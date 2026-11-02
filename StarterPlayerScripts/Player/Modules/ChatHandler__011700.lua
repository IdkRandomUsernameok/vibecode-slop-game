-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TextChatService = game:GetService("TextChatService");

return function(p1, p2) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), TextChatService (copy)
    local Chatted = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Chatted");
    local ChatInputBarConfiguration = TextChatService.ChatInputBarConfiguration;

    local function updateChatKey(p3) -- Line: 8
        -- upvalues: ChatInputBarConfiguration (copy)
        ChatInputBarConfiguration.KeyboardKeyCode = Enum.KeyCode:FromName(p3) or Enum.KeyCode.Slash;
    end;

    TextChatService.SendingMessage:Connect(function(p4) -- Line: 13
        -- upvalues: Chatted (copy)
        Chatted:FireServer({
            Text = p4.Text,
            TextChannel = p4.TextChannel,
            Timestamp = p4.Timestamp,
            Status = p4.Status,
            Metadata = p4.Metadata,
            MessageId = p4.MessageId,
            PrefixText = p4.PrefixText,
            TextSource = p4.TextSource,
            Translation = p4.Translation
        });
    end);
    require(p1.Data.DataManager).DataChanged:Connect(function(p5, p6) -- Line: 27
        -- upvalues: ChatInputBarConfiguration (copy)
        if p5 == "Keybinds/Miscellaneous/ChatKeybind" then
            ChatInputBarConfiguration.KeyboardKeyCode = Enum.KeyCode:FromName(p6) or Enum.KeyCode.Slash;
        end;
    end);
    ChatInputBarConfiguration.KeyboardKeyCode = Enum.KeyCode:FromName(p2.Keybinds.Miscellaneous.ChatKeybind) or Enum.KeyCode.Slash;
end;