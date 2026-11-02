-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Events = ReplicatedStorage.Events;
local IconV2 = require(ReplicatedStorage.Modules.Main.IconV2);
local Adapters = require(ReplicatedStorage.Modules.Other.Adapters);
local Overheads = require(ReplicatedStorage.Modules.UI.Overheads);
local AssetIcons = require(ReplicatedStorage.Modules.UI.AssetIcons);
local _Gameplay = require(ReplicatedStorage.Modules.Main.Translator).new("_Gameplay", { "Gameplay" });
local u1 = {
    TargetLocation = nil,
    UI = script.Loading:Clone(),
    BannerObjects = {},
    BannerSides = {
        L = {},
        R = {}
    },
    Icons = {},
    Tweens = {}
};
u1.UI.RootLocalizationTable = _Gameplay.localizationTable;

local function isURI(p2) -- Line: 55
    return string.find(p2, "^rbx") and true or false;
end;

function u1.reset() -- Line: 59
    -- upvalues: u1 (copy)
    stopTweens();

    for _, v in u1.BannerObjects do
        if v ~= nil then
            v:Destroy();
        end;
    end;

    for _, v in u1.Icons do
        if v ~= nil then
            v:Destroy();
        end;
    end;

    table.clear(u1.Icons);
    table.clear(u1.BannerObjects);
    table.clear(u1.BannerSides.L);
    table.clear(u1.BannerSides.R);
    u1.UI.LoadingLabel.CancelLoading.Visible = false;
    u1.UI.MatchType.Position = UDim2.fromScale(0.5, -0.1);
    u1.UI.LoadingLabel.Position = UDim2.fromScale(0.5, 1.1);
    u1.UI.Transition.Size = UDim2.fromScale(0, 0);
end;

local function getTimeColor(p3: userdata, p4: number) -- Line: 79
    if p4 == 0 then
        return p3.Keypoints[1].Value;
    end;

    if p4 == 1 then
        return p3.Keypoints[#p3.Keypoints].Value;
    end;

    for i = 1, #p3.Keypoints - 1 do
        local v5 = p3.Keypoints[i];
        local v6 = p3.Keypoints[i + 1];

        if v5.Time <= p4 and p4 < v6.Time then
            local v7 = (p4 - v5.Time) / (v6.Time - v5.Time);

            return Color3.new((v6.Value.R - v5.Value.R) * v7 + v5.Value.R, (v6.Value.G - v5.Value.G) * v7 + v5.Value.G, (v6.Value.B - v5.Value.B) * v7 + v5.Value.B);
        end;

        local _ = i;
    end;
end;

local function getRichText(p8, p9) -- Line: 100
    -- upvalues: getTimeColor (copy)
    local v10 = 0;
    local v11 = "";

    for i, v in utf8.graphemes(p8) do
        local v12 = p8:sub(i, v);
        local v13;

        if p9 then
            if typeof(p9) == "Color3" and p9 then
                v13 = p9;
            else
                v13 = getTimeColor(p9, v10 / #p8) or Color3.new(1, 1, 1);
            end;
        else
            v13 = Color3.new(1, 1, 1);
        end;

        v11 = v11 .. `<font color='#{v13:ToHex()}'>{v12}</font>`;
        v10 = v10 + 1;
    end;

    return v11;
end;

function stopTweens()
    -- upvalues: u1 (copy)
    for _, v in u1.Tweens do
        if v ~= nil and v.PlaybackState == Enum.PlaybackState.Playing then
            v:Cancel();
        end;
    end;
end;

function u1.setLoadingText(p14: string) -- Line: 121
    -- upvalues: u1 (copy)
    u1.UI.LoadingLabel.Text = p14;
end;

function u1.start(p15: table) -- Line: 125
    -- upvalues: u1 (copy), Events (copy), IconV2 (copy), AssetIcons (copy), getRichText (copy), Overheads (copy), _Gameplay (copy), Adapters (copy)
    u1.UI.Parent = u1.TargetLocation;
    u1.UI.Visible = true;
    u1.reset();
    u1.createTwn(u1.UI.Transition, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(5, 5)
    }):Play();
    u1.createTwn(u1.UI.VS, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0.2, 0.2)
    }):Play();
    task.delay(0.5, function() -- Line: 134
        -- upvalues: u1 (ref)
        local TweenInfo_new_ret = TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        u1.createTwn(u1.UI.MatchType, TweenInfo_new_ret, {
            Position = UDim2.fromScale(0.5, 0.02)
        }):Play();
        u1.createTwn(u1.UI.LoadingLabel, TweenInfo_new_ret, {
            Position = UDim2.fromScale(0.5, 0.98)
        }):Play();
    end);

    for i, v in p15.Sides do
        local v16 = i;

        for i2, v2 in v do
            local v17 = v2.IsBot and v2 and v2 or Events.Overheads.GetPreviewOverheadData:InvokeServer(v2.Player);
            local v18 = u1.UI:FindFirstChild((`{v16 == "L" and "Left" or "Right"}Side`));
            local v19 = v18.Template:Clone();
            v19.Name = `Player{i2}`;
            v19.Visible = true;
            v19.Parent = v18;
            local v20 = IconV2.new(v19.Banner.IconHolder.Icon, v16, v17.HealthIcon, v17.HealthIconPack);
            table.insert(u1.Icons, v20);
            v20.sFactors = Vector2.new(150, 375);
            v20.Position = UDim2.fromScale(0.5, 0.5);
            v20.anchor = Vector2.new(0.5, 0.5);
            v20.Scale = Vector2.new(1, 1);
            v20:ForceUpdate();

            if v17.IsBot and (v17.Banner == "None" and v17.BannerPack == nil) then
                v19.Banner.BannerHolder.Banner.Image = "rbxassetid://71711014610737";
            else
                local v21 = v17.BannerData or AssetIcons:format("Banners", {
                    name = v17.Banner,
                    pack = v17.BannerPack
                });
                local v22;

                if v17.ReplaceBannerByCustom and v17.CustomBannerImage then
                    local CustomBannerImage = v17.CustomBannerImage;
                    local CustomBannerStyle = v17.CustomBannerStyle;
                    local v23 = tonumber(CustomBannerImage) and Content.fromAssetId((tonumber(CustomBannerImage))) or ((string.find(CustomBannerImage, "^rbx") and true or false) and Content.fromUri(CustomBannerImage) or Content.none);
                    v22 = {
                        antialiasing = true,
                        isBanner = true,
                        imgContent = v23,
                        style = CustomBannerStyle or "Crop"
                    };
                else
                    v22 = nil;
                end;

                local v24 = AssetIcons:render(v19.Banner.BannerHolder.Banner, v22 or v21, {
                    fitFor = Vector2.new(1280, 256)
                });
                table.insert(u1.Icons, v24);
            end;

            if v17.IsBot then
                v19.Banner.BannerHolder.Username.Text = "BOT";
            else
                local v25 = "";

                for _, v3 in v17.ImportantTags do
                    v25 = v25 .. `<b>{getRichText(`[{Overheads:formatTag(v3.RawTag or v3.Tag, v17.DisplayName)}]`, v3.Color)}</b> `;
                end;

                for _, v3 in v17.Tags do
                    v25 = v25 .. getRichText(`[{Overheads:formatTag(v3.RawTag or v3.Tag, v17.DisplayName)}]`, v3.Color) .. " ";
                end;

                v19.Banner.BannerHolder.Username.Text = `{v25 == "" and "" or `{v25}\n`}{v17.DisplayName}\n@{v17.Username}`;
            end;

            table.insert(u1.BannerObjects, v19);
            table.insert(u1.BannerSides[v16], v19);
        end;
    end;

    for _, v in u1.BannerSides do
        task.spawn(function() -- Line: 193
            -- upvalues: v (copy), u1 (ref)
            for _, v2 in v do
                u1.createTwn(v2.Banner, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(0, 0)
                }):Play();
                wait(0.3);
            end;
        end);
    end;

    u1.UI.MatchType.Text = p15.IsSolo and _Gameplay.Get("Gameplay.Loading.SoloMatch") or _Gameplay.Format("Gameplay.Loading.MultiplayerMatch", {
        LCount = p15.PlayerAmmo.L,
        RCount = p15.PlayerAmmo.R
    });
    u1.UI.MatchType.SongInfo.Text = `{p15.Mod} - {p15.Song} ({p15.Difficulty}){p15.Rate == 1 and "" or (` [{Adapters.floatToString(p15.Rate)}x]` or "")}`;
end;

function u1.createTwn(p26: userdata, p27: userdata, p28: table) -- Line: 205
    -- upvalues: TweenService (copy), u1 (copy)
    local v29 = TweenService:Create(p26, p27, p28);
    table.insert(u1.Tweens, v29);

    return v29;
end;

function u1.finished() -- Line: 211
    -- upvalues: u1 (copy)
    stopTweens();
    u1.createTwn(u1.UI.VS, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.fromScale(0)
    }):Play();

    for i, v in u1.BannerSides do
        task.spawn(function() -- Line: 216
            -- upvalues: v (copy), i (copy), u1 (ref)
            for _, v2 in v do
                task.spawn(function() -- Line: 218
                    -- upvalues: i (ref), u1 (ref), v2 (copy)
                    local UDim2_fromScale_ret = UDim2.fromScale(i == "L" and -2 or 2, 0);
                    u1.createTwn(v2.Banner, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                        Position = UDim2_fromScale_ret
                    }):Play();
                    task.wait(1);
                    v2:Destroy();
                end);
                wait(0.1);
            end;
        end);
    end;

    task.delay(0.3, function() -- Line: 229
        -- upvalues: u1 (ref)
        local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
        u1.createTwn(u1.UI.MatchType, TweenInfo_new_ret, {
            Position = UDim2.fromScale(0.5, -0.1)
        }):Play();
        u1.createTwn(u1.UI.LoadingLabel, TweenInfo_new_ret, {
            Position = UDim2.fromScale(0.5, 1.1)
        }):Play();
    end);
    u1.createTwn(u1.UI.Transition, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0, 0)
    }):Play();
end;

function u1.showFailedLoad() -- Line: 238
    -- upvalues: u1 (copy)
    u1.UI.LoadingLabel.CancelLoading.Visible = true;
end;

return u1;