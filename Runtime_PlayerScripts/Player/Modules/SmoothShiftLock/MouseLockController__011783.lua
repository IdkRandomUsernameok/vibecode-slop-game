-- Decompiled with Potassium's decompiler.

local Utils = script:WaitForChild("Utils");
local Maid = require(Utils:WaitForChild("Maid"));
local PriorityState = require(Utils:WaitForChild("PriorityState"));
local Signal = require(Utils:WaitForChild("Signal"));
local RotationController = require(script:WaitForChild("RotationController"));
local u1 = {
    _maid = Maid.new(),
    EnabledChanged = Signal.new(),
    ActiveChanged = Signal.new(),
    EnabledState = PriorityState.new(),
    ActiveState = PriorityState.new(),
    RotationController = RotationController.new(),
    IsEnabled = false,
    IsActive = false
};

function u1.Start(p2) -- Line: 42
    -- upvalues: u1 (copy), Maid (copy)
    if u1._started then
        warn("[MouseLockController]: Is already started");

        return;
    end;

    u1._started = true;
    u1.IsMouseLocked = false;
    local u3 = Maid.new();
    local u4 = Maid.new();

    local function setActiveState(p5) -- Line: 58
        -- upvalues: u1 (ref), u3 (copy)
        local v6 = p5.Active or false;

        if v6 == u1.IsActive then
            return;
        end;

        u3:DoCleaning();
        u1.IsActive = v6;
        u1.ActiveChanged:Fire(v6, u3);
    end;

    local function setEnabledState(p7) -- Line: 70
        -- upvalues: u1 (ref), u4 (copy), u3 (copy)
        local v8 = p7.Enabled or false;

        if v8 == u1.IsEnabled then
            return;
        end;

        u4:DoCleaning();

        if v8 then
            local v9 = u1.ActiveState:Get().Active or false;

            if v9 ~= u1.IsActive then
                u3:DoCleaning();
                u1.IsActive = v9;
                u1.ActiveChanged:Fire(v9, u3);
            end;

            u4:GiveTask(u1.ActiveState.Changed:Connect(function(p10) -- Line: 83
                -- upvalues: u1 (ref), u3 (ref)
                local v11 = p10.Active or false;

                if v11 == u1.IsActive then
                    return;
                end;

                u3:DoCleaning();
                u1.IsActive = v11;
                u1.ActiveChanged:Fire(v11, u3);
            end));
            u4:GiveTask(function() -- Line: 87
                -- upvalues: u1 (ref), u3 (ref)
                local v12 = ({}).Active or false;

                if v12 == u1.IsActive then
                    return;
                end;

                u3:DoCleaning();
                u1.IsActive = v12;
                u1.ActiveChanged:Fire(v12, u3);
            end);
        end;

        u1.IsEnabled = v8;
        u1.EnabledChanged:Fire(v8, u4);
    end;

    setEnabledState(u1.EnabledState:Get());
    u1._maid:GiveTask(u1.EnabledState.Changed:Connect(function(p13) -- Line: 101
        -- upvalues: setEnabledState (copy)
        setEnabledState(p13);
    end));
    u1._maid:GiveTask(function() -- Line: 105
        -- upvalues: u1 (ref)
        u1.ActiveState:Clear();
        u1.EnabledState:Clear();
    end);
end;

function u1.Stop(p14) -- Line: 111
    -- upvalues: u1 (copy)
    u1._maid:Destroy();
    u1._started = false;
end;

function u1.Enable(p15) -- Line: 117
    -- upvalues: u1 (copy)
    u1.EnabledState:Set("MouseLock", {
        Priority = 1,
        Enabled = true
    });
end;

function u1.Disable(p16) -- Line: 124
    -- upvalues: u1 (copy)
    u1.EnabledState:Set("MouseLockDisabled", {
        Priority = 1,
        Enabled = false
    });
end;

function u1.MouseLock(p17, p18) -- Line: 131
    -- upvalues: u1 (copy)
    if type(p18) ~= "boolean" then
        p18 = not u1.IsMouseLocked;
    end;

    if u1.IsMouseLocked == p18 then
        return;
    end;

    u1.IsMouseLocked = p18;

    if p18 then
        u1.ActiveState:Set("MouseLock", {
            Priority = 1,
            Active = true
        });

        return;
    end;

    u1.ActiveState:Remove("MouseLock");
end;

return u1;