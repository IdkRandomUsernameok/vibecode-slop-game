-- Decompiled with Potassium's decompiler.

local v1 = {};
local Players = game:GetService("Players");
game:GetService("UserService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local HttpService = game:GetService("HttpService");
local Assets = script.Parent.Parent.Assets;
local _ = ReplicatedStorage:WaitForChild("Events").UpdatePlayerLeaderboardEntry;
local PlayerTemplate = Assets.PlayerTemplate;
local Modules = ReplicatedStorage:WaitForChild("Modules");
local u2 = {
    Frame = nil,
    FrameAspectRatio = nil,
    Player = nil,
    PlayerInfo = {
        ShowVerified = false,
        Username = "...",
        DisplayName = "...",
        Tags = {}
    },
    Icons = {
        Premium = false,
        Friends = false,
        Staff = false,
        Developer = false
    },
    __Connections = {},
    __Tweens = {},
    __Internals = {
        __HumanoidDescription = nil,
        __Thumbnail = "",
        __IsCompactMode = true,
        __BannerAlwaysAnimated = false,
        __LastGuiState = Enum.GuiState.Idle
    }
};
local u3 = {};
u3.__index = u3;
local AssetIcons = require(Modules.UI.AssetIcons);
local DataManager = require(Modules.Data.DataManager);
local AppearanceManager = require(Modules.Other.AppearanceManager);
require(Modules.UI.ColorConverter);
require(Modules.UI.Overheads);
local Data = DataManager:GetData();

function u3.GetIcon(p4) -- Line: 77
    local v5 = p4.Icons.Friends and "rbxassetid://126359467305587" or (p4.Icons.Developer and "rbxassetid://10885640682" or (p4.Icons.Staff and "rbxassetid://123070296077639" or (p4.Icons.Premium and "rbxassetid://10885647358" or "")));

    return #v5 > 0, v5;
end;

function u3.RenderBanner(p6, p7) -- Line: 110
    -- upvalues: AssetIcons (copy)
    local Frame = p6.Frame;

    if not Frame then
        return;
    end;

    if p6.bannerSprite then
        p6.bannerSprite:Destroy();
        p6.bannerSprite = nil;
    end;

    local v8 = AssetIcons:fromJson(p7) or AssetIcons.fallback;
    p6.bannerSprite = AssetIcons:render(Frame.Banner, v8, {
        fitFor = Vector2.new(1280, 256)
    });

    if p6.bannerSprite then
        p6.bannerSprite.active = false;
        p6.bannerSprite:Update(0);
    end;

    p6:ToggleBannerAnimation(Frame.GuiState == Enum.GuiState.Hover and true or p6.__Internals.__BannerAlwaysAnimated);
end;

function u3.ToggleBannerAnimation(p9, p10) -- Line: 135
    if not p9.bannerSprite then
        return;
    end;

    if p10 then
        if p9.bannerSprite then
            p9.bannerSprite.active = true;
        end;
    elseif p9.bannerSprite then
        p9.bannerSprite.active = false;
        p9.bannerSprite:ResetAnimation();
        p9.bannerSprite:Update(0);
    end;
end;

function u3.Update(u11: table, p12: boolean, p13: boolean, p14: boolean) -- Line: 161
    -- upvalues: Players (copy), AppearanceManager (copy), HttpService (copy)
    local Frame = u11.Frame;

    if Frame then
        local Icons = u11.Icons;
        local v15;

        if u11.Player == Players.LocalPlayer then
            v15 = false;
        else
            v15 = Players.LocalPlayer:IsFriendsWith((math.clamp(u11.Player.UserId, 1, (1 / 0)))) or false;
        end;

        Icons.Friends = v15;
        local Icons2 = u11.Icons;
        local v16;

        if u11.Player:GetAttribute("Staff") then
            v16 = u11.Player:GetAttribute("LB_ShowRank") or false;
        else
            v16 = false;
        end;

        Icons2.Staff = v16;
        local Icons3 = u11.Icons;
        local v17;

        if u11.Player:GetAttribute("Developer") then
            v17 = u11.Player:GetAttribute("LB_ShowRank") or false;
        else
            v17 = false;
        end;

        Icons3.Developer = v17;
        u11.Icons.Premium = u11.Player.MembershipType == Enum.MembershipType.Premium;

        if p13 then
            local Attribute = u11.Player:GetAttribute("LB_DisguiseDisplayName");

            if Attribute then
                if Attribute == "" or not Attribute then
                    Attribute = u11.Player.DisplayName;
                end;
            else
                Attribute = "...";
            end;

            u11.PlayerInfo.DisplayName = Attribute;
            local Attribute2 = u11.Player:GetAttribute("LB_DisguiseUsername");

            if Attribute2 then
                if Attribute2 == "" or not Attribute2 then
                    Attribute2 = u11.Player.Name;
                end;
            else
                Attribute2 = "...";
            end;

            u11.PlayerInfo.Username = Attribute2;
            local v18 = u11.Player:GetAttribute("LB_DisguiseVerified") and not u11.Player.HasVerifiedBadge or u11.Player.HasVerifiedBadge;
            u11.PlayerInfo.ShowVerified = v18;
        end;

        Frame.Contents.Player.PlayerName.Text = u11.PlayerInfo.DisplayName .. (u11.PlayerInfo.ShowVerified and utf8.char(57344) or "");

        if u11.Player == Players.LocalPlayer then
            local FontFace = Frame.Contents.Stats.UFCs.FontFace;
            FontFace.Bold = true;
            FontFace.Weight = Enum.FontWeight.ExtraBold;
            Frame.Contents.Stats.UFCs.FontFace = FontFace;
            local FontFace2 = Frame.Contents.Stats.Wins.FontFace;
            FontFace2.Bold = true;
            FontFace2.Weight = Enum.FontWeight.ExtraBold;
            Frame.Contents.Stats.Wins.FontFace = FontFace2;
            local FontFace3 = Frame.Contents.Player.PlayerName.FontFace;
            FontFace3.Bold = true;
            FontFace3.Weight = Enum.FontWeight.ExtraBold;
            Frame.Contents.Player.PlayerName.FontFace = FontFace3;
        end;

        local Icon, v19 = u11:GetIcon();
        Frame.Contents.Player.SpecialImage.Image = v19;
        Frame.Contents.Player.SpecialImage.Visible = Icon;
    end;

    if p12 then
        u11.__Internals.__Thumbnail = Players:GetUserThumbnailAsync(math.clamp(u11.Player.UserId, 1, (1 / 0)), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size420x420);
        u11.__Internals.__HumanoidDescription = AppearanceManager.getDescription(math.clamp(u11.Player.UserId, 1, (1 / 0)), "User ID", true);
    end;

    if p14 then
        local u20 = {};

        local function __processTagsAttribute(p21) -- Line: 243
            -- upvalues: u11 (copy), HttpService (ref), u20 (copy)
            local Attribute = u11.Player:GetAttribute(p21);

            if not Attribute then
                return;
            end;

            local success, result = pcall(HttpService.JSONDecode, HttpService, Attribute);

            if not success or typeof(result) ~= "table" then
                return;
            end;

            for _, v in ipairs(result) do
                local success2, result2 = pcall(HttpService.JSONDecode, HttpService, v);

                if success2 and result2 then
                    local v22;
                    local v23 = 0;

                    while true do
                        if v23 == 0 then
                            v23 = -1;

                            if not result2[5] then
                                v22 = {
                                    { 0, result2[2] },
                                    { 1, result2[2] }
                                };
                                v23 = 1;
                                continue;
                            end;

                            local v24;
                            v24, v22 = pcall(HttpService.JSONDecode, HttpService, result2[2]);

                            if v24 and v22 then
                                v23 = 1;
                                continue;
                            end;

                            print("X invalid colors", v);
                            v23 = 2;
                            continue;
                        elseif v23 == 1 then
                            v23 = -1;
                            result2[5] = true;
                            result2[2] = v22;
                            table.insert(u20, result2);
                            v23 = 2;
                            continue;
                        elseif v23 == 2 then
                            v23 = -1;
                            break;
                        else
                            break;
                        end;
                    end;
                else
                    print("X invalid tag", v);
                end;
            end;
        end;

        __processTagsAttribute("ImportantTags");
        __processTagsAttribute("Tags");

        local function __generateTagColorSequence(p25) -- Line: 274
            local v26 = {};

            for _, v in p25 do
                v26[#v26 + 1] = ColorSequenceKeypoint.new(v[1], Color3.fromHex(v[2]));
            end;

            return ColorSequence.new(v26);
        end;

        local v27 = {};

        for _, v in u20 do
            local v28 = typeof(v[2]) == "Color3" and ColorSequence.new(v[2]) or (v[5] and __generateTagColorSequence(v[2]) or __generateTagColorSequence({ { 0, "ffffff" }, { 1, "ffffff" } }));
            local v29 = {
                Text = v[1],
                Color = v28,
                Aspect = v[3] == nil and 1 or (v[3] or 1)
            };
            local v30;

            if v[4] == nil then
                v30 = false;
            else
                v30 = v[4] or false;
            end;

            v29.HasName = v30;
            local v31;

            if v[5] == nil then
                v31 = false;
            else
                v31 = v[5] or false;
            end;

            v29.IsColorSequence = v31;
            v29.Idk = v[6] == nil and true or (v[6] or true);
            v29.__RawData = v;
            table.insert(v27, v29);
        end;

        u11.PlayerInfo.Tags = v27;
    end;
end;

local function __deepCopy(p32, p33) -- Line: 336
    -- upvalues: __deepCopy (copy)
    if type(p32) ~= "table" then
        return p32;
    end;

    local v34 = p33 or {};

    if v34[p32] then
        return v34[p32];
    end;

    local v35 = {};
    v34[p32] = v35;

    for i, v in p32 do
        v35[__deepCopy(i, v34)] = __deepCopy(v, v34);
    end;

    return v35;
end;

function v1.new(p36: userdata, p37: boolean, p38: boolean) -- Line: 362
    -- upvalues: PlayerTemplate (copy), __deepCopy (copy), u2 (copy), u3 (copy), Players (copy), AppearanceManager (copy), TweenService (copy), DataManager (copy), Data (copy)
    local u39 = PlayerTemplate:Clone();
    local Contents = u39.Contents;
    u39.UIAspectRatioConstraint.AspectRatio = p37 and 9 or 5;
    local u40 = __deepCopy(u2);
    setmetatable(u40, u3);
    u40.Frame = u39;
    u40.FrameAspectRatio = u39.UIAspectRatioConstraint;
    u40.Player = p36;
    u40.__Internals.__IsCompactMode = p37;
    u40.__Internals.__BannerAlwaysAnimated = p38;
    u40.Frame.Name = u40.Player.Name;
    u40:ToggleBannerAnimation(u39.GuiState == Enum.GuiState.Hover and true or u40.__Internals.__BannerAlwaysAnimated);
    local Icons = u40.Icons;
    local v41;

    if p36 == Players.LocalPlayer then
        v41 = false;
    else
        v41 = Players.LocalPlayer:IsFriendsWith((math.clamp(p36.UserId, 1, (1 / 0)))) or false;
    end;

    Icons.Friends = v41;
    local Icons2 = u40.Icons;
    local v42;

    if u40.Player:GetAttribute("Staff") then
        v42 = u40.Player:GetAttribute("LB_ShowRank") or false;
    else
        v42 = false;
    end;

    Icons2.Staff = v42;
    local Icons3 = u40.Icons;
    local v43;

    if u40.Player:GetAttribute("Developer") then
        v43 = u40.Player:GetAttribute("LB_ShowRank") or false;
    else
        v43 = false;
    end;

    Icons3.Developer = v43;
    u40.Icons.Premium = u40.Player.MembershipType == Enum.MembershipType.Premium;
    u40.HumanoidDescription = AppearanceManager.getDescription(math.clamp(u40.Player.UserId, 1, (1 / 0)), "User ID", true);
    u40.__Internals.__Thumbnail = Players:GetUserThumbnailAsync(math.clamp(p36.UserId, 1, (1 / 0)), Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size420x420);

    local function __ConnectValueUpdate(u44: any, u45: function, p46: function, p47: boolean) -- Line: 422
        -- upvalues: u40 (copy)
        if not (u44 and u45) then
            return;
        end;

        local string_lower_ret = string.lower((typeof(u44)));

        if string_lower_ret ~= "string" then
            if string_lower_ret == "instance" then
                if u44.Value ~= nil then
                    u45(u44.Value, u44);

                    return;
                end;

                if p46 then
                    p46();

                    return;
                end;

                if p47 then
                    u40.__Connections["WaitFor" .. u44.Name] = u44.Changed:Connect(function() -- Line: 460
                        -- upvalues: u45 (copy), u44 (copy), u40 (ref)
                        u45(u44.Value);
                        u40.__Connections["WaitFor" .. u44.Name] = nil;
                    end);

                    return;
                end;

                u40.__Connections["WaitFor" .. u44.Name] = u44.Changed:Once(function() -- Line: 465
                    -- upvalues: u45 (copy), u44 (copy), u40 (ref)
                    u45(u44.Value);
                    u40.__Connections["WaitFor" .. u44.Name] = nil;
                end);
            end;

            return;
        end;

        local Attribute = u40.Player:GetAttribute(u44);

        if Attribute ~= nil then
            u45(Attribute);

            return;
        end;

        if p46 then
            p46();

            return;
        end;

        if p47 then
            u40.__Connections["WaitFor" .. u44] = u40.Player:GetAttributeChangedSignal(u44):Connect(function() -- Line: 440
                -- upvalues: u45 (copy), u40 (ref), u44 (copy)
                u45(u40.Player:GetAttribute(u44));
            end);

            return;
        end;

        u40.__Connections["WaitFor" .. u44] = u40.Player:GetAttributeChangedSignal(u44):Once(function() -- Line: 444
            -- upvalues: u45 (copy), u40 (ref), u44 (copy)
            u45(u40.Player:GetAttribute(u44));
            u40.__Connections["WaitFor" .. u44] = nil;
        end);
    end;

    __ConnectValueUpdate("LB_DisguiseVerified", function(p48) -- Line: 474
        -- upvalues: u40 (copy)
        u40.PlayerInfo.ShowVerified = p48 and not u40.Player.HasVerifiedBadge or u40.Player.HasVerifiedBadge;
        u40:Update(false, true, false);
    end);
    __ConnectValueUpdate("LB_DisguiseDisplayName", function(p49) -- Line: 480
        -- upvalues: u40 (copy)
        if p49 == "" or not p49 then
            p49 = u40.Player.DisplayName;
        end;

        u40.PlayerInfo.DisplayName = p49;
        u40:Update(false, true, false);
    end);
    __ConnectValueUpdate("LB_DisguiseUsername", function(p50) -- Line: 486
        -- upvalues: u40 (copy)
        if p50 == "" or not p50 then
            p50 = u40.Player.Name;
        end;

        u40.PlayerInfo.Username = p50;
        u40:Update(false, true, false);
    end);
    __ConnectValueUpdate("LB_BannerData", function(p51) -- Line: 492
        -- upvalues: u40 (copy)
        u40:RenderBanner(p51);
    end);
    __ConnectValueUpdate("Tags", function(p52) -- Line: 497
        -- upvalues: u40 (copy)
        u40:Update(false, false, true);
    end);
    __ConnectValueUpdate("ImportantTags", function(p53) -- Line: 502
        -- upvalues: u40 (copy)
        u40:Update(false, false, true);
    end);

    local function connectStats(p54) -- Line: 509
        -- upvalues: __ConnectValueUpdate (copy), Contents (copy), u39 (copy)
        __ConnectValueUpdate(p54:WaitForChild("UFCs", 3), function(p55) -- Line: 513
            -- upvalues: Contents (ref)
            Contents.Stats.UFCs.Text = p55;
        end, function() -- Line: 516
            -- upvalues: Contents (ref)
            Contents.Stats.UFCs.Text = "0";
        end, true);
        __ConnectValueUpdate(p54:WaitForChild("Wins", 3), function(p56, p57) -- Line: 525
            -- upvalues: Contents (ref), u39 (ref)
            Contents.Stats.Wins.Text = p56;
            local Attribute = p57:GetAttribute("RealValue");
            u39.LayoutOrder = Attribute and (tonumber(Attribute) and -tonumber(Attribute)) or 0;
        end, function() -- Line: 531
            -- upvalues: Contents (ref), u39 (ref)
            Contents.Stats.Wins.Text = "0";
            u39.LayoutOrder = 0;
        end, true);
    end;

    local Leaderstats = p36:WaitForChild("Leaderstats", 3);

    if Leaderstats then
        connectStats(Leaderstats);
    else
        u40.__Connections.WaitForLeaderstats = p36.ChildAdded:Connect(function(p58) -- Line: 543
            -- upvalues: u40 (copy), connectStats (copy)
            if p58.Name == "Leaderstats" then
                u40.__Connections.WaitForLeaderstats:Disconnect();
                connectStats(p58);
            end;
        end);
    end;

    local TweenInfo_new_ret = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);

    if not u40.__Tweens.PlayerHover then
        u40.__Tweens.PlayerHover = {
            Hover = nil,
            Idle = nil
        };
    end;

    u40.__Connections.OnHover = u39:GetPropertyChangedSignal("GuiState"):Connect(function() -- Line: 580
        -- upvalues: u39 (copy), u40 (copy), TweenService (ref), TweenInfo_new_ret (copy)
        if u39.GuiState == Enum.GuiState.Hover then
            u40:ToggleBannerAnimation(true);

            if u40.FrameAspectRatio and u40.__Internals.__IsCompactMode then
                local v59 = TweenService:Create(u40.FrameAspectRatio, TweenInfo_new_ret, {
                    AspectRatio = 5
                });

                if u40.__Tweens.PlayerHover.Hover then
                    u40.__Tweens.PlayerHover.Hover:Cancel();
                    u40.__Tweens.PlayerHover.Hover:Destroy();
                end;

                u40.__Tweens.PlayerHover.Hover = v59;
                v59:Play();
            end;
        elseif u39.GuiState == Enum.GuiState.Idle then
            u40:ToggleBannerAnimation(u40.__Internals.__BannerAlwaysAnimated);

            if u40.FrameAspectRatio and u40.__Internals.__IsCompactMode then
                local v60 = TweenService:Create(u40.FrameAspectRatio, TweenInfo_new_ret, {
                    AspectRatio = 9
                });

                if u40.__Tweens.PlayerHover.Idle then
                    u40.__Tweens.PlayerHover.Idle:Cancel();
                    u40.__Tweens.PlayerHover.Idle:Destroy();
                end;

                u40.__Tweens.PlayerHover.Idle = v60;
                v60:Play();
            end;
        end;
    end);
    u40.__Connections.AlwaysAnimatedChanged = DataManager.DataChanged:Connect(function(p61) -- Line: 621
        -- upvalues: u40 (copy), Data (ref), u39 (copy)
        if p61 ~= "AlwaysAnimateLeaderboardBanners" then
            return;
        end;

        u40.__Internals.__BannerAlwaysAnimated = Data.AlwaysAnimateLeaderboardBanners;
        print(p61, Data.AlwaysAnimateLeaderboardBanners);
        u40:ToggleBannerAnimation(u39.GuiState == Enum.GuiState.Hover and true or u40.__Internals.__BannerAlwaysAnimated);
    end);

    return u40;
end;

return v1;