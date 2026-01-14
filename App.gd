
extends Control
class_name App

const SETTINGS_FILE := "user://settings.cfg"

# Screens (already instanced under App/Screens)
var _screens_root: Node
var _title_screen: Control
var _main_menu: Control
var _settings_screen: Control
var _vault_screen: Control

# Host for on-demand game scene instances (App/GameHost)
var _game_host: Node

# UI Buttons (found by name via find_child)
var _title_start_button: Button
var _menu_begin_run_button: Button
var _menu_settings_button: Button
var _menu_vault_button: Button
var _settings_back_button: Button
var _vault_back_button: Button

# Optional Settings UI controls (safe if missing)
var _settings_master_slider: Range
var _settings_fullscreen_toggle: BaseButton

# On-demand game instance
@export var game_shell_scene: PackedScene
var _game_instance: Node = null

# Current router state
var _active: String = "title"

# Settings state (Phase 0: keep it tiny + debuggable)
var _master_linear: float = 1.0 # 0..1
var _fullscreen: bool = false


func _ready() -> void:
	print("[Router] boot")

	# Node lookups (these paths MUST match App.tscn)
	_screens_root = get_node_or_null("Screens")
	_title_screen = get_node_or_null("Screens/TitleScreen")
	_main_menu = get_node_or_null("Screens/MainMenu")
	_settings_screen = get_node_or_null("Screens/SettingsScreen")
	_vault_screen = get_node_or_null("Screens/VaultScreen")
	_game_host = get_node_or_null("GameHost")

	# Hard failures early so button presses don't silently do nothing.
	if _screens_root == null:
		push_error("[Router] missing node: Screens")
		return
	if _title_screen == null:
		push_error("[Router] missing node: Screens/TitleScreen")
		return
	if _main_menu == null:
		push_error("[Router] missing node: Screens/MainMenu")
		return
	if _settings_screen == null:
		push_error("[Router] missing node: Screens/SettingsScreen")
		return
	if _vault_screen == null:
		push_error("[Router] missing node: Screens/VaultScreen")
		return
	if _game_host == null:
		push_error("[Router] missing node: GameHost")
		return

	# Wire buttons (by NAME, not by fragile node paths)
	_title_start_button = _find_button(_title_screen, "StartButton", "TitleScreen")
	_menu_begin_run_button = _find_button(_main_menu, "BeginRunButton", "MainMenu")
	_menu_settings_button = _find_button(_main_menu, "SettingsButton", "MainMenu")
	_menu_vault_button = _find_button(_main_menu, "VaultButton", "MainMenu")
	_settings_back_button = _find_button(_settings_screen, "BackButton", "SettingsScreen")
	_vault_back_button = _find_button(_vault_screen, "BackButton", "VaultScreen")

	if _title_start_button:
		_connect_once(_title_start_button, _on_title_start_pressed)
	if _menu_begin_run_button:
		_connect_once(_menu_begin_run_button, _on_menu_begin_run_pressed)
	if _menu_settings_button:
		_connect_once(_menu_settings_button, _on_menu_settings_pressed)
	if _menu_vault_button:
		_connect_once(_menu_vault_button, _on_menu_vault_pressed)
	if _settings_back_button:
		_connect_once(_settings_back_button, _on_settings_back_pressed)
	if _vault_back_button:
		_connect_once(_vault_back_button, _on_vault_back_pressed)

	# Optional settings controls (only hook if they exist)
	_settings_master_slider = _find_range(_settings_screen, "MasterSlider", "SettingsScreen")
	_settings_fullscreen_toggle = _find_toggle(_settings_screen, "FullscreenToggle", "SettingsScreen")

	if _settings_master_slider:
		if not _settings_master_slider.value_changed.is_connected(_on_master_slider_changed):
			_settings_master_slider.value_changed.connect(_on_master_slider_changed)

	if _settings_fullscreen_toggle:
		if not _settings_fullscreen_toggle.toggled.is_connected(_on_fullscreen_toggled):
			_settings_fullscreen_toggle.toggled.connect(_on_fullscreen_toggled)

	# Load + apply settings before showing UI
	_load_settings()
	_apply_settings()
	_sync_settings_ui()

	_show("title")


func _unhandled_input(event: InputEvent) -> void:
	# Default Godot action for Esc / Android back.
	if event.is_action_pressed("ui_cancel"):
		match _active:
			"settings":
				print("[Router] ui_cancel -> menu")
				_show("menu")
			"menu":
				print("[Router] ui_cancel -> title")
				_show("title")
			"game":
				print("[Router] ui_cancel -> return_to_menu")
				_return_to_menu()
			"title":
				pass


# ------------------------------------------------------------
# Router transitions
# ------------------------------------------------------------

func _show(target: String) -> void:
	_active = target
	print("[Router] show -> %s" % target)

	var is_title := target == "title"
	var is_menu := target == "menu"
	var is_settings := target == "settings"
	var is_vault := target == "vault"
	var is_game := target == "game"

	# If we are not on the game screen, ensure the game is truly unloaded.
	if not is_game:
		_unload_game()

	_set_screen_active(_title_screen, is_title)
	_set_screen_active(_main_menu, is_menu)
	_set_screen_active(_settings_screen, is_settings)
	_set_screen_active(_vault_screen, is_vault)

	# Game host only matters when game is active.
	_game_host.visible = is_game
	_game_host.process_mode = Node.PROCESS_MODE_INHERIT if is_game else Node.PROCESS_MODE_DISABLED


func _set_screen_active(screen: Control, active: bool) -> void:
	screen.visible = active
	screen.process_mode = Node.PROCESS_MODE_INHERIT if active else Node.PROCESS_MODE_DISABLED
	# Prevent hidden UI from intercepting input.
	screen.mouse_filter = Control.MOUSE_FILTER_STOP if active else Control.MOUSE_FILTER_IGNORE


func _on_title_start_pressed() -> void:
	_show("menu")


func _on_menu_begin_run_pressed() -> void:
	print("[Router] start_game")
	_start_game()


func _on_menu_settings_pressed() -> void:
	_sync_settings_ui()
	_show("settings")


func _on_menu_vault_pressed() -> void:
	_show("vault")


func _on_settings_back_pressed() -> void:
	_show("menu")


func _on_vault_back_pressed() -> void:
	_show("menu")


func _start_game() -> void:
	_load_game()
	_show("game")


# ------------------------------------------------------------
# Game loading/unloading (on demand)
# ------------------------------------------------------------

func _load_game() -> void:
	if _game_instance != null:
		# Guard against double-instancing.
		print("[Router] game already loaded")
		return

	if game_shell_scene == null:
		push_error("[Router] game_shell_scene is not set (App.gd export).")
		return

	_game_instance = game_shell_scene.instantiate()
	_game_host.add_child(_game_instance)

	# Wire the "Back to Menu" button inside GameShell if present.
	var back_btn := _find_button(_game_instance, "BackButton", "GameShell")
	if back_btn:
		_connect_once(back_btn, _on_gameshell_back_pressed)


func _unload_game() -> void:
	if _game_instance == null:
		return

	if not is_instance_valid(_game_instance):
		_game_instance = null
		return

	_game_instance.queue_free()
	_game_instance = null


func _on_gameshell_back_pressed() -> void:
	print("[Router] return_to_menu")
	_return_to_menu()


func _return_to_menu() -> void:
	_unload_game()
	_show("menu")


# ------------------------------------------------------------
# Settings (Phase 0 stub: master volume + fullscreen)
# ------------------------------------------------------------

func _load_settings() -> void:
	var cfg := ConfigFile.new()
	var err := cfg.load(SETTINGS_FILE)
	if err != OK:
		print("[Settings] no settings file yet (%s), using defaults" % SETTINGS_FILE)
		return

	_master_linear = float(cfg.get_value("audio", "master_linear", 1.0))
	_fullscreen = bool(cfg.get_value("display", "fullscreen", false))
	_master_linear = clamp(_master_linear, 0.0, 1.0)


func _save_settings() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("audio", "master_linear", _master_linear)
	cfg.set_value("display", "fullscreen", _fullscreen)
	var err := cfg.save(SETTINGS_FILE)
	if err != OK:
		push_warning("[Settings] failed saving settings (%s): %s" % [SETTINGS_FILE, err])


func _apply_settings() -> void:
	_set_bus_linear("Master", _master_linear)

	if _fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _sync_settings_ui() -> void:
	if _settings_master_slider:
		_settings_master_slider.value = round(_master_linear * 100.0)
	if _settings_fullscreen_toggle:
		_settings_fullscreen_toggle.button_pressed = _fullscreen


func _on_master_slider_changed(value: float) -> void:
	_master_linear = clamp(value / 100.0, 0.0, 1.0)
	print("[Settings] master_linear = %.2f" % _master_linear)
	_apply_settings()
	_save_settings()


func _on_fullscreen_toggled(pressed: bool) -> void:
	_fullscreen = pressed
	print("[Settings] fullscreen = %s" % str(_fullscreen))
	_apply_settings()
	_save_settings()


func _set_bus_linear(bus_name: String, linear: float) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx == -1:
		push_warning("[Settings] missing audio bus '%s' (Project > Audio > Buses)." % bus_name)
		return

	linear = clamp(linear, 0.0, 1.0)
	var db := linear_to_db(max(linear, 0.0001))
	AudioServer.set_bus_volume_db(idx, db)


# ------------------------------------------------------------
# Helpers
# ------------------------------------------------------------

func _find_button(root: Node, button_name: String, screen_label: String) -> Button:
	var n: Node = root.find_child(button_name, true, false)
	if n == null:
		push_error("[Router] missing button '%s' inside %s" % [button_name, screen_label])
		return null
	if not (n is Button):
		push_error("[Router] node '%s' inside %s is not a Button" % [button_name, screen_label])
		return null
	return n as Button


func _find_range(root: Node, node_name: String, screen_label: String) -> Range:
	var n: Node = root.find_child(node_name, true, false)
	if n == null:
		return null
	if not (n is Range):
		push_warning("[Router] node '%s' inside %s is not a Range (HSlider/VSlider/etc)" % [node_name, screen_label])
		return null
	return n as Range


func _find_toggle(root: Node, node_name: String, screen_label: String) -> BaseButton:
	var n: Node = root.find_child(node_name, true, false)
	if n == null:
		return null
	if not (n is BaseButton):
		push_warning("[Router] node '%s' inside %s is not a BaseButton (CheckBox/CheckButton/Button)" % [node_name, screen_label])
		return null
	return n as BaseButton


func _connect_once(btn: Button, handler: Callable) -> void:
	if btn == null:
		return
	if btn.pressed.is_connected(handler):
		return
	btn.pressed.connect(handler)
