-- Decompiled with Potassium's decompiler.

local u1 = {};
local Events = game:GetService("ReplicatedStorage"):WaitForChild("Events");
local GuiService = game:GetService("GuiService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local StarterPlayer = game:GetService("StarterPlayer");
local ContextActionService = game:GetService("ContextActionService");
local GuiService2 = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
local ContentProvider = game:GetService("ContentProvider");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Events2 = ReplicatedStorage:WaitForChild("Events");
local Assets = ReplicatedStorage:WaitForChild("Assets");
local VirtualCursorManager = require(Modules.Other.VirtualCursorManager);
local DeviceManager = require(Modules.Main.DeviceManager);
local CacheService = require(Modules.Main.CacheService);
local DataManager = require(Modules.Data.DataManager);
local SoundLib = require(Modules.Audio.SoundLib);
local Signal = require(Modules.Lib.Signal);
local Scroll = require(Modules.Lib.Scroll);
local IconV2 = require(Modules.Main.IconV2);
local HoldSplash = require(Modules.Engine.VSRG.HoldSplash);
local NoteSplash = require(Modules.Engine.VSRG.NoteSplash);
local Sprite = require(Modules.Main.Sprite);
local Character = require(Modules.Main.Character);
local Translator = require(Modules.Main.Translator);
local TopbarIcon = require(Modules.UI.TopbarIcon);
local VarTweener = require(Modules.Main.VarTweener);
local AppearanceManager = require(Modules.Other.AppearanceManager);
local Overheads = require(Modules.UI.Overheads);
local AssetIcons = require(Modules.UI.AssetIcons);
local AssetReplicator = require(Modules.Main.AssetReplicator);
local Conductor = require(Modules.Main.Conductor);
local PlayerRanks = require(Modules.Other.PlayerRanks);
local ServerRequest = Events2.ServerRequests.ServerRequest;
local u2 = VirtualCursorManager.new();
local Shop = Translator.new("Shop", { "General", "Shop", "Difficulties", "CreditsReplacements", "Toggles", "Sides" });

local function _(...) -- Line: 138
    if not game:GetService("RunService"):IsStudio() then
        return;
    end;

    print(...);
end;

local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local u3 = PlayerRanks:isDev();
local OnUnlock = Events2.Engine.OnUnlock;
local TeleportAd = Events2:WaitForChild("TeleportAd");
local Data = DataManager:GetData();
local TopbarButtons = LocalPlayer.PlayerGui:WaitForChild("Main"):WaitForChild("TopbarButtons");
Lighting:WaitForChild("ShopDOF");
Lighting:WaitForChild("ShopBlur");
Vector2.new(1280, 720);
local u4 = {
    doubleClickWindow = 0.4,
    useGreenForFilters = false,
    fadeStyle = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    itemStatusDefaultStyle = {
        title = "",
        color = Color3.new(0.0980392, 0.0980392, 0.0980392),
        stroke = Color3.new(0.392157, 0.392157, 0.392157)
    },
    itemStatusNewStyle = {
        title = "NEW",
        color = Color3.new(0.435294, 1, 0),
        stroke = Color3.new(0, 0.615686, 0.686275)
    },
    itemStatusUpdatedStyle = {
        title = "UPDATED",
        color = Color3.new(1, 0.960784, 0),
        stroke = Color3.new(0.639216, 0.501961, 0.00392157)
    },
    filterDefaultStyle = {
        transparency = 0.6,
        color = Color3.new(0.0980392, 0.0980392, 0.0980392),
        stroke = Color3.new(0.392157, 0.392157, 0.392157)
    },
    filterEnabledStyle = {
        transparency = 0,
        color = Color3.fromRGB(50, 24, 0),
        stroke = Color3.fromRGB(255, 125, 0)
    },
    filterEnabledGreenStyle = {
        transparency = 0,
        color = Color3.fromRGB(5, 50, 0),
        stroke = Color3.fromRGB(0, 255, 0)
    },
    playerEquippedButtonStyle = {
        title = "EQUIPPED",
        color = Color3.fromRGB(19, 67, 111),
        stroke = Color3.new(0.141176, 0.380392, 0.588235)
    },
    playerEquipButtonStyle = {
        title = "EQUIP",
        color = Color3.new(0.243137, 0.635294, 1),
        stroke = Color3.new(0.141176, 0.380392, 0.588235)
    },
    botEquippedButtonStyle = {
        title = "EQUIPPED (BOT)",
        color = Color3.fromRGB(120, 55, 132)
    },
    botEquipButtonStyle = {
        title = "EQUIP (BOT)",
        color = Color3.new(0.784314, 0.415686, 1)
    },
    lockedButtonStyle = {
        title = "LOCKED",
        color = Color3.new(0.596078, 0, 0),
        stroke = Color3.new(0.262745, 0, 0)
    },
    defaultItemStyle = {
        transparency = 0.6,
        stroke = Color3.new(0.392157, 0.392157, 0.392157),
        color = Color3.new(0.0980392, 0.0980392, 0.0980392),
        gradient = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.196078, 0.196078, 0.196078)) }),
        strokeGradient = ColorSequence.new(Color3.new(1, 1, 1))
    },
    equippedItemStyle = {
        transparency = 0,
        stroke = Color3.new(0.027451, 0.823529, 1),
        color = Color3.new(0.027451, 0.823529, 1):Lerp(Color3.new(0, 0, 0), 0.8)
    },
    botEquippedItemStyle = {
        transparency = 0,
        stroke = Color3.new(0.862745, 0.447059, 1),
        color = Color3.new(0.862745, 0.447059, 1):Lerp(Color3.new(0, 0, 0), 0.8)
    },
    bothEquippedItemStyle = {
        transparency = 0,
        stroke = Color3.new(1, 1, 1),
        color = Color3.new(1, 1, 1):Lerp(Color3.new(0, 0, 0), 0.8),
        gradient = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.027451, 0.823529, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.862745, 0.447059, 1)) }),
        strokeGradient = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(0.027451, 0.823529, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.862745, 0.447059, 1)) })
    }
};
local _ = AppearanceManager.getExtraDataFrom;

function parseContent(p5)
    if not p5 then
        return Content.none;
    end;

    if typeof(p5) == "Content" then
        return p5;
    end;

    if type(p5) == "string" then
        return Content.fromUri(p5);
    end;

    return Content.fromAssetId(p5);
end;

function requestItem(p6: string, p7: string, p8: string?)
end;

function getItem(p9: string, p10: string, p11: string?)
    -- upvalues: AssetReplicator (copy), Assets (copy)
    if p10 == "" then
        p10 = nil;
    end;

    if p11 == "" then
        p11 = nil;
    end;

    if p9 == "Holdsplashes" then
        local Asset = AssetReplicator.getAsset(p9);

        if not Asset then
            return warn("[ShopV2] No item!!!");
        end;

        local v12 = Asset:FindFirstChild(p11 or (p10 or ""));

        if v12 then
            if not ((not p11 or v12:GetAttribute("Pack")) and (p11 or not v12:GetAttribute("Pack"))) then
                return warn("[ShopV2] Invalid item:", p10);
            end;

            if p11 then
                return v12:FindFirstChild(p10);
            end;

            return v12;
        end;
    else
        local v13 = Assets:FindFirstChild(p9);

        if not v13 then
            return warn("[ShopV2] No item!");
        end;

        local v14 = v13:FindFirstChild(p11 or (p10 or ""));

        if v14 then
            if not ((not p11 or v14:GetAttribute("Pack")) and (p11 or not v14:GetAttribute("Pack"))) then
                return warn("[ShopV2] Invalid item:", p10);
            end;

            if p11 then
                return v14:FindFirstChild(p10);
            end;

            return v14;
        end;
    end;
end;

local function isItemOwned(p15: table) -- Line: 403
    -- upvalues: Data (copy)
    if p15.unlocked or (p15.parentPack or p15).unlocked then
        return true;
    end;

    local category = p15.category;

    if not (category and (category.dataIndexes and category.dataIndexes.owned)) then
        return true;
    end;

    local v16 = Data[category.dataIndexes.owned];

    if v16 then
        return table.find(v16, (p15.parentPack or p15).name) and true or false;
    end;

    return false;
end;

function u1.isOwned(p17: any, p18: table) -- Line: 417
    -- upvalues: isItemOwned (copy)
    return isItemOwned(p18);
end;

local function getItemEquippedState(p19: table) -- Line: 421
    -- upvalues: Data (copy)
    local category = p19.category;

    if category and category.dataIndexes then
        local v20 = false;
        local v21;

        if category.dataIndexes.name then
            local v22;

            if p19.parentPack then
                v22 = p19.parentPack.name or nil;
            else
                v22 = nil;
            end;

            v21 = Data[category.dataIndexes.pack or ""] == v22 and Data[category.dataIndexes.name] == p19.name;
        else
            v21 = false;
        end;

        if category.dataIndexes.opName then
            local v23;

            if p19.parentPack then
                v23 = p19.parentPack.name or nil;
            else
                v23 = nil;
            end;

            v20 = Data[category.dataIndexes.opPack or ""] == v23 and Data[category.dataIndexes.opName] == p19.name;
        end;

        return v21 and v20 and "Both" or (v21 and "Player" or (v20 and "Bot" or nil));
    end;
end;

function u1.isEquipped(p24: any, p25: table) -- Line: 445
    -- upvalues: getItemEquippedState (copy)
    return getItemEquippedState(p25);
end;

function translateCredits(p26: string)
    -- upvalues: Shop (copy)
    for i, v in Shop.Default.CreditsReplacements do
        p26 = p26:gsub(v, Shop.Get("CreditsReplacements_" .. i));
    end;

    return p26;
end;

local v27 = { "", "ALT" };
local u28 = {};
local v29 = { "", "ALT" };

local function joinRequirements(p30) -- Line: 449
    -- upvalues: Shop (copy)
    if type(p30) == "string" then
        return p30;
    end;

    local v31 = "";
    local v32 = #p30;

    if v32 == 1 then
        return p30[1];
    end;

    for i = v32, 1, -1 do
        if i == 1 then
            break;
        end;

        local v33;

        if i == v32 then
            v31 = Shop.Format("Shop.RequirementsJoinEnding", {
                song1 = p30[i - 1],
                song2 = p30[i]
            });
            v33 = i;
        else
            v31 = Shop.Format("Shop.RequirementsJoin", {
                song1 = p30[i - 1],
                song2 = v31
            });
            v33 = i;
        end;
    end;

    return v31;
end;

local function translateDifficulties(p34) -- Line: 481
    -- upvalues: Shop (copy)
    if type(p34) == "string" then
        return Shop.GetOr("Difficulties_" .. p34, p34);
    end;

    for i, v in p34 do
        p34[i] = Shop.GetOr("Difficulties_" .. v, v);
    end;

    return p34;
end;

local function makeWarnHandler(p35) -- Line: 491
    return {
        visible = false,
        ui = p35,
        buttons = {},
        signals = {},
        cases = {},

        load = function(u36, p37, p38, p39) -- Line: 500, Name: load
            for _, v in u36.buttons do
                v:Destroy();
            end;

            for _, v in u36.signals do
                pcall(function() -- Line: 506
                    -- upvalues: v (copy)
                    v:Disconnect();
                end);
            end;

            table.clear(u36.buttons);
            table.clear(u36.signals);
            u36.cases = p37 or {};

            for _, v in p37 do
                local v40 = u36.ui.Content.ToolbarButNotToolbar.ButtonTemplate:Clone();
                v40.Text = v[1] or "IDK";
                v40.UIStroke.Color = v[2] or Color3.new(1, 1, 1);
                v40.Visible = true;
                table.insert(u36.signals, v40.MouseButton1Click:Connect(function() -- Line: 520
                    -- upvalues: u36 (copy), v (copy)
                    if not u36.visible then
                        return;
                    end;

                    u36:hide();

                    if v[3] then
                        v[3]();
                    end;
                end));
                table.insert(u36.buttons, v40);
                v40.Parent = u36.ui.Content.ToolbarButNotToolbar;
            end;

            u36.ui.Content.MainLabel.Text = p38 or "";
            u36.ui.Content.DescLabel.Text = p39 or "";
        end,

        show = function(p41) -- Line: 538, Name: show
            p41.ui.Content.Visible = true;
            p41.visible = true;
        end,

        hide = function(p42) -- Line: 544, Name: hide
            p42.ui.Content.Visible = false;
            p42.visible = false;
        end
    };
end;

local function renderIcon(p43: table, p44: userdata) -- Line: 319
    -- upvalues: IconV2 (copy), AssetIcons (copy)
    local Icon = p44.Icon;
    local customIcon = p43.customIcon;

    if customIcon then
        Icon.Visible = true;
        local v45 = IconV2.new(Icon, "L", nil);
        v45:LoadIcon(customIcon);
        v45.Position = UDim2.fromScale(0.5, 0.5);
        v45.Scale = Vector2.new(0.8, 0.8);

        return v45;
    end;

    local icon = p43.icon;

    if icon then
        Icon.Visible = true;

        return AssetIcons:render(Icon, icon, {
            scale = 0.8,
            fitFor = p43.category.name == "Banners" and Vector2.new(1280, 256) or Vector2.new(150, 150)
        });
    end;

    Icon.Visible = false;
end;

for _, v in { "Left", "Down", "Up", "Right" } do
    local v46 = v;

    for _, v2 in v27 do
        u28[v46 .. v2] = true;
    end;
end;

for _, v in { "Idle", "IdleLeft", "IdleRight" } do
    local v47 = v;

    for _, v2 in v29 do
        u28[v47 .. v2] = true;
    end;
end;

local function getItemAnimFolder(p48: table) -- Line: 579
    if p48.isPack then
        return nil;
    end;

    local category = p48.category;

    if not category then
        return nil;
    end;

    if category.name == "Animations" or category.name == "Emotes" then
        return getItem(category.name, p48.name, p48.parentPack and p48.parentPack.name or nil);
    end;

    return nil;
end;

local function collectExtraAnimNames(p49: userdata, p50: table) -- Line: 589
    -- upvalues: collectExtraAnimNames (copy), u28 (copy)
    for _, child in p49:GetChildren() do
        if child:IsA("Folder") then
            collectExtraAnimNames(child, p50);
        elseif not u28[child.Name] then
            p50[child.Name] = true;
        end;
    end;
end;

local function collectAltAnimNames(p51: userdata, p52: table) -- Line: 599
    -- upvalues: collectAltAnimNames (copy)
    for _, child in p51:GetChildren() do
        if child:IsA("Folder") then
            collectAltAnimNames(child, p52);
        elseif child.Name:sub(-3) == "ALT" and #child.Name > 3 then
            p52[child.Name:sub(1, -4)] = true;
        end;
    end;
end;

local function splitOrValues(p53: string) -- Line: 609
    local v54 = {};

    for i in (p53 .. "&"):gmatch("(.-)&") do
        local v55 = i:gsub("^%s+", ""):gsub("%s+$", "");

        if v55 ~= "" then
            local v56 = finalEscape(v55);
            table.insert(v54, v56:lower());
        end;
    end;

    return v54;
end;

local function itemHasAnimNameMatch(p57: table, p58: table, p59: any) -- Line: 622
    local v60;

    if p57.isPack then
        v60 = nil;
    else
        local category = p57.category;

        if category and (category.name == "Animations" or category.name == "Emotes") then
            v60 = getItem(category.name, p57.name, p57.parentPack and p57.parentPack.name or nil);
        else
            v60 = nil;
        end;
    end;

    if not v60 then
        return false;
    end;

    local v61 = {};
    p59(v60, v61);

    for i, _ in v61 do
        local v62 = i:lower();

        for _, v in p58 do
            if v62:find(v) then
                return true;
            end;
        end;
    end;

    return false;
end;

local function anyItemOrSubItemMatches(p63: table, p64: table, p65: any) -- Line: 641
    -- upvalues: itemHasAnimNameMatch (copy)
    if itemHasAnimNameMatch(p63, p64, p65) then
        return true;
    end;

    for _, v in p63.subItems do
        if itemHasAnimNameMatch(v, p64, p65) then
            return true;
        end;
    end;

    return false;
end;

function finalEscape(p66)
    return p66:gsub("[%-%.%+%[%]%(%)%$%^%%%?%*]", "%%%1");
end;

local u79 = {
    [">"] = function(p67, p68) -- Line: 694
        return p68 < p67;
    end,

    [">="] = function(p69, p70) -- Line: 697
        return p70 <= p69;
    end,

    ["<"] = function(p71, p72) -- Line: 700
        return p71 < p72;
    end,

    ["<="] = function(p73, p74) -- Line: 703
        return p73 <= p74;
    end,

    ["="] = function(p75, p76) -- Line: 708
        return p75 == p76;
    end,

    ["!="] = function(p77, p78) -- Line: 711
        return p77 ~= p78;
    end
};
local u145 = {
    name = function(p80: table, p81: any, p82: any, p83: any) -- Line: 718, Name: name
        local v84 = finalEscape(p81 or ""):lower();
        local v85 = p80.displayName:lower();
        local v86 = v85:gsub("%-", " ");
        local v87 = v85:find(v84) or v86:find(v84);

        if p82 == "!=" then
            v87 = not v87;
        end;

        for _, v in p80.subItems do
            if v87 then
                break;
            end;

            local v88 = v.displayName:lower();
            local v89 = v88:gsub("%-", " ");
            local v90 = v88:find(v84) or v89:find(v84);

            if p82 == "!=" then
                v90 = not v90;
            end;

            v87 = v87 or v90;
        end;

        return v87 and true or false;
    end,

    credits = function(p91: table, p92: any, p93: any) -- Line: 742, Name: credits
        local v94 = finalEscape(p92 or ""):lower();
        local v95;

        if p91.credits then
            v95 = p91.credits:lower():find(v94);

            if p93 == "!=" then
                v95 = not v95;
            end;
        else
            v95 = false;
        end;

        for _, v in p91.subItems do
            if v95 then
                break;
            end;

            if v.credits then
                local v96 = v.credits:lower():find(v94);

                if p93 == "!=" then
                    v96 = not v96;
                end;

                v95 = v95 or v96;
            end;
        end;

        return v95 and true or false;
    end,

    mod = function(p97: table, p98: any, p99: any) -- Line: 769, Name: mod
        local v100 = finalEscape(p98 or ""):lower();
        local v101 = false;
        local v102 = p97.unlockData and p97.unlockData.meta;

        if v102 then
            local v103;

            if v102.Mod == "__any" then
                v103 = false;
            else
                v103 = type(v102.Mod) == "string" and { v102.Mod } or v102.Mod;
            end;

            if v103 then
                for _, v in v103 do
                    local v104 = v:lower():find(v100, 1, true);

                    if p99 == "!=" then
                        v104 = not v104;
                    end;

                    v101 = v101 or v104;

                    if v101 then
                        break;
                    end;
                end;
            else
                v101 = v100 == "any";
            end;
        else
            v101 = v100 == "default";
        end;

        return v101 and true or false;
    end,

    new = function(p105: table, p106: any, p107: any) -- Line: 796, Name: new
        local isNew = p105.isNew;

        if p106 == "false" and true or p106 == "f" then
            isNew = not isNew;
        end;

        if p107 == "!=" then
            isNew = not isNew;
        end;

        return isNew and true or false;
    end,

    updated = function(p108: table, p109: any, p110: any) -- Line: 811, Name: updated
        local isUpdated = p108.isUpdated;

        for _, v in p108.subItems do
            if isUpdated then
                break;
            end;

            isUpdated = v.isUpdated;
        end;

        if p109 == "false" and true or p109 == "f" then
            isUpdated = not isUpdated;
        end;

        if p110 == "!=" then
            isUpdated = not isUpdated;
        end;

        return isUpdated and true or false;
    end,

    locked = function(p111: table, p112: any, p113: any) -- Line: 826, Name: locked
        -- upvalues: isItemOwned (copy)
        local v114 = not isItemOwned(p111);

        if p112 == "false" and true or p112 == "f" then
            v114 = not v114;
        end;

        if p113 == "!=" then
            v114 = not v114;
        end;

        return v114;
    end,

    unlocked = function(p115: table, p116: any, p117: any) -- Line: 836, Name: unlocked
        -- upvalues: isItemOwned (copy)
        local v118 = isItemOwned(p115);

        if p116 == "false" and true or p116 == "f" then
            v118 = not v118;
        end;

        if p117 == "!=" then
            v118 = not v118;
        end;

        return v118;
    end,

    favorited = function(p119: table, p120: any, p121: any) -- Line: 846, Name: favorited
        local favorited = p119.favorited;

        if p120 == "false" and true or p120 == "f" then
            favorited = not favorited;
        end;

        if p121 == "!=" then
            favorited = not favorited;
        end;

        return favorited;
    end,

    rigtype = function(p122: table, p123: any, p124: any) -- Line: 856, Name: rigtype
        if not p122.attributes then
            return;
        end;

        local v125 = p122.attributes[p123:lower()];

        for _, v in p122.subItems do
            if v125 then
                break;
            end;

            if v.attributes then
                v125 = v.attributes[p123:lower()];
            end;
        end;

        return v125;
    end,

    attribute = function(p126: table, p127: any, p128: any) -- Line: 870, Name: attribute
        if not p126.attributes then
            return;
        end;

        local v129 = p126.attributes[p127:lower()];

        for _, v in p126.subItems do
            if v129 then
                break;
            end;

            if v.attributes then
                v129 = v.attributes[p127:lower()];
            end;
        end;

        return v129;
    end,

    charammo = function(p130: table, p131: any, p132: any) -- Line: 884, Name: charammo
        -- upvalues: u79 (copy)
        if not p130.attributes then
            return;
        end;

        local v133 = tonumber(p131);
        local v134;

        if p130.attributes.charAmmo then
            v134 = u79[p132](p130.attributes.charAmmo, v133);
        else
            v134 = false;
        end;

        for _, v in p130.subItems do
            if v134 then
                break;
            end;

            if v.attributes and v.attributes.charAmmo then
                v134 = u79[p132](v.attributes.charAmmo, v133);
            end;
        end;

        return v134;
    end,

    hasevent = function(p135: table, p136: any, p137: any) -- Line: 904, Name: hasevent
        -- upvalues: splitOrValues (copy), anyItemOrSubItemMatches (copy), collectExtraAnimNames (copy)
        local v138 = (p136 or ""):lower();

        if v138 ~= "" and (v138 ~= "true" and (v138 ~= "false" and v138 ~= "t")) and v138 ~= "f" then
            local v139 = anyItemOrSubItemMatches(p135, splitOrValues(p136 or ""), collectExtraAnimNames);

            if p137 == "!=" then
                v139 = not v139;
            end;

            return v139 and true or false;
        end;

        if not p135.attributes then
            return false;
        end;

        local hasEvents = p135.attributes.hasEvents;

        for _, v in p135.subItems do
            if hasEvents then
                break;
            end;

            if v.attributes then
                hasEvents = v.attributes.hasEvents;
            end;
        end;

        if v138 == "false" and true or v138 == "f" then
            hasEvents = not hasEvents;
        end;

        if p137 == "!=" then
            hasEvents = not hasEvents;
        end;

        return hasEvents and true or false;
    end,

    hasalt = function(p140: table, p141: any, p142: any) -- Line: 934, Name: hasalt
        -- upvalues: splitOrValues (copy), anyItemOrSubItemMatches (copy), collectAltAnimNames (copy)
        local v143 = (p141 or ""):lower();

        if v143 ~= "" and (v143 ~= "true" and (v143 ~= "false" and v143 ~= "t")) and v143 ~= "f" then
            local v144 = anyItemOrSubItemMatches(p140, splitOrValues(p141 or ""), collectAltAnimNames);

            if p142 == "!=" then
                v144 = not v144;
            end;

            return v144 and true or false;
        end;

        if not p140.attributes then
            return false;
        end;

        local hasAlts = p140.attributes.hasAlts;

        for _, v in p140.subItems do
            if hasAlts then
                break;
            end;

            if v.attributes then
                hasAlts = v.attributes.hasAlts;
            end;
        end;

        if v143 == "false" and true or v143 == "f" then
            hasAlts = not hasAlts;
        end;

        if p142 == "!=" then
            hasAlts = not hasAlts;
        end;

        return hasAlts and true or false;
    end
};
local v146 = {
    update = "updated",
    isupdated = "updated",
    isupdate = "updated",
    added = "new",
    isnew = "new",
    lock = "locked",
    islock = "locked",
    islocked = "locked",
    unlock = "unlocked",
    isunlock = "unlocked",
    isunlocked = "unlocked",
    alt = "hasalt",
    hasalts = "hasalt",
    event = "hasevent",
    events = "hasevent",
    eventanim = "hasevent",
    eventanims = "hasevent",
    hasevents = "hasevent",
    source = "mod"
};
local v147 = {
    ["=="] = "=",
    ["~="] = "!="
};

for i, v in { "solo", "duo", "trio", "quartet", "quintet" } do
    u145[v] = function(p148: table, p149: any, p150: any) -- Line: 972
        -- upvalues: u145 (copy), i (copy)
        local v151 = true;

        if p149 == "false" and true or p149 == "f" then
            v151 = not v151;
        end;

        if p150 == "!=" then
            v151 = not v151;
        end;

        return u145.charammo(p148, i, v151 and "=" or "!=");
    end;
end;

for _, v in { "r15", "r6", "s15", "d15", "meshrig", { "huge", "ishuge" } } do
    local v152, u153;

    if type(v) == "table" then
        v152 = v[1];
        u153 = v[2];
    else
        v152 = v;
        u153 = v152;
        local v154 = v152;
        v152 = u153;
        v154 = u153;
    end;

    u145[v152] = function(p155: table, p156: any, p157: any) -- Line: 998
        -- upvalues: u153 (ref)
        if not p155.attributes then
            return;
        end;

        local v158 = p155.attributes[u153];

        for _, v2 in p155.subItems do
            if v158 then
                break;
            end;

            if v2.attributes then
                v158 = v2.attributes[u153];
            end;
        end;

        if p156 == "false" and true or p156 == "f" then
            v158 = not v158;
        end;

        if p157 == "!=" then
            v158 = not v158;
        end;

        return v158;
    end;
end;

for i, v in v146 do
    u145[i] = u145[v];
end;

for i, v in v147 do
    u79[i] = u79[v];
end;

function getCasesFromSearch(p159: string)
    -- upvalues: u79 (copy), u145 (copy)
    local v160 = {};

    for _, v in p159:split("&") do
        if v:match("[<>!=]+") or #v160 == 0 then
            table.insert(v160, v);
        else
            v160[#v160] = v160[#v160] .. "&" .. v;
        end;
    end;

    local v161 = {};

    for _, v in v160 do
        local v162 = v:gsub("^%s+", ""):gsub("%s+$", "");
        local v163 = v162:match("[<>!=]+");

        if v163 then
            v163 = v163:lower();
        end;

        if u79[v163] then
            local v164, v165 = unpack(v162:split(v163));
            local v166 = u145[v164:gsub("^%s+", ""):gsub("%s+$", ""):lower()];

            if v166 then
                local v167 = { v166, v165:gsub("^%s+", ""):gsub("%s+$", ""), v163 };
                table.insert(v161, v167);
            end;
        end;
    end;

    if #v161 == 0 then
        v161 = p159 ~= "" and {
            { u145.name, p159, "=" }
        } or v161;
    end;

    return v161;
end;

function makeSearchCase(p168, p169, p170)
    -- upvalues: u145 (copy)
    return { u145[p168], p169, p170 or "=" };
end;

function u1.new(p171, p172) -- Line: 1089
    -- upvalues: Shop (copy), GuiService (copy), makeWarnHandler (copy), Signal (copy), u1 (copy), u4 (copy), isItemOwned (copy), u3 (copy), ServerRequest (copy), DataManager (copy), OnUnlock (copy), getItemEquippedState (copy), renderIcon (copy), Scroll (copy), TeleportAd (copy)
    if not (p171 and p172) then
        return warn("[ShopV2] UI or Model wasn\'t passed!");
    end;

    local Fade = p171:FindFirstChild("Fade");
    local u173 = p171:FindFirstChild("Shop") or p171;
    u173.RootLocalizationTable = Shop.localizationTable;
    u173.Size = UDim2.new(1, 0, 1, -GuiService.TopbarInset.Height);
    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function() -- Line: 1099
        -- upvalues: u173 (ref), GuiService (ref)
        u173.Size = UDim2.new(1, 0, 1, -GuiService.TopbarInset.Height);
    end);
    local v174 = {};

    for _, child in script.Songs:GetChildren() do
        local v175 = child:Clone();
        v175.Parent = u173.BGM;
        table.insert(v174, v175);
    end;

    local v176 = {
        isInitialized = false,
        ui = u173,
        fadeUi = Fade,
        shopModel = p172,
        characters = {},
        cameraPos = CFrame.new(0, 0, 0),
        activeFilters = {
            onlyLocked = false,
            onlyUnlocked = false,
            onlyNew = false,
            onlyUpdated = false,
            onlyFavorited = false
        },
        reversedFilters = {
            onlyLocked = false,
            onlyUnlocked = false,
            onlyNew = false,
            onlyUpdated = false,
            onlyFavorited = false
        },
        hudPreviewData = {
            initialized = false,
            visibleIcons = true,
            visibleNoteskins = true,
            visibleNotesplashes = true,
            visibleHoldsplashes = true,
            iconL = nil,
            iconR = nil,
            currentHealth = 0.5,
            runningHealth = true,
            hud = u173:FindFirstChild("HUDPreview"),
            skinSprites = {
                holdsplashes = {},
                strums = {},
                notes = {},
                notesplashes = {}
            }
        },
        warnHandler = makeWarnHandler(u173.WarningSubstate),
        favoriteAdded = Signal.new(),
        favoriteRemoved = Signal.new(),
        onPress = Signal.new(),
        onRelease = Signal.new(),
        onShowStart = Signal.new(),
        onShow = Signal.new(),
        onHideStart = Signal.new(),
        onHide = Signal.new(),
        songList = v174,
        categories = {},
        items = {},
        itemsById = {},
        renderedSprites = {},
        renderedItems = {}
    };
    local u177 = setmetatable(v176, {
        __index = u1
    });
    local ItemList = u173.Main.Items.Base.ItemList;
    local PackScroll = u173.Packs.List.PackScroll;
    local Equips = u173.ItemInfo.Equips;

    local function applyEquippedStyleToButton(p178: any, p179: string?) -- Line: 1189
        -- upvalues: u4 (ref)
        local v180 = p179 and (p179 == "Player" and u4.equippedItemStyle or (p179 == "Bot" and u4.botEquippedItemStyle or u4.bothEquippedItemStyle)) or u4.defaultItemStyle;
        p178.BackgroundColor3 = v180.color;
        p178.UIStroke.Color = v180.stroke;
        p178.UIStroke.Transparency = v180.transparency;
        p178.UIGradient.Color = v180.gradient or u4.defaultItemStyle.gradient;
        p178.UIStroke.UIGradient.Color = v180.strokeGradient or u4.defaultItemStyle.strokeGradient;
    end;

    local function triggerEquip(p181: any, p182: table?) -- Line: 1199
        -- upvalues: u177 (copy), isItemOwned (ref), u3 (ref), ServerRequest (ref), DataManager (ref), Equips (copy), u4 (ref)
        local v183 = p182 or u177.curItem;

        if not v183 then
            return;
        end;

        if not isItemOwned(v183) then
            if not u3 then
                return;
            end;

            warn("Unlocking with devmode due to trying to equip a locked item", v183.name);
            local v184 = {
                Type = v183.category.name,
                Name = v183.parentPack and v183.parentPack.displayName or v183.displayName,
                IsPack = v183.parentPack and v183.parentPack.isPack or v183.isPack
            };
            local ItemIdentifier = u177:getItemIdentifier(v183.parentPack or v183);
            local v185 = u177.renderedItems[ItemIdentifier];

            if v185 then
                v185.obj.IsLocked.Visible = false;
                v185.item.unlocked = true;
            end;

            ServerRequest:FireServer("GimmeUnlockVro", v183.parentPack and v183.parentPack.unlockData or v183.unlockData, v184);
        end;

        if v183.isPack then
            return;
        end;

        local v186;

        if p181 then
            v186 = v183.category.dataIndexes.opName or "";
        else
            v186 = v183.category.dataIndexes.name;
        end;

        local v187 = p181 and v183.category.dataIndexes.opPack or v183.category.dataIndexes.pack;

        if not v186 or v186 == "" then
            return;
        end;

        DataManager:SetData(v186, v183.name);
        local v188;

        if v183.parentPack then
            v188 = v183.parentPack.name or nil;
        else
            v188 = nil;
        end;

        DataManager:SetData(v187, v188);
        local v189 = p181 and "onOpEquip" or "onEquip";

        if v183.category[v189] then
            v183.category[v189](v183);
        end;

        u177:renderItems();

        if v183.parentPack then
            u177:renderPackItems();
        end;

        if u177.curItem ~= v183 then
            return;
        end;

        local v190 = p181 and Equips.BotEquip or Equips.Equip;
        local v191 = p181 and u4.botEquippedButtonStyle or u4.playerEquippedButtonStyle;
        v190.BackgroundColor3 = v191.color;
        v190.Text = v191.title;

        if v191.stroke then
            v190.UIStroke.Color = v191.stroke;
        end;
    end;

    u177.baseType = {
        OnLoaded = function(u192: table, u193: any, p194: table) -- Line: 1268, Name: OnLoaded
            -- upvalues: u177 (copy), isItemOwned (ref), OnUnlock (ref), getItemEquippedState (ref), u4 (ref), triggerEquip (copy), applyEquippedStyleToButton (copy), renderIcon (ref), Shop (ref)
            p194.uniqueId = u177:getItemIdentifier(u192);
            u177.renderedItems[p194.uniqueId] = {
                obj = u193,
                item = u192
            };
            local category = u192.category;
            local u195 = -1;
            local u196 = 0;
            p194.clickedConnection = u193.MouseButton1Click:Connect(function() -- Line: 1280
                -- upvalues: u192 (copy), category (copy), isItemOwned (ref), u193 (copy), OnUnlock (ref), u177 (ref), getItemEquippedState (ref), u196 (ref), u195 (ref), u4 (ref), triggerEquip (ref)
                local v197 = tick();

                if (not u192.unlockData or u192.unlockData.type == "None") and (category.dataIndexes and (category.dataIndexes.owned and not isItemOwned(u192))) then
                    u193.IsLocked.Visible = false;
                    u192.unlocked = true;
                    OnUnlock:FireServer(u192.category.name, u192.isPack and {
                        pack = u192.name
                    } or {
                        name = u192.name
                    });
                end;

                u177:selectItem(u192);

                if category and category.onLeftClick then
                    category.onLeftClick(u192);
                end;

                local v198 = getItemEquippedState(u192);

                if v198 ~= "Player" and (v198 ~= "Both" and (u196 == 0 or v197 - u195 < u4.doubleClickWindow)) then
                    u196 = u196 + 1;

                    if u196 == 2 then
                        triggerEquip(false, u192);
                        u196 = 0;
                    end;
                end;

                u195 = v197;
            end);
            local u199 = -1;
            local u200 = 0;
            p194.rightClickedConnection = u193.MouseButton2Click:Connect(function() -- Line: 1315
                -- upvalues: getItemEquippedState (ref), u192 (copy), category (copy), u200 (ref), u199 (ref), u4 (ref), triggerEquip (ref)
                local v201 = tick();
                local v202 = getItemEquippedState(u192);

                if category and category.onRightClick then
                    category.onRightClick(u192);
                end;

                if v202 ~= "Bot" and (v202 ~= "Both" and (u200 == 0 or v201 - u199 < u4.doubleClickWindow)) then
                    u200 = u200 + 1;

                    if u200 == 2 then
                        triggerEquip(true, u192);
                        u200 = 0;
                    end;
                end;

                u199 = v201;
            end);
            u193.Favorite.Visible = not u192.parentPack and not u192.blockFavorite;
            u193.Favorite.Sprite.ImageColor3 = u192.favorited and Color3.fromRGB(255, 255, 255) or Color3.new(0, 0, 0);
            p194.favClicked = u193.Favorite.MouseButton1Click:Connect(function() -- Line: 1340
                -- upvalues: u192 (copy), u193 (copy), u177 (ref)
                u192.favorited = not u192.favorited;
                u193.Favorite.Sprite.ImageColor3 = u192.favorited and Color3.fromRGB(255, 255, 255) or Color3.new(0, 0, 0);

                if u192.favorited then
                    u177.favoriteAdded:Fire(u192.category.name, u192.name);
                else
                    u177.favoriteRemoved:Fire(u192.category.name, u192.name);
                end;

                u177:renderItems();
            end);
            local v203 = u192.isNew and u4.itemStatusNewStyle or (u192.isUpdated and u4.itemStatusUpdatedStyle or u4.itemStatusDefaultStyle);

            if v203 == u4.itemStatusDefaultStyle then
                u193.StatusLabel.Visible = false;
            else
                u193.StatusLabel.Visible = true;
                u193.StatusLabel.Text = v203.title;
                u193.StatusLabel.TextColor3 = v203.color or u4.itemStatusDefaultStyle.color;
                u193.StatusLabel.UIStroke.Color = v203.stroke or u4.itemStatusDefaultStyle.stroke;
            end;

            applyEquippedStyleToButton(u193, getItemEquippedState(u192));
            local v204 = isItemOwned(u192);
            u193.IsLocked.Visible = not v204;
            p194.iconRendered = renderIcon(u192, u193);

            if p194.iconRendered then
                u177.renderedSprites[p194.iconRendered] = true;
            end;

            local v205 = u192.isPack and u192.category and not u192.category.hidePackLabel;
            u193.Title.Text = v205 and Shop.RawFormat("Shop.PackItem", {
                packName = u192.displayName
            }) or u192.displayName;
            u193.Title.AutoLocalize = v205;

            if category and category.onDrawItem then
                category.onDrawItem(u193, u192);
            end;
        end,

        OnUnloaded = function(p206: any, p207: any, p208: table) -- Line: 1388, Name: OnUnloaded
            -- upvalues: u177 (copy)
            if p208.uniqueId then
                u177.renderedItems[p208.uniqueId] = nil;
                p208.uniqueId = nil;
            end;

            if p208.clickedConnection then
                p208.clickedConnection:Disconnect();
                p208.clickedConnection = nil;
            end;

            if p208.rightClickedConnection then
                p208.rightClickedConnection:Disconnect();
                p208.rightClickedConnection = nil;
            end;

            if p208.iconRendered then
                u177.renderedSprites[p208.iconRendered] = nil;
                p208.iconRendered:Destroy();
                p208.iconRendered = nil;
            end;

            if p208.favClicked then
                p208.favClicked:Disconnect();
                p208.favClicked = nil;
            end;
        end,

        Template = ItemList.Template,
        Size = ItemList.UIGridLayout.CellSize,
        Ratio = ItemList.UIGridLayout.UIAspectRatioConstraint.AspectRatio
    };
    ItemList.Template.Parent = nil;
    PackScroll.Template.Parent = nil;
    local v209 = Scroll.new(ItemList, nil, "Pooled");
    u177.defaultLayout = {
        maxCells = ItemList.UIGridLayout.FillDirectionMaxCells,
        fillDirection = ItemList.UIGridLayout.FillDirection,
        padding = ItemList.UIGridLayout.CellPadding,
        horizontalAlignment = ItemList.UIGridLayout.HorizontalAlignment,
        verticalAlignment = ItemList.UIGridLayout.VerticalAlignment
    };
    v209:setLayout(u177.defaultLayout);
    v209:setTypes({
        Item = u177.baseType
    });
    v209:setVisible(false);
    u177.itemScroll = v209;
    ItemList.UIGridLayout.Parent = nil;
    local v210 = Scroll.new(PackScroll, nil, "Pooled");
    v210:setLayout({
        isList = true,
        fillDirection = PackScroll.UIListLayout.FillDirection,
        padding = PackScroll.UIListLayout.Padding,
        horizontalAlignment = PackScroll.UIListLayout.HorizontalAlignment,
        verticalAlignment = PackScroll.UIListLayout.VerticalAlignment
    });
    v210:setTypes({
        Item = u177.baseType
    });
    v210:setVisible(false);
    u177.packItemsScroll = v210;
    PackScroll.UIListLayout.Parent = nil;

    local function setButtonState(p211: any, p212: boolean?) -- Line: 1446
        -- upvalues: u4 (ref)
        local v213 = p212 and (u4.useGreenForFilters and u4.filterEnabledGreenStyle or u4.filterEnabledStyle) or u4.filterDefaultStyle;
        p211.BackgroundColor3 = v213.color;
        p211.UIStroke.Color = v213.stroke;
        p211.UIStroke.Transparency = v213.transparency;
    end;

    u173.Main.Category.MouseButton1Click:Connect(function() -- Line: 1457
        -- upvalues: u173 (ref)
        u173.Main.Categories.Visible = not u173.Main.Categories.Visible;
    end);
    u173.Main.ViewCriteria.MouseButton1Click:Connect(function() -- Line: 1461
        -- upvalues: u173 (ref), u4 (ref)
        local v214 = not u173.ItemInfo.Criteria.Visible;
        u173.ItemInfo.Criteria.Visible = v214;
        local ViewCriteria = u173.Main.ViewCriteria;
        local v215 = v214 and (u4.useGreenForFilters and u4.filterEnabledGreenStyle or u4.filterEnabledStyle) or u4.filterDefaultStyle;
        ViewCriteria.BackgroundColor3 = v215.color;
        ViewCriteria.UIStroke.Color = v215.stroke;
        ViewCriteria.UIStroke.Transparency = v215.transparency;
    end);
    u173.ItemInfo.Criteria.Visible = true;
    local ViewCriteria = u173.Main.ViewCriteria;
    local v216 = u4.useGreenForFilters and u4.filterEnabledGreenStyle or (u4.filterEnabledStyle or u4.filterDefaultStyle);
    ViewCriteria.BackgroundColor3 = v216.color;
    ViewCriteria.UIStroke.Color = v216.stroke;
    ViewCriteria.UIStroke.Transparency = v216.transparency;

    for _, v in {
        { u173.Main.Filters.Favorited, "onlyFavorited" },
        {
            u173.Main.Filters.Locked,
            "onlyLocked",
            u173.Main.Filters.Unlocked,
            "onlyUnlocked"
        },
        {
            u173.Main.Filters.Unlocked,
            "onlyUnlocked",
            u173.Main.Filters.Locked,
            "onlyLocked"
        },
        { u173.Main.Filters.New, "onlyNew" },
        { u173.Main.Filters.Updated, "onlyUpdated" }
    } do
        if #v % 2 == 0 and #v ~= 0 then
            local u217 = v[1];
            local u218 = v[2];
            u217.MouseButton1Click:Connect(function() -- Line: 1487
                -- upvalues: u177 (copy), u218 (copy), u217 (copy), u4 (ref), v (copy)
                local v219 = not u177.activeFilters[u218];
                local v220 = u217;
                local v221 = v219 and (u4.useGreenForFilters and u4.filterEnabledGreenStyle or u4.filterEnabledStyle) or u4.filterDefaultStyle;
                v220.BackgroundColor3 = v221.color;
                v220.UIStroke.Color = v221.stroke;
                v220.UIStroke.Transparency = v221.transparency;

                if #v > 2 and v219 then
                    local v222 = 3;

                    while v[v222] do
                        local v223 = v[v222];
                        local v224 = v[v222 + 1];

                        if v224 == u218 then
                            warn("[ShopV2] PERO ESTO QUE ES");
                            v222 = v222 + 2;
                        else
                            if u177.activeFilters[v224] then
                                u177.activeFilters[v224] = false;
                                local filterDefaultStyle = u4.filterDefaultStyle;
                                v223.BackgroundColor3 = filterDefaultStyle.color;
                                v223.UIStroke.Color = filterDefaultStyle.stroke;
                                v223.UIStroke.Transparency = filterDefaultStyle.transparency;
                            end;

                            v222 = v222 + 2;
                        end;
                    end;
                end;

                u177.activeFilters[u218] = v219;
                u177:renderItems();
            end);
            u217.MouseButton2Click:Connect(function() -- Line: 1520, Name: toggleReverse
                -- upvalues: u177 (copy), u218 (copy), u217 (copy), u4 (ref)
                u177.reversedFilters[u218] = not u177.reversedFilters[u218];

                if u177.reversedFilters[u218] then
                    u177.activeFilters[u218] = true;
                end;

                local v225 = u217;
                local v226 = u177.activeFilters[u218] and (u4.useGreenForFilters and u4.filterEnabledGreenStyle or u4.filterEnabledStyle) or u4.filterDefaultStyle;
                v225.BackgroundColor3 = v226.color;
                v225.UIStroke.Color = v226.stroke;
                v225.UIStroke.Transparency = v226.transparency;
                u217.UIStroke.Thickness = u177.reversedFilters[u218] and 2 or 1;
                u177:renderItems();
            end);
            local u227 = 0;
            u217.InputBegan:Connect(function(p228) -- Line: 1536
                -- upvalues: u227 (ref), u177 (copy), u218 (copy), u217 (copy), u4 (ref)
                if p228.UserInputType ~= Enum.UserInputType.MouseButton1 and (p228.UserInputType ~= Enum.UserInputType.Touch and p228.UserInputType ~= Enum.UserInputType.Gamepad1) then
                    return;
                end;

                u227 = u227 + 1;
                local u229 = u227;
                task.delay(2, function() -- Line: 1546
                    -- upvalues: u229 (copy), u227 (ref), u177 (ref), u218 (ref), u217 (ref), u4 (ref)
                    if u229 ~= u227 then
                        return;
                    end;

                    u177.reversedFilters[u218] = not u177.reversedFilters[u218];

                    if u177.reversedFilters[u218] then
                        u177.activeFilters[u218] = true;
                    end;

                    local v230 = u217;
                    local v231 = u177.activeFilters[u218] and (u4.useGreenForFilters and u4.filterEnabledGreenStyle or u4.filterEnabledStyle) or u4.filterDefaultStyle;
                    v230.BackgroundColor3 = v231.color;
                    v230.UIStroke.Color = v231.stroke;
                    v230.UIStroke.Transparency = v231.transparency;
                    u217.UIStroke.Thickness = u177.reversedFilters[u218] and 2 or 1;
                    u177:renderItems();
                    u227 = u227 + 1;
                end);
            end);
            u217.InputEnded:Connect(function(p232) -- Line: 1553
                -- upvalues: u227 (ref)
                if p232.UserInputType ~= Enum.UserInputType.MouseButton1 and (p232.UserInputType ~= Enum.UserInputType.Touch and p232.UserInputType ~= Enum.UserInputType.Gamepad1) then
                    return;
                end;

                u227 = u227 + 1;
            end);
        else
            warn("[ShopV2] Filter is missing data!", v);
        end;
    end;

    Equips.Equip.MouseButton1Click:Connect(function() -- Line: 1565
        -- upvalues: triggerEquip (copy)
        triggerEquip();
    end);
    Equips.BotEquip.MouseButton1Click:Connect(function() -- Line: 1569
        -- upvalues: triggerEquip (copy)
        triggerEquip(true);
    end);
    u173.Main.Search.SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 1573
        -- upvalues: u177 (copy)
        u177:renderItems();
    end);
    u173.ItemInfo.Criteria.CheckOutPanel.Play.MouseButton1Click:Connect(function() -- Line: 1577
        -- upvalues: u177 (copy), TeleportAd (ref)
        local curItem = u177.curItem;

        if not curItem then
            return;
        end;

        local unlockData = curItem.unlockData;

        if not unlockData then
            return;
        end;

        local meta = unlockData.meta;

        if meta and (meta.BadgeInfo and unlockData.type == "Badge") then
            TeleportAd:FireServer(meta.BadgeInfo.UniverseInfo.Id);
        end;
    end);
    Shop.AsignTask(function() -- Line: 1590
        -- upvalues: u177 (copy)
        u177:updateUnlockData();
    end);

    return u177;
end;

function u1.getItemIdentifier(p233: table, p234: table) -- Line: 1598
    return (p234.category and (p234.category.name .. "_" or "") or "") .. (p234.parentPack and (p234.parentPack.name .. "_" or "") or "") .. p234.name;
end;

function u1.getIdentifierFrom(p235: table, p236: string, p237: string?, p238: string) -- Line: 1602
    -- upvalues: DataManager (copy), Data (copy)
    if p236:sub(1, 1) ~= "@" then
        return (p238 and p238 .. "_" or "") .. (p237 and p237 .. "_" or "") .. p236;
    end;

    local v239 = DataManager.getByPath(Data, p236:sub(2)) or p236;
    local v240 = p237 and DataManager.getByPath(Data, p237:sub(2)) or nil;

    return (p238 and p238 .. "_" or "") .. (v240 and v240 .. "_" or "") .. v239;
end;

function u1.makeTopbarIcon(u241) -- Line: 1613
    -- upvalues: TopbarIcon (copy), SoundLib (copy), Events (copy), TopbarButtons (copy)
    if u241.topbarIcon then
        return u241.topbarIcon;
    end;

    local u244 = TopbarIcon.new():setImage(6031265997):setImageScale(0.7):setLeft():setOrder(2):setLabel("Shop", "Viewing"):modifyTheme({
        { "IconLabel", "FontFace", Font.fromName("Montserrat", Enum.FontWeight.Bold, Enum.FontStyle.Normal) },
        { "IconLabel", "TextSize", 15 }
    }):bindEvent("viewingStarted", function() -- Line: 1626
        -- upvalues: SoundLib (ref)
        SoundLib:Play("Topbar/Hover");
    end):bindEvent("selected", function(p242) -- Line: 1629
        -- upvalues: SoundLib (ref), u241 (copy)
        if not shared.clientLoaded then
            return p242:deselect();
        end;

        SoundLib:Play("Topbar/Open");
        u241:show();
    end):bindEvent("deselected", function(p243) -- Line: 1634
        -- upvalues: SoundLib (ref), u241 (copy), Events (ref)
        if not shared.clientLoaded then
            return;
        end;

        SoundLib:Play("Topbar/Open");
        u241:hide();
        Events.Overheads.RefreshOverhead:FireServer();
    end);
    u244:setGroup("SystemButton_Left");
    TopbarButtons:GetAttributeChangedSignal("Disabled"):Connect(function() -- Line: 1644
        -- upvalues: TopbarButtons (ref), u244 (copy)
        local Attribute = TopbarButtons:GetAttribute("Disabled");
        u244:setEnabled(not Attribute);

        if Attribute then
            u244:deselect();
        end;
    end);
    u241.topbarIcon = u244;
    u244:setEnabled(not TopbarButtons:GetAttribute("Disabled"));
end;

function u1.makeCharacter(p245: table, p246: userdata, p247: string, p248: string, p249: string, p250) -- Line: 1658
    -- upvalues: Character (copy), AppearanceManager (copy), Data (copy)
    if not p246 then
        return warn("[ShopV2] Model was not passed!");
    end;

    local v251 = p247 or p246.Name;

    if p250 then
        p246:PivotTo(p250);
    end;

    local v252 = Character.newWithProps({
        asyncDescriptions = false,
        charModel = p246,
        side = p248,
        anim = p249 or nil,
        animAttributes = AppearanceManager.getExtraDataFrom(Data)
    });
    v252.destroyChar = false;
    p245:syncCharToBpm(v252);
    v252:Dance();
    p245.characters[v251] = v252;

    return v252;
end;

function u1.playAnim(p253: table, p254: any, p255: string) -- Line: 1684
    local v256;

    if type(p254) == "string" then
        v256 = p253.characters[p254] or p254;
    else
        v256 = p254;
    end;

    if type(v256) ~= "table" then
        return warn("[ShopV2] No Rig Found!", p254);
    end;

    v256:Play(p255, nil, nil, true);
end;

function u1.loadAnim(p257: table, p258: any, p259: any, p260: boolean?) -- Line: 1691
    -- upvalues: DataManager (copy), Data (copy), CacheService (copy)
    local v261;

    if type(p258) == "string" then
        v261 = p257.characters[p258] or p258;
    else
        v261 = p258;
    end;

    if type(v261) ~= "table" then
        return warn("[ShopV2] No Rig Found!", p258);
    end;

    local v262 = nil;

    if type(p259) == "table" then
        if p259.name:sub(1, 1) == "@" then
            local v263 = DataManager.getByPath(Data, p259.name:sub(2)) or p259.name;
            local v264;

            if p259.pack then
                v264 = DataManager.getByPath(Data, p259.pack:sub(2)) or nil;
            else
                v264 = nil;
            end;

            if p259.pack and p259.pack:sub(1, 1) ~= "@" then
                v264 = p259.pack;
            end;

            p259 = getItem(p260 and "Emotes" or "Animations", v263, v264);
        else
            p259 = getItem(p260 and "Emotes" or "Animations", p259.name, p259.pack);
        end;
    elseif typeof(p259) ~= "Instance" then
        p259 = v262;
    end;

    if p259 then
        if v261.latestAnim then
            local _ = v261.latestAnim == p259;
        end;

        v261:UnloadAllFromMemory();
        CacheService.clearAnims();
        v261:LoadAnim(p259, true);
        p257:syncCharToBpm(v261);
        v261.latestAnim = p259;
    end;
end;

function u1.reloadAnimationSettings(p265, p266) -- Line: 1725
    -- upvalues: AppearanceManager (copy), Data (copy)
    local v267;

    if type(p266) == "string" then
        v267 = p265.characters[p266] or p266;
    else
        v267 = p266;
    end;

    if type(v267) ~= "table" then
        return warn("[ShopV2] No Rig Found!", p266);
    end;

    v267.animAttributes = AppearanceManager.getExtraDataFrom(Data, nil, v267.isEmote and "Emote" or "Anim");

    if v267.latestAnim then
        p265:loadAnim(p266, v267.latestAnim);
    end;

    p265:syncCharToBpm(v267);
end;

function u1.selectCategory(p268: table, p269: table) -- Line: 1738
    if p268.curCat == p269 or not p269 then
        return;
    end;

    if p268.curCat and p268.curCat.onFocusLost then
        p268.curCat.onFocusLost(p269);
    end;

    p268.curCat = p269;
    local Category = p268.ui.Main.Category;
    Category.Icon.ImageContent = p269.icon;
    Category.Title.Text = p269.displayName;

    if p269.onFocus then
        p269.onFocus();
    end;

    p268.itemScroll.linkedScroll.CanvasPosition = Vector2.zero;

    if p269.ScrollLayout then
        local table_clone_ret = table.clone(p268.defaultLayout);

        for i, v in p269.ScrollLayout do
            table_clone_ret[i] = v;
        end;

        p268.itemScroll:setLayout(table_clone_ret);
    else
        p268.itemScroll:setLayout(p268.defaultLayout);
    end;

    p268:renderItems();
end;

function u1.selectItem(p270: table, p271: table) -- Line: 1766
    -- upvalues: Shop (copy), isItemOwned (copy), getItemEquippedState (copy), u4 (copy)
    if p270.curItem and p270.curItem ~= p271 then
        local category = p270.curItem.category;

        if category and category.onUnselected then
            category.onUnselected(p271);
        end;
    end;

    local Equips = p270.ui.ItemInfo.Equips;
    local Info = p270.ui.Main.Info;
    local List = p270.ui.Packs.List;

    if not p271 then
        Info.Desc.Title.Text = Shop.RawGet("Shop.UnselectedItemTitle");
        Info.Desc.Credits.Text = Shop.RawGet("Shop.UnselectedItemCredits");
        List.Title.Visible = true;
        Equips.Visible = false;
        p270.curItem = nil;
        p270.curPack = nil;
        p270:renderPackItems();

        return;
    end;

    if p270.curItem == p271 or p270.curPack == p271 then
        return;
    end;

    if p271.isPack then
        p270.curItem = nil;
        p270.curPack = p271;
    else
        p270.curItem = p271;
        p270.curPack = p271.parentPack;
    end;

    List.Title.Visible = not p270.curPack;
    p270:renderPackItems();
    Info.Desc.Title.Text = p271.displayName;
    Info.Desc.Credits.Text = p271.credits and (Shop.RawFormat("Shop.CreditsBy", {
        creatorName = translateCredits(p271.credits)
    }) or "") or "";
    local v272 = isItemOwned(p271);
    local category = p271.category;

    if category then
        if category.onSelected then
            category.onSelected(p271);
        end;

        if category.dataIndexes and (category.dataIndexes.name or category.dataIndexes.opName) and not p271.isPack then
            Equips.Visible = true;
            local v273 = getItemEquippedState(p271);
            local v274 = v272 and category.dataIndexes.opName and true or false;
            Equips.Equip.Visible = category.dataIndexes.name and true or not v272;
            Equips.BotEquip.Visible = v274;
            local v275 = v272 and ((v273 == "Player" or v273 == "Both") and u4.playerEquippedButtonStyle or u4.playerEquipButtonStyle) or u4.lockedButtonStyle;
            Equips.Equip.BackgroundColor3 = v275.color;
            Equips.Equip.UIStroke.Color = v275.stroke;
            Equips.Equip.Text = v275.title;

            if v274 then
                local v276 = (v273 == "Bot" or v273 == "Both") and u4.botEquippedButtonStyle or u4.botEquipButtonStyle;
                Equips.BotEquip.BackgroundColor3 = v276.color;
                Equips.BotEquip.Text = v276.title;
            end;
        else
            Equips.Visible = false;
        end;
    end;

    p270:updateUnlockData();
end;

function u1.updateUnlockData(p277) -- Line: 1845
    -- upvalues: joinRequirements (copy), Shop (copy), translateDifficulties (copy)
    local curItem = p277.curItem;

    if not curItem then
        return;
    end;

    local category = curItem.category;
    local unlockData = curItem.unlockData;
    local Criteria = p277.ui.ItemInfo.Criteria;
    local Unlock = Criteria.Unlock;
    local CheckOutPanel = Criteria.CheckOutPanel;
    CheckOutPanel.Visible = false;

    if unlockData and unlockData.type ~= "None" then
        local v278 = unlockData.meta or {};
        local type2 = unlockData.type;

        if v278.Description then
            Unlock.Condition.Text = unlockData.Description;
            Unlock.Requirement.Text = "";
            type2 = "";
        end;

        if type2 == "Match" then
            local v279 = v278.Mod ~= "__any" and joinRequirements(v278.Mod) or Shop.Shop_AnyModRequirement;
            local v280 = v278.Song ~= "__any" and joinRequirements(v278.Song) or Shop.Shop_AnySongRequirement;
            local v281 = v278.Difficulty ~= "__any" and joinRequirements(translateDifficulties(v278.Difficulty)) or Shop.Shop_AnyDiffRequirement;
            Unlock.Condition.Text = Shop.Format("Shop.UnlockRequirement", {
                songList = v280,
                modList = v279,
                difficultyList = v281
            });
            Unlock.Requirement.Text = Shop.Format("Shop.ExtraRequirement", {
                accuracyNeeded = category and category.unlockAccuracy or 70
            });

            return;
        end;

        if type2 == "Quest" then
            Unlock.Condition.Text = Shop.Format("Shop.DailyUnlockRequirement");
            Unlock.Requirement.Text = "";

            return;
        end;

        if type2 == "Badge" then
            local BadgeInfo = v278.BadgeInfo;

            if BadgeInfo then
                CheckOutPanel.Visible = true;
                CheckOutPanel.Background.ImageContent = Content.fromUri((`https://www.roblox.com/asset-thumbnail/image?assetId={BadgeInfo.UniverseInfo.Id}&width=1280&height=720&format=png`));
                CheckOutPanel.GameData.Creator.Text = Shop.RawFormat("Shop.CreditsBy", {
                    creatorName = ""
                });
                CheckOutPanel.GameData.Title.Text = BadgeInfo.UniverseInfo.Name;
                Unlock.Condition.Text = Shop.Format("Shop.BadgeUnlockRequirement", {
                    badgeName = BadgeInfo.Name,
                    gameName = BadgeInfo.UniverseInfo.Name
                });
            else
                Unlock.Condition.Text = Shop.Format("Shop.BadgeUnlockRequirement", {
                    badgeName = "UnknownBadge",
                    gameName = "UnknownGame"
                });
            end;

            Unlock.Requirement.Text = "";
        end;
    else
        Unlock.Condition.Text = Shop.Shop_UnlockedDefault;
    end;
end;

function u1.renderItems(p282) -- Line: 1902
    if not p282.curCat then
        return;
    end;

    local Text = p282.ui.Main.Search.SearchBox.Text;
    local v283 = getCasesFromSearch(Text == nil and "" or Text);

    if p282.activeFilters.onlyFavorited then
        table.insert(v283, makeSearchCase("favorited", "true", p282.reversedFilters.onlyFavorited and "!=" or "="));
    end;

    if p282.activeFilters.onlyNew then
        table.insert(v283, makeSearchCase("new", "true", p282.reversedFilters.onlyNew and "!=" or "="));
    end;

    if p282.activeFilters.onlyUpdated then
        table.insert(v283, makeSearchCase("updated", "true", p282.reversedFilters.onlyUpdated and "!=" or "="));
    end;

    if p282.activeFilters.onlyLocked then
        table.insert(v283, makeSearchCase("locked", "true", p282.reversedFilters.onlyLocked and "!=" or "="));
    end;

    if p282.activeFilters.onlyUnlocked then
        table.insert(v283, makeSearchCase("unlocked", "true", p282.reversedFilters.onlyUnlocked and "!=" or "="));
    end;

    local curCat = p282.curCat;
    local v284 = {};
    local v285 = next(v283) and true or false;
    local v286 = curCat.loadAllItems and p282.items or curCat.items;

    if curCat.getItems then
        v286 = curCat.getItems(v283) or v286;
    end;

    for _, v in v286 do
        if v.alwaysVisible then
            table.insert(v284, {
                item = v,
                type = v.itemType or "Item"
            });
        elseif not (v.hideOnSearch and v285) then
            local v287 = v;
            local v288 = true;

            for _, v2 in v283 do
                if not v288 then
                    break;
                end;

                v288 = v2[1](v287, v2[2], v2[3], v288, p282);
            end;

            if v288 then
                table.insert(v284, {
                    item = v287,
                    type = v287.itemType or "Item"
                });
            end;
        end;
    end;

    table.sort(v284, function(p289, p290) -- Line: 1945
        local item = p289.item;
        local item2 = p290.item;
        local sortPriority = item.sortPriority;
        local sortPriority2 = item2.sortPriority;

        if sortPriority ~= sortPriority2 then
            return sortPriority2 < sortPriority;
        end;

        local v291 = item2.displayName or item2.name;

        return (item.displayName or item.name):lower() < v291:lower();
    end);
    local v292 = {
        Item = p282.baseType
    };

    if curCat.itemTypes then
        for i, v in curCat.itemTypes do
            v292[i] = v;
        end;
    end;

    p282.itemScroll:setTypesAndItems(v292, v284);
end;

function u1.renderPackItems(p293) -- Line: 1968
    if not p293.curPack then
        return p293.packItemsScroll:setItems({});
    end;

    local curCat = p293.curCat;
    local v294 = {};

    for _, v in p293.curPack.subItems do
        table.insert(v294, {
            type = "Item",
            item = v
        });
    end;

    table.sort(v294, function(p295, p296) -- Line: 1978
        local item = p295.item;
        local item2 = p296.item;
        local sortPriority = item.sortPriority;
        local sortPriority2 = item2.sortPriority;

        if sortPriority ~= sortPriority2 then
            return sortPriority2 < sortPriority;
        end;

        local v297 = item2.displayName or item2.name;

        return (item.displayName or item.name):lower() < v297:lower();
    end);
    local v298 = {
        Item = p293.baseType
    };

    if curCat and curCat.packTypes then
        for i, v in curCat.packTypes do
            v298[i] = v;
        end;
    end;

    p293.packItemsScroll:setTypesAndItems(v298, v294);
end;

function u1.setSubmenuState(p299, p300) -- Line: 2001
    -- upvalues: TweenService (copy)
    local InsideSubmenuBG = p299.ui.InsideSubmenuBG;
    TweenService:Create(InsideSubmenuBG, TweenInfo.new(0.25), {
        BackgroundTransparency = p300 and 0.5 or 1,
        ImageTransparency = p300 and 0.8 or 1
    }):Play();
    InsideSubmenuBG.HitboxHold.Visible = p300 and true or false;
    p299.isSubmenu = p300 and true or false;
end;

function u1.setCategories(p301: table, p302: table) -- Line: 2010
    for _, v in p302 do
        p301:addCategory(v);
    end;
end;

function u1.allowRender(p303) -- Line: 2016
    p303.isInitialized = true;
    p303:goTo(1);
end;

function u1.goTo(p304, p305) -- Line: 2022
    if type(p305) == "number" then
        p305 = p304.categories[p305] or p305;
    end;

    p304:selectCategory(p305);
end;

function u1.addCategory(u306: table, u307: table) -- Line: 2026
    local v308 = #u306.categories + 1;
    u307.displayName = u307.displayName or u307.name;
    u307.icon = parseContent(u307.icon);
    u307.onSelected = u307.onSelected or function() -- Line: 2032
    end;
    u307.onFocus = u307.onFocus or function() -- Line: 2033
    end;
    u307.onFocusLost = u307.onFocusLost or function() -- Line: 2034
    end;

    for _, v in u307.items do
        u306:addItem(v, u307);
    end;

    table.insert(u306.categories, v308, u307);
    local Categories = u306.ui.Main.Categories;
    local v309 = Categories.Template:Clone();
    v309.Name = u307.name;
    v309.Title.Text = u307.displayName;
    v309.Icon.ImageContent = u307.icon;
    v309.Visible = true;
    v309.MouseButton1Click:Connect(function() -- Line: 2051
        -- upvalues: u306 (copy), u307 (copy)
        u306.ui.Main.Categories.Visible = false;
        u306:selectCategory(u307);
    end);
    v309.Parent = Categories;

    return u307;
end;

function u1.addItem(p310: table, p311: table, p312: table) -- Line: 2061
    -- upvalues: Overheads (copy), LocalPlayer (copy)
    p311.displayName = Overheads:formatTag(p311.displayName or p311.name, LocalPlayer.DisplayName);
    p311.isPack = p311.isPack;
    p311.category = p311.category or p312;
    p311.icon = p311.icon or Content.none;
    p311.prefix = p311.prefix or "";
    p311.sortPriority = p311.sortPriority or 1;
    p311.subItems = p311.subItems or {};

    for _, v in p311.subItems do
        v.parentPack = p311;
        p310:addItem(v, p312);
    end;

    if not p311.parentPack then
        table.insert(p310.items, p311);
    end;

    p310.itemsById[p310:getItemIdentifier(p311)] = p311;
end;

function u1.update(p313, p314) -- Line: 2084
    -- upvalues: Conductor (copy), workspace_CurrentCamera (copy)
    local hudPreviewData = p313.hudPreviewData;

    if p313.currentShopSong and p313.currentShopSong.IsPlaying then
        Conductor.SongPosition = p313.currentShopSong.TimePosition * 1000;
    end;

    if hudPreviewData.initialized then
        local Health = hudPreviewData.hud.Health;
        local currentHealth = hudPreviewData.currentHealth;
        local v315;

        if hudPreviewData.visibleIcons then
            local v316;

            if hudPreviewData.runningHealth then
                v316 = currentHealth + p314 / 8 * (hudPreviewData.healthFlipped and -1 or 1);

                if v316 >= 1 then
                    v316 = 1 - (v316 - 1);
                    hudPreviewData.healthFlipped = true;
                elseif v316 <= 0 then
                    v316 = -v316;
                    hudPreviewData.healthFlipped = false;
                end;

                Health.HealthDrag.Position = UDim2.fromScale(math.map(v316, 0, 1, 1, 0), 0.5);
            else
                v316 = math.map(Health.HealthDrag.Position.X.Scale, 0, 1, 1, 0);
            end;

            v315 = math.clamp(v316, 0, 1);
        else
            v315 = 0.5;
        end;

        Health.Player1.Position = UDim2.fromScale(1 - v315 - 0.0125, 0.5);
        Health.Player2.Position = UDim2.fromScale(1 - v315 + 0.0125, 0.5);
        Health.Container.Fill.Size = UDim2.fromScale(v315, 1);
        local iconL = hudPreviewData.iconL;
        local iconR = hudPreviewData.iconR;

        if v315 >= 0.8 then
            if iconL then
                iconL:ChangeState(v315 >= 0.95 and "Overlose" or "Lose");
            end;

            if iconR then
                iconR:ChangeState(v315 >= 0.95 and "Overwin" or "Win");
            end;
        elseif v315 <= 0.2 then
            if iconR then
                iconR:ChangeState(v315 <= 0.05 and "Overlose" or "Lose");
            end;

            if iconL then
                iconL:ChangeState(v315 <= 0.05 and "Overwin" or "Win");
            end;
        else
            if iconL then
                iconL:ChangeState("Idle");
            end;

            if iconR then
                iconR:ChangeState("Idle");
            end;
        end;

        hudPreviewData.currentHealth = v315;
    end;

    local InsideSubmenuBG = p313.ui.InsideSubmenuBG;

    if InsideSubmenuBG.Visible and InsideSubmenuBG.ImageTransparency ~= 1 then
        local v317 = tick() * 50 % 1655;
        InsideSubmenuBG.Position = UDim2.fromOffset(v317, v317);
    end;

    workspace_CurrentCamera.CFrame = p313.cameraPos;
end;

function getNoteSetData(p318: userdata)
    -- upvalues: Sprite (copy)
    if p318 then
        local Attribute = p318:GetAttribute("Antialiasing");
        local v319 = tonumber(p318:GetAttribute("Framerate")) or 24;
        local v320 = tonumber(p318:GetAttribute("SizeMult")) or 1;
        local v321 = tonumber(p318:GetAttribute("Factor")) or 1;

        return {
            static = Sprite:GetAnimFramesByResults(p318, { "receptor0", "receptor static0" }, v321, v320),
            confirm = Sprite:GetAnimFramesByResults(p318, { "receptor confirm0" }, v321, v320),
            press = Sprite:GetAnimFramesByResults(p318, { "receptor press0", "receptor pressed0" }, v321, v320),
            note = Sprite:GetAnimFramesByResults(p318, { "note0", "note alone0" }, v321, v320),
            hold = Sprite:GetAnimFramesByResults(p318, { "note hold piece0", "note hold0" }, v321, v320),
            holdend = Sprite:GetAnimFramesByResults(p318, { "note hold end0", "note holdend0", "note tail0" }, v321, v320),
            _id = p318:GetAttribute("Image"),
            _antialiasing = Attribute == nil and true or Attribute,
            _framerate = v319
        };
    end;
end;

function getNotesplashData(p322: userdata, p323: userdata?)
    -- upvalues: Sprite (copy)
    local v324 = p323 and p323:GetAttribute("Offset") or Vector2.new();
    local v325 = p322:GetAttribute("Offset") or Vector2.new();
    local v326 = tonumber(p322:GetAttribute("SizeMult")) or 1;
    local Attribute = p322:GetAttribute("Antialiasing");
    local _ = p322:GetAttribute("Underlay") or false;
    local v327 = tonumber(p322:GetAttribute("Factor")) or 1;
    local v328 = {};
    local v329 = {};

    for _, v in Sprite:GetAnimationsFromXml(p322) do
        local AnimFramesByResults = Sprite:GetAnimFramesByResults(p322, { v }, v327, v326);

        if AnimFramesByResults then
            local v330 = #v328;
            local v331 = "splash" .. (v330 == 0 and "" or v330);
            v329[v331] = AnimFramesByResults;
            table.insert(v328, v331);
        end;
    end;

    return {
        animations = v329,
        animNames = v328,
        id = p322:GetAttribute("Image"),
        offset = v324 + v325,
        isUnderlay = p322:GetAttribute("Underlay") or false,
        antialiasing = Attribute == nil and true or Attribute,
        framerate = p322:GetAttribute("Framerate") or 24
    };
end;

function getHoldsplashData(p332: userdata, p333: userdata?)
    -- upvalues: Sprite (copy)
    local v334 = p333 and p333:GetAttribute("Offset") or Vector2.new();
    local v335 = p332:GetAttribute("Offset") or Vector2.new();
    local v336 = tonumber(p332:GetAttribute("SizeMult")) or (p333 and (tonumber(p333:GetAttribute("SizeMult")) or 1) or 1);
    local v337 = tonumber(p332:GetAttribute("Factor")) or (p333 and (tonumber(p333:GetAttribute("Factor")) or 1) or 1);
    local Attribute = p332:GetAttribute("Antialiasing");
    local Attribute2 = p332:GetAttribute("Underlay");

    if Attribute2 == nil then
        if p333 then
            Attribute2 = p333:GetAttribute("Underlay") or false;
        else
            Attribute2 = false;
        end;
    end;

    if Attribute2 == nil then
        Attribute2 = false;
    end;

    local v338 = {};
    local v339 = {};

    for i, v in { "0", "ALT0" } do
        local v340 = i - 1;
        local v341 = v340 == 0 and "" or "alt" .. v340 .. "_";
        local v342 = {
            intro = Sprite:GetAnimFramesByResults(p332, { "Start" .. v }, v337, v336),
            holding = Sprite:GetAnimFramesByResults(p332, { "Idle" .. v }, v337, v336),
            release = Sprite:GetAnimFramesByResults(p332, { "End" .. v }, v337, v336)
        };

        if v342.holding then
            v338[v341] = v342;
            table.insert(v339, v341);
        end;
    end;

    return {
        animationSets = v338,
        setsName = v339,
        id = p332:GetAttribute("Image"),
        offset = v334 + v335,
        isUnderlay = Attribute2,
        antialiasing = Attribute == nil and true or Attribute,
        framerate = tonumber(p332:GetAttribute("Framerate")) or (p333 and tonumber(p333:GetAttribute("Framerate")) or 24)
    };
end;

function u1.initHUDPreview(u343) -- Line: 2261
    -- upvalues: IconV2 (copy), Sprite (copy), NoteSplash (copy), HoldSplash (copy)
    local hudPreviewData = u343.hudPreviewData;

    if hudPreviewData.initialized then
        return;
    end;

    if not hudPreviewData.hud then
        return;
    end;

    local Health = hudPreviewData.hud.Health;
    local u344 = nil;
    Health.HealthDrag.UIDragDetector.DragStart:Connect(function() -- Line: 2271
        -- upvalues: u344 (ref), hudPreviewData (copy)
        if u344 then
            task.cancel(u344);
            u344 = nil;
        end;

        hudPreviewData.runningHealth = false;
    end);
    Health.HealthDrag.UIDragDetector.DragEnd:Connect(function() -- Line: 2277
        -- upvalues: u344 (ref), hudPreviewData (copy)
        u344 = task.delay(3, function() -- Line: 2278
            -- upvalues: hudPreviewData (ref), u344 (ref)
            hudPreviewData.runningHealth = true;
            u344 = nil;
        end);
    end);

    for _, v in { "L", "R" } do
        local v345 = IconV2.new(Health[v == "L" and "Player1" or "Player2"].Sprite, v, nil);
        v345.Position = UDim2.fromScale(0.5, 0.5);
        v345.Scale = Vector2.new(1.75, 1.75);
        (v == "L" and Health.Container or Health.Container.Fill).BackgroundColor3 = v345.iconColor;
        v345.active = false;
        hudPreviewData["icon" .. v] = v345;
    end;

    local Receptors = hudPreviewData.hud.Receptors;

    for i, v in { "Left", "Down", "Up", "Right" } do
        local UDim2_fromScale_ret = UDim2.fromScale(-0.25 + 0.5 * (i - 1), 0.5);
        local Vector2_new_ret = Vector2.new(0.5, 0.5);
        local Vector2_new_ret2 = Vector2.new(4, 4);
        local v346 = Sprite.new(Receptors.Confirm[v], nil, false, false);
        local v347 = Sprite.new(Receptors.Down[v], nil, false, false);
        local u348 = NoteSplash.new();
        local u349 = HoldSplash.new();
        u348:SetObj(Receptors.Splashes[v]);
        u348.parent = Receptors.Splashes;
        u349:SetObj(Receptors.Holds[v]);
        u349.parent = Receptors.Holds;
        v346.Scale = Vector2_new_ret2;
        v347.Scale = Vector2_new_ret2;
        u348.Scale = Vector2_new_ret2;
        u349.Scale = Vector2_new_ret2;
        v346.Position = UDim2_fromScale_ret;
        v347.Position = UDim2_fromScale_ret;
        u348.Position = UDim2_fromScale_ret;
        u349.Position = UDim2_fromScale_ret;
        v346.AnchorPoint = Vector2_new_ret;
        v347.AnchorPoint = Vector2_new_ret;
        u348.AnchorPoint = Vector2_new_ret;
        u349.AnchorPoint = Vector2_new_ret;
        v346.active = false;
        v347.active = false;
        u348.active = false;
        u349.active = false;
        v347.Obj.TextButton.MouseButton1Down:Connect(function() -- Line: 2325
            -- upvalues: u343 (copy), v (copy)
            u343.onPress:Fire("Direction", v);
        end);
        v347.Obj.TextButton.MouseButton1Up:Connect(function() -- Line: 2328
            -- upvalues: u343 (copy), v (copy)
            u343.onRelease:Fire("Direction", v);
        end);
        v346.Obj.TextButton.MouseButton1Down:Connect(function() -- Line: 2331
            -- upvalues: u343 (copy), v (copy)
            u343.onPress:Fire("Direction", v);
        end);
        v346.Obj.TextButton.MouseButton1Up:Connect(function() -- Line: 2334
            -- upvalues: u343 (copy), v (copy)
            u343.onRelease:Fire("Direction", v);
        end);
        u348.visible = false;
        u349.visible = false;
        u348.AnimationStarted:Connect(function() -- Line: 2341
            -- upvalues: u348 (copy)
            u348.visible = true;
        end);
        u348.AnimationEnded:Connect(function() -- Line: 2344
            -- upvalues: u348 (copy)
            u348.visible = false;
        end);
        u349.AnimationStarted:Connect(function() -- Line: 2349
            -- upvalues: u349 (copy)
            u349.visible = true;
        end);
        u349.AnimationEnded:Connect(function(p350) -- Line: 2352
            -- upvalues: u349 (copy)
            if p350:sub(1, 7) == "release" then
                u349.visible = false;
            end;
        end);
        hudPreviewData.skinSprites.strums[v] = v347;
        hudPreviewData.skinSprites.notes[v] = v346;
        hudPreviewData.skinSprites.notesplashes[v] = u348;
        hudPreviewData.skinSprites.holdsplashes[v] = u349;
    end;

    hudPreviewData.initialized = true;
end;

function u1.syncCharToBpm(p351, p352) -- Line: 2368
    -- upvalues: Data (copy), Conductor (copy), ContentProvider (copy)
    if not (p352 and p352.currentAnim) then
        return;
    end;

    local v353 = p352.sideAttributes or {};

    if v353.NoIdleSync then
        return;
    end;

    if not Data.SyncAnimationToBPM or Conductor.BPM <= 0 then
        for _, v in p352:GetIdles() do
            v:AdjustSpeed(1);
        end;

        return;
    end;

    local v354 = tonumber(v353.IdleBeat or 1);
    local u355 = Conductor.Crochet / 500 / 1 * v354;
    local u356 = Conductor.lastBPMChange or Conductor.BPM;

    for _, v in p352:GetIdles() do
        task.spawn(function() -- Line: 2387
            -- upvalues: v (copy), ContentProvider (ref), Conductor (ref), u356 (copy), u355 (copy)
            if v.Length == 0 then
                ContentProvider:PreloadAsync({ v.Animation });
                task.wait();
            end;

            if Conductor.lastBPMChange and u356 ~= Conductor.lastBPMChange then
                return;
            end;

            v:AdjustSpeed(v.Length / u355);
            v.TimePosition = (Conductor.SongPosition - (Conductor.lastBPMChange and Conductor.lastBPMChange.songTime or 0)) / 1000 % u355 / u355 * v.Length;
        end);
    end;
end;

function u1.setHUDPreview(p357: table, p358: table) -- Line: 2405
    local _ = p357.hudPreviewData;
end;

function u1.loadPreviewNoteskin(p359, p360, p361) -- Line: 2409
    -- upvalues: DataManager (copy), Data (copy)
    local hudPreviewData = p359.hudPreviewData;
    local v362 = nil;

    if type(p360) == "string" and p360:sub(1, 1) == "@" then
        local v363 = DataManager.getByPath(Data, p360:sub(2)) or p360;
        local v364 = p361 and DataManager.getByPath(Data, p361:sub(2)) or nil;
        p360 = getItem("Noteskins", v363, v364);
    elseif type(p360) == "string" then
        p360 = getItem("Noteskins", p360, p361);
    elseif typeof(p360) ~= "Instance" then
        p360 = v362;
    end;

    if not p360 then
        return warn("[ShopV2] No noteskin file found!");
    end;

    for _, v in { "Left", "Down", "Up", "Right" } do
        local v365 = p360:FindFirstChild(v);

        if v365 then
            local v366 = getNoteSetData(v365);
            local v367 = hudPreviewData.skinSprites.strums[v];
            local v368 = hudPreviewData.skinSprites.notes[v];

            if v367 then
                v367:AddAnimation("static", v366.static, 24, true, v366._id);
                v367:AddAnimation("pressed", v366.press, 24, false, v366._id);
                v367.antialiasing = v366._antialiasing;
                v367:Play("static", true);
            end;

            if v368 then
                v368:AddAnimation("static", v366.note, 24, true, v366._id);
                v368:AddAnimation("pressed", v366.confirm, 24, false, v366._id);
                v368.antialiasing = v366._antialiasing;
                v368:Play("static", true);
            end;
        else
            warn("[ShopV2] Noteskin doesn\'t have direction", v);
        end;
    end;
end;

function u1.loadPreviewNotesplash(p369, p370, p371) -- Line: 2456
    -- upvalues: DataManager (copy), Data (copy), NoteSplash (copy)
    local hudPreviewData = p369.hudPreviewData;
    local v372 = nil;

    if type(p370) == "string" and p370:sub(1, 1) == "@" then
        local v373 = DataManager.getByPath(Data, p370:sub(2)) or p370;
        local v374 = p371 and DataManager.getByPath(Data, p371:sub(2)) or nil;
        p370 = getItem("Notesplashes", v373, v374);
    elseif type(p370) == "string" then
        p370 = getItem("Notesplashes", p370, p371);
    elseif typeof(p370) ~= "Instance" then
        p370 = v372;
    end;

    if not p370 then
        return warn("[ShopV2] No notesplash file found!");
    end;

    for _, v in { "Left", "Down", "Up", "Right" } do
        local v375 = p370:FindFirstChild(v);

        if v375 then
            local v376 = hudPreviewData.skinSprites.notesplashes[v];

            if v376 then
                local SkinData = NoteSplash:getSkinData(v375, p370);

                if SkinData then
                    v376:loadSkin(SkinData);
                end;
            end;
        else
            warn("[ShopV2] Notesplash doesn\'t have direction", v, p370);
        end;
    end;
end;

function u1.loadPreviewHoldsplash(p377, p378, p379) -- Line: 2491
    -- upvalues: DataManager (copy), Data (copy), HoldSplash (copy)
    local hudPreviewData = p377.hudPreviewData;
    local v380 = nil;

    if type(p378) == "string" and p378:sub(1, 1) == "@" then
        local v381 = DataManager.getByPath(Data, p378:sub(2)) or p378;
        local v382 = p379 and DataManager.getByPath(Data, p379:sub(2)) or nil;
        p378 = getItem("Holdsplashes", v381, v382);
    elseif type(p378) == "string" then
        p378 = getItem("Holdsplashes", p378, p379);
    elseif typeof(p378) ~= "Instance" then
        p378 = v380;
    end;

    if not p378 then
        return warn("[ShopV2] No Holdsplash file found!");
    end;

    for _, v in { "Left", "Down", "Up", "Right" } do
        local v383 = p378:FindFirstChild(v);

        if v383 then
            local v384 = hudPreviewData.skinSprites.holdsplashes[v];

            if v384 then
                local SkinData = HoldSplash:getSkinData(v383, p378);

                if SkinData then
                    v384:loadSkin(SkinData);
                end;
            end;
        else
            warn("[ShopV2] Holdsplash doesn\'t have direction", v, p378);
        end;
    end;
end;

function u1.loadPreviewIcon(p385, p386, p387, p388) -- Line: 2526
    -- upvalues: DataManager (copy), Data (copy)
    local hudPreviewData = p385.hudPreviewData;

    if type(p386) == "string" then
        p386 = hudPreviewData["icon" .. p386];
    end;

    if not p386 then
        return warn("[ShopV2] there\'s no icon lil vro");
    end;

    if type(p387) == "string" and p387:sub(1, 1) == "@" then
        local v389 = DataManager.getByPath(Data, p387:sub(2)) or p387;

        if p388 then
            p388 = DataManager.getByPath(Data, p388:sub(2)) or p388;
        end;

        p386:LoadIcon(v389, p388);
    else
        p386:LoadIcon(p387, p388);
    end;

    local Health = hudPreviewData.hud.Health;
    (p386.side == "L" and Health.Container or Health.Container.Fill).BackgroundColor3 = p386.iconColor;
end;

function u1.enableHUDSprites(p390) -- Line: 2549
    local hudPreviewData = p390.hudPreviewData;

    if hudPreviewData.visibleIcons then
        if hudPreviewData.iconL then
            hudPreviewData.iconL.active = true;
        end;

        if hudPreviewData.iconR then
            hudPreviewData.iconR.active = true;
        end;
    end;

    if hudPreviewData.visibleNoteskins then
        for _, v in hudPreviewData.skinSprites.strums do
            v.active = true;
        end;

        for _, v in hudPreviewData.skinSprites.notes do
            v.active = true;
        end;
    end;

    if hudPreviewData.visibleNotesplashes then
        for _, v in hudPreviewData.skinSprites.notesplashes do
            v.active = true;
        end;
    end;

    if hudPreviewData.visibleHoldsplashes then
        for _, v in hudPreviewData.skinSprites.holdsplashes do
            v.active = true;
        end;
    end;
end;

function u1.disableHUDSprites(p391) -- Line: 2579
    local hudPreviewData = p391.hudPreviewData;

    if hudPreviewData.iconL then
        hudPreviewData.iconL.active = false;
    end;

    if hudPreviewData.iconR then
        hudPreviewData.iconR.active = false;
    end;

    for _, v in hudPreviewData.skinSprites do
        for _, v2 in v do
            v2.active = false;
        end;
    end;
end;

function u1.moveCamTo(p392: table, p393, p394: boolean?) -- Line: 2592
    -- upvalues: VarTweener (copy)
    if typeof(p393) == "Instance" then
        p393 = p393.CFrame;
    end;

    VarTweener:Create(p392, TweenInfo.new(p394 and 0 or 1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        cameraPos = p393
    }):Play();
end;

local u395 = {
    AltSwitch = true,
    TauntKeybind = true
};

function u1.registerBinds(u396) -- Line: 2605
    -- upvalues: DeviceManager (copy), Data (copy), ContextActionService (copy), u395 (copy)
    if DeviceManager.currentDevice == "Mobile" then
        return;
    end;

    local v397 = DeviceManager.currentDevice == "Console" and Data.ConsoleKeybinds or Data.Keybinds;
    local v398 = {};

    for i, v in v397["4"] or {} do
        local v399 = {};
        local u400;

        if type(v) == "table" then
            u400 = i;

            for _, v2 in v do
                v399[#v399 + 1] = Enum.KeyCode:FromName(v2) or Enum.UserInputType:FromName(v2);
            end;
        else
            v399[1] = Enum.KeyCode:FromName(v) or Enum.UserInputType:FromName(v);
            u400 = i;
        end;

        if next(v399) then
            ContextActionService:BindActionAtPriority("Shop_Input_" .. u400, function(p401: string, p402: any, p403: any) -- Line: 2623, Name: handler
                -- upvalues: u396 (copy), u400 (copy)
                if p402 == Enum.UserInputState.Begin then
                    u396.onPress:Fire("Direction", u400);

                    return;
                end;

                u396.onRelease:Fire("Direction", u400);
            end, false, 9999, unpack(v399));
            table.insert(v398, "Shop_Input_" .. u400);
        end;
    end;

    for i, v in v397.Miscellaneous or {} do
        if u395[i] then
            local v404 = {};
            local u405;

            if type(v) == "table" then
                u405 = i;

                for _, v2 in v do
                    v404[#v404 + 1] = Enum.KeyCode:FromName(v2) or Enum.UserInputType:FromName(v2);
                end;
            else
                v404[1] = Enum.KeyCode:FromName(v) or Enum.UserInputType:FromName(v);
                u405 = i;
            end;

            if next(v404) then
                ContextActionService:BindActionAtPriority("Shop_Input_" .. u405, function(p406: string, p407: any, p408: any) -- Line: 2650, Name: handler
                    -- upvalues: u396 (copy), u405 (copy)
                    if p407 == Enum.UserInputState.Begin then
                        u396.onPress:Fire("Action", u405);

                        return;
                    end;

                    u396.onRelease:Fire("Action", u405);
                end, false, 9999, unpack(v404));
                table.insert(v398, "Shop_Input_" .. u405);
            end;
        end;
    end;

    u396.currentBindings = v398;
end;

function u1.removeBinds(p409) -- Line: 2666
    -- upvalues: ContextActionService (copy)
    local currentBindings = p409.currentBindings;

    if not currentBindings then
        return;
    end;

    for _, v in currentBindings do
        ContextActionService:UnbindAction(v);
    end;
end;

function u1.fadeInMusic(p410) -- Line: 2675
    -- upvalues: Data (copy), Conductor (copy), TweenService (copy)
    if #p410.songList < 1 or not Data.ShopMusic then
        return;
    end;

    local v411 = p410.songList[math.random(#p410.songList)];
    local v412 = v411:GetAttribute("BPM") or 120;

    if Conductor.ChangeBPM then
        Conductor:ChangeBPM(v412);
    elseif Conductor.SetBPM then
        Conductor:SetBPM(v412);
    else
        Conductor.BPM = v412;
        Conductor.Crochet = 60 / v412 * 1000;
    end;

    p410.currentShopSong = v411;
    TweenService:Create(v411, TweenInfo.new(0.75, Enum.EasingStyle.Exponential), {
        Volume = 0.5
    }):Play();
    v411:Play();
end;

function u1.fadeOutMusic(p413) -- Line: 2695
    -- upvalues: TweenService (copy)
    if #p413.songList < 1 then
        return;
    end;

    for _, v in p413.songList do
        local v414 = TweenService:Create(v, TweenInfo.new(0.75, Enum.EasingStyle.Exponential), {
            Volume = 0
        });
        v414.Completed:Once(function() -- Line: 2700
            -- upvalues: v (copy)
            v:Stop();
        end);
        v414:Play();
    end;
end;

function u1.setFavorites(p415, p416) -- Line: 2708
    for _, v in p415.items do
        v.favorited = table.find(p416, v.category.name .. "/" .. v.name) and true or false;
    end;

    p415:renderItems();
end;

function u1._show(u417) -- Line: 2718
    -- upvalues: DeviceManager (copy), workspace_CurrentCamera (copy), UserInputService (copy), GuiService2 (copy), RunService (copy), LocalPlayer (copy), u2 (copy)
    u417.itemScroll:setVisible(true);
    u417.packItemsScroll:setVisible(true);
    u417:renderItems();
    u417:renderPackItems();
    u417:registerBinds();
    u417.onDeviceChange = DeviceManager.deviceChanged:Connect(function() -- Line: 2726
        -- upvalues: u417 (copy)
        u417:removeBinds();
        u417:registerBinds();
    end);

    for i, _ in u417.renderedSprites do
        i.active = true;
    end;

    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    workspace_CurrentCamera.CFrame = u417.cameraPos;

    if UserInputService.TouchEnabled then
        GuiService2.TouchControlsEnabled = false;
    end;

    u417.updateConnection = RunService.RenderStepped:Connect(function(p418) -- Line: 2740
        -- upvalues: u417 (copy)
        u417:update(p418);
    end);
    local v419 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v419 then
        v419.WalkSpeed = 0;
        v419.JumpPower = 0;
    end;

    u417:enableHUDSprites();
    u417.ui.Visible = true;
    u2:Enable();
    u417.onShow:Fire();
end;

function u1._hide(p420) -- Line: 2760
    -- upvalues: u2 (copy), workspace_CurrentCamera (copy), UserInputService (copy), GuiService2 (copy), LocalPlayer (copy), StarterPlayer (copy)
    if p420.updateConnection then
        p420.updateConnection:Disconnect();
        p420.updateConnection = nil;
    end;

    if p420.onDeviceChange then
        p420.onDeviceChange:Disconnect();
        p420.onDeviceChange = nil;
    end;

    p420.ui.Visible = false;
    u2:Disable();
    p420:removeBinds();
    p420.itemScroll:setVisible(false);
    p420.packItemsScroll:setVisible(false);

    for i, _ in p420.renderedSprites do
        i.active = false;
    end;

    p420:disableHUDSprites();
    p420.currentShopSong = nil;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;

    if UserInputService.TouchEnabled then
        GuiService2.TouchControlsEnabled = true;
    end;

    local v421 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v421 then
        v421.WalkSpeed = StarterPlayer.CharacterWalkSpeed;
        v421.JumpPower = StarterPlayer.CharacterJumpPower;
        workspace_CurrentCamera.CameraSubject = v421;
    end;

    p420.onHide:Fire();
end;

function u1.show(u422) -- Line: 2795
    -- upvalues: u4 (copy), TweenService (copy)
    u422.onShowStart:Fire();
    u422:fadeInMusic();

    if not u422.fadeUi then
        return u422:_show();
    end;

    if u422.topbarIcon then
        u422.topbarIcon:debounce(u4.fadeStyle.Time);
    end;

    local v423 = TweenService:Create(u422.fadeUi, u4.fadeStyle, {
        BackgroundTransparency = 0
    });
    v423.Completed:Connect(function() -- Line: 2803
        -- upvalues: TweenService (ref), u422 (copy), u4 (ref)
        TweenService:Create(u422.fadeUi, u4.fadeStyle, {
            BackgroundTransparency = 1
        }):Play();
        u422:_show();
    end);
    v423:Play();
end;

function u1.hide(u424) -- Line: 2810
    -- upvalues: u4 (copy), TweenService (copy)
    u424.onHideStart:Fire();
    u424:fadeOutMusic();

    if not u424.fadeUi then
        return u424:_hide();
    end;

    if u424.topbarIcon then
        u424.topbarIcon:debounce(u4.fadeStyle.Time);
    end;

    local v425 = TweenService:Create(u424.fadeUi, u4.fadeStyle, {
        BackgroundTransparency = 0
    });
    v425.Completed:Connect(function() -- Line: 2818
        -- upvalues: TweenService (ref), u424 (copy), u4 (ref)
        TweenService:Create(u424.fadeUi, u4.fadeStyle, {
            BackgroundTransparency = 1
        }):Play();
        u424:_hide();
    end);
    v425:Play();
end;

return u1;