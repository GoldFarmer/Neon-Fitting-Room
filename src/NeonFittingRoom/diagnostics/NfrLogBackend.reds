module NeonFittingRoom

/**
 * Provides the default release diagnostics backend.
 *
 * Packaging replaces this file with the selected build-flavor backend. The release backend has no
 * native logging references, so release packages need no shared debug logging declarations.
 */
public abstract class NfrLogBackend {

  /**
   * Ignores a Neon Fitting Room diagnostic in the release build.
   *
   * @param level The requested diagnostic severity.
   * @param message The selected diagnostic message.
   * @return None.
   * @errors None; release diagnostics intentionally have no native logging side effect.
   */
  public static func Write(level: NfrLogLevel, message: String) -> Void {}
}
