module NeonFittingRoom

/**
 * Identifies a publishable NFR build and its diagnostic policy.
 */
public abstract class NfrBuildProfile {
  /**
   * Returns the installed build flavor.
   *
   * @param None.
   * @return The release flavor label.
   * @errors None.
   */
  public static func GetFlavor() -> String { return "release"; }

  /**
   * Returns this build's default verbose-log setting.
   *
   * @param None.
   * @return False because release builds suppress verbose diagnostics.
   * @errors None.
   */
  public static func IsVerboseLoggingEnabledByDefault() -> Bool { return false; }
}
