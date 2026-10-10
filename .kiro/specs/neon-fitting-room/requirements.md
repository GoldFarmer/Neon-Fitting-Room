# Neon Fitting Room — Requirements

## 1. Equipment-EX integration

1.1. When Photo Mode is active and Equipment-EX is available, Neon Fitting Room SHALL provide a
collapsible card-oriented outfit selector integrated with Equipment-EX's rendered Outfit control on
the Character page.

1.2. NFR SHALL preserve native Photo Mode control semantics. It MAY attach the expandable-card
adapters specified here to Outfit, Category, and Pose; it SHALL leave every other existing
Character-page control unchanged.

1.2a. NFR's expandable selectors and item browser SHALL be visible only on the Photo Mode Character
page and SHALL hide when the player navigates to another Photo Mode page.

1.2b. NFR SHALL NOT persist panel expansion, scroll, search, outfit, pose, expression, or NPC state
between Photo Mode sessions. Same-session presentation restoration after changing pages is deferred;
NFR MAY safely rebuild affected panels collapsed when returning to a page.

1.2c. On every Photo Mode entry, including entry on a reused menu controller, NFR SHALL reconcile its
owned Outfit label, selected identity, card accent, expansion state, and search state from the native
Equipment-EX Outfit selector after that selector has initialized.

1.2c. NFR SHALL use an NFR-owned compiled Ink template for its Photo Mode controls. It SHALL NOT
copy the native Photo Mode root or instantiate the native `PhotoModeListController` as a presumed
generic card-grid controller. Its controls SHALL have explicit Photo Mode entry, page-change, and
exit cleanup.

1.3. When the user selects an outfit through either selector, Neon Fitting Room SHALL synchronize
the other selector to the same stable Equipment-EX outfit identity.

1.3a. NFR SHALL retain Equipment-EX's native Outfit selector as the logical selection authority.
NFR card selection SHALL update that retained selector using its stable option data and SHALL use
Equipment-EX's established selection route; it SHALL not model saved outfits as Photo Mode NPC
puppet records.

1.4. When a newly selected outfit is previewed, Neon Fitting Room SHALL remove prior item overrides
before applying the selected outfit to the Photo Mode fake puppet.

1.4a. Selecting the already-active saved-outfit, No Outfit, or Current Equipped Outfit card SHALL
not change the preview state.

1.4b. When the user selects a different outfit, Neon Fitting Room SHALL remove the prior preview
composition before applying only the newly selected outfit's items.

1.5. Each outfit card SHALL display the outfit name and, when the enabled-by-default Outfit Icons
Mod Settings option is enabled, a compact Wardrobe-style collage of its populated significant-slot
items. Disabling the option SHALL restore a text-only card layout. The collage SHALL omit empty-slot
placeholders.

1.6. An outfit collage SHALL represent every populated Head, Torso, Back, Waist, Legs, and Feet item
icon, including multiple sub-slots in those regions, without truncating the collection to a `+N`
summary. It MAY reduce icon size and use a deterministic composition to fit.

1.8. The currently selected outfit card SHALL use the same Wardrobe blue accent border as a selected
item card.

1.9. The outfit-card selector SHALL start collapsed when the player enters Photo Mode.

1.9a. Activating the outfit-selector header SHALL toggle its expanded state.

1.10. While the outfit-card selector is collapsed, its header SHALL display only the selected saved
outfit name or the matching active Equipment-EX special state: No Outfit or Current Equipped Outfit.

1.11. Selecting an outfit card SHALL leave the outfit-card selector expanded.

1.12. When the user reopens a collapsed outfit-card selector during the same Photo Mode session, the
outer Photo Mode control list SHALL position the outfit panel at its top.

1.12a. Collapsing the outfit-card selector SHALL clear its search field.

1.12b. The expanded outfit-card selector SHALL contribute its complete calculated card-grid height
to the Photo Mode control list and SHALL use that list's existing outer scrollbar rather than a
nested NFR scrollbar.

1.12c. Expandable Photo Mode card selectors SHALL use one NFR-owned browser component for host
insertion, disclosure-arrow state, card ownership, grid measurement, surface visibility, and
teardown. Each target control SHALL supply an adapter that owns its native option identities,
activation route, availability rules, ordering, and selection synchronization.

1.12d. Each expandable selector SHALL provide a disclosure arrow that remains geometrically stable
between collapsed and expanded states. The disclosure arrow, native control label, and current-value
label SHALL toggle the same per-control expanded state without enlarging native left/right-arrow hit
areas.

1.12e. NFR SHALL provide a global Cards Per Row Interface setting for every expandable card browser.
It SHALL default to eight, support six through ten columns, preserve a centered measured grid width,
and uniformly scale card visuals, labels, hit areas, spacing, and row height from the selected count.

1.13. The outfit-card selector SHALL include No Outfit and Current Equipped Outfit as selectable
cards alongside saved Equipment-EX outfits.

1.14. When Current Equipped Outfit is the active baseline, the item browser SHALL show the player's
currently equipped clothing as blue-selected items and in the corresponding category headers.

1.15. When No Outfit is the active baseline, the item browser SHALL show no blue-selected cards and
name-only category headers, ready for an item-only preview.

1.16. The Current Equipped Outfit card SHALL display a compact collage of the player's currently
equipped item icons.

1.17. The No Outfit card SHALL use a clear/empty-state utility icon.

1.18. No Outfit and Current Equipped Outfit SHALL appear before saved outfits in the outfit grid.

1.19. Saved outfit cards SHALL be sorted alphabetically by their display names after the two utility
baseline cards.

1.20. When the enabled-by-default Tooltips Mod Settings option is enabled, hovering or
focusing a saved-outfit card SHALL show a tooltip listing its included item names.

1.21. The outfit-selector header SHALL include a search field for outfit cards.

1.21a. The outfit search field SHALL appear only while the outfit selector is expanded.

1.22. The outfit search SHALL filter matching cards live after a brief input debounce.

1.23. Outfit search SHALL match saved outfit display names only.

1.24. When outfit search has no matches, NFR SHALL not display a separate no-results message.

1.25. While outfit search is active, NFR SHALL hide the No Outfit and Current Equipped Outfit cards.

1.26. Outfit search activation and query changes SHALL preserve the outer Photo Mode control-list
scroll position.

## 1A. Native Category, Pose, and Facial Expression card selectors

1A.1. NFR SHALL provide independently expandable card browsers for the native Character-page
Category, Pose, and Facial Expression selectors using the same reusable browser component as Outfit.

1A.2. Each adapter SHALL retain its native selector as the selection authority, derive cards from
the selector's current option data and display order, and invoke the native activation route rather
than reimplementing selection semantics.

1A.3. Native left/right selection and card selection SHALL remain synchronized bidirectionally for
Category, Pose, and Facial Expression, including selected-card treatment and current-value label.

1A.4. After a Category change, NFR SHALL wait for the native dependent Pose option list to refresh,
then rebuild or reconcile Pose cards from that current native list and synchronize the selected Pose.
It SHALL NOT assume that Pose identities or availability remain valid across Category changes.

1A.5. Category cards SHALL be ordered alphabetically by player-visible label. Pose and Facial
Expression cards SHALL preserve native option order. All three SHALL preserve native availability,
stable option identity, and the player-visible label observed for the current Photo Mode session.
The native Category left/right arrows SHALL traverse that same alphabetical order without mutating
the native selector's retained option array after setup.

1A.6. Each selector's disclosure arrow, native control label, and current-value label SHALL toggle
only that selector. Empty header space and native left/right-arrow hit areas SHALL not toggle it.

1A.7. Expanded Category, Pose, and Facial Expression grids SHALL contribute their complete measured
height to Photo Mode's existing outer control list. NFR SHALL not add nested scroll controllers.

1A.8. NFR SHALL preserve native directional navigation visibility behavior while preventing
non-directional pointer releases from re-centering the outer Photo Mode list. Wheel scrolling,
scrollbar dragging, and card activation SHALL preserve the user's outer-list scroll position.

1A.9. Native Photo Mode Pose browsing SHALL remain the only pose-card feature. NFR SHALL NOT add a
separate Wardrobe preview-puppet pose control.

1A.10. Outfit, Clothing, Category, Pose, and Facial Expression SHALL form one top-level accordion:
expanding one SHALL collapse any expanded peer, while directly collapsing it SHALL leave peers
unchanged.

1A.11. After an NPC is selected on the NPC page, NFR SHALL attach independently expandable card
browsers to that active NPC's Appearance, Facial Expression, Category, and Pose native selectors.
Switching among the selected NPC slots SHALL discard stale widget bindings, wait for the newly active
NPC's option lists to populate, and synchronize every browser from that NPC's native displayed state.

1A.12. NPC Category and Pose SHALL use the same dependency rule as the Character-page selectors:
after Category changes, NFR SHALL reread attribute 57 and replace the prior NPC's or category's Pose
cards. NPC selector attributes are Appearance 3433, Facial Expression 56, Pose 57, Category 65, and
active Character 68 for the validated dependency set.

1A.13. Every expanded native-option card browser on the V and NPC pages SHALL expose the same
localized, debounced label-search field used by other NFR card collections. Filtering SHALL compact
matching cards without changing their source ordering, stable identities, or native selection data.

1A.14. Collapsing a searched native-option browser SHALL clear its query. Search input SHALL release
keyboard focus when another control is clicked or Photo Mode exits, and filtering SHALL preserve the
outer list's anchored viewport position.

1A.15. Selecting a filtered native-option card SHALL preserve and reapply that browser's active
query when native selection refreshes its cards. Only explicit collapse or session reset SHALL clear
the query.

## 2. Item preview

2.1. Neon Fitting Room SHALL present the item browser as expandable categories comparable to the
Equipment-EX Wardrobe item browser.

2.1a. Activating a category header SHALL toggle that category's expanded state.

2.2. The item browser SHALL include every Equipment-EX Wardrobe item that resolves to a valid
`Clothing_Record`, has a valid appearance name, and maps to a supported Equipment-EX outfit slot.
Malformed or stale entries that fail those deterministic checks SHALL be omitted.

2.3. When one or more items in a category are part of the selected outfit or active preview state,
the category header SHALL display the relevant equipped item name using an equipped-state color.

2.4. Neon Fitting Room SHALL update each category header immediately when the user previews,
replaces, or removes an item.

2.5. When the user selects an item card, Neon Fitting Room SHALL immediately preview that item on
the Photo Mode fake puppet without requiring an Apply button.

2.6. When the user selects the same selected item card again, Neon Fitting Room SHALL remove its
preview override.

2.7. When the user selects another item for the same equipment slot, Neon Fitting Room SHALL
request removal of the prior override, wait for the matching attachment-slot completion callback,
and attach the replacement on the following transaction tick. If completion is not reported within
the bounded timeout, NFR SHALL inspect the actual puppet slot: an empty slot SHALL complete the
latest request, a changed attachment SHALL resynchronize the slot UI, and a still-present prior
attachment SHALL cancel the replacement rather than force an overlapping attachment. Additional
input for the same pending slot SHALL replace the pending target so the latest selection wins.

2.8. Selected item cards SHALL use the Wardrobe blue-accent selection treatment.

2.9. Each NFR item category SHALL represent one preview-equipment slot and SHALL have at most one
active item. Selecting an item in that category SHALL deselect and replace its prior active item.

2.10. When the item browser opens, every category SHALL start collapsed, including categories with
an active item.

2.11. A category header's active-item name SHALL use the same Wardrobe blue accent as a selected
item card.

2.12. When a category has no active item, its header SHALL display only the category name using
the Wardrobe muted-gray empty-slot treatment, indicating that no item is equipped or previewed.

2.13. An expanded category SHALL display its items in a Wardrobe-style icon grid.

2.14. Selecting or removing an item SHALL leave its category expanded.

2.15. Clothing-slot categories SHALL form an accordion independent of the top-level controls:
expanding one slot SHALL collapse any expanded sibling slot, without collapsing Clothing or another
top-level selector.

2.16. When an active item originated from the selected outfit baseline, selecting that same item
card again SHALL suppress that category's item from the fake-puppet preview until it is replaced,
the outfit changes, or Reset is used.

2.17. Selecting a different outfit SHALL preserve the current expansion state of every item category.

2.18. Selecting a different outfit SHALL preserve the item browser's current scroll position.

2.18a. If an Outfit selection occurs before the lazy Clothing catalog exists, NFR SHALL retain the
exact native option and synchronize every generated slot from that option immediately after catalog
construction. A new Photo Mode session SHALL derive this baseline from its current native Outfit
option rather than a prior session's slot state or Equipment-EX player-equipped state.

2.19. The overall item browser panel SHALL start collapsed when the player enters Photo Mode; its
individual categories SHALL also start collapsed.

2.19b. Re-entering Photo Mode on a reused controller SHALL clear prior Clothing expansion and search
presentation, invalidate prior-session deferred synchronization, and recompute every retained slot
from the current native Outfit option after that option has settled.

2.19a. Activating the item-browser header SHALL toggle its expanded state.

2.20. When the user reopens a collapsed item browser during the same Photo Mode session, it SHALL
reset to the top and collapse every category.

2.20a. Collapsing the item browser SHALL clear its search field.

2.21. Expanding the outfit-card selector or item browser SHALL collapse the other as members of the
top-level accordion.

2.22. Item categories SHALL preserve Equipment-EX Wardrobe's existing category order.

2.23. Items within each category SHALL be ordered alphabetically by their player-visible display
name. Card activation and left/right cycling SHALL use that same order.

2.24. Item cells in the category icon grid SHALL be icon-only and SHALL not show item names beneath
their icons.

2.25. When Tooltips is enabled, hovering or focusing an item icon SHALL show the standard item
tooltip with its full name and details.

2.25a. When Tooltips is enabled, hovering a Category, Pose, Facial Expression, or NPC Appearance
card SHALL show its complete localized label when the grid cell cannot display that label without
wrapping or truncation.

2.26. Categories with no available Wardrobe items SHALL be hidden from the item browser.

2.27. The expanded top-level Clothing browser on both the V and NPC pages SHALL include one shared
localized search field immediately below its parent control row.

2.27a. The Clothing search field SHALL appear only while the top-level Clothing browser is expanded.

2.28. Every item search SHALL use the same 450-millisecond idle debounce before filtering so input
remains responsive and no search path begins work earlier than another.

2.29. Item search SHALL match item display names only.

2.30. Clothing search SHALL match items across every represented clothing slot and, on the NPC page,
the NPC appearance-component cards; hide child rows with no matches; and apply the current query when
a matching child row is expanded. The NPC appearance-component row SHALL NOT mount a second search
field. Search SHALL not automatically expand sibling rows.

2.31. While Clothing search is active, the `NONE` utility card SHALL be hidden in every rendered
matching slot.

2.32. Search SHALL compact matching cards without changing their stable item identities or
alphabetical source ordering.

2.33. Search SHALL NOT change any slot header's active-item summary.

2.34. When item search has no matches, NFR SHALL not display a separate no-results message.

2.35. Collapsing the top-level Clothing browser SHALL clear its query and restore every slot and
card before the next expansion.

2.36. Clothing search activation and query changes SHALL preserve the item browser's current scroll
position.

## 3. Reset, lifecycle, and input

3.1. NFR SHALL provide text-labeled **Clear** and **Reset** actions beside the Clothing header in
that order. Both SHALL remain available whether Clothing is collapsed or expanded.

3.2. Clear SHALL immediately remove every NFR-managed preview item without confirmation while
retaining the selected outfit identity. Subsequent item choices SHALL form an item-only preview
without implicitly restoring that outfit.

3.3. Reset SHALL immediately remove manual item overrides and restore the selected outfit baseline
without confirmation. Card selection and slot summaries SHALL synchronize to that restored state.

3.4. Clear SHALL be disabled when no NFR-managed clothing is rendered. Reset SHALL be disabled when
the preview exactly matches its active baseline.

3.5. NFR SHALL mutate only the Photo Mode preview puppet. It SHALL NOT change the player's actual
equipment, inventory, persistent active outfit, or Equipment-EX saved outfits.

3.6. Photo Mode exit SHALL discard all NFR preview and UI state. The next session SHALL reconcile
from Equipment-EX's newly initialized native Photo Mode controls and start with NFR panels collapsed.

3.7. The first release SHALL support mouse interaction. Keyboard/controller navigation is deferred.
NFR SHALL not intercept the game's Back action.

3.8. Outfit, Clothing, Category, Pose, and Facial Expression SHALL form a top-level accordion.
Clothing slots SHALL form an independent nested accordion.

3.9. Expanding or collapsing a browser SHALL keep its initiating header at the same viewport
position after the outer scroll range changes. Camera zoom SHALL remain available outside the
controls viewport.

## 4. Compatibility and configuration

4.1. Equipment-EX and Codeware SHALL be required for the first release. Release metadata, the Nexus
listing, and user documentation SHALL identify both requirements. NFR is not required to compile,
load, or emit a runtime diagnostic when either hard dependency is absent.

4.2. PhotoMode-EX and the release-documented compatible Photo Mode companion mods SHALL be listed as
optional and recommended, not required. Release documentation SHALL distinguish compatibility with
NFR from compatibility among arbitrary combinations of those companion mods.

4.3. NFR SHALL provide a Mod Settings option for experimental NPC clothing preview. It SHALL be
disabled by default and describe the possibility of clipping or unsupported NPC bodies. When Mod
Settings is absent, NFR SHALL expose a documented Cyber Engine Tweaks console command that enables
or disables NPC Clothing for the current game process without persisting that override.

4.4. When experimental NPC clothing is enabled, NFR SHALL show Clothing only when the active NPC's
effective `Character_Record.attachmentSlots` intersects Equipment-EX outfit slots.

4.5. NPC slot eligibility SHALL NOT be presented as evidence of V-equivalent garment fitting.
Ordinary and modded NPC bodies may clip through V-fitted items.

4.6. Switching retained NPCs SHALL preserve each puppet's independent NFR item and explicit-NONE
state, rebuild the Clothing UI for the active puppet, and never continue targeting the prior NPC.
Because native activation may replace equipment after the selection callback returns, NFR SHALL
perform one delayed reconstruction of the active puppet's retained item and explicit-NONE state.
Reconstruction SHALL remove retained preview instances only after the puppet is active, re-add them
after a separate transaction interval, and then reapply retained component visibility. It SHALL
cancel stale callbacks through the active NPC generation rather than repeatedly mutating live slots.

4.7. Every materialized V or NPC clothing slot SHALL place a synthetic `NONE` card before its
alphabetized Wardrobe items. Selecting it SHALL remove the tracked slot item and clear the collapsed
value label.

4.8. The NPC Clothing group SHALL retain its `NPC` multi-select component browser. It SHALL expose
detected appearance-owned garment, accessory, and hair mesh components while excluding known
anatomical body geometry. Component cards SHALL toggle complete name/resource signature groups;
`NONE` SHALL hide the represented set without inferring Equipment-EX slot ownership.

4.8a. During one Photo Mode session, NFR SHALL retain component visibility choices independently
for each selected NPC and replay them when that NPC becomes active again. It SHALL retain stable
name/resource signatures rather than stale component references.

4.9. A native NPC Appearance change SHALL remove active NFR preview items and release component and
slot references before lazily rebuilding against the replacement appearance. It SHALL also discard
the prior component-visibility choices for that NPC because they describe the replaced collection.

4.10. All player-visible NFR controls, settings, states, tooltips, and diagnostics SHALL use
localizable strings. The first release SHALL include English text and a documented translation path.

4.11. NFR SHALL NOT automatically substitute NPC garment meshes from filename-ranked external
indexes. Automatic compatibility detection, runtime preview-failure recovery, partial-outfit
recovery, and garment refitting are deferred.

4.13. On every Photo Mode entry, NFR SHALL discard prior-session NPC selector adapters, expanded
card panels, search queries, retained preview targets, and per-NPC Clothing state before a newly
active NPC is allowed to rebuild those surfaces. This reset SHALL NOT depend on controller
`OnUninitialize`, because the game may reuse the controller and Ink tree across Photo Mode sessions.

4.14. Every REDscript `@wrapMethod`, `@replaceMethod`, `@addMethod`, or `@addField` integration SHALL
carry one structured machine-readable `@dependencies` docstring annotation identifying its provider, provider version
at which NFR adopted the integration, and the minimum provider version known to expose that target. The
exact target SHALL be derived from the REDscript annotation and function signature. An unknown
minimum SHALL be recorded explicitly as `TBD`, never inferred from the development baseline,
an upstream mod's current requirement, or a successfully tested version. A concrete minimum SHALL
be recorded only when versioned evidence identifies the release that first introduced the consumed
contract. Every
annotation and each of its fields SHALL use the standard multiline docstring form; compact one-line
dependency objects are invalid.

4.15. Direct, optional, and transitive runtime providers SHALL each have one `@dependencyProvider`
declaration in `integration/NfrDependencies.reds`. Provider declarations
SHALL contain provider identity, relationship, publication, module, surface, and role metadata but
SHALL NOT duplicate adoption or minimum versions. One deterministic generator SHALL aggregate versions from actual
`@dependencies` usage annotations into the dependency matrix, README runtime requirements, Nexus
requirements, and release manifest. Generated artifacts SHALL NOT maintain independent dependency
versions, and development installation and release packaging SHALL regenerate them before building.

4.16. Verification SHALL fail when an interception or injection lacks its own required metadata,
an annotation uses compact formatting, dependency declarations conflict, a dependency provider is
undeclared, or a generated dependency artifact differs from generator output.

4.17. Dependency coverage SHALL be local and explicit: each injected field or method SHALL own the
`@dependencies` annotation immediately associated with its declaration rather than inheriting a
file-level target-class contract. Each provider declaration SHALL enumerate the external API, type,
data, or integration surfaces consumed from that provider. Verification SHALL fail when an
injection lacks local coverage or a provider's dependency surfaces are absent.

4.18. Every positive or negative `ModuleExists` guard SHALL have an immediately adjacent docstring
whose `@dependencies` metadata identifies the provider that owns the guarded module. No blank line
SHALL separate an implementation docstring from its guard, REDscript annotation, field, method, or
class declaration. Every implementation docstring SHALL be separated from preceding code by exactly
one blank line. Verification SHALL reject missing guarded-module coverage, detached docstrings,
malformed docstring openings, and missing or excessive separators before docstrings.

## Shared knowledge basis

- `..\Knowledge\.kiro\steering\equipment-ex\photo-mode\ink-probe.md`
- `..\Knowledge\.kiro\steering\equipment-ex\scroll-input.md`
- `..\Knowledge\.kiro\steering\equipment-ex\research.md`
- `..\Knowledge\.kiro\steering\npc-outfit-manager\research.md`
- `..\Knowledge\.kiro\steering\red-filesystem\mod-red-filesystem.md`
- `..\Knowledge\.kiro\steering\codeware\mod-codeware-ui-core.md`
- `..\Knowledge\.kiro\steering\photomode-ex\research.md`
