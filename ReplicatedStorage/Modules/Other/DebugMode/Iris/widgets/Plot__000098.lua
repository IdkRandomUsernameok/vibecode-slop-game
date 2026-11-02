-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);

return function(u1, u2) -- Line: 3
    u1.WidgetConstructor("ProgressBar", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Format = 2
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p3) -- Line: 13
                return p3.Instance;
            end),
            changed = {
                Init = function(p4) -- Line: 17
                end,

                Get = function(p5) -- Line: 18
                    -- upvalues: u1 (copy)
                    return p5.lastChangedTick == u1._cycleTick;
                end
            }
        },

        Generate = function(p6) -- Line: 23, Name: Generate
            -- upvalues: u1 (copy), u2 (copy)
            local Frame = Instance.new("Frame");
            Frame.Name = "Iris_ProgressBar";
            Frame.Size = UDim2.new(u1._config.ItemWidth, UDim.new());
            Frame.BackgroundTransparency = 1;
            Frame.AutomaticSize = Enum.AutomaticSize.Y;
            Frame.LayoutOrder = p6.ZIndex;
            u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local Frame2 = Instance.new("Frame");
            Frame2.Name = "Bar";
            Frame2.Size = UDim2.new(u1._config.ContentWidth, u1._config.ContentHeight);
            Frame2.BackgroundColor3 = u1._config.FrameBgColor;
            Frame2.BackgroundTransparency = u1._config.FrameBgTransparency;
            Frame2.BorderSizePixel = 0;
            Frame2.AutomaticSize = Enum.AutomaticSize.Y;
            Frame2.ClipsDescendants = true;
            u2.applyFrameStyle(Frame2, true);
            Frame2.Parent = Frame;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "Progress";
            TextLabel.AutomaticSize = Enum.AutomaticSize.Y;
            TextLabel.Size = UDim2.new(UDim.new(0, 0), u1._config.ContentHeight);
            TextLabel.BackgroundColor3 = u1._config.PlotHistogramColor;
            TextLabel.BackgroundTransparency = u1._config.PlotHistogramTransparency;
            TextLabel.BorderSizePixel = 0;
            u2.applyTextStyle(TextLabel);
            u2.UIPadding(TextLabel, u1._config.FramePadding);
            u2.UICorner(TextLabel, u1._config.FrameRounding);
            TextLabel.Text = "";
            TextLabel.Parent = Frame2;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "Value";
            TextLabel2.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel2.Size = UDim2.new(UDim.new(0, 0), u1._config.ContentHeight);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.BorderSizePixel = 0;
            TextLabel2.ZIndex = 1;
            u2.applyTextStyle(TextLabel2);
            u2.UIPadding(TextLabel2, u1._config.FramePadding);
            TextLabel2.Parent = Frame2;
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.Name = "TextLabel";
            TextLabel3.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel3.AnchorPoint = Vector2.new(0, 0.5);
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.BorderSizePixel = 0;
            TextLabel3.LayoutOrder = 1;
            u2.applyTextStyle(TextLabel3);
            u2.UIPadding(TextLabel2, u1._config.FramePadding);
            TextLabel3.Parent = Frame;

            return Frame;
        end,

        GenerateState = function(p7) -- Line: 90, Name: GenerateState
            -- upvalues: u1 (copy)
            if p7.state.progress == nil then
                p7.state.progress = u1._widgetState(p7, "Progress", 0);
            end;
        end,

        Update = function(p8) -- Line: 95, Name: Update
            local Instance2 = p8.Instance;
            local TextLabel = Instance2.TextLabel;
            local Value = Instance2.Bar.Value;

            if p8.arguments.Format ~= nil and typeof(p8.arguments.Format) == "string" then
                Value.Text = p8.arguments.Format;
            end;

            TextLabel.Text = p8.arguments.Text or "Progress Bar";
        end,

        UpdateState = function(p9) -- Line: 107, Name: UpdateState
            -- upvalues: u1 (copy)
            local Bar = p9.Instance.Bar;
            local Progress = Bar.Progress;
            local Value = Bar.Value;
            local math_clamp_ret = math.clamp(p9.state.progress.value, 0, 1);

            if Value.AbsoluteSize.X > Bar.AbsoluteSize.X * (1 - math_clamp_ret) then
                Value.AnchorPoint = Vector2.xAxis;
                Value.Position = UDim2.fromScale(1, 0);
            else
                Value.AnchorPoint = Vector2.zero;
                Value.Position = UDim2.new(math_clamp_ret, 0, 0, 0);
            end;

            Progress.Size = UDim2.new(UDim.new(math_clamp_ret, 0), Progress.Size.Height);

            if p9.arguments.Format == nil or typeof(p9.arguments.Format) ~= "string" then
                Value.Text = string.format("%d%%", math_clamp_ret * 100);
            else
                Value.Text = p9.arguments.Format;
            end;

            p9.lastChangedTick = u1._cycleTick + 1;
        end,

        Discard = function(p10) -- Line: 133, Name: Discard
            -- upvalues: u2 (copy)
            p10.Instance:Destroy();
            u2.discardState(p10);
        end
    });

    local function createLine(p11: userdata, p12: number) -- Line: 139
        -- upvalues: u1 (copy)
        local Frame = Instance.new("Frame");
        Frame.Name = tostring(p12);
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.BackgroundColor3 = u1._config.PlotLinesColor;
        Frame.BackgroundTransparency = u1._config.PlotLinesTransparency;
        Frame.BorderSizePixel = 0;
        Frame.Parent = p11;

        return Frame;
    end;

    local function clearLine(p13) -- Line: 152
        -- upvalues: u1 (copy)
        if p13.HoveredLine then
            p13.HoveredLine.BackgroundColor3 = u1._config.PlotLinesColor;
            p13.HoveredLine.BackgroundTransparency = u1._config.PlotLinesTransparency;
            p13.HoveredLine = false;
            p13.state.hovered:set(nil);
        end;
    end;

    local function updateLine(p14) -- Line: 161
        -- upvalues: u2 (copy), u1 (copy)
        local Plot = p14.Instance.Background.Plot;
        local MouseLocation = u2.getMouseLocation();
        local math_ceil_ret = math.ceil((MouseLocation.X - (Plot.AbsolutePosition - u2.GuiOffset).X) / Plot.AbsoluteSize.X * #p14.Lines);
        local v15 = p14.Lines[math_ceil_ret];

        if v15 then
            if v15 ~= p14.HoveredLine and p14.HoveredLine then
                p14.HoveredLine.BackgroundColor3 = u1._config.PlotLinesColor;
                p14.HoveredLine.BackgroundTransparency = u1._config.PlotLinesTransparency;
                p14.HoveredLine = false;
                p14.state.hovered:set(nil);
            end;

            local v16 = p14.state.values.value[math_ceil_ret];
            local v17 = p14.state.values.value[math_ceil_ret + 1];

            if v16 and v17 then
                if math.floor(v16) == v16 and math.floor(v17) == v17 then
                    p14.Tooltip.Text = ("%d: %d\n%d: %d"):format(math_ceil_ret, v16, math_ceil_ret + 1, v17);
                else
                    p14.Tooltip.Text = ("%d: %.3f\n%d: %.3f"):format(math_ceil_ret, v16, math_ceil_ret + 1, v17);
                end;
            end;

            p14.HoveredLine = v15;
            v15.BackgroundColor3 = u1._config.PlotLinesHoveredColor;
            v15.BackgroundTransparency = u1._config.PlotLinesHoveredTransparency;
            p14.state.hovered:set({ v16, v17 });
        end;
    end;

    u1.WidgetConstructor("PlotLines", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Height = 2,
            Min = 3,
            Max = 4,
            TextOverlay = 5
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p18) -- Line: 205
                return p18.Instance;
            end)
        },

        Generate = function(u19) -- Line: 209, Name: Generate
            -- upvalues: u2 (copy), u1 (copy), updateLine (copy)
            local Frame = Instance.new("Frame");
            Frame.Name = "Iris_PlotLines";
            Frame.Size = UDim2.fromScale(1, 0);
            Frame.BackgroundTransparency = 1;
            Frame.BorderSizePixel = 0;
            Frame.ZIndex = u19.ZIndex;
            Frame.LayoutOrder = u19.ZIndex;
            u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local Frame2 = Instance.new("Frame");
            Frame2.Name = "Background";
            Frame2.Size = UDim2.new(u1._config.ContentWidth, UDim.new(1, 0));
            Frame2.BackgroundColor3 = u1._config.FrameBgColor;
            Frame2.BackgroundTransparency = u1._config.FrameBgTransparency;
            u2.applyFrameStyle(Frame2);
            Frame2.Parent = Frame;
            local Frame3 = Instance.new("Frame");
            Frame3.Name = "Plot";
            Frame3.Size = UDim2.fromScale(1, 1);
            Frame3.BackgroundTransparency = 1;
            Frame3.BorderSizePixel = 0;
            Frame3.ClipsDescendants = true;
            Frame3:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 237
                -- upvalues: u19 (copy), u1 (ref)
                u19.state.values.lastChangeTick = u1._cycleTick;
                u1._widgets.PlotLines.UpdateState(u19);
            end);
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "OverlayText";
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel.AnchorPoint = Vector2.new(0.5, 0);
            TextLabel.Size = UDim2.fromOffset(0, 0);
            TextLabel.Position = UDim2.fromScale(0.5, 0);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.BorderSizePixel = 0;
            TextLabel.ZIndex = 2;
            u2.applyTextStyle(TextLabel);
            TextLabel.Parent = Frame3;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "Iris_Tooltip";
            TextLabel2.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel2.Size = UDim2.fromOffset(0, 0);
            TextLabel2.BackgroundColor3 = u1._config.PopupBgColor;
            TextLabel2.BackgroundTransparency = u1._config.PopupBgTransparency;
            TextLabel2.BorderSizePixel = 0;
            TextLabel2.Visible = false;
            u2.applyTextStyle(TextLabel2);
            u2.UIStroke(TextLabel2, u1._config.PopupBorderSize, u1._config.BorderActiveColor, u1._config.BorderActiveTransparency);
            u2.UIPadding(TextLabel2, u1._config.WindowPadding);

            if u1._config.PopupRounding > 0 then
                u2.UICorner(TextLabel2, u1._config.PopupRounding);
            end;

            local v20 = u1._rootInstance and u1._rootInstance:FindFirstChild("PopupScreenGui");

            if v20 then
                v20 = v20:FindFirstChild("TooltipContainer");
            end;

            TextLabel2.Parent = v20;
            u19.Tooltip = TextLabel2;
            u2.applyMouseMoved(Frame3, function() -- Line: 277
                -- upvalues: updateLine (ref), u19 (copy)
                updateLine(u19);
            end);
            u2.applyMouseLeave(Frame3, function() -- Line: 281
                -- upvalues: u19 (copy), u1 (ref)
                local v21 = u19;

                if v21.HoveredLine then
                    v21.HoveredLine.BackgroundColor3 = u1._config.PlotLinesColor;
                    v21.HoveredLine.BackgroundTransparency = u1._config.PlotLinesTransparency;
                    v21.HoveredLine = false;
                    v21.state.hovered:set(nil);
                end;
            end);
            Frame3.Parent = Frame2;
            u19.Lines = {};
            u19.HoveredLine = false;
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.Name = "TextLabel";
            TextLabel3.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel3.Size = UDim2.fromOffset(0, 0);
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.BorderSizePixel = 0;
            TextLabel3.ZIndex = u19.ZIndex + 3;
            TextLabel3.LayoutOrder = u19.ZIndex + 3;
            u2.applyTextStyle(TextLabel3);
            TextLabel3.Parent = Frame;

            return Frame;
        end,

        GenerateState = function(p22) -- Line: 305, Name: GenerateState
            -- upvalues: u1 (copy)
            if p22.state.values == nil then
                p22.state.values = u1._widgetState(p22, "values", { 0, 1 });
            end;

            if p22.state.hovered == nil then
                p22.state.hovered = u1._widgetState(p22, "hovered", nil);
            end;
        end,

        Update = function(p23) -- Line: 313, Name: Update
            local Instance2 = p23.Instance;
            local OverlayText = Instance2.Background.Plot.OverlayText;
            Instance2.TextLabel.Text = p23.arguments.Text or "Plot Lines";
            OverlayText.Text = p23.arguments.TextOverlay or "";
            Instance2.Size = UDim2.new(1, 0, 0, p23.arguments.Height or 0);
        end,

        UpdateState = function(p24) -- Line: 324, Name: UpdateState
            -- upvalues: u1 (copy)
            if p24.state.hovered.lastChangeTick == u1._cycleTick then
                if p24.state.hovered.value then
                    p24.Tooltip.Visible = true;
                else
                    p24.Tooltip.Visible = false;
                end;
            end;

            if p24.state.values.lastChangeTick == u1._cycleTick then
                local Plot = p24.Instance.Background.Plot;
                local value = p24.state.values.value;
                local v25 = #value - 1;
                local v26 = #p24.Lines;
                local Min = p24.arguments.Min;
                local Max = p24.arguments.Max;

                if Min == nil or Max == nil then
                    for _, v in value do
                        Min = math.min(Min or v, v);
                        Max = math.max(Max or v, v);
                    end;
                end;

                if v26 < v25 then
                    for i = v26 + 1, v25 do
                        local Lines = p24.Lines;
                        local Frame = Instance.new("Frame");
                        Frame.Name = tostring(i);
                        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
                        Frame.BackgroundColor3 = u1._config.PlotLinesColor;
                        Frame.BackgroundTransparency = u1._config.PlotLinesTransparency;
                        Frame.BorderSizePixel = 0;
                        Frame.Parent = Plot;
                        table.insert(Lines, Frame);
                        local _ = i;
                    end;
                elseif v25 < v26 then
                    for i = v25 + 1, v26 do
                        local table_remove_ret = table.remove(p24.Lines);
                        local v27;

                        if table_remove_ret then
                            table_remove_ret:Destroy();
                            v27 = i;
                        else
                            v27 = i;
                        end;
                    end;
                end;

                local v28 = Max - Min;
                local AbsoluteSize = Plot.AbsoluteSize;

                for i = 1, v25 do
                    local v29 = value[i + 1];
                    local v30 = AbsoluteSize * Vector2.new((i - 1) / v25, (Max - value[i]) / v28);
                    local v31 = AbsoluteSize * Vector2.new(i / v25, (Max - v29) / v28);
                    local v32 = (v30 + v31) / 2;
                    p24.Lines[i].Size = UDim2.fromOffset((v31 - v30).Magnitude + 1, 1);
                    p24.Lines[i].Position = UDim2.fromOffset(v32.X, v32.Y);
                    p24.Lines[i].Rotation = math.atan2(v31.Y - v30.Y, v31.X - v30.X) * 57.29577951308232;
                    local _ = i;
                end;
            end;
        end,

        Discard = function(p33) -- Line: 387, Name: Discard
            -- upvalues: u2 (copy)
            p33.Instance:Destroy();
            u2.discardState(p33);
        end
    });

    local function createBlock(p34: userdata, p35: number) -- Line: 393
        -- upvalues: u1 (copy)
        local Frame = Instance.new("Frame");
        Frame.Name = tostring(p35);
        Frame.BackgroundColor3 = u1._config.PlotHistogramColor;
        Frame.BackgroundTransparency = u1._config.PlotHistogramTransparency;
        Frame.BorderSizePixel = 0;
        Frame.Parent = p34;

        return Frame;
    end;

    local function clearBlock(p36) -- Line: 405
        -- upvalues: u1 (copy)
        if p36.HoveredBlock then
            p36.HoveredBlock.BackgroundColor3 = u1._config.PlotHistogramColor;
            p36.HoveredBlock.BackgroundTransparency = u1._config.PlotHistogramTransparency;
            p36.HoveredBlock = false;
            p36.state.hovered:set(nil);
        end;
    end;

    local function updateBlock(p37) -- Line: 414
        -- upvalues: u2 (copy), u1 (copy)
        local Plot = p37.Instance.Background.Plot;
        local MouseLocation = u2.getMouseLocation();
        local math_ceil_ret = math.ceil((MouseLocation.X - (Plot.AbsolutePosition - u2.GuiOffset).X) / Plot.AbsoluteSize.X * #p37.Blocks);
        local v38 = p37.Blocks[math_ceil_ret];

        if v38 then
            if v38 ~= p37.HoveredBlock and p37.HoveredBlock then
                p37.HoveredBlock.BackgroundColor3 = u1._config.PlotHistogramColor;
                p37.HoveredBlock.BackgroundTransparency = u1._config.PlotHistogramTransparency;
                p37.HoveredBlock = false;
                p37.state.hovered:set(nil);
            end;

            local v39 = p37.state.values.value[math_ceil_ret];

            if v39 then
                local Tooltip = p37.Tooltip;
                local v40;

                if math.floor(v39) == v39 then
                    v40 = ("%d: %d"):format(math_ceil_ret, v39);
                else
                    v40 = ("%d: %.3f"):format(math_ceil_ret, v39);
                end;

                Tooltip.Text = v40;
            end;

            p37.HoveredBlock = v38;
            v38.BackgroundColor3 = u1._config.PlotHistogramHoveredColor;
            v38.BackgroundTransparency = u1._config.PlotHistogramHoveredTransparency;
            p37.state.hovered:set(v39);
        end;
    end;

    u1.WidgetConstructor("PlotHistogram", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Height = 2,
            Min = 3,
            Max = 4,
            TextOverlay = 5,
            BaseLine = 6
        },
        Events = {
            hovered = u2.EVENTS.hover(function(p41) -- Line: 454
                return p41.Instance;
            end)
        },

        Generate = function(u42) -- Line: 458, Name: Generate
            -- upvalues: u2 (copy), u1 (copy), updateBlock (copy)
            local Frame = Instance.new("Frame");
            Frame.Name = "Iris_PlotHistogram";
            Frame.Size = UDim2.fromScale(1, 0);
            Frame.BackgroundTransparency = 1;
            Frame.BorderSizePixel = 0;
            Frame.ZIndex = u42.ZIndex;
            Frame.LayoutOrder = u42.ZIndex;
            u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local Frame2 = Instance.new("Frame");
            Frame2.Name = "Background";
            Frame2.Size = UDim2.new(u1._config.ContentWidth, UDim.new(1, 0));
            Frame2.BackgroundColor3 = u1._config.FrameBgColor;
            Frame2.BackgroundTransparency = u1._config.FrameBgTransparency;
            u2.applyFrameStyle(Frame2);
            Frame2.UIPadding.PaddingRight = UDim.new(0, u1._config.FramePadding.X - 1);
            Frame2.Parent = Frame;
            local Frame3 = Instance.new("Frame");
            Frame3.Name = "Plot";
            Frame3.Size = UDim2.fromScale(1, 1);
            Frame3.BackgroundTransparency = 1;
            Frame3.BorderSizePixel = 0;
            Frame3.ClipsDescendants = true;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "OverlayText";
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel.AnchorPoint = Vector2.new(0.5, 0);
            TextLabel.Size = UDim2.fromOffset(0, 0);
            TextLabel.Position = UDim2.fromScale(0.5, 0);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.BorderSizePixel = 0;
            TextLabel.ZIndex = 2;
            u2.applyTextStyle(TextLabel);
            TextLabel.Parent = Frame3;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "Iris_Tooltip";
            TextLabel2.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel2.Size = UDim2.fromOffset(0, 0);
            TextLabel2.BackgroundColor3 = u1._config.PopupBgColor;
            TextLabel2.BackgroundTransparency = u1._config.PopupBgTransparency;
            TextLabel2.BorderSizePixel = 0;
            TextLabel2.Visible = false;
            u2.applyTextStyle(TextLabel2);
            u2.UIStroke(TextLabel2, u1._config.PopupBorderSize, u1._config.BorderActiveColor, u1._config.BorderActiveTransparency);
            u2.UIPadding(TextLabel2, u1._config.WindowPadding);

            if u1._config.PopupRounding > 0 then
                u2.UICorner(TextLabel2, u1._config.PopupRounding);
            end;

            local v43 = u1._rootInstance and u1._rootInstance:FindFirstChild("PopupScreenGui");

            if v43 then
                v43 = v43:FindFirstChild("TooltipContainer");
            end;

            TextLabel2.Parent = v43;
            u42.Tooltip = TextLabel2;
            u2.applyMouseMoved(Frame3, function() -- Line: 524
                -- upvalues: updateBlock (ref), u42 (copy)
                updateBlock(u42);
            end);
            u2.applyMouseLeave(Frame3, function() -- Line: 528
                -- upvalues: u42 (copy), u1 (ref)
                local v44 = u42;

                if v44.HoveredBlock then
                    v44.HoveredBlock.BackgroundColor3 = u1._config.PlotHistogramColor;
                    v44.HoveredBlock.BackgroundTransparency = u1._config.PlotHistogramTransparency;
                    v44.HoveredBlock = false;
                    v44.state.hovered:set(nil);
                end;
            end);
            Frame3.Parent = Frame2;
            u42.Blocks = {};
            u42.HoveredBlock = false;
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.Name = "TextLabel";
            TextLabel3.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel3.Size = UDim2.fromOffset(0, 0);
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.BorderSizePixel = 0;
            TextLabel3.ZIndex = u42.ZIndex + 3;
            TextLabel3.LayoutOrder = u42.ZIndex + 3;
            u2.applyTextStyle(TextLabel3);
            TextLabel3.Parent = Frame;

            return Frame;
        end,

        GenerateState = function(p45) -- Line: 552, Name: GenerateState
            -- upvalues: u1 (copy)
            if p45.state.values == nil then
                p45.state.values = u1._widgetState(p45, "values", { 1 });
            end;

            if p45.state.hovered == nil then
                p45.state.hovered = u1._widgetState(p45, "hovered", nil);
            end;
        end,

        Update = function(p46) -- Line: 560, Name: Update
            local Instance2 = p46.Instance;
            local OverlayText = Instance2.Background.Plot.OverlayText;
            Instance2.TextLabel.Text = p46.arguments.Text or "Plot Histogram";
            OverlayText.Text = p46.arguments.TextOverlay or "";
            Instance2.Size = UDim2.new(1, 0, 0, p46.arguments.Height or 0);
        end,

        UpdateState = function(p47) -- Line: 571, Name: UpdateState
            -- upvalues: u1 (copy), updateBlock (copy)
            if p47.state.hovered.lastChangeTick == u1._cycleTick then
                if p47.state.hovered.value then
                    p47.Tooltip.Visible = true;
                else
                    p47.Tooltip.Visible = false;
                end;
            end;

            if p47.state.values.lastChangeTick == u1._cycleTick then
                local Plot = p47.Instance.Background.Plot;
                local value = p47.state.values.value;
                local v48 = #value;
                local v49 = #p47.Blocks;
                local Min = p47.arguments.Min;
                local Max = p47.arguments.Max;
                local v50 = p47.arguments.BaseLine or 0;

                if Min == nil or Max == nil then
                    for _, v in value do
                        Min = math.min(Min or v, v);
                        Max = math.max(Max or v, v);
                    end;
                end;

                if v49 < v48 then
                    for i = v49 + 1, v48 do
                        local Blocks = p47.Blocks;
                        local Frame = Instance.new("Frame");
                        Frame.Name = tostring(i);
                        Frame.BackgroundColor3 = u1._config.PlotHistogramColor;
                        Frame.BackgroundTransparency = u1._config.PlotHistogramTransparency;
                        Frame.BorderSizePixel = 0;
                        Frame.Parent = Plot;
                        table.insert(Blocks, Frame);
                        local _ = i;
                    end;
                elseif v48 < v49 then
                    for i = v48 + 1, v49 do
                        local table_remove_ret = table.remove(p47.Blocks);
                        local v51;

                        if table_remove_ret then
                            table_remove_ret:Destroy();
                            v51 = i;
                        else
                            v51 = i;
                        end;
                    end;
                end;

                local v52 = Max - Min;
                local UDim_new_ret = UDim.new(1 / v48, -1);

                for i = 1, v48 do
                    local v53 = value[i];
                    local v54;

                    if v53 >= 0 then
                        p47.Blocks[i].Size = UDim2.new(UDim_new_ret, UDim.new((v53 - v50) / v52));
                        p47.Blocks[i].Position = UDim2.fromScale((i - 1) / v48, (Max - v53) / v52);
                        v54 = i;
                    else
                        p47.Blocks[i].Size = UDim2.new(UDim_new_ret, UDim.new((v50 - v53) / v52));
                        p47.Blocks[i].Position = UDim2.fromScale((i - 1) / v48, (Max - v50) / v52);
                        v54 = i;
                    end;
                end;

                if p47.HoveredBlock then
                    updateBlock(p47);
                end;
            end;
        end,

        Discard = function(p55) -- Line: 633, Name: Discard
            -- upvalues: u2 (copy)
            p55.Instance:Destroy();
            u2.discardState(p55);
        end
    });
end;