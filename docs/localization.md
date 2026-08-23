# Localization

NFR registers player-visible text through Codeware's `ModLocalizationProvider` boundary.

- English definitions: `src/NeonFittingRoom/localization/NfrLocalization.reds`
- Typed UI accessors: `src/NeonFittingRoom/localization/NfrText.reds`
- Settings and UI code must request text through registered `NFR-*` keys rather than adding new
  player-visible literals.

## Adding a language

1. Create another `ModLocalizationPackage` containing every `NFR-*` key defined by the English
   package.
2. Update `NfrLocalizationProvider.GetPackage` to return that package for the applicable game
   language code.
3. Keep `GetFallback()` set to `en-us` so an incomplete translation remains readable.
4. Validate long labels in collapsed controls, cards, search fields, tooltips, and Mod Settings.

Item, outfit, category, pose, facial-expression, and NPC names supplied by the game or dependencies
remain owned by their source localization systems.
