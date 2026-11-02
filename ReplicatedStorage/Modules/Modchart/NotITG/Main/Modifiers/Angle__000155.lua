-- Decompiled with Potassium's decompiler.

local u1 = {
    Angle = 0,
    NoteAngle = 0,
    ReceptorAngle = 0,
    Confusion = 0,
    ["ConfusionOffset" .. 0] = 0,
    ["NoteAngle" .. 0] = 0,
    ["ReceptorAngle" .. 0] = 0,
    ["ConfusionOffset" .. 1] = 0,
    ["NoteAngle" .. 1] = 0,
    ["ReceptorAngle" .. 1] = 0,
    ["ConfusionOffset" .. 2] = 0,
    ["NoteAngle" .. 2] = 0,
    ["ReceptorAngle" .. 2] = 0,
    ["ConfusionOffset" .. 3] = 0,
    ["NoteAngle" .. 3] = 0,
    ["ReceptorAngle" .. 3] = 0
};
local v14 = {
    Angle = {
        Set = function(p2) -- Line: 15, Name: Set
            -- upvalues: u1 (copy)
            u1.Angle = p2;
        end,

        Get = function() -- Line: 16, Name: Get
            -- upvalues: u1 (copy)
            return u1.Angle;
        end,

        Update = function(p3, p4, p5) -- Line: 17, Name: Update
            -- upvalues: u1 (copy)
            p3.angle = p3.angle + u1.Angle;

            if not p5.IS_SUSTAIN then
                if p5.IS_STRUM then
                    p3.angle = p3.angle + (u1.ReceptorAngle + (u1["ReceptorAngle" .. p5.COLUMN] or 0));

                    return p3;
                end;

                p3.angle = p3.angle + (u1.NoteAngle + (u1["NoteAngle" .. p5.COLUMN] or 0));
            end;

            return p3;
        end
    },
    NoteAngle = {
        OnlyNotes = true,

        Set = function(p6) -- Line: 32, Name: Set
            -- upvalues: u1 (copy)
            u1.NoteAngle = p6;
        end,

        Get = function() -- Line: 33, Name: Get
            -- upvalues: u1 (copy)
            return u1.NoteAngle;
        end
    },
    ReceptorAngle = {
        OnlyReceptors = true,

        Set = function(p7) -- Line: 37, Name: Set
            -- upvalues: u1 (copy)
            u1.ReceptorAngle = p7;
        end,

        Get = function() -- Line: 38, Name: Get
            -- upvalues: u1 (copy)
            return u1.ReceptorAngle;
        end
    },
    Confusion = {
        Set = function(p8) -- Line: 41, Name: Set
            -- upvalues: u1 (copy)
            u1.Confusion = p8;
        end,

        Get = function() -- Line: 42, Name: Get
            -- upvalues: u1 (copy)
            return u1.Confusion;
        end,

        Update = function(p9, p10, p11) -- Line: 43, Name: Update
            -- upvalues: u1 (copy)
            if p11.IS_SUSTAIN then
                return p9;
            end;

            p9.angle = u1.Confusion + (u1["ConfusionOffset" .. p11.COLUMN] or 0);

            return p9;
        end
    },
    ConfusionOffset = {
        Set = function(p12) -- Line: 50, Name: Set
            -- upvalues: u1 (copy)
            u1.ConfusionOffset = p12;
        end,

        Get = function() -- Line: 51, Name: Get
            -- upvalues: u1 (copy)
            return u1.ConfusionOffset;
        end,

        Update = function(p13) -- Line: 52, Name: Update
            return p13;
        end
    }
};

for i = 0, 3 do
    v14["ConfusionOffset" .. i] = {
        Set = function(p15) -- Line: 58, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["ConfusionOffset" .. i] = p15;
        end,

        Get = function() -- Line: 59, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["ConfusionOffset" .. i];
        end,

        Update = function(p16) -- Line: 60, Name: Update
            return p16;
        end
    };
    v14["NoteAngle" .. i] = {
        Set = function(p17) -- Line: 63, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["NoteAngle" .. i] = p17;
        end,

        Get = function() -- Line: 64, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["NoteAngle" .. i];
        end,

        Update = function(p18) -- Line: 65, Name: Update
            return p18;
        end
    };
    v14["ReceptorAngle" .. i] = {
        Set = function(p19) -- Line: 68, Name: Set
            -- upvalues: u1 (copy), i (copy)
            u1["ReceptorAngle" .. i] = p19;
        end,

        Get = function() -- Line: 69, Name: Get
            -- upvalues: u1 (copy), i (copy)
            return u1["ReceptorAngle" .. i];
        end,

        Update = function(p20) -- Line: 70, Name: Update
            return p20;
        end
    };
    local _ = i;
end;

return v14;