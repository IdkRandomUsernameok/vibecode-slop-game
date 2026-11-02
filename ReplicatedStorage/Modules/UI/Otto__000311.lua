-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = false;
local script_OttoController = require(script.OttoController);
local LocalPlayer = game.Players.LocalPlayer;
local _, result = pcall(function() -- Line: 11
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetRankInGroup(17371285) >= 253;
end);
local _, result2 = pcall(function() -- Line: 15
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer:GetRankInGroup(17371285) == 150;
end);

return {
    onCreate = function(p5) -- Line: 20, Name: onCreate
        -- upvalues: u1 (ref), u3 (ref), u2 (ref), result (copy), result2 (copy), u4 (ref), script_OttoController (copy)
        u1 = p5;

        if u1.Settings.UseOttoBotplay == false then
            return;
        end;

        u3 = u1.Overlay.BotplayText;
        u3.Parent = nil;
        u2 = script.Otto:Clone();
        u2.Parent = u1.Overlay;
        u2.Visible = result or result2;
        u4 = u1.GetAutoplay();
        script_OttoController.SetOtto(u2);

        if u4 then
            script_OttoController.ForceState("Active");

            return;
        end;

        script_OttoController.ForceState("Inactive");
    end,

    onBotplayToggle = function(p6) -- Line: 40, Name: onBotplayToggle
        -- upvalues: u2 (ref), result (copy), result2 (copy), u1 (ref), u4 (ref), script_OttoController (copy)
        local v7;

        if result or result2 then
            v7 = u1.Settings.ShowBotplay or false;
        else
            v7 = false;
        end;

        u2.Visible = v7;
        u4 = p6;

        if u4 then
            script_OttoController.ForceState("Active");
            script_OttoController.GetOtto().ImageColor3 = Color3.new(0.66, 0, 0);

            return;
        end;

        script_OttoController.ForceState("Inactive");
        script_OttoController.GetOtto().ImageColor3 = Color3.new(0.33, 0, 0);
    end,

    onPlayerNoteHit = function(p8) -- Line: 52, Name: onPlayerNoteHit
        -- upvalues: u4 (ref), script_OttoController (copy)
        if not p8.sustainNote then
            if u4 then
                script_OttoController.Tap(p8);

                return;
            end;

            script_OttoController.InactiveTap();
        end;
    end,

    onNoteMiss = function(p9) -- Line: 61, Name: onNoteMiss
        -- upvalues: script_OttoController (copy)
        script_OttoController.Miss();
    end,

    clearUp = function() -- Line: 64, Name: clearUp
        -- upvalues: u2 (ref), u3 (ref), u1 (ref)
        if u2 then
            u2:Destroy();
        end;

        if u3 then
            u3.Parent = u1.Overlay;
        end;
    end
};