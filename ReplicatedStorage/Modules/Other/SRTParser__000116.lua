-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = { "-->", "->", "—>", "–>" };

function u1.parseTimeLine(p3) -- Line: 5
    -- upvalues: u2 (copy), u1 (copy)
    local v4 = nil;
    local v5 = nil;

    for _, v in ipairs(u2) do
        local string_split_ret = string.split(p3, v);

        if #string_split_ret == 2 then
            v4 = string.gsub(string_split_ret[1], "^%s*(.-)%s*$", "%1");
            v5 = string.gsub(string_split_ret[2], "^%s*(.-)%s*$", "%1");
            break;
        end;
    end;

    if not (v4 and v5) then
        return nil;
    end;

    local v6 = u1.parseTimecode(v4);
    local v7 = u1.parseTimecode(v5);

    return v6 >= 0 and v7 >= 0 and {
        start = v6,
        ["end"] = v7
    } or nil;
end;

function u1.parseTimecode(p8) -- Line: 35
    local string_gsub_ret = string.gsub(p8, "^%s*(.-)%s*$", "%1");
    local string_gsub_ret2 = string.gsub(string_gsub_ret, ",", ".");
    local string_split_ret = string.split(string_gsub_ret2, ":");

    if #string_split_ret ~= 3 then
        error("Invalid timecode: " .. p8);
    end;

    local v9 = tonumber(string_split_ret[1]);
    local v10 = tonumber(string_split_ret[2]);
    local string_split_ret2 = string.split(string_split_ret[3], ".");
    local v11 = tonumber(string_split_ret2[1]);
    local v12;

    if #string_split_ret2 > 1 then
        local v13 = string_split_ret2[2];

        if #v13 > 3 then
            v13 = string.sub(v13, 1, 3);
        end;

        while #v13 < 3 do
            v13 = v13 .. "0";
        end;

        v12 = tonumber(v13);
    else
        v12 = 0;
    end;

    return (v9 * 3600 + v10 * 60 + v11 + v12 / 1000) * 1000;
end;

function u1.parse(p14) -- Line: 65
    -- upvalues: u1 (copy)
    local v15 = {};

    for _, v in string.split(p14, "\n\n") do
        local string_gsub_ret = string.gsub(v, "^%s*(.-)%s*$", "%1");

        if string_gsub_ret ~= "" then
            local string_split_ret = string.split(string_gsub_ret, "\n");
            local v16 = tonumber(string_split_ret[1]);
            local v17 = u1.parseTimeLine(string_split_ret[2]);
            local table_move_ret = table.move(string_split_ret, 3, #string_split_ret, 1, {});
            local math_abs_ret = math.abs(v17["end"] - v17.start);
            local v18 = {
                text = table.concat(table_move_ret, "\n"),
                index = v16,
                startTime = v17.start,
                endTime = v17["end"],
                length = math_abs_ret
            };
            table.insert(v15, v18);
        end;
    end;

    return v15;
end;

return u1;