module NeonFittingRoom

/**
 * Centralizes identity and publication metadata for every NFR runtime dependency provider.
 *
 * Concrete implementation dependencies remain documented beside each consuming declaration.
 *
 * @dependencyProvider {
 *   "id": "redscript",
 *   "name": "redscript",
 *   "requirement": "required",
 *   "relationship": "direct",
 *   "url": "https://www.nexusmods.com/cyberpunk2077/mods/1511",
 *   "modules": [],
 *   "surfaces": [
 *     "REDscript annotations, compiler, module imports, and runtime"
 *   ],
 *   "role": "REDscript compiler and runtime"
 * }
 *
 * @dependencyProvider {
 *   "id": "cp2077",
 *   "name": "Cyberpunk 2077",
 *   "requirement": "required",
 *   "relationship": "direct",
 *   "url": "https://www.cyberpunk.net/",
 *   "modules": [],
 *   "surfaces": [
 *     "Photo Mode controller classes, methods, option data, and widget tree",
 *     "Game inventory, transaction, puppet, appearance, and item-record APIs",
 *     "ink widget, input, callback, animation, and scrolling APIs"
 *   ],
 *   "role": "Game runtime and native Photo Mode API"
 * }
 *
 * @dependencyProvider {
 *   "id": "codeware",
 *   "name": "Codeware",
 *   "requirement": "required",
 *   "relationship": "direct",
 *   "url": "https://www.nexusmods.com/cyberpunk2077/mods/7780",
 *   "modules": [
 *     "Codeware"
 *   ],
 *   "surfaces": [
 *     "ScriptableService and ScriptableServiceContainer",
 *     "Codeware.Localization ModLocalizationProvider and ModLocalizationPackage",
 *     "Codeware.UI controls and ScreenHelper"
 *   ],
 *   "role": "Service lifecycle, localization, reflection, screen, and UI controls"
 * }
 *
 * @dependencyProvider {
 *   "id": "cyberEngineTweaks",
 *   "name": "Cyber Engine Tweaks",
 *   "requirement": "optional",
 *   "relationship": "interop",
 *   "url": "https://www.nexusmods.com/cyberpunk2077/mods/107",
 *   "modules": [],
 *   "surfaces": [
 *     "CET console invocation of NfrConfig.SetNpcClothingEnabled"
 *   ],
 *   "role": "Process-local console fallback when Mod Settings is absent"
 * }
 *
 * @dependencyProvider {
 *   "id": "archiveXL",
 *   "name": "ArchiveXL",
 *   "requirement": "required",
 *   "relationship": "transitive",
 *   "url": "https://www.nexusmods.com/cyberpunk2077/mods/4198",
 *   "modules": [],
 *   "surfaces": [
 *     "Equipment-EX transitive ArchiveXL runtime contract"
 *   ],
 *   "role": "Equipment-EX runtime requirement"
 * }
 *
 * @dependencyProvider {
 *   "id": "tweakXL",
 *   "name": "TweakXL",
 *   "requirement": "required",
 *   "relationship": "transitive",
 *   "url": "https://www.nexusmods.com/cyberpunk2077/mods/4197",
 *   "modules": [],
 *   "surfaces": [
 *     "Equipment-EX transitive TweakXL runtime contract"
 *   ],
 *   "role": "Equipment-EX runtime requirement"
 * }
 *
 * @dependencyProvider {
 *   "id": "equipmentEx",
 *   "name": "Equipment-EX",
 *   "requirement": "required",
 *   "relationship": "direct",
 *   "url": "https://www.nexusmods.com/cyberpunk2077/mods/6945",
 *   "modules": [
 *     "EquipmentEx"
 *   ],
 *   "surfaces": [
 *     "EquipmentEx.OutfitSystem",
 *     "EquipmentEx.OutfitPart",
 *     "EquipmentEx.PaperdollHelper"
 *   ],
 *   "role": "Wardrobe catalog, outfit state, slot model, and preview-puppet authority"
 * }
 *
 * @dependencyProvider {
 *   "id": "red4ext",
 *   "name": "RED4ext",
 *   "requirement": "required",
 *   "relationship": "transitive",
 *   "url": "https://www.nexusmods.com/cyberpunk2077/mods/2380",
 *   "modules": [],
 *   "surfaces": [
 *     "Native plugin loading required by Codeware and Equipment-EX"
 *   ],
 *   "role": "Native plugin loader required by Codeware and Equipment-EX"
 * }
 *
 * @dependencyProvider {
 *   "id": "modSettings",
 *   "name": "Mod Settings",
 *   "requirement": "optional",
 *   "relationship": "direct",
 *   "url": "https://www.nexusmods.com/cyberpunk2077/mods/4885",
 *   "modules": [
 *     "ModSettingsModule"
 *   ],
 *   "surfaces": [
 *     "ModSettings runtime properties and ModSettings.GetVars"
 *   ],
 *   "role": "Persistent user-facing configuration UI"
 * }
 *
 * @dependencies {
 *   "id": "archiveXL",
 *   "adopted": "1.26.1",
 *   "min": "TBD"
 * }
 *
 * @dependencies {
 *   "id": "tweakXL",
 *   "adopted": "1.11.3",
 *   "min": "TBD"
 * }
 *
 * @dependencies {
 *   "id": "red4ext",
 *   "adopted": "1.30.0",
 *   "min": "TBD"
 * }
 */
public abstract class NfrDependencies {}
