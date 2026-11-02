-- Decompiled with Potassium's decompiler.

local u1 = require("./RigInfo");

return function(u2: userdata, p3: userdata) -- Line: 7
    -- upvalues: u1 (copy)
    local v4 = u2:FindFirstChildWhichIsA("Humanoid");

    if not v4 then
        return;
    end;

    local v5 = u1[v4.RigType.Name] or {};
    local u6 = v5.BodyParts or { "HumanoidRootPart" };
    local u7 = v5.Attachments or {};
    local PrimaryPart = u2.PrimaryPart;

    local function isBodyPart(p8: userdata) -- Line: 16
        -- upvalues: u2 (copy), u6 (copy)
        return p8.Parent == u2 and table.find(u6, p8.Name) and true or false;
    end;

    local function isRigAttachment(p9: userdata) -- Line: 20
        -- upvalues: u2 (copy), u6 (copy), u7 (copy)
        local v10 = p9:FindFirstAncestorWhichIsA("BasePart");

        return v10 and (v10.Parent == u2 and table.find(u6, v10.Name) and table.find(u7, p9.Name)) and true or false;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "_Props";
    local v11 = {};

    for _, v in u2:QueryDescendants("JointInstance") do
        local Part0 = v.Part0;
        local Part1 = v.Part1;

        if Part0 and Part1 then
            local v12 = {};
            local v13 = Part0.Parent == u2 and table.find(u6, Part0.Name) and true or false;
            local v14 = Part1.Parent == u2 and table.find(u6, Part1.Name) and true or false;

            if v13 then
                v12.Part0 = Part0.Name;
            end;

            if v14 then
                v12.Part1 = Part1.Name;
            end;

            v.Parent = Folder;
            v.Name = "NWeld";
        else
            v:Destroy();
        end;
    end;

    local v15 = u2:QueryDescendants("AnimationConstraint");
    local v16 = {};
    local v17 = {};

    for _, v in u2:QueryDescendants(">Folder,>Model") do
        v.Parent = Folder;
    end;

    for _, v in u2:QueryDescendants(">BasePart") do
        if v.Parent == u2 and table.find(u6, v.Name) and true or false then
            v16[v.Name] = {
                Transparency = v.Transparency
            };
            v17[v.Name] = v.Size;
            local v18 = v;
            local v19 = {};

            for _, v2 in v:QueryDescendants(">.KeepParent, >.Highlight") do
                v19[v2] = true;
                v11[v2] = {
                    Parent = v18.Name
                };
            end;

            for _, v2 in v18:QueryDescendants(">BasePart,>Folder,>Model") do
                if not v19[v2] then
                    v2.Parent = Folder;
                end;
            end;
        end;
    end;

    local v20 = {};

    for _, v in v15 do
        local Attachment0 = v.Attachment0;
        local Attachment1 = v.Attachment1;

        if Attachment0 and Attachment1 then
            local v21 = Attachment0:FindFirstAncestorWhichIsA("BasePart");
            local v22 = Attachment1:FindFirstAncestorWhichIsA("BasePart");
            local v23 = Attachment0:FindFirstAncestorWhichIsA("BasePart");
            local v24;

            if v23 then
                v24 = v23.Parent == u2 and table.find(u6, v23.Name) and table.find(u7, Attachment0.Name) and true or false;
            else
                v24 = false;
            end;

            local v25 = Attachment1:FindFirstAncestorWhichIsA("BasePart");
            local v26;

            if v25 then
                v26 = v25.Parent == u2 and table.find(u6, v25.Name) and table.find(u7, Attachment1.Name) and true or false;
            else
                v26 = false;
            end;

            if not (v24 and v26) then
                local v27 = {};

                if not (v20[Attachment0] or (v24 or not v21) or (v21.Parent ~= u2 or not table.find(u6, v21.Name))) then
                    Attachment0.Parent = nil;
                    v20[Attachment0] = true;
                    v27.A0 = Attachment0;
                    v27.A0Parent = v21.Name;
                end;

                if not (v20[Attachment1] or (v26 or not v22) or (v22.Parent ~= u2 or not table.find(u6, v22.Name))) then
                    Attachment1.Parent = nil;
                    v20[Attachment1] = true;
                    v27.A1 = Attachment1;
                    v27.A1Parent = v22.Name;
                end;

                if next(v27) then
                    v11[v] = v27;
                end;

                local v28 = not Folder:IsAncestorOf(v) and v:FindFirstAncestorWhichIsA("BasePart");

                if v28 and (v28.Parent == u2 and table.find(u6, v28.Name)) then
                    v.Parent = Folder;
                end;
            end;
        else
            v:Destroy();
        end;
    end;

    local v29 = PrimaryPart and (PrimaryPart.Size.Y / 2 + v4.HipHeight or 0) or 0;
    local success, result = pcall(v4.ApplyDescriptionAsync, v4, p3, Enum.AssetTypeVerification.Always);

    if not success then
        warn((`ApplyDescription failed: {result}`));
    end;

    for i, v in v11 do
        if v.A0 then
            v.A0.Parent = u2:FindFirstChild(v.A0Parent) or nil;
        end;

        if v.A1 then
            v.A1.Parent = u2:FindFirstChild(v.A1Parent) or nil;
        end;

        if v.Parent then
            i.Parent = u2:FindFirstChild(v.Parent) or nil;
        end;

        if v.Part0 then
            i.Part0 = u2:FindFirstChild(v.Part0) or nil;
        end;

        if v.Part1 then
            i.Part1 = u2:FindFirstChild(v.Part1) or nil;
        end;
    end;

    if v4.RigType == Enum.HumanoidRigType.R15 then
        if PrimaryPart then
            local v30 = CFrame.new(0, PrimaryPart.Size.Y / 2 + v4.HipHeight - v29, 0):Inverse();

            for _, v in PrimaryPart:QueryDescendants(">Attachment") do
                local v31 = v:FindFirstAncestorWhichIsA("BasePart");
                local v32;

                if v31 then
                    v32 = v31.Parent == u2 and table.find(u6, v31.Name) and table.find(u7, v.Name) and true or false;
                else
                    v32 = false;
                end;

                if not v32 then
                    v.CFrame = v.CFrame * v30;
                end;
            end;
        end;

        for _, v in u2:QueryDescendants(">BasePart") do
            if v ~= PrimaryPart then
                local v33 = v17[v.Name];

                if v33 then
                    local Size = v.Size;

                    for _, v2 in u2:QueryDescendants(">Attachment") do
                        if v20[v2] then
                            local CFrame2 = v2.CFrame;
                            local v34 = CFrame2 - CFrame2.Position;
                            v2.CFrame = CFrame.new(CFrame2.Position * (v33 / Size)) * v34;
                        end;
                    end;
                end;
            end;
        end;
    end;

    Folder.Parent = u2;

    for i, v in v16 do
        local v35 = u2:FindFirstChild(i);

        if v35 then
            v35.Transparency = v.Transparency;
        end;
    end;

    for _, v in u2:QueryDescendants(">BasePart") do
        v.CanCollide = false;
        v.CanQuery = false;
        v.CanTouch = false;
        v.AudioCanCollide = false;
        u2.AncestryChanged:Connect(function() -- Line: 228
            -- upvalues: v (copy)
            v.CanCollide = false;
        end);
    end;

    for _, v in u2:QueryDescendants("BallSocketConstraint, NoCollisionConstraint") do
        v:Destroy();
    end;

    if v4.AutomaticScalingEnabled then
        local u36 = {};
        local u37 = {};

        for _, v in u2:QueryDescendants("Attachment") do
            if v20[v] then
                u37[v] = v:GetPropertyChangedSignal("CFrame"):Connect(function() -- Line: 253
                    -- upvalues: v (copy), u36 (copy)
                    if workspace:IsAncestorOf(v) then
                        return;
                    end;

                    u36[v] = v.CFrame;
                end);
                u36[v] = v.CFrame;
            end;
        end;

        local u38 = nil;
        u38 = u2.AncestryChanged:Connect(function() -- Line: 261
            -- upvalues: u2 (copy), u37 (copy), u36 (copy), u38 (ref)
            if workspace:IsAncestorOf(u2) then
                for _, v in u37 do
                    v:Disconnect();
                end;

                for _, v in u2:QueryDescendants("Attachment") do
                    if u36[v] then
                        v.CFrame = u36[v];
                    end;
                end;

                u38:Disconnect();
                u38 = nil;
                table.clear(u37);
                table.clear(u36);
            end;
        end);
    end;
end;