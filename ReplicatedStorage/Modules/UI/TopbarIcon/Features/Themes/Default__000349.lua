-- Decompiled with Potassium's decompiler.

local Color3_fromRGB_ret = Color3.fromRGB(18, 18, 21);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);

return function(p1: boolean) -- Line: 19
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
    local v2 = {};
    local v3 = {
        "IconButton",
        "BackgroundColor3",
        p1 and Color3_fromRGB_ret2 or Color3_fromRGB_ret,
        "Deselected"
    };
    v2[1], v2[2], v2[3], v2[4], v2[5], v2[6], v2[7], v2[8], v2[9], v2[10], v2[11], v2[12], v2[13], v2[14], v2[15], v2[16] = { "IconCorners", "CornerRadius", UDim.new(1, 0) }, { "Selection", "RotationSpeed", 1 }, { "Selection", "Size", UDim2.new(1, 0, 1, 1) }, { "Selection", "Position", UDim2.new(0, 0, 0, 0) }, { "SelectionGradient", "Color", ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(86, 86, 86)) }) }, { "IconLabel", "TextColor3", p1 and Color3_fromRGB_ret or Color3_fromRGB_ret2 }, { "IconOverlay", "BackgroundColor3", p1 and Color3_fromRGB_ret or Color3_fromRGB_ret2 }, { "IconImage", "Image", "", "Deselected" }, { "IconLabel", "Text", "", "Deselected" }, {
    "IconLabel",
    "Position",
    UDim2.fromOffset(0, 0),
    "Deselected"
}, { "Widget", "DesiredWidth", 44, "Deselected" }, { "Widget", "MinimumWidth", 44, "Deselected" }, { "Widget", "MinimumHeight", 44, "Deselected" }, { "Widget", "BorderSize", 4, "Deselected" }, v3, { "IconButton", "BackgroundTransparency", 0.08, "Deselected" };
    v2[17], v2[18], v2[19], v2[20], v2[21], v2[22], v2[23], v2[24], v2[25], v2[26], v2[27], v2[28], v2[29], v2[30], v2[31], v2[32] = { "IconImageScale", "Value", 0.5, "Deselected" }, {
    "IconImageCorner",
    "CornerRadius",
    UDim.new(0, 0),
    "Deselected"
}, {
    "IconImage",
    "ImageColor3",
    p1 and Color3_fromRGB_ret or Color3_fromRGB_ret2,
    "Deselected"
}, { "IconImage", "ImageTransparency", 0, "Deselected" }, { "IconImageRatio", "AspectRatio", 1, "Deselected" }, {
    "IconLabel",
    "FontFace",
    Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    "Deselected"
}, { "IconLabel", "TextSize", 16, "Deselected" }, { "IconSpot", "BackgroundTransparency", 1, "Deselected" }, {
    "IconOverlay",
    "BackgroundTransparency",
    p1 and 0.95 or 0.85,
    "Deselected"
}, { "IconSpotGradient", "Enabled", false, "Deselected" }, { "IconGradient", "Enabled", false, "Deselected" }, { "ClickRegion", "Active", true, "Deselected" }, { "Menu", "Active", false, "Deselected" }, {
    "ContentsList",
    "HorizontalAlignment",
    Enum.HorizontalAlignment.Center,
    "Deselected"
}, {
    "Dropdown",
    "BackgroundColor3",
    Color3.fromRGB(18, 18, 21),
    "Deselected"
}, { "Dropdown", "BackgroundTransparency", 0.08, "Deselected" };
    local v4 = {
        "IconSpot",
        "BackgroundColor3",
        p1 and Color3_fromRGB_ret or Color3_fromRGB_ret2,
        "Selected"
    };
    v2[33], v2[34], v2[35], v2[36], v2[37], v2[38], v2[39], v2[40], v2[41], v2[42], v2[43], v2[44] = { "Dropdown", "MaxIcons", 4.5, "Deselected" }, { "Menu", "MaxIcons", 4, "Deselected" }, {
    "Notice",
    "Position",
    UDim2.new(1, -12, 0, -1),
    "Deselected"
}, {
    "Notice",
    "Size",
    UDim2.fromOffset(20, 20),
    "Deselected"
}, { "NoticeLabel", "TextSize", 13, "Deselected" }, {
    "PaddingLeft",
    "Size",
    UDim2.new(0, 9, 1, 0),
    "Deselected"
}, {
    "PaddingRight",
    "Size",
    UDim2.new(0, 11, 1, 0),
    "Deselected"
}, {
    "IconSpot",
    "BackgroundTransparency",
    p1 and 0.85 or 0.7,
    "Selected"
}, v4, { "IconSpotGradient", "Enabled", true, "Selected" }, { "IconSpotGradient", "Rotation", 45, "Selected" }, {
    "IconSpotGradient",
    "Color",
    ColorSequence.new(Color3.fromRGB(96, 98, 100), Color3.fromRGB(77, 78, 80)),
    "Selected"
};

    return v2;
end;