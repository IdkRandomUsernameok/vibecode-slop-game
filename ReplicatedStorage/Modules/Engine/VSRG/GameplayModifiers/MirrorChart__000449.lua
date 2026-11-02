-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();
require(game:GetService("ReplicatedStorage").Modules.Main.VarTweener);
local _ = 600 / Api.songSpeed;
local _ = 0.4 / Api.songSpeed;

local function forEachNote(p1) -- Line: 7
    p1:changeNoteData(p1.strumLine.KeyCount - 1 - p1.noteData);
end;

return {
    onCreate = function() -- Line: 12, Name: onCreate
        -- upvalues: Api (copy)
        for _, v in Api.UnspawnNotes do
            if not v.noRandomize then
                v:changeNoteData(v.strumLine.KeyCount - 1 - v.noteData);
            end;
        end;
    end
};