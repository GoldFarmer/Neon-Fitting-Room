module NeonFittingRoom

/**
 * Defines Neon Fitting Room's ordered diagnostic severities.
 *
 * The levels distinguish development traces from recoverable and unrecoverable runtime conditions.
 */
public enum NfrLogLevel {
  Trace = 0,
  Debug = 1,
  Info = 2,
  Warn = 3,
  Error = 4
}

/**
 * Provides the stable Neon Fitting Room diagnostics facade.
 *
 * All NFR code uses this facade so generated debug and release backends remain interchangeable.
 */
public abstract class NfrLog {

  /**
   * Records detailed development trace information.
   *
   * @param message The trace message to emit when verbose logging is enabled.
   * @return None.
   * @errors None; logging failure handling belongs to the selected backend.
   */
  public static func Trace(message: String) {
    NfrLogBackend.Write(NfrLogLevel.Trace, message);
  }

  /**
   * Records detailed development completion information.
   *
   * @param message The debug message to emit when verbose logging is enabled.
   * @return None.
   * @errors None; logging failure handling belongs to the selected backend.
   */
  public static func Debug(message: String) {
    NfrLogBackend.Write(NfrLogLevel.Debug, message);
  }

  /**
   * Records a significant normal lifecycle event.
   *
   * @param message The informational message to emit.
   * @return None.
   * @errors None; logging failure handling belongs to the selected backend.
   */
  public static func Info(message: String) {
    NfrLogBackend.Write(NfrLogLevel.Info, message);
  }

  /**
   * Records a recoverable or unexpected runtime condition.
   *
   * @param message The warning message and selected recovery context.
   * @return None.
   * @errors None; logging failure handling belongs to the selected backend.
   */
  public static func Warn(message: String) {
    NfrLogBackend.Write(NfrLogLevel.Warn, message);
  }

  /**
   * Records an unrecoverable operation failure.
   *
   * @param message The error message and player-visible consequence.
   * @return None.
   * @errors None; logging failure handling belongs to the selected backend.
   */
  public static func Error(message: String) {
    NfrLogBackend.Write(NfrLogLevel.Error, message);
  }
}
