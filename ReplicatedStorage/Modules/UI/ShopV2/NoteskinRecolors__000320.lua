-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Assets = ReplicatedStorage:WaitForChild("Assets");
local DataManager = require(Modules.Data.DataManager);
local ColorPicker = require(Modules.UI.ColorPicker);
local Signal = require(Modules.Lib.Signal);
local RGBSprite = require(Modules.Main.RGBSprite);
local AssetReplicator = require(Modules.Main.AssetReplicator);
local Data = DataManager:GetData();
local u2 = {
    Noteskin = Assets:WaitForChild("Noteskins"),
    Notesplash = Assets:WaitForChild("Notesplashes"),
    Holdsplash = AssetReplicator.getAsset("Holdsplashes")
};
Content.fromAssetId(89542090220189);
local u3 = {
    Down = { Vector2.new(5, 5), Vector2.new(158, 154) },
    Down2 = { Vector2.new(168, 5), Vector2.new(158, 154) },
    Left = { Vector2.new(331, 5), Vector2.new(154, 157) },
    Left2 = { Vector2.new(490, 5), Vector2.new(155, 157) },
    Plus = { Vector2.new(650, 5), Vector2.new(145, 145) },
    rDown = { Vector2.new(800, 5), Vector2.new(160, 154) },
    rDown2 = { Vector2.new(5, 167), Vector2.new(160, 154) },
    Right = { Vector2.new(170, 167), Vector2.new(154, 157) },
    Right2 = { Vector2.new(329, 167), Vector2.new(154, 157) },
    rLeft = { Vector2.new(488, 167), Vector2.new(153, 160) },
    rLeft2 = { Vector2.new(646, 167), Vector2.new(152, 160) },
    rRight = { Vector2.new(803, 167), Vector2.new(152, 160) },
    rRight2 = { Vector2.new(5, 332), Vector2.new(153, 160) },
    rUp = { Vector2.new(163, 332), Vector2.new(160, 153) },
    rUp2 = { Vector2.new(328, 332), Vector2.new(161, 153) },
    Square = { Vector2.new(494, 332), Vector2.new(171, 170) },
    Up = { Vector2.new(670, 332), Vector2.new(157, 154) },
    Up2 = { Vector2.new(832, 332), Vector2.new(158, 154) }
};
local v4 = { "Global" };
local u5 = {
    Noteskin = { "note", "hold", "holdend", "press", "confirm" }
};
local u6 = { "Left", "Down", "Up", "Right", "Square", "Left2", "Down2", "Up2", "Right2", "rLeft", "rDown", "rUp", "rRight", "Plus", "rLeft2", "rDown2", "rUp2", "rRight2" };
local u7 = { "Hue", "Tint", "HueShift" };
local u8 = {
    Hue = "Hue",
    Tint = "Tint",
    HueShift = "Hue Shift"
};

for i = 4, 18 do
    v4[i - 2] = tostring(i);
    local _ = i;
end;

function getSetFor(p9: userdata, p10: string)
    if p10 and p9 then
        local v11 = p10 or "";
        local v12 = p9:FindFirstChild(v11);

        if v12 then
            return v12;
        end;

        if v11 == "Plus" and not v12 then
            v11 = "rDown2";
            v12 = p9:FindFirstChild(v11);
        end;

        if v11 == "Square" and not v12 then
            v11 = "rUp2";
            v12 = p9:FindFirstChild(v11);
        end;

        if v12 then
            return v12;
        end;

        local v13 = p9:FindFirstChild((string.gsub(v11, "%A", "")));

        if v13 then
            return v13;
        end;

        if string.sub(v11, 1, 1) == "r" then
            local string_sub_ret = string.sub(v11, 2);
            local v14 = p9:FindFirstChild(string_sub_ret);

            if v14 then
                return v14;
            end;

            v13 = p9:FindFirstChild((string.gsub(string_sub_ret, "%A", "")));
        end;

        return v13;
    end;
end;

function getItem(p15, p16, p17)
    if p16 == "" then
        p16 = nil;
    end;

    if p17 == "" then
        p17 = nil;
    end;

    if not p15 then
        return;
    end;

    local v18 = p15:FindFirstChild(p17 or (p16 or ""));

    if v18 then
        if not ((not p17 or v18:GetAttribute("Pack")) and (p17 or not v18:GetAttribute("Pack"))) then
            return warn("[ShopV2/NoteskinRecolors] Invalid item", p16);
        end;

        if p17 then
            return v18:FindFirstChild(p16);
        end;

        return v18;
    end;
end;

function getSetAnims(p19: any, p20: userdata)
    -- upvalues: RGBSprite (copy)
    if p19 then
        local Attribute = p19:GetAttribute("Antialiasing");
        local v21 = tonumber(p19:GetAttribute("Framerate")) or 24;
        local v22 = tonumber(p19:GetAttribute("SizeMult")) or 1;
        local v23 = tonumber(p19:GetAttribute("Factor")) or 1;
        local v24 = {};

        if p20 == "Noteskin" then
            v24.static = RGBSprite:GetAnimFramesByResults(p19, { "receptor0", "receptor static0" }, v23, v22);
            v24.confirm = RGBSprite:GetAnimFramesByResults(p19, { "receptor confirm0" }, v23, v22);
            v24.press = RGBSprite:GetAnimFramesByResults(p19, { "receptor press0", "receptor pressed0" }, v23, v22);
            v24.hold = RGBSprite:GetAnimFramesByResults(p19, { "note hold piece0", "note hold0" }, v23, v22);
            v24.holdend = RGBSprite:GetAnimFramesByResults(p19, { "note hold end0", "note holdend0", "note tail0" }, v23, v22);
            v24.note = RGBSprite:GetAnimFramesByResults(p19, { "note0", "note alone0" }, v23, v22);
        elseif p20 == "Holdsplash" then
            v24.idle = RGBSprite:GetAnimFramesByResults(p19, { "Idle0" }, v23, v22);
        elseif p20 == "Notesplash" then
            v24.idle = RGBSprite:GetAnimFramesByResults(p19, { "splash0" }, v23, v22);
        end;

        v24._id = p19:GetAttribute("Image");
        v24._antialiasing = Attribute == nil and true or Attribute;
        v24._framerate = v21;

        return v24;
    end;
end;

function colorFromShifts(p25, p26, p27)
    if p25 < 0 then
        p25 = 360 + p25;
    end;

    if p26 < 0 then
        p26 = 1 + p26;
    end;

    if p27 < 0 then
        p27 = 1 + p27;
    end;

    return Color3.fromHSV(p25, p26, p27);
end;

function newCheckbox(u28: userdata, u29: any)
    if u28 then
        local u33 = {
            value = nil,

            set = function(p30, p31, p32) -- Line: 184, Name: set
                -- upvalues: u28 (copy), u29 (copy)
                local value = p30.value;
                p30.value = p31;
                u28.OptionEnabled.Visible = p31 and true or false;

                if u29 and (not p32 and p31 ~= value) then
                    u29(p31);
                end;
            end
        };
        u28.MouseButton1Click:Connect(function() -- Line: 195
            -- upvalues: u33 (copy)
            u33:set(not u33.value);
        end);

        return u33;
    end;
end;

local function newSlider(u34, p35, p36, u37) -- Line: 202
    if u34 then
        local u38 = p35 or 0;
        local u39 = p36 or 1;
        local u40 = {
            value = 0
        };
        local SliderObj = u34.SliderBox.SliderObj;

        function u40.set(p41, p42, p43) -- Line: 214
            -- upvalues: u38 (ref), u39 (ref), SliderObj (copy), u34 (copy), u37 (copy)
            local value = p41.value;
            p41.value = math.clamp(p42, u38, u39);
            SliderObj.Position = UDim2.fromScale(math.map(p41.value, u38, u39, 0, 1), 0.5);
            u34.TextBox.Text = tostring(p41.value);

            if u37 and (not p43 and p42 ~= value) then
                u37(p42);
            end;
        end;

        local function updateDrag(p44) -- Line: 226
            -- upvalues: SliderObj (copy), u38 (ref), u39 (ref), u40 (copy), u37 (copy)
            local math_map_ret = math.map(SliderObj.Position.X.Scale, 0, 1, u38, u39);
            local math_round_ret = math.round(math_map_ret);
            u40:set(math_round_ret);

            if p44 == true and u37 then
                u37(math_round_ret, true);
            end;
        end;

        SliderObj.UIDragDetector.DragStart:Connect(updateDrag);
        SliderObj.UIDragDetector.DragEnd:Connect(function() -- Line: 235
            -- upvalues: SliderObj (copy), u38 (ref), u39 (ref), u40 (copy), u37 (copy)
            local math_map_ret = math.map(SliderObj.Position.X.Scale, 0, 1, u38, u39);
            local math_round_ret = math.round(math_map_ret);
            u40:set(math_round_ret);

            if u37 then
                u37(math_round_ret, true);
            end;
        end);
        SliderObj.UIDragDetector.DragContinue:Connect(updateDrag);
        u34.TextBox.FocusLost:Connect(function() -- Line: 240
            -- upvalues: u34 (copy), u40 (copy)
            local v45 = u34.Text:gsub("[^%d%.%-]", "");
            local v46 = tonumber(v45);

            if v46 then
                u40:set(v46);

                return;
            end;

            u34.Text = tostring(u40.value);
        end);

        return u40;
    end;
end;

function u1.new(p47) -- Line: 252
    -- upvalues: ColorPicker (copy), Signal (copy), u1 (copy), RGBSprite (copy), Data (copy), DataManager (copy), u7 (copy), newSlider (copy)
    local v48 = {
        selected = nil,
        mode = "Noteskin",
        group = "Global",
        liveUpdate = false,
        ui = p47,
        colorPicker = ColorPicker.new({
            CloseButton = Instance.new("TextButton"),
            ResetButton = Instance.new("TextButton"),
            ConfirmButton = Instance.new("TextButton"),
            Main = p47.BG.ColorPicker.Main,
            ColorLabel = p47.BG.ColorLabel,

            FindFirstChild = function() -- Line: 268, Name: FindFirstChild
            end
        }),
        animationCheckboxes = {},
        animMap = {
            Noteskin = {
                static = p47.BG.Animations.ScrollingFrame.Idle,
                confirm = p47.BG.Animations.ScrollingFrame.Confirm,
                press = p47.BG.Animations.ScrollingFrame.Press,
                note = p47.BG.Animations.ScrollingFrame.Note,
                hold = p47.BG.Animations.ScrollingFrame.Hold,
                holdend = p47.BG.Animations.ScrollingFrame.HoldEnd
            },
            Holdsplash = {},
            Notesplash = {}
        },
        sprites = {
            Noteskin = {},
            Holdsplash = {},
            Notesplash = {}
        },
        onClose = Signal.new()
    };
    local u49 = setmetatable(v48, u1);

    local function setCheck(p50, p51) -- Line: 297
        -- upvalues: u49 (copy)
        if u49.curData then
            if p51 and not table.find(u49.curData.Animations, p50) then
                table.insert(u49.curData.Animations, p50);
            else
                local v52 = not p51 and table.find(u49.curData.Animations, p50);

                if v52 then
                    table.remove(u49.curData.Animations, v52);
                end;
            end;

            u49:updatePreview();
        end;
    end;

    for _, child in p47.StrumsList:GetChildren() do
        if child:IsA("ImageButton") then
            child.MouseButton1Click:Connect(function() -- Line: 312
                -- upvalues: u49 (copy), child (copy)
                u49:setSelected(child.Name);
            end);
        end;
    end;

    for i, v in u49.animMap do
        local v53 = i;

        for i2, v2 in v do
            u49.animationCheckboxes[i2] = newCheckbox(v2.Checkbox, function(p54: boolean) -- Line: 320
                -- upvalues: setCheck (copy), i2 (copy)
                setCheck(i2, p54);
            end);
            local v55 = RGBSprite.new(v2.ImageLabel, Vector2.new(180, 180), nil, nil, true);
            v55.anchor = Vector2.new(0.5, 0.5);
            v55.useFactorsForPosition = true;
            v55.x = 90;
            v55.y = 90;
            u49.sprites[v53][i2] = v55;
        end;
    end;

    local v56 = RGBSprite.new(p47.BG.Preview.ImageLabel, Vector2.new(155, 155), nil, nil, true);
    v56.anchor = Vector2.new(0.5, 0.5);
    v56.useFactorsForPosition = true;
    v56.x = 77.5;
    v56.y = 77.5;
    u49.previewSprite = v56;
    newCheckbox(p47.BG.Checkbox, function(p57: boolean) -- Line: 348
        -- upvalues: u49 (copy)
        u49.liveUpdate = p57;
    end):set(u49.liveUpdate, true);
    u49.colorPicker.onColorChanged:Connect(function(p58) -- Line: 352
        -- upvalues: u49 (copy)
        if not u49.liveUpdate then
            return;
        end;

        u49:setColor(p58);
    end);
    u49.colorPicker.onColorFinish:Connect(function(p59) -- Line: 357
        -- upvalues: u49 (copy)
        u49:setColor(p59);
    end);
    p47.CloseButton.MouseButton1Click:Connect(function() -- Line: 361
        -- upvalues: u49 (copy)
        u49.onClose:Fire();
    end);
    p47.Buttons.Clear.MouseButton1Click:Connect(function() -- Line: 365
        -- upvalues: Data (ref), u49 (copy), DataManager (ref)
        local v60 = Data.NoteskinCustomization[u49.selected];

        if v60 then
            v60 = v60[u49.group];
        end;

        if v60 then
            v60[u49.mode .. "Color"] = nil;
        end;

        DataManager:SetData("NoteskinCustomization/" .. u49.selected .. "/" .. u49.group .. "/" .. u49.mode .. "Color", nil);
        u49:setSelected(u49.selected);
        u49:updateRender();
    end);
    p47.Buttons.UndoChanges.MouseButton1Click:Connect(function() -- Line: 378
        -- upvalues: u49 (copy)
        u49:setSelected(u49.selected);
    end);
    p47.Buttons.ClearAll.MouseButton1Click:Connect(function() -- Line: 382
        -- upvalues: Data (ref), u49 (copy), DataManager (ref)
        for i, v in Data.NoteskinCustomization do
            local v61 = v[u49.group];

            if v61 then
                v61[u49.mode .. "Color"] = nil;
                DataManager:SetData("NoteskinCustomization/" .. i .. "/" .. u49.group .. "/" .. u49.mode .. "Color", nil);
            end;
        end;

        u49:setSelected(u49.selected);
        u49:updateRender();
    end);
    p47.Buttons.Save.MouseButton1Click:Connect(function() -- Line: 395
        -- upvalues: u49 (copy), Data (ref), DataManager (ref)
        local v62 = u49:save();
        local v63 = Data.NoteskinCustomization[u49.selected];

        if v63 then
            if v63[u49.group] then
                DataManager:SetData("NoteskinCustomization/" .. u49.selected .. "/" .. u49.group .. "/" .. u49.mode .. "Color", v62);
            else
                DataManager:SetData("NoteskinCustomization/" .. u49.selected .. "/" .. u49.group, {
                    [u49.mode .. "Color"] = v62
                });
            end;
        else
            DataManager:SetData("NoteskinCustomization/" .. u49.selected, {
                [u49.group] = {
                    [u49.mode .. "Color"] = v62
                }
            });
        end;

        u49:updateRender();
    end);
    p47.BG.MethodScroll.Advance.MouseButton1Click:Connect(function() -- Line: 418
        -- upvalues: u7 (ref), u49 (copy)
        local table_find_ret = table.find(u7, u49.curData.Type);
        local v64;

        if table_find_ret then
            local v65 = table_find_ret + 1;
            v64 = #u7 < v65 and 1 or v65;
        else
            v64 = 1;
        end;

        u49:setType(u7[v64]);
        u49:updatePreviewEditable();
    end);
    p47.BG.MethodScroll.GoBack.MouseButton1Click:Connect(function() -- Line: 435
        -- upvalues: u7 (ref), u49 (copy)
        local table_find_ret = table.find(u7, u49.curData.Type);
        local v66;

        if table_find_ret then
            local v67 = table_find_ret - 1;
            v66 = v67 <= 0 and #u7 or v67;
        else
            v66 = 1;
        end;

        u49:setType(u7[v66]);
        u49:updatePreviewEditable();
    end);
    local u68 = nil;
    local u69 = nil;
    local u70 = nil;

    local function updateSlider(p71, p72) -- Line: 456
        -- upvalues: u49 (copy), u68 (ref), u69 (ref), u70 (ref)
        if p72 or u49.liveUpdate then
            u49:setShifts({ u68.value / 180, u69.value / 100, u70.value / 100 });
        end;
    end;

    u68 = newSlider(p47.BG.HueShifter.Main.Properties.HHue, -180, 180, updateSlider);
    u69 = newSlider(p47.BG.HueShifter.Main.Properties.SSaturation, -100, 100, updateSlider);
    u70 = newSlider(p47.BG.HueShifter.Main.Properties.VValue, -100, 100, updateSlider);
    u68:set(0, true);
    u69:set(0, true);
    u70:set(0, true);
    u49.hueShifter = {
        setShifts = function(p73: any, p74: table) -- Line: 475, Name: setShifts
            -- upvalues: u68 (ref), u69 (ref), u70 (ref)
            u68:set(p74[1] * 180, true);
            u69:set(p74[2] * 100, true);
            u70:set(p74[3] * 100, true);
        end
    };

    return u49;
end;

function u1.save(p75) -- Line: 486
    local curData = p75.curData;

    if curData and curData.Color then
        return {
            Color = curData.Type == "HueShift" and curData.Shifts or { curData.Color.R, curData.Color.G, curData.Color.B },
            Type = curData.Type,
            Animations = table.clone(curData.Animations)
        };
    end;
end;

function u1.setColor(p76, p77) -- Line: 498
    p76.curData.Color = p77;
    p76:updatePreviewEditable();
end;

function u1.setShifts(p78, p79) -- Line: 507
    p78.curData.Shifts = p79;
    p78:updatePreviewEditable();
end;

function u1.setType(p80, p81) -- Line: 516
    -- upvalues: u8 (copy)
    p80.curData.Type = p81;
    p80.ui.BG.MethodScroll.Text = u8[p81 or ""] or (p81 or "");
    p80.ui.BG.ColorPicker.Visible = false;
    p80.ui.BG.HueShifter.Visible = false;

    if p81 == "HueShift" then
        p80.ui.BG.HueShifter.Visible = true;
        p80.hueShifter:setShifts(p80.curData.Shifts or { 0, 0, 0 });

        return;
    end;

    p80.ui.BG.ColorPicker.Visible = true;
    p80.colorPicker:setColor(p80.curData.Color or Color3.new(1, 1, 1), true);
end;

function u1.setSelected(u82: table, p83: userdata) -- Line: 531
    -- upvalues: Data (copy), u5 (copy)
    u82:clearPreviewEditable();
    u82.selected = p83;
    u82.setData = u82:getSelectedSet();
    u82.ui.CurSelected.Text = `Selected: {p83}`;
    local v84 = ((Data.NoteskinCustomization[p83] or {})[u82.group] or {})[u82.mode .. "Color"];
    u82.curData = v84 and {
        Color = v84.Type == "HueShift" and Color3.new(1, 1, 1) or Color3.new(table.unpack(v84.Color)),
        Type = v84.Type or "Hue",
        Animations = table.clone(v84.Animations or u5[u82.mode]),
        Shifts = v84.Type == "HueShift" and (table.clone(v84.Color) or { 0, 0, 0 }) or { 0, 0, 0 }
    } or {
        Color = nil,
        Type = "Hue",
        Animations = table.clone(u5[u82.mode]),
        Shifts = { 0, 0, 0 }
    };
    u82:setType(u82.curData.Type);
    task.spawn(function() -- Line: 557
        -- upvalues: u82 (copy)
        u82:makePreviewEditable();
    end);

    for i, v in u82.animationCheckboxes do
        v:set(table.find(u82.curData.Animations, i), true);
    end;
end;

function u1.getSelectedSet(p85) -- Line: 566
    -- upvalues: Data (copy), u2 (copy)
    local v86 = Data.NoteskinOverrides[p85.selected or ""];
    local v87;

    if v86 then
        v87 = getItem(u2[p85.mode], v86[1], v86[2]);
    else
        v87 = nil;
    end;

    local v88 = v87 or getItem(u2[p85.mode], Data[p85.mode], Data[p85.mode .. "Pack"]);

    return getSetAnims(getSetFor(v88, p85.selected), p85.mode);
end;

function u1.makeEditable(p89) -- Line: 583
end;

function u1.makePreviewEditable(p90) -- Line: 605
    -- upvalues: RGBSprite (copy)
    p90:clearPreviewEditable();
    local setData = p90.setData;

    if not setData then
        return;
    end;

    p90.ui.BG.LoadingPreview.Visible = true;
    local Editable = RGBSprite:getEditable(setData._id);

    if Editable then
        if setData ~= p90.setData then
            Editable.Image:Destroy();

            return;
        end;

        p90:clearPreviewEditable();
        p90.previewEditable = Editable.Image;
        p90.previewEditablePixels = Editable.Image:ReadPixelsBuffer(Vector2.zero, Editable.Image.Size);
        p90.ui.BG.LoadingPreview.Visible = false;

        if p90.visible then
            p90:updatePreview();
            p90:updatePreviewEditable();
        end;
    end;
end;

function u1.clearEditable(p91) -- Line: 633
    if p91.editable then
        p91.editable:Destroy();
        p91.editable = nil;
    end;

    p91.editablePixels = nil;
end;

function u1.clearPreviewEditable(p92) -- Line: 642
    if p92.previewEditable then
        p92.previewEditable:Destroy();
        p92.previewEditable = nil;
    end;

    p92.previewEditablePixels = nil;

    if p92.visible then
        p92:updatePreview();
    end;
end;

function u1.updateActiveSprites(p93) -- Line: 655
    for i, v in p93.sprites do
        local v94 = i;

        for _, v2 in v do
            v2.active = v94 == p93.mode;
        end;
    end;

    p93.previewSprite.active = true;
end;

function u1.show(p95) -- Line: 665
    p95.visible = true;
    p95:setSelected(p95.selected or "Left");
    p95:updateActiveSprites();
    p95:updateRender();
    p95.colorPicker:show();
    p95.ui.Visible = true;
end;

function u1.hide(p96) -- Line: 677
    p96.visible = false;
    p96.ui.Visible = false;
    p96.colorPicker:hide();

    for _, v in p96.sprites do
        for _, v2 in v do
            v2.active = false;
        end;
    end;

    p96.previewSprite.active = false;
    p96:clearPreviewEditable();
end;

function u1.updatePreviewEditable(p97) -- Line: 693
    -- upvalues: RGBSprite (copy)
    local previewEditable = p97.previewEditable;
    local curData = p97.curData;

    if not p97.setData then
        return;
    end;

    if previewEditable and (curData and curData.Color) then
        previewEditable:WritePixelsBuffer(Vector2.zero, previewEditable.Size, p97.previewEditablePixels);
        RGBSprite:editImage(previewEditable, {
            Colors = curData.Type == "HueShift" and Vector3.new(table.unpack(curData.Shifts)) or curData.Color,
            Method = curData.Type,
            Frames = {
                {
                    Offset = Vector2.zero,
                    Size = previewEditable.Size
                }
            }
        });
    end;
end;

function u1.updatePreview(p98) -- Line: 715
    local setData = p98.setData;
    local previewEditable = p98.previewEditable;

    if not setData then
        return;
    end;

    for i, v in p98.sprites do
        local v99 = i;

        for i2, v2 in v do
            if v99 == p98.mode then
                v2:AddAnimation("idle", setData[i2] or {}, 24, false, setData._id);
                v2.antialiasing = setData._antialiasing;
                v2:Play("idle", true);
                v2.curFrame = #(setData[i2] or {});
                local v100;

                if table.find(p98.curData.Animations, i2) then
                    v100 = previewEditable or nil;
                else
                    v100 = nil;
                end;

                v2:load(v100);
            else
                v2:load(nil);
            end;
        end;
    end;

    local previewSprite = p98.previewSprite;
    previewSprite:AddAnimation("idle", setData.note or {}, 24, false, setData._id);
    previewSprite.antialiasing = setData._antialiasing;
    previewSprite:Play("idle", true);
    previewSprite.curFrame = #(setData.note or {});
    previewSprite:load(previewEditable);
end;

function u1.updateRender(p101) -- Line: 749
    -- upvalues: u3 (copy), u6 (copy), Data (copy), RGBSprite (copy)
    local v102;

    if p101.mode == "Noteskin" then
        v102 = u3;
    else
        v102 = false;
    end;

    local editable = p101.editable;
    local StrumsList = p101.ui.StrumsList;
    local v103 = {};

    for _, v in u6 do
        local v104 = (Data.NoteskinCustomization[v] or {})[p101.group];

        if v104 then
            v104 = v104[p101.mode .. "Color"];
        end;

        local v105 = StrumsList[v];

        if v104 then
            if editable then
                v105.NonReplaced.Visible = false;
                v105.Sprite.ImageContent = Content.fromObject(editable);
                v105.Sprite.Visible = true;
                local v106 = {
                    Colors = vector.create(table.unpack(v104.Color)),
                    Method = v104.Type,
                    Frames = {
                        {
                            Offset = v102[v][1],
                            Size = v102[v][2]
                        }
                    }
                };
                table.insert(v103, v106);
            else
                v105.NonReplaced.Visible = true;
                local v107 = v104.Color and Color3.new(table.unpack(v104.Color)) or Color3.new(1, 1, 1);

                if v104.Type == "HueShift" and v104.Color then
                    local table_unpack_ret, v108, v109 = table.unpack(v104.Color, 1, 3);
                    v107 = colorFromShifts(table_unpack_ret, v108, v109);
                end;

                v105.NonReplaced.ImageColor3 = v107;
                v105.Sprite.Visible = false;
            end;
        else
            v105.NonReplaced.Visible = true;
            v105.NonReplaced.ImageColor3 = Color3.new(1, 1, 1);
            v105.Sprite.Visible = false;
        end;
    end;

    if editable then
        editable:WritePixelsBuffer(Vector2.zero, editable.Size, p101.editablePixels);
        RGBSprite:editImage(editable, v103);
    end;
end;

return u1;