-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local u1 = game:GetService("RunService"):IsStudio();
local u5 = {
    SendMessage = function(p2: string, p3: any) -- Line: 74, Name: SendMessage
        -- upvalues: HttpService (copy), u1 (copy)
        local v4 = HttpService:JSONEncode({
            command = p2,
            data = p3
        });

        if not u1 then
            print("[BloxstrapRPC] " .. v4);
        end;
    end
};

function u5.SendNotification(p6: string, p7: string, p8: number) -- Line: 87
    -- upvalues: u5 (copy)
    u5.SendMessage("SendNotification", {
        title = p6,
        message = p7,
        duration = p8
    });
end;

function u5.ShowPopup(p9: string, p10: string) -- Line: 97
    -- upvalues: u5 (copy)
    u5.SendMessage("ShowPopup", {
        title = p9,
        caption = p10
    });
end;

function GetFFlag(u11)
    local success, result = pcall(function() -- Line: 110
        -- upvalues: u11 (copy)
        return UserSettings():IsUserFeatureEnabled(u11);
    end);

    return success and result and result or false;
end;

local u12 = {};
local u13 = GetFFlag("UserAllowsWindowMovement");
u5.AllowsWindowMovement = u13;
local math_round = math.round;

function makeDiff(p14, p15)
    local v16 = {};

    for i, v in p15 do
        v16[i] = v;
    end;

    for i, v in p14 do
        if v16[i] == v then
            v16[i] = nil;
        end;
    end;

    return v16;
end;

function u5.SetWindow(p17: table) -- Line: 137
    -- upvalues: u13 (copy), u5 (copy), u12 (ref), math_round (copy)
    if not u13 then
        return;
    end;

    if p17.reset then
        u5.SendMessage("SetWindow", {
            reset = true
        });
        u12 = {};

        return;
    end;

    p17.reset = nil;

    for i, v in p17 do
        p17[i] = math_round(v);
    end;

    local v18 = makeDiff(u12, p17);

    if not next(v18) then
        return;
    end;

    u12 = p17;
    u5.SendMessage("SetWindow", v18);
end;

function u5.SetWindowRAW(p19: number, p20: number, p21: number, p22: number, p23: number?, p24: number?, p25: boolean?) -- Line: 160
    -- upvalues: u5 (copy), u12 (ref)
    if p25 then
        u5.SendMessage("SetWindow", {
            reset = true
        });
        u12 = {
            reset = true
        };

        return;
    end;

    local v26 = {};

    if p19 then
        p19 = math.round(p19);
    end;

    v26.x = p19;

    if p20 then
        p20 = math.round(p20);
    end;

    v26.y = p20;

    if p21 then
        p21 = math.round(p21);
    end;

    v26.width = p21;

    if p22 then
        p22 = math.round(p22);
    end;

    v26.height = p22;

    if p23 then
        p23 = math.round(p23);
    end;

    v26.scaleWidth = p23;

    if p24 then
        p24 = math.round(p24);
    end;

    v26.scaleHeight = p24;
    local v27 = makeDiff(u12, v26);

    if not next(v27) then
        return;
    end;

    u12 = v26;
    u5.SendMessage("SetWindow", v27);
end;

function u5.ShowWindow(p28: boolean) -- Line: 187
    -- upvalues: u5 (copy)
    u5.SendMessage("ShowWindow", {
        show = p28
    });
end;

function u5.RemoveWindows() -- Line: 193
    -- upvalues: u5 (copy)
    u5.SendMessage("RemoveWindows");
end;

function u5.CreateWindow(p29: table) -- Line: 197
    -- upvalues: u5 (copy)
    u5.SendMessage("MakeWindow", p29);
end;

function u5.RestoreWindow() -- Line: 201
    -- upvalues: u5 (copy), u12 (ref)
    u5.SendMessage("RestoreWindow");
    u12 = {
        reset = true
    };
end;

function u5.SetWindowDefault() -- Line: 206
    -- upvalues: u5 (copy)
    u5.SendMessage("SetWindowDefault");
end;

function u5.SetTitle(p30: string) -- Line: 211
    -- upvalues: u5 (copy)
    u5.SendMessage("SetWindowTitle", {
        Name = p30 or "Project: Afternight",
        name = p30 or "Project: Afternight"
    });
end;

function u5.ResetTitle() -- Line: 218
    -- upvalues: u5 (copy)
    u5.SendMessage("SetWindowTitle", {
        Name = "Project: Afternight",
        name = "Project: Afternight"
    });
end;

function u5.SetTransparency(p31: string, p32: number) -- Line: 225
    -- upvalues: u5 (copy)
    u5.SendMessage("SetWindowTransparency", {
        transparency = p32,
        color = p31
    });
end;

function u5.ResetTransparency() -- Line: 232
    -- upvalues: u5 (copy)
    u5.SendMessage("SetWindowTransparency", {
        transparency = 1
    });
end;

function u5.SetWindowColor(p33: table) -- Line: 238
    -- upvalues: u5 (copy)
    u5.SendMessage("SetWindowColor", p33);
end;

local u34 = 0;
local u35 = false;
local u36 = {};

function u5.SetRichPresence(u37: table, p38: boolean?) -- Line: 248
    -- upvalues: u35 (ref), u36 (copy), u34 (ref), u5 (copy)
    u35 = false;

    if u37.timeStart ~= nil then
        u37.timeStart = math.round(u37.timeStart);
    end;

    if u37.timeEnd ~= nil then
        u37.timeEnd = math.round(u37.timeEnd);
    end;

    for i, v in pairs(u37) do
        u36[i] = v;
    end;

    if tick() - u34 < 1 and not p38 then
        return task.delay(tick() - u34, function() -- Line: 265
            -- upvalues: u5 (ref), u37 (copy)
            u5.SetRichPresence(u37);
        end);
    end;

    u34 = tick();
    u5.SendMessage("SetRichPresence", u37);
end;

function u5.ResetRPC(p39: boolean?) -- Line: 274
    -- upvalues: u35 (ref), u5 (copy)
    if u35 and not p39 then
        return;
    end;

    u5.SetRichPresence({
        details = "Project: Afternight",
        state = "In game.",
        largeImage = {
            assetId = tonumber(script:GetAttribute("EngineLogo"))
        }
    }, p39);
    u35 = true;
end;

u5.ResetRPC(true);

return u5;