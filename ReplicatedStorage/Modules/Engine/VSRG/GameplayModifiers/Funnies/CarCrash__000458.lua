-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = {
    L = {},
    R = {}
};
local u3 = { 6, 7 };
local u4 = {
    Left = CFrame.new(0, 0, 40),
    Down = CFrame.new(0, -40, 0),
    Up = CFrame.new(0, 40, 0),
    Right = CFrame.new(0, 0, -40)
};

function getSetBelow(p5, p6, p7)
    -- upvalues: u1 (ref), u3 (copy)
    if p7 and p6 then
        local v8 = p7 or "";
        local v9 = p6[v8];

        if v8 == "Plus" and not v9 then
            v8 = "rDown2";
            v9 = p6[v8];
        end;

        if v8 == "Square" and not v9 then
            v8 = "rUp2";
            v9 = p6[v8];
        end;

        if u1.getSetting(p5.side, "FlipNoteskin") and table.find(u3, u1.getKeyData().highestKey) then
            if v8:match("Up") then
                v8 = v8:gsub("Up", "Down");
            elseif v8:match("Down") then
                v8 = v8:gsub("Down", "Up");
            end;

            v9 = p6[v8];
        end;

        local v10 = v9 or p6[string.gsub(v8, "%A", "")];

        if string.sub(v8, 1, 1) == "r" then
            local string_sub_ret = string.sub(v8, 2);
            v10 = v10 or p6[string_sub_ret] or p6[string.gsub(string_sub_ret, "%A", "")];
        end;

        return v10;
    end;
end;

function match()
end;

function isPlayerContrib(p11)
    return p11:GetRankInGroup(17371285) >= 200;
end;

function isPlayerDev(p12)
    return p12:GetRankInGroup(17371285) >= 252;
end;

function onNoteHit(u13)
    -- upvalues: u1 (ref), u4 (copy), u2 (copy)
    if u13.sustainNote == false then
        local v14 = u13.strum or u13.strumLine.Strums[u13.noteData];

        if not v14.animDir then
            local _ = u13.dir;
        end;

        local Characters = u1.getCharacters();

        if Characters == nil then
            return;
        end;

        local SideIndex = u1.getSideIndex();

        for _, v in u13.dType do
            local u15, u16;

            if type(v) == "table" then
                u15 = v;
                u16 = u15;
                local v17 = u15;
                u15 = u16;
                v17 = u16;
            else
                u15 = tonumber(v) or 0;
                u16 = Characters[u13.charSide][u15];

                if u16 == nil or u16.locked then
                    u16 = Characters[u13.charSide][SideIndex];
                end;
            end;

            if u16 then
                CFrame.new();
                local u18 = getSetBelow(u13, u4, v14.animDir);
                task.spawn(function() -- Line: 95
                    -- upvalues: u2 (ref), u13 (copy), u15 (ref), u16 (ref), u18 (ref), u1 (ref)
                    local v19 = u2[u13.charSide][u15];

                    if v19 then
                        v19:Cancel();
                    end;

                    local v20 = u16:TweenPosition(u16.startPos * u18, TweenInfo.new(0.5 / u1.playbackRate, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), false);
                    u2[u13.charSide][u15] = v20;
                    v20.tweens[1].Completed:Wait();

                    if v20.tweens[1].PlaybackState == Enum.PlaybackState.Cancelled or v20.tweens[2].PlaybackState == Enum.PlaybackState.Cancelled then
                        return;
                    end;

                    u1.triggerEvent("Camera Shake", 0.35 * u1.playbackRate, 0.05);
                    u1.playSound("rbxassetid://16406249221", 1.2, u1.playbackRate);
                    task.delay(0.15 / u1.playbackRate, function() -- Line: 108
                        -- upvalues: u16 (ref), u1 (ref)
                        u16:TweenPosition(u16.startPos, TweenInfo.new(1 / u1.playbackRate, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), false);
                    end);
                end);
            end;
        end;
    end;
end;

return {
    onCreate = function() -- Line: 117, Name: onCreate
        -- upvalues: u1 (ref)
        u1 = shared.getApi();
    end,

    onPlayerNoteHit = onNoteHit,
    onOpponentNoteHit = onNoteHit
};