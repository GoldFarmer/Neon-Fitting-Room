module NeonFittingRoom

import Codeware.UI.*

/** Defines shared timing for every NFR search field. */
public abstract class NfrPhotoModeSearchPolicy {

  /** Returns the idle interval required before filtering. @param None.
   * @return Seconds after the latest input. @errors None. */
  public static func DebounceSeconds() -> Float = 0.45;
}

/** Binds one reusable text input to one expandable card collection. */
public class NfrPhotoModeCardSearchBinding extends IScriptable {
  public let input: ref<HubTextInput>;
  public let browser: wref<NfrExpandableCardBrowser>;
  public let surface: wref<inkWidget>;
  public let cardContent: wref<inkWidget>;
  public let usesSeparateCardContent: Bool;
  public let labels: array<String>;
  public let utilityCount: Int32;
  public let generation: Int32;
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
private let m_nfrCardSearchBindings: array<ref<NfrPhotoModeCardSearchBinding>>;

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
private let m_nfrCardSearchFocusReleaseRegistered: Bool;

/**
 * Applies only the newest query for one search binding.
 *
 * @dependencies {
 *   "id": "equipmentEx",
 *   "adopted": "1.2.9",
 *   "min": "TBD"
 * }
 */
@if(ModuleExists("EquipmentEx"))
private class NfrCardSearchDebounceCallback extends DelayCallback {
  private let m_controller: wref<gameuiPhotoModeMenuController>;
  private let m_binding: ref<NfrPhotoModeCardSearchBinding>;
  private let m_generation: Int32;

  /** Applies a current query. @param None. @return None. @errors Stale or released state is ignored. */
  public func Call() -> Void {
    if IsDefined(this.m_controller) && IsDefined(this.m_binding) {
      this.m_controller.ApplyNfrCardSearchGeneration(this.m_binding, this.m_generation);
    }
  }

  /** Creates one debounced request. @param controller Owner. @param binding Search binding.
   * @param generation Query generation. @return Callback. @errors None. */
  public static func Create(
    controller: ref<gameuiPhotoModeMenuController>,
    binding: ref<NfrPhotoModeCardSearchBinding>,
    generation: Int32
  ) -> ref<NfrCardSearchDebounceCallback> {
    let callback = new NfrCardSearchDebounceCallback();
    callback.m_controller = controller;
    callback.m_binding = binding;
    callback.m_generation = generation;
    return callback;
  }
}

/** Adds or refreshes the common expanded-card search field.
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
 * @param browser Card collection. @param surface Surface whose height follows filtered cards.
 * @param labels Labels aligned with browser cards. @param utilityCount Leading action cards hidden during search.
 * @return None. @errors Missing surfaces leave the browser unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func EnsureNfrCardSearch(
  browser: ref<NfrExpandableCardBrowser>,
  surface: wref<inkWidget>,
  cardContent: wref<inkWidget>,
  usesSeparateCardContent: Bool,
  labels: array<String>,
  utilityCount: Int32
) -> Void {
  let binding: ref<NfrPhotoModeCardSearchBinding>;
  let parent: wref<inkCompoundWidget>;
  let root: wref<inkWidget>;
  if !IsDefined(browser) || !IsDefined(surface) { return; }
  parent = surface as inkCompoundWidget;
  if !IsDefined(parent) { return; }
  binding = this.FindNfrCardSearch(browser);
  if !IsDefined(binding) {
    binding = new NfrPhotoModeCardSearchBinding();
    binding.browser = browser;
    binding.surface = surface;
    binding.cardContent = cardContent;
    binding.usesSeparateCardContent = usesSeparateCardContent;
    binding.input = HubTextInput.Create();
    binding.input.SetName(StringToName(s"nfr_\(NameToString(browser.controlID))_search"));
    binding.input.SetDefaultText(NfrText.Search());
    binding.input.SetLetterCase(textLetterCase.OriginalCase);
    binding.input.SetMaxLength(64);
    binding.input.SetWidth(900.0);
    binding.input.SetText(browser.searchQuery);
    binding.input.RegisterToCallback(n"OnInput", this, n"OnNfrCardSearchInput");
    binding.input.Reparent(parent);
    root = binding.input.GetRootWidget();
    if IsDefined(root) {
      root.SetSize(900.0, 64.0);
      // Photo Mode reserves the left title region through x=530; the selector spans the
      // remaining 900 pixels, so the field follows the active value and arrow geometry.
      root.SetTranslation(new Vector2(530.0, 8.0));
    }
    ArrayPush(this.m_nfrCardSearchBindings, binding);
  } else {
    binding.browser = browser;
    binding.surface = surface;
    binding.cardContent = cardContent;
    binding.usesSeparateCardContent = usesSeparateCardContent;
    binding.input.Reparent(parent);
  }
  binding.labels = labels;
  binding.utilityCount = Max(utilityCount, 0);
  this.ApplyNfrCardSearch(binding, IsDefined(binding.input) ? binding.input.GetText() : "");
  if !this.m_nfrCardSearchFocusReleaseRegistered {
    this.RegisterToGlobalInputCallback(n"OnPostOnRelease", this, n"OnNfrCardSearchGlobalRelease");
    this.m_nfrCardSearchFocusReleaseRegistered = true;
  }
}

/** Moves an existing input outside card content while that content is rebuilt.
 * The same `HubTextInput` instance is reattached by `EnsureNfrCardSearch`, preserving caret state.
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
 * @param browser Browser being rebuilt. @return None. @errors Missing bindings are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func DetachNfrCardSearchForRebuild(browser: ref<NfrExpandableCardBrowser>) -> Void {
  let binding = this.FindNfrCardSearch(browser);
  if !IsDefined(binding) || !IsDefined(binding.input) || !IsDefined(browser.host) { return; }
  binding.input.Reparent(browser.host);
}

/**
 * Finds the binding for a browser.
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
 * @param browser Browser identity. @return Binding or null. @errors None.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func FindNfrCardSearch(
  browser: ref<NfrExpandableCardBrowser>
) -> ref<NfrPhotoModeCardSearchBinding> {
  if !IsDefined(browser) { return null; }
  for binding in this.m_nfrCardSearchBindings {
    if IsDefined(binding) && IsDefined(binding.browser)
      && Equals(binding.browser.controlID, browser.controlID) { return binding; }
  }
  return null;
}

/** Debounces input from any registered card search.
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
 * @param widget Input root. @return True.
 * @errors Unknown inputs are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrCardSearchInput(widget: wref<inkWidget>) -> Bool {
  let root: wref<inkWidget>;
  for binding in this.m_nfrCardSearchBindings {
    if IsDefined(binding) && IsDefined(binding.input) {
      root = binding.input.GetRootWidget();
      if Equals(widget, root) {
        binding.generation += 1;
        GameInstance.GetDelaySystem(this.GetPlayerControlledObject().GetGame()).DelayCallback(
          NfrCardSearchDebounceCallback.Create(this, binding, binding.generation),
          NfrPhotoModeSearchPolicy.DebounceSeconds(),
          false
        );
        return true;
      }
    }
  }
  return false;
}

/** Applies a non-stale debounced query.
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
 * @param binding Search binding. @param generation Generation.
 * @return None. @errors Stale requests are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ApplyNfrCardSearchGeneration(
  binding: ref<NfrPhotoModeCardSearchBinding>, generation: Int32
) -> Void {
  if !IsDefined(binding) || generation != binding.generation || !IsDefined(binding.input) { return; }
  this.BeginNfrExpandableScrollMutation(binding.browser.rowRoot);
  this.ApplyNfrCardSearch(binding, binding.input.GetText());
  this.ApplyNfrExpandableScrollPrediction();
  this.ScheduleNfrExpandableScrollRefresh();
}

/** Filters and compacts one card collection without changing card identities or source ordering.
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
 * @param binding Search binding. @param query User-entered label fragment. @return None.
 * @errors Missing retained widgets are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ApplyNfrCardSearch(
  binding: ref<NfrPhotoModeCardSearchBinding>, query: String
) -> Void {
  let topInset: Float;
  if IsDefined(binding.browser) { binding.browser.searchQuery = query; }
  topInset = IsDefined(binding.browser)
    ? 80.0 * MaxF(1.0, binding.browser.cellSize / 162.0)
    : 80.0;
  this.ApplyNfrCardCollectionFilter(
    binding.browser,
    binding.surface,
    binding.cardContent,
    binding.usesSeparateCardContent,
    binding.labels,
    binding.utilityCount,
    query,
    topInset
  );
}

/** Reapplies the committed grid density to every retained searchable card browser.
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
 * @param None. @return None. @errors Released bindings are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func RefreshNfrCardGridSettings() -> Void {
  let query: String;
  for binding in this.m_nfrCardSearchBindings {
    if IsDefined(binding) && IsDefined(binding.browser) {
      binding.browser.ConfigureGrid(NfrSettings.GetCardsPerRow());
      query = IsDefined(binding.input) ? binding.input.GetText() : binding.browser.searchQuery;
      this.ApplyNfrCardSearch(binding, query);
    }
  }
  this.RefreshNfrClothingGridSettings();
}

/** Filters and compacts a card collection while preserving authoritative card identities.
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
 * @param browser Card collection. @param surface Height-owning surface.
 * @param cardContent Optional nested card canvas. @param usesSeparateCardContent Whether nested.
 * @param labels Labels aligned with cards. @param utilityCount Leading actions hidden in search.
 * @param query Case-insensitive fragment. @param topInset Reserved content above cards.
 * @return None. @errors Missing retained widgets are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ApplyNfrCardCollectionFilter(
  browser: ref<NfrExpandableCardBrowser>,
  surface: wref<inkWidget>,
  cardContent: wref<inkWidget>,
  usesSeparateCardContent: Bool,
  labels: array<String>,
  utilityCount: Int32,
  query: String,
  topInset: Float
) -> Void {
  let active = NotEquals(StrLower(query), "");
  let normalized = StrLower(query);
  let visibleIndex: Int32;
  let index: Int32;
  let show: Bool;
  let gridHeight: Float;
  if !IsDefined(browser) || !IsDefined(surface) { return; }
  browser.searchQuery = query;
  while index < ArraySize(browser.cards) && index < ArraySize(labels) {
    show = (!active || index >= utilityCount)
      && (!active || StrContains(StrLower(labels[index]), normalized));
    browser.cards[index].SetVisible(show);
    if show {
      browser.cards[index].SetTranslation(new Vector2(
        browser.originX + Cast<Float>(visibleIndex % browser.columnCount) * browser.cellSize,
        (usesSeparateCardContent ? 0.0 : topInset)
          + Cast<Float>(visibleIndex / browser.columnCount) * browser.cellSize
      ));
      visibleIndex += 1;
    }
    index += 1;
  }
  gridHeight = visibleIndex > 0
    ? Cast<Float>((visibleIndex + browser.columnCount - 1) / browser.columnCount)
      * browser.cellSize
    : 0.0;
  browser.contentHeight = topInset + gridHeight;
  if usesSeparateCardContent && IsDefined(cardContent) {
    cardContent.SetTranslation(new Vector2(0.0, topInset));
    cardContent.SetHeight(gridHeight);
  }
  surface.SetHeight(browser.contentHeight);
}

/**
 * Clears one browser's query before collapse.
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
 * @param browser Browser. @return None. @errors None.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ResetNfrCardSearch(browser: ref<NfrExpandableCardBrowser>) -> Void {
  if !IsDefined(browser) { return; }
  browser.searchQuery = "";
  let binding = this.FindNfrCardSearch(browser);
  if !IsDefined(binding) { return; }
  binding.generation += 1;
  if IsDefined(binding.input) { binding.input.SetText(""); }
  this.ApplyNfrCardSearch(binding, "");
  this.ReleaseNfrCardSearchFocus();
}

/** Removes a binding before its surface children are rebuilt.
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
 * @param browser Browser. @return None. @errors Missing browsers and bindings are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ReleaseNfrCardSearch(browser: ref<NfrExpandableCardBrowser>) -> Void {
  let index: Int32;
  if !IsDefined(browser) { return; }
  while index < ArraySize(this.m_nfrCardSearchBindings) {
    if IsDefined(this.m_nfrCardSearchBindings[index])
      && IsDefined(this.m_nfrCardSearchBindings[index].browser)
      && Equals(this.m_nfrCardSearchBindings[index].browser.controlID, browser.controlID) {
      this.m_nfrCardSearchBindings[index].generation += 1;
      if IsDefined(this.m_nfrCardSearchBindings[index].input) {
        this.m_nfrCardSearchBindings[index].input.UnregisterFromCallback(
          n"OnInput", this, n"OnNfrCardSearchInput"
        );
      }
      ArrayErase(this.m_nfrCardSearchBindings, index);
      return;
    }
    index += 1;
  }
}

/** Releases keyboard focus when a click lands outside all search subtrees.
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
 * @param evt Global pointer release. @return False so normal activation continues.
 * @errors Missing and non-click events are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrCardSearchGlobalRelease(evt: ref<inkPointerEvent>) -> Bool {
  let current: wref<inkWidget>;
  if !IsDefined(evt) || !evt.IsAction(n"click") { return false; }
  current = evt.GetTarget();
  while IsDefined(current) {
    for binding in this.m_nfrCardSearchBindings {
      if IsDefined(binding) && IsDefined(binding.input)
        && Equals(current, binding.input.GetRootWidget()) { return false; }
    }
    current = current.GetParentWidget();
  }
  this.ReleaseNfrCardSearchFocus();
  return false;
}

/**
 * Returns keyboard ownership to Photo Mode.
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
 * @param None. @return None. @errors None.
 */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func ReleaseNfrCardSearchFocus() -> Void {
  for binding in this.m_nfrCardSearchBindings {
    if IsDefined(binding) && IsDefined(binding.input) && binding.input.IsFocused() {
      this.RequestSetFocus(null);
      return;
    }
  }
}

/** Releases transient search controls with the Photo Mode widget tree.
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
  this.ReleaseNfrCardSearchFocus();
  for binding in this.m_nfrCardSearchBindings {
    if IsDefined(binding) && IsDefined(binding.input) {
      binding.generation += 1;
      binding.input.UnregisterFromCallback(n"OnInput", this, n"OnNfrCardSearchInput");
    }
  }
  ArrayClear(this.m_nfrCardSearchBindings);
  if this.m_nfrCardSearchFocusReleaseRegistered {
    this.UnregisterFromGlobalInputCallback(
      n"OnPostOnRelease", this, n"OnNfrCardSearchGlobalRelease"
    );
  }
  this.m_nfrCardSearchFocusReleaseRegistered = false;
  wrappedMethod();
}
