module NeonFittingRoom

/**
 * Identifies a non-publishable NFR debug build and its diagnostic policy.
 */
public abstract class NfrBuildProfile {
  /**
   * Returns the installed build flavor.
   *
   * @param None.
   * @return The debug flavor label.
   * @errors None.
   */
  public static func GetFlavor() -> String { return "debug"; }

  /**
   * Returns this build's default verbose-log setting.
   *
   * @param None.
   * @return True because debug builds enable verbose diagnostics.
   * @errors None.
   */
  public static func IsVerboseLoggingEnabledByDefault() -> Bool { return true; }
}
