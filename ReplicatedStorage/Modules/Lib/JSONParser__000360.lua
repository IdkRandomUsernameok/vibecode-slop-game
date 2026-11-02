-- Decompiled with Potassium's decompiler.

local v1 = {};
local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local Conductor = require(Modules.Modules.Conductor);
local Note = require(Modules.Modules.Note);

function v1.parse(u2) -- Line: 60
    -- upvalues: Conductor (copy), Note (copy)
    if typeof(u2) == "string" then
        local success, result = pcall(function() -- Line: 68
            -- upvalues: u2 (ref)
            return game:GetService("HttpService"):JSONDecode(u2);
        end);
        _ = success;
        u2 = result;
    end;

    if typeof(u2) ~= "table" then
        return warn("Non valid chart!");
    end;

    Conductor.init(u2.song.bpm);
    local v3 = u2.sliderVelocities or {};
    local v4 = u2.song.keys or (u2.song.keyCount or 4);
    local v5 = {};
    local v6 = {};

    for _, v in pairs(u2.song.notes) do
        local _ = v.lengthInSteps or 16;
        local v7;

        if v.events then
            v7 = v;

            for _, v2 in next, v.events do
                local v8 = tonumber(v2.time) or 0;

                for _, v9 in next, v2.events do
                    local v10 = v9.args or {};

                    if v9.name == "Scroll Velocity" then
                        if v10[1] == "mult" then
                            table.insert(v3, {
                                startTime = v8,
                                multiplier = v10[2]
                            });
                        elseif v10[1] == "constant" then
                            table.insert(v3, {
                                startTime = v8,
                                multiplier = v10[2] / u2.song.speed
                            });
                        end;
                    else
                        local v11 = {
                            v8,
                            { v9.name, table.unpack(v9.args or {}) }
                        };
                        table.insert(v5, v11);
                    end;
                end;
            end;
        else
            v7 = v;
        end;

        for _, v2 in pairs(v7.sectionNotes) do
            if #v6 % 200 == 0 then
                game:GetService("RunService").RenderStepped:Wait();
            end;

            local mustHitSection = v7.mustHitSection;

            if v4 <= v2[2] % (v4 * 2) then
                mustHitSection = not mustHitSection;
            end;

            local v12 = mustHitSection and "R" or "L";
            local v13 = Note.new(v2[1], v2[2] % v4, v6[#v6 - 1], false);
            v13.Side = v12;
            v13.zindex = v13.zindex + 1;
            local math_floor_ret = math.floor(v2[3] / Conductor.StepCrochet);
            table.insert(v6, v13);

            if math_floor_ret > 0 then
                local v14 = v2;

                for i = 0, math_floor_ret do
                    local v15 = v14[1] + Conductor.StepCrochet * i + Conductor.StepCrochet;
                    local v16 = v6[#v6 - 1];
                    local v17 = Note.new(v15, v14[2] % v4, v16, true, i == math_floor_ret);
                    v17.susEndTime = v15 + Conductor.StepCrochet;

                    if v16 then
                        v17.zindex = v16.zindex + 1;
                    end;

                    v17.Side = v12;
                    table.insert(v6, v17);
                    local _ = i;
                end;
            end;
        end;
    end;

    for i = 1, #(u2.song.events or {}) do
        local v18 = (u2.song.events or {}).events[i];
        local _ = v18[1];
        local _ = i;

        for _, v in pairs(v18[2] or {}) do
            table.insert(v5, {
                v18[1],
                { v[1], v[2], v[3] }
            });
        end;
    end;

    Conductor.mapBPMChanges(u2.song);

    return {
        notes = v6,
        events = v5,
        sliderVelocities = #v3 < 2 and { {
                startTime = 0,
                multiplier = 1
            } } or v3,
        songData = u2.song,
        keys = v4
    };
end;

return v1;