-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = {};
local u8 = false;
local TweenService = game:GetService("TweenService");
local u9 = {
    Color3.fromRGB(49, 162, 253),
    Color3.fromRGB(49, 253, 140),
    Color3.fromRGB(247, 148, 247),
    Color3.fromRGB(249, 109, 99),
    Color3.fromRGB(251, 166, 51)
};

return {
    onCreate = function(p10) -- Line: 21, Name: onCreate
        -- upvalues: u1 (ref), u2 (ref), u4 (ref), u6 (ref)
        u1 = p10;
        u2 = u1.getStage();
        u4 = u1.getCharacters();
        u6 = script.ColorEffect:Clone();
    end,

    doBlammedLights = function(p11, p12) -- Line: 29, Name: doBlammedLights
        -- upvalues: u8 (ref), u9 (copy), u6 (ref), u7 (copy), u3 (ref), TweenService (copy), u1 (ref), u2 (ref), u5 (ref), u4 (ref)
        if not p11 then
            u8 = false;

            if u6 then
                TweenService:Create(u6, TweenInfo.new(1 / u1.playbackRate), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end;

            if u3 then
                TweenService:Create(u3, TweenInfo.new(1 / u1.playbackRate), {
                    Transparency = 1
                }):Play();
            end;

            if u5 then
                TweenService:Create(u5, TweenInfo.new(1 / u1.playbackRate), {
                    FillTransparency = 1
                }):Play();
            end;

            for _, v in u7 do
                task.delay(1 / u1.playbackRate, function() -- Line: 102
                    -- upvalues: v (copy)
                    if v then
                        v:Destroy();
                    end;
                end);
            end;

            task.delay(1 / u1.playbackRate, function() -- Line: 107
                -- upvalues: u6 (ref), u3 (ref), u5 (ref), u4 (ref)
                if u6 then
                    u6.Parent = nil;
                end;

                if u3 then
                    u3:Destroy();
                end;

                if u5 then
                    u5:Destroy();
                end;

                for _, v in u4 do
                    for _, v2 in v do
                        for _, descendant in v2.char:GetDescendants() do
                            if descendant.ClassName == "Highlight" and descendant:GetAttribute("DontTouch") ~= true then
                                descendant.Enabled = true;
                            end;
                        end;
                    end;
                end;
            end);

            return;
        end;

        if u8 then
            local v13 = u9[p12];

            if v13 == nil then
                v13 = u9[math.random(1, #u9)];
            end;

            u6.TintColor = v13;

            return;
        end;

        u8 = true;

        for _, v in u7 do
            v:Destroy();
        end;

        if u3 then
            u3:Destroy();
        end;

        local v14 = u9[p12];

        if v14 == nil then
            v14 = u9[math.random(1, #u9)];
        end;

        TweenService:Create(u6, TweenInfo.new(1 / u1.playbackRate), {
            TintColor = v14
        }):Play();
        u6.Parent = game.Lighting;
        local Highlight = Instance.new("Highlight");
        Highlight.FillColor = Color3.new(0, 0, 0);
        Highlight.OutlineColor = Color3.new(0, 0, 0);
        Highlight.FillTransparency = 1;
        Highlight.OutlineTransparency = 0.999;
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        u3 = script.Skybox:Clone();
        u3.Parent = u2;
        u3.CFrame = u2:FindFirstChild("Background").CFrame;
        u3.BrickColor = BrickColor.new("Really black");
        TweenService:Create(u3, TweenInfo.new(1 / u1.playbackRate), {
            Transparency = 0
        }):Play();
        u5 = Highlight:Clone();
        u5.FillColor = Color3.new(0, 0, 0);
        u5.FillTransparency = 1;
        u5.OutlineTransparency = 0;
        u5.DepthMode = Enum.HighlightDepthMode.Occluded;
        u5.Parent = workspace;
        TweenService:Create(u5, TweenInfo.new(1 / u1.playbackRate), {
            FillTransparency = 0
        }):Play();
        table.insert(u7, Highlight);
        table.insert(u7, u5);

        for _, v in u4 do
            for _, v2 in v do
                for _, descendant in v2.char:GetDescendants() do
                    if descendant.ClassName == "Highlight" then
                        descendant.Enabled = false;
                    end;
                end;

                local v15 = Highlight:Clone();
                v15.Parent = v2.char;
                table.insert(u7, v15);
            end;
        end;
    end,

    clearUp = function() -- Line: 130, Name: clearUp
        -- upvalues: u7 (copy), u3 (ref), u5 (ref), u6 (ref)
        for _, v in u7 do
            v:Destroy();
        end;

        if u3 then
            u3:Destroy();
        end;

        if u5 then
            u5:Destroy();
        end;

        if u6 then
            u6:Destroy();
        end;
    end
};