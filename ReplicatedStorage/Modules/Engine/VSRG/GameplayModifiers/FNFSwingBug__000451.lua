-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();
local u1 = 1;
local u2 = nil;
local u3 = nil;
local u4 = 1;
local u5 = false;

function resync()
    -- upvalues: Api (copy), u5 (ref), u2 (ref), u1 (ref), u3 (ref)
    local _ = Api.Conductor.RawTimePosition;
    u5 = not u5;
    u2.Volume = u5 and 0 or u1;
    u3.Volume = u5 and u1 or 0;

    if u5 then
        local v6 = u2;
        v6.TimePosition = v6.TimePosition + 0.15;

        return;
    end;

    local v7 = u3;
    v7.TimePosition = v7.TimePosition + 0.15;
end;

return {
    onCreate = function() -- Line: 41, Name: onCreate
        -- upvalues: Api (copy), u1 (ref), u4 (ref), u2 (ref), u3 (ref)
        local v8 = Api.getAudioInstances()[1];
        u1 = v8.Volume;
        u4 = Api.Conductor.Crochet / 1000;
        u2 = v8;
        u3 = v8:Clone();
        u3.Parent = v8.Parent;
    end,

    onUpdate = function() -- Line: 51, Name: onUpdate
        -- upvalues: Api (copy), u5 (ref), u3 (ref), u2 (ref)
        Api.Conductor.setSongPos(u5 and u3.TimePosition or u2.TimePosition);
    end,

    onLoad = function() -- Line: 55, Name: onLoad
        -- upvalues: u3 (ref)
        u3.TimePosition = 0.15;
        u3:Resume();
    end,

    clearUp = function() -- Line: 60, Name: clearUp
        -- upvalues: u3 (ref)
        if u3 then
            u3:Destroy();
        end;
    end,

    onBeatHit = function() -- Line: 63, Name: onBeatHit
        resync();
    end
};