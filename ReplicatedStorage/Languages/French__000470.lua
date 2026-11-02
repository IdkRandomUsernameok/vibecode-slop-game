-- Decompiled with Potassium's decompiler.

return {
    Toggles = {
        On = "On",
        Off = "Off"
    },
    Sides = {
        Left = "Gauche",
        Right = "Droite"
    },
    StrumDirections = {
        Left = "Gauche",
        Down = "Bas",
        Up = "Haut",
        Right = "Droite",
        Square = "Carré",
        Left2 = "Gauche (2)",
        Down2 = "Bas (2)",
        Up2 = "Haut (2)",
        Right2 = "Droite (2)",
        rLeft = "Gauche (3)",
        rDown = "Bas (3)",
        rUp = "Haut (3)",
        rRight = "Droite (3)",
        Plus = "Plus",
        rLeft2 = "Gauche (4)",
        rDown2 = "Bas (4)",
        rUp2 = "Haut (4)",
        rRight2 = "Droite (4)"
    },
    RPC = {
        NowPlayingCensored = "Lecture en cours d\'une chanson! - [{playbackRate}x]",
        NowPlaying = "Lecture en cours de: {songName} [{diffName}] - [{playbackRate}x]",
        PlayingCensored = "Joue à une chanson! - [{playbackRate}x]",
        Playing = "Joue à: {songName} [{diffName}] - [{playbackRate}x]",
        InGame = "En jeu"
    },
    RatingStyles = {
        HL024 = {
            Whoops = "Oops..",
            Marvelous = "Merveilleux!!!",
            Sick = "Excellent!",
            Great = "Super!",
            Nice = "Nice!",
            Good = "Bien!",
            NotBad = "Pas mal",
            OK = "Okay"
        }
    },
    HUD = {
        JudgementCounter = "Merveilleux: {Marvelous}\nExcellent: {Sick}\nBien: {Good}\nOkay: {Ok}\nMauvais: {Bad}",
        Marvelous = "Merveilleux",
        Sick = "Excellent",
        Good = "Bien",
        Ok = "Okay",
        Bad = "Mauvais",
        Miss = "Faute",
        ExtraInfo = "MA: {ma}\nPA: {pa}\nMS: {mean}ms",
        PerfDisplay = "FPS: {fps}\nMémoire: {mem}\n\n",
        DebugDisplay = "Pas: {step}\nBattement: {beat}\nSection: {measure}\nSignature: {stepsPerBeat}/{beatsPerMeasure}\n\nBPM: {bpm}\nTemps: {timePos}\nNotes: {noteCache}+{splashCache}",
        ScoreLabelFormats = {
            Default = "Score: {score} | Fautes: {miss} | Précision: {acc}% ({judgement})",
            BaseGame = "Score: {score}",
            BaseGameNoOffset = "Score: {score}",
            BaseGameOMORI = "Score: {score}",
            BaseGameWithHPColor = "Score: {score}",
            BaseGameWithTimer = "Score: {score}",
            Corruption = "Score: {score}",
            DeadAir = "Score: {score}",
            EXEFightOrFlight = "Sacrifices: {miss} | Précision: {acc}% [{judgement}]",
            FunkinHELL = "Score: {score} | Notation: ({acc}%) - [{judgement}]",
            MariosMadness = "SCORE: {score}      FAUTES: {miss}      NOTATION: {judgement} [{acc}%]",
            MariosMadnessGB = "SCORE: {score}      FAUTES: {miss}      NOTATION: {judgement} [{acc}%]",
            MariosMadnessLuigi = "SCORE: {score}      FAUTES: {miss}      NOTATION: {judgement} [{acc}%]",
            RetrospecterNormal = "Score: {score} - Précision: {acc}% [{judgement}] - Combos brisés: {miss} - Combo: {combo}",
            RetrospecterCorrupt = "Score: {score} - Précision: {acc}% [{judgement}] - Combos brisés: {miss} - Combo: {combo}",
            LSE_Normal = "Score: {score} - Notation: {acc}% [{judgement}] - Combos brisés: {miss} - Combo: {combo}",
            LSE_DW = "Score: {score} - Notation: {acc}% [{judgement}] - Combos brisés: {miss} - Combo: {combo}",
            Forever = "Score: {score} • Précision: {acc}% [{judgement}] • Combos brisés: {miss} • Combo: {combo}",
            Brimstone = "Score: {score} • Précision: {acc}% [{judgement}] • Combos brisés: {miss} • Combo: {combo}",
            KadeEngine = "Score:{score} | Combos brisés:{miss} | Précision:{acc}% | ({judgement})",
            ProjectBlossom = "Score:{score} | Fautes:{miss} | Précision:{acc} % | ({judgement})",
            DDTO = "Score: {score} | Breaks: {miss} | Notation: {judgement} ({acc}%)",
            DDTOSTAGNANT = "Worth: {score} | Échecs: {miss} | Volonté: {acc}%",
            Troubleshootin = "SCORE: {score} | FAUTES: {miss} | PRÉCISION: {acc}% [{judgement}]"
        }
    },
    Judgements = {
        FC = "FC",
        GFC = "GFC",
        MFC = "MFC",
        PFC = "PFC",
        TPFC = "TPFC",
        SDP = "SDP",
        WF = "WF",
        BF = "BF",
        SDG = "SDG",
        SDO = "SDO",
        SDB = "SDB",
        MF = "MF",
        OMNI = "OMNI",
        SDCB = "SDCB",
        CLEAR = "CLEAR"
    },
    Gameplay = {
        Loading = {
            SoloMatch = "Match Solo",
            MultiplayerMatch = "Match multijoueur en {LCount}v{RCount}",
            ChartParsing = "Lectures de la chart...",
            ModchartLoading = "Ajout des modcharts...",
            ChartLoading = "Chargement de la chart...",
            SettingsLoading = "Chargement des paramètres...",
            AudioParsing = "Lectures des audios...",
            CharacterCreating = "Création des personnages...",
            BotCreating = "Création du bot...",
            EmoteCharCreating = "Création du spectateur...",
            MapLoading = "Chargement du fond...",
            AudioCaching = "Préchargement des audios...",
            ModchartStart = "Initialisation du contenu...",
            SingleplayerWaiting = "En attente du serveur...",
            OtherPlayersWaiting = "En attente des autres joueurs..."
        }
    },
    CreditsReplacements = {
        BGBy = "Fond par",
        BGsBy = "Fonds par",
        ChartedBy = "Charté par",
        ChartBy = "Chart par",
        IconBy = "Icône par",
        IconsBy = "Icônes par",
        AnimBy = "Animation par",
        AnimsBy = "Animations par",
        FacesBy = "Visages par",
        ModelBy = "Modèles par",
        ModelsBy = "Models par",
        SongBy = "Chanson par"
    },
    SongSelect = {
        CreditsHeader = "Crédits",
        HighscoreHeader = "Meilleur Score",
        SongStatsHeader = "Stats de la musique",
        DiffsHeader = "Difficultés",
        ModifiersHeader = "Modifieurs",
        SongRatesHeader = "Vitesse",
        SongModifiersHeader = "Modifieurs de musique",
        OtherVotesHeader = "Votes des autres joueurs",
        ModifiersApplyButton = "Appliquer",
        ModifiersClearButton = "Réinitialiser les modifieurs",
        PrefixReplacements = {
            NEW = "NOUV",
            UPDATED = "MÀJ",
            INDEV = "INDEV",
            COLLAB = "COLLAB"
        },
        SongSettings = {
            Rates = "Vitesse",
            CurrentRate = "Vitesse actuelle",
            PitchAudio = "Pitch audio",
            Modcharts = "Modcharts",
            Gimmicks = "Notes spéciales",
            Modifiers = "Modifieurs",
            Timing = "Timing (1-9)"
        },
        NothingSelected = "Sélectionne une musique !",
        SongStatsNoSelect = "Sélectionne une difficulté !",
        NoResultsFound = "Aucun résultat trouvé !",
        XResultsFound = "{resultAmmo:int} résultats trouvés !",
        SearchModsPlaceholder = "Rechercher des mods...",
        SearchSongsPlaceholder = "Rechercher des musiques...",
        PlayButton = "Jouer",
        SkipVoteButton = "Passer vote",
        CreditsBy = "Par: {creatorName}",
        CreditsFallback = "Aucun crédit trouvé...",
        CreditsFallbackAlt = "Crédits indisponibles !",
        CreditsFallbackAnotherAlt = "Crédits manquants !",
        UnknownModifier = "Modifieur inconnu",
        ModifierNoDesc = "Aucune description",
        TimeLeft = "Temps restant pour choisir : {timeLeft:int}",
        VoteSkipped = "Passé !",
        OtherVotesNone = "Aucun",
        MadeBy = "Créé par {creatorName}",
        AlsoCheckOut = "À découvrir aussi...",
        FailedCreator = "Impossible d\'obtenir le créateur !",
        FailedName = "Impossible d\'obtenir le nom !",
        OldHighscoreStat = "(Cette statistique provient d\'une version antérieure à U1, seules les données de FC étaient suivies, peu importe la difficulté)",
        HighscoreScore = "Score : {score:int}",
        HighscoreAccuracy = "Précision : {acc}%",
        HighscoreMisses = "Fautes : {misses:int}",
        HighscoreNotPlayed = "NON JOUÉ",
        SongInfo = {
            BPM = "BPM: {bpm}",
            Keycount = "NB de touches: {keycount}",
            Difficulty = "Difficulté: {rating}",
            Events = "À des évenements: {hasEvents}",
            Gimmicks = "À des notes spéciales: {hasGimmicks}",
            Modchart = "À une modchart: {hasModchart}",
            Map = "À un fond: {hasMap}",
            Length = "Durée: {timeLength}"
        },
        Stats = {
            PFCs = "PFCs: {count:int}",
            MFCs = "MFCs: {count:int}",
            GFCs = "GFCs: {count:int}",
            FCs = "FCs: {count:int} (U: {uniqueCount:int})",
            Wins = "Victoires: {count:int}",
            Losses = "Défaites: {count:int}",
            TotalPlayed = "Parties jouées: {count:int}"
        }
    },
    IconEditor = {
        TextBeingFiltered = "Filtrage...",
        IconNamePlaceholder = "mon icône cool",
        SettingNames = {
            ImageId = "ID de l\'image",
            IconCount = "Nombre d’icônes",
            Alpha = "Alpha",
            Offset = "Décalage",
            Color = "Couleur",
            Scale = "Échelle",
            IconSize = "Taille de l’icône",
            Facing = "Orientation",
            AutoFlip = "Retour automatique",
            Antialiasing = "Anticrénelage",
            ShowBounds = "Afficher les limites",
            EditColor = "Modifier"
        },
        IconAnims = {
            Overwinning = "Overwinning",
            Winning = "Winning",
            Idle = "Idle",
            Losing = "Losing",
            Overlosing = "Overlosing"
        },
        Headers = {
            IconName = "Nom de l’icône",
            Animations = "Animations",
            PreviewSide = "Côté d’aperçu"
        },
        SideFacing = {
            GameplayLeft = "Dad (Gauche)",
            GameplayRight = "BF (Droite)",
            TextureLeft = "Gauche (Icône BF)",
            TextureRight = "Droite (Icône Dad)"
        },
        Toolbar = {
            Cancel = "Annuler",
            Undo = "Annuler les modifications",
            Save = "Sauvegarder"
        }
    },
    NoteskinOverrides = {
        ReplaceNoteskin = "Remplacer le Noteskin du récepteur",
        ReplaceHoldsplash = "Remplacer le Holdsplash du récepteur",
        ReplaceNotesplash = "Remplacer le Notesplash du récepteur",
        ReplacingSelectedNoteskin = "Remplacement : {strumName} [Noteskin équipé]",
        ReplacingSelectedHoldsplash = "Remplacement : {strumName} [Holdsplash équipé]",
        ReplacingSelectedNotesplash = "Remplacement : {strumName} [Notesplash équipé]",
        ReplacingSelectedSkinName = "Remplacement : {strumName} [{skinName}]",
        ReplacingSelectedNone = "Remplacement : Aucun",
        ReplacingWith = "Avec : {skinName}",
        ReplacingWithNoneNoteskin = "Avec : Aucun (Sélectionne un Noteskin !)",
        ReplacingWithNoneHoldsplash = "Avec : Aucun (Sélectionne un Holdsplash !)",
        ReplacingWithNoneNotesplash = "Avec : Aucun (Sélectionne un Notesplash !)",
        StrumCategories = {
            All = "Tous",
            Default = "Flèches",
            Alts = "Flèches (Alt)",
            Boosts = "Boosts",
            BoostsAlt = "Boosts (Alt)",
            Specials = "Spéciaux"
        },
        Helper = {
            MainHeader = "\'C’est quoi ça ?\'",
            SubText = "Ceci est le menu de remplacement de noteskin. Ici, au lieu d’avoir le même noteskin sur chaque strum, tu peux faire en sorte qu’un strum charge un skin différent.",
            SubText2 = "Sélectionne un noteskin dans le menu de gauche, clique sur le strum où tu veux l’appliquer et clique sur \'Remplacer\' !",
            SubHeader = "Remplacement uniquement pour 4K, 5K, ...",
            SubTextForHeader = "Tu peux aussi le remplacer sur une seule touche en la sélectionnant dans le menu déroulant à côté du bouton fermer.",
            SubText2ForHeader = "Le paramètre \'Global\' dans le menu déroulant (sélectionné par défaut) remplace le noteskin sur chaque set de touches, mais les données dans les autres sets ne sont pas affectées ; il a juste une priorité plus élevée (un strum gauche remplacé dans Global se chargera à la place d’un strum gauche remplacé dans 4K).",
            SubHeader2 = "Que signifie un sprite en pointillés ?",
            SubTextForHeader2 = "Un sprite en pointillés signifie que le strum n’a pas de noteskin de remplacement et utilisera le noteskin équipé."
        },
        Toolbar = {
            ClearAll = "Tout effacer",
            ClearSelected = "Effacer la sélection",
            Replace = "Remplacer"
        }
    },
    Shop = {
        PackItem = "{packName} (Pack)",
        CreditsBy = "Par : {creatorName}",
        UnlockedDefault = "Débloqué par défaut.",
        SearchFor = "Rechercher...",
        SelectPackForInfo = "[CLIQUE SUR UN PACK POUR VOIR PLUS D’INFOS]",
        RequirementsJoin = "{song1}, {song2}",
        RequirementsJoinEnding = "{song1} ou {song2}",
        AnySongRequirement = "n’importe quelle musique",
        AnyModRequirement = "n’importe quel mod",
        AnyDiffRequirement = "n’importe quelle difficulté",
        UnlockRequirement = "Bats {songList} de {modList} en {difficultyList}.",
        ExtraRequirement = "{accuracyNeeded:int}% de précision, vitesse 1x ou plus, modcharts et notes spéciales activés",
        DailyUnlockRequirement = "Débloqué aléatoirement via une quête quotidienne.",
        BadgeUnlockRequirement = "Débloqué avec le badge {badgeName} dans {gameName}.",
        UnselectedItemTitle = "?",
        UnselectedItemCredits = "Par : ?",
        UnlockCriteria = "Critères de déblocage",
        AnimHasAlts = "Animations alternatives • {hasState}",
        AnimHasEvents = "Animations d’événement • {hasState}",
        NewItemStandout = "NOUVEAU",
        UpdatedItemStandout = "MIS À JOUR",
        EquipItem = "EQUIPER",
        EquippedItem = "EQUIPÉ",
        BotEquipItem = "EQUIPER (Bot)",
        BotEquippedItem = "EQUIPÉ (Bot)",
        LockedItem = "VERROUILLÉ",
        AnimationSettings = {
            PreviewHeader = "Aperçu de l’animation",
            PreviewSide = "Côté de prévisualisation",
            PreviewAlt = "Variante d’aperçu",
            Rotation = "Rotation",
            SettingsHeader = "Paramètres d’animation",
            UseReqProps = "Utiliser les props requis",
            UseProps = "Utiliser les props",
            UseFaces = "Utiliser les visages"
        },
        Tabs = {
            Animations = "Animations",
            Emotes = "Emotes",
            Noteskins = "Noteskins",
            Notesplashes = "Notesplashes",
            Holdsplashes = "Holdsplashes",
            Icons = "Icônes",
            Tags = "Tags",
            Banners = "Bannières"
        },
        SpecialUnlockRequirements = {
            Gambler = "Obtenu aléatoirement en terminant une musique avec 0.1 % de chance."
        }
    },
    Topbar = {
        Settings = "Paramètres",
        Shop = "Magasin"
    }
};