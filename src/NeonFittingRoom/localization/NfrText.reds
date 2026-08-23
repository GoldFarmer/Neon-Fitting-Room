module NeonFittingRoom

/** Resolves first-release UI text through Codeware's localization registry. */
public abstract class NfrText {
  /** @param key Registered localization key. @return Localized text. @errors English is the fallback. */
  private static func Resolve(key: CName) -> String { return GetLocalizedTextByKey(key); }

  /** @param None. @return Localized Outfit title. @errors English is the fallback. */
  public static func Outfit() -> String { return NfrText.Resolve(n"NFR-UI-Outfit"); }

  /** @param None. @return Localized Clothing title. @errors English is the fallback. */
  public static func Clothing() -> String { return NfrText.Resolve(n"NFR-UI-Clothing"); }

  /** @param None. @return Localized NPC component title. @errors English is the fallback. */
  public static func Npc() -> String { return NfrText.Resolve(n"NFR-UI-Npc"); }

  /** @param None. @return Localized empty-choice label. @errors English is the fallback. */
  public static func None() -> String { return NfrText.Resolve(n"NFR-UI-None"); }

  /** @param None. @return Localized Clear action. @errors English is the fallback. */
  public static func Clear() -> String { return NfrText.Resolve(n"NFR-UI-Clear"); }

  /** @param None. @return Localized Reset action. @errors English is the fallback. */
  public static func Reset() -> String { return NfrText.Resolve(n"NFR-UI-Reset"); }

  /** @param None. @return Localized card-search placeholder. @errors English is the fallback. */
  public static func Search() -> String { return NfrText.Resolve(n"NFR-UI-Search"); }

  /** Formats a localized Clothing summary.
   * @param count Active item count. @param custom Whether slot overrides are active.
   * @return Localized summary. @errors English is the fallback. */
  public static func ItemCount(count: Int32, custom: Bool) -> String {
    let value = NfrText.Resolve(custom ? n"NFR-UI-CustomItemCount" : n"NFR-UI-ItemCount");
    return StrReplace(value, "{count}", IntToString(count));
  }

}
