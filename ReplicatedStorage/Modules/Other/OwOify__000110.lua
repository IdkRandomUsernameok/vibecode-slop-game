-- Decompiled with Potassium's decompiler.

game:GetService("TextService");
game:GetService("ReplicatedStorage");
game:GetService("Players");
game["Run Service"]:IsServer();
local u1 = {
    love = "wuv",
    mr = "mistuh",
    mister = "mistuh",
    dog = "doggo",
    cat = "kitteh",
    kat = "kitteh",
    hello = "henwo",
    hi = "haii",
    hey = "haiii",
    friend = "fwend",
    stop = "stawp",
    god = "gosh"
};

function replaceWords(p2: string)
    -- upvalues: u1 (copy)
    for i, v in u1 do
        p2 = p2:gsub(i, v);
    end;

    return p2;
end;

function owoifyRL(p3: string)
    return p3:gsub("[rlt]", "w"):gsub("[RLT]", "W");
end;

function nyaAfterN(p4: string)
    return p4:gsub("N([aeiouAEIOU])", "Ny%1"):gsub("n([aeiouAEIOU])", "ny%1");
end;

function filterString(p5: string)
    return p5;
end;

return function(p6: string) -- Line: 58
    return filterString(replaceWords(owoifyRL(nyaAfterN(p6))));
end;