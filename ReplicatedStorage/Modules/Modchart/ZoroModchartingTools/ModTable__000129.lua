-- Decompiled with Potassium's decompiler.

local u1 = {};
local Modifiers = require(script.Parent.Modifiers);
local ModifierType = Modifiers.ModifierType;
local NoteMovement = require(script.Parent.NoteMovement);
local FlxEase = require(script.Parent.FlxEase);
local ModchartUtil = require(script.Parent.ModchartUtil);
local u2 = nil;
local VarTweener = require(game:GetService("ReplicatedStorage").Modules.Main.VarTweener);

function u1.new(p3, p4) -- Line: 13
    -- upvalues: u1 (copy)
    local v5 = setmetatable({
        instance = nil,
        modifiers = {},
        renderer = p4,
        table = {}
    }, {
        __index = u1
    });
    v5:loadDefaultModifiers();
    v5:reconstructTable();

    return v5;
end;

function u1.add(p6, p7) -- Line: 27
    p7.instance = p6.instance;
    p7.renderer = p6.renderer;
    p6:remove(p7.tag);
    p6.modifiers[p7.tag] = p7;
    p6:reconstructTable();

    return p7;
end;

function u1.remove(p8, p9) -- Line: 38
    if p8.modifiers[p9] then
        p8.modifiers[p9] = nil;
    end;
end;

function u1.clear(p10) -- Line: 44
    p10.modifiers = {};
    p10:loadDefaultModifiers();
end;

function u1.resetMods(p11) -- Line: 49
    for _, v in p11.modifiers do
        v:reset();
    end;
end;

function u1.setModTargetLane(p12, p13, p14) -- Line: 55
    if p12.modifiers[p13] then
        p12.modifiers[p13].targetLane = p14;
    end;
end;

function u1.loadDefaultModifiers(p15) -- Line: 61
    -- upvalues: Modifiers (copy), NoteMovement (copy), ModifierType (copy)
    p15:add(Modifiers.XModifier.new("x"));
    p15:add(Modifiers.YModifier.new("y"));
    p15:add(Modifiers.ZModifier.new("z"));
    p15:add(Modifiers.ConfusionModifier.new("confusion"));

    for i = 0, NoteMovement.keyCount + NoteMovement.playerKeyCount - 1 do
        p15:add(Modifiers.XModifier.new("x" .. i, ModifierType.LANESPECIFIC));
        p15:add(Modifiers.YModifier.new("y" .. i, ModifierType.LANESPECIFIC));
        p15:add(Modifiers.ZModifier.new("z" .. i, ModifierType.LANESPECIFIC));
        p15:add(Modifiers.ConfusionModifier.new("confusion" .. i, ModifierType.LANESPECIFIC));
        p15:setModTargetLane("x" .. i, i);
        p15:setModTargetLane("y" .. i, i);
        p15:setModTargetLane("z" .. i, i);
        p15:setModTargetLane("confusion" .. i, i);
        local _ = i;
    end;
end;

function u1.reconstructTable(p16) -- Line: 79
    -- upvalues: NoteMovement (copy)
    local v17 = {};
    p16.table = v17;

    for i, _ in p16.renderer.playfields do
        v17[i] = {};
        local v18 = i;

        for i2 = -1, NoteMovement.totalKeyCount - 1 do
            v17[v18][i2] = {};
            local v19 = i2;

            for _, v in p16.modifiers do
                if v:checkLane(v19) and v:checkPlayField(v18) then
                    table.insert(v17[v18][v19], v);
                end;
            end;
        end;
    end;
end;

function u1.applyStrumMods(p20: table, p21: userdata, p22: number, p23: number) -- Line: 98
    if p20.table[p23] ~= nil and p20.table[p23][p22] ~= nil then
        for _, v in p20.table[p23][p22] do
            v:getStrumPath(p21, p22, p23);
        end;
    end;
end;

function u1.applyNoteMods(p24: table, p25: userdata, p26: number, p27: userdata, p28: number) -- Line: 107
    if p24.table[p28] ~= nil and p24.table[p28][p26] ~= nil then
        for _, v in p24.table[p28][p26] do
            v:getNotePath(p25, p26, p27, p28);
        end;
    end;
end;

function u1.applyNoteDistMods(p29: table, p30: number, p31: number, p32: number) -- Line: 116
    if p29.table[p32] ~= nil and p29.table[p32][p31] ~= nil then
        for _, v in p29.table[p32][p31] do
            p30 = v:getNoteDist(p30, p31, 0, p32);
        end;
    end;

    return p30;
end;

function u1.applyCurPosMods(p33: table, p34: number, p35: number, p36: number) -- Line: 127
    if p33.table[p36] ~= nil and p33.table[p36][p34] ~= nil then
        for _, v in p33.table[p36][p34] do
            p35 = v:getNoteCurPos(p34, p35, p36);
        end;
    end;

    return p35;
end;

function u1.applyIncomingAngleMods(p37: table, p38: number, p39: number, p40: number) -- Line: 138
    local v41 = { 0, 0 };

    if p37.table[p40] ~= nil and p37.table[p40][p38] ~= nil then
        for _, v in p37.table[p40][p38] do
            local IncomingAngle = v:getIncomingAngle(p38, p39, p40);
            v41[1] = v41[1] + IncomingAngle[1];
            v41[2] = v41[2] + IncomingAngle[2];
        end;
    end;

    return v41;
end;

function u1.getPlayfieldAlphaMods(p42: table, p43: number) -- Line: 153
    local v44 = {
        alpha = 1
    };

    if p42.table[p43] ~= nil and p42.table[p43][-1] ~= nil then
        for _, v in p42.table[p43][-1] do
            if v.playfieldSafe then
                v:getNotePath(v44, -1, 0, p43);
            end;
        end;
    end;

    return v44.alpha;
end;

function u1.tweenModifier(p45: table, p46: string, p47: number, p48: number, p49: string, p50: number) -- Line: 169
    -- upvalues: FlxEase (copy), ModchartUtil (copy), u2 (ref), VarTweener (copy)
    local v51 = p46:gsub(" ", ""):gsub("\n", "");
    local v52 = p45.modifiers[v51];

    if not v52 then
        print("no mod!!!", v51);

        return;
    end;

    local v53 = FlxEase.getFlxEaseByString(p49) or FlxEase.linear;
    local TimeFromBeat = ModchartUtil:getTimeFromBeat(p50);

    if u2.SongPosition >= TimeFromBeat + p48 * 1000 then
        v52.currentValue = p47;

        return;
    end;

    local _ = v52.currentValue;
    local v54 = VarTweener:Create(v52, {
        DelayTime = 0,
        RepeatCount = 0,
        Reverses = false,
        Time = p48 / p45.renderer.speed,
        Ease = v53
    }, {
        currentValue = p47
    });
    v54:Play();

    if TimeFromBeat < u2.SongPosition then
        v54:Set((u2.SongPosition - TimeFromBeat) * 0.001);
    end;
end;

function u1.tweenModifierSubValue(p55: table, p56: string, p57: string, p58: number, p59: number, p60: string, p61: number) -- Line: 198
    -- upvalues: FlxEase (copy), ModchartUtil (copy), u2 (ref), VarTweener (copy)
    local v62 = p56:gsub(" ", ""):gsub("\n", "");
    local v63 = p55.modifiers[v62];

    if not v63 then
        return;
    end;

    local v64 = v63.subValues[p57];

    if not v64 then
        return;
    end;

    local v65 = FlxEase.getFlxEaseByString(p60) or FlxEase.linear;
    local TimeFromBeat = ModchartUtil:getTimeFromBeat(p61);

    if u2.SongPosition >= TimeFromBeat + p59 * 1000 then
        v64.value = p58;

        return;
    end;

    local v66 = VarTweener:Create(v64, {
        DelayTime = 0,
        RepeatCount = 0,
        Reverses = false,
        Time = p59 / p55.renderer.speed,
        Ease = v65
    }, {
        value = p58
    });
    v66:Play();

    if TimeFromBeat < u2.SongPosition then
        v66:Set((u2.songPosition - TimeFromBeat) * 0.001);
    end;
end;

function u1.Init(p67) -- Line: 229
    -- upvalues: u2 (ref)
    u2 = p67.Conductor;
end;

return u1;