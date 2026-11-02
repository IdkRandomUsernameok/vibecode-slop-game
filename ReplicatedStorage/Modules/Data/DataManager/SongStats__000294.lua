-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};

function addDiff(p3, p4)
    -- upvalues: u1 (copy), u2 (copy)
    u1[p4] = p3;
    u2[p3] = p4;
end;

addDiff("Noob", 0);
addDiff("Easy", 1);
addDiff("Normal", 2);
addDiff("Medium", 3);
addDiff("Hard", 4);
addDiff("Standard", 5);
addDiff("Advanced", 6);
addDiff("Expert", 7);
addDiff("Insane", 8);
addDiff("Exhausted", 9);
addDiff("Exhilirated", 10);
addDiff("X_X", 11);
addDiff("Impossible", 12);
addDiff("4K", 13);
addDiff("Legacy", 999);
local u5 = { "[", "]" };
local u6 = { "{", "}" };
local u7 = `[%{u5[1]}%{u5[2]}%{u6[1]}%{u6[2]}%:%|%,]`;
local u8 = {};
local u9 = {
    [4] = "MFC",
    [3] = "PFC",
    [2] = "GFC",
    [1] = "FC"
};
local u10 = {
    MFC = 4,
    PFC = 3,
    GFC = 2,
    FC = 1
};

for i = 1, 127 do
    local string_char_ret = string.char(i);
    u8[string_char_ret] = i - 1;
    u8[i - 1] = string_char_ret;
    local _ = i;
end;

local function copy(p11) -- Line: 104
    local v12 = {};

    for i, v in pairs(p11) do
        v12[i] = v;
    end;

    return v12;
end;

local function tobase127(p13) -- Line: 112
    -- upvalues: u8 (copy)
    local v14 = "";

    repeat
        local v15 = p13 % 127;
        v14 = u8[v15] .. v14;
        p13 = (p13 - v15) / 127;
    until p13 == 0;

    return v14;
end;

local function tobase10(p16) -- Line: 122
    -- upvalues: u8 (copy)
    local v17 = 0;

    for i = 1, #p16 do
        v17 = v17 + 127 ^ (i - 1) * u8[p16:sub(-i, -i)];
        local _ = i;
    end;

    return v17;
end;

function compress(p18)
    -- upvalues: u8 (copy)
    local u19 = {};

    for i, v in pairs(u8) do
        u19[i] = v;
    end;

    local v20 = "";
    local u21 = {};
    local v22 = #u19;
    local u23 = 1;
    local u24 = {};
    local u25 = 0;

    local function listkey(p26) -- Line: 134
        -- upvalues: u19 (copy), u8 (ref), u23 (ref), u25 (ref), u24 (copy), u21 (copy)
        local v27 = u19[p26];
        local v28 = "";

        repeat
            local v29 = v27 % 127;
            v28 = u8[v29] .. v28;
            v27 = (v27 - v29) / 127;
        until v27 == 0;

        if u23 < #v28 then
            local v30 = u23;
            local v31 = u25;
            u23 = #v28;
            u25 = 0;
            u24[v30] = v31;
        end;

        u21[#u21 + 1] = ("\1"):rep(u23 - #v28) .. v28;
        u25 = u25 + 1;
    end;

    for i = 1, #p18 do
        local v32 = p18:sub(i, i);
        local v33 = v20 .. v32;
        local v34;

        if u19[v33] then
            v20 = v33;
            v34 = i;
        else
            local v35 = u19[v20];
            v34 = i;
            local v36 = "";

            repeat
                local v37 = v35 % 127;
                v36 = u8[v37] .. v36;
                v35 = (v35 - v37) / 127;
            until v35 == 0;

            if u23 < #v36 then
                u24[u23] = u25;
                u23 = #v36;
                u25 = 0;
            end;

            u21[#u21 + 1] = ("\1"):rep(u23 - #v36) .. v36;
            u25 = u25 + 1;
            v22 = v22 + 1;
            u19[v33] = v22;
            u19[v22] = v33;
            v20 = v32;
        end;
    end;

    if v20 ~= "" then
        local v38 = u19[v20];
        local v39 = "";

        repeat
            local v40 = v38 % 127;
            v39 = u8[v40] .. v39;
            v38 = (v38 - v40) / 127;
        until v38 == 0;

        if u23 < #v39 then
            u24[u23] = u25;
            u23 = #v39;
            u25 = 0;
        end;

        u21[#u21 + 1] = ("\1"):rep(u23 - #v39) .. v39;
        u25 = u25 + 1;
    end;

    u24[u23] = u25;

    return table.concat(u24, ",") .. "|" .. table.concat(u21);
end;

function decompress(p41)
    -- upvalues: u8 (copy), tobase10 (copy)
    local v42 = {};

    for i, v in pairs(u8) do
        v42[i] = v;
    end;

    local v43, v44 = p41:match("(.-)|(.*)");
    local v45 = {};
    local v46 = 1;
    local v47 = {};

    for i in v43:gmatch("%d+") do
        local v48 = #v45 + 1;
        v45[v48] = v44:sub(v46, v46 + i * v48 - 1);
        v46 = v46 + i * v48;
    end;

    local v49 = nil;

    for i = 1, #v45 do
        local _ = i;

        for i2 in v45[i]:gmatch(("."):rep(i)) do
            local v50 = v42[tobase10(i2)];

            if v49 then
                if v50 then
                    v47[#v47 + 1] = v50;
                    v42[#v42 + 1] = v49 .. v50:sub(1, 1);
                else
                    v50 = v49 .. v49:sub(1, 1);
                    v47[#v47 + 1] = v50;
                    v42[#v42 + 1] = v50;
                end;
            else
                v47[1] = v50;
            end;

            v49 = v50;
        end;
    end;

    return table.concat(v47);
end;

function decodeChar(p51)
    local v52 = tonumber(p51, 16);

    return string.char(v52);
end;

function urlDecode(p53)
    local string_gsub_ret, _ = string.gsub(p53, "%%(%x%x)", decodeChar);

    return string_gsub_ret;
end;

function safeEncode(p54)
    -- upvalues: u7 (copy)
    if p54:find("[\192-\255][\128-\191]*") or p54:find(u7) then
        return game:GetService("HttpService"):UrlEncode(p54);
    end;

    return p54;
end;

function safeDecode(p55)
    return urlDecode(p55);
end;

function compressAcc(p56)
    if p56 == 100 then
        return "P";
    end;

    if p56 < 1 then
        return "." .. round(p56 * 100, 2);
    end;

    if string.len(p56) <= 2 then
        return p56;
    end;

    return math.round(p56 * 100);
end;

function decompressAcc(p57)
    if p57 == "P" then
        return 100;
    end;

    if string.sub(p57, 1, 1) == "." then
        local string_sub_ret = string.sub(p57, 2);

        return tonumber(string_sub_ret) / 100;
    end;

    if string.len(p57) <= 2 then
        return tonumber(p57);
    end;

    return tonumber(p57) / 100;
end;

function compressTable(p58)
    -- upvalues: u2 (copy), u6 (copy), u5 (copy)
    local v59 = 0;
    local v60 = {};

    for i, v in p58 do
        v59 = v59 + 1;
        local v61 = "";

        for i2, v2 in v do
            local v62 = {};

            for i3, v3 in v2 do
                if i3 ~= "__AFNHFCData" then
                    local v63 = { u2[i3] or safeEncode(i3), (encryptDiffData(v3)) };
                    table.insert(v62, table.concat(v63, ":"));
                end;
            end;

            local table_concat_ret = table.concat(v62, ",");
            v61 = v61 .. `{safeEncode(i2)}{u6[1]}{table_concat_ret}{u6[2]}`;
        end;

        v60[v59] = `{safeEncode(i)}{u5[1]}{v61}{u5[2]}`;
    end;

    return table.concat(v60, "");
end;

function decompressTable(p64)
    -- upvalues: u5 (copy), u6 (copy), u1 (copy), u9 (copy)
    local v65 = {};

    for _, v in string.split(p64, u5[2]) do
        local string_find_ret = string.find(v, "%" .. u5[1]);

        if string_find_ret then
            local string_sub_ret = string.sub(v, 1, string_find_ret - 1);
            local string_sub_ret2 = string.sub(v, string_find_ret + 1);
            local v66 = {};

            for _, v2 in string.split(string_sub_ret2, u6[2]) do
                local string_find_ret2 = string.find(v2, u6[1]);

                if string_find_ret2 then
                    local string_sub_ret3 = string.sub(v2, 1, string_find_ret2 - 1);
                    local string_sub_ret4 = string.sub(v2, string_find_ret2 + 1);
                    local v67 = 0;
                    local v68 = {};

                    for _, v3 in string.split(string_sub_ret4, ",") do
                        local string_split_ret = string.split(v3, ":");

                        if string_split_ret[2] then
                            local v69 = tonumber(string_split_ret[2]:sub(1, 1)) or 0;
                            v67 = math.max(v67, v69);
                            v68[u1[tonumber(string_split_ret[1]) or ""] or safeDecode(string_split_ret[1])] = decryptDiffData(string_split_ret[2]);
                        end;
                    end;

                    v68.__AFNHFCData = u9[v67];

                    if next(v68) then
                        v66[safeDecode(string_sub_ret3)] = v68;
                    end;
                end;
            end;

            v65[safeDecode(string_sub_ret)] = v66;
        end;
    end;

    return v65;
end;

function encryptDiffData(p70)
    -- upvalues: u10 (copy)
    local v71 = compressAcc(p70.Accuracy);
    local v72 = u10[p70.FCData or ""] or 0;
    local Misses = p70.Misses;

    if v72 ~= 0 then
        Misses = nil;
    end;

    return table.concat(Misses and {
        v72,
        p70.Score,
        v71,
        Misses
    } or { v72, p70.Score, v71 }, "|");
end;

function decryptDiffData(p73)
    -- upvalues: u9 (copy)
    local string_split_ret = string.split(p73, "|");
    local v74 = string_split_ret[1];
    local v75 = string_split_ret[2];
    local v76 = decompressAcc(string_split_ret[3]);
    local v77 = string_split_ret[4];
    local v78 = u9[tonumber(v74) or ""] or nil;
    local v79 = tonumber(v75) or 0;
    local v80 = v78 and 0 or (tonumber(v77) or 0);

    return v76 <= 100 and (v76 ~= 100 or v79 > 0) and {
        FCData = v78,
        Score = v79,
        Accuracy = v76,
        Misses = v80
    } or nil;
end;

function encryptData(p81: table)
    return compress(compressTable(p81));
end;

function decryptData(p82: string)
    return decompressTable(decompress(p82));
end;

function round(p83, p84)
    local v85 = 10 ^ (p84 or 0);

    return math.floor(p83 * v85 + 0.5) / v85;
end;

local function encryptRunData(p86) -- Line: 365
    -- upvalues: u10 (copy)
    local v87 = u10[p86.FCData or ""] or 0;
    local v88 = compressAcc(p86.Accuracy);
    local v89 = v87 ~= 0 and "" or tostring(p86.Misses or 0);

    return table.concat({
        v87,
        p86.Score,
        v88,
        v89,
        p86.Timestamp or ""
    }, "^");
end;

local function decryptRunData(p90) -- Line: 379
    -- upvalues: u9 (copy)
    local string_split_ret = string.split(p90, "^");
    local v91 = u9[tonumber(string_split_ret[1]) or ""] or nil;
    local v92 = tonumber(string_split_ret[2]) or 0;
    local v93 = decompressAcc(string_split_ret[3]);
    local v94 = v91 and 0 or (tonumber(string_split_ret[4]) or 0);
    local v95 = tonumber(string_split_ret[5]) or nil;

    return v93 <= 100 and (v93 ~= 100 or v92 > 0) and {
        FCData = v91,
        Score = v92,
        Accuracy = v93,
        Misses = v94,
        Timestamp = v95
    } or nil;
end;

local function encryptSessionBody(p96) -- Line: 401
    -- upvalues: u2 (copy), encryptRunData (copy), u6 (copy), u5 (copy)
    local v97 = {};

    for _, v in p96 do
        local v98 = v.Mod or "Unknown";
        local v99 = v.Song or "Unknown";
        local v100 = v.Diff or "Unknown";
        v97[v98] = v97[v98] or {};
        v97[v98][v99] = v97[v98][v99] or {};
        v97[v98][v99][v100] = v97[v98][v99][v100] or {};
        table.insert(v97[v98][v99][v100], v);
    end;

    local v101 = {};

    for i, v in v97 do
        local v102 = {};

        for i2, v2 in v do
            local v103 = {};

            for i3, v3 in v2 do
                local v104 = u2[i3] or safeEncode(i3);
                local v105 = {};

                for _, v4 in v3 do
                    table.insert(v105, encryptRunData(v4));
                end;

                local v106 = v104 .. ":" .. table.concat(v105, ";");
                table.insert(v103, v106);
            end;

            local v107 = safeEncode(i2) .. u6[1] .. table.concat(v103, ",") .. u6[2];
            table.insert(v102, v107);
        end;

        local v108 = safeEncode(i) .. u5[1] .. table.concat(v102, "") .. u5[2];
        table.insert(v101, v108);
    end;

    return table.concat(v101, "");
end;

local function decryptSessionBody(p109) -- Line: 435
    -- upvalues: u5 (copy), u6 (copy), u1 (copy), decryptRunData (copy)
    local v110 = {};

    for _, v in string.split(p109, u5[2]) do
        local string_find_ret = string.find(v, "%" .. u5[1]);

        if string_find_ret then
            local v111 = safeDecode((string.sub(v, 1, string_find_ret - 1)));
            local string_sub_ret = string.sub(v, string_find_ret + 1);

            for _, v2 in string.split(string_sub_ret, u6[2]) do
                local string_find_ret2 = string.find(v2, u6[1]);

                if string_find_ret2 then
                    local v112 = safeDecode((string.sub(v2, 1, string_find_ret2 - 1)));
                    local string_sub_ret2 = string.sub(v2, string_find_ret2 + 1);

                    for _, v3 in string.split(string_sub_ret2, ",") do
                        local string_find_ret3 = string.find(v3, ":");

                        if string_find_ret3 then
                            local string_sub_ret3 = string.sub(v3, 1, string_find_ret3 - 1);
                            local string_sub_ret4 = string.sub(v3, string_find_ret3 + 1);
                            local v113 = u1[tonumber(string_sub_ret3) or ""] or safeDecode(string_sub_ret3);

                            for _, v4 in string.split(string_sub_ret4, ";") do
                                local v114 = decryptRunData(v4);

                                if v114 then
                                    v114.Mod = v111;
                                    v114.Song = v112;
                                    v114.Diff = v113;
                                    table.insert(v110, v114);
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    table.sort(v110, function(p115, p116) -- Line: 473
        return (p115.Timestamp or 0) < (p116.Timestamp or 0);
    end);

    return v110;
end;

function encryptSession(p117)
    -- upvalues: encryptSessionBody (copy)
    local table_concat_ret = table.concat({ tostring(p117.StartTime or ""), (tostring(p117.EndTime or "")) }, "~");
    local v118 = encryptSessionBody(p117.Runs or {});

    return compress(table_concat_ret .. "|" .. v118);
end;

function decryptSession(p119)
    -- upvalues: decryptSessionBody (copy)
    local v120 = decompress(p119);
    local string_find_ret = string.find(v120, "|", 1, true);

    if not string_find_ret then
        return nil;
    end;

    local string_sub_ret = string.sub(v120, 1, string_find_ret - 1);
    local string_sub_ret2 = string.sub(v120, string_find_ret + 1);
    local string_split_ret = string.split(string_sub_ret, "~");

    return {
        StartTime = tonumber(string_split_ret[1]) or nil,
        EndTime = tonumber(string_split_ret[2]) or nil,
        Runs = decryptSessionBody(string_sub_ret2)
    };
end;

return {
    encript = encryptData,
    decrypt = decryptData,
    parseDiff = decryptDiffData,
    decryptDiff = decryptDiffData,
    encryptSession = encryptSession,
    decryptSession = decryptSession,
    compress = compress,
    decompress = decompress,

    songStatChange = function(p121: any, p122: any, p123: any, p124: any, p125: table) -- Line: 520, Name: songStatChange
        -- upvalues: u9 (copy), u10 (copy)
        p121[p122] = p121[p122] or {};
        local v126 = p121[p122];
        v126[p123] = v126[p123] or {};
        local v127 = v126[p123];
        local v128 = v127[p124] or {};
        local v129 = v128.Score or math.round(p125.Score);
        local math_round_ret = math.round(p125.Score);
        v128.Score = math.max(v129, math_round_ret);
        v128.Misses = math.min(v128.Misses or p125.Misses, p125.Misses);
        local v130 = v128.Accuracy or round(p125.Accuracy, 2);
        v128.Accuracy = math.max(v130, round(p125.Accuracy, 2));
        v128.FCData = u9[math.max(u10[p125.FCData or ""] or 0, u10[v128.FCData] or 0)];
        v128.PlayCount = (v128.PlayCount or 0) + 1;
        v128.Timestamp = os.time();
        v127[p124] = v128;

        if v128.FCData then
            v127.__AFNHFCData = u9[math.max(u10[v127.__AFNHFCData or ""] or 0, u10[v128.FCData] or 0)];
        end;
    end
};