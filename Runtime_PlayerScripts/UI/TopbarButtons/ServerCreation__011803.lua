-- Decompiled with Potassium's decompiler.

local u1 = game:FindService("ReplicatedStorage");
local u2 = game:FindService("TweenService");
local RunService = game:GetService("RunService");

return function(p3, p4, p5, u6) -- Line: 5
    -- upvalues: RunService (copy), u1 (copy), u2 (copy)
    local ServerAge = p3.TopbarButtons.ServerAge;
    local PrivateServer = ServerAge.UIContainer.Lower.Container.PrivateServer;
    local Container = ServerAge.UIContainer.Upper.Container;
    local DeviceManager = require(p4.Main.DeviceManager);
    local TopbarIcon = require(p4.UI.TopbarIcon);
    local u7 = RunService:IsStudio();
    local ReserveServer = u1.Events.ReserveServer;
    local JoinServer = u1.Events.JoinServer;
    local u8 = true;
    local u9 = true;
    local u10 = u1.Events.GetServerType:InvokeServer();
    local u11 = TopbarIcon.new():setOrder(p5.Order):align(p5.Position):setImage(135693365339854):setImageScale(0.6):setEnabled(true):setName("Server Creation"):modifyTheme({
        { "IconLabel", "FontFace", Font.fromName("Montserrat", Enum.FontWeight.Bold, Enum.FontStyle.Normal) },
        { "IconLabel", "TextSize", 15 }
    }):bindEvent("viewingStarted", function() -- Line: 33
        -- upvalues: u6 (copy)
        u6:Play("Topbar/Hover");
    end):bindEvent("selected", function() -- Line: 36
        -- upvalues: u6 (copy), Container (copy), u2 (ref), ServerAge (copy)
        u6:Play("Topbar/Open");
        Container.CurrentServerContainer.CurrentServerID.Text = "XXXXXX";
        Container.CurrentServerContainer.ToggleVisibility.Text = "Show";
        u2:Create(ServerAge, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 0.5)
        }):Play();
    end):bindEvent("deselected", function() -- Line: 42
        -- upvalues: u6 (copy), u2 (ref), ServerAge (copy)
        u6:Play("Topbar/Open");
        u2:Create(ServerAge, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.fromScale(0.5, -0.5)
        }):Play();
    end):setCaption("Click to toggle the Server Info UI");
    u11:setGroup("SystemStickyButton_Center");
    PrivateServer.JoinServer.MouseButton1Click:Connect(function() -- Line: 50
        -- upvalues: u8 (ref), ReserveServer (copy)
        if not u8 then
            return;
        end;

        u8 = false;
        ReserveServer:FireServer();
    end);
    ReserveServer.OnClientEvent:Connect(function() -- Line: 56
        -- upvalues: u8 (ref)
        task.spawn(function() -- Line: 57
            -- upvalues: u8 (ref)
            task.wait(5);
            u8 = true;
        end);
    end);
    Container.JoinServerContainer.JoinButton.MouseButton1Click:Connect(function() -- Line: 63
        -- upvalues: u9 (ref), JoinServer (copy), Container (copy)
        if not u9 then
            return;
        end;

        u9 = false;
        JoinServer:FireServer(Container.JoinServerContainer.JoinInput.Text);
    end);
    Container.CurrentServerContainer.ToggleVisibility.MouseButton1Click:Connect(function() -- Line: 69
        -- upvalues: Container (copy), u7 (copy), u10 (copy)
        local ToggleVisibility = Container.CurrentServerContainer.ToggleVisibility;

        if ToggleVisibility.Text == "Show" then
            ToggleVisibility.Text = "Hide";
            Container.CurrentServerContainer.CurrentServerID.Text = u7 and "N/A (Studio)" or (u10.Type == "VIPServer" and "N/A (VIP Serv.)" or u10.ID);

            return;
        end;

        ToggleVisibility.Text = "Show";
        Container.CurrentServerContainer.CurrentServerID.Text = "XXXXXX";
    end);
    JoinServer.OnClientEvent:Connect(function() -- Line: 81
        -- upvalues: u9 (ref)
        task.spawn(function() -- Line: 82
            -- upvalues: u9 (ref)
            task.wait(5);
            u9 = true;
        end);
    end);
    DeviceManager.deviceChanged:Connect(function() -- Line: 88, Name: updateLabel
        -- upvalues: DeviceManager (copy), u11 (copy)
        if DeviceManager.currentDevice == "Mobile" then
            u11:setLabel("");

            return;
        end;

        u11:setLabel("Create/Join a Server");
    end);

    if DeviceManager.currentDevice == "Mobile" then
        u11:setLabel("");
    else
        u11:setLabel("Create/Join a Server");
    end;

    Container.CurrentServerContainer.CurrentServerID.Text = "XXXXXX";

    return {
        setEnabled = function(p12, p13) -- Line: 103, Name: setEnabled
            -- upvalues: u11 (copy)
            u11:setEnabled(p13);
        end,

        deselect = function() -- Line: 106, Name: deselect
            -- upvalues: u11 (copy)
            u11:deselect();
        end,

        icon = u11
    };
end;