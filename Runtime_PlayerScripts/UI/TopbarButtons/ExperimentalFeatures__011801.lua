-- Decompiled with Potassium's decompiler.

game:FindService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");

return function(p1, p2, p3, u4) -- Line: 6
    -- upvalues: TweenService (copy), RunService (copy), GuiService (copy)
    local ExperimentalNotice = p1.TopbarButtons.ExperimentalNotice;
    local ExperimentalNotificationHandler = p1.TopbarButtons.ExperimentalNotificationHandler;
    local TopbarIcon = require(p2.UI.TopbarIcon);
    local ExperimentalFeatures = require(p2.Other.ExperimentalFeatures);
    local u5 = require(p2.Other.VirtualCursorManager).new();
    local u6 = 0;
    local u7 = true;
    local u8 = false;
    local u9 = {};
    local u10 = {};
    local u11 = {};
    local u12 = {
        { "IconLabel", "FontFace", Font.fromName("Montserrat", Enum.FontWeight.Bold, Enum.FontStyle.Normal) },
        { "IconLabel", "TextSize", 15 },
        { "IconGradient", "Color", ColorSequence.new(Color3.fromHex("#0044ff"), Color3.fromHex("#07ff24")) },
        { "IconSpotGradient", "Color", ColorSequence.new(Color3.fromHex("#0044ff"), Color3.fromHex("#07ff24")) },
        { "IconSpotGradient", "Rotation", 0 }
    };
    ExperimentalNotice.Visible = true;
    local u13 = TopbarIcon.new():setImage(132396415044039):setImageScale(0.5):setOrder(p3.Order):align(p3.Position):setLabel("", "Closed"):setLabel("Experimental Features", "Open"):setLabel("Experimental Features", "Viewing"):setCaption("Click to show the Experimental Features Menu"):modifyTheme(u12):bindEvent("viewingStarted", function() -- Line: 43
        -- upvalues: u4 (copy)
        u4:Play("Topbar/Hover");
    end):bindEvent("selected", function() -- Line: 46
        -- upvalues: u4 (copy), TweenService (ref), ExperimentalNotice (copy), u5 (copy)
        u4:Play("Topbar/Open");
        TweenService:Create(ExperimentalNotice, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 0.5)
        }):Play();
        task.delay(0.16, function() -- Line: 49
            -- upvalues: u5 (ref), ExperimentalNotice (ref)
            u5:Enable(ExperimentalNotice);
        end);
    end):bindEvent("deselected", function() -- Line: 53
        -- upvalues: u4 (copy), TweenService (ref), ExperimentalNotice (copy), u5 (copy)
        u4:Play("Topbar/Open");
        TweenService:Create(ExperimentalNotice, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.fromScale(0.5, -0.5)
        }):Play();
        u5:Disable();
    end);

    local function updateLabel() -- Line: 59
        -- upvalues: ExperimentalFeatures (copy), u10 (copy), u13 (copy), u7 (ref), u8 (ref), ExperimentalNotice (copy), u11 (ref)
        local v14 = ExperimentalFeatures:ListEnabled();

        for _, v in u10 do
            v:Destroy();
        end;

        table.clear(u10);

        if #v14 > 0 then
            u13:setEnabled(u7);
            u8 = u7;

            for _, v in v14 do
                local v15 = ExperimentalFeatures:Format(v);
                local v16 = ExperimentalNotice.List.ScrollingFrame.Template:Clone();
                v16.Visible = true;
                v16.Title.Text = `{v15.name} <i><font transparency="0.5" size="18">\{{v15.id}}</font></i>`;
                v16.Desc.Text = v15.desc;
                v16.Name = v15.id;
                v16.Parent = ExperimentalNotice.List.ScrollingFrame;
                table.insert(u10, v16);
            end;
        else
            u13:setEnabled(false);
            u13:deselect();
            u8 = false;
        end;

        u11 = table.clone(v14);
    end;

    local function getHSV(p17: number) -- Line: 86
        return Color3.fromHSV(p17 % 360 / 360, 1, 1);
    end;

    local function update(p18) -- Line: 90
        -- upvalues: u8 (ref), u9 (copy), u6 (ref), getHSV (copy), ExperimentalNotice (copy), u12 (copy), u13 (copy)
        if not u8 and #u9 == 0 then
            return;
        end;

        u6 = u6 + p18 * 60;
        local ColorSequence_new_ret = ColorSequence.new(Color3.fromHSV(u6 % 360 / 360, 1, 1), getHSV(u6 + 60));
        ExperimentalNotice.UIGradient.Color = ColorSequence_new_ret;
        ExperimentalNotice.UIStroke.UIGradient.Color = ColorSequence_new_ret;
        u12[3][3] = ColorSequence_new_ret;
        u12[4][3] = ColorSequence_new_ret;
        u13:modifyTheme(u12);

        for _, v in u9 do
            v.obj.DisplayContent.UIGradient.Color = ColorSequence_new_ret;
            v.obj.DisplayContent.UIStroke.UIGradient.Color = ColorSequence_new_ret;
            v.lifeTime = v.lifeTime - p18;

            if v.lifeTime <= 0 then
                v.startEnd();
            end;
        end;
    end;

    local ExperimentalNotificationTemplate = ExperimentalNotificationHandler.ExperimentalNotificationTemplate;

    local function showExperimentsNotification(p19: string, p20: string) -- Line: 115
        -- upvalues: ExperimentalNotificationTemplate (copy), ExperimentalNotificationHandler (copy), TweenService (ref), u9 (copy)
        local u21 = ExperimentalNotificationTemplate:Clone();
        u21.DisplayContent.Title.Text = p19;
        u21.DisplayContent.List.Text = p20;
        u21.Parent = ExperimentalNotificationHandler;
        u21.Visible = true;
        local u22 = {};
        u22 = {
            lifeTime = 7.5,
            startedEnd = false,
            obj = u21,

            startEnd = function() -- Line: 127, Name: startEnd
                -- upvalues: u22 (ref), TweenService (ref), u21 (copy), u9 (ref)
                if u22.startedEnd then
                    return;
                end;

                u22.startedEnd = true;
                TweenService:Create(u21.DisplayContent, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                    Position = UDim2.fromScale(2.5, 0)
                }):Play();
                task.delay(1.5, function() -- Line: 132
                    -- upvalues: u9 (ref), u22 (ref)
                    local table_find_ret = table.find(u9, u22);
                    local _ = table_find_ret and table.remove(u9, table_find_ret);
                    u22.obj:Destroy();
                end);
            end
        };
        table.insert(u9, u22);
        TweenService:Create(u21.DisplayContent, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(1, 0)
        }):Play();
    end;

    RunService.RenderStepped:Connect(update);
    ExperimentalFeatures.Updated:Connect(function() -- Line: 146
        -- upvalues: ExperimentalFeatures (copy), u11 (ref), updateLabel (copy), showExperimentsNotification (copy)
        local v23 = ExperimentalFeatures:ListEnabled();
        local v24 = {};
        local v25 = {};
        local v26 = {};
        local v27 = {};

        for _, v in u11 do
            v24[v] = true;
        end;

        for _, v in v23 do
            v25[v] = true;
        end;

        for _, v in v23 do
            if not v24[v] then
                table.insert(v26, v);
            end;
        end;

        for _, v in u11 do
            if not v25[v] then
                table.insert(v27, v);
            end;
        end;

        updateLabel();

        if #v26 > 0 then
            local v28 = "";

            for _, v in v26 do
                local v29 = ExperimentalFeatures:Format(v);
                v28 = v28 .. (v28:len() > 0 and `\n{v29.name}` or `{v29.name}`);
            end;

            showExperimentsNotification(`The following experimental feature{#v26 == 1 and "" or "s"} have been enabled:`, v28);
        end;

        if #v27 > 0 then
            local v30 = "";

            for _, v in v27 do
                local v31 = ExperimentalFeatures:Format(v);
                v30 = v30 .. (v30:len() > 0 and `\n{v31.name}` or `{v31.name}`);
            end;

            showExperimentsNotification(`The following experimental feature{#v27 == 1 and "" or "s"} have been disabled:`, v30);
        end;
    end);
    updateLabel();
    ExperimentalNotificationHandler.Size = UDim2.new(1, -30, 1, -GuiService.TopbarInset.Height - 30);
    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function() -- Line: 199
        -- upvalues: ExperimentalNotificationHandler (copy), GuiService (ref)
        ExperimentalNotificationHandler.Size = UDim2.new(1, -30, 1, -GuiService.TopbarInset.Height - 30);
    end);

    return {
        setEnabled = function(p32, p33) -- Line: 204, Name: setEnabled
            -- upvalues: u7 (ref), updateLabel (copy)
            u7 = p33;
            updateLabel();
        end,

        deselect = function() -- Line: 208, Name: deselect
            -- upvalues: u13 (copy)
            u13:deselect();
        end,

        icon = u13
    };
end;