-- Decompiled with Potassium's decompiler.

local script_Parent = script.Parent;
local Humanoid = script_Parent:WaitForChild("Humanoid");
local u1 = "Standing";

local function getRigScale() -- Line: 5
    -- upvalues: script_Parent (copy)
    return script_Parent:GetScale();
end;

local ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent");
local success, result = pcall(function() -- Line: 14
    return UserSettings():IsUserFeatureEnabled("UserAnimateRemoveEmoteChatHook");
end);
local u2 = "";
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = 1;
local u7 = nil;
local u8 = nil;
local u9 = {};
local u10 = {};
local u11 = {
    idle = { {
            id = "http://www.roblox.com/asset/?id=507766666",
            weight = 1
        }, {
            id = "http://www.roblox.com/asset/?id=507766951",
            weight = 1
        }, {
            id = "http://www.roblox.com/asset/?id=507766388",
            weight = 9
        } },
    walk = { {
            id = "http://www.roblox.com/asset/?id=507777826",
            weight = 10
        } },
    run = { {
            id = "http://www.roblox.com/asset/?id=507767714",
            weight = 10
        } },
    swim = { {
            id = "http://www.roblox.com/asset/?id=507784897",
            weight = 10
        } },
    swimidle = { {
            id = "http://www.roblox.com/asset/?id=507785072",
            weight = 10
        } },
    jump = { {
            id = "http://www.roblox.com/asset/?id=507765000",
            weight = 10
        } },
    fall = { {
            id = "http://www.roblox.com/asset/?id=507767968",
            weight = 10
        } },
    climb = { {
            id = "http://www.roblox.com/asset/?id=507765644",
            weight = 10
        } },
    sit = { {
            id = "http://www.roblox.com/asset/?id=2506281703",
            weight = 10
        } },
    toolnone = { {
            id = "http://www.roblox.com/asset/?id=507768375",
            weight = 10
        } },
    toolslash = { {
            id = "http://www.roblox.com/asset/?id=522635514",
            weight = 10
        } },
    toollunge = { {
            id = "http://www.roblox.com/asset/?id=522638767",
            weight = 10
        } },
    wave = { {
            id = "http://www.roblox.com/asset/?id=507770239",
            weight = 10
        } },
    point = { {
            id = "http://www.roblox.com/asset/?id=507770453",
            weight = 10
        } },
    dance = { {
            id = "http://www.roblox.com/asset/?id=507771019",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507771955",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507772104",
            weight = 10
        } },
    dance2 = { {
            id = "http://www.roblox.com/asset/?id=507776043",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507776720",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507776879",
            weight = 10
        } },
    dance3 = { {
            id = "http://www.roblox.com/asset/?id=507777268",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507777451",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507777623",
            weight = 10
        } },
    laugh = { {
            id = "http://www.roblox.com/asset/?id=507770818",
            weight = 10
        } },
    cheer = { {
            id = "http://www.roblox.com/asset/?id=507770677",
            weight = 10
        } }
};
local u12 = {
    wave = false,
    point = false,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
};
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local success2, result2 = pcall(function() -- Line: 122
    return UserSettings():IsUserFeatureEnabled("UserAnimationAbilityManagerFixed");
end);
local u18 = success2 and result2;

function resetManagerListeners()
    -- upvalues: u13 (ref), u14 (ref), u15 (ref)
    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;

    if u15 then
        u15:Disconnect();
        u15 = nil;
    end;
end;

function teardownManager()
    -- upvalues: u16 (ref), u17 (ref)
    resetManagerListeners();
    u16 = nil;
    u17 = nil;
end;

function processIfManagerBelongsToCharacter(u19: userdata)
    -- upvalues: script_Parent (copy), u17 (ref), u16 (ref), u13 (ref), u14 (ref), u15 (ref)
    if u19.RootPart ~= script_Parent.PrimaryPart then
        return false;
    end;

    if u17 ~= u19 then
        resetManagerListeners();
        u16 = u19.GroundSensor;
        u13 = u19:GetPropertyChangedSignal("GroundSensor"):Connect(function() -- Line: 159
            -- upvalues: u19 (copy), u13 (ref)
            if processIfManagerBelongsToCharacter(u19) then
                u13:Disconnect();
                u13 = nil;
            end;
        end);
        u14 = u19:GetPropertyChangedSignal("RootPart"):Connect(function() -- Line: 165
            -- upvalues: u19 (copy), u14 (ref)
            if processIfManagerBelongsToCharacter(u19) then
                u14:Disconnect();
                u14 = nil;
            end;
        end);
        u15 = u19.AncestryChanged:Connect(function(p20, p21) -- Line: 171
            if p21 == nil then
                resetManagerListeners();
                lookForControllerManager();
            end;
        end);
        u17 = u19;
    end;

    return true;
end;

function setupManager(u22: userdata)
    -- upvalues: u17 (ref), u16 (ref), u13 (ref), u14 (ref), script_Parent (copy), u15 (ref)
    u17 = u22;
    u16 = u22.GroundSensor;
    u13 = u22:GetPropertyChangedSignal("GroundSensor"):Connect(function() -- Line: 190
        -- upvalues: u16 (ref), u17 (ref)
        u16 = u17.GroundSensor;
    end);
    u14 = u22:GetPropertyChangedSignal("RootPart"):Connect(function() -- Line: 194
        -- upvalues: u22 (copy), script_Parent (ref)
        if u22.RootPart ~= script_Parent.PrimaryPart then
            teardownManager();
            lookForControllerManager();
        end;
    end);
    u15 = u22.AncestryChanged:Connect(function(p23, p24) -- Line: 201
        if p24 == nil then
            teardownManager();
            lookForControllerManager();
        end;
    end);
end;

function lookForControllerManager()
    -- upvalues: u18 (ref), script_Parent (copy), u16 (ref), u17 (ref)
    if u18 then
        local u25 = script_Parent:FindFirstChildOfClass("ControllerManager");

        if not u25 then
            local u26 = nil;
            u26 = script_Parent.ChildAdded:Connect(function(p27) -- Line: 230
                -- upvalues: u26 (ref)
                if p27:IsA("ControllerManager") then
                    u26:Disconnect();
                    lookForControllerManager();
                end;
            end);

            return;
        end;

        if u25.RootPart == script_Parent.PrimaryPart then
            setupManager(u25);

            return;
        end;

        local u28 = nil;
        u28 = u25:GetPropertyChangedSignal("RootPart"):Connect(function() -- Line: 221
            -- upvalues: u25 (copy), script_Parent (ref), u28 (ref)
            if u25.RootPart == script_Parent.PrimaryPart then
                u28:Disconnect();
                setupManager(u25);
            end;
        end);

        return;
    end;

    u16 = nil;
    u17 = nil;
    local v29 = script_Parent:FindFirstChildOfClass("ControllerManager");

    if v29 then
        processIfManagerBelongsToCharacter(v29);
    end;

    if u17 == nil then
        local u30 = nil;
        u30 = script_Parent.ChildAdded:Connect(function(p31) -- Line: 249
            -- upvalues: u30 (ref)
            if p31:IsA("ControllerManager") and processIfManagerBelongsToCharacter(p31) then
                u30:Disconnect();
                u30 = nil;
            end;
        end);
    end;
end;

lookForControllerManager();
math.randomseed(tick());

function findExistingAnimationInSet(p32, p33)
    if p32 == nil or p33 == nil then
        return 0;
    end;

    for i = 1, p32.count do
        if p32[i].anim.AnimationId == p33.AnimationId then
            return i;
        end;

        local _ = i;
    end;

    return 0;
end;

function configureAnimationSet(u34, u35)
    -- upvalues: u10 (copy), u9 (copy), Humanoid (copy)
    if u10[u34] ~= nil then
        for _, v in pairs(u10[u34].connections) do
            v:disconnect();
        end;
    end;

    u10[u34] = {};
    u10[u34].count = 0;
    u10[u34].totalWeight = 0;
    u10[u34].connections = {};
    local u36 = true;
    local success3, _ = pcall(function() -- Line: 291
        -- upvalues: u36 (ref)
        u36 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u36 = not success3 and true or u36;
    local v37 = script:FindFirstChild(u34);

    if u36 and v37 ~= nil then
        table.insert(u10[u34].connections, v37.ChildAdded:connect(function(p38) -- Line: 299
            -- upvalues: u34 (copy), u35 (copy)
            configureAnimationSet(u34, u35);
        end));
        table.insert(u10[u34].connections, v37.ChildRemoved:connect(function(p39) -- Line: 300
            -- upvalues: u34 (copy), u35 (copy)
            configureAnimationSet(u34, u35);
        end));

        for _, child in pairs(v37:GetChildren()) do
            if child:IsA("Animation") then
                local Weight = child:FindFirstChild("Weight");
                local v40 = Weight == nil and 1 or Weight.Value;
                u10[u34].count = u10[u34].count + 1;
                local count = u10[u34].count;
                u10[u34][count] = {};
                u10[u34][count].anim = child;
                u10[u34][count].weight = v40;
                u10[u34].totalWeight = u10[u34].totalWeight + u10[u34][count].weight;
                table.insert(u10[u34].connections, child.Changed:connect(function(p41) -- Line: 316
                    -- upvalues: u34 (copy), u35 (copy)
                    configureAnimationSet(u34, u35);
                end));
                table.insert(u10[u34].connections, child.ChildAdded:connect(function(p42) -- Line: 317
                    -- upvalues: u34 (copy), u35 (copy)
                    configureAnimationSet(u34, u35);
                end));
                table.insert(u10[u34].connections, child.ChildRemoved:connect(function(p43) -- Line: 318
                    -- upvalues: u34 (copy), u35 (copy)
                    configureAnimationSet(u34, u35);
                end));
            end;
        end;
    end;

    if u10[u34].count <= 0 then
        for i, v in pairs(u35) do
            u10[u34][i] = {};
            u10[u34][i].anim = Instance.new("Animation");
            u10[u34][i].anim.Name = u34;
            u10[u34][i].anim.AnimationId = v.id;
            u10[u34][i].weight = v.weight;
            u10[u34].count = u10[u34].count + 1;
            u10[u34].totalWeight = u10[u34].totalWeight + v.weight;
        end;
    end;

    for _, v in pairs(u10) do
        local v44 = v;

        for i = 1, v.count do
            local v45;

            if u9[v44[i].anim.AnimationId] == nil then
                Humanoid:LoadAnimation(v44[i].anim);
                u9[v44[i].anim.AnimationId] = true;
                v45 = i;
            else
                v45 = i;
            end;
        end;
    end;
end;

function configureAnimationSetOld(u46, u47)
    -- upvalues: u10 (copy), Humanoid (copy)
    if u10[u46] ~= nil then
        for _, v in pairs(u10[u46].connections) do
            v:disconnect();
        end;
    end;

    u10[u46] = {};
    u10[u46].count = 0;
    u10[u46].totalWeight = 0;
    u10[u46].connections = {};
    local u48 = true;
    local success3, _ = pcall(function() -- Line: 362
        -- upvalues: u48 (ref)
        u48 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u48 = not success3 and true or u48;
    local v49 = script:FindFirstChild(u46);

    if u48 and v49 ~= nil then
        table.insert(u10[u46].connections, v49.ChildAdded:connect(function(p50) -- Line: 370
            -- upvalues: u46 (copy), u47 (copy)
            configureAnimationSet(u46, u47);
        end));
        table.insert(u10[u46].connections, v49.ChildRemoved:connect(function(p51) -- Line: 371
            -- upvalues: u46 (copy), u47 (copy)
            configureAnimationSet(u46, u47);
        end));
        local v52 = 1;

        for _, child in pairs(v49:GetChildren()) do
            if child:IsA("Animation") then
                table.insert(u10[u46].connections, child.Changed:connect(function(p53) -- Line: 375
                    -- upvalues: u46 (copy), u47 (copy)
                    configureAnimationSet(u46, u47);
                end));
                u10[u46][v52] = {};
                u10[u46][v52].anim = child;
                local Weight = child:FindFirstChild("Weight");

                if Weight == nil then
                    u10[u46][v52].weight = 1;
                else
                    u10[u46][v52].weight = Weight.Value;
                end;

                u10[u46].count = u10[u46].count + 1;
                u10[u46].totalWeight = u10[u46].totalWeight + u10[u46][v52].weight;
                v52 = v52 + 1;
            end;
        end;
    end;

    if u10[u46].count <= 0 then
        for i, v in pairs(u47) do
            u10[u46][i] = {};
            u10[u46][i].anim = Instance.new("Animation");
            u10[u46][i].anim.Name = u46;
            u10[u46][i].anim.AnimationId = v.id;
            u10[u46][i].weight = v.weight;
            u10[u46].count = u10[u46].count + 1;
            u10[u46].totalWeight = u10[u46].totalWeight + v.weight;
        end;
    end;

    for _, v in pairs(u10) do
        local v54 = v;

        for i = 1, v.count do
            Humanoid:LoadAnimation(v54[i].anim);
            local _ = i;
        end;
    end;
end;

function scriptChildModified(p55)
    -- upvalues: u11 (copy)
    local v56 = u11[p55.Name];

    if v56 ~= nil then
        configureAnimationSet(p55.Name, v56);
    end;
end;

script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
local v57;

if Humanoid then
    v57 = Humanoid:FindFirstChildOfClass("Animator");
else
    v57 = nil;
end;

if v57 then
    local PlayingAnimationTracks = v57:GetPlayingAnimationTracks();

    for _, v in ipairs(PlayingAnimationTracks) do
        v:Stop(0);
        v:Destroy();
    end;
end;

for i, v in pairs(u11) do
    configureAnimationSet(i, v);
end;

local u58 = "None";
local u59 = 0;
local u60 = 0;
local u61 = false;

function stopAllAnimations()
    -- upvalues: u2 (ref), u12 (copy), u61 (ref), u3 (ref), u5 (ref), u4 (ref), u8 (ref), u7 (ref)
    local v62 = u2;
    local v63 = u12[v62] ~= nil and u12[v62] == false and "idle" or v62;

    if u61 then
        v63 = "idle";
        u61 = false;
    end;

    u2 = "";
    u3 = nil;

    if u5 ~= nil then
        u5:disconnect();
    end;

    if u4 ~= nil then
        u4:Stop();
        u4:Destroy();
        u4 = nil;
    end;

    if u8 ~= nil then
        u8:disconnect();
    end;

    if u7 ~= nil then
        u7:Stop();
        u7:Destroy();
        u7 = nil;
    end;

    return v63;
end;

function getHeightScale()
    -- upvalues: Humanoid (copy), getRigScale (copy), ScaleDampeningPercent (ref)
    if not Humanoid then
        return getRigScale();
    end;

    if not Humanoid.AutomaticScalingEnabled then
        return getRigScale();
    end;

    local v64 = Humanoid.HipHeight / 2;

    if ScaleDampeningPercent == nil then
        ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent");
    end;

    if ScaleDampeningPercent ~= nil then
        v64 = 1 + (Humanoid.HipHeight - 2) * ScaleDampeningPercent.Value / 2;
    end;

    return v64;
end;

local function rootMotionCompensation(p65) -- Line: 514
    return p65 * 1.25 / getHeightScale();
end;

local function setRunSpeed(p66) -- Line: 522
    -- upvalues: u4 (ref), u7 (ref)
    local v67 = p66 * 1.25 / getHeightScale();
    local v68 = 0.0001;
    local v69 = 0.0001;
    local v70 = 1;

    if v67 <= 0.5 then
        v70 = v67 / 0.5;
        v68 = 1;
    elseif v67 < 1 then
        v69 = (v67 - 0.5) / 0.5;
        v68 = 1 - v69;
    else
        v70 = v67 / 1;
        v69 = 1;
    end;

    u4:AdjustWeight(v68);
    u7:AdjustWeight(v69);
    u4:AdjustSpeed(v70);
    u7:AdjustSpeed(v70);
end;

function setAnimationSpeed(p71)
    -- upvalues: u2 (ref), setRunSpeed (copy), u6 (ref), u4 (ref)
    if u2 == "walk" then
        setRunSpeed(p71);

        return;
    end;

    if p71 ~= u6 then
        u6 = p71;
        u4:AdjustSpeed(u6);
    end;
end;

function keyFrameReachedFunc(p72)
    -- upvalues: u2 (ref), u7 (ref), u4 (ref), u12 (copy), u61 (ref), u6 (ref), Humanoid (copy)
    if p72 == "End" then
        if u2 == "walk" then
            if u7.Looped ~= true then
                u7.TimePosition = 0;
            end;

            if u4.Looped ~= true then
                u4.TimePosition = 0;
            end;
        else
            local v73 = u2;
            local v74 = u12[v73] ~= nil and u12[v73] == false and "idle" or v73;

            if u61 then
                if u4.Looped then
                    return;
                end;

                v74 = "idle";
                u61 = false;
            end;

            playAnimation(v74, 0.15, Humanoid);
            setAnimationSpeed(u6);
        end;
    end;
end;

function rollAnimation(p75)
    -- upvalues: u10 (copy)
    local math_random_ret = math.random(1, u10[p75].totalWeight);
    local v76 = 1;

    while u10[p75][v76].weight < math_random_ret do
        math_random_ret = math_random_ret - u10[p75][v76].weight;
        v76 = v76 + 1;
    end;

    return v76;
end;

local function switchToAnim(p77, p78, p79, p80) -- Line: 603
    -- upvalues: u3 (ref), u4 (ref), u7 (ref), u6 (ref), u2 (ref), u5 (ref), u10 (copy), u8 (ref)
    if p77 ~= u3 then
        if u4 ~= nil then
            u4:Stop(p79);
            u4:Destroy();
        end;

        if u7 ~= nil then
            u7:Stop(p79);
            u7:Destroy();
            u7 = nil;
        end;

        u6 = 1;
        u4 = p80:LoadAnimation(p77);
        u4.Priority = Enum.AnimationPriority.Core;
        u4:Play(p79);
        u2 = p78;
        u3 = p77;

        if u5 ~= nil then
            u5:disconnect();
        end;

        u5 = u4.KeyframeReached:connect(keyFrameReachedFunc);

        if p78 == "walk" then
            local v81 = rollAnimation("run");
            u7 = p80:LoadAnimation(u10.run[v81].anim);
            u7.Priority = Enum.AnimationPriority.Core;
            u7:Play(p79);

            if u8 ~= nil then
                u8:disconnect();
            end;

            u8 = u7.KeyframeReached:connect(keyFrameReachedFunc);
        end;
    end;
end;

function playAnimation(p82, p83, p84)
    -- upvalues: u10 (copy), switchToAnim (copy), u61 (ref)
    local v85 = rollAnimation(p82);
    switchToAnim(u10[p82][v85].anim, p82, p83, p84);
    u61 = false;
end;

function playEmote(p86, p87, p88)
    -- upvalues: switchToAnim (copy), u61 (ref)
    switchToAnim(p86, p86.Name, p87, p88);
    u61 = true;
end;

local u89 = "";
local u90 = nil;
local u91 = nil;
local u92 = nil;

function toolKeyFrameReachedFunc(p93)
    -- upvalues: u89 (ref), Humanoid (copy)
    if p93 == "End" then
        playToolAnimation(u89, 0, Humanoid);
    end;
end;

function playToolAnimation(p94, p95, p96, p97)
    -- upvalues: u10 (copy), u91 (ref), u90 (ref), u89 (ref), u92 (ref)
    local v98 = rollAnimation(p94);
    local anim = u10[p94][v98].anim;

    if u91 ~= anim then
        if u90 ~= nil then
            u90:Stop();
            u90:Destroy();
            p95 = 0;
        end;

        u90 = p96:LoadAnimation(anim);

        if p97 then
            u90.Priority = p97;
        end;

        u90:Play(p95);
        u89 = p94;
        u91 = anim;
        u92 = u90.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;

function stopToolAnimations()
    -- upvalues: u89 (ref), u92 (ref), u91 (ref), u90 (ref)
    local v99 = u89;

    if u92 ~= nil then
        u92:disconnect();
    end;

    u89 = "";
    u91 = nil;

    if u90 ~= nil then
        u90:Stop();
        u90:Destroy();
        u90 = nil;
    end;

    return v99;
end;

function onRunning(p100)
    -- upvalues: u16 (ref), Humanoid (copy), u17 (ref), u61 (ref), u1 (ref), u12 (copy), u2 (ref)
    local v101 = getHeightScale();

    if u16 ~= nil and Humanoid.EvaluateStateMachine == false then
        local RootPart = Humanoid.RootPart;
        local SensedPart = u16.SensedPart;

        if SensedPart then
            local VelocityAtPosition = SensedPart:GetVelocityAtPosition(u16.HitFrame.Position);
            local AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity;
            local Magnitude = Vector3.new(AssemblyLinearVelocity.X - VelocityAtPosition.X, 0, AssemblyLinearVelocity.Z - VelocityAtPosition.Z).Magnitude;
            local Magnitude2 = u17.MovingDirection.Magnitude;

            if Magnitude2 < 0.1 then
                Magnitude = 0;
                Magnitude2 = 0;
            elseif Magnitude2 > 1 then
                Magnitude2 = 1;
            end;

            p100 = Magnitude * Magnitude2;
        end;
    end;

    if (u61 and Humanoid.MoveDirection == Vector3.new(0, 0, 0) and (Humanoid.WalkSpeed / v101 or 0.75) or 0.75) * v101 >= p100 then
        if u12[u2] == nil and not u61 then
            playAnimation("idle", 0.2, Humanoid);
            u1 = "Standing";
        end;

        return;
    end;

    playAnimation("walk", 0.2, Humanoid);
    setAnimationSpeed(p100 / 16);
    u1 = "Running";
end;

function onDied()
    -- upvalues: u1 (ref)
    u1 = "Dead";
end;

function onJumping()
    -- upvalues: Humanoid (copy), u60 (ref), u1 (ref)
    playAnimation("jump", 0.1, Humanoid);
    u60 = 0.31;
    u1 = "Jumping";
end;

function onClimbing(p102)
    -- upvalues: Humanoid (copy), u1 (ref)
    local v103 = p102 / getHeightScale();
    playAnimation("climb", 0.1, Humanoid);
    setAnimationSpeed(v103 / 5);
    u1 = "Climbing";
end;

function onGettingUp()
    -- upvalues: u1 (ref)
    u1 = "GettingUp";
end;

function onFreeFall()
    -- upvalues: u60 (ref), Humanoid (copy), u1 (ref)
    if u60 <= 0 then
        playAnimation("fall", 0.2, Humanoid);
    end;

    u1 = "FreeFall";
end;

function onFallingDown()
    -- upvalues: u1 (ref)
    u1 = "FallingDown";
end;

function onSeated()
    -- upvalues: u1 (ref)
    u1 = "Seated";
end;

function onPlatformStanding()
    -- upvalues: u1 (ref)
    u1 = "PlatformStanding";
end;

function onSwimming(p104)
    -- upvalues: Humanoid (copy), u1 (ref)
    local v105 = p104 / getHeightScale();

    if v105 <= 1 then
        playAnimation("swimidle", 0.4, Humanoid);
        u1 = "Standing";

        return;
    end;

    playAnimation("swim", 0.4, Humanoid);
    setAnimationSpeed(v105 / 10);
    u1 = "Swimming";
end;

function animateTool()
    -- upvalues: u58 (ref), Humanoid (copy)
    if u58 == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle);

        return;
    end;

    if u58 == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action);

        return;
    end;

    if u58 ~= "Lunge" then
        return;
    end;

    playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action);
end;

function getToolAnim(p106)
    for _, child in ipairs(p106:GetChildren()) do
        if child.Name == "toolanim" and child.className == "StringValue" then
            return child;
        end;
    end;

    return nil;
end;

local u107 = 0;

function stepAnimate(p108)
    -- upvalues: u107 (ref), u60 (ref), u1 (ref), Humanoid (copy), script_Parent (copy), u58 (ref), u59 (ref), u91 (ref)
    local v109 = p108 - u107;
    u107 = p108;

    if u60 > 0 then
        u60 = u60 - v109;
    end;

    if u1 == "FreeFall" and u60 <= 0 then
        playAnimation("fall", 0.2, Humanoid);
    else
        if u1 == "Seated" then
            playAnimation("sit", 0.5, Humanoid);

            return;
        end;

        if u1 == "Running" then
            playAnimation("walk", 0.2, Humanoid);
        elseif u1 == "Dead" or (u1 == "GettingUp" or (u1 == "FallingDown" or (u1 == "Seated" or u1 == "PlatformStanding"))) then
            stopAllAnimations();
        end;
    end;

    local v110 = script_Parent:FindFirstChildOfClass("Tool");

    if v110 and v110:FindFirstChild("Handle") then
        local v111 = getToolAnim(v110);

        if v111 then
            u58 = v111.Value;
            v111.Parent = nil;
            u59 = p108 + 0.3;
        end;

        if u59 < p108 then
            u59 = 0;
            u58 = "None";
        end;

        animateTool();

        return;
    end;

    stopToolAnimations();
    u58 = "None";
    u91 = nil;
    u59 = 0;
end;

Humanoid.Died:connect(onDied);
Humanoid.Running:connect(onRunning);
Humanoid.Jumping:connect(onJumping);
Humanoid.Climbing:connect(onClimbing);
Humanoid.GettingUp:connect(onGettingUp);
Humanoid.FreeFalling:connect(onFreeFall);
Humanoid.FallingDown:connect(onFallingDown);
Humanoid.Seated:connect(onSeated);
Humanoid.PlatformStanding:connect(onPlatformStanding);
Humanoid.Swimming:connect(onSwimming);

if not (success and result) then
    game:GetService("Players").LocalPlayer.Chatted:connect(function(p112) -- Line: 924
        -- upvalues: u1 (ref), u12 (copy), Humanoid (copy)
        local v113 = "";

        if string.sub(p112, 1, 3) == "/e " then
            v113 = string.sub(p112, 4);
        elseif string.sub(p112, 1, 7) == "/emote " then
            v113 = string.sub(p112, 8);
        end;

        if u1 == "Standing" and u12[v113] ~= nil then
            playAnimation(v113, 0.1, Humanoid);
        end;
    end);
end;

script:WaitForChild("PlayEmote").OnInvoke = function(p114) -- Line: 939
    -- upvalues: u1 (ref), u12 (copy), Humanoid (copy), u4 (ref)
    if u1 == "Standing" then
        if u12[p114] ~= nil then
            playAnimation(p114, 0.1, Humanoid);

            return true, u4;
        end;

        if typeof(p114) ~= "Instance" or not p114:IsA("Animation") then
            return false;
        end;

        playEmote(p114, 0.1, Humanoid);

        return true, u4;
    end;
end;

if script_Parent.Parent ~= nil then
    playAnimation("idle", 0.1, Humanoid);
    u1 = "Standing";
end;

while script_Parent.Parent ~= nil do
    local _, v115 = wait(0.1);
    stepAnimate(v115);
end;