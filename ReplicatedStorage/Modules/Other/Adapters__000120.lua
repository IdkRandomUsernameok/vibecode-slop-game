-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {};
local u2 = {};
require(ReplicatedStorage.Modules.Signals.LocalSignals).APILoaded:Once(function(p3) -- Line: 7
    -- upvalues: u2 (ref)
    u2 = p3.textItemsScaling;
end);
local u4 = {
    rLeft = "Left",
    rUp = "Up",
    rRight = "Right",
    rDown = "Down",
    Left2 = "Left",
    Down2 = "Down",
    Right2 = "Right",
    Up2 = "Up",
    Square = "Up",
    Plus = "Up",
    rLeft2 = "Left",
    rUp2 = "Up",
    rRight2 = "Right",
    rDown2 = "Down"
};

function u1.convertNoteAnimToBase(p5) -- Line: 31
    -- upvalues: u4 (copy)
    return u4[p5] or p5;
end;

function u1.SecondsToMMSS(p6: number) -- Line: 35
    local math_floor_ret = math.floor(p6 + 0.5);
    local v7 = math_floor_ret % 60;
    local math_floor_ret2 = math.floor((math_floor_ret - v7) / 60);

    if v7 < 10 then
        v7 = "0" .. v7 or v7;
    end;

    return math_floor_ret2 .. ":" .. v7;
end;

function u1.vectorToRatio(p8, p9: number) -- Line: 42
    local X = p8.X;
    local Y = p8.Y;
    local math_round_ret = math.round(Y * p9);

    if X <= math_round_ret then
        return Vector2.new(X, (math.round(X / p9)));
    end;

    return Vector2.new(math_round_ret, Y);
end;

function u1.SecondsToMilliseconds(p10: number) -- Line: 55
    return math.floor(p10 * 1000);
end;

function u1.textScaledToNormal(p11: userdata, p12: number) -- Line: 59
    local Rotation = p11.Rotation;

    if p11.AbsoluteRotation ~= 0 then
        p11.Rotation = Rotation - p11.AbsoluteRotation;
    end;

    p11.TextScaled = false;
    p11.TextWrapped = true;
    local v13 = 1;
    local v14 = p12 or 100;
    local v15 = 1;

    while v13 <= v14 do
        v15 = (v13 + v14) // 2;
        p11.TextSize = v15;

        if p11.TextFits then
            v13 = v15 + 1;
        else
            v14 = v15 - 1;
        end;
    end;

    p11.TextWrapped = false;
    p11.TextSize = p11.TextSize - 1;
    p11.Rotation = Rotation;

    return v15 - 1;
end;

function u1.linkTextScaling(u16: userdata) -- Line: 92
    -- upvalues: u1 (copy), u2 (ref)
    if u16 then
        local ViewportSize = workspace.CurrentCamera.ViewportSize;
        local u17 = u1.textScaledToNormal(u16);
        local u18 = 1;
        local Size = u16.Size;
        local u19 = ViewportSize;

        local function updateText(p20, p21) -- Line: 103
            -- upvalues: u19 (ref), ViewportSize (copy), u16 (copy), u17 (copy), u18 (ref)
            if u19 == p20 and not p21 then
                return;
            end;

            u19 = p20;
            local v22 = p20 / ViewportSize;
            u16.TextSize = u17 * u18 * math.min(v22.X, v22.Y);
        end;

        local u23 = nil;

        local function unbind() -- Line: 112
            -- upvalues: u23 (ref), u2 (ref), u16 (copy)
            if u23 then
                u23:Disconnect();
                u23 = nil;
            end;

            u2[u16] = nil;
        end;

        u23 = u16:GetPropertyChangedSignal("Size"):Connect(function() -- Line: 117
            -- upvalues: u16 (copy), u18 (ref), Size (copy), u19 (ref), ViewportSize (copy), u17 (copy)
            local Size2 = u16.Size;
            u18 = math.min(Size2.X.Scale / Size.X.Scale, Size2.Y.Scale / Size.Y.Scale);
            local v24 = u19;
            local _ = u19 == v24;
            u19 = v24;
            local v25 = v24 / ViewportSize;
            u16.TextSize = u17 * u18 * math.min(v25.X, v25.Y);
        end);
        u2[u16] = updateText;
        u16.Destroying:Connect(unbind);

        return unbind;
    end;
end;

function u1.floatToString(p26) -- Line: 142
    if p26 % 1 == 0 then
        return p26 .. ".0";
    end;

    return p26;
end;

function u1.splitTitleCaps(p27) -- Line: 150
    local v28 = p27:gsub("(%u)", " %1"):gsub("^%s", "");

    return string.split(v28, " ");
end;

function u1.firstToUpper(p29) -- Line: 156
    return p29:gsub("^%l", string.upper);
end;

function u1.getTweenStyle(p30) -- Line: 160
    -- upvalues: u1 (copy)
    if p30 == nil or p30 == "" then
        return Enum.EasingStyle.Linear;
    end;

    if p30:lower() == "classic" then
        return Enum.EasingStyle.Quad;
    end;

    if p30:lower() == "instant" then
        return Enum.EasingStyle.Linear;
    end;

    local v31 = u1.splitTitleCaps(p30);

    if #v31 == 0 then
        return Enum.EasingStyle.Linear;
    end;

    local v32 = u1.firstToUpper(v31[1]);

    return Enum.EasingStyle:FromName(v32 == "Circ" and "Circular" or (v32 == "Expo" and "Exponential" or (v32 == "Cube" and "Cubic" or (v32 == "Ease" and "Back" or v32)))) or Enum.EasingStyle.Quad;
end;

function u1.getTweenDir(p33) -- Line: 182
    -- upvalues: u1 (copy)
    if p33 == nil or p33 == "" then
        return Enum.EasingDirection.InOut;
    end;

    if p33:lower() == "classic" then
        return Enum.EasingDirection.InOut;
    end;

    local v34 = u1.splitTitleCaps(p33);

    if #v34 <= 1 then
        return Enum.EasingDirection.InOut;
    end;

    local table_concat_ret = table.concat(v34, "", 2, #v34);

    return Enum.EasingDirection:FromName(table_concat_ret) or Enum.EasingDirection.InOut;
end;

local u35 = { "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine" };

function u1.numberToText(p36) -- Line: 195
    -- upvalues: u35 (copy)
    if tonumber(p36) then
        return u35[tonumber(p36)] or "Two";
    end;
end;

return u1;