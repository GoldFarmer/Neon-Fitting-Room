module NeonFittingRoom

/** Coordinates reusable card state without knowing how the host control is mounted. */
public class NfrExpandableCardPresenter extends IScriptable {
  public let model: ref<NfrExpandableCardControlModel>;
  public let browser: ref<NfrExpandableCardBrowser>;
  public let content: wref<inkCompoundWidget>;

  /** Initializes shared presentation state. @param model Model to present. @param rowRoot Host row.
   * @return True when initialized. @errors Invalid inputs return false. */
  public func Initialize(
    model: ref<NfrExpandableCardControlModel>,
    rowRoot: wref<inkCompoundWidget>
  ) -> Bool {
    if !IsDefined(model) || !IsDefined(rowRoot) { return false; }
    this.model = model;
    this.browser = new NfrExpandableCardBrowser();
    this.browser.Initialize(
      model.controlID,
      rowRoot,
      model.columnCount,
      model.cellSize,
      model.originX
    );
    this.browser.ConfigureGrid(NfrSettings.GetCardsPerRow());
    this.model.columnCount = this.browser.columnCount;
    this.model.cellSize = this.browser.cellSize;
    this.model.originX = this.browser.originX;
    return true;
  }

  /** Updates selection state. @param identity Active identity. @return None. @errors None. */
  public func SetActiveIdentity(identity: Int32) -> Void {
    if IsDefined(this.model) { this.model.activeIdentity = identity; }
  }

  /** Attaches arbitrary expandable content beneath the control row.
   * @param content Compound content owned by the caller. @return True when attached.
   * @errors Missing browser hosts or content return false. */
  public func SetContent(content: wref<inkCompoundWidget>) -> Bool {
    if !IsDefined(this.browser) || !IsDefined(this.browser.host) || !IsDefined(content) {
      return false;
    }
    content.Reparent(this.browser.host);
    this.content = content;
    this.browser.SetSurface(content);
    return true;
  }

  /** Releases retained presentation state. @param None. @return None. @errors None. */
  public func Reset() -> Void {
    if IsDefined(this.browser) { this.browser.Reset(); }
    this.content = null;
    this.browser = null;
    this.model = null;
  }
}
