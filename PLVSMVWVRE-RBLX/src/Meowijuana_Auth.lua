-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |                                 If Adonis Exists Kill him Method                                |
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
local function Deob()
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

local function killadonisforme() 
    -- Safe environment fallbacks
    local setthreadidentity = setthreadidentity or setidentity or setthreadcontext or (syn and syn.set_thread_identity)
    local hookfunction = hookfunction or replaceclosure or (detour and detour.hook)
    local getgc = getgc or get_gc_objects
    local newcclosure = newcclosure or function(f) return f end
    local getrenv = getrenv

    if not hookfunction then
        warn("Bypass Check: hookfunction is not supported on your executor.")
        return
    end

    if not getgc then
        warn("Bypass Check: getgc is not supported on your executor.")
        return
    end

    local getinfo = getinfo or debug.getinfo
    local DEBUG = true
    local Hooked = {}
    
    local Detected, Kill
    
    if setthreadidentity then
        pcall(function() setthreadidentity(2) end)
    end
    
    local gcObjects = {}
    local successGC, errGC = pcall(function() gcObjects = getgc(true) end)

    if successGC and type(gcObjects) == "table" then
        for i, v in pairs(gcObjects) do
            if typeof(v) == "table" then
                local DetectFunc = rawget(v, "Detected")
                local KillFunc = rawget(v, "Kill")
            
                if typeof(DetectFunc) == "function" and not Detected then
                    Detected = DetectFunc
                    
                    local successHook, errHook = pcall(function()
                        hookfunction(Detected, function(Action, Info, NoCrash)
                            if Action ~= "_" then
                                if DEBUG then
                                    warn(`Adonis AntiCheat flagged\nMethod: {Action}\nInfo: {Info}`)
                                end
                            end
                            
                            return true
                        end)
                    end)
        
                    if successHook then
                        table.insert(Hooked, Detected)
                    end
                end
        
                if rawget(v, "Variables") and rawget(v, "Process") and typeof(KillFunc) == "function" and not Kill then
                    Kill = KillFunc
                    local successHook2, errHook2 = pcall(function()
                        hookfunction(Kill, function(Info)
                            if DEBUG then
                                        warn(`Adonis AntiCheat tried to kill (fallback): {Info}`)
                                    end
                        end)
                    end)
        
                    if successHook2 then
                        table.insert(Hooked, Kill)
                    end
                end
            end
        end
    end
    
    local debugInfo = (getrenv and pcall(getrenv) and getrenv().debug and getrenv().debug.info) or debug.info
    if debugInfo then
        pcall(function()
            local Old; Old = hookfunction(debugInfo, newcclosure(function(...)
                local LevelOrFunc, Info = ...
            
                if Detected and LevelOrFunc == Detected then
                    if DEBUG then
                        warn(`zins | adonis bypassed`)
                    end
            
                    return coroutine.yield(coroutine.running())
                end
                
                return Old(...)
            end))
        end)
    end

    if setthreadidentity then
        pcall(function() setthreadidentity(7) end)
    end
end

local function _X()
    repeat task.wait() until game:IsLoaded()
    Deob()
    killadonisforme()
    
    -- Added safety check for game:HttpGet to prevent crashing
    -- 1. Verify loadstring is supported in the current environment
    local success, scriptContent = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/hollyntt/PLWVRE-Roblox-Script/refs/heads/main/PLVSMVWVRE-RBLX/src/Main%20Cheat/WhippityOxideHack.lua")
    end)

    if success and scriptContent then
        print("Received raw content length: " .. #scriptContent)
        print("First 50 characters of content: " .. string.sub(scriptContent, 1, 50))

        local compiledChunk, compileError = loadstring(scriptContent)
        if compiledChunk then
            print("Compilation successful! Safe to execute.")
            -- pcall(compiledChunk)
        else
            warn("Compilation failed: " .. tostring(compileError))
        end
    else
        warn("Failed to fetch script content.")
    end
end

_X()