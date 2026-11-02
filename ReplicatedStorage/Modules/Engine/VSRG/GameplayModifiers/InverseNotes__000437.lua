-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();
local VarTweener = require(game:GetService("ReplicatedStorage").Modules.Main.VarTweener);
local u1 = {
    curVal = 0
};

local function lerp(p2, p3, p4) -- Line: 8
    return p2 + (p3 - p2) * p4;
end;

local u5 = false;
local u6 = {};

return {
    onCreate = function() -- Line: 17, Name: onCreate
        -- upvalues: Api (copy), u6 (copy), u1 (copy)
        for _, v in Api.StrumLines do
            if v.KeyCount == 1 then
                u6[v][0] = {
                    x = 0,
                    y = 0
                };
            else
                u6[v] = {};
                local v7 = v;

                for i, v2 in v.Strums do
                    local u8 = {
                        x = 0,
                        y = 0
                    };
                    u6[v7][i] = u8;
                    local u9 = v7.Strums[v7.KeyCount - 1 - i];
                    local GetProperty = v2.GetProperty;

                    function v2.GetProperty(p10, p11, ...) -- Line: 28
                        -- upvalues: GetProperty (copy), v2 (copy), u9 (copy), u1 (ref), u8 (copy)
                        local v12 = GetProperty(v2, p11, ...);

                        if p11 ~= "x" and p11 ~= "y" then
                            return v12;
                        end;

                        local v13 = v12 + (GetProperty(u9, p11, ...) - v12) * u1.curVal;
                        u8[p11] = v12 - v13;

                        return v13;
                    end;
                end;
            end;
        end;
    end,

    onSpawnNote = function(p14) -- Line: 45, Name: onSpawnNote
        -- upvalues: u6 (copy)
        local u15 = u6[p14.strumLine][p14.noteData];
        p14.offsets.set("x", "_inverseStrumsModifier", function(p16) -- Line: 48
            -- upvalues: u15 (copy)
            return p16 - (u15.x or 0);
        end);
        p14.offsets.set("y", "_inverseStrumsModifier", function(p17) -- Line: 52
            -- upvalues: u15 (copy)
            return p17 - (u15.y or 0);
        end);
    end,

    onBeatHit = function() -- Line: 56, Name: onBeatHit
        -- upvalues: u5 (ref), VarTweener (copy), u1 (copy), Api (copy)
        if math.random(1, 5) == 2 then
            u5 = not u5;
            VarTweener:Create(u1, TweenInfo.new(Api.Conductor.Crochet / 1000 / Api.playbackRate), {
                curVal = u5 and 1 or 0
            }):Play();
        end;
    end
};