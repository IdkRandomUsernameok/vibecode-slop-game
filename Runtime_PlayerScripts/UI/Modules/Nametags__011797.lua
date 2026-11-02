-- Decompiled with Potassium's decompiler.

local TextChatService = game:GetService("TextChatService");
local HttpService = game:GetService("HttpService");
local u1 = {};
local u2 = {};

return function(p3) -- Line: 7
    -- upvalues: TextChatService (copy), u1 (copy), u2 (copy), HttpService (copy)
    local Overheads = require(p3.UI.Overheads);
    local ColorConverter = require(p3.UI.ColorConverter);

    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        function TextChatService.OnIncomingMessage(p4: userdata) -- Line: 12
            -- upvalues: u1 (ref), u2 (ref), HttpService (ref), Overheads (copy), ColorConverter (copy)
            local TextChatMessageProperties = Instance.new("TextChatMessageProperties");
            local v5 = "";
            local v6, v7;

            if p4.TextSource then
                local PlayerByUserId = game.Players:GetPlayerByUserId(p4.TextSource.UserId);
                v6 = {
                    DisplayName = PlayerByUserId:GetAttribute("LB_DisguiseDisplayName"),
                    DisguiseUsername = PlayerByUserId:GetAttribute("LB_DisguiseDisplayName")
                };
                local Attribute = PlayerByUserId:GetAttribute("ImportantTags");
                local Attribute2 = PlayerByUserId:GetAttribute("Tags");
                local v8 = (Attribute or "") .. "|" .. (Attribute2 or "");

                if u1[p4.TextSource.UserId] == v8 and u2[p4.TextSource.UserId] then
                    v7 = u2[p4.TextSource.UserId];
                else
                    v7 = {};

                    if Attribute then
                        for _, v in ipairs(HttpService:JSONDecode(Attribute)) do
                            table.insert(v7, v);
                        end;
                    end;

                    if Attribute2 then
                        for _, v in ipairs(HttpService:JSONDecode(Attribute2)) do
                            table.insert(v7, v);
                        end;
                    end;

                    u1[p4.TextSource.UserId] = v8;
                    u2[p4.TextSource.UserId] = v7;
                end;
            else
                v7 = nil;
                v6 = {};
            end;

            if v7 ~= nil then
                local string_sub_ret = string.sub(p4.PrefixText, 1, #p4.PrefixText - 1);

                if v6.DisplayName and v6.DisplayName ~= "" then
                    p4.PrefixText = p4.PrefixText:gsub(string_sub_ret, v6.DisplayName);
                    string_sub_ret = v6.DisplayName;
                end;

                local v9 = "";

                for _, v in v7 do
                    local v10 = HttpService:JSONDecode(v);
                    local _ = string.find(v10[1] or "", "%[nameuwu%]") ~= nil;
                    local v11 = Overheads:formatTag(v10[1] or "", string_sub_ret);
                    local v12 = ColorConverter.convertColor(v10[2], v10[4], "[" .. v11 .. "]", v10[5], v10[6], true);

                    if v10[4] == true then
                        if v9 == "" then
                            if v12.isGradient then
                                v9 = v9 .. v12.color;
                            else
                                v9 = `<font color='{v12.color}'>[{v10[1] or "ERROR"}]:</font>`;
                            end;
                        end;
                    elseif v12.isGradient then
                        v5 = v5 .. v12.color;
                    else
                        v5 = v5 .. `<font color='{v12.color}'>[{v10[1] or "ERROR"}]</font> `;
                    end;
                end;

                local v13 = Overheads:formatTag(v9, string_sub_ret);

                if v13 == "" then
                    v13 = p4.PrefixText or v13;
                end;

                TextChatMessageProperties.PrefixText = v5 .. v13;
            end;

            task.wait();

            return TextChatMessageProperties;
        end;
    end;
end;