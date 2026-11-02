-- Decompiled with Potassium's decompiler.

local script_Parent = script.Parent;
local Humanoid = script_Parent:WaitForChild("Humanoid");
local u1 = "Standing";
local success, result = pcall(function() -- Line: 7
    return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop");
end);
local u2 = success and result;
local success2, result2 = pcall(function() -- Line: 10
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun");
end);
local u3 = success2 and result2;

local function getRigScale() -- Line: 13
    -- upvalues: u3 (copy), script_Parent (copy)
    return not u3 and 1 or script_Parent:GetScale();
end;

local ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent");
local u4 = "";
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = 1;
local u9 = nil;
local u10 = nil;
local u11 = {};
local u12 = {};
local u13 = {
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
local u14 = {
    wave = false,
    point = false,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
};
math.randomseed(tick());

function findExistingAnimationInSet(p15, p16)
    if p15 == nil or p16 == nil then
        return 0;
    end;

    for i = 1, p15.count do
        if p15[i].anim.AnimationId == p16.AnimationId then
            return i;
        end;

        local _ = i;
    end;

    return 0;
end;

function configureAnimationSet(u17, u18)
    -- upvalues: u12 (copy), u11 (copy), Humanoid (copy)
    if u12[u17] ~= nil then
        for _, v in pairs(u12[u17].connections) do
            v:disconnect();
        end;
    end;

    u12[u17] = {};
    u12[u17].count = 0;
    u12[u17].totalWeight = 0;
    u12[u17].connections = {};
    local u19 = true;
    local success3, _ = pcall(function() -- Line: 138
        -- upvalues: u19 (ref)
        u19 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u19 = not success3 and true or u19;
    local v20 = script:FindFirstChild(u17);

    if u19 and v20 ~= nil then
        table.insert(u12[u17].connections, v20.ChildAdded:connect(function(p21) -- Line: 146
            -- upvalues: u17 (copy), u18 (copy)
            configureAnimationSet(u17, u18);
        end));
        table.insert(u12[u17].connections, v20.ChildRemoved:connect(function(p22) -- Line: 147
            -- upvalues: u17 (copy), u18 (copy)
            configureAnimationSet(u17, u18);
        end));

        for _, child in pairs(v20:GetChildren()) do
            if child:IsA("Animation") then
                local Weight = child:FindFirstChild("Weight");
                local v23 = Weight == nil and 1 or Weight.Value;
                u12[u17].count = u12[u17].count + 1;
                local count = u12[u17].count;
                u12[u17][count] = {};
                u12[u17][count].anim = child;
                u12[u17][count].weight = v23;
                u12[u17].totalWeight = u12[u17].totalWeight + u12[u17][count].weight;
                table.insert(u12[u17].connections, child.Changed:connect(function(p24) -- Line: 163
                    -- upvalues: u17 (copy), u18 (copy)
                    configureAnimationSet(u17, u18);
                end));
                table.insert(u12[u17].connections, child.ChildAdded:connect(function(p25) -- Line: 164
                    -- upvalues: u17 (copy), u18 (copy)
                    configureAnimationSet(u17, u18);
                end));
                table.insert(u12[u17].connections, child.ChildRemoved:connect(function(p26) -- Line: 165
                    -- upvalues: u17 (copy), u18 (copy)
                    configureAnimationSet(u17, u18);
                end));
            end;
        end;
    end;

    if u12[u17].count <= 0 then
        for i, v in pairs(u18) do
            u12[u17][i] = {};
            u12[u17][i].anim = Instance.new("Animation");
            u12[u17][i].anim.Name = u17;
            u12[u17][i].anim.AnimationId = v.id;
            u12[u17][i].weight = v.weight;
            u12[u17].count = u12[u17].count + 1;
            u12[u17].totalWeight = u12[u17].totalWeight + v.weight;
        end;
    end;

    for _, v in pairs(u12) do
        local v27 = v;

        for i = 1, v.count do
            local v28;

            if u11[v27[i].anim.AnimationId] == nil then
                Humanoid:LoadAnimation(v27[i].anim);
                u11[v27[i].anim.AnimationId] = true;
                v28 = i;
            else
                v28 = i;
            end;
        end;
    end;
end;

function configureAnimationSetOld(u29, u30)
    -- upvalues: u12 (copy), Humanoid (copy)
    if u12[u29] ~= nil then
        for _, v in pairs(u12[u29].connections) do
            v:disconnect();
        end;
    end;

    u12[u29] = {};
    u12[u29].count = 0;
    u12[u29].totalWeight = 0;
    u12[u29].connections = {};
    local u31 = true;
    local success3, _ = pcall(function() -- Line: 209
        -- upvalues: u31 (ref)
        u31 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u31 = not success3 and true or u31;
    local v32 = script:FindFirstChild(u29);

    if u31 and v32 ~= nil then
        table.insert(u12[u29].connections, v32.ChildAdded:connect(function(p33) -- Line: 217
            -- upvalues: u29 (copy), u30 (copy)
            configureAnimationSet(u29, u30);
        end));
        table.insert(u12[u29].connections, v32.ChildRemoved:connect(function(p34) -- Line: 218
            -- upvalues: u29 (copy), u30 (copy)
            configureAnimationSet(u29, u30);
        end));
        local v35 = 1;

        for _, child in pairs(v32:GetChildren()) do
            if child:IsA("Animation") then
                table.insert(u12[u29].connections, child.Changed:connect(function(p36) -- Line: 222
                    -- upvalues: u29 (copy), u30 (copy)
                    configureAnimationSet(u29, u30);
                end));
                u12[u29][v35] = {};
                u12[u29][v35].anim = child;
                local Weight = child:FindFirstChild("Weight");

                if Weight == nil then
                    u12[u29][v35].weight = 1;
                else
                    u12[u29][v35].weight = Weight.Value;
                end;

                u12[u29].count = u12[u29].count + 1;
                u12[u29].totalWeight = u12[u29].totalWeight + u12[u29][v35].weight;
                v35 = v35 + 1;
            end;
        end;
    end;

    if u12[u29].count <= 0 then
        for i, v in pairs(u30) do
            u12[u29][i] = {};
            u12[u29][i].anim = Instance.new("Animation");
            u12[u29][i].anim.Name = u29;
            u12[u29][i].anim.AnimationId = v.id;
            u12[u29][i].weight = v.weight;
            u12[u29].count = u12[u29].count + 1;
            u12[u29].totalWeight = u12[u29].totalWeight + v.weight;
        end;
    end;

    for _, v in pairs(u12) do
        local v37 = v;

        for i = 1, v.count do
            Humanoid:LoadAnimation(v37[i].anim);
            local _ = i;
        end;
    end;
end;

function scriptChildModified(p38)
    -- upvalues: u13 (copy)
    local v39 = u13[p38.Name];

    if v39 ~= nil then
        configureAnimationSet(p38.Name, v39);
    end;
end;

script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
local v40;

if Humanoid then
    v40 = Humanoid:FindFirstChildOfClass("Animator");
else
    v40 = nil;
end;

if v40 then
    local PlayingAnimationTracks = v40:GetPlayingAnimationTracks();

    for _, v in ipairs(PlayingAnimationTracks) do
        v:Stop(0);
        v:Destroy();
    end;
end;

for i, v in pairs(u13) do
    configureAnimationSet(i, v);
end;

local u41 = "None";
local u42 = 0;
local u43 = 0;
local u44 = false;

function stopAllAnimations()
    -- upvalues: u4 (ref), u14 (copy), u44 (ref), u5 (ref), u7 (ref), u6 (ref), u10 (ref), u9 (ref)
    local v45 = u4;
    local v46 = u14[v45] ~= nil and u14[v45] == false and "idle" or v45;

    if u44 then
        v46 = "idle";
        u44 = false;
    end;

    u4 = "";
    u5 = nil;

    if u7 ~= nil then
        u7:disconnect();
    end;

    if u6 ~= nil then
        u6:Stop();
        u6:Destroy();
        u6 = nil;
    end;

    if u10 ~= nil then
        u10:disconnect();
    end;

    if u9 ~= nil then
        u9:Stop();
        u9:Destroy();
        u9 = nil;
    end;

    return v46;
end;

function getHeightScale()
    -- upvalues: Humanoid (copy), getRigScale (copy), ScaleDampeningPercent (ref)
    if not Humanoid then
        return getRigScale();
    end;

    if not Humanoid.AutomaticScalingEnabled then
        return getRigScale();
    end;

    local v47 = Humanoid.HipHeight / 2;

    if ScaleDampeningPercent == nil then
        ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent");
    end;

    if ScaleDampeningPercent ~= nil then
        v47 = 1 + (Humanoid.HipHeight - 2) * ScaleDampeningPercent.Value / 2;
    end;

    return v47;
end;

local function rootMotionCompensation(p48) -- Line: 361
    return p48 * 1.25 / getHeightScale();
end;

local function setRunSpeed(p49) -- Line: 369
    -- upvalues: u6 (ref), u9 (ref)
    local v50 = p49 * 1.25 / getHeightScale();
    local v51 = 0.0001;
    local v52 = v50 / 0.5;
    local v53 = v50 / 1;
    local v54;

    if v50 <= 0.5 then
        v51 = 1;
        v54 = 0.0001;
    elseif v50 < 1 then
        v54 = (v50 - 0.5) / 0.5;
        v51 = 1 - v54;
        v52 = 1;
        v53 = 1;
    else
        v54 = 1;
    end;

    u6:AdjustWeight(v51);
    u9:AdjustWeight(v54);
    u6:AdjustSpeed(v52);
    u9:AdjustSpeed(v53);
end;

function setAnimationSpeed(p55)
    -- upvalues: u4 (ref), setRunSpeed (copy), u8 (ref), u6 (ref)
    if u4 == "walk" then
        setRunSpeed(p55);

        return;
    end;

    if p55 ~= u8 then
        u8 = p55;
        u6:AdjustSpeed(u8);
    end;
end;

function keyFrameReachedFunc(p56)
    -- upvalues: u4 (ref), u2 (copy), u9 (ref), u6 (ref), u14 (copy), u44 (ref), u8 (ref), Humanoid (copy)
    if p56 == "End" then
        if u4 == "walk" then
            if u2 ~= true then
                u9.TimePosition = 0;
                u6.TimePosition = 0;

                return;
            end;

            if u9.Looped ~= true then
                u9.TimePosition = 0;
            end;

            if u6.Looped ~= true then
                u6.TimePosition = 0;
            end;
        else
            local v57 = u4;
            local v58 = u14[v57] ~= nil and u14[v57] == false and "idle" or v57;

            if u44 then
                if u6.Looped then
                    return;
                end;

                v58 = "idle";
                u44 = false;
            end;

            playAnimation(v58, 0.15, Humanoid);
            setAnimationSpeed(u8);
        end;
    end;
end;

function rollAnimation(p59)
    -- upvalues: u12 (copy)
    local math_random_ret = math.random(1, u12[p59].totalWeight);
    local v60 = 1;

    while u12[p59][v60].weight < math_random_ret do
        math_random_ret = math_random_ret - u12[p59][v60].weight;
        v60 = v60 + 1;
    end;

    return v60;
end;

local function switchToAnim(p61, p62, p63, p64) -- Line: 456
    -- upvalues: u5 (ref), u6 (ref), u9 (ref), u2 (copy), u8 (ref), u4 (ref), u7 (ref), u12 (copy), u10 (ref)
    if p61 ~= u5 then
        if u6 ~= nil then
            u6:Stop(p63);
            u6:Destroy();
        end;

        if u9 ~= nil then
            u9:Stop(p63);
            u9:Destroy();

            if u2 == true then
                u9 = nil;
            end;
        end;

        u8 = 1;
        u6 = p64:LoadAnimation(p61);
        u6.Priority = Enum.AnimationPriority.Core;
        u6:Play(p63);
        u4 = p62;
        u5 = p61;

        if u7 ~= nil then
            u7:disconnect();
        end;

        u7 = u6.KeyframeReached:connect(keyFrameReachedFunc);

        if p62 == "walk" then
            local v65 = rollAnimation("run");
            u9 = p64:LoadAnimation(u12.run[v65].anim);
            u9.Priority = Enum.AnimationPriority.Core;
            u9:Play(p63);

            if u10 ~= nil then
                u10:disconnect();
            end;

            u10 = u9.KeyframeReached:connect(keyFrameReachedFunc);
        end;
    end;
end;

function playAnimation(p66, p67, p68)
    -- upvalues: u12 (copy), switchToAnim (copy), u44 (ref)
    local v69 = rollAnimation(p66);
    switchToAnim(u12[p66][v69].anim, p66, p67, p68);
    u44 = false;
end;

function playEmote(p70, p71, p72)
    -- upvalues: switchToAnim (copy), u44 (ref)
    switchToAnim(p70, p70.Name, p71, p72);
    u44 = true;
end;

local u73 = "";
local u74 = nil;
local u75 = nil;
local u76 = nil;

function toolKeyFrameReachedFunc(p77)
    -- upvalues: u73 (ref), Humanoid (copy)
    if p77 == "End" then
        playToolAnimation(u73, 0, Humanoid);
    end;
end;

function playToolAnimation(p78, p79, p80, p81)
    -- upvalues: u12 (copy), u75 (ref), u74 (ref), u73 (ref), u76 (ref)
    local v82 = rollAnimation(p78);
    local anim = u12[p78][v82].anim;

    if u75 ~= anim then
        if u74 ~= nil then
            u74:Stop();
            u74:Destroy();
            p79 = 0;
        end;

        u74 = p80:LoadAnimation(anim);

        if p81 then
            u74.Priority = p81;
        end;

        u74:Play(p79);
        u73 = p78;
        u75 = anim;
        u76 = u74.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;

function stopToolAnimations()
    -- upvalues: u73 (ref), u76 (ref), u75 (ref), u74 (ref)
    local v83 = u73;

    if u76 ~= nil then
        u76:disconnect();
    end;

    u73 = "";
    u75 = nil;

    if u74 ~= nil then
        u74:Stop();
        u74:Destroy();
        u74 = nil;
    end;

    return v83;
end;

function onRunning(p84)
    -- upvalues: u3 (copy), u44 (ref), Humanoid (copy), u1 (ref), u14 (copy), u4 (ref)
    local v85 = not u3 and 1 or getHeightScale();

    if (u44 and Humanoid.MoveDirection == Vector3.new(0, 0, 0) and (Humanoid.WalkSpeed / v85 or 0.75) or 0.75) * v85 >= p84 then
        if u14[u4] == nil and not u44 then
            playAnimation("idle", 0.2, Humanoid);
            u1 = "Standing";
        end;

        return;
    end;

    playAnimation("walk", 0.2, Humanoid);
    setAnimationSpeed(p84 / 16);
    u1 = "Running";
end;

function onDied()
    -- upvalues: u1 (ref)
    u1 = "Dead";
end;

function onJumping()
    -- upvalues: Humanoid (copy), u43 (ref), u1 (ref)
    playAnimation("jump", 0.1, Humanoid);
    u43 = 0.31;
    u1 = "Jumping";
end;

function onClimbing(p86)
    -- upvalues: u3 (copy), Humanoid (copy), u1 (ref)
    if u3 then
        p86 = p86 / getHeightScale();
    end;

    playAnimation("climb", 0.1, Humanoid);
    setAnimationSpeed(p86 / 5);
    u1 = "Climbing";
end;

function onGettingUp()
    -- upvalues: u1 (ref)
    u1 = "GettingUp";
end;

function onFreeFall()
    -- upvalues: u43 (ref), Humanoid (copy), u1 (ref)
    if u43 <= 0 then
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

function onSwimming(p87)
    -- upvalues: u3 (copy), Humanoid (copy), u1 (ref)
    if u3 then
        p87 = p87 / getHeightScale();
    end;

    if p87 <= 1 then
        playAnimation("swimidle", 0.4, Humanoid);
        u1 = "Standing";

        return;
    end;

    playAnimation("swim", 0.4, Humanoid);
    setAnimationSpeed(p87 / 10);
    u1 = "Swimming";
end;

function animateTool()
    -- upvalues: u41 (ref), Humanoid (copy)
    if u41 == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle);

        return;
    end;

    if u41 == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action);

        return;
    end;

    if u41 ~= "Lunge" then
        return;
    end;

    playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action);
end;

function getToolAnim(p88)
    for _, child in ipairs(p88:GetChildren()) do
        if child.Name == "toolanim" and child.className == "StringValue" then
            return child;
        end;
    end;

    return nil;
end;

local u89 = 0;

function stepAnimate(p90)
    -- upvalues: u89 (ref), u43 (ref), u1 (ref), Humanoid (copy), script_Parent (copy), u41 (ref), u42 (ref), u75 (ref)
    local v91 = p90 - u89;
    u89 = p90;

    if u43 > 0 then
        u43 = u43 - v91;
    end;

    if u1 == "FreeFall" and u43 <= 0 then
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

    local v92 = script_Parent:FindFirstChildOfClass("Tool");

    if v92 and v92:FindFirstChild("Handle") then
        local v93 = getToolAnim(v92);

        if v93 then
            u41 = v93.Value;
            v93.Parent = nil;
            u42 = p90 + 0.3;
        end;

        if u42 < p90 then
            u42 = 0;
            u41 = "None";
        end;

        animateTool();

        return;
    end;

    stopToolAnimations();
    u41 = "None";
    u75 = nil;
    u42 = 0;
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
game:GetService("Players").LocalPlayer.Chatted:connect(function(p94) -- Line: 757
    -- upvalues: u1 (ref), u14 (copy), Humanoid (copy)
    local v95 = "";

    if string.sub(p94, 1, 3) == "/e " then
        v95 = string.sub(p94, 4);
    elseif string.sub(p94, 1, 7) == "/emote " then
        v95 = string.sub(p94, 8);
    end;

    if u1 == "Standing" and u14[v95] ~= nil then
        playAnimation(v95, 0.1, Humanoid);
    end;
end);

script:WaitForChild("PlayEmote").OnInvoke = function(p96) -- Line: 771
    -- upvalues: u1 (ref), u14 (copy), Humanoid (copy), u6 (ref)
    if u1 == "Standing" then
        if u14[p96] ~= nil then
            playAnimation(p96, 0.1, Humanoid);

            return true, u6;
        end;

        if typeof(p96) ~= "Instance" or not p96:IsA("Animation") then
            return false;
        end;

        playEmote(p96, 0.1, Humanoid);

        return true, u6;
    end;
end;

if script_Parent.Parent ~= nil then
    playAnimation("idle", 0.1, Humanoid);
    u1 = "Standing";
end;

while script_Parent.Parent ~= nil do
    local _, v97 = wait(0.1);
    stepAnimate(v97);
end;