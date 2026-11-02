-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AssetService = game:GetService("AssetService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local DataManager = require(Modules.Data.DataManager);
local Sprite = require(Modules.Main.Sprite);
local Signal = require(Modules.Lib.Signal);
local Data = DataManager:GetData();
local u1 = Signal.new();
local u2 = {};
local u3 = {};

function toContent(p4)
    if type(p4) == "number" then
        return Content.fromAssetId(p4);
    end;

    if type(p4) == "string" then
        return Content.fromUri(p4);
    end;

    if typeof(p4) == "Content" then
        return p4;
    end;

    return Content.none;
end;

function getSourceEditable(p5: userdata)
    -- upvalues: Data (copy), u2 (copy), u3 (copy), u1 (copy), AssetService (copy)
    if Data.DisablePixelManipulation then
        return nil;
    end;

    local u6 = toContent(p5);

    if u2[u6] then
        return u2[u6];
    end;

    if u3[u6] then
        local coroutine_running_ret = coroutine.running();
        local u7 = nil;
        u7 = u1:Connect(function(p8, p9) -- Line: 42
            -- upvalues: u6 (ref), u7 (ref), coroutine_running_ret (copy)
            if p8 ~= u6 then
                return;
            end;

            u7:Disconnect();
            task.spawn(coroutine_running_ret, p9);
        end);

        return coroutine.yield();
    end;

    u3[u6] = true;
    local success, result = pcall(AssetService.CreateEditableImageAsync, AssetService, u6);

    if not success then
        warn("[Pixelation] Failed to load source editable for: ", u6, "-->", result);
        u3[u6] = nil;

        return nil;
    end;

    local Size = result.Size;
    local v10 = result:ReadPixelsBuffer(Vector2.zero, Size);
    local v11 = {
        srcImage = result,
        width = Size.X,
        height = Size.Y,
        originalPixels = v10
    };
    local v12 = math.min(Size.X, Size.Y) / 4;
    local math_floor_ret = math.floor(v12);
    v11.maxPixelSize = math.max(2, math_floor_ret);
    v11.Content = Content.fromObject(result);
    u3[u6] = nil;
    u2[u6] = v11;
    u1:Fire(u6, v11);

    return v11;
end;

local v13, _, v14 = Sprite:Extend();
v13.allowedNilCases.sourceData = true;
v13.allowedNilCases.dstImage = true;
v13.allowedNilCases.lastPixelSize = true;
v13.allowedNilCases.lastAmount = true;

function v13.load(p15, p16) -- Line: 93
    -- upvalues: Data (copy), AssetService (copy)
    if p15.dstImage then
        p15.dstImage:Destroy();
        p15.dstImage = nil;
    end;

    p15.contentOverride = false;
    p15.sourceData = nil;
    p15.lastPixelSize = -1;
    p15.lastAmount = 0;

    if p15.onlyPixelateBlack == nil then
        p15.onlyPixelateBlack = false;
    end;

    if p15.blackThreshold == nil then
        p15.blackThreshold = 10;
    end;

    if not p16 then
        return;
    end;

    if Data.DisablePixelManipulation then
        return;
    end;

    local v17 = getSourceEditable(p16);

    if not v17 then
        return;
    end;

    p15.sourceData = v17;
    p15.dstImage = AssetService:CreateEditableImage({
        Size = Vector2.new(v17.width, v17.height)
    });
    p15.contentOverride = Content.fromObject(p15.dstImage);
    p15:setPixelationAmount(0);
end;

function v13.setOnlyPixelateBlack(p18: table, p19: boolean, p20: number?) -- Line: 127
    local v21 = p20 or (p18.blackThreshold or 10);

    if p18.onlyPixelateBlack == p19 and v21 == p18.blackThreshold then
        return;
    end;

    p18.onlyPixelateBlack = p19;
    p18.blackThreshold = v21;
    p18.lastPixelSize = -1;
    p18:setPixelationAmount(p18.lastAmount or 0);
end;

function v13.setPixelationAmount(p22: table, p23: number) -- Line: 141
    -- upvalues: Data (copy)
    if Data.DisablePixelManipulation then
        return;
    end;

    if not (p22.sourceData and p22.dstImage) then
        return;
    end;

    local math_clamp_ret = math.clamp(p23, 0, 100);
    p22.lastAmount = math_clamp_ret;
    local v24;

    if math_clamp_ret > 0 then
        local math_floor_ret = math.floor(math_clamp_ret / 100 * p22.sourceData.maxPixelSize);
        v24 = math.max(2, math_floor_ret);
    else
        v24 = 1;
    end;

    if v24 == p22.lastPixelSize then
        return;
    end;

    p22.lastPixelSize = v24;
    local width = p22.sourceData.width;
    local height = p22.sourceData.height;
    local originalPixels = p22.sourceData.originalPixels;

    if v24 == 1 then
        p22.dstImage:WritePixelsBuffer(Vector2.zero, Vector2.new(width, height), originalPixels);

        return;
    end;

    if p22.onlyPixelateBlack then
        p22.dstImage:WritePixelsBuffer(Vector2.zero, Vector2.new(width, height), originalPixels);
    end;

    local v25 = p22.blackThreshold or 10;

    for i = 0, height - 1, v24 do
        local v26 = i;

        for i2 = 0, width - 1, v24 do
            local v27 = (v26 * width + i2) * 4;
            local buffer_readu8_ret = buffer.readu8(originalPixels, v27);
            local buffer_readu8_ret2 = buffer.readu8(originalPixels, v27 + 1);
            local buffer_readu8_ret3 = buffer.readu8(originalPixels, v27 + 2);
            local buffer_readu8_ret4 = buffer.readu8(originalPixels, v27 + 3);
            local v28, v29, v30, v31, v32;

            if p22.onlyPixelateBlack then
                local v33;

                if buffer_readu8_ret <= v25 and buffer_readu8_ret2 <= v25 then
                    v33 = buffer_readu8_ret3 <= v25;
                else
                    v33 = false;
                end;

                if v33 then
                    v28 = Color3.fromRGB(buffer_readu8_ret, buffer_readu8_ret2, buffer_readu8_ret3);
                    v29 = 1 - buffer_readu8_ret4 / 255;
                    v30 = math.min(v24, width - i2);
                    v31 = math.min(v24, height - v26);
                    p22.dstImage:DrawRectangle(Vector2.new(i2, v26), Vector2.new(v30, v31), v28, v29, Enum.ImageCombineType.Overwrite);
                    v32 = i2;
                else
                    v32 = i2;
                end;
            else
                v28 = Color3.fromRGB(buffer_readu8_ret, buffer_readu8_ret2, buffer_readu8_ret3);
                v29 = 1 - buffer_readu8_ret4 / 255;
                v30 = math.min(v24, width - i2);
                v31 = math.min(v24, height - v26);
                p22.dstImage:DrawRectangle(Vector2.new(i2, v26), Vector2.new(v30, v31), v28, v29, Enum.ImageCombineType.Overwrite);
                v32 = i2;
            end;
        end;
    end;
end;

function v13.releaseCache(p34) -- Line: 198
    -- upvalues: u2 (copy)
    for _, v in u2 do
        pcall(function() -- Line: 200
            -- upvalues: v (copy)
            v.srcImage:Destroy();
        end);
    end;

    table.clear(u2);
end;

function v13.Destroy(p35, ...) -- Line: 205
    p35:load(nil);
    p35.super:Destroy(...);
end;

v14();

return v13;