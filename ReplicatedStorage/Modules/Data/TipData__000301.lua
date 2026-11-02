-- Decompiled with Potassium's decompiler.

local PolicyService = game:GetService("PolicyService");
game:GetService("MarketplaceService");
local BadgeService = game:GetService("BadgeService");
local TweenService = game:GetService("TweenService");
local BloxstrapRPC = require(game.ReplicatedStorage.Modules.Engine.BloxstrapRPC);
local RBX_CustomFont = require(game.ReplicatedStorage.Modules.Other.RBX_CustomFont);

local function playSound(p1, p2, p3) -- Line: 9
    local Sound = Instance.new("Sound", p1);
    Sound.SoundGroup = game:GetService("SoundService").Main.SFX;
    Sound.SoundId = p2;
    Sound.Volume = p3 or 1;
    Sound.Ended:Once(function() -- Line: 14
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);

    if not Sound.IsLoaded then
        Sound.Loaded:Wait();
    end;

    Sound:Play();

    return Sound;
end;

_tips = {
    "You left your oven on.",
    "Your fridge is open.",
    "+do you smell smoke?",
    "Is your refrigerator running?",
    "Are you experiencing issues with performance? Try out some optimization settings and see how they work.",
    "There are no best settings. How you want to play is all up to you!",
    "You can change your keybinds.\nYou.. knew that.. right?",
    "There are a total of <tips> tips in here.",
    "+Kimi still owes me money.",
    "This game was made with cheese!",
    "+Aw hell nah they added mid to Project Afternight",
    "+Aw hell yah they added peak to Project Afternight",
    "+Play A Dance of Fire and Ice!",
    "+Play Ace Attorney!",
    "+Play Advent NEON!",
    "+Play Arknights!",
    "+Play Bayonetta!",
    "+Play Beat Saber!",
    "+Play DELTARUNE!",
    "+Play Dead by Daylight!",
    "+Play Deep Rock Galactic!",
    "+Play Devil May Cry!",
    "+Play Fortnite!",
    "+Play Ghost Trick: Phantom Detective!",
    "+Play Everhood!",
    "+Play Helltaker!",
    "+Play Hollow Knight!",
    "+Play Honkai: Star Rail!",
    "+Play Fall Guys!",
    "+Play Five Nights at Freddy\'s!",
    "+Play Five Nights at Frickbear\'s 3!",
    "+Play Geometry Dash!",
    "+Play Super Meat Boy!",
    "+Play Monster Hunter!",
    "+Play Lobotomy Corporation!",
    "+Play Library of Ruina!",
    "+Play Limbus Company!",
    "+Play Lethal Company!",
    "+Play Rhythm Doctor!",
    "+Play Metal Gear!",
    "+Play Mega Man!",
    "+Play no_moon.jar!",
    "+Play OFF!",
    "+Play OMORI!",
    "+Play Persona!",
    "+Play Pizza Tower!",
    "+Play Plants vs. Zombies!",
    "+Play Rain World!",
    "+Play Shin Megami Tensei!",
    "+Play Sonic the Hedgehog!",
    "+Play Touhou!",
    "+Play UNDERTALE!",
    "+Play ULTRAKILL!",
    "+Play UNDERTALE YELLOW!",
    "+Play Umamusume: Pretty Derby!",
    "+Play Yakuza!",
    "+Play Woon!",
    "+Play wonderland.jar!",
    "+Play Zenless Zone Zero!",
    "+Read Homestuck!",
    "+Watch Interloper!",
    "+Also try Block Tales!",
    "+Also try Blox Cards!",
    "+Also try Darkest Hours!",
    "+Also try Decaying Winter!",
    "+Also try Deepwoken!",
    "+Also try Die of Death!",
    "+Also try DOORS!",
    "+Also try One More Night!",
    "+Also try Item Asylum!",
    "+Also try Asylum Rejects!",
    "+Also try Midnight Horrors!",
    "+Also try REGRETEVATOR!",
    "+Also try Super Scuffle!",
    "+Also try Funky Friday!",
    "+Also try Friday Night Partyin\'!",
    "+Also try Basically FNF: Remix!",
    "+Also try GRIMWORKS!",
    "+Also try PWNed by 14:00!",
    "+Also try Nullscape!",
    "+Also try PHIGHTING!",
    "+Also try The Battle Bricks!",
    "+Also try Monster Employer!",
    "+Also try nico\'s nextbots!",
    "You play like a cat mrrp mrp meow :3",
    "+deltarune tomorrow",
    "ESC + R + ENTER",
    "ESC + L + ENTER",
    "ALT + F4",
    "duntine",
    "Go for a perfect!",
    "riven has died well over 157 times in the exterior. 45 in five pebbles.",
    "wil",
    "fo",
    "+:3",
    "+Ennakon",
    "+Are you guys going trick or treating?",
    "[Placeholder] --remove this later pls",
    "You cannot sleep now, there are monsters nearby.",
    "You WILL die at one point.",
    "Marceline never sleeps so she can work on the game",
    "                                                   what? expected a tip? no.",
    "+there\'s a skip vote button on the bottom left btw",
    "the j",
    "use 4539931 in your bot id",
    "if you see this... run.",
    "Tip: Tip: Tip: Tip: Tip: Tip: Tip: Tip: Tip: Tip: Tip: Tip: Tip: Tip: Tip: Tip: Tip. Tip: Tip: Tip:",
    "During the alpha alone, there have been over 150K deaths in-game. Can you beat that?",
    "🍉",
    "🧱",
    "\n\n\n\n\n\n\n\n\n\n\n\n\nif you can SOMEHOW read this please get some help.",
    "the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never the end is never",
    "+sample text",
    "Is a song too hard? Play an easier difficulty (if applicable).",
    "Is a song too hard and you\'re playing solo?\nYou can reset without consequences.",
    "Are kids constantly stealing your solo spot?\nConsider playing on a private server.",
    "It says \"gullible\" on the ceiling.",
    "Collect my Keys.",
    "this engine took 7 tries (and counting)",
    "+simba",
    "more songs need to use the SM64 soundfont",
    "+we stole it from notitg (trust me)",
    "+run.",
    "+I\'m using tilt controls!",
    "+look at your ceiling",
    "+It\'s time to drink water.",
    "+batteries are not included with this session",
    "Not all Tips are actual Tips",
    "Some Tips are hidden behind certain conditions...",
    "+you. i know you. i know what you did. i know where you live. i am in the walls. the walls.. walls...\n\nget scared already dammit",
    "+santa may have came early, but he went away early as well.",
    "+there are loads of tips here and they are all useless.",
    "+there\'s a small chance you get a very glitchy tip (unintended)",
    "+autotranslate sucks",
    "+Sezei still didn\'t send that one bug report related to AutoLocalize.\n\ni never will either -sezei",
    "+T1p: There\'s something wrong with this t1p.",
    "+nil",
    "This game needs a Hero...",
    "Where are you going?",
    "+* There is no tip here.",
    "I\'ll have two number 9s, a number 9 large, a number 6 with extra dip, a number 7, two number 45s, one with cheese, and a large soda.",
    "Cousin, it\'s Roman! Let\'s go bowling.",
    "Bad with hold notes? Just hold them.",
    "This object here has been sitting there for 10 years! Dang... That\'s old.",
    "+Theres a Spy behind you.",
    "+Fun Fact: Theres like 4 Pyro mains in the team.",
    "+How to scare an Overwatch player: Protection Suzu",
    "+LÚCIO MAFIA",
    "+Tip: Take flank routes when playing Reaper or Tracer.\nWait wrong game.",
    "+Tip: If they have a Doomfist, try and stun as often as you can.\nWait wrong game.",
    "+Tip: Venture Overwatch",
    "+Hop on Val",
    "+Hop on Real Life.",
    "+I saw you run Buckle Up\nagainst that Trapper.",
    "+Tip: Generators take 90 full seconds to repair.\nWait wrong game.",
    "+Tip: When facing The Huntress, try and cut line of sight as fast as possible.\nWait wrong game.",
    "+Tip: When facing The Singularity, avoid areas guarded by Biopods.\nWait wrong game.",
    "+Tip: When facing The Knight, fake vaults slow down Guards in chase.\nWait wrong game.",
    "+Tip: When facing The Unknown, looking at it will remove the Weakened status effect.\nWait wrong game.",
    "+Tip: When facing The Artist, going into a locker while swarmed makes the crows leave.\nWait wrong game.",
    "Hello! Will you sing with me? How kind of you to show!",
    "+FRICK-TIP: Don\'t follow the white rabbit.",
    "+You good-for-nothing buckets of bolts! Make yourselves useful or I\'ll slash you to scrap metal!",
    "+You thought it was a good idea to climb up 64 studs, waiting for the earthquake to fling you millions of miles away from the island and suddenly...\nWait, what do you mean this is the wrong island? Is this not Natural Disaster Survival?",
    "+catgirlsequence fell from a high place.",
    "+Sezei was shot by Skeleton.",
    "+Marceline experienced kinetic energy.",
    "+PlushtrapDev went off with a bang.",
    "+Minz left the confines of this world.",
    "+Furo didn\'t want to live in the\nsame world as {player}.",
    "+Smokey went up in flames.",
    "+riven starved to death\nwhile fighting Iron Golem.",
    "+aquatica hit the ground too hard.",
    "+wil was impaled by Trident.",
    "+HeroEyad walked into a\ncactus while trying to escape Husk.",
    "+Pho discovered the floor is lava.",
    "+GDD was killed by [Intentional Game Design].",
    "+Mala was roasted in dragon\'s breath.",
    "+death.fell.accident.water",
    "+Spigot was obliterated by a\nsonically-charged shriek.",
    "+KrystalKlears died from dehydration.",
    "+waxatak was impaled on a stalagmite.",
    "+syrupwaf was struck by lightning\nwhile fighting Cave Spider.",
    "+cwb074 drowned while trying\n to escape Elder Guardian.",
    "+moonlitvoid froze to death.",
    "+Not_Killer was smashed by Zombie with \"BANHAMMER\".",
    "+RhysRJJ suffocated in a wall.",
    `+{game.Players.LocalPlayer.Name} held the hot potato for too long.`,
    "see zy",
    "nykoshe e",
    "meenss",
    "plash træp",
    "fhu roe",
    "he rou",
    "raven",
    "mae ta",
    "+Tip: You can use your glove to push people into cacti and get.. wait.. wrong game.",
    "+You can change the way your button looks by changing the difficulty. (wait.. wrong game..)",
    "+Say \'weegee\' in Mario\'s lobby in Item Asylum. Trust.",
    "+Tip: The higher your Intelligence, the more XP you get per kill.\nWait wrong game.",
    "+Tip: T-Bones cause more damage than Ramming or Slamming.\nWait wrong game.",
    "+Sure, you may be able to play as everyone, but Aiden..\nActually, no tips for you.",
    "+you want to take over the world?",
    "+📺   ☀️⭐ 📊   🚪💿 🐱   ✨🌊 🔺   🛰️🌠 🎬   ❤👤",
    "+● •",
    "+🚺",
    { function(p4) -- Line: 254
            p4.Text = "errmm.. <font color=\"rgb(134,116,216)\">freesquad</font>? we have a problem...";
            p4.RichText = true;
        end },
    { function(p5) -- Line: 260
            p5.Text = "<font color=\"rgb(61,6,26)\">stay calm</font>";
            p5.RichText = true;
        end },
    { function(p6) -- Line: 266
            p6.Text = "When someone <font color=\"rgb(255,255,255)\">rushes</font> you";
            p6.RichText = true;
        end },
    { function(p7) -- Line: 273
            p7.TextColor3 = Color3.new(0.345098, 0.101961, 0.498039);
            p7.Text = "You feel an evil presence watching you...";
        end },
    { function(p8) -- Line: 280
            p8.TextColor3 = Color3.new(0.345098, 0.101961, 0.498039);
            p8.Text = "The air is getting colder around you...";
        end },
    { function(p9) -- Line: 287
            p9.TextColor3 = Color3.new(0.345098, 0.101961, 0.498039);
            p9.Text = "Impending doom approaches...";
        end },
    { function(p10) -- Line: 294
            p10.TextColor3 = Color3.new(0.345098, 0.101961, 0.498039);
            p10.Text = "A horrible chill goes down your spine...";
        end },
    { function(p11) -- Line: 301
            -- upvalues: TweenService (copy)
            p11.TextColor3 = Color3.new(1, 0.701961, 0);
            p11.Text = "The First Trumpet has been sounded.";
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = p11.Parent.Parent.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Image = "rbxassetid://14867747898";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            TweenService:Create(ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
            game:GetService("Debris"):AddItem(ImageLabel, 2);
        end },
    { function(p12) -- Line: 318
            -- upvalues: TweenService (copy)
            p12.TextColor3 = Color3.new(1, 0.45098, 0);
            p12.Text = "The Second Trumpet has been sounded.";
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = p12.Parent.Parent.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Image = "rbxassetid://14867747634";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            TweenService:Create(ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
            game:GetService("Debris"):AddItem(ImageLabel, 2);
        end },
    { function(p13) -- Line: 334
            -- upvalues: TweenService (copy)
            p13.TextColor3 = Color3.new(1, 0.2, 0);
            p13.Text = "The Third Trumpet has been sounded.";
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = p13.Parent.Parent.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Image = "rbxassetid://14867747385";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            TweenService:Create(ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
            game:GetService("Debris"):AddItem(ImageLabel, 2);
        end },
    { function(p14) -- Line: 350
            -- upvalues: TweenService (copy)
            p14.TextColor3 = Color3.new(0, 1, 0.784314);
            p14.Text = "The Fourth Trumpet has been sounded.";
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = p14.Parent.Parent.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Image = "rbxassetid://15144911970";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            TweenService:Create(ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
            game:GetService("Debris"):AddItem(ImageLabel, 2);
        end },
    { function(p15) -- Line: 366
            p15.TextColor3 = Color3.new(0.666667, 0.113725, 0.113725);
            p15.Text = "Hello?";
        end },
    { "Tip: Hey can you turn around for like 2 seconds?", function(p16) -- Line: 373
            task.wait(1.5);
        end, "Tip: Thanks" },
    { "There is an intruder in your house.", function(u17) -- Line: 380
            -- upvalues: playSound (copy)
            task.delay(2, function() -- Line: 381
                -- upvalues: playSound (ref), u17 (copy)
                playSound(u17, "rbxassetid://7973280792");
            end);
        end },
    { function(p18) -- Line: 387
            p18.Text = require(script.TF2Tips)();
        end },
    { table.unpack(require(script["the entire fnaf 1 intro"])) },
    { table.unpack(require(script["Henry Speech"])) },
    { function(p19: userdata) -- Line: 403
            p19.TextColor3 = Color3.new(1, 0.2, 0.2);
            local v20 = 5;

            repeat
                p19.Text = `WARNING: YOU WILL DIE IN {tostring(v20)} SECONDS!!!11!`;
                v20 = v20 - 1;
                task.wait(1);
            until v20 == 0;
        end, "jk" },
    { function(p21: userdata) -- Line: 416
            p21.Text = "The Beta";
            task.wait(3);
        end, "Am Sorry." },
    { function(u22, u23) -- Line: 423
            u22.TextColor3 = Color3.new(1, 1, 1);
            u22.Text = "oooooo spinny textlab";
            task.spawn(function() -- Line: 426
                -- upvalues: u22 (copy), u23 (copy)
                repeat
                    task.wait();
                    local v24 = u22;
                    v24.Rotation = v24.Rotation + 0.7;
                until u22:GetAttribute("TipID") ~= u23 or u22.Parent.Parent.Visible == false;

                u22.Rotation = 0;
            end);
        end },
    { function(u25, u26) -- Line: 436
            -- upvalues: RBX_CustomFont (copy)
            u25.Visible = false;
            local u27 = u25:Clone();
            u27.Visible = true;
            u27.TextColor3 = Color3.new(1, 0.666667, 1);
            u27.TextStrokeTransparency = 0;
            u27.TextStrokeColor3 = Color3.new(1, 1, 1);
            u27.Text = "cute text!";
            u27.RichText = true;
            u27.Parent = u25.Parent;
            RBX_CustomFont.Replace("Mini Wakuwaku", u27);
            task.spawn(function() -- Line: 449
                -- upvalues: u25 (copy), u26 (copy), u27 (copy)
                repeat
                    task.wait();
                until u25:GetAttribute("TipID") ~= u26 or u25.Parent.Parent.Visible == false;

                u27:Destroy();
                u25.Visible = true;
            end);
        end },
    { function(u28, u29) -- Line: 460
            -- upvalues: RBX_CustomFont (copy)
            u28.Visible = false;
            local u30 = u28:Clone();
            u30.Visible = true;
            u30.Text = "I love Friday Night Funkin!";
            u30.RichText = true;
            u30.Parent = u28.Parent;
            RBX_CustomFont.Replace("FNF", u30);
            task.spawn(function() -- Line: 470
                -- upvalues: u28 (copy), u29 (copy), u30 (copy)
                repeat
                    task.wait();
                until u28:GetAttribute("TipID") ~= u29 or u28.Parent.Parent.Visible == false;

                u30:Destroy();
                u28.Visible = true;
            end);
        end },
    { function(u31, u32) -- Line: 481
            -- upvalues: RBX_CustomFont (copy)
            u31.Visible = false;
            local u33 = u31:Clone();
            u33.Visible = true;
            u33.Text = "hey kid.";
            u33.RichText = true;
            u33.Parent = u31.Parent;
            RBX_CustomFont.Replace("Comic Sans MS", u33);
            task.spawn(function() -- Line: 491
                -- upvalues: u31 (copy), u32 (copy), u33 (copy)
                repeat
                    task.wait();
                until u31:GetAttribute("TipID") ~= u32 or u31.Parent.Parent.Visible == false;

                u33:Destroy();
                u31.Visible = true;
            end);
        end },
    { "wega", function(u34) -- Line: 503
            -- upvalues: playSound (copy)
            task.delay(math.random(0, 20), function() -- Line: 505
                -- upvalues: u34 (copy), playSound (ref)
                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.Parent = u34.Parent;
                ImageLabel.Size = UDim2.fromScale(1, 1);
                ImageLabel.Image = "rbxassetid://16231466659";
                ImageLabel.Visible = true;
                ImageLabel.BackgroundTransparency = 1;
                local v35 = playSound(u34, "rbxassetid://16231447286");
                game:GetService("Debris"):AddItem(v35, 0.3);
                game:GetService("Debris"):AddItem(ImageLabel, 0.3);
            end);
        end },
    { function(u36, u37) -- Line: 522
            u36.Visible = false;
            local VideoFrame = Instance.new("VideoFrame");
            VideoFrame.Parent = u36.Parent;
            VideoFrame.BackgroundTransparency = 1;
            VideoFrame.Size = UDim2.new(1, 0, 1, 0);
            VideoFrame.Video = "rbxassetid://15997221603";
            VideoFrame.Visible = true;
            VideoFrame:Play();
            task.spawn(function() -- Line: 531
                -- upvalues: u36 (copy), u37 (copy), VideoFrame (copy)
                repeat
                    task.wait();
                until u36:GetAttribute("TipID") ~= u37 or u36.Parent.Parent.Visible == false;

                u36.Visible = true;
                VideoFrame:Destroy();
            end);
        end },
    { function(u38, u39) -- Line: 542
            u38.Visible = false;
            local VideoFrame = Instance.new("VideoFrame");
            VideoFrame.Parent = u38.Parent;
            VideoFrame.BackgroundTransparency = 1;
            VideoFrame.Size = UDim2.new(1, 0, 1, 0);
            VideoFrame.Video = "rbxassetid://16344260831";
            VideoFrame.Visible = true;
            VideoFrame:Play();
            task.spawn(function() -- Line: 551
                -- upvalues: u38 (copy), u39 (copy), VideoFrame (copy)
                repeat
                    task.wait();
                until u38:GetAttribute("TipID") ~= u39 or u38.Parent.Parent.Visible == false;

                u38.Visible = true;
                VideoFrame:Destroy();
            end);
        end },
    { function(u40, u41) -- Line: 561
            u40.Visible = false;
            local VideoFrame = Instance.new("VideoFrame");
            VideoFrame.Parent = u40.Parent;
            VideoFrame.BackgroundTransparency = 1;
            VideoFrame.Size = UDim2.new(1, 0, 1, 0);
            VideoFrame.Video = "rbxassetid://17106063818";
            VideoFrame.Visible = true;
            VideoFrame:Play();
            task.spawn(function() -- Line: 570
                -- upvalues: u40 (copy), u41 (copy), VideoFrame (copy)
                repeat
                    task.wait();
                until u40:GetAttribute("TipID") ~= u41 or u40.Parent.Parent.Visible == false;

                u40.Visible = true;
                VideoFrame:Destroy();
            end);
        end },
    { function(u42, u43) -- Line: 580
            u42.Visible = false;
            local VideoFrame = Instance.new("VideoFrame");
            VideoFrame.Parent = u42.Parent;
            VideoFrame.BackgroundTransparency = 1;
            VideoFrame.Size = UDim2.new(1, 0, 1, 0);
            VideoFrame.Video = "rbxassetid://93713187668656";
            VideoFrame.Visible = true;
            VideoFrame:Play();
            task.spawn(function() -- Line: 589
                -- upvalues: u42 (copy), u43 (copy), VideoFrame (copy)
                repeat
                    task.wait();
                until u42:GetAttribute("TipID") ~= u43 or u42.Parent.Parent.Visible == false;

                u42.Visible = true;
                VideoFrame:Destroy();
            end);
        end },
    { function(u44, u45) -- Line: 599
            u44.Visible = false;
            local VideoFrame = Instance.new("VideoFrame");
            VideoFrame.Parent = u44.Parent;
            VideoFrame.BackgroundTransparency = 1;
            VideoFrame.Size = UDim2.new(1, 0, 1, 0);
            VideoFrame.Video = "rbxassetid://84098659199814";
            VideoFrame.Visible = true;
            VideoFrame:Play();
            task.spawn(function() -- Line: 608
                -- upvalues: u44 (copy), u45 (copy), VideoFrame (copy)
                repeat
                    task.wait();
                until u44:GetAttribute("TipID") ~= u45 or u44.Parent.Parent.Visible == false;

                u44.Visible = true;
                VideoFrame:Destroy();
            end);
        end },
    "mrrp mrow prrrr -w-",
    "+>:3",
    "Need... bo...dies... So I can... gr... ow...",
    "FLEENTSTONES?",
    "while true do end -- load this up in studio trust me",
    "Blink before you open doors in case The Statue is behind it... wait, wrong game.",
    "+we need to kill ai artists",
    "+we need to kill Al artists",
    "+Are you sure?",
    "Remember to do warm-ups",
    "+afterdreamer says: hit the death notes for a surprise!",
    "+Hey, can you get me a bag of chips?",
    "Hello, Deadpool speaking here! I just wanted to leave a little note here to tell you road blockers that one of these characters don\'t belong here. ...It\'s me. I don\'t belong here. Oh well, enjoy the temporary fourth wall break and tell the afternight devs I said hi!",
    "boo.",
    "+1v1 me on blox cards vro",
    "Never stop the grind. Keep spending orundum on those pulls.",
    "+Aww look who didn\'t pull Wiš\'adel, haha",
    "+bro 0-1 is so hard I can\'t beat it",
    "Have you collected your dailies yet?",
    "I stole some food from the fridge last night, don\'t let Kal\'tsit know... please.",
    "+get beaned",
    "Struggling on an operation? Just use Wiš\'ade- oh wait, wrong game.",
    "+bunmiya",
    "+roach",
    "Damn! These lupos gay! Good for them.",
    "+shoutouts to tom fulp\nlol",
    "+cyberzone\ncoming soon",
    "+love to thriftman\nswag",
    "+ultimate rhythm gaming\nprobably",
    "+in loving memory of\nhenryeyes",
    "+dancin\nforever",
    "+ritz dx\nrest in peace lol",
    "+rate five\npls no blam",
    "+rhythm gaming\nultimate",
    "+you already know\nwe really out here",
    "+Like Parappa\nbut cooler",
    "+women are real\nthis is official",
    "+too over exposed\nroblox cant handle us",
    "+Hatsune Miku\nbiggest inspiration",
    "+too many people\nmy head hurts",
    "+refined taste in music\nif i say so myself",
    "+his name isnt keith\ndumb eggy lol",
    "+fashionably late\nbut here it is",
    "+yooooooooooo\nyooooooooo",
    "+pico funny\npico funny",
    "+we are not adding shucks\nstop asking us",
    "+shoutouts to mason\nfor da homies",
    "+carpal tunnel\ngame design",
    "+downscroll\ni dont know what that is",
    "+warning\nchoking hazard",
    "+devin chat\nwhat an honorable man",
    "+Oh {player}! I\'m respecting your privacy by knocking but asserting my authority as this tip by coming in anyway!",
    "If you do not press a note you lose score!",
    "+dont press the notes in the next song.",
    "+Shadow Wizard Money Gang! (We love casting spells.)\nThis tip was brought to you by:\nTHE SHADOW GOVERNMENT!",
    "Don\'t dig straight down...",
    "This tip does not tell you anything about how you can get better at the game!",
    "Wanna get better at the game? Just hit note good",
    "Information about your Sims can be found in the Info Panels at the bottom right.",
    "+the raccoons are after me. Send help",
    "if you press the notes at the right time, you press the notes",
    "If the song seems too difficult for you, don’t spam, don’t quit. This is progress.",
    "This screen displays tips.",
    "+i am the tip person, my tips are delicious.\nspecial delivery today!",
    "+If my tip makes it into the game, can you please make it green?",
    "+Sorry I ate this tip",
    "+i am going to hug you /threat",
    "+Pro tip: don\'t listen to any of these tips",
    "Don\'t know how to play? Just press the notes when they overlap with the corresponding receptors!",
    "Begging to get Tester won\'t work. It just won\'t. Stop begging.",
    "",
    "Every copy of Project: Afternight is personalized",
    "+Dying? Just say no! They cannot take your life without your permission.",
    "+Good job, you know how to read! 👍",
    "+urm.. how to give tips for a rhythm game?",
    "This is the tips screen!",
    "+I AM ERROR.",
    "+Wow what a cool game, let’s see what’s in store!",
    "Custom icons are unlocked at 50 unique full combos!",
    "+Not a tip: this isn\'t a tip",
    "+Finally, I’ve been waiting for you to show up!",
    "+There is no Project Afternight employee by the name of ████████",
    "+You\'ve been in a coma since 2016, we\'ve been trying to reach out to you. We don\'t know where this message will appear in your dreams, but we hope it reaches you.\nPlease wake up.",
    "Run to a wall and press A to jump, that will make you unlock Luigi.",
    "+We\'ve been triying to reach out to you about your car\'s extended warranty",
    "+At least they don’t identify as… Freddy Fazbear. Because… this one kid… became Freddy fi-Freddy five bear- after- this guy William Afton MURDER him. RAAGH! And like… five other k",
    "+DO NOT BELIEVE WHAT HE SAYS, THAT GUY\'S A CRIMINAL! A CRIMINAL I TELL YOU!",
    "+🎵 Dancing... Walking.. Rearranging furniture... Babs is.. Shopping, I let the bird out of the cage! 🎶",
    "+i Just LOVE arrows ⏩↙️↕️↙️⏪⏬↙️⏫↘️↖️",
    "+how was the fall?",
    "+i Just stole your food while you were reading this",
    "+What a nice tree.",
    "+Hello everybody, my name is Markiplier, and welcome back to Project Afternight, a ROBLOX FNF game that you guys requested for me to check out and I heard it was really, really good.",
    "+BOOOOOOOOOOOOOO👎👎👎👎👎👎👎👎👎👎🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅🍅",
    "+Is your refrigerator running? Then go catch it!",
    "+Is your refrigerator running? Oh it is? nvm then.",
    "+the government doesn’t tell you, but you can just take the ducks. I own like 7.",
    "Pancakes > Waffles",
    "Hello World!",
    "Long ago, two races ruled over the Earth: Humans and Monsters.\nOne day, a war broke out between the two races.",
    "Waffles > Pancakes",
    "+You’re telling me a shrimp fried that rice!?!?",
    "+we\'ve been trying to reach you about your car\'s extended warranty",
    "+I’m gonna make Mac & Cheese, AND NOBODY CAN STOP ME!",
    "+Look out for the 10hour burst man.......He is there to kill you with a twilight Sword slam-down",
    "+If a tip was a tip could this tip be a tip that gives you a tip",
    "+Instructions not included!",
    "+April Fools! There is no tip.",
    "+You know what that means!\n🐟",
    "+You don\'t really need any tips.\nYou got it as is, I believe in you! 👍",
    "+WHAT IS A KILOMETER!!! 🦅🦅🦅🦅🦅",
    "+How can I be grounded IF IM ALREADY ON THE GROUND?!",
    "+Everyone\'s here! \n❤️ Determination\n🧡 Bravery\n💛 Justice\n💚 Kindness\n💙 Integrity\n🩵 Patience\n💜 Perseverance\n🤎 Vessel\n🖤 Destruction\n🤍 Creation",
    "+Your politics bore me キリング・ブラスト 「KILLING BLAST」",
    "+i ain\'t feeling up to it right now, sorry..",
    "+*blows you up with mind*",
    "+QUICK {" .. string.upper(game.Players.LocalPlayer.DisplayName) .. "} GET THE BANANA",
    "+You can\'t always control who walks into your life, but you can control which window you throw them out of.",
    "I need a raise...",
    "I don\'t get paid enough for this...",
    "+meow? :3",
    "+YOU ARE NOW MANUALLY BREATHING.",
    "+YOU CAN NOW HEAR YOUR OWN THOUGHTS.",
    "+Everything can be a pizza topping if you\'re brave enough.",
    "+Do you know who else has dementia? Do you know who else has dementia?\nDo you know who else has dementia? Do you know who else has dementia?\nDo you know who else has dementia? Do you know who else has dementia?\nDo you know who else has dementia? Do you know who else has dementia?",
    "+Remember all that cringy things you did?\nNow you do. >:3",
    "+Road work ahead? Uh, I sure hope it does...",
    "+Rapping alone on a Friday night? Pathetic.",
    "+This is a story of a person named " .. string.upper(game.Players.LocalPlayer.DisplayName):sub(1, 1) .. string.lower(game.Players.LocalPlayer.DisplayName):sub(2) .. ". " .. string.upper(game.Players.LocalPlayer.DisplayName):sub(1, 1) .. string.lower(game.Players.LocalPlayer.DisplayName):sub(2) .. " goes up to a computer And begins to play a game called Project Afternight",
    "+Hey can you play that song that goes ⬇️⬅️➡️➡️⬇️⬇️⬅️⬆️⬆️⬇️↘️⬆️⬅️➡️⬇️?",
    "+THEY WERE IMPOSTORS, " .. string.upper(game.Players.LocalPlayer.DisplayName) .. "! THEY DIDN\'T LOVE YOU, I LOVED YOU! YOU THINK THEY WERE YOUR FRIENDS? I WAS YOUR BEST FRIEND, " .. string.upper(game.Players.LocalPlayer.DisplayName) .. "\'S BEST FRIEND IS ME!",
    "+friendly reminder to stay hydrated (drink your water)",
    "+go away, i wanna play solo",
    "+you have already lost.",
    "+You love my game? Project Afternight, my game? My gasme Project Frontiers? You love it? Project Aftertiers?",
    "+{player} Gaming!",
    "+" .. string.lower(game.Players.LocalPlayer.DisplayName) .. ": demoknight tf2",
    "+How it FEELS to Play " .. string.upper(game.Players.LocalPlayer.DisplayName),
    "+Glory to Arstotzka.",
    "+The existence of watermelons can only mean there is an earthmelon, firemelon and airmelon. These are the elemelons.",
    "+ORIGINAL TIP DO NOT STEAL",
    "+Friday Night Funkin\' is an open-source rhythm game released on [REDACTED] in 2020.\nThe game is developed by a small group called The Funkin\' Crew Inc., which consists of Cameron \"ninjamuffin99\" Taylor, David \"PhantomArcade\" Brown, Isaac \"Kawai Sprite\" Garcia, and evilsk8r.\nThe game shares some gameplay features with Dance Dance Revolution, PaRappa the Rapper, and the \"Dance Contest\" minigame from Club Penguin, and borrows aesthetic influences from Flash games. The game has been credited with driving users back to [REDACTED], a site whose popularity peaked in the early 2000s.",
    "+Thip: How do I spell Thip?",
    "+We are not legally responsible for finger related injuries",
    "+Hello Internet, and welcome to Project: Afternight!",
    "+the original mascot of project: afternight was gary. dont bother asking what gary is, just know it was the original mascot",
    "+\"Tip: if you\'re going to suggest a tip, add the quotation marks\"",
    "+I LOVE CHEWING ON RUBBER LEGO TIRES",
    "+I think I dropped my house key somewhere. That was my favourite key... it opened my house...",
    "+THE DEMONS TOLD ME TO-",
    "Did you kno- Oh, you did? Nevermind then.",
    "+Sorry... I couldnt think of a tip...",
    "+uhhh... what\'s this suppose to be again? Oh right a tip uh.... yes you can uh.. hit notes. yeah.",
    "+So, what did you die to this time?",
    "+You Cannot Beat Us.",
    "If you play solo, there\'s a larger time limit for choosing songs.",
    "oh a mirror | rorrim a ho :piT",
    "HATSUNE MIKU?! IS THAT YOU?!",
    "+only 0.0021% of suggested tips are accepted",
    "IA shopkeeper — 01/04/2024 21:08\nThose beta devs keep stealing my stuff",
    "+your brain tricks you into thinking",
    "+uhh umm i forgot the tip",
    "+This tip was made specifically for you, {player}.",
    "In certain songs, you can try out different difficulties with easier versions of their modcharts.",
    "+Hello and, again, welcome to the Aperture Science computer-aided enrichment center.",
    "+[ insert tip here ]",
    "+Would you keep this tip, or double it and give it to the next person?",
    "+i am slowly losing my sanity...",
    "+: oh sorry i ate this tip",
    "+I was paid 50k to make this tip in particular",
    "+ooooooo, look! a can of dementia!\n\nooooooo, look! a can of dementia!\n\nooooooo, look! a can of dementia!",
    "+did the pipe hit u hard?",
    "+GO GO GADGET TIP!",
    "+🐇",
    "+🐈",
    "+🐕",
    "+6 7",
    "+six seveennnnn",
    "+You can get a free tip by playing the game for 10 minutes.",
    "+This tip costs 0 to unlock. It appears you do not have such funds. Shame.",
    "+[{player}]: hi",
    "Sometimes a break goes a long way.",
    "+When did you have a break last time? Go out for a bit if the answer is above 1 hour ago.",
    "Anything goes, even Jamacian.",
    "Chinese, Thai or Korean",
    "+i like waffles",
    "+there is no tip..... you\'ve ran out of tips.....",
    "+breaking roblox tos is easy\n\neven if you aren\'t breaking it",
    "try swimming in the volcano! it\'s kinda warm",
    "+afternight TOMORROW",
    "+Stand ready for my arrival bunny",
    "If u look closely at the screen u can see something scary\n\n\n[thats u]",
    "Here\'s five booms for uncovering this tip. BOOM! BOOM! BOOM! BOOM! BOOM!",
    "+touch the crystal for silly cats",
    "+i have done nothing but teleport bread for three days.",
    "+hi ma!",
    "+500 Sandviches.",
    "If you\'re new to the game, please check your settings and play solo first before playing against others. You don\'t want to embarrass yourself, right?",
    "Don\'t be afraid to 1v1 people even if you are starter, people are nice here\n\nExcept when they aren\'t",
    "Data corruptions are laughable!",
    "+i will eat your cheese. 🐀",
    "+i will eat your strawberries. 🐇",
    "What a save!\nWhat a save!\nWhat a save!\nWhat a save!\nWhat a save!\nYou are muted for 10 seconds.\nYou are muted for 10 seconds.\nYou are muted for 10 seconds.\nYou are muted for 9 seconds.",
    "+DUDE!! SOMEONE JUST PUT THE WEATHER MACHINE ON 12!!",
    "+unplugging your screen will make the game x100 times harder",
    "+UPDATE IS DELAYED!",
    "+[ Content Deleted ]",
    "+[CENSORED]",
    "+####################################################",
    "+why do they call it oven when you of in the cold food of out hot eat food",
    "+why do they call it fridge when you of in the hot food of out cold food",
    "+Chip: Chip. 🥔🥔🥔🥔🥔🥔🥔",
    "+<font color=\'#ff0000\">DEATH 死</font> --guys this tip smh",
    "",
    { "subspace tripmine", function(u46, u47) -- Line: 869
            -- upvalues: TweenService (copy), playSound (copy)
            u46.Parent.ClipsDescendants = true;
            local ImageButton = Instance.new("ImageButton");
            ImageButton.Parent = u46.Parent;
            ImageButton.Size = UDim2.fromOffset(30, 30);
            ImageButton.Position = UDim2.fromScale(0.5, -2);
            ImageButton.AnchorPoint = Vector2.new(0.5, 1);
            ImageButton.Visible = true;
            ImageButton.BackgroundTransparency = 1;
            TweenService:Create(ImageButton, TweenInfo.new(2.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 1)
            }):Play();
            local u48 = playSound(ImageButton, "http://www.roblox.com/asset/?id=11956590");
            u48.Looped = true;
            local u49 = false;

            local function Pulse() -- Line: 888
                -- upvalues: u49 (ref), playSound (ref), ImageButton (copy), TweenService (ref)
                if u49 then
                    playSound(ImageButton, "http://www.roblox.com/asset/?id=11984254");
                    ImageButton.ImageTransparency = 0.5;
                    TweenService:Create(ImageButton, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                        ImageTransparency = 1
                    }):Play();
                end;
            end;

            task.delay(3.5, function() -- Line: 896
                -- upvalues: u48 (copy), u49 (ref), playSound (ref), ImageButton (copy), u46 (copy), TweenService (ref)
                u48:Stop();

                local function BlowUp() -- Line: 899
                    -- upvalues: u49 (ref), playSound (ref), ImageButton (ref), u46 (ref)
                    if u49 then
                        playSound(ImageButton, "http://www.roblox.com/asset/?id=17146810816");
                        u46.TextColor3 = Color3.new(1, 0, 1);
                        u49 = false;
                        ImageButton:Destroy();
                    end;
                end;

                TweenService:Create(ImageButton, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    ImageTransparency = 1
                }):Play();
                task.delay(0.5, function() -- Line: 910
                    -- upvalues: u49 (ref)
                    u49 = true;
                end);
                ImageButton.Activated:Connect(function() -- Line: 914
                    -- upvalues: u49 (ref), playSound (ref), ImageButton (ref), u46 (ref)
                    if u49 and u49 then
                        playSound(ImageButton, "http://www.roblox.com/asset/?id=17146810816");
                        u46.TextColor3 = Color3.new(1, 0, 1);
                        u49 = false;
                        ImageButton:Destroy();
                    end;
                end);
            end);
            task.spawn(function() -- Line: 921
                -- upvalues: Pulse (copy), u46 (copy), u47 (copy), u48 (copy), ImageButton (copy)
                while true do
                    task.wait();

                    if math.random(1, 240) <= 3 then
                        Pulse();
                    end;

                    if u46:GetAttribute("TipID") ~= u47 or u46.Parent.Parent.Visible == false then
                        pcall(function() -- Line: 929
                            -- upvalues: u48 (ref), ImageButton (ref)
                            u48:Stop();
                            u48:Destroy();
                            ImageButton:Destroy();
                        end);
                        u46.TextColor3 = Color3.new(1, 1, 1);

                        return;
                    end;
                end;
            end);
        end },
    { function(p50) -- Line: 940
            p50.Text = math.random(1, 100) == 1 and "This tip is 1/10000 chance and no one will believe you if you try to prove it exists" or "This is a tip. Hi!";
        end },
    { "Cooking too hard will burn your house down, Including this text. ", function(u51, u52) -- Line: 946
            task.spawn(function() -- Line: 948
                -- upvalues: u51 (copy), u52 (copy)
                while u51:GetAttribute("TipID") == u52 and u51.Parent.Parent.Visible == true do
                    task.wait(0.25);
                    local v53 = u51;
                    v53.Text = v53.Text .. "🔥";
                end;
            end);
        end },
    { "+Fact: There are 8 letters in the name Mettaton", function(u54, u55) -- Line: 958
            task.spawn(function() -- Line: 959
                -- upvalues: u54 (copy), u55 (copy)
                local v56 = 1;
                local v57 = "n";

                while u54:GetAttribute("TipID") == u55 and u54.Parent.Parent.Visible == true do
                    task.wait(0.1);
                    v56 = v56 + 1;
                    v57 = v57 .. "n";
                    u54.Text = "Fact: There are " .. v56 + 7 .. " letters in the name Mettato" .. v57;
                end;
            end);
        end },
    { function(p58) -- Line: 985
            p58.Text = "<font color=\"rgb(255,255,0)\">Congratulations! You found a yellow text! You get nothing!</font>";
            p58.RichText = true;
        end },
    { function(p59) -- Line: 991
            p59.Text = "<font color=\"rgb(255,0,0)\">* Greetings.</font>";
            p59.RichText = true;
        end },
    { function(p60) -- Line: 1052
            p60.Text = "human.. i remeber youre <stroke color=\"#990000\" joins=\"miter\" thickness=\"9\" transparency=\"0.25\"><font color=\"rgb(255,0,0)\">genocides</font></stroke>";
            p60.RichText = true;
        end },
    { function(p61) -- Line: 1058
            p61.Text = "human.. i remeber youre <stroke color=\"#999900\" joins=\"miter\" thickness=\"9\" transparency=\"0.25\"><font color=\"rgb(255,255,0)\">neutrals</font></stroke>";
            p61.RichText = true;
        end },
    { function(p62) -- Line: 1064
            p62.Text = "human.. i remeber youre <stroke color=\"#009900\" joins=\"miter\" thickness=\"9\" transparency=\"0.25\"><font color=\"rgb(0,255,0)\">pacifists</font></stroke>";
            p62.RichText = true;
        end },
    { function(p63) -- Line: 1070
            p63.Text = "human.. i remeber youre <stroke color=\"#ffffff\" joins=\"miter\" thickness=\"9\" transparency=\"0.25\"><font color=\"rgb(255,255,255)\">solos</font></stroke>";
            p63.RichText = true;
        end },
    { function(u64, u65) -- Line: 1076
            u64.Text = "human.. i remeber youre <stroke color=\"#0000ff\" joins=\"miter\" thickness=\"9\" transparency=\"0.25\"><font color=\"rgb(0,0,255)\">blues</font></stroke>";
            u64.RichText = true;
            local Highlight = Instance.new("Highlight", game.Players.LocalPlayer.Character);
            Highlight.FillColor = Color3.new(0, 0, 1);
            Highlight.OutlineTransparency = 1;
            Highlight.FillTransparency = 0;
            Highlight.Enabled = true;
            task.spawn(function() -- Line: 1086
                -- upvalues: u64 (copy), u65 (copy), Highlight (copy)
                repeat
                    task.wait();
                until u64:GetAttribute("TipID") ~= u65 or u64.Parent.Parent.Visible == false;

                Highlight:Destroy();
            end);
        end },
    { function(u66) -- Line: 1095
            -- upvalues: playSound (copy)
            task.spawn(function() -- Line: 1097
                -- upvalues: u66 (copy), playSound (ref)
                for i = 1, 56 do
                    u66.Text = ("QUICK, I GOT 3 SECONDS, THE NEXT AFTERNIGHT UPDATE IS IN"):sub(1, i);
                    task.spawn(function() -- Line: 1100
                        -- upvalues: playSound (ref), u66 (ref)
                        playSound(u66, "rbxassetid://5416666166");
                    end);
                    task.wait(0.05);
                    local _ = i;
                end;
            end);
        end },
    { "Let that sink in.", function(u67) -- Line: 1110
            -- upvalues: playSound (copy)
            task.delay(2, function() -- Line: 1111
                -- upvalues: playSound (ref), u67 (copy)
                playSound(u67, "rbxassetid://7973280792");
            end);
        end },
    { "Did you know that you aren\'t safe?", function(u68) -- Line: 1118
            -- upvalues: playSound (copy)
            task.delay(2, function() -- Line: 1119
                -- upvalues: u68 (copy)
                u68.Text = "Look behind you.";
            end);
            task.delay(3.5, function() -- Line: 1122
                -- upvalues: playSound (ref), u68 (copy)
                playSound(u68, "rbxassetid://9114145202");
            end);
        end },
    { "Mysterious wind.", function(u69, u70) -- Line: 1129
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u69.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u69, "rbxassetid://101963857020856", 1.6);
            task.spawn(function() -- Line: 1139
                -- upvalues: u69 (copy), u70 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u69:GetAttribute("TipID") ~= u70 or u69.Parent.Parent.Visible == false;

                u69.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "Sustingus.", function(u71, u72) -- Line: 1151
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u71.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u71, "rbxassetid://126763963156264", 1.6);
            task.spawn(function() -- Line: 1161
                -- upvalues: u71 (copy), u72 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u71:GetAttribute("TipID") ~= u72 or u71.Parent.Parent.Visible == false;

                u71.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "It\'s me, Flowery!", function(u73, u74) -- Line: 1173
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u73.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u73, "rbxassetid://118719811504448", 1.6);
            task.spawn(function() -- Line: 1183
                -- upvalues: u73 (copy), u74 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u73:GetAttribute("TipID") ~= u74 or u73.Parent.Parent.Visible == false;

                u73.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "Jarona!", function(u75, u76) -- Line: 1195
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u75.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u75, "rbxassetid://134255977776772", 1.6);
            task.spawn(function() -- Line: 1205
                -- upvalues: u75 (copy), u76 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u75:GetAttribute("TipID") ~= u76 or u75.Parent.Parent.Visible == false;

                u75.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "Sorry to keep you waiting!", function(u77, u78) -- Line: 1217
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u77.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u77, "rbxassetid://102536727251985", 1.6);
            task.spawn(function() -- Line: 1227
                -- upvalues: u77 (copy), u78 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u77:GetAttribute("TipID") ~= u78 or u77.Parent.Parent.Visible == false;

                u77.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "What a predictable creature!", function(u79, u80) -- Line: 1239
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u79.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u79, "rbxassetid://118831727086816", 1.6);
            task.spawn(function() -- Line: 1249
                -- upvalues: u79 (copy), u80 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u79:GetAttribute("TipID") ~= u80 or u79.Parent.Parent.Visible == false;

                u79.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "Hey there little guy.", function(u81, u82) -- Line: 1261
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u81.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u81, "rbxassetid://91055533028823", 1.6);
            task.spawn(function() -- Line: 1271
                -- upvalues: u81 (copy), u82 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u81:GetAttribute("TipID") ~= u82 or u81.Parent.Parent.Visible == false;

                u81.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "Hey guys! I think I found a glue!", function(u83, u84) -- Line: 1283
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u83.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u83, "rbxassetid://121597337783506", 1.6);
            task.spawn(function() -- Line: 1293
                -- upvalues: u83 (copy), u84 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u83:GetAttribute("TipID") ~= u84 or u83.Parent.Parent.Visible == false;

                u83.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "They\'re eating my flesh!", function(u85, u86) -- Line: 1305
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u85.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u85, "rbxassetid://75845133954558", 1.6);
            task.spawn(function() -- Line: 1315
                -- upvalues: u85 (copy), u86 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u85:GetAttribute("TipID") ~= u86 or u85.Parent.Parent.Visible == false;

                u85.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "Here I come San Frandisco!", function(u87, u88) -- Line: 1327
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u87.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u87, "rbxassetid://82674289734521", 1.6);
            task.spawn(function() -- Line: 1337
                -- upvalues: u87 (copy), u88 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u87:GetAttribute("TipID") ~= u88 or u87.Parent.Parent.Visible == false;

                u87.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "Heh, it\'s my Jarona!", function(u89, u90) -- Line: 1349
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u89.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u89, "rbxassetid://72765150237152", 1.6);
            task.spawn(function() -- Line: 1359
                -- upvalues: u89 (copy), u90 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u89:GetAttribute("TipID") ~= u90 or u89.Parent.Parent.Visible == false;

                u89.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "Leaf it to me!", function(u91, u92) -- Line: 1371
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u91.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u91, "rbxassetid://113862552031349", 1.6);
            task.spawn(function() -- Line: 1381
                -- upvalues: u91 (copy), u92 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u91:GetAttribute("TipID") ~= u92 or u91.Parent.Parent.Visible == false;

                u91.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "All according to plant!", function(u93, u94) -- Line: 1393
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u93.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u93, "rbxassetid://126278094563314", 1.6);
            task.spawn(function() -- Line: 1403
                -- upvalues: u93 (copy), u94 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u93:GetAttribute("TipID") ~= u94 or u93.Parent.Parent.Visible == false;

                u93.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "I\'m falling!", function(u95, u96) -- Line: 1415
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u95.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u95, "rbxassetid://114759873022395", 1.6);
            task.spawn(function() -- Line: 1425
                -- upvalues: u95 (copy), u96 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u95:GetAttribute("TipID") ~= u96 or u95.Parent.Parent.Visible == false;

                u95.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "Flowery.", function(u97, u98) -- Line: 1437
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u97.Parent;
            ImageLabel.Size = UDim2.fromScale(0.25, 1);
            ImageLabel.Image = "rbxassetid://86907811105324";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            playSound(u97, "rbxassetid://140251480146053", 1.6);
            task.spawn(function() -- Line: 1447
                -- upvalues: u97 (copy), u98 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u97:GetAttribute("TipID") ~= u98 or u97.Parent.Parent.Visible == false;

                u97.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "cantaloupe", function(u99, u100) -- Line: 1459
            -- upvalues: TweenService (copy)
            task.delay(1, function() -- Line: 1460
                -- upvalues: u99 (copy), TweenService (ref), u100 (copy)
                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.Parent = u99.Parent;
                ImageLabel.Size = UDim2.fromScale(1, 1);
                ImageLabel.Image = "rbxassetid://15212043194";
                ImageLabel.Visible = true;
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.ImageTransparency = 1;
                TweenService:Create(ImageLabel, TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ImageTransparency = 0
                }):Play();
                task.spawn(function() -- Line: 1470
                    -- upvalues: u99 (ref), u100 (ref), ImageLabel (copy)
                    repeat
                        task.wait();
                    until u99:GetAttribute("TipID") ~= u100 or u99.Parent.Parent.Visible == false;

                    u99.Visible = true;
                    ImageLabel:Destroy();
                end);
            end);
        end },
    { function(u101, u102) -- Line: 1482
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u101.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Image = "rbxassetid://17270863335";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            task.spawn(function() -- Line: 1491
                -- upvalues: u101 (copy), u102 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u101:GetAttribute("TipID") ~= u102 or u101.Parent.Parent.Visible == false;

                u101.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { function(u103, u104) -- Line: 1502
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u103.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 3);
            ImageLabel.Image = "rbxassetid://78973366226116";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            task.spawn(function() -- Line: 1511
                -- upvalues: u103 (copy), u104 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u103:GetAttribute("TipID") ~= u104 or u103.Parent.Parent.Visible == false;

                u103.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { function(u105, u106) -- Line: 1522
            -- upvalues: playSound (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u105.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Image = "rbxassetid://17670220064";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            local u107 = playSound(u105, "rbxassetid://17698325819");
            task.delay(5, function() -- Line: 1534
                -- upvalues: u105 (copy), u106 (copy), ImageLabel (copy)
                if u105:GetAttribute("TipID") ~= u106 then
                    return;
                end;

                ImageLabel.Image = "rbxassetid://17670220275";
            end);
            task.spawn(function() -- Line: 1539
                -- upvalues: u105 (copy), u106 (copy), u107 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u105:GetAttribute("TipID") ~= u106 or u105.Parent.Parent.Visible == false;

                u105.Visible = true;

                if u107 then
                    u107:Destroy();
                end;

                if ImageLabel then
                    ImageLabel:Destroy();
                end;
            end);
        end },
    { function(u108, u109) -- Line: 1551
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u108.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Image = "rbxassetid://16938982214";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            task.spawn(function() -- Line: 1560
                -- upvalues: u108 (copy), u109 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u108:GetAttribute("TipID") ~= u109 or u108.Parent.Parent.Visible == false;

                u108.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { function(u110, u111) -- Line: 1570
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u110.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Image = "rbxassetid://16939462270";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            task.spawn(function() -- Line: 1579
                -- upvalues: u110 (copy), u111 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u110:GetAttribute("TipID") ~= u111 or u110.Parent.Parent.Visible == false;

                u110.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { function(u112, u113) -- Line: 1590
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u112.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 3);
            ImageLabel.Image = "rbxassetid://115769038636822";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            task.spawn(function() -- Line: 1599
                -- upvalues: u112 (copy), u113 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u112:GetAttribute("TipID") ~= u113 or u112.Parent.Parent.Visible == false;

                u112.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { function(u114, u115) -- Line: 1609
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u114.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Image = "rbxassetid://16939030287";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            task.spawn(function() -- Line: 1618
                -- upvalues: u114 (copy), u115 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u114:GetAttribute("TipID") ~= u115 or u114.Parent.Parent.Visible == false;

                u114.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { function(u116, u117) -- Line: 1629
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u116.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Image = "rbxassetid://127932324173889";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 0;
            task.spawn(function() -- Line: 1638
                -- upvalues: u116 (copy), u117 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u116:GetAttribute("TipID") ~= u117 or u116.Parent.Parent.Visible == false;

                u116.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "There is no tip here.", function(u118, u119) -- Line: 1649
            -- upvalues: TweenService (copy)
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Parent = u118.Parent;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Image = "rbxassetid://15831985574";
            ImageLabel.Visible = true;
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.ImageTransparency = 1;
            TweenService:Create(ImageLabel, TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            }):Play();
            task.spawn(function() -- Line: 1659
                -- upvalues: u118 (copy), u119 (copy), ImageLabel (copy)
                repeat
                    task.wait();
                until u118:GetAttribute("TipID") ~= u119 or u118.Parent.Parent.Visible == false;

                u118.Visible = true;
                ImageLabel:Destroy();
            end);
        end },
    { "elelelelelele", function(u120, u121) -- Line: 1671
            u120.Visible = false;
            local VideoFrame = Instance.new("VideoFrame");
            VideoFrame.Parent = u120.Parent;
            VideoFrame.BackgroundTransparency = 1;
            VideoFrame.Size = UDim2.new(1, 0, 1, 0);
            VideoFrame.Video = "rbxassetid://131400758542500";
            VideoFrame.Visible = true;
            VideoFrame:Play();
            task.spawn(function() -- Line: 1681
                -- upvalues: VideoFrame (copy), u120 (copy), u121 (copy)
                repeat
                    task.wait();
                until VideoFrame.Loaded or not (VideoFrame and (u120:GetAttribute("TipID") == u121 and u120.Parent.Parent.Visible ~= false));

                if VideoFrame then
                    task.delay(0.02, function() -- Line: 1687
                        -- upvalues: VideoFrame (ref), u120 (ref), u121 (ref)
                        if VideoFrame then
                            VideoFrame:Destroy();
                        end;

                        if u120:GetAttribute("TipID") ~= u121 then
                            return;
                        end;

                        u120.Visible = true;
                    end);
                end;
            end);
            task.spawn(function() -- Line: 1696
                -- upvalues: u120 (copy), u121 (copy), VideoFrame (copy)
                repeat
                    task.wait();
                until u120:GetAttribute("TipID") ~= u121 or u120.Parent.Parent.Visible == false;

                u120.Visible = true;

                if VideoFrame then
                    VideoFrame:Destroy();
                end;
            end);
        end },
    { "Proceed.", function(p122, p123) -- Line: 1710
            -- upvalues: playSound (copy)
            if p122:GetAttribute("TipID") ~= p123 then
                return;
            end;

            playSound(p122, "rbxassetid://119592417946062");
        end },
    { "That\'s why I want... to do something crazy.", function(p124, p125) -- Line: 1717
            -- upvalues: playSound (copy)
            if p124:GetAttribute("TipID") ~= p125 then
                return;
            end;

            playSound(p124, "rbxassetid://119592417946062");
        end },
    { "Tell me to grow wings... And let\'s fly out of this stupid town!", function(p126, p127) -- Line: 1724
            -- upvalues: playSound (copy)
            if p126:GetAttribute("TipID") ~= p127 then
                return;
            end;

            playSound(p126, "rbxassetid://119592417946062");
        end },
    { "{player}... that\'s... not the thorn, is it?", function(p128, p129) -- Line: 1731
            -- upvalues: playSound (copy)
            if p128:GetAttribute("TipID") ~= p129 then
                return;
            end;

            playSound(p128, "rbxassetid://119592417946062");
        end },
    { "That\'s not... the... ThornRing, is it...?", function(p130, p131) -- Line: 1738
            -- upvalues: playSound (copy)
            if p130:GetAttribute("TipID") ~= p131 then
                return;
            end;

            playSound(p130, "rbxassetid://119592417946062");
        end },
    { "Also try Project: Afternight!", function(u132, u133) -- Line: 1747
            -- upvalues: playSound (copy)
            task.delay(2, function() -- Line: 1748
                -- upvalues: u132 (copy), u133 (copy), playSound (ref)
                if u132:GetAttribute("TipID") ~= u133 then
                    return;
                end;

                playSound(u132, "rbxassetid://119592417946062");
            end);
        end },
    { "There is a tip here.", function(u134, u135) -- Line: 1756
            -- upvalues: playSound (copy)
            task.delay(2, function() -- Line: 1757
                -- upvalues: u134 (copy), u135 (copy), playSound (ref)
                if u134:GetAttribute("TipID") ~= u135 then
                    return;
                end;

                playSound(u134, "rbxassetid://119592417946062");
            end);
        end },
    { "Tip: Wait... Huh... where...?", function(u136, u137) -- Line: 1765
            -- upvalues: playSound (copy)
            task.delay(2, function() -- Line: 1766
                -- upvalues: u136 (copy), u137 (copy), playSound (ref)
                if u136:GetAttribute("TipID") ~= u137 then
                    return;
                end;

                playSound(u136, "rbxassetid://119592417946062");
            end);
        end },
    { "I HATE Friday Night Funkin...", function(u138, u139) -- Line: 1774
            -- upvalues: playSound (copy)
            task.delay(2, function() -- Line: 1775
                -- upvalues: u138 (copy), u139 (copy), playSound (ref)
                if u138:GetAttribute("TipID") ~= u139 then
                    return;
                end;

                playSound(u138, "rbxassetid://119592417946062");
            end);
        end },
    { "MERCY MAFIA", function(u140, u141) -- Line: 1783
            -- upvalues: playSound (copy)
            task.delay(2, function() -- Line: 1784
                -- upvalues: u140 (copy), u141 (copy), playSound (ref)
                if u140:GetAttribute("TipID") ~= u141 then
                    return;
                end;

                playSound(u140, "rbxassetid://119592417946062");
            end);
        end }
};

local function add(p142) -- Line: 1792
    local l__tips = _tips;

    if type(p142) == "string" then
        table.insert(l__tips, p142);

        return;
    end;

    if type(p142) == "table" then
        for _, v in ipairs(p142) do
            table.insert(l__tips, v);
        end;
    end;
end;

return function(u143: userdata) -- Line: 1804
    -- upvalues: PolicyService (copy), BloxstrapRPC (copy), BadgeService (copy), playSound (copy)
    local u144 = {
        AllowedExternalLinkReferences = {}
    };
    pcall(function() -- Line: 1807
        -- upvalues: u144 (ref), PolicyService (ref), u143 (copy)
        u144 = PolicyService:GetPolicyInfoForPlayerAsync(u143);
    end);

    if BloxstrapRPC.AllowsWindowMovement then
        local v149 = {
            { "Check your window title", function(u145, u146) -- Line: 1815
                    -- upvalues: BloxstrapRPC (ref)
                    task.spawn(function() -- Line: 1816
                        -- upvalues: BloxstrapRPC (ref), u145 (copy), u146 (copy)
                        BloxstrapRPC.SetTitle("I\'m in your walls. Wake up.");

                        repeat
                            task.wait();
                        until u145:GetAttribute("TipID") ~= u146 or u145.Parent.Parent.Visible == false;

                        BloxstrapRPC.SetTitle("Project: Afternight");
                    end);
                end },
            { "3:", function(u147, u148) -- Line: 1828
                    -- upvalues: BloxstrapRPC (ref)
                    task.spawn(function() -- Line: 1829
                        -- upvalues: BloxstrapRPC (ref), u147 (copy), u148 (copy)
                        BloxstrapRPC.SetTitle("If you can read this, go take a shower");

                        repeat
                            task.wait();
                        until u147:GetAttribute("TipID") ~= u148 or u147.Parent.Parent.Visible == false;

                        BloxstrapRPC.SetTitle("Project: Afternight");
                    end);
                end }
        };
        local l__tips = _tips;

        if type(v149) == "string" then
            table.insert(l__tips, v149);
        elseif type(v149) == "table" then
            for _, v in ipairs(v149) do
                table.insert(l__tips, v);
            end;
        end;
    end;

    pcall(function() -- Line: 1842
        -- upvalues: BadgeService (ref), u143 (copy)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 2124766944) then
            local v150 = { "+now with more 10 hour bursts", "+xerroz plays here regularly maybe tell him hi ;p", "+its not a collab we just add each others\' items", "+jean not included", "+port not included", "+xerroz not included", "+that shopkeeper from IA is in heavy debt", "+Item Asylum Tip: You can 1-HP run most of the bosses using Legion Kata!" };
            local l__tips = _tips;

            if type(v150) == "string" then
                table.insert(l__tips, v150);

                return;
            end;

            if type(v150) == "table" then
                for _, v in ipairs(v150) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 1857
        -- upvalues: BadgeService (ref), u143 (copy), playSound (ref)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 2124851045) then
            local v154 = {
                "i sure regret getting on this elevator",
                "+how many floors have you\nsurvived in regretevator?",
                "Get Lampert to find another Lampert.",
                "+Flesh Cousin has entered the game.",

                function(u151, u152) -- Line: 1864
                    -- upvalues: playSound (ref)
                    local ImageLabel = Instance.new("ImageLabel");
                    ImageLabel.Parent = u151.Parent;
                    ImageLabel.Size = UDim2.fromScale(1, 1);
                    ImageLabel.Image = "rbxassetid://116459428434462";
                    ImageLabel.Visible = true;
                    ImageLabel.BackgroundTransparency = 1;
                    ImageLabel.ImageTransparency = 0;
                    local u153 = playSound(u151, "rbxassetid://125841338506368");
                    task.spawn(function() -- Line: 1875
                        -- upvalues: u151 (copy), u152 (copy), ImageLabel (copy), u153 (copy)
                        repeat
                            task.wait();
                        until u151:GetAttribute("TipID") ~= u152 or u151.Parent.Parent.Visible == false;

                        u151.Visible = true;
                        ImageLabel:Destroy();
                        u153:Destroy();
                    end);
                end
            };
            local l__tips = _tips;

            if type(v154) == "string" then
                table.insert(l__tips, v154);

                return;
            end;

            if type(v154) == "table" then
                for _, v in ipairs(v154) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 1889
        -- upvalues: BadgeService (ref), u143 (copy)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 2124877233) then
            local v155 = { "+the gem drop rate is low but you can still get them", "+sezei has a \"NORMAL\" sword which is just 3 times bigger than the sword", "dashing into people without a sword does more damage than with", "dashing without the sword causes the ability to regen faster" };
            local l__tips = _tips;

            if type(v155) == "string" then
                table.insert(l__tips, v155);

                return;
            end;

            if type(v155) == "table" then
                for _, v in ipairs(v155) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 1900
        -- upvalues: BadgeService (ref), u143 (copy), playSound (ref)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 2145915792) then
            local v157 = {
                { "there is a hidden behind you", function(u156) -- Line: 1905
                        -- upvalues: playSound (ref)
                        task.delay(2, function() -- Line: 1906
                            -- upvalues: playSound (ref), u156 (copy)
                            playSound(u156, "rbxassetid://2663254285");
                        end);
                    end },
                "The best way to survive as a Damned is to get a bow as soon as possible.\nWait wrong game.",
                "Well I\'ll be damned... *ba tum tsss*",
                "+Warning, heavily armoured hostile detected.",
                "+Warning, agent on your team is down.",
                "Do not provoke the sad boy.",
                "+How many times have you died on Night 1?",
                "+Random AK Scavenger Jumpscare",
                "+Random Sledgehammer Scavenger Jumpscare",
                "+RESIST THE INFLUENCE",
                "+TAME THE BEAST.",
                "Stay away from the Raiders\' castle, unless you want to meet an unfortunate fate.",
                "+ew vagabond main",
                "+ew survivalist main",
                "+ew damned main",
                "+ew lazarus main",
                "+ew zealot main",
                "+ew prophet main",
                "+ew sovereign main",
                "+ew mindflayer main",
                "+ew immolator main",
                "+ew arbiter main",
                "+ew executioner main",
                "+ew berserker main",
                "+ew drifter main",
                "+ew apostle main",
                "+ew artillerist main",
                "+ew riskrunner main",
                "+ew hivemind main",
                "+ew blitzer main",
                "+ew tickspider main",
                "+ew crosslink main",
                "As an Arbiter, for a \"Longshot\", press F again within a window of 0.46 seconds to 0.6 seconds of pressing F the first time. This will slightly lengthen the amount of time it takes for the shot to fire as a loud ringing sound plays along with a bright flash. The longshot has increased velocity, range, and area damage (90). The longshot also has significantly higher recoil, but it also does the same damage to the player if they are caught in the explosion.\nWait wrong game."
            };
            local l__tips = _tips;

            if type(v157) == "string" then
                table.insert(l__tips, v157);

                return;
            end;

            if type(v157) == "table" then
                for _, v in ipairs(v157) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 1947
        -- upvalues: BadgeService (ref), u143 (copy), playSound (ref)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 2124460084) then
            local v160 = {
                { "始末しに来た！", function(p158) -- Line: 1952
                        -- upvalues: playSound (ref)
                        playSound(p158, "rbxassetid://77995434394439");
                    end },
                "+Let\'s be honest, you only joined for the Item Asylum collab",
                "+Daratango is love, Daratango is life.",
                "+Joy will awaken soon...",
                "+lol look who died to Apostle at 0:01",
                "Some killers can bypass the Blue Relic",
                "Some killers can bypass the Cloak of Invisibility",
                "Do not touch the button.",

                function(p159) -- Line: 1964
                    p159.Text = "<font color=\"#005007\" face=\"Creepster\">BETRAYER</font>";
                    p159.RichText = true;
                end
            };
            local l__tips = _tips;

            if type(v160) == "string" then
                table.insert(l__tips, v160);

                return;
            end;

            if type(v160) == "table" then
                for _, v in ipairs(v160) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 1972
        -- upvalues: BadgeService (ref), u143 (copy)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 2124945579) then
            local v161 = { "+who do you main in phighting?", "+have you seen a max sword round yet?", "+slingshot my beloved", "+medkit my beloved", "+ew hyperlazer main" };
            local l__tips = _tips;

            if type(v161) == "string" then
                table.insert(l__tips, v161);

                return;
            end;

            if type(v161) == "table" then
                for _, v in ipairs(v161) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 1984
        -- upvalues: BadgeService (ref), u143 (copy)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 2130262856) then
            local v162 = { "+what faction did you choose in blox cards", "+Two-Legged!", "+hey have you seen a blue\ndemon girl around here?" };
            local l__tips = _tips;

            if type(v162) == "string" then
                table.insert(l__tips, v162);

                return;
            end;

            if type(v162) == "table" then
                for _, v in ipairs(v162) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 1994
        -- upvalues: BadgeService (ref), u143 (copy)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 4386627498091450) then
            local v163 = { "+haha bomb round go brr", "+something malicious may arise", "+go on, spend all your SEWH money on emotes.\nDo it." };
            local l__tips = _tips;

            if type(v163) == "string" then
                table.insert(l__tips, v163);

                return;
            end;

            if type(v163) == "table" then
                for _, v in ipairs(v163) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 2004
        -- upvalues: BadgeService (ref), u143 (copy)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 2150388951) then
            local v164 = { "+Viro was here", "+Theres an otter-shaped virus\nin your device", "+Viros fine hes just sleepy", "+You do not ask who Stitch is.", "+Collect my cheddars." };
            local l__tips = _tips;

            if type(v164) == "string" then
                table.insert(l__tips, v164);

                return;
            end;

            if type(v164) == "table" then
                for _, v in ipairs(v164) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 2016
        -- upvalues: BadgeService (ref), u143 (copy)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 2394984146566261) then
            local v168 = { function(p165) -- Line: 2019
                    p165.Text = "<font color=\"#9797CC\" face=\"Arcade\">For Blackrock!</font>";
                    p165.RichText = true;
                end, function(p166) -- Line: 2023
                    p166.Text = "<font color=\"#9797CC\" face=\"Arcade\">...I-I feel... cold...</font>";
                    p166.RichText = true;
                end, function(p167) -- Line: 2027
                    p167.Text = "<font color=\"#9797CC\" face=\"Arcade\">Do what you think is right.</font>";
                    p167.RichText = true;
                end };
            local l__tips = _tips;

            if type(v168) == "string" then
                table.insert(l__tips, v168);

                return;
            end;

            if type(v168) == "table" then
                for _, v in ipairs(v168) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 2035
        -- upvalues: BadgeService (ref), u143 (copy)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 2373714563391669) then
            local v175 = {
                function(p169) -- Line: 2038
                    p169.Text = "<font color=\"#FF0000\" face=\"Arcade\">N0 0NE C4N S4VE Y0U N0W!</font>";
                    p169.RichText = true;
                end,

                function(p170) -- Line: 2042
                    p170.Text = "<font color=\"#FF0000\" face=\"Arcade\">CHE4TER!!!</font>";
                    p170.RichText = true;
                end,

                function(p171) -- Line: 2046
                    p171.Text = "<font color=\"#FF0000\" face=\"Arcade\">L0L. U TH0UGHT.</font>";
                    p171.RichText = true;
                end,

                function(p172) -- Line: 2051
                    p172.Text = "<font color=\"#0C8A1B\" face=\"Arcade\">H3LP.. ME...</font>";
                    p172.RichText = true;
                end,

                function(p173) -- Line: 2055
                    p173.Text = "<font color=\"#0C8A1B\" face=\"Arcade\">MUST... K1LL...</font>";
                    p173.RichText = true;
                end,

                function(p174) -- Line: 2059
                    p174.Text = "<font color=\"#0C8A1B\" face=\"Arcade\">IF IM R3ALLY G0NNAㅤG0 OUT, THEN IM TAK1NG Y0U WITHㅤME.</font>";
                    p174.RichText = true;
                end
            };
            local l__tips = _tips;

            if type(v175) == "string" then
                table.insert(l__tips, v175);

                return;
            end;

            if type(v175) == "table" then
                for _, v in ipairs(v175) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 2067
        -- upvalues: BadgeService (ref), u143 (copy)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 832101721793665) then
            local v186 = {
                function(p176) -- Line: 2070
                    p176.Text = "<font color=\"#9E0000\" face=\"Arcade\">G I V E I N</font>";
                    p176.RichText = true;
                end,

                function(p177) -- Line: 2074
                    p177.Text = "<font color=\"#9E0000\" face=\"Arcade\">...{player}... {player}...</font>";
                    p177.RichText = true;
                end,

                function(p178) -- Line: 2078
                    p178.Text = "<font color=\"#9E0000\" face=\"Arcade\">CORRUPTION forms in the mouth of the HATEFUL.</font>";
                    p178.RichText = true;
                end,

                function(p179) -- Line: 2082
                    p179.Text = "<font color=\"#9E0000\" face=\"Arcade\">The air TINGLES with a looming sense of DREAD.</font>";
                    p179.RichText = true;
                end,

                function(p180) -- Line: 2086
                    p180.Text = "<font color=\"#2A0052\" face=\"Arcade\">Y-YOURE BEING USED!</font>";
                    p180.RichText = true;
                end,

                function(p181) -- Line: 2090
                    p181.Text = "<font color=\"#2A0052\" face=\"Arcade\">Is this... T-the end?</font>";
                    p181.RichText = true;
                end,

                function(p182) -- Line: 2094
                    p182.Text = "<font color=\"#FFC014\" face=\"Arcade\">Dolla Dolla Bills</font>";
                    p182.RichText = true;
                end,

                function(p183) -- Line: 2098
                    p183.Text = "<font color=\"#FFC014\" face=\"Arcade\">Master of a thousand hands! Thats me!</font>";
                    p183.RichText = true;
                end,

                function(p184) -- Line: 2102
                    p184.Text = "<font color=\"#121287\" face=\"Arcade\">Remember the time when...</font>";
                    p184.RichText = true;
                end,

                function(p185) -- Line: 2106
                    p185.Text = "<font color=\"#121287\" face=\"Arcade\">Theres nothing there...</font>";
                    p185.RichText = true;
                end
            };
            local l__tips = _tips;

            if type(v186) == "string" then
                table.insert(l__tips, v186);

                return;
            end;

            if type(v186) == "table" then
                for _, v in ipairs(v186) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 2114
        -- upvalues: BadgeService (ref), u143 (copy)
        if BadgeService:UserHasBadgeAsync(u143.UserId, 2127715318) then
            local v187 = { "+do you think doors\nfloor 3 will ever come out", "When Rush spawns in, you can also go\ninto another room to survive.", "+psst", "+LSPLASH says hi", "When Ambush spawns in, keep getting in and out the locker when\nthey\'re far away", "+Seek is coming, RUN!", "+Of course I remember my own name. That would be stupid to write it down. It’s not like I forgot my name or something. That would be dumb." };
            local l__tips = _tips;

            if type(v187) == "string" then
                table.insert(l__tips, v187);
            elseif type(v187) == "table" then
                for _, v in ipairs(v187) do
                    table.insert(l__tips, v);
                end;
            end;
        end;

        if BadgeService:UserHasBadgeAsync(u143.UserId, 70842463964644) then
            local v188 = { "Maybe check the ceiling next time...", "+Look! A Giggle", "+Look up there\'s a giggle above you" };
            local l__tips = _tips;

            if type(v188) == "string" then
                table.insert(l__tips, v188);
            elseif type(v188) == "table" then
                for _, v in ipairs(v188) do
                    table.insert(l__tips, v);
                end;
            end;
        end;

        if BadgeService:UserHasBadgeAsync(u143.UserId, 2817127966247970) then
            local v189 = { "+Did you like my cart ride?", "+Left or Right?", "+Left, Center or Right? Choose wisely or you\'ll get caught" };
            local l__tips = _tips;

            if type(v189) == "string" then
                table.insert(l__tips, v189);
            elseif type(v189) == "table" then
                for _, v in ipairs(v189) do
                    table.insert(l__tips, v);
                end;
            end;
        end;

        if BadgeService:UserHasBadgeAsync(u143.UserId, 2256123875769776) then
            local v190 = { "+Dread\'s Reaction" };
            local l__tips = _tips;

            if type(v190) == "string" then
                table.insert(l__tips, v190);

                return;
            end;

            if type(v190) == "table" then
                for _, v in ipairs(v190) do
                    table.insert(l__tips, v);
                end;
            end;
        end;
    end);
    pcall(function() -- Line: 2147
        -- upvalues: u143 (copy)
        if u143:IsInGroupAsync(33534924) then
            local v191 = { "+did u join that group because of the tip or smthn?", "+that one group is just a social experiment\nfeel free to destroy it lol" };
            local l__tips = _tips;

            if type(v191) == "string" then
                table.insert(l__tips, v191);

                return;
            end;

            if type(v191) == "table" then
                for _, v in ipairs(v191) do
                    table.insert(l__tips, v);
                end;
            end;
        else
            table.insert(_tips, "+did u hear about that group where everyone has all permissions active");
        end;
    end);

    return _tips;
end;