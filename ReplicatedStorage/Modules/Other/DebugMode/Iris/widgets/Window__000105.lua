-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);

return function(u1, u2) -- Line: 3
    local function relocateTooltips() -- Line: 4
        -- upvalues: u1 (copy), u2 (copy)
        if u1._rootInstance == nil then
            return;
        end;

        local PopupScreenGui = u1._rootInstance:FindFirstChild("PopupScreenGui");
        local TooltipContainer = PopupScreenGui.TooltipContainer;
        local MouseLocation = u2.getMouseLocation();
        local v3 = u2.findBestWindowPosForPopup(MouseLocation, TooltipContainer.AbsoluteSize, u1._config.DisplaySafeAreaPadding, PopupScreenGui.AbsoluteSize);
        TooltipContainer.Position = UDim2.fromOffset(v3.X, v3.Y);
    end;

    u2.registerEvent("InputChanged", function() -- Line: 15
        -- upvalues: u1 (copy), relocateTooltips (copy)
        if not u1._started then
            return;
        end;

        relocateTooltips();
    end);
    u1.WidgetConstructor("Tooltip", {
        hasState = false,
        hasChildren = false,
        Args = {
            Text = 1
        },
        Events = {},

        Generate = function(p4) -- Line: 30, Name: Generate
            -- upvalues: u1 (copy), u2 (copy)
            p4.parentWidget = u1._rootWidget;
            local Frame = Instance.new("Frame");
            Frame.Name = "Iris_Tooltip";
            Frame.Size = UDim2.new(u1._config.ContentWidth, UDim.new(0, 0));
            Frame.AutomaticSize = Enum.AutomaticSize.Y;
            Frame.BorderSizePixel = 0;
            Frame.BackgroundTransparency = 1;
            Frame.ZIndex = 1;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "TooltipText";
            TextLabel.Size = UDim2.fromOffset(0, 0);
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel.BackgroundColor3 = u1._config.PopupBgColor;
            TextLabel.BackgroundTransparency = u1._config.PopupBgTransparency;
            TextLabel.TextWrapped = u1._config.TextWrapped;
            u2.applyTextStyle(TextLabel);
            u2.UIStroke(TextLabel, u1._config.PopupBorderSize, u1._config.BorderActiveColor, u1._config.BorderActiveTransparency);
            u2.UIPadding(TextLabel, u1._config.WindowPadding);

            if u1._config.PopupRounding > 0 then
                u2.UICorner(TextLabel, u1._config.PopupRounding);
            end;

            TextLabel.Parent = Frame;

            return Frame;
        end,

        Update = function(p5) -- Line: 60, Name: Update
            -- upvalues: relocateTooltips (copy)
            local TooltipText = p5.Instance.TooltipText;

            if p5.arguments.Text == nil then
                error("Text argument is required for Iris.Tooltip().", 5);
            end;

            TooltipText.Text = p5.arguments.Text;
            relocateTooltips();
        end,

        Discard = function(p6) -- Line: 69, Name: Discard
            p6.Instance:Destroy();
        end
    });
    local u7 = 0;
    local u8 = nil;
    local u9 = false;
    local u10 = nil;
    local u11 = nil;
    local u12 = false;
    local u13 = false;
    local u14 = false;
    local Top = Enum.TopBottom.Top;
    local Left = Enum.LeftRight.Left;
    local u15 = nil;
    local u16 = nil;
    local u17 = false;
    local u18 = {};

    local function quickSwapWindows() -- Line: 93
        -- upvalues: u1 (copy), u18 (copy)
        if u1._config.UseScreenGUIs == false then
            return;
        end;

        local v19 = 65535;
        local v20 = nil;

        for _, v in u18 do
            if v.state.isOpened.value and (not v.arguments.NoNav and v.Instance:IsA("ScreenGui")) then
                local DisplayOrder = v.Instance.DisplayOrder;

                if DisplayOrder < v19 then
                    v20 = v;
                    v19 = DisplayOrder;
                end;
            end;
        end;

        if not v20 then
            return;
        end;

        if v20.state.isUncollapsed.value == false then
            v20.state.isUncollapsed:set(true);
        end;

        u1.SetFocusedWindow(v20);
    end;

    local function fitSizeToWindowBounds(p21: any, p22) -- Line: 124
        -- upvalues: u1 (copy), u2 (copy)
        local Vector2_new_ret = Vector2.new(p21.state.position.value.X, p21.state.position.value.Y);
        local v23 = (u1._config.TextSize + 2 * u1._config.FramePadding.Y) * 2;
        local ScreenSizeForWindow = u2.getScreenSizeForWindow(p21);
        local Vector2_new_ret2 = Vector2.new(u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.X, u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.Y);
        local v24 = ScreenSizeForWindow - Vector2_new_ret - Vector2_new_ret2;
        local Vector2_new = Vector2.new;
        local X = p22.X;
        local math_max_ret = math.max(v24.X, v23);
        local math_clamp_ret = math.clamp(X, v23, math_max_ret);
        local Y = p22.Y;
        local math_max_ret2 = math.max(v24.Y, v23);

        return Vector2_new(math_clamp_ret, (math.clamp(Y, v23, math_max_ret2)));
    end;

    local function fitPositionToWindowBounds(p25: any, p26) -- Line: 134
        -- upvalues: u2 (copy), u1 (copy)
        local Instance2 = p25.Instance;
        local ScreenSizeForWindow = u2.getScreenSizeForWindow(p25);
        local Vector2_new_ret = Vector2.new(u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.X, u1._config.WindowBorderSize + u1._config.DisplaySafeAreaPadding.Y);
        local Vector2_new = Vector2.new;
        local X = p26.X;
        local X2 = Vector2_new_ret.X;
        local math_max_ret = math.max(Vector2_new_ret.X, ScreenSizeForWindow.X - Instance2.WindowButton.AbsoluteSize.X - Vector2_new_ret.X);
        local math_clamp_ret = math.clamp(X, X2, math_max_ret);
        local Y = p26.Y;
        local Y2 = Vector2_new_ret.Y;
        local math_max_ret2 = math.max(Vector2_new_ret.Y, ScreenSizeForWindow.Y - Instance2.WindowButton.AbsoluteSize.Y - Vector2_new_ret.Y);

        return Vector2_new(math_clamp_ret, (math.clamp(Y, Y2, math_max_ret2)));
    end;

    function u1.SetFocusedWindow(p27) -- Line: 145
        -- upvalues: u16 (ref), u17 (ref), u18 (copy), u1 (copy), u7 (ref), u2 (copy)
        if u16 == p27 then
            return;
        end;

        if u17 and u16 ~= nil then
            if u18[u16.ID] then
                local WindowButton = u16.Instance.WindowButton;
                local TitleBar = WindowButton.Content.TitleBar;

                if u16.state.isUncollapsed.value then
                    TitleBar.BackgroundColor3 = u1._config.TitleBgColor;
                    TitleBar.BackgroundTransparency = u1._config.TitleBgTransparency;
                else
                    TitleBar.BackgroundColor3 = u1._config.TitleBgCollapsedColor;
                    TitleBar.BackgroundTransparency = u1._config.TitleBgCollapsedTransparency;
                end;

                WindowButton.UIStroke.Color = u1._config.BorderColor;
            end;

            u17 = false;
            u16 = nil;
        end;

        if p27 ~= nil then
            u17 = true;
            u16 = p27;
            local Instance2 = p27.Instance;
            local WindowButton = Instance2.WindowButton;
            local TitleBar = WindowButton.Content.TitleBar;
            TitleBar.BackgroundColor3 = u1._config.TitleBgActiveColor;
            TitleBar.BackgroundTransparency = u1._config.TitleBgActiveTransparency;
            WindowButton.UIStroke.Color = u1._config.BorderActiveColor;
            u7 = u7 + 1;

            if p27.usesScreenGuis then
                Instance2.DisplayOrder = u7 + u1._config.DisplayOrderOffset;
            else
                Instance2.ZIndex = u7 + u1._config.DisplayOrderOffset;
            end;

            if p27.state.isUncollapsed.value == false then
                p27.state.isUncollapsed:set(true);
            end;

            if u2.GuiService.SelectedObject then
                if TitleBar.Visible then
                    u2.GuiService:Select(TitleBar);

                    return;
                end;

                u2.GuiService:Select(p27.ChildContainer);
            end;
        end;
    end;

    u2.registerEvent("InputBegan", function(p28: userdata) -- Line: 206
        -- upvalues: u1 (copy), u2 (copy), u18 (copy), quickSwapWindows (copy), u13 (ref), u14 (ref), u17 (ref), u16 (ref), Top (ref), Left (ref), u12 (ref), u11 (ref)
        if not u1._started then
            return;
        end;

        if p28.UserInputType == Enum.UserInputType.MouseButton1 then
            local MouseLocation = u2.getMouseLocation();
            local v29 = false;

            for _, v in u18 do
                local Instance2 = v.Instance;

                if Instance2 then
                    local ResizeBorder = Instance2.WindowButton.ResizeBorder;

                    if ResizeBorder and u2.isPosInsideRect(MouseLocation, ResizeBorder.AbsolutePosition - u2.GuiOffset, ResizeBorder.AbsolutePosition - u2.GuiOffset + ResizeBorder.AbsoluteSize) then
                        v29 = true;
                        break;
                    end;
                end;
            end;

            if not v29 then
                u1.SetFocusedWindow(nil);
            end;
        end;

        if p28.KeyCode == Enum.KeyCode.Tab and (u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
            quickSwapWindows();
        end;

        if p28.UserInputType == Enum.UserInputType.MouseButton1 and (u13 and (not u14 and (u17 and u16))) then
            local v30 = u16.state.position.value + u16.state.size.value / 2;
            local v31 = u2.getMouseLocation() - v30;

            if math.abs(v31.X) * u16.state.size.value.Y >= math.abs(v31.Y) * u16.state.size.value.X then
                Top = Enum.TopBottom.Center;
                local v32;

                if math.sign(v31.X) == -1 then
                    v32 = Enum.LeftRight.Left;
                else
                    v32 = Enum.LeftRight.Right;
                end;

                Left = v32;
            else
                Left = Enum.LeftRight.Center;
                local v33;

                if math.sign(v31.Y) == -1 then
                    v33 = Enum.TopBottom.Top;
                else
                    v33 = Enum.TopBottom.Bottom;
                end;

                Top = v33;
            end;

            u12 = true;
            u11 = u16;
        end;
    end);
    u2.registerEvent("TouchTapInWorld", function(p34: any, p35: boolean) -- Line: 252
        -- upvalues: u1 (copy)
        if not u1._started then
            return;
        end;

        if not p35 then
            u1.SetFocusedWindow(nil);
        end;
    end);
    u2.registerEvent("InputChanged", function(p36: userdata) -- Line: 261
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u2 (copy), u10 (ref), fitPositionToWindowBounds (copy), u12 (ref), u11 (ref), u15 (ref), Left (ref), Top (ref), fitSizeToWindowBounds (copy)
        if not u1._started then
            return;
        end;

        if u9 and u8 then
            local v37;

            if p36.UserInputType == Enum.UserInputType.Touch then
                local Position = p36.Position;
                v37 = Vector2.new(Position.X, Position.Y);
            else
                v37 = u2.getMouseLocation();
            end;

            local WindowButton = u8.Instance.WindowButton;
            local v38 = fitPositionToWindowBounds(u8, v37 - u10);
            WindowButton.Position = UDim2.fromOffset(v38.X, v38.Y);
            u8.state.position.value = v38;
        end;

        if u12 and (u11 and u11.arguments.NoResize ~= true) then
            local WindowButton = u11.Instance.WindowButton;
            local Vector2_new_ret = Vector2.new(WindowButton.Position.X.Offset, WindowButton.Position.Y.Offset);
            local Vector2_new_ret2 = Vector2.new(WindowButton.Size.X.Offset, WindowButton.Size.Y.Offset);
            local v39;

            if p36.UserInputType == Enum.UserInputType.Touch then
                v39 = p36.Delta;
            else
                v39 = u2.getMouseLocation() - u15;
            end;

            local v40 = Vector2_new_ret + Vector2.new(Left ~= Enum.LeftRight.Left and 0 or v39.X, Top ~= Enum.TopBottom.Top and 0 or v39.Y);
            local v41;

            if Left == Enum.LeftRight.Left then
                v41 = -v39.X;
            else
                v41 = Left ~= Enum.LeftRight.Right and 0 or v39.X;
            end;

            local v42;

            if Top == Enum.TopBottom.Top then
                v42 = -v39.Y;
            else
                v42 = Top ~= Enum.TopBottom.Bottom and 0 or v39.Y;
            end;

            local v43 = fitSizeToWindowBounds(u11, Vector2_new_ret2 + Vector2.new(v41, v42));
            local v44 = fitPositionToWindowBounds(u11, v40);
            WindowButton.Size = UDim2.fromOffset(v43.X, v43.Y);
            u11.state.size.value = v43;
            WindowButton.Position = UDim2.fromOffset(v44.X, v44.Y);
            u11.state.position.value = v44;
        end;

        u15 = u2.getMouseLocation();
    end);
    u2.registerEvent("InputEnded", function(p45, p46) -- Line: 315
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u12 (ref), u11 (ref), quickSwapWindows (copy)
        if not u1._started then
            return;
        end;

        if (p45.UserInputType == Enum.UserInputType.MouseButton1 or p45.UserInputType == Enum.UserInputType.Touch) and (u9 and u8) then
            local WindowButton = u8.Instance.WindowButton;
            u9 = false;
            u8.state.position:set(Vector2.new(WindowButton.Position.X.Offset, WindowButton.Position.Y.Offset));
        end;

        if (p45.UserInputType == Enum.UserInputType.MouseButton1 or p45.UserInputType == Enum.UserInputType.Touch) and (u12 and u11) then
            u12 = false;
            u11.state.size:set(u11.Instance.WindowButton.AbsoluteSize);
        end;

        if p45.KeyCode == Enum.KeyCode.ButtonX then
            quickSwapWindows();
        end;
    end);
    u1.WidgetConstructor("Window", {
        hasState = true,
        hasChildren = true,
        Args = {
            Title = 1,
            NoTitleBar = 2,
            NoBackground = 3,
            NoCollapse = 4,
            NoClose = 5,
            NoMove = 6,
            NoScrollbar = 7,
            NoResize = 8,
            NoNav = 9,
            NoMenu = 10
        },
        Events = {
            closed = {
                Init = function(p47) -- Line: 354
                end,

                Get = function(p48) -- Line: 355
                    -- upvalues: u1 (copy)
                    return p48.lastClosedTick == u1._cycleTick;
                end
            },
            opened = {
                Init = function(p49) -- Line: 360
                end,

                Get = function(p50) -- Line: 361
                    -- upvalues: u1 (copy)
                    return p50.lastOpenedTick == u1._cycleTick;
                end
            },
            collapsed = {
                Init = function(p51) -- Line: 366
                end,

                Get = function(p52) -- Line: 367
                    -- upvalues: u1 (copy)
                    return p52.lastCollapsedTick == u1._cycleTick;
                end
            },
            uncollapsed = {
                Init = function(p53) -- Line: 372
                end,

                Get = function(p54) -- Line: 373
                    -- upvalues: u1 (copy)
                    return p54.lastUncollapsedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p55) -- Line: 377
                return p55.Instance.WindowButton;
            end)
        },

        Generate = function(u56) -- Line: 382, Name: Generate
            -- upvalues: u1 (copy), u18 (copy), u2 (copy), u8 (ref), u9 (ref), u10 (ref), u17 (ref), u16 (ref), u12 (ref), Top (ref), Left (ref), u11 (ref), u13 (ref), u14 (ref)
            u56.parentWidget = u1._rootWidget;
            u56.usesScreenGuis = u1._config.UseScreenGUIs;
            u18[u56.ID] = u56;
            local v57;

            if u56.usesScreenGuis then
                v57 = Instance.new("ScreenGui");
                v57.ResetOnSpawn = false;
                v57.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                v57.DisplayOrder = u1._config.DisplayOrderOffset;
                v57.IgnoreGuiInset = u1._config.IgnoreGuiInset;
            else
                v57 = Instance.new("Frame");
                v57.AnchorPoint = Vector2.new(0.5, 0.5);
                v57.Position = UDim2.new(0.5, 0, 0.5, 0);
                v57.Size = UDim2.new(1, 0, 1, 0);
                v57.BackgroundTransparency = 1;
                v57.ZIndex = u1._config.DisplayOrderOffset;
            end;

            v57.Name = "Iris_Window";
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "WindowButton";
            TextButton.Size = UDim2.fromOffset(0, 0);
            TextButton.BackgroundTransparency = 1;
            TextButton.BorderSizePixel = 0;
            TextButton.Text = "";
            TextButton.ClipsDescendants = false;
            TextButton.AutoButtonColor = false;
            TextButton.Selectable = false;
            TextButton.SelectionImageObject = u1.SelectionImageObject;
            TextButton.SelectionGroup = true;
            TextButton.SelectionBehaviorUp = Enum.SelectionBehavior.Stop;
            TextButton.SelectionBehaviorDown = Enum.SelectionBehavior.Stop;
            TextButton.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop;
            TextButton.SelectionBehaviorRight = Enum.SelectionBehavior.Stop;
            u2.UIStroke(TextButton, u1._config.WindowBorderSize, u1._config.BorderColor, u1._config.BorderTransparency);
            TextButton.Parent = v57;
            u2.applyInputBegan(TextButton, function(p58: userdata) -- Line: 426
                -- upvalues: u56 (copy), u1 (ref), u8 (ref), u9 (ref), u10 (ref), u2 (ref)
                if p58.UserInputType == Enum.UserInputType.MouseMovement or p58.UserInputType == Enum.UserInputType.Keyboard then
                    return;
                end;

                if u56.state.isUncollapsed.value then
                    u1.SetFocusedWindow(u56);
                end;

                if not u56.arguments.NoMove and p58.UserInputType == Enum.UserInputType.MouseButton1 then
                    u8 = u56;
                    u9 = true;
                    u10 = u2.getMouseLocation() - u56.state.position.value;
                end;
            end);
            local Frame = Instance.new("Frame");
            Frame.Name = "Content";
            Frame.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame.Position = UDim2.fromScale(0.5, 0.5);
            Frame.Size = UDim2.fromScale(1, 1);
            Frame.BackgroundTransparency = 1;
            Frame.ClipsDescendants = true;
            Frame.Parent = TextButton;
            local v59 = u2.UIListLayout(Frame, Enum.FillDirection.Vertical, UDim.new(0, 0));
            v59.HorizontalAlignment = Enum.HorizontalAlignment.Center;
            v59.VerticalAlignment = Enum.VerticalAlignment.Top;
            local ScrollingFrame = Instance.new("ScrollingFrame");
            ScrollingFrame.Name = "WindowContainer";
            ScrollingFrame.Size = UDim2.fromScale(1, 1);
            ScrollingFrame.BackgroundColor3 = u1._config.WindowBgColor;
            ScrollingFrame.BackgroundTransparency = u1._config.WindowBgTransparency;
            ScrollingFrame.BorderSizePixel = 0;
            ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            ScrollingFrame.ScrollBarImageTransparency = u1._config.ScrollbarGrabTransparency;
            ScrollingFrame.ScrollBarImageColor3 = u1._config.ScrollbarGrabColor;
            ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0);
            ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
            ScrollingFrame.LayoutOrder = u56.ZIndex + 65535;
            ScrollingFrame.ClipsDescendants = true;
            u2.UIPadding(ScrollingFrame, u1._config.WindowPadding);
            ScrollingFrame.Parent = Frame;
            local UIFlexItem = Instance.new("UIFlexItem");
            UIFlexItem.FlexMode = Enum.UIFlexMode.Fill;
            UIFlexItem.ItemLineAlignment = Enum.ItemLineAlignment.End;
            UIFlexItem.Parent = ScrollingFrame;
            ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 478
                -- upvalues: u56 (copy), ScrollingFrame (copy)
                u56.state.scrollDistance.value = ScrollingFrame.CanvasPosition.Y;
            end);
            u2.applyInputBegan(ScrollingFrame, function(p60: userdata) -- Line: 483
                -- upvalues: u56 (copy), u1 (ref)
                if p60.UserInputType == Enum.UserInputType.MouseMovement or p60.UserInputType == Enum.UserInputType.Keyboard then
                    return;
                end;

                if u56.state.isUncollapsed.value then
                    u1.SetFocusedWindow(u56);
                end;
            end);
            local Frame2 = Instance.new("Frame");
            Frame2.Name = "TerminatingFrame";
            Frame2.Size = UDim2.fromOffset(0, u1._config.WindowPadding.Y + u1._config.FramePadding.Y);
            Frame2.BackgroundTransparency = 1;
            Frame2.BorderSizePixel = 0;
            Frame2.LayoutOrder = 2147483632;
            u2.UIListLayout(ScrollingFrame, Enum.FillDirection.Vertical, UDim.new(0, u1._config.ItemSpacing.Y)).VerticalAlignment = Enum.VerticalAlignment.Top;
            Frame2.Parent = ScrollingFrame;
            local Frame3 = Instance.new("Frame");
            Frame3.Name = "TitleBar";
            Frame3.AutomaticSize = Enum.AutomaticSize.Y;
            Frame3.Size = UDim2.fromScale(1, 0);
            Frame3.BorderSizePixel = 0;
            Frame3.ClipsDescendants = true;
            Frame3.Parent = Frame;
            u2.UIPadding(Frame3, Vector2.new(u1._config.FramePadding.X));
            u2.UIListLayout(Frame3, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            u2.applyInputBegan(Frame3, function(p61: userdata) -- Line: 515
                -- upvalues: u56 (copy), u8 (ref), u9 (ref), u10 (ref)
                if p61.UserInputType == Enum.UserInputType.Touch and not u56.arguments.NoMove then
                    u8 = u56;
                    u9 = true;
                    local Position = p61.Position;
                    u10 = Vector2.new(Position.X, Position.Y) - u56.state.position.value;
                end;
            end);
            local v62 = u1._config.TextSize + (u1._config.FramePadding.Y - 1) * 2;
            local TextButton2 = Instance.new("TextButton");
            TextButton2.Name = "CollapseButton";
            TextButton2.AnchorPoint = Vector2.new(0, 0.5);
            TextButton2.Size = UDim2.fromOffset(v62, v62);
            TextButton2.Position = UDim2.new(0, 0, 0.5, 0);
            TextButton2.AutomaticSize = Enum.AutomaticSize.None;
            TextButton2.BackgroundTransparency = 1;
            TextButton2.BorderSizePixel = 0;
            TextButton2.AutoButtonColor = false;
            TextButton2.Text = "";
            u2.UICorner(TextButton2);
            TextButton2.Parent = Frame3;
            u2.applyButtonClick(TextButton2, function() -- Line: 543
                -- upvalues: u56 (copy)
                u56.state.isUncollapsed:set(not u56.state.isUncollapsed.value);
            end);
            u2.applyInteractionHighlights("Background", TextButton2, TextButton2, {
                Transparency = 1,
                Color = u1._config.ButtonColor,
                HoveredColor = u1._config.ButtonHoveredColor,
                HoveredTransparency = u1._config.ButtonHoveredTransparency,
                ActiveColor = u1._config.ButtonActiveColor,
                ActiveTransparency = u1._config.ButtonActiveTransparency
            });
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Name = "Arrow";
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel.Size = UDim2.fromOffset(math.floor(v62 * 0.7), (math.floor(v62 * 0.7)));
            ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.BorderSizePixel = 0;
            ImageLabel.Image = u2.ICONS.MULTIPLICATION_SIGN;
            ImageLabel.ImageColor3 = u1._config.TextColor;
            ImageLabel.ImageTransparency = u1._config.TextTransparency;
            ImageLabel.Parent = TextButton2;
            local TextButton3 = Instance.new("TextButton");
            TextButton3.Name = "CloseButton";
            TextButton3.AnchorPoint = Vector2.new(1, 0.5);
            TextButton3.Size = UDim2.fromOffset(v62, v62);
            TextButton3.Position = UDim2.new(1, 0, 0.5, 0);
            TextButton3.AutomaticSize = Enum.AutomaticSize.None;
            TextButton3.BackgroundTransparency = 1;
            TextButton3.BorderSizePixel = 0;
            TextButton3.Text = "";
            TextButton3.LayoutOrder = 2;
            TextButton3.AutoButtonColor = false;
            u2.UICorner(TextButton3);
            u2.applyButtonClick(TextButton3, function() -- Line: 582
                -- upvalues: u56 (copy)
                u56.state.isOpened:set(false);
            end);
            u2.applyInteractionHighlights("Background", TextButton3, TextButton3, {
                Transparency = 1,
                Color = u1._config.ButtonColor,
                HoveredColor = u1._config.ButtonHoveredColor,
                HoveredTransparency = u1._config.ButtonHoveredTransparency,
                ActiveColor = u1._config.ButtonActiveColor,
                ActiveTransparency = u1._config.ButtonActiveTransparency
            });
            TextButton3.Parent = Frame3;
            local ImageLabel2 = Instance.new("ImageLabel");
            ImageLabel2.Name = "Icon";
            ImageLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
            ImageLabel2.Size = UDim2.fromOffset(math.floor(v62 * 0.7), (math.floor(v62 * 0.7)));
            ImageLabel2.Position = UDim2.fromScale(0.5, 0.5);
            ImageLabel2.BackgroundTransparency = 1;
            ImageLabel2.BorderSizePixel = 0;
            ImageLabel2.Image = u2.ICONS.MULTIPLICATION_SIGN;
            ImageLabel2.ImageColor3 = u1._config.TextColor;
            ImageLabel2.ImageTransparency = u1._config.TextTransparency;
            ImageLabel2.Parent = TextButton3;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "Title";
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel.BorderSizePixel = 0;
            TextLabel.BackgroundTransparency = 1;
            TextLabel.LayoutOrder = 1;
            TextLabel.ClipsDescendants = true;
            u2.UIPadding(TextLabel, Vector2.new(0, u1._config.FramePadding.Y));
            u2.applyTextStyle(TextLabel);
            TextLabel.TextXAlignment = Enum.TextXAlignment[u1._config.WindowTitleAlign.Name];
            local UIFlexItem2 = Instance.new("UIFlexItem");
            UIFlexItem2.FlexMode = Enum.UIFlexMode.Fill;
            UIFlexItem2.ItemLineAlignment = Enum.ItemLineAlignment.Center;
            UIFlexItem2.Parent = TextLabel;
            TextLabel.Parent = Frame3;
            local v63 = u1._config.TextSize + u1._config.FramePadding.X;
            local ImageButton = Instance.new("ImageButton");
            ImageButton.Name = "LeftResizeGrip";
            ImageButton.AnchorPoint = Vector2.yAxis;
            ImageButton.Rotation = 180;
            ImageButton.Size = UDim2.fromOffset(v63, v63);
            ImageButton.Position = UDim2.fromScale(0, 1);
            ImageButton.BackgroundTransparency = 1;
            ImageButton.BorderSizePixel = 0;
            ImageButton.Image = u2.ICONS.BOTTOM_RIGHT_CORNER;
            ImageButton.ImageColor3 = u1._config.ResizeGripColor;
            ImageButton.ImageTransparency = 1;
            ImageButton.AutoButtonColor = false;
            ImageButton.ZIndex = 3;
            ImageButton.Parent = TextButton;
            u2.applyInteractionHighlights("Image", ImageButton, ImageButton, {
                Transparency = 1,
                Color = u1._config.ResizeGripColor,
                HoveredColor = u1._config.ResizeGripHoveredColor,
                HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
                ActiveColor = u1._config.ResizeGripActiveColor,
                ActiveTransparency = u1._config.ResizeGripActiveTransparency
            });
            u2.applyButtonDown(ImageButton, function() -- Line: 657
                -- upvalues: u17 (ref), u16 (ref), u56 (copy), u1 (ref), u12 (ref), Top (ref), Left (ref), u11 (ref)
                if not u17 or u16 ~= u56 then
                    u1.SetFocusedWindow(u56);
                end;

                u12 = true;
                Top = Enum.TopBottom.Bottom;
                Left = Enum.LeftRight.Left;
                u11 = u56;
            end);
            local ImageButton2 = Instance.new("ImageButton");
            ImageButton2.Name = "RightResizeGrip";
            ImageButton2.AnchorPoint = Vector2.one;
            ImageButton2.Rotation = 90;
            ImageButton2.Size = UDim2.fromOffset(v63, v63);
            ImageButton2.Position = UDim2.fromScale(1, 1);
            ImageButton2.BackgroundTransparency = 1;
            ImageButton2.BorderSizePixel = 0;
            ImageButton2.Image = u2.ICONS.BOTTOM_RIGHT_CORNER;
            ImageButton2.ImageColor3 = u1._config.ResizeGripColor;
            ImageButton2.ImageTransparency = u1._config.ResizeGripTransparency;
            ImageButton2.AutoButtonColor = false;
            ImageButton2.ZIndex = 3;
            ImageButton2.Parent = TextButton;
            u2.applyInteractionHighlights("Image", ImageButton2, ImageButton2, {
                Color = u1._config.ResizeGripColor,
                Transparency = u1._config.ResizeGripTransparency,
                HoveredColor = u1._config.ResizeGripHoveredColor,
                HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
                ActiveColor = u1._config.ResizeGripActiveColor,
                ActiveTransparency = u1._config.ResizeGripActiveTransparency
            });
            u2.applyButtonDown(ImageButton2, function() -- Line: 693
                -- upvalues: u17 (ref), u16 (ref), u56 (copy), u1 (ref), u12 (ref), Top (ref), Left (ref), u11 (ref)
                if not u17 or u16 ~= u56 then
                    u1.SetFocusedWindow(u56);
                end;

                u12 = true;
                Top = Enum.TopBottom.Bottom;
                Left = Enum.LeftRight.Right;
                u11 = u56;
            end);
            local ImageButton3 = Instance.new("ImageButton");
            ImageButton3.Name = "LeftResizeBorder";
            ImageButton3.AnchorPoint = Vector2.new(1, 0.5);
            ImageButton3.Position = UDim2.fromScale(0, 0.5);
            ImageButton3.Size = UDim2.new(0, u1._config.WindowResizePadding.X, 1, 2 * u1._config.WindowBorderSize);
            ImageButton3.Transparency = 1;
            ImageButton3.Image = u2.ICONS.BORDER;
            ImageButton3.ResampleMode = Enum.ResamplerMode.Pixelated;
            ImageButton3.ScaleType = Enum.ScaleType.Slice;
            ImageButton3.SliceCenter = Rect.new(0, 0, 1, 1);
            ImageButton3.ImageRectOffset = Vector2.new(2, 2);
            ImageButton3.ImageRectSize = Vector2.new(2, 1);
            ImageButton3.ImageTransparency = 1;
            ImageButton3.ZIndex = 4;
            ImageButton3.AutoButtonColor = false;
            ImageButton3.Parent = TextButton;
            local ImageButton4 = Instance.new("ImageButton");
            ImageButton4.Name = "RightResizeBorder";
            ImageButton4.AnchorPoint = Vector2.new(0, 0.5);
            ImageButton4.Position = UDim2.fromScale(1, 0.5);
            ImageButton4.Size = UDim2.new(0, u1._config.WindowResizePadding.X, 1, 2 * u1._config.WindowBorderSize);
            ImageButton4.Transparency = 1;
            ImageButton4.Image = u2.ICONS.BORDER;
            ImageButton4.ResampleMode = Enum.ResamplerMode.Pixelated;
            ImageButton4.ScaleType = Enum.ScaleType.Slice;
            ImageButton4.SliceCenter = Rect.new(1, 0, 2, 1);
            ImageButton4.ImageRectOffset = Vector2.new(1, 2);
            ImageButton4.ImageRectSize = Vector2.new(2, 1);
            ImageButton4.ImageTransparency = 1;
            ImageButton4.ZIndex = 4;
            ImageButton4.AutoButtonColor = false;
            ImageButton4.Parent = TextButton;
            local ImageButton5 = Instance.new("ImageButton");
            ImageButton5.Name = "TopResizeBorder";
            ImageButton5.AnchorPoint = Vector2.new(0.5, 1);
            ImageButton5.Position = UDim2.fromScale(0.5, 0);
            ImageButton5.Size = UDim2.new(1, 2 * u1._config.WindowBorderSize, 0, u1._config.WindowResizePadding.Y);
            ImageButton5.Transparency = 1;
            ImageButton5.Image = u2.ICONS.BORDER;
            ImageButton5.ResampleMode = Enum.ResamplerMode.Pixelated;
            ImageButton5.ScaleType = Enum.ScaleType.Slice;
            ImageButton5.SliceCenter = Rect.new(0, 0, 1, 1);
            ImageButton5.ImageRectOffset = Vector2.new(2, 2);
            ImageButton5.ImageRectSize = Vector2.new(1, 2);
            ImageButton5.ImageTransparency = 1;
            ImageButton5.ZIndex = 4;
            ImageButton5.AutoButtonColor = false;
            ImageButton5.Parent = TextButton;
            local ImageButton6 = Instance.new("ImageButton");
            ImageButton6.Name = "BottomResizeBorder";
            ImageButton6.AnchorPoint = Vector2.new(0.5, 0);
            ImageButton6.Position = UDim2.fromScale(0.5, 1);
            ImageButton6.Size = UDim2.new(1, 2 * u1._config.WindowBorderSize, 0, u1._config.WindowResizePadding.Y);
            ImageButton6.Transparency = 1;
            ImageButton6.Image = u2.ICONS.BORDER;
            ImageButton6.ResampleMode = Enum.ResamplerMode.Pixelated;
            ImageButton6.ScaleType = Enum.ScaleType.Slice;
            ImageButton6.SliceCenter = Rect.new(0, 1, 1, 2);
            ImageButton6.ImageRectOffset = Vector2.new(2, 1);
            ImageButton6.ImageRectSize = Vector2.new(1, 2);
            ImageButton6.ImageTransparency = 1;
            ImageButton6.ZIndex = 4;
            ImageButton6.AutoButtonColor = false;
            ImageButton6.Parent = TextButton;
            u2.applyInteractionHighlights("Image", ImageButton3, ImageButton3, {
                Transparency = 1,
                Color = u1._config.ResizeGripColor,
                HoveredColor = u1._config.ResizeGripHoveredColor,
                HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
                ActiveColor = u1._config.ResizeGripActiveColor,
                ActiveTransparency = u1._config.ResizeGripActiveTransparency
            });
            u2.applyInteractionHighlights("Image", ImageButton4, ImageButton4, {
                Transparency = 1,
                Color = u1._config.ResizeGripColor,
                HoveredColor = u1._config.ResizeGripHoveredColor,
                HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
                ActiveColor = u1._config.ResizeGripActiveColor,
                ActiveTransparency = u1._config.ResizeGripActiveTransparency
            });
            u2.applyInteractionHighlights("Image", ImageButton5, ImageButton5, {
                Transparency = 1,
                Color = u1._config.ResizeGripColor,
                HoveredColor = u1._config.ResizeGripHoveredColor,
                HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
                ActiveColor = u1._config.ResizeGripActiveColor,
                ActiveTransparency = u1._config.ResizeGripActiveTransparency
            });
            u2.applyInteractionHighlights("Image", ImageButton6, ImageButton6, {
                Transparency = 1,
                Color = u1._config.ResizeGripColor,
                HoveredColor = u1._config.ResizeGripHoveredColor,
                HoveredTransparency = u1._config.ResizeGripHoveredTransparency,
                ActiveColor = u1._config.ResizeGripActiveColor,
                ActiveTransparency = u1._config.ResizeGripActiveTransparency
            });
            local Frame4 = Instance.new("Frame");
            Frame4.Name = "ResizeBorder";
            Frame4.Size = UDim2.new(1, u1._config.WindowResizePadding.X * 2, 1, u1._config.WindowResizePadding.Y * 2);
            Frame4.Position = UDim2.fromOffset(-u1._config.WindowResizePadding.X, -u1._config.WindowResizePadding.Y);
            Frame4.BackgroundTransparency = 1;
            Frame4.BorderSizePixel = 0;
            Frame4.Active = true;
            Frame4.Selectable = false;
            Frame4.ClipsDescendants = false;
            Frame4.Parent = TextButton;
            u2.applyMouseEnter(Frame4, function() -- Line: 823
                -- upvalues: u16 (ref), u56 (copy), u13 (ref)
                if u16 == u56 then
                    u13 = true;
                end;
            end);
            u2.applyMouseLeave(Frame4, function() -- Line: 828
                -- upvalues: u16 (ref), u56 (copy), u13 (ref)
                if u16 == u56 then
                    u13 = false;
                end;
            end);
            u2.applyInputBegan(Frame4, function(p64: userdata) -- Line: 833
                -- upvalues: u56 (copy), u1 (ref)
                if p64.UserInputType == Enum.UserInputType.MouseMovement or p64.UserInputType == Enum.UserInputType.Keyboard then
                    return;
                end;

                if u56.state.isUncollapsed.value then
                    u1.SetFocusedWindow(u56);
                end;
            end);
            u2.applyMouseEnter(TextButton, function() -- Line: 842
                -- upvalues: u16 (ref), u56 (copy), u14 (ref)
                if u16 == u56 then
                    u14 = true;
                end;
            end);
            u2.applyMouseLeave(TextButton, function() -- Line: 847
                -- upvalues: u16 (ref), u56 (copy), u14 (ref)
                if u16 == u56 then
                    u14 = false;
                end;
            end);
            u56.ChildContainer = ScrollingFrame;

            return v57;
        end,

        Update = function(p65) -- Line: 856, Name: Update
            -- upvalues: u1 (copy)
            local ChildContainer = p65.ChildContainer;
            local WindowButton = p65.Instance.WindowButton;
            local Content = WindowButton.Content;
            local TitleBar = Content.TitleBar;
            local Title = TitleBar.Title;
            local MenuBar = Content:FindFirstChild("MenuBar");
            local LeftResizeGrip = WindowButton.LeftResizeGrip;
            local RightResizeGrip = WindowButton.RightResizeGrip;
            local LeftResizeBorder = WindowButton.LeftResizeBorder;
            local RightResizeBorder = WindowButton.RightResizeBorder;
            local TopResizeBorder = WindowButton.TopResizeBorder;
            local BottomResizeBorder = WindowButton.BottomResizeBorder;

            if p65.arguments.NoResize == true then
                LeftResizeGrip.Visible = false;
                RightResizeGrip.Visible = false;
                LeftResizeBorder.Visible = false;
                RightResizeBorder.Visible = false;
                TopResizeBorder.Visible = false;
                BottomResizeBorder.Visible = false;
            else
                LeftResizeGrip.Visible = true;
                RightResizeGrip.Visible = true;
                LeftResizeBorder.Visible = true;
                RightResizeBorder.Visible = true;
                TopResizeBorder.Visible = true;
                BottomResizeBorder.Visible = true;
            end;

            if p65.arguments.NoScrollbar then
                ChildContainer.ScrollBarThickness = 0;
            else
                ChildContainer.ScrollBarThickness = u1._config.ScrollbarSize;
            end;

            if p65.arguments.NoTitleBar then
                TitleBar.Visible = false;
            else
                TitleBar.Visible = true;
            end;

            if MenuBar then
                if p65.arguments.NoMenu then
                    MenuBar.Visible = false;
                else
                    MenuBar.Visible = true;
                end;
            end;

            if p65.arguments.NoBackground then
                ChildContainer.BackgroundTransparency = 1;
            else
                ChildContainer.BackgroundTransparency = u1._config.WindowBgTransparency;
            end;

            if p65.arguments.NoCollapse then
                TitleBar.CollapseButton.Visible = false;
            else
                TitleBar.CollapseButton.Visible = true;
            end;

            if p65.arguments.NoClose then
                TitleBar.CloseButton.Visible = false;
            else
                TitleBar.CloseButton.Visible = true;
            end;

            Title.Text = p65.arguments.Title or "";
        end,

        Discard = function(p66) -- Line: 923, Name: Discard
            -- upvalues: u16 (ref), u17 (ref), u8 (ref), u9 (ref), u11 (ref), u12 (ref), u18 (copy), u2 (copy)
            if u16 == p66 then
                u16 = nil;
                u17 = false;
            end;

            if u8 == p66 then
                u8 = nil;
                u9 = false;
            end;

            if u11 == p66 then
                u11 = nil;
                u12 = false;
            end;

            u18[p66.ID] = nil;
            p66.Instance:Destroy();
            u2.discardState(p66);
        end,

        ChildAdded = function(p67, p68) -- Line: 940, Name: ChildAdded
            local Content = p67.Instance.WindowButton.Content;

            if p68.type ~= "MenuBar" then
                return p67.ChildContainer;
            end;

            local ChildContainer = p67.ChildContainer;
            p68.Instance.ZIndex = ChildContainer.ZIndex + 1;
            p68.Instance.LayoutOrder = ChildContainer.LayoutOrder - 1;

            return Content;
        end,

        UpdateState = function(u69) -- Line: 952, Name: UpdateState
            -- upvalues: u1 (copy), u2 (copy)
            local value = u69.state.size.value;
            local value2 = u69.state.position.value;
            local value3 = u69.state.isUncollapsed.value;
            local value4 = u69.state.isOpened.value;
            local value5 = u69.state.scrollDistance.value;
            local Instance2 = u69.Instance;
            local ChildContainer = u69.ChildContainer;
            local WindowButton = Instance2.WindowButton;
            local Content = WindowButton.Content;
            local TitleBar = Content.TitleBar;
            local MenuBar = Content:FindFirstChild("MenuBar");
            local LeftResizeGrip = WindowButton.LeftResizeGrip;
            local RightResizeGrip = WindowButton.RightResizeGrip;
            local LeftResizeBorder = WindowButton.LeftResizeBorder;
            local RightResizeBorder = WindowButton.RightResizeBorder;
            local TopResizeBorder = WindowButton.TopResizeBorder;
            local BottomResizeBorder = WindowButton.BottomResizeBorder;
            WindowButton.Size = UDim2.fromOffset(value.X, value.Y);
            WindowButton.Position = UDim2.fromOffset(value2.X, value2.Y);

            if value4 then
                if u69.usesScreenGuis then
                    Instance2.Enabled = true;
                    WindowButton.Visible = true;
                else
                    Instance2.Visible = true;
                    WindowButton.Visible = true;
                end;

                u69.lastOpenedTick = u1._cycleTick + 1;
            else
                if u69.usesScreenGuis then
                    Instance2.Enabled = false;
                    WindowButton.Visible = false;
                else
                    Instance2.Visible = false;
                    WindowButton.Visible = false;
                end;

                u69.lastClosedTick = u1._cycleTick + 1;
            end;

            if value3 then
                TitleBar.CollapseButton.Arrow.Image = u2.ICONS.DOWN_POINTING_TRIANGLE;

                if MenuBar then
                    MenuBar.Visible = not u69.arguments.NoMenu;
                end;

                ChildContainer.Visible = true;

                if u69.arguments.NoResize ~= true then
                    LeftResizeGrip.Visible = true;
                    RightResizeGrip.Visible = true;
                    LeftResizeBorder.Visible = true;
                    RightResizeBorder.Visible = true;
                    TopResizeBorder.Visible = true;
                    BottomResizeBorder.Visible = true;
                end;

                WindowButton.AutomaticSize = Enum.AutomaticSize.None;
                u69.lastUncollapsedTick = u1._cycleTick + 1;
            else
                local Y = TitleBar.AbsoluteSize.Y;
                TitleBar.CollapseButton.Arrow.Image = u2.ICONS.RIGHT_POINTING_TRIANGLE;

                if MenuBar then
                    MenuBar.Visible = false;
                end;

                ChildContainer.Visible = false;
                LeftResizeGrip.Visible = false;
                RightResizeGrip.Visible = false;
                LeftResizeBorder.Visible = false;
                RightResizeBorder.Visible = false;
                TopResizeBorder.Visible = false;
                BottomResizeBorder.Visible = false;
                WindowButton.Size = UDim2.fromOffset(value.X, Y);
                u69.lastCollapsedTick = u1._cycleTick + 1;
            end;

            if value4 and value3 then
                u1.SetFocusedWindow(u69);
            else
                TitleBar.BackgroundColor3 = u1._config.TitleBgCollapsedColor;
                TitleBar.BackgroundTransparency = u1._config.TitleBgCollapsedTransparency;
                WindowButton.UIStroke.Color = u1._config.BorderColor;
                u1.SetFocusedWindow(nil);
            end;

            if value5 and value5 ~= 0 then
                local u70 = #u1._postCycleCallbacks + 1;
                local u71 = u1._cycleTick + 1;

                u1._postCycleCallbacks[u70] = function() -- Line: 1043
                    -- upvalues: u1 (ref), u71 (copy), u69 (copy), ChildContainer (copy), value5 (copy), u70 (copy)
                    if u71 <= u1._cycleTick then
                        if u69.lastCycleTick ~= -1 then
                            ChildContainer.CanvasPosition = Vector2.new(0, value5);
                        end;

                        u1._postCycleCallbacks[u70] = nil;
                    end;
                end;
            end;
        end,

        GenerateState = function(p72) -- Line: 1053, Name: GenerateState
            -- upvalues: u1 (copy), u17 (ref), u16 (ref), fitPositionToWindowBounds (copy), fitSizeToWindowBounds (copy)
            if p72.state.size == nil then
                p72.state.size = u1._widgetState(p72, "size", Vector2.new(400, 300));
            end;

            if p72.state.position == nil then
                local state = p72.state;
                local _widgetState = u1._widgetState;
                local v73;

                if u17 and u16 then
                    v73 = u16.state.position.value + Vector2.new(15, 45);
                else
                    v73 = Vector2.new(150, 250);
                end;

                state.position = _widgetState(p72, "position", v73);
            end;

            p72.state.position.value = fitPositionToWindowBounds(p72, p72.state.position.value);
            p72.state.size.value = fitSizeToWindowBounds(p72, p72.state.size.value);

            if p72.state.isUncollapsed == nil then
                p72.state.isUncollapsed = u1._widgetState(p72, "isUncollapsed", true);
            end;

            if p72.state.isOpened == nil then
                p72.state.isOpened = u1._widgetState(p72, "isOpened", true);
            end;

            if p72.state.scrollDistance == nil then
                p72.state.scrollDistance = u1._widgetState(p72, "scrollDistance", 0);
            end;
        end
    });
end;