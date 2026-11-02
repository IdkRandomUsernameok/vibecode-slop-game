-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {};
local u2 = {};
local u3 = {};
task.spawn(function() -- Line: 11
    -- upvalues: u3 (copy), u2 (copy)
    while task.wait(3) do
        for i, v in u3 do
            if not next(v) then
                local u4 = u2[i];

                if u4 then
                    task.delay(1, function() -- Line: 18
                        -- upvalues: u3 (ref), i (copy), u2 (ref), u4 (copy)
                        if u3[i] then
                            return;
                        end;

                        u2[i] = nil;
                        u4:Destroy();
                    end);
                end;

                u3[i] = nil;
            end;
        end;
    end;
end);
local u5 = {
    __mode = "v"
};

function makeWeak(p6)
    -- upvalues: u5 (copy)
    return setmetatable({ p6 }, u5);
end;

local Signal = require(ReplicatedStorage.Modules.Lib.Signal);

function getPointerId(p7)
    if type(p7) == "string" then
        return p7;
    end;

    return `{p7.pack or ""}{p7.name}`;
end;

function getArgsId(p8: table?)
    if not (p8 and next(p8)) then
        return "";
    end;
end;

function getLocalContent(p9: userdata, p10: any, p11: table?)
end;

function u1.from(p12: userdata, p13: any, p14: table?) -- Line: 76
    -- upvalues: u3 (copy), u2 (copy), Signal (copy), u1 (copy)
    local v15 = `Asset_{p12}_{getPointerId(p13)}:{getArgsId(p14)}`;
    local v16 = u3[v15] and u3[v15][1];

    if v16 then
        return v16;
    end;

    local v17 = u2[v15];
    local v18;

    if v17 then
        v18 = false;
    else
        v17 = getLocalContent(p12, p13, p14);
        v18 = v17 and true or false;
    end;

    local v19 = {
        beingLoaded = false,
        isLoaded = v18,
        content = v17,
        isLocal = v18,
        __onLoadQueue = {},
        __onGC = Signal.new(),
        __uid = v15
    };
    local v20 = setmetatable(v19, u1);
    u3[v15] = makeWeak(v20);

    return v20;
end;

for i, _ in {
    Animation = true,
    Banner = true,
    Emote = true,
    Icon = true,
    Noteskin = true,
    Notesplash = true,
    Holdsplash = true,
    Tag = true,
    Countdown = true,
    NoteType = true,
    Rating = true
} do
    u1[i:lower()] = function(p21: any, p22: table?) -- Line: 110
        -- upvalues: u1 (copy), i (copy)
        return u1.from(i, p21, p22);
    end;
end;

function u1.with(p23: userdata, p24: function) -- Line: 117
    if p23.isLoaded then
        return p24();
    end;

    p23.__onLoadQueue[p24] = true;
end;

function u1.load(p25: userdata) -- Line: 126
    if p25.isLoaded or p25.beingLoaded then
        return;
    end;

    p25.beingLoaded = true;
end;

function u1.get(p26: userdata) -- Line: 136
    if not p26.isLoaded then
        p26:load();
    end;

    return p26.content;
end;

function u1.__tostring(p27: userdata) -- Line: 142
    return p27.__uid;
end;

return u1;