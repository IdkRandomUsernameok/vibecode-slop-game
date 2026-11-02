-- Decompiled with Potassium's decompiler.

local StarterGui = game:GetService("StarterGui");
game:GetService("ReplicatedStorage");

return function(p1, p2, p3, u4) -- Line: 4
    -- upvalues: StarterGui (copy)
    local TopbarIcon = require(p2.UI.TopbarIcon);
    local DeviceManager = require(p2.Main.DeviceManager);
    local u5 = nil;
    local u6 = true;
    local u9 = {
        setEnabled = function(p7, p8) -- Line: 12, Name: setEnabled
            -- upvalues: DeviceManager (copy), u6 (ref), u5 (ref)
            local currentDevice = DeviceManager.currentDevice;

            if currentDevice ~= "Console" and currentDevice ~= "Mobile" then
                p8 = false;
            end;

            u6 = p8;
            u5:setEnabled(p8);
        end,

        deselect = function() -- Line: 23, Name: deselect
            -- upvalues: u5 (ref)
            u5:deselect();
        end,

        icon = u5
    };
    u5 = TopbarIcon.new():setImage(10885640682):setImageScale(0.5):setLabel("", "Closed"):setLabel("Dev Console", "Open"):setLabel("Dev Console", "Viewing"):setOrder(p3.Order):align(p3.Position):modifyTheme({
        { "IconLabel", "FontFace", Font.fromName("Montserrat", Enum.FontWeight.Bold, Enum.FontStyle.Normal) },
        { "IconLabel", "TextSize", 15 }
    }):setCaption("Click to open the Roblox Developer Console"):oneClick(true):bindEvent("viewingStarted", function() -- Line: 43
        -- upvalues: u4 (copy)
        u4:Play("Topbar/Hover");
    end):bindEvent("selected", function() -- Line: 46
        -- upvalues: u4 (copy), StarterGui (ref)
        u4:Play("Topbar/Open");
        StarterGui:SetCore("DevConsoleVisible", true);
    end);
    u5:setGroup("SystemStickyButton_Center");
    DeviceManager.deviceChanged:Connect(function() -- Line: 53
        -- upvalues: u9 (copy), u6 (ref)
        u9:setEnabled(u6);
    end);

    return u9;
end;