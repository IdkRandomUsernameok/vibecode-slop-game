-- Decompiled with Potassium's decompiler.

local u1 = {};
game:GetService("RunService");

local function fixSpectrum(p2: table, p3: number) -- Line: 5
    local v4 = #p2 // 1.4;

    if v4 == 0 then
        return table.create(p3, 0);
    end;

    local table_create_ret = table.create(p3);

    for i = 0, p3 - 1 do
        local v5 = 0;
        local v6 = 0;

        for i2 = v4 ^ (i / p3) // 1, (v4 ^ ((i + 1) / p3) + 0.5) // 1 do
            v5 = v5 + p2[i2];
            v6 = v6 + 1;
            local _ = i2;
        end;

        table_create_ret[i + 1] = v5 / v6;
    end;

    return table_create_ret;
end;

function u1.new(p7, p8) -- Line: 28
    -- upvalues: u1 (copy), fixSpectrum (copy)
    local v9 = setmetatable({}, {
        __index = u1
    });
    v9.AudioStuff = script.AudioStuff_Temp:Clone();
    v9.AudioStuff.Parent = script;
    v9.Analyzer = v9.AudioStuff.AudioAnalyzer;
    v9.Player = v9.AudioStuff.AudioPlayer;
    v9.visualizerData = {};

    if p7 then
        local v10 = #p7:GetChildren() - 1;
        v9.list = p7;

        for i = 1, v10 do
            local v11 = p7:FindFirstChild("List_" .. i);
            local v12;

            if v11 then
                v12 = i;
                local v13 = nil;
                local v14 = {};

                for _, child in v11:GetChildren() do
                    if child.ClassName == "Frame" and child.LayoutOrder == 0 then
                        v13 = child;
                    end;
                end;

                if v13 ~= nil then
                    v14[1] = v13;
                end;

                v9.visualizerData[v12] = {
                    WeirdAmount = 1,
                    Bar = v11,
                    SubBars = v14,
                    SubLength = #v14,
                    VisData = { 0, 0 }
                };
            else
                v12 = i;
            end;
        end;

        v9.ItemSize = p8;

        function v9.SetPlaybackSpeed(p15, p16) -- Line: 73
            p15.Player.PlaybackSpeed = p16;
        end;

        function v9.SetSound(p17: any, p18: userdata) -- Line: 77
            if not p18 then
                return;
            end;

            if typeof(p18) ~= "Instance" or not p18:IsA("Sound") then
                return;
            end;

            p17.SoundId = p18.SoundId;
            p17.Sound = p18;
            p17.Player:Stop();
            p17.Player.AssetId = p17.SoundId;

            repeat
                task.wait();
            until p17.Player.IsReady;

            if p18.Playing then
                p17.Player:Play();
            end;

            p17.Player.TimePosition = p18.TimePosition;
            p17.AudioStuff.Name = "AudioStuff_" .. p17.SoundId;
        end;

        function v9.Update(p19, p20) -- Line: 95
            -- upvalues: fixSpectrum (ref)
            if p19.Sound == nil or not p19.Sound.Playing then
                return;
            end;

            local v21 = #p19.list:GetChildren() - 1;
            local v22 = fixSpectrum(p19.Analyzer:GetSpectrum(), v21);

            for i = 1, v21 do
                local v23 = p19.list:FindFirstChild("List_" .. i);
                local v24;

                if v23 == nil then
                    v24 = i;
                else
                    if p19.visualizerData[i].VisData == nil then
                        p19.visualizerData[i].VisData = { 0, 0 };
                    end;

                    p19.visualizerData[i].VisData[1] = math.min(4, (v22[i] or 0) * 75);
                    local VisData = p19.visualizerData[i].VisData;
                    local math_lerp_ret = math.lerp(p19.visualizerData[i].VisData[2], p19.visualizerData[i].VisData[1], p20 * 25);
                    VisData[2] = math.min(4, math_lerp_ret);
                    local ItemSize = p19.ItemSize;
                    local _ = 1 / v21;
                    v23.Size = UDim2.fromScale(ItemSize.X.Scale, ItemSize.Y.Scale * (p19.visualizerData[i].VisData[2] / 4));
                    v24 = i;
                end;
            end;
        end;

        function v9.ResetBarSizes(p25) -- Line: 123
            for i = 1, #p25.list:GetChildren() - 1 do
                local v26 = p25.list:FindFirstChild("List_" .. i);
                local v27;

                if v26 == nil then
                    v27 = i;
                else
                    v26.Size = UDim2.fromScale(p25.ItemSize.X.Scale, 0);
                    v27 = i;
                end;
            end;
        end;

        return v9;
    end;
end;

return u1;