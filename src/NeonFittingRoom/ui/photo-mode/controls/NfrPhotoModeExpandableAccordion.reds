module NeonFittingRoom

/** Collapses expanded top-level card browsers other than the browser about to open.
 * @param exceptID Control identity that remains eligible to expand. @return None.
 * @errors Missing or partially initialized presenters are skipped. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
public func CollapseNfrTopLevelExpandablePeers(exceptID: CName) -> Void {
  if NotEquals(exceptID, n"outfit")
    && IsDefined(this.m_nfrOutfitBrowser)
    && this.m_nfrOutfitBrowser.isExpanded {
    this.ResetNfrCardSearch(this.m_nfrOutfitBrowser);
    this.m_nfrOutfitBrowser.SetExpanded(false);
    this.UpdateNfrOutfitBrowserSurface();
  }
  if NotEquals(exceptID, n"clothing")
    && IsDefined(this.m_nfrClothingControl)
    && IsDefined(this.m_nfrClothingControl.presenter)
    && IsDefined(this.m_nfrClothingControl.presenter.browser)
    && this.m_nfrClothingControl.presenter.browser.isExpanded {
    this.ResetNfrClothingGroupSearch(n"clothing");
    this.m_nfrClothingControl.presenter.browser.SetExpanded(false);
  }
  this.CollapseNfrNativeTopLevelPeer(this.m_nfrCategoryAdapter, exceptID);
  this.CollapseNfrNativeTopLevelPeer(this.m_nfrPoseAdapter, exceptID);
  this.CollapseNfrNativeTopLevelPeer(this.m_nfrExpressionAdapter, exceptID);
  this.UpdateNfrNativeOptionBrowserLayouts();
}

/** Collapses one native top-level peer unless it is the browser being opened.
 * @param adapter Native selector adapter. @param exceptID Eligible expanding identity.
 * @return None. @errors Missing adapters are ignored. */
@if(ModuleExists("EquipmentEx"))
@addMethod(gameuiPhotoModeMenuController)
private func CollapseNfrNativeTopLevelPeer(
  adapter: ref<NfrNativeOptionBrowserAdapter>,
  exceptID: CName
) -> Void {
  if IsDefined(adapter)
    && IsDefined(adapter.binding)
    && IsDefined(adapter.binding.presenter)
    && IsDefined(adapter.binding.presenter.browser)
    && NotEquals(adapter.binding.presenter.model.controlID, exceptID)
    && adapter.binding.presenter.browser.isExpanded {
    this.ResetNfrCardSearch(adapter.binding.presenter.browser);
    adapter.binding.presenter.browser.SetExpanded(false);
  }
}
