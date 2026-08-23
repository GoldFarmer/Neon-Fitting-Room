module NeonFittingRoom

import Codeware.UI.*

/** Owns one parent-level Clothing query across its generated slot controls. */
@if(ModuleExists("EquipmentEx"))
public class NfrPhotoModeClothingSearchBinding extends IScriptable {
  public let controlID: CName;
  public let input: ref<HubTextInput>;
  public let wrapper: wref<inkWidget>;
  public let rowRoot: wref<inkCompoundWidget>;
  public let slots: array<ref<NfrPhotoModeClothingSlotBrowser>>;
  public let generation: Int32;
}

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrClothingSearchBindings: array<ref<NfrPhotoModeClothingSearchBinding>>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrClothingSearchFocusReleaseRegistered: Bool;

/** Applies only the newest delayed Clothing query. */
@if(ModuleExists("EquipmentEx"))
private class NfrClothingSearchDebounceCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;
  private let m_controlID: CName;
  private let m_generation: Int32;

  /** Applies a current query. @param None. @return None. @errors Released state is ignored. */
  public func Call() -> Void {
    if IsDefined(this.m_controller) {
      this.m_controller.ApplyNfrClothingSearchGeneration(
        this.m_controlID,
        this.m_generation
      );
    }
  }

  /** Creates one debounce request. @param controller Owner. @param controlID Clothing owner.
   * @param generation Query generation. @return Callback. @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>,
    controlID: CName,
    generation: Int32
  ) -> ref<NfrClothingSearchDebounceCallback> {
    let callback = new NfrClothingSearchDebounceCallback();
    callback.m_controller = controller;
    callback.m_controlID = controlID;
    callback.m_generation = generation;
    return callback;
  }
}

/** Mounts or refreshes one search directly below a parent Clothing row.
 * @param controlID Stable parent identity. @param container Parent's expanded child container.
 * @param slots Current slot controls. @param rowRoot Scroll anchoring row.
 * @return None. @errors Missing containers leave search unavailable. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func EnsureNfrClothingGroupSearch(
  controlID: CName,
  container: wref<inkVerticalPanel>,
  slots: array<ref<NfrPhotoModeClothingSlotBrowser>>,
  rowRoot: wref<inkCompoundWidget>
) -> Void {
  let binding = this.FindNfrClothingSearch(controlID);
  let wrapper: ref<inkCanvas>;
  let root: wref<inkWidget>;
  let isNewBinding: Bool;
  if !IsDefined(container) { return; }
  if !IsDefined(binding) {
    binding = new NfrPhotoModeClothingSearchBinding();
    binding.controlID = controlID;
    isNewBinding = true;
  }
  if !IsDefined(binding.wrapper) {
    wrapper = new inkCanvas();
    wrapper.SetName(StringToName(s"nfr_\(NameToString(controlID))_search_wrapper"));
    wrapper.SetSize(1500.0, 80.0);
    wrapper.SetInteractive(false);
    binding.wrapper = wrapper;
  }
  if !IsDefined(binding.input) {
    binding.input = HubTextInput.Create();
    binding.input.SetName(StringToName(s"nfr_\(NameToString(controlID))_search"));
    binding.input.SetDefaultText(NfrText.Search());
    binding.input.SetLetterCase(textLetterCase.OriginalCase);
    binding.input.SetMaxLength(64);
    binding.input.SetWidth(900.0);
    binding.input.RegisterToCallback(n"OnInput", this, n"OnNfrClothingSearchInput");
  }
  binding.wrapper.Reparent(container, 0);
  binding.wrapper.SetVisible(true);
  binding.input.Reparent(binding.wrapper as inkCompoundWidget);
  root = binding.input.GetRootWidget();
  if IsDefined(root) {
    root.SetSize(900.0, 64.0);
    root.SetTranslation(new Vector2(530.0, 8.0));
    root.SetVisible(true);
  }
  if isNewBinding {
    ArrayPush(this.m_nfrClothingSearchBindings, binding);
  }
  binding.slots = slots;
  binding.rowRoot = rowRoot;
  this.ApplyNfrClothingGroupSearch(binding, binding.input.GetText());
  if !this.m_nfrClothingSearchFocusReleaseRegistered {
    this.RegisterToGlobalInputCallback(
      n"OnPostOnRelease",
      this,
      n"OnNfrClothingSearchGlobalRelease"
    );
    this.m_nfrClothingSearchFocusReleaseRegistered = true;
  }
}

/** Finds one parent Clothing search. @param controlID Stable identity.
 * @return Matching binding or null. @errors None. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func FindNfrClothingSearch(
  controlID: CName
) -> ref<NfrPhotoModeClothingSearchBinding> {
  for binding in this.m_nfrClothingSearchBindings {
    if IsDefined(binding) && Equals(binding.controlID, controlID) { return binding; }
  }
  return null;
}

/** Debounces input from either V or NPC Clothing search. @param widget Input root.
 * @return True for a known input. @errors Unknown inputs are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrClothingSearchInput(widget: wref<inkWidget>) -> Bool {
  for binding in this.m_nfrClothingSearchBindings {
    if IsDefined(binding) && IsDefined(binding.input)
      && Equals(widget, binding.input.GetRootWidget()) {
      binding.generation += 1;
      GameInstance.GetDelaySystem(this.GetPlayerControlledObject().GetGame()).DelayCallback(
        NfrClothingSearchDebounceCallback.Create(
          this,
          binding.controlID,
          binding.generation
        ),
        0.20,
        false
      );
      return true;
    }
  }
  return false;
}

/** Applies a query generation when still current. @param controlID Parent identity.
 * @param generation Query generation. @return None. @errors Stale requests are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ApplyNfrClothingSearchGeneration(controlID: CName, generation: Int32) -> Void {
  let binding = this.FindNfrClothingSearch(controlID);
  if !IsDefined(binding) || !IsDefined(binding.input)
    || generation != binding.generation { return; }
  this.BeginNfrExpandableScrollMutation(binding.rowRoot);
  this.ApplyNfrClothingGroupSearch(binding, binding.input.GetText());
  this.ApplyNfrExpandableScrollPrediction();
  this.ScheduleNfrExpandableScrollRefresh();
}

/** Filters every slot catalog owned by one Clothing parent.
 * @param binding Parent search state. @param query Display-name fragment.
 * @return None. @errors Unavailable slot catalogs remain visible and retryable. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ApplyNfrClothingGroupSearch(
  binding: ref<NfrPhotoModeClothingSearchBinding>, query: String
) -> Void {
  let active = NotEquals(StrLower(query), "");
  let normalized = StrLower(query);
  let labels: array<String>;
  let matchCount: Int32;
  let index: Int32;
  if !IsDefined(binding) { return; }
  if Equals(binding.controlID, n"npc_clothing")
    && IsDefined(this.m_nfrNpcAppearanceControl)
    && IsDefined(this.m_nfrNpcAppearanceControl.presenter) {
    ArrayClear(labels);
    matchCount = 0;
    index = 0;
    for item in this.m_nfrNpcAppearanceControl.presenter.model.items {
      ArrayPush(labels, item.label);
      if index > 0 && StrContains(StrLower(item.label), normalized) {
        matchCount += 1;
      }
      index += 1;
    }
    this.m_nfrNpcAppearanceControl.presenter.browser.host.SetVisible(!active || matchCount > 0);
    if IsDefined(this.m_nfrNpcAppearanceControl.presenter.content) {
      this.ApplyNfrCardCollectionFilter(
        this.m_nfrNpcAppearanceControl.presenter.browser,
        this.m_nfrNpcAppearanceControl.presenter.content,
        this.m_nfrNpcAppearanceControl.presenter.content,
        false,
        labels,
        1,
        query,
        0.0
      );
    }
  }
  for slotBrowser in binding.slots {
    ArrayClear(labels);
    matchCount = 0;
    index = 0;
    if IsDefined(slotBrowser) && IsDefined(slotBrowser.control)
      && IsDefined(slotBrowser.control.presenter)
      && (!active || this.EnsureNfrClothingSlotItemsLoaded(slotBrowser)) {
      for item in slotBrowser.control.presenter.model.items {
        ArrayPush(labels, item.label);
        if index > 0 && StrContains(StrLower(item.label), normalized) {
          matchCount += 1;
        }
        index += 1;
      }
      slotBrowser.control.presenter.browser.host.SetVisible(!active || matchCount > 0);
      if IsDefined(slotBrowser.control.presenter.content) {
        this.ApplyNfrCardCollectionFilter(
          slotBrowser.control.presenter.browser,
          slotBrowser.control.presenter.content,
          slotBrowser.control.presenter.content,
          false,
          labels,
          1,
          query,
          0.0
        );
      }
    }
  }
}

/** Reapplies global grid density to retained V and NPC Clothing card surfaces.
 * @param None. @return None. @errors Unbuilt lazy slot surfaces are skipped. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func RefreshNfrClothingGridSettings() -> Void {
  let query: String;
  for binding in this.m_nfrClothingSearchBindings {
    if IsDefined(binding) {
      for slotBrowser in binding.slots {
        if IsDefined(slotBrowser) && IsDefined(slotBrowser.control)
          && IsDefined(slotBrowser.control.presenter)
          && IsDefined(slotBrowser.control.presenter.browser) {
          slotBrowser.control.presenter.browser.ConfigureGrid(NfrSettings.GetCardsPerRow());
        }
      }
      query = IsDefined(binding.input) ? binding.input.GetText() : "";
      this.ApplyNfrClothingGroupSearch(binding, query);
    }
  }
}

/** Reapplies a parent query after a lazy slot card surface is created.
 * @param browser Newly rendered slot browser. @return None. @errors Unknown browsers are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func RefreshNfrClothingGroupSearchForBrowser(
  browser: ref<NfrExpandableCardBrowser>
) -> Void {
  let npcBinding: ref<NfrPhotoModeClothingSearchBinding>;
  if !IsDefined(browser) { return; }
  if IsDefined(this.m_nfrNpcAppearanceControl)
    && IsDefined(this.m_nfrNpcAppearanceControl.presenter)
    && Equals(this.m_nfrNpcAppearanceControl.presenter.browser.controlID, browser.controlID) {
    npcBinding = this.FindNfrClothingSearch(n"npc_clothing");
    if IsDefined(npcBinding) && IsDefined(npcBinding.input) {
      this.ApplyNfrClothingGroupSearch(npcBinding, npcBinding.input.GetText());
    }
    return;
  }
  for binding in this.m_nfrClothingSearchBindings {
    for slotBrowser in binding.slots {
      if IsDefined(slotBrowser) && IsDefined(slotBrowser.control)
        && Equals(slotBrowser.control.presenter.browser.controlID, browser.controlID) {
        this.ApplyNfrClothingGroupSearch(binding, binding.input.GetText());
        return;
      }
    }
  }
}

/** Clears one parent query when Clothing collapses. @param controlID Parent identity.
 * @return None. @errors Missing bindings are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ResetNfrClothingGroupSearch(controlID: CName) -> Void {
  let binding = this.FindNfrClothingSearch(controlID);
  if !IsDefined(binding) { return; }
  binding.generation += 1;
  if IsDefined(binding.input) { binding.input.SetText(""); }
  this.ApplyNfrClothingGroupSearch(binding, "");
  this.ReleaseNfrClothingSearchFocus();
}

/** Removes one parent Clothing search when its generated child hierarchy is released.
 * @param controlID Parent identity. @return None. @errors Missing bindings are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ReleaseNfrClothingGroupSearch(controlID: CName) -> Void {
  let parent: wref<inkCompoundWidget>;
  let index: Int32;
  while index < ArraySize(this.m_nfrClothingSearchBindings) {
    if IsDefined(this.m_nfrClothingSearchBindings[index])
      && Equals(this.m_nfrClothingSearchBindings[index].controlID, controlID) {
      this.m_nfrClothingSearchBindings[index].generation += 1;
      if IsDefined(this.m_nfrClothingSearchBindings[index].input) {
        if this.m_nfrClothingSearchBindings[index].input.IsFocused() {
          this.RequestSetFocus(null);
        }
        this.m_nfrClothingSearchBindings[index].input.UnregisterFromCallback(
          n"OnInput", this, n"OnNfrClothingSearchInput"
        );
      }
      if IsDefined(this.m_nfrClothingSearchBindings[index].wrapper) {
        parent = this.m_nfrClothingSearchBindings[index].wrapper.GetParentWidget()
          as inkCompoundWidget;
        if IsDefined(parent) {
          parent.RemoveChild(this.m_nfrClothingSearchBindings[index].wrapper);
        }
      }
      ArrayErase(this.m_nfrClothingSearchBindings, index);
      return;
    }
    index += 1;
  }
}

/** Releases search focus after a click outside both Clothing inputs.
 * @param evt Global release. @return False so normal input continues. @errors None. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrClothingSearchGlobalRelease(evt: ref<inkPointerEvent>) -> Bool {
  let current: wref<inkWidget>;
  if !IsDefined(evt) || !evt.IsAction(n"click") { return false; }
  current = evt.GetTarget();
  while IsDefined(current) {
    for binding in this.m_nfrClothingSearchBindings {
      if IsDefined(binding) && IsDefined(binding.input)
        && Equals(current, binding.input.GetRootWidget()) { return false; }
    }
    current = current.GetParentWidget();
  }
  this.ReleaseNfrClothingSearchFocus();
  return false;
}

/** Returns keyboard ownership to Photo Mode. @param None. @return None. @errors None. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ReleaseNfrClothingSearchFocus() -> Void {
  for binding in this.m_nfrClothingSearchBindings {
    if IsDefined(binding) && IsDefined(binding.input) && binding.input.IsFocused() {
      this.RequestSetFocus(null);
      return;
    }
  }
}

/** Releases parent Clothing search controls with Photo Mode.
 * @param None. @return None. @errors Partial initialization is safe. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnUninitialize() -> Void {
  this.ReleaseNfrClothingSearchFocus();
  for binding in this.m_nfrClothingSearchBindings {
    if IsDefined(binding) && IsDefined(binding.input) {
      binding.generation += 1;
      binding.input.UnregisterFromCallback(n"OnInput", this, n"OnNfrClothingSearchInput");
    }
  }
  ArrayClear(this.m_nfrClothingSearchBindings);
  if this.m_nfrClothingSearchFocusReleaseRegistered {
    this.UnregisterFromGlobalInputCallback(
      n"OnPostOnRelease",
      this,
      n"OnNfrClothingSearchGlobalRelease"
    );
  }
  this.m_nfrClothingSearchFocusReleaseRegistered = false;
  wrappedMethod();
}
