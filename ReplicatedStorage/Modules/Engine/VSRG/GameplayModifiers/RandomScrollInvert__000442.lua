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

return {
    onCreate = function() -- Line: 15, Name: onCreate
        -- upvalues: Api (copy), u1 (copy)
        for _, v in Api.Strums do
            local GetProperty = v.GetProperty;

            function v.GetProperty(p6, p7, ...) -- Line: 18
                -- upvalues: GetProperty (copy), v (copy), u1 (ref)
                local v8 = GetProperty(v, p7, ...);

                if p7 == "y" then
                    return v8 + (720 - v8 - v8) * u1.curVal;
                end;

                return v8;
            end;
        end;
    end,

    onSpawnNote = function(u9) -- Line: 27, Name: onSpawnNote
        -- upvalues: u1 (copy)
        if u9.sustainNote then
            u9.offsets.set("Scale", "_switchModThing", function(p10) -- Line: 29
                -- upvalues: u1 (ref)
                return p10 * Vector2.new(1, 1 + -2 * u1.curVal);
            end);
        end;

        local GetProperty = u9.GetProperty;

        function u9.GetProperty(p11, p12, ...) -- Line: 35
            -- upvalues: GetProperty (copy), u9 (copy), u1 (ref)
            local v13 = GetProperty(u9, p12, ...);

            if p12 == "y" then
                return v13 + (720 - v13 - v13) * u1.curVal;
            end;

            if p12 == "angle" and u9.useAngleAnchor then
                return v13 + (-v13 - v13) * u1.curVal;
            end;

            return v13;
        end;
    end,

    onBeatHit = function() -- Line: 45, Name: onBeatHit
        -- upvalues: u5 (ref), VarTweener (copy), u1 (copy), Api (copy)
        if math.random(1, 5) == 2 then
            u5 = not u5;
            VarTweener:Create(u1, TweenInfo.new(Api.Conductor.Crochet / 1000 / Api.playbackRate), {
                curVal = u5 and 1 or 0
            }):Play();
        end;
    end
};