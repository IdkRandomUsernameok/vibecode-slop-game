-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = nil;
local u3 = false;
local u4 = false;
local u5 = nil;
local u6 = nil;

function v1.Init(p7) -- Line: 10
    -- upvalues: u5 (ref), u3 (ref), u4 (ref), u2 (ref), u6 (ref)
    u5 = p7;
    u3 = p7.Settings.Downscroll;
    u4 = p7.Settings.Middlescroll;
    u2 = require(script.Parent.NoteMovement);
    u6 = {
        width = 1280,
        height = 720
    };
end;

function v1.getDownscroll(p8, p9) -- Line: 22
    -- upvalues: u5 (ref), u2 (ref), u3 (ref)
    if p9 and u5 then
        return u5.getSetting(u2.keyCount <= p9 and "R" or "L", "Downscroll");
    end;

    return u3;
end;

function v1.getMiddlescroll(p10, p11) -- Line: 29
    -- upvalues: u5 (ref), u2 (ref), u4 (ref)
    if p11 and u5 then
        return u5.getSetting(u2.keyCount <= p11 and "R" or "L", "Middlescroll");
    end;

    return u4;
end;

function v1.isLeftSide(p12) -- Line: 36
    -- upvalues: u5 (ref)
    return u5.Side == "L";
end;

function v1.getScrollSpeed(p13) -- Line: 40
    -- upvalues: u5 (ref)
    return not u5 and 2.8 or u5.songSpeed;
end;

v1.zNear = 0;
v1.zFar = 100;
v1.defaultFOV = 90;
v1.zRange = v1.zNear - v1.zFar;
local u14 = 2 * v1.zFar * v1.zNear / v1.zRange;

function v1.calculatePerspective(p15: table, p16: table, p17: number, p18: number, p19: number) -- Line: 52
    -- upvalues: u6 (ref), u14 (copy)
    local v20 = p16.z - 1;
    local math_tan_ret = math.tan(p17 * 0.5);
    local v21 = (p16.z > 1 and 0 or v20) + u14;
    local v22 = (p16.y - u6.height * 0.5 + (p19 or 0) * -v21) * math_tan_ret / -v21;
    p16.x = (p16.x - u6.width * 0.5 + (p18 or 0) * -v21) * (1 / math_tan_ret) / -v21 + u6.width * 0.5;
    p16.y = v22 + u6.height * 0.5;
    p16.z = v21;

    return p16;
end;

function v1.getCartesianCoords3D(p23: table, p24: number, p25: number, p26: number) -- Line: 83
    local math_rad_ret = math.rad(p24);
    local math_rad_ret2 = math.rad(p25);
    local v27 = {
        x = 0,
        y = 0,
        z = 0,
        x = math.cos(math_rad_ret) * math.sin(math_rad_ret2),
        y = math.cos(math_rad_ret2),
        z = math.sin(math_rad_ret) * math.sin(math_rad_ret2)
    };
    v27.x = v27.x * p26;
    v27.y = v27.y * p26;
    v27.z = v27.z * p26;

    return v27;
end;

function v1.getTimeFromBeat(p28, p29) -- Line: 97
    -- upvalues: u5 (ref)
    return not u5 and 0 or u5.Conductor.Crochet * p29;
end;

return v1;