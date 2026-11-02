-- Decompiled with Potassium's decompiler.

local v1 = {};
local script_OffsetFixing = require(script.OffsetFixing);
local script_CameraFixing = require(script.CameraFixing);
local u2 = {
    ModernDNB = require(script.ModernDNB),
    HoloFunk = require(script.HoloFunk),
    Codename = require(script.Codename),
    BaseGame = require(script.BaseGame),
    ModernCF = require(script.ModernCF),
    ModernPsych = require(script.ModernPsych),
    NightmareVisionV2 = require(script.NightmareVisionV2),
    EventRenaming = require(script.EventRenamer)
};

function autoFixChart(u3, u4)
    -- upvalues: u2 (copy)
    for _, v in ipairs(u2) do
        if type(v.fixChart) == "function" then
            local success, result = pcall(function() -- Line: 26
                -- upvalues: v (copy), u3 (ref), u4 (copy)
                return v.fixChart(u3, u4);
            end);

            if success == true then
                u3 = result;
            else
                warn("[ChartFixing] Failed to parse chart from the format \"" .. v.FormatName .. "\" to the readable format");
            end;
        end;
    end;

    return u3;
end;

function v1.fixChart(u5, u6) -- Line: 40
    -- upvalues: u2 (copy), script_CameraFixing (copy), script_OffsetFixing (copy)
    for _, v in u2 do
        local success, result = pcall(function() -- Line: 45
            -- upvalues: v (copy), u5 (ref), u6 (copy)
            return v.fixChart(u5, u6);
        end);

        if success == true then
            u5 = result;
        else
            warn("[ChartFixing] Failed to parse chart from the format \"" .. v.FormatName .. "\" to the readable format\nError:", result);
        end;
    end;

    local v7 = script_CameraFixing.fixChart(u5, u6);
    local u8 = script_OffsetFixing.fixChart(v7, u6);
    pcall(function() -- Line: 58
        -- upvalues: u8 (ref)
        if u8 and u8.notes then
            u8 = {
                song = u8
            };
        end;
    end);

    return u8;
end;

function v1.fixEvents(p9) -- Line: 67
    -- upvalues: u2 (copy)
    local v10 = u2.ModernCF.fixEvents(p9);

    return u2.Codename.fixEvents(v10);
end;

return v1;