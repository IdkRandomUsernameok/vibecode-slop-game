-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local CaptureService = game:GetService("CaptureService");
local CaptureStuff = script.Parent.Parent.CaptureStuff;
local u1 = true;
script.Parent.MouseButton1Click:Connect(function() -- Line: 6
    -- upvalues: u1 (ref), CaptureService (copy), CaptureStuff (copy), TweenService (copy)
    if not u1 then
        return;
    end;

    CaptureService:CaptureScreenshot(function(p2) -- Line: 8
        -- upvalues: u1 (ref), CaptureStuff (ref), TweenService (ref), CaptureService (ref)
        u1 = false;
        CaptureStuff.ShutterSound:Play();
        CaptureStuff.CaptureOverlay.BackgroundTransparency = 0;
        local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
        task.wait();
        TweenService:Create(CaptureStuff.CaptureOverlay, TweenInfo_new_ret, {
            BackgroundTransparency = 1
        }):Play();
        task.wait(TweenInfo_new_ret.Time + 0.1);
        CaptureService:PromptSaveCapturesToGallery({ p2 }, function() -- Line: 18
            -- upvalues: u1 (ref)
            u1 = true;
        end);
    end);
end);