-- Decompiled with Potassium's decompiler.

local SocialService = game:GetService("SocialService");

return function() -- Line: 3
    -- upvalues: SocialService (copy)
    task.spawn(function() -- Line: 4
        -- upvalues: SocialService (ref)
        task.wait(5);
        local success, result = pcall(function() -- Line: 7
            -- upvalues: SocialService (ref)
            return SocialService:GetUpcomingExperienceEventsAsync();
        end);

        if not success then
            warn("[RSVP] Failed to load events:", result);

            return;
        end;

        for _, v in result do
            if not (v.HasStarted or v.HasEnded) then
                local Id = v.Id;
                local success2, result2 = pcall(function() -- Line: 21
                    -- upvalues: SocialService (ref), Id (copy)
                    return SocialService:GetEventRsvpStatusAsync(Id);
                end);

                if success2 then
                    if result2 == Enum.RsvpStatus.None then
                        local success3, result3 = pcall(function() -- Line: 32
                            -- upvalues: SocialService (ref), Id (copy)
                            return SocialService:PromptRsvpToEventAsync(Id);
                        end);

                        if not success3 then
                            warn("[RSVP] Failed to prompt RSVP:", result3);

                            return;
                        end;

                        break;
                    end;
                else
                    warn("[RSVP] Failed to get RSVP status:", result2);
                end;
            end;
        end;
    end);
end;