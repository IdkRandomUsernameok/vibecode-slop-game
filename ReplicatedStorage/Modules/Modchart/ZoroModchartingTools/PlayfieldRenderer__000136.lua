-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = nil;
local ModTable = require(script.Parent.ModTable);
local Playfield = require(script.Parent.Playfield);
local NoteMovement = require(script.Parent.NoteMovement);
local ModchartUtil = require(script.Parent.ModchartUtil);
local Modifiers = require(script.Parent.Modifiers);
local ModchartEventManager = require(script.Parent.ModchartEventManager);
local ModchartFuncs = require(script.Parent.ModchartFuncs);

local function getStrumDistanceFromTime(p3) -- Line: 16
    -- upvalues: u2 (ref), ModchartUtil (copy)
    return (u2.SongPosition - p3) * ModchartUtil:getScrollSpeed();
end;

local function point_direction(p4, p5, p6, p7) -- Line: 20
    local math_atan2_ret = math.atan2(p5 - p7, p4 - p6);

    return -math.deg(math_atan2_ret) + 180;
end;

function u1.new(p8, p9, p10) -- Line: 24
    -- upvalues: u2 (ref), ModTable (copy), Modifiers (copy), ModchartUtil (copy), ModchartEventManager (copy), ModchartFuncs (copy), u1 (copy)
    u2 = p8.Conductor;
    ModTable.Init(p8);
    Modifiers.Init(p8);
    ModchartUtil.Init(p8);
    ModchartEventManager.Init(p8);
    ModchartFuncs.Init(p8);
    local v11 = {
        strumGroup = p9 or p8.Strums,
        notes = p10 or p8.Notes,
        speed = p8.playbackRate or 1,
        playfields = {},
        eventManager = ModchartEventManager.new(),
        customModifiers = {}
    };
    local v12 = setmetatable(v11, {
        __index = u1
    });
    v12.modifierTable = ModTable.new(nil, v12);
    v12.apiManager = ModchartFuncs.new(v12);
    v12:addNewPlayfield(0, 0, 0);

    return v12;
end;

function u1.addCustomModifier(p13, p14, p15) -- Line: 50
    p13.customModifiers[p14] = p15;
end;

function u1.getApi(p16) -- Line: 54
    return p16.apiManager.api;
end;

function u1.getCorrectScrollSpeed(p17) -- Line: 58
    -- upvalues: ModchartUtil (copy)
    return ModchartUtil:getScrollSpeed();
end;

function u1.addNewPlayfield(p18, p19, p20, p21, p22) -- Line: 62
    -- upvalues: Playfield (copy)
    p18.playfields[p18.playfields[0] and (#p18.playfields + 1 or 0) or 0] = Playfield.new(p19, p20, p21, p22);
end;

function u1.update(p23, p24) -- Line: 67
    p23.eventManager:update();
    p23:draw();
end;

local u25 = ModchartUtil.defaultFOV * 0.017453292519943295;

function u1.draw(p26) -- Line: 74
    -- upvalues: ModchartUtil (copy), NoteMovement (copy), u25 (copy), u2 (ref)
    local ScrollSpeed = ModchartUtil:getScrollSpeed();
    local v27 = {};

    for i, _ in p26.playfields do
        local v28 = i;

        for i2 = 0, NoteMovement.totalKeyCount - 1 do
            local v29 = p26.strumGroup[i2];
            local v30;

            if v28 == 0 then
                v30 = v29;
            else
                v30 = v29.copies[v28];

                if not v30 then
                    v30 = v29:Copy(true);
                    v29.copies[v28] = v30;
                end;
            end;

            local DataForStrum = p26:getDataForStrum(i2, v28);
            local v31;

            if DataForStrum.alpha <= 0 then
                v30.alpha = 0;
                v31 = i2;
            else
                local v32 = ModchartUtil:calculatePerspective({
                    x = DataForStrum.x + 54.25,
                    y = DataForStrum.y + 54.25,
                    z = DataForStrum.z * 0.001
                }, u25, -54.25, -54.25);
                DataForStrum.x = v32.x;
                DataForStrum.y = v32.y;
                DataForStrum.scaleX = DataForStrum.scaleX * (1 / -v32.z);
                DataForStrum.scaleY = DataForStrum.scaleY * (1 / -v32.z);
                v27[DataForStrum.index] = v32.z;
                DataForStrum.zindex = 4;
                p26:addDataToStrum(DataForStrum, v30);
                v31 = i2;
            end;
        end;

        for _, v in p26.notes do
            if v.active then
                local v33;

                if v28 == 0 then
                    v33 = v;
                else
                    v33 = v.copies[v28];

                    if not v33 then
                        v33 = v:Copy(true);
                        v.copies[v28] = v33;
                    end;
                end;

                local v34 = getLane(v33);
                local NoteDist = p26:getNoteDist(v34);
                local v35 = p26.modifierTable:applyNoteDistMods(NoteDist, v34, v28);
                local v36 = (u2.SongPosition - v33.strumTime) * ModchartUtil:getScrollSpeed();
                local v37 = p26.modifierTable:applyCurPosMods(v34, v36, v28);
                local v38 = p26.modifierTable:applyIncomingAngleMods(v34, v37, v28);

                if v35 < 0 then
                    v38[1] = v38[1] + 180;
                end;

                NoteMovement:setNotePath(v33, v34, ScrollSpeed, v37, v35, v38[1], v38[2]);
                local v39 = p26:createDataFromNote(v33, v28, v37, v35, v38);
                p26.modifierTable:applyNoteMods(v39, v34, v37, v28);

                if v39.alpha <= 0 then
                    v33.alpha = 0;
                else
                    local v40 = 155 * v39.scaleX / 2;
                    local v41 = 155 * v39.scaleY / 2;
                    local v42 = ModchartUtil:calculatePerspective({
                        x = v39.x + v40,
                        y = v39.y + v41,
                        z = v39.z * 0.001
                    }, u25, -v40, -v41);
                    v39.x = v42.x;
                    v39.y = v42.y;
                    v39.scaleX = v39.scaleX * (1 / -v42.z);

                    if v42.z >= (v27[v34] or v42.z) then
                        v39.zindex = 5;
                    else
                        v39.zindex = 3;
                    end;

                    if v.sustainNote then
                        local v43 = (u2.SongPosition - (v.isEnd and v.endPixelTime or v.susEndTime)) * ModchartUtil:getScrollSpeed();
                        local v44 = p26.modifierTable:applyCurPosMods(v34, v43, v28);
                        local v45 = p26.modifierTable:applyIncomingAngleMods(v34, v44, v28);

                        if v35 < 0 then
                            v45[1] = v45[1] + 180;
                        end;

                        NoteMovement:setNotePath(v33, v34, ScrollSpeed, v44, v35, v45[1], v45[2]);
                        local v46 = p26:createDataFromNote(v33, v28, v44, v35, v45);
                        p26.modifierTable:applyNoteMods(v46, v34, v44, v28);
                        local v47 = ModchartUtil:calculatePerspective({
                            x = v46.x + v40,
                            y = v46.y + v41,
                            z = v46.z * 0.001
                        }, u25, -v40, -v41);
                        v46.x = v47.x;
                        v46.y = v47.y;
                        v33.useAngleAnchor = true;
                        v33.angleAnchor = Vector2.new(0.5, 0);
                        local v48 = v.isEnd and 0.7 * (1 / -v47.z) or math.abs((v46.y - v39.y) / 44);

                        if v35 > 0 then
                            v48 = v48 * -1;
                        end;

                        v39.scaleY = v48;
                        local math_atan2_ret = math.atan2(v39.y - v46.y, v39.x - v46.x);
                        v39.angle = -(-math.deg(math_atan2_ret) + 180 + 90);

                        if v.isClipping then
                            local v49 = p26.strumGroup[v34];
                            local y = v49.y;
                            v39.x = v49.x;
                            v39.y = y;
                        end;
                    else
                        v39.scaleY = v39.scaleY * (1 / -v42.z);
                    end;

                    p26:addDataToNote(v39, v33);
                end;
            end;
        end;
    end;
end;

function u1.addDataToStrum(p50: table, p51: userdata, p52: any) -- Line: 253
    p52.x = p51.x;
    p52.y = p51.y;
    p52.angle = p51.angle;
    p52.alpha = p51.alpha;
    p52.scale.x = p51.scaleX;
    p52.scale.y = p51.scaleY;
    p52.zindex = p51.zindex;
end;

function newNotePosData()
    return {
        setupStrum = function(p53: any, p54: number, p55: number, p56: number, p57: number, p58: number, p59: number, p60: number) -- Line: 266, Name: setupStrum
            p53.x = p54;
            p53.y = p55;
            p53.z = p56;
            p53.angle = 0;
            p53.alpha = 1;
            p53.scaleX = p58;
            p53.scaleY = p59;
            p53.index = p57;
            p53.playfieldIndex = p60;
            p53.lane = p57;
            p53.curPos = 0;
            p53.noteDist = 0;
            p53.isStrum = true;
            p53.incomingAngleX = 0;
            p53.incomingAngleY = 0;
            p53.strumTime = 0;
        end,

        setupNote = function(p61: any, p62: number, p63: number, p64: number, p65: number, p66: number, p67: number, p68: number, p69: number, p70: number, p71: number, p72: number, p73: number, p74: number, p75: number) -- Line: 285, Name: setupNote
            p61.x = p62;
            p61.y = p63;
            p61.z = p64;
            p61.angle = 0;
            p61.alpha = p69;
            p61.scaleX = p66;
            p61.scaleY = p67;
            p61.note = p75;
            p61.playfieldIndex = p68;
            p61.lane = p65;
            p61.curPos = p70;
            p61.noteDist = p71;
            p61.isStrum = false;
            p61.incomingAngleX = p72;
            p61.incomingAngleY = p73;
            p61.strumTime = p74;
        end
    };
end;

function u1.getDataForStrum(p76: table, p77: number, p78: number) -- Line: 306
    -- upvalues: NoteMovement (copy)
    local v79 = NoteMovement.defaultStrumX[p77];
    local v80 = NoteMovement.defaultStrumY[p77];
    local v81 = NoteMovement.defaultScale[p77];
    local v82 = NoteMovement.defaultScale[p77];
    local v83 = newNotePosData();
    v83:setupStrum(v79, v80, 0, p77, v81, v82, p78);
    p76.playfields[p78]:applyOffsets(v83);
    p76.modifierTable:applyStrumMods(v83, p77, p78);

    return v83;
end;

function u1.addDataToNote(p84: table, p85: userdata, p86: userdata) -- Line: 319
    p86.x = p85.x;
    p86.y = p85.y;
    p86.angle = p85.angle;
    p86.alpha = p85.alpha;
    p86.Scale = Vector2.new(p85.scaleX, p85.scaleY);
    p86.zindex = p85.zindex;
end;

function getLane(p87)
    -- upvalues: NoteMovement (copy)
    return p87.side == "R" and p87.noteData + NoteMovement.keyCount or p87.noteData;
end;

function u1.createDataFromNote(p88: table, p89: any, p90: number, p91: number, p92: number, p93: table) -- Line: 336
    -- upvalues: NoteMovement (copy)
    local x = p89.x;
    local y = p89.y;
    local v94 = p89.z or 0;
    local v95 = getLane(p89);
    local v96 = NoteMovement.defaultScale[v95];
    local multAlpha = p89.multAlpha;
    local v97 = newNotePosData();
    v97:setupNote(x, y, v94, v95, v96, v96, p90, multAlpha, p91, p92, p93[1], p93[2], p89.strumTime, p89);
    p88.playfields[p90]:applyOffsets(v97);

    return v97;
end;

function u1.getNoteDist(p98, p99) -- Line: 354
    -- upvalues: ModchartUtil (copy)
    return ModchartUtil:getDownscroll(p99) and 0.45 or -0.45;
end;

return u1;