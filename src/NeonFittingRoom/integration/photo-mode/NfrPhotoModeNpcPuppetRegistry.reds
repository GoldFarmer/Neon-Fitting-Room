module NeonFittingRoom

@if(ModuleExists("EquipmentEx"))
import EquipmentEx.{OutfitSystem}

@if(ModuleExists("EquipmentEx"))
@addField(PlayerPuppet)
private let m_nfrActivePhotoModeNpcPuppet: wref<gamePuppet>;

@if(ModuleExists("EquipmentEx"))
@addField(PlayerPuppet)
private let m_nfrPhotoModeNpcPuppets: array<wref<gamePuppet>>;

/** Registers a concrete NPC Photo Mode puppet and makes it the active clothing target.
 * @param puppet Concrete non-customizable Photo Mode puppet. @return None. @errors Null clears the target. */
@if(ModuleExists("EquipmentEx"))
@addMethod(PlayerPuppet)
public func RegisterNfrPhotoModeNpcPuppet(puppet: wref<gamePuppet>) -> Void {
  let index: Int32;
  this.m_nfrActivePhotoModeNpcPuppet = puppet;
  if !IsDefined(puppet) { return; }
  while index < ArraySize(this.m_nfrPhotoModeNpcPuppets) {
    if Equals(this.m_nfrPhotoModeNpcPuppets[index], puppet) { return; }
    index += 1;
  }
  ArrayPush(this.m_nfrPhotoModeNpcPuppets, puppet);
}

/** Returns the active NPC Photo Mode puppet for target-specific controls.
 * @param None. @return Current NPC target or null. @errors Released puppets resolve as null. */
@if(ModuleExists("EquipmentEx"))
@addMethod(PlayerPuppet)
public func GetNfrActivePhotoModeNpcPuppet() -> wref<gamePuppet> {
  return this.m_nfrActivePhotoModeNpcPuppet;
}

/** Selects an already-created Photo Mode NPC by the native EDIT CHARACTER option label.
 * @param optionText Native attribute-68 label. @param optionData Native selector identity for traces.
 * @return True when a live registered puppet matched. @errors Ambiguous or absent labels retain the
 * current target and return false. */
@if(ModuleExists("EquipmentEx"))
@addMethod(PlayerPuppet)
public func SelectNfrPhotoModeNpcPuppet(optionText: String, optionData: Int32) -> Bool {
  let puppet: wref<gamePuppet>;
  let record: wref<Character_Record>;
  let displayName: String;
  let index: Int32 = ArraySize(this.m_nfrPhotoModeNpcPuppets) - 1;
  while index >= 0 {
    puppet = this.m_nfrPhotoModeNpcPuppets[index];
    if IsDefined(puppet) {
      record = TweakDBInterface.GetCharacterRecord(puppet.GetRecordID());
      if IsDefined(record) {
        displayName = GetLocalizedTextByKey(record.DisplayName());
        if Equals(StrLower(displayName), StrLower(optionText)) {
          this.m_nfrActivePhotoModeNpcPuppet = puppet;
          NfrLog.Trace(
            s"[PM-NPC-REGISTRY][ACTIVE] optionData=\(optionData) optionText=\(optionText) "
            + s"entity=\(EntityID.GetHash(puppet.GetEntityID())) "
            + s"record=\(TDBID.ToStringDEBUG(puppet.GetRecordID()))."
          );
          return true;
        }
      }
    }
    index -= 1;
  }
  NfrLog.Warn(
    s"[PM-NPC-REGISTRY][ACTIVE] No registered puppet matched optionData=\(optionData) "
    + s"optionText=\(optionText); retained the prior clothing target."
  );
  return false;
}

/** Clears session-only NPC registry state during Photo Mode teardown.
 * @param None. @return None. @errors None. */
@if(ModuleExists("EquipmentEx"))
@addMethod(PlayerPuppet)
public func ResetNfrPhotoModeNpcPuppets() -> Void {
  this.m_nfrActivePhotoModeNpcPuppet = null;
  ArrayClear(this.m_nfrPhotoModeNpcPuppets);
}

/** Registers Photo Mode's rendered NPC puppet without changing inventory.
 * @param isCurrentPlayerObjectCustomizable Native source-character capability flag.
 * @return None. @errors Undefined source or preview puppets are logged without mutation. */
@if(ModuleExists("EquipmentEx"))
@wrapMethod(PhotoModePlayerEntityComponent)
private final func SetupInventory(isCurrentPlayerObjectCustomizable: Bool) -> Void {
  let owner: wref<gamePuppet>;
  let preview: wref<gamePuppet>;
  let player: wref<PlayerPuppet>;
  wrappedMethod(isCurrentPlayerObjectCustomizable);
  owner = this.GetOwner() as gamePuppet;
  preview = this.fakePuppet;
  NfrLog.Trace(
    s"[PM-NPC-REGISTRY][SETUP] componentCustomizable=\(this.customizable) "
    + s"currentPlayerCustomizable=\(isCurrentPlayerObjectCustomizable) "
    + this.DescribeNfrPhotoModeNpcPuppet("owner", owner) + " "
    + this.DescribeNfrPhotoModeNpcPuppet("preview", preview)
  );
  if !this.customizable && IsDefined(preview) {
    player = GetPlayer(preview.GetGame());
    if IsDefined(player) { player.RegisterNfrPhotoModeNpcPuppet(preview); }
  }
}

/** Formats stable runtime identity needed to distinguish Photo Mode puppet instances.
 * @param role Relationship to the component. @param puppet Candidate puppet.
 * @return Compact identity string. @errors Missing puppets are reported as undefined. */
@if(ModuleExists("EquipmentEx"))
@addMethod(PhotoModePlayerEntityComponent)
private func DescribeNfrPhotoModeNpcPuppet(role: String, puppet: wref<gamePuppet>) -> String {
  if !IsDefined(puppet) { return s"\(role)=undefined"; }
  return s"\(role)Class=\(puppet.GetClassName())"
    + s" \(role)Entity=\(EntityID.GetHash(puppet.GetEntityID()))"
    + s" \(role)Record=\(TDBID.ToStringDEBUG(puppet.GetRecordID()))";
}
