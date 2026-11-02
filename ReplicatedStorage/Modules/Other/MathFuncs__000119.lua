-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
require(ReplicatedStorage.Modules.Signals.LocalSignals).APILoaded:Once(function(p5) -- Line: 11
    -- upvalues: u4 (ref), u2 (ref), u3 (ref)
    u4 = p5;
    u2 = u4.getKeyData();
    u3 = u4.getManiaData();
end);

function u1.getYPosAt(p6, p7, p8) -- Line: 18
    -- upvalues: u4 (ref)
    local v9 = p7 or 1;

    if #u4.svFunctions.sliderVelocities > 1 and not p8 then
        return (u4.Conductor.CurrentTrackPos - p6) * v9;
    end;

    local v10 = u4.getRawSpeed() * v9 * 0.45;

    return (u4.Conductor.SongPosition - p6) * v10;
end;

function u1.getStrumFromYPos(p11, p12, p13) -- Line: 26
    -- upvalues: u4 (ref)
    if #u4.svFunctions.sliderVelocities > 1 and not p13 then
        return (u4.Conductor.CurrentTrackPos * p12 - p11) / p12;
    end;

    local v14 = u4.getRawSpeed() * p12 * 0.45;

    return (u4.Conductor.SongPosition * v14 - p11) / v14;
end;

function u1.getSusLength(p15, p16, p17) -- Line: 33
    -- upvalues: u1 (copy)
    local v18 = p17 or 1;

    return (u1.getYPosAt(p15, v18) - u1.getYPosAt(p16, v18)) / 44;
end;

function u1.getRawXPoint(p19: any, p20: any, p21: number?) -- Line: 39
    -- upvalues: u2 (ref), u3 (ref)
    if not p19 then
        return 0;
    end;

    local v22 = p20 or u2.highestKey;
    local size = u3.size;
    local offset = u3.offset;
    local gap = u3.gap;

    return (155 * (Vector2.new(0.7, 0.7) - Vector2.new(size[v22], size[v22])).X * (p21 or 1) + (2 + gap[v22])) * math.abs(p19) + offset[v22];
end;

function u1.getRawStartPoint(p23) -- Line: 52
    -- upvalues: u2 (ref)
    local v24 = p23 or u2.leftKeyCount;

    return 100 - (v24 - 4) * 16 + (v24 >= 10 and 30 or 0);
end;

function u1.getRawPlrOffset(p25) -- Line: 57
    return 640 * (p25 or 0);
end;

function u1.getKeyMiddlePointOffset(p26) -- Line: 62
    -- upvalues: u3 (ref), u1 (copy)
    local size = u3.size;
    local v27 = (Vector2.new(0.7, 0.7) - Vector2.new(size[p26], size[p26])).X * 155;

    return u1.getRawXPoint(p26 / 2 + v27, p26, 1) - (640 + v27 / 2);
end;

function u1.getDefaultX(p28: any, p29: any, p30: any, p31: number?) -- Line: 72
    -- upvalues: u2 (ref), u3 (ref)
    local v32 = p30 or u2.highestKey;
    local size = u3.size;
    local offset = u3.offset;
    local gap = u3.gap;

    return 0 + ((155 * (Vector2.new(0.7, 0.7) - Vector2.new(size[v32], size[v32])).X * (p31 or 1) + (2 + gap[v32])) * math.abs(p28) + offset[v32]) + (100 - (v32 - 4) * 16 + (v32 >= 10 and 30 or 0)) + 640 * p29;
end;

function u1.getStrumGroupCenter(p33) -- Line: 92
    return (p33[0].x + (p33[#p33].x + 155 * p33[0].Scale.X)) / 2;
end;

function u1.setStrumGroupToPoint(p34: any, p35: any, p36: boolean?) -- Line: 102
    local v37 = (p35[0].x + (p35[#p35].x + 155 * p35[0].Scale.X)) / 2 - p34;

    for _, v in p35 do
        v.x = v.x - v37;

        if p36 then
            v.defaultX = v.x;
            _G["defaultStrum" .. tostring(v.strumIndex) .. "X"] = v.x;
        end;
    end;
end;

function u1.setGradientTransPoint(p38: table, p39: any, p40: number) -- Line: 122
    local math_clamp_ret = math.clamp(p40, 0, 1);

    if math_clamp_ret == 0 then
        p39.Transparency = NumberSequence.new(1);

        return;
    end;

    if math_clamp_ret == 1 then
        p39.Transparency = NumberSequence.new(0);

        return;
    end;

    local math_clamp_ret2 = math.clamp(p40, 0.002, 0.999);
    p39.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(math_clamp_ret2 - 0.001, 0),
        NumberSequenceKeypoint.new(math_clamp_ret2, 1),
        NumberSequenceKeypoint.new(1, 1)
    });
end;

return u1;