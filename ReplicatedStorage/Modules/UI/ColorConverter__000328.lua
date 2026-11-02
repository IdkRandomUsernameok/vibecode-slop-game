-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");

function evalColorSequence(p1: userdata, p2: number)
    if p2 == 0 then
        return p1.Keypoints[1].Value;
    end;

    if p2 == 1 then
        return p1.Keypoints[#p1.Keypoints].Value;
    end;

    for i = 1, #p1.Keypoints - 1 do
        local v3 = p1.Keypoints[i];
        local v4 = p1.Keypoints[i + 1];

        if v3.Time <= p2 and p2 < v4.Time then
            local v5 = (p2 - v3.Time) / (v4.Time - v3.Time);

            return Color3.new((v4.Value.R - v3.Value.R) * v5 + v3.Value.R, (v4.Value.G - v3.Value.G) * v5 + v3.Value.G, (v4.Value.B - v3.Value.B) * v5 + v3.Value.B);
        end;

        local _ = i;
    end;
end;

return {
    convertColor = function(p6: any, p7: boolean, p8: string, p9: boolean, p10: boolean, p11: boolean) -- Line: 21, Name: convertColor
        -- upvalues: HttpService (copy)
        if typeof(p6) == "Color3" then
            p6 = p6:ToHex();
        end;

        if not p9 and typeof(p6) == "string" then
            return {
                isGradient = false,
                color = p6
            };
        end;

        if not p9 or typeof(p6) ~= "string" then
            return {
                color = "#FFFFFF",
                isGradient = false
            };
        end;

        local v12 = {};

        for _, v in HttpService:JSONDecode(p6) do
            table.insert(v12, ColorSequenceKeypoint.new(v[1], Color3.fromHex(v[2])));
        end;

        local ColorSequence_new_ret = ColorSequence.new(v12);
        local v13 = p10 and "<b>" or "";

        for i, v in string.split(p8, "") do
            v13 = v13 .. `<font color='#{evalColorSequence(ColorSequence_new_ret, (i - 1) / #p8):ToHex()}'>{v}</font>`;
        end;

        if p10 then
            v13 = v13 .. "</b>";
        end;

        return {
            isGradient = true,
            color = v13 .. (p11 and (p7 == true and ":" or " ") or "")
        };
    end,

    invertColor = function(u14) -- Line: 64, Name: invertColor
        if typeof(u14) == "Color3" then
            u14 = u14:ToHex();
        end;

        if typeof(u14) == "string" then
            local success, result = pcall(function() -- Line: 70
                -- upvalues: u14 (ref)
                return Color3.fromHex(u14);
            end);

            if success then
                local Color3_new_ret = Color3.new(1 - result.R, 1 - result.G, 1 - result.B);

                return string.format("#%02X%02X%02X", math.round(Color3_new_ret.R * 255), math.round(Color3_new_ret.G * 255), (math.round(Color3_new_ret.B * 255)));
            end;
        elseif typeof(u14) == "ColorSequence" then
            local v15 = {};

            for _, v in ipairs(u14.Keypoints) do
                local Value = v.Value;
                local Color3_new_ret = Color3.new(1 - Value.R, 1 - Value.G, 1 - Value.B);
                v15[#v15 + 1] = ColorSequenceKeypoint.new(v.Time, Color3_new_ret);
            end;

            return ColorSequence.new(v15);
        end;
    end,

    grayscaleColor = function(u16) -- Line: 97, Name: grayscaleColor
        if typeof(u16) == "Color3" then
            u16 = u16:ToHex();
        end;

        if typeof(u16) == "string" then
            local success, result = pcall(function() -- Line: 103
                -- upvalues: u16 (ref)
                return Color3.fromHex(u16);
            end);

            if success then
                local v17 = (result.R + result.G + result.B) / 3;
                local Color3_new_ret = Color3.new(v17, v17, v17);

                return string.format("#%02X%02X%02X", math.round(Color3_new_ret.R * 255), math.round(Color3_new_ret.G * 255), (math.round(Color3_new_ret.B * 255)));
            end;
        elseif typeof(u16) == "ColorSequence" then
            local v18 = {};

            for _, v in ipairs(u16.Keypoints) do
                local Value = v.Value;
                local v19 = (Value.R + Value.G + Value.B) / 3;
                local Color3_new_ret = Color3.new(v19, v19, v19);
                v18[#v18 + 1] = ColorSequenceKeypoint.new(v.Time, Color3_new_ret);
            end;

            return ColorSequence.new(v18);
        end;
    end
};