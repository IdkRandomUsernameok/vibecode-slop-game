-- Decompiled with Potassium's decompiler.

local v1 = game:FindService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local CacheService = require(v1.Modules.Main.CacheService);
local u2 = { "rbxassetid://83716593641627", "rbxassetid://128284658907445", "rbxassetid://100985037247412", "rbxassetid://75384124935223", "rbxassetid://72021768221725", "rbxassetid://105166925389126", "rbxassetid://105166925389126", "rbxassetid://139446701525668", "rbxassetid://139446701525668", "rbxassetid://136051940183566", "rbxassetid://74040754776383", "rbxassetid://94448263838029", "rbxassetid://110182073078699", "rbxassetid://100869510896049", "rbxassetid://92240666771153", "rbxassetid://100049873948186", "rbxassetid://118644132325564", "rbxassetid://78022595139014", "rbxassetid://109439906310124", "rbxassetid://99472023522777", "rbxassetid://84840422702656", "rbxassetid://113717674088101" };
local u3 = nil;
local u4 = 1;
local u5 = tick();
local u6 = nil;

return {
    Create = function(p7: table, p8: userdata, p9: userdata) -- Line: 49, Name: Create
        -- upvalues: u2 (copy), CacheService (copy), u6 (ref), TweenService (copy), u3 (ref), u4 (ref)
        for _, v in u2 do
            CacheService.cacheImage(v);
        end;

        u6 = script.Frame:Clone();
        u6.Parent = p9;
        TweenService:Create(u6.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
            Transparency = 0.9
        }):Play();
        u3 = script.BG:Clone();
        u3.Image = u2[u4];
        u3.Parent = p8;
    end,

    Update = function(p10, p11) -- Line: 64, Name: Update
        -- upvalues: u5 (ref), u3 (ref), u4 (ref), u2 (copy)
        local v12 = tick();

        if math.abs(v12 - u5) >= 0.03333333333333333 and u3 ~= nil then
            u5 = v12;
            u4 = u4 + 1;

            if u4 > #u2 then
                u4 = 1;
            end;

            u3.Image = u2[u4];
        end;
    end,

    Destroy = function(p13) -- Line: 78, Name: Destroy
        -- upvalues: u3 (ref), u6 (ref)
        for _, v in { u3, u6 } do
            if v then
                v:Destroy();
            end;
        end;
    end
};