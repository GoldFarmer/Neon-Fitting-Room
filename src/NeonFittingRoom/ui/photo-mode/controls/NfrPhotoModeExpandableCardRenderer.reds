module NeonFittingRoom

/** Builds labeled Photo Mode cards from either owned or native expandable-control models.
 *
 * @dependencies {
 *   "id": "cp2077",
 *   "adopted": "2.31",
 *   "min": "TBD"
 * }
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 *
 * @param control Mounted control. @param callbackOwner Card callback owner.
 * @param cardCallback Card activation callback. @return True when rebuilt.
 * @errors Missing model, browser, or host state returns false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func RebuildNfrExpandableCardControl(
  control: ref<NfrExpandableCardPresenter>,
  callbackOwner: ref<IScriptable>,
  cardCallback: CName
) -> Bool {
  let wrapper: ref<inkCanvas>;
  let height: Float;
  let labels: array<String>;
  let utilityCount: Int32;
  let index: Int32 = 0;
  if !IsDefined(control)
    || !IsDefined(control.model)
    || !IsDefined(control.browser)
    || !IsDefined(control.browser.host) {
    return false;
  }
  control.browser.ConfigureGrid(NfrSettings.GetCardsPerRow());
  control.model.columnCount = control.browser.columnCount;
  control.model.cellSize = control.browser.cellSize;
  control.model.originX = control.browser.originX;
  if !IsDefined(control.content) {
    wrapper = new inkCanvas();
    wrapper.SetName(StringToName(
      s"nfr_\(NameToString(control.model.controlID))_card_surface"
    ));
    wrapper.SetAnchor(inkEAnchor.TopLeft);
    wrapper.SetAnchorPoint(Vector2(0.0, 0.0));
    wrapper.SetSize(control.browser.rowRoot.GetWidth(), control.model.cellSize);
    wrapper.SetMargin(new inkMargin(0.0, control.model.contentTopMargin, 0.0, 0.0));
    wrapper.SetInteractive(true);
    wrapper.Reparent(control.browser.host);
    control.SetContent(wrapper);
  } else {
    this.DetachNfrCardSearchForRebuild(control.browser);
    while index < ArraySize(control.browser.cards) {
      this.UnregisterNfrCardTooltipCallbacks(control.browser.cards[index]);
      control.browser.cards[index].UnregisterFromCallback(
        n"OnRelease",
        callbackOwner,
        cardCallback
      );
      index += 1;
    }
    control.content.RemoveAllChildren();
  }
  ArrayClear(control.browser.cards);
  index = 0;
  while index < ArraySize(control.model.items) {
    this.CreateNfrExpandableCard(
      control,
      control.model.items[index],
      callbackOwner,
      cardCallback
    );
    ArrayPush(labels, control.model.items[index].label);
    index += 1;
  }
  height = control.browser.MeasureContentHeight();
  control.content.SetHeight(height);
  control.browser.SetSurface(control.content);
  if ArraySize(labels) > 0 && Equals(StrLower(labels[0]), StrLower(NfrText.None())) {
    utilityCount = 1;
  }
  if control.browser.suppressOwnSearch {
    this.RefreshNfrClothingGroupSearchForBrowser(control.browser);
  } else {
    this.EnsureNfrCardSearch(
      control.browser,
      control.content,
      control.content,
      false,
      labels,
      utilityCount
    );
  }
  return true;
}

/** Creates one card and binds its array position to the supplied item model.
 *
 * @dependencies {
 *   "id": "cp2077",
 *   "adopted": "2.31",
 *   "min": "TBD"
 * }
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 *
 * @param control Owning expandable control. @param item Item to display.
 * @param callbackOwner Activation owner. @param cardCallback Activation callback.
 * @return Card root or null. @errors A failed compiled-template spawn returns null. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CreateNfrExpandableCard(
  control: ref<NfrExpandableCardPresenter>,
  item: ref<NfrExpandableCardItemModel>,
  callbackOwner: ref<IScriptable>,
  cardCallback: CName
) -> wref<inkWidget> {
  let card: wref<inkWidget>;
  let root: wref<inkCompoundWidget>;
  let label: ref<inkText>;
  let icon: ref<inkImage>;
  let plus: wref<inkWidget>;
  let index = ArraySize(control.browser.cards);
  card = this.SpawnFromExternal(
    control.content,
    r"nfr\\ui\\nfr_photomode_static_panel.inkwidget",
    n"Card"
  );
  root = card as inkCompoundWidget;
  if !IsDefined(root) { return null; }
  card.SetName(StringToName(
    s"nfr_\(NameToString(control.model.controlID))_card_\(index)"
  ));
  card.SetAnchor(inkEAnchor.TopLeft);
  card.SetAnchorPoint(Vector2(0.0, 0.0));
  card.SetOpacity(1.0);
  card.SetState(item.isEnabled ? n"Default" : n"Disabled");
  card.SetInteractive(item.isEnabled);
  if item.isEnabled && NotEquals(cardCallback, n"") {
    card.RegisterToCallback(n"OnRelease", callbackOwner, cardCallback);
  }
  plus = root.GetWidgetByPathName(n"plusImg");
  if IsDefined(plus) { plus.SetVisible(false); }
  if NotEquals(item.iconPart, n"") {
    icon = new inkImage();
    icon.SetName(n"nfrExpandableCardIcon");
    icon.SetAtlasResource(item.iconAtlas);
    icon.SetTexturePart(item.iconPart);
    icon.SetAnchor(inkEAnchor.Centered);
    icon.SetAnchorPoint(new Vector2(0.5, 0.5));
    icon.SetSize(136.0, 136.0);
    icon.SetInteractive(false);
    icon.Reparent(root);
  }
  label = new inkText();
  label.SetName(n"nfrExpandableCardLabel");
  label.SetText(item.label);
  label.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
  label.SetFontStyle(n"Regular");
  label.SetFontSize(30);
  label.SetAnchor(inkEAnchor.Fill);
  label.SetMargin(new inkMargin(10.0, 10.0, 10.0, 10.0));
  label.SetWrapping(true, 140.0, textWrappingPolicy.PerCharacter);
  label.SetHorizontalAlignment(textHorizontalAlignment.Center);
  label.SetVerticalAlignment(IsDefined(icon) ? textVerticalAlignment.Bottom : textVerticalAlignment.Center);
  label.SetOpacity(IsDefined(icon) ? 0.0 : 1.0);
  label.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
  label.BindProperty(n"tintColor", n"MainColors.ActiveRed");
  label.SetInteractive(false);
  label.Reparent(root);
  control.browser.AddCard(card);
  this.RegisterNfrCardTooltipCallbacks(card);
  return card;
}
