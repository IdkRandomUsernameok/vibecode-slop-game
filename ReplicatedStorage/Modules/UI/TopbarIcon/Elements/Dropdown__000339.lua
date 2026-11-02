-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Themes = require(script.Parent.Parent.Features.Themes);

return function(u1) -- Line: 5
    -- upvalues: Themes (copy), TweenService (copy), RunService (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Dropdown";
    Frame.AutomaticSize = Enum.AutomaticSize.X;
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.AnchorPoint = Vector2.new(0.5, 0);
    Frame.Position = UDim2.new(0.5, 0, 1, 10);
    Frame.ZIndex = -2;
    Frame.ClipsDescendants = true;
    Frame.Parent = u1.widget;
    local GuiService = game:GetService("GuiService");
    u1:setBehaviour("Dropdown", "BackgroundTransparency", function(p2) -- Line: 20
        -- upvalues: GuiService (copy)
        if p2 == 1 then
            return p2;
        end;

        return p2 * GuiService.PreferredTransparency;
    end);
    u1.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- Line: 28
        -- upvalues: u1 (copy), Frame (copy)
        u1:refreshAppearance(Frame, "BackgroundTransparency");
    end));
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "DropdownCorner";
    UICorner.CornerRadius = UDim.new(0, 10);
    UICorner.Parent = Frame;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "DropdownScroller";
    ScrollingFrame.AutomaticSize = Enum.AutomaticSize.X;
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.AnchorPoint = Vector2.new(0, 0);
    ScrollingFrame.Position = UDim2.new(0, 0, 0, 0);
    ScrollingFrame.ZIndex = -1;
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.Visible = true;
    ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.None;
    ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;
    ScrollingFrame.Active = false;
    ScrollingFrame.ScrollingEnabled = true;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollBarThickness = 5;
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255);
    ScrollingFrame.ScrollBarImageTransparency = 0.8;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0);
    ScrollingFrame.Selectable = false;
    ScrollingFrame.Active = true;
    ScrollingFrame.Parent = Frame;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Name = "DropdownSpeed";
    NumberValue.Value = 0.07;
    NumberValue.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.Name = "DropdownPadding";
    UIPadding.PaddingTop = UDim.new(0, 0);
    UIPadding.PaddingBottom = UDim.new(0, 0);
    UIPadding.Parent = ScrollingFrame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "DropdownList";
    UIListLayout.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly;
    UIListLayout.Parent = ScrollingFrame;
    local dropdownJanitor = u1.dropdownJanitor;
    local iconModule = require(u1.iconModule);
    u1.dropdownChildAdded:Connect(function(u3) -- Line: 81
        local _, u4 = u3:modifyTheme({
            { "Widget", "BorderSize", 0 },
            { "IconCorners", "CornerRadius", UDim.new(0, 10) },
            { "Widget", "MinimumWidth", 190 },
            { "Widget", "MinimumHeight", 58 },
            { "IconLabel", "TextSize", 20 },
            { "IconOverlay", "Size", UDim2.fromScale(1, 1) },
            { "PaddingLeft", "Size", UDim2.fromOffset(25, 0) },
            { "Notice", "Position", UDim2.new(1, -24, 0, 5) },
            { "ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left },
            { "Selection", "Size", UDim2.new(1, -0, 1, -0) },
            { "Selection", "Position", UDim2.fromOffset(0, 0) }
        });
        task.defer(function() -- Line: 95
            -- upvalues: u3 (copy), u4 (copy)
            u3.joinJanitor:add(function() -- Line: 96
                -- upvalues: u3 (ref), u4 (ref)
                u3:removeModification(u4);
            end);
        end);
    end);
    u1.dropdownSet:Connect(function(p5) -- Line: 101
        -- upvalues: u1 (copy), iconModule (copy)
        for _, v in pairs(u1.dropdownIcons) do
            iconModule.getIconByUID(v):destroy();
        end;

        if type(p5) == "table" then
            for _, v in pairs(p5) do
                v:joinDropdown(u1);
            end;
        end;
    end);

    local function updateMaxIcons() -- Line: 113
        -- upvalues: Frame (copy), u1 (copy), ScrollingFrame (copy), UIPadding (copy)
        local Attribute = Frame:GetAttribute("MaxIcons");
        local v6 = u1.isGroupHandler and (1 / 0) or Attribute;

        if not v6 then
            return 0;
        end;

        local v7 = {};

        for _, child in pairs(ScrollingFrame:GetChildren()) do
            if child:IsA("GuiObject") and child.Visible then
                table.insert(v7, child);
            end;
        end;

        table.sort(v7, function(p8, p9) -- Line: 127
            return p8.AbsolutePosition.Y < p9.AbsolutePosition.Y;
        end);
        local math_ceil_ret = math.ceil(v6);
        local v10 = 0;

        for i = 1, math_ceil_ret do
            local v11 = v7[i];

            if not v11 then
                break;
            end;

            local Y = v11.AbsoluteSize.Y;
            local v12;

            if i == math_ceil_ret then
                v12 = math_ceil_ret ~= v6;
            else
                v12 = false;
            end;

            if v12 then
                Y = Y * (v6 - math_ceil_ret + 1);
            end;

            v10 = v10 + Y;
            local _ = i;
        end;

        return v10 + (UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset);
    end;

    local u13 = nil;
    local u14 = nil;
    local u15 = nil;
    local u16 = nil;

    local function getTweenInfo() -- Line: 150
        -- upvalues: Themes (ref), Frame (copy), u15 (ref), u16 (ref), NumberValue (copy)
        local v17 = Themes.getInstanceValue(Frame, "MaxIcons") or 1;

        if u15 and (u15 == v17 and u16) then
            return u16;
        end;

        local TweenInfo_new_ret = TweenInfo.new(NumberValue.Value * v17, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        u16 = TweenInfo_new_ret;
        u15 = v17;

        return TweenInfo_new_ret;
    end;

    local function updateVisibility() -- Line: 164
        -- upvalues: Themes (ref), Frame (copy), u15 (ref), u16 (ref), NumberValue (copy), u13 (ref), u14 (ref), u1 (copy), updateMaxIcons (copy), TweenService (ref)
        local v18 = Themes.getInstanceValue(Frame, "MaxIcons") or 1;
        local v19;

        if u15 and (u15 == v18 and u16) then
            v19 = u16;
        else
            v19 = TweenInfo.new(NumberValue.Value * v18, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
            u16 = v19;
            u15 = v18;
        end;

        if u13 then
            u13:Cancel();
            u13 = nil;
        end;

        if u14 then
            u14:Cancel();
            u14 = nil;
        end;

        if not u1.isSelected then
            u14 = TweenService:Create(Frame, TweenInfo.new(0), {
                Size = UDim2.fromOffset(Frame.Size.X.Offset, 0)
            });
            u14:Play();
            u14.Completed:Connect(function() -- Line: 192
                -- upvalues: u14 (ref)
                u14 = nil;
            end);

            return;
        end;

        local v20 = updateMaxIcons();
        Frame.Visible = true;
        Frame.BackgroundTransparency = 0;
        Frame.Size = UDim2.fromOffset(Frame.Size.X.Offset, 0);
        u13 = TweenService:Create(Frame, v19, {
            Size = UDim2.fromOffset(Frame.Size.X.Offset, v20)
        });
        u13:Play();
        u13.Completed:Connect(function() -- Line: 185
            -- upvalues: u13 (ref)
            u13 = nil;
        end);
    end;

    dropdownJanitor:add(u1.toggled:Connect(updateVisibility));
    updateVisibility();

    local function updateChildSize() -- Line: 202
        -- upvalues: Themes (ref), Frame (copy), u15 (ref), u16 (ref), NumberValue (copy), u1 (copy), u13 (ref), u14 (ref), RunService (ref), updateMaxIcons (copy), TweenService (ref)
        local v21 = Themes.getInstanceValue(Frame, "MaxIcons") or 1;
        local v22;

        if u15 and (u15 == v21 and u16) then
            v22 = u16;
        else
            v22 = TweenInfo.new(NumberValue.Value * v21, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
            u16 = v22;
            u15 = v21;
        end;

        if not u1.isSelected then
            return;
        end;

        if u13 then
            u13:Cancel();
            u13 = nil;
        end;

        if u14 then
            u14:Cancel();
            u14 = nil;
        end;

        RunService.Heartbeat:Wait();
        local v23 = updateMaxIcons();
        u13 = TweenService:Create(Frame, v22, {
            Size = UDim2.fromOffset(Frame.Size.X.Offset, v23)
        });
        u13:Play();
        u13.Completed:Connect(function() -- Line: 220
            -- upvalues: u13 (ref)
            u13 = nil;
        end);
    end;

    dropdownJanitor:add(u1.toggled:Connect(updateVisibility));
    local u24 = 0;
    local u25 = false;

    local function updateMaxIconsListener() -- Line: 233
        -- upvalues: u24 (ref), u25 (ref), updateMaxIconsListener (copy), Frame (copy), ScrollingFrame (copy), iconModule (copy), u1 (copy), UIPadding (copy)
        u24 = u24 + 1;

        if u25 then
            return;
        end;

        local u26 = u24;
        u25 = true;
        task.defer(function() -- Line: 238
            -- upvalues: u25 (ref), u24 (ref), u26 (copy), updateMaxIconsListener (ref)
            u25 = false;

            if u24 ~= u26 then
                updateMaxIconsListener();
            end;
        end);
        local Attribute = Frame:GetAttribute("MaxIcons");

        if not Attribute then
            return;
        end;

        local v27 = {};

        for _, child in pairs(ScrollingFrame:GetChildren()) do
            if child:IsA("GuiObject") and child.Visible then
                table.insert(v27, { child, child.AbsolutePosition.Y });
            end;
        end;

        table.sort(v27, function(p28, p29) -- Line: 253
            return p28[2] < p29[2];
        end);
        local math_ceil_ret = math.ceil(Attribute);
        local v30 = 0;
        local v31 = false;

        for i = 1, math_ceil_ret do
            local v32 = v27[i];

            if not v32 then
                break;
            end;

            local v33 = v32[1];
            local Y = v33.AbsoluteSize.Y;
            local v34;

            if i == math_ceil_ret then
                v34 = math_ceil_ret ~= Attribute;
            else
                v34 = false;
            end;

            if v34 then
                Y = Y * (Attribute - math_ceil_ret + 1);
            end;

            v30 = v30 + Y;
            local v35;

            if v34 then
                v35 = i;
            else
                local Attribute2 = v33:GetAttribute("WidgetUID");

                if Attribute2 then
                    Attribute2 = iconModule.getIconByUID(Attribute2);
                end;

                if Attribute2 then
                    local v36;

                    if v31 then
                        v36 = nil;
                    else
                        v36 = u1:getInstance("ClickRegion");
                        v31 = true;
                    end;

                    Attribute2:getInstance("ClickRegion").NextSelectionUp = v36;
                    v35 = i;
                else
                    v35 = i;
                end;
            end;
        end;

        ScrollingFrame.Size = UDim2.fromOffset(0, v30 + (UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset));
    end;

    dropdownJanitor:add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateMaxIconsListener));
    dropdownJanitor:add(ScrollingFrame.ChildAdded:Connect(updateMaxIconsListener));
    dropdownJanitor:add(ScrollingFrame.ChildRemoved:Connect(updateChildSize));
    dropdownJanitor:add(ScrollingFrame.ChildRemoved:Connect(updateMaxIconsListener));
    dropdownJanitor:add(Frame:GetAttributeChangedSignal("MaxIcons"):Connect(updateMaxIconsListener));
    dropdownJanitor:add(Frame:GetAttributeChangedSignal("MaxIcons"):Connect(updateChildSize));
    dropdownJanitor:add(u1.childThemeModified:Connect(updateMaxIconsListener));
    updateMaxIconsListener();

    local function connectVisibilityListeners(p37) -- Line: 300
        -- upvalues: updateChildSize (copy)
        if p37:IsA("GuiObject") then
            p37:GetPropertyChangedSignal("Visible"):Connect(updateChildSize);
            p37:GetPropertyChangedSignal("Size"):Connect(updateChildSize);
        end;
    end;

    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            child:GetPropertyChangedSignal("Visible"):Connect(updateChildSize);
            child:GetPropertyChangedSignal("Size"):Connect(updateChildSize);
        end;
    end;

    ScrollingFrame.ChildAdded:Connect(function(p38) -- Line: 312
        -- upvalues: RunService (ref), updateChildSize (copy)
        RunService.Heartbeat:Wait();

        if p38:IsA("GuiObject") then
            p38:GetPropertyChangedSignal("Visible"):Connect(updateChildSize);
            p38:GetPropertyChangedSignal("Size"):Connect(updateChildSize);
        end;

        updateChildSize();
    end);
    Frame.Visible = false;

    return Frame;
end;