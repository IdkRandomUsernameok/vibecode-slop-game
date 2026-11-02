-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AssetService = game:GetService("AssetService");
local Modules = ReplicatedStorage:WaitForChild("Modules");
local Sprite = require(Modules.Main.Sprite);
local u1 = require(Modules.Lib.Signal).new();
local u2 = {};
local u3 = {};
local _ = Vector2.zero;
local _ = Vector2.one;
local Color3_new = Color3.new;
local Color3_fromRGB = Color3.fromRGB;
local Color3_fromHSV = Color3.fromHSV;
local _ = Vector3.new;

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

function makeEditableTable(p5: userdata, p6: any)
    return {
        Size = p5.Size,
        Image = p5,
        Content = Content.fromObject(p5),
        Id = p6,
        References = {}
    };
end;

function getEditable(p7: userdata)
    -- upvalues: AssetService (copy)
    local v8 = toContent(p7);
    local success, result = pcall(AssetService.CreateEditableImageAsync, AssetService, v8);

    if success then
        return result and makeEditableTable(result, v8) or nil;
    end;

    warn("[Recoloring] Failed to load editable for: ", v8.Uri, "-->", result);

    return nil;
end;

function cacheEditable(p9: userdata)
    -- upvalues: u2 (copy), u3 (copy), u1 (copy)
    local u10 = toContent(p9);

    if u2[u10] then
        return u2[u10];
    end;

    if u3[u10] then
        local coroutine_running_ret = coroutine.running();
        local u11 = nil;
        u11 = u1:Connect(function(p12, p13) -- Line: 81
            -- upvalues: u10 (ref), u11 (ref), coroutine_running_ret (copy)
            if p12 ~= u10 then
                return;
            end;

            u11:Disconnect();
            task.spawn(coroutine_running_ret, p13);
        end);

        return coroutine.yield();
    end;

    u3[u10] = true;
    local v14 = getEditable(u10);
    u3[u10] = nil;
    u1:Fire(u10, v14);
    u2[u10] = v14;

    return v14;
end;

function cloneEditable(p15: userdata)
    -- upvalues: AssetService (copy)
    local success, result = pcall(AssetService.CreateEditableImageAsync, AssetService, Content.fromObject(p15));

    if success then
        return result;
    end;

    warn("[Recoloring] Failed to clone editable -->", result);

    return nil;
end;

function applyShaderOn(p16: userdata, p17, p18, p19: table, p20: string)
    -- upvalues: Color3_new (copy), Color3_fromRGB (copy), Color3_fromHSV (copy)
    local v21 = p16:ReadPixelsBuffer(p17, p18);

    if p20 == "Hue" then
        local v22 = p19[1];
        local v23, v24, v25 = Color3_new(v22.X, v22.Y, v22.Z):ToHSV();

        for i = 0, buffer.len(v21) / 4 - 1 do
            local v26 = i * 4;
            local v27;

            if buffer.readu8(v21, v26 + 3) == 0 then
                v27 = i;
            else
                local _, v28, v29 = Color3_fromRGB(buffer.readu8(v21, v26), buffer.readu8(v21, v26 + 1), (buffer.readu8(v21, v26 + 2))):ToHSV();
                local v30 = Color3_fromHSV(v23, v28 * v24, v29 * v25);
                local math_round_ret = math.round(v30.R * 255);
                buffer.writeu8(v21, v26, math_round_ret);
                local math_round_ret2 = math.round(v30.G * 255);
                buffer.writeu8(v21, v26 + 1, math_round_ret2);
                local math_round_ret3 = math.round(v30.B * 255);
                buffer.writeu8(v21, v26 + 2, math_round_ret3);
                v27 = i;
            end;
        end;
    elseif p20 == "HueShift" then
        local v31 = p19[1];
        local X = v31.X;
        local Y = v31.Y;
        local Z = v31.Z;

        for i = 0, buffer.len(v21) / 4 - 1 do
            local v32 = i * 4;
            local v33;

            if buffer.readu8(v21, v32 + 3) == 0 then
                v33 = i;
            else
                local v34, v35, v36 = Color3_fromRGB(buffer.readu8(v21, v32), buffer.readu8(v21, v32 + 1), (buffer.readu8(v21, v32 + 2))):ToHSV();
                local v37 = Color3_fromHSV((v34 + X) % 1, math.clamp(v35 + Y, 0, 1), (math.clamp(v36 + Z, 0, 1)));
                local math_round_ret = math.round(v37.R * 255);
                buffer.writeu8(v21, v32, math_round_ret);
                local math_round_ret2 = math.round(v37.G * 255);
                buffer.writeu8(v21, v32 + 1, math_round_ret2);
                local math_round_ret3 = math.round(v37.B * 255);
                buffer.writeu8(v21, v32 + 2, math_round_ret3);
                v33 = i;
            end;
        end;
    elseif p20 == "Tint" then
        local v38 = p19[1];
        local _, _, _ = Color3_new(v38.X, v38.Y, v38.Z):ToHSV();

        for i = 0, buffer.len(v21) / 4 - 1 do
            local v39 = i * 4;
            local v40;

            if buffer.readu8(v21, v39 + 3) == 0 then
                v40 = i;
            else
                local buffer_readu8_ret = buffer.readu8(v21, v39);
                local buffer_readu8_ret2 = buffer.readu8(v21, v39 + 1);
                local buffer_readu8_ret3 = buffer.readu8(v21, v39 + 2);
                local v41 = Vector3.new(buffer_readu8_ret, buffer_readu8_ret2, buffer_readu8_ret3) * v38;
                local math_round_ret = math.round(v41.X);
                buffer.writeu8(v21, v39, math_round_ret);
                local math_round_ret2 = math.round(v41.Y);
                buffer.writeu8(v21, v39 + 1, math_round_ret2);
                local math_round_ret3 = math.round(v41.Z);
                buffer.writeu8(v21, v39 + 2, math_round_ret3);
                v40 = i;
            end;
        end;
    elseif p20 == "RGB" then
        local v42 = p19[1];
        local v43 = p19[2];
        local v44 = p19[3];

        for i = 0, buffer.len(v21) / 4 - 1 do
            local v45 = i * 4;
            local v46;

            if buffer.readu8(v21, v45 + 3) == 0 then
                v46 = i;
            else
                local v47 = buffer.readu8(v21, v45) / 255;
                local v48 = buffer.readu8(v21, v45 + 1) / 255;
                local v49 = buffer.readu8(v21, v45 + 2) / 255;
                local v50 = v47 * v42 + v48 * v43 + v49 * v44;
                buffer.writeu8(v21, v45, v50.X);
                buffer.writeu8(v21, v45 + 1, v50.Y);
                buffer.writeu8(v21, v45 + 2, v50.Z);
                v46 = i;
            end;
        end;
    end;

    p16:WritePixelsBuffer(p17, p18, v21);
end;

function formatColors(p51)
    local v52 = type(p51) ~= "table" and { p51 } or p51;

    for i, v in v52 do
        if typeof(v) == "Color3" then
            v52[i] = vector.create(v.R, v.G, v.B);
        elseif typeof(v) == "Vector3" then
            v52[i] = vector.create(v.X, v.Y, v.Z);
        end;
    end;

    return v52;
end;

function getIdFromEditData(p53: table)
    local v54 = {};

    for _, v in p53 do
        local v55 = v.Colors and (formatColors(v.Colors) or { Vector3.new(1, 1, 1) }) or { Vector3.new(1, 1, 1) };
        local v56 = v.Method or "Hue";
        local v57 = v.Frames or {};
        local v58 = {};

        for i, v2 in v55 do
            v58[i] = tostring(v2);
        end;

        local table_concat = table.concat;
        local v59 = { table.concat(v58, "~"), v56, (tostring(v57)) };
        table.insert(v54, table_concat(v59, "#"));
    end;

    return table.concat(v54, "|");
end;

function editImage(p60: any, p61: table)
    local v62 = p61.Colors and { p61 } or p61;
    local X = p60.Size.X;
    local Y = p60.Size.Y;

    for _, v in v62 do
        local v63 = v.Colors and (formatColors(v.Colors) or { Vector3.new(1, 1, 1) }) or { Vector3.new(1, 1, 1) };
        local v64 = v.Method or "Hue";
        local v65 = {};

        for _, v2 in v.Frames or {} do
            local Offset = v2.Offset;
            local Size = v2.Size;
            local v66 = Offset + Size;
            local v67 = X < v66.X;
            local v68 = Y < v66.Y;

            if v67 or v68 then
                Offset = Offset - Vector2.new(v67 and (v66.X - X or 0) or 0, v68 and (v66.Y - Y or 0) or 0);
            end;

            local v69 = tostring(Offset) .. "|" .. tostring(Size);

            if not v65[v69] then
                v65[v69] = true;
                applyShaderOn(p60, Offset, Size, v63, v64);
            end;
        end;
    end;
end;

function convertOldSetToEditData(p70: any, p71: any, p72: any, p73: string)
    local v74 = {};
    local v75 = {
        Colors = p72,
        Method = p73,
        Frames = {}
    };

    for i, v in p70 do
        if table.find(p71, i) then
            for _, v2 in #v > 0 and v and v or v.Frames do
                local Size = v2.Size;
                local v76 = tostring(v2.Offset) .. "|" .. tostring(Size);

                if not v74[v76] then
                    table.insert(v75.Frames, v2);
                    v74[v76] = true;
                end;
            end;
        end;
    end;

    return v75;
end;

local v77, _, v78 = Sprite:Extend();
v77.allowedNilCases.editableData = true;

function v77.editImage(p79: table, p80: any, p81: table, p82: boolean) -- Line: 299
    -- upvalues: u2 (copy)
    local v83;

    if typeof(p80) == "Object" then
        v83 = p80;
    else
        v83 = false;
    end;

    local v84;

    if v83 then
        v84 = "";
        p82 = false;
    else
        local v85 = getEditable(toContent(p80));

        if not v85 then
            return;
        end;

        v84 = v85.Content.Uri or "";
        v83 = v85.Image;
    end;

    if v83 then
        local v86 = p81.Colors and { p81 } or p81;
        local v87 = v84 .. getIdFromEditData(v86);
        editImage(v83, v86);

        if p82 then
            u2[v87] = makeEditableTable(v83, v87);
        end;

        return v87;
    end;
end;

function v77.getEditable(p88, p89) -- Line: 330
    return getEditable(p89);
end;

function v77.cacheId(p90, p91) -- Line: 334
    return cacheEditable(p91);
end;

function v77.cacheSetWithColor(p92: table, p93: any, p94: any, p95: any, p96: any, p97: string) -- Line: 339
    return p92:editImage(p93, convertOldSetToEditData(p94, p95, p96, p97), true);
end;

function v77.releaseCache(p98) -- Line: 343
    -- upvalues: u2 (copy)
    for _, v in u2 do
        pcall(function() -- Line: 345
            -- upvalues: v (copy)
            v.Image:Destroy();
        end);

        for i, _ in v.References do
            i:load(nil);
        end;
    end;

    table.clear(u2);
end;

function v77.load(p99, p100) -- Line: 355
    -- upvalues: u2 (copy)
    if p99.editableData then
        p99.editableData.References[p99] = nil;
    end;

    p99.contentOverride = false;
    p99.editableData = nil;

    if typeof(p100) == "Object" then
        p99.contentOverride = Content.fromObject(p100);

        return;
    end;

    local v101 = type(p100) == "table" and p100 and p100 or u2[p100 or ""];

    if not v101 then
        return;
    end;

    v101.References[p99] = true;
    p99.editableData = v101;
    p99.contentOverride = v101.Content;
end;

function v77.Destroy(p102, ...) -- Line: 376
    p102:load(nil);
    p102.super:Destroy(...);
end;

v78();

return v77;