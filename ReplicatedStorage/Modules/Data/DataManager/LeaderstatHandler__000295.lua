-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = nil;
local u3 = {};
local u4 = { "k", "M", "B", "T", "qd", "Qn", "sx", "Sp", "O", "N", "de", "Ud", "DD", "tdD", "qdD", "QnD", "sxD", "SpD", "OcD", "NvD", "Vgn", "UVg", "DVg", "TVg", "qtV", "QnV", "SeV", "SPG", "OVG", "NVG", "TGN", "UTG", "DTG", "tsTG", "qtTG", "QnTG", "ssTG", "SpTG", "OcTG", "NoTG", "QdDR", "uQDR", "dQDR", "tQDR", "qdQDR", "QnQDR", "sxQDR", "SpQDR", "OQDDr", "NQDDr", "qQGNT", "uQGNT", "dQGNT", "tQGNT", "qdQGNT", "QnQGNT", "sxQGNT", "SpQGNT", "OQQGNT", "NQQGNT", "SXGNTL" };

function shortenNumber(p5)
    -- upvalues: u4 (copy)
    local math_abs_ret = math.abs(p5);
    local v6 = false;

    for i, _ in u4 do
        if 10 ^ (3 * i) > math_abs_ret then
            local v7 = math_abs_ret / 10 ^ (3 * (i - 1));
            local string_find_ret = string.find(tostring(v7), ".");

            if string_find_ret then
                local v8 = tostring(v7);
                string_find_ret = string.sub(v8, 4, 4) ~= ".";
            end;

            local v9 = tostring(v7);
            math_abs_ret = string.sub(v9, 1, string_find_ret and 4 or 3) .. (u4[i - 1] or "");
            v6 = true;
            break;
        end;
    end;

    if not v6 then
        local math_floor_ret = math.floor(math_abs_ret);
        math_abs_ret = tostring(math_floor_ret);
    end;

    if p5 < 0 then
        return "-" .. math_abs_ret;
    end;

    return math_abs_ret;
end;

function u1.Create(p10: string, p11: userdata, p12: function) -- Line: 46
    -- upvalues: u3 (copy), u1 (copy)
    if u3[p11] and u3[p11][p10] then
        return u3[p11][p10];
    end;

    if not u3[p11] then
        u3[p11] = {};
    end;

    local v13 = {
        Name = p10,
        Player = p11,
        UpdateCallback = typeof(p12) == "function" and p12 and p12 or nil
    };
    setmetatable(v13, {
        __index = u1
    });
    local StringValue = Instance.new("StringValue");

    if typeof(p12) == "function" then
        p12 = p12(p11) or p12;
    end;

    StringValue:SetAttribute("RealValue", p12);
    StringValue.Value = shortenNumber((tonumber(p12)));
    v13.Self = StringValue;
    v13.Self.Name = p10;
    u3[p11][p10] = v13;

    return v13;
end;

function u1.Update(p14) -- Line: 75
    -- upvalues: u2 (ref)
    if not (p14.Player and p14.Player.Parent) then
        return;
    end;

    if not p14.Self then
        return;
    end;

    if p14.UpdateCallback then
        local v15 = p14.UpdateCallback(p14.Player);
        p14.Self:SetAttribute("RealValue", v15);
        p14.Self.Value = shortenNumber((tonumber(v15)));

        return;
    end;

    if not u2 then
        return;
    end;

    local Profile = u2:GetProfile(p14.Player);

    if not Profile then
        return;
    end;

    if Profile.Data.Stats[p14.Name] then
        p14.Self:SetAttribute("RealValue", Profile.Data.Stats[p14.Name]);
        p14.Self.Value = shortenNumber((tonumber(Profile.Data.Stats[p14.Name])));
    end;
end;

function u1.GetLeaderstat(p16: userdata, p17: string) -- Line: 107
    -- upvalues: u3 (copy)
    if u3[p16] and u3[p16][p17] then
        return u3[p16][p17];
    end;

    if u3[p16] and p17 == "ALL" then
        return u3[p16];
    end;

    return nil;
end;

function u1.GiveDataManager(p18) -- Line: 123
    -- upvalues: u2 (ref)
    u2 = p18;
end;

return u1;