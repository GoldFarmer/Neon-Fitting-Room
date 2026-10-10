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
import EquipmentEx.{OutfitPart, OutfitSystem, PaperdollHelper}

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
private let m_nfrClothingControl: ref<NfrPhotoModeOwnedExpandableControl>;

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
private let m_nfrClothingSlotContainer: wref<inkVerticalPanel>;

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
private let m_nfrClothingSlots: array<ref<NfrPhotoModeClothingSlotBrowser>>;

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
private let m_nfrClothingCatalogBuilt: Bool;

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
private let m_nfrClothingCustomPreview: Bool;

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
private let m_nfrClothingActiveCount: Int32;

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
private let m_nfrClothingSyncRevision: Int32;

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
private let m_nfrClothingBaselineOption: PhotoModeOptionSelectorData;

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
private let m_nfrClothingHasBaselineOption: Bool;

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
private let m_nfrClothingClearHit: wref<inkWidget>;

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
private let m_nfrClothingClearLabel: wref<inkText>;

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
private let m_nfrClothingResetHit: wref<inkWidget>;

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
private let m_nfrClothingResetLabel: wref<inkText>;

/**
 * Repeats outfit-to-clothing synchronization after Equipment-EX's preview update settles.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrClothingOutfitSyncCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;
  private let m_option: PhotoModeOptionSelectorData;
  private let m_revision: Int32;

  /** Applies the retained option to generated Clothing rows. @param None. @return None.
   * @errors Released controllers are ignored. */
  public func Call() -> Void {
    if IsDefined(this.m_controller) {
      this.m_controller.SyncNfrClothingSlotsFromOutfitOptionIfCurrent(
        this.m_option,
        this.m_revision
      );
    }
  }

  /** Creates a deferred synchronization request. @param controller Active Photo Mode controller.
   * @param option Exact selected Outfit option. @return New callback. @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>,
    option: PhotoModeOptionSelectorData,
    revision: Int32
  ) -> ref<NfrClothingOutfitSyncCallback> {
    let callback = new NfrClothingOutfitSyncCallback();
    callback.m_controller = controller;
    callback.m_option = option;
    callback.m_revision = revision;
    return callback;
  }
}

/** Synchronizes generated clothing selectors after Equipment-EX changes the Photo Mode outfit.
 * The dependency applies the puppet change first; NFR then mirrors the same option into retained UI state.
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
 * @param attribute Selected Photo Mode attribute. @param option Exact selected option.
 * @return None. @errors Non-Outfit selections retain their native behavior without NFR synchronization. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
public func OnAttributeOptionSelected(attribute: Uint32, option: PhotoModeOptionSelectorData) -> Void {
  wrappedMethod(attribute, option);
  if Equals(attribute, 3301u) {
    this.m_nfrClothingSyncRevision += 1;
    this.SyncNfrClothingSlotsFromOutfitOption(option);
    GameInstance.GetDelaySystem(this.GetPlayerControlledObject().GetGame()).DelayCallback(
      NfrClothingOutfitSyncCallback.Create(this, option, this.m_nfrClothingSyncRevision),
      0.35,
      false
    );
  }
}

/** Applies settled outfit synchronization only when no later manual preview action superseded it.
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
 * @param option Retained native Outfit option. @param revision Outfit transition revision.
 * @return None. @errors Stale callbacks are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func SyncNfrClothingSlotsFromOutfitOptionIfCurrent(
  option: PhotoModeOptionSelectorData,
  revision: Int32
) -> Void {
  if revision == this.m_nfrClothingSyncRevision {
    this.SyncNfrClothingSlotsFromOutfitOption(option);
  }
}

/** Replaces stale manual clothing selections with the parts represented by the selected outfit.
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
 * @param option Exact Equipment-EX Photo Mode outfit option. @return None.
 * @errors Before the lazy slot catalog exists there is no retained UI state to synchronize. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func SyncNfrClothingSlotsFromOutfitOption(option: PhotoModeOptionSelectorData) -> Void {
  let outfitSystem: wref<OutfitSystem>;
  let parts: array<ref<OutfitPart>>;
  let selectedItem: ItemID;
  let selectedIndex: Int32;
  let selectedCount: Int32;
  this.m_nfrClothingBaselineOption = option;
  this.m_nfrClothingHasBaselineOption = true;
  this.m_nfrClothingCustomPreview = false;
  outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
  if !IsDefined(outfitSystem) { return; }
  if NotEquals(option.optionData, 3302) && NotEquals(option.optionData, 3303) {
    parts = outfitSystem.GetOutfitParts(StringToName(option.optionText));
  }
  if Equals(option.optionData, 3302) {
    selectedCount = this.CountNfrPuppetBaseSlotItems();
  } else {
    selectedCount = Equals(option.optionData, 3303)
      ? ArraySize(outfitSystem.GetUsedSlots())
      : this.CountNfrOutfitParts(parts);
  }
  this.UpdateNfrClothingStatus(selectedCount);
  if !this.m_nfrClothingCatalogBuilt { return; }
  selectedCount = 0;
  for slotBrowser in this.m_nfrClothingSlots {
    selectedItem = ItemID.None();
    if option.optionData == 3303 {
      for itemID in slotBrowser.itemIDs {
        if outfitSystem.IsEquipped(itemID) {
          selectedItem = itemID;
          break;
        }
      }
    } else {
      for part in parts {
        if Equals(part.GetSlotID(), slotBrowser.slotID) {
          selectedItem = part.GetItemID();
          break;
        }
      }
    }
    slotBrowser.activeItemID = selectedItem;
    if ItemID.IsValid(selectedItem) { selectedCount += 1; }
    selectedIndex = this.FindNfrClothingItemIndex(slotBrowser, selectedItem);
    if selectedIndex < 0 { selectedIndex = 0; }
    if selectedIndex > 0 { slotBrowser.activeItemID = slotBrowser.itemIDs[selectedIndex]; }
    if slotBrowser.itemsLoaded {
      slotBrowser.control.presenter.SetActiveIdentity(selectedIndex);
      slotBrowser.control.SyncOwnedValueLabel();
      if selectedIndex == 0 { slotBrowser.control.optionLabel.SetText(""); }
    } else {
      slotBrowser.control.optionLabel.SetText(
        ItemID.IsValid(selectedItem) ? outfitSystem.GetItemName(selectedItem) : ""
      );
    }
    this.UpdateNfrClothingSlotCardVisuals(slotBrowser);
  }
  this.UpdateNfrClothingStatus(selectedCount);
  NfrLog.Debug(s"Synchronized clothing slot controls to Photo Mode outfit option=\(option.optionText).");
}

/** Finds a slot item by record identity so preview-instance differences cannot break selection.
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
 * @param slotBrowser Slot catalog to search. @param itemID Selected outfit item.
 * @return Ordered item index, or minus one when absent. @errors Invalid values return minus one. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func FindNfrClothingItemIndex(
  slotBrowser: ref<NfrPhotoModeClothingSlotBrowser>,
  itemID: ItemID
) -> Int32 {
  let itemIndex: Int32;
  if !IsDefined(slotBrowser) || !ItemID.IsValid(itemID) { return -1; }
  while itemIndex < ArraySize(slotBrowser.itemIDs) {
    if Equals(
      ItemID.GetTDBID(slotBrowser.itemIDs[itemIndex]),
      ItemID.GetTDBID(itemID)
    ) {
      return itemIndex;
    }
    itemIndex += 1;
  }
  return -1;
}

/** Updates the parent Clothing value without coupling it to child card identities.
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
 * @param activeCount Number of outfit-derived active slot items. @return None.
 * @errors A not-yet-mounted value label is ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrClothingStatus(activeCount: Int32) -> Void {
  this.m_nfrClothingActiveCount = activeCount;
  if !IsDefined(this.m_nfrClothingControl) || !IsDefined(this.m_nfrClothingControl.optionLabel) {
    return;
  }
  this.m_nfrClothingControl.optionLabel.SetText(
    this.m_nfrClothingCustomPreview
      ? NfrText.ItemCount(activeCount, true)
      : NfrText.ItemCount(activeCount, false)
  );
  this.UpdateNfrClothingActionState();
}

/** Enables Clothing actions only when they would change the current preview.
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
 * @param None. @return None. @errors Missing action widgets are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrClothingActionState() -> Void {
  let canClear = this.m_nfrClothingActiveCount > 0;
  let canReset = this.m_nfrClothingCustomPreview;
  if IsDefined(this.m_nfrClothingClearHit) {
    this.m_nfrClothingClearHit.SetInteractive(canClear);
  }
  if IsDefined(this.m_nfrClothingClearLabel) {
    this.m_nfrClothingClearLabel.SetOpacity(canClear ? 1.0 : 0.35);
  }
  if IsDefined(this.m_nfrClothingResetHit) {
    this.m_nfrClothingResetHit.SetInteractive(canReset);
  }
  if IsDefined(this.m_nfrClothingResetLabel) {
    this.m_nfrClothingResetLabel.SetOpacity(canReset ? 1.0 : 0.35);
  }
}

/** Creates one text action in an expandable control row's unused title/value region.
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
 * @param parent Row that owns the action.
 * @param name Stable widget name. @param text Player-visible action label.
 * @param x Horizontal origin. @param callback Release callback.
 * @param label Output text widget. @return Interactive action surface. @errors None. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CreateNfrClothingAction(
  parent: wref<inkCompoundWidget>,
  name: CName,
  text: String,
  x: Float,
  callback: CName,
  out label: wref<inkText>
) -> wref<inkWidget> {
  let hit = new inkCanvas();
  let actionLabel = new inkText();
  hit.SetName(name);
  hit.SetAnchor(inkEAnchor.TopLeft);
  hit.SetAnchorPoint(new Vector2(0.0, 0.0));
  hit.SetTranslation(new Vector2(x, 0.0));
  hit.SetSize(155.0, 88.0);
  hit.SetInteractive(true);
  hit.RegisterToCallback(n"OnRelease", this, callback);
  hit.Reparent(parent);
  actionLabel.SetText(text);
  actionLabel.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
  actionLabel.SetFontStyle(n"Regular");
  actionLabel.SetFontSize(30);
  actionLabel.SetAnchor(inkEAnchor.Fill);
  actionLabel.SetHorizontalAlignment(textHorizontalAlignment.Center);
  actionLabel.SetVerticalAlignment(textVerticalAlignment.Center);
  actionLabel.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
  actionLabel.BindProperty(n"tintColor", n"MainColors.ActiveRed");
  actionLabel.SetInteractive(false);
  actionLabel.Reparent(hit);
  label = actionLabel;
  return hit;
}

/**
 * Defers Clothing insertion until Equipment-EX has finished constructing the Outfit host.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrClothingAttachCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;

  /** Attempts insertion after the host layout settles. @param None. @return None.
   * @errors Released controllers are ignored. */
  public func Call() -> Void {
    if IsDefined(this.m_controller) {
      this.m_controller.ReconcileNfrClothingForPhotoModeShow();
    }
  }

  /** Creates one deferred attachment callback. @param controller Active Photo Mode controller.
   * @return New callback. @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>
  ) -> ref<NfrClothingAttachCallback> {
    let callback = new NfrClothingAttachCallback();
    callback.m_controller = controller;
    return callback;
  }
}

/** Inserts the owned Clothing browser between Outfit and the first native selector row.
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
 * @param reversedUI Host orientation. @return Host callback result.
 * @errors Missing Outfit ownership leaves the Clothing browser absent without moving native rows. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnShow(reversedUI: Bool) -> Bool {
  let result = wrappedMethod(reversedUI);
  this.ReconcileNfrClothingForPhotoModeShow();
  GameInstance.GetDelaySystem(this.GetPlayerControlledObject().GetGame()).DelayCallback(
    NfrClothingAttachCallback.Create(this),
    0.15,
    false
  );
  return result;
}

/** Starts each Photo Mode session from the native Outfit option and collapsed Clothing UI.
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
 * @param None. @return None. @errors Missing native Outfit state leaves prior labels untouched
 * until the deferred reconciliation retry. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ReconcileNfrClothingForPhotoModeShow() -> Void {
  let option: PhotoModeOptionSelectorData;
  this.EnsureNfrClothingBrowser();
  if !IsDefined(this.m_nfrClothingControl)
    || !IsDefined(this.m_nfrClothingControl.presenter)
    || !IsDefined(this.m_nfrClothingControl.presenter.browser) { return; }
  this.m_nfrClothingSyncRevision += 1;
  this.m_nfrClothingCustomPreview = false;
  this.ResetNfrClothingGroupSearch(n"clothing");
  this.m_nfrClothingControl.presenter.browser.SetExpanded(false);
  for slotBrowser in this.m_nfrClothingSlots {
    if IsDefined(slotBrowser) && IsDefined(slotBrowser.control)
      && IsDefined(slotBrowser.control.presenter)
      && IsDefined(slotBrowser.control.presenter.browser) {
      slotBrowser.control.presenter.browser.SetExpanded(false);
    }
  }
  option = this.GetNfrSelectedOutfitOption();
  if NotEquals(option.optionText, "") || Equals(option.optionData, 3302)
    || Equals(option.optionData, 3303) {
    this.SyncNfrClothingSlotsFromOutfitOption(option);
  }
}

/** Creates the top-level content-agnostic Clothing host at Outfit's following list index.
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
 * @param None. @return None. @errors Missing or detached Outfit hosts are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func EnsureNfrClothingBrowser() -> Void {
  let outfitHost = this.GetNfrOutfitBrowserHost();
  let parent: wref<inkCompoundWidget>;
  let items: array<ref<NfrExpandableCardItemModel>>;
  let model: ref<NfrExpandableCardControlModel>;
  let outfitSystem: wref<OutfitSystem>;
  let index: Int32 = 0;
  let count: Int32;
  if IsDefined(this.m_nfrClothingControl) { return; }
  if !IsDefined(outfitHost) {
    NfrLog.Trace("Clothing attachment is waiting for the Outfit browser host.");
    return;
  }
  parent = outfitHost.GetParentWidget() as inkCompoundWidget;
  if !IsDefined(parent) {
    NfrLog.Warn("Clothing attachment found a detached Outfit browser host.");
    return;
  }
  count = parent.GetNumChildren();
  while index < count && !Equals(parent.GetWidgetByIndex(index), outfitHost) { index += 1; }
  if index >= count {
    NfrLog.Warn("Clothing attachment could not locate Outfit in its reported parent.");
    return;
  }
  model = NfrExpandableCardControlModel.Create(n"clothing", NfrText.Clothing(), items, -1);
  this.m_nfrClothingControl = new NfrPhotoModeOwnedExpandableControl();
  if !this.m_nfrClothingControl.MountOwned(
    model,
    parent,
    index + 1,
    this,
    n"OnNfrClothingLineReleased",
    n"",
    n"",
    this.GetNfrOutfitReferenceRow(),
    this.GetNfrOutfitReferenceDisclosure(),
    true
  ) {
    this.m_nfrClothingControl = null;
    return;
  }
  this.m_nfrClothingControl.titleLabel.SetFontSize(45);
  this.m_nfrClothingClearHit = this.CreateNfrClothingAction(
    this.m_nfrClothingControl.rowRoot,
    n"nfr_clothing_clear",
    NfrText.Clear(),
    270.0,
    n"OnNfrClothingClearReleased",
    this.m_nfrClothingClearLabel
  );
  this.m_nfrClothingResetHit = this.CreateNfrClothingAction(
    this.GetNfrOutfitReferenceRow(),
    n"nfr_clothing_reset",
    NfrText.Reset(),
    270.0,
    n"OnNfrClothingResetReleased",
    this.m_nfrClothingResetLabel
  );
  this.m_nfrClothingSlotContainer = this.m_nfrClothingControl.CreateChildContainer(
    n"nfr_clothing_slot_container",
    13.0
  );
  this.m_nfrClothingControl.presenter.browser.host.SetMargin(
    new inkMargin(0.0, -1.0, 0.0, -1.0)
  );
  outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
  if IsDefined(outfitSystem) {
    this.SyncNfrClothingSlotsFromOutfitOption(this.GetNfrSelectedOutfitOption());
  } else {
    this.UpdateNfrClothingStatus(0);
  }
  NfrLog.Info("Attached the lazy Photo Mode Clothing browser host.");
}

/** Clears every Equipment-EX-managed item from V's Photo Mode preview puppet.
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
 * @param evt Pointer release. @return True when Clear was applied.
 * @errors Missing preview services leave the current preview unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrClothingClearReleased(evt: ref<inkPointerEvent>) -> Bool {
  let game = this.GetPlayerControlledObject().GetGame();
  let outfitSystem = OutfitSystem.GetInstance(game);
  let paperdoll = PaperdollHelper.GetInstance(game);
  let transactionSystem = GameInstance.GetTransactionSystem(game);
  let puppet: wref<gamePuppet>;
  if !IsDefined(evt) || !evt.IsAction(n"click") || this.m_nfrClothingActiveCount <= 0
    || !IsDefined(outfitSystem) || !IsDefined(paperdoll) || !IsDefined(transactionSystem) {
    return false;
  }
  puppet = paperdoll.GetPuppet();
  if !IsDefined(puppet) { return false; }
  // This is the clearing phase of Equipment-EX's EquipPuppetParts without its subsequent apply
  // phase. Clearing slots directly avoids reconstructing either an outfit or V's normal equipment.
  this.m_nfrClothingSyncRevision += 1;
  for slotID in this.GetNfrBaseClothingSlots() {
    transactionSystem.RemoveItemFromSlot(puppet, slotID);
  }
  for slotID in outfitSystem.GetOutfitSlots() {
    transactionSystem.RemoveItemFromSlot(puppet, slotID);
  }
  for slotBrowser in this.m_nfrClothingSlots {
    slotBrowser.activeItemID = ItemID.None();
    if slotBrowser.itemsLoaded {
      slotBrowser.control.presenter.SetActiveIdentity(0);
      slotBrowser.control.SyncOwnedValueLabel();
      slotBrowser.control.optionLabel.SetText("");
      this.UpdateNfrClothingSlotCardVisuals(slotBrowser);
    } else {
      slotBrowser.control.optionLabel.SetText("");
    }
  }
  this.m_nfrClothingCustomPreview = true;
  this.UpdateNfrClothingStatus(0);
  this.UpdateNfrClothingActionState();
  NfrLog.Info("Cleared all NFR-managed clothing from V's Photo Mode preview.");
  return true;
}

/** Restores the retained native Outfit selection after manual Clothing changes.
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
 * @param evt Pointer release. @return True when Reset was requested.
 * @errors Missing retained Outfit state leaves the current preview unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrClothingResetReleased(evt: ref<inkPointerEvent>) -> Bool {
  let game = this.GetPlayerControlledObject().GetGame();
  let outfitSystem = OutfitSystem.GetInstance(game);
  let paperdoll = PaperdollHelper.GetInstance(game);
  let puppet: wref<gamePuppet>;
  let option: PhotoModeOptionSelectorData;
  if !IsDefined(evt) || !evt.IsAction(n"click") || !this.m_nfrClothingCustomPreview {
    return false;
  }
  if !this.m_nfrClothingHasBaselineOption || !IsDefined(outfitSystem) || !IsDefined(paperdoll) {
    NfrLog.Warn("Reset could not restore clothing because its Photo Mode outfit baseline is unavailable.");
    return false;
  }
  puppet = paperdoll.GetPuppet();
  if !IsDefined(puppet) { return false; }
  option = this.m_nfrClothingBaselineOption;
  this.m_nfrClothingSyncRevision += 1;
  if Equals(option.optionData, 3302) {
    outfitSystem.EquipPuppetOutfit(puppet, false);
  } else {
    if Equals(option.optionData, 3303) {
      outfitSystem.EquipPuppetOutfit(puppet, true);
    } else {
      outfitSystem.EquipPuppetOutfit(puppet, StringToName(option.optionText));
    }
  }
  this.SyncNfrClothingSlotsFromOutfitOption(option);
  NfrLog.Info(s"Reset V's Photo Mode clothing to Outfit option=\(option.optionText).");
  return true;
}

/** Builds one real selector/card browser per nonempty Equipment-EX Wardrobe slot.
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
 * @param None. @return None. @errors Unavailable catalog services leave the parent browser empty. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func BuildNfrClothingSlotBrowsers() -> Void {
  let eligibleSlots: array<TweakDBID>;
  let config: ref<NfrPhotoModeClothingBrowserConfig>;
  if !IsDefined(this.m_nfrClothingSlotContainer) {
    NfrLog.Warn("Clothing slot controls are unavailable because the Wardrobe catalog is not ready.");
    return;
  }
  config = NfrPhotoModeClothingBrowserConfig.Create(
    "clothing",
    n"OnNfrClothingSlotLineReleased",
    n"OnNfrClothingSlotPreviousReleased",
    n"OnNfrClothingSlotNextReleased",
    eligibleSlots,
    false,
    true,
    false,
    null
  );
  this.m_nfrClothingSlots = this.BuildNfrPhotoModeClothingSlotControls(
    this.m_nfrClothingSlotContainer,
    config,
    this.GetNfrOutfitReferenceRow(),
    this.GetNfrOutfitReferenceDisclosure()
  );
  this.EnsureNfrClothingGroupSearch(
    n"clothing",
    this.m_nfrClothingSlotContainer,
    this.m_nfrClothingSlots,
    this.m_nfrClothingControl.rowRoot
  );
  this.m_nfrClothingCatalogBuilt = true;
  // Outfit selection can precede the lazy catalog. Reapply the retained native option only after
  // the slot rows exist so their identities never inherit stale player-equipped state.
  if this.m_nfrClothingHasBaselineOption {
    this.SyncNfrClothingSlotsFromOutfitOption(this.m_nfrClothingBaselineOption);
  } else {
    this.SyncNfrClothingSlotsFromOutfitOption(this.GetNfrSelectedOutfitOption());
  }
  NfrLog.Info(
    s"Built \(ArraySize(this.m_nfrClothingSlots)) lazy Photo Mode clothing slot controls."
  );
}

/** Counts slot controls whose retained identity currently represents an equipped outfit item.
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
 * @param None. @return Active clothing-slot count. @errors An empty catalog returns zero. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CountNfrActiveClothingSlots() -> Int32 {
  let count: Int32;
  for slotBrowser in this.m_nfrClothingSlots {
    if ItemID.IsValid(slotBrowser.activeItemID) { count += 1; }
  }
  return count;
}

/** Counts distinct populated slots in a saved Equipment-EX outfit snapshot.
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
 * @param parts Saved outfit parts. @return Number of unique slots containing valid items.
 * @errors Empty or invalid parts contribute nothing. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CountNfrOutfitParts(parts: array<ref<OutfitPart>>) -> Int32 {
  let slots: array<TweakDBID>;
  let isKnown: Bool;
  for part in parts {
    if IsDefined(part) && ItemID.IsValid(part.GetItemID()) {
      isKnown = false;
      for slotID in slots {
        if Equals(slotID, part.GetSlotID()) { isKnown = true; }
      }
      if !isKnown { ArrayPush(slots, part.GetSlotID()); }
    }
  }
  return ArraySize(slots);
}

/** Counts populated base equipment slots on the current Photo Mode preview puppet.
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
 * @param None. @return Number of populated Equipment-EX base slots.
 * @errors Missing preview services return zero. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CountNfrPuppetBaseSlotItems() -> Int32 {
  let game = this.GetPlayerControlledObject().GetGame();
  let paperdoll = PaperdollHelper.GetInstance(game);
  let transactionSystem = GameInstance.GetTransactionSystem(game);
  let puppet: wref<gamePuppet>;
  let count: Int32;
  if !IsDefined(paperdoll) || !IsDefined(transactionSystem) { return 0; }
  puppet = paperdoll.GetPuppet();
  if !IsDefined(puppet) { return 0; }
  for slotID in this.GetNfrBaseClothingSlots() {
    if IsDefined(transactionSystem.GetItemInSlot(puppet, slotID)) { count += 1; }
  }
  return count;
}

/** Returns the vanilla attachment slots Equipment-EX treats as its base clothing slots.
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
 * @param None. @return Stable base-slot identities for preview clearing and counting.
 * @errors None; changes to Equipment-EX's base-slot policy require compatibility validation. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func GetNfrBaseClothingSlots() -> array<TweakDBID> {
  return [
    t"AttachmentSlots.Head",
    t"AttachmentSlots.Eyes",
    t"AttachmentSlots.Chest",
    t"AttachmentSlots.Torso",
    t"AttachmentSlots.Legs",
    t"AttachmentSlots.Feet",
    t"AttachmentSlots.UnderwearTop",
    t"AttachmentSlots.UnderwearBottom"
  ];
}

/** Toggles the Clothing child-control container and refreshes Photo Mode's outer scroll range.
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
 * @param evt Pointer release. @return True when toggled. @errors Invalid events are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrClothingLineReleased(evt: ref<inkPointerEvent>) -> Bool {
  if !IsDefined(evt) || !evt.IsAction(n"click") || !IsDefined(this.m_nfrClothingControl) {
    return false;
  }
  this.UseNfrExpandableScrollContext(this.m_nfrClothingControl.rowRoot);
  this.BeginNfrExpandableScrollMutation(this.m_nfrClothingControl.rowRoot);
  if !this.m_nfrClothingControl.presenter.browser.isExpanded {
    this.CollapseNfrTopLevelExpandablePeers(n"clothing");
  } else {
    this.ResetNfrClothingGroupSearch(n"clothing");
  }
  if !this.m_nfrClothingCatalogBuilt { this.BuildNfrClothingSlotBrowsers(); }
  this.m_nfrClothingControl.presenter.browser.Toggle();
  this.ApplyNfrExpandableScrollPrediction();
  this.ScheduleNfrExpandableScrollRefresh();
  return true;
}

/** Toggles the slot browser whose title or active-item label received the click.
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
 * @param evt Pointer release. @return True when a slot was toggled. @errors Unknown targets are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrClothingSlotLineReleased(evt: ref<inkPointerEvent>) -> Bool {
  let target: wref<inkWidget>;
  if !IsDefined(evt) || !evt.IsAction(n"click") { return false; }
  target = evt.GetCurrentTarget();
  for slotBrowser in this.m_nfrClothingSlots {
    if Equals(target, slotBrowser.control.titleHit) || Equals(target, slotBrowser.control.optionHit) {
      if !this.EnsureNfrClothingSlotItemsLoaded(slotBrowser) { return false; }
      this.UseNfrExpandableScrollContext(slotBrowser.control.rowRoot);
      this.BeginNfrExpandableScrollMutation(slotBrowser.control.rowRoot);
      // Clothing slots inherit the parent Clothing query. Clearing the generic
      // per-browser query here would leave nonmatches hidden while allowing the
      // next expansion to restore their original, sparse grid positions.
      if slotBrowser.control.presenter.browser.isExpanded
        && !slotBrowser.control.presenter.browser.suppressOwnSearch {
        this.ResetNfrCardSearch(slotBrowser.control.presenter.browser);
      }
      if !slotBrowser.control.presenter.browser.isExpanded {
        this.CollapseNfrClothingSlotExpandablePeers(slotBrowser);
      }
      if !IsDefined(slotBrowser.control.presenter.content) {
        this.RebuildNfrExpandableCardControl(
          slotBrowser.control.presenter,
          this,
          n"OnNfrClothingSlotCardReleased"
        );
        this.UpdateNfrClothingSlotCardVisuals(slotBrowser);
      }
      slotBrowser.control.presenter.browser.Toggle();
      this.ApplyNfrExpandableScrollPrediction();
      this.ScheduleNfrExpandableScrollRefresh();
      return true;
    }
  }
  return false;
}

/** Collapses clothing-slot browsers other than the slot about to open.
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
 * @param exceptBrowser Slot browser that remains eligible to expand. @return None.
 * @errors Missing slot controls are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CollapseNfrClothingSlotExpandablePeers(
  exceptBrowser: ref<NfrPhotoModeClothingSlotBrowser>
) -> Void {
  for slotBrowser in this.m_nfrClothingSlots {
    if IsDefined(slotBrowser)
      && NotEquals(slotBrowser, exceptBrowser)
      && IsDefined(slotBrowser.control)
      && IsDefined(slotBrowser.control.presenter)
      && IsDefined(slotBrowser.control.presenter.browser)
      && slotBrowser.control.presenter.browser.isExpanded {
      if !slotBrowser.control.presenter.browser.suppressOwnSearch {
        this.ResetNfrCardSearch(slotBrowser.control.presenter.browser);
      }
      slotBrowser.control.presenter.browser.SetExpanded(false);
    }
  }
}

/** Selects the previous item in a clothing slot, wrapping at the start.
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
 * @param evt Pointer release. @return True when selection changed. @errors Unknown targets are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrClothingSlotPreviousReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.CycleNfrClothingSlot(evt, -1);
}

/** Selects the next item in a clothing slot, wrapping at the end.
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
 * @param evt Pointer release. @return True when selection changed. @errors Unknown targets are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrClothingSlotNextReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.CycleNfrClothingSlot(evt, 1);
}

/** Resolves an arrow target and cycles its slot's ordered Wardrobe items.
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
 * @param evt Pointer release. @param delta Minus one for previous or one for next.
 * @return True when an item was applied. @errors Missing puppets or empty slots are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CycleNfrClothingSlot(evt: ref<inkPointerEvent>, delta: Int32) -> Bool {
  let target: wref<inkWidget>;
  let index: Int32;
  if !IsDefined(evt) || !evt.IsAction(n"click") { return false; }
  target = evt.GetCurrentTarget();
  for slotBrowser in this.m_nfrClothingSlots {
    if (delta < 0 && Equals(target, slotBrowser.control.leftHit))
      || (delta > 0 && Equals(target, slotBrowser.control.rightHit)) {
      if !this.EnsureNfrClothingSlotItemsLoaded(slotBrowser) { return false; }
      index = slotBrowser.control.presenter.model.FindIndex(
        slotBrowser.control.presenter.model.activeIdentity
      );
      if index < 0 { index = delta > 0 ? 0 : ArraySize(slotBrowser.itemIDs) - 1; }
      else {
        index += delta;
        if index < 0 { index = ArraySize(slotBrowser.itemIDs) - 1; }
        if index >= ArraySize(slotBrowser.itemIDs) { index = 0; }
      }
      return this.ApplyNfrClothingSlotSelection(slotBrowser, index, false);
    }
  }
  return false;
}

/** Resolves names and ordered UI identities only when a slot is first used.
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
 * @param slotBrowser Lightweight slot catalog to materialize. @return True when its model is ready.
 * @errors Missing Equipment-EX state leaves the slot unloaded and safely retryable. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func EnsureNfrClothingSlotItemsLoaded(
  slotBrowser: ref<NfrPhotoModeClothingSlotBrowser>
) -> Bool {
  let outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
  let items: array<ref<NfrExpandableCardItemModel>>;
  let itemModel: ref<NfrExpandableCardItemModel>;
  let itemRecord: wref<Item_Record>;
  let iconRecord: wref<UIIcon_Record>;
  let sortedItemIDs: array<ItemID>;
  let orderedItemIDs: array<ItemID>;
  let itemID: ItemID;
  let insertionIndex: Int32;
  let activeIdentity: Int32 = 0;
  let index: Int32 = 0;
  if !IsDefined(slotBrowser) || !IsDefined(slotBrowser.control) { return false; }
  if slotBrowser.itemsLoaded { return true; }
  if !IsDefined(outfitSystem) { return false; }
  // Sort the retained identities themselves so card indices and previous/next cycling use one
  // authoritative alphabetical order.
  for itemID in slotBrowser.itemIDs {
    if NotEquals(itemID, slotBrowser.startingItemID) {
      insertionIndex = 0;
      while insertionIndex < ArraySize(sortedItemIDs)
        && StrCmp(
          StrLower(outfitSystem.GetItemName(sortedItemIDs[insertionIndex])),
          StrLower(outfitSystem.GetItemName(itemID))
        ) <= 0 {
        insertionIndex += 1;
      }
      ArrayInsert(sortedItemIDs, insertionIndex, itemID);
    }
  }
  ArrayPush(orderedItemIDs, ItemID.None());
  if ItemID.IsValid(slotBrowser.startingItemID) {
    ArrayPush(orderedItemIDs, slotBrowser.startingItemID);
  }
  for itemID in sortedItemIDs { ArrayPush(orderedItemIDs, itemID); }
  slotBrowser.itemIDs = orderedItemIDs;
  ArrayPush(items, NfrExpandableCardItemModel.Create(0, NfrText.None()));
  index = 1;
  while index < ArraySize(slotBrowser.itemIDs) {
    itemModel = NfrExpandableCardItemModel.Create(
      index,
      outfitSystem.GetItemName(slotBrowser.itemIDs[index])
    );
    itemRecord = TweakDBInterface.GetItemRecord(ItemID.GetTDBID(slotBrowser.itemIDs[index]));
    if IsDefined(itemRecord) {
      iconRecord = itemRecord.Icon();
      if IsDefined(iconRecord) {
        itemModel.SetIcon(iconRecord.AtlasResourcePath(), iconRecord.AtlasPartName());
      }
    }
    ArrayPush(items, itemModel);
    if Equals(slotBrowser.itemIDs[index], slotBrowser.activeItemID) {
      activeIdentity = index;
    }
    index += 1;
  }
  slotBrowser.control.presenter.model.SetItems(items);
  slotBrowser.control.presenter.SetActiveIdentity(activeIdentity);
  slotBrowser.control.SyncOwnedValueLabel();
  if activeIdentity == 0 { slotBrowser.control.optionLabel.SetText(""); }
  slotBrowser.itemsLoaded = true;
  NfrLog.Debug(
    s"Loaded \(ArraySize(items)) Photo Mode clothing item models for slot="
    + TDBID.ToStringDEBUG(slotBrowser.slotID) + "."
  );
  return true;
}

/** Applies the card selected in one generated clothing-slot browser.
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
 * @param evt Card release. @return True when an item was applied. @errors Stale cards are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrClothingSlotCardReleased(evt: ref<inkPointerEvent>) -> Bool {
  let index: Int32;
  if !IsDefined(evt) || !evt.IsAction(n"click") { return false; }
  for slotBrowser in this.m_nfrClothingSlots {
    index = 0;
    while index < ArraySize(slotBrowser.control.presenter.browser.cards) {
      if Equals(slotBrowser.control.presenter.browser.cards[index], evt.GetCurrentTarget()) {
        return this.ApplyNfrClothingSlotSelection(slotBrowser, index, true);
      }
      index += 1;
    }
  }
  return false;
}

/** Applies one authoritative slot transition for card and arrow input.
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
 * @param slotBrowser Owning slot selector. @param index Ordered target identity.
 * @param toggleActive Whether selecting the active item should clear it.
 * @return True when the preview changed. @errors Invalid state leaves the preview unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ApplyNfrClothingSlotSelection(
  slotBrowser: ref<NfrPhotoModeClothingSlotBrowser>,
  index: Int32,
  toggleActive: Bool
) -> Bool {
  let game = this.GetPlayerControlledObject().GetGame();
  let outfitSystem = OutfitSystem.GetInstance(game);
  let paperdoll = PaperdollHelper.GetInstance(game);
  let puppet: wref<gamePuppet>;
  let activeItemID: ItemID;
  let selectedItemID: ItemID;
  let shouldClear: Bool;
  if !IsDefined(slotBrowser) || index < 0 || index >= ArraySize(slotBrowser.itemIDs)
    || !IsDefined(outfitSystem) || !IsDefined(paperdoll) {
    return false;
  }
  puppet = paperdoll.GetPuppet();
  if !IsDefined(puppet) {
    NfrLog.Warn("Clothing selection could not find the Photo Mode preview puppet.");
    return false;
  }
  activeItemID = slotBrowser.activeItemID;
  selectedItemID = slotBrowser.itemIDs[index];
  shouldClear = index == 0 || (toggleActive && Equals(selectedItemID, activeItemID));
  if shouldClear && !ItemID.IsValid(activeItemID) { return false; }
  if !shouldClear && Equals(selectedItemID, activeItemID) { return false; }

  return this.RequestNfrClothingSwap(
    puppet,
    slotBrowser,
    index,
    selectedItemID,
    shouldClear
  );
}

/** Applies the standard red/blue card treatment for one clothing slot's active identity.
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
 * @param slotBrowser Slot presenter to refresh. @return None. @errors Missing card internals are skipped. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrClothingSlotCardVisuals(
  slotBrowser: ref<NfrPhotoModeClothingSlotBrowser>
) -> Void {
  let root: wref<inkCompoundWidget>;
  let frame: wref<inkWidget>;
  let background: wref<inkWidget>;
  let label: wref<inkWidget>;
  let selected: Bool;
  let index: Int32 = 0;
  if !IsDefined(slotBrowser) { return; }
  while index < ArraySize(slotBrowser.control.presenter.browser.cards) {
    root = slotBrowser.control.presenter.browser.cards[index] as inkCompoundWidget;
    frame = root.GetWidgetByPathName(n"frameImg");
    background = root.GetWidgetByPathName(n"bgRect");
    label = root.GetWidgetByPathName(n"nfrExpandableCardLabel");
    selected = Equals(index, slotBrowser.control.presenter.model.activeIdentity);
    if IsDefined(frame) {
      frame.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
      frame.BindProperty(n"tintColor", selected ? n"MainColors.ActiveBlue" : n"MainColors.ActiveRed");
      frame.SetOpacity(1.0);
    }
    if IsDefined(background) {
      background.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
      background.BindProperty(n"tintColor", selected ? n"MainColors.ActiveBlue" : n"MainColors.ActiveRed");
      background.SetOpacity(selected ? 0.40 : 0.0);
    }
    if IsDefined(label) {
      label.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
      label.BindProperty(n"tintColor", selected ? n"MainColors.ActiveBlue" : n"MainColors.ActiveRed");
    }
    index += 1;
  }
}

/** Releases the owned Clothing host before the native Photo Mode tree is destroyed.
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
 * @param None. @return None. @errors Partial initialization is safe. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnUninitialize() -> Void {
  let parent: wref<inkCompoundWidget>;
  let cardIndex: Int32;
  this.ReleaseNfrClothingAttachmentListener();
  for slotBrowser in this.m_nfrClothingSlots {
    this.ReleaseNfrCardSearch(slotBrowser.control.presenter.browser);
    slotBrowser.control.ReleaseOwnedHooks(
      this,
      n"OnNfrClothingSlotLineReleased",
      n"OnNfrClothingSlotPreviousReleased",
      n"OnNfrClothingSlotNextReleased"
    );
    cardIndex = 0;
    while cardIndex < ArraySize(slotBrowser.control.presenter.browser.cards) {
      slotBrowser.control.presenter.browser.cards[cardIndex].UnregisterFromCallback(
        n"OnRelease",
        this,
        n"OnNfrClothingSlotCardReleased"
      );
      cardIndex += 1;
    }
  }
  ArrayClear(this.m_nfrClothingSlots);
  this.m_nfrClothingCatalogBuilt = false;
  this.m_nfrClothingCustomPreview = false;
  this.m_nfrClothingHasBaselineOption = false;
  this.m_nfrClothingActiveCount = 0;
  if IsDefined(this.m_nfrClothingClearHit) {
    this.m_nfrClothingClearHit.UnregisterFromCallback(
      n"OnRelease", this, n"OnNfrClothingClearReleased"
    );
  }
  if IsDefined(this.m_nfrClothingResetHit) {
    this.m_nfrClothingResetHit.UnregisterFromCallback(
      n"OnRelease", this, n"OnNfrClothingResetReleased"
    );
  }
  if IsDefined(this.m_nfrClothingControl) {
    this.m_nfrClothingControl.ReleaseOwnedHooks(
      this,
      n"OnNfrClothingLineReleased",
      n"",
      n""
    );
    if IsDefined(this.m_nfrClothingControl.presenter)
      && IsDefined(this.m_nfrClothingControl.presenter.browser)
      && IsDefined(this.m_nfrClothingControl.presenter.browser.host) {
      parent = this.m_nfrClothingControl.presenter.browser.host.GetParentWidget()
        as inkCompoundWidget;
      if IsDefined(parent) {
        parent.RemoveChild(this.m_nfrClothingControl.presenter.browser.host);
      }
    }
  }
  this.m_nfrClothingSlotContainer = null;
  this.m_nfrClothingControl = null;
  this.m_nfrClothingClearHit = null;
  this.m_nfrClothingClearLabel = null;
  this.m_nfrClothingResetHit = null;
  this.m_nfrClothingResetLabel = null;
  wrappedMethod();
}
