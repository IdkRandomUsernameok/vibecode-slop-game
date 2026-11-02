-- Decompiled with Potassium's decompiler.

local u1 = game:FindService("ReplicatedStorage");
local u2 = game:FindService("TweenService");

return function(p3, p4, p5, u6) -- Line: 4
    -- upvalues: u1 (copy), u2 (copy)
    local Changelog = p3.TopbarButtons.Changelog;
    local TopbarIcon = require(p4.UI.TopbarIcon);
    local u7 = require(p4.Other.VirtualCursorManager).new();
    local v8 = u1:WaitForChild("Events").RequestChangelog:InvokeServer();
    local script_Assets = script.Assets;
    local u9 = TopbarIcon.new():setImage(114127804740858):setImageScale(0.5):setLabel("", "Closed"):setLabel("Changelogs", "Open"):setLabel("Changelogs", "Viewing"):setOrder(p5.Order):align(p5.Position):setCaption("Click to show the Current Update\'s Changelogs"):modifyTheme({
        { "IconLabel", "FontFace", Font.fromName("Montserrat", Enum.FontWeight.Bold, Enum.FontStyle.Normal) },
        { "IconLabel", "TextSize", 15 }
    }):bindEvent("viewingStarted", function() -- Line: 24
        -- upvalues: u6 (copy)
        u6:Play("Topbar/Hover");
    end):bindEvent("selected", function() -- Line: 27
        -- upvalues: u6 (copy), u2 (ref), Changelog (copy), u7 (copy)
        u6:Play("Topbar/Open");
        u2:Create(Changelog, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 0.5)
        }):Play();
        task.delay(0.16, function() -- Line: 30
            -- upvalues: u7 (ref), Changelog (ref)
            u7:Enable(Changelog);
        end);
    end):bindEvent("deselected", function() -- Line: 34
        -- upvalues: u6 (copy), u2 (ref), Changelog (copy), u7 (copy)
        u6:Play("Topbar/Open");
        u2:Create(Changelog, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.fromScale(0.5, -0.5)
        }):Play();
        u7:Disable();
    end);
    u9:setGroup("SystemButton_InfoRight");
    Changelog.Title.Text = `{v8.UpdateName} — Last Updated {v8.Date}`;

    local function CreateText(p10: string, p11: any, p12: userdata?) -- Line: 44
        -- upvalues: script_Assets (copy), Changelog (copy)
        local v13 = script_Assets[`{p11.Type}Text`]:Clone();
        local string_split_ret = string.split(p10, "\n");
        v13.Size = UDim2.new(1, 0, 0, #string_split_ret * v13.Size.Y.Offset);
        v13.Parent = p12 or Changelog.Changelog.ScrollingFrame;
        v13.Label.Text = p10;
        v13.BackgroundColor3 = p11.Color or Color3.new(1, 1, 1);

        if not v13.Parent:IsA("ScrollingFrame") then
            local Size = v13.Parent.Size;
            v13.Parent.Size = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale, Size.Y.Offset + 4 + v13.AbsoluteSize.Y);
            v13.LayoutOrder = #v13.Parent:GetChildren();
        end;

        v13.Visible = true;

        return v13;
    end;

    local v14 = nil;

    for _, v in v8.Updates do
        local v15;

        if v.Type == "Major" or not v14 then
            v15 = nil;
        else
            v15 = v14;
        end;

        local v16 = CreateText(v.Text, v, v15);

        if v.Type == "Major" then
            if v14 then
                local Size = v14.Size;
                v14.Size = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale, Size.Y.Offset + 12);
            end;

            v14 = v16;
        end;
    end;

    return {
        setEnabled = function(p17, p18) -- Line: 78, Name: setEnabled
            -- upvalues: u9 (copy)
            u9:setEnabled(p18);
        end,

        deselect = function() -- Line: 81, Name: deselect
            -- upvalues: u9 (copy)
            u9:deselect();
        end,

        icon = u9
    };
end;