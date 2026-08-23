module NeonFittingRoom

/**
 * Owns the reusable widget state and grid geometry for one expandable Photo Mode card browser.
 * The consuming adapter remains responsible for item data, activation, and native selection sync.
 */
public class NfrExpandableCardBrowser extends IScriptable {
  public let controlID: CName;
  public let rowRoot: wref<inkCompoundWidget>;
  public let host: wref<inkVerticalPanel>;
  public let surface: wref<inkWidget>;
  public let disclosure: wref<inkImage>;
  public let cards: array<wref<inkWidget>>;
  public let isExpanded: Bool;
  public let rowHeight: Float;
  public let contentHeight: Float;
  public let columnCount: Int32;
  public let cellSize: Float;
  public let originX: Float;
  public let suppressOwnSearch: Bool;
  public let searchQuery: String;

  /**
   * Initializes one browser from a native Photo Mode row.
   * @param controlID Stable adapter identity used in generated widget names.
   * @param rowRoot Native control-row root retained at its original height.
   * @param columnCount Number of cards in each row.
   * @param cellSize Width and height of each card hit cell.
   * @param originX Horizontal grid origin within the native row.
   * @return None.
   * @errors Invalid geometry is retained for caller validation rather than silently altered.
   */
  public func Initialize(
    controlID: CName,
    rowRoot: wref<inkCompoundWidget>,
    columnCount: Int32,
    cellSize: Float,
    originX: Float
  ) -> Void {
    this.controlID = controlID;
    this.rowRoot = rowRoot;
    this.rowHeight = IsDefined(rowRoot) ? rowRoot.GetHeight() : 0.0;
    this.columnCount = columnCount;
    this.cellSize = cellSize;
    this.originX = originX;
    this.contentHeight = cellSize;
    this.isExpanded = false;
  }

  /** Derives centered square-card geometry from a requested column count and measured row width.
   * The established nine-column layout occupies 1458 virtual units; narrower hosts reduce that
   * width rather than overflowing. @param columns Requested cards per row. @return None.
   * @errors Invalid counts use nine and unavailable widths retain the established grid width. */
  public func ConfigureGrid(columns: Int32) -> Void {
    let rowWidth: Float = IsDefined(this.rowRoot) ? this.rowRoot.GetWidth() : 0.0;
    let gridWidth: Float = 1458.0;
    if columns < 1 { columns = 9; }
    if rowWidth > 24.0 && rowWidth - 24.0 < gridWidth { gridWidth = rowWidth - 24.0; }
    this.columnCount = columns;
    this.cellSize = gridWidth / Cast<Float>(columns);
    this.originX = rowWidth > 0.0 ? (rowWidth - gridWidth) * 0.5 : 12.0;
    // Search owns compact visible-card positions until its query is cleared.
    if Equals(this.searchQuery, "") { this.ReflowCards(); }
  }

  /** Repositions and uniformly scales every retained compiled card to current grid geometry.
   * @param None. @return None. @errors Invalid geometry leaves cards unchanged. */
  public func ReflowCards() -> Void {
    let scale: Float;
    let index: Int32;
    if this.columnCount <= 0 || this.cellSize <= 0.0 { return; }
    scale = this.cellSize / 162.0;
    while index < ArraySize(this.cards) {
      this.cards[index].SetScale(Vector2(scale, scale));
      this.cards[index].SetTranslation(Vector2(
        this.originX + Cast<Float>(index % this.columnCount) * this.cellSize,
        Cast<Float>(index / this.columnCount) * this.cellSize
      ));
      index += 1;
    }
  }

  /**
   * Inserts an NFR-owned fit-to-content host after the native row without moving that row.
   * @param hostName Project-owned widget name.
   * @return True when the sibling host exists after the call.
   * @errors Missing parents or row membership leave the native row untouched and return false.
   */
  public func AttachSiblingHost(hostName: CName) -> Bool {
    let parent: wref<inkCompoundWidget>;
    let created: ref<inkVerticalPanel>;
    let index: Int32 = 0;
    let count: Int32;
    if IsDefined(this.host) { return true; }
    if !IsDefined(this.rowRoot) { return false; }
    parent = this.rowRoot.GetParentWidget() as inkCompoundWidget;
    if !IsDefined(parent) { return false; }
    count = parent.GetNumChildren();
    while index < count && !Equals(parent.GetWidgetByIndex(index), this.rowRoot) { index += 1; }
    if index >= count { return false; }
    created = new inkVerticalPanel();
    created.SetName(hostName);
    created.SetFitToContent(true);
    created.SetWidth(this.rowRoot.GetWidth());
    created.SetInteractive(false);
    created.Reparent(parent, index + 1);
    this.host = created;
    return true;
  }

  /** Toggles expansion. @param None. @return The new expanded state. @errors None. */
  public func Toggle() -> Bool {
    this.ConfigureGrid(NfrSettings.GetCardsPerRow());
    if IsDefined(this.surface) {
      this.surface.SetHeight(
        Equals(this.searchQuery, "") ? this.MeasureContentHeight() : this.contentHeight
      );
    }
    return this.SetExpanded(!this.isExpanded);
  }

  /** Applies an explicit expansion state for accordion coordination.
   * @param expanded Desired state. @return Applied state. @errors None. */
  public func SetExpanded(expanded: Bool) -> Bool {
    this.isExpanded = expanded;
    this.UpdateDisclosure();
    this.UpdateSurfaceVisibility();
    return this.isExpanded;
  }

  /**
   * Updates the disclosure texture without changing its bounds.
   * @param None. @return None. @errors Missing disclosure widgets are ignored.
   */
  public func UpdateDisclosure() -> Void {
    if IsDefined(this.disclosure) {
      this.disclosure.SetTexturePart(this.isExpanded ? n"arrow_down_bg" : n"arrow_right_bg");
    }
  }

  /**
   * Retains the generic card surface and applies current visibility.
   * @param surface Card-surface root created by the adapter.
   * @return None.
   * @errors Null surfaces are retained as unavailable.
   */
  public func SetSurface(surface: wref<inkWidget>) -> Void {
    this.surface = surface;
    this.UpdateSurfaceVisibility();
  }

  /** Shows or hides the card surface. @param None. @return None. @errors Missing surfaces are ignored. */
  public func UpdateSurfaceVisibility() -> Void {
    if IsDefined(this.surface) { this.surface.SetVisible(this.isExpanded); }
    if IsDefined(this.rowRoot) { this.rowRoot.SetHeight(this.rowHeight); }
  }

  /**
   * Positions and retains one adapter-created card in the shared grid.
   * @param card Card root whose complete cell remains interactive.
   * @return Zero-based card index, or -1 for an unavailable card.
   * @errors Null cards are rejected without changing the collection.
   */
  public func AddCard(card: wref<inkWidget>) -> Int32 {
    let index = ArraySize(this.cards);
    let scale: Float;
    if !IsDefined(card) || this.columnCount <= 0 { return -1; }
    scale = this.cellSize / 162.0;
    card.SetScale(Vector2(scale, scale));
    card.SetTranslation(new Vector2(
      this.originX + Cast<Float>(index % this.columnCount) * this.cellSize,
      Cast<Float>(index / this.columnCount) * this.cellSize
    ));
    ArrayPush(this.cards, card);
    return index;
  }

  /**
   * Recomputes the complete grid height from retained cards.
   * @param None. @return Calculated content height. @errors Invalid geometry returns zero.
   */
  public func MeasureContentHeight() -> Float {
    let rows: Int32;
    if this.columnCount <= 0 || this.cellSize <= 0.0 { return 0.0; }
    rows = (ArraySize(this.cards) + this.columnCount - 1) / this.columnCount;
    if rows < 1 { rows = 1; }
    this.contentHeight = Cast<Float>(rows) * this.cellSize;
    return this.contentHeight;
  }

  /** Clears retained runtime widgets after their owner unregisters callbacks. */
  public func Reset() -> Void {
    ArrayClear(this.cards);
    this.disclosure = null;
    this.surface = null;
    this.host = null;
    this.rowRoot = null;
    this.isExpanded = false;
    this.rowHeight = 0.0;
    this.contentHeight = 0.0;
  }
}
