# Neon Fitting Room — Design

## Overview

Neon Fitting Room is a REDscript integration around the existing Equipment-EX Photo Mode seam.
It owns a transient session model and never writes preview changes to the player or saved outfits.

### Current implementation status

The repository contains working in-place card browsers for Outfit, Category, Pose, and Facial
Expression on V's Character page. Category changes rebuild the dependent Pose cards, native arrows
and card choices remain synchronized, and expanded content contributes its measured height to Photo
Mode's outer list. The implemented CLOTHING browser adds lazy, alphabetized, icon-bearing slot
cards and applies temporary Equipment-EX item previews. The NPC page has the same native-option
browsers plus an experimental, slot-filtered Clothing browser and a component-visibility browser.
NPC Clothing is now an explicit, disabled-by-default Mod Settings opt-in. Player-visible NFR text
uses Codeware localization keys with a shipped English fallback. Outfit icon collages, tooltips, and
search are implemented and their runtime acceptance and clean Debug/Release packaging are validated.
Keyboard/controller support and automatic
NPC garment refitting are deferred.

## State model

The live state model retains Equipment-EX's native Outfit selection authority. V clothing card and
slot-arrow input converge on
`ApplyNfrClothingSlotSelection`, which uses the slot browser's active `ItemID` to perform one
clear/toggle/replace transition through `UnequipPuppetItem` and `EquipPuppetItem`, then synchronizes
the slot label, selected card, parent count, and custom-preview state.

Clear is an owned text action in the Clothing header's unused space. It preserves the active
Equipment-EX preview-outfit selection while directly clearing its public `GetOutfitSlots()` set and
the eight vanilla base attachment slots used by Equipment-EX 1.2.9 on the preview puppet. This mirrors the clearing phase of Equipment-EX's private
`EquipPuppetParts` without running an apply phase for either an outfit or player equipment. It resets every materialized slot identity
to `NONE`, presents an empty collapsed value instead of the synthetic card label, and deliberately
leaves the native Outfit selection unchanged. Reset is presented in the Outfit header. Outfit
synchronization retains the exact native `PhotoModeMenuListItem` option as an independent session
baseline. Reset calls Equipment-EX's matching saved/current/no-outfit puppet API directly and then
synchronizes Clothing from that retained option; it does not re-enter the native arrow callback.
Because Outfit selection may occur before Clothing's lazy slot catalog exists, catalog construction
marks the catalog ready and then replays that retained option through the same synchronization path.
Fresh Photo Mode controllers seed the retained baseline from the current native Outfit option, so
neither player-equipped state nor the previous session's final slot summaries can initialize rows.
Because the game may reuse the same Photo Mode controller and Ink tree across openings, `OnShow` is
the session reset boundary: NFR reconciles its owned Outfit identity, label, card accent, expansion,
and search state from Equipment-EX's newly initialized native selector; it then collapses Clothing
and its slot panels, clears their search, invalidates older deferred synchronization, and rereads the
same native Outfit option immediately and once more after the host UI settles. `OnUninitialize`
remains destruction cleanup rather than session-reset authority.
Manual Clear/item transitions invalidate any
older settled synchronization callback so it cannot overwrite their custom state. Action availability
derives from active slot count and whether a manual preview diverges from the retained Outfit baseline.

Equipment-EX and Codeware are hard installation dependencies. Release metadata, the Nexus listing,
and user documentation communicate those requirements; NFR does not attempt a runtime fallback or
diagnostic after either prerequisite is omitted. Defensive handling for an unexpectedly absent V
preview puppet remains outside the first-release scope unless a reproducible failure establishes
that handling contract.

Selecting the already-active saved-outfit, No Outfit, or Current Equipped Outfit baseline card is a
no-op. Selecting a different baseline first removes the previous preview composition, clears category
overrides, and then renders only the new baseline.

`NfrItemBrowserModel` derives expandable Wardrobe-style categories from every clothing item available
in the player's Equipment-EX Wardrobe. Each supported category maps to exactly one preview-equipment
slot and therefore has at most one active item. It resolves that item from the baseline outfit plus
overrides and provides the category-header equipped summary. The UI refreshes that summary on every
preview-state change rather than retaining independent widget state. The first release implements
name search and slot grouping but no additional catalog filters.

## Module ownership

- `core/` — outfit snapshots, user settings, build marker, and diagnostic configuration.
- `ui/` — reusable NFR-owned Ink components and presentation state.
- `ui/photo-mode/` — native Photo Mode control adapters, card selection, and widget cleanup.
- `diagnostics/photo-mode/` — functional active-NPC puppet discovery and session registry.
- `settings/` — future optional settings integrations and visual style mapping.
- `diagnostics/` — the sole logging facade and generated build-specific backend.

## Development foundation

`NfrBuildMarker` exposes source-tree version metadata without a local-path dependency.
`NfrBuildProfile` is generated from a Debug or Release template during installation and packaging.
`NfrConfig` is a Codeware `ScriptableService` that resolves verbose logging from that profile's
default. `NfrLog` is the only diagnostics facade available to NFR code. Debug builds replace
its backend with the Codeware/engine logging implementation; Release builds receive a no-op backend
with no native logging references. The functional active-NPC puppet registry remains in every build.

The development installer replaces only NFR's unbundled source directory under
`r6/scripts/NeonFittingRoom`, preventing stale REDscript files from remaining compiled after an
iteration. It creates shared debug logging declarations only when absent. A Release install removes
those declarations only when they exactly match NFR's template. The package script stages a
game-root-relative `r6` directory, writes a checksum,
and validates the archive's marker, generated profile, and selected logging backend.

After installing the selected source profile, the development installer runs
`tools/compile-redscript.ps1`. This compiles the complete installed `r6/scripts` tree together with
the RED4ext plugin declaration paths against an isolated copy of the installed modded script
baseline. Compiler output remains beneath `build/redscript-preflight`, and any compiler diagnostic
fails deployment before the game is launched without modifying the game's launch cache.

## Compatibility boundaries

Equipment-EX is the saved-outfit authority and provides fake-puppet outfit/item operations. NFR
must call only its public API at this boundary. PhotoMode-EX currently has no public REDscript API
for arbitrary pose application, so its functionality is not coupled to the first NFR release.
Wardrobe pose controls are omitted entirely from that release rather than presented in a disabled
state.
Codeware is a required runtime dependency and supplies the selected service and UI facilities.
All NFR player-visible text is resolved through localizable strings from the first release.
The first release ships English text only while preserving a structure for later translations.

### Validated Equipment-EX integration boundary

The installed Equipment-EX Photo Mode implementation adds its Outfit attribute immediately after
Visibility on the Character page and configures a `PhotoModeMenuListItem` in `OnShow`. It exposes
the full logical option set—No Outfit, Current Equipped Outfit when an outfit is active, and saved
outfits—through `SetupOptionSelector(options, current)`. Its arrow callback delegates to the public
`gameuiPhotoModeMenuController.OnAttributeOptionSelected(attribute, option)` method.

NFR retains that logical attribute and its rendered row as the synchronization host. It mounts a
measured card panel beneath the row, updates the retained selector with `ForceValue`, and invokes the
same `OnAttributeOptionSelected` route. Native arrow selection is observed and reflected back into
the selected card. This retained-row approach is the verified implementation, not a fallback.

The native NPC card selector is expressly excluded as an implementation host. Its data contract is
one `Character.*_Photomode_Puppet` record plus a `PhotoModeSticker` icon per card; choosing an entry
selects a Photo Mode NPC puppet. Equipment-EX saved outfits instead apply to V's existing fake
puppet, so representing them as NPC records would be semantically and technically incorrect. NFR's
card grid must therefore be supplied by an NFR-owned compiled Ink template/controller with an
explicit lifecycle. NFR will not maintain a second CET/ImGui implementation.

NFR uses an owned compiled Ink library for the card surface and does not copy the native Photo Mode
root, which embeds `gameuiPhotoModeMenuController`. NFR does not instantiate another
`PhotoModeListController` or nested scroll controller. Its fit-to-content hosts participate in the
existing Photo Mode list, whose outer `inkScrollController` remains the sole scrolling authority.
NFR narrowly wraps `PhotoModeListController.HandleInputWithVisibilityCheck`: directional releases
retain the native `EnsureVisible` behavior, while non-directional releases bypass that unconditional
re-centering. Native `OnRelease` continues to process the `Scroll` action. This preserves wheel and
scrollbar positions across card activation. Structural Ink changes are validated with a clean game
restart; Hot Reload while Photo Mode is open is not a valid validation path.

The Photo Mode Pose Selector CET implementation validates the native synchronization primitive:
`GetMenuItem(attribute).ForceValue(data, true)` updates a retained menu item by option data (with
`OnForceAttributeVaulue` exposed as fallback). NFR will use the Equipment-EX Outfit option identity
and then preserve its normal `OnAttributeOptionSelected` application path; it will never synthesize
or select an NPC character option for an outfit.

`OutfitSystem.GetOutfits()` already returns alphabetical saved-outfit names and
`GetOutfitParts(CName)` returns the complete `OutfitPart` list used for card presentation. Tooltips
retain that complete list, while the icon collage selects only significant regions.
`EquipPuppetOutfit(puppet, outfitName)` clears Equipment-EX managed puppet slots before it
applies the chosen outfit. `EquipPuppetItem` and `UnequipPuppetItem` operate on the Photo Mode fake
puppet through preview items. NFR's renderer therefore owns a resolved baseline/override snapshot:
it renders a new baseline first, then removes or replaces known category items in deterministic slot
order. It tracks every baseline and override `ItemID` that it may need to remove; it must not call
player-equipment or saved-outfit mutation APIs.

Equipment-EX constructs Wardrobe cells from `UIInventoryItem.Make(...)` and uses
`UIInventoryItemTooltipWrapper.Make(...)` for standard item tooltips. Runtime inspection verified
that Photo Mode does not instantiate the configured `gameuiTooltipsManager`, tooltip library, and
widget references required by that presentation route. NFR therefore reuses `UIInventoryItem` for
safe name, quality, and description resolution, then renders those values in one shared owned
surface using the base game's `generic_background` and `generic_background_fg` tooltip atlas parts.
That surface copies the extracted Wardrobe item-tooltip roles: `Tooltip.backgroundColor` and
`Tooltip.frameColor` for the frame, uppercase Raj Medium `MainColors.Blue` title text, and Raj Medium
`Tooltip.descriptionTextColor` body text. Every owned tooltip widget uses the common
`tooltip_style.inkstyle` resource, which defines those roles and imports the main color palette;
using `main_colors.inkstyle` alone leaves `Tooltip.*` bindings unresolved. Nominal 4K sizes and
margins are scaled by the measured Photo Mode-root-to-notification-window ratio rather than
hardcoded for one display configuration.
Wardrobe-only identities that cannot resolve player transaction data fall back to the complete
Equipment-EX item label.

Tooltip presentation is an Interface setting in Mod Settings and defaults to enabled.
Cards retain their hover callbacks so an accepted setting change can take effect without rebuilding
the Photo Mode tree, but both the hover and display boundaries reject presentation while disabled.
If Mod Settings is unavailable, the enabled default is preserved.

The tooltip is mounted in `inkGameNotificationsLayer`'s virtual window and reordered to its final
child on every show so Photo Mode and ordinary menu layers cannot cover it; `inkMenuLayer` and the
controller root are ordered fallbacks when that layer is unavailable. Placement remains
cursor-relative by measuring both the
configured screen size and the actual virtual-window size, deriving an independent X/Y conversion
ratio, and applying that ratio to `inkPointerEvent.GetScreenSpacePosition()`. It flips left or above
the pointer at window edges. This avoids a hardcoded scale while remaining correct when configured
display size, render size, and driver-level upscaling differ.

Automatic compatibility detection, runtime item-failure recovery, and partial saved-outfit recovery
are deferred. The first release does not infer visual compatibility from attachment slots or claim
that successful Equipment-EX calls prove that a garment fits.

At Photo Mode entry, NFR exposes controls only after their required Wardrobe data is ready.

## UI direction

Unless the current-status section or implementation tasks mark an item complete, this section
describes the intended design rather than verified runtime behavior.

`NfrExpandableCardBrowser` and `NfrExpandableCardPresenter` form the reusable presentation layer.
The browser owns expanded state, card collection, grid geometry and measurement, card-surface
visibility, and runtime reset. The presenter composes that browser with one model and card surface;
it does not inherit Photo Mode mounting behavior or know Equipment-EX and native-option semantics.
The global Interface `Cards Per Row` setting defaults to eight and accepts six through ten. At mount
and rebuild boundaries, the browser measures its row, preserves the established 1458-unit grid width
when available, reduces it for narrower hosts, centers it, divides it by the selected column count,
and uniformly scales the compiled 162-unit card root. Consequently nine preserves the established
size, eight produces cards 12.5 percent larger, and search, hit testing, and content-height
measurement all consume the same derived `columnCount`, `cellSize`, and `originX`.
Retained surfaces reapply this geometry on expansion and Photo Mode entry rather than only at first
construction. Search reserves at least 80 virtual units above the grid and scales that inset with
cards larger than the nine-column baseline; search owns the final filtered surface height so a later
bare-grid measurement cannot overlap or clip the field.

`NfrExpandableCardControlModel` is the common input contract: a stable control identity, title,
ordered `NfrExpandableCardItemModel` list, active item identity, and grid geometry. Each item carries
a stable integer identity, display label, and enabled state. Domain adapters retain typed activation
data rather than hiding it in a `Variant`. The shared Photo Mode renderer consumes the presenter.

Two Photo Mode-specific bindings compose that presenter:

- `NfrPhotoModeOwnedExpandableControl` creates a complete NFR-owned Photo Mode row, selector arrows,
  disclosure input, value label, expandable host, and teardown hooks at a supplied list position.
- `NfrPhotoModeNativeSelectorBinding` accepts an existing native row, preserves its parent and
  selection authority, mounts a sibling expansion host, hooks only the bounded title/value/arrow
  targets supplied by the verified native structure, reapplies layout on reused `OnShow` widgets,
  and restores native geometry at teardown.

Consumers instantiate the appropriate binding, supply a model and callback names, call the shared
card renderer, activate the returned item identity through their own typed domain authority, and
update the model's active identity before refreshing card visuals. Neither type owns domain-specific
selection behavior.

Each consuming control supplies a thin adapter under `ui/photo-mode/`. It selects the owned or native
mounting type, supplies the model, invokes the domain activation route, and synchronizes selection
when arrows or another control changes the value. Outfit is the verified first adapter. Category,
Pose, and Facial Expression use the native variant. Category selection is treated as a dependency
boundary: after the host
refreshes its Pose options, a deferred indexed reread replaces the Pose model and card widgets from
attribute 6 instead of retaining stale identities from the prior Category.
Category presentation sorts cards by case-insensitive visible label while retaining each native
`optionData` as its activation identity. It does not reorder `m_OptionSelectorValues`: runtime
validation showed that changing the retained array order can make the displayed label follow the
new entry while the applied category still follows native index state. Alphabetical arrow traversal
must therefore be layered over the untouched native authority. Pose and Facial Expression retain
native option order.
Each adapter owns its expanded state and disclosure target; empty header space and native left/right
arrows are never treated as disclosure input. A Photo Mode-level accordion coordinator explicitly
collapses expanded peers before opening a top-level browser. It uses the browser's public,
idempotent `SetExpanded` operation so disclosure and surface visibility follow the same route as a
direct toggle.

Equipment-EX's native Outfit list item remains mounted in a zero-sized off-layout state holder so
its controller state, `ForceValue`, and selection callback contract remain authoritative. An NFR-owned row occupies
its former list index and owns all Outfit visuals and hit surfaces, including disclosure, arrows,
value, Reset, and cards; this avoids native ancestor tint, animation transforms, and competing input
layers. Native Category, Pose, and Facial Expression rows remain in their original Photo Mode list
parent and child index. Category is verified with
an NFR-owned sibling host inserted immediately after the native row; its zero-height collapsed
overlay supplies disclosure input while its content surface supplies measured expanded height. Pose
uses the same sibling-host pattern because the Photo Mode list controller retains ownership of
native list-item placement. Facial Expression uses attribute 28 and has no Category dependency.
Rebuilding any selector first unregisters old card callbacks and then replaces its card tree while
retaining that selector's expansion state.

The NPC page uses a separate set of native bindings for Appearance 3433, Facial Expression 56,
Category 65, and Pose 57. Character selection attribute 68 has two lifecycle boundaries. Initial
grid selection enables attribute 68 without selecting one of its options, so a coalesced 150 ms
refresh mounts the browsers after verifying that the retained character is an NPC rather than V.
Disabling attribute 68 is the verified no-active-NPC boundary: NFR cancels pending refresh work,
releases every NPC browser, and hides NPC Clothing without scheduling a scroll refresh. The native
`m_currentNpc` field can remain `0` after all NPCs have been removed, so it is not used as an
empty-state test.
The NPC Clothing header exposes Clear when the feature is enabled and the active NPC has NFR preview
items. Clear removes only those item-slot previews; it does not alter appearance-mesh component
visibility owned by the separate NPC control.
Native left/right NPC cycling selects an attribute-68 option and schedules a teardown/remount against
the newly populated native selectors. Removing each prior sibling host as part of release prevents
repeated switches from accumulating layout height. The active native row remains the per-NPC state authority;
NFR does not flatten the three selected NPC slots into one shared selection model. NPC Category
changes trigger a deferred indexed reread of dependent Pose attribute 57.

The initial UI preserves Equipment-EX's arrow-based Outfit control on the existing Photo Mode
Character page and adds a collapsible card surface beneath it; it does not add a top-level Photo Mode
tab. The same retained-native-row pattern applies only to the explicitly scoped Category, Pose, and
Facial Expression controls. Other Character-page controls remain unchanged.
NFR's own outfit selector and item browser exist only while the Character page is active and hide on
all other Photo Mode pages. Same-session presentation restoration after page changes is deferred;
reconstructed pages may safely reset their panels collapsed.
Each outfit card displays its name and a compact Wardrobe-style collage derived from populated
Equipment-EX Head, Torso, Back, Waist, Legs, and Feet slots. All populated sub-slots in those six
regions are included; smaller accessory regions such as Face, jewelry, arms, hands, fingers, toes,
and props are omitted so the remaining icons stay recognizable while skimming. The collage shows
no empty-slot placeholders. The implementation selects a deterministic near-square grid from the
significant-part count,
reduces every icon uniformly to fit above the retained outfit-name label, and reserves a visible `?`
cell when a valid constituent item lacks resolvable icon data. It never substitutes a truncated `+N`
summary. This is a deterministic UI
composition, not a rendered character thumbnail. NFR does not implement live outfit thumbnails.
Outfit icon presentation is an Interface setting in Mod Settings and defaults to enabled. Cards
retain their icon widgets across Photo Mode controller reuse, while every Outfit-surface update
reapplies the committed visibility and label layout. When disabled, NFR hides both constituent
collages and the No Outfit utility icon and restores the centered, text-only card layout. If Mod
Settings is unavailable, the enabled default is preserved.
The selected outfit card uses the same Wardrobe blue accent border as a selected item card.
The outfit selector starts collapsed when the player enters Photo Mode. Its collapsed header displays
only the selected outfit name or the matching active Equipment-EX No Outfit or Current Equipped
Outfit state. Selecting an outfit leaves the selector expanded for rapid browsing. Collapsing and
reopening it resets the containing Photo Mode control list to the outfit panel's top and clears its
search field. Its header toggles the panel's expanded state. The configurable card surface calculates
its complete row height and expands the Outfit row to contain every card. Photo Mode's existing outer
control-list scrollbar remains the only scrolling authority; NFR does not create a nested outfit
scrollbar.
The grid includes Photo Mode's No Outfit and Current Equipped Outfit special choices as selectable
NFR cards alongside saved Equipment-EX outfits. Current Equipped Outfit uses the same compact
constituent-item icon collage, resolved from the player's currently equipped clothing.
No Outfit uses an NFR clear/empty-state utility icon.
These two utility-baseline cards precede all saved outfits in the grid.
Saved outfits are then ordered alphabetically by their display names.
Hovering a saved-outfit card shows the shared tooltip with every included item name. Native-option
cards use the same surface for their complete localized labels.
Every non-Clothing card surface uses one shared expanded-only search binding. It mounts a localized Codeware
`HubTextInput`, debounces label filtering, compacts visible cards without changing their retained
identity or source ordering, participates in the predictive scroll transaction, and releases keyboard
focus when another control is clicked or Photo Mode exits. Outfit search matches saved outfit names
and hides No Outfit and Current Equipped Outfit utility cards while active. Native V/NPC option
browsers search their current native-derived labels. A no-results query leaves the grid empty without
a separate message, and collapsing any searched browser clears its query. Search fields align with
the selector region beneath the active value and left/right arrows rather than the full row center.
Each browser retains its query independently from the transient Codeware input widget, so native
selection may rebuild cards and recreate the input without clearing the filter. Explicit collapse
and Photo Mode session reset remain the query-clearing boundaries.
The item browser uses expandable Wardrobe-style categories. A category header displays its active
equipped item summary using the same Wardrobe blue accent as a selected item card and changes
immediately after any item-preview action. Every category begins collapsed when the browser opens,
including a category with an active item. Every card and category refresh must reset visibility,
text, blue selection styling, expansion state, and callbacks because card widgets may be virtualized
or reused. A category with no active item displays only its category name in Wardrobe's muted gray
empty-slot treatment; it indicates that nothing in that category is equipped or previewed. An
expanded category renders its available items in a Wardrobe-style icon grid and remains expanded
after an item is selected or removed. Clothing-slot categories form their own accordion: opening a
slot collapses an expanded sibling but does not collapse the Clothing parent or any top-level peer.
Their expansion state survives an outfit selection; only their active-item summaries and selected
cards are recomputed. Outfit selection also preserves the item browser's current scroll position.
The top-level CLOTHING row is an NFR-owned expandable control inserted immediately after Outfit's
host and before native Category. Its presenter accepts an arbitrary fit-to-content compound widget;
the attached vertical child container owns nested slot controls, while each slot control may attach
its own card surface. Nested slot disclosures and titles are indented by the reference disclosure's
width plus a small child offset, while their selector arrows and active value retain the shared
top-level selector columns. CLOTHING itself is a disclosure-and-title group header with no selector value
or cycling arrows. Each nested slot control is a complete selector: its disclosure and slot name
toggle that slot's cards, its centered value summarizes the active clothing item (or empty state),
and its left/right arrows cycle through the same ordered item list while the cards are collapsed or
expanded. Arrow changes and card selections update the same active identity and preview route. No
level introduces a nested scroll controller.
The parent row is attached without reading the Wardrobe catalog. NFR snapshots lightweight Wardrobe
`ItemID`s and groups them by Equipment-EX slot only when CLOTHING is first expanded, then creates the
slot selector rows. A slot resolves its ordered labels and UI item models on first interaction and
instantiates its card widgets only on first expansion. Collapsed, never-used slots therefore retain
only item identities and active-preview identity; opened slots retain their model and optional card
subtree for the rest of the Photo Mode session. Page changes hide the browser without rebuilding or
purging it, and Photo Mode teardown releases the complete transient catalog and widget tree.
The overall item browser panel also starts collapsed when the player enters Photo Mode. Collapsing
the overall panel discards its browsing presentation state; reopening it scrolls to the top and
collapses every category, clears its search field, and retains the session's actual preview
selections. Outfit, Clothing, Category, Pose, and Facial Expression form a top-level accordion, so
opening one collapses any expanded peer. This coordinator is independent of the nested clothing-slot
accordion. The item-browser header toggles the panel's expanded state, and each category header
toggles that category's own expanded state.
Its categories preserve Equipment-EX Wardrobe's existing category order. A slot's retained item
identities are sorted by player-visible display name when that slot is first materialized, making
card position, selected identity, and left/right cycling share one alphabetical order. Items render
as icon-only cells without names beneath their icons. Hovering a cell resolves standard
`UIInventoryItem` name, quality, and description data when available and otherwise shows its complete
Equipment-EX item label in the shared game-styled tooltip. Categories with no available Wardrobe
items are omitted.
The top-level Clothing browser on both V and NPC pages owns one shared search field immediately below
its header. It lazily resolves every represented slot catalog, hides child rows without a match, and
applies the current display-name query whenever a matching child is expanded. On the NPC page the same
binding also filters the NPC appearance-component card collection, whose browser suppresses its own
otherwise-standard card search. Search hides `NONE` utility cards in rendered results, preserves every
slot header's active-item summary, and does not automatically expand sibling controls. Clearing or
collapsing Clothing restores every child row and card.
Query changes use the same predictive scroll transaction
as expansion so the outer Photo Mode viewport remains anchored.

Equipment-EX's `OnAttributeOptionSelected` remains the outfit-application authority. NFR wraps that
completed route only to recompute every materialized clothing-slot summary and selected-card identity
from the exact selected option: saved choices use `GetOutfitParts(optionText)`, Current Outfit uses
the active Equipment-EX part state, and No Outfit clears all slot summaries. A prior manual preview
must therefore never remain displayed after an outfit choice replaces the preview puppet contents.

Every expansion begins one shared, generation-guarded scroll transaction before accordion peers or
the selected panel change height. The transaction captures the outer `inkScrollController`'s
absolute content offset plus the initiating header's global Y position and effective Y scale. After
Before Ink publishes the changed fit-to-content height, NFR recursively measures the visible,
explicit heights and margins of its owned vertical-list branches. The synchronous before/after
difference predicts both the new scroll range and the height removed or inserted above the initiating
header, allowing its normalized position to be set in the mutation callback before the changed frame
is rendered. After Ink publishes the authoritative range, `UpdateScrollPositionFromScrollArea`
restores the predicted absolute offset. The following frame measures and corrects any residual header
displacement, with one short fallback for late settlement. Stale deferred callbacks cannot restore an
older transaction.
The controls input guard resolves the active native outer scroll viewport after dynamic controls are
mounted. A global `OnPreOnRelease` callback receives the actual `inkPointerEvent` for
`PhotoMode_ScrollUp` and `PhotoMode_ScrollDown`, transforms `GetScreenSpacePosition()` into viewport
local coordinates, and records a one-use decision for the corresponding
`PhotoMode_CameraMouseWheel` player action. When that wheel event lies inside the measured viewport,
the guard steps the sole outer `inkScrollController` once and consumes the pointer release so child
hit-test gaps and interactive controls use the same scroll path without double-stepping. It retains
the camera-wheel decision until the next pre-release boundary because one physical wheel step may
emit multiple camera-wheel callbacks. Outside releases clear the decision and preserve camera zoom.
This avoids hover-state races, child-transition churn, and synthetic hit-test surfaces.
Teardown unregisters the global callback and clears any pending decision. TRACE logging retains the
screen position, local position, viewport size, classification, and subsequent consume/delegate
result until V and NPC callback ordering and coordinate bounds are runtime-validated.

Clear retains the selected outfit identity but disables its rendered baseline, clears overrides,
and rerenders the fake puppet immediately without confirmation. Reset restores that selected
outfit baseline exactly and clears overrides immediately without confirmation. Both are preview-only
actions and never invoke persistent player-equipment, active-outfit, inventory, or saved-outfit
mutation APIs. While the baseline remains disabled, later selections populate the slot-keyed
overrides and render together as an item-only preview; they do not implicitly restore the selected
outfit. Reset derives every item-card selected state from the restored baseline, so all of its
constituent cards use the blue accent. Clear resets all item-card selection styling and category
header summaries.
Clear and Reset are persistent header-adjacent controls and remain visible while their respective
browsers are collapsed or expanded. Clear is disabled when no managed clothing item is rendered. Reset is
disabled when the resolved preview exactly matches its active baseline.
Both controls use text labels and require no iconography.
Their order is Clear followed by Reset.

The first release supports mouse interaction. Keyboard/controller focus and action-navigation are
deferred.
NFR does not consume the game's Back action to collapse a panel; normal Photo Mode navigation and
exit behavior takes precedence.

NFR preview state is scoped to one Photo Mode session. On Photo Mode exit, its selected identity,
baseline-render state, category overrides, panel expansion state, and scroll positions are discarded.
The next session initializes from Equipment-EX's active outfit with both NFR panels collapsed.

## Shared knowledge consulted

- `..\Knowledge\.kiro\steering\equipment-ex\photo-mode\ink-probe.md` — retained Outfit-selector
  authority and Photo Mode lifecycle constraints.
- `..\Knowledge\.kiro\steering\equipment-ex\scroll-input.md` — outer-scroll ownership, runtime
  ordering evidence, and the verified `EnsureVisible` input boundary.
- `..\Knowledge\.kiro\steering\equipment-ex\research.md` — public outfit/item APIs and asynchronous
  NPC preview-item materialization.
- `..\Knowledge\.kiro\steering\npc-outfit-manager\research.md` — offline refit discovery boundary
  and absence of an authoritative runtime compatibility mapping.
- `..\Knowledge\.kiro\steering\red-filesystem\mod-red-filesystem.md` — known-path resource access
  without packed-archive enumeration.
- `..\Knowledge\.kiro\steering\codeware\mod-codeware-ui-core.md` — Codeware UI construction,
  reflection, and widget-library APIs.
- `..\Knowledge\.kiro\steering\codeware\mod-codeware-localization.md` — localization provider,
  package, and fallback lifecycle.
- `..\Knowledge\.kiro\steering\photomode-ex\research.md` and
  `..\Knowledge\.kiro\steering\photo-mode-pose-selector\native-selector-bridge.md` — option-data
  synchronization boundary.
- `..\Knowledge\.kiro\steering\wkmcp\ink-assets\workflow.md` — compiled Ink build workflow.
- `..\Knowledge\.kiro\steering\mod-settings\mod-mod-settings.md` — optional declarations,
  persistent value lookup, and missing-module fallback behavior.

Favorites and per-category clear controls are deliberately outside the first-release UI. The only
preview-reset controls are the global Clear and Reset actions. Mod Settings exposes the experimental
NPC Clothing feature as an opt-in setting; the setting is disabled by default and describes known
fit and clipping limitations.

## Experimental NPC clothing browser

NPC Clothing is gated by an NFR Mod Settings option that defaults to disabled and describes the
known possibility of clipping or unsupported bodies. When Mod Settings is absent, `NfrConfig`
exposes `SetNpcClothingEnabled(Bool)` as a CET-callable, process-local override. The override begins
false, is never persisted, and therefore returns to the safe disabled state after every game
restart. The NPC native Appearance, Facial Expression, Category, and Pose card browsers do not
depend on this setting.

As with V's retained controls, the game may reuse the Photo Mode controller and Ink tree without
calling `OnUninitialize`. NPC `OnShow` therefore invalidates pending NPC refresh generations,
releases all four native-option adapters, collapses and hides retained Clothing surfaces, clears
their search and per-puppet preview maps, and drops retained puppet references. A fresh native
attribute-68 activation remains the only path that remounts target-specific NPC controls. This
prevents an expanded panel, disclosure arrow, query, or Clothing target from leaking into a later
Photo Mode session before an NPC is selected.

The NPC Photo Mode page owns a separate NFR-owned `CLOTHING` control mounted after the active
NPC's complete Appearance expandable host. It reuses the owned expandable-control presenter and the Wardrobe
slot/card models. Photo Mode puppet setup registers each non-customizable puppet for the session.
On native attribute-68 selection, NFR matches the option label to the retained puppets' localized
character display names and then refreshes against that puppet. Initial grid selection uses the most
recently registered NPC followed by the deferred native-selector refresh. This name-based bridge is
the current project fallback because runtime verification found that `m_currentNpc` does not reliably
represent the no-active-NPC state.
Its nested slot rows expose the same title, current-item value, left/right cycling arrows, lazy card
materialization, and select-again-to-remove behavior as V's clothing rows.

The browser binds scroll refresh and the wheel-coordinate input guard from its own row so they resolve the
NPC page's outer `inkScrollController` and viewport rather than retaining V's page context. Before
layout mutation, the generic refresh path snapshots the resolved controller's absolute pixel offset.
The current NPC expansion path recomputes the outer range synchronously, then schedules the normal
deferred settle and offset restoration. This latest ordering is statically validated and deployed
but still requires in-game validation for the reported one-frame jump.
Because the NPC selector rows are rebound when the active character changes, each completed adapter
refresh also rebinds pointer ownership when the active native scroll viewport changes. A
same-controller match preserves the current viewport binding.

Slot rows are filtered against the active puppet `Character_Record`'s effective
`attachmentSlots`. A newly active puppet releases and lazily rebuilds only the target-specific UI
rows; it first collapses the retained parent so its disclosure cannot advertise an empty expanded
surface, and it does not unequip items from the retained prior puppet. Each live puppet has a
session-local slot override map, resolved by live puppet reference with its Character record as the
fallback when native reconstruction replaces the puppet object. Native character switching first
remounts target-specific controls, then begins one fixed delayed reconstruction after native
activation has had time to replace equipment. The first phase removes retained preview instances;
the second phase re-adds them after a separate transaction interval so a genuinely new attachment
transition is observable. Generation and target checks discard stale callbacks, and no polling loop
repeatedly mutates the transaction system. Appearance-component visibility is replayed idempotently
after reconstruction. Lazy row creation
then synchronizes labels and selection from the retained map. This filter is a
conservative capability hint only: an advertised slot does not establish that a custom NPC entity
template has compatible garment components. NPC clothing preview and teardown restoration remain
experimental.

When the eligibility intersection is empty, the complete NPC Clothing host is hidden and consumes
no list space. Its parent summary follows V's presentation contract: zero-based state is `0 ITEMS`,
and any direct per-item mutation changes it to `CUSTOM (N ITEMS)`, where N is the number of retained
active slot selections.

V and NPC construction share `NfrPhotoModeClothingBrowserConfig` and
`BuildNfrPhotoModeClothingSlotControls`. The configuration supplies generated identity prefixes,
controller callback seams, initial equipped-state behavior, and a target-specific eligible-slot
set. V permits the complete Equipment-EX slot catalog and seeds active identities from the player's
Equipment-EX state. NPCs restrict the same catalog to the active entity's effective attachment
slots and do not read player-equipped state. Target-specific equip, synchronization, and restoration
remain adapter responsibilities; Wardrobe enumeration and slot-row presentation do not.

The shared clothing-slot model currently stores an ordered `ItemID` array and reserves index zero
for the synthetic `NONE` card. V and NPC callbacks own their different equip, remove,
synchronization, and restoration policies. There is no implemented per-slot `ORIGINAL` card or
automatic association between an appearance-owned component and an Equipment-EX slot. Baked
appearance meshes are instead managed by the separate NPC component browser described below.

REDscript and RedFileSystem can resolve or read known paths but cannot enumerate packed archive
resources. NFR does not package a resource index, require customers to run an offline tool, or use
filename similarity as proof of body compatibility. Garment refitting remains deferred until a
runtime dependency can provide authoritative resource enumeration and compatibility metadata, or
content authors publish equivalent manifests.

Every materialized clothing slot begins with a `NONE` model identity. Selecting it removes the
slot's currently tracked item, clears the collapsed row's value label, and makes `NONE` the selected
card; left/right cycling traverses the
same ordered model. For NPC targets, the adapter also queries each eligible slot through
`TransactionSystem.GetItemInSlot`. A resolvable starting item is normalized from preview identity to
record identity and inserted immediately after `NONE`, ahead of alphabetized Wardrobe items. Baked
appearance components have no `ItemID` and remain outside this item-card model. The native
Appearance selector changes a complete entity appearance; NFR does not inject a misleading `NONE`
option into it.

Instead, the NPC Clothing child list begins with an NFR-owned `NPC` browser. This is a
multi-select component-visibility adapter rather than an Equipment-EX slot adapter: its cards retain
direct component identities, independently toggle garment, accessory (including ambiguous `i1_`),
and hair meshes, and show every currently retained visible component with the selected accent. Its
`NONE` card hides the complete represented set. The parent-style value is `N ITEMS` initially and
`CUSTOM (N ITEMS)` after any component is hidden, where N counts only visible component entries.
Known anatomical body prefixes remain excluded. This explicit surface lets the user resolve baked
appearance conflicts without pretending that a regional prefix proves one exact extended slot.
Photo Mode and Equipment-EX can expose repeated live component instances with identical name and
resource signatures. One NPC card therefore retains and toggles the complete signature group rather
than deduplicating to an arbitrary first component reference.
Per-NPC session state stores only those signatures and their desired visibility. Active-character
navigation may release the browser and its live component references; NFR rediscovers the active
puppet's component collection, reapplies matching visibility choices, and reconstructs card accents
from the retained values. The state is cleared at Photo Mode entry/teardown and for the affected NPC
when native Appearance replaces its component collection.
Native NPC Appearance selection is a hard invalidation boundary: immediately before delegating the
selection to Photo Mode, NFR removes its preview items and releases this component browser plus all
generated slot rows. The ordinary deferred native-option refresh then leaves them eligible for lazy
reconstruction against the replacement appearance.
