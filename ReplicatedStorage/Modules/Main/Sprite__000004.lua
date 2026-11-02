-- Decompiled with Potassium's decompiler.

local math_sin = math.sin;
local math_cos = math.cos;
local _ = math.rad;
local Vector2_new = Vector2.new;

local function _(p1) -- Line: 144
    return select(2, xpcall(p1, function() -- Line: 145
        local debug_info_ret = debug.info(2, "f");

        if debug_info_ret == error or not debug_info_ret then
            debug_info_ret = nil;
        end;

        return debug_info_ret;
    end)) or warn("HEY BUDDY THIS METAMETHOD SUCKS");
end;

local u5 = select(2, xpcall(function() -- Line: 151
    Instance.new("ImageLabel").THOSEWHOKNOWSIGMA = true;
end, function() -- Line: 145
    local debug_info_ret = debug.info(2, "f");

    if debug_info_ret == error or not debug_info_ret then
        debug_info_ret = nil;
    end;

    return debug_info_ret;
end)) or warn("HEY BUDDY THIS METAMETHOD SUCKS") or (warn("this metamethod broke") or function(p2, p3, p4) -- Line: 153
    p2[p3] = p4;
end);
local u8 = select(2, xpcall(function() -- Line: 157
    return Vector2.zero["erm what the sigma"];
end, function() -- Line: 145
    local debug_info_ret = debug.info(2, "f");

    if debug_info_ret == error or not debug_info_ret then
        debug_info_ret = nil;
    end;

    return debug_info_ret;
end)) or warn("HEY BUDDY THIS METAMETHOD SUCKS") or function(p6, p7) -- Line: 159
    return p6[p7];
end;
local u11 = select(2, xpcall(function() -- Line: 163
    return Vector2.zero + nil;
end, function() -- Line: 145
    local debug_info_ret = debug.info(2, "f");

    if debug_info_ret == error or not debug_info_ret then
        debug_info_ret = nil;
    end;

    return debug_info_ret;
end)) or warn("HEY BUDDY THIS METAMETHOD SUCKS") or function(p9, p10) -- Line: 165
    return p9 + p10;
end;
local u14 = select(2, xpcall(function() -- Line: 169
    return Vector2.zero * nil;
end, function() -- Line: 145
    local debug_info_ret = debug.info(2, "f");

    if debug_info_ret == error or not debug_info_ret then
        debug_info_ret = nil;
    end;

    return debug_info_ret;
end)) or warn("HEY BUDDY THIS METAMETHOD SUCKS") or function(p12, p13: any) -- Line: 171
    return p12 * p13;
end;

if not (select(2, xpcall(function() -- Line: 175
    return UDim2.new() + nil;
end, function() -- Line: 145
    local debug_info_ret = debug.info(2, "f");

    if debug_info_ret == error or not debug_info_ret then
        debug_info_ret = nil;
    end;

    return debug_info_ret;
end)) or warn("HEY BUDDY THIS METAMETHOD SUCKS")) then
    local function _(p15, p16) -- Line: 177
        return p15 + p16;
    end;
end;

local math_round = math.round;
local UDim2_fromScale = UDim2.fromScale;
local _ = UDim2.new;
local UDim2_fromOffset = UDim2.fromOffset;
local table_find = table.find;
local _ = table.insert;
local table_clone = table.clone;
local UDim2_fromScale_ret = UDim2.fromScale(0, 0);
local Default = Enum.ResamplerMode.Default;
local Pixelated = Enum.ResamplerMode.Pixelated;
debug.setmemorycategory("SPRITE MANAGER");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Lib = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Lib");
local XMLParser = require(Lib.XML.XMLParser);
local new = require(Lib.Signal).new;
local Class = require(Lib.Class);
local u17, v18 = Class.newClass();
u17.__minz = true;
local u19 = 0;
local u20 = setmetatable({}, {
    __mode = "v"
});
local u21 = workspace.CurrentCamera.ViewportSize + Vector2_new(0, 1);
local X = u21.X;
local Y = u21.Y;
local u22 = Vector2_new(1, 1);
local u23 = Vector2_new(1280, 720);
local _ = u23.X;
local _ = u23.Y;

local function parseImageId(p24) -- Line: 220
    if tonumber(p24) then
        p24 = "rbxassetid://" .. p24;
    end;

    return p24;
end;

local Vector2_new_ret = Vector2.new(100, 100);

local function getImageIdFromName(p25: any, p26: string) -- Line: 228
    for _, v in p25.children do
        if v.tag == "Image" then
            local attrs = v.attrs;

            if attrs.name == p26 then
                return tonumber(attrs.id);
            end;
        end;
    end;

    return nil;
end;

local function fixFrames(p27, p28) -- Line: 239
    -- upvalues: Vector2_new_ret (copy)
    for _, v in p27 do
        if not v._fixed then
            local v29 = v.Image or (v.ImageId or p28);

            if v29 and not v.ImageContent then
                if tonumber(v29) then
                    v29 = "rbxassetid://" .. v29;
                end;

                v.ImageContent = typeof(v29) == "Content" and v29 and v29 or Content.fromUri(v29);
                v.Image = nil;
                v.ImageId = nil;
            end;

            v.FrameSize = v.FrameSize or Vector2_new_ret;
            v.RawFrameSize = v.RawFrameSize or v.FrameSize;
            v._sizeX = v.Size.X;
            v._sizeY = v.Size.Y;
            v._offsetX = v.Offset.X;
            v._offsetY = v.Offset.Y;
            v._frameSizeX = v.FrameSize.X;
            v._frameSizeY = v.FrameSize.Y;
            v._rawFrameSizeX = v.RawFrameSize.X;
            v._rawFrameSizeY = v.RawFrameSize.Y;

            if v.FrameOffset then
                v._frameOffsetX = v.FrameOffset.X;
                v._frameOffsetY = v.FrameOffset.Y;
            else
                v._frameOffsetX = 0;
                v._frameOffsetY = 0;
            end;

            v._fixed = true;
        end;
    end;
end;

function u17.AddAnimation(p30: table, p31: string, p32: table?, p33: number?, p34: boolean?, p35: any) -- Line: 279
    -- upvalues: fixFrames (copy)
    local v36 = p32 or {};

    if tonumber(p35) then
        p35 = "rbxassetid://" .. p35;
    end;

    fixFrames(v36, p35);
    local Animations = p30.Animations;
    local v37 = {
        Playing = false,
        FlipY = false,
        FlipX = false,
        Frames = v36,
        Framerate = p33 or 24,
        Looped = p34 or false
    };
    local v38;

    if p35 then
        v38 = typeof(p35) == "Content" and p35 and p35 or (Content.fromUri(p35) or nil);
    else
        v38 = nil;
    end;

    v37.ImageContent = v38;
    Animations[p31] = v37;
    p30.AnimationAdded:Fire(p31);
end;

local u39 = {};

function u17.clearXmlCache(p40) -- Line: 303
    -- upvalues: u39 (ref)
    u39 = {};
end;

function u17.GetImageMetadata(p41, p42) -- Line: 307
    for _, v in p42.children do
        if v.tag == "ImageMetadata" then
            return v;
        end;
    end;

    return nil;
end;

function u17.GetMetadata(p43, p44) -- Line: 317
    for _, v in p44.children do
        if v.tag == "Metadata" then
            return v;
        end;
    end;

    return nil;
end;

function u17.GetAnimationsFromXml(p45: table, p46: any, p47: boolean) -- Line: 327
    -- upvalues: u39 (ref), XMLParser (copy), table_find (copy)
    if u39[p46] and not p47 then
        return u39[p46];
    end;

    if typeof(p46) == "Instance" then
        p46 = require(p46);
    end;

    local v48 = {};

    for _, v in XMLParser.parse(p46, true).children do
        for _, v2 in v.children do
            if v2.tag == "SubTexture" and not table_find(v48, v2.attrs.name:sub(1, -5)) then
                v48[#v48 + 1] = v2.attrs.name:sub(1, -5);
            end;
        end;
    end;

    u39[p46] = v48;

    return v48;
end;

function u17.AddSparrowXml(p49: table, p50: any, p51: string, p52: string, p53: number, p54: boolean, p55: number, p56: any, p57: any) -- Line: 351
    local AnimFramesXml = p49:GetAnimFramesXml(p50, p52, p55, p56);

    if AnimFramesXml and #AnimFramesXml > 0 then
        return p49:AddAnimation(p51, AnimFramesXml, p53, p54, p57);
    end;
end;

function u17.LoadAnimationsFromXml(p58, p59) -- Line: 359
    -- upvalues: u39 (ref), XMLParser (copy)
    if u39[p59] then
        p59 = u39[p59];
    end;

    if typeof(p59) == "Instance" then
        p59 = require(p59) or p59;
    end;

    local v60 = XMLParser.parse(p59, true);

    if not v60 then
        return;
    end;

    local Metadata = p58:GetMetadata(v60);

    if not Metadata then
        return;
    end;

    for _, v in Metadata.children do
        if v.tag == "Animation" then
            local attrs = v.attrs;
            local AnimFramesXml = p58:GetAnimFramesXml(p59, attrs.prefix, tonumber(attrs.factor), (tonumber(attrs.multSize)));
            p58:AddAnimation(attrs.name, AnimFramesXml, tonumber(attrs.framerate), attrs.looped == "true");
        end;
    end;
end;

function u17.loadGraphic(p61, p62, p63, p64, p65) -- Line: 383
    if typeof(p62) == "Instance" then
        p62 = require(p62) or p62;
    end;

    p61.loadedGraphic = p62;
    p61.graphicImage = p63;
    p61.graphicFactor = p64;
    p61.graphicSize = p65;
end;

function u17.addByPrefix(p66, p67, p68, p69, p70) -- Line: 394
    if p66.loadedGraphic then
        return p66:AddSparrowXml(p66.loadedGraphic, p67, p68, p69, p70, p66.graphicFactor, p66.graphicSize, p66.graphicImage);
    end;
end;

function u17.addByIndices(p71: table, p72: string, p73: string, p74: table, p75: string?, p76: number?, p77: boolean?) -- Line: 399
    if not p71.loadedGraphic then
        return;
    end;

    local AnimFramesXml = p71:GetAnimFramesXml(p71.loadedGraphic, p73, p71.graphicFactor, p71.graphicSize, p75 or "");

    if AnimFramesXml and #AnimFramesXml > 0 then
        local v78 = {};

        for i = 1, #p74 do
            local v79 = AnimFramesXml[p74[i] + 1];
            local v80;

            if v79 then
                table.insert(v78, v79);
                v80 = i;
            else
                v80 = i;
            end;
        end;

        if #v78 > 0 then
            return p71:AddAnimation(p72, v78, p76, p77, p71.graphicImage);
        end;
    end;
end;

function u17.animExists(p81, p82) -- Line: 424
    return p81.Animations[p82] and true or false;
end;

function u17.GetSpriteImages(p83, p84) -- Line: 428
    -- upvalues: u39 (ref), XMLParser (copy), getImageIdFromName (copy)
    if u39[p84] then
        p84 = u39[p84];
    end;

    if typeof(p84) == "Instance" then
        p84 = require(p84) or p84;
    end;

    local v85 = XMLParser.parse(p84, true);
    local ImageMetadata = p83:GetImageMetadata(v85);
    local v86 = {};

    for _, v in v85.children do
        local imagePath = v.attrs.imagePath;

        if imagePath then
            if ImageMetadata then
                imagePath = getImageIdFromName(ImageMetadata, v.attrs.imagePath);
            else
                imagePath = ImageMetadata;
            end;
        end;

        if imagePath and not table.find(v86, imagePath) then
            local Content_fromUri = Content.fromUri;

            if tonumber(imagePath) then
                imagePath = "rbxassetid://" .. imagePath;
            end;

            table.insert(v86, Content_fromUri(imagePath));
        end;
    end;

    return v86;
end;

function u17.GetAnimFramesXml(p87, p88, p89, p90, p91, p92) -- Line: 448
    -- upvalues: u39 (ref), XMLParser (copy), Vector2_new (copy), u22 (copy), getImageIdFromName (copy), fixFrames (copy)
    if u39[p88] then
        p88 = u39[p88];
    end;

    if typeof(p88) == "Instance" then
        p88 = require(p88) or p88;
    end;

    local v93 = XMLParser.parse(p88, true);
    local v94 = type(p91) == "number" and Vector2_new(p91, p91) or (p91 or u22);
    local ImageMetadata = p87:GetImageMetadata(v93);
    local v95 = {};
    local v96 = p90 or 1;

    for _, v in v93.children do
        local imagePath = v.attrs.imagePath;

        if imagePath then
            if ImageMetadata then
                imagePath = getImageIdFromName(ImageMetadata, v.attrs.imagePath);
            else
                imagePath = ImageMetadata;
            end;
        end;

        if imagePath and tonumber(imagePath) then
            imagePath = "rbxassetid://" .. imagePath;
        end;

        for _, v2 in v.children do
            local attrs = v2.attrs;

            if v2.tag == "SubTexture" and (attrs.name:sub(1, #p89) == p89 and not (p92 and (p92 ~= "" and attrs.name:sub(-#p92) ~= p92))) then
                local v97 = tonumber(attrs.x);
                local v98 = tonumber(attrs.y);
                local v99 = tonumber(attrs.width);
                local v100 = tonumber(attrs.height);
                local v101 = attrs.rotated ~= nil and attrs.rotated == "true";
                local v102 = tonumber(attrs.offsetX) or 0;
                local v103 = tonumber(attrs.offsetY) or 0;
                local v104 = Vector2_new(v97 / v96, v98 / v96);
                local v105 = Vector2_new(v99 / v96, v100 / v96);
                local v106 = Vector2_new(v99, v100);
                local v107 = Vector2_new(v102, v103) * v94;

                if v107 == Vector2.zero then
                    v107 = nil;
                end;

                local v108 = {};
                local v109;

                if imagePath then
                    v109 = typeof(imagePath) == "Content" and imagePath and imagePath or (Content.fromUri(imagePath) or nil);
                else
                    v109 = nil;
                end;

                v108.ImageContent = v109;
                v108.Rotated = v101 or nil;
                v108.Offset = v104;
                v108.Size = v105;
                v108.RawFrameSize = v106;
                v108.FrameSize = v106 * v94;
                v108.FrameOffset = v107;
                v95[#v95 + 1] = v108;
            end;
        end;
    end;

    fixFrames(v95);

    return #v95 > 0 and v95 and v95 or nil;
end;

local u110 = {
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
local u111 = {
    scale = "Scale",
    x = "x",
    y = "y",
    angle = "angle",
    rectImageOffset = "rectImageOffset",
    Speed = "Speed",
    alpha = "alpha",
    bgAlpha = "bgAlpha",
    bsp = "bsp",
    rectSizeOffset = "rectSizeOffset"
};

for i, v in u110 do
    u111[i] = v;
end;

local u112 = {
    Frame = "BackgroundTransparency",
    TextLabel = "TextTransparency",
    TextButton = "TextTransparency",
    TextBox = "TextTransparency",
    ImageLabel = "ImageTransparency",
    ImageButton = "ImageTransparency",
    CanvasGroup = "GroupTransparency"
};

local function deepcopy(p113, p114) -- Line: 592
    -- upvalues: deepcopy (copy)
    local v115 = p114 or {};

    if type(p113) ~= "table" then
        return p113;
    end;

    local v116 = v115[p113];

    if v116 then
        return v116;
    end;

    local v117 = {};
    v115[p113] = v117;

    for i, v in next, p113 do
        v117[i] = deepcopy(v, v115);
    end;

    local v118 = getmetatable(p113);
    setmetatable(v117, v118);

    return v117;
end;

local u119 = {
    parent = true,
    curAnimData = true,
    obj = true,
    animReset = true,
    __super = true,
    contentOverride = true
};
local u133 = {
    scale = function(u120) -- Line: 618
        -- upvalues: Vector2_new (copy)
        return setmetatable({}, {
            __index = function(p121, p122) -- Line: 619, Name: __index
                -- upvalues: u120 (copy), Vector2_new (ref)
                if p122 == "set" then
                    return function(p123, p124) -- Line: 621
                        -- upvalues: u120 (ref), Vector2_new (ref)
                        u120.Scale = Vector2_new(p123, p124);
                    end;
                end;

                if p122 == "get" then
                    return function() -- Line: 625
                        -- upvalues: u120 (ref)
                        return u120.Scale;
                    end;
                end;

                if p122 == "x" or p122 == "y" then
                    return u120.Scale[string.upper(p122)];
                end;

                return u120.Scale;
            end,

            __newindex = function(p125, p126, p127) -- Line: 634, Name: __newindex
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

    Position = function(p128) -- Line: 643
        -- upvalues: u23 (copy), UDim2_fromScale (copy)
        local v129 = p128.useFactorsForPosition and p128.sFactors or u23;

        return UDim2_fromScale(p128:GetProperty("x") / v129.X, p128:GetProperty("y") / v129.Y);
    end,

    ResampleMode = function(p130) -- Line: 647
        -- upvalues: Default (copy), Pixelated (copy)
        return p130.antialiasing and Default or Pixelated;
    end,

    size = function(p131) -- Line: 650
        return p131.frameSize;
    end,

    active = function(p132) -- Line: 653
        return p132._active;
    end
};
local u141 = {
    Position = function(p134, p135) -- Line: 659
        -- upvalues: u23 (copy)
        local v136 = p134.useFactorsForPosition and p134.sFactors or u23;
        rawset(p134, "x", p135.X.Scale * v136.X + p135.X.Offset);
        rawset(p134, "y", p135.Y.Scale * v136.Y + p135.Y.Offset);
    end,

    ResampleMode = function(p137, p138) -- Line: 666
        -- upvalues: Default (copy)
        rawset(p137, "antialiasing", p138 == Default);
    end,

    active = function(p139, p140) -- Line: 670
        p139:set_active(p140);
    end
};
u17.allowedNilCases = u119;

function u17.__index(p142, p143) -- Line: 678
    -- upvalues: u110 (copy), u119 (copy), u17 (copy), u133 (copy)
    local v144 = u110[p143];

    if v144 then
        return p142[v144];
    end;

    if u119[p143] then
        return;
    end;

    local v145 = u17[p143];

    if v145 then
        return v145;
    end;

    local v146 = u133[p143];

    if v146 then
        return v146(p142);
    end;

    local v147;

    if p143 == "BackgroundTransparency" then
        v147 = p142.useBgAlpha;
    else
        v147 = false;
    end;

    if v147 or p142.alphaAlias == p143 then
        return 1 - p142[v147 and "bgAlpha" or "alpha"];
    end;
end;

function u17.__newindex(p148, p149, p150) -- Line: 700
    -- upvalues: u110 (copy), u141 (copy)
    local v151 = u110[p149] or p149;
    local v152 = u141[v151];

    if v152 then
        return v152(p148, p150);
    end;

    local v153;

    if v151 == "BackgroundTransparency" then
        v153 = p148.useBgAlpha;
    else
        v153 = false;
    end;

    if v153 or p148.alphaAlias == v151 then
        return rawset(p148, v153 and "bgAlpha" or "alpha", 1 - p150);
    end;

    rawset(p148, v151, p150);
end;

local _ = {
    Mult = function(p154: number, p155: number) -- Line: 744, Name: Mult
        return p154 * p155;
    end,

    Sum = function(p156: number, p157: number) -- Line: 747, Name: Sum
        return p156 + p157;
    end,

    Sub = function(p158: number, p159: number) -- Line: 750, Name: Sub
        return p158 - p159;
    end,

    Div = function(p160: number, p161: number) -- Line: 753, Name: Div
        return p160 / p161;
    end,

    MultVector2 = u14 or function(p162, p163: any) -- Line: 756
        return p162 * p163;
    end,
    SumVector2 = u11 or function(p164, p165) -- Line: 759
        return p164 + p165;
    end,

    SubVector2 = function(p166, p167) -- Line: 762, Name: SubVector2
        return p166 - p167;
    end,

    DivVector2 = function(p168, p169: any) -- Line: 765, Name: DivVector2
        return p168 / p169;
    end
};

function iterateSum(p170: number, p171: table, p172: table)
    for i, v in p171 do
        if p172[i] then
            p170 = v(p170);
        else
            p170 = p170 + v;
        end;
    end;

    return p170;
end;

function iterateSumVector(p173, p174: table, p175: table)
    for i, v in p174 do
        if p175[i] then
            p173 = v(p173);
        else
            p173 = p173 + v;
        end;
    end;

    return p173;
end;

function iterateMult(p176: number, p177: table, p178: table)
    for i, v in p177 do
        if p178[i] then
            p176 = v(p176);
        else
            p176 = p176 * v;
        end;
    end;

    return p176;
end;

function iterateMultVector(p179, p180: table, p181: table)
    for i, v in p180 do
        if p181[i] then
            p179 = v(p179);
        else
            p179 = p179 * v;
        end;
    end;

    return p179;
end;

function iterateBListSum(p182: number, p183: table, p184: table, p185: table)
    -- upvalues: table_find (copy)
    for i, v in p183 do
        if not table_find(p185, i) then
            if p184[i] then
                p182 = v(p182);
            else
                p182 = p182 + v;
            end;
        end;
    end;

    return p182;
end;

function iterateBListSumVector(p186, p187: table, p188: table, p189: table)
    -- upvalues: table_find (copy)
    for i, v in p187 do
        if not table_find(p189, i) then
            if p188[i] then
                p186 = v(p186);
            else
                p186 = p186 + v;
            end;
        end;
    end;

    return p186;
end;

function iterateBListMult(p190: number, p191: table, p192: table, p193: table)
    -- upvalues: table_find (copy)
    for i, v in p191 do
        if not table_find(p193, i) then
            if p192[i] then
                p190 = v(p190);
            else
                p190 = p190 * v;
            end;
        end;
    end;

    return p190;
end;

function iterateBListMultVector(p194, p195: table, p196: table, p197: table)
    -- upvalues: table_find (copy)
    for i, v in p195 do
        if not table_find(p197, i) then
            if p196[i] then
                p194 = v(p194);
            else
                p194 = p194 * v;
            end;
        end;
    end;

    return p194;
end;

local u198 = {
    x = iterateSum,
    y = iterateSum,
    angle = iterateSum,
    rectImageOffset = iterateSumVector,
    Scale = iterateMultVector,
    Speed = iterateMult,
    alpha = iterateMult,
    bgAlpha = iterateMult,
    bsp = iterateMult,
    rectSizeOffset = iterateMult
};
local u199 = {
    x = iterateBListSum,
    y = iterateBListSum,
    angle = iterateBListSum,
    rectImageOffset = iterateBListSumVector,
    Scale = iterateBListMultVector,
    Speed = iterateBListMult,
    alpha = iterateBListMult,
    bgAlpha = iterateBListMult,
    bsp = iterateBListMult,
    rectSizeOffset = iterateBListMult
};
local u229 = {
    implement = function(u200) -- Line: 935, Name: implement
        -- upvalues: u199 (copy), u198 (copy), u111 (copy)
        local u201 = {};
        local u202 = {};

        function u200.GetProperty(p203: table, p204: string, p205: table?) -- Line: 939
            -- upvalues: u201 (copy), u199 (ref), u202 (copy), u198 (ref)
            local v206 = u201[p204];

            if not v206 then
                return p203[p204];
            end;

            if p205 then
                return u199[p204](p203[p204], v206, u202[p204], p205);
            end;

            return u198[p204](p203[p204], v206, u202[p204]);
        end;

        function u200.GetOffset(p207: table, p208: string, p209: any, p210: table?) -- Line: 952
            -- upvalues: u201 (copy), u199 (ref), u202 (copy), u198 (ref)
            local v211 = u201[p208];

            if not v211 then
                return p209;
            end;

            if p210 then
                return u199[p208](p209, v211, u202[p208], p210);
            end;

            return u198[p208](p209, v211, u202[p208]);
        end;

        local v228 = {
            __real = u201,
            __isFuncs = u202,

            getPropertyOffsets = function(p212: string) -- Line: 969, Name: getPropertyOffsets
                -- upvalues: u201 (copy)
                return u201[p212];
            end,

            GetPropertyOffsets = function(p213: any, p214: string) -- Line: 973, Name: GetPropertyOffsets
                -- upvalues: u201 (copy)
                return u201[p214];
            end,

            getOffset = function(p215, p216) -- Line: 977, Name: getOffset
                -- upvalues: u200 (copy)
                return u200:GetOffset(p216, p215);
            end,

            GetOffset = function(p217, p218, p219) -- Line: 981, Name: GetOffset
                -- upvalues: u200 (copy)
                return u200:GetOffset(p219, p218);
            end,

            set = function(p220: string, p221: string, p222: any) -- Line: 985, Name: set
                -- upvalues: u111 (ref), u201 (copy), u202 (copy)
                local v223 = u111[p220] or p220;
                local v224 = u201[v223];

                if not v224 then
                    if p222 == nil then
                        return;
                    end;

                    u201[v223] = {
                        [p221] = p222
                    };
                    u202[v223] = {
                        [p221] = type(p222) == "function"
                    };

                    return;
                end;

                v224[p221] = p222;

                if p222 ~= nil then
                    u202[v223][p221] = type(p222) == "function";

                    return;
                end;

                if next(v224) then
                    u202[v223][p221] = nil;

                    return;
                end;

                u201[v223] = nil;
                u202[v223] = nil;
            end,

            get = function(p225: string, p226: string) -- Line: 1014, Name: get
                -- upvalues: u111 (ref), u201 (copy)
                local v227 = u201[u111[p225] or p225];

                if v227 then
                    return v227[p226];
                end;

                return nil;
            end,

            clear = function() -- Line: 1025, Name: clear
                -- upvalues: u201 (copy), u202 (copy)
                table.clear(u201);
                table.clear(u202);
            end
        };
        u200.offsets = v228;

        return v228;
    end
};

function u229.clone(p230, p231) -- Line: 1036
    -- upvalues: u229 (copy), table_clone (copy)
    local v232 = u229.implement(p231);

    for i, v in p230.__real do
        v232.__real[i] = table_clone(v);
    end;

    for i, v in p230.__isFuncs do
        v232.__isFuncs[i] = table_clone(v);
    end;

    return v232;
end;

function u229.copy(u233, p234) -- Line: 1050
    -- upvalues: u229 (copy)
    local u235 = u229.implement(p234);

    local function newPointer(p236, u237) -- Line: 1053
        return setmetatable({}, {
            __iter = function(p238) -- Line: 1055, Name: __iter
                -- upvalues: u237 (copy)
                local v239 = {};

                for i, v in u237 do
                    v239[i] = v;
                end;

                for i, v in pairs(p238) do
                    v239[i] = v;
                end;

                return pairs(v239);
            end,

            __index = u237
        });
    end;

    for i, v in u233.__real do
        u235.__real[i] = newPointer(i, v);
    end;

    for i, v in u233.__isFuncs do
        u235.__isFuncs[i] = setmetatable({}, {
            __index = v
        });
    end;

    setmetatable(u235.__real, {
        __index = function(p240, p241) -- Line: 1082, Name: __index
            -- upvalues: u233 (copy), newPointer (copy), u235 (copy)
            local v242 = u233.__real[p241];

            if v242 then
                local v243 = newPointer(p241, v242);
                u235.__real[p241] = v243;
                u235.__isFuncs[p241] = setmetatable({}, {
                    __index = u233.__isFuncs[p241]
                });

                return v243;
            end;
        end
    });

    return u235;
end;

u229.imitate = u229.copy;

function u17.new(p244: userdata, p245, p246: boolean?, p247: boolean?, p248: boolean?) -- Line: 1243
    -- upvalues: u22 (copy), u23 (copy), X (ref), Y (ref), u112 (copy), Vector2_new (copy), u229 (copy), new (copy), u17 (copy)
    if not p244 then
        print("no obj");

        return nil;
    end;

    local _ = p247 == nil and true or p247;
    local v249 = {
        Obj = p244,
        objClass = p244.ClassName,
        curAnim = "",
        curFrame = 1,
        timer = 0,
        Finished = false,
        Paused = true,
        Speed = 1,
        Playing = false,
        Scale = u22,
        sFactors = p245 or u23,
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
        size = p244.ClassName ~= "ImageLabel" and ({
            x = p244.AbsoluteSize.X / X * 1280,
            y = p244.AbsoluteSize.Y / Y * 720
        } or nil) or nil,
        currentFrame = nil,
        loadedGraphic = nil,
        keepSpriteRatio = false,
        curAnimData = nil,
        sizeCache = table.create(4),
        frameCache = table.create(7),
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
        isCopy = false,
        destroyObj = p246 == nil and true or p246 or false,
        useAngleAnchor = false,
        x = 0,
        y = 0,
        angle = p244.Rotation,
        visible = p244.Visible,
        anchor = p244.AnchorPoint,
        rectSizeOffset = u22,
        rectImageOffset = Vector2.zero,
        __parentSize = u22,
        alpha = 1 - p244[u112[p244.ClassName]],
        bgAlpha = 1 - p244.BackgroundTransparency,
        useBgAlpha = u112[p244.ClassName] ~= "BackgroundTransparency",
        alphaAlias = u112[p244.ClassName],
        zindex = p244.ZIndex,
        bsp = p244.BorderSizePixel,
        bsColor = p244.BorderColor3,
        bgColor = p244.BackgroundColor3,
        angleAnchor = Vector2_new(0.5, 0.5),
        rendersImage = p244:IsA("ImageLabel") or p244:IsA("ImageButton"),
        parent = p244.Parent,
        className = "Sprite",
        contentOverride = false,
        __currentProperties = {},
        frameOffX = 0,
        frameOffY = 0
    };
    u229.implement(v249);
    v249.setOffset = v249.offsets.set;
    v249.getOffset = v249.offsets.getOffset;

    if v249.rendersImage then
        v249.imageColor = p244.ImageColor3 or Color3.new(1, 1, 1);
        v249.antialiasing = p244.ResampleMode == Enum.ResamplerMode.Default;
        local v250 = new();
        local v251 = new();
        local v252 = new();
        local v253 = new();
        local v254 = new();
        v249.AnimationStarted = v250;
        v249.AnimationEnded = v251;
        v249.AnimationLooped = v252;
        v249.AnimationAdded = v253;
        v249.AnimationRemoved = v254;
    end;

    setmetatable(v249, u17);
    v249:SetObj(p244);

    if not p248 then
        v249:set_active(true);
    end;

    return v249;
end;

function u17.postCreate(p255) -- Line: 1379
    rawset(p255, "Update", p255.Update);
    rawset(p255, "Destroy", p255.Destroy);
    rawset(p255, "GetProperty", p255.GetProperty);
    rawset(p255, "SetObj", p255.SetObj);
    rawset(p255, "set_active", p255.set_active);
    rawset(p255, "UpdateSize", p255.UpdateSize);
    rawset(p255, "UpdateFrame", p255.UpdateFrame);
    rawset(p255, "UpdateObj", p255.UpdateObj);
    rawset(p255, "UpdateAnimation", p255.UpdateAnimation);
end;

function u17.SetObj(u256: table, p257: userdata) -- Line: 1402
    if u256.objDestroying then
        u256.objDestroying:Disconnect();
        u256.objDestroying = false;
    end;

    u256:CleanUpdateCaches();
    u256.Obj = p257;

    if not p257 then
        return;
    end;

    u256.objDestroying = p257.Destroying:Once(function() -- Line: 1411
        -- upvalues: u256 (copy)
        u256.objDestroying = false;
        u256.isObjAlive = false;

        if u256.alive then
            u256:Destroy();
        end;
    end);
end;

function u17.IsA(p258: table, p259: string) -- Line: 1425
    return p258.className == p259 and true or p258.Obj:IsA(p259);
end;

function u17.GetPosFactors(p260) -- Line: 1429
    -- upvalues: u23 (copy)
    return p260.useFactorsForPosition and p260.sFactors or u23;
end;

function u17.AddSparrowByResults(p261, p262, p263, ...) -- Line: 1433
    -- upvalues: table_find (copy)
    if p262 == nil then
        return;
    end;

    local AnimationsFromXml = p261:GetAnimationsFromXml(p262);
    local v264 = { ... };

    for _, v in p263 or {} do
        local v265 = v:gsub("0", "");

        if table_find(AnimationsFromXml, v265 or "") then
            p261:AddSparrowXml(p262, unpack(v264, 1, 1), v265 .. "0", unpack(v264, 2, select("#", ...)));

            return;
        end;
    end;
end;

u17.AddAnimationByResults = u17.AddSparrowByResults;

function u17.GetAnimFramesByResults(p266, p267, p268, p269, p270) -- Line: 1451
    -- upvalues: table_find (copy)
    if p267 == nil then
        return nil;
    end;

    local AnimationsFromXml = p266:GetAnimationsFromXml(p267);

    for _, v in p268 or {} do
        local v271 = v:gsub("0", "");

        if table_find(AnimationsFromXml, v271 or "") then
            local AnimFramesXml = p266:GetAnimFramesXml(p267, v271 .. "0", p269, p270);

            if AnimFramesXml then
                return AnimFramesXml;
            end;
        end;
    end;

    return nil;
end;

function u17.isRendered(p272) -- Line: 1468
    local Property = p272:GetProperty("Scale");
    local v273;

    if Property.X == 0 or Property.Y == 0 then
        v273 = false;
    else
        v273 = p272.visible and p272.parent ~= nil;
    end;

    return v273;
end;

function u17.Update(p274: table, p275: number) -- Line: 1473
    -- upvalues: u5 (copy), u8 (copy), UDim2_fromScale_ret (copy)
    local v276 = p275 or 0;
    local Obj = p274.Obj;

    if not Obj then
        return;
    end;

    local rendersImage = p274.rendersImage;

    if rendersImage and not (p274.Finished or p274.isCopy) then
        p274:UpdateAnimation(v276);

        if not p274.alive then
            return;
        end;
    end;

    local __currentProperties = p274.__currentProperties;
    local parent = p274.parent;

    if not parent then
        if __currentProperties.Parent then
            __currentProperties.Parent = nil;
            u5(Obj, "Parent", nil);
        end;

        return;
    end;

    if not p274.visible then
        if __currentProperties.Visible then
            __currentProperties.Visible = false;
            u5(Obj, "Visible", false);
        end;

        return;
    end;

    local Property = p274:GetProperty("alpha");

    if __currentProperties._alpha ~= Property then
        __currentProperties._alpha = Property;

        if Property == 0 then
            __currentProperties.alpha = 0;
            u5(Obj, p274.alphaAlias, 1);

            return;
        end;
    end;

    local Property2 = p274:GetProperty("Scale");

    if __currentProperties._prevScale ~= Property2 then
        local v277 = u8(Property2, "X");
        local v278 = u8(Property2, "Y");
        __currentProperties._scaleX = v277;
        __currentProperties._scaleY = v278;
        __currentProperties._prevScale = Property2;

        if v277 == 0 or v278 == 0 then
            u5(Obj, "Size", UDim2_fromScale_ret);

            return;
        end;
    end;

    local sFactors = p274.sFactors;

    if __currentProperties._prevFactor ~= sFactors then
        local v279 = u8(sFactors, "X");
        local v280 = u8(sFactors, "Y");
        __currentProperties._sFactorX = v279;
        __currentProperties._sFactorY = v280;
        __currentProperties._prevFactor = sFactors;
    end;

    if rendersImage then
        p274:UpdateFrame();
    end;

    if p274.changeSize then
        p274:UpdateSize();
    end;

    p274:UpdateObj();

    if __currentProperties.Parent ~= parent then
        __currentProperties.Parent = parent;
        u5(Obj, "Parent", parent);
    end;
end;

local function vectorToRatio(p281, p282: number) -- Line: 1558
    -- upvalues: math_round (copy), Vector2_new (copy)
    local X2 = p281.X;
    local Y2 = p281.Y;
    local v283 = math_round(Y2 * p282);

    if X2 <= v283 then
        return Vector2_new(X2, (math_round(X2 / p282)));
    end;

    return Vector2_new(v283, Y2);
end;

function u17.__parentChanged(p284: table, p285: userdata) -- Line: 1571
    -- upvalues: u22 (copy)
    if p284.__parentConnection then
        p284.__parentConnection:Disconnect();
        p284.__parentConnection = nil;
    end;

    if p285 then
        p284.__parentSize = u22;

        return;
    end;

    p284.__parentSize = u22;
end;

function u17.set_active(p286, p287) -- Line: 1625
    -- upvalues: u19 (ref), u20 (copy), table_find (copy)
    if p286._active == p287 then
        return;
    end;

    if p287 then
        u19 = u19 + 1;
        u20[u19] = p286;
    else
        u20[table_find(u20, p286)] = u20[u19];
        u20[u19] = nil;
        u19 = u19 - 1;
    end;

    p286._active = p287;
end;

function u17.__updateProperty(p288, p289, p290, p291) -- Line: 1639
    -- upvalues: u5 (copy)
    local __currentProperties = p288.__currentProperties;

    if __currentProperties[p290] == p291 then
        return;
    end;

    __currentProperties[p290] = p291;
    u5(p289, p290, p291);
end;

function u17.__updateCachedProp(p292, p293, p294, p295) -- Line: 1647
    local __currentProperties = p292.__currentProperties;

    if __currentProperties[p294] == p295 then
        return;
    end;

    __currentProperties[p294] = p295;
end;

function u17.CleanUpdateCaches(p296) -- Line: 1653
    p296.__currentProperties = {};
    p296.sizeCache = table.create(4);
    p296.frameCache = table.create(7);
end;

function u17.ForceUpdate(p297) -- Line: 1659
    p297:CleanUpdateCaches();
    p297:Update(0);
end;

function u17.UpdateObj(p298) -- Line: 1744
    -- upvalues: u5 (copy), Vector2_new (copy), math_cos (copy), math_sin (copy), u8 (copy), UDim2_fromScale (copy), Default (copy), Pixelated (copy)
    local frameOffX = p298.frameOffX;
    local frameOffY = p298.frameOffY;
    local Obj = p298.Obj;
    local __currentProperties = p298.__currentProperties;
    local v299 = p298:GetProperty("x") + frameOffX;
    local v300 = p298:GetProperty("y") + frameOffY;
    local Property = p298:GetProperty("angle");
    local v301 = __currentProperties.xFinal == v299;
    local v302 = __currentProperties.yFinal == v300;
    local anchor = p298.anchor;
    local _alpha = __currentProperties._alpha;
    local zindex = p298.zindex;
    local bgColor = p298.bgColor;
    local bsp = p298.bsp;
    local bsColor = p298.bsColor;

    if not __currentProperties.Visible then
        __currentProperties.Visible = true;
        u5(Obj, "Visible", true);
    end;

    if __currentProperties.AnchorPoint ~= anchor then
        __currentProperties.AnchorPoint = anchor;
        u5(Obj, "AnchorPoint", anchor);
    end;

    local v303 = __currentProperties.angle ~= Property;

    if v303 then
        __currentProperties.angle = Property;
        u5(Obj, "Rotation", Property);
    end;

    if p298.useAngleAnchor then
        if not (v301 and (v302 and not v303)) then
            local currentSize = p298.currentSize;
            local v304 = Property * 0.017453292519943295;
            local v305 = Vector2_new(currentSize.x, currentSize.y);
            local v306 = v305 * p298.angleAnchor;
            local v307 = math_cos(v304);
            local v308 = math_sin(v304);
            local v309 = v306 - v305 / 2;
            local v310 = u8(v309, "X");
            local v311 = u8(v309, "Y");
            local v312 = v299 + (v310 - (v310 * v307 - v311 * v308));
            local v313 = v300 + (v311 - (v310 * v308 + v311 * v307));
            local v314, v315;

            if p298.useFactorsForPosition then
                if __currentProperties.xFinal == v312 then
                    v314 = __currentProperties._x;
                else
                    __currentProperties.xFinal = v312;
                    __currentProperties.x = v312 - frameOffX;
                    v314 = v312 / __currentProperties._sFactorX;
                    __currentProperties._x = v314;
                end;

                if __currentProperties.yFinal == v313 then
                    v315 = __currentProperties._y;
                else
                    __currentProperties.yFinal = v313;
                    __currentProperties.y = v313 - frameOffY;
                    v315 = v313 / __currentProperties._sFactorY;
                    __currentProperties._y = v315;
                end;
            else
                if __currentProperties.xFinal == v312 then
                    v314 = __currentProperties._x;
                else
                    __currentProperties.xFinal = v312;
                    __currentProperties.x = v312 - frameOffX;
                    v314 = v312 / 1280;
                    __currentProperties._x = v314;
                end;

                if __currentProperties.yFinal == v313 then
                    v315 = __currentProperties._y;
                else
                    __currentProperties.yFinal = v313;
                    __currentProperties.y = v313 - frameOffY;
                    v315 = v313 / 720;
                    __currentProperties._y = v315;
                end;
            end;

            local v316 = UDim2_fromScale(v314, v315);
            __currentProperties.Position = v316;
            u5(Obj, "Position", v316);
        end;
    elseif not (v301 and v302) then
        local v317, v318;

        if p298.useFactorsForPosition then
            if __currentProperties.xFinal == v299 then
                v317 = __currentProperties._x;
            else
                __currentProperties.xFinal = v299;
                __currentProperties.x = v299 - frameOffX;
                v317 = v299 / __currentProperties._sFactorX;
                __currentProperties._x = v317;
            end;

            if __currentProperties.yFinal == v300 then
                v318 = __currentProperties._y;
            else
                __currentProperties.yFinal = v300;
                __currentProperties.y = v300 - frameOffY;
                v318 = v300 / __currentProperties._sFactorY;
                __currentProperties._y = v318;
            end;
        else
            if __currentProperties.xFinal == v299 then
                v317 = __currentProperties._x;
            else
                __currentProperties.xFinal = v299;
                __currentProperties.x = v299 - frameOffX;
                v317 = v299 / 1280;
                __currentProperties._x = v317;
            end;

            if __currentProperties.yFinal == v300 then
                v318 = __currentProperties._y;
            else
                __currentProperties.yFinal = v300;
                __currentProperties.y = v300 - frameOffY;
                v318 = v300 / 720;
                __currentProperties._y = v318;
            end;
        end;

        local v319 = UDim2_fromScale(v317, v318);
        __currentProperties.Position = v319;
        u5(Obj, "Position", v319);
    end;

    if __currentProperties.alpha ~= _alpha then
        __currentProperties.alpha = _alpha;
        u5(Obj, p298.alphaAlias, 1 - _alpha);
    end;

    if p298.useBgAlpha then
        local Property2 = p298:GetProperty("bgAlpha");

        if __currentProperties.bgAlpha ~= Property2 then
            __currentProperties.bgAlpha = Property2;
            u5(Obj, "BackgroundTransparency", 1 - Property2);
        end;
    end;

    if __currentProperties.ZIndex ~= zindex then
        __currentProperties.ZIndex = zindex;
        u5(Obj, "ZIndex", zindex);
    end;

    if __currentProperties.BackgroundColor3 ~= bgColor then
        __currentProperties.BackgroundColor3 = bgColor;
        u5(Obj, "BackgroundColor3", bgColor);
    end;

    if __currentProperties.BorderSizePixel ~= bsp then
        __currentProperties.BorderSizePixel = bsp;
        u5(Obj, "BorderSizePixel", bsp);
    end;

    if __currentProperties.BorderColor3 ~= bsColor then
        __currentProperties.BorderColor3 = bsColor;
        u5(Obj, "BorderColor3", bsColor);
    end;

    if p298.rendersImage then
        local antialiasing = p298.antialiasing;
        local imageColor = p298.imageColor;

        if __currentProperties.antialiasing ~= antialiasing then
            __currentProperties.antialiasing = antialiasing;
            u5(Obj, "ResampleMode", antialiasing and Default or Pixelated);
        end;

        if __currentProperties.ImageColor3 ~= imageColor then
            __currentProperties.ImageColor3 = imageColor;
            u5(Obj, "ImageColor3", imageColor);
        end;
    end;
end;

local u320 = {
    [1] = {
        [1] = Vector2.new(1, 1),
        [-1] = Vector2.new(1, -1)
    },
    [-1] = {
        [1] = Vector2.new(-1, 1),
        [-1] = Vector2.new(-1, -1)
    }
};

function u17.UpdateFrame(p321) -- Line: 1877
    -- upvalues: u5 (copy), u14 (copy), u8 (copy), u11 (copy), Vector2_new (copy), u320 (copy)
    local curAnimData = p321.curAnimData;

    if not curAnimData then
        return;
    end;

    local __currentProperties = p321.__currentProperties;
    local v322 = curAnimData.Frames[p321.curFrame];

    if not v322 then
        return;
    end;

    local Obj = p321.Obj;
    local contentOverride = p321.contentOverride;
    local frameCache = p321.frameCache;
    local Property = p321:GetProperty("rectSizeOffset");
    local Property2 = p321:GetProperty("rectImageOffset");

    if contentOverride then
        if __currentProperties.ImageContent ~= contentOverride then
            __currentProperties.ImageContent = contentOverride;
            u5(Obj, "ImageContent", contentOverride);
        end;
    else
        local ImageContent = v322.ImageContent;

        if ImageContent then
            if __currentProperties.ImageContent ~= ImageContent then
                __currentProperties.ImageContent = ImageContent;
                u5(Obj, "ImageContent", ImageContent);
            end;
        else
            local ImageContent2 = curAnimData.ImageContent;

            if ImageContent2 and __currentProperties.ImageContent ~= ImageContent2 then
                __currentProperties.ImageContent = ImageContent2;
                u5(Obj, "ImageContent", ImageContent2);
            end;
        end;
    end;

    local _scaleX = __currentProperties._scaleX;
    local _scaleY = __currentProperties._scaleY;
    local v323 = p321.flipX and -1 or 1;
    local v324 = p321.flipY and -1 or 1;
    local v325;

    if _scaleX < 0 then
        v323 = v323 * -1;
        v325 = -_scaleX;
    else
        v325 = _scaleX;
    end;

    if curAnimData.FlipX then
        v323 = v323 * -1;
    end;

    local v326;

    if _scaleY < 0 then
        v324 = v324 * -1;
        v326 = -_scaleY;
    else
        v326 = _scaleY;
    end;

    if curAnimData.FlipY then
        v324 = v324 * -1;
    end;

    if frameCache[1] == v322 then
        if frameCache[2] == Property then
            if frameCache[3] == Property2 then
                if frameCache[4] == v323 then
                    if frameCache[5] == v324 then
                        if frameCache[6] == _scaleX then
                            if frameCache[7] == _scaleY then
                                return;
                            end;

                            frameCache[7] = _scaleY;
                        else
                            frameCache[6] = _scaleX;
                        end;
                    else
                        frameCache[5] = v324;
                    end;
                else
                    frameCache[4] = v323;
                end;
            else
                frameCache[3] = Property2;
            end;
        else
            frameCache[2] = Property;
        end;
    else
        frameCache[1] = v322;
    end;

    p321.currentFrame = v322;
    local Rotated = v322.Rotated;
    local frameSize = p321.frameSize;
    local rawFrameSize = p321.rawFrameSize;
    local _frameSizeY = v322._frameSizeY;
    local _rawFrameSizeX = v322._rawFrameSizeX;
    local _rawFrameSizeY = v322._rawFrameSizeY;
    frameSize.x = v322._frameSizeX;
    frameSize.y = _frameSizeY;
    rawFrameSize.x = _rawFrameSizeX;
    rawFrameSize.y = _rawFrameSizeY;

    if __currentProperties._rotated ~= Rotated then
        if Rotated then
            p321.setOffset("angle", "rotated", -90);
            __currentProperties._rotated = true;
        else
            p321.setOffset("angle", "rotated", nil);
            __currentProperties._rotated = nil;
        end;
    end;

    local useFactorsForPosition = p321.useFactorsForPosition;
    local v327 = useFactorsForPosition and 1 or 720 / __currentProperties._sFactorY;
    p321.frameOffX = v322._frameOffsetX * v325 * v323 * (useFactorsForPosition and 1 or 1280 / __currentProperties._sFactorX);
    p321.frameOffY = v322._frameOffsetY * v326 * v324 * v327;
    local v328 = u14(v322.Size, Property);
    local v329 = false;
    local v330 = 0;
    local v331 = 0;

    if v323 == -1 then
        v329 = true;
        v330 = u8(v328, "X");

        if v324 == -1 then
            v331 = u8(v328, "Y");
        end;
    elseif v324 == -1 then
        v331 = u8(v328, "Y");
        v329 = true;
    end;

    local v332 = u11(v322.Offset, Property2);

    if v329 then
        v332 = u11(v332, Vector2_new(v330, v331));
        v328 = u14(v328, u320[v323][v324]);
    end;

    if __currentProperties.ImageRectSize ~= v328 then
        __currentProperties.ImageRectSize = v328;
        u5(Obj, "ImageRectSize", v328);
    end;

    if __currentProperties.ImageRectOffset ~= v332 then
        __currentProperties.ImageRectOffset = v332;
        u5(Obj, "ImageRectOffset", v332);
    end;
end;

function u17.UpdateAnimation(p333: table, p334: number) -- Line: 2002
    local curAnimData = p333.curAnimData;

    if curAnimData then
        local v335 = #curAnimData.Frames;
        local v336 = v335 == 1;
        local Looped = curAnimData.Looped;

        if v336 and Looped then
            p333.Finished = true;

            return;
        end;

        local v337 = curAnimData.Framerate or 24;

        if v337 == 0 then
            p333.Finished = true;
            p333.AnimationEnded:Fire(p333.curAnim);

            return;
        end;

        local v338 = p333.timer + p334 * p333:GetProperty("Speed");
        local v339 = 1 / v337;
        local curFrame = p333.curFrame;
        local v340 = v338 // v339;

        if v336 and v340 ~= 0 then
            p333.Finished = true;
            p333.AnimationEnded:Fire(p333.curAnim);

            return;
        end;

        local v341 = curFrame + v340 % v335;
        p333.timer = v338 - v340 * v339;

        if v335 < v341 then
            if Looped then
                p333.curFrame = v341 - v335;
                p333.AnimationLooped:Fire(p333.curAnim);

                return;
            end;

            p333.curFrame = v335;
            p333.Finished = true;
            p333.AnimationEnded:Fire(p333.curAnim);

            return;
        end;

        p333.curFrame = v341;
    end;
end;

function u17.ResetAnimation(p342) -- Line: 2079
    if p342.animReset then
        p342.animReset:Disconnect();
        p342.animReset = nil;
    end;

    p342.Finished = false;
    p342.curFrame = 1;
    p342.timer = 0;
    local curAnimData = p342.curAnimData;

    if not curAnimData then
        return;
    end;

    local v343 = curAnimData.Frames[1];

    if not v343 then
        return;
    end;

    local FrameSize = v343.FrameSize;
    local RawFrameSize = v343.RawFrameSize;
    local frameSize = p342.frameSize;
    local rawFrameSize = p342.rawFrameSize;
    local Y2 = FrameSize.Y;
    local X2 = RawFrameSize.X;
    local Y3 = RawFrameSize.Y;
    frameSize.x = FrameSize.X;
    frameSize.y = Y2;
    rawFrameSize.x = X2;
    rawFrameSize.y = Y3;
end;

function u17.Play(u344, p345, p346) -- Line: 2096
    local u347 = {
        resetAnim = nil,
        resetTime = 0,
        resetOnAnimEnd = false
    };
    local v348 = u344.Animations[p345];

    if not v348 then
        warn((`[Sprite] Missing animation {p345}`));

        return u347;
    end;

    if u344.curAnimData == v348 and not p346 then
        return u347;
    end;

    u344.curAnimData = v348;
    u344.curAnim = p345;
    u344:ResetAnimation();
    u344.AnimationStarted:Fire(u344.curAnim);
    task.defer(function() -- Line: 2110
        -- upvalues: u344 (copy), u347 (copy)
        if u344.resetData ~= u347 or not u347.resetAnim then
            return;
        end;

        if u347.resetOnAnimEnd then
            u344.animReset = u344.AnimationEnded:Connect(function() -- Line: 2113
                -- upvalues: u347 (ref), u344 (ref)
                if u347.resetTime > 0 then
                    task.wait(u347.resetTime);
                end;

                task.spawn(u344.Play, u344, u347.resetAnim);
            end);

            return;
        end;

        task.delay(u347.resetTime, function() -- Line: 2118
            -- upvalues: u344 (ref), u347 (ref)
            if u344.resetData ~= u347 then
                return;
            end;

            u344:Play(u347.resetAnim);
        end);
    end);
    u344.resetData = u347;

    return u347;
end;

function u17.PlayAnimation(p349, ...) -- Line: 2133
    return p349:Play(...);
end;

({}).__index = function(p350, p351) -- Line: 2138, Name: __index
    return setmetatable({}, {
        __call = function() -- Line: 2139, Name: __call
        end
    });
end;

local _ = table.clear;

local function realDestroy(p352) -- Line: 2147
    -- upvalues: table_find (copy), u20 (copy), u19 (ref)
    if not p352 then
        return;
    end;

    local u353 = p352.__super or p352;
    local v354 = table_find(u20, u353);

    if v354 then
        u20[v354] = u20[u19];
        u20[u19] = nil;
        u19 = u19 - 1;
    end;

    p352.alive = false;
    p352._active = false;

    if u353.destroyObj and u353.Obj then
        pcall(function() -- Line: 2159
            -- upvalues: u353 (copy)
            u353.Obj:Destroy();
        end);
    end;

    p352:SetObj(nil);
    p352.Destroyed = true;
    p352.killed = true;
end;

function u17.Destroy(p355) -- Line: 2174
    -- upvalues: realDestroy (copy)
    for _, v in p355.copies do
        v:Destroy();
    end;

    realDestroy(p355);
end;

u17.Kill = u17.Destroy;

function u17.Clone(p356, p357, p358) -- Line: 2184
    -- upvalues: deepcopy (copy), u229 (copy), table_clone (copy), Class (copy), u19 (ref), u20 (copy)
    local Animations = p356.Animations;
    p356.Animations = nil;
    local offsets = p356.offsets;
    p356.offsets = nil;
    local v359 = deepcopy(p356.__super or p356);
    u229.clone(offsets, v359);
    v359.Animations = table_clone(Animations);
    p356.Animations = Animations;
    p356.offsets = offsets;

    if not p357 then
        p357 = p356.Obj and p356.Obj:Clone();
    end;

    v359.Obj = p357;
    v359.copies = {};
    v359.parent = nil;
    local v360 = getmetatable(p356);
    setmetatable(v359, v360);
    v359.super = Class.getSuper(v359, p356.__class);

    if p358 then
        for i, v in p358 do
            v359[i] = v;
        end;
    end;

    v359:SetObj(v359.Obj);

    if v359._active then
        u19 = u19 + 1;
        u20[u19] = v359;
    end;

    return v359;
end;

function u17.Copy(p361, p362, p363, p364) -- Line: 2229
    -- upvalues: u229 (copy), Class (copy), u19 (ref), u20 (copy)
    local v365 = {};

    if not p363 then
        p363 = p361.Obj and p361.Obj:Clone();
    end;

    v365.Obj = p363;
    u229.copy(p361.offsets, v365);
    v365.objDestroying = false;
    v365.copies = {};
    v365.isCopy = true;
    setmetatable(v365, {
        __index = p361.__super or p361
    });
    v365.super = Class.getSuper(v365, p361.__class);

    if p364 then
        for i, v in p364 do
            v365[i] = v;
        end;
    end;

    v365:SetObj(v365.Obj);

    if p361._active then
        u19 = u19 + 1;
        u20[u19] = v365;
    end;

    if not p362 then
        local copies = p361.copies;
        copies[#copies + 1] = v365;
    end;

    return v365;
end;

u17.Imitate = u17.Copy;
local u366 = {};

function cacheScreenRatio(p367: number)
    -- upvalues: X (ref), Y (ref), math_round (copy), Vector2_new (copy), u366 (ref)
    local v368 = X;
    local v369 = Y;
    local v370 = math_round(v369 * p367);

    if v368 <= v370 then
        local v371 = Vector2_new(v368, (math_round(v368 / p367)));
        u366[p367] = v371;

        return v371;
    end;

    local v372 = Vector2_new(v370, v369);
    u366[p367] = v372;

    return v372;
end;

function u17.UpdateSize(p373) -- Line: 2286
    -- upvalues: u5 (copy), UDim2_fromScale (copy), UDim2_fromOffset (copy)
    local Obj = p373.Obj;
    local frameSize = p373.frameSize;
    local x = frameSize.x;
    local y = frameSize.y;
    local __currentProperties = p373.__currentProperties;
    local sizeCache = p373.sizeCache;
    local _scaleX = __currentProperties._scaleX;
    local _scaleY = __currentProperties._scaleY;

    if sizeCache[1] == x then
        if sizeCache[2] == y then
            if sizeCache[3] == _scaleX then
                if sizeCache[4] == _scaleY then
                    return;
                end;

                sizeCache[4] = _scaleY;
            else
                sizeCache[3] = _scaleX;
            end;
        else
            sizeCache[2] = y;
        end;
    else
        sizeCache[1] = x;
    end;

    local currentSize = p373.currentSize;
    local v374 = x * _scaleX;
    local v375 = y * _scaleY;
    currentSize.x = v374;
    currentSize.y = v375;

    if p373.useScale then
        u5(Obj, "Size", UDim2_fromScale(v374 / __currentProperties._sFactorX, v375 / __currentProperties._sFactorY));

        return;
    end;

    u5(Obj, "Size", UDim2_fromOffset(v374, v375));
end;

function u17.AddBaseAnimation(p376: table, p377: string, p378: table) -- Line: 2325
    -- upvalues: fixFrames (copy)
    p378.Playing = false;

    if p378.Frames then
        fixFrames(p378.Frames);
    end;

    p376.Animations[p377] = p378;
end;

function u17.CopyAnimationsFrom(p379, p380) -- Line: 2335
    for i, v in p380.Animations do
        p379:AddBaseAnimation(i, v);
    end;
end;

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 2362
    -- upvalues: u21 (ref), Vector2_new (copy), X (ref), Y (ref), u8 (copy), u366 (ref)
    u21 = workspace.CurrentCamera.ViewportSize + Vector2_new(0, 1);
    local v381 = u8(u21, "X");
    local v382 = u8(u21, "Y");
    X = v381;
    Y = v382;
    u366 = {};
end);

if RunService:IsStudio() then
    RunService:BindToRenderStep("_SpriteRenderer", Enum.RenderPriority.Last.Value + 1000, function(p383) -- Line: 2383
        -- upvalues: u19 (ref), u20 (copy)
        debug.profilebegin((`Sprite Update (#{u19})`));

        for i = u19, 1, -1 do
            debug.profilebegin("Update Sprite: " .. i);
            local v384 = u20[i];

            if v384 then
                v384:Update(p383);
            else
                u20[i] = u20[u19];
                u20[u19] = nil;
                u19 = u19 - 1;
            end;

            debug.profileend();
            local _ = i;
        end;

        debug.profileend();
    end);
else
    RunService:BindToRenderStep("_SpriteRenderer", Enum.RenderPriority.Last.Value + 1000, function(p385) -- Line: 2370
        -- upvalues: u19 (ref), u20 (copy)
        for i = u19, 1, -1 do
            local v386 = u20[i];
            local v387;

            if v386 then
                v386:Update(p385);
                v387 = i;
            else
                u20[i] = u20[u19];
                u20[u19] = nil;
                u19 = u19 - 1;
                v387 = i;
            end;
        end;
    end);
end;

v18();

return u17;