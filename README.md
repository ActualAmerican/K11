// GDD v0.50 — Psychological Horror Deduction Roguelite
(Lock-in Draft + PROFILE + Case Folder + NOISE (Triggers List) + EXPAND +
PROCEDURAL ENGINE + UI BLOCKING NOTES + REQUISITION + DIFFICULTY
SCALING + DISTORTION + FAIRNESS GUARDRAILS + SCORE/ARCHIVE + OFF
RAMP: EXIT PROTOCOL + META: COMMENDATIONS/FILES + ESCAPE CREDITS +
OVERSIGHT VOICE + REVOLVER/DANGER CLARIFIED + INTER-ENCOUNTER FLOW

//- PRESSURE CLOCK)
Tagline: “Their lives are in your hand.”
Core fantasy: You’re forced into a rigged, morally corrupt interrogation game where truth, fear,
and survival collide.
⸻

//1. High Concept (Locked)
A run-based psychological horror deduction game where each suspect is a procedurally
generated composite identity (silhouette + case folder + dossier + profile). The player must
choose CLEAR (innocent) vs CONVICT (guilty) — with an optional SCAPEGOAT — using
information earned through gameplay, under escalating lethal stakes represented by one shared
revolver.
The revolver is the emotional anchor: the same gun can kill you or them depending on your
choice.
⸻
//2. Pillars (Locked)
• Psychological horror (systemic): fear comes from pressure, distortion, and complicity (not
jump scares).
• Deduction (fair + auditable): players can “show their work” via evidence logs, not vibes.
• Suspense (push-your-luck): digging for truth increases lethal risk.
• Morality + strategy: survival can come at the cost of innocent lives and lasting corruption.
• Set-and-forget friendly: 2D UI-first; minimal authored content.
⸻
//3. Presentation (Locked)
• Format: 2D, UI-heavy interrogation screen.
• Suspects: limited silhouette variants + procedurally generated case labels/text (no stereotypes;
neutral templates).
• Tone: oppressive, ritualized verdict moments; “you are inside a messed-up game.”
• Visual depth target (direction): 2.5D lighting/shading on 2D assets; no requirement to go full
3D.
• Era direction (locked): late-90s / early-00s institutional vibe (CRT, paper case folder, desk
props).
Investigate Attempt battle presentation (Locked direction):
• Battle is a visualized interrogation duel, not a literal fantasy fight.
• Detective avatar on left, suspect-psyche manifestations on right.
• Stage-like composition inspired by Paper Mario (flat readable silhouettes, crisp staging,
minimal camera movement).
⸻
//4. Run Structure (Clarified flow)
4.1 Run definition (Not fully locked)
• A run is a chain of suspect encounters until player death OR Escape via EXIT PROTOCOL.
• Death ends the run immediately.
• Escape ends the run with an “escaped” outcome and rewards (EC, score bonuses).
4.2 Encounter cycle (Locked structure)
Each suspect encounter repeats:

//1) Choose a Focus (Tab)
//2) Perform an Investigate Attempt (partially specified; see Section 20)
//3) Resolve:
• Win → gain a Fact
• Lose → increase Danger (and often create Noise/Distortion consequences depending on
trigger)
//4) Choose a Verdict when you commit (CLEAR / CONVICT / SCAPEGOAT)
4.3 Inter-Encounter Break (Locked structure)
After a verdict resolves and before the next suspect loads, the game enters an inter-encounter
break with three steps, always in this order:
A) Case Handling Step (locked, simple, fast)
• A short “desk handling” moment to stow the current case folder and pull the next one.
• Implemented as a small timed input/QTE or discrete action (press/hold at the right time).
• Failure creates Noise (and potentially camera attention); success keeps things quiet.
• This is a system noise source, not just flavor.
B) Requisition (REQ) step (locked)
• Buy 0+ items from the desk drawer list.
• No forced spending, no cap.
C) Optional: Initiate EXIT PROTOCOL (locked)
• Player may choose to attempt escape here (between suspects only).
⸻

//5. Core Gameplay Loop (Locked spine)
(See 4.2. The encounter cycle is the locked spine.)
⸻
//6. Tabs + Evidence Logs (Locked — 5)
Tabs:
• ALIBI
• TIMELINE
• MOTIVE
• CAPABILITY (Means + Opportunity merged)
• PROFILE
(Optional later: ALL/SUMMARY)
Behavior (Locked)
• Clicking a tab sets Focus.
• The dossier/case panel displays that tab’s Evidence Log.
• Player does not need to memorize facts; the UI is the audit trail.
Category Exhaustion (Locked)
• If a tab has no remaining facts to discover, it greys out for info gain.
• Player must pivot to another tab.
⸻
//7. Facts (Two fact families)
7.1 Fact format (Locked)
A Fact is a 1-line evidence item filed under a tab, displayed with:
• Reliability: Solid / Shaky / Corrupted
• Conflict marker (  
 ): contradicts a known fact
7.2 Two families (Locked)
• Case Facts: ALIBI / TIMELINE / MOTIVE / CAPABILITY
• Profile Facts: PROFILE (interrogation dynamics only; never direct guilt signal)
7.3 Investigate targeting (Locked)
• Player selects a tab first; any info gained is pulled from that tab’s pool.
⸻
//8. Verdict System (Locked concept + SCAPEGOAT clarified)
Verdicts
• CLEAR (declare innocent)
• CONVICT (declare guilty)
• SCAPEGOAT / CLOSE CASE (optional but strongly desired)
Outcomes (Locked)
• Correct CLEAR/CONVICT → proceed
• Wrong CLEAR/CONVICT → player death (run ends)
• SCAPEGOAT → survive encounter but incur Corruption penalties
Verdict input rules (Locked)
• Verdict buttons are single-click and final.
• Buttons highlight on hover.
• No do-overs.
• Player may open/close the Case Folder and review logs freely before clicking.
SCAPEGOAT clarifications (Locked)
• SCAPEGOAT always resolves the encounter immediately (no further investigation).
• SCAPEGOAT always counts as a “dirty action” for Corruption and interacts harshly with
camera “hot” oversight.
• Directional coupling (locked direction, tuning later):
• tends to worsen future signal quality (more Corrupted facts)
• may trigger harsher Oversight scrutiny that makes REQ outcomes worse (examples: reduced
REQ gain, higher REQ prices, fewer “clean” tools offered)
• Guardrail (locked): SCAPEGOAT must never be the best long-run strategy for EC/score/REQ.
⸻
//9. Single Shared Revolver + Danger (Fully specified)
9.1 The revolver (Locked)
• One shared revolver with 6 chambers.
• UI shows:
• Live rounds (e.g., 2/6)
• Remaining chambers in current cylinder
• Optional odds display
9.2 When it fires (Locked)
• Fires only on verdict resolution and during EXIT PROTOCOL’s single “kill-switch.”
• No firing during investigation attempts.
9.3 Who gets shot (Locked)
If verdict is correct: nothing happens (no shot).
If verdict is wrong / or scapegoat: the gun is pointed and may fire:
• CLEAR: if wrong → fires at you
• CONVICT: if wrong → fires at suspect
• SCAPEGOAT: fires at suspect regardless of innocence
9.4 Chamber consumption + cylinder cycling (Locked)
• Every time the revolver fires, one chamber is consumed.
• When all 6 chambers have been consumed, the cylinder resets (ritual reload/spin) automatically
before the next time it’s needed.
• This allows runs longer than 6 suspects while keeping the 6-chamber tension loop.
9.5 Danger definition (Locked)
Danger is defined as:
• Danger Rating (0–6): run-facing risk meter representing how “loaded” the next pulls are likely
to be.
• Current Cylinder State: the live/empty distribution in the active 6-chamber cycle.
Interpretation:
• Danger Rating = “supply of bullets the system is willing to put into your life.”
• The cylinder = current tactical reality.
9.6 How Danger changes (Locked structure; values tunable)
• On Lose (investigation resolution): Danger Rating increases (usually +1, capped at 6).
• On dirty actions (notably SCAPEGOAT, certain REQ dirty emergency tools): Danger Rating
may increase and/or cylinder worsens immediately (direction locked).
• Clean play does not automatically reduce Danger unless you explicitly buy/trigger a system
effect (no free forgiveness loop).
• Exception allowed later: rare, expensive REQ item may reduce Danger slightly.
9.7 How the cylinder gets live rounds (Locked)
• At the start of each fresh 6-chamber cycle, the game loads the cylinder with a number of live
rounds equal to the current Danger Rating, randomly distributed.
• If Danger Rating increases mid-cycle and there are still unconsumed chambers:
• immediately add a live round into one currently-empty unconsumed chamber (if any exist)
• if none exist, apply the increase to the next cycle
9.8 Fairness rule: revolver UI never lies (Locked)
• UI must always be truthful about counts.
• Distortion may add visual instability (flicker/glitch), but displayed numbers/odds remain
accurate after the effect.
9.9 Empty-click consequence (Locked)
If the revolver is pointed at the suspect and the fired chamber is empty:
• suspect screams and flees the room (immediate encounter break)
• large Noise spike (larger than a normal gunshot)
• Oversight/camera forced “hot” during fallout (intent locked)
• Distortion increases (small but guaranteed)
• Corruption increases (attempted lethal/rigged action even if failed)
Guardrail: not a “safe win” and blocks Silent Exit eligibility via Noise/camera gating.
If the revolver is pointed at the player and clicks empty (wrong CLEAR):
• medium Noise spike + small Distortion increase
9.10 Morality consequence (Locked)
• If the suspect dies (guilty or innocent), player morality is negatively affected (Corruption
impact; scale tunable).
• If the player dies, the run ends immediately.
⸻
//10. Morality + Corruption (Locked direction)
Corruption Meter (Locked)
Run-long meter rising from morally compromised actions (especially SCAPEGOAT, plus
lethal/attempted-lethal suspect outcomes).
Consequences (concept locked, tuning not locked)
• More Corrupted facts
• Worse risk economy (barrel disadvantage)
• Worse end-of-run outcomes / score penalties
Camera tension coupling (Locked direction)
• Scapegoating “on camera” is punished harder.
Note (Locked): No “Efficiency” stat.
Operational pressure is handled by Noise triggers, Oversight hot state, REQ constraints, and
Extraction pressure. Distortion remains the information-integrity system.
⸻
//11. Emergent Cop Styles (Locked direction)
• Good Cop: truth-first, minimal harm, low corruption
• Bad Cop: pressure-first, faster extraction, higher distortion risk
• Corrupt Cop: survival-first, scapegoats, long-term degradation
⸻
//12. “Alive Suspect” (Locked direction, constrained)
Suspects feel alive through:
• Stress / Composure / HR indicators
• Communication changes (cooperative vs evasive)
Constraints:
• Behavioral cues must not replace fair deduction.
• They modify signal quality, not truth.
UI note:
• Add Resistance as an additional “read” signal.
• Not all reads are bars.
NEW (Locked): suspect can be a Noise source
• High Stress / low Composure can create audible cues (panting, chair creak, muttering) that are
system-coupled and can raise Noise under certain triggers.
⸻
//13. PROFILE Tab — Deep Suspect State (Locked)
Hidden axes:

//1) Composure
//2) Stress Reactivity
//3) Defensiveness
//4) Cognitive Load
//5) Narrative Control
//6) Volatility
Fairness guardrail:
• Affects attempt success / reliability / backlash odds
• Does not change guilt probability
⸻

//14. PROFILE Conflict System (Locked — procedural)
Conflict marker (  
 ) appears when Profile Facts are mutually incompatible per rules A–D.
Solid overrides Shaky ordering; Corrupted can conflict with anything.
Axis families (Locked):
• Stability family: Composure, Volatility
• Stress family: Stress Reactivity, Volatility
• Cognition family: Cognitive Load, Narrative Control
• Resistance family: Defensiveness, Narrative Control
Compatibility rules (Locked):
• Rule A — Stability contradiction
• “Composure: High” conflicts with “Volatility: High”
• “Composure: Low” conflicts with “Volatility: Low”
• Rule B — Cognition contradiction
• “Narrative Control: Strong” conflicts with “Cognitive Load: Severe”
• “Narrative Control: Fragmented” conflicts with “Cognitive Load: Low”
• Rule C — Resistance contradiction
• “Defensiveness: Low” conflicts with “Narrative Control: Highly guarded/rehearsed”
• “Defensiveness: High” conflicts with “Narrative Control: openly cooperative”
• Rule D — Stress contradiction
• “Stress Reactivity: Low” conflicts with “Volatility: High”
• “Stress Reactivity: High” conflicts with “Volatility: Low”
⸻
//15. Case Folder Overlay (Locked)
Two modes:
• Compact / Closed: summary view (Case Brief + focused tab log)
• Full-screen Case Folder:
• Left page: Charge Sheet / Case Brief
• Right page: Evidence Logs by tab
Exit: close or Esc.
Folder is a reference/check tool; core loop stays in compact mode.
⸻
//16. Noise / Impending Doom System (Updated — stall-drip removed, triggers locked)
16.1 Noise meter (Locked)
• Per-suspect Noise meter (0–100).
• Noise rises from triggers (see 16.4).
• Success does not reduce Noise.
16.2 Bands (Locked)

//1) 0–39 Quiet
//2) 40–69 Alert
//3) 70–89 Danger
//4) 90–100 Breach
At 100: Breach Check:
• Fail → death (run ends)
• Succeed → Noise drops (e.g., to 80) but Distortion increases
16.3 Decay + reset (Locked)
Decay:
• Quiet window: 3s without trigger → decay begins
• Decay: -6 Noise/sec until 0
Reset:
• Noise resets to 0 only when the next suspect fully loads (start of the next encounter).
• Inter-encounter mistakes (case handling) carry into the next suspect as starting Noise.
16.4 Noise creators (System-coupled list — Locked)
A) Investigation outcome noises
• Attempt Failure: monitor error beep / paper stamp slam / desk mic crackle → Noise spike
• Attempt Backlash (if applicable later): forced loud event → Noise spike
B) Inactivity triggers (Locked)
No constant drip. Discrete escalating events:
//5) Phone ring (first warning) → small Noise
//6) Phone ring + harsher tone / second ring → larger Noise
7//) Overhead speaker click / oversight ping → larger Noise
C) Suspect-driven noise (Locked)
• High Stress / low Composure → panting / coughing / chair scrape / restrained outburst
• Tied to state thresholds, not random flavor.
D) Camera/oversight device stress (Locked)
• Prolonged camera interference escalates: buzz → smoke → fire alarm
• Fire alarm = large Noise spike + may increase Distortion.
E) Verdict/revolver spike (Locked)
• Any revolver firing is a Noise event (degree tunable).
• Empty click vs suspect has large Noise via scream/flee (9.9).
F) Inter-encounter case handling step (Locked)
• Failure creates Noise before next suspect starts.
G) Dirty actions (Locked direction)
• SCAPEGOAT and certain dirty emergency tools can spike Noise and interact with camera hot.
⸻

//17. Screen Layout + Scaling (Locked: EXPAND) + UI state practicality
17.1 Expand rule (Locked)
• Critical UI authored for a 16:9 safe stage.
• Extra aspect ratio space reveals more environment/desk dressing only.
• Cannot reflow critical elements.
17.2 “Everything can’t be on screen” solution (Locked approach)
No 3D traversal required. Use stateful overlays:
• Compact interrogation state = default
• Full-screen Case Folder overlay
• Drawer overlay for REQ purchases (between suspects)
• Camera/oversight panel as a small pop-out overlay (when relevant)
• Extraction overlay replaces most interrogation UI and foregrounds Pursuit + kill-switch + steps
Optional visual depth (direction only):
• subtle parallax/pan in background layers during Extraction to imply movement toward a
door/vent without changing core UI layout
⸻
//18. Procedural Case Engine (Locked foundation)
(Unchanged from your v0.50 draft; retained as-is.)
18.1–18.9 remain exactly as you wrote (goal, seeding, charge sheet, truth graph, tab pools,
reliability, anti-repeat, fairness guardrails 1–8, minimal content libraries).
⸻
//19. Psyche Matrix (Clarified role; partially locked)
What it is: a tactics selector describing the interrogation approach used during Investigate
Attempts.
It does not change guilt probability and does not contain “tell me who did it” stats.
Locked direction:
• Psyche Matrix represents the suspect’s reactive behavior + tempo shaping, not “personality
flavor.”
• Suspect PROFILE axes modulate:
• enemy roster composition
• enemy move tendencies
• turn tempo (Speed/initiative)
• which approaches are safer or riskier
The three approach modes (Locked interface; content tunable):
• EXTRACT: high commitment to pulling usable info → can win a Fact (Section 20).
• CONTAIN: stabilize / reduce threat output → no Fact, but creates a short-term advantage
token.
• DISENGAGE: attempt to bail out with minimal additional risk → no Fact, small penalty.
Stress amplification (Locked):
• Stress does not “change truth.”
• Stress amplifies how punishing/fast the suspect’s reactive psyche becomes.
⸻
//20. Investigate Attempt System (Updated — now partially specified)
20.1 Purpose (Locked)
Investigate Attempts are repeatable “duels” that convert pressure into information:
• Win → gain a Fact from the focused tab pool
• Lose → increase Danger + trigger Noise/Distortion consequences
20.2 Format (Locked direction)
• Turn-based, RPG-inspired interrogation duel (Expedition-style initiative nuance + Paper Mario
staging + Omori tone).
• You are not farming XP; you are extracting usable information under escalating consequences.
• Enemy roster size is flexible: 1–3 enemies (sometimes 1–2 elites) depending on suspect psyche

- stress.
  20.3 Move families (Locked)
  Player move families are:
  • Attack
  • Status
  • Item (includes REQ-driven tools when applicable)
  20.4 No fixed round cap (Locked)
  • There is no hard “max rounds per attempt.”
  20.5 Pressure Clock — Oversight Patience (LOCKED solution)
  To prevent infinite safe fishing without a gamey “max rounds” limit:
  Oversight Patience (0–100) exists per Investigate Attempt.
  • Each player turn increases Patience.
  • Patience does not decrease during the attempt.
  • At 100, the attempt auto-fails (counts as a Lose).
  Escalation beats (locked structure; values tunable):
  • ~40: Phone ring #1 → small Noise spike, pressure intensifies
  • ~70: Phone ring #2 → medium Noise spike, harsher escalation
  • ~90: Overhead ping / oversight click → large Noise spike, Oversight forced hot
  • 100: “Compliance Timeout” → immediate Lose (+ normal Lose consequences)
  Anti-abuse direction (locked):
  • Disengage/Abort actions (if present later) increase Patience sharply to prevent spam.
  • Repeating the same action may accelerate Patience (optional tuning knob).
  20.6 Battle math contract (LOCKED FRAMEWORK, values tunable)
  A) The three core gauges (Locked)

//1. Leverage (0–100)
• Win condition for EXTRACT: Leverage ≥ 100
//2. Blowback (0–100)
• Loss condition for the attempt: Blowback ≥ 100
//3. Enemy Pressure (per enemy: 0–100)
• Not HP. Represents that enemy’s threat output.
• Pressure controls how much Blowback an enemy can generate and/or how often it acts.
• Pressure can be reduced via Attacks/Statuses (containment).
B) Initiative timeline (Expedition-style) (Locked)
Not strict “I go / you go.” Uses a speed timeline:
• Each unit gains ATB over time: ATB += Speed
• When ATB ≥ 100, that unit acts; then ATB -= 100
Speed sources:
• Player speed: base + REQ buffs + status effects
• Enemy speed: base + psyche matrix modifiers + stress band modifiers
Stress band direction (locked; coefficients tunable):
• Low stress: slower/steadier
• High stress: faster/more punishing
C) Tell Window (Locked)
Enemies have hidden Tell Thresholds.
• Certain actions build Tell Exposure on a target.
• When Tell triggers, your next EXTRACT-type action gains a Tell Bonus:
• bonus Leverage and/or small Blowback mitigation (choose standard in implementation)
This is how “interrogation openings” exist without “HP dumping.”
D) Execution tiers (Paper Mario input) (Locked)
Actions resolve into execution tiers (values tunable):
• Clean: stronger effect
• Normal: baseline
• Sloppy: reduced effect + adds Blowback
• Whiff: no effect + adds more Blowback
Locked rule:
• Mistakes always create risk (Blowback), not just “miss damage.”
E) Psyche → battle behavior mapping (Locked direction)
PROFILE axes and stress influence the duel via:
• enemy roster archetype selection
• resistances/vulnerabilities (status effectiveness)
• tempo (Speed/ATB behavior)
• backlash style (how Blowback spikes)
Locked guardrail:
• None of this modifies guilt truth; it only modifies extraction difficulty and risk profile.
20.7 Attempt outcomes (Locked interface)
At end of an attempt:
EXTRACT win
• Grants 1 Fact from the currently selected Focus tab pool.
• Reliability skew is influenced by how messy the attempt was:
• higher accumulated Blowback → higher chance Shaky/Corrupted (tunable)
CONTAIN win
• Grants no Fact
• Grants a Contain Advantage token (next attempt begins safer in a small, readable way)
DISENGAGE
• No Fact
• Small penalty (noise / stress / oversight direction; tunable)
LOSS
• Counts as a Lose:
• Danger increases (per rules)
• Noise spike (trigger rules)
• Distortion may increase (depending on band/trigger)
⸻

//21) Requisition System (Locked foundation + clarified)
(Retains your v0.50 content; plus one locked coupling note.)
Battle coupling direction (Locked direction, not tuned):
• REQ can influence Investigate Attempts like “pictos” — small buffs/privileges (e.g., always go
first, +speed, reduce Patience gain, stabilize Blowback, improve Tell bonuses).
⸻
//22) Difficulty Scaling Model (Locked)
(As written in your v0.50.)
⸻
//23) Distortion System (Locked)
(As written in your v0.50.)
⸻
//24) Score + Archive (Locked MVP stance)
(As written in your v0.50.)
⸻
//25) Off-Ramp System — EXIT PROTOCOL (Locked)
(As written in your v0.50.)
⸻
//26) Meta Progression — Commendations + Archive Files (Locked MVP stance)
(As written in your v0.50.)
⸻
//27) Escape Credits (EC) — Deep-Run Incentive (Locked)
(As written in your v0.50.)
⸻
//28) Oversight Presence — Systemic Character (Locked direction)
(As written in your v0.50.)
⸻
//29) UI Requirements (Locked set + layout intent)
(As written in your v0.50, plus battle staging already noted in Presentation/20.2.)
⸻
//30) MVP Scope (Updated checklist)
Your MVP list stands, with one explicit addendum already included:
• Investigate Attempt pressure control: Oversight Patience Pressure Clock (no hard max rounds)
• Investigate Attempt system now includes the locked math contract (gauges + speed timeline +
tell windows + execution tiers + outcomes)
