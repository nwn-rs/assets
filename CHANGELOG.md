# Changelog

## [88.8193.36-13] - 2024-04-13

### Fixed

- Fixed a crash caused by static lighting on certain tilesets, as mainly seen with the Toolset.

## [88.8193.36-12] - 2024-02-23

### Fixed

- Fixed client AoEs sometimes adding duplicate objects.
- Fixed a bug where the client objects appear to be frozen in place until the game is restarted.
- Fixed learning a stacked scroll making the remainder of the stack unusable.
- Fixed a crash that happens after several loadscreens on some Linux systems.
- Fixed the bug report message pointing at the wrong URL.
- Fixed the MacOS binaries not containing the aarch64 build.
- Fixed screen capture tools like OBS and Steam not being able to read the full framebuffer content.

### Changed

- Improved the AV warn message.
- Reverted movement teleport fix because it was resulting in jerky WASD movement for some players.

## [88.8193.36-11] - 2024-02-06

### Credits

This release was developed for personal enjoyment and out of goodwill for our fellow players and creators by unpaid software engineers from the NWN community:

- clippy, Daz, Jasperre, Liareth, niv, shadguy, Soren, Squatting Monk, tinygiant, virusman

To our fellow community:

Thank you all for keeping this shared adventure alive.

### Highlights

- New HDR-bloom postprocessing effect accumulates overlapping effects more naturally and makes intense colors bleed into the surrounding pixels.
- Improvements to the gameplay UI, such as toggling object highlight by double-pressing TAB.
- Significant performance improvements across the board, both on servers and clients.
- Many new and improved scripting functions, including support for synchronised audio playback and improvements to the scriptable UI.
- Over a hundred bugfixes, including several notorious 20-year-old bugs, such as area objects sometimes showing up too late.
- Script compiler is now open source and available as a standalone tool at https://github.com/niv/neverwinter.nim.

You are cordially invited to join our developer Discord, here: https://nwn.beamdog.net/discord/

Kindly report issues you find at https://github.com/Beamdog/nwn-issues by following the instructions provided there.

### Added

- Added HDR-bloom postprocessing effect.
- You can now lock object highlighting by double-tapping TAB instead of holding it down permanently.
- Added Debug UI panel to view Sound system details.
- Added a set of console commands (`perfstats*`) to get performance data.
- Added game setting for VSync, including support for adaptive VSync.
- Added `-noaliases` CLI arg, which ignores aliases in nwn.ini and always uses the default values.
- Added setting to tweak the minimum Z (height) offset used by keyholing.
- Added support for custom damage visuals for ammunition.
- Added support for loading/saving script sets in the Toolset Area Properties dialog.
- Added a Direct Connect button directly in the Multiplayer menu.
- Added nwscript support for raw string literals: `r".."` and `R".."`, which can also span multiple lines.
- Added new GUI events: `GUIEVENT_CHATLOG_PORTRAIT_CLICK` and `GUIEVENT_PLAYERLIST_PLAYER_TELL`.
- Added new `cachedmodels.2da` that lists all models that will always be kept loaded in memory. Use with care.
- Loadscreen hints are now displayed in chatlog.
- Mouse cursor scaling can optionally be set independent of the UI scale chosen (Game Options -> UI -> Mouse Cursor Scale Override).

#### 30 New VM functions

- `SetEffectCreator()`, `SetEffectSpellId()`, `SetEffectCasterLevel()`
- `SqlGetColumnCount()`, `SqlGetColumnName`().
- `GetSpellAbilityCount()`, `GetSpellAbilitySpell()`, `GetSpellAbilityCasterLevel()`, `GetSpellAbilityReady()`, `SetSpellAbilityReady()`
- `JsonObjectSetInplace()`, `JsonObjectDelInplace()`, `JsonArraySetInplace()`, `JsonArrayInsertInplace()`, `JsonArrayDelInplace()`
- `SetAreaGrassOverride()`, `RemoveAreaGrassOverride()`, `SetAreaDefaultGrassDisabled()`
- `SetAge()`, `JsonToTemplate()`
- `GetAttacksPerRound()`, `EffectEnemyAttackBonus()`
- `SetAreaTileBorderDisabled()`, `GetAreaNoRestFlag()`, `SetAreaNoRestFlag()`
- `StartAudioStream()`, `StopAudioStream()`, `SetAudioStreamPaused()`, `SetAudioStreamVolume()`, `SeekAudioStream()`

See `nwscript.nss` for documentation.

#### New NUI features

- Added `image_region` property for image button widgets.
- Added window title text coloring.
- Added window size and edge constraints.
- Added support for binding array data in draw lists (except inside list views).
- Added support for `_RECT` type in draw lists.
- Added text and number transformation parameter support to binds (e.g. render a int as hex).
- Added support for custom fonts for whole windows, layout groups, and individual widgets.

#### New `ruleset.2da` entries

- `TURN_RESISTANCE_AFFECTS_PCS`
- `SKILL_SET_TRAP_DURATION`
- `SKILL_FLAG_TRAP_DURATION`
- `SKILL_DISABLE_TRAP_DURATION`
- `SKILL_RECOVER_TRAP_DURATION`
- `SKILL_EXAMINE_TRAP_DURATION`
- `SKILL_OPEN_LOCK_DURATION`
- `SKILL_LOCK_DURATION`
- `SKILL_HIDE_IN_PLAIN_SIGHT_COOLDOWN`
- `SKILL_TAUNT_COOLDOWN`
- `SKILL_PICKPOCKET_COOLDOWN`
- `SKILL_ANIMAL_EMPATHY_COOLDOWN`

### Changed

#### Gameplay

- Game now shows a descriptive error message, instead of crashing if file access is blocked (e.g. by antivirus software).
- Object popup information will now update dynamically, for example when taking damage.
- The game now allows logins from private network addresses (LAN only) even if the masterserver is currently unreachable.
- NWSync will keep data marked for deletion, that has been written recently, a little while longer (default: 14 days).
- Module buttons in the New Game browser now have the same height as Campaigns.

#### Graphics

- Implemented use of OpenGL renderbuffers and framebuffer targets.
- SSAO now runs at half resolution but with additional smoothing.
- PLT-on-GPU generation now uses custom offscreen framebuffer target. This means the output texture size is no longer limited to screen resolution.
- Mouse cursors can be any resolution, and scale at non-integer values.
- Added validation of compiled models upon first load to fix invalid normals and tangents.

#### VM functions

- `GetHasFeat()` now has `bIgnoreUses` parameter.
- `SetObjectTextBubbleOverride()` now works for items in inventories.
- `ActionCastSpellAt{Object,Location}()` now have `nClass` and `bSpontaneousCast` parameters.
- `ResManGetFileContents()` can now return binary data in base64 or hex encoding.
- `TemplateToJson()` and `JsonToTemplate()` now also support RESTYPEs: DLG, UTS, IFO, FAC, ITP, JRL, GUI, GFF.
- `SqlPrepareQueryObject()` temporary databases are now entirely in-memory (`:memory:`).
- `FloatingText{String,StrRef}OnCreature()` now have `bChatWindow` parameter.
- `GetLastSpellCastClass()` now returns the AOE creator's class in AOE scripts.
- `EffectDamageResistance()` and `EffectDamageReduction()` now have a `bRangedOnly` parameter.
- `GetEffectType()` now has a `bAllTypes` parameter.
- `NuiCreate()` and `NuiCreateFromResRef()` now have a `sEventScript` parameter.
- `GetItemPossessor()` now has a `bReturnBags` parameter.
- `GetResRef()` now works with encounter objects.
- `EffectDispelMagic()` made consistent with new caster level calculations and will always utilize stored caster level of effects.
- Area of Effect objects now consistently store and retrieve their caster level and spell ID.

See `nwscript.nss` for documentation.

#### Script Compiler

- For loops can now take non-integer expressions in the first and third part of a loop statement. (e.g. floating point values now work).
- Parser now understands floating point values such as `0f`, `.0` and `.42f`.
- `const` declarations can now contain any constant expression (such as arithmetic), including previously defined consts.

#### Logging

- Changed "Error:" messages in client log to clarify they are related to the sound subsystem.
- Updated a log message regarding bad PWK use nodes to provide more explicit feedback.
- Will print 2DA load failures to log instead of just crashing the game.
- In case of module corruption, game will now print the relevant area resref to the log.
- BIC gff validator no longer prints a pointless log message every time a file successfully validates.
- Corrected crash dialog message URL.

#### Misc

- nui_skin.tml can now specify an array of fonts, with their properties, to bake into the font atlas.
- NUI can now load DDS images, which are only used if no other texture format of same name is found.
- Caster level calculations are now made consistent across the engine including using the Caster Level Multiplier for spells.
- You can no longer give gold to placeables that have no inventory enabled.
- Updated Sqlite3 implementation to 3.42.0.

#### 2DA changes

- `MemorizesSpells=0` with `SpellbookRestricted=0` combination in `classes.2da` is now valid.
- `damagetypes.2da` has a new `DamageRangedProjectile` column.
- `ammunitiontypes.2da` has new `AmmunitionType` and `DamageRangedProjectile` columns.
- `packages.2da` now allows values over 255.
- `vfx_persistent.2da` now allows values over 255 for mobile AOEs.

### Removed

- Removed legacy code for reading pre-EE encrypted premium modules. All premium modules shipped with EE are in default MOD format and not affected by this change.
- All rules-related internal checks on expansion pack availability have been removed from the game client and server.
- All engine code for deprecated and nonfunctional multi-byte lang support has been removed.

### Fixed

#### Crash Fixes

- Fixed a server crash on area load due to bad GFF data.
- Fixed a server crash due to a player having outdated automap data.
- Fixed a server crash that could happen if a creature died during the `EffectRunScript` interval script.
- Fixed a client crash related to models with no or corrupt faces.
- Fixed a client crash when decoding some mp3 files.
- Fixed a client crash caused by missing bone weights in model skinmeshes.
- Fixed a client crash when enabling the PLT-on-GPU setting and loading PLT textures with an uneven number of texels per row.
- Fixed a client crash when loading a module with a missing movie.
- Fixed a client crash when using NUI scrollbars in a group with many elements.
- Fixed a client crash that could happen when applying a gamma modifier to an image.
- Fixed a client crash when loading a corrupt TGA file.
- Fixed a client crash that could happen when exiting a module that used custom shaders.
- Fixed a client crash that happened if server gave info about a baseitem client does not know about.
- Fixed a client crash caused by bad custom content related to customized damage type 2das.
- Fixed a rare client crash when trying to select a race and Human is not a playable race.
- Fixed a rare client crash on game shutdown if music was still playing.
- Fixed a rare client crash when trying to spawn a ranged projectile.
- Fixed a very rare client crash when handling inventory items.

#### Gameplay

- Fixed aura VFX not being rendered after an area change.
- Fixed a race condition where a PC would teleport to the wrong part of the map after an area transition.
- Fixed a race condition that could lead to objects being invisible for a client.
- Fixed VFX on placeables not fading out when the placeable is destroyed.
- Fixed an issue where special attacks that missed still caused damage to target's defensive effects.
- Fixed issue where Entangle and other effects stopping movement sometimes left dexterity on 3.
- Fixed stat gains that affect skill points not being validated correctly at levelup.
- Fixed Effect Icons getting removed from the top bar if there are icons from permanent effects still in effect.
- Fixed buffer stutter when resuming music playback.
- Fixed not being able to cast automatic silent spells if predecessor feats were missing.
- Fixed incorrect attack bonus vs X data shown on charsheet.
- Fixed custom two-handed/offhand weapon strength modifiers not showing correctly on the character sheet.
- Fixed some visual effects (like visibility) not properly updating when updated or reattached.
- Fixed journal entries not being retained after relogging on a server.
- Fixed area lighting still appearing even when under the blindness effect.
- Fixed damage color regressions from 8193.35.
- Fixed click to move not respecting modified `ruleset.2da` stealth/detect mode movement penalties.
- Fixed effect caster level not being included in save games.
- Fixed polymorph making every subfeat in the quickbar change to "Cancel Polymorph".
- Fixed nwsync repository modules unable to progress to the next module/chapter.
- Fixed clientside objects not being properly cleaned up, leading to degraded performance as play session progressed.
- Fixed Defensive Stance getting cancelled without notifying the clients.
- Fixed a bug where party members standing at elevation over 2m could cause information about other objects to be lost.
- Fixed a regression with Leave Lootable Corpse where generated remains were clickable on clients.
- Fixed incorrect total weight carried calculating when using stacks of items with weight property.
- Fixed a rare issue where a malformed tile walkmesh would cause levitation.
- Fixed critical threat roll displaying incorrect totals if attacks are made with a penalty.
- Fixed vsync negatively affecting (un)load times of very large areas.

#### Toolset

- Fixed structures passed using the ?: operator causing a bad compiler state.
- Fixed toolset clobbering module UUID, when the author has manually embedded one with a GFF editor.
- Fixed toolset not preserving scriptset changes after loading a scriptset into a Trigger instance.
- Fixed armor parts over 255 not working in the toolset.
- Fixed PLT textures not updating correctly when the color is changed.

#### Graphics

- Fixed PLT-on-GPU not properly loading custom palette textures.
- Fixed using custom palettes for PLT in combination with the generate-PLT-on-GPU setting.
- Fixed regression where beams were rendered with wrong width/thickness.
- Fixed Material Shader Uniforms not refreshing when a creature's appearance changed.
- Fixed keyholing not always applying properly on some geometry.
- Fixed model tangent generation unable to handle faces with zero area.
- Fixed the weather density shader uniform not always going to 0 at the end of the transition when setting weather to clear.
- Fixed flat model planes generating invalid normals when both sides of the plane shares smoothing group.
- Fixed model part combining not taking into account materialname fields being different between nodes.
- Fixed an issue with texture displacement that would cause warping when texture was viewed from steep viewangles.
- Fixed a memory corruption when using procedural texture distortion if the image dimensions exceed 256x256.
- Fixed a minor memory leak related to PLT-on-GPU generation.

#### Scripting

- Fixed a memory leak in the `RandomName()` nwscript function.
- Fixed `ItemPropertyCustom()` returning a valid itemproperty if a required parameter was -1.
- Fixed `GetAreaLightDirection()` causing scripting errors.
- Fixed `GetAssociate()` to honor the `nAssociateIndex` parameter for Dominated Associates.
- Fixed `DecrementRemainingFeatUses()` to work correctly on NPCs using feats with successors when they don't have the some of the intermediate feats.
- Fixed `SetWeather()` causing the weather effects to disappear if setting the type to the already current.
- Fixed `EffectModifyAttacks()` not recalculating total bonus attacks when being applied.
- Fixed `LongJmp()` incorrectly modifying some passed return values.
- Fixed `SetCreatureBodyPart()` erroneously modifying equipped armor.
- Fixed `SetCreatureBodyPart()` changes only being seen by a single client in multiplayer.
- Fixed `SetCreatureBodyPart()` failing to update some armor appearances if no skinmesh was used.
- Fixed `SetMaterialShaderUniform*()` calls not propagating to head/wing/tail/cloak models.
- Fixed `SetFacing()` not sending updates to clients for changes of less than 20 degrees.
- Fixed `SetCreatureAppearanceType()` not updating all appearance related variables.
- Fixed `CopyItem()` not copying the hidden when equipped field.
- Fixed `SetObjectUiDiscoveryMask()` while holding TAB not taking effect until release.
- Fixed `EffectDamageReduction()` not always being checked on placeables and doors when other effects are applied.
- Fixed PCs not being searchable with `GetObjectByTag()` after relogging.
- Fixed sqlite database transaction rollback not working correctly in DelayCommands.
- Fixed the encounter object support in `ObjectToJson()`, `CopyObject()`, `SqlBindObject()`, `StoreCampaignObject()`.
- Fixed effect links not being retained after relogging on a server.
- Fixed traps created by nwscript not being detectable until after a save/load cycle.
- Fixed a visual corruption when modifying armor that is hidden.
- Fixed `ActionUseFeat()` with an invalid target to queue a combat feat against the current target the creature is attacking.
- Fixed SetShaderUniformVec()'s 4th float parameter clobbering the 3rd float parameter when saving as gff.
- Area of Effect scripts now use the spell ID and caster level that was stored when the AOE was created.

#### Misc

- Fixed cutscene camera settings to use 1.69 values that existing cutscenes expect.
- Fixed traps without a key tag set getting destroyed by a creature carrying an item with no tag set.
- Fixed clients leveling up in a 4th class on a server running version 8193.34 or earlier.
- Fixed ELC only validating domain feats for last chosen class.
- Fixed dynamic area light fade timers not resetting properly upon changing area.
- Fixed baseitems.2da line IDs over 255 giving bad feedback messages when pickpocketing or acquiring unidentified items.
- Fixed Shou Disciple allowing for 2d20 unarmed damage in some cases.
- Fixed `GetName()` description in `nwscript.nss`.
- Fixed `SetObjectUiDiscoveryMask()` description in `nwscript.nss`.
- Fixed `SetBaseAttackBonus()` description in `nwscript.nss` to properly describe how it works on PCs.
- Fixed News panel on main menu showing ".. 0 more .." with exactly 5 unread news items present.

### Performance Improvements

#### Scripting

- Optimized instruction decoding in the nwscript VM.
- Optimized instruction counting in the nwscript VM.
- Optimized how strings are pushed and popped on the nwscript VM stack.
- Optimized how `string` and `json` constants work in the nwscript VM.
- Added a second pass over the generated bytecode to meld some redundant instructions together.
- Where possible, expressions are now evaluated at compile time (instead of runtime).

#### Graphics

- Optimized internal quaternion math.
- Low level optimizations to how shadow edges are built.
- Improved PLT shader generation performance by reserving mipmap storage in advance.
- Various low level optimizations to the renderer.
- No longer do distance sorting of particle emitters that have no particles.
- Optimized away memory allocations and copies in BSP scene management.
- Optimized computing keyholing dissolve in some cases.
- Several minor optimizations to emitter/particle rendering.

#### Misc

- Optimized loading times for areas with many placeables.
- Sped up area unloading by up to 10x.
- In singleplayer, if struggling to hit 60fps, some server logic will yield to favor rendering instead.
- Optimized away most of the unnecessary string copies.
- Optimized how object updates are calculated by the server.
- Reduced some performance overhead related to visual transforms.
- Optimized ruleset.2da entry lookup.
- Reduced memory and performance footprint of triggers and encounters.

### Security

- Updated bundled OpenSSL.
- Fixed an exploit that allowed hacked clients to teleport anywhere in an area.

## [87.8193.35-40] - 2023-05-11

### Credits

This patch was made entirely by community members: Done entirely for personal enjoyment, out of good will and with copious amounts of adhesive.

Development team:

- clippy, Daz, Jasperre, Liareth, niv, Soren, tinygiant, virusman

With explicit thanks to:

- The NWNDEV Discord folks. Your testing and support is invaluable.
- The Neverwinter Vault.
- Nereida and Zwerkules.
- Everyone in the community!

### Highlights

- Spells and spell-like abilities now display a targeting indicator displaying their range and, if appropriate, their AOE shape and size.
- Added support for up to 8 multiclasses, configurable per-module.
- Improved area load times by up to 100x!
- Added an in-game News UI that shows upcoming patches and community news.
- NUI windows will no longer break input to the game (WASD, drag&drop).
- Added a new "Toon" postprocessing shader.
- Hundreds of new functions and goodies for module builders.
- Hundreds of bugfixes and optimizations.

### Added

- Added support for up to 8 multiclasses on creatures, controlled by `ruleset.2da` toggle.
- Added spell targeting indicators, sourced from `spells.2da`.
- Added a News UI to the main menu with preview of upcoming patches and important community news.
  - All nwsync CI repos can add their own news as well.
- Added a new "Toon" postprocessing shader that makes NWN looks more like a cartoon.
  - Disabled by default, set `graphics.fbo.toon.enabled = true` to enable.
  - Includes a few other `graphics.fbo.toon.*` settings to fine-tune.
- Added support for dynamic area lighting (e.g. moving sun). See `nw_dynlight.nss` for details.
- Added option to combine PLT textures on the GPU using shaders.
- Added support for custom damage types. The game can now support up to 32 damage types (13 hardcoded plus up to 19 custom).
- Added support for customizable weapon glow FX.
- Added support for emitters with custom shaders.
- Added scriptable (per-player) global shader uniforms (see `SetShaderUniform*` in `nwscript.nss` and `inc_scriptable.shd`).
- Added aarch64 client and server linux binaries.
- Added support for arbitrary character encoding/languages through a new `encoding.2da`.
- Added option to confirm casting of spells that target self (so you can preview the impact area).
- Added new nwscript built-in constants: `LOCATION_INVALID`, `JSON_FALSE`, `JSON_TRUE`, `JSON_OBJECT`, `JSON_ARRAY`, `JSON_STRING`.
- Modules may now specify a "default character", which can be shipped as a .bic file inside the .mod.
  - If specified, the module is launched immediately using that character without options to choose a different one or create new.
  - To use, set the `"Mod_DefaultBic"` resref field in `module.ifo` (no GUI option yet).
- Modules may now specify party control mode that takes precedence over server settings.
  - No GUI option yet, but you can set `"Mod_PartyControl"` INT in `module.ifo`: 0=Server default, 1=enabled, 2=disabled.
- Added 8 new tile pathnodes ('q'..'x').
- Added support for wireframe rendering in debug UI.
- Added Cancel button to the NWScript UI object picker.
- Added rock/chasm crosser to Medieval Rural 2.
- Added missing tiles to Medieval City 2.

#### 82 new NWScript functions (see `nwscript.nss` for documentation)

  - `UnyieldingEffect()`
  - `IgnoreEffectImmunity()`
  - `SetShaderUniformFloat()`, `SetShaderUniformInt()`, `SetShaderUniformVec()`
  - `SetSpellTargetingData()`, `SetEnterTargetingModeData()`
  - `GetMemorizedSpellCountByLevel()`, `GetMemorizedSpellId()`, `GetMemorizedSpellReady()`
  - `GetMemorizedSpellMetaMagic()`, `GetMemorizedSpellIsDomainSpell()`
  - `SetMemorizedSpell()`, `SetMemorizedSpellReady()`, `ReadySpellLevel()`
  - `ClearMemorizedSpell()`, `ClearMemorizedSpellBySpellId()`
  - `GetKnownSpellCount()`, `GetKnownSpellId()`, `GetIsInKnownSpellList()`
  - `GetSpellUsesLeft()`, `GetSpellLevelByClass()`
  - `ReplaceObjectAnimation()`
  - `SetObjectVisibleDistance()`, `GetObjectVisibleDistance()`
  - `SetGameActivePause()`, `GetGamePauseState()`
  - `SetGender()`
  - `SetSoundset()`, `GetSoundset()`
  - `SetCommandingPlayer()`
  - `SetCameraLimits()`, `SetCameraFlags()`
  - `RegExpMatch()`, `RegExpIterate()`, `RegExpReplace()`
  - `ResManGetFileContents()`
  - `CompileScript()`
  - `AttachCamera()`
  - `GetObjectUiDiscoveryMask()`, `SetObjectUiDiscoveryMask()`
  - `SetObjectTextBubbleOverride()`
  - `ClearObjectVisualTransform()`
  - `GetLastGuiEventVector()`
  - `GetAreaLightColor()`, `SetAreaLightColor()`
  - `GetAreaLightDirection()`, `SetAreaLightDirection()`
  - `AbortRunningScript()`
  - `GetScriptBacktrace()`, `GetScriptRecursionLevel()`
  - `SetJmp()`, `LongJmp()`, `GetIsValidJmp()`
  - `GetScriptName()`, `GetScriptChunk()`
  - `EffectPacified()`, `EffectBonusFeat()`, `EffectTimestopImmunity()`, `EffectForcedWalk()`
  - `GetPlayerBuildVersionPostfix()`, `GetPlayerBuildVersionCommitSha1()`
  - `GetEffectLinkId()`
  - `GetFeatRemainingUses()`
  - `GetTileID()`, `GetTileOrientation()`, `GetTileHeight()`
  - `SetTile()`, `SetTileJson()`
  - `SetTileAnimationLoops()`
  - `ReloadAreaGrass()`, `ReloadAreaBorder()`
  - `SetEffectIconFlashing()`
  - `GetPCItemLastEquippedSlot()`, `GetPCItemLastUnequippedSlot()`
  - `GetSpallCastSpontaneously()`, `GetLastSpellLevel()`
  - `SqlResetQuery()`
  - `GetTickRate()`, `GetMicrosecondCounter()`, `GetSpellFeatId()`
  - `HashString()`

#### NUI additions

  - NUI can now be skinned, both globally and per-module. See `nui_skin.tml` for details.
  - `"disabled_tooltip"` property, shows up on hover over disabled elements only.
  - Strings can now be sent as STRREF.
  - draw_list now supports BEFORE and AFTER (per-widget), so you can paint behind widgets too.
  - draw_list now supports rendering only on hover, mouse button down.
  - You can now "encourage" (= breathing inner glow) elements same as some native buttons. This should work with all widget types.
  - Added support for rendering image subregions (e.g. spritemaps).
  - Added bindable optional `"acceptsInput"` param to window constructor.
    - All interaction will fall through to the window or game scene beneath.
    - This also means the player cannot move, resize, or close the window.
  - Added a few more options for aligning windows:
    - Centering a window by setting the window x/y position to -1.0 can now be done per axis.
    - Setting the window x/y position to -2.0 will position the top left of the window at the mouse cursor's position.
    - Setting the window x/y position to -3.0 will center the window at the mouse cursor's position.
  - Added `tabbars`, which work exactly as option groups, including properties, except toggle buttons are rendered instead of radio buttons.

#### Toolset

  - Added support for using an external script editor to edit scripts (Options -> Script Editor -> External Script Editor).
  - Right clicking on a script in the pane to the left now provides the user with an option to build that script.
  - Added a few new module events to the Module Properties window:
    - OnPlayerTarget
    - OnPlayerGuiEvent
    - OnPlayerTileAction
    - OnNuiEvent
  - The Build Module option in the toolset now observes changes in temp0/ when compiling scripts.
  - Toolset no longer artificially restricts which item/body part ranges are available.

#### New config options

  - `graphics.experimental.generate-plt-with-shaders`
  - `graphics.fbo.dof.focus-type`
  - `graphics.fbo.run-shader-even-with-no-effects`
  - `graphics.fbo.toon.color-edge-threshold`
  - `graphics.fbo.toon.depth-edge-threshold`
  - `graphics.fbo.toon.edge-hardness`
  - `graphics.fbo.toon.enabled`
  - `graphics.keyholing.disables-camera-collisions`
  - `graphics.shadows.all-types-can-cast-dynamic`
  - `graphics.spell-targeting-effect.color.dangerous`
  - `graphics.spell-targeting-effect.color.harmful`
  - `graphics.spell-targeting-effect.color.helpful`
  - `graphics.spell-targeting-effect.color.other`
  - `graphics.spell-targeting-effect.enabled`
  - `server.player-party-control`
  - `server.show-player-join-messages`
  - `server.tweaks.game-obj-update-interval`
  - `server.tweaks.game-obj-update-interval-loading`
  - `server.tweaks.message-limit`
  - `server.tweaks.message-limit-loading`
  - `ui.confirm-self-cast-feats`
  - `ui.confirm-self-cast-items`
  - `ui.confirm-self-cast-spells`
  - `ui.hide-quick-chat-text-in-chat-window`
  - `ui.radial.class-abilities.always-show-as-subradial`
  - `ui.radial.spellcasting.always-show-as-subradial`

#### New `ruleset.2da` options

  - `DEATH_ATTACK_BASE_SAVE_DC`
  - `QUICKENED_SPELL_MINIMUM_CONJURE_TIME`
  - `HASTED_SPELL_CONJURE_TIME_MODIFIER`
  - `FIX_EFFECTDAMAGEINCREASE_BYPASSING_DR_AND_DI`
  - `TWO_HANDED_WEAPON_STRENGTH_MODIFIER`
  - `OFFHAND_WEAPON_STRENGTH_MODIFIER`
  - `HASTE_MOVEMENT_SPEED_INCREASE_BONUS`
  - `HASTE_DODGE_AC_INCREASE_AMOUNT`
  - `ALL_ASSOCIATES_RUN_SCRIPTS`
  - `MOVEMENT_SPEED_BONUS_DEFAULT_CAP`
  - `MOVEMENT_SPEED_BONUS_MONK_CAP`
  - `MOVEMENT_SPEED_PENALTY_CAP`
  - `MOVEMENT_STAGE_PENALTY_DETECT_MODE`
  - `MOVEMENT_STAGE_PENALTY_STEALTH_MODE`
  - `MOVEMENT_STAGE_PENALTY_ENCUMBRANCE_HEAVY`
  - `MOVEMENT_STAGE_PENALTY_ENCUMBRANCE_OVERLOADED`
  - `MAX_CHARGES_FOR_ITEM_COST`
  - `CHARGEN_ENABLE_RECOMMENDED_BUTTON`
  - `MULTICLASS_LIMIT`
  - `ALL_ASSOCIATES_CAN_INTERACT`

#### Enabled sqlite pragmas

  - `collation_list`
  - `compile_options`
  - `defer_foreign_keys`
  - `foreign_key_check`
  - `foreign_key_list`
  - `foreign_keys`
  - `freelist_count`
  - `function_list`
  - `index_info`
  - `index_list`
  - `index_xinfo`
  - `page_count`
  - `page_size`
  - `table_info`
  - `table_list`
  - `table_xinfo`

### Changed

- Gameplay:
  - Pressing 'H' to hide in-game GUI now also hides scriptable NUI windows.
  - NUI key down/up detection changed to not interfere with game.
  - NUI textedit(multiline=true) now auto-expands to available container height.
      - This is a breaking change for existing nui panels, but arguably better behaviour.
  - NUI textedit(multiline=true) now word wraps when reaching width limits.
  - Quickbar spells now show the name of the class they belong to, for when you have multiple spellcaster classes.
  - Disabled camera bumping into geometry when keyholing is enabled.
  - Restored pre-EE costs for items with charges. Use `MAX_CHARGES_FOR_ITEM_COST` `ruleset.2da` toggle to modify. (#483)
- Renderer:
  - Game now uses OpenGL 3.3.
  - Nicer looking waves on water.
  - Transparent surfaces are now also backlit.
  - Models of classification other than `character` only cast shadows if not transparent.
- Building and Scripting:
  - All SQL query/execution errors are now echoed to all players (like script VM errors).
  - All SQL transactions are now always rolled back when the parent script exits.
    - This means you cannot stagger a transaction across multiple `DelayCommands()`.
  - `SetUseableFlag()` now also works on Doors, Creatures and Items.
  - `GetItemAppearance()` now works with per-part colors.
  - `Get{First,Next}ObjectInArea()` now has a `nObjectFilter` parameter.
  - `SetName()` now works for player characters.
  - `SetObjectVisualTransform()` can now target sub-models (e.g. HEAD, WING, TAIL, CLOAK).
  - `SetObjectVisualTransform()` now has `nRepeatsRemaining` and `nBehaviorFlags` parameters.
  - `SetGuiPanelDisabled()` now has an `oTarget` parameter.
  - `GetPlayerDeviceProperty()` can now query most client config values.
  - `GetEffectInteger()` now works on the complete range of integers for `EffectDamage`.
  - `ActionUseFeat()` now allow subfeats to be used and locations to be targeted.
  - GUI events can now trigger on radial menu (`GUIEVENT_RADIAL_OPEN`).
  - Area transitions now allow targeting any tag. (#425)
    - Doors and waypoints are given priority over other objects of same tag.
  - Script Compiler: Now accepts string constants in case statements. See `HashString()` function in `nwscript.nss`.
  - Script Compiler: Increased max identifier count from 16384 to 65536.
  - Script Compiler: Increased max string constant size from 512 to 8192.
  - Script Compiler: Increased max include files from 128 to 512.
- Custom Content:
  - Increased NWSync single file max size from 15MB to 64MB.
  - Upped the body part and armor variations limit from 255 to 999 (higher may also work).
    - Older clients will default to part 0 if given a part greater than 255.
  - The shader postprocessing pass now runs always, even if no effects are enabled.
    - This allows modules to script their own post processing effects.
  - Game no longer requires `po_*_m.tga` file to be present to use DDS portraits.
  - Game will now fallback to closest available portrait size if one is missing.
  - Refined the debug rendering of tile path nodes.
  - "Log Model Errors" will now never truncate the log file.
  - "Log Model Errors" will now log all rejected/erroneous commands in ascii mdl files.
  - Improved handled of model vertex data, allowing for up to 3x more vertices per mesh.
  - Models with classification other than `Character` now all project shadows.
  - "Configure" option at chargen now uses the selected package to configure.
    - Removed the classes.2da to packages.2da matching line ID assumption.
  - Added a few more material rendering modes that can be set in MTR files:
    - `transparency 1`: Always render after opaque models, guarantees transparency.
    - `twosided 1`: renders both back- and front-facing vertices.
    - `sample_framebuffer 1/2`: renders near the end of the frame. Allows rendering refractions and similar.
    - `volumetric 1`: renders back-facing vertices to depth and renders with updated depth buffer sample texture before rendering front-facing.
- Miscellaneous:
  - 64bit linux platforms (x86 and ARM) now advertises as such, not 32bit.
  - Internal sqlite version updated to 3.39.0.
  - ContentIndex repositories (Community tab in New Game) now accept schemaless-URLs (e.g. `http://my-server.tld/repo` -> `my-server.tld/repo`) to make input easier.
  - CI Storage Manager now shows path in addition to hostname, to make identifying multihost content easier.
  - Made backing out of submenus in 'New Game' more intuitive.
- 2DA changes:
  - Added a row for base damage to `iprp_damagetype.2da` and `damagehitvisual.2da`.
    - This row is necessary to line up subsequent rows for custom damage types.
  - `iprp_damagetypes.2da` has been extended with a new column, `VisualFX` (index into `iprp_visualfx.2da`)
  - Added four new columns to `spells.2da` for spell targeting indicators: `TargetShape`, `TargetSizeX`, `TargetSizeY`, `Flags`
  - Added `HideFromLevelUp` column to `skills.2da`.
  - Added `SkipSpellSelection` column to `classes.2da`.
  - Added `FavoredEnemtyFeat` column to `racialtypes.2da`.


### Fixed

- Fixed a bug where factions went crazy when using a non-dm client created .bic file as DM character.
- Fixed nwsync download UI cutting off http errors.
- Fixed visual effects on placeables re-applying over and over. (#140)
- Fixed a human multiclass xp penalty bug. (#182)
- Fixed a crash when unloading `iprp_costtable.2da` if it had blank lines or missing 2das.
- Fixed empty sqlquery error messages in server log.
- Fixed the DM creature selection box not working when player-party-control is off. (#432)
- Fixed NWScript Debug UI not being able to run 16-character long script files.
- Fixed issue where combining damage types would sometimes result in magical damage type. (#106)
- Fixed a bug where effects of ReplaceObjectTexture() would be lost after a VFX like stoneskin is applied to the object.
- Fixed EffectDamage to preserve damage power when doing physical damage. (#265)
- Fixed an issue where framelimiter was also limiting the nwsync download speed.
- Fixed over twenty distinct memory leaks.
- Fixed `ReplaceObjectTexture()` removing the texture when given `sNewName=""` without previously having set a value.
- Fixed familiars sometimes failing to spawn.
- Fixed a crash when hovering over party members in other areas.
- Fixed a crash when portalling between servers on the DM client.
- Fixed 'a' nodes in models not always being rendered dynamic, causing transparency issues.
- Fixed bad displacement rendering at steep view angles.
- Fixed multiple issues when applying texture replacements to and from MTR files.
- Fixed crash when a shadow has more vertices than OGL driver reports as recommended max.
- Fixed a crash when getting a range from an empty json array in nwscript.
- Fixed the "Environment shadows" setting.
- Fixed camera collision not adjusting properly to keyhole toggle.
- Fixed vertex normals on grass. (#470)
- Fixed a crash that can happen when referencing an invalid class/skill/race, such as when adding DM cheat spells to the quickbar for a player DM.
- Fixed issue with custom materials for meshes without an existing base texture.
- Fixed several game crashes when loading broken CC (usually internal node/texture names too long).
- Fixed textures on body parts that don't use PLT. (#471)
- Fixed normal maps on HD pack heads. (#468)
- Fixed crash on joining a server if character sheet GUI panel is disabled.
- Fixed wielded items going out of sync with creature LOD models. (#431)
- Fixed Windows end lines causing the text edit cursor to display as a question mark when at the end of a line.
- Fixed blending issues when fading between skyboxes.
- Fixed emitter lightning update linked rendering (what was causing ray of frost and similar to not appear right). (#459)
- Fixed non-fading lights appearing with a delay because they were waiting for others to fade out. (#473, #445)
- Fixed creatures facing east when standing on `_POST` waypoints.
- Fixed effects incorrectly setting creator, caster level and spell ID.
- Fixed incorrect spell failure calculation from multiple `EffectSpellFailure()`.
- Fixed inconsistent application of temporary HP with `EffectNegativeLevel()`.
- Fixed stacking and cap of `EffectMovementSpeed{Increase,Decrease}()`.
- Fixed bad state when using `EffectRegenerate()` with negative values.
- Fixed floating dwarf head being summon when giving a bad resref to `EffectSummonMonster()`.
- Fixed applying spell failure to non-concentration spells (e.g. Barbarian Range) when under `EffectEntangle()`.
- Fixed `EffectDeaf()` to apply 20% spell failure to all verbal spells without Silent metamagic.
- Fixed monk bonus speed occasionally going above the 300% cap.
- Fixed not properly using cubemap environment maps if they are specified in the TXI.
- Fixed `net.udp.window.timeout` not being properly applied.
- Fixed being able to do melee attacks through doors that do not block sight.
- Fixed a crash related to models with no or corrupt faces.
- Fixed a crash caused by missing bone weights in model skinmeshes.
- Fixed journal entries not being retained after relogging on a server.
- Fixed beam VFXs being rendered too thin.
- NUI:
  - Fixed bad modifier array index being sent for watch events. (#448)
  - Fixed exception when reducing NUI scrolled list view contents. (#427)
  - Fixed NuiDrawListImage without NuiDrawListImageRegion not working.
  - Fixed NuiDrawListLine() not working.
  - Fixed carriage returns being rendered as question marks.
  - Fixed drawlist items not working correctly with gui scale.
    - Note: this may break any workarounds you have in place.

### Performance Improvements

- Optimized area load times significantly (up to 10000% faster!), particularly in singleplayer.
- Optimized default visual transformation handling: Reduced memory usage and network traffic for most serverside objects.
- Optimized JSON handling in nwscript VM. It is now copy-on-write, so read operations are much faster.
- Optimized stock shader performance.
- Optimized handling of vertex data for high poly meshes.
- Optimized how emitters are sorted.
- Optimized how minimap data is updated, which was causing performance issues on large PWs.
- Optimized VFX and creature perception list updates.
- Optimized `ruleset.2da` lookups when entry is not present.
- Minor optimizations when rendering grass and objects.

### Removed

- Disabled non-functional object preloading when entering an area: Reduces network traffic on load screens.
- Disabled non-functional FTS5 sqlite extension.
- Removed optional http ocsp toggle in config.
- Removed `io.mmap.*` options that were interfering with movie playback.

## [86.8193.34.1] - 2021-12-08

Greetings, Neverwinter Nights players and modders!

A new PC patch for Neverwinter Nights: Enhanced Edition arrives today. This update brings new quality of life improvements and fixes a few regressions introduced by the previous stable update.

### Fixes

- Apple M1: Fixed audio crackle when decoding mp3 files, including voiceovers.
- Pathfinding: Fixed a case where pathing was bailed on too early, resulting in incorrect behaviour that was regressed in the previous patch.
- Facelift tilesets tts02 tcm02: Addressed various texture and model issues.
- ResMan: Fixed two memleaks where it wouldn’t release loaded data instances.
- Renderer: Minor fixes to animation start consistency.
- Renderer: Fixed animated skinmesh parts going out of sync/being one frame behind.
- Renderer: Fixed rough surfaces having a milky sheen at some viewing aspects, especially when using height maps.

### QoL Improvements

- Game: Disable ctrl-drag selection box on clients when server.player-party-control is off (the default). Note that clients will have to reconnect if you toggle this setting while a game is up.
- NWSync: Repositories are now collapsible in the main UI view; this state is remembered in settings.tml.
- NWSync: Module versions can now hold a `localalias` field that is used to backreference for StartNewModule(“originalfilename”).
- NWSync: Better support for repository-side statistics.
- NWSync: Hide modules, campaigns and adverts with empty name labels.
- NWSync: Don’t reject repository.json if advert buttons have empty labels and URLs.
- Launch Game UI/Repo Manager: Fixed “Show Advert” checkbox label being cut off.
- Launch Game UI: Fixed “Advert” panel type displaying a STRREF instead of text when no label is defined in repository.json.

### Scriptable UI

- Nui: Fixed crash when calling SetGroupLayout() with invalid data.
- Nui: Fixed scrollbar size for textedit.
- Nui: Text can now override border and scrollbars properties.
- Nui: Fixed draw_list scissoring breaking succeeding widget rendering.
- Nui: Fixed draw_list scissoring leaving a stale scissor on the GL stack for nested widgets.
- Nui: Fixed entries in a list view not scissoring draw_list correctly when scrolling out of view.
- Nui: list(): Fixed textedit() widget not working in lists.
- Nui: list(): Scrollbars now configurable.
- Nui: list(): Fix spacers not advancing row layout correctly.
- Nui: Never allow binds to update during construction. This fixes list() array binds degrading to scalar values, among other.
- Nui: textedit(): Fixed placeholder sometimes rendering on the succeeding widget instead.
- Nui: textedit(): Fixed range event triggering too often or with wrong values.
- Nui: Added demo code for spreadsheet UI.
- Nui: Fixed “list” widget not showing a vertical scrollbar in AUTO mode.


### Premium Modules

- Tyrants of the Moonsea: Fixed ship's cabin navigation map occasionally disabling erroneously.

### New Script Commands

    // Returns the number of script instructions remaining for the currently-running script.
    // Once this value hits zero, the script will abort with TOO MANY INSTRUCTIONS.
    // The instruction limit is configurable by the user, so if you have a really long-running
    // process, this value can guide you with splitting it up into smaller, discretely schedulable parts.
    // Note: Running this command and checking/handling the value also takes up some instructions.
    int GetScriptInstructionsRemaining();

    // Returns a modified copy of jArray with the value order changed according to nTransform:
    // * JSON_ARRAY_SORT_ASCENDING, JSON_ARRAY_SORT_DESCENDING
    //    Sorting is dependent on the type and follows json standards (.e.g. 99 < "100").
    // * JSON_ARRAY_SHUFFLE
    //   Randomises the order of elements.
    // * JSON_ARRAY_REVERSE
    //   Reverses the array.
    // * JSON_ARRAY_UNIQUE
    //   Returns a modified copy of jArray with duplicate values removed.
    //   Coercable but different types are not considered equal (e.g. 99 != "99"); int/float equivalence however applies: 4.0 == 4.
    //   Order is preserved.
    // * JSON_ARRAY_COALESCE
    //   Returns the first non-null entry. Empty-ish values (e.g. "", 0) are not considered null, only the json scalar type.
    json JsonArrayTransform(json jArray, int nTransform);

    // Returns the nth-matching index or key of jNeedle in jHaystack.
    // Supported haystacks: object, array
    // Ordering behaviour for objects is unspecified.
    // Return null when not found or on any error.
    json JsonFind(json jHaystack, json jNeedle, int nNth = 0, int nConditional = JSON_FIND_EQUAL);

    // Returns a copy of the range (nBeginIndex, nEndIndex) inclusive of jArray.
    // Negative nEndIndex values count from the other end.
    // Out-of-bound values are clamped to the array range.
    // Examples:
    //  json a = JsonParse("[0, 1, 2, 3, 4]");
    //  JsonArrayGetRange(a, 0, 1)    // => [0, 1]
    //  JsonArrayGetRange(a, 1, -1)   // => [1, 2, 3, 4]
    //  JsonArrayGetRange(a, 0, 4)    // => [0, 1, 2, 3, 4]
    //  JsonArrayGetRange(a, 0, 999)  // => [0, 1, 2, 3, 4]
    //  JsonArrayGetRange(a, 1, 0)    // => []
    //  JsonArrayGetRange(a, 1, 1)    // => [1]
    // Returns a null type on error, including type mismatches.
    json JsonArrayGetRange(json jArray, int nBeginIndex, int nEndIndex);

    // Returns the result of a set operation on two arrays.
    // Operations:
    // * JSON_SET_SUBSET (v <= o):
    //   Returns true if every element in jValue is also in jOther.
    // * JSON_SET_UNION (v | o):
    //   Returns a new array containing values from both sides.
    // * JSON_SET_INTERSECT (v & o):
    //   Returns a new array containing only values common to both sides.
    // * JSON_SET_DIFFERENCE (v - o):
    //   Returns a new array containing only values not in jOther.
    // * JSON_SET_SYMMETRIC_DIFFERENCE (v ^ o):
    //   Returns a new array containing all elements present in either array, but not both.
    json JsonSetOp(json jValue, int nOp, json jOther);

    // Returns the column name of s2DA at nColumn index (starting at 0).
    // Returns "" if column nColumn doesn't exist (at end).
    string Get2DAColumn(string s2DA, int nColumnIdx);

    // Returns the number of defined rows in the 2da s2DA.
    int Get2DARowCount(string s2DA);

## [85.8193.33] - 2021-09-30

Greetings from the Neverwinter Nights team!

We're pushing Build 85.8193.33 to the live branch!

### Patch notes

- Fixed local multiplayer failing with error 110622
- Fixed a crash when some PLT textures failed to load
- Fixed area tile source lights showing up as red when they previously were off after a game save & load
- Fixed some pathfinding regressions where creatures had difficulties leaving corridors/rooms
- Fixed a crash in the GetPlayerDeviceProperty script call when passing in an invalid player object
- Updated Steam SDK to version 152. This should fix the Mac M1 build not running natively when launched from Steam
- Added a message box when the user directory fails to initialise (instead of crashing). This is most commonly caused by Antivirus preventing write access to the Documents directory

This will be the last stable patch in a while! We want to thank you all again for your continued feedback!

## [85.8193.32] - 2021-09-22

Greetings, Neverwinter Nights players and modders!

Today we're releasing Patch 8193.32 for Neverwinter Nights: Enhanced Edition! This update brings dozens of bug fixes and new features— including some exciting updates for content creators! Curated community content is also getting a new addition: A Hunt Through The Dark, by Markus Schlegel!

### Patch Highlights

- **Renderer** | Significant performance improvements & better shadows
- **New Curated Content** | Play as a drow in Markus Schlegel's campaign, A Hunt Through The Dark
- **Scriptable UI** | Module authors can now create custom UI panels!
- **Apple M1 support** | Owners of Apple M1 devices now will have a much better experience playing NWN:EE!
- **More than 100 fixes** | Many other new features, script commands & fixes

### Changes over build .31

This build is following the beta build from last week, and includes the following changes on top of it:

- Renderer: Fixed SetTextureOverride() not working for custom content.
- Nui/Scriptable UI: Fixed combo() widget not decoding UTF8 correctly.
- ResMan: Fixed RESTYPE_JUI having the wrong ID, and added to nwscript.nss.
- nwscript.nss: Minor text/documentation updates.

### Renderer Improvements

Many improvements have been made to the rendering and shadows engine:

- Greatly reduced the amount of CPU time spent on rendering shadows (50-90% less) by moving more work to the shaders and just doing things more intelligently.
- Reduced buffer transfers related to rendering shadows (perf+)
- Fixed some common shadow rendering issues related to "behind" stencil tests. It does not fix every issue, however, and in rare cases, some issues may become more apparent - but all in all, the benefits should outweigh the drawbacks. The old approach can be restored with using "shadowfliporder 1" in the console.
- Shadow and beam volumes now use their own unique shaders.
- Fixed a number of other shadow rendering issues by doing view frustrum clipping in the vertex shaders. This (beyond improving performance) alleviates issues with shadows sometimes being cut off in odd places (and similar).
- The game now uses tiledata bounding box to determine lower clip of shadow volumes. This fixes shadows not being applied to geometry below the z position of the tile.
- The game now adjusts shadow alpha based on the vertical distance between the shadow plane used for drawing projections and the projection source. This gives a more correct shading.
- Removed the "experimental optimized shadow rendering" toggle. It is now always enabled.
- Added some minor refinements that help reduce the visual oddities caused by shadows being projected by erroneous models.
- Fixed dynamic shadow rendering performance dropping significantly on certain devices due to the new streaming setup.
- Added new debug outputs that help content artists to debug models from within the game. This includes rendering mesh bounding boxes, pivots (centers), emitter and light ranges, as well as shadow volumes. The options are accessible through the normal debug panel (ctrl+shift+f12).
- Optimized generation of shadow volumes to better fit the size of the shadow plane used for rendering shadows. Improves performance in GPU limited situations.
- Fixed an issue that made shadows fade out too quickly at low view angles.
- Fixed an issue with the scene manager that made geometry culling less effective.
- Made the game automatically downsize textures larger than the client GPU supports (instead of just failing to render).
- Optimized the size of the baked font textures to minimize texture memory footprint.
- Tweaked the subsurface light algorithm and made the normal debug outputs also apply for water.
- Removed some redundant GPU data buffer uploads.
- Fixed soft particles reading the screen depth at an offset position, resulting in occasional halos appearing around objects.
- Fixed automatic tile texture rotation (`rotatetexture 1`) causing normal and displacement maps to malfunction.
- Added a new console command ‘printvertexdata'. Prints an overview of the amount of memory currently used for vertex data (model geometry) to the client log.
- Fixed rendering unlit models with envmap (chargen colour picker shader issue; Halaster model issue).
- Fixed object view culling not respecting visual transforms, resulting in objects sometimes not appearing if transformed into view.
- Fixed some static parts being removed after having been auto-combined, resulting in erroneous shadows for some static geometry.
- Fixed skinmesh bone hierarchy to initial model layout. This solves certain issues caused by skinmeshed bodyparts being dynamically attached and removed.
- Fixed low quality render mode darkening water too much.


### Curated Content: A Hunt Through The Dark

by Markus Schlegel

Presenting the classic six-part campaign by Markus Schlegel - A Hunt Through The Dark!

*Did you ever want to play the dark side, the bad, the evil, the worst of all, the drow?*
*Take part in a hunting trip through the Underdark. It is on you to enslave goblins, betray comrades and spoil the plans of your leader Mistress Piwiewien – or not.*

### Scriptable UI

Modules can now spawn custom UI panels, either defined in NWScript or JSON datafiles.

- The layouting is done via a constraints solver and currently presents as a row/layout flow.
- Most native widget types available, including lower-level drawing primitives to create your own.
- Data binding is two-way between clients and the module, and allows synchronising sliders, input fields, buttons, and window geometry/properties. Mouse input events are supported as well.
- There is a new include file: nw_inc_nui.nss. There is also a demo script (nw_nui_demo.nss) that showcases some basic widget types. Finally, there is a more complex inspector example (nw_nui_insp.nss) that can show bind values for all open scripted windows.
- See the mentioned include file and demo for starting points. The new nwscript.nss API is reproduced at the end of this document.

### NWScript JSON Datatype Support

NWScript now has a new native datatype, `json`. The API is documented at the end of these notes.

The engine can also serialise game objects to/from json, similar to how the sql data binder works. There is a new data format ".caf" for area objects that combines .are and .git, so you can de/serialise areas into a single json object. The serialisation format is compatible with neverwinter.nim.

There is a small helper library in nw_inc_gff.nss so you can construct GFF data on the fly (e.g. dynamic area/object creation and spawning).

The API also supports JSON Pointer, Diff, Patch and Merge. The SQLite API has been amended for both Campaign DB and custom databases.

### Other Features

- Added more GUI events, some suppressible, when the player interacts.
- Added device property queries to get player screen width height and scale.
- Added VM commands to query the game resource manager.
- PLT textures can now be phenotype-specific.
- Added a setting that allows players to control their non-PC party members in the same way as DMs do (drag, ctrl+click, etc). This is off by default, and can be enabled in server settings.
- Mac: Provided universal binary with a build for Apple M1. If you are on M1 and on Steam, you will have to launch the game directly, NOT via Steam, for the binary to run natively. Otherwise, it will run via Rosetta.
- Mac only: GOG Galaxy SDK no longer supported on x64 and arm64 (no native M1 build for the library).
- Mac only: Steam SDK/Workshop not supported on M1 (no native M1 build for the binary).
- Toolset: Added support for custom caster classes.
- Curated Content UI: Added support for promotion panels to show links to the Vault, Wikis, etc.

### Smaller Changes

- Script compiler now supports `\xFF` style escape sequences to put arbitrary bytes into a string literal. NB: \x00 will terminate the string, do not use.
- Cleaned up ovr/, moved everything except scripts into keybif.
- Debug UI: You can now use the RunScript/Chunk Debug UI in SP even when DebugMode is off (for testing convenience).
- VM: Store/RetrieveCampaignObject, SqlBindObject, SqlGetObject, ObjectToJson, and JsonToObject now support an additional parameter; bSave/LoadObjectState; which handles local variables, effects, action queue and transition info (for doors and triggers).
- Updated game credits for 2021, moved button out of OC Campaign to top level Movie menu.

### Fixes

- Game: Fixed savegames causing creatures in areas re-triggering the OnAreaEnter event. This was causing HotU chapter 3 to malfunction after saving and loading.
- Game: Fixed a rare crash when doors were melee-attacked by a null creature (PW-specific crash).
- Game: Fixed not storing fog clipping distance for areas when saving games.
- Game: Fixed a crash when showing a polymorphed creature on the party bar.
- Game: Fixed Steam Workshop modules not showing up if the .mod extension wasn't all lowercase.

- Toolset: Fixed inconsistencies with shadow rendering.
- Toolset: Fixed second story tile fade in "Always" mode not working correctly.
- Toolset: Areas are now considered modified when undo stack is changed
- Toolset: Undo now works for mouse wheel object scaling
- Toolset: Undo now works for Adjust Location dialog
- Toolset: Fixed a crash when right-clicking a tile with a recently-selected creature on it.
- Toolset: Fixed Replace All not working in backwards search mode.

- VM: Fixed crash in CreateArea() due to heap-use-after-free
- VM: Fixed a crash when SetResourceOverride was targeting a missing/invalid resource.
- VM: Fixed a memleak every time CopyObject, CreateObject or CreateArea was called.
- VM: Area serialisation: Do not save item state twice to GFF (this would needlessly duplicate temporary effects and local vars into savegames and serialised objects).

- Framelimiter: Opening up the radial menu is no longer considered background/modal.

- Nui: Fixed nuklear receiving input meant for the console.
- Nui: Fixed nuklear eating mouse clicks that should go to the radial menu instead.

### Tyrants of the Moonsea

- Prevented use of the map inside the navigation cabin after traveling to a destination.
- Covered some poor camera rotations when transitioning out of the sea map.
- Removed an xp exploit in Ulblyn's conversation.

### NWScript API Additions

    int GUIEVENT_COMPASS_CLICK                          = 15;
    int GUIEVENT_LEVELUP_CANCELLED                      = 16;
    int GUIEVENT_AREA_LOADSCREEN_FINISHED               = 17;
    int GUIEVENT_QUICKCHAT_ACTIVATE                     = 18;
    int GUIEVENT_QUICKCHAT_SELECT                       = 19;
    int GUIEVENT_QUICKCHAT_CLOSE                        = 20;
    int GUIEVENT_SELECT_CREATURE                        = 21;
    int GUIEVENT_UNSELECT_CREATURE                      = 22;
    int GUIEVENT_EXAMINE_OBJECT                         = 23;
    int GUIEVENT_OPTIONS_OPEN                           = 24;
    int GUIEVENT_OPTIONS_CLOSE                          = 25;

    int JSON_TYPE_NULL                                  = 0; // Also invalid
    int JSON_TYPE_OBJECT                                = 1;
    int JSON_TYPE_ARRAY                                 = 2;
    int JSON_TYPE_STRING                                = 3;
    int JSON_TYPE_INTEGER                               = 4;
    int JSON_TYPE_FLOAT                                 = 5;
    int JSON_TYPE_BOOL                                  = 6;

    // The player's gui width (inner window bounds).
    string PLAYER_DEVICE_PROPERTY_GUI_WIDTH             = "gui_width";
    // The player's gui height (inner window bounds).
    string PLAYER_DEVICE_PROPERTY_GUI_HEIGHT            = "gui_height";
    // The player's gui scale, in percent (factor 1.4 = 140)
    string PLAYER_DEVICE_PROPERTY_GUI_SCALE             = "gui_scale";

    int PLAYER_LANGUAGE_INVALID                         = -1;
    int PLAYER_LANGUAGE_ENGLISH                         = 0;
    int PLAYER_LANGUAGE_FRENCH                          = 1;
    int PLAYER_LANGUAGE_GERMAN                          = 2;
    int PLAYER_LANGUAGE_ITALIAN                         = 3;
    int PLAYER_LANGUAGE_SPANISH                         = 4;
    int PLAYER_LANGUAGE_POLISH                          = 5;

    int PLAYER_DEVICE_PLATFORM_INVALID                  = 0;
    int PLAYER_DEVICE_PLATFORM_WINDOWS_X86              = 1;
    int PLAYER_DEVICE_PLATFORM_WINDOWS_X64              = 2;
    int PLAYER_DEVICE_PLATFORM_LINUX_X86                = 10;
    int PLAYER_DEVICE_PLATFORM_LINUX_X64                = 11;
    int PLAYER_DEVICE_PLATFORM_LINUX_ARM32              = 12;
    int PLAYER_DEVICE_PLATFORM_LINUX_ARM64              = 13;
    int PLAYER_DEVICE_PLATFORM_MAC_X86                  = 20;
    int PLAYER_DEVICE_PLATFORM_MAC_X64                  = 21;
    int PLAYER_DEVICE_PLATFORM_IOS                      = 30;
    int PLAYER_DEVICE_PLATFORM_ANDROID_ARM32            = 40;
    int PLAYER_DEVICE_PLATFORM_ANDROID_ARM64            = 41;
    int PLAYER_DEVICE_PLATFORM_ANDROID_X64              = 42;
    int PLAYER_DEVICE_PLATFORM_NINTENDO_SWITCH          = 50;
    int PLAYER_DEVICE_PLATFORM_MICROSOFT_XBOXONE        = 60;
    int PLAYER_DEVICE_PLATFORM_SONY_PS4                 = 70;

    int RESTYPE_RES                                     = 0;
    ...
    int RESTYPE_CAF                                     = 2082;

    // Parse the given string as a valid json value, and returns the corresponding type.
    // Returns a JSON_TYPE_NULL on error.
    // Check JsonGetError() to see the parse error, if any.
    // NB: The parsed string needs to be in game-local encoding, but the generated json structure
    //     will contain UTF-8 data.
    json JsonParse(string sJson);

    // Dump the given json value into a string that can be read back in via JsonParse.
    // nIndent describes the indentation level for pretty-printing; a value of -1 means no indentation and no linebreaks.
    // Returns a string describing JSON_TYPE_NULL on error.
    // NB: The dumped string is in game-local encoding, with all non-ascii characters escaped.
    string JsonDump(json jValue, int nIndent = -1);

    // Describes the type of the given json value.
    // Returns JSON_TYPE_NULL if the value is empty.
    int JsonGetType(json jValue);

    // Returns the length of the given json type.
    // For objects, returns the number of top-level keys present.
    // For arrays, returns the number of elements.
    // Null types are of size 0.
    // All other types return 1.
    int JsonGetLength(json jValue);

    // Returns the error message if the value has errored out.
    // Currently only describes parse errors.
    string JsonGetError(json jValue);

    // Create a NULL json value, seeded with a optional error message for JsonGetError().
    json JsonNull(string sError = "");

    // Create a empty json object.
    json JsonObject();

    // Create a empty json array.
    json JsonArray();

    // Create a json string value.
    // NB: Strings are encoded to UTF-8 from the game-local charset.
    json JsonString(string sValue);

    // Create a json integer value.
    json JsonInt(int nValue);

    // Create a json floating point value.
    json JsonFloat(float fValue);

    // Create a json bool valye.
    json JsonBool(int bValue);

    // Returns a string representation of the json value.
    // Returns "" if the value cannot be represented as a string, or is empty.
    // NB: Strings are decoded from UTF-8 to the game-local charset.
    string JsonGetString(json jValue);

    // Returns a int representation of the json value, casting where possible.
    // Returns 0 if the value cannot be represented as a float.
    // Use this to parse json bool types.
    // NB: This will narrow down to signed 32 bit, as that is what NWScript int is.
    //     If you are trying to read a 64 bit or unsigned integer, you will lose data.
    //     You will not lose data if you keep the value as a json element (via Object/ArrayGet).
    int JsonGetInt(json jValue);

    // Returns a float representation of the json value, casting where possible.
    // Returns 0.0 if the value cannot be represented as a float.
    // NB: This will narrow doubles down to float.
    //     If you are trying to read a double, you will lose data.
    //     You will not lose data if you keep the value as a json element (via Object/ArrayGet).
    float JsonGetFloat(json jValue);

    // Returns a json array containing all keys of jObject.
    // Returns a empty array if the object is empty or not a json object, with GetJsonError() filled in.
    json JsonObjectKeys(json jObject);

    // Returns the key value of sKey on the object jObect.
    // Returns a null json value if jObject is not a object or sKey does not exist on the object, with GetJsonError() filled in.
    json JsonObjectGet(json jObject, string sKey);

    // Returns a modified copy of jObject with the key at sKey set to jValue.
    // Returns a json null value if jObject is not a object, with GetJsonError() filled in.
    json JsonObjectSet(json jObject, string sKey, json jValue);

    // Returns a modified copy of jObject with the key at sKey deleted.
    // Returns a json null value if jObject is not a object, with GetJsonError() filled in.
    json JsonObjectDel(json jObject, string sKey);

    // Gets the json object at jArray index position nIndex.
    // Returns a json null value if the index is out of bounds, with GetJsonError() filled in.
    json JsonArrayGet(json jArray, int nIndex);

    // Returns a modified copy of jArray with position nIndex set to jValue.
    // Returns a json null value if jArray is not actually an array, with GetJsonError() filled in.
    // Returns a json null value if nIndex is out of bounds, with GetJsonError() filled in.
    json JsonArraySet(json jArray, int nIndex, json jValue);

    // Returns a modified copy of jArray with jValue inserted at position nIndex.
    // All succeeding objects in the array will move by one.
    // By default (-1), inserts objects at the end of the array ("push").
    // nIndex = 0 inserts at the beginning of the array.
    // Returns a json null value if jArray is not actually an array, with GetJsonError() filled in.
    // Returns a json null value if nIndex is not 0 or -1 and out of bounds, with GetJsonError() filled in.
    json JsonArrayInsert(json jArray, json jValue, int nIndex = -1);

    // Returns a modified copy of jArray with the element at position nIndex removed,
    // and the array resized by one.
    // Returns a json null value if jArray is not actually an array, with GetJsonError() filled in.
    // Returns a json null value if nIndex is out of bounds, with GetJsonError() filled in.
    json JsonArrayDel(json jArray, int nIndex);

    // Transforms the given object into a json structure.
    // The json format is compatible with what https://github.com/niv/neverwinter.nim@1.4.3+ emits.
    // Returns the null json type on errors, or if oObject is not serializable, with GetJsonError() filled in.
    // Supported object types: creature, item, trigger, placeable, door, waypoint, encounter, store, area (combined format)
    // If bSaveObjectState is TRUE, local vars, effects, action queue, and transition info (triggers, doors) are saved out
    // (except for Combined Area Format, which always has object state saved out).
    json ObjectToJson(object oObject, int bSaveObjectState = FALSE);

    // Deserializes the game object described in jObject.
    // Returns OBJECT_INVALID on errors.
    // Supported object types: creature, item, trigger, placeable, door, waypoint, encounter, store, area (combined format)
    // For areas, locLocation is ignored.
    // If bLoadObjectState is TRUE, local vars, effects, action queue, and transition info (triggers, doors) are read in.
    object JsonToObject(json jObject, location locLocation, object oOwner = OBJECT_INVALID, int bLoadObjectState = FALSE);

    // Returns the element at the given JSON pointer value.
    // See https://datatracker.ietf.org/doc/html/rfc6901 for details.
    // Returns a json null value on error, with GetJsonError() filled in.
    json JsonPointer(json jData, string sPointer);

    // Return a modified copy of jData with jValue inserted at the path described by sPointer.
    // See https://datatracker.ietf.org/doc/html/rfc6901 for details.
    // Returns a json null value on error, with GetJsonError() filled in.
    // jPatch is an array of patch elements, each containing a op, a path, and a value field. Example:
    // [
    //   { "op": "replace", "path": "/baz", "value": "boo" },
    //   { "op": "add", "path": "/hello", "value": ["world"] },
    //   { "op": "remove", "path": "/foo"}
    // ]
    // Valid operations are: add, remove, replace, move, copy, test
    json JsonPatch(json jData, json jPatch);

    // Returns the diff (described as a json structure you can pass into JsonPatch) between the two objects.
    // Returns a json null value on error, with GetJsonError() filled in.
    json JsonDiff(json jLHS, json jRHS);

    // Returns a modified copy of jData with jMerge merged into it. This is an alternative to
    // JsonPatch/JsonDiff, with a syntax more closely resembling the final object.
    // See https://datatracker.ietf.org/doc/html/rfc7386 for details.
    // Returns a json null value on error, with GetJsonError() filled in.
    json JsonMerge(json jData, json jMerge);

    // Get oObject's local json variable sVarName
    // * Return value on error: json null type
    json GetLocalJson(object oObject, string sVarName);

    // Set oObject's local json variable sVarName to jValue
    void SetLocalJson(object oObject, string sVarName, json jValue);

    // Delete oObject's local json variable sVarName
    void DeleteLocalJson(object oObject, string sVarName);

    // Bind an json to a named parameter of the given prepared query.
    // Json values are serialised into a string.
    // Example:
    //   sqlquery v = SqlPrepareQueryObject(GetModule(), "insert into test (col) values (@myjson);");
    //   SqlBindJson(v, "@myjson", myJsonObject);
    //   SqlStep(v);
    void SqlBindJson(sqlquery sqlQuery, string sParam, json jValue);

    // Retrieve a column cast as a json value of the currently stepped row.
    // You can call this after SqlStep() returned TRUE.
    // In case of error, a json null value will be returned.
    // In traditional fashion, nIndex starts at 0.
    json SqlGetJson(sqlquery sqlQuery, int nIndex);

    // This stores a json out to the specified campaign database
    // The database name:
    //  - is case insensitive and it must be the same for both set and get functions.
    //  - can only contain alphanumeric characters, no spaces.
    // The var name must be unique across the entire database, regardless of the variable type.
    // If you want a variable to pertain to a specific player in the game, provide a player object.
    void SetCampaignJson(string sCampaignName, string sVarName, json jValue, object oPlayer=OBJECT_INVALID);

    // This will read a json from the  specified campaign database
    // The database name:
    //  - is case insensitive and it must be the same for both set and get functions.
    //  - can only contain alphanumeric characters, no spaces.
    // The var name must be unique across the entire database, regardless of the variable type.
    // If you want a variable to pertain to a specific player in the game, provide a player object.
    json GetCampaignJson(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID);

    // Gets a device property/capability as advertised by the client.
    // sProperty is one of PLAYER_DEVICE_PROPERTY_xxx.
    // Returns -1 if
    // - the property was never set by the client,
    // - the the actual value is -1,
    // - the player is running a older build that does not advertise device properties,
    // - the player has disabled sending device properties (Options->Game->Privacy).
    int GetPlayerDeviceProperty(object oPlayer, string sProperty);

    // Returns the LANGUAGE_xx code of the given player, or -1 if unavailable.
    int GetPlayerLanguage(object oPlayer);

    // Returns one of PLAYER_DEVICE_PLATFORM_xxx, or 0 if unavailable.
    int GetPlayerDevicePlatform(object oPlayer);

    // Deserializes the given resref/template into a JSON structure.
    // Supported GFF resource types:
    // * RESTYPE_CAF (and RESTYPE_ARE, RESTYPE_GIT, RESTYPE_GIC)
    // * RESTYPE_UTC
    // * RESTYPE_UTI
    // * RESTYPE_UTT
    // * RESTYPE_UTP
    // * RESTYPE_UTD
    // * RESTYPE_UTW
    // * RESTYPE_UTE
    // * RESTYPE_UTM
    // Returns a valid gff-type json structure, or a null value with GetJsonError() set.
    json TemplateToJson(string sResRef, int nResType);

    // Returns the resource location of sResRef.nResType, as seen by the running module.
    // Note for dedicated servers: Checks on the module/server side, not the client.
    // Returns "" if the resource does not exist in the search space.
    string ResManGetAliasFor(string sResRef, int nResType);

    // Finds the nNth available resref starting with sPrefix.
    // * Set bSearchBaseData to TRUE to also search base game content stored in your game installation directory.
    //   WARNING: This can be very slow.
    // * Set sOnlyKeyTable to a specific keytable to only search the given named keytable (e.g. "OVERRIDE:").
    // Returns "" if no such resref exists.
    string ResManFindPrefix(string sPrefix, int nResType, int nNth = 1, int bSearchBaseData = FALSE, string sOnlyKeyTable = "");

    // Create a NUI window from the given resref(.jui) for the given player.
    // * The resref needs to be available on the client, not the server.
    // * The token is a integer for ease of handling only. You are not supposed to do anything with it, except store/pass it.
    // * The window ID needs to be alphanumeric and short. Only one window (per client) with the same ID can exist at a time.
    //   Re-creating a window with the same id of one already open will immediately close the old one.
    // * See nw_inc_nui.nss for full documentation.
    // Returns the window token on success (>0), or 0 on error.
    int NuiCreateFromResRef(object oPlayer, string sResRef, string sWindowId = "");

    // Create a NUI window inline for the given player.
    // * The token is a integer for ease of handling only. You are not supposed to do anything with it, except store/pass it.
    // * The window ID needs to be alphanumeric and short. Only one window (per client) with the same ID can exist at a time.
    //   Re-creating a window with the same id of one already open will immediately close the old one.
    // * See nw_inc_nui.nss for full documentation.
    // Returns the window token on success (>0), or 0 on error.
    int NuiCreate(object oPlayer, json jNui, string sWindowId = "");

    // You can look up windows by ID, if you gave them one.
    // * Windows with a ID present are singletons - attempting to open a second one with the same ID
    //   will fail, even if the json definition is different.
    // Returns the token if found, or 0.
    int NuiFindWindow(object oPlayer, string sId);

    // Destroys the given window, by token, immediately closing it on the client.
    // Does nothing if nUiToken does not exist on the client.
    // Does not send a close event - this immediately destroys all serverside state.
    // The client will close the window asynchronously.
    void NuiDestroy(object oPlayer, int nUiToken);

    // Returns the originating player of the current event.
    object NuiGetEventPlayer();

    // Gets the window token of the current event (or 0 if not in a event).
    int NuiGetEventWindow();

    // Returns the event type of the current event.
    // * See nw_inc_nui.nss for full documentation of all events.
    string NuiGetEventType();

    // Returns the ID of the widget that triggered the event.
    string NuiGetEventElement();

    // Get the array index of the current event.
    // This can be used to get the index into an array, for example when rendering lists of buttons.
    // Returns -1 if the event is not originating from within an array.
    int NuiGetEventArrayIndex();

    // Returns the window ID of the window described by nUiToken.
    // Returns "" on error, or if the window has no ID.
    string NuiGetWindowId(object oPlayer, int nUiToken);

    // Gets the json value for the given player, token and bind.
    // * json values can hold all kinds of values; but NUI widgets require specific bind types.
    //   It is up to you to either handle this in NWScript, or just set compatible bind types.
    //   No auto-conversion happens.
    // Returns a json null value if the bind does not exist.
    json NuiGetBind(object oPlayer, int nUiToken, string sBindName);

    // Sets a json value for the given player, token and bind.
    // The value is synced down to the client and can be used in UI binding.
    // When the UI changes the value, it is returned to the server and can be retrieved via NuiGetBind().
    // * json values can hold all kinds of values; but NUI widgets require specific bind types.
    //   It is up to you to either handle this in NWScript, or just set compatible bind types.
    //   No auto-conversion happens.
    // * If the bind is on the watch list, this will immediately invoke the event handler with the "watch"
    //   even type; even before this function returns. Do not update watched binds from within the watch handler
    //   unless you enjoy stack overflows.
    // Does nothing if the given player+token is invalid.
    void NuiSetBind(object oPlayer, int nUiToken, string sBindName, json jValue);

    // Swaps out the given element (by id) with the given nui layout (partial).
    // * This currently only works with the "group" element type, and the special "_window_" root group.
    void NuiSetGroupLayout(object oPlayer, int nUiToken, string sElement, json jNui);

    // Mark the given bind name as watched.
    // A watched bind will invoke the NUI script event every time it's value changes.
    // Be careful with binding nui data inside a watch event handler: It's easy to accidentally recurse yourself into a stack overflow.
    int NuiSetBindWatch(object oPlayer, int nUiToken, string sBind, int bWatch);

    // Returns the nNth window token of the player, or 0.
    // nNth starts at 0.
    // Iterator is not write-safe: Calling DestroyWindow() will invalidate move following offsets by one.
    int NuiGetNthWindow(object oPlayer, int nNth = 0);

    // Return the nNth bind name of the given window, or "".
    // If bWatched is TRUE, iterates only watched binds.
    // If FALSE, iterates all known binds on the window (either set locally or in UI).
    string NuiGetNthBind(object oPlayer, int nToken, int bWatched, int nNth = 0);

    // Returns the event payload, specific to the event.
    // Returns JsonNull if event has no payload.
    json NuiGetEventPayload();

    // Get the userdata of the given window token.
    // Returns JsonNull if the window does not exist on the given player, or has no userdata set.
    json NuiGetUserData(object oPlayer, int nToken);

    // Sets an arbitrary json value as userdata on the given window token.
    // This userdata is not read or handled by the game engine and not sent to clients.
    // This mechanism only exists as a convenience for the programmer to store data bound to a windows' lifecycle.
    // Will do nothing if the window does not exist.
    void NuiSetUserData(object oPlayer, int nToken, json jUserData);
