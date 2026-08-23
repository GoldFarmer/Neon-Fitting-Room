module NeonFittingRoom

/**
 * Provides the release diagnostics backend.
 *
 * Release packages deliberately perform no native logging.
 */
public abstract class NfrLogBackend {
  /**
   * Ignores an NFR diagnostic in the release build.
   *
   * @param level The requested diagnostic severity.
   * @param message The selected diagnostic message.
   * @return None.
   * @errors None; release diagnostics intentionally have no native logging side effect.
   */
  public static func Write(level: NfrLogLevel, message: String) -> Void {}
}
