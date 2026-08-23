# Preview Lifecycle and Safety Boundary

NFR treats Photo Mode as a temporary rendering session. Equipment-EX's selected outfit is the V
preview baseline; manually selected clothing items are slot-specific overrides. **Clear** suppresses
the rendered clothing composition while retaining the outfit identity, and **Reset** reconstructs
the selected baseline. These actions use preview-puppet APIs and never mutate player inventory,
actual equipment, the persistent active outfit, or saved outfits.

NFR discards expansion, scroll, search, selection, and preview state when Photo Mode ends. On the
next entry it reconciles from the newly initialized native controls rather than restoring a prior
session.

Experimental NPC Clothing retains independent item and appearance-component choices only while the
current Photo Mode session exists. Native NPC switching can reconstruct equipment after its selector
callback; NFR therefore waits for activation, removes retained preview instances, and re-adds them
after a separate transaction interval. Native NPC Appearance changes invalidate that NPC's prior
component and item state.
