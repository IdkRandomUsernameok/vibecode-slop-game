-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p3.EngineData.IsIndev() then
        p1.ActivateAfternight:Destroy();

        return;
    end;

    p1.ActivateAfternight.Visible = true;

    if p2.UserId == 346767800 then
        p1.ActivateAfternight.DevelopmentBuild.Visible = true;
        p1.ActivateAfternight.DevelopmentBuild.Text = ` INDEV Build | {p2.Name} | Lock {p3.EngineData.GetCurrentLock()} // {p3.EngineData.GetMajorUpdateName()} // Update Version: {p3.EngineData.GetGameVersion()}`;
    else
        p1.ActivateAfternight.Frame.Visible = true;
    end;

    if not p3.EngineData.IsGenuine() then
        p1.ActivateAfternight.Frame.Label.Text = "we know what you are 🏳️‍🌈";
    end;
end;