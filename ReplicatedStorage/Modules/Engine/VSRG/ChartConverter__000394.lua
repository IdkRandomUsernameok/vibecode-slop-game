-- Decompiled with Potassium's decompiler.

local v1 = {};
require(script.AFNFormat);

function v1.toAFN(p2) -- Line: 8
    if not p2.isAFN then
        return {
            scrollSpeed = 2.8,
            bpm = 120,
            offset = 0,
            isAFN = true,
            version = 1,
            strumLines = {},
            events = {},
            bpmMap = {},
            cameraMap = {},
            editorData = {
                patterns = {},
                regions = {}
            },
            noteTypes = {}
        };
    end;

    local _ = (p2.version or 1) < 1;

    return p2;
end;

function v1.resolveAFN() -- Line: 43
end;

return v1;