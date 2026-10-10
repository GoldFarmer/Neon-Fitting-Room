module NeonFittingRoom.Localization

import Codeware.Localization.*

/** Defines the first-release English localization package. */
public class NfrEnglishLocalization extends ModLocalizationPackage {

  /** Registers English NFR text. @param None. @return None. @errors None. */
  protected func DefineTexts() -> Void {
    this.Text("NFR-Mod-Name", "Neon Fitting Room");
    this.Text("NFR-Settings-Interface", "Interface");
    this.Text("NFR-Settings-CardTooltips", "Enable Tooltips");
    this.Text(
      "NFR-Settings-CardTooltips-Description",
      "Show names and available details when hovering over fitting-room cards."
    );
    this.Text("NFR-Settings-OutfitIcons", "Enable Outfit Icons");
    this.Text(
      "NFR-Settings-OutfitIcons-Description",
      "Show significant clothing-item icon collages on outfit cards."
    );
    this.Text("NFR-Settings-CardsPerRow", "Cards Per Row");
    this.Text(
      "NFR-Settings-CardsPerRow-Description",
      "Choose how many cards appear across expandable panels. Fewer cards are displayed larger."
    );
    this.Text("NFR-Settings-Experimental", "Experimental");
    this.Text("NFR-Settings-NpcClothing", "Enable NPC Clothing");
    this.Text(
      "NFR-Settings-NpcClothing-Description",
      "Experimental. Clothing may clip on unsupported NPC bodies."
    );
    this.Text("NFR-UI-Outfit", "OUTFIT");
    this.Text("NFR-UI-Clothing", "CLOTHING");
    this.Text("NFR-UI-Npc", "NPC");
    this.Text("NFR-UI-None", "NONE");
    this.Text("NFR-UI-Clear", "CLEAR");
    this.Text("NFR-UI-Reset", "RESET");
    this.Text("NFR-UI-Search", "Search");
    this.Text("NFR-UI-ItemCount", "{count} ITEMS");
    this.Text("NFR-UI-CustomItemCount", "CUSTOM ({count} ITEMS)");
  }
}

/** Supplies localized NFR text and falls back to English for unsupported languages. */
public class NfrLocalizationProvider extends ModLocalizationProvider {

  /** Resolves a language package. @param language Active language.
   * @return English package. @errors Unsupported languages use English. */
  public func GetPackage(language: CName) -> ref<ModLocalizationPackage> {
    return new NfrEnglishLocalization();
  }

  /** Declares English as the fallback. @param None. @return English language code. @errors None. */
  public func GetFallback() -> CName { return n"en-us"; }
}
