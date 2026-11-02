-- Decompiled with Potassium's decompiler.

local Color3_fromRGB_ret = Color3.fromRGB(39, 41, 48);
local Color3_fromRGB_ret2 = Color3.fromRGB(247, 247, 248);

return function(u1) -- Line: 4
    -- upvalues: Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
    local iconModule = require(u1.iconModule);
    local v2 = iconModule.playtestMode and Color3_fromRGB_ret2 or Color3_fromRGB_ret;
    local v3 = iconModule.playtestMode and Color3_fromRGB_ret or Color3_fromRGB_ret2;
    local Instance2 = u1:getInstance("ClickRegion");
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "Caption";
    CanvasGroup.AnchorPoint = Vector2.new(0.5, 0);
    CanvasGroup.BackgroundTransparency = 1;
    CanvasGroup.BorderSizePixel = 0;
    CanvasGroup.GroupTransparency = 1;
    CanvasGroup.Position = UDim2.fromOffset(0, 0);
    CanvasGroup.Visible = true;
    CanvasGroup.ZIndex = 30;
    CanvasGroup.Parent = Instance2;
    local Frame = Instance.new("Frame");
    Frame.Name = "Box";
    Frame.AutomaticSize = Enum.AutomaticSize.XY;
    Frame.BackgroundColor3 = v2;
    Frame.Position = UDim2.fromOffset(4, 7);
    Frame.ZIndex = 12;
    Frame.Parent = CanvasGroup;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Header";
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    TextLabel.Text = "Caption";
    TextLabel.TextColor3 = v3;
    TextLabel.TextSize = 15;
    TextLabel.TextTruncate = Enum.TextTruncate.None;
    TextLabel.TextWrapped = false;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.AutomaticSize = Enum.AutomaticSize.X;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.LayoutOrder = 1;
    TextLabel.Size = UDim2.fromOffset(0, 16);
    TextLabel.ZIndex = 18;
    TextLabel.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "Layout";
    UIListLayout.Padding = UDim.new(0, 8);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "CaptionCorner";
    UICorner.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.Name = "Padding";
    UIPadding.PaddingBottom = UDim.new(0, 12);
    UIPadding.PaddingLeft = UDim.new(0, 12);
    UIPadding.PaddingRight = UDim.new(0, 12);
    UIPadding.PaddingTop = UDim.new(0, 12);
    UIPadding.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Hotkeys";
    Frame2.AutomaticSize = Enum.AutomaticSize.Y;
    Frame2.BackgroundTransparency = 1;
    Frame2.LayoutOrder = 3;
    Frame2.Size = UDim2.fromScale(1, 0);
    Frame2.Visible = false;
    Frame2.Parent = Frame;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.Name = "Layout1";
    UIListLayout2.Padding = UDim.new(0, 6);
    UIListLayout2.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout2.HorizontalFlex = Enum.UIFlexAlignment.None;
    UIListLayout2.ItemLineAlignment = Enum.ItemLineAlignment.Automatic;
    UIListLayout2.VerticalFlex = Enum.UIFlexAlignment.None;
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout2.Parent = Frame2;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Key1";
    ImageLabel.Image = "rbxasset://textures/ui/Controls/key_single.png";
    ImageLabel.ImageColor3 = v3;
    ImageLabel.ImageTransparency = iconModule.playtestMode and 0.3 or 0.7;
    ImageLabel.ScaleType = Enum.ScaleType.Slice;
    ImageLabel.SliceCenter = Rect.new(5, 5, 23, 24);
    ImageLabel.AutomaticSize = Enum.AutomaticSize.X;
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.LayoutOrder = 1;
    ImageLabel.Size = UDim2.fromOffset(0, 30);
    ImageLabel.ZIndex = 15;
    ImageLabel.Parent = Frame2;
    local UIPadding2 = Instance.new("UIPadding");
    UIPadding2.Name = "Inset";
    UIPadding2.PaddingLeft = UDim.new(0, 8);
    UIPadding2.PaddingRight = UDim.new(0, 8);
    UIPadding2.Parent = ImageLabel;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.AutoLocalize = false;
    TextLabel2.Name = "LabelContent";
    TextLabel2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    TextLabel2.Text = "";
    TextLabel2.TextColor3 = v3;
    TextLabel2.TextTransparency = iconModule.playtestMode and 0.3 or 0.5;
    TextLabel2.TextSize = 15;
    TextLabel2.AutomaticSize = Enum.AutomaticSize.X;
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Position = UDim2.fromOffset(0, -1);
    TextLabel2.Size = UDim2.fromScale(1, 1);
    TextLabel2.ZIndex = 16;
    TextLabel2.Parent = ImageLabel;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Caret";
    ImageLabel2.Image = "rbxassetid://101906294438076";
    ImageLabel2.ImageColor3 = v2;
    ImageLabel2.AnchorPoint = Vector2.new(0, 0.5);
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Position = UDim2.fromOffset(0, 4);
    ImageLabel2.Size = UDim2.fromOffset(16, 8);
    ImageLabel2.ZIndex = 12;
    ImageLabel2.Parent = CanvasGroup;
    local ImageLabel3 = Instance.new("ImageLabel");
    ImageLabel3.Visible = true;
    ImageLabel3.Name = "DropShadow";
    ImageLabel3.Image = "rbxassetid://124920646932671";
    ImageLabel3.ImageColor3 = Color3.fromRGB(0, 0, 0);
    ImageLabel3.ImageTransparency = 0.45;
    ImageLabel3.ScaleType = Enum.ScaleType.Slice;
    ImageLabel3.SliceCenter = Rect.new(12, 12, 13, 13);
    ImageLabel3.BackgroundTransparency = 1;
    ImageLabel3.Position = UDim2.fromOffset(0, 5);
    ImageLabel3.Size = UDim2.new(1, 0, 0, 48);
    ImageLabel3.Parent = CanvasGroup;
    Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 152
        -- upvalues: ImageLabel3 (copy), Frame (copy)
        ImageLabel3.Size = UDim2.new(1, 0, 0, Frame.AbsoluteSize.Y + 8);
    end);
    local captionJanitor = u1.captionJanitor;
    local _, u4 = u1:clipOutside(CanvasGroup);
    u4.AutomaticSize = Enum.AutomaticSize.None;
    captionJanitor:add(CanvasGroup:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 162, Name: matchSize
        -- upvalues: CanvasGroup (copy), u4 (copy)
        local AbsoluteSize = CanvasGroup.AbsoluteSize;
        u4.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
    end));
    local AbsoluteSize = CanvasGroup.AbsoluteSize;
    u4.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
    local u5 = false;
    local Header = CanvasGroup.Box.Header;
    local UserInputService = game:GetService("UserInputService");

    local function updateHotkey(p6) -- Line: 175
        -- upvalues: UserInputService (copy), CanvasGroup (copy), u1 (copy), Header (copy), TextLabel2 (copy), Frame2 (copy)
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v7 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v8 = v7 == "_hotkey_";

        if not KeyboardEnabled and v8 then
            u1:setCaption();

            return;
        end;

        Header.Text = v7;
        Header.Visible = not v8;

        if p6 then
            TextLabel2.Text = UserInputService:GetStringForKeyCode(p6);
            Frame2.Visible = true;
        end;

        if not KeyboardEnabled then
            Frame2.Visible = false;
        end;
    end;

    CanvasGroup:GetAttributeChangedSignal("CaptionText"):Connect(updateHotkey);
    local Quad = Enum.EasingStyle.Quad;
    local TweenInfo_new_ret = TweenInfo.new(0.2, Quad, Enum.EasingDirection.In);
    local TweenInfo_new_ret2 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.Out);
    local TweenService = game:GetService("TweenService");
    local RunService = game:GetService("RunService");

    local function getCaptionPosition(p9) -- Line: 201
        -- upvalues: u5 (ref)
        if p9 == nil then
            p9 = u5;
        end;

        return UDim2.new(0.5, 0, 1, p9 and 10 or 2);
    end;

    local function updatePosition(p10) -- Line: 208
        -- upvalues: u5 (ref), ImageLabel2 (copy), CanvasGroup (copy), Instance2 (copy), u4 (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy), TweenService (copy), RunService (copy)
        if not u5 then
            return;
        end;

        if p10 == nil then
            p10 = u5;
        end;

        local v11 = not p10;

        if v11 == nil then
            v11 = u5;
        end;

        local UDim2_new_ret = UDim2.new(0.5, 0, 1, v11 and 10 or 2);
        local v12;

        if p10 == nil then
            v12 = u5;
        else
            v12 = p10;
        end;

        local UDim2_new_ret2 = UDim2.new(0.5, 0, 1, v12 and 10 or 2);

        if p10 then
            ImageLabel2.Position = UDim2.fromOffset(0, ImageLabel2.Position.Y.Offset);
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.XY;
            CanvasGroup.Size = UDim2.fromOffset(32, 53);
        else
            local AbsoluteSize2 = CanvasGroup.AbsoluteSize;
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.Y;
            CanvasGroup.Size = UDim2.fromOffset(AbsoluteSize2.X, AbsoluteSize2.Y);
        end;

        local u13 = nil;

        local function updateCaret() -- Line: 237
            -- upvalues: Instance2 (ref), CanvasGroup (ref), ImageLabel2 (ref), u13 (ref)
            local v14 = Instance2.AbsolutePosition.X - CanvasGroup.AbsolutePosition.X + Instance2.AbsoluteSize.X / 2 - ImageLabel2.AbsoluteSize.X / 2;
            local Offset = ImageLabel2.Position.Y.Offset;
            local UDim2_fromOffset_ret = UDim2.fromOffset(v14, Offset);

            if u13 ~= v14 then
                u13 = v14;
                ImageLabel2.Position = UDim2.fromOffset(0, Offset);
                task.wait();
            end;

            ImageLabel2.Position = UDim2_fromOffset_ret;
        end;

        u4.Position = UDim2_new_ret;
        updateCaret();
        local v15 = TweenService:Create(u4, p10 and TweenInfo_new_ret or TweenInfo_new_ret2, {
            Position = UDim2_new_ret2
        });
        local u16 = RunService.Heartbeat:Connect(updateCaret);
        v15:Play();
        v15.Completed:Once(function() -- Line: 260
            -- upvalues: u16 (copy)
            u16:Disconnect();
        end);
    end;

    captionJanitor:add(Instance2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 265
        -- upvalues: updatePosition (copy)
        updatePosition();
    end));
    updatePosition(false);
    captionJanitor:add(u1.toggleKeyAdded:Connect(updateHotkey));

    for i, _ in pairs(u1.bindedToggleKeys) do
        updateHotkey(i);
        break;
    end;

    captionJanitor:add(u1.fakeToggleKeyChanged:Connect(updateHotkey));
    local fakeToggleKey = u1.fakeToggleKey;

    if fakeToggleKey then
        updateHotkey(fakeToggleKey);
    end;

    local function setCaptionEnabled(p17) -- Line: 281
        -- upvalues: u5 (ref), u1 (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy), TweenService (copy), CanvasGroup (copy), u4 (copy), updatePosition (copy), updateHotkey (copy)
        if u5 == p17 then
            return;
        end;

        local joinedFrame = u1.joinedFrame;

        if joinedFrame and string.match(joinedFrame.Name, "Dropdown") then
            p17 = false;
        end;

        u5 = p17;
        TweenService:Create(CanvasGroup, p17 and TweenInfo_new_ret or TweenInfo_new_ret2, {
            GroupTransparency = p17 and 0 or 1
        }):Play();

        if p17 then
            u4:SetAttribute("ForceUpdate", true);
        end;

        updatePosition();
        updateHotkey();
    end;

    local iconModule2 = require(u1.iconModule);
    captionJanitor:add(u1.stateChanged:Connect(function(p18) -- Line: 306
        -- upvalues: u1 (copy), iconModule2 (copy), setCaptionEnabled (copy)
        u1:updateParent("stateChanged");

        if p18 ~= "Viewing" then
            iconModule2.captionLastClosedClock = os.clock();
            setCaptionEnabled(false);

            return;
        end;

        local captionLastClosedClock = iconModule2.captionLastClosedClock;
        local v19 = (captionLastClosedClock and os.clock() - captionLastClosedClock or 999) < 0.3 and 0 or 0.5;
        task.delay(v19, function() -- Line: 312
            -- upvalues: u1 (ref), setCaptionEnabled (ref)
            if u1.activeState == "Viewing" then
                setCaptionEnabled(true);
            end;
        end);
    end));

    return CanvasGroup;
end;