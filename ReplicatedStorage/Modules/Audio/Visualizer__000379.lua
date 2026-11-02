-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

local function _(p2) -- Line: 60
    return select(2, xpcall(p2, function() -- Line: 61
        local debug_info_ret = debug.info(2, "f");

        if debug_info_ret == error or not debug_info_ret then
            debug_info_ret = nil;
        end;

        return debug_info_ret;
    end)) or warn("HEY BUDDY THIS METAMETHOD SUCKS");
end;

local u6 = select(2, xpcall(function() -- Line: 68
    Instance.new("ImageLabel").THOSEWHOKNOWSIGMA = true;
end, function() -- Line: 61
    local debug_info_ret = debug.info(2, "f");

    if debug_info_ret == error or not debug_info_ret then
        debug_info_ret = nil;
    end;

    return debug_info_ret;
end)) or warn("HEY BUDDY THIS METAMETHOD SUCKS") or (warn("this metamethod broke") or function(p3: userdata, p4: string, p5: any) -- Line: 70
    p3[p5] = p4;
end);
local u10 = select(2, xpcall(function() -- Line: 74
    Instance.new("UIGradient").THOSEWHOKNOWSIGMA = true;
end, function() -- Line: 61
    local debug_info_ret = debug.info(2, "f");

    if debug_info_ret == error or not debug_info_ret then
        debug_info_ret = nil;
    end;

    return debug_info_ret;
end)) or warn("HEY BUDDY THIS METAMETHOD SUCKS") or (warn("this metamethod broke") or function(p7: userdata, p8: string, p9: any) -- Line: 76
    p7[p9] = p8;
end);
local u11 = {
    Center = Vector2.new(0, 0.5),
    Down = Vector2.new(0, 1),
    Up = Vector2.new(0, 0),
    Left = Vector2.new(0, 0),
    Right = Vector2.new(1, 0)
};
local u12 = {
    Center = 0.5,
    Up = 0,
    Down = 1,
    Left = 0,
    Right = 1
};
local u13 = {
    Up = 90,
    Down = -90,
    Center = 0,
    Left = 0,
    Right = 180
};
local u14 = {
    Up = Vector2.new(0, 1),
    Down = Vector2.new(0, -1),
    Center = Vector2.new(0, 0),
    Left = Vector2.new(1, 0),
    Right = Vector2.new(-1, 0)
};
local u15 = {
    Center = -1,
    Up = 1,
    Down = -1,
    Left = 1,
    Right = -1
};
local u16 = {};

local function fixSpectrum(p17: table, p18: number) -- Line: 132
    local v19 = #p17 // 1.4 - 8;

    if v19 == 0 then
        return table.create(p18, 0);
    end;

    local table_create_ret = table.create(p18);

    for i = 0, p18 - 1 do
        local v20 = 0;
        local v21 = 0;

        for i2 = v19 ^ (i / p18) // 1, (v19 ^ ((i + 1) / p18) + 0.5) // 1 do
            v20 = v20 + p17[i2 + 8];
            v21 = v21 + 1;
            local _ = i2;
        end;

        table_create_ret[i + 1] = v20 / v21;
    end;

    return table_create_ret;
end;

function u1.new(p22: userdata, p23: table?, p24: any) -- Line: 155
    -- upvalues: u1 (copy)
    local v25 = {
        lerped = true,
        maxSize = 1,
        minSize = 0,
        transparency = 0.5,
        isRainbow = false,
        barPosition = "Down",
        barCount = 64,
        barSpacing = 0.001,
        barSize = 1,
        isHorizontalBar = false,
        visBarCount = 0,
        spectrumGap = 0,
        thickness = 1,
        closedPath = true,
        pathStartsAtMin = true,
        downsampled = false,
        sizeMult = 1,
        frame = p22,
        color = Color3.new(1, 1, 1),
        barColoring = {},
        bars = {},
        visBars = {},
        _visBarObjs = {},
        drawPointSizes = {}
    };
    local v26 = setmetatable(v25, u1);
    v26.wiring = p24 or script.Wiring:Clone();

    if not p24 then
        v26.wiring.Parent = p22;
        v26.clonedWiring = true;
    end;

    v26:setSettings(p23 or {});

    return v26;
end;

function u1.setParent(p27, p28) -- Line: 203
    p27.frame = p28;
    p27.wiring.Parent = p28;
end;

function u1.Destroy(p29) -- Line: 208
    p29.audio = nil;
    p29:setType(nil, true);
    local wiring = p29.wiring;

    if wiring and p29.clonedWiring then
        pcall(wiring.Destroy, wiring);
        p29.wiring = nil;
    end;

    function p29.update() -- Line: 215
    end;
end;

function u1.setSettings(p30: table, p31: table) -- Line: 218
    p30.barPosition = p31.barPosition or "Down";
    p30.barCount = p31.barCount or 64;
    p30.barSpacing = p31.barSpacing or 0.001;
    p30.color = p31.color or Color3.new(1, 1, 1);
    p30.isRainbow = p31.isRainbow or false;
    p30.transparency = p31.transparency or 0.5;

    if p31.lerped == nil then
        p31.lerped = true;
    end;

    p30.lerped = p31.lerped;
    p30.minSize = p31.minSize or 0.005;
    p30.maxSize = p31.maxSize or 1;
    p30.thickness = p31.thickness or 1;

    if p31.closedPath == nil then
        p31.closedPath = false;
    end;

    p30.closedPath = p31.closedPath;

    if p31.pathStartsAtMin == nil then
        p31.pathStartsAtMin = true;
    end;

    p30.pathStartsAtMin = p31.pathStartsAtMin;
    p30.visBars = p31.visBars or {};
    p30.visBarCount = p31.visBarCount or 0;

    if not p31.visBarCount and p30.visBars[1] then
        p30.visBarCount = #p30.visBars[1];
    end;

    p30.spectrumGap = p31.spectrumGap or 0;
    p30:setType(p31.type, true);
end;

function u1.setChannel(p32: table, p33: string, p34: boolean?) -- Line: 256
    if p32.channel == p33 and not p34 then
        return;
    end;

    local wiring = p32.wiring;
    wiring.Mono.Wires.PlayerToChannel.SourceInstance = p32.audio;
    wiring.Stereo.Wires.PlayerToSplit.SourceInstance = p32.audio;
    p32.channel = p33;

    if p33 == "Mono" then
        p32.leftChannel = wiring.Mono.Channel;
        p32.rightChannel = wiring.Mono.Channel;

        return;
    end;

    p32.leftChannel = wiring.Stereo.Channels.LeftChannel;
    p32.rightChannel = wiring.Stereo.Channels.RightChannel;
end;

function u1.setType(p35: table, p36: string?, p37: boolean?) -- Line: 279
    -- upvalues: u11 (copy), u12 (copy), u14 (copy), u13 (copy)
    if p35.type == p36 and not p37 then
        return;
    end;

    if p35.type == "Bars" or (p35.type == "StereoBars" or (p35.type == "GradientBars" or p35.type == "StereoGradientBars")) then
        for _, v in p35.bars do
            v.obj:Destroy();
        end;

        table.clear(p35.bars);
    elseif p35.type == "Line" or p35.type == "StereoLine" then
        local leftPath2d = p35.leftPath2d;

        if leftPath2d then
            leftPath2d:Destroy();
            p35.leftPath2d = nil;
        end;

        local rightPath2d = p35.rightPath2d;

        if rightPath2d then
            rightPath2d:Destroy();
            p35.rightPath2d = nil;
        end;

        if p35.drawPointSizes then
            table.clear(p35.drawPointSizes);
        end;
    end;

    table.clear(p35._visBarObjs);

    if not p36 then
        function p35.update() -- Line: 304
        end;

        return;
    end;

    local barPosition = p35.barPosition;
    local v38 = barPosition == "Center" and p36 == "GradientBars" and "Bars" or p36;
    p35.type = v38;
    p35:setChannel((v38 == "StereoBars" or (v38 == "StereoLine" or v38 == "StereoGradientBars")) and "Stereo" or "Mono");
    p35.isHorizontalBar = barPosition == "Left" and true or barPosition == "Right";
    local wiring = p35.wiring;

    if v38 == "Bars" then
        local barCount = p35.barCount;
        local barSpacing = p35.barSpacing;
        p35.barSize = 1 / barCount - barSpacing;
        local v39 = u11[barPosition];
        local v40 = u12[barPosition];
        local table_create_ret = table.create(barCount);

        for i = 1, barCount do
            local Instance_fromExisting_ret = Instance.fromExisting(script.BarTemplate);
            Instance_fromExisting_ret.BackgroundTransparency = p35.transparency;
            Instance_fromExisting_ret.BackgroundColor3 = p35.color;
            local v41 = (i - 1) / barCount + barSpacing / 2;
            Instance_fromExisting_ret.AnchorPoint = v39;
            Instance_fromExisting_ret.Position = p35.isHorizontalBar and UDim2.fromScale(v40, v41) or UDim2.fromScale(v41, v40);
            Instance_fromExisting_ret.Parent = p35.frame;
            table_create_ret[i] = {
                lastSize = 0,
                obj = Instance_fromExisting_ret
            };
            local _ = i;
        end;

        p35.bars = table_create_ret;
        p35.update = p35.updateBars;
    elseif v38 == "GradientBars" then
        local barCount = p35.barCount;
        local barSpacing = p35.barSpacing;
        local v42 = 1 / barCount - barSpacing;
        local table_create_ret = table.create(barCount);
        p35.gradientOffset = u14[barPosition];
        local v43 = u13[barPosition];

        for i = 1, barCount do
            local v44 = script.BarTemplate:Clone();
            v44.BackgroundTransparency = p35.transparency;
            v44.BackgroundColor3 = p35.color;
            local v45 = (i - 1) / barCount + barSpacing / 2;
            v44.AnchorPoint = Vector2.zero;
            v44.Size = p35.isHorizontalBar and UDim2.fromScale(1, v42) or UDim2.fromScale(v42, 1);
            v44.Position = p35.isHorizontalBar and UDim2.fromScale(0, v45) or UDim2.fromScale(v45, 0);
            v44.UIGradient.Enabled = true;
            v44.UIGradient.Rotation = v43;
            v44.Parent = p35.frame;
            table_create_ret[i] = {
                lastSize = 0,
                obj = v44,
                gradient = v44.UIGradient
            };
            local _ = i;
        end;

        p35.bars = table_create_ret;
        p35.update = p35.updateGradientBars;
    elseif v38 == "StereoBars" then
        local barCount = p35.barCount;
        local barSpacing = p35.barSpacing;
        p35.isHorizontalBar = true;
        p35.barSize = 1 / barCount - barSpacing;
        local Left = u11.Left;
        local Right = u11.Right;
        local table_create_ret = table.create(barCount);

        for i = 1, barCount * 2 do
            local Instance_fromExisting_ret = Instance.fromExisting(script.BarTemplate);
            Instance_fromExisting_ret.BackgroundTransparency = p35.transparency;
            Instance_fromExisting_ret.BackgroundColor3 = p35.color;
            local _ = barCount < i;

            if barCount < i then
                Instance_fromExisting_ret.AnchorPoint = Right;
                Instance_fromExisting_ret.Position = UDim2.fromScale(1, (i - 1 - barCount) / barCount + barSpacing / 2);
            else
                Instance_fromExisting_ret.AnchorPoint = Left;
                Instance_fromExisting_ret.Position = UDim2.fromScale(0, (i - 1) / barCount + barSpacing / 2);
            end;

            Instance_fromExisting_ret.Parent = p35.frame;
            table_create_ret[i] = {
                lastSize = 0,
                obj = Instance_fromExisting_ret
            };
            local _ = i;
        end;

        p35.bars = table_create_ret;
        p35.update = p35.updateStereoBars;
    elseif v38 == "StereoGradientBars" then
        local barCount = p35.barCount;
        local barSpacing = p35.barSpacing;
        local v46 = 1 / barCount - barSpacing;
        local table_create_ret = table.create(barCount);

        for i = 1, barCount * 2 do
            local v47 = script.BarTemplate:Clone();
            v47.BackgroundTransparency = p35.transparency;
            v47.BackgroundColor3 = p35.color;

            if barCount < i then
                v47.Position = UDim2.fromScale(0, (i - 1 - barCount) / barCount + barSpacing / 2);
                v47.UIGradient.Rotation = 180;
            else
                v47.Position = UDim2.fromScale(0, (i - 1) / barCount + barSpacing / 2);
                v47.UIGradient.Rotation = 0;
            end;

            v47.AnchorPoint = Vector2.zero;
            v47.Size = UDim2.fromScale(1, v46);
            v47.UIGradient.Enabled = true;
            v47.Parent = p35.frame;
            table_create_ret[i] = {
                lastSize = 0,
                obj = v47,
                gradient = v47.UIGradient
            };
            local _ = i;
        end;

        p35.bars = table_create_ret;
        p35.update = p35.updateStereoGradientBars;
    elseif v38 == "VisualBars" then
        local v48 = #p35.visBars;
        p35.barCount = v48;
        local v49 = {};

        for i = 1, v48 do
            v49[i] = {
                lastCount = 0,
                lastSize = 0,
                objs = p35.visBars[i]
            };
            local _ = i;
        end;

        p35._visBarObjs = v49;
        p35.update = p35.updateVisualBars;
    elseif v38 == "Line" then
        local Instance_fromExisting_ret = Instance.fromExisting(script.PathTemplate);
        Instance_fromExisting_ret.Color3 = p35.color;
        Instance_fromExisting_ret.Thickness = p35.thickness;
        Instance_fromExisting_ret.Closed = p35.closedPath;
        Instance_fromExisting_ret.Parent = p35.frame;
        p35.leftPath2d = Instance_fromExisting_ret;
        p35.update = p35.updateLine;
    else
        function p35.update() -- Line: 497
        end;
    end;

    local Small = Enum.AudioWindowSize.Small;
    wiring.Mono.Channel.WindowSize = Small;
    wiring.Stereo.Channels.LeftChannel.WindowSize = Small;
    wiring.Stereo.Channels.RightChannel.WindowSize = Small;
end;

function u1.setAudio(p50: table, p51: userdata) -- Line: 507
    p50.audio = p51;
    local wiring = p50.wiring;
    wiring.Mono.Wires.PlayerToChannel.SourceInstance = p51;
    wiring.Stereo.Wires.PlayerToSplit.SourceInstance = p51;
end;

function u1.updateBars(p52: table, p53: number) -- Line: 518
    -- upvalues: u16 (copy), fixSpectrum (copy), u6 (copy)
    local minSize = p52.minSize;
    local maxSize = p52.maxSize;
    local lerped = p52.lerped;
    local v54 = p52.sizeMult * 4;
    local barSize = p52.barSize;
    local isHorizontalBar = p52.isHorizontalBar;
    local v55 = p53 * 15;
    local v56 = v55 > 1 and 1 or v55;
    local leftChannel = p52.leftChannel;
    local v57 = u16[leftChannel];

    if not v57 then
        v57 = leftChannel:GetSpectrum();
        u16[leftChannel] = v57;
    end;

    if p52.downsampled then
        v57 = fixSpectrum(v57, p52.barCount);
    end;

    for i, v in p52.bars do
        local v58 = (v57[i] or 0) * v54;

        if v58 < minSize then
            v58 = minSize;
        elseif maxSize < v58 then
            v58 = maxSize;
        end;

        local lastSize = v.lastSize;

        if lerped then
            v58 = math.lerp(lastSize, v58, v56);
        end;

        if lastSize ~= v58 then
            v.lastSize = v58;
            u6(v.obj, "Size", isHorizontalBar and UDim2.fromScale(v58, barSize) or UDim2.fromScale(barSize, v58));
        end;
    end;
end;

function u1.updateGradientBars(p59: table, p60: number) -- Line: 561
    -- upvalues: u16 (copy), fixSpectrum (copy), u10 (copy)
    local minSize = p59.minSize;
    local maxSize = p59.maxSize;
    local lerped = p59.lerped;
    local v61 = p59.sizeMult * 4;
    local gradientOffset = p59.gradientOffset;
    local v62 = p60 * 15;
    local v63 = v62 > 1 and 1 or v62;
    local leftChannel = p59.leftChannel;
    local v64 = u16[leftChannel];

    if not v64 then
        v64 = leftChannel:GetSpectrum();
        u16[leftChannel] = v64;
    end;

    if p59.downsampled then
        v64 = fixSpectrum(v64, p59.barCount);
    end;

    for i, v in p59.bars do
        local v65 = (v64[i] or 0) * v61;

        if v65 < minSize then
            v65 = minSize;
        elseif maxSize < v65 then
            v65 = maxSize;
        end;

        local lastSize = v.lastSize;

        if lerped then
            v65 = math.lerp(lastSize, v65, v63);
        end;

        if lastSize ~= v65 then
            v.lastSize = v65;
            u10(v.gradient, "Offset", gradientOffset * v65);
        end;
    end;
end;

function u1.updateVisualBars(p66: table, p67: number) -- Line: 603
    -- upvalues: u16 (copy), fixSpectrum (copy), u6 (copy)
    local minSize = p66.minSize;
    local maxSize = p66.maxSize;
    local lerped = p66.lerped;
    local v68 = p66.sizeMult * 4;
    local v69 = p67 * 15;
    local v70 = v69 > 1 and 1 or v69;
    local visBarCount = p66.visBarCount;
    local v71 = 1 / (visBarCount + 1);
    local spectrumGap = p66.spectrumGap;
    local leftChannel = p66.leftChannel;
    local v72 = u16[leftChannel];

    if not v72 then
        v72 = leftChannel:GetSpectrum();
        u16[leftChannel] = v72;
    end;

    if p66.downsampled then
        v72 = fixSpectrum(v72, visBarCount);
    end;

    for i, v in p66._visBarObjs do
        local v73 = (v72[i + spectrumGap * (i - 1)] or 0) * v68;

        if v73 < minSize then
            v73 = minSize;
        elseif maxSize < v73 then
            v73 = maxSize;
        end;

        local lastSize = v.lastSize;

        if lerped then
            v73 = math.lerp(lastSize, v73, v70);
        end;

        v.lastSize = v73;
        local lastCount = v.lastCount;
        local v74 = v73 // v71;

        if visBarCount < v74 then
            v74 = visBarCount;
        end;

        if lastCount ~= v74 then
            local objs = v.objs;
            local v75;

            if v74 < lastCount then
                v75 = v;

                for i2 = lastCount, v74 + 1, -1 do
                    u6(objs[i2], "Visible", false);
                    local _ = i2;
                end;
            else
                v75 = v;

                for i2 = lastCount + 1, v74 do
                    u6(objs[i2], "Visible", true);
                    local _ = i2;
                end;
            end;

            v75.lastCount = v74;
        end;
    end;
end;

function u1.updateStereoGradientBars(p76: table, p77: number) -- Line: 666
    -- upvalues: u16 (copy), fixSpectrum (copy), u10 (copy)
    local minSize = p76.minSize;
    local maxSize = p76.maxSize;
    local lerped = p76.lerped;
    local v78 = p76.sizeMult * 2;
    local barCount = p76.barCount;
    local v79 = p77 * 15;
    local v80 = v79 > 1 and 1 or v79;
    local v81 = false;
    local leftChannel = p76.leftChannel;
    local v82 = u16[leftChannel];
    local v83 = u16[p76.rightChannel];

    if not v82 then
        v82 = leftChannel:GetSpectrum();
        u16[leftChannel] = v82;
    end;

    if not v83 then
        v83 = leftChannel:GetSpectrum();
        u16[leftChannel] = v83;
    end;

    if p76.downsampled then
        v82 = fixSpectrum(v82, barCount);
        v83 = fixSpectrum(v83, barCount);
    end;

    for i, v in p76.bars do
        v81 = v81 or barCount < i;
        local v84 = (v81 and v83[i - barCount] or (v82[i] or 0)) * v78;

        if v84 < minSize then
            v84 = minSize;
        elseif maxSize < v84 then
            v84 = maxSize;
        end;

        local lastSize = v.lastSize;

        if lerped then
            v84 = math.lerp(lastSize, v84, v80);
        end;

        if lastSize ~= v84 then
            v.lastSize = v84;
            u10(v.gradient, "Offset", v81 and Vector2.new(-v84, 0) or Vector2.new(v84, 0));
        end;
    end;
end;

function u1.updateStereoBars(p85: table, p86: number) -- Line: 717
    -- upvalues: u16 (copy), fixSpectrum (copy), u6 (copy)
    local minSize = p85.minSize;
    local v87 = p85.maxSize / 2;
    local lerped = p85.lerped;
    local v88 = p85.sizeMult * 2;
    local barSize = p85.barSize;
    local barCount = p85.barCount;
    local v89 = p86 * 15;
    local v90 = v89 > 1 and 1 or v89;
    local leftChannel = p85.leftChannel;
    local v91 = u16[leftChannel];
    local v92 = u16[p85.rightChannel];

    if not v91 then
        v91 = leftChannel:GetSpectrum();
        u16[leftChannel] = v91;
    end;

    if not v92 then
        v92 = leftChannel:GetSpectrum();
        u16[leftChannel] = v92;
    end;

    if p85.downsampled then
        v91 = fixSpectrum(v91, barCount);
        v92 = fixSpectrum(v92, barCount);
    end;

    for i, v in p85.bars do
        local v93 = (barCount < i and v92[i - barCount] or (v91[i] or 0)) * v88;

        if v93 < minSize then
            v93 = minSize;
        elseif v87 < v93 then
            v93 = v87;
        end;

        local lastSize = v.lastSize;

        if lerped then
            v93 = math.lerp(lastSize, v93, v90);
        end;

        if lastSize ~= v93 then
            v.lastSize = v93;
            u6(v.obj, "Size", UDim2.fromScale(v93, barSize));
        end;
    end;
end;

function u1.updateLine(p94: table, p95: number) -- Line: 766
    -- upvalues: u12 (copy), u15 (copy), u16 (copy), fixSpectrum (copy)
    local leftPath2d = p94.leftPath2d;
    local MaxControlPoints = leftPath2d:GetMaxControlPoints();
    local pathStartsAtMin = p94.pathStartsAtMin;
    local v96 = p94.barCount + (pathStartsAtMin and 2 or 0);

    if MaxControlPoints < v96 then
        v96 = MaxControlPoints;
    end;

    if v96 == 0 then
        local v97 = {};
        leftPath2d:SetControlPoints(v97);
        p94.drawPointSizes = v97;

        return;
    end;

    local barPosition = p94.barPosition;
    local v98 = barPosition == "Center";
    local isHorizontalBar = p94.isHorizontalBar;
    local minSize = p94.minSize;
    local maxSize = p94.maxSize;
    local lerped = p94.lerped;
    local v99 = p94.sizeMult * 4;
    local v100 = p95 * 15;
    local v101 = v100 > 1 and 1 or v100;
    local table_create_ret = table.create(v96);
    local table_create_ret2 = table.create(v96);
    local drawPointSizes = p94.drawPointSizes;
    local v102 = u12[barPosition];
    local v103 = u15[barPosition];

    if pathStartsAtMin then
        table_create_ret[1] = Path2DControlPoint.new(isHorizontalBar and UDim2.fromScale(v102, 0) or UDim2.fromScale(0, v102));
        table_create_ret[v96] = Path2DControlPoint.new(isHorizontalBar and UDim2.fromScale(v102, 1) or UDim2.fromScale(1, v102));
        v96 = v96 - 2;
    end;

    local v104 = 1 / v96 / 2;
    local leftChannel = p94.leftChannel;
    local v105 = u16[leftChannel];

    if not v105 then
        v105 = leftChannel:GetSpectrum();
        u16[leftChannel] = v105;
    end;

    if p94.downsampled then
        v105 = fixSpectrum(v105, v96);
    end;

    for i = 1, v96 do
        local v106 = (v105[i] or 0) * v99;

        if v106 < minSize then
            v106 = minSize;
        elseif maxSize < v106 then
            v106 = maxSize;
        end;

        if v98 and i % 2 == 0 then
            v106 = -v106;
        end;

        local v107 = drawPointSizes[i] or v106;

        if lerped then
            v106 = math.lerp(v107, v106, v101);
        end;

        table_create_ret2[i] = v106;
        local v108 = (i - 1) / v96 + v104;
        local v109 = v102 + v106 * v103;
        table_create_ret[i + 1] = Path2DControlPoint.new(isHorizontalBar and UDim2.fromScale(v109, v108) or UDim2.fromScale(v108, v109));
        local _ = i;
    end;

    leftPath2d:SetControlPoints(table_create_ret);
    p94.drawPointSizes = table_create_ret2;
end;

function u1.update(p110) -- Line: 854
end;

local RunService = game:GetService("RunService");

if RunService:IsClient() then
    RunService:BindToRenderStep("_VisCacheReset", Enum.RenderPriority.First.Value + 1, function() -- Line: 860
        -- upvalues: u16 (copy)
        table.clear(u16);
    end);

    return u1;
end;

RunService.Heartbeat:Connect(function() -- Line: 864
    -- upvalues: u16 (copy)
    table.clear(u16);
end);

return u1;