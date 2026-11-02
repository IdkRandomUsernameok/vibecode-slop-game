-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
local u1 = {};

return function(u2) -- Line: 5
    -- upvalues: u1 (copy)
    u1.GuiService = game:GetService("GuiService");
    u1.RunService = game:GetService("RunService");
    u1.UserInputService = game:GetService("UserInputService");
    u1.ContextActionService = game:GetService("ContextActionService");
    u1.TextService = game:GetService("TextService");
    u1.ICONS = {
        RIGHT_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_right.png",
        DOWN_POINTING_TRIANGLE = "rbxasset://textures/DeveloperFramework/button_arrow_down.png",
        MULTIPLICATION_SIGN = "rbxasset://textures/AnimationEditor/icon_close.png",
        BOTTOM_RIGHT_CORNER = "rbxasset://textures/ui/InspectMenu/gr-item-selector-triangle.png",
        CHECK_MARK = "rbxasset://textures/AnimationEditor/icon_checkmark.png",
        BORDER = "rbxasset://textures/ui/InspectMenu/gr-item-selector.png",
        ALPHA_BACKGROUND_TEXTURE = "rbxasset://textures/meshPartFallback.png",
        UNKNOWN_TEXTURE = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    };
    u1.IS_STUDIO = u1.RunService:IsStudio();

    function u1.getTime() -- Line: 24
        -- upvalues: u1 (ref)
        if u1.IS_STUDIO then
            return os.clock();
        end;

        return time();
    end;

    local v3;

    if u2._config.IgnoreGuiInset then
        v3 = -u1.GuiService:GetGuiInset();
    else
        v3 = Vector2.zero;
    end;

    u1.GuiOffset = v3;
    local v4;

    if u2._config.IgnoreGuiInset then
        v4 = Vector2.zero;
    else
        v4 = u1.GuiService:GetGuiInset();
    end;

    u1.MouseOffset = v4;
    local u5 = nil;
    u5 = u1.GuiService:GetPropertyChangedSignal("TopbarInset"):Once(function() -- Line: 40
        -- upvalues: u1 (ref), u2 (copy), u5 (ref)
        local v6;

        if u2._config.IgnoreGuiInset then
            v6 = Vector2.zero;
        else
            v6 = u1.GuiService:GetGuiInset();
        end;

        u1.MouseOffset = v6;
        local v7;

        if u2._config.IgnoreGuiInset then
            v7 = -u1.GuiService:GetGuiInset();
        else
            v7 = Vector2.zero;
        end;

        u1.GuiOffset = v7;
        u5:Disconnect();
    end);
    task.delay(5, function() -- Line: 46
        -- upvalues: u5 (ref)
        u5:Disconnect();
    end);

    function u1.getMouseLocation() -- Line: 50
        -- upvalues: u1 (ref)
        return u1.UserInputService:GetMouseLocation() - u1.MouseOffset;
    end;

    function u1.isPosInsideRect(p8, p9, p10) -- Line: 54
        local v11;

        if p8.X >= p9.X and (p8.X <= p10.X and p8.Y >= p9.Y) then
            v11 = p8.Y <= p10.Y;
        else
            v11 = false;
        end;

        return v11;
    end;

    function u1.findBestWindowPosForPopup(p12, p13, p14, p15) -- Line: 58
        local v16;

        if p12.X + p13.X + 20 > p15.X then
            if p12.Y + p13.Y + 20 > p15.Y then
                v16 = p12 + Vector2.new(0, -(20 + p13.Y));
            else
                v16 = p12 + Vector2.new(0, 20);
            end;
        else
            v16 = p12 + Vector2.new(20);
        end;

        local Vector2_new = Vector2.new;
        local v17 = math.min(v16.X + p13.X, p15.X) - p13.X;
        local math_max_ret = math.max(v17, p14.X);
        local v18 = math.min(v16.Y + p13.Y, p15.Y) - p13.Y;

        return Vector2_new(math_max_ret, (math.max(v18, p14.Y)));
    end;

    function u1.getScreenSizeForWindow(p19) -- Line: 78
        if p19.Instance:IsA("GuiBase2d") then
            return p19.Instance.AbsoluteSize;
        end;

        local Parent = p19.Instance.Parent;

        if Parent:IsA("GuiBase2d") then
            return Parent.AbsoluteSize;
        end;

        if Parent.Parent:IsA("GuiBase2d") then
            return Parent.AbsoluteSize;
        end;

        return workspace.CurrentCamera.ViewportSize;
    end;

    function u1.extend(p20, p21) -- Line: 95
        local table_clone_ret = table.clone(p20);

        for i, v in p21 do
            table_clone_ret[i] = v;
        end;

        return table_clone_ret;
    end;

    function u1.UIPadding(p22: userdata, p23) -- Line: 103
        local UIPadding = Instance.new("UIPadding");
        UIPadding.PaddingLeft = UDim.new(0, p23.X);
        UIPadding.PaddingRight = UDim.new(0, p23.X);
        UIPadding.PaddingTop = UDim.new(0, p23.Y);
        UIPadding.PaddingBottom = UDim.new(0, p23.Y);
        UIPadding.Parent = p22;

        return UIPadding;
    end;

    function u1.UIListLayout(p24: userdata, p25: any, p26) -- Line: 113
        local UIListLayout = Instance.new("UIListLayout");
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
        UIListLayout.Padding = p26;
        UIListLayout.FillDirection = p25;
        UIListLayout.Parent = p24;

        return UIListLayout;
    end;

    function u1.UIStroke(p27: userdata, p28: number, p29, p30: number) -- Line: 122
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Thickness = p28;
        UIStroke.Color = p29;
        UIStroke.Transparency = p30;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
        UIStroke.Parent = p27;

        return UIStroke;
    end;

    function u1.UICorner(p31: userdata, p32: number?) -- Line: 133
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(p32 and 0 or 1, p32 or 0);
        UICorner.Parent = p31;

        return UICorner;
    end;

    function u1.UISizeConstraint(p33: userdata, p34, p35) -- Line: 140
        local UISizeConstraint = Instance.new("UISizeConstraint");
        UISizeConstraint.MinSize = p34 or UISizeConstraint.MinSize;
        UISizeConstraint.MaxSize = p35 or UISizeConstraint.MaxSize;
        UISizeConstraint.Parent = p33;

        return UISizeConstraint;
    end;

    function u1.applyTextStyle(p36) -- Line: 150
        -- upvalues: u2 (copy)
        p36.FontFace = u2._config.TextFont;
        p36.TextSize = u2._config.TextSize;
        p36.TextColor3 = u2._config.TextColor;
        p36.TextTransparency = u2._config.TextTransparency;
        p36.TextXAlignment = Enum.TextXAlignment.Left;
        p36.TextYAlignment = Enum.TextYAlignment.Center;
        p36.RichText = u2._config.RichText;
        p36.TextWrapped = u2._config.TextWrapped;
        p36.AutoLocalize = false;
    end;

    function u1.applyInteractionHighlights(u37: string, p38: userdata, u39: userdata, u40: table) -- Line: 163
        -- upvalues: u1 (ref), u2 (copy)
        local u41 = false;
        u1.applyMouseEnter(p38, function() -- Line: 165
            -- upvalues: u39 (copy), u37 (copy), u40 (copy), u41 (ref)
            u39[u37 .. "Color3"] = u40.HoveredColor;
            u39[u37 .. "Transparency"] = u40.HoveredTransparency;
            u41 = false;
        end);
        u1.applyMouseLeave(p38, function() -- Line: 172
            -- upvalues: u39 (copy), u37 (copy), u40 (copy), u41 (ref)
            u39[u37 .. "Color3"] = u40.Color;
            u39[u37 .. "Transparency"] = u40.Transparency;
            u41 = true;
        end);
        u1.applyInputBegan(p38, function(p42: userdata) -- Line: 179
            -- upvalues: u39 (copy), u37 (copy), u40 (copy)
            if p42.UserInputType ~= Enum.UserInputType.MouseButton1 and p42.UserInputType ~= Enum.UserInputType.Gamepad1 then
                return;
            end;

            u39[u37 .. "Color3"] = u40.ActiveColor;
            u39[u37 .. "Transparency"] = u40.ActiveTransparency;
        end);
        u1.applyInputEnded(p38, function(p43: userdata) -- Line: 187
            -- upvalues: u41 (ref), u39 (copy), u37 (copy), u40 (copy)
            if p43.UserInputType ~= Enum.UserInputType.MouseButton1 and p43.UserInputType ~= Enum.UserInputType.Gamepad1 or u41 then
                return;
            end;

            if p43.UserInputType == Enum.UserInputType.MouseButton1 then
                u39[u37 .. "Color3"] = u40.HoveredColor;
                u39[u37 .. "Transparency"] = u40.HoveredTransparency;
            end;

            if p43.UserInputType == Enum.UserInputType.Gamepad1 then
                u39[u37 .. "Color3"] = u40.Color;
                u39[u37 .. "Transparency"] = u40.Transparency;
            end;
        end);
        p38.SelectionImageObject = u2.SelectionImageObject;
    end;

    function u1.applyInteractionHighlightsWithMultiHighlightee(u44: string, p45: userdata, u46: table) -- Line: 204
        -- upvalues: u1 (ref), u2 (copy)
        local u47 = false;
        u1.applyMouseEnter(p45, function() -- Line: 206
            -- upvalues: u46 (copy), u44 (copy), u47 (ref)
            for _, v in u46 do
                v[1][u44 .. "Color3"] = v[2].HoveredColor;
                v[1][u44 .. "Transparency"] = v[2].HoveredTransparency;
                u47 = false;
            end;
        end);
        u1.applyMouseLeave(p45, function() -- Line: 215
            -- upvalues: u46 (copy), u44 (copy), u47 (ref)
            for _, v in u46 do
                v[1][u44 .. "Color3"] = v[2].Color;
                v[1][u44 .. "Transparency"] = v[2].Transparency;
                u47 = true;
            end;
        end);
        u1.applyInputBegan(p45, function(p48: userdata) -- Line: 224
            -- upvalues: u46 (copy), u44 (copy)
            if p48.UserInputType ~= Enum.UserInputType.MouseButton1 and p48.UserInputType ~= Enum.UserInputType.Gamepad1 then
                return;
            end;

            for _, v in u46 do
                v[1][u44 .. "Color3"] = v[2].ActiveColor;
                v[1][u44 .. "Transparency"] = v[2].ActiveTransparency;
            end;
        end);
        u1.applyInputEnded(p45, function(p49: userdata) -- Line: 234
            -- upvalues: u47 (ref), u46 (copy), u44 (copy)
            if p49.UserInputType ~= Enum.UserInputType.MouseButton1 and p49.UserInputType ~= Enum.UserInputType.Gamepad1 or u47 then
                return;
            end;

            for _, v in u46 do
                if p49.UserInputType == Enum.UserInputType.MouseButton1 then
                    v[1][u44 .. "Color3"] = v[2].HoveredColor;
                    v[1][u44 .. "Transparency"] = v[2].HoveredTransparency;
                end;

                if p49.UserInputType == Enum.UserInputType.Gamepad1 then
                    v[1][u44 .. "Color3"] = v[2].Color;
                    v[1][u44 .. "Transparency"] = v[2].Transparency;
                end;
            end;
        end);
        p45.SelectionImageObject = u2.SelectionImageObject;
    end;

    function u1.applyFrameStyle(p50: userdata, p51: boolean?, p52: boolean?) -- Line: 253
        -- upvalues: u2 (copy), u1 (ref)
        local FrameBorderSize = u2._config.FrameBorderSize;
        local FrameRounding = u2._config.FrameRounding;
        p50.BorderSizePixel = 0;

        if FrameBorderSize > 0 then
            u1.UIStroke(p50, FrameBorderSize, u2._config.BorderColor, u2._config.BorderTransparency);
        end;

        if FrameRounding > 0 and not p52 then
            u1.UICorner(p50, FrameRounding);
        end;

        if not p51 then
            u1.UIPadding(p50, u2._config.FramePadding);
        end;
    end;

    function u1.applyButtonClick(p53: userdata, u54: function) -- Line: 271
        p53.MouseButton1Click:Connect(function() -- Line: 272
            -- upvalues: u54 (copy)
            u54();
        end);
    end;

    function u1.applyButtonDown(p55: userdata, u56: function) -- Line: 277
        -- upvalues: u1 (ref)
        p55.MouseButton1Down:Connect(function(p57: number, p58: number) -- Line: 278
            -- upvalues: u1 (ref), u56 (copy)
            local v59 = Vector2.new(p57, p58) - u1.MouseOffset;
            u56(v59.X, v59.Y);
        end);
    end;

    function u1.applyMouseEnter(p60: userdata, u61: function) -- Line: 284
        -- upvalues: u1 (ref)
        p60.MouseEnter:Connect(function(p62: number, p63: number) -- Line: 285
            -- upvalues: u1 (ref), u61 (copy)
            local v64 = Vector2.new(p62, p63) - u1.MouseOffset;
            u61(v64.X, v64.Y);
        end);
    end;

    function u1.applyMouseMoved(p65: userdata, u66: function) -- Line: 291
        -- upvalues: u1 (ref)
        p65.MouseMoved:Connect(function(p67: number, p68: number) -- Line: 292
            -- upvalues: u1 (ref), u66 (copy)
            local v69 = Vector2.new(p67, p68) - u1.MouseOffset;
            u66(v69.X, v69.Y);
        end);
    end;

    function u1.applyMouseLeave(p70: userdata, u71: function) -- Line: 298
        -- upvalues: u1 (ref)
        p70.MouseLeave:Connect(function(p72: number, p73: number) -- Line: 299
            -- upvalues: u1 (ref), u71 (copy)
            local v74 = Vector2.new(p72, p73) - u1.MouseOffset;
            u71(v74.X, v74.Y);
        end);
    end;

    function u1.applyInputBegan(p75: userdata, u76: function) -- Line: 305
        p75.InputBegan:Connect(function(...) -- Line: 306
            -- upvalues: u76 (copy)
            u76(...);
        end);
    end;

    function u1.applyInputEnded(p77: userdata, u78: function) -- Line: 311
        p77.InputEnded:Connect(function(...) -- Line: 312
            -- upvalues: u78 (copy)
            u78(...);
        end);
    end;

    function u1.discardState(p79) -- Line: 317
        for _, v in p79.state do
            v.ConnectedWidgets[p79.ID] = nil;
        end;
    end;

    function u1.registerEvent(u80: string, u81: function) -- Line: 323
        -- upvalues: u2 (copy), u1 (ref)
        table.insert(u2._initFunctions, function() -- Line: 324
            -- upvalues: u2 (ref), u1 (ref), u80 (copy), u81 (copy)
            table.insert(u2._connections, u1.UserInputService[u80]:Connect(u81));
        end);
    end;

    u1.EVENTS = {
        hover = function(u82: function) -- Line: 330, Name: hover
            -- upvalues: u1 (ref)
            return {
                Init = function(u83) -- Line: 332
                    -- upvalues: u82 (copy), u1 (ref)
                    local v84 = u82(u83);
                    u1.applyMouseEnter(v84, function() -- Line: 334
                        -- upvalues: u83 (copy)
                        u83.isHoveredEvent = true;
                    end);
                    u1.applyMouseLeave(v84, function() -- Line: 337
                        -- upvalues: u83 (copy)
                        u83.isHoveredEvent = false;
                    end);
                    u83.isHoveredEvent = false;
                end,

                Get = function(p85) -- Line: 342
                    return p85.isHoveredEvent;
                end
            };
        end,

        click = function(u86: function) -- Line: 348, Name: click
            -- upvalues: u1 (ref), u2 (copy)
            return {
                Init = function(u87) -- Line: 350
                    -- upvalues: u86 (copy), u1 (ref), u2 (ref)
                    local v88 = u86(u87);
                    u87.lastClickedTick = -1;
                    u1.applyButtonClick(v88, function() -- Line: 354
                        -- upvalues: u87 (copy), u2 (ref)
                        u87.lastClickedTick = u2._cycleTick + 1;
                    end);
                end,

                Get = function(p89) -- Line: 358
                    -- upvalues: u2 (ref)
                    return p89.lastClickedTick == u2._cycleTick;
                end
            };
        end,

        rightClick = function(u90: function) -- Line: 364, Name: rightClick
            -- upvalues: u2 (copy)
            return {
                Init = function(u91) -- Line: 366
                    -- upvalues: u90 (copy), u2 (ref)
                    local v92 = u90(u91);
                    u91.lastRightClickedTick = -1;
                    v92.MouseButton2Click:Connect(function() -- Line: 370
                        -- upvalues: u91 (copy), u2 (ref)
                        u91.lastRightClickedTick = u2._cycleTick + 1;
                    end);
                end,

                Get = function(p93) -- Line: 374
                    -- upvalues: u2 (ref)
                    return p93.lastRightClickedTick == u2._cycleTick;
                end
            };
        end,

        doubleClick = function(u94: function) -- Line: 380, Name: doubleClick
            -- upvalues: u1 (ref), u2 (copy)
            return {
                Init = function(u95) -- Line: 382
                    -- upvalues: u94 (copy), u1 (ref), u2 (ref)
                    local v96 = u94(u95);
                    u95.lastClickedTime = -1;
                    u95.lastClickedPosition = Vector2.zero;
                    u95.lastDoubleClickedTick = -1;
                    u1.applyButtonDown(v96, function(p97: number, p98: number) -- Line: 388
                        -- upvalues: u1 (ref), u95 (copy), u2 (ref)
                        local Time = u1.getTime();

                        if Time - u95.lastClickedTime < u2._config.MouseDoubleClickTime and (Vector2.new(p97, p98) - u95.lastClickedPosition).Magnitude < u2._config.MouseDoubleClickMaxDist then
                            u95.lastDoubleClickedTick = u2._cycleTick + 1;

                            return;
                        end;

                        u95.lastClickedTime = Time;
                        u95.lastClickedPosition = Vector2.new(p97, p98);
                    end);
                end,

                Get = function(p99) -- Line: 399
                    -- upvalues: u2 (ref)
                    return p99.lastDoubleClickedTick == u2._cycleTick;
                end
            };
        end,

        ctrlClick = function(u100: function) -- Line: 405, Name: ctrlClick
            -- upvalues: u1 (ref), u2 (copy)
            return {
                Init = function(u101) -- Line: 407
                    -- upvalues: u100 (copy), u1 (ref), u2 (ref)
                    local v102 = u100(u101);
                    u101.lastCtrlClickedTick = -1;
                    u1.applyButtonClick(v102, function() -- Line: 411
                        -- upvalues: u1 (ref), u101 (copy), u2 (ref)
                        if u1.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or u1.UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
                            u101.lastCtrlClickedTick = u2._cycleTick + 1;
                        end;
                    end);
                end,

                Get = function(p103) -- Line: 417
                    -- upvalues: u2 (ref)
                    return p103.lastCtrlClickedTick == u2._cycleTick;
                end
            };
        end
    };
    u2._utility = u1;
    require(script.Root)(u2, u1);
    require(script.Window)(u2, u1);
    require(script.Menu)(u2, u1);
    require(script.Format)(u2, u1);
    require(script.Text)(u2, u1);
    require(script.Button)(u2, u1);
    require(script.Checkbox)(u2, u1);
    require(script.RadioButton)(u2, u1);
    require(script.Image)(u2, u1);
    require(script.Tree)(u2, u1);
    require(script.Tab)(u2, u1);
    require(script.Input)(u2, u1);
    require(script.Combo)(u2, u1);
    require(script.Plot)(u2, u1);
    require(script.Table)(u2, u1);
end;