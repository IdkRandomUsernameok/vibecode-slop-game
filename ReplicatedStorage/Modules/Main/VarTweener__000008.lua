-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
game:GetService("TweenService");
local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local Signal = require(Modules.Lib.Signal);
local Eases = require(Modules.Lib.Eases);
local u1 = {};
local u2 = {};
local u3 = {};
local Begin = Enum.PlaybackState.Begin;
local Delayed = Enum.PlaybackState.Delayed;
local Cancelled = Enum.PlaybackState.Cancelled;
local Playing = Enum.PlaybackState.Playing;
local Completed = Enum.PlaybackState.Completed;
local Paused = Enum.PlaybackState.Paused;
(RunService:IsServer() and RunService.Heartbeat or RunService.PreRender):Connect(function(p4: number) -- Line: 27
    -- upvalues: u1 (copy)
    for i, _ in u1 do
        i:Update(p4);
    end;
end);
local u5 = {};
u5.__index = u5;

function u5.Create(p6: table, p7: any, p8: any, p9: table) -- Line: 36
    -- upvalues: Eases (copy), Begin (copy), Signal (copy), u5 (copy)
    local v10 = p9 or {};
    local v11 = p8 or {};
    local Reverses = v11.Reverses;

    if Reverses == nil then
        Reverses = v11.Reverse;
    end;

    if Reverses == nil then
        Reverses = false;
    end;

    local v12 = nil;

    if v11.EasingStyle or v11.EasingDirection then
        v12 = Eases.getEaseFromEnum(v11.EasingStyle or Enum.EasingStyle.Linear, v11.EasingDirection or Enum.EasingDirection.Out);
    elseif type(v11.Ease) == "table" then
        v12 = Eases.getEaseFromEnum(v11.Ease.Style or Enum.EasingStyle.Linear, v11.Ease.Direction or Enum.EasingDirection.Out);
    elseif type(v11.Ease) == "string" then
        v12 = Eases.getEaseFromFlixel(v11.Ease) or (Eases[v11.Ease] or nil);
    elseif type(v11.Ease) == "function" then
        v12 = v11.Ease;
    end;

    local v13 = {
        Timer = 0,
        delayAffectsLoops = true,
        delayLooping = false,
        LoopsDone = 0,
        Speed = 1,
        Parent = nil,
        Running = false,
        Reversing = false,
        Duration = math.abs(v11.Time or (v11.Duration or 0)),
        Reverses = Reverses,
        Loops = math.abs(v11.RepeatCount or (v11.Loops or 0)),
        DelayTime = math.abs(v11.DelayTime or (v11.Delay or 0)),
        Easing = v12 or Eases.InLinear,
        Target = v10,
        OGTarget = v10,
        Table = p7,
        OriginalProps = {},
        SubjectLerps = {},
        Instance = p7,
        PlaybackState = Begin,
        TweenInfo = v11,
        Completed = Signal.new(),
        Started = Signal.new(),
        Looped = Signal.new()
    };

    return setmetatable(v13, u5);
end;

local u14 = {
    dummy = true
};

function u5.CreateValueTween(p15: table, u16: any, p17: any, p18: any, u19: function) -- Line: 94
    -- upvalues: u14 (copy)
    return p15:Create(setmetatable({
        value = nil
    }, {
        __iter = function() -- Line: 96, Name: __iter
            -- upvalues: u14 (ref)
            return next, u14;
        end,

        __index = function() -- Line: 99, Name: __index
            -- upvalues: u16 (copy)
            return u16;
        end,

        __newindex = function(p20: any, p21: any, p22: number) -- Line: 102, Name: __newindex
            -- upvalues: u19 (copy)
            u19(p22);
        end
    }), p18, {
        value = p17
    });
end;

function u5.MergeTweens(p23: table, u24: userdata, ...) -- Line: 110
    local u25 = { u24, ... };

    return setmetatable({
        tweens = u25
    }, {
        __index = function(p26: any, u27: userdata) -- Line: 114, Name: __index
            -- upvalues: u24 (copy), u25 (copy)
            local v28 = u24[u27];

            if type(v28) == "function" then
                return setmetatable({}, {
                    __call = function(...) -- Line: 117, Name: __call
                        -- upvalues: u25 (ref), u27 (copy)
                        for _, v in u25 do
                            v[u27](v, select(3, ...));
                        end;
                    end
                });
            end;

            return v28;
        end,

        __newindex = function(p29: any, p30: userdata, p31: any) -- Line: 126, Name: __newindex
            -- upvalues: u25 (copy)
            for _, v in u25 do
                v[p30] = p31;
            end;
        end
    });
end;

function u5.Update(p32: userdata, p33: number) -- Line: 134
    -- upvalues: Completed (copy)
    if p32.delayLooping or not p32.Running then
        return;
    end;

    local v34 = p33 * p32.Speed;
    local Duration = p32.Duration;
    local v35 = Duration == 0;

    if Duration < v34 and not v35 then
        for i = 1, v34 // Duration do
            p32:Update(Duration);
            local _ = i;
        end;

        return p32:Update(v34 % Duration);
    end;

    local Reverses = p32.Reverses;
    local Loops = p32.Loops;

    if p32.Reversing then
        v34 = -v34 or v34;
    end;

    p32.Timer = p32.Timer + v34;

    if Reverses and (not p32.Reversing and Duration <= p32.Timer) then
        p32.Reversing = true;
        p32.Timer = Duration - (p32.Timer - Duration);
    end;

    local Timer = p32.Timer;
    p32.Timer = v35 and 0 or math.clamp(p32.Timer, 0, Duration);
    local v36 = Timer - p32.Timer;
    local v37 = Reverses and (p32.Reversing and p32.Timer <= 0) and true or (not Reverses and Duration <= p32.Timer and true or false);
    local v38 = Loops > 0 and Loops - p32.LoopsDone or (Loops == 0 and 0 or (1 / 0));

    if v37 then
        p32.Reversing = v35;
        p32.Timer = v38 >= 1 and v36 and v36 or p32.Duration;
        p32.LoopsDone = p32.LoopsDone + 1;
    end;

    if v38 >= 1 and v37 then
        p32.Looped:Fire(p32.LoopsDone);

        if p32.delayAffectsLoops then
            p32.delayLooping = true;
            p32.Timer = 0;
            p32:UpdateValues();
            p32.Timer = task.wait(p32.DelayTime);
            p32.delayLooping = false;

            if not p32.Running then
                return;
            end;
        end;
    end;

    if not (v38 <= 0 and v37 and v37) and next(p32.Target) then
        p32:UpdateValues();

        return;
    end;

    p32.Timer = Reverses and 0 or Duration;
    p32:UpdateValues();
    p32.Running = false;
    p32.delayLooping = false;
    p32:RemoveFromRunning();
    p32.PlaybackState = Completed;
    p32.Completed:Fire();
end;

function u5.CompleteTweensFrom(p39: userdata, p40: any) -- Line: 212
    -- upvalues: u2 (copy)
    local v41 = {};

    for _, v in u2[p40] or {} do
        if not v41[v] and v.Running then
            v:Complete();
            v41[v] = true;
        end;
    end;
end;

function u5.CancelTweensOf(p42: userdata, p43: any, p44: any) -- Line: 226
    -- upvalues: u2 (copy), u3 (copy)
    if not p43 then
        return;
    end;

    local v45 = {};
    local v46 = u2[p43];

    if v46 then
        if p44 then
            local v47 = v46[p44];

            if v47 then
                v45[v47] = true;
            end;
        else
            for _, v in v46 do
                if v then
                    v45[v] = true;
                end;
            end;
        end;
    end;

    local v48 = u3[p43];

    if v48 then
        for i in v48 do
            if i and (not p44 or i.Target[p44] ~= nil) then
                v45[i] = true;
            end;
        end;
    end;

    for i in v45 do
        i:Cancel();
    end;
end;

function metaLerpWrapper(u49, u50)
    local Lerp = u49.Lerp;

    return function(p51: number) -- Line: 262
        -- upvalues: Lerp (copy), u49 (copy), u50 (copy)
        return Lerp(u49, u50, p51);
    end;
end;

local u103 = {
    boolean = function(u52: boolean, u53: boolean) -- Line: 269
        return function(p54: number) -- Line: 270
            -- upvalues: u53 (copy), u52 (copy)
            if p54 == 1 then
                return u53;
            end;

            return u52;
        end;
    end,

    number = function(u55: number, p56: number) -- Line: 278
        local u57 = p56 - u55;

        return function(p58: number) -- Line: 281
            -- upvalues: u55 (copy), u57 (copy)
            return u55 + u57 * p58;
        end;
    end,

    CFrame = metaLerpWrapper,
    Color3 = metaLerpWrapper,
    UDim2 = metaLerpWrapper,
    Vector2 = metaLerpWrapper,

    Vector3 = function(u59: vector, u60: vector) -- Line: 290
        local vector_lerp = vector.lerp;

        return function(p61: number) -- Line: 292
            -- upvalues: u59 (copy), u60 (copy), vector_lerp (copy)
            return vector_lerp(u59, u60, p61);
        end;
    end,

    NumberSequence = function(p62: userdata, p63: any) -- Line: 296
        if type(p63) == "number" then
            p63 = NumberSequence.new(p63) or p63;
        end;

        local v64 = {};

        for _, v in p62.Keypoints do
            table.insert(v64, {
                Time = v.Time,
                Value = v.Value,
                Envelope = v.Envelope
            });
        end;

        local v65 = {};

        for _, v in p63.Keypoints do
            table.insert(v65, {
                Time = v.Time,
                Value = v.Value,
                Envelope = v.Envelope
            });
        end;

        local u66 = {};
        local v67 = {};
        local v68 = 0;

        for _, v in v64 do
            local v69 = v;
            local v70 = nil;
            local v71 = nil;

            for _, v2 in v65 do
                if v2.Time == v69.Time then
                    v70 = v2;
                    v71 = v70;
                    local v72 = v70;
                    v70 = v71;
                    v72 = v71;
                    break;
                end;

                if v2.Time < v69.Time and (v70 == nil or v2.Time > v70.Time) then
                    v70 = v2;
                elseif v2.Time > v69.Time and (v71 == nil or v2.Time < v71.Time) then
                    v71 = v2;
                end;
            end;

            local u73, u74;

            if v71 == v70 then
                u73 = v71.Value;
                u74 = v71.Envelope;
            else
                local v75 = (v69.Time - v70.Time) / (v71.Time - v70.Time);
                u73 = (v71.Value - v70.Value) * v75 + v70.Value;
                u74 = (v71.Envelope - v70.Envelope) * v75 + v70.Envelope;
            end;

            local Value = v69.Value;
            local Envelope = v69.Envelope;
            v68 = v68 + 1;
            local v76 = {
                time = v69.Time
            };
            local v77;

            if u74 == Envelope then
                v77 = function(p78: number) -- Line: 351
                    -- upvalues: u73 (ref), Value (copy), Envelope (copy)
                    return (u73 - Value) * p78 + Value, Envelope;
                end;
            else
                v77 = function(p79: number) -- Line: 355
                    -- upvalues: u73 (ref), Value (copy), u74 (ref), Envelope (copy)
                    return (u73 - Value) * p79 + Value, (u74 - Envelope) * p79 + Envelope;
                end;
            end;

            v76.evalFunc = v77;
            u66[v68] = v76;
            v67[v69.Time] = true;
        end;

        for _, v in v65 do
            if not v67[v.Time] then
                local v80 = v;
                local v81 = nil;
                local v82 = nil;

                for _, v2 in v64 do
                    if v2.Time == v80.Time then
                        v81 = v2;
                        v82 = v81;
                        local v83 = v81;
                        v81 = v82;
                        v83 = v82;
                        break;
                    end;

                    if v2.Time < v80.Time and (v81 == nil or v2.Time > v81.Time) then
                        v81 = v2;
                    elseif v2.Time > v80.Time and (v82 == nil or v2.Time < v82.Time) then
                        v82 = v2;
                    end;
                end;

                local u84, u85;

                if v82 == v81 then
                    u84 = v82.Value;
                    u85 = v82.Envelope;
                else
                    local v86 = (v80.Time - v81.Time) / (v82.Time - v81.Time);
                    u84 = (v82.Value - v81.Value) * v86 + v81.Value;
                    u85 = (v82.Envelope - v81.Envelope) * v86 + v81.Envelope;
                end;

                local Value = v80.Value;
                local Envelope = v80.Envelope;
                v68 = v68 + 1;
                local v87 = {
                    time = v80.Time
                };
                local v88;

                if Envelope == u85 then
                    v88 = function(p89: number) -- Line: 393
                        -- upvalues: Value (copy), u84 (ref), u85 (ref)
                        return (Value - u84) * p89 + u84, u85;
                    end;
                else
                    v88 = function(p90: number) -- Line: 397
                        -- upvalues: Value (copy), u84 (ref), Envelope (copy), u85 (ref)
                        return (Value - u84) * p90 + u84, (Envelope - u85) * p90 + u85;
                    end;
                end;

                v87.evalFunc = v88;
                u66[v68] = v87;
            end;
        end;

        table.clear(v67);
        table.sort(u66, function(p91: table, p92: table) -- Line: 406
            return p91.time < p92.time;
        end);
        local table_create_ret = table.create(v68, NumberSequenceKeypoint.new(0, 0, 0));

        for i, v in u66 do
            local v93, v94 = v.evalFunc(0);
            local v95, v96 = v.evalFunc(1);

            if v93 == v95 and v94 == v96 then
                u66[i] = nil;
                table_create_ret[i] = NumberSequenceKeypoint.new(v.time, v93, v94);
            end;
        end;

        return function(p97: number) -- Line: 422
            -- upvalues: u66 (copy), table_create_ret (copy)
            for i, v in u66 do
                table_create_ret[i] = NumberSequenceKeypoint.new(v.time, v.evalFunc(p97));
            end;

            return NumberSequence.new(table_create_ret);
        end;
    end,

    NumberRange = function(p98, p99: any) -- Line: 430, Name: NumberRange
        if type(p99) == "number" then
            p99 = NumberRange.new(p99) or p99;
        end;

        local Min = p98.Min;
        local Max = p98.Max;
        local u100 = p99.Min - Min;
        local u101 = p99.Max - Max;

        return function(p102: number) -- Line: 436
            -- upvalues: Min (copy), u100 (copy), Max (copy), u101 (copy)
            return NumberRange.new(Min + p102 * u100, Max + p102 * u101);
        end;
    end
};

function u5.UpdateValues(p104: userdata) -- Line: 442
    local Duration = p104.Duration;
    local v105;

    if Duration == 0 then
        v105 = p104.Reverses and 0 or 1;
    else
        v105 = p104.Timer / Duration;
    end;

    local math_clamp_ret = math.clamp(v105, 0, 1);
    local v106 = p104.Easing(math_clamp_ret);
    local Table = p104.Table;

    for i, v in p104.SubjectLerps do
        Table[i] = v(v106);
    end;
end;

function u5.Set(p107: userdata, p108: number) -- Line: 455
    local Duration = p107.Duration;
    local Reverses = p107.Reverses;
    local Loops = p107.Loops;
    local v109 = Reverses and 2 or 1;

    if Loops >= 0 and Duration * v109 * math.max(Loops, 1) <= p108 then
        return p107:Complete();
    end;

    if Loops > 0 then
        local math_floor_ret = math.floor(p108 / (Duration * v109));
        p107.LoopsDone = math.clamp(math_floor_ret, 0, Loops);

        if p107.LoopsDone > 0 then
            for i = 1, p107.LoopsDone do
                p107.Looped:Fire(i);
                local _ = i;
            end;
        end;

        p107.Timer = p108 - Duration * v109 * p107.LoopsDone;
    else
        local v110 = p108 % Duration;
        local v111 = p108 % (Duration * v109);

        if Reverses then
            Reverses = Duration <= v111;
        end;

        p107.Reversing = Reverses;

        if p107.Reversing then
            v111 = Duration - v110;
        end;

        p107.Timer = v111;
    end;

    p107:Update(0);
end;

function u5.GetProgress(p112: userdata) -- Line: 489
    -- upvalues: Completed (copy)
    if not p112.Running then
        return p112.PlaybackState == Completed and 1 or 0;
    end;

    local Duration = p112.Duration;
    local _ = p112.Reverses;
    local Loops = p112.Loops;
    local v113 = p112.Reverses and 2 or 1;
    local v114;

    if Loops > 0 then
        v114 = (p112.Timer + Duration * v113 * p112.LoopsDone) / (Duration * v113 * (Loops + 1));
    else
        v114 = p112.Timer / (Duration * v113);
    end;

    return math.clamp(v114, 0, 1);
end;

function u5.SetProgress(p115: userdata, p116: number) -- Line: 510
    local math_clamp_ret = math.clamp(p116, 0, 1);

    if math_clamp_ret == 0 then
        p115:Cancel();

        return;
    end;

    if math_clamp_ret == 1 then
        p115:Complete();

        return;
    end;

    local Duration = p115.Duration;
    local Reverses = p115.Reverses;
    local v117 = math_clamp_ret * (Duration * (Reverses and 2 or 1) * math.max(p115.Loops, 1));

    if p115.Loops > 0 then
        p115.LoopsDone = v117 // (Duration * (Reverses and 2 or 1));
        v117 = v117 - Duration * (Reverses and 2 or 1) * p115.LoopsDone;
    end;

    if Reverses then
        Reverses = Duration <= v117;
    end;

    p115.Reversing = Reverses;

    if Reverses then
        v117 = Duration - (v117 - Duration) or v117;
    end;

    p115.Timer = v117;
    p115:UpdateValues();
end;

function u5.Play(u118: userdata) -- Line: 541
    -- upvalues: Paused (copy), Delayed (copy), u3 (copy), Playing (copy), u2 (copy), u103 (copy), Completed (copy)
    if u118.Running then
        return;
    end;

    local u119 = u118.PlaybackState == Paused;
    u118.PlaybackState = Delayed;

    if not u3[u118.Table] then
        u3[u118.Table] = {};
    end;

    u3[u118.Table][u118] = true;
    local u120 = tick();

    local function v127() -- Line: 554
        -- upvalues: u3 (ref), u118 (copy), u120 (copy), u119 (copy), Playing (ref), u2 (ref), u103 (ref), Completed (ref)
        local v121 = u3[u118.Table];

        if v121 then
            v121[u118] = nil;

            if not next(v121) then
                u3[u118.Table] = nil;
            end;
        end;

        u118._currentTask = nil;
        u118.delayLooping = false;
        u118.Timer = tick() - u120 - (u119 and 0 or (u118.DelayTime or 0)) + (u119 and u118.Timer or 0);
        u118.PlaybackState = Playing;
        u118.Running = true;
        u118.Started:Fire();
        local table_clone_ret = table.clone(u118.OGTarget);
        u118.Target = table_clone_ret;

        if not u119 then
            local u122 = {};

            for i, _ in table_clone_ret do
                pcall(function() -- Line: 579
                    -- upvalues: u122 (copy), i (copy), u118 (ref)
                    u122[i] = u118.Table[i];
                end);
            end;

            u118.OriginalProps = u122;
        end;

        local v123 = u2[u118.Table];

        if v123 then
            for i, _ in table_clone_ret do
                local v124 = v123[i];

                if v124 and v124 ~= u118 then
                    v124.Target[i] = nil;
                    v124.SubjectLerps[i] = nil;
                end;
            end;
        else
            v123 = {};
            u2[u118.Table] = v123;
        end;

        local v125 = {};

        for i, v in u118.OriginalProps do
            local v126 = u103[typeof(v)];

            if v126 then
                v125[i] = v126(v, table_clone_ret[i]);
            end;

            v123[i] = u118;
        end;

        u118.SubjectLerps = v125;
        u118:Update(0);

        if u118.PlaybackState ~= Completed then
            u118:AddToRunning();
        end;
    end;

    if u118._currentTask then
        task.cancel(u118._currentTask);
    end;

    if u118.DelayTime > 0 and not u119 then
        u118._currentTask = task.delay(u118.DelayTime, v127);

        return;
    end;

    v127();
end;

function u5.Complete(p128: userdata) -- Line: 630
    p128.Timer = p128.Reverses and 0 or p128.Duration;
    p128.LoopsDone = p128.Loops;
    p128.Reversing = p128.Reverses;
    p128:Update(0);
end;

function u5.AddToRunning(p129: userdata) -- Line: 637
    -- upvalues: u1 (copy)
    u1[p129] = true;
end;

function u5.RemoveFromRunning(p130: userdata) -- Line: 641
    -- upvalues: u1 (copy), u3 (copy), u2 (copy)
    u1[p130] = nil;
    local v131 = u3[p130.Table];

    if v131 then
        v131[p130] = nil;

        if not next(v131) then
            u3[p130.Table] = nil;
        end;
    end;

    local v132 = u2[p130.Table];

    if v132 then
        for i, _ in p130.Target do
            if v132[i] == p130 then
                v132[i] = nil;
            end;
        end;

        if not next(v132) then
            u2[p130.Table] = nil;
        end;
    end;
end;

function u5.Pause(p133: userdata) -- Line: 666
    -- upvalues: Paused (copy)
    if p133._currentTask then
        task.cancel(p133._currentTask);
        p133._currentTask = nil;
    end;

    p133.PlaybackState = Paused;
    p133.Running = false;
    p133.delayLooping = false;
    p133:RemoveFromRunning();
end;

function u5.Cancel(p134: userdata) -- Line: 679
    -- upvalues: Cancelled (copy)
    if p134._currentTask then
        task.cancel(p134._currentTask);
        p134._currentTask = nil;
    end;

    p134.PlaybackState = Cancelled;
    p134.Running = false;
    p134.delayLooping = false;
    p134:RemoveFromRunning();
end;

function u5.Analitics(p135: userdata) -- Line: 692
    -- upvalues: u1 (copy), u2 (copy)
    local v136 = 0;

    for _, _ in u1 do
        v136 = v136 + 1;
    end;

    local v137 = 0;

    for _, _ in u2 do
        v137 = v137 + 1;
    end;

    return {
        totalTweens = v136,
        totalInstances = v137
    };
end;

return u5;