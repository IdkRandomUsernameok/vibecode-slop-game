-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local Modules = game:GetService("ReplicatedStorage").Modules;
local ChartFixing = require(Modules.Engine.VSRG.ChartFixing);
require("./Types");

return {
    convert = function(u1: any, u2: string?) -- Line: 12, Name: convert
        -- upvalues: HttpService (copy), ChartFixing (copy)
        if typeof(u1) == "Instance" and u1:IsA("ModuleScript") then
            u1 = require(u1);
        end;

        if type(u1) == "string" then
            local success, result = pcall(function() -- Line: 18
                -- upvalues: HttpService (ref), u1 (ref)
                return HttpService:JSONDecode(u1);
            end);

            if not success then
                return nil;
            end;

            u1 = result;
        end;

        if not u1 then
            return nil;
        end;

        local success, result = pcall(function() -- Line: 29
            -- upvalues: ChartFixing (ref), u1 (ref), u2 (copy)
            return ChartFixing.fixChart(u1, u2);
        end);

        if success and result then
            u1 = result;
        else
            warn("[ChartConverter] ChartFixing.fixChart failed, falling back to raw chart:", result);
        end;

        if type(u1) ~= "table" or not u1.song then
            return { {
                    keyCount = 4,
                    columnRoles = {},
                    notes = {},
                    svChanges = {}
                } };
        end;

        local song = u1.song;

        if type(u1.song) == "string" then
            song = u1;
        end;

        local v3 = tonumber(song.keys) or (tonumber(song.keyCount) or 4);
        local v4 = tonumber(song.playerKeyCount) or v3;
        local u5 = {};

        local function getChart(p6: number, p7: number) -- Line: 51
            -- upvalues: u5 (copy)
            if not u5[p6] then
                u5[p6] = {
                    keyCount = p7,
                    columnRoles = {},
                    notes = {},
                    svChanges = {}
                };
            end;

            return u5[p6];
        end;

        local v8, v9, v10, v11, v12, v13, v14, v15;

        if type(song.notes) ~= "table" then
            v8 = {};
            v9 = {};

            for i in pairs(u5) do
                table.insert(v8, i);
            end;

            table.sort(v8);

            for i, v in ipairs(v8) do
                v10 = u5[v];
                table.sort(v10.notes, function(p16, p17) -- Line: 116
                    if p16.time == p17.time then
                        return p16.column < p17.column;
                    end;

                    return p16.time < p17.time;
                end);
                v11 = {};
                v12 = {};

                for _, v2 in ipairs(v10.notes) do
                    v13 = v2.column;
                    v14 = v11[v13];

                    if not v14 or v2.time - v14 > 0.001 then
                        v11[v13] = v2.time;
                        table.insert(v12, v2);
                    end;
                end;

                v10.notes = v12;

                if #v10.notes > 0 then
                    v15 = v10.notes[1].time;

                    if v15 ~= 0 then
                        for _, v2 in ipairs(v10.notes) do
                            v2.time = v2.time - v15;
                        end;

                        for _, v2 in ipairs(v10.svChanges) do
                            v2.time = v2.time - v15;
                        end;
                    end;
                end;

                table.insert(v9, v10);
            end;

            return #v9 == 0 and { {
                    keyCount = 4,
                    columnRoles = {},
                    notes = {},
                    svChanges = {}
                } } or v9;
        end;

        for _, v in ipairs(song.notes) do
            if type(v.sectionNotes) == "table" then
                local mustHitSection = v.mustHitSection;

                for _, v2 in ipairs(v.sectionNotes) do
                    local v18 = tonumber(v2[1]) or 0;
                    local v19 = v2[2];
                    local v20 = tonumber(v2[3]) or 0;
                    local v21 = v2[4];

                    if type(v18) == "number" and (type(v19) == "number" and v19 >= 0) then
                        local v22, v23, v24;

                        if v19 < v3 then
                            v22 = v3;
                            v23 = 0;

                            if mustHitSection then
                                v23 = v23 == 0 and 1 or (v23 == 1 and 0 or v23);
                            end;

                            v24 = getChart(v23, v22 or 4).notes;
                            table.insert(v24, {
                                time = v18 / 1000,
                                column = v19 + 1,
                                holdLength = v20 / 1000,
                                noteType = v21
                            });
                        elseif v19 < v3 + v4 then
                            v19 = v19 - v3;
                            v22 = v4;
                            v23 = 1;

                            if mustHitSection then
                                v23 = v23 == 0 and 1 or (v23 == 1 and 0 or v23);
                            end;

                            v24 = getChart(v23, v22 or 4).notes;
                            table.insert(v24, {
                                time = v18 / 1000,
                                column = v19 + 1,
                                holdLength = v20 / 1000,
                                noteType = v21
                            });
                        end;
                    end;
                end;
            end;
        end;

        v8 = {};
        v9 = {};

        for i in pairs(u5) do
            table.insert(v8, i);
        end;

        table.sort(v8);

        for i, v in ipairs(v8) do
            v10 = u5[v];
            table.sort(v10.notes, function(p16, p17) -- Line: 116
                if p16.time == p17.time then
                    return p16.column < p17.column;
                end;

                return p16.time < p17.time;
            end);
            v11 = {};
            v12 = {};

            for _, v2 in ipairs(v10.notes) do
                v13 = v2.column;
                v14 = v11[v13];

                if not v14 or v2.time - v14 > 0.001 then
                    v11[v13] = v2.time;
                    table.insert(v12, v2);
                end;
            end;

            v10.notes = v12;

            if #v10.notes > 0 then
                v15 = v10.notes[1].time;

                if v15 ~= 0 then
                    for _, v2 in ipairs(v10.notes) do
                        v2.time = v2.time - v15;
                    end;

                    for _, v2 in ipairs(v10.svChanges) do
                        v2.time = v2.time - v15;
                    end;
                end;
            end;

            table.insert(v9, v10);
        end;

        return #v9 == 0 and { {
                keyCount = 4,
                columnRoles = {},
                notes = {},
                svChanges = {}
            } } or v9;
    end
};