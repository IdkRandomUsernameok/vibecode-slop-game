-- Decompiled with Potassium's decompiler.

local function perspectiveProject(p1, p2, p3) -- Line: 6
    local math_min_ret = math.min(1, p3);
    local math_max_ret = math.max(0.0001, math_min_ret);
    local v4 = math_max_ret - 1;
    local v5 = -(v4 > 0 and 0 or v4);

    if v5 < 0.0001 then
        return p1, p2, 1;
    end;

    return p1 / v5, p2 / v5, 1 / math_max_ret;
end;

local u6 = {
    Drunk = 0,
    DrunkSpeed = 0,
    DrunkPeriod = 0,
    DrunkOffset = 0,
    DrunkZ = 0,
    DrunkZSpeed = 0,
    DrunkZOffset = 0,
    DrunkZPeriod = 0,
    Tipsy = 0,
    TipsySpeed = 1,
    TipsyOffset = 0,
    TipsyZ = 0,
    TipsyZSpeed = 1,
    TipsyZOffset = 0,
    Bumpy = 0,
    BumpyPeriod = 0,
    BumpyOffset = 0
};

return {
    Drunk = {
        Set = function(p7) -- Line: 49, Name: Set
            -- upvalues: u6 (copy)
            u6.Drunk = p7;
        end,

        Get = function() -- Line: 50, Name: Get
            -- upvalues: u6 (copy)
            return u6.Drunk;
        end,

        Update = function(p8, p9, p10) -- Line: 51, Name: Update
            -- upvalues: u6 (copy)
            local v11 = p10.SONG_POSITION * 0.001;
            local COLUMN = p10.COLUMN;
            local Y_OFFSET = p10.Y_OFFSET;
            local ARROW_SIZE = p10.ARROW_SIZE;

            if u6.Tipsy ~= 0 then
                p8.y = p8.y + u6.Tipsy * (math.cos(v11 * (u6.TipsySpeed * 1.2 + 1.2) + COLUMN * (u6.TipsyOffset * 1.8 + 1.8)) * ARROW_SIZE * 0.4);
            end;

            if u6.Drunk ~= 0 then
                p8.x = p8.x + u6.Drunk * (math.cos(v11 * (1 + u6.DrunkSpeed) + COLUMN * (u6.DrunkOffset * 0.2 + 0.2) + Y_OFFSET * (u6.DrunkPeriod * 10 + 10) / 720) * ARROW_SIZE * 0.5);
            end;

            local v12 = 0;

            if u6.DrunkZ ~= 0 then
                v12 = v12 + u6.DrunkZ * (math.cos(v11 * (1 + u6.DrunkZSpeed) + COLUMN * (u6.DrunkZOffset * 0.2 + 0.2) + Y_OFFSET * (u6.DrunkZPeriod * 10 + 10) / 720) * 0.5);
            end;

            if u6.TipsyZ ~= 0 then
                v12 = v12 + u6.TipsyZ * (math.cos(v11 * (u6.TipsyZSpeed * 1.2 + 1.2) + COLUMN * (u6.TipsyZOffset * 1.8 + 3.2)) * 0.15);
            end;

            if u6.Bumpy ~= 0 then
                v12 = v12 + u6.Bumpy * 40 * math.sin((Y_OFFSET + 100 * u6.BumpyOffset) / (u6.BumpyPeriod * 16 + 16)) / 250;
            end;

            if v12 ~= 0 then
                local v13 = p8.x - 640;
                local v14 = p8.y - 360;
                local math_min_ret = math.min(1, v12 + 1);
                local math_max_ret = math.max(0.0001, math_min_ret);
                local v15 = math_max_ret - 1;
                local v16 = -(v15 > 0 and 0 or v15);
                local v17;

                if v16 < 0.0001 then
                    v17 = 1;
                else
                    v13 = v13 / v16;
                    v14 = v14 / v16;
                    v17 = 1 / math_max_ret;
                end;

                p8.x = 640 + v13;
                p8.y = 360 + v14;
                p8.scaleX = p8.scaleX * v17;
                p8.scaleY = p8.scaleY * v17;
            end;

            return p8;
        end
    },
    DrunkSpeed = {
        Set = function(p18) -- Line: 124, Name: Set
            -- upvalues: u6 (copy)
            u6.DrunkSpeed = p18;
        end,

        Get = function() -- Line: 124, Name: Get
            -- upvalues: u6 (copy)
            return u6.DrunkSpeed;
        end
    },
    DrunkPeriod = {
        Set = function(p19) -- Line: 125, Name: Set
            -- upvalues: u6 (copy)
            u6.DrunkPeriod = p19;
        end,

        Get = function() -- Line: 125, Name: Get
            -- upvalues: u6 (copy)
            return u6.DrunkPeriod;
        end
    },
    DrunkOffset = {
        Set = function(p20) -- Line: 126, Name: Set
            -- upvalues: u6 (copy)
            u6.DrunkOffset = p20;
        end,

        Get = function() -- Line: 126, Name: Get
            -- upvalues: u6 (copy)
            return u6.DrunkOffset;
        end
    },
    DrunkZ = {
        Set = function(p21) -- Line: 128, Name: Set
            -- upvalues: u6 (copy)
            u6.DrunkZ = p21;
        end,

        Get = function() -- Line: 128, Name: Get
            -- upvalues: u6 (copy)
            return u6.DrunkZ;
        end
    },
    DrunkZSpeed = {
        Set = function(p22) -- Line: 129, Name: Set
            -- upvalues: u6 (copy)
            u6.DrunkZSpeed = p22;
        end,

        Get = function() -- Line: 129, Name: Get
            -- upvalues: u6 (copy)
            return u6.DrunkZSpeed;
        end
    },
    DrunkZOffset = {
        Set = function(p23) -- Line: 130, Name: Set
            -- upvalues: u6 (copy)
            u6.DrunkZOffset = p23;
        end,

        Get = function() -- Line: 130, Name: Get
            -- upvalues: u6 (copy)
            return u6.DrunkZOffset;
        end
    },
    DrunkZPeriod = {
        Set = function(p24) -- Line: 131, Name: Set
            -- upvalues: u6 (copy)
            u6.DrunkZPeriod = p24;
        end,

        Get = function() -- Line: 131, Name: Get
            -- upvalues: u6 (copy)
            return u6.DrunkZPeriod;
        end
    },
    Tipsy = {
        Set = function(p25) -- Line: 133, Name: Set
            -- upvalues: u6 (copy)
            u6.Tipsy = p25;
        end,

        Get = function() -- Line: 133, Name: Get
            -- upvalues: u6 (copy)
            return u6.Tipsy;
        end
    },
    TipsySpeed = {
        Set = function(p26) -- Line: 134, Name: Set
            -- upvalues: u6 (copy)
            u6.TipsySpeed = p26;
        end,

        Get = function() -- Line: 134, Name: Get
            -- upvalues: u6 (copy)
            return u6.TipsySpeed;
        end
    },
    TipsyOffset = {
        Set = function(p27) -- Line: 135, Name: Set
            -- upvalues: u6 (copy)
            u6.TipsyOffset = p27;
        end,

        Get = function() -- Line: 135, Name: Get
            -- upvalues: u6 (copy)
            return u6.TipsyOffset;
        end
    },
    TipsyZ = {
        Set = function(p28) -- Line: 137, Name: Set
            -- upvalues: u6 (copy)
            u6.TipsyZ = p28;
        end,

        Get = function() -- Line: 137, Name: Get
            -- upvalues: u6 (copy)
            return u6.TipsyZ;
        end
    },
    TipsyZSpeed = {
        Set = function(p29) -- Line: 138, Name: Set
            -- upvalues: u6 (copy)
            u6.TipsyZSpeed = p29;
        end,

        Get = function() -- Line: 138, Name: Get
            -- upvalues: u6 (copy)
            return u6.TipsyZSpeed;
        end
    },
    TipsyZOffset = {
        Set = function(p30) -- Line: 139, Name: Set
            -- upvalues: u6 (copy)
            u6.TipsyZOffset = p30;
        end,

        Get = function() -- Line: 139, Name: Get
            -- upvalues: u6 (copy)
            return u6.TipsyZOffset;
        end
    },
    Bumpy = {
        Set = function(p31) -- Line: 141, Name: Set
            -- upvalues: u6 (copy)
            u6.Bumpy = p31;
        end,

        Get = function() -- Line: 141, Name: Get
            -- upvalues: u6 (copy)
            return u6.Bumpy;
        end
    },
    BumpyPeriod = {
        Set = function(p32) -- Line: 142, Name: Set
            -- upvalues: u6 (copy)
            u6.BumpyPeriod = p32;
        end,

        Get = function() -- Line: 142, Name: Get
            -- upvalues: u6 (copy)
            return u6.BumpyPeriod;
        end
    },
    BumpyOffset = {
        Set = function(p33) -- Line: 143, Name: Set
            -- upvalues: u6 (copy)
            u6.BumpyOffset = p33;
        end,

        Get = function() -- Line: 143, Name: Get
            -- upvalues: u6 (copy)
            return u6.BumpyOffset;
        end
    }
};