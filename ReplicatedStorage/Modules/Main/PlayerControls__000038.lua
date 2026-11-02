-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
game:GetService("Players");
local u1 = {};

if RunService:IsServer() then
    return u1;
end;

u1.controlsEnabled = true;

function u1.Disable(p2) -- Line: 12
    -- upvalues: u1 (copy)
    if not u1.controlsEnabled then
        return;
    end;

    u1.controlsEnabled = false;
end;

function u1.Enable(p3) -- Line: 20
    -- upvalues: u1 (copy)
    if u1.controlsEnabled then
        return;
    end;

    u1.controlsEnabled = true;
end;

return u1;