-- Decompiled with Potassium's decompiler.

return function() -- Line: 1
    local ContextActionService = game:GetService("ContextActionService");
    local Players = game:GetService("Players");
    local RunService = game:GetService("RunService");
    game:GetService("StarterPlayer");
    local UserInputService = game:GetService("UserInputService");
    local Workspace = game:GetService("Workspace");
    local Spring = require(script:WaitForChild("Utils"):WaitForChild("Spring"));
    local CurrentCamera = Workspace.CurrentCamera;
    local LocalPlayer = Players.LocalPlayer;
    local Config = require(script:WaitForChild("Config"));
    local MouseLockController = require(script:WaitForChild("MouseLockController"));
    (function() -- Line: 24, Name: setup
        -- upvalues: MouseLockController (copy), CurrentCamera (copy), Config (copy), UserInputService (copy), RunService (copy), Spring (copy), LocalPlayer (copy), ContextActionService (copy)
        local _maid = MouseLockController._maid;
        local RotationController = MouseLockController.RotationController;
        RotationController:SetRotationSource(CurrentCamera);

        if Config.MOUSE_LOCK_ENABLED then
            local MOUSE_LOCK = Config.MOUSE_LOCK;
            local MOUSE_ICON = MOUSE_LOCK.MOUSE_ICON;
            local MOUSE_BEHAVIOUR = MOUSE_LOCK.MOUSE_BEHAVIOUR;
            _maid:GiveTask(MouseLockController.ActiveChanged:Connect(function(p1, p2) -- Line: 40
                -- upvalues: UserInputService (ref), MOUSE_ICON (copy), RunService (ref), MOUSE_BEHAVIOUR (copy)
                if not p1 then
                    return;
                end;

                local MouseIcon = UserInputService.MouseIcon;
                UserInputService.MouseIcon = MOUSE_ICON;
                p2:GiveTask(RunService.RenderStepped:Connect(function(p3) -- Line: 48
                    -- upvalues: UserInputService (ref), MOUSE_BEHAVIOUR (ref)
                    if UserInputService.MouseBehavior ~= MOUSE_BEHAVIOUR then
                        UserInputService.MouseBehavior = MOUSE_BEHAVIOUR;
                    end;
                end));
                p2:GiveTask(function() -- Line: 56
                    -- upvalues: UserInputService (ref), MouseIcon (copy)
                    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
                    UserInputService.MouseIcon = MouseIcon;
                end);
            end));
        end;

        if Config.CAMERA_OFFSET_ENABLED then
            local CAMERA_OFFSET = Config.CAMERA_OFFSET;
            local u4 = Vector3.new(0, 0, 0);

            local function u5() -- Line: 69
                -- upvalues: u4 (ref)
                return u4;
            end;

            if CAMERA_OFFSET.SMOOTH then
                local u6 = Spring.new(Vector3.new(0, 0, 0));

                u5 = function(p7, p8) -- Line: 77
                    -- upvalues: u6 (copy), CAMERA_OFFSET (copy), u4 (ref)
                    if p8 then
                        u6.Damper = 1;
                    else
                        u6.Damper = CAMERA_OFFSET.SMOOTH_DAMPER or 0.75;

                        if p7 then
                            u6.Speed = CAMERA_OFFSET.SMOOTH_SPEED_IN or 25;
                        else
                            u6.Speed = CAMERA_OFFSET.SMOOTH_SPEED_OUT or 15;
                        end;
                    end;

                    u6.Target = u4;

                    return u6.Position;
                end;
            end;

            _maid:GiveTask(MouseLockController.EnabledChanged:Connect(function(p9, p10) -- Line: 96
                -- upvalues: RunService (ref), CurrentCamera (ref), MouseLockController (ref), u4 (ref), CAMERA_OFFSET (copy), u5 (ref)
                if not p9 then
                    return;
                end;

                p10:GiveTask(RunService.RenderStepped:Connect(function(p11) -- Line: 100
                    -- upvalues: CurrentCamera (ref), MouseLockController (ref), u4 (ref), CAMERA_OFFSET (ref), u5 (ref)
                    if CurrentCamera.CameraType ~= Enum.CameraType.Custom then
                        return;
                    end;

                    local v12 = (CurrentCamera.Focus.Position - CurrentCamera.CFrame.Position).Magnitude < 1;
                    local IsActive = MouseLockController.IsActive;

                    if IsActive and not v12 then
                        u4 = CAMERA_OFFSET.OFFSET;
                    else
                        u4 = Vector3.new(0, 0, 0);
                    end;

                    CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(u5(IsActive, v12));
                end));
            end));
        end;

        if Config.ROTATION_ENABLED then
            local ROTATION = Config.ROTATION;

            if ROTATION.SMOOTH then
                local SMOOTH_SPEED = ROTATION.SMOOTH_SPEED;
                RotationController:SetRotationBehaviour(function(p13, p14, p15: any) -- Line: 129
                    -- upvalues: SMOOTH_SPEED (copy)
                    return p13:Lerp(p14, p15 * SMOOTH_SPEED);
                end);
            end;

            if ROTATION.ASSUME_USING_ROBLOX_CHARACTERS then
                local u16 = nil;
                _maid:GiveTask(MouseLockController.EnabledChanged:Connect(function(p17, p18) -- Line: 138
                    -- upvalues: u16 (ref), RotationController (copy), LocalPlayer (ref)
                    if not p17 then
                        return;
                    end;

                    local function updateCharacter(p19: userdata) -- Line: 142
                        -- upvalues: u16 (ref), RotationController (ref)
                        u16 = p19:WaitForChild("Humanoid");
                        RotationController:SetRotationTarget((p19:WaitForChild("HumanoidRootPart")));
                    end;

                    local Character = LocalPlayer.Character;

                    if Character then
                        task.defer(updateCharacter, Character);
                    end;

                    p18:GiveTask(LocalPlayer.CharacterAdded:Connect(function(p20) -- Line: 156
                        -- upvalues: u16 (ref), RotationController (ref)
                        u16 = p20:WaitForChild("Humanoid");
                        RotationController:SetRotationTarget((p20:WaitForChild("HumanoidRootPart")));
                    end));
                end));
                _maid:GiveTask(MouseLockController.ActiveChanged:Connect(function(p21, p22) -- Line: 161
                    -- upvalues: RunService (ref), u16 (ref), RotationController (copy)
                    if not p21 then
                        return;
                    end;

                    p22:GiveTask(RunService.Heartbeat:Connect(function() -- Line: 165
                        -- upvalues: u16 (ref), RotationController (ref)
                        if not u16 then
                            return;
                        end;

                        u16.AutoRotate = false;
                        RotationController:SetRotate(not u16.Sit);
                    end));
                    p22:GiveTask(function() -- Line: 173
                        -- upvalues: u16 (ref), RotationController (ref)
                        if not u16 then
                            return;
                        end;

                        u16.AutoRotate = true;
                        RotationController:SetRotate(false);
                    end);
                end));
            else
                _maid:GiveTask(MouseLockController.ActiveChanged:Connect(function(p23, p24) -- Line: 181
                    -- upvalues: RotationController (copy)
                    if not p23 then
                        return;
                    end;

                    RotationController:SetRotate(true);
                    p24:GiveTask(function() -- Line: 188
                        -- upvalues: RotationController (ref)
                        RotationController:SetRotate(false);
                    end);
                end));
            end;
        end;

        if Config.USE_CONTEXT_ACTION then
            local CONTEXT_ACTION = Config.CONTEXT_ACTION;
            _maid:GiveTask(MouseLockController.EnabledChanged:Connect(function(p25, p26) -- Line: 199
                -- upvalues: ContextActionService (ref), CONTEXT_ACTION (copy), MouseLockController (ref)
                if not p25 then
                    return;
                end;

                ContextActionService:BindActionAtPriority(CONTEXT_ACTION.ACTION_NAME, function(p27, p28, p29) -- Line: 205
                    -- upvalues: MouseLockController (ref)
                    if p28 ~= Enum.UserInputState.Begin then
                        return Enum.ContextActionResult.Pass;
                    end;

                    MouseLockController:MouseLock();

                    return Enum.ContextActionResult.Sink;
                end, CONTEXT_ACTION.MOBILE_BUTTON, CONTEXT_ACTION.ACTION_PRIORITY, unpack(CONTEXT_ACTION.KEYBINDS));
                p26:GiveTask(function() -- Line: 219
                    -- upvalues: ContextActionService (ref), CONTEXT_ACTION (ref)
                    ContextActionService:UnbindAction(CONTEXT_ACTION.ACTION_NAME);
                end);
            end));
        end;

        if Config.MOUSE_LOCK_OPTION_COMPATIBILITY then
            local GameSettings = UserSettings().GameSettings;

            local function updateMouseLockAvailability() -- Line: 231
                -- upvalues: LocalPlayer (ref), GameSettings (copy), MouseLockController (ref)
                if LocalPlayer.DevEnableMouseLock and (GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) and not (LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable) then
                    MouseLockController.EnabledState:Remove("RBX_MouseLockOption");

                    return;
                end;

                MouseLockController.EnabledState:Set("RBX_MouseLockOption", {
                    Priority = 10,
                    Enabled = false
                });
            end;

            _maid:GiveTask(GameSettings.Changed:Connect(function(p30) -- Line: 249
                -- upvalues: updateMouseLockAvailability (copy)
                if p30 ~= "ControlMode" and p30 ~= "ComputerMovementMode" then
                    return;
                end;

                updateMouseLockAvailability();
            end));
            _maid:GiveTask(LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(updateMouseLockAvailability));
            _maid:GiveTask(LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(updateMouseLockAvailability));
            updateMouseLockAvailability();
        end;

        _maid:GiveTask(task.spawn(pcall, function() -- Line: 261
            -- upvalues: LocalPlayer (ref), _maid (copy)
            local BoundKeys = LocalPlayer.PlayerScripts:WaitForChild("PlayerModule", 5):WaitForChild("CameraModule", 5):WaitForChild("MouseLockController", 5):WaitForChild("BoundKeys", 5);

            if BoundKeys then
                local Value = BoundKeys.Value;
                BoundKeys.Value = "";
                _maid:GiveTask(BoundKeys:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 271
                    -- upvalues: Value (ref), BoundKeys (copy)
                    Value = BoundKeys.Value;
                    BoundKeys.Value = "";
                end));
                _maid:GiveTask(function() -- Line: 276
                    -- upvalues: BoundKeys (copy), Value (ref)
                    BoundKeys.Value = Value;
                end);
            end;
        end));
    end)();
    MouseLockController:Start();
    MouseLockController:Enable();
end;