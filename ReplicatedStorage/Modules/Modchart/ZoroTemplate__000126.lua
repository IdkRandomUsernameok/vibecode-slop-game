-- Decompiled with Potassium's decompiler.

local script_PsychSprite = require(script.PsychSprite);
local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local VarTweener = require(Modules.Main.VarTweener);
local Api = shared.getApi();
local u1 = {};
local u2 = {};
local u3 = true;
local u4 = 450;
local u5 = {
    Conductor = nil,
    Settings = nil,
    Strums = nil,
    Notes = nil,
    HUD = nil,
    Game = nil
};
local u6 = 0;
local u7 = 0;
local u8 = false;
local u9 = false;
local u10 = 0;
local u11 = 0;
local u12 = 0;
local u13 = 0;
local u14 = { {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    }, {
        X = 0,
        Y = 0
    } };

function getSongPosition()
    -- upvalues: u5 (copy)
    return u5.Conductor.songPosition;
end;

function setPropertyFromGroup(p15, p16, p17, p18)
    local v19 = p15[p16];
    local string_split_ret = string.split(p17, ".");

    if #string_split_ret > 1 then
        for i = 1, #string_split_ret - 1 do
            v19 = v19[string_split_ret[i]];
            local _ = i;
        end;
    end;

    v19[string_split_ret[#string_split_ret]] = p18;
end;

function getPropertyFromGroup(p20, p21, p22)
    local _ = p20[p21];
    local v23 = p20[p21];
    local string_split_ret = string.split(p22, ".");

    if #string_split_ret > 1 then
        for i = 1, #string_split_ret - 1 do
            v23 = v23[string_split_ret[i]];
            local _ = i;
        end;
    end;

    return v23[string_split_ret[#string_split_ret]];
end;

u2.setProperty = script_PsychSprite.setProperty;
u2.getProperty = script_PsychSprite.getProperty;
local setProperty = u2.setProperty;
local getProperty = u2.getProperty;
local makeLuaSprite = script_PsychSprite.makeLuaSprite;

function u2.setup(p24) -- Line: 102
    -- upvalues: u5 (copy), Api (copy), u14 (copy)
    u5.Conductor = p24.Conductor;
    u5.Settings = p24.Settings;
    u5.Strums = p24.Strums;
    u5.Notes = p24.Notes;
    u5.HUD = p24.HUD;
    u5.Game = p24.Game;
    Api.setSetting(nil, "Middlescroll", false);
    Api.recalculateStrums(true);

    for i = 0, 7 do
        local v25 = u5.Strums[i];
        u14[i + 1].X = v25.x;
        u14[i + 1].Y = v25.y;
        local _ = i;
    end;

    setupModifiers();
end;

function setupModifiers()
    -- upvalues: makeLuaSprite (copy), setProperty (copy)
    for i = 0, 7 do
        makeLuaSprite("strumAlpha" .. i, "", 0, 0);
        makeLuaSprite("strumOffset" .. i, "", 0, 0);
        makeLuaSprite("strumOffset2" .. i, "", 0, 0);
        makeLuaSprite("scaleMulti" .. i, "", 1, 1);
        makeLuaSprite("reverse" .. i, "", 0, 0);
        makeLuaSprite("confusion" .. i, "", 0, 0);
        makeLuaSprite("incomingAngle" .. i, "", 0, 0);
        makeLuaSprite("noteRot" .. i, "", 0, 0);
        makeLuaSprite("noteOffset" .. i, "", 0, 0);
        local _ = i;
    end;

    makeLuaSprite("globalStrumOffset", "", 0, 0);
    makeLuaSprite("playerStrumOffset", "", 0, 0);
    makeLuaSprite("opponentStrumOffset", "", 0, 0);
    makeLuaSprite("incomingAngle", "", 0, 0);
    makeLuaSprite("playerIncomingAngle", "", 0, 0);
    makeLuaSprite("opponentIncomingAngle", "", 0, 0);
    makeLuaSprite("noteRot", "", 0, 0);
    makeLuaSprite("playerNoteRot", "", 0, 0);
    makeLuaSprite("opponentNoteRot", "", 0, 0);
    makeLuaSprite("screenRot", "", 0, 0);
    makeLuaSprite("brake", "", 0, 0);
    makeLuaSprite("playerBrake", "", 0, 0);
    makeLuaSprite("opponentBrake", "", 0, 0);
    makeLuaSprite("boost", "", 0, 0);
    makeLuaSprite("playerBoost", "", 0, 0);
    makeLuaSprite("opponentBoost", "", 0, 0);
    makeLuaSprite("speed", "", 1, 1);
    makeLuaSprite("twist", "", 0, 0);
    makeLuaSprite("tipsy", "", 0, 0);
    makeLuaSprite("drunk", "", 0, 0);
    makeLuaSprite("tipsySpeed", "", 1, 1);
    makeLuaSprite("drunkSpeed", "", 1, 1);
    makeLuaSprite("playerNotePathAlpha", "", 0, 0);
    setProperty("playerNotePathAlpha.alpha", 0);
    makeLuaSprite("opponentNotePathAlpha", "", 0, 0);
    setProperty("opponentNotePathAlpha.alpha", 0);
    makeLuaSprite("dark", "", 0, 0);
    makeLuaSprite("stealth", "", 0, 0);
    setProperty("dark.alpha", 0);
    setProperty("stealth.alpha", 0);
    makeLuaSprite("sudden", "", 0, 0);
    makeLuaSprite("hidden", "", 0, 0);
    setProperty("sudden.alpha", 0);
    setProperty("hidden.alpha", 0);
    makeLuaSprite("noteOffset", "", 0, 0);
    makeLuaSprite("playerNoteOffset", "", 0, 0);
    makeLuaSprite("opponentNoteOffset", "", 0, 0);
    makeLuaSprite("scale", "", 0.7, 0.7);
    makeLuaSprite("confusion", "", 0, 0);
    makeLuaSprite("reverse", "", 0, 0);
    makeLuaSprite("waveShit", "", 0, 0);
    makeLuaSprite("camHUD", "", 0, 0);
    makeLuaSprite("camGame", "", 0, 0);
end;

function getAlpha(p26, p27)
    -- upvalues: getProperty (copy), script_PsychSprite (copy), u7 (ref)
    local v28 = 1 * getProperty("strumAlpha" .. p26 .. ".alpha");
    local v29;

    if p26 < 4 then
        v29 = v28 * script_PsychSprite.getProperty("opponentStrumOffset.alpha");
    else
        v29 = v28 * script_PsychSprite.getProperty("playerStrumOffset.alpha");
    end;

    if script_PsychSprite.getProperty("stealth.alpha") ~= 0 and p27 ~= 0 then
        v29 = v29 - script_PsychSprite.getProperty("stealth.alpha");
    end;

    if script_PsychSprite.getProperty("dark.alpha") ~= 0 and p27 == 0 then
        v29 = v29 - script_PsychSprite.getProperty("dark.alpha");
    end;

    if script_PsychSprite.getProperty("hidden.alpha") ~= 0 and p27 ~= 0 then
        local v30 = scale(-p27 / u7, GetHiddenStartLine(), GetHiddenEndLine(), -1, 0);
        local v31 = clamp(v30, -1, 0);
        v29 = v29 + script_PsychSprite.getProperty("hidden.alpha") * v31;
    end;

    if script_PsychSprite.getProperty("sudden.alpha") ~= 0 and p27 ~= 0 then
        local v32 = scale(-p27 / u7, GetSuddenStartLine(), GetSuddenEndLine(), -1, 0);
        local v33 = clamp(v32, -1, 0);
        v29 = v29 + script_PsychSprite.getProperty("sudden.alpha") * v33;
    end;

    return v29;
end;

function runModifiers(p34, p35)
    -- upvalues: script_PsychSprite (copy), u10 (ref), u8 (ref), u4 (ref)
    local v36 = 0;
    local v37 = getAlpha(p34, p35);
    local v38 = 1;
    local v39 = 0 + script_PsychSprite.getProperty("strumOffset" .. p34 .. ".x");
    local v40 = 0 + script_PsychSprite.getProperty("strumOffset" .. p34 .. ".y");
    local v41 = 0 + script_PsychSprite.getProperty("strumOffset" .. p34 .. ".angle");
    local v42 = v39 + script_PsychSprite.getProperty("strumOffset2" .. p34 .. ".x");
    local v43 = v40 + script_PsychSprite.getProperty("strumOffset2" .. p34 .. ".y");
    local v44 = v41 + script_PsychSprite.getProperty("strumOffset2" .. p34 .. ".angle");
    local v45 = v42 + script_PsychSprite.getProperty("globalStrumOffset.x");
    local v46 = v43 + script_PsychSprite.getProperty("globalStrumOffset.y");
    local v47 = v44 + script_PsychSprite.getProperty("globalStrumOffset.angle");

    if p35 ~= 0 then
        local v48 = v45 + script_PsychSprite.getProperty("noteOffset.x") * math.sin(p35 * 0.002);
        local v49 = v46 + script_PsychSprite.getProperty("noteOffset.y") * math.sin(p35 * 0.002);
        local v50 = v47 + script_PsychSprite.getProperty("noteOffset.angle") * math.sin(p35 * 0.002);
        v45 = v48 + script_PsychSprite.getProperty("noteOffset" .. p34 .. ".x") * math.sin(p35 * 0.002);
        v46 = v49 + script_PsychSprite.getProperty("noteOffset" .. p34 .. ".y") * math.sin(p35 * 0.002);
        v47 = v50 + script_PsychSprite.getProperty("noteOffset" .. p34 .. ".angle") * math.sin(p35 * 0.002);
    end;

    local v51, v52, v53;

    if p34 < 4 then
        v51 = v45 + script_PsychSprite.getProperty("opponentStrumOffset.x");
        v52 = v46 + script_PsychSprite.getProperty("opponentStrumOffset.y");
        v53 = v47 + script_PsychSprite.getProperty("opponentStrumOffset.angle");

        if p35 ~= 0 then
            v51 = v51 + script_PsychSprite.getProperty("opponentNoteOffset.x");
            v52 = v52 + script_PsychSprite.getProperty("opponentNoteOffset.y");
            v53 = v53 + script_PsychSprite.getProperty("opponentNoteOffset.angle");
        end;
    else
        v51 = v45 + script_PsychSprite.getProperty("playerStrumOffset.x");
        v52 = v46 + script_PsychSprite.getProperty("playerStrumOffset.y");
        v53 = v47 + script_PsychSprite.getProperty("playerStrumOffset.angle");

        if p35 ~= 0 then
            v51 = v51 + script_PsychSprite.getProperty("playerNoteOffset.x");
            v52 = v52 + script_PsychSprite.getProperty("playerNoteOffset.y");
            v53 = v53 + script_PsychSprite.getProperty("playerNoteOffset.angle");
        end;
    end;

    if script_PsychSprite.getProperty("drunk.x") ~= 0 then
        local Property = script_PsychSprite.getProperty("drunk.x");
        local v54 = (u10 * 0.001 + p34 % 4 * 0.2 + p35 * 0.45 * 0.013888888888888888) * (script_PsychSprite.getProperty("drunkSpeed.x") * 0.2);
        v51 = v51 + Property * (math.cos(v54) * 112 * 0.5);
    end;

    if script_PsychSprite.getProperty("drunk.y") ~= 0 then
        local Property = script_PsychSprite.getProperty("drunk.y");
        local v55 = (u10 * 0.001 + p34 % 4 * 0.2 + p35 * 0.45 * 0.013888888888888888) * (script_PsychSprite.getProperty("drunkSpeed.y") * 0.2);
        v52 = v52 + Property * (math.cos(v55) * 112 * 0.5);
    end;

    if script_PsychSprite.getProperty("drunk.angle") ~= 0 then
        local Property = script_PsychSprite.getProperty("drunk.angle");
        local v56 = (u10 * 0.001 + p34 % 4 * 0.2 + p35 * 0.45 * 0.013888888888888888) * (script_PsychSprite.getProperty("drunkSpeed.angle") * 0.2);
        v53 = v53 + Property * (math.cos(v56) * 112 * 0.5);
    end;

    if script_PsychSprite.getProperty("tipsy.x") ~= 0 then
        local Property = script_PsychSprite.getProperty("tipsy.x");
        local v57 = u10 * 0.001 * 1.2 + p34 % 4 * 2 + script_PsychSprite.getProperty("tipsySpeed.x") * 0.2;
        v51 = v51 + Property * (math.cos(v57) * 112 * 0.4);
    end;

    if script_PsychSprite.getProperty("tipsy.y") ~= 0 then
        local Property = script_PsychSprite.getProperty("tipsy.y");
        local v58 = u10 * 0.001 * 1.2 + p34 % 4 * 2 + script_PsychSprite.getProperty("tipsySpeed.y") * 0.2;
        v52 = v52 + Property * (math.cos(v58) * 112 * 0.4);
    end;

    if script_PsychSprite.getProperty("tipsy.angle") ~= 0 then
        local Property = script_PsychSprite.getProperty("tipsy.angle");
        local v59 = u10 * 0.001 * 1.2 + p34 % 4 * 2 + script_PsychSprite.getProperty("tipsySpeed.angle") * 0.2;
        v53 = v53 + Property * (math.cos(v59) * 112 * 0.4);
    end;

    if script_PsychSprite.getProperty("reverse.y") ~= 0 or script_PsychSprite.getProperty("reverse" .. p34 .. ".y") ~= 0 then
        v52 = v52 + (u8 and -u4 or u4) * (script_PsychSprite.getProperty("reverse.y") + script_PsychSprite.getProperty("reverse" .. p34 .. ".y"));
        v38 = -2 * (script_PsychSprite.getProperty("reverse.y") + script_PsychSprite.getProperty("reverse" .. p34 .. ".y")) + 1;
    end;

    if script_PsychSprite.getProperty("confusion.angle") ~= 0 or script_PsychSprite.getProperty("confusion" .. p34 .. ".angle") ~= 0 then
        v36 = v36 + script_PsychSprite.getProperty("confusion.angle") + script_PsychSprite.getProperty("confusion" .. p34 .. ".angle");
    end;

    if script_PsychSprite.getProperty("waveShit.angle") ~= 0 then
        v53 = v53 + 64 * script_PsychSprite.getProperty("waveShit.angle") * -math.sin(u10 * 0.001 * 3.141592653589793 - p34);
    end;

    if script_PsychSprite.getProperty("waveShit.y") ~= 0 then
        v52 = v52 + 32 * script_PsychSprite.getProperty("waveShit.y") * math.cos(u10 * 0.001 * 3.141592653589793 - p34 % 2);
    end;

    return {
        v51,
        v52,
        v53 / 1000,
        v36,
        v37,
        v38
    };
end;

function runPosModifiers(p60, p61)
    -- upvalues: script_PsychSprite (copy), u7 (ref)
    local v62 = 0;

    if script_PsychSprite.getProperty("speed.x") ~= 1 then
        p61 = p61 * script_PsychSprite.getProperty("speed.x");
    end;

    if script_PsychSprite.getProperty("boost.y") ~= 0 then
        local v63 = -p61 / u7;
        local v64 = script_PsychSprite.getProperty("boost.y") * (v63 * 1.5 / ((v63 + 600) / 720) - v63);
        v62 = v62 - clamp(v64 * u7, -400, 400);
    end;

    if script_PsychSprite.getProperty("brake.y") ~= 0 then
        local v65 = -p61 / u7;
        local v66 = v65 * scale(v65, 0, 720, 0, 1);
        local v67 = script_PsychSprite.getProperty("brake.y") * (v66 - v65);
        v62 = v62 - clamp(v67, -400, 400) * u7;
    end;

    return p61 + v62;
end;

function getIncomingAngleX(p68, p69)
    -- upvalues: script_PsychSprite (copy)
    local Property = script_PsychSprite.getProperty("playerIncomingAngle.x");

    if p68 < 4 then
        Property = script_PsychSprite.getProperty("opponentIncomingAngle.x");
    end;

    return script_PsychSprite.getProperty("incomingAngle" .. p68 .. ".x") + script_PsychSprite.getProperty("incomingAngle.x") + Property;
end;

function getIncomingAngleY(p70, p71)
    -- upvalues: script_PsychSprite (copy)
    local Property = script_PsychSprite.getProperty("playerIncomingAngle.y");

    if p70 < 4 then
        Property = script_PsychSprite.getProperty("opponentIncomingAngle.y");
    end;

    return script_PsychSprite.getProperty("incomingAngle" .. p70 .. ".y") + script_PsychSprite.getProperty("incomingAngle.y") + Property - getNoteRotY(p70, p71);
end;

function getNoteRotX(p72, p73)
    -- upvalues: script_PsychSprite (copy)
    local Property = script_PsychSprite.getProperty("playerNoteRot.x");

    if p72 < 4 then
        Property = script_PsychSprite.getProperty("opponentNoteRot.x");
    end;

    if script_PsychSprite.getProperty("twist.x") ~= 0 then
        Property = Property + math.abs(p73) * script_PsychSprite.getProperty("twist.x") * 0.1;
    end;

    return script_PsychSprite.getProperty("noteRot" .. p72 .. ".x") + script_PsychSprite.getProperty("noteRot.x") + Property;
end;

function getNoteRotY(p74, p75)
    -- upvalues: script_PsychSprite (copy)
    local Property = script_PsychSprite.getProperty("playerNoteRot.y");

    if p74 < 4 then
        Property = script_PsychSprite.getProperty("opponentNoteRot.y");
    end;

    if script_PsychSprite.getProperty("twist.y") ~= 0 then
        Property = Property + math.abs(p75) * script_PsychSprite.getProperty("twist.y") * 0.1;
    end;

    return script_PsychSprite.getProperty("noteRot" .. p74 .. ".y") + script_PsychSprite.getProperty("noteRot.y") + Property;
end;

function getScreenRotX(p76)
    -- upvalues: script_PsychSprite (copy)
    return script_PsychSprite.getProperty("screenRot.x") % 360;
end;

function getScreenRotY(p77)
    -- upvalues: script_PsychSprite (copy)
    return script_PsychSprite.getProperty("screenRot.y") % 360;
end;

function getScaleX(p78, p79)
    -- upvalues: script_PsychSprite (copy)
    return script_PsychSprite.getProperty("scale.x") * script_PsychSprite.getProperty("scaleMulti" .. p78 .. ".x");
end;

function getScaleY(p80, p81)
    -- upvalues: script_PsychSprite (copy)
    return script_PsychSprite.getProperty("scale.y") * script_PsychSprite.getProperty("scaleMulti" .. p80 .. ".y");
end;

function getNoteDist(p82, p83, p84)
    -- upvalues: script_PsychSprite (copy)
    if script_PsychSprite.getProperty("reverse.y") ~= 0 then
        p84 = p84 * (1 - script_PsychSprite.getProperty("reverse.y") * 2);
    end;

    if script_PsychSprite.getProperty("reverse" .. p82 .. ".y") ~= 0 then
        p84 = p84 * (1 - script_PsychSprite.getProperty("reverse" .. p82 .. ".y") * 2);
    end;

    return p84 * (1 - getIncomingAngleX(p82, p83) / 180 * 2) * (1 - getIncomingAngleY(p82, p83) / 180 * 2);
end;

function GetHiddenSudden()
    -- upvalues: script_PsychSprite (copy)
    return script_PsychSprite.getProperty("hidden.alpha") * script_PsychSprite.getProperty("sudden.alpha");
end;

function GetHiddenEndLine()
    -- upvalues: script_PsychSprite (copy)
    return 360 + 60 * scale(GetHiddenSudden(), 0, 1, 1, 1.25) + 360 * script_PsychSprite.getProperty("hidden.y");
end;

function GetHiddenStartLine()
    -- upvalues: script_PsychSprite (copy)
    return 360 + 60 * scale(GetHiddenSudden(), 0, 1, 0, 0.25) + 360 * script_PsychSprite.getProperty("hidden.y");
end;

function GetSuddenEndLine()
    -- upvalues: script_PsychSprite (copy)
    return 360 + 60 * scale(GetHiddenSudden(), 0, 1, 0, 0.25) + 360 * script_PsychSprite.getProperty("sudden.y");
end;

function GetSuddenStartLine()
    -- upvalues: script_PsychSprite (copy)
    return 360 + 60 * scale(GetHiddenSudden(), 0, 1, 1, 1.25) + 360 * script_PsychSprite.getProperty("sudden.y");
end;

function onCreatePost()
    -- upvalues: u8 (ref), u4 (ref), u3 (ref)
    setupModifiers();

    if u8 then
        u4 = -450;
    end;

    u3 = true;

    if u3 then
    end;
end;

local u113 = {
    resetX = function(p85, p86) -- Line: 469
        resetX(tonumber(p85), p86);
    end,

    resetY = function(p87, p88) -- Line: 472
        resetY(tonumber(p87), p88);
    end,

    resetZ = function(p89, p90) -- Line: 475
        resetZ(tonumber(p89), p90);
    end,

    invert = function(p91, p92) -- Line: 478
        invert(tonumber(p91), p92);
    end,

    flip = function(p93, p94) -- Line: 481
        flip(tonumber(p93), p94);
    end,

    easeModifierX = function(p95, p96) -- Line: 484
        -- upvalues: u2 (copy)
        local v97 = p95:split(",");
        local v98 = p96:split(",");
        u2.doTweenX(v97[1] .. ".x", v97[1], tonumber(v97[2]), tonumber(v98[1]), v98[2]);
    end,

    easeModifierY = function(p99, p100) -- Line: 489
        -- upvalues: u2 (copy)
        local v101 = p99:split(",");
        local v102 = p100:split(",");
        u2.doTweenY(v101[1] .. ".y", v101[1], tonumber(v101[2]), tonumber(v102[1]), v102[2]);
    end,

    easeModifierZ = function(p103, p104) -- Line: 494
        -- upvalues: u2 (copy)
        local v105 = p103:split(",");
        local v106 = p104:split(",");
        u2.doTweenAngle(v105[1] .. ".z", v105[1], tonumber(v105[2]), tonumber(v106[1]), v106[2]);
    end,

    setModifierX = function(p107, p108) -- Line: 499
        -- upvalues: setProperty (copy)
        setProperty(p107 .. ".x", (tonumber(p108)));
    end,

    setModifierY = function(p109, p110) -- Line: 502
        -- upvalues: setProperty (copy)
        setProperty(p109 .. ".y", (tonumber(p110)));
    end,

    setModifierZ = function(p111, p112) -- Line: 505
        -- upvalues: setProperty (copy)
        setProperty(p111 .. ".angle", (tonumber(p112)));
    end
};

function onEvent(p114, p115, p116)
    -- upvalues: u113 (copy)
    local v117 = u113[p114];

    if v117 then
        v117(p115, p116);
    end;
end;

function resetX(p118, p119)
    -- upvalues: u2 (copy)
    for i = 0, 7 do
        u2.doTweenX(i .. "x", "strumOffset" .. i, 0, p118, p119);
        local _ = i;
    end;
end;

function resetY(p120, p121)
    -- upvalues: u2 (copy)
    for i = 0, 7 do
        u2.doTweenY(i .. "y", "strumOffset" .. i, 0, p120, p121);
        local _ = i;
    end;
end;

function resetZ(p122, p123)
    -- upvalues: u2 (copy)
    for i = 0, 7 do
        u2.doTweenAngle(i .. "z", "strumOffset" .. i, 0, p122, p123);
        local _ = i;
    end;
end;

function invert(p124, p125)
    -- upvalues: u2 (copy)
    for i = 0, 7 do
        u2.doTweenX(i .. "x", "strumOffset" .. i, (i % 2 == 0 and 1 or -1) * 112, p124, p125);
        local _ = i;
    end;
end;

function flip(p126, p127)
    -- upvalues: u2 (copy)
    u2.doTweenX("0x", "strumOffset0", 336, p126, p127);
    u2.doTweenX("1x", "strumOffset1", 112, p126, p127);
    u2.doTweenX("2x", "strumOffset2", -112, p126, p127);
    u2.doTweenX("3x", "strumOffset3", -336, p126, p127);
    u2.doTweenX("4x", "strumOffset4", 336, p126, p127);
    u2.doTweenX("5x", "strumOffset5", 112, p126, p127);
    u2.doTweenX("6x", "strumOffset6", -112, p126, p127);
    u2.doTweenX("7x", "strumOffset7", -336, p126, p127);
end;

function u2.onUpdatePost(p128) -- Line: 557
    -- upvalues: u3 (ref), u5 (copy), u6 (ref), u12 (ref), Api (copy), u13 (ref), u10 (ref), u7 (ref), u11 (ref), u9 (ref), u8 (ref), script_PsychSprite (copy)
    if not u3 then
        return;
    end;

    u5.Notes = shared.getNotes();
    local v129 = #u5.Notes;
    u6 = u5.Conductor.bpm;
    u12 = u5.Conductor.crochet / Api.playbackRate;
    u13 = u5.Conductor.stepCrochet;
    u10 = getSongPosition();
    u7 = Api.songSpeed;
    u11 = u7;
    u9 = u5.Settings.Middlescroll;
    u8 = u5.Settings.Downscroll;

    for i = 0, 7 do
        setupStrumPosition(i);
        local _ = i;
    end;

    for i = 1, v129 do
        setupNotePosition(i);
        local _ = i;
    end;

    Api.setProperty("camHUD.angle", script_PsychSprite.getProperty("camHUD.angle"));
    Api.setProperty("camGame.angle", script_PsychSprite.getProperty("camGame.angle"));
end;

function clamp(p130, p131, p132)
    if p130 < p131 then
        return p131;
    end;

    if p132 >= p130 then
        p132 = p130;
    end;

    return p132;
end;

function scale(p133, p134, p135, p136, p137)
    return (p137 - p136) * (p133 - p134) / (p135 - p134) + p136;
end;

function getNoteRot(p138, p139, p140, p141)
    local v142 = getCartesianCoords3D(getNoteRotX(p138, p139), 90, p140 - 640);
    local v143 = v142[1] + 640;
    local v144 = getCartesianCoords3D(90, getNoteRotY(p138, p139), p141 - 360);

    return { v143, v144[2] + 360, -1 + v142[3] + v144[3] };
end;

function calculatePerspective(p145, p146, p147, p148)
    local v149 = p147 + -0;

    return { (p145 - 640 + 56 + p148 / (1 / -v149)) * 1.0000000000000002 / -v149 + 640 - 56, (p146 - 360 + 56) / 1.0000000000000002 / -v149 + 360 - 56, v149 };
end;

function getCartesianCoords3D(p150, p151, p152)
    local v153 = math.cos(p150 * 0.017453292519943295) * math.sin(p151 * 0.017453292519943295);
    local math_cos_ret = math.cos(p151 * 0.017453292519943295);
    local v154 = math.sin(p150 * 0.017453292519943295) * math.sin(p151 * 0.017453292519943295);

    return { v153 * p152, math_cos_ret * p152, v154 * p152 / 1000 };
end;

function setupStrumPosition(p155)
    -- upvalues: u14 (copy), u9 (ref), Api (copy), u5 (copy), u10 (ref)
    local v156 = getNoteRot(p155, 0, u14[p155 + 1].X, u14[p155 + 1].Y);
    local v157 = v156[1];
    local v158 = v156[2];
    local v159 = v156[3];
    local v160 = runModifiers(p155, 0);
    local v161 = v157 + v160[1];
    local v162 = v158 + v160[2];
    local v163 = v159 + v160[3];
    local v164 = v160[4];
    local v165 = (Api.side == "L" and getAlpha(p155 % 4 + ((p155 < 4 and "L" or "R") == "R" and 4 or 0)) or v160[5]) * (p155 < 4 and u9 and 0.35 or 1);
    local v166 = calculatePerspective(v161, v162, v163, 0);
    local v167 = v166[3];
    setPropertyFromGroup(u5.Strums, p155, "x", v166[1]);
    setPropertyFromGroup(u5.Strums, p155, "y", v166[2]);
    setPropertyFromGroup(u5.Strums, p155, "angle", v164);

    if u10 > 0 then
        setPropertyFromGroup(u5.Strums, p155, "alpha", v165);
    end;

    setPropertyFromGroup(u5.Strums, p155, "scale.x", getScaleX(p155, 0) * (1 / -v167));
    setPropertyFromGroup(u5.Strums, p155, "scale.y", getScaleY(p155, 0) * (1 / -v167));
end;

function setupNotePosition(p168)
    -- upvalues: u5 (copy), u10 (ref), u7 (ref)
    getPropertyFromGroup(u5.Notes, p168, "sustainNote");
    local v169 = getPropertyFromGroup(u5.Notes, p168, "noteData");

    if getPropertyFromGroup(u5.Notes, p168, "side") == "R" then
        v169 = v169 + 4;
    end;

    local v170 = (u10 - getPropertyFromGroup(u5.Notes, p168, "strumTime")) * u7;
    local v171 = getNoteDist(v169, v170, 1);
    setPropertyFromGroup(u5.Notes, p168, "multSpeed", v171);
end;

function getObject(p172)
    -- upvalues: script_PsychSprite (copy)
    return script_PsychSprite.objects[p172];
end;

function splitTitleCaps(p173)
    local v174 = p173:gsub("(%u)", " %1"):gsub("^%s", "");

    return string.split(v174, " ");
end;

function firstToUpper(p175)
    return p175:gsub("^%l", string.upper);
end;

function getTweenStyle(p176)
    local v177 = splitTitleCaps(p176);

    if #v177 == 0 then
        return Enum.EasingStyle.Linear;
    end;

    local v178 = firstToUpper(v177[1]);

    return Enum.EasingStyle[v178];
end;

function getTweenDir(p179)
    local v180 = splitTitleCaps(p179);

    if #v180 <= 1 then
        return Enum.EasingDirection.InOut;
    end;

    local table_concat_ret = table.concat(v180, "", 2, #v180);

    return Enum.EasingDirection[table_concat_ret];
end;

function u2.doTweenX(p181, p182, p183, p184, p185, p186, p187, p188) -- Line: 753
    -- upvalues: u1 (copy), VarTweener (copy), u12 (ref)
    u1[p181] = VarTweener:Create(getObject(p182), TweenInfo.new(u12 * 0.001 * p184, getTweenStyle(p185), getTweenDir(p185), p186 or 0, p187 or false, p188 or 0), {
        x = p183
    });
    u1[p181]:Play();
end;

function u2.doTweenY(p189, p190, p191, p192, p193, p194, p195, p196) -- Line: 758
    -- upvalues: u1 (copy), VarTweener (copy), u12 (ref)
    u1[p189] = VarTweener:Create(getObject(p190), TweenInfo.new(u12 * 0.001 * p192, getTweenStyle(p193), getTweenDir(p193), p194 or 0, p195 or false, p196 or 0), {
        y = p191
    });
    u1[p189]:Play();
end;

function u2.doTweenZ(p197, p198, p199, p200, p201, p202, p203, p204) -- Line: 763
    -- upvalues: u1 (copy), VarTweener (copy), u12 (ref)
    u1[p197] = VarTweener:Create(getObject(p198), TweenInfo.new(u12 * 0.001 * p200, getTweenStyle(p201), getTweenDir(p201), p202 or 0, p203 or false, p204 or 0), {
        angle = p199
    });
    u1[p197]:Play();
end;

function u2.doTweenAngle(p205, p206, p207, p208, p209, p210, p211, p212) -- Line: 768
    -- upvalues: u1 (copy), VarTweener (copy), u12 (ref)
    u1[p205] = VarTweener:Create(getObject(p206), TweenInfo.new(u12 * 0.001 * p208, getTweenStyle(p209), getTweenDir(p209), p210 or 0, p211 or false, p212 or 0), {
        angle = p207
    });
    u1[p205]:Play();
end;

function u2.doTweenAlpha(p213, p214, p215, p216, p217, p218, p219, p220) -- Line: 773
    -- upvalues: u1 (copy), VarTweener (copy), u12 (ref)
    u1[p213] = VarTweener:Create(getObject(p214), TweenInfo.new(u12 * 0.001 * p216, getTweenStyle(p217), getTweenDir(p217), p218 or 0, p219 or false, p220 or 0), {
        alpha = p215
    });
    u1[p213]:Play();
end;

return u2;