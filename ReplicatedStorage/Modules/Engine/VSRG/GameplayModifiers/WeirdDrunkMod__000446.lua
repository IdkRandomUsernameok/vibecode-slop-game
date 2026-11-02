-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();
local Conductor = Api.Conductor;
local math_sin = math.sin;
local math_cos = math.cos;

local function doDrunkMath(p1, p2) -- Line: 8
    -- upvalues: Conductor (copy), math_cos (copy), math_sin (copy)
    return math_cos(Conductor.TimePosition) * 25 + (p1 > 0 and p2 and 0 or math_sin(p1 / 50) * 25);
end;

return {
    onCreate = function() -- Line: 14, Name: onCreate
        -- upvalues: Api (copy), Conductor (copy), math_cos (copy)
        for _, v in Api.Strums do
            v.offsets.set("x", "_drunkWeirdMod", function(p3) -- Line: 16
                -- upvalues: Conductor (ref), math_cos (ref)
                return p3 + (math_cos(Conductor.TimePosition) * 25 + 0);
            end);
        end;
    end,

    onSpawnNote = function(u4) -- Line: 21, Name: onSpawnNote
        -- upvalues: Conductor (copy), math_cos (copy), math_sin (copy)
        u4.offsets.set("x", "_drunkWeirdMod", function(p5) -- Line: 22
            -- upvalues: Conductor (ref), u4 (copy), math_cos (ref), math_sin (ref)
            local v6 = Conductor.SongPosition - u4.strumTime;
            local sustainNote = u4.sustainNote;

            return p5 + (math_cos(Conductor.TimePosition) * 25 + (v6 > 0 and sustainNote and 0 or math_sin(v6 / 50) * 25));
        end);
    end
};