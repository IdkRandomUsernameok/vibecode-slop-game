-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();
local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local u1 = {
    Conductor = require(Modules.Main.Conductor),
    ratingModule = require(Modules.Main.Ratings)
};

return {
    onPlayerNoteHit = function(p2) -- Line: 10, Name: onPlayerNoteHit
        -- upvalues: Api (copy), u1 (copy)
        if not Api.Settings.ShowHUD then
            return;
        end;

        if p2.sustainNote then
            return;
        end;

        local v3 = Api.GetAutoplay() and 0 or (u1.Conductor.SongPosition - p2.strumTime) / Api.playbackRate;
        local ScoreAndJudgement = u1.ratingModule.GetScoreAndJudgement(v3);

        if ScoreAndJudgement.name ~= "Marvelous" and ScoreAndJudgement.name ~= "Sick" then
            Api.die();
        end;
    end,

    onNoteMiss = Api.die
};