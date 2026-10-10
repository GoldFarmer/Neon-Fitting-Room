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
 * Owns one generated clothing-slot selector, its ordered item identities, and card presenter.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
public class NfrPhotoModeClothingSlotBrowser extends IScriptable {
  public let slotID: TweakDBID;
  public let itemIDs: array<ItemID>;
  public let activeItemID: ItemID;
  public let startingItemID: ItemID;
  public let itemsLoaded: Bool;
  public let control: ref<NfrPhotoModeOwnedExpandableControl>;
}

/**
 * Describes the reusable presentation and eligibility policy for one clothing browser instance.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
public class NfrPhotoModeClothingBrowserConfig extends IScriptable {
  public let controlPrefix: String;
  public let slotToggleCallback: CName;
  public let previousCallback: CName;
  public let nextCallback: CName;
  public let eligibleSlots: array<TweakDBID>;
  public let restrictToEligibleSlots: Bool;
  public let readPlayerEquippedState: Bool;
  public let discoverTargetSlotItems: Bool;
  public let target: wref<GameObject>;

  /** Creates an immutable-per-build browser policy.
   * @param controlPrefix Stable generated-control prefix. @param slotToggleCallback Slot toggle.
   * @param previousCallback Previous-item callback. @param nextCallback Next-item callback.
   * @param eligibleSlots Target-supported slots. @param restrictToEligibleSlots Whether to filter.
   * @param readPlayerEquippedState Whether initial identities come from player Equipment-EX state.
   * @return New browser configuration. @errors None. */
  public static func Create(
    controlPrefix: String,
    slotToggleCallback: CName,
    previousCallback: CName,
    nextCallback: CName,
    eligibleSlots: array<TweakDBID>,
    restrictToEligibleSlots: Bool,
    readPlayerEquippedState: Bool,
    discoverTargetSlotItems: Bool,
    target: wref<GameObject>
  ) -> ref<NfrPhotoModeClothingBrowserConfig> {
    let config = new NfrPhotoModeClothingBrowserConfig();
    config.controlPrefix = controlPrefix;
    config.slotToggleCallback = slotToggleCallback;
    config.previousCallback = previousCallback;
    config.nextCallback = nextCallback;
    config.eligibleSlots = eligibleSlots;
    config.restrictToEligibleSlots = restrictToEligibleSlots;
    config.readPlayerEquippedState = readPlayerEquippedState;
    config.discoverTargetSlotItems = discoverTargetSlotItems;
    config.target = target;
    return config;
  }

  /** Returns whether a dependency-owned slot should be represented for this target.
   * @param slotID Candidate Equipment-EX slot. @return Whether it is allowed. @errors None. */
  public func AllowsSlot(slotID: TweakDBID) -> Bool {
    return !this.restrictToEligibleSlots || ArrayContains(this.eligibleSlots, slotID);
  }
}

/** Builds the shared lazy slot-row representation used by V and NPC clothing adapters.
 * Target-specific code supplies eligibility and preview mutation behavior through its config and
 * callbacks; this function owns Wardrobe enumeration and identical row presentation.
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
 * @param container Parent child-control panel. @param config Target-specific policy and callbacks.
 * @param referenceRow Native row geometry source. @param referenceDisclosure Disclosure geometry.
 * @return Generated nonempty eligible slot controls. @errors Missing services return an empty set. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func BuildNfrPhotoModeClothingSlotControls(
  container: wref<inkVerticalPanel>,
  config: ref<NfrPhotoModeClothingBrowserConfig>,
  referenceRow: wref<inkCompoundWidget>,
  referenceDisclosure: wref<inkImage>
) -> array<ref<NfrPhotoModeClothingSlotBrowser>> {
  let result: array<ref<NfrPhotoModeClothingSlotBrowser>>;
  let game = this.GetPlayerControlledObject().GetGame();
  let outfitSystem = OutfitSystem.GetInstance(game);
  let wardrobeSystem = GameInstance.GetWardrobeSystem(game);
  let wardrobeItemIDs: array<ItemID>;
  let transactionSystem = GameInstance.GetTransactionSystem(game);
  let attachedObject: wref<ItemObject>;
  let attachedItem: ItemID;
  let candidates: array<ref<NfrPhotoModeClothingSlotBrowser>>;
  let slotMap = new inkHashMap();
  let itemModels: array<ref<NfrExpandableCardItemModel>>;
  let slotBrowser: ref<NfrPhotoModeClothingSlotBrowser>;
  let model: ref<NfrExpandableCardControlModel>;
  if !IsDefined(container) || !IsDefined(config) || !IsDefined(referenceRow)
    || !IsDefined(referenceDisclosure) || !IsDefined(outfitSystem)
    || !IsDefined(wardrobeSystem) {
    return result;
  }
  wardrobeItemIDs = wardrobeSystem.GetStoredItemIDs();
  for slotID in outfitSystem.GetOutfitSlots() {
    slotBrowser = new NfrPhotoModeClothingSlotBrowser();
    slotBrowser.slotID = slotID;
    slotMap.Insert(TDBID.ToNumber(slotID), slotBrowser);
    ArrayPush(candidates, slotBrowser);
  }
  for itemID in wardrobeItemIDs {
    if this.IsNfrClothingCatalogItemEligible(outfitSystem, itemID) {
      slotBrowser = slotMap.Get(TDBID.ToNumber(outfitSystem.GetItemSlot(itemID)))
        as NfrPhotoModeClothingSlotBrowser;
      if IsDefined(slotBrowser) {
        ArrayPush(slotBrowser.itemIDs, itemID);
        if config.readPlayerEquippedState && outfitSystem.IsEquipped(itemID) {
          slotBrowser.activeItemID = itemID;
        }
      }
    } else {
      NfrLog.Warn(
        s"Skipped invalid Wardrobe clothing record="
        + s"\(TDBID.ToStringDEBUG(ItemID.GetTDBID(itemID)))."
      );
    }
  }
  if config.discoverTargetSlotItems && IsDefined(config.target) && IsDefined(transactionSystem) {
    for slotBrowser in candidates {
      attachedObject = transactionSystem.GetItemInSlot(config.target, slotBrowser.slotID);
      attachedItem = IsDefined(attachedObject) ? attachedObject.GetItemID() : ItemID.None();
      if ItemID.IsValid(attachedItem) {
        // Puppet slots contain preview identities. Normalize to record identity so the shared
        // Equipment-EX equip/unequip route can deterministically recreate the preview ID.
        attachedItem = ItemID.FromTDBID(ItemID.GetTDBID(attachedItem));
        if this.IsNfrClothingCatalogItemEligible(outfitSystem, attachedItem) {
          slotBrowser.startingItemID = attachedItem;
          slotBrowser.activeItemID = attachedItem;
          if !ArrayContains(slotBrowser.itemIDs, attachedItem) {
            ArrayPush(slotBrowser.itemIDs, attachedItem);
          }
        }
      }
    }
  }
  for slotBrowser in candidates {
    if ArraySize(slotBrowser.itemIDs) > 0 && config.AllowsSlot(slotBrowser.slotID) {
      ArrayClear(itemModels);
      model = NfrExpandableCardControlModel.Create(
        StringToName(s"\(config.controlPrefix)_\(TDBID.ToNumber(slotBrowser.slotID))"),
        StrUpper(outfitSystem.GetSlotName(slotBrowser.slotID)),
        itemModels,
        -1
      );
      slotBrowser.control = new NfrPhotoModeOwnedExpandableControl();
      if slotBrowser.control.MountOwned(
        model,
        container,
        ArraySize(result),
        this,
        config.slotToggleCallback,
        config.previousCallback,
        config.nextCallback,
        referenceRow,
        referenceDisclosure
      ) {
        slotBrowser.control.presenter.browser.suppressOwnSearch = true;
        slotBrowser.control.SetTitleIndent(referenceDisclosure.GetWidth() + 6.0);
        slotBrowser.control.presenter.browser.host.SetMargin(
          new inkMargin(0.0, -1.0, 0.0, -1.0)
        );
        if ItemID.IsValid(slotBrowser.activeItemID) {
          slotBrowser.control.optionLabel.SetText(outfitSystem.GetItemName(slotBrowser.activeItemID));
        }
        ArrayPush(result, slotBrowser);
      }
    }
  }
  NfrLog.Debug(
    s"Built shared clothing browser prefix=\(config.controlPrefix) slots=\(ArraySize(result)) "
    + s"wardrobeItems=\(ArraySize(wardrobeItemIDs)) eligible=\(ArraySize(config.eligibleSlots))."
  );
  return result;
}

/** Validates the record-level contract required by Equipment-EX puppet preview operations.
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
 * @param outfitSystem Active Equipment-EX authority. @param itemID Candidate Wardrobe identity.
 * @return True for a defined clothing record assigned to a supported outfit slot.
 * @errors Missing or stale records are rejected without attempting to load their visual resources. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func IsNfrClothingCatalogItemEligible(
  outfitSystem: wref<OutfitSystem>, itemID: ItemID
) -> Bool {
  let clothingRecord: wref<Clothing_Record>;
  if !IsDefined(outfitSystem) || !ItemID.IsValid(itemID) { return false; }
  clothingRecord = TweakDBInterface.GetClothingRecord(ItemID.GetTDBID(itemID));
  if !IsDefined(clothingRecord) || !IsDefined(clothingRecord.ItemCategory())
    || NotEquals(clothingRecord.ItemCategory().Type(), gamedataItemCategory.Clothing)
    || !IsNameValid(clothingRecord.AppearanceName()) {
    return false;
  }
  return outfitSystem.IsEquippable(itemID)
    && TDBID.IsValid(outfitSystem.GetItemSlot(itemID));
}
