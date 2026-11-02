-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AssetService = game:GetService("AssetService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Sprite = require(Modules.Main.Sprite);
local Vector2_zero = Vector2.zero;
local Vector3_new = Vector3.new;
local Color3_new = Color3.new;
local Color3_fromHSV = Color3.fromHSV;
local table_clone = table.clone;
local u1 = {};
local u2 = {};

function lerp(p3, p4, p5)
    return p3 + (p4 - p3) * p5;
end;

function mix(p6, p7, p8)
    return p6 * (1 - p8) + p7 * p8;
end;

local u9, u10, _ = Sprite:Extend();

function u9.new(...) -- Line: 27
    -- upvalues: u10 (copy)
    local v11 = u10(...);
    v11.rgbAnims = {};
    v11.linkedRGB = {};

    return v11;
end;

function cacheImage(u12)
    -- upvalues: u2 (copy), u1 (copy), AssetService (copy), Vector2_zero (copy)
    if u2[u12] then
        repeat
            task.wait();
        until not u2[u12];

        return u1[u12];
    end;

    if not u1[u12] then
        local success, result = pcall(function() -- Line: 42
            -- upvalues: u2 (ref), u12 (copy), AssetService (ref), Vector2_zero (ref), u1 (ref)
            u2[u12] = true;
            local v13 = AssetService:CreateEditableImageAsync(u12);
            local v14 = {
                Image = v13,
                Size = v13.Size
            };
            v14.DPixels = v13:ReadPixels(Vector2_zero, v14.Size);
            u1[u12] = v14;
            u2[u12] = false;

            return v14;
        end);

        if success then
            return result;
        end;

        warn(result);
    end;

    return u1[u12];
end;

function getNewImage(p15)
    -- upvalues: Vector2_zero (copy)
    local v16 = cacheImage(p15);

    return {
        Image = v16.Image:Copy(Vector2_zero, v16.Size),
        Size = v16.Size,
        DPixels = v16.DPixels,
        Id = p15
    };
end;

function u9.cacheId(p17, p18) -- Line: 74
    return cacheImage(p18);
end;

function u9.getId(p19, p20) -- Line: 78
    if not p19.prevImage or p19.prevImage.Id ~= p20 then
        return getNewImage(p20);
    end;

    local prevImage = p19.prevImage;
    p19.prevImage = nil;

    return prevImage;
end;

function u9.setRGBId(p21, p22) -- Line: 89
    for _, v in p21.linkedRGB or {} do
        v:setRGBId(p22);
    end;

    if p22 == p21.curRgbId then
        return;
    end;

    p21.curRgbId = p22;

    if p21.curRGBImage then
        p21:DisableRGB();
        p21.prevImage = p21.curRGBImage;
        p21.curRGBImage = nil;
    end;

    if not p22 then
        return;
    end;

    p21.curRGBImage = p21:getId(p22);

    if p21.prevImage then
        p21.prevImage.Image:Destroy();
        p21.prevImage = nil;
    end;

    p21.curRGBImage.Image.Parent = p21.Obj;

    if p21.rgbColors then
        p21:updateColor();
    end;
end;

function u9.setColor(p23: table, p24, p25: any) -- Line: 120
    -- upvalues: Vector3_new (copy)
    for _, v in p23.linkedRGB or {} do
        v:setColor(p24, p25);
    end;

    if not p24 then
        p23:DisableRGB();

        return;
    end;

    if typeof(p24) == "table" then
        p23.rgbColors = p24;
    else
        local v26 = Vector3_new(p24.R, p24.G, p24.B);
        p23.rgbColors = { v26, v26, v26 };
    end;

    p23.rgbType = p25 or "Hue";
    p23:updateColor();
end;

function u9.updateColor(p27) -- Line: 144
    -- upvalues: table_clone (copy), Color3_new (copy), Color3_fromHSV (copy), Vector3_new (copy)
    local curRGBImage = p27.curRGBImage;
    local rgbColors = p27.rgbColors;

    if not (curRGBImage and rgbColors) then
        return;
    end;

    print(curRGBImage.DPixels, #table_clone(curRGBImage.DPixels));
    local v28 = table_clone(curRGBImage.DPixels);

    if p27.rgbType == "Hue" then
        local v29, v30, v31 = Color3_new(rgbColors[1].X, rgbColors[1].Y, rgbColors[1].Z):ToHSV();

        for i = 1, #v28 / 4 do
            local v32 = (i - 1) * 4 + 1;
            local v33, v34, v35, v36 = unpack(v28, v32, v32 + 3);
            local v37;

            if v36 <= 0 then
                v37 = i;
            else
                local _, v38, v39 = Color3_new(v33, v34, v35):ToHSV();
                local v40 = Color3_fromHSV(v29, (v30 + v38) / 2, v39 / v31);
                local G = v40.G;
                local B = v40.B;
                v28[v32] = v40.R;
                v28[v32 + 1] = G;
                v28[v32 + 2] = B;
                v37 = i;
            end;
        end;
    else
        local v41 = rgbColors[1];
        local v42 = rgbColors[2];
        local v43 = rgbColors[3];

        for i = 1, #v28 / 4 do
            local v44 = (i - 1) * 4 + 1;
            local v45 = v28[v44];
            local v46 = v28[v44 + 1];
            local v47 = v28[v44 + 2];
            local v48;

            if v28[v44 + 3] <= 0 then
                v48 = i;
            else
                local v49 = v45 * v41 + v46 * v42 + v47 * v43;
                local v50 = mix(Vector3_new(v45, v46, v47), Vector3_new(v49.X, v49.Y, v49.Z), 1);
                local Y = v50.Y;
                local Z = v50.Z;
                v28[v44] = v50.X;
                v28[v44 + 1] = Y;
                v28[v44 + 2] = Z;
                v48 = i;
            end;
        end;
    end;

    p27.rgbPixels = v28;

    if p27.rgbEnabled then
        p27.rgbEnabled = false;
        p27:EnableRGB();
    end;
end;

u9.setRGB = u9.setColor;

function u9.RemoveRGB(p51) -- Line: 202
    return p51:setRGBId(nil);
end;

function u9.DisableRGB(p52) -- Line: 206
    local curRGBImage = p52.curRGBImage;

    if not (p52.rgbEnabled and curRGBImage) then
        return;
    end;

    curRGBImage.Image:WritePixels(Vector2.zero, curRGBImage.Size, curRGBImage.DPixels);
    p52.rgbEnabled = false;
end;

function u9.EnableRGB(p53) -- Line: 214
    local curRGBImage = p53.curRGBImage;

    if p53.rgbEnabled or not (curRGBImage and (p53.rgbPixels and p53.rgbPixels[1])) then
        return;
    end;

    print("skibidi");
    curRGBImage.Image:WritePixels(Vector2.zero, curRGBImage.Size, p53.rgbPixels);
    p53.rgbEnabled = true;
end;

function u9.PlayAnimation(p54, p55, ...) -- Line: 224
    local v56 = p54.super:PlayAnimation(p55, ...);

    if table.find(p54.rgbAnims, p55) then
        p54:EnableRGB();

        return v56;
    end;

    p54:DisableRGB();

    return v56;
end;

function u9.linkWith(p57, p58) -- Line: 236
    if p57.linked then
        local linkedRGB = p57.linked.linkedRGB;
        local table_find_ret = table.find(linkedRGB, p57);

        if table_find_ret then
            table.remove(linkedRGB, table_find_ret);
        end;
    end;

    if not p58 then
        p57:setRGBId(nil);

        return;
    end;

    p57:setRGBId(p58.curRgbId);
    p57.rgbColors = p58.rgbColors;
    p57.rgbType = p58.rgbType;
    p57.rgbPixels = p58.rgbPixels;
    p57:PlayAnimation(p57.curAnim);
    table.insert(p58.linkedRGB, p57);
    p57.linked = p58;
end;

function u9.Destroy(p59, ...) -- Line: 260
    p59:setRGBId(nil);

    if p59.prevImage then
        p59.prevImage.Image:Destroy();
        p59.prevImage = nil;
    end;

    p59:linkWith(nil);

    for _, v in p59.linkedRGB do
        v.linked = nil;
    end;

    p59.super:Destroy(...);
end;

getmetatable(u9).__call = function(...) -- Line: 277
    -- upvalues: u9 (copy)
    return u9.new(...);
end;

return u9;