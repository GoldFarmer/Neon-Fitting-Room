module NeonFittingRoom

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcAppearanceAdapter: ref<NfrNativeOptionBrowserAdapter>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcExpressionAdapter: ref<NfrNativeOptionBrowserAdapter>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcCategoryAdapter: ref<NfrNativeOptionBrowserAdapter>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcPoseAdapter: ref<NfrNativeOptionBrowserAdapter>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcAppearanceOptions: array<PhotoModeOptionSelectorData>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcExpressionOptions: array<PhotoModeOptionSelectorData>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcCategoryOptions: array<PhotoModeOptionSelectorData>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcPoseOptions: array<PhotoModeOptionSelectorData>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcBrowserGeneration: Int32;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcInitialMountPending: Bool;

/** Clears NPC-owned presentation state at the start of a reused Photo Mode session.
 * Photo Mode can hide and show this controller without calling `OnUninitialize`, so the prior
 * session's adapters, expanded panels, searches, and puppet references cannot be retained until
 * a fresh NPC selector becomes active.
 * @param None. @return None. @errors Partially initialized surfaces are safe. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ResetNfrNpcControlsForPhotoModeShow() -> Void {
  this.m_nfrNpcBrowserGeneration += 1;
  this.m_nfrNpcInitialMountPending = false;
  this.ReleaseNfrNpcOptionBrowsers();
  this.ResetNfrNpcClothingForPhotoModeShow();
}

/** Defers NPC adapter rebuilding until native per-puppet option lists have settled. */
@if(ModuleExists("EquipmentEx"))
private class NfrNpcOptionBrowserRefreshCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;
  private let m_generation: Int32;
  private let m_remount: Bool;
  private let m_replayClothingAfterSettle: Bool;

  /** Applies the latest NPC selector state. @param None. @return None. @errors Stale callbacks are ignored. */
  public func Call() -> Void {
    if !IsDefined(this.m_controller) { return; }
    this.m_controller.RefreshNfrNpcOptionBrowsers(
      this.m_generation,
      this.m_remount,
      this.m_replayClothingAfterSettle
    );
  }

  /** Creates a deferred refresh. @param controller Owner. @param generation Current generation.
   * @param remount Whether native rows must be rebound.
   * @param replayClothingAfterSettle Whether retained clothing must be replayed after activation.
   * @return Deferred callback. @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>,
    generation: Int32,
    remount: Bool,
    replayClothingAfterSettle: Bool
  ) -> ref<NfrNpcOptionBrowserRefreshCallback> {
    let callback = new NfrNpcOptionBrowserRefreshCallback();
    callback.m_controller = controller;
    callback.m_generation = generation;
    callback.m_remount = remount;
    callback.m_replayClothingAfterSettle = replayClothingAfterSettle;
    return callback;
  }
}

/** Tracks native NPC selection changes independently for each selected puppet slot.
 * @param attribute Changed native attribute. @param option Exact selected option.
 * @return None. @errors Unsupported attributes retain native behavior. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
public func OnAttributeOptionSelected(attribute: Uint32, option: PhotoModeOptionSelectorData) -> Void {
  let player: wref<PlayerPuppet>;
  if Equals(attribute, 3433u) {
    // A native Appearance change reconstructs the puppet's component collection. Remove preview
    // items and release every retained component/row reference before the host performs that change.
    this.PrepareNfrNpcClothingForAppearanceChange();
  }
  wrappedMethod(attribute, option);
  if Equals(attribute, 68u) {
    player = this.GetPlayerControlledObject() as PlayerPuppet;
    if IsDefined(player) {
      player.SelectNfrPhotoModeNpcPuppet(option.optionText, option.optionData);
    }
    this.m_nfrNpcInitialMountPending = false;
    this.m_nfrNpcBrowserGeneration += 1;
    this.ScheduleNfrNpcOptionBrowserRefresh(true);
  } else {
    if Equals(attribute, 65u) || Equals(attribute, 57u)
      || Equals(attribute, 56u) || Equals(attribute, 58u) || Equals(attribute, 3433u) {
      this.ScheduleNfrNpcOptionBrowserRefresh(false);
    }
  }
}

/** Mounts the NPC browsers after grid selection enables the populated character selector.
 * Grid selection does not call `OnAttributeOptionSelected`, while native NPC arrow cycling does.
 * @param attribute Enabled native attribute. @param enabled Requested state.
 * @return Host result. @errors V's character selector and duplicate requests are ignored. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnSetAttributeOptionEnabled(attribute: Uint32, enabled: Bool) -> Bool {
  let result = wrappedMethod(attribute, enabled);
  let player: wref<PlayerPuppet>;
  let target: wref<gamePuppet>;
  if Equals(attribute, 68u) && !enabled {
    this.m_nfrNpcBrowserGeneration += 1;
    this.m_nfrNpcInitialMountPending = false;
    this.DeactivateNfrNpcClothingBrowser();
    this.ReleaseNfrNpcOptionBrowsers();
    this.EnsureNfrPhotoModeControlsInputGuardFor(this.GetNfrOutfitBrowserHost());
    return result;
  }
  if Equals(attribute, 68u) && enabled {
    player = this.GetPlayerControlledObject() as PlayerPuppet;
    if IsDefined(player) { target = player.GetNfrActivePhotoModeNpcPuppet(); }
  }
  if Equals(attribute, 68u) && enabled
    && !this.m_nfrNpcInitialMountPending
    && (!IsDefined(this.m_nfrNpcAppearanceAdapter)
      || (IsDefined(target) && NotEquals(target, this.m_nfrNpcClothingTarget))) {
    this.m_nfrNpcInitialMountPending = true;
    this.ScheduleNfrNpcOptionBrowserRefresh(false);
  }
  return result;
}

/** Schedules a per-NPC reread after native dependent selectors update.
 * @param remount Whether to replace bindings after a character switch. @return None.
 * @errors A missing game instance prevents scheduling. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ScheduleNfrNpcOptionBrowserRefresh(remount: Bool) -> Void {
  let delaySystem = GameInstance.GetDelaySystem(this.GetPlayerControlledObject().GetGame());
  delaySystem.DelayCallback(
    NfrNpcOptionBrowserRefreshCallback.Create(
      this, this.m_nfrNpcBrowserGeneration, remount, false
    ),
    0.15,
    false
  );
  // Native character activation can reapply native equipment after the first adapter refresh.
  // Replay retained NFR overrides only after that activation has settled.
  if remount {
    delaySystem.DelayCallback(
      NfrNpcOptionBrowserRefreshCallback.Create(
        this, this.m_nfrNpcBrowserGeneration, false, true
      ),
      0.80,
      false
    );
  }
}

/** Rebinds or refreshes the four selectors belonging to the active NPC.
 * @param generation Character-switch generation. @param remount Whether to replace native bindings.
 * @param replayClothingAfterSettle Whether to replay retained clothing after native activation.
 * @return None. @errors Missing native rows are skipped without changing Photo Mode. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func RefreshNfrNpcOptionBrowsers(
  generation: Int32,
  remount: Bool,
  replayClothingAfterSettle: Bool
) -> Void {
  if NotEquals(generation, this.m_nfrNpcBrowserGeneration) { return; }
  this.m_nfrNpcInitialMountPending = false;
  if !this.HasNfrActiveNpcSelector() { return; }
  if remount { this.ReleaseNfrNpcOptionBrowsers(); }
  this.m_nfrNpcAppearanceOptions = this.ReadNfrNativeOptionValues(3433u);
  this.m_nfrNpcExpressionOptions = this.ReadNfrNativeOptionValues(56u);
  this.m_nfrNpcCategoryOptions = this.ReadNfrNativeOptionValues(65u);
  this.m_nfrNpcPoseOptions = this.ReadNfrNativeOptionValues(57u);
  this.m_nfrNpcAppearanceAdapter = this.EnsureNfrNpcOptionBrowser(
    this.m_nfrNpcAppearanceAdapter, 3433u, n"npc_appearance", this.m_nfrNpcAppearanceOptions,
    n"nfr_npc_appearance_browser_host", n"nfr_npc_appearance_disclosure",
    n"OnNfrNpcAppearanceLineReleased", n"OnNfrNpcAppearanceCardReleased"
  );
  this.m_nfrNpcExpressionAdapter = this.EnsureNfrNpcOptionBrowser(
    this.m_nfrNpcExpressionAdapter, 56u, n"npc_expression", this.m_nfrNpcExpressionOptions,
    n"nfr_npc_expression_browser_host", n"nfr_npc_expression_disclosure",
    n"OnNfrNpcExpressionLineReleased", n"OnNfrNpcExpressionCardReleased"
  );
  this.m_nfrNpcCategoryAdapter = this.EnsureNfrNpcOptionBrowser(
    this.m_nfrNpcCategoryAdapter, 65u, n"npc_category", this.m_nfrNpcCategoryOptions,
    n"nfr_npc_category_browser_host", n"nfr_npc_category_disclosure",
    n"OnNfrNpcCategoryLineReleased", n"OnNfrNpcCategoryCardReleased"
  );
  this.m_nfrNpcPoseAdapter = this.EnsureNfrNpcOptionBrowser(
    this.m_nfrNpcPoseAdapter, 57u, n"npc_pose", this.m_nfrNpcPoseOptions,
    n"nfr_npc_pose_browser_host", n"nfr_npc_pose_disclosure",
    n"OnNfrNpcPoseLineReleased", n"OnNfrNpcPoseCardReleased"
  );
  this.EnsureNfrNpcClothingBrowser();
  if replayClothingAfterSettle {
    this.ReplayNfrActiveNpcClothingPreviewState();
  }
  if IsDefined(this.m_nfrNpcAppearanceAdapter)
    && IsDefined(this.m_nfrNpcAppearanceAdapter.binding) {
    this.EnsureNfrPhotoModeControlsInputGuardFor(this.m_nfrNpcAppearanceAdapter.binding.rowRoot);
  }
  this.UpdateNfrNpcOptionBrowserLayouts();
  this.ScheduleNfrExpandableScrollRefresh();
}

/** Distinguishes NPC selection from V's attribute-68 selector before mounting NPC-only rows.
 * @param None. @return True when the first retained character is not V. @errors Missing rows return false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func HasNfrActiveNpcSelector() -> Bool {
  let values = this.ReadNfrNativeOptionValues(68u);
  return ArraySize(values) > 0 && NotEquals(StrLower(values[0].optionText), "v");
}

/** Creates or refreshes one active-NPC selector adapter.
 * @param adapter Existing adapter. @param attribute Native key. @param controlID Stable identity.
 * @param options Current options. @param hostName Host name. @param disclosureName Arrow name.
 * @param toggleCallback Toggle callback. @param cardCallback Card callback.
 * @return Active adapter or null. @errors Empty or missing native selectors remain unmodified. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func EnsureNfrNpcOptionBrowser(
  adapter: ref<NfrNativeOptionBrowserAdapter>,
  attribute: Uint32,
  controlID: CName,
  options: array<PhotoModeOptionSelectorData>,
  hostName: CName,
  disclosureName: CName,
  toggleCallback: CName,
  cardCallback: CName
) -> ref<NfrNativeOptionBrowserAdapter> {
  if ArraySize(options) == 0 { return adapter; }
  if !IsDefined(adapter) {
    adapter = this.AttachNfrNativeOptionSiblingBrowser(
      attribute, controlID, options, hostName, disclosureName, toggleCallback
    );
  } else {
    this.UpdateNfrNativeOptionAdapterItems(adapter, options);
  }
  if IsDefined(adapter) {
    this.SyncNfrNativeOptionFromLabel(adapter);
    if adapter.binding.presenter.browser.isExpanded {
      this.RebuildNfrNativeOptionCards(adapter, cardCallback);
    }
    this.UpdateNfrNativeOptionBrowserLayout(adapter);
  }
  return adapter;
}

/** Toggles NPC Appearance. @param evt Release. @return Whether handled. @errors Invalid events are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcAppearanceLineReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.ToggleNfrNpcOptionBrowser(evt, this.m_nfrNpcAppearanceAdapter, n"OnNfrNpcAppearanceCardReleased");
}

/** Toggles NPC Expression. @param evt Release. @return Whether handled. @errors Invalid events are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcExpressionLineReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.ToggleNfrNpcOptionBrowser(evt, this.m_nfrNpcExpressionAdapter, n"OnNfrNpcExpressionCardReleased");
}

/** Toggles NPC Category. @param evt Release. @return Whether handled. @errors Invalid events are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcCategoryLineReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.ToggleNfrNpcOptionBrowser(evt, this.m_nfrNpcCategoryAdapter, n"OnNfrNpcCategoryCardReleased");
}

/** Toggles NPC Pose. @param evt Release. @return Whether handled. @errors Invalid events are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcPoseLineReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.ToggleNfrNpcOptionBrowser(evt, this.m_nfrNpcPoseAdapter, n"OnNfrNpcPoseCardReleased");
}

/** Toggles one NPC browser and collapses its same-depth NPC peers.
 * @param evt Release. @param adapter Target. @param cardCallback Card callback.
 * @return Whether handled. @errors Invalid input returns false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ToggleNfrNpcOptionBrowser(
  evt: ref<inkPointerEvent>, adapter: ref<NfrNativeOptionBrowserAdapter>, cardCallback: CName
) -> Bool {
  if !IsDefined(evt) || !evt.IsAction(n"click") || !IsDefined(adapter) { return false; }
  this.UseNfrExpandableScrollContext(adapter.binding.rowRoot);
  this.BeginNfrExpandableScrollMutation(adapter.binding.rowRoot);
  if adapter.binding.presenter.browser.isExpanded {
    this.ResetNfrCardSearch(adapter.binding.presenter.browser);
  }
  if !adapter.binding.presenter.browser.isExpanded {
    this.CollapseNfrNpcOptionBrowserPeers(adapter.binding.presenter.model.controlID);
  }
  adapter.binding.presenter.browser.Toggle();
  this.RebuildNfrNativeOptionCards(adapter, cardCallback);
  this.UpdateNfrNpcOptionBrowserLayouts();
  this.ApplyNfrExpandableScrollPrediction();
  this.ScheduleNfrExpandableScrollRefresh();
  return true;
}

/** Collapses other active-NPC browsers. @param exceptID Browser remaining open.
 * @return None. @errors Missing adapters are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CollapseNfrNpcOptionBrowserPeers(exceptID: CName) -> Void {
  this.CollapseNfrNativeTopLevelPeer(this.m_nfrNpcAppearanceAdapter, exceptID);
  this.CollapseNfrNativeTopLevelPeer(this.m_nfrNpcExpressionAdapter, exceptID);
  this.CollapseNfrNativeTopLevelPeer(this.m_nfrNpcCategoryAdapter, exceptID);
  this.CollapseNfrNativeTopLevelPeer(this.m_nfrNpcPoseAdapter, exceptID);
}

/** Selects NPC Appearance. @param evt Release. @return Whether selected. @errors Invalid cards are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcAppearanceCardReleased(evt: ref<inkPointerEvent>) -> Bool {
  let selected: Bool;
  this.PrepareNfrNpcClothingForAppearanceChange();
  selected = this.SelectNfrNativeOptionCard(evt, this.m_nfrNpcAppearanceAdapter);
  if selected { this.ScheduleNfrNpcOptionBrowserRefresh(false); }
  return selected;
}

/** Selects NPC Expression. @param evt Release. @return Whether selected. @errors Invalid cards are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcExpressionCardReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.SelectNfrNativeOptionCard(evt, this.m_nfrNpcExpressionAdapter);
}

/** Selects NPC Category. @param evt Release. @return Whether selected. @errors Invalid cards are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcCategoryCardReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.SelectNfrNativeOptionCard(evt, this.m_nfrNpcCategoryAdapter);
}

/** Selects NPC Pose. @param evt Release. @return Whether selected. @errors Invalid cards are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcPoseCardReleased(evt: ref<inkPointerEvent>) -> Bool {
  return this.SelectNfrNativeOptionCard(evt, this.m_nfrNpcPoseAdapter);
}

/** Reapplies active-NPC native geometry. @param None. @return None. @errors Missing adapters are skipped. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func UpdateNfrNpcOptionBrowserLayouts() -> Void {
  this.UpdateNfrNativeOptionBrowserLayout(this.m_nfrNpcAppearanceAdapter);
  this.UpdateNfrNativeOptionBrowserLayout(this.m_nfrNpcExpressionAdapter);
  this.UpdateNfrNativeOptionBrowserLayout(this.m_nfrNpcCategoryAdapter);
  this.UpdateNfrNativeOptionBrowserLayout(this.m_nfrNpcPoseAdapter);
}

/** Releases bindings owned by the prior active NPC. @param None. @return None.
 * @errors Partially initialized adapters are safe. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ReleaseNfrNpcOptionBrowsers() -> Void {
  this.ReleaseNfrNativeOptionBrowser(
    this.m_nfrNpcAppearanceAdapter,
    n"OnNfrNpcAppearanceLineReleased",
    n"OnNfrNpcAppearanceCardReleased"
  );
  this.ReleaseNfrNativeOptionBrowser(
    this.m_nfrNpcExpressionAdapter,
    n"OnNfrNpcExpressionLineReleased",
    n"OnNfrNpcExpressionCardReleased"
  );
  this.ReleaseNfrNativeOptionBrowser(
    this.m_nfrNpcCategoryAdapter,
    n"OnNfrNpcCategoryLineReleased",
    n"OnNfrNpcCategoryCardReleased"
  );
  this.ReleaseNfrNativeOptionBrowser(
    this.m_nfrNpcPoseAdapter,
    n"OnNfrNpcPoseLineReleased",
    n"OnNfrNpcPoseCardReleased"
  );
  this.m_nfrNpcAppearanceAdapter = null;
  this.m_nfrNpcExpressionAdapter = null;
  this.m_nfrNpcCategoryAdapter = null;
  this.m_nfrNpcPoseAdapter = null;
  ArrayClear(this.m_nfrNpcAppearanceOptions);
  ArrayClear(this.m_nfrNpcExpressionOptions);
  ArrayClear(this.m_nfrNpcCategoryOptions);
  ArrayClear(this.m_nfrNpcPoseOptions);
}

/** Tears down active-NPC bindings before native rows are destroyed.
 * @param None. @return None. @errors Partial initialization is safe. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnUninitialize() -> Void {
  this.m_nfrNpcBrowserGeneration += 1;
  this.m_nfrNpcInitialMountPending = false;
  this.ReleaseNfrNpcOptionBrowsers();
  wrappedMethod();
}
