-- Decompiled with Potassium's decompiler.

local v1 = {};
local HttpService = game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
local Assets = ReplicatedStorage:WaitForChild("Assets");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local AssetReplicator = require(Modules.Main:WaitForChild("AssetReplicator"));
local Sprite = require(Modules.Main.Sprite);
local IconV2 = require(Modules.Main.IconV2);
local Vector2_new_ret = Vector2.new(1280, 720);
local u2 = {
    Noteskins = "note0",
    Notesplashes = "splash0",
    Holdsplashes = "Idle0",
    Banners = "banner0"
};
v1.fallback = {
    antialiasing = true,
    imgContent = Content.none
};
v1.none = v1.fallback;

local function isURI(p3) -- Line: 79
    return string.find(p3, "^rbx") and true or false;
end;

function formatIconData(...)
    return ...;
end;

local function formatSkin(p4: userdata, p5: string) -- Line: 83
    -- upvalues: Sprite (copy), u2 (copy)
    local v6 = p4:FindFirstChild("Up") or p4:FindFirstChild("XML");

    if not v6 then
        return Content.none, true;
    end;

    local success, result = pcall(require, v6);

    if not success then
        warn("[AssetIcons] Noteskin data is wrong!", v6);

        return nil;
    end;

    local v7 = tonumber(v6:GetAttribute("SizeMult")) or 1;
    local v8 = tonumber(v6:GetAttribute("Factor")) or 1;
    local Attribute = v6:GetAttribute("Image");
    local Attribute2 = v6:GetAttribute("Resolution");
    local AnimFramesXml = Sprite:GetAnimFramesXml(result, u2[p5] or "note0", v8, v7);

    if not AnimFramesXml or #AnimFramesXml == 0 then
        warn("[AssetIcons] Noteskin data is wrong!", v6);

        return nil;
    end;

    local Attribute3 = v6:GetAttribute("Antialiasing");

    return {
        isXML = true,
        frames = AnimFramesXml,
        resolution = Attribute2,
        imgContent = tonumber(Attribute) and Content.fromAssetId((tonumber(Attribute))) or ((string.find(Attribute, "^rbx") and true or false) and Content.fromUri(Attribute) or Content.none),
        antialiasing = Attribute3 == nil and true or Attribute3
    };
end;

local u9 = {};

local function merge(p10, p11) -- Line: 42
    if p10 then
        local table_clone_ret = table.clone(p10);

        for i, v in p11 do
            table_clone_ret[i] = v;
        end;

        return table_clone_ret;
    end;
end;

local function getItem(p12: string, p13: string?, p14: string?) -- Line: 53
    -- upvalues: Assets (copy), RunService (copy), ServerStorage (copy), AssetReplicator (copy)
    if p13 == "" then
        p13 = nil;
    end;

    if p14 == "" then
        p14 = nil;
    end;

    local v15 = Assets:FindFirstChild(p12) or RunService:IsServer() and ServerStorage:WaitForChild("ReplicableAssets"):FindFirstChild(p12);
    local v16;

    if v15 then
        v16 = v15:FindFirstChild(p14 or (p13 or ""));
    else
        v16 = v15;
    end;

    if not (v15 and (v16 or not AssetReplicator)) then
        v16 = AssetReplicator.getAsset(p12, p14 or p13);
    end;

    if v16 then
        if not ((not p14 or v16:GetAttribute("Pack")) and (p14 or not v16:GetAttribute("Pack"))) then
            return nil;
        end;

        if p14 and p13 then
            return v16:FindFirstChild(p13);
        end;

        return v16;
    end;

    warn("[AssetIcons] Couldn\'t find", p12, p13, p14);
end;

for _, v in { "Noteskins", "Holdsplashes", "Notesplashes" } do
    u9[v] = function(p17: any, p18: userdata) -- Line: 127
        -- upvalues: formatSkin (copy), v (copy)
        if not p18:GetAttribute("Pack") then
            return formatSkin(p18, v);
        end;

        if not p17.Default then
            return;
        end;

        local v19 = p18:FindFirstChild(p17.Default);

        if v19 then
            return formatSkin(v19, v);
        end;
    end;
end;

function u9.Icons(p20, p21) -- Line: 141
    -- upvalues: Assets (copy)
    local v22 = p20.Antialiasing or p20.Antialiasing == nil;

    if not p21:GetAttribute("Pack") then
        local v23 = {
            name = p21.Name
        };
        local v24;

        if p21.Parent == Assets.Icons then
            v24 = nil;
        else
            v24 = p21.Parent or nil;
        end;

        v23.pack = v24;
        v23.antialiasing = v22;

        return formatIconData(v23);
    end;

    if p20.Icon then
        return formatIcon(p20, p21.Name);
    end;
end;

function u9.Banners(p25, p26) -- Line: 160
    -- upvalues: merge (copy), formatSkin (copy)
    if not p26:GetAttribute("Pack") then
        if p25.Animated then
            return merge(formatSkin(p26, "Banners"), {
                isBanner = true
            });
        end;

        return merge(formatIcon(p25), {
            isBanner = true
        });
    end;

    if p25.Default then
        local v27 = p26:FindFirstChild(p25.Default);

        if not v27 then
            return;
        end;

        local Metadata = v27:FindFirstChild("Metadata");
        local success, result = pcall(require, Metadata);

        if success then
            if result.Animated then
                return merge(formatSkin(v27, "Banners"), {
                    isBanner = true
                });
            end;

            return merge(formatIcon(result), {
                isBanner = true
            });
        end;
    end;
end;

function formatIcon(p28, p29)
    local Icon = p28.Icon;

    if not (p29 and (p29 ~= "" and p29)) then
        if p28.IconPack and p28.IconPack ~= "" then
            p29 = p28.IconPack or nil;
        else
            p29 = nil;
        end;
    end;

    if p28.Asset and not Icon then
        Icon = p28.Asset;
        p29 = nil;
    end;

    if not Icon or Icon == "" then
        return nil;
    end;

    local v30 = p28.Antialiasing or p28.Antialiasing == nil;

    return type(Icon) == "number" and {
        imgContent = Content.fromAssetId(Icon),
        antialiasing = v30
    } or ((string.find(Icon, "^rbx") and true or false) and {
        imgContent = Content.fromUri(Icon),
        antialiasing = v30
    } or formatIconData({
        name = Icon,
        pack = p29,
        antialiasing = v30
    }));
end;

function v1.toJson(p31, p32) -- Line: 224
    -- upvalues: HttpService (copy)
    if not p32 then
        return "{}";
    end;

    local table_clone_ret = table.clone(p32);

    if table_clone_ret.frames then
        table_clone_ret.frames = table.clone(table_clone_ret.frames);

        for i, v in table_clone_ret.frames do
            local table_clone_ret2 = table.clone(v);
            table_clone_ret.frames[i] = table_clone_ret2;

            for i2, v2 in table_clone_ret2 do
                if typeof(v2) == "Vector2" then
                    table_clone_ret2[i2] = { v2.X, v2.Y };
                end;
            end;
        end;
    end;

    if table_clone_ret.imgContent then
        table_clone_ret.imgContent = table_clone_ret.imgContent.Uri;
    end;

    if table_clone_ret.resolution then
        table_clone_ret.resolution = { table_clone_ret.resolution.X, table_clone_ret.resolution.Y };
    end;

    return HttpService:JSONEncode(table_clone_ret);
end;

function v1.fromJson(p33: table, u34: string) -- Line: 253
    -- upvalues: HttpService (copy)
    local success, result = pcall(function() -- Line: 254
        -- upvalues: HttpService (ref), u34 (copy)
        return HttpService:JSONDecode(u34);
    end);

    if success and next(result) then
        if result.resolution then
            result.resolution = Vector2.new(result.resolution[1], result.resolution[2]);
        end;

        if result.imgContent then
            result.imgContent = Content.fromUri(result.imgContent);
        end;

        if result.frames then
            for _, v in result.frames do
                local v35 = v;

                for i, v2 in v do
                    if type(v2) == "table" and #v2 == 2 then
                        v35[i] = Vector2.new(v2[1], v2[2]);
                    end;
                end;
            end;
        end;

        return result;
    end;
end;

function v1.format(p36: table, p37: string, p38: any, p39: table?) -- Line: 281
    -- upvalues: getItem (copy), u9 (copy)
    if type(p38) == "table" then
        p38 = getItem(p37, p38.name, p38.pack);
    end;

    if not (p38 or p39) then
        return nil;
    end;

    local v40;

    if p39 then
        v40 = p39;
    else
        local Metadata = p38:FindFirstChild("Metadata");
        local v41;
        v41, v40 = pcall(require, Metadata);

        if not v41 then
            v40 = p39;
        end;
    end;

    if not v40 then
        return nil;
    end;

    local v42;

    if u9[p37] then
        v42 = u9[p37](v40, p38);
    else
        v42 = formatIcon(v40);
    end;

    return v42 or nil;
end;

function v1.render(p43: table, p44: userdata, p45: any, p46: table?) -- Line: 313
    -- upvalues: Vector2_new_ret (copy), Sprite (copy), IconV2 (copy)
    local v47 = p46 or {};
    local v48 = 1 * (v47.scale or 1);

    if typeof(p45) == "Content" then
        p44.ImageContent = p45;
        p44.ResampleMode = Enum.ResamplerMode.Default;
        p44.ImageRectSize = Vector2.zero;
        p44.ImageRectOffset = Vector2.zero;
        p44.Rotation = 0;
        p44.Size = UDim2.fromScale(v48, v48);
    end;

    if type(p45) ~= "table" then
        return;
    end;

    if p45.isXML then
        local frames = p45.frames;

        if #frames ~= 1 then
            local v49 = Sprite.new(p44, p45.resolution or (v47.fitFor or nil), false, false, false);
            v49.antialiasing = p45.antialiasing;
            v49.Position = UDim2.fromScale(0.5, 0.5);
            local v50 = Vector2.one * v48;

            if v47.fitFor and p45.resolution then
                v50 = v50 * (v47.fitFor / p45.resolution);
            end;

            v49.Scale = v50;
            v49:AddAnimation("idle", frames, 24, true, p45.imgContent);
            v49:PlayAnimation("idle", true);

            return v49;
        end;

        local v51 = frames[1];
        local v52 = v51.FrameSize / (p45.resolution or (v47.fitFor or Vector2_new_ret));

        if v47.fitFor and p45.resolution then
            v52 = v52 * (v47.fitFor / p45.resolution);
        end;

        local v53 = v52 * v48;
        p44.ImageRectSize = v51.Size;
        p44.ImageRectOffset = v51.Offset;
        p44.ResampleMode = p45.antialiasing and Enum.ResamplerMode.Default or Enum.ResamplerMode.Pixelated;
        p44.ImageContent = p45.imgContent;
        p44.Size = UDim2.fromScale(v53.X, v53.Y);

        return {
            active = true,

            Update = function() -- Line: 351, Name: Update
            end,

            Destroy = function() -- Line: 352, Name: Destroy
            end
        };
    end;

    if not p45.imgContent then
        if p45.name then
            local v54 = IconV2.new(p44, "L", nil);
            v54:LoadIcon(p45.name, p45.pack);
            v54.Position = UDim2.fromScale(0.5, 0.5);
            v54.Scale = Vector2.one * v48 * (v47.fitFor and v47.fitFor / Vector2.new(150, 150) or 1);

            return v54;
        end;

        return;
    end;

    p44.ImageContent = p45.imgContent;
    p44.ScaleType = p45.style and Enum.ScaleType[p45.style] or Enum.ScaleType.Crop;
    p44.ResampleMode = p45.antialiasing and Enum.ResamplerMode.Default or Enum.ResamplerMode.Pixelated;
    p44.ImageRectSize = Vector2.zero;
    p44.ImageRectOffset = Vector2.zero;
    p44.Size = UDim2.fromScale(v48, v48);
    p44.Rotation = 0;
end;

return v1;