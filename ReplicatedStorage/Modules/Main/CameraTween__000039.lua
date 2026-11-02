-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local workspace_CurrentCamera = workspace.CurrentCamera;
local v1 = {};
local u2 = nil;
local u3 = nil;

function v1.init(p4, p5) -- Line: 7
    -- upvalues: u2 (ref), u3 (ref)
    u2 = p4;
    u3 = p5 or u2.getStage();
end;

function v1.updateStage(p6, p7) -- Line: 12
    -- upvalues: u3 (ref)
    u3 = p7;
end;

function v1.tweenCamera(p8, p9, p10) -- Line: 16
    -- upvalues: u2 (ref), u3 (ref), TweenService (copy), workspace_CurrentCamera (copy)
    if not (u2 and u3) then
        warn("CameraTween not initialized. Call CameraTween:init(api, stage) first.");

        return;
    end;

    local v11 = u3.Cameras:FindFirstChild(p9);

    if v11 then
        u2.overrideCamera(true);
        local v12 = TweenService:Create(workspace_CurrentCamera, p10, {
            CFrame = v11.CFrame
        });
        v12.Completed:Connect(function() -- Line: 27
            -- upvalues: u2 (ref), workspace_CurrentCamera (ref)
            u2.setTarget(workspace_CurrentCamera);
            u2.overrideCamera(false);
            u2.updateCam(0, true);
        end);

        return v12;
    end;

    warn("Camera target not found: " .. p9);
end;

function v1.resetCamera(p13) -- Line: 39
    -- upvalues: u2 (ref)
    u2.setTarget(nil);
end;

return v1;