module NeonFittingRoom

/** Binds an expandable-card presenter to one existing native Photo Mode selector row. */
public class NfrPhotoModeNativeSelectorBinding extends IScriptable {
  public let presenter: ref<NfrExpandableCardPresenter>;
  public let attribute: Uint32;
  public let rowRoot: wref<inkCompoundWidget>;
  public let labelRoot: wref<inkWidget>;
  public let titleHit: wref<inkWidget>;
  public let optionHit: wref<inkWidget>;
  public let leftHit: wref<inkWidget>;
  public let rightHit: wref<inkWidget>;
  public let header: wref<inkHorizontalPanel>;
  public let labelAnchor: inkEAnchor;
  public let labelAnchorPoint: Vector2;
  public let labelMargin: inkMargin;
  public let labelTranslation: Vector2;
  public let labelHeight: Float;

  /** Mounts against one native selector. @param attribute Native attribute. @param model Card model.
   * @param rowRoot Native row. @param owner Callback owner. @param toggleCallback Toggle callback.
   * @param arrowCallback Arrow callback. @param hostName Host name. @param disclosureName Arrow name.
   * @param hostBottomMargin Spacing after the expansion host.
   * @return True when mounted. @errors Unexpected native structure returns false. */
  public func Mount(
    attribute: Uint32,
    model: ref<NfrExpandableCardControlModel>,
    rowRoot: wref<inkCompoundWidget>,
    owner: ref<IScriptable>,
    toggleCallback: CName,
    arrowCallback: CName,
    hostName: CName,
    disclosureName: CName,
    hostBottomMargin: Float
  ) -> Bool {
    let labelCompound: wref<inkCompoundWidget>;
    let selectorParent: wref<inkCompoundWidget>;
    let selector: wref<inkCompoundWidget>;
    let header: ref<inkHorizontalPanel>;
    let disclosure: ref<inkImage>;
    let margin: inkMargin;
    this.presenter = new NfrExpandableCardPresenter();
    if !this.presenter.Initialize(model, rowRoot) { return false; }
    this.attribute = attribute;
    this.rowRoot = rowRoot;
    this.labelRoot = rowRoot.GetWidgetByIndex(1);
    if !IsDefined(this.labelRoot) { return false; }
    this.labelAnchor = this.labelRoot.GetAnchor();
    this.labelAnchorPoint = this.labelRoot.GetAnchorPoint();
    this.labelMargin = this.labelRoot.GetMargin();
    this.labelTranslation = this.labelRoot.GetTranslation();
    this.labelHeight = this.labelRoot.GetHeight();
    labelCompound = this.labelRoot as inkCompoundWidget;
    if IsDefined(labelCompound) { this.titleHit = labelCompound.GetWidgetByIndex(0); }
    selectorParent = rowRoot.GetWidgetByIndex(3) as inkCompoundWidget;
    if IsDefined(selectorParent) { selector = selectorParent.GetWidgetByIndex(0) as inkCompoundWidget; }
    if IsDefined(selector) {
      this.leftHit = selector.GetWidgetByIndex(0);
      this.optionHit = selector.GetWidgetByIndex(1);
      this.rightHit = selector.GetWidgetByIndex(2);
    }
    if !this.presenter.browser.AttachSiblingHost(hostName) { return false; }
    this.presenter.browser.host.SetMargin(new inkMargin(0.0, 0.0, 0.0, hostBottomMargin));
    header = new inkHorizontalPanel();
    header.SetName(StringToName(s"nfr_\(NameToString(model.controlID))_browser_header"));
    header.SetSize(rowRoot.GetWidth(), 88.0);
    header.SetMargin(new inkMargin(0.0, -88.0, 0.0, 0.0));
    header.SetVAlign(inkEVerticalAlign.Center);
    header.SetOpacity(0.35);
    header.SetInteractive(false);
    disclosure = new inkImage();
    disclosure.SetName(disclosureName);
    disclosure.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
    disclosure.SetTexturePart(n"arrow_right_bg");
    disclosure.SetSize(56.0, 48.0);
    disclosure.SetVAlign(inkEVerticalAlign.Center);
    disclosure.SetMargin(new inkMargin(30.0, 20.0, 0.0, 0.0));
    disclosure.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
    disclosure.BindProperty(n"tintColor", n"MainColors.Red");
    disclosure.SetInteractive(true);
    disclosure.RegisterToCallback(n"OnRelease", owner, toggleCallback);
    disclosure.Reparent(header);
    this.presenter.browser.disclosure = disclosure;
    header.Reparent(this.presenter.browser.host);
    this.header = header;
    margin = this.labelRoot.GetMargin();
    this.labelRoot.SetMargin(new inkMargin(margin.left + 62.0, margin.top, margin.right, margin.bottom));
    if IsDefined(this.titleHit) {
      this.titleHit.SetInteractive(true);
      this.titleHit.RegisterToCallback(n"OnRelease", owner, toggleCallback);
    }
    if IsDefined(this.optionHit) {
      this.optionHit.SetInteractive(true);
      this.optionHit.RegisterToCallback(n"OnRelease", owner, toggleCallback);
    }
    if IsDefined(this.leftHit) && NotEquals(arrowCallback, n"") {
      this.leftHit.RegisterToCallback(n"OnRelease", owner, arrowCallback);
    }
    if IsDefined(this.rightHit) && NotEquals(arrowCallback, n"") {
      this.rightHit.RegisterToCallback(n"OnRelease", owner, arrowCallback);
    }
    return true;
  }

  /** Reapplies retained native geometry. @param None. @return None. @errors Missing widgets are ignored. */
  public func ReapplyLayout() -> Void {
    if !IsDefined(this.labelRoot) { return; }
    if IsDefined(this.presenter) && IsDefined(this.presenter.browser) {
      // Native Photo Mode conditionally hides complete selector rows. The synthetic header uses a
      // negative top margin to overlay its bound row, so leaving the host visible would overlay the
      // preceding row whenever the native row disappears.
      if IsDefined(this.presenter.browser.host) && IsDefined(this.rowRoot) {
        this.presenter.browser.host.SetVisible(this.rowRoot.IsVisible());
      }
    }
    this.labelRoot.SetAnchor(this.labelAnchor);
    this.labelRoot.SetAnchorPoint(this.labelAnchorPoint);
    this.labelRoot.SetMargin(new inkMargin(
      this.labelMargin.left + 62.0,
      this.labelMargin.top,
      this.labelMargin.right,
      this.labelMargin.bottom
    ));
    this.labelRoot.SetTranslation(this.labelTranslation);
    this.labelRoot.SetHeight(this.labelHeight);
  }

  /** Restores original native geometry. @param None. @return None. @errors Missing widgets are ignored. */
  public func RestoreLayout() -> Void {
    if !IsDefined(this.labelRoot) { return; }
    this.labelRoot.SetAnchor(this.labelAnchor);
    this.labelRoot.SetAnchorPoint(this.labelAnchorPoint);
    this.labelRoot.SetMargin(this.labelMargin);
    this.labelRoot.SetTranslation(this.labelTranslation);
    this.labelRoot.SetHeight(this.labelHeight);
  }

  /** Removes callbacks and restores layout. @param owner Callback owner.
   * @param toggleCallback Toggle callback. @param arrowCallback Arrow callback.
   * @return None. @errors Missing widgets are ignored. */
  public func Release(owner: ref<IScriptable>, toggleCallback: CName, arrowCallback: CName) -> Void {
    let headerParent: wref<inkCompoundWidget>;
    if IsDefined(this.titleHit) {
      this.titleHit.UnregisterFromCallback(n"OnRelease", owner, toggleCallback);
    }
    if IsDefined(this.optionHit) {
      this.optionHit.UnregisterFromCallback(n"OnRelease", owner, toggleCallback);
    }
    if IsDefined(this.leftHit) && NotEquals(arrowCallback, n"") {
      this.leftHit.UnregisterFromCallback(n"OnRelease", owner, arrowCallback);
    }
    if IsDefined(this.rightHit) && NotEquals(arrowCallback, n"") {
      this.rightHit.UnregisterFromCallback(n"OnRelease", owner, arrowCallback);
    }
    if IsDefined(this.presenter) && IsDefined(this.presenter.browser)
      && IsDefined(this.presenter.browser.disclosure) {
      this.presenter.browser.disclosure.UnregisterFromCallback(n"OnRelease", owner, toggleCallback);
    }
    // The synthetic header belongs to the adapter, not to the native row. Remove it explicitly so
    // a controller reused by a later Photo Mode session cannot retain a floating disclosure arrow.
    if IsDefined(this.header) {
      headerParent = this.header.GetParentWidget() as inkCompoundWidget;
      if IsDefined(headerParent) { headerParent.RemoveChild(this.header); }
      this.header = null;
    }
    this.RestoreLayout();
  }
}
