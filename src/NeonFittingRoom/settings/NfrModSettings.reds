module NeonFittingRoom

/** Declares Neon Fitting Room's persistent user choices when Mod Settings is installed. */
@if(ModuleExists("ModSettingsModule"))
public class NfrModSettings {
  @runtimeProperty("ModSettings.mod", "NFR-Mod-Name")
  @runtimeProperty("ModSettings.category", "NFR-Settings-Interface")
  @runtimeProperty("ModSettings.category.order", "0")
  @runtimeProperty("ModSettings.displayName", "NFR-Settings-CardTooltips")
  @runtimeProperty("ModSettings.description", "NFR-Settings-CardTooltips-Description")
  @runtimeProperty("ModSettings.order", "1")
  public let enableCardTooltips: Bool = true;

  @runtimeProperty("ModSettings.mod", "NFR-Mod-Name")
  @runtimeProperty("ModSettings.category", "NFR-Settings-Interface")
  @runtimeProperty("ModSettings.category.order", "0")
  @runtimeProperty("ModSettings.displayName", "NFR-Settings-OutfitIcons")
  @runtimeProperty("ModSettings.description", "NFR-Settings-OutfitIcons-Description")
  @runtimeProperty("ModSettings.order", "2")
  public let enableOutfitIcons: Bool = true;

  @runtimeProperty("ModSettings.mod", "NFR-Mod-Name")
  @runtimeProperty("ModSettings.category", "NFR-Settings-Interface")
  @runtimeProperty("ModSettings.category.order", "0")
  @runtimeProperty("ModSettings.displayName", "NFR-Settings-CardsPerRow")
  @runtimeProperty("ModSettings.description", "NFR-Settings-CardsPerRow-Description")
  @runtimeProperty("ModSettings.order", "3")
  @runtimeProperty("ModSettings.step", "1")
  @runtimeProperty("ModSettings.min", "6")
  @runtimeProperty("ModSettings.max", "10")
  public let cardsPerRow: Int32 = 8;

  @runtimeProperty("ModSettings.mod", "NFR-Mod-Name")
  @runtimeProperty("ModSettings.category", "NFR-Settings-Experimental")
  @runtimeProperty("ModSettings.category.order", "1")
  @runtimeProperty("ModSettings.displayName", "NFR-Settings-NpcClothing")
  @runtimeProperty("ModSettings.description", "NFR-Settings-NpcClothing-Description")
  @runtimeProperty("ModSettings.order", "1")
  public let enableNpcClothing: Bool = false;
}

/** Resolves optional Mod Settings values behind a stable, safe-default boundary. */
public abstract class NfrSettings {
  /** Returns the global number of cards rendered per expandable-browser row.
   * @param None. @return Committed value clamped to the supported range.
   * @errors Missing settings preserve the eight-card default. */
  @if(ModuleExists("ModSettingsModule"))
  public static func GetCardsPerRow() -> Int32 {
    let settings = ModSettings.GetVars(n"NFR-Mod-Name", n"NFR-Settings-Interface");
    let setting: ref<ModConfigVarInt32>;
    let index: Int32;
    while index < ArraySize(settings) {
      setting = settings[index] as ModConfigVarInt32;
      if IsDefined(setting) && Equals(setting.GetName(), n"cardsPerRow") {
        return Max(6, Min(10, setting.GetValue()));
      }
      index += 1;
    }
    return 8;
  }

  /** Preserves the eight-card default when Mod Settings is unavailable.
   * @param None. @return Eight. @errors None. */
  @if(!ModuleExists("ModSettingsModule"))
  public static func GetCardsPerRow() -> Int32 { return 8; }

  /** Returns whether outfit-card icon collages are enabled.
   * @param None. @return The committed value. @errors Missing settings preserve the enabled default. */
  @if(ModuleExists("ModSettingsModule"))
  public static func AreOutfitIconsEnabled() -> Bool {
    let settings = ModSettings.GetVars(n"NFR-Mod-Name", n"NFR-Settings-Interface");
    let setting: ref<ModConfigVarBool>;
    let index: Int32;
    while index < ArraySize(settings) {
      setting = settings[index] as ModConfigVarBool;
      if IsDefined(setting) && Equals(setting.GetName(), n"enableOutfitIcons") {
        return setting.GetValue();
      }
      index += 1;
    }
    return true;
  }

  /** Preserves the enabled default when Mod Settings is unavailable.
   * @param None. @return True. @errors None. */
  @if(!ModuleExists("ModSettingsModule"))
  public static func AreOutfitIconsEnabled() -> Bool { return true; }

  /** Returns whether hover tooltips are enabled for NFR cards.
   * @param None. @return The committed value. @errors Missing settings preserve the enabled default. */
  @if(ModuleExists("ModSettingsModule"))
  public static func AreCardTooltipsEnabled() -> Bool {
    let settings = ModSettings.GetVars(n"NFR-Mod-Name", n"NFR-Settings-Interface");
    let setting: ref<ModConfigVarBool>;
    let index: Int32;
    while index < ArraySize(settings) {
      setting = settings[index] as ModConfigVarBool;
      if IsDefined(setting) && Equals(setting.GetName(), n"enableCardTooltips") {
        return setting.GetValue();
      }
      index += 1;
    }
    return true;
  }

  /** Preserves the enabled default when Mod Settings is unavailable.
   * @param None. @return True. @errors None. */
  @if(!ModuleExists("ModSettingsModule"))
  public static func AreCardTooltipsEnabled() -> Bool { return true; }

  /** Returns whether the complete experimental NPC Clothing feature is enabled.
   * @param None. @return The committed opt-in value. @errors Missing settings default to false. */
  @if(ModuleExists("ModSettingsModule"))
  public static func IsNpcClothingEnabled() -> Bool {
    let settings = ModSettings.GetVars(n"NFR-Mod-Name", n"NFR-Settings-Experimental");
    let setting: ref<ModConfigVarBool>;
    let index: Int32;
    while index < ArraySize(settings) {
      setting = settings[index] as ModConfigVarBool;
      if IsDefined(setting) && Equals(setting.GetName(), n"enableNpcClothing") {
        return setting.GetValue();
      }
      index += 1;
    }
    return false;
  }

  /** Resolves the process-local CET override when Mod Settings is unavailable.
   * @param None. @return The session override, disabled by default.
   * @errors Missing or early configuration services safely return false. */
  @if(!ModuleExists("ModSettingsModule"))
  public static func IsNpcClothingEnabled() -> Bool {
    let config = NfrConfig.Get();
    return IsDefined(config) && config.IsNpcClothingEnabledForSession();
  }
}
