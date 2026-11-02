-- Decompiled with Potassium's decompiler.

local u1 = {};

function u1.createGameActivity(p2) -- Line: 3
    -- upvalues: u1 (copy)
    local PLAYING = u1.ActivityType.PLAYING;

    if p2.type ~= nil then
        PLAYING = p2.type;
    end;

    return {
        platform = "desktop",
        type = PLAYING,
        state = p2.state or "In Game",
        details = p2.details or "Playing",
        assets = p2.assets or nil,
        timestamps = p2.timestamps or nil,
        party = p2.party or nil,
        secret = p2.secret or nil
    };
end;

u1.ActivityType = {
    PLAYING = 0,
    STREAMING = 1,
    LISTENING = 2,
    WATCHING = 3,
    COMPETING = 5
};

return u1;