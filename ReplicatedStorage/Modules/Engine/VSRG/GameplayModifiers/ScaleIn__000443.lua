-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();
local VarTweener = require(game:GetService("ReplicatedStorage").Modules.Main.VarTweener);
local u1 = 550 / Api.songSpeed;
local u2 = 0.65 / Api.songSpeed;

return {
    onSpawnNote = function(u3) -- Line: 8, Name: onSpawnNote
        -- upvalues: Api (copy), u1 (copy), VarTweener (copy), u2 (copy)
        u3.offsets.set("Scale", "_scaleInModifier", 0);
        task.delay((u3.strumTime - Api.Conductor.SongPosition - u1) / 1000 / Api.playbackRate, function() -- Line: 10
            -- upvalues: u3 (copy), VarTweener (ref), u2 (ref), Api (ref)
            if not u3.alive then
                return;
            end;

            VarTweener:Create(u3.offsets:GetPropertyOffsets("Scale"), TweenInfo.new(u2 / Api.playbackRate), {
                _scaleInModifier = 1
            }):Play();
        end);
    end
};