-- Decompiled with Potassium's decompiler.

local u1 = nil;
local VarTweener = require(game:GetService("ReplicatedStorage").Modules.Main.VarTweener);
local u2 = 500;

return {
    preCreate = function(p3) -- Line: 8, Name: preCreate
        -- upvalues: u1 (ref)
        u1 = p3;
        u1.setSimpleSustains(false);
    end,

    create = function(p4) -- Line: 12, Name: create
        -- upvalues: u2 (ref)
        u2 = 500 * p4.playbackRate / p4.songSpeed;
    end,

    onSpawnNote = function(u5) -- Line: 15, Name: onSpawnNote
        -- upvalues: u1 (ref), u2 (ref), VarTweener (copy)
        task.delay((u5.strumTime - u1.Conductor.SongPosition - u2) / 1000 / u1.playbackRate, function() -- Line: 16
            -- upvalues: u5 (copy), VarTweener (ref), u1 (ref)
            if not u5.alive then
                return;
            end;

            u5.offsets.set("alpha", "_fadeOutModifier", 1);
            VarTweener:Create(u5.offsets:GetPropertyOffsets("alpha"), TweenInfo.new(0.3 / u1.playbackRate, Enum.EasingStyle.Linear), {
                _fadeOutModifier = 0
            }):Play();
        end);
    end
};