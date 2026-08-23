module NeonFittingRoom

/** Describes one card independently of the control that presents or activates it. */
public class NfrExpandableCardItemModel extends IScriptable {
  public let identity: Int32;
  public let label: String;
  public let isEnabled: Bool;
  public let iconAtlas: ResRef;
  public let iconPart: CName;

  /** Creates one card item. @param identity Stable control-local identity. @param label Display text.
   * @return New item. @errors None. */
  public static func Create(identity: Int32, label: String) -> ref<NfrExpandableCardItemModel> {
    let item = new NfrExpandableCardItemModel();
    item.identity = identity;
    item.label = label;
    item.isEnabled = true;
    return item;
  }

  /** Attaches optional UI-icon atlas metadata to this presentation model.
   * @param atlas Icon atlas resource. @param part Atlas part name. @return This item for composition.
   * @errors Invalid metadata simply leaves the renderer's text fallback active. */
  public func SetIcon(atlas: ResRef, part: CName) -> ref<NfrExpandableCardItemModel> {
    this.iconAtlas = atlas;
    this.iconPart = part;
    return this;
  }
}

/** Supplies the complete state required to render and synchronize one expandable card control. */
public class NfrExpandableCardControlModel extends IScriptable {
  public let controlID: CName;
  public let title: String;
  public let items: array<ref<NfrExpandableCardItemModel>>;
  public let activeIdentity: Int32;
  public let columnCount: Int32;
  public let cellSize: Float;
  public let originX: Float;
  public let contentTopMargin: Float;

  /** Creates one reusable control model. @param controlID Stable control identity.
   * @param title Display title. @param items Ordered items. @param activeIdentity Active identity.
   * @return New model. @errors None. */
  public static func Create(
    controlID: CName,
    title: String,
    items: array<ref<NfrExpandableCardItemModel>>,
    activeIdentity: Int32
  ) -> ref<NfrExpandableCardControlModel> {
    let model = new NfrExpandableCardControlModel();
    model.controlID = controlID;
    model.title = title;
    model.items = items;
    model.activeIdentity = activeIdentity;
    model.columnCount = 9;
    model.cellSize = 162.0;
    model.originX = 12.0;
    model.contentTopMargin = 20.0;
    return model;
  }

  /** Replaces the ordered item list. @param items Current items. @return None. @errors None. */
  public func SetItems(items: array<ref<NfrExpandableCardItemModel>>) -> Void { this.items = items; }

  /** Finds one item. @param identity Identity to locate. @return Index or -1. @errors None. */
  public func FindIndex(identity: Int32) -> Int32 {
    let index: Int32 = 0;
    while index < ArraySize(this.items) {
      if Equals(this.items[index].identity, identity) { return index; }
      index += 1;
    }
    return -1;
  }
}
