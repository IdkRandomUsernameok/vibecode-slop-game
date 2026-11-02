-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
game:GetService("UserService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("HttpService");
local script_Assets = script.Assets;
local script_Modules = script.Modules;
local UpdatePlayerLeaderboardEntry = ReplicatedStorage:WaitForChild("Events").UpdatePlayerLeaderboardEntry;
local Leaderboard = script_Assets.Leaderboard;
local _ = script_Assets.PlayerTemplate;
local _ = script_Assets.PlayerViewerTemplates.Tag;
local ActionButton = script_Assets.PlayerViewerTemplates.ActionButton;
local AvatarExaminer = script_Assets.AvatarExaminer;
local Inspector = Leaderboard.Container.PlayerInspectorContainer.Inspector;
local ScrollingFrame = Leaderboard.Container.Leaderboard.Contents.ScrollingFrame;
local Frame = Leaderboard.Container.Leaderboard.Contents.Frame;
local UIListLayout = Frame.UIListLayout;
local Modules = ReplicatedStorage:WaitForChild("Modules");
local u2 = {
    OverRatio = 5,
    CurrentDisplayMode = "Normal",
    LastInspectedUser = nil,
    LeaderboardClosing = false,
    LeaderboardOpen = false,
    InspectorOpen = false,
    OpenLeaderboardButtonEnabled = true,
    OpenLeaderboardButtonTweenDelayTask = nil,
    LeaderboardSizeYCap = 0.5,
    IgnoreNextUsernameUpdate = false,
    IgnoreNextDisplayNameUpdate = false,
    LastCloseButtonGuiState = Enum.GuiState.Idle,
    LastOpenButtonGuiState = Enum.GuiState.Idle
};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
require(Modules.UI.AssetIcons);
local DataManager = require(Modules.Data.DataManager);
local Data = DataManager:GetData();
local PlayerFrame = require(script_Modules.PlayerFrame);
local TagGenerator = require(script_Modules.TagGenerator);
local Actions = require(script_Modules.Actions);
u1.LeaderboardEnabled = true;
u1.UserInspectorVisible = false;
u1.LastInspectedUser = nil;
u1.OpenLeaderboardButtonEnabled = true;
u1.LeaderboardOpen = false;
u1.ToggleKeybinds = { "Tab", "DPadLeft" };

function __ConnectPlayerFrame(u7: table)
    -- upvalues: u2 (copy), u1 (copy), DataManager (copy), Data (copy)
    if not u7 then
        return;
    end;

    TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);

    if u7.Frame then
        u7.__Connections.Triggered = u7.Frame.Activated:Connect(function() -- Line: 97
            -- upvalues: u2 (ref), u7 (copy), u1 (ref)
            if u2.LastInspectedUser == u7.Player then
                u1:CloseUserInspector();
                u2.LastInspectedUser = nil;
            else
                u1.LastInspectedUser = u7.Player;
                u2.LastInspectedUser = u7.Player;
                u1:InspectUser(u7);

                if not u1.UserInspectorVisible then
                    u1:OpenUserInspector();
                end;
            end;

            u7.__Internals.__LastGuiState = u7.Frame.GuiState;
        end);
    end;

    u7.__Connections.CompactModeSwitch = DataManager.DataChanged:Connect(function(p8) -- Line: 116
        -- upvalues: u7 (copy), Data (ref)
        if p8 ~= "CompactLeaderboard" then
            return;
        end;

        u7.FrameAspectRatio.AspectRatio = Data.CompactLeaderboard and 9 or 5;
        u7.__Internals.__IsCompactMode = Data.CompactLeaderboard;
    end);
end;

function u1.Init(p9) -- Line: 133
    -- upvalues: UIListLayout (copy), ScrollingFrame (copy), u2 (copy), Frame (copy), u4 (copy), Players (copy), u5 (copy), PlayerFrame (copy), Data (copy), TweenService (copy), UpdatePlayerLeaderboardEntry (copy), DataManager (copy), u1 (copy), UserInputService (copy), Leaderboard (copy)
    local function __updateLBSizeY() -- Line: 138
        -- upvalues: UIListLayout (ref), ScrollingFrame (ref), u2 (ref), Frame (ref)
        local Y = UIListLayout.AbsoluteContentSize.Y;
        local Y2 = workspace.CurrentCamera.ViewportSize.Y;
        ScrollingFrame.Size = UDim2.new(1, 0, 0, Y2 * u2.LeaderboardSizeYCap);

        if u2.CurrentDisplayMode ~= "Normal" or Y2 * u2.LeaderboardSizeYCap > Y then
            if u2.CurrentDisplayMode == "Scroll" and Y < Y2 * u2.LeaderboardSizeYCap then
                u2.CurrentDisplayMode = "Normal";

                for _, child in ScrollingFrame:GetChildren() do
                    child.Parent = Frame;
                end;

                Frame.Visible = true;
                ScrollingFrame.Visible = false;
            end;

            return;
        end;

        u2.CurrentDisplayMode = "Scroll";

        for _, child in Frame:GetChildren() do
            child.Parent = ScrollingFrame;
        end;

        Frame.Visible = false;
        ScrollingFrame.Visible = true;
    end;

    u4.PlayerJoin = Players.PlayerAdded:Connect(function(p10) -- Line: 178
        -- upvalues: u5 (ref), PlayerFrame (ref), Data (ref), u2 (ref), ScrollingFrame (ref), Frame (ref), TweenService (ref)
        if not u5[p10] then
            local u11 = PlayerFrame.new(p10, Data.CompactLeaderboard, Data.AlwaysAnimateLeaderboardBanners);
            u5[p10] = u11;

            if u11 then
                __ConnectPlayerFrame(u11);
                u11:Update(true, true, true);
                u11.Frame.Size = UDim2.new();
                u11.FrameAspectRatio.Parent = script;
                u11.Frame.Parent = u2.CurrentDisplayMode == "Scroll" and ScrollingFrame or Frame;
                local u12 = TweenService:Create(u11.Frame, TweenInfo.new(0.27999999999999997, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    Size = UDim2.new(0, 0, 0, u11.Frame.Parent.AbsoluteSize.X / (Data.CompactLeaderboard and 9 or 5))
                });
                local u13 = TweenService:Create(u11.Frame, TweenInfo.new(0.35, Enum.EasingStyle.Cubic), {
                    Size = UDim2.new(1, 0, 0, u11.Frame.Parent.AbsoluteSize.X / (Data.CompactLeaderboard and 9 or 5))
                });
                u12.Completed:Once(function() -- Line: 198
                    -- upvalues: u13 (copy), u12 (copy)
                    u13:Play();
                    task.wait();
                    u12:Destroy();
                end);
                u13.Completed:Once(function() -- Line: 203
                    -- upvalues: u11 (copy), u13 (copy)
                    if u11 and u11.Frame then
                        u11.FrameAspectRatio.Parent = u11.Frame;
                        u11.Frame.Size = UDim2.fromScale(1, 1);
                    end;

                    task.wait();
                    u13:Destroy();
                end);
                u12:Play();
            end;
        end;
    end);
    u4.PlayerLeave = Players.PlayerRemoving:Connect(function(u14) -- Line: 217
        -- upvalues: u5 (ref), Data (ref), u2 (ref), ScrollingFrame (ref), Frame (ref), TweenService (ref)
        if u5[u14] then
            if u5[u14].Frame then
                local u15 = u5[u14];

                if not u15 then
                    return;
                end;

                u15.Frame.Size = UDim2.new(1, 0, 0, u15.Frame.Parent and (u15.Frame.Parent.AbsoluteSize.X / (Data.CompactLeaderboard and 9 or 5) or 0) or 0);
                u15.FrameAspectRatio.Parent = script;
                u15.Frame.Parent = u2.CurrentDisplayMode == "Scroll" and ScrollingFrame or Frame;
                local u16 = TweenService:Create(u15.Frame, TweenInfo.new(0.27999999999999997, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    Size = UDim2.new(0, 0, 0, u15.Frame.Parent.AbsoluteSize.X / (Data.CompactLeaderboard and 9 or 5))
                });
                local u17 = TweenService:Create(u15.Frame, TweenInfo.new(0.35, Enum.EasingStyle.Cubic), {
                    Size = UDim2.new()
                });
                u16.Completed:Once(function() -- Line: 234
                    -- upvalues: u17 (copy), u16 (copy)
                    u17:Play();
                    task.wait();
                    u16:Destroy();
                end);
                u17.Completed:Once(function() -- Line: 239
                    -- upvalues: u15 (copy), u17 (copy), u5 (ref), u14 (copy)
                    if u15 and u15.Frame then
                        u15.FrameAspectRatio.Parent = u15.Frame;
                        u15.Frame:Destroy();
                    end;

                    task.wait();
                    u17:Destroy();

                    if u5[u14] and u5[u14].__Connections then
                        for _, v in u5[u14].__Connections do
                            v:Disconnect();
                        end;
                    end;

                    u5[u14] = nil;
                end);
                u16:Play();
            end;

            for _, v in u5[u14].__Connections do
                v:Disconnect();
            end;

            u5[u14] = nil;
        end;
    end);
    u4.PlayerUpdate = UpdatePlayerLeaderboardEntry.OnClientEvent:Connect(function(p18) -- Line: 271
        -- upvalues: u5 (ref)
        if u5[p18] then
            u5[p18]:Update(true, true, true);
            u5[p18]:RenderBanner(p18:GetAttribute("LB_BannerData") or "");
        end;
    end);
    u4.SizeUpdated = UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 279
        -- upvalues: __updateLBSizeY (copy)
        __updateLBSizeY();
    end);
    u4.ViewportSizeUpdated = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 284
        -- upvalues: __updateLBSizeY (copy)
        __updateLBSizeY();
    end);
    u4.LeaderboardVerticalSizeChanged = DataManager.DataChanged:Connect(function(p19) -- Line: 289
        -- upvalues: u2 (ref), Data (ref), __updateLBSizeY (copy)
        if p19 ~= "LeaderboardVerticalSize" then
            return;
        end;

        u2.LeaderboardSizeYCap = Data.LeaderboardVerticalSize;
        __updateLBSizeY();
    end);
    u4.PlayerUpdate = DataManager.DataChanged:Connect(function(p20) -- Line: 296
        -- upvalues: Data (ref), u1 (ref)
        if p20 ~= "LeaderboardEnabled" then
            return;
        end;

        if Data.LeaderboardEnabled then
            u1:EnableLeaderboard();

            return;
        end;

        u1:DisableLeaderboard();
    end);
    u4.ToggleKeybinds = UserInputService.InputBegan:Connect(function(p21, p22) -- Line: 306
        -- upvalues: Data (ref), u1 (ref), u2 (ref)
        if p22 or not Data.LeaderboardEnabled then
            return;
        end;

        for _, v in u1.ToggleKeybinds do
            if p21.KeyCode.Name == v then
                if u2.LeaderboardOpen then
                    u1:CloseLeaderboard();

                    return;
                end;

                u1:OpenLeaderboard();

                return;
            end;
        end;
    end);
    u4.CloseButton = Leaderboard.Container.Leaderboard.Close.Activated:Connect(function() -- Line: 332
        -- upvalues: u1 (ref)
        u1:CloseLeaderboard();
    end);
    u4.OpenButton = Leaderboard.Toggle.Trigger.Activated:Connect(function() -- Line: 344
        -- upvalues: u1 (ref)
        u1:OpenLeaderboard();
    end);
    u2.LeaderboardSizeYCap = Data.LeaderboardVerticalSize;

    for _, v in Players:GetPlayers() do
        if not u5[v] then
            local u23 = PlayerFrame.new(v, Data.CompactLeaderboard, Data.AlwaysAnimateLeaderboardBanners);
            u5[v] = u23;

            if u23 then
                __ConnectPlayerFrame(u23);
                u23:Update(true, true, true);
                u23.Frame.Size = UDim2.new();
                u23.FrameAspectRatio.Parent = script;
                u23.Frame.Parent = u2.CurrentDisplayMode == "Scroll" and ScrollingFrame or Frame;
                local u24 = TweenService:Create(u23.Frame, TweenInfo.new(0.27999999999999997, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    Size = UDim2.new(0, 0, 0, u23.Frame.Parent.AbsoluteSize.X / (Data.CompactLeaderboard and 9 or 5))
                });
                local u25 = TweenService:Create(u23.Frame, TweenInfo.new(0.35, Enum.EasingStyle.Cubic), {
                    Size = UDim2.new(1, 0, 0, u23.Frame.Parent.AbsoluteSize.X / (Data.CompactLeaderboard and 9 or 5))
                });
                u24.Completed:Once(function() -- Line: 375
                    -- upvalues: u25 (copy), u24 (copy)
                    u25:Play();
                    task.wait();
                    u24:Destroy();
                end);
                u25.Completed:Once(function() -- Line: 380
                    -- upvalues: u23 (copy), u25 (copy)
                    if u23 and u23.Frame then
                        u23.FrameAspectRatio.Parent = u23.Frame;
                        u23.Frame.Size = UDim2.fromScale(1, 1);
                    end;

                    task.wait();
                    u25:Destroy();
                end);
                u24:Play();
            end;
        end;
    end;

    __updateLBSizeY();
end;

function u1.InspectUser(p26: table, u27: table) -- Line: 397
    -- upvalues: Inspector (copy), u4 (copy), u2 (copy), TagGenerator (copy), u6 (ref), Actions (copy), Players (copy), ActionButton (copy), u1 (copy)
    local PlayerInfo = Inspector.Container.PlayerInfo;
    local Icon, v28 = u27:GetIcon();
    PlayerInfo.SpecialIcon.Image = v28;
    PlayerInfo.SpecialIcon.Visible = Icon;
    PlayerInfo.Avatar.ImageLabel.Image = u27.__Internals.__Thumbnail;

    if u27.PlayerInfo.ShowVerified then
        PlayerInfo.Username.Text = PlayerInfo.Username.Text .. utf8.char(57344);
    end;

    if u4.PlayerInspectorUsernameEdited then
        u4.PlayerInspectorUsernameEdited:Disconnect();
    end;

    u4.PlayerInspectorUsernameEdited = PlayerInfo.Username.Changed:Connect(function() -- Line: 417
        -- upvalues: u2 (ref), u27 (copy), PlayerInfo (copy)
        if u2.IgnoreNextUsernameUpdate then
            u2.IgnoreNextUsernameUpdate = false;

            return;
        end;

        local v29 = "@" .. u27.PlayerInfo.Username;

        if u27.PlayerInfo.ShowVerified then
            v29 = v29 .. utf8.char(57344);
        end;

        if v29 ~= PlayerInfo.Username.Text then
            u2.IgnoreNextUsernameUpdate = true;
            PlayerInfo.Username.Text = v29;
        end;
    end);
    PlayerInfo.DisplayName.Text = u27.PlayerInfo.DisplayName;
    PlayerInfo.Username.Text = ("@" .. u27.PlayerInfo.Username) .. (u27.PlayerInfo.ShowVerified and tostring(utf8.char(57344)) or "");

    if u27.PlayerInfo and u27.PlayerInfo.Tags then
        for _, child in PlayerInfo.Parent.Tags:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        if #u27.PlayerInfo.Tags >= 1 then
            PlayerInfo.Parent.InfoSeparator.Visible = true;
            PlayerInfo.Parent.Tags.Visible = true;

            for _, v in TagGenerator:GenerateTagFrames(u27) do
                v.Parent = PlayerInfo.Parent.Tags;
            end;
        else
            PlayerInfo.Parent.InfoSeparator.Visible = false;
            PlayerInfo.Parent.Tags.Visible = false;
        end;
    end;

    local v30 = 0;

    for _, child in PlayerInfo.Parent.Actions:GetChildren() do
        if child:IsA("TextButton") then
            child:Destroy();
        end;
    end;

    for _, v in u6 do
        v:Disconnect();
    end;

    u6 = {};

    for _, v in pairs(Actions) do
        if not (v.VisibleOnYourself ~= nil and (not v.VisibleOnYourself or u27.Player ~= Players.LocalPlayer) and (v.VisibleOnYourself or u27.Player == Players.LocalPlayer) or v.ShowIfFriends ~= nil and not (v.ShowIfFriends and Players.LocalPlayer:IsFriendsWithAsync(u27.Player.UserId)) and (v.ShowIfFriends or Players.LocalPlayer:IsFriendsWithAsync(u27.Player.UserId))) then
            v30 = v30 + 1;
            local v31 = ActionButton:Clone();
            local Label = v31:WaitForChild("Label");
            local Icon2 = v31:WaitForChild("Icon");
            v31.LayoutOrder = v30;
            Label.Text = v.Text;

            if v.Icon then
                Icon2.Image = v.Icon;
                Icon2.Visible = true;
            else
                Icon2.Visible = false;
            end;

            table.insert(u6, v31.Activated:Connect(function() -- Line: 531
                -- upvalues: v (copy), u27 (copy), u1 (ref)
                if v.TriggerFunction then
                    v.TriggerFunction(u27.Player);
                end;

                if v.CollapsePlayerViewerOnTrigger then
                    u1:CloseUserInspector();
                end;

                if v.CollapseLeaderboardOnTrigger then
                    u1:CloseLeaderboard();
                end;

                if v.UpdateInspectorOnTrigger then
                    u1:InspectUser(u27);
                end;
            end));
            v31.Parent = PlayerInfo.Parent.Actions;
        end;
    end;

    PlayerInfo.Parent.Actions.Visible = v30 >= 1;
    PlayerInfo.Parent.ActionSeparator.Visible = v30 >= 1;
end;

function u1.OpenUserInspector(p32) -- Line: 556
    -- upvalues: u2 (copy), u1 (copy), Leaderboard (copy), Inspector (copy), u3 (ref)
    if not u2.InspectorOpen then
        u2.InspectorOpen = true;
        u1.UserInspectorVisible = true;
        Leaderboard.Container.PlayerInspectorContainer.Visible = true;
        Inspector.Parent = Leaderboard.Container.PlayerInspectorContainer.Animated;

        for _, v in u3.TogglePlayerInspector.Close do
            v:Cancel();
        end;

        task.wait();

        for _, v in u3.TogglePlayerInspector.Open do
            v:Play();
        end;
    end;
end;

function u1.CloseUserInspector(p33) -- Line: 574
    -- upvalues: u2 (copy), u1 (copy), Leaderboard (copy), Inspector (copy), u3 (ref)
    if u2.InspectorOpen then
        u2.LastInspectedUser = nil;
        u2.InspectorOpen = false;
        u1.UserInspectorVisible = false;
        Leaderboard.Container.PlayerInspectorContainer.Visible = true;
        Inspector.Parent = Leaderboard.Container.PlayerInspectorContainer.Animated;

        for _, v in u3.TogglePlayerInspector.Open do
            v:Cancel();
        end;

        task.wait();

        for _, v in u3.TogglePlayerInspector.Close do
            v:Play();
        end;
    end;
end;

function u1.DisableOpenLeaderboardButton(p34) -- Line: 593
    -- upvalues: u2 (copy), u1 (copy), Leaderboard (copy)
    if u2.OpenLeaderboardButtonEnabled then
        u2.OpenLeaderboardButtonEnabled = false;
        u1.OpenLeaderboardButtonEnabled = false;
        Leaderboard.Toggle.Visible = false;
    end;
end;

function u1.EnableOpenLeaderboardButton(p35) -- Line: 602
    -- upvalues: u2 (copy), u1 (copy), Leaderboard (copy)
    if not u2.OpenLeaderboardButtonEnabled then
        u2.OpenLeaderboardButtonEnabled = true;
        u1.OpenLeaderboardButtonEnabled = true;

        if not u2.LeaderboardOpen then
            Leaderboard.Toggle.Visible = true;
        end;
    end;
end;

function u1.OpenLeaderboard(p36) -- Line: 611
    -- upvalues: u2 (copy), u1 (copy), u3 (ref), Leaderboard (copy)
    if not u2.LeaderboardOpen then
        if u2.OpenLeaderboardButtonTweenDelayTask then
            task.cancel(u2.OpenLeaderboardButtonTweenDelayTask);
            u2.OpenLeaderboardButtonTweenDelayTask = nil;
        end;

        u1.LeaderboardOpen = true;
        u2.LeaderboardOpen = true;

        for _, v in u3.ToggleLeaderboard.Close do
            v:Cancel();
        end;

        task.wait();

        if u2.LeaderboardClosing then
            u3.ToggleLeaderboard.Open.Container:Play();
            u2.OpenLeaderboardButtonTweenDelayTask = nil;
        else
            u2.OpenLeaderboardButtonTweenDelayTask = task.delay(0.15, function() -- Line: 629
                -- upvalues: u3 (ref), u2 (ref)
                u3.ToggleLeaderboard.Open.Container:Play();
                u2.OpenLeaderboardButtonTweenDelayTask = nil;
            end);
        end;

        for i, v in u3.ToggleLeaderboard.Open do
            if i ~= "Container" then
                v:Play();
            end;
        end;

        if u2.OpenLeaderboardButtonEnabled then
            Leaderboard.Toggle.Visible = true;
        end;

        Leaderboard.Container.Visible = true;
        u2.LeaderboardClosing = false;
    end;
end;

function u1.CloseLeaderboard(p37) -- Line: 651
    -- upvalues: u2 (copy), u1 (copy), u3 (ref), Leaderboard (copy)
    if u2.LeaderboardOpen then
        u2.LeaderboardClosing = true;

        if u2.OpenLeaderboardButtonTweenDelayTask then
            task.cancel(u2.OpenLeaderboardButtonTweenDelayTask);
            u2.OpenLeaderboardButtonTweenDelayTask = nil;
        end;

        u1.LeaderboardOpen = false;
        u2.LeaderboardOpen = false;

        for _, v in u3.ToggleLeaderboard.Open do
            v:Cancel();
        end;

        task.wait();
        u2.OpenLeaderboardButtonTweenDelayTask = task.delay(0.15, function() -- Line: 671
            -- upvalues: u3 (ref), u2 (ref)
            u3.ToggleLeaderboard.Close.Toggle:Play();
            u2.OpenLeaderboardButtonTweenDelayTask = nil;
        end);

        for i, v in u3.ToggleLeaderboard.Close do
            if i ~= "Toggle" then
                v:Play();
            end;
        end;

        if u2.OpenLeaderboardButtonEnabled then
            Leaderboard.Toggle.Visible = true;
        end;

        Leaderboard.Container.Visible = true;
    end;
end;

function u1.EnableLeaderboard(p38) -- Line: 687
    -- upvalues: u1 (copy), Leaderboard (copy)
    u1.LeaderboardEnabled = true;
    Leaderboard.Enabled = true;
end;

function u1.DisableLeaderboard(p39) -- Line: 693
    -- upvalues: u1 (copy), Leaderboard (copy)
    u1.LeaderboardEnabled = false;
    Leaderboard.Enabled = false;
end;

u3 = {
    PlayerHover = {},
    ToggleLeaderboard = {
        Open = {
            Container = TweenService:Create(Leaderboard.Container, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(1, 0)
            }),
            Toggle = TweenService:Create(Leaderboard.Toggle, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 250, 0, 0)
            })
        },
        Close = {
            Container = TweenService:Create(Leaderboard.Container, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 500, 0, 0)
            }),
            Toggle = TweenService:Create(Leaderboard.Toggle, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(1, 0)
            })
        }
    },
    TogglePlayerInspector = {
        Open = {
            Inspector = TweenService:Create(Inspector, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(1, 0)
            }),
            Gradient = TweenService:Create(Leaderboard.Container.PlayerInspectorContainer.Animated.UIGradient, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Offset = Vector2.new(0.1, 0)
            })
        },
        Close = {
            Inspector = TweenService:Create(Inspector, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 190, 0, 0)
            }),
            Gradient = TweenService:Create(Leaderboard.Container.PlayerInspectorContainer.Animated.UIGradient, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Offset = Vector2.new(0, 0)
            })
        }
    }
};
u4.TweenCompletions = {
    u3.ToggleLeaderboard.Close.Container.Completed:Connect(function(p40) -- Line: 730
        -- upvalues: Leaderboard (copy), u2 (copy), u3 (ref), Inspector (copy), u1 (copy)
        if p40 == Enum.PlaybackState.Completed then
            Leaderboard.Container.Visible = false;

            if u2.InspectorOpen then
                for _, v in u3.TogglePlayerInspector.Open do
                    v:Cancel();
                end;

                for _, v in u3.TogglePlayerInspector.Close do
                    v:Cancel();
                end;

                Inspector.Position = UDim2.new(1, 160, 0, 0);
                Leaderboard.Container.PlayerInspectorContainer.Animated.UIGradient.Offset = Vector2.new(0, 0);
                Leaderboard.Container.PlayerInspectorContainer.Visible = false;
                Inspector.Parent = Leaderboard.Container.PlayerInspectorContainer.Animated;
                u2.LastInspectedUser = nil;
                u2.InspectorOpen = false;
                u1.UserInspectorVisible = false;
            end;
        end;
    end),
    u3.ToggleLeaderboard.Open.Toggle.Completed:Connect(function(p41) -- Line: 754
        -- upvalues: Leaderboard (copy)
        if p41 == Enum.PlaybackState.Completed then
            Leaderboard.Toggle.Visible = false;
        end;
    end),
    u3.ToggleLeaderboard.Close.Toggle.Completed:Connect(function(p42) -- Line: 759
        -- upvalues: u2 (copy)
        if p42 == Enum.PlaybackState.Completed then
            u2.LeaderboardClosing = false;
        end;
    end),
    u3.TogglePlayerInspector.Close.Inspector.Completed:Connect(function(p43) -- Line: 766
        -- upvalues: Leaderboard (copy), Inspector (copy)
        if p43 == Enum.PlaybackState.Completed then
            Leaderboard.Container.PlayerInspectorContainer.Visible = false;
            Inspector.Parent = Leaderboard.Container.PlayerInspectorContainer.Static;
        end;
    end),
    u3.TogglePlayerInspector.Open.Inspector.Completed:Connect(function(p44) -- Line: 772
        -- upvalues: Inspector (copy), Leaderboard (copy)
        if p44 == Enum.PlaybackState.Completed then
            Inspector.Parent = Leaderboard.Container.PlayerInspectorContainer.Static;
        end;
    end)
};
Leaderboard.Parent = Players.LocalPlayer.PlayerGui;
AvatarExaminer.Parent = Players.LocalPlayer.PlayerGui;
Leaderboard.Toggle.Position = UDim2.fromScale(1, 0);
Leaderboard.Toggle.Visible = true;
Leaderboard.Container.Position = UDim2.new(1, 500, 0, 0);
Leaderboard.Container.Visible = false;
Inspector.Position = UDim2.new(1, 160, 0, 0);
Inspector.Parent = Leaderboard.Container.PlayerInspectorContainer.Static;
Leaderboard.Container.PlayerInspectorContainer.Animated.UIGradient.Offset = Vector2.new(0, 0);
Leaderboard.Container.PlayerInspectorContainer.Visible = false;

if not Data.LeaderboardEnabled then
    u1:DisableLeaderboard();
end;

return u1;