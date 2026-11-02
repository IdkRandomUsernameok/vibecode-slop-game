-- Decompiled with Potassium's decompiler.

repeat
    task.wait();
until game:IsLoaded();

local u1 = {
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    TweenService = game:GetService("TweenService"),
    Players = game:GetService("Players"),
    UserInput = game:GetService("UserInputService"),
    Stats = game:GetService("Stats"),
    RunService = game:GetService("RunService"),
    Debris = game:GetService("Debris"),
    Lighting = game:GetService("Lighting"),
    HttpService = game:GetService("HttpService"),
    TextChatService = game:GetService("TextChatService"),
    StarterGui = game:GetService("StarterGui"),
    ContextAction = game:GetService("ContextActionService"),
    CollectionService = game:GetService("CollectionService"),
    GuiService = game:GetService("GuiService"),
    ContentProvider = game:GetService("ContentProvider"),
    Haptics = game:GetService("HapticService"),
    AssetService = game:GetService("AssetService"),
    LogService = game:GetService("LogService")
};
local LocalPlayer = u1.Players.LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Assets = Modules:WaitForChild("Assets");
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local Main = PlayerGui:WaitForChild("Main");
local Music = Main:WaitForChild("Music");
Assets:WaitForChild("Sounds");
local u2 = {
    ScriptPack = require(Modules.Main.ScriptPack),
    Translator = require(Modules.Main.Translator),
    sprite = require(Modules.Main.Sprite),
    Conductor = require(Modules.Main.Conductor),
    Cache = require(Modules.Main.CacheService),
    varTweener = require(Modules.Main.VarTweener),
    Note = require(Modules.Main.Note),
    RGBSprite = require(Modules.Main.RGBSprite),
    Icons = require(Modules.Main.Icon),
    IconsV2 = require(Modules.Main.IconV2),
    ratingModule = require(Modules.Main.Ratings),
    CharacterModule = require(Modules.Main.Character),
    CharReplicator = require(Modules.Main.CharacterReplicator),
    AssetReplicator = require(Modules.Main.AssetReplicator),
    DeviceManager = require(Modules.Main.DeviceManager),
    MapService = require(Modules.Main.MapService),
    PlayerControls = require(Modules.Main.PlayerControls),
    Results = require(Modules.UI.ResultsRework),
    SongSelect = require(Modules.UI.SongSelectV2),
    LoadingScreen = require(Modules.UI.Loading),
    Topbar = require(Modules.UI.TopbarIcon),
    SignalHandler = require(Modules.Lib.Signal),
    FlxVel = require(Modules.Lib.FlxVel),
    AppearanceManager = require(Modules.Other.AppearanceManager),
    EasingStyles = require(Modules.Other.Easings),
    SRTParser = require(Modules.Other.SRTParser),
    LRCParser = require(Modules.Other.LRCParser),
    RBXOptis = require(Modules.Other.RBXOptimizations),
    StageZones = require(Modules.Other.StageZones),
    PlayerRanks = require(Modules.Other.PlayerRanks),
    TimeFunctions = require(Modules.Other.TimeFunctions),
    MathFuncs = require(Modules.Other.MathFuncs),
    Adapters = require(Modules.Other.Adapters),
    ExperimentalFeatures = require(Modules.Other.ExperimentalFeatures),
    MedalClipping = require(Modules.Other.MedalClipping),
    SoundPlayer = require(Modules.Audio.SoundPlayer),
    SongPlayer = require(Modules.Audio.SongPlayer),
    Visualizer = require(Modules.Audio.Visualizer),
    SoundLibrary = require(Modules.Audio.SoundLib),
    DiscordRPC = require(Modules.Engine.BloxstrapRPC),
    EngineVersion = require(Modules.Engine.EngineVersion),
    NetworkFunctions = require(Modules.Engine.NetworkFunctions),
    Strum = require(Modules.Engine.VSRG.Strum),
    LaneBG = require(Modules.Engine.VSRG.LaneBG),
    HoldSplash = require(Modules.Engine.VSRG.HoldSplash),
    NoteSplash = require(Modules.Engine.VSRG.NoteSplash),
    ChartFixing = require(Modules.Engine.VSRG.ChartFixing),
    Strumline = require(Modules.Engine.VSRG.Strumline),
    LocalSignals = require(Modules.Signals.LocalSignals),
    Events = require(Modules.ModData.Events),
    songIds = require(Modules.ModData.Songs),
    RBX_PlayerModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")),
    SharedValues = require(Modules.Engine.SharedValues),
    coreCall = require(Modules.Other.CoreCall),
    Logger = require(Modules.Other.Logger)
};
require(Modules.Types);
local u3 = {
    HUDClass = require(Modules.Customization.HUD.BaseHUD),
    iconBops = require(Modules.Customization.IconBops),
    cameraBops = require(Modules.Customization.CameraBops),
    ratingMethods = require(Modules.Customization.RatingStyles),
    RatingManager = require(Modules.Customization.RatingManager)
};
local ManiaData = require(Modules.Engine.VSRG.ManiaData);
local DataManager = require(Modules.Data.DataManager);
local Data = DataManager:GetData();
local u4 = Data;
local _Gameplay = u2.Translator.new("_Gameplay", { "Judgements", "Difficulties", "Gameplay", "HUD", "RPC" });
useRGBNotes = true;
local u5 = nil;
local success, _ = pcall(function() -- Line: 146
    -- upvalues: u5 (ref), u1 (copy)
    u5 = u1.AssetService:CreateEditableImage({
        Size = Vector2.one
    });
    u5:ReadPixelsBuffer(Vector2.zero, Vector2.one);
end);

if not success and LocalPlayer.Name ~= "Adrigamer278YT" then
    useRGBNotes = false;
    u2.Logger.warn("Editable images are disabled!");
end;

if u5 then
    u5:Destroy();
end;

u2.SoundLibrary:Cache({ "SongSelect/FavoriteRemoved", "SongSelect/FavoriteAdded", "Gameplay/MissNote1", "Gameplay/MissNote2", "Gameplay/MissNote3", "Gameplay/PlayerHitSound" });
local u6 = {};

function setObjPropWithIndex(p7, p8, p9, p10)
    -- upvalues: u6 (copy)
    if u6[p10] == p9 then
        return;
    end;

    u6[p10] = p9;
    p7[p8] = p9;
end;

function clearCachedProps()
    -- upvalues: u6 (copy)
    table.clear(u6);
end;

function getObjProp(p11)
    -- upvalues: u6 (copy)
    return u6[p11];
end;

function deepcopy(p12, p13)
    local v14 = p13 or {};

    if type(p12) ~= "table" then
        return p12;
    end;

    if v14[p12] then
        return v14[p12];
    end;

    local v15 = {};
    v14[p12] = v15;

    for i, v in next, p12 do
        v15[deepcopy(i, v14)] = deepcopy(v, v14);
    end;

    local l_deepcopy = deepcopy;
    local v16 = getmetatable(p12);
    setmetatable(v15, l_deepcopy(v16, v14));

    return v15;
end;

function compareTable(p17: table, p18: table)
    if #p17 ~= #p18 then
        return false;
    end;

    local v19 = true;

    for i = 1, #p17 do
        v19 = v19 and p17[i] == p18[i] and true or false;

        if not v19 then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

local u20 = {};

function newTrackedTable(p21)
    -- upvalues: u20 (copy)
    local v22 = p21 or {};
    table.insert(u20, v22);

    return v22;
end;

function clearAllTrackedTables()
    -- upvalues: u20 (copy)
    for _, v in u20 do
        table.clear(v);
    end;
end;

local BindableEvent = Instance.new("BindableEvent");
local u23 = {
    loadedSong = false,
    inSong = false,
    inSongSelect = false,
    updateMotions = {}
};
local u24 = {
    useModcharts = true,
    useGimmicks = true,
    judgementScaling = 4,
    showCountdown = true,
    skipCountdown = false,
    dontStartSong = false,
    skipNowPlaying = false,
    noteSpawnTime = 1.75,
    reverseNotes = false,
    simpleSustains = true,
    useSliders = false,
    curModifiers = {}
};
setmetatable(u23, {
    __index = function(p25, p26) -- Line: 270, Name: __index
        -- upvalues: u24 (copy)
        if p26 == "noteSpawnTime" then
            return u24.noteSpawnTime;
        end;

        if p26 == "reverseNotes" then
            return u24.reverseNotes;
        end;

        if p26 == "doSimpleSustains" then
            return u24.simpleSustains;
        end;

        return nil;
    end,

    __newindex = function(p27, p28, p29) -- Line: 276, Name: __newindex
        -- upvalues: u24 (copy)
        if p28 == "noteSpawnTime" then
            u24.noteSpawnTime = p29;
        end;

        if p28 == "reverseNotes" then
            u24.reverseNotes = p29;
        end;

        if p28 == "doSimpleSustains" then
            u24.simpleSustains = p29;
        end;
    end
});
local u30 = nil;
local u31 = nil;
local u32 = {};
local u33 = {};
local u34 = {};
local u35 = {};
local u36 = "R";

function setSongData(p37, p38)
    -- upvalues: DataManager (copy)
    DataManager:SetData("SaveData/" .. p37, p38);
end;

function getSongData(p39)
    -- upvalues: DataManager (copy)
    local Data2 = DataManager:GetData();

    return DataManager.getByPath(Data2, "SaveData/" .. p39);
end;

function showError(p40, p41, p42, p43)
    -- upvalues: u2 (copy), u36 (ref), u35 (ref), LocalPlayer (copy)
    u2.LocalSignals.SetNotificationSide:Fire(u36);
    local v44 = "";

    if p42 ~= nil then
        local string_split_ret = string.split(p42, "\n");

        if string_split_ret[1] ~= nil then
            v44 = v44 .. string_split_ret[1] .. "\n";
        end;

        if string_split_ret[2] ~= nil then
            v44 = v44 .. string_split_ret[2] .. "\n";
        end;

        if string_split_ret[3] ~= nil then
            v44 = v44 .. string_split_ret[3] .. "\n";
        end;

        if string_split_ret[4] ~= nil then
            v44 = v44 .. string_split_ret[4] .. "\n";
        end;
    end;

    u2.LocalSignals.SendNotification:Fire({
        contentHiddenByDefault = true,
        timeout = 5,
        header = `[AFTERNIGHT {p40} ERROR] {u35.SongFile and `SONG: {u35.SongFile.Name} ({u35.Difficulty}` or ""})`,
        content = `\nSTEP: {u2.Conductor.Step}, BEAT: {u2.Conductor.Beat}, USERID: {LocalPlayer.UserId}\nERROR: {p41}\n\n{v44}\n{p43 or "PLEASE REPORT THIS TO THE DEVELOPERS"}`,
        color = Color3.new(1, 0.360784, 0.372549)
    });
    local v45 = `[{p40} ERROR] {u35.SongFile and `SONG: {u35.SongFile.Name} ({u35.Difficulty}` or ""})\nSTEP: {u2.Conductor.Step}, BEAT: {u2.Conductor.Beat}, USERID: {LocalPlayer.UserId}\nERROR: {p41}\n\n{v44}\n{p43 or "PLEASE REPORT THIS TO THE DEVELOPERS"}`;
    warn(v45);
end;

function showTrace(p46, p47, p48, p49)
    -- upvalues: u2 (copy), u36 (ref)
    u2.LocalSignals.SetNotificationSide:Fire(u36);
    u2.LocalSignals.SendNotification:Fire({
        contentHiddenByDefault = false,
        timeout = 5,
        header = `{p47 or "[TRACE]"}`,
        content = `{p46}`,
        color = p49
    });

    if p48 then
        u2.Logger.log(p46);
    end;
end;

u2.SongSelect.baseUI = Main.SongSelect:Clone();
local u50 = Data.Favorites or {};
local u51 = Data.Recents or {};
local u52 = u2.SongSelect.new(Main.SongSelect);
u2.SongSelect.mainSS = u52;
u52.favoriteAdded:Connect(function(p53, p54) -- Line: 370
    -- upvalues: u50 (copy), u2 (copy)
    table.insert(u50, p53 .. "/" .. p54);
    u2.SoundLibrary:Play("SongSelect/FavoriteAdded");
end);
u52.favoriteRemoved:Connect(function(p55, p56) -- Line: 375
    -- upvalues: u50 (copy), u2 (copy)
    local table_find_ret = table.find(u50, p55 .. "/" .. p56);

    if table_find_ret then
        table.remove(u50, table_find_ret);
        u2.SoundLibrary:Play("SongSelect/FavoriteRemoved");
    end;
end);
u2.Results.favoriteToggled:Connect(function(p57, p58, p59) -- Line: 383
    -- upvalues: u50 (copy), u52 (copy), DataManager (copy)
    local v60 = p57 .. "/" .. p58;
    local table_find_ret = table.find(u50, v60);

    if p59 and not table_find_ret then
        table.insert(u50, v60);
    elseif not p59 and table_find_ret then
        table.remove(u50, table_find_ret);
    end;

    u52:setFavorites(u50);
    DataManager:SetData("Favorites", u50);
end);
u2.NetworkFunctions.listenTo("SongSelectorRecentPlay", function(p61, p62) -- Line: 397
    -- upvalues: u51 (copy), u52 (copy)
    if p61 == "" or p62 == "" then
        return;
    end;

    local v63 = p61 .. "/" .. p62;
    local table_find_ret = table.find(u51, v63);

    if table_find_ret then
        table.remove(u51, table_find_ret);
    end;

    table.insert(u51, 1, v63);

    if #u51 > 25 then
        table.remove(u51, #u51);
    end;

    u52:addRecent(p61, p62);
end);
u52.play:Connect(function(p64, p65, p66) -- Line: 410
    -- upvalues: u2 (copy), u52 (copy)
    u2.NetworkFunctions.fireServer("Play", p64, p65, p66, u52.useRates and u52.rate or nil, u52.modchartsEnabled, u52.gimmicksEnabled);
end);
u52.picked:Connect(function(p67, p68, p69) -- Line: 414
    -- upvalues: u2 (copy), u52 (copy)
    u2.NetworkFunctions.fireServer("PickSong", p67, p68, p69, u52.useRates and u52.rate or nil);
end);
u2.NetworkFunctions.listenTo("SongSelectorPick", function(p70, p71) -- Line: 418
    -- upvalues: u52 (copy)
    u52:setVote(p70, p71);
end);
local v72 = u2.NetworkFunctions.ModulesFolder.Assets.GetMods:InvokeServer();
local os_clock_ret = os.clock();
local u73 = {};
local u74 = {};
local u75 = {
    alreadyDead = false,
    gameoverLoop = nil
};
local u76 = false;
local u77 = false;

for i, v in v72.DifficultyOrder do
    u52:addDifficulty({
        name = v,
        color = v72.DifficultyData[v],
        scale = v72.DifficultyScale[v],
        order = i
    });
end;

for _, v in v72.ModOrder do
    local v78 = v72.ModData[v];

    if v78 then
        local string_lower_ret = string.lower(v78.Prefix or "");
        local v79 = false;

        if string_lower_ret:match("dev") == nil and string_lower_ret:match("indev") == nil then
            if string_lower_ret:match("updated") ~= nil or string_lower_ret:match("new") ~= nil then
                v79 = u2.EngineVersion.IsIndev() and true or v79;
            end;
        else
            v79 = true;
        end;

        if v79 then
            table.insert(u73, v);
        end;

        u52:addCategory(u52:legacyParse(v78, v));
    else
        warn("Mod is listed but data doesn\'t exist", v);
    end;
end;

u2.Logger.log((`Song select took {os.clock() - os_clock_ret}s to load assets`));
u52:setFavorites(u50);
u52:setRecents(u51);
u52:setUnavailableSongs(u74);
u52:allowRender();
u2.NetworkFunctions.listenTo("UpdateBlockedSongs", function(p80) -- Line: 464
    -- upvalues: u74 (ref), u52 (copy)
    u74 = p80;
    u52:setUnavailableSongs(u74);
end);
u2.NetworkFunctions.listenTo("UpdateReplacedIds", function(p81) -- Line: 469
    -- upvalues: u2 (copy)
    u2.SongPlayer:setIdOverrides(p81);
end);
u2.NetworkFunctions.listenTo("UpdateExperimentalFeatures", function(p82, p83) -- Line: 473
    -- upvalues: u2 (copy)
    u2.ExperimentalFeatures.List = p82 or {};
    u2.ExperimentalFeatures.AlwaysEnabled = p83 or {};
    u2.ExperimentalFeatures.Updated:Fire();
end);
local u86 = {
    ZIndex = {
        Front = 70,
        FrontNotes = 10,
        BehindStrums = 1,
        Behind = -1
    },
    fakeScore = 0,
    fakeSustainScore = 0,
    scoreMultiplier = 1,
    fakeScoreMultiplier = 1,

    getClientSettings = function() -- Line: 511
        -- upvalues: u23 (copy)
        return u23;
    end,

    setNoteSpawnTime = function(p84) -- Line: 512
        -- upvalues: u24 (copy)
        u24.noteSpawnTime = p84;
    end,

    setSimpleSustains = function(p85) -- Line: 513
        -- upvalues: u24 (copy)
        u24.simpleSustains = p85;
    end,

    debug = {},

    getCameras = function() -- Line: 516
        -- upvalues: u32 (ref)
        return u32;
    end,

    hitHaptic = Instance.new("HapticEffect")
};
u86.hitHaptic.Parent = workspace;
u86.hitHaptic.Type = Enum.HapticEffectType.UIClick;
u86.VarTweener = u2.varTweener;
local u87 = false;
local u88 = {};
local u89 = u2.ScriptPack.new();
u89:defineAliases({
    onUpdate = { "update" },
    onStart = { "onSongStart" },
    clearUp = { "onClear" },
    onLoad = { "onCreatePost" }
});
u89.onPreAdd:Connect(function(p90) -- Line: 536
    -- upvalues: u88 (copy)
    if typeof(p90) == "Instance" then
        u88[p90:GetFullName()] = true;
    end;
end);
u89.onAdd:Connect(function(p91, p92) -- Line: 542
    -- upvalues: u89 (copy), u86 (copy), u87 (ref)
    u89:singleCall(p92, "preCreate", u86, p92);

    if u87 then
        u89:singleCall(p92, "onCreate", u86);
    end;
end);
u89.onRemove:Connect(function(p93) -- Line: 550
    -- upvalues: u88 (copy)
    if typeof(p93) == "Instance" then
        u88[p93:GetFullName()] = nil;
    end;
end);
u89.onError:Connect(function(p94) -- Line: 556
    showError("MODCHART", p94, debug.traceback("", 4));
end);
local u95 = u2.ScriptPack.new();
u95.onPreAdd:Connect(function(p96) -- Line: 563
    -- upvalues: u88 (copy)
    if typeof(p96) == "Instance" then
        u88[p96:GetFullName()] = true;
    end;
end);
u95.onAdd:Connect(function(p97, p98) -- Line: 569
    -- upvalues: u95 (copy), u86 (copy)
    u95:singleCall(p98, "preCreate", u86, p98);
end);
u95.onError:Connect(function(p99) -- Line: 573
    showError("NOTE GROUP", p99, debug.traceback("", 4));
end);
u95.onRemove:Connect(function(p100) -- Line: 577
    -- upvalues: u88 (copy)
    if typeof(p100) == "Instance" then
        u88[p100:GetFullName()] = nil;
    end;
end);
local u101 = false;

function shared.getApi() -- Line: 586
    -- upvalues: u88 (copy), u101 (ref), u2 (copy), u86 (copy)
    local debug_info_ret = debug.info(2, "s");

    if not (u88[debug_info_ret] or (debug_info_ret:find("GameplayModifiers") or (debug_info_ret:find("HUD") or debug_info_ret:find("Gameplay")))) then
        u101 = true;

        if u2.EngineVersion.IsStudio() then
            u2.Logger.log("Loaded:", debug_info_ret);
        end;
    end;

    return u86;
end;

shared.getGlobals = shared.getApi;
shared.useGlobals = shared.getGlobals;
u86.customizationModules = u3;

function onDeviceChange()
end;

function updateDevice(p102)
    -- upvalues: u1 (copy)
    u1.ReplicatedStorage.Events.SetUserPlatform:FireServer(p102);
    onDeviceChange();
end;

u1.ReplicatedStorage.Events.SetUserPlatform:FireServer(u2.DeviceManager.currentDevice);
u2.DeviceManager.deviceChanged:Connect(updateDevice);

function loadLua()
    -- upvalues: u87 (ref)
    if u87 then
        return;
    end;

    u87 = true;
end;

function clearLua()
    -- upvalues: u87 (ref), u89 (copy), u95 (copy)
    u87 = false;
    u89:removeAll();
    u95:removeAll();
end;

function getLuaDebugStats()
    -- upvalues: u89 (copy), u87 (ref)
    local v103 = u89:stats();
    local v104 = u89:stats();

    return {
        Loaded = u87,
        Modcharts = v103.scripts,
        NoteGroups = v104.scripts
    };
end;

u86.getLuaDebugStats = getLuaDebugStats;
local u105 = false;
u2.LoadingScreen.TargetLocation = Main;

function enterLoadingState(p106)
    -- upvalues: u105 (ref), u2 (copy)
    if u105 then
        return;
    end;

    u105 = true;
    u2.LoadingScreen.start(p106);
end;

function leaveLoadingState()
    -- upvalues: u105 (ref), u2 (copy)
    if u105 == false then
        return;
    end;

    u105 = false;
    u2.LoadingScreen.finished();
end;

function showFailedLoad()
    -- upvalues: u2 (copy)
    u2.LoadingScreen.showFailedLoad();
end;

function setLoadingText(...)
    -- upvalues: u2 (copy)
    u2.LoadingScreen.setLoadingText(...);
end;

local Noteskins = u1.ReplicatedStorage:WaitForChild("Assets").Noteskins;
local Notesplashes = u1.ReplicatedStorage:WaitForChild("Assets").Notesplashes;
local u107 = false;
local u108 = false;
local u109 = {};
local u110 = {};
local u111 = {};
local u112 = {};
local Random_new_ret = Random.new();
local u113 = u2.SongPlayer.new(Music);
local u114 = nil;
local u115 = 1;
u86.songPlayer = u113;

function u86.getAudioInstances() -- Line: 686
    -- upvalues: u113 (copy)
    return u113:getAudios();
end;

local u116 = {};
local u117 = {};
local u118 = {};
local u119 = {};
local u120 = {};
local u121 = false;
local u122 = false;
local u123 = false;
local Vector2_new = Vector2.new;
local CFrame_new_ret = CFrame.new(0, 0, 0);
local u124 = {
    leftKeyCount = 4,
    rightKeyCount = 4,
    playerKeyCount = 4,
    opponentKeyCount = 4,
    totalKeys = 8,
    highestKey = 4,
    lowestKey = 4,
    chartPlayers = 2
};
local u125 = {};
local u126 = Data.Keybinds["4"];
local Miscellaneous = Data.Keybinds.Miscellaneous;
local PhoneCover = PlayerGui:WaitForChild("PhoneCover");
local FullScreenSize = PlayerGui:WaitForChild("FullScreenSize");
local u127 = {};
local u128 = {};
local u129 = {};
local u130 = {};
local u131 = {};
local u132 = {};
local Sounds = Main.Sounds;
local Game = Main.Game;
local u133 = "Default";
local u134 = u3.HUDClass:Init("Default", Main);
local Overlay = Main.Overlay;
local Underlay = Main.Underlay;
local RatingsContainer = Main.RatingsContainer;
local u135 = u2.Visualizer.new(Underlay.Visualizer);
u135:setAudio(Music);
local Obj = u134.Obj;
local DebugLabel = Overlay.DebugLabel;
local u136 = {};
local Position = DebugLabel.Position;
DebugLabel.Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale, Position.Y.Offset + u1.GuiService.TopbarInset.Height);
local PropertyChangedSignal = u1.GuiService:GetPropertyChangedSignal("TopbarInset");
table.insert(u128, PropertyChangedSignal:Connect(function() -- Line: 754
    -- upvalues: DebugLabel (copy), Position (copy), u1 (copy)
    DebugLabel.Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale, Position.Y.Offset + u1.GuiService.TopbarInset.Height);
end));
local TimeBar = Obj.TimeBar;
local UIGradient = TimeBar.Time.UIGradient;
local u137 = nil;
local u138 = false;
local u139 = true;
local HPBar = Obj.HPBar;
local Container = HPBar.Container;
local u140 = {
    L = {},
    R = {}
};
local u141 = Assets.Templates.BotplayText:Clone();
u141.Parent = Overlay;
u141.Visible = false;
local u142 = Assets.Templates.Progress:Clone();
u142.Parent = Overlay;
u142.Visible = false;
local u143 = nil;
local u144 = {
    start = nil,
    value = 0,
    targetTime = 0,
    targetValue = 0,
    alphaTweens = {},
    imageLeft = u142.Left.Sprite,
    imageRight = u142.Right.Sprite
};
u144.Functions = {
    ClearProgress = function(p145: boolean?) -- Line: 799, Name: ClearProgress
        -- upvalues: u144 (copy), u1 (copy), u115 (ref)
        u144.start = nil;
        u144.targetValue = p145 and 0 or u144.targetValue;

        for _, v in { "L", "R" } do
            local v146 = u1.TweenService:Create(v == "L" and u144.imageLeft or u144.imageRight, TweenInfo.new(p145 and 0.001 or 0.5 / u115, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                ImageTransparency = 1
            });
            u144.alphaTweens[v] = v146;
            u144.alphaTweens[v]:Play();
        end;

        local math_clamp_ret = math.clamp(u144.targetValue * 3.6, 0, 360);
        u144.imageLeft.UIGradient.Rotation = math.clamp(math_clamp_ret, 180, 360);
        u144.imageRight.UIGradient.Rotation = math.clamp(math_clamp_ret, 0, 180);
        u144.imageLeft.UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(0.5001, 1),
            NumberSequenceKeypoint.new(1, 1)
        });
        u144.imageRight.UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(0.5001, 1),
            NumberSequenceKeypoint.new(1, 1)
        });
    end,

    StartProgress = function(p147, p148) -- Line: 818, Name: StartProgress
        -- upvalues: u144 (copy), u1 (copy), u115 (ref)
        u144.targetTime = p147;
        u144.targetValue = math.clamp(p148, 0, 100);
        u144.start = tick();

        for _, v in { "L", "R" } do
            u1.TweenService:Create(v == "L" and u144.imageLeft or u144.imageRight, TweenInfo.new(0.25 / u115, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                ImageTransparency = 0
            }):Play();
        end;
    end,

    Update = function(p149) -- Line: 828, Name: Update
        -- upvalues: u144 (copy)
        if u144.start ~= nil then
            local v150 = tick() - u144.start;

            if math.abs(v150) <= u144.targetTime then
                local v151 = tick() - u144.start;
                local v152 = math.abs(v151) / u144.targetTime * 1000;
                local v153 = math.ceil(v152) / 1000;
                local math_clamp_ret = math.clamp(u144.targetValue * v153 * 3.6, 0, 360);

                for _, v in u144.alphaTweens do
                    if v ~= nil then
                        v:Cancel();
                    end;
                end;

                u144.imageLeft.UIGradient.Rotation = math.clamp(math_clamp_ret, 180, 360);
                u144.imageRight.UIGradient.Rotation = math.clamp(math_clamp_ret, 0, 180);
                u144.imageLeft.UIGradient.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(0.5, 0),
                    NumberSequenceKeypoint.new(0.5001, 1),
                    NumberSequenceKeypoint.new(1, 1)
                });
                u144.imageRight.UIGradient.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(0.5, 0),
                    NumberSequenceKeypoint.new(0.5001, 1),
                    NumberSequenceKeypoint.new(1, 1)
                });
            end;
        end;
    end
};
local u154 = {};
Obj.Watermark.Text = u2.EngineVersion.GetEngineString();

function u86.getEngineString() -- Line: 853
    -- upvalues: u2 (copy)
    return u2.EngineVersion.GetEngineString();
end;

function u86.engineVersion() -- Line: 854
    -- upvalues: u2 (copy)
    return u2.EngineVersion.GetAfterVersion();
end;

local u155 = 0;
local Tick = Obj.HitError.Tick;
local TickAvg = Obj.HitError.TickAvg;
local u156 = nil;
local u157 = {
    currentHealth = 1,
    visualHealth = 1,
    gainMult = 1,
    lossMult = 1,
    globalGainMult = 1,
    globalLossMult = 1,
    minHealth = 0,
    maxHealth = 2,
    totalHealth = 2,
    flipHealthbar = false,
    allowHealthDrain = false,
    forceHealthDrain = false,
    isDead = false,
    winHealth = 0.8,
    overwinHealth = 0.95,
    loseHealth = 0.2,
    overloseHealth = 0.05
};
local u158 = false;
local u159 = false;
local u160 = false;
local u161 = nil;
local u162 = nil;
local u163 = nil;
local u164 = false;
u86.textItemsScaling = u136;

function u86.GetAutoplay() -- Line: 900
    -- upvalues: u158 (ref)
    return u158;
end;

function u86.SetAutoplay(p165) -- Line: 901
    -- upvalues: u101 (ref), u158 (ref)
    u101 = true;
    u158 = p165;
end;

function u86.overrideInputs(p166, p167) -- Line: 902
    -- upvalues: u159 (ref), u160 (ref)
    u159 = p166;
    u160 = p167 or false;
end;

function u86.gcAdd(p168) -- Line: 903
    -- upvalues: u131 (copy)
    table.insert(u131, p168);
end;

u86.lerp = math.lerp;

function attachVisualizerTo(p169)
    -- upvalues: u2 (copy), u135 (copy), Music (copy)
    local v170 = p169:GetActiveCharacter():QueryDescendants("#Visualizer>#Surface>#Main")[1];

    if not v170 then
        if p169.attachedVisualizer then
            p169.attachedVisualizer:setSettings({});
        end;

        return;
    end;

    local v171 = 0;
    local v172 = {};

    for _, child in v170:GetChildren() do
        local v173 = tonumber(child.Name:match("%d+$"));

        if v173 then
            local v174 = {};
            local v175 = child:FindFirstChildOfClass("UIListLayout") or child:FindFirstChildOfClass("UIGridLayout");

            if v175 and v175.SortOrder == Enum.SortOrder.LayoutOrder then
                for _, child2 in child:GetChildren() do
                    if child2:IsA("GuiBase2d") then
                        table.insert(v174, child2);
                    end;
                end;

                table.sort(v174, function(p176, p177) -- Line: 933
                    return p176.LayoutOrder > p177.LayoutOrder;
                end);
            else
                for _, child2 in child:GetChildren() do
                    local v178 = tonumber(child2.Name:match("%d+$"));

                    if v178 then
                        v174[v178] = child2;
                    end;
                end;
            end;

            v171 = v171 < #v174 and #v174 or v171;
            v172[v173] = v174;
        end;
    end;

    for _, v in v172 do
        if #v < v171 then
            local v179 = v;

            for i = #v + 1, v171 do
                v179[i] = v179[#v179];
                local _ = i;
            end;
        end;
    end;

    if p169.attachedVisualizer then
        p169.attachedVisualizer:setParent(v170);
        p169.attachedVisualizer:setSettings({
            type = "VisualBars",
            visBars = v172,
            visBarCount = v171
        });

        return;
    end;

    local v180 = u2.Visualizer.new(v170, {
        type = "VisualBars",
        spectrumGap = 1,
        visBars = v172,
        visBarCount = v171
    }, u135.wiring);
    v180.sizeMult = 4;
    v180:setAudio(Music);
    p169.attachedVisualizer = v180;
end;

u86.setObjPropWithIndex = setObjPropWithIndex;
u86.getCachedObjProp = getObjProp;
local u181 = {
    x = 0,
    y = 0,
    angle = 0,
    zoom = 1,
    baseZoom = 1,
    charZoom = 1,
    defaultZoom = 1,
    modchartZoom = 0,
    additionalZoom = 0,
    zoomMultiplier = 1,
    zoomSpeed = 1,
    cameraBeat = 16,
    cameraSpeed = 1,
    cameraBeatZoom = 0.03,
    cameraBeatMultiplier = 1,
    _shakeIntensity = 0,
    _shakeDuration = 0,
    _shakeOffset = {
        x = 0,
        y = 0
    },
    _shakeMultiplier = {
        x = 1,
        y = 1
    }
};
local u182 = {
    x = 0,
    y = 0,
    angle = 0,
    zoom = 1,
    baseZoom = 1,
    charZoom = 1,
    defaultZoom = 1,
    modchartZoom = 0,
    baseGameZoom = 1,
    additionalZoom = 0,
    zoomMultiplier = 1,
    zoomSpeed = 1,
    cameraBeat = 16,
    cameraSpeed = 1,
    cameraBeatZoom = 0.015,
    cameraBeatMultiplier = 1,
    physicalAngle = 0,
    cameraCentered = false,
    cameraFollow = true,
    instantLerp = false,
    _shakeIntensity = 0,
    _shakeDuration = 0,
    offset = {
        position = {
            x = 0,
            y = 0,
            z = 0
        },
        rotation = {
            x = 0,
            y = 0,
            z = 0
        },
        instantPos = {
            x = 0,
            y = 0,
            z = 0
        },
        instantRot = {
            x = 0,
            y = 0,
            z = 0
        }
    },
    _shakeOffset = {
        x = 0,
        y = 0
    },
    _shakeMultiplier = {
        x = 1,
        y = 1
    }
};
local workspace_CurrentCamera = workspace.CurrentCamera;
local u183 = {
    baseFOV = 70,
    camMovement = CFrame_new_ret
};

function u86.getCamera(p184) -- Line: 1055
    -- upvalues: u181 (ref), u182 (ref)
    local v185 = {
        camHUD = u181,
        camGame = u182
    };

    if v185[p184] then
        return v185[p184];
    end;
end;

function u86.setFOV(p186) -- Line: 1066
    -- upvalues: u183 (ref), workspace_CurrentCamera (copy), u182 (ref)
    u183.baseFOV = p186;
    workspace_CurrentCamera.FieldOfView = u183.baseFOV / (u182.zoom * u182.zoomMultiplier) * u182.baseZoom;
end;

u86.useModcharts = u24.useModcharts;
u86.useGimmicks = u24.useGimmicks;
u86.parseLRCToTableTimeout = u2.LRCParser.ParseLRCToTableTimeout;
u86.parseLRCToTableStep = u2.LRCParser.ParseLRCToTableStep;
u86.parseLRCToBaseTable = u2.LRCParser.ParseLRCToBaseTable;
u86.deviceManager = u2.DeviceManager;
local u187 = {
    L = {},
    R = {}
};
local u188 = {
    L = nil,
    R = nil
};
local u189 = nil;
local u190 = false;
local u191 = nil;
local u192 = {};

function u86.addKeybind(u193: any, p194: any, p195, p196: string?) -- Line: 1096
    -- upvalues: u2 (copy), Data (ref), u192 (copy), Main (copy), u1 (copy), u132 (copy)
    if p194 == nil then
        p194 = setmetatable({}, {
            __iter = function() -- Line: 1099, Name: __iter
                -- upvalues: u2 (ref), Data (ref), u193 (copy)
                local v197 = (u2.DeviceManager.currentDevice == "Console" and Data.ConsoleKeybinds or Data.Keybinds).Extra[u193];

                return next, type(v197) == "string" and { v197 } or (v197 or {}), nil;
            end,

            __len = function() -- Line: 1103, Name: __len
                -- upvalues: u2 (ref), Data (ref), u193 (copy)
                local v198 = (u2.DeviceManager.currentDevice == "Console" and Data.ConsoleKeybinds or Data.Keybinds).Extra[u193];

                return #(type(v198) == "string" and { v198 } or (v198 or {}));
            end
        });
    end;

    u192[u193] = type(p194) == "string" and ({ p194 } or p194) or p194;

    if not u192[u193] then
        return;
    end;

    addExtraButton(u193, p195);
    local v199 = "";

    for i, v in u192[u193] do
        if i == #u192[u193] then
            v199 = v199 .. v;
        else
            v199 = v199 .. v .. " / ";
        end;
    end;

    local u200 = Main.NotificationFrame.Template:Clone();
    u200.Visible = true;
    u200.Text = (p196 or u193) .. ": " .. v199;
    u200.Parent = Main.NotificationFrame;
    u1.Debris:AddItem(u200, 3);
    table.insert(u132, task.delay(2, function() -- Line: 1132
        -- upvalues: u1 (ref), u200 (copy)
        u1.TweenService:Create(u200, TweenInfo.new(1), {
            TextTransparency = 1
        }):Play();
        u1.TweenService:Create(u200.UIStroke, TweenInfo.new(1), {
            Transparency = 1
        }):Play();
    end));
end;

function u86.removeKeybind(p201) -- Line: 1138
    -- upvalues: u192 (copy)
    u192[p201] = nil;
    removeExtraButton(p201);
end;

local u202 = nil;
local u203 = nil;
local u204 = {};
local u205 = {};
local u206 = {};
local u207 = 0;
local u208 = {};
local u209 = {};

function getLaneBGInstance(p210)
    -- upvalues: u111 (ref)
    local v211 = u111 and u111.Strums and u111.Strums[p210];

    if not v211 then
        return nil;
    end;

    local LaneBacks = u111.LaneBacks;

    if not LaneBacks then
        return nil;
    end;

    local v212 = LaneBacks[(v211.lane or (v211.column or 0)) + 1];

    if v212 then
        v212 = v212.lane;
    end;

    return v212;
end;

function syncMobileTileToLane(p213)
    -- upvalues: u208 (copy), Main (copy)
    local v214 = u208[p213];
    local v215 = getLaneBGInstance(p213);

    if not (v214 and v215) then
        return;
    end;

    local MobileTiles = Main.MobileTiles;
    local AbsoluteSize = MobileTiles.AbsoluteSize;

    if AbsoluteSize.X <= 0 then
        return;
    end;

    local v216 = v215.AbsoluteSize.X / AbsoluteSize.X;
    local Position2 = v214.Position;
    local Size = v214.Size;
    v214.Position = UDim2.new((v215.AbsolutePosition.X - MobileTiles.AbsolutePosition.X) / AbsoluteSize.X, 0, Position2.Y.Scale, Position2.Y.Offset);
    v214.Size = UDim2.new(v216, 0, Size.Y.Scale, Size.Y.Offset);
    v214.Rotation = v215.AbsoluteRotation;
end;

function hookMobileLaneTile(u217)
    -- upvalues: Data (ref), u208 (copy), u209 (copy)
    if not Data.MobileTileFollowStrum then
        return;
    end;

    if not u208[u217] then
        return;
    end;

    if u209[u217] then
        for _, v in u209[u217] do
            pcall(function() -- Line: 1193
                -- upvalues: v (copy)
                v:Disconnect();
            end);
        end;

        u209[u217] = nil;
    end;

    local v218 = getLaneBGInstance(u217);

    if not v218 then
        return;
    end;

    local function resync() -- Line: 1200
        -- upvalues: u217 (copy)
        syncMobileTileToLane(u217);
    end;

    u209[u217] = { v218:GetPropertyChangedSignal("AbsolutePosition"):Connect(resync), v218:GetPropertyChangedSignal("AbsoluteSize"):Connect(resync), v218:GetPropertyChangedSignal("AbsoluteRotation"):Connect(resync) };
    syncMobileTileToLane(u217);
end;

function syncAllMobileLaneTiles()
    -- upvalues: Data (ref), u208 (copy)
    if not Data.MobileTileFollowStrum then
        return;
    end;

    for i, _ in u208 do
        hookMobileLaneTile(i);
    end;
end;

function getPositionForButton(p219: number, p220: number)
    -- upvalues: u205 (copy), Data (ref), u207 (ref)
    local v221 = 0;

    if Data.FlipMobileExtraTiles then
        if p219 == 0 then
            for i = 1, u207 do
                v221 = v221 + u205[i].rowSize;
                local _ = i;
            end;
        else
            for i = 1, p219 - 1 do
                v221 = v221 + u205[i].rowSize;
                local _ = i;
            end;
        end;
    else
        for i = 0, p219 - 1 do
            v221 = v221 + u205[i].rowSize;
            local _ = i;
        end;
    end;

    return UDim2.fromScale(1 / u205[p219].tileAmmo * (p220 - 1), v221);
end;

function getSizeForButton(p222: number, p223: number)
    -- upvalues: u205 (copy)
    local v224 = u205[p222];

    return UDim2.fromScale(1 / v224.tileAmmo, v224.rowSize);
end;

function recalculateButtons(p225: number?)
    -- upvalues: u205 (copy), u1 (copy)
    updateExtraRowSize();
    local v226 = tonumber(p225) or 0;

    for i, v in u205 do
        local v227 = i;

        for i2, v2 in v.buttons do
            u1.TweenService:Create(v2, TweenInfo.new(v226), {
                Size = getSizeForButton(v227, i2),
                Position = getPositionForButton(v227, i2)
            }):Play();
        end;
    end;
end;

function regenerateButtons(p228)
    clearAllButtons();
    generateMobileButtons(p228);
end;

function getRowAmmo()
    -- upvalues: u207 (ref)
    return u207;
end;

function updateExtraRowSize()
    -- upvalues: u206 (ref), u205 (copy), Data (ref), u207 (ref)
    u206.rowSize = u206.tileAmmo == 0 and 0 or u205[1].defaultSize * u206.rowSizeScale;
    local FlipMobileExtraTiles = Data.FlipMobileExtraTiles;

    for _, v in u205 do
        if v ~= u206 then
            if FlipMobileExtraTiles then
                v.rowSize = u206.tileAmmo == 0 and v.defaultSize or v.defaultSize - v.defaultSize * u206.rowSizeScale / u207;
            else
                v.rowSize = u206.tileAmmo == 0 and v.defaultSize or v.defaultSize - v.defaultSize * u206.rowSizeScale / u207;
            end;
        end;
    end;
end;

function addExtraButton(u229, p230)
    -- upvalues: Assets (copy), Data (ref), u89 (copy), Main (copy), u206 (ref), u204 (copy)
    removeExtraButton(u229);
    local v231 = Assets.Templates.MobileButton:Clone();
    v231.BackgroundColor3 = p230 or Color3.fromRGB(47, 47, 47);
    v231.Glow.ImageColor3 = p230 or Color3.fromRGB(47, 47, 47);
    v231.BackgroundTransparency = Data.MobileTileTransparency;
    v231.UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.25),
        NumberSequenceKeypoint.new(0.125, 0.9),
        NumberSequenceKeypoint.new(0.875, 0.9),
        NumberSequenceKeypoint.new(1, 0.25)
    });
    v231.MouseEnter:Connect(function() -- Line: 1306
        -- upvalues: u89 (ref), u229 (copy)
        u89:call("onSpecialDown", u229);
    end);
    v231.MouseLeave:Connect(function() -- Line: 1311
        -- upvalues: u89 (ref), u229 (copy)
        u89:call("onSpecialUp", u229);
    end);
    v231.Parent = Main.MobileTiles;
    local v232 = u206;
    v232.tileAmmo = v232.tileAmmo + 1;
    u206.buttonsName[u229] = v231;
    table.insert(u206.buttons, v231);
    table.insert(u204, v231);
    recalculateButtons();
end;

function removeExtraButton(p233)
    -- upvalues: u206 (ref), u204 (copy)
    local v234 = u206.buttonsName[p233];

    if v234 then
        v234:Destroy();
        u206.buttonsName[p233] = nil;
        local table_find_ret = table.find(u206.buttons, v234);

        if table_find_ret then
            table.remove(u206.buttons, table_find_ret);
        end;

        local table_find_ret2 = table.find(u204, v234);

        if table_find_ret2 then
            table.remove(u204, table_find_ret2);
        end;

        local v235 = u206;
        v235.tileAmmo = v235.tileAmmo - 1;
    end;

    recalculateButtons();
end;

function generateMobileButtons(p236)
    -- upvalues: u124 (ref), Data (ref), u207 (ref), u206 (ref), u205 (copy), ManiaData (copy), Assets (copy), u202 (ref), u203 (ref), Main (copy), u208 (copy), u204 (copy)
    clearAllButtons();
    local v237 = tonumber(p236) or u124.playerKeyCount;
    local v238 = nil;
    local v239 = nil;
    local v240 = nil;

    if Data.SeparateMobileMiddleKey then
        if v237 % 2 == 1 then
            v238 = v237 < 10;
        else
            v238 = false;
        end;

        if v238 then
            v239 = math.ceil(v237 / 2) or nil;
        else
            v239 = nil;
        end;

        if v238 then
            v240 = v237 - 1 or v237;
        else
            v240 = v237;
        end;

        u207 = math.ceil(v240 / 10);

        if v238 then
            u207 = u207 + 1;
        end;
    else
        u207 = math.ceil(v237 / 10);
    end;

    u206 = {
        tileAmmo = 0,
        isExtra = true,
        rowSizeScale = 0.25,
        rowSize = 0,
        defaultSize = 0,
        buttons = {},
        buttonsName = {}
    };
    u205[0] = u206;
    local v241 = 0;

    for i = 1, u207 do
        local v242;

        if Data.SeparateMobileMiddleKey then
            if v238 and i == u207 then
                u205[i] = {
                    tileAmmo = 1,
                    rowSize = 0.25,
                    defaultSize = 0.25,
                    buttons = {}
                };
                v242 = i;
            else
                u205[i] = {
                    tileAmmo = i == u207 - (v238 and 1 or 0) and (v240 - v241 or 10) or 10,
                    buttons = {},
                    rowSize = 1 / u207 + (v238 and 0.25 or 0),
                    defaultSize = 1 / u207 + (v238 and 0.25 or 0)
                };
                v241 = v241 + u205[i].tileAmmo;
                v242 = i;
            end;
        else
            u205[i] = {
                tileAmmo = i == u207 and (v237 - v241 or 10) or 10,
                buttons = {},
                rowSize = 1 / u207,
                defaultSize = 1 / u207
            };
            v241 = v241 + u205[i].tileAmmo;
            v242 = i;
        end;
    end;

    local v243 = ManiaData.dirs[v237];
    local colors = ManiaData.colors;
    local v244 = 0;
    local v245 = {};

    for i = 1, v237 do
        local u246 = v243[i];
        local v247 = Assets.Templates.MobileButton:Clone();
        v247.BackgroundColor3 = colors[u246];
        v247.Glow.ImageColor3 = colors[u246];
        v247.BackgroundTransparency = Data.MobileTileTransparency;
        v247.UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.25),
            NumberSequenceKeypoint.new(0.125, 0.9),
            NumberSequenceKeypoint.new(0.875, 0.9),
            NumberSequenceKeypoint.new(1, 0.25)
        });
        v247.MouseEnter:Connect(function() -- Line: 1432
            -- upvalues: u202 (ref), u246 (copy)
            u202(u246);
        end);
        v247.MouseLeave:Connect(function() -- Line: 1436
            -- upvalues: u203 (ref), u246 (copy)
            u203(u246);
        end);
        v247.Parent = Main.MobileTiles;
        local v248;

        if Data.SeparateMobileMiddleKey then
            if v238 and i == v239 then
                v248 = u207;
            else
                v244 = v244 + 1;
                v248 = math.ceil(v244 / 10);
                local _ = v244 - (v248 - 1) * 10;
            end;
        else
            v248 = math.ceil(i / 10);
        end;

        if Data.MobileTileFollowStrum then
            u208[u246] = v247;
        else
            table.insert(u205[v248].buttons, v247);
        end;

        table.insert(v245, v247);
        table.insert(u204, v247);
        local _ = i;
    end;

    recalculateButtons();
end;

function clearAllButtons()
    -- upvalues: u204 (copy), u209 (copy), u208 (copy), u205 (copy)
    for _, v in u204 do
        pcall(function() -- Line: 1472
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    for _, v in u209 do
        for _, v2 in v do
            pcall(function() -- Line: 1476
                -- upvalues: v2 (copy)
                v2:Disconnect();
            end);
        end;
    end;

    table.clear(u209);
    table.clear(u208);
    table.clear(u205);
    table.clear(u204);
end;

u86.regenerateButtons = regenerateButtons;
local u249 = {
    Left = "Left",
    Down = "Down",
    Up = "Up",
    Right = "Right"
};
local u250 = 2.5;
local u251 = u250 * 0.45;
local u252 = "Friday Night Funkin\'";
local u253 = 1;

function u86.balanceSpeedMult(p254, p255) -- Line: 1502
    -- upvalues: u250 (ref), u33 (ref)
    local v256 = p255 or u250;

    if v256 <= u33.speed then
        return p254;
    end;

    return (p254 - 1) / (v256 / u33.speed) ^ 1.25 + 1;
end;

function u86.setSpeed(p257) -- Line: 1514
    -- upvalues: u250 (ref), Data (ref), u33 (ref), u115 (ref)
    u250 = p257 or Data.ForceScrollSpeed and Data.ScrollSpeed or u33.speed * Data.ScrollSpeed;
    u250 = u250 / u115;
end;

function u86.getSpeed() -- Line: 1518
    -- upvalues: u250 (ref), u115 (ref)
    return u250 * u115;
end;

function shared.setHealth(p258) -- Line: 1520
    -- upvalues: u157 (ref)
    u157.currentHealth = p258;
end;

function shared.setMaxHealth(p259) -- Line: 1521
    -- upvalues: u157 (ref)
    u157.maxHealth = p259;
end;

function shared.setSkipCountdown(p260) -- Line: 1522
    -- upvalues: u24 (copy)
    u24.skipCountdown = p260;
end;

function shared.setSkipNowPlaying(p261) -- Line: 1523
    -- upvalues: u24 (copy)
    u24.skipNowPlaying = p261;
end;

function shared.setCountdownStyle(p262) -- Line: 1524
    -- upvalues: u252 (ref)
    u252 = p262;
end;

function shared.setCountdownSpeed(p263) -- Line: 1525
    -- upvalues: u253 (ref)
    u253 = p263;
end;

function shared.getRawSpeed() -- Line: 1526
    -- upvalues: u250 (ref)
    return u250;
end;

function shared.getHealth() -- Line: 1527
    -- upvalues: u157 (ref)
    return u157.currentHealth;
end;

function shared.getMaxHealth() -- Line: 1528
    -- upvalues: u157 (ref)
    return u157.maxHealth;
end;

function shared.getNotes() -- Line: 1529
    -- upvalues: u117 (copy)
    return u117;
end;

function shared.getReceptors() -- Line: 1530
    -- upvalues: u110 (copy)
    return u110;
end;

function shared.getReceptorBG(p264) -- Line: 1531
    -- upvalues: u109 (copy)
    return u109[p264 == "L" and 0 or 1].LaneBGs;
end;

function shared.getStrumlineByName(p265) -- Line: 1532
    -- upvalues: u111 (ref), u112 (ref)
    return p265:lower() == "player" and u111 or u112;
end;

function shared.getStrumline(p266) -- Line: 1533
    -- upvalues: u109 (copy)
    return u109[p266];
end;

function shared.getStrumsByName(p267) -- Line: 1534
    -- upvalues: u111 (ref), u112 (ref)
    return p267:lower() == "player" and u111.Strums or u112.Strums;
end;

function shared.getStrumsBySide(p268) -- Line: 1535
    -- upvalues: u109 (copy)
    return p268:lower() == "l" and u109[0].Strums or u109[1].Strums;
end;

function shared.getStrumlines() -- Line: 1537
    -- upvalues: u109 (copy)
    return u109;
end;

u86.Notes = u117;
u86.NoteSplashes = u118;
u86.UnspawnedNotes = u116;

function u86.hideGirlfriend(p269) -- Line: 1542
    -- upvalues: u164 (ref)
    u164 = p269;
    updateHideSpeaker();
end;

u86.Music = Music;
u86.RNG = Random_new_ret;
u86.GUI = Main;
u86.Game = Main.Game;
u86.HUD = Obj;
u86.Side = u36;
u86.Overlay = Overlay;
u86.RatingsContainer = RatingsContainer;
u86.HUDApi = u134;
u86.Strums = u110;
u86.Strumlines = u109;
u86.healthStats = u157;
u86.Underlay = Underlay;
u86.Settings = Data;
u86.OpponentSettings = u4;
u86.Keybinds = u126;
u86.Characters = u187;
u86.GFCharacter = u162;
u86.Conductor = u2.Conductor;
u86.mapModule = u2.MapService;
u86.showError = showError;
u86.showTrace = showTrace;

function u86.setZoomHit(p270) -- Line: 1569
    -- upvalues: u139 (ref)
    u139 = p270;
end;

u86.setSongData = setSongData;
u86.getSongData = getSongData;

function u86.overrideIconBop(p271) -- Line: 1572
    -- upvalues: u140 (ref)
    for _, v in u140 do
        for _, v2 in v do
            v2.overrideBop = p271;
        end;
    end;
end;

function u86.overrideIconPositions(p272) -- Line: 1579
    -- upvalues: u140 (ref)
    for _, v in u140 do
        for _, v2 in v do
            v2.overridePos = p272;
        end;
    end;
end;

function u86.doReverseNotes(p273) -- Line: 1586
    -- upvalues: u24 (copy)
    u24.reverseNotes = p273;
end;

function u86.getSideIndex() -- Line: 1587
    -- upvalues: u155 (ref)
    return u155;
end;

function u86.getKeyData() -- Line: 1588
    -- upvalues: u124 (ref)
    return u124;
end;

function u86.getManiaData() -- Line: 1589
    -- upvalues: ManiaData (copy)
    return ManiaData;
end;

function u86.getStage() -- Line: 1590
    -- upvalues: u30 (ref)
    return u30;
end;

function u86.getSpots() -- Line: 1591
    -- upvalues: u30 (ref)
    local v274 = u30 and u30:FindFirstChild("Spots");

    return v274;
end;

function u86.getCharacters(p275) -- Line: 1592
    -- upvalues: u187 (ref)
    return p275 and u187[p275] or u187;
end;

function u86.cacheImage(p276) -- Line: 1595
    cacheImage(p276);
end;

function trackDelayedThread(p277: number, u278: function)
    -- upvalues: u132 (copy)
    local u279 = nil;
    u279 = task.delay(p277, function() -- Line: 1599
        -- upvalues: u132 (ref), u279 (ref), u278 (copy)
        local table_find_ret = table.find(u132, u279);

        if table_find_ret then
            table.remove(u132, table_find_ret);
        end;

        u278();
    end);
    table.insert(u132, u279);

    return u279;
end;

function cacheImage(p280)
    -- upvalues: u2 (copy), Main (copy)
    if type(p280) == "string" then
        u2.Cache.cacheImage(p280);

        return;
    end;

    if type(p280) == "number" then
        u2.Cache.cacheImage("rbxassetid://" .. p280);

        return;
    end;

    local v281 = {
        ImageLabel = {
            Property = "Image"
        },
        Texture = {
            Property = "Texture"
        },
        Decal = {
            Property = "Texture"
        },
        Sky = {
            Properties = { "MoonTextureId", "SunTextureId", "SkyboxBk", "SkyboxFt", "SkyboxDn", "SkyboxLf", "SkyboxRt", "SkyboxUp" }
        },
        ParticleEmitter = {
            Property = "Texture"
        }
    };

    if v281[p280.ClassName] ~= nil then
        local v282 = v281[p280.ClassName];

        if v282.Properties then
            for _, v in v282.Properties do
                local v283 = u2.Cache.cacheImage(p280[v]);
                v283.ImageTransparency = 0.9999;
                v283.Parent = Main.Cache;
            end;

            return;
        end;

        if v282.Property then
            local v284 = u2.Cache.cacheImage(p280[v282.Property]);
            v284.ImageTransparency = 0.9999;
            v284.Parent = Main.Cache;
        end;
    end;
end;

local __Background = u1.ReplicatedStorage:WaitForChild("Temp"):WaitForChild("__Background");
local u285 = nil;

function u86.cacheMap(p286: table) -- Line: 1648
    -- upvalues: u86 (copy)
    return u86.Map.Cache(p286);
end;

function u86.switchMap(p287: string) -- Line: 1651
    -- upvalues: u86 (copy)
    return u86.Map.Switch(p287);
end;

local u288 = nil;

function u86.getBackground(p289: string?) -- Line: 1655
    -- upvalues: u86 (copy)
    return u86.Map.GetBackground(p289);
end;

u86.Map = {
    Property = function(p290: string, p291: boolean?, p292: any) -- Line: 1658, Name: Property
        -- upvalues: u2 (copy)
        return u2.MapService:Property(p290, p291 or false, p292 or nil);
    end,

    GetProperty = function(p293: string) -- Line: 1659, Name: GetProperty
        -- upvalues: u2 (copy)
        return u2.MapService:Property(p293, false);
    end,

    SetProperty = function(p294: string, p295: any) -- Line: 1660, Name: SetProperty
        -- upvalues: u2 (copy)
        return u2.MapService:Property(p294, true, p295);
    end,

    Switch = function(p296: string) -- Line: 1662, Name: Switch
        -- upvalues: Data (ref), u2 (copy)
        if Data.DisableMapMidsong then
            return;
        end;

        if not u2.MapService:Property((`Maps/{p296}`)) then
            return warn("Map", "Map " .. p296 .. " does not exist!");
        end;

        u2.MapService:Switch(p296);
    end,

    GetBackground = function(p297: string?) -- Line: 1675, Name: GetBackground
        -- upvalues: Data (ref), u2 (copy)
        if Data.DisableMapMidsong then
            return;
        end;

        local v298 = p297 or u2.MapService:Property("CurrentMap");

        if v298 == nil or v298 == "CustomVoid" and Data.HideLobby then
            return;
        end;

        local v299 = u2.MapService:Property((`Maps/{v298}`));

        if v299 then
            local v300 = {};
            local v301;

            if v299 and v299.SerializedInstance then
                v301 = v299.SerializedInstance or nil;
            else
                v301 = nil;
            end;

            v300.instance = v301;
            v300.data = v299 or nil;

            return v300;
        end;
    end,

    RawGetBackground = function(p302: string?) -- Line: 1691, Name: RawGetBackground
        -- upvalues: u2 (copy)
        local v303 = p302 or u2.MapService:Property("CurrentMap");

        if v303 == nil then
            return;
        end;

        local v304 = u2.MapService:Property((`Maps/{v303}`));

        if v304 then
            local v305 = {};
            local v306;

            if v304 and v304.SerializedInstance then
                v306 = v304.SerializedInstance or nil;
            else
                v306 = nil;
            end;

            v305.instance = v306;
            v305.data = v304 or nil;

            return v305;
        end;
    end,

    CacheAsync = function(p307: table) -- Line: 1704, Name: CacheAsync
        -- upvalues: Data (ref), u2 (copy), u288 (ref), u35 (ref)
        if Data.DisableMapMidsong then
            return;
        end;

        local v308 = type(p307) == "string" and { nil, nil, p307 } or p307;
        u2.NetworkFunctions.fireStageRemote("GET_Map", {
            Path = { v308[2] or (u288 or u35.ModName), v308[3] or nil }
        });
    end,

    Cache = function(p309: table) -- Line: 1718, Name: Cache
        -- upvalues: Data (ref), u2 (copy), u288 (ref), u35 (ref)
        local u310 = type(p309) == "string" and { nil, nil, p309 } or p309;

        if Data.DisableMapMidsong and (not Data.HideLobby or u2.MapService.Initialized) then
            return;
        end;

        if not u2.MapService:Property((`Maps/{u310[3] or ""}`)) then
            u2.NetworkFunctions.fireStageRemote("GET_Map", {
                Path = { u310[2] or (u288 or u35.ModName), u310[3] or nil }
            });
            local coroutine_running_ret = coroutine.running();
            local u311 = nil;
            u311 = u2.MapService.Signals.MapAdded:Connect(function(p312) -- Line: 1734
                -- upvalues: u310 (ref), u311 (ref), coroutine_running_ret (copy)
                if p312 == u310[3] then
                    u311:Disconnect();
                    coroutine.resume(coroutine_running_ret);
                end;
            end);

            return coroutine.yield();
        end;
    end,

    BulkCache = function(p313: table) -- Line: 1744, Name: BulkCache
        -- upvalues: Data (ref), u2 (copy), u288 (ref), u35 (ref)
        if Data.DisableMapMidsong then
            return;
        end;

        local u314 = {};

        for _, v in p313 do
            local v315 = type(v) == "string" and { nil, nil, v } or v;
            u2.NetworkFunctions.fireStageRemote("GET_Map", {
                Path = { v315[2] or (u288 or u35.ModName), v315[3] or nil }
            });

            if v315[3] then
                u314[v315[3]] = true;
            end;
        end;

        if next(u314) then
            local coroutine_running_ret = coroutine.running();
            local u316 = nil;
            u316 = u2.MapService.Signals.MapAdded:Connect(function(p317) -- Line: 1769
                -- upvalues: u314 (copy), u316 (ref), coroutine_running_ret (copy)
                if u314[p317] then
                    u314[p317] = nil;
                end;

                if not next(u314) then
                    u316:Disconnect();
                    coroutine.resume(coroutine_running_ret);
                end;
            end);

            return coroutine.yield();
        end;
    end,

    StartMapModchart = function(p318) -- Line: 1783, Name: StartMapModchart
        -- upvalues: u2 (copy), u89 (copy)
        local v319 = u2.MapService:Property((`Maps/{p318}`));

        if v319 and (v319.Modchart and not u89:getModule(v319.Modchart)) then
            u89:add(v319.Modchart, true);
        end;
    end,

    Load = function(p320: table) -- Line: 1792, Name: Load
        -- upvalues: u86 (copy)
        u86.Map.Cache(p320);
        u86.Map.Switch(p320[3] or "");
    end
};

function u86.getStagePos(p321, p322) -- Line: 1798
    -- upvalues: u155 (ref), u36 (ref), u189 (ref), u2 (copy), u30 (ref)
    local v323 = p321 or u155;
    local v324 = p322 or u36;
    local v325 = u189 and (u189.data.Characters and u189.data.Characters[v324]) and u189.data.Characters[v324][tostring(v323)];

    if v325 then
        return v325;
    end;

    if u189 and u189.instance then
        v325 = getPosFromStage(u2.MapService:GetBackgroundFolder():FindFirstChild("Stage"), u36, v323);
    end;

    if not v325 and u30 then
        v325 = getPosFromStage(u30:FindFirstChild("Spots"), u36, v323);
    end;

    return v325;
end;

function getEmoteUsesSpeaker(p326)
    if p326 then
        p326 = p326.sideAttributes;
    end;

    return (not p326 or p326.UseSpeaker == nil) and true or p326.UseSpeaker;
end;

function resolveSpeakerRule(p327, p328)
    local v329;

    if p327 == nil then
        v329 = false;
    else
        v329 = p327.Attributes.HideSpeaker == true;
    end;

    local v330 = (p327 == nil or p327.Attributes.AllowEmotes == nil) and true or p327.Attributes.AllowEmotes == true;

    if not v330 then
        return false, true;
    end;

    if not v329 then
        return v330, not p328;
    end;

    if v330 then
        v330 = not p328;
    end;

    return v330, true;
end;

function updateHideSpeaker()
    -- upvalues: u163 (ref), u30 (ref), u162 (ref), u285 (ref), u164 (ref), Data (ref), u2 (copy)
    local v331 = u163 ~= nil;
    local v332;

    if v331 then
        local v333 = u30 and u30:GetAttribute("HideSpeaker") == true;
        v332 = not v333;
    else
        v332 = getEmoteUsesSpeaker(u162);
    end;

    local v334, v335 = resolveSpeakerRule(u285, v332);

    if u164 then
        v335 = true;
        v334 = false;
    end;

    if Data.HideCharacters then
        v334 = false;
    end;

    u2.MapService:HideSpeaker(v335);
    local RigStorage = u2.CharacterModule:GetRigStorage();
    local v336;

    if v334 then
        v336 = workspace or RigStorage;
    else
        v336 = RigStorage;
    end;

    if u163 then
        u163.Parent = v336;
    end;

    if u162 then
        if v331 then
            v336 = RigStorage or v336;
        end;

        u162.Parent = v336;
    end;
end;

function u86.getBackgroundProperty(p337: string) -- Line: 1872
    -- upvalues: u2 (copy)
    return u2.MapService:Property(p337);
end;

u86.currentCharacter = nil;

function u86.cancelSongStart() -- Line: 1874
    -- upvalues: u24 (copy)
    u24.dontStartSong = true;
end;

function u86.sendServerEvent(...) -- Line: 1875
    -- upvalues: u2 (copy)
    u2.NetworkFunctions.fireStageRemote("SongEvent", ...);
end;

function u86.isKeyPressed(p338) -- Line: 1876
    -- upvalues: u125 (ref)
    return u125[p338];
end;

local u339 = {
    playbackRate = function() -- Line: 1880
        -- upvalues: u115 (ref)
        return u115;
    end,

    songSpeed = function() -- Line: 1881
        -- upvalues: u250 (ref), u115 (ref)
        return u250 * u115;
    end,

    songLength = function() -- Line: 1882
        -- upvalues: u114 (ref)
        return u114;
    end,

    startedCountdown = function() -- Line: 1883
        -- upvalues: u108 (ref)
        return u108;
    end,

    onSongEndedCalled = function() -- Line: 1884
        return onSongEndedCalled;
    end
};
local u345 = {
    playbackRate = function(p340) -- Line: 1888
        -- upvalues: u115 (ref)
        u115 = p340;
        changePlaybackRate();
    end,

    songLength = function(p341) -- Line: 1892
        -- upvalues: u114 (ref)
        u114 = p341;
    end,

    songSpeed = function(p342) -- Line: 1893
        -- upvalues: u250 (ref), u115 (ref)
        u250 = p342 / u115;
    end,

    startedCountdown = function(p343) -- Line: 1894
        -- upvalues: u108 (ref)
        u108 = p343;
    end,

    onSongEndedCalled = function(p344) -- Line: 1895
        onSongEndedCalled = p344;
    end
};
local script_globalsAliases = require(script.globalsAliases);
setmetatable(u86, {
    __index = function(p346, p347) -- Line: 1901, Name: __index
        -- upvalues: script_globalsAliases (copy), u86 (copy), u339 (copy)
        local v348 = script_globalsAliases[p347] or p347;
        local v349 = rawget(u86, v348);

        if v349 ~= nil then
            return v349;
        end;

        if u339[v348] then
            return u339[v348]();
        end;

        return shared[v348];
    end,

    __newindex = function(p350, p351, p352) -- Line: 1916, Name: __newindex
        -- upvalues: script_globalsAliases (copy), u345 (copy), u86 (copy)
        local v353 = script_globalsAliases[p351] or p351;

        if u345[v353] then
            return u345[v353](p352);
        end;

        rawset(u86, v353, p352);
    end,

    __len = function() -- Line: 1924, Name: __len
        -- upvalues: u86 (copy)
        local v354 = 0;
        local v355 = 0;

        for _, v in u86 do
            if typeof(v) == "function" then
                v355 = v355 + 1;
            else
                v354 = v354 + 1;
            end;
        end;

        return v355 + v354;
    end
});
local u356 = {
    Marvelous = 0,
    Sick = 0,
    Good = 0,
    Ok = 0,
    Bad = 0,
    Miss = 0
};
local u357 = {
    notesPlayed = 0,
    notesHit = 0,
    meanSum = 0,
    list = {},
    releaseGraces = {}
};
local u358 = nil;

function changePlaybackRate()
    -- upvalues: u358 (ref), Obj (ref), u35 (ref), u2 (copy), u115 (ref), u86 (copy), u113 (copy)
    u358 = nil;
    Obj.Song.Text = `{u35.SongName} [{u35.DisplayDiffName}] - [{u2.Adapters.floatToString(u115)}x]`;
    u86.setSpeed();
    u113:setSpeed(u115);
end;

u86.judgements = u356;
local u359 = 0;
local u360 = 0;
local u361 = 0;
local u362 = 0;
local u363 = 0;
local u364 = {
    songTime = 0,
    stepTime = 0,
    bpm = 0
};
u86.lastBPMChange = u364;
local u365 = 0;
local u366 = 0;
local u367 = 0;
local u368 = 1;
local u369 = {
    accuracy = 1,
    score = 0,
    notesPlayed = 0,
    notesHit = 0,
    combo = 0,
    topCombo = 0,
    misses = 0
};

function u86.getNotesPlayed() -- Line: 1990
    -- upvalues: u357 (ref)
    return u357.notesPlayed;
end;

local u370 = 0;
local u371 = 0;
local Asset = u2.AssetReplicator.getAsset("Ratings", "Afternight");
local u372 = {};
local u373 = Assets.Templates["3DRating"]:Clone();

function u86.forceJudgementId(p374, p375) -- Line: 2002
    -- upvalues: u372 (copy)
    u372[p374] = p375;
end;

local CFrame2 = workspace_CurrentCamera.CFrame;
local u376 = nil;
local u377 = false;

function u86.overrideCamera(p378: boolean) -- Line: 2012
    -- upvalues: u377 (ref)
    u377 = p378;
end;

function round(p379, p380)
    local v381 = 10 ^ (p380 or 0);

    return math.floor(p379 * v381 + 0.5) / v381;
end;

function Mean(p382)
    local v383 = 0;

    for _, v in p382 do
        v383 = v383 + v;
    end;

    return v383 / #p382;
end;

function updateShake(p384)
    -- upvalues: Data (ref), u115 (ref), u181 (ref), u182 (ref), Random_new_ret (copy), u1 (copy)
    if not Data.CameraShake then
        return;
    end;

    local v385 = p384 * u115;
    local v386 = 0;

    for _, v in { u181, u182 } do
        if v._shakeDuration > 0 then
            v._shakeDuration = v._shakeDuration - v385;

            if v._shakeDuration > 0 then
                local _shakeIntensity = v._shakeIntensity;
                local v387 = Random_new_ret:NextInteger(-_shakeIntensity * 1280, _shakeIntensity * 1280);
                local v388 = Random_new_ret:NextInteger(-_shakeIntensity * 720, _shakeIntensity * 720);

                if v386 < _shakeIntensity then
                    v386 = _shakeIntensity or v386;
                end;

                v._shakeOffset.x = v387;
                v._shakeOffset.y = v388;
            else
                v._shakeOffset.x = 0;
                v._shakeOffset.y = 0;
            end;
        end;
    end;

    if Data.ControllerVibration then
        u1.Haptics:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, (math.min(v386 * 75, 1)));
    end;
end;

function getCamGameOffsets()
    -- upvalues: u182 (ref)
    local offset = u182.offset;
    local position = offset.position;
    local rotation = offset.rotation;
    local instantPos = offset.instantPos;
    local instantRot = offset.instantRot;
    local physicalAngle = u182.physicalAngle;

    return CFrame.Angles(math.rad(rotation.x), math.rad(rotation.y), (math.rad(rotation.z + physicalAngle))) + vector.create(position.x, position.y, position.z), CFrame.Angles(math.rad(instantRot.x), math.rad(instantRot.y), (math.rad(instantRot.z + physicalAngle))) + vector.create(instantPos.x + u182._shakeOffset.x * u182._shakeMultiplier.x / 100, instantPos.y + u182._shakeOffset.y * u182._shakeMultiplier.y / 100, instantPos.z);
end;

function getCameraTarget()
    -- upvalues: Data (ref), u182 (ref), u363 (ref), u32 (ref), u188 (ref)
    if not (Data.CameraMovement and (not u182.cameraCentered and u363 ~= 2)) then
        return u32.Camera.CFrame;
    end;

    local v389 = u363 == 1;
    local v390 = v389 and "BF" or "Dad";
    local v391 = u32[v390];
    local v392 = v389 and u188.R or not v389 and u188.L;

    if not v392 then
        return v391.CFrame;
    end;

    local v393 = u32[v390 .. v392.currentID];

    if v393 then
        return v393.CFrame;
    end;

    local camOffset = v392.camOffset;

    return v391.CFrame + vector.create(-camOffset.X, camOffset.Y, camOffset.Z);
end;

local u394 = nil;
local u395 = nil;
local u396 = 0;
local u397 = nil;
local u398 = nil;
local u399 = nil;
local u400 = CFrame_new_ret;

function lerpCFrame(p401: number, p402, p403, p404)
    -- upvalues: u398 (ref), Data (ref), u2 (copy), u399 (ref), u396 (ref), u182 (ref), u397 (ref)
    if p402 == p403 then
        return p403;
    end;

    local v405 = u398;

    if not v405 then
        if Data.CameraEasingStyle == "Default" then
            v405 = nil;
        else
            v405 = Data.CameraEasingStyle or nil;
        end;
    end;

    if not (v405 and u2.EasingStyles[v405]) then
        return p404:Lerp(p403, (math.clamp(p401 * 3.125 * u182.cameraSpeed, 0, 1)));
    end;

    local v406 = u399 or Data.CameraEasingDir;
    local v407 = v406 and Enum.EasingDirection:FromName(v406) or Enum.EasingDirection.InOut;
    u396 = u396 + p401 * u182.cameraSpeed;
    local v408 = u396 / (u397 or 1.15);

    if v408 >= 1 then
        return p403;
    end;

    return p402:Lerp(p403, (u2.EasingStyles[v405](0, 1, v408, v407)));
end;

u86.lerpCFrame = lerpCFrame;

function updateCam(p409: any, p410: boolean?)
    -- upvalues: u30 (ref), u377 (ref), u191 (ref), u394 (ref), u395 (ref), CFrame2 (ref), u396 (ref), u182 (ref), u400 (ref), u183 (ref), CFrame_new_ret (copy), workspace_CurrentCamera (copy)
    if not u30 or u377 then
        return;
    end;

    local v411, v412 = getCamGameOffsets();
    local v413 = getCameraTarget();

    if u191 then
        if typeof(u191) == "Instance" then
            if u191:IsA("CFrameValue") then
                v413 = u191.Value;
            elseif u191:IsA("Vector3Value") then
                v413 = CFrame.new(u191.Value);
            else
                v413 = u191.CFrame;
            end;
        elseif typeof(u191) == "CFrame" then
            v413 = u191;
        elseif typeof(u191) == "Vector3" then
            v413 = CFrame.new(u191);
        end;
    end;

    local v414 = v413 * v411;

    if u394 ~= v414 then
        u395 = CFrame2;
        u396 = 0;
        u394 = v414;
    end;

    if u182.instantLerp or p410 then
        u395 = v414;
        u394 = v414;
        u400 = u183.camMovement;
        CFrame2 = v414;
    else
        u400 = u182.cameraFollow and u400:Lerp(u183.camMovement, (math.clamp(p409 * 3.125 * u182.cameraSpeed, 0, 1))) or CFrame_new_ret;
        CFrame2 = lerpCFrame(p409, u395 or v414, v414, CFrame2);
    end;

    workspace_CurrentCamera.CFrame = CFrame2 * u400 * v412;
end;

function getCamSubjectPos()
    -- upvalues: u2 (copy), workspace_CurrentCamera (copy)
    local Cameras = u2.RBX_PlayerModule:GetCameras();

    return Cameras.activeCameraController and Cameras.activeCameraController:GetSubjectPosition() or workspace_CurrentCamera.CFrame.Position;
end;

function u2.LocalSignals.func_GetCamSubjectPos.OnInvoke() -- Line: 2195
    return getCamSubjectPos();
end;

if not u2.CharReplicator.SupportEmotes then
    local u415 = nil;
    local Part = Instance.new("Part");
    local u416 = nil;
    local ObjectValue = Instance.new("ObjectValue", LocalPlayer);
    ObjectValue.Name = "ShopCamTargetValueFix";
    ObjectValue.Value = LocalPlayer.Character.Humanoid;
    u2.NetworkFunctions.listenTo("setStageEmoteCameraTarget", function(p417) -- Line: 2208
        -- upvalues: ObjectValue (copy), LocalPlayer (copy), DataManager (copy), u415 (ref), Part (copy), workspace_CurrentCamera (copy), u416 (ref), u1 (copy)
        ObjectValue.Value = LocalPlayer.Character.Humanoid;

        if not DataManager:GetData().CameraMoveEmote then
            u1.RunService:UnbindFromRenderStep("_StageEmoteCameraUpdate");

            if workspace_CurrentCamera.CameraSubject ~= LocalPlayer.Character.Humanoid then
                workspace_CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid;
                ObjectValue.Value = LocalPlayer.Character.Humanoid;
            end;

            return;
        end;

        local v418 = getCamSubjectPos();
        u415 = p417;
        Part.CFrame = CFrame.new(v418) or workspace_CurrentCamera.CFrame;
        u416 = CFrame.new(v418) or workspace_CurrentCamera.CFrame;
        u1.RunService:UnbindFromRenderStep("_StageEmoteCameraUpdate");

        if not u415 then
            workspace_CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid;

            return;
        end;

        workspace_CurrentCamera.CameraSubject = Part;
        ObjectValue.Value = Part;
        u1.RunService:BindToRenderStep("_StageEmoteCameraUpdate", Enum.RenderPriority.Camera.Value, function(p419) -- Line: 2221
            -- upvalues: u415 (ref), u416 (ref), Part (ref)
            if u415 then
                u416 = lerpCFrame(p419, Part.CFrame, u415.CFrame, u416);
                Part.CFrame = u416;
            end;
        end);
    end);
end;

u86.updateCam = updateCam;

function u86.setTarget(p420) -- Line: 2241
    -- upvalues: u191 (ref)
    u191 = p420;
end;

function u86.getTarget() -- Line: 2242
    -- upvalues: u191 (ref)
    return u191;
end;

function u86.getCombo() -- Line: 2243
    -- upvalues: u370 (ref)
    return u370;
end;

function u86.getMisses() -- Line: 2244
    -- upvalues: u356 (ref)
    return u356.Miss;
end;

function u86.getAccuracy() -- Line: 2245
    -- upvalues: u368 (ref)
    return u368;
end;

function u86.setCamZooming(p421) -- Line: 2246
    -- upvalues: u138 (ref)
    u138 = p421;
end;

function u86.getCamPosition() -- Line: 2247
    -- upvalues: CFrame2 (ref)
    return CFrame2;
end;

function u86.setCamPosition(p422) -- Line: 2248
    -- upvalues: CFrame2 (ref)
    CFrame2 = p422;
end;

local function lookForAsset(p423, p424, p425) -- Line: 2252
    if not (p424 and p423) then
        return;
    end;

    if not p425 or p425 == "" then
        return p423:FindFirstChild(p424);
    end;

    local v426 = p423:FindFirstChild(p425);

    if v426 then
        return v426:FindFirstChild(p424);
    end;
end;

function u86.getLocalEmoteFolder(p427, p428) -- Line: 2264
    -- upvalues: lookForAsset (copy), u35 (ref)
    return lookForAsset(u35.SongFile:FindFirstChild("Emotes"), p427, p428);
end;

function u86.getLocalAnimFolder(p429, p430) -- Line: 2268
    -- upvalues: lookForAsset (copy), u35 (ref)
    return lookForAsset(u35.SongFile:FindFirstChild("Animations"), p429, p430);
end;

function u86.getAnimFolder(p431, p432) -- Line: 2272
    -- upvalues: lookForAsset (copy), u1 (copy)
    return lookForAsset(u1.ReplicatedStorage.Assets.Animations, p431, p432);
end;

function u86.getEmoteFolder(p433, p434) -- Line: 2276
    -- upvalues: lookForAsset (copy), u1 (copy)
    return lookForAsset(u1.ReplicatedStorage.Assets.Emotes, p433, p434);
end;

function u86.getNoteskinFolder(p435, p436) -- Line: 2280
    -- upvalues: lookForAsset (copy), u1 (copy)
    return lookForAsset(u1.ReplicatedStorage.Assets.Noteskins, p435, p436);
end;

function u86.getNotesplashFolder(p437, p438) -- Line: 2284
    -- upvalues: lookForAsset (copy), u1 (copy)
    return lookForAsset(u1.ReplicatedStorage.Assets.Notesplashes, p437, p438);
end;

function getSetting(p439: string?, p440: string, p441: boolean?)
    -- upvalues: Data (ref), u36 (ref), u4 (ref)
    if not (p439 and (Data.ShowOpponentSettings or p441)) then
        return Data[p440];
    end;

    if p439 == u36 then
        return Data[p440];
    end;

    return u4[p440];
end;

function setSetting(p442: string?, p443: string, p444: any)
    -- upvalues: Data (ref), u36 (ref), u156 (ref), u4 (ref), u109 (copy)
    if p442 and Data.ShowOpponentSettings then
        if p442 == u36 then
            Data[p443] = p444;

            if p443 == "Downscroll" then
                u156.Downscroll = p444;
            end;
        else
            u4[p443] = p444;
            local v445 = p443 == "Downscroll" and u109[u36 == "L" and 1 or 0];

            if v445 then
                v445.Downscroll = p444;
            end;
        end;
    else
        Data[p443] = p444;

        if p443 == "Downscroll" then
            u156.Downscroll = p444;
        end;
    end;
end;

u86.getSetting = getSetting;
u86.setSetting = setSetting;

function loadIcon(p446: any, p447: any, p448: string?, p449: string?, p450: number?, p451: boolean?, p452: number?)
    -- upvalues: u2 (copy), HPBar (ref), u77 (ref), u36 (ref), Data (ref), u4 (ref), u35 (ref), u140 (ref), u134 (ref), u115 (ref), u154 (copy)
    if p446 ~= nil then
        if type(p446) == "string" then
            if not (HPBar and HPBar:FindFirstChild(p446)) then
                u2.Logger.log((`Icon {p446} not found in healthbar, canceling...`));

                return;
            end;

            p446 = HPBar:FindFirstChild(p446);
        end;

        local v453 = p446:FindFirstChild("Sprite") or Instance.new("ImageLabel", p446);

        if p447 == nil or not p447 then
            p447 = nil;
        end;

        local v454 = (p448 == nil or not p448) and "Friday Night Funkin\'" or p448;
        local v455 = p449 == "Left" and "L" or "R";

        if p447 == nil then
            local v456 = nil;

            if u77 then
                if u36 == v455 or not Data.ShowBotCustomIcon then
                    if u36 == v455 and Data.ShowPlayerCustomIcon then
                        local v457 = Data.CustomIconSets[tonumber(Data.CustomIcon or -1)];

                        if v457 then
                            v456 = u2.IconsV2:parseFromDatastore(v457);
                        end;
                    end;
                else
                    local v458 = Data.CustomIconSets[tonumber(Data.OpponentCustomIcon or -1)];

                    if v458 then
                        v456 = u2.IconsV2:parseFromDatastore(v458);
                    end;
                end;
            elseif getSetting(v455, "ShowPlayerCustomIcon", true) then
                local v459 = getSetting(v455, "CustomIcon", true);

                if v455 == u36 or not Data.ShowCustomIcons then
                    if v455 == u36 then
                        local v460 = Data.CustomIconSets[tonumber(v459 or -1)];

                        if v460 then
                            v456 = u2.IconsV2:parseFromDatastore(v460);
                        end;
                    end;
                else
                    local v461 = u4.CustomIconSets[tonumber(v459 or -1)];

                    if v461 then
                        v456 = u2.IconsV2:parseFromDatastore(v461);
                    end;
                end;
            end;

            if v456 then
                p447 = table.clone(v456);

                if p447.FlipAutomatically then
                    p447.Facing = (p447.Facing == "Left" or p447.Facing == "L") and "Left" or "Right";
                else
                    p447.Facing = p449 == "Left" and "Right" or "Left";
                end;
            else
                p447 = p449 == "Left" and "Dad" or "BF";
                local MetaFile = u35.MetaFile;

                if MetaFile and (MetaFile.CustomIcons and Data.UseSongIcons) then
                    if MetaFile.CustomIcons[u35.SongFile.Name .. "-" .. u35.Difficulty] then
                        local v462 = MetaFile.CustomIcons[u35.SongFile.Name .. "-" .. u35.Difficulty];
                        v454 = v462.Path or (MetaFile.IconPack or "Friday Night Funkin\'");

                        if v462.IconPacks and v462.IconPacks[v455] ~= nil then
                            v454 = v462.IconPacks[v455];
                        end;

                        p447 = p449 == "Left" and v462.LeftIcon or (v462.RightIcon or (p449 == "Left" and "Dad" or "BF"));
                    elseif MetaFile.CustomIcons[u35.SongFile.Name] then
                        local v463 = MetaFile.CustomIcons[u35.SongFile.Name];
                        v454 = v463.Path or (MetaFile.IconPack or "Friday Night Funkin\'");

                        if v463.IconPacks and v463.IconPacks[v455] ~= nil then
                            v454 = v463.IconPacks[v455];
                        end;

                        p447 = p449 == "Left" and v463.LeftIcon or (v463.RightIcon or (p449 == "Left" and "Dad" or "BF"));
                    end;
                elseif not Data.UseSongIcons then
                    if u77 then
                        local v464 = v455 ~= u36;
                        p447 = v464 and Data.OpponentIcon or Data.Icon;
                        v454 = v464 and Data.OpponentIconPack or Data.IconPack;
                    else
                        p447 = getSetting(v455, "Icon", true);
                        v454 = getSetting(v455, "IconPack", true);
                    end;
                end;
            end;
        end;

        local v465 = p452 or #u140[v455];
        local u466 = u2.Icons.new(v453, p447, v454);
        local v467 = (p450 == nil or not p450) and 3 or p450;
        u466.Scale = Vector2.new(v467, v467);

        if u466.facing == p449 then
            u466.flipX = true;
        end;

        if p451 then
            u466.flipX = not u466.flipX;
        end;

        local v468 = Vector2.new(u466.iconOffset.X.Scale, u466.iconOffset.Y.Scale) * u466.iconSize / u466.iconScale;
        local X = v468.X;
        local Y = v468.Y;
        u466.offsets.set("x", "_standarizedOffset", X ~= 0 and (function(p469) -- Line: 2431
            -- upvalues: u466 (copy), X (copy)
            local X2 = u466:GetProperty("Scale").X;
            local v470 = u466.flipX and -1 or 1;

            if X2 < 0 then
                X2 = -X2;
                v470 = v470 * -1;
            end;

            return p469 + X * X2 * v470 * 5.688888888888889;
        end or nil) or nil);
        u466.offsets.set("y", "_standarizedOffset", Y ~= 0 and (function(p471) -- Line: 2441
            -- upvalues: u466 (copy), Y (copy)
            local Y2 = u466:GetProperty("Scale").Y;
            local v472 = u466.flipY and -1 or 1;

            if Y2 < 0 then
                Y2 = -Y2;
                v472 = v472 * -1;
            end;

            return p471 + Y * Y2 * v472 * 3.2;
        end or nil) or nil);
        u466.Position = UDim2.fromScale(0.5, 0.5);

        if u466.iconColor ~= nil and v465 == 0 then
            u134:SetHealthbarColor(p449, u466.iconColor);
        end;

        u466.Animations = {};

        if u466.animatedIcon then
            if u466.metadata.Animations then
                for i, v in u466.metadata.Animations do
                    local v473 = u466.XMLPath ~= nil and (u466.XMLPath:FindFirstChild(i) or u466.XMLFile) or u466.XMLFile;
                    local v474 = u466.metadata.Assets ~= nil and (u466.metadata.Assets[i] ~= nil and u466.metadata.Assets[i] or u466.metadata.Asset) or u466.metadata.Asset;

                    if v473 ~= nil then
                        local v475;

                        if u466.metadata.LoopData == nil then
                            v475 = nil;
                        else
                            v475 = u466.metadata.LoopData or nil;
                        end;

                        if v475 then
                            v475 = v475[i];
                        end;

                        if v475 == nil then
                            v475 = not i:match("Trans_");
                        end;

                        u466:AddSparrowXml(v473, i, v, u115 * 24, v475, v473:GetAttribute("Factor") or 1, u466.iconScale, v474);
                    end;
                end;

                u466:ChangeState("Idle", true);
            end;
        else
            local v476 = u466.iconSize.X / u466.iconSize.Y;
            local v477 = {};

            for i = 1, u466.iconCount do
                local v478 = {
                    Size = Vector2.new(u466.iconSize.X, u466.iconSize.Y),
                    Offset = Vector2.new(u466.iconSize.X * (i - 1), 0),
                    FrameSize = Vector2.new(100 * v476, 100) * u466.iconScale
                };
                table.insert(v477, v478);
                local _ = i;
            end;

            u466:AddAnimation("icon", v477, 0, true, u466.metadata.Asset);
            u466:Play("icon", true);
            u466.curFrame = 1;
            u466.overrideFrames = false;
        end;

        table.insert(u154, u466);

        if u140[v455][v465] == nil then
            u140[v455][v465] = u466;
        end;

        u466.Obj.BackgroundTransparency = 1;

        return u466;
    end;

    u2.Logger.log("Icon instance is nil, canceling...");
end;

u86.floatToString = u2.Adapters.floatToString;
local Vector2_new_ret = Vector2.new(1, 1);
workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 2515
    -- upvalues: Obj (ref), u2 (copy), workspace_CurrentCamera (copy), Vector2_new_ret (ref), u136 (copy)
    local v479 = Obj and Obj:FindFirstChildOfClass("UIAspectRatioConstraint");

    if v479 then
        v479 = v479.AspectRatio;
    end;

    local v480 = u2.Adapters.vectorToRatio(workspace_CurrentCamera.ViewportSize * Vector2_new_ret, v479 or 1.7777777777777777);

    for _, v in u136 do
        v(v480);
    end;
end);
u86.linkTextScaling = u2.Adapters.linkTextScaling;

function switchHUD(p481: any, p482: table?)
    -- upvalues: Data (ref), u133 (ref), u137 (ref), u134 (ref), u89 (copy), u154 (copy), u140 (ref), u36 (ref), Obj (ref), _Gameplay (copy), Game (copy), u86 (copy), TimeBar (ref), UIGradient (ref), HPBar (ref), Container (ref), u2 (copy), u35 (ref), u115 (ref), u113 (copy), Tick (ref), TickAvg (ref), u110 (copy), u116 (copy), u117 (copy)
    if Data.DefaultHUD ~= "Default" then
        if Data.ForceHUD then
            p481 = Data.DefaultHUD;
        elseif p481 == "Default" then
            p481 = Data.DefaultHUD;
        end;

        p481 = p481:gsub("[%s:%(%)%.%,%-]", "");
    end;

    u133 = p481;

    if u137 then
        u137.Parent = nil;
    end;

    local v483 = u134.Modchart and u89:getModule(u134.Modchart);

    if v483 then
        u89:singleCall(v483, "clearUp");
        u89:singleCall(v483, "clearUpPost");
        u89:remove(u134.Modchart);
    end;

    for _, v in u154 do
        v:Destroy();
    end;

    table.clear(u154);
    u140 = {
        L = {},
        R = {}
    };
    u134 = u134:Switch(p481, u36);
    Obj = u134.Obj;
    Obj.RootLocalizationTable = _Gameplay.localizationTable;
    local v484 = Obj:FindFirstChildOfClass("UIAspectRatioConstraint");

    if v484 then
        v484.AspectRatio = Game.UIAspectRatioConstraint.AspectRatio;
    end;

    u86.HUDApi = u134;
    u86.HUD = Obj;
    Obj.ZIndex = Data.HUDOverNotes and 2 or 1;
    TimeBar = Obj.TimeBar;
    UIGradient = TimeBar.Time.UIGradient;
    HPBar = Obj.HPBar;
    Container = HPBar.Container;

    if not (Data.ShowInfoOnRight and Obj.SidebarRight) then
        local _ = Obj.SidebarLeft;
    end;

    (Data.ShowInfoOnRight and Obj.SidebarLeft or Obj.SidebarRight).Visible = false;
    local Player1 = HPBar:FindFirstChild("Player1");
    local Player2 = HPBar:FindFirstChild("Player2");

    if Player1 then
        local v485;

        if p482 then
            v485 = p482[1] or nil;
        else
            v485 = nil;
        end;

        loadIcon(Player1, v485, nil, "Left");
    end;

    if Player2 then
        loadIcon(Player2, p482 and p482[2] or nil, nil, "Right");
    end;

    Obj.Watermark.Text = u2.EngineVersion.GetEngineString();
    Obj.Song.Text = `{u35.SongName} [{u35.DisplayDiffName}] - [{u2.Adapters.floatToString(u115)}x]`;
    u134:SetSongData(u35, math.max(u113.timeLength - u113.timePosition, 0) / u115, u115);
    u134:SetTimeColor(Container.BackgroundColor3, Container.Fill.BackgroundColor3);
    Tick = Obj.HitError.Tick;
    TickAvg = Obj.HitError.TickAvg;

    if u137 then
        u137.Parent = Obj;
    end;

    u134:SetVisibility(Data.ShowHUD);
    u134:PostSwitch();

    if u133 ~= "KadeEngine" and (u133 ~= "BaseGame" and u133 ~= "TrollgeFiles") or Data.Middlescroll then
        for _, v in { u110, u116, u117 } do
            for _, v2 in v do
                v2.offsets.set("x", "kadeEngineOffset", nil);
            end;
        end;
    else
        for _, v in { u110, u116, u117 } do
            for _, v2 in v do
                v2.offsets.set("x", "kadeEngineOffset", -48);
            end;
        end;
    end;

    u134:SetTimebarColors({ ColorSequenceKeypoint.new(0, u140.L[0].iconColor), ColorSequenceKeypoint.new(1, u140.R[0].iconColor) });
    local v486 = u134:ConnectModchart();

    if v486 then
        u89:add(v486);
    end;

    updateHUD(0);
    updateStatsLabel();
    updateOppStatsLabel();

    for _, descendant in Obj:GetDescendants() do
        if descendant.ClassName == "TextLabel" then
            u2.Adapters.linkTextScaling(descendant);
        end;
    end;
end;

u86.switchHUD = switchHUD;
u86.loadIcon = loadIcon;

function u86.getCurrentHUD() -- Line: 2649
    -- upvalues: u133 (ref)
    return u133;
end;

function u86.getIcons() -- Line: 2653
    -- upvalues: u140 (ref)
    return u140;
end;

shared.iconSprites = u154;
shared.iconData = u140;
local u487 = 60;
local u488 = 0;
local u489 = 0;

function getCurrentFPS()
    -- upvalues: u487 (ref)
    return u487;
end;

u86.canTrackMem = u1.Stats.MemoryTrackingEnabled;

function getCurrentMemory()
    -- upvalues: u86 (copy), u1 (copy)
    return not u86.canTrackMem and 0 or round(u1.Stats:GetTotalMemoryUsageMb(), 0);
end;

u86.getCurrentFPS = getCurrentFPS;
u86.getCurrentMemory = getCurrentMemory;
local u490 = 0;

function updateDebugger(p491)
    -- upvalues: u488 (ref), u489 (ref), u487 (ref), Data (ref), DebugLabel (copy), u86 (copy), u2 (copy), _Gameplay (copy)
    u488 = u488 + 1;
    u489 = u489 + p491;
    local v492;

    if u489 >= 0.1 then
        u487 = math.round(u488 / u489);
        u488 = 0;
        u489 = u489 - 0.1;
        v492 = true;
    else
        v492 = false;
    end;

    if not v492 then
        return;
    end;

    if not (Data.ShowDebugInfo or Data.ShowFPSMemInfo) then
        return;
    end;

    if DebugLabel == nil then
        return;
    end;

    DebugLabel.Visible = Data.ShowDebugInfo or Data.ShowFPSMemInfo;
    local v493 = tostring(getCurrentFPS());
    local v494;

    if u86.canTrackMem then
        local v495 = getCurrentMemory();
        local v496;

        if v495 > 1000 then
            v496 = v495 / 1000 or v495;
        else
            v496 = v495;
        end;

        v494 = tostring(v496) .. (v495 > 1000 and "GB" or "MB");
    else
        v494 = "Disabled";
    end;

    local CacheSize = u2.Note.getCacheSize();
    local CacheSize2 = u2.NoteSplash.getCacheSize();

    if u2.EngineVersion.IsStudio() then
        v494 = v494 .. " (Studio Playtest)";
    end;

    local v497 = {
        fps = v493,
        mem = v494
    };
    local v498 = {
        step = u2.Conductor.Step,
        beat = u2.Conductor.Beat,
        measure = u2.Conductor.Measure,
        stepsPerBeat = u2.Conductor.StepsPerBeat,
        beatsPerMeasure = u2.Conductor.BeatsPerMeasure,
        bpm = u2.Conductor.BPM,
        timePos = round(u2.Conductor.SongPosition / 1000, 2),
        noteCache = CacheSize,
        splashCache = CacheSize2
    };
    local v499 = Data.ShowFPSMemInfo and _Gameplay.Format("HUD.PerfDisplay", v497) or "";
    local v500 = Data.ShowDebugInfo and _Gameplay.Format("HUD.DebugDisplay", v498) or "";
    local v501 = (v499 .. (v499 == "" and "" or "\n\n") .. v500):gsub("\n$", "");
    local v502 = #string.split(v501, "\n");
    DebugLabel.Text = v501;
    DebugLabel.Size = UDim2.fromScale(1, v502 * 0.022727272727272728);
    DebugLabel.TextXAlignment = Data.AlignDebugToRight and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left;
end;

function updateHUD(p503)
    -- upvalues: u158 (ref), u490 (ref), u141 (copy), Data (ref), u358 (ref), u35 (ref), u113 (copy), u114 (ref), u115 (ref), u2 (copy), _Gameplay (copy), u73 (copy), UIGradient (ref), u134 (ref), u142 (copy), u144 (copy), u157 (ref), u36 (ref), u140 (ref), u3 (copy), u360 (ref), u363 (ref)
    if u158 then
        u490 = u490 + 180 * p503;
        u141.Text = "[BOTPLAY]";
        u141.TextTransparency = math.sin(3.141592653589793 * u490 / 180);
        u141.Position = UDim2.fromScale(0.5, Data.Downscroll and 0.85 or 0.125);
    end;

    if Data.BloxstrapData.AllowDiscordRPC and (u358 == nil or u358 ~= u35.SongName) then
        local v504 = os.time() - u113.timePosition;
        local v505 = (u114 or u113.timeLength) / u115;
        u358 = u35.SongName;
        u2.DiscordRPC.SetRichPresence({
            state = _Gameplay.Format(table.find(u73, u35.ModName) and "RPC.PlayingCensored" or "RPC.Playing", {
                playbackRate = u115,
                songName = u35.SongName,
                diffName = u35.DisplayDiffName
            }),
            timeStart = v504,
            timeEnd = v504 + v505
        });
    end;

    if Data.ShowHUD then
        local v506 = u2.Conductor.RawTimePosition > 0 and u113.timePosition / u115 or 0;
        local v507 = (u114 or u113.timeLength) / u115;
        local math_max_ret = math.max(0, v507 - v506);
        local v508 = v506 / v507;
        local math_max_ret2 = math.max(0, Data.TimeBarType == "Time Left" and math_max_ret // 1 or v506 // u115);
        local v509 = u2.Adapters.SecondsToMMSS(math_max_ret2);
        u2.MathFuncs:setGradientTransPoint(UIGradient, v508 ~= v508 and 0 or v508);
        u134:SetInformation({
            SongName = u35.SongName,
            Difficulty = u35.DisplayDiffName,
            TimePastString = u2.Adapters.SecondsToMMSS(v506 // 1),
            TimeLeftString = u2.Adapters.SecondsToMMSS(math_max_ret // 1),
            TimeType = v509,
            PlaybackRate = u115,
            Settings = Data,
            SongLength = v507
        });
        u134:SetSongData(u35, math_max_ret, u115);

        if Data.ShowBreakTimer then
            setObjPropWithIndex(u142, "Visible", true, "ProgBar_Visible");
            setObjPropWithIndex(u142, "Position", UDim2.fromScale(0.5, Data.Downscroll and 0.75 or 0.225), "ProgBar_Position");
            u144.Functions.Update(p503);
        end;

        local visualHealth = u157.visualHealth;

        if u36 == "L" then
            visualHealth = u157.totalHealth - visualHealth or visualHealth;
        end;

        local v510 = visualHealth / u157.totalHealth;

        for i, v in u140 do
            local v511 = i;

            for i2, v2 in v do
                if not v2.overridePos then
                    setObjPropWithIndex(v2.obj.Parent, "Position", UDim2.fromScale((u157.flipHealthbar and v510 and v510 or 1 - v510) + (u157.flipHealthbar and 0.0125 or -0.0125) * (v2.posIndex or i2 + 1) + (v511 == "L" and -1 or 1) * 0.025 + v2.posOffset.X.Scale, 0.5 + v2.posOffset.Y.Scale), v511 .. "IconP" .. i2 .. "_Position");
                end;
            end;
        end;

        local v512;

        if u157.flipHealthbar then
            v512 = 1 - v510 or v510;
        else
            v512 = v510;
        end;

        u134:SetHealth(v512);

        local function updateIcon(p513, p514, p515) -- Line: 2827
            if not p513 or p513.overrideFrames then
                return;
            end;

            if p513.animatedIcon then
                local v516 = p514 == "Overlose" and "Lose" or p514;
                local v517 = v516 == "Overwin" and "Win" or v516;

                if p513:animExists(v517) then
                    p513:ChangeState(v517);
                end;
            else
                local v518 = #p513.curAnimData.Frames;
                local v519 = v518 < 5 and p514 == "Overlose" and "Lose" or p514;
                local v520 = v518 < 4 and v519 == "Overwin" and "Win" or v519;
                local v521 = v518 < 3 and v520 == "Win" and "Idle" or v520;
                local v522 = v518 < 2 and v521 == "Lose" and "Idle" or v521;
                p513.curFrame = v522 == "Idle" and 1 or (v522 == "Lose" and 2 or (v522 == "Win" and 3 or (v522 == "Overwin" and 4 or (v522 == "Overlose" and 5 or false))));
            end;
        end;

        for i, v in u140 do
            local v523 = i;

            for _, v2 in v do
                if u157.winHealth <= v510 then
                    local v524;

                    if v523 == "L" then
                        v524 = u157.overwinHealth <= v510 and "Overlose" or "Lose";
                    else
                        v524 = u157.overwinHealth <= v510 and "Overwin" or "Win";
                    end;

                    updateIcon(v2, v524);
                elseif v510 <= u157.loseHealth then
                    local v525;

                    if v523 == "L" then
                        v525 = v510 <= u157.overloseHealth and "Overwin" or "Win";
                    else
                        v525 = v510 <= u157.overloseHealth and "Overlose" or "Lose";
                    end;

                    updateIcon(v2, v525, v510);
                else
                    updateIcon(v2, "Idle", v510);
                end;

                if not v2.overrideBop and v2.obj.Parent:FindFirstChild("UIScale") then
                    u3.iconBops.Update(p503, v2.obj.Parent, getSetting(v523, "IconBop"), u115, {
                        Beat = u360,
                        Side = v523 == "L" and "Left" or "Right",
                        MustHit = v523 == "L" and u363 == 0 and true or u363 == 1,
                        Conductor = u2.Conductor,
                        Sprite = v2,
                        HealthStatus = v510
                    });
                end;
            end;
        end;
    end;
end;

local u526 = {};

function getHitTick(p527: userdata)
    -- upvalues: u526 (copy), Tick (ref)
    local table_remove_ret = table.remove(u526);

    if not table_remove_ret then
        table_remove_ret = Tick:Clone();
        table_remove_ret.Parent = p527;
    end;

    table_remove_ret.BackgroundTransparency = 0;
    table_remove_ret.Visible = true;

    return table_remove_ret;
end;

function releaseHitTick(p528: userdata)
    -- upvalues: u526 (copy)
    p528.Visible = false;
    table.insert(u526, p528);
end;

function doHitError(p529)
    -- upvalues: Data (ref), u2 (copy), Obj (ref), TickAvg (ref), u1 (copy)
    if not Data.ShowHitError then
        return;
    end;

    if not Data.ShowHUD then
        return;
    end;

    local v530 = math.clamp(p529, -u2.Conductor.SafeZoneOffset, u2.Conductor.SafeZoneOffset) / u2.Conductor.SafeZoneOffset / 2;
    local u531 = getHitTick(Obj.HitError.Ticks);
    u531.Position = UDim2.fromScale(0.5 + v530, 0.5);
    u531.BackgroundColor3 = Color3.new(1, 1, 1);
    u531.Visible = true;
    TickAvg:TweenPosition(UDim2.new(0.25 + v530 / 2 + TickAvg.Position.X.Scale / 2, 0, 0.5, 10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true);
    local v532 = u1.TweenService:Create(u531, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    });
    v532:Play();
    v532.Completed:Connect(function() -- Line: 2921
        -- upvalues: u531 (copy)
        releaseHitTick(u531);
    end);
end;

function showNowPlaying(p533: string?, p534: string?, p535: any)
    -- upvalues: Data (ref), u24 (copy), u35 (ref), u33 (ref), Overlay (copy), u36 (ref), u1 (copy)
    if not Data.ShowNowPlaying or u24.skipNowPlaying then
        return;
    end;

    if not Data.ShowHUD then
        return;
    end;

    local MetaFile = u35.MetaFile;
    local _ = p533 or u35.SongName;

    if u33.artist ~= nil or u33.artist ~= "Unknown" then
        p534 = u33.artist;
    end;

    if MetaFile then
        if not p535 then
            if MetaFile.Colors and MetaFile.Colors[u35.SongFile.Name] then
                p535 = MetaFile.Colors[u35.SongFile.Name];
            elseif MetaFile.Color then
                p535 = MetaFile.Color;
            end;
        end;

        if p534 == nil then
            local v536;

            if MetaFile.ExtraCredits then
                v536 = MetaFile.ExtraCredits[u35.SongFile.Name] or nil;
            else
                v536 = nil;
            end;

            if v536 then
                if v536.Artists then
                    if typeof(v536.Artists) == "string" then
                        p534 = v536.Artists;
                    elseif typeof(v536.Artists) == "table" then
                        if v536.Artists[u35.Difficulty] then
                            p534 = v536.Artists[u35.Difficulty];
                        elseif v536.Artists._Default then
                            p534 = v536.Artists._Default;
                        end;
                    end;
                elseif v536.Artist then
                    if typeof(v536.Artist) == "string" then
                        p534 = v536.Artist;
                    elseif typeof(v536.Artist) == "table" then
                        if v536.Artist[u35.Difficulty] then
                            p534 = v536.Artist[u35.Difficulty];
                        elseif v536.Artist._Default then
                            p534 = v536.Artist._Default;
                        end;
                    end;
                end;
            end;

            if p534 == nil then
                if MetaFile.Artists then
                    if typeof(MetaFile.Artists) == "string" then
                        p534 = MetaFile.Artists;
                    elseif typeof(MetaFile.Artists) == "table" then
                        if MetaFile.Artists[u35.Difficulty] then
                            p534 = MetaFile.Artists[u35.Difficulty];
                        elseif MetaFile.Artists._Default then
                            p534 = MetaFile.Artists._Default;
                        end;
                    end;
                elseif MetaFile.Artist then
                    if typeof(MetaFile.Artist) == "string" then
                        p534 = MetaFile.Artist;
                    elseif typeof(MetaFile.Artist) == "table" then
                        if MetaFile.Artist[u35.Difficulty] then
                            p534 = MetaFile.Artist[u35.Difficulty];
                        elseif MetaFile.Artist._Default then
                            p534 = MetaFile.Artist._Default;
                        end;
                    end;
                end;
            end;
        end;
    end;

    local v537 = p535 or Color3.fromRGB(255, 255, 255);
    local u538 = Overlay:FindFirstChild((`NowPlaying{u36}{p534 == nil and "" or "WArtist"}`)):Clone();
    u538.Visible = true;
    u538.Parent = Overlay;
    u538.SongLabel.Text = u35.SongName;

    if typeof(v537) == "Color3" then
        u538.Color.BackgroundColor3 = v537 or Color3.fromRGB(255, 255, 255);
    else
        u538.Color.UIGradient.Color = v537 or ColorSequence.new(Color3.fromRGB(255, 255, 255));
    end;

    if p534 ~= nil then
        u538.ArtistLabel.Text = `<i>By:</i> <b>{p534}</b>`;
    end;

    u1.Debris:AddItem(u538, 6);
    u1.TweenService:Create(u538, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        AnchorPoint = Vector2.new(u36 == "L" and 0 or 1, 0)
    }):Play();
    task.delay(4, function() -- Line: 3018
        -- upvalues: u1 (ref), u538 (copy), u36 (ref)
        u1.TweenService:Create(u538, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
            AnchorPoint = Vector2.new(u36 == "L" and 1 or 0, 0)
        }):Play();
    end);
end;

function showPlayerLeft(p539: string, u540: number, p541: boolean)
    -- upvalues: u36 (ref), Overlay (copy), u1 (copy)
    local u542 = (u36 == "L" and Overlay.PlayerLeftR or Overlay.PlayerLeftL):Clone();
    u542.Visible = true;
    u542.Parent = Overlay;
    u542.PlayerLeftLabel.Text = p541 and "Teammate Left" or "Opponent Left";
    u542.PlayerLeftUsername.Text = p539 and "@" .. p539 or "???";
    u542.PlayerPFP.ImageContent = Content.none;
    task.spawn(function() -- Line: 3032
        -- upvalues: u1 (ref), u540 (copy), u542 (copy)
        pcall(function() -- Line: 3033
            -- upvalues: u1 (ref), u540 (ref), u542 (ref)
            local UserThumbnailAsync = u1.Players:GetUserThumbnailAsync(u540, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180);
            u542.PlayerPFP.ImageContent = Content.fromUri(UserThumbnailAsync);
        end);
    end);
    u1.Debris:AddItem(u542, 7);
    u1.TweenService:Create(u542, TweenInfo.new(1), {
        Position = UDim2.fromScale(u36 == "L" and 1 or 0, 0.1)
    }):Play();
    task.delay(4, function() -- Line: 3041
        -- upvalues: u1 (ref), u542 (copy), u36 (ref)
        u1.TweenService:Create(u542, TweenInfo.new(1), {
            Position = UDim2.fromScale(u36 == "L" and 1.25 or -0.25, 0.1)
        }):Play();
    end);
end;

u86.showNowPlaying = showNowPlaying;

function getRandomColor()
    -- upvalues: Random_new_ret (copy)
    return Color3.new(Random_new_ret:NextNumber(0, 1), Random_new_ret:NextNumber(0, 1), Random_new_ret:NextNumber(0, 1));
end;

u86.getRandomColor = getRandomColor;
local RatingManager = u3.RatingManager;
RatingManager.init({
    Templates = Assets.Templates,
    RatingsContainer = RatingsContainer
});

function spawnJudgement(...)
    -- upvalues: RatingManager (copy), u86 (copy), Data (ref), u115 (ref), Asset (ref), u89 (copy)
    u89:call("onRatingSpawned", (RatingManager.createJudgement({
        globals = u86,
        settings = Data,
        playbackRate = u115,
        selectedJudgementSet = Asset
    }, ...)));
end;

function spawnCombo(...)
    -- upvalues: RatingManager (copy), u86 (copy), Data (ref), u115 (ref), Asset (ref), u89 (copy)
    u89:call("onComboSpawned", (RatingManager.createCombo({
        globals = u86,
        settings = Data,
        playbackRate = u115,
        selectedJudgementSet = Asset
    }, ...)));
end;

function spawnJudgementOffset(...)
    -- upvalues: RatingManager (copy), u86 (copy), Data (ref), u115 (ref), Asset (ref), u89 (copy)
    u89:call("onOffsetSpawned", (RatingManager.createJudgementOffset({
        globals = u86,
        settings = Data,
        playbackRate = u115,
        selectedJudgementSet = Asset
    }, ...)));
end;

u86.getRating = u2.ratingModule.getJudgementTitle;
u86.getRatingLetter = u2.ratingModule.getRatingLetter;
DataManager.DataChanged:Connect(function(p543) -- Line: 3098
    -- upvalues: u130 (copy), Data (ref)
    if p543 == "GlobalVolume" then
        for _, v in u130 do
            local Object = v.Object;

            if Object ~= nil then
                Object.Volume = v.Volume * (Data.GlobalVolume / 10);
            end;
        end;
    end;
end);

function u86.getTrackedSounds() -- Line: 3109
    -- upvalues: u130 (copy)
    return u130;
end;

function u86.addToTrackedSounds(p544: userdata) -- Line: 3110
    -- upvalues: u130 (copy)
    table.insert(u130, {
        Object = p544,
        Volume = p544.Volume
    });
end;

u86.cacheSound = u2.SoundPlayer.CacheSound;
u86.playSound = u2.SoundPlayer.PlayTrackedSound;
local u545 = { 7, 6 };

function u86.getAllowedFlipTypes() -- Line: 3116
    -- upvalues: u545 (copy)
    return u545;
end;

u86.getDefaultX = u2.MathFuncs.getDefaultX;
u86.setStrumGroupToPoint = u2.MathFuncs.setStrumGroupToPoint;
u86.getStrumGroupCenter = u2.MathFuncs.getStrumGroupCenter;
u86.getRawXPoint = u2.MathFuncs.getRawXPoint;
u86.getRawStartPoint = u2.MathFuncs.getRawStartPoint;
u86.getRawPlrOffset = u2.MathFuncs.getRawPlrOffset;

function changeCurrentStrumline(p546)
    -- upvalues: u109 (copy), u156 (ref), u112 (ref), u111 (ref), u86 (copy), u89 (copy)
    if type(p546) == "number" then
        p546 = u109[p546];
    end;

    if not p546 then
        return;
    end;

    if u156 then
        for _, v in u156.Strums or {} do
            v:Play("static");
        end;

        p546:showKeybindReminders();
    end;

    u112 = p546.Index % 2 == 0 and u109[p546.Index + 1] or u109[p546.Index - 1];
    u111 = p546;
    u156 = p546;
    u86.currentStrumline = p546;
    syncAllMobileLaneTiles();
    u89:call("onStrumlineChange", p546);
end;

function u86.setSustainClipping(p547, p548) -- Line: 3149
    -- upvalues: u109 (copy)
    u109[p547 == "L" and 0 or 1].ClipSustains = p548;
end;

u86.changeStrumline = changeCurrentStrumline;
u86.changeCurrentStrumline = changeCurrentStrumline;
u86.createStrumline = u2.Strumline.new;

function resetRatio()
    -- upvalues: u86 (copy)
    u86.changeGameRatio(1.7777777777777777);
end;

function u86.changeGameRatio(p549, p550) -- Line: 3159
    -- upvalues: Game (copy), Obj (ref), u2 (copy), u110 (copy), u117 (copy), u116 (copy), workspace_CurrentCamera (copy), u136 (copy)
    local v551 = p549 or 1.7777777777777777;
    Game.UIAspectRatioConstraint.AspectRatio = v551;

    if not p550 then
        local v552 = Obj and Obj:FindFirstChildOfClass("UIAspectRatioConstraint");

        if v552 then
            v552.AspectRatio = v551;
        end;
    end;

    local v553 = u2.Adapters.vectorToRatio(Vector2.new(1280, 720), v551);
    local math_min_ret = math.min(v551 / 1.7777777777777777, 1);
    local v554 = 1.7777777777777777 / v551;

    for _, v in u110 do
        v.sFactors = v553;
        v.offsets.set("Scale", "_clientGameRatioFix", math_min_ret);
        v.sizeCache = {};
    end;

    for _, v in u117 do
        v.sFactors = v553;
        v.offsets.set("Scale", "_clientGameRatioFix", math_min_ret);
        v.sizeCache = {};
    end;

    for _, v in u116 do
        v.sFactors = v553;
        v.offsets.set("Scale", "_clientGameRatioFix", math_min_ret);

        if v.sustainNote and not v.isEnd then
            v.offsets.set("Scale", "_clientSustainGameRatioFix", Vector2.new(1, v554));
        end;

        v.sizeCache = {};
    end;

    local v555 = u2.Adapters.vectorToRatio(workspace_CurrentCamera.ViewportSize, v551);

    for _, v in u136 do
        v(v555);
    end;
end;

local u556 = {};

function mapVelocityChanges(p557)
    -- upvalues: u251 (ref), u127 (ref), u556 (ref)
    local v558 = p557 or u251;
    local v559 = {};

    if u127 ~= nil and #u127 ~= 0 then
        local v560 = u127[1].startTime * (v558 * u127[1].multiplier);
        table.insert(v559, v560);

        for i = 2, #u127 do
            v560 = v560 + (u127[i].startTime - u127[i - 1].startTime) * (v558 * u127[i - 1].multiplier);
            table.insert(v559, v560);
            local _ = i;
        end;

        u556 = v559;

        return v559;
    end;
end;

function getPosFromTimeSV(p561, p562)
    -- upvalues: u251 (ref), u556 (ref), u127 (ref)
    if p562 == 0 or p562 == nil then
        return p561 * u251;
    end;

    local v563 = p562 - 1;

    return u556[v563 + 1] + (p561 - u127[v563 + 1].startTime) * (u251 * u127[v563 + 1].multiplier);
end;

function getPosFromTime(p564)
    -- upvalues: u127 (ref)
    local v565 = 0;

    while v565 < #u127 and p564 >= u127[v565 + 1].startTime do
        v565 = v565 + 1;
    end;

    return getPosFromTimeSV(p564, v565);
end;

function getSVFromTime(p566)
    -- upvalues: u127 (ref), u251 (ref)
    local v567 = 0;

    while v567 < #u127 and p566 >= u127[v567 + 1].startTime do
        v567 = v567 + 1;
    end;

    local v568 = v567 - 1;

    if v568 <= 0 then
        return u251;
    end;

    return u251 * u127[v568 + 1].multiplier;
end;

function getSpeed(p569)
    -- upvalues: u251 (ref)
    return getSVFromTime(p569) * (u251 * 2.2222222222222223);
end;

u86.svFunctions = {
    mapVelocityChanges = mapVelocityChanges,
    getPosFromTime = getPosFromTime,
    getSVFromTime = getSVFromTime,
    getSpeed = getSpeed,
    getPosFromTimeSV = getPosFromTimeSV,
    sliderVelocities = u127
};
u86.getTweenStyle = u2.Adapters.getTweenStyle;
u86.getTweenDir = u2.Adapters.getTweenDir;

function getProperty(p570)
    -- upvalues: u181 (ref), u182 (ref), u138 (ref), u183 (ref), u157 (ref), u2 (copy)
    local string_split_ret = string.split(p570, ".");
    local v571 = string_split_ret[1] == "camHUD" and u181 or string_split_ret[1] == "camGame" and u182 or (string_split_ret[1] == "camZooming" and u138 or string_split_ret[1] == "cameraInfo" and u183 or (string_split_ret[1] == "healthStats" and u157 or nil));

    if v571 == nil then
        return;
    end;

    if string_split_ret[1] == "camZooming" then
        return u138;
    end;

    if #string_split_ret <= 2 then
        if string_split_ret[2] == nil then
            return v571;
        end;

        return v571[string_split_ret[2]];
    end;

    for i = 2, #string_split_ret - 1 do
        v571 = v571[string_split_ret[i]];

        if v571 == nil then
            break;
        end;

        local _ = i;
    end;

    if v571 ~= nil then
        return v571[string_split_ret[#string_split_ret]];
    end;

    u2.Logger.log("Invalid property \'" .. p570 .. "\'!");
end;

function setProperty(u572, u573)
    -- upvalues: u181 (ref), u182 (ref), u138 (ref), u363 (ref), u183 (ref), u157 (ref), u2 (copy)
    local string_split_ret = string.split(u572, ".");
    local v574 = string_split_ret[1] == "camHUD" and u181 or string_split_ret[1] == "camGame" and u182 or (string_split_ret[1] == "camZooming" and u138 or string_split_ret[1] == "cameraTargetId" and u363) or (string_split_ret[1] == "cameraInfo" and u183 or string_split_ret[1] == "healthStats" and u157 or (string_split_ret[1] == "cams" and { u181, u182 } or nil));

    if v574 == nil then
        return;
    end;

    local function setTarget(p575) -- Line: 3326
        -- upvalues: string_split_ret (copy), u138 (ref), u573 (copy), u363 (ref), u2 (ref), u572 (copy)
        if string_split_ret[1] == "camZooming" then
            u138 = u573;

            return;
        end;

        if string_split_ret[1] == "cameraTargetId" then
            u363 = u573;

            return;
        end;

        if #string_split_ret <= 2 then
            p575[string_split_ret[2]] = u573;

            return;
        end;

        for i = 2, #string_split_ret - 1 do
            p575 = p575[string_split_ret[i]];

            if p575 == nil then
                break;
            end;

            local _ = i;
        end;

        if p575 == nil then
            u2.Logger.log("Invalid property \'" .. u572 .. "\'!");

            return;
        end;

        p575[string_split_ret[#string_split_ret]] = u573;
    end;

    if type(v574) == "table" and string_split_ret[1] == "cams" then
        for _, v in v574 do
            setTarget(v);
        end;

        return;
    end;

    setTarget(v574);
end;

function cancelTweensOf(p576)
    -- upvalues: u181 (ref), u182 (ref), u183 (ref), u157 (ref), u2 (copy)
    local string_split_ret = string.split(p576, ".");
    local v577 = string_split_ret[1] == "camHUD" and u181 or (string_split_ret[1] == "camGame" and u182 or string_split_ret[1] == "cameraInfo" and u183 or (string_split_ret[1] == "healthStats" and u157 or nil));

    if v577 == nil then
        return;
    end;

    if #string_split_ret <= 2 then
        u2.varTweener:CancelTweensOf(v577, string_split_ret[2]);

        return;
    end;

    for i = 2, #string_split_ret - 1 do
        v577 = v577[string_split_ret[i]];
        local _ = i;
    end;

    u2.varTweener:CancelTweensOf(v577, string_split_ret[#string_split_ret]);
end;

function tweenProperty(p578, p579, p580, p581, p582)
    -- upvalues: u181 (ref), u182 (ref), u183 (ref), u157 (ref), u2 (copy)
    local string_split_ret = string.split(p578, ".");
    local v583 = string_split_ret[1] == "camHUD" and u181 or (string_split_ret[1] == "camGame" and u182 or string_split_ret[1] == "cameraInfo" and u183 or (string_split_ret[1] == "healthStats" and u157 or nil));

    if v583 == nil then
        return;
    end;

    local v584 = {
        Duration = p580,
        Ease = p581
    };
    local v585;

    if #string_split_ret > 2 then
        for i = 2, #string_split_ret - 1 do
            v583 = v583[string_split_ret[i]];
            local _ = i;
        end;

        v585 = u2.varTweener:Create(v583, v584, {
            [string_split_ret[#string_split_ret]] = p579
        });
    else
        v585 = u2.varTweener:Create(v583, v584, {
            [string_split_ret[2]] = p579
        });
    end;

    if v585 then
        v585:Play();

        if p582 then
            v585.Completed:Connect(p582);
        end;

        return v585;
    end;
end;

local u586 = {
    enabled = false,
    simulated = false,
    onlySimulated = false,
    x = 0,
    y = 0,
    w = 1280,
    h = 720,
    scaleX = 1280,
    scaleY = 720,
    savedPos = {
        x = 0,
        y = 0,
        w = 1280,
        h = 720
    }
};
local u587 = nil;
local u588 = true;
local u589 = -1;
local u590 = {};
local SimulatedWindow = Main.SimulatedWindow;
local u591 = "Project: Afternight";

function resetWindowTable()
    -- upvalues: u586 (ref)
    u586 = {
        enabled = false,
        simulated = false,
        onlySimulated = false,
        x = 0,
        y = 0,
        w = 1280,
        h = 720,
        scaleX = 1280,
        scaleY = 720,
        savedPos = {
            x = 0,
            y = 0,
            w = 1280,
            h = 720
        }
    };
end;

function createWindow(p592, p593, p594, p595, p596, p597, p598, p599)
    -- upvalues: u589 (ref), u586 (ref), u2 (copy), Main (copy), u590 (copy)
    u589 = u589 + 1;

    if not u586.simulated then
        return u2.DiscordRPC.CreateWindow({
            reset = false,
            x = p592,
            y = p593,
            width = p594,
            height = p595,
            scaleWidth = p596,
            scaleHeight = p597,
            windowId = p598,
            image = p599
        });
    end;

    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Image = "rbxassetid://" .. p599 or "";
    ImageLabel.Name = "FakeWindow";
    ImageLabel.Parent = Main;
    ImageLabel.ZIndex = 9;
    ImageLabel.Position = UDim2.fromScale(p592 / p596, p593 / p597);
    ImageLabel.Size = UDim2.fromScale(p594 / p596, p595 / p597);
    ImageLabel.BackgroundTransparency = 0.5;
    u590[u589] = ImageLabel;

    return u589;
end;

function destroyWindow(p600)
    -- upvalues: u590 (copy)
    if typeof(p600) == "Instance" then
        p600:Destroy();

        return;
    end;

    if u590[p600] then
        u590[p600]:Destroy();
        table.remove(u590, p600);
    end;
end;

function updateSimWinTimer()
    -- upvalues: LocalPlayer (copy), SimulatedWindow (copy)
    local v601 = `{os.date("%H:%M")}\n{DateTime.now():FormatLocalTime("L", LocalPlayer.LocaleId)}`;
    SimulatedWindow.BG.Taskbar.Right.Clock.Text = v601;
    SimulatedWindow.BG2.Taskbar.Right.Clock.Text = v601;
end;

function spawnInfLoopTimerUpdate()
    -- upvalues: u132 (copy)
    updateSimWinTimer();
    local task_delay = task.delay;
    local v602 = 60 - DateTime.now():ToLocalTime().Second;
    table.insert(u132, task_delay(v602, spawnInfLoopTimerUpdate));
end;

function initWindowMovement(p603: boolean)
    -- upvalues: u2 (copy), Data (ref), u586 (ref), u86 (copy), u588 (ref), u591 (ref), SimulatedWindow (copy)
    resetWindowTable();
    updateBGGradients();
    u2.DiscordRPC.CheckWindowPermission();
    local v604;

    if u2.EngineVersion.IsStudio() or not u2.DiscordRPC.IsGameAllowed then
        v604 = false;
    else
        v604 = Data.BloxstrapData.AllowWindowMove or false;
    end;

    u586.onlySimulated = not v604;
    u586.simulated = p603 or not v604;
    u86.windowOnlySimulated = u586.onlySimulated;
    u86.isSimulatedWindow = u586.simulated;
    u588 = true;
    u2.DiscordRPC.StartWindow();

    if u586.simulated then
        spawnInfLoopTimerUpdate();
        setTitle(u591);
        SimulatedWindow.Visible = true;
    end;

    u586.enabled = true;
    setWallpaper();
end;

function setWindow(p605: number?, p606: number?, p607: number?, p608: number?, p609: number?, p610: number?, p611: number?, p612: number?)
    -- upvalues: u588 (ref), u586 (ref), u2 (copy), u590 (copy), u587 (ref)
    u588 = true;

    if not u586.simulated then
        return u2.DiscordRPC.SetWindow({
            x = p605,
            y = p606,
            width = p607,
            height = p608,
            scaleWidth = p609,
            scaleHeight = p610,
            reset = p611
        });
    end;

    if p612 ~= nil then
        local v613 = u590[p612];

        if not v613 then
            return;
        end;

        v613.Position = UDim2.fromScale(p605 / p609, p606 / p610);
        v613.Size = UDim2.fromScale(p607 / p609, p608 / p610);

        return;
    end;

    u586.x = p605 or u586.x;
    u586.y = p606 or u586.y;
    u586.w = p607 or u586.w;
    u586.h = p608 or u586.h;
    u586.scaleX = p609 or u586.scaleX;
    u586.scaleY = p610 or u586.scaleY;
    updateBGGradients();

    if not u587 then
        return;
    end;

    local w = u586.w;
    local h = u586.h;
    local scaleX = u586.scaleX;
    local scaleY = u586.scaleY;

    if not u587 then
        return;
    end;

    u587.Position = UDim2.fromScale(u586.x / scaleX, u586.y / scaleY);
    u587.Size = UDim2.fromScale(w / scaleX, h / scaleY);
end;

function restoreWindow()
    -- upvalues: u586 (ref), u2 (copy), u587 (ref)
    if not u586.simulated then
        return u2.DiscordRPC.ResetWindow();
    end;

    for i, v in u586.savedPos do
        u586[i] = v;
    end;

    updateBGGradients();

    if not u587 then
        return;
    end;

    u587.Position = UDim2.fromScale(0, 0);
    u587.Size = UDim2.fromScale(1, 1);
end;

function clearWindow()
    -- upvalues: u586 (ref), u2 (copy), u587 (ref), u590 (copy), SimulatedWindow (copy), u86 (copy)
    if not u586.enabled then
        return;
    end;

    u2.DiscordRPC.StopWindow();
    setDesktopIconsVisible(true);
    setDesktopTaskbarVisible(true);
    setWallpaper();
    setTitle();
    setWindowBorderless();

    if u587 then
        u587:Destroy();
        u587 = nil;
    end;

    for _, v in u590 do
        destroyWindow(v);
    end;

    SimulatedWindow.Visible = false;
    table.clear(u590);
    updateBGGradients();
    u86.isSimulatedWindow = false;
    resetWindowTable();
end;

function setTitle(p614)
    -- upvalues: u591 (ref), u586 (ref), SimulatedWindow (copy), Data (ref), u2 (copy)
    u591 = p614 or "Project: Afternight";

    if u586.simulated then
        SimulatedWindow.TopBarContainer.Title.Text = u591;

        return;
    end;

    if Data.BloxstrapData.AllowWindowTitle then
        u2.DiscordRPC.SetTitle(u591);
    end;
end;

function setWindowBorderless(p615)
    -- upvalues: u2 (copy), u586 (ref), SimulatedWindow (copy)
    if p615 == nil then
        p615 = false;
    end;

    u2.DiscordRPC.SetWindowBorderless(p615);

    if u586.simulated then
        SimulatedWindow.TopBarContainer.Visible = not p615;
    end;
end;

function sendNotification(p616, p617, p618)
    -- upvalues: u2 (copy), u586 (ref), SimulatedWindow (copy)
    u2.DiscordRPC.SendNotification(p616, p617, p618);

    if u586.simulated then
        local v619 = p616 or "[[MISSING TITLE]]";
        local v620 = p617 or "[[MISSING CAPTION]]";
        local u621 = SimulatedWindow.NotificationFrame:Clone();
        u621.Parent = SimulatedWindow;
        u621.NotificationTitle.Text = v619 or "";
        u621.NotificationMessage.Text = v620 or "";

        if not v619 then
            u621.NotificationTitle.Visible = false;
        end;

        if not v620 then
            u621.NotificationMessage.Visible = false;
        end;

        u621.Position = UDim2.new(1.3, -10, 1, -60);
        u621.Visible = true;
        u621:TweenPosition(UDim2.new(1, -10, 1, -60), "Out", "Sine", 0.35);
        task.delay((p618 or 5) + 0.35, function() -- Line: 3676
            -- upvalues: u621 (copy)
            u621:TweenPosition(UDim2.new(1.3, -10, 1, -60), "Out", "Sine", 0.35, true, function() -- Line: 3677
                -- upvalues: u621 (ref)
                u621:Destroy();
            end);
        end);
    end;
end;

function showPopup(p622, p623)
    -- upvalues: u2 (copy)
    u2.DiscordRPC.ShowPopup(p622, p623);
end;

function showWindow(p624)
    -- upvalues: u588 (ref), u2 (copy)
    u588 = p624;
    u2.DiscordRPC.ShowWindow(p624);
    updateBGGradients();
end;

function setWindowTransparency(p625, p626, p627)
    -- upvalues: Data (ref), u2 (copy)
    if Data.BloxstrapData.AllowWindowTransparency then
        u2.DiscordRPC.SetTransparency({
            color = p625,
            transparency = p626,
            useAlpha = p627
        });
    end;
end;

function useLegacySimulation(p628: boolean)
    -- upvalues: u586 (ref), SimulatedWindow (copy)
    if not (u586.enabled and u586.simulated) then
        return;
    end;

    SimulatedWindow.Legacy.Visible = p628;
    SimulatedWindow.BG.Visible = not p628;
    SimulatedWindow.BG2.Visible = not p628;
end;

function makeTransparentSections(p629, p630)
    if p630 < p629 then
        local v631 = p630;
        p630 = p629;
        p629 = v631;
    end;

    local math_clamp_ret = math.clamp(p629, 0.0005, 1);
    local math_clamp_ret2 = math.clamp(p630, math_clamp_ret, 1);

    if math_clamp_ret == math_clamp_ret2 then
        return NumberSequence.new(0);
    end;

    local v632 = {
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(math_clamp_ret - 0.0005, 0),
        NumberSequenceKeypoint.new(math_clamp_ret, 1),
        NumberSequenceKeypoint.new(math_clamp_ret2 - 0.0005, 1),
        NumberSequenceKeypoint.new(math_clamp_ret2, 0),
        NumberSequenceKeypoint.new(1, 0)
    };

    if math_clamp_ret <= 0.0005 then
        table.remove(v632, 1);
    end;

    if math_clamp_ret2 == 1 then
        table.remove(v632, #v632);
    end;

    return NumberSequence.new(v632);
end;

function updateBGGradients()
    -- upvalues: u588 (ref), SimulatedWindow (copy), u586 (ref), Vector2_new_ret (ref), workspace_CurrentCamera (copy), u136 (copy)
    if u588 then
        SimulatedWindow.TopBarContainer.Size = UDim2.new((u586.x + u586.w) / u586.scaleX - u586.x / u586.scaleX, 0, 0, 29);
        SimulatedWindow.TopBarContainer.Position = UDim2.fromScale((u586.x + u586.w) / u586.scaleX, u586.y / u586.scaleY);
        SimulatedWindow.BG.Horizontal.Transparency = makeTransparentSections(u586.x / u586.scaleX, (u586.x + u586.w) / u586.scaleX);
        SimulatedWindow.BG2.Vertical.Transparency = makeTransparentSections(u586.y / u586.scaleY, (u586.y + u586.h) / u586.scaleY);
    else
        SimulatedWindow.TopBarContainer.Size = UDim2.fromScale(0, 0);
        SimulatedWindow.BG.Horizontal.Transparency = NumberSequence.new(0);
        SimulatedWindow.BG2.Vertical.Transparency = NumberSequence.new(0);
    end;

    SimulatedWindow.Legacy.BG.Horizontal.Transparency = SimulatedWindow.BG.Horizontal.Transparency;
    SimulatedWindow.Legacy.BG2.Vertical.Transparency = SimulatedWindow.BG2.Vertical.Transparency;
    local Vector2_new_ret2 = Vector2.new(u586.w / u586.scaleX, u586.h / u586.scaleY);

    if Vector2_new_ret == Vector2_new_ret2 then
        return;
    end;

    Vector2_new_ret = Vector2_new_ret2;
    local v633 = workspace_CurrentCamera.ViewportSize * Vector2_new_ret2;

    for _, v in u136 do
        v(v633);
    end;
end;

function setWallpaper(p634: string?, p635)
    -- upvalues: u586 (ref), SimulatedWindow (copy)
    if not (u586.enabled and u586.simulated) then
        return;
    end;

    if p635 == nil then
        SimulatedWindow.BG.Background.Image = p634 or "rbxassetid://6279580198";
        SimulatedWindow.BG2.Background.Image = p634 or "rbxassetid://6279580198";
        SimulatedWindow.BG.Background.ImageTransparency = 0;
        SimulatedWindow.BG.Background.BackgroundTransparency = 1;
        SimulatedWindow.BG2.Background.ImageTransparency = 0;
        SimulatedWindow.BG2.Background.BackgroundTransparency = 1;
        SimulatedWindow.Legacy.BG.Image = p634 or "rbxassetid://3800050934";
        SimulatedWindow.Legacy.BG2.Image = p634 or "rbxassetid://3800050934";
        SimulatedWindow.Legacy.BG.ImageTransparency = 0;
        SimulatedWindow.Legacy.BG2.ImageTransparency = 0;

        return;
    end;

    SimulatedWindow.BG.Background.ImageTransparency = 1;
    SimulatedWindow.BG.Background.BackgroundTransparency = 0;
    SimulatedWindow.BG2.Background.ImageTransparency = 1;
    SimulatedWindow.BG2.Background.BackgroundTransparency = 0;
    SimulatedWindow.Legacy.BG.ImageTransparency = 1;
    SimulatedWindow.Legacy.BG2.ImageTransparency = 1;
    SimulatedWindow.BG.Background.BackgroundColor3 = p635;
    SimulatedWindow.BG2.Background.BackgroundColor3 = p635;
    SimulatedWindow.Legacy.BG.BackgroundColor3 = p635;
    SimulatedWindow.Legacy.BG2.BackgroundColor3 = p635;
end;

function setWindowColor(p636, p637, p638)
    -- upvalues: u2 (copy)
    if p638 then
        return u2.DiscordRPC.SetWindowColor({
            reset = true
        });
    end;

    local v639 = {};

    if p636 then
        v639.caption = p636;
    end;

    if p637 then
        v639.border = p637;
    end;

    u2.DiscordRPC.SetWindowColor(v639);
end;

function setDesktopTaskbarVisible(p640: boolean)
    -- upvalues: u586 (ref), SimulatedWindow (copy)
    if not (u586.enabled and u586.simulated) then
        return;
    end;

    local v641 = p640 == nil and true or p640;
    SimulatedWindow.BG.Taskbar.Visible = v641 or false;
    SimulatedWindow.BG2.Taskbar.Visible = v641 or false;
end;

function setDesktopIconsVisible(p642: boolean)
    -- upvalues: u586 (ref), SimulatedWindow (copy)
    if not (u586.enabled and u586.simulated) then
        return;
    end;

    local v643 = p642 == nil and true or p642;

    for _, child in SimulatedWindow.BG.Background:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = v643 or false;
        end;
    end;

    for _, child in SimulatedWindow.BG2.Background:GetChildren() do
        if child:IsA("Frame") then
            child.Visible = v643 or false;
        end;
    end;
end;

u86.setTitle = setTitle;
u86.setWindow = setWindow;
u86.showPopup = showPopup;
u86.showWindow = showWindow;
u86.setWallpaper = setWallpaper;
u86.createWindow = createWindow;
u86.restoreWindow = restoreWindow;
u86.resetWindow = restoreWindow;
u86.initWindow = initWindowMovement;
u86.setWindowColor = setWindowColor;
u86.sendNotification = sendNotification;
u86.initWindowMovement = initWindowMovement;
u86.setWindowBorderless = setWindowBorderless;
u86.setWindowTransparency = setWindowTransparency;
u86.useLegacySimulation = useLegacySimulation;
u86.setDesktopTaskbarVisible = setDesktopTaskbarVisible;
u86.setDesktopIconsVisible = setDesktopIconsVisible;

function u86.getWindowData() -- Line: 3853
    -- upvalues: u586 (ref)
    return u586;
end;

function u86.__getWindowData() -- Line: 3856
    -- upvalues: u586 (ref)
    return u586;
end;

function u86.__setWindowData(p644) -- Line: 3859
    -- upvalues: u586 (ref)
    warn("WHATEVER THIS METHOD IS IT AND WHEREVER IT POPS UP IT SHOULD BE REMOVED THIS IS LITERALLY BAD DO NOT SET WINDOWDATA OK TYYYY -MINZ");
    u586 = p644;
end;

u86.updateBGGradients = updateBGGradients;
u86.isSimulatedWindow = false;
local AfterImage = Assets.Templates.AfterImage;
local u645 = { { -0.05, 0 }, { 0, 0.05 }, { 0, -0.05 }, { 0.05, 0 }, { 0, -0.05 }, { -0.05, 0 }, { 0, 0.05 }, { 0, -0.05 }, { 0.05, 0 } };

function createAfterImage(p646: any, p647: any, p648, p649: number?, p650: boolean?)
    -- upvalues: Data (ref), AfterImage (copy), Underlay (copy), workspace_CurrentCamera (copy), u645 (copy), u1 (copy)
    if not Data.AfterImages then
        return;
    end;

    if p646 == nil or p646.charModel == nil then
        return;
    end;

    local column = p647.column;

    if p647.sustainNote then
        return;
    end;

    local v651 = p649 == nil and 1 or p649;
    local v652 = AfterImage:Clone();
    v652.Parent = Underlay;
    v652.CurrentCamera = workspace_CurrentCamera;

    if p648 ~= nil then
        v652.ImageColor3 = p648;
    end;

    local v653 = p646.charModel:Clone();

    if v653 == nil then
        return;
    end;

    v653.Parent = v652;
    local v654 = p650 ~= nil and p650 == true and UDim2.new() or UDim2.new(u645[column + 1][1] * v651, 0, u645[column + 1][2] * v651, 0);
    u1.TweenService:Create(v652, TweenInfo.new(0.5), {
        ImageTransparency = 1,
        Position = v654
    }):Play();
    u1.Debris:AddItem(v652, 0.5);
end;

local AfterImage2 = Assets.Templates.AfterImage;
local u655 = { { -0.05, 0 }, { 0, 0.05 }, { 0, -0.05 }, { 0.05, 0 }, { 0, -0.05 }, { -0.05, 0 }, { 0, 0.05 }, { 0, -0.05 }, { 0.05, 0 } };
local TweenInfo_new_ret = TweenInfo.new(0.5);

function newAfterImage(p656: any, p657: any, p658, p659: number?, p660: boolean?)
    -- upvalues: Data (ref), AfterImage2 (copy), Underlay (copy), workspace_CurrentCamera (copy), u655 (copy), u1 (copy), TweenInfo_new_ret (copy)
    if not (Data.AfterImages and (p656 and (p656.charModel and p656.afterImageRigs))) then
        return;
    end;

    if p657.sustainNote then
        return;
    end;

    local column = p657.column;
    local v661 = p659 or 1;
    local v662 = AfterImage2:Clone();
    v662.Parent = Underlay;
    v662.CurrentCamera = workspace_CurrentCamera;

    if p658 then
        v662.ImageColor3 = p658;
    end;

    local v663 = p656.afterImageRigs[column];

    if not v663 then
        v663 = p656.charModel:Clone();
        p656.afterImageRigs[column] = v663;
    end;

    v663.Parent = v662;
    local v664;

    if p660 then
        v664 = UDim2.new();
    else
        local v665 = u655[column + 1];
        v664 = UDim2.new(v665[1] * v661, 0, v665[2] * v661, 0);
    end;

    u1.TweenService:Create(v662, TweenInfo_new_ret, {
        ImageTransparency = 1,
        Position = v664
    }):Play();
    u1.Debris:AddItem(v662, 0.5);
end;

u86.createAfterImage = newAfterImage;
u86.newAfterImage = newAfterImage;
u86.getProperty = getProperty;
u86.setProperty = setProperty;
u86.tweenProperty = tweenProperty;
u86.cancelTweensOf = cancelTweensOf;

function u86.getScreenSize() -- Line: 3977
    -- upvalues: workspace_CurrentCamera (copy)
    return workspace_CurrentCamera.ViewportSize;
end;

u86.EventManager = u2.Events;
u86.setBarTarget = u2.Events.setBarTarget;
u86.setFadeTarget = u2.Events.setFadeTarget;
u86.getCurrentFade = u2.Events.getCurrentFade;
u86.setSubtitleTarget = u2.Events.setSubtitleTarget;
u86.setBarTransparency = u2.Events.setBarTransparency;

function triggerEvent(p666: any, p667: any, p668: any, p669: number?)
    -- upvalues: u2 (copy)
    u2.Events.callEvent(p666, p667, p668, p669);
end;

u86.triggerEvent = triggerEvent;
local u670 = {
    noteTypes = {},
    noteSets = {},
    noteSplashes = {},
    holdSplashes = {}
};

function cacheNoteType(p671)
    -- upvalues: ReplicatedStorage (copy), u670 (ref), ManiaData (copy), u124 (ref), Data (ref), u545 (copy), u2 (copy)
    local v672 = type(p671) == "string" and ReplicatedStorage.Assets.NoteTypes:FindFirstChild(p671);

    if v672 then
        p671 = v672;
    elseif typeof(p671) ~= "Instance" or not p671 then
        if type(p671) ~= "table" then
            p671 = false;
        end;
    end;

    if p671 then
        local Name = p671.Name;
        local v673 = u670.noteTypes[Name];

        if v673 then
            return v673;
        end;

        local v674 = {};

        for _, v in ManiaData.dirs[tonumber(u124.highestKey)] do
            local v675;

            if Data.FlipNoteskin and table.find(u545, u124.highestKey) then
                v675 = v == "Down" and "Up" or (v == "Up" and "Down" or v);
            else
                v675 = v;
            end;

            local v676 = p671:FindFirstChild(v675);

            if v676 then
                local v677 = {};
                local Attribute = v676:GetAttribute("Antialiasing");
                local v678 = tonumber(v676:GetAttribute("Framerate")) or 24;
                local v679 = tonumber(v676:GetAttribute("SizeMult")) or 1;
                local v680 = tonumber(v676:GetAttribute("Factor")) or 1;
                v675:lower();
                v677.note = u2.sprite:GetAnimFramesByResults(v676, { "note0", "note alone0" }, v680, v679);
                v677.hold = u2.sprite:GetAnimFramesByResults(v676, { "note hold piece0", "note hold0" }, v680, v679);
                v677.holdend = u2.sprite:GetAnimFramesByResults(v676, { "note hold end0", "note holdend0", "note tail0" }, v680, v679);
                v677._id = v676:GetAttribute("Image") or p671:GetAttribute("Image");
                v677._antialiasing = Attribute == nil and true or Attribute;
                v677._framerate = v678;
                v677._folder = v675;
                v677._name = Name;
                v674[v675] = v677;
            else
                v674[v675] = u2.Note.getNoteSkinTypeFrames(p671, v675);
            end;

            u2.Cache.cacheImage(v674[v675]._id);
        end;

        u670.noteTypes[p671.Name] = v674;
        u2.Logger.log("Cached note type: ", p671);

        return v674;
    end;

    warn("Nonexistent texture");
end;

u86.cacheNoteType = cacheNoteType;

function cacheNoteSet(p681: string, p682: userdata, p683: string?)
    -- upvalues: u2 (copy), u670 (ref)
    if not p682 then
        return u2.Logger.warn("No notetype with the name of", p681);
    end;

    local v684 = p683 or p682.Name;
    local v685;

    if u670.noteSets[p681] then
        v685 = u670.noteSets[p681][v684] or nil;
    else
        v685 = nil;
    end;

    if v685 then
        return v685;
    end;

    local Attribute = p682:GetAttribute("Antialiasing");
    local v686 = tonumber(p682:GetAttribute("Framerate")) or 24;
    local v687 = tonumber(p682:GetAttribute("SizeMult")) or 1;
    local v688 = tonumber(p682:GetAttribute("Factor")) or 1;
    local v689 = {
        static = u2.sprite:GetAnimFramesByResults(p682, { "receptor0", "receptor static0" }, v688, v687),
        confirm = u2.sprite:GetAnimFramesByResults(p682, { "receptor confirm0" }, v688, v687),
        press = u2.sprite:GetAnimFramesByResults(p682, { "receptor press0", "receptor pressed0" }, v688, v687),
        note = u2.sprite:GetAnimFramesByResults(p682, { "note0", "note alone0" }, v688, v687),
        hold = u2.sprite:GetAnimFramesByResults(p682, { "note hold piece0", "note hold0" }, v688, v687),
        holdend = u2.sprite:GetAnimFramesByResults(p682, { "note hold end0", "note holdend0", "note tail0" }, v688, v687),
        _id = p682:GetAttribute("Image"),
        _antialiasing = Attribute == nil and true or Attribute,
        _framerate = v686,
        _folder = p681,
        _name = v684
    };
    u2.Cache.cacheImage(v689._id);
    u670.noteSets[p681] = u670.noteSets[p681] or {};
    u670.noteSets[p681][v684] = v689;
    u2.Logger.log("Cached note set: " .. p681 .. "/" .. v684);

    return v689;
end;

function cacheColoredNoteSet(p690: any, p691: table)
    -- upvalues: u2 (copy), u670 (ref)
    p691.Anims = p691.Anims or { "confirm", "press", "note", "hold", "holdend" };
    p691.Color = typeof(p691.Color) == "Color3" and p691.Color or (type(p691.Color) == "table" and Color3.new(table.unpack(p691.Color)) or Color3.new(1, 1, 1));
    p691.Type = p691.Type or "Hue";
    local table_clone_ret = table.clone(p690);
    local v692 = u2.RGBSprite:cacheSetWithColor(table_clone_ret._id, table_clone_ret, p691.Anims, p691.Color, p691.Type);
    table_clone_ret._rgbId = v692;

    if not v692 then
        return table_clone_ret;
    end;

    local v693 = u670.noteSets[table_clone_ret._folder];

    if not v693 then
        v693 = {};
        u670.noteSets[table_clone_ret._folder] = v693;
    end;

    if v693[table_clone_ret._id .. table_clone_ret._rgbId] then
        return v693[table_clone_ret._id .. table_clone_ret._rgbId];
    end;

    v693[table_clone_ret._id .. table_clone_ret._rgbId] = table_clone_ret;

    return table_clone_ret;
end;

function getSetBelow(p694, p695)
    -- upvalues: Data (ref), u545 (copy), u124 (ref)
    if p695 and (p694 and type(p695) == "string") then
        local v696 = p694:FindFirstChild(p695);

        if Data.FlipNoteskin and table.find(u545, u124.highestKey) then
            p695 = p695 == "Down" and "Up" or (p695 == "Up" and "Down" or p695);
            v696 = p694:FindFirstChild(p695) or v696;
        end;

        if v696 then
            return v696;
        end;

        if p695 == "Plus" then
            p695 = "rDown2";
            v696 = p694:FindFirstChild(p695);
        end;

        if p695 == "Square" and not v696 then
            p695 = "rUp2";
            v696 = p694:FindFirstChild(p695);
        end;

        local v697 = v696 or p694:FindFirstChild((string.gsub(p695, "%A", "")));

        if string.sub(p695, 1, 1) == "r" then
            local string_sub_ret = string.sub(p695, 2);
            v697 = v697 or p694:FindFirstChild(string_sub_ret) or p694:FindFirstChild((string.gsub(string_sub_ret, "%A", "")));
        end;

        return v697;
    end;
end;

function cacheOverrides(p698: table, p699: any)
    -- upvalues: Noteskins (copy)
    local v700 = {};

    for i, v in p698 do
        if type(v) == "table" then
            local v701 = p699[i];
            local v702;

            if v701 then
                v702 = v701.textureDir;
            else
                v702 = i;
            end;

            local v703;

            if v[2] then
                v703 = Noteskins:FindFirstChild(v[2]);

                if v703 then
                    v703 = v703:FindFirstChild(v[1] or "");
                end;
            else
                v703 = Noteskins:FindFirstChild(v[1] or "");
            end;

            if v703 then
                v700[i] = cacheNoteSet((v703.Parent == Noteskins or v703.Parent == nil) and v703.Name or v703.Parent.Name .. "/" .. v703.Name, getSetBelow(v703, v702), v702);
            end;
        end;
    end;

    return v700;
end;

function cacheNoteskin(p704, p705)
    -- upvalues: Noteskins (copy), u109 (copy), u670 (ref), Data (ref), ManiaData (copy)
    if type(p704) == "table" then
        local v706 = p704[2];
        local v707 = p704[1];

        if v706 == "" or (v706 == nil or not v706) then
            v706 = nil;
        end;

        local v708 = Noteskins:FindFirstChild(v706 or (v707 or ""));

        if v706 and v708 then
            p704 = v708:FindFirstChild(v707 or "");
        else
            p704 = v708 or Noteskins:FindFirstChild(v707 or "");
        end;
    elseif type(p704) == "string" then
        p704 = Noteskins:FindFirstChild(p704);
    end;

    if p704 and not p704:GetAttribute("Pack") then
        local v709 = (p704.Parent == Noteskins or p704.Parent == nil) and p704.Name or p704.Parent.Name .. "/" .. p704.Name;
        local v710 = {
            Path = (p704.Parent == Noteskins or p704.Parent == nil) and "" or p704.Parent.Name,
            Name = p704.Name,
            Instance = p704,
            Cache = v709
        };

        if not p705 then
            for _, v in u109 do
                cacheNoteskin(p704, v);
            end;

            return u670.noteSets[v709], v710;
        end;

        if type(p705) == "string" then
            for i, v in u109 do
                if (i % 2 == 0 and "L" or "R") == p705 then
                    cacheNoteskin(p704, v);
                end;
            end;

            return u670.noteSets[v709], v710;
        end;

        for _, v in p705.Strums do
            local dir = v.dir;
            cacheNoteSet(v709, getSetBelow(p704, dir), dir);
        end;

        if Data.QuantNotes then
            for _, v in ManiaData.dirs[9] do
                cacheNoteSet(v709, getSetBelow(p704, v), v);
            end;
        end;

        return u670.noteSets[v709], v710;
    end;
end;

function loadNoteskin(p711: any, p712: any, p713: table, p714: string?, p715: table?, p716: table?)
    -- upvalues: u109 (copy), u2 (copy), Noteskins (copy)
    if p711 == nil then
        for _, v in u109 do
            loadNoteskin(v, p712, nil, p714, p715, p716);
        end;

        return;
    end;

    if type(p711) == "string" then
        for i, v in u109 do
            if (i % 2 == 0 and "L" or "R") == p711 then
                loadNoteskin(v, p712, nil, p714, p715, p716);
            end;
        end;

        return;
    end;

    local v717 = p712 or p711.NoteskinPath;
    local v718 = p716 or {};
    local v719 = p715 or {};
    local v720 = cacheOverrides(v719, p711.Strums);
    local v721, v722 = cacheNoteskin(typeof(v717) == "Instance" and v717 and v717 or { v717, p714 }, p711);

    if not v721 then
        u2.Logger.warn("Noteskin", v717, "/", p714, "not found, using default");
        v721, v722 = cacheNoteskin(Noteskins["Friday Night Funkin\'"], p711);
    end;

    local table_clone_ret = table.clone(v721);

    for i, v in v720 do
        table_clone_ret[i] = v;
    end;

    for _, v in p711.Strums do
        local dir = v.dir;
        local v723 = table_clone_ret[dir];
        local _id = v723._id;
        local v724 = v718[dir] or {};

        if v723._cachedStrumAnims then
            v.Animations = v723._cachedStrumAnims;
        else
            v.Animations = {};
            v:AddAnimation("static", v723.static, 24, true, _id);
            v:AddAnimation("confirm", v723.confirm, 24, false, _id);
            v:AddAnimation("pressed", v723.press, 24, false, _id);
            v723._cachedStrumAnims = v.Animations;
        end;

        local v725 = v724.Global and v724.Global.NoteskinColor;

        if useRGBNotes and (v725 and next(v725)) then
            v723 = cacheColoredNoteSet(v723, {
                Anims = v725.Animations,
                Color = v725.Color,
                Type = v725.Type
            });
            table_clone_ret[dir] = v723;
        end;

        v:load(v723._rgbId);
        v.antialiasing = v723._antialiasing;
        v:Play("static", true);
    end;

    p711.Noteskin = table_clone_ret;
    p711.NoteskinCachePath = v722.Cache;
    p711.NoteskinPath = v722.Instance;
    p711.NoteskinPack = v722.Pack;
    p711.NoteskinName = v722.Name;
    p711.DefaultOverrides = p711.DefaultOverrides or v719;
    p711.Overrides = v719;

    for _, v in p711.Notes do
        v:reloadSkin();
    end;
end;

u86.cacheNoteSet = cacheNoteSet;
u86.getSetBelow = getSetBelow;
u86.loadNoteskin = loadNoteskin;
u86.cacheNoteskin = cacheNoteskin;

function u86.getPixelVariant(p726) -- Line: 4333
    -- upvalues: Noteskins (copy)
    if type(p726) == "table" then
        if #p726 > 0 then
            local v727 = p726[2];
            local v728 = p726[1];

            if v727 == "" or (v727 == nil or not v727) then
                v727 = nil;
            end;

            local v729 = Noteskins:FindFirstChild(v727 or (v728 or ""));

            if v727 and v729 then
                p726 = v729:FindFirstChild(v728 or "");
            else
                p726 = v729 or Noteskins:FindFirstChild(v728 or "");
            end;
        elseif p726.Strums then
            p726 = p726.NoteskinPath;
        end;
    elseif type(p726) == "string" then
        p726 = Noteskins:FindFirstChild(p726);
    end;

    if p726 and p726.Parent ~= nil then
        local Name = p726.Name;

        return p726.Parent:FindFirstChild(Name .. " (Pixel)") or p726.Parent:FindFirstChild(Name .. " Pixel");
    end;
end;

local u730 = {};

function u86.getCurrentNotesplashData() -- Line: 4364
    -- upvalues: u730 (copy)
    return u730;
end;

local u731 = {};

function u86.getCurrentHoldsplashData() -- Line: 4367
    -- upvalues: u731 (copy)
    return u731;
end;

function loadNotesplashes(p732, p733, p734)
    -- upvalues: u109 (copy)
    if type(p732) == "string" then
        for i, v in u109 do
            if (i % 2 == 0 and "L" or "R") == p732 then
                loadNotesplashes(v, p733, p734);
            end;
        end;

        return;
    end;

    for _, v in p732.Strums do
        cacheNotesplash(v, p733, p734, true);
    end;
end;

function loadHoldsplashes(p735, p736, p737)
    -- upvalues: u109 (copy)
    if type(p735) == "string" then
        for i, v in u109 do
            if (i % 2 == 0 and "L" or "R") == p735 then
                loadHoldsplashes(v, p736, p737);
            end;
        end;

        return;
    end;

    for _, v in p735.Strums do
        cacheHoldsplash(v, p736, p737, true);
    end;
end;

function cacheHoldsplash(p738: any, p739: any, p740: any, p741: boolean?, p742: string?)
    -- upvalues: u731 (copy), u2 (copy)
    if p742 == nil or (p742 == "" or not p742) then
        p742 = p738.dir;
    end;

    if u731[p738.side] and (u731[p738.side][p742] and not p741) then
        return u731[p738.side][p742];
    end;

    local v743;

    if p740 == nil then
        v743 = u2.AssetReplicator.getAsset("Holdsplashes", p739);
    else
        v743 = u2.AssetReplicator.getAsset("Holdsplashes", p740):FindFirstChild(p739);
    end;

    if v743 == nil then
        v743 = u2.AssetReplicator.getAsset("Holdsplashes", "Friday Night Funkin\'");
    end;

    local v744 = getSetBelow(v743, p742);

    if v744 == nil then
        return nil;
    end;

    local v745 = v743:GetAttribute("Offset") or Vector2.new();
    local v746 = v744:GetAttribute("Offset") or Vector2.new();
    local v747 = v744:GetAttribute("SizeMult") or (v743:GetAttribute("SizeMult") or 1);
    local Attribute = v744:GetAttribute("Antialiasing");
    local Attribute2 = v744:GetAttribute("Underlay");

    if Attribute2 == nil then
        Attribute2 = v743:GetAttribute("Underlay");
    end;

    if Attribute2 == nil then
        Attribute2 = false;
    end;

    local v748 = getSetting(p738.side, "Downscroll") and -1 or 1;
    local v749 = {
        XML = v744,
        Image = v744:GetAttribute("Image"),
        Offset = (v745 + v746) * Vector2.new(1, v748),
        Factor = v744:GetAttribute("Factor") or 1,
        Scale = v747,
        IsUnderlay = Attribute2,
        Antialiasing = Attribute == nil and true or Attribute,
        Framerate = v744:GetAttribute("Framerate") or 24,
        hasAltSplashes = v744:GetAttribute("hasAltSplashes") or (v743:GetAttribute("hasAltSplashes") or false),
        whatthefuck = v744:GetAttribute("whatthefuck") or (v743:GetAttribute("whatthefuck") or false)
    };
    u2.Cache.cacheImage(v749.Image);

    if u731[p738.side] == nil then
        u731[p738.side] = {};
    end;

    u731[p738.side][p742] = v749;
    u2.Logger.log((`Cached holdsplash '{v743:GetFullName()}' for direction {p742}`));

    return v749;
end;

function cacheNotesplash(p750: any, p751: any, p752: any, p753: boolean?, p754: string?)
    -- upvalues: u730 (copy), Notesplashes (copy), u2 (copy)
    if p754 == nil or (p754 == "" or not p754) then
        p754 = p750.dir;
    end;

    if u730[p750.side] and (u730[p750.side][p754] and not p753) then
        return u730[p750.side][p754];
    end;

    local v755 = Notesplashes;

    if p752 ~= nil then
        v755 = Notesplashes:FindFirstChild(p752) or Notesplashes;
    end;

    local v756 = v755:FindFirstChild(p751) or u2.AssetReplicator.getAsset("Notesplashes", "Friday Night Funkin\'");

    if v756 == nil then
        return nil;
    end;

    local v757 = getSetBelow(v756, p754);

    if v757 == nil then
        return nil;
    end;

    local v758 = v756:GetAttribute("Offset") or Vector2.new();
    local v759 = v757:GetAttribute("Offset") or Vector2.new();
    local v760 = v757:GetAttribute("SizeMult") or 1;
    local Attribute = v757:GetAttribute("Antialiasing");
    local Attribute2 = v757:GetAttribute("Underlay");

    if Attribute2 == nil then
        Attribute2 = false;
    end;

    local v761 = {
        XML = v757,
        Image = v757:GetAttribute("Image"),
        Offset = v758 + v759,
        Factor = v757:GetAttribute("Factor") or 1,
        Scale = v760,
        IsUnderlay = Attribute2,
        Antialiasing = Attribute == nil and true or Attribute,
        hasAltSplashes = v757:GetAttribute("hasAltSplashes") or false,
        Framerate = v757:GetAttribute("Framerate") or 24
    };
    u2.Cache.cacheImage(v761.Image);

    if u730[p750.side] == nil then
        u730[p750.side] = {};
    end;

    u730[p750.side][p754] = v761;
    u2.Logger.log((`Cached notesplash '{v756:GetFullName()}' for direction {p754}`));

    return v761;
end;

local u762 = {
    L = {},
    R = {}
};
local u763 = {
    L = {},
    R = {}
};
local u764 = {};

local function removeSplashFromList(p765) -- Line: 4514
    -- upvalues: u118 (copy)
    local table_find_ret = table.find(u118, p765);

    if table_find_ret then
        table.remove(u118, table_find_ret);
    end;
end;

function createHoldsplash(u766, p767)
    -- upvalues: Data (ref), u133 (ref), u36 (ref), u762 (copy), u763 (copy), u118 (copy), u77 (ref), u156 (ref), u124 (ref), u2 (copy)
    if not Data.Holdsplashes then
        return;
    end;

    if u133 == "KadeEngine" and u766.side ~= u36 then
        return;
    end;

    if u762[u766.side][u766.dir] ~= nil then
        local v768 = u762[u766.side][u766.dir];

        if u763[u766.side][u766.dir] ~= nil then
            for _, v in u763[u766.side][u766.dir] do
                pcall(function() -- Line: 4528
                    -- upvalues: v (copy)
                    v:Disconnect();
                end);
            end;

            u763[u766.side][u766.dir] = nil;
        end;

        local table_find_ret = table.find(u118, v768);

        if table_find_ret then
            table.remove(u118, table_find_ret);
        end;

        v768:Destroy();
        u762[u766.side][u766.dir] = nil;
    end;

    local v769 = getSetting(u766.side, "Holdsplash");
    local v770 = getSetting(u766.side, "HoldsplashPack");

    if u77 and u766.side ~= u36 then
        v769 = getSetting(u766.side, "OpponentHoldsplash");
        v770 = getSetting(u766.side, "OpponentHoldsplashPack");
    end;

    local u771 = cacheHoldsplash(u766, v769, v770, nil, p767);

    if u766.strumLine ~= u156 and (Data.DisableOpponentStrums and u124.chartPlayers <= 2) then
        return;
    end;

    if u771 ~= nil then
        local v772 = { "Idle0", "IdleALT0" };
        local u773 = u2.HoldSplash.new(u766.x + u771.Offset.X, u766.y + u771.Offset.Y);

        if u771.whatthefuck then
            if u771.hasAltSplashes then
                local v774 = v772[math.random(#v772)];
                u773:AddSparrowXml(u771.XML, "idle", v774, u771.Framerate, true, u771.Factor, 1, u771.Image);
                u773:AddSparrowXml(u771.XML, "idle_end", v774, u771.Framerate, false, u771.Factor, 1, u771.Image);
            else
                u773:AddSparrowXml(u771.XML, "idle", "Idle0", u771.Framerate, true, u771.Factor, 1, u771.Image);
                u773:AddSparrowXml(u771.XML, "idle_end", "Idle0", u771.Framerate, false, u771.Factor, 1, u771.Image);
            end;

            u773.offsets.set("angle", "animaniaFuckedUp", getSetting(u766.side, "Downscroll") and 180 or 0);
        else
            u773:AddSparrowXml(u771.XML, "start", "Start0", u771.Framerate, false, u771.Factor, 1, u771.Image);
            u773:AddSparrowXml(u771.XML, "idle", "Idle0", u771.Framerate, true, u771.Factor, 1, u771.Image);
            u773:AddSparrowXml(u771.XML, "end", "End0", u771.Framerate, false, u771.Factor, 1, u771.Image);
        end;

        u773.zindex = u771.IsUnderlay and 3 or 8;
        u773.parent = u766.parent;
        u773.sFactors = u766.sFactors;
        u773.useFactorsForPosition = u766.useFactorsForPosition;
        u773.alpha = u766.alpha;
        u773.angle = u766.angle;
        local v775 = getSetting(u766.side, "HoldSplashTransparency");
        local v776 = type(v775) ~= "number" and 1 or v775;
        u773.offsets.set("alpha", "splashTransparency", v776);
        u773.antialiasing = u771.Antialiasing;
        u773.x = u766:GetProperty("x") + u771.Offset.X;
        u773.y = u766:GetProperty("y") + u771.Offset.Y;
        u773.angle = u766.incomingAngle - 90;
        local v777 = getSetting(u766.side, "NoteScale");
        local u778 = type(v777) ~= "number" and 1 or v777;
        local Property = u766:GetProperty("Scale");
        u773.Scale = u771.Scale * (Property / Vector2.new(u778, u778) * getSetting(u766.side, "HoldSplashSize"));

        if u773.Animations.start == nil then
            u773:Play("idle", true);
        else
            local v779 = u773:Play("start", true);
            v779.resetAnim = "idle";
            v779.resetTime = 0.125;
        end;

        local Obj2 = u766.Obj;
        u118[#u118 + 1] = u773;
        local v780 = {
            Obj2:GetPropertyChangedSignal("Position"):Connect(function() -- Line: 4606
                -- upvalues: u773 (copy), u766 (copy), u771 (copy)
                u773.x = (u766.__currentProperties.x or u766:GetProperty("x")) + u771.Offset.X;
                u773.y = (u766.__currentProperties.y or u766:GetProperty("y")) + u771.Offset.Y;
            end),
            Obj2:GetPropertyChangedSignal("Rotation"):Connect(function() -- Line: 4610
                -- upvalues: u773 (copy), u766 (copy)
                u773.angle = u766.incomingAngle - 90;
            end),
            Obj2:GetPropertyChangedSignal("ImageTransparency"):Connect(function() -- Line: 4611
                -- upvalues: u773 (copy), u766 (copy)
                u773.alpha = u766.__currentProperties.alpha or u766:GetProperty("alpha");
            end),
            Obj2:GetPropertyChangedSignal("Size"):Connect(function() -- Line: 4612
                -- upvalues: u766 (copy), u773 (copy), u771 (copy), u778 (ref)
                local Property2 = u766:GetProperty("Scale");
                u773.Scale = u771.Scale * (Property2 / Vector2.new(u778, u778) * getSetting(u766.side, "HoldSplashSize"));
            end)
        };
        u763[u766.side][u766.dir] = v780;
        u773.AnimationEnded:Connect(function(p781) -- Line: 4620
            -- upvalues: u763 (ref), u766 (copy), u773 (copy), u118 (ref), u762 (ref)
            if p781:match("end") then
                if u763[u766.side][u766.dir] ~= nil then
                    for _, v in u763[u766.side][u766.dir] do
                        pcall(function() -- Line: 4623
                            -- upvalues: v (copy)
                            v:Disconnect();
                        end);
                    end;

                    u763[u766.side][u766.dir] = nil;
                end;

                local table_find_ret = table.find(u118, u773);

                if table_find_ret then
                    table.remove(u118, table_find_ret);
                end;

                u773:Destroy();
                u762[u766.side][u766.dir] = nil;
            end;
        end);
        u762[u766.side][u766.dir] = u773;
    end;
end;

function releaseHoldsplash(p782, p783, p784)
    -- upvalues: Data (ref), u762 (copy), u763 (copy), u118 (copy)
    if not Data.Holdsplashes then
        return;
    end;

    local v785 = u762[p782.side][p782.dir];

    if v785 ~= nil then
        if p784 then
            if u763[p782.side][p782.dir] ~= nil then
                for _, v in u763[p782.side][p782.dir] do
                    pcall(function() -- Line: 4644
                        -- upvalues: v (copy)
                        v:Disconnect();
                    end);
                end;

                u763[p782.side][p782.dir] = nil;
            end;

            local table_find_ret = table.find(u118, v785);

            if table_find_ret then
                table.remove(u118, table_find_ret);
            end;

            v785:Destroy();
            u762[p782.side][p782.dir] = nil;

            return;
        end;

        if v785.Animations["end"] ~= nil then
            v785:Play("end", true);

            return;
        end;

        v785:Play("idle_end", true);
    end;
end;

function createNotesplash(u786, p787)
    -- upvalues: Data (ref), u133 (ref), u36 (ref), u77 (ref), u156 (ref), u124 (ref), u2 (copy), u118 (copy)
    if not Data.Notesplashes then
        return;
    end;

    if u133 == "KadeEngine" and u786.side ~= u36 then
        return;
    end;

    local v788 = getSetting(u786.side, "Notesplash");
    local v789 = getSetting(u786.side, "NotesplashPack");

    if u77 and u786.side ~= u36 then
        v788 = getSetting(u786.side, "OpponentNotesplash");
        v789 = getSetting(u786.side, "OpponentNotesplashPack");
    end;

    local u790 = cacheNotesplash(u786, v788, v789, nil, p787);

    if u786.strumLine ~= u156 and (Data.DisableOpponentStrums and u124.chartPlayers <= 2) then
        return;
    end;

    if u790 ~= nil then
        releaseHoldsplash(u786, p787, true);
        local v791 = { "splash0", "splash alt0" };
        local u792 = u2.NoteSplash.new();

        if u790.hasAltSplashes then
            u792:AddSparrowXml(u790.XML, "splash", v791[math.random(#v791)], u790.Framerate, false, u790.Factor, 1, u790.Image);
        else
            u792:AddSparrowXml(u790.XML, "splash", "splash0", u790.Framerate, false, u790.Factor, 1, u790.Image);
        end;

        u792.zindex = u790.IsUnderlay and 4 or 9;
        u792.parent = u786.parent;
        u792.sFactors = u786.sFactors;
        u792.useFactorsForPosition = u786.useFactorsForPosition;
        u792.alpha = u786.__currentProperties.alpha or u786:GetProperty("alpha");
        local v793 = getSetting(u786.side, "SplashTransparency");
        local v794 = type(v793) ~= "number" and 1 or v793;
        u792.offsets.set("alpha", "splashTransparency", v794);
        u792.antialiasing = u790.Antialiasing;
        u792.x = (u786.__currentProperties.x or u786:GetProperty("x")) + u790.Offset.X;
        u792.y = (u786.__currentProperties.y or u786:GetProperty("y")) + u790.Offset.Y;
        u792.angle = u786.__currentProperties.angle or u786:GetProperty("angle");
        local v795 = getSetting(u786.side, "NoteScale");
        local u796 = type(v795) ~= "number" and 1 or v795;
        local Property = u786:GetProperty("Scale");
        u792.Scale = u790.Scale * (Property / Vector2.new(u796, u796) * getSetting(u786.side, "NoteSplashSize"));
        u792:Play();
        local u797;

        if u786.Obj then
            local Obj2 = u786.Obj;
            u797 = {
                Obj2:GetPropertyChangedSignal("Position"):Connect(function() -- Line: 4727
                    -- upvalues: u792 (copy), u786 (copy), u790 (copy)
                    u792.x = (u786.__currentProperties.x or u786:GetProperty("x")) + u790.Offset.X;
                    u792.y = (u786.__currentProperties.y or u786:GetProperty("y")) + u790.Offset.Y;
                end),
                Obj2:GetPropertyChangedSignal("Rotation"):Connect(function() -- Line: 4731
                    -- upvalues: u792 (copy), u786 (copy)
                    u792.angle = u786.__currentProperties.angle or u786:GetProperty("angle");
                end),
                Obj2:GetPropertyChangedSignal("ImageTransparency"):Connect(function() -- Line: 4734
                    -- upvalues: u792 (copy), u786 (copy)
                    u792.alpha = u786.__currentProperties.alpha or u786:GetProperty("alpha");
                end),
                Obj2:GetPropertyChangedSignal("Size"):Connect(function() -- Line: 4737
                    -- upvalues: u786 (copy), u792 (copy), u790 (copy), u796 (ref)
                    local Property2 = u786:GetProperty("Scale");
                    u792.Scale = u790.Scale * (Property2 / Vector2.new(u796, u796) * getSetting(u786.side, "NoteSplashSize"));
                end)
            };
        else
            u797 = {};
        end;

        u118[#u118 + 1] = u792;
        u792.AnimationEnded:Connect(function() -- Line: 4747
            -- upvalues: u797 (ref), u118 (ref), u792 (copy)
            task.delay(0.02, function() -- Line: 4748
                -- upvalues: u797 (ref), u118 (ref), u792 (ref)
                for _, v in u797 do
                    pcall(function() -- Line: 4749
                        -- upvalues: v (copy)
                        v:Disconnect();
                    end);
                end;

                u797 = nil;
                local table_find_ret = table.find(u118, u792);

                if table_find_ret then
                    table.remove(u118, table_find_ret);
                end;

                u792:Destroy();
            end);
        end);
    end;
end;

function createNote(p798, p799)
    -- upvalues: u124 (ref), u36 (ref), u109 (copy), u2 (copy), u116 (copy), ManiaData (copy), u127 (ref), u24 (copy), u155 (ref), u95 (copy), Data (ref), Sounds (copy), Vector2_new (copy)
    local table_clone_ret = table.clone(p798);
    p798[1] = tonumber(p798[1]);
    p798[2] = tonumber(p798[2]);

    if type(p798[3]) == "string" and not tonumber(p798[3]) then
        p798[p798[4] == nil and 4 or #p798 + 1] = p798[3];
        p798[3] = 0;
    else
        p798[3] = tonumber(p798[3]) or 0;
    end;

    local v800 = p798[1];
    local _ = p798[2];
    local v801 = p798[2] % u124.totalKeys;
    local v802, v803;

    if u124.chartPlayers > 2 then
        local v804 = v801 // u124.leftKeyCount;

        if v804 <= 1 and p799.mustHitSection then
            v804 = math.abs(v804 - 1);
        end;

        v802 = u109[v804];
        v801 = v801 % u124.leftKeyCount;
        v803 = v804 % 2 == 0 and "L" or "R";
    else
        local mustHitSection = p799.mustHitSection;

        if (mustHitSection and u124.rightKeyCount or u124.leftKeyCount) <= v801 then
            mustHitSection = not mustHitSection;
        end;

        v803 = mustHitSection and "R" or "L";

        if p799.mustHitSection and u124.rightKeyCount <= v801 then
            v801 = (v801 - u124.rightKeyCount) % u124.leftKeyCount;
        elseif not p799.mustHitSection and u124.leftKeyCount <= v801 then
            v801 = (v801 - u124.leftKeyCount) % u124.rightKeyCount;
        end;

        v802 = u109[v803 == "R" and 1 or 0];
    end;

    local KeyCount = v802.KeyCount;
    local v805 = u2.Note.new(v800, v801, #u116 > 0 and u116[#u116] or nil, false, v802);
    local v806 = v802.Strums[v801];
    local v807 = Vector2.new(0.7, 0.7) - Vector2.new(ManiaData.size[KeyCount], ManiaData.size[KeyCount]);
    local _ = ManiaData.noteSize * v807.X;
    local v808 = v806.offsets.get("x", "anchorOffset");
    local v809 = v806.offsets.get("y", "anchorOffset");
    local v810 = v806.offsets.get("y", "strumLineOffset");
    local v811 = v806.offsets.get("x", "strumGapOffset");
    v805.offsets.set("x", "anchorOffset", v808);
    v805.offsets.set("y", "anchorOffset", v809);
    v805.offsets.set("y", "strumLineOffset", v810);
    v805.offsets.set("x", "strumGapOffset", v811);
    local NoteScale = v802.NoteScale;

    if NoteScale == 1 or not NoteScale then
        NoteScale = nil;
    end;

    v805.offsets.set("Scale", "sizeOffset", NoteScale);
    local NoteScale2 = v802.NoteScale;

    if NoteScale2 == 0 then
        NoteScale2 = nil;
    end;

    v805.offsets.set("y", "laneHeight", NoteScale2);
    v805.playAnim = p798[4] ~= "No Animation";
    local v812;

    if p798[4] == "Alt Animation" then
        v812 = true;
    else
        v812 = p799.altAnim and not p799.gfSection;
    end;

    v805.altAnim = v812;
    v805.zindex = 7;
    v805.section = p799;
    v805.mustPress = v803 == u36;
    local v813;

    if #u127 > 1 then
        v813 = getPosFromTime(v800) or v800;
    else
        v813 = v800;
    end;

    v805.initialPos = v813;
    v805.side = v803;
    v805.charSide = v803;

    if p799.gfSection and (not p798[4] or p798[4] == "") then
        p798[4] = "GF Sing";
    elseif p799.extraCharSection and (not p798[4] or p798[4] == "") then
        p798[4] = "Extra Character Sing";
    end;

    v805.rawData = p798;
    v805.noteRawData = table_clone_ret;
    local simpleSustains = u24.simpleSustains;
    v805.simpleSus = simpleSustains;
    v805.dType = p798[4] and type(p798[5]) == "string" and (type(p798[4]) == "table" and p798[4] or tonumber(p798[4]) and { p798[4] }) or (p799.dType ~= nil and { (tonumber(p799.dType)) } or { u155 });
    u95:call("onNote", v805);

    if not u24.useGimmicks then
        if v805.hitCausesMiss == true or (v805.hitHealth < 0 or v805.hitbox <= 0) then
            v805:Destroy(true);

            return nil;
        end;

        v805.texture = nil;
        v805.textureFallback = nil;
    end;

    if v805.dir ~= ManiaData.dirs[KeyCount][v805.noteData + 1] then
        v805:changeNoteData(v805.noteData);
    end;

    if not Data.SimpleGimmickNotes then
        v805.textureFallback = nil;
    end;

    local v814 = v805.textureFallback or v805.texture;

    if v814 then
        cacheNoteType(v814);
    end;

    if v805.hitSound then
        u2.Cache.cacheAsset(v805.hitSound);

        if not Sounds:FindFirstChild(v805.hitSound) then
            local Sound = Instance.new("Sound");
            Sound.Name = v805.hitSound;
            Sound.SoundId = v805.hitSound;
            Sound.Parent = Sounds;
        end;
    end;

    if v805.missSound then
        u2.Cache.cacheAsset(v805.missSound);

        if not Sounds:FindFirstChild(v805.missSound) then
            local Sound = Instance.new("Sound");
            Sound.Name = v805.missSound;
            Sound.SoundId = v805.missSound;
            Sound.Parent = Sounds;
        end;
    end;

    local v815 = {};
    local v816 = p798[3] // u2.Conductor.StepCrochet;
    local v817;

    if v816 > 0 then
        v805.susEndTime = v800 + v816 * u2.Conductor.StepCrochet;
        v805.susEndPos = #u127 > 1 and getPosFromTime(v800) or v805.susEndTime;
        local v818 = simpleSustains and 1 or v816;
        local v819 = v805.susEndTime - v805.strumTime;
        local v820 = v819 / v818;
        local table_create_ret = table.create(v816);
        local table_create_ret2 = table.create(v816, false);

        if simpleSustains then
            local v821 = v819 / v816;

            for i = 0, v816 - 1 do
                table_create_ret[i + 1] = v800 + v821 * i;
                local _ = i;
            end;
        end;

        local v822 = getSetting(v805.side, "LowerZIndexSustains") and 2 or 6;
        v817 = v805;

        for i = 0, v818 do
            local u823, v824;
            local v805, u823, v824;
            local v825 = 0;

            while true do
                if v825 == 0 then
                    v825 = -1;
                    local v826 = v800 + v820 * i;
                    local v827 = v800 + v820 * (i + 1);
                    local v828 = i == v818;
                    local v829;

                    if simpleSustains then
                        v829 = not v828;
                    else
                        v829 = simpleSustains;
                    end;

                    u823 = u2.Note.new(v826, v817.noteData, v805, true, v802);
                    u823.zindex = v822;
                    u823.anchor = Vector2.new(0.5, 0);
                    u823.offsets.set("x", "anchorOffset", v808);
                    u823.offsets.set("y", "anchorOffset", v809);
                    u823.offsets.set("y", "strumLineOffset", v810);
                    u823.offsets.set("x", "strumGapOffset", v811);
                    u823.offsets.set("y", "laneHeight", NoteScale2);
                    local HoldWidthMult = v802.HoldWidthMult;

                    if HoldWidthMult ~= 1 then
                        u823.offsets.set("Scale", "sizeOffset", Vector2.new(HoldWidthMult, 1));
                    end;

                    local v830 = getSetting(v803, "SustainTransparency");
                    u823.offsets.set("alpha", "sustainTransparency", tonumber(v830) or 1);
                    local v831;

                    if #u127 > 1 then
                        v831 = getPosFromTime(v826) or v826;
                    else
                        v831 = v826;
                    end;

                    u823.initialPos = v831;
                    u823.offsets.set("rectImageOffset", "sustainFix", function(p832) -- Line: 4949
                        -- upvalues: u823 (copy), Vector2_new (ref)
                        local v833 = u823.percentage or 0;

                        if v833 <= 0 then
                            return p832;
                        end;

                        local currentFrame = u823.currentFrame;

                        if not currentFrame then
                            return p832;
                        end;

                        local v834 = currentFrame.Size.Y * u823:GetProperty("rectSizeOffset") / p832;

                        return p832 + Vector2_new(0, (v834 - v834 * v833).Y);
                    end);
                    u823.sustainNote = v817;
                    u823.parentNote = v817;
                    local v835;

                    if Data.RepeatAnimationWhenHoldingNote then
                        v835 = v817.playAnim or false;
                    else
                        v835 = false;
                    end;

                    u823.playAnim = v835;
                    u823.altAnim = v817.altAnim;
                    u823.section = v817.section;
                    u823.side = v817.side;
                    u823.charSide = v817.charSide;
                    u823.rawData = v817.rawData;
                    u823.mustPress = v817.mustPress;
                    u823.dType = v817.dType;
                    u823.baseStrumTime = v800;
                    u823.susLength = v820;
                    u823.susStrumTime = v826;
                    u823.susEndTime = v827;

                    if #u127 > 1 then
                        v827 = getPosFromTime(v827) or v827;
                    end;

                    u823.susEndPos = v827;
                    u823.simpleSus = simpleSustains;
                    u823.isEnd = v828;
                    u823.sustains = v815;
                    u823.sustainTimes = v829 and table_create_ret and table_create_ret or nil;
                    u823.hitSustains = v829 and table_create_ret2 and table_create_ret2 or nil;
                    u823.totalSustains = u823.sustainTimes and (#u823.sustainTimes or 0) or 0;
                    u823.currentSustainIndex = 1;
                    u95:call("onNote", u823);

                    if u24.useGimmicks then
                        v825 = 1;
                        continue;
                    end;

                    if u823.hitCausesMiss ~= true and (u823.hitHealth >= 0 and u823.hitbox > 0) then
                        u823.texture = nil;
                        u823.textureFallback = nil;
                        v825 = 1;
                        continue;
                    end;

                    u823:Destroy(true);
                    v824 = i;
                    v825 = 2;
                    continue;
                elseif v825 == 1 then
                    v825 = -1;

                    if not Data.SimpleGimmickNotes then
                        u823.textureFallback = nil;
                    end;

                    local v836 = u823.textureFallback or u823.texture;

                    if v836 then
                        cacheNoteType(v836);
                    end;

                    if u823.isEnd then
                        u823.offsets.set("rectImageOffset", "textureFix", Vector2.new(0, 0.8));
                    else
                        u823.offsets.set("rectSizeOffset", "textureFix", Vector2.new(1, 0.8));
                        u823.offsets.set("Scale", "noteSkinFix", function(p837) -- Line: 5014
                            -- upvalues: u823 (copy)
                            return p837 * Vector2.new(1, 44 / u823.frameSize.y);
                        end);
                    end;

                    table.insert(v802.UnspawnNotes, u823);
                    table.insert(u823.tablesStored, v802.UnspawnNotes);
                    table.insert(u116, u823);
                    table.insert(u823.tablesStored, u116);
                    v815[i + 1] = u823;
                    v805 = u823;
                    v824 = i;
                    v825 = 2;
                    continue;
                elseif v825 == 2 then
                    v825 = -1;
                    break;
                else
                    break;
                end;
            end;
        end;
    else
        v817 = v805;
    end;

    v817.sustains = v815;
    table.insert(v802.UnspawnNotes, v817);
    table.insert(v817.tablesStored, v802.UnspawnNotes);
    table.insert(u116, v817);
    table.insert(v817.tablesStored, u116);

    return v817;
end;

function addEvent(p838)
    -- upvalues: u89 (copy), u119 (copy)
    u89:call("onEventAdded", p838);
    table.insert(u119, p838);
    table.sort(u119, function(p839, p840) -- Line: 5044
        return p839.StrumTime < p840.StrumTime;
    end);
end;

function u86.getEvents() -- Line: 5049
    -- upvalues: u119 (copy)
    return u119;
end;

u86.addEvent = addEvent;

function u86.debug.addDebugPoint(p841, p842, p843) -- Line: 5051
    addEvent({
        Name = "debug highlight",
        StrumTime = p841,
        Value1 = p842,
        Value2 = p843
    });
end;

local function addNotesFromChart(p844, p845) -- Line: 5053
    -- upvalues: u2 (copy), u116 (copy), u109 (copy), u117 (copy), u119 (copy)
    local v846 = 0;
    local v847 = {};
    local v848 = 0;

    for i, v in p844.notes do
        if v ~= nil then
            v.id = (tonumber(i) or 0) - 1;
            local v849 = v;

            for _, v2 in v.sectionNotes do
                if v846 % 250 == 0 then
                    task.wait();
                end;

                v2[1] = tonumber(v2[1]);

                if v2[1] ~= nil then
                    if v2[2] < 0 then
                        if not p845 then
                            addEvent({
                                StrumTime = v2[1],
                                Name = v2[3],
                                Value1 = v2[4],
                                Value2 = v2[5]
                            });
                        end;
                    else
                        local v850 = createNote(v2, v849);

                        if v850 and v850.strumLine then
                            local v851, v852;
                            local v851, v852, v846;
                            local v853 = 0;

                            while true do
                                if v853 == 0 then
                                    v853 = -1;
                                    v851 = v850.strumLine.ID .. "|" .. v850.strumTime .. "|" .. v850.noteData;
                                    v852 = v847[v851];

                                    if v852 then
                                        v853 = 2;
                                        continue;
                                    end;

                                    v853 = 1;
                                    continue;
                                elseif v853 == 1 then
                                    v853 = -1;
                                    v847[v851] = v850;
                                    v846 = v846 + 1;
                                    v853 = 3;
                                    continue;
                                elseif v853 == 2 then
                                    v853 = -1;
                                    u2.Logger.log("Stacked note at " .. v2[1] .. ", continuing....");
                                    v848 = v848 + 1;

                                    if v852.rawData[3] <= v2[3] then
                                        for _, v3 in v852.sustains or {} do
                                            v3:Destroy();
                                        end;

                                        v852:Destroy();
                                        v846 = v846 - 1;
                                        v853 = 1;
                                        continue;
                                    end;

                                    for _, v3 in v850.sustains or {} do
                                        v3:Destroy();
                                    end;

                                    v850:Destroy();
                                    v853 = 3;
                                    continue;
                                elseif v853 == 3 then
                                    v853 = -1;
                                    break;
                                else
                                    break;
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            if v849.events and not p845 then
                for _, v2 in v849.events do
                    local time = v2.time;

                    if v2.args then
                        addEvent({
                            StrumTime = time,
                            Name = v2.name,
                            Value1 = v2.args[1],
                            Value2 = v2.args[2]
                        });
                    else
                        for _, v3 in v2.events do
                            addEvent({
                                StrumTime = time,
                                Name = v3.name,
                                Value1 = v3.args[1],
                                Value2 = v3.args[2]
                            });
                        end;
                    end;
                end;
            end;
        end;
    end;

    table.sort(u116, function(p854, p855) -- Line: 5133
        if p854.strumTime ~= p855.strumTime then
            return p854.strumTime < p855.strumTime;
        end;

        if p854.noteData == p855.noteData then
            return p854.strumLine.ID < p855.strumLine.ID;
        end;

        return p854.noteData < p855.noteData;
    end);
    u2.Logger.log("Stacked notes in chart: " .. v848);

    for _, v in u109 do
        table.sort(v.UnspawnNotes, function(p856, p857) -- Line: 5146
            if p856.strumTime == p857.strumTime then
                return p856.noteData < p857.noteData;
            end;

            return p856.strumTime < p857.strumTime;
        end);
        local v858 = {};

        for _, v2 in v.UnspawnNotes do
            if not v2.sustainNote then
                if not v858[v2.noteData] then
                    v858[v2.noteData] = {};
                end;

                table.insert(v858[v2.noteData], v2);
            end;
        end;

        for _, v2 in v858 do
            local v859 = nil;

            for _, v3 in v2 do
                if v3 and v3.alive then
                    if v859 and v859.alive then
                        if math.abs(v3.strumTime - v859.strumTime) < 5 and v3.noteData == v859.noteData then
                            local v860;

                            if v3.rawData[3] == v859.rawData[3] then
                                if v3.rawData[4] == nil and v859.rawData[4] then
                                    u2.Logger.log((`Stacked notes within 5ms range, killing note with no noteType [{v3.strumTime}]`));
                                    v860 = v3;
                                elseif v859.rawData[4] == nil and v3.rawData[4] then
                                    u2.Logger.log((`Stacked notes within 5ms range, killing note with no noteType [{v859.strumTime}]`));
                                    v860 = v859;
                                else
                                    local StepFromTime = u2.TimeFunctions.getStepFromTime(v3.strumTime);
                                    local StepFromTime2 = u2.TimeFunctions.getStepFromTime(v859.strumTime);
                                    local v861 = StepFromTime - math.round(StepFromTime);
                                    local math_abs_ret = math.abs(v861);
                                    local v862 = StepFromTime2 - math.round(StepFromTime2);
                                    v860 = math_abs_ret < math.abs(v862) and v859 and v859 or v3;
                                    u2.Logger.log((`Stacked notes within 5ms range, killing note further from a step [{v860.strumTime}]`));
                                end;
                            else
                                v860 = v3.rawData[3] > v859.rawData[3] and v859 and v859 or v3;
                                u2.Logger.log((`Stacked notes within 5ms range, killing note with shorter sustain [{v860.strumTime}]`));
                            end;

                            local v863 = v3;

                            for _, v4 in v860.sustains or {} do
                                v4:Destroy();
                            end;

                            v860:Destroy();
                            v848 = v848 + 1;

                            if v860 == v859 then
                                v859 = v863;
                            end;
                        else
                            v859 = v3;
                        end;
                    else
                        v859 = v3;
                    end;
                end;
            end;
        end;

        local v864 = {};

        for _, v2 in v.UnspawnNotes do
            if v2 and (v2.alive and not v2.sustainNote) then
                table.insert(v864, v2);
            end;
        end;

        local v865 = #v864;
        local v866 = 1;

        while v866 <= v865 do
            local v867 = v866;

            while v866 <= v865 and v864[v866].strumTime == v864[v866].strumTime do
                v866 = v866 + 1;
            end;

            if v866 - v867 > 1 then
                for i = v867, v866 - 1 do
                    v864[i].isChord = true;
                    local _ = i;
                end;
            end;
        end;
    end;

    u2.Logger.log("This chart had " .. v848 .. " stacked / duplicate notes! - Client");
    table.sort(u117, function(p868, p869) -- Line: 5239
        return p868.strumTime < p869.strumTime;
    end);
    table.sort(u119, function(p870, p871) -- Line: 5240
        return p870.StrumTime < p871.StrumTime;
    end);
    table.clear(v847);
end;

function addSectionsFromChart(p872)
    -- upvalues: u2 (copy), u120 (ref), u33 (ref)
    local ChartSongLength = u2.TimeFunctions.getChartSongLength();
    local BPMFromTime = u2.TimeFunctions.getBPMFromTime(ChartSongLength);
    local bpm = BPMFromTime.bpm;
    local v873 = BPMFromTime.stepCrochet * 4;
    local v874 = nil;

    for _, v in p872.notes do
        local v875;

        if v.sectionBeats == nil and v.lengthInSteps then
            v875 = (tonumber(v.lengthInSteps) or 16) / 4;
            v.lengthInSteps = nil;
        else
            v875 = 4;
        end;

        local v876 = v.sectionBeats and (tonumber(v.sectionBeats) or 4) or v875;
        local v877;

        if v.changeBPM then
            v877 = tonumber(v.bpm) or bpm;
        else
            v877 = bpm;
        end;

        if v877 == bpm then
            v877 = bpm;
        else
            v873 = 60 / v877 * 1000;
        end;

        local v878 = {
            StrumTime = ChartSongLength,
            Target = v.mustHitSection and 1 or 0,
            Position = Vector2.new()
        };

        if v874 ~= v878.Target then
            table.insert(u120, v878);
        end;

        v874 = v878.Target;
        ChartSongLength = ChartSongLength + v876 * v873;
        table.insert(u33.notes, v);
        bpm = v877;
    end;
end;

u86.createNote = createNote;
u86.addNotesFromChart = addNotesFromChart;
u86.addSectionsFromChart = addSectionsFromChart;

function parseChart(p879: userdata, u880: table?, p881: any, p882: table)
    -- upvalues: u119 (copy), u116 (copy), u2 (copy), Data (ref), u115 (ref), u124 (ref), u36 (ref), u109 (copy), u4 (ref), u127 (ref), u86 (copy), u251 (ref), u120 (ref), addNotesFromChart (copy)
    local v883 = p879;
    local song = v883.song;
    table.clear(u119);
    table.clear(u116);
    u2.Conductor.init(song.bpm or 100, tonumber(song.afnOffset) or 0 + Data.AudioOffset / 1000 * u115);
    u2.Conductor.mapBPMChanges(v883);
    local v884 = tonumber(song.keys) or (tonumber(song.keyCount) or 4);
    local v885 = tonumber(song.playerKeyCount) or v884;
    local u886 = tonumber(song.players) or 2;
    u124 = {
        totalKeys = 0,
        leftKeyCount = v884,
        rightKeyCount = v885,
        opponentKeyCount = u36 == "L" and v885 and v885 or v884,
        playerKeyCount = u36 == "R" and v885 and v885 or v884,
        highestKey = math.max(v885, v884),
        lowestKey = math.min(v885, v884),
        chartPlayers = u886
    };

    if u886 == 0 then
        u124.totalKeys = 0;

        for _, v in u109 do
            local v887 = u124;
            v887.totalKeys = v887.totalKeys + v.KeyCount;
        end;
    end;

    local u888 = u886 - 2;

    for i = 0, u886 - 1 do
        local v889 = (i + 1) % 2 == 0 and "R" or "L";
        local v890 = u124[v889 == "L" and "leftKeyCount" or "rightKeyCount"];
        local v891 = u124;
        v891.totalKeys = v891.totalKeys + v890;
        local v892 = 1 + -0.1 * u888;
        local u893 = 1280 / u886 * i;
        local v894 = u888 * (-1.95 / (u886 - 1)) * u2.MathFuncs.getRawStartPoint(v890) * v892 + u2.MathFuncs.getRawStartPoint(v890);
        local v895 = u2.Strumline.new(v889, v890, u893 + v894, v892, u36 == v889 and Data or u4);

        function v895.getStartingPoint(p896, p897) -- Line: 5334
            -- upvalues: u893 (copy), u888 (copy), u886 (copy), u2 (ref)
            local v898 = p897 or p896.KeyCount;

            return u893 + u888 * (-1.95 / (u886 - 1)) * u2.MathFuncs.getRawStartPoint(v898) * p896.Scale + u2.MathFuncs.getRawStartPoint(v898);
        end;

        v895:generateStrums();
        local v899 = u109[0] == nil and 0 or #u109 + 1;
        u109[v899] = v895;
        v895.Index = v899;
        v895.ID = v899;
        local _ = i;
    end;

    u127 = Data.SVChanges and (v883.sliderVelocities or { {
            startTime = 0,
            multiplier = 1
        } }) or { {
            startTime = 0,
            multiplier = 1
        } };
    u86.svFunctions.sliderVelocities = u127;
    mapVelocityChanges(u251);

    if u880 then
        u880 = u2.ChartFixing.fixEvents(u880);
    end;

    if song and song.camEvents then
        u120 = song.camEvents;
    end;

    if #u120 == 0 and (u880 and u880.camEvents) then
        u120 = u880.camEvents;
    end;

    u2.Logger.log("Found " .. #u120 .. " camera switches!");
    local u900 = u880 and next(u880);

    local function readEventsFromRoot(p901: string, p902: boolean?) -- Line: 5379
        -- upvalues: u900 (copy), u880 (ref), song (ref)
        local v903 = u900 and (u880.song or u880) or ((p902 == nil and true or p902) and song or nil);

        if v903 == nil then
            return nil;
        end;

        return v903[p901];
    end;

    local v904 = nil;
    local v905 = v904 == nil and true or v904;
    local v906 = u900 and (u880.song or u880);

    if not v906 then
        if v905 then
            v906 = song or nil;
        else
            v906 = nil;
        end;
    end;

    local v907;

    if v906 == nil then
        v907 = nil;
    else
        v907 = v906.events;
    end;

    local v908 = false;
    local v909 = v908 == nil and true or v908;
    local v910 = u900 and (u880.song or u880);

    if not v910 then
        if v909 then
            v910 = song or nil;
        else
            v910 = nil;
        end;
    end;

    local v911;

    if v910 == nil then
        v911 = nil;
    else
        v911 = v910.notes;
    end;

    local v912 = nil;
    local v913 = v912 == nil and true or v912;
    local v914 = u900 and (u880.song or u880);

    if not v914 then
        if v913 then
            v914 = song or nil;
        else
            v914 = nil;
        end;
    end;

    local v915;

    if v914 == nil then
        v915 = nil;
    else
        v915 = v914.mythEvents;
    end;

    local v916 = nil;
    local v917 = v916 == nil and true or v916;
    local v918 = u900 and (u880.song or u880);

    if not v918 then
        if v917 then
            v918 = song or nil;
        else
            v918 = nil;
        end;
    end;

    local v919;

    if v918 == nil then
        v919 = nil;
    else
        v919 = v918.yoshiEvents;
    end;

    local v920 = nil;
    local v921 = v920 == nil and true or v920;
    local v922 = u900 and (u880.song or u880);

    if not v922 then
        if v921 then
            v922 = song or nil;
        else
            v922 = nil;
        end;
    end;

    local v923;

    if v922 == nil then
        v923 = nil;
    else
        v923 = v922.eventObjects;
    end;

    local v924 = nil;
    local v925 = v924 == nil and true or v924;
    local v926 = u900 and (u880.song or u880);

    if not v926 then
        if v925 then
            v926 = song or nil;
        else
            v926 = nil;
        end;
    end;

    local v927;

    if v926 == nil then
        v927 = nil;
    else
        v927 = v926.leatherEvents;
    end;

    local v928 = nil;
    local v929 = v928 == nil and true or v928;
    local v930 = u900 and (u880.song or u880);

    if not v930 then
        if v929 then
            v930 = song or nil;
        else
            v930 = nil;
        end;
    end;

    local v931;

    if v930 == nil then
        v931 = nil;
    else
        v931 = v930.codenameEvents;
    end;

    local v932 = nil;
    local v933 = v932 == nil and true or v932;
    local v934 = u900 and (u880.song or u880);

    if not v934 then
        if v933 then
            v934 = song or nil;
        else
            v934 = nil;
        end;
    end;

    local v935;

    if v934 == nil then
        v935 = nil;
    else
        v935 = v934.vanillaEvents;
    end;

    addNotesFromChart(song, v911 ~= nil);

    if v907 then
        local v936 = 0;

        for _, v in v907 do
            local v937 = v[1];
            local v938 = v[2];

            if v938 == nil then
                v936 = v936 + 1;
            else
                for _, v2 in v938 do
                    addEvent({
                        StrumTime = v937,
                        Name = v2[1],
                        Value1 = v2[2],
                        Value2 = v2[3]
                    });
                end;
            end;
        end;

        if v936 > 0 then
            u2.Logger.warn((`Skipped {v936} malformed entries, this chart is missing events`));
        end;
    end;

    if v911 then
        for _, v in v911 do
            if v ~= nil then
                for _, v2 in v.sectionNotes do
                    if v2[2] < 0 then
                        addEvent({
                            StrumTime = v2[1],
                            Name = v2[3],
                            Value1 = v2[4],
                            Value2 = v2[5]
                        });
                    end;
                end;
            end;
        end;
    end;

    if v927 then
        for _, v in v927 do
            addEvent({
                StrumTime = v[2],
                Name = v[1],
                Value1 = v[3],
                Value2 = v[4]
            });
        end;
    end;

    if v923 then
        for _, v in v923 do
            local _ = v.name;
            local v939 = tonumber(v.position) or 0;
            local v940 = u2.Conductor.Crochet * v939;

            if v.step then
                local v941 = tonumber(v.step) or 0;
                v940 = u2.Conductor.StepCrochet * v941;
            end;

            addEvent({
                Value2 = nil,
                Name = v.type,
                StrumTime = v940,
                Value1 = v.value
            });
        end;
    end;

    if v915 then
        for _, v in v915 do
            local name = v.name;
            local v942 = tonumber(v.position) or 0;
            local v943 = u2.Conductor.Crochet * v942;

            if v.step then
                local v944 = tonumber(v.step) or 0;
                v943 = u2.Conductor.StepCrochet * v944;
            end;

            addEvent({
                Value2 = nil,
                Name = name,
                StrumTime = v943,
                Value1 = v.args
            });
        end;
    end;

    if v931 then
        for _, v in v931 do
            addEvent({
                Value2 = nil,
                Name = "Codename " .. v.name,
                StrumTime = v.time,
                Value1 = v.params
            });
        end;
    end;

    if v935 then
        for _, v in v935 do
            addEvent({
                Value2 = nil,
                Name = v.e,
                StrumTime = v.t,
                Value1 = v.v
            });
        end;
    end;

    if v919 then
        for _, v in v919 do
            addEvent({
                Name = v.name,
                StrumTime = v.time,
                Value1 = v.parameters
            });
        end;
    end;

    if p882 then
        local v945 = p882[1];
        local v946 = p882[2];
        local v947 = p882[3];

        if v946 == "SRT" then
            local v948 = u2.SRTParser.parse(v945);

            if v948 then
                for _, v in v948 do
                    addEvent({
                        Name = "Afternight Subtitles",
                        StrumTime = v.startTime,
                        Value1 = v.text,
                        Value2 = v947 or ""
                    });
                    addEvent({
                        Name = "Afternight Subtitles",
                        Value1 = " ",
                        StrumTime = v.endTime,
                        Value2 = v947 or ""
                    });
                end;
            end;
        else
            local v949 = v946 == "LRC" and u2.LRCParser.ParseLRCToBaseTable(v945);

            if v949 then
                for _, v in v949 do
                    addEvent({
                        Name = "Afternight Subtitles",
                        StrumTime = u2.Adapters.SecondsToMilliseconds(v.Timestamp),
                        Value1 = v.Lyric,
                        Value2 = v947 or ""
                    });
                end;
            end;
        end;
    end;

    table.sort(u119, function(p950, p951) -- Line: 5549
        return p950.StrumTime < p951.StrumTime;
    end);
    table.sort(u120, function(p952, p953) -- Line: 5550
        return p952.StrumTime < p953.StrumTime;
    end);
end;

u86.parseChart = parseChart;

function checkBreakTimer()
    -- upvalues: Data (ref), u156 (ref), u2 (copy), u144 (copy), u115 (ref)
    if not (Data.ShowBreakTimer and u156) then
        return;
    end;

    local v954 = u156.Notes[1] or u156.UnspawnNotes[1];

    if v954 then
        local v955 = v954.strumTime - u2.Conductor.SongPosition;

        if v955 >= 2000 and u144.start == nil then
            u144.Functions.StartProgress(v955 / 1000 / u115, 100);
            task.delay(v955 / 1000 / u115 + 0.25 / u115, function() -- Line: 5566
                -- upvalues: u144 (ref)
                u144.Functions.ClearProgress();
            end);
        end;
    end;
end;

local u956 = {
    L = {},
    R = {}
};

function playNoteAnimation(p957, p958, ...)
    -- upvalues: u2 (copy), u187 (ref), u956 (ref), u155 (ref), u188 (ref), u140 (ref), Data (ref)
    local strumLine = p957.strumLine;
    local v959 = p957.strum or strumLine.Strums[p957.noteData];

    if strumLine.LinkedCharacter then
        strumLine.LinkedCharacter:Play(p957.forcedAnim or (v959.animDir or u2.Adapters.convertNoteAnimToBase(p957.dir)), p958 or (p957.altAnim and "ALT" or p957.altType), ...);
    else
        local v960 = u187[p957.charSide];

        for _, v in p957.dType do
            local v961;

            if type(v) == "table" then
                v961 = v;
            else
                local v962 = tonumber(v) or 0;
                v961 = v960[v962];

                if v961 == nil or v961.isOpponent and not u956[p957.charSide][v962] then
                    v961 = v960[u155];
                end;
            end;

            if v961 then
                u188[p957.charSide] = v961;

                if not v961.isOpponent then
                    v961:Play(p957.forcedAnim or (v959.animDir or u2.Adapters.convertNoteAnimToBase(p957.dir)), p958 or (p957.altAnim and "ALT" or p957.altType), ...);
                end;
            end;
        end;
    end;

    local v963 = u140[p957.charSide];

    for _, v in p957.dType do
        local v964;

        if type(v) == "table" then
            v964 = v;
        else
            v964 = v963[tonumber(v) or 0];

            if v964 == nil then
                v964 = v963[u155];
            end;
        end;

        local v965 = u2.Adapters.convertNoteAnimToBase(p957.dir);

        if Data.ShowHUD and (v964 ~= nil and v964:animExists(v965)) then
            v964:PlayEvent(v965, false);
        end;
    end;
end;

function goodHit(p966, p967)
    -- upvalues: u139 (ref), u138 (ref), u115 (ref), u2 (copy), _Gameplay (copy), u89 (copy), Data (ref), u134 (ref), u86 (copy), u356 (ref), u101 (ref), u158 (ref), u764 (ref), u357 (ref), u365 (ref), u370 (ref), u371 (ref), u162 (ref), u368 (ref), Sounds (copy), u125 (ref), u366 (ref)
    if not p966.alive then
        return;
    end;

    if not p966.simpleSus and (p966.hit and p966.sustainNote) or p966.missed then
        return;
    end;

    p966.hit = true;

    if u139 then
        u138 = true;
    end;

    local v968 = p967 / u115;
    local ScoreAndJudgement = u2.ratingModule.GetScoreAndJudgement(v968);
    ScoreAndJudgement.translatedName = _Gameplay.Get((`HUD.{ScoreAndJudgement.name}`)) or ScoreAndJudgement.name;
    u89:call("onPlayerNoteHit", p966, ScoreAndJudgement);
    local v969 = not p966.shouldBeHitted and p966.hitCausesMiss;
    local v970 = (v969 and 0 or 1) * p966.scoreMult;

    if not p966.alive then
        return;
    end;

    local v971 = p966.strum or p966.strumLine.Strums[p966.noteData];
    local HoldNoteScorePerSecond = u2.ratingModule.GetHoldNoteScorePerSecond();
    local v972;

    if p966.sustainNote then
        v972 = 0.1;

        if v969 then
            u764[p966.dir] = nil;
        else
            u764[p966.dir] = p966.parentNote;
        end;

        if p966.isEnd then
            if HoldNoteScorePerSecond > 0 and (u764[p966.dir] ~= nil and (u125[p966.dir] or u158)) then
                local parentNote = p966.parentNote;

                if parentNote.maxScore and parentNote.obtainedScore then
                    local v973 = math.max(0, parentNote.maxScore - parentNote.obtainedScore) - HoldNoteScorePerSecond * ((parentNote.missedDuration or 0) / 1000);
                    local math_max_ret = math.max(0, v973);
                    local v974 = math_max_ret * u86.scoreMultiplier;
                    u366 = u366 + v974;
                    local v975 = u86;
                    v975.fakeSustainScore = v975.fakeSustainScore + v974 * u86.fakeScoreMultiplier;
                    updateStatsLabel();
                    parentNote.obtainedScore = parentNote.obtainedScore + math_max_ret;
                end;
            end;

            u764[p966.dir] = nil;
            releaseHoldsplash(v971, p966.quantDir, false);
            u89:call("onSustainEnd", p966);
        end;
    else
        if Data.AccuracyLabelBop then
            u134:AccuracyBop();
        end;

        if Data.ControllerVibration and ScoreAndJudgement.spawnSplash then
            u86.hitHaptic:Play();
        end;

        local v976 = u356;
        local name = ScoreAndJudgement.name;
        v976[name] = v976[name] + 1;
        p966:SetRating(ScoreAndJudgement);
        v972 = ScoreAndJudgement.ratingMod;
        local table_concat_ret = table.concat(p966.rawData, "|", 1, 3);

        if u101 then
            table_concat_ret = (u158 and "​" or "⁤") .. table_concat_ret;
        end;

        if v969 == false then
            u2.NetworkFunctions.fireStageRemoteBatched("NoteHit", table_concat_ret, v968);
        end;

        if #p966.sustains > 0 then
            u764[p966.dir] = p966;

            if HoldNoteScorePerSecond > 0 then
                local v977 = 0;

                for _, v in p966.sustains do
                    v977 = v977 + HoldNoteScorePerSecond * ((v.susEndTime - v.strumTime) / 1000);
                end;

                p966.maxScore = v977;
            end;
        end;

        if getSetting(v971.side, "Notesplashes") and ScoreAndJudgement.spawnSplash then
            createNotesplash(v971, p966.quantDir);
        end;

        if getSetting(v971.side, "Holdsplashes") and #p966.sustains > 0 then
            createHoldsplash(v971, p966.quantDir);
        end;

        local v978 = u357;
        v978.meanSum = v978.meanSum + v968;

        if not p966.ignoreAccuracy then
            local v979 = u357;
            v979.notesPlayed = v979.notesPlayed + 1;
            local v980 = u357;
            v980.notesHit = v980.notesHit + ScoreAndJudgement.ratingMod * v970;
            table.insert(u357.list, {
                strumTime = p966.strumTime,
                name = ScoreAndJudgement.name,
                offset = v968
            });
        end;

        local v981 = ScoreAndJudgement.score * u86.scoreMultiplier * v970;
        u365 = u365 + v981;
        local v982 = u86;
        v982.fakeScore = v982.fakeScore + v981 * u86.fakeScoreMultiplier;

        if ScoreAndJudgement.comboBreak then
            u370 = 0;
        else
            u370 = u370 + 1;
        end;

        if u371 < u370 then
            u371 = u370;
        end;

        if u370 > 0 and (u370 % 50 == 0 and u162) then
            u162:Play("Hey");
        end;

        u368 = u357.notesHit / u357.notesPlayed;
        spawnJudgement(ScoreAndJudgement, v968, p966, v971);
        spawnCombo(u370);
        doHitError(v968);
        spawnJudgementOffset(v968);
        updateStatsLabel();

        if not Data.PlayHitsoundAtReceptor then
            if p966.hitSound == nil then
                if Data.HitSounds and Data.HitSoundID ~= 0 then
                    u2.SoundLibrary:Play(Sounds.Hit.SoundId, 1);
                end;
            else
                u2.SoundLibrary:Play(p966.hitSound, p966.hitSoundVolume or 1);
            end;
        end;
    end;

    if p966.killOnHit == true then
        addHealth(-99);
        die();
    else
        addHealth(p966.hitHealth * (p966.texture ~= nil and 1 or v972));
    end;

    if v969 then
        doMiss(p966, v971);
    end;

    if not Data.DisableArrowGlow and (u125[p966.dir] or u158) then
        local v983 = v971:Play("confirm", true);

        if u158 then
            v983.resetAnim = "static";
            v983.resetTime = 0.125;
        end;
    end;

    if p966.playAnim then
        playNoteAnimation(p966);
    end;

    u89:call("onPlayerNoteHitPost", p966, ScoreAndJudgement);

    if not p966.sustainNote then
        p966.wasHit = true;
        p966:Destroy();
    end;
end;

function opponentHit(p984, p985)
    -- upvalues: u156 (ref), u158 (ref), u139 (ref), u138 (ref), u89 (copy), Data (ref), u157 (ref), u133 (ref)
    if not p984.alive then
        return;
    end;

    local v986 = p984.shouldBeHitted and not p984.hitCausesMiss and p984.hitbox > 0;
    local v987 = p984.strumLine == u156;

    if v987 or not p984.simpleSus and p984.hit then
        if v987 and (v986 and u158) then
            task.spawn(goodHit, p984, 0);
        end;

        return;
    end;

    if u139 then
        u138 = true;
    end;

    if v986 then
        p984.hit = true;
        u89:call("onOpponentNoteHit", p984);

        if not p984.alive then
            return;
        end;

        local v988 = p984.strum or p984.strumLine.Strums[p984.noteData];

        if getSetting(p984.side, "Notesplashes") and p985.spawnSplash then
            if p984.sustainNote then
                if p984.isEnd then
                    releaseHoldsplash(v988, p984.quantDir, false);
                end;
            elseif #p984.sustains > 0 and getSetting(p984.side, "Holdsplashes") then
                createHoldsplash(v988, p984.quantDir);
            else
                createNotesplash(v988, p984.quantDir);
            end;
        end;

        if (Data.HealthDrain or u157.forceHealthDrain) and u157.allowHealthDrain then
            local v989 = p984.hitHealth * (p984.sustainNote and 0.1 or p985.ratingMod) * Data.HealthDrainIntensity;
            local v990 = Data.HealthDrainLimit * u157.maxHealth;

            if u157.currentHealth > v990 then
                local v991 = u157.currentHealth - v989 * u157.lossMult * u157.globalLossMult;

                if v991 <= v990 then
                    v989 = (u157.currentHealth - math.clamp(v991, v990, 10000)) / u157.lossMult / u157.globalLossMult;
                end;

                removeHealth(v989);
            end;
        end;

        if p984.playAnim then
            playNoteAnimation(p984);
        end;

        if u133 ~= "KadeEngine" and not Data.DisableArrowGlow then
            local v992 = v988:Play("confirm", true);
            v992.resetAnim = "static";
            v992.resetTime = 0.125;
        end;

        if not p984.sustainNote then
            p984:Destroy();
        end;
    end;
end;

function doMiss(p993: any, p994: any, p995: boolean?)
    -- upvalues: u365 (ref), u2 (copy), u86 (copy), _Gameplay (copy), u356 (ref), u357 (ref), u368 (ref), u370 (ref), u371 (ref), u764 (ref), u89 (copy), Data (ref), u1 (copy), u115 (ref), u162 (ref), Sounds (copy)
    local v996 = p995 and -999 or 999;
    u365 = u365 + u2.ratingModule.GetMissScore() * u86.scoreMultiplier;
    local v997 = u86;
    v997.fakeScore = v997.fakeScore + u2.ratingModule.GetMissScore() * u86.fakeScoreMultiplier;
    u2.NetworkFunctions.fireStageRemoteBatched("NoteMiss");
    local ScoreAndJudgement = u2.ratingModule.GetScoreAndJudgement(v996);
    ScoreAndJudgement.translatedName = _Gameplay.Get((`HUD.{ScoreAndJudgement.name}`)) or ScoreAndJudgement.name;
    local v998 = u356;
    local name = ScoreAndJudgement.name;
    v998[name] = v998[name] + 1;
    local v999 = u357;
    v999.notesPlayed = v999.notesPlayed + 1;
    table.insert(u357.list, {
        strumTime = p993 and p993.strumTime or u2.Conductor.SongPosition,
        name = ScoreAndJudgement.name,
        offset = v996
    });
    u368 = u357.notesHit / u357.notesPlayed;

    if ScoreAndJudgement.comboBreak then
        u370 = 0;
    else
        u370 = u370 + 1;
    end;

    if u371 < u370 then
        u371 = u370;
    end;

    spawnJudgement(ScoreAndJudgement, v996, p993, p994);
    spawnCombo(u370);
    updateStatsLabel();

    if p993 then
        u764[p993.dir] = nil;
        releaseHoldsplash(p994, p993.quantDir, true);
        u89:call("onNoteMiss", p993);

        if Data.FlashLaneOnMiss and p993.strumLine ~= nil then
            local lane = p993.strumLine.LaneBacks[p993.column + 1].lane;
            lane.BackgroundColor3 = Color3.new(1, 1, 1);
            u1.TweenService:Create(lane, TweenInfo.new(1 / u115), {
                BackgroundColor3 = Color3.new(0, 0, 0)
            }):Play();
        end;
    else
        u89:call("onGhostMiss");
    end;

    removeHealth(p993 and (p993.missHealth or 0.05) or 0.05);

    if p993 and Data.NoMissAnimation == false then
        playNoteAnimation(p993, "MISS");

        if u162 then
            u162:Play("Miss");
        end;
    end;

    if not Data.MissSounds then
        return;
    end;

    if p993 and p993.missSound ~= nil then
        u2.SoundPlayer.PlayTrackedSound(p993.missSound, p993.missSoundVolume);

        return;
    end;

    if Data.MissSoundID <= 0 then
        u2.SoundLibrary:Play(`Gameplay/MissNote{tostring(math.random(1, 3))}`, Data.MissSoundVolume);

        return;
    end;

    u2.SoundPlayer.PlayTrackedSound(Sounds.Miss);
end;

function missNote(p1000)
    -- upvalues: u159 (ref), u160 (ref), u89 (copy), u156 (ref), u158 (ref)
    if u159 and not u160 then
        u89:call("onNoteMiss", p1000);

        return;
    end;

    if p1000.alive and not (p1000.missed or (p1000.ignoreNote or (p1000.strumLine ~= u156 or p1000.hit and not p1000.simpleSus))) then
        if u158 then
            goodHit(p1000, 0);

            return;
        end;

        p1000.offsets.set("alpha", "missOffset", 0.5);

        for _, v in p1000.sustains or {} do
            if v.alive then
                v.offsets.set("alpha", "missOffset", 0.5);
                v.missed = true;
            end;
        end;

        doMiss(p1000, p1000.strum or p1000.strumLine.Strums[p1000.noteData]);
        p1000.missed = true;
    end;
end;

function addHealth(p1001: number)
    -- upvalues: u157 (ref)
    local v1002 = u157;
    v1002.currentHealth = v1002.currentHealth + p1001 * u157.gainMult * u157.globalGainMult;
end;

function removeHealth(p1003: number)
    -- upvalues: u157 (ref)
    local v1004 = u157;
    v1004.currentHealth = v1004.currentHealth - p1003 * u157.lossMult * u157.globalLossMult;
end;

function setHealth(p1005)
    -- upvalues: u157 (ref)
    u157.currentHealth = p1005;
end;

u86.doMiss = doMiss;
u86.addHealth = addHealth;
u86.removeHealth = removeHealth;
u86.setHealth = setHealth;

function u86.setHealthGain(p1006) -- Line: 5990
    -- upvalues: u157 (ref)
    u157.gainMult = p1006;
end;

function u86.setHealthLoss(p1007) -- Line: 5991
    -- upvalues: u157 (ref)
    u157.lossMult = p1007;
end;

function u86.allowHealthDrain(p1008) -- Line: 5992
    -- upvalues: u157 (ref)
    u157.allowHealthDrain = p1008;
end;

function u86.forceHealthDrain(p1009) -- Line: 5993
    -- upvalues: u157 (ref)
    u157.forceHealthDrain = p1009;
end;

function u86.getHealthStats() -- Line: 5994
    -- upvalues: u157 (ref)
    return u157;
end;

function getExtraData()
    -- upvalues: u357 (ref), u356 (ref)
    local v1010 = u357.notesPlayed <= 0 and 0 or round(u357.meanSum / u357.notesPlayed, 2);
    local v1011 = u356.Sick + u356.Good + u356.Ok + u356.Bad;
    local v1012 = u356.Good + u356.Ok + u356.Bad;

    return {
        mean = v1010,
        ma = u356.Marvelous + v1011 <= 0 and "inf:1" or round(u356.Marvelous / math.max(1, v1011), 2) .. ":1",
        pa = u356.Sick + v1012 <= 0 and "inf:1" or round(u356.Sick / math.max(1, v1012), 2) .. ":1"
    };
end;

function updateStatsLabel()
    -- upvalues: Data (ref), Obj (ref), u356 (ref), u368 (ref), u134 (ref), u86 (copy), u370 (ref), _Gameplay (copy), u2 (copy), u89 (copy)
    if not Data.ShowHUD then
        return;
    end;

    local v1013 = Data.ShowInfoOnRight and Obj.SidebarRight or Obj.SidebarLeft;
    local v1014 = getExtraData();
    local v1015 = {
        Marvelous = 0,
        Sick = 0,
        Good = 0,
        Ok = 0,
        Bad = 0,
        Miss = 0
    };

    if u356 then
        for i, v in u356 do
            if v ~= nil then
                v1015[i] = v;
            end;
        end;
    end;

    local v1016 = round(u368 * 100, 2);
    u134:SetAccuracy({
        Score = u86.fakeScore + math.floor(u86.fakeSustainScore),
        Combo = u370,
        Rating = _Gameplay.Get("Judgements_" .. u2.ratingModule.getJudgementTitle(v1015)),
        ComboBreaks = v1015.Miss,
        Accuracy = v1016,
        RatingLetter = u2.ratingModule.getRatingLetter(v1016),
        Judgements = v1015
    });

    if u134.UpdatingDisabled and not table.find(u134.UpdatingDisabled, "JudgementCounter") then
        v1013.JudgementCounter.Text = _Gameplay.Format("HUD.JudgementCounter", v1015);
    end;

    v1013.ExtraInfo.Text = _Gameplay.Format("HUD.ExtraInfo", v1014);
    u89:call("onScoreTextUpdate", Obj.Accuracy.Text);
end;

u86.updateStatsLabel = updateStatsLabel;
({
    Accuracy = 0,
    BaseScore = 0,
    Score = 0,
    Misses = 0,
    TotalNotesHit = 0,
    TotalNotesPlayed = 0,
    IsFC = true,
    IsPFC = true,
    IsMFC = true,
    IsGFC = true,
    Failed = false
}).Modifiers = {};
u2.NetworkFunctions.listenTo("ForwardOpponentStats", function(p1017: buffer) -- Line: 6070
    -- upvalues: u369 (ref)
    u369.notesPlayed = buffer.readu32(p1017, 0);
    u369.notesHit = buffer.readu32(p1017, 4);
    u369.score = buffer.readu32(p1017, 8);
    local v1018 = u369;
    v1018.combo = v1018.combo + 1;

    if u369.combo > u369.topCombo then
        u369.topCombo = u369.combo;
    end;

    updateOppStatsLabel();
end);

function updateOppStatsLabel()
    -- upvalues: Data (ref), u369 (ref), u134 (ref), u137 (ref)
    if not Data.ShowHUD then
        return;
    end;

    u369.accuracy = u369.notesHit / u369.notesPlayed;
    u134:SetOpponentAccuracy({
        Score = u369.score,
        Combo = u369.combo,
        ComboBreaks = u369.misses,
        Accuracy = u369.accuracy
    });

    if u137 == nil then
        return;
    end;

    u137.Inner.Label.Text = `Score: {round(u369.score, 0)} - Accuracy: {round(u369.accuracy * 100, 2)}% - Misses: {u369.misses}`;
end;

function loadNoteset(p1019, p1020, p1021)
    -- upvalues: u249 (ref), u2 (copy), ManiaData (copy)
    local strumLine = p1019.strumLine;

    if not p1019.strum then
        local _ = strumLine.Strums[p1019.noteData];
    end;

    local v1022 = strumLine.Noteskin or u249;
    local v1023 = v1022[p1020];

    if p1019.texture then
        local v1024;

        if getSetting(p1019.side, "SimpleGimmickNotes") and p1019.textureFallback then
            v1024 = cacheNoteType(p1019.textureFallback) or v1022;
        else
            v1024 = cacheNoteType(p1019.texture) or v1022;
        end;

        v1023 = v1024[p1020];
    end;

    if not v1023 then
        local v1025 = strumLine.NoteskinCachePath or "unknownNoteskinCache";
        local v1026 = strumLine.NoteskinPath or u2.AssetReplicator.getAsset("Noteskins", "Friday Night Funkin\'");
        v1023 = cacheNoteSet(v1025, getSetBelow(v1026, p1020), p1020);
        v1022[p1020] = v1023;
    end;

    if v1023 then
        local _id = v1023._id;
        p1019.antialiasing = v1023._antialiasing;

        if v1023._cachedNoteAnims then
            p1019.Animations = v1023._cachedNoteAnims;
        else
            p1019.Animations = {};
            p1019:AddAnimation("scroll", v1023.note, 24, true, _id);
            p1019:AddAnimation("hold", v1023.hold, 24, true, _id);
            p1019:AddAnimation("holdend", v1023.holdend, 24, true, _id);

            if p1019.curAnim and p1019.curAnim ~= "" then
                p1019:Play(p1019.curAnim, true);
            end;

            v1023._cachedNoteAnims = p1019.Animations;
        end;

        p1019:load(v1023._rgbId);
    else
        u2.Logger.log("Note asset", p1020, "is missing set: ", p1019.texture);
    end;

    if p1021 then
        if p1019.quantDir ~= "" then
            p1020 = p1019.quantDir or p1020;
        end;

        p1019.imageColor = ManiaData.colors[p1020];
    end;
end;

function applyQuantsToNote(p1027)
    -- upvalues: u2 (copy), ManiaData (copy)
    local KeyCount = p1027.strumLine.KeyCount;
    local BeatFromTime = u2.TimeFunctions.getBeatFromTime(p1027.sustainNote and p1027.baseStrumTime or p1027.strumTime);
    local v1028 = round(BeatFromTime * 48, 0);
    local v1029 = { 6, 7, 5, 4, -1, 0, 3, 1, 2, -1, -1 };
    local v1030 = -1;

    for i, v in { 4, 8, 12, 16, 20, 24, 32, 48, 64, 96, 192 } do
        if v1028 % (192 / v) == 0 then
            v1030 = v1029[i];
            break;
        end;
    end;

    if v1030 < 0 then
        p1027.imageColor = Color3.new(0.5, 0.5, 0.5);
        v1030 = 3;
    end;

    local v1031 = ManiaData.dirs[8][v1030 + 1];
    local v1032 = 0 - ManiaData.angles[4][v1030 % 4 + 1] + ManiaData.angles[KeyCount][p1027.column % KeyCount + 1];
    p1027.quantCol = v1030;
    p1027.quantDir = v1031;

    if not p1027.sustainNote then
        if v1032 == 0 or not v1032 then
            v1032 = nil;
        end;

        p1027.offsets.set("angle", "quantAngle", v1032);
    end;

    loadNoteset(p1027, v1031, false);
end;

u86.loadNoteset = loadNoteset;
u86.applyQuantsToNote = applyQuantsToNote;
u86.getBPMFromTime = u2.TimeFunctions.getBPMFromTime;
u86.getTimeFromStep = u2.TimeFunctions.getTimeFromStep;
u86.getTimeFromBeat = u2.TimeFunctions.getTimeFromBeat;
u86.getStepFromTime = u2.TimeFunctions.getStepFromTime;
u86.getBeatFromTime = u2.TimeFunctions.getBeatFromTime;
local u1033 = false;
local u1034 = 1;

function checkNoteSpawns()
    -- upvalues: u108 (ref), u2 (copy), u250 (ref), u24 (copy), u127 (ref), u116 (copy), u156 (ref), Data (ref), u124 (ref), u36 (ref), u89 (copy), u1033 (ref), u115 (ref), u139 (ref), u138 (ref), u76 (ref), u117 (copy)
    if not u108 then
        return;
    end;

    local SongPosition = u2.Conductor.SongPosition;
    local math_abs_ret = math.abs(u250);
    local v1035 = u24.noteSpawnTime * 1000;
    local v1036;

    if #u127 > 1 then
        v1036 = true;
    else
        v1036 = false;
    end;

    while true do
        local u1037 = u116[1];

        if not u1037 then
            break;
        end;

        if u1037.cancelSpawn then
            table.remove(u116, 1);
        else
            local strumLine = u1037.strumLine;
            local v1038 = u1037.strum or strumLine.Strums[u1037.noteData];

            if v1038 then
                local v1039 = (u1037.multSpeed or 1) * (v1038.laneSpeed or 1);
                local v1040;

                if v1036 then
                    local v1041 = getSVFromTime(u1037.strumTime);
                    v1040 = v1035 / math.abs(v1041);
                else
                    v1040 = v1035 / (math_abs_ret * v1039);
                end;

                if u24.reverseNotes and u1037.strumTime > SongPosition or u1037.strumTime - v1040 * u1037.spawnTimeMult > SongPosition then
                    break;
                end;

                local v1042;

                if strumLine == u156 then
                    v1042 = false;
                else
                    v1042 = Data.DisableOpponentStrums;
                end;

                local v1043 = Data.ShowcaseMode and u2.PlayerRanks:isDev() and true or v1042;

                if u124.chartPlayers > 2 then
                    v1043 = false;
                end;

                if u1037.side == u36 or not v1043 then
                    u1037:makeObj();
                end;

                u1037.active = not v1043;
                u1037.loadTextures = u1037._active;

                if u1037.loadTextures then
                    local KeyCount = strumLine.KeyCount;
                    local v1044 = getSetting(u1037.side, "QuantNotes") and table.find({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, KeyCount) and not u1037.texture;
                    u1037.useQuants = v1044;

                    if u1037.useQuants then
                        applyQuantsToNote(u1037);
                    else
                        loadNoteset(u1037, u1037.dir, false);
                    end;

                    u1037:Play(u1037.sustainNote and (u1037.isEnd and "holdend" or "hold" or "scroll") or "scroll");

                    if u1037.curAnim == "hold" then
                        u1037.offsets.set("rectImageOffset", "textureFix", Vector2.new(0, (math.min(2, u1037.rawFrameSize.y / 5))));
                    end;

                    u89:call("onNoteTextureCreated", u1037);
                end;

                u89:call("onSpawnNote", u1037);

                if not u1033 then
                    u1033 = true;
                    trackDelayedThread((u1037.strumTime - u2.Conductor.SongPosition - 2000) / 1000 / u115, function() -- Line: 6285
                        -- upvalues: u139 (ref), u138 (ref)
                        if u139 then
                            u138 = true;
                        end;
                    end);
                end;

                if u76 then
                    local ScoreAndJudgement = u2.ratingModule.GetScoreAndJudgement(0);

                    for _, v in u1037.sustainTimes or { u1037.strumTime } do
                        trackDelayedThread((v - u2.Conductor.SongPosition) / 1000 / u115 - Data.InputOffset / 1000, function() -- Line: 6295
                            -- upvalues: u1037 (copy), ScoreAndJudgement (copy)
                            opponentHit(u1037, ScoreAndJudgement);
                        end);
                    end;
                else
                    for _, v in u1037.sustainTimes or { u1037.strumTime } do
                        trackDelayedThread((v - u2.Conductor.SongPosition) / 1000 / u115, function() -- Line: 6301
                            -- upvalues: u139 (ref), u138 (ref), u1037 (copy), u156 (ref)
                            if u139 then
                                u138 = true;
                            end;

                            if u1037.strumLine == u156 then
                                return;
                            end;

                            playNoteAnimation(u1037);
                            u1037.playAnim = false;
                        end);
                    end;
                end;

                if not v1043 then
                    local tablesStored = u1037.tablesStored;
                    local v1045 = #tablesStored;
                    local Notes = strumLine.Notes;
                    u117[#u117 + 1] = u1037;
                    tablesStored[v1045 + 1] = u117;
                    Notes[#Notes + 1] = u1037;
                    tablesStored[v1045 + 2] = Notes;

                    if not u1037.sustainNote then
                        local v1046 = strumLine.Lanes[u1037.noteData];
                        v1046[#v1046 + 1] = u1037;
                        tablesStored[v1045 + 3] = v1046;
                    end;
                end;

                table.remove(u116, 1);
            else
                u2.Logger.log("Invalid note! Note data: " .. u1037.noteData);
                table.remove(u116, 1);
            end;
        end;
    end;
end;

function doEvent(p1047)
    -- upvalues: u89 (copy)
    triggerEvent(p1047.Name, p1047.Value1, p1047.Value2, p1047.StrumTime);
    u89:call("onEvent", p1047.Name, p1047.Value1, p1047.Value2, p1047.StrumTime);
end;

function u86.triggerDoEvent(p1048, p1049, p1050) -- Line: 6341
    -- upvalues: u2 (copy)
    doEvent({
        Name = p1048,
        Value1 = p1049,
        Value2 = p1050,
        StrumTime = u2.Conductor.SongPosition
    });
end;

u86.doEvent = doEvent;

function checkEvents()
    -- upvalues: u108 (ref), u2 (copy), u119 (copy)
    if not u108 then
        return;
    end;

    local SongPosition = u2.Conductor.SongPosition;

    while true do
        local v1051 = u119[1];

        if not v1051 or v1051.StrumTime > SongPosition then
            break;
        end;

        table.remove(u119, 1);
        doEvent(v1051);
    end;
end;

function doCamEvent(p1052)
    -- upvalues: Data (ref), u363 (ref), u182 (ref), u397 (ref), u2 (copy), u115 (ref), u398 (ref), u399 (ref), u89 (copy)
    if not p1052 then
        return;
    end;

    if not Data.CameraMovement then
        return;
    end;

    u363 = p1052.Target;

    if p1052.Position == nil then
        u182.offset.position.x = 0;
        u182.offset.position.y = 0;
    else
        u182.offset.position.x = p1052.Position.X / 100;
        u182.offset.position.y = -p1052.Position.Y / 100;
    end;

    if p1052.Duration and (p1052.Duration ~= "" and p1052.Duration > 0) then
        u397 = u2.Conductor.StepCrochet * p1052.Duration / 1000 / u115;
    else
        u397 = nil;
    end;

    if p1052.Easing and p1052.Easing ~= "" then
        u398 = p1052.Easing;

        if u398:lower() == "instant" then
            u398 = "Constant";
            u397 = 0.001;
        end;

        if p1052.EasingDirection and p1052.EasingDirection ~= "" then
            u399 = p1052.EasingDirection;
        end;
    else
        u398 = nil;
        u399 = nil;
    end;

    u89:call("onCamSwitch", u363, p1052);
end;

u86.doCamEvent = doCamEvent;

function checkCamEvents()
    -- upvalues: u108 (ref), u2 (copy), u120 (ref)
    if not u108 then
        return;
    end;

    local SongPosition = u2.Conductor.SongPosition;

    while true do
        local v1053 = u120[1];

        if not v1053 or v1053.StrumTime > SongPosition then
            break;
        end;

        doCamEvent(v1053);
        table.remove(u120, 1);
    end;
end;

function updateConductor(p1054)
    -- upvalues: u108 (ref), u2 (copy), u113 (copy), u115 (ref)
    if u108 and not u2.Conductor.Paused then
        local timePosition = u113.timePosition;

        if timePosition <= 0 then
            return u2.Conductor.setSongPos(u2.Conductor.RawTimePosition + p1054 * u115);
        end;

        return u2.Conductor.setSongPos(timePosition);
    end;
end;

function camZoom(p1055)
    p1055.zoom = p1055.zoom + p1055.cameraBeatZoom * p1055.cameraBeatMultiplier;
end;

u86.camHUD = u181;
u86.camGame = u182;
u86.camZoom = camZoom;
u86.getYPosAt = u2.MathFuncs.getYPosAt;

function beatHit(p1056)
    -- upvalues: u360 (ref), u2 (copy), u33 (ref), u362 (ref), u122 (ref), u123 (ref), u121 (ref), u36 (ref), u157 (ref), u140 (ref), u3 (copy), u115 (ref), u363 (ref), u89 (copy)
    u360 = p1056;
    u2.Conductor.Beat = p1056;

    if u360 % u2.Conductor.BeatsPerMeasure == 0 then
        sectionHit(u360 / u2.Conductor.BeatsPerMeasure);
    end;

    local v1057 = (u33.notes[u362 + 1] or {}).altAnim or false;

    if u122 ~= u123 or u121 ~= v1057 then
        u121 = v1057;
        u123 = u122;
        syncIdle();
    end;

    local math_round_ret = math.round((u36 == "L" and u157.totalHealth - u157.currentHealth or u157.currentHealth) / u157.totalHealth * 100);

    for i, v in u140 do
        local v1058 = i;

        for _, v2 in v do
            if not v2.overrideBop and v2.obj.Parent:FindFirstChild("UIScale") then
                u3.iconBops.BeatHit(v2.obj.Parent, getSetting(v1058, "IconBop"), u115, {
                    Beat = u360,
                    Side = v1058 == "L" and "Left" or "Right",
                    MustHit = v1058 == "L" and u363 == 0 and true or u363 == 1,
                    Conductor = u2.Conductor,
                    Sprite = v2,
                    HealthStatus = math_round_ret
                });
            end;
        end;
    end;

    u89:call("onBeatHit", u360);
end;

function stepHit(p1059)
    -- upvalues: u359 (ref), u2 (copy), u181 (ref), u182 (ref), u138 (ref), u33 (ref), u362 (ref), u363 (ref), u188 (ref), u89 (copy), u36 (ref), u157 (ref), u140 (ref), u3 (copy), u115 (ref)
    u359 = p1059;
    u2.Conductor.Step = u359;

    if u359 % u2.Conductor.StepsPerBeat == 0 then
        beatHit(u359 / u2.Conductor.StepsPerBeat);
    end;

    for _, v in { u181, u182 } do
        if u359 % v.cameraBeat == 0 and u138 then
            camZoom(v);
        end;
    end;

    local v1060 = u33.notes[u362 + 1] or {};
    local v1061 = 16;

    if v1060 then
        if v1060.sectionBeats == nil and v1060.lengthInSteps then
            v1060.sectionBeats = tonumber(v1060.lengthInSteps) / 4;
            v1060.lengthInSteps = nil;
        end;

        if v1060.sectionBeats then
            v1061 = tonumber(v1060.sectionBeats) * 4;
        end;
    end;

    if u359 % v1061 == 0 then
        u362 = u362 + 1;
        local v1062 = u33.notes[u362 + 1] or {};
        local v1063 = u363 == 1 and u188.R;

        if not v1063 then
            if u363 == 0 then
                v1063 = u188.L;
            else
                v1063 = false;
            end;
        end;

        if v1063 and v1063.currentRig then
            u182.additionalZoom = -(v1063.currentRig.zoom or 0);
        end;

        u89:call("onCamSectionHit", u362, v1062);
    end;

    local math_round_ret = math.round((u36 == "L" and u157.totalHealth - u157.currentHealth or u157.currentHealth) / u157.totalHealth * 100);

    for i, v in u140 do
        local v1064 = i;

        for _, v2 in v do
            if not v2.overrideBop and v2.obj.Parent:FindFirstChild("UIScale") then
                u3.iconBops.StepHit(v2.obj.Parent, getSetting(v1064, "IconBop"), u115, {
                    Step = u359,
                    Side = v1064 == "L" and "Left" or "Right",
                    MustHit = v1064 == "L" and u363 == 0 and true or u363 == 1,
                    Conductor = u2.Conductor,
                    Sprite = v2,
                    HealthStatus = math_round_ret
                });
            end;
        end;
    end;

    u89:call("onStepHit", u359);
end;

function u86.onNextFrame(u1065) -- Line: 6548
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 6549
        -- upvalues: u1 (ref), u1065 (copy)
        u1.RunService.RenderStepped:Wait();
        u1.RunService.RenderStepped:Once(u1065);
    end);
end;

local u1066 = "ALT";

function syncIdle()
    -- upvalues: u187 (ref), u122 (ref), u121 (ref)
    for _, v in u187 do
        for _, v2 in v do
            local v1067 = (u122 == true and not u121 or u121) and "ALT" or "";

            if v2.animPrefix ~= v1067 then
                v2.animPrefix = v1067;
                v2:Dance();
            end;
        end;
    end;
end;

function u86.setAltPrefix(p1068) -- Line: 6569
    -- upvalues: u1066 (ref)
    if u1066 == p1068 then
        return;
    end;

    u1066 = p1068;
    syncIdle();
end;

function u86.flipAltAnims() -- Line: 6576
    -- upvalues: u122 (ref)
    u122 = not u122;
    syncIdle();
end;

function sectionHit(p1069)
    -- upvalues: u361 (ref), u2 (copy), u89 (copy)
    u361 = u361 + 1;
    local Conductor = u2.Conductor;
    Conductor.Measure = Conductor.Measure + 1;
    u89:call("onSectionHit", u2.Conductor.Measure);
end;

u86.SecondsToMMSS = u2.Adapters.SecondsToMMSS;

function u86.getTimeLeft() -- Line: 6589
    -- upvalues: u113 (copy), u115 (ref)
    return (u113.timeLength - u113.timePosition) / u115;
end;

function u86.getTimePast() -- Line: 6592
    -- upvalues: u113 (copy)
    local v1070 = u113.timePosition / u113.timeLength;

    return v1070 ~= v1070 and 0 or v1070;
end;

function u86.getTimeElapsed() -- Line: 6597
    -- upvalues: u113 (copy), u115 (ref)
    return u113.timePosition / u115;
end;

local u1071 = false;

function abruptGameEnd()
    -- upvalues: u1071 (ref)
    u1071 = false;
    clearUp(true);
end;

function u86.getMotionTable() -- Line: 6611
    -- upvalues: u2 (copy)
    return u2.FlxVel:GetTracked();
end;

function u86.addMotionTable(p1072: userdata, p1073: table?) -- Line: 6615
    -- upvalues: u2 (copy)
    u2.FlxVel:Add(p1072, p1073);
end;

function u86.removeMotionTable(p1074: userdata) -- Line: 6619
    -- upvalues: u2 (copy)
    u2.FlxVel:Remove(p1074);
end;

onSongEndedCalled = false;
local u1075 = nil;
local u1076 = false;

function onUpdate(p1077)
    -- upvalues: u23 (copy), u24 (copy), u2 (copy), u1076 (ref), u113 (copy), u127 (ref), Data (ref), u135 (copy), u162 (ref), u364 (ref), u187 (ref), u138 (ref), u3 (copy), u181 (ref), u115 (ref), u182 (ref), u89 (copy), u157 (ref), u764 (ref), u125 (ref), u158 (ref), u86 (copy), u366 (ref), u117 (copy), u250 (ref), u156 (ref), u357 (ref), Vector2_new (copy), u586 (ref), Game (copy), Overlay (copy), Underlay (copy), Obj (ref), u183 (ref), workspace_CurrentCamera (copy), u363 (ref), u188 (ref), u1075 (ref), CFrame_new_ret (copy)
    if not (u23.loadedSong or u24.dontStartSong) then
        return;
    end;

    if p1077 > 10 and not u2.EngineVersion.IsStudio() then
        u2.NetworkFunctions.fireServer("PlayerReset");
        abruptGameEnd();

        return;
    end;

    if not u1076 then
        u113:update();
    end;

    updateConductor(p1077);
    u1076 = false;
    local v1078 = #u127;

    if Data.SoundVisualizer then
        u135:update(p1077);
    end;

    if u162 and u162.attachedVisualizer then
        u162.attachedVisualizer:update(p1077);
    end;

    local Conductor = u2.Conductor;
    local SongPosition = Conductor.SongPosition;

    if v1078 > 1 then
        Conductor.CurrentTrackPos = getPosFromTime(SongPosition);
    end;

    checkEvents();
    checkCamEvents();
    checkNoteSpawns();
    checkBreakTimer();

    for i = 1, #Conductor.BPMChangeMap do
        local v1079 = Conductor.BPMChangeMap[1];

        if v1079.songTime > SongPosition then
            break;
        end;

        u364 = v1079;

        if v1079.beatsPerMeasure then
            Conductor.BeatsPerMeasure = v1079.beatsPerMeasure;
        end;

        if v1079.stepsPerBeat then
            Conductor.StepsPerBeat = v1079.stepsPerBeat;
        end;

        Conductor.changeBPM(v1079.bpm);
        table.remove(Conductor.BPMChangeMap, 1);
        local _ = i;

        for _, v in u187 do
            for _, v2 in v do
                syncCharToBpm(v2);
            end;
        end;

        syncCharToBpm(u162);
    end;

    local v1080 = (SongPosition - u364.songTime) / Conductor.StepCrochet;
    Conductor.DecimalStep = u364.stepTime + v1080;
    Conductor.DecimalBeat = Conductor.DecimalStep / Conductor.StepsPerBeat;
    Conductor.DecimalMeasure = Conductor.DecimalBeat / Conductor.BeatsPerMeasure;
    local Step = Conductor.Step;
    local v1081 = u364.stepTime + math.floor(v1080);

    for i = Step + 1, v1081 do
        stepHit(i);
        local _ = i;
    end;

    if u138 then
        local v1082 = u3.cameraBops[Data.CameraBop] or u3.cameraBops.Default;
        u181.zoom = v1082(u181, p1077, u181.zoomSpeed * u115);
        u182.zoom = v1082(u182, p1077, u182.zoomSpeed * u115);
    end;

    updateCam(p1077);
    u89:call("onUpdate", p1077);

    if u157.currentHealth <= u157.minHealth and (not u157.isDead and Data.DieOnHealthLoss) then
        u157.isDead = true;
        die(true);
    end;

    u157.currentHealth = math.clamp(u157.currentHealth, u157.minHealth, u157.maxHealth);
    local v1083;

    if Data.SmoothHUD then
        local currentHealth = u157.currentHealth;
        local visualHealth = u157.visualHealth;
        local math_clamp_ret = math.clamp(1 - p1077 * 9, 0, 1);
        v1083 = math.lerp(currentHealth, visualHealth, math_clamp_ret) or u157.currentHealth;
    else
        v1083 = u157.currentHealth;
    end;

    u157.visualHealth = v1083;
    updateHUD(p1077);
    updateDebugger(p1077);
    updateShake(p1077);
    local SafeZoneOffset = Conductor.SafeZoneOffset;
    local v1084 = SafeZoneOffset * 2;
    local v1085 = SafeZoneOffset / 1.3;
    local reverseNotes = u24.reverseNotes;
    local InputOffset = Data.InputOffset;
    local math_min_ret = math.min(InputOffset, 0);
    local math_sin = math.sin;
    local math_cos = math.cos;
    local math_rad = math.rad;
    local math_abs = math.abs;
    local HoldNoteScorePerSecond = u2.ratingModule.GetHoldNoteScorePerSecond();

    if HoldNoteScorePerSecond > 0 then
        for i, v in u764 do
            local v1086 = u125[i] or u158;

            if not v1086 then
                u764[i] = nil;
            end;

            if v ~= nil and (v1086 and v.maxScore ~= nil) then
                v.obtainedScore = v.obtainedScore or 0;

                if v.maxScore > v.obtainedScore then
                    local math_min_ret2 = math.min(HoldNoteScorePerSecond * p1077, v.maxScore - v.obtainedScore);
                    local v1087 = math_min_ret2 * u86.scoreMultiplier;
                    u366 = u366 + v1087;
                    local v1088 = u86;
                    v1088.fakeSustainScore = v1088.fakeSustainScore + v1087 * u86.fakeScoreMultiplier;
                    updateStatsLabel();
                    v.obtainedScore = v.obtainedScore + math_min_ret2;
                end;
            end;
        end;
    end;

    local ratingWindow = u2.ratingModule.getRatingByName("Ok").ratingWindow;

    for i = #u117, 1, -1 do
        local v1089 = u117[i];
        local v1090;

        if v1089 and (not v1089.cancelUpdate and v1089._active) then
            local strumTime = v1089.strumTime;
            local sustainNote = v1089.sustainNote;
            local strumLine = v1089.strumLine;
            local v1091 = v1089.strum or strumLine.Strums[v1089.noteData];
            local v1092 = v1089.multSpeed * (v1091.laneSpeed or 1);
            local v1093 = strumTime + v1084;

            if sustainNote then
                v1093 = v1089.susEndTime + v1084;
            end;

            if reverseNotes then
                v1093 = v1093 + u24.noteSpawnTime * v1089.spawnTimeMult / (v1078 > 1 and getSVFromTime(strumTime) or math_abs(u250 * v1092)) * 1000;
            end;

            if v1093 - math_min_ret <= SongPosition then
                v1089:Destroy(true);
                v1090 = i;
            elseif v1089.sustainNote or (v1089.missed or (v1089.hit or v1089.strumTime + SafeZoneOffset - math.min(InputOffset, 0) > SongPosition)) then
                local v1094, v1095, v1096, v1097, v1098, v1099, v1100;
                local v1094, v1095, v1096, v1097, v1090, v1098, v1099, v1100;
                local v1101 = 0;

                while true do
                    if v1101 == 0 then
                        v1101 = -1;
                        local v1102 = u125[v1089.dir] or u158;

                        if strumLine == u156 then
                            v1094 = v1089.parentNote and v1089.parentNote.wasHit and not v1089.missed;

                            if v1102 then
                                u357.releaseGraces[v1089.dir] = nil;
                            else
                                if u357.releaseGraces[v1089.dir] == nil then
                                    u357.releaseGraces[v1089.dir] = SongPosition;
                                end;

                                local v1103 = ratingWindow * (v1089.hitbox or 1);
                                local v1104 = SongPosition - u357.releaseGraces[v1089.dir];

                                if v1094 then
                                    v1094 = v1104 <= v1103;
                                end;
                            end;
                        else
                            v1094 = not v1089.missed and not v1089.hitCausesMiss;
                        end;

                        v1097 = sustainNote and strumLine.ClipSustains;

                        if v1097 then
                            if strumTime <= SongPosition then
                                v1097 = v1094;
                            else
                                v1097 = false;
                            end;
                        end;

                        v1096 = v1091.incomingAngle or 90;
                        v1095 = strumLine.Downscroll;

                        if not v1089.cancelMovement then
                            local v1105 = v1097 and 0 or u2.MathFuncs.getYPosAt(v1089.initialPos, v1092);

                            if v1095 then
                                v1105 = v1105 * -1;
                            end;

                            v1089.distance = v1105;
                            local v1106, v1107;

                            if v1096 == 90 then
                                v1106 = v1105;
                                v1107 = 0;
                            else
                                local v1108 = math_rad(v1096);
                                v1106 = v1105 * math_sin(v1108);
                                v1107 = v1105 * -math_cos(v1108);
                            end;

                            local posOffset = v1089.posOffset;
                            v1089.y = v1097 and v1091.y or v1091.y + (reverseNotes and v1106 and v1106 or -v1106) + posOffset.y;
                            local v1109 = v1097 and v1091.x;

                            if not v1109 then
                                if reverseNotes then
                                    v1107 = -v1107 or v1107;
                                end;

                                v1109 = v1091.x + v1107 + posOffset.x;
                            end;

                            v1089.x = v1109;
                        end;

                        v1089.parent = v1091.parent;

                        if v1089.shareAlpha then
                            v1089.alpha = v1091.alpha * v1089.multAlpha;
                        end;

                        if sustainNote then
                            v1101 = 2;
                            continue;
                        end;

                        v1098 = v1089.shareScale and v1091.Scale or Vector2_new(v1091.keyCountScale, v1091.keyCountScale);

                        if v1089.shareAngle then
                            v1089.angle = v1091.angle;
                            v1090 = i;
                        else
                            v1090 = i;
                        end;

                        v1101 = 1;
                        continue;
                    elseif v1101 == 1 then
                        v1101 = -1;
                        v1089.Scale = v1098;
                        v1101 = 6;
                        continue;
                    elseif v1101 == 2 then
                        v1101 = -1;

                        if v1089.missed or (strumLine ~= u156 or not v1089.parentNote.wasHit) then
                            v1090 = i;
                        else
                            local v1110 = u125[v1089.dir] or (u158 or v1094);
                            local v1111 = v1085 * v1089.hitbox;
                            local _ = v1089.prevTime or SongPosition;
                            local sustainTimes = v1089.sustainTimes;

                            if sustainTimes then
                                local totalSustains = v1089.totalSustains;
                                local currentSustainIndex = v1089.currentSustainIndex;
                                local hitSustains = v1089.hitSustains;
                                v1090 = i;

                                while true do
                                    local v1112 = sustainTimes[currentSustainIndex];

                                    if not v1112 then
                                        v1089.sustainComplete = true;
                                        currentSustainIndex = totalSustains + 1;
                                        break;
                                    end;

                                    local v1113 = v1112 + v1111 - math_min_ret;
                                    local v1114 = SongPosition - v1112 + InputOffset;
                                    local v1115 = hitSustains[currentSustainIndex];

                                    if not (v1115 or (not v1110 or math_abs(v1114) > v1111)) then
                                        hitSustains[currentSustainIndex] = true;
                                        v1115 = true;
                                    end;

                                    if v1115 then
                                        v1115 = v1114 >= 0;
                                    end;

                                    if not v1115 then
                                        if not v1115 then
                                            local v1116 = v1089.parentNote or v1089;
                                            v1116.missedDuration = (v1116.missedDuration or 0) + (SongPosition - (v1089.prevTime or SongPosition));

                                            if v1113 < SongPosition then
                                                missNote(v1089);
                                            end;
                                        end;

                                        break;
                                    end;

                                    currentSustainIndex = currentSustainIndex + 1;
                                    goodHit(v1089, v1114);
                                end;

                                v1089.currentSustainIndex = currentSustainIndex;
                            elseif v1089.hit then
                                v1090 = i;
                            else
                                local v1117 = strumTime + v1111 - math_min_ret;
                                local v1118 = SongPosition - strumTime + InputOffset;
                                local hitSustain = v1089.hitSustain;

                                if not (hitSustain or (not v1110 or math_abs(v1118) > v1111)) then
                                    v1089.hitSustain = true;
                                    hitSustain = true;
                                end;

                                if hitSustain then
                                    hitSustain = v1118 >= 0;
                                end;

                                if hitSustain then
                                    goodHit(v1089, v1118);
                                    v1089.sustainComplete = true;
                                    v1090 = i;
                                elseif hitSustain or v1117 >= SongPosition then
                                    v1090 = i;
                                else
                                    missNote(v1089);
                                    v1090 = i;
                                end;
                            end;

                            v1089.prevTime = SongPosition;
                        end;

                        local isEnd = v1089.isEnd;
                        v1099 = v1089.offsets;
                        local v1119 = v1078 > 1 and getSVFromTime(strumTime) or u250 * v1092;
                        local v1120 = v1119 < 0 and -1 or 1;

                        if v1089.sustainScrollSpeed ~= v1119 then
                            v1089.sustainScrollSpeed = v1119;
                            v1089.sustainYScale = isEnd and v1091.keyCountScale * v1120 or u2.MathFuncs.getSusLength(v1089.initialPos, v1089.susEndPos, v1092);
                            v1099.set("Scale", "sustainDownscroll", v1095 and Vector2_new(1, -1) or nil);
                        end;

                        v1098 = Vector2_new(v1089.shareScale and v1091.Scale.X or v1091.keyCountScale, v1089.sustainYScale);

                        if isEnd and (v1097 and v1089.frameSize.y ~= v1089.endPixel) then
                            v1089.endPixel = v1089.frameSize.y;
                            v1089.endPixelTime = u2.MathFuncs.getStrumFromYPos(u2.MathFuncs.getYPosAt(strumTime, 1, true) - v1089.endPixel, v1120, true);
                        end;

                        v1089.isClipping = v1097;

                        if not v1097 then
                            if v1089.percentage ~= nil then
                                v1089.percentage = nil;
                                v1099.set("Scale", "sustainReduce", nil);
                                v1099.set("rectSizeOffset", "sustainFix", nil);
                            end;

                            v1101 = 4;
                            continue;
                        end;

                        local v1121;

                        if v1089.isEnd then
                            v1121 = v1089.endPixelTime;
                        else
                            v1121 = v1089.susEndTime;
                        end;

                        local math_map_ret = math.map(SongPosition, strumTime, v1121, 1, 0);
                        v1100 = math.clamp(math_map_ret, 0, 1);

                        if v1100 ~= 0 or not (v1089.sustainComplete or v1089.missed) or reverseNotes then
                            v1101 = 3;
                            continue;
                        end;

                        v1101 = 5;
                        continue;
                    elseif v1101 == 3 then
                        v1101 = -1;
                        v1099.set("Scale", "reverseFlip", Vector2_new(1, reverseNotes and -1 or 1));

                        if reverseNotes then
                            v1100 = 1 - v1100;
                        end;

                        if v1100 ~= 1 then
                            v1089.percentage = v1100;
                            local Vector2_new_ret2 = Vector2.new(1, v1100);
                            v1099.set("Scale", "sustainReduce", Vector2_new_ret2);

                            if v1100 > 0 then
                                v1099.set("rectSizeOffset", "sustainFix", Vector2_new_ret2);
                            end;
                        end;

                        v1101 = 4;
                        continue;
                    elseif v1101 == 4 then
                        v1101 = -1;
                        local v1122 = v1096 - 90;

                        if v1122 == 0 then
                            v1099.set("angle", "incomingAngle", nil);
                            v1089.useAngleAnchor = nil;
                        else
                            v1099.set("angle", "incomingAngle", v1122);
                            v1089.useAngleAnchor = true;
                        end;

                        v1101 = 1;
                        continue;
                    elseif v1101 == 5 then
                        v1101 = -1;
                        v1089:Destroy();
                        v1101 = 6;
                        continue;
                    elseif v1101 == 6 then
                        v1101 = -1;
                        break;
                    else
                        break;
                    end;
                end;
            else
                missNote(v1089);
                v1090 = i;
            end;
        else
            v1090 = i;
        end;
    end;

    local _shakeOffset = u181._shakeOffset;
    local _shakeMultiplier = u181._shakeMultiplier;
    local v1123 = _shakeOffset.x * _shakeMultiplier.x;
    local v1124 = _shakeOffset.y * _shakeMultiplier.y;
    local v1125 = u182.x + v1123;
    local v1126 = u182.y + v1124;
    local v1127 = 0;
    local v1128 = 0;
    local v1129 = nil;
    local v1130 = nil;
    local v1131 = nil;
    local UDim2_fromScale = UDim2.fromScale;

    if u586.simulated then
        v1127 = u586.x / u586.scaleX;
        v1128 = u586.y / u586.scaleY;
        v1130 = u586.w / u586.scaleX;
        v1131 = u586.h / u586.scaleY;
        v1129 = UDim2_fromScale(v1130, v1131);
        setObjPropWithIndex(Game, "Position", UDim2_fromScale(v1130 / 2 + v1127 + v1125 / 1280 * v1130, v1131 / 2 + v1128 + v1126 / 720 * v1131), "Gameplay_Position");
        local v1132 = UDim2_fromScale(v1130 / 2 + v1127, v1131 / 2 + v1128);
        setObjPropWithIndex(Overlay, "Position", v1132, "Overlay_Position");
        setObjPropWithIndex(Underlay, "Position", v1132, "Underlay_Position");
        setObjPropWithIndex(Game, "Size", v1129, "Gameplay_Size");
        setObjPropWithIndex(Overlay, "Size", v1129, "Overlay_Size");
        setObjPropWithIndex(Underlay, "Size", v1129, "Underlay_Size");
    else
        setObjPropWithIndex(Game, "Position", UDim2_fromScale(0.5 + v1125 / 1280, 0.5 + v1126 / 720), "Gameplay_Position");
    end;

    setObjPropWithIndex(Game, "Rotation", u181.angle, "Gameplay_Angle");

    if Data.ShowHUD then
        local v1133 = u181.x + v1123;
        local v1134 = u181.y + v1124;
        setObjPropWithIndex(Obj, "Rotation", u181.angle, "HUD_Angle");

        if u586.simulated then
            setObjPropWithIndex(Obj, "Position", UDim2_fromScale(v1130 / 2 + v1127 + v1133 / 1280 * v1130, v1131 / 2 + v1128 + v1134 / 720 * v1131), "HUD_Position");
            setObjPropWithIndex(Obj, "Size", v1129, "HUD_Size");
        else
            setObjPropWithIndex(Obj, "Position", UDim2_fromScale(0.5 + v1133 / 1280, 0.5 + v1134 / 720), "HUD_Position");
        end;

        if Data.HUDZoom then
            local v1135 = (u181.zoom + u181.modchartZoom) * u181.zoomMultiplier;
            local v1136;

            if u586.simulated then
                v1136 = v1135 * (v1130 or 1);
                v1135 = v1135 * (v1131 or 1);
            else
                v1136 = v1135;
            end;

            setObjPropWithIndex(Obj, "Size", UDim2.fromScale(v1136, v1135), "HUD_Size");
        end;
    end;

    if Data.GameZoom then
        local v1137 = (u181.zoom + u181.modchartZoom) * u181.zoomMultiplier;
        local v1138;

        if u586.simulated then
            v1138 = v1137 * (v1130 or 1);
            v1137 = v1137 * (v1131 or 1);
        else
            v1138 = v1137;
        end;

        setObjPropWithIndex(Game, "Size", UDim2.fromScale(v1138, v1137), "Gameplay_Size");
    end;

    if Data.CameraZoom then
        local v1139 = u183.baseFOV / ((u182.zoom + u182.modchartZoom + (u182.baseGameZoom - 1)) * u182.zoomMultiplier) * u182.baseZoom;

        if u586.simulated then
            local ViewportSize = workspace_CurrentCamera.ViewportSize;
            local v1140 = math_rad(v1139 / 2);
            local v1141 = math.tan(v1140) * 2 * 0.7002075382097097 * 2 * 9.8;
            local v1142 = ViewportSize.X / ViewportSize.Y * v1141 / v1130;
            local v1143 = getObjProp("Gameplay_Position");
            local v1144 = workspace_CurrentCamera;
            v1144.CFrame = v1144.CFrame * CFrame.new(-v1142 * (v1143.X.Scale - 0.5), v1141 / v1131 * (v1143.Y.Scale - 0.5), 0);
            local v1145 = math_rad(v1139 / 2);
            local v1146 = math.tan(v1145) * 2 / ((v1130 + v1131) / 2) / 2;
            local math_atan_ret = math.atan(v1146);
            v1139 = math.deg(math_atan_ret) * 2;
        end;

        setObjPropWithIndex(workspace_CurrentCamera, "FieldOfView", v1139, "Cam_FOV");
    end;

    u2.FlxVel:Update(p1077);
    local v1147 = u363 == 1 and u188.R;

    if not v1147 then
        if u363 == 0 then
            v1147 = u188.L;
        else
            v1147 = false;
        end;
    end;

    if v1147 then
        u182.charZoom = v1147.zoom or 1;

        if Data.CameraFollow and u182.cameraFollow then
            local recentTrack = v1147.recentTrack;

            if recentTrack and recentTrack.Priority == Enum.AnimationPriority.Movement then
                if u1075 then
                    task.cancel(u1075);
                end;

                u1075 = task.delay(3.5 / u115, function() -- Line: 7153
                    -- upvalues: u1075 (ref), u183 (ref), CFrame_new_ret (ref)
                    u1075 = nil;
                    u183.camMovement = CFrame_new_ret;
                end);
                local v1148 = 0;
                local v1149 = 0;
                local Name = recentTrack.Name;

                if Name:match("Left") then
                    v1148 = -0.5 * Data.CameraFollowIntensity;
                elseif Name:match("Right") then
                    v1148 = 0.5 * Data.CameraFollowIntensity;
                elseif Name:match("Up") then
                    v1149 = 0.5 * Data.CameraFollowIntensity;
                elseif Name:match("Down") then
                    v1149 = -0.5 * Data.CameraFollowIntensity;
                end;

                local v1150 = Data.CameraFollowAngle and (-v1148 * 2 or 0) or 0;
                u183.camMovement = CFrame.new(v1148, v1149, 0) * CFrame.Angles(0, 0, (math.rad(v1150)));
            else
                u183.camMovement = CFrame_new_ret;
            end;
        else
            u183.camMovement = CFrame_new_ret;
        end;
    else
        u183.camMovement = CFrame_new_ret;
    end;

    if u113.timeLength - u113.timePosition <= 0.05 and not (onSongEndedCalled or u113.paused) then
        onSongEndedCalled = true;
        u89:call("onSongEnded");
    end;

    u89:call("onUpdatePost", p1077);
end;

local u1151 = nil;

function createResults(p1152)
    -- upvalues: u1151 (ref), u2 (copy), Data (ref), u35 (ref), Overlay (copy), u115 (ref), u24 (copy), u156 (ref), u371 (ref), u365 (ref), u366 (ref), u86 (copy), u368 (ref), u356 (ref), u357 (ref), u50 (copy)
    if u1151 then
        u2.Results.clearUp(u1151);
    end;

    if not Data.ShowResults then
        return;
    end;

    local v1153 = getExtraData();

    if u35.DiffFile then
        u1151 = u2.Results.create(Overlay, {
            modName = u35.ModFile.Name,
            songName = u35.SongFile.Name,
            difficulty = u35.DisplayDiffName,
            playbackRate = u115 or 1,
            modcharts = u24.useModcharts,
            specialNotes = u24.useGimmicks,
            modifiers = u24.curModifiers,
            cleared = p1152,
            keyCount = u156.KeyCount,
            topCombo = u371,
            score = u365 + math.floor(u366),
            fakeScore = u86.fakeScore + math.floor(u86.fakeSustainScore),
            accuracy = round(u368 * 100, 2),
            ma = v1153.ma,
            pa = v1153.pa,
            mean = v1153.mean,
            judgements = u356,
            hitData = u357.list,
            timings = u2.ratingModule.Data,
            favorited = table.find(u50, u35.ModFile.Name .. "/" .. u35.SongFile.Name) ~= nil
        });
    end;
end;

function clearUp(p1154)
    -- upvalues: u23 (copy), u86 (copy), u1071 (ref), u2 (copy), workspace_CurrentCamera (copy), Main (copy), u1 (copy), Music (copy), u113 (copy), u190 (ref), u358 (ref), Overlay (copy), Obj (ref), DebugLabel (copy), Game (copy), u141 (copy), u116 (copy), u117 (copy), u118 (copy), u762 (copy), u763 (copy), u730 (copy), u731 (copy), u110 (copy), u109 (copy), u764 (ref), Underlay (copy), u376 (ref), u31 (ref), u30 (ref), u187 (ref), u95 (copy), u89 (copy), u107 (ref), u956 (ref), u35 (ref), u131 (copy), u128 (copy), u132 (copy), u137 (ref), u369 (ref), u130 (copy), u285 (ref), u164 (ref), u162 (ref), LocalPlayer (copy), u526 (copy), u143 (ref), u75 (copy), u24 (copy), u1033 (ref), u3 (copy), u129 (copy), u156 (ref), u154 (copy), u125 (ref), u372 (copy), u136 (copy), u34 (ref), u33 (ref), u119 (copy), u120 (ref), u192 (copy), u670 (ref), u144 (copy), u394 (ref), u395 (ref), u396 (ref), u400 (ref), CFrame_new_ret (copy), u188 (ref), u140 (ref), u134 (ref), u32 (ref), u189 (ref), u191 (ref), u158 (ref), u101 (ref), u249 (ref), u356 (ref), u377 (ref), u364 (ref), u159 (ref), u160 (ref), u362 (ref), u359 (ref), u360 (ref), u361 (ref), u370 (ref), u371 (ref), u368 (ref), u365 (ref), u366 (ref), u367 (ref), u357 (ref), u139 (ref), u138 (ref), u108 (ref), u157 (ref), u155 (ref), u115 (ref), u114 (ref), CFrame2 (ref), u181 (ref), u182 (ref), u183 (ref), u397 (ref), u398 (ref), u399 (ref), PhoneCover (copy), u1034 (ref), u135 (copy)
    u23.inSong = false;
    u23.loadedSong = false;
    u86.inSong = false;

    if u1071 then
        showFailedLoad();

        return u2.Logger.log("Received clear request but song is still running, waiting for unload...");
    end;

    u2.Logger.log("Clearing up...");

    if p1154 then
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        Main.TopbarButtons:SetAttribute("Disabled", false);
        u1.TweenService:Create(Music, TweenInfo.new(1), {
            Volume = 0
        }):Play();
        task.delay(1, function() -- Line: 7261
            -- upvalues: u113 (ref)
            u113:unload();
        end);
    else
        u113:unload();
    end;

    u2.PlayerControls:Enable();
    u2.StageZones:reenableZones();
    clearAllButtons();
    clearWindow();
    u2.DiscordRPC.ResetTitle();
    Main.MobileTiles.Size = UDim2.fromScale(1, 1);
    u190 = false;
    u2.NetworkFunctions.remoteListen.POST_Map = nil;
    u2.NetworkFunctions.remoteListen.FAIL_Map = nil;
    u2.Topbar.highlightKey = u2.Topbar.defaultHighlightKey;
    u358 = nil;

    if Overlay:FindFirstChild("Countdown") then
        Overlay:FindFirstChild("Countdown"):Destroy();
    end;

    resetRatio();
    Obj.Visible = false;
    DebugLabel.Visible = false;
    Game.Visible = false;
    u141.Visible = false;
    local v1155 = 0;

    while #u116 > 0 do
        local v1156 = u116[1];

        if v1156 then
            v1156:Destroy(true);
        end;

        v1155 = v1155 + 1;

        if v1155 % 250 == 0 then
            task.wait();
        end;
    end;

    local v1157 = 0;

    while #u117 > 0 do
        local v1158 = u117[1];

        if v1158 then
            v1158:Destroy(true);
        end;

        v1157 = v1157 + 1;

        if v1157 % 250 == 0 then
            task.wait();
        end;
    end;

    for _, v in u118 do
        if v and v.Destroy then
            v:Destroy(true);
        end;
    end;

    for _, v in u762 do
        for _, v2 in v do
            if v2 and v2.Destroy then
                v2:Destroy(true);
            end;
        end;

        table.clear(v);
    end;

    for _, v in u763 do
        for _, v2 in v do
            if v2 ~= nil then
                for _, v3 in v2 do
                    pcall(function() -- Line: 7339
                        -- upvalues: v3 (copy)
                        v3:Disconnect();
                    end);
                end;
            end;
        end;

        table.clear(v);
    end;

    for _, v in u730 do
        table.clear(v);
    end;

    for _, v in u731 do
        table.clear(v);
    end;

    for _, v in u110 do
        if v and v.Destroy then
            v:Destroy();
        end;
    end;

    for _, v in u109 do
        if v and v.Destroy then
            v:Destroy();
        end;
    end;

    table.clear(u764);
    u764 = {};

    for _, v in {
        Obj,
        Game,
        Underlay,
        Overlay
    } do
        v.Parent = Main;
    end;

    if Underlay and Underlay:FindFirstChild("Dim") then
        Underlay.Dim.Visible = false;
    end;

    for _, v in { "L", "R" } do
        Overlay:FindFirstChild("TeamScore" .. v).Visible = false;
        Overlay:FindFirstChild("TeamScore" .. v).Label.Text = "Team Score: 0 (100.00%)";
    end;

    table.clear(u23.updateMotions);
    u376 = nil;

    if u31 then
        u31.Parent = u30;
        u31 = nil;
    end;

    for _, v in u187 do
        for _, v2 in v do
            if v2.attachedVisualizer then
                v2.attachedVisualizer:Destroy();
                v2.attachedVisualizer = nil;
            end;

            if v2.player then
                v2.charModel.Parent = nil;
            end;
        end;
    end;

    u95:call("clearUp");
    u89:call("clearUp");
    u107 = false;
    u956 = {
        L = {},
        R = {}
    };
    u2.coreCall("SetCoreGuiEnabled", Enum.CoreGuiType.Chat, true);
    u2.coreCall("SetCoreGuiEnabled", Enum.CoreGuiType.EmotesMenu, true);
    u2.LocalSignals.PlayingRound:Fire(false);
    u1.GuiService.TouchControlsEnabled = true;

    if u35 ~= nil and u35.Files then
        for _, v in u35.Files do
            if typeof(v) == "Instance" then
                pcall(function() -- Line: 7396
                    -- upvalues: v (copy)
                    v:Destroy();
                end);
            end;
        end;
    end;

    u1.RunService:UnbindFromRenderStep("_EngineUpdate");

    for _, v in u131 do
        if v then
            v:Destroy();
        end;
    end;

    table.clear(u131);

    for _, v in u128 do
        pcall(function() -- Line: 7406
            -- upvalues: v (copy)
            v:Disconnect();
        end);
    end;

    for _, v in u132 do
        pcall(task.cancel, v);
    end;

    if u137 then
        u137:Destroy();
        u137 = nil;
    end;

    u369 = {
        accuracy = 1,
        score = 0,
        notesPlayed = 0,
        notesHit = 0,
        combo = 0,
        misses = 0,
        topCombo = 0
    };
    table.clear(u130);
    u285 = nil;
    u164 = false;
    u2.MapService:Destroy(function() -- Line: 7425
        -- upvalues: u86 (ref), u162 (ref), LocalPlayer (ref), u2 (ref), u187 (ref), u1 (ref)
        u86.currentCharacter = nil;

        if u162 then
            if u162.attachedVisualizer then
                u162.attachedVisualizer:Destroy();
                u162.attachedVisualizer = nil;
            end;

            u162:Destroy();
            u162 = nil;
        end;

        u86.GFCharacter = nil;

        if LocalPlayer.Character then
            local PrimaryPart = LocalPlayer.Character.PrimaryPart;

            for _, descendant in LocalPlayer.Character:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("FaceInstance")) and (descendant ~= PrimaryPart and descendant.Name ~= "HumanoidRootPart") then
                    descendant.Transparency = 0;
                elseif descendant:IsA("LayerCollector") or (descendant:IsA("Beam") or descendant:IsA("ParticleEmitter")) then
                    descendant.Enabled = true;
                end;
            end;

            if LocalPlayer.Character:FindFirstChild("Overhead") then
                LocalPlayer.Character.Overhead.Enabled = true;
            end;

            if PrimaryPart then
                PrimaryPart.Anchored = false;
            end;
        end;

        if u2.CharReplicator.ReplicationEnabled then
            u2.CharReplicator:UnlinkAll();
            u2.CharReplicator:SetSettings({
                loadCharacters = true,
                loadExtCharacters = true,
                loadStageCharacters = true
            });
        end;

        for _, v in u187 do
            for _, v2 in v do
                local v1159;

                if v2.plrChar and u1.Players:GetPlayerFromCharacter(v2.plrChar) then
                    local PrimaryPart = v2.plrChar.PrimaryPart;
                    v1159 = v2;

                    for _, descendant in v2.plrChar:GetDescendants() do
                        if (descendant:IsA("BasePart") or descendant:IsA("FaceInstance")) and (descendant ~= PrimaryPart and descendant.Name ~= "HumanoidRootPart") then
                            descendant.Transparency = 0;
                        elseif descendant:IsA("LayerCollector") or (descendant:IsA("Beam") or descendant:IsA("ParticleEmitter")) then
                            descendant.Enabled = true;
                        end;
                    end;

                    if v1159.plrChar:FindFirstChild("Overhead") then
                        v1159.plrChar.Overhead.Enabled = true;
                    end;
                else
                    v1159 = v2;
                end;

                if v1159.alive then
                    v1159:Destroy();
                end;
            end;
        end;

        updateHideSpeaker();
    end);

    for _, v in u526 do
        pcall(function() -- Line: 7492
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    table.clear(u526);

    if u143 ~= nil and not u75.alreadyDead then
        u143:Destroy();
    end;

    u75.alreadyDead = false;
    u24.useModcharts = true;
    u24.useGimmicks = true;
    u86.useModcharts = true;
    u86.useGimmicks = true;
    u24.judgementScaling = 4;
    u1033 = false;
    u2.Note.clearCache();
    u2.NoteSplash.clearCache();
    u3.RatingManager.clear();
    u2.FlxVel:Clear();

    for _, v in u129 do
        u1.ContextAction:UnbindAction(v);
    end;

    u156 = nil;

    for _, v in u154 do
        v:Destroy();
    end;

    for _, v in {
        u154,
        u125,
        u372,
        u129,
        u136,
        u128,
        u132,
        u109,
        u34,
        u33,
        u35,
        u730,
        u731,
        u110,
        u117,
        u116,
        u118,
        u119,
        u120,
        u192
    } do
        table.clear(v);
    end;

    u670 = {
        noteTypes = {},
        noteSets = {},
        noteSplashes = {},
        holdSplashes = {}
    };
    clearCachedProps();
    u2.Events.clearUp();
    u144.Functions.ClearProgress(true);
    u125 = {};
    u394 = nil;
    u395 = nil;
    u396 = 0;
    u400 = CFrame_new_ret;
    u187 = {
        L = {},
        R = {}
    };
    u188 = {
        L = nil,
        R = nil
    };
    u140 = {
        L = {},
        R = {}
    };
    local v1160 = u134.Modchart and u89:getModule(u134.Modchart);

    if v1160 then
        u89:singleCall(v1160, "clearUp");
        u89:singleCall(v1160, "clearUpPost");
        u89:remove(u134.Modchart);
    end;

    u134:ClearChildren();
    u30 = nil;
    u32 = {};
    u189 = nil;
    u191 = nil;
    u158 = false;
    u101 = false;
    u249 = {
        Left = "Left",
        Down = "Down",
        Up = "Up",
        Right = "Right"
    };
    u2.NetworkFunctions.stageRemote = nil;
    u2.Cache.clearAll();
    u356 = {
        Marvelous = 0,
        Sick = 0,
        Good = 0,
        Ok = 0,
        Bad = 0,
        Miss = 0
    };
    u377 = false;
    u86.judgements = u356;
    u364 = {
        songTime = 0,
        stepTime = 0,
        bpm = 0
    };
    u24.noteSpawnTime = 1.75;
    u24.simpleSustains = true;
    u159 = false;
    u160 = false;
    u362 = 0;
    u359 = 0;
    u360 = 0;
    u361 = 0;
    u370 = 0;
    u371 = 0;
    u368 = 1;
    u365 = 0;
    u366 = 0;
    u367 = 0;
    u357 = {
        notesPlayed = 0,
        notesHit = 0,
        meanSum = 0,
        list = {},
        releaseGraces = {}
    };
    u86.scoreMultiplier = 1;
    u86.fakeScore = 0;
    u86.fakeSustainScore = 0;
    u86.fakeScoreMultiplier = 1;
    u139 = true;
    u138 = false;
    u24.skipCountdown = false;
    u24.dontStartSong = false;
    u24.skipNowPlaying = false;
    u108 = false;
    u157 = {
        currentHealth = 1,
        visualHealth = 1,
        gainMult = 1,
        lossMult = 1,
        minHealth = 0,
        maxHealth = 2,
        totalHealth = 2,
        flipHealthbar = false,
        allowHealthDrain = false,
        forceHealthDrain = false,
        isDead = false,
        winHealth = 0.8,
        overwinHealth = 0.95,
        loseHealth = 0.2,
        overloseHealth = 0.05
    };
    u86.healthStats = u157;
    u155 = 0;
    u115 = 1;
    u114 = nil;
    u2.Conductor.StepsPerBeat = 4;
    u2.Conductor.BeatsPerMeasure = 4;
    u2.Conductor.SafeZoneOffset = 166;
    CFrame2 = CFrame_new_ret;
    u181 = {
        x = 0,
        y = 0,
        angle = 0,
        zoom = 1,
        baseZoom = 1,
        charZoom = 1,
        defaultZoom = 1,
        additionalZoom = 0,
        modchartZoom = 0,
        zoomMultiplier = 1,
        zoomSpeed = 1,
        cameraBeat = 16,
        cameraSpeed = 1,
        cameraBeatZoom = 0.03,
        cameraBeatMultiplier = 1,
        _shakeIntensity = 0,
        _shakeDuration = 0,
        _shakeOffset = {
            x = 0,
            y = 0
        },
        _shakeMultiplier = {
            x = 1,
            y = 1
        }
    };
    u182 = {
        x = 0,
        y = 0,
        angle = 0,
        zoom = 1,
        baseZoom = 1,
        charZoom = 1,
        defaultZoom = 1,
        additionalZoom = 0,
        modchartZoom = 0,
        baseGameZoom = 1,
        zoomMultiplier = 1,
        zoomSpeed = 1,
        cameraBeat = 16,
        cameraSpeed = 1,
        cameraBeatZoom = 0.015,
        cameraBeatMultiplier = 1,
        physicalAngle = 0,
        cameraCentered = false,
        cameraFollow = true,
        instantLerp = false,
        _shakeIntensity = 0,
        _shakeDuration = 0,
        offset = {
            position = {
                x = 0,
                y = 0,
                z = 0
            },
            rotation = {
                x = 0,
                y = 0,
                z = 0
            },
            instantPos = {
                x = 0,
                y = 0,
                z = 0
            },
            instantRot = {
                x = 0,
                y = 0,
                z = 0
            }
        },
        _shakeOffset = {
            x = 0,
            y = 0
        },
        _shakeMultiplier = {
            x = 1,
            y = 1
        }
    };

    function onDeviceChange()
    end;

    u183 = {
        baseFOV = 70,
        camMovement = CFrame_new_ret
    };
    u397 = nil;
    u398 = nil;
    u399 = nil;
    Obj.UIScale.Scale = 1;
    workspace_CurrentCamera.FieldOfView = 70;
    Game.UIScale.Scale = 1;
    Game.Position = UDim2.fromScale(0.5, 0.5);
    Game.Size = UDim2.fromScale(1, 1);
    Game.Rotation = 0;
    Overlay.Position = UDim2.fromScale(0.5, 0.5);
    Underlay.Position = UDim2.fromScale(0.5, 0.5);
    Overlay.Size = UDim2.fromScale(1, 1);
    Underlay.Size = UDim2.fromScale(1, 1);
    u1.TweenService:Create(PhoneCover.Left, TweenInfo.new(1), {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(-0.25, 0)
    }):Play();
    u1.TweenService:Create(PhoneCover.Right, TweenInfo.new(1), {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(1.25, 0)
    }):Play();
    u1034 = 1;
    u89:call("clearUpPost");
    clearLua();
    u135:setSettings({});

    if u75.gameoverLoop ~= nil then
        u1.TweenService:Create(u75.gameoverLoop, TweenInfo.new(1), {
            Volume = 0
        }):Play();
        task.delay(1, function() -- Line: 7725
            -- upvalues: u75 (ref)
            u75.gameoverLoop:Destroy();
        end);
    end;

    onSongEndedCalled = false;
    u2.sprite:clearXmlCache();
    u2.Strum:releaseCache();

    for _, child in u1.Lighting:GetChildren() do
        if child:IsA("HumanoidDescription") then
            child:Destroy();
        end;
    end;

    leaveLoadingState();
end;

getRandomFriend = u2.AppearanceManager.getRandomFriend;
u86.getRandomFriend = getRandomFriend;

function getPosFromStage(p1161: any, p1162: any, p1163: number?)
    -- upvalues: CFrame_new_ret (copy)
    if p1161 == nil then
        return nil;
    end;

    local v1164 = p1163 == nil and 1 or p1163;
    local v1165 = p1161:FindFirstChild(p1162 == "L" and "Dad" .. v1164 + 1 or "BF" .. v1164 + 1);
    local v1166;

    if v1165 then
        v1166 = v1165.CFrame;
    else
        v1166 = v1165;
    end;

    local v1167 = CFrame_new_ret;

    if not v1165 then
        local v1168 = p1161:FindFirstChild(p1162 == "L" and "Dad" or "BF");

        if v1168 then
            v1167 = CFrame.new((p1162 == "L" and 1 or -1) * 1.5 * v1164, 0, 2.75 * v1164);
            v1166 = v1168.CFrame * v1167;
        end;
    end;

    return v1166, v1167:Inverse();
end;

getBotAppearance = u2.AppearanceManager.getDescription;
u86.getBotAppearance = getBotAppearance;

function spawnBot(p1169: any, p1170: any, p1171: number?, p1172: boolean?, p1173: number?, p1174: any, p1175, p1176: userdata?)
    -- upvalues: u187 (ref), u956 (ref), Modules (copy), u2 (copy), u189 (ref), u30 (ref), CFrame_new_ret (copy), Data (ref), u23 (copy), u128 (copy), u376 (ref), u89 (copy)
    local v1177 = p1171 or 0;
    local v1178 = u187[p1170][v1177];
    u956[p1170][p1171] = true;

    if v1178 ~= nil then
        return v1178;
    end;

    local u1179 = Modules.Other.Botplay.Dummy:Clone();
    u1179.Parent = u2.CharacterModule:GetRigStorage();
    local v1180 = getSetting(p1170, "ExtraBotIDs");
    local v1181 = getSetting(p1170, "ExtraBotTypes");
    local v1182 = tostring(p1171);
    local v1183;

    if v1180 == nil or (v1181 == nil or (v1180[v1182] == nil or v1181[v1182] == nil)) then
        v1183 = nil;
    else
        u2.Logger.log("Outfit ID is valid for bot " .. p1170 .. "/" .. v1182 .. "!");

        if v1180[v1182] == "" or (tostring(v1180[v1182]):gsub(" ", "") == "0" or v1180[v1182] == 0) then
            v1183 = nil;
        else
            v1183 = getBotAppearance(v1180[v1182], v1181[v1182]) or nil;
        end;
    end;

    local v1184, v1185;

    if u189 and u189.instance then
        local l_getPosFromStage = getPosFromStage;
        local Stage = u2.MapService:GetBackgroundFolder():FindFirstChild("Stage");
        local v1186;

        if p1173 == nil or not p1173 then
            v1186 = v1177;
        else
            v1186 = p1173;
        end;

        v1184, v1185 = l_getPosFromStage(Stage, p1170, v1186);
    else
        v1184 = nil;
        v1185 = nil;
    end;

    if not v1184 and u30 then
        local l_getPosFromStage = getPosFromStage;
        local Spots = u30:FindFirstChild("Spots");

        if p1173 == nil or not p1173 then
            p1173 = v1177;
        end;

        v1184, v1185 = l_getPosFromStage(Spots, p1170, p1173);
    end;

    if not v1184 then
        v1184 = CFrame_new_ret;
        v1185 = CFrame_new_ret;
    end;

    if typeof(p1174) == "number" and p1174 ~= 0 then
        p1174 = getBotAppearance(p1174, "User ID");
    elseif v1183 ~= nil then
        p1174 = v1183;
    end;

    local v1187 = p1174 or getBotAppearance(getRandomFriend(), "User ID");
    local new = u2.CharacterModule.new;
    local v1188 = {
        charModel = u1179,
        side = p1170,
        position = v1184
    };

    if p1175 == nil or not p1175 then
        p1175 = CFrame.Angles(0, 0, 0);
    end;

    v1188.offset = p1175;
    v1188.anim = p1169 ~= "None" and (p1169 or "BF") or nil;
    v1188.description = v1187;
    v1188.locked = Data.HideCharacters;
    local u1189 = new(v1188);
    u1189.destroyChar = true;
    u1189.currentID = v1177;
    u1189.camOffset = v1185;
    u187[p1170][v1177] = u1189;

    if p1172 and Data.ShowBotplayTags then
        local u1190 = Modules.Other.Botplay.Display:Clone();
        u1190.Enabled = true;
        u1190.Parent = u1179;
        u1189.botTagThread = task.spawn(function() -- Line: 7855
            -- upvalues: u23 (ref), u1189 (copy), u1190 (copy)
            local v1191 = nil;

            while u23.inSong and u1189.alive do
                task.wait();
                local ActiveCharacter = u1189:GetActiveCharacter();

                if ActiveCharacter == v1191 then
                    ActiveCharacter = v1191;
                else
                    u1190.Adornee = ActiveCharacter:FindFirstChild("Head") or ActiveCharacter;
                end;

                v1191 = ActiveCharacter;
            end;
        end);
    end;

    if Data.HideCharacters then
        local PropertyChangedSignal2 = u1179:GetPropertyChangedSignal("Parent");
        table.insert(u128, PropertyChangedSignal2:Connect(function() -- Line: 7871
            -- upvalues: u1179 (copy), u2 (ref)
            if u1179 then
                u1179.Parent = u2.CharacterModule:GetRigStorage();
            end;
        end));
    else
        u1179.Parent = p1176 or workspace;
    end;

    if u376 then
        u376({
            [p1170] = {
                [v1177] = u1189
            }
        });
    end;

    u89:call("onBotSpawn", u1189);

    return u1189;
end;

function setKeybinds(p1192, p1193)
    -- upvalues: u126 (ref), u86 (copy), Miscellaneous (ref), u125 (ref), u129 (copy), u1 (copy), u23 (copy), u202 (ref), u203 (ref)
    u126 = p1192 or u126;
    u86.Keybinds = u126;
    Miscellaneous = p1193 or Miscellaneous;
    local Sink = Enum.ContextActionResult.Sink;

    for i, _ in u125 do
        u125[i] = nil;
    end;

    for i = #u129, 1, -1 do
        local v1194 = u129[i];
        local v1195;

        if v1194 and v1194:match("Afternight_Input_") then
            table.remove(u129, i);
            u1.ContextAction:UnbindAction(v1194);
            v1195 = i;
        else
            v1195 = i;
        end;
    end;

    for i, v in u126 do
        local v1196 = {};
        local u1197;

        if type(v) == "table" then
            u1197 = i;

            for _, v2 in v do
                v1196[#v1196 + 1] = Enum.KeyCode:FromName(v2) or Enum.UserInputType:FromName(v2);
            end;
        else
            v1196[1] = Enum.KeyCode:FromName(v) or Enum.UserInputType:FromName(v);
            u1197 = i;
        end;

        for i2, v2 in v1196 do
            if v2 == Enum.KeyCode.ButtonR2 then
                v1196[i2] = Enum.UserInputType.MouseButton1;
            end;
        end;

        if next(v1196) then
            local function handler(p1198: string, p1199: any, p1200: any) -- Line: 7926
                -- upvalues: u23 (ref), u202 (ref), u1197 (copy), u203 (ref), Sink (copy)
                if u23.inSong then
                    if p1199 == Enum.UserInputState.Begin then
                        u202(u1197);
                    else
                        u203(u1197);
                    end;

                    return Sink;
                end;
            end;

            local v1201 = "Afternight_Input_" .. u1197;
            u1.ContextAction:BindActionAtPriority(v1201, handler, false, 9999, unpack(v1196));
            table.insert(u129, v1201);
        end;
    end;

    for _, v in Miscellaneous do
        local v1202 = {};

        if type(v) == "table" then
            for _, v2 in v do
                v1202[#v1202 + 1] = Enum.KeyCode:FromName(v2) or Enum.UserInputType:FromName(v2);
            end;
        else
            v1202[1] = Enum.KeyCode:FromName(v) or Enum.UserInputType:FromName(v);
        end;

        next(v1202);
    end;
end;

u86.changeKeybinds = setKeybinds;
u86.spawnBot = spawnBot;

function u86.killBot(p1203: any, p1204: number) -- Line: 7960
    -- upvalues: u956 (ref), u187 (ref)
    if not u956[p1203] or u956[p1203][p1204] == nil then
        return;
    end;

    local v1205 = u187[p1203][p1204];

    if v1205 == nil then
        return;
    end;

    u956[p1203][p1204] = nil;
    u187[p1203][p1204] = nil;

    if v1205.botTagThread then
        task.cancel(v1205.botTagThread);
        v1205.botTagThread = nil;
    end;

    v1205:Destroy();
end;

function doMiddlescroll(p1206)
    -- upvalues: u109 (copy), u2 (copy), u111 (ref), Data (ref), DataManager (copy), u112 (ref)
    for _, v in u109 do
        v:recalculateStrums();
        u2.MathFuncs.setStrumGroupToPoint(v == u111 and 640 or 10000, v.Strums, true);
    end;

    Data.DisableOpponentStrums = DataManager:GetData().DisableOpponentStrums or not p1206;

    if not p1206 then
        for _, v in u112.Strums do
            v.visible = false;
        end;

        return;
    end;

    u2.MathFuncs.setStrumGroupToPoint(640, u112.Strums);
    local KeyCount = u112.KeyCount;

    if KeyCount % 2 == 0 then
        for _, v in u112.Strums do
            if v.lane <= math.floor(KeyCount / 2) - 1 then
                v.x = v.x - 320;
            else
                v.x = v.x + 320;
            end;

            v.alpha = 0.25;
            v.defaultX = v.x;
            _G[`defaultStrum{v.strumIndex}X`] = v.x;
        end;

        return;
    end;

    for _, v in u112.Strums do
        if v.lane <= math.floor(KeyCount / 2) - 1 then
            v.x = v.x - 320;
        elseif v.lane == math.ceil(KeyCount / 2) - 1 then
            v.x = v.x + 10000;
            v.visible = false;
        else
            v.x = v.x + 320;
        end;

        v.alpha = 0.25;
        v.defaultX = v.x;
        _G[`defaultStrum{v.strumIndex}X`] = v.x;
    end;
end;

function u86.recalculateStrums(p1207: boolean?) -- Line: 8024
    -- upvalues: u109 (copy)
    for _, v in u109 do
        v:recalculateStrums(p1207);
    end;
end;

u86.doMiddlescroll = doMiddlescroll;

function u86.reapplyStrumlines() -- Line: 8032
    -- upvalues: u109 (copy), Data (ref), DataManager (copy), u124 (ref)
    for _, v in u109 do
        v:recalculateStrums();
    end;

    Data.DisableOpponentStrums = DataManager:GetData().DisableOpponentStrums;

    if Data.Middlescroll and u124.chartPlayers == 2 then
        doMiddlescroll(Data.ShowOpponentOnMiddlescroll);
    end;
end;

function toggleAutoplay()
    -- upvalues: u158 (ref), u141 (copy), Data (ref), u2 (copy), u89 (copy)
    u158 = not u158;
    local v1208;

    if u158 == true then
        v1208 = Data.ShowBotplay or false;
    else
        v1208 = false;
    end;

    u141.Visible = v1208;

    if u158 then
        u2.SoundPlayer.PlayTrackedSound("rbxassetid://16891680772", 0.7, 1);
    else
        u2.SoundPlayer.PlayTrackedSound("rbxassetid://16891681008", 0.7, 1);
    end;

    u89:call("onBotplayToggle", u158);
end;

function loadSong(u1209: any, p1210: string?, p1211: number?, p1212: any, p1213: table?, p1214: number?, p1215: table?, p1216: userdata?, p1217: table?)
    -- upvalues: u1071 (ref), _Gameplay (copy), u2 (copy), u1 (copy), u23 (copy), u86 (copy), u34 (ref), u33 (ref), u36 (ref), u114 (ref), Data (ref), DataManager (copy), u157 (ref), u30 (ref), u77 (ref), u76 (ref), u24 (copy), u52 (copy), u32 (ref), u155 (ref), u115 (ref), LocalPlayer (copy), u4 (ref), PhoneCover (copy), FullScreenSize (copy), workspace_CurrentCamera (copy), Main (copy), Assets (copy), u131 (copy), Asset (ref), u35 (ref), u252 (ref), u253 (ref), u95 (copy), u134 (ref), Game (copy), u89 (copy), Modules (copy), u250 (ref), u251 (ref), u109 (copy), u156 (ref), Sounds (copy), Underlay (copy), u137 (ref), Obj (ref), u124 (ref), RatingsContainer (copy), Overlay (copy), u373 (copy), u128 (copy), u135 (copy), CFrame2 (ref), TimeBar (ref), u113 (copy), u187 (ref), u143 (ref), u73 (copy), Music (copy), PlayerGui (copy), CFrame_new_ret (copy), u366 (ref), u367 (ref), u101 (ref), u158 (ref), u161 (ref), u162 (ref), u188 (ref), u163 (ref), u288 (ref), u285 (ref), u182 (ref), u183 (ref), u189 (ref), u190 (ref), __Background (copy), u956 (ref), u376 (ref), u192 (copy), Miscellaneous (ref), u122 (ref), u121 (ref), u107 (ref), u141 (copy), u31 (ref)
    u1071 = true;
    setLoadingText(_Gameplay.Get("Gameplay.Loading.ChartLoading"));

    if not u1209.Chart then
        u1071 = false;

        return u2.Logger.warn("No song file was passed!");
    end;

    local success2, result = pcall(function() -- Line: 8068
        -- upvalues: u1 (ref), u1209 (copy)
        return u1.HttpService:JSONDecode(require(u1209.Chart));
    end);

    if not success2 then
        u1071 = false;

        return u2.Logger.warn("Chart is not valid!");
    end;

    u1209.rawChart = u1209.Chart;
    u1209.Chart = Instance.new("Folder");
    u1209.Chart.Name = u1209.rawChart.Name;

    for _, child in u1209.rawChart:GetChildren() do
        child.Parent = u1209.Chart;
    end;

    u1209.Chart.Parent = u1209.rawChart.Parent;
    u1209.rawChart.Parent = nil;
    u23.inSong = true;
    u86.inSong = true;
    u34 = u2.ChartFixing.fixChart(result, u1209.Chart.Name);
    u33 = u34.song;
    u36 = p1210 or "R";
    local v1218 = u36 == "L" and "R" or "L";
    u86.Side = u36;
    clearLua();
    u114 = nil;
    Data = table.clone(DataManager:GetData());
    Data.InputSystem = "Afternight";
    u157.globalGainMult = Data.HealthGainMultiplier;
    u157.globalLossMult = Data.HealthLossMultiplier;
    u30 = p1212 or nil;
    u77 = u30 and u30:GetAttribute("Singleplayer") or false;
    u2.NetworkFunctions.stageRemote = u30 and u30:FindFirstChild("Hits") or nil;
    u76 = u77 or Data.FakeOpponentInput;
    u24.useModcharts = u1209.ModchartsEnabled;
    u24.useGimmicks = u1209.GimmicksEnabled;
    u86.useModcharts = u24.useModcharts;
    u86.useGimmicks = u24.useGimmicks;

    if u77 then
        u24.judgementScaling = u52.judgement or 4;
        u2.ratingModule.recalculateWindows("J" .. u24.judgementScaling);
    end;

    if u30 then
        u32 = {};

        for _, child in u30.Cameras:GetChildren() do
            u32[child.Name] = child;
        end;
    end;

    u2.Cache.clearAll();
    local v1219 = tonumber(p1214) or 0;
    u155 = v1219;
    local u1220 = p1215 or {};
    u86.players = u1220;
    u86.isSingleplayer = u77;

    if Data.MultiplayerDrain or u77 then
        u157.allowHealthDrain = true;
    end;

    u115 = tonumber(p1211) or 1;
    u115 = round(u115, 2);
    local u1221 = {
        L = {},
        R = {}
    };

    local function setPlayerSideData(p1222, p1223, p1224) -- Line: 8150
        -- upvalues: u1221 (copy)
        u1221[p1222][p1223] = {
            IsBot = false,
            Player = p1224
        };
    end;

    for _, v in { "L", "R" } do
        local v1225 = v;

        for i, _ in p1213[v] do
            local v1226 = u1220[v1225][i + 1] or u1220[v1225][tostring(i + 1)];
            u1221[v1225][i] = {
                IsBot = false,
                Player = v1226
            };
        end;
    end;

    u1221[u36][v1219] = {
        IsBot = false,
        Player = LocalPlayer
    };

    if u77 then
        local v1227 = nil;
        local v1228 = nil;

        if Data.ShowBotCustomIcon then
            local v1229 = Data.CustomIconSets[tonumber(Data.OpponentCustomIcon or -1)];

            if v1229 then
                v1228 = u2.IconsV2:parseFromDatastore(v1229);
            end;
        end;

        local v1230;

        if v1228 then
            v1228 = table.clone(v1228);
            v1230 = v1228;
        else
            v1230 = Data.OpponentIcon;
            v1227 = Data.OpponentIconPack;
        end;

        if v1228 then
            v1230 = table.clone(v1228);
        end;

        u1221[v1218][1] = {
            IsBot = true,
            Banner = Data.OpponentBanner,
            BannerPack = Data.OpponentBannerPack,
            HealthIcon = v1230,
            HealthIconPack = v1227
        };
    end;

    if u2.DiscordRPC.WindowSettings and next(u2.DiscordRPC.WindowSettings) then
        Data.BloxstrapData.AllowWindowMove = u2.DiscordRPC.WindowSettings.Control and Data.BloxstrapData.AllowWindowMove;
        Data.BloxstrapData.AllowWindowTitle = u2.DiscordRPC.WindowSettings.Title and Data.BloxstrapData.AllowWindowTitle;
        Data.BloxstrapData.AllowWindowTransparency = u2.DiscordRPC.WindowSettings.Transparency and Data.BloxstrapData.AllowWindowTransparency;
    end;

    u2.RBXOptis();
    u2.PlayerControls:Disable();
    u2.StageZones:disableZones();
    u86.Settings = Data;
    u4 = p1213[v1218][v1219] or (p1213[v1218][tostring(v1219)] or table.clone(Data));
    u86.OpponentSettings = u4;

    if Data.UseNotchCovers then
        u1.TweenService:Create(PhoneCover.Left, TweenInfo.new(1), {
            BackgroundTransparency = 0,
            Position = UDim2.fromScale(0, 0)
        }):Play();
        u1.TweenService:Create(PhoneCover.Right, TweenInfo.new(1), {
            BackgroundTransparency = 0,
            Position = UDim2.fromScale(1, 0)
        }):Play();
    end;

    if Data.TilesWithNotch and not Data.UseNotchCovers then
        local function _() -- Line: 8219
            -- upvalues: FullScreenSize (ref)
            return FullScreenSize.AbsoluteSize;
        end;

        Main.MobileTiles.Size = UDim2.new(1, (FullScreenSize.AbsoluteSize - workspace_CurrentCamera.ViewportSize).X, 1, 0);
    end;

    if Data.LiveSenpaiReaction then
        local v1231 = Assets.Templates.LiveSenpaiReaction:Clone();
        v1231.Parent = Main;
        table.insert(u131, v1231);
    end;

    Asset = u2.AssetReplicator.getAsset("Ratings", Data.JudgementStyle);

    if Asset == nil then
        Asset = u2.AssetReplicator.getAsset("Ratings", "Afternight");
    end;

    u35 = {
        MetaFile = nil,
        DataPath = nil,
        Metadata = nil,
        SongInfo = nil,
        SoundInfo = nil,
        Files = u1209,
        Difficulty = u1209.Chart.Name,
        SongName = u1209.Song:GetAttribute("DisplayName") or u1209.Song.Name,
        ModName = u1209.Mod.Name,
        DisplayDiffName = _Gameplay.GetOr("Difficulties_" .. u1209.Chart.Name, u1209.Chart.Name),
        DiffFile = u1209.Chart,
        SongFile = u1209.Song,
        ModFile = u1209.Mod
    };
    enterLoadingState({
        IsSolo = u77,
        Difficulty = u35.DisplayDiffName,
        Song = u1209.Song.Name,
        Mod = u1209.Mod.Name,
        Rate = u115,
        Sides = u1221,
        PlayerAmmo = {
            L = #u1220.L,
            R = #u1220.R
        }
    });
    local v1232 = u35.ModFile:FindFirstChild("Metadata") and require(u35.ModFile.Metadata) or nil;
    u35.MetaFile = v1232;
    u35.DataPath = u2.songIds[u35.ModFile.Name];
    u35.SongInfo = u35.DataPath.Songs[u35.SongFile.Name .. "-" .. u35.Difficulty] or (u35.DataPath.Songs[u35.SongFile.Name] or {});
    u35.SoundInfo = u35.SongInfo.Audio;
    u35.Metadata = u35.DataPath.Metadata or {};
    u86.song = u33;
    u86.rawSong = u34;
    u86.songData = u35;
    u252 = u35.SongInfo.Countdown or (u35.Metadata.Countdown or "Friday Night Funkin\'");
    u253 = u35.SongInfo.CountdownSpeed or (u35.Metadata.CountdownSpeed or 1);

    if u35.Metadata.SkipCountdown then
        u24.skipCountdown = u35.Metadata.SkipCountdown;
    end;

    if u35.SongInfo.SkipCountdown ~= nil then
        u24.skipCountdown = u35.SongInfo.SkipCountdown;
    end;

    local u1233 = {};

    if u35.DiffFile:FindFirstChild("Events") then
        local success3, _ = pcall(function() -- Line: 8294
            -- upvalues: u1233 (ref), u1 (ref), u35 (ref)
            u1233 = u1.HttpService:JSONDecode(require(u35.DiffFile.Events));
        end);

        if not success3 then
            u2.Logger.warn("Events are not valid!");
        end;
    elseif u35.SongFile:FindFirstChild("Events") then
        local success3, _ = pcall(function() -- Line: 8301
            -- upvalues: u1233 (ref), u1 (ref), u35 (ref)
            u1233 = u1.HttpService:JSONDecode(require(u35.SongFile.Events));
        end);

        if not success3 then
            u2.Logger.warn("Events are not valid!");
        end;
    end;

    setLoadingText(_Gameplay.Get("Gameplay.Loading.ModchartLoading"));
    local v1234 = u35.DiffFile:FindFirstChild("Subtitles") or (u35.SongFile:FindFirstChild("Subtitles") or nil);
    local v1235, v1236;

    if v1234 then
        v1235 = require(v1234);
        v1236 = v1234:GetAttribute("Type") or "SRT";
    else
        v1236 = "";
        v1235 = "";
    end;

    u95:add(u35.ModFile:FindFirstChild("NoteGroup"), true);
    u95:add(u35.SongFile:FindFirstChild("NoteGroup"), true);
    u95:add(u35.DiffFile:FindFirstChild("NoteGroup"), true);
    u134.Settings = Data;
    switchHUD(u35.SongInfo.HUD or (u35.Metadata.HUD or "Default"));
    u134:SetVisibility(false);
    Game.Visible = false;
    Game.ZIndex = Data.HUDOverNotes and 1 or 2;
    u89:add(u35.ModFile:FindFirstChild("ForcedModchart"), true);
    u89:add(u35.SongFile:FindFirstChild("ForcedModchart"), true);
    u89:add(u35.DiffFile:FindFirstChild("ForcedModchart"), true);

    if u24.useModcharts then
        u89:add(u35.ModFile:FindFirstChild("Modchart"), true);
        u89:add(u35.SongFile:FindFirstChild("Modchart"), true);
        u89:add(u35.DiffFile:FindFirstChild("Modchart"), true);
    end;

    local v1237 = p1217 or (u52.modifiers or {});
    u24.curModifiers = v1237;

    if v1237 then
        for _, v in v1237 do
            u89:add(Modules.Engine.VSRG.GameplayModifiers[v]);
        end;
    end;

    if Data.UseOttoBotplay and u2.PlayerRanks.isDev then
        u89:add(Modules.UI.Otto);
    end;

    if Data.ScagJPT then
        u89:add(Modules.Other.ScagJPT);
    end;

    if u2.PlayerRanks:isDev() then
        if Modules.Engine.VSRG.GameplayModifiers.Funnies:FindFirstChild(Data.FunnyMode) then
            u89:add(Modules.Engine.VSRG.GameplayModifiers.Funnies[Data.FunnyMode]);
        end;

        if Data.FunnyDebugMode then
            u89:add(Modules.Other.DebugMode);
        end;
    end;

    u250 = Data.ForceScrollSpeed and Data.ScrollSpeed or (u33.speed or 2.9) * Data.ScrollSpeed;
    u250 = u250 / u115;
    u251 = u250 * 0.45;
    setLoadingText(_Gameplay.Get("Gameplay.Loading.ChartParsing"));
    local l_parseChart = parseChart;
    local Difficulty = u35.Difficulty;
    local v1238 = {};
    local v1239;

    if typeof(v1235) == "ModuleScript" then
        v1239 = v1235:GetAttribute("Data") or nil;
    else
        v1239 = nil;
    end;

    v1238[1], v1238[2], v1238[3] = v1235, v1236, v1239;
    l_parseChart(u34, u1233, Difficulty, v1238);
    generateMobileButtons();
    changeCurrentStrumline(u109[u36 == "L" and 0 or 1]);

    function onDeviceChange()
        -- upvalues: u2 (ref), Main (ref), Data (ref), u156 (ref), DataManager (ref), u1 (ref)
        local currentDevice = u2.DeviceManager.currentDevice;
        Main.MobileTiles.Visible = currentDevice == "Mobile";
        local v1240 = currentDevice == "Console" and Data.ConsoleKeybinds or Data.Keybinds;
        local l_setKeybinds = setKeybinds;
        local v1241 = u156 and tostring(u156.KeyCount);
        l_setKeybinds(v1240[v1241] or (v1240["4"] or {}), v1240.Miscellaneous or {});
        local ControllerVibration = Data.ControllerVibration;
        local v1242 = DataManager:GetData().ControllerVibration and currentDevice == "Console";
        Data.ControllerVibration = v1242;

        if ControllerVibration and not Data.ControllerVibration then
            u1.Haptics:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0);
            u1.Haptics:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0);
        end;
    end;

    onDeviceChange();
    u2.Conductor.SafeZoneOffset = 166;

    if Data.HitSounds and Data.HitSoundID ~= 0 then
        Sounds.Hit.SoundId = `rbxassetid://{Data.HitSoundID}`;
        Sounds.Hit.Volume = Data.HitSoundVolume;
    end;

    if Data.MissSounds and Data.MissSoundID ~= 0 then
        Sounds.Miss.SoundId = `rbxassetid://{Data.MissSoundID}`;
        Sounds.Miss.Volume = Data.MissSoundVolume;
    end;

    if Data.BackgroundDim < 1 then
        if Underlay and Underlay:FindFirstChild("Dim") then
            Underlay.Dim.Visible = true;

            if Data.BackgroundImage == 0 or Data.BackgroundImage == "" then
                Underlay.Dim.Background.Visible = false;
                Underlay.Dim.BackgroundTransparency = Data.BackgroundDim;
            else
                Underlay.Dim.Background.Visible = true;
                Underlay.Dim.Background.Image = "rbxassetid://" .. Data.BackgroundImage;
                Underlay.Dim.Background.ImageTransparency = Data.BackgroundDim;
            end;
        end;

        if Data.BackgroundDim <= 0.05 then
            Data.DisableMapMidsong = true;
            Data.HideCharacters = true;
            Data.HideLobby = true;
        end;
    end;

    if Data.SplashTransparency <= 0.025 then
        Data.Notesplashes = false;
    end;

    if Data.ShowOpponentStats and (not u77 and Data.ForceHUD ~= "FunkyFriday") then
        u137 = Assets.Templates.OpponentStats:Clone();
        u137.Visible = true;
        u137.Parent = Obj;
        local v1243;

        if Data.Middlescroll then
            v1243 = Data.Downscroll and 0.175 or 0.875;
        else
            v1243 = u4.Downscroll and 0.175 or 0.875;
        end;

        u137.Position = UDim2.fromScale(Data.Middlescroll and 0.5 or (u36 == "L" and 0.75 or 0.25), v1243);
        u2.Adapters.linkTextScaling(u137.Inner.Label);
    end;

    setLoadingText(_Gameplay.Get("Gameplay.Loading.SettingsLoading"));

    if v1232 then
        local Color3_new_ret = Color3.new(1, 1, 1);
        local Color3_new_ret2 = Color3.new(1, 1, 1);

        if v1232.Colors and v1232.Colors[u35.SongFile.Name] then
            Color3_new_ret2 = v1232.Colors[u35.SongFile.Name];
        end;

        if v1232.Color then
            Color3_new_ret = v1232.Color;
        end;

        u134:SetModColor(Color3_new_ret, Color3_new_ret2);
    else
        u134:SetModColor(Color3.new(1, 1, 1), Color3.new(1, 1, 1));
    end;

    if Data.Middlescroll and u124.chartPlayers == 2 then
        doMiddlescroll(Data.ShowOpponentOnMiddlescroll);
    end;

    if u77 or not Data.ShowOpponentSettings then
        loadNotesplashes(u36, Data.Notesplash, Data.NotesplashPack);
        loadNotesplashes(u36 == "R" and "L" or "R", Data.OpponentNotesplash, Data.OpponentNotesplashPack);
        loadHoldsplashes(u36, Data.Holdsplash, Data.HoldsplashPack);
        loadHoldsplashes(u36 == "R" and "L" or "R", Data.OpponentHoldsplash, Data.OpponentHoldsplashPack);
    else
        loadNotesplashes("L", getSetting("L", "Notesplash"), getSetting("L", "NotesplashPack"));
        loadNotesplashes("R", getSetting("R", "Notesplash"), getSetting("R", "NotesplashPack"));
        loadHoldsplashes("L", getSetting("L", "Holdsplash"), getSetting("L", "HoldsplashPack"));
        loadHoldsplashes("R", getSetting("R", "Holdsplash"), getSetting("R", "HoldsplashPack"));
    end;

    if u77 or not Data.ShowOpponentSettings then
        loadNoteskin(u36, Data.Noteskin, nil, Data.NoteskinPack, Data.NoteskinOverrides, Data.NoteskinCustomization);
        loadNoteskin(u36 == "R" and "L" or "R", Data.OpponentNoteskin, nil, Data.OpponentNoteskinPack);
    else
        local l_loadNoteskin = loadNoteskin;
        local v1244 = getSetting("L", "Noteskin");
        local v1245 = getSetting("L", "NoteskinPack");
        local v1246 = getSetting("L", "NoteskinOverrides");
        local v1247;

        if u36 == "L" then
            v1247 = Data.NoteskinCustomization or nil;
        else
            v1247 = nil;
        end;

        l_loadNoteskin("L", v1244, nil, v1245, v1246, v1247);
        local l_loadNoteskin2 = loadNoteskin;
        local v1248 = getSetting("R", "Noteskin");
        local v1249 = getSetting("R", "NoteskinPack");
        local v1250 = getSetting("R", "NoteskinOverrides");
        local v1251;

        if u36 == "R" then
            v1251 = Data.NoteskinCustomization or nil;
        else
            v1251 = nil;
        end;

        l_loadNoteskin2("R", v1248, nil, v1249, v1250, v1251);
    end;

    if not u24.skipCountdown then
        for _, child in (u2.AssetReplicator.getAsset("Countdowns", u252) or Assets.Countdowns["Friday Night Funkin\'"]):GetChildren() do
            if child.ClassName ~= "Folder" then
                u2.Cache.cacheImage(child.Value);
            end;
        end;
    end;

    RatingsContainer.Parent = Data.RatingsOverNotes and Overlay or Game;

    if Data.UseWorldSpaceRatings and u30 ~= nil then
        local Attribute = u30:GetAttribute("UseRatingPosition");

        local function setupRating() -- Line: 8498
            -- upvalues: Attribute (ref), u30 (ref), u373 (ref), RatingsContainer (ref), Data (ref), Overlay (ref), Game (ref)
            local v1252 = Attribute and u30:FindFirstChild("RatingPosition") or u30.Internals:WaitForChild("Speaker");
            u373.StudsOffsetWorldSpace = Attribute and Vector3.new() or Vector3.new(-6, 0, 0);
            u373.Parent = u30;
            u373.Adornee = v1252;
            u373.Enabled = v1252 ~= nil;
            RatingsContainer.Parent = u373 or (Data.RatingsOverNotes and Overlay or Game);
        end;

        local AttributeChangedSignal = u30:GetAttributeChangedSignal("UseRatingPosition");
        table.insert(u128, AttributeChangedSignal:Connect(function() -- Line: 8511
            -- upvalues: Attribute (ref), u30 (ref), u373 (ref), RatingsContainer (ref), Data (ref), Overlay (ref), Game (ref)
            Attribute = u30:GetAttribute("UseRatingPosition");
            local v1253 = Attribute and u30:FindFirstChild("RatingPosition") or u30.Internals:WaitForChild("Speaker");
            u373.StudsOffsetWorldSpace = Attribute and Vector3.new() or Vector3.new(-6, 0, 0);
            u373.Parent = u30;
            u373.Adornee = v1253;
            u373.Enabled = v1253 ~= nil;
            RatingsContainer.Parent = u373 or (Data.RatingsOverNotes and Overlay or Game);
        end));
        local v1254 = Attribute and u30:FindFirstChild("RatingPosition") or u30.Internals:WaitForChild("Speaker");
        u373.StudsOffsetWorldSpace = Attribute and Vector3.new() or Vector3.new(-6, 0, 0);
        u373.Parent = u30;
        u373.Adornee = v1254;
        u373.Enabled = v1254 ~= nil;
        RatingsContainer.Parent = u373 or (Data.RatingsOverNotes and Overlay or Game);
    end;

    if Data.SoundVisualizer then
        local Color3_new_ret = Color3.new(1, 1, 1);
        pcall(function() -- Line: 8528
            -- upvalues: Data (ref), Color3_new_ret (ref)
            if type(Data.VisualizerColor) == "table" then
                Color3_new_ret = Color3.new(table.unpack(Data.VisualizerColor));
            end;
        end);
        u135.sizeMult = Data.VisualizerMultSize or 1;
        u135:setSettings({
            type = ({
                Bars = "GradientBars",
                ["Stereo Bars"] = "StereoGradientBars",
                Line = "Line",
                ["Stereo Line"] = "StereoLine"
            })[Data.VisualizerType] or "GradientBars",
            barCount = Data.VisualizerBarCount or 64,
            barPosition = Data.VisualizerPosition or "Down",
            barSpacing = Data.VisualizerGap / 1280 or 0.001,
            color = Color3_new_ret,
            transparency = Data.VisualizerTransparency or 0.5,
            thickness = Data.VisualizerLineThickness or 1
        });
    end;

    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    CFrame2 = workspace_CurrentCamera.CFrame;
    Obj.Song.Text = `{u35.SongName} [{u35.DisplayDiffName}] - [{u2.Adapters.floatToString(u115)}x]`;
    TimeBar.Visible = Data.ShowTimebar;

    local function getFormattedSongLength(p1255) -- Line: 8551
        -- upvalues: Data (ref), u2 (ref)
        if Data.TimeBarTextFormat == "Song Position" then
            return "(0:00)";
        end;

        if Data.TimeBarTextFormat == "Song Position / Song Length" then
            return `(0:00 / {u2.Adapters.SecondsToMMSS(p1255)})`;
        end;

        if Data.TimeBarTextFormat == "Reverse Song Position" then
            return `({u2.Adapters.SecondsToMMSS(p1255)})`;
        end;
    end;

    local v1256 = `{u35.SongName} ({u35.DisplayDiffName})`;
    local v1257 = (u114 or u113.timeLength) / u115;
    local v1258;

    if Data.TimeBarTextFormat == "Song Position" then
        v1258 = "(0:00)";
    elseif Data.TimeBarTextFormat == "Song Position / Song Length" then
        v1258 = `(0:00 / {u2.Adapters.SecondsToMMSS(v1257)})`;
    elseif Data.TimeBarTextFormat == "Reverse Song Position" then
        v1258 = `({u2.Adapters.SecondsToMMSS(v1257)})`;
    else
        v1258 = nil;
    end;

    if u115 ~= 1 then
        v1258 = v1258 .. ` ({u2.Adapters.floatToString(u115)}x)`;
    end;

    TimeBar.Song.Text = (Data.ShowSongNameInTimeBar and v1256 or "") .. v1258;
    local v1259 = u187[u36 == "L" and "R" or "L"][u155];
    local v1260 = v1259 and v1259.userId;
    u134:SetSongData(u35, math.max(u113.timeLength - u113.timePosition, 0) / u115, u115, v1260);

    if Data.ShowDeathWarning then
        u143 = Assets.DeathWarning:Clone();
        u143.Parent = Main;
    end;

    if Data.BloxstrapData.AllowDiscordRPC then
        u2.DiscordRPC.SetRichPresence({
            state = _Gameplay.Format(table.find(u73, u35.ModName) and "RPC.NowPlayingCensored" or "RPC.NowPlaying", {
                playbackRate = u115,
                songName = u35.SongName,
                diffName = u35.DisplayDiffName
            })
        });
    end;

    local v1261 = `Project: Afternight - {u35.SongName} [{u35.DisplayDiffName}]`;

    if u115 ~= 1 then
        v1261 = v1261 .. ` [{u2.Adapters.floatToString(u115)}x]`;
    end;

    setTitle(v1261);
    setLoadingText(_Gameplay.Get("Gameplay.Loading.AudioParsing"));
    local v1262 = u52.pitchSong or false;

    if u35.SongInfo.PitchSong ~= nil then
        v1262 = u35.SongInfo.PitchSong;
    end;

    u113:setPitched(v1262);
    u113:setSpeed(u115);

    if u35.SoundInfo then
        u113:load(u35.SoundInfo);
    end;

    u1.TweenService:Create(Music, TweenInfo.new(0), {
        Volume = 1
    }):Play();

    for _, v in { "rbxassetid://17663044125", "rbxassetid://17663057649", "rbxassetid://104702250406420", "rbxassetid://101121402308185", "rbxassetid://110657517950114", "rbxassetid://105916822996052" } do
        u2.Cache.cacheAsset(v);
    end;

    setLoadingText(_Gameplay.Get("Gameplay.Loading.CharacterCreating"));
    LocalPlayer.Character.Archivable = true;

    for _, descendant in LocalPlayer.Character:GetDescendants() do
        descendant.Archivable = true;
    end;

    if LocalPlayer.Character:FindFirstChild("Overhead") then
        LocalPlayer.Character.Overhead.Enabled = false;
    end;

    if not LocalPlayer.Character:GetAttribute("DescriptionReady") then
        LocalPlayer.Character:GetAttributeChangedSignal("DescriptionReady"):Wait();
        task.wait();
    end;

    if not u23.inSong then
        return abruptGameEnd();
    end;

    u1.RunService:BindToRenderStep("_EngineUpdate", Enum.RenderPriority.Input.Value + 10, onUpdate);
    local u1263 = u2.CharacterModule.cloneModel(LocalPlayer.Character);
    u1263.Parent = u2.CharacterModule:GetRigStorage();

    local function forEachPart(u1264: userdata) -- Line: 8651
        -- upvalues: u128 (ref)
        if u1264:IsA("BasePart") or u1264:IsA("FaceInstance") then
            u1264.Transparency = 1;
            local PropertyChangedSignal2 = u1264:GetPropertyChangedSignal("Transparency");
            table.insert(u128, PropertyChangedSignal2:Connect(function() -- Line: 8654
                -- upvalues: u1264 (copy)
                u1264.Transparency = 1;
            end));
        end;

        if u1264:IsA("LayerCollector") or (u1264:IsA("Beam") or u1264:IsA("ParticleEmitter")) then
            u1264.Enabled = false;
            local PropertyChangedSignal2 = u1264:GetPropertyChangedSignal("Enabled");
            table.insert(u128, PropertyChangedSignal2:Connect(function() -- Line: 8660
                -- upvalues: u1264 (copy)
                u1264.Enabled = false;
            end));
        end;
    end;

    table.insert(u128, LocalPlayer.Character.DescendantAdded:Connect(forEachPart));

    for _, descendant in LocalPlayer.Character:GetDescendants() do
        forEachPart(descendant);
    end;

    local PrimaryPart = LocalPlayer.Character.PrimaryPart;
    local PropertyChangedSignal2 = PrimaryPart:GetPropertyChangedSignal("Anchored");
    table.insert(u128, PropertyChangedSignal2:Connect(function() -- Line: 8673
        -- upvalues: u1071 (ref), PrimaryPart (copy)
        if u1071 then
            PrimaryPart.Anchored = true;
        end;
    end));
    local v1265 = u86.getAnimFolder(Data.Animation, Data.AnimationPack) or "BF";

    if Data.CustomDuoAnim then
        v1265 = PlayerGui:FindFirstChild("CustomDuoAnim") or v1265;
    end;

    local v1266 = u30 and u30.Spots:FindFirstChild(u36 == "L" and "Dad" or "BF");

    if v1266 then
        v1266 = v1266.CFrame;
    end;

    if v1266 then
        v1266 = v1266 * CFrame.new((u36 == "L" and 1 or -1) * (1.5 * v1219), 0, 2.75 * v1219);
    end;

    local u1267 = u2.CharacterModule.new({
        charModel = u1263,
        side = u36,
        position = v1266,
        anim = v1265,
        desc = u1263.Humanoid:GetAppliedDescription(),
        remote = Main:FindFirstChild("Character"),
        animAttrs = u2.AppearanceManager.getExtraDataFrom(Data, nil, "Anim")
    });
    u1267.currentID = v1219 or 0;
    u1267.destroyChar = true;
    u187[u36][v1219 or 0] = u1267;
    u89:call("onBotSpawn", u1267);
    u86.currentCharacter = u1267;

    if Data.HideCharacters then
        local PropertyChangedSignal3 = u1263:GetPropertyChangedSignal("Parent");
        table.insert(u128, PropertyChangedSignal3:Connect(function() -- Line: 8715
            -- upvalues: u1263 (copy), u2 (ref)
            if u1263 then
                u1263.Parent = u2.CharacterModule:GetRigStorage();
            end;
        end));
    else
        u1263.Parent = workspace;
    end;

    for i, v in u1220 do
        local v1268 = i;

        for i2, v2 in v do
            if v2.Character and LocalPlayer ~= v2 then
                local Character = v2.Character;
                local v1269, v1270;

                if u2.CharReplicator.ReplicationEnabled then
                    Character = u2.CharacterModule.cloneModel(v2.Character);
                    table.insert(u128, v2.Character.DescendantAdded:Connect(forEachPart));
                    v1269 = v2;
                    v1270 = i2;

                    for _, descendant in v2.Character:GetDescendants() do
                        forEachPart(descendant);
                    end;

                    Character.Parent = u2.CharacterModule:GetRigStorage();
                else
                    v1269 = v2;
                    v1270 = i2;
                end;

                local v1271 = p1213[v1268][v1270 - 1] or p1213[v1268][tostring(v1270 - 1)];
                local new = u2.CharacterModule.new;
                local v1272 = {
                    charModel = Character,
                    side = v1268
                };
                local v1273;

                if v1271 then
                    v1273 = v1271.Animation;
                else
                    v1273 = v1271;
                end;

                local v1274;

                if v1271 then
                    v1274 = v1271.AnimationPack;
                else
                    v1274 = v1271;
                end;

                v1272.anim = u86.getAnimFolder(v1273, v1274) or "BF";
                v1272.locked = not u2.CharReplicator.ReplicationEnabled;
                v1272.animAttrs = u2.AppearanceManager.getExtraDataFrom(v1271, nil, "Anim");
                local v1275 = new(v1272);
                v1275.plrChar = v1269.Character;
                v1275.isOpponent = not u76;
                v1275.destroyChar = u2.CharReplicator.ReplicationEnabled;
                v1275.currentID = v1270 - 1;
                u187[v1268][v1270 - 1] = v1275;

                if u2.CharReplicator.ReplicationEnabled and v1275.isOpponent then
                    u2.CharReplicator:LinkPlayer(v1269, v1275);
                end;

                local charModel = v1275.charModel;

                if charModel then
                    if Data.HideCharacters then
                        local PropertyChangedSignal3 = charModel:GetPropertyChangedSignal("Parent");
                        table.insert(u128, PropertyChangedSignal3:Connect(function() -- Line: 8765
                            -- upvalues: charModel (copy), u2 (ref)
                            if charModel then
                                charModel.Parent = u2.CharacterModule:GetRigStorage();
                            end;
                        end));
                    else
                        charModel.Parent = workspace;
                    end;
                end;
            end;
        end;
    end;

    local v1276 = CFrame_new_ret;
    local v1277 = u30 and u30.Spots:FindFirstChild(v1218 == "L" and "Dad" or "BF");

    if v1277 then
        v1277 = v1277.CFrame;
    end;

    if v1277 then
        v1276 = CFrame.new((v1218 == "L" and 1 or -1) * (1.5 * v1219), 0, 2.75 * v1219);
        v1277 = v1277 * v1276;
    end;

    setLoadingText(_Gameplay.Get("Gameplay.Loading.BotCreating"));
    local u1278 = Modules.Other.Botplay.Dummy:Clone();

    if u77 then
        u1278.Parent = u2.CharacterModule:GetRigStorage();
        local v1279 = Data.BotUserID ~= "" and (Data.BotUserID ~= "0" and Data.BotUserID ~= 0) and getBotAppearance(Data.BotUserID, Data.BotUserType) or getBotAppearance(getRandomFriend(), "User ID");
        u1278.Name = u1278.Name .. "_BOT";
        local v1280 = u86.getAnimFolder(Data.OpponentAnimation, Data.OpponentAnimationPack) or "BF";
        local u1281 = u2.CharacterModule.new({
            charModel = u1278,
            side = v1218,
            position = v1277,
            anim = v1280,
            description = v1279
        });
        u1281.destroyChar = true;
        u1281.camOffset = v1276;
        u1281.currentID = v1219 or 0;
        u187[v1218][v1219 or 0] = u1281;
        u89:call("onBotSpawn", u1281);

        if Data.ShowBotplayTags then
            local u1282 = Modules.Other.Botplay.Display:Clone();
            u1282.Enabled = true;
            u1282.Parent = u1278;
            local u1283 = nil;
            local u1284 = nil;
            u1284 = u1.RunService.Heartbeat:Connect(function() -- Line: 8820
                -- upvalues: u23 (ref), u1284 (ref), u1281 (ref), u1283 (ref), u1282 (copy)
                if not u23.inSong then
                    if u1284 then
                        u1284:Disconnect();
                    end;

                    return;
                end;

                local ActiveCharacter = u1281:GetActiveCharacter();

                if ActiveCharacter ~= u1283 then
                    u1283 = ActiveCharacter;
                    u1282.Adornee = ActiveCharacter:FindFirstChild("Head") or ActiveCharacter;
                end;
            end);
        end;

        if Data.HideCharacters then
            local PropertyChangedSignal3 = u1278:GetPropertyChangedSignal("Parent");
            table.insert(u128, PropertyChangedSignal3:Connect(function() -- Line: 8838
                -- upvalues: u1278 (copy), u2 (ref)
                u1278.Parent = u2.CharacterModule:GetRigStorage();
            end));
        else
            u1278.Parent = workspace;
        end;
    end;

    task.spawn(function() -- Line: 8844
        -- upvalues: u23 (ref), u366 (ref), u367 (ref), u101 (ref), u158 (ref), u2 (ref)
        while task.wait(0.2) and u23.inSong do
            local v1285 = u366 - u367;

            if v1285 > 0 then
                u367 = u366;
                local v1286 = tostring(v1285);

                if u101 then
                    v1286 = (u158 and "​" or "⁤") .. v1286;
                end;

                u2.NetworkFunctions.fireStageRemoteBatched("UpdateSustainScoring", v1286);
            end;
        end;
    end);

    if u77 == false then
        Data.AllowKicks = false;
    end;

    setLoadingText(_Gameplay.Get("Gameplay.Loading.EmoteCharCreating"));
    u161 = Modules.Other.Botplay.Dummy:Clone();
    u161.Parent = u2.CharacterModule:GetRigStorage();
    local v1287 = Data.EmoteUserID ~= "" and (Data.EmoteUserID ~= "0" and Data.EmoteUserID ~= 0) and getBotAppearance(Data.EmoteUserID, Data.EmoteUserType) or getBotAppearance(getRandomFriend(), "User ID");
    local v1288 = u161;
    v1288.Name = v1288.Name .. "_GF";
    local v1289 = u86.getEmoteFolder(Data.Emote, Data.EmotePack) or "GF";
    local v1290 = u30 and u30.Internals.GF;

    if v1290 then
        v1290 = v1290.CFrame;
    end;

    u162 = u2.CharacterModule.new({
        side = "Emote",
        charModel = u161,
        position = v1290,
        anim = v1289,
        desc = v1287,
        animAttrs = u2.AppearanceManager.getExtraDataFrom(Data, nil, "Emote")
    });
    u86.GFCharacter = u162;
    u162.destroyChar = true;
    u162.currentID = 0;
    task.spawn(function() -- Line: 8891
        -- upvalues: u162 (ref)
        local function onGFAnim() -- Line: 8892
            -- upvalues: u162 (ref)
            updateHideSpeaker();
            attachVisualizerTo(u162);
        end;

        if u162.animationData then
            updateHideSpeaker();
            attachVisualizerTo(u162);
        end;

        u162.animationLoaded:Connect(onGFAnim);
    end);

    if u161 ~= nil then
        updateHideSpeaker();

        if Data.HideCharacters then
            local PropertyChangedSignal3 = u161:GetPropertyChangedSignal("Parent");
            table.insert(u128, PropertyChangedSignal3:Connect(function() -- Line: 8908
                -- upvalues: u161 (ref)
                if not u161 then
                    return;
                end;

                updateHideSpeaker();
            end));
        end;
    end;

    u188.L = u187.L[0] or (u187.L[v1219] or nil);
    u188.R = u187.R[0] or (u187.R[v1219] or nil);

    if not u23.inSong then
        return abruptGameEnd();
    end;

    if p1216 ~= nil then
        u163 = u2.CharacterModule:GetRigStorage():FindFirstChild(p1216.Name);
        updateHideSpeaker();
    end;

    setLoadingText(_Gameplay.Get("Gameplay.Loading.MapLoading"));

    if Data.HideLobby or (u35.SongInfo and u35.SongInfo.Background or u35.Metadata and u35.Metadata.Background) and not Data.DisableMapMidsong then
        local v1291 = (u35.SongInfo or {}).Background or (u35.Metadata or {}).Background;
        u288 = u35.SongInfo.BackgroundPath or (u35.Metadata.BackgroundPath or u35.ModName);
        local u1292 = nil;
        table.insert(u128, u2.MapService.Signals.MapSwitched:Connect(function(u1293) -- Line: 8953
            -- upvalues: u32 (ref), u30 (ref), u285 (ref), u2 (ref), u187 (ref), u162 (ref), u182 (ref), u183 (ref), workspace_CurrentCamera (ref), u189 (ref), u1292 (ref), u89 (ref), Data (ref)
            u32 = {};

            for _, child in u30.Cameras:GetChildren() do
                u32[child.Name] = child;
            end;

            u285 = u1293;
            u2.MapService:Reposition(u187, u162);
            updateCam(0, true);
            updateHideSpeaker();
            u182.baseZoom = u1293.Attributes.BaseZoom or 1;
            u183.baseFOV = u1293.Attributes.BaseFOV or 70;

            if u183.baseFOV ~= 70 then
                workspace_CurrentCamera.FieldOfView = u183.baseFOV / (u182.zoom * u182.zoomMultiplier) * u182.baseZoom;
            end;

            if u182.baseZoom ~= 1 then
                u182.zoom = u182.baseZoom;
                u182.defaultZoom = u182.baseZoom;
                workspace_CurrentCamera.FieldOfView = u183.baseFOV / (u182.zoom * u182.zoomMultiplier) * u182.baseZoom;
            end;

            u189 = {
                data = u1293,
                instance = u1293.SerializedInstance
            };
            local Modchart = u1293.Modchart;

            if Modchart ~= u1292 then
                if u1292 then
                    local Module = u89:getModule(u1292);

                    if Module then
                        u89:singleCall(Module, "clearUp");
                        u89:singleCall(Module, "clearUpPost");
                        u89:remove(u1292);
                    end;

                    u1292 = nil;
                end;

                if Modchart then
                    if not u89:getModule(Modchart) then
                        u89:add(Modchart, true);
                    end;

                    u1292 = Modchart;
                end;
            end;

            pcall(function() -- Line: 9016
                -- upvalues: u1293 (copy), Data (ref)
                if u1293.SerializedInstance.Name == "CustomVoid" then
                    local Color3_new = Color3.new;
                    local v1294 = type(Data.CustomVoidColor) == "table" and (Data.CustomVoidColor or { 1, 1, 1 }) or { 1, 1, 1 };
                    local v1295 = Color3_new(table.unpack(v1294));
                    u1293.SerializedInstance.Map.ColorWall.SurfaceGui.Frame.BackgroundColor3 = v1295;
                end;
            end);
        end));

        local function postCallback(p1296, p1297) -- Line: 9025
            -- upvalues: u190 (ref), __Background (ref), u2 (ref), u30 (ref), u1220 (ref), u956 (ref)
            if u190 then
                p1296.SerializedInstance.Parent = __Background:FindFirstChild("CachedMaps");
                u2.MapService:Add(p1296);

                return;
            end;

            u190 = true;
            u2.Logger.log("Received map! Loading...");
            u2.MapService:CreateStage(p1296, u30, u1220, u956);
        end;

        u2.NetworkFunctions.listenTo("FAIL_Map", function(p1298) -- Line: 9036
            -- upvalues: u2 (ref)
            u2.MapService.Signals.MapAdded:Fire(p1298);
        end);
        u2.NetworkFunctions.listenTo("POST_Map", function(p1299) -- Line: 9041
            -- upvalues: u2 (ref), postCallback (copy)
            local v1300 = tick();

            repeat
                task.wait();
            until tick() - v1300 >= 15 or p1299.SerializedInstance ~= nil;

            if p1299.SerializedInstance == nil then
                u2.Logger.warn("Map failed to load! Please report this.");

                return;
            end;

            postCallback(p1299, p1299.SerializedInstance);
        end);

        u376 = function(p1301: table) -- Line: 9053
            -- upvalues: u2 (ref), u187 (ref), u162 (ref)
            u2.MapService:Reposition(p1301 or u187, u162);
        end;

        local v1302 = { nil, "Global", "CustomVoid" };
        u2.CharReplicator:SetSettings({
            loadExtCharacters = false,
            loadCharacters = not Data.HideCharacters,
            loadStageCharacters = not u76
        });

        if Data.DisableMapMidsong then
            if Data.HideLobby then
                u86.Map.Cache(v1302);
            end;
        elseif v1291 then
            u86.Map.Cache({ nil, u288 or u35.ModName, v1291 });
        elseif Data.HideLobby then
            u86.Map.Cache(v1302);
        end;

        if u190 and not u2.MapService:Property("CurrentMap") then
            u2.MapService.Signals.MapSwitched:Wait();
        end;

        updateHideSpeaker();
    else
        u2.MapService.Stage = u30;
        u2.CharReplicator:SetSettings({
            loadExtCharacters = true,
            loadCharacters = not Data.HideCharacters,
            loadStageCharacters = not u76
        });
        updateHideSpeaker();
    end;

    table.insert(u128, u1.UserInput.InputBegan:Connect(function(p1303, p1304) -- Line: 9094
        -- upvalues: u192 (ref), u89 (ref), Miscellaneous (ref), u1267 (copy), u122 (ref), u121 (ref), u77 (ref), u2 (ref), u107 (ref), u113 (ref), u115 (ref)
        if p1304 and p1303.KeyCode ~= Enum.KeyCode.ButtonA then
            return;
        end;

        for i, v in u192 do
            local v1305 = i;

            for _, v2 in type(v) == "string" and ({ v } or v) or v do
                if v2 == p1303.UserInputType.Name then
                    u89:call("onSpecialDown", v1305);
                elseif p1303.KeyCode.Name == v2 then
                    u89:call("onSpecialDown", v1305);
                end;
            end;
        end;

        for i, v in Miscellaneous do
            local v1306 = i;

            for _, v2 in type(v) == "string" and ({ v } or v) or v do
                if p1303.KeyCode.Name == v2 then
                    if v1306 == "TauntKeybind" then
                        if u1267 and u1267.alive then
                            u1267:PlayAsManual("Hey");
                        end;
                    elseif v1306 == "AltSwitch" then
                        u122 = not u122;

                        if u1267 and u1267.alive then
                            u1267.animPrefix = u122 == true and not u121 and "ALT" or (u121 and "ALT" or "");
                            u1267:Dance();
                        end;
                    end;
                end;
            end;
        end;

        if p1303.KeyCode == Enum.KeyCode.Seven and (u77 and u2.PlayerRanks:isDev()) then
            toggleAutoplay();
        end;

        if p1303.KeyCode == Enum.KeyCode.Return and (u2.EngineVersion.IsStudio() and (u77 and u107)) then
            u113:setPosition(u113.timePosition + u115 * 5);
            u2.NetworkFunctions.fireStageRemote("SongSkip");
        end;
    end));
    table.insert(u128, u1.UserInput.InputEnded:Connect(function(p1307, p1308) -- Line: 9148
        -- upvalues: u192 (ref), u89 (ref)
        if p1308 and p1307.KeyCode ~= Enum.KeyCode.ButtonA then
            return;
        end;

        for i, v in u192 do
            local v1309 = i;

            for _, v2 in type(v) == "string" and ({ v } or v) or v do
                if v2 == p1307.UserInputType.Name then
                    u89:call("onSpecialUp", v1309);
                elseif p1307.KeyCode.Name == v2 then
                    u89:call("onSpecialUp", v1309);
                end;
            end;
        end;
    end));
    setLoadingText(_Gameplay.Get("Gameplay.Loading.AudioCaching"));

    local function makeSureItLoads(p1310, p1311, p1312) -- Line: 9178
        -- upvalues: u1 (ref), makeSureItLoads (copy)
        local u1313 = (p1312 or -1) + 1;

        if p1311 == Enum.AssetFetchStatus.Success or u1313 > 5 then
            if p1311 ~= Enum.AssetFetchStatus.Success then
                showError("AUDIO", `Failed to load audio [{p1310}]\nRoblox failed to load the audio!! (Atleast, that's what they said)\nTry again later!!`, "", "REPORT IF IT HAPPENS MULTIPLE TIMES AND ITS JUST YOU");
            end;
        else
            u1.ContentProvider:PreloadAsync({ p1310 }, function(p1314, p1315) -- Line: 9182
                -- upvalues: makeSureItLoads (ref), u1313 (ref)
                makeSureItLoads(p1314, p1315, u1313);
            end);
        end;
    end;

    u1.ContentProvider:PreloadAsync(u113:getAudios(), makeSureItLoads);
    local v1316 = u113.timeLength <= 0 and u35.DiffFile:GetAttribute("_CachedAudio");

    if v1316 then
        u114 = v1316;
    end;

    if not (u33 and next(u35)) then
        return abruptGameEnd();
    end;

    if Data.RemoveGameRatio then
        local ViewportSize = workspace_CurrentCamera.ViewportSize;
        u86.changeGameRatio(ViewportSize.X / ViewportSize.Y);
    end;

    setLoadingText(_Gameplay.Get("Gameplay.Loading.ModchartStart"));
    u2.Events.onCreate(u2.NetworkFunctions.stageRemote, u86);
    u89:call("onCreate", u86);
    loadLua();

    if not u23.inSong then
        return abruptGameEnd();
    end;

    u2.coreCall("SetCoreGuiEnabled", Enum.CoreGuiType.EmotesMenu, false);

    if Data.DisableChatOnGameplay then
        u2.coreCall("SetCoreGuiEnabled", Enum.CoreGuiType.Chat, false);
    end;

    u2.LocalSignals.PlayingRound:Fire(true);

    if Data.AutomaticBotplay and (u2.PlayerRanks.isDev and u77) then
        u158 = true;
    end;

    if not u77 then
        u158 = false;
    end;

    if u1.UserInput.TouchEnabled then
        u1.GuiService.TouchControlsEnabled = false;
    end;

    local v1317;

    if u158 == true then
        v1317 = Data.ShowBotplay or false;
    else
        v1317 = false;
    end;

    u141.Visible = v1317;

    if Data.ShowcaseMode and u77 then
        u141.Visible = false;
        u158 = true;
        TimeBar.Visible = false;
        Data.ShowTimebar = false;
        u134:SetVisibility(false);
    end;

    if Data.ShowMatchStats then
        for i, v in u1220 do
            if #v >= 2 then
                Overlay:FindFirstChild("TeamScore" .. i).Visible = true;
            end;
        end;
    end;

    updateHUD(0);
    updateStatsLabel();
    updateOppStatsLabel();
    updateHideSpeaker();

    if not u23.inSong then
        return abruptGameEnd();
    end;

    if u30 then
        u31 = u30:FindFirstChild("Sound");

        if u31 then
            u31.Parent = nil;
        end;

        u2.NetworkFunctions.fireStageRemote("SongLoaded", v1237);
        setLoadingText(u77 and _Gameplay.Get("Gameplay.Loading.SingleplayerWaiting") or _Gameplay.Get("Gameplay.Loading.OtherPlayersWaiting"));
    end;

    u1071 = false;
end;

function getClosestNote(p1318, p1319)
    -- upvalues: u112 (ref), u111 (ref), u2 (copy), u115 (ref), Data (ref)
    local v1320 = (p1319 and u112 or u111).Lanes[p1318];

    if not v1320 then
        return;
    end;

    local v1321 = u2.Conductor.SafeZoneOffset * 1.2 * u115;
    local SongPosition = u2.Conductor.SongPosition;

    for _, v in v1320 do
        local v1322 = SongPosition - v.strumTime + Data.InputOffset;
        local math_abs_ret = math.abs(v1322);
        local v1323 = v1321 * v.hitbox;

        if not (v.hit or (v.sustainNote or (v.missed or math_abs_ret > v1323))) then
            if math_abs_ret <= v1323 / 1.2 then
                return v, nil, v1322;
            end;

            return nil, v, v1322;
        end;
    end;
end;

u86.getClosestNote = getClosestNote;

u202 = function(p1324: string) -- Line: 9309
    -- upvalues: u89 (copy), u2 (copy), u158 (ref), u159 (ref), u1076 (ref), u113 (copy), u125 (ref), u357 (ref), u108 (ref), u111 (ref), Data (ref), u86 (copy), u188 (ref), u36 (ref), Sounds (copy)
    u89:call("onKeyDown", p1324);

    if u2.Conductor.Paused then
        return;
    end;

    if u158 or u159 then
        return;
    end;

    if not u1076 then
        u113:update();
        u1076 = true;
    end;

    u125[p1324] = true;
    u357.releaseGraces[p1324] = nil;
    local v1325, v1326, v1327 = getClosestNote(p1324);

    if v1325 then
        goodHit(v1325, v1327);

        return;
    end;

    if v1326 then
        doMiss(v1326, v1326.strum or v1326.strumLine.Strums[v1326.noteData], true);
    end;

    if not u108 then
        return;
    end;

    local v1328 = u111.Strums[p1324];
    local v1329 = Data.PlayAnimationOnGhosttap and u86.currentCharacter;

    if v1329 then
        u188[u36] = v1329;
        v1329:PlayAsManual(v1328 and v1328.animDir or u2.Adapters.convertNoteAnimToBase(p1324), nil, nil, false);
    end;

    if Data.GhostTapping then
        if Data.PlayHitsoundOnGhosttap and (Data.HitSounds and Data.HitSoundID ~= 0) then
            u2.SoundLibrary:Play(Sounds.Hit.SoundId, 1);
        end;
    else
        removeHealth(0.02);
        doMiss(nil, v1328);
    end;

    if v1328 and not Data.DisableArrowPress then
        v1328:Play("pressed", true);
    end;

    u89:call("onGhostTap", p1324);
end;

u203 = function(p1330) -- Line: 9363
    -- upvalues: u89 (copy), u2 (copy), u158 (ref), u159 (ref), u125 (ref), u111 (ref)
    u89:call("onKeyUp", p1330);

    if u2.Conductor.Paused then
        return;
    end;

    if u158 or u159 then
        return;
    end;

    u125[p1330] = nil;
    local v1331 = u111.Strums[p1330];

    if v1331 == nil then
        return;
    end;

    v1331:Play("static", true);
end;

function syncCharToBpm(p1332)
    -- upvalues: Data (ref), u2 (copy), u115 (ref), u364 (ref), u1 (copy)
    if not (p1332.currentAnim and Data.SyncAnimationToBPM) then
        return;
    end;

    local sideAttributes = p1332.sideAttributes;

    if sideAttributes.NoIdleSync then
        return;
    end;

    local v1333 = tonumber(sideAttributes.IdleBeat or 1);
    local u1334 = u2.Conductor.Crochet / 500 / u115 * v1333;
    local u1335 = u364;

    for _, v in p1332:GetIdles() do
        task.spawn(function() -- Line: 9387
            -- upvalues: v (copy), u1 (ref), u1335 (copy), u364 (ref), u1334 (copy), u2 (ref)
            if v.Length == 0 then
                u1.ContentProvider:PreloadAsync({ v.Animation });
                task.wait();
            end;

            if u1335 ~= u364 then
                return;
            end;

            v:AdjustSpeed(v.Length / u1334);
            v.TimePosition = (u2.Conductor.SongPosition - u364.songTime) / 1000 % u1334 / u1334 * v.Length;
        end);
    end;
end;

function startSong()
    -- upvalues: u35 (ref), u2 (copy), u23 (copy), u187 (ref), u115 (ref), u162 (ref), u113 (copy), u114 (ref), Data (ref), _Gameplay (copy), u73 (copy), u89 (copy), u107 (ref), u77 (ref), u86 (copy)
    if not u35.SongName then
        return u2.Logger.log("No song name, canceling...");
    end;

    if not u23.inSong then
        return u2.Logger.log("Not in song, canceling...");
    end;

    for _, v in u187 do
        for _, v2 in v do
            syncCharToBpm(v2);
            v2:linkActionsToRate(u115);
            v2.animationLoaded:Connect(function() -- Line: 9415
                -- upvalues: v2 (copy), u115 (ref)
                syncCharToBpm(v2);
                v2:linkActionsToRate(u115);
            end);
        end;
    end;

    syncCharToBpm(u162);
    showNowPlaying();
    u113:Play();
    local os_time_ret = os.time();
    local v1336 = (u114 or u113.timeLength) / u115;

    if Data.BloxstrapData.AllowDiscordRPC then
        u2.DiscordRPC.SetRichPresence({
            state = _Gameplay.Format(table.find(u73, u35.ModName) and "RPC.PlayingCensored" or "RPC.Playing", {
                playbackRate = u115,
                songName = u35.SongName,
                diffName = u35.DisplayDiffName
            }),
            timeStart = os_time_ret,
            timeEnd = os_time_ret + v1336
        });
    end;

    updateConductor(0);
    u89:call("onStart");
    u107 = true;

    if u77 then
        u2.NetworkFunctions.fireStageRemote("SongStarted");
    end;

    u86.songStartTime = os_time_ret;
    checkBreakTimer();
end;

u86.startSong = startSong;
u86.calculateSectionLength = u2.TimeFunctions.calculateSectionLength;
local u1337 = 1;

local function getCountdownPath() -- Line: 9458
    -- upvalues: u2 (copy), u252 (ref), Assets (copy)
    return u2.AssetReplicator.getAsset("Countdowns", u252) or Assets.Countdowns["Friday Night Funkin\'"];
end;

local function getCountdownAssets(p1338) -- Line: 9462
    -- upvalues: u2 (copy)
    local v1339 = p1338:GetAttribute("Scale") or 1;
    local v1340 = {};
    local v1341 = {};

    for _, child in p1338:GetChildren() do
        if child.ClassName ~= "Folder" then
            v1340[child.Name] = child;
            v1341[child.Name] = child:FindFirstChild("XML") and true or nil;
            u2.Cache.cacheImage(child.Value);
        end;
    end;

    for _, child in p1338.Audio:GetChildren() do
        u2.Cache.cacheAsset(child.SoundId);
    end;

    return v1340, v1341, v1339;
end;

local function playCountdownAudio(p1342, p1343) -- Line: 9481
    -- upvalues: Music (copy), u130 (copy), Data (ref), u1 (copy)
    local v1344;

    if p1343 <= 3 then
        local math_abs_ret = math.abs(p1343 - 4);
        v1344 = tostring(math_abs_ret);
    else
        v1344 = "Go";
    end;

    local v1345 = p1342.Audio:FindFirstChild(v1344);

    if v1345 then
        local v1346 = v1345:Clone();
        v1346.Parent = Music;
        table.insert(u130, {
            Object = v1346,
            Volume = v1346.Volume
        });
        v1346.Volume = v1346.Volume * (Data.GlobalVolume / 10);
        v1346:Play();
        u1.Debris:AddItem(v1346, v1346.TimeLength <= 0 and 15 or v1346.TimeLength + 0.5);
    end;
end;

function visualCountdown()
    -- upvalues: u2 (copy), u252 (ref), Assets (copy), getCountdownAssets (copy), Overlay (copy), u24 (copy), u1337 (ref), u115 (ref), u1 (copy), playCountdownAudio (copy), u89 (copy)
    local v1347 = u2.AssetReplicator.getAsset("Countdowns", u252) or Assets.Countdowns["Friday Night Funkin\'"];
    local v1348, v1349, v1350 = getCountdownAssets(v1347);
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Countdown";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Size = UDim2.fromScale(v1350, v1350);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.ZIndex = v1347:GetAttribute("ZIndex") or 1;
    ImageLabel.Parent = Overlay;
    ImageLabel.Visible = u24.showCountdown;
    local v1351 = { "Three", "Two", "One", "Go" };
    local v1352 = { "3", "2", "1", "Go" };
    local Attribute = v1347:GetAttribute("Antialiasing");
    local v1353 = Attribute == nil and true or Attribute;

    if u1337 < 5 then
        local v1354 = v1351[u1337];
        local Value = v1348[v1354].Value;

        if v1349[v1354] then
            local v1355 = u2.sprite.new(ImageLabel, nil, true, false);
            local v1356 = v1348[v1354];
            local XML = v1356:FindFirstChild("XML");
            local v1357 = v1356:GetAttribute("Factor") or 1;
            local v1358 = v1356:GetAttribute("Scale") or v1350;
            v1355:AddSparrowXml(XML, v1354, v1352[u1337], u115 * 24, false, v1357, 1, Value);
            v1355:PlayAnimation(v1354, true);
            v1355.Antialiasing = v1353;
            v1355.Scale = Vector2.new(v1358, v1358);
            v1355.AnchorPoint = Vector2.new(0.5, 0.5);
            v1355.Position = UDim2.fromScale(0.5, 0.5);
            v1355.AnimationEnded:Connect(function() -- Line: 9535
                -- upvalues: u1 (ref), ImageLabel (copy), u2 (ref)
                u1.Debris:AddItem(ImageLabel, u2.Conductor.Crochet / 1000);
            end);
        else
            local v1359;

            if v1353 == false then
                v1359 = Enum.ResamplerMode.Pixelated;
            else
                v1359 = Enum.ResamplerMode.Default;
            end;

            ImageLabel.ResampleMode = v1359;
            ImageLabel.Image = Value;
            ImageLabel.ImageTransparency = 0;
            u1.TweenService:Create(ImageLabel, TweenInfo.new(u2.Conductor.Crochet / 1000, Enum.EasingStyle.Linear), {
                ImageTransparency = 1
            }):Play();
            u1.Debris:AddItem(ImageLabel, u2.Conductor.Crochet / 1000);
        end;

        playCountdownAudio(v1347, u1337);
    end;

    u89:call("onCountdown", u1337 - 1, ImageLabel);
    u1337 = u1337 + 1;
end;

u86.visualCountdown = visualCountdown;

function beginCountdown()
    -- upvalues: u108 (ref), u1337 (ref), u156 (ref), u24 (copy), u2 (copy), u132 (copy), u115 (ref), u252 (ref), Assets (copy), getCountdownAssets (copy), u253 (ref), Overlay (copy), u89 (copy), u187 (ref), u162 (ref), u1 (copy), playCountdownAudio (copy)
    if u108 then
        return;
    end;

    u108 = true;
    u1337 = 1;

    if u156 then
        u156:showKeybindReminders();
    end;

    if u24.skipCountdown then
        u2.Conductor.setSongPos(-u2.TimeFunctions.calculateSectionLength(0.5));
        table.insert(u132, task.delay(-u2.Conductor.RawTimePosition / u115, startSong));

        return;
    end;

    local u1360 = u2.AssetReplicator.getAsset("Countdowns", u252) or Assets.Countdowns["Friday Night Funkin\'"];
    local u1361, u1362, u1363 = getCountdownAssets(u1360);
    local Attribute = u1360:GetAttribute("Antialiasing");
    local v1364 = Attribute == nil and true or Attribute;
    u2.Conductor.setSongPos(60 / u2.Conductor.BPM / u253 * -5);
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Countdown";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.ImageContent = Content.none;
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.ZIndex = u1360:GetAttribute("ZIndex") or 1;
    ImageLabel.Visible = u24.showCountdown;
    local u1365 = nil;

    if next(u1362) then
        u1365 = u2.sprite.new(ImageLabel, nil, true, false);
        u1365.anchor = Vector2.new(0.5, 0.5);
        u1365.Position = UDim2.fromScale(0.5, 0.5);
        u1365.antialiasing = v1364;
        u1365.parent = Overlay;
    else
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        ImageLabel.Size = UDim2.fromScale(u1363, u1363);
        ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
        local v1366;

        if v1364 == false then
            v1366 = Enum.ResamplerMode.Pixelated;
        else
            v1366 = Enum.ResamplerMode.Default;
        end;

        ImageLabel.ResampleMode = v1366;
        ImageLabel.Parent = Overlay;
    end;

    local u1367 = { "3", "2", "1", "Go" };
    local u1368 = { "Three", "Two", "One", "Go" };

    for i = 1, 5 do
        table.insert(u132, task.delay(60 / u2.Conductor.BPM / u253 * i / u115, function() -- Line: 9605
            -- upvalues: u89 (ref), i (copy), ImageLabel (copy), u2 (ref), u115 (ref), u1365 (ref), u187 (ref), u1367 (copy), u162 (ref), u24 (ref), u1368 (copy), u1361 (copy), u1362 (copy), u1363 (copy), u1 (ref), playCountdownAudio (ref), u1360 (copy)
            u89:call("onCountdown", i - 1, ImageLabel);

            if i == 5 then
                task.delay(u2.Conductor.Crochet / 1000 / u115, function() -- Line: 9609
                    -- upvalues: u1365 (ref), ImageLabel (ref)
                    if u1365 then
                        pcall(function() -- Line: 9610
                            -- upvalues: u1365 (ref)
                            u1365:Destroy();
                        end);
                    end;

                    pcall(function() -- Line: 9611
                        -- upvalues: ImageLabel (ref)
                        ImageLabel:Destroy();
                    end);
                end);

                return startSong();
            end;

            for _, v in u187 do
                for _, v2 in v do
                    v2:Play(i == 1 and "Intro" or `Intro{u1367[i]}`);
                end;
            end;

            if u162 then
                u162:Play(i == 1 and "Intro" or `Intro{u1367[i]}`);
            end;

            if u24.showCountdown then
                local v1369 = u1368[i];
                local Value = u1361[v1369].Value;

                if u1362[v1369] then
                    local v1370 = u1361[v1369];
                    local XML = v1370:FindFirstChild("XML");
                    local v1371 = v1370:GetAttribute("Factor") or 1;
                    local v1372 = v1370:GetAttribute("Scale") or u1363;
                    u1365:AddSparrowXml(XML, "Idle", u1367[i], u115 * 24, false, v1371, 1, Value);
                    u1365:PlayAnimation("Idle", true);
                    u1365.Scale = Vector2.new(v1372, v1372);
                else
                    ImageLabel.Image = Value;
                    ImageLabel.ImageTransparency = 0;
                    u1.TweenService:Create(ImageLabel, TweenInfo.new(u2.Conductor.Crochet / 1000, Enum.EasingStyle.Linear), {
                        ImageTransparency = 1
                    }):Play();
                end;
            end;

            playCountdownAudio(u1360, i);
        end));
        local _ = i;
    end;
end;

function u86.delay(p1373, p1374) -- Line: 9648
    -- upvalues: u115 (ref), u132 (copy)
    local task_delay_ret = task.delay(p1373 / u115, p1374);
    table.insert(u132, task_delay_ret);

    return task_delay_ret;
end;

u86.beginCountdown = beginCountdown;
u86.songStartTime = 0;
local SettingsBlur = u1.Lighting.SettingsBlur;
local TweenInfo_new_ret2 = TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut);
u2.NetworkFunctions.listenTo("SetSongSelector", function(p1375, p1376, p1377, p1378, p1379, p1380) -- Line: 9663
    -- upvalues: Main (copy), u52 (copy), u2 (copy), workspace_CurrentCamera (copy), u1 (copy), SettingsBlur (copy), TweenInfo_new_ret2 (copy), u1151 (ref), u23 (copy), DataManager (copy), u50 (copy), u51 (copy)
    Main.InviteUI.Visible = false;

    for _, child in Main:GetChildren() do
        if child.Name == "SoloPrompt" then
            child.Parent = nil;
            child:Destroy();
        end;
    end;

    u52:updateSongFlags({
        curSide = p1378,
        showCopyright = p1379,
        isSingleplayer = p1376,
        players = p1380
    });
    u2.Topbar.highlightKey = false;
    Main.TopbarButtons:SetAttribute("Disabled", true);

    if p1375 or p1375 == "Show" then
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        u1.TweenService:Create(SettingsBlur, TweenInfo_new_ret2, {
            Size = 16
        }):Play();
        u1.TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            CFrame = p1377.Cameras.Camera.CFrame
        }):Play();

        if u1151 then
            u2.Results.clearUp(u1151);
        end;

        u52:show();
        u23.inSongSelect = true;

        if not (workspace:GetAttribute("VIPServer") or u2.EngineVersion.IsStudio()) then
            u52:setTimeLeft(p1376 and 300 or 120);
        end;
    elseif not p1375 or p1375 == "Hide" then
        u23.inSongSelect = false;
        u52:hide();
        u1.TweenService:Create(SettingsBlur, TweenInfo_new_ret2, {
            Size = 0
        }):Play();
        DataManager:SetData("Favorites", u50);
        DataManager:SetData("Recents", u51);
    end;
end);
local u1381 = nil;
u2.NetworkFunctions.listenTo("SetSingleplayerUI", function(p1382, p1383) -- Line: 9712
    -- upvalues: Main (copy), u1381 (ref)
    if Main.StageWait.Enabled then
        local v1384 = (not p1382 and p1382 ~= "Show" and true or false) and Main:FindFirstChild("SoloPrompt");

        if v1384 then
            v1384:SetAttribute("Hide", true);
        end;
    else
        Main.SoloUI.Visible = p1382 or p1382 == "Show";

        if Main.SoloUI.Visible == false then
            Main.InviteUI.Visible = false;
        end;
    end;

    u1381 = (p1382 or p1382 == "Show") and p1383 and p1383 or nil;
    Main.TopbarButtons:SetAttribute("Disabled", p1382 or p1382 == "Show");
end);
local u1385 = false;
u2.NetworkFunctions.listenTo("InviteReceived", function(p1386: userdata, u1387) -- Line: 9737
    -- upvalues: Data (ref), u1385 (ref), Main (copy), u1 (copy), u2 (copy)
    if Data.DisableInvites or u1385 then
        return;
    end;

    u1385 = true;

    if not Main.InviteUI.List:FindFirstChild(p1386.Name) then
        local u1388 = Main.InviteReceived.Placeholder:Clone();
        local u1389 = true;
        u1388.Visible = true;
        u1388.Name = p1386.Name;
        u1388.SubTitle.Text = p1386.DisplayName and p1386.DisplayName .. " (" .. p1386.Name .. ")" or p1386.Name;
        u1388.Icon.Image = u1.Players:GetUserThumbnailAsync(p1386.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
        u1388.Decline.MouseButton1Click:Connect(function() -- Line: 9753
            -- upvalues: u1389 (ref), u1388 (copy), u1385 (ref), u1 (ref)
            if u1389 then
                u1388.Decline.Visible = false;
                u1388.Accept.Visible = false;
                u1389 = false;
                u1385 = false;
                u1.TweenService:Create(u1388, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 1), {
                    GroupTransparency = 1
                }):Play();
                u1.Debris:AddItem(u1388, 3);
            end;
        end);
        u1388.Accept.MouseButton1Click:Connect(function() -- Line: 9764
            -- upvalues: u1389 (ref), u1385 (ref), u1388 (copy), u2 (ref), u1387 (copy)
            if u1389 then
                u1389 = false;
                u1385 = false;
                u1388:Destroy();
                u2.NetworkFunctions.fireServer("AcceptInvite", u1387);
            end;
        end);
        task.delay(9, function() -- Line: 9776
            -- upvalues: u1389 (ref), u1385 (ref), u1 (ref), u1388 (copy)
            if u1389 then
                u1385 = false;
                u1.TweenService:Create(u1388, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 1), {
                    GroupTransparency = 1
                }):Play();
                u1.Debris:AddItem(u1388, 3);
            end;
        end);
        u1388.Parent = Main.InviteReceived;
    end;
end);
u2.NetworkFunctions.listenTo("POST_InvitePlayers", function(p1390: table) -- Line: 9788
    -- upvalues: Main (copy), Data (ref), u1381 (ref), u2 (copy), u1 (copy)
    for _, child in Main.InviteUI.List:GetChildren() do
        if child:IsA("TextButton") and child.Visible then
            child:Destroy();
        end;
    end;

    if Data.DisableInvites then
        return;
    end;

    local v1391 = u1381;

    if not v1391 then
        u2.Logger.warn("No stage to invite to, ignoring invite...");

        return;
    end;

    local u1392 = v1391.Cameras.Camera.CFrame + CFrame.new(0, 3.5, 0).Position;

    for _, v in p1390 do
        local v1393 = Main.InviteUI.List.Template:Clone();
        v1393.PlrName.Label.Text = v.DisplayName;
        v1393.Icon.Image = u1.Players:GetUserThumbnailAsync(v.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
        v1393.Invite.MouseButton1Click:Connect(function() -- Line: 9808
            -- upvalues: u2 (ref), v (copy), u1392 (copy)
            u2.NetworkFunctions.fireServer("SET_InvitePlayer", v, u1392);
        end);
        v1393.Parent = Main.InviteUI.List;
        v1393.Visible = true;
    end;
end);

local function toggleInvite() -- Line: 9816
    -- upvalues: Main (copy), u2 (copy)
    if Main.InviteUI.Visible == false then
        u2.NetworkFunctions.fireServer("GET_InvitePlayers");
    end;

    Main.InviteUI.Visible = not Main.InviteUI.Visible;
end;

Main.InviteUI.Close.MouseButton1Click:Connect(function() -- Line: 9823
    -- upvalues: Main (copy)
    Main.InviteUI.Visible = false;
end);
Main.ChildAdded:Connect(function(p1394) -- Line: 9826
    -- upvalues: toggleInvite (copy)
    local v1395 = p1394.Name == "SoloPrompt" and p1394:WaitForChild("Invite", 50);

    if v1395 then
        v1395.MouseButton1Click:Connect(toggleInvite);
    end;
end);
Main.SoloUI.Invite.MouseButton1Click:Connect(toggleInvite);
local u1396 = false;
u2.NetworkFunctions.listenTo("LoadSong", function(p1397, p1398, p1399, p1400, p1401, p1402, p1403, p1404) -- Line: 9840
    -- upvalues: u1396 (ref), u1071 (ref)
    u1396 = false;

    if u1071 then
        repeat
            task.wait();
        until u1396 or not u1071;
    end;

    if u1396 then
        return;
    end;

    xpcall(loadSong, function(p1405) -- Line: 9851
        -- upvalues: u1071 (ref), u1396 (ref)
        u1071 = false;
        showError("ENGINE", p1405, debug.traceback());

        if u1396 then
            abruptGameEnd();
        end;
    end, p1397, p1398, p1399, p1400, p1401, p1402, p1403, p1404);
end);
u2.NetworkFunctions.listenTo("Start", function(p1406) -- Line: 9861
    -- upvalues: u134 (ref), Game (copy), u1 (copy), BindableEvent (copy), u33 (ref), u23 (copy), u89 (copy), u24 (copy)
    u134:SetVisibility(true);
    Game.Visible = true;
    leaveLoadingState();
    task.wait(0.75);
    u1.StarterGui:SetCore("ResetButtonCallback", BindableEvent);

    if not u33 then
        return;
    end;

    u23.loadedSong = true;
    u89:call("onLoad");

    if u24.dontStartSong then
        return;
    end;

    if p1406 > 0 then
        task.wait(p1406);
    end;

    if not u23.inSong then
        return;
    end;

    u89:call("preCountdown");
    beginCountdown();
end);

function endSong(p1407)
    -- upvalues: Data (ref), u2 (copy), u356 (ref), u35 (ref), u115 (ref), u114 (ref), u113 (copy)
    createResults(p1407);

    if Data.MedalAutoclip then
        local Judgement = u2.ratingModule.getJudgement(u356);

        if Judgement.countsAs ~= nil and table.find(Judgement.countsAs, Data.MedalAutoclipReq:upper()) then
            u2.MedalClipping:TriggerClip("afternight_" .. string.lower(Data.MedalAutoclipReq), `{u35.SongName} ({u35.DisplayDiffName}) [{u2.Adapters.floatToString(u115)}x] - ` .. string.upper(Data.MedalAutoclipReq), {
                captureDelayMs = 1000,
                duration = Data.MedalAutoclipFull and ((u114 or u113.timeLength) / u115 + 10 or 30) or 30
            });
        end;
    end;

    clearUp(true);
end;

u86.endSong = endSong;
u2.NetworkFunctions.listenTo("EndSong", function() -- Line: 9910
    -- upvalues: u89 (copy), u356 (ref)
    u89:call("onSongEnd", u356);
end);
u2.NetworkFunctions.listenTo("Clear", function(p1408) -- Line: 9914
    -- upvalues: u1396 (ref)
    u1396 = true;
    endSong(p1408);
end);
u2.NetworkFunctions.listenTo("PlayerLeft", function(p1409: table) -- Line: 9919
    -- upvalues: u36 (ref)
    showPlayerLeft(p1409.Username, p1409.UserId, p1409.Side == u36);
end);
u2.NetworkFunctions.listenTo("ServerEvent", function(p1410, p1411) -- Line: 9923
    -- upvalues: u89 (copy)
    u89:call("onServerEvent", p1410, p1411);
end);
local u1412 = nil;
u2.NetworkFunctions.listenTo("ChangeGFStatus", function(p1413) -- Line: 9928
    -- upvalues: u1412 (ref), u163 (ref), u2 (copy)
    u1412 = p1413 or nil;
    local v1414;

    if p1413 then
        v1414 = u2.CharReplicator:GetCharFromPlr(p1413) or u2.CharacterModule:GetRigStorage():FindFirstChild(p1413.Name) or nil;
    else
        v1414 = nil;
    end;

    u163 = v1414;
    u2.MapService:Reposition(nil, u163);
    updateHideSpeaker();
end);

function oppoNoNoteSimulateHealthDrain(p1415)
    -- upvalues: Data (ref), u157 (ref)
    if (Data.HealthDrain or u157.forceHealthDrain) and u157.allowHealthDrain then
        local v1416 = 0.035 * p1415.ratingMod * Data.HealthDrainIntensity;
        local v1417 = Data.HealthDrainLimit * u157.maxHealth;

        if u157.currentHealth > v1417 then
            local v1418 = u157.currentHealth - v1416 * u157.lossMult;

            if v1418 <= v1417 then
                v1416 = (u157.currentHealth - math.clamp(v1418, v1417, 10000)) / u157.lossMult;
            end;

            removeHealth(v1416);
        end;
    end;
end;

u2.NetworkFunctions.listenTo("ReplicateInput", function(p1419, p1420) -- Line: 9952
    -- upvalues: Data (ref), u117 (copy), u156 (ref)
    if Data.DisableOpponentStrums then
        return oppoNoNoteSimulateHealthDrain(p1420);
    end;

    local v1421 = string.split(p1419, "|")[1];
    local v1422 = tonumber(v1421) or 0;
    local v1423 = nil;

    for _, v in u117 do
        if v.strumLine ~= u156 then
            if v1422 < v.strumTime then
                break;
            end;

            if p1419 == table.concat(v.rawData, "|", 1, 3) then
                v1423 = v;
                break;
            end;
        end;
    end;

    if v1423 == nil then
        return oppoNoNoteSimulateHealthDrain(p1420);
    end;

    opponentHit(v1423, p1420);
end);
u2.NetworkFunctions.listenTo("ReplicateMiss", function(p1424) -- Line: 9974
    -- upvalues: u369 (ref)
    u369.score = p1424.Score;
    u369.misses = p1424.Misses;
    u369.notesPlayed = p1424.TotalNotesPlayed;
    u369.combo = 0;
    updateOppStatsLabel();
end);
u2.NetworkFunctions.listenTo("UpdateStats", function(p1425) -- Line: 9983
    -- upvalues: Overlay (copy), Data (ref)
    for _, v in { "L", "R" } do
        local v1426 = Overlay["TeamScore" .. v];

        if Data.ShowMatchStats and v1426.Visible then
            v1426.Label.Text = "Team Score: " .. math.floor(p1425[v].Score) .. " (" .. round(p1425[v].Accuracy, 2) .. "%)";
        end;
    end;
end);
local u1427 = {};
local u1429 = (function(p1428) -- Line: 9993, Name: GetObject
    -- upvalues: u1427 (copy)
    if u1427[p1428] then
        return u1427[p1428];
    end;

    local l_game = game;

    for _, v in p1428:split(".") do
        l_game = l_game[v];
    end;

    u1427[p1428] = l_game;

    return l_game;
end)(script:GetAttribute("SpawnPart")).CFrame + CFrame.new(0, 3.5, 0).Position;
local u1430 = u1429;

function trackedDeath()
    -- upvalues: u1429 (ref), LocalPlayer (copy)
    u1429 = LocalPlayer.Character:GetPivot();
    LocalPlayer.Character.Humanoid.Health = 0;
end;

function die(p1431: boolean?)
    -- upvalues: u75 (copy), u2 (copy), Data (ref), u89 (copy), u143 (ref), u1 (copy)
    if u75.alreadyDead == true then
        return;
    end;

    u75.alreadyDead = true;
    u2.NetworkFunctions.fireServer("PlayerDeath");

    if not Data.DieOnHealthLoss then
        if not (p1431 or (not Data.ShowDeathWarning or u143 == nil)) then
            u143.ImageTransparency = 0;
            u143.Title.Visible = true;
            u143.Label.Visible = true;
            task.delay(3, function() -- Line: 10030
                -- upvalues: u143 (ref), u1 (ref)
                if not u143 then
                    return;
                end;

                u1.TweenService:Create(u143, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    ImageTransparency = 1
                }):Play();

                for _, v in { u143:FindFirstChild("Title"), u143:FindFirstChild("Label") } do
                    if v ~= nil then
                        u1.TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                            TextTransparency = 1
                        }):Play();

                        if v:FindFirstChild("UIStroke") then
                            u1.TweenService:Create(v.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                                Transparency = 1
                            }):Play();
                        end;
                    end;
                end;

                u1.Debris:AddItem(u143, 2);
            end);
        end;

        return;
    end;

    u89:call("onDeath", true);
    trackedDeath();
end;

u86.die = die;
LocalPlayer.CharacterAdded:Connect(function(u1432) -- Line: 10052
    -- upvalues: LocalPlayer (copy), workspace_CurrentCamera (copy), u1429 (ref), u1430 (copy)
    u1432:WaitForChild("HumanoidRootPart");
    u1432.Archivable = true;
    task.wait();
    task.spawn(function() -- Line: 10058
        -- upvalues: LocalPlayer (ref), u1432 (copy), workspace_CurrentCamera (ref)
        local ShopCamTargetValueFix = LocalPlayer:FindFirstChild("ShopCamTargetValueFix");

        if ShopCamTargetValueFix then
            ShopCamTargetValueFix.Value = u1432:WaitForChild("Humanoid");
            workspace_CurrentCamera.CameraSubject = u1432.Humanoid;
        end;
    end);

    if script:GetAttribute("SpawnPos") then
        u1432:PivotTo(script:GetAttribute("SpawnPos"));
        script:SetAttribute("SpawnPos", nil);

        return;
    end;

    if LocalPlayer:GetAttribute("SpawnPos") then
        u1432:PivotTo(LocalPlayer:GetAttribute("SpawnPos"));
        LocalPlayer:SetAttribute("SpawnPos", nil);

        return;
    end;

    u1432:PivotTo(u1429);
    u1429 = u1430;
end);
BindableEvent.Event:Connect(function() -- Line: 10078
    -- upvalues: u23 (copy), u1071 (ref), Main (copy), u2 (copy), u89 (copy)
    if u23.inSong and u1071 then
        return;
    end;

    if Main.SoloUI.Visible then
        Main.SoloUI.Visible = false;
    end;

    if not u23.inSong then
        trackedDeath();

        return;
    end;

    u2.NetworkFunctions.fireServer("PlayerReset");
    u89:call("onDeath", false);
end);

while not pcall(u1.StarterGui.SetCore, u1.StarterGui, "ResetButtonCallback", BindableEvent) do
    wait();
end;

u2.LocalSignals.APILoaded:Fire(u86);
u2.Logger.log((`API has {#u86} indexes`));