-- Decompiled with Potassium's decompiler.

local u1 = {};

local function u2() -- Line: 3
end;

u1.width = 1280;
u1.height = u1.width / 1.7777777777777777;
u1.x = 960 - u1.width / 2;
u1.y = 540 - u1.height / 2;
local u3 = {
    L = nil,
    R = nil
};
local u4 = {
    L = nil,
    R = nil
};
u1.WindowData = {
    width = u1.width,
    height = u1.height,
    x = u1.x,
    y = u1.y
};
u1.StartWindow = false;
u1.StartResize = false;

function u1.enableWindowTransparency(p5, p6, p7) -- Line: 35
    -- upvalues: u3 (copy), u4 (copy)
    local v8 = not p7;
    local v9;

    if v8 then
        v9 = false;
    else
        v9 = u3.L or false;
    end;

    p6.setSetting("L", "Notesplashes", v9);
    local v10;

    if v8 then
        v10 = false;
    else
        v10 = u3.R or false;
    end;

    p6.setSetting("R", "Notesplashes", v10);
    local v11 = v8 and {
        L = 1,
        R = 1
    } or (u4 or {
        L = 1,
        R = 1
    });

    for _, v in p6.Notes do
        if v.strumTime >= 134500 then
            break;
        end;

        if v.sustainNote then
            v.offsets.set("alpha", "sustainTransparency", v11 and (v11[v.side] or 1) or 1);
        end;
    end;

    for _, v in p6.UnspawnNotes do
        if v.strumTime >= 134500 then
            break;
        end;

        if v.sustainNote then
            v.offsets.set("alpha", "sustainTransparency", v11 and (v11[v.side] or 1) or 1);
        end;
    end;

    p6.setSetting("L", "SustainTransparency", v8 and 1 or u4.L);
    p6.setSetting("R", "SustainTransparency", v8 and 1 or u4.R);

    for _, v in p6.Strumlines do
        v:setLaneTransparency(v8 and 0 or 1);
    end;

    p6.setWindowTransparency("0x" .. Color3.fromRGB(0, 255, 0):ToHex(), v8 and 0 or 1);
end;

function u1.setWindowData(p12, p13) -- Line: 86
    -- upvalues: u1 (copy)
    u1.WindowData.x = p12;
    u1.WindowData.y = p13;
end;

function u1.onCreate(p14) -- Line: 91
    -- upvalues: u3 (copy), u4 (copy), u2 (ref)
    u3.L = p14.getSetting("L", "Notesplashes");
    u3.R = p14.getSetting("R", "Notesplashes");
    u4.L = p14.getSetting("L", "SustainTransparency");
    u4.R = p14.getSetting("R", "SustainTransparency");
    u2 = p14.setWindow;
    p14.initWindow();
end;

function u1.onUpdate(p15) -- Line: 101
    -- upvalues: u1 (copy), u2 (ref)
    if u1.StartWindow then
        u1.WindowData.x = u1.x;
        u1.WindowData.y = u1.y;
    elseif u1.StartResize then
        u1.WindowData.width = 1280;
        u1.WindowData.height = 720;
        u1.WindowData.x = u1.x;
        u1.WindowData.y = u1.y;
    end;

    u2(u1.WindowData.x, u1.WindowData.y, u1.WindowData.width, u1.WindowData.height, 1920, 1080);
end;

return u1;