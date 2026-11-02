-- Decompiled with Potassium's decompiler.

local u1 = nil;
require(game:GetService("ReplicatedStorage").Modules.Main.VarTweener);
local Random_new_ret = Random.new();
local u2 = {
    L = {},
    R = {}
};

function updateNotes()
    -- upvalues: u2 (copy)
    for _, v in shared.getNotes() do
        if not v.sustainNote then
            v.offsets.set("Scale", "_randomNoteScaleModifier", u2[v.side][v.column]);
        end;
    end;
end;

return {
    onCreate = function() -- Line: 19, Name: onCreate
        -- upvalues: u1 (ref), u2 (copy)
        u1 = shared.getApi();
        local KeyData = u1.getKeyData();

        for i = 1, KeyData.leftKeyCount do
            u2.L[i] = 1;
            local _ = i;
        end;

        for i = 1, KeyData.rightKeyCount do
            u2.R[i] = 1;
            local _ = i;
        end;
    end,

    onSpawnNote = function(p3) -- Line: 31, Name: onSpawnNote
        -- upvalues: u2 (copy)
        if not p3.sustainNote then
            p3.offsets.set("Scale", "_randomNoteScaleModifier", u2[p3.side][p3.column]);
        end;
    end,

    onPlayerNoteHit = function(p4) -- Line: 36, Name: onPlayerNoteHit
        -- upvalues: Random_new_ret (copy), u2 (copy)
        local v5 = p4.strum or p4.strumLine.Strums[p4.noteData];
        local v6 = Random_new_ret:NextNumber() + 0.5;
        v5.offsets.set("Scale", "_randomNoteScaleModifier", v6);
        u2[p4.side][p4.column] = v6;
        updateNotes();
    end
};