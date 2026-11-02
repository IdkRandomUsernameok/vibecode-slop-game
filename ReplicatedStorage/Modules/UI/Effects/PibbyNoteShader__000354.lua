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
local table_sort = table.sort;

local function setInvisibleInSections(p3) -- Line: 17
    -- upvalues: math_max (copy), table_insert (copy), math_min (copy), table_sort (copy)
    local v4 = { NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0) };

    for _, v in p3 do
        local v5 = v[1];
        local v6 = v[2];
        table_insert(v4, NumberSequenceKeypoint.new(math_max(0, v5 - 0.001), 0));
        table_insert(v4, NumberSequenceKeypoint.new(v5, 1));
        table_insert(v4, NumberSequenceKeypoint.new(v6, 1));
        table_insert(v4, NumberSequenceKeypoint.new(math_min(1, v6 + 0.001), 0));
    end;

    table_sort(v4, function(p7, p8) -- Line: 33
        return p7.Time < p8.Time;
    end);

    return NumberSequence.new(v4);
end;

local function createGradient(p9) -- Line: 40
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = 90;
    UIGradient.Parent = p9;

    return UIGradient;
end;

function u1.new(p10) -- Line: 47
    -- upvalues: u1 (copy), math_random (copy), table_insert (copy), setInvisibleInSections (copy), RunService (copy)
    local u11 = setmetatable({}, u1);
    u11.api = p10;
    u11.lStrums = p10.getStrumsBySide("L");
    u11.rStrums = p10.getStrumsBySide("R");
    u11.glitches = {
        L = false,
        R = false
    };
    u11.t = 0;
    u11.randomSequences = {};

    for i = 1, 2 do
        u11.randomSequences[i] = {};
        local v12 = i;

        for i2 = 1, 30 do
            local _ = i2;
            local v13 = {};

            for i3 = 1, v12 do
                local v14 = 1 / v12 * (math_random(40, 100) / 100);
                local v15 = math_random(1 / v12 * (i3 - 1) * 10000000, (1 / v12 * i3 - v14) * 10000000) / 10000000;
                table_insert(v13, { v15, v15 + v14 * (math_random(60, 100) / 100) });
                local _ = i3;
            end;

            local success, result = pcall(setInvisibleInSections, v13);

            if success and result then
                table_insert(u11.randomSequences[v12], result);
            end;
        end;
    end;

    u11._randomCounts = { #u11.randomSequences[1], #u11.randomSequences[2] };
    u11._renderConnection = RunService.RenderStepped:Connect(function(p16) -- Line: 89
        -- upvalues: u11 (copy)
        u11:Update(p16);
    end);

    return u11;
end;

function u1._processStrumline(p17, p18, p19) -- Line: 96
    -- upvalues: u2 (copy), math_random (copy), NumberSequence_new_ret (copy), Vector2_new_ret (copy)
    if not p18 then
        return;
    end;

    local randomSequences = p17.randomSequences;
    local _randomCounts = p17._randomCounts;

    for _, v in p18 do
        local v20 = v.copies and v.copies[1];

        if not v20 then
            v20 = v:Copy();
            local Obj = v20.Obj;
            local UIGradient = Instance.new("UIGradient");
            UIGradient.Rotation = 90;
            UIGradient.Parent = Obj;
            v20.gradientObj = UIGradient;
        end;

        local gradientObj = v.gradientObj;

        if not gradientObj then
            local Obj = v.Obj;
            gradientObj = Instance.new("UIGradient");
            gradientObj.Rotation = 90;
            gradientObj.Parent = Obj;
            v.gradientObj = gradientObj;
        end;

        local v21 = v20.gradientObj or gradientObj;

        if p19 then
            gradientObj.Rotation = u2[math_random(1, 4)];
            v21.Rotation = u2[math_random(1, 4)];
            local v22 = v.curAnim == "confirm";
            local v23 = v22 and math_random(1, 2) or math_random(1, 7);

            if (v22 and math_random(1, 2) or math_random(1, 4)) == 2 then
                v20.offsets.set("rectImageOffset", "pibbyingOut", Vector2.new(math_random(-10, 10), math_random(-10, 10)));
            end;

            if v23 == 2 then
                local v24 = math_random(1, 2);
                gradientObj.Transparency = randomSequences[v24][math_random(1, _randomCounts[v24])];
                local v25 = math_random(1, 2);
                v21.Transparency = randomSequences[v25][math_random(1, _randomCounts[v25])];
                v.lastFrameWasPibby = true;
            elseif not v22 then
                if v.lastFrameWasPibby then
                    gradientObj.Transparency = NumberSequence_new_ret;
                    v21.Transparency = NumberSequence_new_ret;
                    v20.offsets.set("rectImageOffset", "pibbyingOut", Vector2_new_ret);
                end;

                v.lastFrameWasPibby = false;
            end;
        elseif v.lastFrameWasPibby or gradientObj.Transparency ~= NumberSequence_new_ret then
            gradientObj.Transparency = NumberSequence_new_ret;
            v21.Transparency = NumberSequence_new_ret;
            v20.offsets.set("rectImageOffset", "pibbyingOut", Vector2_new_ret);
            v.lastFrameWasPibby = false;
        end;

        v20.visible = gradientObj.Transparency ~= NumberSequence_new_ret;
    end;
end;

function u1.Update(p26, p27) -- Line: 162
    p26.t = p26.t + p27;

    if p26.t < 0.0333 then
        return;
    end;

    p26.t = 0;
    p26:_processStrumline(p26.lStrums, p26.glitches.L);
    p26:_processStrumline(p26.rStrums, p26.glitches.R);
end;

function u1.Toggle(p28, p29, p30) -- Line: 171
    if p28.glitches[p29] == nil then
        warn("Invalid side provided to Toggle. Use \"L\" or \"R\".");

        return;
    end;

    p28.glitches[p29] = p30;
end;

function u1.Destroy(p31) -- Line: 179
    if p31._renderConnection then
        p31._renderConnection:Disconnect();
        p31._renderConnection = nil;
    end;

    p31.lStrums = nil;
    p31.rStrums = nil;
    p31.api = nil;
    table.clear(p31.randomSequences);
    p31.randomSequences = nil;
    p31._randomCounts = nil;
    setmetatable(p31, nil);
end;

return u1;