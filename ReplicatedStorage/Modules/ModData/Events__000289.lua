-- Decompiled with Potassium's decompiler.

local u1 = {
    RepStorage = game:GetService("ReplicatedStorage"),
    TweenService = game:GetService("TweenService"),
    Debris = game:GetService("Debris")
};
local u2 = nil;
local Modules = u1.RepStorage:WaitForChild("Modules");
require(Modules.Modchart.MirasTools.BadAppleFilter);
local u3 = nil;
local u4 = {
    Conductor = require(Modules.Main.Conductor),
    varTweener = require(Modules.Main.VarTweener),
    CustomFont = require(Modules.Other.RBX_CustomFont)
};
local u5 = {};

function createFullScreenFrame(p6: string, p7)
    local Frame = Instance.new("Frame");
    Frame.Name = p6;
    Frame.Size = UDim2.fromScale(10, 10);
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.BackgroundColor3 = p7 or Color3.new(0, 0, 0);
    Frame.BackgroundTransparency = 1;
    Frame.ZIndex = 3;

    return Frame;
end;

function signedIntToColor(p8)
    local bit32_band_ret = bit32.band(p8, 4294967295);
    local bit32_rshift_ret = bit32.rshift(bit32_band_ret, 16);
    local bit32_band_ret2 = bit32.band(bit32_rshift_ret, 255);
    local bit32_rshift_ret2 = bit32.rshift(bit32_band_ret, 8);
    local bit32_band_ret3 = bit32.band(bit32_rshift_ret2, 255);
    local bit32_band_ret4 = bit32.band(bit32_band_ret, 255);
    Color3.fromRGB(bit32_band_ret2, bit32_band_ret3, bit32_band_ret4);
    local string_format_ret = string.format("#%02X%02X%02X", bit32_band_ret2, bit32_band_ret3, bit32_band_ret4);

    return tostring(string_format_ret);
end;

function parseColor(p9)
    local v10 = tonumber(p9) or p9;

    if typeof(v10) ~= "number" then
        return v10;
    end;

    if v10 < 0 then
        return signedIntToColor(v10);
    end;

    return tostring(hex(v10, 6));
end;

local script_BlammedLights = require(script.BlammedLights);
local u11 = {};

function findFontWeight(p12)
    for _, v in Enum.FontWeight:GetEnumItems() do
        if v.Value == p12 then
            return v;
        end;
    end;

    return nil;
end;

local u13 = createFullScreenFrame("Fade");
local u14 = createFullScreenFrame("Fade");
local u15 = nil;
local u16 = 3;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;

function setSubtitleTarget(p22)
    -- upvalues: u18 (ref)
    if not (u18 and p22) then
        return;
    end;

    u18.Parent = p22;
end;

function setBarTarget(p23)
    -- upvalues: u21 (ref), u19 (ref), u2 (ref)
    u21 = p23;

    if u19 ~= nil then
        u19.Parent = p23 or u2.Overlay;
    end;

    setFadeTarget(p23);
end;

function setFadeTarget(p24)
    -- upvalues: u20 (ref), u13 (ref), u2 (ref)
    u20 = p24;

    if u13 ~= nil then
        u13.Parent = p24 or u2.Overlay;
    end;
end;

local u25 = {
    camZoomingMult = { "camGame.cameraBeatMultiplier", 1 },
    beatsPerZoom = { "camGame.cameraBeat", 4 },
    defaultCamZoom = { "camGame.defaultZoom", 1 }
};
local u26 = nil;

function fireStageRemote(p27, ...)
    -- upvalues: u26 (ref)
    if u26 == nil then
        print("no stage remote");

        return;
    end;

    u26:FireServer(p27, ...);
end;

function setBarTransparency(p28)
    -- upvalues: u19 (ref)
    u19:SetAttribute("TargetTransparency", p28);
end;

function parseStepsToSeconds(p29)
    -- upvalues: u4 (copy)
    return u4.Conductor.StepCrochet / 1000 * p29;
end;

function hex(p30, p31)
    local v32 = "";

    repeat
        local v33 = p30 % 16 + 1;
        v32 = string.sub("0123456789ABCDEF", v33, v33) .. v32;
        p30 = math.floor(p30 / 16);
    until p30 <= 0;

    if p31 ~= nil then
        if p31 < #v32 then
            v32 = string.sub(v32, -p31);
        end;

        while #v32 < p31 do
            v32 = "0" .. v32;
        end;
    end;

    return "#" .. v32;
end;

local u215 = {
    ["BPM Change"] = function(p34) -- Line: 155
        -- upvalues: u4 (copy)
        u4.Conductor.changeBPM(tonumber(p34) or 100);
    end,

    ["Time Sig Change"] = function(p35) -- Line: 158
        -- upvalues: u4 (copy)
        local BPM = u4.Conductor.BPM;
        local string_split_ret = string.split(p35, "/");
        u4.Conductor.BeatsPerMeasure = tonumber(string_split_ret[1] or "4") or 4;
        u4.Conductor.StepsPerBeat = tonumber(string_split_ret[2] or "4") or 4;
        u4.Conductor.changeBPM(BPM);
    end,

    ["Add Camera Zoom"] = function(p36, p37) -- Line: 165
        -- upvalues: u2 (ref)
        u2.setProperty("camGame.zoom", u2.getProperty("camGame.zoom") + (tonumber(p36) or 0.015));
        u2.setProperty("camHUD.zoom", u2.getProperty("camHUD.zoom") + (tonumber(p37) or 0.03));
    end,

    ["Set Camera Zoom"] = function(p38, p39) -- Line: 169
        -- upvalues: u2 (ref)
        local v40 = tonumber(p38) or 1;
        local v41 = (tonumber(p39) or 0.001) / u2.playbackRate;

        if v41 and v41 > 0 then
            u2.tweenProperty("camGame.defaultZoom", v40, v41, "sineInOut");

            return;
        end;

        u2.setProperty("camGame.defaultZoom", v40);
    end,

    ["Set HUD Zoom"] = function(p42, p43) -- Line: 180
        -- upvalues: u2 (ref)
        local v44 = tonumber(p42) or 1;
        local v45 = (tonumber(p43) or 0) / u2.playbackRate;

        if v45 and v45 > 0 then
            u2.tweenProperty("camHUD.defaultZoom", v44, v45, "sineInOut");

            return;
        end;

        u2.setProperty("camHUD.defaultZoom", v44);
    end,

    ["Blammed Lights"] = function(p46, p47) -- Line: 191
        -- upvalues: script_BlammedLights (copy)
        local v48 = tonumber(p46) or 0;
        script_BlammedLights.doBlammedLights(v48 > 0, v48);
    end,

    ["Set Scroll Speed"] = function(p49, p50) -- Line: 195
        -- upvalues: u2 (ref), u4 (copy)
        if not u2.Settings.SVChanges then
            return;
        end;

        local v51 = tonumber(p49) or 1;
        local v52 = (tonumber(p50) or 0) / u2.playbackRate;

        if v52 > 0 then
            u4.varTweener:Create(u2, TweenInfo.new(v52, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                songSpeed = v51
            }):Play();

            return;
        end;

        u2.songSpeed = v51;
    end,

    ["Change Scroll Speed"] = function(p53, p54) -- Line: 210
        -- upvalues: u2 (ref), u4 (copy)
        if not u2.Settings.SVChanges then
            return;
        end;

        local v55 = tonumber(p53) or 1;
        local v56 = (tonumber(p54) or 0) / u2.playbackRate;
        local v57 = u2.Settings.ForceScrollSpeed and u2.Settings.ScrollSpeed or u2.song.speed * u2.Settings.ScrollSpeed;
        local v58 = v57 * u2.balanceSpeedMult(v55, v57);

        if v56 > 0 then
            u4.varTweener:Create(u2, TweenInfo.new(v56, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                songSpeed = v58
            }):Play();

            return;
        end;

        u2.songSpeed = v58;
    end,

    ZoomCamera = function(p59) -- Line: 228
        -- upvalues: u2 (ref)
        local v60 = tonumber(p59.zoom) or 1;
        local v61 = p59.ease or "instant";
        local v62 = v61 == "instant" and 0.001 or (tonumber(p59.duration) or 1);
        local v63 = (p59 == nil and "" or (p59.ease or "")) .. ((p59 == nil or not p59.ease) and "" or (p59.easeDir or ""));
        u2.cancelTweensOf("camGame.baseGameZoom");
        u2.tweenProperty("camGame.baseGameZoom", v60, v61 == "instant" and 0.001 or u2.Conductor.StepCrochet * v62 / 1000 / u2.playbackRate, v61 == "instant" and "linear" or v63);
    end,

    SetCameraBop = function(p64) -- Line: 238
        -- upvalues: u2 (ref)
        local v65 = (tonumber(p64.rate) or 1) * 4;
        local v66 = tonumber(p64.intensity) or 1;
        u2.setProperty("camGame.cameraBeat", v65);
        u2.setProperty("camHUD.cameraBeat", v65);
        u2.setProperty("camGame.cameraBeatMultiplier", v66);
        u2.setProperty("camHUD.cameraBeatMultiplier", v66);
    end,

    ["Set Game Zoom"] = function(p67, p68) -- Line: 248
        -- upvalues: u2 (ref)
        local v69 = tonumber(p67) or 1;
        local v70 = (tonumber(p68) or 0) / u2.playbackRate;

        if v70 and v70 > 0 then
            u2.tweenProperty("camGame.defaultZoom", v69, v70, "sineInOut");

            return;
        end;

        u2.setProperty("camGame.defaultZoom", v69);
    end,

    ["Screen Shake"] = function(p71, p72) -- Line: 258
        -- upvalues: u2 (ref)
        local string_split_ret = string.split(p71, ",");
        local string_split_ret2 = string.split(p72, ",");

        for i = 1, 2 do
            local v73 = i == 1 and "camGame" or "camHUD";
            local v74 = i == 1 and string_split_ret and string_split_ret or string_split_ret2;
            local v75;

            if #v74 == 0 then
                v75 = i;
            else
                u2.setProperty(v73 .. "._shakeDuration", (tonumber(v74[1]) or 0) / u2.playbackRate);
                u2.setProperty(v73 .. "._shakeIntensity", tonumber(v74[2]) or 0);
                v75 = i;
            end;
        end;
    end,

    ["HUD Shake"] = function(p76, p77, p78, p79) -- Line: 273
        callEvent("Screen Shake", "0,0", (`{p76},{p77}`));
    end,

    ["Camera Shake"] = function(p80, p81) -- Line: 276
        callEvent("Screen Shake", `{p80},{p81}`, "0,0");
    end,

    ["Play Animation"] = function(p82, p83, p84) -- Line: 279
        -- upvalues: u2 (ref)
        local v85 = p83 and (p83:lower() == "dad" and "L" or "R") or "R";

        if not (p83 and (p83:lower() == "gf" or p83:lower() == "girlfriend")) then
            for _, v in u2.getCharacters(v85) do
                v:Play(p82);
            end;

            return;
        end;

        if u2.GFCharacter ~= nil then
            u2.GFCharacter:Play(p82);
        end;

        if p84 ~= nil then
            fireStageRemote("GFEventAnimation", p84, p82);
        end;
    end,

    PlayAnimation = function(p86, p87, p88) -- Line: 294
        callEvent("Play Animation", p86.anim, p86.target, p88);
    end,

    ["Hey!"] = function(p89, p90, p91) -- Line: 297
        local v92 = (p89 == nil or (p89 == "" or (p89:lower() == "bf" or p89:lower() == "boyfriend"))) and true or p89:lower() == "0";
        local v93 = (p89:lower() == "gf" or p89:lower() == "girlfriend") and true or p89:lower() == "1";
        callEvent("Play Animation", "Hey", v93 and "gf" or (v92 and "bf" or "dad"), p91);
    end,

    ["Switch Prefix"] = function(p94, p95, p96) -- Line: 302
        -- upvalues: u2 (ref)
        local v97 = p95:lower() == "dad" and "L" or "R";

        if p95:lower() == "gf" then
            if u2.GFCharacter ~= nil then
                u2.GFCharacter.animPrefix = p94;
                u2.GFCharacter:Dance();
            end;

            return;
        end;

        for _, v in u2.getCharacters(v97 == "R" and "R" or "L") do
            v.animPrefix = p94;
            v:Dance();
        end;
    end,

    ["Set Property"] = function(p98, p99) -- Line: 319
        -- upvalues: u25 (copy), u2 (ref)
        if u25[p98] then
            local v100 = u25[p98];
            p98 = v100[1];
            p99 = (tonumber(p99) or 0) * v100[2];
        end;

        u2.setProperty(p98, p99);
    end,

    ["Afternight Window Title"] = function(p101, p102) -- Line: 328
        -- upvalues: u2 (ref)
        u2.setTitle(p101);
    end,

    ["Afternight Flash"] = function(p103, u104, p105, p106) -- Line: 331
        -- upvalues: u2 (ref), u1 (copy), u5 (copy)
        if not u2.Settings.CameraFlash then
            return;
        end;

        local v107 = string.find(p106, "Underlay") ~= nil;
        local v108 = string.find(p106, "Reverse") ~= nil;
        local v109 = (tonumber(p103) or 1) / u2.playbackRate;
        local Color3_new_ret = Color3.new(1, 1, 1);
        local success, result = pcall(function() -- Line: 340
            -- upvalues: Color3_new_ret (ref), u104 (copy)
            Color3_new_ret = Color3.fromHex(u104);
        end);

        if result or not success then
            Color3_new_ret = Color3.new(1, 1, 1);
        end;

        local v110 = v107 and u2.Underlay or u2.Overlay;

        if v110:FindFirstChild("Flash") then
            v110.Flash:Destroy();
        end;

        local v111 = createFullScreenFrame("Flash", Color3_new_ret);
        v111.BackgroundTransparency = v108 and 1 or 0;
        v111.Visible = true;
        v111.Parent = v110;
        u1.TweenService:Create(v111, TweenInfo.new(v109), {
            BackgroundTransparency = v108 and 0 or 1
        }):Play();
        u1.Debris:AddItem(v111, v109 + 1);
        table.insert(u5, v111);
    end,

    ["Afternight Flash Reverse"] = "Afternight Flash",
    ["Afternight Underlay Flash"] = "Afternight Flash",
    ["Afternight Flash Underlay"] = "Afternight Flash",
    ["Afternight Underlay Flash Reverse"] = "Afternight Flash",
    ["Afternight Flash Underlay Reverse"] = "Afternight Flash",

    ["Afternight HUD Fade"] = function(p112, p113) -- Line: 363
        -- upvalues: u2 (ref)
        local v114 = (tonumber(p113) or 1) / u2.playbackRate;

        if p112 == "true" or (p112 == true or p112 == 1) then
            u2.HUDApi:ShowHUD(v114);

            return;
        end;

        u2.HUDApi:HideHUD(v114);
    end,

    ["Afternight Game Fade"] = function(p115, p116) -- Line: 371
        -- upvalues: u2 (ref), u4 (copy)
        local v117 = (tonumber(p116) or 1) / u2.playbackRate;
        local Receptors = shared.getReceptors();

        if p115 ~= "true" and (p115 ~= true and p115 ~= 1) then
            u2.HUDApi:HideHUD(v117);

            for _, v in Receptors do
                u4.varTweener:Create(v, TweenInfo.new(v117, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    alpha = 0
                }):Play();
            end;

            return;
        end;

        u2.HUDApi:ShowHUD(v117);
        shared.getStrumsByName("player");

        for _, v in Receptors do
            u4.varTweener:Create(v, TweenInfo.new(v117, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                alpha = 1
            }):Play();
        end;
    end,

    ["Afternight HUD Alpha"] = function(p118, p119) -- Line: 389
        -- upvalues: u2 (ref)
        local v120 = 1 - (tonumber(p118) or 0);
        local v121 = (tonumber(p119) or 1) / u2.playbackRate;
        u2.HUDApi:HideHUD(v121, v120);
    end,

    ["Afternight Strums Alpha"] = function(p122, p123) -- Line: 395
        -- upvalues: u2 (ref), u4 (copy)
        local v124 = (tonumber(p123) or 1) / u2.playbackRate;
        local v125 = tonumber(p122) or 0;

        for _, v in shared.getReceptors() do
            u4.varTweener:Create(v, TweenInfo.new(v124, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                alpha = v125
            }):Play();
        end;
    end,

    ["Afternight Strums Side Alpha"] = function(p126, p127) -- Line: 404
        -- upvalues: u2 (ref)
        local StrumsBySide = u2.getStrumsBySide(p126);
        local v128 = tonumber(p127);

        for _, v in StrumsBySide do
            v.alpha = v128;
        end;
    end,

    ["Afternight Game Alpha"] = function(p129, p130, p131, p132) -- Line: 412
        callEvent("Afternight HUD Alpha", p129, p130);
        callEvent("Afternight Strums Alpha", p129, p130);
    end,

    ["Afternight Fade ZIndex"] = function(p133) -- Line: 416
        -- upvalues: u16 (ref)
        u16 = tonumber(p133) or 3;
    end,

    ["Afternight Fade"] = function(p134, p135, p136, p137) -- Line: 419
        -- upvalues: u2 (ref), u14 (ref), u13 (ref), u16 (ref), u15 (ref), u1 (copy)
        local v138 = (tonumber(p134) or 1) / u2.playbackRate;
        local v139 = tonumber(p135) or 1;
        local v140 = string.find(p137, "Underlay") ~= nil;
        local v141 = v140 and u14 or u13;

        if v141 == nil then
            v141 = createFullScreenFrame("Fade");
            v141.Parent = v140 and u2.Underlay or u2.Overlay;
            v141.ZIndex = u16;
        end;

        if u15 ~= nil then
            u15:Cancel();
        end;

        v141.BackgroundTransparency = v139;
        v141.Visible = true;
        local v142 = v138 or 1;
        local v143 = 1 - v139;

        if v142 <= 0.01 then
            v141.BackgroundTransparency = v143;

            return;
        end;

        u15 = u1.TweenService:Create(v141, TweenInfo.new(v142), {
            BackgroundTransparency = v143
        });
        u15:Play();
    end,

    ["Afternight Fade Underlay"] = "Afternight Fade",

    ["Afternight Reset Fade"] = function(p144, p145) -- Line: 451
        -- upvalues: u15 (ref), u20 (ref), u16 (ref), u13 (ref), u2 (ref), u14 (ref)
        if u15 ~= nil then
            u15:Cancel();
            u15 = nil;
        end;

        u20 = nil;
        u16 = 3;

        if u13 ~= nil then
            u13:Destroy();
        end;

        u13 = createFullScreenFrame("Fade");
        u13.Parent = u2.Overlay;

        if u14 ~= nil then
            u14:Destroy();
        end;

        u14 = createFullScreenFrame("Fade");
        u14.Parent = u2.Underlay;
    end,

    ["Afternight Bars"] = function(p146, p147, p148, p149) -- Line: 472
        -- upvalues: u2 (ref), u19 (ref), u21 (ref), u1 (copy), u4 (copy)
        local v150 = tonumber(p146) or 0;
        local v151 = v150 / 100;
        local v152 = v151 / 2;
        local u153 = (tonumber(p147) or 1) / u2.playbackRate;
        local v154 = string.find(p149, "Underlay") ~= nil;
        local u155 = u19;
        local u156 = v151 == 0 and 1 or u19:GetAttribute("TargetTransparency");
        u155.Parent = u21 and u21 or (v154 and u2.Underlay or u2.Overlay);

        for _, child in u155:GetChildren() do
            child.Visible = true;
        end;

        u1.TweenService:Create(u155.TopBar, TweenInfo.new(u153, Enum.EasingStyle.Quad), {
            Position = UDim2.fromScale(0.5, v152)
        }):Play();
        u1.TweenService:Create(u155.BottomBar, TweenInfo.new(u153, Enum.EasingStyle.Quad), {
            Position = UDim2.fromScale(0.5, 1 - v152)
        }):Play();

        if u156 == 1 then
            task.delay(u153 / 10 * 9, function() -- Line: 491
                -- upvalues: u1 (ref), u155 (copy), u153 (copy), u156 (copy)
                u1.TweenService:Create(u155.TopBar, TweenInfo.new(u153 / 10, Enum.EasingStyle.Quad), {
                    BackgroundTransparency = u156
                }):Play();
                u1.TweenService:Create(u155.BottomBar, TweenInfo.new(u153 / 10, Enum.EasingStyle.Quad), {
                    BackgroundTransparency = u156
                }):Play();
            end);
        else
            u1.TweenService:Create(u155.TopBar, TweenInfo.new(u153 / 10, Enum.EasingStyle.Quad), {
                BackgroundTransparency = u156
            }):Play();
            u1.TweenService:Create(u155.BottomBar, TweenInfo.new(u153 / 10, Enum.EasingStyle.Quad), {
                BackgroundTransparency = u156
            }):Play();
        end;

        if string.find(p149, "Note Movement") ~= nil then
            for _, v in shared.getReceptors() do
                local varTweener = u4.varTweener;
                local TweenInfo_new_ret = TweenInfo.new(u153, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                local v157 = {};
                local v158 = _G["defaultStrum" .. tostring(v.strumIndex) .. "Y"];
                local v159;

                if u2.getSetting(v.side, "Downscroll") then
                    v159 = -v150 or v150;
                else
                    v159 = v150;
                end;

                v157.y = v158 + v159 * 2.75;
                varTweener:Create(v, TweenInfo_new_ret, v157):Play();
            end;
        end;
    end,

    ["Afternight Bars with Note Movement"] = "Afternight Bars",
    ["Afternight Bars Underlay with Note Movement"] = "Afternight Bars",
    ["Afternight Bars Underlay"] = "Afternight Bars",

    ["Afternight Subtitles"] = function(p160, p161) -- Line: 511
        -- upvalues: u2 (ref), u18 (ref), u17 (ref), u1 (copy), Modules (copy), u4 (copy)
        if not u2.Settings.ShowSubtitles then
            return;
        end;

        local v162 = p160 == nil and "" or (tostring(p160) or "");
        local u163 = p161 == nil and {} or (string.split(p161, ",") or {});
        local v164 = #string.split(v162, "\n");
        local Color3_new_ret = Color3.new(1, 1, 1);
        local u165 = nil;
        local u166 = nil;
        local Attribute = u18:GetAttribute("Height");

        if u163[1] ~= nil and u163[1] ~= "" then
            local _, result = pcall(function() -- Line: 525
                -- upvalues: Color3_new_ret (ref), u163 (copy)
                Color3_new_ret = Color3.fromHex(u163[1]);
            end);

            if result then
                Color3_new_ret = Color3.new(1, 1, 1);
            end;
        end;

        if u163[2] ~= nil and u163[2] ~= "" then
            local u167 = 400;

            for i, v in string.split(u163[2], ":") do
                if i == 1 then
                    u166 = v;
                elseif i == 2 then
                    u167 = tonumber(v);
                end;
            end;

            local _, _ = pcall(function() -- Line: 541
                -- upvalues: u165 (ref), u166 (ref), u167 (ref)
                u165 = Font.fromName(u166, findFontWeight(u167));
            end);
        end;

        if u163[3] ~= nil and u163[3] ~= "" then
            local _, result = pcall(function() -- Line: 547
                -- upvalues: Attribute (ref), u163 (copy)
                Attribute = tonumber(u163[3]);
            end);

            if result then
                Attribute = u18:GetAttribute("Height");
            end;
        end;

        if v162 == "" then
            if u17 then
                for _, descendant in u18:GetDescendants() do
                    if descendant.ClassName == "ImageLabel" then
                        u1.TweenService:Create(descendant, TweenInfo.new(0.25 / u2.playbackRate), {
                            ImageTransparency = 1
                        }):Play();
                    end;
                end;
            else
                u1.TweenService:Create(u18, TweenInfo.new(0.25 / u2.playbackRate, Enum.EasingStyle.Quad), {
                    TextTransparency = 1
                }):Play();
            end;
        else
            u18.Size = UDim2.fromScale(0.95, Attribute * v164);
            u18.Position = UDim2.fromScale(0.5, u2.getSetting(nil, "Downscroll") and 1 - u18:GetAttribute("Position") or u18:GetAttribute("Position"));
            u18.Text = v162;
            u18.TextColor3 = Color3_new_ret;
            u1.TweenService:Create(u18, TweenInfo.new(0.001, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play();

            if u17 then
                u17:Revert();
                u17 = nil;
            end;

            if u166 == nil or string.sub(u166, 1, 1) ~= "+" then
                if u165 ~= nil then
                    if Color3_new_ret == Color3.new(0, 0, 0) then
                        u18.TextStrokeColor3 = Color3.new(1, 1, 1);
                    else
                        u18.TextStrokeColor3 = Color3.new(0, 0, 0);
                    end;

                    u18.FontFace = u165;
                end;
            elseif Modules.Other.RBX_CustomFont:FindFirstChild(u166:sub(2)) then
                if Color3_new_ret == Color3.new(0, 0, 0) then
                    u18.TextColor3 = Color3.new(1, 1, 1);
                end;

                u17 = u4.CustomFont.Replace(u166:sub(2), u18);
            else
                u18.FontFace = Font.fromName("PressStart2P", Enum.FontWeight.Regular);

                if Color3_new_ret == Color3.new(0, 0, 0) then
                    u18.TextStrokeColor3 = Color3.new(1, 1, 1);
                else
                    u18.TextStrokeColor3 = Color3.new(0, 0, 0);
                end;
            end;
        end;
    end,

    ["Add CamOnly Zoom"] = function(p168, p169) -- Line: 605
        -- upvalues: u2 (ref)
        u2.setProperty("camGame.zoom", u2.getProperty("camGame.zoom") + (tonumber(p168) or 0.015));
    end,

    ["Codename Afternight Camera Shake"] = function(p170) -- Line: 703
        local v171 = p170[1];
        local v172 = tonumber(p170[2]) or 0.005;
        local v173 = tonumber(p170[3]) or 1;
        callEvent(v171 and "HUD Shake" or "Camera Shake", v173, v172);
    end,

    ["Codename Afternight Bars"] = function(p174) -- Line: 711
        local v175 = tonumber(p174[1]) or 0;
        local v176 = tonumber(p174[2]) or 1;
        local v177 = "Afternight Bars";

        if p174[4] then
            v177 = v177 .. " Underlay";
        end;

        if p174[3] then
            v177 = v177 .. " with Note Movement";
        end;

        callEvent(v177, v175, v176);
    end,

    ["Codename Afternight Fade"] = function(p178) -- Line: 724
        local v179 = tonumber(p178[1]) or 1;
        local v180 = tonumber(p178[2]) or 1;
        local v181 = "Afternight Fade";

        if p178[3] == true then
            v181 = v181 .. " Underlay";
        end;

        callEvent(v181, v180, v179);
    end,

    ["Codename Afternight Subtitles"] = function(p182) -- Line: 734
        local v183 = p182[1] or "";
        local v184 = `{parseColor(p182[2]) or "#FFFFFF"},{p182[3] or "Montserrat"}:{p182[4] or 400}`;
        callEvent("Afternight Subtitles", v183, v184);
    end,

    ["Codename Add Camera Zoom"] = function(p185) -- Line: 740
        -- upvalues: u2 (ref)
        local v186 = tonumber(p185[1]) or 0.015;
        local v187 = p185[2] or "camHUD";
        u2.setProperty(v187 .. ".zoom", u2.getProperty(v187 .. ".zoom") + v186);
    end,

    ["Codename Camera Bop"] = function(p188) -- Line: 746
        -- upvalues: u2 (ref)
        local v189 = (tonumber(p188[1]) or 4) * 4;
        local v190 = tonumber(p188[2]) or 1;
        u2.setProperty("camGame.cameraBeat", v189);
        u2.setProperty("camHUD.cameraBeat", v189);
        u2.setProperty("camGame.cameraBeatMultiplier", v190);
        u2.setProperty("camHUD.cameraBeatMultiplier", v190);
    end,

    ["Codename BPM Change"] = function(p191) -- Line: 756
        -- upvalues: u4 (copy)
        local v192 = tonumber(p191[1]) or 100;
        u4.Conductor.changeBPM((tonumber(v192)));
    end,

    ["Codename Change Stage Zoom"] = function(p193) -- Line: 760
        -- upvalues: u2 (ref)
        local v194 = tonumber(p193[5]) or 1;

        if p193[1] == true then
            u2.setProperty("camGame.defaultZoom", v194);
        end;

        if p193[2] == true then
            for _, v in u2.getCharacters("L") do
                v.zoom = v194;
            end;
        end;

        if p193[3] == true then
            for _, v in u2.getCharacters("R") do
                v.zoom = v194;
            end;
        end;
    end,

    ["Codename Scroll Speed Change"] = function(p195) -- Line: 775
        -- upvalues: u2 (ref), u4 (copy)
        if not u2.Settings.SVChanges then
            return;
        end;

        local v196 = tonumber(p195[2]) or 1;
        local v197 = parseStepsToSeconds(tonumber(p195[3]) or 0) / u2.playbackRate;
        local v198 = p195[6];
        local v199 = not p195[4] and "linear" or p195[4];

        if p195[5] then
            v199 = v199 .. p195[5];
        end;

        local TweenStyle = u2.getTweenStyle(v199);
        local TweenDir = u2.getTweenDir(v199);
        local v200 = u2.Settings.ForceScrollSpeed and u2.Settings.ScrollSpeed or u2.song.speed * u2.Settings.ScrollSpeed;

        if v198 then
            v196 = v200 * u2.balanceSpeedMult(v196, v200);
        end;

        if v197 > 0 then
            u4.varTweener:Create(u2, TweenInfo.new(v197, TweenStyle, TweenDir), {
                songSpeed = v196
            }):Play();

            return;
        end;

        u2.songSpeed = v196;
    end,

    ["Codename Time Signature Change"] = function(p201) -- Line: 809
        callEvent("Time Sig Change", `{p201[1]}/{p201[2]}`, "");
    end,

    ["Codename Camera Flash"] = function(p202) -- Line: 812
        local v203 = "Afternight Flash";

        if p202[4] ~= "camHUD" then
            v203 = v203 .. " Underlay";
        end;

        if p202[1] then
            v203 = v203 .. " Reverse";
        end;

        callEvent(v203, tostring(parseStepsToSeconds(p202[3])), parseColor(p202[2]));
    end,

    ["Codename Alt Animation Toggle"] = function(p204) -- Line: 822
        -- upvalues: u2 (ref)
        local v205 = p204[3] == 0 and "L" or "R";

        if p204[3] == 2 then
            if u2.GFCharacter ~= nil then
                u2.GFCharacter.animPrefix = p204[2] and "ALT" or "";
                u2.GFCharacter:Dance();
            end;

            return;
        end;

        for _, v in u2.getCharacters(v205) do
            v.animPrefix = p204[2] and "ALT" or "";
            v:Dance();
        end;
    end,

    ["Codename Play Animation"] = function(p206) -- Line: 839
        local v207 = p206[1];
        callEvent("Play Animation", p206[2], v207 == 0 and "dad" or (v207 == 1 and "bf" or "gf"));
    end,

    ["Codename Camera Zoom"] = function(p208) -- Line: 845
        -- upvalues: u2 (ref)
        local v209 = p208[3] == "camHUD" and "camHUD" or "camGame";
        local v210 = p208[2] * (p208[7] == "direct" and 1 or (tonumber(u2.getProperty("camGame.baseZoom")) or 1));

        if p208[8] then
            local v211 = u2.getProperty(v209 .. ".zoom") or 1;
            v210 = v210 * tonumber(v211);
        end;

        if p208[1] == false then
            u2.setProperty(v209 .. ".zoom", v210);
            u2.setProperty(v209 .. ".defaultZoom", v210);

            return;
        end;

        local v212 = parseStepsToSeconds(p208[4]) / u2.playbackRate;
        local v213 = `{p208[5]}{p208[6]}`;
        u2.tweenProperty(v209 .. ".defaultZoom", v210, v212, v213);
        u2.tweenProperty(v209 .. ".zoom", v210, v212, v213);
    end,

    ["Codename Camera Module Change"] = function(p214) -- Line: 862
        -- upvalues: u2 (ref)
        local string_upper_ret = string.upper(p214[3]);
        u2.setProperty("cams.cameraBeat", p214[1] * (string_upper_ret == "STEP" and 1 or (string_upper_ret == "BEAT" and 4 or 16)));
        u2.setProperty("cams.cameraBeatMultiplier", tonumber(p214[2]) or 1);
    end
};

for i, v in u215 do
    if typeof(v) == "string" then
        u215[i] = u215[v];
    end;
end;

function callEvent(p216, p217, p218, p219)
    -- upvalues: u215 (copy)
    local v220 = u215[p216];

    if v220 == nil then
        return;
    end;

    v220(p217, p218, p219, p216);
end;

return {
    onCreate = function(p221, p222) -- Line: 884, Name: onCreate
        -- upvalues: u2 (ref), u26 (ref), u18 (ref), u19 (ref), u13 (ref), u14 (ref), script_BlammedLights (copy)
        u2 = p222;
        u26 = p221;
        local _Subtitles = u2.Overlay._Subtitles;

        if _Subtitles then
            u18 = _Subtitles:Clone();
            u18.Name = "Subtitles";
            u18.Visible = true;
            u18.Parent = u2.Overlay;
        end;

        u19 = script.EventBars:Clone();
        setBarTarget(nil);

        for _, child in u19:GetChildren() do
            if child:IsA("GuiObject") then
                child.Visible = true;
            end;
        end;

        if u13 ~= nil then
            u13:Destroy();
        end;

        u13 = createFullScreenFrame("Fade");
        u13.Parent = u2.Overlay;

        if u14 ~= nil then
            u14:Destroy();
        end;

        u14 = createFullScreenFrame("Fade");
        u14.Parent = u2.Underlay;
        script_BlammedLights.onCreate(u2);
    end,

    eventCases = u215,
    callEvent = callEvent,

    clearUp = function() -- Line: 922, Name: clearUp
        -- upvalues: u2 (ref), u18 (ref), u17 (ref), script_BlammedLights (copy), u11 (copy), u5 (copy), u15 (ref), u13 (ref), u14 (ref), u20 (ref), u19 (ref), u3 (ref)
        if u2 == nil then
            return;
        end;

        if u18 then
            if u17 then
                u17:Revert();
            end;

            u18:Destroy();
        end;

        script_BlammedLights.clearUp();
        table.clear(u11);

        for _, v in u5 do
            if v then
                v:Destroy();
            end;
        end;

        table.clear(u5);

        if u15 ~= nil then
            u15:Cancel();
            u15 = nil;
        end;

        if u13 ~= nil then
            u13:Destroy();
        end;

        u13 = createFullScreenFrame("Fade");
        u13.Parent = u2.Overlay;

        if u14 ~= nil then
            u14:Destroy();
        end;

        u14 = createFullScreenFrame("Fade");
        u14.Parent = u2.Underlay;
        u20 = nil;

        if u19 ~= nil then
            u19:Destroy();
        end;

        if u3 and u3.Destroy then
            u3:Destroy();
            u3 = nil;
        end;

        u2 = nil;
    end,

    setSubtitleTarget = setSubtitleTarget,
    setBarTarget = setBarTarget,
    setBarTransparency = setBarTransparency,
    setFadeTarget = setFadeTarget,

    getCurrentFade = function() -- Line: 975, Name: getCurrentFade
        -- upvalues: u13 (ref)
        return u13;
    end
};