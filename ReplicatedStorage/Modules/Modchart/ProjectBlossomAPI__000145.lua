-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local u3 = nil;
local Ratings = require(game:GetService("ReplicatedStorage").Modules.Main.Ratings);

return {
    setup = function(p4) -- Line: 8, Name: setup
        -- upvalues: u1 (ref), u2 (ref), u3 (ref)
        u1 = p4;
        u2 = 1;
        u3 = 0;
    end,

    setHealthStopVal = function(p5) -- Line: 13, Name: setHealthStopVal
        -- upvalues: u3 (ref)
        u3 = p5 or 0;
    end,

    removeHealth = function(p6) -- Line: 16, Name: removeHealth
        -- upvalues: u2 (ref), u3 (ref)
        if u3 < u2 - p6 then
            u2 = u2 - p6;
        end;
    end,

    addHealth = function(p7) -- Line: 21, Name: addHealth
        -- upvalues: u2 (ref)
        if u2 < 2 then
            u2 = u2 + p7;
        end;
    end,

    playerNoteHit = function(p8) -- Line: 26, Name: playerNoteHit
        -- upvalues: u1 (ref), Ratings (copy), u2 (ref)
        if not p8.sustainNote then
            local name = Ratings.GetScoreAndJudgement((u1.Conductor.SongPosition - p8.strumTime) / u1.playbackRate).name;

            if u2 < 2 then
                if name == "Marvelous" or name == "Sick" then
                    u2 = u2 + 0.08;
                elseif name == "Good" then
                    u2 = u2 + 0.034999999999999996;
                elseif name == "Ok" then
                    u2 = u2 + 0.03;
                end;
            end;

            if u2 > 0 and name == "Bad" then
                u2 = u2 - 0.06;
            end;
        end;
    end,

    noteMiss = function() -- Line: 48, Name: noteMiss
        -- upvalues: u2 (ref)
        if u2 > 0 then
            u2 = u2 - 0.15;
        end;
    end,

    update = function(p9) -- Line: 53, Name: update
        -- upvalues: u1 (ref), u2 (ref)
        u1.setHealth(u2);
    end
};