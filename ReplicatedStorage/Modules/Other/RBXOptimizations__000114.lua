-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");

return function() -- Line: 6
    -- upvalues: RunService (copy), Players (copy)
    RunService:UnbindFromRenderStep("utility-focus-state-muteall");
    RunService:UnbindFromRenderStep("utility-focus-state-sharegame");
    RunService:UnbindFromRenderStep("utility-focus-state-playermute");
    RunService:UnbindFromRenderStep("utility-focus-state-joinVoice");

    for _, v in Players:GetPlayers() do
        RunService:UnbindFromRenderStep("utility-focus-state" .. "-friendstatuslabel-" .. v.Name);
        RunService:UnbindFromRenderStep("utility-focus-state" .. "-blockbutton-" .. v.Name);
        RunService:UnbindFromRenderStep("utility-focus-state" .. "-mutestatusbutton-" .. v.UserId);
        RunService:UnbindFromRenderStep("utility-focus-state" .. "-reportplayer-" .. v.Name);
        RunService:UnbindFromRenderStep("utility-focus-state" .. "-inspect-" .. v.Name);
    end;
end;