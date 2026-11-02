-- Decompiled with Potassium's decompiler.

local u1 = {
    pretty = false,
    robloxFullName = false,
    robloxProperFullName = true,
    robloxClassName = true,
    tabs = false,
    semicolons = false,
    spaces = 3,
    sortKeys = true
};
local u2 = {
    ["and"] = true,
    ["break"] = true,
    ["do"] = true,
    ["else"] = true,
    ["elseif"] = true,
    ["end"] = true,
    ["false"] = true,
    ["for"] = true,
    ["function"] = true,
    ["if"] = true,
    ["in"] = true,
    ["local"] = true,
    ["nil"] = true,
    ["not"] = true,
    ["or"] = true,
    ["repeat"] = true,
    ["return"] = true,
    ["then"] = true,
    ["true"] = true,
    ["until"] = true,
    ["while"] = true
};

local function isLuaIdentifier(p3) -- Line: 35
    -- upvalues: u2 (copy)
    if type(p3) ~= "string" then
        return false;
    end;

    if p3:len() == 0 then
        return false;
    end;

    if p3:find("[^%d%a_]") then
        return false;
    end;

    if tonumber(p3:sub(1, 1)) then
        return false;
    end;

    return not u2[p3];
end;

local function properFullName(p4, p5) -- Line: 49
    -- upvalues: u2 (copy), properFullName (copy)
    if p4 == nil or p4 == game then
        return "";
    end;

    local Name = p4.Name;
    local v6 = true;
    local v7;

    if type(Name) == "string" and (Name:len() ~= 0 and not (Name:find("[^%d%a_]") or tonumber(Name:sub(1, 1)))) then
        v7 = not u2[Name];
    else
        v7 = false;
    end;

    if not v7 then
        Name = ("[%q]"):format(Name);
        v6 = false;
    end;

    if p4.Parent and p4.Parent ~= game then
        return properFullName(p4.Parent) .. (v6 and "." or "") .. Name;
    end;

    return Name;
end;

local u8 = 0;
local u9 = nil;
local u10 = nil;

local function repr(p11, p12) -- Line: 71
    -- upvalues: u1 (copy), u10 (ref), u8 (ref), u9 (ref), repr (copy), u2 (copy), properFullName (copy)
    local v13 = p12 or u1;
    u10 = (" "):rep(v13.spaces or u1.spaces);

    if v13.tabs then
        u10 = "\t";
    end;

    local v14 = u10:rep(u8);

    if u8 == 0 then
        u9 = {};
    end;

    if type(p11) == "string" then
        return ("%q"):format(p11);
    end;

    if type(p11) == "number" then
        return p11 == (1 / 0) and "math.huge" or (p11 == (-1 / 0) and "-math.huge" or tonumber(p11));
    end;

    if type(p11) == "boolean" then
        return tostring(p11);
    end;

    if type(p11) == "nil" then
        return "nil";
    end;

    if type(p11) == "table" and type(p11.__tostring) == "function" then
        return tostring(p11.__tostring(p11));
    end;

    if type(p11) == "table" and getmetatable(p11) then
        local __tostring = getmetatable(p11).__tostring;

        if type(__tostring) == "function" then
            local __tostring2 = getmetatable(p11).__tostring;

            return tostring(__tostring2(p11));
        end;
    end;

    if type(p11) ~= "table" then
        if not typeof then
            return "<" .. type(p11) .. ">";
        end;

        if typeof(p11) == "Instance" then
            return (v13.robloxFullName and (v13.robloxProperFullName and properFullName(p11) or p11:GetFullName()) or p11.Name) .. (v13.robloxClassName and (" (%s)"):format(p11.ClassName) or "");
        end;

        if typeof(p11) == "Axes" then
            local v15 = {};

            if p11.X then
                table.insert(v15, repr(Enum.Axis.X, v13));
            end;

            if p11.Y then
                table.insert(v15, repr(Enum.Axis.Y, v13));
            end;

            if p11.Z then
                table.insert(v15, repr(Enum.Axis.Z, v13));
            end;

            return ("Axes.new(%s)"):format(table.concat(v15, ", "));
        end;

        if typeof(p11) == "BrickColor" then
            return ("BrickColor.new(%q)"):format(p11.Name);
        end;

        if typeof(p11) == "CFrame" then
            return ("CFrame.new(%s)"):format(table.concat({ p11:GetComponents() }, ", "));
        end;

        if typeof(p11) == "Color3" then
            return ("Color3.new(%d, %d, %d)"):format(p11.r, p11.g, p11.b);
        end;

        if typeof(p11) == "ColorSequence" then
            if #p11.Keypoints > 2 then
                return ("ColorSequence.new(%s)"):format(repr(p11.Keypoints, v13));
            end;

            if p11.Keypoints[1].Value == p11.Keypoints[2].Value then
                return ("ColorSequence.new(%s)"):format(repr(p11.Keypoints[1].Value, v13));
            end;

            return ("ColorSequence.new(%s, %s)"):format(repr(p11.Keypoints[1].Value, v13), repr(p11.Keypoints[2].Value, v13));
        end;

        if typeof(p11) == "ColorSequenceKeypoint" then
            return ("ColorSequenceKeypoint.new(%d, %s)"):format(p11.Time, repr(p11.Value, v13));
        end;

        if typeof(p11) == "DockWidgetPluginGuiInfo" then
            return ("DockWidgetPluginGuiInfo.new(%s, %s, %s, %s, %s, %s, %s)"):format(repr(p11.InitialDockState, v13), repr(p11.InitialEnabled, v13), repr(p11.InitialEnabledShouldOverrideRestore, v13), repr(p11.FloatingXSize, v13), repr(p11.FloatingYSize, v13), repr(p11.MinWidth, v13), repr(p11.MinHeight, v13));
        end;

        if typeof(p11) == "Enums" then
            return "Enums";
        end;

        if typeof(p11) == "Enum" then
            return ("Enum.%s"):format((tostring(p11)));
        end;

        if typeof(p11) == "EnumItem" then
            return ("Enum.%s.%s"):format(tostring(p11.EnumType), p11.Name);
        end;

        if typeof(p11) == "Faces" then
            local v16 = {};

            for _, v in pairs(Enum.NormalId:GetEnumItems()) do
                if p11[v.Name] then
                    table.insert(v16, repr(v, v13));
                end;
            end;

            return ("Faces.new(%s)"):format(table.concat(v16, ", "));
        end;

        if typeof(p11) == "NumberRange" then
            if p11.Min == p11.Max then
                return ("NumberRange.new(%d)"):format(p11.Min);
            end;

            return ("NumberRange.new(%d, %d)"):format(p11.Min, p11.Max);
        end;

        if typeof(p11) == "NumberSequence" then
            if #p11.Keypoints > 2 then
                return ("NumberSequence.new(%s)"):format(repr(p11.Keypoints, v13));
            end;

            if p11.Keypoints[1].Value == p11.Keypoints[2].Value then
                return ("NumberSequence.new(%d)"):format(p11.Keypoints[1].Value);
            end;

            return ("NumberSequence.new(%d, %d)"):format(p11.Keypoints[1].Value, p11.Keypoints[2].Value);
        end;

        if typeof(p11) == "NumberSequenceKeypoint" then
            if p11.Envelope == 0 then
                return ("NumberSequenceKeypoint.new(%d, %d)"):format(p11.Time, p11.Value);
            end;

            return ("NumberSequenceKeypoint.new(%d, %d, %d)"):format(p11.Time, p11.Value, p11.Envelope);
        end;

        if typeof(p11) == "PathWaypoint" then
            return ("PathWaypoint.new(%s, %s)"):format(repr(p11.Position, v13), repr(p11.Action, v13));
        end;

        if typeof(p11) == "PhysicalProperties" then
            return ("PhysicalProperties.new(%d, %d, %d, %d, %d)"):format(p11.Density, p11.Friction, p11.Elasticity, p11.FrictionWeight, p11.ElasticityWeight);
        end;

        if typeof(p11) == "Random" then
            return "<Random>";
        end;

        if typeof(p11) == "Ray" then
            return ("Ray.new(%s, %s)"):format(repr(p11.Origin, v13), repr(p11.Direction, v13));
        end;

        if typeof(p11) == "RBXScriptConnection" then
            return "<RBXScriptConnection>";
        end;

        if typeof(p11) == "RBXScriptSignal" then
            return "<RBXScriptSignal>";
        end;

        if typeof(p11) == "Rect" then
            return ("Rect.new(%d, %d, %d, %d)"):format(p11.Min.X, p11.Min.Y, p11.Max.X, p11.Max.Y);
        end;

        if typeof(p11) == "Region3" then
            local v17 = p11.CFrame.p + p11.Size * 0.5;

            return ("Region3.new(%s, %s)"):format(repr(p11.CFrame.p + p11.Size * -0.5, v13), repr(v17, v13));
        end;

        if typeof(p11) == "Region3int16" then
            return ("Region3int16.new(%s, %s)"):format(repr(p11.Min, v13), repr(p11.Max, v13));
        end;

        if typeof(p11) == "TweenInfo" then
            return ("TweenInfo.new(%d, %s, %s, %d, %s, %d)"):format(p11.Time, repr(p11.EasingStyle, v13), repr(p11.EasingDirection, v13), p11.RepeatCount, repr(p11.Reverses, v13), p11.DelayTime);
        end;

        if typeof(p11) == "UDim" then
            return ("UDim.new(%d, %d)"):format(p11.Scale, p11.Offset);
        end;

        if typeof(p11) == "UDim2" then
            return ("UDim2.new(%d, %d, %d, %d)"):format(p11.X.Scale, p11.X.Offset, p11.Y.Scale, p11.Y.Offset);
        end;

        if typeof(p11) == "Vector2" then
            return ("Vector2.new(%d, %d)"):format(p11.X, p11.Y);
        end;

        if typeof(p11) == "Vector2int16" then
            return ("Vector2int16.new(%d, %d)"):format(p11.X, p11.Y);
        end;

        if typeof(p11) == "Vector3" then
            return ("Vector3.new(%d, %d, %d)"):format(p11.X, p11.Y, p11.Z);
        end;

        if typeof(p11) == "Vector3int16" then
            return ("Vector3int16.new(%d, %d, %d)"):format(p11.X, p11.Y, p11.Z);
        end;

        if typeof(p11) == "DateTime" then
            return ("DateTime.fromIsoDate(%q)"):format(p11:ToIsoDate());
        end;

        return "<Roblox:" .. typeof(p11) .. ">";
    end;

    if u9[p11] then
        return "{CYCLIC}";
    end;

    u9[p11] = true;
    local v18 = "{" .. (v13.pretty and ("\n" .. u10 .. v14 or "") or "");
    local v19 = 0;
    local v20 = true;

    for i, _ in pairs(p11) do
        v19 = v19 + 1;

        if type(i) ~= "number" then
            v20 = false;
            break;
        end;
    end;

    if #p11 ~= v19 then
        v20 = false;
    end;

    if v20 then
        for i = 1, #p11 do
            if i ~= 1 then
                v18 = v18 .. (v13.semicolons and ";" or ",") .. (v13.pretty and ("\n" .. u10 .. v14 or " ") or " ");
            end;

            u8 = u8 + 1;
            v18 = v18 .. repr(p11[i], v13);
            u8 = u8 - 1;
            local _ = i;
        end;
    else
        local v21 = {};
        local v22 = {};

        for i, v in pairs(p11) do
            u8 = u8 + 1;
            local v23;

            if type(i) == "string" and (i:len() ~= 0 and not (i:find("[^%d%a_]") or tonumber(i:sub(1, 1)))) then
                v23 = not u2[i];
            else
                v23 = false;
            end;

            local v24 = v23 and i and i or "[" .. repr(i, v13) .. "]";
            local v25 = repr(v, v13);
            table.insert(v21, v24);
            v22[v24] = v25;
            u8 = u8 - 1;
        end;

        if v13.sortKeys then
            table.sort(v21);
        end;

        local v26 = true;

        for _, v in pairs(v21) do
            if not v26 then
                v18 = v18 .. (v13.semicolons and ";" or ",") .. (v13.pretty and ("\n" .. u10 .. v14 or " ") or " ");
            end;

            v18 = v18 .. ("%s = %s"):format(v, v22[v]);
            v26 = false;
        end;
    end;

    u9[p11] = false;

    if v13.pretty then
        v18 = v18 .. "\n" .. v14;
    end;

    return v18 .. "}";
end;

return repr;