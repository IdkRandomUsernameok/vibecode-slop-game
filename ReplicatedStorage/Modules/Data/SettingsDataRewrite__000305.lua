-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = ReplicatedStorage:WaitForChild("Modules");
require(Modules.UI.SettingsV2);
local Dirs = require(Modules.Engine.VSRG.ManiaData.Dirs);
local DataManager = require(Modules.Data.DataManager);
local PlayerRanks = require(Modules.Other.PlayerRanks);
local VolumeManager = require(Modules.Audio.VolumeManager);
local BloxstrapRPC = require(Modules.Engine.BloxstrapRPC);
local Events = ReplicatedStorage:WaitForChild("Events");
local LocalData = DataManager:GetLocalData();
local v21 = {
    Name = "Sounds",
    Icon = "rbxassetid://16360659285",
    Items = {
        {
            Name = "Volume",
            Items = {
                {
                    Index = "GlobalVolume",
                    Type = "Slider",
                    DisplayName = "Main Volume",
                    Description = "Controls the overall volume of the game.\n\nActs as a multiplier for every other volume group below.",
                    TypeMeta = {
                        Min = 0,
                        Max = 150,
                        Round = 0,

                        FormatInput = function(p1) -- Line: 351, Name: FormatInput
                            return p1 .. "%";
                        end,

                        GetValue = function(p2) -- Line: 355, Name: GetValue
                            return p2 * 10;
                        end,

                        SetValue = function(p3) -- Line: 358, Name: SetValue
                            return p3 / 10;
                        end,

                        OnVisualUpdate = function(p4) -- Line: 362, Name: OnVisualUpdate
                            -- upvalues: VolumeManager (copy)
                            VolumeManager:SetGroupVolume("Main", p4 / 10);
                        end
                    }
                },
                {
                    Index = "GameplayVolume",
                    Type = "Slider",
                    DisplayName = "Gameplay Volume",
                    Description = "Controls the volume of the song playing during gameplay.",
                    TypeMeta = {
                        Min = 0,
                        Max = 150,
                        Round = 0,

                        FormatInput = function(p5) -- Line: 378, Name: FormatInput
                            return p5 .. "%";
                        end,

                        GetValue = function(p6) -- Line: 382, Name: GetValue
                            return p6 * 10;
                        end,

                        SetValue = function(p7) -- Line: 385, Name: SetValue
                            return p7 / 10;
                        end,

                        OnVisualUpdate = function(p8) -- Line: 389, Name: OnVisualUpdate
                            -- upvalues: VolumeManager (copy)
                            VolumeManager:SetGroupVolume("Gameplay", p8 / 10);
                        end
                    }
                },
                {
                    Index = "SFXVolume",
                    Type = "Slider",
                    DisplayName = "SFX Volume",
                    Description = "Controls the volume of sound effects.",
                    TypeMeta = {
                        Min = 0,
                        Max = 150,
                        Round = 0,

                        FormatInput = function(p9) -- Line: 405, Name: FormatInput
                            return p9 .. "%";
                        end,

                        GetValue = function(p10) -- Line: 409, Name: GetValue
                            return p10 * 10;
                        end,

                        SetValue = function(p11) -- Line: 412, Name: SetValue
                            return p11 / 10;
                        end,

                        OnVisualUpdate = function(p12) -- Line: 416, Name: OnVisualUpdate
                            -- upvalues: VolumeManager (copy)
                            VolumeManager:SetGroupVolume("SFX", p12 / 10);
                        end
                    }
                },
                {
                    Index = "UIVolume",
                    Type = "Slider",
                    DisplayName = "UI Volume",
                    Description = "Controls the volume of music in menus like the Shop and Settings.",
                    TypeMeta = {
                        Min = 0,
                        Max = 150,
                        Round = 0,

                        FormatInput = function(p13) -- Line: 432, Name: FormatInput
                            return p13 .. "%";
                        end,

                        GetValue = function(p14) -- Line: 436, Name: GetValue
                            return p14 * 10;
                        end,

                        SetValue = function(p15) -- Line: 439, Name: SetValue
                            return p15 / 10;
                        end,

                        OnVisualUpdate = function(p16) -- Line: 443, Name: OnVisualUpdate
                            -- upvalues: VolumeManager (copy)
                            VolumeManager:SetGroupVolume("UI", p16 / 10);
                        end
                    }
                },
                {
                    Index = "StageVolume",
                    Type = "Slider",
                    DisplayName = "Spectating Volume",
                    Description = "Controls the volume of audio coming from stages elsewhere on the map, like other songs or emotes.",
                    TypeMeta = {
                        Min = 0,
                        Max = 150,
                        Round = 0,

                        FormatInput = function(p17) -- Line: 459, Name: FormatInput
                            return p17 .. "%";
                        end,

                        GetValue = function(p18) -- Line: 463, Name: GetValue
                            return p18 * 10;
                        end,

                        SetValue = function(p19) -- Line: 466, Name: SetValue
                            return p19 / 10;
                        end,

                        OnVisualUpdate = function(p20) -- Line: 470, Name: OnVisualUpdate
                            -- upvalues: VolumeManager (copy)
                            VolumeManager:SetGroupVolume("Stages", p20 / 10);
                        end
                    }
                },
                {
                    Index = "UseVolumeSlider",
                    Type = "Bool",
                    DisplayName = "Volume Keybind Adjustment",
                    Description = "Lets the Volume Up and Volume Down keybinds nudge your main volume by 10%."
                }
            }
        },
        {
            Name = "Music",
            Items = {
                {
                    Index = "SongSelectMusic",
                    Type = "Bool",
                    DisplayName = "Play Music in Song Select",
                    Description = "Plays background music while you\'re browsing the song select menu."
                },
                {
                    Index = "SongSelectPreviewMusic",
                    Type = "Bool",
                    DisplayName = "Play Song Previews in Song Select",
                    Description = "Plays a short preview of whichever song is selected in the song select menu."
                },
                {
                    Index = "ShopMusic",
                    Type = "Bool",
                    DisplayName = "Play Music in Shop",
                    Description = "Plays background music while you\'re browsing the Shop."
                },
                {
                    Index = "SettingsMusic",
                    Type = "Bool",
                    DisplayName = "Play Music in Settings",
                    Description = "Plays background music while you\'re in the Settings menu."
                },
                {
                    Index = "RatingEditorMusic",
                    Type = "Bool",
                    DisplayName = "Play Music in Rating Editor",
                    Description = "Plays background music while you\'re adjusting your rating positions."
                },
                {
                    Index = "WaitingForPlayerMusic",
                    Type = "Bool",
                    DisplayName = "Play Music in Waiting",
                    Description = "Plays background music while you\'re queuing up for a match."
                }
            }
        },
        {
            Name = "Hit Sounds",
            Items = {
                {
                    Index = "HitSounds",
                    Type = "Bool",
                    DisplayName = "Hit Sounds",
                    Description = "Plays a sound every time you hit a note."
                },
                {
                    Index = "HitSoundID",
                    Type = "Asset",
                    Description = "Sets the sound used for the hit sound.",
                    DisplayName = "Hit Sound ID",
                    TypeMeta = {
                        AssetType = Enum.AssetType.Audio
                    }
                },
                {
                    Index = "HitSoundVolume",
                    Type = "Number",
                    DisplayName = "Hit Sound Volume",
                    Description = "Controls the hit sound\'s volume, as a percentage.",
                    TypeMeta = {
                        Min = 0.25,
                        Max = 2,
                        Round = 2
                    }
                },
                {
                    Index = "PlayHitsoundOnGhosttap",
                    Type = "Bool",
                    DisplayName = "Play Hit Sounds on Ghost Tap",
                    Description = "Plays the hit sound when you press a key with no note there, like in osu! or Quaver."
                }
            }
        },
        {
            Name = "Miss Sounds",
            Items = {
                {
                    Index = "MissSounds",
                    Type = "Bool",
                    DisplayName = "Miss Sounds",
                    Description = "Plays a sound every time you miss a note."
                },
                {
                    Index = "MissSoundID",
                    Type = "Asset",
                    DisplayName = "Miss Sound ID",
                    Description = "Sets the sound used when you miss a note.",
                    TypeMeta = {
                        AssetType = Enum.AssetType.Audio
                    }
                },
                {
                    Index = "MissSoundVolume",
                    Type = "Number",
                    DisplayName = "Miss Sound Volume",
                    Description = "Controls the miss sound\'s volume, as a percentage.",
                    TypeMeta = {
                        Min = 0.25,
                        Max = 2,
                        Round = 2
                    }
                }
            }
        }
    }
};
local v22 = {
    Left = { "Left", "rbxassetid://8516202812" },
    Down = { "Down", "rbxassetid://8516202817" },
    Up = { "Up", "rbxassetid://8516202814" },
    Right = { "Right", "rbxassetid://8516202809" },
    Square = { "Square", "rbxassetid://8516202821" },
    Left2 = { "Left (R)", "rbxassetid://8516202812" },
    Down2 = { "Down (R)", "rbxassetid://8516202817" },
    Up2 = { "Up (R)", "rbxassetid://8516202814" },
    Right2 = { "Right (R)", "rbxassetid://8516202809" },
    rLeft = { "Left (Boosts)", "rbxassetid://8516202821" },
    rDown = { "Down (Boosts)", "rbxassetid://8516202821" },
    rUp = { "Up (Boosts)", "rbxassetid://8516202821" },
    rRight = { "Right (Boosts)", "rbxassetid://8516202821" },
    Plus = { "Plus", "rbxassetid://8516202821" },
    rLeft2 = { "Left (Boosts Alt)", "rbxassetid://8516202821" },
    rDown2 = { "Down (Boosts Alt)", "rbxassetid://8516202821" },
    rUp2 = { "Up (Boosts Alt)", "rbxassetid://8516202821" },
    rRight2 = { "Right (Boosts Alt)", "rbxassetid://8516202821" }
};
local v23 = {
    Name = "Keybinds",
    Icon = "rbxassetid://16360658907",
    IndexPrefix = "Keybinds",
    ControllerIndexPrefix = "ConsoleKeybinds",
    Items = {
        {
            Name = "Extras",
            IndexPrefix = "+/Extra",
            Items = { {
                    Index = "+/Dodge",
                    Type = "Keybind",
                    DisplayName = "Dodge",
                    Description = "Dodges an attack during song events that call for it.",
                    TypeMeta = {
                        KeybindsAllowed = 2
                    }
                }, {
                    Index = "+/Attack",
                    Type = "Keybind",
                    DisplayName = "Attack",
                    Description = "Attacks the opponent during song events that call for it.",
                    TypeMeta = {
                        KeybindsAllowed = 2
                    }
                } }
        },
        {
            Name = "Miscellaneous",
            IndexPrefix = "+/Miscellaneous",
            Items = {
                {
                    Index = "+/VolumeDown",
                    Type = "Keybind",
                    DisplayName = "Volume Down",
                    Description = "Turns the game\'s volume down a bit.\n\nOnly works while <i>Volume Keybind Adjustment</i> is on."
                },
                {
                    Index = "+/VolumeUp",
                    Type = "Keybind",
                    DisplayName = "Volume Up",
                    Description = "Turns the game\'s volume up a bit.\n\nOnly works while <i>Volume Keybind Adjustment</i> is on."
                },
                {
                    Index = "+/ChatKeybind",
                    Type = "Keybind",
                    DisplayName = "Chat Keybind",
                    Description = "Opens the chat input bar."
                },
                {
                    Index = "+/TauntKeybind",
                    Type = "Keybind",
                    DisplayName = "Taunt",
                    Description = "Plays the \"Hey!\" taunt animation mid-song."
                },
                {
                    Index = "+/AltSwitch",
                    Type = "Keybind",
                    DisplayName = "Alt Animation Switch",
                    Description = "Switches to a character\'s alternate singing animations mid-song, for the ones that have them."
                },
                {
                    Index = "+/LeaderboardKeybind",
                    Type = "Keybind",
                    DisplayName = "Leaderboard Toggle Keybind",
                    Description = "Toggles the leaderboard on or off."
                },
                {
                    Index = "+/Sprint",
                    Type = "Keybind",
                    DisplayName = "Sprint Keybind",
                    Description = "Makes you run faster while it\'s held down."
                },
                {
                    Index = "+/AdminKeybind",
                    Type = "Keybind",
                    DisplayName = "Admin Panel Keybind",
                    Description = "Opens the admin command panel.\n\nAdmin commands only work in private servers."
                }
            }
        }
    }
};
local v25 = {
    Name = "Gameplay",
    Icon = "rbxassetid://16360658571",
    Items = {
        {
            Name = "Strumlines",
            Items = {
                {
                    Index = "Downscroll",
                    Type = "Bool",
                    DisplayName = "Downscroll",
                    Description = "Moves the strumline to the bottom of the screen, so notes scroll down toward it instead of up."
                },
                {
                    Index = "Middlescroll",
                    Type = "Bool",
                    DisplayName = "Middlescroll",
                    Description = "Moves the strumline to the center of the screen."
                },
                {
                    Index = "ShowOpponentOnMiddlescroll",
                    Type = "Bool",
                    DisplayName = "Show Opponent\'s Notes on Middlescroll",
                    Description = "Splits the opponent\'s strumline to the sides of the screen instead of hiding it.\n\nOnly does anything while <i><b>Middlescroll</b></i> is on."
                },
                {
                    Index = "LaneHeight",
                    Type = "Number",
                    DisplayName = "Note Height Offset",
                    Description = "Moves the strumline up or down, in pixels.\n\nExample: 180px is about 25% of the screen.",
                    TypeMeta = {
                        Min = -1000,
                        Max = 1000
                    }
                },
                {
                    Index = "LaneGap",
                    Type = "Number",
                    DisplayName = "Note Gap Offset",
                    Description = "Spaces the strumline\'s lanes apart, in pixels.\n\nExample: 320px is about 25% of the screen width.",
                    TypeMeta = {
                        Min = -100,
                        Max = 500
                    }
                }
            }
        },
        {
            Name = "Note Speed",
            Items = {
                {
                    Index = "ForceScrollSpeed",
                    Type = "Bool",
                    DisplayName = "Custom Scroll Speed",
                    Description = "Uses a fixed scroll speed instead of scaling with each song\'s own speed.\n\nWith this off, the <b>Scroll Speed</b> value below acts as a multiplier on a song\'s base speed instead of replacing it outright."
                },
                {
                    Index = "ScrollSpeed",
                    Type = "Number",
                    DisplayName = "Scroll Speed",
                    Description = "How fast notes travel down to the strums.\n\nActs as a multiplier for a song\'s base speed unless <i>Custom Scroll Speed</i> is on, in which case it\'s used directly.",
                    TypeMeta = {
                        Min = 0.5,
                        Max = 10,
                        Round = 2,

                        FormatInput = function(p24) -- Line: 173, Name: FormatInput
                            -- upvalues: LocalData (copy)
                            if LocalData.ForceScrollSpeed then
                                return p24;
                            end;

                            return p24 .. "x";
                        end
                    },
                    ListeningUpdates = { "ForceScrollSpeed" }
                },
                {
                    Index = "SVChanges",
                    Type = "Bool",
                    DisplayName = "Allow Scroll Speed Changes",
                    Description = "Lets songs use scroll speed or velocity changes mid-song.\n\nTurning this off strips those changes out entirely, so notes scroll at a constant speed."
                }
            }
        },
        {
            Name = "Death Mode",
            Items = { {
                    Index = "DieOnHealthLoss",
                    Type = "Bool",
                    Description = "Ends the song right away if your health hits zero during a solo song.",
                    DisplayName = "Die on 0 Health"
                }, {
                    Index = "ShowDeathWarning",
                    Type = "Bool",
                    Description = "Shows an on-screen warning when your health hits zero.\n\nOnly shows up if <i>Die on 0 Health</i> is also on.",
                    DisplayName = "Show Death Warning"
                } }
        },
        {
            Name = "Health Multipliers",
            Items = { {
                    Index = "HealthGainMultiplier",
                    Type = "Number",
                    Description = "Scales how much health you get back for hitting notes well.",
                    DisplayName = "Health Gain Multiplier",
                    TypeMeta = {
                        Min = 0,
                        Max = 5,
                        Round = 1
                    }
                }, {
                    Index = "HealthLossMultiplier",
                    Type = "Number",
                    Description = "Scales how much health you lose from missed or poorly hit notes.",
                    DisplayName = "Health Loss Multiplier",
                    TypeMeta = {
                        Min = 0.1,
                        Max = 5,
                        Round = 1
                    }
                } }
        },
        {
            Name = "HP Drain",
            Items = { {
                    Index = "HealthDrain",
                    Type = "Bool",
                    Description = "Slowly drains your health whenever the opponent hits a note.",
                    DisplayName = "Health Drain on Opponent Note Hit"
                }, {
                    Index = "HealthDrainIntensity",
                    Type = "Number",
                    Description = "How much health you lose from opponent hits.\n\nHigher-rated judgements drain more per hit than lower ones.",
                    DisplayName = "Health Drain Intensity",
                    TypeMeta = {
                        Min = 0.25,
                        Max = 3,
                        Round = 2
                    }
                }, {
                    Index = "HealthDrainLimit",
                    Type = "Number",
                    Description = "The health percentage below which drain turns off, so you can\'t lose your last bit of health to it.",
                    DisplayName = "Health Drain Limit",
                    TypeMeta = {
                        Min = 0,
                        Max = 0.75,
                        Round = 2
                    }
                }, {
                    Index = "MultiplayerDrain",
                    Type = "Bool",
                    Description = "Turns on health drain during multiplayer matches too.\n\nMay lag behind actual gameplay very slightly.",
                    DisplayName = "Health Drain in Multiplayer"
                } }
        },
        {
            Name = "Miscellaneous",
            Items = { {
                    Index = "GhostTapping",
                    Type = "Bool",
                    Description = "Pressing a key with no note won\'t count as a miss.",
                    DisplayName = "Ghost Tapping"
                }, {
                    Index = "DisableChatOnGameplay",
                    Type = "Bool",
                    Description = "Hides and locks Roblox\'s chat while you\'re playing a song.",
                    DisplayName = "Hide Chat During Gameplay"
                } }
        }
    }
};
local v30 = {
    Name = "Preferences",
    Icon = "rbxassetid://16360659082",
    Items = {
        {
            Name = "Strums and Notes",
            Items = {
                {
                    Index = "NoteScale",
                    Type = "Number",
                    Description = "Changes how big notes and strums look.\n\nDoesn\'t affect Scroll Speed. For hold note width, see <b>Hold Note Width</b>.",
                    DisplayName = "Note Size",
                    TypeMeta = {
                        Min = 0.25,
                        Max = 1.5,
                        Round = 2
                    }
                },
                {
                    Index = "HoldNoteWidth",
                    Type = "Number",
                    Description = "Changes how wide hold notes are, as a percentage.\n\nA normal note is 160 wide, and the average hold note width across noteskins is about 50px (31.25%). This acts as a multiplier, so the actual result varies by noteskin.",
                    DisplayName = "Hold Note Width",
                    TypeMeta = {
                        Min = 0,
                        Max = 150,
                        Round = 2,

                        FormatInput = function(p26) -- Line: 654, Name: FormatInput
                            return p26 .. "%";
                        end,

                        GetValue = function(p27) -- Line: 658, Name: GetValue
                            return p27 * 100;
                        end,

                        SetValue = function(p28) -- Line: 661, Name: SetValue
                            return p28 / 100;
                        end
                    }
                },
                {
                    Index = "LaneTransparency",
                    Type = "Number",
                    Description = "Changes how see-through the panel behind the strum lanes is.\n\n0 is fully opaque, 1 is fully transparent.",
                    DisplayName = "Strum Background Transparency",
                    TypeMeta = {
                        Min = 0,
                        Max = 1,
                        Round = 2
                    }
                },
                {
                    Index = "FlashLaneOnMiss",
                    Type = "Bool",
                    Description = "Flashes the strum lane background white when you miss a note.\n\nDoesn\'t do anything if the background is already fully transparent.",
                    DisplayName = "Flash Strum Background on Miss"
                },
                {
                    Index = "BackgroundLaneSpacing",
                    Type = "Bool",
                    Description = "Adds a small gap between each strum lane\'s background.",
                    DisplayName = "Gaps Between Strum Lanes"
                },
                {
                    Index = "LowerZIndexSustains",
                    Type = "Bool",
                    Description = "Renders hold notes behind the strum layer instead of in front of it.",
                    DisplayName = "Holds Behind Strums"
                },
                {
                    Index = "SustainTransparency",
                    Type = "Number",
                    Description = "Changes how see-through hold notes are.\n\n0 is fully opaque, 1 is fully transparent.",
                    DisplayName = "Hold Note Transparency",
                    TypeMeta = {
                        Min = 0.1,
                        Max = 1,
                        Round = 2
                    }
                },
                {
                    Index = "DisableArrowPress",
                    Type = "Bool",
                    Description = "Turns off the strum\'s press animation when you ghost tap.",
                    DisplayName = "Hide Strum Press Animation"
                },
                {
                    Index = "DisableArrowGlow",
                    Type = "Bool",
                    Description = "Turns off the strum\'s glow animation when hitting notes.\n\nMakes strums behave like the left side in Kade Engine or Friday Night Funkin\' Demo builds.",
                    DisplayName = "Hide Strum Glow Animation"
                }
            }
        },
        {
            Name = "Notesplashes",
            Items = {
                {
                    Index = "Notesplashes",
                    Type = "Bool",
                    Description = "Shows a note splash effect when you land a Sick judgement or higher.",
                    DisplayName = "Note Splashes"
                },
                {
                    Index = "NoteSplashSize",
                    Type = "Number",
                    Description = "Changes how big note splashes are, as a percentage.",
                    DisplayName = "Note Splash Size",
                    TypeMeta = {
                        Min = 0.25,
                        Max = 1.5,
                        Round = 2
                    }
                },
                {
                    Index = "SplashTransparency",
                    Type = "Number",
                    Description = "Changes how see-through note splashes are.\n\n0 is fully opaque, 1 is fully transparent.",
                    DisplayName = "Note Splash Transparency",
                    TypeMeta = {
                        Min = 0,
                        Max = 1,
                        Round = 2
                    }
                },
                {
                    Index = "Holdsplashes",
                    Type = "Bool",
                    Description = "Shows a hold splash effect when you hold or release a held note.",
                    DisplayName = "Hold Splashes"
                },
                {
                    Index = "HoldSplashSize",
                    Type = "Number",
                    Description = "Changes how big hold splashes are, as a percentage.",
                    DisplayName = "Hold Splash Size",
                    TypeMeta = {
                        Min = 0.25,
                        Max = 1.5,
                        Round = 2
                    }
                },
                {
                    Index = "HoldSplashTransparency",
                    Type = "Number",
                    Description = "Changes how see-through hold splashes are.\n\n0 is fully opaque, 1 is fully transparent.",
                    DisplayName = "Hold Splash Transparency",
                    TypeMeta = {
                        Min = 0,
                        Max = 1,
                        Round = 2
                    }
                }
            }
        },
        {
            Name = "Camera Movement",
            Items = {
                {
                    Index = "CameraMovement",
                    Type = "Bool",
                    Description = "Lets the camera move around during gameplay depending on the section that\'s playing.\n\nWith this off, the camera just stays centered on the stage.",
                    DisplayName = "Camera Movement"
                },
                {
                    Index = "CameraZoom",
                    Type = "Bool",
                    Description = "Zooms the camera in slightly every four beats, and lets extra camera zoom events work.",
                    DisplayName = "Camera Zoom on Beat"
                },
                {
                    Index = "GameZoom",
                    Type = "Bool",
                    Description = "Applies the beat-synced camera zoom to the notes as well as the camera.",
                    DisplayName = "Game Zoom on Beat"
                },
                {
                    Index = "CameraFollow",
                    Type = "Bool",
                    Description = "Nudges the camera slightly toward the direction of whichever note you just hit.",
                    DisplayName = "Move Camera on Note Hit"
                },
                {
                    Index = "CameraFollowAngle",
                    Type = "Bool",
                    Description = "Slightly rotates the camera when you hit a left or right note.",
                    DisplayName = "Rotate Camera on Note Hit"
                },
                {
                    Index = "CameraFollowIntensity",
                    Type = "Number",
                    Description = "Speed multiplier for the <i>Move Camera on Note Hit</i> option.",
                    DisplayName = "Hit Camera Movement Intensity",
                    TypeMeta = {
                        Min = 0.25,
                        Max = 3,
                        Round = 2
                    }
                },
                {
                    Index = "CameraBop",
                    Type = "Dropdown",
                    Description = "Changes the style of the camera\'s zoom animation.\n\nDo note that these affect how camera zoom events look like, and events such as Friday Night Funkin\' V-Slice camera events might look weird!",
                    DisplayName = "Camera Bop Style",
                    TypeMeta = {
                        Options = { "Default", "Kade Engine", "FNF", "Psych", "Bloxxin" }
                    }
                },
                {
                    Index = "CameraEasingStyle",
                    Type = "Dropdown",
                    Description = "Sets the easing curve used for camera movement.\n\n<i>Default</i> uses a lerp instead of a tween.",
                    DisplayName = "Camera Easing Style",
                    TypeMeta = {
                        Options = { "Default", "Quad", "Sine", "Quint", "Quart", "Cubic", "Back", "Circular", "Elastic", "Exponential", "Bounce" }
                    }
                },
                {
                    Index = "CameraEasingDir",
                    Type = "Dropdown",
                    Description = "Sets the easing direction used for camera movement.\n\nHas no effect when <i>Camera Easing Style</i> is set to Default.",
                    DisplayName = "Camera Easing Direction",
                    TypeMeta = {
                        Options = { "InOut", "In", "Out" }
                    }
                },
                {
                    Index = "CameraMoveEmote",
                    Type = "Bool",
                    Description = "Focuses the camera on your character\'s head and follows it while you\'re emoting.",
                    DisplayName = "Camera Follows Player While Emoting"
                }
            }
        },
        {
            Name = "HUD Elements",
            Items = {
                {
                    Index = "ShowHUD",
                    Type = "Bool",
                    Description = "Toggles the whole heads-up display.",
                    DisplayName = "Show HUD"
                },
                {
                    Index = "HUDZoom",
                    Type = "Bool",
                    Description = "Zooms the HUD in slightly every four beats, and lets HUD zoom events work.",
                    DisplayName = "HUD Zoom on Beat"
                },
                {
                    Index = "HealthBar",
                    Type = "Bool",
                    Description = "Toggles the health bar.",
                    DisplayName = "Show Health Bar"
                },
                {
                    Index = "SmoothHUD",
                    Type = "Bool",
                    Description = "Smoothly animates health bar changes instead of snapping instantly.",
                    DisplayName = "Smooth HP Bar"
                },
                {
                    Index = "AccuracyBar",
                    Type = "Bool",
                    Description = "Toggles the stats label under the HP bar.",
                    DisplayName = "Show Accuracy & Miss Stats"
                },
                {
                    Index = "JudgementCounter",
                    Type = "Bool",
                    Description = "Toggles the judgement counter.",
                    DisplayName = "Show Judgement Counter"
                },
                {
                    Index = "ExtraInfo",
                    Type = "Bool",
                    DisplayName = "Show Extra Info (PA, MA, Mean)",
                    Description = "Shows extra stats: the ratio of Marvelous to Sick judgements, and your mean hit time."
                },
                {
                    Index = "ShowInfoOnRight",
                    Type = "Bool",
                    Description = "Moves the judgement counter and additional stats to the right side of the screen.",
                    DisplayName = "Move Judgements & Extras to the Right"
                },
                {
                    Index = "ShowTimebar",
                    Type = "Bool",
                    Description = "Toggles the time bar.",
                    DisplayName = "Show Time Bar"
                },
                {
                    Index = "TimebarColors",
                    Type = "Bool",
                    Description = "Colors the time bar using your and your opponent\'s equipped icons.",
                    DisplayName = "Color Time Bar by Icons"
                },
                {
                    Index = "AccuracyLabelBop",
                    Type = "Bool",
                    Description = "Makes the score and accuracy info briefly grow every time you hit a note, like in some Friday Night Funkin\' forks.",
                    DisplayName = "Accuracy Info Bops on Note Hit"
                },
                {
                    Index = "AccuracyLabelBopType",
                    Type = "Dropdown",
                    Description = "Changes how the accuracy info bops.",
                    DisplayName = "Accuracy Info Bop Type",
                    TypeMeta = {
                        Options = { "Default", "Angled" }
                    }
                },
                {
                    Index = "TimeBarTextFormat",
                    Type = "Dropdown",
                    Description = "Changes how the time bar\'s timer reads.\n\n<i>Song Position</i> counts up from 0:00. <i>Song Position / Song Length</i> also shows the total length, like 0:01 / 3:30. <i>Reverse Song Position</i> counts down from the total length instead.",
                    DisplayName = "Time Bar Text Format",
                    TypeMeta = {
                        Options = { "Song Position", "Song Position / Song Length", "Reverse Song Position" }
                    }
                },
                {
                    Index = "ShowSongNameInTimeBar",
                    Type = "Bool",
                    Description = "Shows the song\'s name next to the timer in the time bar, including its rate if you\'ve changed it.",
                    DisplayName = "Show Song Name in Time Bar"
                },
                {
                    Index = "ShowBreakTimer",
                    Type = "Bool",
                    Description = "Shows a countdown whenever a song has more than five seconds of downtime in a section.",
                    DisplayName = "Show Break Timer"
                },
                {
                    Index = "ShowHitError",
                    Type = "Bool",
                    Description = "Shows a bar that tracks how early or late your hits land.",
                    DisplayName = "Show Hit Error Bar"
                },
                {
                    Index = "HideInfo",
                    Type = "Bool",
                    Description = "Hides the song name and engine label during gameplay.",
                    DisplayName = "Hide Song & Engine Info"
                },
                {
                    Index = "ShowOpponentStats",
                    Type = "Bool",
                    Description = "Shows the opponent\'s stats at the bottom of the screen.\n\nOnly shows up when you\'re actually playing against someone.",
                    DisplayName = "Show Opponent Stats"
                },
                {
                    Index = "ShowMatchStats",
                    Type = "Bool",
                    Description = "Shows each team\'s combined stats in the top corners of the screen.",
                    DisplayName = "Show Team Stats on 2v2+"
                },
                {
                    Index = "ShowKeybindReminders",
                    Type = "Bool",
                    Description = "Shows your current keybinds when starting a song.",
                    DisplayName = "Show Keybind Reminders"
                },
                {
                    Index = "ShowSubtitles",
                    Type = "Bool",
                    Description = "Shows subtitles during a song.",
                    DisplayName = "Show Subtitles"
                },
                {
                    Index = "BackgroundDim",
                    Type = "Number",
                    Description = "Dims the background behind gameplay.\n\n0 fully dims it (hides it behind black), 1 leaves it fully visible.",
                    DisplayName = "Dim Gameplay Background",
                    TypeMeta = {
                        Min = 0,
                        Max = 1,
                        Round = 1
                    }
                },
                {
                    Index = "BackgroundImage",
                    Type = "Image",
                    Description = "Sets the image shown behind gameplay for the <i>Dim Gameplay Background</i> option. ID 0 falls back to solid black.\n\nIf the image fails to load, the dim defaults to solid black.",
                    DisplayName = "Background Image ID"
                },
                {
                    Index = "HUDOverNotes",
                    Type = "Bool",
                    Description = "Renders HUD in front of the strumline instead of behind it.\n\nNote that this might break the visuals on some older songs, and should not be used on them.",
                    DisplayName = "Show HUD Above The Notes"
                },
                {
                    Index = "DefaultHUD",
                    Type = "Dropdown",
                    DisplayName = "Replace Default HUD",
                    Description = "Overrides the default HUD with the selected preset, for songs that support a custom HUD.",
                    TypeMeta = {
                        Options = { "Default", "Funky Friday", "Bloxxin", "YAFN", "Arknights", "Hotline Miami", "Plants Vs Zombies", "Rain World", "Sonic Forces", "Undertale", "Asylum Rejects", "Block Tales", "Item Asylum", "Corruption", "Crafters Demise", "Crafters Demise (EXODUS)", "Dave And Bambi", "DDTO", "DDTO (STAGNANT)", "EXE", "FNAffliction", "Foundation (D Class)", "Funk Story", "Holofunk", "Marios Madness", "Madness0201 (Expurgation)", "Ourple Guy", "Ourple Guy (Bite)", "Pibby: Apocalypse (Finn)", "Pibby: Apocalypse (Gumball)", "Troubleshootin", "VS OMORI", "Base Game", "Codename Engine", "Forever Engine", "Kade Engine", "Project Blossom", "Schizo HUD" }
                    }
                }
            }
        },
        {
            Name = "Visualizer",
            Items = {
                {
                    Index = "SoundVisualizer",
                    Type = "Bool",
                    Description = "Shows an audio visualizer at the bottom of the screen.\n\nCan cost a bit of performance on lower-end devices.",
                    DisplayName = "Show Audio Visualizer"
                },
                {
                    Index = "VisualizerType",
                    Type = "Dropdown",
                    Description = "Changes the visualizer\'s shape.",
                    DisplayName = "Visualizer Style",
                    TypeMeta = {
                        Options = { "Bars", "Stereo Bars", "Line" }
                    }
                },
                {
                    Index = "VisualizerPosition",
                    Type = "Dropdown",
                    Description = "Changes where the visualizer sits on screen.\n\nDoesn\'t apply when <i>Visualizer Style</i> is set to a Stereo option.",
                    DisplayName = "Visualizer Position",
                    TypeMeta = {
                        Options = { "Down", "Up", "Center", "Left", "Right" }
                    }
                },
                {
                    Index = "VisualizerBarCount",
                    Type = "Number",
                    Description = "Changes how many bars or line points the visualizer uses.\n\nMore segments look smoother but cost more performance.",
                    DisplayName = "Visualizer Segments",
                    TypeMeta = {
                        Min = 1,
                        Max = 128,
                        Round = 0
                    }
                },
                {
                    Index = "VisualizerMultSize",
                    Type = "Number",
                    Description = "Changes how strongly each segment reacts to the audio.",
                    DisplayName = "Visualizer Size Multiplier",
                    TypeMeta = {
                        Min = 0.05,
                        Max = 4,
                        Round = 2,

                        FormatInput = function(p29) -- Line: 1244, Name: FormatInput
                            return p29 .. "x";
                        end
                    }
                },
                {
                    Index = "VisualizerGap",
                    Type = "Number",
                    Description = "Changes the spacing between bars, in pixels.\n\nOnly applies to the Bars and Stereo Bars styles.",
                    DisplayName = "Visualizer Pixel Gap",
                    TypeMeta = {
                        Min = 0,
                        Max = 1280,
                        Round = 0
                    }
                },
                {
                    Index = "VisualizerLineThickness",
                    Type = "Number",
                    Description = "Changes how thick the visualizer line is, in pixels.\n\nOnly applies to the Line style.",
                    DisplayName = "Visualizer Line Thickness",
                    TypeMeta = {
                        Min = 0,
                        Max = 50,
                        Round = 0
                    }
                },
                {
                    Index = "VisualizerTransparency",
                    Type = "Number",
                    Description = "Changes how see-through the visualizer is.\n\n0 is fully opaque, 1 is fully transparent. Doesn\'t work with a Line visualizer, due to a Roblox limitation.",
                    DisplayName = "Visualizer Transparency",
                    TypeMeta = {
                        Min = 0,
                        Max = 1,
                        Round = 2
                    }
                },
                {
                    Index = "VisualizerColor",
                    Type = "Color",
                    DisplayName = "Visualizer Color",
                    Description = "Changes the visualizer\'s color."
                }
            }
        },
        {
            Name = "Advanced",
            Items = {
                {
                    Index = "FlipNoteskin",
                    Type = "Bool",
                    Description = "Swaps the up and down strums on 6 and 7 key.\n\nThis restores an old coding mistake from mods like VS. Shaggy, kept around for compatibility.",
                    DisplayName = "Flip Up & Down on 6K & 7K"
                },
                {
                    Index = "SyncAnimationToBPM",
                    Type = "Bool",
                    Description = "Syncs idle animations to the song\'s beat, like in Friday Night Funkin\'.\n\nSome animations can look a little faster or slower than intended with this on.",
                    DisplayName = "Sync Idle Animations to BPM"
                },
                {
                    Index = "RepeatAnimationWhenHoldingNote",
                    Type = "Bool",
                    Description = "Repeats your hit animation while you\'re holding a note down.\n\nWith this off, holding a note plays the same animation as a normal tap and just ignores the hold.",
                    DisplayName = "Repeat Animations While Holding Notes"
                },
                {
                    Index = "RemoveGameRatio",
                    Type = "Bool",
                    DisplayName = "Remove Forced Game Ratio (Experimental)",
                    Description = "Stretches gameplay to fill your actual screen ratio instead of the usual locked 16:9.\n\nExperimental, some layouts might not look right."
                },
                {
                    Index = "FakeOpponentInput",
                    Type = "Bool",
                    DisplayName = "Botplay for Opponent in 1v1s+",
                    Description = "Replaces the opponent\'s hits and events with a bot, as if you were playing solo.\n\nRemoves opponent taunts and ghost-tap animations, which can help with lag. May cause inconsistencies with some multiplayer song events."
                },
                {
                    Index = "QuantNotes",
                    Type = "Bool",
                    Description = "Recolors notes based on their timing in the chart, similar to Stepmania or Etterna.",
                    DisplayName = "Note Quantization"
                },
                {
                    Index = "FlipMobileExtraTiles",
                    Type = "Bool",
                    DisplayName = "Flip Mobile Extra Tile Position",
                    Description = "Moves the extra mobile keybind (usually Dodge) between the top and bottom of the screen.\n\nSits at the top by default."
                },
                {
                    Index = "SeparateMobileMiddleKey",
                    Type = "Bool",
                    DisplayName = "Separate Mobile Middle Tile",
                    Description = "Moves the middle tile on 3/5/7/9 key onto its own row, away from the rest.\n\nMakes it easier to reach comfortably with your thumb."
                },
                {
                    Index = "MobileTileFollowStrum",
                    Type = "Bool",
                    DisplayName = "Mobile Tiles Follow Strums",
                    Description = "Matches mobile tile size and position to the strum backgrounds.\n\nTiles move along with the strums, so songs that shift notes around will also move the buttons. <b>That\'s intentional, not a bug.</b>"
                }
            }
        },
        {
            Name = "Mobile",
            Items = { {
                    Index = "MobileTileTransparency",
                    Type = "Number",
                    Description = "Changes how see-through mobile tiles are.\n\n0 is fully opaque, 1 is fully transparent.",
                    DisplayName = "Mobile Tile Transparency",
                    TypeMeta = {
                        Min = 0,
                        Max = 1,
                        Round = 2
                    }
                }, {
                    Index = "TilesWithNotch",
                    Type = "Bool",
                    Description = "Extends tiles to fill the whole screen, ignoring the space where the front camera notch sits.",
                    DisplayName = "Fullscreen Tiles (Ignores Notch)"
                }, {
                    Index = "UseNotchCovers",
                    Type = "Bool",
                    Description = "Covers up content that would otherwise sit behind the front camera notch.",
                    DisplayName = "Cover Offscreen Content (Notch)"
                } }
        },
        {
            Name = "Song Select & Menus",
            Items = {
                {
                    Index = "SortByWeek",
                    Type = "Bool",
                    Description = "Sorts songs by week instead of alphabetically, like Friday Night Funkin\'.",
                    DisplayName = "Sort Songs by Week"
                },
                {
                    Index = "ShowSongSelectStats",
                    Type = "Bool",
                    Description = "Shows your Full Combo status for each mod/song in the song select menu.",
                    DisplayName = "Show FC Data on Song Select"
                },
                {
                    Index = "SongSelectUpscale",
                    Type = "Number",
                    Description = "Scales the song select interface up on resolutions taller than 720p.\n\nAt 0, elements stay pixel-accurate and look smaller on bigger screens. At 1, elements match how they\'d look on a 720p display.",
                    DisplayName = "Song Select Upscale Multiplier",
                    TypeMeta = {
                        Min = 0,
                        Max = 2,
                        Round = 2
                    }
                },
                {
                    Index = "ShowResults",
                    Type = "Bool",
                    Description = "Shows a results screen after finishing a song, with your stats, rating, and a judgement breakdown.",
                    DisplayName = "Show Results Screen"
                },
                {
                    Index = "UseSongIcons",
                    Type = "Bool",
                    Description = "Overrides your equipped icon with one made for the current song, when it has one.",
                    DisplayName = "Song-Specific Icons"
                },
                {
                    Index = "AfterImages",
                    Type = "Bool",
                    Description = "Leaves faint copies of the opponent behind whenever they hit a note, like in VS. Tabi.",
                    DisplayName = "Show After Images"
                }
            }
        }
    }
};

for _, v in { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 18 } do
    local v31 = {
        Name = "Keybinds (" .. v .. " Keys)",
        IndexPrefix = "+/" .. v,
        Items = {}
    };
    local v32 = v;

    for _, v2 in Dirs[v] do
        table.insert(v31.Items, {
            Type = "Keybind",
            Index = "+/" .. v2,
            TypeMeta = {
                KeybindsAllowed = 2
            },
            DisplayName = v22[v2][1] .. " (" .. v32 .. " Keys)",
            Description = (v22[v2][1] == v2 and v2 and v2 or v22[v2][1] .. " (" .. v2 .. ")") .. " keybind for " .. v32 .. " keys."
        });
    end;

    table.insert(v23.Items, v31);
end;

local v33 = { "User ID", "Username", "Outfit ID" };
local v34 = {
    Name = "Streamer Options",
    Icon = "rbxassetid://16360842205",
    Prefix = "Content Creator",
    ShortPrefix = "CC",
    PrefixColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(197, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }),

    Visible = function() -- Line: 2794, Name: Visible
        -- upvalues: PlayerRanks (copy)
        return PlayerRanks:GetRank() >= 150;
    end,

    Items = { {
            Index = "StreamerMode",
            Type = "Bool",
            DisplayName = "Streamer Mode",
            Description = "Mutes and blocks songs that might trigger a content ID claim, like Gangnam Style or tracks by JT Music and The Living Tombstone."
        } }
};
({
    Name = "NAME_GOES_HERE",
    Icon = "rbxassetid://16360658571"
}).Items = {};

return {
    v25,
    v21,
    v30,
    v23,
    {
        Name = "Customization",
        Icon = "rbxassetid://16360658328",
        Items = {
            {
                Name = "Combo",
                Items = { {
                        Index = "RuinCombo",
                        Type = "Bool",
                        DisplayName = "Old FNF Style Combo",
                        Description = "Always shows three digits in the combo counter, even under 100, like classic Friday Night Funkin\'."
                    }, {
                        Index = "ShowComboWhenHigherThan10",
                        Type = "Bool",
                        DisplayName = "Show Combo Only Above 10",
                        Description = "Only shows the combo counter once you\'ve hit 10 notes in a row without missing, like Friday Night Funkin\'."
                    } }
            },
            {
                Name = "Leaderboard",
                Items = {
                    {
                        Index = "DisableLeaderboardOnGameplay",
                        Type = "Bool",
                        Description = "Hides and locks the leaderboard while you\'re playing a song.\n\nIf you rely on the leaderboard keybind mid-match, change it first to avoid a conflict.",
                        DisplayName = "Hide Leaderboard During Gameplay"
                    },
                    {
                        Index = "CompactLeaderboard",
                        Type = "Bool",
                        Description = "Shrinks each player\'s row on the leaderboard.\n\nBanners get cropped to fit, but you can still see them in full by hovering over a player.",
                        DisplayName = "Compact Leaderboard Mode"
                    },
                    {
                        Index = "LeaderboardEnabled",
                        Type = "Bool",
                        Description = "Turns the leaderboard on or off entirely.",
                        DisplayName = "Leaderboard Enabled"
                    },
                    {
                        Index = "AlwaysAnimateLeaderboardBanners",
                        Type = "Bool",
                        Description = "Animates every player\'s leaderboard banner at once.\n\nWith this off, a banner only animates while you\'re hovering over that player.",
                        DisplayName = "Always Animate Leaderboard Banners"
                    },
                    {
                        Index = "LeaderboardVerticalSize",
                        Type = "Slider",
                        DisplayName = "Leaderboard Size Limit",
                        Description = "Sets the most vertical screen space the leaderboard is allowed to take up.",
                        TypeMeta = {
                            Min = 15,
                            Max = 75,
                            Round = 0,

                            FormatInput = function(p35) -- Line: 1674, Name: FormatInput
                                return p35 .. "%";
                            end,

                            GetValue = function(p36) -- Line: 1678, Name: GetValue
                                return p36 * 100;
                            end,

                            SetValue = function(p37) -- Line: 1681, Name: SetValue
                                return p37 / 100;
                            end
                        }
                    }
                }
            },
            {
                Name = "Icons",
                Items = { {
                        Type = "Text",
                        DisplayName = "Looking for your custom icons? They live in the Shop now!"
                    }, {
                        Index = "ShowCustomIcons",
                        Type = "Bool",
                        Description = "Shows the opponent\'s custom icon over their equipped shop icon, if they have one set.",
                        DisplayName = "Show Opponent\'s Custom Icon"
                    }, {
                        Index = "ShowPlayerCustomIcon",
                        Type = "Bool",
                        Description = "Uses your equipped custom icon instead of your shop icon, if you\'ve got both set up.\n\nHandy since some players turn off custom icons for others (see <i>Show Opponent\'s Custom Icon</i>), but you can still show your own.",
                        DisplayName = "Prefer Custom Icon Over Shop Icon"
                    }, {
                        Index = "ShowBotCustomIcon",
                        Type = "Bool",
                        Description = "Uses a bot\'s equipped custom icon instead of the shop icon set for it, if both are set up.",
                        DisplayName = "Prefer Custom Icon for Bots"
                    } }
            },
            {
                Name = "Other",
                Items = { {
                        Index = "ShowNowPlaying",
                        Type = "Bool",
                        DisplayName = "Show \"Now Playing\" Popup",
                        Description = "Flies a popup in at the top of the screen showing the current song\'s name, like other FNF games on Roblox."
                    }, {
                        Index = "ShowOpponentSettings",
                        Type = "Bool",
                        Description = "Shows the opponent\'s visual settings on your side instead of mirroring your own.",
                        DisplayName = "Show Opponent\'s Settings"
                    }, {
                        Index = "PlayAnimationOnGhosttap",
                        Type = "Bool",
                        Description = "Plays your singing animation when you press a key with no note there, like other FNF games on Roblox.",
                        DisplayName = "Play Animations on Ghost Tap"
                    }, {
                        Index = "IconBop",
                        Type = "Dropdown",
                        Description = "Changes how your icon bops.",
                        DisplayName = "Icon Bop Style",
                        TypeMeta = {
                            Options = { "Bloxxin", "FNF", "FNF (Legacy)", "None", ".EXE", "MCM", "Hood", "Kade Engine", "FF", "Project Blossom", "OURPLE GUY", "Kreadian Funk", "Squishy", "Squishy (Horizontal)", "Head Bop" }
                        }
                    } }
            }
        }
    },
    {
        Name = "Ratings",
        Icon = "rbxassetid://16360659475",
        Items = {
            {
                Index = "ShowRatings",
                Type = "Bool",
                DisplayName = "Show Ratings",
                Description = "Toggles the hit judgement popup."
            },
            {
                Index = "ShowCombo",
                Type = "Bool",
                DisplayName = "Show Combo",
                Description = "Toggles the combo counter."
            },
            {
                Index = "ShowJudgementOffset",
                Type = "Bool",
                DisplayName = "Show Judgement Offset",
                Description = "Shows the millisecond value of how early or late your hit was."
            },
            {
                Index = "RatingsMethod",
                Type = "Dropdown",
                DisplayName = "Rating Popup Style",
                Description = "Changes the style of the rating popup animation.",
                TypeMeta = {
                    Options = { "Afternight", "FNF", "ADOFAI", "ADOFAI (ALT)", "Bloxxin", "FF", "FF (Rewrite)", "HL024", "ITG", "osu!mania", "OURPLE GUY", "Stepmania" }
                }
            },
            {
                Index = "JudgementStyle",
                Type = "Dropdown",
                Description = "Changes the style of the judgement sprites.",
                DisplayName = "Rating Design Presets",
                TypeMeta = {
                    Options = { "Afternight", "FNF", "FNF (Pixel)", "Andromeda Engine", "Kade Engine", "Leather Engine", "Leather Engine (Pixel)", "Ace (Flavor Rave)", "AdventNEON", "B3 Remixed", "BOPCITY", "Brawl Stars", "Daisy (Flavor Rave)", "DDTO+", "Erratic", "Forever Syndrome", "Foundation", "Funk Story", "Gummy", "HoloFunk", "Hypno\'s Lullaby", "Mario\'s Madness", "Mega Man", "OMORI", "OURPLE GUY", "Persona 5", "Poem", "Rika", "Rhythmic Robo", "Saff", "Salty", "Savory", "SEGA", "Smoky", "Soft", "Sonic Forces", "Sour", "Space Jam", "Spicy", "Sun-Dried", "Super Funkin\' Galaxy", "Sweet", "Synthetic", "Tangy", "The Funkin\' Files", "The Trollge Files", "Troubleshootin\'", "Umami", "Wii Deleted You" }
                }
            },
            {
                Type = "Action",
                Description = "Opens the Rating Editor, where you can reposition and resize your judgements.",
                DisplayName = "Rating Editor",
                TypeMeta = {
                    ActionName = "Edit",

                    OnClick = function(u38) -- Line: 1902, Name: OnClick
                        local RatingScreen = u38.ui.SubStates.RatingScreen;

                        if RatingScreen:GetAttribute("Debounce") then
                            return;
                        end;

                        u38:setSubmenuState(true);
                        RatingScreen.Visible = true;
                        RatingScreen:SetAttribute("Running", true);
                        RatingScreen:TweenPosition(UDim2.fromScale(0.5, 0.5), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.6, true);
                        RatingScreen.BackButton.MouseButton1Click:Once(function() -- Line: 1912
                            -- upvalues: u38 (copy), RatingScreen (copy)
                            u38:setSubmenuState(false);
                            RatingScreen:SetAttribute("Debounce", true);
                            task.delay(0.6, function() -- Line: 1916
                                -- upvalues: RatingScreen (ref)
                                RatingScreen:SetAttribute("Running", false);
                                RatingScreen:SetAttribute("Debounce", false);
                                RatingScreen.Visible = false;
                            end);
                            RatingScreen:TweenPosition(UDim2.fromScale(0.5, -1), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.6, true);
                        end);
                    end
                }
            },
            {
                Index = "RatingsOverNotes",
                Type = "Bool",
                Description = "Renders judgements in front of the strumline instead of behind it.",
                DisplayName = "Show Ratings Above The Notes"
            },
            {
                Name = "Custom Judgement Images",
                IndexPrefix = "JudgementImages",
                Items = {
                    {
                        Type = "Text",
                        DisplayName = "These rating presets override your preset, so leave them at 0 to keep your actual presets!"
                    },
                    {
                        Index = "+/Marvelous",
                        Type = "Image",
                        DisplayName = "Marvelous Image ID",
                        Description = "Sets the image used for the Marvelous judgement sprite."
                    },
                    {
                        Index = "+/Sick",
                        Type = "Image",
                        DisplayName = "Sick Image ID",
                        Description = "Sets the image used for the Sick judgement sprite."
                    },
                    {
                        Index = "+/Good",
                        Type = "Image",
                        DisplayName = "Good Image ID",
                        Description = "Sets the image used for the Good judgement sprite."
                    },
                    {
                        Index = "+/Ok",
                        Type = "Image",
                        DisplayName = "OK Image ID",
                        Description = "Sets the image used for the OK judgement sprite."
                    },
                    {
                        Index = "+/Bad",
                        Type = "Image",
                        DisplayName = "Bad Image ID",
                        Description = "Sets the image used for the Bad judgement sprite."
                    },
                    {
                        Index = "+/Miss",
                        Type = "Image",
                        DisplayName = "Miss Image ID",
                        Description = "Sets the image used for the Miss judgement sprite."
                    },
                    {
                        Index = "+/Combo",
                        Type = "Image",
                        DisplayName = "Combo Image ID",
                        Description = "Sets the image used for the combo number spritesheet."
                    },
                    {
                        Index = "+/Ratings",
                        Type = "Image",
                        DisplayName = "Rating Numbers Image ID",
                        Description = "Sets the image used for the judgement offset number spritesheet."
                    },
                    {
                        Index = "+/Offset",
                        Type = "Image",
                        DisplayName = "Rating Extras Image ID",
                        Description = "Sets the image used for the judgement offset spritesheet\'s <b><i>-</i></b> and <b><i>.</i></b> characters."
                    }
                }
            }
        }
    },
    {
        Name = "Accessibility",
        Icon = "rbxassetid://16360726093",
        Items = {
            {
                Name = "Accessibility",
                Items = { {
                        Index = "CameraShake",
                        Type = "Bool",
                        DisplayName = "Camera Shakes",
                        Description = "Toggles heavy camera shake effects."
                    }, {
                        Index = "CameraFlash",
                        Type = "Bool",
                        DisplayName = "Flashing Lights",
                        Description = "Toggles intense flashing lights during songs."
                    }, {
                        Index = "HaveJumpscare",
                        Type = "Bool",
                        DisplayName = "Show Jumpscares",
                        Description = "Toggles jumpscares during songs."
                    }, {
                        Index = "SimpleGimmickNotes",
                        Type = "Bool",
                        DisplayName = "Simplify Gimmick Notes",
                        Description = "Swaps special note sprites for simpler ones.\n\nNotes you\'re meant to miss show up as a <b>red and black note</b>, similar to The Tricky Mod. Notes you\'re meant to hit show up as a <b>warning note</b>."
                    } }
            },
            {
                Name = "Offsets",
                Items = {
                    {
                        Index = "InputOffset",
                        Type = "Number",
                        DisplayName = "Input Offset (milliseconds)",
                        Description = "Shifts your input timing earlier or later, in milliseconds.\n\nUseful if you notice a consistent desync in your hits.",
                        TypeMeta = {
                            Min = -1000,
                            Max = 1000,
                            Round = 1
                        }
                    },
                    {
                        Index = "AudioOffset",
                        Type = "Number",
                        DisplayName = "Audio Offset (milliseconds)",
                        Description = "Shifts the song\'s audio earlier or later, in milliseconds.\n\nUseful if you notice audio desync.",
                        TypeMeta = {
                            Min = -500,
                            Max = 500,
                            Round = 1
                        }
                    },
                    {
                        Type = "Action",
                        Description = "Opens the offset editor, where you can check your offsets with a visual indicator.",
                        DisplayName = "Offset Editor",
                        TypeMeta = {
                            ActionName = "Edit",

                            OnClick = function(u39) -- Line: 2099, Name: OnClick
                                local OffsetScreen = u39.ui.SubStates.OffsetScreen;

                                if OffsetScreen:GetAttribute("Debounce") then
                                    return;
                                end;

                                u39:setSubmenuState(true);
                                OffsetScreen:SetAttribute("Running", true);
                                OffsetScreen.Visible = true;
                                OffsetScreen:TweenPosition(UDim2.fromScale(0.5, 0.5), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.6, true);
                                OffsetScreen.BackButton.MouseButton1Click:Once(function() -- Line: 2109
                                    -- upvalues: u39 (copy), OffsetScreen (copy)
                                    u39:setSubmenuState(false);
                                    OffsetScreen:SetAttribute("Debounce", true);
                                    task.delay(0.6, function() -- Line: 2113
                                        -- upvalues: OffsetScreen (ref)
                                        OffsetScreen:SetAttribute("Running", false);
                                        OffsetScreen:SetAttribute("Debounce", false);
                                        OffsetScreen.Visible = false;
                                    end);
                                    OffsetScreen:TweenPosition(UDim2.fromScale(0.5, -1), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.6, true);
                                end);
                            end
                        }
                    }
                }
            }
        }
    },
    {
        Name = "Bot Settings",
        Icon = "rbxassetid://16360726093",
        Items = {
            {
                Name = "General Bot Settings",
                Items = { {
                        Index = "ShowBotplayTags",
                        Type = "Bool",
                        DisplayName = "Show Bot Nametags",
                        Description = "Shows a nametag above bots during gameplay."
                    } }
            },
            {
                Name = "Duo Animation Bot",
                Items = {
                    {
                        Index = "DuoUserID",
                        Type = "String",
                        DisplayName = "Duo Animation Bot Username/ID",
                        Description = "Sets which user\'s outfit or animations the Duo bot uses."
                    },
                    {
                        Index = "DuoUserType",
                        Type = "Dropdown",
                        DisplayName = "Duo Animation Bot Type",
                        Description = "Sets whether the field above is a Username, User ID, or Outfit ID.",
                        TypeMeta = {
                            Options = v33
                        }
                    }
                }
            },
            {
                Name = "Trio Animation Bot",
                Items = {
                    {
                        Index = "TrioUserID",
                        Type = "String",
                        DisplayName = "Trio Animation Bot Username/ID",
                        Description = "Sets which user\'s outfit or animations the Trio bot uses."
                    },
                    {
                        Index = "TrioUserType",
                        Type = "Dropdown",
                        DisplayName = "Trio Animation Bot Type",
                        Description = "Sets whether the field above is a Username, User ID, or Outfit ID.",
                        TypeMeta = {
                            Options = v33
                        }
                    }
                }
            },
            {
                Name = "Opponent Bot",
                Items = {
                    {
                        Index = "BotUserID",
                        Type = "String",
                        DisplayName = "Opponent Bot Username/ID",
                        Description = "Sets which user\'s outfit or animations the opponent bot uses."
                    },
                    {
                        Index = "BotUserType",
                        Type = "Dropdown",
                        DisplayName = "Opponent Bot Type",
                        Description = "Sets whether the field above is a Username, User ID, or Outfit ID.",
                        TypeMeta = {
                            Options = v33
                        }
                    }
                }
            },
            {
                Name = "Song Bot (Slot 2)",
                Items = {
                    {
                        Index = "ExtraBotIDs/1",
                        Type = "String",
                        DisplayName = "Secondary Song Bot Username/ID",
                        Description = "Sets which user\'s outfit or animations the secondary song bot uses."
                    },
                    {
                        Index = "ExtraBotTypes/1",
                        Type = "Dropdown",
                        DisplayName = "Secondary Song Bot Type",
                        Description = "Sets whether the field above is a Username, User ID, or Outfit ID.",
                        TypeMeta = {
                            Options = v33
                        }
                    }
                }
            },
            {
                Name = "Song Bot (Slot 3)",
                Items = {
                    {
                        Index = "ExtraBotIDs/2",
                        Type = "String",
                        DisplayName = "Third Song Bot Username/ID",
                        Description = "Sets which user\'s outfit or animations the third song bot uses."
                    },
                    {
                        Index = "ExtraBotTypes/2",
                        Type = "Dropdown",
                        DisplayName = "Third Song Bot Type",
                        Description = "Sets whether the field above is a Username, User ID, or Outfit ID.",
                        TypeMeta = {
                            Options = v33
                        }
                    }
                }
            },
            {
                Name = "Song Bot (Slot 4)",
                Items = {
                    {
                        Index = "ExtraBotIDs/3",
                        Type = "String",
                        DisplayName = "Fourth Song Bot Username/ID",
                        Description = "Sets which user\'s outfit or animations the fourth song bot uses."
                    },
                    {
                        Index = "ExtraBotTypes/3",
                        Type = "Dropdown",
                        DisplayName = "Fourth Song Bot Type",
                        Description = "Sets whether the field above is a Username, User ID, or Outfit ID.",
                        TypeMeta = {
                            Options = v33
                        }
                    }
                }
            },
            {
                Name = "Song Bot (Slot 5)",
                Items = {
                    {
                        Index = "ExtraBotIDs/4",
                        Type = "String",
                        DisplayName = "Fifth Song Bot Username/ID",
                        Description = "Sets which user\'s outfit or animations the fifth song bot uses."
                    },
                    {
                        Index = "ExtraBotTypes/4",
                        Type = "Dropdown",
                        DisplayName = "Fifth Song Bot Type",
                        Description = "Sets whether the field above is a Username, User ID, or Outfit ID.",
                        TypeMeta = {
                            Options = v33
                        }
                    }
                }
            },
            {
                Name = "Emote Bot",
                Items = {
                    {
                        Index = "EmoteUserID",
                        Type = "String",
                        DisplayName = "Emote Bot Username/ID",
                        Description = "Sets which user\'s outfit or animations the emote bot uses."
                    },
                    {
                        Index = "EmoteUserType",
                        Type = "Dropdown",
                        DisplayName = "Emote Bot Type",
                        Description = "Sets whether the field above is a Username, User ID, or Outfit ID.",
                        TypeMeta = {
                            Options = v33
                        }
                    }
                }
            },
            {
                Name = "Emote Duo Bot",
                Items = {
                    {
                        Index = "DuoEmoteUserID",
                        Type = "String",
                        DisplayName = "Emote Duo Bot Username/ID",
                        Description = "Sets which user\'s outfit or animations the emote duo bot uses."
                    },
                    {
                        Index = "DuoEmoteUserType",
                        Type = "Dropdown",
                        DisplayName = "Emote Duo Bot Type",
                        Description = "Sets whether the field above is a Username, User ID, or Outfit ID.",
                        TypeMeta = {
                            Options = v33
                        }
                    }
                }
            },
            {
                Name = "Emote Trio Bot",
                Items = {
                    {
                        Index = "TrioEmoteUserID",
                        Type = "String",
                        DisplayName = "Emote Trio Bot Username/ID",
                        Description = "Sets which user\'s outfit or animations the emote trio bot uses."
                    },
                    {
                        Index = "TrioEmoteUserType",
                        Type = "Dropdown",
                        DisplayName = "Emote Trio Bot Type",
                        Description = "Sets whether the field above is a Username, User ID, or Outfit ID.",
                        TypeMeta = {
                            Options = v33
                        }
                    }
                }
            }
        }
    },
    {
        Name = "Extras & Optimizations",
        Icon = "rbxassetid://16360842205",
        Items = {
            {
                Name = "Extras",
                Items = {
                    {
                        Index = "ControllerVibration",
                        Type = "Bool",
                        DisplayName = "Controller Vibration",
                        Description = "Rumbles your controller during moments with a screen shaking effect."
                    },
                    {
                        Index = "KicksAllowed",
                        Type = "Bool",
                        DisplayName = "Song Kicking",
                        Description = "Lets certain songs, like Piracy Check, kick you from the game if you fail them."
                    },
                    {
                        Index = "NoMissAnimation",
                        Type = "Bool",
                        DisplayName = "Hide Miss Animations",
                        Description = "Hides your character\'s miss pose when you miss a note."
                    },
                    {
                        Index = "ShowRank",
                        Type = "Bool",
                        DisplayName = "Show Rank",
                        Description = "Shows your rank on your user card and overhead display.",

                        OnToggle = function(p40, p41) -- Line: 2437, Name: OnToggle
                            -- upvalues: Events (copy)
                            print("show rank", p41);
                            Events.Overheads.RefreshOverhead:FireServer();
                        end
                    },
                    {
                        Index = "JumpscareImage",
                        Type = "Image",
                        DisplayName = "Jumpscare Image ID",
                        Description = "Sets the image used for the jumpscare gameplay modifier."
                    },
                    {
                        Index = "LiveSenpaiReaction",
                        Type = "Bool",
                        DisplayName = "Live Senpai Reaction",
                        Description = "Keeps Senpai from Dating Simulator on screen the whole time during gameplay.\n\nPurely for fun, doesn\'t affect anything else."
                    },
                    {
                        Index = "ShowFPSMemInfo",
                        Type = "Bool",
                        DisplayName = "Show FPS & Memory",
                        Description = "Shows your FPS and memory usage in the performance label during gameplay."
                    },
                    {
                        Index = "ShowDebugInfo",
                        Type = "Bool",
                        DisplayName = "Show Debug Info",
                        Description = "Shows song position and note/object cache info in the performance label during gameplay.\n\n<b>Keeps the performance label from fading out, so only leave this on for debugging, it can get in the way of actually playing.</b>"
                    },
                    {
                        Index = "AlignDebugToRight",
                        Type = "Bool",
                        DisplayName = "Align FPS/Debug To Right",
                        Description = "Aligns the FPS & Debug label to the right side of the screen."
                    }
                }
            },
            {
                Name = "Optimizations",
                Items = {
                    {
                        Index = "DisableProps",
                        Type = "Bool",
                        DisplayName = "Hide Map Props",
                        Description = "Hides some map props to help performance."
                    },
                    {
                        Index = "DisableTextures",
                        Type = "Bool",
                        DisplayName = "Hide Materials",
                        Description = "Hides materials on parts to help performance."
                    },
                    {
                        Index = "DisableShadows",
                        Type = "Bool",
                        DisplayName = "Hide Shadows",
                        Description = "Stops shadows from rendering, which can noticeably help performance."
                    },
                    {
                        Index = "DisableMapMidsong",
                        Type = "Bool",
                        DisplayName = "Hide Backgrounds",
                        Description = "Hides the backgrounds used in certain songs.\n\nUseful on lower-end devices."
                    },
                    {
                        Index = "DisableOpponentStrums",
                        Type = "Bool",
                        DisplayName = "Hide Opponent\'s Strums",
                        Description = "Stops the opponent\'s strums from rendering."
                    },
                    {
                        Index = "DisablePixelManipulation",
                        Type = "Bool",
                        DisplayName = "Reduce Pixel Manipulation",
                        Description = "Cuts back on EditableImage usage, which is the closest thing we\'ve got to a 2D shader right now.\n\nCurrently only active in select songs. Can help performance."
                    },
                    {
                        Index = "HideLobby",
                        Type = "Bool",
                        DisplayName = "Hide Lobby During Gameplay",
                        Description = "Hides the lobby while you\'re playing.\n\nUseful on lower-end devices."
                    },
                    {
                        Index = "HideCharacters",
                        Type = "Bool",
                        DisplayName = "Hide All Characters During Gameplay",
                        Description = "Hides every character, including ones on stage, while you\'re playing.\n\nUseful on lower-end devices."
                    }
                }
            },
            {
                Name = "Advanced",
                Items = {
                    {
                        Index = "CustomVoidColor",
                        Type = "Color",
                        DisplayName = "Custom Void Color (No Background)",
                        Description = "Changes the color shown when no background is active."
                    },
                    {
                        Index = "UseFaces",
                        Type = "Bool",
                        DisplayName = "Animated Faces",
                        Description = "Shows animated faces on characters whose animations have them."
                    },
                    {
                        Index = "UseProps",
                        Type = "Bool",
                        DisplayName = "Animation Props",
                        Description = "Shows props that come attached to certain animations."
                    },
                    {
                        Index = "UseRequiredProps",
                        Type = "Bool",
                        DisplayName = "Required Animation Props",
                        Description = "Shows props that some animations need to make sense, like microphones or guitars."
                    },
                    {
                        Index = "DisableInvites",
                        Type = "Bool",
                        DisplayName = "Opt Out of Game Invites",
                        Description = "Stops you from getting invites while queuing for a match."
                    },
                    {
                        Type = "Action",
                        Description = "Resets the intro cutscene so it plays again next time you boot the game.",
                        DisplayName = "Reset Cutscene",
                        TypeMeta = {
                            ActionName = "Reset",

                            OnClick = function() -- Line: 2602, Name: OnClick
                                -- upvalues: DataManager (copy)
                                DataManager:SetData("hasSeenU1", false);
                            end
                        }
                    }
                }
            },
            {
                Name = "Title and Loading Screens",
                Items = { {
                        Index = "ShowLuaPreIntro",
                        Type = "Bool",
                        DisplayName = "Show Lua Pre-Intro",
                        Description = "Shows a splash screen on boot, similar to the old HaxeFlixel splash from early Friday Night Funkin\' versions."
                    } }
            }
        }
    },
    {
        Name = "Integrations",
        Icon = "rbxassetid://16360842205",
        Items = {
            {
                Name = "Bloxstrap Settings",
                Icon = "rbxassetid://16360842205",
                Items = {
                    {
                        Type = "Action",
                        DisplayName = "Bloxstrap Settings",
                        Description = "Opens the Bloxstrap Settings window.",
                        TypeMeta = {
                            ActionName = "Edit",

                            OnClick = function(u42) -- Line: 2696, Name: OnClick
                                -- upvalues: BloxstrapRPC (copy)
                                local BloxstrapSettings = u42.ui.SubStates.BloxstrapSettings;

                                if BloxstrapSettings:GetAttribute("Debounce") then
                                    return;
                                end;

                                u42:setSubmenuState(true);
                                BloxstrapRPC.CheckWindowPermission();
                                BloxstrapSettings.Visible = true;
                                BloxstrapSettings:TweenPosition(UDim2.fromScale(0.5, 0.5), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.6, true);
                                BloxstrapSettings.Close.MouseButton1Click:Once(function() -- Line: 2706
                                    -- upvalues: u42 (copy), BloxstrapSettings (copy)
                                    u42:setSubmenuState(false);
                                    BloxstrapSettings:SetAttribute("Debounce", true);
                                    BloxstrapSettings:TweenPosition(UDim2.fromScale(0.5, -1), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.6, true);
                                    task.delay(0.6, function() -- Line: 2711
                                        -- upvalues: BloxstrapSettings (ref)
                                        BloxstrapSettings:SetAttribute("Debounce", nil);
                                        BloxstrapSettings.Visible = false;
                                    end);
                                end);
                            end
                        }
                    }
                }
            },
            {
                Name = "Medal Settings",
                Icon = "rbxassetid://16360842205",
                Items = { {
                        Index = "MedalAutoclip",
                        Type = "Bool",
                        DisplayName = "Autoclip Scores",
                        Description = "Automatically clips your run if you have Medal running."
                    }, {
                        Index = "MedalAutoclipFull",
                        Type = "Bool",
                        DisplayName = "Clip Entire Song",
                        Description = "Clips the whole song instead of just the last 30 seconds."
                    }, {
                        Index = "MedalAutoclipReq",
                        Type = "Dropdown",
                        DisplayName = "Autoclip Requirements",
                        Description = "Sets the minimum result, from Clear up to MFC, needed for a clip to actually save.",
                        TypeMeta = {
                            Options = { "Clear", "FC", "GFC", "PFC", "MFC" }
                        }
                    } }
            },
            {
                Name = "Other",
                Items = { {
                        Index = "ScagJPT",
                        Type = "Bool",
                        DisplayName = "ScagJPT Integration",
                        Description = "Lets ScagJPT comment on your gameplay live."
                    } }
            }
        }
    },
    v34,
    {
        Name = "Custom Tag",
        Icon = "rbxassetid://16360842205",
        Prefix = "Staff",
        ShortPrefix = "S",
        PrefixColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 119, 0)) }),

        Visible = function() -- Line: 2824, Name: Visible
            -- upvalues: PlayerRanks (copy)
            return PlayerRanks:GetRank() >= 248;
        end,

        Items = {
            {
                Prefix = "Developer",
                ShortPrefix = "DEV",
                Name = "Custom Rank Tag",
                PrefixColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 166, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 153, 255)) }),

                Visible = function() -- Line: 2834, Name: Visible
                    -- upvalues: PlayerRanks (copy)
                    return PlayerRanks:isDev();
                end,

                Items = { {
                        Index = "CustomDevRankTag",
                        Type = "Dropdown",
                        DisplayName = "Custom Rank Tag",
                        Description = "Sets the rank tag shown next to your name, from the available presets.",
                        TypeMeta = {
                            Options = { "None", "Content Creator", "Mod Creator", "Tester", "Translator", "Contributor", "Contractor", "Staff", "Head Staff" }
                        }
                    } }
            },
            {
                Prefix = "Staff",
                ShortPrefix = "S",
                IndexPrefix = "CustomTagData",
                Name = "Custom Staff Tag",
                PrefixColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 119, 0)) }),
                Items = {
                    {
                        Index = "ShowCustomDevTag",
                        Type = "Bool",
                        DisplayName = "Show Custom Tag",
                        Description = "Shows your custom staff tag next to your name."
                    },
                    {
                        Type = "Action",
                        DisplayName = "Open Tag Editor",
                        Description = "Opens the tag editor, where you can customize your tag\'s icon and banner.",
                        TypeMeta = {
                            ActionName = "Open",

                            OnClick = function(u43) -- Line: 2882, Name: OnClick
                                local TagEditor = u43.ui.SubStates.TagEditor;

                                if TagEditor:GetAttribute("Debounce") then
                                    return;
                                end;

                                u43:setSubmenuState(true);
                                TagEditor:SetAttribute("Running", true);
                                TagEditor.Visible = true;
                                TagEditor:TweenPosition(UDim2.fromScale(0.5, 0.5), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.6, true);
                                TagEditor.BackButton.Toggle.MouseButton1Click:Once(function() -- Line: 2892
                                    -- upvalues: u43 (copy), TagEditor (copy)
                                    u43:setSubmenuState(false);
                                    TagEditor:SetAttribute("Debounce", true);
                                    task.delay(0.6, function() -- Line: 2896
                                        -- upvalues: TagEditor (ref)
                                        TagEditor:SetAttribute("Running", false);
                                        TagEditor:SetAttribute("Debounce", false);
                                        TagEditor.Visible = false;
                                    end);
                                    TagEditor:TweenPosition(UDim2.fromScale(0.5, -1), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.6, true);
                                end);
                            end
                        }
                    },
                    {
                        Index = "+/Icon",
                        Type = "String",
                        DisplayName = "Custom Tag Image",
                        Description = "Sets the image used for your custom tag icon."
                    },
                    {
                        Index = "ReplaceBannerByCustom",
                        Type = "Bool",
                        DisplayName = "Use Custom Banner",
                        Description = "Replaces your default banner with a custom image."
                    },
                    {
                        Index = "CustomBannerImage",
                        Type = "String",
                        DisplayName = "Custom Banner Image",
                        Description = "Sets the image used for your custom banner.\n\nThe \"rbxassetid://\" prefix is optional but recommended. Developer early access, contributor access may open up later."
                    },
                    {
                        Index = "CustomBannerStyle",
                        Type = "Dropdown",
                        DisplayName = "Custom Banner Style",
                        Description = "Controls how your banner image is cropped, fitted, or stretched to fill its frame.",
                        TypeMeta = {
                            Options = { "Crop", "Fit", "Stretch" }
                        }
                    }
                }
            }
        }
    },
    {
        Name = "Dev Settings",
        Icon = "rbxassetid://16360842205",
        Prefix = "Developer",
        ShortPrefix = "DEV",
        PrefixColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 166, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 153, 255)) }),

        Visible = function() -- Line: 2964, Name: Visible
            -- upvalues: PlayerRanks (copy)
            return PlayerRanks:isDev();
        end,

        Items = {
            {
                Name = "Cosmetics",
                Items = { {
                        Index = "UseWaitingAnim",
                        Type = "Bool",
                        DisplayName = "Show Waiting Animation",
                        Description = "Shows a custom waiting animation.\n\nDeveloper early access."
                    }, {
                        Index = "WaitingAnim",
                        Type = "String",
                        DisplayName = "Waiting Animation",
                        Description = "Sets which animation plays while waiting.\n\nDeveloper early access, will move to the Shop once it\'s finished."
                    }, {
                        Index = "WaitingAnimPack",
                        Type = "String",
                        DisplayName = "Waiting Animation Pack",
                        Description = "Sets which pack the waiting animation is pulled from.\n\nDeveloper early access, will move to the Shop once it\'s finished."
                    } }
            },
            {
                Name = "Miscellaneous",
                Items = { {
                        Index = "FunnyMode",
                        Type = "Dropdown",
                        DisplayName = "Current Selected Funny Mode",
                        TypeMeta = {
                            Options = { "None", "UnsightreadableV2", "CarCrash", "Trampoline", "funkifything" }
                        }
                    }, {
                        Index = "ShowDeathScreen",
                        Type = "Bool",
                        DisplayName = "Show Death Screen",
                        Description = "Shows the death screen when you fail."
                    }, {
                        Index = "UseWorldSpaceRatings",
                        Type = "Bool",
                        DisplayName = "Move Ratings to Stage",
                        Description = "Positions judgements in the 3D world near the stage instead of on the 2D HUD."
                    }, {
                        Index = "UseAlbums",
                        Type = "Bool",
                        DisplayName = "Swap Song Select Icons for Albums",
                        Description = "Replaces song icons with album art on the song select screen."
                    } }
            },
            {
                Name = "Debugging",
                Items = { {
                        Index = "FunnyDebugMode",
                        Type = "Bool",
                        DisplayName = "Debug Mode",
                        Description = "Turns on internal debug tooling."
                    }, {
                        Index = "ShowBloxstrapDebug",
                        Type = "Bool",
                        DisplayName = "Show Bloxstrap Debug Overlay",
                        Description = "Shows Bloxstrap\'s debug overlay."
                    }, {
                        Index = "DebugPrint",
                        Type = "Bool",
                        DisplayName = "Show Debug Prints",
                        Description = "Prints general debug info to the console."
                    }, {
                        Index = "PrintIncomingSignals",
                        Type = "Bool",
                        DisplayName = "Show Incoming Signal Prints",
                        Description = "Prints almost every incoming signal.\n\nCan flood the console, use at your own risk."
                    }, {
                        Index = "PrintOutgoingSignals",
                        Type = "Bool",
                        DisplayName = "Show Outgoing Signal Prints",
                        Description = "Prints almost every outgoing signal.\n\nCan flood the console, use at your own risk."
                    } }
            },
            {
                Name = "Disguise",
                Items = { {
                        Index = "DisguisedName",
                        Type = "String",
                        DisplayName = "Disguised Username",
                        Description = "Replaces your username on the leaderboard and overhead."
                    }, {
                        Index = "DisguisedVerified",
                        Type = "Bool",
                        DisplayName = "Toggle Verified Badge",
                        Description = "Flips your verified badge state, regardless of whether you actually have one.\n\nIf you have the badge, turning this on hides it in chat and on the leaderboard. If you don\'t have it, turning this on adds it instead."
                    }, {
                        Index = "DisguisedDisplayName",
                        Type = "String",
                        DisplayName = "Disguised Display Name",
                        Description = "Replaces your display name on the leaderboard and overhead."
                    } }
            },
            {
                Name = "Botplay",
                Items = { {
                        Index = "AutomaticBotplay",
                        Type = "Bool",
                        DisplayName = "Botplay On By Default",
                        Description = "Turns botplay on automatically at the start of every song."
                    }, {
                        Index = "UseOttoBotplay",
                        Type = "Bool",
                        DisplayName = "Show Otto (Replaces Label)",
                        Description = "Replaces the botplay label with Otto."
                    }, {
                        Index = "ShowcaseMode",
                        Type = "Bool",
                        DisplayName = "Showcase Mode",
                        Description = "Turns on botplay and hides all UI, meant for showcase recordings."
                    }, {
                        Index = "ShowBotplay",
                        Type = "Bool",
                        DisplayName = "Show Botplay Label",
                        Description = "Shows the botplay label during gameplay."
                    } }
            }
        }
    },
    {
        Prefix = "Studio Only",
        ShortPrefix = "STUDIO",
        Name = "Component Test",
        PrefixColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255)) }),

        Visible = function() -- Line: 3172, Name: Visible
            return game:GetService("RunService"):IsStudio();
        end,

        Items = {
            {
                Index = "ShowOpponentOnMiddlescroll",
                Type = "Dropdown",
                DisplayName = "Long Name Test, aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                Description = "Bound to the show opponent notes on middlescroll value, sorry guys, no fun allowed.",
                TypeMeta = {
                    Options = { "Bloxxin", "FNF", "FNF (Legacy)", "None", ".EXE", "MCM", "Hood", "Kade Engine", "FF", "Project Blossom", "OURPLE GUY", "Kreadian Funk", "Squishy", "67 🤚💀🤚" }
                }
            },
            {
                Index = "ShowOpponentOnMiddlescroll",
                Type = "Dropdown",
                DisplayName = "Another test setting",
                Description = "yed guy, also known by real name dave peterson is the vloo version of prange guy. dave resembles a cop with an orange tang color. he is seen with a stern face and wields a saxophone. he is seen in front of ned\'s pizza parlor, owned by vloo guy (victor anton) and hank (last name pending).\n(taken from funkipedia)\nnate is the character you play as in vloo guy. like brooke, nate is more sensitive and more anxiety wrecked than bf, bf is more idiotic and kinda goes with whatever but nate is very aware and nervous about everything.",
                TypeMeta = {
                    Options = { "SSD Slot 3", "Abandoned - MARIO MADNESS OST", "Age Checks to Access Chat, Studio Team Create, and Links on Roblox", "67 🤚💀🤚" }
                }
            }
        }
    }
};