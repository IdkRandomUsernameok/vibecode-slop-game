-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage:WaitForChild("Modules").ModData.Difficulties);
require(ReplicatedStorage:WaitForChild("Modules").ModData:WaitForChild("Difficulties"));
local v1 = {};

for _, v in require(ReplicatedStorage:WaitForChild("Modules").ModData.Difficulties).DifficultyOrder do
    if not v1[v] then
        v1[v] = v;
    end;
end;

local v2 = {};

for _, child in ReplicatedStorage:WaitForChild("Modules").Engine.VSRG.GameplayModifiers:GetChildren() do
    if child:GetAttribute("CanBeUsed") and not v2[child.Name] then
        v2[child.Name] = {
            Name = child:GetAttribute("Name"),
            Description = child:GetAttribute("Description")
        };
    end;
end;

return {
    Toggles = {
        On = "On",
        Off = "Off"
    },
    Sides = {
        Left = "Left",
        Right = "Right"
    },
    StrumDirections = {
        Left = "Left",
        Down = "Down",
        Up = "Up",
        Right = "Right",
        Square = "Square",
        Left2 = "Left2",
        Down2 = "Down2",
        Up2 = "Up2",
        Right2 = "Right2",
        rLeft = "rLeft",
        rDown = "rDown",
        rUp = "rUp",
        rRight = "rRight",
        Plus = "Plus",
        rLeft2 = "rLeft2",
        rDown2 = "rDown2",
        rUp2 = "rUp2",
        rRight2 = "rRight2"
    },
    RPC = {
        NowPlayingCensored = "Now playing a song! - [{playbackRate}x]",
        NowPlaying = "Now Playing: {songName} [{diffName}] - [{playbackRate}x]",
        PlayingCensored = "Playing a song! - [{playbackRate}x]",
        Playing = "Playing: {songName} [{diffName}] - [{playbackRate}x]",
        InGame = "In game"
    },
    RatingStyles = {
        HL024 = {
            Whoops = "Whoops..",
            Marvelous = "Marvelous!!!",
            Sick = "Sick!",
            Great = "Great!",
            Nice = "Nice!",
            Good = "Good!",
            NotBad = "Not bad",
            OK = "OK"
        }
    },
    HUD = {
        JudgementCounter = "Marvelous: {Marvelous}\nSick: {Sick}\nGood: {Good}\nOkay: {Ok}\nBad: {Bad}",
        Marvelous = "Marvelous",
        Sick = "Sick",
        Good = "Good",
        Ok = "Okay",
        Bad = "Bad",
        Miss = "Miss",
        ExtraInfo = "MA: {ma}\nPA: {pa}\nMS: {mean}ms",
        PerfDisplay = "FPS: {fps}\nMemory: {mem}",
        DebugDisplay = "Step: {step}\nBeat: {beat}\nSection: {measure}\nSignature: {stepsPerBeat}/{beatsPerMeasure}\n\nBPM: {bpm}\nTime: {timePos}\nNotes: {noteCache}+{splashCache}",
        ScoreLabelFormats = {
            Default = "Score: {score} | Misses: {miss} | Accuracy: {acc}% ({judgement})",
            BaseGame = "Score: {score}",
            BaseGameNoOffset = "Score: {score}",
            BaseGameOMORI = "Score: {score}",
            BaseGameWithHPColor = "Score: {score}",
            BaseGameWithTimer = "Score: {score}",
            Corruption = "Score: {score}",
            DeadAir = "Score: {score}",
            EXEFightOrFlight = "Sacrifices: {miss} | Accuracy: {acc}% [{judgement}]",
            FunkinHELL = "Score: {score} | Rating: ({acc}%) - [{judgement}]",
            MariosMadness = "SCORE: {score}      MISSES: {miss}      RATING: {judgement} [{acc}%]",
            MariosMadnessGB = "SCORE: {score}      MISSES: {miss}      RATING: {judgement} [{acc}%]",
            MariosMadnessLuigi = "SCORE: {score}      MISSES: {miss}      RATING: {judgement} [{acc}%]",
            RetrospecterNormal = "Score: {score} - Accuracy: {acc}% [{judgement}] - Combo Breaks: {miss} - Combo: {combo}",
            RetrospecterCorrupt = "Score: {score} - Accuracy: {acc}% [{judgement}] - Combo Breaks: {miss} - Combo: {combo}",
            LSE_Normal = "Score: {score} - Rating: {acc}% [{judgement}] - Combo Breaks: {miss} - Combo: {combo}",
            LSE_DW = "Score: {score} - Rating: {acc}% [{judgement}] - Combo Breaks: {miss} - Combo: {combo}",
            Forever = "Score: {score} • Accuracy: {acc}% [{judgement}] • Combo Breaks: {miss} • Combo: {combo}",
            Brimstone = "Score: {score} • Accuracy: {acc}% [{judgement}] • Combo Breaks: {miss} • Combo: {combo}",
            KadeEngine = "Score:{score} | Combo Breaks:{miss} | Accuracy:{acc}% | ({judgement})",
            ProjectBlossom = "Score:{score} | Misses:{miss} | Accuracy:{acc} % | ({judgement})",
            DDTO = "Score: {score} | Breaks: {miss} | Rating: {judgement} ({acc}%)",
            DDTOSTAGNANT = "Worth: {score} | Failures: {miss} | Will Power: {acc}%",
            Troubleshootin = "SCORE: {score} | MISSES: {miss} | ACCURACY: {acc}% [{judgement}]"
        }
    },
    Judgements = {
        FC = "FC",
        GFC = "GFC",
        MFC = "MFC",
        PFC = "PFC",
        SDP = "SDP",
        WF = "WF",
        BF = "BF",
        SDG = "SDG",
        SDO = "SDO",
        SDB = "SDB",
        MF = "MF",
        SDCB = "SDCB",
        CLEAR = "CLEAR"
    },
    Gameplay = {
        Loading = {
            SoloMatch = "Solo Match",
            MultiplayerMatch = "{LCount}v{RCount} Multiplayer Match",
            ChartParsing = "Parsing Chart...",
            ModchartLoading = "Adding modcharts...",
            ChartLoading = "Loading chart...",
            SettingsLoading = "Applying settings...",
            AudioParsing = "Creating audios...",
            CharacterCreating = "Creating characters...",
            BotCreating = "Creating bot character...",
            EmoteCharCreating = "Creating speaker character...",
            MapLoading = "Processing maps...",
            AudioCaching = "Preloading Audios...",
            ModchartStart = "Initializing song content...",
            SingleplayerWaiting = "Waiting for server...",
            OtherPlayersWaiting = "Waiting for other players..."
        }
    },
    CreditsReplacements = {
        BGBy = "Background by",
        BGsBy = "Backgrounds by",
        ChartedBy = "Charted by",
        ChartBy = "Chart by",
        IconBy = "Icon by",
        IconsBy = "Icons By",
        AnimBy = "Animation by",
        AnimsBy = "Animations by",
        FacesBy = "Faces by",
        ModelBy = "Model by",
        ModelsBy = "Models by",
        SongBy = "Song by"
    },
    SongSelect = {
        CreditsHeader = "Credits",
        HighscoreHeader = "Highscore",
        SongStatsHeader = "Song Stats",
        DiffsHeader = "Difficulties",
        ModifiersHeader = "Modifiers",
        SongRatesHeader = "Song Rates",
        SongModifiersHeader = "Song Modifiers",
        OtherVotesHeader = "Other Player Votes",
        ModifiersApplyButton = "Apply",
        ModifiersClearButton = "Clear Modifiers",
        PrefixReplacements = {
            NEW = "NEW",
            UPDATED = "UPDATED",
            INDEV = "INDEV",
            COLLAB = "COLLAB"
        },
        SongSettings = {
            Rates = "Rates",
            CurrentRate = "Current rate",
            PitchAudio = "Pitch audio",
            Modcharts = "Modcharts",
            Gimmicks = "Special notes",
            Modifiers = "GP Modifiers",
            Timing = "Timing (1-9)"
        },
        NothingSelected = "Select a song first!",
        SongStatsNoSelect = "Select a difficulty!",
        NoResultsFound = "No results found!",
        XResultsFound = "{resultAmmo:int} results found!",
        SearchModsPlaceholder = "Search for mods...",
        SearchSongsPlaceholder = "Search for songs...",
        PlayButton = "Play",
        SkipVoteButton = "Skip Vote",
        CreditsBy = "By: {creatorName}",
        CreditsFallback = "No credits found...\nThose who credit 💀",
        CreditsFallbackAlt = "Credits are not available!\n\nHave a 🐇 instead.",
        CreditsFallbackAnotherAlt = "Missing credits! Have a bnuy 🐇",
        UnknownModifier = "Unknown Modifier",
        ModifierNoDesc = "No description",
        TimeLeft = "Time Left For Selection: {timeLeft:int}",
        VoteSkipped = "Skipped!",
        OtherVotesNone = "None",
        MadeBy = "Made by {creatorName}",
        AlsoCheckOut = "Also check out...",
        FailedCreator = "Couldn\'t get creator!",
        FailedName = "Couldn\'t get name!",
        OldHighscoreStat = "(This stat is from a version previous to U1, only FC data was tracked regardless of difficulty)",
        HighscoreScore = "Score: {score:int}",
        HighscoreAccuracy = "Accuracy: {acc}%",
        HighscoreMisses = "Misses: {misses:int}",
        HighscoreNotPlayed = "NOT PLAYED",
        SongInfo = {
            BPM = "BPM: {bpm}",
            Keycount = "Keycount: {keycount}",
            Difficulty = "Difficulty: {rating}",
            Events = "Has events: {hasEvents}",
            Gimmicks = "Has special notes: {hasGimmicks}",
            Modchart = "Has modchart: {hasModchart}",
            Map = "Has map: {hasMap}",
            Length = "Song Length: {timeLength}"
        },
        Stats = {
            PFCs = "PFCs: {count:int}",
            MFCs = "MFCs: {count:int}",
            GFCs = "GFCs: {count:int}",
            FCs = "FCs: {count:int} (U: {uniqueCount:int})",
            Wins = "Wins: {count:int}",
            Losses = "Losses: {count:int}",
            TotalPlayed = "Played: {count:int}"
        }
    },
    IconEditor = {
        TextBeingFiltered = "Filtering...",
        IconNamePlaceholder = "cool icon",
        SettingNames = {
            ImageId = "Image ID",
            IconCount = "Icon Count",
            Alpha = "Alpha",
            Offset = "Offset",
            Color = "Color",
            Scale = "Scale",
            IconSize = "Icon Size",
            Facing = "Facing",
            AutoFlip = "Automatically Flip",
            Antialiasing = "Antialiasing",
            ShowBounds = "Show Rect Bounds",
            EditColor = "Edit"
        },
        IconAnims = {
            Overwinning = "Overwinning",
            Winning = "Winning",
            Idle = "Idle",
            Losing = "Losing",
            Overlosing = "Overlosing"
        },
        Headers = {
            IconName = "Icon Name",
            Animations = "Animations",
            PreviewSide = "Preview Side"
        },
        SideFacing = {
            GameplayLeft = "Dad (Left)",
            GameplayRight = "BF (Right)",
            TextureLeft = "Left (BF Icon)",
            TextureRight = "Right (Dad Icon)"
        },
        Toolbar = {
            Cancel = "Cancel",
            Undo = "Undo Changes",
            Save = "Save"
        }
    },
    NoteskinOverrides = {
        ReplaceNoteskin = "Replace Noteskin for Strum",
        ReplaceHoldsplash = "Replace Holdsplash for Strum",
        ReplaceNotesplash = "Replace Notesplash for Strum",
        ReplacingSelectedNoteskin = "Replacing: {strumName} [Equipped Noteskin]",
        ReplacingSelectedHoldsplash = "Replacing: {strumName} [Equipped Holdsplash]",
        ReplacingSelectedNotesplash = "Replacing: {strumName} [Equipped Notesplash]",
        ReplacingSelectedSkinName = "Replacing: {strumName} [{skinName}]",
        ReplacingSelectedNone = "Replacing: None",
        ReplacingWith = "With: {skinName}",
        ReplacingWithNoneNoteskin = "With: None (Select a Noteskin!)",
        ReplacingWithNoneHoldsplash = "With: None (Select a Holdsplash!)",
        ReplacingWithNoneNotesplash = "With: None (Select a Notesplash!)",
        StrumCategories = {
            All = "All",
            Default = "Arrows",
            Alts = "Arrows (Alt)",
            Boosts = "Boosts",
            BoostsAlt = "Boosts (Alt)",
            Specials = "Specials"
        },
        Helper = {
            MainHeader = "\'What is this?\'",
            SubText = "This is the noteskin replacement menu, here, instead of having the same noteskin on every single strum, you can make a strum load with a different skin.",
            SubText2 = "Select a noteskin on the left menu, click the strum you wanna to apply it on and click \'Replace\'!",
            SubHeader = "Replacing for 4K,5K,... only",
            SubTextForHeader = "You can also just replace it on a single key by selecting it on the dropdown located next to the close button",
            SubText2ForHeader = "The \'Global\' set in the dropdown (The one selected by default) replaces a noteskin on every key set, however, the data in the other sets is unafected, it just has a higher priority than the others (A replaced left strum in global will load instead of a replaced left strum in 4K)",
            SubHeader2 = "What does a dotted sprite mean?",
            SubTextForHeader2 = "A dotted sprite means that the strum doesn\'t have a noteskin replacing it and will load the equipped noteskin"
        },
        Toolbar = {
            ClearAll = "Clear All",
            ClearSelected = "Clear Selected",
            Replace = "Replace"
        }
    },
    Shop = {
        PackItem = "{packName} (Pack)",
        CreditsBy = "By: {creatorName}",
        UnlockedDefault = "Unlocked by default.",
        SearchFor = "Search for...",
        SelectPackForInfo = "[CLICK ON A PACK TO VIEW MORE]",
        RequirementsJoin = "{song1}, {song2}",
        RequirementsJoinEnding = "{song1} or {song2}",
        AnySongRequirement = "any song",
        AnyModRequirement = "any mod",
        AnyDiffRequirement = "any difficulty",
        UnlockRequirement = "Beat {songList} from {modList} on {difficultyList}.",
        ExtraRequirement = "{accuracyNeeded:int}% accuracy, 1x or higher rate, modcharts & special notes enabled",
        DailyUnlockRequirement = "Unlocked randomly from any daily quest.",
        BadgeUnlockRequirement = "Unlocked with the {badgeName} badge in {gameName}.",
        UnselectedItemTitle = "?",
        UnselectedItemCredits = "By: ?",
        UnlockCriteria = "Unlock Criteria",
        AnimHasAlts = "Alt Animations • {hasState}",
        AnimHasEvents = "Event Animations • {hasState}",
        NewItemStandout = "NEW",
        UpdatedItemStandout = "UPDATED",
        EquipItem = "EQUIP",
        EquippedItem = "EQUIPPED",
        BotEquipItem = "EQUIP (BOT)",
        BotEquippedItem = "EQUIPPED (BOT)",
        LockedItem = "LOCKED",
        AnimationSettings = {
            PreviewHeader = "Animation Preview",
            PreviewSide = "Preview Side",
            PreviewAlt = "Preview Alt",
            Rotation = "Rotation",
            SettingsHeader = "Animation Settings",
            UseReqProps = "Use Req. Props",
            UseProps = "Use Props",
            UseFaces = "Use Faces"
        },
        Tabs = {
            Animations = "Animations",
            Emotes = "Emotes",
            Noteskins = "Noteskins",
            Notesplashes = "Notesplashes",
            Holdsplashes = "Holdsplashes",
            Icons = "Icons",
            Tags = "Tags",
            Banners = "Banners"
        },
        SpecialUnlockRequirements = {
            Gambler = "Randomly obtained when finishing a song with a 0.1% chance."
        }
    },
    Topbar = {
        Settings = "Settings",
        Shop = "Shop"
    },
    Difficulties = v1,
    Modifiers = v2,
    __TranslationsContext = {
        Shop_RequirementsJoin = "The pattern used for merging something to display in the unlock criteria, this means that for example, \'Beat #Silly Billy, Endless# or Bite\', silly billy is song1 and endless is song2",
        Shop_RequirementsJoinEnding = "The pattern used for merging something to display in the unlock criteria, this means that for example, \'Beat Silly Billy, #Endless or Bite#\', endless is song1 and bite is song2",
        Shop_AnySongRequirement = "Used for when there\'s no list to add in the unlock requirement string, \'Beat #any song# from...\' instead of \'Beat songList from...\'",
        Shop_AnyModRequirement = "Used for when there\'s no list to add in the unlock requirement string, \'Beat #any song# from...\' instead of \'Beat songList from...\'",
        Shop_AnyDiffRequirement = "Used for when there\'s no list to add in the unlock requirement string, \'Beat #any song# from...\' instead of \'Beat songList from...\'",
        IconEditor_IconNamePlaceholder = "It\'s called a placeholder because its the text that shows when the textbox is empty, should be translated too, preferably same length instead of actual translation"
    }
};