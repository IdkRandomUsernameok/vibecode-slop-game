-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = 1;

function lerp(p6, p7, p8)
    return p6 + (p7 - p6) * p8;
end;

function matrix_rotateX(p9)
    local math_rad_ret = math.rad(p9);
    local math_cos_ret = math.cos(math_rad_ret);
    local math_sin_ret = math.sin(math_rad_ret);

    return {
        1,
        0,
        0,
        0,
        0,
        math_cos_ret,
        -math_sin_ret,
        0,
        0,
        math_sin_ret,
        math_cos_ret,
        0,
        0,
        0,
        0,
        1
    };
end;

function matrix_rotateY(p10)
    local math_rad_ret = math.rad(p10);
    local math_cos_ret = math.cos(math_rad_ret);
    local math_sin_ret = math.sin(math_rad_ret);

    return {
        math_cos_ret,
        0,
        math_sin_ret,
        0,
        0,
        1,
        0,
        0,
        -math_sin_ret,
        0,
        math_cos_ret,
        0,
        0,
        0,
        0,
        1
    };
end;

function matrix_rotateZ(p11)
    local math_rad_ret = math.rad(p11);
    local math_cos_ret = math.cos(math_rad_ret);
    local math_sin_ret = math.sin(math_rad_ret);

    return {
        math_cos_ret,
        -math_sin_ret,
        0,
        0,
        math_sin_ret,
        math_cos_ret,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        1
    };
end;

function matrix_scale(p12, p13, p14)
    return {
        p12,
        0,
        0,
        0,
        0,
        p13,
        0,
        0,
        0,
        0,
        p14,
        0,
        0,
        0,
        0,
        1
    };
end;

function matrix_multiply(p15, p16)
    local v17 = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 };

    for i = 1, 4 do
        local v18 = i;

        for i2 = 1, 4 do
            v17[(v18 - 1) * 4 + i2] = 0 + p15[i2 + 0] * p16[(v18 - 1) * 4 + 1] + p15[i2 + 4] * p16[(v18 - 1) * 4 + 2] + p15[i2 + 8] * p16[(v18 - 1) * 4 + 3] + p15[i2 + 12] * p16[(v18 - 1) * 4 + 4];
            local _ = i2;
        end;
    end;

    return v17;
end;

function matrix_build(p19, p20, p21, p22, p23, p24, p25, p26, p27)
    local v28 = matrix_rotateX(p22);
    local v29 = matrix_rotateY(p23);
    local v30 = matrix_rotateZ(p24);
    local v31 = matrix_multiply(matrix_multiply(v30, v28), v29);
    local v32 = matrix_scale(p25, p26, p27);
    local v33 = matrix_multiply(v32, v31);
    v33[13] = p19;
    v33[14] = p20;
    v33[15] = p21;

    return v33;
end;

function matrix_transform_vertex(p34, p35, p36, p37, p38)
    local v39 = p38 or 1;
    local v40 = p34[4] * p35 + p34[8] * p36 + p34[12] * p37 + p34[16] * v39;

    return {
        p34[1] * p35 + p34[5] * p36 + p34[9] * p37 + p34[13] * v39,
        p34[2] * p35 + p34[6] * p36 + p34[10] * p37 + p34[14] * v39,
        p34[3] * p35 + p34[7] * p36 + p34[11] * p37 + p34[15] * v39,
        (p38 and true or false) and v40 and v40 or nil
    };
end;

function bezCurve(p41, p42, p43, p44)
    local x = p42.x;
    local y = p42.y;
    local z = p42.z;

    return {
        x = lerp(lerp(p41.x, x, p44), lerp(x, p43.x, p44), p44),
        y = lerp(lerp(p41.y, y, p44), lerp(y, p43.y, p44), p44),
        z = lerp(lerp(p41.z, z, p44), lerp(z, p43.z, p44), p44)
    };
end;

function bezMultiCurve(p45, p46)
    local v47 = array_length(p45);

    if v47 == 1 then
        return p45[1];
    end;

    if v47 == 2 then
        return {
            x = lerp(p45[1].x, p45[2].x, p46),
            y = lerp(p45[1].y, p45[2].y, p46),
            z = lerp(p45[1].z, p45[2].z, p46)
        };
    end;

    local v48 = {
        x = p45[1].x,
        y = p45[1].y,
        z = p45[1].z
    };
    local v49 = 0;
    local v50 = 0.5;

    for i = 2, v47 - 2 do
        local v51 = p45[i];
        local v52 = p45[i + 1];
        local v53 = {
            x = (v51.x + v52.x) / 2,
            y = (v51.y + v52.y) / 2,
            z = (v51.z + v52.z) / 2
        };
        v50 = v50 + 1;

        if p46 <= v50 / v47 then
            return bezCurve(v48, v51, v53, (p46 * v47 - v49) / (v50 - v49));
        end;

        v48 = v53;
        local _ = i;
        v49 = v50;
    end;

    return bezCurve(v48, p45[v47 - 1], p45[v47], (p46 * v47 - v49) / (v50 + 1.5 - v49));
end;

function dsAngle(p54, p55)
    return {
        x = p55 and -p54.x or p54.x,
        y = p54.y,
        z = p54.z
    };
end;

function strumLineAdd(p56, p57, p58, p59)
    return {
        w = p56 or 1,
        p = {},
        l = p57 or 720,
        a = p58 or 270,
        ax = p59 and (p59.x or 0) or 0,
        ay = p59 and p59.y or 0
    };
end;

local u60 = {};

function createStrum(p61, p62, p63, p64)
    return {
        scroll = 1,
        xscale = 1,
        yscale = 1,
        hitQuant = 0,
        hitData = 0,
        strum = p61,
        isPlayer = p62,
        angle = p63,
        ang3D = p64 or {
            z = 0,
            x = 0,
            y = 0
        },
        dir = {
            z = 0,
            x = 0,
            y = 0
        },
        pos = {
            x = 0,
            y = 0,
            z = 0
        },
        lines = { strumLineAdd(1, 720), strumLineAdd(1, 720) }
    };
end;

function calcCurrTime(p65)
    -- upvalues: u2 (ref)
    return p65 - u2.SongPosition;
end;

function array_length(p66)
    return p66[0] ~= nil and #p66 + 1 or #p66;
end;

local u67 = 50;

function getPosByTime(p68, p69, p70)
    -- upvalues: u67 (ref)
    local v71 = 0;
    local v72 = nil;
    local v73 = nil;
    local v74 = 0;
    local v75 = 0;
    local v76 = 0;

    for i = 1, array_length(p68.lines) do
        v72 = p68.lines[i];
        v73 = (720 - u67) * v72.w / p68.scroll;
        local v77 = v74 + v73;
        local v78 = matrix_build(0, 0, 0, v72.ax, v72.ay, v72.a, 1, 1, 1);
        local v79 = matrix_transform_vertex(v78, v72.l, 0, 0);
        local v80 = { {
                x = 0,
                y = 0,
                z = 0
            } };
        table.move(v72.p, 1, #v72.p, 2, v80);
        table.insert(v80, {
            x = v79[1],
            y = v79[2],
            z = v79[3]
        });

        if p69 <= v77 then
            local v81 = bezMultiCurve(v80, (p69 - v74) / (v77 - v74));
            v75 = v75 + v81.x;
            v76 = v76 + v81.y;
            v71 = v71 + v81.z;
            break;
        end;

        v75 = v75 + v79[1];
        v76 = v76 + v79[2];
        v71 = v71 + v79[3];
        v74 = v77;
        local _ = i;
    end;

    local v82 = matrix_build(0, 0, 0, p68.dir.x, p68.dir.y, p68.dir.z, 1, p70 and -1 or 1, 1);
    local v83 = matrix_transform_vertex(v82, v75, v76, v71);

    return {
        x = v83[1],
        y = v83[2],
        z = v83[3],
        a = p68.angle,
        a3d = dsAngle(p68.ang3D, p70),
        l = v72,
        lt = v73
    };
end;

function point_direction(p84, p85, p86, p87)
    local math_atan2_ret = math.atan2(p85 - p87, p84 - p86);

    return -math.deg(math_atan2_ret) + 180;
end;

function draw_sprite_ext(p88, p89, p90, p91, p92, p93, p94, p95, p96)
    p88.x = p90;
    p88.y = p91;
    p88.Scale = Vector2.new(p92, p93);

    if p88.sustainNote then
        p88.useAngleAnchor = true;
        p88.angleAnchor = Vector2.new(0.5, 0);
    end;

    p88.angle = p94;
    p88.alpha = p96;
end;

function calculatePerspective(p97, p98, p99)
    local v100 = p99 + -0;

    return { (p97 - 640 + 56) * 1.0000000000000002 / -v100 + 640 - 56, (p98 - 360 + 56) / 1.0000000000000002 / -v100 + 360 - 56, v100 };
end;

function getCartesianCoords3D(p101, p102, p103)
    local v104 = math.cos(p101 * 0.017453292519943295) * math.sin(p102 * 0.017453292519943295);
    local math_cos_ret = math.cos(p102 * 0.017453292519943295);
    local v105 = math.sin(p101 * 0.017453292519943295) * math.sin(p102 * 0.017453292519943295);

    return { v104 * p103, math_cos_ret * p103, v105 * p103 / 1000 };
end;

function getNoteRot(p106, p107, p108, p109)
    local v110 = getCartesianCoords3D(p106, 90, p108 - 640);
    local v111 = v110[1] + 640;
    local v112 = getCartesianCoords3D(90, p107, p109 - 360);

    return { v111, v112[2] + 360, -1 + v110[3] + v112[3] };
end;

local math_rad = math.rad;
local u113 = nil;
local u114 = nil;

function d3d_draw_sprite(p115, p116, p117, p118, p119, p120, p121, p122, p123, p124, p125)
    -- upvalues: math_rad (copy)
    local v126 = p124 == nil and {
        x = 0,
        y = 0,
        z = 0
    } or p124;
    local v127 = getNoteRot(math_rad(v126.x), math_rad(v126.y), p117, p118);
    local v128 = calculatePerspective(v127[1], v127[2], p119 / 1000 - 1);
    local v129 = v128[1];
    local v130 = v128[2];
    local v131 = 1 / -v128[3];

    if p115.sustainNote then
        v126.z = 0;
    end;

    local l_draw_sprite_ext = draw_sprite_ext;
    local v132 = math_rad(v126.y) * 1.5;
    local v133 = (p120 == nil and 1 or p120) * v131 * math.cos(v132);
    local v134 = math_rad(v126.x);
    l_draw_sprite_ext(p115, "", v129, v130, v133, (p121 == nil and 1 or p121) * v131 * math.cos(v134), (p122 == nil and 0 or p122) + v126.z, "", p125 == nil and 1 or p125);
end;

function drawNote(p135, p136, p137, p138, p139, p140, p141)
    -- upvalues: math_rad (copy), u2 (ref)
    local v142 = p139 == nil and 0 or p139;
    local v143 = p140 == nil and 1 or p140;
    local v144 = getPosByTime(p136, calcCurrTime(p135.strumTime), p141);
    local v145;

    if p135.sustainNote then
        local v146 = getPosByTime(p136, calcCurrTime(p135.isEnd and p135.endPixelTime or p135.susEndTime), p141);
        local v147 = getNoteRot(math_rad(v144.a3d.x), math_rad(v144.a3d.y), p137 + v144.x, p138 + v144.y);
        local v148 = calculatePerspective(v147[1], v147[2], (v142 + v144.z * v143) / 1000 - 1);
        local v149 = v148[1];
        local v150 = v148[2];
        local v151 = getNoteRot(math_rad(v146.a3d.x), math_rad(v146.a3d.y), p137 + v146.x, p138 + v146.y);
        local v152 = calculatePerspective(v151[1], v151[2], (v142 + v146.z * v143) / 1000 - 1);
        local v153 = v152[1];
        local v154 = v152[2];
        v145 = p135.isEnd and 0.7 or math.abs((v154 - v150) / 44);

        if p141 then
            v145 = v145 * -1;
        end;

        v144.a = -(point_direction(v149, v150, v153, v154) + 90);

        if u2.SongPosition >= p135.strumTime then
            v144.x = 0;
            v144.y = 0;
        end;
    else
        v145 = 0.7;
    end;

    d3d_draw_sprite(p135, 0, p137 + v144.x, p138 + v144.y, v142 + v144.z * v143, 0.7, v145, v144.a, 0, v144.a3d);
end;

local u155 = {};

function drawStrum(p156, p157, p158, p159, p160, p161)
    -- upvalues: u155 (ref), u60 (copy), u114 (ref)
    local v162 = p158 == nil and 0 or p158;
    local v163 = p159 == nil and 0 or p159;
    local v164 = p160 == nil and 0 or p160;
    u155[p157] = {
        p157,
        v162,
        v163,
        v164
    };
    local v165 = u60[p157];
    local v166 = { {
            x = 0,
            y = 0,
            z = 0
        }, {
            x = 0,
            y = 0,
            z = 0
        }, {
            x = 0.1,
            y = 0,
            z = 0
        }, {
            x = 0.9,
            y = 0,
            z = 0
        }, {
            x = 1,
            y = 0,
            z = 0
        }, {
            x = 1,
            y = 0,
            z = 0
        } };
    local v167 = 1 - bezMultiCurve(v166, 0).x * 0.175;
    local v168 = 1 + bezMultiCurve(v166, 0).x * 0.1;
    local v169 = p157 <= 4 and 1 or 2;
    d3d_draw_sprite(p156, 0, v162 + v165.pos.x + u114[v169].x, v163 + (v165.pos.y + u114[v169].y) * (p161 and -1 or 1), v164 + v165.pos.z + u114[v169].z - 0.2, 0.7 * v167 * v168, 0.7 * v167 * v168, v165.angle, "", dsAngle(v165.ang3D, p161));
end;

function onUpdatePost(p170)
    -- upvalues: u5 (ref), u155 (ref), u1 (ref), u4 (ref), u3 (ref), u60 (copy), u114 (ref)
    u5 = p170;
    u155 = {};

    for i, v in u1.Strums do
        local v171 = 0 - (i < 4 and 40 or -20);
        local v172 = (i < 4 and i + 4 or i - 4) + 1;

        if u4 and v.side ~= u1.Side then
            v.visible = false;
        else
            if u4 then
                v171 = v171 + 320 * (u1.Side == "L" and -1 or 1);
            end;

            drawStrum(v, v172, _G[`defaultStrum{i}X`] + v171, _G[`defaultStrum{i}Y`], nil, u3[v.side]);
        end;
    end;

    for _, v in u1.Notes do
        if u4 and v.side ~= u1.Side then
            v.visible = false;
        else
            local noteData = v.noteData;

            if v.side == "L" then
                noteData = noteData + 4 or noteData;
            end;

            local v173 = noteData + 1;
            local v174 = u60[v173];
            local v175 = u3[v.side];
            local v176 = v.side == "R" and 1 or 2;
            drawNote(v, v174, u155[v173][2] + v174.pos.x + u114[v176].x, u155[v173][3] + (v174.pos.y + u114[v176].y) * (v175 and -1 or 1), u155[v173][4] + v174.pos.z + u114[v176].z, nil, v175);
        end;
    end;

    u155 = {};
end;

function remapToRange(p177, p178, p179, p180, p181)
    return p180 + (p177 - p178) * ((p181 - p180) / (p179 - p178));
end;

return {
    init = function() -- Line: 648, Name: init
        -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u60 (copy), u113 (ref), u114 (ref), u67 (ref)
        u1 = shared.getApi();
        u2 = u1.Conductor;
        u3 = {
            L = u1.getSetting("L", "Downscroll"),
            R = u1.getSetting("R", "Downscroll")
        };
        u4 = u1.Settings.Middlescroll;
        table.clear(u60);

        for i = 1, 8 do
            table.insert(u60, createStrum(i % 4, i <= 4, 0));
            local _ = i;
        end;

        u113 = {
            X = 0,
            Y = 0,
            Z = 0
        };
        u114 = { {
                x = 0,
                y = 0,
                z = 0
            }, {
                x = 0,
                y = 0,
                z = 0
            } };
        u67 = remapToRange(u1.songSpeed, 0, 3.8, -2350, 70);

        return u60, u114, u113;
    end,

    update = onUpdatePost,
    strums = u60
};