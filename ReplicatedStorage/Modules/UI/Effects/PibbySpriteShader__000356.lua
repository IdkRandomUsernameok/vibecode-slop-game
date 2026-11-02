-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local NumberSequence_new_ret = NumberSequence.new(0);
local Vector2_new_ret = Vector2.new(0, 0);
local u2 = { 90, 180, 270, 360 };
local math_random = math.random;
local math_max = math.max;
local math_min = math.min;
local table_insert = table.insert;

local function setInvisibleInSections(p3) -- Line: 18
    -- upvalues: math_max (copy), table_insert (copy), math_min (copy)
    local v4 = { NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0) };

    for _, v in p3 do
        local v5 = v[1];
        local v6 = v[2];
        table_insert(v4, NumberSequenceKeypoint.new(math_max(0, v5 - 0.001), 0));
        table_insert(v4, NumberSequenceKeypoint.new(v5, 1));
        table_insert(v4, NumberSequenceKeypoint.new(v6, 1));
        table_insert(v4, NumberSequenceKeypoint.new(math_min(1, v6 + 0.001), 0));
    end;

    table.sort(v4, function(p7, p8) -- Line: 34
        return p7.Time < p8.Time;
    end);

    return NumberSequence.new(v4);
end;

local function setVisibleOnlyInSections(p9) -- Line: 38
    -- upvalues: math_max (copy), table_insert (copy), math_min (copy)
    local v10 = { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) };

    for _, v in p9 do
        local v11 = v[1];
        local v12 = v[2];
        table_insert(v10, NumberSequenceKeypoint.new(math_max(0, v11 - 0.001), 1));
        table_insert(v10, NumberSequenceKeypoint.new(v11, 0));
        table_insert(v10, NumberSequenceKeypoint.new(v12, 0));
        table_insert(v10, NumberSequenceKeypoint.new(math_min(1, v12 + 0.001), 1));
    end;

    table.sort(v10, function(p13, p14) -- Line: 54
        return p13.Time < p14.Time;
    end);

    return NumberSequence.new(v10);
end;

local function getOrCreateGradient(p15) -- Line: 58
    local Obj = p15.Obj;
    local PibbyGradient = Obj:FindFirstChild("PibbyGradient");

    if not PibbyGradient then
        PibbyGradient = Instance.new("UIGradient");
        PibbyGradient.Name = "PibbyGradient";
        PibbyGradient.Rotation = 90;
        PibbyGradient.Parent = Obj;
    end;

    return PibbyGradient;
end;

function u1.new() -- Line: 70
    -- upvalues: u1 (copy), math_random (copy), setInvisibleInSections (copy), setVisibleOnlyInSections (copy), table_insert (copy), RunService (copy)
    local u16 = setmetatable({}, u1);
    u16.targets = {};
    u16.t = 0;
    u16.randomSequences = {};
    u16.sliceSequences = {};

    for i = 1, 30 do
        local v17 = math_random(10, 70) / 100;
        local v18 = {
            { v17, v17 + math_random(5, 20) / 100 }
        };
        table_insert(u16.sliceSequences, { setInvisibleInSections(v18), setVisibleOnlyInSections(v18) });
        local _ = i;
    end;

    for i = 1, 2 do
        u16.randomSequences[i] = {};
        local v19 = i;

        for i2 = 1, 30 do
            local _ = i2;
            local v20 = {};

            for i3 = 1, v19 do
                local v21 = 1 / v19 * (math_random(40, 100) / 100);
                local v22 = math_random(1 / v19 * (i3 - 1) * 10000000, (1 / v19 * i3 - v21) * 10000000) / 10000000;
                table_insert(v20, { v22, v22 + v21 * (math_random(60, 100) / 100) });
                local _ = i3;
            end;

            local success, result = pcall(setInvisibleInSections, v20);

            if success and result then
                table_insert(u16.randomSequences[v19], result);
            end;
        end;
    end;

    u16._sliceCount = #u16.sliceSequences;
    u16._randomCounts = { #u16.randomSequences[1], #u16.randomSequences[2] };
    u16._renderConnection = RunService.RenderStepped:Connect(function(p23) -- Line: 115
        -- upvalues: u16 (copy)
        u16:Update(p23);
    end);

    return u16;
end;

function u1.AddTarget(p24, p25, p26) -- Line: 122
    if p24.targets[p25] then
        return;
    end;

    local v27 = p25:Copy();
    v27.visible = false;
    v27.Obj.BackgroundTransparency = 1;
    local targets = p24.targets;
    local v28 = {
        lastFrameWasPibby = false,
        enabled = p26 or false,
        ghost = v27
    };
    local Obj = p25.Obj;
    local PibbyGradient = Obj:FindFirstChild("PibbyGradient");

    if not PibbyGradient then
        PibbyGradient = Instance.new("UIGradient");
        PibbyGradient.Name = "PibbyGradient";
        PibbyGradient.Rotation = 90;
        PibbyGradient.Parent = Obj;
    end;

    v28.gradient = PibbyGradient;
    local Obj2 = v27.Obj;
    local PibbyGradient2 = Obj2:FindFirstChild("PibbyGradient");

    if not PibbyGradient2 then
        PibbyGradient2 = Instance.new("UIGradient");
        PibbyGradient2.Name = "PibbyGradient";
        PibbyGradient2.Rotation = 90;
        PibbyGradient2.Parent = Obj2;
    end;

    v28.ghostGradient = PibbyGradient2;
    targets[p25] = v28;
end;

function u1.RemoveTarget(p29, p30) -- Line: 139
    -- upvalues: NumberSequence_new_ret (copy)
    local v31 = p29.targets[p30];

    if v31 then
        if v31.ghost then
            v31.ghost:Destroy();
        end;

        if p30.alive and (v31.gradient and v31.gradient.Parent) then
            v31.gradient.Transparency = NumberSequence_new_ret;
        end;

        p29.targets[p30] = nil;
    end;
end;

function u1.SetEnabled(p32, p33, p34) -- Line: 152
    -- upvalues: NumberSequence_new_ret (copy), Vector2_new_ret (copy)
    local v35 = p32.targets[p33];

    if v35 then
        v35.ghost.Obj.BackgroundTransparency = 1;
        v35.enabled = p34;

        if not p34 then
            v35.gradient.Transparency = NumberSequence_new_ret;
            v35.ghostGradient.Transparency = NumberSequence_new_ret;
            v35.ghost.offsets.set("rectImageOffset", "pibbyingOut", Vector2_new_ret);
            v35.ghost.offsets.set("x", "sliceJitter", 0);
            v35.ghost.visible = false;
            v35.lastFrameWasPibby = false;
        end;
    end;
end;

function u1.Update(p36, p37) -- Line: 168
    -- upvalues: math_random (copy), u2 (copy), Vector2_new_ret (copy), NumberSequence_new_ret (copy)
    p36.t = p36.t + p37;

    if p36.t < 0.14 then
        return;
    end;

    p36.t = 0;
    local sliceSequences = p36.sliceSequences;
    local randomSequences = p36.randomSequences;

    for i, v in p36.targets do
        if i.alive then
            if v.enabled then
                local gradient = v.gradient;
                local ghostGradient = v.ghostGradient;
                local ghost = v.ghost;
                local v38 = math_random(1, 7);
                local v39 = math_random(1, 5);
                local _ = v38 == 2;
                gradient.Rotation = u2[math_random(1, 4)];
                ghostGradient.Rotation = u2[math_random(1, 4)];

                if v39 == 2 then
                    local v40 = sliceSequences[math_random(1, p36._sliceCount)];
                    gradient.Transparency = v40[1];
                    ghostGradient.Transparency = v40[2];
                    ghost.offsets.set("x", "sliceJitter", math_random(-30, 30));
                    ghost.offsets.set("rectImageOffset", "pibbyingOut", Vector2_new_ret);
                else
                    local v41 = math_random(1, 2);
                    gradient.Transparency = randomSequences[v41][math_random(1, p36._randomCounts[v41])];
                    local v42 = math_random(1, 2);
                    ghostGradient.Transparency = randomSequences[v42][math_random(1, p36._randomCounts[v42])];
                    ghost.offsets.set("x", "sliceJitter", 0);
                    ghost.offsets.set("rectImageOffset", "pibbyingOut", Vector2.new(math_random(-10, 10), math_random(-10, 10)));
                end;

                v.lastFrameWasPibby = true;
                ghost.visible = ghostGradient.Transparency ~= NumberSequence_new_ret;
            end;
        else
            p36:RemoveTarget(i);
        end;
    end;
end;

function u1.Destroy(p43) -- Line: 230
    if p43._renderConnection then
        p43._renderConnection:Disconnect();
        p43._renderConnection = nil;
    end;

    for i in p43.targets do
        p43:RemoveTarget(i);
    end;

    table.clear(p43.randomSequences);
    table.clear(p43.sliceSequences);
    setmetatable(p43, nil);
end;

return u1;