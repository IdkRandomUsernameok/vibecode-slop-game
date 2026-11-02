-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = {};
CFrame.new(0, 5, 0);
CFrame.new(0, 10, 0);
local _, _ = pcall(function() -- Line: 8
    return game.Players.LocalPlayer:GetRankInGroup(17371285) >= 200;
end);
local _, result = pcall(function() -- Line: 12
    return game.Players.LocalPlayer:GetRankInGroup(17371285) >= 252;
end);
local _, _ = pcall(function() -- Line: 16
    local DateTime_now_ret = DateTime.now();
    local v3;

    if tonumber(DateTime_now_ret:FormatLocalTime("M", "en-us")) == 4 then
        local DateTime_now_ret2 = DateTime.now();
        v3 = tonumber(DateTime_now_ret2:FormatLocalTime("D", "en-us")) == 1;
    else
        v3 = false;
    end;

    return v3;
end);
local _, result2 = pcall(function() -- Line: 20
    -- upvalues: result (copy)
    return result;
end);

function getPosFromStage(p4: any, p5: any, p6: number?)
    if p4 == nil then
        return nil;
    end;

    local v7 = p6 == nil and 1 or p6;
    local v8 = p4:FindFirstChild(p5 == "L" and "Dad" .. v7 + 1 or "BF" .. v7 + 1);
    local v9;

    if v8 then
        v9 = v8.CFrame;
    else
        v9 = v8;
    end;

    local CFrame_new_ret = CFrame.new();

    if not v8 then
        local v10 = p4:FindFirstChild(p5 == "L" and "Dad" or "BF");

        if v10 then
            CFrame_new_ret = CFrame.new((p5 == "L" and 1 or -1) * 1.5 * v7, 0, v7 * 2.75);
            v9 = v10.CFrame * CFrame_new_ret;
        end;
    end;

    return v9, CFrame_new_ret;
end;

function onBeat(p11)
    -- upvalues: u1 (ref), result2 (copy)
    if u1.getSetting(u1.Side, "FunnyMode") == "Trampoline" and result2 then
        if p11 % 4 ~= 0 then
            return;
        end;

        local Characters = u1.getCharacters();

        if Characters == nil then
            return;
        end;

        local SideIndex = u1.getSideIndex();

        for _, v in { "L", "R" } do
            local v12 = v;

            for _, v2 in u1.getCharacters(v) do
                local u13 = v2;

                if u13 == nil or u13.locked then
                    u13 = Characters[v12][SideIndex];
                end;

                if u13 then
                    local v14 = u13.trampoline:GetExtentsSize().Y / 2;
                    local CFrame_new_ret = CFrame.new(0, v14, 0);
                    local CFrame_new_ret2 = CFrame.new(0, v14 + 5, 0);
                    task.spawn(function() -- Line: 67
                        -- upvalues: u13 (ref), CFrame_new_ret2 (ref), u1 (ref), CFrame_new_ret (copy)
                        u13:TweenPosition(u13.startPos * CFrame_new_ret2, TweenInfo.new(u1.Conductor.Crochet / 800, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), false).tweens[1].Completed:Wait();
                        CFrame_new_ret2 = CFrame_new_ret;
                        u13:TweenPosition(u13.startPos * CFrame_new_ret2, TweenInfo.new(u1.Conductor.Crochet / 500, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), false);
                    end);
                end;
            end;
        end;
    end;
end;

return {
    onCreate = function() -- Line: 80, Name: onCreate
        -- upvalues: u1 (ref), result2 (copy), u2 (copy)
        u1 = shared.getApi();

        if u1.getCharacters() == nil then
            return;
        end;

        for _, v in { "L", "R" } do
            if u1.getSetting(v, "FunnyMode") == "Trampoline" and result2 then
                local v15 = v;

                for _, v2 in u1.getCharacters(v) do
                    local SideIndex = u1.getSideIndex();

                    if v2 ~= nil and not v2.locked then
                        local v16, v17 = getPosFromStage(u1.getStage(), v15, SideIndex);
                        local v18 = game.ReplicatedStorage.Trampolin:Clone();
                        v18.Parent = workspace;
                        local v19 = v16.Position - v17.Position;
                        local v20 = workspace:Raycast(v19, v16.Position + Vector3.new(0, -30, 0));
                        print(v20.Distance * 0.2);
                        v18:MoveTo(v19 - Vector3.new(0, v20.Distance * 0.2, 0));
                        v2.trampoline = v18;
                        table.insert(u2, v18);
                    end;
                end;
            end;
        end;
    end,

    clearUp = function() -- Line: 111, Name: clearUp
        -- upvalues: u2 (copy)
        for _, v in u2 do
            v:Destroy();
        end;
    end,

    onBeatHit = onBeat
};