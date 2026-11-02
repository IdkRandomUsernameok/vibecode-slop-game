-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local u3 = nil;
local Modules = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local VarTweener = require(Modules.Main.VarTweener);

function initStrums()
    -- upvalues: u2 (ref), u1 (ref), u3 (ref)
    u2 = u1.Strums;

    for i, _ in u2 do
        local DefaultX = u3.getDefaultX(i);
        local DefaultY = u3.getDefaultY(i);
        u3.setActorX(DefaultX, i);
        u3.setActorY(DefaultY, i);
    end;
end;

u3 = {
    getHudX = function() -- Line: 43, Name: getHudX
        -- upvalues: u1 (ref)
        return u1.getProperty("camHUD.x");
    end,

    getHudY = function() -- Line: 46, Name: getHudY
        -- upvalues: u1 (ref)
        return u1.getProperty("camHUD.y");
    end,

    getCamX = function() -- Line: 49, Name: getCamX
        -- upvalues: u1 (ref)
        return u1.getProperty("camGame.x");
    end,

    getCamY = function() -- Line: 52, Name: getCamY
        -- upvalues: u1 (ref)
        return u1.getProperty("camGame.y");
    end,

    setCPosition = function(p4, p5) -- Line: 57, Name: setCPosition
        -- upvalues: u1 (ref)
        u1.setProperty("camHUD.x", p4);
        u1.setProperty("camHUD.y", p5);
        u1.setProperty("camGame.x", p4);
        u1.setProperty("camGame.y", p5);
    end,

    setHudPosition = function(p6, p7) -- Line: 64, Name: setHudPosition
        -- upvalues: u1 (ref)
        u1.setProperty("camHUD.x", p6);
        u1.setProperty("camHUD.y", p7);
    end,

    setCamPosition = function(p8, p9) -- Line: 68, Name: setCamPosition
        -- upvalues: u1 (ref)
        u1.setProperty("camGame.x", p8);
        u1.setProperty("camGame.y", p9);
    end,

    setCAngle = function(p10) -- Line: 73, Name: setCAngle
        -- upvalues: u1 (ref)
        u1.setProperty("camGame.angle", p10);
        u1.setProperty("camHUD.angle", p10);
    end,

    setCamAngle = function(p11) -- Line: 77, Name: setCamAngle
        -- upvalues: u1 (ref)
        u1.setProperty("camGame.angle", p11);
    end,

    setHudAngle = function(p12) -- Line: 80, Name: setHudAngle
        -- upvalues: u1 (ref)
        u1.setProperty("camHUD.angle", p12);
    end,

    setCZoom = function(p13) -- Line: 84, Name: setCZoom
        -- upvalues: u1 (ref)
        u1.setProperty("camHUD.zoom", p13);
        u1.setProperty("camGame.zoom", p13);
    end,

    setHudZoom = function(p14) -- Line: 88, Name: setHudZoom
        -- upvalues: u1 (ref)
        u1.setProperty("camHUD.zoom", p14);
    end,

    setCamZoom = function(p15) -- Line: 91, Name: setCamZoom
        -- upvalues: u1 (ref)
        u1.setProperty("camGame.zoom", p15);
    end,

    tweenCZoom = function(p16: any, p17: any, p18: string?) -- Line: 97, Name: tweenCZoom
        -- upvalues: u1 (ref)
        u1.tweenProperty("camHUD.zoom", p16, p17 / u1.playbackRate, (p18 == "" or not p18) and "linearInOut" or p18);
        u1.tweenProperty("camGame.zoom", p16, p17 / u1.playbackRate, (p18 == "" or not p18) and "linearInOut" or p18);
    end,

    tweenHudZoom = function(p19: any, p20: any, p21: string?) -- Line: 101, Name: tweenHudZoom
        -- upvalues: u1 (ref)
        u1.tweenProperty("camHUD.zoom", p19, p20 / u1.playbackRate, (p21 == "" or not p21) and "linearInOut" or p21);
    end,

    tweenCamZoom = function(p22: any, p23: any, p24: string?) -- Line: 104, Name: tweenCamZoom
        -- upvalues: u1 (ref)
        u1.tweenProperty("camGame.zoom", p22, p23 / u1.playbackRate, (p24 == "" or not p24) and "linearInOut" or p24);
    end,

    getActorX = function(p25) -- Line: 109, Name: getActorX
        -- upvalues: u2 (ref)
        return u2[p25] and u2[p25].x or 0;
    end,

    getActorY = function(p26) -- Line: 112, Name: getActorY
        -- upvalues: u2 (ref)
        return u2[p26] and u2[p26].y or 0;
    end,

    getActorScaleX = function(p27) -- Line: 115, Name: getActorScaleX
        -- upvalues: u2 (ref)
        return u2[p27] and u2[p27].Scale.X or 1;
    end,

    getActorScaleY = function(p28) -- Line: 118, Name: getActorScaleY
        -- upvalues: u2 (ref)
        return u2[p28] and u2[p28].Scale.Y or 1;
    end,

    getActorAngle = function(p29) -- Line: 121, Name: getActorAngle
        -- upvalues: u2 (ref)
        return u2[p29] and u2[p29].angle or 0;
    end,

    getActorAlpha = function(p30) -- Line: 124, Name: getActorAlpha
        -- upvalues: u2 (ref)
        return u2[p30] and u2[p30].alpha or 1;
    end,

    getActorWidth = function(p31) -- Line: 127, Name: getActorWidth
        -- upvalues: u2 (ref)
        return u2[p31] and u2[p31].size.x or 0;
    end,

    getActorHeight = function(p32) -- Line: 130, Name: getActorHeight
        -- upvalues: u2 (ref)
        return u2[p32] and u2[p32].size.y or 0;
    end,

    setActorX = function(p33, p34) -- Line: 135, Name: setActorX
        -- upvalues: u2 (ref)
        u2[p34].x = p33;
    end,

    setActorY = function(p35, p36) -- Line: 138, Name: setActorY
        -- upvalues: u2 (ref)
        u2[p36].y = p35;
    end,

    setActorScale = function(p37, p38) -- Line: 141, Name: setActorScale
        -- upvalues: u2 (ref)
        u2[p38].Scale = Vector2.new(p37, p37);
    end,

    setActorScaleX = function(p39, p40) -- Line: 144, Name: setActorScaleX
        -- upvalues: u2 (ref)
        u2[p40].Scale = Vector2.new(p39, u2[p40].Scale.Y);
    end,

    setActorScaleY = function(p41, p42) -- Line: 147, Name: setActorScaleY
        -- upvalues: u2 (ref)
        u2[p42].Scale = Vector2.new(u2[p42].Scale.X, p41);
    end,

    setActorAngle = function(p43, p44) -- Line: 150, Name: setActorAngle
        -- upvalues: u2 (ref)
        u2[p44].angle = p43;
    end,

    setActorAlpha = function(p45, p46) -- Line: 153, Name: setActorAlpha
        -- upvalues: u2 (ref)
        u2[p46].alpha = p45;
    end,

    getDefaultX = function(p47) -- Line: 158, Name: getDefaultX
        return _G["defaultStrum" .. tostring(p47) .. "X"];
    end,

    getDefaultY = function(p48) -- Line: 161, Name: getDefaultY
        return _G["defaultStrum" .. tostring(p48) .. "Y"];
    end,

    getDefaultAngle = function(p49) -- Line: 164, Name: getDefaultAngle
        return _G["defaultStrum" .. tostring(p49) .. "Angle"];
    end,

    setDefaultX = function(p50) -- Line: 169, Name: setDefaultX
        -- upvalues: u3 (ref)
        _G["defaultStrum" .. tostring(p50) .. "X"] = u3.getActorX(p50);
    end,

    setDefaultY = function(p51) -- Line: 172, Name: setDefaultY
        -- upvalues: u3 (ref)
        _G["defaultStrum" .. tostring(p51) .. "Y"] = u3.getActorY(p51);
    end,

    setDefaultAngle = function(p52) -- Line: 175, Name: setDefaultAngle
        -- upvalues: u3 (ref)
        _G["defaultStrum" .. tostring(p52) .. "Angle"] = u3.getActorAngle(p52);
    end,

    tweenPos = function(p53: any, p54: any, p55: any, p56: any, p57: string?) -- Line: 180, Name: tweenPos
        -- upvalues: u1 (ref), VarTweener (copy), u2 (ref)
        local TweenStyle = u1.getTweenStyle(p57);
        local TweenDir = u1.getTweenDir(p57);
        VarTweener:Create(u2[p53], TweenInfo.new(p56 / u1.playbackRate, TweenStyle, TweenDir), {
            x = p54,
            y = p55
        }):Play();
    end,

    tweenPosXAngle = function(p58: any, p59: any, p60: any, p61: any, p62: string?) -- Line: 184, Name: tweenPosXAngle
        -- upvalues: u1 (ref), VarTweener (copy), u2 (ref)
        local TweenStyle = u1.getTweenStyle(p62);
        local TweenDir = u1.getTweenDir(p62);
        VarTweener:Create(u2[p58], TweenInfo.new(p61 / u1.playbackRate, TweenStyle, TweenDir), {
            x = p59,
            angle = p60
        }):Play();
    end,

    tweenPosYAngle = function(p63: any, p64: any, p65: any, p66: any, p67: string?) -- Line: 188, Name: tweenPosYAngle
        -- upvalues: u1 (ref), VarTweener (copy), u2 (ref)
        local TweenStyle = u1.getTweenStyle(p67);
        local TweenDir = u1.getTweenDir(p67);
        VarTweener:Create(u2[p63], TweenInfo.new(p66 / u1.playbackRate, TweenStyle, TweenDir), {
            y = p64,
            angle = p65
        }):Play();
    end,

    tweenAngle = function(p68: any, p69: any, p70: any, p71: string?) -- Line: 192, Name: tweenAngle
        -- upvalues: u1 (ref), VarTweener (copy), u2 (ref)
        local TweenStyle = u1.getTweenStyle(p71);
        local TweenDir = u1.getTweenDir(p71);
        VarTweener:Create(u2[p68], TweenInfo.new(p70 / u1.playbackRate, TweenStyle, TweenDir), {
            angle = p69
        }):Play();
    end,

    tweenAlpha = function(p72: any, p73: any, p74: any, p75: string?) -- Line: 196, Name: tweenAlpha
        -- upvalues: u1 (ref), VarTweener (copy), u2 (ref)
        local TweenStyle = u1.getTweenStyle(p75);
        local TweenDir = u1.getTweenDir(p75);
        VarTweener:Create(u2[p72], TweenInfo.new(p74 / u1.playbackRate, TweenStyle, TweenDir), {
            alpha = p73
        }):Play();
    end,

    tweenFadeOut = function(p76: any, p77: any, p78: any, p79: string?) -- Line: 200, Name: tweenFadeOut
        -- upvalues: u1 (ref), VarTweener (copy), u2 (ref)
        local TweenStyle = u1.getTweenStyle(p79);
        local TweenDir = u1.getTweenDir(p79);
        VarTweener:Create(u2[p76], TweenInfo.new(p78 / u1.playbackRate, TweenStyle, TweenDir), {
            alpha = p77
        }):Play();
    end,

    tweenFadeIn = function(p80: any, p81: any, p82: any, p83: string?) -- Line: 204, Name: tweenFadeIn
        -- upvalues: u1 (ref), VarTweener (copy), u2 (ref)
        local TweenStyle = u1.getTweenStyle(p83);
        local TweenDir = u1.getTweenDir(p83);
        VarTweener:Create(u2[p80], TweenInfo.new(p82 / u1.playbackRate, TweenStyle, TweenDir), {
            alpha = p81
        }):Play();
    end,

    tweenProperty = function(p84: any, p85: any, p86: any, p87: any, p88: string?) -- Line: 208, Name: tweenProperty
        -- upvalues: u1 (ref), VarTweener (copy), u2 (ref)
        local TweenStyle = u1.getTweenStyle(p88);
        local TweenDir = u1.getTweenDir(p88);
        VarTweener:Create(u2[p84], TweenInfo.new(p87 / u1.playbackRate, TweenStyle, TweenDir), {
            [p85] = p86
        }):Play();
    end,

    init = function(p89: any, p90: boolean?) -- Line: 214, Name: init
        -- upvalues: u1 (ref)
        u1 = p89 or shared.getApi();
        initStrums();
    end
};

return u3;