module NeonFittingRoom

@if(ModuleExists("EquipmentEx"))
@addField(PlayerPuppet)
private let m_nfrPhotoModeConsumeNextCameraWheel: Bool;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrControlsInputGuardViewport: wref<inkWidget>;

@if(ModuleExists("EquipmentEx"))
@addField(gameuiPhotoModeMenuController)
private let m_nfrControlsInputGuardRegistered: Bool;

/** Prevents camera zoom when the matching wheel release occurred inside the controls viewport.
 * The release decision comes from the wheel event's own cursor coordinates and is consumed once.
 * @param action Player input action. @param consumer Host input consumer.
 * @return Host result unless the guarded camera-wheel action is consumed.
 * @errors Missing or out-of-order wheel decisions delegate unchanged. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(PlayerPuppet)
protected cb func OnAction(action: ListenerAction, consumer: ListenerActionConsumer) -> Bool {
  if Equals(ListenerAction.GetName(action), n"PhotoMode_CameraMouseWheel") {
    if this.m_nfrPhotoModeConsumeNextCameraWheel {
      NfrLog.Trace("Controls viewport consumed matching camera wheel action.");
      ListenerActionConsumer.Consume(consumer);
      return false;
    }
    NfrLog.Trace("Controls viewport delegated unmatched camera wheel action.");
  }
  return wrappedMethod(action, consumer);
}

/** Resolves the active native controls viewport and installs the pre-release coordinate probe.
 * @param None. @return None. @errors Missing or changed host ancestry leaves native input unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func EnsureNfrPhotoModeControlsInputGuard() -> Void {
  this.EnsureNfrPhotoModeControlsInputGuardFor(this.GetNfrOutfitBrowserHost());
}

/** Moves the coordinate guard to the scroll viewport containing the supplied page widget.
 * @param start Widget inside the active controls list. @return None.
 * @errors Missing host ancestry leaves the current guard unchanged. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func EnsureNfrPhotoModeControlsInputGuardFor(start: wref<inkWidget>) -> Void {
  let current: wref<inkWidget> = start;
  let listRoot: wref<inkWidget>;
  while IsDefined(current) {
    if IsDefined(current.GetControllerByType(n"inkScrollController")) {
      listRoot = current;
      break;
    }
    current = current.GetParentWidget();
  }
  if !IsDefined(listRoot) { return; }
  this.m_nfrControlsInputGuardViewport = listRoot;
  if !this.m_nfrControlsInputGuardRegistered {
    this.RegisterToGlobalInputCallback(
      n"OnPreOnRelease", this, n"OnNfrPhotoModeControlsWheelRelease"
    );
    this.m_nfrControlsInputGuardRegistered = true;
  }
  NfrLog.Trace(
    s"Controls wheel-coordinate guard attached name=\(NameToString(listRoot.GetName()))."
  );
}

/** Classifies a wheel release using its own cursor position in the active viewport's local space.
 * @param evt Global pre-release pointer event. @return False to preserve native propagation.
 * @errors Missing players, viewports, or measurable sizes safely delegate camera input. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
protected cb func OnNfrPhotoModeControlsWheelRelease(evt: ref<inkPointerEvent>) -> Bool {
  let player = this.GetPlayerControlledObject() as PlayerPuppet;
  let pointer: Vector2;
  let local: Vector2;
  let size: Vector2;
  let scrollController: wref<inkScrollController>;
  let isUp: Bool = evt.IsAction(n"PhotoMode_ScrollUp");
  let isDown: Bool = evt.IsAction(n"PhotoMode_ScrollDown");
  let actionLabel: String;
  let shouldConsume: Bool;

  if !IsDefined(player) { return false; }
  player.m_nfrPhotoModeConsumeNextCameraWheel = false;
  if !isUp && !isDown { return false; }
  actionLabel = isUp ? "PhotoMode_ScrollUp" : "PhotoMode_ScrollDown";
  if !IsDefined(this.m_nfrControlsInputGuardViewport) {
    NfrLog.Trace(s"Wheel coordinate unavailable action=\(actionLabel) viewport=false.");
    return false;
  }

  pointer = evt.GetScreenSpacePosition();
  local = WidgetUtils.GlobalToLocal(this.m_nfrControlsInputGuardViewport, pointer);
  size = this.m_nfrControlsInputGuardViewport.GetSize();
  if size.X <= 0.0 || size.Y <= 0.0 {
    size = this.m_nfrControlsInputGuardViewport.GetDesiredSize();
  }
  shouldConsume = size.X > 0.0 && size.Y > 0.0
    && local.X >= 0.0 && local.Y >= 0.0
    && local.X <= size.X && local.Y <= size.Y;
  player.m_nfrPhotoModeConsumeNextCameraWheel = shouldConsume;
  if shouldConsume {
    scrollController = this.m_nfrControlsInputGuardViewport.GetControllerByType(
      n"inkScrollController"
    ) as inkScrollController;
    if IsDefined(scrollController) {
      scrollController.Scroll(isUp ? 1.0 : -1.0, true);
      evt.Consume();
    }
  }
  NfrLog.Trace(
    s"Wheel coordinate action=\(actionLabel) "
    + s"screen=\(pointer.X),\(pointer.Y) local=\(local.X),\(local.Y) "
    + s"size=\(size.X),\(size.Y) consume=\(shouldConsume) "
    + s"manualScroll=\(shouldConsume && IsDefined(scrollController))."
  );
  return false;
}

/** Releases the global coordinate callback and active viewport reference.
 * @param None. @return None. @errors Partial initialization is safe. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func ReleaseNfrPhotoModeControlsInputGuard() -> Void {
  if this.m_nfrControlsInputGuardRegistered {
    this.UnregisterFromGlobalInputCallback(
      n"OnPreOnRelease", this, n"OnNfrPhotoModeControlsWheelRelease"
    );
  }
  this.m_nfrControlsInputGuardRegistered = false;
  this.m_nfrControlsInputGuardViewport = null;
}

/** Installs the controls input guard after the Photo Mode page is shown.
 * @param reversedUI Host orientation. @return Host result. @errors Missing controls retain native behavior. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnShow(reversedUI: Bool) -> Bool {
  let result = wrappedMethod(reversedUI);
  this.EnsureNfrPhotoModeControlsInputGuard();
  return result;
}

/** Removes coordinate callbacks and pending wheel decisions during controller teardown.
 * @param None. @return None. @errors Partial initialization is safe. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(gameuiPhotoModeMenuController)
protected cb func OnUninitialize() -> Void {
  let player = this.GetPlayerControlledObject() as PlayerPuppet;
  this.ReleaseNfrPhotoModeControlsInputGuard();
  if IsDefined(player) { player.m_nfrPhotoModeConsumeNextCameraWheel = false; }
  wrappedMethod();
}
