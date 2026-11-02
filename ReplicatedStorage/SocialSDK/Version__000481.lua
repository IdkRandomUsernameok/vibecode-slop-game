-- Decompiled with Potassium's decompiler.

local v1 = {
    VERSION = "1.0.3",
    BUILD_DATE = "2026-06-25 20:13:20 UTC",
    BUILD_TIMESTAMP = 1782418400
};
v1.Components = (function(p2: string) -- Line: 17, Name: parseVersion
    local v3, v4, v5, v6 = p2:match("^v?(%d+)%.(%d+)%.(%d+)(.*)$");

    if not v3 then
        return {
            major = 1,
            minor = 0,
            patch = 0,
            prerelease = p2
        };
    end;

    local v7 = {
        major = tonumber(v3) or 1,
        minor = tonumber(v4) or 0,
        patch = tonumber(v5) or 0
    };

    if not (v6 and (v6 ~= "" and v6)) then
        v6 = nil;
    end;

    v7.prerelease = v6;

    return v7;
end)(v1.VERSION);

function v1.GetVersion(p8) -- Line: 42
    return p8.VERSION;
end;

function v1.GetBuildDate(p9) -- Line: 46
    return p9.BUILD_DATE;
end;

function v1.GetBuildTimestamp(p10) -- Line: 50
    return p10.BUILD_TIMESTAMP;
end;

function v1.GetMajor(p11) -- Line: 54
    return p11.Components.major;
end;

function v1.GetMinor(p12) -- Line: 58
    return p12.Components.minor;
end;

function v1.GetPatch(p13) -- Line: 62
    return p13.Components.patch;
end;

function v1.GetPrerelease(p14) -- Line: 66
    return p14.Components.prerelease;
end;

function v1.IsPrerelease(p15) -- Line: 70
    return p15.Components.prerelease ~= nil;
end;

function v1.ToString(p16) -- Line: 74
    return string.format("Discord Roblox SDK %s (built %s)", p16.VERSION, p16.BUILD_DATE);
end;

function v1.ToTable(p17) -- Line: 78
    return {
        version = p17.VERSION,
        buildDate = p17.BUILD_DATE,
        buildTimestamp = p17.BUILD_TIMESTAMP,
        components = p17.Components
    };
end;

return v1;