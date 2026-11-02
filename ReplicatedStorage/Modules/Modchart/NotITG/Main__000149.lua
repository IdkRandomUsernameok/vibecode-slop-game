-- Decompiled with Potassium's decompiler.

local Modules = game:GetService("ReplicatedStorage"):FindFirstChild("Modules");
local VarTweener = require(Modules.Main.VarTweener);
require(Modules.Main.Sprite);
local script_Utils = require(script.Utils);
local u1 = nil;
local u2 = {
    BEAT = 0,
    STEP = 0,
    ARROW_SIZE = 108.5
};
local u3 = {};
local u4 = {};
local u5 = {};

function getBaseX(p6, p7, p8)
    -- upvalues: u4 (copy), u2 (copy)
    local v9 = #u4;
    local v10 = 1280 / v9;

    return v10 * (v9 - 1 - ((v9 <= p7 or p7 < 0) and 0.5 or p7)) + (v10 - u2.ARROW_SIZE * (p8 == nil and 4 or p8)) * 0.5 + u2.ARROW_SIZE * p6;
end;

function getBaseVisPosD(p11, p12)
    return 0.45 * p11 * (p12 or 1);
end;

function updateObject(p13, p14, p15, p16)
    -- upvalues: u2 (copy), u1 (ref)
    local v17 = {
        x = 0,
        y = 0,
        angle = 0,
        alpha = 1,
        scaleX = 1,
        scaleY = 1,
        scrollSpeed = 1
    };

    if not p15.Modifiers then
        print("Invalid modifier list on strumline " .. p15.ID);

        return;
    end;

    for _, v in p15.Modifiers do
        if v.Update ~= nil and (v.Get(p14) ~= 0 and (v.OnlyNotes == nil or (v.OnlyNotes ~= true or p16))) and (v.OnlyReceptors == nil or (v.OnlyReceptors ~= true or not p16)) then
            local Update = v.Update;
            local Modifiers = p15.Modifiers;
            local v18 = {
                Y_OFFSET = p16 == nil and 0 or p13.y - p16.y,
                COLUMN = p14,
                OBJECT = p13,
                IS_STRUM = p16 == nil
            };
            local v19;

            if p16 == nil then
                v19 = nil;
            else
                v19 = p13.sustainNote or nil;
            end;

            v18.IS_SUSTAIN = v19;
            v18.STRUMLINE_ID = p15.ID;
            v18.BEAT = u2.BEAT;
            v18.STEP = u2.STEP;
            v18.CONDUCTOR = u1.Conductor;
            v18.ARROW_SIZE = u2.ARROW_SIZE;
            v18.SONG_POSITION = u1.Conductor.songPosition;
            v18.RECEPTOR_Y = p16 and (p16.y or 0) or 0;
            local v20 = Update(v17, Modifiers, v18);

            if v20 ~= nil then
                v17 = v20;
            end;
        end;
    end;

    if u1.getSetting(p15.Origin.Side, "Downscroll") then
        v17.y = -v17.y;
    end;

    if p16 then
        if p13.sustainNote then
            local v21 = (p13.strumTime or 0) + (p13.susLength or 0);
            local v22 = -getBaseVisPosD(u1.Conductor.songPosition - v21, u1.Conductor.songSpeed or 1);
            local v23 = {
                x = 0,
                y = 0,
                angle = 0,
                alpha = 1,
                scaleX = 1,
                scaleY = 1,
                scrollSpeed = 1
            };

            for _, v in p15.Modifiers do
                if v.Update ~= nil and (v.Get(p14) ~= 0 and v.OnlyReceptors ~= true) then
                    local v24 = v.Update(v23, p15.Modifiers, {
                        IS_STRUM = false,
                        IS_SUSTAIN = true,
                        Y_OFFSET = v22,
                        COLUMN = p14,
                        OBJECT = p13,
                        STRUMLINE_ID = p15.ID,
                        BEAT = u2.BEAT,
                        STEP = u2.STEP,
                        CONDUCTOR = u1.Conductor,
                        ARROW_SIZE = u2.ARROW_SIZE,
                        SONG_POSITION = v21,
                        RECEPTOR_Y = p16 and (p16.y or 0) or 0
                    });

                    if v24 ~= nil then
                        v23 = v24;
                    end;
                end;
            end;

            if u1.getSetting(p15.Origin.Side, "Downscroll") then
                v23.y = -v23.y;
            end;

            local v25 = v23.x - v17.x;
            local v26 = v23.y - v17.y;
            v17.angle = math.atan2(v26, v25) * 57.29577951308232 - 90;
            local math_sqrt_ret = math.sqrt(v25 * v25 + v26 * v26);

            if math_sqrt_ret > 0 then
                p13.offsets.set("SusLength", "modchartManager_SusLength", math_sqrt_ret);
            end;
        end;
    else
        p13.laneSpeed = v17.scrollSpeed;
    end;

    local Vector2_new_ret = Vector2.new(v17.scaleX, v17.scaleY);
    p13.offsets.set("Scale", "modchartManager_Scale", Vector2_new_ret);

    for i, v in v17 do
        if not i:match("scale") then
            p13.offsets.set(i, "modchartManager_" .. i, v);
        end;
    end;
end;

function addModifier(p27: table, p28: string, p29: any, p30: boolean?)
    if p27[p28] ~= nil then
        print("Modifier with the name " .. p28 .. "already exists!");

        if p30 == false then
            return;
        end;
    end;

    p27[p28] = p29;
end;

local u31 = false;

return {
    preCreate = function(p32, p33) -- Line: 246, Name: preCreate
        -- upvalues: u1 (ref)
        u1 = p32;
        p32.setSimpleSustains(false);
    end,

    onLoad = function() -- Line: 250, Name: onLoad
        -- upvalues: u4 (copy)
        for i, v in shared.getStrumlines() do
            u4[i] = {
                ID = i,
                Strums = v.Strums,
                Origin = v,
                Proxies = {},
                Modifiers = {}
            };
            local v34 = i;

            for _, child in script.Modifiers:GetChildren() do
                local v35 = child:Clone();
                local v36 = require(v35);
                local Name = child.Name;

                if typeof(v36) == "table" then
                    if v36.Update then
                        addModifier(u4[v34].Modifiers, Name, v36, false);
                    else
                        for i2, v2 in v36 do
                            addModifier(u4[v34].Modifiers, i2, v2, false);
                        end;
                    end;
                end;
            end;
        end;
    end,

    onUpdatePost = function(p37: number) -- Line: 279, Name: onUpdatePost
        -- upvalues: u2 (copy), u1 (ref), u31 (ref), u5 (copy), u4 (copy), VarTweener (copy)
        u2.STEP = u1.Conductor.DecimalStep;
        u2.BEAT = u1.Conductor.DecimalBeat;

        if u31 then
            if #u5 > 1 then
                table.sort(u5, function(p38, p39) -- Line: 285
                    if p38.Time == p39.Time then
                        return p38.Tick < p39.Tick;
                    end;

                    return p38.Time < p39.Time;
                end);

                for i, _ in shared.getStrumlines() do
                    local v40 = i;
                    local v41 = {};

                    for _, v in u5 do
                        if v.StrumlineID == v40 and not u4[v40].Modifiers[v.Modifier] then
                            table.insert(v41, v);
                        end;
                    end;

                    for _, v in v41 do
                        print("Invalid modifier -", v.Modifier);
                        table.remove(u5, table.find(u5, v));
                    end;
                end;
            end;

            u31 = false;
        end;

        for _, v in u5 do
            if u2.STEP < v.Time then
                break;
            end;

            local v42 = {};
            local v43;

            if v.StrumlineID == nil or (v.StrumlineID < 0 or not u4[v.StrumlineID]) then
                v43 = v;

                for _, v2 in u4 do
                    table.insert(v42, v2);
                end;
            else
                table.insert(v42, u4[v.StrumlineID]);
                v43 = v;
            end;

            if #v42 > 0 then
                for _, v2 in v42 do
                    local u44 = v2.Modifiers[v43.Modifier];

                    if u44 == nil then
                        print("Invalid modifier -", v43.Modifier);
                    elseif v43.Type == "Ease" then
                        if v43.Easing ~= nil and v43.EndTime ~= nil then
                            local v45 = math.abs(v43.EndTime - v43.Time) * (u1.Conductor.StepCrochet / 1000);
                            local TweenInfo_new_ret = TweenInfo.new(v45, u1.getTweenStyle(v43.Easing), u1.getTweenDir(v43.Easing));

                            if u44.TweenID == nil then
                                u44.TweenID = 0;
                            else
                                u44.TweenID = u44.TweenID + 1;
                            end;

                            local TweenID = u44.TweenID;
                            local u46 = nil;
                            u46 = VarTweener:CreateValueTween(u44.Get(), v43.Value, TweenInfo_new_ret, function(p47) -- Line: 347
                                -- upvalues: u44 (copy), TweenID (copy), u46 (ref)
                                if u44.TweenID == TweenID then
                                    u44.Set(p47);

                                    return;
                                end;

                                u46:Pause();
                            end);
                            u46:Play();
                        end;
                    elseif v43.Type == "Set" then
                        if u44.TweenID == nil then
                            u44.TweenID = 0;
                        else
                            u44.TweenID = u44.TweenID + 1;
                        end;

                        u44.Set(v43.Value);
                    end;
                end;
            else
                print("No valid strumlines found!");
            end;

            local table_find_ret = table.find(u5, v43);

            if table_find_ret then
                table.remove(u5, table_find_ret);
            end;
        end;

        for _, v in u4 do
            local v48 = v;

            for _, v2 in v.Strums do
                updateObject(v2, v2.lane, v48, nil);
            end;

            for _, v2 in v48.Origin.Notes do
                updateObject(v2, v2.column, v48, v48.Strums[v2.column]);
            end;
        end;
    end,

    initPlayfield = function(p49: number?) -- Line: 385, Name: initPlayfield
        -- upvalues: u4 (copy)
        local v50 = p49 or #u4 + 1;

        for _, v in u4 do
            if v.ID == v50 then
                return v;
            end;
        end;

        return nil;
    end,

    defineMod = function(u51, p52) -- Line: 398, Name: defineMod
        -- upvalues: u4 (copy), u3 (copy)
        for _, v in u4 do
            u3[v.ID][u51] = 0;

            function p52.Get() -- Line: 402
                -- upvalues: u3 (ref), v (copy), u51 (copy)
                return u3[v.ID][u51];
            end;

            function p52.Set(p53) -- Line: 403
                -- upvalues: u3 (ref), v (copy), u51 (copy)
                u3[v.ID][u51] = p53;
            end;

            addModifier(u4[v.ID], u51, p52, true);
        end;
    end,

    setValue = function(p54: string, p55: number, p56: number?) -- Line: 408, Name: setValue
        -- upvalues: u5 (copy), script_Utils (copy), u31 (ref)
        local v57 = {
            Type = "Set",
            Time = 0,
            Easing = nil,
            Modifier = script_Utils.firstToUpper(p54),
            Value = p55,
            StrumlineID = p56,
            Tick = tick()
        };
        table.insert(u5, v57);
        u31 = true;
    end,

    setModifier = function(p58: number, p59: string, p60: number, p61: number?) -- Line: 423, Name: setModifier
        -- upvalues: u5 (copy), script_Utils (copy), u31 (ref)
        local v62 = {
            Type = "Set",
            Easing = nil,
            Time = p58,
            Modifier = script_Utils.firstToUpper(p59),
            Value = p60,
            StrumlineID = p61,
            Tick = tick()
        };
        table.insert(u5, v62);
        u31 = true;
    end,

    easeModifier = function(p63: number, p64: number, p65: string, p66: number, p67: string, p68: number?) -- Line: 438, Name: easeModifier
        -- upvalues: u5 (copy), script_Utils (copy), u31 (ref)
        local v69 = {
            Type = "Ease",
            Time = p63,
            EndTime = p64,
            Modifier = script_Utils.firstToUpper(p65),
            Value = p66,
            Easing = p67,
            StrumlineID = p68,
            Tick = tick()
        };
        table.insert(u5, v69);
        u31 = true;
    end,

    clearUp = function() -- Line: 455, Name: clearUp
        -- upvalues: u5 (copy), u4 (copy)
        table.clear(u5);
        table.clear(u4);
    end
};