-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = "Inactive";
local u3 = 0;
local u4 = {
    Inactive = "rbxassetid://118051097903087",
    Judging = "rbxassetid://95769685854266",
    Active = "rbxassetid://131837939153017",
    Active_R = "rbxassetid://133875903097717",
    Active_L = "rbxassetid://93294038806167",
    Inactive_R = "rbxassetid://128327244404198",
    Inactive_L = "rbxassetid://86897804930649"
};
local u7 = {
    ForceState = function(p5) -- Line: 18, Name: ForceState
        -- upvalues: u1 (ref), u4 (copy), u2 (ref)
        u1.Image = u4[p5];
        u2 = p5;
    end,

    GetState = function() -- Line: 23, Name: GetState
        -- upvalues: u2 (ref)
        if u2 == "Active_R" or (u2 == "Active_L" or u2 == "Dizzy") then
            u2 = "Active";
        elseif u2 == "Inactive_R" or (u2 == "Inactive_L" or u2 == "Judging") then
            u2 = "Inactive";
        end;

        return u2;
    end,

    SetOtto = function(p6) -- Line: 32, Name: SetOtto
        -- upvalues: u1 (ref)
        u1 = p6;
    end
};

function u7.InactiveTap() -- Line: 36
    -- upvalues: u3 (ref), u7 (copy)
    u3 = u3 + 1;
    local u8 = u3;

    if u3 % 2 == 0 then
        u7.ForceState("Inactive_R");
    else
        u7.ForceState("Inactive_L");
    end;

    task.delay(0.3333333333333333, function() -- Line: 46
        -- upvalues: u8 (copy), u3 (ref), u7 (ref)
        if u8 == u3 and u7.GetState() ~= "Active" then
            u7.ForceState("Inactive");
        end;
    end);
end;

function u7.Tap(p9) -- Line: 59
    -- upvalues: u3 (ref), u7 (copy)
    u3 = u3 + 1;
    local u10 = u3;

    if u3 % 2 == 0 then
        u7.ForceState("Active_R");
    else
        u7.ForceState("Active_L");
    end;

    task.delay(0.3333333333333333, function() -- Line: 73
        -- upvalues: u10 (copy), u3 (ref), u7 (ref)
        if u10 == u3 and u7.GetState() ~= "Inactive" then
            u7.ForceState("Active");
        end;
    end);
end;

function u7.GetOtto() -- Line: 80
    -- upvalues: u1 (ref)
    return u1;
end;

function u7.Miss() -- Line: 84
    -- upvalues: u7 (copy)
    u7.ForceState("Judging");
    task.delay(0.5, function() -- Line: 87
        -- upvalues: u7 (ref)
        u7.ForceState("Inactive");
    end);
end;

return u7;