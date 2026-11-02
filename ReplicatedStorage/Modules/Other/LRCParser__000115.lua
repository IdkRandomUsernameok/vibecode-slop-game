-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TimeFunctions = require(ReplicatedStorage.Modules.Other.TimeFunctions);
local Adapters = require(ReplicatedStorage.Modules.Other.Adapters);
local u1 = {};

local function parseTimestamp(p2) -- Line: 7
    local v3, v4 = p2:match("(%d+):([%d%.]+)");

    if v3 and v4 then
        return tonumber(v3) * 60 + tonumber(v4);
    end;

    return nil;
end;

local function calculateTimeout(p5, p6) -- Line: 15
    local v7 = p6[p5 + 1];

    return not v7 and 3 or v7.Timestamp - p6[p5].Timestamp - 0.5;
end;

function u1.ParseLRCToBaseTable(p8: string) -- Line: 26
    if not p8 or p8 == "" then
        return nil;
    end;

    local v9 = {};

    for i in p8:gmatch("[^\r\n]+") do
        local v10, v11 = i:match("%[(.-)%](.*)");

        if v10 and v11 then
            local v12, v13 = v10:match("(%d+):([%d%.]+)");
            local v14;

            if v12 and v13 then
                v14 = tonumber(v12) * 60 + tonumber(v13);
            else
                v14 = nil;
            end;

            if v14 then
                local v15 = {
                    Timestamp = v14,
                    Lyric = v11:gsub("^%s+", "")
                };
                table.insert(v9, v15);
            end;
        end;
    end;

    return v9;
end;

function u1.ParseLRCToTableTimeout(p16: string) -- Line: 49
    -- upvalues: u1 (copy)
    local v17 = u1.ParseLRCToBaseTable(p16);

    if not v17 then
        return nil;
    end;

    for i = 1, #v17 do
        local v18 = v17[i + 1];
        v17[i].Timeout = not v18 and 3 or v18.Timestamp - v17[i].Timestamp - 0.5;
        local _ = i;
    end;

    return v17;
end;

function u1.ParseLRCToTableStep(p19: string) -- Line: 60
    -- upvalues: u1 (copy), TimeFunctions (copy), Adapters (copy)
    local v20 = u1.ParseLRCToBaseTable(p19);

    if not v20 then
        return nil;
    end;

    local table_create_ret = table.create(#v20);

    for i = 1, #v20 do
        local v21 = v20[i];
        local v22 = {};
        local StepFromTime = TimeFunctions.getStepFromTime(Adapters.SecondsToMilliseconds(v21.Timestamp));
        v22.Step = math.floor(StepFromTime);
        v22.Timestamp = v21.Timestamp;
        v22.Lyric = v21.Lyric;
        local v23 = v20[i + 1];
        v22.Timeout = not v23 and 3 or v23.Timestamp - v20[i].Timestamp - 0.5;
        table.insert(table_create_ret, v22);
        local _ = i;
    end;

    return table_create_ret;
end;

return u1;