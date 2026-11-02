-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);

return function(u1, u2) -- Line: 3
    local u3 = false;
    local u4 = nil;
    local u5 = {};

    local function EmptyMenuStack(p6: number?) -- Line: 8
        -- upvalues: u5 (copy), u1 (copy), u3 (ref), u4 (ref)
        for i = #u5, p6 and p6 + 1 or 1, -1 do
            local v7 = u5[i];
            v7.state.isOpened:set(false);
            v7.Instance.BackgroundColor3 = u1._config.HeaderColor;
            v7.Instance.BackgroundTransparency = 1;
            table.remove(u5, i);
            local _ = i;
        end;

        if #u5 == 0 then
            u3 = false;
            u4 = nil;
        end;
    end;

    local function UpdateChildContainerTransform(p8) -- Line: 25
        -- upvalues: u2 (copy), u1 (copy)
        local v9 = p8.parentWidget.type == "Menu";
        local Instance2 = p8.Instance;
        local ChildContainer = p8.ChildContainer;
        ChildContainer.Size = UDim2.fromOffset(Instance2.AbsoluteSize.X, 0);

        if ChildContainer.Parent == nil then
            return;
        end;

        local v10 = Instance2.AbsolutePosition - u2.GuiOffset;
        local AbsoluteSize = Instance2.AbsoluteSize;
        local AbsoluteSize2 = ChildContainer.AbsoluteSize;
        local PopupBorderSize = u1._config.PopupBorderSize;
        local AbsoluteSize3 = ChildContainer.Parent.AbsoluteSize;
        local X = v10.X;
        local Vector2_zero = Vector2.zero;

        if v9 then
            if v10.X + AbsoluteSize2.X > AbsoluteSize3.X then
                Vector2_zero = Vector2.xAxis;
            else
                X = v10.X + AbsoluteSize.X;
            end;
        end;

        local v11;

        if v10.Y + AbsoluteSize2.Y > AbsoluteSize3.Y then
            v11 = v10.Y - PopupBorderSize + (v9 and AbsoluteSize.Y or 0);
            Vector2_zero = Vector2_zero + Vector2.yAxis;
        else
            v11 = v10.Y + PopupBorderSize + (v9 and 0 or AbsoluteSize.Y);
        end;

        ChildContainer.Position = UDim2.fromOffset(X, v11);
        ChildContainer.AnchorPoint = Vector2_zero;
    end;

    u2.registerEvent("InputBegan", function(p12: userdata) -- Line: 65
        -- upvalues: u1 (copy), u3 (ref), u4 (ref), u2 (copy), u5 (copy), EmptyMenuStack (copy)
        if not u1._started then
            return;
        end;

        if p12.UserInputType ~= Enum.UserInputType.MouseButton1 and p12.UserInputType ~= Enum.UserInputType.MouseButton2 then
            return;
        end;

        if u3 == false then
            return;
        end;

        if u4 == nil then
            return;
        end;

        local MouseLocation = u2.getMouseLocation();
        local v13 = false;

        for _, v in u5 do
            for _, v2 in { v.ChildContainer, v.Instance } do
                local v14 = v2.AbsolutePosition - u2.GuiOffset;

                if u2.isPosInsideRect(MouseLocation, v14, v14 + v2.AbsoluteSize) then
                    v13 = true;
                    break;
                end;
            end;

            if v13 then
                break;
            end;
        end;

        if not v13 then
            EmptyMenuStack();
        end;
    end);
    u1.WidgetConstructor("MenuBar", {
        hasState = false,
        hasChildren = true,
        Args = {},
        Events = {},

        Generate = function(p15) -- Line: 107, Name: Generate
            -- upvalues: u1 (copy), u2 (copy)
            local Frame = Instance.new("Frame");
            Frame.Name = "Iris_MenuBar";
            Frame.Size = UDim2.fromScale(1, 0);
            Frame.AutomaticSize = Enum.AutomaticSize.Y;
            Frame.BackgroundColor3 = u1._config.MenubarBgColor;
            Frame.BackgroundTransparency = u1._config.MenubarBgTransparency;
            Frame.BorderSizePixel = 0;
            Frame.LayoutOrder = p15.ZIndex;
            Frame.ClipsDescendants = true;
            u2.UIPadding(Frame, Vector2.new(u1._config.WindowPadding.X, 1));
            u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new()).VerticalAlignment = Enum.VerticalAlignment.Center;
            u2.applyFrameStyle(Frame, true, true);

            return Frame;
        end,

        Update = function(p16) -- Line: 124, Name: Update
        end,

        ChildAdded = function(p17, p18) -- Line: 127, Name: ChildAdded
            return p17.Instance;
        end,

        Discard = function(p19) -- Line: 130, Name: Discard
            p19.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("Menu", {
        hasState = true,
        hasChildren = true,
        Args = {
            Text = 1
        },
        Events = {
            clicked = u2.EVENTS.click(function(p20) -- Line: 143
                return p20.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p21) -- Line: 146
                return p21.Instance;
            end),
            opened = {
                Init = function(p22) -- Line: 150
                end,

                Get = function(p23) -- Line: 151
                    -- upvalues: u1 (copy)
                    return p23.lastOpenedTick == u1._cycleTick;
                end
            },
            closed = {
                Init = function(p24) -- Line: 156
                end,

                Get = function(p25) -- Line: 157
                    -- upvalues: u1 (copy)
                    return p25.lastClosedTick == u1._cycleTick;
                end
            }
        },

        Generate = function(u26) -- Line: 162, Name: Generate
            -- upvalues: u1 (copy), u2 (copy), u5 (copy), u3 (ref), u4 (ref), EmptyMenuStack (copy)
            u26.ButtonColors = {
                Transparency = 1,
                Color = u1._config.HeaderColor,
                HoveredColor = u1._config.HeaderHoveredColor,
                HoveredTransparency = u1._config.HeaderHoveredTransparency,
                ActiveColor = u1._config.HeaderHoveredColor,
                ActiveTransparency = u1._config.HeaderHoveredTransparency
            };
            local v27;

            if u26.parentWidget.type == "Menu" then
                v27 = Instance.new("TextButton");
                v27.Name = "Menu";
                v27.BackgroundColor3 = u1._config.HeaderColor;
                v27.BackgroundTransparency = 1;
                v27.BorderSizePixel = 0;
                v27.Size = UDim2.fromScale(1, 0);
                v27.Text = "";
                v27.AutomaticSize = Enum.AutomaticSize.Y;
                v27.LayoutOrder = u26.ZIndex;
                v27.AutoButtonColor = false;
                local v28 = u2.UIPadding(v27, u1._config.FramePadding);
                v28.PaddingTop = v28.PaddingTop - UDim.new(0, 1);
                u2.UIListLayout(v27, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local TextLabel = Instance.new("TextLabel");
                TextLabel.Name = "TextLabel";
                TextLabel.BackgroundTransparency = 1;
                TextLabel.BorderSizePixel = 0;
                TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
                u2.applyTextStyle(TextLabel);
                TextLabel.Parent = v27;
                local v29 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
                local v30 = v29 - math.round(v29 * 0.2) * 2;
                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.Name = "Icon";
                ImageLabel.Size = UDim2.fromOffset(v30, v30);
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.BorderSizePixel = 0;
                ImageLabel.ImageColor3 = u1._config.TextColor;
                ImageLabel.ImageTransparency = u1._config.TextTransparency;
                ImageLabel.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE;
                ImageLabel.LayoutOrder = 1;
                ImageLabel.Parent = v27;
            else
                v27 = Instance.new("TextButton");
                v27.Name = "Menu";
                v27.AutomaticSize = Enum.AutomaticSize.XY;
                v27.Size = UDim2.fromScale(0, 0);
                v27.BackgroundColor3 = u1._config.HeaderColor;
                v27.BackgroundTransparency = 1;
                v27.BorderSizePixel = 0;
                v27.Text = "";
                v27.LayoutOrder = u26.ZIndex;
                v27.AutoButtonColor = false;
                v27.ClipsDescendants = true;
                u2.applyTextStyle(v27);
                u2.UIPadding(v27, Vector2.new(u1._config.ItemSpacing.X, u1._config.FramePadding.Y));
            end;

            u2.applyInteractionHighlights("Background", v27, v27, u26.ButtonColors);
            u2.applyButtonClick(v27, function() -- Line: 232
                -- upvalues: u5 (ref), u26 (copy), u3 (ref), u4 (ref)
                local v31 = #u5 > 1 and true or not u26.state.isOpened.value;
                u26.state.isOpened:set(v31);
                u3 = v31;
                u4 = v31 and u26 or nil;

                if #u5 <= 1 then
                    if v31 then
                        table.insert(u5, u26);

                        return;
                    end;

                    table.remove(u5);
                end;
            end);
            u2.applyMouseEnter(v27, function() -- Line: 248
                -- upvalues: u3 (ref), u4 (ref), u26 (copy), u5 (ref), EmptyMenuStack (ref)
                if u3 and (u4 and u4 ~= u26) then
                    EmptyMenuStack((table.find(u5, u26.parentWidget)));
                    u26.state.isOpened:set(true);
                    u4 = u26;
                    u3 = true;
                    table.insert(u5, u26);
                end;
            end);
            local ScrollingFrame = Instance.new("ScrollingFrame");
            ScrollingFrame.Name = "MenuContainer";
            ScrollingFrame.BackgroundColor3 = u1._config.PopupBgColor;
            ScrollingFrame.BackgroundTransparency = u1._config.PopupBgTransparency;
            ScrollingFrame.BorderSizePixel = 0;
            ScrollingFrame.Size = UDim2.fromOffset(0, 0);
            ScrollingFrame.AutomaticSize = Enum.AutomaticSize.XY;
            ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            ScrollingFrame.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency;
            ScrollingFrame.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor;
            ScrollingFrame.ScrollBarThickness = u1._config.ScrollbarSize;
            ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0);
            ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
            ScrollingFrame.ZIndex = 6;
            ScrollingFrame.LayoutOrder = 6;
            ScrollingFrame.ClipsDescendants = true;
            u2.UIStroke(ScrollingFrame, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency);
            u2.UIPadding(ScrollingFrame, Vector2.new(2, u1._config.WindowPadding.Y - u1._config.ItemSpacing.Y));
            u2.UIListLayout(ScrollingFrame, Enum.FillDirection.Vertical, UDim.new(0, 1)).VerticalAlignment = Enum.VerticalAlignment.Top;
            local v32 = u1._rootInstance and u1._rootInstance:FindFirstChild("PopupScreenGui");
            ScrollingFrame.Parent = v32;
            u26.ChildContainer = ScrollingFrame;

            return v27;
        end,

        Update = function(p33) -- Line: 298, Name: Update
            local Instance2 = p33.Instance;

            if p33.parentWidget.type == "Menu" then
                Instance2 = Instance2.TextLabel;
            end;

            Instance2.Text = p33.arguments.Text or "Menu";
        end,

        ChildAdded = function(p34, p35) -- Line: 308, Name: ChildAdded
            -- upvalues: UpdateChildContainerTransform (copy)
            UpdateChildContainerTransform(p34);

            return p34.ChildContainer;
        end,

        ChildDiscarded = function(p36, p37) -- Line: 312, Name: ChildDiscarded
            -- upvalues: UpdateChildContainerTransform (copy)
            UpdateChildContainerTransform(p36);
        end,

        GenerateState = function(p38) -- Line: 315, Name: GenerateState
            -- upvalues: u1 (copy)
            if p38.state.isOpened == nil then
                p38.state.isOpened = u1._widgetState(p38, "isOpened", false);
            end;
        end,

        UpdateState = function(p39) -- Line: 320, Name: UpdateState
            -- upvalues: u1 (copy), UpdateChildContainerTransform (copy)
            local ChildContainer = p39.ChildContainer;

            if not p39.state.isOpened.value then
                p39.lastClosedTick = u1._cycleTick + 1;
                p39.ButtonColors.Transparency = 1;
                ChildContainer.Visible = false;

                return;
            end;

            p39.lastOpenedTick = u1._cycleTick + 1;
            p39.ButtonColors.Transparency = u1._config.HeaderTransparency;
            ChildContainer.Visible = true;
            UpdateChildContainerTransform(p39);
        end,

        Discard = function(p40) -- Line: 335, Name: Discard
            -- upvalues: u2 (copy)
            p40.Instance:Destroy();
            u2.discardState(p40);
        end
    });
    u1.WidgetConstructor("MenuItem", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1,
            KeyCode = 2,
            ModifierKey = 3
        },
        Events = {
            clicked = u2.EVENTS.click(function(p41) -- Line: 351
                return p41.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p42) -- Line: 354
                return p42.Instance;
            end)
        },

        Generate = function(u43) -- Line: 358, Name: Generate
            -- upvalues: u2 (copy), u1 (copy), EmptyMenuStack (copy), u3 (ref), u4 (ref), u5 (copy)
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "MenuItem";
            TextButton.BackgroundTransparency = 1;
            TextButton.BorderSizePixel = 0;
            TextButton.Size = UDim2.fromScale(1, 0);
            TextButton.Text = "";
            TextButton.AutomaticSize = Enum.AutomaticSize.Y;
            TextButton.LayoutOrder = u43.ZIndex;
            TextButton.AutoButtonColor = false;
            local v44 = u2.UIPadding(TextButton, u1._config.FramePadding);
            v44.PaddingTop = v44.PaddingTop - UDim.new(0, 1);
            u2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X));
            u2.applyInteractionHighlights("Background", TextButton, TextButton, {
                Transparency = 1,
                Color = u1._config.HeaderColor,
                HoveredColor = u1._config.HeaderHoveredColor,
                HoveredTransparency = u1._config.HeaderHoveredTransparency,
                ActiveColor = u1._config.HeaderHoveredColor,
                ActiveTransparency = u1._config.HeaderHoveredTransparency
            });
            u2.applyButtonClick(TextButton, function() -- Line: 382
                -- upvalues: EmptyMenuStack (ref)
                EmptyMenuStack();
            end);
            u2.applyMouseEnter(TextButton, function() -- Line: 386
                -- upvalues: u43 (copy), u3 (ref), u4 (ref), u5 (ref), EmptyMenuStack (ref)
                local parentWidget = u43.parentWidget;

                if u3 and (u4 and u4 ~= parentWidget) then
                    EmptyMenuStack((table.find(u5, parentWidget)));
                    u4 = parentWidget;
                    u3 = true;
                end;
            end);
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "TextLabel";
            TextLabel.BackgroundTransparency = 1;
            TextLabel.BorderSizePixel = 0;
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(TextLabel);
            TextLabel.Parent = TextButton;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "Shortcut";
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.BorderSizePixel = 0;
            TextLabel2.LayoutOrder = 1;
            TextLabel2.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(TextLabel2);
            TextLabel2.Text = "";
            TextLabel2.TextColor3 = u1._config.TextDisabledColor;
            TextLabel2.TextTransparency = u1._config.TextDisabledTransparency;
            TextLabel2.Parent = TextButton;

            return TextButton;
        end,

        Update = function(p45) -- Line: 424, Name: Update
            local Instance2 = p45.Instance;
            local Shortcut = Instance2.Shortcut;
            Instance2.TextLabel.Text = p45.arguments.Text;

            if p45.arguments.KeyCode then
                if p45.arguments.ModifierKey then
                    Shortcut.Text = p45.arguments.ModifierKey.Name .. " + " .. p45.arguments.KeyCode.Name;

                    return;
                end;

                Shortcut.Text = p45.arguments.KeyCode.Name;
            end;
        end,

        Discard = function(p46) -- Line: 438, Name: Discard
            p46.Instance:Destroy();
        end
    });
    u1.WidgetConstructor("MenuToggle", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            KeyCode = 2,
            ModifierKey = 3
        },
        Events = {
            checked = {
                Init = function(p47) -- Line: 454
                end,

                Get = function(p48) -- Line: 455
                    -- upvalues: u1 (copy)
                    return p48.lastCheckedTick == u1._cycleTick;
                end
            },
            unchecked = {
                Init = function(p49) -- Line: 460
                end,

                Get = function(p50) -- Line: 461
                    -- upvalues: u1 (copy)
                    return p50.lastUncheckedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p51) -- Line: 465
                return p51.Instance;
            end)
        },

        Generate = function(u52) -- Line: 469, Name: Generate
            -- upvalues: u2 (copy), u1 (copy), EmptyMenuStack (copy), u3 (ref), u4 (ref), u5 (copy)
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "MenuItem";
            TextButton.BackgroundTransparency = 1;
            TextButton.BorderSizePixel = 0;
            TextButton.Size = UDim2.fromScale(1, 0);
            TextButton.Text = "";
            TextButton.AutomaticSize = Enum.AutomaticSize.Y;
            TextButton.LayoutOrder = u52.ZIndex;
            TextButton.AutoButtonColor = false;
            local v53 = u2.UIPadding(TextButton, u1._config.FramePadding);
            v53.PaddingTop = v53.PaddingTop - UDim.new(0, 1);
            u2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            u2.applyInteractionHighlights("Background", TextButton, TextButton, {
                Transparency = 1,
                Color = u1._config.HeaderColor,
                HoveredColor = u1._config.HeaderHoveredColor,
                HoveredTransparency = u1._config.HeaderHoveredTransparency,
                ActiveColor = u1._config.HeaderHoveredColor,
                ActiveTransparency = u1._config.HeaderHoveredTransparency
            });
            u2.applyButtonClick(TextButton, function() -- Line: 493
                -- upvalues: u52 (copy), EmptyMenuStack (ref)
                u52.state.isChecked:set(not u52.state.isChecked.value);
                EmptyMenuStack();
            end);
            u2.applyMouseEnter(TextButton, function() -- Line: 499
                -- upvalues: u52 (copy), u3 (ref), u4 (ref), u5 (ref), EmptyMenuStack (ref)
                local parentWidget = u52.parentWidget;

                if u3 and (u4 and u4 ~= parentWidget) then
                    EmptyMenuStack((table.find(u5, parentWidget)));
                    u4 = parentWidget;
                    u3 = true;
                end;
            end);
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "TextLabel";
            TextLabel.BackgroundTransparency = 1;
            TextLabel.BorderSizePixel = 0;
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(TextLabel);
            TextLabel.Parent = TextButton;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "Shortcut";
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.BorderSizePixel = 0;
            TextLabel2.LayoutOrder = 1;
            TextLabel2.AutomaticSize = Enum.AutomaticSize.XY;
            u2.applyTextStyle(TextLabel2);
            TextLabel2.Text = "";
            TextLabel2.TextColor3 = u1._config.TextDisabledColor;
            TextLabel2.TextTransparency = u1._config.TextDisabledTransparency;
            TextLabel2.Parent = TextButton;
            local v54 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            local v55 = v54 - math.round(v54 * 0.2) * 2;
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "Icon";
            ImageLabel.Size = UDim2.fromOffset(v55, v55);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.BorderSizePixel = 0;
            ImageLabel.ImageColor3 = u1._config.TextColor;
            ImageLabel.ImageTransparency = u1._config.TextTransparency;
            ImageLabel.Image = u2.ICONS.CHECK_MARK;
            ImageLabel.LayoutOrder = 2;
            ImageLabel.Parent = TextButton;

            return TextButton;
        end,

        GenerateState = function(p56) -- Line: 553, Name: GenerateState
            -- upvalues: u1 (copy)
            if p56.state.isChecked == nil then
                p56.state.isChecked = u1._widgetState(p56, "isChecked", false);
            end;
        end,

        Update = function(p57) -- Line: 558, Name: Update
            local Instance2 = p57.Instance;
            local Shortcut = Instance2.Shortcut;
            Instance2.TextLabel.Text = p57.arguments.Text;

            if p57.arguments.KeyCode then
                if p57.arguments.ModifierKey then
                    Shortcut.Text = p57.arguments.ModifierKey.Name .. " + " .. p57.arguments.KeyCode.Name;

                    return;
                end;

                Shortcut.Text = p57.arguments.KeyCode.Name;
            end;
        end,

        UpdateState = function(p58) -- Line: 572, Name: UpdateState
            -- upvalues: u2 (copy), u1 (copy)
            local Icon = p58.Instance.Icon;

            if p58.state.isChecked.value then
                Icon.Image = u2.ICONS.CHECK_MARK;
                p58.lastCheckedTick = u1._cycleTick + 1;

                return;
            end;

            Icon.Image = "";
            p58.lastUncheckedTick = u1._cycleTick + 1;
        end,

        Discard = function(p59) -- Line: 584, Name: Discard
            -- upvalues: u2 (copy)
            p59.Instance:Destroy();
            u2.discardState(p59);
        end
    });
end;