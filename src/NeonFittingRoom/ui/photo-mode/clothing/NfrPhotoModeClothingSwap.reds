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
import EquipmentEx.{OutfitSystem, PaperdollHelper}

/**
 * Routes Photo Mode puppet attachment completion back to the owning menu controller.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrClothingAttachmentCallback extends AttachmentSlotsScriptCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;

  /** Reports a completed removal. @param slotID Completed slot. @param itemID Removed preview item.
   * @return None. @errors Released controllers are ignored. */
  public func OnItemUnequippedComplete(slotID: TweakDBID, itemID: ItemID) -> Void {
    if IsDefined(this.m_controller) {
      this.m_controller.OnNfrClothingItemUnequipped(slotID, itemID);
    }
  }

  /** Creates a callback for one Photo Mode controller. @param controller Callback owner.
   * @return New callback. @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>
  ) -> ref<NfrClothingAttachmentCallback> {
    let callback = new NfrClothingAttachmentCallback();
    callback.m_controller = controller;
    return callback;
  }
}

/**
 * Defers replacement until the transaction callback has returned to the engine.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrClothingSwapCommitCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;
  private let m_revision: Int32;

  /** Commits the still-current replacement. @param None. @return None.
   * @errors Released or superseded requests are ignored. */
  public func Call() -> Void {
    if IsDefined(this.m_controller) {
      this.m_controller.CommitNfrClothingSwap(this.m_revision);
    }
  }

  /** Creates a next-tick commit. @param controller Callback owner. @param revision Request identity.
   * @return New callback. @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>,
    revision: Int32
  ) -> ref<NfrClothingSwapCommitCallback> {
    let callback = new NfrClothingSwapCommitCallback();
    callback.m_controller = controller;
    callback.m_revision = revision;
    return callback;
  }
}

/**
 * Cancels a replacement that never receives a transaction completion event.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrClothingSwapTimeoutCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;
  private let m_revision: Int32;

  /** Cancels the still-pending request. @param None. @return None.
   * @errors Released or already completed requests are ignored. */
  public func Call() -> Void {
    if IsDefined(this.m_controller) {
      this.m_controller.CancelTimedOutNfrClothingSwap(this.m_revision);
    }
  }

  /** Creates a bounded safety timeout. @param controller Callback owner.
   * @param revision Request identity. @return New callback. @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>,
    revision: Int32
  ) -> ref<NfrClothingSwapTimeoutCallback> {
    let callback = new NfrClothingSwapTimeoutCallback();
    callback.m_controller = controller;
    callback.m_revision = revision;
    return callback;
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
private let m_nfrClothingAttachmentListener: ref<AttachmentSlotsScriptListener>;

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
private let m_nfrClothingAttachmentTarget: wref<gamePuppet>;

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
private let m_nfrClothingSwapPending: Bool;

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
private let m_nfrClothingSwapCommitQueued: Bool;

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
private let m_nfrClothingSwapRevision: Int32;

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
private let m_nfrClothingSwapSlot: ref<NfrPhotoModeClothingSlotBrowser>;

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
private let m_nfrClothingSwapTargetItem: ItemID;

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
private let m_nfrClothingSwapTargetIndex: Int32;

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
private let m_nfrClothingSwapShouldClear: Bool;

/** Applies immediately when no removal is needed, otherwise waits for transaction completion.
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
 * @param puppet Current V Photo Mode puppet. @param slotBrowser Owning slot selector.
 * @param index Selected card identity. @param selectedItemID Desired item or invalid for clear.
 * @param shouldClear Whether the slot should remain empty. @return True when accepted.
 * @errors Concurrent replacement input is consumed without changing its in-flight request. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func RequestNfrClothingSwap(
  puppet: wref<gamePuppet>,
  slotBrowser: ref<NfrPhotoModeClothingSlotBrowser>,
  index: Int32,
  selectedItemID: ItemID,
  shouldClear: Bool
) -> Bool {
  let game = this.GetPlayerControlledObject().GetGame();
  let outfitSystem = OutfitSystem.GetInstance(game);
  let activeItemID: ItemID;
  if !IsDefined(puppet) || !IsDefined(slotBrowser) || !IsDefined(outfitSystem) { return false; }
  if !shouldClear && !this.IsNfrClothingCatalogItemEligible(outfitSystem, selectedItemID) {
    NfrLog.Warn("Rejected a clothing selection whose record or appearance dependency is invalid.");
    return true;
  }
  if this.m_nfrClothingSwapPending {
    if Equals(this.m_nfrClothingSwapSlot, slotBrowser) {
      this.m_nfrClothingSwapTargetItem = selectedItemID;
      this.m_nfrClothingSwapTargetIndex = index;
      this.m_nfrClothingSwapShouldClear = shouldClear;
      NfrLog.Trace("Coalesced clothing input into the pending same-slot replacement.");
    } else {
      NfrLog.Warn("Ignored clothing selection in another slot while removal was pending.");
    }
    return true;
  }
  activeItemID = slotBrowser.activeItemID;
  this.m_nfrClothingSyncRevision += 1;
  if !ItemID.IsValid(activeItemID) {
    return this.ApplyCompletedNfrClothingSwap(
      puppet, slotBrowser, index, selectedItemID, shouldClear
    );
  }
  if !this.EnsureNfrClothingAttachmentListener(puppet) {
    NfrLog.Warn("Clothing replacement was cancelled because its puppet listener was unavailable.");
    return false;
  }
  this.m_nfrClothingSwapPending = true;
  this.m_nfrClothingSwapCommitQueued = false;
  this.m_nfrClothingSwapRevision = this.m_nfrClothingSyncRevision;
  this.m_nfrClothingSwapSlot = slotBrowser;
  this.m_nfrClothingSwapTargetItem = selectedItemID;
  this.m_nfrClothingSwapTargetIndex = index;
  this.m_nfrClothingSwapShouldClear = shouldClear;
  outfitSystem.UnequipPuppetItem(puppet, activeItemID);
  GameInstance.GetDelaySystem(game).DelayCallback(
    NfrClothingSwapTimeoutCallback.Create(this, this.m_nfrClothingSwapRevision),
    1.0,
    false
  );
  return true;
}

/** Queues the replacement after the matching slot removal completes.
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
 * @param slotID Completed slot. @param itemID Removed preview identity. @return None.
 * @errors Unrelated, duplicate, and stale callbacks are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func OnNfrClothingItemUnequipped(slotID: TweakDBID, itemID: ItemID) -> Void {
  if !this.m_nfrClothingSwapPending || this.m_nfrClothingSwapCommitQueued
    || !IsDefined(this.m_nfrClothingSwapSlot)
    || NotEquals(slotID, this.m_nfrClothingSwapSlot.slotID) {
    return;
  }
  if this.m_nfrClothingSwapRevision != this.m_nfrClothingSyncRevision {
    this.ClearNfrClothingSwapState();
    return;
  }
  this.m_nfrClothingSwapCommitQueued = true;
  GameInstance.GetDelaySystem(this.GetPlayerControlledObject().GetGame()).DelayCallback(
    NfrClothingSwapCommitCallback.Create(this, this.m_nfrClothingSwapRevision),
    0.0,
    false
  );
  NfrLog.Trace(
    s"[PM-CLOTHING][UNEQUIPPED] slot=\(TDBID.ToStringDEBUG(slotID)) "
    + s"item=\(TDBID.ToStringDEBUG(ItemID.GetTDBID(itemID)))."
  );
}

/** Commits a replacement on the transaction tick following removal completion.
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
 * @param revision Expected request identity. @return None.
 * @errors Stale controllers, puppets, and selections are cancelled. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func CommitNfrClothingSwap(revision: Int32) -> Void {
  let paperdoll = PaperdollHelper.GetInstance(this.GetPlayerControlledObject().GetGame());
  let puppet: wref<gamePuppet>;
  if !this.m_nfrClothingSwapPending || revision != this.m_nfrClothingSwapRevision
    || revision != this.m_nfrClothingSyncRevision || !IsDefined(paperdoll) {
    this.ClearNfrClothingSwapState();
    return;
  }
  puppet = paperdoll.GetPuppet();
  if !IsDefined(puppet) || NotEquals(puppet, this.m_nfrClothingAttachmentTarget)
    || !IsDefined(this.m_nfrClothingSwapSlot) {
    this.ClearNfrClothingSwapState();
    return;
  }
  this.ApplyCompletedNfrClothingSwap(
    puppet,
    this.m_nfrClothingSwapSlot,
    this.m_nfrClothingSwapTargetIndex,
    this.m_nfrClothingSwapTargetItem,
    this.m_nfrClothingSwapShouldClear
  );
  this.ClearNfrClothingSwapState();
}

/** Cancels a request whose attachment completion event never arrived.
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
 * @param revision Expected request identity. @return None. @errors Completed requests are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func CancelTimedOutNfrClothingSwap(revision: Int32) -> Void {
  let transactionSystem: ref<TransactionSystem>;
  let attachedObject: wref<ItemObject>;
  let attachedItemID: ItemID;
  let actualIndex: Int32;
  if !this.m_nfrClothingSwapPending || revision != this.m_nfrClothingSwapRevision { return; }
  transactionSystem = GameInstance.GetTransactionSystem(
    this.GetPlayerControlledObject().GetGame()
  );
  if !IsDefined(transactionSystem) || !IsDefined(this.m_nfrClothingAttachmentTarget)
    || !IsDefined(this.m_nfrClothingSwapSlot) {
    NfrLog.Warn("Cancelled a timed-out clothing replacement with unavailable slot state.");
    this.ClearNfrClothingSwapState();
    return;
  }
  attachedObject = transactionSystem.GetItemInSlot(
    this.m_nfrClothingAttachmentTarget,
    this.m_nfrClothingSwapSlot.slotID
  );
  if !IsDefined(attachedObject) {
    NfrLog.Trace("Completed a clothing replacement after polling an empty timed-out slot.");
    this.CommitNfrClothingSwap(revision);
    return;
  }
  attachedItemID = ItemID.FromTDBID(ItemID.GetTDBID(attachedObject.GetItemID()));
  if NotEquals(
    ItemID.GetTDBID(attachedItemID),
    ItemID.GetTDBID(this.m_nfrClothingSwapSlot.activeItemID)
  ) {
    actualIndex = this.FindNfrClothingItemIndex(this.m_nfrClothingSwapSlot, attachedItemID);
    this.m_nfrClothingSwapSlot.activeItemID = actualIndex >= 0 ? attachedItemID : ItemID.None();
    this.m_nfrClothingSwapSlot.control.presenter.SetActiveIdentity(Max(actualIndex, 0));
    this.m_nfrClothingSwapSlot.control.SyncOwnedValueLabel();
    if actualIndex < 1 { this.m_nfrClothingSwapSlot.control.optionLabel.SetText(""); }
    this.UpdateNfrClothingSlotCardVisuals(this.m_nfrClothingSwapSlot);
    this.UpdateNfrClothingStatus(this.CountNfrActiveClothingSlots());
    NfrLog.Warn("Resynchronized a clothing slot after its removal callback was not observed.");
  } else {
    NfrLog.Warn("Cancelled a clothing replacement because its prior attachment remains present.");
  }
  this.ClearNfrClothingSwapState();
}

/** Applies the desired item and synchronizes its card presentation.
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
 * @param puppet Current V Photo Mode puppet. @param slotBrowser Owning slot selector.
 * @param index Selected card identity. @param selectedItemID Desired item.
 * @param shouldClear Whether the slot remains empty. @return True when state was applied.
 * @errors Missing authorities leave presentation unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ApplyCompletedNfrClothingSwap(
  puppet: wref<gamePuppet>,
  slotBrowser: ref<NfrPhotoModeClothingSlotBrowser>,
  index: Int32,
  selectedItemID: ItemID,
  shouldClear: Bool
) -> Bool {
  let outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
  if !IsDefined(puppet) || !IsDefined(slotBrowser) || !IsDefined(outfitSystem) { return false; }
  if !shouldClear && !this.IsNfrClothingCatalogItemEligible(outfitSystem, selectedItemID) {
    NfrLog.Warn("Cancelled a clothing replacement whose record became invalid before attachment.");
    return false;
  }
  if shouldClear {
    selectedItemID = ItemID.None();
    index = 0;
  } else {
    outfitSystem.EquipPuppetItem(puppet, selectedItemID);
  }
  slotBrowser.activeItemID = selectedItemID;
  slotBrowser.control.presenter.SetActiveIdentity(index);
  slotBrowser.control.SyncOwnedValueLabel();
  if index == 0 { slotBrowser.control.optionLabel.SetText(""); }
  this.m_nfrClothingCustomPreview = true;
  this.UpdateNfrClothingStatus(this.CountNfrActiveClothingSlots());
  this.UpdateNfrClothingSlotCardVisuals(slotBrowser);
  NfrLog.Info(
    s"Updated Photo Mode clothing slot=\(TDBID.ToStringDEBUG(slotBrowser.slotID)) "
    + s"itemIndex=\(index) cleared=\(shouldClear)."
  );
  return true;
}

/** Ensures one listener follows the current V Photo Mode puppet.
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
 * @param puppet Current preview target. @return Whether registration succeeded.
 * @errors Missing transaction services return false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func EnsureNfrClothingAttachmentListener(puppet: wref<gamePuppet>) -> Bool {
  let transactionSystem = GameInstance.GetTransactionSystem(
    this.GetPlayerControlledObject().GetGame()
  );
  if IsDefined(this.m_nfrClothingAttachmentListener)
    && Equals(this.m_nfrClothingAttachmentTarget, puppet) {
    return true;
  }
  this.ReleaseNfrClothingAttachmentListener();
  if !IsDefined(transactionSystem) || !IsDefined(puppet) { return false; }
  this.m_nfrClothingAttachmentTarget = puppet;
  this.m_nfrClothingAttachmentListener = transactionSystem.RegisterAttachmentSlotListener(
    puppet,
    NfrClothingAttachmentCallback.Create(this)
  );
  return IsDefined(this.m_nfrClothingAttachmentListener);
}

/** Unregisters the current puppet listener and invalidates pending work.
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
public func ReleaseNfrClothingAttachmentListener() -> Void {
  let transactionSystem = GameInstance.GetTransactionSystem(
    this.GetPlayerControlledObject().GetGame()
  );
  this.m_nfrClothingSyncRevision += 1;
  this.ClearNfrClothingSwapState();
  if IsDefined(transactionSystem) && IsDefined(this.m_nfrClothingAttachmentTarget)
    && IsDefined(this.m_nfrClothingAttachmentListener) {
    transactionSystem.UnregisterAttachmentSlotListener(
      this.m_nfrClothingAttachmentTarget,
      this.m_nfrClothingAttachmentListener
    );
  }
  this.m_nfrClothingAttachmentListener = null;
  this.m_nfrClothingAttachmentTarget = null;
}

/** Clears retained request data without mutating puppet clothing.
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
 * @param None. @return None. @errors None. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ClearNfrClothingSwapState() -> Void {
  this.m_nfrClothingSwapPending = false;
  this.m_nfrClothingSwapCommitQueued = false;
  this.m_nfrClothingSwapSlot = null;
  this.m_nfrClothingSwapTargetItem = ItemID.None();
  this.m_nfrClothingSwapTargetIndex = 0;
  this.m_nfrClothingSwapShouldClear = false;
}
