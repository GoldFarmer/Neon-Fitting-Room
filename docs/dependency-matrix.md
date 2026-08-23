# Neon Fitting Room — Dependency Matrix

## Development support baseline

This matrix records the exact baseline used to develop and runtime-validate the first Neon Fitting
Room release. The in-game V and NPC smoke-test checklist passed for this combination.

| Component | Role | Required | Development baseline | Evidence |
| --- | --- | --- | --- | --- |
| Cyberpunk 2077 | Game runtime | Yes | 2.31 | `Cyberpunk2077.exe` product version |
| RED4ext | Native runtime loader | Yes | 1.30.0 | Installed `RED4ext.dll` product version |
| redscript | REDscript compiler/runtime | Yes | 0.5.31 | Installed package version |
| Codeware | Service, UI, localization, and diagnostics facilities | Yes | 1.20.3 | Installed `Codeware.dll` and script banner |
| Equipment-EX | Wardrobe data authority and fake-puppet preview API | Yes | 1.2.9 | Installed script banner |
| Mod Settings | Optional configuration UI | No | 0.2.21 | Installed package version |
| PhotoMode-EX | Recommended companion compatibility mod | No | 1.4.1 | Installed `PhotoModeEx.dll` product version |
| [NPC Outfit Manager](https://www.nexusmods.com/cyberpunk2077/mods/31327) | Broadens NPC Clothing slot eligibility for character records with `AttachmentSlots.Chest` | No | 1.2 | Installed package/source inspection and runtime census |

## Recommended compatible companions

The following mods are compatible with and recommended alongside NFR, but are not NFR runtime
dependencies. Their Nexus page versions were checked on 2026-10-03; those versions are reference
information rather than NFR's development baseline.

| Companion mod | Required by NFR | Nexus page version | Compatibility role |
| --- | --- | --- | --- |
| [NPC Outfit Manager](https://www.nexusmods.com/cyberpunk2077/mods/31327) | No | 1.2 | Broadens NPC Clothing slot availability for Chest-bearing character records |
| [Photomode Camera Reset Fix (look-at-camera lock)](https://www.nexusmods.com/cyberpunk2077/mods/24427) | No | 1.2.0 | Prevents pose or category changes from resetting Look at Camera/Target |
| [Photomode Tweaks](https://www.nexusmods.com/cyberpunk2077/mods/24253) | No | 1.0 | Additional Photo Mode quality-of-life adjustments |
| [Photomode - No Confirm](https://www.nexusmods.com/cyberpunk2077/mods/22872) | No | 0.1 | Removes the Photo Mode exit confirmation |
| [Photomode Cursor Fix](https://www.nexusmods.com/cyberpunk2077/mods/31176) | No | 1.1 | Hides the cursor when the Photo Mode interface is hidden |
| [Photomode UI Improvements](https://www.nexusmods.com/cyberpunk2077/mods/34353) | No | 1.0.3 | Adds complementary Photo Mode UI and workflow improvements |
| [Clean Photomode UI](https://www.nexusmods.com/cyberpunk2077/mods/26742) | No | 1.0 | Reduces Photo Mode interface clutter and rescales UI elements |

This table records compatibility with NFR, not compatibility among every possible combination of
the companion mods. Follow each companion's own requirements and compatibility notes.

## Support policy

- Neon Fitting Room requires the listed game runtime, RED4ext, redscript, Codeware, and Equipment-EX.
- PhotoMode-EX is optional and recommended; NFR's first release does not call a PhotoMode-EX runtime
  API.
- NPC Outfit Manager is optional and recommended for broader NPC Clothing availability. NFR does
  not call its API; it observes the final effective attachment slots after the mod's TweakDB changes.
- The recommended Photo Mode companions above are optional and are not loaded or called by NFR.
- Mod Settings is optional. Without it, NFR uses eight cards per row, enables tooltips and outfit
  icons, and defaults experimental NPC Clothing to disabled. A user with Cyber Engine Tweaks may
  enable NPC Clothing for the current game process through NFR's documented service command; the
  override is not persisted.
- A newer dependency may be accepted only after its relevant smoke-test scenarios pass.
- The first-release behavior has been validated in game against this baseline.
