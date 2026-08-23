# Neon Fitting Room — In-Game Smoke Test

Record the game and dependency versions before testing. The validated baseline is documented in
[dependency-matrix.md](dependency-matrix.md).

## V page

1. Enter Photo Mode, open V's Character page, and confirm all NFR controls start collapsed.
2. Expand Outfit; verify cards, search, tooltips, optional icon collages, selection, native-arrow
   synchronization, and outer scrolling.
3. Expand Clothing; verify alphabetical icon cards, parent search, slot-arrow cycling, `NONE`,
   selected-card toggling, replacement, and synchronized slot summaries.
4. Select another outfit before and after Clothing is materialized; verify its slot state is current.
5. Use **Clear** and **Reset** from Current Equipped, No Outfit, and a saved outfit.
6. Expand Category, Pose, and Facial Expression; verify search, native synchronization, dependent
   Pose rebuilding, accordion behavior, and anchored expansion.
7. Scroll over rows, cards, and gaps; verify the controls scroll and the camera zooms only outside
   the controls viewport.
8. Repeat representative checks at six, eight, nine, and ten cards per row.

## NPC page

1. Select an NPC and verify Appearance, Facial Expression, Category, and Pose card browsers mount
   only after an active NPC exists.
2. Switch among retained NPCs; verify each browser follows the active NPC and stale panels disappear.
3. Enable experimental NPC Clothing and verify unsupported zero-slot NPCs hide the complete control.
   Without Mod Settings, run the documented CET enable command before entering Photo Mode and verify
   the feature returns to disabled after restarting the game.
4. On two supported NPCs, select different clothing and explicit `NONE` states, switch repeatedly,
   and verify each NPC reconstructs its independent session state.
5. Toggle individual and `NONE` cards in the NPC appearance-component browser; verify visibility,
   card accents, and counts remain independent across NPC switching.
6. Change native Appearance; verify old preview items and component choices are invalidated.
7. Verify NPC Clothing search, Clear, scrolling, gap input, and accordion behavior.

## Lifecycle

1. Exit and re-enter Photo Mode; verify no expansion, search, selection, NPC target, or preview state
   leaks into the new session.
2. Disable and re-enable optional settings between sessions; verify the rebuilt UI reflects them.
3. Exit the game normally and inspect the log for NFR errors.
