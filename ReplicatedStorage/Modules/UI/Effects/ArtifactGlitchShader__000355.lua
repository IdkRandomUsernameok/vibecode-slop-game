-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local RunService = game:GetService("RunService");
local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local Signal = require(Modules.Lib.Signal);
local VarTweener = require(Modules.Main.VarTweener);
local UDim2_fromScale = UDim2.fromScale;
local UDim2_fromOffset = UDim2.fromOffset;
local math_clamp = math.clamp;
local math_random = math.random;
local math_floor = math.floor;
local math_cos = math.cos;
local math_sin = math.sin;
local math_max = math.max;
local math_ceil = math.ceil;
local os_clock = os.clock;
local Vector2_new = Vector2.new;
local table_remove = table.remove;
local table_insert = table.insert;
local table_clear = table.clear;

function u1.new(p2) -- Line: 22
    -- upvalues: UDim2_fromScale (copy), u1 (copy), RunService (copy), os_clock (copy), math_max (copy), math_clamp (copy), math_floor (copy), math_random (copy), Signal (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "GlitchContainer";
    Frame.Size = UDim2_fromScale(1, 1);
    Frame.Position = UDim2_fromScale(0, 0);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ClipsDescendants = true;
    Frame.ZIndex = 1;
    Frame.Parent = p2.parent;
    local v3 = {
        _lastSpawn = 0,
        _poolCount = 0,
        _isBursting = false,
        parent = p2.parent,
        container = Frame,
        enabled = p2.enabled or false,
        type = p2.type or "Squares",
        frequency = p2.frequency or 1,
        squareColorRange = p2.squareColorRange or { Color3.new(1, 1, 1) },
        huxColorRange = p2.huxColorRange or { Color3.new(1, 1, 1) },
        radiusSettings = p2.radiusSettings or {
            enabled = false,
            ignoreRadius = 1,
            isSquare = false
        }
    };
    local v4;

    if p2.independentSquares == nil then
        v4 = false;
    else
        v4 = p2.independentSquares;
    end;

    v3.independentSquares = v4;
    local v5;

    if p2.varyingZIndex == nil then
        v5 = false;
    else
        v5 = p2.varyingZIndex;
    end;

    v3.varyingZIndex = v5;
    v3.mainSizeRange = p2.mainSizeRange or NumberRange.new(15, 40);
    v3.subSizeRange = p2.subSizeRange or NumberRange.new(0.1, 0.6);
    v3.lifetimeRange = p2.lifetimeRange or NumberRange.new(0.05, 0.15);
    v3.teleportSpeed = p2.teleportSpeed or 0;
    v3.teleportRadius = p2.teleportRadius or 0.02;
    v3._pool = {};
    v3._activeFrames = {};
    v3._lastEnabled = p2.enabled or false;
    v3._originalTeleportSpeed = p2.teleportSpeed or 0;
    local u6 = setmetatable(v3, u1);
    u6.type = u6.type:lower();
    u6._connection = RunService.RenderStepped:Connect(function() -- Line: 68
        -- upvalues: os_clock (ref), u6 (copy), math_max (ref), math_clamp (ref), math_floor (ref), math_random (ref), UDim2_fromScale (ref)
        local v7 = os_clock();
        local enabled = u6.enabled;

        if enabled or not u6._lastEnabled then
            if enabled and not u6._lastEnabled then
                u6._lastEnabled = true;
            end;
        else
            u6._lastEnabled = false;

            for _, v in u6._activeFrames do
                v.fadeStart = v7;
                v.fadeDuration = 0.3;
                v.expiresAt = math_max(v.expiresAt, v7 + 0.3);
            end;
        end;

        if enabled and 1 / math_clamp(u6.frequency * 100, 0.01, 1000) <= v7 - u6._lastSpawn then
            u6._lastSpawn = v7;
            u6:_spawnGlitch(u6._isBursting and "both" or u6.type);
        end;

        local teleportSpeed = u6.teleportSpeed;
        local v8 = teleportSpeed > 0;
        local v9;

        if v8 then
            v9 = math_floor(v7 * teleportSpeed) % 2 == 0;
        else
            v9 = v8;
        end;

        local v10 = u6.teleportRadius * 2;

        for i, v in u6._activeFrames do
            if v.expiresAt <= v7 then
                u6:_returnToPool(i);
            else
                if v.fadeStart then
                    i.BackgroundTransparency = math_clamp((v7 - v.fadeStart) / v.fadeDuration, 0, 1);
                end;

                if v8 then
                    local v11 = (math_random() - 0.5) * v10;
                    local v12 = (math_random() - 0.5) * v10;
                    local origin = v.origin;
                    i.Position = v9 and UDim2_fromScale(math_clamp(origin.X.Scale + v11, 0, 1), (math_clamp(origin.Y.Scale + v12, 0, 1))) or UDim2_fromScale(math_clamp(origin.X.Scale - v11, 0, 1), (math_clamp(origin.Y.Scale - v12, 0, 1)));
                end;
            end;
        end;
    end);
    u6.BurstEnded = Signal.new();

    return u6;
end;

function u1.Burst(u13, p14, p15) -- Line: 121
    -- upvalues: os_clock (copy), math_max (copy), VarTweener (copy)
    local v16 = os_clock();

    for _, v in u13._activeFrames do
        v.fadeStart = v16;
        v.fadeDuration = 0.3;
        v.expiresAt = math_max(v.expiresAt, v16 + 0.3);
    end;

    u13._isBursting = true;

    if u13._burstTween then
        u13._burstTween:Cancel();
    end;

    u13.teleportSpeed = u13._originalTeleportSpeed * (p14 or 10);
    u13._burstTween = VarTweener:Create(u13, {
        Time = p15 or 0.5,
        EasingStyle = Enum.EasingStyle.Quart,
        EasingDirection = Enum.EasingDirection.Out
    }, {
        teleportSpeed = u13._originalTeleportSpeed
    });
    u13._burstTween.Completed:Connect(function() -- Line: 146
        -- upvalues: u13 (copy)
        u13.BurstEnded:Fire();
        u13._isBursting = false;
    end);
    u13._burstTween:Play();
end;

function u1._cleanPool(p17) -- Line: 154
    -- upvalues: table_remove (copy)
    local _poolCount = p17._poolCount;

    if _poolCount > 50 then
        for i = _poolCount, 25, -1 do
            local v18 = table_remove(p17._pool, i);
            local v19;

            if v18 then
                v18:Destroy();
                v19 = i;
            else
                v19 = i;
            end;
        end;

        p17._poolCount = 24;
    end;
end;

function u1._getFromPool(p20) -- Line: 165
    -- upvalues: table_remove (copy), Vector2_new (copy)
    local _poolCount = p20._poolCount;

    if _poolCount > 0 then
        local v21 = table_remove(p20._pool, _poolCount);
        p20._poolCount = _poolCount - 1;

        return v21;
    end;

    local Frame = Instance.new("Frame");
    Frame.BorderSizePixel = 0;
    Frame.AnchorPoint = Vector2_new(0.5, 0.5);

    return Frame;
end;

function u1._returnToPool(p22, p23) -- Line: 179
    -- upvalues: table_insert (copy)
    p23.Visible = false;
    p22._activeFrames[p23] = nil;
    local v24 = p22._poolCount + 1;
    p22._poolCount = v24;
    table_insert(p22._pool, v24, p23);
end;

function u1._createFrame(p25, p26, p27, p28) -- Line: 187
    -- upvalues: math_random (copy), math_ceil (copy), math_floor (copy), math_max (copy), os_clock (copy)
    local v29 = p25:_getFromPool();

    if p25.varyingZIndex then
        local v30 = p25:_getMedianZIndex();
        v29.ZIndex = math_max(1, math_random() > 0.5 and math_ceil(v30 + 5) or math_floor(v30 - 5));
    end;

    v29.Size = p26;
    v29.Position = p27;
    v29.BackgroundColor3 = p28;
    v29.BackgroundTransparency = 0;
    v29.Visible = true;
    v29.Parent = p25.container;
    local Min = p25.lifetimeRange.Min;
    local Max = p25.lifetimeRange.Max;
    local v31 = Min + math_random() * (Max - Min);
    local v32 = os_clock();
    local v33 = {
        origin = p27,
        expiresAt = v32 + v31
    };

    if p25._isBursting then
        v33.fadeStart = v32;
        v33.fadeDuration = v31;
    end;

    p25._activeFrames[v29] = v33;

    return v29;
end;

function u1._spawnGlitch(p34, p35) -- Line: 219
    -- upvalues: math_clamp (copy), math_random (copy), math_cos (copy), math_sin (copy), UDim2_fromOffset (copy), UDim2_fromScale (copy)
    local radiusSettings = p34.radiusSettings;
    local v36, v37;

    if radiusSettings.enabled then
        local v38 = math_clamp(radiusSettings.ignoreRadius, 0, 1) * 0.5;

        if radiusSettings.isSquare then
            local v39 = math_random(1, 4);

            if v39 == 1 then
                v36 = math_random();
                v37 = math_random() * (0.5 - v38);
            elseif v39 == 2 then
                v36 = math_random();
                v37 = v38 + 0.5 + math_random() * (0.5 - v38);
            elseif v39 == 3 then
                v36 = math_random() * (0.5 - v38);
                v37 = math_random();
            else
                v36 = v38 + 0.5 + math_random() * (0.5 - v38);
                v37 = math_random();
            end;
        else
            local v40 = math_random() * 6.283185307179586;
            local v41 = v38 + math_random() * (0.5 - v38);
            v36 = 0.5 + math_cos(v40) * v41;
            v37 = 0.5 + math_sin(v40) * v41;
        end;
    else
        v36 = math_random();
        v37 = math_random();
    end;

    local v42 = math_clamp(v36, 0, 1);
    local v43 = math_clamp(v37, 0, 1);

    if p35 == "squares" or p35 == "both" then
        local squareColorRange = p34.squareColorRange;
        local v44 = squareColorRange[math_random(1, #squareColorRange)];
        local Min = p34.mainSizeRange.Min;
        local Max = p34.mainSizeRange.Max;
        local v45 = Min + math_random() * (Max - Min);
        p34:_createFrame(UDim2_fromOffset(v45, v45), UDim2_fromScale(v42, v43), v44);
        local Min2 = p34.subSizeRange.Min;
        local Max2 = p34.subSizeRange.Max;

        for i = 1, math_random(3, 6) do
            local v46 = v45 * (Min2 + math_random() * (Max2 - Min2));
            local v47 = (math_random() - 0.5) * 0.04;
            local v48 = (math_random() - 0.5) * 0.04;
            p34:_createFrame(UDim2_fromOffset(v46, v46), UDim2_fromScale(math_clamp(v42 + v47, 0, 1), (math_clamp(v43 + v48, 0, 1))), v44);
            local _ = i;
        end;
    end;

    if p35 == "hux" or p35 == "both" then
        local huxColorRange = p34.huxColorRange;
        local v49 = huxColorRange[math_random(1, #huxColorRange)];

        for i = 1, math_random(3, 6) do
            p34:_createFrame(UDim2_fromOffset(100 + math_random() * 300, (math_random(1, 2))), UDim2_fromScale(v42, (math_clamp(v43 + (i - 1) * 0.003, 0, 1))), v49);
            local _ = i;
        end;
    end;
end;

function u1.Destroy(p50) -- Line: 286
    -- upvalues: table_clear (copy)
    p50.enabled = false;

    if p50.BurstEnded then
        p50.BurstEnded:Destroy();
    end;

    if p50._burstTween then
        p50._burstTween:Cancel();
    end;

    if p50._connection then
        p50._connection:Disconnect();
    end;

    if p50.container then
        p50.container:Destroy();
    end;

    for i, _ in p50._activeFrames do
        i:Destroy();
    end;

    for _, v in p50._pool do
        v:Destroy();
    end;

    table_clear(p50._activeFrames);
    table_clear(p50._pool);
    setmetatable(p50, nil);
end;

return u1;