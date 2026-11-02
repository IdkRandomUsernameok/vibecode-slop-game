-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();
require(game:GetService("ReplicatedStorage").Modules.Main.VarTweener);
local _ = 600 / Api.songSpeed;
local _ = 0.4 / Api.songSpeed;
local u1 = {};
local u2 = {};
local u3 = nil;

function generateArrayFrom(p4)
    -- upvalues: u3 (ref)
    local v5 = {};

    for i = 0, p4 - 1 do
        v5[i + 1] = i;
        local _ = i;
    end;

    u3:Shuffle(v5);

    return v5;
end;

local u6 = {};

local function forEachNote(p7) -- Line: 29
    -- upvalues: u2 (copy), u1 (copy), u3 (ref)
    local v8 = u2[p7.strumLine] or nil;
    local v9 = p7.strumLine.Index .. "#" .. p7.strumTime;
    local v10 = u1[v9] or generateArrayFrom(p7.strumLine.KeyCount);
    local v11 = v10[1];

    for i = 1, 5 do
        if v8 ~= v11 or #v10 <= 1 then
            break;
        end;

        u3:Shuffle(v10);
        v11 = v10[1];
        local _ = i;
    end;

    p7:changeNoteData(v11);
    table.remove(v10, 1);

    for _, v in p7.sustains or {} do
        v:changeNoteData(v11);
    end;

    u1[v9] = v10;
    u2[p7.strumLine] = v11;
end;

return {
    onCreate = function() -- Line: 56, Name: onCreate
        -- upvalues: u3 (ref), Api (copy), u6 (copy), u1 (copy), forEachNote (copy)
        u3 = Random.new();

        for _, v in Api.UnspawnNotes do
            if v.noRandomize then
                local v12 = u6[v.strumLine.Index .. "#" .. v.strumTime] or {};
                v12[#v12 + 1] = v;
                u6[v.strumLine.Index .. "#" .. v.strumTime] = v12;
            end;
        end;

        for i, v in u6 do
            local v13 = generateArrayFrom(v[1].strumLine.KeyCount);

            for _, v2 in v do
                local table_find_ret = table.find(v13, v2.noteData);

                if table_find_ret then
                    table.remove(v13, table_find_ret);
                end;
            end;

            u1[i] = v13;
        end;

        for _, v in Api.UnspawnNotes do
            if not (v.sustainNote or v.noRandomize) then
                forEachNote(v);
            end;
        end;
    end
};