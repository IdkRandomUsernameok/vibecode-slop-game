-- Decompiled with Potassium's decompiler.

local StarterGui = game:GetService("StarterGui");
local RunService = game:GetService("RunService");

return function(p1, ...) -- Line: 6
    -- upvalues: StarterGui (copy), RunService (copy)
    local v2 = {};

    for i = 1, 8 do
        v2 = { pcall(StarterGui[p1], StarterGui, ...) };

        if v2[1] then
            break;
        end;

        RunService.Stepped:Wait();
        local _ = i;
    end;

    return unpack(v2);
end;