-- Decompiled with Potassium's decompiler.

local u1 = {
    Players = game:GetService("Players"),
    TS = game:GetService("TweenService"),
    GuiService = game:GetService("GuiService"),
    UIS = game:GetService("UserInputService")
};
local LocalPlayer = u1.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local TopbarButtons = LocalPlayer.PlayerGui:WaitForChild("Main"):WaitForChild("TopbarButtons");

function setInputStatus(p2: boolean)
    -- upvalues: u1 (copy), LocalPlayer (copy)
    u1.GuiService.TouchControlsEnabled = p2;
    LocalPlayer.Character.HumanoidRootPart.Anchored = not p2;
end;

local u3 = {
    currentDialog = nil,
    curLine = nil,
    oldCamPos = nil,
    oldCamFocus = nil,
    inDialog = false,
    doCamMovementWip = true,
    ui = LocalPlayer.PlayerGui:WaitForChild("DialogueGui"),
    tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    quickClose = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    camTweenInfo = TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
    choicesBtns = {},
    __statics = {
        PlayerTalking = {
            Player = 0,
            NPC = 1
        }
    }
};

function onHumanoidDeath()
    -- upvalues: u3 (copy)
    if u3.inDialog then
        u3:Exit(true);
    end;
end;

local Humanoid = (LocalPlayer.Character or LocalPlayer.CharacterAdded):WaitForChild("Humanoid");
local u4 = Humanoid.Died:Connect(onHumanoidDeath);
LocalPlayer.CharacterAdded:Connect(function(p5) -- Line: 51
    -- upvalues: u4 (ref), Humanoid (ref)
    if u4 then
        u4:Disconnect();
    end;

    Humanoid = p5:WaitForChild("Humanoid");
    u4 = Humanoid.Died:Connect(onHumanoidDeath);
end);

function getSpeaker(p6: table)
    -- upvalues: u3 (copy), LocalPlayer (copy), u1 (copy)
    local v7;

    if u3.doCamMovementWip then
        local v8 = p6.Player == u3.__statics.PlayerTalking.Player and u3.currentDialog.Data.PlrCamOffset or u3.currentDialog.Data.NPCCamOffset;
        v7 = (p6.Player == u3.__statics.PlayerTalking.Player and LocalPlayer.Character:GetPivot() or (u3.currentDialog.Data.NPCCamPos or u3.currentDialog.Data.NPC:GetPivot())) * CFrame.new(0, 0, -7) * CFrame.fromOrientation(0, 3.141592653589793, 0) * (v8 or CFrame.new());
    else
        v7 = nil;
    end;

    if p6.PlayerData then
        return p6.PlayerData;
    end;

    return p6.Player == u3.__statics.PlayerTalking.Player and {
        Name = LocalPlayer.DisplayName,
        Icon = {
            Icon = u1.Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size150x150),
            Size = Vector2.new(150, 150),
            Offset = Vector2.zero
        },
        CamCFrame = v7
    } or {
        Name = u3.currentDialog.Data.NPCName,
        Icon = u3.currentDialog.Data.NPCIcon,
        CamCFrame = v7
    };
end;

local u9 = {};
local u10 = false;

function finishedText(p11)
    -- upvalues: u10 (ref), u9 (copy), u3 (copy)
    if not u10 then
        return;
    end;

    u10 = false;

    for _, v in u9 do
        if v then
            pcall(function() -- Line: 98
                -- upvalues: v (copy)
                if coroutine.status(v) ~= "dead" then
                    task.cancel(v);
                end;
            end);
        end;
    end;

    table.clear(u9);
    u3.ui.DialogueMain.SafeZone.Icon.DialogueContent.Yap.MaxVisibleGraphemes = -1;
    task.wait(0.5);

    if not u3.inDialog then
        return;
    end;

    if p11.Choices then
        for _, v in p11.Choices do
            local v12 = u3.ui.BotGrad.ChoicesZone.Template:Clone();
            v12.Visible = true;
            v12.Label.Text = v.ChoiceText or v.Text;
            v12.MouseButton1Click:Connect(function() -- Line: 115
                -- upvalues: u3 (ref), v (copy)
                for _, v2 in u3.choicesBtns do
                    if v2 then
                        v2:Destroy();
                    end;
                end;

                u3.choicesBtns = {};
                u3:setLine(v);
            end);
            table.insert(u3.choicesBtns, v12);
            v12.Parent = u3.ui.BotGrad.ChoicesZone;
        end;

        return;
    end;

    if not p11.Continue then
        task.wait(2);
        u3:Exit(false);

        return;
    end;

    task.wait(1);

    if p11.StartDelay then
        task.wait(p11.StartDelay);
    end;

    if not u3.inDialog then
        return;
    end;

    u3:setLine(p11.Continue);
end;

function u3.setLine(p13: table, u14: table) -- Line: 140
    -- upvalues: u3 (copy), u10 (ref), workspace_CurrentCamera (copy), u9 (copy)
    if not u3.inDialog then
        return;
    end;

    if u14.EndDialogue == true then
        u3:Exit(false);

        return;
    end;

    u10 = true;
    u3.curLine = u14;

    if u14.Callback ~= nil then
        u14.Callback();
    end;

    local v15 = getSpeaker(u14);
    u3.ui.DialogueMain.SafeZone.Icon.Image = v15.Icon.Icon;
    u3.ui.DialogueMain.SafeZone.Icon.ImageRectSize = v15.Icon.Size or Vector2.zero;
    u3.ui.DialogueMain.SafeZone.Icon.ImageRectOffset = v15.Icon.Offset or Vector2.zero;
    u3.ui.DialogueMain.SafeZone.Icon.DialogueContent.BroName.Text = v15.Name;

    if u14.Text == nil then
        u3.ui.DialogueMain.SafeZone.Icon.DialogueContent.Yap.Text = "";
        u3.ui.DialogueMain.SafeZone.Icon.DialogueContent.Yap.MaxVisibleGraphemes = -1;
    else
        u3.ui.DialogueMain.SafeZone.Icon.DialogueContent.Yap.Text = u14.Text;
        u3.ui.DialogueMain.SafeZone.Icon.DialogueContent.Yap.MaxVisibleGraphemes = 0;
    end;

    if v15.CamCFrame then
        tweenCamTo(u3.camTweenInfo, workspace_CurrentCamera.CFrame, v15.CamCFrame);
    end;

    if u14.Text ~= nil then
        for i = 0, u14.Text:len() - 1 do
            local task_delay = task.delay;
            local v16 = u14.Duration / u14.Text:len() * i;
            table.insert(u9, task_delay(v16, function() -- Line: 173
                -- upvalues: u3 (ref), i (copy), u14 (copy)
                u3.ui.DialogueMain.SafeZone.Icon.DialogueContent.Yap.MaxVisibleGraphemes = u3.ui.DialogueMain.SafeZone.Icon.DialogueContent.Yap.MaxVisibleGraphemes + 1;

                if i == u14.Text:len() - 1 then
                    finishedText(u14);
                end;
            end));
            local _ = i;
        end;
    end;
end;

function tweenCamTo(p17: userdata, p18, p19)
    -- upvalues: u1 (copy), workspace_CurrentCamera (copy)
    local v20 = tick() + p17.Time;

    for i = 1, 100000 do
        task.wait();
        local Time = p17.Time;
        local v21 = tick() - v20;
        local v22 = (Time - math.abs(v21)) / p17.Time;
        local Value = u1.TS:GetValue(v22, p17.EasingStyle, p17.EasingDirection);

        if tick() > v20 then
            break;
        end;

        workspace_CurrentCamera.CFrame = p18:Lerp(p19, Value);
        local _ = i;
    end;
end;

function u3.Exit(p23: table, p24: boolean) -- Line: 198
    -- upvalues: u3 (copy), u1 (copy), workspace_CurrentCamera (copy), Humanoid (ref), TopbarButtons (copy)
    if not u3.inDialog then
        return;
    end;

    u1.TS:Create(u3.ui.BotGrad, p24 and u3.quickClose or u3.tweenInfo, {
        AnchorPoint = Vector2.new(0, 0)
    }):Play();
    u1.TS:Create(u3.ui.DialogueMain, p24 and u3.quickClose or u3.tweenInfo, {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 1.1)
    }):Play();

    if u3.doCamMovementWip then
        if p24 then
            workspace_CurrentCamera.CFrame = u3.oldCamPos;
            workspace_CurrentCamera.Focus = u3.oldCamFocus;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CameraSubject = Humanoid;
            u3.currentDialog = nil;
            u3.inDialog = false;
            u3.curLine = nil;
            TopbarButtons:SetAttribute("Disabled", false);

            for _, v in u3.choicesBtns do
                if v then
                    v:Destroy();
                end;
            end;
        else
            tweenCamTo(u3.tweenInfo, workspace_CurrentCamera.CFrame, u3.oldCamPos);
            task.wait(u3.tweenInfo.Time);

            for _, v in u3.choicesBtns do
                if v then
                    v:Destroy();
                end;
            end;

            workspace_CurrentCamera.CFrame = u3.oldCamPos;
            workspace_CurrentCamera.Focus = u3.oldCamFocus;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CameraSubject = Humanoid;
            u3.currentDialog = nil;
            u3.inDialog = false;
            u3.curLine = nil;
            TopbarButtons:SetAttribute("Disabled", false);
        end;
    else
        for _, v in u3.choicesBtns do
            if v then
                v:Destroy();
            end;
        end;

        u3.currentDialog = nil;
        u3.inDialog = false;
        u3.curLine = nil;
        TopbarButtons:SetAttribute("Disabled", false);
    end;

    setInputStatus(true);
end;

function u3.startDialogue(p25: table, p26: table) -- Line: 248
    -- upvalues: Humanoid (ref), LocalPlayer (copy), u3 (copy), TopbarButtons (copy), workspace_CurrentCamera (copy), u1 (copy)
    if not Humanoid then
        return;
    end;

    if Humanoid.Health <= 0 then
        return;
    end;

    if LocalPlayer.PlayerGui:WaitForChild("Main"):FindFirstChild("SoloPrompt") then
        return;
    end;

    if not u3.inDialog then
        u3.ui = LocalPlayer.PlayerGui:WaitForChild("DialogueGui");
        local v27 = p26.Dialog or p26.Dialogue;
        assert(v27, "Dialogue is not correctly formatted");
        setInputStatus(false);
        TopbarButtons:SetAttribute("Disabled", true);
        u3.currentDialog = p26;
        u3.inDialog = true;

        if u3.doCamMovementWip then
            workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            u3.oldCamPos = workspace_CurrentCamera.CFrame;
            u3.oldCamFocus = workspace_CurrentCamera.Focus;
        end;

        u1.TS:Create(u3.ui.BotGrad, u3.tweenInfo, {
            AnchorPoint = Vector2.new(0, 1)
        }):Play();
        u1.TS:Create(u3.ui.DialogueMain, u3.tweenInfo, {
            AnchorPoint = Vector2.new(0.5, 1),
            Position = UDim2.fromScale(0.5, 0.9)
        }):Play();
        u3:setLine(v27);
    end;
end;

return u3;