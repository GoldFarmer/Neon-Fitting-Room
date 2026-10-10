module NeonFittingRoom

/**
 * Compiles this declaration only when its external provider is available.
  *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
import EquipmentEx.{OutfitSystem}

/** Returns the exact option currently selected by a native Photo Mode list item.
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
 * @param None. @return Current option, or a zero value when the selector is unavailable.
 * @errors Invalid selector state returns the zero value without changing selection. */
@if(ModuleExists("EquipmentEx"))
@addMethod(PhotoModeMenuListItem)
public func GetNfrCurrentOption() -> PhotoModeOptionSelectorData {
  let result: PhotoModeOptionSelectorData;
  let index: Int32;
  if !IsDefined(this.m_OptionSelector) { return result; }
  index = this.m_OptionSelector.GetCurrIndex();
  if index < 0 || index >= ArraySize(this.m_OptionSelectorValues) { return result; }
  return this.m_OptionSelectorValues[index];
}

/**
 * Preserves native wheel scrolling without re-centering the selected Photo Mode row.
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
 * @param e Released pointer event. @param gameCtrl Optional input owner. @return None. @errors None.
 */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(PhotoModeListController)
public func HandleInputWithVisibilityCheck(
  e: ref<inkPointerEvent>,
  opt gameCtrl: wref<inkGameController>
) -> Void {
  let isDirectional = e.IsAction(n"left_button")
    || e.IsAction(n"right_button")
    || e.IsAction(n"up_button")
    || e.IsAction(n"down_button")
    || e.IsAction(n"PhotoMode_Left_Button")
    || e.IsAction(n"PhotoMode_Right_Button");
  if isDirectional {
    wrappedMethod(e, gameCtrl);
  }
}

/**
 * Stores NFR-owned state on the extended native class.
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
 */
@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrOutfitLine: wref<inkWidget>;

/**
 * Stores NFR-owned state on the extended native class.
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
 */
@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrOutfitBrowser: ref<NfrExpandableCardBrowser>;

/**
 * Stores NFR-owned state on the extended native class.
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
 */
@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrOutfitOwnedControl: ref<NfrPhotoModeOwnedExpandableControl>;

/**
 * Stores NFR-owned state on the extended native class.
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
 */
@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrOutfitNativeMenuItem: wref<PhotoModeMenuListItem>;

/**
 * Stores NFR-owned state on the extended native class.
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
 */
@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrOutfitNativeStateHolder: wref<inkCanvas>;

/**
 * Returns the reusable Outfit browser host for diagnostics and outer-scroll integration.
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
 * @param None. @return The host widget or null before initialization. @errors None.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func GetNfrOutfitBrowserHost() -> wref<inkWidget> {
  if IsDefined(this.m_nfrOutfitBrowser) { return this.m_nfrOutfitBrowser.host; }
  return null;
}

/** Returns Outfit's settled native row for owned-control style derivation.
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
 * @param None. @return Native row or null before binding. @errors None. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func GetNfrOutfitReferenceRow() -> wref<inkCompoundWidget> {
  return this.m_nfrOutfitRowRoot;
}

/** Returns Outfit's disclosure image for owned-control geometry derivation.
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
 * @param None. @return Disclosure image or null before binding. @errors None. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func GetNfrOutfitReferenceDisclosure() -> wref<inkImage> {
  if IsDefined(this.m_nfrOutfitBrowser) { return this.m_nfrOutfitBrowser.disclosure; }
  return null;
}

/**
 * Stores NFR-owned state on the extended native class.
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
 */
@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrOutfitRowRoot: wref<inkCompoundWidget>;

/**
 * Stores NFR-owned state on the extended native class.
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
 */
@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrOutfitCardOptions: array<PhotoModeOptionSelectorData>;

/**
 * Stores NFR-owned state on the extended native class.
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
 */
@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrOutfitSelectedOptionData: Int32;

/** Returns the retained native Outfit option represented by the current NFR selection.
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
 * @param None. @return Matching option, or a zero-data value before options are available.
 * @errors Missing card options return the default value without changing native state. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func GetNfrSelectedOutfitOption() -> PhotoModeOptionSelectorData {
  let result: PhotoModeOptionSelectorData;
  let menuItem: wref<PhotoModeMenuListItem> = this.m_nfrOutfitNativeMenuItem;
  if !IsDefined(menuItem) { menuItem = this.GetMenuItem(3301u); }
  if IsDefined(menuItem) {
    result = menuItem.GetNfrCurrentOption();
    if NotEquals(result.optionText, "") || Equals(result.optionData, 3302)
      || Equals(result.optionData, 3303) {
      return result;
    }
  }
  for option in this.m_nfrOutfitCardOptions {
    if Equals(option.optionData, this.m_nfrOutfitSelectedOptionData) { return option; }
  }
  return result;
}

/**
 * Stores NFR-owned state on the extended native class.
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
 */
@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrOutfitOuterScroll: wref<inkScrollController>;

/**
 * Reapplies native-derived header geometry after the fit-to-content host completes layout.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrOutfitHeaderLayoutRefreshCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;

  /** Applies the retained layout. @param None. @return None. @errors Released owners are ignored. */
  public func Call() -> Void {
    if IsDefined(this.m_controller) {
      this.m_controller.ReconcileNfrOutfitForPhotoModeShow();
    }
  }

  /**
   * Creates one deferred layout refresh.
   * @param controller Active Photo Mode controller.
   * @return Callback retaining the controller weakly.
   * @errors None.
   */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>
  ) -> ref<NfrOutfitHeaderLayoutRefreshCallback> {
    let callback = new NfrOutfitHeaderLayoutRefreshCallback();
    callback.m_controller = controller;
    return callback;
  }
}

/**
 * Adds NFR's click listener to Equipment-EX's existing Outfit control line without changing its
 * visual selector, arrows, or selected-outfit label.
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
 * @param reversedUI The host Photo Mode orientation flag.
 * @return The inherited callback result.
 * @errors Missing native widgets retain Equipment-EX's unmodified control.
 */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnShow(reversedUI: Bool) -> Bool {
  let result = wrappedMethod(reversedUI);
  let outfitRow = this.GetMenuItem(3301u);
  let rowRoot: wref<inkCompoundWidget>;
  let selectorParent: wref<inkWidget>;
  let selector: wref<inkCompoundWidget>;
  let optionHit: wref<inkWidget>;
  let leftHit: wref<inkWidget>;
  let rightHit: wref<inkWidget>;
  let parent: wref<inkCompoundWidget>;
  let index: Int32;
  let model: ref<NfrExpandableCardControlModel>;
  let items: array<ref<NfrExpandableCardItemModel>>;
  let stateHolder: ref<inkCanvas>;
  if IsDefined(outfitRow) { this.m_nfrOutfitNativeMenuItem = outfitRow; }
  if IsDefined(this.m_nfrOutfitLine) {
    this.ReconcileNfrOutfitForPhotoModeShow();
    this.EnsureNfrPhotoModeControlsInputGuardFor(this.GetNfrOutfitBrowserHost());
    GameInstance.GetDelaySystem(this.GetPlayerControlledObject().GetGame()).DelayCallback(
      NfrOutfitHeaderLayoutRefreshCallback.Create(this),
      0.10,
      false
    );
    return result;
  }
  if !IsDefined(outfitRow) { return result; }
  this.m_nfrOutfitNativeMenuItem = outfitRow;
  rowRoot = outfitRow.GetRootWidget() as inkCompoundWidget;
  if !IsDefined(rowRoot) { return result; }
  selectorParent = rowRoot.GetWidgetByIndex(3);
  if !IsDefined(selectorParent) { return result; }
  selectorParent.SetInteractive(false);
  selector = (selectorParent as inkCompoundWidget).GetWidgetByIndex(0) as inkCompoundWidget;
  this.m_nfrOutfitLine = selectorParent;
  parent = rowRoot.GetParentWidget() as inkCompoundWidget;
  if !IsDefined(parent) { return result; }
  index = 0;
  while index < parent.GetNumChildren() && !Equals(parent.GetWidgetByIndex(index), rowRoot) {
    index += 1;
  }
  if index >= parent.GetNumChildren() { return result; }
  model = NfrExpandableCardControlModel.Create(n"outfit", NfrText.Outfit(), items, -1);
  this.m_nfrOutfitOwnedControl = new NfrPhotoModeOwnedExpandableControl();
  if !this.m_nfrOutfitOwnedControl.MountOwned(
    model,
    parent,
    index,
    this,
    n"OnNfrOutfitLineReleased",
    n"OnNfrOutfitExpandedLeftReleased",
    n"OnNfrOutfitExpandedRightReleased",
    rowRoot,
    null,
    true
  ) {
    this.m_nfrOutfitOwnedControl = null;
    return result;
  }
  stateHolder = new inkCanvas();
  stateHolder.SetName(n"nfr_outfit_native_state_holder");
  stateHolder.SetSize(0.0, 0.0);
  stateHolder.SetTranslation(new Vector2(-10000.0, -10000.0));
  stateHolder.SetInteractive(false);
  stateHolder.SetVisible(true);
  stateHolder.SetOpacity(0.0);
  stateHolder.Reparent(this.m_nfrOutfitOwnedControl.presenter.browser.host);
  rowRoot.Reparent(stateHolder);
  rowRoot.SetInteractive(false);
  rowRoot.SetVisible(true);
  rowRoot.SetOpacity(0.0);
  this.m_nfrOutfitNativeStateHolder = stateHolder;
  this.m_nfrOutfitRowRoot = this.m_nfrOutfitOwnedControl.rowRoot;
  this.m_nfrOutfitBrowser = this.m_nfrOutfitOwnedControl.presenter.browser;
  this.m_nfrOutfitBrowser.ConfigureGrid(NfrSettings.GetCardsPerRow());
  this.EnsureNfrPhotoModeControlsInputGuardFor(this.m_nfrOutfitBrowser.host);
  this.SyncNfrOutfitOwnedValueFromNativeOption();
  this.SyncNfrOutfitCardSelectionFromNativeOption();
  GameInstance.GetDelaySystem(this.GetPlayerControlledObject().GetGame()).DelayCallback(
    NfrOutfitHeaderLayoutRefreshCallback.Create(this),
    0.10,
    false
  );
  NfrLog.Info("Replaced Equipment-EX's visible Outfit row with an NFR-owned presentation adapter.");
  return result;
}

/** Starts each Photo Mode session from Equipment-EX's newly initialized native Outfit option.
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
 * @param None. @return None. @errors Missing native or owned widgets leave the prior presentation
 * intact until the scheduled settled retry. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ReconcileNfrOutfitForPhotoModeShow() -> Void {
  let option: PhotoModeOptionSelectorData;
  if !IsDefined(this.m_nfrOutfitNativeMenuItem) {
    this.m_nfrOutfitNativeMenuItem = this.GetMenuItem(3301u);
  }
  if !IsDefined(this.m_nfrOutfitNativeMenuItem) || !IsDefined(this.m_nfrOutfitOwnedControl) {
    return;
  }
  option = this.m_nfrOutfitNativeMenuItem.GetNfrCurrentOption();
  if Equals(option.optionText, "") && NotEquals(option.optionData, 3302)
    && NotEquals(option.optionData, 3303) { return; }
  if IsDefined(this.m_nfrOutfitBrowser) {
    this.ResetNfrCardSearch(this.m_nfrOutfitBrowser);
    this.m_nfrOutfitBrowser.SetExpanded(false);
  }
  this.m_nfrOutfitSelectedOptionData = option.optionData;
  if IsDefined(this.m_nfrOutfitOwnedControl.optionLabel) {
    this.m_nfrOutfitOwnedControl.optionLabel.SetText(option.optionText);
  }
  this.UpdateNfrOutfitExpandedOptionLabel();
  this.UpdateNfrOutfitCardSelectionVisuals();
}

/** Initializes the owned Outfit value before its lazy card catalog has been materialized.
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
 * @param None. @return None. @errors An unavailable native selector leaves the value blank. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func SyncNfrOutfitOwnedValueFromNativeOption() -> Void {
  let option: PhotoModeOptionSelectorData;
  if !IsDefined(this.m_nfrOutfitNativeMenuItem) || !IsDefined(this.m_nfrOutfitOwnedControl)
    || !IsDefined(this.m_nfrOutfitOwnedControl.optionLabel) {
    return;
  }
  option = this.m_nfrOutfitNativeMenuItem.GetNfrCurrentOption();
  this.m_nfrOutfitSelectedOptionData = option.optionData;
  this.m_nfrOutfitOwnedControl.optionLabel.SetText(option.optionText);
}

/**
 * Toggles NFR's future outfit-card browser from the existing Outfit control line.
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
 * @param evt The pointer release received by the native Outfit control.
 * @return True only for NFR's handled click action.
 * @errors Non-click input is ignored and leaves Equipment-EX behavior unchanged.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrOutfitLineReleased(evt: ref<inkPointerEvent>) -> Bool {
  if !IsDefined(evt) || !evt.IsAction(n"click") { return false; }
  if this.IsNfrOutfitArrowTarget(evt.GetTarget()) {
    this.SyncNfrOutfitCardSelectionFromNativeOption();
    return false;
  }
  this.UseNfrExpandableScrollContext(this.m_nfrOutfitRowRoot);
  this.BeginNfrExpandableScrollMutation(this.m_nfrOutfitRowRoot);
  if this.m_nfrOutfitBrowser.isExpanded { this.ResetNfrCardSearch(this.m_nfrOutfitBrowser); }
  if !this.m_nfrOutfitBrowser.isExpanded {
    this.CollapseNfrTopLevelExpandablePeers(n"outfit");
  }
  this.m_nfrOutfitBrowser.Toggle();
  this.UpdateNfrOutfitBrowserSurface();
  this.UpdateNfrOutfitExpandIndicator();
  this.ApplyNfrExpandableScrollPrediction();
  NfrLog.Info(
    this.m_nfrOutfitBrowser.isExpanded
      ? "NFR Outfit control line requested browser expansion."
      : "NFR Outfit control line requested browser collapse."
  );
  return true;
}

/**
 * Mirrors Equipment-EX's native arrow-selected Outfit option onto NFR's card accent.
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
 * @param None.
 * @return None.
 * @errors A changed native selector layout safely leaves the card accent unchanged.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func SyncNfrOutfitCardSelectionFromNativeOption() -> Void {
  let selectorParent: wref<inkCompoundWidget>;
  let selector: wref<inkCompoundWidget>;
  let optionLabel: wref<inkText>;
  let optionText: String;
  let index: Int32 = 0;
  if !IsDefined(this.m_nfrOutfitLine) { return; }
  selectorParent = this.m_nfrOutfitLine as inkCompoundWidget;
  if !IsDefined(selectorParent) { return; }
  selector = selectorParent.GetWidgetByIndex(0) as inkCompoundWidget;
  if !IsDefined(selector) { return; }
  optionLabel = selector.GetWidgetByIndex(1) as inkText;
  if !IsDefined(optionLabel) { return; }
  optionText = StrLower(optionLabel.GetText());
  while index < ArraySize(this.m_nfrOutfitCardOptions) {
    if Equals(StrLower(this.m_nfrOutfitCardOptions[index].optionText), optionText) {
      this.m_nfrOutfitSelectedOptionData = this.m_nfrOutfitCardOptions[index].optionData;
      this.UpdateNfrOutfitCardSelectionVisuals();
      this.UpdateNfrOutfitExpandedOptionLabel();
      return;
    }
    index += 1;
  }
  if StrContains(optionText, "no outfit") { this.m_nfrOutfitSelectedOptionData = 3302; }
  if StrContains(optionText, "current outfit") { this.m_nfrOutfitSelectedOptionData = 3303; }
  this.UpdateNfrOutfitCardSelectionVisuals();
  this.UpdateNfrOutfitExpandedOptionLabel();
}

/**
 * Identifies a click originating from Equipment-EX's native Outfit selector arrows.
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
 * @param target The Ink widget that originally received the pointer event.
 * @return True when the event belongs to either arrow subtree.
 * @errors An unavailable native selector is treated as a non-arrow target.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func IsNfrOutfitArrowTarget(target: wref<inkWidget>) -> Bool {
  let selectorParent: wref<inkCompoundWidget>;
  let selector: wref<inkCompoundWidget>;
  let leftButton: wref<inkWidget>;
  let rightButton: wref<inkWidget>;
  let current: wref<inkWidget> = target;
  let depth: Int32 = 0;
  if !IsDefined(this.m_nfrOutfitLine) { return false; }
  selectorParent = this.m_nfrOutfitLine as inkCompoundWidget;
  if !IsDefined(selectorParent) { return false; }
  selector = selectorParent.GetWidgetByIndex(0) as inkCompoundWidget;
  if !IsDefined(selector) { return false; }
  leftButton = selector.GetWidgetByIndex(0);
  rightButton = selector.GetWidgetByIndex(2);
  while IsDefined(current) && depth < 4 {
    if Equals(current, leftButton) || Equals(current, rightButton) { return true; }
    current = current.GetParentWidget();
    depth += 1;
  }
  return false;
}

/**
 * Selects one visible NFR outfit card through Equipment-EX's retained Photo Mode option route.
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
 * @param evt The pointer release received by an NFR-owned outfit card.
 * @return True only when an NFR card option was selected.
 * @errors Missing or stale card bindings leave Equipment-EX's existing selector unchanged.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrOutfitCardReleased(evt: ref<inkPointerEvent>) -> Bool {
  let target: wref<inkWidget>;
  let menuItem: wref<PhotoModeMenuListItem>;
  let index: Int32 = 0;
  if !IsDefined(evt) || !evt.IsAction(n"click") { return false; }
  target = evt.GetCurrentTarget();
  while index < ArraySize(this.m_nfrOutfitBrowser.cards) {
    if Equals(this.m_nfrOutfitBrowser.cards[index], target) {
      if index >= ArraySize(this.m_nfrOutfitCardOptions) { return false; }
      menuItem = this.m_nfrOutfitNativeMenuItem;
      if !IsDefined(menuItem) { menuItem = this.GetMenuItem(3301u); }
      if !IsDefined(menuItem) { return false; }
      menuItem.ForceValue(Cast<Float>(this.m_nfrOutfitCardOptions[index].optionData), true);
      this.OnAttributeOptionSelected(3301u, this.m_nfrOutfitCardOptions[index]);
      this.m_nfrOutfitSelectedOptionData = this.m_nfrOutfitCardOptions[index].optionData;
      this.UpdateNfrOutfitCardSelectionVisuals();
      this.UpdateNfrOutfitExpandedOptionLabel();
      NfrLog.Info(s"NFR outfit card selected: \(this.m_nfrOutfitCardOptions[index].optionText).");
      return true;
    }
    index += 1;
  }
  return false;
}

/**
 * Selects the previous Outfit through the same Equipment-EX route used by card releases.
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
 * @param evt The bounded expanded-header release event.
 * @return True when the click action was handled.
 * @errors Missing option data leaves the current Outfit unchanged.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrOutfitExpandedLeftReleased(evt: ref<inkPointerEvent>) -> Bool {
  if !IsDefined(evt) || !evt.IsAction(n"click") { return false; }
  return this.SelectAdjacentNfrOutfit(-1);
}

/**
 * Selects the next Outfit through the same Equipment-EX route used by card releases.
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
 * @param evt The bounded expanded-header release event.
 * @return True when the click action was handled.
 * @errors Missing option data leaves the current Outfit unchanged.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrOutfitExpandedRightReleased(evt: ref<inkPointerEvent>) -> Bool {
  if !IsDefined(evt) || !evt.IsAction(n"click") { return false; }
  return this.SelectAdjacentNfrOutfit(1);
}

/**
 * Applies an adjacent retained Outfit option, wrapping at either end of the list.
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
 * @param direction Negative for previous and positive for next.
 * @return True when Equipment-EX received a selection.
 * @errors Empty option data or a missing menu item returns false without changing equipment.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func SelectAdjacentNfrOutfit(direction: Int32) -> Bool {
  let menuItem: wref<PhotoModeMenuListItem>;
  let count: Int32 = ArraySize(this.m_nfrOutfitCardOptions);
  let index: Int32 = 0;
  if count == 0 { return false; }
  while index < count
    && !Equals(
      this.m_nfrOutfitCardOptions[index].optionData,
      this.m_nfrOutfitSelectedOptionData
    ) {
    index += 1;
  }
  if index >= count { index = direction < 0 ? count - 1 : 0; }
  else {
    index += direction < 0 ? -1 : 1;
    if index < 0 { index = count - 1; }
    if index >= count { index = 0; }
  }
  menuItem = this.m_nfrOutfitNativeMenuItem;
  if !IsDefined(menuItem) { menuItem = this.GetMenuItem(3301u); }
  if !IsDefined(menuItem) { return false; }
  menuItem.ForceValue(Cast<Float>(this.m_nfrOutfitCardOptions[index].optionData), true);
  this.OnAttributeOptionSelected(3301u, this.m_nfrOutfitCardOptions[index]);
  this.m_nfrOutfitSelectedOptionData = this.m_nfrOutfitCardOptions[index].optionData;
  this.UpdateNfrOutfitCardSelectionVisuals();
  this.UpdateNfrOutfitExpandedOptionLabel();
  NfrLog.Info(s"NFR expanded Outfit arrow selected: \(this.m_nfrOutfitCardOptions[index].optionText).");
  return true;
}

/**
 * Mirrors the retained selected Outfit name onto the fixed expanded header.
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
 * @param None.
 * @return None.
 * @errors Missing label or unmatched option data leaves the previous text unchanged.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrOutfitExpandedOptionLabel() -> Void {
  let index: Int32 = 0;
  while index < ArraySize(this.m_nfrOutfitCardOptions) {
    if Equals(
      this.m_nfrOutfitCardOptions[index].optionData,
      this.m_nfrOutfitSelectedOptionData
    ) {
      if IsDefined(this.m_nfrOutfitOwnedControl)
        && IsDefined(this.m_nfrOutfitOwnedControl.optionLabel) {
        this.m_nfrOutfitOwnedControl.optionLabel.SetText(
          this.m_nfrOutfitCardOptions[index].optionText
        );
      }
      return;
    }
    index += 1;
  }
}

/**
 * Gives the selected NFR card the Wardrobe-style blue accent without changing the native selector.
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
 * @param None.
 * @return None.
 * @errors Missing card internals simply leave that card in its normal appearance.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrOutfitCardSelectionVisuals() -> Void {
  let cardController: wref<PhotoModeGridButton>;
  let frame: wref<inkWidget>;
  let background: wref<inkWidget>;
  let label: wref<inkWidget>;
  let selected: Bool;
  let index: Int32 = 0;
  while index < ArraySize(this.m_nfrOutfitBrowser.cards) {
    frame = (this.m_nfrOutfitBrowser.cards[index] as inkCompoundWidget).GetWidgetByPathName(n"frameImg");
    background = (this.m_nfrOutfitBrowser.cards[index] as inkCompoundWidget).GetWidgetByPathName(n"bgRect");
    label = (this.m_nfrOutfitBrowser.cards[index] as inkCompoundWidget).GetWidgetByPathName(n"nfrOutfitCardLabel");
    selected = index < ArraySize(this.m_nfrOutfitCardOptions)
      && Equals(this.m_nfrOutfitCardOptions[index].optionData, this.m_nfrOutfitSelectedOptionData);
    cardController = this.m_nfrOutfitBrowser.cards[index].GetControllerByType(n"PhotoModeGridButton")
      as PhotoModeGridButton;
    if IsDefined(cardController) { cardController.ButtonStateChanged(selected); }
    if selected {
      if IsDefined(frame) {
        frame.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
        frame.BindProperty(n"tintColor", n"MainColors.ActiveBlue");
        frame.SetOpacity(1.0);
      }
      if IsDefined(background) {
        background.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
        background.BindProperty(n"tintColor", n"MainColors.ActiveBlue");
        background.SetOpacity(0.40);
      }
      if IsDefined(label) {
        label.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
        label.BindProperty(n"tintColor", n"MainColors.ActiveBlue");
      }
    } else {
      if IsDefined(frame) {
        frame.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
        frame.BindProperty(n"tintColor", n"MainColors.ActiveRed");
        frame.SetOpacity(1.0);
      }
      if IsDefined(background) {
        background.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
        background.BindProperty(n"tintColor", n"MainColors.ActiveRed");
        background.SetOpacity(0.40);
      }
      if IsDefined(label) {
        label.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
        label.BindProperty(n"tintColor", n"MainColors.ActiveRed");
      }
    }
    index += 1;
  }
}

/**
 * Shows the owning card's explicit red hover background without native grid-button state.
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
 * @param evt The hover event whose current target is an NFR-owned card root.
 * @return True when a matching card background was shown.
 * @errors Stale and unrelated targets are ignored.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrOutfitCardHoverOver(evt: ref<inkPointerEvent>) -> Bool {
  let background: wref<inkWidget>;
  let index: Int32 = 0;
  while index < ArraySize(this.m_nfrOutfitBrowser.cards) {
    if Equals(this.m_nfrOutfitBrowser.cards[index], evt.GetCurrentTarget()) {
      background = (this.m_nfrOutfitBrowser.cards[index] as inkCompoundWidget).GetWidgetByPathName(n"bgRect");
      if IsDefined(background) {
        background.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
        background.BindProperty(n"tintColor", n"MainColors.ActiveRed");
        background.SetOpacity(0.20);
        background.SetVisible(true);
      }
      return true;
    }
    index += 1;
  }
  return false;
}

/**
 * Restores explicit selected/unselected visuals after the pointer leaves an outfit card.
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
 * @param evt The hover-out event; its payload is not otherwise required.
 * @return True after card selection visuals are restored.
 * @errors An empty card collection is safe.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrOutfitCardHoverOut(evt: ref<inkPointerEvent>) -> Bool {
  this.UpdateNfrOutfitCardSelectionVisuals();
  return true;
}

/**
 * Reflects the Outfit card browser's current open state in its disclosure indicator.
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
 * @param None.
 * @return None.
 * @errors A missing indicator is safe while the native row is rebuilding.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrOutfitExpandIndicator() -> Void {
  if IsDefined(this.m_nfrOutfitBrowser) {
    this.m_nfrOutfitBrowser.UpdateDisclosure();
  }
}

/**
 * Shows or hides the complete Equipment-EX outfit-card selector in the Outfit row.
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
 * @param None.
 * @return None.
 * @errors Missing row widgets leave the control line usable and only omit the card surface.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrOutfitBrowserSurface() -> Void {
  let outfits: array<ref<NfrOutfitSnapshot>>;
  let utilityParts: array<ref<NfrOutfitPartSnapshot>>;
  let currentParts: array<ref<NfrOutfitPartSnapshot>>;
  let outfitSystem: wref<OutfitSystem>;
  let option: PhotoModeOptionSelectorData;
  let wrapper: ref<inkCanvas>;
  let content: ref<inkCanvas>;
  let index: Int32 = 0;
  let optionOffset: Int32 = 1;
  let searchIndex: Int32;
  let searchLabels: array<String>;
  let contentHeight: Float;
  if !IsDefined(this.m_nfrOutfitRowRoot) || !IsDefined(this.m_nfrOutfitBrowser.host) { return; }
  this.m_nfrOutfitBrowser.ConfigureGrid(NfrSettings.GetCardsPerRow());
  if !IsDefined(this.m_nfrOutfitBrowser.surface) {
    wrapper = new inkCanvas();
    wrapper.SetName(n"nfr_outfit_card_surface");
    wrapper.SetAnchor(inkEAnchor.TopLeft);
    wrapper.SetAnchorPoint(Vector2(0.0, 0.0));
    wrapper.SetMargin(inkMargin(9.0, 0.0, 0.0, 0.0));
    wrapper.SetTranslation(Vector2(0.0, 0.0));
    wrapper.SetSize(this.m_nfrOutfitRowRoot.GetWidth(), this.m_nfrOutfitBrowser.contentHeight);
    wrapper.SetInteractive(true);
    wrapper.SetOpacity(1.0);
    // The outer list sees one expanding host at the native Outfit row's original position, while
    // the native row itself remains fixed-height and the cards form its second vertical child.
    wrapper.Reparent(this.m_nfrOutfitBrowser.host);
    // A plain canvas keeps every card directly under Photo Mode's outer scrolling ancestry. There
    // is deliberately no nested inkScrollArea or native grid controller competing for wheel input.
    content = new inkCanvas();
    content.SetName(n"nfr_outfit_card_content");
    content.SetAnchor(inkEAnchor.TopLeft);
    content.SetAnchorPoint(Vector2(0.0, 0.0));
    content.SetTranslation(Vector2(0.0, 0.0));
    content.SetSize(this.m_nfrOutfitRowRoot.GetWidth(), this.m_nfrOutfitBrowser.contentHeight);
    content.SetInteractive(true);
    content.SetOpacity(1.0);
    content.Reparent(wrapper);
    outfits = NfrOutfitCatalog.ReadSavedOutfits();
    outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
    option.optionText = "No Outfit";
    option.optionData = 3302;
    this.CreateNfrOutfitCard(content, option, utilityParts);
    if IsDefined(outfitSystem) && outfitSystem.IsActive() {
      optionOffset = 2;
      option.optionText = "Current Equipped Outfit";
      option.optionData = 3303;
      currentParts = this.BuildNfrCurrentEquippedOutfitParts(outfitSystem);
      this.CreateNfrOutfitCard(content, option, currentParts);
    }
    while index < ArraySize(outfits) {
      option.optionText = outfits[index].displayName;
      option.optionData = index + optionOffset;
      this.CreateNfrOutfitCard(content, option, outfits[index].parts);
      index += 1;
    }
    contentHeight = this.m_nfrOutfitBrowser.MeasureContentHeight();
    content.SetHeight(contentHeight);
    wrapper.SetHeight(contentHeight);
    this.m_nfrOutfitBrowser.SetSurface(wrapper);
    while searchIndex < ArraySize(this.m_nfrOutfitCardOptions) {
      ArrayPush(searchLabels, this.m_nfrOutfitCardOptions[searchIndex].optionText);
      searchIndex += 1;
    }
    this.EnsureNfrCardSearch(
      this.m_nfrOutfitBrowser,
      wrapper,
      content,
      true,
      searchLabels,
      optionOffset
    );
    this.SyncNfrOutfitCardSelectionFromNativeOption();
    this.UpdateNfrOutfitCardSelectionVisuals();
  }
  this.RefreshNfrCardGridSettings();
  this.ApplyNfrOutfitIconSetting();
  this.m_nfrOutfitBrowser.UpdateSurfaceVisibility();
  // The outer scroll area still reports its collapsed content size on the first frame after this
  // visibility change. Allow ink's fit-to-content layout to settle before deriving a new range.
  this.ScheduleNfrExpandableScrollRefresh();
}

/**
 * Recomputes the native Photo Mode scroll range after the outfit host's layout has settled.
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
 * @param None.
 * @return None.
 * @errors A missing outer scroll controller leaves native scrolling unchanged.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func RefreshNfrOutfitOuterScrollRange() -> Void {
  let current: wref<inkWidget>;
  let restoreOffset: Float;
  let scroll: wref<inkScrollController> = this.m_nfrOutfitOuterScroll;
  if !IsDefined(scroll) {
    current = this.m_nfrOutfitBrowser.host;
    while IsDefined(current) && !IsDefined(scroll) {
      scroll = current.GetControllerByType(n"inkScrollController") as inkScrollController;
      current = current.GetParentWidget();
    }
    this.m_nfrOutfitOuterScroll = scroll;
  }
  if !IsDefined(scroll) {
    NfrLog.Warn("Could not refresh Outfit scroll range: no outer inkScrollController found.");
    return;
  }
  NfrLog.Info(s"Outfit scroll before refresh: position=\(scroll.position) delta=\(scroll.scrollDelta).");
  NfrLog.Info(s"Outfit scroll before refresh: contentY=\(scroll.contentSize.Y) viewportY=\(scroll.viewportSize.Y).");
  scroll.UpdateScrollPositionFromScrollArea();
  // Equipment-EX's extension recomputes scrollDelta as contentSize.Y - viewportSize.Y.
  scroll.SetScrollEnabled(true);
  if this.m_nfrExpandableScrollRestorePending {
    restoreOffset = this.m_nfrExpandableScrollRestoreOffset;
    scroll.SetScrollPosition(
      scroll.scrollDelta > 0.0
        ? ClampF(restoreOffset, 0.0, scroll.scrollDelta)
          / scroll.scrollDelta
        : 0.0
    );
    this.m_nfrExpandableScrollRestorePending = false;
    this.ScheduleNfrExpandableAnchorCorrection();
  }
  NfrLog.Info(s"Outfit scroll after refresh: position=\(scroll.position) delta=\(scroll.scrollDelta).");
  NfrLog.Info(s"Outfit scroll after refresh: contentY=\(scroll.contentSize.Y) viewportY=\(scroll.viewportSize.Y).");
}

/**
 * Creates one compiled Photo Mode card and binds it to a retained Equipment-EX selector choice.
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
 * @param panel The NFR-owned card content panel.
 * @param option The exact Equipment-EX option data to select when the card is clicked.
 * @param parts Saved-outfit parts represented by the adaptive icon mosaic; empty for utility cards.
 * @return None.
 * @errors A missing compiled card is ignored without affecting the native selector.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CreateNfrOutfitCard(
  panel: wref<inkCompoundWidget>,
  option: PhotoModeOptionSelectorData,
  parts: array<ref<NfrOutfitPartSnapshot>>
) -> Void {
  let card: wref<inkWidget>;
  let cardRoot: wref<inkCompoundWidget>;
  let label: ref<inkText>;
  let plus: wref<inkWidget>;
  let hasVisual: Bool;
  let mosaicParts: array<ref<NfrOutfitPartSnapshot>>;
  let index: Int32 = ArraySize(this.m_nfrOutfitBrowser.cards);
  if !IsDefined(panel) { return; }
  card = this.SpawnFromExternal(panel, r"nfr\\ui\\nfr_photomode_static_panel.inkwidget", n"Card");
  cardRoot = card as inkCompoundWidget;
  if IsDefined(cardRoot) {
        card.SetName(StringToName(s"nfrOutfitCard\(index)"));
        card.SetAnchor(inkEAnchor.TopLeft);
        card.SetAnchorPoint(Vector2(0.0, 0.0));
        // Full 162-unit roots meet at cell boundaries, eliminating pointer gaps that leak wheel
        // input to camera zoom. Nine cells still fit within the measured 1500-unit Outfit row.
        card.SetScale(new Vector2(1.0, 1.0));
        card.SetOpacity(1.0);
        card.SetState(n"Default");
        card.SetTintColor(new HDRColor(1.00, 1.00, 1.00, 1.00));
        card.SetInteractive(true);
        card.RegisterToCallback(n"OnRelease", this, n"OnNfrOutfitCardReleased");
        this.RegisterNfrCardTooltipCallbacks(card);
        plus = cardRoot.GetWidgetByPathName(n"plusImg");
        if IsDefined(plus) { plus.SetVisible(false); }
        mosaicParts = this.GetNfrSignificantOutfitParts(parts);
        if ArraySize(mosaicParts) > 0 {
          this.BuildNfrOutfitCardIconMosaic(cardRoot, mosaicParts);
        }
        if Equals(option.optionData, 3302) {
          this.BuildNfrNoOutfitCardIcon(cardRoot);
        }
        hasVisual = NfrSettings.AreOutfitIconsEnabled()
          && (ArraySize(mosaicParts) > 0 || Equals(option.optionData, 3302));
        label = new inkText();
        label.SetName(n"nfrOutfitCardLabel");
        label.SetText(option.optionText);
        label.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
        label.SetFontStyle(n"Regular");
        label.SetFontSize(hasVisual ? 21 : 30);
        label.SetAnchor(hasVisual ? inkEAnchor.TopLeft : inkEAnchor.Fill);
        label.SetAnchorPoint(Vector2(0.0, 0.0));
        label.SetMargin(inkMargin(10.0, 10.0, 10.0, 10.0));
        if hasVisual {
          label.SetTranslation(Vector2(10.0, 112.0));
          label.SetSize(142.0, 44.0);
          label.SetMargin(inkMargin(0.0, 0.0, 0.0, 0.0));
        }
        label.SetWrapping(true, 140.0, textWrappingPolicy.PerCharacter);
        label.SetHorizontalAlignment(textHorizontalAlignment.Center);
        label.SetVerticalAlignment(hasVisual
          ? textVerticalAlignment.Top
          : textVerticalAlignment.Center);
        label.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
        label.BindProperty(n"tintColor", n"MainColors.ActiveRed");
        label.SetOpacity(1.00);
        label.Reparent(cardRoot);
        this.ApplyNfrOutfitCardIconSetting(cardRoot);
        this.m_nfrOutfitBrowser.AddCard(card);
        ArrayPush(this.m_nfrOutfitCardOptions, option);
  }
}

/** Applies the committed outfit-icon setting to one retained card and its text layout.
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
 * @param cardRoot Compiled outfit-card root. @return None. @errors Missing optional visuals are
 * treated as a text-only outfit. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ApplyNfrOutfitCardIconSetting(cardRoot: wref<inkCompoundWidget>) -> Void {
  let mosaic: wref<inkWidget>;
  let noOutfitFirst: wref<inkWidget>;
  let noOutfitSecond: wref<inkWidget>;
  let label: wref<inkText>;
  let enabled: Bool = NfrSettings.AreOutfitIconsEnabled();
  let hasVisual: Bool;
  if !IsDefined(cardRoot) { return; }
  mosaic = cardRoot.GetWidgetByPathName(n"nfrOutfitCardIconMosaic");
  noOutfitFirst = cardRoot.GetWidgetByPathName(n"nfrNoOutfitIconFirst");
  noOutfitSecond = cardRoot.GetWidgetByPathName(n"nfrNoOutfitIconSecond");
  hasVisual = IsDefined(mosaic) || IsDefined(noOutfitFirst) || IsDefined(noOutfitSecond);
  if IsDefined(mosaic) { mosaic.SetVisible(enabled); }
  if IsDefined(noOutfitFirst) { noOutfitFirst.SetVisible(enabled); }
  if IsDefined(noOutfitSecond) { noOutfitSecond.SetVisible(enabled); }
  label = cardRoot.GetWidgetByPathName(n"nfrOutfitCardLabel") as inkText;
  if !IsDefined(label) { return; }
  if enabled && hasVisual {
    label.SetFontSize(21);
    label.SetAnchor(inkEAnchor.TopLeft);
    label.SetTranslation(Vector2(10.0, 112.0));
    label.SetSize(142.0, 44.0);
    label.SetMargin(inkMargin(0.0, 0.0, 0.0, 0.0));
    label.SetVerticalAlignment(textVerticalAlignment.Top);
  } else {
    label.SetFontSize(30);
    label.SetAnchor(inkEAnchor.Fill);
    label.SetTranslation(Vector2(0.0, 0.0));
    label.SetSize(0.0, 0.0);
    label.SetMargin(inkMargin(10.0, 10.0, 10.0, 10.0));
    label.SetVerticalAlignment(textVerticalAlignment.Center);
  }
}

/** Refreshes outfit icon visibility for retained cards after settings or Photo Mode lifecycle changes.
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
 * @param None. @return None. @errors Missing browser cards are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ApplyNfrOutfitIconSetting() -> Void {
  let cardRoot: wref<inkCompoundWidget>;
  let index: Int32;
  if !IsDefined(this.m_nfrOutfitBrowser) { return; }
  while index < ArraySize(this.m_nfrOutfitBrowser.cards) {
    cardRoot = this.m_nfrOutfitBrowser.cards[index] as inkCompoundWidget;
    this.ApplyNfrOutfitCardIconSetting(cardRoot);
    index += 1;
  }
}

/** Captures the currently equipped Equipment-EX outfit-slot items for the utility-card mosaic.
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
 * @param outfitSystem Active Equipment-EX authority. @return Valid populated slot snapshots.
 * @errors Missing systems and empty slots are omitted. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func BuildNfrCurrentEquippedOutfitParts(
  outfitSystem: wref<OutfitSystem>
) -> array<ref<NfrOutfitPartSnapshot>> {
  if !IsDefined(outfitSystem) { return []; }
  return NfrOutfitCatalog.ReadActiveOutfitParts();
}

/** Draws a clear-state cross for the No Outfit utility card.
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
 * @param cardRoot Compiled card root. @return None. @errors Missing roots are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func BuildNfrNoOutfitCardIcon(cardRoot: wref<inkCompoundWidget>) -> Void {
  let first: ref<inkRectangle>;
  let second: ref<inkRectangle>;
  if !IsDefined(cardRoot) { return; }
  first = new inkRectangle();
  first.SetName(n"nfrNoOutfitIconFirst");
  first.SetAnchor(inkEAnchor.TopLeft);
  first.SetAnchorPoint(Vector2(0.5, 0.5));
  first.SetTranslation(Vector2(81.0, 56.0));
  first.SetSize(72.0, 5.0);
  first.SetRotation(45.0);
  first.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
  first.BindProperty(n"tintColor", n"MainColors.ActiveRed");
  first.SetInteractive(false);
  first.Reparent(cardRoot);
  second = new inkRectangle();
  second.SetName(n"nfrNoOutfitIconSecond");
  second.SetAnchor(inkEAnchor.TopLeft);
  second.SetAnchorPoint(Vector2(0.5, 0.5));
  second.SetTranslation(Vector2(81.0, 56.0));
  second.SetSize(72.0, 5.0);
  second.SetRotation(-45.0);
  second.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
  second.BindProperty(n"tintColor", n"MainColors.ActiveRed");
  second.SetInteractive(false);
  second.Reparent(cardRoot);
}

/** Selects populated silhouette-defining outfit parts for a recognizable card collage.
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
 * @param parts Immutable session outfit parts. @return Head, Torso, Back, Waist, Legs, and Feet
 * parts, including every populated sub-slot in those Equipment-EX regions. @errors Invalid parts and
 * non-significant accessory regions are omitted. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func GetNfrSignificantOutfitParts(
  parts: array<ref<NfrOutfitPartSnapshot>>
) -> array<ref<NfrOutfitPartSnapshot>> {
  let result: array<ref<NfrOutfitPartSnapshot>>;
  for part in parts {
    if IsDefined(part) && ItemID.IsValid(part.itemID) && this.IsNfrSignificantOutfitSlot(part.slotID) {
      ArrayPush(result, part);
    }
  }
  return result;
}

/** Reports whether an Equipment-EX slot materially defines the outfit silhouette.
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
 * @param slotID Equipment-EX outfit slot. @return True for selected major body regions.
 * @errors Unknown and invalid slots return false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func IsNfrSignificantOutfitSlot(slotID: TweakDBID) -> Bool {
  return Equals(slotID, t"OutfitSlots.Head")
    || Equals(slotID, t"OutfitSlots.Balaclava")
    || Equals(slotID, t"OutfitSlots.TorsoUnder")
    || Equals(slotID, t"OutfitSlots.TorsoInner")
    || Equals(slotID, t"OutfitSlots.TorsoMiddle")
    || Equals(slotID, t"OutfitSlots.TorsoOuter")
    || Equals(slotID, t"OutfitSlots.TorsoAux")
    || Equals(slotID, t"OutfitSlots.Back")
    || Equals(slotID, t"OutfitSlots.Waist")
    || Equals(slotID, t"OutfitSlots.LegsInner")
    || Equals(slotID, t"OutfitSlots.LegsMiddle")
    || Equals(slotID, t"OutfitSlots.LegsOuter")
    || Equals(slotID, t"OutfitSlots.ThighLeft")
    || Equals(slotID, t"OutfitSlots.ThighRight")
    || Equals(slotID, t"OutfitSlots.KneeLeft")
    || Equals(slotID, t"OutfitSlots.KneeRight")
    || Equals(slotID, t"OutfitSlots.AnkleLeft")
    || Equals(slotID, t"OutfitSlots.AnkleRight")
    || Equals(slotID, t"OutfitSlots.Feet");
}

/** Builds a significant-parts adaptive inventory-icon mosaic above a saved outfit's label.
 * The grid expands its row/column count instead of replacing included parts with a `+N` summary.
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
 * @param cardRoot Compiled card root. @param parts Immutable session outfit parts.
 * @return None. @errors Missing item/icon records retain a visible placeholder cell. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func BuildNfrOutfitCardIconMosaic(
  cardRoot: wref<inkCompoundWidget>, parts: array<ref<NfrOutfitPartSnapshot>>
) -> Void {
  let mosaic: ref<inkCanvas>;
  let cell: ref<inkCanvas>;
  let icon: ref<inkImage>;
  let placeholder: ref<inkText>;
  let itemRecord: wref<Item_Record>;
  let iconRecord: wref<UIIcon_Record>;
  let columns: Int32;
  let rows: Int32;
  let cellWidth: Float;
  let cellHeight: Float;
  let iconSize: Float;
  let index: Int32;
  if !IsDefined(cardRoot) || ArraySize(parts) == 0 { return; }
  columns = this.GetNfrOutfitMosaicColumns(ArraySize(parts));
  rows = (ArraySize(parts) + columns - 1) / columns;
  cellWidth = 142.0 / Cast<Float>(columns);
  cellHeight = 104.0 / Cast<Float>(rows);
  iconSize = MaxF(10.0, MinF(cellWidth, cellHeight) - 4.0);
  mosaic = new inkCanvas();
  mosaic.SetName(n"nfrOutfitCardIconMosaic");
  mosaic.SetAnchor(inkEAnchor.TopLeft);
  mosaic.SetAnchorPoint(Vector2(0.0, 0.0));
  mosaic.SetTranslation(Vector2(10.0, 5.0));
  mosaic.SetSize(142.0, 104.0);
  mosaic.SetInteractive(false);
  mosaic.Reparent(cardRoot);
  while index < ArraySize(parts) {
    cell = new inkCanvas();
    cell.SetName(StringToName(s"nfrOutfitCardIconCell(index)"));
    cell.SetAnchor(inkEAnchor.TopLeft);
    cell.SetAnchorPoint(Vector2(0.0, 0.0));
    cell.SetTranslation(Vector2(
      Cast<Float>(index % columns) * cellWidth,
      Cast<Float>(index / columns) * cellHeight
    ));
    cell.SetSize(cellWidth, cellHeight);
    cell.SetInteractive(false);
    cell.Reparent(mosaic);
    if IsDefined(parts[index]) && ItemID.IsValid(parts[index].itemID) {
      itemRecord = TweakDBInterface.GetItemRecord(ItemID.GetTDBID(parts[index].itemID));
      if IsDefined(itemRecord) { iconRecord = itemRecord.Icon(); } else { iconRecord = null; }
    } else {
      iconRecord = null;
    }
    if IsDefined(iconRecord) && NotEquals(iconRecord.AtlasPartName(), n"") {
      icon = new inkImage();
      icon.SetName(StringToName(s"nfrOutfitCardItemIcon(index)"));
      icon.SetAtlasResource(iconRecord.AtlasResourcePath());
      icon.SetTexturePart(iconRecord.AtlasPartName());
      icon.SetAnchor(inkEAnchor.Centered);
      icon.SetAnchorPoint(Vector2(0.5, 0.5));
      icon.SetSize(iconSize, iconSize);
      icon.SetInteractive(false);
      icon.Reparent(cell);
    } else {
      placeholder = new inkText();
      placeholder.SetName(StringToName(s"nfrOutfitCardMissingIcon(index)"));
      placeholder.SetText("?");
      placeholder.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
      placeholder.SetFontStyle(n"Medium");
      placeholder.SetFontSize(Max(12, Cast<Int32>(iconSize * 0.55)));
      placeholder.SetAnchor(inkEAnchor.Fill);
      placeholder.SetHorizontalAlignment(textHorizontalAlignment.Center);
      placeholder.SetVerticalAlignment(textVerticalAlignment.Center);
      placeholder.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
      placeholder.BindProperty(n"tintColor", n"MainColors.ActiveRed");
      placeholder.SetInteractive(false);
      placeholder.Reparent(cell);
    }
    index += 1;
  }
}

/** Chooses a compact near-square grid that retains every outfit part.
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
 * @param count Constituent part count. @return Column count. @errors Non-positive counts use one. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func GetNfrOutfitMosaicColumns(count: Int32) -> Int32 {
  if count <= 1 { return 1; }
  if count <= 4 { return 2; }
  if count <= 9 { return 3; }
  if count <= 16 { return 4; }
  if count <= 25 { return 5; }
  return 6;
}

/**
 * Releases NFR's listener before Photo Mode destroys the native widget tree.
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
 * @param None.
 * @return None.
 * @errors A missing line is safe during teardown.
 */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnUninitialize() -> Void {
  let index: Int32 = 0;
  let parent: wref<inkCompoundWidget>;
  if IsDefined(this.m_nfrOutfitLine) {
    this.m_nfrOutfitLine.UnregisterFromCallback(n"OnRelease", this, n"OnNfrOutfitLineReleased");
  }
  if IsDefined(this.m_nfrOutfitOwnedControl) {
    this.m_nfrOutfitOwnedControl.ReleaseOwnedHooks(
      this,
      n"OnNfrOutfitLineReleased",
      n"OnNfrOutfitExpandedLeftReleased",
      n"OnNfrOutfitExpandedRightReleased"
    );
    if IsDefined(this.m_nfrOutfitOwnedControl.presenter)
      && IsDefined(this.m_nfrOutfitOwnedControl.presenter.browser)
      && IsDefined(this.m_nfrOutfitOwnedControl.presenter.browser.host) {
      parent = this.m_nfrOutfitOwnedControl.presenter.browser.host.GetParentWidget()
        as inkCompoundWidget;
      if IsDefined(parent) {
        parent.RemoveChild(this.m_nfrOutfitOwnedControl.presenter.browser.host);
      }
    }
  }
  if IsDefined(this.m_nfrOutfitBrowser) {
    while index < ArraySize(this.m_nfrOutfitBrowser.cards) {
      this.m_nfrOutfitBrowser.cards[index].UnregisterFromCallback(
        n"OnRelease", this, n"OnNfrOutfitCardReleased"
      );
      this.m_nfrOutfitBrowser.cards[index].UnregisterFromCallback(
        n"OnHoverOver", this, n"OnNfrOutfitCardHoverOver"
      );
      this.m_nfrOutfitBrowser.cards[index].UnregisterFromCallback(
        n"OnHoverOut", this, n"OnNfrOutfitCardHoverOut"
      );
      this.UnregisterNfrCardTooltipCallbacks(this.m_nfrOutfitBrowser.cards[index]);
      index += 1;
    }
  }
  this.m_nfrOutfitLine = null;
  this.m_nfrOutfitRowRoot = null;
  ArrayClear(this.m_nfrOutfitCardOptions);
  this.m_nfrOutfitSelectedOptionData = -1;
  this.m_nfrOutfitOwnedControl = null;
  this.m_nfrOutfitNativeMenuItem = null;
  this.m_nfrOutfitNativeStateHolder = null;
  this.m_nfrOutfitOuterScroll = null;
  if IsDefined(this.m_nfrOutfitBrowser) { this.m_nfrOutfitBrowser.Reset(); }
  this.m_nfrOutfitBrowser = null;
  wrappedMethod();
}
