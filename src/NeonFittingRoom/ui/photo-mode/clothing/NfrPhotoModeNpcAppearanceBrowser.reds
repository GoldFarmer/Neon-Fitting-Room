module NeonFittingRoom

/** Reads the mesh-like resource used by functional NPC appearance discovery and controls.
 * @param component Component to inspect. @return Resource path or an empty string when unsupported.
 * @errors Missing or unsupported components return an empty string. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func GetNfrNpcRefitMeshPath(component: ref<IComponent>) -> String {
  let skinned = component as entSkinnedMeshComponent;
  let morph = component as entMorphTargetSkinnedMeshComponent;
  let cloth = component as entSkinnedClothComponent;
  if IsDefined(skinned) {
    return ResRef.ToString(ResourceAsyncRef.GetPath(skinned.mesh));
  }
  if IsDefined(morph) {
    return ResRef.ToString(ResourceAsyncRef.GetPath(morph.morphResource));
  }
  if IsDefined(cloth) {
    return ResRef.ToString(ResourceAsyncRef.GetPath(cloth.graphicsMesh));
  }
  return "";
}

/** Retains one appearance-owned mesh and its NFR-controlled visibility state. */
@if(ModuleExists("EquipmentEx"))
public class NfrNpcAppearanceMeshEntry extends IScriptable {
  public let components: array<ref<IComponent>>;
  public let signature: String;
  public let label: String;
  public let meshPath: String;
  public let visible: Bool;
}

/** Retains component visibility choices without retaining appearance-owned component references. */
@if(ModuleExists("EquipmentEx"))
private class NfrNpcAppearanceVisibilityState extends IScriptable {
  public let target: wref<gamePuppet>;
  public let recordID: TweakDBID;
  public let signatures: array<String>;
  public let visible: array<Bool>;
}

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcAppearanceControl: ref<NfrPhotoModeOwnedExpandableControl>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcAppearanceMeshes: array<ref<NfrNpcAppearanceMeshEntry>>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrNpcAppearanceVisibilityStates: array<ref<NfrNpcAppearanceVisibilityState>>;

/** Builds the NPC-only multi-select appearance-mesh browser ahead of item-slot rows.
 * @param container Clothing child container. @param target Active retained NPC.
 * @param referenceRow Native row geometry. @param referenceDisclosure Native disclosure geometry.
 * @return Whether a control with at least one candidate was mounted.
 * @errors Missing targets or candidates leave the Clothing children unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func BuildNfrNpcAppearanceBrowser(
  container: wref<inkVerticalPanel>,
  target: wref<gamePuppet>,
  referenceRow: wref<inkCompoundWidget>,
  referenceDisclosure: wref<inkImage>
) -> Bool {
  let components: array<ref<IComponent>>;
  let component: ref<IComponent>;
  let entry: ref<NfrNpcAppearanceMeshEntry>;
  let swap: ref<NfrNpcAppearanceMeshEntry>;
  let items: array<ref<NfrExpandableCardItemModel>>;
  let model: ref<NfrExpandableCardControlModel>;
  let meshPath: String;
  let signature: String;
  let signatures: array<String>;
  let signatureIndex: Int32;
  let retainedIndex: Int32;
  let retainedState = this.GetNfrNpcAppearanceVisibilityState(target, false);
  let index: Int32;
  let insertionIndex: Int32;
  if !IsDefined(container) || !IsDefined(target) || !IsDefined(referenceRow)
    || !IsDefined(referenceDisclosure) { return false; }
  components = target.GetComponents();
  while index < ArraySize(components) {
    component = components[index];
    meshPath = this.GetNfrNpcRefitMeshPath(component);
    if this.IsNfrNpcAppearanceMeshCandidate(component, meshPath) {
      signature = s"\(StrLower(NameToString(component.GetName())))|\(meshPath)";
      signatureIndex = ArrayFindFirst(signatures, signature);
      if signatureIndex < 0 {
        entry = new NfrNpcAppearanceMeshEntry();
        ArrayPush(entry.components, component);
        entry.signature = signature;
        entry.label = NameToString(component.GetName());
        entry.meshPath = meshPath;
        entry.visible = true;
        if IsDefined(retainedState) {
          retainedIndex = ArrayFindFirst(retainedState.signatures, signature);
          if retainedIndex >= 0 && retainedIndex < ArraySize(retainedState.visible) {
            entry.visible = retainedState.visible[retainedIndex];
          }
        }
        ArrayPush(this.m_nfrNpcAppearanceMeshes, entry);
        ArrayPush(signatures, signature);
      } else {
        // Equipment-EX can materialize repeated component instances with the same logical name and
        // resource. A card owns the complete signature group so it cannot toggle a dormant copy.
        ArrayPush(this.m_nfrNpcAppearanceMeshes[signatureIndex].components, component);
      }
    }
    index += 1;
  }
  if ArraySize(this.m_nfrNpcAppearanceMeshes) == 0 { return false; }
  this.ReplayNfrNpcAppearanceVisibilityState(target);
  index = 1;
  while index < ArraySize(this.m_nfrNpcAppearanceMeshes) {
    insertionIndex = index;
    while insertionIndex > 0 && StrCmp(
      StrLower(this.m_nfrNpcAppearanceMeshes[insertionIndex - 1].label),
      StrLower(this.m_nfrNpcAppearanceMeshes[insertionIndex].label)
    ) > 0 {
      swap = this.m_nfrNpcAppearanceMeshes[insertionIndex - 1];
      this.m_nfrNpcAppearanceMeshes[insertionIndex - 1] =
        this.m_nfrNpcAppearanceMeshes[insertionIndex];
      this.m_nfrNpcAppearanceMeshes[insertionIndex] = swap;
      insertionIndex -= 1;
    }
    index += 1;
  }
  ArrayPush(items, NfrExpandableCardItemModel.Create(0, NfrText.None()));
  index = 0;
  while index < ArraySize(this.m_nfrNpcAppearanceMeshes) {
    ArrayPush(items, NfrExpandableCardItemModel.Create(index + 1, this.m_nfrNpcAppearanceMeshes[index].label));
    index += 1;
  }
  model = NfrExpandableCardControlModel.Create(
    n"npc_appearance_meshes", NfrText.Npc(), items, -1
  );
  this.m_nfrNpcAppearanceControl = new NfrPhotoModeOwnedExpandableControl();
  if !this.m_nfrNpcAppearanceControl.MountOwned(
    model,
    container,
    0,
    this,
    n"OnNfrNpcMeshAppearanceLineReleased",
    n"",
    n"",
    referenceRow,
    referenceDisclosure,
    true
  ) {
    this.m_nfrNpcAppearanceControl = null;
    ArrayClear(this.m_nfrNpcAppearanceMeshes);
    return false;
  }
  // NPC appearance meshes participate in the parent Clothing query. They must not mount a
  // second search field inside their own expanded card surface.
  this.m_nfrNpcAppearanceControl.presenter.browser.suppressOwnSearch = true;
  this.m_nfrNpcAppearanceControl.SetTitleIndent(referenceDisclosure.GetWidth() + 6.0);
  this.m_nfrNpcAppearanceControl.presenter.browser.host.SetMargin(new inkMargin(0.0, -1.0, 0.0, -1.0));
  this.UpdateNfrNpcAppearanceStatus();
  NfrLog.Debug(s"Built NPC Appearance browser meshes=\(ArraySize(this.m_nfrNpcAppearanceMeshes)).");
  return true;
}

/** Selects appearance-associated skinned meshes while excluding anatomical body geometry.
 * Hair and ambiguous `i1_` meshes are intentionally included because this control makes no slot
 * claim; every card directly toggles the named component.
 * @param component Candidate component. @param meshPath Resolved resource path.
 * @return Whether the component should be exposed. @errors Unknown component classes are excluded. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func IsNfrNpcAppearanceMeshCandidate(component: ref<IComponent>, meshPath: String) -> Bool {
  let name: String;
  let className: CName;
  if !IsDefined(component) || StrLen(meshPath) == 0 { return false; }
  name = StrLower(NameToString(component.GetName()));
  className = component.GetClassName();
  if StrBeginsWith(name, "x0_") || StrBeginsWith(name, "body_")
    || Equals(name, "body") { return false; }
  if Equals(className, n"entGarmentSkinnedMeshComponent") { return true; }
  if !Equals(className, n"entSkinnedMeshComponent")
    && !Equals(className, n"entSkinnedClothComponent") { return false; }
  return StrBeginsWith(name, "t1_") || StrBeginsWith(name, "t2_")
    || StrBeginsWith(name, "l1_") || StrBeginsWith(name, "s1_")
    || StrBeginsWith(name, "h1_") || StrBeginsWith(name, "h2_")
    || StrBeginsWith(name, "g1_") || StrBeginsWith(name, "i1_")
    || StrBeginsWith(name, "hh_") || StrContains(name, "hair")
    || StrContains(StrLower(meshPath), "\\hair\\");
}

/** Expands or collapses the NPC Appearance component cards.
 * @param evt Pointer release. @return Whether the event was handled.
 * @errors Invalid events or absent controls are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcMeshAppearanceLineReleased(evt: ref<inkPointerEvent>) -> Bool {
  if !IsDefined(evt) || !evt.IsAction(n"click") || !IsDefined(this.m_nfrNpcAppearanceControl) {
    return false;
  }
  this.UseNfrExpandableScrollContext(this.m_nfrNpcAppearanceControl.rowRoot);
  this.BeginNfrExpandableScrollMutation(this.m_nfrNpcAppearanceControl.rowRoot);
  if this.m_nfrNpcAppearanceControl.presenter.browser.isExpanded
    && !this.m_nfrNpcAppearanceControl.presenter.browser.suppressOwnSearch {
    this.ResetNfrCardSearch(this.m_nfrNpcAppearanceControl.presenter.browser);
  }
  this.CollapseNfrNpcClothingSlotPeers(null);
  if !IsDefined(this.m_nfrNpcAppearanceControl.presenter.content) {
    this.RebuildNfrExpandableCardControl(
      this.m_nfrNpcAppearanceControl.presenter,
      this,
      n"OnNfrNpcMeshAppearanceCardReleased"
    );
    this.UpdateNfrNpcAppearanceCardVisuals();
  }
  this.m_nfrNpcAppearanceControl.presenter.browser.Toggle();
  this.ApplyNfrExpandableScrollPrediction();
  this.ScheduleNfrExpandableScrollRefresh();
  return true;
}

/** Toggles one appearance mesh, or hides every listed mesh for the NONE card.
 * @param evt Card release. @return Whether a represented card was handled.
 * @errors Invalid events and stale card identities are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrNpcMeshAppearanceCardReleased(evt: ref<inkPointerEvent>) -> Bool {
  let cardIndex: Int32;
  let meshIndex: Int32;
  let visible: Bool;
  if !IsDefined(evt) || !evt.IsAction(n"click") || !IsDefined(this.m_nfrNpcAppearanceControl) {
    return false;
  }
  while cardIndex < ArraySize(this.m_nfrNpcAppearanceControl.presenter.browser.cards) {
    if Equals(
      this.m_nfrNpcAppearanceControl.presenter.browser.cards[cardIndex],
      evt.GetCurrentTarget()
    ) {
      if cardIndex == 0 {
        while meshIndex < ArraySize(this.m_nfrNpcAppearanceMeshes) {
          this.SetNfrNpcAppearanceMeshVisible(this.m_nfrNpcAppearanceMeshes[meshIndex], false);
          meshIndex += 1;
        }
      } else {
        meshIndex = cardIndex - 1;
        if meshIndex >= ArraySize(this.m_nfrNpcAppearanceMeshes) { return false; }
        visible = !this.m_nfrNpcAppearanceMeshes[meshIndex].visible;
        this.SetNfrNpcAppearanceMeshVisible(this.m_nfrNpcAppearanceMeshes[meshIndex], visible);
      }
      this.UpdateNfrNpcAppearanceStatus();
      this.UpdateNfrNpcAppearanceCardVisuals();
      return true;
    }
    cardIndex += 1;
  }
  return false;
}

/** Applies one retained visibility choice through REDscript's component toggle API.
 * @param entry Retained mesh identity. @param visible Desired visibility.
 * @return None. @errors Released components are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func SetNfrNpcAppearanceMeshVisible(
  entry: ref<NfrNpcAppearanceMeshEntry>, visible: Bool
) -> Void {
  let component: ref<IComponent>;
  let toggled: Int32;
  if !IsDefined(entry) { return; }
  for component in entry.components {
    if IsDefined(component) {
      component.Toggle(visible);
      toggled += 1;
    }
  }
  entry.visible = visible;
  this.SetNfrNpcAppearanceVisibilityState(
    this.GetNfrNpcClothingTarget(), entry.signature, visible
  );
  NfrLog.Trace(
    s"[PM-NPC-APPEARANCE][TOGGLE] name=\(entry.label) visible=\(visible) "
    + s"components=\(toggled) mesh=\(entry.meshPath)."
  );
}

/** Finds or creates retained appearance-component state for one NPC.
 * @param target Retained Photo Mode NPC. @param create Whether absence creates state.
 * @return Matching state or null. @errors Missing targets return null. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func GetNfrNpcAppearanceVisibilityState(
  target: wref<gamePuppet>, create: Bool
) -> ref<NfrNpcAppearanceVisibilityState> {
  let state: ref<NfrNpcAppearanceVisibilityState>;
  for candidate in this.m_nfrNpcAppearanceVisibilityStates {
    if Equals(candidate.target, target)
      || (IsDefined(target) && Equals(candidate.recordID, target.GetRecordID())) {
      candidate.target = target;
      return candidate;
    }
  }
  if !create || !IsDefined(target) { return null; }
  state = new NfrNpcAppearanceVisibilityState();
  state.target = target;
  state.recordID = target.GetRecordID();
  ArrayPush(this.m_nfrNpcAppearanceVisibilityStates, state);
  return state;
}

/** Stores one desired component visibility by stable name-and-resource signature.
 * @param target Owning NPC. @param signature Component signature. @param visible Desired state.
 * @return None. @errors Missing targets or signatures leave state unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func SetNfrNpcAppearanceVisibilityState(
  target: wref<gamePuppet>, signature: String, visible: Bool
) -> Void {
  let state = this.GetNfrNpcAppearanceVisibilityState(target, true);
  let index: Int32;
  if !IsDefined(state) || StrLen(signature) == 0 { return; }
  index = ArrayFindFirst(state.signatures, signature);
  if index >= 0 {
    state.visible[index] = visible;
    return;
  }
  ArrayPush(state.signatures, signature);
  ArrayPush(state.visible, visible);
}

/** Reapplies retained visibility to newly activated or reconstructed NPC components.
 * @param target Active NPC. @return None. @errors Missing state or components are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ReplayNfrNpcAppearanceVisibilityState(target: wref<gamePuppet>) -> Void {
  let state = this.GetNfrNpcAppearanceVisibilityState(target, false);
  let components: array<ref<IComponent>>;
  let component: ref<IComponent>;
  let meshPath: String;
  let signature: String;
  let index: Int32;
  let toggled: Int32;
  if !IsDefined(state) || !IsDefined(target) { return; }
  components = target.GetComponents();
  for component in components {
    meshPath = this.GetNfrNpcRefitMeshPath(component);
    if this.IsNfrNpcAppearanceMeshCandidate(component, meshPath) {
      signature = s"\(StrLower(NameToString(component.GetName())))|\(meshPath)";
      index = ArrayFindFirst(state.signatures, signature);
      if index >= 0 && index < ArraySize(state.visible) {
        component.Toggle(state.visible[index]);
        toggled += 1;
      }
    }
  }
  NfrLog.Trace(
    s"[PM-NPC-APPEARANCE][RESTORE] entity=\(EntityID.GetHash(target.GetEntityID())) "
    + s"choices=\(ArraySize(state.signatures)) components=\(toggled)."
  );
}

/** Removes retained component choices when the NPC's native Appearance changes.
 * @param target NPC whose component collection is being replaced. @return None.
 * @errors Missing targets leave other NPC states unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ClearNfrNpcAppearanceVisibilityState(target: wref<gamePuppet>) -> Void {
  let index: Int32;
  if !IsDefined(target) { return; }
  while index < ArraySize(this.m_nfrNpcAppearanceVisibilityStates) {
    if Equals(this.m_nfrNpcAppearanceVisibilityStates[index].target, target)
      || Equals(this.m_nfrNpcAppearanceVisibilityStates[index].recordID, target.GetRecordID()) {
      ArrayErase(this.m_nfrNpcAppearanceVisibilityStates, index);
      return;
    }
    index += 1;
  }
}

/** Mirrors Clothing's count-label convention using only visible appearance meshes.
 * @param None. @return None. @errors Missing UI state is ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrNpcAppearanceStatus() -> Void {
  let count: Int32;
  if !IsDefined(this.m_nfrNpcAppearanceControl)
    || !IsDefined(this.m_nfrNpcAppearanceControl.optionLabel) { return; }
  for entry in this.m_nfrNpcAppearanceMeshes {
    if entry.visible { count += 1; }
  }
  this.m_nfrNpcAppearanceControl.optionLabel.SetText(
    count < ArraySize(this.m_nfrNpcAppearanceMeshes)
      ? NfrText.ItemCount(count, true)
      : NfrText.ItemCount(count, false)
  );
}

/** Applies independent selected styling to every visible component card and to NONE when empty.
 * @param None. @return None. @errors Missing card internals are skipped. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func UpdateNfrNpcAppearanceCardVisuals() -> Void {
  let root: wref<inkCompoundWidget>;
  let frame: wref<inkWidget>;
  let background: wref<inkWidget>;
  let label: wref<inkWidget>;
  let selected: Bool;
  let visibleCount: Int32;
  let index: Int32;
  if !IsDefined(this.m_nfrNpcAppearanceControl) { return; }
  for entry in this.m_nfrNpcAppearanceMeshes { if entry.visible { visibleCount += 1; } }
  while index < ArraySize(this.m_nfrNpcAppearanceControl.presenter.browser.cards) {
    selected = index == 0
      ? visibleCount == 0
      : index - 1 < ArraySize(this.m_nfrNpcAppearanceMeshes)
        && this.m_nfrNpcAppearanceMeshes[index - 1].visible;
    root = this.m_nfrNpcAppearanceControl.presenter.browser.cards[index] as inkCompoundWidget;
    frame = root.GetWidgetByPathName(n"frameImg");
    background = root.GetWidgetByPathName(n"bgRect");
    label = root.GetWidgetByPathName(n"nfrExpandableCardLabel");
    if IsDefined(frame) {
      frame.BindProperty(n"tintColor", selected ? n"MainColors.ActiveBlue" : n"MainColors.ActiveRed");
      frame.SetOpacity(1.0);
    }
    if IsDefined(background) {
      background.BindProperty(n"tintColor", selected ? n"MainColors.ActiveBlue" : n"MainColors.ActiveRed");
      background.SetOpacity(selected ? 0.40 : 0.0);
    }
    if IsDefined(label) {
      label.BindProperty(n"tintColor", selected ? n"MainColors.ActiveBlue" : n"MainColors.ActiveRed");
    }
    index += 1;
  }
}

/** Removes the NPC Appearance row and its callbacks without changing component visibility.
 * @param None. @return None. @errors Partial initialization is safe. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ReleaseNfrNpcAppearanceBrowser() -> Void {
  let parent: wref<inkCompoundWidget>;
  let index: Int32;
  if IsDefined(this.m_nfrNpcAppearanceControl) {
    this.ReleaseNfrCardSearch(this.m_nfrNpcAppearanceControl.presenter.browser);
    this.m_nfrNpcAppearanceControl.ReleaseOwnedHooks(
      this, n"OnNfrNpcMeshAppearanceLineReleased", n"", n""
    );
    while index < ArraySize(this.m_nfrNpcAppearanceControl.presenter.browser.cards) {
      this.m_nfrNpcAppearanceControl.presenter.browser.cards[index].UnregisterFromCallback(
        n"OnRelease", this, n"OnNfrNpcMeshAppearanceCardReleased"
      );
      index += 1;
    }
    parent = this.m_nfrNpcAppearanceControl.presenter.browser.host.GetParentWidget()
      as inkCompoundWidget;
    if IsDefined(parent) { parent.RemoveChild(this.m_nfrNpcAppearanceControl.presenter.browser.host); }
  }
  this.m_nfrNpcAppearanceControl = null;
  ArrayClear(this.m_nfrNpcAppearanceMeshes);
}
