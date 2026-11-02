-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);

return function(u1, u2) -- Line: 3
    u1.WidgetConstructor("RadioButton", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            Index = 2
        },
        Events = {
            selected = {
                Init = function(p3) -- Line: 14
                end,

                Get = function(p4) -- Line: 15
                    -- upvalues: u1 (copy)
                    return p4.lastSelectedTick == u1._cycleTick;
                end
            },
            unselected = {
                Init = function(p5) -- Line: 20
                end,

                Get = function(p6) -- Line: 21
                    -- upvalues: u1 (copy)
                    return p6.lastUnselectedTick == u1._cycleTick;
                end
            },
            active = {
                Init = function(p7) -- Line: 26
                end,

                Get = function(p8) -- Line: 27
                    return p8.state.index.value == p8.arguments.Index;
                end
            },
            hovered = u2.EVENTS.hover(function(p9) -- Line: 31
                return p9.Instance;
            end)
        },

        Generate = function(u10) -- Line: 35, Name: Generate
            -- upvalues: u2 (copy), u1 (copy)
            local TextButton = Instance.new("TextButton");
            TextButton.Name = "Iris_RadioButton";
            TextButton.AutomaticSize = Enum.AutomaticSize.XY;
            TextButton.Size = UDim2.fromOffset(0, 0);
            TextButton.BackgroundTransparency = 1;
            TextButton.BorderSizePixel = 0;
            TextButton.Text = "";
            TextButton.LayoutOrder = u10.ZIndex;
            TextButton.AutoButtonColor = false;
            TextButton.ZIndex = u10.ZIndex;
            TextButton.LayoutOrder = u10.ZIndex;
            u2.UIListLayout(TextButton, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local v11 = u1._config.TextSize + 2 * (u1._config.FramePadding.Y - 1);
            local Frame = Instance.new("Frame");
            Frame.Name = "Button";
            Frame.Size = UDim2.fromOffset(v11, v11);
            Frame.Parent = TextButton;
            Frame.BackgroundColor3 = u1._config.FrameBgColor;
            Frame.BackgroundTransparency = u1._config.FrameBgTransparency;
            u2.UICorner(Frame);
            local UIPadding = u2.UIPadding;
            local Vector2_new = Vector2.new;
            local math_floor_ret = math.floor(v11 / 5);
            local math_max_ret = math.max(1, math_floor_ret);
            local math_floor_ret2 = math.floor(v11 / 5);
            UIPadding(Frame, Vector2_new(math_max_ret, (math.max(1, math_floor_ret2))));
            local Frame2 = Instance.new("Frame");
            Frame2.Name = "Circle";
            Frame2.Size = UDim2.fromScale(1, 1);
            Frame2.Parent = Frame;
            Frame2.BackgroundColor3 = u1._config.CheckMarkColor;
            Frame2.BackgroundTransparency = u1._config.CheckMarkTransparency;
            u2.UICorner(Frame2);
            u2.applyInteractionHighlights("Background", TextButton, Frame, {
                Color = u1._config.FrameBgColor,
                Transparency = u1._config.FrameBgTransparency,
                HoveredColor = u1._config.FrameBgHoveredColor,
                HoveredTransparency = u1._config.FrameBgHoveredTransparency,
                ActiveColor = u1._config.FrameBgActiveColor,
                ActiveTransparency = u1._config.FrameBgActiveTransparency
            });
            u2.applyButtonClick(TextButton, function() -- Line: 79
                -- upvalues: u10 (copy)
                u10.state.index:set(u10.arguments.Index);
            end);
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "TextLabel";
            TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
            TextLabel.BackgroundTransparency = 1;
            TextLabel.BorderSizePixel = 0;
            TextLabel.LayoutOrder = 1;
            u2.applyTextStyle(TextLabel);
            TextLabel.Parent = TextButton;

            return TextButton;
        end,

        Update = function(p12) -- Line: 95, Name: Update
            -- upvalues: u1 (copy)
            p12.Instance.TextLabel.Text = p12.arguments.Text or "Radio Button";

            if p12.state then
                p12.state.index.lastChangeTick = u1._cycleTick;
                u1._widgets[p12.type].UpdateState(p12);
            end;
        end,

        Discard = function(p13) -- Line: 105, Name: Discard
            -- upvalues: u2 (copy)
            p13.Instance:Destroy();
            u2.discardState(p13);
        end,

        GenerateState = function(p14) -- Line: 109, Name: GenerateState
            -- upvalues: u1 (copy)
            if p14.state.index == nil then
                p14.state.index = u1._widgetState(p14, "index", p14.arguments.Index);
            end;
        end,

        UpdateState = function(p15) -- Line: 114, Name: UpdateState
            -- upvalues: u1 (copy)
            local Circle = p15.Instance.Button.Circle;

            if p15.state.index.value == p15.arguments.Index then
                Circle.BackgroundTransparency = u1._config.CheckMarkTransparency;
                p15.lastSelectedTick = u1._cycleTick + 1;

                return;
            end;

            Circle.BackgroundTransparency = 1;
            p15.lastUnselectedTick = u1._cycleTick + 1;
        end
    });
end;