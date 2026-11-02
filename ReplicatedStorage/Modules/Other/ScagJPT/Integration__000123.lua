-- Decompiled with Potassium's decompiler.

return {
    Say = function(p1: string) -- Line: 3, Name: Say
        print("[SJPT]:say," .. p1:gsub(",", ",,"));
    end,

    Fling = function(p2: number, p3: number) -- Line: 7, Name: Fling
        print("[SJPT]:fling," .. p2 .. "," .. p3);
    end,

    SetImage = function(p4: string) -- Line: 11, Name: SetImage
        print("[SJPT]:set_image," .. p4);
    end,

    PlayAudio = function(p5: string) -- Line: 15, Name: PlayAudio
        print("[SJPT]:play_audio," .. p5);
    end
};