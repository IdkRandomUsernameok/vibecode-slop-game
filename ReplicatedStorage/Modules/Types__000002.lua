-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.Modules.Lib.Signal);
require(game.ReplicatedStorage.Modules.Data.DataManager);
require(game.ReplicatedStorage.Modules.Audio.SongPlayer);
require(game.ReplicatedStorage.Modules.Main.Conductor);
require(game.ReplicatedStorage.Modules.Other.LRCParser);
require(game.ReplicatedStorage.Modules.Main.VarTweener);
require(game.ReplicatedStorage.Modules.Engine.VSRG.ManiaData);
require(game.ReplicatedStorage.Modules.ModData.Events);
local _ = {
    setAltPrefix = function(p1) -- Line: 714, Name: setAltPrefix
    end,

    iconSprites = nil,

    setNoteSpawnTime = function(p2) -- Line: 716, Name: setNoteSpawnTime
    end,

    flipAltAnims = function() -- Line: 717, Name: flipAltAnims
    end,

    floatToString = nil,
    judgements = nil,

    doMiss = function(p3: any, p4: any, p5: boolean?) -- Line: 720, Name: doMiss
    end,

    balanceSpeedMult = function(p6: any, p7: number) -- Line: 721, Name: balanceSpeedMult
    end,

    showPopup = function(p8, p9) -- Line: 722, Name: showPopup
    end,

    onNextFrame = function(p10) -- Line: 723, Name: onNextFrame
    end,

    getSetBelow = function(p11, p12) -- Line: 724, Name: getSetBelow
    end,

    getMotionTable = function() -- Line: 725, Name: getMotionTable
    end,

    cacheImage = function(p13) -- Line: 726, Name: cacheImage
    end,

    updateStatsLabel = function() -- Line: 727, Name: updateStatsLabel
    end,

    getTrackedSounds = function() -- Line: 728, Name: getTrackedSounds
    end,

    overrideIconBop = function(p14) -- Line: 729, Name: overrideIconBop
    end,

    getCurrentHoldsplashData = function() -- Line: 730, Name: getCurrentHoldsplashData
    end,

    linkTextScaling = nil,
    cacheSound = nil,

    getSpots = function() -- Line: 733, Name: getSpots
    end,

    forceHealthDrain = function(p15) -- Line: 734, Name: forceHealthDrain
    end,

    getStage = function() -- Line: 735, Name: getStage
    end,

    getYPosAt = nil,

    addSectionsFromChart = function(p16) -- Line: 737, Name: addSectionsFromChart
    end,

    getRawPlrOffset = nil,

    switchHUD = function(p17: any, p18: table?) -- Line: 739, Name: switchHUD
    end,

    getProperty = function(p19) -- Line: 740, Name: getProperty
    end,

    getCurrentHUD = function() -- Line: 741, Name: getCurrentHUD
    end,

    songData = nil,

    reapplyStrumlines = function() -- Line: 743, Name: reapplyStrumlines
    end,

    getIcons = function() -- Line: 744, Name: getIcons
    end,

    doMiddlescroll = function(p20) -- Line: 745, Name: doMiddlescroll
    end,

    addToTrackedSounds = function(p21: userdata) -- Line: 746, Name: addToTrackedSounds
    end,

    showError = function(p22, p23, p24, p25) -- Line: 747, Name: showError
    end,

    getStepFromTime = nil,

    lerpCFrame = function(p26: number, p27, p28, p29) -- Line: 749, Name: lerpCFrame
    end,

    showTrace = function(p30, p31, p32, p33) -- Line: 750, Name: showTrace
    end,

    startSong = function() -- Line: 751, Name: startSong
    end,

    Conductor = nil,
    HUD = nil,

    getCamSubjectPos = function() -- Line: 754, Name: getCamSubjectPos
    end,

    lastBPMChange = nil,
    getCachedObjProp = nil,

    recalculateStrums = function(p34: boolean?) -- Line: 757, Name: recalculateStrums
    end,

    loadNoteset = function(p35, p36, p37) -- Line: 758, Name: loadNoteset
    end,

    getDefaultX = nil,
    getRawXPoint = nil,
    mapModule = nil,

    loadIcon = function(p38: any, p39: any, p40: string?, p41: string?, p42: number?, p43: boolean?) -- Line: 762, Name: loadIcon
    end,

    getTweenStyle = nil,

    addMotionTable = function(p44) -- Line: 764, Name: addMotionTable
    end,

    createNote = function(p45, p46) -- Line: 765, Name: createNote
    end,

    SecondsToMMSS = nil,

    addNotesFromChart = function(p47: userdata, p48: boolean?) -- Line: 767, Name: addNotesFromChart
    end,

    elapsed = nil,

    cacheNoteType = function(p49) -- Line: 769, Name: cacheNoteType
    end,

    cacheNoteskin = function(p50, p51) -- Line: 770, Name: cacheNoteskin
    end,

    Signals = nil,
    HUDApi = nil,
    getTweenDir = nil,
    getRandomFriend = nil,
    getBotAppearance = nil,

    createStrumline = function(...) -- Line: 776, Name: createStrumline
    end,

    getBeatFromTime = nil,

    loadNoteskin = function(p52: any, p53: any, p54: table, p55: string?, p56: table?, p57: table?) -- Line: 778, Name: loadNoteskin
    end,

    getTimeFromStep = nil,
    getBPMFromTime = nil,
    playSound = nil,
    newAfterImage = nil,

    getCurrentNotesplashData = function() -- Line: 783, Name: getCurrentNotesplashData
    end,

    forceJudgementId = function(p58, p59) -- Line: 784, Name: forceJudgementId
    end,

    createAfterImage = nil,

    visualCountdown = function() -- Line: 786, Name: visualCountdown
    end,

    getRawStartPoint = nil,
    getStrumGroupCenter = nil,

    getStagePos = function(p60, p61) -- Line: 789, Name: getStagePos
    end,

    tweenProperty = function(p62, p63, p64, p65, p66) -- Line: 790, Name: tweenProperty
    end,

    getClosestNote = function(p67, p68) -- Line: 791, Name: getClosestNote
    end,

    setStrumGroupToPoint = nil,

    die = function(p69: boolean?) -- Line: 793, Name: die
    end,

    getTimeFromBeat = nil,

    removeMotionTable = function(p70) -- Line: 795, Name: removeMotionTable
    end,

    getNoteSet = function() -- Line: 796, Name: getNoteSet
    end,

    getPixelVariant = function(p71) -- Line: 797, Name: getPixelVariant
    end,

    applyQuantsToNote = function(p72) -- Line: 798, Name: applyQuantsToNote
    end,

    parseChart = function(p73: userdata, p74: table?, p75: any, p76: table) -- Line: 799, Name: parseChart
    end,

    cacheNoteSet = function(p77: string, p78: userdata, p79: string?) -- Line: 800, Name: cacheNoteSet
    end,

    setObjPropWithIndex = nil,

    spawnBot = function(p80: any, p81: any, p82: number?, p83: boolean?, p84: number?, p85: any, p86, p87: userdata?) -- Line: 802, Name: spawnBot
    end,

    customizationModules = nil,

    allowHealthDrain = function(p88) -- Line: 804, Name: allowHealthDrain
    end,

    getRandomColor = function() -- Line: 805, Name: getRandomColor
    end,

    setProperty = function(p89, p90) -- Line: 806, Name: setProperty
    end,

    calculateSectionLength = nil
};

return 0;