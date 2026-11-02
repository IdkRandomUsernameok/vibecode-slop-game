-- Decompiled with Potassium's decompiler.

local l_script = script;
local ContentProvider = game:GetService("ContentProvider");
local l_next = next;
local l_type = type;
local l_pcall = pcall;
local l_unpack = unpack;
local l_tostring = tostring;
local _ = tonumber;
local math_abs = math.abs;
local _ = math.min;
local math_max = math.max;
local string_sub = string.sub;
local string_rep = string.rep;
local string_byte = string.byte;
local string_gsub = string.gsub;
local string_find = string.find;
local _ = string.char;
local string_match = string.match;
local string_upper = string.upper;
local string_gmatch = string.gmatch;
local table_sort = table.sort;
local table_insert = table.insert;
local UDim2_new = UDim2.new;
local Color3_new = Color3.new;
local Vector2_new = Vector2.new;
local Instance_new = Instance.new;
local u1 = Instance_new("ImageLabel");
u1.Size = UDim2_new(0, 0, 0, 0);
u1.BackgroundTransparency = 1;
u1.ScaleType = Enum.ScaleType.Stretch;
local u2 = {
    Right = true,
    Bottom = true
};
local u3 = {
    Left = true,
    Top = true
};
local u4 = {
    AbsoluteSize = true,
    TextWrapped = true,
    TextScaled = true,
    TextXAlignment = true,
    TextYAlignment = true
};
local u5 = {
    TextTransparency = true,
    TextStrokeTransparency = true,
    BackgroundTransparency = true
};
local u6 = {
    AbsolutePosition = true,
    AbsoluteSize = true,
    Position = true,
    Size = true,
    Rotation = true,
    Parent = true
};
local u7 = {
    FontName = true,
    Style = true
};

local function getAlignMultiplier(p8) -- Line: 104
    -- upvalues: u2 (copy), u3 (copy)
    return u2[p8.Name] and 1 or (u3[p8.Name] and 0 or 0.5);
end;

local function getClosestNumber(u9, p10) -- Line: 108
    -- upvalues: table_sort (copy), math_abs (copy)
    table_sort(p10, function(p11, p12) -- Line: 109
        -- upvalues: u9 (copy), math_abs (ref)
        return math_abs(u9 - p11) < math_abs(u9 - p12);
    end);

    return p10[1];
end;

local function wrapper(u13, u14) -- Line: 115
    -- upvalues: l_tostring (copy)
    local v15 = newproxy(true);
    local v16 = getmetatable(v15);

    function v16.__index(p17, p18) -- Line: 118
        -- upvalues: u14 (copy), u13 (copy)
        return u14[p18] or u13[p18];
    end;

    function v16.__newindex(p19, p20, p21) -- Line: 119
        -- upvalues: u14 (copy), u13 (copy)
        if u14[p20] then
            u14[p20] = p21;

            return;
        end;

        u13[p20] = p21;
    end;

    function v16.__call() -- Line: 120
        -- upvalues: u13 (copy)
        return u13;
    end;

    function v16.__tostring(p22) -- Line: 121
        -- upvalues: u13 (copy), l_tostring (ref)
        return l_tostring(u13);
    end;

    v16.__metatable = "The metatable is locked.";

    return v15;
end;

local function defaultHide(p23) -- Line: 128
    p23.TextTransparency = 1e18;
    p23.BackgroundTransparency = 1e18;
    p23.TextStrokeTransparency = 1e18;
end;

local function newBackground(u24, p25) -- Line: 134
    -- upvalues: Instance_new (copy), UDim2_new (copy), Color3_new (copy)
    local u26 = Instance_new("Frame", u24);
    u26.Name = "_background";
    u26.Size = UDim2_new(1, 0, 1, 0);
    u26.BackgroundTransparency = u24.BackgroundTransparency;
    u26.BackgroundColor3 = u24.BackgroundColor3;
    u26.BorderSizePixel = u24.BorderSizePixel;
    u26.BorderColor3 = u24.BorderColor3;
    u26.ZIndex = u24.ZIndex;

    if p25 == "TextButton" then
        u26.MouseEnter:connect(function() -- Line: 144
            -- upvalues: u24 (copy), u26 (copy), Color3_new (ref)
            if u24.AutoButtonColor then
                local BackgroundColor3 = u24.BackgroundColor3;
                u26.BackgroundColor3 = Color3_new(BackgroundColor3.r - 0.29411764705882354, BackgroundColor3.g - 0.29411764705882354, BackgroundColor3.b - 0.29411764705882354);
            end;
        end);
        u24.MouseLeave:connect(function() -- Line: 150
            -- upvalues: u24 (copy), u26 (copy)
            if u24.AutoButtonColor then
                u26.BackgroundColor3 = u24.BackgroundColor3;
            end;
        end);
    end;

    return u26;
end;

local function split(p27, p28) -- Line: 161
    -- upvalues: string_find (copy), string_sub (copy), table_insert (copy)
    local v29 = 0;
    local v30 = {};

    while true do
        local v31 = string_find(p27, p28, v29, true);

        if not v31 then
            break;
        end;

        table_insert(v30, (string_sub(p27, v29, v31 - 1)));
        v29 = v31 + 1;
    end;

    table_insert(v30, (string_sub(p27, v29)));

    return v30;
end;

local function getLines(p32) -- Line: 177
    -- upvalues: string_gsub (copy), string_rep (copy), split (copy)
    return split(string_gsub(p32, "\t", string_rep(" ", 4)), "\n");
end;

local function getWords(p33, p34) -- Line: 182
    -- upvalues: string_gsub (copy), string_rep (copy), split (copy), string_gmatch (copy), table_insert (copy)
    local v35 = split(string_gsub(p33, "\t", string_rep(" ", 4)), "\n");
    local v36 = #v35;
    local v37 = {};

    for i = 1, v36 do
        for i2 in string_gmatch(v35[i], " *[^%s]+ *") do
            table_insert(v37, i2);
        end;

        if p34 and i < v36 then
            table_insert(v37, "\n");
        end;
    end;

    return v37;
end;

local function getStringWidth(p38, p39) -- Line: 200
    -- upvalues: string_sub (copy), string_byte (copy)
    local v40 = 0;

    for i = 1, #p38 do
        local v41;

        if i + 1 <= #p38 then
            v41 = i + 1;
        else
            v41 = false;
        end;

        local v42 = string_byte((string_sub(p38, i, i)));

        if v41 then
            v41 = string_byte((string_sub(p38, v41, v41)));
        end;

        local _ = p39.characters[v42];
        v40 = v40 + p39.characters[v42].xadvance + (not (v41 and (p39.kerning[v42] and p39.kerning[v42][v41])) and 0 or p39.kerning[v42][v41].x);
        local _ = i;
    end;

    return v40;
end;

local function getMaxHeight(p43, p44) -- Line: 216
    -- upvalues: string_sub (copy), string_byte (copy)
    local v45 = 0;

    for i = 1, #p43 do
        local v46 = string_byte((string_sub(p43, i, i)));
        local _ = p44.characters[v46];
        local v47 = p44.characters[v46].height + p44.characters[v46].yoffset;
        local v48;

        if v45 < v47 then
            v45 = v47;
            v48 = i;
        else
            v48 = i;
        end;
    end;

    return v45;
end;

local function wrapText(p49, p50, p51) -- Line: 231
    -- upvalues: getWords (copy), math_abs (copy), getStringWidth (copy)
    local v52 = getWords(p49, true);
    local v53 = math_abs(p51.child.AbsoluteSize.x);
    local v54 = 0;
    local v55 = 1;
    local v56 = { "" };

    for i = 1, #v52 do
        local v57 = v52[i];
        local v58;

        if v57 == "\n" then
            v55 = v55 + 1;
            v56[v55] = "";
            v58 = i;
            v54 = 0;
        else
            local v59 = getStringWidth(v57, p51.styles[p51.style][p50]);

            if v59 + v54 <= v53 then
                v56[v55] = v56[v55] .. v57;
            else
                v55 = v55 + 1;
                v56[v55] = v57;
                v54 = 0;
            end;

            v54 = v54 + v59;
            v58 = i;
        end;
    end;

    return v56;
end;

function scaleText(p60, p61)
    -- upvalues: table_sort (copy), wrapText (copy), string_gsub (copy), string_rep (copy), split (copy), getMaxHeight (copy), getStringWidth (copy), table_insert (copy), l_unpack (copy), math_max (copy), math_abs (copy)
    local child = p61.child;
    local _ = p61.attached;
    table_sort(p61.information.sizes, function(p62, p63) -- Line: 260
        return p63 < p62;
    end);
    local v64 = p61.information.sizes[1];
    local v65 = false;

    for i = 1, #p61.information.sizes do
        local v66 = p61.information.sizes[i];
        local v67 = p61.styles[p61.style][v66];
        local v68 = child.TextWrapped and wrapText(p60, v66, p61) or split(string_gsub(p60, "\t", string_rep(" ", 4)), "\n");
        local v69 = -v67.firstAdjust;
        local _ = i;
        local v70 = {};

        for i2 = 1, #v68 do
            local v71 = v68[i2];
            v69 = v69 + getMaxHeight(v71, v67);
            table_insert(v70, (getStringWidth(v71, v67)));
            local _ = i2;
        end;

        if math_max(l_unpack(v70)) <= math_abs(child.AbsoluteSize.x) and v69 <= math_abs(child.AbsoluteSize.y) then
            v64 = v66;
            v65 = true;
            break;
        end;
    end;

    return v65 and v64 and v64 or p61.information.sizes[#p61.information.sizes];
end;

local function drawSprite(p72, p73, p74) -- Line: 290
    -- upvalues: u1 (copy), Vector2_new (copy), UDim2_new (copy)
    local v75 = u1:Clone();
    local child = p74.child;
    local attached = p74.attached;
    local v76 = p74.styles[p74.style][p74.size];
    local v77 = v76.characters[p72];
    v75.Name = p72;
    v75.ImageColor3 = child.TextColor3;
    v75.ImageTransparency = attached.TextTransparency;
    v75.ZIndex = child.ZIndex;
    v75.Image = p74.atlases[v77.atlas + 1];
    v75.ImageRectSize = Vector2_new(v77.width, v77.height);
    v75.ImageRectOffset = Vector2_new(v77.x, v77.y);
    local v78, v79;

    if p73 and (v76.kerning[p72] and v76.kerning[p72][p73]) then
        local v80 = v76.kerning[p72][p73];
        v78 = v80.x;
        v79 = v80.y;
    else
        v78 = 0;
        v79 = 0;
    end;

    v75.Position = UDim2_new(0, v78, 0, v77.yoffset + v79);
    v75.Size = UDim2_new(0, v77.width, 0, v77.height);

    return v75, v78, v79 + v77.yoffset + v77.height;
end;

local function drawLine(p81, p82, p83, p84) -- Line: 324
    -- upvalues: string_sub (copy), string_byte (copy), drawSprite (copy), UDim2_new (copy), table_insert (copy), u2 (copy), u3 (copy), math_abs (copy)
    local child = p84.child;
    local _ = p84.attached;
    local v85 = #p81;
    local v86 = p84.styles[p84.style][p84.size];
    local v87 = 0;
    local v88 = {};
    local v89 = 0;

    for i = 1, v85 do
        local v90;

        if i + 1 <= v85 then
            v90 = i + 1;
        else
            v90 = false;
        end;

        local v91 = string_byte((string_sub(p81, i, i)));
        local v92;

        if v90 then
            v92 = string_byte((string_sub(p81, v90, v90)));
        else
            v92 = v90;
        end;

        local v93, v94, v95 = drawSprite(v91, v92, p84);

        if v87 < v95 then
            v87 = v95 or v87;
        end;

        v93.Position = v93.Position + UDim2_new(0, v89, 0, p82);
        v89 = v89 + (v90 and v86.characters[v91].xadvance or v86.characters[v91].width) + v94;
        table_insert(v88, v93);
        table_insert(p83, v93);
        local _ = i;
    end;

    local TextXAlignment = child.TextXAlignment;
    local v96 = u2[TextXAlignment.Name] and 1 or (u3[TextXAlignment.Name] and 0 or 0.5);
    local v97 = (math_abs(child.AbsoluteSize.x) - v89) * v96;

    for i = 1, v85 do
        local v98 = v88[i];
        v98.Position = v98.Position + UDim2_new(0, v97, 0, 0);
        local _ = i;
    end;

    return v89, v87;
end;

local function drawLines(p99, p100, p101) -- Line: 357
    -- upvalues: wrapText (copy), string_gsub (copy), string_rep (copy), split (copy), drawLine (copy), table_insert (copy), u2 (copy), u3 (copy), math_abs (copy), UDim2_new (copy)
    local child = p100.child;

    if child.TextScaled then
        p100.size = scaleText(p99, p100);
    end;

    local v102 = child.TextWrapped and wrapText(p99, p100.size, p100) or split(string_gsub(p99, "\t", string_rep(" ", 4)), "\n");
    local _ = p100.styles[p100.style][p100.size].lineHeight;
    local v103 = -p100.styles[p100.style][p100.size].firstAdjust;
    local v104 = {};
    local v105 = { 0 };

    for i = 1, #v102 do
        local v106, v107 = drawLine(v102[i], v103, v104, p100);
        v103 = v103 + v107;
        table_insert(v105, v106);
        local _ = i;
    end;

    local TextYAlignment = child.TextYAlignment;
    local v108 = u2[TextYAlignment.Name] and 1 or (u3[TextYAlignment.Name] and 0 or 0.5);
    local v109 = (math_abs(child.AbsoluteSize.y) - v103) * v108;

    for i = 1, #v104 do
        local v110 = v104[i];
        v110.Position = v110.Position + UDim2_new(0, 0, 0, v109);
        v110.Parent = p101;
        local _ = i;
    end;

    return v104;
end;

local u120 = {
    new = function(u111) -- Line: 393, Name: new
        -- upvalues: l_type (copy)
        local u112 = {};
        local v116 = setmetatable({}, {
            __metatable = "The metatable is locked.",
            __index = u111,

            __newindex = function(p113, p114, p115) -- Line: 397, Name: __newindex
                -- upvalues: u111 (copy), u112 (copy), l_type (ref)
                if u111[p114] ~= p115 then
                    u111[p114] = p115;

                    if l_type(u112[p114]) == "function" then
                        u112[p114](p115);
                    end;
                end;
            end
        });

        function v116.connect(p117, p118, p119) -- Line: 408
            -- upvalues: u112 (copy)
            u112[p118] = p119;
        end;

        return v116;
    end
};
local u121 = {};

function u121.new(p122, u123, u124) -- Line: 417
    -- upvalues: u121 (copy), table_sort (copy), l_next (copy), l_tostring (copy), math_abs (copy)
    local u125 = setmetatable({}, {
        __index = u121
    });
    u121.child = u124;
    u121.attached = u123;
    u125.information = p122.font.information;
    u125.atlases = p122.atlases;
    u125.styles = p122.font.styles;
    table_sort(u125.information.sizes, function(p126, p127) -- Line: 429
        return p127 < p126;
    end);
    u125.style = u125.information.styles[1];
    u125.size = u124.TextSize;

    for _, v in l_next, u125.styles do
        for _, v2 in l_next, v do
            setmetatable(v2.characters, {
                __index = function(p128, p129) -- Line: 440, Name: __index
                    -- upvalues: l_tostring (ref)
                    local v130 = l_tostring(p129);
                    local v131 = rawget(p128, v130);

                    if v131 then
                        return v131;
                    end;

                    warn(v130, "is not a valid character. Replaced with, \"?\"");
                    local v132 = l_tostring(63);

                    return rawget(p128, v132);
                end
            });
        end;

        setmetatable(v, {
            __index = function(p133, p134) -- Line: 453, Name: __index
                -- upvalues: l_tostring (ref), u125 (copy), table_sort (ref), math_abs (ref), u124 (copy)
                local u135 = l_tostring(p134);
                local v136 = rawget(p133, u135);

                if v136 then
                    return v136;
                end;

                local sizes = u125.information.sizes;
                table_sort(sizes, function(p137, p138) -- Line: 109
                    -- upvalues: u135 (copy), math_abs (ref)
                    return math_abs(u135 - p137) < math_abs(u135 - p138);
                end);
                local v139 = sizes[1];
                u125.size = v139;
                u124.TextSize = v139;
                warn(u135, "is not a valid size. Using the closest size,", v139);
                local v140 = l_tostring(v139);

                return rawget(p133, v140);
            end
        });
    end;

    setmetatable(u125.styles, {
        __index = function(p141, p142) -- Line: 469, Name: __index
            -- upvalues: u125 (copy), u123 (copy)
            local v143 = rawget(p141, p142);

            if v143 then
                return v143;
            end;

            local v144 = u125.information.styles[1];
            u125.style = v144;
            u123.Style = v144;
            warn(p142, "is not a valid style. Using first style found", v144);

            return rawget(p141, v144);
        end
    });

    return u125;
end;

function u121.preload(p145) -- Line: 485
    -- upvalues: l_next (copy), ContentProvider (copy)
    for _, v in l_next, p145.atlases do
        ContentProvider:Preload(v);
    end;
end;

local u176 = {
    new = function(p146, u147, p148) -- Line: 495, Name: new
        -- upvalues: u120 (copy), l_type (copy), Instance_new (copy), l_script (copy), u121 (copy), l_next (copy), u7 (copy), string_upper (copy), string_sub (copy), newBackground (copy), drawLines (copy), u5 (copy), u4 (copy), string_match (copy), u6 (copy), l_pcall (copy), table_insert (copy), wrapper (copy)
        local u149 = u120.new({});

        if l_type(u147) == "string" or not u147 then
            u147 = Instance_new(u147);
        end;

        local v150 = l_script:FindFirstChild(p146);
        local u151 = u121.new(require(v150), u149, u147);
        u151:preload();
        u149.FontName = p146;
        u149.Style = u151.style;
        u149.TextTransparency = u147.TextTransparency;
        u149.TextStrokeTransparency = u147.TextStrokeTransparency;
        u149.BackgroundTransparency = u147.BackgroundTransparency;
        u149.TextFits = false;
        local u152 = {};
        local u153 = {};
        local u154 = {};
        local u155 = {};

        for i, _ in l_next, u7 do
            local v156 = u149[i];
            local v157 = l_type(v156);
            local v158 = string_upper((string_sub(v157, 1, 1))) .. string_sub(v157, 2) .. "Value";
            local Instance_new_ret = Instance.new(v158, u147);
            Instance_new_ret.Name = i;
            Instance_new_ret.Value = v156;
            Instance_new_ret.Changed:connect(function(p159) -- Line: 528
                -- upvalues: u149 (copy), i (copy)
                u149[i] = p159;
            end);
            u152[Instance_new_ret.Name] = Instance_new_ret;
            u153[Instance_new_ret] = true;
        end;

        local u160 = newBackground(u147, p148 and "TextButton");
        u147.TextTransparency = 1e18;
        u147.BackgroundTransparency = 1e18;
        u147.TextStrokeTransparency = 1e18;

        local function drawText() -- Line: 541
            -- upvalues: u160 (copy), u155 (ref), drawLines (ref), u147 (copy), u151 (ref)
            u160:ClearAllChildren();
            u155 = drawLines(u147.Text, u151, u160);
        end;

        u149:connect("FontName", function(p161) -- Line: 548
            -- upvalues: u160 (copy), u155 (ref), drawLines (ref), u147 (copy), u151 (ref)
            u160:ClearAllChildren();
            u155 = drawLines(u147.Text, u151, u160);
        end);
        u149:connect("TextStrokeTransparency", function(p162) -- Line: 549
            -- upvalues: u160 (copy), u155 (ref), drawLines (ref), u147 (copy), u151 (ref)
            u160:ClearAllChildren();
            u155 = drawLines(u147.Text, u151, u160);
        end);
        u149:connect("BackgroundTransparency", function(p163) -- Line: 551
            -- upvalues: u160 (copy)
            u160.BackgroundTransparency = p163;
        end);
        u149:connect("Style", function(p164) -- Line: 555
            -- upvalues: u151 (ref), u152 (ref), u160 (copy), u155 (ref), drawLines (ref), u147 (copy)
            u151.style = p164;
            u152.Style.Value = p164;
            u160:ClearAllChildren();
            u155 = drawLines(u147.Text, u151, u160);
        end);
        u149:connect("TextTransparency", function(p165) -- Line: 561
            -- upvalues: u155 (ref)
            for i = 1, #u155 do
                u155[i].ImageTransparency = p165;
                local _ = i;
            end;
        end);
        u149:connect("FontName", function(p166) -- Line: 567
            -- upvalues: l_script (ref), u151 (ref), u149 (copy), u147 (copy), u152 (ref), u160 (copy), u155 (ref), drawLines (ref)
            local v167 = l_script:FindFirstChild(p166);
            u151 = u151.new(require(v167), u149, u147);
            u151:preload();
            u152.FontName.Value = p166;

            if not u147.TextScaled then
                u151.size = u147.TextSize;
            end;

            u151.style = u149.Style;
            u160:ClearAllChildren();
            u155 = drawLines(u147.Text, u151, u160);
        end);
        table_insert(u154, u147.Changed:connect(function(u168) -- Line: 581
            -- upvalues: u5 (ref), u147 (copy), u149 (copy), u151 (ref), u160 (copy), u155 (ref), drawLines (ref), l_next (ref), u4 (ref), string_match (ref), u6 (ref), l_pcall (ref)
            if u5[u168] then
                if u147[u168] ~= 2 then
                    u149[u168] = u147[u168];
                end;

                u147[u168] = 2;

                return;
            end;

            if u168 == "TextSize" then
                u151.size = u147[u168];
                u160:ClearAllChildren();
                u155 = drawLines(u147.Text, u151, u160);

                return;
            end;

            if u168 == "TextColor3" then
                for _, v in l_next, u155 do
                    v.ImageColor3 = u147[u168];
                end;

                return;
            end;

            if u168 == "ZIndex" then
                u160.ZIndex = u147[u168];

                for _, v in l_next, u155 do
                    v.ZIndex = u147[u168];
                end;

                return;
            end;

            if u168 == "Text" then
                u160:ClearAllChildren();
                u155 = drawLines(u147.Text, u151, u160);

                return;
            end;

            if not u4[u168] then
                if not (string_match(u168, "Text") or u6[u168]) then
                    l_pcall(function() -- Line: 607
                        -- upvalues: u160 (ref), u168 (copy), u147 (ref)
                        u160[u168] = u147[u168];
                    end);
                end;

                return;
            end;

            if u168 == "TextScaled" and not u147[u168] then
                u151.size = u147.TextSize;
            end;

            u160:ClearAllChildren();
            u155 = drawLines(u147.Text, u151, u160);
        end));

        if u147:IsA("TextBox") then
            table_insert(u154, u147.Focused:connect(function() -- Line: 612
                -- upvalues: u147 (copy)
                if u147.ClearTextOnFocus then
                    u147.Text = "";
                end;
            end));
        end;

        function u149.Revert(p169) -- Line: 621
            -- upvalues: l_next (ref), u152 (ref), u154 (ref), u160 (copy), u147 (copy), u153 (ref)
            for _, v in l_next, u152 do
                v:Destroy();
            end;

            for _, v in l_next, u154 do
                v:disconnect();
            end;

            u160:Destroy();
            u147.TextTransparency = p169.TextTransparency;
            u147.BackgroundTransparency = p169.BackgroundTransparency;
            u153 = {};
            u152 = {};
            u154 = {};

            return u147;
        end;

        function u149.GetChildren(p170) -- Line: 631
            -- upvalues: l_next (ref), u147 (copy), u160 (copy), u153 (ref), table_insert (ref)
            local Children, v171 = u147:GetChildren();
            local v172 = {};

            for _, v in l_next, Children, v171 do
                if v ~= u160 and not u153[v] then
                    table_insert(v172, v);
                end;
            end;

            return v172;
        end;

        function u149.ClearAllChildren(p173) -- Line: 641
            -- upvalues: l_next (ref), u147 (copy), u160 (copy), u153 (ref)
            local Children, v174 = u147:GetChildren();

            for _, v in l_next, Children, v174 do
                if v ~= u160 and not u153[v] then
                    v:Destroy();
                end;
            end;
        end;

        function u149.Destroy(p175) -- Line: 649
            p175:Revert():Destroy();
        end;

        u160:ClearAllChildren();
        u155 = drawLines(u147.Text, u151, u160);

        return wrapper(u147, u149);
    end
};
local v177 = {};

for _, v in l_next, { "TextLabel", "TextBox", "TextButton", "TextReplace" } do
    v177[string.sub(v, 5)] = function(p178, p179) -- Line: 664
        -- upvalues: u176 (copy), v (copy)
        local new = u176.new;
        local v180;

        if v == "TextButton" then
            v180 = true;
        elseif v == "TextReplace" then
            v180 = p179:IsA("TextButton");
        else
            v180 = false;
        end;

        return new(p178, v == "TextReplace" and p179 and p179 or v, v180);
    end;
end;

wait();

return v177;