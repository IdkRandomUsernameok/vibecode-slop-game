-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local GuiService = game:GetService("GuiService");
local StarterPlayer = game:GetService("StarterPlayer");
local workspace_CurrentCamera = workspace.CurrentCamera;
local FieldOfView = workspace_CurrentCamera.FieldOfView;
local CharacterWalkSpeed = StarterPlayer.CharacterWalkSpeed;
local u1 = CharacterWalkSpeed * 2;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = false;
local u7 = false;
local u8 = false;
local u9 = false;
local u10 = 0;
local u11 = false;

return function(u12: userdata, p13: any, p14: any, p15: any) -- Line: 28
    -- upvalues: u9 (ref), GuiService (copy), u2 (ref), u3 (ref), u8 (ref), u7 (ref), u6 (ref), u5 (ref), u1 (copy), TweenService (copy), workspace_CurrentCamera (copy), FieldOfView (copy), CharacterWalkSpeed (copy), u11 (ref), u10 (ref), u4 (ref), UserInputService (copy)
    local DeviceManager = require(p13.Main.DeviceManager);
    local u16 = u12.Character or u12.CharacterAdded:Wait();
    local Humanoid = u16:WaitForChild("Humanoid");
    local u17 = "";
    local u18 = "";

    local function UpdateAnimationFolders(p19) -- Line: 38
        -- upvalues: u17 (ref), u18 (ref), Humanoid (ref), u16 (ref)
        if u17 == "" or u18 == "" then
            return;
        end;

        if Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
            return;
        end;

        local Animate = u16:FindFirstChild("Animate");

        if not Animate then
            return;
        end;

        local u20 = p19 and u18 or u17;

        local function swapFolder(p21) -- Line: 47
            -- upvalues: Animate (copy), u20 (copy)
            local v22 = Animate:FindFirstChild(p21);

            if v22 then
                local v23 = v22:Clone();

                for _, child in ipairs(v23:GetChildren()) do
                    if child:IsA("Animation") or child:IsA("StringValue") then
                        child.AnimationId = u20;
                    end;
                end;

                v22:Destroy();
                v23.Parent = Animate;
            end;
        end;

        swapFolder("walk");
        swapFolder("run");
        local State = Humanoid:GetState();

        if State == Enum.HumanoidStateType.Running or State == Enum.HumanoidStateType.RunningNoPhysics then
            Humanoid:ChangeState(Enum.HumanoidStateType.Landed);
        end;
    end;

    local function SetupAnimations() -- Line: 70
        -- upvalues: u17 (ref), u18 (ref), Humanoid (ref), u16 (ref), UpdateAnimationFolders (copy), u9 (ref)
        u17 = "";
        u18 = "";

        if Humanoid.RigType == Enum.HumanoidRigType.R15 then
            task.spawn(function() -- Line: 74
                -- upvalues: u16 (ref), u17 (ref), u18 (ref), UpdateAnimationFolders (ref), u9 (ref)
                local Animate = u16:WaitForChild("Animate", 3);

                if Animate then
                    local walk = Animate:WaitForChild("walk", 1);
                    local run = Animate:WaitForChild("run", 1);

                    if walk and run then
                        local v24 = walk:FindFirstChildWhichIsA("Animation") or walk:FindFirstChildWhichIsA("StringValue");
                        local v25 = run:FindFirstChildWhichIsA("Animation") or run:FindFirstChildWhichIsA("StringValue");

                        if v24 and v25 then
                            u17 = v24.AnimationId;
                            u18 = v25.AnimationId;
                            UpdateAnimationFolders(u9);
                        end;
                    end;
                end;
            end);
        end;
    end;

    u17 = "";
    u18 = "";

    if Humanoid.RigType == Enum.HumanoidRigType.R15 then
        task.spawn(function() -- Line: 74
            -- upvalues: u16 (ref), u17 (ref), u18 (ref), UpdateAnimationFolders (copy), u9 (ref)
            local Animate = u16:WaitForChild("Animate", 3);

            if Animate then
                local walk = Animate:WaitForChild("walk", 1);
                local run = Animate:WaitForChild("run", 1);

                if walk and run then
                    local v26 = walk:FindFirstChildWhichIsA("Animation") or walk:FindFirstChildWhichIsA("StringValue");
                    local v27 = run:FindFirstChildWhichIsA("Animation") or run:FindFirstChildWhichIsA("StringValue");

                    if v26 and v27 then
                        u17 = v26.AnimationId;
                        u18 = v27.AnimationId;
                        UpdateAnimationFolders(u9);
                    end;
                end;
            end;
        end);
    end;

    local u28 = DeviceManager.currentDevice == "Mobile";

    local function updateMobileUI() -- Line: 100
        -- upvalues: u28 (ref), GuiService (ref), u12 (copy)
        u12.PlayerGui.MobileGui.Enabled = u28 and GuiService.TouchControlsEnabled;
    end;

    u12.PlayerGui.MobileGui.Enabled = u28 and GuiService.TouchControlsEnabled;

    local function updateSprintKey(p29) -- Line: 107
        -- upvalues: u2 (ref)
        u2 = Enum.KeyCode:FromName(p29);
    end;

    local function updateConsoleSprintKey(p30) -- Line: 111
        -- upvalues: u3 (ref)
        u3 = Enum.KeyCode:FromName(p30);
    end;

    local function UpdateSprintState() -- Line: 115
        -- upvalues: Humanoid (ref), u8 (ref), u7 (ref), u6 (ref), u9 (ref), u5 (ref), u1 (ref), TweenService (ref), workspace_CurrentCamera (ref), FieldOfView (ref), UpdateAnimationFolders (copy), CharacterWalkSpeed (ref)
        local v31 = u8 or (u7 or u6 and Humanoid.MoveDirection.Magnitude > 0);

        if v31 and not u9 then
            if u5 and not u5.inSong then
                u9 = true;
                Humanoid.WalkSpeed = u1;
                TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.4), {
                    FieldOfView = FieldOfView + u1 / 7
                }):Play();
                UpdateAnimationFolders(true);
            end;
        elseif not v31 and u9 then
            u9 = false;

            if u5 and not u5.inSong then
                Humanoid.WalkSpeed = CharacterWalkSpeed;
                TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.4), {
                    FieldOfView = FieldOfView
                }):Play();
                UpdateAnimationFolders(false);
            end;
        end;
    end;

    local u32 = Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function() -- Line: 139
        -- upvalues: UpdateSprintState (copy)
        UpdateSprintState();
    end);
    DeviceManager.deviceChanged:Connect(function(p33) -- Line: 143
        -- upvalues: u28 (ref), GuiService (ref), u12 (copy), u8 (ref), UpdateSprintState (copy)
        u28 = p33 == "Mobile";
        u12.PlayerGui.MobileGui.Enabled = u28 and GuiService.TouchControlsEnabled;

        if not u28 and u8 then
            u8 = false;
            UpdateSprintState();
        end;
    end);
    GuiService:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(updateMobileUI);
    task.spawn(function() -- Line: 156
        -- upvalues: u12 (copy), u28 (ref), u8 (ref), UpdateSprintState (copy)
        local MobileGui = u12:WaitForChild("PlayerGui"):WaitForChild("MobileGui", 10);
        local u34 = MobileGui and MobileGui:WaitForChild("Container", 10):WaitForChild("Sprint", 10);

        if u34 then
            u34.Activated:Connect(function() -- Line: 164
                -- upvalues: u28 (ref), u8 (ref), u34 (copy), UpdateSprintState (ref)
                if not u28 then
                    return;
                end;

                u8 = not u8;
                u34.Image = `rbxasset://textures/ui/Input/SprintButton{u8 and "Pressed" or "Regular"}@2x.png`;
                UpdateSprintState();
            end);
        end;
    end);

    local function handleForwardPress() -- Line: 175
        -- upvalues: u28 (ref), u11 (ref), u10 (ref), u7 (ref), UpdateSprintState (copy)
        if u28 then
            return;
        end;

        if not u11 then
            u11 = true;
            local os_clock_ret = os.clock();

            if os_clock_ret - u10 <= 0.3 then
                u7 = true;
                UpdateSprintState();

                return;
            end;

            u10 = os_clock_ret;
        end;
    end;

    local function handleForwardRelease() -- Line: 191
        -- upvalues: u28 (ref), u11 (ref), u7 (ref), UpdateSprintState (copy)
        if u28 then
            return;
        end;

        if u11 then
            u11 = false;

            if u7 then
                u7 = false;
                UpdateSprintState();
            end;
        end;
    end;

    local function onInputBegan(p35, p36) -- Line: 203
        -- upvalues: u2 (ref), u3 (ref), u6 (ref), UpdateSprintState (copy), u28 (ref), u11 (ref), u10 (ref), u7 (ref)
        if not p36 then
            if p35.KeyCode == u2 or p35.KeyCode == u3 then
                u6 = true;
                UpdateSprintState();
            end;

            if p35.KeyCode == Enum.KeyCode.W or p35.KeyCode == Enum.KeyCode.Up then
                if u28 then
                    return;
                end;

                if not u11 then
                    u11 = true;
                    local os_clock_ret = os.clock();

                    if os_clock_ret - u10 <= 0.3 then
                        u7 = true;
                        UpdateSprintState();

                        return;
                    end;

                    u10 = os_clock_ret;
                end;
            end;
        end;
    end;

    local function onInputEnded(p37) -- Line: 216
        -- upvalues: u2 (ref), u3 (ref), u6 (ref), UpdateSprintState (copy), u28 (ref), u11 (ref), u7 (ref)
        if p37.KeyCode == u2 or p37.KeyCode == u3 then
            u6 = false;
            UpdateSprintState();
        end;

        if p37.KeyCode == Enum.KeyCode.W or p37.KeyCode == Enum.KeyCode.Up then
            if u28 then
                return;
            end;

            if u11 then
                u11 = false;

                if u7 then
                    u7 = false;
                    UpdateSprintState();
                end;
            end;
        end;
    end;

    local function onInputChanged(p38) -- Line: 227
        -- upvalues: u28 (ref), u11 (ref), u10 (ref), u7 (ref), UpdateSprintState (copy)
        if p38.KeyCode == Enum.KeyCode.Thumbstick1 then
            local Y = p38.Position.Y;

            if Y >= 0.7 then
                if u28 then
                    return;
                end;

                if not u11 then
                    u11 = true;
                    local os_clock_ret = os.clock();

                    if os_clock_ret - u10 > 0.3 then
                        u10 = os_clock_ret;

                        return;
                    end;

                    u7 = true;
                    UpdateSprintState();
                end;
            elseif Y <= 0.3 then
                if u28 then
                    return;
                end;

                if u11 then
                    u11 = false;

                    if u7 then
                        u7 = false;
                        UpdateSprintState();
                    end;
                end;
            end;
        end;
    end;

    p14.LocalSignals.APILoaded:Connect(function(p39) -- Line: 239
        -- upvalues: u4 (ref), u5 (ref)
        u4 = p39;
        u5 = p39.getClientSettings();
    end);
    p14.DataManager.DataChanged:Connect(function(p40, p41) -- Line: 244
        -- upvalues: u2 (ref), u3 (ref)
        if p40 == "Keybinds/Miscellaneous/Sprint" then
            u2 = Enum.KeyCode:FromName(p41);

            return;
        end;

        if p40 == "ConsoleKeybinds/Miscellaneous/Sprint" then
            u3 = Enum.KeyCode:FromName(p41);
        end;
    end);
    u12.CharacterAdded:Connect(function(p42) -- Line: 252
        -- upvalues: u16 (ref), Humanoid (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u11 (ref), u32 (ref), UpdateSprintState (copy), u17 (ref), u18 (ref), UpdateAnimationFolders (copy)
        u16 = p42;
        Humanoid = u16:WaitForChild("Humanoid");
        u6 = false;
        u7 = false;
        u8 = false;
        u9 = false;
        u11 = false;

        if u32 then
            u32:Disconnect();
        end;

        u32 = Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function() -- Line: 265
            -- upvalues: UpdateSprintState (ref)
            UpdateSprintState();
        end);
        u17 = "";
        u18 = "";

        if Humanoid.RigType == Enum.HumanoidRigType.R15 then
            task.spawn(function() -- Line: 74
                -- upvalues: u16 (ref), u17 (ref), u18 (ref), UpdateAnimationFolders (ref), u9 (ref)
                local Animate = u16:WaitForChild("Animate", 3);

                if Animate then
                    local walk = Animate:WaitForChild("walk", 1);
                    local run = Animate:WaitForChild("run", 1);

                    if walk and run then
                        local v43 = walk:FindFirstChildWhichIsA("Animation") or walk:FindFirstChildWhichIsA("StringValue");
                        local v44 = run:FindFirstChildWhichIsA("Animation") or run:FindFirstChildWhichIsA("StringValue");

                        if v43 and v44 then
                            u17 = v43.AnimationId;
                            u18 = v44.AnimationId;
                            UpdateAnimationFolders(u9);
                        end;
                    end;
                end;
            end);
        end;
    end);
    u2 = Enum.KeyCode:FromName(p15.Keybinds.Miscellaneous.Sprint);
    u3 = Enum.KeyCode:FromName(p15.ConsoleKeybinds.Miscellaneous.Sprint);
    UserInputService.InputBegan:Connect(onInputBegan);
    UserInputService.InputEnded:Connect(onInputEnded);
    UserInputService.InputChanged:Connect(onInputChanged);
end;