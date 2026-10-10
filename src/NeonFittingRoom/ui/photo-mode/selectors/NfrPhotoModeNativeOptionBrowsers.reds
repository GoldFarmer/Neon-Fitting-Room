module NeonFittingRoom

/** Retains one native Photo Mode option selector and its expandable labeled-card presentation. */
public class NfrNativeOptionBrowserAdapter extends IScriptable {
  public let binding: ref<NfrPhotoModeNativeSelectorBinding>;
}

/** Reports how many options are retained by a native Photo Mode selector.
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
 * @param None. @return Current selector option count.
 * @errors An unconfigured selector returns zero. */
@if(ModuleExists("EquipmentEx"))
@addMethod(PhotoModeMenuListItem)
public func GetNfrOptionSelectorCount() -> Int32 {
  return ArraySize(this.m_OptionSelectorValues);
}

/** Copies one retained native option without exporting the owning array.
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
 * @param index Zero-based native display index. @return Option at the requested index.
 * @errors Callers must validate the index against `GetNfrOptionSelectorCount`. */
@if(ModuleExists("EquipmentEx"))
@addMethod(PhotoModeMenuListItem)
public func GetNfrOptionSelectorValue(index: Int32) -> PhotoModeOptionSelectorData {
  return this.m_OptionSelectorValues[index];
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
private let m_nfrCategoryAdapter: ref<NfrNativeOptionBrowserAdapter>;

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
private let m_nfrPoseAdapter: ref<NfrNativeOptionBrowserAdapter>;

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
private let m_nfrExpressionAdapter: ref<NfrNativeOptionBrowserAdapter>;

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
private let m_nfrCategoryOptions: array<PhotoModeOptionSelectorData>;

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
private let m_nfrPoseOptions: array<PhotoModeOptionSelectorData>;

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
private let m_nfrExpressionOptions: array<PhotoModeOptionSelectorData>;

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
private let m_nfrExpandableScrollRestoreOffset: Float;

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
private let m_nfrExpandableScrollRestorePending: Bool;

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
private let m_nfrExpandableScrollAnchor: wref<inkWidget>;

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
private let m_nfrExpandableScrollAnchorY: Float;

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
private let m_nfrExpandableScrollAnchorScaleY: Float;

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
private let m_nfrExpandableScrollGeneration: Uint32;

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
private let m_nfrExpandableLayoutRoot: wref<inkVerticalPanel>;

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
private let m_nfrExpandableAnchorBranch: wref<inkWidget>;

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
private let m_nfrExpandableLayoutHeightBefore: Float;

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
private let m_nfrExpandablePrefixHeightBefore: Float;

/**
 * Refreshes outer Photo Mode scrolling after a native option browser changes measured height.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrNativeOptionScrollRefreshCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;
  private let m_generation: Uint32;

  /** Recomputes the existing outer scroll range after Ink layout settles.
   * @param None. @return None. @errors A released controller is ignored. */
  public func Call() -> Void {
    if IsDefined(this.m_controller) {
      this.m_controller.RefreshNfrExpandableScrollRange(this.m_generation);
    }
  }

  /** Creates a deferred refresh for the active Photo Mode controller.
   * @param controller Active controller. @return Deferred callback. @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>,
    generation: Uint32
  ) -> ref<NfrNativeOptionScrollRefreshCallback> {
    let callback = new NfrNativeOptionScrollRefreshCallback();
    callback.m_controller = controller;
    callback.m_generation = generation;
    return callback;
  }
}

/**
 * Corrects residual header movement after the restored scroll offset reaches Ink layout.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrExpandableScrollAnchorCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;
  private let m_generation: Uint32;
  private let m_isFinal: Bool;

  /** Applies one generation-guarded anchor correction.
   * @param None. @return None. @errors Released controllers and stale generations are ignored. */
  public func Call() -> Void {
    if IsDefined(this.m_controller) {
      this.m_controller.CorrectNfrExpandableScrollAnchor(this.m_generation, this.m_isFinal);
    }
  }

  /** Creates one post-layout anchor correction.
   * @param controller Active controller. @param generation Expansion transaction generation.
   * @param isFinal Whether this callback releases the retained anchor. @return Deferred callback.
   * @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>,
    generation: Uint32,
    isFinal: Bool
  ) -> ref<NfrExpandableScrollAnchorCallback> {
    let callback = new NfrExpandableScrollAnchorCallback();
    callback.m_controller = controller;
    callback.m_generation = generation;
    callback.m_isFinal = isFinal;
    return callback;
  }
}

/**
 * Reapplies native-derived Category and Pose label geometry after fit-to-content layout settles.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrNativeOptionLayoutRefreshCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;

  /** Reapplies retained geometry. @param None. @return None. @errors Released owners are ignored. */
  public func Call() -> Void {
    if IsDefined(this.m_controller) { this.m_controller.UpdateNfrNativeOptionBrowserLayouts(); }
  }

  /** Creates one deferred layout refresh.
   * @param controller Active controller. @return Deferred callback. @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>
  ) -> ref<NfrNativeOptionLayoutRefreshCallback> {
    let callback = new NfrNativeOptionLayoutRefreshCallback();
    callback.m_controller = controller;
    return callback;
  }
}

/**
 * Refreshes native selector options and selection after Photo Mode finishes an arrow/card action.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrNativeOptionStateRefreshCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;

  /** Refreshes both dependent selectors. @param None. @return None. @errors Released owners are ignored. */
  public func Call() -> Void {
    if IsDefined(this.m_controller) { this.m_controller.RefreshNfrNativeOptionState(); }
  }

  /** Creates one deferred state refresh.
   * @param controller Active controller. @return Deferred callback. @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>
  ) -> ref<NfrNativeOptionStateRefreshCallback> {
    let callback = new NfrNativeOptionStateRefreshCallback();
    callback.m_controller = controller;
    return callback;
  }
}

/** Attaches Category and Pose browsers after Photo Mode has constructed their native rows.
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
 * @param reversedUI Host orientation. @return Host callback result. @errors Missing rows are skipped. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnShow(reversedUI: Bool) -> Bool {
  let result = wrappedMethod(reversedUI);
  this.m_nfrCategoryOptions = this.ReadNfrNativeOptionValues(5u);
  if IsDefined(this.m_nfrCategoryAdapter) {
    this.UpdateNfrNativeOptionAdapterItems(
      this.m_nfrCategoryAdapter,
      this.m_nfrCategoryOptions
    );
    this.UpdateNfrNativeOptionBrowserLayout(this.m_nfrCategoryAdapter);
    this.RebuildNfrNativeOptionCards(this.m_nfrCategoryAdapter, n"OnNfrCategoryCardReleased");
  } else {
    this.m_nfrCategoryAdapter = this.AttachNfrNativeOptionSiblingBrowser(
      5u,
      n"category",
      this.m_nfrCategoryOptions,
      n"nfr_category_browser_host",
      n"nfr_category_disclosure",
      n"OnNfrCategoryLineReleased"
    );
    this.RebuildNfrNativeOptionCards(this.m_nfrCategoryAdapter, n"OnNfrCategoryCardReleased");
  }
  this.m_nfrPoseOptions = this.ReadNfrNativeOptionValues(6u);
  if IsDefined(this.m_nfrPoseAdapter) {
    this.UpdateNfrNativeOptionAdapterItems(this.m_nfrPoseAdapter, this.m_nfrPoseOptions);
    this.UpdateNfrNativeOptionBrowserLayout(this.m_nfrPoseAdapter);
    this.RebuildNfrNativeOptionCards(this.m_nfrPoseAdapter, n"OnNfrPoseCardReleased");
  } else {
    this.m_nfrPoseAdapter = this.AttachNfrNativeOptionSiblingBrowser(
      6u,
      n"pose",
      this.m_nfrPoseOptions,
      n"nfr_pose_browser_host",
      n"nfr_pose_disclosure",
      n"OnNfrPoseLineReleased"
    );
    this.RebuildNfrNativeOptionCards(this.m_nfrPoseAdapter, n"OnNfrPoseCardReleased");
  }
  this.m_nfrExpressionOptions = this.ReadNfrNativeOptionValues(28u);
  if IsDefined(this.m_nfrExpressionAdapter) {
    this.UpdateNfrNativeOptionAdapterItems(
      this.m_nfrExpressionAdapter,
      this.m_nfrExpressionOptions
    );
    this.UpdateNfrNativeOptionBrowserLayout(this.m_nfrExpressionAdapter);
    this.RebuildNfrNativeOptionCards(
      this.m_nfrExpressionAdapter,
      n"OnNfrExpressionCardReleased"
    );
  } else {
    this.m_nfrExpressionAdapter = this.AttachNfrNativeOptionSiblingBrowser(
      28u,
      n"expression",
      this.m_nfrExpressionOptions,
      n"nfr_expression_browser_host",
      n"nfr_expression_disclosure",
      n"OnNfrExpressionLineReleased"
    );
    this.RebuildNfrNativeOptionCards(
      this.m_nfrExpressionAdapter,
      n"OnNfrExpressionCardReleased"
    );
  }
  this.ScheduleNfrExpandableScrollRefresh();
  return result;
}

/** Adds an NFR-owned browser after a native row without changing the row's list ownership.
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
 * @param attribute Native attribute key. @param controlID Stable browser identity.
 * @param options Current native options. @param hostName Owned sibling host name.
 * @param disclosureName Owned disclosure name. @param toggleCallback Toggle callback.
 * @return Retained adapter or null. @errors Missing native ownership leaves the row untouched. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func AttachNfrNativeOptionSiblingBrowser(
  attribute: Uint32,
  controlID: CName,
  options: array<PhotoModeOptionSelectorData>,
  hostName: CName,
  disclosureName: CName,
  toggleCallback: CName
) -> ref<NfrNativeOptionBrowserAdapter> {
  let menuItem = this.GetMenuItem(attribute);
  let adapter: ref<NfrNativeOptionBrowserAdapter>;
  let model: ref<NfrExpandableCardControlModel>;
  let rowRoot: wref<inkCompoundWidget>;
  if !IsDefined(menuItem) { return null; }
  adapter = new NfrNativeOptionBrowserAdapter();
  adapter.binding = new NfrPhotoModeNativeSelectorBinding();
  rowRoot = menuItem.GetRootWidget() as inkCompoundWidget;
  model = this.CreateNfrNativeOptionControlModel(controlID, options);
  if !adapter.binding.Mount(
    attribute,
    model,
    rowRoot,
    this,
    toggleCallback,
    n"OnNfrNativeOptionArrowReleased",
    hostName,
    disclosureName,
    Equals(controlID, n"category") ? 19.0 : 18.0
  ) {
    return null;
  }
  this.SyncNfrNativeOptionFromLabel(adapter);
  NfrLog.Info(s"Attached native Photo Mode \(NameToString(controlID)) sibling browser.");
  return adapter;
}

/** Converts native options into the reusable control model without exporting the native array.
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
 * @param controlID Stable control identity. @param options Controller-owned indexed copy.
 * @return Reusable ordered model. @errors Empty input produces an empty model. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CreateNfrNativeOptionControlModel(
  controlID: CName,
  options: array<PhotoModeOptionSelectorData>
) -> ref<NfrExpandableCardControlModel> {
  let items: array<ref<NfrExpandableCardItemModel>>;
  let item: ref<NfrExpandableCardItemModel>;
  let insertionIndex: Int32;
  let index: Int32 = 0;
  while index < ArraySize(options) {
    item = NfrExpandableCardItemModel.Create(
      options[index].optionData,
      options[index].optionText
    );
    if Equals(controlID, n"category") || Equals(controlID, n"npc_category") {
      insertionIndex = 0;
      while insertionIndex < ArraySize(items)
        && StrCmp(StrLower(items[insertionIndex].label), StrLower(item.label)) <= 0 {
        insertionIndex += 1;
      }
      ArrayInsert(items, insertionIndex, item);
    } else {
      ArrayPush(items, item);
    }
    index += 1;
  }
  return NfrExpandableCardControlModel.Create(
    controlID,
    StrUpper(NameToString(controlID)),
    items,
    -1
  );
}

/** Replaces the reusable presentation model from the current typed native option copy.
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
 * @param adapter Target adapter. @param options Current indexed native options. @return None.
 * @errors A missing adapter is ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrNativeOptionAdapterItems(
  adapter: ref<NfrNativeOptionBrowserAdapter>,
  options: array<PhotoModeOptionSelectorData>
) -> Void {
  let replacement: ref<NfrExpandableCardControlModel>;
  if !IsDefined(adapter) { return; }
  replacement = this.CreateNfrNativeOptionControlModel(
    adapter.binding.presenter.model.controlID,
    options
  );
  adapter.binding.presenter.model.SetItems(replacement.items);
}

/** Reads the native selector's retained options one entry at a time.
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
 * @param attribute Native attribute key. @return Exact current native options.
 * @errors A missing menu item returns an empty array and leaves the native control untouched. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ReadNfrNativeOptionValues(attribute: Uint32) -> array<PhotoModeOptionSelectorData> {
  let options: array<PhotoModeOptionSelectorData>;
  let menuItem = this.GetMenuItem(attribute);
  let count: Int32;
  let index: Int32 = 0;
  if !IsDefined(menuItem) { return options; }
  count = menuItem.GetNfrOptionSelectorCount();
  while index < count {
    ArrayPush(options, menuItem.GetNfrOptionSelectorValue(index));
    index += 1;
  }
  return options;
}

/** Toggles the native Category browser without consuming arrow hit areas.
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
protected cb func OnNfrCategoryLineReleased(evt: ref<inkPointerEvent>) -> Bool {
  let isClick = IsDefined(evt) && evt.IsAction(n"click");
  NfrLog.Info(
    s"Native Photo Mode Category disclosure release "
    + s"defined=\(IsDefined(evt)) click=\(isClick)."
  );
  return this.ToggleNfrNativeOptionBrowser(evt, this.m_nfrCategoryAdapter, n"OnNfrCategoryCardReleased");
}

/** Toggles the native Pose browser without consuming arrow hit areas.
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
protected cb func OnNfrPoseLineReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.ToggleNfrNativeOptionBrowser(evt, this.m_nfrPoseAdapter, n"OnNfrPoseCardReleased");
}

/** Toggles the native Facial Expression browser without consuming arrow hit areas.
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
protected cb func OnNfrExpressionLineReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.ToggleNfrNativeOptionBrowser(
    evt,
    this.m_nfrExpressionAdapter,
    n"OnNfrExpressionCardReleased"
  );
}

/** Schedules synchronization after a native Category or Pose arrow completes its own callback.
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
 * @param evt Native arrow release. @return False so native input remains authoritative.
 * @errors Non-click releases are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNativeOptionArrowReleased(evt: ref<inkPointerEvent>) -> Bool {
  if IsDefined(evt) && evt.IsAction(n"click") { this.ScheduleNfrNativeOptionStateRefresh(); }
  return false;
}

/** Toggles one initialized browser and schedules the shared outer-scroll range refresh.
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
 * @param evt Pointer release. @param adapter Target adapter. @param cardCallback Card callback.
 * @return True when toggled. @errors Invalid input returns false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ToggleNfrNativeOptionBrowser(
  evt: ref<inkPointerEvent>,
  adapter: ref<NfrNativeOptionBrowserAdapter>,
  cardCallback: CName
) -> Bool {
  if !IsDefined(evt) || !evt.IsAction(n"click") || !IsDefined(adapter) { return false; }
  this.UseNfrExpandableScrollContext(adapter.binding.rowRoot);
  this.BeginNfrExpandableScrollMutation(adapter.binding.rowRoot);
  if adapter.binding.presenter.browser.isExpanded {
    this.ResetNfrCardSearch(adapter.binding.presenter.browser);
  }
  if !adapter.binding.presenter.browser.isExpanded {
    this.CollapseNfrTopLevelExpandablePeers(adapter.binding.presenter.model.controlID);
  }
  adapter.binding.presenter.browser.Toggle();
  this.RebuildNfrNativeOptionCards(adapter, cardCallback);
  this.UpdateNfrNativeOptionBrowserLayouts();
  this.ApplyNfrExpandableScrollPrediction();
  this.ScheduleNfrExpandableScrollRefresh();
  return true;
}

/** Schedules outer-scroll recomputation after Ink publishes the changed fit-to-content height.
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
 * @param None. @return None. @errors A missing game instance prevents scheduling. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ScheduleNfrExpandableScrollRefresh() -> Void {
  if IsDefined(this.m_nfrOutfitOuterScroll) && !this.m_nfrExpandableScrollRestorePending {
    this.m_nfrExpandableScrollRestoreOffset =
      this.m_nfrOutfitOuterScroll.position * this.m_nfrOutfitOuterScroll.scrollDelta;
    this.m_nfrExpandableScrollRestorePending = true;
    this.m_nfrExpandableScrollGeneration += 1u;
  }
  GameInstance.GetDelaySystem(this.GetPlayerControlledObject().GetGame()).DelayCallback(
    NfrNativeOptionScrollRefreshCallback.Create(this, this.m_nfrExpandableScrollGeneration),
    0.10,
    false
  );
}

/** Captures the absolute viewport offset and initiating header before measured height changes.
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
 * @param anchor Header that must retain its screen position. @return None.
 * @errors A missing active scroll controller still invalidates older deferred restores. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func BeginNfrExpandableScrollMutation(anchor: wref<inkWidget>) -> Void {
  let anchorOrigin: Vector2;
  let anchorUnit: Vector2;
  this.m_nfrExpandableScrollGeneration += 1u;
  this.m_nfrExpandableScrollAnchor = anchor;
  this.m_nfrExpandableScrollAnchorY = 0.0;
  this.m_nfrExpandableScrollAnchorScaleY = 1.0;
  if IsDefined(anchor) {
    anchorOrigin = WidgetUtils.LocalToGlobal(anchor, Vector2(0.0, 0.0));
    anchorUnit = WidgetUtils.LocalToGlobal(anchor, Vector2(0.0, 100.0));
    this.m_nfrExpandableScrollAnchorY = anchorOrigin.Y;
    this.m_nfrExpandableScrollAnchorScaleY = MaxF(
      AbsF(anchorUnit.Y - anchorOrigin.Y) / 100.0,
      0.001
    );
  }
  this.CaptureNfrExpandableLayoutPrediction(anchor);
  if !IsDefined(this.m_nfrOutfitOuterScroll) {
    this.m_nfrExpandableScrollRestorePending = false;
    return;
  }
  this.m_nfrExpandableScrollRestoreOffset =
    this.m_nfrOutfitOuterScroll.position * this.m_nfrOutfitOuterScroll.scrollDelta;
  this.m_nfrExpandableScrollRestorePending = true;
}

/** Captures the current vertical-list height and the height preceding the initiating header.
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
 * @param anchor Header whose direct list branch identifies the mutation boundary. @return None.
 * @errors Unrecognized ancestry disables prediction while retaining measured restoration. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CaptureNfrExpandableLayoutPrediction(anchor: wref<inkWidget>) -> Void {
  let branch = anchor;
  let current = anchor;
  let root: wref<inkVerticalPanel>;
  let scroll: wref<inkScrollController>;
  this.m_nfrExpandableLayoutRoot = null;
  this.m_nfrExpandableAnchorBranch = null;
  this.m_nfrExpandableLayoutHeightBefore = 0.0;
  this.m_nfrExpandablePrefixHeightBefore = 0.0;
  while IsDefined(current) && !IsDefined(scroll) {
    if IsDefined(current as inkVerticalPanel) { root = current as inkVerticalPanel; }
    scroll = current.GetControllerByType(n"inkScrollController") as inkScrollController;
    if !IsDefined(scroll) { current = current.GetParentWidget(); }
  }
  if !IsDefined(root) { return; }
  while IsDefined(branch.GetParentWidget()) && !Equals(branch.GetParentWidget(), root) {
    branch = branch.GetParentWidget();
  }
  if !Equals(branch.GetParentWidget(), root) { return; }
  this.m_nfrExpandableLayoutRoot = root;
  this.m_nfrExpandableAnchorBranch = branch;
  this.m_nfrExpandableLayoutHeightBefore = this.MeasureNfrExpandableVerticalChildren(root);
  this.m_nfrExpandablePrefixHeightBefore = this.MeasureNfrExpandablePrefix(root, branch);
}

/** Predicts the new range and anchor offset from NFR's synchronously changed owned widget heights.
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
 * @param None. @return None. @errors Missing prediction state leaves deferred restoration authoritative. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ApplyNfrExpandableScrollPrediction() -> Void {
  let heightAfter: Float;
  let prefixAfter: Float;
  let predictedDelta: Float;
  let predictedOffset: Float;
  let scroll = this.m_nfrOutfitOuterScroll;
  if !this.m_nfrExpandableScrollRestorePending
    || !IsDefined(scroll)
    || !IsDefined(this.m_nfrExpandableLayoutRoot)
    || !IsDefined(this.m_nfrExpandableAnchorBranch) {
    return;
  }
  heightAfter = this.MeasureNfrExpandableVerticalChildren(this.m_nfrExpandableLayoutRoot);
  prefixAfter = this.MeasureNfrExpandablePrefix(
    this.m_nfrExpandableLayoutRoot,
    this.m_nfrExpandableAnchorBranch
  );
  predictedDelta = MaxF(
    scroll.scrollDelta + heightAfter - this.m_nfrExpandableLayoutHeightBefore,
    0.0
  );
  predictedOffset = ClampF(
    this.m_nfrExpandableScrollRestoreOffset
      + prefixAfter - this.m_nfrExpandablePrefixHeightBefore,
    0.0,
    predictedDelta
  );
  this.m_nfrExpandableScrollRestoreOffset = predictedOffset;
  if predictedDelta > 0.0 {
    scroll.SetScrollPosition(predictedOffset / predictedDelta);
  } else {
    scroll.SetScrollPosition(0.0);
  }
  NfrLog.Trace(
    s"Expansion prediction heightDelta=\(heightAfter - this.m_nfrExpandableLayoutHeightBefore) "
    + s"prefixDelta=\(prefixAfter - this.m_nfrExpandablePrefixHeightBefore) "
    + s"predictedDelta=\(predictedDelta) predictedOffset=\(predictedOffset)."
  );
}

/** Measures visible children of one vertical list using explicit NFR-owned heights and margins.
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
 * @param root Vertical list. @return Effective visible height. @errors Missing roots return zero. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func MeasureNfrExpandableVerticalChildren(root: wref<inkVerticalPanel>) -> Float {
  let height: Float;
  let index: Int32;
  if !IsDefined(root) { return 0.0; }
  while index < root.GetNumChildren() {
    height += this.MeasureNfrExpandableWidgetHeight(root.GetWidgetByIndex(index));
    index += 1;
  }
  return height;
}

/** Measures visible vertical layout recursively while treating canvas children as overlays.
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
 * @param widget Widget to measure. @return Height including vertical margins. @errors Hidden widgets return zero. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func MeasureNfrExpandableWidgetHeight(widget: wref<inkWidget>) -> Float {
  let margin: inkMargin;
  let vertical: wref<inkVerticalPanel>;
  if !IsDefined(widget) || !widget.IsVisible() { return 0.0; }
  margin = widget.GetMargin();
  vertical = widget as inkVerticalPanel;
  return margin.top + margin.bottom + (
    IsDefined(vertical)
      ? this.MeasureNfrExpandableVerticalChildren(vertical)
      : widget.GetHeight()
  );
}

/** Measures visible siblings preceding the anchor's direct branch in the shared vertical list.
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
 * @param root Shared vertical list. @param branch Direct child containing the header.
 * @return Height before the branch. @errors Missing branches return the complete measured list. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func MeasureNfrExpandablePrefix(
  root: wref<inkVerticalPanel>,
  branch: wref<inkWidget>
) -> Float {
  let height: Float;
  let index: Int32;
  if !IsDefined(root) || !IsDefined(branch) { return 0.0; }
  while index < root.GetNumChildren() && !Equals(root.GetWidgetByIndex(index), branch) {
    height += this.MeasureNfrExpandableWidgetHeight(root.GetWidgetByIndex(index));
    index += 1;
  }
  return height;
}

/** Applies only the newest deferred expansion restore after Ink layout has settled.
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
 * @param generation Expansion transaction generation. @return None.
 * @errors Stale callbacks are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func RefreshNfrExpandableScrollRange(generation: Uint32) -> Void {
  if generation != this.m_nfrExpandableScrollGeneration { return; }
  this.RefreshNfrOutfitOuterScrollRange();
}

/** Schedules a next-frame correction and one bounded fallback after the base restore propagates.
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
 * @param None. @return None. @errors Missing game state skips correction. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ScheduleNfrExpandableAnchorCorrection() -> Void {
  let delaySystem = GameInstance.GetDelaySystem(this.GetPlayerControlledObject().GetGame());
  let generation = this.m_nfrExpandableScrollGeneration;
  if !IsDefined(this.m_nfrExpandableScrollAnchor) { return; }
  delaySystem.DelayCallbackNextFrame(
    NfrExpandableScrollAnchorCallback.Create(this, generation, false)
  );
  delaySystem.DelayCallback(
    NfrExpandableScrollAnchorCallback.Create(this, generation, true),
    0.03,
    false
  );
}

/** Restores the initiating header after the base absolute-offset restore has taken effect.
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
 * @param generation Expansion transaction generation. @param isFinal Whether to release the anchor.
 * @return None. @errors Missing widgets, zero ranges, and stale callbacks are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func CorrectNfrExpandableScrollAnchor(generation: Uint32, isFinal: Bool) -> Void {
  let anchorOrigin: Vector2;
  let correction: Float;
  let currentOffset: Float;
  let scroll = this.m_nfrOutfitOuterScroll;
  if generation != this.m_nfrExpandableScrollGeneration
    || !IsDefined(scroll)
    || !IsDefined(this.m_nfrExpandableScrollAnchor)
    || scroll.scrollDelta <= 0.0 {
    return;
  }
  anchorOrigin = WidgetUtils.LocalToGlobal(
    this.m_nfrExpandableScrollAnchor,
    Vector2(0.0, 0.0)
  );
  correction = (anchorOrigin.Y - this.m_nfrExpandableScrollAnchorY)
    / this.m_nfrExpandableScrollAnchorScaleY;
  currentOffset = scroll.position * scroll.scrollDelta;
  if AbsF(correction) > 0.01 {
    scroll.SetScrollPosition(
      ClampF(currentOffset + correction, 0.0, scroll.scrollDelta) / scroll.scrollDelta
    );
  }
  NfrLog.Trace(
    s"Expansion anchor correction generation=\(generation) correction=\(correction) "
    + s"final=\(isFinal)."
  );
  if isFinal { this.m_nfrExpandableScrollAnchor = null; }
}

/** Selects the outer scroll controller belonging to the active expandable page.
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
 * @param start Widget within that page. @return None. @errors Missing ancestry preserves the prior context. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func UseNfrExpandableScrollContext(start: wref<inkWidget>) -> Void {
  let current = start;
  let scroll: wref<inkScrollController>;
  while IsDefined(current) && !IsDefined(scroll) {
    scroll = current.GetControllerByType(n"inkScrollController") as inkScrollController;
    current = current.GetParentWidget();
  }
  if IsDefined(scroll) { this.m_nfrOutfitOuterScroll = scroll; }
}

/** Schedules a post-input read after native dependent selector updates have completed.
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
 * @param None. @return None. @errors A missing game instance prevents scheduling. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ScheduleNfrNativeOptionStateRefresh() -> Void {
  GameInstance.GetDelaySystem(this.GetPlayerControlledObject().GetGame()).DelayCallback(
    NfrNativeOptionStateRefreshCallback.Create(this),
    0.10,
    false
  );
}

/** Rereads Category and dependent Pose options from their retained native menu items.
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
 * @param None. @return None. @errors Missing reflected values produce empty card sets safely. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func RefreshNfrNativeOptionState() -> Void {
  if IsDefined(this.m_nfrCategoryAdapter) {
    this.m_nfrCategoryOptions = this.ReadNfrNativeOptionValues(5u);
    this.UpdateNfrNativeOptionAdapterItems(
      this.m_nfrCategoryAdapter,
      this.m_nfrCategoryOptions
    );
    this.RebuildNfrNativeOptionCards(this.m_nfrCategoryAdapter, n"OnNfrCategoryCardReleased");
  }
  if IsDefined(this.m_nfrPoseAdapter) {
    this.m_nfrPoseOptions = this.ReadNfrNativeOptionValues(6u);
    this.UpdateNfrNativeOptionAdapterItems(this.m_nfrPoseAdapter, this.m_nfrPoseOptions);
    this.RebuildNfrNativeOptionCards(this.m_nfrPoseAdapter, n"OnNfrPoseCardReleased");
  }
  if IsDefined(this.m_nfrExpressionAdapter) {
    this.m_nfrExpressionOptions = this.ReadNfrNativeOptionValues(28u);
    this.UpdateNfrNativeOptionAdapterItems(
      this.m_nfrExpressionAdapter,
      this.m_nfrExpressionOptions
    );
    this.RebuildNfrNativeOptionCards(
      this.m_nfrExpressionAdapter,
      n"OnNfrExpressionCardReleased"
    );
  }
  if IsDefined(this.m_nfrNpcAppearanceAdapter) {
    this.m_nfrNpcAppearanceOptions = this.ReadNfrNativeOptionValues(3433u);
    this.UpdateNfrNativeOptionAdapterItems(this.m_nfrNpcAppearanceAdapter, this.m_nfrNpcAppearanceOptions);
    this.RebuildNfrNativeOptionCards(this.m_nfrNpcAppearanceAdapter, n"OnNfrNpcAppearanceCardReleased");
  }
  if IsDefined(this.m_nfrNpcExpressionAdapter) {
    this.m_nfrNpcExpressionOptions = this.ReadNfrNativeOptionValues(56u);
    this.UpdateNfrNativeOptionAdapterItems(this.m_nfrNpcExpressionAdapter, this.m_nfrNpcExpressionOptions);
    this.RebuildNfrNativeOptionCards(this.m_nfrNpcExpressionAdapter, n"OnNfrNpcExpressionCardReleased");
  }
  if IsDefined(this.m_nfrNpcCategoryAdapter) {
    this.m_nfrNpcCategoryOptions = this.ReadNfrNativeOptionValues(65u);
    this.UpdateNfrNativeOptionAdapterItems(this.m_nfrNpcCategoryAdapter, this.m_nfrNpcCategoryOptions);
    this.RebuildNfrNativeOptionCards(this.m_nfrNpcCategoryAdapter, n"OnNfrNpcCategoryCardReleased");
  }
  if IsDefined(this.m_nfrNpcPoseAdapter) {
    this.m_nfrNpcPoseOptions = this.ReadNfrNativeOptionValues(57u);
    this.UpdateNfrNativeOptionAdapterItems(this.m_nfrNpcPoseAdapter, this.m_nfrNpcPoseOptions);
    this.RebuildNfrNativeOptionCards(this.m_nfrNpcPoseAdapter, n"OnNfrNpcPoseCardReleased");
  }
  this.ScheduleNfrExpandableScrollRefresh();
}

/** Reapplies native-derived label and disclosure geometry for both retained rows.
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
 * @param None. @return None. @errors Missing adapters are skipped. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func UpdateNfrNativeOptionBrowserLayouts() -> Void {
  this.UpdateNfrNativeOptionBrowserLayout(this.m_nfrCategoryAdapter);
  this.UpdateNfrNativeOptionBrowserLayout(this.m_nfrPoseAdapter);
  this.UpdateNfrNativeOptionBrowserLayout(this.m_nfrExpressionAdapter);
  this.UpdateNfrNpcOptionBrowserLayouts();
}

/** Reapplies one retained row's label geometry after its host changes height.
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
 * @param adapter Target adapter. @return None. @errors Missing widgets are skipped. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrNativeOptionBrowserLayout(adapter: ref<NfrNativeOptionBrowserAdapter>) -> Void {
  if !IsDefined(adapter) || !IsDefined(adapter.binding) { return; }
  adapter.binding.ReapplyLayout();
}

/** Rebuilds cards from the latest native option array, including Category-dependent Pose changes.
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
 * @param adapter Target adapter. @param cardCallback Card activation callback.
 * @return None. @errors Missing browser state is ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func RebuildNfrNativeOptionCards(
  adapter: ref<NfrNativeOptionBrowserAdapter>,
  cardCallback: CName
) -> Void {
  if !this.RebuildNfrExpandableCardControl(adapter.binding.presenter, this, cardCallback) { return; }
  this.SyncNfrNativeOptionFromLabel(adapter);
  this.UpdateNfrNativeOptionCardVisuals(adapter);
}

/** Selects one Category through its retained native Photo Mode menu item.
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
 * @param evt Card release. @return True when selected. @errors Invalid cards return false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrCategoryCardReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.SelectNfrNativeOptionCard(evt, this.m_nfrCategoryAdapter);
}

/** Selects one Pose through its retained native Photo Mode menu item.
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
 * @param evt Card release. @return True when selected. @errors Invalid cards return false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrPoseCardReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.SelectNfrNativeOptionCard(evt, this.m_nfrPoseAdapter);
}

/** Selects one Facial Expression through its retained native Photo Mode menu item.
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
 * @param evt Card release. @return True when selected. @errors Invalid cards return false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrExpressionCardReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.SelectNfrNativeOptionCard(evt, this.m_nfrExpressionAdapter);
}

/** Applies a card's exact optionData through `PhotoModeMenuListItem.ForceValue`.
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
 * @param evt Card release. @param adapter Owning adapter.
 * @return True when selected. @errors Stale bindings return false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func SelectNfrNativeOptionCard(
  evt: ref<inkPointerEvent>,
  adapter: ref<NfrNativeOptionBrowserAdapter>
) -> Bool {
  let menuItem: wref<PhotoModeMenuListItem>;
  let index: Int32 = 0;
  if !IsDefined(evt) || !evt.IsAction(n"click") || !IsDefined(adapter) { return false; }
  while index < ArraySize(adapter.binding.presenter.browser.cards) {
    if Equals(adapter.binding.presenter.browser.cards[index], evt.GetCurrentTarget()) {
      if index >= ArraySize(adapter.binding.presenter.model.items) { return false; }
      menuItem = this.GetMenuItem(adapter.binding.attribute);
      if !IsDefined(menuItem) { return false; }
      menuItem.ForceValue(Cast<Float>(adapter.binding.presenter.model.items[index].identity), true);
      adapter.binding.presenter.SetActiveIdentity(adapter.binding.presenter.model.items[index].identity);
      this.UpdateNfrNativeOptionCardVisuals(adapter);
      this.ScheduleNfrNativeOptionStateRefresh();
      NfrLog.Info(
        s"Selected native Photo Mode \(NameToString(adapter.binding.presenter.model.controlID)) "
        + s"card index=\(index)."
      );
      return true;
    }
    index += 1;
  }
  return false;
}

/** Derives initial selection from the retained native selector's displayed label.
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
 * @param adapter Target adapter. @return None. @errors Missing selector text leaves selection unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func SyncNfrNativeOptionFromLabel(adapter: ref<NfrNativeOptionBrowserAdapter>) -> Void {
  let selectorParent: wref<inkCompoundWidget>;
  let selector: wref<inkCompoundWidget>;
  let optionLabel: wref<inkText>;
  let index: Int32 = 0;
  if !IsDefined(adapter) || !IsDefined(adapter.binding) || !IsDefined(adapter.binding.rowRoot) { return; }
  selectorParent = adapter.binding.rowRoot.GetWidgetByIndex(3) as inkCompoundWidget;
  if IsDefined(selectorParent) { selector = selectorParent.GetWidgetByIndex(0) as inkCompoundWidget; }
  if IsDefined(selector) { optionLabel = selector.GetWidgetByIndex(1) as inkText; }
  if !IsDefined(optionLabel) { return; }
  while index < ArraySize(adapter.binding.presenter.model.items) {
    if Equals(
      StrLower(adapter.binding.presenter.model.items[index].label),
      StrLower(optionLabel.GetText())
    ) {
      adapter.binding.presenter.SetActiveIdentity(
        adapter.binding.presenter.model.items[index].identity
      );
      return;
    }
    index += 1;
  }
}

/** Applies the existing red/blue card treatment from the adapter's selected option identity.
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
 * @param adapter Target adapter. @return None. @errors Missing card internals are skipped. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrNativeOptionCardVisuals(adapter: ref<NfrNativeOptionBrowserAdapter>) -> Void {
  let controller: wref<PhotoModeGridButton>;
  let root: wref<inkCompoundWidget>;
  let frame: wref<inkWidget>;
  let background: wref<inkWidget>;
  let label: wref<inkWidget>;
  let selected: Bool;
  let index: Int32 = 0;
  if !IsDefined(adapter) { return; }
  while index < ArraySize(adapter.binding.presenter.browser.cards) {
    root = adapter.binding.presenter.browser.cards[index] as inkCompoundWidget;
    frame = root.GetWidgetByPathName(n"frameImg");
    background = root.GetWidgetByPathName(n"bgRect");
    label = root.GetWidgetByPathName(n"nfrExpandableCardLabel");
    selected = index < ArraySize(adapter.binding.presenter.model.items)
      && Equals(
        adapter.binding.presenter.model.items[index].identity,
        adapter.binding.presenter.model.activeIdentity
      );
    controller = adapter.binding.presenter.browser.cards[index].GetControllerByType(n"PhotoModeGridButton")
      as PhotoModeGridButton;
    if IsDefined(controller) { controller.ButtonStateChanged(selected); }
    if IsDefined(frame) {
      frame.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
      frame.BindProperty(n"tintColor", selected ? n"MainColors.ActiveBlue" : n"MainColors.ActiveRed");
      frame.SetOpacity(1.0);
    }
    if IsDefined(background) {
      background.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
      background.BindProperty(n"tintColor", selected ? n"MainColors.ActiveBlue" : n"MainColors.ActiveRed");
      background.SetOpacity(0.40);
    }
    if IsDefined(label) {
      label.SetStyle(r"base\\gameplay\\gui\\common\\main_colors.inkstyle");
      label.BindProperty(n"tintColor", selected ? n"MainColors.ActiveBlue" : n"MainColors.ActiveRed");
    }
    index += 1;
  }
}

/** Releases callbacks and adapter references before Photo Mode destroys native rows.
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
 * @param None. @return None. @errors Partially initialized adapters are safe. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnUninitialize() -> Void {
  this.ReleaseNfrNativeOptionBrowser(
    this.m_nfrCategoryAdapter,
    n"OnNfrCategoryLineReleased",
    n"OnNfrCategoryCardReleased"
  );
  this.ReleaseNfrNativeOptionBrowser(this.m_nfrPoseAdapter, n"OnNfrPoseLineReleased", n"OnNfrPoseCardReleased");
  this.ReleaseNfrNativeOptionBrowser(
    this.m_nfrExpressionAdapter,
    n"OnNfrExpressionLineReleased",
    n"OnNfrExpressionCardReleased"
  );
  this.m_nfrCategoryAdapter = null;
  this.m_nfrPoseAdapter = null;
  this.m_nfrExpressionAdapter = null;
  ArrayClear(this.m_nfrCategoryOptions);
  ArrayClear(this.m_nfrPoseOptions);
  ArrayClear(this.m_nfrExpressionOptions);
  wrappedMethod();
}

/** Unregisters one adapter's native and card callbacks and clears its retained widget state.
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
 * @param adapter Target adapter. @param toggleCallback Toggle callback.
 * @param cardCallback Card callback. @return None. @errors Missing adapters are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ReleaseNfrNativeOptionBrowser(
  adapter: ref<NfrNativeOptionBrowserAdapter>,
  toggleCallback: CName,
  cardCallback: CName
) -> Void {
  let index: Int32 = 0;
  let hostParent: wref<inkCompoundWidget>;
  if !IsDefined(adapter) { return; }
  this.ReleaseNfrCardSearch(adapter.binding.presenter.browser);
  adapter.binding.Release(
    this,
    toggleCallback,
    n"OnNfrNativeOptionArrowReleased"
  );
  while index < ArraySize(adapter.binding.presenter.browser.cards) {
    adapter.binding.presenter.browser.cards[index].UnregisterFromCallback(n"OnRelease", this, cardCallback);
    index += 1;
  }
  if IsDefined(adapter.binding.presenter.browser.host) {
    hostParent = adapter.binding.presenter.browser.host.GetParentWidget() as inkCompoundWidget;
    if IsDefined(hostParent) {
      hostParent.RemoveChild(adapter.binding.presenter.browser.host);
    }
  }
  adapter.binding.presenter.Reset();
}
