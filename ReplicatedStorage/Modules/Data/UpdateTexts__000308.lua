-- Decompiled with Potassium's decompiler.

local u1 = { "Preparing something cool...", "Peak incoming...", "What is a Project: Afternight again?", "Oops!", "The next Project: Afternight Update is in [REDACTED]", "Spilling juice on the old server...", "Oops, all updates!" };
local u2 = { "Almost there...", "Should finish any moment now!", "The server is almost done!", "One step closer to playing!", "Downloading more RAM...", "Patience is a virtue (allegedly)" };

return function(p3) -- Line: 20
    -- upvalues: u1 (copy), u2 (copy)
    if p3 then
        return u1[math.random(1, #u1)];
    end;

    return p3 and "Bottom Text" or u2[math.random(1, #u2)];
end;