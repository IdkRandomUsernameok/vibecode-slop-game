-- Decompiled with Potassium's decompiler.

local v1 = {};
local Vector2_zero = Vector2.zero;
local u2 = {};

local function AddPosV2(p3, p4) -- Line: 19
    local X = p3.X;
    local Y = p3.Y;

    return UDim2.new(X.Scale, X.Offset + p4.X, Y.Scale, Y.Offset + p4.Y);
end;

local function isIdle(p5) -- Line: 29
    -- upvalues: Vector2_zero (copy)
    local v6;

    if math.abs(p5.Velocity.X) < 0.001 then
        v6 = math.abs(p5.Velocity.Y) < 0.001;
    else
        v6 = false;
    end;

    local v7 = p5.Acceleration == Vector2_zero;
    local v8 = math.abs(p5.AngularVelocity) < 0.001;

    if v6 then
        if not v7 then
            v8 = v7;
        end;
    else
        v8 = v6;
    end;

    return v8;
end;

function v1.ComputeVelocity(p9: table, p10: number, p11: number, p12: number, p13: number, p14: number) -- Line: 36
    if p11 == 0 then
        if p12 ~= 0 then
            local v15 = p12 * p14;

            if p10 - v15 > 0 then
                p10 = p10 - v15;
            else
                p10 = p10 + v15 >= 0 and 0 or p10 + v15;
            end;
        end;
    else
        p10 = p10 + p11 * p14;
    end;

    if p13 ~= 0 and p10 ~= 0 then
        p10 = math.clamp(p10, -p13, p13);
    end;

    return p10;
end;

function v1.GetTracked(p16) -- Line: 55
    -- upvalues: u2 (copy)
    return u2;
end;

function v1.Add(u17: table, u18: userdata, p19: table?) -- Line: 59
    -- upvalues: u2 (copy), Vector2_zero (copy)
    local v20 = u2[u18];

    if v20 then
        if p19 then
            for i, v in p19 do
                v20[i] = v;
            end;
        end;

        local v21;

        if math.abs(v20.Velocity.X) < 0.001 then
            v21 = math.abs(v20.Velocity.Y) < 0.001;
        else
            v21 = false;
        end;

        local v22 = v20.Acceleration == Vector2_zero;
        local v23 = math.abs(v20.AngularVelocity) < 0.001;

        if v21 then
            if not v22 then
                v23 = v22;
            end;
        else
            v23 = v21;
        end;

        if v23 then
            u17:Remove(u18);
        end;

        return;
    end;

    local u24 = p19 or {};

    local function resolve(p25: string, p26: any) -- Line: 77
        -- upvalues: u24 (ref), u18 (copy)
        if u24[p25] ~= nil then
            return u24[p25];
        end;

        local Attribute = u18:GetAttribute(p25);

        if Attribute == nil then
            return p26;
        end;

        return Attribute;
    end;

    local v27;

    if u24.Drag == nil then
        local Attribute = u18:GetAttribute("Drag");
        v27 = Attribute == nil and 0 or Attribute;
    else
        v27 = u24.Drag;
    end;

    local v28 = typeof(v27);
    local v29 = v28 == "Vector2" and v27 and v27 or (v28 == "number" and Vector2.new(v27, v27) or Vector2_zero);
    local v30 = {
        connection = nil
    };
    local v31 = Vector2_zero;

    if u24.Velocity == nil then
        local Attribute = u18:GetAttribute("Velocity");

        if Attribute ~= nil then
            v31 = Attribute;
        end;
    else
        v31 = u24.Velocity;
    end;

    v30.Velocity = v31;
    local v32 = Vector2_zero;

    if u24.MaxVelocity == nil then
        local Attribute = u18:GetAttribute("MaxVelocity");

        if Attribute ~= nil then
            v32 = Attribute;
        end;
    else
        v32 = u24.MaxVelocity;
    end;

    v30.MaxVelocity = v32;
    local v33 = Vector2_zero;

    if u24.Acceleration == nil then
        local Attribute = u18:GetAttribute("Acceleration");

        if Attribute ~= nil then
            v33 = Attribute;
        end;
    else
        v33 = u24.Acceleration;
    end;

    v30.Acceleration = v33;
    v30.Drag = v29;
    local v34;

    if u24.AngularVelocity == nil then
        local Attribute = u18:GetAttribute("AngularVelocity");
        v34 = Attribute == nil and 0 or Attribute;
    else
        v34 = u24.AngularVelocity;
    end;

    v30.AngularVelocity = v34;
    local v35 = Vector2_zero;

    if u24.Offset == nil then
        local Attribute = u18:GetAttribute("Offset");

        if Attribute ~= nil then
            v35 = Attribute;
        end;
    else
        v35 = u24.Offset;
    end;

    v30.Offset = v35;
    local v36;

    if u24.AngleOffset == nil then
        local Attribute = u18:GetAttribute("AngleOffset");
        v36 = Attribute == nil and 0 or Attribute;
    else
        v36 = u24.AngleOffset;
    end;

    v30.AngleOffset = v36;
    local Position = u18.Position;

    if u24.Origin == nil then
        local Attribute = u18:GetAttribute("Origin");

        if Attribute ~= nil then
            Position = Attribute;
        end;
    else
        Position = u24.Origin;
    end;

    v30.Origin = Position;
    local Rotation = u18.Rotation;

    if u24.AngleOrigin == nil then
        local Attribute = u18:GetAttribute("AngleOrigin");

        if Attribute ~= nil then
            Rotation = Attribute;
        end;
    else
        Rotation = u24.AngleOrigin;
    end;

    v30.AngleOrigin = Rotation;
    local v37;

    if math.abs(v30.Velocity.X) < 0.001 then
        v37 = math.abs(v30.Velocity.Y) < 0.001;
    else
        v37 = false;
    end;

    local v38 = v30.Acceleration == Vector2_zero;
    local v39 = math.abs(v30.AngularVelocity) < 0.001;

    if v37 then
        if not v38 then
            v39 = v38;
        end;
    else
        v39 = v37;
    end;

    if v39 then
        return;
    end;

    v30.connection = u18.Destroying:Connect(function() -- Line: 113
        -- upvalues: u17 (copy), u18 (copy)
        u17:Remove(u18);
    end);
    u2[u18] = v30;
end;

function v1.Remove(p40: table, p41: userdata) -- Line: 120
    -- upvalues: u2 (copy)
    local v42 = u2[p41];

    if not v42 then
        return;
    end;

    if v42.connection then
        v42.connection:Disconnect();
        v42.connection = nil;
    end;

    u2[p41] = nil;
end;

function v1.Clear(p43) -- Line: 132
    -- upvalues: u2 (copy)
    for _, v in u2 do
        if v.connection then
            v.connection:Disconnect();
            v.connection = nil;
        end;
    end;

    table.clear(u2);
end;

function v1.GetMotion(p44: table, p45: any, p46: number) -- Line: 142
    local Velocity = p45.Velocity;
    local MaxVelocity = p45.MaxVelocity;
    local Acceleration = p45.Acceleration;
    local AngularVelocity = p45.AngularVelocity;
    local Drag = p45.Drag;
    local v47 = p44:ComputeVelocity(Velocity.X, Acceleration.X, Drag.X, MaxVelocity.X, p46);
    local v48 = p44:ComputeVelocity(Velocity.Y, Acceleration.Y, Drag.Y, MaxVelocity.Y, p46);
    local v49 = p44:ComputeVelocity(AngularVelocity, 0, 0, 10000, p46);
    local v50 = Vector2.new(0.5 * (Velocity.X + v47), 0.5 * (Velocity.Y + v48)) * p46;
    p45.Velocity = Vector2.new(v47, v48);
    p45.AngularVelocity = v49;

    return v50, 0.5 * (AngularVelocity + v49) * p46;
end;

function v1.UpdateMotion(p51: table, p52: userdata, p53: any, p54: number) -- Line: 162
    -- upvalues: Vector2_zero (copy)
    local v55;

    if math.abs(p53.Velocity.X) < 0.001 then
        v55 = math.abs(p53.Velocity.Y) < 0.001;
    else
        v55 = false;
    end;

    local v56 = p53.Acceleration == Vector2_zero;
    local v57 = math.abs(p53.AngularVelocity) < 0.001;

    if v55 then
        if not v56 then
            v57 = v56;
        end;
    else
        v57 = v55;
    end;

    if v57 then
        return false;
    end;

    local Motion, v58 = p51:GetMotion(p53, p54);
    p53.Offset = p53.Offset + Motion;
    p53.AngleOffset = p53.AngleOffset + v58;
    local Origin = p53.Origin;
    local Offset = p53.Offset;
    local X = Origin.X;
    local Y = Origin.Y;
    p52.Position = UDim2.new(X.Scale, X.Offset + Offset.X, Y.Scale, Y.Offset + Offset.Y);
    p52.Rotation = p53.AngleOrigin + p53.AngleOffset;

    return true;
end;

function v1.Update(p59: table, p60: number) -- Line: 179
    -- upvalues: u2 (copy)
    for i, v in u2 do
        if i.Parent then
            if not p59:UpdateMotion(i, v, p60) then
                p59:Remove(i);
            end;
        else
            p59:Remove(i);
        end;
    end;
end;

return v1;