-- Decompiled with Potassium's decompiler.

local AssetService = game:GetService("AssetService");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy), AssetService (copy)
    local v3 = setmetatable({}, u1);
    local v4 = nil;

    if typeof(p2) == "Instance" and p2:IsA("ImageLabel") then
        v3.imageLabel = p2;

        if v3.imageLabel.Image == "" then
            v4 = v3.imageLabel.ImageContent;
        else
            v4 = Content.fromUri(v3.imageLabel.Image);
        end;
    else
        v3.imageLabel = Instance.new("ImageLabel");
        v3.isCreated = true;

        if type(p2) == "number" then
            v4 = Content.fromUri("rbxassetid://" .. p2);
        elseif type(p2) == "string" then
            v4 = Content.fromUri(p2);
        elseif typeof(p2) == "Content" then
            v4 = p2;
        else
            error("Invalid input type provided to RecolorShader.new");
        end;

        v3.imageLabel.ImageContent = v4;
    end;

    v3.originalContent = v4;
    v3.aliases = {};
    v3.currentAlias = nil;
    local v5 = AssetService:CreateEditableImageAsync(v3.originalContent);
    local Size = v5.Size;
    v3.width = Size.X;
    v3.height = Size.Y;
    v3.pixelCount = v3.width * v3.height;
    v3.bufferSize = v3.pixelCount * 4;
    v3.originalPixels = v5:ReadPixelsBuffer(Vector2.zero, Size);
    v5:Destroy();

    return v3;
end;

function u1.newMultiple(...) -- Line: 60
    -- upvalues: u1 (copy)
    local v6 = {};

    for _, v in ipairs({ ... }) do
        table.insert(v6, u1.new(v));
    end;

    return table.unpack(v6);
end;

function u1.BakeColor(p7: table, p8: string, p9, p10, p11: number?) -- Line: 71
    -- upvalues: AssetService (copy)
    local math_round_ret = math.round(p9.R * 255);
    local math_round_ret2 = math.round(p9.G * 255);
    local math_round_ret3 = math.round(p9.B * 255);
    local math_round_ret4 = math.round(p10.R * 255);
    local math_round_ret5 = math.round(p10.G * 255);
    local math_round_ret6 = math.round(p10.B * 255);
    local v12 = ((p11 or 0.05) * 255) ^ 2 * 3;
    local buffer_create_ret = buffer.create(p7.bufferSize);
    buffer.copy(buffer_create_ret, 0, p7.originalPixels, 0, p7.bufferSize);

    for i = 0, p7.bufferSize - 1, 4 do
        local buffer_readu8_ret = buffer.readu8(buffer_create_ret, i);
        local buffer_readu8_ret2 = buffer.readu8(buffer_create_ret, i + 1);
        local buffer_readu8_ret3 = buffer.readu8(buffer_create_ret, i + 2);
        local v13;

        if (buffer_readu8_ret - math_round_ret) ^ 2 + (buffer_readu8_ret2 - math_round_ret2) ^ 2 + (buffer_readu8_ret3 - math_round_ret3) ^ 2 <= v12 then
            buffer.writeu8(buffer_create_ret, i, math_round_ret4);
            buffer.writeu8(buffer_create_ret, i + 1, math_round_ret5);
            buffer.writeu8(buffer_create_ret, i + 2, math_round_ret6);
            v13 = i;
        else
            v13 = i;
        end;
    end;

    local Vector2_new_ret = Vector2.new(p7.width, p7.height);
    local v14 = AssetService:CreateEditableImage({
        Size = Vector2_new_ret
    });
    v14:WritePixelsBuffer(Vector2.zero, Vector2_new_ret, buffer_create_ret);
    local v15, v16 = AssetService:CreateDataModelContentAsync(Content.fromObject(v14));

    if v15 == Enum.CreateContentResult.Success then
        p7.aliases[p8] = v16;
    else
        warn("RecolorShader failed to bake content for alias \'" .. tostring(p8) .. "\': ", v15);
    end;

    v14:Destroy();
end;

function u1.Render(p17: table, p18: string) -- Line: 116
    if not p17.aliases[p18] then
        warn("RecolorShader: Alias not found or not baked yet -> " .. tostring(p18));

        return;
    end;

    p17.imageLabel.ImageContent = p17.aliases[p18];
    p17.currentAlias = p18;
end;

function u1.Reset(p19) -- Line: 125
    if p19.imageLabel and p19.originalContent then
        p19.imageLabel.ImageContent = p19.originalContent;
        p19.currentAlias = nil;
    end;
end;

function u1.DeleteAlias(p20: table, p21: string) -- Line: 132
    if p20.aliases[p21] then
        p20.aliases[p21] = nil;

        if p20.currentAlias == p21 then
            p20:Reset();
        end;
    end;
end;

function u1.Destroy(p22) -- Line: 142
    p22:Reset();

    if p22.isCreated and p22.imageLabel then
        p22.imageLabel:Destroy();
    end;

    p22.aliases = nil;
    p22.originalPixels = nil;
    p22.imageLabel = nil;
    p22.originalContent = nil;
end;

return u1;