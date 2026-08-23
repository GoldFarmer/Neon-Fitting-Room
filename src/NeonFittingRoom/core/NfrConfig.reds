module NeonFittingRoom

/**
 * Resolves Neon Fitting Room diagnostic configuration.
 *
 * Codeware owns this ScriptableService's lifecycle. The generated build profile supplies the
 * default before the service is registered or when no session override exists.
 */
public class NfrConfig extends ScriptableService {
  private let npcClothingEnabledForSession: Bool;

  /**
   * Obtains Codeware's registered Neon Fitting Room configuration service.
   *
   * @param None.
   * @return The configuration service, or null before Codeware service registration.
   * @errors None; callers fall back to the generated build-profile default.
   */
  public static func Get() -> ref<NfrConfig> {
    return GameInstance.GetScriptableServiceContainer().GetService(
      n"NeonFittingRoom.NfrConfig"
    ) as NfrConfig;
  }

  /**
   * Resolves the active verbose diagnostic setting.
   *
   * @param None.
   * @return True when a session override or build profile enables verbose logging.
   * @errors None.
   */
  public func IsVerboseLoggingEnabled() -> Bool {
    return NfrBuildProfile.IsVerboseLoggingEnabledByDefault();
  }

  /**
   * Determines whether a diagnostic severity reaches the selected logging backend.
   *
   * @param level The requested Neon Fitting Room diagnostic severity.
   * @return True for operational levels and for verbose levels enabled by configuration.
   * @errors None; early initialization uses the generated build-profile default.
   */
  public static func ShouldLog(level: NfrLogLevel) -> Bool {
    let config = NfrConfig.Get();

    switch level {
      case NfrLogLevel.Trace:
      case NfrLogLevel.Debug:
        if IsDefined(config) {
          return config.IsVerboseLoggingEnabled();
        }

        return NfrBuildProfile.IsVerboseLoggingEnabledByDefault();
      default:
        return true;
    }
  }

  /**
   * Sets the no-Mod-Settings NPC Clothing override for the current game process.
   *
   * This public service seam is callable from the Cyber Engine Tweaks console. The value is not
   * persisted, so the experimental feature returns to its safe disabled default after restart.
   *
   * @param enabled Whether experimental NPC Clothing is enabled for this game process.
   * @return The committed session value.
   * @errors None; installations with Mod Settings continue to use its persistent option instead.
   */
  public func SetNpcClothingEnabled(enabled: Bool) -> Bool {
    this.npcClothingEnabledForSession = enabled;
    return this.npcClothingEnabledForSession;
  }

  /**
   * Returns the current no-Mod-Settings NPC Clothing session override.
   *
   * @param None.
   * @return True only after the user enables the feature during this game process.
   * @errors None; the uninitialized value is false.
   */
  public func IsNpcClothingEnabledForSession() -> Bool {
    return this.npcClothingEnabledForSession;
  }
}
