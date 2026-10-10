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
private let m_nfrNpcClothingControl: ref<NfrPhotoModeOwnedExpandableControl>;

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
private let m_nfrNpcClothingContainer: wref<inkVerticalPanel>;

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
private let m_nfrNpcClothingSlots: array<ref<NfrPhotoModeClothingSlotBrowser>>;

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
private let m_nfrNpcClothingCatalogBuilt: Bool;

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
private let m_nfrNpcClothingTarget: wref<gamePuppet>;

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
private let m_nfrNpcClothingCustomPreview: Bool;

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
private let m_nfrNpcClothingClearHit: wref<inkWidget>;

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
private let m_nfrNpcClothingClearLabel: wref<inkText>;

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
private let m_nfrNpcAppearanceRefreshPending: Bool;

/**
 * Re-adds retained clothing after a settled active NPC has processed preview removal.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrNpcClothingDelayedAddCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;
  private let m_target: wref<gamePuppet>;
  private let m_generation: Int32;

  /** Completes retained preview reconstruction. @param None. @return None. @errors Stale owners are ignored. */
  public func Call() -> Void {
    if IsDefined(this.m_controller) {
      this.m_controller.CompleteNfrNpcClothingDelayedReplay(
        this.m_target, this.m_generation
      );
    }
  }

  /** Creates the delayed add callback.
   * @param controller Owner. @param target Expected active NPC. @param generation Switch generation.
   * @return Deferred callback. @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>,
    target: wref<gamePuppet>,
    generation: Int32
  ) -> ref<NfrNpcClothingDelayedAddCallback> {
    let callback = new NfrNpcClothingDelayedAddCallback();
    callback.m_controller = controller;
    callback.m_target = target;
    callback.m_generation = generation;
    return callback;
  }
}

/**
 * Retains NFR-applied slot overrides for one live Photo Mode NPC puppet.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrNpcClothingPreviewState extends IScriptable {
  public let target: wref<gamePuppet>;
  public let recordID: TweakDBID;
  public let slotIDs: array<TweakDBID>;
  public let itemIDs: array<ItemID>;
  public let removedItemIDs: array<ItemID>;
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
private let m_nfrNpcClothingPreviewStates: array<ref<NfrNpcClothingPreviewState>>;

/** Reconciles the optional NPC Clothing surface when a new Photo Mode session opens.
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
 * @errors Missing or already-released NPC Clothing widgets are ignored. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnShow(reversedUI: Bool) -> Bool {
  let result = wrappedMethod(reversedUI);
  this.ResetNfrNpcControlsForPhotoModeShow();
  return result;
}

/** Clears target-specific NPC Clothing state when a new Photo Mode session begins.
 * The reusable owned row remains allocated but hidden until a newly active NPC is reconciled.
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
 * @param None. @return None. @errors Released targets and absent widgets are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ResetNfrNpcClothingForPhotoModeShow() -> Void {
  let player = this.GetPlayerControlledObject() as PlayerPuppet;
  this.DeactivateNfrNpcClothingBrowser();
  ArrayClear(this.m_nfrNpcClothingPreviewStates);
  ArrayClear(this.m_nfrNpcAppearanceVisibilityStates);
  if IsDefined(player) { player.ResetNfrPhotoModeNpcPuppets(); }
}

/** Inserts the temporary NPC clothing picker before the active NPC Appearance row.
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
 * @param None. @return None. @errors Missing native NPC bindings leave the browser absent. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func EnsureNfrNpcClothingBrowser() -> Void {
  let row: wref<inkCompoundWidget>;
  let insertionAnchor: wref<inkWidget>;
  let parent: wref<inkCompoundWidget>;
  let target: wref<gamePuppet>;
  let items: array<ref<NfrExpandableCardItemModel>>;
  let model: ref<NfrExpandableCardControlModel>;
  let index: Int32;
  if !NfrSettings.IsNpcClothingEnabled() {
    if IsDefined(this.m_nfrNpcClothingControl) {
      this.UpdateNfrNpcClothingVisibility();
    }
    return;
  }
  target = this.GetNfrNpcClothingTarget();
  if IsDefined(this.m_nfrNpcClothingControl) {
    if this.m_nfrNpcAppearanceRefreshPending {
      // The native appearance has settled. Keep the parent open and rebuild its children against
      // the replacement component collection rather than retaining stale cards.
      this.ReleaseNfrNpcAppearanceBrowser();
      this.ReleaseNfrNpcClothingSlotControls();
      this.m_nfrNpcClothingTarget = target;
      this.m_nfrNpcClothingCustomPreview = false;
      this.m_nfrNpcAppearanceRefreshPending = false;
      if this.m_nfrNpcClothingControl.presenter.browser.isExpanded {
        this.BuildNfrNpcClothingSlots();
      }
      this.UpdateNfrNpcClothingVisibility();
      this.UpdateNfrNpcClothingStatus();
    } else {
      if IsDefined(target) && NotEquals(target, this.m_nfrNpcClothingTarget) {
      // The parent host survives active-character navigation, so its expansion flag must not
      // describe child rows that belong to the previous puppet.
      this.ResetNfrClothingGroupSearch(n"npc_clothing");
      this.m_nfrNpcClothingControl.presenter.browser.SetExpanded(false);
      this.ReleaseNfrNpcAppearanceBrowser();
      this.ReleaseNfrNpcClothingSlotControls();
      this.m_nfrNpcClothingTarget = target;
      this.m_nfrNpcClothingCustomPreview = false;
      this.ReplayNfrNpcAppearanceVisibilityState(target);
      this.UpdateNfrNpcClothingVisibility();
      this.UpdateNfrNpcClothingStatus();
      }
    }
    return;
  }
  if !IsDefined(this.m_nfrNpcAppearanceAdapter)
    || !IsDefined(this.m_nfrNpcAppearanceAdapter.binding) {
    return;
  }
  row = this.m_nfrNpcAppearanceAdapter.binding.rowRoot;
  insertionAnchor = this.m_nfrNpcAppearanceAdapter.binding.presenter.browser.host;
  parent = insertionAnchor.GetParentWidget() as inkCompoundWidget;
  if !IsDefined(row) || !IsDefined(parent) { return; }
  index = this.FindNfrNpcClothingChildIndex(parent, insertionAnchor);
  if index < 0 { return; }
  model = NfrExpandableCardControlModel.Create(
    n"npc_clothing", NfrText.Clothing(), items, -1
  );
  this.m_nfrNpcClothingControl = new NfrPhotoModeOwnedExpandableControl();
  if !this.m_nfrNpcClothingControl.MountOwned(
    model,
    parent,
    index + 1,
    this,
    n"OnNfrNpcClothingLineReleased",
    n"",
    n"",
    row,
    this.m_nfrNpcAppearanceAdapter.binding.presenter.browser.disclosure,
    true
  ) {
    this.m_nfrNpcClothingControl = null;
    return;
  }
  this.m_nfrNpcClothingControl.optionLabel.SetText(NfrText.ItemCount(0, false));
  this.m_nfrNpcClothingControl.titleLabel.SetFontSize(45);
  this.m_nfrNpcClothingClearHit = this.CreateNfrClothingAction(
    this.m_nfrNpcClothingControl.rowRoot,
    n"nfr_npc_clothing_clear",
    NfrText.Clear(),
    270.0,
    n"OnNfrNpcClothingClearReleased",
    this.m_nfrNpcClothingClearLabel
  );
  if IsDefined(this.m_nfrNpcClothingClearHit) {
    this.m_nfrNpcClothingClearHit.RegisterToCallback(
      n"OnPress", this, n"OnNfrNpcClothingClearReleased"
    );
  }
  this.m_nfrNpcClothingContainer = this.m_nfrNpcClothingControl.CreateChildContainer(
    n"nfr_npc_clothing_slots", 13.0
  );
  this.m_nfrNpcClothingControl.presenter.browser.host.SetMargin(
    new inkMargin(0.0, -1.0, 0.0, -1.0)
  );
  this.EnsureNfrPhotoModeControlsInputGuardFor(row);
  this.UseNfrExpandableScrollContext(row);
  this.m_nfrNpcClothingTarget = target;
  this.UpdateNfrNpcClothingVisibility();
  NfrLog.Info("Attached temporary NPC clothing feasibility browser.");
}

/** Finds a native row's current child position.
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
 * @param parent List owner. @param child Native row.
 * @return Zero-based index or -1. @errors Detached rows return -1. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func FindNfrNpcClothingChildIndex(
  parent: wref<inkCompoundWidget>, child: wref<inkWidget>
) -> Int32 {
  let index: Int32;
  if !IsDefined(parent) || !IsDefined(child) { return -1; }
  while index < parent.GetNumChildren() {
    if Equals(parent.GetWidgetByIndex(index), child) { return index; }
    index += 1;
  }
  return -1;
}

/** Toggles the browser and lazily builds its slot controls.
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
 * @param evt Pointer release. @return True when handled. @errors Invalid events are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcClothingLineReleased(evt: ref<inkPointerEvent>) -> Bool {
  if !NfrSettings.IsNpcClothingEnabled()
    || !IsDefined(evt) || !evt.IsAction(n"click")
    || !IsDefined(this.m_nfrNpcClothingControl) { return false; }
  if !this.m_nfrNpcClothingCatalogBuilt { this.BuildNfrNpcClothingSlots(); }
  this.UseNfrExpandableScrollContext(this.m_nfrNpcClothingControl.rowRoot);
  this.BeginNfrExpandableScrollMutation(this.m_nfrNpcClothingControl.rowRoot);
  if this.m_nfrNpcClothingControl.presenter.browser.isExpanded {
    this.ResetNfrClothingGroupSearch(n"npc_clothing");
  }
  this.m_nfrNpcClothingControl.presenter.browser.Toggle();
  this.ApplyNfrExpandableScrollPrediction();
  this.ScheduleNfrExpandableScrollRefresh();
  return true;
}

/** Builds lightweight NPC test slot controls from Wardrobe identities.
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
 * @param None. @return None. @errors Missing catalog services leave the picker retryable. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func BuildNfrNpcClothingSlots() -> Void {
  let target = this.GetNfrNpcClothingTarget();
  let availableSlots: array<TweakDBID>;
  let config: ref<NfrPhotoModeClothingBrowserConfig>;
  if !NfrSettings.IsNpcClothingEnabled()
    || !IsDefined(this.m_nfrNpcClothingContainer) || !IsDefined(target)
    || !IsDefined(this.m_nfrNpcAppearanceAdapter)
    || !IsDefined(this.m_nfrNpcAppearanceAdapter.binding) { return; }
  availableSlots = TweakDBInterface.GetForeignKeyArray(target.GetRecordID() + t".attachmentSlots");
  config = NfrPhotoModeClothingBrowserConfig.Create(
    "npc_clothing",
    n"OnNfrNpcClothingSlotReleased",
    n"OnNfrNpcClothingPreviousReleased",
    n"OnNfrNpcClothingNextReleased",
    availableSlots,
    true,
    false,
    true,
    target
  );
  this.m_nfrNpcClothingSlots = this.BuildNfrPhotoModeClothingSlotControls(
    this.m_nfrNpcClothingContainer,
    config,
    this.m_nfrNpcAppearanceAdapter.binding.rowRoot,
    this.m_nfrNpcAppearanceAdapter.binding.presenter.browser.disclosure
  );
  this.BuildNfrNpcAppearanceBrowser(
    this.m_nfrNpcClothingContainer,
    target,
    this.m_nfrNpcAppearanceAdapter.binding.rowRoot,
    this.m_nfrNpcAppearanceAdapter.binding.presenter.browser.disclosure
  );
  this.EnsureNfrClothingGroupSearch(
    n"npc_clothing",
    this.m_nfrNpcClothingContainer,
    this.m_nfrNpcClothingSlots,
    this.m_nfrNpcClothingControl.rowRoot
  );
  this.SyncNfrNpcClothingSlotsFromState(target);
  this.m_nfrNpcClothingCatalogBuilt = true;
  this.UpdateNfrNpcClothingVisibility();
  this.UpdateNfrNpcClothingStatus();
  NfrLog.Info(
    s"Built \(ArraySize(this.m_nfrNpcClothingSlots)) NPC clothing slots from "
    + s"\(ArraySize(availableSlots)) target attachment slots."
  );
}

/** Expands one NPC test slot and materializes its cards.
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
 * @param evt Pointer release. @return True when handled. @errors Unknown targets are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcClothingSlotReleased(evt: ref<inkPointerEvent>) -> Bool {
  let target: wref<inkWidget>;
  if !IsDefined(evt) || !evt.IsAction(n"click") { return false; }
  target = evt.GetCurrentTarget();
  for slotBrowser in this.m_nfrNpcClothingSlots {
    if Equals(target, slotBrowser.control.titleHit) || Equals(target, slotBrowser.control.optionHit) {
      if !this.EnsureNfrClothingSlotItemsLoaded(slotBrowser) { return false; }
      this.UseNfrExpandableScrollContext(slotBrowser.control.rowRoot);
      this.BeginNfrExpandableScrollMutation(slotBrowser.control.rowRoot);
      if slotBrowser.control.presenter.browser.isExpanded
        && !slotBrowser.control.presenter.browser.suppressOwnSearch {
        this.ResetNfrCardSearch(slotBrowser.control.presenter.browser);
      }
      this.CollapseNfrNpcClothingSlotPeers(slotBrowser);
      if !IsDefined(slotBrowser.control.presenter.content) {
        this.RebuildNfrExpandableCardControl(
          slotBrowser.control.presenter,
          this,
          n"OnNfrNpcClothingCardReleased"
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

/** Invalidates all NPC Clothing children before Photo Mode reconstructs a native appearance.
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
 * @param None. @return None. @errors Partially initialized controls are safe. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func PrepareNfrNpcClothingForAppearanceChange() -> Void {
  if !NfrSettings.IsNpcClothingEnabled() { return; }
  this.ClearNfrNpcAppearanceVisibilityState(this.GetNfrNpcClothingTarget());
  this.ClearNfrNpcClothingItems();
  this.ReleaseNfrNpcAppearanceBrowser();
  this.ReleaseNfrNpcClothingSlotControls();
  this.m_nfrNpcAppearanceRefreshPending = true;
}

/** Selects the previous item for the clicked NPC clothing slot.
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
 * @param evt Arrow release. @return True when applied. @errors Unknown targets are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcClothingPreviousReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.CycleNfrNpcClothingSlot(evt, -1);
}

/** Selects the next item for the clicked NPC clothing slot.
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
 * @param evt Arrow release. @return True when applied. @errors Unknown targets are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcClothingNextReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.CycleNfrNpcClothingSlot(evt, 1);
}

/** Resolves an NPC slot arrow and cycles its alphabetized item identities.
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
 * @param evt Arrow release. @param delta Direction. @return True when applied.
 * @errors Empty or unknown slot controls are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CycleNfrNpcClothingSlot(evt: ref<inkPointerEvent>, delta: Int32) -> Bool {
  let target: wref<inkWidget>;
  let index: Int32;
  if !NfrSettings.IsNpcClothingEnabled()
    || !IsDefined(evt) || !evt.IsAction(n"click") { return false; }
  target = evt.GetCurrentTarget();
  for slotBrowser in this.m_nfrNpcClothingSlots {
    if (delta < 0 && Equals(target, slotBrowser.control.leftHit))
      || (delta > 0 && Equals(target, slotBrowser.control.rightHit)) {
      if !this.EnsureNfrClothingSlotItemsLoaded(slotBrowser) { return false; }
      index = slotBrowser.control.presenter.model.activeIdentity;
      if index < 0 { index = delta > 0 ? 0 : ArraySize(slotBrowser.itemIDs) - 1; }
      else {
        index += delta;
        if index < 0 { index = ArraySize(slotBrowser.itemIDs) - 1; }
        if index >= ArraySize(slotBrowser.itemIDs) { index = 0; }
      }
      return this.ApplyNfrNpcClothingItem(slotBrowser, index);
    }
  }
  return false;
}

/** Returns the most recently initialized NPC target for the temporary picker.
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
 * @param None. @return NPC puppet or null. @errors Missing players return null. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func GetNfrNpcClothingTarget() -> wref<gamePuppet> {
  let player = this.GetPlayerControlledObject() as PlayerPuppet;
  return IsDefined(player) ? player.GetNfrActivePhotoModeNpcPuppet() : null;
}

/** Collapses other NPC clothing slots.
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
 * @param exceptBrowser Slot remaining eligible to open.
 * @return None. @errors Missing controls are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CollapseNfrNpcClothingSlotPeers(
  exceptBrowser: ref<NfrPhotoModeClothingSlotBrowser>
) -> Void {
  for slotBrowser in this.m_nfrNpcClothingSlots {
    if IsDefined(slotBrowser) && NotEquals(slotBrowser, exceptBrowser)
      && IsDefined(slotBrowser.control) && slotBrowser.control.presenter.browser.isExpanded {
      if !slotBrowser.control.presenter.browser.suppressOwnSearch {
        this.ResetNfrCardSearch(slotBrowser.control.presenter.browser);
      }
      slotBrowser.control.presenter.browser.SetExpanded(false);
    }
  }
}

/** Selects or clears one test item on the latest NPC puppet.
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
 * @param evt Card release. @return True when the NPC was changed. @errors Stale cards are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcClothingCardReleased(evt: ref<inkPointerEvent>) -> Bool {
  let index: Int32;
  if !NfrSettings.IsNpcClothingEnabled()
    || !IsDefined(evt) || !evt.IsAction(n"click") { return false; }
  for slotBrowser in this.m_nfrNpcClothingSlots {
    index = 0;
    while index < ArraySize(slotBrowser.control.presenter.browser.cards) {
      if Equals(slotBrowser.control.presenter.browser.cards[index], evt.GetCurrentTarget()) {
        return this.ApplyNfrNpcClothingItem(slotBrowser, index);
      }
      index += 1;
    }
  }
  return false;
}

/** Applies one selected Wardrobe item or removes it when selected again.
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
 * @param slotBrowser Owning slot. @param index Selected card index. @return True on mutation.
 * @errors Missing or changed NPC targets leave the card state unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ApplyNfrNpcClothingItem(
  slotBrowser: ref<NfrPhotoModeClothingSlotBrowser>, index: Int32
) -> Bool {
  let player = this.GetPlayerControlledObject() as PlayerPuppet;
  let outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
  let target: wref<gamePuppet>;
  let oldIndex: Int32;
  if !NfrSettings.IsNpcClothingEnabled()
    || !IsDefined(player) || !IsDefined(outfitSystem) || !IsDefined(slotBrowser)
    || index < 0 || index >= ArraySize(slotBrowser.itemIDs) { return false; }
  target = player.GetNfrActivePhotoModeNpcPuppet();
  if !IsDefined(target) { return false; }
  if IsDefined(this.m_nfrNpcClothingTarget)
    && NotEquals(this.m_nfrNpcClothingTarget, target) {
    // Active-character navigation retains both puppets. Do not mutate the previous target; reject a
    // stale row event until the target-specific controls are rebuilt for the newly active puppet.
    return false;
  }
  this.m_nfrNpcClothingTarget = target;
  oldIndex = slotBrowser.control.presenter.model.activeIdentity;
  if index == 0 {
    if oldIndex > 0 && oldIndex < ArraySize(slotBrowser.itemIDs) {
      outfitSystem.UnequipPuppetItem(target, slotBrowser.itemIDs[oldIndex]);
    }
    slotBrowser.activeItemID = ItemID.None();
    slotBrowser.control.presenter.SetActiveIdentity(0);
    slotBrowser.control.optionLabel.SetText("");
    this.SetNfrNpcClothingPreviewState(
      target,
      slotBrowser.slotID,
      ItemID.None(),
      oldIndex > 0 && oldIndex < ArraySize(slotBrowser.itemIDs)
        ? slotBrowser.itemIDs[oldIndex]
        : slotBrowser.startingItemID
    );
    this.UpdateNfrClothingSlotCardVisuals(slotBrowser);
    this.m_nfrNpcClothingCustomPreview = true;
    this.UpdateNfrNpcClothingStatus();
    return oldIndex > 0;
  }
  if oldIndex == index {
    outfitSystem.UnequipPuppetItem(target, slotBrowser.itemIDs[index]);
    slotBrowser.activeItemID = ItemID.None();
    slotBrowser.control.presenter.SetActiveIdentity(0);
    this.SetNfrNpcClothingPreviewState(
      target, slotBrowser.slotID, ItemID.None(), slotBrowser.itemIDs[index]
    );
    NfrLog.Trace(
      s"[PM-NPC-CLOTHING][CLEAR] entity=\(EntityID.GetHash(target.GetEntityID())) "
      + s"item=\(TDBID.ToStringDEBUG(ItemID.GetTDBID(slotBrowser.itemIDs[index])))."
    );
  } else {
    if oldIndex >= 0 && oldIndex < ArraySize(slotBrowser.itemIDs) {
      outfitSystem.UnequipPuppetItem(target, slotBrowser.itemIDs[oldIndex]);
    }
    outfitSystem.EquipPuppetItem(target, slotBrowser.itemIDs[index]);
    slotBrowser.activeItemID = slotBrowser.itemIDs[index];
    slotBrowser.control.presenter.SetActiveIdentity(index);
    this.SetNfrNpcClothingPreviewState(
      target, slotBrowser.slotID, slotBrowser.itemIDs[index], ItemID.None()
    );
    NfrLog.Trace(
      s"[PM-NPC-CLOTHING][EQUIP] entity=\(EntityID.GetHash(target.GetEntityID())) "
      + s"record=\(TDBID.ToStringDEBUG(target.GetRecordID())) "
      + s"slot=\(TDBID.ToStringDEBUG(slotBrowser.slotID)) "
      + s"item=\(TDBID.ToStringDEBUG(ItemID.GetTDBID(slotBrowser.itemIDs[index])))."
    );
  }
  if ItemID.IsValid(slotBrowser.activeItemID) {
    slotBrowser.control.SyncOwnedValueLabel();
  } else {
    slotBrowser.control.optionLabel.SetText("");
  }
  this.UpdateNfrClothingSlotCardVisuals(slotBrowser);
  this.m_nfrNpcClothingCustomPreview = true;
  this.UpdateNfrNpcClothingStatus();
  return true;
}

/** Finds or creates the session state associated with one retained NPC puppet.
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
 * @param target Retained Photo Mode NPC. @param create Whether absence creates a state.
 * @return Matching state or null. @errors Released and absent targets return null. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func GetNfrNpcClothingPreviewState(
  target: wref<gamePuppet>, create: Bool
) -> ref<NfrNpcClothingPreviewState> {
  let state: ref<NfrNpcClothingPreviewState>;
  for candidate in this.m_nfrNpcClothingPreviewStates {
    if Equals(candidate.target, target)
      || (IsDefined(target) && Equals(candidate.recordID, target.GetRecordID())) {
      candidate.target = target;
      return candidate;
    }
  }
  if !create || !IsDefined(target) { return null; }
  state = new NfrNpcClothingPreviewState();
  state.target = target;
  state.recordID = target.GetRecordID();
  ArrayPush(this.m_nfrNpcClothingPreviewStates, state);
  return state;
}

/** Stores the explicit item or empty selection for one NPC slot.
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
 * @param target Retained Photo Mode NPC. @param slotID Equipment-EX slot.
 * @param itemID Selected item or invalid identity for NONE.
 * @param removedItemID Item to remove again if native reconstruction restores the slot. @return None.
 * @errors Missing targets leave session state unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func SetNfrNpcClothingPreviewState(
  target: wref<gamePuppet>, slotID: TweakDBID, itemID: ItemID, removedItemID: ItemID
) -> Void {
  let state = this.GetNfrNpcClothingPreviewState(target, true);
  let index: Int32;
  if !IsDefined(state) { return; }
  while index < ArraySize(state.slotIDs) {
    if Equals(state.slotIDs[index], slotID) {
      state.itemIDs[index] = itemID;
      state.removedItemIDs[index] = removedItemID;
      return;
    }
    index += 1;
  }
  ArrayPush(state.slotIDs, slotID);
  ArrayPush(state.itemIDs, itemID);
  ArrayPush(state.removedItemIDs, removedItemID);
}

/** Re-adds retained previews after the settled target processes their removal.
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
 * @param target Expected active NPC. @param generation NPC-switch generation. @return None.
 * @errors Stale targets or missing state cancel the replay safely. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func CompleteNfrNpcClothingDelayedReplay(
  target: wref<gamePuppet>, generation: Int32
) -> Void {
  let state: ref<NfrNpcClothingPreviewState>;
  let outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
  let index: Int32;
  if NotEquals(generation, this.m_nfrNpcBrowserGeneration)
    || !NfrSettings.IsNpcClothingEnabled()
    || !IsDefined(target)
    || NotEquals(target, this.GetNfrNpcClothingTarget())
    || !IsDefined(outfitSystem) {
    return;
  }
  state = this.GetNfrNpcClothingPreviewState(target, false);
  if !IsDefined(state) { return; }
  while index < ArraySize(state.itemIDs) {
    if ItemID.IsValid(state.itemIDs[index]) {
      outfitSystem.EquipPuppetItem(target, state.itemIDs[index]);
    }
    index += 1;
  }
  NfrLog.Trace(
    s"[PM-NPC-CLOTHING][DELAYED-ADD] entity=\(EntityID.GetHash(target.GetEntityID())) "
    + s"slots=\(ArraySize(state.slotIDs))."
  );
  this.ReplayNfrNpcAppearanceVisibilityState(target);
}

/** Replays retained clothing after native active-character activation has settled.
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
 * @param None. @return None.
 * @errors Missing, disabled, or stale targets leave the native appearance unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ReplayNfrActiveNpcClothingPreviewState() -> Void {
  let target = this.GetNfrNpcClothingTarget();
  let state: ref<NfrNpcClothingPreviewState>;
  let outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
  let delaySystem: ref<DelaySystem>;
  let index: Int32;
  if !NfrSettings.IsNpcClothingEnabled()
    || !IsDefined(target)
    || !IsDefined(this.m_nfrNpcClothingTarget)
    || NotEquals(target, this.m_nfrNpcClothingTarget)
    || !IsDefined(outfitSystem) {
    return;
  }
  state = this.GetNfrNpcClothingPreviewState(target, false);
  if !IsDefined(state) { return; }
  while index < ArraySize(state.itemIDs) {
    if ItemID.IsValid(state.itemIDs[index]) {
      outfitSystem.UnequipPuppetItem(target, state.itemIDs[index]);
    } else {
      if index < ArraySize(state.removedItemIDs) && ItemID.IsValid(state.removedItemIDs[index]) {
        outfitSystem.UnequipPuppetItem(target, state.removedItemIDs[index]);
      }
    }
    index += 1;
  }
  NfrLog.Trace(
    s"[PM-NPC-CLOTHING][DELAYED-REMOVE] entity=\(EntityID.GetHash(target.GetEntityID())) "
    + s"slots=\(ArraySize(state.slotIDs))."
  );
  delaySystem = GameInstance.GetDelaySystem(target.GetGame());
  delaySystem.DelayCallback(
    NfrNpcClothingDelayedAddCallback.Create(this, target, this.m_nfrNpcBrowserGeneration),
    0.15,
    false
  );
}

/** Synchronizes newly materialized slot rows with the target's retained session overrides.
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
 * @param target Active retained NPC. @return None.
 * @errors Missing state leaves discovered slot values unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func SyncNfrNpcClothingSlotsFromState(target: wref<gamePuppet>) -> Void {
  let state = this.GetNfrNpcClothingPreviewState(target, false);
  let outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
  let stateIndex: Int32;
  let itemIndex: Int32;
  if !IsDefined(state) { return; }
  for slotBrowser in this.m_nfrNpcClothingSlots {
    stateIndex = 0;
    while stateIndex < ArraySize(state.slotIDs) {
      if Equals(state.slotIDs[stateIndex], slotBrowser.slotID) {
        slotBrowser.activeItemID = state.itemIDs[stateIndex];
        if ItemID.IsValid(slotBrowser.activeItemID) && IsDefined(outfitSystem) {
          slotBrowser.control.optionLabel.SetText(
            outfitSystem.GetItemName(slotBrowser.activeItemID)
          );
        } else {
          slotBrowser.control.optionLabel.SetText("");
        }
        itemIndex = 0;
        while itemIndex < ArraySize(slotBrowser.itemIDs) {
          if Equals(slotBrowser.itemIDs[itemIndex], slotBrowser.activeItemID) {
            slotBrowser.control.presenter.SetActiveIdentity(itemIndex);
            break;
          }
          itemIndex += 1;
        }
        break;
      }
      stateIndex += 1;
    }
  }
}

/** Mirrors V's Clothing parent summary from the retained NPC slot selections.
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
 * @param None. @return None. @errors Missing parent UI is ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrNpcClothingStatus() -> Void {
  let count: Int32;
  let state: ref<NfrNpcClothingPreviewState>;
  if !IsDefined(this.m_nfrNpcClothingControl)
    || !IsDefined(this.m_nfrNpcClothingControl.optionLabel) { return; }
  for slotBrowser in this.m_nfrNpcClothingSlots {
    if ItemID.IsValid(slotBrowser.activeItemID) { count += 1; }
  }
  if ArraySize(this.m_nfrNpcClothingSlots) == 0 {
    state = this.GetNfrNpcClothingPreviewState(this.m_nfrNpcClothingTarget, false);
    if IsDefined(state) {
      for itemID in state.itemIDs {
        if ItemID.IsValid(itemID) { count += 1; }
      }
    }
  }
  this.m_nfrNpcClothingControl.optionLabel.SetText(
    NfrText.ItemCount(count, this.m_nfrNpcClothingCustomPreview)
  );
  if IsDefined(this.m_nfrNpcClothingClearHit) {
    this.m_nfrNpcClothingClearHit.SetInteractive(count > 0);
  }
  if IsDefined(this.m_nfrNpcClothingClearLabel) {
    this.m_nfrNpcClothingClearLabel.SetOpacity(count > 0 ? 1.0 : 0.35);
  }
}

/** Clears NFR-equipped item previews from the active NPC without changing appearance components.
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
 * @param evt Pointer release. @return True when at least one preview item was removed.
 * @errors Missing or stale target state leaves the NPC unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcClothingClearReleased(evt: ref<inkPointerEvent>) -> Bool {
  let outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
  let target = this.GetNfrNpcClothingTarget();
  let state: ref<NfrNpcClothingPreviewState>;
  let index: Int32;
  let cleared: Int32;
  if !NfrSettings.IsNpcClothingEnabled()
    || !IsDefined(evt) || !evt.IsAction(n"click") || !IsDefined(outfitSystem)
    || !IsDefined(target) || NotEquals(target, this.m_nfrNpcClothingTarget) {
    return false;
  }
  state = this.GetNfrNpcClothingPreviewState(target, true);
  while index < ArraySize(state.itemIDs) {
    if ItemID.IsValid(state.itemIDs[index]) {
      outfitSystem.UnequipPuppetItem(target, state.itemIDs[index]);
      if index < ArraySize(state.removedItemIDs) {
        state.removedItemIDs[index] = state.itemIDs[index];
      }
      state.itemIDs[index] = ItemID.None();
      cleared += 1;
    }
    index += 1;
  }
  for slotBrowser in this.m_nfrNpcClothingSlots {
    if ItemID.IsValid(slotBrowser.activeItemID) {
      if !this.NfrNpcClothingStateContainsRemovedItem(state, slotBrowser.activeItemID) {
        outfitSystem.UnequipPuppetItem(target, slotBrowser.activeItemID);
        this.SetNfrNpcClothingPreviewState(
          target, slotBrowser.slotID, ItemID.None(), slotBrowser.activeItemID
        );
        cleared += 1;
      }
    }
    slotBrowser.activeItemID = ItemID.None();
    slotBrowser.control.presenter.SetActiveIdentity(0);
    slotBrowser.control.optionLabel.SetText("");
    this.UpdateNfrClothingSlotCardVisuals(slotBrowser);
  }
  if cleared == 0 { return false; }
  this.m_nfrNpcClothingCustomPreview = true;
  this.UpdateNfrNpcClothingStatus();
  NfrLog.Info(
    s"Cleared \(cleared) NFR clothing item preview(s) from active NPC entity="
    + s"\(EntityID.GetHash(target.GetEntityID()))."
  );
  return true;
}

/** Tests whether retained clear state already processed an item visible in a materialized slot.
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
 * @param state Active NPC state. @param itemID Candidate preview item.
 * @return True when the item is already retained as removed. @errors Missing state returns false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func NfrNpcClothingStateContainsRemovedItem(
  state: ref<NfrNpcClothingPreviewState>, itemID: ItemID
) -> Bool {
  if !IsDefined(state) { return false; }
  for removedItemID in state.removedItemIDs {
    if Equals(removedItemID, itemID) { return true; }
  }
  return false;
}

/** Hides the complete NPC Clothing row when its target exposes no Equipment-EX outfit slot.
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
 * @param None. @return None. @errors Missing targets keep the row hidden. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrNpcClothingVisibility() -> Void {
  let target = this.GetNfrNpcClothingTarget();
  let outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
  let availableSlots: array<TweakDBID>;
  let visible: Bool;
  if NfrSettings.IsNpcClothingEnabled() && IsDefined(target) && IsDefined(outfitSystem) {
    availableSlots = TweakDBInterface.GetForeignKeyArray(target.GetRecordID() + t".attachmentSlots");
    for slotID in outfitSystem.GetOutfitSlots() {
      if ArrayContains(availableSlots, slotID) {
        visible = true;
        break;
      }
    }
  }
  if IsDefined(this.m_nfrNpcClothingControl)
    && IsDefined(this.m_nfrNpcClothingControl.presenter)
    && IsDefined(this.m_nfrNpcClothingControl.presenter.browser)
    && IsDefined(this.m_nfrNpcClothingControl.presenter.browser.host) {
    this.m_nfrNpcClothingControl.presenter.browser.host.SetVisible(visible);
  }
}

/** Hides and clears target-specific NPC Clothing surfaces without destroying the reusable row.
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
@addMethod(gameuiPhotoModeMenuController)
public func DeactivateNfrNpcClothingBrowser() -> Void {
  // Target-specific children are rebuilt after settings and NPC lifecycle changes.
  this.ReleaseNfrClothingGroupSearch(n"npc_clothing");
  if IsDefined(this.m_nfrNpcClothingControl) {
    this.m_nfrNpcClothingControl.presenter.browser.SetExpanded(false);
    this.m_nfrNpcClothingControl.presenter.browser.host.SetVisible(false);
  }
  this.ReleaseNfrNpcAppearanceBrowser();
  this.ReleaseNfrNpcClothingSlotControls();
  this.m_nfrNpcClothingTarget = null;
  this.m_nfrNpcClothingCustomPreview = false;
  this.m_nfrNpcAppearanceRefreshPending = false;
}

/** Removes every item applied by the NPC clothing browser from its retained target.
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
 * @param None. @return None. @errors Released targets only clear retained UI state. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ClearNfrNpcClothingItems() -> Void {
  let outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
  for slotBrowser in this.m_nfrNpcClothingSlots {
    if ItemID.IsValid(slotBrowser.activeItemID) {
      if IsDefined(outfitSystem) && IsDefined(this.m_nfrNpcClothingTarget) {
        outfitSystem.UnequipPuppetItem(this.m_nfrNpcClothingTarget, slotBrowser.activeItemID);
      }
      slotBrowser.activeItemID = ItemID.None();
      slotBrowser.control.presenter.SetActiveIdentity(0);
      slotBrowser.control.SyncOwnedValueLabel();
    }
  }
}

/** Releases only the target-specific NPC slot rows while retaining the parent Clothing control.
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
@addMethod(gameuiPhotoModeMenuController)
private func ReleaseNfrNpcClothingSlotControls() -> Void {
  let parent: wref<inkCompoundWidget>;
  let cardIndex: Int32;
  for slotBrowser in this.m_nfrNpcClothingSlots {
    if IsDefined(slotBrowser) && IsDefined(slotBrowser.control) {
      this.ReleaseNfrCardSearch(slotBrowser.control.presenter.browser);
      slotBrowser.control.ReleaseOwnedHooks(
        this,
        n"OnNfrNpcClothingSlotReleased",
        n"OnNfrNpcClothingPreviousReleased",
        n"OnNfrNpcClothingNextReleased"
      );
      cardIndex = 0;
      while cardIndex < ArraySize(slotBrowser.control.presenter.browser.cards) {
        slotBrowser.control.presenter.browser.cards[cardIndex].UnregisterFromCallback(
          n"OnRelease", this, n"OnNfrNpcClothingCardReleased"
        );
        cardIndex += 1;
      }
      parent = slotBrowser.control.presenter.browser.host.GetParentWidget() as inkCompoundWidget;
      if IsDefined(parent) { parent.RemoveChild(slotBrowser.control.presenter.browser.host); }
    }
  }
  ArrayClear(this.m_nfrNpcClothingSlots);
  this.m_nfrNpcClothingCatalogBuilt = false;
}

/** Releases the temporary NPC clothing UI and removes its applied items before Photo Mode teardown.
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
  let player = this.GetPlayerControlledObject() as PlayerPuppet;
  this.ClearNfrNpcClothingItems();
  this.ReleaseNfrNpcAppearanceBrowser();
  this.ReleaseNfrNpcClothingSlotControls();
  if IsDefined(this.m_nfrNpcClothingClearHit) {
    this.m_nfrNpcClothingClearHit.UnregisterFromCallback(
      n"OnPress", this, n"OnNfrNpcClothingClearReleased"
    );
    this.m_nfrNpcClothingClearHit.UnregisterFromCallback(
      n"OnRelease", this, n"OnNfrNpcClothingClearReleased"
    );
  }
  if IsDefined(this.m_nfrNpcClothingControl) {
    this.m_nfrNpcClothingControl.ReleaseOwnedHooks(
      this, n"OnNfrNpcClothingLineReleased", n"", n""
    );
    parent = this.m_nfrNpcClothingControl.presenter.browser.host.GetParentWidget()
      as inkCompoundWidget;
    if IsDefined(parent) {
      parent.RemoveChild(this.m_nfrNpcClothingControl.presenter.browser.host);
    }
  }
  this.m_nfrNpcClothingContainer = null;
  this.m_nfrNpcClothingControl = null;
  this.m_nfrNpcClothingTarget = null;
  this.m_nfrNpcClothingClearHit = null;
  this.m_nfrNpcClothingClearLabel = null;
  this.m_nfrNpcClothingCustomPreview = false;
  this.m_nfrNpcAppearanceRefreshPending = false;
  ArrayClear(this.m_nfrNpcClothingPreviewStates);
  ArrayClear(this.m_nfrNpcAppearanceVisibilityStates);
  if IsDefined(player) { player.ResetNfrPhotoModeNpcPuppets(); }
  wrappedMethod();
}
