-- Decompiled with Potassium's decompiler.

local function scale(p1, p2, p3, p4, p5) -- Line: 1
    if p3 == p2 then
        return p4;
    end;

    return (p1 - p2) * (p5 - p4) / (p3 - p2) + p4;
end;

local function computeBeatAmount(p6, p7, p8) -- Line: 6
    local v9 = p6 + p7;
    local v10 = math.floor(v9) % 2 ~= 0;
    local v11 = v9 - math.floor(v9) + 1;
    local v12 = v11 - math.floor(v11);

    if p8 <= v12 then
        return nil;
    end;

    local v13;

    if v12 < p7 then
        local v14 = p7 == 0 and 0 or (v12 - 0) * 1 / (p7 - 0) + 0;
        v13 = v14 * v14;
    else
        local v15 = p8 == p7 and 1 or (v12 - p7) * -1 / (p8 - p7) + 1;
        v13 = 1 - (1 - v15) * (1 - v15);
    end;

    if v10 then
        v13 = v13 * -1;
    end;

    return v13;
end;

local u16 = {
    Beat = 0,
    BeatY = 0,
    BeatZ = 0
};

return {
    Beat = {
        Set = function(p17) -- Line: 29, Name: Set
            -- upvalues: u16 (copy)
            u16.Beat = p17;
        end,

        Get = function() -- Line: 30, Name: Get
            -- upvalues: u16 (copy)
            return u16.Beat;
        end,

        Update = function(p18, p19, p20) -- Line: 31, Name: Update
            -- upvalues: u16 (copy), computeBeatAmount (copy)
            if u16.Beat == 0 then
                return p18;
            end;

            local v21 = computeBeatAmount(p20.BEAT, 0.3, 0.7);

            if v21 == nil then
                return p18;
            end;

            local v22 = 40 * v21 * math.sin(p20.Y_OFFSET / 30 + 1.5707963267948966);
            p18.x = p18.x + u16.Beat * v22;

            return p18;
        end
    },
    BeatY = {
        Set = function(p23) -- Line: 41, Name: Set
            -- upvalues: u16 (copy)
            u16.BeatY = p23;
        end,

        Get = function() -- Line: 42, Name: Get
            -- upvalues: u16 (copy)
            return u16.BeatY;
        end,

        Update = function(p24, p25, p26) -- Line: 43, Name: Update
            -- upvalues: u16 (copy), computeBeatAmount (copy)
            if u16.BeatY == 0 then
                return p24;
            end;

            local v27 = computeBeatAmount(p26.BEAT, 0.3, 0.7);

            if v27 == nil then
                return p24;
            end;

            local v28 = 40 * v27 * math.sin(p26.Y_OFFSET / 30 + 1.5707963267948966);
            p24.y = p24.y + u16.BeatY * v28;

            return p24;
        end
    },
    BeatZ = {
        Set = function(p29) -- Line: 53, Name: Set
            -- upvalues: u16 (copy)
            u16.BeatZ = p29;
        end,

        Get = function() -- Line: 54, Name: Get
            -- upvalues: u16 (copy)
            return u16.BeatZ;
        end,

        Update = function(p30, p31, p32) -- Line: 55, Name: Update
            -- upvalues: u16 (copy), computeBeatAmount (copy)
            if u16.BeatZ == 0 then
                return p30;
            end;

            local v33 = computeBeatAmount(p32.BEAT, 0.3, 0.7);

            if v33 == nil then
                return p30;
            end;

            local v34 = u16.BeatZ * v33 / 10;
            p30.scaleX = p30.scaleX + v34;
            p30.scaleY = p30.scaleY + v34;

            return p30;
        end
    }
};