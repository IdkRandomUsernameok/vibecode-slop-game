-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Assets = ReplicatedStorage:WaitForChild("Assets");
local Signal = require(Modules.Lib.Signal);
local Sprite = require(Modules.Main.Sprite);
local AssetReplicator = require(Modules.Main.AssetReplicator);
local u2 = {
    Noteskin = Assets:WaitForChild("Noteskins"),
    Notesplash = Assets:WaitForChild("Notesplashes"),
    Holdsplash = AssetReplicator.getAsset("Holdsplashes")
};
local v3 = { "Global" };
local u4 = {
    All = "All",
    ["4K"] = "Arrows",
    ["4KAlt"] = "Arrows (Alt)",
    Boosts = "Boosts",
    BoostsAlt = "Boosts (Alt)",
    Specials = "Specials"
};

for i = 4, 18 do
    v3[i - 2] = tostring(i);
    local _ = i;
end;

function getSetFor(p5: userdata, p6: string)
    if p6 and p5 then
        local v7 = p6 or "";
        local v8 = p5:FindFirstChild(v7);

        if v8 then
            return v8;
        end;

        if v7 == "Plus" and not v8 then
            v7 = "rDown2";
            v8 = p5:FindFirstChild(v7);
        end;

        if v7 == "Square" and not v8 then
            v7 = "rUp2";
            v8 = p5:FindFirstChild(v7);
        end;

        if v8 then
            return v8;
        end;

        local v9 = p5:FindFirstChild((string.gsub(v7, "%A", "")));

        if v9 then
            return v9;
        end;

        if string.sub(v7, 1, 1) == "r" then
            local string_sub_ret = string.sub(v7, 2);
            local v10 = p5:FindFirstChild(string_sub_ret);

            if v10 then
                return v10;
            end;

            v9 = p5:FindFirstChild((string.gsub(string_sub_ret, "%A", "")));
        end;

        return v9;
    end;
end;

function getItem(p11, p12, p13)
    if p12 == "" then
        p12 = nil;
    end;

    if p13 == "" then
        p13 = nil;
    end;

    if not p11 then
        return;
    end;

    local v14 = p11:FindFirstChild(p13 or (p12 or ""));

    if v14 then
        if not ((not p13 or v14:GetAttribute("Pack")) and (p13 or not v14:GetAttribute("Pack"))) then
            return warn("[ShopV2/NoteskinOverrides] Invalid item", p12);
        end;

        if p13 then
            return v14:FindFirstChild(p12);
        end;

        return v14;
    end;
end;

function getSetAnims(p15: any, p16: string)
    -- upvalues: Sprite (copy)
    if p15 then
        local Attribute = p15:GetAttribute("Antialiasing");
        local v17 = tonumber(p15:GetAttribute("Framerate")) or 24;
        local v18 = tonumber(p15:GetAttribute("SizeMult")) or 1;
        local v19 = tonumber(p15:GetAttribute("Factor")) or 1;
        local v20 = {};

        if p16 == "Noteskin" then
            v20.idle = Sprite:GetAnimFramesByResults(p15, { "note0", "note alone0" }, v19, v18);
        elseif p16 == "Holdsplash" then
            v20.idle = Sprite:GetAnimFramesByResults(p15, { "Idle0" }, v19, v18);
        elseif p16 == "Notesplash" then
            v20.idle = Sprite:GetAnimFramesByResults(p15, { "splash0" }, v19, v18);
        end;

        v20._id = p15:GetAttribute("Image");
        v20._antialiasing = Attribute == nil and true or Attribute;
        v20._framerate = v17;

        return v20;
    end;
end;

function u1.new(u21) -- Line: 132
    -- upvalues: Signal (copy), u1 (copy), u4 (copy), Sprite (copy), TweenService (copy)
    local v22 = {
        selectedStrum = nil,
        selectedOverride = nil,
        keys = 18,
        setUsed = "Global",
        mode = "Noteskin",
        ui = u21,
        overrideData = {},
        uiOverrideMaps = {},
        spriteMaps = {},
        pageSprites = {},
        onSetSelected = Signal.new(),
        onReplace = Signal.new(),
        onClear = Signal.new(),
        onOverrideDataChanged = Signal.new()
    };
    local u23 = setmetatable(v22, u1);
    u21.CloseButton.MouseButton1Click:Connect(function() -- Line: 156
        -- upvalues: u23 (copy)
        u23:hide();
    end);
    u21.Buttons.ClearAll.MouseButton1Click:Connect(function() -- Line: 160
        -- upvalues: u23 (copy)
        u23.overrideData = {};
        u23.onClear:Fire();
        u23.onOverrideDataChanged:Fire();
        u23:render();
    end);
    u21.Buttons.ClearSelected.MouseButton1Click:Connect(function() -- Line: 168
        -- upvalues: u23 (copy)
        if not u23.selectedStrum then
            return;
        end;

        u23.overrideData[u23.selectedStrum] = nil;
        u23.onClear:Fire(u23.selectedStrum);
        u23.onOverrideDataChanged:Fire();
        u23:render();
    end);
    u21.Buttons.Replace.MouseButton1Click:Connect(function() -- Line: 178
        -- upvalues: u23 (copy)
        if not u23.selectedStrum then
            return;
        end;

        u23.overrideData[u23.selectedStrum] = u23.selectedOverride;
        u23.onReplace:Fire(u23.selectedStrum);
        u23.onOverrideDataChanged:Fire();
        u23:render();
    end);
    u21.PageName.GoBack.MouseButton1Click:Connect(function() -- Line: 188
        -- upvalues: u21 (copy)
        u21.List.UIPageLayout:Previous();
    end);
    u21.PageName.Advance.MouseButton1Click:Connect(function() -- Line: 192
        -- upvalues: u21 (copy)
        u21.List.UIPageLayout:Next();
    end);
    local UIPageLayout = u21.List.UIPageLayout;
    UIPageLayout:GetPropertyChangedSignal("CurrentPage"):Connect(function() -- Line: 198
        -- upvalues: UIPageLayout (copy), u21 (copy), u4 (ref)
        local CurrentPage = UIPageLayout.CurrentPage;
        u21.PageName.Text = CurrentPage and u4[CurrentPage.Name] or "Unknown Page";
    end);

    for _, child in u21.List:GetChildren() do
        if u4[child.Name] then
            local v24 = child;
            local v25 = {};

            for _, child2 in child:GetChildren() do
                if child2:IsA("ImageButton") then
                    local Name = child2.Name;
                    child2.MouseButton1Click:Connect(function() -- Line: 212
                        -- upvalues: u23 (copy), Name (copy)
                        u23:setSelectedStrum(Name);
                    end);
                    local v26 = u23.uiOverrideMaps[Name] or {};
                    v26[v24.Name] = child2;
                    u23.uiOverrideMaps[Name] = v26;
                    local v27 = Sprite.new(child2.Sprite, Vector2.new(155, 155), nil, nil, true);
                    v27.anchor = Vector2.new(0.5, 0.5);
                    v27.useFactorsForPosition = true;
                    v27.x = 77.5;
                    v27.y = 77.5;
                    local v28 = u23.spriteMaps[Name] or {};
                    v28[v24.Name] = v27;
                    u23.spriteMaps[Name] = v28;
                    v25[Name] = v27;
                end;
            end;

            u23.pageSprites[v24.Name] = v25;
        end;
    end;

    UIPageLayout:JumpTo(u21.List.All);
    u21.Header.HelpButton.MouseButton1Click:Connect(function() -- Line: 244
        -- upvalues: u21 (copy), TweenService (ref)
        u21.FrameGuide.BGSinking.Visible = true;
        TweenService:Create(u21.FrameGuide.BG, TweenInfo.new(0.1), {
            ImageTransparency = 0.95
        }):Play();
        TweenService:Create(u21.FrameGuide, TweenInfo.new(0.1), {
            BackgroundTransparency = 0.1
        }):Play();
        u21.FrameGuide.Content.Visible = true;
        u21.FrameGuide.Content.Position = UDim2.fromScale(0.5, 0.55);
        TweenService:Create(u21.FrameGuide.Content, TweenInfo.new(0.1), {
            Position = UDim2.fromScale(0.5, 0.5)
        }):Play();
    end);
    u21.FrameGuide.Content.OkDude.MouseButton1Click:Connect(function() -- Line: 253
        -- upvalues: u21 (copy), TweenService (ref)
        u21.FrameGuide.BGSinking.Visible = false;
        u21.FrameGuide.Content.Visible = false;
        TweenService:Create(u21.FrameGuide, TweenInfo.new(0.1), {
            BackgroundTransparency = 1
        }):Play();
        TweenService:Create(u21.FrameGuide.BG, TweenInfo.new(0.1), {
            ImageTransparency = 1
        }):Play();
    end);

    return u23;
end;

function u1.setKeys(p29) -- Line: 263
end;

function u1.show(p30) -- Line: 267
    p30.ui.Visible = true;
    p30:render();

    for _, v in p30.spriteMaps do
        for _, v2 in v do
            v2.active = true;
        end;
    end;
end;

function u1.hide(p31) -- Line: 278
    p31.ui.Visible = false;

    for _, v in p31.spriteMaps do
        for _, v2 in v do
            v2.active = false;
        end;
    end;
end;

function u1.changeMode(p32: table, p33: string, p34: table) -- Line: 287
    if p34 then
        p32.overrideData = p34;
    end;

    p32.ui.Header.Text = `Replace {p33} for Strum`;
    p32:setSelectedStrum(nil);
    p32.mode = p33;
    p32:render();
end;

function u1.setSelectedStrum(p35: table, p36: string) -- Line: 301
    p35.selectedStrum = p36;

    if p36 then
        p35.ui.ReplaceSelected.Text = `Replacing: {p36} [{p35.overrideData[p36] and (type(p35.overrideData[p36]) == "table" and p35.overrideData[p36][1] or p35.overrideData[p36]) or `Equipped {p35.mode}`}]`;

        return;
    end;

    p35.ui.ReplaceSelected.Text = "Replacing: None";
end;

function u1.setOverride(p37, p38) -- Line: 310
    p37.selectedOverride = p38;

    if not p38 then
        p37.ui.ReplaceWith.Text = `With: None (Select a {p37.mode}!)`;

        return;
    end;

    local ReplaceWith = p37.ui.ReplaceWith;

    if type(p38) == "table" then
        p38 = p38[1] or p38;
    end;

    ReplaceWith.Text = `With: {p38}`;
end;

function u1.render(p39) -- Line: 319
    -- upvalues: u2 (copy)
    for i, v in p39.uiOverrideMaps do
        local v40 = p39.overrideData[i];
        local v41 = nil;

        if v40 then
            local v42;

            if type(v40) == "table" then
                v42 = getItem(u2[p39.mode], v40[1], v40[2]);
            else
                v42 = getItem(u2[p39.mode], v40);
            end;

            local v43 = getSetFor(v42, i);

            if v43 then
                v41 = getSetAnims(v43, p39.mode);
            end;
        end;

        local v44 = i;

        for i2, v2 in v do
            v2.NonReplaced.Visible = not v40;
            local v45 = p39.spriteMaps[v44] and p39.spriteMaps[v44][i2];

            if v45 then
                v45.visible = v40 and true or false;

                if v41 then
                    v45:AddAnimation("idle", v41.idle, 24, true, v41._id);
                    v45.antialiasing = v41._antialiasing;
                    v45:Play("idle", true);
                end;
            end;
        end;
    end;
end;

function u1.load(p46: table, p47: table) -- Line: 357
    p46.overrideData = p47;
    p46:render();
end;

function u1.save(p48) -- Line: 362
    return p48.overrideData;
end;

return u1;