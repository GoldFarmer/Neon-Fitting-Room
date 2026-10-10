# Neon Fitting Room 0.1.2

This update makes clothing previews safer and keeps search input responsive in large Wardrobes.

- V clothing replacement now waits for the prior attachment to report complete removal before the
  new item is previewed. If removal does not complete within the safety timeout, NFR cancels the
  replacement instead of forcing overlapping attachments. Repeated clicks in the same slot are
  coalesced so the latest selection wins, and missing callbacks are reconciled against the actual
  puppet slot instead of leaving the control unresponsive.
- Malformed or stale Wardrobe entries are omitted when they do not resolve to a valid clothing
  record, appearance identity, Equipment-EX outfit slot, or equippable item.
- Every search field now uses the same 450-millisecond idle debounce.
- Clothing search checks unopened slot catalogs without constructing all of their card surfaces,
  preventing filtering work from interrupting continued typing.

The record checks can reject invalid metadata, but they cannot verify every packed mesh or
third-party garment dependency. Clothing mods still need their own required archives and framework
dependencies installed.
