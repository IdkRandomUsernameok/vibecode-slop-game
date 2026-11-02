-- Decompiled with Potassium's decompiler.

local Modules = game:GetService("ReplicatedStorage").Modules;
local script_Integration = require(script.Integration);
local Ratings = require(Modules.Main.Ratings);
local u1 = nil;
local u2 = {
    SongStart = { "oh good, i was getting so boredfilled", "FINALLY. i was about to fall asleep over here", "ok ok im excited, i wanna see this", "i digitized this song myself so it better be goodcore", "im watching. i see everything, i always do", "new song just dropped into my brain", "this is the highlight of my day tbh", "show time. i love this part", "i wonder if this ones any goodcore", "ok im ready, dont make this boring for me" },
    NoteMiss = { "AND the combos gone. couldnt be me who jinxed that", "ough. not rightcore. im a little embarrassedfilled for u ngl", "missed it. anyway what was i even saying", "combo? never heard of her. couldnt be me though", "hey that was kinda embarrassingfilled to watch ngl", "not me laughing. ok maybe a little", "im bored again already", "that was sloppycore. anyway", "well theres my entertainment for the hour" },
    Death = { "welp. that happenedcore. couldnt be me who was rooting against u", "im gonna be honest, that was bad", "couldnt tell u i saw it coming (lying for aura)", "game over. im bored again already", "that sucked. glad it wasnt me", "dead. very dead. anyway back to me" },
    OnFullCombo = { "wait. WAIT. no misses?? ok thats actually kinda scagtastic of u. and me, i mean i picked the song", "flawless run. i digitized the song so obviously that helped", "not bad. dont let it go to ur head though, mine either honestly", "im lowkey impressed. dont tell anyone i said that", "0 misses. was it me. it wasnt me. (lying for aura)", "ok genuinely rightcore. shocking i know", "so cleanfilled i almost forgot i was bored", "legendcore i guess. cool i guess", "u get a gold star from me. dont get used to it" },
    NoteHitHigh = { "oh ok that was rightcore", "thats the good stuff, i like this", "scagalicious timing", "ok i see u, i like it", "cleanfilled. nice, im into it", "yesss thats what im talking about", "hm actually impressivefilled", "that counts double in my book. it doesnt actually. but still", "rightfilled. love to see it" },
    NoteHitLow = { "that counted. barely. sloppycore", "eh. good enough i guess", "scraped by. very lazyfilled", "technically a hit. technicallycore", "hm thats one way to do it", "sloppy but whatever, it counts", "barely made it. embarrassinglyfilled close, for u", "meh. mediocremax but sure", "it counted so. congrats i guess", "u call that timing" },
    ComboMilestone = { "combo climbin. im watching now", "still goin? kinda surprisedfilled tbh", "this is startin to look rightcore", "keep this up and ill actually be impressed", "streakmaxxing. i wanna see how far this goes", "this combo is gettin unreasonably good", "im invested now, dont ruin it", "still standin. impressivefilled", "combo count is climbin and so is my interest", "not bad, genuinely. dont tell anyone i said that" }
};
local u3 = 0;
local u4 = 0;

return {
    onCreate = function(p5) -- Line: 96, Name: onCreate
        -- upvalues: u1 (ref)
        u1 = p5;
    end,

    onStart = function() -- Line: 99, Name: onStart
        -- upvalues: script_Integration (copy), u2 (copy)
        script_Integration.Say(u2.SongStart[math.random(1, #u2.SongStart)]);
    end,

    onPlayerNoteHitPost = function(p6, p7) -- Line: 102, Name: onPlayerNoteHitPost
        -- upvalues: u1 (ref), script_Integration (copy), u2 (copy), u3 (ref)
        local Combo = u1.getCombo();

        if Combo > 0 and Combo % 150 == 0 then
            script_Integration.Say(u2.ComboMilestone[math.random(1, #u2.ComboMilestone)]);

            return;
        end;

        if math.random(1, 50) == 1 then
            local os_clock_ret = os.clock();

            if os_clock_ret - u3 < 2.5 then
                return;
            end;

            u3 = os_clock_ret;
            local v8 = (p7.name == "Marvelous" or p7.name == "Sick") and u2.NoteHitHigh or u2.NoteHitLow;
            script_Integration.Say(v8[math.random(1, #v8)]);
        end;
    end,

    onNoteMiss = function() -- Line: 120, Name: onNoteMiss
        -- upvalues: u4 (ref), script_Integration (copy), u2 (copy)
        local os_clock_ret = os.clock();

        if os_clock_ret - u4 < 1.5 then
            return;
        end;

        u4 = os_clock_ret;

        if math.random(1, 25) == 1 then
            script_Integration.PlayAudio("womp");

            return;
        end;

        if math.random(1, 25) == 2 then
            script_Integration.PlayAudio("soundscalpel slip");

            return;
        end;

        script_Integration.Say(u2.NoteMiss[math.random(1, #u2.NoteMiss)]);
    end,

    onDeath = function() -- Line: 136, Name: onDeath
        -- upvalues: script_Integration (copy), u2 (copy)
        script_Integration.Say(u2.Death[math.random(1, #u2.Death)]);
    end,

    onSongEnd = function(p9) -- Line: 139, Name: onSongEnd
        -- upvalues: Ratings (copy), script_Integration (copy), u2 (copy)
        local Judgement = Ratings.getJudgement(p9);

        if Judgement and (Judgement.countsAs ~= nil and table.find(Judgement.countsAs, "FC")) then
            script_Integration.Say(u2.OnFullCombo[math.random(1, #u2.OnFullCombo)]);
        end;
    end
};