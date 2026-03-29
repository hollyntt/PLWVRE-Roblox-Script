-- // PLVSMVWVRE. \\ -- 
-- // Etc Functionality | B4 loading \\ --
local Requirement = 0
local RequiredUNC = 70, 0, 0
local UNCRecieved, UNCMissed, UNCUndefined = 0, 0, 0 
local UNCTestFinished = false
local originalPcall = pcall
local BetaBuild = true

-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |                                         Hooking Method                                          |
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

local function hookedPcall(func, ...)
    local threadId = tostring(coroutine.running()):match("0x%x+")
    print(`🚀 pcall started in thread {threadId}`)
    
    local startTime = os.clock()
    local success, result = originalPcall(func, ...)
    local duration = os.clock() - startTime
    
    if success then
        print(`✅ pcall succeeded in {math.floor(duration*1000)}ms`)
    else
        print(`❌ pcall failed after {math.floor(duration*1000)}ms`)
        print(`⚠️ Error: {result}`)
        print("Call stack:\n"..debug.traceback())
    end
    
    return success, result
end

-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |                                             MENU                                                |
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

local function PLVSMVWVRE_Menu()
    art = [[

                                                                                                  
                                            @              @@                                     
                                             @@.  @    @@@@@@.                                    
                             @@@     @@@@@@@@@@@@@ @@@@@@@@@@:                                    
                              @@@@@@@@@@ @@@@@@@@@@@@@@@@@ @@                                     
                               @ @@@@@@@@@@ @@@@@@@@@@@@@ @@@                                     
                               @@ @@ @@@@@@@@ @@@@@@@@@@@@@@@                                     
                                 @@  @@@@@@@@@@@@:@@@@@@@@ @                                      
                                  .@@@@@   @@@@@ @    @@@@       .-         @@  @@                
                                   @@@@@@   @@@@@    @@@ @.      @@@@@@@@@@@                      
                                      @@@@@@@@@@  @@@@@@- @@@@@@@@@@@@@@@ .                       
                                     @@@ @@         @ .@@.  @@@@@@@@@@@                           
                                     @       @@@@@           @@@@@@@@@@@                          
                                         @@@@@@@@                   @@@@@@     @@                 
                        .@@@@   ....... @@@@@@@@@@                     @@@@@@@@@@                 
                    @@=@@@@@@@  ....... @@@@@@@      @           @       @@@@@@@@@@               
                    .@*@.@@@@ .  ......         .       @    @@@@@@@@@@@@@@@@@@@@@@@@             
                      @@-@#.    .  .............. @ ...  @  @@@@@@@@@@@@@@@@@.@     .@            
                      @ @ @.   @ @ .............. @  ...  .     @@@@                 .@           
                       @@ %.    @      ...     .     ....  @     @@@@@@              @            
                        @@ @   @  @  @..... @           ..   @@@@@@@       @@@                    
                         -=@           ....     @     @        @@@@@@@@@@@@@@@@@@@                
                     @%@ @@@@   .....   ......     @ @@@@@@@ .    .@@  ..@@       .               
                   @. :@%@  . @ ..    @ ......        @@@#@@    @   @@@@@@@@                      
                 @= @.@@           .@      ..  .    -@@@ @@@  @@    @@@@@@@@@                     
                  @    @@@@@@  .@@@      @ ..      %=@ @@.@ .@@@   @@      @@@@                   
                      @@@@@@@@@  @@@@@@@.         @ @#@*+   @@@@ @@@@@ @@@   @@@@                 
                      @@@@@@@@@@ @@@@#@@@@@   @  *+%=%-     @@@@@@@@@ @@@@@    @@@@@     .        
                      @@@@@@@@@ @   @@@ @@@@@@@@%+          @@@@   @  @@@@@@ @@@@@@@@@@@@         
                       @@@@@@@@@@  @@@@@@@@@@ + @          @@     @@@     .       @@              
                       @@@@@@@@@@   @*@:@@@@@@ @@         @@@@@@@@@@@       @@                    
                       @@@@@@@@@@   .@@@@@@@@@@=@ @@.       @@@@@  @  @@@@@@@@                    
                       @@@@@@@@@@.   @@@@@@@@@@   @@@@@@    @@@@@       @@@@@@                    
                       @@@@@@@@@@.   .@@@@@@@@@@@@= @@@@@@@@@@@@@@@@      @@@ @@                  
                       .@@@@@@@*@@    @@@%@@@@@@@@+@@@@@@@.@@@@@@@@@@@   .   @@@@                 
                        @@@@@@@@@@     @@@@@@@@@@     @@@@@@=@@@@@@@@@@@ @ @@@@@@@                
                        @@@@@@@@@@      @@@@@@@@@@        @@@#@@@@@@@@@@ .    @@@@@@@             
                        @@@@@@@@@@@     @@@@@@@@@@@      ..                    @@@  @@            
                        @@@@@@@@@@@      @@@@@@@@@@@       @@@@@@@@@@@@@@@ ..  @@    .@           
                        @@@@@@@@@:@.      @@@@@@@@@@@     @@@@@@@@@@@@@@@@@@@@@@                  
                         @@ @@@@@@@@      @@@@@@+@@@@@   @  @@@@@@@@.        @@@                  
                         @@  @@:@@@@       @@@@@@@@@@@@ @   @@@ .@@@@          @                  
                         @@@@ @=@ #@.       @@@-@ @  @ @ @   @@    @@         @@@@@@              
                             @@@@-@ @       @@@@@=#@@ @@@   @@@@    @@@     @@@      @            
                          @@ @ @ @@@         @@@@@@- :@- @  @@@@@@@@@@@@@@@@@@                    
                          @  @  # @ @@       @-@ = *@.@  @@@@@@@@@ .@@@@   @@                     
                         -.@*@@@@ @  @        ==@ @%. ..@@  @          @                          
                        @  .@ @ %@@@  @       .@@  -%@ #@ @@ =                                    
                       *@  @ . -   @@*@        @#@ #@:.@@ @@ @ @                                  
                        .@@%-@-+@@@. @@         :.@%.@%%+*@ +@#@@                                 
                      @    @  +    .             @.  -    @#.  .@                                 
                                                        @  @                                      
                                                                                                  
                                                        ]]

    -- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    -- |                                           REQUIREMENTS                                          |
    -- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    local function getCurrentDateTime() return os.date("%m/%d/%Y | %H:%M:%S") end
    local function getCurrentTime() return os.date("%m/%d/%Y | %H:%M:%S") end
    local MarketplaceService = game:GetService("MarketplaceService")
    local RunService = game:GetService("RunService")
    local HttpService = game:GetService("HttpService")
    local UserInputService = game:GetService("UserInputService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Stats = game:GetService("Stats")
    local Workspace = game:GetService("Workspace")
    local starterCharacterScripts = game.StarterPlayer.StarterCharacterScripts
    local player = game.Players.LocalPlayer
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local Username = Players.LocalPlayer.DisplayName
    local p = Players.LocalPlayer
    local TextChatService = game:GetService("TextChatService")
    local mouse = player:GetMouse()
    local ts = game:GetService("TeleportService")
    local char = player.Character or player.CharacterAdded:Wait() or nil
    local camera = Workspace.CurrentCamera
    local Humanoid = char and char:FindFirstChild("Humanoid") or nil
    local Action = false
    local shooting = false
    local spinSpeed = 20
    local antifling = false
    local flySpeed = 50 -- Base fly speed
    local rootPart = char:WaitForChild("HumanoidRootPart")
    local PlaceId = game.PlaceId
    local JobId = game.JobId
    local char, rootPart, Humanoid
    local flyForce, flyConnection

    local ExecName = identifyexecutor()
    local SoundIDHM = 5794214857;
    local SoundIDK = 5764885315;
    local TargetFling = "nil"
    local Namecall
    local playerNames = {}
    local currentIndex = 1
    local disabledwarning = "Disabled (Until further notice)"
    local UNCwarning = "Low UNC\n(Script Requires 70+) (Features might be unstable)"
    local testwarning = "In-Testing\n(Features might be unstable)"
    local Camera
    local lastKilledTarget     -- Track the last killed target
    local trackedTarget        -- Track the currently monitored target
    local initialHealth        -- Track the target's initial health
    local no = true
    local originalCFrame = nil
    local originalY = nil
    local ARE_YOU_DONE = true
    local currentRotation = 0
    local EventConnections = {}
    local KillCount = 0
    local OVERKillCount = 0
    local blacklisted = {"AnnaBypasser", "SurpWare", "-net", "-gh", "/cmds", ".cmds", "/e", "-re", "CONTROLBOTZ!", "#", "[TOOL GIVER]"}

    -- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    -- |                                           SETTINGS                                              |
    -- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    local SKELETON_SETTINGS = {
        -- Visual Settings
        Color = Color3.fromRGB(255, 255, 255),
        Size = 15,
        Transparency = 1,
        AutoScale = true,
        Enabled = true
    }
    local NAMETAG_CONFIG = {
        NAME = "",
        NAMEPLATE_TAG = "",
        NAMEPLATE_COLOR = Color3.fromRGB(255, 255, 255)
    }    
    local Anticheat_Settings = {
        FLOOR_DETECTION_THRESHOLD = 3, -- Time in seconds before flagging for not touching the ground
        FLY_VELOCITY_THRESHOLD = 1,   -- Minimum vertical velocity threshold to detect flying
        FLY_DETECTION_THRESHOLD = 1,   -- Time in seconds before flagging for flying
        SPEED_THRESHOLD = 16,          -- Maximum allowed speed (magnitude of velocity)
        JUMP_THRESHOLD = 75,           -- Maximum allowed jump power
        TELEPORT_THRESHOLD = 1.5,       -- Maximum allowed distance per frame
        VELOCITY_CHANGE_THRESHOLD = 75, -- Maximum allowed velocity change per frame
        MAX_SPIKES = 1,                -- Number of spikes before flagging
        SPIN_DETECTION_THRESHOLD = 50, -- Radians per second.  Adjust as needed.
        HOOK_DISTANCE_THRESHOLD = 1.0, -- Distance to consider a player "hooked"
        HOOK_DURATION_THRESHOLD = 5, -- Seconds hooked before triggering
        MIN_MESSAGE_INTERVAL = 0.1,
        REPORT = false,
        PARDONED = false;
    } 
    local ExtraVisuals = {
        FOV = 70,
        PlayerTransparency = 0,
    }
    local ChamsAdjustments = {
        Enabled = false,
        TeamCheck = false, -- Enable team checking
    
        OutlineColor = Color3.fromRGB(0, 0, 0),
        OutlineTransparency = 0,
    
        FillColor = Color3.fromRGB(0, 0, 0),
        FillTransparency = 0,
    
        -- Add the visibility check toggle
        CheckVisibility = true, 
    }
    local Aimbot = {
        -- Main
        Enabled = false, -- Enable or disable the aimbot
        Hitbox = "", -- Specify the hitbox to aim at (e.g., "Head", "Torso")
        CheckVisibility = false, -- Set this to false to disable the wall check
        CheckAlive = false, -- Set this to false to disable the alive check
        CheckForcefield = false, -- Set this to false to disable the forcefield check
        Smoothing = 0, -- Set this to scale the smoothness (0 = instant snap, 1 = no movement)
        Prediction = false, -- Set this to false to disable prediction
        TeamCheck = false, -- Set this to false to disable Team Checking
        Prediction_Offset = 0, -- Set this to scale the prediction offset
        Distance = 0, -- Set this to scale the distancing
        Triggerbot_Sensitivity = 10, -- Set this to scale the Triggerbot
        AutoShoot = false,
        AutoShoot_Delay = 0,
        Resolver = false,
            ResolverHistory = 0.5, -- seconds of history to keep
            MaxPredictionError = 2.0, -- maximum allowed error in studs
            VelocitySmoothing = 0.7, -- blend factor for velocity smoothing (0-1)
            DesyncDetection = true, -- enable desync detection

            JitterThreshold = 0.15, -- velocity change threshold for jitter detection
            MinPredictionConfidence = 0.1, -- minimum confidence level
    
        -- FOV Settings
        FOVRadius = 0, -- Set this to scale the radius of the FOV (in pixels)
        FOVCheck = false, -- Set this to false to disable the FOV check
        FOVColor = Color3.fromRGB(255, 255, 255), -- Color of the FOV circle
        FOVThickness = 0, -- Thickness of the FOV circle
        FOVVisible = false, -- Whether the FOV circle is visible
        FOVTransparency = 0, 
        FOVSides = 0, 
    }
    local RCS_Sets = {
        Enabled = false, -- Enable or disable the aimbot
        RecoilControl = 10,
        RecoilDownAim = 1000,
        Speed = 5,
    }
    local Crosshair = {
        -- Main
        Enabled = false, -- Enable or disable the crosshair
        Sides = 4, -- Number of sides (e.g., 4 for a cross, 3 for a triangle, etc.)
        Size = 15, -- Size of the crosshair
        Color = Color3.fromRGB(255, 255, 255), -- Color of the crosshair
        Transparency = 0, -- Transparency of the crosshair (0 = fully visible, 1 = fully transparent)
        Rotation = 0, -- Rotation of the crosshair in degrees
        Thickness = 2, -- Thickness of the crosshair lines
        Gap = 4, -- Gap between the lines in the crosshair
        x_Off = 0,
        y_Off = 0,
    }
    local AntiAim = {
        Activated = false, -- How do i get him off this mad anti aim
        Jitter = 0.5, -- The jitter amount of that mad anti aim
        Jitter_X = 0.5, -- The jitter (X) amount of that mad anti aim
        Jitter_Z = 0.5, -- The jitter (Z) amount of that mad anti aim
        SpinSpeed = 10, -- Speed of spinning (degrees per frame)
        SpinDirection = 1, -- 1 for right, -1 for left
        SpinSwitchInterval = 180, -- Angle at which to switch direction (e.g., every 180 degrees)
    }
    local ChatSpammerrr = {
        Activated = false,
        Mode = 0
    }
    local Orbiter_Settings = {
        Target = "TargetPlayerName",
        Height = 5,
        BaseRadius = 8,  -- Base distance
        BaseSpeed = 2,   -- Base speed
        Speed = 2,       -- Current speed (can be modified)
        Smoothness = 0.2,
        MaxSpeed = 50,
        RadiusScale = 1.5  -- How much radius increases with speed
    }
    -- ================ MELONLOADER TYPE CONSOLE CONFIGURATION ================
    local COLORS = {
        RESET = "\27[0m",
        GRAY = "\27[90m",
        RED = "\27[31m",
        GREEN = "\27[32m",
        YELLOW = "\27[33m",
        BLUE = "\27[34m",
        MAGENTA = "\27[35m",
        CYAN = "\27[36m",
        WHITE = "\27[37m",
        BG_RED = "\27[41m"
    }
    
    -- ================ CORE FUNCTIONS ================
    local function validateMessage(input)
        return tostring(input or "nil message received")
    end 
    local function safeNotify(message)
        pcall(function() Library:Notify(message) end)
    end
    local function consolePrint(color, tag, message)
        rconsoleprint(
            COLORS.GRAY.."["..os.date("%H:%M:%S").."]"..
            color.." [PLVSMVWVRE | "..tag.."] "..
            COLORS.RESET..validateMessage(message).."\n"
        )
    end
    
    -- ================ NOTIFICATION API ================
    function Notificate(color, i)
        if not i then -- Handle single-argument usage
            i = color
            color = COLORS.WHITE
        elseif COLORS[color] then -- Handle color string
            color = COLORS[color]
        end
        -- Else assume color is already an ANSI code
        
        safeNotify(i)
        consolePrint(color, "INFO", i)
    end
    function Warning_Notificate(i)
        safeNotify(i)
        consolePrint(COLORS.YELLOW, "WARNING", i)
    end
    function Err_Notificate(i)
        safeNotify(i)
        consolePrint(COLORS.BG_RED..COLORS.WHITE, "ERROR", i)
    end
    function Success_Notificate(i)
        safeNotify(i)
        consolePrint(COLORS.GREEN, "SUCCESS", i)
    end
    
    -- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    -- |                                           FUNCTIONS                                             |
    -- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    
    repeat Camera = Workspace.CurrentCamera task.wait() until Camera
    local function GetScreenCenter() local ScreenSize = Camera.ViewportSize return Vector2.new(ScreenSize.X / 2, ScreenSize.Y / 2) end
    local FOVCircleOutline = Drawing.new("Circle")
    local FOVCircleInnerOutline = Drawing.new("Circle")
    local FOVCircle = Drawing.new("Circle")

    local initialPlayerStats = {}
    local timeSinceLastFloor = {}
    local flyingTime = {}
    local playerFlags = {}  -- Store exploit flags (FLYING, SPEED, etc.)
    local lastRotations = {}
    local playerChatHistory = {} -- { [player] = { {timestamp, message}, ... } }
    local playerMuteTimers = {}  -- { [player] = endTime }
    local hookTimers = {} -- { [player] = {target = otherPlayer, startTime = tick()} }
    local chatLogs = {}

    local playerWalkspeedCache = player.Character.Humanoid.WalkSpeed
    local playerJumpPowerCache = player.Character.Humanoid.JumpPower

    local orbitOffset = math.random() * 2 * math.pi
    local screenGui, cursorFrame, crosshairFrame
    local cursorLines = {}
    
    function Nametags()
        -- This makes the name tag
        local function createBillboardGui(character)
            local head = character:FindFirstChild("Head")
            if not head then return end
        
            -- Remove existing billboard if it exists
            local existingBillboard = head:FindFirstChild("SentinelBillboard")
            if existingBillboard then
                existingBillboard:Destroy()
            end
        
            -- Only create billboard if it's the selected player
            if character:FindFirstChildOfClass("Humanoid") and character:FindFirstChildOfClass("Humanoid").Parent.Name == NAMETAG_CONFIG.NAME then
                local billboardGui = Instance.new("BillboardGui", head)
                billboardGui.Name = "SentinelBillboard"
                billboardGui.Active = true
                billboardGui.MaxDistance = 99999
                billboardGui.ExtentsOffsetWorldSpace = Vector3.new(0, 4, 0)
                billboardGui.Size = UDim2.new(0, 180, 0, 50)
                billboardGui.ClipsDescendants = true
                billboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
                local frame = Instance.new("Frame", billboardGui)
                frame.BorderSizePixel = 0
                frame.BackgroundColor3 = Color3.fromRGB(69, 69, 69)
                frame.Size = UDim2.new(0, 170, 0, 42)
                frame.Position = UDim2.new(0, 5, 0, 5)
                frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                frame.ClipsDescendants = true
        
                local corner = Instance.new("UICorner", frame)
                corner.CornerRadius = UDim.new(0, 14)
        
                local stroke = Instance.new("UIStroke", frame)
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Thickness = 1.2
                stroke.Color = NAMETAG_CONFIG.NAMEPLATE_COLOR
        
                local nameLabel = Instance.new("TextLabel", frame)
                nameLabel.Text = NAMETAG_CONFIG.NAMEPLATE_TAG
                nameLabel.TextWrapped = true
                nameLabel.BorderSizePixel = 0
                nameLabel.TextSize = 16
                nameLabel.BackgroundTransparency = 1
                nameLabel.FontFace = Font.new([[rbxassetid://12187365977]], Enum.FontWeight.Medium, Enum.FontStyle.Normal)
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.Size = UDim2.new(0, 170, 0, 42)
                nameLabel.Position = UDim2.new(0, 10, 0, -1.3)
        
                local crownLabel = Instance.new("TextLabel", frame)
                crownLabel.Text = "->"
                crownLabel.BorderSizePixel = 0
                crownLabel.TextSize = 20
                crownLabel.BackgroundTransparency = 1
                crownLabel.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                crownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                crownLabel.Size = UDim2.new(0, 45, 0, 40)
                crownLabel.Position = UDim2.new(0, 2, 0, 0)
        
                local shadowHolder = Instance.new("Frame", frame)
                shadowHolder.ZIndex = 0
                shadowHolder.Size = UDim2.new(1, 0, 1, 0)
                shadowHolder.Position = UDim2.new(0, 0, -0.05, 0)
                shadowHolder.Name = "shadowHolder"
                shadowHolder.BackgroundTransparency = 1
        
                local umbraShadow = Instance.new("ImageLabel", shadowHolder)
                umbraShadow.ZIndex = 0
                umbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)
                umbraShadow.ScaleType = Enum.ScaleType.Slice
                umbraShadow.ImageTransparency = 0.86
                umbraShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
                umbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
                umbraShadow.Image = [[rbxassetid://1316045217]]
                umbraShadow.Size = UDim2.new(1, 3, 1, 3)
                umbraShadow.BackgroundTransparency = 1
                umbraShadow.Name = "umbraShadow"
                umbraShadow.Position = UDim2.new(0.5, 0, 0.5, 2)
        
                local penumbraShadow = Instance.new("ImageLabel", shadowHolder)
                penumbraShadow.ZIndex = 0
                penumbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)
                penumbraShadow.ScaleType = Enum.ScaleType.Slice
                penumbraShadow.ImageTransparency = 0.88
                penumbraShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
                penumbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
                penumbraShadow.Image = [[rbxassetid://1316045217]]
                penumbraShadow.Size = UDim2.new(1, 3, 1, 3)
                penumbraShadow.BackgroundTransparency = 1
                penumbraShadow.Name = "penumbraShadow"
                penumbraShadow.Position = UDim2.new(0.5, 0, 0.5, 2)
        
                local ambientShadow = Instance.new("ImageLabel", shadowHolder)
                ambientShadow.ZIndex = 0
                ambientShadow.SliceCenter = Rect.new(10, 10, 118, 118)
                ambientShadow.ScaleType = Enum.ScaleType.Slice
                ambientShadow.ImageTransparency = 0.88
                ambientShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
                ambientShadow.AnchorPoint = Vector2.new(0.5, 0.5)
                ambientShadow.Image = [[rbxassetid://1316045217]]
                ambientShadow.Size = UDim2.new(1, 3, 1, 3)
                ambientShadow.BackgroundTransparency = 1
                ambientShadow.Name = "ambientShadow"
                ambientShadow.Position = UDim2.new(0.5, 0, 0.5, 2)
            end
        end
        
        -- Change username to who you want the tag to show above
        local function monitorPlayer(player)
            player.CharacterAdded:Connect(function(character)
                createBillboardGui(character)
            end)
        
            if player.Character then
                createBillboardGui(player.Character)
            end
        end
        
        -- Remove billboards from all players first
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then
                local head = player.Character:FindFirstChild("Head")
                if head and head:FindFirstChild("SentinelBillboard") then
                    head.SentinelBillboard:Destroy()
                end
            end
        end
        
        -- Then set up monitoring for all players
        for _, player in ipairs(Players:GetPlayers()) do
            monitorPlayer(player)
        end
        
        Players.PlayerAdded:Connect(monitorPlayer)
        
        if namt then
            namt:Disconnect()
            namt = nil
        end
        namt = RunService.RenderStepped:Connect(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character then
                    createBillboardGui(player.Character)
                end
            end
            task.wait(1)
        end)
    end
    
    function ChatSpammer()
        getgenv().Mode1 = {
            ":3\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "You're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "TEH EPIK DUCK IS COMING!!!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "<(0_0<) <(0_0)> (>0_0)> KIRBY DANCE\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "GET OFF MAH LAWN\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "all your base are belong to me!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "ROFL\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "1337\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "Muahahahaha!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "z0mg h4x!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "ub3rR0xXorzage!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "w00t!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "i r teh pwnz0r!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "Use the Chat menu to talk to me.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "I can only see menu chats\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\nPLVSMVWVRE.lol's Rebirth is happening!\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\nPLVSMVWVRE.lol's Rebirth is happening!\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\nPLVSMVWVRE.lol's Rebirth is happening!\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n<3\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\nPLVSMVWVRE.lol's Rebirth is happening!\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\nPLVSMVWVRE.lol's Rebirth is happening!\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\nPLVSMVWVRE.lol's Rebirth is happening!\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\nPLVSMVWVRE.lol's Rebirth is happening!\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\nPLVSMVWVRE.lol's Rebirth is happening!\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\nPLVSMVWVRE.lol's Rebirth is happening!\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\nkemonohooks\n\n\n\n\n\n\n\n\n\n\n\n\nkemonohooks\n\n\n\n\n\n\n\n\n\n\n\n\nkemonohooks\n\n",
            "\n\n\n\n\n\nkemonohooks\n\n\n\n\n\n\n\n\n\n\n\n\nkemonohooks\n\n\n\n\n\n\n\n\n\n\n\n\nkemonohooks\n\n",
            "\n\n\n\n\n\nkemonohooks\n\n\n\n\n\n\n\n\n\n\n\n\nkemonohooks\n\n\n\n\n\n\n\n\n\n\n\n\nkemonohooks\n\n"
        }

        getgenv().Mode2 = {
            "[=== kEm+nohOoks.c+m ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kemxnohOxks.c== ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kEm+nohooks.=== ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kEmonoho======= ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kEmon========== ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kE============= ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== =============== ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kE-============ ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kEmOn|========= ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kEmOnOho/====== ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kEmOnOho/====== ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kEmonoh0oks.*== ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kemOnOhoOks.cO= ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kemOnOhoOks.c+m ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "[=== kemOnxhoOks.c+m ===]",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        }

        getgenv().Mode3 = {
            "You like that?",
            "Im so close",
            "hehe",
            "Your a cutie yk",
            "Luv",
            "ab to goon",
            "huge",
            "ah~",
            "ur railing me",
            "OOOOOOOOOOOOOO",
            "IM BLOWING!",
            "i like it ROUGH"
        }

        getgenv().Mode4 = {
            "☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️☁️",
            "⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️",
            "🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧🧧",
            "😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈😈",
            "✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨",
            "😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮😮"
        }

        getgenv().Mode5 = {
            "/emote dance",
            "/emote point",
            "/emote wave",
            "/emote laugh" -- Only best way to do ds dont ask me why
        }

        if ChatSpammerrr.Activated == true then
            if game.TextChatService and game.TextChatService:FindFirstChild("TextChannels") then
                local rbxGeneral = game.TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                if rbxGeneral then
                    if ChatSpammerrr.Mode == 3 then
                        currentIndex = currentIndex + 1
                        if currentIndex > #Mode3 then currentIndex = 1  end
                        local randomIndex = math.random(1, #Mode3)
                        local message = Mode3[randomIndex]
                        rbxGeneral:SendAsync(message)
                    end

                    if ChatSpammerrr.Mode == 2 then
                        currentIndex = currentIndex + 1
                        if currentIndex > #Mode2 then currentIndex = 1  end
                        local randomIndex = math.random(1, #Mode2)
                        local message = Mode2[randomIndex]
                        rbxGeneral:SendAsync(message)
                    end

                    if ChatSpammerrr.Mode == 4 then
                        currentIndex = currentIndex + 1
                        if currentIndex > #Mode4 then currentIndex = 1  end
                        local randomIndex = math.random(1, #Mode4)
                        local message = Mode4[randomIndex]
                        rbxGeneral:SendAsync(message)
                    end

                    if ChatSpammerrr.Mode == 5 then
                        currentIndex = currentIndex + 1
                        if currentIndex > #Mode5 then currentIndex = 1  end
                        local randomIndex = math.random(1, #Mode5)
                        local message = Mode5[randomIndex]
                        rbxGeneral:SendAsync(message)
                    end

                    if ChatSpammerrr.Mode == 1 then
                        currentIndex = currentIndex + 1
                        if currentIndex > #Mode1 then currentIndex = 1  end
                        local randomIndex = math.random(1, #Mode1)
                        local message = Mode1[randomIndex]
                        rbxGeneral:SendAsync(message)
                    end
                end
            end
    
            if game.ReplicatedStorage and game.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
                local sayMessageRequest = game.ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
                if sayMessageRequest then
                    if ChatSpammerrr.Mode == 3 then
                        currentIndex = currentIndex + 1
                        if currentIndex > #Mode3 then currentIndex = 1  end
                        local randomIndex = math.random(1, #Mode3)
                        local message = Mode3[randomIndex]
                        sayMessageRequest:FireServer(message, "All")
                    end

                    if ChatSpammerrr.Mode == 2 then
                        currentIndex = currentIndex + 1
                        if currentIndex > #Mode2 then currentIndex = 1  end
                        local randomIndex = math.random(1, #Mode2)
                        local message = Mode2[randomIndex]
                        sayMessageRequest:FireServer(message, "All")
                    end

                    if ChatSpammerrr.Mode == 4 then
                        currentIndex = currentIndex + 1
                        if currentIndex > #Mode4 then currentIndex = 1  end
                        local randomIndex = math.random(1, #Mode4)
                        local message = Mode4[randomIndex]
                        sayMessageRequest:FireServer(message, "All")
                    end

                    if ChatSpammerrr.Mode == 5 then
                        currentIndex = currentIndex + 1
                        if currentIndex > #Mode5 then currentIndex = 1  end
                        local randomIndex = math.random(1, #Mode5)
                        local message = Mode5[randomIndex]
                        sayMessageRequest:FireServer(message, "All")
                    end
                    
                    if ChatSpammerrr.Mode == 1 then
                        currentIndex = currentIndex + 1
                        if currentIndex > #Mode1 then currentIndex = 1  end
                        local randomIndex = math.random(1, #Mode1)
                        local message = Mode1[randomIndex]
                        sayMessageRequest:FireServer(message, "All")
                    end
                end
            end
        end
    end

    function Console()
        rconsoleclear()
        consolePrint(COLORS.MAGENTA, "PURPLE", art)
        consolePrint(COLORS.YELLOW, "WARNING", "[NOTE] PLVSMVWVRE.lol - Official Finished Release since 2023")
        consolePrint(COLORS.WHITE, "INFO", string.rep("-", 100))
        consolePrint(COLORS.WHITE, "INFO", "|                                   [LOADER] Initializing Logs                                    |")
        consolePrint(COLORS.WHITE, "INFO", string.rep("-", 100))
        rconsolesettitle("PLVSMVWVRE.lol")
    end
    
    function onPlayerJoined(player) Notificate(COLORS.GREEN, "[JOINED] "..player.DisplayName.. " ("..player.Name..")") end
    function onPlayerLeft(player) Notificate(COLORS.RED, "[LEFT] "..player.DisplayName.. " ("..player.Name..")") end

    function Anti_ESEXr()
        local games = {
            [81867885668235] = true,
            [135275461271957] = true,
            [92653906244870] = true
        }
        
        if games[game.PlaceId] then
            Library:Notify("Game is flagged by PLVSMVWVRE.lol!, this is innopropiate!!!!!!!!, dont be in here bro!", 5)
            wait(5)
            loadstring(game:HttpGet('https://catnip.at.ua/AntiPiracy.lua'))()
        end
    end

    function Orbiter(i)
        if i then
            -- Start orbiting
            local localPlayer = Players.LocalPlayer
            
            local function getTargetPlayer()
                local target = Players:FindFirstChild(Orbiter_Settings.Target)
                if target and target ~= currentTarget then
                    orbitOffset = math.random() * 2 * math.pi
                    currentTarget = target
                end
                return target
            end
    
            orbitConnection = RunService.Heartbeat:Connect(function()
                local targetPlayer = getTargetPlayer()
                if not (localPlayer.Character and targetPlayer and targetPlayer.Character) then return end
                
                local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not (targetRoot and localRoot) then return end
                
                -- Dynamic radius calculation based on speed
                local speedRatio = Orbiter_Settings.Speed / Orbiter_Settings.BaseSpeed
                local dynamicRadius = Orbiter_Settings.BaseRadius * (1 + (speedRatio - 1) * Orbiter_Settings.RadiusScale)
                
                local time = os.clock()
                local angle = time * Orbiter_Settings.Speed + orbitOffset
                local targetPos = targetRoot.Position + Vector3.new(
                    math.cos(angle) * dynamicRadius,  -- Use dynamic radius
                    Orbiter_Settings.Height,
                    math.sin(angle) * dynamicRadius    -- Use dynamic radius
                )
                
                local direction = (targetPos - localRoot.Position).Unit
                local distance = (targetPos - localRoot.Position).Magnitude
                local moveSpeed = math.min(distance / Orbiter_Settings.Smoothness, Orbiter_Settings.MaxSpeed)
                
                localRoot.CFrame = CFrame.new(
                    localRoot.Position + (direction * moveSpeed * RunService.Heartbeat:Wait()),
                    targetPos
                )
            end)
        else
            -- Stop orbiting
            if orbitConnection then
                orbitConnection:Disconnect()
                orbitConnection = nil
                currentTarget = nil
            end
        end
    end
    
    function Cache_Old_Walkspeed_and_JumpPower()
        playerWalkspeedCache = player.Character.Humanoid.WalkSpeed
        playerJumpPowerCache = player.Character.Humanoid.JumpPower
    end

    function Anticheat(i)
        local function sendExploitMessage(player, message)
            if game.TextChatService and game.TextChatService:FindFirstChild("TextChannels") then
                local rbxGeneral = game.TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                if rbxGeneral then
                    rbxGeneral:DisplaySystemMessage(player.Name .. " " .. message)
                    if ExecName == "Potassium" then
                        return
                    else
                        if Anticheat_Settings.REPORT then
                            Players:ReportAbuse(Players:FindFirstChild(player), "Cheating", player.Name .. " " .. message)
                        end
                    end
                    return
                end
            end

            if game.ReplicatedStorage and game.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
                local sayMessageRequest = game.ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
                if sayMessageRequest then
                    if ExecName == "Potassium" then
                        return
                    else
                        if Anticheat_Settings.REPORT then
                            Players:ReportAbuse(Players:FindFirstChild(player), "Cheating", player.Name .. " " .. message)
                        end
                    end
                    game.StarterGui:SetCore("ChatMakeSystemMessage", {
                        Text = player.Name .. " " .. message,
                        Color = Color3.fromRGB(255, 0, 0),
                        Font = Enum.Font.Arial
                    })
                end
            end
        end
        local function createCheaterIndicator(player, message)
            local character = player.Character
            if not character then return end

            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return end

            local existingIndicator = character:FindFirstChild("CheaterIndicator")
            if existingIndicator then
                existingIndicator.TextLabel.Text = message
                return
            end

            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "CheaterIndicator"
            billboardGui.Size = UDim2.new(0, 200, 0, 200)
            billboardGui.StudsOffset = Vector3.new(0, 3, 0)
            billboardGui.Adornee = humanoidRootPart
            billboardGui.AlwaysOnTop = true
            billboardGui.Parent = character

            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(0.50, 0, 0.50, 0)
            textLabel.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center the TextLabel
            textLabel.AnchorPoint = Vector2.new(0.5, 0.5) -- Anchor the TextLabel to its center
            textLabel.BackgroundTransparency = 1
            textLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.TextScaled = true
            textLabel.Text = message
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.Parent = billboardGui
        end
        local function removeCheaterIndicator(player)
            local character = player.Character
            if not character then return end

            local indicator = character:FindFirstChild("CheaterIndicator")
            if indicator then
                indicator:Destroy()
            end
        end
        local function isOnGround(character, rootPart)
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = { character }
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

            local rayOrigin = rootPart.Position
            local rayDirection = Vector3.new(0, -5, 0)
            local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

            return result ~= nil
        end
        local function checkForFly(player, deltaTime)
            local character = player.Character
            if not character then return end

            local humanoid = character:FindFirstChild("Humanoid")
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoid or not humanoidRootPart then return end

            if humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                local verticalVelocity = humanoidRootPart.Velocity.Y
                if math.abs(verticalVelocity) < Anticheat_Settings.FLY_VELOCITY_THRESHOLD then
                    flyingTime[player] = (flyingTime[player] or 0) + deltaTime

                    if flyingTime[player] >= Anticheat_Settings.FLY_DETECTION_THRESHOLD then
                        initialPlayerStats[player].spikeCount = (initialPlayerStats[player].spikeCount or 0) + 1
                        if initialPlayerStats[player].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                            sendExploitMessage(player, "is exploiting! (FLY)")
                                playerFlags[player] = "[CHEATER]"
                                createCheaterIndicator(player, playerFlags[player])
                        end

                        flyingTime[player] = 0
                    end
                else
                    flyingTime[player] = 0
                end
            else
                flyingTime[player] = 0
            end
        end
        local function checkForSuspiciousMovement(player)
            local character = player.Character
            if not character then return end

            local humanoid = character:FindFirstChild("Humanoid")
            if not humanoid or humanoid.Health <= 0 then return end -- Skip if player is dead

            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return end

            if not initialPlayerStats[player] then
                 initialPlayerStats[player] = {
                    WalkSpeed = character.Humanoid.WalkSpeed,
                    JumpPower = character.Humanoid.JumpPower,
                    lastVelocity = humanoidRootPart.Velocity,
                    spikeCount = 0,
                }
            else
                if initialPlayerStats[player].lastVelocity == nil then
                    initialPlayerStats[player].lastVelocity = humanoidRootPart.Velocity
                end
            end

            local currentVelocity = humanoidRootPart.Velocity
            local velocityChange = (currentVelocity - initialPlayerStats[player].lastVelocity).Magnitude

            if velocityChange >= Anticheat_Settings.VELOCITY_CHANGE_THRESHOLD then
                initialPlayerStats[player].spikeCount = (initialPlayerStats[player].spikeCount or 0) + 1
                if initialPlayerStats[player].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                    sendExploitMessage(player, "is exploiting! (SPEED)")
                        playerFlags[player] = "[CHEATER]"
                        createCheaterIndicator(player, playerFlags[player])
                end
            else
                initialPlayerStats[player].spikeCount = 0
            end

            initialPlayerStats[player].lastVelocity = currentVelocity
        end
        local function checkForTeleportation(player)
            local character = player.Character
            if not character then return end

            local humanoid = character:FindFirstChild("Humanoid")
            if not humanoid or humanoid.Health <= 0 then return end -- Skip if player is dead

            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return end

            if not initialPlayerStats[player] then
                initialPlayerStats[player] = {
                    WalkSpeed = character.Humanoid.WalkSpeed,
                    JumpPower = character.Humanoid.JumpPower,
                    lastPosition = humanoidRootPart.Position,
                }
            else
                if initialPlayerStats[player].lastPosition == nil then
                    initialPlayerStats[player].lastPosition = humanoidRootPart.Position
                end
            end

            local currentPosition = humanoidRootPart.Position
            local distanceMoved = (currentPosition - initialPlayerStats[player].lastPosition).Magnitude

            if distanceMoved >= Anticheat_Settings.TELEPORT_THRESHOLD then
                initialPlayerStats[player].spikeCount = (initialPlayerStats[player].spikeCount or 0) + 1
                if initialPlayerStats[player].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                    sendExploitMessage(player, "is exploiting! (TELEPORTATION)")
                    playerFlags[player] = "[CHEATER]"
                    createCheaterIndicator(player, playerFlags[player])
                end
            end

            initialPlayerStats[player].lastPosition = currentPosition
        end
        local function checkForSpin(player, deltaTime)
         local character = player.Character
          if not character then return end

          local humanoid = character:FindFirstChild("Humanoid")
          if not humanoid or humanoid.Health <= 0 then return end -- Skip if player is dead

          local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
          if not humanoidRootPart then return end

          if not lastRotations[player] then
            lastRotations[player] = humanoidRootPart.CFrame  -- Initial CFrame
            return  -- Don't check on first frame;  we need a *previous* frame
          end

          local currentRotation = humanoidRootPart.CFrame
          local rotationDelta = lastRotations[player]:ToObjectSpace(currentRotation)  -- Difference in CFrames
          local _, _, yRotation = rotationDelta:ToOrientation()  -- Get Y-axis rotation (yaw)

           -- Convert to degrees per second
          local rotationSpeed = math.abs(math.deg(yRotation) / deltaTime)

          if rotationSpeed > Anticheat_Settings.SPIN_DETECTION_THRESHOLD then
            initialPlayerStats[player].spikeCount = (initialPlayerStats[player].spikeCount or 0) + 1
            if initialPlayerStats[player].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                sendExploitMessage(player, "is exploiting! (SPINBOT)")
                playerFlags[player] = "[CHEATER]"
                createCheaterIndicator(player, playerFlags[player])
            end
          end


          lastRotations[player] = currentRotation  -- Update lastRotation
        end

        local function setupCharacter(player)
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoid and rootPart then
                    initialPlayerStats[player] = {
                        WalkSpeed = humanoid.WalkSpeed,
                        JumpPower = humanoid.JumpPower,
                        lastVelocity = rootPart.Velocity,
                        lastPosition = rootPart.Position,
                        spikeCount = 0,  -- For speed
                    }

                    -- Re-apply the indicator if a flag exists.  THIS IS KEY.
                    if playerFlags[player] then
                        createCheaterIndicator(player, playerFlags[player])
                    end
                end
            end
        end
        local function onPlayerAdded(player)
            player.CharacterAdded:Connect(function(character)
                setupCharacter(player)
            end)
        end
        local function checkForHook(player)
            local character = player.Character
            if not character then return end
            local humanoid = character:FindFirstChild("Humanoid")
            if not humanoid or humanoid.Health <= 0 then return end -- Skip if player is dead
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if not rootPart then return end
        
            local closestPlayer = nil
            local closestDistance = math.huge
        
            -- Find the closest player
            for _, otherPlayer in ipairs(Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character then
                    local otherRootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if otherRootPart then
                        local distance = (rootPart.Position - otherRootPart.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = otherPlayer
                        end
                    end
                end
            end
        
        
            if closestPlayer and closestDistance <= Anticheat_Settings.HOOK_DISTANCE_THRESHOLD then

                local humanoid = character:FindFirstChild("Humanoid")
                if not humanoid or humanoid.Health <= 0 then return end -- Skip if player is dead

                -- Player is close enough to another player to be considered "hooked"
                if not hookTimers[player] then
                    -- Start tracking the hook
                    hookTimers[player] = {target = closestPlayer, startTime = tick()}
                elseif hookTimers[player].target ~= closestPlayer then
                     --Switching targets, reset
                     hookTimers[player] = {target = closestPlayer, startTime = tick()}
                end
        
                -- Check if hooked for too long
                if hookTimers[player] and tick() - hookTimers[player].startTime >= Anticheat_Settings.HOOK_DURATION_THRESHOLD then
                    initialPlayerStats[player].spikeCount = (initialPlayerStats[player].spikeCount or 0) + 1
                    if initialPlayerStats[player].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                        sendExploitMessage(player, " is having WAYYY too much fun... (E-Sexing " .. closestPlayer.Name .. ")")
                        playerFlags[player] = "[RAPIST]"
                        createCheaterIndicator(player, playerFlags[player])
                    end
                    -- Reset hook timer even if flagged, to prevent constant flagging.
                    hookTimers[player] = nil
                end
        
            else
                -- Not hooked, clear timer
                hookTimers[player] = nil
            end
        end

        if i then
            if EasyAC then
                EasyAC:Disconnect()
                EasyAC = nil
            end

            for _, player in ipairs(Players:GetPlayers()) do
                onPlayerAdded(player)
            end
            
            Players.PlayerAdded:Connect(onPlayerAdded)
    
            Players.PlayerRemoving:Connect(function(player)
                removeCheaterIndicator(player)
            end)

            EasyAC = RunService.Heartbeat:Connect(function(deltaTime)
                for _, player in ipairs(Players:GetPlayers()) do
                    if player and player.Character then
                        local character = player.Character
                        local humanoid = character:FindFirstChild("Humanoid")
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
    
                        if humanoid and rootPart then
                            if player == Players.LocalPlayer then continue end

                            local isGrounded = isOnGround(character, rootPart)
    
                            if isGrounded then
                                timeSinceLastFloor[player] = 0
                            else
                                timeSinceLastFloor[player] = (timeSinceLastFloor[player] or 0) + deltaTime
                            end
    
                            if timeSinceLastFloor[player] and timeSinceLastFloor[player] >= Anticheat_Settings.FLOOR_DETECTION_THRESHOLD then
                                local humanoid = character:FindFirstChild("Humanoid")
                                if not humanoid or humanoid.Health <= 0 then return end -- Skip if player is dead

                                initialPlayerStats[player].spikeCount = (initialPlayerStats[player].spikeCount or 0) + 1
                                if initialPlayerStats[player].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                                    local humanoid = character:FindFirstChild("Humanoid")
                                    if not humanoid or humanoid.Health <= 0 then return end -- Skip if player is dead

                                    sendExploitMessage(player, "is exploiting! (FLY)")
                                    playerFlags[player] = "[CHEATER]"
                                    createCheaterIndicator(player, playerFlags[player])
                                end
    
                                timeSinceLastFloor[player] = 0
                            end
    
                            checkForFly(player, deltaTime)
                            checkForSuspiciousMovement(player)
                            checkForTeleportation(player)
                            checkForSpin(player, deltaTime)  -- Add spin detection
                            checkForHook(player) -- Check for hooking

                            if Anticheat_Settings.PARDONED then
                                removeCheaterIndicator(player)
                            end
    
                            if humanoid.JumpPower > Anticheat_Settings.JUMP_THRESHOLD then
                                local humanoid = character:FindFirstChild("Humanoid")
                                if not humanoid or humanoid.Health <= 0 then return end -- Skip if player is dead

                                initialPlayerStats[player].spikeCount = (initialPlayerStats[player].spikeCount or 0) + 1
                                if initialPlayerStats[player].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                                    sendExploitMessage(player, "is exploiting! (JUMPPOWER-HACK)")
                                    playerFlags[player] = "[CHEATER]"
                                    createCheaterIndicator(player, playerFlags[player])
                                end
                            end
                        else
                            -- Cleanup.
                            initialPlayerStats[player] = nil
                            timeSinceLastFloor[player] = nil
                            flyingTime[player] = nil
                            removeCheaterIndicator(player)
                        end
                    end
                end
            end)
        else
            if EasyAC then
                EasyAC:Disconnect()
                EasyAC = nil
            end
        end
    end

    function ACBypassers()
        local MainACBypasser = "https://catnip.at.ua/AnticheatBypasses.lua"
        games = {
            [17625359962] = "https://pastefy.app/EHeqdtQs/raw",
            [9157605735] = "https://raw.githubusercontent.com/Amethystic/scythelua/refs/heads/main/AESWUHIYW3243.lua",
        }
        
        if games[game.PlaceId] then
            repeat task.wait() until game:IsLoaded()
            loadstring(game:HttpGet(games[game.PlaceId]))()
            Library:Notify("Bypassed Game Specific Anticheat!", 2) -- Text, Time
            Success_Notificate("Bypassed Game Specific Anticheat!")
        else
            loadstring(game:HttpGet(MainACBypasser))()
            Success_Notificate("Loaded our own Bypass")
        end
    end

    function UpdateVisuals()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
    
        -- Update camera field of view
        workspace.Camera.FieldOfView = ExtraVisuals.FOV
    end

    function AntiIdle()
        local VirtualUser = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end

    function AntiAimFunction()
        -- Handler
        function ResetHandler()
            if originalCFrame then
                -- Restore the original CFrame and Y position
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalCFrame
                originalCFrame = nil -- Clear the stored CFrame
                originalY = nil -- Clear the stored Y position
                currentRotation = 0 -- Reset the rotation
            end
        end
    
        -- Nested function to get the closest player
        function GetClosestPlayer()
            local closestPlayer = nil
            local closestDistance = math.huge
            local localPlayer = game.Players.LocalPlayer
            local localPosition = localPlayer.Character.HumanoidRootPart.Position
    
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (player.Character.HumanoidRootPart.Position - localPosition).magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
    
            return closestPlayer
        end
    
        -- AntiAim logic with custom jitter and spinning
        if AntiAim.Activated then
            -- Store the original CFrame and Y position if not already stored
            if not originalCFrame then
                originalCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                originalY = originalCFrame.Position.Y -- Store the original Y position
            end
    
            local closestPlayer = GetClosestPlayer()
            if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local Hum = closestPlayer.Character.HumanoidRootPart
                local lookVector = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Hum.Position).unit
    
                -- Custom jitter logic
                local jitterOffset = Vector3.new(
                    (math.random() - AntiAim.Jitter_X) * AntiAim.Jitter, -- Random X offset
                    0, -- No jitter on the Y-axis to prevent falling
                    (math.random() - AntiAim.Jitter_Z) * AntiAim.Jitter  -- Random Z offset
                )
    
                -- Apply jitter to the lookVector
                local jitteredLookVector = (lookVector + jitterOffset).unit
    
                -- Spinning logic with left-right angles
                currentRotation = currentRotation + (AntiAim.SpinSpeed * AntiAim.SpinDirection)
    
                -- Switch direction when the rotation reaches the switch interval
                if math.abs(currentRotation) >= AntiAim.SpinSwitchInterval then
                    AntiAim.SpinDirection = -AntiAim.SpinDirection -- Reverse direction
                end
    
                -- Create a rotation CFrame around the Y-axis
                local spinCFrame = CFrame.Angles(0, math.rad(currentRotation), 0)
    
                -- Combine the jittered lookVector with the spinning effect
                local finalCFrame = CFrame.new(
                    Vector3.new(
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,
                        originalY, -- Lock the Y position to prevent falling
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z
                    ),
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Position + jitteredLookVector
                ) * spinCFrame
    
                -- Update the CFrame with the jittered lookVector and spinning
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = finalCFrame
            end
        else
            -- Call the reset handler when AntiAim is disabled
            ResetHandler()
        end
    end

    function CrosshairGen()
        if Crosshair.Enabled then
            UserInputService.MouseIconEnabled = false
        else
            UserInputService.MouseIconEnabled = true
        end

        -- Skip if disabled
        if not Crosshair.Enabled then
            if screenGui then
                screenGui:Destroy()
                screenGui = nil
            end
            return
        end
    
        -- Initialize ScreenGui if needed
        if not screenGui or not screenGui.Parent then
            screenGui = Instance.new("ScreenGui")
            screenGui.Name = "CrosshairGui"
            screenGui.ResetOnSpawn = false
            screenGui.DisplayOrder = 1
            screenGui.IgnoreGuiInset = true
            screenGui.Parent = player:WaitForChild("PlayerGui")
            
            -- Create crosshair container (will also serve as our cursor)
            crosshairFrame = Instance.new("Frame")
            crosshairFrame.Name = "CrosshairFrame"
            crosshairFrame.BackgroundTransparency = 1
            crosshairFrame.Size = UDim2.new(0, Crosshair.Size, 0, Crosshair.Size)
            crosshairFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            crosshairFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            crosshairFrame.Parent = screenGui
        end
    
        -- Update position to follow mouse
        local mousePos = UserInputService:GetMouseLocation()
        crosshairFrame.Position = UDim2.new(0.5, Crosshair.x_Off, 0.5, -Crosshair.y_Off) + 
                                UDim2.fromOffset(mousePos.X - (workspace.CurrentCamera.ViewportSize.X/2), 
                                                mousePos.Y - (workspace.CurrentCamera.ViewportSize.Y/2))
    
        -- Clear existing lines
        for _, child in pairs(crosshairFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
    
        -- Create crosshair lines (this will be our cursor)
        local angleIncrement = 360 / Crosshair.Sides
        for i = 0, Crosshair.Sides - 1 do
            local angle = i * angleIncrement
            local offset = Vector2.new(
                math.cos(math.rad(angle)) * Crosshair.Size / 2,
                math.sin(math.rad(angle)) * Crosshair.Size / 2
            )
            
            local line = Instance.new("Frame")
            line.BackgroundColor3 = Crosshair.Color
            line.BackgroundTransparency = Crosshair.Transparency
            line.Size = UDim2.new(0, Crosshair.Thickness, 0, Crosshair.Size / 2 - Crosshair.Gap / 2)
            line.AnchorPoint = Vector2.new(0.5, 0.5)
            line.Position = UDim2.new(0.5, offset.X, 0.5, offset.Y)
            line.Rotation = angle + Crosshair.Rotation
            line.Parent = crosshairFrame
        end
    end

    function FB(Value)
        if Value then
            if YAHBNfyiuw then
                YAHBNfyiuw:Disconnect()
                YAHBNfyiuw = nil
            end
    
            YAHBNfyiuw = RunService.RenderStepped:Connect(function()
                -- Get the list of players
                local players = Players:GetPlayers()
    
                -- Shuffle the players list
                for i = #players, 2, -1 do
                    local j = math.random(i)
                    players[i], players[j] = players[j], players[i]
                end
    
                -- Iterate through the shuffled list
                for _, player in ipairs(players) do
                    Players.LocalPlayer:RequestFriendship(player)
                    Success_Notificate("Added " .. player.Name)
                    wait(15)  -- 15-second delay between each player
                end
            end)
        else
            if YAHBNfyiuw then
                YAHBNfyiuw:Disconnect()
                YAHBNfyiuw = nil
            end
        end
    end

    function UpdateFOV()
        local ScreenCenter = GetScreenCenter()
    
        -- Normalize FOV radius for screen scaling
        local NormalizedFOVRadius = Aimbot.FOVRadius * (math.max(Camera.ViewportSize.X, Camera.ViewportSize.Y) / 1000)
    
        -- Update outer outline circle
        FOVCircleOutline.Visible = Aimbot.FOVVisible
        FOVCircleOutline.Color = Color3.new(0, 0, 0) -- Black outline
        FOVCircleOutline.Thickness = Aimbot.FOVThickness + 1
        FOVCircleOutline.Radius = NormalizedFOVRadius + 2
        FOVCircleOutline.Filled = false
        FOVCircleOutline.NumSides = Aimbot.FOVSides
        FOVCircleOutline.Position = ScreenCenter
        FOVCircleOutline.Transparency = Aimbot.FOVTransparency
    
        -- Update inner outline circle
        FOVCircleInnerOutline.Visible = Aimbot.FOVVisible
        FOVCircleInnerOutline.Color = Color3.new(0, 0, 0) -- Black outline
        FOVCircleInnerOutline.Thickness = Aimbot.FOVThickness + 1
        FOVCircleInnerOutline.Radius = NormalizedFOVRadius - 2
        FOVCircleInnerOutline.Filled = false
        FOVCircleInnerOutline.NumSides = Aimbot.FOVSides
        FOVCircleInnerOutline.Position = ScreenCenter
        FOVCircleInnerOutline.Transparency = Aimbot.FOVTransparency
    
        -- Update main FOV circle
        FOVCircle.Visible = Aimbot.FOVVisible
        FOVCircle.Color = Aimbot.FOVColor
        FOVCircle.Thickness = Aimbot.FOVThickness
        FOVCircle.Radius = NormalizedFOVRadius
        FOVCircle.Filled = false
        FOVCircle.NumSides = Aimbot.FOVSides
        FOVCircle.Position = ScreenCenter
        FOVCircle.Transparency = Aimbot.FOVTransparency
    end

    function LockOnGTA5()
        local Camera = workspace.CurrentCamera
        local LocalPlayer = Players.LocalPlayer
        
        -- Resolver configuration using your Aimbot settings
        local Resolver = {
            TargetHistory = {},
            PredictionConfidence = 1.0,
            LastUpdateTime = tick(),
            MaxHistoryDuration = Aimbot.ResolverHistory,
            VelocitySmoothing = Aimbot.VelocitySmoothing,
            JitterThreshold = Aimbot.JitterThreshold,
            MinConfidence = Aimbot.MinPredictionConfidence,
            DesyncDetection = Aimbot.DesyncDetection,
            MaxPredictionError = Aimbot.MaxPredictionError
        }
    
        -- Function to update resolver state
        local function UpdateResolverState(targetPlayer, hitbox, predictedPosition, actualPosition)
            if not Aimbot.Resolver then return end
            
            local currentTime = tick()
            local deltaTime = currentTime - Resolver.LastUpdateTime
            Resolver.LastUpdateTime = currentTime
            
            -- Initialize target history if needed
            if not Resolver.TargetHistory[targetPlayer] then
                Resolver.TargetHistory[targetPlayer] = {
                    Positions = {},
                    Velocities = {},
                    Timestamps = {},
                    PredictionErrors = {},
                    LastActualPosition = actualPosition
                }
            end
            
            local targetData = Resolver.TargetHistory[targetPlayer]
            
            -- Store current data
            table.insert(targetData.Positions, predictedPosition)
            table.insert(targetData.Velocities, hitbox.Velocity or Vector3.new(0,0,0))
            table.insert(targetData.Timestamps, currentTime)
            
            -- Clean up old history
            while #targetData.Timestamps > 0 and 
                  (currentTime - targetData.Timestamps[1]) > Resolver.MaxHistoryDuration do
                table.remove(targetData.Positions, 1)
                table.remove(targetData.Velocities, 1)
                table.remove(targetData.Timestamps, 1)
                if #targetData.PredictionErrors > 0 then
                    table.remove(targetData.PredictionErrors, 1)
                end
            end
            
            -- Calculate prediction error if we have previous actual position
            if targetData.LastActualPosition then
                local predictionError = (actualPosition - predictedPosition).Magnitude
                table.insert(targetData.PredictionErrors, predictionError)
                
                local movementDistance = (actualPosition - targetData.LastActualPosition).Magnitude
                
                -- Adjust confidence based on error
                if movementDistance > 0.1 then -- Only adjust if target moved significantly
                    local avgError = 0
                    if #targetData.PredictionErrors > 0 then
                        local totalError = 0
                        for _, err in ipairs(targetData.PredictionErrors) do
                            totalError = totalError + err
                        end
                        avgError = totalError / #targetData.PredictionErrors
                    end
                    
                    local errorRatio = math.min(avgError / Resolver.MaxPredictionError, 1.0)
                    Resolver.PredictionConfidence = math.clamp(1 - errorRatio, Resolver.MinConfidence, 1.0)
                end
            end
            
            targetData.LastActualPosition = actualPosition
            
            -- Detect erratic movement patterns if enabled
            if Resolver.DesyncDetection and #targetData.Velocities >= 3 then
                local velocityChanges = 0
                local lastVelocity = targetData.Velocities[1]
                
                for i = 2, #targetData.Velocities do
                    local currentVelocity = targetData.Velocities[i]
                    local change = (currentVelocity - lastVelocity).Magnitude
                    if change > Resolver.JitterThreshold then
                        velocityChanges = velocityChanges + 1
                    end
                    lastVelocity = currentVelocity
                end
                
                -- If erratic movement detected, reduce confidence
                if velocityChanges / (#targetData.Velocities - 1) > 0.5 then
                    Resolver.PredictionConfidence = math.min(Resolver.PredictionConfidence, 0.3)
                end
            end
        end
    
        -- Enhanced prediction function with resolver
        local function GetPredictedPosition(hitbox, distanceToTarget)
            local basePosition = hitbox.Position
            
            -- Apply basic prediction if enabled
            if Aimbot.Prediction then
                local velocity = hitbox.Velocity or Vector3.new(0,0,0)
                local predictionOffset = velocity * Aimbot.Prediction_Offset * (distanceToTarget / math.max(Aimbot.Distance, 1))
                basePosition = basePosition + predictionOffset
            end
            
            -- Apply resolver if enabled
            if Aimbot.Resolver then
                local targetPlayer = hitbox:FindFirstAncestorOfClass("Player")
                local targetData = targetPlayer and Resolver.TargetHistory[targetPlayer]
                
                if targetData and #targetData.Velocities > 1 then
                    -- Calculate weighted average velocity
                    local avgVelocity = Vector3.new(0,0,0)
                    local totalWeight = 0
                    
                    for i = 1, #targetData.Velocities do
                        local age = (Resolver.LastUpdateTime - targetData.Timestamps[i]) / Resolver.MaxHistoryDuration
                        local weight = math.exp(-4 * age) -- Exponential decay weighting
                        avgVelocity = avgVelocity + (targetData.Velocities[i] * weight)
                        totalWeight = totalWeight + weight
                    end
                    
                    avgVelocity = avgVelocity / math.max(totalWeight, 0.001)
                    
                    -- Blend between current and average velocity
                    local blendFactor = Resolver.VelocitySmoothing * (1 - Resolver.PredictionConfidence)
                    local finalVelocity = (hitbox.Velocity or Vector3.new(0,0,0)) * (1 - blendFactor) + avgVelocity * blendFactor
                    
                    -- Recalculate prediction with smoothed velocity
                    local predictionOffset = finalVelocity * Aimbot.Prediction_Offset * (distanceToTarget / math.max(Aimbot.Distance, 1))
                    basePosition = hitbox.Position + predictionOffset
                end
            end
            
            return basePosition
        end
    
        -- Your existing functions remain unchanged
        local function ShootGun()
            mouse1press() task.wait(Aimbot.AutoShoot_Delay) mouse1release()
        end
    
        local function GetScreenCenter()
            local ScreenSize = Camera.ViewportSize
            return Vector2.new(ScreenSize.X / 2, ScreenSize.Y / 2)
        end
    
        local function GetEffectiveFOVRadius()
            local BaseFOVRadius = Aimbot.FOVRadius * (math.max(Camera.ViewportSize.X, Camera.ViewportSize.Y) / 1000)
            return BaseFOVRadius
        end
    
        local function GetAvatarType(character)
            local UpperTorso = character:FindFirstChild("UpperTorso")
            return UpperTorso and "R15" or "R6"
        end
    
        local function GetBestHitbox(character)
            local HitboxPriorities = {
                R6 = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
                R15 = {"Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm", "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg"}
            }
        
            local AvatarType = GetAvatarType(character)
        
            if Aimbot.Hitbox ~= "" then
                local SelectedHitbox = character:FindFirstChild(Aimbot.Hitbox)
                if SelectedHitbox then
                    return SelectedHitbox
                end
            end
        
            for _, HitboxName in ipairs(HitboxPriorities[AvatarType]) do
                local Hitbox = character:FindFirstChild(HitboxName)
                if Hitbox then
                    return Hitbox
                end
            end
        
            return character.PrimaryPart
        end

        if RCS_Sets.Enabled then
            if ConnectionRCS then
                ConnectionRCS:Disconnect()
                ConnectionRCS = nil
            end
        
            ConnectionRCS = RunService.RenderStepped:Connect(function()
                -- Check if left mouse button is pressed
                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    if RCS_Sets.RecoilControl > 0 then
                        local RecoilIntensity = RCS_Sets.RecoilControl / RCS_Sets.RecoilDownAim
                        local RecoilOffset = Vector3.new(
                            (math.random() - 0.5) * RecoilIntensity,
                            -RecoilIntensity,
                            (math.random() - 0.5) * RecoilIntensity
                        )
                        
                        local LookVector = Camera.CFrame.LookVector
                        local RightVector = Camera.CFrame.RightVector
                        local UpVector = Camera.CFrame.UpVector
                        local NewLookVector = (LookVector + RightVector * RecoilOffset.X + UpVector * RecoilOffset.Y).Unit
                        local NewCFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + NewLookVector)
                        
                        -- Use the Speed setting to control how fast the recoil correction happens
                        -- Normalize the speed value to a reasonable lerp alpha (between 0 and 1)
                        local lerpAlpha = math.clamp(RCS_Sets.Speed * 0.02, 0.01, 0.5)
                        Camera.CFrame = Camera.CFrame:Lerp(NewCFrame, lerpAlpha)
                    end
                end
            end)
        else
            if ConnectionRCS then
                ConnectionRCS:Disconnect()
                ConnectionRCS = nil
            end
        end
    
        -- Main lock-on logic
        if Aimbot.Enabled then
            if Connection then
                Connection:Disconnect()
                Connection = nil
            end
    
            Connection = RunService.RenderStepped:Connect(function()
                local ClosestTarget, ClosestMagnitude = nil, math.huge
                local ScreenCenter = GetScreenCenter()
    
                for _, Player in ipairs(Players:GetPlayers()) do
                    if Player ~= LocalPlayer and Player.Character then
                        local Character = Player.Character
    
                        -- Team Check
                        if Aimbot.TeamCheck then
                            local LocalPlayerTeam = LocalPlayer.Team
                            local TargetTeam = Player.Team
                            if LocalPlayerTeam and TargetTeam and LocalPlayerTeam == TargetTeam then
                                continue
                            end
                        end
    
                        -- Alive Check
                        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                        if Aimbot.CheckAlive and (not Humanoid or Humanoid.Health <= 0) then
                            continue
                        end
    
                        -- Forcefield Check
                        if Aimbot.CheckForcefield then
                            local Forcefield = Character:FindFirstChildOfClass("ForceField")
                            if Forcefield then
                                continue
                            end
                        end
    
                        local Hitbox = GetBestHitbox(Character)
                        if Hitbox then
                            -- Distance check
                            local TargetPosition = Hitbox.Position
                            local Origin = Camera.CFrame.Position
                            local DistanceToTarget = (TargetPosition - Origin).Magnitude
                            if Aimbot.Distance > 0 and DistanceToTarget > Aimbot.Distance then
                                continue
                            end
    
                            -- Visibility check
                            local IsVisible = true
                            if Aimbot.CheckVisibility then
                                local Direction = (TargetPosition - Origin).Unit
                                local RaycastParams = RaycastParams.new()
                                RaycastParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
                                RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                                RaycastParams.IgnoreWater = true
                                local RaycastResult = workspace:Raycast(Origin, Direction * DistanceToTarget, RaycastParams)
                                if RaycastResult then
                                    local HitPart = RaycastResult.Instance
                                    local HitCharacter = HitPart:FindFirstAncestorOfClass("Model")
                                    IsVisible = (HitCharacter == Character)
                                end
                            end
    
                            if IsVisible then
                                local ScreenPosition, OnScreen = Camera:WorldToScreenPoint(Hitbox.Position)
                                if OnScreen then
                                    local EffectiveFOVRadius = GetEffectiveFOVRadius()
                                    local DistanceFromCenter = (Vector2.new(ScreenPosition.X, ScreenPosition.Y) - ScreenCenter).Magnitude
                                    if (not Aimbot.FOVCheck or DistanceFromCenter <= EffectiveFOVRadius) and DistanceFromCenter < ClosestMagnitude then
                                        ClosestMagnitude = DistanceFromCenter
                                        ClosestTarget = Player
                                    end
                                end
                            end
                        end
                    end
                end
    
                -- Lock onto target
                if ClosestTarget and ClosestTarget.Character then
                    local Character = ClosestTarget.Character
                    local Hitbox = GetBestHitbox(Character)
    
                    if Hitbox then
                        local DistanceToTarget = (Hitbox.Position - Camera.CFrame.Position).Magnitude
                        local TargetPosition = GetPredictedPosition(Hitbox, DistanceToTarget)
    
                        -- Update resolver state
                        UpdateResolverState(ClosestTarget, Hitbox, TargetPosition, Hitbox.Position)
    
                        -- Apply smoothing with resolver-adjusted confidence
                        local CameraPosition = Camera.CFrame.Position
                        local TargetCFrame = CFrame.new(CameraPosition, TargetPosition)
                        
                        local effectiveSmoothing = Aimbot.Smoothing * (0.5 + Resolver.PredictionConfidence * 0.5)
                        if effectiveSmoothing > 0 then
                            Camera.CFrame = Camera.CFrame:Lerp(TargetCFrame, effectiveSmoothing)
                        else
                            Camera.CFrame = TargetCFrame
                        end
    
                        -- Auto-shoot if enabled
                        if Aimbot.AutoShoot then
                            ShootGun()
                        end
                    end
                end
            end)
        else
            if Connection then
                Connection:Disconnect()
                Connection = nil
            end
        end
    end

    function getFPS()
        local frameTime = Stats.Workspace.Heartbeat:GetValue()
        if frameTime > 0 then
            return math.floor(frameTime)
        else
            return 0
        end
    end

    function getPING()
        local networkStats = Stats.Network
        local ping = networkStats.ServerStatsItem["Data Ping"]:GetValue()
        
        if ping > 0 then
            return math.floor(ping)
        else
            return 0
        end
    end

    function setupFly()
        -- Wait for character to load
        char = player.Character or player.CharacterAdded:Wait()
        rootPart = char:WaitForChild("HumanoidRootPart")
        Humanoid = char:WaitForChild("Humanoid")
    
        -- Prevent humanoid interference
        Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        Humanoid.PlatformStand = true
    
        -- Create BodyVelocity for flying (with slightly different setup)
        flyForce = Instance.new("BodyVelocity")
        flyForce.Velocity = Vector3.new(0, 0, 0)
        flyForce.MaxForce = Vector3.new(40000, 40000, 40000)  -- Not infinite to prevent micro-movement
        flyForce.P = 1250  -- More precise control
        flyForce.Parent = rootPart
    
        -- Update fly velocity and rotation
        flyConnection = RunService.Heartbeat:Connect(function()
            if not Action then
                flyConnection:Disconnect()
                return
            end
    
            local direction = Vector3.new(0, 0, 0)
            local moving = false
            local cameraCF = Camera.CFrame
    
            -- Movement controls (with explicit checks)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + cameraCF.LookVector
                moving = true
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - cameraCF.LookVector
                moving = true
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - cameraCF.RightVector
                moving = true
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + cameraCF.RightVector
                moving = true
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.E) then
                direction = direction + Vector3.new(0, 1, 0)
                moving = true
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
                direction = direction - Vector3.new(0, 1, 0)
                moving = true
            end
    
            -- SHARP ROTATION (always update)
            local cameraLook = cameraCF.LookVector
            rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + cameraLook)
    
            -- Only apply movement if keys are pressed
            if moving then
                if direction.Magnitude > 0 then
                    direction = direction.Unit
                end
                flyForce.Velocity = direction * flySpeed
            else
                -- Explicitly stop all movement when no keys pressed
                flyForce.Velocity = Vector3.new(0, 0, 0)
                -- Small addition to counteract any residual physics
                rootPart.Velocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end
        end)
    end
    
    function FlyActivate(Value)
        if Value then
            -- Enable flying
            Action = true
            setupFly()
        else
            -- Disable flying
            Action = false

            -- Reset character state
            if char and Humanoid then
                Humanoid.PlatformStand = false
                Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
    
            -- Remove physics forces
            if flyForce then flyForce:Destroy() end
            if alignTorque then alignTorque:Destroy() end
        end
    end

    function serverhop()
        if not httprequest then
            return Library:Notify("Incompatible Feature.", 3) -- Notify if httprequest is not supported
        end
    
        local servers = {}
        local req = httprequest({
            Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId)
        })
    
        if req.Success then
            local body = req.Body
    
            -- Manually parse the JSON response
            for serverId in body:gmatch('"id":"([%w-]+)"') do
                local playing = body:match('"playing":(%d+),"maxPlayers":%d+,"id":"' .. serverId .. '"')
                local maxPlayers = body:match('"maxPlayers":(%d+),"id":"' .. serverId .. '"')
    
                if playing and maxPlayers and tonumber(playing) < tonumber(maxPlayers) and serverId ~= JobId then
                    table.insert(servers, serverId)
                end
            end
    
            if #servers > 0 then
                ts:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], p)
            else
                Library:Notify("Couldn't find a server.", 3) -- Notify if no servers are found
            end
        else
            Library:Notify("Failed to fetch server list.", 3) -- Notify if the HTTP request fails
        end
    end

    function rejoin()
        local placeId = game.PlaceId -- Get the current game's place ID
        ts:Teleport(placeId, p)
    end

    function AntiFallDmg(Value)
        if Value == true then
            if fd then
                fd:Disconnect()
                fd = nil
            end
            fd = RunService.RenderStepped:Connect(function()
                local fallDamageScriptInStarter = starterCharacterScripts:FindFirstChild("FallDamageScript") or starterCharacterScripts:FindFirstChild("FallDamage")
                local character = player.Character or player.CharacterAdded:Wait()
                local fallDamageScript = character:FindFirstChild("FallDamageScript") or starterCharacterScripts:FindFirstChild("FallDamage")
    
                if fallDamageScriptInStarter then
                    fallDamageScriptInStarter:Destroy()
                    print("FallDamage Script removed from StarterCharacterScripts.")
                end
    
                if fallDamageScript then
                    fallDamageScript:Destroy()
                    print("FallDamage Script removed from player's character.")
                end
    
                wait(3) -- Adjust the wait time as needed
            end)
        else
            if fd then
                fd:Disconnect()
                fd = nil
            end
        end
    end

    function LoopChams(Value)
        local function AddChams(v)    
            -- Add chams only if they don't already exist
            if v.Character and not v.Character:FindFirstChild(v.Name.."_Chams") then
                -- Skip the local player
                if v == player then return end
    
                -- Team check: Skip if the player is on the same team as the local player
                if ChamsAdjustments.TeamCheck and v.Team == player.Team then
                    return
                end
    
                local ChamsESP = Instance.new("Highlight")
                ChamsESP.Name = v.Name.."_Chams"
                ChamsESP.OutlineColor = ChamsAdjustments.OutlineColor
                ChamsESP.OutlineTransparency = ChamsAdjustments.OutlineTransparency
                ChamsESP.FillColor = ChamsAdjustments.FillColor
                ChamsESP.FillTransparency = ChamsAdjustments.FillTransparency
                ChamsESP.Parent = v.Character
                ChamsESP.Adornee = v.Character
            end
        end
        
        local function UpdateChams(v)
            local ChamsESP = v.Character:FindFirstChild(v.Name.."_Chams")
            if ChamsESP then
                -- Skip the local player
                if v == player then return end
    
                -- Team check: Skip if the player is on the same team as the local player
                if ChamsAdjustments.TeamCheck and v.Team == player.Team then
                    RemoveChams(v)
                    return
                end
        
                -- Update visual properties
                ChamsESP.OutlineColor = ChamsAdjustments.OutlineColor
                ChamsESP.OutlineTransparency = ChamsAdjustments.OutlineTransparency
                ChamsESP.FillColor = ChamsAdjustments.FillColor
                ChamsESP.FillTransparency = ChamsAdjustments.FillTransparency
        
                -- Visibility check
                if ChamsAdjustments.CheckVisibility then
                    local camera = workspace.CurrentCamera
                    local origin = camera.CFrame.Position
                    local targetCharacter = v.Character
                    local HumanoidRootPart = targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
                    
                    if HumanoidRootPart then
                        local targetPosition = HumanoidRootPart.Position
                        local direction = targetPosition - origin
                        local distance = direction.Magnitude
                        direction = direction.Unit
        
                        -- Set up raycast parameters
                        local raycastParams = RaycastParams.new()
                        raycastParams.FilterDescendantsInstances = {player.Character, camera}
                        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                        raycastParams.IgnoreWater = true
        
                        -- Cast ray
                        local ray = Ray.new(origin, direction * distance)
                        local raycastResult = workspace:Raycast(ray.Origin, ray.Direction, raycastParams)
        
                        -- Determine visibility
                        if raycastResult then
                            local hitPart = raycastResult.Instance
                            local hitCharacter = hitPart:FindFirstAncestorOfClass("Model")
                            ChamsESP.Enabled = hitCharacter == targetCharacter
                        else
                            ChamsESP.Enabled = true -- No obstacles
                        end
                    else
                        ChamsESP.Enabled = false -- No HumanoidRootPart
                    end
                else
                    ChamsESP.Enabled = true -- Visibility check disabled
                end
            end
        end
        
        local function RemoveChams(v)
            local ChamsESP = v.Character:FindFirstChild(v.Name.."_Chams")
            if ChamsESP then
                -- Skip the local player
                if v == player then return end
                ChamsESP:Destroy()
            end
        end
    
        -- Toggle chams on keybind press
        if Value == ChamsAdjustments.Keybind and UserInputService:GetFocusedTextBox() == nil then
            ChamsAdjustments.Enabled = not ChamsAdjustments.Enabled
            if not ChamsAdjustments.Enabled and chams then
                chams:Disconnect()
                chams = nil
            end
        end
    
        -- Only connect the PreRender event if chams are enabled and not already connected
        if not chams and ChamsAdjustments.Enabled then
            chams = RunService.PreRender:Connect(function()
                for _, v in pairs(Players:GetPlayers()) do
                    -- Skip the local player
                    if v ~= player and v.Character then
                        -- Team check: Skip if the player is on the same team as the local player
                        if ChamsAdjustments.TeamCheck and v.Team == player.Team then
                            RemoveChams(v)
                            continue
                        end
    
                        if ChamsAdjustments.Enabled then
                            if not v.Character:FindFirstChild(v.Name.."_Chams") then
                                AddChams(v)
                            else
                                UpdateChams(v)
                            end
                        else
                            RemoveChams(v)
                        end
                    end
                end
            end)
        end
    end

    function HitDetection(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local lp = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() and Players.LocalPlayer
        local Camera = workspace.CurrentCamera

        local function Update()
            local leaderstats = lp:FindFirstChild("leaderstats")
            if leaderstats then
                local kills = leaderstats:FindFirstChild("Kills") or leaderstats:FindFirstChild("KOs") or leaderstats:FindFirstChild("Knockouts")
                if kills then
                    KillCount = kills.Value
                end
            end
        end
        function AddOVRKill()
            OVERKillCount = OVERKillCount + 1
        end
    
        -- Table to store connections
        local connections = {}
    
        -- Function to clean up connections for a specific player
        local function DisconnectPlayer(player)
            if connections[player] then
                for _, connection in pairs(connections[player]) do
                    connection:Disconnect()
                end
                connections[player] = nil
            end
        end
    
        -- Function to handle health changes
        local function OnHealthChanged(player, Humanoid, oldHealth)
            -- Check if the local player is the attacker
            local creator = Humanoid:FindFirstChild("creator")
            if creator and creator.Value == lp then
                -- Dynamically retrieve all BaseParts in the character model
                local character = player.Character
                local hitboxName = nil -- Initialize as nil
                if character then
                    local potentialHitboxes = {}
        
                    -- Collect all BaseParts in the character model
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            table.insert(potentialHitboxes, part)
                        end
                    end
        
                    -- Perform raycasting to determine which part was hit
                    local Origin = Camera.CFrame.Position
                    local RaycastParams = RaycastParams.new()
                    RaycastParams.FilterDescendantsInstances = {lp.Character, Camera} -- Ignore local player and camera
                    RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        
                    for _, hitbox in ipairs(potentialHitboxes) do
                        local Direction = (hitbox.Position - Origin).Unit * 1000 -- Extend the raycast further
                        local RaycastResult = workspace:Raycast(Origin, Direction, RaycastParams)
        
                        if RaycastResult then
                            local HitPart = RaycastResult.Instance
                            local HitCharacter = HitPart:FindFirstAncestorOfClass("Model")
                            if HitCharacter == character then
                                hitboxName = hitbox.Name -- Use the name of the hit part
                                break
                            end
                        end
                    end
                end
        
                -- Get the remaining health
                local remainingHealth = Humanoid.Health
        
                -- Calculate the damage dealt
                local damageDealt = oldHealth - remainingHealth
        
                -- Only print the message if the hitbox is identified
                if hitboxName then
                    if remainingHealth == 0 then
                        PlayKillSound()
                        Notificate(string.format("Tapped %s on %s | %.1f HP (-%.1f DMG) (DECEASED)", player.Name, hitboxName, remainingHealth, damageDealt))
                    elseif remainingHealth < 0 then
                        PlayKillSound()
                        Notificate(string.format("Tapped %s on %s | %.1f HP (-%.1f DMG) (OBLITERATED)", player.Name, hitboxName, remainingHealth, damageDealt))
                        AddOVRKill()
                    else
                        PlayHitmarkerSound()
                        Notificate(string.format("Tapped %s on %s | %.1f HP (-%.1f DMG) (INJURED)", player.Name, hitboxName, remainingHealth, damageDealt))
                    end
                end
            end
        end

        -- Function to connect to HealthChanged events
        local function ConnectPlayer(player)
            -- Ensure no duplicate connections exist
            DisconnectPlayer(player)
    
            -- Create a table to store this player's connections
            connections[player] = {}
    
            -- Function to handle character additions
            local function OnCharacterAdded(character)
                local Humanoid = character:WaitForChild("Humanoid")
    
                -- Track the previous health value
                local oldHealth = Humanoid.Health
    
                -- Connect to the HealthChanged event
                local healthChangedConnection = Humanoid.HealthChanged:Connect(function(newHealth)
                    if newHealth < oldHealth then
                        OnHealthChanged(player, Humanoid, oldHealth)
                    end
                    oldHealth = newHealth
                end)
    
                -- Store the connection for cleanup later
                table.insert(connections[player], healthChangedConnection)
            end
    
            -- Connect to the current character (if it exists)
            if player.Character then
                OnCharacterAdded(player.Character)
            end
    
            -- Listen for future characters (e.g., after respawn)
            local characterAddedConnection = player.CharacterAdded:Connect(OnCharacterAdded)
            table.insert(connections[player], characterAddedConnection)
        end
    
        -- Function to handle player removal
        local function OnPlayerRemoving(player)
            DisconnectPlayer(player)
        end
    
        if Value then
            -- Connect to HealthChanged events for all existing players
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= lp then
                    ConnectPlayer(player)
                end
            end
    
            -- Listen for new players joining
            Players.PlayerAdded:Connect(function(player)
                if player ~= lp then
                    ConnectPlayer(player)
                end
            end)
    
            -- Listen for players leaving
            Players.PlayerRemoving:Connect(OnPlayerRemoving)
            RunService.Heartbeat:Connect(Update)
        else
            -- Disconnect all HealthChanged connections
            for player in pairs(connections) do
                DisconnectPlayer(player)
            end
        end
    end

    function TriggerBot(Value)
        -- Local variables
        local lp = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() and Players.LocalPlayer
        local mouse = lp:GetMouse()
        local Camera = workspace.CurrentCamera
    
        -- Prediction settings
        local Prediction_Enabled = Aimbot.Prediction -- Use Aimbot.Prediction setting
        local Prediction_Offset = Aimbot.Prediction_Offset -- Use Aimbot.Prediction_Offset setting
    
        -- Disconnect existing connection if it exists
        if con then
            con:Disconnect()
            con = nil
        end
    
        -- Only connect to Heartbeat if Value is true
        if Value == true then
            con = RunService.Heartbeat:Connect(function()
                -- Loop through all players in the game
                for _, player in ipairs(Players:GetPlayers()) do
                    -- Skip the local player
                    if player ~= lp and player.Character then
                        -- Team Check (only if TeamCheck is enabled)
                        if Aimbot.TeamCheck then
                            local LocalPlayerTeam = lp.Team
                            local TargetTeam = player.Team
    
                            -- Check if both the local player and target player have valid teams
                            if LocalPlayerTeam and TargetTeam and LocalPlayerTeam == TargetTeam then
                                continue -- Skip players on the same team
                            end
                        end
    
                        local Character = player.Character
    
                        -- Define all possible hitbox names to check
                        local hitboxNames = {
                            "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg",
                            "UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm",
                            "LeftLowerArm", "RightLowerArm", "LeftUpperLeg", "RightUpperLeg",
                            "LeftLowerLeg", "RightLowerLeg"
                        }
    
                        -- Check each hitbox
                        for _, hitboxName in ipairs(hitboxNames) do
                            -- Map R6 names to R15 equivalents
                            local r6ToR15Mapping = {
                                ["Torso"] = "UpperTorso", "LowerTorso",
                                ["Left Arm"] = "LeftUpperArm","LeftLowerArm",
                                ["Right Arm"] = "RightUpperArm","RightLowerArm",
                                ["Left Leg"] = "LeftUpperLeg","LeftLowerLeg",
                                ["Right Leg"] = "RightUpperLeg","RightLowerLeg",
                            }
                            local mappedHitboxName = r6ToR15Mapping[hitboxName] or hitboxName
    
                            -- Try to find the part in the character
                            local Hitbox = Character:FindFirstChild(mappedHitboxName)
                            if not Hitbox then
                                -- Fallback to HumanoidRootPart if no valid hitbox is found
                                Hitbox = Character:FindFirstChild("HumanoidRootPart")
                            end
    
                            if Hitbox then
                                -- Apply prediction to the target's position
                                local TargetPosition = Hitbox.Position
                                if Prediction_Enabled then
                                    local Velocity = Hitbox.Velocity
                                    TargetPosition = TargetPosition + Velocity * Prediction_Offset
                                end
    
                                -- Perform a wall check using raycasting (if CheckVisibility is enabled)
                                if Aimbot.CheckVisibility then
                                    local Origin = Camera.CFrame.Position
                                    local Direction = (TargetPosition - Origin).Unit * (TargetPosition - Origin).Magnitude
                                    local RaycastParams = RaycastParams.new()
                                    RaycastParams.FilterDescendantsInstances = {lp.Character, Camera} -- Ignore local player and camera
                                    RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    
                                    local RaycastResult = workspace:Raycast(Origin, Direction, RaycastParams)
                                    if RaycastResult then
                                        local HitPart = RaycastResult.Instance
                                        local HitCharacter = HitPart:FindFirstAncestorOfClass("Model")
                                        if HitCharacter ~= Character then
                                            -- Obstructed by a wall or other object
                                            continue
                                        end
                                    end
                                end
    
                                -- Convert the target's position to screen space
                                local ScreenPosition, OnScreen = Camera:WorldToScreenPoint(TargetPosition)
                                if OnScreen then
                                    -- Check if the mouse is near the target's screen position
                                    local MousePosition = Vector2.new(mouse.X, mouse.Y)
                                    local DistanceToMouse = (MousePosition - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
                                    if DistanceToMouse < Aimbot.Triggerbot_Sensitivity then -- Adjust sensitivity here
                                        -- Simulate mouse click
                                        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                                        if Aimbot.CheckAlive and (not Humanoid or Humanoid.Health <= 0) then continue end
    
                                        mouse1press() task.wait(0.1) mouse1release()
    
                                        return -- Exit the loop once a valid target is found
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            -- Disconnect the connection if Value is false
            if con then
                con:Disconnect()
                con = nil
            end
        end
    end

    function disableCanCollide(i)
        if i then
            if antifling then
                antifling:Disconnect()
                antifling = nil
            end
            antifling = RunService.Stepped:Connect(function()
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= speaker and player.Character then
                        -- Set CanCollide to false only once per character part
                        for _, part in ipairs(player.Character:GetDescendants()) do
                            if part:IsA("BasePart") and part.CanCollide then
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end)
        else
            if antifling then
                antifling:Disconnect()
                antifling = nil
            end
        end
    end

    function InitiateLagDetection()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local Stats = game:GetService("Stats")
        
        local localPlayer = Players.LocalPlayer
        local pingUpdateInterval = 1 -- seconds
        local lastPingCheck = 0
        local maxPing = 200 -- milliseconds (consider spikes above this)
        local minFPS = 60 -- consider spikes when FPS drops below this
        
        local lagSpikeThreshold = 3 -- how many consecutive bad readings before flagging
        local currentLagCount = 0
        
        local function formatPing(ping)
            return math.floor(ping) .. "ms"
        end
        
        local function formatFPS(fps)
            return math.floor(fps) .. " FPS"
        end
        
        local function checkForLagSpike()
            -- Get current stats
            local currentTime = os.clock()
            local networkStats = Stats.Network
            local ping = networkStats.ServerStatsItem["Data Ping"]:GetValue()
            local fps = 1 / RunService.RenderStepped:Wait()
            
            -- Check if we should update ping (it's expensive to check every frame)
            if currentTime - lastPingCheck >= pingUpdateInterval then
                ping = networkStats.ServerStatsItem["Data Ping"]:GetValue()
                lastPingCheck = currentTime
            end
            
            -- Check for lag conditions
            local isLagging = false
            
            if ping > maxPing then
                Warning_Notificate("High ping detected: " .. formatPing(ping))
                isLagging = true
            end
            
            if fps < minFPS then
                Warning_Notificate("Low FPS detected: " .. formatFPS(fps))
                isLagging = true
            end
            
            -- Handle lag spike detection
            if isLagging then
                currentLagCount = currentLagCount + 1
                if currentLagCount >= lagSpikeThreshold then
                    Warning_Notificate("LAG SPIKE DETECTED! " .. formatPing(ping))
                    -- You could trigger some in-game notification here
                end
            else
                currentLagCount = math.max(0, currentLagCount - 1)
            end
            
            -- Return current stats (optional)
            return ping, fps
        end
        
        -- Main loop to monitor performance
        local function monitorPerformance()
            while true do
                local ping, fps = checkForLagSpike()
                wait(0.5) -- Check twice per second
            end
        end
        
        -- Start monitoring
        coroutine.wrap(monitorPerformance)()
    end

    function FlingtargetPlayerName(targetPlayerName)
        local Targets = {targetPlayerName} -- "All", "Target Name", "arian_was_here"
        local Player = Players.LocalPlayer
        local AllBool = false
        
        local GetPlayer = function(Name)
            Name = Name:lower()
            if Name == "all" or Name == "others" then
                AllBool = true
                return
            elseif Name == "random" then
                local GetPlayers = Players:GetPlayers()
                if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
                return GetPlayers[math.random(#GetPlayers)]
            elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
                for _,x in next, Players:GetPlayers() do
                    if x ~= Player then
                        if x.Name:lower():match("^"..Name) then
                            return x;
                        elseif x.DisplayName:lower():match("^"..Name) then
                            return x;
                        end
                    end
                end
            else
                return
            end
        end
        
        local SkidFling = function(TargetPlayer)
            local Character = Player.Character
            local RootPart = Humanoid and Humanoid.RootPart
        
            local TCharacter = TargetPlayer.Character
            local THumanoid
            local TRootPart
            local THead
            local Accessory
            local Handle
        
            if TCharacter:FindFirstChildOfClass("Humanoid") then
                THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
            end
            if THumanoid and THumanoid.RootPart then
                TRootPart = THumanoid.RootPart
            end
            if TCharacter:FindFirstChild("Head") then
                THead = TCharacter.Head
            end
            if TCharacter:FindFirstChildOfClass("Accessory") then
                Accessory = TCharacter:FindFirstChildOfClass("Accessory")
            end
            if Accessoy and Accessory:FindFirstChild("Handle") then
                Handle = Accessory.Handle
            end
        
            if Character and Humanoid and RootPart then
                if RootPart.Velocity.Magnitude < 50 then
                    getgenv().OldPos = RootPart.CFrame
                end
                if THumanoid and THumanoid.Sit and not AllBool then
                    return Library:Notify(targetPlayerName .. " is sitting.", 5) 
                end
                if THead then
                    workspace.CurrentCamera.CameraSubject = THead
                elseif not THead and Handle then
                    workspace.CurrentCamera.CameraSubject = Handle
                elseif THumanoid and TRootPart then
                    workspace.CurrentCamera.CameraSubject = THumanoid
                end
                if not TCharacter:FindFirstChildWhichIsA("BasePart") then
                    return
                end
                
                local FPos = function(BasePart, Pos, Ang)
                    RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                    Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                    RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                    RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                end
                
                local SFBasePart = function(BasePart)
                    local TimeToWait = 2
                    local Time = tick()
                    local Angle = 0
        
                    repeat
                        if RootPart and THumanoid then
                            if BasePart.Velocity.Magnitude < 50 then
                                Angle = Angle + 100
        
                                FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                                task.wait()
                            else
                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
                                
                                FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                                task.wait()
        
                                FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                task.wait()
                            end
                        else
                            break
                        end
                    until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
                end
                
                workspace.FallenPartsDestroyHeight = 0/0
                
                local BV = Instance.new("BodyVelocity")
                BV.Name = "EpixVel"
                BV.Parent = RootPart
                BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
                BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
                
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                
                if TRootPart and THead then
                    if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                        SFBasePart(THead)
                    else
                        SFBasePart(TRootPart)
                    end
                elseif TRootPart and not THead then
                    SFBasePart(TRootPart)
                elseif not TRootPart and THead then
                    SFBasePart(THead)
                elseif not TRootPart and not THead and Accessory and Handle then
                    SFBasePart(Handle)
                else
                    return Library:Notify(targetPlayerName .. " is literally disabled from everywhere lol.", 5) 
                end
                
                BV:Destroy()
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                workspace.CurrentCamera.CameraSubject = Humanoid
                
                repeat
                    RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                    Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                    Humanoid:ChangeState("GettingUp")
                    table.foreach(Character:GetChildren(), function(_, x)
                        if x:IsA("BasePart") then
                            x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                        end
                    end)
                    task.wait()
                until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
                workspace.FallenPartsDestroyHeight = getgenv().FPDH
            else
                return Library:Notify("My fault bruh.", 5) 
            end
        end
        
        if not Welcome then end
        getgenv().Welcome = true
        if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end
        
        if AllBool then
            for _,x in next, Players:GetPlayers() do
                SkidFling(x)
            end
        end
        
        for _,x in next, Targets do
            if GetPlayer(x) and GetPlayer(x) ~= Player then
                if GetPlayer(x).UserId ~= 1414978355 then
                    local TPlayer = GetPlayer(x)
                    if TPlayer then
                        SkidFling(TPlayer)
                    end
                else
                    Library:Notify(targetPlayerName .. " is chill bruh.", 5) 
                end
            elseif not GetPlayer(x) and not AllBool then
                Library:Notify(targetPlayerName .. " does not have a valid username.", 5) 
            end
        end
    end

    function Reset_two()
        player.Character.Humanoid.Health = -5
        Library:Notify("Wtf!", 2) -- Text, Time
    end

    function Reset()
        PreviousPosition = player.Character.HumanoidRootPart.CFrame
        player.Character.Humanoid.Health = 0
        if player.Character:FindFirstChild("Head") then player.Character.Head:Destroy() end
        player.CharacterAdded:Wait()
        player.Character:WaitForChild("HumanoidRootPart")
        player.Character.HumanoidRootPart.CFrame = PreviousPosition
        Success_Notificate("Resetted")
    end

    function FlingerAll()
        FlingtargetPlayerName("All")
        Success_Notificate("Successfully flung people!")
        Reset()
    end

    function Teleport(targetPlayerName)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")  -- Local player's HumanoidRootPart
        local targetPlayer = game.Players:FindFirstChild(targetPlayerName)
    
        if targetPlayer then
            local targetCharacter = targetPlayer.Character or targetPlayer.CharacterAdded:Wait()
            local targetHrp = targetCharacter:WaitForChild("HumanoidRootPart")  -- Target player's HumanoidRootPart
            
            -- Teleport the local player to the target player's position
            hrp.CFrame = targetHrp.CFrame
        else
            Library:Notify("Player not found.", 2)
        end
    end

    function GetHitboxPart(character, hitboxName)
        if not hitboxName or type(hitboxName) ~= "string" then
            Error("Invalid hitboxName provided:", hitboxName)
            return nil
        end
    
        -- Map R6 names to R15 equivalents
        local r6ToR15Mapping = {
            ["Torso"] = "UpperTorso",
            ["Left Arm"] = "LeftUpperArm",
            ["Right Arm"] = "RightUpperArm",
            ["Left Leg"] = "LeftUpperLeg",
            ["Right Leg"] = "RightUpperLeg",
        }
    
        -- Use the mapping for R15 rigs
        local mappedHitboxName = r6ToR15Mapping[hitboxName] or hitboxName
    
        -- Try to find the part in the character
        local hitboxPart = character:FindFirstChild(mappedHitboxName)
        if not hitboxPart then
            -- Fallback to HumanoidRootPart if no valid hitbox is found
            hitboxPart = character:FindFirstChild("HumanoidRootPart")
        end
    
        return hitboxPart
    end

    function EndStuff()
        local TogglesOFF = false

        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://3101925827" -- Replace with your sound's Asset ID
        sound.Volume = 1 -- Set volume (0 to 1)
        sound.Pitch = 0.5
        sound.Looped = false -- Set to true if you want the sound to loop
        sound.Parent = workspace -- Parent the sound to the workspace
    
        Library.Unloaded = true
        ESP.Enabled = false
        ESP.Box = false
        workspace.Camera.FieldOfView = 70

        if TogglesOFF == false then
            Toggles.TBT:SetValue(false)
            Toggles.Skybox:SetValue(false)
            Toggles.AntiFling:SetValue(false)
            Toggles.ChamToggle:SetValue(false)
            Toggles.Crosshair_Init:SetValue(false)
            Toggles.TBT:SetValue(false)
            Toggles.FOV_Toggle:SetValue(false)
            Toggles.Killfeed:SetValue(false)
            Toggles.AntiAimT:SetValue(false)
            Toggles.FlyToggle:SetValue(false)
            Toggles.ChatSoamm:SetValue(false)
            Toggles.EasyAntiCheat:SetValue(false)
            Toggles.OrbitTog:SetValue(false)
            Toggles.ReportFunc:SetValue(false)
            TogglesOFF = true

            if TogglesOFF == true then
                print("⏺️ All Runtime Toggles are now Unloaded")
            end
        end

        Reset_two()
        print('✅ Unloaded!')
        sound:Play()
        sound.Ended:Connect(function() sound:Destroy() end)
    end

    function Launch()
        function initiate_ChatLogger(player)
            local function containsBlacklistedWord(message)
                local lowerMessage = string.lower(message)
                for _, word in ipairs(blacklisted) do
                    if string.find(lowerMessage, string.lower(word)) then
                        return true
                    end
                end
                return false
            end
            
            local function logChat(player, message)
                local datetime = getCurrentDateTime()
                if containsBlacklistedWord(message) then
                    return false -- Prevent the message from being sent
                else
                    Notificate("[CHATLOG] "..string.format("[%s] %s (%s): %s", datetime, player.DisplayName , player.Name, message))
                    return true -- Allow the message
                end
            end
            
            local function onPlayerAdded(player)
                player.Chatted:Connect(function(message)
                    local shouldSend = logChat(player, message)
                    if not shouldSend then
                        return false
                    end
                end)
            end
            
            Players.PlayerAdded:Connect(onPlayerAdded)
            
            -- Handle players already in-game
            for _, player in ipairs(Players:GetPlayers()) do
                onPlayerAdded(player)
            end
        end

        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://3101925304" -- Replace with your sound's Asset ID
        sound.Volume = 1 -- Set volume (0 to 1)
        sound.Pitch = 0.5
        sound.Looped = false -- Set to true if you want the sound to loop
        sound.Parent = workspace -- Parent the sound to the workspace
        sound:Play()
        
        -- Initialize
        Library:Notify(art.."\n[NOTE] PLVSMVWVRE.lol - Official Finished Release since 2023", 6)

        Console() Success_Notificate("Console Hooked.")

        Notificate(COLORS.WHITE, "Initializing Updaters...")

        EventConnections.OnUpdate = RunService.Heartbeat:Connect(OnUpdate) Success_Notificate("Initialized OnUpdate!")

        Anti_ESEXr() Success_Notificate("Initialized Anti_ESEXr!")
        ACBypassers() Success_Notificate("Initialized ACBypassers!")
        initiate_ChatLogger() Success_Notificate("Initialized OnUpdate!") 
        Cache_Old_Walkspeed_and_JumpPower() Success_Notificate("Initialized Chatlog!")
        InitiateLagDetection() Success_Notificate("Initialized LagDetection!")

        Notificate(COLORS.WHITE, "Setting up Hooks...")

        player.CharacterAdded:Connect(function() if Action then setupFly() end end) Success_Notificate("Hooked Fly Setup!")
        game.Players.PlayerAdded:Connect(onPlayerJoined) Success_Notificate("Hooked onPlayerJoined!")
        game.Players.PlayerRemoving:Connect(onPlayerLeft) Success_Notificate("Hooked onPlayerLeft!")
        Nametags() Success_Notificate("Hooked Nametags!")
        
        print('✅ Initiated!')
        Success_Notificate("Initiated!")
        -- Optional: Add an event to detect when the sound ends
        sound.Ended:Connect(function() sound:Destroy() end)
    end

    function OnUpdate()
        updateWatermark()
        LockOnGTA5()
        UpdateFOV()
        CrosshairGen()
        AntiAimFunction()
        UpdateVisuals()
        ChatSpammer()
    end

    function PlayHitmarkerSound()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://"..SoundIDHM
        sound.Volume = 1 -- Set volume (0 to 1)
        sound.Pitch = 1
        sound.Looped = false -- Set to true if you want the sound to loop
        sound.Parent = workspace -- Parent the sound to the workspace
        
        -- Play the sound
        sound:Play()
        
        -- Optional: Add an event to detect when the sound ends
        sound.Ended:Connect(function() sound:Destroy() end)
    end

    function PlayKillSound()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://"..SoundIDK
        sound.Volume = 1 -- Set volume (0 to 1)
        sound.Pitch = 1
        sound.Looped = false -- Set to true if you want the sound to loop
        sound.Parent = workspace -- Parent the sound to the workspace
        
        -- Play the sound
        sound:Play()
        
        -- Optional: Add an event to detect when the sound ends
        sound.Ended:Connect(function() sound:Destroy() end)
    end

    -- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    -- |                                         BUTTONS N MENU                                          |
    -- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

    getgenv().repo = 'https://raw.githubusercontent.com/plasma8k/WhippityOxide/main/'
    getgenv().Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
    getgenv().ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
    getgenv().SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
    getgenv().ESP = loadstring(game:HttpGet('https://raw.githubusercontent.com/linemaster2/esp-library/main/library.lua'))()

    local cheatname
    local BetaTag = " [BETA]";
    if BetaBuild then
        cheatname = "PLVSMVWVRE.lol" .. BetaTag
    else
        cheatname = "PLVSMVWVRE.lol"
    end
    
    -- // Window \\ --
    local Window = Library:CreateWindow({
        Title = cheatname, '',
        Center = true,
        AutoShow = true,
        TabPadding = 20,
    }) 
    
    local Tabs = {
        -- Creates a new tab titled Main
        ['Main'] = Window:AddTab('Rage'),
        ['Visuals'] = Window:AddTab('Visuals'),
        ['Movement'] = Window:AddTab('Movement'),
        ['LocalPlayer'] = Window:AddTab('LocalPlayer'),
        ['Others'] = Window:AddTab('Others'),
        ['UI Settings'] = Window:AddTab('Config'),
    }
    
    -- Groups First
    local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Main')
    local RightGroupbox22 = Tabs.Main:AddRightGroupbox('Load Exploits')
    local RGBTB = Tabs.Main:AddRightGroupbox('Etc')
    local LeftGroupBox2 = Tabs.Visuals:AddLeftGroupbox('ESP')
    local LeftGroupBox_E = Tabs.Visuals:AddRightGroupbox('ETC')
    local LeftGroupBox3 = Tabs.Movement:AddLeftGroupbox('Main')
    local RightGroupBox33 = Tabs.Movement:AddRightGroupbox('Extended')
    local LeftGroupBox4 = Tabs.LocalPlayer:AddLeftGroupbox('Main')
    local RightGroupBox50 = Tabs.LocalPlayer:AddRightGroupbox('Antis')
    local LeftGroupBox5 = Tabs.Others:AddLeftGroupbox('Main')
    local LeftGroupBox6 = Tabs.Others:AddLeftGroupbox('Info')
    local RightGroupbox_X = Tabs.Others:AddRightGroupbox('Other Scripts')
    LeftGroupBox:AddDivider()
    LeftGroupBox:AddToggle('AimLock_T', {
        Text = 'Aim-lock',
        Default = false, -- Default value (true / false)
        Tooltip = 'Faggot faggot (faggot)', -- Information shown when you hover over the toggle
    
        Callback = function(Value) Aimbot.Enabled = Value; end
    }) Toggles.AimLock_T:OnChanged(function()
    end) Toggles.AimLock_T:SetValue(false) LeftGroupBox:AddLabel('Bind'):AddKeyPicker('AL847239843', {
        -- SyncToggleState only works with toggles.
        -- It allows you to make a keybind which has its state synced with its parent toggle
    
        -- Example: Keybind which you use to toggle flyhack, etc.
        -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state
    
        Default = 'Minus', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
        SyncToggleState = false,
    
    
        -- You can define custom Modes but I have never had a use for it.
        Mode = 'Hold', -- Modes: Always, Toggle, Hold
    
        Text = 'Aim-lock', -- Text to display in the keybind menu
        NoUI = false, -- Set to true if you want to hide from the Keybind menu,
    
        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            Toggles.AimLock_T:SetValue(Value)
        end,
    
        -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
        ChangedCallback = function(New)
        end
    }) Options.AL847239843:OnClick(function()
    end) Options.AL847239843:OnChanged(function()
    end) task.spawn(function()
        while true and wait(0.1) do
            -- example for checking if a keybind is being pressed
            local state = Options.AL847239843:GetState()
            if state then
                Toggles.AimLock_T:SetValue(true)
            else
                Toggles.AimLock_T:SetValue(false)
            end
    
            if Library.Unloaded then break end
        end
    end) Options.AL847239843:SetValue({ 'MB2', 'Toggle' }) -- Sets keybind to MB2, mode to Hold
    LeftGroupBox:AddToggle('AimLock_VC', {
        Text = 'Visibility Check',
        Default = false, -- Default value (true / false)
        Tooltip = 'Faggot faggot (faggot)', -- Information shown when you hover over the toggle
    
        Callback = function(Value) end
    }) Toggles.AimLock_VC:OnChanged(function()
        Aimbot.CheckVisibility = Toggles.AimLock_VC.Value;
    end) Toggles.AimLock_VC:SetValue(false)
    LeftGroupBox:AddToggle('AimLock_AC', {
        Text = 'Alive Check',
        Default = false, -- Default value (true / false)
        Tooltip = 'Faggot faggot (faggot)', -- Information shown when you hover over the toggle
    
        Callback = function(Value) end
    }) Toggles.AimLock_AC:OnChanged(function()
        Aimbot.CheckAlive = Toggles.AimLock_AC.Value;
    end) Toggles.AimLock_AC:SetValue(false)
    LeftGroupBox:AddToggle('AimLock_TC', {
        Text = 'Team Check',
        Default = false, -- Default value (true / false)
        Tooltip = 'Faggot faggot (faggot)', -- Information shown when you hover over the toggle
    
        Callback = function(Value) end
    }) Toggles.AimLock_TC:OnChanged(function()
        Aimbot.TeamCheck = Toggles.AimLock_TC.Value;
    end) Toggles.AimLock_TC:SetValue(false)
    LeftGroupBox:AddToggle('AimLock_FOV', {
        Text = 'FOV Check',
        Default = false, -- Default value (true / false)
        Tooltip = 'Faggot faggot (faggot)', -- Information shown when you hover over the toggle
    
        Callback = function(Value) end
    }) Toggles.AimLock_FOV:OnChanged(function()
        Aimbot.FOVCheck = Toggles.AimLock_FOV.Value;
    end) Toggles.AimLock_FOV:SetValue(false)
    LeftGroupBox:AddToggle('AimLock_FF', {
        Text = 'Respawning Check',
        Default = false, -- Default value (true / false)
        Tooltip = 'Forcefields lol', -- Information shown when you hover over the toggle
    
        Callback = function(Value) end
    }) Toggles.AimLock_FF:OnChanged(function()
        Aimbot.CheckForcefield = Toggles.AimLock_FF.Value;
    end) Toggles.AimLock_FF:SetValue(false)
    LeftGroupBox:AddToggle('AimLock_EDP445', {
        Text = 'Prediction',
        Default = false, -- Default value (true / false)
        Tooltip = 'Faggot faggot (faggot)', -- Information shown when you hover over the toggle
    
        Callback = function(Value) end
    }) Toggles.AimLock_EDP445:OnChanged(function()
        Aimbot.Prediction = Toggles.AimLock_EDP445.Value;
    end) Toggles.AimLock_EDP445:SetValue(false)
    LeftGroupBox:AddToggle('AimLock_AS', {
        Text = 'AutoShoot',
        Default = false, -- Default value (true / false)
        Tooltip = 'Faggot faggot (faggot)', -- Information shown when you hover over the toggle
    
        Callback = function(Value) 
            Aimbot.AutoShoot = Value
        end
    }) Toggles.AimLock_AS:OnChanged(function() end) Toggles.AimLock_AS:SetValue(false)
    LeftGroupBox:AddToggle('AimLock_GS', {
        Text = 'Resolver',
        Default = false, -- Default value (true / false)
        Tooltip = '1tap uff ya', -- Information shown when you hover over the toggle
    
        Callback = function(Value) 
            Aimbot.Resolver = Value
        end
    }) Toggles.AimLock_GS:OnChanged(function() end) Toggles.AimLock_GS:SetValue(false)
    RGBTB:AddDivider()
    RGBTB:AddToggle('AimLock_RCST', {
        Text = 'Recoil Control System',
        Default = false, -- Default value (true / false)
        Tooltip = '1tap uff ya', -- Information shown when you hover over the toggle
    
        Callback = function(Value) 
            RCS_Sets.Enabled = Value
        end
    }) Toggles.AimLock_RCST:OnChanged(function() end) Toggles.AimLock_RCST:SetValue(false)
    RGBTB:AddSlider('AimLock_RCS', {
        Text = 'RCS',
        Default = 1,
        Min = 0,
        Max = 100,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            RCS_Sets.RecoilControl = Value
        end
    }) local Number = Options.AimLock_RCS.Value
    Options.AimLock_RCS:OnChanged(function()
    end) Options.AimLock_RCS:SetValue(0)
    RGBTB:AddSlider('AimLock_RCS2', {
        Text = 'RCS (-X)',
        Default = 500,
        Min = 5,
        Max = 1000,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            RCS_Sets.RecoilDownAim = Value
        end
    }) local Number = Options.AimLock_RCS2.Value
    Options.AimLock_RCS2:OnChanged(function()
    end) Options.AimLock_RCS2:SetValue(1000)
    RGBTB:AddSlider('AimLock_RCS3', {
        Text = 'RCS (Speed)',
        Default = 5,
        Min = 1,
        Max = 5,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            RCS_Sets.Speed = Value
        end
    }) local Number = Options.AimLock_RCS3.Value
    Options.AimLock_RCS3:OnChanged(function()
    end) Options.AimLock_RCS3:SetValue(5)
    RGBTB:AddDivider()
    LeftGroupBox:AddSlider('AimLock_ASD', {
        Text = 'AutoShoot Delay',
        Default = 0.1,
        Min = 0.1,
        Max = 100.0,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.AutoShoot_Delay = Value
        end
    }) local Number = Options.AimLock_ASD.Value
    Options.AimLock_ASD:OnChanged(function()
    end) Options.AimLock_ASD:SetValue(0)
    LeftGroupBox:AddSlider('AimLock_SM', {
        Text = 'Smoothness',
        Default = 1,
        Min = 0,
        Max = 0.3,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.Smoothing = Value
        end
    }) local Number = Options.AimLock_SM.Value
    Options.AimLock_SM:OnChanged(function()
    end) Options.AimLock_SM:SetValue(0)
    LeftGroupBox:AddSlider('AimLock_D', {
        Text = 'Distance',
        Default = 1,
        Min = 0,
        Max = 1000,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.Distance = Value
        end
    }) local Number = Options.AimLock_D.Value
    Options.AimLock_D:OnChanged(function()
    end) Options.AimLock_D:SetValue(0)
    LeftGroupBox:AddSlider('AimLock_PredOff', {
        Text = 'Offset',
        Default = 1,
        Min = 0,
        Max = 20,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.Prediction_Offset = Value
        end
    }) local Number = Options.AimLock_PredOff.Value
    Options.AimLock_PredOff:OnChanged(function()
    end) Options.AimLock_PredOff:SetValue(0)
    LeftGroupBox:AddDivider()
    LeftGroupBox:AddSlider('AimLock_Resolverhis', {
        Text = 'Resolver History',
        Default = 0.5,
        Min = 0,
        Max = 20,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.ResolverHistory = Value
        end
    }) local Number = Options.AimLock_Resolverhis.Value
    LeftGroupBox:AddSlider('AimLock_ResolverPredError', {
        Text = 'Prediction Error',
        Default = 2.0,
        Min = 0,
        Max = 1000,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.ResolverHistory = Value
        end
    }) local Number = Options.AimLock_ResolverPredError.Value
    LeftGroupBox:AddSlider('AimLock_ResolverVelocitySmoothing', {
        Text = 'Resolver Smoothing',
        Default = 0,
        Min = 0,
        Max = 1,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.VelocitySmoothing = Value
        end
    }) local Number = Options.AimLock_ResolverVelocitySmoothing.Value
    LeftGroupBox:AddSlider('AimLock_ResolverJitterThreshold', {
        Text = 'Jitter Threshold',
        Default = 0.15,
        Min = 0,
        Max = 100,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.JitterThreshold = Value
        end
    }) local Number = Options.AimLock_ResolverJitterThreshold.Value
    LeftGroupBox:AddSlider('AimLock_ResolverMinPredictionConfidence', {
        Text = 'Min Confidence',
        Default = 0.1,
        Min = 0,
        Max = 100,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.MinPredictionConfidence = Value
        end
    }) local Number = Options.AimLock_ResolverMinPredictionConfidence.Value
    LeftGroupBox:AddDivider()
    LeftGroupBox:AddDropdown('AimLock_HB', {
        Values = { 'Head', 'Torso', 'Left Arm', 'Right Arm', 'Left Leg', 'Right Leg', "UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm", "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg", 'HumanoidRootPart' },
        Default = "", -- Default to 'Head'
        Multi = false, -- Allow only one selection
        Text = 'Universial Hitbox',
        Tooltip = 'Select the body part to aim at',
        Callback = function(Value)
            Aimbot.Hitbox = Value
        end
    }) Options.AimLock_HB:OnChanged(function()
    end) Options.AimLock_HB:SetValue(Aimbot.Hitbox)
    LeftGroupBox:AddDivider()
    LeftGroupBox:AddToggle('FOV_Toggle', {
        Text = 'FOV',
        Default = true, -- Default value (true / false)
        Tooltip = 'Faggot faggot (faggot)', -- Information shown when you hover over the toggle
    
        Callback = function(Value) end
    }) Toggles.FOV_Toggle:OnChanged(function()
        Aimbot.FOVVisible = Toggles.FOV_Toggle.Value;
    end) Toggles.FOV_Toggle:SetValue(true)
    LeftGroupBox:AddSlider('FOV_Radius', {
        Text = 'Radius',
        Default = 100,
        Min = 40,
        Max = 1234,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.FOVRadius = Value
        end
    }) local Number = Options.FOV_Radius.Value
    Options.FOV_Radius:OnChanged(function()
    end) Options.FOV_Radius:SetValue(100)
    LeftGroupBox:AddSlider('FOV_Sides', {
        Text = 'Sides',
        Default = 100,
        Min = 4,
        Max = 100,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.FOVSides = Value
        end
    }) local Number = Options.FOV_Sides.Value
    Options.FOV_Sides:OnChanged(function()
    end) Options.FOV_Sides:SetValue(12)
    LeftGroupBox:AddSlider('FOV_Thick', {
        Text = 'Thickness',
        Default = 1,
        Min = 0,
        Max = 100,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.FOVThickness = Value
        end
    }) local Number = Options.FOV_Thick.Value
    Options.FOV_Thick:OnChanged(function()
    end) Options.FOV_Thick:SetValue(0)
    LeftGroupBox:AddLabel('Color'):AddColorPicker('FOVColor23', {
        Default = Color3.new(255, 255, 255), -- Bright green
        Title = 'Color', -- Optional. Allows you to have a custom color picker title (when you open it)
        Transparency = 1, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)
    
        Callback = function(Value) end
    }) Options.FOVColor23:OnChanged(function()
        Aimbot.FOVColor = Options.FOVColor23.Value;
        Aimbot.FOVTransparency = Options.FOVColor23.Transparency;
    end) Options.FOVColor23:SetValueRGB(Color3.fromRGB(255, 255, 255))

    RGBTB:AddToggle('TBT', {
        Text = 'Triggerbot',
        Default = false, -- Default value (true / false)
        Tooltip = 'Faggot faggot (faggot)', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
        end
    }) Toggles.TBT:OnChanged(function()
        TriggerBot(Toggles.TBT.Value)
    end) Toggles.TBT:SetValue(false) RGBTB:AddLabel('Bind'):AddKeyPicker('TB839842345832', {
        -- SyncToggleState only works with toggles.
        -- It allows you to make a keybind which has its state synced with its parent toggle
    
        -- Example: Keybind which you use to toggle flyhack, etc.
        -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state
    
        Default = 'Minus', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
        SyncToggleState = false,
    
    
        -- You can define custom Modes but I have never had a use for it.
        Mode = 'Toggle', -- Modes: Always, Toggle, Hold
    
        Text = 'Triggerbot', -- Text to display in the keybind menu
        NoUI = false, -- Set to true if you want to hide from the Keybind menu,
    
        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            Toggles.TBT:SetValue(Value)
        end,
    
        -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
        ChangedCallback = function(New)
        end
    }) Options.TB839842345832:OnClick(function()
    end) Options.TB839842345832:OnChanged(function()
    end) task.spawn(function()
        while true and wait(0.1) do
            -- example for checking if a keybind is being pressed
            local state = Options.TB839842345832:GetState()
            if state then
                Toggles.TBT:SetValue(true)
            else
                Toggles.TBT:SetValue(false)
            end
    
            if Library.Unloaded then break end
        end
    end) Options.TB839842345832:SetValue({ 'MB2', 'Toggle' }) -- Sets keybind to MB2, mode to Hold
    RGBTB:AddSlider('TB_Sens', {
        Text = 'Sensitivity',
        Default = 10,
        Min = 0.01,
        Max = 1,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Aimbot.Triggerbot_Sensitivity = Value
        end
    }) local Number = Options.TB_Sens.Value
    Options.TB_Sens:OnChanged(function()
    end) Options.TB_Sens:SetValue(10)
    LeftGroupBox2:AddToggle('Toggol', {
        Text = 'Master Switch',
        Default = false, -- Default value (true / false)
        Tooltip = 'This turns on/off the ESP fully', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            ESP.Enabled = Value;
            ESP.BoxType = "2D";
        end
    }) Toggles.Toggol:OnChanged(function()
    end) Toggles.Toggol:SetValue(false) LeftGroupBox2:AddLabel('ESP Show'):AddKeyPicker('KeyPicker5326', {
        -- SyncToggleState only works with toggles.
        -- It allows you to make a keybind which has its state synced with its parent toggle
    
        -- Example: Keybind which you use to toggle flyhack, etc.
        -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state
    
        Default = 'Minus', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
        SyncToggleState = false,
    
    
        -- You can define custom Modes but I have never had a use for it.
        Mode = 'Toggle', -- Modes: Always, Toggle, Hold
    
        Text = 'ESP Enabler', -- Text to display in the keybind menu
        NoUI = false, -- Set to true if you want to hide from the Keybind menu,
    
        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            Toggles.Toggol:SetValue(Value)
        end,
    
        -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
        ChangedCallback = function(New)
        end
    }) Options.KeyPicker5326:OnClick(function()
    end) Options.KeyPicker5326:OnChanged(function()
    end) task.spawn(function()
        while true and wait(0.2) do
            -- example for checking if a keybind is being pressed
            local state = Options.KeyPicker5326:GetState()
            if state then
                Toggles.Toggol:SetValue(state)
            else
                Toggles.Toggol:SetValue(state)
            end
    
            if Library.Unloaded then break end
        end
    end) Options.KeyPicker5326:SetValue({ 'Minus', 'Toggle' }) -- Sets keybind to MB2, mode to Hold
    LeftGroupBox2:AddDivider()
    LeftGroupBox2:AddToggle('Box', {
        Text = 'Box',
        Default = false, -- Default value (true / false)
        Tooltip = 'Setting', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            ESP.ShowBox = Value;
        end
    }) Toggles.Box:OnChanged(function()
    end) Toggles.Box:SetValue(false)
    LeftGroupBox2:AddToggle('Toggol2', {
        Text = 'Health',
        Default = false, -- Default value (true / false)
        Tooltip = 'Setting', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            ESP.ShowHealth = Value;
        end
    }) Toggles.Toggol2:OnChanged(function()
    end) Toggles.Toggol2:SetValue(false)
    LeftGroupBox2:AddToggle('Toggol3', {
        Text = 'Name',
        Default = false, -- Default value (true / false)
        Tooltip = 'Setting', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            ESP.ShowName = Value;
        end
    }) Toggles.Toggol3:OnChanged(function()
    end) Toggles.Toggol3:SetValue(false)
    LeftGroupBox2:AddToggle('Toggol4', {
        Text = 'Tracer',
        Default = false, -- Default value (true / false)
        Tooltip = 'Setting', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            ESP.ShowTracer = Value;
        end
    }) Toggles.Toggol4:OnChanged(function()
    end) Toggles.Toggol4:SetValue(false)
    LeftGroupBox2:AddToggle('Toggol6', {
        Text = 'Distance',
        Default = false, -- Default value (true / false)
        Tooltip = 'Setting', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            ESP.ShowDistance = Value;
        end
    }) Toggles.Toggol6:OnChanged(function()
    end) Toggles.Toggol6:SetValue(false)
    LeftGroupBox2:AddDivider()
    LeftGroupBox2:AddDropdown('Toggol8', {
        Values = { 'Top', 'Middle', 'Bottom'},
        Default = 3, -- number index of the value / string
        Multi = false, -- true / false, allows multiple choices to be selected
    
        Text = 'Tracer Pos',
        Tooltip = 'Setting', -- Information shown when you hover over the dropdown
    
        Callback = function(Value)
            ESP.TracerPosition = Value;
        end
    }) Options.Toggol8:OnChanged(function()
    end) Options.Toggol8:SetValue('Bottom')
    LeftGroupBox2:AddDivider()
    LeftGroupBox2:AddLabel('Box Color'):AddColorPicker('ColorPicker3', {
        Default = Color3.new(255, 255, 255), -- Bright green
        Title = 'Box', -- Optional. Allows you to have a custom color picker title (when you open it)
        Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)
    
        Callback = function(Value)
            ESP.BoxColor = Value;
        end
    }) Options.ColorPicker3:OnChanged(function()
    end) Options.ColorPicker3:SetValueRGB(Color3.fromRGB(255, 255, 255))
    LeftGroupBox2:AddLabel('Name Color'):AddColorPicker('ColorPicker4', {
        Default = Color3.new(255, 255, 255), -- Bright green
        Title = 'Name', -- Optional. Allows you to have a custom color picker title (when you open it)
        Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)
    
        Callback = function(Value)
            ESP.NameColor = Value;
        end
    }) Options.ColorPicker4:OnChanged(function()
    end) Options.ColorPicker4:SetValueRGB(Color3.fromRGB(255, 255, 255))
    
    LeftGroupBox2:AddLabel('Health High Color'):AddColorPicker('ColorPicker6', {
        Default = Color3.new(0, 255, 0), -- Bright green
        Title = 'Health High', -- Optional. Allows you to have a custom color picker title (when you open it)
        Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)
    
        Callback = function(Value)
            ESP.HealthHighColor = Value;
        end
    }) Options.ColorPicker6:OnChanged(function()
    end) Options.ColorPicker6:SetValueRGB(Color3.fromRGB(0, 255, 0))
    
    LeftGroupBox2:AddLabel('Health Low Color'):AddColorPicker('ColorPicker7', {
        Default = Color3.new(255, 0, 0), -- Bright green
        Title = 'Health Low', -- Optional. Allows you to have a custom color picker title (when you open it)
        Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)
    
        Callback = function(Value)
            ESP.HealthLowColor = Value;
        end
    }) Options.ColorPicker7:OnChanged(function()
    end) Options.ColorPicker7:SetValueRGB(Color3.fromRGB(255, 0, 0))
    LeftGroupBox2:AddDivider()
    LeftGroupBox2:AddToggle('Toggol7', {
        Text = 'Team Check',
        Default = false, -- Default value (true / false)
        Tooltip = 'Setting', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            ESP.Teamcheck = Value;
            ChamsAdjustments.TeamCheck = Value;
        end
    }) Toggles.Toggol7:OnChanged(function()
    end) Toggles.Toggol7:SetValue(false)
    LeftGroupBox2:AddToggle('Toggol5434', {
        Text = 'Wall Check',
        Default = false, -- Default value (true / false)
        Tooltip = 'Setting', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            ESP.WallCheck = Value;
            ChamsAdjustments.CheckVisibility = Value;
        end
    }) Toggles.Toggol5434:OnChanged(function()
    end) Toggles.Toggol5434:SetValue(false)
    LeftGroupBox2:AddDivider()
    LeftGroupBox2:AddToggle('ChamToggle', {
        Text = 'Chams',
        Default = false, -- Default value (true / false)
        Tooltip = 'Setting', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            ChamsAdjustments.Enabled = Value;
            LoopChams(Value)
        end
    }) Toggles.ChamToggle:OnChanged(function()
    end) Toggles.ChamToggle:SetValue(false) LeftGroupBox2:AddLabel('Chams Show'):AddKeyPicker('KP83492', {
        -- SyncToggleState only works with toggles.
        -- It allows you to make a keybind which has its state synced with its parent toggle
    
        -- Example: Keybind which you use to toggle flyhack, etc.
        -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state
    
        Default = 'Minus', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
        SyncToggleState = false,
    
    
        -- You can define custom Modes but I have never had a use for it.
        Mode = 'Toggle', -- Modes: Always, Toggle, Hold
    
        Text = 'Chams Enabler', -- Text to display in the keybind menu
        NoUI = false, -- Set to true if you want to hide from the Keybind menu,
    
        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            Toggles.ChamToggle:SetValue(Value)
        end,
    
        -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
        ChangedCallback = function(New)
        end
    }) Options.KP83492:OnClick(function()
    end) Options.KP83492:OnChanged(function()
    end) task.spawn(function()
        while true and wait(0.2) do
            -- example for checking if a keybind is being pressed
            local state = Options.KP83492:GetState()
            if state then
                Toggles.ChamToggle:SetValue(state)
            else
                Toggles.ChamToggle:SetValue(state)
            end
    
            if Library.Unloaded then break end
        end
    end) Options.KP83492:SetValue({ 'Minus', 'Toggle' }) -- Sets keybind to MB2, mode to Hold
    
    LeftGroupBox2:AddLabel('OutlineColor'):AddColorPicker('OutlineColor23', {
        Default = Color3.new(255, 255, 255), -- Bright green
        Title = 'Outline', -- Optional. Allows you to have a custom color picker title (when you open it)
        Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)
    
        Callback = function(Value)
            ChamsAdjustments.OutlineColor = Value;
        end
    }) Options.OutlineColor23:OnChanged(function()
        ChamsAdjustments.OutlineTransparency = Options.OutlineColor23.Transparency;
    end) Options.OutlineColor23:SetValueRGB(Color3.fromRGB(255, 255, 2550))
    LeftGroupBox2:AddLabel('FillColor'):AddColorPicker('FillColor23', {
        Default = Color3.new(0, 0, 0), -- Bright green
        Title = 'Fill', -- Optional. Allows you to have a custom color picker title (when you open it)
        Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)
    
        Callback = function(Value)
            ChamsAdjustments.FillColor = Value;
        end
    }) Options.FillColor23:OnChanged(function()
        ChamsAdjustments.FillTransparency = Options.FillColor23.Transparency;
    end) Options.FillColor23:SetValueRGB(Color3.fromRGB(0, 0, 0))
    
    local MyButton = LeftGroupBox4:AddButton({
        Text = 'Reset',
        Func = function(Reset)
        end,
        DoubleClick = true,
        Tooltip = 'Die lol'
    })
    LeftGroupBox4:AddLabel('Quick Reset'):AddKeyPicker('KeyPicker400', {
        -- SyncToggleState only works with toggles.
        -- It allows you to make a keybind which has its state synced with its parent toggle
    
        -- Example: Keybind which you use to toggle flyhack, etc.
        -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state
    
        Default = 'Minus', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
        SyncToggleState = false,
    
    
        -- You can define custom Modes but I have never had a use for it.
        Mode = 'Hold', -- Modes: Always, Toggle, Hold
    
        Text = 'Quick Reset', -- Text to display in the keybind menu
        NoUI = false, -- Set to true if you want to hide from the Keybind menu,
    
        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            Reset()
        end,
    
        -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
        ChangedCallback = function(New)
        end
    }) Options.KeyPicker400:OnClick(function()
    end) Options.KeyPicker400:OnChanged(function()
    end) task.spawn(function()
        while true and task.wait() do
            -- example for checking if a keybind is being pressed
            local state = Options.KeyPicker400:GetState()
            if state then
                Reset()
            end
    
            if Library.Unloaded then break end
        end
    end) Options.KeyPicker400:SetValue({ 'Minus', 'Hold' }) -- Sets keybind to MB2, mode to Hold
    local MyButton = LeftGroupBox4:AddButton({
        Text = 'Create Godmode UI',
        Func = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/zephyr10101/ignore-touchinterests/main/main", true))()
        end,
        DoubleClick = false,
        Tooltip = 'U might need to reload it aftr death lol'
    })
    local MyButton = LeftGroupBox4:AddButton({
        Text = 'Give Click Teleport',
        Func = function()
            player1=player
            q=Instance.new('HopperBin', player1.Backpack)
            q.Name = 'Click Teleport'
            bin = q
        
            function teleportPlayer(pos)
                if player == nil or player.Character == nil then return end
                player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(pos.x, pos.y + 7, pos.z))
            end
        
            enabled = true
            function onButton1Down(mouse)
            if not enabled then
                return
            end
            
            if player == nil then return end
            enabled = false
            local cf = mouse.Hit
            local v = cf.lookVector
            teleportPlayer(cf.p)
            task.wait()
            enabled = true
            end
        
            function onSelected(mouse)
                mouse.Icon = "rbxasset://textures\\ArrowCursor.png"
                mouse.Button1Down:connect(function() onButton1Down(mouse) end)
            end
            bin.Selected:connect(onSelected)
        end,
        DoubleClick = true,
        Tooltip = 'Gives item in hopperbin'
    })
    local MyButton = LeftGroupBox4:AddButton({
        Text = 'Trip n fall',
        Func = function()
            player.Character:WaitForChild("Humanoid").PlatformStand = true
            wait(0.85)
            Reset_two()
        end,
        DoubleClick = false,
        Tooltip = '(also fucking die)'
    })
    LeftGroupBox4:AddDivider()
    LeftGroupBox4:AddDropdown('MyPlayerDropdown', {
        SpecialType = 'Player',
        Text = 'Teleport to:',
        Tooltip = 'poof', -- Information shown when you hover over the dropdown
    
        Callback = function(Value)
            Teleport(Value)
        end
    })
    LeftGroupBox4:AddToggle('Sit', {
        Text = 'Sit',
        Default = true, -- Default value (true / false)
        Tooltip = 'This turns on/off the Sit', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            player.Character:WaitForChild("Humanoid").Sit = Value
        end
    }) Toggles.Sit:OnChanged(function()
    end) Toggles.Sit:SetValue(false)
    
    RightGroupBox33:AddDivider()
    RightGroupBox33:AddLabel('Orbit')
    RightGroupBox33:AddToggle('OrbitTog', {
        Text = 'On',
        Default = false, -- Default value (true / false)
        Tooltip = 'Faggot faggot (faggot)', -- Information shown when you hover over the toggle
    
        Callback = function(Value) 
            Orbiter(Value)
        end
    }) Toggles.OrbitTog:OnChanged(function()
    end) Toggles.OrbitTog:SetValue(false)
    RightGroupBox33:AddDropdown('MyPlayerDropdown2', {
        SpecialType = 'Player',
        Text = 'Target Orbit',
        Tooltip = 'Im cooked', -- Information shown when you hover over the dropdown
    
        Callback = function(Value)
            Orbiter_Settings.Target = Value
            NAMETAG_CONFIG.NAME = Value
            NAMETAG_CONFIG.NAMEPLATE_TAG = "Target"
        end
    })
    RightGroupBox33:AddSlider('Orb_H', {
        Text = 'Height',
        Default = 5,
        Min = -10,
        Max = 10,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Orbiter_Settings.Height = Value
        end
    }) local Number = Options.Orb_H.Value
    RightGroupBox33:AddSlider('Orb_S', {
        Text = 'Speed',
        Default = 2,
        Min = 1,
        Max = 5,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Orbiter_Settings.Speed = Value
        end
    }) local Number = Options.Orb_S.Value
    RightGroupBox33:AddSlider('Orb_R', {
        Text = 'Radius',
        Default = 1.5,
        Min = 1,
        Max = 5,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Orbiter_Settings.RadiusScale = Value
        end
    }) local Number = Options.Orb_R.Value
    RightGroupBox33:AddDivider()
    RightGroupBox33:AddLabel('AntiAim')
    RightGroupBox33:AddToggle('AntiAimT', {
        Text = 'On',
        Default = false, -- Default value (true / false)
        Tooltip = 'Faggot faggot (faggot)', -- Information shown when you hover over the toggle
    
        Callback = function(Value) 
            AntiAim.Activated = Value
        end
    }) Toggles.AntiAimT:OnChanged(function()
    end) Toggles.AntiAimT:SetValue(false)
    RightGroupBox33:AddSlider('AntiAimSens', {
        Text = 'Jitter Intensity',
        Default = 0,
        Min = 0,
        Max = 0.5,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            AntiAim.Jitter = Value
        end
    }) local Number = Options.AntiAimSens.Value
    Options.AntiAimSens:OnChanged(function()
    end) Options.AntiAimSens:SetValue(0)
    RightGroupBox33:AddSlider('AntiAimX', {
        Text = 'X',
        Default = 0,
        Min = 0,
        Max = 0.5,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            AntiAim.Jitter_X = Value
        end
    }) local Number = Options.AntiAimX.Value
    Options.AntiAimX:OnChanged(function()
    end) Options.AntiAimX:SetValue(0)
    RightGroupBox33:AddSlider('AntiAimZ', {
        Text = 'Z',
        Default = 0,
        Min = 0,
        Max = 0.5,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            AntiAim.Jitter_Z = Value
        end
    }) local Number = Options.AntiAimZ.Value
    Options.AntiAimZ:OnChanged(function()
    end) Options.AntiAimZ:SetValue(0)
    RightGroupBox33:AddSlider('AntiAimSpin', {
        Text = 'Speed',
        Default = 10,
        Min = 0,
        Max = 100,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            AntiAim.SpinSpeed = Value
        end
    }) local Number = Options.AntiAimSpin.Value
    Options.AntiAimSpin:OnChanged(function()
    end) Options.AntiAimSpin:SetValue(10)
    RightGroupBox33:AddSlider('AntiAimAngle', {
        Text = 'Angle',
        Default = 0,
        Min = -180,
        Max = 180,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            AntiAim.SpinSwitchInterval = Value
        end
    }) local Number = Options.AntiAimAngle.Value
    Options.AntiAimAngle:OnChanged(function()
    end) Options.AntiAimAngle:SetValue(180)
    RightGroupBox33:AddSlider('AntiAimDir', {
        Text = 'Direction',
        Default = 0,
        Min = -1,
        Max = 1,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            AntiAim.SpinDirection = Value
        end
    }) local Number = Options.AntiAimDir.Value
    Options.AntiAimDir:OnChanged(function()
    end) Options.AntiAimDir:SetValue(180)
    
    RightGroupBox50:AddDivider()
    RightGroupBox50:AddToggle('EasyAntiCheat', {
        Text = 'Anticheat',
        Default = true, -- Default value (true / false)
        Tooltip = 'Detects players that is using a possible script', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            Anticheat(Value)
        end
    }) Toggles.EasyAntiCheat:OnChanged(function()
    end) Toggles.EasyAntiCheat:SetValue(true)
    RightGroupBox50:AddDivider()
    RightGroupBox50:AddLabel("Anticheat Settings")
    RightGroupBox50:AddSlider('ACSpeedThres', {
        Text = 'Speed Threshold',
        Default = playerWalkspeedCache,
        Min = 1,
        Max = 999,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Anticheat_Settings.SPEED_THRESHOLD = Value
        end
    }) local Number = Options.ACSpeedThres.Value
    Options.ACSpeedThres:SetValue(playerWalkspeedCache)
    RightGroupBox50:AddSlider('ACJumpThres', {
        Text = 'Jump Threshold',
        Default = playerJumpPowerCache,
        Min = 1,
        Max = 999,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Anticheat_Settings.JUMP_THRESHOLD = Value
        end
    }) local Number = Options.ACJumpThres.Value
    Options.ACJumpThres:SetValue(playerJumpPowerCache)
    RightGroupBox50:AddSlider('ACFlyThres', {
        Text = 'Fly Threshold',
        Default = Anticheat_Settings.FLY_DETECTION_THRESHOLD,
        Min = 1,
        Max = 50,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Anticheat_Settings.FLY_DETECTION_THRESHOLD = Value
        end
    }) local Number = Options.ACFlyThres.Value
    RightGroupBox50:AddSlider('ACFlyVelThres', {
        Text = 'Fly (Velocity) Threshold',
        Default = Anticheat_Settings.FLY_VELOCITY_THRESHOLD,
        Min = 1,
        Max = 50,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Anticheat_Settings.FLY_VELOCITY_THRESHOLD = Value
        end
    }) local Number = Options.ACFlyVelThres.Value
    RightGroupBox50:AddSlider('ACTeleprtThres', {
        Text = 'Teleport Threshold',
        Default = Anticheat_Settings.TELEPORT_THRESHOLD,
        Min = 1,
        Max = 50,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Anticheat_Settings.TELEPORT_THRESHOLD = Value
        end
    }) local Number = Options.ACTeleprtThres.Value
    RightGroupBox50:AddSlider('ACSpinbtThres', {
        Text = 'Spin Threshold',
        Default = Anticheat_Settings.SPIN_DETECTION_THRESHOLD,
        Min = 1,
        Max = 50,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Anticheat_Settings.SPIN_DETECTION_THRESHOLD = Value
        end
    }) local Number = Options.ACSpinbtThres.Value
    RightGroupBox50:AddSlider('ACHookWindDur', {
        Text = 'Molestation Distance',
        Default = Anticheat_Settings.HOOK_DISTANCE_THRESHOLD,
        Min = 1,
        Max = 1.5,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Anticheat_Settings.HOOK_DISTANCE_THRESHOLD = Value
        end
    }) local Number = Options.ACHookWindDur.Value
    RightGroupBox50:AddSlider('ACHookThres', {
        Text = 'Molestation Threshold',
        Default = Anticheat_Settings.HOOK_DURATION_THRESHOLD,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Anticheat_Settings.HOOK_DURATION_THRESHOLD = Value
        end
    }) local Number = Options.ACHookThres.Value
    RightGroupBox50:AddSlider('ACSpikeThres', {
        Text = 'Spikes Threshold',
        Default = Anticheat_Settings.MAX_SPIKES,
        Min = 1,
        Max = 5,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Anticheat_Settings.MAX_SPIKES = Value
        end
    }) local Number = Options.ACSpikeThres.Value
    RightGroupBox50:AddDivider()
    RightGroupBox50:AddToggle('ReportFunc', {
        Text = 'AutoReport for Cheating',
        Default = false, -- Default value (true / false)
        Tooltip = 'Make the Anticheat watch them', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            Anticheat_Settings.REPORT = Value
        end
    }) Toggles.ReportFunc:OnChanged(function()
    end) Toggles.ReportFunc:SetValue(false)
    local MyButton = RightGroupBox50:AddButton({
        Text = 'Pardon All',
        Func = function()
            Library:Notify("Everyone is now undetected")
            Anticheat_Settings.PARDONED = true
            task.wait(5)
            Library:Notify("Anticheat back in action")
            Anticheat_Settings.PARDONED = false
        end,
        DoubleClick = true,
        Tooltip = 'Pardons everyone and then waits for the pardening be deactive'
    })
    RightGroupBox50:AddDivider()
    RightGroupBox50:AddLabel("Etc")
    local MyButton = RightGroupBox50:AddButton({
        Text = 'Un-VC Ban',
        Func = function()
            game:GetService("VoiceChatService"):joinVoice()
            Success_Notificate("VC Ban Bypassed")
        end,
        DoubleClick = false,
        Tooltip = 'Only works when you get banned for cursing (USE THIS AFTER BAN)'
    })
    local MyButton = RightGroupBox50:AddButton({
        Text = 'Anti-AFK',
        Func = function()
            AntiIdle()
        end,
        DoubleClick = false,
        Tooltip = 'Only works when you go afk'
    })
    RightGroupBox50:AddToggle('AntiFD', {
        Text = 'Anti FallDmg',
        Default = false, -- Default value (true / false)
        Tooltip = 'Only works with games with a specific fall damage script', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            AntiFallDmg(Value)
        end
    }) Toggles.AntiFD:OnChanged(function()
    end) Toggles.AntiFD:SetValue(false)
    RightGroupBox50:AddToggle('AntiFling', {
        Text = 'Anti Fling',
        Default = false, -- Default value (true / false)
        Tooltip = 'You can also noclip/walkfling with this somehow LOL', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            disableCanCollide(Value)
        end
    }) Toggles.AntiFling:OnChanged(function()
    end) Toggles.AntiFling:SetValue(false)
    
    local MyButton = LeftGroupBox_E:AddButton({
        Text = 'Radar',
        Func = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/JD0jxp9Z", true))()
        end,
        DoubleClick = false,
        Tooltip = 'Loads a radar'
    })
    local MyButton = LeftGroupBox_E:AddButton({
        Text = 'Rainbow Chat',
        Func = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/b3YS61yV", true))()
        end,
        DoubleClick = true,
        Tooltip = 'Fagoit'
    })
    local MyButton = LeftGroupBox_E:AddButton({
        Text = 'Roblox 2007 Mouse Cursor',
        Func = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/6uDb3He5", true))()
        end,
        DoubleClick = true,
        Tooltip = 'D'
    })
    local MyButton = LeftGroupBox_E:AddButton({
        Text = 'Rainbow Char',
        Func = function()
            for _, v in pairs(char:GetChildren()) do
                if v:IsA("MeshPart") then
                    v.Material = "ForceField"
                    coroutine.wrap(function()
                        while task.wait() do
                            for _, meshPart in pairs(char:GetChildren()) do
                                if meshPart:IsA("MeshPart") then
                                    meshPart.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                                    task.wait()
                                end
                            end
                        end 
                    end)()
                end
            end
        end,
        DoubleClick = true,
        Tooltip = 'Fagoit'
    })
    LeftGroupBox_E:AddDivider()
    LeftGroupBox_E:AddToggle('Skybox', {
        Text = 'Skybox',
        Default = false, -- Default value (true / false)
        Tooltip = 'This turns on/off the Skybox', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            if Value == true then
                SkyBox = Instance.new("Sky")
                SkyBox.Name = "PLVSMVWVRE.lol"
                SkyBox.Parent = game.Lighting
                SkyBox.SkyboxBk = "http://www.roblox.com/asset/?id=271042516"
                SkyBox.SkyboxDn = "http://www.roblox.com/asset/?id=271077243"
                SkyBox.SkyboxFt = "http://www.roblox.com/asset/?id=271042556"
                SkyBox.SkyboxRt = "http://www.roblox.com/asset/?id=271042467"
                SkyBox.SkyboxLf = "http://www.roblox.com/asset/?id=271042310"
                SkyBox.SkyboxUp = "http://www.roblox.com/asset/?id=271077958"
                SkyBox.StarCount = 0
            else
                for _, v in ipairs(game:GetService("Lighting"):GetDescendants()) do
                    if v.Name == "PLVSMVWVRE.lol" then
                        v:Destroy()
                    end
                end
            end
        end
    }) Toggles.Skybox:OnChanged(function()
    end) Toggles.Skybox:SetValue(false)
    LeftGroupBox_E:AddToggle('DevCameraOcclusionMode', {
        Text = 'Camera WallClip',
        Default = false, -- Default value (true / false)
        Tooltip = 'This turns on/off the DevCameraOcclusionMode', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            if Value == true then
                player.DevCameraOcclusionMode = "Invisicam"
            else
                player.DevCameraOcclusionMode = "Zoom"
            end
        end
    }) Toggles.DevCameraOcclusionMode:OnChanged(function()
        -- here we get our toggle object & then get its value
    end) Toggles.DevCameraOcclusionMode:SetValue(false)
    LeftGroupBox_E:AddLabel('Bind'):AddKeyPicker('KeyPicker343', {
        -- SyncToggleState only works with toggles.
        -- It allows you to make a keybind which has its state synced with its parent toggle
    
        -- Example: Keybind which you use to toggle flyhack, etc.
        -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state
    
        Default = 'Minus', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
        SyncToggleState = false,
    
    
        -- You can define custom Modes but I have never had a use for it.
        Mode = 'Toggle', -- Modes: Always, Toggle, Hold
    
        Text = 'Camera WallClip', -- Text to display in the keybind menu
        NoUI = false, -- Set to true if you want to hide from the Keybind menu,
    
        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            Toggles.DevCameraOcclusionMode:SetValue(Value)
        end,
    
        -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
        ChangedCallback = function(New)
        end
    }) Options.KeyPicker343:OnClick(function()
    end) Options.KeyPicker343:OnChanged(function()
    end) task.spawn(function()
        while true and wait(0.1) do
            -- example for checking if a keybind is being pressed
            local state = Options.KeyPicker343:GetState()
            if state then
                Toggles.DevCameraOcclusionMode:SetValue(state)
            else
                Toggles.DevCameraOcclusionMode:SetValue(state)
            end
    
            if Library.Unloaded then break end
        end
    end) Options.KeyPicker343:SetValue({ 'Minus', 'Toggle' }) -- Sets keybind to MB2, mode to Hold
    LeftGroupBox_E:AddSlider('FOV_2Slider', {
        Text = 'Max Zoom Dist',
        Default = 16,
        Min = 16,
        Max = 999,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            player.CameraMaxZoomDistance = Value
        end
    }) local Number = Options.FOV_2Slider.Value
    Options.FOV_2Slider:OnChanged(function()
    end) Options.FOV_2Slider:SetValue(3)
    LeftGroupBox_E:AddSlider('FOVSlider', {
        Text = 'FOV',
        Default = 70,
        Min = 70,
        Max = 120,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            ExtraVisuals.FOV = Value
        end
    }) local Number = Options.FOVSlider.Value
    Options.FOVSlider:OnChanged(function()
    end) Options.FOVSlider:SetValue(3)
    LeftGroupBox_E:AddInput('HitMarkerSound', {
        Default = '5794214857',
        Numeric = true, -- true / false, only allows numbers
        Finished = true, -- true / false, only calls callback when you press enter
    
        Text = 'Custom HitMarker Sound',
        Tooltip = 'This is the tooltip', -- Information shown when you hover over the textbox
    
        Placeholder = 'SoundID', -- placeholder text when the box is empty
        -- MaxLength is also an option which is the max length of the text
    }) Options.HitMarkerSound:OnChanged(function()
        SoundIDHM = Options.HitMarkerSound.Value;
    end)
    LeftGroupBox_E:AddInput('KillSound', {
        Default = '5764885315',
        Numeric = true, -- true / false, only allows numbers
        Finished = true, -- true / false, only calls callback when you press enter
    
        Text = 'Custom Kill Sound',
        Tooltip = 'This is the tooltip', -- Information shown when you hover over the textbox
    
        Placeholder = 'SoundID', -- placeholder text when the box is empty
        -- MaxLength is also an option which is the max length of the text
    }) Options.KillSound:OnChanged(function()
        SoundIDK = Options.KillSound.Value;
    end)
    LeftGroupBox_E:AddDivider()
    LeftGroupBox_E:AddToggle('Crosshair_Init', {
        Text = 'Crosshair',
        Default = false, -- Default value (true / false)
        Tooltip = 'U dont even need dis LOL', -- Information shown when you hover over the toggle
    
        Callback = function(Value) Crosshair.Enabled = Value; end
    }) Toggles.Crosshair_Init:OnChanged(function()
    end) Toggles.Crosshair_Init:SetValue(false)
    LeftGroupBox_E:AddSlider('Crosshair_Sides', {
        Text = 'Sides',
        Default = 4,
        Min = 2,
        Max = 4,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Crosshair.Sides = Value
        end
    }) local Number = Options.Crosshair_Sides.Value
    Options.Crosshair_Sides:OnChanged(function()
    end) Options.Crosshair_Sides:SetValue(4)
    LeftGroupBox_E:AddSlider('Crosshair_Thickness', {
        Text = 'Gap',
        Default = 15,
        Min = 10,
        Max = 20,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Crosshair.Size = Value
        end
    }) local Number = Options.Crosshair_Thickness.Value
    Options.Crosshair_Thickness:OnChanged(function()
    end) Options.Crosshair_Thickness:SetValue(15)
    LeftGroupBox_E:AddSlider('Crosshair_Rotation', {
        Text = 'Rotation',
        Default = 0,
        Min = 0,
        Max = 90,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Crosshair.Rotation = Value
        end
    }) local Number = Options.Crosshair_Rotation.Value
    Options.Crosshair_Rotation:OnChanged(function()
    end) Options.Crosshair_Rotation:SetValue(85.3)
    LeftGroupBox_E:AddSlider('Crosshair_Length', {
        Text = 'Thickness',
        Default = 2,
        Min = 1,
        Max = 5,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Crosshair.Thickness = Value
        end
    }) local Number = Options.Crosshair_Length.Value
    Options.Crosshair_Length:OnChanged(function()
    end) Options.Crosshair_Length:SetValue(2)
    LeftGroupBox_E:AddSlider('Crosshair_Gap', {
        Text = 'Length',
        Default = 32,
        Min = 25,
        Max = 35,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Crosshair.Gap = Value
        end
    }) local Number = Options.Crosshair_Gap.Value
    Options.Crosshair_Gap:OnChanged(function()
    end) Options.Crosshair_Gap:SetValue(32)
    LeftGroupBox_E:AddSlider('Crosshair_x', {
        Text = 'Offset (x)',
        Default = 0,
        Min = -100,
        Max = 100,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Crosshair.x_Off = Value
        end
    }) local Number = Options.Crosshair_x.Value
    Options.Crosshair_x:SetValue(0)
    LeftGroupBox_E:AddSlider('Crosshair_y', {
        Text = 'Offset (y)',
        Default = 0,
        Min = -100,
        Max = 100,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            Crosshair.y_Off = Value
        end
    }) local Number = Options.Crosshair_y.Value
    Options.Crosshair_y:SetValue(0)
    LeftGroupBox_E:AddLabel('Color'):AddColorPicker('Crosshair_ColorPick', {
        Default = Color3.new(255, 255, 255), -- Bright green
        Title = 'Color', -- Optional. Allows you to have a custom color picker title (when you open it)
        Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)
    
        Callback = function(Value)
            Crosshair.Color = Value;
        end
    }) Options.Crosshair_ColorPick:OnChanged(function()
        Crosshair.Transparency = Options.Crosshair_ColorPick.Transparency;
    end) Options.Crosshair_ColorPick:SetValueRGB(Color3.fromRGB(255, 255, 255))

    LeftGroupBox_E:AddDivider()
    LeftGroupBox_E:AddLabel('Target Plates')
    LeftGroupBox_E:AddLabel('Color'):AddColorPicker('FillColor45', {
        Default = Color3.new(142, 0, 255), -- Bright green
        Title = 'Color', -- Optional. Allows you to have a custom color picker title (when you open it)
        Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)
    
        Callback = function(Value)
            NAMETAG_CONFIG.NAMEPLATE_COLOR = Value;
        end
    }) Options.FillColor45:OnChanged(function()
        ChamsAdjustments.FillTransparency = Options.FillColor45.Transparency;
    end)
    
    RightGroupbox22:AddToggle('ChatSoamm', {
        Text = 'Chat Spam',
        Default = false, -- Default value (true / false)
        Tooltip = 'lol', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            ChatSpammerrr.Activated = Value
        end
    }) Toggles.ChatSoamm:OnChanged(function()
    end) Toggles.ChatSoamm:SetValue(false)
    RightGroupbox22:AddSlider('Chatsoam', {
        Text = 'ChatSpammer Mode',
        Default = 1,
        Min = 1,
        Max = 5,
        Rounding = 0,
        Compact = true,
    
        Callback = function(Value)
            ChatSpammerrr.Mode = Value
        end
    }) local Number = Options.Chatsoam.Value

    local MyButton = RightGroupbox22:AddButton({
        Text = 'Become a NPC',
        Func = function()
            getgenv().hurtmessages = {
                "That hurt!",
                "Watch where you're swinging!",
                "Ow! That's gonna leave a mark!",
                "Stop attacking me!",
                "I'm not feeling so good...",
                "Is that all you've got?",
                "Can't catch a break!",
                "That was a cheap shot!",
                "You'll regret that!"
             }
            if player.Character then
                local Humanoid = player.Character:WaitForChild("Humanoid")
                local previousHealth = Humanoid.Health
            
                Humanoid.Changed:Connect(function()
                    if Humanoid.Health < previousHealth then
                        local randomIndex = math.random(1, #getgenv().hurtmessages)
                        local message = getgenv().hurtmessages[randomIndex]
                        game.TextChatService.TextChannels.RBXGeneral:SendAsync(message)
                    end
                    
                    previousHealth = Humanoid.Health
                end)
            end
            player.CharacterAdded:Connect(function(char)
                local Humanoid = char:WaitForChild("Humanoid")
                local previousHealth = Humanoid.Health
            
                Humanoid.Changed:Connect(function()
                    if Humanoid.Health < previousHealth then
                        local randomIndex = math.random(1, #getgenv().hurtmessages)
                        local message = getgenv().hurtmessages[randomIndex]
                        game.TextChatService.TextChannels.RBXGeneral:SendAsync(message)
                    end
                    
                    previousHealth = Humanoid.Health
                end)
            end)
        end,
        DoubleClick = true,
        Tooltip = 'Beepbop'
    })
    local MyButton = RightGroupbox22:AddButton({
        Text = 'Reportbot',
        Func = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/CF-Trail/random/main/loadstrings/AutoreportRevamp.lua", true))()
        end,
        DoubleClick = true,
        Tooltip = 'become the #10 reporter ever'
    })
    local MyButton = RightGroupbox22:AddButton({
        Text = 'Flingbot',
        Func = function()
            FlingerAll()
        end,
        DoubleClick = true,
        Tooltip = 'who flung me'
    })
    local MyButton = RightGroupbox22:AddButton({
        Text = 'Flingbot (Random Player)',
        Func = function()
            FlingtargetPlayerName("random")
        end,
        DoubleClick = true,
        Tooltip = 'who flung me'
    })
    local MyButton = RightGroupbox_X:AddButton({
        Text = 'Load Dex',
        Func = function()
            loadstring(game:HttpGet(('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'),true))();
        end,
        DoubleClick = true,
        Tooltip = 'Loads the script'
    })
    local MyButton = RightGroupbox_X:AddButton({
        Text = 'Load Sirius-X',
        Func = function()
            loadstring(game:HttpGet(('https://sirius.menu/sirius'),true))();
        end,
        DoubleClick = false,
        Tooltip = 'Loads the script'
    })
    local MyButton = RightGroupbox_X:AddButton({
        Text = 'Load INF-Y',
        Func = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end,
        DoubleClick = true,
        Tooltip = 'Loads the script'
    })
    local MyButton = RightGroupbox_X:AddButton({
        Text = 'Load SSpy',
        Func = function()
            loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()
        end,
        DoubleClick = true,
        Tooltip = 'Loads the script'
    })
    local MyButton = RightGroupbox_X:AddButton({
        Text = 'Load Hydrox',
        Func = function()
            local owner = "Upbolt"
            local branch = "revision"
            
            local function webImport(file)
                return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
            end
            
            webImport("init")
            webImport("ui/main")
        end,
        DoubleClick = true,
        Tooltip = 'Loads the script'
    })
    local MyButton = RightGroupbox_X:AddButton({
        Text = 'Load Proton',
        Func = function()
            Keybind = "`"
            loadstring(game:HttpGet("https://raw.githubusercontent.com/biggaboy212/Public-Resources/main/Proton%20IDE/Raw.lua"))()
        end,
        DoubleClick = true,
        Tooltip = 'Loads the script'
    })
    local MyButton = RightGroupbox_X:AddButton({
        Text = 'Load SUS FE',
        Func = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Amethystic/susfescripts/refs/heads/main/susfe.lua"))()
        end,
        DoubleClick = true,
        Tooltip = 'Loads the script'
    })
    local MyButton = RightGroupbox_X:AddButton({
        Text = 'Load Chatbypasser',
        Func = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/cheatplug/usercreated/refs/heads/main/main.lua'))()
        end,
        DoubleClick = true,
        Tooltip = 'Loads the script'
    })
    local MyButton = RightGroupbox_X:AddButton({
        Text = 'Load ToolHandler',
        Func = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/dqtixz/NebulaNosh-I-Gui-A.C.S-F.E-/main/By%20dqtixz"))();
        end,
        DoubleClick = true,
        Tooltip = 'Loads the script'
    })

    LeftGroupBox3:AddToggle('FlyToggle', {
        Text = 'Fly',
        Default = false, -- Default value (true / false)
        Tooltip = 'Setting', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
        end
    }) Toggles.FlyToggle:OnChanged(function()
        -- here we get our toggle object & then get its value
        FlyActivate(Toggles.FlyToggle.Value)
    end) Toggles.FlyToggle:SetValue(false) LeftGroupBox3:AddLabel('Fly Bind'):AddKeyPicker('KP543645', {
        -- SyncToggleState only works with toggles.
        -- It allows you to make a keybind which has its state synced with its parent toggle
    
        -- Example: Keybind which you use to toggle flyhack, etc.
        -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state
    
        Default = 'Minus', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
        SyncToggleState = true,
    
    
        -- You can define custom Modes but I have never had a use for it.
        Mode = 'Toggle', -- Modes: Always, Toggle, Hold
    
        Text = 'Fly', -- Text to display in the keybind menu
        NoUI = false, -- Set to true if you want to hide from the Keybind menu,
    
        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            Toggles.FlyToggle:SetValue(Value)
        end,
    
        -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
        ChangedCallback = function(New)
        end
    }) Options.KP543645:OnClick(function()
    end) Options.KP543645:OnChanged(function()
    end) task.spawn(function()
        while true and wait(0.2) do
            -- example for checking if a keybind is being pressed
            local state = Options.KP543645:GetState()
            if state then
            end
    
            if Library.Unloaded then break end
        end
    end) Options.KP543645:SetValue({ 'Minus', 'Toggle' }) -- Sets keybind to MB2, mode to Hold
    
    LeftGroupBox3:AddSlider('Walkspeed', {
        Text = 'Walkspeed',
        Default = playerWalkspeedCache,
        Min = 15,
        Max = 120,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            player.Character.Humanoid.WalkSpeed = Value
        end
    }) local Number = Options.Walkspeed.Value
    Options.Walkspeed:OnChanged(function()
    end) Options.Walkspeed:SetValue(playerWalkspeedCache)
    LeftGroupBox3:AddSlider('JumpPower', {
        Text = 'JumpPower',
        Default = playerJumpPowerCache,
        Min = 50,
        Max = 9999,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            player.Character.Humanoid.JumpPower = Value
        end
    }) local Number = Options.JumpPower.Value
    Options.JumpPower:OnChanged(function()
    end) Options.JumpPower:SetValue(playerJumpPowerCache)
    LeftGroupBox3:AddSlider('FlySpeed', {
        Text = 'FlySpeed',
        Default = 50,
        Min = 5,
        Max = 1000,
        Rounding = 1,
        Compact = true,
    
        Callback = function(Value)
            flySpeed = Value
        end
    }) local Number = Options.FlySpeed.Value
    Options.FlySpeed:OnChanged(function()
    end) Options.FlySpeed:SetValue(50)
    LeftGroupBox3:AddDivider()
    
    local MyButton = LeftGroupBox3:AddButton({
        Text = 'Reset Speeds',
        Func = function()
            Options.JumpPower:SetValue(playerJumpPowerCache)
            Options.Walkspeed:SetValue(playerWalkspeedCache)
        end,
        DoubleClick = true,
        Tooltip = 'Resets those 2 settings'
    })
    
    local MyButton = LeftGroupBox5:AddButton({
        Text = 'Load Supported Script',
        Func = function()
            loadstring(game:HttpGet("https://catnip.at.ua/Meowijuana_Gamalauncher.lua"))()
        end,
        DoubleClick = false,
        Tooltip = 'This loads a script for this specific game'
    })
    local MyButton = LeftGroupBox5:AddButton({
        Text = 'Get GameID',
        Func = function()
            print(game.PlaceId)
            setclipboard(tostring(game.PlaceId))
        end,
        DoubleClick = false,
        Tooltip = 'This grabs the games current ID'
    })
    local MyButton = LeftGroupBox5:AddButton({
        Text = 'Get JobID',
        Func = function()
            print(game.JobId)
            setclipboard(tostring(game.JobId))
        end,
        DoubleClick = false,
        Tooltip = 'This grabs the games current job ID'
    })
    LeftGroupBox5:AddDropdown('MyPlayerDropdown', {
        SpecialType = 'Player',
        Text = 'Get Target Username',
        Tooltip = 'Yoink', -- Information shown when you hover over the dropdown
    
        Callback = function(Value)
            toclipboard(Value)
            Notificate(COLORS.GREEN, "Copied "..Value.. "'s Username")
        end
    })
    RightGroupbox22:AddToggle('FriBot', {
        Text = 'FriendBot',
        Default = false, -- Default value (true / false)
        Tooltip = 'Faggot faggot (faggot)', -- Information shown when you hover over the toggle
    
        Callback = function(Value) end
    }) Toggles.FriBot:OnChanged(function()
        FB(Toggles.FriBot.Value)
    end) Toggles.FriBot:SetValue(false) 
    RightGroupbox22:AddDropdown('MyPlayerDropdown', {
        SpecialType = 'Player',
        Text = 'Target Fling',
        Tooltip = 'Im fried', -- Information shown when you hover over the dropdown
    
        Callback = function(Value)
            NAMETAG_CONFIG.NAME = Value
            NAMETAG_CONFIG.NAMEPLATE_TAG = "Target"
        end
    })
    local MyButton = RightGroupbox22:AddButton({
        Text = 'Fling Target',
        Func = function()
            if NAMETAG_CONFIG.NAME == nil then
                Library:Notify("No player chosen", 2) -- Text, Time
            else
                FlingtargetPlayerName(NAMETAG_CONFIG.NAME)
                Library:Notify("Flung " .. NAMETAG_CONFIG.NAME .. "!", 2) -- Text, Time
                wait(1)
                Reset()
            end
        end,
        DoubleClick = false,
        Tooltip = 'Yk what ds does'
    })
    RightGroupbox22:AddLabel('Immediant AllFlinger'):AddKeyPicker('KeyPicker56', {
        -- SyncToggleState only works with toggles.
        -- It allows you to make a keybind which has its state synced with its parent toggle
    
        -- Example: Keybind which you use to toggle flyhack, etc.
        -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state
    
        Default = 'Minus', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
        SyncToggleState = false,
    
    
        -- You can define custom Modes but I have never had a use for it.
        Mode = 'Toggle', -- Modes: Always, Toggle, Hold
    
        Text = 'Immediant AllFlinger', -- Text to display in the keybind menu
        NoUI = false, -- Set to true if you want to hide from the Keybind menu,
    
        -- Occurs when the keybind is clicked, Value is `true`/`false`
        Callback = function(Value)
            FlingerAll()
        end,
    
        -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
        ChangedCallback = function(New)
        end
    }) Options.KeyPicker56:OnClick(function() print('Keybind clicked!', Options.KeyPicker56:GetState()) end) Options.KeyPicker56:OnChanged(function() end) task.spawn(function()
        while true and wait(0.50) do
            -- example for checking if a keybind is being pressed
            local state = Options.KeyPicker56:GetState()
            if state == true then
                FlingerAll()
            end
    
            if Library.Unloaded then break end
        end
    end) Options.KeyPicker56:SetValue({ 'Minus', 'Toggle' }) -- Sets keybind to MB2, mode to Hold
    
    -- Etc
    LeftGroupBox6:AddLabel('User ID: ' .. p.UserId)

    LeftGroupBox6:AddDivider()
    if ExecName then
        LeftGroupBox6:AddLabel(ExecName)
        LeftGroupBox6:AddDivider()
        if UNCRecieved <= RequiredUNC then
            LeftGroupBox6:AddLabel(UNCwarning)
        else
            LeftGroupBox6:AddLabel('Supported Exec')
            LeftGroupBox6:AddLabel(UNCRecieved..'% UNC')
        end
        LeftGroupBox6:AddDivider()
        local JollyRancher4 = LeftGroupBox6:AddButton({
            Text = 'Grab HWID',
            Func = function()
                setclipboard(tostring(gethwid()))
            end,
            DoubleClick = false,
            Tooltip = 'Grab ur HWID'
        })
        local JollyRancher2 = LeftGroupBox6:AddButton({
            Text = 'Verificate LVL',
            Func = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/vvult/HIdentity/main/HIdentity"))()
            end,
            DoubleClick = false,
            Tooltip = 'Grab ur Executors Level'
        })
        if game.PlaceId == 133609342474444 then
            local JollyRancher5 = LeftGroupBox6:AddButton({
                Text = 'Verificate UNC through sUNC',
                Func = function()
                    getgenv().sUNCDebug = {
                        ["printcheckpoints"] = BetaBuild,
                        ["delaybetweentests"] = 0
                    }
                    loadstring(game:HttpGet("https://script.sunc.su/"))()
                end,
                DoubleClick = false,
                Tooltip = '(✅ In Dedicated game) Double-Check UNC'
            })
        else
            local JollyRancher6 = LeftGroupBox6:AddButton({
                Text = 'Verificate UNC through sUNC',
                Func = function()
                    local TeleportService = game:GetService("TeleportService")
                    local placeId = 133609342474444 -- ROBLOCKS STOP PMOING ME game ID
                    
                    -- Function to teleport to the game
                    local function teleportToGame()
                        local success, errorMessage = pcall(function()
                            TeleportService:Teleport(placeId)
                        end)
                        
                        if not success then
                            warn("Teleport failed:", errorMessage)
                        end
                    end
                    
                    -- Call the teleport function
                    teleportToGame()
                end,
                DoubleClick = true,
                Tooltip = '(⚠️ You are not in the dedicated game) This will teleport you to the dedicated sUNC game'
            })
        end
        local JollyRancher2 = LeftGroupBox6:AddButton({
            Text = 'Flex Executor',
            Func = function()
                ExecFlex = {
                    "Oh yeah im using "..ExecName.." and it got "..UNCRecieved..'% UNC. '.."and it supports [PLVSMVWVRE] something that u dont have, cuz ur not rich like me.",
                    "Does ur executor have "..UNCRecieved..'% UNC. like '..ExecName..", No? ok. Pooron. 😼😼",
                    "*Sigh* "..ExecName.." "..ExecName.." "..ExecName.." "..". When will these people buy you.. for your "..UNCRecieved..'% UNC. '.." ;(",
                }

                if game.TextChatService and game.TextChatService:FindFirstChild("TextChannels") then
                    local rbxGeneral = game.TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                    if rbxGeneral then
                        currentIndex = currentIndex + 1
                            if currentIndex > #ExecFlex then currentIndex = 1  end
                            local randomIndex = math.random(1, #ExecFlex)
                            local message = ExecFlex[randomIndex]
                        rbxGeneral:SendAsync(message)
                    end
                end
        
                if game.ReplicatedStorage and game.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
                    local sayMessageRequest = game.ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
                    if sayMessageRequest then
                        currentIndex = currentIndex + 1
                            if currentIndex > #ExecFlex then currentIndex = 1  end
                            local randomIndex = math.random(1, #ExecFlex)
                            local message = ExecFlex[randomIndex]
                        sayMessageRequest:FireServer(message, "All")
                    end
                end
            end,
            DoubleClick = true,
            Tooltip = 'This can possibly ragebait other executor users (Avoid using this to avoid other cancer patients like the wave users)'
        })
        LeftGroupBox6:AddSlider('ShitFPS', {
            Text = 'FPS Cap',
            Default = 240,
            Min = 60,
            Max = 1000,
            Rounding = 1,
            Compact = true,
        
            Callback = function(Value)
                setfpscap(Value)
            end
        }) local Number = Options.ShitFPS.Value
        Options.ShitFPS:OnChanged(function()
            
        end) Options.ShitFPS:SetValue(240)
    else
        LeftGroupBox6:AddLabel('Unknown ass hack')
        LeftGroupBox6:AddDivider()
        LeftGroupBox6:AddLabel('? Com')
        LeftGroupBox6:AddLabel('Use the UNC test')
        LeftGroupBox6:AddLabel('Verificate the LVL in console')
        LeftGroupBox6:AddDivider()
        LeftGroupBox6:AddLabel(testwarning)
        LeftGroupBox6:AddDivider()
        local JollyRancher4 = LeftGroupBox6:AddButton({
            Text = 'Grab HWID',
            Func = function()
                setclipboard(tostring(gethwid()))
            end,
            DoubleClick = false,
            Tooltip = 'Grab ur HWID'
        })
        local JollyRancher2 = LeftGroupBox6:AddButton({
            Text = 'Verificate LVL',
            Func = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/vvult/HIdentity/main/HIdentity"))()
            end,
            DoubleClick = false,
            Tooltip = 'Grab ur Executors Level'
        })
        local JollyRancher2 = LeftGroupBox6:AddButton({
            Text = 'Test UNC',
            Func = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/unified-naming-convention/NamingStandard/main/UNCCheckEnv.lua"))()
            end,
            DoubleClick = false,
            Tooltip = 'Grab ur Executors (REAL) UNC'
        })
        LeftGroupBox6:AddSlider('ShitFPS', {
            Text = 'FPS Cap',
            Default = 240,
            Min = 60,
            Max = 1000,
            Rounding = 1,
            Compact = true,
        
            Callback = function(Value)
                setfpscap(Value)
            end
        }) local Number = Options.ShitFPS.Value
        Options.ShitFPS:OnChanged(function()
            
        end) Options.ShitFPS:SetValue(240)
    end
    
    -- Library functions
    -- Sets the watermark visibility
    function updateWatermark()
        local fps = getFPS()
        local ping = getPING()
        local character = game.Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                local health = humanoid.Health
                Library:SetWatermark(cheatname .. ' | ' .. Username .. " / " .. health .. "% HP" .. " / " .. "Kills: " .. KillCount .. " / " .. "OVERKILL(s): " .. OVERKillCount .. " / " .. "FPS: " .. fps .. " / " .. "Ping: " .. ping .. " | " .. ExecName, '')
            end
        end
    end
    
    Library.KeybindFrame.Visible = true; -- todo: add a function for this
    
    Library:OnUnload(function() EndStuff() end)
    
    -- UI Settings
    local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
    MenuGroup:AddButton('Unload', function() Library:Unload() end)
    MenuGroup:AddButton('Rejoin', function() rejoin() end)
    MenuGroup:AddButton('Server Hop', function() serverhop() end)
    local Button = MenuGroup:AddButton({
        Text = 'Rage Quit',
        Func = function()
            game:Shutdown()
        end,
        DoubleClick = true,
        Tooltip = 'wtf no maan'
    })
    MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Home', NoUI = true, Text = 'Menu keybind' })
    MenuGroup:AddToggle('Killfeed', {
        Text = 'Killfeed',
        Default = false, -- Default value (true / false)
        Tooltip = 'This turns on/off the Killfeed', -- Information shown when you hover over the toggle
    
        Callback = function(Value)
            HitDetection(Value)
        end
    }) Toggles.Killfeed:OnChanged(function()
        -- here we get our toggle object & then get its value
    end)
    Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
    ThemeManager:SetFolder(cheatname)
    SaveManager:SetFolder(cheatname)
    SaveManager:BuildConfigSection(Tabs['UI Settings'])
    ThemeManager:ApplyToTab(Tabs['UI Settings'])
    SaveManager:LoadAutoloadConfig()
    Library:SetWatermarkVisibility(true)
    Launch()
    
    if Library.Unloaded then
        -- Iterate through all event connections and disconnect them
        for name, connection in pairs(EventConnections) do
            if connection then
                -- Ensure the connection is valid before disconnecting
                if typeof(connection) == "RBXScriptConnection" then
                    connection:Disconnect()
                else
                    warn("Invalid connection type for " .. name .. ": " .. typeof(connection))
                end
                -- Clear the reference
                EventConnections[name] = nil
            end
        end
    
        -- Check if all connections have been cleared
        local allDisconnected = true
        for _, connection in pairs(EventConnections) do
            if connection then
                allDisconnected = false
                break
            end
        end
    
        -- Print a message if all connections were successfully unloaded
        if allDisconnected then
            print("✅ All runtime functions are now unloaded.")
        else
            warn("⚠️ Some runtime functions could not be unloaded.")
        end
    end
end

-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |                                         Loading Method                                          |
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

local function PlayAnimation()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TweenService = game:GetService("TweenService")
    
    -- Create the loading GUI
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LoadingGui"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    frame.BackgroundTransparency = 1 -- Start fully transparent
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    local loadingText = Instance.new("TextLabel")
    loadingText.Name = "LoadingText"
    loadingText.Size = UDim2.new(0, 200, 0, 50)
    loadingText.Position = UDim2.new(0.5, -100, 0.5, -25)
    loadingText.BackgroundTransparency = 1
    loadingText.Text = "Loading..."
    loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingText.TextTransparency = 1 -- Start transparent
    loadingText.Font = Enum.Font.GothamSemibold
    loadingText.TextSize = 24
    loadingText.Parent = frame
    
    local progressBar = Instance.new("Frame")
    progressBar.Name = "ProgressBar"
    progressBar.Size = UDim2.new(0, 300, 0, 4)
    progressBar.Position = UDim2.new(0.5, -150, 0.55, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    progressBar.BackgroundTransparency = 1 -- Start transparent
    progressBar.BorderSizePixel = 0
    progressBar.Parent = frame
    
    local progressFill = Instance.new("Frame")
    progressFill.Name = "ProgressFill"
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    progressFill.BorderSizePixel = 0
    progressFill.Parent = progressBar
    
    -- Animation function
    local function animateLoad()
        -- First, fade in all elements
        local fadeInInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        
        -- Fade in the background
        local bgTween = TweenService:Create(frame, fadeInInfo, {BackgroundTransparency = 0})
        bgTween:Play()
        
        -- Fade in all child elements
        for _, child in ipairs(frame:GetChildren()) do
            if child:IsA("GuiObject") then
                local childTween
                if child:IsA("TextLabel") then
                    childTween = TweenService:Create(child, fadeInInfo, {TextTransparency = 0})
                else
                    childTween = TweenService:Create(child, fadeInInfo, {BackgroundTransparency = 0})
                end
                childTween:Play()
            end
        end
        
        -- Wait for fade in to complete
        bgTween.Completed:Wait()
        wait(0.2) -- Small delay after fade in
        
        -- Text animation
        local dots = {"", ".", "..", "..."}
        local dotCount = 1
        
        local textConnection
        textConnection = game:GetService("RunService").RenderStepped:Connect(function()
            dotCount = dotCount + 1
            if dotCount > #dots then dotCount = 1 end
            loadingText.Text = "Injecting PLVSMVWVRE.lol [BETA]"
        end)
        
        -- Progress bar animation - FIXED
        -- First make sure progressFill is visible (remove transparency)
        progressFill.BackgroundTransparency = 0
        
        -- Then animate the width
        for i = 1, 100 do
            progressFill.Size = UDim2.new(i/100, 0, 1, 0)
            task.wait(0.03) -- Using task.wait() instead of wait() is better practice
        end
        
        -- Fade out animation
        local fadeOutInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        local tween = TweenService:Create(frame, fadeOutInfo, {BackgroundTransparency = 1})
        
        for _, child in ipairs(frame:GetChildren()) do
            if child:IsA("GuiObject") then
                local childTween
                if child:IsA("TextLabel") then
                    childTween = TweenService:Create(child, fadeOutInfo, {TextTransparency = 1})
                else
                    childTween = TweenService:Create(child, fadeOutInfo, {BackgroundTransparency = 1})
                end
                childTween:Play()
            end
        end
        
        tween:Play()
        tween.Completed:Wait()
        
        -- Clean up
        textConnection:Disconnect()
        screenGui:Destroy()
    end
    
    -- Start the animation
    animateLoad()
end 

-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |                                           Checking...                                           |
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

local function CallBuild()
    function UNCTest()
        local passes, fails, undefined = 0, 0, 0
        local running = 0
        
        local function getGlobal(path)
            local value = getfenv(0)
        
            while value ~= nil and path ~= "" do
                local name, nextValue = string.match(path, "^([^.]+)%.?(.*)$")
                value = value[name]
                path = nextValue
            end
        
            return value
        end
        
        local function test(name, aliases, callback)
            running += 1
        
            task.spawn(function()
                if not callback then
                    print("⏺️ " .. name)
                elseif not getGlobal(name) then
                    fails += 1
                    warn("⛔ " .. name)
                else
                    local success, message = pcall(callback)
            
                    if success then
                        passes += 1
                        print("✅ " .. name .. (message and " • " .. message or ""))
                    else
                        fails += 1
                        warn("⛔ " .. name .. " failed: " .. message)
                    end
                end
            
                local undefinedAliases = {}
            
                for _, alias in ipairs(aliases) do
                    if getGlobal(alias) == nil then
                        table.insert(undefinedAliases, alias)
                    end
                end
            
                if #undefinedAliases > 0 then
                    undefined += 1
                    warn("⚠️ " .. table.concat(undefinedAliases, ", "))
                end
        
                running -= 1
            end)
        end
        
        -- Header and summary
        
        print("\n")
        
        print("UNC Environment Check")
        print("✅ - Pass, ⛔ - Fail, ⏺️ - No test, ⚠️ - Missing aliases\n")
        
        task.defer(function()
            repeat task.wait() until running == 0
        
            local rate = math.round(passes / (passes + fails) * 100)
            local outOf = passes .. " out of " .. (passes + fails)
        
            print("\n")
        
            print("UNC Summary")
            print("✅ Tested with a " .. rate .. "% success rate (" .. outOf .. ")")
            print("⛔ " .. fails .. " tests failed")
            print("⚠️ " .. undefined .. " globals are missing aliases")
    
            UNCTestFinished = true
            UNCRecieved=rate
            UNCMissed=fails
            UNCUndefined=undefined
        end)
        
        -- Cache
        
        test("cache.invalidate", {}, function()
            local container = Instance.new("Folder")
            local part = Instance.new("Part", container)
            cache.invalidate(container:FindFirstChild("Part"))
            assert(part ~= container:FindFirstChild("Part"), "Reference `part` could not be invalidated")
        end)
        
        test("cache.iscached", {}, function()
            local part = Instance.new("Part")
            assert(cache.iscached(part), "Part should be cached")
            cache.invalidate(part)
            assert(not cache.iscached(part), "Part should not be cached")
        end)
        
        test("cache.replace", {}, function()
            local part = Instance.new("Part")
            local fire = Instance.new("Fire")
            cache.replace(part, fire)
            assert(part ~= fire, "Part was not replaced with Fire")
        end)
        
        test("cloneref", {}, function()
            local part = Instance.new("Part")
            local clone = cloneref(part)
            assert(part ~= clone, "Clone should not be equal to original")
            clone.Name = "Test"
            assert(part.Name == "Test", "Clone should have updated the original")
        end)
        
        test("compareinstances", {}, function()
            local part = Instance.new("Part")
            local clone = cloneref(part)
            assert(part ~= clone, "Clone should not be equal to original")
            assert(compareinstances(part, clone), "Clone should be equal to original when using compareinstances()")
        end)
        
        -- Closures
        
        local function shallowEqual(t1, t2)
            if t1 == t2 then
                return true
            end
        
            local UNIQUE_TYPES = {
                ["function"] = true,
                ["table"] = true,
                ["userdata"] = true,
                ["thread"] = true,
            }
        
            for k, v in pairs(t1) do
                if UNIQUE_TYPES[type(v)] then
                    if type(t2[k]) ~= type(v) then
                        return false
                    end
                elseif t2[k] ~= v then
                    return false
                end
            end
        
            for k, v in pairs(t2) do
                if UNIQUE_TYPES[type(v)] then
                    if type(t2[k]) ~= type(v) then
                        return false
                    end
                elseif t1[k] ~= v then
                    return false
                end
            end
        
            return true
        end
        
        test("checkcaller", {}, function()
            assert(checkcaller(), "Main scope should return true")
        end)
        
        test("clonefunction", {}, function()
            local function test()
                return "success"
            end
            local copy = clonefunction(test)
            assert(test() == copy(), "The clone should return the same value as the original")
            assert(test ~= copy, "The clone should not be equal to the original")
        end)
        
        test("getcallingscript", {})
        
        -- DETECTED
        test("getscriptclosure", {"getscriptfunction"}, function()
            local module = game:GetService("CoreGui").RobloxGui.Modules.Common.Constants
            local constants = getrenv().require(module)
            local generated = getscriptclosure(module)()
            assert(constants ~= generated, "Generated module should not match the original")
            assert(shallowEqual(constants, generated), "Generated constant table should be shallow equal to the original")
        end)
        
        -- DETECTED
        test("hookfunction", {"replaceclosure"}, function()
            local function test()
                return true
            end
            local ref = hookfunction(test, function()
                return false
            end)
            assert(test() == false, "Function should return false")
            assert(ref() == true, "Original function should return true")
            assert(test ~= ref, "Original function should not be same as the reference")
        end)
        
        test("iscclosure", {}, function()
            assert(iscclosure(print) == true, "Function 'print' should be a C closure")
            assert(iscclosure(function() end) == false, "Executor function should not be a C closure")
        end)
        
        test("islclosure", {}, function()
            assert(islclosure(print) == false, "Function 'print' should not be a Lua closure")
            assert(islclosure(function() end) == true, "Executor function should be a Lua closure")
        end)
        
        -- DETECTED
        test("isexecutorclosure", {"checkclosure", "isourclosure"}, function()
            assert(isexecutorclosure(isexecutorclosure) == true, "Did not return true for an executor global")
            assert(isexecutorclosure(newcclosure(function() end)) == true, "Did not return true for an executor C closure")
            assert(isexecutorclosure(function() end) == true, "Did not return true for an executor Luau closure")
            assert(isexecutorclosure(print) == false, "Did not return false for a Roblox global")
        end)
        
        test("loadstring", {}, function()
            local animate = game:GetService("Players").LocalPlayer.Character.Animate
            local bytecode = getscriptbytecode(animate)
            local func = loadstring(bytecode)
            assert(type(func) ~= "function", "Luau bytecode should not be loadable!")
            assert(assert(loadstring("return ... + 1"))(1) == 2, "Failed to do simple math")
            assert(type(select(2, loadstring("f"))) == "string", "Loadstring did not return anything for a compiler error")
        end)
        
        -- DETECTED
        test("newcclosure", {}, function()
            local function test()
                return true
            end
            local testC = newcclosure(test)
            assert(test() == testC(), "New C closure should return the same value as the original")
            assert(test ~= testC, "New C closure should not be same as the original")
            assert(iscclosure(testC), "New C closure should be a C closure")
        end)
        
        -- Console
        
        test("rconsoleclear", {"consoleclear"})
        
        test("rconsolecreate", {"consolecreate"})
        
        test("rconsoledestroy", {"consoledestroy"})
        
        test("rconsoleinput", {"consoleinput"})
        
        test("rconsoleprint", {"consoleprint"})
        
        test("rconsolesettitle", {"rconsolename", "consolesettitle"})
        
        -- Crypt
        
        test("crypt.base64encode", {"crypt.base64.encode", "crypt.base64_encode", "base64.encode", "base64_encode"}, function()
            assert(crypt.base64encode("test") == "dGVzdA==", "Base64 encoding failed")
        end)
        
        test("crypt.base64decode", {"crypt.base64.decode", "crypt.base64_decode", "base64.decode", "base64_decode"}, function()
            assert(crypt.base64decode("dGVzdA==") == "test", "Base64 decoding failed")
        end)
        
        test("crypt.encrypt", {}, function()
            local key = crypt.generatekey()
            local encrypted, iv = crypt.encrypt("test", key, nil, "CBC")
            assert(iv, "crypt.encrypt should return an IV")
            local decrypted = crypt.decrypt(encrypted, key, iv, "CBC")
            assert(decrypted == "test", "Failed to decrypt raw string from encrypted data")
        end)
        
        test("crypt.decrypt", {}, function()
            local key, iv = crypt.generatekey(), crypt.generatekey()
            local encrypted = crypt.encrypt("test", key, iv, "CBC")
            local decrypted = crypt.decrypt(encrypted, key, iv, "CBC")
            assert(decrypted == "test", "Failed to decrypt raw string from encrypted data")
        end)
        
        test("crypt.generatebytes", {}, function()
            local size = math.random(10, 100)
            local bytes = crypt.generatebytes(size)
            assert(#crypt.base64decode(bytes) == size, "The decoded result should be " .. size .. " bytes long (got " .. #crypt.base64decode(bytes) .. " decoded, " .. #bytes .. " raw)")
        end)
        
        test("crypt.generatekey", {}, function()
            local key = crypt.generatekey()
            assert(#crypt.base64decode(key) == 32, "Generated key should be 32 bytes long when decoded")
        end)
        
        test("crypt.hash", {}, function()
            local algorithms = {'sha1', 'sha384', 'sha512', 'md5', 'sha256', 'sha3-224', 'sha3-256', 'sha3-512'}
            for _, algorithm in ipairs(algorithms) do
                local hash = crypt.hash("test", algorithm)
                assert(hash, "crypt.hash on algorithm '" .. algorithm .. "' should return a hash")
            end
        end)
        
        --- Debug
        
        test("debug.getconstant", {}, function()
            local function test()
                print("Hello, world!")
            end
            assert(debug.getconstant(test, 1) == "print", "First constant must be print")
            assert(debug.getconstant(test, 2) == nil, "Second constant must be nil")
            assert(debug.getconstant(test, 3) == "Hello, world!", "Third constant must be 'Hello, world!'")
        end)
        
        test("debug.getconstants", {}, function()
            local function test()
                local num = 5000 .. 50000
                print("Hello, world!", num, warn)
            end
            local constants = debug.getconstants(test)
            assert(constants[1] == 50000, "First constant must be 50000")
            assert(constants[2] == "print", "Second constant must be print")
            assert(constants[3] == nil, "Third constant must be nil")
            assert(constants[4] == "Hello, world!", "Fourth constant must be 'Hello, world!'")
            assert(constants[5] == "warn", "Fifth constant must be warn")
        end)
        
        test("debug.getinfo", {}, function()
            local types = {
                source = "string",
                short_src = "string",
                func = "function",
                what = "string",
                currentline = "number",
                name = "string",
                nups = "number",
                numparams = "number",
                is_vararg = "number",
            }
            local function test(...)
                print(...)
            end
            local info = debug.getinfo(test)
            for k, v in pairs(types) do
                assert(info[k] ~= nil, "Did not return a table with a '" .. k .. "' field")
                assert(type(info[k]) == v, "Did not return a table with " .. k .. " as a " .. v .. " (got " .. type(info[k]) .. ")")
            end
        end)
        
        test("debug.getproto", {}, function()
            local function test()
                local function proto()
                    return true
                end
            end
            local proto = debug.getproto(test, 1, true)[1]
            local realproto = debug.getproto(test, 1)
            assert(proto, "Failed to get the inner function")
            assert(proto() == true, "The inner function did not return anything")
            if not realproto() then
                return "Proto return values are disabled on this executor"
            end
        end)
        
        test("debug.getprotos", {}, function()
            local function test()
                local function _1()
                    return true
                end
                local function _2()
                    return true
                end
                local function _3()
                    return true
                end
            end
            for i in ipairs(debug.getprotos(test)) do
                local proto = debug.getproto(test, i, true)[1]
                local realproto = debug.getproto(test, i)
                assert(proto(), "Failed to get inner function " .. i)
                if not realproto() then
                    return "Proto return values are disabled on this executor"
                end
            end
        end)
        
        test("debug.getstack", {}, function()
            local _ = "a" .. "b"
            assert(debug.getstack(1, 1) == "ab", "The first item in the stack should be 'ab'")
            assert(debug.getstack(1)[1] == "ab", "The first item in the stack table should be 'ab'")
        end)
        
        test("debug.getupvalue", {}, function()
            local upvalue = function() end
            local function test()
                print(upvalue)
            end
            assert(debug.getupvalue(test, 1) == upvalue, "Unexpected value returned from debug.getupvalue")
        end)
        
        test("debug.getupvalues", {}, function()
            local upvalue = function() end
            local function test()
                print(upvalue)
            end
            local upvalues = debug.getupvalues(test)
            assert(upvalues[1] == upvalue, "Unexpected value returned from debug.getupvalues")
        end)
        
        test("debug.setconstant", {}, function()
            local function test()
                return "fail"
            end
            debug.setconstant(test, 1, "success")
            assert(test() == "success", "debug.setconstant did not set the first constant")
        end)
        
        test("debug.setstack", {}, function()
            local function test()
                return "fail", debug.setstack(1, 1, "success")
            end
            assert(test() == "success", "debug.setstack did not set the first stack item")
        end)
        
        test("debug.setupvalue", {}, function()
            local function upvalue()
                return "fail"
            end
            local function test()
                return upvalue()
            end
            debug.setupvalue(test, 1, function()
                return "success"
            end)
            assert(test() == "success", "debug.setupvalue did not set the first upvalue")
        end)
        
        -- Filesystem
        
        if isfolder and makefolder and delfolder then
            if isfolder(".tests") then
                delfolder(".tests")
            end
            makefolder(".tests")
        end
        
        test("readfile", {}, function()
            writefile(".tests/readfile.txt", "success")
            assert(readfile(".tests/readfile.txt") == "success", "Did not return the contents of the file")
        end)
        
        test("listfiles", {}, function()
            makefolder(".tests/listfiles")
            writefile(".tests/listfiles/test_1.txt", "success")
            writefile(".tests/listfiles/test_2.txt", "success")
            local files = listfiles(".tests/listfiles")
            assert(#files == 2, "Did not return the correct number of files")
            assert(isfile(files[1]), "Did not return a file path")
            assert(readfile(files[1]) == "success", "Did not return the correct files")
            makefolder(".tests/listfiles_2")
            makefolder(".tests/listfiles_2/test_1")
            makefolder(".tests/listfiles_2/test_2")
            local folders = listfiles(".tests/listfiles_2")
            assert(#folders == 2, "Did not return the correct number of folders")
            assert(isfolder(folders[1]), "Did not return a folder path")
        end)
        
        test("writefile", {}, function()
            writefile(".tests/writefile.txt", "success")
            assert(readfile(".tests/writefile.txt") == "success", "Did not write the file")
            local requiresFileExt = pcall(function()
                writefile(".tests/writefile", "success")
                assert(isfile(".tests/writefile.txt"))
            end)
            if not requiresFileExt then
                return "This executor requires a file extension in writefile"
            end
        end)
        
        test("makefolder", {}, function()
            makefolder(".tests/makefolder")
            assert(isfolder(".tests/makefolder"), "Did not create the folder")
        end)
        
        test("appendfile", {}, function()
            writefile(".tests/appendfile.txt", "su")
            appendfile(".tests/appendfile.txt", "cce")
            appendfile(".tests/appendfile.txt", "ss")
            assert(readfile(".tests/appendfile.txt") == "success", "Did not append the file")
        end)
        
        test("isfile", {}, function()
            writefile(".tests/isfile.txt", "success")
            assert(isfile(".tests/isfile.txt") == true, "Did not return true for a file")
            assert(isfile(".tests") == false, "Did not return false for a folder")
            assert(isfile(".tests/doesnotexist.exe") == false, "Did not return false for a nonexistent path (got " .. tostring(isfile(".tests/doesnotexist.exe")) .. ")")
        end)
        
        test("isfolder", {}, function()
            assert(isfolder(".tests") == true, "Did not return false for a folder")
            assert(isfolder(".tests/doesnotexist.exe") == false, "Did not return false for a nonexistent path (got " .. tostring(isfolder(".tests/doesnotexist.exe")) .. ")")
        end)
        
        test("delfolder", {}, function()
            makefolder(".tests/delfolder")
            delfolder(".tests/delfolder")
            assert(isfolder(".tests/delfolder") == false, "Failed to delete folder (isfolder = " .. tostring(isfolder(".tests/delfolder")) .. ")")
        end)
        
        test("delfile", {}, function()
            writefile(".tests/delfile.txt", "Hello, world!")
            delfile(".tests/delfile.txt")
            assert(isfile(".tests/delfile.txt") == false, "Failed to delete file (isfile = " .. tostring(isfile(".tests/delfile.txt")) .. ")")
        end)
        
        test("loadfile", {}, function()
            writefile(".tests/loadfile.txt", "return ... + 1")
            assert(assert(loadfile(".tests/loadfile.txt"))(1) == 2, "Failed to load a file with arguments")
            writefile(".tests/loadfile.txt", "f")
            local callback, err = loadfile(".tests/loadfile.txt")
            assert(err and not callback, "Did not return an error message for a compiler error")
        end)
        
        test("dofile", {})
        
        -- Input
        
        test("isrbxactive", {"isgameactive"}, function()
            assert(type(isrbxactive()) == "boolean", "Did not return a boolean value")
        end)
        
        test("mouse1click", {})
        
        test("mouse1press", {})
        
        test("mouse1release", {})
        
        test("mouse2click", {})
        
        test("mouse2press", {})
        
        test("mouse2release", {})
        
        test("mousemoveabs", {})
        
        test("mousemoverel", {})
        
        test("mousescroll", {})
        
        -- Instances
        
        test("fireclickdetector", {}, function()
            local detector = Instance.new("ClickDetector")
            fireclickdetector(detector, 50, "MouseHoverEnter")
        end)
        
        test("getcallbackvalue", {}, function()
            local bindable = Instance.new("BindableFunction")
            local function test()
            end
            bindable.OnInvoke = test
            assert(getcallbackvalue(bindable, "OnInvoke") == test, "Did not return the correct value")
        end)
        
        test("getconnections", {}, function()
            local types = {
                Enabled = "boolean",
                ForeignState = "boolean",
                LuaConnection = "boolean",
                Function = "function",
                Thread = "thread",
                Fire = "function",
                Defer = "function",
                Disconnect = "function",
                Disable = "function",
                Enable = "function",
            }
            local bindable = Instance.new("BindableEvent")
            bindable.Event:Connect(function() end)
            local connection = getconnections(bindable.Event)[1]
            for k, v in pairs(types) do
                assert(connection[k] ~= nil, "Did not return a table with a '" .. k .. "' field")
                assert(type(connection[k]) == v, "Did not return a table with " .. k .. " as a " .. v .. " (got " .. type(connection[k]) .. ")")
            end
        end)
        
        test("getcustomasset", {}, function()
            writefile(".tests/getcustomasset.txt", "success")
            local contentId = getcustomasset(".tests/getcustomasset.txt")
            assert(type(contentId) == "string", "Did not return a string")
            assert(#contentId > 0, "Returned an empty string")
            assert(string.match(contentId, "rbxasset://") == "rbxasset://", "Did not return an rbxasset url")
        end)
        
        test("gethiddenproperty", {}, function()
            local fire = Instance.new("Fire")
            local property, isHidden = gethiddenproperty(fire, "size_xml")
            assert(property == 5, "Did not return the correct value")
            assert(isHidden == true, "Did not return whether the property was hidden")
        end)
        
        test("sethiddenproperty", {}, function()
            local fire = Instance.new("Fire")
            local hidden = sethiddenproperty(fire, "size_xml", 10)
            assert(hidden, "Did not return true for the hidden property")
            assert(gethiddenproperty(fire, "size_xml") == 10, "Did not set the hidden property")
        end)
        
        test("gethui", {}, function()
            assert(typeof(gethui()) == "Instance", "Did not return an Instance")
        end)
        
        test("getinstances", {}, function()
            assert(getinstances()[1]:IsA("Instance"), "The first value is not an Instance")
        end)
        
        test("getnilinstances", {}, function()
            assert(getnilinstances()[1]:IsA("Instance"), "The first value is not an Instance")
            assert(getnilinstances()[1].Parent == nil, "The first value is not parented to nil")
        end)
        
        test("isscriptable", {}, function()
            local fire = Instance.new("Fire")
            assert(isscriptable(fire, "size_xml") == false, "Did not return false for a non-scriptable property (size_xml)")
            assert(isscriptable(fire, "Size") == true, "Did not return true for a scriptable property (Size)")
        end)
        
        test("setscriptable", {}, function()
            local fire = Instance.new("Fire")
            local wasScriptable = setscriptable(fire, "size_xml", true)
            assert(wasScriptable == false, "Did not return false for a non-scriptable property (size_xml)")
            assert(isscriptable(fire, "size_xml") == true, "Did not set the scriptable property")
            fire = Instance.new("Fire")
            assert(isscriptable(fire, "size_xml") == false, "⚠️⚠️ setscriptable persists between unique instances ⚠️⚠️")
        end)
        
        test("setrbxclipboard", {})
        
        -- Metatable
        
        -- DETECTED
        test("getrawmetatable", {}, function()
            local metatable = { __metatable = "Locked!" }
            local object = setmetatable({}, metatable)
            assert(getrawmetatable(object) == metatable, "Did not return the metatable")
        end)
        
        -- DETECTED
        test("hookmetamethod", {}, function()
            local object = setmetatable({}, { __index = newcclosure(function() return false end), __metatable = "Locked!" })
            local ref = hookmetamethod(object, "__index", function() return true end)
            assert(object.test == true, "Failed to hook a metamethod and change the return value")
            assert(ref() == false, "Did not return the original function")
        end)
        
        -- DETECTED
        test("getnamecallmethod", {}, function()
            local method
            local ref
            ref = hookmetamethod(game, "__namecall", function(...)
                if not method then
                    method = getnamecallmethod()
                end
                return ref(...)
            end)
            game:GetService("Lighting")
            assert(method == "GetService", "Did not get the correct method (GetService)")
        end)
        
        test("isreadonly", {}, function()
            local object = {}
            table.freeze(object)
            assert(isreadonly(object), "Did not return true for a read-only table")
        end)
        
        test("setrawmetatable", {}, function()
            local object = setmetatable({}, { __index = function() return false end, __metatable = "Locked!" })
            local objectReturned = setrawmetatable(object, { __index = function() return true end })
            assert(object, "Did not return the original object")
            assert(object.test == true, "Failed to change the metatable")
            if objectReturned then
                return objectReturned == object and "Returned the original object" or "Did not return the original object"
            end
        end)
        
        test("setreadonly", {}, function()
            local object = { success = false }
            table.freeze(object)
            setreadonly(object, false)
            object.success = true
            assert(object.success, "Did not allow the table to be modified")
        end)
        
        -- Miscellaneous
        
        test("identifyexecutor", {"getexecutorname"}, function()
            local name, version = identifyexecutor()
            assert(type(name) == "string", "Did not return a string for the name")
            return type(version) == "string" and "Returns version as a string" or "Does not return version"
        end)
        
        test("lz4compress", {}, function()
            local raw = "Hello, world!"
            local compressed = lz4compress(raw)
            assert(type(compressed) == "string", "Compression did not return a string")
            assert(lz4decompress(compressed, #raw) == raw, "Decompression did not return the original string")
        end)
        
        test("lz4decompress", {}, function()
            local raw = "Hello, world!"
            local compressed = lz4compress(raw)
            assert(type(compressed) == "string", "Compression did not return a string")
            assert(lz4decompress(compressed, #raw) == raw, "Decompression did not return the original string")
        end)
        
        test("messagebox", {})
        
        test("queue_on_teleport", {"queueonteleport"})
        
        test("request", {"http.request", "http_request"}, function()
            local response = request({
                Url = "https://httpbin.org/user-agent",
                Method = "GET",
            })
            assert(type(response) == "table", "Response must be a table")
            assert(response.StatusCode == 200, "Did not return a 200 status code")
            local data = game:GetService("HttpService"):JSONDecode(response.Body)
            assert(type(data) == "table" and type(data["user-agent"]) == "string", "Did not return a table with a user-agent key")
            return "User-Agent: " .. data["user-agent"]
        end)
        
        test("setclipboard", {"toclipboard"})
        
        test("setfpscap", {}, function()
            local renderStepped = game:GetService("RunService").RenderStepped
            local function step()
                renderStepped:Wait()
                local sum = 0
                for _ = 1, 5 do
                    sum += 1 / renderStepped:Wait()
                end
                return math.round(sum / 5)
            end
            setfpscap(60)
            local step60 = step()
            setfpscap(0)
            local step0 = step()
            return step60 .. "fps @60 • " .. step0 .. "fps @0"
        end)
        
        -- Scripts
        
        test("getgc", {}, function()
            local gc = getgc()
            assert(type(gc) == "table", "Did not return a table")
            assert(#gc > 0, "Did not return a table with any values")
        end)
        
        -- DETECTED
        test("getgenv", {}, function()
            getgenv().__TEST_GLOBAL = true
            assert(__TEST_GLOBAL, "Failed to set a global variable")
            getgenv().__TEST_GLOBAL = nil
        end)
        
        -- DETECTED
        test("getloadedmodules", {}, function()
            local modules = getloadedmodules()
            assert(type(modules) == "table", "Did not return a table")
            assert(#modules > 0, "Did not return a table with any values")
            assert(typeof(modules[1]) == "Instance", "First value is not an Instance")
            assert(modules[1]:IsA("ModuleScript"), "First value is not a ModuleScript")
        end)
        
        -- DETECTED
        test("getrenv", {}, function()
            assert(_G ~= getrenv()._G, "The variable _G in the executor is identical to _G in the game")
        end)
        
        test("getrunningscripts", {}, function()
            local scripts = getrunningscripts()
            assert(type(scripts) == "table", "Did not return a table")
            assert(#scripts > 0, "Did not return a table with any values")
            assert(typeof(scripts[1]) == "Instance", "First value is not an Instance")
            assert(scripts[1]:IsA("ModuleScript") or scripts[1]:IsA("LocalScript"), "First value is not a ModuleScript or LocalScript")
        end)
        
        test("getscriptbytecode", {"dumpstring"}, function()
            local animate = game:GetService("Players").LocalPlayer.Character.Animate
            local bytecode = getscriptbytecode(animate)
            assert(type(bytecode) == "string", "Did not return a string for Character.Animate (a " .. animate.ClassName .. ")")
        end)
        
        -- DETECTED
        test("getscripthash", {}, function()
            local animate = game:GetService("Players").LocalPlayer.Character.Animate:Clone()
            local hash = getscripthash(animate)
            local source = animate.Source
            animate.Source = "print('Hello, world!')"
            task.defer(function()
                animate.Source = source
            end)
            local newHash = getscripthash(animate)
            assert(hash ~= newHash, "Did not return a different hash for a modified script")
            assert(newHash == getscripthash(animate), "Did not return the same hash for a script with the same source")
        end)
        
        test("getscripts", {}, function()
            local scripts = getscripts()
            assert(type(scripts) == "table", "Did not return a table")
            assert(#scripts > 0, "Did not return a table with any values")
            assert(typeof(scripts[1]) == "Instance", "First value is not an Instance")
            assert(scripts[1]:IsA("ModuleScript") or scripts[1]:IsA("LocalScript"), "First value is not a ModuleScript or LocalScript")
        end)
        
        -- DETECTED
        test("getsenv", {}, function()
            local animate = game:GetService("Players").LocalPlayer.Character.Animate
            local env = getsenv(animate)
            assert(type(env) == "table", "Did not return a table for Character.Animate (a " .. animate.ClassName .. ")")
            assert(env.script == animate, "The script global is not identical to Character.Animate")
        end)
        
        test("getthreadidentity", {"getidentity", "getthreadcontext"}, function()
            assert(type(getthreadidentity()) == "number", "Did not return a number")
        end)
        
        test("setthreadidentity", {"setidentity", "setthreadcontext"}, function()
            setthreadidentity(3)
            assert(getthreadidentity() == 3, "Did not set the thread identity")
        end)
        
        -- Drawing
        
        test("Drawing", {})
        
        test("Drawing.new", {}, function()
            local drawing = Drawing.new("Square")
            drawing.Visible = false
            local canDestroy = pcall(function()
                drawing:Destroy()
            end)
            assert(canDestroy, "Drawing:Destroy() should not throw an error")
        end)
        
        test("Drawing.Fonts", {}, function()
            assert(Drawing.Fonts.UI == 0, "Did not return the correct id for UI")
            assert(Drawing.Fonts.System == 1, "Did not return the correct id for System")
            assert(Drawing.Fonts.Plex == 2, "Did not return the correct id for Plex")
            assert(Drawing.Fonts.Monospace == 3, "Did not return the correct id for Monospace")
        end)
        
        test("isrenderobj", {}, function()
            local drawing = Drawing.new("Image")
            drawing.Visible = true
            assert(isrenderobj(drawing) == true, "Did not return true for an Image")
            assert(isrenderobj(newproxy()) == false, "Did not return false for a blank table")
        end)
        
        test("getrenderproperty", {}, function()
            local drawing = Drawing.new("Image")
            drawing.Visible = true
            assert(type(getrenderproperty(drawing, "Visible")) == "boolean", "Did not return a boolean value for Image.Visible")
            local success, result = pcall(function()
                return getrenderproperty(drawing, "Color")
            end)
            if not success or not result then
                return "Image.Color is not supported"
            end
        end)
        
        test("setrenderproperty", {}, function()
            local drawing = Drawing.new("Square")
            drawing.Visible = true
            setrenderproperty(drawing, "Visible", false)
            assert(drawing.Visible == false, "Did not set the value for Square.Visible")
        end)
        
        test("cleardrawcache", {}, function()
            cleardrawcache()
        end)
        
        -- WebSocket
        
        test("WebSocket", {})
        
        test("WebSocket.connect", {}, function()
            local types = {
                Send = "function",
                Close = "function",
                OnMessage = {"table", "userdata"},
                OnClose = {"table", "userdata"},
            }
            local ws = WebSocket.connect("ws://echo.websocket.events")
            assert(type(ws) == "table" or type(ws) == "userdata", "Did not return a table or userdata")
            for k, v in pairs(types) do
                if type(v) == "table" then
                    assert(table.find(v, type(ws[k])), "Did not return a " .. table.concat(v, ", ") .. " for " .. k .. " (a " .. type(ws[k]) .. ")")
                else
                    assert(type(ws[k]) == v, "Did not return a " .. v .. " for " .. k .. " (a " .. type(ws[k]) .. ")")
                end
            end
            ws:Close()
        end)            
    end
    function Initiate()
        print("⏺️ Initting...")
    
        PLVSMVWVRE_Menu()
        print("✅ PLVSMVWVRE_Menu executed successfully!")
    end
    function Inject()
        print("⏺️ Checking...")

        print("⏺️ Launching UNC Test.")
        UNCTest()

        repeat task.wait() until UNCTestFinished
        if UNCTestFinished then
            if UNCRecieved > RequiredUNC then
                print("✅ UNC Amount met!")
                
                repeat
                    task.wait()
                    local PlayersLoaded = game:GetService("Players")
                    task.wait() -- Wait a frame before checking again
                until PlayersLoaded ~= nil

                print("✅ Required UNC met: ".. UNCRecieved)
                Initiate()
            else
                error("⚠️ UNC needs to be atleast 70+ to run this script on your executor! ⚠️")
            end
        end
    end
    Inject()
end

local success, errorMessage = hookedPcall(function() repeat task.wait() until game:IsLoaded() PlayAnimation() CallBuild() end)
if success then print("✅ Initialized Build!") else error("🚨 Build Call Failed 2 Initialize: "..tostring(errorMessage)) end
