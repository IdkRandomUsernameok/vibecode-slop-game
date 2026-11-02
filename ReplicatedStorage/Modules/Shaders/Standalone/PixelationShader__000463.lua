-- Decompiled with Potassium's decompiler.

local AssetService = game:GetService("AssetService");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy), AssetService (copy)
    local v3 = setmetatable({}, u1);
    v3.imageLabel = p2;
    v3.originalImageId = p2.Image;
    v3.srcImage = AssetService:CreateEditableImageAsync(Content.fromUri(v3.originalImageId));
    local Size = v3.srcImage.Size;
    v3.width = Size.X;
    v3.height = Size.Y;
    v3.dstImage = AssetService:CreateEditableImage({
        Size = Size
    });
    v3.imageLabel.ImageContent = Content.fromObject(v3.dstImage);
    v3.originalPixels = v3.srcImage:ReadPixelsBuffer(Vector2.zero, Size);
    v3.lastPixelSize = -1;
    local v4 = math.min(v3.width, v3.height) / 4;
    local math_floor_ret = math.floor(v4);
    v3.maxPixelSize = math.max(2, math_floor_ret);

    return v3;
end;

function u1.setPixelationAmount(p5, p6) -- Line: 32
    local math_clamp_ret = math.clamp(p6, 0, 100);
    local v7;

    if math_clamp_ret > 0 then
        local math_floor_ret = math.floor(math_clamp_ret / 100 * p5.maxPixelSize);
        v7 = math.max(2, math_floor_ret);
    else
        v7 = 1;
    end;

    if v7 == p5.lastPixelSize then
        return;
    end;

    p5.lastPixelSize = v7;

    if p5.srcImage then
        local Size = p5.srcImage.Size;

        if v7 == 1 then
            p5.dstImage:WritePixelsBuffer(Vector2.zero, Size, p5.originalPixels);

            return;
        end;

        for i = 0, p5.height - 1, v7 do
            local v8 = i;

            for i2 = 0, p5.width - 1, v7 do
                local v9 = (v8 * p5.width + i2) * 4;
                local buffer_readu8_ret = buffer.readu8(p5.originalPixels, v9);
                local buffer_readu8_ret2 = buffer.readu8(p5.originalPixels, v9 + 1);
                local buffer_readu8_ret3 = buffer.readu8(p5.originalPixels, v9 + 2);
                local buffer_readu8_ret4 = buffer.readu8(p5.originalPixels, v9 + 3);
                local Color3_fromRGB_ret = Color3.fromRGB(buffer_readu8_ret, buffer_readu8_ret2, buffer_readu8_ret3);
                local math_min_ret = math.min(v7, p5.width - i2);
                local math_min_ret2 = math.min(v7, p5.height - v8);
                p5.dstImage:DrawRectangle(Vector2.new(i2, v8), Vector2.new(math_min_ret, math_min_ret2), Color3_fromRGB_ret, 1 - buffer_readu8_ret4 / 255, Enum.ImageCombineType.Overwrite);
                local _ = i2;
            end;
        end;
    end;
end;

function u1.Destroy(p10) -- Line: 72
    if p10.srcImage then
        p10.srcImage:Destroy();
        p10.srcImage = nil;
    end;

    if p10.dstImage then
        p10.dstImage:Destroy();
        p10.dstImage = nil;
    end;

    if p10.imageLabel then
        p10.imageLabel.ImageContent = Content.fromUri(p10.originalImageId);
    end;

    p10.originalPixels = nil;
    p10.imageLabel = nil;
end;

return u1;