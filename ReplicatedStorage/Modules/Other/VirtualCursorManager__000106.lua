-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local GuiService = game:GetService("GuiService");
local GamepadService = game:GetService("GamepadService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DeviceManager = require(ReplicatedStorage.Modules.Main.DeviceManager);
local u2 = setmetatable({}, {
    __mode = "k"
});

function u1.new() -- Line: 12
    -- upvalues: u1 (copy)
    return setmetatable({
        enabled = false
    }, u1);
end;

function u1.Enable(p3: table, p4: userdata?) -- Line: 19
    -- upvalues: u2 (copy), GamepadService (copy)
    u2[p3] = true;
    p3.enabled = true;
    GamepadService:EnableGamepadCursor(p4 or nil);
end;

function u1.Disable(p5) -- Line: 26
    -- upvalues: u2 (copy), GamepadService (copy)
    u2[p5] = nil;
    p5.enabled = false;

    if not next(u2) then
        GamepadService:DisableGamepadCursor();
    end;
end;

function u1.IsEnabled(p6) -- Line: 35
    -- upvalues: u2 (copy)
    return next(u2) and true or false;
end;

local function updateCursorState() -- Line: 39
    -- upvalues: u1 (copy), DeviceManager (copy), GamepadService (copy)
    if not u1:IsEnabled() then
        GamepadService:DisableGamepadCursor();

        return;
    end;

    if DeviceManager.currentDevice ~= "Console" then
        GamepadService:DisableGamepadCursor();

        return;
    end;

    if GamepadService.GamepadCursorEnabled then
        return;
    end;

    GamepadService:EnableGamepadCursor(nil);
end;

DeviceManager.deviceChanged:Connect(updateCursorState);
GuiService.MenuClosed:Connect(updateCursorState);

return u1;