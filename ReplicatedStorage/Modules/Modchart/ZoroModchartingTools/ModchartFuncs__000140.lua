-- Decompiled with Potassium's decompiler.

local u1 = {};
local Modifiers = require(script.Parent.Modifiers);
local u2 = nil;

function u1.Init(p3) -- Line: 27
    -- upvalues: u2 (ref)
    u2 = p3.Conductor;
end;

function u1.new(p4) -- Line: 31
    -- upvalues: u1 (copy)
    local v5 = setmetatable({
        renderer = p4
    }, {
        __index = u1
    });
    v5.api = v5:createApi();

    return v5;
end;

function u1.createApi(u6) -- Line: 40
    return {
        startMod = function(p7: string, p8: string, p9: string, p10: number) -- Line: 43, Name: startMod
            -- upvalues: u6 (copy)
            return u6:startMod(p7, p8, p9 or "", tonumber(p10) or -1);
        end,

        setMod = function(p11: string, p12: number) -- Line: 47, Name: setMod
            -- upvalues: u6 (copy)
            return u6:setMod(p11, p12);
        end,

        setSubMod = function(p13: string, p14: string, p15: number) -- Line: 51, Name: setSubMod
            -- upvalues: u6 (copy)
            return u6:setSubMod(p13, p14, p15);
        end,

        setModTargetLane = function(p16: string, p17: number) -- Line: 55, Name: setModTargetLane
            -- upvalues: u6 (copy)
            return u6:setModTargetLane(p16, p17);
        end,

        setModPlayfield = function(p18: string, p19: number) -- Line: 59, Name: setModPlayfield
            -- upvalues: u6 (copy)
            return u6:setModPlayfield(p18, p19);
        end,

        addPlayfield = function(p20: number?, p21: number?, p22: number?, p23: number?) -- Line: 63, Name: addPlayfield
            -- upvalues: u6 (copy)
            return u6:addPlayfield(p20 or 0, p21 or 0, p22 or 0, p23 or 1);
        end,

        removePlayfield = function(p24: number) -- Line: 67, Name: removePlayfield
            -- upvalues: u6 (copy)
            return u6:removePlayfield(p24);
        end,

        tweenModifier = function(p25: string, p26: number, p27: number, p28: string) -- Line: 71, Name: tweenModifier
            -- upvalues: u6 (copy)
            return u6:tweenModifier(p25, p26, p27, p28);
        end,

        tweenModifierSubValue = function(p29: string, p30: string, p31: number, p32: number, p33: string) -- Line: 75, Name: tweenModifierSubValue
            -- upvalues: u6 (copy)
            return u6:tweenModifierSubValue(p29, p30, p31, p32, p33);
        end,

        setModEaseFunc = function(p34: string, p35: string) -- Line: 79, Name: setModEaseFunc
            -- upvalues: u6 (copy)
            return u6:setModEaseFunc(p34, p35);
        end,

        set = function(p36: number, p37: string) -- Line: 83, Name: set
            -- upvalues: u6 (copy)
            return u6:set(p36, p37);
        end,

        ease = function(p38: number, p39: number, p40: string, p41: string) -- Line: 87, Name: ease
            -- upvalues: u6 (copy)
            return u6:ease(p38, p39, p40, p41);
        end
    };
end;

function u1.startMod(p42: table, p43: userdata, p44: userdata, p45: userdata, p46: userdata) -- Line: 94
    -- upvalues: Modifiers (copy)
    local v47 = p45 or "";
    local v48 = p46 or -1;
    local v49 = p42.renderer.customModifiers[p44];

    if v49 then
        local v50 = Modifiers.Modifier.new(p43, getModTypeFromString(v47), v48);

        if v49.initMod then
            v49.initMod(v50);
        end;

        p42.renderer.modifierTable:add(v50);

        return v49;
    end;

    local v51 = Modifiers[p44] or Modifiers[p44 .. "Modifier"];

    if v51 then
        local v52 = v51.new(p43, getModTypeFromString(v47), v48);
        p42.renderer.modifierTable:add(v52);

        return v52;
    end;
end;

function u1.setMod(p53: table, p54: string, p55: number) -- Line: 135
    local v56 = p53.renderer.modifierTable.modifiers[p54];

    if v56 then
        v56.currentValue = p55;
    end;
end;

function u1.setSubMod(p57: table, p58: string, p59: string, p60: number) -- Line: 146
    local v61 = p57.renderer.modifierTable.modifiers[p58];

    if v61 then
        v61.subValues[p59].value = p60;
    end;
end;

function u1.setModTargetLane(p62: table, p63: string, p64: number) -- Line: 157
    local v65 = p62.renderer.modifierTable.modifiers[p63];

    if v65 then
        v65.targetLane = p64;
    end;
end;

function u1.addPlayfield(p66: table, p67: number?, p68: number?, p69: number?, p70: number?) -- Line: 168
    p66.renderer:addNewPlayfield(p67, p68, p69, p70);
end;

function u1.removePlayfield(p71: table, p72: number) -- Line: 172
    table.remove(p71.renderer.playfields, p72);
end;

function u1.tweenModifier(p73: table, p74: string, p75: number, p76: number, p77: string) -- Line: 176
    -- upvalues: Modifiers (copy)
    p73.renderer.modifierTable:tweenModifier(p74, p75, p76, p77, Modifiers.Modifier.beat);
end;

function u1.tweenModifierSubValue(p78: table, p79: string, p80: string, p81: number, p82: number, p83: string) -- Line: 180
    -- upvalues: Modifiers (copy)
    p78.renderer.modifierTable:tweenModifierSubValue(p79, p80, p81, p82, p83, Modifiers.Modifier.beat);
end;

function u1.setModEaseFunc(p84: table, p85: string, p86: string) -- Line: 184
    local v87 = p84.renderer.modifierTable.modifiers[p85];

    if v87 and v87.setEase then
        v87:setEase(p86);
    end;
end;

function u1.set(u88: table, p89: number, p90: string) -- Line: 191
    local v91 = p90:gsub(" ", ""):split(",");
    u88.renderer.eventManager:addEvent(p89, function(p92: table) -- Line: 198
        -- upvalues: u88 (copy)
        for i = 1, #p92 // 2 do
            local v93 = (i - 1) * 2 + 1;
            local v94 = p92[v93 + 1]:gsub(" ", ""):gsub("\n", "");
            local v95 = tonumber(p92[v93]);

            if not v95 or v95 ~= v95 then
                warn("Non valid value");
                v95 = 0;
            end;

            local v96 = u88.renderer.modifierTable.modifiers[v94];
            local v97;

            if v96 then
                v96.currentValue = v95;
                v97 = i;
            else
                local v98 = v94:split(":");

                if #v98 > 1 then
                    local v99 = v98[1]:gsub(" ", ""):gsub("\n", "");
                    local v100 = v98[2]:gsub(" ", ""):gsub("\n", "");
                    local v101 = u88.renderer.modifierTable.modifiers[v99];

                    if v101 then
                        v101.subValues[v100].value = v95;
                        v97 = i;
                    else
                        v97 = i;
                    end;
                else
                    v97 = i;
                end;
            end;
        end;
    end, v91);
end;

function u1.ease(u102: table, u103: number, p104: number?, u105: string, p106: string) -- Line: 238
    -- upvalues: u2 (ref)
    local u107 = (not p104 or p104 ~= p104) and 1 or p104;
    local v108 = p106:gsub(" ", ""):split(",");
    u102.renderer.eventManager:addEvent(u103, function(p109: table) -- Line: 249
        -- upvalues: u102 (copy), u107 (ref), u2 (ref), u105 (copy), u103 (copy)
        for i = 1, #p109 // 2 do
            local v110 = (i - 1) * 2 + 1;
            local v111 = p109[v110 + 1]:gsub(" ", ""):gsub("\n", "");
            local v112 = tonumber(p109[v110]);
            local v113 = (not v112 or v112 ~= v112) and 0 or v112;
            local v114 = v111:split(":");
            local v115;

            if #v114 > 1 then
                local v116 = v114[2];
                local v117 = v114[1]:gsub(" ", ""):gsub("\n", "");
                local v118 = v116:gsub(" ", ""):gsub("\n", "");
                u102.renderer.modifierTable:tweenModifierSubValue(v117, v118, v113, u107 * u2.crochet * 0.001, u105, u103);
                v115 = i;
            else
                u102.renderer.modifierTable:tweenModifier(v111, v113, u107 * u2.crochet * 0.001, u105, u103);
                v115 = i;
            end;
        end;
    end, v108);
end;

function u1.setModPlayfield(p119: table, p120: string, p121: number) -- Line: 281
    local v122 = p119.renderer.modifierTable.modifiers[p120];

    if v122 then
        v122.playfield = p121;
    end;
end;

local ModifierType = Modifiers.ModifierType;

function getModTypeFromString(p123: userdata)
    -- upvalues: ModifierType (copy)
    if string.lower(p123) == "player" then
        return ModifierType.PLAYERONLY;
    end;

    if string.lower(p123) == "opponent" then
        return ModifierType.OPPONENTONLY;
    end;

    if string.lower(p123) == "lane" or string.lower(p123) == "lanespecific" then
        return ModifierType.LANESPECIFIC;
    end;

    return ModifierType.ALL;
end;

return u1;