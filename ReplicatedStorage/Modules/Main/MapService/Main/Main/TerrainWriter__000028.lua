-- Decompiled with Potassium's decompiler.

local u1 = { "Air", "Water", "Grass", "WoodPlanks", "Basalt", "Slate", "CrackedLava", "Concrete", "Limestone", "Pavement", "Brick", "Cobblestone", "Rock", "Sandstone", "CorrodedMetal", "LeafyGrass", "Sand", "Snow", "Mud", "Ground", "Asphalt", "Salt", "Ice", "Glacier" };
local v2 = {};

for i = 1, #u1 do
    local v3 = Enum.Material:FromName(u1[i]);

    if not v3 then
        warn("[TerrainWriter] Enum doesn\'t exist");
    end;

    if v3 then
        u1[v3] = i - 1;
        u1[i - 1] = v3;
    end;

    u1[i] = nil;
    local _ = i;
end;

local u4 = {
    {
        255,
        buffer.writeu8,
        buffer.readu8,
        1
    },
    {
        65535,
        buffer.writeu16,
        buffer.readu16,
        2
    },
    {
        1,
        buffer.writef32,
        buffer.readf32,
        4
    },
    {
        4294967295,
        buffer.writeu32,
        buffer.readu32,
        4
    },
    {
        1,
        buffer.writef64,
        buffer.readf64,
        8
    }
};

function v2.save(p5: table, p6: table, p7: table, p8: number?) -- Line: 37
    -- upvalues: u4 (copy), u1 (copy)
    local v9 = tonumber(p8) or 1;
    local math_clamp_ret = math.clamp(v9, 1, 5);
    local v10 = u4[math_clamp_ret];
    local v11 = v10[1] or 255;
    local v12 = v10[2] or buffer.writeu8;
    local v13 = p6.Size or p7.Size;
    local v14 = 1 + (v10[4] or 1);
    local buffer_create_ret = buffer.create(v14 * v13.X * v13.Y * v13.Z);
    local v15 = 0;

    for i = 1, v13.X do
        local v16 = i;

        for i2 = 1, v13.Y do
            local v17 = i2;

            for i3 = 1, v13.Z do
                local v18 = u1[p6[v16][v17][i3]];
                local v19 = v11 == 1 and p7[v16][v17][i3] or math.round(p7[v16][v17][i3] * v11);

                if type(v18) ~= "number" then
                    warn("[TerrainWriter] Bad material here", p6[v16][v17][i3], v18);
                    v18 = u1[Enum.Material.Air];
                end;

                buffer.writeu8(buffer_create_ret, v15, v18);
                v12(buffer_create_ret, v15 + 1, v19);
                v15 = v15 + v14;
                local _ = i3;
            end;
        end;
    end;

    return buffer.tostring(buffer_create_ret), v13, math_clamp_ret;
end;

function v2.load(p20: table, p21: string, p22: vector, p23: number?) -- Line: 74
    -- upvalues: u4 (copy), u1 (copy)
    local v24 = tonumber(p23) or 1;
    local v25 = u4[math.clamp(v24, 1, 5)];
    local v26 = v25[1] or 255;
    local v27 = v25[3] or buffer.readu8;
    local v28 = 1 + (v25[4] or 1);
    local buffer_fromstring_ret = buffer.fromstring(p21);
    local table_create_ret = table.create(p22.X, nil);
    local table_create_ret2 = table.create(p22.X, nil);
    table_create_ret.Size = p22;
    table_create_ret2.Size = p22;
    local v29 = 0;

    for i = 1, p22.X do
        local table_create_ret3 = table.create(p22.Y, nil);
        local table_create_ret4 = table.create(p22.Y, nil);
        table_create_ret[i] = table_create_ret3;
        table_create_ret2[i] = table_create_ret4;
        local _ = i;

        for i2 = 1, p22.Y do
            local table_create_ret5 = table.create(p22.Z, Enum.Material.Air);
            local table_create_ret6 = table.create(p22.Z, 0);
            table_create_ret3[i2] = table_create_ret5;
            table_create_ret4[i2] = table_create_ret6;
            local _ = i2;

            for i3 = 1, p22.Z do
                local buffer_readu8_ret = buffer.readu8(buffer_fromstring_ret, v29);
                local v30 = v27(buffer_fromstring_ret, v29 + 1);
                table_create_ret5[i3] = u1[buffer_readu8_ret] or Enum.Material.Air;
                table_create_ret6[i3] = v30 / v26;
                v29 = v29 + v28;
                local _ = i3;
            end;
        end;
    end;

    return table_create_ret, table_create_ret2;
end;

return v2;