-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();
require(game:GetService("ReplicatedStorage").Modules.Main.VarTweener);

local function lerp(p1, p2, p3) -- Line: 6
    return p1 + (p2 - p1) * p3;
end;

function getPosByTime(p4)
    local v5 = p4 * 0.75 % 2300;

    if v5 < 733.3333333333333 then
        local v6 = 345 + -265 * toAlpha(v5, 400, 433.3333333333333);

        return -100 + 685 * toAlpha(v5, 200, 733.3333333333333), v6;
    end;

    if v5 < 1066.6666666666667 then
        local v7 = 80 + 265 * toAlpha(v5, 733.3333333333333, 1066.6666666666667);

        return 585 + -345 * toAlpha(v5, 866.6666666666666, 900), v7;
    end;

    if v5 < 1500 then
        return 240 + 480 * toAlpha(v5, 1066.6666666666667, 1500), v5 > 1200 and 345 + 145 * circIn(toAlpha(v5, 1200, 1300)) or 345;
    end;

    if v5 < 1799.9999999999998 then
        return 720 + 210 * toAlpha(v5, 1500, 1799.9999999999998), v5 > 1766.6666666666665 and 80 + 570 * toAlpha(v5, 1766.6666666666665, 1799.9999999999998) or 490 + -410 * toAlpha(v5, 1500, 1533.3333333333333);
    end;

    return 930 + 350 * toAlpha(v5, 1799.9999999999998, 2300), 650 + -344.25 * circOut(toAlpha(v5, 1799.9999999999998, 2100));
end;

function toAlpha(p8, p9, p10)
    return math.clamp((p8 - p9) / (p10 - p9), 0, 1);
end;

function circIn(p11)
    return -(math.sqrt(1 - p11 * p11) - 1);
end;

function circOut(p12)
    return math.sqrt(1 - (p12 - 1) * (p12 - 1));
end;

local u13 = 0;
local u14 = 0;

return {
    onCreate = function() -- Line: 74, Name: onCreate
        -- upvalues: Api (copy), u14 (ref), u13 (ref)
        for _, v in Api.UnspawnNotes do
            if v.mustPress and not v.sustainNote then
                local u15, u16 = getPosByTime(v.strumTime);
                local GetProperty = v.GetProperty;

                function v.GetProperty(p17, p18, ...) -- Line: 81
                    -- upvalues: u16 (copy), v (copy), u15 (copy), GetProperty (copy)
                    if p18 == "y" then
                        return u16 + v.offsets.get("y", "strumLineOffset") + v.offsets.get("y", "anchorOffset");
                    end;

                    if p18 == "x" then
                        return u15 + v.offsets.get("x", "anchorOffset");
                    end;

                    return GetProperty(v, p18, ...);
                end;
            end;
        end;

        for _, v in Api.Strums do
            local GetProperty = v.GetProperty;

            function v.GetProperty(p19, p20, ...) -- Line: 95
                -- upvalues: u14 (ref), v (copy), u13 (ref), GetProperty (copy)
                if p20 == "y" then
                    return u14 + v.offsets.get("y", "strumLineOffset") + v.offsets.get("y", "anchorOffset");
                end;

                if p20 == "x" then
                    return u13 + v.offsets.get("x", "anchorOffset");
                end;

                return GetProperty(v, p20, ...);
            end;
        end;
    end,

    onUpdate = function() -- Line: 107, Name: onUpdate
        -- upvalues: Api (copy), u13 (ref), u14 (ref)
        local v21, v22 = getPosByTime(Api.Conductor.SongPosition);
        u13 = v21;
        u14 = v22;
        local _ = Api.currentStrumline;

        for _, v in Api.Strums do
            v.visible = false;
        end;

        for i, v in Api.currentStrumline.Strums do
            v.visible = i == 1;
        end;
    end
};