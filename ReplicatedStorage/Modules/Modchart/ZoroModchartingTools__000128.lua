-- Decompiled with Potassium's decompiler.

local script_PlayfieldRenderer = require(script.PlayfieldRenderer);
local u1 = nil;
local script_NoteMovement = require(script.NoteMovement);

function init(p2)
    -- upvalues: u1 (ref), script_PlayfieldRenderer (copy), script_NoteMovement (copy)
    u1 = script_PlayfieldRenderer.new(p2);
    p2.setSetting(nil, "Middlescroll", false);
    p2.recalculateStrums(true);
    script_NoteMovement:getDefaultStrumPos(p2);

    return u1:getApi();
end;

return {
    init = init,

    getApi = function() -- Line: 23, Name: getApi
        -- upvalues: u1 (ref)
        if u1 then
            return u1:getApi();
        end;
    end,

    update = function(p3) -- Line: 27, Name: update
        -- upvalues: u1 (ref)
        if u1 then
            u1:update(p3);
        end;
    end,

    clear = function() -- Line: 31, Name: clear
        -- upvalues: u1 (ref)
        u1 = nil;
    end,

    addCustomModifier = function(p4, p5) -- Line: 35, Name: addCustomModifier
        -- upvalues: u1 (ref)
        if u1 then
            u1:addCustomModifier(p4, p5);
        end;
    end,

    loadJson = function(p6) -- Line: 41, Name: loadJson
        -- upvalues: u1 (ref)
        if not u1 then
            init();
        end;

        local Api = u1:getApi();

        if typeof(p6) == "Instance" then
            p6 = require(p6) or p6;
        end;

        local v7 = game:GetService("HttpService"):JSONDecode(p6);

        if v7.playfields then
            for i = 1, v7.playfields - 1 do
                Api.addPlayfield(0, 0, 0, 1);
                local _ = i;
            end;
        end;

        if v7.modifiers then
            for _, v in v7.modifiers do
                local v8 = Api.startMod(unpack(v, 1, 4));

                if tonumber(v[5]) and v8 then
                    v8.targetLane = tonumber(v[5]);
                end;
            end;

            u1.modifierTable:reconstructTable();
        end;

        local u13 = {
            ease = function(p9, p10) -- Line: 66, Name: ease
                -- upvalues: Api (copy)
                Api.ease(p9[2][1] + p10, p9[2][2], p9[2][3], p9[2][4]);
            end,

            set = function(p11, p12) -- Line: 69, Name: set
                -- upvalues: Api (copy)
                Api.set(p11[2][1] + p12, p11[2][2]);
            end
        };

        local function makeEvent(p14, p15) -- Line: 74
            -- upvalues: u13 (copy)
            (u13[p14[1]] or function() -- Line: 76
            end)(p14, p15 or 0);
        end;

        if v7.events then
            for _, v in v7.events do
                if v[3] == nil then
                    v[3] = { false, 1, 0 };
                end;

                if v[3][1] then
                    local v16 = v;

                    for i = 0, v[3][2] do
                        (u13[v16[1]] or function() -- Line: 76
                        end)(v16, i * v16[3][3] or 0);
                        local _ = i;
                    end;
                else
                    (u13[v[1]] or function() -- Line: 76
                    end)(v, nil or 0);
                end;
            end;
        end;
    end
};