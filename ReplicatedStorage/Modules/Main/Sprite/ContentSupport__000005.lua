-- Decompiled with Potassium's decompiler.

local math_sin = math.sin;
local math_cos = math.cos;
local math_rad = math.rad;
local Vector2_new = Vector2.new;
local math_round = math.round;
local UDim2_fromScale = UDim2.fromScale;
local _ = UDim2.new;
local UDim2_fromOffset = UDim2.fromOffset;
local table_find = table.find;
local _ = table.insert;
local table_remove = table.remove;
local table_clone = table.clone;
local Default = Enum.ResamplerMode.Default;
local Pixelated = Enum.ResamplerMode.Pixelated;
debug.setmemorycategory("SPRITE MANAGER");
local u1 = {
    __minz = true
};
local Lib = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Lib");
local XMLParser = require(Lib.XML.XMLParser);
local new = require(Lib.Signal).new;
local u2 = 0;
local u3 = setmetatable({}, {
    __mode = "v"
});
local u4 = workspace.CurrentCamera.ViewportSize + Vector2_new(0, 1);
local _ = task.spawn;

local function updatePropertyFrom(p5: table, p6: userdata, p7: string, p8: any) -- Line: 166
    if p5[p7] == p8 then
        return;
    end;

    p5[p7] = p8;

    if p6 == nil then
        return;
    end;

    p6[p7] = p8;
end;

local u9 = Vector2_new(1, 1);
local u10 = Vector2_new(1280, 720);

local function parseImageId(p11) -- Line: 177
    if tonumber(p11) then
        p11 = "rbxassetid://" .. p11;
    end;

    return p11;
end;

local function fixFrames(p12) -- Line: 182
    for _, v in p12 do
        local v13 = v.Image or v.ImageId;

        if v13 and not v.ImageContent then
            if tonumber(v13) then
                v13 = "rbxassetid://" .. v13;
            end;

            v.ImageContent = Content.fromUri(v13);
            v.Image = nil;
            v.ImageId = nil;
        end;
    end;
end;

function u1.AddAnimation(p14, p15, p16, p17, p18, p19) -- Line: 195
    -- upvalues: fixFrames (copy)
    fixFrames(p16);

    if tonumber(p19) then
        p19 = "rbxassetid://" .. p19;
    end;

    local Animations = p14.Animations;
    local v20 = {
        Playing = false,
        FlipY = false,
        FlipX = false,
        Frames = p16 or {},
        Framerate = p17 or 24,
        Looped = p18 or false
    };
    local v21;

    if p19 then
        v21 = typeof(p19) == "Content" and p19 and p19 or (Content.fromUri(p19) or nil);
    else
        v21 = nil;
    end;

    v20.ImageContent = v21;
    Animations[p15 or ""] = v20;
    p14.AnimationAdded:Fire(p15);
end;

local u22 = {};

function u1.clearXmlCache(p23) -- Line: 215
    -- upvalues: u22 (ref)
    u22 = {};
end;

function u1.GetAnimationsFromXml(p24: table, p25: any, p26: boolean) -- Line: 219
    -- upvalues: u22 (ref), XMLParser (copy), table_find (copy)
    if u22[p25] and not p26 then
        return u22[p25];
    end;

    if typeof(p25) == "Instance" then
        p25 = require(p25);
    end;

    local children = XMLParser.parse(p25, true).children[1].children;
    local v27 = {};

    for i = 1, #children do
        local v28 = children[i];
        local v29;

        if v28.tag == "SubTexture" and not table_find(v27, v28.attrs.name:sub(1, -5)) then
            v27[#v27 + 1] = v28.attrs.name:sub(1, -5);
            v29 = i;
        else
            v29 = i;
        end;
    end;

    u22[p25] = v27;

    return v27;
end;

function u1.AddSparrowXml(p30: table, p31: any, p32: string, p33: string, p34: number, p35: boolean, p36: number, p37: any, p38: any) -- Line: 243
    local AnimFramesXml = p30:GetAnimFramesXml(p31, p33, p36, p37);

    if AnimFramesXml and #AnimFramesXml > 0 then
        return p30:AddAnimation(p32, AnimFramesXml, p34, p35, p38);
    end;
end;

function u1.loadGraphic(p39, p40, p41, p42, p43) -- Line: 252
    if typeof(p40) == "Instance" then
        p40 = require(p40) or p40;
    end;

    p39.loadedGraphic = p40;
    p39.graphicImage = p41;
    p39.graphicFactor = p42;
    p39.graphicSize = p43;
end;

function u1.addByPrefix(p44, p45, p46, p47, p48) -- Line: 263
    if p44.loadedGraphic then
        return p44:AddSparrowXml(p44.loadedGraphic, p45, p46, p47, p48, p44.graphicFactor, p44.graphicSize, p44.graphicImage);
    end;
end;

function u1.animExists(p49, p50) -- Line: 268
    return p49.Animations[p50] and true or false;
end;

function u1.GetAnimFramesXml(p51, p52, p53, p54, p55) -- Line: 272
    -- upvalues: XMLParser (copy), Vector2_new (copy), u9 (copy), fixFrames (copy)
    if typeof(p52) == "Instance" then
        p52 = require(p52) or p52;
    end;

    local v56 = XMLParser.parse(p52, true);
    local v57 = type(p55) == "number" and Vector2_new(p55, p55) or (p55 or u9);
    local children = v56.children[1].children;
    local Vector2_new_ret = Vector2.new(0, 0);
    local v58 = p54 or 1;
    local v59 = nil;
    local v60 = {};

    for i = 1, #children do
        local v61 = children[i];
        local attrs = v61.attrs;
        local v62;

        if v61.tag == "SubTexture" and attrs.name:sub(1, #p53) == p53 then
            local v63 = tonumber(attrs.x);
            local v64 = tonumber(attrs.y);
            local v65 = tonumber(attrs.width);
            local v66 = tonumber(attrs.height);
            local v67 = attrs.rotated ~= nil and attrs.rotated == "true";
            local v68 = tonumber(attrs.frameX) or 0;
            local v69 = tonumber(attrs.frameY) or 0;
            local v70 = tonumber(attrs.frameWidth) or v65;
            local v71 = tonumber(attrs.frameHeight) or v66;
            local v72 = Vector2_new(v63 / v58, v64 / v58);
            local v73 = Vector2_new(v65 / v58, v66 / v58);
            local v74 = Vector2_new(v65, v66);
            local v75 = Vector2_new(0, 0);

            if p51.useFrameOffsets then
                local v76 = p51.anchor or Vector2.new(0, 0);

                if tonumber(attrs.frameX) then
                    v59 = Vector2_new(v70, v71) or v59;
                end;

                if v59 then
                    v75 = -Vector2_new(v68, v69) + v74 / v59 * v76 * v59;
                else
                    v75 = -Vector2_new(v68, v69);
                end;

                Vector2_new_ret = Vector2_new(math.abs(Vector2_new_ret.X) > math.abs(v75.X) and Vector2_new_ret.X or v75.X, math.abs(Vector2_new_ret.Y) > math.abs(v75.Y) and Vector2_new_ret.Y or v75.Y);
            end;

            v60[#v60 + 1] = {
                Rotated = v67,
                Offset = v72,
                Size = v73,
                RawFrameSize = v74,
                FrameSize = v74 * v57,
                FrameOffset = v75
            };
            v62 = i;
        else
            v62 = i;
        end;
    end;

    for _, v in v60 do
        v.FrameOffset = v.FrameOffset - Vector2_new_ret;
    end;

    fixFrames(v60);

    return #v60 > 0 and v60 and v60 or nil;
end;

local u77 = {
    curAnimation = "curAnim",
    GUI = "Obj",
    obj = "Obj",
    Object = "Obj",
    object = "Obj",
    Frame = "curFrame",
    frame = "curFrame",
    Rotation = "angle",
    Angle = "angle",
    Visible = "visible",
    Alpha = "alpha",
    AnchorPoint = "anchor",
    Anchor = "anchor",
    AP = "anchor",
    X = "x",
    Y = "y",
    pos = "Position",
    ZIndex = "zindex",
    zLayer = "zindex",
    zlayer = "zindex",
    BorderSizePixel = "bsp",
    BSP = "bsp",
    BackgroundColor3 = "bgColor",
    BGColor3 = "bgColor",
    bgcolor = "bgColor",
    BGColor = "bgColor",
    bgcolor3 = "bgColor",
    BorderColor3 = "bsColor",
    BSColor3 = "bsColor",
    bscolor = "bsColor",
    BSColor = "bsColor",
    bscolor3 = "bsColor",
    Antialiasing = "antialiasing",
    Parent = "parent",
    fatherFigure = "parent",
    fatherless = "parent",
    ParentSize = "size",
    sizeOffset = "rectSizeOffset",
    imageOffset = "rectImageOffset",
    ImageColor3 = "imageColor",
    ImageColor = "imageColor",
    imageColor3 = "imageColor",
    imgColor = "imageColor",
    imgColor3 = "imageColor",
    ImgColor = "imageColor",
    ImgColor3 = "imageColor",
    Text = "text",
    RichText = "richText",
    PlaceholderText = "altText",
    AltText = "altText",
    PlaceholderColor3 = "altTextColor",
    PlaceholderColor = "altTextColor",
    placeholderColor3 = "altTextColor",
    placeholderColor = "altTextColor",
    altTextColor3 = "altTextColor",
    AltTextColor3 = "altTextColor",
    AltTextColor = "altTextColor",
    TextColor3 = "textColor",
    TextColor = "textColor",
    textColor3 = "textColor",
    txtColor = "textColor",
    txtColor3 = "textColor",
    TxtColor = "textColor",
    TxtColor3 = "textColor",
    hasImage = "rendersImage",
    rendersText = "hasText",
    Clicked = "onClick",
    MouseButton1Click = "onClick",
    AltClicked = "onAltClick",
    MouseButton2Click = "onAltClick",
    onMouseDown = "mouseDown",
    MouseButton1Down = "mouseDown",
    onAltMouseDown = "altMouseDown",
    MouseButton2Down = "altMouseDown",
    onMouseUp = "mouseUp",
    MouseButton1Up = "mouseUp",
    onAltMouseUp = "altMouseUp",
    MouseButton2Up = "altMouseUp"
};
local u78 = {
    Frame = "BackgroundTransparency",
    TextLabel = "TextTransparency",
    TextButton = "TextTransparency",
    TextBox = "TextTransparency",
    ImageLabel = "ImageTransparency",
    ImageButton = "ImageTransparency",
    CanvasGroup = "GroupTransparency"
};

local function deepcopy(p79, p80) -- Line: 430
    -- upvalues: deepcopy (copy)
    local v81 = p80 or {};

    if type(p79) ~= "table" then
        return p79;
    end;

    local v82 = v81[p79];

    if v82 then
        return v82;
    end;

    local v83 = {};
    v81[p79] = v83;

    for i, v in next, p79 do
        v83[i] = deepcopy(v, v81);
    end;

    local v84 = getmetatable(p79);
    setmetatable(v83, v84);

    return v83;
end;

local function getSuper(u85, u86) -- Line: 451
    -- upvalues: getSuper (copy)
    return setmetatable({}, {
        __index = function(p87, u88) -- Line: 456, Name: __index
            -- upvalues: u86 (copy), getSuper (ref), u85 (copy)
            local u89 = getmetatable(u86) and getmetatable(u86).__index or u86;

            if u88 == "super" then
                return getSuper(u85, u89);
            end;

            return setmetatable({}, {
                __call = function(...) -- Line: 459, Name: __call
                    -- upvalues: u89 (copy), u88 (copy), u85 (ref), getSuper (ref)
                    local v90 = u89[u88];
                    local v91 = {
                        __super = u85
                    };
                    local v97 = {
                        __index = function(p92, p93) -- Line: 463, Name: __index
                            -- upvalues: getSuper (ref), u85 (ref), u89 (ref)
                            if p93 == "super" then
                                return getSuper(u85, u89);
                            end;

                            return u85[p93];
                        end,

                        __newindex = function(p94, p95, p96) -- Line: 469, Name: __newindex
                            -- upvalues: u85 (ref)
                            u85[p95] = p96;
                        end,

                        __metatable = getmetatable(u85)
                    };

                    return v90(setmetatable(v91, v97), unpack({ ... }, 3, select("#", ...)));
                end
            });
        end
    });
end;

local u98 = {
    parent = true,
    curAnimData = true,
    obj = true,
    animReset = true,
    __super = true
};

local function getExtended(p99) -- Line: 484
    local v100 = {};

    while true do
        local v101 = getmetatable(p99);

        if not (v101 and v101.__index) then
            break;
        end;

        p99 = v101.__index;
        table.insert(v100, p99);
    end;

    return v100;
end;

function u1.Extend(u102) -- Line: 498
    -- upvalues: deepcopy (copy), u98 (copy), getExtended (copy), getSuper (copy)
    local v103 = deepcopy(u102);
    local u104 = setmetatable(v103, {
        __index = u102
    });
    local __index = u102.__index;
    local table_clone_ret = table.clone(u98);

    local function _(p105, p106) -- Line: 505
        -- upvalues: u104 (copy), __index (copy)
        local v107 = u104[p106];

        if v107 then
            return v107;
        end;

        local v108 = __index and __index(p105, p106);

        return v108;
    end;

    function u104.__index(p109, p110) -- Line: 512
        -- upvalues: table_clone_ret (copy), u104 (copy), __index (copy)
        if not table_clone_ret[p110] then
            local v111 = u104[p110];

            if v111 then
                return v111;
            end;

            local v112 = __index and __index(p109, p110);

            return v112;
        end;
    end;

    function u104.__newindex(p113, p114, p115) -- Line: 525
        -- upvalues: u102 (copy)
        if u102.__newindex then
            return u102.__newindex(p113, p114, p115);
        end;

        return rawset(p113, p114, p115);
    end;

    u104.allowedNilCases = table_clone_ret;
    local u116 = getExtended(u104);

    local function v119(...) -- Line: 536
        -- upvalues: u116 (copy), u104 (copy), u102 (copy), getSuper (ref)
        for _, v in u116 do
            rawset(v, "__extended", u104);
        end;

        local v117 = u102.new(...);
        local v118 = setmetatable(v117, u104);
        v118.super = getSuper(v118, u104);

        if rawget(u104, "__extended") == nil then
            v118:postCreate();
        end;

        for _, v in u116 do
            rawset(v, "__extended", nil);
        end;

        return v118;
    end;

    u104.new = v119;

    return u104, v119, u102;
end;

local u132 = {
    scale = function(u120) -- Line: 561
        -- upvalues: Vector2_new (copy)
        return setmetatable({}, {
            __index = function(p121, p122) -- Line: 562, Name: __index
                -- upvalues: u120 (copy), Vector2_new (ref)
                if p122 == "set" then
                    return function(p123, p124) -- Line: 564
                        -- upvalues: u120 (ref), Vector2_new (ref)
                        u120.Scale = Vector2_new(p123, p124);
                    end;
                end;

                if p122 == "get" then
                    return function() -- Line: 568
                        -- upvalues: u120 (ref)
                        return u120.Scale;
                    end;
                end;

                if p122 == "x" or p122 == "y" then
                    return u120.Scale[string.upper(p122)];
                end;

                return u120.Scale;
            end,

            __newindex = function(p125, p126, p127) -- Line: 577, Name: __newindex
                -- upvalues: u120 (copy), Vector2_new (ref)
                if p126 == "x" then
                    u120.Scale = Vector2_new(p127, u120.Scale.Y);

                    return;
                end;

                if p126 == "y" then
                    u120.Scale = Vector2_new(u120.Scale.X, p127);
                end;
            end
        });
    end,

    Position = function(p128) -- Line: 586
        -- upvalues: UDim2_fromScale (copy)
        return UDim2_fromScale(p128:GetProperty("x") / 1280, p128:GetProperty("y") / 720);
    end,

    ResampleMode = function(p129) -- Line: 589
        -- upvalues: Default (copy), Pixelated (copy)
        return p129.antialiasing and Default or Pixelated;
    end,

    size = function(p130) -- Line: 592
        return p130.frameSize;
    end,

    active = function(p131) -- Line: 595
        return p131._active;
    end
};
local u139 = {
    Position = function(p133, p134) -- Line: 601
        rawset(p133, "x", p134.X.Scale * 1280 + p134.X.Offset);
        rawset(p133, "y", p134.Y.Scale * 720 + p134.Y.Offset);
    end,

    ResampleMode = function(p135, p136) -- Line: 606
        -- upvalues: Default (copy)
        rawset(p135, "antialiasing", p136 == Default);
    end,

    active = function(p137, p138) -- Line: 610
        p137:set_active(p138);
    end
};
u1.allowedNilCases = u98;

function u1.__index(p140, p141) -- Line: 618
    -- upvalues: u77 (copy), u98 (copy), u1 (copy), u132 (copy)
    local v142 = u77[p141] or p141;

    if u98[v142] then
        return;
    end;

    local v143 = u1[v142];

    if v143 then
        return v143;
    end;

    local v144 = u132[v142];

    if v144 then
        return v144(p140);
    end;

    local v145;

    if v142 == "BackgroundTransparency" then
        v145 = p140.useBgAlpha;
    else
        v145 = false;
    end;

    if v145 or p140.alphaAlias == v142 then
        return 1 - p140[v145 and "bgAlpha" or "alpha"];
    end;
end;

function u1.__newindex(p146, p147, p148) -- Line: 636
    -- upvalues: u77 (copy), u139 (copy)
    local v149 = u77[p147] or p147;
    local v150 = u139[v149];

    if v150 then
        return v150(p146, p148);
    end;

    local v151;

    if v149 == "BackgroundTransparency" then
        v151 = p146.useBgAlpha;
    else
        v151 = false;
    end;

    if v151 or p146.alphaAlias == v149 then
        return rawset(p146, v151 and "bgAlpha" or "alpha", 1 - p148);
    end;

    rawset(p146, v149, p148);
end;

local v160 = {
    Mult = function(p152: number, p153: number) -- Line: 680, Name: Mult
        return p152 * p153;
    end,

    Sum = function(p154: number, p155: number) -- Line: 683, Name: Sum
        return p154 + p155;
    end,

    Sub = function(p156: number, p157: number) -- Line: 686, Name: Sub
        return p156 - p157;
    end,

    Div = function(p158: number, p159: number) -- Line: 689, Name: Div
        return p158 / p159;
    end
};
local u161 = {};
u161.__index = u161;

function u161.new() -- Line: 696
    -- upvalues: u77 (copy), u161 (copy)
    local u162 = {};

    return setmetatable({
        __real = u162,

        set = function(p163, p164, p165) -- Line: 700, Name: set
            -- upvalues: u77 (ref), u162 (copy)
            local v166 = p163 == "scale" and "Scale" or (u77[p163] or p163);

            if not u162[v166] then
                u162[v166] = {};
            end;

            u162[v166][p164] = p165;
        end,

        get = function(p167, p168) -- Line: 705, Name: get
            -- upvalues: u77 (ref), u162 (copy)
            local v169 = p167 == "scale" and "Scale" or (u77[p167] or p167);

            if u162[v169] then
                return u162[v169][p168];
            end;
        end
    }, {
        __index = u161
    });
end;

function u161.GetPropertyOffsets(p170, p171) -- Line: 713
    return p170.__real[p171];
end;

local Sum = v160.Sum;

function u161.GetOffset(p172: table, p173: any, p174: any, p175: any, p176: table?) -- Line: 719
    -- upvalues: Sum (copy), table_find (copy)
    local v177 = p175 or Sum;
    local v178 = p176 or {};
    local v179 = p173 or 0;

    for i, v in p172.__real[p174] or {} do
        if not table_find(v178, i) then
            if type(v) == "function" then
                v179 = v(v179);
            else
                v179 = v177(v179, v, i);
            end;
        end;
    end;

    return v179;
end;

function u161.Copy(u180) -- Line: 736
    -- upvalues: u161 (copy)
    local v181 = u161.new();
    local u187 = {
        __index = function(p182, p183) -- Line: 740, Name: __index
            -- upvalues: u180 (copy)
            local v184 = u180.__real[p182.__key];

            if v184 then
                v184 = v184[p183];
            end;

            return v184;
        end,

        __iter = function(p185) -- Line: 744, Name: __iter
            -- upvalues: u180 (copy)
            local v186 = {};

            for i, v in pairs(u180.__real[p185.__key] or {}) do
                if i ~= "__key" then
                    v186[i] = v;
                end;
            end;

            for i, v in pairs(p185) do
                if i ~= "__key" then
                    v186[i] = v;
                end;
            end;

            return pairs(v186);
        end
    };
    local u188 = {};

    for i, _ in u180.__real do
        u188[i] = setmetatable({
            __key = i
        }, u187);
        v181.__real[i] = u188[i];
    end;

    setmetatable(v181.__real, {
        __index = function(p189, p190) -- Line: 769, Name: __index
            -- upvalues: u188 (copy)
            return u188[p190];
        end,

        __newindex = function(p191, p192, p193) -- Line: 773, Name: __newindex
            -- upvalues: u187 (copy), u188 (copy)
            local v194 = setmetatable({
                __key = p192
            }, u187);
            u188[p192] = v194;

            return rawset(p191, p192, v194);
        end
    });

    return v181;
end;

function u161.Clone(p195) -- Line: 783
    -- upvalues: u161 (copy), table_clone (copy)
    local v196 = u161.new();

    for i, v in p195.__real do
        v196.__real[i] = table_clone(v);
    end;

    return v196;
end;

function u1.new(p197: userdata, p198, p199: boolean?, p200: boolean?, p201: boolean?) -- Line: 823
    -- upvalues: u9 (copy), u10 (copy), u4 (ref), u161 (copy), Vector2_new (copy), u78 (copy), getSuper (copy), u1 (copy), new (copy)
    if not p197 then
        print("no obj");

        return nil;
    end;

    local _ = p200 == nil and true or p200;
    local v202 = {
        Obj = p197,
        objClass = p197.ClassName,
        curAnim = "",
        curFrame = 1,
        timer = 0,
        Finished = false,
        Paused = true,
        Speed = 1,
        Playing = false,
        Scale = u9,
        sFactors = p198 or u10,
        useFactorsForPosition = false,
        useFrameOffsets = false,
        Animations = {},
        frameSize = {
            x = 100,
            y = 100
        },
        rawFrameSize = {
            x = 100,
            y = 100
        },
        currentSize = {
            x = 0,
            y = 0
        },
        size = p197.ClassName ~= "ImageLabel" and ({
            x = p197.AbsoluteSize.X / u4.X * 1280,
            y = p197.AbsoluteSize.Y / u4.Y * 720
        } or nil) or nil,
        currentFrame = nil,
        loadedGraphic = nil,
        offsets = u161.new(),
        keepSpriteRatio = true,
        curAnimData = nil,
        sizeCache = table.create(4),
        flipX = false,
        flipY = false,
        _active = false,
        alive = true,
        killed = false,
        useScale = true,
        changeSize = true,
        Destroyed = false,
        isObjAlive = true,
        copies = {},
        copier = false,
        destroyObj = p199 == nil and true or p199 or false,
        useAngleAnchor = false,
        x = 0,
        y = 0,
        angle = p197.Rotation,
        visible = p197.Visible,
        anchor = p197.AnchorPoint,
        rectSizeOffset = u9,
        rectImageOffset = Vector2_new(0, 0),
        __parentSize = u9,
        alpha = 1 - p197[u78[p197.ClassName]],
        bgAlpha = 1 - p197.BackgroundTransparency,
        useBgAlpha = u78[p197.ClassName] ~= "BackgroundTransparency",
        alphaAlias = u78[p197.ClassName],
        zindex = p197.ZIndex,
        bsp = p197.BorderSizePixel,
        bsColor = p197.BorderColor3,
        bgColor = p197.BackgroundColor3,
        angleAnchor = Vector2_new(0.5, 0.5),
        rendersImage = p197:IsA("ImageLabel") or p197:IsA("ImageButton"),
        parent = p197.Parent,
        className = "Sprite",
        __currentProperties = {}
    };
    v202.super = getSuper(v202, u1);

    if v202.rendersImage then
        v202.imageColor = p197.ImageColor3 or Color3.new(1, 1, 1);
        v202.antialiasing = p197.ResampleMode == Enum.ResamplerMode.Default;
        local v203 = new();
        local v204 = new();
        local v205 = new();
        local v206 = new();
        local v207 = new();
        v202.AnimationStarted = v203;
        v202.AnimationEnded = v204;
        v202.AnimationLooped = v205;
        v202.AnimationAdded = v206;
        v202.AnimationRemoved = v207;
    end;

    local v208 = setmetatable(v202, u1);
    v202:SetObj(p197);

    if not p201 then
        v202:set_active(true);
    end;

    return v208;
end;

function u1.postCreate(p209) -- Line: 951
    local v210 = p209.__super or p209;
    rawset(v210, "Update", v210.Update);
    rawset(v210, "__updateProperty", v210.__updateProperty);
    rawset(v210, "Destroy", v210.Destroy);
    rawset(v210, "GetProperty", v210.GetProperty);
    rawset(v210, "SetObj", v210.SetObj);
    rawset(v210, "set_active", v210.set_active);
    rawset(v210, "UpdateSize", v210.UpdateSize);
    rawset(v210, "UpdateFrame", v210.UpdateFrame);
    rawset(v210, "UpdateObj", v210.UpdateObj);
    rawset(v210, "UpdateAnimation", v210.UpdateAnimation);
end;

function u1.SetObj(u211, p212) -- Line: 974
    if u211.objDestroying then
        u211.objDestroying:Disconnect();
        u211.objDestroying = nil;
    end;

    if u211.objParentChanged then
        u211.objParentChanged:Disconnect();
        u211.objParentChanged = nil;
    end;

    u211.Obj = p212;

    if not p212 then
        return;
    end;

    u211.objDestroying = p212.Destroying:Once(function() -- Line: 981
        -- upvalues: u211 (copy)
        u211.isObjAlive = false;

        if u211.alive then
            u211.objDestroying = nil;
            u211:Destroy();
        end;
    end);
end;

function u1.IsA(p213, p214) -- Line: 994
    return p213.className == p214 and true or p213.Obj:IsA(p214);
end;

function u1.AddSparrowByResults(p215, p216, p217, ...) -- Line: 998
    -- upvalues: table_find (copy)
    if p216 == nil then
        return;
    end;

    local AnimationsFromXml = p215:GetAnimationsFromXml(p216);
    local v218 = { ... };

    for _, v in p217 or {} do
        local v219 = v:gsub("0", "");

        if table_find(AnimationsFromXml, v219 or "") then
            p215:AddSparrowXml(p216, unpack(v218, 1, 1), v219 .. "0", unpack(v218, 2, select("#", ...)));

            return;
        end;
    end;
end;

u1.AddAnimationByResults = u1.AddSparrowByResults;

function u1.GetAnimFramesByResults(p220, p221, p222, p223, p224) -- Line: 1016
    -- upvalues: table_find (copy)
    if p221 == nil then
        return nil;
    end;

    local AnimationsFromXml = p220:GetAnimationsFromXml(p221);

    for _, v in p222 or {} do
        local v225 = v:gsub("0", "");

        if table_find(AnimationsFromXml, v225 or "") then
            local AnimFramesXml = p220:GetAnimFramesXml(p221, v225 .. "0", p223, p224);

            if AnimFramesXml then
                return AnimFramesXml;
            end;
        end;
    end;

    return nil;
end;

local u226 = {
    Scale = v160.Mult,
    Speed = v160.Mult,
    alpha = v160.Mult,
    bgAlpha = v160.Mult,
    bsp = v160.Mult,
    rectSizeOffset = v160.Mult
};

function u1.GetProperty(p227, p228, p229) -- Line: 1042
    -- upvalues: u226 (copy)
    return p227.offsets:GetOffset(p227[p228], p228, u226[p228], p229);
end;

function u1.GetOffset(p230, p231, p232, p233) -- Line: 1046
    -- upvalues: u226 (copy)
    return p230.offsets:GetOffset(p232, p231, u226[p231], p233);
end;

function u1.isRendered(p234) -- Line: 1050
    local Property = p234:GetProperty("Scale");
    local v235;

    if Property.X == 0 or Property.Y == 0 then
        v235 = false;
    else
        v235 = p234.visible and p234.parent ~= nil;
    end;

    return v235;
end;

function u1.Update(p236, p237) -- Line: 1055
    local v238 = p237 or 0;
    local Obj = p236.Obj;

    if not Obj then
        return;
    end;

    local rendersImage = p236.rendersImage;

    if rendersImage then
        p236:UpdateAnimation(v238);
    end;

    local __currentProperties = p236.__currentProperties;

    if not p236.parent then
        if __currentProperties.Parent == nil then
            return;
        end;

        __currentProperties.Parent = nil;

        if Obj == nil then
            return;
        end;

        Obj.Parent = nil;

        return;
    end;

    if not p236.visible then
        if __currentProperties.Visible == false then
            return;
        end;

        __currentProperties.Visible = false;

        if Obj == nil then
            return;
        end;

        Obj.Visible = false;

        return;
    end;

    if p236:GetProperty("alpha") ~= 0 then
        if rendersImage then
            p236:UpdateFrame();
        end;

        p236:UpdateObj();
        p236:UpdateSize();

        return;
    end;

    local alphaAlias = p236.alphaAlias;

    if __currentProperties[alphaAlias] == 1 then
        return;
    end;

    __currentProperties[alphaAlias] = 1;

    if Obj == nil then
        return;
    end;

    Obj[alphaAlias] = 1;
end;

local function rotateAroundAnchor(p239: userdata, p240, p241: number, p242) -- Line: 1105
    -- upvalues: math_cos (copy), math_sin (copy), UDim2_fromOffset (copy)
    local AbsoluteSize = p239.AbsoluteSize;
    local v243 = AbsoluteSize * p240;
    local v244 = p239.AbsolutePosition - v243;
    local v245 = v244 + AbsoluteSize / 2;
    local v246 = v244 + v243;
    local v247 = math_cos(p241);
    local v248 = math_sin(p241);
    local v249 = v246 - v245;
    local v250 = v246 - v245;
    p239.Position = p242 + UDim2_fromOffset(v250.X - (v249.X * v247 - v249.Y * v248), v250.Y - (v249.X * v248 + v249.Y * v247));
end;

local function vectorToRatio(p251, p252: number) -- Line: 1126
    -- upvalues: math_round (copy), Vector2_new (copy)
    local X = p251.X;
    local Y = p251.Y;
    local v253 = math_round(Y * p252);

    if X <= v253 then
        return Vector2_new(X, (math_round(X / p252)));
    end;

    return Vector2_new(v253, Y);
end;

function u1.__parentChanged(p254: table, p255: userdata) -- Line: 1139
    -- upvalues: u9 (copy)
    if p254.__parentConnection then
        p254.__parentConnection:Disconnect();
        p254.__parentConnection = nil;
    end;

    if p255 then
        p254.__parentSize = u9;

        return;
    end;

    p254.__parentSize = u9;
end;

function u1.set_active(p256, p257) -- Line: 1193
    -- upvalues: u2 (ref), u3 (copy), table_remove (copy), table_find (copy)
    if p256._active == p257 then
        return;
    end;

    if p257 then
        u2 = u2 + 1;
        u3[u2] = p256;
    else
        table_remove(u3, table_find(u3, p256));
        u2 = u2 - 1;
    end;

    p256._active = p257;
end;

function u1.__updateProperty(p258, p259, p260, p261) -- Line: 1206
    local __currentProperties = p258.__currentProperties;

    if __currentProperties[p260] == p261 then
        return;
    end;

    __currentProperties[p260] = p261;
    p259[p260] = p261;
end;

function u1.__updateCachedProp(p262, p263, p264, p265) -- Line: 1212
    local __currentProperties = p262.__currentProperties;

    if __currentProperties[p264] == p265 then
        return;
    end;

    __currentProperties[p264] = p265;
end;

function u1.ForceUpdate(p266) -- Line: 1218
    p266.__currentProperties = {};
    p266.sizeCache = {};
    p266:Update(0);
end;

function u1.UpdateObj(p267) -- Line: 1224
    -- upvalues: u10 (copy), rotateAroundAnchor (copy), math_rad (copy), UDim2_fromScale (copy), Default (copy), Pixelated (copy)
    local Obj = p267.Obj;
    local __currentProperties = p267.__currentProperties;

    if __currentProperties.Visible ~= true then
        __currentProperties.Visible = true;

        if Obj ~= nil then
            Obj.Visible = true;
        end;
    end;

    local anchor = p267.anchor;

    if __currentProperties.AnchorPoint ~= anchor then
        __currentProperties.AnchorPoint = anchor;

        if Obj ~= nil then
            Obj.AnchorPoint = anchor;
        end;
    end;

    local Property = p267:GetProperty("x");
    local Property2 = p267:GetProperty("y");
    local v268 = p267.useFactorsForPosition and p267.sFactors or u10;
    local v269;

    if __currentProperties.x == Property then
        v269 = __currentProperties._x;
    else
        __currentProperties.x = Property;
        v269 = Property / v268.X;
        __currentProperties._x = v269;
    end;

    local v270;

    if __currentProperties.y == Property2 then
        v270 = __currentProperties._y;
    else
        __currentProperties.y = Property2;
        v270 = Property2 / v268.Y;
        __currentProperties._y = v270;
    end;

    local Property3 = p267:GetProperty("angle");

    if p267.useAngleAnchor then
        rotateAroundAnchor(Obj, p267.angleAnchor, math_rad(Property3), UDim2_fromScale(v269, v270));
    else
        local v271 = UDim2_fromScale(v269, v270);

        if __currentProperties.Position ~= v271 then
            __currentProperties.Position = v271;

            if Obj ~= nil then
                Obj.Position = v271;
            end;
        end;
    end;

    if __currentProperties.Rotation ~= Property3 then
        __currentProperties.Rotation = Property3;

        if Obj ~= nil then
            Obj.Rotation = Property3;
        end;
    end;

    local alphaAlias = p267.alphaAlias;
    local v272 = 1 - p267:GetProperty("alpha");

    if __currentProperties[alphaAlias] ~= v272 then
        __currentProperties[alphaAlias] = v272;

        if Obj ~= nil then
            Obj[alphaAlias] = v272;
        end;
    end;

    if p267.useBgAlpha then
        local v273 = 1 - p267:GetProperty("bgAlpha");

        if __currentProperties.BackgroundTransparency ~= v273 then
            __currentProperties.BackgroundTransparency = v273;

            if Obj ~= nil then
                Obj.BackgroundTransparency = v273;
            end;
        end;
    end;

    local zindex = p267.zindex;

    if __currentProperties.ZIndex ~= zindex then
        __currentProperties.ZIndex = zindex;

        if Obj ~= nil then
            Obj.ZIndex = zindex;
        end;
    end;

    local bgColor = p267.bgColor;

    if __currentProperties.BackgroundColor3 ~= bgColor then
        __currentProperties.BackgroundColor3 = bgColor;

        if Obj ~= nil then
            Obj.BackgroundColor3 = bgColor;
        end;
    end;

    local bsp = p267.bsp;

    if __currentProperties.BorderSizePixel ~= bsp then
        __currentProperties.BorderSizePixel = bsp;

        if Obj ~= nil then
            Obj.BorderSizePixel = bsp;
        end;
    end;

    local bsColor = p267.bsColor;

    if __currentProperties.BorderColor3 ~= bsColor then
        __currentProperties.BorderColor3 = bsColor;

        if Obj ~= nil then
            Obj.BorderColor3 = bsColor;
        end;
    end;

    if p267.rendersImage then
        local v274 = p267.antialiasing and Default or Pixelated;

        if __currentProperties.ResampleMode ~= v274 then
            __currentProperties.ResampleMode = v274;

            if Obj ~= nil then
                Obj.ResampleMode = v274;
            end;
        end;

        local imageColor = p267.imageColor;

        if __currentProperties.ImageColor3 ~= imageColor then
            __currentProperties.ImageColor3 = imageColor;

            if Obj ~= nil then
                Obj.ImageColor3 = imageColor;
            end;
        end;
    end;

    local parent = p267.parent;

    if __currentProperties.Parent == parent then
        return;
    end;

    __currentProperties.Parent = parent;

    if Obj == nil then
        return;
    end;

    Obj.Parent = parent;
end;

function u1.UpdateFrame(p275) -- Line: 1287
    -- upvalues: Vector2_new (copy)
    local curAnimData = p275.curAnimData;

    if not curAnimData then
        return;
    end;

    local Property = p275:GetProperty("Scale");

    if Property.X == 0 or Property.Y == 0 then
        return;
    end;

    local v276 = curAnimData.Frames[p275.curFrame];

    if not v276 then
        return;
    end;

    local Obj = p275.Obj;
    local __currentProperties = p275.__currentProperties;
    local v277 = p275.contentOverride or (v276.ImageContent or curAnimData.ImageContent);

    if v277 and __currentProperties.ImageContent ~= v277 then
        __currentProperties.ImageContent = v277;

        if Obj ~= nil then
            Obj.ImageContent = v277;
        end;
    end;

    p275.currentFrame = v276;
    local FrameSize = v276.FrameSize;
    local RawFrameSize = v276.RawFrameSize;

    if FrameSize then
        local frameSize = p275.frameSize;
        local Y = FrameSize.Y;
        frameSize.x = FrameSize.X;
        frameSize.y = Y;
    end;

    if RawFrameSize then
        local rawFrameSize = p275.rawFrameSize;
        local Y = RawFrameSize.Y;
        rawFrameSize.x = RawFrameSize.X;
        rawFrameSize.y = Y;
    end;

    p275.offsets.set("angle", "rotated", v276.Rotated and 90 or 0);

    if p275.useFrameOffsets then
        local FrameOffset = v276.FrameOffset;

        if FrameOffset then
            p275.offsets.set("x", "curFrameX", FrameOffset.X * Property.X);
            p275.offsets.set("y", "curFrameY", FrameOffset.Y * Property.Y);
        else
            p275.offsets.set("x", "curFrameX", 0);
            p275.offsets.set("y", "curFrameY", 0);
        end;
    end;

    local v278 = (p275.flipX and -1 or 1) * (Property.X < 0 and -1 or 1) * (curAnimData.FlipX and -1 or 1);
    local v279 = (p275.flipY and -1 or 1) * (Property.Y < 0 and -1 or 1) * (curAnimData.FlipY and -1 or 1);
    local v280 = v276.Size * p275:GetProperty("rectSizeOffset");
    local v281 = v276.Offset + p275:GetProperty("rectImageOffset") + Vector2_new(v278 == -1 and (v280.X or 0) or 0, v279 == -1 and (v280.Y or 0) or 0);
    local v282 = v280 * Vector2_new(v278, v279);

    if __currentProperties.ImageRectSize ~= v282 then
        __currentProperties.ImageRectSize = v282;

        if Obj ~= nil then
            Obj.ImageRectSize = v282;
        end;
    end;

    if __currentProperties.ImageRectOffset == v281 then
        return;
    end;

    __currentProperties.ImageRectOffset = v281;

    if Obj == nil then
        return;
    end;

    Obj.ImageRectOffset = v281;
end;

function u1.UpdateAnimation(p283: table, p284: number) -- Line: 1346
    local curAnimData = p283.curAnimData;

    if not (p283.Finished or (not curAnimData or p283.copier)) then
        local v285 = #curAnimData.Frames;
        local v286 = v285 == 1;
        local Looped = curAnimData.Looped;

        if v286 and Looped then
            p283.Finished = true;

            return;
        end;

        local v287 = curAnimData.Framerate or 24;

        if v287 == 0 then
            p283.AnimationEnded:Fire(p283.curAnim);
            p283.Finished = true;

            return;
        end;

        p283.timer = p283.timer + p284 * p283:GetProperty("Speed");
        local v288 = 1 / v287;
        local curFrame = p283.curFrame;
        local v289 = p283.timer // v288;

        if v286 and v289 ~= 0 then
            p283.AnimationEnded:Fire(p283.curAnim);
            p283.Finished = true;

            return;
        end;

        p283.timer = p283.timer - v289 * v288;
        local v290 = curFrame + v289 % v285;

        if v285 < v290 then
            if Looped then
                v285 = v290 - v285;
                p283.AnimationLooped:Fire(p283.curAnim);
            else
                p283.AnimationEnded:Fire(p283.curAnim);
                p283.Finished = true;
            end;
        else
            v285 = v290;
        end;

        p283.curFrame = v285;
    end;
end;

function u1.ResetAnimation(p291) -- Line: 1418
    if p291.animReset then
        p291.animReset:Disconnect();
        p291.animReset = nil;
    end;

    p291.Finished = false;
    p291.curFrame = 1;
    p291.timer = 0;
    local curAnimData = p291.curAnimData;

    if not curAnimData then
        return;
    end;

    local v292 = curAnimData.Frames[1];

    if not v292 then
        return;
    end;

    local FrameSize = v292.FrameSize;
    local RawFrameSize = v292.RawFrameSize;

    if FrameSize then
        local frameSize = p291.frameSize;
        local Y = FrameSize.Y;
        frameSize.x = FrameSize.X;
        frameSize.y = Y;
    end;

    if RawFrameSize then
        local rawFrameSize = p291.rawFrameSize;
        local Y = RawFrameSize.Y;
        rawFrameSize.x = RawFrameSize.X;
        rawFrameSize.y = Y;
    end;
end;

function u1.PlayAnimation(u293, p294, p295) -- Line: 1445
    local v296 = u293.Animations[p294];

    if not v296 then
        warn((`[Sprite] Missing animation {p294}`));

        return {
            resetAnim = nil,
            resetTime = 0
        };
    end;

    if u293.curAnim == p294 and not p295 then
        return {
            resetAnim = nil,
            resetTime = 0
        };
    end;

    u293.curAnimData = v296;
    u293.curAnim = p294;
    u293:ResetAnimation();
    u293.AnimationStarted:Fire(u293.curAnim);
    local u297 = {
        resetAnim = nil,
        resetTime = 0
    };
    local u298 = nil;
    u298 = u293.AnimationEnded:Once(function() -- Line: 1463
        -- upvalues: u297 (copy), u293 (copy), u298 (ref)
        if u297.resetTime > 0 then
            task.wait(u297.resetTime / u293:GetProperty("Speed"));
        end;

        if u298 ~= u293.animReset or not u293.alive then
            return;
        end;

        u293.animReset = nil;

        if u297.resetAnim then
            u293:Play(u297.resetAnim);
        end;
    end);
    u293.animReset = u298;

    return u297;
end;

function u1.Play(p299, ...) -- Line: 1482
    return p299:PlayAnimation(...);
end;

local u302 = {
    __index = function(p300, p301) -- Line: 1487, Name: __index
        return setmetatable({}, {
            __call = function() -- Line: 1488, Name: __call
            end
        });
    end
};
local table_clear = table.clear;

local function realDestroy(p303) -- Line: 1496
    -- upvalues: table_find (copy), u3 (copy), table_remove (copy), u2 (ref), table_clear (copy), u302 (copy)
    if not p303 then
        return;
    end;

    local u304 = p303.__super or p303;
    local v305 = table_find(u3, u304);

    if v305 then
        table_remove(u3, v305);
        u2 = u2 - 1;
    end;

    p303.alive = false;

    if u304.destroyObj and u304.Obj then
        pcall(function() -- Line: 1506
            -- upvalues: u304 (copy)
            u304.Obj:Destroy();
        end);
    end;

    p303:SetObj(nil);
    table_clear(u304);
    setmetatable(u304, u302);
    p303.Destroyed = true;
    p303.alive = false;
    p303.killed = true;
end;

function u1.Destroy(p306) -- Line: 1522
    -- upvalues: realDestroy (copy)
    for _, v in p306.copier and {} or p306.copies do
        realDestroy(v);
    end;

    realDestroy(p306);
end;

u1.Kill = u1.Destroy;

function u1.Clone(p307, p308) -- Line: 1532
    -- upvalues: deepcopy (copy), table_clone (copy), getSuper (copy), u2 (ref), u3 (copy)
    local Animations = p307.Animations;
    p307.Animations = nil;
    local offsets = p307.offsets;
    p307.offsets = nil;
    local v309 = deepcopy(p307.__super or p307);
    v309.offsets = offsets:Clone();
    v309.Animations = table_clone(Animations);
    p307.Animations = Animations;
    p307.offsets = offsets;

    if not p308 then
        p308 = p307.Obj and p307.Obj:Clone();
    end;

    v309.Obj = p308;
    v309.__currentProperties = {};
    v309.sizeCache = {};
    v309.copies = {};
    v309.parent = nil;
    local v310 = getmetatable(v309);

    if v310 then
        v309.super = getSuper(v309, v310);
    end;

    v309:SetObj(v309.Obj);

    if v309._active then
        u2 = u2 + 1;
        u3[u2] = v309;
    end;

    return v309;
end;

function u1.Copy(p311, p312, p313) -- Line: 1571
    -- upvalues: u2 (ref), u3 (copy)
    local v314 = {};

    if not p313 then
        p313 = p311.Obj and p311.Obj:Clone();
    end;

    v314.Obj = p313;
    v314.offsets = p311.offsets:Copy();
    v314.__currentProperties = {};
    v314.sizeCache = {};
    v314.copies = {};
    v314.copier = true;
    setmetatable(v314, {
        __index = p311.__super or p311
    });
    v314:SetObj(v314.Obj);

    if p311._active then
        u2 = u2 + 1;
        u3[u2] = v314;
    end;

    if not p312 then
        local copies = p311.copies;
        copies[#copies + 1] = v314;
    end;

    return v314;
end;

u1.Imitate = u1.Copy;

local function compareTables(p315: table, p316: table) -- Line: 1603
    if #p315 ~= #p316 then
        return false;
    end;

    local v317 = true;

    for i = 1, #p315 do
        if v317 then
            v317 = p315[i] == p316[i];
        end;

        if not v317 then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

local u318 = {};

local function cacheScreenRatio(p319: number) -- Line: 1620
    -- upvalues: u4 (ref), math_round (copy), Vector2_new (copy), u318 (ref)
    local X = u4.X;
    local Y = u4.Y;
    local v320 = math_round(Y * p319);

    if X <= v320 then
        local v321 = Vector2_new(X, (math_round(X / p319)));
        u318[p319] = v321;

        return v321;
    end;

    local v322 = Vector2_new(v320, Y);
    u318[p319] = v322;

    return v322;
end;

function u1.UpdateSize(p323) -- Line: 1637
    -- upvalues: u4 (ref), u318 (ref), math_round (copy), Vector2_new (copy), UDim2_fromScale (copy), UDim2_fromOffset (copy)
    if not p323.changeSize then
        return;
    end;

    local Obj = p323.Obj;
    local frameSize = p323.frameSize;
    local x = frameSize.x;
    local y = frameSize.y;
    local Property = p323:GetProperty("Scale");
    local sizeCache = p323.sizeCache;

    if sizeCache[1] == x and (sizeCache[2] == y and (sizeCache[3] == Property and sizeCache[4] == u4)) then
        return;
    end;

    sizeCache[1] = x;
    sizeCache[2] = y;
    sizeCache[3] = Property;
    sizeCache[4] = u4;
    local sFactors = p323.sFactors;
    local v324;

    if p323.keepSpriteRatio then
        local v325 = x / y;
        v324 = v325 ~= v325 and u4 or u318[v325];

        if not v324 then
            local X = u4.X;
            local Y = u4.Y;
            local v326 = math_round(Y * v325);

            if X <= v326 then
                v324 = Vector2_new(X, (math_round(X / v325)));
                u318[v325] = v324;
            else
                v324 = Vector2_new(v326, Y);
                u318[v325] = v324;
            end;
        end;
    else
        v324 = sFactors;
    end;

    local v327 = v324 / sFactors;
    local v328 = x * Property.X * v327.X;
    local v329 = y * Property.Y * v327.Y;
    local currentSize = p323.currentSize;
    currentSize.x = v328;
    currentSize.y = v329;
    local __currentProperties = p323.__currentProperties;

    if not p323.useScale then
        local v330 = UDim2_fromOffset(v328, v329);

        if __currentProperties.Size == v330 then
            return;
        end;

        __currentProperties.Size = v330;
        Obj.Size = v330;

        return;
    end;

    local v331 = sFactors * v327;
    local v332 = UDim2_fromScale(v328 / v331.X, v329 / v331.Y);

    if __currentProperties.Size == v332 then
        return;
    end;

    __currentProperties.Size = v332;
    Obj.Size = v332;
end;

function u1.AddBaseAnimation(p333: table, p334: string, p335: table) -- Line: 1687
    -- upvalues: fixFrames (copy)
    p335.Playing = false;

    if p335.Frames then
        fixFrames(p335.Frames);
    end;

    p333.Animations[p334] = p335;
end;

function u1.CopyAnimationsFrom(p336, p337) -- Line: 1697
    for i, v in p337.Animations do
        p336:AddBaseAnimation(i, v);
    end;
end;

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 1724
    -- upvalues: u4 (ref), Vector2_new (copy), u318 (ref)
    u4 = workspace.CurrentCamera.ViewportSize + Vector2_new(0, 1);
    u318 = {};
end);
game:GetService("RunService"):BindToRenderStep("_SpriteRenderer", Enum.RenderPriority.Last.Value + 1000, function(p338) -- Line: 1729
    -- upvalues: u2 (ref), u3 (copy)
    debug.profilebegin("Sprite Update");

    for i = u2, 1, -1 do
        u3[i]:Update(p338);
        local _ = i;
    end;

    debug.profileend();
end);

return u1;