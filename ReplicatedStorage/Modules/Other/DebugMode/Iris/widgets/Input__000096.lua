-- Decompiled with Potassium's decompiler.

require(script.Parent.Parent.Types);

return function(u1, u2) -- Line: 5
    local u5 = {
        Init = function(p3) -- Line: 7
        end,

        Get = function(p4) -- Line: 8
            -- upvalues: u1 (copy)
            return p4.lastNumberChangedTick == u1._cycleTick;
        end
    };

    local function getValueByIndex(p6: any, p7: number, p8: any) -- Line: 13
        local v9 = typeof(p6);

        if v9 == "number" then
            return p6;
        end;

        if v9 == "Vector2" then
            if p7 == 1 then
                return p6.X;
            end;

            if p7 == 2 then
                return p6.Y;
            end;
        elseif v9 == "Vector3" then
            if p7 == 1 then
                return p6.X;
            end;

            if p7 == 2 then
                return p6.Y;
            end;

            if p7 == 3 then
                return p6.Z;
            end;
        elseif v9 == "UDim" then
            if p7 == 1 then
                return p6.Scale;
            end;

            if p7 == 2 then
                return p6.Offset;
            end;
        elseif v9 == "UDim2" then
            if p7 == 1 then
                return p6.X.Scale;
            end;

            if p7 == 2 then
                return p6.X.Offset;
            end;

            if p7 == 3 then
                return p6.Y.Scale;
            end;

            if p7 == 4 then
                return p6.Y.Offset;
            end;
        elseif v9 == "Color3" then
            local v10 = p8.UseHSV and { p6:ToHSV() } or { p6.R, p6.G, p6.B };

            if p7 == 1 then
                return v10[1];
            end;

            if p7 == 2 then
                return v10[2];
            end;

            if p7 == 3 then
                return v10[3];
            end;
        elseif v9 == "Rect" then
            if p7 == 1 then
                return p6.Min.X;
            end;

            if p7 == 2 then
                return p6.Min.Y;
            end;

            if p7 == 3 then
                return p6.Max.X;
            end;

            if p7 == 4 then
                return p6.Max.Y;
            end;
        elseif v9 == "table" then
            return p6[p7];
        end;

        error((`Incorrect datatype or value: {p6} {typeof(p6)} {p7}.`));
    end;

    local function updateValueByIndex(p11: any, p12: number, p13: number, p14: any) -- Line: 74
        if typeof(p11) == "number" then
            return p13;
        end;

        if typeof(p11) == "Vector2" then
            if p12 == 1 then
                return Vector2.new(p13, p11.Y);
            end;

            if p12 == 2 then
                return Vector2.new(p11.X, p13);
            end;
        elseif typeof(p11) == "Vector3" then
            if p12 == 1 then
                return Vector3.new(p13, p11.Y, p11.Z);
            end;

            if p12 == 2 then
                return Vector3.new(p11.X, p13, p11.Z);
            end;

            if p12 == 3 then
                return Vector3.new(p11.X, p11.Y, p13);
            end;
        elseif typeof(p11) == "UDim" then
            if p12 == 1 then
                return UDim.new(p13, p11.Offset);
            end;

            if p12 == 2 then
                return UDim.new(p11.Scale, p13);
            end;
        elseif typeof(p11) == "UDim2" then
            if p12 == 1 then
                return UDim2.new(UDim.new(p13, p11.X.Offset), p11.Y);
            end;

            if p12 == 2 then
                return UDim2.new(UDim.new(p11.X.Scale, p13), p11.Y);
            end;

            if p12 == 3 then
                return UDim2.new(p11.X, UDim.new(p13, p11.Y.Offset));
            end;

            if p12 == 4 then
                return UDim2.new(p11.X, UDim.new(p11.Y.Scale, p13));
            end;
        elseif typeof(p11) == "Rect" then
            if p12 == 1 then
                return Rect.new(Vector2.new(p13, p11.Min.Y), p11.Max);
            end;

            if p12 == 2 then
                return Rect.new(Vector2.new(p11.Min.X, p13), p11.Max);
            end;

            if p12 == 3 then
                return Rect.new(p11.Min, Vector2.new(p13, p11.Max.Y));
            end;

            if p12 == 4 then
                return Rect.new(p11.Min, Vector2.new(p11.Max.X, p13));
            end;
        elseif typeof(p11) == "Color3" then
            if p14.UseHSV then
                local v15, v16, v17 = p11:ToHSV();

                if p12 == 1 then
                    return Color3.fromHSV(p13, v16, v17);
                end;

                if p12 == 2 then
                    return Color3.fromHSV(v15, p13, v17);
                end;

                if p12 == 3 then
                    return Color3.fromHSV(v15, v16, p13);
                end;
            end;

            if p12 == 1 then
                return Color3.new(p13, p11.G, p11.B);
            end;

            if p12 == 2 then
                return Color3.new(p11.R, p13, p11.B);
            end;

            if p12 == 3 then
                return Color3.new(p11.R, p11.G, p13);
            end;
        end;

        error((`Incorrect datatype or value {p11} {typeof(p11)} {p12}.`));
    end;

    local u18 = {
        Num = { 1 },
        Vector2 = { 1, 1 },
        Vector3 = { 1, 1, 1 },
        UDim = { 0.01, 1 },
        UDim2 = { 0.01, 1, 0.01, 1 },
        Color3 = { 1, 1, 1 },
        Color4 = { 1, 1, 1, 1 },
        Rect = { 1, 1, 1, 1 }
    };
    local u19 = {
        Num = { 0 },
        Vector2 = { 0, 0 },
        Vector3 = { 0, 0, 0 },
        UDim = { 0, 0 },
        UDim2 = { 0, 0, 0, 0 },
        Rect = { 0, 0, 0, 0 }
    };
    local u20 = {
        Num = { 100 },
        Vector2 = { 100, 100 },
        Vector3 = { 100, 100, 100 },
        UDim = { 1, 960 },
        UDim2 = { 1, 960, 1, 960 },
        Rect = { 960, 960, 960, 960 }
    };
    local u21 = {
        Num = { "" },
        Vector2 = { "X: ", "Y: " },
        Vector3 = { "X: ", "Y: ", "Z: " },
        UDim = { "", "" },
        UDim2 = { "", "", "", "" },
        Color3_RGB = { "R: ", "G: ", "B: " },
        Color3_HSV = { "H: ", "S: ", "V: " },
        Color4_RGB = { "R: ", "G: ", "B: ", "T: " },
        Color4_HSV = { "H: ", "S: ", "V: ", "T: " },
        Rect = { "X: ", "Y: ", "X: ", "Y: " }
    };
    local u22 = {
        Num = { 0 },
        Vector2 = { 0, 0 },
        Vector3 = { 0, 0, 0 },
        UDim = { 3, 0 },
        UDim2 = { 3, 0, 3, 0 },
        Color3 = { 0, 0, 0 },
        Color4 = { 0, 0, 0, 0 },
        Rect = { 0, 0, 0, 0 }
    };

    local function generateButtons(u23: any, p24: userdata, p25: number, p26: number) -- Line: 198
        -- upvalues: u1 (copy), u2 (copy), getValueByIndex (copy)
        local v27 = p25 + (2 * u1._config.ItemInnerSpacing.X + p26 * 2);
        local v28 = u2.abstractButton.Generate(u23);
        v28.Name = "SubButton";
        v28.ZIndex = 5;
        v28.LayoutOrder = 5;
        v28.TextXAlignment = Enum.TextXAlignment.Center;
        v28.Text = "-";
        v28.Size = UDim2.fromOffset(u1._config.TextSize + 2 * u1._config.FramePadding.Y, u1._config.TextSize);
        v28.Parent = p24;
        u2.applyButtonClick(v28, function() -- Line: 210
            -- upvalues: u2 (ref), u23 (copy), getValueByIndex (ref), u1 (ref)
            local v29 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl);
            local v30 = u23.arguments.Increment and getValueByIndex(u23.arguments.Increment, 1, u23.arguments) or 1;
            local v31 = u23.state.number.value - v30 * (v29 and 100 or 1);

            if u23.arguments.Min ~= nil then
                v31 = math.max(v31, getValueByIndex(u23.arguments.Min, 1, u23.arguments));
            end;

            if u23.arguments.Max ~= nil then
                v31 = math.min(v31, getValueByIndex(u23.arguments.Max, 1, u23.arguments));
            end;

            u23.state.number:set(v31);
            u23.lastNumberChangedTick = u1._cycleTick + 1;
        end);
        local v32 = u2.abstractButton.Generate(u23);
        v32.Name = "AddButton";
        v32.ZIndex = 6;
        v32.LayoutOrder = 6;
        v32.TextXAlignment = Enum.TextXAlignment.Center;
        v32.Text = "+";
        v32.Size = UDim2.fromOffset(u1._config.TextSize + 2 * u1._config.FramePadding.Y, u1._config.TextSize);
        v32.Parent = p24;
        u2.applyButtonClick(v32, function() -- Line: 233
            -- upvalues: u2 (ref), u23 (copy), getValueByIndex (ref), u1 (ref)
            local v33 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl);
            local v34 = u23.arguments.Increment and getValueByIndex(u23.arguments.Increment, 1, u23.arguments) or 1;
            local v35 = u23.state.number.value + v34 * (v33 and 100 or 1);

            if u23.arguments.Min ~= nil then
                v35 = math.max(v35, getValueByIndex(u23.arguments.Min, 1, u23.arguments));
            end;

            if u23.arguments.Max ~= nil then
                v35 = math.min(v35, getValueByIndex(u23.arguments.Max, 1, u23.arguments));
            end;

            u23.state.number:set(v35);
            u23.lastNumberChangedTick = u1._cycleTick + 1;
        end);

        return v27;
    end;

    local function generateInputScalar(u36: string, u37: number, u38: any) -- Line: 250
        -- upvalues: u5 (copy), u2 (copy), u1 (copy), generateButtons (copy), getValueByIndex (copy), updateValueByIndex (copy), u22 (copy), u21 (copy)
        return {
            hasState = true,
            hasChildren = false,
            Args = {
                Text = 1,
                Increment = 2,
                Min = 3,
                Max = 4,
                Format = 5
            },
            Events = {
                numberChanged = u5,
                hovered = u2.EVENTS.hover(function(p39) -- Line: 263
                    return p39.Instance;
                end)
            },

            Generate = function(u40) -- Line: 267, Name: Generate
                -- upvalues: u36 (copy), u2 (ref), u1 (ref), u37 (copy), generateButtons (ref), getValueByIndex (ref), updateValueByIndex (ref)
                local Frame = Instance.new("Frame");
                Frame.Name = "Iris_Input" .. u36;
                Frame.Size = UDim2.fromScale(1, 0);
                Frame.BackgroundTransparency = 1;
                Frame.BorderSizePixel = 0;
                Frame.LayoutOrder = u40.ZIndex;
                Frame.AutomaticSize = Enum.AutomaticSize.Y;
                u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local v41 = 0;
                local v42 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;

                if u37 == 1 then
                    v41 = generateButtons(u40, Frame, v41, v42);
                end;

                local UDim_new_ret = UDim.new(u1._config.ContentWidth.Scale / u37, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u37 - 1) - v41) / u37);
                local UDim_new_ret2 = UDim.new(UDim_new_ret.Scale * (u37 - 1), UDim_new_ret.Offset * (u37 - 1) + u1._config.ItemInnerSpacing.X * (u37 - 1) + v41);
                local v43 = u1._config.ContentWidth - UDim_new_ret2;

                for i = 1, u37 do
                    local TextBox = Instance.new("TextBox");
                    TextBox.Name = "InputField" .. tostring(i);
                    TextBox.LayoutOrder = i;

                    if i == u37 then
                        TextBox.Size = UDim2.new(v43, u1._config.ContentHeight);
                    else
                        TextBox.Size = UDim2.new(UDim_new_ret, u1._config.ContentHeight);
                    end;

                    TextBox.AutomaticSize = Enum.AutomaticSize.Y;
                    TextBox.BackgroundColor3 = u1._config.FrameBgColor;
                    TextBox.BackgroundTransparency = u1._config.FrameBgTransparency;
                    TextBox.ClearTextOnFocus = false;
                    TextBox.TextTruncate = Enum.TextTruncate.AtEnd;
                    TextBox.ClipsDescendants = true;
                    u2.applyFrameStyle(TextBox);
                    u2.applyTextStyle(TextBox);
                    u2.UISizeConstraint(TextBox, Vector2.xAxis);
                    TextBox.Parent = Frame;
                    TextBox.FocusLost:Connect(function() -- Line: 316
                        -- upvalues: TextBox (copy), u40 (copy), getValueByIndex (ref), i (copy), updateValueByIndex (ref), u1 (ref)
                        local v44 = tonumber(TextBox.Text:match("-?%d*%.?%d*"));

                        if v44 ~= nil then
                            if u40.arguments.Min ~= nil then
                                v44 = math.max(v44, getValueByIndex(u40.arguments.Min, i, u40.arguments));
                            end;

                            if u40.arguments.Max ~= nil then
                                v44 = math.min(v44, getValueByIndex(u40.arguments.Max, i, u40.arguments));
                            end;

                            if u40.arguments.Increment then
                                local v45 = v44 / getValueByIndex(u40.arguments.Increment, i, u40.arguments);
                                v44 = math.round(v45) * getValueByIndex(u40.arguments.Increment, i, u40.arguments);
                            end;

                            u40.state.number:set(updateValueByIndex(u40.state.number.value, i, v44, u40.arguments));
                            u40.lastNumberChangedTick = u1._cycleTick + 1;
                        end;

                        local v46 = u40.arguments.Format[i] or u40.arguments.Format[1];

                        if u40.arguments.Prefix then
                            v46 = u40.arguments.Prefix[i] .. v46;
                        end;

                        TextBox.Text = string.format(v46, getValueByIndex(u40.state.number.value, i, u40.arguments));
                        u40.state.editingText:set(0);
                    end);
                    TextBox.Focused:Connect(function() -- Line: 342
                        -- upvalues: TextBox (copy), u40 (copy), i (copy)
                        TextBox.CursorPosition = #TextBox.Text + 1;
                        TextBox.SelectionStart = 1;
                        u40.state.editingText:set(i);
                    end);
                    local _ = i;
                end;

                local TextLabel = Instance.new("TextLabel");
                TextLabel.Name = "TextLabel";
                TextLabel.BackgroundTransparency = 1;
                TextLabel.BorderSizePixel = 0;
                TextLabel.LayoutOrder = 7;
                TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
                u2.applyTextStyle(TextLabel);
                TextLabel.Parent = Frame;

                return Frame;
            end,

            Update = function(p47) -- Line: 364, Name: Update
                -- upvalues: u36 (copy), u37 (copy), u22 (ref), getValueByIndex (ref), u21 (ref)
                local Instance2 = p47.Instance;
                Instance2.TextLabel.Text = p47.arguments.Text or `Input {u36}`;

                if u37 == 1 then
                    Instance2.SubButton.Visible = not p47.arguments.NoButtons;
                    Instance2.AddButton.Visible = not p47.arguments.NoButtons;
                end;

                if p47.arguments.Format and typeof(p47.arguments.Format) ~= "table" then
                    p47.arguments.Format = { p47.arguments.Format };

                    return;
                end;

                if not p47.arguments.Format then
                    local v48 = {};

                    for i = 1, u37 do
                        local v49 = u22[u36][i];

                        if p47.arguments.Increment then
                            local v50 = getValueByIndex(p47.arguments.Increment, i, p47.arguments);
                            local v51 = -math.log10(v50 == 0 and 1 or v50);
                            local math_ceil_ret = math.ceil(v51);
                            v49 = math.max(v49, math_ceil_ret, v49);
                        end;

                        if p47.arguments.Max then
                            local v52 = getValueByIndex(p47.arguments.Max, i, p47.arguments);
                            local v53 = -math.log10(v52 == 0 and 1 or v52);
                            local math_ceil_ret = math.ceil(v53);
                            v49 = math.max(v49, math_ceil_ret, v49);
                        end;

                        if p47.arguments.Min then
                            local v54 = getValueByIndex(p47.arguments.Min, i, p47.arguments);
                            local v55 = -math.log10(v54 == 0 and 1 or v54);
                            local math_ceil_ret = math.ceil(v55);
                            v49 = math.max(v49, math_ceil_ret, v49);
                        end;

                        local v56;

                        if v49 > 0 then
                            v48[i] = `%.{v49}f`;
                            v56 = i;
                        else
                            v48[i] = "%d";
                            v56 = i;
                        end;
                    end;

                    p47.arguments.Format = v48;
                    p47.arguments.Prefix = u21[u36];
                end;
            end,

            Discard = function(p57) -- Line: 409, Name: Discard
                -- upvalues: u2 (ref)
                p57.Instance:Destroy();
                u2.discardState(p57);
            end,

            GenerateState = function(p58) -- Line: 413, Name: GenerateState
                -- upvalues: u1 (ref), u38 (copy)
                if p58.state.number == nil then
                    p58.state.number = u1._widgetState(p58, "number", u38);
                end;

                if p58.state.editingText == nil then
                    p58.state.editingText = u1._widgetState(p58, "editingText", 0);
                end;
            end,

            UpdateState = function(p59) -- Line: 421, Name: UpdateState
                -- upvalues: u37 (copy), getValueByIndex (ref)
                local Instance2 = p59.Instance;

                for i = 1, u37 do
                    local v60 = Instance2:FindFirstChild("InputField" .. tostring(i));
                    local v61 = p59.arguments.Format[i] or p59.arguments.Format[1];

                    if p59.arguments.Prefix then
                        v61 = p59.arguments.Prefix[i] .. v61;
                    end;

                    v60.Text = string.format(v61, getValueByIndex(p59.state.number.value, i, p59.arguments));
                    local _ = i;
                end;
            end
        };
    end;

    local u62 = 0;
    local u63 = false;
    local u64 = nil;
    local u65 = 0;
    local u66 = "";

    local function updateActiveDrag() -- Line: 449
        -- upvalues: u2 (copy), u62 (ref), u63 (ref), u64 (ref), u66 (ref), u65 (ref), getValueByIndex (copy), u18 (copy), updateValueByIndex (copy), u1 (copy)
        local X = u2.getMouseLocation().X;
        local v67 = X - u62;
        u62 = X;

        if u63 == false then
            return;
        end;

        if u64 == nil then
            return;
        end;

        local number = u64.state.number;

        if u66 == "Color3" or u66 == "Color4" then
            local v68 = u64;
            number = v68.state.color;

            if u65 == 4 then
                number = v68.state.transparency;
            end;
        end;

        local v69 = (u64.arguments.Increment and getValueByIndex(u64.arguments.Increment, u65, u64.arguments) or u18[u66][u65]) * ((u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightShift)) and 10 or 1) * ((u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightAlt)) and 0.1 or 1) * ((u66 == "Color3" or u66 == "Color4") and 5 or 1);
        local v70 = getValueByIndex(number.value, u65, u64.arguments) + v67 * v69;

        if u64.arguments.Min ~= nil then
            v70 = math.max(v70, getValueByIndex(u64.arguments.Min, u65, u64.arguments));
        end;

        if u64.arguments.Max ~= nil then
            v70 = math.min(v70, getValueByIndex(u64.arguments.Max, u65, u64.arguments));
        end;

        number:set(updateValueByIndex(number.value, u65, v70, u64.arguments));
        u64.lastNumberChangedTick = u1._cycleTick + 1;
    end;

    local function DragMouseDown(p71: any, p72: string, p73: number, p74: number, p75: number) -- Line: 489
        -- upvalues: u2 (copy), u1 (copy), u63 (ref), u64 (ref), u65 (ref), u66 (ref), updateActiveDrag (copy)
        local Time = u2.getTime();
        local v76 = Time - p71.lastClickedTime < u1._config.MouseDoubleClickTime;
        local v77 = u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl);

        if v76 and (Vector2.new(p74, p75) - p71.lastClickedPosition).Magnitude < u1._config.MouseDoubleClickMaxDist or v77 then
            p71.state.editingText:set(p73);

            return;
        end;

        p71.lastClickedTime = Time;
        p71.lastClickedPosition = Vector2.new(p74, p75);
        u63 = true;
        u64 = p71;
        u65 = p73;
        u66 = p72;
        updateActiveDrag();
    end;

    u2.registerEvent("InputChanged", function() -- Line: 507
        -- upvalues: u1 (copy), updateActiveDrag (copy)
        if not u1._started then
            return;
        end;

        updateActiveDrag();
    end);
    u2.registerEvent("InputEnded", function(p78: userdata) -- Line: 514
        -- upvalues: u1 (copy), u63 (ref), u64 (ref), u65 (ref)
        if not u1._started then
            return;
        end;

        if p78.UserInputType == Enum.UserInputType.MouseButton1 and u63 then
            u63 = false;
            u64 = nil;
            u65 = 0;
        end;
    end);

    local function generateDragScalar(u79: string, u80: number, u81: any) -- Line: 525
        -- upvalues: u5 (copy), u2 (copy), u1 (copy), getValueByIndex (copy), updateValueByIndex (copy), DragMouseDown (copy), u22 (copy), u21 (copy)
        return {
            hasState = true,
            hasChildren = false,
            Args = {
                Text = 1,
                Increment = 2,
                Min = 3,
                Max = 4,
                Format = 5
            },
            Events = {
                numberChanged = u5,
                hovered = u2.EVENTS.hover(function(p82) -- Line: 538
                    return p82.Instance;
                end)
            },

            Generate = function(u83) -- Line: 542, Name: Generate
                -- upvalues: u79 (copy), u2 (ref), u1 (ref), u80 (copy), getValueByIndex (ref), updateValueByIndex (ref), DragMouseDown (ref)
                u83.lastClickedTime = -1;
                u83.lastClickedPosition = Vector2.zero;
                local Frame = Instance.new("Frame");
                Frame.Name = "Iris_Drag" .. u79;
                Frame.Size = UDim2.fromScale(1, 0);
                Frame.BackgroundTransparency = 1;
                Frame.BorderSizePixel = 0;
                Frame.LayoutOrder = u83.ZIndex;
                Frame.AutomaticSize = Enum.AutomaticSize.Y;
                u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local v84 = 0;
                local v85 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;

                if u79 == "Color3" or u79 == "Color4" then
                    v84 = v84 + (u1._config.ItemInnerSpacing.X + v85);
                    local ImageLabel = Instance.new("ImageLabel");
                    ImageLabel.Name = "ColorBox";
                    ImageLabel.BorderSizePixel = 0;
                    ImageLabel.Size = UDim2.fromOffset(v85, v85);
                    ImageLabel.LayoutOrder = 5;
                    ImageLabel.Image = u2.ICONS.ALPHA_BACKGROUND_TEXTURE;
                    ImageLabel.ImageTransparency = 1;
                    u2.applyFrameStyle(ImageLabel, true);
                    ImageLabel.Parent = Frame;
                end;

                local UDim_new_ret = UDim.new(u1._config.ContentWidth.Scale / u80, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u80 - 1) - v84) / u80);
                local UDim_new_ret2 = UDim.new(UDim_new_ret.Scale * (u80 - 1), UDim_new_ret.Offset * (u80 - 1) + u1._config.ItemInnerSpacing.X * (u80 - 1) + v84);
                local v86 = u1._config.ContentWidth - UDim_new_ret2;

                for i = 1, u80 do
                    local TextButton = Instance.new("TextButton");
                    TextButton.Name = "DragField" .. tostring(i);
                    TextButton.LayoutOrder = i;

                    if i == u80 then
                        TextButton.Size = UDim2.new(v86, u1._config.ContentHeight);
                    else
                        TextButton.Size = UDim2.new(UDim_new_ret, u1._config.ContentHeight);
                    end;

                    TextButton.AutomaticSize = Enum.AutomaticSize.Y;
                    TextButton.BackgroundColor3 = u1._config.FrameBgColor;
                    TextButton.BackgroundTransparency = u1._config.FrameBgTransparency;
                    TextButton.AutoButtonColor = false;
                    TextButton.Text = "";
                    TextButton.ClipsDescendants = true;
                    u2.applyFrameStyle(TextButton);
                    u2.applyTextStyle(TextButton);
                    u2.UISizeConstraint(TextButton, Vector2.xAxis);
                    TextButton.TextXAlignment = Enum.TextXAlignment.Center;
                    TextButton.Parent = Frame;
                    u2.applyInteractionHighlights("Background", TextButton, TextButton, {
                        Color = u1._config.FrameBgColor,
                        Transparency = u1._config.FrameBgTransparency,
                        HoveredColor = u1._config.FrameBgHoveredColor,
                        HoveredTransparency = u1._config.FrameBgHoveredTransparency,
                        ActiveColor = u1._config.FrameBgActiveColor,
                        ActiveTransparency = u1._config.FrameBgActiveTransparency
                    });
                    local TextBox = Instance.new("TextBox");
                    TextBox.Name = "InputField";
                    TextBox.Size = UDim2.new(1, 0, 1, 0);
                    TextBox.BackgroundTransparency = 1;
                    TextBox.ClearTextOnFocus = false;
                    TextBox.TextTruncate = Enum.TextTruncate.AtEnd;
                    TextBox.ClipsDescendants = true;
                    TextBox.Visible = false;
                    u2.applyFrameStyle(TextBox, true);
                    u2.applyTextStyle(TextBox);
                    TextBox.Parent = TextButton;
                    TextBox.FocusLost:Connect(function() -- Line: 630
                        -- upvalues: TextBox (copy), u83 (copy), u79 (ref), i (copy), getValueByIndex (ref), updateValueByIndex (ref), u1 (ref)
                        local v87 = tonumber(TextBox.Text:match("-?%d*%.?%d*"));
                        local number = u83.state.number;
                        local v88 = u83;

                        if u79 == "Color4" and i == 4 then
                            number = v88.state.transparency;
                        elseif u79 == "Color3" or u79 == "Color4" then
                            number = v88.state.color;
                        end;

                        if v87 ~= nil then
                            if u79 == "Color3" or u79 == "Color4" and not v88.arguments.UseFloats then
                                v87 = v87 / 255;
                            end;

                            if u83.arguments.Min ~= nil then
                                v87 = math.max(v87, getValueByIndex(u83.arguments.Min, i, u83.arguments));
                            end;

                            if u83.arguments.Max ~= nil then
                                v87 = math.min(v87, getValueByIndex(u83.arguments.Max, i, u83.arguments));
                            end;

                            if u83.arguments.Increment then
                                local v89 = v87 / getValueByIndex(u83.arguments.Increment, i, u83.arguments);
                                v87 = math.round(v89) * getValueByIndex(u83.arguments.Increment, i, u83.arguments);
                            end;

                            number:set(updateValueByIndex(number.value, i, v87, u83.arguments));
                            u83.lastNumberChangedTick = u1._cycleTick + 1;
                        end;

                        local v90 = getValueByIndex(number.value, i, u83.arguments);

                        if u79 == "Color3" or u79 == "Color4" and not v88.arguments.UseFloats then
                            v90 = math.round(v90 * 255);
                        end;

                        local v91 = u83.arguments.Format[i] or u83.arguments.Format[1];

                        if u83.arguments.Prefix then
                            v91 = u83.arguments.Prefix[i] .. v91;
                        end;

                        TextBox.Text = string.format(v91, v90);
                        u83.state.editingText:set(0);
                        TextBox:ReleaseFocus(true);
                    end);
                    TextBox.Focused:Connect(function() -- Line: 673
                        -- upvalues: TextBox (copy), u83 (copy), i (copy)
                        TextBox.CursorPosition = #TextBox.Text + 1;
                        TextBox.SelectionStart = 1;
                        u83.state.editingText:set(i);
                    end);
                    u2.applyButtonDown(TextButton, function(p92: number, p93: number) -- Line: 681
                        -- upvalues: DragMouseDown (ref), u83 (copy), u79 (ref), i (copy)
                        DragMouseDown(u83, u79, i, p92, p93);
                    end);
                    local _ = i;
                end;

                local TextLabel = Instance.new("TextLabel");
                TextLabel.Name = "TextLabel";
                TextLabel.BackgroundTransparency = 1;
                TextLabel.BorderSizePixel = 0;
                TextLabel.LayoutOrder = 6;
                TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
                u2.applyTextStyle(TextLabel);
                TextLabel.Parent = Frame;

                return Frame;
            end,

            Update = function(p94) -- Line: 699, Name: Update
                -- upvalues: u79 (copy), u80 (copy), u22 (ref), getValueByIndex (ref), u21 (ref)
                p94.Instance.TextLabel.Text = p94.arguments.Text or `Drag {u79}`;

                if p94.arguments.Format and typeof(p94.arguments.Format) ~= "table" then
                    p94.arguments.Format = { p94.arguments.Format };

                    return;
                end;

                if not p94.arguments.Format then
                    local v95 = {};

                    for i = 1, u80 do
                        local v96 = u22[u79][i];

                        if p94.arguments.Increment then
                            local v97 = getValueByIndex(p94.arguments.Increment, i, p94.arguments);
                            local v98 = -math.log10(v97 == 0 and 1 or v97);
                            local math_ceil_ret = math.ceil(v98);
                            v96 = math.max(v96, math_ceil_ret, v96);
                        end;

                        if p94.arguments.Max then
                            local v99 = getValueByIndex(p94.arguments.Max, i, p94.arguments);
                            local v100 = -math.log10(v99 == 0 and 1 or v99);
                            local math_ceil_ret = math.ceil(v100);
                            v96 = math.max(v96, math_ceil_ret, v96);
                        end;

                        if p94.arguments.Min then
                            local v101 = getValueByIndex(p94.arguments.Min, i, p94.arguments);
                            local v102 = -math.log10(v101 == 0 and 1 or v101);
                            local math_ceil_ret = math.ceil(v102);
                            v96 = math.max(v96, math_ceil_ret, v96);
                        end;

                        local v103;

                        if v96 > 0 then
                            v95[i] = `%.{v96}f`;
                            v103 = i;
                        else
                            v95[i] = "%d";
                            v103 = i;
                        end;
                    end;

                    p94.arguments.Format = v95;
                    p94.arguments.Prefix = u21[u79];
                end;
            end,

            Discard = function(p104) -- Line: 739, Name: Discard
                -- upvalues: u2 (ref)
                p104.Instance:Destroy();
                u2.discardState(p104);
            end,

            GenerateState = function(p105) -- Line: 743, Name: GenerateState
                -- upvalues: u1 (ref), u81 (copy)
                if p105.state.number == nil then
                    p105.state.number = u1._widgetState(p105, "number", u81);
                end;

                if p105.state.editingText == nil then
                    p105.state.editingText = u1._widgetState(p105, "editingText", false);
                end;
            end,

            UpdateState = function(p106) -- Line: 751, Name: UpdateState
                -- upvalues: u80 (copy), u79 (copy), getValueByIndex (ref), u1 (ref)
                local Instance2 = p106.Instance;

                for i = 1, u80 do
                    local number = p106.state.number;

                    if u79 == "Color3" or u79 == "Color4" then
                        number = p106.state.color;

                        if i == 4 then
                            number = p106.state.transparency;
                        end;
                    end;

                    local v107 = Instance2:FindFirstChild("DragField" .. tostring(i));
                    local InputField = v107.InputField;
                    local v108 = getValueByIndex(number.value, i, p106.arguments);

                    if not (u79 ~= "Color3" and u79 ~= "Color4" or p106.arguments.UseFloats) then
                        v108 = math.round(v108 * 255);
                    end;

                    local v109 = p106.arguments.Format[i] or p106.arguments.Format[1];

                    if p106.arguments.Prefix then
                        v109 = p106.arguments.Prefix[i] .. v109;
                    end;

                    v107.Text = string.format(v109, v108);
                    InputField.Text = tostring(v108);
                    local v110;

                    if p106.state.editingText.value == i then
                        InputField.Visible = true;
                        InputField:CaptureFocus();
                        v107.TextTransparency = 1;
                        v110 = i;
                    else
                        InputField.Visible = false;
                        v107.TextTransparency = u1._config.TextTransparency;
                        v110 = i;
                    end;
                end;

                if u79 == "Color3" or u79 == "Color4" then
                    local ColorBox = Instance2.ColorBox;
                    ColorBox.BackgroundColor3 = p106.state.color.value;

                    if u79 == "Color4" then
                        ColorBox.ImageTransparency = 1 - p106.state.transparency.value;
                    end;
                end;
            end
        };
    end;

    local function generateColorDragScalar(u111: string, ...) -- Line: 800
        -- upvalues: generateDragScalar (ref), u2 (copy), u21 (copy), u1 (copy)
        local u112 = { ... };
        local v113 = generateDragScalar(u111, u111 == "Color4" and 4 or 3, u112[1]);

        return u2.extend(v113, {
            Args = {
                Text = 1,
                UseFloats = 2,
                UseHSV = 3,
                Format = 4
            },

            Update = function(p114) -- Line: 811, Name: Update
                -- upvalues: u111 (copy), u21 (ref), u1 (ref)
                p114.Instance.TextLabel.Text = p114.arguments.Text or `Drag {u111}`;

                if p114.arguments.Format and typeof(p114.arguments.Format) ~= "table" then
                    p114.arguments.Format = { p114.arguments.Format };
                elseif not p114.arguments.Format then
                    if p114.arguments.UseFloats then
                        p114.arguments.Format = { "%.3f" };
                    else
                        p114.arguments.Format = { "%d" };
                    end;

                    p114.arguments.Prefix = u21[u111 .. (p114.arguments.UseHSV and "_HSV" or "_RGB")];
                end;

                p114.arguments.Min = { 0, 0, 0, 0 };
                p114.arguments.Max = { 1, 1, 1, 1 };
                p114.arguments.Increment = { 0.001, 0.001, 0.001, 0.001 };

                if p114.state then
                    p114.state.color.lastChangeTick = u1._cycleTick;

                    if u111 == "Color4" then
                        p114.state.transparency.lastChangeTick = u1._cycleTick;
                    end;

                    u1._widgets[p114.type].UpdateState(p114);
                end;
            end,

            GenerateState = function(p115) -- Line: 842, Name: GenerateState
                -- upvalues: u1 (ref), u112 (copy), u111 (copy)
                if p115.state.color == nil then
                    p115.state.color = u1._widgetState(p115, "color", u112[1]);
                end;

                if u111 == "Color4" and p115.state.transparency == nil then
                    p115.state.transparency = u1._widgetState(p115, "transparency", u112[2]);
                end;

                if p115.state.editingText == nil then
                    p115.state.editingText = u1._widgetState(p115, "editingText", false);
                end;
            end
        });
    end;

    local u116 = false;
    local u117 = nil;
    local u118 = 0;
    local u119 = "";

    local function updateActiveSlider() -- Line: 870
        -- upvalues: u116 (ref), u117 (ref), u118 (ref), getValueByIndex (copy), u18 (copy), u119 (ref), u19 (copy), u20 (copy), u2 (copy), updateValueByIndex (copy), u1 (copy)
        if u116 == false then
            return;
        end;

        if u117 == nil then
            return;
        end;

        local v120 = u117.Instance:FindFirstChild("SliderField" .. tostring(u118));
        local GrabBar = v120.GrabBar;
        local v121 = u117.arguments.Increment and getValueByIndex(u117.arguments.Increment, u118, u117.arguments) or u18[u119][u118];
        local v122 = u117.arguments.Min and getValueByIndex(u117.arguments.Min, u118, u117.arguments) or u19[u119][u118];
        local v123 = u117.arguments.Max and getValueByIndex(u117.arguments.Max, u118, u117.arguments) or u20[u119][u118];
        local X = GrabBar.AbsoluteSize.X;
        local v124 = (u2.getMouseLocation().X - (v120.AbsolutePosition.X - u2.GuiOffset.X + X / 2)) / (v120.AbsoluteSize.X - X) * math.floor((v123 - v122) / v121);
        local v125 = math.round(v124) * v121 + v122;
        local math_clamp_ret = math.clamp(v125, v122, v123);
        u117.state.number:set(updateValueByIndex(u117.state.number.value, u118, math_clamp_ret, u117.arguments));
        u117.lastNumberChangedTick = u1._cycleTick + 1;
    end;

    local function SliderMouseDown(p126: any, p127: string, p128: number) -- Line: 896
        -- upvalues: u2 (copy), u116 (ref), u117 (ref), u118 (ref), u119 (ref), updateActiveSlider (copy)
        if u2.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u2.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
            p126.state.editingText:set(p128);

            return;
        end;

        u116 = true;
        u117 = p126;
        u118 = p128;
        u119 = p127;
        updateActiveSlider();
    end;

    u2.registerEvent("InputChanged", function() -- Line: 909
        -- upvalues: u1 (copy), updateActiveSlider (copy)
        if not u1._started then
            return;
        end;

        updateActiveSlider();
    end);
    u2.registerEvent("InputEnded", function(p129: userdata) -- Line: 916
        -- upvalues: u1 (copy), u116 (ref), u117 (ref), u118 (ref), u119 (ref)
        if not u1._started then
            return;
        end;

        if p129.UserInputType == Enum.UserInputType.MouseButton1 and u116 then
            u116 = false;
            u117 = nil;
            u118 = 0;
            u119 = "";
        end;
    end);

    local function generateSliderScalar(u130: string, u131: number, u132: any) -- Line: 928
        -- upvalues: u5 (copy), u2 (copy), u1 (copy), getValueByIndex (copy), updateValueByIndex (copy), SliderMouseDown (copy), u22 (copy), u21 (copy), u18 (copy), u19 (copy), u20 (copy)
        return {
            hasState = true,
            hasChildren = false,
            Args = {
                Text = 1,
                Increment = 2,
                Min = 3,
                Max = 4,
                Format = 5
            },
            Events = {
                numberChanged = u5,
                hovered = u2.EVENTS.hover(function(p133) -- Line: 941
                    return p133.Instance;
                end)
            },

            Generate = function(u134) -- Line: 945, Name: Generate
                -- upvalues: u130 (copy), u2 (ref), u1 (ref), u131 (copy), getValueByIndex (ref), updateValueByIndex (ref), SliderMouseDown (ref)
                local Frame = Instance.new("Frame");
                Frame.Name = "Iris_Slider" .. u130;
                Frame.Size = UDim2.fromScale(1, 0);
                Frame.BackgroundTransparency = 1;
                Frame.BorderSizePixel = 0;
                Frame.LayoutOrder = u134.ZIndex;
                Frame.AutomaticSize = Enum.AutomaticSize.Y;
                u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
                local UDim_new_ret = UDim.new(u1._config.ContentWidth.Scale / u131, (u1._config.ContentWidth.Offset - u1._config.ItemInnerSpacing.X * (u131 - 1)) / u131);
                local UDim_new_ret2 = UDim.new(UDim_new_ret.Scale * (u131 - 1), UDim_new_ret.Offset * (u131 - 1) + u1._config.ItemInnerSpacing.X * (u131 - 1));
                local v135 = u1._config.ContentWidth - UDim_new_ret2;

                for i = 1, u131 do
                    local TextButton = Instance.new("TextButton");
                    TextButton.Name = "SliderField" .. tostring(i);
                    TextButton.LayoutOrder = i;

                    if i == u131 then
                        TextButton.Size = UDim2.new(v135, u1._config.ContentHeight);
                    else
                        TextButton.Size = UDim2.new(UDim_new_ret, u1._config.ContentHeight);
                    end;

                    TextButton.AutomaticSize = Enum.AutomaticSize.Y;
                    TextButton.BackgroundColor3 = u1._config.FrameBgColor;
                    TextButton.BackgroundTransparency = u1._config.FrameBgTransparency;
                    TextButton.AutoButtonColor = false;
                    TextButton.Text = "";
                    TextButton.ClipsDescendants = true;
                    u2.applyFrameStyle(TextButton);
                    u2.applyTextStyle(TextButton);
                    u2.UISizeConstraint(TextButton, Vector2.xAxis);
                    TextButton.Parent = Frame;
                    local TextLabel = Instance.new("TextLabel");
                    TextLabel.Name = "OverlayText";
                    TextLabel.Size = UDim2.fromScale(1, 1);
                    TextLabel.BackgroundTransparency = 1;
                    TextLabel.BorderSizePixel = 0;
                    TextLabel.ZIndex = 10;
                    TextLabel.ClipsDescendants = true;
                    u2.applyTextStyle(TextLabel);
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
                    TextLabel.Parent = TextButton;
                    u2.applyInteractionHighlights("Background", TextButton, TextButton, {
                        Color = u1._config.FrameBgColor,
                        Transparency = u1._config.FrameBgTransparency,
                        HoveredColor = u1._config.FrameBgHoveredColor,
                        HoveredTransparency = u1._config.FrameBgHoveredTransparency,
                        ActiveColor = u1._config.FrameBgActiveColor,
                        ActiveTransparency = u1._config.FrameBgActiveTransparency
                    });
                    local TextBox = Instance.new("TextBox");
                    TextBox.Name = "InputField";
                    TextBox.Size = UDim2.new(1, 0, 1, 0);
                    TextBox.BackgroundTransparency = 1;
                    TextBox.ClearTextOnFocus = false;
                    TextBox.TextTruncate = Enum.TextTruncate.AtEnd;
                    TextBox.ClipsDescendants = true;
                    TextBox.Visible = false;
                    u2.applyFrameStyle(TextBox, true);
                    u2.applyTextStyle(TextBox);
                    TextBox.Parent = TextButton;
                    TextBox.FocusLost:Connect(function() -- Line: 1022
                        -- upvalues: TextBox (copy), u134 (copy), getValueByIndex (ref), i (copy), updateValueByIndex (ref), u1 (ref)
                        local v136 = tonumber(TextBox.Text:match("-?%d*%.?%d*"));

                        if v136 ~= nil then
                            if u134.arguments.Min ~= nil then
                                v136 = math.max(v136, getValueByIndex(u134.arguments.Min, i, u134.arguments));
                            end;

                            if u134.arguments.Max ~= nil then
                                v136 = math.min(v136, getValueByIndex(u134.arguments.Max, i, u134.arguments));
                            end;

                            if u134.arguments.Increment then
                                local v137 = v136 / getValueByIndex(u134.arguments.Increment, i, u134.arguments);
                                v136 = math.round(v137) * getValueByIndex(u134.arguments.Increment, i, u134.arguments);
                            end;

                            u134.state.number:set(updateValueByIndex(u134.state.number.value, i, v136, u134.arguments));
                            u134.lastNumberChangedTick = u1._cycleTick + 1;
                        end;

                        local v138 = u134.arguments.Format[i] or u134.arguments.Format[1];

                        if u134.arguments.Prefix then
                            v138 = u134.arguments.Prefix[i] .. v138;
                        end;

                        TextBox.Text = string.format(v138, getValueByIndex(u134.state.number.value, i, u134.arguments));
                        u134.state.editingText:set(0);
                        TextBox:ReleaseFocus(true);
                    end);
                    TextBox.Focused:Connect(function() -- Line: 1051
                        -- upvalues: TextBox (copy), u134 (copy), i (copy)
                        TextBox.CursorPosition = #TextBox.Text + 1;
                        TextBox.SelectionStart = 1;
                        u134.state.editingText:set(i);
                    end);
                    u2.applyButtonDown(TextButton, function() -- Line: 1059
                        -- upvalues: SliderMouseDown (ref), u134 (copy), u130 (ref), i (copy)
                        SliderMouseDown(u134, u130, i);
                    end);
                    local Frame2 = Instance.new("Frame");
                    Frame2.Name = "GrabBar";
                    Frame2.ZIndex = 5;
                    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
                    Frame2.Position = UDim2.new(0, 0, 0.5, 0);
                    Frame2.BorderSizePixel = 0;
                    Frame2.BackgroundColor3 = u1._config.SliderGrabColor;
                    Frame2.Transparency = u1._config.SliderGrabTransparency;

                    if u1._config.GrabRounding > 0 then
                        u2.UICorner(Frame2, u1._config.GrabRounding);
                    end;

                    u2.UISizeConstraint(Frame2, Vector2.new(u1._config.GrabMinSize, 0));
                    Frame2.Parent = TextButton;
                    local _ = i;
                end;

                local TextLabel = Instance.new("TextLabel");
                TextLabel.Name = "TextLabel";
                TextLabel.BackgroundTransparency = 1;
                TextLabel.BorderSizePixel = 0;
                TextLabel.LayoutOrder = 5;
                TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
                u2.applyTextStyle(TextLabel);
                TextLabel.Parent = Frame;

                return Frame;
            end,

            Update = function(u139) -- Line: 1093, Name: Update
                -- upvalues: u130 (copy), u131 (copy), u22 (ref), getValueByIndex (ref), u21 (ref), u18 (ref), u19 (ref), u20 (ref), u1 (ref)
                local Instance2 = u139.Instance;
                Instance2.TextLabel.Text = u139.arguments.Text or `Slider {u130}`;

                if u139.arguments.Format and typeof(u139.arguments.Format) ~= "table" then
                    u139.arguments.Format = { u139.arguments.Format };
                elseif not u139.arguments.Format then
                    local v140 = {};

                    for i = 1, u131 do
                        local v141 = u22[u130][i];

                        if u139.arguments.Increment then
                            local v142 = getValueByIndex(u139.arguments.Increment, i, u139.arguments);
                            local v143 = -math.log10(v142 == 0 and 1 or v142);
                            local math_ceil_ret = math.ceil(v143);
                            v141 = math.max(v141, math_ceil_ret, v141);
                        end;

                        if u139.arguments.Max then
                            local v144 = getValueByIndex(u139.arguments.Max, i, u139.arguments);
                            local v145 = -math.log10(v144 == 0 and 1 or v144);
                            local math_ceil_ret = math.ceil(v145);
                            v141 = math.max(v141, math_ceil_ret, v141);
                        end;

                        if u139.arguments.Min then
                            local v146 = getValueByIndex(u139.arguments.Min, i, u139.arguments);
                            local v147 = -math.log10(v146 == 0 and 1 or v146);
                            local math_ceil_ret = math.ceil(v147);
                            v141 = math.max(v141, math_ceil_ret, v141);
                        end;

                        local v148;

                        if v141 > 0 then
                            v140[i] = `%.{v141}f`;
                            v148 = i;
                        else
                            v140[i] = "%d";
                            v148 = i;
                        end;
                    end;

                    u139.arguments.Format = v140;
                    u139.arguments.Prefix = u21[u130];
                end;

                for i = 1, u131 do
                    local GrabBar = Instance2:FindFirstChild("SliderField" .. tostring(i)).GrabBar;
                    local v149 = u139.arguments.Increment and getValueByIndex(u139.arguments.Increment, i, u139.arguments) or u18[u130][i];
                    local v150 = u139.arguments.Min and getValueByIndex(u139.arguments.Min, i, u139.arguments) or u19[u130][i];
                    local v151 = u139.arguments.Max and getValueByIndex(u139.arguments.Max, i, u139.arguments) or u20[u130][i];
                    local v152 = 1 / math.floor((v151 + 1 - v150) / v149);
                    GrabBar.Size = UDim2.new(v152, 0, 1, 0);
                    local _ = i;
                end;

                local u153 = #u1._postCycleCallbacks + 1;
                local u154 = u1._cycleTick + 1;

                u1._postCycleCallbacks[u153] = function() -- Line: 1148
                    -- upvalues: u1 (ref), u154 (copy), u139 (copy), u130 (ref), u153 (copy)
                    if u154 <= u1._cycleTick then
                        if u139.lastCycleTick ~= -1 then
                            u139.state.number.lastChangeTick = u1._cycleTick;
                            u1._widgets[`Slider{u130}`].UpdateState(u139);
                        end;

                        u1._postCycleCallbacks[u153] = nil;
                    end;
                end;
            end,

            Discard = function(p155) -- Line: 1158, Name: Discard
                -- upvalues: u2 (ref)
                p155.Instance:Destroy();
                u2.discardState(p155);
            end,

            GenerateState = function(p156) -- Line: 1162, Name: GenerateState
                -- upvalues: u1 (ref), u132 (copy)
                if p156.state.number == nil then
                    p156.state.number = u1._widgetState(p156, "number", u132);
                end;

                if p156.state.editingText == nil then
                    p156.state.editingText = u1._widgetState(p156, "editingText", false);
                end;
            end,

            UpdateState = function(p157) -- Line: 1170, Name: UpdateState
                -- upvalues: u131 (copy), getValueByIndex (ref), u18 (ref), u130 (copy), u19 (ref), u20 (ref)
                local Instance2 = p157.Instance;

                for i = 1, u131 do
                    local v158 = Instance2:FindFirstChild("SliderField" .. tostring(i));
                    local InputField = v158.InputField;
                    local OverlayText = v158.OverlayText;
                    local GrabBar = v158.GrabBar;
                    local v159 = getValueByIndex(p157.state.number.value, i, p157.arguments);
                    local v160 = p157.arguments.Format[i] or p157.arguments.Format[1];

                    if p157.arguments.Prefix then
                        v160 = p157.arguments.Prefix[i] .. v160;
                    end;

                    OverlayText.Text = string.format(v160, v159);
                    InputField.Text = tostring(v159);
                    local v161 = p157.arguments.Increment and getValueByIndex(p157.arguments.Increment, i, p157.arguments) or u18[u130][i];
                    local v162 = p157.arguments.Min and getValueByIndex(p157.arguments.Min, i, p157.arguments) or u19[u130][i];
                    local v163 = p157.arguments.Max and getValueByIndex(p157.arguments.Max, i, p157.arguments) or u20[u130][i];
                    local X = v158.AbsoluteSize.X;
                    local v164 = X - GrabBar.AbsoluteSize.X;
                    local math_floor_ret = math.floor((v163 - v162) / v161);
                    local v165 = math.floor((v159 - v162) / (v163 - v162) * math_floor_ret) / math_floor_ret;
                    local math_clamp_ret = math.clamp(v165, 0, 1);
                    GrabBar.Position = UDim2.new(v164 / X * math_clamp_ret + (1 - v164 / X) / 2, 0, 0.5, 0);
                    local v166;

                    if p157.state.editingText.value == i then
                        InputField.Visible = true;
                        OverlayText.Visible = false;
                        GrabBar.Visible = false;
                        InputField:CaptureFocus();
                        v166 = i;
                    else
                        InputField.Visible = false;
                        OverlayText.Visible = true;
                        GrabBar.Visible = true;
                        v166 = i;
                    end;
                end;
            end
        };
    end;

    local function generateEnumSliderScalar(u167: userdata, u168: userdata) -- Line: 1216
        -- upvalues: generateSliderScalar (ref), u2 (copy), u1 (copy)
        local v169 = generateSliderScalar("Enum", 1, u168.Value);
        local v170 = { string };

        for _, v in u167:GetEnumItems() do
            v170[v.Value] = v.Name;
        end;

        return u2.extend(v169, {
            Args = {
                Text = 1
            },

            Update = function(p171) -- Line: 1228, Name: Update
                -- upvalues: u167 (copy)
                local Instance2 = p171.Instance;
                Instance2.TextLabel.Text = p171.arguments.Text or "Input Enum";
                p171.arguments.Increment = 1;
                p171.arguments.Min = 0;
                p171.arguments.Max = #u167:GetEnumItems() - 1;
                local GrabBar = Instance2:FindFirstChild("SliderField1").GrabBar;
                local v172 = #u167:GetEnumItems();
                local v173 = 1 / math.floor(v172);
                GrabBar.Size = UDim2.new(v173, 0, 1, 0);
            end,

            GenerateState = function(p174) -- Line: 1244, Name: GenerateState
                -- upvalues: u1 (ref), u168 (copy)
                if p174.state.number == nil then
                    p174.state.number = u1._widgetState(p174, "number", u168.Value);
                end;

                if p174.state.enumItem == nil then
                    p174.state.enumItem = u1._widgetState(p174, "enumItem", u168);
                end;

                if p174.state.editingText == nil then
                    p174.state.editingText = u1._widgetState(p174, "editingText", false);
                end;
            end
        });
    end;

    local v175 = generateInputScalar("Num", 1, 0);
    v175.Args.NoButtons = 6;
    u1.WidgetConstructor("InputNum", v175);
    u1.WidgetConstructor("InputVector2", generateInputScalar("Vector2", 2, Vector2.zero));
    u1.WidgetConstructor("InputVector3", generateInputScalar("Vector3", 3, Vector3.new(0, 0, 0)));
    u1.WidgetConstructor("InputUDim", generateInputScalar("UDim", 2, UDim.new()));
    u1.WidgetConstructor("InputUDim2", generateInputScalar("UDim2", 4, UDim2.new()));
    u1.WidgetConstructor("InputRect", generateInputScalar("Rect", 4, Rect.new(0, 0, 0, 0)));
    u1.WidgetConstructor("DragNum", generateDragScalar("Num", 1, 0));
    u1.WidgetConstructor("DragVector2", generateDragScalar("Vector2", 2, Vector2.zero));
    u1.WidgetConstructor("DragVector3", generateDragScalar("Vector3", 3, Vector3.new(0, 0, 0)));
    u1.WidgetConstructor("DragUDim", generateDragScalar("UDim", 2, UDim.new()));
    u1.WidgetConstructor("DragUDim2", generateDragScalar("UDim2", 4, UDim2.new()));
    u1.WidgetConstructor("DragRect", generateDragScalar("Rect", 4, Rect.new(0, 0, 0, 0)));
    u1.WidgetConstructor("InputColor3", generateColorDragScalar("Color3", Color3.fromRGB(0, 0, 0)));
    u1.WidgetConstructor("InputColor4", generateColorDragScalar("Color4", Color3.fromRGB(0, 0, 0), 0));
    u1.WidgetConstructor("SliderNum", generateSliderScalar("Num", 1, 0));
    u1.WidgetConstructor("SliderVector2", generateSliderScalar("Vector2", 2, Vector2.zero));
    u1.WidgetConstructor("SliderVector3", generateSliderScalar("Vector3", 3, Vector3.new(0, 0, 0)));
    u1.WidgetConstructor("SliderUDim", generateSliderScalar("UDim", 2, UDim.new()));
    u1.WidgetConstructor("SliderUDim2", generateSliderScalar("UDim2", 4, UDim2.new()));
    u1.WidgetConstructor("SliderRect", generateSliderScalar("Rect", 4, Rect.new(0, 0, 0, 0)));
    u1.WidgetConstructor("InputText", {
        hasState = true,
        hasChildren = false,
        Args = {
            Text = 1,
            TextHint = 2,
            ReadOnly = 3,
            MultiLine = 4
        },
        Events = {
            textChanged = {
                Init = function(p176) -- Line: 1300
                    p176.lastTextChangedTick = 0;
                end,

                Get = function(p177) -- Line: 1303
                    -- upvalues: u1 (copy)
                    return p177.lastTextChangedTick == u1._cycleTick;
                end
            },
            hovered = u2.EVENTS.hover(function(p178) -- Line: 1307
                return p178.Instance;
            end)
        },

        Generate = function(u179) -- Line: 1311, Name: Generate
            -- upvalues: u2 (copy), u1 (copy)
            local Frame = Instance.new("Frame");
            Frame.Name = "Iris_InputText";
            Frame.AutomaticSize = Enum.AutomaticSize.Y;
            Frame.Size = UDim2.fromScale(1, 0);
            Frame.BackgroundTransparency = 1;
            Frame.BorderSizePixel = 0;
            Frame.ZIndex = u179.ZIndex;
            Frame.LayoutOrder = u179.ZIndex;
            u2.UIListLayout(Frame, Enum.FillDirection.Horizontal, UDim.new(0, u1._config.ItemInnerSpacing.X)).VerticalAlignment = Enum.VerticalAlignment.Center;
            local TextBox = Instance.new("TextBox");
            TextBox.Name = "InputField";
            TextBox.Size = UDim2.new(u1._config.ContentWidth, u1._config.ContentHeight);
            TextBox.AutomaticSize = Enum.AutomaticSize.Y;
            TextBox.BackgroundColor3 = u1._config.FrameBgColor;
            TextBox.BackgroundTransparency = u1._config.FrameBgTransparency;
            TextBox.Text = "";
            TextBox.TextYAlignment = Enum.TextYAlignment.Top;
            TextBox.PlaceholderColor3 = u1._config.TextDisabledColor;
            TextBox.ClearTextOnFocus = false;
            TextBox.ClipsDescendants = true;
            u2.applyFrameStyle(TextBox);
            u2.applyTextStyle(TextBox);
            u2.UISizeConstraint(TextBox, Vector2.xAxis);
            TextBox.Parent = Frame;
            TextBox.FocusLost:Connect(function() -- Line: 1342
                -- upvalues: u179 (copy), TextBox (copy), u1 (ref)
                u179.state.text:set(TextBox.Text);
                u179.lastTextChangedTick = u1._cycleTick + 1;
            end);
            local v180 = u1._config.TextSize + 2 * u1._config.FramePadding.Y;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "TextLabel";
            TextLabel.Size = UDim2.fromOffset(0, v180);
            TextLabel.AutomaticSize = Enum.AutomaticSize.X;
            TextLabel.BackgroundTransparency = 1;
            TextLabel.BorderSizePixel = 0;
            TextLabel.LayoutOrder = 1;
            u2.applyTextStyle(TextLabel);
            TextLabel.Parent = Frame;

            return Frame;
        end,

        Update = function(p181) -- Line: 1363, Name: Update
            local Instance2 = p181.Instance;
            local InputField = Instance2.InputField;
            Instance2.TextLabel.Text = p181.arguments.Text or "Input Text";
            InputField.PlaceholderText = p181.arguments.TextHint or "";
            InputField.TextEditable = not p181.arguments.ReadOnly;
            InputField.MultiLine = p181.arguments.MultiLine or false;
        end,

        Discard = function(p182) -- Line: 1373, Name: Discard
            -- upvalues: u2 (copy)
            p182.Instance:Destroy();
            u2.discardState(p182);
        end,

        GenerateState = function(p183) -- Line: 1377, Name: GenerateState
            -- upvalues: u1 (copy)
            if p183.state.text == nil then
                p183.state.text = u1._widgetState(p183, "text", "");
            end;
        end,

        UpdateState = function(p184) -- Line: 1382, Name: UpdateState
            p184.Instance.InputField.Text = p184.state.text.value;
        end
    });
end;