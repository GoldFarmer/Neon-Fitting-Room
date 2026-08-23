module NeonFittingRoom

/** Creates a completely NFR-owned Photo Mode control row and expandable host. */
public class NfrPhotoModeOwnedExpandableControl extends IScriptable {
  public let presenter: ref<NfrExpandableCardPresenter>;
  public let rowRoot: wref<inkCanvas>;
  public let titleHit: wref<inkWidget>;
  public let optionHit: wref<inkWidget>;
  public let leftHit: wref<inkWidget>;
  public let rightHit: wref<inkWidget>;
  public let titleLabel: wref<inkText>;
  public let optionLabel: wref<inkText>;

  /** Creates an owned row at a supplied list position.
   * @param model Card/control model. @param parent List parent. @param index Insertion index.
   * @param owner Callback owner. @param toggleCallback Disclosure callback.
   * @param leftCallback Previous-item callback. @param rightCallback Next-item callback.
   * @return True when mounted. @errors Missing model or parent returns false. */
  public func MountOwned(
    model: ref<NfrExpandableCardControlModel>,
    parent: wref<inkCompoundWidget>,
    index: Int32,
    owner: ref<IScriptable>,
    toggleCallback: CName,
    leftCallback: CName,
    rightCallback: CName,
    referenceRow: wref<inkCompoundWidget>,
    referenceDisclosure: wref<inkImage>,
    opt showValue: Bool
  ) -> Bool {
    let host: ref<inkVerticalPanel>;
    let row: ref<inkCanvas>;
    let border: ref<inkImage>;
    let fill: ref<inkImage>;
    let disclosure: ref<inkImage>;
    let title: ref<inkText>;
    let leftArrow: ref<inkImage>;
    let value: ref<inkText>;
    let rightArrow: ref<inkImage>;
    let rowSize = new Vector2(1500.0, 88.0);
    let disclosureSize = new Vector2(56.0, 48.0);
    // Owned rows do not inherit the native list item's internal left inset.
    let disclosurePosition = new Vector2(30.0, 20.0);
    let titleSize = new Vector2(168.0, 88.0);
    // The standalone text widget lacks the native label container's vertical layout offset.
    let titlePosition = new Vector2(90.0, 12.0);
    let titleFontSize: Int32 = 46;
    let hasSelector = showValue
      || ArraySize(model.items) > 0
      || NotEquals(leftCallback, n"")
      || NotEquals(rightCallback, n"");
    if !IsDefined(model) || !IsDefined(parent) { return false; }
    if IsDefined(referenceRow) {
      rowSize = referenceRow.GetSize();
    }
    if IsDefined(referenceDisclosure) {
      disclosureSize = referenceDisclosure.GetSize();
    }
    host = new inkVerticalPanel();
    host.SetName(StringToName(s"nfr_\(NameToString(model.controlID))_owned_host"));
    host.SetFitToContent(true);
    host.SetWidth(rowSize.X);
    host.SetInteractive(false);
    host.Reparent(parent, index);
    row = new inkCanvas();
    row.SetName(StringToName(s"nfr_\(NameToString(model.controlID))_owned_row"));
    row.SetSize(rowSize.X, rowSize.Y);
    row.SetInteractive(false);
    row.Reparent(host);
    this.presenter = new NfrExpandableCardPresenter();
    if !this.presenter.Initialize(model, row) {
      return false;
    }
    this.presenter.browser.host = host;
    this.rowRoot = row;
    // Match the native PhotoModeMenuListItem frame/background construction. These are
    // nine-sliced atlas images with a list-item inset, not full-row rectangles.
    border = new inkImage();
    border.SetAnchor(inkEAnchor.Fill);
    border.SetMargin(new inkMargin(10.0, 0.0, 10.0, 5.0));
    border.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
    border.SetTexturePart(n"color_fg");
    border.SetNineSliceScale(true);
    border.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
    // A native controller promotes the serialized darker binding into its effective row state.
    // Owned rows have no PhotoModeMenuListItem controller, so bind the visible foreground directly.
    border.BindProperty(n"tintColor", n"MainColors.Red");
    border.Reparent(row);
    fill = new inkImage();
    fill.SetAnchor(inkEAnchor.Fill);
    fill.SetMargin(new inkMargin(10.0, 0.0, 10.0, 5.0));
    fill.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
    fill.SetTexturePart(n"color_bg");
    fill.SetNineSliceScale(true);
    fill.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
    fill.BindProperty(n"tintColor", n"MainColors.Fullscreen_PrimaryBackgroundDarkest");
    fill.SetOpacity(0.90);
    fill.Reparent(row);
    this.titleHit = this.CreateOwnedHit(row, n"owned_title_hit", 0.0, 250.0, owner, toggleCallback);
    disclosure = this.CreateOwnedArrow(
      this.titleHit as inkCompoundWidget,
      n"arrow_right_bg",
      disclosurePosition.X,
      disclosurePosition.Y
    );
    disclosure.SetSize(disclosureSize.X, disclosureSize.Y);
    disclosure.SetName(StringToName(s"nfr_\(NameToString(model.controlID))_owned_disclosure"));
    this.presenter.browser.disclosure = disclosure;
    title = new inkText();
    title.SetText(model.title);
    title.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
    title.SetFontStyle(n"Regular");
    title.SetFontSize(titleFontSize);
    title.SetTranslation(titlePosition);
    title.SetSize(titleSize.X, titleSize.Y);
    title.SetVerticalAlignment(textVerticalAlignment.Center);
    title.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
    title.BindProperty(n"tintColor", n"MainColors.ActiveRed");
    title.SetInteractive(false);
    title.Reparent(this.titleHit as inkCompoundWidget);
    this.titleLabel = title;
    if NotEquals(leftCallback, n"") {
      this.leftHit = this.CreateOwnedHit(row, n"owned_left_hit", 530.0, 100.0, owner, leftCallback);
      leftArrow = this.CreateOwnedArrow(
        this.leftHit as inkCompoundWidget,
        n"arrow_left_bg",
        18.0,
        23.0
      );
      leftArrow.SetSize(64.0, 40.0);
    }
    // A content-only group header has no current value. Slot controls populate model items and
    // opt into the centered active-item summary; their nonempty callbacks also create previous and
    // next arrows that cycle through this same ordered model while collapsed or expanded.
    if hasSelector {
      this.optionHit = this.CreateOwnedHit(row, n"owned_option_hit", 630.0, 697.0, owner, toggleCallback);
      value = new inkText();
      value.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
      value.SetFontStyle(n"Regular");
      value.SetFontSize(40);
      value.SetAnchor(inkEAnchor.Fill);
      value.SetHorizontalAlignment(textHorizontalAlignment.Center);
      value.SetVerticalAlignment(textVerticalAlignment.Center);
      value.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
      value.BindProperty(n"tintColor", n"MainColors.ActiveRed");
      value.SetInteractive(false);
      value.Reparent(this.optionHit as inkCompoundWidget);
      this.optionLabel = value;
    }
    if NotEquals(rightCallback, n"") {
      this.rightHit = this.CreateOwnedHit(row, n"owned_right_hit", 1327.0, 100.0, owner, rightCallback);
      rightArrow = this.CreateOwnedArrow(
        this.rightHit as inkCompoundWidget,
        n"arrow_right_bg",
        18.0,
        23.0
      );
      rightArrow.SetSize(64.0, 40.0);
    }
    this.SyncOwnedValueLabel();
    return true;
  }

  /** Updates the owned value label from the active model identity. @param None. @return None.
   * @errors Missing model or label state is ignored. */
  public func SyncOwnedValueLabel() -> Void {
    let index: Int32;
    if !IsDefined(this.presenter) || !IsDefined(this.presenter.model) || !IsDefined(this.optionLabel) { return; }
    index = this.presenter.model.FindIndex(this.presenter.model.activeIdentity);
    this.optionLabel.SetText(index >= 0 ? this.presenter.model.items[index].label : "");
  }

  /** Creates a fit-to-content child-control container as this control's expandable content.
   * @param name Stable widget name. @param topMargin Space below the owning header.
   * @return The attached container, or null when the presenter is unavailable.
   * @errors Invalid presenter state returns null without changing the widget tree. */
  public func CreateChildContainer(name: CName, topMargin: Float) -> wref<inkVerticalPanel> {
    let container: ref<inkVerticalPanel>;
    if !IsDefined(this.presenter) { return null; }
    container = new inkVerticalPanel();
    container.SetName(name);
    container.SetFitToContent(true);
    container.SetWidth(1500.0);
    container.SetMargin(new inkMargin(0.0, topMargin, 0.0, 0.0));
    container.SetInteractive(false);
    if !this.presenter.SetContent(container) { return null; }
    return container;
  }

  /** Indents the disclosure and title hit region without moving selector arrows or the value.
   * @param indent Horizontal offset from the row's normal title origin. @return None.
   * @errors A missing title region is ignored. */
  public func SetTitleIndent(indent: Float) -> Void {
    if IsDefined(this.titleHit) {
      this.titleHit.SetTranslation(new Vector2(indent, 0.0));
    }
  }

  /** Creates one owned hit surface. @param parent Owning row. @param name Widget name.
   * @param x Horizontal origin. @param width Hit width. @param owner Callback owner.
   * @param callback Release callback. @return Created hit surface. @errors None. */
  private func CreateOwnedHit(
    parent: wref<inkCompoundWidget>,
    name: CName,
    x: Float,
    width: Float,
    owner: ref<IScriptable>,
    callback: CName
  ) -> wref<inkCanvas> {
    let hit = new inkCanvas();
    hit.SetName(name);
    hit.SetTranslation(new Vector2(x, 0.0));
    hit.SetSize(width, 88.0);
    hit.SetInteractive(true);
    if NotEquals(callback, n"") { hit.RegisterToCallback(n"OnRelease", owner, callback); }
    hit.Reparent(parent);
    return hit;
  }

  /** Creates one Photo Mode arrow image inside an owned hit surface.
   * @param parent Hit surface. @param part Atlas part. @param x Horizontal origin.
   * @param y Vertical origin. @return Created image. @errors None. */
  private func CreateOwnedArrow(
    parent: wref<inkCompoundWidget>,
    part: CName,
    x: Float,
    y: Float
  ) -> ref<inkImage> {
    let arrow = new inkImage();
    arrow.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
    arrow.SetTexturePart(part);
    arrow.SetTranslation(new Vector2(x, y));
    arrow.SetSize(56.0, 48.0);
    arrow.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
    arrow.BindProperty(n"tintColor", n"MainColors.Red");
    // Native selector ancestry contributes an additional tint multiplier that owned rows lack.
    arrow.SetOpacity(0.45);
    arrow.SetInteractive(false);
    arrow.Reparent(parent);
    return arrow;
  }

  /** Unregisters owned-row input before its containing UI tree is destroyed.
   * @param owner Callback owner. @param toggleCallback Disclosure callback.
   * @param leftCallback Previous callback. @param rightCallback Next callback.
   * @return None. @errors Missing widgets are skipped. */
  public func ReleaseOwnedHooks(
    owner: ref<IScriptable>,
    toggleCallback: CName,
    leftCallback: CName,
    rightCallback: CName
  ) -> Void {
    if IsDefined(this.titleHit) {
      this.titleHit.UnregisterFromCallback(n"OnRelease", owner, toggleCallback);
    }
    if IsDefined(this.optionHit) {
      this.optionHit.UnregisterFromCallback(n"OnRelease", owner, toggleCallback);
    }
    if IsDefined(this.leftHit) && NotEquals(leftCallback, n"") {
      this.leftHit.UnregisterFromCallback(n"OnRelease", owner, leftCallback);
    }
    if IsDefined(this.rightHit) && NotEquals(rightCallback, n"") {
      this.rightHit.UnregisterFromCallback(n"OnRelease", owner, rightCallback);
    }
  }
}
