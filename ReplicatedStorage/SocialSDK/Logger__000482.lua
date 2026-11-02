-- Decompiled with Potassium's decompiler.

local v1 = {
    LogLevels = {
        ERROR = "ERROR",
        WARN = "WARN",
        INFO = "INFO",
        DEBUG = "DEBUG",
        TRACE = "TRACE"
    }
};
local u2 = {
    ERROR = 1,
    WARN = 2,
    INFO = 3,
    DEBUG = 4,
    TRACE = 5
};
local u3 = {
    enabled = true,
    logLevel = "WARN",
    defaultCategoryState = true,
    includeTimestamp = true,
    includeCategory = true,
    includeLevel = true,
    outputToConsole = true,
    customOutputFunction = nil,
    enabledCategories = {}
};

local function isCategoryEnabled(p4) -- Line: 40
    -- upvalues: u3 (copy)
    if u3.enabledCategories[p4] == nil then
        return u3.defaultCategoryState;
    end;

    return u3.enabledCategories[p4];
end;

local function shouldLog(p5, p6) -- Line: 47
    -- upvalues: u3 (copy), u2 (copy)
    if not u3.enabled then
        return false;
    end;

    local v7;

    if u3.enabledCategories[p5] == nil then
        v7 = u3.defaultCategoryState;
    else
        v7 = u3.enabledCategories[p5];
    end;

    if v7 then
        return (u2[u3.logLevel] or 3) >= (u2[p6] or 3);
    end;

    return false;
end;

local function formatMessage(p8, p9, p10, ...) -- Line: 60
    -- upvalues: u3 (copy)
    local v11 = {};

    if u3.includeTimestamp then
        table.insert(v11, string.format("[%s]", os.date("%Y-%m-%d %H:%M:%S")));
    end;

    if u3.includeLevel then
        table.insert(v11, string.format("[%s]", p8));
    end;

    if u3.includeCategory then
        table.insert(v11, string.format("[%s]", p9));
    end;

    table.insert(v11, string.format(p10, ...));

    return table.concat(v11, " ");
end;

local function outputMessage(p12, p13, p14) -- Line: 77
    -- upvalues: u3 (copy)
    if u3.customOutputFunction then
        u3.customOutputFunction(p12, p13, p14);

        return;
    end;

    if u3.outputToConsole then
        if p13 == "ERROR" or p13 == "WARN" then
            warn(p12);

            return;
        end;

        print(p12);
    end;
end;

function v1.error(p15, p16, ...) -- Line: 89
    -- upvalues: u3 (copy), u2 (copy), formatMessage (copy)
    local v17;

    if u3.enabled then
        local v18;

        if u3.enabledCategories[p15] == nil then
            v18 = u3.defaultCategoryState;
        else
            v18 = u3.enabledCategories[p15];
        end;

        if v18 then
            v17 = (u2[u3.logLevel] or u2.INFO) >= (u2.ERROR or u2.INFO);
        else
            v17 = false;
        end;
    else
        v17 = false;
    end;

    if v17 then
        local v19 = formatMessage("ERROR", p15, p16, ...);

        if u3.customOutputFunction then
            u3.customOutputFunction(v19, "ERROR", p15);

            return;
        end;

        if u3.outputToConsole then
            warn(v19);
        end;
    end;
end;

function v1.warn(p20, p21, ...) -- Line: 95
    -- upvalues: u3 (copy), u2 (copy), formatMessage (copy)
    local v22;

    if u3.enabled then
        local v23;

        if u3.enabledCategories[p20] == nil then
            v23 = u3.defaultCategoryState;
        else
            v23 = u3.enabledCategories[p20];
        end;

        if v23 then
            v22 = (u2[u3.logLevel] or u2.INFO) >= (u2.WARN or u2.INFO);
        else
            v22 = false;
        end;
    else
        v22 = false;
    end;

    if v22 then
        local v24 = formatMessage("WARN", p20, p21, ...);

        if u3.customOutputFunction then
            u3.customOutputFunction(v24, "WARN", p20);

            return;
        end;

        if u3.outputToConsole then
            warn(v24);
        end;
    end;
end;

function v1.info(p25, p26, ...) -- Line: 101
    -- upvalues: u3 (copy), u2 (copy), formatMessage (copy)
    local v27;

    if u3.enabled then
        local v28;

        if u3.enabledCategories[p25] == nil then
            v28 = u3.defaultCategoryState;
        else
            v28 = u3.enabledCategories[p25];
        end;

        if v28 then
            v27 = (u2[u3.logLevel] or u2.INFO) >= (u2.INFO or u2.INFO);
        else
            v27 = false;
        end;
    else
        v27 = false;
    end;

    if v27 then
        local v29 = formatMessage("INFO", p25, p26, ...);

        if u3.customOutputFunction then
            u3.customOutputFunction(v29, "INFO", p25);

            return;
        end;

        if u3.outputToConsole then
            print(v29);
        end;
    end;
end;

function v1.debug(p30, p31, ...) -- Line: 107
    -- upvalues: u3 (copy), u2 (copy), formatMessage (copy)
    local v32;

    if u3.enabled then
        local v33;

        if u3.enabledCategories[p30] == nil then
            v33 = u3.defaultCategoryState;
        else
            v33 = u3.enabledCategories[p30];
        end;

        if v33 then
            v32 = (u2[u3.logLevel] or u2.INFO) >= (u2.DEBUG or u2.INFO);
        else
            v32 = false;
        end;
    else
        v32 = false;
    end;

    if v32 then
        local v34 = formatMessage("DEBUG", p30, p31, ...);

        if u3.customOutputFunction then
            u3.customOutputFunction(v34, "DEBUG", p30);

            return;
        end;

        if u3.outputToConsole then
            print(v34);
        end;
    end;
end;

function v1.trace(p35, p36, ...) -- Line: 113
    -- upvalues: u3 (copy), u2 (copy), formatMessage (copy)
    local v37;

    if u3.enabled then
        local v38;

        if u3.enabledCategories[p35] == nil then
            v38 = u3.defaultCategoryState;
        else
            v38 = u3.enabledCategories[p35];
        end;

        if v38 then
            v37 = (u2[u3.logLevel] or u2.INFO) >= (u2.TRACE or u2.INFO);
        else
            v37 = false;
        end;
    else
        v37 = false;
    end;

    if v37 then
        local v39 = formatMessage("TRACE", p35, p36, ...);

        if u3.customOutputFunction then
            u3.customOutputFunction(v39, "TRACE", p35);

            return;
        end;

        if u3.outputToConsole then
            print(v39);
        end;
    end;
end;

function v1.setConfig(p40: table) -- Line: 119
    -- upvalues: u3 (copy), u2 (copy)
    if p40.enabled ~= nil then
        u3.enabled = p40.enabled;
    end;

    if p40.logLevel ~= nil then
        if u2[p40.logLevel] then
            u3.logLevel = p40.logLevel;
        else
            warn("Logger: Invalid log level:", p40.logLevel);
        end;
    end;

    if p40.defaultCategoryState ~= nil then
        u3.defaultCategoryState = p40.defaultCategoryState;
    end;

    if p40.enabledCategories then
        for i, v in pairs(p40.enabledCategories) do
            u3.enabledCategories[i] = v;
        end;
    end;

    if p40.outputToConsole ~= nil then
        u3.outputToConsole = p40.outputToConsole;
    end;

    if p40.customOutputFunction ~= nil then
        u3.customOutputFunction = p40.customOutputFunction;
    end;
end;

return v1;