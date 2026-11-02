-- Decompiled with Potassium's decompiler.

game:GetService("GuiService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local MarketplaceService = game:GetService("MarketplaceService");
local StarterPlayer = game:GetService("StarterPlayer");
local GuiService = game:GetService("GuiService");
local UserInputService2 = game:GetService("UserInputService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
ReplicatedStorage:WaitForChild("Assets");
local VirtualCursorManager = require(Modules.Other.VirtualCursorManager);
local DeviceManager = require(Modules.Main.DeviceManager);
local DataManager = require(Modules.Data.DataManager);
local Signal = require(Modules.Lib.Signal);
local Scroll = require(Modules.Lib.Scroll);
local Translator = require(Modules.Main.Translator);
local TopbarIcon = require(Modules.UI.TopbarIcon);
require(Modules.Main.VarTweener);
local ColorPicker = require(Modules.UI.ColorPicker);
local SoundLib = require(Modules.Audio.SoundLib);
local ColorConverter = require(Modules.UI.ColorConverter);
local GetImageID = ReplicatedStorage:WaitForChild("Events"):WaitForChild("GetImageID");
local u1 = VirtualCursorManager.new();
local Settings = Translator.new("Settings", { "General", "Settings" });
local LocalPlayer = Players.LocalPlayer;
local SettingsBlur = game:GetService("Lighting"):FindFirstChild("SettingsBlur");
local TweenInfo_new_ret = TweenInfo.new(0.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
local Data = DataManager:GetData();
local TopbarButtons = LocalPlayer.PlayerGui:WaitForChild("Main"):WaitForChild("TopbarButtons");

function finalEscape(p2)
    return p2:gsub("[%-%.%+%[%]%(%)%$%^%%%?%*]", "%%%1");
end;

local u12 = {
    name = function(p3: table, p4: any, p5: any, p6: any) -- Line: 183, Name: name
        local v7 = finalEscape(p4 or ""):lower();
        local v8 = p3.DisplayName:lower();
        local v9 = (p3.Aliases or ""):lower();
        local v10;

        if v9 == "" then
            v10 = v7;
        else
            v10 = v7:gsub("|", "") or v7;
        end;

        local v11 = (v8:find(v7) or v9:find(v10)) ~= nil;

        if p5 == "!=" then
            v11 = not v11;
        end;

        return v11;
    end
};
local v13 = {
    ["=="] = "=",
    ["~="] = "!="
};
local u26 = {
    [">"] = function(p14, p15) -- Line: 159
        return p15 < p14;
    end,

    [">="] = function(p16, p17) -- Line: 162
        return p17 <= p16;
    end,

    ["<"] = function(p18, p19) -- Line: 165
        return p18 < p19;
    end,

    ["<="] = function(p20, p21) -- Line: 168
        return p20 <= p21;
    end,

    ["="] = function(p22, p23) -- Line: 173
        return p22 == p23;
    end,

    ["!="] = function(p24, p25) -- Line: 176
        return p24 ~= p25;
    end
};

local function convertColorToJson(p27) -- Line: 125
    if typeof(p27) == "Color3" then
        return "#" .. p27:ToHex();
    end;

    if typeof(p27) ~= "ColorSequence" then
        return nil;
    end;

    local v28 = {};

    for _, v in p27.Keypoints do
        local v29 = { v.Time, v.Value:ToHex() };
        table.insert(v28, v29);
    end;

    return game.HttpService:JSONEncode(v28);
end;

local u30 = {};

for i, v in {} do
    u12[i] = u12[v];
end;

for i, v in v13 do
    u26[i] = u26[v];
end;

function getCasesFromSearch(p31)
    -- upvalues: u26 (copy), u12 (copy)
    local v32 = {};

    for _, v in p31:split("&") do
        local v33 = v:gsub("^%s+", ""):gsub("%s+$", "");
        local v34 = v33:match("[<>!=]+");

        if u26[v34] then
            local v35, v36 = unpack(v33:split(v34));
            local v37 = u12[v35:gsub("^%s+", ""):gsub("%s+$", ""):lower()];

            if v37 then
                local v38 = { v37, v36:gsub("^%s+", ""):gsub("%s+$", ""), v34 };
                table.insert(v32, v38);
            end;
        end;
    end;

    if #v32 == 0 then
        v32 = p31 ~= "" and {
            { u12.name, p31, "=" }
        } or v32;
    end;

    return v32;
end;

function round(p39, p40)
    local v41 = 10 ^ (p40 or 0);

    return math.floor(p39 * v41 + 0.5) / v41;
end;

function failsafeValue(p42)
    if typeof(p42) == "string" or typeof(p42) == "number" then
        local v43 = typeof(p42);
        local string_sub_ret = string.sub(p42, 1, 100);

        if v43 == "string" then
            return string_sub_ret;
        end;

        if v43 == "number" then
            return tonumber(string_sub_ret);
        end;
    end;

    return p42;
end;

function parseContent(p44)
    if not p44 then
        return Content.none;
    end;

    if typeof(p44) == "Content" then
        return p44;
    end;

    if type(p44) == "string" then
        return Content.fromUri(p44);
    end;

    return Content.fromAssetId(p44);
end;

function resolveIndex(p45: table, p46: boolean?)
    local v47 = p45.Index or p45.Name;

    if not v47 then
        return;
    end;

    if string.sub(v47, 1, 1) == "+" then
        local ParentCategory = p45.ParentCategory;

        while ParentCategory do
            local v48 = p46 and ParentCategory.ControllerIndexPrefix or ParentCategory.IndexPrefix;

            if v48 then
                v47 = v48 .. string.sub(v47, 2);

                if string.sub(v48, 1, 1) ~= "+" then
                    break;
                end;
            end;

            ParentCategory = ParentCategory.ParentCategory;
        end;
    end;

    if string.sub(v47, 1, 1) == "+" then
        v47 = string.sub(v47, 2) or v47;
    end;

    return v47;
end;

local u62 = {
    Bool = { { "ResetSetting" }, { "SettingLabel" }, { "Toggle" } },
    Number = { { "ResetSetting" }, { "SettingLabel" }, { "Input", "Number" } },
    Slider = { { "ResetSetting" }, { "SettingLabel" }, { "Slider" }, { "Input", "Number" } },
    String = { { "ResetSetting" }, { "SettingLabel" }, { "Input", "String" } },
    Dropdown = { { "ResetSetting" }, { "SettingLabel" }, { "Dropdown" } },

    Keybind = function(p49: table) -- Line: 317
        local v50 = p49.TypeMeta or {};
        local v51 = v50.KeybindsAllowed or 1;
        local v52 = { { "ResetSetting" }, { "SettingLabel" } };

        if v50.Icon then
            local v53 = { "SettingIcon", parseContent(v50.Icon) };
            table.insert(v52, v53);
        end;

        for i = 1, v51 do
            table.insert(v52, { "Action", "KeybindBind" });
            local _ = i;
        end;

        return v52;
    end,

    Text = { { "CenteredText" } },
    Image = {
        { "ResetSetting" },
        { "SettingLabel" },
        { "Input", "Number", function(p54: number, p55: table, p56: userdata) -- Line: 339
                -- upvalues: GetImageID (copy)
                local _, v57 = GetImageID:InvokeServer(p54);

                return true, tonumber(v57) or p54;
            end }
    },
    Asset = {
        { "ResetSetting" },
        { "SettingLabel" },
        { "Input", "Number", function(u58: number, u59: table, p60: userdata) -- Line: 347
                -- upvalues: MarketplaceService (copy)
                if not (u59.TypeMeta and u59.TypeMeta.AssetType) then
                    return true, u58;
                end;

                local v61 = nil;
                local AssetType = u59.TypeMeta.AssetType;

                if type(AssetType) == "string" then
                    v61 = (Enum.AssetType:FromName(AssetType) or Enum.AssetType.Audio).Value;
                elseif typeof(AssetType) == "Enum" then
                    v61 = AssetType.Value;
                end;

                if not v61 then
                    return true;
                end;

                local success, result = pcall(function() -- Line: 362
                    -- upvalues: MarketplaceService (ref), u58 (copy), u59 (copy)
                    return MarketplaceService:GetProductInfoAsync(u58, Enum.InfoType.Asset).AssetTypeId == u59.TypeMeta.AssetType;
                end);

                return success and result;
            end }
    },
    Color = { { "ResetSetting" }, { "SettingLabel" }, { "ColorPreview" }, { "Action", "ColorEdit" } },
    Action = { { "SettingLabel" }, { "Action" } }
};
local u63 = {
    Asset = {
        Min = 0,
        Round = 0
    },
    Text = {
        NoIndex = true,
        IgnoreHover = true
    },
    Action = {
        NoIndex = true
    }
};
local TweenInfo_new_ret2 = TweenInfo.new(0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
local TweenInfo_new_ret3 = TweenInfo.new(0);

function setToggleState(p64: userdata, p65: boolean, p66: boolean?)
    -- upvalues: TweenService (copy), TweenInfo_new_ret3 (copy), TweenInfo_new_ret2 (copy)
    if p65 then
        TweenService:Create(p64, p66 and TweenInfo_new_ret3 or TweenInfo_new_ret2, {
            BackgroundColor3 = Color3.new(0, 0.666667, 0)
        }):Play();
        TweenService:Create(p64.Inner, p66 and TweenInfo_new_ret3 or TweenInfo_new_ret2, {
            Position = UDim2.fromScale(0.5, 0)
        }):Play();

        return;
    end;

    TweenService:Create(p64, p66 and TweenInfo_new_ret3 or TweenInfo_new_ret2, {
        BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
    }):Play();
    TweenService:Create(p64.Inner, p66 and TweenInfo_new_ret3 or TweenInfo_new_ret2, {
        Position = UDim2.fromScale(0, 0)
    }):Play();
end;

function u30.new(p67) -- Line: 418
    -- upvalues: SoundLib (copy), Settings (copy), ColorPicker (copy), Signal (copy), u30 (copy), Scroll (copy), ColorConverter (copy), convertColorToJson (copy), DeviceManager (copy), u63 (copy), u62 (copy), DataManager (copy), Data (copy), UserInputService (copy), u1 (copy), TweenService (copy)
    if not p67 then
        return warn("[SettingsV2] UI wasn\'t passed!");
    end;

    local v68 = p67:FindFirstChildOfClass("AudioFader");

    if v68 then
        v68.Volume = 0;
        local v69 = v68:FindFirstChildOfClass("AudioPlayer");

        if v69 then
            v69:Play();
        end;
    end;

    SoundLib:Pool({ { "SettingsMenu/Hover1", 2 }, { "SettingsMenu/Hover2", 2 }, { "SettingsMenu/Hover3", 2 }, { "SettingsMenu/Hover4", 2 }, { "SettingsMenu/Hover5", 2 } });
    SoundLib:Pool("SettingsMenu/Toggle", 2);
    SoundLib:Pool("SettingsMenu/Tick", 2);
    SoundLib:Pool("Selected", 2);
    local u70 = p67:FindFirstChild("Settings") or p67;
    u70.RootLocalizationTable = Settings.localizationTable;
    u70.BottomBar.Position = UDim2.fromScale(0, 1.2);
    u70.TopBar.Position = UDim2.fromScale(0, -0.2);
    u70.RightTab.Position = UDim2.fromScale(1.4, 0.5);
    u70.SettingsTab.Position = UDim2.fromScale(-0.55, 0.5);
    local SettingsList = u70.SettingsTab.SettingsList;
    local v71 = {
        ui = u70,
        musicFader = v68,
        categories = {},
        settings = {},
        settingTemplate = SettingsList.SettingTemplate,
        categoryTemplate = SettingsList.Category,
        subCatTemplate = SettingsList.SubCategory,
        settingSelectionStroke = u70.SettingSelectionStroke,
        colorPicker = ColorPicker.new(u70.SubStates.ColorPicker),
        onHide = Signal.new(),
        onShow = Signal.new(),
        settingComponents = {},
        renderedTextScrollers = {}
    };
    local u72 = setmetatable(v71, {
        __index = u30
    });
    local u73 = {};

    for _, child in u72.settingTemplate.Components:GetChildren() do
        if child:IsA("GuiBase2d") then
            u72.settingComponents[child.Name] = child;
            local u74 = {};
            local u75 = 0;
            u73[child.Name] = {
                get = function() -- Line: 490, Name: get
                    -- upvalues: u74 (copy), u75 (ref), child (copy)
                    local v76 = u74[1];

                    if not v76 then
                        return child:Clone();
                    end;

                    u74[1] = u74[u75];
                    u74[u75] = nil;
                    u75 = u75 - 1;

                    return v76;
                end,

                add = function(p77) -- Line: 502, Name: add
                    -- upvalues: u75 (ref), u74 (copy)
                    p77.Parent = nil;
                    u75 = u75 + 1;
                    u74[u75] = p77;
                end
            };
            child.Parent = nil;
            child.Visible = true;
        end;
    end;

    local Container = u70.RightTab.Container;
    Container.SettingInfo.Body.Text = "";
    Container.SettingInfo.Header.Text = "";
    Container.PreviewSeparator.Visible = false;
    Container.SettingPreview.Visible = false;
    local u78 = u72.settingComponents.__DropdownList:Clone();
    local u79 = Scroll.new(u78.Objects, nil, "Pooled");
    local Template = u78.Objects.Template;
    Template.Visible = true;
    Template.Parent = nil;
    u79:setLayout({
        isList = true,
        fillDirection = u78.Objects.UIListLayout.FillDirection,
        padding = u78.Objects.UIListLayout.Padding,
        horizontalAlignment = u78.Objects.UIListLayout.HorizontalAlignment,
        verticalAlignment = u78.Objects.UIListLayout.VerticalAlignment
    });
    u79:setTypes({
        Option = {
            OnLoaded = function(u80, p81, p82) -- Line: 541, Name: OnLoaded
                -- upvalues: u79 (copy)
                p81.Label.Text = u80;
                p82.onClick = p81.MouseButton1Click:Connect(function() -- Line: 543
                    -- upvalues: u79 (ref), u80 (copy)
                    if u79.onOptionClicked then
                        u79.onOptionClicked(u80);
                    end;
                end);
            end,

            OnUnloaded = function(p83, p84, p85) -- Line: 549, Name: OnUnloaded
                if p85.onClick then
                    p85.onClick:Disconnect();
                    p85.onClick = nil;
                end;
            end,

            Template = Template
        }
    });
    u78.Objects.UIListLayout.Parent = nil;
    u79:setVisible(false);
    u72.dropdownScroll = u79;

    local function getDropdownAbsSize(p86) -- Line: 562
        local math_min_ret = math.min(#p86, 5);

        return math_min_ret * 20 + math.max(math_min_ret - 1, 0) * 4;
    end;

    local u87 = nil;
    local u88 = nil;

    local function setDropdown(p89: userdata, p90: any, u91: any) -- Line: 569
        -- upvalues: u87 (ref), u79 (copy), u88 (ref), u78 (copy), SettingsList (copy), SoundLib (ref), u72 (copy), setDropdown (copy)
        if u87 then
            u87:Disconnect();
            u87 = nil;
        end;

        if u79._onScrollMove then
            u79._onScrollMove:Disconnect();
            u79._onScrollMove = nil;
        end;

        if u88 then
            local v92 = u88;
            v92.ZIndex = v92.ZIndex - 1;
            u88 = nil;
        end;

        if not p89 then
            u79:setVisible(false);
            u79.onOptionClicked = nil;
            u78.Parent = nil;

            return;
        end;

        local v93 = p89.Parent and p89.Parent.Parent;

        if v93 then
            u88 = v93;
            v93.ZIndex = v93.ZIndex + 1;
        end;

        local u94 = {};

        for _, v in p90 do
            table.insert(u94, {
                type = "Option",
                item = v
            });
        end;

        local math_min_ret = math.min(#u94, 5);
        local u95 = math_min_ret * 20 + math.max(math_min_ret - 1, 0) * 4;
        u78.Size = UDim2.new(1, 0, 0, 12 + u95);
        u78.Parent = p89;
        local u96 = nil;

        local function updateLayout() -- Line: 599
            -- upvalues: u94 (copy), u78 (ref), u95 (copy), u96 (ref), u79 (ref)
            local v97 = 25;
            local Vector2_zero = Vector2.zero;
            local table_clone_ret = table.clone(u94);
            u78.Position = UDim2.new(0, 0, 0, v97);
            u78.AnchorPoint = Vector2_zero;

            if 12 + u95 + u78.AbsolutePosition.Y >= workspace.CurrentCamera.ViewportSize.Y * 0.92 then
                Vector2_zero = Vector2.new(0, 1);
                u78.Position = UDim2.new(0, 0, 0, v97 * -1);
                u78.AnchorPoint = Vector2_zero;
            end;

            if u96 == Vector2_zero then
                return;
            end;

            u96 = Vector2_zero;
            u79:setItems(table_clone_ret);
        end;

        u79._onScrollMove = SettingsList:GetPropertyChangedSignal("CanvasPosition"):Connect(updateLayout);

        function u79.onOptionClicked(p98) -- Line: 629
            -- upvalues: SoundLib (ref), u91 (copy)
            SoundLib:Play("Selected");

            if u91 then
                u91(p98);
            end;
        end;

        u87 = u72.onHide:Connect(function() -- Line: 637
            -- upvalues: setDropdown (ref)
            setDropdown(nil);
        end);
        updateLayout();
        u79:setVisible(true);
    end;

    local v99 = Scroll.new(SettingsList, nil, "Pooled");
    v99:setLayout({
        isList = true,
        fillDirection = SettingsList.UIListLayout.FillDirection,
        padding = SettingsList.UIListLayout.Padding,
        horizontalAlignment = SettingsList.UIListLayout.HorizontalAlignment,
        verticalAlignment = SettingsList.UIListLayout.VerticalAlignment
    });
    local u100 = {};
    local u101 = {};

    local function triggerValueChange(p102) -- Line: 665
        -- upvalues: u100 (copy), u101 (copy)
        for _, v in u100[p102] or {} do
            v();
        end;

        for _, v in u101[p102] or {} do
            v();
        end;
    end;

    local function addToChangeRerender(p103: table, p104: function) -- Line: 675
        -- upvalues: u100 (copy)
        if p103.ListeningUpdates and p104 then
            for _, v in p103.ListeningUpdates do
                local v105 = u100[v];

                if not v105 then
                    v105 = {};
                    u100[v] = v105;
                end;

                v105[p103] = p104;
            end;
        end;
    end;

    local function removeFromChangeRerender(p106: table) -- Line: 686
        -- upvalues: u100 (copy), u101 (copy)
        if p106.ListeningUpdates then
            for _, v in p106.ListeningUpdates do
                local v107 = u100[v];

                if v107 then
                    v107[p106] = nil;

                    if not next(v107) then
                        u100[v] = nil;
                    end;
                end;
            end;
        end;

        if p106.ListeningRenders then
            for _, v in p106.ListeningRenders do
                local v108 = u101[v];

                if v108 then
                    v108[p106] = nil;

                    if not next(v108) then
                        u101[v] = nil;
                    end;
                end;
            end;
        end;
    end;

    local v122 = {
        OnLoaded = function(u109: table, p110: any, p111: table) -- Line: 711, Name: OnLoaded
            -- upvalues: ColorConverter (ref), convertColorToJson (ref), DeviceManager (ref)
            local v112;

            if u109.Prefix then
                if u109.PrefixColor then
                    v112 = ColorConverter.convertColor(convertColorToJson(u109.PrefixColor), false, `[{u109.Prefix}] `, true, false, false).color;
                else
                    v112 = `[{u109.Prefix}] `;
                end;
            else
                v112 = "";
            end;

            p110.SettingLabel.Main.Text = v112 .. (u109.DisplayName or u109.Name);
            local DeviceSwap = p110.SettingLabel.DeviceSwap;

            if resolveIndex({
                Index = "+",
                ParentCategory = u109
            }, true) == resolveIndex({
                Index = "+",
                ParentCategory = u109
            }) then
                DeviceSwap.Visible = false;

                return;
            end;

            local function updateDeviceShown() -- Line: 730
                -- upvalues: DeviceSwap (copy), u109 (copy), DeviceManager (ref)
                DeviceSwap.Contain.CurPlatform.Image = u109._ControllerEnabled and DeviceManager.Icons.Console or DeviceManager.Icons.PC;
            end;

            local function setControllerEnabled(p113: boolean) -- Line: 734
                -- upvalues: u109 (copy), DeviceManager (ref), DeviceSwap (copy)
                local _ControllerEnabled = u109._ControllerEnabled;

                if not DeviceManager.controllerEnabled then
                    p113 = false;
                end;

                u109._ControllerEnabled = p113;

                if _ControllerEnabled ~= p113 then
                    DeviceSwap.Contain.CurPlatform.Image = u109._ControllerEnabled and DeviceManager.Icons.Console or DeviceManager.Icons.PC;
                    u109.indexPrefixChanged:Fire();
                end;
            end;

            local function updateDeviceSwap() -- Line: 748
                -- upvalues: DeviceManager (ref), u109 (copy), DeviceSwap (copy)
                local _ = DeviceManager.currentDevice;
                local v114 = DeviceManager.keyboardEnabled and DeviceManager.controllerEnabled and u109.HasItems;
                DeviceSwap.Visible = v114 and true or false;

                if v114 then
                    DeviceSwap.Contain.CurPlatform.Image = u109._ControllerEnabled and DeviceManager.Icons.Console or DeviceManager.Icons.PC;

                    return;
                end;

                local v115 = DeviceManager.currentDevice == "Console";
                local _ControllerEnabled = u109._ControllerEnabled;

                if not DeviceManager.controllerEnabled then
                    v115 = false;
                end;

                u109._ControllerEnabled = v115;

                if _ControllerEnabled ~= v115 then
                    DeviceSwap.Contain.CurPlatform.Image = u109._ControllerEnabled and DeviceManager.Icons.Console or DeviceManager.Icons.PC;
                    u109.indexPrefixChanged:Fire();
                end;
            end;

            local _ = DeviceManager.currentDevice;
            local v116 = DeviceManager.keyboardEnabled and DeviceManager.controllerEnabled and u109.HasItems;
            DeviceSwap.Visible = v116 and true or false;

            if v116 then
                DeviceSwap.Contain.CurPlatform.Image = u109._ControllerEnabled and DeviceManager.Icons.Console or DeviceManager.Icons.PC;
            else
                local v117 = DeviceManager.currentDevice == "Console";
                local _ControllerEnabled = u109._ControllerEnabled;

                if not DeviceManager.controllerEnabled then
                    v117 = false;
                end;

                u109._ControllerEnabled = v117;

                if _ControllerEnabled ~= v117 then
                    DeviceSwap.Contain.CurPlatform.Image = u109._ControllerEnabled and DeviceManager.Icons.Console or DeviceManager.Icons.PC;
                    u109.indexPrefixChanged:Fire();
                end;
            end;

            p111.deviceChanged = DeviceManager.inputDeviceChanged:Connect(updateDeviceSwap);
            p111.deviceSwapClick = p110.SettingLabel.DeviceSwap.MouseButton1Click:Connect(function() -- Line: 764
                -- upvalues: u109 (copy), DeviceManager (ref), DeviceSwap (copy)
                local v118 = not u109._ControllerEnabled;
                local _ControllerEnabled = u109._ControllerEnabled;

                if not DeviceManager.controllerEnabled then
                    v118 = false;
                end;

                u109._ControllerEnabled = v118;

                if _ControllerEnabled ~= v118 then
                    DeviceSwap.Contain.CurPlatform.Image = u109._ControllerEnabled and DeviceManager.Icons.Console or DeviceManager.Icons.PC;
                    u109.indexPrefixChanged:Fire();
                end;

                u109.indexPrefixChanged:Fire();
            end);
        end,

        OnUnloaded = function(p119: table, p120: any, p121: table) -- Line: 769, Name: OnUnloaded
            if p121.deviceSwapClick then
                p121.deviceSwapClick:Disconnect();
                p121.deviceSwapClick = nil;
            end;

            if p121.deviceChanged then
                p121.deviceChanged:Disconnect();
                p121.deviceChanged = nil;
            end;
        end,

        Template = u72.categoryTemplate
    };
    local table_clone_ret = table.clone(v122);
    table_clone_ret.Template = u72.subCatTemplate;
    v99:setTypes({
        Item = {
            OnLoaded = function(u123: table, u124: userdata, p125: table) -- Line: 781, Name: OnLoaded
                -- upvalues: u63 (ref), u62 (ref), DataManager (ref), Data (ref), triggerValueChange (copy), addToChangeRerender (copy), u72 (copy), u73 (copy), SoundLib (ref), DeviceManager (ref), u70 (ref), UserInputService (ref), u1 (ref), TweenService (ref), setDropdown (copy), u78 (copy), u87 (ref), u79 (copy), u88 (ref), Container (copy)
                local u126 = u123.TypeMeta or {};

                for i, v in u63[u123.Type or ""] or {} do
                    if u126[i] == nil then
                        u126[i] = v;
                    end;
                end;

                local v127 = u123.Components or (u62[u123.Type] or {});

                if type(v127) == "function" then
                    v127 = v127(u123) or v127;
                end;

                local table_create_ret = table.create(#v127);
                p125.renderedComponents = table_create_ret;
                local v128 = {};
                p125.connections = v128;
                local Components = u124.Components;
                local u129 = nil;
                local u130 = nil;
                local u131 = {};
                local u132 = {};
                local ParentCategory = u123.ParentCategory;
                local u133 = nil;
                local u134 = nil;

                local function updateIndex() -- Line: 810
                    -- upvalues: u126 (copy), u133 (ref), u134 (ref), u129 (ref), u123 (copy), ParentCategory (copy), u130 (ref), DataManager (ref), Data (ref), u132 (copy), u131 (copy)
                    if u126.NoIndex then
                        u133 = false;
                        u134 = false;
                        u129 = nil;
                    else
                        u134 = resolveIndex(u123, true) ~= resolveIndex(u123, false);
                        u133 = u134 and ParentCategory and ParentCategory._ControllerEnabled;
                        u129 = resolveIndex(u123, u133);
                    end;

                    u130 = nil;

                    if not (u129 or u126.NoIndex) then
                        warn("[SettingsV2] Malformed index for: ", u123.DisplayName or u123.Name);

                        return;
                    end;

                    if u129 then
                        u130 = DataManager.getByPath(Data, u129);

                        if u126.GetValue then
                            u130 = u126.GetValue(u130);
                        end;

                        u130 = failsafeValue(u130);
                    end;

                    for _, v in u132 do
                        v();
                    end;

                    for _, v in u131 do
                        v();
                    end;
                end;

                local function refreshValue() -- Line: 846
                    -- upvalues: u129 (ref), u130 (ref), DataManager (ref), Data (ref), u126 (copy), triggerValueChange (ref), u131 (copy)
                    if not u129 then
                        return;
                    end;

                    local v135 = u130;
                    u130 = DataManager.getByPath(Data, u129);

                    if u126.GetValue then
                        u130 = u126.GetValue(u130);
                    end;

                    u130 = failsafeValue(u130);

                    if u130 ~= v135 then
                        triggerValueChange(u129);
                    end;

                    for _, v in u131 do
                        v();
                    end;
                end;

                p125._externalSettingChange = DataManager.DataChanged:Connect(function(p136) -- Line: 867
                    -- upvalues: u129 (ref), refreshValue (copy)
                    if p136 == u129 then
                        refreshValue();
                    end;
                end);

                local function isSettingDifferent() -- Line: 873
                    -- upvalues: u129 (ref), DataManager (ref), Data (ref)
                    if not u129 then
                        return false;
                    end;

                    local ByPath = DataManager.getByPath(DataManager.DataTemplate, u129);
                    local ByPath2 = DataManager.getByPath(Data, u129);

                    if type(ByPath) ~= type(ByPath2) then
                        return true;
                    end;

                    if type(ByPath2) ~= "table" then
                        return ByPath ~= ByPath2;
                    end;

                    for i, v in next, ByPath do
                        if ByPath2[i] ~= v then
                            return true;
                        end;
                    end;

                    for i, v in next, ByPath2 do
                        if ByPath[i] ~= v then
                            return true;
                        end;
                    end;

                    return false;
                end;

                local function setSettingValue(p137, p138) -- Line: 894
                    -- upvalues: u126 (copy), DataManager (ref), u129 (ref)
                    local v139 = failsafeValue(p137);

                    if u126.SetValue and not p138 then
                        v139 = u126.SetValue(v139);
                    end;

                    DataManager:SetData(u129, v139);
                end;

                updateIndex();

                if ParentCategory then
                    table.insert(v128, ParentCategory.indexPrefixChanged:Connect(updateIndex));
                end;

                addToChangeRerender(u123, refreshValue);
                local u140 = {};
                local u141 = 0;

                for i, v in v127 do
                    local v142 = v[1];
                    local v143 = u72.settingComponents[v142];

                    if v143 then
                        local u144;

                        if u73[v142] then
                            u144 = u73[v142].get();
                        else
                            u144 = v143:Clone();
                        end;

                        table_create_ret[u144] = v142;
                        u144.LayoutOrder = i;

                        if v142 == "SettingLabel" or v142 == "CenteredText" then
                            u144.Main.Text = (u123.DisplayName or u123.Name) .. (u133 and " (Controller)" or (u134 and " (Keyboard)" or ""));
                            table.insert(u132, function() -- Line: 931
                                -- upvalues: u144 (ref), u123 (copy), u133 (ref), u134 (ref)
                                u144.Main.Text = (u123.DisplayName or u123.Name) .. (u133 and " (Controller)" or (u134 and " (Keyboard)" or ""));
                            end);
                            u144.Main.Size = UDim2.fromScale(99, 1) or UDim2.fromScale(1, 1);
                            u72.renderedTextScrollers[u123] = u144 or nil;

                            if not u123._scrollTime then
                                u144.Main.Position = UDim2.fromScale(v142 == "SettingLabel" and 0 or 0.5, 0.5);
                                u144.Main.TextTransparency = 0;
                            end;
                        elseif v142 == "Input" then
                            local u145 = v[2];
                            local u146 = v[3];

                            local function renderText() -- Line: 946
                                -- upvalues: u130 (ref), u126 (copy), u144 (ref)
                                local v147 = tostring(u130);
                                local FormatInput = u126.FormatInput;

                                if FormatInput then
                                    v147 = type(FormatInput) == "function" and FormatInput(v147) or FormatInput:gsub("%{value%}", v147);
                                end;

                                u144.Text = v147;
                            end;

                            local ByPath = DataManager.getByPath(DataManager.DataTemplate, u129);

                            if u126.GetValue then
                                ByPath = u126.GetValue(ByPath);
                            end;

                            u144.PlaceholderText = tostring(ByPath);
                            table.insert(v128, u144.Focused:Connect(function() -- Line: 964
                                -- upvalues: SoundLib (ref), u144 (ref), u130 (ref)
                                SoundLib:Play("Selected");
                                u144.Text = tostring(u130);
                            end));
                            table.insert(v128, u144.FocusLost:Connect(function() -- Line: 969
                                -- upvalues: u144 (ref), u130 (ref), u126 (copy), DataManager (ref), u145 (copy), u146 (copy), u123 (copy), u129 (ref)
                                u144.TextEditable = false;
                                u144.TextColor3 = Color3.fromRGB(150, 150, 150);

                                local function avoidEdit() -- Line: 973
                                    -- upvalues: u144 (ref), u130 (ref), u126 (ref)
                                    u144.TextEditable = true;
                                    u144.TextColor3 = Color3.fromRGB(255, 255, 255);
                                    local v148 = tostring(u130);
                                    local FormatInput = u126.FormatInput;

                                    if FormatInput then
                                        v148 = type(FormatInput) == "function" and FormatInput(v148) or FormatInput:gsub("%{value%}", v148);
                                    end;

                                    u144.Text = v148;
                                end;

                                local Text = u144.Text;

                                if not DataManager:isValid(Text) then
                                    return avoidEdit();
                                end;

                                local v149 = Text:gsub("^%s+", ""):gsub("%s+$", "");

                                if u145 == "Number" then
                                    local v150 = v149:gsub(",", ".", 1):gsub("[^%d%.%-]", "");
                                    local v151 = tonumber(v150);

                                    if not v151 then
                                        return avoidEdit();
                                    end;

                                    v149 = round(v151, u126.Round or 0);

                                    if u126.Min then
                                        v149 = math.max(v149, u126.Min);
                                    end;

                                    if u126.Max then
                                        v149 = math.min(v149, u126.Max);
                                    end;
                                end;

                                if u146 then
                                    local v152, v153 = u146(v149, u123, u144);

                                    if not v152 then
                                        return avoidEdit();
                                    end;

                                    v149 = v153 or v149;
                                end;

                                u144.TextEditable = true;
                                u144.TextColor3 = Color3.fromRGB(255, 255, 255);
                                local v154 = failsafeValue(v149);

                                if u126.SetValue then
                                    v154 = u126.SetValue(v154);
                                end;

                                DataManager:SetData(u129, v154);
                            end));
                            table.insert(u131, renderText);
                            local v155 = tostring(u130);
                            local FormatInput = u126.FormatInput;

                            if FormatInput then
                                v155 = type(FormatInput) == "function" and FormatInput(v155) or FormatInput:gsub("%{value%}", v155);
                            end;

                            u144.Text = v155;
                        elseif v142 == "ColorPreview" then
                            local function updateColor() -- Line: 1020
                                -- upvalues: u130 (ref), u144 (ref)
                                local v156;

                                if type(u130) == "table" then
                                    v156 = Color3.new(table.unpack(u130 == 0 and { 1, 1, 1 } or (u130 or { 1, 1, 1 })));
                                else
                                    v156 = Color3.new(1, 1, 1);
                                end;

                                u144.BackgroundColor3 = v156;
                            end;

                            updateColor();
                            table.insert(u131, updateColor);
                        elseif v142 == "Toggle" then
                            setToggleState(u144, u130, true);
                            table.insert(u131, function() -- Line: 1037
                                -- upvalues: u144 (ref), u130 (ref)
                                setToggleState(u144, u130);
                            end);
                            table.insert(v128, u144.MouseButton1Click:Connect(function() -- Line: 1041
                                -- upvalues: u130 (ref), u126 (copy), DataManager (ref), u129 (ref), SoundLib (ref)
                                local v157 = not u130;
                                local v158 = failsafeValue(v157);

                                if u126.SetValue then
                                    v158 = u126.SetValue(v158);
                                end;

                                DataManager:SetData(u129, v158);
                                SoundLib:Play("SettingsMenu/Toggle");

                                if u126.OnToggle then
                                    u126.OnToggle(v157);
                                end;
                            end));
                        elseif v142 == "Action" then
                            local v159 = v[2];

                            if v159 == "KeybindBind" then
                                u141 = u141 + 1;
                                table.insert(u140, u144);
                                local AllowUnbind = u126.AllowUnbind;
                                local u160 = u126.MinKeybinds or 1;
                                local u161 = u141;
                                table.insert(v128, u144.MouseButton1Click:Connect(function() -- Line: 1062
                                    -- upvalues: DeviceManager (ref), SoundLib (ref), u70 (ref), u130 (ref), u161 (copy), AllowUnbind (copy), u160 (copy), u72 (ref), UserInputService (ref), u133 (ref), u126 (copy), DataManager (ref), u129 (ref), u1 (ref)
                                    if not (DeviceManager.controllerEnabled or DeviceManager.keyboardEnabled) then
                                        return;
                                    end;

                                    SoundLib:Play("Selected");
                                    local KeybindSelect = u70.SubStates.KeybindSelect;
                                    local v162 = type(u130) == "table" and u130 or { u130 };
                                    local v163 = {};
                                    local u164 = "Set";
                                    local v165 = u161;
                                    local Unbind = KeybindSelect.Selections.Unbind;

                                    if v162[v165] and (AllowUnbind or u160 < #v162) then
                                        Unbind.Visible = true;
                                        table.insert(v163, Unbind.MouseButton1Click:Connect(function() -- Line: 1079
                                            -- upvalues: u164 (ref)
                                            u164 = "Unbind";
                                        end));
                                    else
                                        Unbind.Visible = false;
                                    end;

                                    table.insert(v163, KeybindSelect.Selections.Cancel.MouseButton1Click:Connect(function() -- Line: 1086
                                        -- upvalues: u164 (ref)
                                        u164 = "Cancel";
                                    end));
                                    u72:setSubmenuState(true);
                                    KeybindSelect.Visible = true;
                                    task.wait();
                                    task.wait();
                                    local v166;

                                    repeat
                                        v166 = UserInputService.InputEnded:Wait();
                                    until v166 ~= Enum.KeyCode.Thumbstick1;

                                    task.wait();
                                    local v167 = v166.KeyCode == Enum.KeyCode.Unknown and (v166.UserInputType == Enum.UserInputType.MouseButton1 and u133) and "ButtonR2" or v166.KeyCode.Name;

                                    if u164 == "Set" and v167 ~= "Unknown" then
                                        if #v162 < v165 then
                                            table.insert(v162, v167);
                                        else
                                            v162[v165] = v167;
                                        end;

                                        if #v162 == 1 then
                                            v162 = v162[1];
                                        end;

                                        local v168 = failsafeValue(v162);

                                        if u126.SetValue then
                                            v168 = u126.SetValue(v168);
                                        end;

                                        DataManager:SetData(u129, v168);
                                    elseif u164 == "Unbind" then
                                        if #v162 == 1 then
                                            local v169 = failsafeValue(nil);

                                            if u126.SetValue then
                                                v169 = u126.SetValue(v169);
                                            end;

                                            DataManager:SetData(u129, v169);
                                        else
                                            table.remove(v162, v165);

                                            if #v162 == 1 then
                                                v162 = v162[1];
                                            end;

                                            local v170 = failsafeValue(v162);

                                            if u126.SetValue then
                                                v170 = u126.SetValue(v170);
                                            end;

                                            DataManager:SetData(u129, v170);
                                        end;
                                    end;

                                    u1:Enable(u70);
                                    u72:setSubmenuState(false);
                                    KeybindSelect.Visible = false;

                                    for _, v2 in v163 do
                                        v2:Disconnect();
                                    end;
                                end));
                            elseif v159 == "ColorEdit" then
                                u144.Text = "Edit";
                                table.insert(v128, u144.MouseButton1Click:Connect(function() -- Line: 1146
                                    -- upvalues: u72 (ref), u130 (ref), u126 (copy), DataManager (ref), u129 (ref)
                                    u72:setSubmenuState(true);
                                    local v171;

                                    if type(u130) == "table" then
                                        v171 = Color3.new(table.unpack(u130 == 0 and { 1, 1, 1 } or (u130 or { 1, 1, 1 })));
                                    else
                                        v171 = Color3.new(1, 1, 1);
                                    end;

                                    u72.colorPicker:setColor(v171);
                                    u72.colorPicker:show();
                                    local u172 = false;

                                    local function saveColor(p173) -- Line: 1162
                                        -- upvalues: u126 (ref), DataManager (ref), u129 (ref)
                                        local v174 = failsafeValue({ p173.R, p173.G, p173.B });

                                        if u126.SetValue then
                                            v174 = u126.SetValue(v174);
                                        end;

                                        DataManager:SetData(u129, v174);
                                    end;

                                    local v177 = u72.colorPicker.onConfirm:Connect(function(p175) -- Line: 1168
                                        -- upvalues: u172 (ref), u126 (ref), DataManager (ref), u129 (ref)
                                        u172 = true;
                                        local v176 = failsafeValue({ p175.R, p175.G, p175.B });

                                        if u126.SetValue then
                                            v176 = u126.SetValue(v176);
                                        end;

                                        DataManager:SetData(u129, v176);
                                    end);
                                    local v178 = u72.colorPicker.onCancel:Connect(function() -- Line: 1173
                                        -- upvalues: u172 (ref)
                                        u172 = true;
                                    end);

                                    repeat
                                        task.wait();
                                    until u172;

                                    if v177 then
                                        v177:Disconnect();
                                    end;

                                    if v178 then
                                        v178:Disconnect();
                                    end;

                                    u72:setSubmenuState(false);
                                end));
                            else
                                u144.Text = u126.ActionName or "Action";

                                if u126.OnClick then
                                    table.insert(v128, u144.MouseButton1Click:Connect(function() -- Line: 1187
                                        -- upvalues: u126 (copy), u72 (ref)
                                        u126.OnClick(u72);
                                    end));
                                end;
                            end;
                        elseif v142 == "ResetSetting" then
                            u144.Size = isSettingDifferent() and UDim2.fromScale(1, 0.4) or UDim2.fromScale(0, 0);
                            table.insert(u131, function() -- Line: 1194
                                -- upvalues: TweenService (ref), u144 (ref), isSettingDifferent (copy)
                                TweenService:Create(u144, TweenInfo.new(0.3), {
                                    Size = isSettingDifferent() and UDim2.fromScale(1, 0.4) or UDim2.fromScale(0, 0)
                                }):Play();
                            end);
                            table.insert(v128, u144.ResetButton.MouseButton1Click:Connect(function() -- Line: 1198
                                -- upvalues: DataManager (ref), u129 (ref), u126 (copy), SoundLib (ref)
                                local ByPath = DataManager.getByPath(DataManager.DataTemplate, u129);
                                local v179 = failsafeValue(ByPath);
                                local _ = u126.SetValue;
                                DataManager:SetData(u129, v179);
                                SoundLib:Play("Selected");
                            end));
                        elseif v142 == "Dropdown" then
                            u144.Text = tostring(u130);
                            local u180 = u126.Options or {};

                            if u126.OptionsSorting == "Alphabetical" then
                                table.sort(u180, function(p181, p182) -- Line: 1208
                                    return p181:lower() < p182:lower();
                                end);
                            end;

                            table.insert(v128, u144.MouseButton1Click:Connect(function() -- Line: 1213
                                -- upvalues: SoundLib (ref), setDropdown (ref), u78 (ref), u144 (ref), u180 (copy), u126 (copy), DataManager (ref), u129 (ref), u87 (ref), u79 (ref), u88 (ref)
                                SoundLib:Play("Selected");
                                local v183;

                                if u78.Parent == u144 then
                                    v183 = nil;
                                else
                                    v183 = u144 or nil;
                                end;

                                setDropdown(v183, u180, function(p184) -- Line: 1216
                                    -- upvalues: u126 (ref), DataManager (ref), u129 (ref), u87 (ref), u79 (ref), u88 (ref), u78 (ref)
                                    local v185 = failsafeValue(p184);

                                    if u126.SetValue then
                                        v185 = u126.SetValue(v185);
                                    end;

                                    DataManager:SetData(u129, v185);

                                    if u87 then
                                        u87:Disconnect();
                                        u87 = nil;
                                    end;

                                    if u79._onScrollMove then
                                        u79._onScrollMove:Disconnect();
                                        u79._onScrollMove = nil;
                                    end;

                                    if u88 then
                                        local v186 = u88;
                                        v186.ZIndex = v186.ZIndex - 1;
                                        u88 = nil;
                                    end;

                                    u79:setVisible(false);
                                    u79.onOptionClicked = nil;
                                    u78.Parent = nil;

                                    if u126.OnSelect then
                                        u126.OnSelect(p184);
                                    end;
                                end);
                            end));
                            table.insert(u131, function() -- Line: 1226
                                -- upvalues: u144 (ref), u130 (ref)
                                u144.Text = tostring(u130);
                            end);
                        elseif v142 == "Slider" then
                            local SliderMarker = u144.SliderMarker;
                            local UIDragDetector = SliderMarker.UIDragDetector;
                            SliderMarker.Position = UDim2.fromScale(math.map(tonumber(u130) or 0, u126.Min or 0, u126.Max or 1, 0, 1), 0.5);
                            table.insert(v128, UIDragDetector.DragContinue:Connect(function() -- Line: 1235
                                -- upvalues: u130 (ref), SliderMarker (copy), u126 (copy), u131 (copy)
                                u130 = round(math.map(SliderMarker.Position.X.Scale, 0, 1, u126.Min or 0, u126.Max or 1), u126.Round or 0);

                                for _, v2 in u131 do
                                    v2();
                                end;

                                if u126.OnVisualUpdate then
                                    local v187 = u130;

                                    if u126.SetValue then
                                        v187 = u126.SetValue(v187);
                                    end;

                                    u126.OnVisualUpdate(v187, u130);
                                end;
                            end));
                            table.insert(v128, UIDragDetector.DragEnd:Connect(function() -- Line: 1252
                                -- upvalues: u130 (ref), u126 (copy), DataManager (ref), u129 (ref)
                                local v188 = failsafeValue(u130);

                                if u126.SetValue then
                                    v188 = u126.SetValue(v188);
                                end;

                                DataManager:SetData(u129, v188);

                                if u126.OnDragEnd then
                                    u126.OnDragEnd(u130);
                                end;
                            end));
                            table.insert(u131, function() -- Line: 1260
                                -- upvalues: SliderMarker (copy), u130 (ref), u126 (copy), SoundLib (ref)
                                SliderMarker.Position = UDim2.fromScale(math.map(tonumber(u130) or 0, u126.Min or 0, u126.Max or 1, 0, 1), 0.5);
                                SoundLib:Play("SettingsMenu/Tick");
                            end);
                        end;

                        u144.Parent = Components;
                    end;
                end;

                if not u126.IgnoreHover then
                    p125.onHover = u124.MouseEnter:Connect(function() -- Line: 1270
                        -- upvalues: u72 (ref), u124 (copy), TweenService (ref), SoundLib (ref), Container (ref), u123 (copy)
                        u72.settingSelectionStroke.Parent = u124.TrueBackground;
                        u72.settingSelectionStroke.Thickness = 0;
                        TweenService:Create(u72.settingSelectionStroke, TweenInfo.new(0.25), {
                            Thickness = 3
                        }):Play();
                        SoundLib:Play("SettingsMenu/Hover1");
                        Container.SettingInfo.Header.Text = u123.DisplayName or u123.Name;
                        Container.SettingInfo.Body.Text = type(u123.Description) == "function" and u123.Description() or tostring(u123.Description);

                        if u123.Preview then
                            Container.PreviewSeparator.Visible = true;
                            Container.SettingPreview.Visible = true;

                            return;
                        end;

                        Container.PreviewSeparator.Visible = false;
                        Container.SettingPreview.Visible = false;
                    end);
                    p125.onHoverEnded = u124.MouseLeave:Connect(function() -- Line: 1289
                        -- upvalues: u72 (ref)
                        u72.settingSelectionStroke.Parent = nil;
                    end);
                end;

                if u141 > 0 then
                    local function updateRenderedKeybinds() -- Line: 1295
                        -- upvalues: u130 (ref), u141 (ref), u140 (copy)
                        local v189 = type(u130) == "table" and u130 or { u130 };

                        for i = 1, u141 do
                            u140[i].Text = v189[i] or "None";
                            local _ = i;
                        end;
                    end;

                    table.insert(u131, updateRenderedKeybinds);
                    updateRenderedKeybinds();
                end;
            end,

            OnUnloaded = function(p190: table, p191: any, p192: table) -- Line: 1310, Name: OnUnloaded
                -- upvalues: u78 (copy), u87 (ref), u79 (copy), u88 (ref), removeFromChangeRerender (copy), u72 (copy), u73 (copy)
                if p192._externalSettingChange then
                    p192._externalSettingChange:Disconnect();
                end;

                if p192.onHover then
                    p192.onHover:Disconnect();
                end;

                if p192.onHoverEnded then
                    p192.onHoverEnded:Disconnect();
                end;

                if u78:IsDescendantOf(p191) then
                    if u87 then
                        u87:Disconnect();
                        u87 = nil;
                    end;

                    if u79._onScrollMove then
                        u79._onScrollMove:Disconnect();
                        u79._onScrollMove = nil;
                    end;

                    if u88 then
                        local v193 = u88;
                        v193.ZIndex = v193.ZIndex - 1;
                        u88 = nil;
                    end;

                    u79:setVisible(false);
                    u79.onOptionClicked = nil;
                    u78.Parent = nil;
                end;

                removeFromChangeRerender(p190);
                u72.renderedTextScrollers[p190] = nil;

                for i, v in p192.renderedComponents or {} do
                    if u73[v] then
                        u73[v].add(i);
                    else
                        i:Destroy();
                    end;
                end;

                for _, v in p192.connections or {} do
                    v:Disconnect();
                end;
            end,

            Template = u72.settingTemplate
        },
        SubCategory = table_clone_ret,
        Category = v122
    });
    v99:setVisible(false);
    u72.settingsScroll = v99;
    SettingsList.UIListLayout.Parent = nil;
    u72.settingTemplate.Parent = nil;
    u72.categoryTemplate.Parent = nil;
    u72.subCatTemplate.Parent = nil;
    u70.SettingsTab.SearchBar.Search:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 1362
        -- upvalues: u72 (copy)
        u72:render();
    end);

    return u72;
end;

function u30.update(p194, p195) -- Line: 1369
    local BG = p194.ui.SubStates.BG;

    if BG.Visible and BG.ImageTransparency ~= 1 then
        local v196 = tick() * 50 % 1655;
        BG.Position = UDim2.fromOffset(v196, v196);
    end;

    for i, v in p194.renderedTextScrollers do
        local X = v.Main.TextBounds.X;
        local X2 = v.AbsoluteSize.X;
        local X3 = v.Main.AnchorPoint.X;

        if X2 + 5 < X then
            local _scrollTime = i._scrollTime;
            local v197 = _scrollTime and (_scrollTime + p195 or 0) or 0;
            local v198 = X - X2;
            local v199 = v198 / 40;
            local v200 = nil;
            local v201 = 1;

            if v199 + 2.25 < v197 then
                v200 = UDim2.new(X3, v198 * X3, 0.5, 0);
                local math_min_ret = math.min((v197 - v199 - 2.25) / 1, 1);
                v201 = math.lerp(0, 1, math_min_ret);

                if v201 == 1 then
                    v197 = -1;
                end;
            elseif v199 + 2 < v197 then
                local math_min_ret = math.min((v197 - v199 - 2) / 1, 1);
                v201 = math.lerp(1, 0, math_min_ret);
            end;

            if not v200 then
                local UDim2_new = UDim2.new;
                local math_clamp_ret = math.clamp(v197 / v199, 0, 1);
                v200 = UDim2_new(X3, math.lerp(v198 * X3, -v198 * (1 - X3), math_clamp_ret), 0.5, 0);
            end;

            v.Main.TextTransparency = 1 - v201;
            v.Main.Position = v200;
            i._scrollTime = v197;
        elseif i._scrollTime then
            v.Main.Position = UDim2.fromScale(0, 0.5);
            i._scrollTime = nil;
        end;
    end;
end;

function u30.render(p202) -- Line: 1424
    if not p202.isInitialized then
        return;
    end;

    local Text = p202.ui.SettingsTab.SearchBar.Search.Text;
    local v203 = getCasesFromSearch(Text == nil and "" or Text);
    local v204 = {};
    local v205 = {};

    for _, v in p202.settings do
        local v206 = v;
        local v207 = true;

        for _, v2 in v203 do
            if not v207 then
                break;
            end;

            v207 = v2[1](v206, v2[2], v2[3], v207, p202);
        end;

        if v207 then
            local ParentCategory = v206.ParentCategory;

            if not v205[ParentCategory] then
                local v208 = {};

                while true do
                    local ParentCategory2 = ParentCategory.ParentCategory;
                    table.insert(v208, {
                        item = ParentCategory,
                        type = ParentCategory2 and "SubCategory" or "Category"
                    });
                    v205[ParentCategory] = true;

                    if not ParentCategory2 or v205[ParentCategory2] then
                        break;
                    end;

                    ParentCategory = ParentCategory2;
                end;

                for i = #v208, 1, -1 do
                    table.insert(v204, v208[i]);
                    local _ = i;
                end;
            end;

            table.insert(v204, {
                type = "Item",
                item = v206
            });
        end;
    end;

    p202.settingsScroll:setItems(v204);
end;

function u30.goToCategory(p209: table, p210: table) -- Line: 1472
    -- upvalues: TweenService (copy)
    local PositionFromItem = p209.settingsScroll:GetPositionFromItem(p210);

    if PositionFromItem then
        TweenService:Create(p209.ui.SettingsTab.SettingsList, TweenInfo.new(0.25, Enum.EasingStyle.Exponential), {
            CanvasPosition = PositionFromItem
        }):Play();
    end;
end;

function u30.setCategories(p211: table, p212: table) -- Line: 1480
    for _, v in p212 do
        p211:addCategory(v);
    end;
end;

function u30.setSubmenuState(p213, p214) -- Line: 1486
    -- upvalues: TweenService (copy)
    local v215 = p214 and true or false;
    local SubStates = p213.ui.SubStates;
    local BG = SubStates.BG;
    TweenService:Create(BG, TweenInfo.new(0.25), {
        BackgroundTransparency = v215 and 0.45 or 1,
        ImageTransparency = v215 and 0.7 or 1
    }):Play();
    BG.HitboxHold.Visible = v215;
    SubStates.Visible = v215;
    p213.isSubmenu = v215;
end;

function u30.addCategory(u216: table, u217: table, p218: table?) -- Line: 1499
    -- upvalues: Signal (copy), ColorConverter (copy), convertColorToJson (copy), SoundLib (copy), TweenService (copy)
    if (type(u217.Visible) ~= "function" or u217.Visible()) and u217.Visible ~= false then
        u217.Name = u217.Name or u217.DisplayName;
        u217.DisplayName = u217.DisplayName or u217.Name;
        u217.ShortName = u217.ShortName or u217.DisplayName;

        if u217.Prefix and not u217.ShortPrefix then
            u217.ShortPrefix = u217.Prefix;
        end;

        if u217.PrefixColor and typeof(u217.PrefixColor) == "Color3" then
            u217.PrefixColor = ColorSequence.new(u217.PrefixColor);
        end;

        u217.Icon = parseContent(u217.Icon);
        u217.Items = u217.Items or {};
        u217.IsCategory = true;
        u217.ParentCategory = p218;
        u217.HasItems = false;
        u217.HasCategories = false;
        u217.indexPrefixChanged = Signal.new();

        for _, v in u217.Items do
            if v.Items or (v.IndexPrefix or v.IsCategory) then
                u217.HasCategories = true;
                u216:addCategory(v, u217);
            else
                u217.HasItems = true;
                u216:addItem(v, u217);
            end;
        end;

        if not p218 then
            table.insert(u216.categories, u217);
            local Categories = u216.ui.BottomBar.Categories;
            local u219 = Categories.Template:Clone();
            local v220;

            if u217.ShortPrefix then
                if u217.PrefixColor then
                    v220 = ColorConverter.convertColor(convertColorToJson(u217.PrefixColor), false, `[{u217.ShortPrefix}] `, true, false, false).color;
                else
                    v220 = `[{u217.ShortPrefix}] `;
                end;
            else
                v220 = "";
            end;

            u219.Name = u217.Name;
            u219.Button.Label.Text = v220 .. u217.ShortName;
            u219.Button.Icon.ImageContent = u217.Icon;
            u219.Visible = true;
            u219.Button.MouseButton1Click:Connect(function() -- Line: 1558
                -- upvalues: u216 (copy), u217 (copy)
                u216:goToCategory(u217);
            end);
            SoundLib:Attach(u219.Button, {
                MouseButton1Click = "Selected",
                MouseEnter = { "SettingsMenu/Hover1", "SettingsMenu/Hover2", "SettingsMenu/Hover3", "SettingsMenu/Hover4", "SettingsMenu/Hover5" }
            });
            u219.Button.MouseEnter:Connect(function() -- Line: 1567
                -- upvalues: TweenService (ref), u219 (copy)
                TweenService:Create(u219, TweenInfo.new(0.25), {
                    Size = UDim2.fromScale(0.2, 0.7)
                }):Play();
            end);
            u219.Button.MouseLeave:Connect(function() -- Line: 1571
                -- upvalues: TweenService (ref), u219 (copy)
                TweenService:Create(u219, TweenInfo.new(0.25), {
                    Size = UDim2.fromScale(0.174, 0.7)
                }):Play();
            end);
            u219.Parent = Categories;
        end;

        return u217;
    end;
end;

function u30.addItem(p221: table, p222: table, p223: any) -- Line: 1581
    if type(p222.Visible) == "function" and not p222.Visible() or p222.Visible == false then
        return;
    end;

    p222.Name = p222.Name or p222.DisplayName;
    p222.Description = p222.Description or "This setting has no description yet.";
    p222.ParentCategory = p223;
    table.insert(p221.settings, p222);
end;

function u30.makeTopbarIcon(u224) -- Line: 1594
    -- upvalues: TopbarIcon (copy), SoundLib (copy), TopbarButtons (copy)
    if u224.topbarIcon then
        return u224.topbarIcon;
    end;

    local u227 = TopbarIcon.new():setImage(6031280882):setImageScale(0.7):setLeft():setOrder(1):setLabel("Settings", "Viewing"):modifyTheme({
        { "IconLabel", "FontFace", Font.fromName("Montserrat", Enum.FontWeight.Bold, Enum.FontStyle.Normal) },
        { "IconLabel", "TextSize", 15 }
    }):bindEvent("viewingStarted", function() -- Line: 1607
        -- upvalues: SoundLib (ref)
        SoundLib:Play("Topbar/Hover");
    end):bindEvent("selected", function(p225) -- Line: 1610
        -- upvalues: SoundLib (ref), u224 (copy)
        if not shared.clientLoaded then
            return p225:deselect();
        end;

        SoundLib:Play("Topbar/Open");
        u224:show();
    end):bindEvent("deselected", function(p226) -- Line: 1615
        -- upvalues: SoundLib (ref), u224 (copy)
        if not shared.clientLoaded then
            return;
        end;

        SoundLib:Play("Topbar/Open");
        u224:hide();
    end);
    u227:setGroup("SystemButton_Left");
    TopbarButtons:GetAttributeChangedSignal("Disabled"):Connect(function() -- Line: 1623
        -- upvalues: TopbarButtons (ref), u227 (copy)
        local Attribute = TopbarButtons:GetAttribute("Disabled");
        u227:setEnabled(not Attribute);

        if Attribute then
            u227:deselect();
        end;
    end);
    u224.topbarIcon = u227;
    u227:setEnabled(not TopbarButtons:GetAttribute("Disabled"));
end;

function u30.allowRender(p228) -- Line: 1637
    p228.isInitialized = true;
end;

function u30.fadeMusicIn(p229) -- Line: 1641
    -- upvalues: Data (copy), TweenService (copy)
    if not (p229.musicFader and Data.SettingsMusic) then
        return;
    end;

    TweenService:Create(p229.musicFader, TweenInfo.new(0.75, Enum.EasingStyle.Exponential), {
        Volume = 1
    }):Play();
end;

function u30.fadeMusicOut(p230) -- Line: 1646
    -- upvalues: TweenService (copy)
    if not p230.musicFader then
        return;
    end;

    TweenService:Create(p230.musicFader, TweenInfo.new(0.75, Enum.EasingStyle.Exponential), {
        Volume = 0
    }):Play();
end;

function u30.show(p231) -- Line: 1651
    -- upvalues: TweenService (copy), SettingsBlur (copy), TweenInfo_new_ret (copy)
    TweenService:Create(SettingsBlur, TweenInfo.new(0.75), {
        Size = 16
    }):Play();
    TweenService:Create(p231.ui.BottomBar, TweenInfo_new_ret, {
        Position = UDim2.fromScale(0, 1)
    }):Play();
    TweenService:Create(p231.ui.TopBar, TweenInfo_new_ret, {
        Position = UDim2.fromScale(0, 0)
    }):Play();
    TweenService:Create(p231.ui.RightTab, TweenInfo_new_ret, {
        Position = UDim2.fromScale(0.99, 0.5)
    }):Play();
    TweenService:Create(p231.ui.SettingsTab, TweenInfo_new_ret, {
        Position = UDim2.fromScale(0.01, 0.5)
    }):Play();
    p231:fadeMusicIn();
    p231:_show();
end;

function u30._show(u232) -- Line: 1663
    -- upvalues: RunService (copy), u1 (copy), UserInputService2 (copy), GuiService (copy), LocalPlayer (copy)
    u232.ui.Visible = true;
    u232.settingsScroll:setVisible(true);
    u232.onShow:Fire();
    u232.updateConnection = RunService.RenderStepped:Connect(function(p233) -- Line: 1669
        -- upvalues: u232 (copy)
        u232:update(p233);
    end);
    task.delay(0.16, function() -- Line: 1673
        -- upvalues: u1 (ref)
        u1:Enable();
    end);

    if UserInputService2.TouchEnabled then
        GuiService.TouchControlsEnabled = false;
    end;

    local v234 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v234 then
        v234.WalkSpeed = 0;
        v234.JumpPower = 0;
    end;

    u232:render();
end;

function u30.hide(p235) -- Line: 1690
    -- upvalues: TweenService (copy), SettingsBlur (copy), TweenInfo_new_ret (copy), UserInputService2 (copy), GuiService (copy), LocalPlayer (copy), StarterPlayer (copy)
    TweenService:Create(SettingsBlur, TweenInfo_new_ret, {
        Size = 0
    }):Play();
    TweenService:Create(p235.ui.BottomBar, TweenInfo_new_ret, {
        Position = UDim2.fromScale(0, 1.2)
    }):Play();
    TweenService:Create(p235.ui.TopBar, TweenInfo_new_ret, {
        Position = UDim2.fromScale(0, -0.2)
    }):Play();
    TweenService:Create(p235.ui.RightTab, TweenInfo_new_ret, {
        Position = UDim2.fromScale(1.4, 0.5)
    }):Play();
    TweenService:Create(p235.ui.SettingsTab, TweenInfo_new_ret, {
        Position = UDim2.fromScale(-0.55, 0.5)
    }):Play();
    p235:fadeMusicOut();

    if UserInputService2.TouchEnabled then
        GuiService.TouchControlsEnabled = true;
    end;

    local v236 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v236 then
        v236.WalkSpeed = StarterPlayer.CharacterWalkSpeed;
        v236.JumpPower = StarterPlayer.CharacterJumpPower;
    end;

    p235:_hide();
end;

function u30._hide(p237) -- Line: 1712
    -- upvalues: u1 (copy)
    if p237.updateConnection then
        p237.updateConnection:Disconnect();
        p237.updateConnection = nil;
    end;

    p237.onHide:Fire();
    p237.ui.Visible = false;
    p237.settingsScroll:setVisible(false);
    p237:setSubmenuState(false);

    for _, child in p237.ui.SubStates:GetChildren() do
        if child:GetAttribute("Running") then
            child:SetAttribute("Running", false);
        end;
    end;

    u1:Disable();
end;

return u30;