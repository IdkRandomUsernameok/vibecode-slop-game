-- Decompiled with Potassium's decompiler.

game:GetService("TextService");
game:GetService("ReplicatedStorage");
game:GetService("Players");
game["Run Service"]:IsServer();
local u1 = {
    hello = "ahoy",
    friend = "matey",
    idiot = "scaleywag",
    ["kill you"] = "make yee walk the plank",
    you = "yee"
};

function replaceWords(p2: string)
    -- upvalues: u1 (copy)
    for i, v in u1 do
        p2 = p2:gsub(i, v);
    end;

    return p2;
end;

function filterString(p3: string)
    return p3;
end;

return function(p4: string) -- Line: 50
    return filterString(replaceWords);
end;