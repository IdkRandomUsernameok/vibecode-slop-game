-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();
local u1 = nil;

function remapToRange(p2, p3, p4, p5, p6)
    return p5 + (p6 - p5) * ((p2 - p3) / (p4 - p3));
end;

return {
    onCreate = function() -- Line: 10, Name: onCreate
        -- upvalues: u1 (ref), Api (copy)
        u1 = script.Bnuy:Clone();
        u1.Parent = Api.Overlay;
        u1.ZIndex = 9999;
    end,

    onUpdate = function() -- Line: 16, Name: onUpdate
        -- upvalues: u1 (ref), Api (copy)
        if not u1 then
            return;
        end;

        local DecimalBeat = Api.Conductor.DecimalBeat;
        local v7 = DecimalBeat % 32;
        local v8 = v7 >= 16 and remapToRange(v7, 16, 32, 0.812, 0) or remapToRange(v7, 0, 16, 0, 0.812);
        local math_sin_ret = math.sin(DecimalBeat % 2 / 2 * 3.141592653589793);
        local math_abs_ret = math.abs(math_sin_ret);
        u1.Position = UDim2.fromScale(v8, 1 - math_abs_ret * 0.5);
        u1.ImageRectSize = Vector2.new(v7 >= 16 and -620 or 620, 603);
        u1.ImageRectOffset = Vector2.new(v7 >= 16 and 620 or 0, 0);
    end,

    clearUp = function() -- Line: 30, Name: clearUp
        -- upvalues: u1 (ref)
        if u1 then
            u1:Destroy();
            u1 = nil;
        end;
    end
};