-- Decompiled with Potassium's decompiler.

require("./Types");
local u1 = require("./Utils");
local u2 = require("./Config");
local u3 = require("./WindowAnalyzer");
local u4 = require("./Aggregator");
local l_require = require;
local u5 = {};

for _, child in script.Parent.Skillsets:GetChildren() do
    if child:IsA("ModuleScript") and string.sub(child.Name, 1, 1) ~= "_" then
        u5[child.Name] = l_require(child);
    end;
end;

local u6 = require("./ChartConverter");
local v7 = {};

local function calculateSingle(p8) -- Line: 30
    -- upvalues: u3 (copy), u5 (copy), u1 (copy), u2 (copy), u4 (copy)
    if type(p8) ~= "table" or not (p8.notes and (#p8.notes ~= 0 and p8.keyCount)) then
        return {
            overall = 0,
            skillsets = {}
        };
    end;

    local v9 = u3.prepass(p8);
    local v10 = {};

    for i, v in u5 do
        v10[i] = u1.formatValue(v.calculate(p8, v9) ^ u2.VALUE_EXPONENT);
    end;

    return {
        overall = u1.formatValue(u4.compute(v10)),
        skillsets = v10
    };
end;

local function chartsMatch(p11, p12) -- Line: 51
    if p11.keyCount ~= p12.keyCount then
        return false;
    end;

    if #p11.notes ~= #p12.notes then
        return false;
    end;

    for i = 1, #p11.notes do
        local v13 = p11.notes[i];
        local v14 = p12.notes[i];

        if v13.time ~= v14.time or (v13.column ~= v14.column or v13.holdLength ~= v14.holdLength) then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

function v7.calculate(p15: any, p16: string?) -- Line: 65
    -- upvalues: u6 (copy), calculateSingle (copy), chartsMatch (copy)
    local v17 = u6.convert(p15, p16);

    if not v17 then
        return {
            overall = 0,
            skillsets = {}
        };
    end;

    if #v17 == 1 then
        return calculateSingle(v17[1]);
    end;

    local v18 = v17[1];
    local v19 = true;

    for i = 2, #v17 do
        if not chartsMatch(v18, v17[i]) then
            v19 = false;
            break;
        end;

        local _ = i;
    end;

    if v19 then
        return calculateSingle(v18);
    end;

    local v20 = {};

    for i, v in ipairs(v17) do
        v20[i] = calculateSingle(v);
    end;

    return v20;
end;

return v7;