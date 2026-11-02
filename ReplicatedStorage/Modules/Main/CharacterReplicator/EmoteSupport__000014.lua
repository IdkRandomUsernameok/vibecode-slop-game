-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = game:GetService("Players").LocalPlayer;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 12
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);
require(ReplicatedStorage:WaitForChild("Modules").Other.Easings);
local DataManager = require(ReplicatedStorage:WaitForChild("Modules").Data.DataManager);
local LocalSignals = require(ReplicatedStorage:WaitForChild("Modules").Signals.LocalSignals);
local Data = DataManager:GetData();

function lerpCFrame(p5: number, p6, p7, p8)
    -- upvalues: Data (ref)
    if p6 == p7 then
        return p7;
    end;

    local _ = Data.CameraEasingStyle == nil or (Data.CameraEasingStyle == "Default" or not Data.CameraEasingStyle);

    if Data.CameraEasingDir == nil or (Data.CameraEasingDir == "Default" or not Enum.EasingDirection:FromName(Data.CameraEasingDir)) then
        local _ = Enum.EasingDirection.InOut;
    end;

    return p8:Lerp(p7, (math.clamp(p5 * 3.125, 0, 1)));
end;

return {
    init = function() -- Line: 33, Name: init
        -- upvalues: u2 (ref), u4 (ref), workspace_CurrentCamera (ref)
        u2 = Instance.new("Part");
        u4 = Instance.new("ObjectValue");
        u4.Name = "ShopCamTargetValueFix";
        u4.Parent = game:GetService("Players").LocalPlayer;
        u4.Value = workspace_CurrentCamera.CameraSubject;
    end,

    localCharCreated = function(p9) -- Line: 41, Name: localCharCreated
        -- upvalues: Data (ref), DataManager (copy), LocalSignals (copy), u1 (ref), u2 (ref), workspace_CurrentCamera (ref), u3 (ref), RunService (copy), LocalPlayer (copy), u4 (ref)
        local ActiveCharacter = p9:GetActiveCharacter();
        local v10 = ActiveCharacter:FindFirstChild("Head") or ActiveCharacter.PrimaryPart;

        if p9.sideAttributes.FollowHead == false then
            v10 = nil;
        end;

        Data = DataManager:GetData();

        if Data.CameraMoveEmote and v10 then
            local v11 = LocalSignals.func_GetCamSubjectPos:Invoke();
            u1 = v10;
            u2.CFrame = CFrame.new(v11) or workspace_CurrentCamera.CFrame;
            u3 = CFrame.new(v11) or workspace_CurrentCamera.CFrame;
            RunService:UnbindFromRenderStep("_StageEmoteCameraUpdate");

            if u1 then
                workspace_CurrentCamera.CameraSubject = u2;
                RunService:BindToRenderStep("_StageEmoteCameraUpdate", Enum.RenderPriority.Camera.Value, function(p12) -- Line: 57
                    -- upvalues: u1 (ref), u3 (ref), u2 (ref)
                    if u1 then
                        u3 = lerpCFrame(p12, u2.CFrame, u1.CFrame, u3);
                        u2.CFrame = u3;
                    end;
                end);
            else
                workspace_CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid;
            end;
        end;

        u4.Value = workspace_CurrentCamera.CameraSubject;
    end,

    localDestroyed = function(p13) -- Line: 71, Name: localDestroyed
        -- upvalues: RunService (copy), workspace_CurrentCamera (ref), LocalPlayer (copy)
        RunService:UnbindFromRenderStep("_StageEmoteCameraUpdate");

        if workspace_CurrentCamera.CameraSubject ~= LocalPlayer.Character.Humanoid then
            workspace_CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid;
        end;
    end,

    charCreated = function(p14: any, p15: userdata?) -- Line: 78, Name: charCreated
        if p15 then
        end;
    end
};