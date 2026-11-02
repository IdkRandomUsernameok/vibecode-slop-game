-- Decompiled with Potassium's decompiler.

game:FindService("ReplicatedStorage");
local u1 = game:FindService("RunService");
local u2 = game:FindService("TweenService");
game:GetService("Players");
local u3 = {};
local u4 = nil;

return function(p5, p6, p7, u8) -- Line: 9
    -- upvalues: u3 (ref), u4 (ref), u1 (copy), u2 (copy)
    local TopbarIcon = require(p6.UI.TopbarIcon);
    local Rules = require(p6:WaitForChild("Other"):WaitForChild("Rules"));
    local u9 = require(p6.Other.VirtualCursorManager).new();
    local RomanNumbers = require(p6.Lib.RomanNumbers);
    local Rules2 = p5.TopbarButtons.Rules;

    local function fetchRules() -- Line: 18
        -- upvalues: Rules2 (copy), u3 (ref), u4 (ref), u1 (ref), Rules (copy), RomanNumbers (copy)
        if Rules2.Rules.Loading.Visible then
            return;
        end;

        for _, v in u3 do
            local _ = v and v:Destroy();
        end;

        u3 = {};
        Rules2.Rules.Loading.Visible = true;
        u4 = u1.RenderStepped:Connect(function(p10: number) -- Line: 28
            -- upvalues: Rules2 (ref)
            local Icon = Rules2.Rules.Loading.Icon.Icon;
            Icon.Rotation = Icon.Rotation - p10 * 180;
        end);

        for i, v in Rules:Get() do
            local v11 = Rules2.Rules.ScrollingFrame.Template:Clone();
            local v12 = `<b><font size="38">{v.name}</font></b>\n{v.description}`;

            if v.punishment then
                local v13 = `<b><font size="38">[{v.punishment}]</font></b>`;

                if v.punishmentColor then
                    v13 = `<font color="{v.punishmentColor}">{v13}</font>` or v13;
                end;

                v12 = `{v13} {v12}`;
            end;

            local v14, v15;

            if v.fields then
                v14 = v;
                v15 = i;

                for i2, v2 in v.fields do
                    local v16 = `\n\t\t<b>{string.char(64 + i2):lower()}.</b> {v2.text}`;

                    if v2.color then
                        v16 = `<font color="{v2.color}">{v16}</font>` or v16;
                    end;

                    v12 = v12 .. v16;

                    if v2.fields then
                        for i3, v3 in v2.fields do
                            local v17 = `\n\t\t\t\t<b>{RomanNumbers.ToRomanNumerals(i3)}.</b> {v3.text}`;

                            if v3.color then
                                v17 = `<font color="{v3.color}">{v17}</font>` or v17;
                            end;

                            v12 = v12 .. v17;
                        end;
                    end;
                end;
            else
                v14 = v;
                v15 = i;
            end;

            v11.Text = v12;
            v11.Parent = Rules2.Rules.ScrollingFrame;
            v11.LayoutOrder = v15;
            v11.Name = v14.name;
            v11.Visible = true;
            table.insert(u3, v11);
        end;

        Rules2.Rules.Loading.Visible = false;
        u4:Disconnect();
        Rules2.Rules.Loading.Icon.Icon.Rotation = 0;
    end;

    fetchRules();
    local u18 = TopbarIcon.new():setImage(109289260280963):setImageScale(0.5):setLabel("", "Closed"):setLabel("Rules", "Open"):setLabel("Rules", "Viewing"):setOrder(p7.Order):align(p7.Position):modifyTheme({
        { "IconLabel", "FontFace", Font.fromName("Montserrat", Enum.FontWeight.Bold, Enum.FontStyle.Normal) },
        { "IconLabel", "TextSize", 15 }
    }):setCaption("Click to show the In-Game Rules"):bindEvent("viewingStarted", function() -- Line: 87
        -- upvalues: u8 (copy)
        u8:Play("Topbar/Hover");
    end):bindEvent("selected", function() -- Line: 90
        -- upvalues: u8 (copy), u2 (ref), Rules2 (copy), fetchRules (copy)
        u8:Play("Topbar/Open");
        u2:Create(Rules2, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 0.5)
        }):Play();
        fetchRules();
    end):bindEvent("deselected", function() -- Line: 95
        -- upvalues: u8 (copy), u2 (ref), Rules2 (copy), u9 (copy)
        u8:Play("Topbar/Open");
        u2:Create(Rules2, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.fromScale(0.5, -0.5)
        }):Play();
        u9:Disable();
    end);
    u18:setGroup("SystemButton_InfoRight");

    return {
        setEnabled = function(p19, p20) -- Line: 104, Name: setEnabled
            -- upvalues: u18 (ref)
            u18:setEnabled(p20);
        end,

        deselect = function() -- Line: 107, Name: deselect
            -- upvalues: u18 (ref)
            u18:deselect();
        end,

        icon = u18
    };
end;