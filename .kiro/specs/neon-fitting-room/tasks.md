# Neon Fitting Room — Implementation Tasks

Only first-release work carries checkboxes. Deferred and removed features are recorded as scope
decisions, not as actionable backlog items.

## Completed foundation

- [x] Establish the FABRIC-style project, dependency baseline, build flavors, diagnostic logging,
  guarded development installation, release packaging, and source-contract checks.
- [x] Validate the supported Equipment-EX outfit and puppet-preview APIs and the native Photo Mode
  Outfit selection seam.
- [x] Implement the transient outfit catalog and preview-session baseline/override model.
- [x] Establish an NFR-owned compiled Ink surface and reusable owned/native expandable-card
  controls without copying the native Photo Mode root or adding nested scroll controllers.

## V1 — Core V fitting room

- [x] Retain the detached native Outfit selector as Equipment-EX's state adapter and provide one
  NFR-owned row, input layer, and synchronized card grid using the native outer scrollbar.
- [x] Add one localized Cards Per Row Interface setting, defaulting to eight with a six-to-ten range,
  and derive centered card scale, spacing, hit bounds, search layout, and row height through the
  shared browser geometry used by every NFR card control.
- [x] Runtime-validate all V and NPC card browsers at six, eight, nine, and ten columns, including
  icon/label readability, search reflow, pointer hit coverage, accordion anchoring, and scrolling.
- [x] Provide synchronized expandable Category, Category-dependent Pose, and Facial Expression card
  browsers while preserving native selection authority.
- [x] Provide the expandable Clothing parent and lazy, alphabetized, icon-bearing slot controls with
  arrow cycling, card selection, `NONE`, active-item summaries, and retained-baseline replay when
  Outfit selection precedes lazy catalog construction.
- [x] Preserve V-page wheel ownership over interactive rows and cards while retaining camera zoom
  outside the controls viewport.
- [x] Consolidate V clothing card and arrow mutations into one authoritative tracked-`ItemID`
  clear/toggle/replace transition without changing Equipment-EX's native Outfit authority.
- [x] Runtime-validate the consolidated V slot transition for arrow selection, card selection,
  selected-card toggle, `NONE`, item replacement, and outfit resynchronization.
- [x] Validate repeated Photo Mode entry, exit, page reconstruction, and clean teardown without
  persisting any NFR state between sessions.

## V1 — Outfit presentation and search

- [x] Add a compact icon collage to every saved-outfit card using populated Head, Torso, Back,
  Waist, Legs, and Feet slots, retaining all significant sub-slots without a `+N` summary.
- [x] Gate outfit collages and the No Outfit utility icon behind a localized, enabled-by-default
  Interface Mod Settings option, restoring centered text-only cards while disabled.
- [x] Validate missing-icon fallback presentation on saved-outfit, Current Equipped Outfit, and No
  Outfit cards; composition, significant-region filtering, labels, density scaling, selection, and
  search have been runtime-validated.
- [x] Add saved-outfit tooltips listing their included item names.
- [x] Add expanded-header outfit search with debounce, name matching, hidden utility cards during
  search, empty-grid behavior, and preserved outer-list position.

## V1 — Clothing search and tooltips

- [x] Add one reusable localized card-search binding to Outfit and V/NPC native-option browsers,
  plus one parent-level V/NPC Clothing search across every represented slot and the NPC Clothing
  appearance-component cards, with no redundant inner NPC search field and with
  debounced label matching, utility-card hiding, focus release, collapse reset, selector-aligned
  placement, and predictive scroll preservation.
- [x] Runtime-validate search filtering, empty results, collapse reset, focus release, and anchored
  scrolling across Outfit, V/NPC native options, NPC Appearance, and parent-level V/NPC Clothing.
- [x] Add game-styled item tooltips with full item names and available details to icon-only clothing
  cards, reusing `UIInventoryItem` data where safe and retaining the item-label fallback. Gate all
  card tooltips behind a localized, enabled-by-default Mod Settings option.
- [x] Validate tooltip edge flipping near each screen boundary; content, wrapping, root-transform
  placement, topmost z-order, and the enabled setting have been runtime-validated for Outfit,
  native-option, V Clothing, and NPC Clothing cards.

## V1 — Clear and Reset

- [x] Add persistent text actions named **Clear** and **Reset** beside the Clothing header.
- [x] Implement Clear as removal of all NFR-managed preview clothing while retaining the outfit
  identity and allowing a subsequent item-only preview.
- [x] Implement Reset as restoration of the selected outfit baseline with synchronized slot labels
  and selected cards.
- [x] Disable Clear when no managed clothing is rendered and Reset when preview equals baseline.
- [x] Validate Clear and Reset specifically from Current Equipped and No Outfit baselines before and
  after lazy Clothing-slot materialization; saved-outfit labels, cards, counts, and disabled states
  have been runtime-validated.

## V1 — NPC native-control cards

- [x] Implement active-NPC Appearance, Facial Expression, Category, and Category-dependent Pose card
  adapters with initial-selection mounting, active-character remounting, stale-host removal, and
  native option authority.
- [x] Runtime-validate initial mounting and repeated switching among all three selected NPC slots,
  including selection identity, dependent Pose rebuilding, geometry, scrolling, and teardown.

## V1 — Experimental NPC clothing

- [x] Implement the NPC Clothing browser with V-matched presentation, effective attachment-slot
  filtering, hidden zero-slot hosts, lazy item cards, `NONE`, and per-NPC session state.
- [x] Implement the NPC multi-select component browser for appearance-owned garment, accessory, and
  hair meshes, including grouped toggles and a browser-wide `NONE` action.
- [x] Add active-NPC Clear to remove only NFR-equipped item previews while preserving appearance
  component visibility and target-specific session state.
- [x] Add a Mod Settings option that is disabled by default, gates the complete NPC Clothing feature,
  and explains unsupported bodies and possible garment clipping.
- [x] Expose and document a non-persistent CET service command for enabling or disabling NPC
  Clothing when Mod Settings is absent, retaining the disabled startup default.
- [x] Synchronize NPC Clothing mutation with native attribute-68 selection through retained-puppet
  display-name matching, and treat attribute-68 disable as the authoritative no-active-NPC teardown
  boundary.
- [x] Reset retained NPC adapters, panels, searches, puppet references, and per-puppet Clothing state
  at `OnShow` so controller reuse cannot leak a prior Photo Mode session into the next one.
- [x] Runtime-validate per-NPC item and explicit-NONE retention across native active-character
  switching and native puppet reconstruction.
- [x] Runtime-validate delayed per-NPC clothing replay after native NPC activation, including
  separated removal/re-addition, different items, and explicit `NONE` state on at least two retained
  NPCs.
- [x] Runtime-validate NPC wheel ownership, scrollbar dragging, gap input, expansion-position
  preservation, and synchronous range refresh.
- [x] Runtime-validate native NPC Appearance changes release preview items and stale component/slot
  references before lazy reconstruction.
- [x] Runtime-validate per-NPC appearance-component visibility retention across repeated active-NPC
  switching, including `NONE`, independent toggles, card accents, counts, and native Appearance
  invalidation.

## V1 — Shared interaction and presentation

- [x] Prevent Photo Mode camera zoom on V when the mouse wheel is used over non-interactive gaps
  within the visible controls region, including space between rows, cards, titles, values, and arrow
  hit surfaces, while preserving camera zoom outside the controls region.
- [x] Runtime-validate the same viewport-owned gap behavior on the NPC page.
- [x] Runtime-validate the two-level accordion: top-level Outfit, Clothing, Category, Pose, and
  Facial Expression peers; and independent nested Clothing-slot peers.
- [x] Verify every expansion keeps its initiating header at the same viewport position on both V
  and NPC pages.

## V1 — Lifecycle, safety, and localization

- [x] Route all currently implemented player-visible controls, settings, states, and diagnostics
  through localizable strings; ship English text and document the translation path. New tooltips
  must use the same boundary when their presentation work is implemented.

## V1 — Validation and release

- [x] Remove dormant high-volume probes, experimental selectors, and developer archive-index tooling
  from the first-release source and package.
- [x] Complete the in-game V and NPC smoke-test checklist and acceptance record.
- [x] Validate clean development installation and release packaging with no stale scripts or Debug
  artifacts, and confirm release metadata and documentation identify Codeware and Equipment-EX as
  required dependencies.
- [x] Produce the validated release archive and publication-ready listing materials without
  publishing them, including the experimental NPC-clothing and body-clipping limitations.

## Deferred scope

- Defensive disabling for an unexpectedly missing V preview puppet without a reproduced failure.
- Automatic item compatibility detection.
- Runtime preview-failure recovery and session-level failed-item disabling.
- Partial saved-outfit recovery and omitted-item summaries.
- Keyboard/controller navigation.
- Expansion and collapse animations.
- Same-session panel, scroll, and search restoration after changing Photo Mode pages.
- Automatic NPC garment refitting or filename-ranked mesh substitution.

## Removed scope

- Per-slot NPC `ORIGINAL` cards and inferred appearance-component-to-slot associations.
- Clothing-catalog filters beyond the required name search and existing slot grouping.
- Live character or independent garment thumbnails.
- Wardrobe preview-puppet pose controls.
- A separate top-level NFR Photo Mode page.
- A duplicate CET/ImGui interface.

## Shared knowledge basis

- `..\Knowledge\.kiro\steering\equipment-ex\photo-mode\ink-probe.md`
- `..\Knowledge\.kiro\steering\equipment-ex\scroll-input.md`
- `..\Knowledge\.kiro\steering\equipment-ex\research.md`
- `..\Knowledge\.kiro\steering\npc-outfit-manager\research.md`
- `..\Knowledge\.kiro\steering\red-filesystem\mod-red-filesystem.md`
- `..\Knowledge\.kiro\steering\codeware\mod-codeware-ui-core.md`
- `..\Knowledge\.kiro\steering\codeware\mod-codeware-localization.md`
- `..\Knowledge\.kiro\steering\wkmcp\ink-assets\workflow.md`
- `..\Knowledge\.kiro\steering\mod-settings\mod-mod-settings.md`
