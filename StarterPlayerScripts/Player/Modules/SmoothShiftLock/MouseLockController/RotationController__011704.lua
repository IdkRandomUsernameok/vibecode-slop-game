-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Utils = script.Parent:WaitForChild("Utils");
local Maid = require(Utils:WaitForChild("Maid"));
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 21
    -- upvalues: u1 (copy), Maid (copy)
    local v2 = setmetatable({}, u1);
    v2._rotationMaid = Maid.new();
    v2.IsRotate = false;

    return v2;
end;

function u1.Destroy(p3) -- Line: 33
    -- upvalues: u1 (copy)
    u1.SetRotate(p3, false);
end;

function u1._updateRotateState(p4) -- Line: 38
    -- upvalues: u1 (copy), RunService (copy)
    p4._rotationMaid:DoCleaning();

    if not p4.IsRotate then
        return;
    end;

    local RotationSource = u1.GetRotationSource(p4);

    if not RotationSource then
        return;
    end;

    local RotationTarget = u1.GetRotationTarget(p4);

    if not RotationTarget then
        return;
    end;

    local u8 = p4.RotationBehaviourCallback or function(p5, p6, p7) -- Line: 50
        return p6;
    end;
    local Rotation = RotationTarget:GetPivot().Rotation;
    p4._rotationMaid:GiveTask(RunService.RenderStepped:Connect(function(p9) -- Line: 58
        -- upvalues: RotationSource (copy), RotationTarget (copy), u8 (copy), Rotation (ref)
        if not RotationSource.Parent then
            return;
        end;

        if not RotationTarget.Parent then
            return;
        end;

        local CFrame_new_ret = CFrame.new(RotationTarget:GetPivot().Position);
        local _, v10, _ = RotationSource:GetPivot():ToOrientation();
        local v11 = u8(CFrame_new_ret * Rotation, CFrame_new_ret * CFrame.Angles(0, v10, 0), p9);
        Rotation = v11.Rotation;
        RotationTarget:PivotTo(v11);
    end));
end;

function u1.SetRotationSource(p12: any, p13: userdata) -- Line: 74
    -- upvalues: u1 (copy)
    local v14;

    if typeof(p13) == "Instance" then
        v14 = p13:IsA("PVInstance");
    else
        v14 = false;
    end;

    assert(v14, "Rotation source must be a PVInstance");
    p12.RotationSource = p13;
    u1._updateRotateState(p12);
end;

function u1.GetRotationSource(p15) -- Line: 81
    return p15.RotationSource;
end;

function u1.SetRotationTarget(p16: any, p17: userdata) -- Line: 85
    -- upvalues: u1 (copy)
    local v18;

    if typeof(p17) == "Instance" then
        v18 = p17:IsA("PVInstance");
    else
        v18 = false;
    end;

    assert(v18, "Rotation target must be a PVInstance");
    p16.RotationTarget = p17;
    u1._updateRotateState(p16);
end;

function u1.GetRotationTarget(p19) -- Line: 92
    return p19.RotationTarget;
end;

function u1.SetRotationBehaviour(p20: any, p21: function) -- Line: 96
    -- upvalues: u1 (copy)
    local v22 = typeof(p21) == "function";
    assert(v22, "Rotation behaviour callback must be a function");
    p20.RotationBehaviourCallback = p21;
    u1._updateRotateState(p20);
end;

function u1.SetRotate(p23: any, p24: boolean) -- Line: 104
    -- upvalues: u1 (copy)
    if p23.IsRotate == p24 then
        return;
    end;

    p23.IsRotate = p24;
    u1._updateRotateState(p23);
end;

return u1;