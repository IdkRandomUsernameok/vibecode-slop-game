-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local ContentProvider = game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local StarterGui = game:GetService("StarterGui");
local Players = game:GetService("Players");
require(script.Types);
local l_script = script;
local Reference = require(l_script.Reference);
local Object = Reference.getObject();
local v1;

if Object then
    v1 = Object.Value;
else
    v1 = Object;
end;

if v1 and v1 ~= l_script then
    return require(v1);
end;

if not Object then
    Reference.addToReplicatedStorage();
end;

local GoodSignal = require(l_script.Packages.GoodSignal);
local Janitor = require(l_script.Packages.Janitor);
local Utility = require(l_script.Utility);
local Themes = require(l_script.Features.Themes);
local Gamepad = require(l_script.Features.Gamepad);
local Overflow = require(l_script.Features.Overflow);
local u2 = {};
u2.__index = u2;
local LocalPlayer = Players.LocalPlayer;
local Themes2 = l_script.Features.Themes;
local u3 = {};
local u4 = GoodSignal.new();
local Elements = l_script.Elements;
local u5 = 0;
local u6 = {
    mobile = Enum.PreferredInput.Touch,
    desktop = Enum.PreferredInput.KeyboardAndMouse,
    console = Enum.PreferredInput.Gamepad
};
u2.baseDisplayOrderChanged = GoodSignal.new();
u2.baseDisplayOrder = 10;
u2.baseTheme = Themes2.Default;
u2.isOldTopbar = false;
u2.iconsDictionary = u3;
u2.groupHandlers = {};
u2.insetHeightChanged = GoodSignal.new();
u2.container = require(Elements.Container)(u2);
u2.topbarEnabled = true;
u2.iconAdded = GoodSignal.new();
u2.iconRemoved = GoodSignal.new();
u2.iconChanged = GoodSignal.new();
local _TopbarPlusGetGameInfo = ReplicatedStorage:WaitForChild("_TopbarPlusGetGameInfo", 10);

if _TopbarPlusGetGameInfo then
    u2.gameInfo = _TopbarPlusGetGameInfo:InvokeServer();
end;

local v7 = not RunService:IsStudio() and u2.gameInfo.IsPrivate;
u2.playtestMode = v7;

function u2.getIcons(p8: boolean?) -- Line: 119
    -- upvalues: u2 (copy)
    local v9 = p8 == nil and true or p8;
    local v10 = {};

    for _, v in u2.iconsDictionary do
        if not (v.isGroupHandler and v9) then
            table.insert(v10, v);
        end;
    end;

    return v10;
end;

function u2.getIconByUID(p11) -- Line: 132
    -- upvalues: u2 (copy)
    return u2.iconsDictionary[p11] or nil;
end;

function u2.getIcon(p12) -- Line: 140
    -- upvalues: u2 (copy), u3 (copy)
    local IconByUID = u2.getIconByUID(p12);

    if IconByUID then
        return IconByUID;
    end;

    for _, v in pairs(u3) do
        if v.name == p12 then
            return v;
        end;
    end;

    return nil;
end;

function u2.setTopbarEnabled(p13, p14) -- Line: 153
    -- upvalues: u2 (copy)
    if typeof(p13) ~= "boolean" then
        p13 = u2.topbarEnabled;
    end;

    if not p14 then
        u2.topbarEnabled = p13;
    end;

    for _, v in pairs(u2.container) do
        v.Enabled = p13;
    end;
end;

function u2.modifyBaseTheme(p15) -- Line: 165
    -- upvalues: u2 (copy), Themes (copy), u3 (copy)
    if typeof(p15) == "Instance" and p15.ClassName == "ModuleScript" then
        p15 = require(p15);
    end;

    if typeof(p15) == "function" then
        p15 = p15(u2.playtestMode);
    end;

    local Modifications = Themes.getModifications(p15);

    for _, v in pairs(Modifications) do
        local v16 = v;

        for _, v2 in pairs(u2.baseTheme) do
            Themes.merge(v2, v16);
        end;
    end;

    for _, v in pairs(u3) do
        v:setTheme(u2.baseTheme);
    end;
end;

function u2.setDisplayOrder(p17) -- Line: 184
    -- upvalues: u2 (copy)
    u2.baseDisplayOrder = p17;
    u2.baseDisplayOrderChanged:Fire(p17);
end;

task.defer(Gamepad.start, u2);
task.defer(Overflow.start, u2);
task.defer(function() -- Line: 194
    -- upvalues: LocalPlayer (copy), u2 (copy)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");

    for _, v in pairs(u2.container) do
        v.Parent = PlayerGui;
    end;
end);

function u2.new() -- Line: 204
    -- upvalues: u2 (copy), Janitor (copy), Utility (copy), u3 (copy), GoodSignal (copy), l_script (copy), Elements (copy), u5 (ref), UserInputService (copy), u6 (copy), u4 (copy), StarterGui (copy)
    local u18 = {};
    setmetatable(u18, u2);
    local v19 = Janitor.new();
    u18.janitor = v19;
    u18.themesJanitor = v19:add(Janitor.new());
    u18.singleClickJanitor = v19:add(Janitor.new());
    u18.captionJanitor = v19:add(Janitor.new());
    u18.joinJanitor = v19:add(Janitor.new());
    u18.menuJanitor = v19:add(Janitor.new());
    u18.dropdownJanitor = v19:add(Janitor.new());
    local u20 = Utility.generateUID();
    u3[u20] = u18;
    v19:add(function() -- Line: 221
        -- upvalues: u3 (ref), u20 (copy)
        u3[u20] = nil;
    end);
    u18.selected = v19:add(GoodSignal.new());
    u18.deselected = v19:add(GoodSignal.new());
    u18.toggled = v19:add(GoodSignal.new());
    u18.viewingStarted = v19:add(GoodSignal.new());
    u18.viewingEnded = v19:add(GoodSignal.new());
    u18.stateChanged = v19:add(GoodSignal.new());
    u18.notified = v19:add(GoodSignal.new());
    u18.noticeStarted = v19:add(GoodSignal.new());
    u18.noticeChanged = v19:add(GoodSignal.new());
    u18.endNotices = v19:add(GoodSignal.new());
    u18.toggleKeyAdded = v19:add(GoodSignal.new());
    u18.fakeToggleKeyChanged = v19:add(GoodSignal.new());
    u18.alignmentChanged = v19:add(GoodSignal.new());
    u18.updateSize = v19:add(GoodSignal.new());
    u18.resizingComplete = v19:add(GoodSignal.new());
    u18.joinedParent = v19:add(GoodSignal.new());
    u18.menuSet = v19:add(GoodSignal.new());
    u18.dropdownSet = v19:add(GoodSignal.new());
    u18.updateMenu = v19:add(GoodSignal.new());
    u18.startMenuUpdate = v19:add(GoodSignal.new());
    u18.childThemeModified = v19:add(GoodSignal.new());
    u18.indicatorSet = v19:add(GoodSignal.new());
    u18.dropdownChildAdded = v19:add(GoodSignal.new());
    u18.menuChildAdded = v19:add(GoodSignal.new());
    u18.iconModule = l_script;
    u18.UID = u20;
    u18.isEnabled = true;
    u18.enabled = u18.isEnabled;
    u18.isSelected = false;
    u18.isViewing = false;
    u18.joinedFrame = false;
    u18.parentIconUID = false;
    u18.deselectWhenOtherIconSelected = true;
    u18.totalNotices = 0;
    u18.activeState = "Deselected";
    u18.alignment = "";
    u18.originalAlignment = "";
    u18.appliedTheme = {};
    u18.appearance = {};
    u18.cachedInstances = {};
    u18.cachedNamesToInstances = {};
    u18.cachedCollectives = {};
    u18.bindedToggleKeys = {};
    u18.customBehaviours = {};
    u18.toggleItems = {};
    u18.bindedEvents = {};
    u18.notices = {};
    u18.menuIcons = {};
    u18.dropdownIcons = {};
    u18.childIconsDict = {};
    u18.creationTime = os.clock();
    u18.groupName = nil;
    u18.isGroupHandler = false;
    u18.widget = v19:add(require(Elements.Widget)(u18, u2));
    u18:setAlignment();
    u5 = u5 + 1;
    local v21 = u5 * 0.01 + 1;
    u18:setOrder(v21, "deselected");
    u18:setOrder(v21, "selected");
    u18:setTheme(u2.baseTheme);
    local Instance = u18:getInstance("ClickRegion");
    local u22 = false;
    local u23 = 0;

    local function handleToggle() -- Line: 303
        -- upvalues: u18 (copy), u23 (ref)
        if u18.locked then
            return;
        end;

        local v24 = tick();

        if v24 - u23 < 0.1 then
            return;
        end;

        u23 = v24;

        if u18.isSelected then
            u18:deselect("User", u18);

            return;
        end;

        u18:select("User", u18);
    end;

    Instance.MouseButton1Click:Connect(function() -- Line: 322
        -- upvalues: u22 (ref), u18 (copy), u23 (ref)
        u22 = true;

        if u18.locked then
            return;
        end;

        local v25 = tick();

        if v25 - u23 < 0.1 then
            return;
        end;

        u23 = v25;

        if u18.isSelected then
            u18:deselect("User", u18);

            return;
        end;

        u18:select("User", u18);
    end);
    Instance.TouchTap:Connect(function() -- Line: 327
        -- upvalues: u22 (ref), u18 (copy), u23 (ref)
        if not u22 then
            if u18.locked then
                return;
            end;

            local v26 = tick();

            if v26 - u23 < 0.1 then
                return;
            end;

            u23 = v26;

            if u18.isSelected then
                u18:deselect("User", u18);

                return;
            end;

            u18:select("User", u18);
        end;
    end);
    v19:add(UserInputService.InputBegan:Connect(function(p27, p28) -- Line: 340
        -- upvalues: u18 (copy), u23 (ref)
        if u18.locked then
            return;
        end;

        if u18.bindedToggleKeys[p27.KeyCode] and not p28 then
            if u18.locked then
                return;
            end;

            local v29 = tick();

            if v29 - u23 < 0.1 then
                return;
            end;

            u23 = v29;

            if u18.isSelected then
                u18:deselect("User", u18);

                return;
            end;

            u18:select("User", u18);
        end;
    end));

    local function viewingEnded() -- Line: 362
        -- upvalues: u18 (copy)
        if u18.locked then
            return;
        end;

        u18.isViewing = false;
        u18.viewingEnded:Fire(true);
        u18:setState(nil, "User", u18);
    end;

    u18.joinedParent:Connect(function() -- Line: 370
        -- upvalues: u18 (copy)
        if u18.isViewing then
            if u18.locked then
                return;
            end;

            u18.isViewing = false;
            u18.viewingEnded:Fire(true);
            u18:setState(nil, "User", u18);
        end;
    end);
    Instance.MouseEnter:Connect(function() -- Line: 375
        -- upvalues: UserInputService (ref), u6 (ref), u18 (copy)
        local v30 = UserInputService.PreferredInput ~= u6.desktop;

        if u18.locked then
            return;
        end;

        u18.isViewing = true;
        u18.viewingStarted:Fire(true);

        if not v30 then
            u18:setState("Viewing", "User", u18);
        end;
    end);
    local u31 = 0;
    v19:add(UserInputService.TouchEnded:Connect(viewingEnded));
    Instance.MouseLeave:Connect(viewingEnded);
    Instance.SelectionGained:Connect(function(p32) -- Line: 352, Name: viewingStarted
        -- upvalues: u18 (copy)
        if u18.locked then
            return;
        end;

        u18.isViewing = true;
        u18.viewingStarted:Fire(true);

        if not p32 then
            u18:setState("Viewing", "User", u18);
        end;
    end);
    Instance.SelectionLost:Connect(viewingEnded);
    Instance.MouseButton1Down:Connect(function() -- Line: 384
        -- upvalues: u18 (copy), UserInputService (ref), u6 (ref), u31 (ref)
        if not u18.locked and UserInputService.PreferredInput == u6.mobile then
            u31 = u31 + 1;
            local u33 = u31;
            task.delay(0.2, function() -- Line: 388
                -- upvalues: u33 (copy), u31 (ref), u18 (ref)
                if u33 == u31 then
                    if u18.locked then
                        return;
                    end;

                    u18.isViewing = true;
                    u18.viewingStarted:Fire(true);
                    u18:setState("Viewing", "User", u18);
                end;
            end);
        end;
    end);
    Instance.MouseButton1Up:Connect(function() -- Line: 395
        -- upvalues: u31 (ref)
        u31 = u31 + 1;
    end);
    local Instance2 = u18:getInstance("IconOverlay");
    u18.viewingStarted:Connect(function() -- Line: 401
        -- upvalues: Instance2 (copy), u18 (copy)
        Instance2.Visible = not u18.overlayDisabled;
    end);
    u18.viewingEnded:Connect(function() -- Line: 404
        -- upvalues: Instance2 (copy)
        Instance2.Visible = false;
    end);
    v19:add(u4:Connect(function(p34) -- Line: 409
        -- upvalues: u18 (copy)
        if p34 ~= u18 and (u18.deselectWhenOtherIconSelected and p34.deselectWhenOtherIconSelected) then
            u18:deselect("AutoDeselect", p34);
        end;
    end));
    local debug_info_ret = debug.info(2, "s");
    local string_split_ret = string.split(debug_info_ret, ".");
    local l_game = game;
    local v35 = nil;

    for _, v in pairs(string_split_ret) do
        l_game = l_game:FindFirstChild(v);

        if not l_game then
            break;
        end;

        if l_game:IsA("ScreenGui") then
            v35 = l_game;
        end;
    end;

    if l_game and (v35 and v35.ResetOnSpawn == true) then
        u18.originsScreenGui = v35;
        Utility.localPlayerRespawned(function() -- Line: 435
            -- upvalues: u18 (copy)
            u18:destroy();
        end);
    end;

    u18.toggled:Connect(function(p36) -- Line: 441
        -- upvalues: u18 (copy), u2 (ref)
        u18.noticeChanged:Fire(u18.totalNotices);

        for i, _ in pairs(u18.childIconsDict) do
            local IconByUID = u2.getIconByUID(i);
            IconByUID.noticeChanged:Fire(IconByUID.totalNotices);

            if not p36 and IconByUID.isSelected then
                for _, _ in pairs(IconByUID.childIconsDict) do
                    IconByUID:deselect("HideParentFeature", u18);
                end;
            end;
        end;
    end);
    u18.selected:Connect(function() -- Line: 464
        -- upvalues: u18 (copy), StarterGui (ref)
        if #u18.dropdownIcons > 0 then
            if StarterGui:GetCore("ChatActive") and u18.alignment ~= "Right" then
                u18.chatWasPreviouslyActive = true;
                StarterGui:SetCore("ChatActive", false);
            end;

            if StarterGui:GetCoreGuiEnabled("PlayerList") and u18.alignment ~= "Left" then
                u18.playerlistWasPreviouslyActive = true;
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
            end;
        end;
    end);
    u18.deselected:Connect(function() -- Line: 477
        -- upvalues: u18 (copy), StarterGui (ref)
        if u18.chatWasPreviouslyActive then
            u18.chatWasPreviouslyActive = nil;
            StarterGui:SetCore("ChatActive", true);
        end;

        if u18.playerlistWasPreviouslyActive then
            u18.playerlistWasPreviouslyActive = nil;
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
        end;
    end);
    task.delay(0.1, function() -- Line: 491
        -- upvalues: u18 (copy)
        if u18.activeState == "Deselected" then
            u18.stateChanged:Fire("Deselected");
            u18:refresh();
        end;
    end);
    u2.iconAdded:Fire(u18);

    return u18;
end;

function u2.setName(p37, p38) -- Line: 507
    p37.widget.Name = p38;
    p37.name = p38;

    return p37;
end;

function u2.setState(p39, p40, p41, p42) -- Line: 513
    -- upvalues: Utility (copy), u4 (copy)
    local v43 = Utility.formatStateName(p40 or (p39.isSelected and "Selected" or "Deselected"));

    if p39.activeState == v43 then
        return;
    end;

    local isSelected = p39.isSelected;
    p39.activeState = v43;

    if v43 == "Deselected" then
        p39.isSelected = false;

        if isSelected then
            p39.toggled:Fire(false, p41, p42);
            p39.deselected:Fire(p41, p42);
        end;

        p39:_setToggleItemsVisible(false, p41, p42);
    elseif v43 == "Selected" then
        p39.isSelected = true;

        if not isSelected then
            p39.toggled:Fire(true, p41, p42);
            p39.selected:Fire(p41, p42);
            u4:Fire(p39, p41, p42);
        end;

        p39:_setToggleItemsVisible(true, p41, p42);
    end;

    p39.stateChanged:Fire(v43, p41, p42);
    p39:updateParent("setState");
end;

function u2.getInstance(u44, u45) -- Line: 547
    -- upvalues: Themes (copy)
    local v46 = u44.cachedNamesToInstances[u45];

    if v46 then
        return v46;
    end;

    local function cacheInstance(u47, u48) -- Line: 555
        -- upvalues: u44 (copy)
        if not u44.cachedInstances[u48] then
            local Attribute = u48:GetAttribute("Collective");

            if Attribute then
                Attribute = u44.cachedCollectives[Attribute];
            end;

            if Attribute then
                table.insert(Attribute, u48);
            end;

            u44.cachedNamesToInstances[u47] = u48;
            u44.cachedInstances[u48] = true;
            u48.Destroying:Once(function() -- Line: 565
                -- upvalues: u44 (ref), u47 (copy), u48 (copy)
                u44.cachedNamesToInstances[u47] = nil;
                u44.cachedInstances[u48] = nil;
            end);
        end;
    end;

    local widget = u44.widget;
    cacheInstance("Widget", widget);

    if u45 == "Widget" then
        return widget;
    end;

    local u49 = nil;

    local function scanChildren(p50) -- Line: 578
        -- upvalues: u44 (copy), Themes (ref), scanChildren (copy), cacheInstance (copy), u45 (copy), u49 (ref)
        for _, child in pairs(p50:GetChildren()) do
            local Attribute = child:GetAttribute("WidgetUID");

            if not Attribute or Attribute == u44.UID then
                local v51 = Themes.getRealInstance(child) or child;
                scanChildren(v51);

                if v51:IsA("GuiBase") or (v51:IsA("UIBase") or v51:IsA("ValueBase")) then
                    local Name = v51.Name;
                    cacheInstance(Name, v51);

                    if Name == u45 then
                        u49 = v51;
                    end;
                end;
            end;
        end;
    end;

    scanChildren(widget);

    return u49;
end;

function u2.getCollective(p52, p53) -- Line: 607
    local v54 = p52.cachedCollectives[p53];

    if v54 then
        return v54;
    end;

    local v55 = {};

    for i, _ in pairs(p52.cachedInstances) do
        if i:GetAttribute("Collective") == p53 then
            table.insert(v55, i);
        end;
    end;

    p52.cachedCollectives[p53] = v55;

    return v55;
end;

function u2.getInstanceOrCollective(p56, p57) -- Line: 628
    local v58 = {};
    local Instance = p56:getInstance(p57);

    if Instance then
        table.insert(v58, Instance);
    end;

    if #v58 == 0 then
        v58 = p56:getCollective(p57);
    end;

    return v58;
end;

function u2.getStateGroup(p59, p60) -- Line: 642
    local v61 = p60 or p59.activeState;
    local v62 = p59.appearance[v61];

    if not v62 then
        v62 = {};
        p59.appearance[v61] = v62;
    end;

    return v62;
end;

function u2.refreshAppearance(p63, p64, p65) -- Line: 652
    -- upvalues: Themes (copy)
    Themes.refresh(p63, p64, p65);

    return p63;
end;

function u2.refresh(p66) -- Line: 657
    p66:refreshAppearance(p66.widget);
    p66.updateSize:Fire();

    return p66;
end;

function u2.updateParent(p67: table, p68: string) -- Line: 663
    -- upvalues: u2 (copy)
    if p67.isGroupHandler then
        return;
    end;

    local IconByUID = u2.getIconByUID(p67.parentIconUID);

    if IconByUID then
        IconByUID.updateSize:Fire();

        if IconByUID.isGroupHandler and p68 == "setEnabled" then
            local v69 = 0;

            for _, v in IconByUID.menuIcons do
                if u2.getIconByUID(v).isEnabled then
                    v69 = v69 + 1;
                end;
            end;

            local v70 = v69 > 0;

            if IconByUID.isEnabled ~= v70 then
                IconByUID:setEnabled(v70);
            end;
        end;
    end;
end;

function u2.setBehaviour(p71, p72, p73, p74, p75) -- Line: 687
    p71.customBehaviours[p72 .. "-" .. p73] = p74;

    if p75 then
        local InstanceOrCollective = p71:getInstanceOrCollective(p72);

        for _, v in pairs(InstanceOrCollective) do
            p71:refreshAppearance(v, p73);
        end;
    end;
end;

function u2.modifyTheme(p76, p77, p78) -- Line: 700
    -- upvalues: Themes (copy)
    return p76, Themes.modify(p76, p77, p78);
end;

function u2.modifyChildTheme(p79, p80, p81) -- Line: 705
    -- upvalues: u2 (copy)
    p79.childModifications = p80;
    p79.childModificationsUID = p81;

    for i, _ in pairs(p79.childIconsDict) do
        u2.getIconByUID(i):modifyTheme(p80, p81);
    end;

    p79.childThemeModified:Fire();

    return p79;
end;

function u2.removeModification(p82, p83) -- Line: 718
    -- upvalues: Themes (copy)
    Themes.remove(p82, p83);

    return p82;
end;

function u2.removeModificationWith(p84, p85, p86, p87) -- Line: 723
    -- upvalues: Themes (copy)
    Themes.removeWith(p84, p85, p86, p87);

    return p84;
end;

function u2.setTheme(p88, p89) -- Line: 728
    -- upvalues: u2 (copy), Themes (copy)
    if typeof(p89) == "Instance" and p89.ClassName == "ModuleScript" then
        p89 = require(p89);
    end;

    if typeof(p89) == "function" then
        p89 = p89(u2.playtestMode);
    end;

    Themes.set(p88, p89);

    return p88;
end;

function u2.setEnabled(p90, p91) -- Line: 740
    -- upvalues: u2 (copy)
    p90.isEnabled = p91;
    p90.enabled = p90.isEnabled;
    p90.widget.Visible = p91;
    p90:updateParent("setEnabled");
    u2.iconChanged:Fire(p90);

    return p90;
end;

function u2.select(p92, p93, p94) -- Line: 749
    p92:setState("Selected", p93, p94);

    return p92;
end;

function u2.deselect(p95, p96, p97) -- Line: 754
    p95:setState("Deselected", p96, p97);

    return p95;
end;

function u2.notify(p98, p99, p100) -- Line: 759
    -- upvalues: Elements (copy), u2 (copy)
    if not p98.notice then
        p98.notice = require(Elements.Notice)(p98, u2);
    end;

    p98.noticeStarted:Fire(p99, p100);

    return p98;
end;

function u2.clearNotices(p101) -- Line: 773
    p101.endNotices:Fire();

    return p101;
end;

function u2.disableOverlay(p102, p103) -- Line: 778
    p102.overlayDisabled = p103;

    return p102;
end;

u2.disableStateOverlay = u2.disableOverlay;

function u2.setImage(p104, u105, p106) -- Line: 784
    -- upvalues: ContentProvider (copy)
    p104:modifyTheme({
        "IconImage",
        "Image",
        u105,
        p106
    });
    task.spawn(function() -- Line: 788
        -- upvalues: u105 (copy), ContentProvider (ref)
        local v107;

        if tonumber(u105) then
            v107 = `rbxassetid://{u105}`;
        else
            v107 = u105;
        end;

        if ContentProvider:GetAssetFetchStatus(v107) ~= Enum.AssetFetchStatus.Success then
            pcall(ContentProvider.PreloadAsync, ContentProvider, { v107 });
        end;
    end);

    return p104;
end;

function u2.setLabel(p108, p109, p110) -- Line: 800
    p108:modifyTheme({
        "IconLabel",
        "Text",
        p109,
        p110
    });

    return p108;
end;

function u2.setOrder(p111, p112, p113) -- Line: 805
    local v114 = p112 * 100;
    p111:modifyTheme({
        "IconSpot",
        "LayoutOrder",
        v114,
        p113
    });
    p111:modifyTheme({
        "Widget",
        "LayoutOrder",
        v114,
        p113
    });

    return p111;
end;

function u2.setCornerRadius(p115, p116, p117) -- Line: 814
    p115:modifyTheme({
        "IconCorners",
        "CornerRadius",
        p116,
        p117
    });

    return p115;
end;

function u2.align(p118, p119, p120) -- Line: 819
    -- upvalues: u2 (copy)
    local v121 = tostring(p119):lower();
    local v122 = (v121 == "mid" or v121 == "centre") and "center" or v121;
    local v123 = v122 ~= "left" and (v122 ~= "center" and v122 ~= "right") and "left" or v122;
    local v124 = v123 == "center" and u2.container.TopbarCentered or u2.container.TopbarStandard;
    local Holders = v124.Holders;
    local v125 = string.upper((string.sub(v123, 1, 1))) .. string.sub(v123, 2);

    if not p120 then
        p118.originalAlignment = v125;
    end;

    local joinedFrame = p118.joinedFrame;
    local v126 = Holders[v125];
    p118.screenGui = v124;
    p118.alignmentHolder = v126;

    if not p118.isDestroyed then
        p118.widget.Parent = joinedFrame or v126;
    end;

    p118.alignment = v125;
    p118.alignmentChanged:Fire(v125);
    u2.iconChanged:Fire(p118);

    return p118;
end;

u2.setAlignment = u2.align;

function u2.setLeft(p127) -- Line: 848
    p127:setAlignment("Left");

    return p127;
end;

function u2.setMid(p128) -- Line: 853
    p128:setAlignment("Center");

    return p128;
end;

function u2.setRight(p129) -- Line: 858
    p129:setAlignment("Right");

    return p129;
end;

function u2.setWidth(p130, p131, p132) -- Line: 863
    p130:modifyTheme({
        "Widget",
        "DesiredWidth",
        p131,
        p132
    });

    return p130;
end;

function u2.setImageScale(p133, p134, p135) -- Line: 871
    p133:modifyTheme({
        "IconImageScale",
        "Value",
        p134,
        p135
    });

    return p133;
end;

function u2.setImageRatio(p136, p137, p138) -- Line: 876
    p136:modifyTheme({
        "IconImageRatio",
        "AspectRatio",
        p137,
        p138
    });

    return p136;
end;

function u2.setTextSize(p139, p140, p141) -- Line: 881
    p139:modifyTheme({
        "IconLabel",
        "TextSize",
        p140,
        p141
    });

    return p139;
end;

function u2.setTextFont(p142, p143, p144, p145, p146) -- Line: 886
    local v147 = p144 or Enum.FontWeight.Regular;
    local v148 = p145 or Enum.FontStyle.Normal;
    local v149 = nil;
    local v150 = typeof(p143);

    if v150 == "number" then
        v149 = Font.fromId(p143, v147, v148);
    elseif v150 == "EnumItem" then
        v149 = Font.fromEnum(p143);
    elseif v150 == "string" and not p143:match("rbxasset") then
        v149 = Font.fromName(p143, v147, v148);
    end;

    p142:modifyTheme({
        "IconLabel",
        "FontFace",
        v149 or Font.new(p143, v147, v148),
        p146
    });

    return p142;
end;

function u2.setTextColor(p151, p152, p153) -- Line: 907
    if p152 == nil or (p152 == "" or (type(p152) ~= "userdata" or typeof(p152) ~= "Color3")) then
        if p152 ~= nil and p152 ~= "" then
            warn("setTextColor item must be a Color3 value! Changed the color to white.");
        end;

        p152 = Color3.fromRGB(255, 255, 255);
    end;

    p151:modifyTheme({
        "IconLabel",
        "TextColor3",
        p152,
        p153
    });

    return p151;
end;

function u2.bindToggleItem(p154, p155) -- Line: 919
    if not (p155:IsA("GuiObject") or p155:IsA("LayerCollector")) then
        error("Toggle item must be a GuiObject or LayerCollector!");
    end;

    p154.toggleItems[p155] = true;
    p154:_updateSelectionInstances();

    return p154;
end;

function u2.unbindToggleItem(p156, p157) -- Line: 928
    p156.toggleItems[p157] = nil;
    p156:_updateSelectionInstances();

    return p156;
end;

function u2._updateSelectionInstances(p158) -- Line: 934
    for i, _ in pairs(p158.toggleItems) do
        local v159 = {};

        for _, descendant in pairs(i:GetDescendants()) do
            if (descendant:IsA("TextButton") or descendant:IsA("ImageButton")) and descendant.Active then
                table.insert(v159, descendant);
            end;
        end;

        p158.toggleItems[i] = v159;
    end;
end;

function u2._setToggleItemsVisible(p160, p161, p162, p163) -- Line: 948
    for i, _ in pairs(p160.toggleItems) do
        if not (p163 and (p163 ~= p160 and p163.toggleItems[i] ~= nil)) then
            i[i:IsA("LayerCollector") and "Enabled" or "Visible"] = p161;
        end;
    end;
end;

function u2.bindEvent(u164, p165, u166) -- Line: 960
    local v167 = u164[p165];
    local v168;

    if v167 then
        if typeof(v167) == "table" then
            v168 = v167.Connect;
        else
            v168 = false;
        end;
    else
        v168 = v167;
    end;

    assert(v168, "argument[1] must be a valid topbarplus icon event name!");
    local v169 = typeof(u166) == "function";
    assert(v169, "argument[2] must be a function!");
    u164.bindedEvents[p165] = v167:Connect(function(...) -- Line: 964
        -- upvalues: u166 (copy), u164 (copy)
        u166(u164, ...);
    end);

    return u164;
end;

function u2.unbindEvent(p170, p171) -- Line: 970
    local v172 = p170.bindedEvents[p171];

    if v172 then
        v172:Disconnect();
        p170.bindedEvents[p171] = nil;
    end;

    return p170;
end;

function u2.bindToggleKey(p173, p174) -- Line: 979
    local v175 = typeof(p174) == "EnumItem";
    assert(v175, "argument[1] must be a KeyCode EnumItem!");
    p173.bindedToggleKeys[p174] = true;
    p173.toggleKeyAdded:Fire(p174);
    p173:setCaption("_hotkey_");

    return p173;
end;

function u2.unbindToggleKey(p176, p177) -- Line: 987
    local v178 = typeof(p177) == "EnumItem";
    assert(v178, "argument[1] must be a KeyCode EnumItem!");
    p176.bindedToggleKeys[p177] = nil;

    return p176;
end;

function u2.call(u179, u180, ...) -- Line: 993
    local table_pack_ret = table.pack(...);
    task.spawn(function() -- Line: 995
        -- upvalues: u180 (copy), u179 (copy), table_pack_ret (copy)
        u180(u179, table.unpack(table_pack_ret));
    end);

    return u179;
end;

function u2.addToJanitor(p181, p182, p183, p184) -- Line: 1001
    p181.janitor:add(p182, p183, p184);

    return p181;
end;

function u2.lock(p185) -- Line: 1006
    p185:getInstance("ClickRegion").Visible = false;
    p185.locked = true;

    return p185;
end;

function u2.unlock(p186) -- Line: 1014
    p186:getInstance("ClickRegion").Visible = true;
    p186.locked = false;

    return p186;
end;

function u2.debounce(p187, p188) -- Line: 1021
    p187:lock();
    task.wait(p188);
    p187:unlock();

    return p187;
end;

function u2.autoDeselect(p189, p190) -- Line: 1028
    p189.deselectWhenOtherIconSelected = p190 == nil and true or p190;

    return p189;
end;

function u2.oneClick(u191, p192) -- Line: 1038
    local singleClickJanitor = u191.singleClickJanitor;
    singleClickJanitor:clean();

    if p192 or p192 == nil then
        singleClickJanitor:add(u191.selected:Connect(function() -- Line: 1044
            -- upvalues: u191 (copy)
            u191:deselect("OneClick", u191);
        end));
    end;

    u191.oneClickEnabled = true;

    return u191;
end;

function u2.setCaption(p193, p194) -- Line: 1052
    -- upvalues: Elements (copy)
    if p194 == "_hotkey_" and p193.captionText then
        return p193;
    end;

    local captionJanitor = p193.captionJanitor;
    p193.captionJanitor:clean();

    if not p194 or p194 == "" then
        p193.caption = nil;
        p193.captionText = nil;

        return p193;
    end;

    local v195 = captionJanitor:add(require(Elements.Caption)(p193));
    v195:SetAttribute("CaptionText", p194);
    p193.caption = v195;
    p193.captionText = p194;

    return p193;
end;

function u2.setCaptionHint(p196, p197) -- Line: 1070
    local v198 = typeof(p197) == "EnumItem";
    assert(v198, "argument[1] must be a KeyCode EnumItem!");
    p196.fakeToggleKey = p197;
    p196.fakeToggleKeyChanged:Fire(p197);
    p196:setCaption("_hotkey_");

    return p196;
end;

function u2.leave(p199) -- Line: 1078
    p199.joinJanitor:clean();

    return p199;
end;

function u2.joinMenu(p200, p201) -- Line: 1084
    -- upvalues: Utility (copy)
    Utility.joinFeature(p200, p201, p201.menuIcons, p201:getInstance("Menu"));
    p201.menuChildAdded:Fire(p200);

    return p200;
end;

function u2.setMenu(p202, p203) -- Line: 1090
    p202.menuSet:Fire(p203);

    return p202;
end;

function u2.setFixedMenu(p204, p205) -- Line: 1095
    p204:freezeMenu();
    p204:setMenu(p205);
end;

u2.setFrozenMenu = u2.setFixedMenu;

function u2.setGroup(p206: table, p207: string) -- Line: 1101
    -- upvalues: u2 (copy)
    p206.groupName = p207;

    if p206.isGroupHandler then
        return p206;
    end;

    local v208 = u2.groupHandlers[p207];

    if v208 == nil then
        local Instance = p206:getInstance("IconSpot");
        v208 = u2.new():align(p206.alignment):setLabel(p207):lock();
        v208:setOrder(Instance.LayoutOrder / 100);
        v208.isGroupHandler = true;
        u2.groupHandlers[p207] = v208;
    end;

    p206:joinMenu(v208);
    v208:freezeMenu();

    return p206;
end;

function u2.freezeMenu(u209) -- Line: 1126
    u209:select("FrozenMenu", u209);
    u209:bindEvent("deselected", function(p210) -- Line: 1130
        -- upvalues: u209 (copy)
        p210:select("FrozenMenu", u209);
    end);
    u209:modifyTheme({ "IconSpot", "Visible", false });
end;

function u2.joinDropdown(p211, p212) -- Line: 1136
    -- upvalues: Utility (copy)
    p212:getDropdown();
    Utility.joinFeature(p211, p212, p212.dropdownIcons, p212:getInstance("DropdownScroller"));
    p212.dropdownChildAdded:Fire(p211);

    return p211;
end;

function u2.getDropdown(p213) -- Line: 1143
    -- upvalues: Elements (copy)
    local dropdown = p213.dropdown;

    if not dropdown then
        dropdown = require(Elements.Dropdown)(p213);
        p213.dropdown = dropdown;
        p213:clipOutside(dropdown);
    end;

    return dropdown;
end;

function u2.setDropdown(p214, p215) -- Line: 1153
    p214:getDropdown();
    p214.dropdownSet:Fire(p215);

    return p214;
end;

function u2.clipOutside(p216, p217) -- Line: 1159
    -- upvalues: Utility (copy)
    local v218 = Utility.clipOutside(p216, p217);
    p216:refreshAppearance(p217);

    return p216, v218;
end;

function u2.setIndicator(p219, p220) -- Line: 1170
    -- upvalues: Elements (copy), u2 (copy)
    if not p219.indicator then
        p219.indicator = p219.janitor:add(require(Elements.Indicator)(p219, u2));
    end;

    p219.indicatorSet:Fire(p220);
end;

function u2.convertLabelToNumberSpinner(u221, u222, u223) -- Line: 1182
    task.defer(function() -- Line: 1183
        -- upvalues: u221 (copy), u222 (copy), u223 (copy)
        local Instance = u221:getInstance("IconLabel");
        Instance.Transparency = 1;
        u222.Parent = Instance.Parent;
        u222.Size = UDim2.fromScale(1, 1);
        u222.AnchorPoint = Vector2.new(0.5, 0.5);
        u222.Position = UDim2.fromScale(0.5, 0.5);
        u222.TextXAlignment = Enum.TextXAlignment.Center;
        u222.ClipsDescendants = false;

        for _, v in ipairs({ "FontFace", "BorderSizePixel", "BorderColor3", "Rotation", "TextStrokeTransparency", "TextStrokeColor3", "TextStrokeTransparency", "TextColor3" }) do
            u222[v] = Instance[v];
            u221:addToJanitor(Instance:GetPropertyChangedSignal(v):Connect(function() -- Line: 1206
                -- upvalues: u222 (ref), v (copy), Instance (copy)
                u222[v] = Instance[v];
            end));
        end;

        local function getSpinnerSizeAndDigitCount() -- Line: 1213
            -- upvalues: u222 (ref)
            local v224 = 0;
            local v225 = 0;

            for _, child in u222.Frame:GetChildren() do
                local string_lower_ret = string.lower(child.Name);

                if string_lower_ret == "digit" then
                    v224 = v224 + child.AbsoluteSize.X;
                    v225 = v225 + 1;
                elseif (string_lower_ret == "prefix" or (string_lower_ret == "suffix" or string_lower_ret == "comma")) and child.Text ~= "" then
                    v224 = v224 + child.AbsoluteSize.X;
                    v225 = v225 + 1;
                end;
            end;

            return v224, v225;
        end;

        local function getLabelParentContainerXSize() -- Line: 1231
            -- upvalues: Instance (copy), u222 (ref)
            local Parent = Instance.Parent;

            if Parent then
                Parent = Parent.Parent;
            end;

            if Parent == nil then
                return 0;
            end;

            if Parent.IconImage.Visible == true then
                return u222.Frame.AbsoluteSize.X + Instance.Parent.Parent.IconImage.AbsoluteSize.X;
            end;

            return Parent.AbsoluteSize.X;
        end;

        local function getNumberSpinnerXSize() -- Line: 1243
            -- upvalues: u222 (ref)
            return u222.Frame.AbsoluteSize.X;
        end;

        local function adjustSize() -- Line: 1247
            -- upvalues: getSpinnerSizeAndDigitCount (copy), u221 (ref), u222 (ref), Instance (copy)
            local v226, v227 = getSpinnerSizeAndDigitCount();

            if v227 < 18 then
                u221:setLabel(u222.Value);
            end;

            local X = u222.Frame.AbsoluteSize.X;

            while v226 < X and u221.isDestroyed ~= true do
                task.wait(0.05);

                if v227 > 0 and v227 < 8 then
                    u222.TextSize = Instance.TextSize;
                    break;
                end;

                local v228 = u222;
                v228.TextSize = v228.TextSize + 1;
                X = u222.Frame.AbsoluteSize.X;
                v226, v227 = getSpinnerSizeAndDigitCount();
            end;

            local Parent = Instance.Parent;

            if Parent then
                Parent = Parent.Parent;
            end;

            local v229;

            if Parent == nil then
                v229 = 0;
            elseif Parent.IconImage.Visible == true then
                v229 = u222.Frame.AbsoluteSize.X + Instance.Parent.Parent.IconImage.AbsoluteSize.X;
            else
                v229 = Parent.AbsoluteSize.X;
            end;

            while v229 < v226 and u221.isDestroyed ~= true do
                task.wait(0.05);

                if v227 < 8 and v227 > 0 then
                    u222.TextSize = Instance.TextSize;

                    return;
                end;

                local v230 = u222;
                v230.TextSize = v230.TextSize - 1;
                local Parent2 = Instance.Parent;

                if Parent2 then
                    Parent2 = Parent2.Parent;
                end;

                if Parent2 == nil then
                    v229 = 0;
                elseif Parent2.IconImage.Visible == true then
                    v229 = u222.Frame.AbsoluteSize.X + Instance.Parent.Parent.IconImage.AbsoluteSize.X;
                else
                    v229 = Parent2.AbsoluteSize.X;
                end;

                v226, v227 = getSpinnerSizeAndDigitCount();
            end;
        end;

        u221:addToJanitor(u222.Frame.ChildAdded:Connect(adjustSize));
        u221:addToJanitor(u222.Frame.ChildRemoved:Connect(adjustSize));
        u221:addToJanitor(u221.iconAdded:Connect(function() -- Line: 1285
            -- upvalues: adjustSize (copy)
            task.wait(1);
            adjustSize();
        end));
        u221:updateParent("convertLabelToNumberSpinner");
        u222.Name = "LabelSpinner";
        u222.Prefix = "$";
        u222.Commas = true;
        u222.Decimals = 0;
        u222.Duration = 0.25;
        u222.Value = 10;
        task.wait(0.2);

        if typeof(u223) == "function" then
            u223();
        end;
    end);

    return u221;
end;

function u2.destroy(p231) -- Line: 1310
    -- upvalues: u2 (copy)
    if p231.isDestroyed then
        return;
    end;

    p231:clearNotices();

    if p231.parentIconUID then
        p231:leave();
    end;

    p231.isDestroyed = true;
    p231.janitor:clean();
    u2.iconRemoved:Fire(p231);
end;

u2.Destroy = u2.destroy;

return u2;