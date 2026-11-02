-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();

return {
    onNoteMiss = function() -- Line: 4, Name: onNoteMiss
        -- upvalues: Api (copy)
        Api.triggerEvent("Set Scroll Speed", Api.songSpeed + 0.1, Api.Conductor.crochet * 0.006);
    end
};