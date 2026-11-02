-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Events = ReplicatedStorage:WaitForChild("Events");
local ColorPicker = require(Modules.UI.ColorPicker);
local DataManager = require(Modules.Data.DataManager);
local Signal = require(Modules.Lib.Signal);
local IconEditor = require(Modules.Main.Translator).new("IconEditor", { "General", "IconEditor" });
local GetImageID = Events.GetImageID;
local GetImageSize = Events.Utils.GetImageSize;
local u2 = { { "Idle" }, { "Idle", "Losing" }, { "Idle", "Losing", "Winning" }, { "Idle", "Losing", "Winning", "Overwinning" }, { "Idle", "Losing", "Winning", "Overwinning", "Overlosing" } };
local u3 = {
    Selected = {
        Thickness = 2,
        Transparency = 0,
        Color = Color3.new(0, 1, 0)
    },
    Idle = {
        Thickness = 2,
        Transparency = 0.85,
        Color = Color3.new(0, 0, 0)
    }
};

function round(p4, p5)
    local v6 = 10 ^ (p5 or 0);

    return math.floor(p4 * v6 + 0.5) / v6;
end;

function newNumBox(u7: userdata, p8: any, p9: any, p10: any, u11: any)
    if u7 then
        local u12 = p10 or 0;
        local u13 = p8 or 0;
        local u14 = p9 or 1;
        local u20 = {
            value = nil,

            set = function(p15, p16, p17) -- Line: 78, Name: set
                -- upvalues: u12 (ref), u13 (ref), u14 (ref), u7 (copy), u11 (copy)
                local v18 = tonumber(p16);

                if not v18 then
                    return;
                end;

                local v19 = round(v18, u12);
                local math_clamp_ret = math.clamp(v19, u13, u14);
                local value = p15.value;
                p15.value = math_clamp_ret;
                u7.Text = tostring(p15.value);

                if u11 and (not p17 and math_clamp_ret ~= value) then
                    u11(math_clamp_ret);
                end;
            end
        };
        u7.FocusLost:Connect(function() -- Line: 91
            -- upvalues: u7 (copy), u20 (copy)
            local v21 = u7.Text:gsub("[^%d%.%-]", "");
            local v22 = tonumber(v21);

            if v22 then
                u20:set(v22);

                return;
            end;

            u7.Text = tostring(u20.value);
        end);

        return u20;
    end;
end;

function newBox(u23: userdata, u24: any)
    if u23 then
        local u28 = {
            value = nil,

            set = function(p25, p26, p27) -- Line: 110, Name: set
                -- upvalues: u23 (copy), u24 (copy)
                if not p26 or p26:gsub(" ", "") == "" then
                    u23.Text = tostring(p25.value);

                    return;
                end;

                local value = p25.value;
                p25.value = p26;
                u23.Text = tostring(p25.value);

                if u24 and (not p27 and p26 ~= value) then
                    u24(p26);
                end;
            end
        };
        u23.FocusLost:Connect(function() -- Line: 122
            -- upvalues: u28 (copy), u23 (copy)
            u28:set(u23.Text);
        end);

        return u28;
    end;
end;

function newCheckBox(u29: userdata, u30: any)
    if u29 then
        local u34 = {
            value = nil,

            set = function(p31, p32, p33) -- Line: 136, Name: set
                -- upvalues: u29 (copy), u30 (copy)
                local value = p31.value;
                p31.value = p32;
                u29.OptionEnabled.Visible = p32 and true or false;

                if u30 and (not p33 and p32 ~= value) then
                    u30(p32);
                end;
            end
        };
        u29.MouseButton1Click:Connect(function() -- Line: 147
            -- upvalues: u34 (copy)
            u34:set(not u34.value);
        end);

        return u34;
    end;
end;

function makeSaveWarnHandler(p35)
    -- upvalues: TweenService (copy)
    local u42 = {
        visible = false,
        ui = p35,
        signals = {},
        cases = {},

        load = function(p36, p37, p38, p39) -- Line: 162, Name: load
            if p36.cases.cancel then
                p36.cases.cancel();
            end;

            p36.cases = p37 or {};
        end,

        show = function(p40) -- Line: 170, Name: show
            -- upvalues: TweenService (ref)
            TweenService:Create(p40.ui, TweenInfo.new(0.25), {
                BackgroundTransparency = 0.2
            }):Play();
            p40.ui.BGSinking.Visible = true;
            p40.ui.Content.Visible = true;
            p40.visible = true;
        end,

        hide = function(p41) -- Line: 178, Name: hide
            -- upvalues: TweenService (ref)
            TweenService:Create(p41.ui, TweenInfo.new(0.25), {
                BackgroundTransparency = 1
            }):Play();
            p41.ui.BGSinking.Visible = false;
            p41.ui.Content.Visible = false;
            p41.visible = false;
        end
    };
    p35.Content.ToolbarButNotToolbar.Save.MouseButton1Click:Connect(function() -- Line: 186
        -- upvalues: u42 (copy)
        if not u42.visible then
            return;
        end;

        u42:hide();

        if u42.cases.save then
            u42.cases.save();
        end;
    end);
    p35.Content.ToolbarButNotToolbar.DontSave.MouseButton1Click:Connect(function() -- Line: 195
        -- upvalues: u42 (copy)
        if not u42.visible then
            return;
        end;

        u42:hide();

        if u42.cases.noSave then
            u42.cases.noSave();
        end;
    end);
    p35.Content.ToolbarButNotToolbar.Cancel.MouseButton1Click:Connect(function() -- Line: 204
        -- upvalues: u42 (copy)
        if not u42.visible then
            return;
        end;

        u42:hide();

        if u42.cases.cancel then
            u42.cases.cancel();
        end;
    end);

    return u42;
end;

function u1.new(u43) -- Line: 216
    -- upvalues: Signal (copy), ColorPicker (copy), u1 (copy), IconEditor (copy), DataManager (copy), u2 (copy)
    local v44 = {
        imageId = -1,
        transparency = 0,
        iconCount = -1,
        scale = 1,
        facing = "R",
        antialiasing = true,
        automaticallyFlip = true,
        iconName = "Step On Up",
        showRectBounds = true,
        previewSide = "L",
        previewScale = 1,
        curFrame = 1,
        _imgWidth = -1,
        _imgHeight = -1,
        ui = u43,
        onSaveIcon = Signal.new(),
        onUndoChanges = Signal.new(),
        onCancel = Signal.new(),
        onLoadIcon = Signal.new(),
        color = Color3.new(1, 1, 1),
        size = Vector2.new(150, 150),
        offset = Vector2.zero,
        displayIcon = u43.Health.IconDisplay.Sprite,
        colorPicker = ColorPicker.new(u43.ColorPicker),
        saveWarn = makeSaveWarnHandler(u43.NoSavingWarn),
        boxes = {}
    };
    local u45 = setmetatable(v44, u1);
    u43.RootLocalizationTable = IconEditor.localizationTable;
    local OptionsList = u43.OptionsList;
    local v47 = newNumBox(OptionsList.ImageID.BoxContent, 0, 9000000000000000, 0, function(p46) -- Line: 258
        -- upvalues: u45 (copy)
        u45:loadImage(p46);
    end);
    u45.boxes.imageId = v47;
    v47:set(0);
    local v49 = newNumBox(OptionsList.IconTrans.BoxContent, 0, 1, 3, function(p48) -- Line: 264
        -- upvalues: u45 (copy)
        u45:setTrans(p48);
    end);
    u45.boxes.transparency = v49;
    v49:set(0);
    local v51 = newNumBox(OptionsList.IconScale.BoxContent, 0.25, 2, 3, function(p50) -- Line: 270
        -- upvalues: u45 (copy)
        u45:setScale(p50);
    end);
    u45.boxes.scale = v51;
    v51:set(1);
    local v53 = newNumBox(OptionsList.IconCount.BoxContent, 1, 5, 0, function(p52) -- Line: 276
        -- upvalues: u45 (copy)
        u45:setIconCount(p52);
    end);
    u45.boxes.iconCount = v53;
    v53:set(2);
    local v55 = newNumBox(OptionsList.IconBaseSize.IndvList.XOffset.BoxContent, 0, 1024, 0, function(p54) -- Line: 282
        -- upvalues: u45 (copy)
        u45:setSize(Vector2.new(p54, u45.size.Y));
    end);
    u45.boxes.iconSizeX = v55;
    v55:set(150);
    local v57 = newNumBox(OptionsList.IconBaseSize.IndvList.YOffset.BoxContent, 0, 1024, 0, function(p56) -- Line: 288
        -- upvalues: u45 (copy)
        u45:setSize(Vector2.new(u45.size.X, p56));
    end);
    u45.boxes.iconSizeY = v57;
    v57:set(150);
    local v59 = newNumBox(OptionsList.IconOffset.IndvList.XOffset.BoxContent, -1.5, 1.5, 3, function(p58) -- Line: 294
        -- upvalues: u45 (copy)
        u45:setOffset(Vector2.new(p58, u45.offset.Y));
    end);
    u45.boxes.iconOffsetX = v59;
    v59:set(150);
    local v61 = newNumBox(OptionsList.IconOffset.IndvList.YOffset.BoxContent, -1.5, 1.5, 3, function(p60) -- Line: 300
        -- upvalues: u45 (copy)
        u45:setOffset(Vector2.new(u45.offset.X, p60));
    end);
    u45.boxes.iconOffsetY = v61;
    v61:set(150);
    local v63 = newCheckBox(OptionsList.Antialiasing.Checkbox, function(p62) -- Line: 306
        -- upvalues: u45 (copy)
        u45:setAntialiasing(p62);
    end);
    u45.boxes.antialiasing = v63;
    v63:set(true);
    local v65 = newCheckBox(OptionsList.IconAutoFlip.Checkbox, function(p64) -- Line: 312
        -- upvalues: u45 (copy)
        u45:setAutoFlip(p64);
    end);
    u45.boxes.autoFlip = v65;
    v65:set(true);
    u43.Health.IconDisplay.MouseButton1Click:Connect(function() -- Line: 318
        -- upvalues: u45 (copy)
        u45.previewScale = math.clamp(u45.previewScale + 0.15, 1, 1.15);
    end);
    newCheckBox(u43.Sidebar.RectBoundsCheckbox.Checkbox, function(p66) -- Line: 322
        -- upvalues: u45 (copy)
        u45:setDisplayBounds(p66);
    end):set(true);
    local u67 = nil;
    u67 = newBox(u43.Sidebar.BoxContent, function(p68) -- Line: 327
        -- upvalues: u43 (copy), DataManager (ref), u67 (ref), u45 (copy)
        u43.Sidebar.BoxContent.TextEditable = false;
        u43.Sidebar.BoxContent:ReleaseFocus();
        u43.Sidebar.BoxContent.FilterInProgress.Visible = true;
        u67:set(DataManager:filterString(p68) or u45.iconName, true);
        u45.iconName = u67.value;
        u43.Sidebar.BoxContent.FilterInProgress.Visible = false;
        u43.Sidebar.BoxContent.TextEditable = true;
    end);
    u45.boxes.iconName = u67;
    u67:set(u45.iconName, true);
    u43.ToolbarButNotToolbar.Save.MouseButton1Click:Connect(function() -- Line: 342
        -- upvalues: u45 (copy)
        local v69 = u45:saveIcon();
        u45.onSaveIcon:Fire(v69, true);
        u45.curIcon = v69;
    end);
    u43.ToolbarButNotToolbar.Cancel.MouseButton1Click:Connect(function() -- Line: 347
        -- upvalues: u45 (copy)
        if not u45:hasUnsavedChanges() then
            u45.onCancel:Fire();

            return;
        end;

        u45.saveWarn:load({
            cancel = function() -- Line: 352, Name: cancel
            end,

            noSave = function() -- Line: 354, Name: noSave
                -- upvalues: u45 (ref)
                u45.onCancel:Fire();
                u45.curIcon = u45:saveIcon();
            end,

            save = function() -- Line: 358, Name: save
                -- upvalues: u45 (ref)
                local v70 = u45:saveIcon();
                u45.onSaveIcon:Fire(v70, true);
                u45.curIcon = v70;
            end
        });
        u45.saveWarn:show();
    end);
    u43.ToolbarButNotToolbar.UndoChanges.MouseButton1Click:Connect(function() -- Line: 370
        -- upvalues: u45 (copy)
        if u45.curIcon then
            u45:loadIcon(u45.curIcon);
        end;

        u45.onUndoChanges:Fire();
    end);
    u45.colorPicker.onColorChanged:Connect(function(p71) -- Line: 377
        -- upvalues: u45 (copy)
        u45:setColor(p71);
    end);
    u45.colorPicker.onCancel:Connect(function(p72) -- Line: 381
        -- upvalues: u45 (copy)
        u45:setColor(p72);
    end);
    u45.colorPicker.onConfirm:Connect(function(p73) -- Line: 385
        -- upvalues: u45 (copy)
        u45:setColor(p73);
    end);
    OptionsList.IconColor.Color.MouseButton1Click:Connect(function() -- Line: 389
        -- upvalues: u45 (copy)
        u45.colorPicker:setColor(u45.color);
        u45.colorPicker:show();
    end);
    OptionsList.IconColor.EditColor.MouseButton1Click:Connect(function() -- Line: 394
        -- upvalues: u45 (copy)
        u45.colorPicker:setColor(u45.color);
        u45.colorPicker:show();
    end);

    for _, child in u43.Sidebar.AnimationsList:GetChildren() do
        if child:IsA("TextButton") then
            child.MouseButton1Click:Connect(function() -- Line: 401
                -- upvalues: u2 (ref), u45 (copy), child (copy)
                local table_find_ret = table.find(u2[u45.iconCount] or {}, child.Name);

                if not table_find_ret then
                    return;
                end;

                u45:setCurrentAnim(table_find_ret);
            end);
        end;
    end;

    for _, child in u43.Sidebar.PreviewSideList:GetChildren() do
        if child:IsA("TextButton") then
            child.MouseButton1Click:Connect(function() -- Line: 411
                -- upvalues: u45 (copy), child (copy)
                u45:setPreviewSide(child.Name);
            end);
        end;
    end;

    for _, child in u43.OptionsList.IconFacing.IndvList:GetChildren() do
        if child:IsA("TextButton") then
            child.MouseButton1Click:Connect(function() -- Line: 419
                -- upvalues: u45 (copy), child (copy)
                u45:setFacing(child.Name);
            end);
        end;
    end;

    return u45;
end;

function u1.update(p74, p75) -- Line: 469
    local previewScale = p74.previewScale;
    local math_clamp_ret = math.clamp(1 - p75 * 9, 0, 1);
    p74.previewScale = math.lerp(1, previewScale, math_clamp_ret);
    p74.ui.Health.IconDisplay.UIScale.Scale = p74.previewScale;
end;

function u1.hasUnsavedChanges(p76) -- Line: 474
    if not p76.curIcon then
        return false;
    end;

    local curIcon = p76.curIcon;
    local v77 = p76:saveIcon();

    for i, v in curIcon do
        if v77[i] ~= v then
            return true;
        end;
    end;

    for i, v in v77 do
        if curIcon[i] ~= v then
            return true;
        end;
    end;

    return false;
end;

function u1.safeLoadIcon(u78: table, u79: table) -- Line: 490
    if not (u78.curIcon and u78:hasUnsavedChanges()) then
        u78:loadIcon(u79);

        return;
    end;

    u78.saveWarn:load({
        cancel = function() -- Line: 493, Name: cancel
        end,

        noSave = function() -- Line: 495, Name: noSave
            -- upvalues: u78 (copy), u79 (copy)
            u78:loadIcon(u79);
        end,

        save = function() -- Line: 498, Name: save
            -- upvalues: u78 (copy), u79 (copy)
            local v80 = u78:saveIcon();
            u78.onSaveIcon:Fire(v80);
            u78.curIcon = v80;
            u78:loadIcon(u79);
        end
    });
    u78.saveWarn:show();
end;

function u1.loadIcon(p81: table, p82: table) -- Line: 513
    p81.onLoadIcon:Fire(p82);
    p81.boxes.iconCount:set(p82.IconCount or 2);
    p81.boxes.scale:set(p82.Scale or 1);
    p81.boxes.transparency:set(p82.Transparency or 1);
    p81:setSize(p82.Size or Vector2.new(150, 150));
    p81.boxes.iconSizeX:set(p81.size.X, true);
    p81.boxes.iconSizeY:set(p81.size.Y, true);
    p81:setOffset(p82.Offset or Vector2.zero);
    p81.boxes.iconOffsetX:set(p81.offset.X, true);
    p81.boxes.iconOffsetY:set(p81.offset.Y, true);

    if p82.Antialiasing == nil then
        p82.Antialiasing = true;
    end;

    p81.boxes.antialiasing:set(p82.Antialiasing);

    if p82.FlipAutomatically == nil then
        p82.FlipAutomatically = true;
    end;

    p81:setAutoFlip(p82.FlipAutomatically);
    p81.iconName = p82.Name or "Step On Up";
    p81.boxes.iconName:set(p81.iconName, true);
    p81:setFacing((p82.Facing == "Left" or p82.Facing == "L") and "L" or "R");
    p81:setPreviewSide(p81.previewSide);

    if p82.Asset and not p82.Id then
        local v83, v84 = p82.Asset:find("%d+");

        if v83 then
            p82.Id = tonumber(p82.Asset:sub(v83, v84));
        end;
    end;

    task.spawn(p81.loadImage, p81, p82.Id or 0);
    p81:setColor(p82.Color or Color3.new(1, 1, 1));
    p81.colorPicker:setColor(p81.color);
    p81:setCurrentAnim(1);
    p81.curIcon = p81:saveIcon();
end;

function u1.saveIcon(p85) -- Line: 556
    return {
        Name = p85.iconName,
        Asset = `rbxassetid://{p85.imageId}`,
        IconCount = p85.iconCount,
        Offset = p85.offset,
        Size = p85.size,
        Scale = p85.scale,
        Transparency = p85.transparency,
        Color = p85.color,
        Antialiasing = p85.antialiasing,
        Facing = p85.facing,
        FlipAutomatically = p85.automaticallyFlip
    };
end;

function u1.reconcileIcon(p86: table, p87: table) -- Line: 575
    local _ = p87.Id or 0;

    if p87.Asset and not p87.Id then
        local v88, v89 = p87.Asset:find("%d+");

        if v88 then
            tonumber(p87.Asset:sub(v88, v89));
        end;
    end;

    local Antialiasing = p87.Antialiasing;
    local FlipAutomatically = p87.FlipAutomatically;

    return {
        Name = p87.Name or "Step On Up",
        Facing = (p87.Facing == "Left" or p87.Facing == "L") and "L" or "R",
        Transparency = p87.Transparency or 0,
        Id = p87.Id or 0,
        Offset = p87.Offset or Vector2.zero,
        Size = p87.Size or Vector2.new(150, 150),
        IconCount = p87.IconCount or 2,
        Scale = p87.Scale or 1,
        Color = p87.Color or Color3.new(1, 1, 1),
        Antialiasing = Antialiasing == nil and true or Antialiasing,
        FlipAutomatically = FlipAutomatically == nil and true or FlipAutomatically
    };
end;

function u1.setCurrentAnim(p90, p91) -- Line: 607
    -- upvalues: u2 (copy), u3 (copy)
    p90.curFrame = p91;
    local v92 = u2[p90.iconCount] or {};

    for _, child in p90.ui.Sidebar.AnimationsList:GetChildren() do
        if child:IsA("TextButton") then
            local v93 = v92[p91] == child.Name and u3.Selected or u3.Idle;
            local UIStroke = child.UIStroke;
            UIStroke.Color = v93.Color;
            UIStroke.Thickness = v93.Thickness;
            UIStroke.Transparency = v93.Transparency;
        end;
    end;

    p90:updateIconAnim();
end;

function u1.updateIconAnim(p94) -- Line: 624
    local v95 = p94.size or (Vector2.new(p94._imgWidth / p94.iconCount, p94._imgHeight) or Vector2.zero);
    local v96 = p94.size and Vector2.new(p94.size.X * (p94.curFrame - 1), 0) or Vector2.new(p94._imgWidth / p94.iconCount * (p94.curFrame - 1), 0);

    if p94.facing == p94.previewSide and p94.automaticallyFlip then
        v96 = v96 + Vector2.new(v95.X, 0);
        v95 = v95 * Vector2.new(-1, 1);
    end;

    p94.displayIcon.ImageRectSize = v95;
    p94.displayIcon.ImageRectOffset = v96;
end;

function u1.updateIconBounds(p97) -- Line: 637
    local IconImageDisplay = p97.ui.ImageDisplay.IconImageDisplay;
    local v98 = p97.prevBoundBoxes or {};

    for _, v in v98 do
        v:Destroy();
    end;

    table.clear(v98);

    if p97.imageId == 0 or (p97._imgWidth == -1 or p97._imgHeight == -1) then
        return;
    end;

    local _imgWidth = p97._imgWidth;
    local _imgHeight = p97._imgHeight;
    local AbsoluteSize = IconImageDisplay.AbsoluteSize;
    local v99 = _imgWidth / _imgHeight * AbsoluteSize.Y;
    IconImageDisplay.BoundsDisplay.Position = UDim2.fromScale((AbsoluteSize.X - v99) / AbsoluteSize.X / 2, 0.5);
    IconImageDisplay.BoundsDisplay.UIGridLayout.CellSize = UDim2.new(p97.size and p97.size.X / _imgWidth * v99 / AbsoluteSize.X or v99 / AbsoluteSize.X / p97.iconCount, 0, p97.size and (p97.size.Y / _imgHeight or 1) or 1, -1);
    local v100 = {};

    for i = 1, p97.iconCount do
        local v101 = IconImageDisplay.BoundsDisplay.BoundsTemplate:Clone();
        v101.Visible = p97.showRectBounds and true or false;
        v101.Name = "Bound";
        v101.Parent = IconImageDisplay.BoundsDisplay;
        table.insert(v100, v101);
        local _ = i;
    end;

    p97.prevBoundBoxes = v100;
end;

function u1.setDisplayBounds(p102, p103) -- Line: 676
    p102.showRectBounds = p103;

    for _, v in p102.prevBoundBoxes or {} do
        v.Visible = p103 and true or false;
    end;
end;

function u1.setFacing(p104, p105) -- Line: 684
    -- upvalues: u3 (copy)
    p104.facing = p105;

    for _, child in p104.ui.OptionsList.IconFacing.IndvList:GetChildren() do
        if child:IsA("TextButton") then
            local v106 = p105 == child.Name and u3.Selected or u3.Idle;
            local UIStroke = child.UIStroke;
            UIStroke.Color = v106.Color;
            UIStroke.Thickness = v106.Thickness;
            UIStroke.Transparency = v106.Transparency;
        end;
    end;

    p104:updateIconAnim();
end;

function u1.setPreviewSide(p107, p108) -- Line: 700
    -- upvalues: u3 (copy)
    p107.previewSide = p108;

    for _, child in p107.ui.Sidebar.PreviewSideList:GetChildren() do
        if child:IsA("TextButton") then
            local v109 = p108 == child.Name and u3.Selected or u3.Idle;
            local UIStroke = child.UIStroke;
            UIStroke.Color = v109.Color;
            UIStroke.Thickness = v109.Thickness;
            UIStroke.Transparency = v109.Transparency;
        end;
    end;

    p107.ui.Health.UIGradient.Rotation = p108 == "R" and 0 or 180;
    p107.ui.Health.Container.UIGradient.Rotation = p108 == "R" and 0 or 180;
    p107:setOffset(p107.offset);
    p107:updateIconAnim();
end;

function u1.setIconCount(p110, p111) -- Line: 720
    -- upvalues: u2 (copy)
    p110.iconCount = p111;
    local v112 = u2[p111] or {};

    if not v112[p110.curFrame] then
        p110:setCurrentAnim(1);
    end;

    for _, child in p110.ui.Sidebar.AnimationsList:GetChildren() do
        if child:IsA("TextButton") then
            child.Visible = table.find(v112, child.Name) and true or false;
        end;
    end;

    p110:updateIconSizeHintText();
    p110:updateIconBounds();
end;

function u1.updateIconSizeHintText(p113) -- Line: 735
    local IndvList = p113.ui.OptionsList.IconBaseSize.IndvList;
    IndvList.XOffset.BoxContent.PlaceholderText = p113._imgWidth == -1 and 150 or (p113._imgWidth / p113.iconCount or 150);
    IndvList.YOffset.BoxContent.PlaceholderText = p113._imgHeight == -1 and 150 or (p113._imgHeight or 150);
end;

function u1.setOffset(p114: table, p115) -- Line: 741
    p114.offset = p115;

    if p114.facing == p114.previewSide and p114.automaticallyFlip then
        p115 = Vector2.new(-p115.X, p115.Y);
    end;

    p114.displayIcon.Position = UDim2.fromScale(0.5 + p115.X, 0.5 + p115.Y);
end;

function u1.setAntialiasing(p116, p117) -- Line: 751
    p116.antialiasing = p117 and true or false;
    p116.displayIcon.ResampleMode = p117 and Enum.ResamplerMode.Default or Enum.ResamplerMode.Pixelated;
end;

function u1.setAutoFlip(p118, p119) -- Line: 756
    p118.automaticallyFlip = p119 and true or false;
    p118:updateIconAnim();
end;

function u1.setSize(p120: table, p121) -- Line: 761
    p120.size = p121;
    local math_min_ret = math.min(150 / p121.Y, 150 / p121.X);
    p120.displayIcon.Size = UDim2.fromScale(p121.X / 150 * math_min_ret, p121.Y / 150 * math_min_ret);
    p120:updateIconBounds();
    p120:updateIconAnim();
end;

function u1.setScale(p122, p123) -- Line: 772
    p122.scale = p123;
    p122.displayIcon.UIScale.Scale = p123;
    p122.boxes.scale:set(p123);
end;

function u1.setTrans(p124, p125) -- Line: 779
    p124.transparency = p125;
    p124.displayIcon.ImageTransparency = 1 - p125;
    p124.boxes.transparency:set(p125);
end;

function u1.setColor(p126, p127) -- Line: 786
    p126.color = p127;
    p126.ui.Health.Container.BackgroundColor3 = p127;
    p126.ui.OptionsList.IconColor.Color.BackgroundColor3 = p127;
end;

function u1.loadImage(p128, p129) -- Line: 792
    -- upvalues: GetImageID (copy), GetImageSize (copy)
    local v130 = p129 or 0;

    if p128.imageId == v130 then
        return;
    end;

    local ImageValidState = p128.ui.OptionsList.ImageID.ImageValidState;
    p128.imageId = v130;
    ImageValidState.NonValidDisplay.Visible = false;
    ImageValidState.ValidDisplay.Visible = false;
    p128.ui.ImageSizeLabel.Text = "?x?";
    p128._imgWidth = -1;
    p128._imgHeight = -1;
    p128.ui.ImageDisplay.IconImageDisplay.ImageContent = Content.none;
    p128.displayIcon.ImageContent = Content.none;
    p128:updateIconBounds();

    if v130 == 0 then
        p128.boxes.imageId:set(v130, true);
        ImageValidState.NonValidDisplay.Visible = true;

        return;
    end;

    local _, v131 = GetImageID:InvokeServer(v130);

    if p128.imageId ~= v130 then
        return;
    end;

    p128.imageId = v131 or p128.imageId;
    p128.boxes.imageId:set(p128.imageId, true);
    ImageValidState.NonValidDisplay.Visible = not v131;
    ImageValidState.ValidDisplay.Visible = v131 and true or false;
    p128.ui.ImageDisplay.IconImageDisplay.ImageContent = v131 and Content.fromAssetId(v131) or Content.none;
    p128.displayIcon.ImageContent = v131 and Content.fromAssetId(v131) or Content.none;
    local _ = p128.ui.OptionsList.IconBaseSize.IndvList;

    if v131 then
        local v132, v133 = GetImageSize:InvokeServer(v131);

        if p128.imageId ~= v131 then
            return;
        end;

        if v132 and v133 then
            p128._imgWidth = v132;
            p128._imgHeight = v133;
            p128.ui.ImageSizeLabel.Text = `{v132 or "?"}x{v133 or "?"}`;
        end;
    end;

    p128:updateIconBounds();
    p128:updateIconSizeHintText();
end;

function u1.show(u134) -- Line: 849
    -- upvalues: IconEditor (copy), RunService (copy)
    u134.visible = true;
    local ui = u134.ui;
    u134.translateCleanup = IconEditor.AsignTask(function() -- Line: 853
        -- upvalues: ui (copy), IconEditor (ref)
        local OptionsList = ui.OptionsList;
        OptionsList.Antialiasing.SettingLabel.Text = IconEditor.IconEditor_SettingNames_Antialiasing;
        OptionsList.IconAutoFlip.SettingLabel.Text = IconEditor.IconEditor_SettingNames_AutoFlip;
        OptionsList.IconBaseSize.SettingLabel.Text = IconEditor.IconEditor_SettingNames_IconSize;
        OptionsList.IconColor.SettingLabel.Text = IconEditor.IconEditor_SettingNames_Color;
        OptionsList.IconCount.SettingLabel.Text = IconEditor.IconEditor_SettingNames_IconCount;
        OptionsList.IconFacing.SettingLabel.Text = IconEditor.IconEditor_SettingNames_Facing;
        OptionsList.IconOffset.SettingLabel.Text = IconEditor.IconEditor_SettingNames_Offset;
        OptionsList.IconScale.SettingLabel.Text = IconEditor.IconEditor_SettingNames_Scale;
        OptionsList.IconTrans.SettingLabel.Text = IconEditor.IconEditor_SettingNames_Alpha;
        OptionsList.ImageID.SettingLabel.Text = IconEditor.IconEditor_SettingNames_ImageId;
        OptionsList.IconColor.EditColor.Text = IconEditor.IconEditor_SettingNames_EditColor;
        OptionsList.IconFacing.IndvList.L.Text = IconEditor.IconEditor_SideFacing_TextureLeft;
        OptionsList.IconFacing.IndvList.R.Text = IconEditor.IconEditor_SideFacing_TextureRight;
        local ToolbarButNotToolbar = ui.ToolbarButNotToolbar;
        ToolbarButNotToolbar.Cancel.Text = IconEditor.IconEditor_Toolbar_Cancel;
        ToolbarButNotToolbar.UndoChanges.Text = IconEditor.IconEditor_Toolbar_Undo;
        ToolbarButNotToolbar.Save.Text = IconEditor.IconEditor_Toolbar_Save;
        local Sidebar = ui.Sidebar;
        Sidebar.IconNameHeaderLabel.Text = IconEditor.IconEditor_Headers_IconName;
        Sidebar.AnimationsHeaderLabel.Text = IconEditor.IconEditor_Headers_Animations;
        Sidebar.SidePreviewHeaderLabel.Text = IconEditor.IconEditor_Headers_PreviewSide;
        Sidebar.AnimationsList.Idle.Text = IconEditor.IconEditor_IconAnims_Idle;
        Sidebar.AnimationsList.Losing.Text = IconEditor.IconEditor_IconAnims_Losing;
        Sidebar.AnimationsList.Overlosing.Text = IconEditor.IconEditor_IconAnims_Overlosing;
        Sidebar.AnimationsList.Overwinning.Text = IconEditor.IconEditor_IconAnims_Overwinning;
        Sidebar.AnimationsList.Winning.Text = IconEditor.IconEditor_IconAnims_Winning;
        Sidebar.RectBoundsCheckbox.SettingLabel.Text = IconEditor.IconEditor_SettingNames_ShowBounds;
        Sidebar.PreviewSideList.L.Text = IconEditor.IconEditor_SideFacing_GameplayLeft;
        Sidebar.PreviewSideList.R.Text = IconEditor.IconEditor_SideFacing_GameplayRight;
        Sidebar.BoxContent.PlaceholderText = IconEditor.IconEditor_IconNamePlaceholder;
        Sidebar.BoxContent.FilterInProgress.Text = IconEditor.IconEditor_TextBeingFiltered;
    end);
    u134.updateCon = RunService.RenderStepped:Connect(function(p135) -- Line: 897
        -- upvalues: u134 (copy)
        u134:update(p135);
    end);
    ui.Visible = true;
end;

function u1.hide(p136) -- Line: 904
    p136.visible = false;
    p136.ui.Visible = false;

    if p136.translateCleanup then
        p136.translateCleanup();
        p136.translateCleanup = nil;
    end;

    if p136.updateCon then
        p136.updateCon:Disconnect();
        p136.updateCon = nil;
    end;

    p136.colorPicker:hide();
end;

return u1;