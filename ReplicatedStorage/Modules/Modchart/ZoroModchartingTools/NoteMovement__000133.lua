-- Decompiled with Potassium's decompiler.

local v1 = {
    keyCount = 4,
    playerKeyCount = 4,
    totalKeyCount = 8,
    arrowScale = 0.7,
    arrowSize = 112,
    defaultStrumX = {},
    defaultStrumY = {},
    defaultScale = {},
    arrowSizes = {}
};
local ModchartUtil = require(script.Parent.ModchartUtil);

function v1.getDefaultStrumPos(p2, p3) -- Line: 15
    p2.defaultStrumX = {};
    p2.defaultStrumY = {};
    p2.defaultScale = {};
    p2.arrowSizes = {};
    local KeyData = p3.getKeyData();
    p2.keyCount = KeyData.leftKeyCount;
    p2.playerKeyCount = KeyData.rightKeyCount;
    p2.totalKeyCount = KeyData.totalKeys;

    for i, v in p3.Strums do
        p2.defaultStrumX[i] = v.x;
        p2.defaultStrumY[i] = v.y;
        p2.defaultScale[i] = v.scale.x;
        p2.arrowSizes[i] = 160 * v.scale.x;
    end;
end;

v1.getDefaultStrumPosEditor = v1.getDefaultStrumPos;

function v1.setNotePath(p4: table, p5: userdata, p6: number, p7: number, p8: number, p9: number, p10: number, p11: number) -- Line: 36
    -- upvalues: ModchartUtil (copy)
    p5.x = p4.defaultStrumX[p6];
    p5.y = p4.defaultStrumY[p6];
    p5.z = 0;
    local CartesianCoords3D = ModchartUtil:getCartesianCoords3D(p10, p11, p8 * p9);
    p5.y = p5.y + CartesianCoords3D.y;
    p5.x = p5.x + CartesianCoords3D.x;
    p5.z = p5.z + CartesianCoords3D.z;
end;

function v1.getLaneDiffFromCenter(p12: table, p13: userdata) -- Line: 47
    local v14 = p13 % 4;

    if v14 + 1 > p12.keyCount * 0.5 then
        return v14 - (p12.keyCount * 0.5 + 1);
    end;

    return v14 - p12.keyCount * 0.5;
end;

return v1;