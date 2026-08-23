module NeonFittingRoom

@if(ModuleExists("EquipmentEx"))
import EquipmentEx.{OutfitPart, OutfitSystem}

/**
 * Stores one immutable Equipment-EX outfit part captured for an NFR Photo Mode session.
 *
 * The value deliberately copies public part data instead of retaining an Equipment-EX object whose
 * persistent backing data could change after the Photo Mode session begins.
 */
public class NfrOutfitPartSnapshot extends IScriptable {
  public let itemID: ItemID;
  public let slotID: TweakDBID;
  public let displayName: String;
}

/**
 * Stores one immutable saved-outfit definition captured from Equipment-EX.
 *
 * The display name currently derives from the authoritative Equipment-EX identifier. It remains a
 * separate field so a localization or display-name resolver can be introduced without changing
 * consumers of the session snapshot.
 */
public class NfrOutfitSnapshot extends IScriptable {
  public let outfitID: CName;
  public let displayName: String;
  public let parts: array<ref<NfrOutfitPartSnapshot>>;
}

/**
 * Reads saved OutfitSystem data through Equipment-EX's public API and returns value snapshots.
 *
 * The catalog is intentionally stateless: the future Photo Mode session owns the returned snapshot
 * for its entire lifetime and does not observe Equipment-EX mutations until the next session.
 */
@if(ModuleExists("EquipmentEx"))
public abstract class NfrOutfitCatalog {
  /**
   * Reports whether the Equipment-EX outfit authority is available for the active game instance.
   * @param None.
   * @return True when OutfitSystem is ready to read; otherwise false.
   * @errors None.
   */
  public static func IsAvailable() -> Bool {
    return IsDefined(OutfitSystem.GetInstance(GetGameInstance()));
  }

  /**
   * Copies all saved outfits and valid parts from Equipment-EX in its authoritative order.
   *
   * @param None.
   * @return Independent saved-outfit snapshots, or an empty array when the authority is unavailable.
   * @errors Invalid OutfitPart values and invalid item identities are omitted without mutation.
   */
  public static func ReadSavedOutfits() -> array<ref<NfrOutfitSnapshot>> {
    let snapshots: array<ref<NfrOutfitSnapshot>>;
    let outfitSystem = OutfitSystem.GetInstance(GetGameInstance());
    let outfitParts: array<ref<OutfitPart>>;
    let snapshot: ref<NfrOutfitSnapshot>;
    let partSnapshot: ref<NfrOutfitPartSnapshot>;

    if !IsDefined(outfitSystem) { return snapshots; }
    for outfitID in outfitSystem.GetOutfits() {
      snapshot = new NfrOutfitSnapshot();
      snapshot.outfitID = outfitID;
      snapshot.displayName = NameToString(outfitID);
      outfitParts = outfitSystem.GetOutfitParts(outfitID);
      for outfitPart in outfitParts {
        if IsDefined(outfitPart) && ItemID.IsValid(outfitPart.GetItemID()) {
          partSnapshot = new NfrOutfitPartSnapshot();
          partSnapshot.itemID = outfitPart.GetItemID();
          partSnapshot.slotID = outfitPart.GetSlotID();
          partSnapshot.displayName = TDBID.ToStringDEBUG(ItemID.GetTDBID(partSnapshot.itemID));
          ArrayPush(snapshot.parts, partSnapshot);
        }
      }
      ArrayPush(snapshots, snapshot);
    }
    return snapshots;
  }
}

/**
 * Provides the same safe catalog contract when Equipment-EX is not installed.
 *
 * No Equipment-EX symbols occur in this compiled branch, allowing NFR to keep its disabled UI path
 * loadable long enough to report the missing required dependency.
 */
@if(!ModuleExists("EquipmentEx"))
public abstract class NfrOutfitCatalog {
  /**
   * Reports that Equipment-EX is unavailable in this compiled configuration.
   * @param None.
   * @return False.
   * @errors None.
   */
  public static func IsAvailable() -> Bool { return false; }

  /**
   * Returns no saved outfits because Equipment-EX is unavailable in this compiled configuration.
   * @param None.
   * @return An empty snapshot array.
   * @errors None.
   */
  public static func ReadSavedOutfits() -> array<ref<NfrOutfitSnapshot>> { return []; }
}
