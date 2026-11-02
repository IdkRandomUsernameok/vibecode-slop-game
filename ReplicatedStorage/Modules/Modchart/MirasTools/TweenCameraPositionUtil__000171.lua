-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.Main.VarTweener);
local u1 = nil;

return function(p2, p3, u4, p5, u6) -- Line: 6
    -- upvalues: u1 (ref)
    u6.setProperty("camGame.instantLerp", u4);

    if typeof(p5) == "string" then
        p5 = u6.getCameras():FindFirstChild(p5).CFrame or p5;
    end;

    if u1 and u1.Running then
        u1:Cancel();
    end;

    u1 = VarTweener:CreateValueTween(workspace.CurrentCamera.CFrame, p5, p2, function(p7) -- Line: 15
        workspace.CurrentCamera.CFrame = p7;
    end);
    u1:Play();

    if p3 then
        u6.delay(p2.Time or (p2.Duration or 0), function() -- Line: 22
            -- upvalues: u1 (ref), u6 (copy), u4 (copy)
            u1 = nil;
            u6.setTarget(nil);

            if u4 then
                u6.setProperty("camGame.instantLerp", false);
            end;
        end);
    end;
end;