-- Decompiled with Potassium's decompiler.

local Api = shared.getApi();

local function lerp(p1, p2, p3) -- Line: 5
    return p1 + (p2 - p1) * p3;
end;

local u4 = {};
local u5 = {};
local Vector2_new_ret = Vector2.new(1, -1);

return {
    onCreate = function() -- Line: 17, Name: onCreate
        -- upvalues: Api (copy), u4 (copy)
        for _, v in Api.StrumLines do
            u4[v] = false;
            local v6 = v;

            for i, v2 in v.Strums do
                if math.floor(v6.KeyCount / 2) <= i then
                    if v6.KeyCount % 2 ~= 0 and i + 1 == math.ceil(v6.KeyCount / 2) then
                        local GetProperty = v2.GetProperty;

                        function v2.GetProperty(p7, p8, ...) -- Line: 24
                            -- upvalues: GetProperty (copy), v2 (copy)
                            if p8 ~= "y" then
                                return GetProperty(v2, p8, ...);
                            end;

                            local y = p7.y;
                            p7.y = 360;
                            GetProperty(v2, "y", {});
                            p7.y = y;

                            return 360;
                        end;
                    end;
                else
                    local GetProperty = v2.GetProperty;

                    function v2.GetProperty(p9, p10, ...) -- Line: 39
                        -- upvalues: GetProperty (copy), v2 (copy)
                        local v11 = GetProperty(v2, p10, ...);

                        if p10 == "y" then
                            return 720 - v11;
                        end;

                        return v11;
                    end;
                end;
            end;
        end;
    end,

    onSpawnNote = function(u12) -- Line: 50, Name: onSpawnNote
        -- upvalues: u5 (ref), u4 (copy), Vector2_new_ret (copy)
        if u5[u12] then
            return;
        end;

        local strumLine = u12.strumLine;
        local noteData = u12.noteData;
        u5[u12] = true;

        if math.floor(strumLine.KeyCount / 2) <= noteData then
            if strumLine.KeyCount % 2 ~= 0 and noteData + 1 == math.ceil(strumLine.KeyCount / 2) then
                if not strumLine.Strums[u12.noteData] then
                    return;
                end;

                local GetProperty = u12.GetProperty;
                local u13 = u4[strumLine];
                u4[strumLine] = not u13;

                for _, v in u12.sustains or {} do
                    local GetProperty2 = v.GetProperty;
                    u5[v] = true;
                    v.offsets.set("Scale", "_splitScrollInvertThing", u13 and Vector2_new_ret or nil);

                    function v.GetProperty(p14, p15, ...) -- Line: 72
                        -- upvalues: GetProperty2 (copy), v (copy), u13 (copy)
                        local v16 = GetProperty2(v, p15, ...);

                        if p15 ~= "y" then
                            if p15 == "angle" and (v.useAngleAnchor and u13) then
                                return -v16;
                            end;

                            return v16;
                        end;

                        local y = p14.y;
                        p14.y = 0;
                        local v17 = GetProperty2(v, "y", {});
                        p14.y = y;

                        return u13 and 720 - (360 - v17 + v16) or 360 - v17 + v16;
                    end;
                end;

                function u12.GetProperty(p18, p19, ...) -- Line: 87
                    -- upvalues: GetProperty (copy), u12 (copy), u13 (copy)
                    local v20 = GetProperty(u12, p19, ...);

                    if p19 ~= "y" then
                        if p19 == "angle" and (u12.useAngleAnchor and u13) then
                            return -v20;
                        end;

                        return v20;
                    end;

                    local y = p18.y;
                    p18.y = 0;
                    local v21 = GetProperty(u12, "y", {});
                    p18.y = y;

                    return u13 and 720 - (360 - v21 + v20) or 360 - v21 + v20;
                end;
            end;

            return;
        end;

        if u12.sustainNote then
            u12.offsets.set("Scale", "_splitScrollInvertThing", Vector2_new_ret);
        end;

        local GetProperty = u12.GetProperty;

        function u12.GetProperty(p22, p23, ...) -- Line: 109
            -- upvalues: GetProperty (copy), u12 (copy)
            local v24 = GetProperty(u12, p23, ...);

            if p23 == "y" then
                return 720 - v24;
            end;

            if p23 == "angle" and u12.useAngleAnchor then
                return -v24;
            end;

            return v24;
        end;
    end,

    clearUp = function() -- Line: 120, Name: clearUp
        -- upvalues: u5 (ref)
        u5 = {};
    end
};