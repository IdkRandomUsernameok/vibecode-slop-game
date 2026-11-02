-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);

return function(u1, u2) -- Line: 3
    u1.WidgetConstructor("Selectable", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Index = 2,
            NoClick = 3
        },
        Events = {
            selected = {
                Init = function(p3) -- Line: 15
                end,

                Get = function(p4) -- Line: 16
                    -- upvalues: u1 (copy)
                    return p4.lastSelectedTick == u1._cycleTick;
                end
            },
            unselected = {
                Init = function(p5) -- Line: 21
                end,

                Get = function(p6) -- Line: 22
                    -- upvalues: u1 (copy)
                    return p6.lastUnselectedTick == u1._cycleTick;
                end
            },
            active = {
                Init = function(p7) -- Line: 27
                end,

                Get = function(p8) -- Line: 28
                    return p8.state.index.value == p8.arguments.Index;
                end
            },
            clicked = u2.EVENTS.click(function(p9) -- Line: 32
                return p9.Instance.SelectableButton;
            end),
            rightClicked = u2.EVENTS.rightClick(function(p10) -- Line: 36
                return p10.Instance.SelectableButton;
            end),
            doubleClicked = u2.EVENTS.doubleClick(function(p11) -- Line: 40
                return p11.Instance.SelectableButton;
            end),
            ctrlClicked = u2.EVENTS.ctrlClick(function(p12) -- Line: 44
                return p12.Instance.SelectableButton;
            end),
            hovered = u2.EVENTS.hover(function(p13) -- Line: 48
                return p13.Instance.SelectableButton;
            end)
        },

        Generate = function(u14) -- Line: 53, Name: Generate
            -- upvalues: u1 (copy), u2 (copy)
            local Frame = Instance.new("Frame");
            Frame.Name = "Iris_Selectable";
            Frame.Size = UDim2.new(u1._config.ItemWidth, UDim.new(0, u1._config.TextSize + 2 * u1._config.FramePadding.Y - u1._config.ItemSpacing.Y));
            Frame.BackgroundTransparency = 1;
            Frame.BorderSizePixel = 0;
            Frame.ZIndex = 0;
            Frame.LayoutOrder = u14.ZIndex;
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "SelectableButton";
            TextButton.Size = UDim2.new(1, 0, 0, u1._config.TextSize + 2 * u1._config.FramePadding.Y);
            TextButton.Position = UDim2.fromOffset(0, -bit32.rshift(u1._config.ItemSpacing.Y, 1));
            TextButton.BackgroundColor3 = u1._config.HeaderColor;
            TextButton.ClipsDescendants = true;
            u2.applyFrameStyle(TextButton);
            u2.applyTextStyle(TextButton);
            u2.UISizeConstraint(TextButton, Vector2.xAxis);
            u14.ButtonColors = {
                Transparency = 1,
                Color = u1._config.HeaderColor,
                HoveredColor = u1._config.HeaderHoveredColor,
                HoveredTransparency = u1._config.HeaderHoveredTransparency,
                ActiveColor = u1._config.HeaderActiveColor,
                ActiveTransparency = u1._config.HeaderActiveTransparency
            };
            u2.applyInteractionHighlights("Background", TextButton, TextButton, u14.ButtonColors);
            u2.applyButtonClick(TextButton, function() -- Line: 84
                -- upvalues: u14 (copy)
                if u14.arguments.NoClick ~= true then
                    if type(u14.state.index.value) == "boolean" then
                        u14.state.index:set(not u14.state.index.value);

                        return;
                    end;

                    u14.state.index:set(u14.arguments.Index);
                end;
            end);
            TextButton.Parent = Frame;

            return Frame;
        end,

        Update = function(p15) -- Line: 98, Name: Update
            p15.Instance.SelectableButton.Text = p15.arguments.Text or "Selectable";
        end,

        Discard = function(p16) -- Line: 103, Name: Discard
            -- upvalues: u2 (copy)
            p16.Instance:Destroy();
            u2.discardState(p16);
        end,

        GenerateState = function(p17) -- Line: 107, Name: GenerateState
            -- upvalues: u1 (copy)
            if p17.state.index == nil then
                if p17.arguments.Index ~= nil then
                    error("A shared state index is required for Iris.Selectables() with an Index argument.", 5);
                end;

                p17.state.index = u1._widgetState(p17, "index", false);
            end;
        end,

        UpdateState = function(p18) -- Line: 115, Name: UpdateState
            -- upvalues: u1 (copy)
            local SelectableButton = p18.Instance.SelectableButton;

            if p18.state.index.value == (p18.arguments.Index or true) then
                p18.ButtonColors.Transparency = u1._config.HeaderTransparency;
                SelectableButton.BackgroundTransparency = u1._config.HeaderTransparency;
                p18.lastSelectedTick = u1._cycleTick + 1;

                return;
            end;

            p18.ButtonColors.Transparency = 1;
            SelectableButton.BackgroundTransparency = 1;
            p18.lastUnselectedTick = u1._cycleTick + 1;
        end
    });
    local u19 = false;
    local u20 = -1;
    local u21 = nil;

    local function UpdateChildContainerTransform(p22) -- Line: 134
        -- upvalues: u2 (copy), u1 (copy)
        local PreviewContainer = p22.Instance.PreviewContainer;
        local ChildContainer = p22.ChildContainer;
        ChildContainer.Size = UDim2.fromOffset(PreviewContainer.AbsoluteSize.X, 0);
        local v23 = PreviewContainer.AbsolutePosition - u2.GuiOffset;
        local AbsoluteSize = PreviewContainer.AbsoluteSize;
        local PopupBorderSize = u1._config.PopupBorderSize;
        local X = v23.X;
        local Vector2_zero = Vector2.zero;
        local v24;

        if v23.Y + ChildContainer.AbsoluteSize.Y > ChildContainer.Parent.AbsoluteSize.Y then
            v24 = v23.Y - PopupBorderSize;
            Vector2_zero = Vector2.yAxis;
        else
            v24 = v23.Y + AbsoluteSize.Y + PopupBorderSize;
        end;

        ChildContainer.AnchorPoint = Vector2_zero;
        ChildContainer.Position = UDim2.fromOffset(X, v24);
    end;

    u2.registerEvent("InputBegan", function(p25: userdata) -- Line: 161
        -- upvalues: u1 (copy), u19 (ref), u21 (ref), u20 (ref), u2 (copy)
        if not u1._started then
            return;
        end;

        if p25.UserInputType ~= Enum.UserInputType.MouseButton1 and (p25.UserInputType ~= Enum.UserInputType.MouseButton2 and p25.UserInputType ~= Enum.UserInputType.Touch) then
            return;
        end;

        if u19 == false or not u21 then
            return;
        end;

        if u20 == u1._cycleTick then
            return;
        end;

        local MouseLocation = u2.getMouseLocation();
        local PreviewContainer = u21.Instance.PreviewContainer;
        local ChildContainer = u21.ChildContainer;

        if u2.isPosInsideRect(MouseLocation, PreviewContainer.AbsolutePosition - u2.GuiOffset, PreviewContainer.AbsolutePosition - u2.GuiOffset + PreviewContainer.AbsoluteSize) then
            return;
        end;

        if u2.isPosInsideRect(MouseLocation, ChildContainer.AbsolutePosition - u2.GuiOffset, ChildContainer.AbsolutePosition - u2.GuiOffset + ChildContainer.AbsoluteSize) then
            return;
        end;

        u21.state.isOpened:set(false);
    end);
    u1.WidgetConstructor("Combo", {
        hasState = true,
        hasChildren = true,
        Args = {
            Text = 1,
            NoButton = 2,
            NoPreview = 3
        },
        Events = {
            opened = {
                Init = function(p26) -- Line: 205
                end,

                Get = function(p27) -- Line: 206
                    -- upvalues: u1 (copy)
                    return p27.lastOpenedTick == u1._cycleTick;
                end
            },
            closed = {
                Init = function(p28) -- Line: 211
                end,

                Get = function(p29) -- Line: 212
                    -- upvalues: u1 (copy)
                    return p29.lastClosedTick == u1._cycleTick;
                end
            },
            clicked = u2.EVENTS.click(function(p30) -- Line: 216
                return p30.Instance;
            end),
            hovered = u2.EVENTS.hover(function(p31) -- Line: 219
                return p31.Instance;
            end)
        },

        Generate = function(u32) -- Line: 223, Name: Generate
            -- upvalues: u1 (copy), u2 (copy), u19 (ref), u21 (ref)
            local v33 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            local Frame = Instance.new("Frame");
            Frame.Name = "Iris_Combo";
            Frame.Size = UDim2.fromScale(1, 0);
            Frame.AutomaticSize = Enum.AutomaticSize.Y;
            Frame.BackgroundTransparency = 1;
            Frame.BorderSizePixel = 0;
            Frame.LayoutOrder = u32.ZIndex;
            u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "PreviewContainer";
            TextButton.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0));
            TextButton.AutomaticSize = Enum.AutomaticSize.Y;
            TextButton.BackgroundTransparency = 1;
            TextButton.Text = "";
            TextButton.ZIndex = u32.ZIndex + 2;
            TextButton.AutoButtonColor = false;
            u2.applyFrameStyle(TextButton, true);
            u2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, 0));
            u2.UISizeConstraint(TextButton, Vector2.new(v33 + 1));
            TextButton.Parent = Frame;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "PreviewLabel";
            TextLabel.Size = UDim2.new(UDim.new(1, 0), u1._config.ContentHeight);
            TextLabel.AutomaticSize = Enum.AutomaticSize.Y;
            TextLabel.BackgroundColor3 = u1._config.FrameBgColor;
            TextLabel.BackgroundTransparency = u1._config.FrameBgTransparency;
            TextLabel.BorderSizePixel = 0;
            TextLabel.ClipsDescendants = true;
            u2.applyTextStyle(TextLabel);
            u2.UIPadding(TextLabel, u1._config.FramePadding);
            TextLabel.Parent = TextButton;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "DropdownButton";
            TextLabel2.Size = UDim2.new(0, v33, u1._config.ContentHeight.Scale, (math.max(u1._config.ContentHeight.Offset, v33)));
            TextLabel2.BorderSizePixel = 0;
            TextLabel2.BackgroundColor3 = u1._config.ButtonColor;
            TextLabel2.BackgroundTransparency = u1._config.ButtonTransparency;
            TextLabel2.Text = "";
            local v34 = v33 - math.round(v33 * 0.2) * 2;
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "Dropdown";
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel.Size = UDim2.fromOffset(v34, v34);
            ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.BorderSizePixel = 0;
            ImageLabel.ImageColor3 = u1._config.TextColor;
            ImageLabel.ImageTransparency = u1._config.TextTransparency;
            ImageLabel.Parent = TextLabel2;
            TextLabel2.Parent = TextButton;
            u2.applyInteractionHighlightsWithMultiHighlightee("Background", TextButton, {
                {
                    TextLabel,
                    {
                        Color = u1._config.FrameBgColor,
                        Transparency = u1._config.FrameBgTransparency,
                        HoveredColor = u1._config.FrameBgHoveredColor,
                        HoveredTransparency = u1._config.FrameBgHoveredTransparency,
                        ActiveColor = u1._config.FrameBgActiveColor,
                        ActiveTransparency = u1._config.FrameBgActiveTransparency
                    }
                },
                {
                    TextLabel2,
                    {
                        Color = u1._config.ButtonColor,
                        Transparency = u1._config.ButtonTransparency,
                        HoveredColor = u1._config.ButtonHoveredColor,
                        HoveredTransparency = u1._config.ButtonHoveredTransparency,
                        ActiveColor = u1._config.ButtonHoveredColor,
                        ActiveTransparency = u1._config.ButtonHoveredTransparency
                    }
                }
            });
            u2.applyButtonClick(TextButton, function() -- Line: 319
                -- upvalues: u19 (ref), u21 (ref), u32 (copy)
                if u19 and u21 ~= u32 then
                    return;
                end;

                u32.state.isOpened:set(not u32.state.isOpened.value);
            end);
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.Name = "TextLabel";
            TextLabel3.Size = UDim2.fromOffset(0, v33);
            TextLabel3.AutomaticSize = Enum.AutomaticSize.X;
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.BorderSizePixel = 0;
            u2.applyTextStyle(TextLabel3);
            TextLabel3.Parent = Frame;
            local ScrollingFrame = Instance.new("ScrollingFrame");
            ScrollingFrame.Name = "ComboContainer";
            ScrollingFrame.AutomaticSize = Enum.AutomaticSize.Y;
            ScrollingFrame.BackgroundColor3 = u1._config.PopupBgColor;
            ScrollingFrame.BackgroundTransparency = u1._config.PopupBgTransparency;
            ScrollingFrame.BorderSizePixel = 0;
            ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            ScrollingFrame.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency;
            ScrollingFrame.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor;
            ScrollingFrame.ScrollBarThickness = u1._config.ScrollbarSize;
            ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0);
            ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
            ScrollingFrame.ClipsDescendants = true;
            u2.UIStroke(ScrollingFrame, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency);
            u2.UIPadding(ScrollingFrame, Vector2.new(2, u1._config.WindowPadding.Y));
            u2.UISizeConstraint(ScrollingFrame, Vector2.new(100));
            u2.UIListLayout(ScrollingFrame, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top;
            local v35 = u1._rootInstance and u1._rootInstance:WaitForChild("PopupScreenGui");
            ScrollingFrame.Parent = v35;
            u32.ChildContainer = ScrollingFrame;

            return Frame;
        end,

        Update = function(p36) -- Line: 372, Name: Update
            -- upvalues: u1 (copy)
            local Instance2 = p36.Instance;
            local PreviewContainer = Instance2.PreviewContainer;
            local PreviewLabel = PreviewContainer.PreviewLabel;
            local DropdownButton = PreviewContainer.DropdownButton;
            Instance2.TextLabel.Text = p36.arguments.Text or "Combo";

            if p36.arguments.NoButton then
                DropdownButton.Visible = false;
                PreviewLabel.Size = UDim2.new(UDim.new(1, 0), PreviewLabel.Size.Height);
            else
                DropdownButton.Visible = true;
                PreviewLabel.Size = UDim2.new(UDim.new(1, -(u1._config.TextSize + 2 * u1._config.FramePadding.Y)), PreviewLabel.Size.Height);
            end;

            if p36.arguments.NoPreview then
                PreviewLabel.Visible = false;
                PreviewContainer.Size = UDim2.new(0, 0, 0, 0);
                PreviewContainer.AutomaticSize = Enum.AutomaticSize.XY;

                return;
            end;

            PreviewLabel.Visible = true;
            PreviewContainer.Size = UDim2.new(u1._config.ContentWidth, u1._config.ContentHeight);
            PreviewContainer.AutomaticSize = Enum.AutomaticSize.Y;
        end,

        ChildAdded = function(p37, p38) -- Line: 400, Name: ChildAdded
            -- upvalues: UpdateChildContainerTransform (copy)
            UpdateChildContainerTransform(p37);

            return p37.ChildContainer;
        end,

        GenerateState = function(u39) -- Line: 404, Name: GenerateState
            -- upvalues: u1 (copy)
            if u39.state.index == nil then
                u39.state.index = u1._widgetState(u39, "index", "No Selection");
            end;

            u39.state.index:onChange(function() -- Line: 408
                -- upvalues: u39 (copy)
                if u39.state.isOpened.value then
                    u39.state.isOpened:set(false);
                end;
            end);

            if u39.state.isOpened == nil then
                u39.state.isOpened = u1._widgetState(u39, "isOpened", false);
            end;
        end,

        UpdateState = function(p40) -- Line: 417, Name: UpdateState
            -- upvalues: u19 (ref), u21 (ref), u20 (ref), u1 (copy), u2 (copy), UpdateChildContainerTransform (copy)
            local ChildContainer = p40.ChildContainer;
            local PreviewContainer = p40.Instance.PreviewContainer;
            local PreviewLabel = PreviewContainer.PreviewLabel;
            local Dropdown = PreviewContainer.DropdownButton.Dropdown;

            if p40.state.isOpened.value then
                u19 = true;
                u21 = p40;
                u20 = u1._cycleTick;
                p40.lastOpenedTick = u1._cycleTick + 1;
                Dropdown.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE;
                ChildContainer.Visible = true;
                UpdateChildContainerTransform(p40);
            else
                if u19 then
                    u19 = false;
                    u21 = nil;
                    p40.lastClosedTick = u1._cycleTick + 1;
                end;

                Dropdown.Image = u2.ICONS.DOWN_POINTING_TRIANGLE;
                ChildContainer.Visible = false;
            end;

            local value = p40.state.index.value;
            local v41;

            if typeof(value) == "EnumItem" then
                v41 = value.Name;
            else
                v41 = tostring(value);
            end;

            PreviewLabel.Text = v41;
        end,

        Discard = function(p42) -- Line: 449, Name: Discard
            -- upvalues: u2 (copy)
            p42.Instance:Destroy();
            u2.discardState(p42);
        end
    });
end;