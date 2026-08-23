module NeonFittingRoom

import Codeware.UI.ScreenHelper

@if(ModuleExists("EquipmentEx"))
import EquipmentEx.{OutfitPart, OutfitSystem}

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrCardTooltipSurface: wref<inkCanvas>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrCardTooltipTitle: wref<inkText>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrCardTooltipDescription: wref<inkText>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrCardTooltipPointerPosition: Vector2;

/** Registers the shared tooltip lifecycle on a materialized NFR card.
 * @param card Card root. @return None. @errors Missing cards are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func RegisterNfrCardTooltipCallbacks(card: wref<inkWidget>) -> Void {
  if !IsDefined(card) { return; }
  card.RegisterToCallback(n"OnHoverOver", this, n"OnNfrCardTooltipHoverOver");
  card.RegisterToCallback(n"OnHoverOut", this, n"OnNfrCardTooltipHoverOut");
}

/** Removes the shared tooltip lifecycle from a released NFR card.
 * @param card Card root. @return None. @errors Missing cards are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func UnregisterNfrCardTooltipCallbacks(card: wref<inkWidget>) -> Void {
  if !IsDefined(card) { return; }
  card.UnregisterFromCallback(n"OnHoverOver", this, n"OnNfrCardTooltipHoverOver");
  card.UnregisterFromCallback(n"OnHoverOut", this, n"OnNfrCardTooltipHoverOut");
}

/** Resolves tooltip content from the authoritative model that owns the hovered card.
 * @param evt Hover event. @return True when a supported tooltip is shown.
 * @errors Stale and unsupported card targets are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrCardTooltipHoverOver(evt: ref<inkPointerEvent>) -> Bool {
  let target: wref<inkWidget>;
  if !NfrSettings.AreCardTooltipsEnabled() || !IsDefined(evt) { return false; }
  target = evt.GetCurrentTarget();
  this.m_nfrCardTooltipPointerPosition = evt.GetScreenSpacePosition();
  if this.ShowNfrOutfitCardTooltip(target) { return true; }
  if this.ShowNfrNativeOptionCardTooltip(target, this.m_nfrCategoryAdapter) { return true; }
  if this.ShowNfrNativeOptionCardTooltip(target, this.m_nfrPoseAdapter) { return true; }
  if this.ShowNfrNativeOptionCardTooltip(target, this.m_nfrExpressionAdapter) { return true; }
  if this.ShowNfrNativeOptionCardTooltip(target, this.m_nfrNpcAppearanceAdapter) { return true; }
  if this.ShowNfrNativeOptionCardTooltip(target, this.m_nfrNpcCategoryAdapter) { return true; }
  if this.ShowNfrNativeOptionCardTooltip(target, this.m_nfrNpcPoseAdapter) { return true; }
  if this.ShowNfrNativeOptionCardTooltip(target, this.m_nfrNpcExpressionAdapter) { return true; }
  if this.ShowNfrClothingCardTooltip(target, this.m_nfrClothingSlots) { return true; }
  return this.ShowNfrClothingCardTooltip(target, this.m_nfrNpcClothingSlots);
}

/** Hides the active NFR tooltip after its card loses hover.
 * @param evt Hover-out event. @return True. @errors Missing surfaces are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrCardTooltipHoverOut(evt: ref<inkPointerEvent>) -> Bool {
  if IsDefined(this.m_nfrCardTooltipSurface) { this.m_nfrCardTooltipSurface.SetVisible(false); }
  return true;
}

/** Shows a saved-outfit tooltip containing every constituent item name.
 * @param target Hovered card. @return True when target belongs to Outfit.
 * @errors Utility or unavailable outfits show the localized empty-state label. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ShowNfrOutfitCardTooltip(target: wref<inkWidget>) -> Bool {
  let description: String;
  let index: Int32;
  if !IsDefined(this.m_nfrOutfitBrowser) { return false; }
  while index < ArraySize(this.m_nfrOutfitBrowser.cards) {
    if Equals(this.m_nfrOutfitBrowser.cards[index], target) {
      if index >= ArraySize(this.m_nfrOutfitCardOptions) { return false; }
      description = this.BuildNfrOutfitTooltipDescription(this.m_nfrOutfitCardOptions[index]);
      return this.ShowNfrOwnedCardTooltip(
        target,
        this.m_nfrOutfitCardOptions[index].optionText,
        Equals(description, "") ? NfrText.None() : description
      );
    }
    index += 1;
  }
  return false;
}

/** Builds newline-separated constituent names for an Equipment-EX Outfit option.
 * @param option Exact native option identity. @return Included item names.
 * @errors Missing systems and No Outfit return an empty string. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func BuildNfrOutfitTooltipDescription(option: PhotoModeOptionSelectorData) -> String {
  let outfitSystem = OutfitSystem.GetInstance(this.GetPlayerControlledObject().GetGame());
  let parts: array<ref<OutfitPart>>;
  let itemID: ItemID;
  let result: String;
  if !IsDefined(outfitSystem) || Equals(option.optionData, 3302) { return result; }
  if Equals(option.optionData, 3303) {
    for slotID in outfitSystem.GetOutfitSlots() {
      itemID = outfitSystem.GetEquippedItemInSlot(slotID);
      if ItemID.IsValid(itemID) {
        result = this.AppendNfrTooltipLine(result, outfitSystem.GetItemName(itemID));
      }
    }
    return result;
  }
  parts = outfitSystem.GetOutfitParts(StringToName(option.optionText));
  for part in parts {
    if IsDefined(part) && ItemID.IsValid(part.GetItemID()) {
      result = this.AppendNfrTooltipLine(result, outfitSystem.GetItemName(part.GetItemID()));
    }
  }
  return result;
}

/** Shows the full localized label for a native-option card.
 * @param target Hovered card. @param adapter Candidate native adapter.
 * @return True when target belongs to adapter. @errors Stale adapters are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ShowNfrNativeOptionCardTooltip(
  target: wref<inkWidget>, adapter: ref<NfrNativeOptionBrowserAdapter>
) -> Bool {
  let index: Int32;
  if !IsDefined(adapter) || !IsDefined(adapter.binding) { return false; }
  while index < ArraySize(adapter.binding.presenter.browser.cards) {
    if Equals(adapter.binding.presenter.browser.cards[index], target) {
      if index >= ArraySize(adapter.binding.presenter.model.items) { return false; }
      return this.ShowNfrOwnedCardTooltip(
        target, adapter.binding.presenter.model.items[index].label, ""
      );
    }
    index += 1;
  }
  return false;
}

/** Shows item details for a V or NPC clothing card.
 * @param target Hovered card. @param slots Candidate slot browsers.
 * @return True when target belongs to a slot. @errors Unresolved inventory data falls back to label. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ShowNfrClothingCardTooltip(
  target: wref<inkWidget>, slots: array<ref<NfrPhotoModeClothingSlotBrowser>>
) -> Bool {
  let index: Int32;
  for slot in slots {
    index = 0;
    while IsDefined(slot) && IsDefined(slot.control)
      && index < ArraySize(slot.control.presenter.browser.cards) {
      if Equals(slot.control.presenter.browser.cards[index], target) {
        if index == 0 || index >= ArraySize(slot.itemIDs) {
          return this.ShowNfrOwnedCardTooltip(target, NfrText.None(), "");
        }
        if this.ShowNfrInventoryItemTooltip(target, slot.itemIDs[index]) { return true; }
        return this.ShowNfrOwnedCardTooltip(
          target, slot.control.presenter.model.items[index].label, ""
        );
      }
      index += 1;
    }
  }
  return false;
}

/** Builds safe standard inventory presentation for an exact clothing identity.
 * @param target Hovered card. @param itemID Complete item identity.
 * @return True when item data was available. @errors Wardrobe-only identities use caller fallback. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ShowNfrInventoryItemTooltip(target: wref<inkWidget>, itemID: ItemID) -> Bool {
  let player = this.GetPlayerControlledObject() as PlayerPuppet;
  let transactionSystem: ref<TransactionSystem>;
  let uiSystem: ref<UIInventoryScriptableSystem>;
  let manager: ref<UIInventoryItemsManager>;
  let itemData: wref<gameItemData>;
  let item: ref<UIInventoryItem>;
  let description: String;
  if !IsDefined(player) || !ItemID.IsValid(itemID) { return false; }
  transactionSystem = GameInstance.GetTransactionSystem(player.GetGame());
  if !IsDefined(transactionSystem) { return false; }
  itemData = transactionSystem.GetItemData(player, itemID);
  if !IsDefined(itemData) { return false; }
  uiSystem = UIInventoryScriptableSystem.GetInstance(player.GetGame());
  if IsDefined(uiSystem) { manager = uiSystem.GetInventoryItemsManager(); }
  item = UIInventoryItem.Make(player, itemData, manager);
  if !IsDefined(item) { return false; }
  description = this.AppendNfrTooltipLine(description, item.GetQualityText());
  description = this.AppendNfrTooltipLine(description, item.GetDescription());
  return this.ShowNfrOwnedCardTooltip(target, item.GetName(), description);
}

/** Shows the shared game-styled tooltip beside the pointer.
 * The measured root-to-screen ratio converts configured display coordinates into Ink coordinates
 * without hardcoding the multiplier introduced by driver-level render upscaling.
 * @param target Hovered card. @param title Primary text. @param description Optional wrapped body.
 * @return True when shown. @errors Missing roots or empty titles return false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ShowNfrOwnedCardTooltip(
  target: wref<inkWidget>, title: String, description: String
) -> Bool {
  let layer: ref<inkLayerWrapper>;
  let root: wref<inkCompoundWidget>;
  let screenSize: Vector2;
  let screenToRoot: Vector2;
  let position: Vector2;
  let rootSize: Vector2;
  let photoRootSize: Vector2;
  let visualScale: Float;
  let visualWidth: Float;
  let visualHeight: Float;
  let height: Float = 92.0;
  if !NfrSettings.AreCardTooltipsEnabled() { return false; }
  layer = GameInstance.GetInkSystem().GetLayer(n"inkGameNotificationsLayer");
  if !IsDefined(layer) { layer = GameInstance.GetInkSystem().GetLayer(n"inkMenuLayer"); }
  if IsDefined(layer) { root = layer.GetVirtualWindow(); }
  if !IsDefined(root) { root = this.GetRootWidget() as inkCompoundWidget; }
  if !IsDefined(root) || !IsDefined(target) || Equals(title, "")
    || !this.EnsureNfrOwnedCardTooltip(root) { return false; }
  if NotEquals(this.m_nfrCardTooltipSurface.GetParentWidget(), root) {
    this.m_nfrCardTooltipSurface.Reparent(root);
  }
  rootSize = root.GetSize();
  if NotEquals(description, "") {
    height = MinF(
      94.0 + Cast<Float>(this.EstimateNfrTooltipVisualLines(description)) * 34.0,
      rootSize.Y * 0.80
    );
  }
  photoRootSize = this.GetRootWidget().GetSize();
  visualScale = MinF(
    rootSize.X / MaxF(photoRootSize.X, 1.0),
    rootSize.Y / MaxF(photoRootSize.Y, 1.0)
  );
  visualScale = ClampF(visualScale, 0.25, 1.0);
  visualWidth = 700.0 * visualScale;
  visualHeight = height * visualScale;
  this.m_nfrCardTooltipSurface.SetScale(Vector2(1.0, 1.0));
  this.m_nfrCardTooltipSurface.SetSize(visualWidth, visualHeight);
  this.RebuildNfrTooltipText(title, description, visualScale, visualHeight);
  screenSize = ScreenHelper.GetScreenSize(this.GetPlayerControlledObject().GetGame());
  screenToRoot = Vector2(
    rootSize.X / MaxF(screenSize.X, 1.0),
    rootSize.Y / MaxF(screenSize.Y, 1.0)
  );
  position = Vector2(
    this.m_nfrCardTooltipPointerPosition.X * screenToRoot.X + 28.0,
    this.m_nfrCardTooltipPointerPosition.Y * screenToRoot.Y + 28.0
  );
  if position.X + visualWidth > rootSize.X {
    position.X = MaxF(
      this.m_nfrCardTooltipPointerPosition.X * screenToRoot.X - visualWidth - 28.0,
      0.0
    );
  }
  if position.Y + visualHeight > rootSize.Y {
    position.Y = MaxF(
      this.m_nfrCardTooltipPointerPosition.Y * screenToRoot.Y - visualHeight - 28.0,
      0.0
    );
  }
  this.m_nfrCardTooltipSurface.SetTranslation(position);
  // Photo Mode rebuilds sibling layers. Reordering on every show keeps the tooltip above them.
  root.ReorderChild(this.m_nfrCardTooltipSurface, root.GetNumChildren() - 1);
  this.m_nfrCardTooltipSurface.ReorderChild(
    this.m_nfrCardTooltipTitle,
    this.m_nfrCardTooltipSurface.GetNumChildren() - 1
  );
  this.m_nfrCardTooltipSurface.ReorderChild(
    this.m_nfrCardTooltipDescription,
    this.m_nfrCardTooltipSurface.GetNumChildren() - 1
  );
  this.m_nfrCardTooltipSurface.SetVisible(true);
  NfrLog.Trace(
    s"Photo Mode tooltip shown titleChars=\(StrLen(title)) bodyChars=\(StrLen(description)) "
    + s"renderedTitleChars=\(StrLen(this.m_nfrCardTooltipTitle.GetText())) "
    + s"renderedBodyChars=\(StrLen(this.m_nfrCardTooltipDescription.GetText())) "
    + s"window=\(rootSize.X),\(rootSize.Y) photoRoot=\(photoRootSize.X),\(photoRootSize.Y) "
    + s"screen=\(screenSize.X),\(screenSize.Y) scale=\(visualScale) "
    + s"pointer=\(this.m_nfrCardTooltipPointerPosition.X),"
    + s"\(this.m_nfrCardTooltipPointerPosition.Y) placed=\(position.X),\(position.Y)."
  );
  return true;
}

/** Estimates wrapped visual lines for the configured tooltip width.
 * @param value Multiline body. @return Estimated line count. @errors Empty input returns zero. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func EstimateNfrTooltipVisualLines(value: String) -> Int32 {
  let currentLength: Int32;
  let index: Int32;
  let lines: Int32;
  while index < StrLen(value) {
    if Equals(StrMid(value, index, 1), "\n") {
      lines += Max(1, (currentLength + 43) / 44);
      currentLength = 0;
    } else {
      currentLength += 1;
    }
    index += 1;
  }
  if currentLength > 0 { lines += Max(1, (currentLength + 43) / 44); }
  return lines;
}

/** Creates the shared tooltip surface with the base game's shaped tooltip atlas.
 * @param root Photo Mode root. @return Whether creation succeeded. @errors Missing roots are safe. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func EnsureNfrOwnedCardTooltip(root: wref<inkCompoundWidget>) -> Bool {
  let surface: ref<inkCanvas>;
  let background: ref<inkImage>;
  let frame: ref<inkImage>;
  if IsDefined(this.m_nfrCardTooltipSurface) { return true; }
  if !IsDefined(root) { return false; }
  surface = new inkCanvas();
  surface.SetName(n"nfr_card_tooltip");
  surface.SetAnchor(inkEAnchor.TopLeft);
  surface.SetAnchorPoint(Vector2(0.0, 0.0));
  surface.SetInteractive(false);
  surface.SetOpacity(1.0);
  surface.SetVisible(false);
  surface.Reparent(root);
  background = this.CreateNfrTooltipAtlasPart(n"nfr_card_tooltip_background", n"generic_background");
  background.BindProperty(n"tintColor", n"Tooltip.backgroundColor");
  // Photo Mode remains visually busy behind the notification layer; keep the native Wardrobe
  // background color but make this compact owned surface opaque for dependable legibility.
  background.SetOpacity(1.0);
  background.Reparent(surface);
  frame = this.CreateNfrTooltipAtlasPart(n"nfr_card_tooltip_frame", n"generic_background_fg");
  frame.BindProperty(n"tintColor", n"Tooltip.frameColor");
  frame.Reparent(surface);
  this.m_nfrCardTooltipSurface = surface;
  return true;
}

/** Recreates text with content assigned before it enters the notification-layer window tree.
 * Runtime verification showed that post-mount `SetText` left these owned widgets empty.
 * @param title Primary text. @param description Optional body. @param scale Layer layout scale.
 * @param surfaceHeight Final tooltip height. @return None. @errors Missing surfaces are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func RebuildNfrTooltipText(
  title: String,
  description: String,
  scale: Float,
  surfaceHeight: Float
) -> Void {
  let surface = this.m_nfrCardTooltipSurface;
  let titleWidget: ref<inkText>;
  let descriptionWidget: ref<inkText>;
  if !IsDefined(surface) { return; }
  if IsDefined(this.m_nfrCardTooltipTitle) { surface.RemoveChild(this.m_nfrCardTooltipTitle); }
  if IsDefined(this.m_nfrCardTooltipDescription) {
    surface.RemoveChild(this.m_nfrCardTooltipDescription);
  }
  titleWidget = this.CreateNfrTooltipText(
    n"nfr_card_tooltip_title",
    Max(1, Cast<Int32>(42.0 * scale)),
    20.0 * scale,
    20.0 * scale,
    660.0 * scale,
    54.0 * scale
  );
  titleWidget.SetText(title);
  titleWidget.SetFontStyle(n"Medium");
  titleWidget.SetLetterCase(textLetterCase.UpperCase);
  titleWidget.BindProperty(n"tintColor", n"MainColors.Blue");
  titleWidget.Reparent(surface);
  descriptionWidget = this.CreateNfrTooltipText(
    n"nfr_card_tooltip_description",
    Max(1, Cast<Int32>(30.0 * scale)),
    22.0 * scale,
    72.0 * scale,
    656.0 * scale,
    MaxF(surfaceHeight - 92.0 * scale, 0.0)
  );
  descriptionWidget.SetText(description);
  descriptionWidget.SetFontStyle(n"Medium");
  descriptionWidget.SetLetterCase(textLetterCase.OriginalCase);
  descriptionWidget.BindProperty(n"tintColor", n"Tooltip.descriptionTextColor");
  descriptionWidget.SetOpacity(0.90);
  descriptionWidget.SetVisible(NotEquals(description, ""));
  descriptionWidget.Reparent(surface);
  this.m_nfrCardTooltipTitle = titleWidget;
  this.m_nfrCardTooltipDescription = descriptionWidget;
}

/** Creates one fill-anchored piece of the vanilla tooltip frame.
 * @param name Widget name. @param part Atlas part. @return Configured image. @errors None. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CreateNfrTooltipAtlasPart(name: CName, part: CName) -> ref<inkImage> {
  let image = new inkImage();
  image.SetName(name);
  image.SetAnchor(inkEAnchor.Fill);
  image.SetMargin(new inkMargin(0.0, 0.0, 0.0, 0.0));
  image.SetAtlasResource(r"base\\gameplay\\gui\\common\\tooltip\\tooltips_new.inkatlas");
  image.SetTexturePart(part);
  image.SetStyle(r"base\\gameplay\\gui\\common\\tooltip\\tooltip_style.inkstyle");
  image.SetInteractive(false);
  return image;
}

/** Creates one wrapped tooltip text widget.
 * @param name Widget name. @param fontSize Font size. @param x Left offset.
 * @param y Top offset. @param width Bounds width. @param height Bounds height.
 * @return Configured text. @errors None. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CreateNfrTooltipText(
  name: CName, fontSize: Int32, x: Float, y: Float, width: Float, height: Float
) -> ref<inkText> {
  let text = new inkText();
  text.SetName(name);
  text.SetAnchor(inkEAnchor.TopLeft);
  text.SetAnchorPoint(Vector2(0.0, 0.0));
  text.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
  text.SetFontStyle(n"Regular");
  text.SetFontSize(fontSize);
  text.SetTranslation(Vector2(x, y));
  text.SetSize(width, height);
  text.SetWrapping(true, width, textWrappingPolicy.PerCharacter);
  text.SetHorizontalAlignment(textHorizontalAlignment.Left);
  text.SetVerticalAlignment(textVerticalAlignment.Top);
  text.SetStyle(r"base\\gameplay\\gui\\common\\tooltip\\tooltip_style.inkstyle");
  text.SetOpacity(1.0);
  text.SetVisible(true);
  text.SetInteractive(false);
  return text;
}

/** Appends a non-empty line to a tooltip body.
 * @param value Existing body. @param line New line. @return Joined body. @errors Empty lines are skipped. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func AppendNfrTooltipLine(value: String, line: String) -> String {
  if Equals(line, "") { return value; }
  return Equals(value, "") ? line : value + "\n" + line;
}

/** Releases the owned tooltip before host teardown.
 * @param None. @return None. @errors Missing surfaces are safe. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnUninitialize() -> Void {
  let parent: wref<inkCompoundWidget>;
  if IsDefined(this.m_nfrCardTooltipSurface) {
    parent = this.m_nfrCardTooltipSurface.GetParentWidget() as inkCompoundWidget;
    if IsDefined(parent) { parent.RemoveChild(this.m_nfrCardTooltipSurface); }
  }
  this.m_nfrCardTooltipSurface = null;
  this.m_nfrCardTooltipTitle = null;
  this.m_nfrCardTooltipDescription = null;
  this.m_nfrCardTooltipPointerPosition = Vector2(0.0, 0.0);
  wrappedMethod();
}
