-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local Debris = game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Assets = Modules:WaitForChild("Assets");
local ManiaData = require(Modules.Engine.VSRG.ManiaData);
local Strum = require(Modules.Engine.VSRG.Strum);
local LaneBG = require(Modules.Engine.VSRG.LaneBG);
local MathFuncs = require(Modules.Other.MathFuncs);
local Adapters = require(Modules.Other.Adapters);
local DeviceManager = require(Modules.Main.DeviceManager);
local LocalSignals = require(Modules.Signals.LocalSignals);
require(Modules.Types);
local u1 = {
    Characters = true,
    LaneBacks = true,
    Notes = true,
    UnspawnNotes = true,
    LaneBGs = true,
    KeybindReminders = true,
    Holdsplashes = true,
    Notesplashes = true,
    _strumlineDelayedThreads = true,
    _dirStrums = true
};

local function serialize(p2, p3, p4) -- Line: 34
    -- upvalues: u1 (copy), serialize (copy)
    local v5 = p3 or "";
    local v6 = p4 or {};

    if v6[p2] then
        return "*circular reference*";
    end;

    v6[p2] = true;
    local v7 = v5 .. "    ";
    local v8 = "{\n";

    for i, v in p2 do
        if not u1[i] then
            local v9 = tostring(i);

            if type(v) == "table" then
                v8 = v8 .. v7 .. v9 .. " = " .. serialize(v, v7, v6) .. ",\n";
            elseif type(v) == "string" then
                v8 = v8 .. v7 .. v9 .. " = \"" .. v .. "\",\n";
            else
                v8 = v8 .. v7 .. v9 .. " = " .. tostring(v) .. ",\n";
            end;
        end;
    end;

    return v8 .. v5 .. "}";
end;

local u10 = {};
u10.__index = u10;

function u10.__tostring(p11) -- Line: 63
    -- upvalues: serialize (copy)
    return serialize(p11);
end;

local u12 = { 6, 7 };
local size = ManiaData.size;
local _ = ManiaData.offset;
local gap = ManiaData.gap;
local u13 = nil;
LocalSignals.APILoaded:Once(function(p14) -- Line: 74
    -- upvalues: u13 (ref)
    u13 = p14;
end);

function u10.new(p15: string?, p16: number?, p17: number?, p18: number?, p19: any) -- Line: 78
    -- upvalues: u13 (ref), size (copy), u10 (copy)
    local v20 = p15 or u13.Side;
    local u21 = {};
    local v25 = {
        Alpha = 0,
        ClipSustains = true,
        Downscroll = false,
        ShowKeybindReminders = true,
        NoteScale = 1,
        HoldWidthMult = 1,
        LaneGap = 0,
        LaneHeight = 0,
        LaneTransparency = 1,
        LaneSpacing = false,
        Characters = {},
        LaneBacks = {},
        Notes = {},
        UnspawnNotes = {},
        Lanes = setmetatable({}, {
            __index = function(p22, p23) -- Line: 91, Name: __index
                -- upvalues: u21 (copy)
                local v24 = u21[p23];

                if v24 then
                    return p22[v24.lane];
                end;
            end
        }),
        Strums = setmetatable({}, {
            __index = u21
        }),
        KeyCount = p16 or 4,
        Scale = p18 or 1,
        KeyCountScale = 0.7 - size[p16],
        Side = v20,
        StartPoint = p17 or 0,
        LaneBGs = {},
        KeybindReminders = {},
        Holdsplashes = {},
        Notesplashes = {},
        _strumlineDelayedThreads = {},
        _dirStrums = u21
    };
    local v26 = setmetatable(v25, u10);

    if p19 then
        v26:loadSettings(p19);
    end;

    return v26;
end;

function u10.Destroy(p27) -- Line: 134
    for _, v in p27.Strums do
        v:Destroy();
    end;

    for _, v in p27.LaneBacks do
        v:Destroy();
    end;

    for _, v in p27._strumlineDelayedThreads do
        pcall(task.cancel, v);
    end;

    for _, v in p27.KeybindReminders do
        v:Destroy();
    end;

    table.clear(p27._dirStrums);
    table.clear(p27);
end;

function u10.generateStrum(p28: table, p29: number, p30: boolean?) -- Line: 155
    -- upvalues: u13 (ref), ManiaData (copy), Assets (copy), Strum (copy), LaneBG (copy), u12 (copy), Adapters (copy)
    local v31 = u13.Strums[0] == nil and 0 or #u13.Strums + 1;
    local v32 = ManiaData.dirs[p28.KeyCount][p29 + 1];
    local v33 = Assets.Templates.StrumObj:Clone();
    v33.Name = "Strum" .. v31;
    local v34 = Strum.new(v33);
    local v35 = LaneBG.new();
    v34.side = p28.Side;
    v34.dir = v32;
    v34.lane = p29;
    v34.strumIndex = v31;
    v34.strumLine = p28;

    if u13.Settings.FlipNoteskin and table.find(u12, p28.KeyCount) then
        v34.animDir = v32 == "Down" and "Up" or (v32 == "Up" and "Down" or Adapters.convertNoteAnimToBase(v32));
    else
        v34.animDir = Adapters.convertNoteAnimToBase(v32);
    end;

    v34.textureDir = v32;
    v34.laneSpeed = 1;
    v34.incomingAngle = 90;
    v34.zindex = 5;
    v34.parent = u13.Game;
    v35.insetPixels = p28.LaneSpacing and 2 or -2;
    v35.alpha = 1 - p28.LaneTransparency;
    v35.scale = 1 / p28.NoteScale * (1 / p28.Scale);
    table.insert(p28.LaneBacks, v35);
    table.insert(p28.LaneBGs, v35.lane);
    p28:resetStrum(v34, true);
    v35:attach(v34);

    if not p30 then
        v34:playFNFIntro(p28.KeyCount, p29);
    end;

    p28._dirStrums[v34.dir] = v34;
    p28.Strums[p29] = v34;
    p28.Lanes[p29] = {};
    u13.Strums[v31] = v34;
end;

function u10.applyNoteSkin(p36: table, p37: table, p38: table, p39: boolean?) -- Line: 211
    for i, v in p36._dirStrums do
        local v40 = p37[i];

        if v40 then
            v:loadSkin(v40);
            v.defaultSkin = v40;
        end;
    end;
end;

function u10.setStrumSkin(p41: table, p42: any, p43: boolean?) -- Line: 224
end;

function u10.applySplashSkin(p44: table, p45: table, p46: table, p47: boolean?) -- Line: 228
end;

function u10.applyHoldSplashSkin(p48: table, p49: table, p50: table, p51: boolean?) -- Line: 232
end;

function u10.resetStrum(p52, p53, p54) -- Line: 237
    -- upvalues: size (copy), ManiaData (copy), MathFuncs (copy)
    local v55 = (0.7 - size[p52.KeyCount]) * p52.Scale;
    local v56 = ManiaData.noteSize * v55;
    local _ = ManiaData.dirs[p52.KeyCount][p53.lane + 1];
    local v57 = MathFuncs.getRawXPoint(p53.lane, p52.KeyCount, p52.Scale) + p52.StartPoint;
    local v58 = p52.Downscroll and (720 - v56 - 50 or 50) or 50;
    p53.x = v57;
    p53.y = v58;
    p53.Scale = Vector2.new(v55, v55);
    p53.keyCountScale = v55;
    p53.offsets.set("x", "anchorOffset", v56 * p53.anchor.X);
    p53.offsets.set("y", "anchorOffset", v56 * p53.anchor.Y);
    local v59 = (ManiaData.noteSize / 2 * 0.7 - ManiaData.noteSize / 2 * v55) * p53.anchor.Y;

    if v59 == 0 or not v59 then
        v59 = nil;
    end;

    p53.offsets.set("y", "strumLineOffset", v59);
    p52:updateOffset(p53);

    if p54 then
        local v60 = p53.strumIndex or -1;
        p53.defaultX = v57;
        p53.defaultY = v58;
        p53.defaultAngle = 0;
        _G["defaultStrum" .. tostring(v60) .. "X"] = v57;
        _G["defaultStrum" .. tostring(v60) .. "Y"] = v58;
        _G["defaultStrum" .. tostring(v60) .. "Angle"] = 0;
    end;
end;

function u10.setLaneTransparency(p61, p62) -- Line: 277
    local v63 = p62 or 0;

    for _, v in p61.LaneBacks do
        v.alphaMult = v63;
        v:updateAlpha();
    end;
end;

function u10.setBaseLaneTransparency(p64, p65) -- Line: 285
    local v66 = p65 or (p64.LaneTransparency or 1);

    for _, v in p64.LaneBacks do
        v.alpha = 1 - v66;
        v:updateAlpha();
    end;
end;

function u10.recalculateStrums(p67, p68) -- Line: 294
    for _, v in p67.Strums do
        p67:resetStrum(v, p68);
    end;

    for i, v in p67.LaneBacks do
        v.insetPixels = p67.LaneSpacing and 2 or -2;
        v.alpha = 1 - p67.LaneTransparency;
        local _ = p67.Strums[i - 1];
        v.scale = 1 / p67.NoteScale * (1 / p67.Scale);
        v:update();
    end;

    p67:updateAnchorOffsets();
end;

function u10.updateOffset(p69, p70) -- Line: 311
    -- upvalues: gap (copy)
    local v71 = p69.LaneGap / (p70.keyCountScale / 0.7);
    local lane = p70.lane;
    local v72 = v71 < 0 and -1 or 1;
    local v73 = v72 * math.abs((p69.KeyCount + 1) / 2 - (lane + 1)) * (v71 * v72) * (p69.KeyCount / 2 <= lane and 1 or -1);

    if v73 ~= 0 then
        p70.offsets.set("x", "strumGapOffset", v73);
    end;

    local LaneHeight = p69.LaneHeight;

    if LaneHeight ~= 0 then
        p70.offsets.set("y", "laneHeight", LaneHeight);
    end;

    local NoteScale = p69.NoteScale;

    if NoteScale ~= 1 then
        p70.offsets.set("Scale", "sizeOffset", NoteScale);
    end;

    local v74 = p69.LaneBacks[p70.lane + 1];

    if not v74 then
        return;
    end;

    v74.extraSize = v71 + gap[p69.KeyCount];
    v74.scale = 1 / NoteScale * (1 / p69.Scale);
    v74:updateSize();
end;

function u10.generateStrums(p75: table, p76: boolean?) -- Line: 343
    for i = 0, p75.KeyCount - 1 do
        p75:generateStrum(i, p76);
        local _ = i;
    end;
end;

function u10.updateAnchorOffsets(p77) -- Line: 349
    local LaneHeight = p77.LaneHeight;
    local NoteScale = p77.NoteScale;
    local HoldWidthMult = p77.HoldWidthMult;

    if NoteScale == 1 or not NoteScale then
        NoteScale = nil;
    end;

    local v78;

    if HoldWidthMult == 1 then
        v78 = nil;
    else
        v78 = Vector2.new(HoldWidthMult, 1) or nil;
    end;

    if LaneHeight == 0 then
        LaneHeight = nil;
    end;

    for _, v in { p77.Notes, p77.UnspawnNotes } do
        for _, v2 in v do
            v2.offsets.set("y", "laneHeight", LaneHeight);

            if v2.sustainNote then
                v2.offsets.set("Scale", "sizeOffset", v78);
            else
                v2.offsets.set("Scale", "sizeOffset", NoteScale);
            end;

            local v79 = v2.strum or p77.Strums[v2.noteData];

            if v79 then
                v2.offsets.set("x", "anchorOffset", v79.offsets.get("x", "anchorOffset"));
                v2.offsets.set("y", "anchorOffset", v79.offsets.get("y", "anchorOffset"));
                v2.offsets.set("y", "strumLineOffset", v79.offsets.get("y", "strumLineOffset"));
                v2.offsets.set("x", "strumGapOffset", v79.offsets.get("x", "strumGapOffset"));
            end;
        end;
    end;
end;

function u10.regenerateStrums(p80: table, p81: boolean?) -- Line: 382
    for _, v in p80.Strums do
        v:Destroy();
    end;

    for _, v in p80.LaneBacks do
        v:Destroy();
    end;

    for _, v in p80.KeybindReminders do
        v:Destroy();
    end;

    table.clear(p80._dirStrums);
    table.clear(p80.Strums);
    table.clear(p80.LaneBacks);
    table.clear(p80.LaneBGs);
    table.clear(p80.Lanes);
    table.clear(p80.KeybindReminders);
    p80:generateStrums(p81);
end;

function u10.showKeybindReminders(u82) -- Line: 405
    -- upvalues: DeviceManager (copy), Assets (copy), u13 (ref), ManiaData (copy), UserInputService (copy), TweenService (copy), Debris (copy)
    if not u82.ShowKeybindReminders or DeviceManager.currentDevice == "Mobile" then
        return;
    end;

    for _, v in u82.KeybindReminders do
        v:Destroy();
    end;

    table.clear(u82.KeybindReminders);

    for i = 0, u82.KeyCount - 1 do
        local u83 = u82.Strums[i];

        if not u83 then
            return;
        end;

        local u84 = Assets.Templates.KeybindReminder:Clone();
        local KBContent = u84.KBContent;
        local v85 = u13.Keybinds[u83.dir] or "No Key";
        local v86 = type(v85) == "table" and v85 and v85 or { v85 };
        local _ = #v86;
        local Property = u83:GetProperty("y");
        local PosFactors = u83:GetPosFactors();
        local u87 = u83.keyCountScale * ManiaData.noteSize / 720 / 2;
        local u88;

        if PosFactors.Y / 2 < Property then
            KBContent.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
            u87 = u87 * -1;
            u88 = -1;
        else
            u88 = 1;
        end;

        KBContent.Position = UDim2.fromScale(0.5, -u88 * 0.75);
        local u89 = {};
        local v90 = 0;
        local u91 = {};

        for _, v in v86 do
            local ImageForKeyCode = UserInputService:GetImageForKeyCode(Enum.KeyCode:FromName(v) or Enum.KeyCode.Unknown);
            v90 = v90 + 1;

            if ImageForKeyCode and ImageForKeyCode ~= "" then
                local v92 = Assets.Templates.KeybindImage:Clone();
                v92.Image = ImageForKeyCode;
                v92.ImageTransparency = 1;
                v92.LayoutOrder = v90 * u88;
                v92.Parent = KBContent;
                table.insert(u89, v92);
            else
                local v93 = Assets.Templates.KeybindText:Clone();
                v93.Text = v;
                v93.TextTransparency = 1;
                v93.UIStroke.Transparency = 1;
                v93.LayoutOrder = v90 * u88;
                v93.Parent = KBContent;
                table.insert(u91, v93);
            end;
        end;

        u84.Size = UDim2.fromScale(1, 26 / PosFactors.Y);
        u84.Position = UDim2.fromScale((u83.__currentProperties.x or u83:GetProperty("x")) / PosFactors.X, Property / PosFactors.Y + u87);
        local u94 = u83.Obj:GetPropertyChangedSignal("Position"):Connect(function() -- Line: 474
            -- upvalues: u83 (copy), u84 (copy), u87 (ref)
            local PosFactors2 = u83:GetPosFactors();
            u84.Position = UDim2.fromScale((u83.__currentProperties.x or u83:GetProperty("x")) / PosFactors2.X, (u83.__currentProperties._y or u83:GetProperty("y") / PosFactors2.Y) + u87);
        end);
        local u95 = u83.Obj:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 479
            -- upvalues: u84 (copy), u83 (copy)
            u84.Parent = u83.parent or nil;
        end);
        u84.Destroying:Once(function() -- Line: 483
            -- upvalues: u95 (ref), u94 (ref)
            if u95 then
                u95:Disconnect();
                u95 = nil;
            end;

            if u94 then
                u94:Disconnect();
                u94 = nil;
            end;
        end);
        u84.ZIndex = 12;
        u84.Visible = true;
        u84.Name = "KeybindPopup" .. u83.strumIndex;
        u84.Parent = u83.parent or nil;
        table.insert(u82._strumlineDelayedThreads, task.delay(i * 0.1 + 0.1, function() -- Line: 493
            -- upvalues: u95 (ref), u91 (copy), TweenService (ref), u89 (copy), KBContent (copy), u82 (copy), u88 (ref), Debris (ref), u84 (copy)
            if not u95 then
                return;
            end;

            for _, v in u91 do
                TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    TextTransparency = 0
                }):Play();
                TweenService:Create(v.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    Transparency = 0.5
                }):Play();
            end;

            for _, v in u89 do
                TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    ImageTransparency = 0
                }):Play();
            end;

            TweenService:Create(KBContent, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 0.5)
            }):Play();
            table.insert(u82._strumlineDelayedThreads, task.delay(2.25, function() -- Line: 506
                -- upvalues: u95 (ref), u91 (ref), TweenService (ref), u89 (ref), KBContent (ref), u88 (ref), Debris (ref), u84 (ref)
                if not u95 then
                    return;
                end;

                for _, v in u91 do
                    TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                        TextTransparency = 1
                    }):Play();
                    TweenService:Create(v.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                end;

                for _, v in u89 do
                    TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                        ImageTransparency = 1
                    }):Play();
                end;

                TweenService:Create(KBContent, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(0.5, u88 * 0.75)
                }):Play();
                Debris:AddItem(u84, 1);
            end));
        end));
        table.insert(u82.KeybindReminders, u84);
    end;
end;

function u10.loadSettings(p96, p97) -- Line: 526
    p96.Downscroll = p97.Downscroll or false;
    p96.ShowKeybindReminders = p97.ShowKeybindReminders or false;
    p96.LaneTransparency = p97.LaneTransparency or 1;
    p96.NoteScale = p97.NoteScale or 1;
    p96.LaneGap = p97.LaneGap or 0;
    p96.LaneHeight = p97.LaneHeight or 0;
    p96.LaneSpacing = p97.BackgroundLaneSpacing or false;
    p96.HoldWidthMult = p97.HoldNoteWidth / 0.3125;
    p96:recalculateStrums();
end;

return u10;