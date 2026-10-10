module NeonFittingRoom

/**
 * Exposes the installed NFR source version without relying on archive or local-path metadata.
 *
 * @dependencies {
 *   "id": "redscript",
 *   "adopted": "0.5.31",
 *   "min": "TBD"
 * }
 *
 * @param None.
 * @return None.
 * @errors None.
 */
public abstract class NfrBuildMarker {

  /**
   * Returns the version shipped by this source tree.
   *
   * @param None.
   * @return The Neon Fitting Room version string.
   * @errors None.
   */
  public static func GetVersion() -> String {
    return "0.1.2";
  }
}
