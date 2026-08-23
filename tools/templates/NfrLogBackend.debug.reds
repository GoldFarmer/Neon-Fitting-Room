module NeonFittingRoom

import Codeware.*

/**
 * Provides the debug diagnostics backend.
 *
 * The debug installer creates the shared native logging declarations only when they are absent.
 */
public abstract class NfrLogBackend {
  /**
   * Filters and writes one NFR diagnostic through the debug logging API.
   *
   * @param level The severity that controls filtering and the emitted prefix.
   * @param message The diagnostic message selected by the caller.
   * @return None.
   * @errors Missing shared logging declarations prevent debug REDscript compilation.
   */
  public static func Write(level: NfrLogLevel, message: String) -> Void {
    let formatted = s"[NFR] [\(NfrLogBackend.LevelName(level))] \(message)";
    if !NfrConfig.ShouldLog(level) { return; }
    switch level {
      case NfrLogLevel.Warn:
        FTLogWarning(formatted);
        break;
      case NfrLogLevel.Error:
        FTLogError(NfrLogBackend.FormatErrorMessage(formatted));
        break;
      default:
        FTLog(formatted);
    }
  }

  /**
   * Adds the direct NFR call site to a debug error message.
   *
   * @param formatted The severity-prefixed message produced by Write.
   * @return A message carrying the current NFR class and function when available.
   * @errors None; Codeware supplies the current call stack.
   */
  private static func FormatErrorMessage(formatted: String) -> String {
    let entries = GetStackTrace(3, true);
    let entry = entries[0];
    let trace = IsDefined(entry.object)
      ? s"[\(entry.class)][\(entry.function)]"
      : s"[\(entry.function)]";
    return s"\(trace) \(formatted)";
  }

  /**
   * Converts a severity value into its stable log prefix.
   *
   * @param level The severity to name.
   * @return The uppercase severity label, or ERROR for an unrecognized value.
   * @errors None.
   */
  private static func LevelName(level: NfrLogLevel) -> String {
    switch level {
      case NfrLogLevel.Trace: return "TRACE";
      case NfrLogLevel.Debug: return "DEBUG";
      case NfrLogLevel.Info: return "INFO";
      case NfrLogLevel.Warn: return "WARN";
      default: return "ERROR";
    }
  }
}
