-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local OwOify = require(Modules.Other.OwOify);
local PirateSpeech = require(Modules.Other.PirateSpeech);
local IconV2 = require(Modules.Main.IconV2);
local ColorConverter = require(Modules.UI.ColorConverter);
local AssetIcons = require(Modules.UI.AssetIcons);
local u2 = { "%[name%]", "%[uppername%]", "%[lowername%]", "%[nameuwu%]", "%[nameahoy%]" };

function isTableContentDifferent(p3, p4)
    return true;
end;

function u1.new(p5: table) -- Line: 20
    -- upvalues: u1 (copy)
    local v6 = {
        alive = true,
        data = nil,
        obj = script.Overhead:Clone()
    };
    local v7 = setmetatable(v6, u1);
    v7.obj.Enabled = true;
    local Labels = v7.obj.Base.Labels;
    local v8 = Labels.Custom:Clone();
    v8.Name = "PlatformLabel";
    v8.Parent = Labels;
    v8.LayoutOrder = 1;
    v7.platformLabel = v8;
    v7:setData(p5);

    return v7;
end;

function u1.Destroy(p9) -- Line: 42
    if p9.bannerSprite then
        p9.bannerSprite:Destroy();
        p9.bannerSprite = nil;
    end;

    if p9.icon then
        p9.icon:Destroy();
        p9.icon = nil;
    end;

    pcall(game.Destroy, p9.obj);
    table.clear(p9);
    p9.alive = false;
end;

local function convertColorToJson(p10) -- Line: 59
    -- upvalues: HttpService (copy)
    if typeof(p10) == "Color3" then
        return "#" .. p10:ToHex();
    end;

    if typeof(p10) ~= "ColorSequence" then
        return nil;
    end;

    local v11 = {};

    for _, v in p10.Keypoints do
        local v12 = { v.Time, v.Value:ToHex() };
        table.insert(v11, v12);
    end;

    return HttpService:JSONEncode(v11);
end;

function u1.setData(p13: table, p14: table) -- Line: 73
    -- upvalues: u1 (copy), ColorConverter (copy), convertColorToJson (copy), AssetIcons (copy), IconV2 (copy)
    local v15 = p14 or {};
    p13.data = v15;
    local Base = p13.obj.Base;
    v15.Labels = v15.Labels or {};
    v15.Tags = v15.Tags or {};
    v15.Name = v15.Name or "OnlyTwentyCharacters";
    v15.DisplayName = v15.DisplayName or "OnlyTwentyCharacters";
    v15.Username = v15.Username or "OnlyTwentyCharacters";

    if p13.curData and isTableContentDifferent(p13.curData.Labels, v15.Labels) then
        for _, child in Base.Labels:GetChildren() do
            if child:HasTag("OverheadData") then
                child:Destroy();
            end;
        end;
    end;

    for i, v in ipairs(v15.Labels) do
        if #v:gsub("[ \t]", "") ~= 0 then
            local v16;

            if v:find("^rbx") then
                v16 = Base.Labels.Custom:Clone();
                v16.ImageContent = Content.fromUri(v);
            else
                v16 = Base.Labels.CustomText:Clone();
                v16.Text = v;
            end;

            v16.Visible = true;
            v16.Name = v;
            v16:AddTag("OverheadData");
            v16.LayoutOrder = i + 1;
            v16.Parent = Base.Labels;
        end;
    end;

    local ColorSequence_new_ret = ColorSequence.new(Color3.new(0, 0, 0));
    local v17 = v15.ImportantTags or {};
    local v18 = v15.Tags or {};
    local table_clone_ret = table.clone(v17);
    local v19 = "";
    local v20 = "";

    for _, v in v18 do
        table.insert(table_clone_ret, v);
    end;

    for _, v in table_clone_ret do
        local v21 = typeof(v.Color) ~= "Color3";
        local v22, _ = u1:formatTag(v.RawTag or v.Tag, v15.DisplayName);
        local v23 = u1:tagHasNameField(v.RawTag or v.Tag);
        local v24 = ColorConverter.convertColor(convertColorToJson(v.Color), v23, `[{v22}] `, v21, v.Bold, false);

        if v23 == true then
            if v20 == "" then
                ColorSequence_new_ret = ColorConverter.grayscaleColor(ColorConverter.invertColor(v.Color));

                if v24.isGradient then
                    v20 = v24.color;
                else
                    v20 = `<font color='{v24.color}'>{v22 or "ERROR"}</font>`;
                end;
            end;
        elseif v24.isGradient then
            v19 = v19 .. v24.color;
        else
            v19 = v19 .. `<font color='{v24.color}'>[{v22 or "ERROR"}]</font> `;
        end;
    end;

    if string.len(v20) <= 0 then
        v20 = v15.DisplayName;
    end;

    if typeof(ColorSequence_new_ret) == "string" then
        ColorSequence_new_ret = ColorSequence.new(Color3.fromHex(ColorSequence_new_ret));
    end;

    Base.Banner.BannerHolder.Contents.DisplayName.UIStroke.UIGradient.Color = ColorSequence_new_ret;
    Base.Banner.BannerHolder.Contents.DisplayName.Text = `{v20}`;
    Base.Banner.BannerHolder.Contents.Username.Text = `@{v15.Username}` .. (v15.ShowVerifiedTick and "" or "");
    Base.Banner.BannerHolder.Contents.Tags.Text = v19;
    Base.Banner.BannerHolder.Contents.Tags.Visible = string.len(v19) >= 1;

    if p13.bannerSprite then
        p13.bannerSprite:Destroy();
        p13.bannerSprite = nil;
    end;

    if v15.BannerData then
        p13.bannerSprite = AssetIcons:render(Base.Banner.BannerHolder.Banner, v15.BannerData, {
            fitFor = Vector2.new(1280, 256)
        });
    else
        Base.Banner.BannerHolder.Banner.ImageContent = Content.none;
    end;

    if v15.HealthIcon then
        if p13.icon then
            p13.icon:Destroy();
            p13.icon = nil;
        end;

        local v25 = IconV2.new(Base.Banner.IconHolder.Icon, "L", v15.HealthIcon, v15.HealthIconPack);
        p13.icon = v25;
        v25.sFactors = Vector2.new(150, 375);
        v25.Position = UDim2.fromScale(0.5, 0.5);
        v25.anchor = Vector2.new(0.5, 0.5);
        v25.Scale = Vector2.new(1, 1);
        v25:ForceUpdate();
        p13:changePlatform(v15.PlatformIcon);
        p13.curData = v15;
    end;
end;

function stripFontTags(p26)
    return p26:gsub("<%s*[Ff][Oo][Nn][Tt][^>]*>", ""):gsub("</%s*[Ff][Oo][Nn][Tt]%s*>", "");
end;

function trim(p27)
    return p27:gsub("^[%s\n]+", ""):gsub("[%s\n]+$", "");
end;

function u1.changePlatform(p28: table, p29: string?) -- Line: 231
    if p28.curData then
        p28.curData.PlatformIcon = p29;
    end;

    local platformLabel = p28.platformLabel;

    if not platformLabel then
        return;
    end;

    if not p29 then
        platformLabel.Visible = false;

        return;
    end;

    platformLabel.ImageContent = Content.fromUri(p29);
    platformLabel.Visible = true;
end;

function u1.attachTo(p30: table, p31: userdata, p32: userdata?) -- Line: 247
    p30.obj.Adornee = p31;
    p30.obj.Parent = p32 or p31;
end;

function u1.Update(p33, p34) -- Line: 252
    if p33.icon then
        p33.icon:Update(p34);
    end;

    if p33.bannerSprite then
        p33.bannerSprite:Update(p34);
    end;
end;

function u1.tagHasNameField(p35: table, p36: string) -- Line: 261
    -- upvalues: u2 (copy)
    for _, v in u2 do
        if string.find(p36, v) then
            return true;
        end;
    end;

    return false;
end;

function u1.formatTag(p37: table, p38: string, p39: string) -- Line: 270
    -- upvalues: OwOify (copy), PirateSpeech (copy)
    return p38:gsub("%[name%]", p39):gsub("%[uppername%]", p39:upper()):gsub("%[lowername%]", p39:lower()):gsub("%[nameuwu%]", OwOify(p39)):gsub("%[nameahoy%]", PirateSpeech(p39));
end;

return u1;