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
    print(`🚀 Launched!`)
    local startTime = os.clock()
    local success, result = originalPcall(func, ...)
    local duration = os.clock() - startTime
    return success, result
end

-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |                                   GLOBAL / FILE SCOPE VARIABLES                                 |
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

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
local flySpeed = 50 
local rootPart = char:WaitForChild("HumanoidRootPart")
local PlaceId = game.PlaceId
local JobId = game.JobId
local flyForce, flyConnection

-- Sirius Sense ESP remains untouched
local Sense = loadstring(game:HttpGet('https://sirius.menu/sense'))()
local ArrowESP, Skeleton
local ExecName = (identifyexecutor and identifyexecutor() or getexecutorname and getexecutorname() or "Unknown Executor")
if not ExecName or ExecName == "" then
    ExecName = "Unknown Executor"
end
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
local lastKilledTarget     
local trackedTarget        
local initialHealth        
local no = true
local originalCFrame = nil
local originalY = nil
local ARE_YOU_DONE = true
local currentRotation = 0
local EventConnections = {}
local KillCount = 0
local OVERKillCount = 0
local blacklisted = {"AnnaBypasser", "SurpWare", "-net", "-gh", "/cmds", ".cmds", "/e", "-re", "CONTROLBOTZ!", "#", "[TOOL GIVER]"}

-- Setup Sense ESP Settings
local SKELETON_SETTINGS = {
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
    FLOOR_DETECTION_THRESHOLD = 3, 
    FLY_VELOCITY_THRESHOLD = 1,   
    FLY_DETECTION_THRESHOLD = 1,   
    SPEED_THRESHOLD = 16,          
    JUMP_THRESHOLD = 75,           
    TELEPORT_THRESHOLD = 1.5,       
    VELOCITY_CHANGE_THRESHOLD = 75, 
    MAX_SPIKES = 1,                
    SPIN_DETECTION_THRESHOLD = 50, 
    HOOK_DISTANCE_THRESHOLD = 1.0, 
    HOOK_DURATION_THRESHOLD = 5, 
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
    TeamCheck = false, 
    OutlineColor = Color3.fromRGB(0, 0, 0),
    OutlineTransparency = 0,
    FillColor = Color3.fromRGB(0, 0, 0),
    FillTransparency = 0,
    CheckVisibility = true, 
}
local Aimbot = {
    Enabled = false, 
    itboxes = { ["Head"] = true },
    CheckVisibility = false, 
    CheckAlive = false, 
    CheckForcefield = false, 
    Smoothing = 0, 
    Prediction = false, 
    TeamCheck = false, 
    Prediction_Offset = 0, 
    Distance = 0, 
    Triggerbot_Sensitivity = 10, 
    AutoShoot = false,
    AutoShoot_Delay = 0,
    Resolver = false,
    ResolverHistory = 0.5, 
    MaxPredictionError = 2.0, 
    VelocitySmoothing = 0.7, 
    DesyncDetection = true, 
    JitterThreshold = 0.15, 
    MinPredictionConfidence = 0.1, 
    ConfidenceAmount = 1.0, -- Added dynamic real-time tracking variable

    FOVRadius = 0, 
    FOVCheck = false, 
    FOVColor = Color3.fromRGB(255, 255, 255), 
    FOVThickness = 0, 
    FOVVisible = false, 
    FOVTransparency = 1, 
    FOVSides = 32, 
}
local RCS_Sets = {
    Enabled = false, 
    RecoilControl = 10,
    RecoilDownAim = 1000,
    Speed = 5,
}
local Crosshair = {
    Enabled = false, 
    Sides = 4, 
    Size = 15, 
    Color = Color3.fromRGB(255, 255, 255), 
    Transparency = 0, 
    Rotation = 0, 
    Thickness = 2, 
    Gap = 4, 
    x_Off = 0,
    y_Off = 0,
}
local AntiAim = {
    Activated = false, 
    Jitter = 0.5, 
    Jitter_X = 0.5, 
    Jitter_Z = 0.5, 
    SpinSpeed = 10, 
    SpinDirection = 1, 
    SpinSwitchInterval = 180, 
}
local ChatSpammerrr = {
    Activated = false,
    Mode = 0
}
local Orbiter_Settings = {
    Target = "TargetPlayerName",
    Height = 5,
    BaseRadius = 8,  
    BaseSpeed = 2,   
    Speed = 2,       
    Smoothness = 0.2,
    MaxSpeed = 50,
    RadiusScale = 1.5  
}
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

local initialPlayerStats = {}
local timeSinceLastFloor = {}
local flyingTime = {}
local playerFlags = {}  
local lastRotations = {}
local playerChatHistory = {} 
local playerMuteTimers = {}  
local hookTimers = {} 
local chatLogs = {}

local playerWalkspeedCache = player.Character.Humanoid.WalkSpeed
local playerJumpPowerCache = player.Character.Humanoid.JumpPower

local orbitOffset = math.random() * 2 * math.pi
local screenGui, cursorFrame, crosshairFrame
local cursorLines = {}
local Notif 
local Wm 

-- Initialize Mock Library Object to ensure backwards compatibility with any nested safeNotify's
getgenv().Library = {
    Notify = function(self, text, time)
        if Notif then
            Notif:Notify(text, time or 5, "information")
        else
            print("[uh hi]:", text)
        end
    end,
    SetWatermarkVisibility = function() end,
    Unloaded = false
}

-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |                                         SUPPORT FUNCTIONS                                       |
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

local function validateMessage(input)
    return tostring(input or "nil message received")
end 

local function safeNotify(message)
    pcall(function() getgenv().Library:Notify(message) end)
end

local function consolePrint(color, tag, message)
    rconsoleprint(
        COLORS.GRAY.."["..os.date("%H:%M:%S").."]"..
        color.." [PLVSMVWVRE | "..tag.."] "..
        COLORS.RESET..validateMessage(message).."\n"
    )
end

local function Notificate(color, i)
    if not i then 
        i = color
        color = COLORS.WHITE
    elseif COLORS[color] then 
        color = COLORS[color]
    end
    safeNotify(i)
    consolePrint(color, "INFO", i)
end

local function Warning_Notificate(i)
    safeNotify(i)
    consolePrint(COLORS.YELLOW, "WARNING", i)
end

local function Err_Notificate(i)
    safeNotify(i)
    consolePrint(COLORS.BG_RED..COLORS.WHITE, "ERROR", i)
end

local function Success_Notificate(i)
    safeNotify(i)
    consolePrint(COLORS.GREEN, "SUCCESS", i)
end

repeat Camera = Workspace.CurrentCamera task.wait() until Camera
local function GetScreenCenter()
    local currentCam = workspace.CurrentCamera or Workspace.CurrentCamera
    if not currentCam then 
        return Vector2.new(0, 0) 
    end
    local ScreenSize = currentCam.ViewportSize
    return Vector2.new(ScreenSize.X / 2, ScreenSize.Y / 2)
end
local FOVCircleOutline, FOVCircleInnerOutline, FOVCircle

local function InitializeDrawing()
    if FOVCircle then return end -- Already loaded
    FOVCircleOutline = Drawing.new("Circle")
    FOVCircleInnerOutline = Drawing.new("Circle")
    FOVCircle = Drawing.new("Circle")
end


local function Nametags()
    local function createBillboardGui(character)
        local head = character:FindFirstChild("Head")
        if not head then return end
    
        local existingBillboard = head:FindFirstChild("SentinelBillboard")
        if existingBillboard then
            existingBillboard:Destroy()
        end
    
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
    
    local function monitorPlayer(p_obj)
        p_obj.CharacterAdded:Connect(function(character)
            createBillboardGui(character)
        end)
    
        if p_obj.Character then
            createBillboardGui(p_obj.Character)
        end
    end
    
    for _, item in ipairs(Players:GetPlayers()) do
        if item.Character then
            local head = item.Character:FindFirstChild("Head")
            if head and head:FindFirstChild("SentinelBillboard") then
                head.SentinelBillboard:Destroy()
            end
        end
    end
    
    for _, item in ipairs(Players:GetPlayers()) do
        monitorPlayer(item)
    end
    
    Players.PlayerAdded:Connect(monitorPlayer)
    
    if namt then
        namt:Disconnect()
        namt = nil
    end
    namt = RunService.RenderStepped:Connect(function()
        for _, item in ipairs(Players:GetPlayers()) do
            if item.Character then
                createBillboardGui(item.Character)
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
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n<3\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou're a silly boykisser!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\nPLVSMVWVRE.lol's Rebirth is happening!\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\nPLVSMVWVRE.lol's Rebirth is happening!\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\nPLVSMVWVRE.lol's Rebirth is happening!\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n.\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",
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
            "/emote laugh" 
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

local function Console()
    rconsoleclear()
    if BetaBuild then
        consolePrint(COLORS.YELLOW, "BETA", "This is a beta build, expect crashes and bugs! Report them in the discord server!")
    end
    consolePrint(COLORS.WHITE, "INFO", string.rep("-", 100))
    consolePrint(COLORS.WHITE, "INFO", "|                                   [LOADER] Initializing Logs                                    |")
    consolePrint(COLORS.WHITE, "INFO", string.rep("-", 100))
    rconsolesettitle("PLVSMVWVRE.lol")
end

local function onPlayerJoined(player_obj) Notificate(COLORS.GREEN, "[JOINED] "..player_obj.DisplayName.. " ("..player_obj.Name..")") end
local function onPlayerLeft(player_obj) Notificate(COLORS.RED, "[LEFT] "..player_obj.DisplayName.. " ("..player_obj.Name..")") end

local function Anti_ESEXr()
    local games = {
        [81867885668235] = true,
        [135275461271957] = true,
        [92653906244870] = true
    }
    
    if games[game.PlaceId] then
        getgenv().Library:Notify("Game is flagged by PLVSMVWVRE.lol!, this is innopropiate!!!!!!!!, dont be in here bro!", 5)
        wait(5)
        loadstring(game:HttpGet('https://catnip.at.ua/AntiPiracy.lua'))()
    end
end

local function Orbiter(i)
    if i then
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
            
            local speedRatio = Orbiter_Settings.Speed / Orbiter_Settings.BaseSpeed
            local dynamicRadius = Orbiter_Settings.BaseRadius * (1 + (speedRatio - 1) * Orbiter_Settings.RadiusScale)
            
            local time = os.clock()
            local angle = time * Orbiter_Settings.Speed + orbitOffset
            local targetPos = targetRoot.Position + Vector3.new(
                math.cos(angle) * dynamicRadius,  
                Orbiter_Settings.Height,
                math.sin(angle) * dynamicRadius    
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
        if orbitConnection then
            orbitConnection:Disconnect()
            orbitConnection = nil
            currentTarget = nil
        end
    end
end

local function Cache_Old_Walkspeed_and_JumpPower()
    playerWalkspeedCache = player.Character.Humanoid.WalkSpeed
    playerJumpPowerCache = player.Character.Humanoid.JumpPower
end

local function Anticheat(i)
    local function sendExploitMessage(player_obj, message)
        if game.TextChatService and game.TextChatService:FindFirstChild("TextChannels") then
            local rbxGeneral = game.TextChatService.TextChannels:FindFirstChild("RBXGeneral")
            if rbxGeneral then
                rbxGeneral:DisplaySystemMessage(player_obj.Name .. " " .. message)
                if ExecName == "Potassium" then
                    return
                else
                    if Anticheat_Settings.REPORT then
                        Players:ReportAbuse(Players:FindFirstChild(player_obj), "Cheating", player_obj.Name .. " " .. message)
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
                        Players:ReportAbuse(Players:FindFirstChild(player_obj), "Cheating", player_obj.Name .. " " .. message)
                    end
                end
                game.StarterGui:SetCore("ChatMakeSystemMessage", {
                    Text = player_obj.Name .. " " .. message,
                    Color = Color3.fromRGB(255, 0, 0),
                    Font = Enum.Font.Arial
                })
            end
        end
    end
    local function createCheaterIndicator(player_obj, message)
        local character = player_obj.Character
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
        textLabel.Position = UDim2.new(0.5, 0, 0.5, 0) 
        textLabel.AnchorPoint = Vector2.new(0.5, 0.5) 
        textLabel.BackgroundTransparency = 1
        textLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextScaled = true
        textLabel.Text = message
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.Parent = billboardGui
    end
    local function removeCheaterIndicator(player_obj)
        local character = player_obj.Character
        if not character then return end

        local indicator = character:FindFirstChild("CheaterIndicator")
        if indicator then
            indicator:Destroy()
        end
    end
    local function isOnGround(character, rootPart_obj)
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = { character }
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

        local rayOrigin = rootPart_obj.Position
        local rayDirection = Vector3.new(0, -5, 0)
        local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

        return result ~= nil
    end
    local function checkForFly(player_obj, deltaTime)
        local character = player_obj.Character
        if not character then return end

        local humanoid_obj = character:FindFirstChild("Humanoid")
        local humanoidRootPart_obj = character:FindFirstChild("HumanoidRootPart")
        if not humanoid_obj or not humanoidRootPart_obj then return end

        if humanoid_obj:GetState() == Enum.HumanoidStateType.Freefall then
            local verticalVelocity = humanoidRootPart_obj.Velocity.Y
            if math.abs(verticalVelocity) < Anticheat_Settings.FLY_VELOCITY_THRESHOLD then
                flyingTime[player_obj] = (flyingTime[player_obj] or 0) + deltaTime

                if flyingTime[player_obj] >= Anticheat_Settings.FLY_DETECTION_THRESHOLD then
                    initialPlayerStats[player_obj].spikeCount = (initialPlayerStats[player_obj].spikeCount or 0) + 1
                    if initialPlayerStats[player_obj].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                        sendExploitMessage(player_obj, "is exploiting! (FLY)")
                        playerFlags[player_obj] = "[CHEATER]"
                        createCheaterIndicator(player_obj, playerFlags[player_obj])
                    end

                    flyingTime[player_obj] = 0
                end
            else
                flyingTime[player_obj] = 0
            end
        else
            flyingTime[player_obj] = 0
        end
    end
    local function checkForSuspiciousMovement(player_obj)
        local character = player_obj.Character
        if not character then return end

        local humanoid_obj = character:FindFirstChild("Humanoid")
        if not humanoid_obj or humanoid_obj.Health <= 0 then return end 

        local humanoidRootPart_obj = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart_obj then return end

        if not initialPlayerStats[player_obj] then
             initialPlayerStats[player_obj] = {
                WalkSpeed = character.Humanoid.WalkSpeed,
                JumpPower = character.Humanoid.JumpPower,
                lastVelocity = humanoidRootPart_obj.Velocity,
                spikeCount = 0,
            }
        else
            if initialPlayerStats[player_obj].lastVelocity == nil then
                initialPlayerStats[player_obj].lastVelocity = humanoidRootPart_obj.Velocity
            end
        end

        local currentVelocity = humanoidRootPart_obj.Velocity
        local velocityChange = (currentVelocity - initialPlayerStats[player_obj].lastVelocity).Magnitude

        if velocityChange >= Anticheat_Settings.VELOCITY_CHANGE_THRESHOLD then
            initialPlayerStats[player_obj].spikeCount = (initialPlayerStats[player_obj].spikeCount or 0) + 1
            if initialPlayerStats[player_obj].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                sendExploitMessage(player_obj, "is exploiting! (SPEED)")
                playerFlags[player_obj] = "[CHEATER]"
                createCheaterIndicator(player_obj, playerFlags[player_obj])
            end
        else
            initialPlayerStats[player_obj].spikeCount = 0
        end

        initialPlayerStats[player_obj].lastVelocity = currentVelocity
    end
    local function checkForTeleportation(player_obj)
        local character = player_obj.Character
        if not character then return end

        local humanoid_obj = character:FindFirstChild("Humanoid")
        if not humanoid_obj or humanoid_obj.Health <= 0 then return end 

        local humanoidRootPart_obj = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart_obj then return end

        if not initialPlayerStats[player_obj] then
            initialPlayerStats[player_obj] = {
                WalkSpeed = character.Humanoid.WalkSpeed,
                JumpPower = character.Humanoid.JumpPower,
                lastPosition = humanoidRootPart_obj.Position,
            }
        else
            if initialPlayerStats[player_obj].lastPosition == nil then
                initialPlayerStats[player_obj].lastPosition = humanoidRootPart_obj.Position
            end
        end

        local currentPosition = humanoidRootPart_obj.Position
        local distanceMoved = (currentPosition - initialPlayerStats[player_obj].lastPosition).Magnitude

        if distanceMoved >= Anticheat_Settings.TELEPORT_THRESHOLD then
            initialPlayerStats[player_obj].spikeCount = (initialPlayerStats[player_obj].spikeCount or 0) + 1
            if initialPlayerStats[player_obj].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                sendExploitMessage(player_obj, "is exploiting! (TELEPORTATION)")
                playerFlags[player_obj] = "[CHEATER]"
                createCheaterIndicator(player_obj, playerFlags[player_obj])
            end
        end

        initialPlayerStats[player_obj].lastPosition = currentPosition
    end
    local function checkForSpin(player_obj, deltaTime)
        local character = player_obj.Character
        if not character then return end

        local humanoid_obj = character:FindFirstChild("Humanoid")
        if not humanoid_obj or humanoid_obj.Health <= 0 then return end 

        local humanoidRootPart_obj = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart_obj then return end

        if not lastRotations[player_obj] then
            lastRotations[player_obj] = humanoidRootPart_obj.CFrame  
            return  
        end

        local currentRotation_val = humanoidRootPart_obj.CFrame
        local rotationDelta = lastRotations[player_obj]:ToObjectSpace(currentRotation_val)  
        local _, _, yRotation = rotationDelta:ToOrientation()  

        local rotationSpeed = math.abs(math.deg(yRotation) / deltaTime)

        if rotationSpeed > Anticheat_Settings.SPIN_DETECTION_THRESHOLD then
            initialPlayerStats[player_obj].spikeCount = (initialPlayerStats[player_obj].spikeCount or 0) + 1
            if initialPlayerStats[player_obj].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                sendExploitMessage(player_obj, "is exploiting! (SPINBOT)")
                playerFlags[player_obj] = "[CHEATER]"
                createCheaterIndicator(player_obj, playerFlags[player_obj])
            end
        end

        lastRotations[player_obj] = currentRotation_val  
    end

    local function setupCharacter(player_obj)
        local character = player_obj.Character
        if character then
            local humanoid_obj = character:FindFirstChild("Humanoid")
            local rootPart_obj = character:FindFirstChild("HumanoidRootPart")
            if humanoid_obj and rootPart_obj then
                initialPlayerStats[player_obj] = {
                    WalkSpeed = humanoid_obj.WalkSpeed,
                    JumpPower = humanoid_obj.JumpPower,
                    lastVelocity = rootPart_obj.Velocity,
                    lastPosition = rootPart_obj.Position,
                    spikeCount = 0,  
                }

                if playerFlags[player_obj] then
                    createCheaterIndicator(player_obj, playerFlags[player_obj])
                end
            end
        end
    end
    local function onPlayerAdded(player_obj)
        player_obj.CharacterAdded:Connect(function(character)
            setupCharacter(player_obj)
        end)
    end
    local function checkForHook(player_obj)
        local character = player_obj.Character
        if not character then return end
        local humanoid_obj = character:FindFirstChild("Humanoid")
        if not humanoid_obj or humanoid_obj.Health <= 0 then return end 
        local rootPart_obj = character:FindFirstChild("HumanoidRootPart")
        if not rootPart_obj then return end
    
        local closestPlayer = nil
        local closestDistance = math.huge
    
        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= player_obj and otherPlayer.Character then
                local otherRootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                if otherRootPart then
                    local distance = (rootPart_obj.Position - otherRootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = otherPlayer
                    end
                end
            end
        end
    
        if closestPlayer and closestDistance <= Anticheat_Settings.HOOK_DISTANCE_THRESHOLD then
            local humanoid_v = character:FindFirstChild("Humanoid")
            if not humanoid_v or humanoid_v.Health <= 0 then return end 

            if not hookTimers[player_obj] then
                hookTimers[player_obj] = {target = closestPlayer, startTime = tick()}
            elseif hookTimers[player_obj].target ~= closestPlayer then
                 hookTimers[player_obj] = {target = closestPlayer, startTime = tick()}
            end
    
            if hookTimers[player_obj] and tick() - hookTimers[player_obj].startTime >= Anticheat_Settings.HOOK_DURATION_THRESHOLD then
                initialPlayerStats[player_obj].spikeCount = (initialPlayerStats[player_obj].spikeCount or 0) + 1
                if initialPlayerStats[player_obj].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                    sendExploitMessage(player_obj, " is having WAYYY too much fun... (E-Sexing " .. closestPlayer.Name .. ")")
                    playerFlags[player_obj] = "[RAPIST]"
                    createCheaterIndicator(player_obj, playerFlags[player_obj])
                end
                hookTimers[player_obj] = nil
            end
        else
            hookTimers[player_obj] = nil
        end
    end

    if i then
        if EasyAC then
            EasyAC:Disconnect()
            EasyAC = nil
        end

        for _, item in ipairs(Players:GetPlayers()) do
            onPlayerAdded(item)
        end
        
        Players.PlayerAdded:Connect(onPlayerAdded)

        Players.PlayerRemoving:Connect(function(item)
            removeCheaterIndicator(item)
        end)

        EasyAC = RunService.Heartbeat:Connect(function(deltaTime)
            for _, item in ipairs(Players:GetPlayers()) do
                if item and item.Character then
                    local character = item.Character
                    local humanoid_obj = character:FindFirstChild("Humanoid")
                    local rootPart_obj = character:FindFirstChild("HumanoidRootPart")

                    if humanoid_obj and rootPart_obj then
                        if item == Players.LocalPlayer then continue end

                        local isGrounded = isOnGround(character, rootPart_obj)

                        if isGrounded then
                            timeSinceLastFloor[item] = 0
                        else
                            timeSinceLastFloor[item] = (timeSinceLastFloor[item] or 0) + deltaTime
                        end

                        if timeSinceLastFloor[item] and timeSinceLastFloor[item] >= Anticheat_Settings.FLOOR_DETECTION_THRESHOLD then
                            local humanoid_v = character:FindFirstChild("Humanoid")
                            if not humanoid_v or humanoid_v.Health <= 0 then return end 

                            initialPlayerStats[item].spikeCount = (initialPlayerStats[item].spikeCount or 0) + 1
                            if initialPlayerStats[item].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                                local humanoid_v2 = character:FindFirstChild("Humanoid")
                                if not humanoid_v2 or humanoid_v2.Health <= 0 then return end 

                                sendExploitMessage(item, "is exploiting! (FLY)")
                                playerFlags[item] = "[CHEATER]"
                                createCheaterIndicator(item, playerFlags[item])
                            end

                            timeSinceLastFloor[item] = 0
                        end

                        checkForFly(item, deltaTime)
                        checkForSuspiciousMovement(item)
                        checkForTeleportation(item)
                        checkForSpin(item, deltaTime)  
                        checkForHook(item) 

                        if Anticheat_Settings.PARDONED then
                            removeCheaterIndicator(item)
                        end

                        if humanoid_obj.JumpPower > Anticheat_Settings.JUMP_THRESHOLD then
                            local humanoid_v = character:FindFirstChild("Humanoid")
                            if not humanoid_v or humanoid_v.Health <= 0 then return end 

                            initialPlayerStats[item].spikeCount = (initialPlayerStats[item].spikeCount or 0) + 1
                            if initialPlayerStats[item].spikeCount <= Anticheat_Settings.MAX_SPIKES then
                                sendExploitMessage(item, "is exploiting! (JUMPPOWER-HACK)")
                                playerFlags[item] = "[CHEATER]"
                                createCheaterIndicator(item, playerFlags[item])
                            end
                        end
                    else
                        initialPlayerStats[item] = nil
                        timeSinceLastFloor[item] = nil
                        flyingTime[item] = nil
                        removeCheaterIndicator(item)
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

local function ACBypassers()
    local MainACBypasser = "https://raw.githubusercontent.com/hollyntt/PLWVRE-Roblox-Script/refs/heads/main/PLVSMVWVRE-RBLX/src/Outside%20Func/AnticheatBypasses.lua"
    local games = {
        [17625359962] = "https://pastefy.app/EHeqdtQs/raw"
    }
    
    if games[game.PlaceId] then
        repeat task.wait() until game:IsLoaded()
        loadstring(game:HttpGet(games[game.PlaceId]))()
        getgenv().Library:Notify("Bypassed Game Specific Anticheat!", 2) 
        Success_Notificate("Bypassed Game Specific Anticheat!")
    else
        loadstring(game:HttpGet(MainACBypasser))()
        Success_Notificate("Loaded our own Bypass")
    end
end

local function UpdateVisuals()
    workspace.Camera.FieldOfView = ExtraVisuals.FOV
end

local function AntiIdle()
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

    local lastEnabled, lastSides, lastSize, lastColor, lastTransparency, lastRotation, lastThickness, lastGap

    local CrosshairLines = {} -- Persists the active drawing objects

    local function CrosshairGen()
        -- 1. Manage Mouse Icon Visibility
        if lastEnabled ~= Crosshair.Enabled then
            UserInputService.MouseIconEnabled = not Crosshair.Enabled
            lastEnabled = Crosshair.Enabled
        end

        -- 2. Hide and cleanup lines if disabled
        if not Crosshair.Enabled then
            for _, line in ipairs(CrosshairLines) do
                line.Visible = false
            end
            return
        end

        -- 3. Dynamically scale lines to match current settings
        while #CrosshairLines < Crosshair.Sides do
            table.insert(CrosshairLines, Drawing.new("Line"))
        end
        while #CrosshairLines > Crosshair.Sides do
            local oldLine = table.remove(CrosshairLines)
            pcall(function() oldLine:Destroy() end)
        end

        -- 4. Calculate coordinates based on absolute mouse position
        local mousePos = UserInputService:GetMouseLocation()
        local center = Vector2.new(mousePos.X + Crosshair.x_Off, mousePos.Y + Crosshair.y_Off)

        -- 5. Render lines in an absolute pixel overlay space
        local angleIncrement = 360 / Crosshair.Sides
        for i, line in ipairs(CrosshairLines) do
            local radAngle = math.rad((i - 1) * angleIncrement + Crosshair.Rotation)
            local dir = Vector2.new(math.cos(radAngle), math.sin(radAngle))

            line.Visible = true
            line.From = center + dir * Crosshair.Gap -- Starts exactly at 0 (center) if Gap is 0
            line.To = center + dir * (Crosshair.Gap + Crosshair.Size) -- Extends by the actual Length (Size)
            line.Color = Crosshair.Color
            line.Thickness = Crosshair.Thickness
            line.Transparency = 1 - Crosshair.Transparency 
        end
    end

    local function FB(Value)
        if Value then
            if YAHBNfyiuw then
                YAHBNfyiuw:Disconnect()
                YAHBNfyiuw = nil
            end

            YAHBNfyiuw = RunService.RenderStepped:Connect(function()
                local players = Players:GetPlayers()

                for i = #players, 2, -1 do
                    local j = math.random(i)
                    players[i], players[j] = players[j], players[i]
                end

                for _, player_obj in ipairs(players) do
                    Players.LocalPlayer:RequestFriendship(player_obj)
                    Success_Notificate("Added " .. player_obj.Name)
                    wait(15)  
                end
            end)
        else
            if YAHBNfyiuw then
                YAHBNfyiuw:Disconnect()
                YAHBNfyiuw = nil
            end
        end
    end

    local function UpdateFOV()
        local currentCam = workspace.CurrentCamera or Workspace.CurrentCamera
        if not currentCam then return end
        
        local ScreenCenter = GetScreenCenter()
        local ScreenSize = currentCam.ViewportSize

        -- Fallback safety for Radius
        local radiusSetting = (Aimbot.FOVRadius and Aimbot.FOVRadius > 0) and Aimbot.FOVRadius or 100
        local NormalizedFOVRadius = radiusSetting * (math.max(ScreenSize.X, ScreenSize.Y) / 1000)

        -- Safe fallbacks to prevent invisible rendering on load
        local thickness = (Aimbot.FOVThickness and Aimbot.FOVThickness > 0) and Aimbot.FOVThickness or 1.5
        local transparency = Aimbot.FOVTransparency or 1 
        local sides = (Aimbot.FOVSides and Aimbot.FOVSides >= 4) and Aimbot.FOVSides or 32

        FOVCircleOutline.Visible = Aimbot.FOVVisible
        FOVCircleOutline.Color = Color3.new(0, 0, 0) 
        FOVCircleOutline.Thickness = thickness + 1
        FOVCircleOutline.Radius = NormalizedFOVRadius + 2
        FOVCircleOutline.Filled = false
        FOVCircleOutline.NumSides = sides
        FOVCircleOutline.Position = ScreenCenter
        FOVCircleOutline.Transparency = transparency

        FOVCircleInnerOutline.Visible = Aimbot.FOVVisible
        FOVCircleInnerOutline.Color = Color3.new(0, 0, 0) 
        FOVCircleInnerOutline.Thickness = thickness + 1
        FOVCircleInnerOutline.Radius = NormalizedFOVRadius - 2
        FOVCircleInnerOutline.Filled = false
        FOVCircleInnerOutline.NumSides = sides
        FOVCircleInnerOutline.Position = ScreenCenter
        FOVCircleInnerOutline.Transparency = transparency

        FOVCircle.Visible = Aimbot.FOVVisible
        FOVCircle.Color = Aimbot.FOVColor
        FOVCircle.Thickness = thickness
        FOVCircle.Radius = NormalizedFOVRadius
        FOVCircle.Filled = false
        FOVCircle.NumSides = sides
        FOVCircle.Position = ScreenCenter
        FOVCircle.Transparency = transparency
    end

    local lastAimbotState = nil -- Prevents the loop from constantly rebinding
    local currentTarget = nil -- Global target reference to maintain sticky target lock-on

    local function LockOnGTA5()
        if Aimbot.Enabled == lastAimbotState then return end
        lastAimbotState = Aimbot.Enabled

        local Camera_obj = workspace.CurrentCamera
        local LocalPlayer = Players.LocalPlayer

        -- Persist resolver data across toggles so history is not lost
        if not getgenv().PersistentResolver then
            getgenv().PersistentResolver = {
                TargetHistory = {},
                PredictionConfidence = Aimbot.ConfidenceAmount,
                LastUpdateTime = tick(),
                MaxHistoryDuration = Aimbot.ResolverHistory,
                VelocitySmoothing = Aimbot.VelocitySmoothing,
                JitterThreshold = Aimbot.JitterThreshold,
                MinConfidence = Aimbot.MinPredictionConfidence,
                DesyncDetection = Aimbot.DesyncDetection,
                MaxPredictionError = Aimbot.MaxPredictionError
            }
        end
        local Resolver = getgenv().PersistentResolver

        -- Reusable raycast params to avoid high garbage-collection overhead
        local RaycastParameters = RaycastParams.new()
        RaycastParameters.FilterType = Enum.RaycastFilterType.Blacklist
        RaycastParameters.IgnoreWater = true

        -- Frame-rate independent CFrame interpolation
        local function frameIndependentLerp(startCFrame, targetCFrame, smoothing, deltaTime)
            if smoothing <= 0 then return targetCFrame end
            local speed = (1 / smoothing) * 2.2
            local alpha = 1 - math.exp(-speed * deltaTime)
            return startCFrame:Lerp(targetCFrame, math.clamp(alpha, 0, 1))
        end

        local function GetAvatarType(character)
            local UpperTorso = character:FindFirstChild("UpperTorso")
            return UpperTorso and "R15" or "R6"
        end

        local function GetBestHitbox(character)
            -- Fallback: Ensure the main Aimbot table exists
            if not Aimbot then
                Aimbot = { Enabled = false, Hitbox = "Head" }
            end

            local HitboxPriorities = {
                R6 = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
                R15 = {"Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm", "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg"}
            }
            local AvatarType = GetAvatarType(character)

            -- 1. Try reading the multi-choice table if it exists
            if Aimbot.Hitboxes and type(Aimbot.Hitboxes) == "table" then
                for _, HitboxName in ipairs(HitboxPriorities[AvatarType]) do
                    if Aimbot.Hitboxes[HitboxName] then
                        local Hitbox = character:FindFirstChild(HitboxName)
                        if Hitbox then return Hitbox end
                    end
                end
            end

            -- 2. Fallback to the old singular string setting if the table is missing
            if Aimbot.Hitbox and type(Aimbot.Hitbox) == "string" and Aimbot.Hitbox ~= "" then
                local Hitbox = character:FindFirstChild(Aimbot.Hitbox)
                if Hitbox then return Hitbox end
            end

            -- 3. Hard fallback to Head or PrimaryPart if all else is missing
            return character:FindFirstChild("Head") or character.PrimaryPart
        end

        -- Inner helper validation logic
        local function checkTargetValidity(player, screenCenter, fovRadius)
            if not player or not player.Character then return false end
            if Aimbot.TeamCheck and LocalPlayer.Team and player.Team == LocalPlayer.Team then return false end

            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if Aimbot.CheckAlive and (not humanoid or humanoid.Health <= 0) then return false end
            if Aimbot.CheckForcefield and player.Character:FindFirstChildOfClass("ForceField") then return false end

            local hitbox = GetBestHitbox(player.Character)
            if not hitbox then return false end

            local distance = (hitbox.Position - Camera_obj.CFrame.Position).Magnitude
            if Aimbot.Distance > 0 and distance > Aimbot.Distance then return false end

            if Aimbot.CheckVisibility then
                local origin = Camera_obj.CFrame.Position
                local direction = (hitbox.Position - origin).Unit
                RaycastParameters.FilterDescendantsInstances = {LocalPlayer.Character, Camera_obj}
                local result = workspace:Raycast(origin, direction * distance, RaycastParameters)
                if result and result.Instance:FindFirstAncestorOfClass("Model") ~= player.Character then
                    return false
                end
            end

            if Aimbot.FOVCheck then
                local screenPos, onScreen = Camera_obj:WorldToViewportPoint(hitbox.Position)
                if not onScreen then return false end
                local distanceCenter = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                if distanceCenter > fovRadius then return false end
            end

            return true, hitbox
        end

        local function UpdateResolverState(targetPlayer, hitbox, predictedPosition, actualPosition)
            if not Aimbot.Resolver then return end
            local currentTime = tick()
            local deltaTime = currentTime - Resolver.LastUpdateTime
            Resolver.LastUpdateTime = currentTime
            if not Resolver.TargetHistory[targetPlayer] then
                Resolver.TargetHistory[targetPlayer] = {
                    Positions = {}, Velocities = {}, Timestamps = {}, PredictionErrors = {}, LastActualPosition = actualPosition
                }
            end
            local targetData = Resolver.TargetHistory[targetPlayer]
            table.insert(targetData.Positions, predictedPosition)
            table.insert(targetData.Velocities, hitbox.Velocity or Vector3.new(0,0,0))
            table.insert(targetData.Timestamps, currentTime)
            while #targetData.Timestamps > 0 and (currentTime - targetData.Timestamps[1]) > Resolver.MaxHistoryDuration do
                table.remove(targetData.Positions, 1)
                table.remove(targetData.Velocities, 1)
                table.remove(targetData.Timestamps, 1)
                if #targetData.PredictionErrors > 0 then table.remove(targetData.PredictionErrors, 1) end
            end
            if targetData.LastActualPosition then
                local predictionError = (actualPosition - predictedPosition).Magnitude
                table.insert(targetData.PredictionErrors, predictionError)
                local movementDistance = (actualPosition - targetData.LastActualPosition).Magnitude
                if movementDistance > 0.1 then 
                    local avgError = 0
                    if #targetData.PredictionErrors > 0 then
                        local totalError = 0
                        for _, err in ipairs(targetData.PredictionErrors) do totalError = totalError + err end
                        avgError = totalError / #targetData.PredictionErrors
                    end
                    local errorRatio = math.min(avgError / Resolver.MaxPredictionError, 1.0)
                    local safeMin = math.min(Resolver.MinConfidence, 1.0)
                    Resolver.PredictionConfidence = math.clamp(1 - errorRatio, safeMin, 1.0)
                    
                    -- Keep table value synchronized with calculation
                    Aimbot.ConfidenceAmount = Resolver.PredictionConfidence 
                end
            end
            targetData.LastActualPosition = actualPosition
            if Resolver.DesyncDetection and #targetData.Velocities >= 3 then
                local velocityChanges = 0
                local lastVelocity = targetData.Velocities[1]
                for i = 2, #targetData.Velocities do
                    local currentVelocity = targetData.Velocities[i]
                    local change = (currentVelocity - lastVelocity).Magnitude
                    if change > Resolver.JitterThreshold then velocityChanges = velocityChanges + 1 end
                    lastVelocity = currentVelocity
                end
                if velocityChanges / (#targetData.Velocities - 1) > 0.5 then
                    Resolver.PredictionConfidence = math.min(Resolver.PredictionConfidence, 0.3)
                    
                    -- Keep table value synchronized with calculation
                    Aimbot.ConfidenceAmount = Resolver.PredictionConfidence 
                end
            end
        end

        local function GetPredictedPosition(hitbox, distanceToTarget)
            local basePosition = hitbox.Position
            if Aimbot.Prediction then
                local velocity = hitbox.Velocity or Vector3.new(0,0,0)
                local latency = (getPING and getPING() or 100) / 1000 -- Fallback safety
                local timeOfFlight = distanceToTarget / 1000
                local predictionOffset = velocity * Aimbot.Prediction_Offset * (timeOfFlight + latency)
                basePosition = basePosition + predictionOffset
            end
            if Aimbot.Resolver then
                local targetPlayer = hitbox:FindFirstAncestorOfClass("Player")
                local targetData = targetPlayer and Resolver.TargetHistory[targetPlayer]
                if targetData and #targetData.Velocities > 1 then
                    local avgVelocity = Vector3.new(0,0,0)
                    local totalWeight = 0
                    for i = 1, #targetData.Velocities do
                        local age = (Resolver.LastUpdateTime - targetData.Timestamps[i]) / Resolver.MaxHistoryDuration
                        local weight = math.exp(-4 * age) 
                        avgVelocity = avgVelocity + (targetData.Velocities[i] * weight)
                        totalWeight = totalWeight + weight
                    end
                    avgVelocity = avgVelocity / math.max(totalWeight, 0.001)
                    local blendFactor = Resolver.VelocitySmoothing * (1 - Resolver.PredictionConfidence)
                    local finalVelocity = (hitbox.Velocity or Vector3.new(0,0,0)) * (1 - blendFactor) + avgVelocity * blendFactor
                    local latency = (getPING and getPING() or 100) / 1000
                    local timeOfFlight = distanceToTarget / 1000
                    local predictionOffset = finalVelocity * Aimbot.Prediction_Offset * (timeOfFlight + latency)
                    basePosition = hitbox.Position + predictionOffset
                end
            end
            return basePosition
        end

        local function ShootGun()
            mouse1press() task.wait(Aimbot.AutoShoot_Delay) mouse1release()
        end

        local function GetScreenCenter_obj()
            local ScreenSize = Camera_obj.ViewportSize
            return Vector2.new(ScreenSize.X / 2, ScreenSize.Y / 2)
        end

        local function GetEffectiveFOVRadius()
            local radiusSetting = (Aimbot.FOVRadius and Aimbot.FOVRadius > 0) and Aimbot.FOVRadius or 100
            return radiusSetting * (math.max(Camera_obj.ViewportSize.X, Camera_obj.ViewportSize.Y) / 1000)
        end

        -- Setup standard loop operations
        if ConnectionRCS then ConnectionRCS:Disconnect() ConnectionRCS = nil end -- Purge external RCS connections

        if Aimbot.Enabled then
            if Connection then Connection:Disconnect() Connection = nil end
            Connection = RunService.RenderStepped:Connect(function(deltaTime)
                local ScreenCenter = GetScreenCenter_obj()
                local FOVRadius = GetEffectiveFOVRadius()

                -- 1. Validate Target Stickiness
                local isTargetValid, currentHitbox = checkTargetValidity(currentTarget, ScreenCenter, FOVRadius)

                if not isTargetValid then
                    currentTarget = nil
                    currentHitbox = nil

                    -- Scan for a new target closest to center of screen
                    local closestTarget, closestMag = nil, math.huge
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                            local valid, hitbox = checkTargetValidity(player, ScreenCenter, FOVRadius)
                            if valid and hitbox then
                                local screenPos = Camera_obj:WorldToScreenPoint(hitbox.Position)
                                local distCenter = (Vector2.new(screenPos.X, screenPos.Y) - ScreenCenter).Magnitude
                                if distCenter < closestMag then
                                    closestMag = distCenter
                                    closestTarget = player
                                    currentHitbox = hitbox
                                end
                            end
                        end
                    end

                    if closestTarget then
                        currentTarget = closestTarget
                    end
                end

                -- 2. Execute Aim and Recoil Actions Together
                if currentTarget and currentHitbox then
                    local distance = (currentHitbox.Position - Camera_obj.CFrame.Position).Magnitude
                    local targetPos = GetPredictedPosition(currentHitbox, distance)

                    UpdateResolverState(currentTarget, currentHitbox, targetPos, currentHitbox.Position)

                    local targetCFrame = CFrame.new(Camera_obj.CFrame.Position, targetPos)
                    local finalCFrame = targetCFrame

                    -- Apply Recoil directly to the final Look CFrame to maintain smooth aiming transitions
                    if RCS_Sets.Enabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                        if RCS_Sets.RecoilControl > 0 then
                            local recoilAmount = RCS_Sets.RecoilControl / RCS_Sets.RecoilDownAim
                            local recoilOffset = Vector3.new(
                                (math.random() - 0.5) * recoilAmount,
                                -recoilAmount,
                                (math.random() - 0.5) * recoilAmount
                            )
                            local right = targetCFrame.RightVector
                            local up = targetCFrame.UpVector
                            local look = (targetCFrame.LookVector + right * recoilOffset.X + up * recoilOffset.Y).Unit
                            finalCFrame = CFrame.new(Camera_obj.CFrame.Position, Camera_obj.CFrame.Position + look)
                        end
                    end

                    -- Adjust Camera smooth position using deltaTime
                    Camera_obj.CFrame = frameIndependentLerp(Camera_obj.CFrame, finalCFrame, Aimbot.Smoothing, deltaTime)

                    if Aimbot.AutoShoot then 
                        ShootGun() 
                    end
                elseif RCS_Sets.Enabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    -- Stand-alone RCS fallback if firing without an aim-locked target
                    if RCS_Sets.RecoilControl > 0 then
                        local recoilAmount = RCS_Sets.RecoilControl / RCS_Sets.RecoilDownAim
                        local recoilOffset = Vector3.new(
                            (math.random() - 0.5) * recoilAmount,
                            -recoilAmount,
                            (math.random() - 0.5) * recoilAmount
                        )
                        local look = (Camera_obj.CFrame.LookVector + Camera_obj.CFrame.RightVector * recoilOffset.X + Camera_obj.CFrame.UpVector * recoilOffset.Y).Unit
                        local finalCFrame = CFrame.new(Camera_obj.CFrame.Position, Camera_obj.CFrame.Position + look)
                        
                        Camera_obj.CFrame = Camera_obj.CFrame:Lerp(finalCFrame, math.clamp(RCS_Sets.Speed * deltaTime * 5, 0.01, 0.5))
                    end
                end
            end)
        else
            if Connection then Connection:Disconnect() Connection = nil end
        end
    end

    local function getFPS()
        local frameTime = Stats.Workspace.Heartbeat:GetValue()
        if frameTime > 0 then
            return math.floor(frameTime)
        else
            return 0
        end
    end

    local function getPING()
        local networkStats = Stats.Network
        local ping = networkStats.ServerStatsItem["Data Ping"]:GetValue()
        
        if ping > 0 then
            return math.floor(ping)
        else
            return 0
        end
    end

    local function setupFly()
        char = player.Character or player.CharacterAdded:Wait()
        rootPart = char:WaitForChild("HumanoidRootPart")
        Humanoid = char:WaitForChild("Humanoid")

        Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        Humanoid.PlatformStand = true

        flyForce = Instance.new("BodyVelocity")
        flyForce.Velocity = Vector3.new(0, 0, 0)
        flyForce.MaxForce = Vector3.new(40000, 40000, 40000)  
        flyForce.P = 1250  
        flyForce.Parent = rootPart

        flyConnection = RunService.Heartbeat:Connect(function()
            if not Action then
                flyConnection:Disconnect()
                return
            end

            local direction = Vector3.new(0, 0, 0)
            local moving = false
            local cameraCF = Camera.CFrame

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

            local cameraLook = cameraCF.LookVector
            rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + cameraLook)

            if moving then
                if direction.Magnitude > 0 then
                    direction = direction.Unit
                end
                flyForce.Velocity = direction * flySpeed
            else
                flyForce.Velocity = Vector3.new(0, 0, 0)
                rootPart.Velocity = Vector3.new(0, 0, 0)
                rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end
        end)
    end

    local function FlyActivate(Value)
        if Value then
            Action = true
            setupFly()
        else
            Action = false
            if char and Humanoid then
                Humanoid.PlatformStand = false
                Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            if flyForce then flyForce:Destroy() end
            if alignTorque then alignTorque:Destroy() end
        end
    end

    local function serverhop()
        if not httprequest then
            return getgenv().Library:Notify("Incompatible Feature.", 3) 
        end

        local servers = {}
        local req = httprequest({
            Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId)
        })

        if req.Success then
            local body = req.Body

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
                getgenv().Library:Notify("Couldn't find a server.", 3) 
            end
        else
            getgenv().Library:Notify("Failed to fetch server list.", 3) 
        end
    end

    local function rejoin()
        local placeId = game.PlaceId 
        ts:Teleport(placeId, p)
    end

    local function AntiFallDmg(Value)
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

                wait(3) 
            end)
        else
            if fd then
                fd:Disconnect()
                fd = nil
            end
        end
    end

    local function HitDetection(Value)
        local lp = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() and Players.LocalPlayer
        local Camera_obj = workspace.CurrentCamera

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

        local connections = {}

        local function DisconnectPlayer(player_obj)
            if connections[player_obj] then
                for _, connection in pairs(connections[player_obj]) do
                    connection:Disconnect()
                end
                connections[player_obj] = nil
            end
        end

        local function OnHealthChanged(player_obj, Humanoid_obj, oldHealth)
            local creator = Humanoid_obj:FindFirstChild("creator")
            if creator and creator.Value == lp then
                local character = player_obj.Character
                local hitboxName = nil 
                if character then
                    local potentialHitboxes = {}
        
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            table.insert(potentialHitboxes, part)
                        end
                    end
        
                    local Origin = Camera_obj.CFrame.Position
                    local RaycastParams_v = RaycastParams.new()
                    RaycastParams_v.FilterDescendantsInstances = {lp.Character, Camera_obj} 
                    RaycastParams_v.FilterType = Enum.RaycastFilterType.Blacklist
        
                    for _, hitbox in ipairs(potentialHitboxes) do
                        local Direction = (hitbox.Position - Origin).Unit * 1000 
                        local RaycastResult = workspace:Raycast(Origin, Direction, RaycastParams_v)
        
                        if RaycastResult then
                            local HitPart = RaycastResult.Instance
                            local HitCharacter = HitPart:FindFirstAncestorOfClass("Model")
                            if HitCharacter == character then
                                hitboxName = hitbox.Name 
                                break
                            end
                        end
                    end
                end
        
                local remainingHealth = Humanoid_obj.Health
                local damageDealt = oldHealth - remainingHealth
        
                if hitboxName then
                    if remainingHealth == 0 then
                        PlayKillSound()
                        Notificate(string.format("Tapped %s on %s | %.1f HP (-%.1f DMG) (DECEASED)", player_obj.Name, hitboxName, remainingHealth, damageDealt))
                    elseif remainingHealth < 0 then
                        PlayKillSound()
                        Notificate(string.format("Tapped %s on %s | %.1f HP (-%.1f DMG) (OBLITERATED)", player_obj.Name, hitboxName, remainingHealth, damageDealt))
                        AddOVRKill()
                    else
                        PlayHitmarkerSound()
                        Notificate(string.format("Tapped %s on %s | %.1f HP (-%.1f DMG) (INJURED)", player_obj.Name, hitboxName, remainingHealth, damageDealt))
                    end
                end
            end
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

        local function ConnectPlayer(player_obj)
            DisconnectPlayer(player_obj)

            connections[player_obj] = {}

            local function OnCharacterAdded(character)
                local Humanoid_obj = character:WaitForChild("Humanoid")
                local oldHealth = Humanoid_obj.Health

                local healthChangedConnection = Humanoid_obj.HealthChanged:Connect(function(newHealth)
                    if newHealth < oldHealth then
                        OnHealthChanged(player_obj, Humanoid_obj, oldHealth)
                    end
                    oldHealth = newHealth
                end)

                table.insert(connections[player_obj], healthChangedConnection)
            end

            if player_obj.Character then
                OnCharacterAdded(player_obj.Character)
            end

            local characterAddedConnection = player_obj.CharacterAdded:Connect(OnCharacterAdded)
            table.insert(connections[player_obj], characterAddedConnection)
        end

        local function OnPlayerRemoving(player_obj)
            DisconnectPlayer(player_obj)
        end

        if Value then
            for _, player_obj in ipairs(Players:GetPlayers()) do
                if player_obj ~= lp then
                    ConnectPlayer(player_obj)
                end
            end

            Players.PlayerAdded:Connect(function(player_obj)
                if player_obj ~= lp then
                    ConnectPlayer(player_obj)
                end
            end)

            Players.PlayerRemoving:Connect(OnPlayerRemoving)
            RunService.Heartbeat:Connect(Update)
        else
            for player_obj in pairs(connections) do
                DisconnectPlayer(player_obj)
            end
        end
    end

    local function TriggerBot(Value)
        local lp = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() and Players.LocalPlayer
        local mouse_obj = lp:GetMouse()
        local Camera_obj = workspace.CurrentCamera

        local Prediction_Enabled = Aimbot.Prediction 
        local Prediction_Offset = Aimbot.Prediction_Offset 

        if con then
            con:Disconnect()
            con = nil
        end

        if Value == true then
            con = RunService.Heartbeat:Connect(function()
                for _, player_obj in ipairs(Players:GetPlayers()) do
                    if player_obj ~= lp and player_obj.Character then
                        if Aimbot.TeamCheck then
                            local LocalPlayerTeam = lp.Team
                            local TargetTeam = player_obj.Team

                            if LocalPlayerTeam and TargetTeam and LocalPlayerTeam == TargetTeam then
                                continue 
                            end
                        end

                        local Character = player_obj.Character

                        local hitboxNames = {
                            "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg",
                            "UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm",
                            "LeftLowerArm", "RightLowerArm", "LeftUpperLeg", "RightUpperLeg",
                            "LeftLowerLeg", "RightLowerLeg"
                        }

                        for _, hitboxName in ipairs(hitboxNames) do
                            local r6ToR15Mapping = {
                                ["Torso"] = "UpperTorso", "LowerTorso",
                                ["Left Arm"] = "LeftUpperArm","LeftLowerArm",
                                ["Right Arm"] = "RightUpperArm","RightLowerArm",
                                ["Left Leg"] = "LeftUpperLeg","LeftLowerLeg",
                                ["Right Leg"] = "RightUpperLeg","RightLowerLeg",
                            }
                            local mappedHitboxName = r6ToR15Mapping[hitboxName] or hitboxName

                            local Hitbox = Character:FindFirstChild(mappedHitboxName)
                            if not Hitbox then
                                Hitbox = Character:FindFirstChild("HumanoidRootPart")
                            end

                            if Hitbox then
                                local TargetPosition = Hitbox.Position
                                if Prediction_Enabled then
                                    local Velocity = Hitbox.Velocity
                                    TargetPosition = TargetPosition + Velocity * Prediction_Offset
                                end

                                if Aimbot.CheckVisibility then
                                    local Origin = Camera_obj.CFrame.Position
                                    local Direction = (TargetPosition - Origin).Unit * (TargetPosition - Origin).Magnitude
                                    local RaycastParams_v = RaycastParams.new()
                                    RaycastParams_v.FilterDescendantsInstances = {lp.Character, Camera_obj} 
                                    RaycastParams_v.FilterType = Enum.RaycastFilterType.Blacklist

                                    local RaycastResult = workspace:Raycast(Origin, Direction, RaycastParams_v)
                                    if RaycastResult then
                                        local HitPart = RaycastResult.Instance
                                        local HitCharacter = HitPart:FindFirstAncestorOfClass("Model")
                                        if HitCharacter ~= Character then
                                            continue
                                        end
                                    end
                                end

                                local ScreenPosition, OnScreen = Camera_obj:WorldToScreenPoint(TargetPosition)
                                if OnScreen then
                                    local MousePosition = Vector2.new(mouse_obj.X, mouse_obj.Y)
                                    local DistanceToMouse = (MousePosition - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
                                    if DistanceToMouse < Aimbot.Triggerbot_Sensitivity then 
                                        local Humanoid_obj = Character:FindFirstChildOfClass("Humanoid")
                                        if Aimbot.CheckAlive and (not Humanoid_obj or Humanoid_obj.Health <= 0) then continue end

                                        mouse1press() task.wait(0.1) mouse1release()

                                        return 
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            if con then
                con:Disconnect()
                con = nil
            end
        end
    end

    local function disableCanCollide(i)
        if i then
            if antifling then
                antifling:Disconnect()
                antifling = nil
            end
            antifling = RunService.Stepped:Connect(function()
                for _, player_obj in ipairs(Players:GetPlayers()) do
                    if player_obj ~= speaker and player_obj.Character then
                        for _, part in ipairs(player_obj.Character:GetDescendants()) do
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

    local function InitiateLagDetection()
        local Players_obj = game:GetService("Players")
        local RunService_obj = game:GetService("RunService")
        local Stats_obj = game:GetService("Stats")
        
        local pingUpdateInterval = 1 
        local lastPingCheck = 0
        local maxPing = 200 
        local minFPS = 60 
        
        local lagSpikeThreshold = 3 
        local currentLagCount = 0
        
        local function formatPing(ping)
            return math.floor(ping) .. "ms"
        end
        
        local function formatFPS(fps)
            return math.floor(fps) .. " FPS"
        end
        
        local function checkForLagSpike()
            local currentTime = os.clock()
            local networkStats = Stats_obj.Network
            local ping = networkStats.ServerStatsItem["Data Ping"]:GetValue()
            local fps = 1 / RunService_obj.RenderStepped:Wait()
            
            if currentTime - lastPingCheck >= pingUpdateInterval then
                ping = networkStats.ServerStatsItem["Data Ping"]:GetValue()
                lastPingCheck = currentTime
            end
            
            local isLagging = false
            
            if ping > maxPing then
                isLagging = true
            end
            
            if fps < minFPS then
                Warning_Notificate("Low FPS detected: " .. formatFPS(fps))
                isLagging = true
            end
            
            if isLagging then
                currentLagCount = currentLagCount + 1
                if currentLagCount >= lagSpikeThreshold then
                    Warning_Notificate("LAG SPIKE DETECTED! " .. formatPing(ping))
                end
            else
                currentLagCount = math.max(0, currentLagCount - 1)
            end
            
            return ping, fps
        end
        
        local function monitorPerformance()
            while true do
                checkForLagSpike()
                wait(0.5) 
            end
        end
        
        coroutine.wrap(monitorPerformance)()
    end

    local function FlingtargetPlayerName(targetPlayerName)
        local Targets = {targetPlayerName} 
        local Player_obj = Players.LocalPlayer
        local AllBool = false
        
        local GetPlayer = function(Name)
            Name = Name:lower()
            if Name == "all" or Name == "others" then
                AllBool = true
                return
            elseif Name == "random" then
                local GetPlayers = Players:GetPlayers()
                if table.find(GetPlayers,Player_obj) then table.remove(GetPlayers,table.find(GetPlayers,Player_obj)) end
                return GetPlayers[math.random(#GetPlayers)]
            elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
                for _,x in next, Players:GetPlayers() do
                    if x ~= Player_obj then
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
            local Character = Player_obj.Character
            local RootPart_obj = Humanoid and Humanoid.RootPart
        
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
            if Accessory and Accessory:FindFirstChild("Handle") then
                Handle = Accessory.Handle
            end
        
            if Character and Humanoid and RootPart_obj then
                if RootPart_obj.Velocity.Magnitude < 50 then
                    getgenv().OldPos = RootPart_obj.CFrame
                end
                if THumanoid and THumanoid.Sit and not AllBool then
                    return getgenv().Library:Notify(targetPlayerName .. " is sitting.", 5) 
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
                    RootPart_obj.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                    Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                    RootPart_obj.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                    RootPart_obj.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                end
                
                local SFBasePart = function(BasePart)
                    local TimeToWait = 2
                    local Time = tick()
                    local Angle = 0
        
                    repeat
                        if RootPart_obj and THumanoid then
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
                BV.Parent = RootPart_obj
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
                    return getgenv().Library:Notify(targetPlayerName .. " is literally disabled from everywhere lol.", 5) 
                end
                
                BV:Destroy()
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                workspace.CurrentCamera.CameraSubject = Humanoid
                
                repeat
                    RootPart_obj.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                    Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                    Humanoid:ChangeState("GettingUp")
                    table.foreach(Character:GetChildren(), function(_, x)
                        if x:IsA("BasePart") then
                            x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                        end
                    end)
                    task.wait()
                until (RootPart_obj.Position - getgenv().OldPos.p).Magnitude < 25
                workspace.FallenPartsDestroyHeight = getgenv().FPDH
            else
                return getgenv().Library:Notify("My fault bruh.", 5) 
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
            if GetPlayer(x) and GetPlayer(x) ~= Player_obj then
                if GetPlayer(x).UserId ~= 1414978355 then
                    local TPlayer = GetPlayer(x)
                    if TPlayer then
                        SkidFling(TPlayer)
                    end
                else
                    getgenv().Library:Notify(targetPlayerName .. " is chill bruh.", 5) 
                end
            elseif not GetPlayer(x) and not AllBool then
                getgenv().Library:Notify(targetPlayerName .. " does not have a valid username.", 5) 
            end
        end
    end

    local function Reset_two()
        player.Character.Humanoid.Health = -5
        getgenv().Library:Notify("Wtf!", 2) 
    end

    local function Reset()
        PreviousPosition = player.Character.HumanoidRootPart.CFrame
        player.Character.Humanoid.Health = 0
        if player.Character:FindFirstChild("Head") then player.Character.Head:Destroy() end
        player.CharacterAdded:Wait()
        player.Character:WaitForChild("HumanoidRootPart")
        player.Character.HumanoidRootPart.CFrame = PreviousPosition
        Success_Notificate("Resetted")
    end

    local function FlingerAll()
        FlingtargetPlayerName("All")
        Success_Notificate("Successfully flung people!")
        Reset()
    end

    function OnUpdate()
        LockOnGTA5()
        UpdateFOV()
        CrosshairGen()
        AntiAimFunction()
        UpdateVisuals()
        ChatSpammer()
    end

    local function Teleport(targetPlayerName)
        local player_obj = game.Players.LocalPlayer
        local character = player_obj.Character or player_obj.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")  
        local targetPlayer = game.Players:FindFirstChild(targetPlayerName)

        if targetPlayer then
            local targetCharacter = targetPlayer.Character or targetPlayer.CharacterAdded:Wait()
            local targetHrp = targetCharacter:WaitForChild("HumanoidRootPart")  
            hrp.CFrame = targetHrp.CFrame
        else
            getgenv().Library:Notify("Player not found.", 2)
        end
    end

    local function GetHitboxPart(character, hitboxName)
        if not hitboxName or type(hitboxName) ~= "string" then
            return nil
        end

        local r6ToR15Mapping = {
            ["Torso"] = "UpperTorso",
            ["Left Arm"] = "LeftUpperArm",
            ["Right Arm"] = "RightUpperArm",
            ["Left Leg"] = "LeftUpperLeg",
            ["Right Leg"] = "RightUpperLeg",
        }

        local mappedHitboxName = r6ToR15Mapping[hitboxName] or hitboxName
        local hitboxPart = character:FindFirstChild(mappedHitboxName)
        if not hitboxPart then
            hitboxPart = character:FindFirstChild("HumanoidRootPart")
        end

        return hitboxPart
    end

    local function EndStuff()
        local TogglesOFF = false

        if CrosshairLines then
            for _, line in ipairs(CrosshairLines) do
                pcall(function() line:Destroy() end)
            end
            CrosshairLines = {}
        end

        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://3101925827" 
        sound.Volume = 1 
        sound.Pitch = 0.5
        sound.Looped = false 
        sound.Parent = workspace 

        getgenv().Library.Unloaded = true
        Sense.Unload()

        pcall(function()
            if getgenv().ArrowSettings and getgenv().ArrowSettings.Unload then
                getgenv().ArrowSettings.Unload()
            end
        end)

        pcall(function()
            if getgenv().SkeletonSettings and getgenv().SkeletonSettings.Unload then
                getgenv().SkeletonSettings.Unload()
            end
        end)

        workspace.Camera.FieldOfView = 70

        if TogglesOFF == false then
            Aimbot.Enabled = false
            TriggerBot(false)
            Crosshair.Enabled = false
            Aimbot.FOVVisible = false
            HitDetection(false)
            AntiAim.Activated = false
            FlyActivate(false)
            ChatSpammerrr.Activated = false
            Anticheat(false)
            Orbiter(false)
            Anticheat_Settings.REPORT = false
            disableCanCollide(false)
            TogglesOFF = true

            if TogglesOFF == true then
                print("⏺️ All Runtime Toggles are now Unloaded")
            end
        end

        for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
            if v.Name == "screen" or v.Name == "watermark" or v.Name == "Notifications" then
                v:Destroy()
            end
        end

        Reset_two()
        print('✅ Unloaded!')
        sound:Play()
        sound.Ended:Connect(function() sound:Destroy() end)
    end

    local function Launch()
        InitializeDrawing() 

        local function containsBlacklistedWord(message)
            local lowerMessage = string.lower(message)
            for _, word in ipairs(blacklisted) do
                if string.find(lowerMessage, string.lower(word)) then
                    return true
                end
            end
            return false
        end
        
        local function onPlayerAdded_v(player_v)
            player_v.Chatted:Connect(function(message)
                local shouldSend = logChat(player_v, message)
                if not shouldSend then
                    return false
                end
            end)
        end
        
        getgenv().Library:Notify((art or "PLVSMVWVRE").."\n[NOTE] PLVSMVWVRE.lol - Official Finished Release since 2023", 6)

        Console() Success_Notificate("Console Hooked.")

        Notificate(COLORS.WHITE, "Initializing Updaters...")

        EventConnections.OnUpdate = RunService.Heartbeat:Connect(OnUpdate) Success_Notificate("Initialized OnUpdate!")

        Anti_ESEXr() Success_Notificate("Initialized Anti_ESEXr!")
        ACBypassers() Success_Notificate("Initialized ACBypassers!")
        Cache_Old_Walkspeed_and_JumpPower() Success_Notificate("Initialized Cache!")
        InitiateLagDetection() Success_Notificate("Initialized LagDetection!")
        Sense.Load() Success_Notificate("Initialized Sense!")
        getgenv().ArrowESP = loadstring(game:HttpGet('https://raw.githubusercontent.com/hollyntt/PLWVRE-Roblox-Script/refs/heads/main/PLVSMVWVRE-RBLX/src/UI/Arrow.lua'))() Success_Notificate("Initialized ArrowESP!")
        getgenv().SkeletonESP = loadstring(game:HttpGet('https://raw.githubusercontent.com/hollyntt/PLWVRE-Roblox-Script/refs/heads/main/PLVSMVWVRE-RBLX/src/UI/Skeleton.lua'))() Success_Notificate("Initialized SkeletonESP!")
        Notificate(COLORS.WHITE, "Setting up Hooks...")

        player.CharacterAdded:Connect(function() if Action then setupFly() end end) Success_Notificate("Hooked Fly Setup!")
        game.Players.PlayerAdded:Connect(onPlayerJoined) Success_Notificate("Hooked onPlayerJoined!")
        game.Players.PlayerRemoving:Connect(onPlayerLeft) Success_Notificate("Hooked onPlayerLeft!")
        Nametags() Success_Notificate("Hooked Nametags!")
        
        print('✅ Initiated!')
        Success_Notificate("Initiated!")
    end

    local cheatname = BetaBuild and "PLVSMVWVRE.lol [BETA]" or "PLVSMVWVRE.lol"

-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |                                             MENU                                                |
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
local function PLVSMVWVRE_Menu()
    local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/hollyntt/PLWVRE-Roblox-Script/refs/heads/main/PLVSMVWVRE-RBLX/src/UI/XSX.lua"))()
    library.title = cheatname
    
    Notif = library:InitNotifications()
    local Wm = library:Watermark(cheatname.. " | v" .. library.version ..  " | " .. library:GetUsername() .. " | rank: " .. library.rank)
    local FpsWm = Wm:AddWatermark("fps: " .. library.fps)
    coroutine.wrap(function()
        while wait(.75) do
            FpsWm:Text("fps: " .. library.fps)
        end
    end)()


    -- Initialize Sense ESP Colors to match default expectations
    Sense.teamSettings.enemy.boxColor = { Color3.fromRGB(255, 0, 0), 1 }
    Sense.teamSettings.enemy.tracerColor = { Color3.fromRGB(255, 0, 0), 1 }
    Sense.teamSettings.enemy.chamsOutlineColor = { Color3.fromRGB(255, 0, 0), 0 }
    
    Sense.teamSettings.friendly.boxColor = { Color3.fromRGB(0, 255, 0), 1 }
    Sense.teamSettings.friendly.tracerColor = { Color3.fromRGB(0, 255, 0), 1 }
    Sense.teamSettings.friendly.chamsOutlineColor = { Color3.fromRGB(0, 255, 0), 0 }

    library:Introduction()

    task.wait(1)
    local Init = library:Init(Enum.KeyCode.Home)
    
    local TabMain = Init:NewTab('Rage')
    local TabVisuals = Init:NewTab('Visuals')
    local TabMovement = Init:NewTab('Movement')
    local TabLocalPlayer = Init:NewTab('LocalPlayer')
    local TabOthers = Init:NewTab('Others')
    local TabUISettings = Init:NewTab('Config')
    
    -- // RAGE TAB
    local SectionMain = TabMain:NewSection('Main')
    local UI_Aimbot_Lock = TabMain:NewToggle('Aim-lock', false, function(Value) Aimbot.Enabled = Value; end)
    UI_Aimbot_Lock:AddKeybind(Enum.KeyCode.Minus)
    local UI_Aimbot_Vis = TabMain:NewToggle('Visibility Check', false, function(Value) Aimbot.CheckVisibility = Value; end)
    local UI_Aimbot_Alive = TabMain:NewToggle('Alive Check', false, function(Value) Aimbot.CheckAlive = Value; end)
    local UI_Aimbot_Team = TabMain:NewToggle('Team Check', false, function(Value) Aimbot.TeamCheck = Value; end)
    local UI_Aimbot_FOV = TabMain:NewToggle('FOV Check', false, function(Value) Aimbot.FOVCheck = Value; end)
    local UI_Aimbot_Respawn = TabMain:NewToggle('Respawning Check', false, function(Value) Aimbot.CheckForcefield = Value; end)
    local UI_Aimbot_Pred = TabMain:NewToggle('Prediction', false, function(Value) Aimbot.Prediction = Value; end)
    local UI_Aimbot_AutoShoot = TabMain:NewToggle('AutoShoot', false, function(Value) Aimbot.AutoShoot = Value; end)
    local UI_Aimbot_Resolver = TabMain:NewToggle('Resolver', false, function(Value) Aimbot.Resolver = Value; end)
    
    local SectionRCS = TabMain:NewSection('Recoil Control')
    local UI_RCS_Toggle = TabMain:NewToggle('Recoil Control System', false, function(Value) RCS_Sets.Enabled = Value; end)
    local UI_RCS_Control = TabMain:NewSlider('RCS', '', false, '', {min = 0, max = 100, default = 0}, function(Value) RCS_Sets.RecoilControl = Value end)
    local UI_RCS_DownAim = TabMain:NewSlider('RCS (-X)', '', false, '', {min = 5, max = 1000, default = 1000}, function(Value) RCS_Sets.RecoilDownAim = Value end)
    local UI_RCS_Speed = TabMain:NewSlider('RCS (Speed)', '', false, '', {min = 1, max = 5, default = 5}, function(Value) RCS_Sets.Speed = Value end)
    
    local SectionSettings = TabMain:NewSection('Aimbot Settings')
    local UI_Aim_ASDelay = TabMain:NewSlider('AutoShoot Delay', '', false, '', {min = 0, max = 1000, default = 0}, function(Value) Aimbot.AutoShoot_Delay = Value / 10 end)
    local UI_Aim_Smooth = TabMain:NewSlider('Smoothness', '', false, '', {min = 0, max = 30, default = 0}, function(Value) Aimbot.Smoothing = Value / 100 end)
    local UI_Aim_Dist = TabMain:NewSlider('Distance', '', false, '', {min = 0, max = 1000, default = 0}, function(Value) Aimbot.Distance = Value end)
    local UI_Aim_Offset = TabMain:NewSlider('Offset', '', false, '', {min = 0, max = 20, default = 0}, function(Value) Aimbot.Prediction_Offset = Value end)
    
    local SectionResolver = TabMain:NewSection('Resolver Settings')
    local UI_Res_Hist = TabMain:NewSlider('Resolver History', '', false, '', {min = 0, max = 200, default = 5}, function(Value) Aimbot.ResolverHistory = Value / 10 end)
    local UI_Res_PredErr = TabMain:NewSlider('Prediction Error', '', false, '', {min = 0, max = 1000, default = 2}, function(Value) Aimbot.MaxPredictionError = Value end)
    local UI_Res_Smooth = TabMain:NewSlider('Resolver Smoothing', '', false, '', {min = 0, max = 100, default = 0}, function(Value) Aimbot.VelocitySmoothing = Value / 100 end)
    local UI_Res_Jitter = TabMain:NewSlider('Jitter Threshold', '', false, '', {min = 0, max = 1000, default = 15}, function(Value) Aimbot.JitterThreshold = Value / 100 end)
    local UI_Chance_Conf = TabMain:NewSlider('Confidence', '', false, '', {min = 0, max = 100, default = 80}, function(Value) Aimbot.ConfidenceAmount = Value / 100 end)
    local UI_Res_Conf = TabMain:NewSlider('Min Confidence', '', false, '', {min = 0, max = 100, default = 0}, function(Value) Aimbot.MinPredictionConfidence = Value / 100 end)
    
    TabMain:NewSection('Misc')
    local UI_Aim_Hitbox = TabMain:NewMultiSelector(
    'Universal Hitbox', 
    { 'Head' }, -- Default selection (needs to be a table)
    { 
        'Head', 'Torso', 'Left Arm', 'Right Arm', 'Left Leg', 'Right Leg', 
        'UpperTorso', 'LowerTorso', 'LeftUpperArm', 'RightUpperArm', 
        'LeftLowerArm', 'RightLowerArm', 'LeftUpperLeg', 'RightUpperLeg', 
        'LeftLowerLeg', 'RightLowerLeg', 'HumanoidRootPart' 
    }, 
    function(Values)
        -- Clear current table selection
        table.clear(Aimbot.Hitboxes)
        
        -- Store the newly checked values
        for _, value in ipairs(Values) do
            Aimbot.Hitboxes[value] = true
        end
        
        -- Safety fallback: ensure at least one hitbox is targeted
        if #Values == 0 then
            Aimbot.Hitboxes["Head"] = true
        end
    end
)
    local UI_Aim_FOVVis = TabMain:NewToggle('FOV', false, function(Value) Aimbot.FOVVisible = Value; end)
    local UI_Aim_FOVRad = TabMain:NewSlider('Radius', '', false, '', {min = 40, max = 1234, default = 100}, function(Value) Aimbot.FOVRadius = Value end)
    local UI_Aim_FOVSides = TabMain:NewSlider('Sides', '', false, '', {min = 4, max = 100, default = 12}, function(Value) Aimbot.FOVSides = Value end)
    local UI_Aim_FOVThick = TabMain:NewSlider('Thickness', '', false, '', {min = 1, max = 10, default = 2}, function(Value) Aimbot.FOVThickness = Value end)
    local UI_Aim_FOVTrans = TabMain:NewSlider('FOV Opacity', '', false, '', {min = 0, max = 100, default = 100}, function(Value) Aimbot.FOVTransparency = Value / 100 end)
    local UI_Aim_FOVC = TabMain:NewColorpicker('FOV Color', Color3.new(255, 255, 255), function(Value) Aimbot.FOVColor = Value end)
    
    local TriggerBotState = false
    local UI_Aim_TBot = TabMain:NewToggle('Triggerbot', false, function(Value) TriggerBotState = Value; TriggerBot(Value) end)
    UI_Aim_TBot:AddKeybind(Enum.KeyCode.Minus)
    local UI_Aim_TSens = TabMain:NewSlider('Sensitivity', '', false, '', {min = 1, max = 100, default = 10}, function(Value) Aimbot.Triggerbot_Sensitivity = Value / 100 end)

    -- // VISUALS TAB
    TabVisuals:NewSection('ESP Configuration')
    
    local currentESPTeam = "Enemy"
    local isESPSyncing = false
    local espControls = {}

    TabVisuals:NewSelector('Edit Team Settings', 'Enemy', { 'Enemy', 'Friendly' }, function(Value)
        currentESPTeam = Value
        if not espControls.Enabled then return end
        isESPSyncing = true
        
        local settings = Sense.teamSettings[string.lower(Value)]
        espControls.Enabled:Set(settings.enabled)
        espControls.Box:Set(settings.box)
        espControls.Name:Set(settings.name)
        espControls.Tracer:Set(settings.tracer)
        espControls.HealthBar:Set(settings.healthBar)
        espControls.Distance:Set(settings.distance)
        espControls.Chams:Set(settings.chams)
        local color = settings.boxColor and settings.boxColor[1] or (Value == "Enemy" and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0))
        espControls.Color:Set(color)
        
        isESPSyncing = false
    end)

    espControls.Enabled = TabVisuals:NewToggle('ESP Enabled', false, function(Value)
        if not isESPSyncing then Sense.teamSettings[string.lower(currentESPTeam)].enabled = Value end
    end)
    espControls.Box = TabVisuals:NewToggle('Show Box', false, function(Value)
        if not isESPSyncing then Sense.teamSettings[string.lower(currentESPTeam)].box = Value end
    end)
    espControls.Name = TabVisuals:NewToggle('Show Name', false, function(Value)
        if not isESPSyncing then Sense.teamSettings[string.lower(currentESPTeam)].name = Value end
    end)
    espControls.Tracer = TabVisuals:NewToggle('Show Tracer', false, function(Value)
        if not isESPSyncing then Sense.teamSettings[string.lower(currentESPTeam)].tracer = Value end
    end)
    espControls.HealthBar = TabVisuals:NewToggle('Show Health Bar', false, function(Value)
        if not isESPSyncing then Sense.teamSettings[string.lower(currentESPTeam)].healthBar = Value end
    end)
    espControls.Distance = TabVisuals:NewToggle('Show Distance', false, function(Value)
        if not isESPSyncing then Sense.teamSettings[string.lower(currentESPTeam)].distance = Value end
    end)
    espControls.Chams = TabVisuals:NewToggle('Show Chams', false, function(Value)
        if not isESPSyncing then Sense.teamSettings[string.lower(currentESPTeam)].chams = Value end
    end)
    espControls.Color = TabVisuals:NewColorpicker('ESP Color', Color3.fromRGB(255, 0, 0), function(Value)
        if not isESPSyncing then
            local teamStr = string.lower(currentESPTeam)
            Sense.teamSettings[teamStr].boxColor = { Value, 1 }
            Sense.teamSettings[teamStr].tracerColor = { Value, 1 }
            Sense.teamSettings[teamStr].chamsOutlineColor = { Value, 0 }
        end
    end)

    TabVisuals:NewSection('ESP Global Settings')
    local UI_ESP_Origin = TabVisuals:NewSelector('Tracer Origin', 'Bottom', { 'Top', 'Middle', 'Bottom'}, function(Value)
        Sense.teamSettings.enemy.tracerOrigin = Value
        Sense.teamSettings.friendly.tracerOrigin = Value
    end)
    local UI_ESP_TextS = TabVisuals:NewSlider('Text Size', '', false, '', {min = 10, max = 24, default = 13}, function(Value) Sense.sharedSettings.textSize = Value end)
    local UI_ESP_MaxD = TabVisuals:NewSlider('Max Distance', '', false, '', {min = 50, max = 2000, default = 150}, function(Value) Sense.sharedSettings.maxDistance = Value end)

    -- Dedicated Arrow ESP configuration block
    TabVisuals:NewSection('Arrow ESP')
    
    TabVisuals:NewToggle('Arrow ESP Enabled', true, function(Value)
        if getgenv().ArrowSettings then
            getgenv().ArrowSettings.Enabled = Value
        end
    end)

    TabVisuals:NewSlider('Distance from Center', '', false, '', {min = 40, max = 250, default = 80}, function(Value)
        if getgenv().ArrowSettings then
            getgenv().ArrowSettings.DistFromCenter = Value
        end
    end)

    TabVisuals:NewSlider('Arrow Height', '', false, '', {min = 10, max = 50, default = 16}, function(Value)
        if getgenv().ArrowSettings then
            getgenv().ArrowSettings.TriangleHeight = Value
        end
    end)

    TabVisuals:NewSlider('Arrow Width', '', false, '', {min = 10, max = 50, default = 16}, function(Value)
        if getgenv().ArrowSettings then
            getgenv().ArrowSettings.TriangleWidth = Value
        end
    end)

    TabVisuals:NewToggle('Fill Arrows', true, function(Value)
        if getgenv().ArrowSettings then
            getgenv().ArrowSettings.TriangleFilled = Value
        end
    end)

    TabVisuals:NewColorpicker('Enemy Arrow Color', Color3.fromRGB(255, 0, 0), function(Value)
        if getgenv().ArrowSettings then
            getgenv().ArrowSettings.EnemyColor = Value
        end
    end)
    TabVisuals:NewSection('Arrow ESP')

    -- // MOVEMENT TAB
    local FlyState = false
    TabMovement:NewSection('Main')
    local UI_Move_Fly = TabMovement:NewToggle('Fly', false, function(Value) FlyState = Value; FlyActivate(Value) end)
    UI_Move_Fly:AddKeybind(Enum.KeyCode.Minus)
    local UI_Move_WS = TabMovement:NewSlider('Walkspeed', '', false, '', {min = 15, max = 120, default = playerWalkspeedCache}, function(Value) player.Character.Humanoid.WalkSpeed = Value end)
    local UI_Move_JP = TabMovement:NewSlider('JumpPower', '', false, '', {min = 50, max = 9999, default = playerJumpPowerCache}, function(Value) player.Character.Humanoid.JumpPower = Value end)
    local UI_Move_FS = TabMovement:NewSlider('FlySpeed', '', false, '', {min = 5, max = 1000, default = 50}, function(Value) flySpeed = Value end)
    TabMovement:NewButton('Reset Speeds', function()
        player.Character.Humanoid.WalkSpeed = playerWalkspeedCache
        player.Character.Humanoid.JumpPower = playerJumpPowerCache
    end)

    -- // LOCALPLAYER TAB
    local SitState = false
    local OrbitState = false
    TabLocalPlayer:NewSection('Main')
    TabLocalPlayer:NewButton('Reset', function() Reset() end)
    local UI_LP_QuickReset = TabLocalPlayer:NewKeybind('Quick Reset', Enum.KeyCode.Minus, function(Active)
        if Active then
            Reset()
        end
    end)
    TabLocalPlayer:NewButton('Create Godmode UI', function() loadstring(game:HttpGet("https://raw.githubusercontent.com/zephyr10101/ignore-touchinterests/main/main", true))() end)
    TabLocalPlayer:NewButton('Give Click Teleport', function()
        player1 = player
        q = Instance.new('HopperBin', player1.Backpack)
        q.Name = 'Click Teleport'
        bin = q
        function teleportPlayer(pos)
            if player == nil or player.Character == nil then return end
            player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(pos.x, pos.y + 7, pos.z))
        end
        enabled = true
        function onButton1Down(mouse_obj)
            if not enabled then return end
            if player == nil then return end
            enabled = false
            local cf = mouse_obj.Hit
            teleportPlayer(cf.p)
            task.wait()
            enabled = true
        end
        function onSelected(mouse_obj)
            mouse_obj.Icon = "rbxasset://textures\\ArrowCursor.png"
            mouse_obj.Button1Down:connect(function() onButton1Down(mouse_obj) end)
        end
        bin.Selected:connect(onSelected)
    end)
    TabLocalPlayer:NewButton('Trip n fall', function()
        player.Character:WaitForChild("Humanoid").PlatformStand = true
        wait(0.85)
        Reset_two()
    end)
    
    TabLocalPlayer:NewTextbox('Teleport to:', '', 'Player Name', 'all', 'small', true, false, function(Value) Teleport(Value) end)
    local UI_LP_Sit = TabLocalPlayer:NewToggle('Sit', false, function(Value) SitState = Value; player.Character:WaitForChild("Humanoid").Sit = Value end)

    TabLocalPlayer:NewSection('Orbit')
    local UI_LP_Orbit = TabLocalPlayer:NewToggle('On', false, function(Value) OrbitState = Value; Orbiter(Value) end)
    local UI_LP_OrbitTar = TabLocalPlayer:NewTextbox('Target Orbit', '', 'Player Name', 'all', 'small', true, false, function(Value) Orbiter_Settings.Target = Value; NAMETAG_CONFIG.NAME = Value; NAMETAG_CONFIG.NAMEPLATE_TAG = "Target" end)
    local UI_LP_OrbitH = TabLocalPlayer:NewSlider('Height', '', false, '', {min = -10, max = 10, default = 5}, function(Value) Orbiter_Settings.Height = Value end)
    local UI_LP_OrbitS = TabLocalPlayer:NewSlider('Speed', '', false, '', {min = 1, max = 5, default = 2}, function(Value) Orbiter_Settings.Speed = Value end)
    local UI_LP_OrbitR = TabLocalPlayer:NewSlider('Radius', '', false, '', {min = 10, max = 50, default = 15}, function(Value) Orbiter_Settings.RadiusScale = Value / 10 end)

    TabLocalPlayer:NewSection('AntiAim')
    local UI_AA_On = TabLocalPlayer:NewToggle('On', false, function(Value) AntiAim.Activated = Value end)
    local UI_AA_Jitter = TabLocalPlayer:NewSlider('Jitter Intensity', '', false, '', {min = 0, max = 50, default = 0}, function(Value) AntiAim.Jitter = Value / 100 end)
    local UI_AA_X = TabLocalPlayer:NewSlider('X', '', false, '', {min = 0, max = 50, default = 0}, function(Value) AntiAim.Jitter_X = Value / 100 end)
    local UI_AA_Z = TabLocalPlayer:NewSlider('Z', '', false, '', {min = 0, max = 50, default = 0}, function(Value) AntiAim.Jitter_Z = Value / 100 end)
    local UI_AA_Speed = TabLocalPlayer:NewSlider('Speed', '', false, '', {min = 0, max = 100, default = 10}, function(Value) AntiAim.SpinSpeed = Value end)
    local UI_AA_Angle = TabLocalPlayer:NewSlider('Angle', '', false, '', {min = -180, max = 180, default = 180}, function(Value) AntiAim.SpinSwitchInterval = Value end)
    local UI_AA_Dir = TabLocalPlayer:NewSlider('Direction', '', false, '', {min = -1, max = 1, default = 1}, function(Value) AntiAim.SpinDirection = Value end)

    local AntiCheatState = false
    local AntiFallDmgState = false
    local AntiFlingState = false
    TabLocalPlayer:NewSection('Antis & Anticheat')
    local UI_AC_On = TabLocalPlayer:NewToggle('Anticheat', false, function(Value) AntiCheatState = Value; Anticheat(Value) end)
    local UI_AC_Speed = TabLocalPlayer:NewSlider('Speed Threshold', '', false, '', {min = 1, max = 999, default = playerWalkspeedCache}, function(Value) Anticheat_Settings.SPEED_THRESHOLD = Value end)
    local UI_AC_Jump = TabLocalPlayer:NewSlider('Jump Threshold', '', false, '', {min = 1, max = 999, default = playerJumpPowerCache}, function(Value) Anticheat_Settings.JUMP_THRESHOLD = Value end)
    local UI_AC_FlyD = TabLocalPlayer:NewSlider('Fly Threshold', '', false, '', {min = 1, max = 50, default = Anticheat_Settings.FLY_DETECTION_THRESHOLD}, function(Value) Anticheat_Settings.FLY_DETECTION_THRESHOLD = Value end)
    local UI_AC_FlyV = TabLocalPlayer:NewSlider('Fly (Velocity) Threshold', '', false, '', {min = 1, max = 50, default = Anticheat_Settings.FLY_VELOCITY_THRESHOLD}, function(Value) Anticheat_Settings.FLY_VELOCITY_THRESHOLD = Value end)
    local UI_AC_Tele = TabLocalPlayer:NewSlider('Teleport Threshold', '', false, '', {min = 1, max = 50, default = Anticheat_Settings.TELEPORT_THRESHOLD}, function(Value) Anticheat_Settings.TELEPORT_THRESHOLD = Value end)
    local UI_AC_Spin = TabLocalPlayer:NewSlider('Spin Threshold', '', false, '', {min = 1, max = 50, default = Anticheat_Settings.SPIN_DETECTION_THRESHOLD}, function(Value) Anticheat_Settings.SPIN_DETECTION_THRESHOLD = Value end)
    local UI_AC_MolD = TabLocalPlayer:NewSlider('Molestation Distance', '', false, '', {min = 1, max = 15, default = 10}, function(Value) Anticheat_Settings.HOOK_DISTANCE_THRESHOLD = Value / 10 end)
    local UI_AC_MolT = TabLocalPlayer:NewSlider('Molestation Threshold', '', false, '', {min = 1, max = 100, default = Anticheat_Settings.HOOK_DURATION_THRESHOLD}, function(Value) Anticheat_Settings.HOOK_DURATION_THRESHOLD = Value end)
    local UI_AC_Spikes = TabLocalPlayer:NewSlider('Spikes Threshold', '', false, '', {min = 1, max = 5, default = Anticheat_Settings.MAX_SPIKES}, function(Value) Anticheat_Settings.MAX_SPIKES = Value end)
    local UI_AC_AutoRep = TabLocalPlayer:NewToggle('AutoReport for Cheating', false, function(Value) Anticheat_Settings.REPORT = Value end)
    TabLocalPlayer:NewButton('Pardon All', function()
        getgenv().Library:Notify("Everyone is now undetected")
        Anticheat_Settings.PARDONED = true
        task.wait(5)
        getgenv().Library:Notify("Anticheat back in action")
        Anticheat_Settings.PARDONED = false
    end)
    
    TabLocalPlayer:NewButton('Un-VC Ban', function()
        game:GetService("VoiceChatService"):joinVoice()
        Success_Notificate("VC Ban Bypassed")
    end)
    TabLocalPlayer:NewButton('Anti-AFK', function() AntiIdle() end)
    local UI_LP_FallDmg = TabLocalPlayer:NewToggle('Anti FallDmg', false, function(Value) AntiFallDmgState = Value; AntiFallDmg(Value) end)
    local UI_LP_AntiFling = TabLocalPlayer:NewToggle('Anti Fling', false, function(Value) AntiFlingState = Value; disableCanCollide(Value) end)

    -- // OTHERS TAB
    local SkyboxState = false
    local WallClipState = false
    local FriendBotState = false
    local FPSCapState = 240
    
    TabOthers:NewSection('Main')
    TabOthers:NewButton('Load Supported Script', function() loadstring(game:HttpGet("https://raw.githubusercontent.com/hollyntt/PLWVRE-Roblox-Script/refs/heads/main/PLVSMVWVRE-RBLX/src/Outside%20Func/Meowijuana_Gamalauncher.lua"))() end)
    TabOthers:NewButton('Get GameID', function() print(game.PlaceId) setclipboard(tostring(game.PlaceId)) end)
    TabOthers:NewButton('Get JobID', function() print(game.JobId) setclipboard(tostring(game.JobId)) end)
    TabOthers:NewTextbox('Get Target Username', '', 'Player Name', 'all', 'small', true, false, function(Value) toclipboard(Value) Notificate(COLORS.GREEN, "Copied "..Value.. "'s Username") end)

    TabOthers:NewSection('Visuals / ETC')
    TabVisuals:NewSection('Skeleton ESP')

    local UI_Skeleton_Enabled = TabVisuals:NewToggle('Enabled', false, function(Value)
        if getgenv().SkeletonSettings then
            getgenv().SkeletonSettings.Enabled = Value
        end
    end)

    local UI_Skeleton_Thickness = TabVisuals:NewSlider('Thickness', '', false, '', {min = 1, max = 5, default = 1}, function(Value)
        if getgenv().SkeletonSettings then
            getgenv().SkeletonSettings.Thickness = Value
        end
    end)

    local UI_Skeleton_Transparency = TabVisuals:NewSlider('Transparency', '', false, '', {min = 10, max = 100, default = 100}, function(Value)
        if getgenv().SkeletonSettings then
            getgenv().SkeletonSettings.Transparency = Value / 100
        end
    end)

    local UI_Skeleton_UseTeamColor = TabVisuals:NewToggle('Use Team Colors', true, function(Value)
        if getgenv().SkeletonSettings then
            getgenv().SkeletonSettings.UseTeamColor = Value
        end
    end)

    local UI_Skeleton_Color = TabVisuals:NewColorpicker('Skeleton Color', Color3.fromRGB(255, 255, 255), function(Value)
        if getgenv().SkeletonSettings then
            getgenv().SkeletonSettings.Color = Value
        end
    end)

    local UI_Skeleton_TeamColor = TabVisuals:NewColorpicker('Team Color', Color3.fromRGB(0, 255, 0), function(Value)
        if getgenv().SkeletonSettings then
            getgenv().SkeletonSettings.TeamColor = Value
        end
    end)

    local UI_Skeleton_EnemyColor = TabVisuals:NewColorpicker('Enemy Color', Color3.fromRGB(255, 0, 0), function(Value)
        if getgenv().SkeletonSettings then
            getgenv().SkeletonSettings.EnemyColor = Value
        end
    end)
    
    TabOthers:NewButton('Rainbow Chat', function() loadstring(game:HttpGet("https://pastebin.com/raw/b3YS61yV", true))() end)
    TabOthers:NewButton('Roblox 2007 Mouse Cursor', function() loadstring(game:HttpGet("https://pastebin.com/raw/6uDb3He5", true))() end)
    TabOthers:NewButton('Rainbow Char', function()
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
    end)
    local UI_Oth_Skybox = TabOthers:NewToggle('Skybox', false, function(Value)
        SkyboxState = Value
        if Value == true then
            local SkyBox = Instance.new("Sky")
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
                if v.Name == "PLVSMVWVRE.lol" then v:Destroy() end
            end
        end
    end)
    local UI_Oth_WallClip = TabOthers:NewToggle('Camera WallClip', false, function(Value)
        WallClipState = Value
        if Value == true then player.DevCameraOcclusionMode = "Invisicam" else player.DevCameraOcclusionMode = "Zoom" end
    end)
    UI_Oth_WallClip:AddKeybind(Enum.KeyCode.Minus)

    local UI_Oth_Zoom = TabOthers:NewSlider('Max Zoom Dist', '', false, '', {min = 16, max = 999, default = 16}, function(Value) player.CameraMaxZoomDistance = Value end)
    local UI_Oth_FOV = TabOthers:NewSlider('FOV', '', false, '', {min = 70, max = 120, default = 70}, function(Value) ExtraVisuals.FOV = Value end)
    local UI_Oth_SndHM = TabOthers:NewTextbox('HitMarker Sound', '5794214857', 'SoundID', 'numbers', 'small', true, false, function(Value) SoundIDHM = Value end)
    local UI_Oth_SndK = TabOthers:NewTextbox('Kill Sound', '5764885315', 'SoundID', 'numbers', 'small', true, false, function(Value) SoundIDK = Value end)

    TabOthers:NewSection('Crosshair')
    local UI_Cross_On = TabOthers:NewToggle('Crosshair', false, function(Value) Crosshair.Enabled = Value end)
    local UI_Cross_Sides = TabOthers:NewSlider('Sides', '', false, '', {min = 2, max = 4, default = 4}, function(Value) Crosshair.Sides = Value end)
    local UI_Cross_Gap = TabOthers:NewSlider('Gap', '', false, '', {min = 0, max = 50, default = 4}, function(Value) Crosshair.Gap = Value end)    local UI_Cross_Rot = TabOthers:NewSlider('Rotation', '', false, '', {min = 0, max = 90, default = 85}, function(Value) Crosshair.Rotation = Value end)
    local UI_Cross_Thick = TabOthers:NewSlider('Thickness', '', false, '', {min = 1, max = 5, default = 2}, function(Value) Crosshair.Thickness = Value end)
    local UI_Cross_Len = TabOthers:NewSlider('Length', '', false, '', {min = 1, max = 50, default = 15}, function(Value) Crosshair.Size = Value end)    local UI_Cross_X = TabOthers:NewSlider('Offset (x)', '', false, '', {min = -100, max = 100, default = 0}, function(Value) Crosshair.x_Off = Value end)
    local UI_Cross_Y = TabOthers:NewSlider('Offset (y)', '', false, '', {min = -100, max = 100, default = 0}, function(Value) Crosshair.y_Off = Value end)
    local UI_Cross_C = TabOthers:NewColorpicker('Color', Color3.new(255, 255, 255), function(Value) Crosshair.Color = Value end)

    TabOthers:NewSection('Target Plates')
    local UI_Plate_C = TabOthers:NewColorpicker('Color', Color3.new(142, 0, 255), function(Value) NAMETAG_CONFIG.NAMEPLATE_COLOR = Value end)

    TabOthers:NewSection('Trolling')
    local UI_Chat_On = TabOthers:NewToggle('Chat Spam', false, function(Value) ChatSpammerrr.Activated = Value end)
    local UI_Chat_Mode = TabOthers:NewSlider('ChatSpammer Mode', '', false, '', {min = 1, max = 5, default = 1}, function(Value) ChatSpammerrr.Mode = Value end)
    TabOthers:NewButton('Become a NPC', function()
        getgenv().hurtmessages = { "That hurt!", "Watch where you're swinging!", "Ow! That's gonna leave a mark!", "Stop attacking me!", "I'm not feeling so good...", "Is that all you've got?", "Can't catch a break!", "That was a cheap shot!", "You'll regret that!" }
        if player.Character then
            local humanoid_v = player.Character:WaitForChild("Humanoid")
            local previousHealth = humanoid_v.Health
            humanoid_v.Changed:Connect(function()
                if humanoid_v.Health < previousHealth then
                    game.TextChatService.TextChannels.RBXGeneral:SendAsync(getgenv().hurtmessages[math.random(1, #getgenv().hurtmessages)])
                end
                previousHealth = humanoid_v.Health
            end)
        end
        player.CharacterAdded:Connect(function(char_obj)
            local humanoid_v = char_obj:WaitForChild("Humanoid")
            local previousHealth = humanoid_v.Health
            humanoid_v.Changed:Connect(function()
                if humanoid_v.Health < previousHealth then
                    game.TextChatService.TextChannels.RBXGeneral:SendAsync(getgenv().hurtmessages[math.random(1, #getgenv().hurtmessages)])
                end
                previousHealth = humanoid_v.Health
            end)
        end)
    end)
    TabOthers:NewButton('Reportbot', function() loadstring(game:HttpGet("https://raw.githubusercontent.com/CF-Trail/random/main/loadstrings/AutoreportRevamp.lua", true))() end)
    TabOthers:NewButton('Flingbot', function() FlingerAll() end)
    TabOthers:NewButton('Flingbot (Random Player)', function() FlingtargetPlayerName("random") end)
    local UI_Oth_Friend = TabOthers:NewToggle('FriendBot', false, function(Value) FriendBotState = Value; FB(Value) end)
    local UI_Oth_Targ = TabOthers:NewTextbox('Target Fling', '', 'Player Name', 'all', 'small', true, false, function(Value) NAMETAG_CONFIG.NAME = Value; NAMETAG_CONFIG.NAMEPLATE_TAG = "Target" end)
    TabOthers:NewButton('Fling Target', function()
        if NAMETAG_CONFIG.NAME == nil or NAMETAG_CONFIG.NAME == "" then
            getgenv().Library:Notify("No player chosen", 2) 
        else
            FlingtargetPlayerName(NAMETAG_CONFIG.NAME)
            getgenv().Library:Notify("Flung " .. NAMETAG_CONFIG.NAME .. "!", 2) 
            wait(1)
            Reset()
        end
    end)
    local UI_Oth_Flinger = TabOthers:NewKeybind('Immediant AllFlinger', Enum.KeyCode.Minus, function(Active)
        if Active then
            FlingerAll()
        end
    end)

    TabOthers:NewSection('Load Exploits')
    TabOthers:NewButton('Load Dex', function() loadstring(game:HttpGet(('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'),true))() end)
    TabOthers:NewButton('Load Sirius-X', function() loadstring(game:HttpGet(('https://sirius.menu/sirius'),true))() end)
    TabOthers:NewButton('Load INF-Y', function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
    TabOthers:NewButton('Load SSpy', function() loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))() end)
    TabOthers:NewButton('Load Hydrox', function()
        local owner = "Upbolt"
        local branch = "revision"
        local function webImport(file)
            return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
        end
        webImport("init")
        webImport("ui/main")
    end)
    TabOthers:NewButton('Load Proton', function() loadstring(game:HttpGet("https://raw.githubusercontent.com/biggaboy212/Public-Resources/main/Proton%20IDE/Raw.lua"))() end)
    TabOthers:NewButton('Load SUS FE', function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Amethystic/susfescripts/refs/heads/main/susfe.lua"))() end)
    TabOthers:NewButton('Load Chatbypasser', function() loadstring(game:HttpGet('https://raw.githubusercontent.com/cheatplug/usercreated/refs/heads/main/main.lua'))() end)
    TabOthers:NewButton('Load ToolHandler', function() loadstring(game:HttpGet("https://raw.githubusercontent.com/dqtixz/NebulaNosh-I-Gui-A.C.S-F.E-/main/By%20dqtixz"))() end)

    local UI_Oth_FPS = nil
    TabOthers:NewSection('Info')
    TabOthers:NewLabel('User ID: ' .. p.UserId, "left")
    if ExecName then
        TabOthers:NewLabel(ExecName, "left")
        if UNCRecieved <= RequiredUNC then
            TabOthers:NewLabel(UNCwarning, "left")
        else
            TabOthers:NewLabel('Supported Exec', "left")
            TabOthers:NewLabel(UNCRecieved..'% UNC', "left")
        end
        TabOthers:NewButton('Grab HWID', function() setclipboard(tostring(gethwid())) end)
        TabOthers:NewButton('Verificate LVL', function() loadstring(game:HttpGet("https://raw.githubusercontent.com/vvult/HIdentity/main/HIdentity"))() end)
        if game.PlaceId == 133609342474444 then
            TabOthers:NewButton('Verificate UNC through sUNC', function()
                getgenv().sUNCDebug = { ["printcheckpoints"] = BetaBuild, ["delaybetweentests"] = 0 }
                loadstring(game:HttpGet("https://script.sunc.su/"))()
            end)
        else
            TabOthers:NewButton('Verificate UNC through sUNC', function()
                local TeleportService = game:GetService("TeleportService")
                pcall(function() TeleportService:Teleport(133609342474444) end)
            end)
        end
        TabOthers:NewButton('Flex Executor', function()
            local ExecFlex = {
                "Oh yeah im using "..ExecName.." and it got "..UNCRecieved..'% UNC. '.."and it supports [PLVSMVWVRE] something that u dont have, cuz ur not rich like me.",
                "Does ur executor have "..UNCRecieved..'% UNC. like '..ExecName..", No? ok. Pooron. 😼😼",
                "*Sigh* "..ExecName.." "..ExecName.." "..ExecName.." "..". When will these people buy you.. for your "..UNCRecieved..'% UNC. '.." ;(",
            }
            if game.TextChatService and game.TextChatService:FindFirstChild("TextChannels") then
                local rbxGeneral = game.TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                if rbxGeneral then rbxGeneral:SendAsync(ExecFlex[math.random(1, #ExecFlex)]) end
            elseif game.ReplicatedStorage and game.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
                local sayMessageRequest = game.ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
                if sayMessageRequest then sayMessageRequest:FireServer(ExecFlex[math.random(1, #ExecFlex)], "All") end
            end
        end)
        UI_Oth_FPS = TabOthers:NewSlider('FPS Cap', '', false, '', {min = 60, max = 1000, default = 240}, function(Value) FPSCapState = Value; setfpscap(Value) end)
    else
        TabOthers:NewLabel('Unknown ass hack', "left")
        TabOthers:NewLabel('? Com', "left")
        TabOthers:NewLabel('Use the UNC test', "left")
        TabOthers:NewLabel('Verificate the LVL in console', "left")
        TabOthers:NewLabel(testwarning, "left")
        TabOthers:NewButton('Grab HWID', function() setclipboard(tostring(gethwid())) end)
        TabOthers:NewButton('Verificate LVL', function() loadstring(game:HttpGet("https://raw.githubusercontent.com/vvult/HIdentity/main/HIdentity"))() end)
        TabOthers:NewButton('Test UNC', function() loadstring(game:HttpGet("https://raw.githubusercontent.com/unified-naming-convention/NamingStandard/main/UNCCheckEnv.lua"))() end)
        UI_Oth_FPS = TabOthers:NewSlider('FPS Cap', '', false, '', {min = 60, max = 1000, default = 240}, function(Value) FPSCapState = Value; setfpscap(Value) end)
    end
    
    -- // CONFIG TAB
    TabUISettings:NewSection('Menu')
    TabUISettings:NewButton('Unload', function() EndStuff() end)
    TabUISettings:NewButton('Rejoin', function() rejoin() end)
    TabUISettings:NewButton('Server Hop', function() serverhop() end)
    TabUISettings:NewButton('Rage Quit', function() game:Shutdown() end)
    
    local KillFeedState = false
    local KillfeedToggle = TabUISettings:NewToggle('Killfeed', false, function(Value) 
        KillFeedState = Value
        HitDetection(Value) 
    end)

    -- ==========================================
    -- // CONFIGURATION MANAGER & FLAG EXPORTS
    -- ==========================================
    local ConfigFlags = {
        -- RAGE Main
        {Name = "Aimbot_Lock", Type = "Toggle", Get = function() return Aimbot.Enabled end, Set = function(val) Aimbot.Enabled = val; UI_Aimbot_Lock:Set(val) end},
        {Name = "Aimbot_Lock_Key", Type = "Keybind_Key", Get = function() return UI_Aimbot_Lock.Key end, Set = function(val) UI_Aimbot_Lock:SetKey(val) end},
        {Name = "Aimbot_Lock_KeyMode", Type = "Keybind_Mode", Get = function() return UI_Aimbot_Lock.KeyMode end, Set = function(val) UI_Aimbot_Lock:SetMode(val) end},
        
        {Name = "Aimbot_Vis", Type = "Toggle", Get = function() return Aimbot.CheckVisibility end, Set = function(val) Aimbot.CheckVisibility = val; UI_Aimbot_Vis:Set(val) end},
        {Name = "Aimbot_Alive", Type = "Toggle", Get = function() return Aimbot.CheckAlive end, Set = function(val) Aimbot.CheckAlive = val; UI_Aimbot_Alive:Set(val) end},
        {Name = "Aimbot_Team", Type = "Toggle", Get = function() return Aimbot.TeamCheck end, Set = function(val) Aimbot.TeamCheck = val; UI_Aimbot_Team:Set(val) end},
        {Name = "Aimbot_FOVCheck", Type = "Toggle", Get = function() return Aimbot.FOVCheck end, Set = function(val) Aimbot.FOVCheck = val; UI_Aimbot_FOV:Set(val) end},
        {Name = "Aimbot_Forcefield", Type = "Toggle", Get = function() return Aimbot.CheckForcefield end, Set = function(val) Aimbot.CheckForcefield = val; UI_Aimbot_Respawn:Set(val) end},
        {Name = "Aimbot_Prediction", Type = "Toggle", Get = function() return Aimbot.Prediction end, Set = function(val) Aimbot.Prediction = val; UI_Aimbot_Pred:Set(val) end},
        {Name = "Aimbot_AutoShoot", Type = "Toggle", Get = function() return Aimbot.AutoShoot end, Set = function(val) Aimbot.AutoShoot = val; UI_Aimbot_AutoShoot:Set(val) end},
        {Name = "Aimbot_Resolver", Type = "Toggle", Get = function() return Aimbot.Resolver end, Set = function(val) Aimbot.Resolver = val; UI_Aimbot_Resolver:Set(val) end},
        
        -- RCS
        {Name = "RCS_Enabled", Type = "Toggle", Get = function() return RCS_Sets.Enabled end, Set = function(val) RCS_Sets.Enabled = val; UI_RCS_Toggle:Set(val) end},
        {Name = "RCS_Control", Type = "Slider", Get = function() return RCS_Sets.RecoilControl end, Set = function(val) RCS_Sets.RecoilControl = val; UI_RCS_Control:Value(val) end},
        {Name = "RCS_DownAim", Type = "Slider", Get = function() return RCS_Sets.RecoilDownAim end, Set = function(val) RCS_Sets.RecoilDownAim = val; UI_RCS_DownAim:Value(val) end},
        {Name = "RCS_Speed", Type = "Slider", Get = function() return RCS_Sets.Speed end, Set = function(val) RCS_Sets.Speed = val; UI_RCS_Speed:Value(val) end},
        
        -- Aim Settings
        {Name = "Aim_ASDelay", Type = "Slider", Get = function() return Aimbot.AutoShoot_Delay * 10 end, Set = function(val) Aimbot.AutoShoot_Delay = val / 10; UI_Aim_ASDelay:Value(val) end},
        {Name = "Aim_Smooth", Type = "Slider", Get = function() return Aimbot.Smoothing * 100 end, Set = function(val) Aimbot.Smoothing = val / 100; UI_Aim_Smooth:Value(val) end},
        {Name = "Aim_Dist", Type = "Slider", Get = function() return Aimbot.Distance end, Set = function(val) Aimbot.Distance = val; UI_Aim_Dist:Value(val) end},
        {Name = "Aim_Offset", Type = "Slider", Get = function() return Aimbot.Prediction_Offset end, Set = function(val) Aimbot.Prediction_Offset = val; UI_Aim_Offset:Value(val) end},
        
        -- Resolver Settings
        {Name = "Res_Hist", Type = "Slider", Get = function() return Aimbot.ResolverHistory * 10 end, Set = function(val) Aimbot.ResolverHistory = val / 10; UI_Res_Hist:Value(val) end},
        {Name = "Res_PredErr", Type = "Slider", Get = function() return Aimbot.MaxPredictionError end, Set = function(val) Aimbot.MaxPredictionError = val; UI_Res_PredErr:Value(val) end},
        {Name = "Res_Smooth", Type = "Slider", Get = function() return Aimbot.VelocitySmoothing * 100 end, Set = function(val) Aimbot.VelocitySmoothing = val / 100; UI_Res_Smooth:Value(val) end},
        {Name = "Res_Jitter", Type = "Slider", Get = function() return Aimbot.JitterThreshold * 100 end, Set = function(val) Aimbot.JitterThreshold = val / 100; UI_Res_Jitter:Value(val) end},
        {Name = "Res_Conf", Type = "Slider", Get = function() return Aimbot.MinPredictionConfidence * 100 end, Set = function(val) Aimbot.MinPredictionConfidence = val / 100; UI_Res_Conf:Value(val) end},
        
        -- Added Desync Detection config flag
        {Name = "Res_DesyncDetection", Type = "Toggle", Get = function() return Aimbot.DesyncDetection end, Set = function(val) Aimbot.DesyncDetection = val; if UI_Res_Desync then UI_Res_Desync:Set(val) end end},
        
        -- Misc
        {
            Name = "Aim_Hitboxes", 
            Type = "Dropdown", 
            Get = function() 
                if not Aimbot.Hitboxes then
                    Aimbot.Hitboxes = { ["Head"] = true }
                end
                local active = {}
                for name, enabled in pairs(Aimbot.Hitboxes) do
                    if enabled then table.insert(active, name) end
                end
                return table.concat(active, ",")
            end, 
            Set = function(val) 
                if not Aimbot.Hitboxes then
                    Aimbot.Hitboxes = { ["Head"] = true }
                end
                
                local parsed = {}
                table.clear(Aimbot.Hitboxes)
                
                for name in string.gmatch(val, "[^,]+") do
                    Aimbot.Hitboxes[name] = true
                    table.insert(parsed, name)
                end
                
                -- Safety check fallback
                if #parsed == 0 then
                    Aimbot.Hitboxes["Head"] = true
                    table.insert(parsed, "Head")
                end
                
                -- Sync the visual state of the multi-selector UI
                if UI_Aim_Hitbox and UI_Aim_Hitbox.Set then
                    UI_Aim_Hitbox:Set(parsed)
                end
            end
        },
        {Name = "Aim_FOVVis", Type = "Toggle", Get = function() return Aimbot.FOVVisible end, Set = function(val) Aimbot.FOVVisible = val; UI_Aim_FOVVis:Set(val) end},
        {Name = "Aim_FOVRad", Type = "Slider", Get = function() return Aimbot.FOVRadius end, Set = function(val) Aimbot.FOVRadius = val; UI_Aim_FOVRad:Value(val) end},
        {Name = "Aim_FOVSides", Type = "Slider", Get = function() return Aimbot.FOVSides end, Set = function(val) Aimbot.FOVSides = val; UI_Aim_FOVSides:Value(val) end},
        {Name = "Aim_FOVThick", Type = "Slider", Get = function() return Aimbot.FOVThickness end, Set = function(val) Aimbot.FOVThickness = val; UI_Aim_FOVThick:Value(val) end},
        {Name = "Aim_FOVTrans", Type = "Slider", Get = function() return Aimbot.FOVTransparency * 100 end, Set = function(val) Aimbot.FOVTransparency = val / 100; if UI_Aim_FOVTrans then UI_Aim_FOVTrans:Value(val) end end},
        {Name = "Aim_FOVC", Type = "Colorpicker", Get = function() return Aimbot.FOVColor end, Set = function(val) Aimbot.FOVColor = val; UI_Aim_FOVC:Set(val) end},
        
        {Name = "Aim_TBot", Type = "Toggle", Get = function() return TriggerBotState end, Set = function(val) TriggerBotState = val; TriggerBot(val); UI_Aim_TBot:Set(val) end},
        {Name = "Aim_TBot_Key", Type = "Keybind_Key", Get = function() return UI_Aim_TBot.Key end, Set = function(val) UI_Aim_TBot:SetKey(val) end},
        {Name = "Aim_TBot_KeyMode", Type = "Keybind_Mode", Get = function() return UI_Aim_TBot.KeyMode end, Set = function(val) UI_Aim_TBot:SetMode(val) end},
        
        {Name = "Aim_TSens", Type = "Slider", Get = function() return Aimbot.Triggerbot_Sensitivity * 100 end, Set = function(val) Aimbot.Triggerbot_Sensitivity = val / 100; UI_Aim_TSens:Value(val) end},
        
        -- Movement
        {Name = "Move_Fly", Type = "Toggle", Get = function() return FlyState end, Set = function(val) FlyState = val; FlyActivate(val); UI_Move_Fly:Set(val) end},
        {Name = "Move_Fly_Key", Type = "Keybind_Key", Get = function() return UI_Move_Fly.Key end, Set = function(val) UI_Move_Fly:SetKey(val) end},
        {Name = "Move_Fly_KeyMode", Type = "Keybind_Mode", Get = function() return UI_Move_Fly.KeyMode end, Set = function(val) UI_Move_Fly:SetMode(val) end},
        
        {Name = "Move_WS", Type = "Slider", Get = function() return player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.WalkSpeed or playerWalkspeedCache end, Set = function(val) if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = val end; UI_Move_WS:Value(val) end},
        {Name = "Move_JP", Type = "Slider", Get = function() return player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.JumpPower or playerJumpPowerCache end, Set = function(val) if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.JumpPower = val end; UI_Move_JP:Value(val) end},
        {Name = "Move_FS", Type = "Slider", Get = function() return flySpeed end, Set = function(val) flySpeed = val; UI_Move_FS:Value(val) end},
        
        -- LocalPlayer
        {Name = "LP_Sit", Type = "Toggle", Get = function() return SitState end, Set = function(val) SitState = val; if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.Sit = val end; UI_LP_Sit:Set(val) end},
        {Name = "LP_QuickReset_Key", Type = "Keybind_Key", Get = function() return UI_LP_QuickReset.Key end, Set = function(val) UI_LP_QuickReset:SetKey(val) end},
        {Name = "LP_QuickReset_KeyMode", Type = "Keybind_Mode", Get = function() return UI_LP_QuickReset.KeyMode end, Set = function(val) UI_LP_QuickReset:SetMode(val) end},
        
        {Name = "Orbit_On", Type = "Toggle", Get = function() return OrbitState end, Set = function(val) OrbitState = val; Orbiter(val); UI_LP_Orbit:Set(val) end},
        {Name = "Orbit_Target", Type = "Textbox", Get = function() return Orbiter_Settings.Target end, Set = function(val) Orbiter_Settings.Target = val end},
        {Name = "Orbit_Height", Type = "Slider", Get = function() return Orbiter_Settings.Height end, Set = function(val) Orbiter_Settings.Height = val; UI_LP_OrbitH:Value(val) end},
        {Name = "Orbit_Speed", Type = "Slider", Get = function() return Orbiter_Settings.Speed end, Set = function(val) Orbiter_Settings.Speed = val; UI_LP_OrbitS:Value(val) end},
        {Name = "Orbit_Radius", Type = "Slider", Get = function() return Orbiter_Settings.RadiusScale * 10 end, Set = function(val) Orbiter_Settings.RadiusScale = val / 10; UI_LP_OrbitR:Value(val) end},
        {Name = "AA_On", Type = "Toggle", Get = function() return AntiAim.Activated end, Set = function(val) AntiAim.Activated = val; UI_AA_On:Set(val) end},
        {Name = "AA_Jitter", Type = "Slider", Get = function() return AntiAim.Jitter * 100 end, Set = function(val) AntiAim.Jitter = val / 100; UI_AA_Jitter:Value(val) end},
        {Name = "AA_X", Type = "Slider", Get = function() return AntiAim.Jitter_X * 100 end, Set = function(val) AntiAim.Jitter_X = val / 100; UI_AA_X:Value(val) end},
        {Name = "AA_Z", Type = "Slider", Get = function() return AntiAim.Jitter_Z * 100 end, Set = function(val) AntiAim.Jitter_Z = val / 100; UI_AA_Z:Value(val) end},
        {Name = "AA_Speed", Type = "Slider", Get = function() return AntiAim.SpinSpeed end, Set = function(val) AntiAim.SpinSpeed = val; UI_AA_Speed:Value(val) end},
        {Name = "AA_Angle", Type = "Slider", Get = function() return AntiAim.SpinSwitchInterval end, Set = function(val) AntiAim.SpinSwitchInterval = val; UI_AA_Angle:Value(val) end},
        {Name = "AA_Dir", Type = "Slider", Get = function() return AntiAim.SpinDirection end, Set = function(val) AntiAim.SpinDirection = val; UI_AA_Dir:Value(val) end},
        {Name = "AC_On", Type = "Toggle", Get = function() return AntiCheatState end, Set = function(val) AntiCheatState = val; Anticheat(val); UI_AC_On:Set(val) end},
        {Name = "AC_Speed", Type = "Slider", Get = function() return Anticheat_Settings.SPEED_THRESHOLD end, Set = function(val) Anticheat_Settings.SPEED_THRESHOLD = val; UI_AC_Speed:Value(val) end},
        {Name = "AC_Jump", Type = "Slider", Get = function() return Anticheat_Settings.JUMP_THRESHOLD end, Set = function(val) Anticheat_Settings.JUMP_THRESHOLD = val; UI_AC_Jump:Value(val) end},
        {Name = "AC_FlyD", Type = "Slider", Get = function() return Anticheat_Settings.FLY_DETECTION_THRESHOLD end, Set = function(val) Anticheat_Settings.FLY_DETECTION_THRESHOLD = val; UI_AC_FlyD:Value(val) end},
        {Name = "AC_FlyV", Type = "Slider", Get = function() return Anticheat_Settings.FLY_VELOCITY_THRESHOLD end, Set = function(val) Anticheat_Settings.FLY_VELOCITY_THRESHOLD = val; UI_AC_FlyV:Value(val) end},
        {Name = "AC_Tele", Type = "Slider", Get = function() return Anticheat_Settings.TELEPORT_THRESHOLD end, Set = function(val) Anticheat_Settings.TELEPORT_THRESHOLD = val; UI_AC_Tele:Value(val) end},
        {Name = "AC_Spin", Type = "Slider", Get = function() return Anticheat_Settings.SPIN_DETECTION_THRESHOLD end, Set = function(val) Anticheat_Settings.SPIN_DETECTION_THRESHOLD = val; UI_AC_Spin:Value(val) end},
        {Name = "AC_MolD", Type = "Slider", Get = function() return Anticheat_Settings.HOOK_DISTANCE_THRESHOLD * 10 end, Set = function(val) Anticheat_Settings.HOOK_DISTANCE_THRESHOLD = val / 10; UI_AC_MolD:Value(val) end},
        {Name = "AC_MolT", Type = "Slider", Get = function() return Anticheat_Settings.HOOK_DURATION_THRESHOLD end, Set = function(val) Anticheat_Settings.HOOK_DURATION_THRESHOLD = val; UI_AC_MolT:Value(val) end},
        {Name = "AC_Spikes", Type = "Slider", Get = function() return Anticheat_Settings.MAX_SPIKES end, Set = function(val) Anticheat_Settings.MAX_SPIKES = val; UI_AC_Spikes:Value(val) end},
        {Name = "AC_AutoRep", Type = "Toggle", Get = function() return Anticheat_Settings.REPORT end, Set = function(val) Anticheat_Settings.REPORT = val; UI_AC_AutoRep:Set(val) end},
        {Name = "LP_FallDmg", Type = "Toggle", Get = function() return AntiFallDmgState end, Set = function(val) AntiFallDmgState = val; AntiFallDmg(val); UI_LP_FallDmg:Set(val) end},
        {Name = "LP_AntiFling", Type = "Toggle", Get = function() return AntiFlingState end, Set = function(val) AntiFlingState = val; disableCanCollide(val); UI_LP_AntiFling:Set(val) end},
        
        -- OTHERS
        {Name = "Oth_Skybox", Type = "Toggle", Get = function() return SkyboxState end, Set = function(val) 
            SkyboxState = val
            UI_Oth_Skybox:Set(val)
            if val == true then
                if not game.Lighting:FindFirstChild("PLVSMVWVRE.lol") then
                    local SkyBox = Instance.new("Sky")
                    SkyBox.Name = "PLVSMVWVRE.lol"
                    SkyBox.Parent = game.Lighting
                    SkyBox.SkyboxBk = "http://www.roblox.com/asset/?id=271042516"
                    SkyBox.SkyboxDn = "http://www.roblox.com/asset/?id=271077243"
                    SkyBox.SkyboxFt = "http://www.roblox.com/asset/?id=271042556"
                    SkyBox.SkyboxRt = "http://www.roblox.com/asset/?id=271042467"
                    SkyBox.SkyboxLf = "http://www.roblox.com/asset/?id=271042310"
                    SkyBox.SkyboxUp = "http://www.roblox.com/asset/?id=271077958"
                    SkyBox.StarCount = 0
                end
            else
                for _, v in ipairs(game:GetService("Lighting"):GetDescendants()) do
                    if v.Name == "PLVSMVWVRE.lol" then v:Destroy() end
                end
            end
        end},
        {Name = "Oth_WallClip", Type = "Toggle", Get = function() return WallClipState end, Set = function(val) 
            WallClipState = val
            UI_Oth_WallClip:Set(val)
            player.DevCameraOcclusionMode = val and "Invisicam" or "Zoom"
        end},
        {Name = "Oth_WallClip_Key", Type = "Keybind_Key", Get = function() return UI_Oth_WallClip.Key end, Set = function(val) UI_Oth_WallClip:SetKey(val) end},
        {Name = "Oth_WallClip_KeyMode", Type = "Keybind_Mode", Get = function() return UI_Oth_WallClip.KeyMode end, Set = function(val) UI_Oth_WallClip:SetMode(val) end},
        
        {Name = "Oth_Zoom", Type = "Slider", Get = function() return player.CameraMaxZoomDistance end, Set = function(val) player.CameraMaxZoomDistance = val; UI_Oth_Zoom:Value(val) end},
        {Name = "Oth_FOV", Type = "Slider", Get = function() return ExtraVisuals.FOV end, Set = function(val) ExtraVisuals.FOV = val; UI_Oth_FOV:Value(val) end},
        {Name = "Oth_SndHM", Type = "Textbox", Get = function() return SoundIDHM end, Set = function(val) SoundIDHM = val end},
        {Name = "Oth_SndK", Type = "Textbox", Get = function() return SoundIDK end, Set = function(val) SoundIDK = val end},
        {Name = "Cross_On", Type = "Toggle", Get = function() return Crosshair.Enabled end, Set = function(val) Crosshair.Enabled = val; UI_Cross_On:Set(val) end},
        {Name = "Cross_Sides", Type = "Slider", Get = function() return Crosshair.Sides end, Set = function(val) Crosshair.Sides = val; UI_Cross_Sides:Value(val) end},
        {Name = "Cross_Gap", Type = "Slider", Get = function() return Crosshair.Gap end, Set = function(val) Crosshair.Gap = val; UI_Cross_Gap:Value(val) end},        {Name = "Cross_Rot", Type = "Slider", Get = function() return Crosshair.Rotation end, Set = function(val) Crosshair.Rotation = val; UI_Cross_Rot:Value(val) end},
        {Name = "Cross_Thick", Type = "Slider", Get = function() return Crosshair.Thickness end, Set = function(val) Crosshair.Thickness = val; UI_Cross_Thick:Value(val) end},
        {Name = "Cross_Len", Type = "Slider", Get = function() return Crosshair.Size end, Set = function(val) Crosshair.Size = val; UI_Cross_Len:Value(val) end},        {Name = "Cross_X", Type = "Slider", Get = function() return Crosshair.x_Off end, Set = function(val) Crosshair.x_Off = val; UI_Cross_X:Value(val) end},
        {Name = "Cross_Y", Type = "Slider", Get = function() return Crosshair.y_Off end, Set = function(val) Crosshair.y_Off = val; UI_Cross_Y:Value(val) end},
        {Name = "Cross_C", Type = "Colorpicker", Get = function() return Crosshair.Color end, Set = function(val) Crosshair.Color = val; UI_Cross_C:Set(val) end},
        {Name = "Plate_C", Type = "Colorpicker", Get = function() return NAMETAG_CONFIG.NAMEPLATE_COLOR end, Set = function(val) NAMETAG_CONFIG.NAMEPLATE_COLOR = val; UI_Plate_C:Set(val) end},
        {Name = "Chat_On", Type = "Toggle", Get = function() return ChatSpammerrr.Activated end, Set = function(val) ChatSpammerrr.Activated = val; UI_Chat_On:Set(val) end},
        {Name = "Chat_Mode", Type = "Slider", Get = function() return ChatSpammerrr.Mode end, Set = function(val) ChatSpammerrr.Mode = val; UI_Chat_Mode:Value(val) end},
        {Name = "Oth_Friend", Type = "Toggle", Get = function() return FriendBotState end, Set = function(val) FriendBotState = val; FB(val); UI_Oth_Friend:Set(val) end},
        {Name = "Oth_Targ", Type = "Textbox", Get = function() return NAMETAG_CONFIG.NAME end, Set = function(val) NAMETAG_CONFIG.NAME = val; NAMETAG_CONFIG.NAMEPLATE_TAG = "Target" end},
        
        {Name = "Oth_Flinger_Key", Type = "Keybind_Key", Get = function() return UI_Oth_Flinger.Key end, Set = function(val) UI_Oth_Flinger:SetKey(val) end},
        {Name = "Oth_Flinger_KeyMode", Type = "Keybind_Mode", Get = function() return UI_Oth_Flinger.KeyMode end, Set = function(val) UI_Oth_Flinger:SetMode(val) end},
        
        {Name = "Oth_FPS", Type = "Slider", Get = function() return FPSCapState end, Set = function(val) if UI_Oth_FPS then FPSCapState = val; setfpscap(val); UI_Oth_FPS:Value(val) end end},
        {Name = "Oth_Killfeed", Type = "Toggle", Get = function() return KillFeedState end, Set = function(val) KillFeedState = val; HitDetection(val); KillfeedToggle:Set(val) end},
        
        -- ESP Shared Settings
        {Name = "ESP_Origin", Type = "Dropdown", Get = function() return Sense.teamSettings.enemy.tracerOrigin end, Set = function(val) Sense.teamSettings.enemy.tracerOrigin = val; Sense.teamSettings.friendly.tracerOrigin = val; UI_ESP_Origin:Text(val) end},
        {Name = "ESP_TextSize", Type = "Slider", Get = function() return Sense.sharedSettings.textSize end, Set = function(val) Sense.sharedSettings.textSize = val; UI_ESP_TextS:Value(val) end},
        {Name = "ESP_MaxDist", Type = "Slider", Get = function() return Sense.sharedSettings.maxDistance end, Set = function(val) Sense.sharedSettings.maxDistance = val; UI_ESP_MaxD:Value(val) end},
        
        {Name = "Skeleton_Enabled", Type = "Toggle", Get = function() return getgenv().SkeletonSettings and getgenv().SkeletonSettings.Enabled or false end, Set = function(val) if getgenv().SkeletonSettings then getgenv().SkeletonSettings.Enabled = val end; UI_Skeleton_Enabled:Set(val) end},
        {Name = "Skeleton_Thickness", Type = "Slider", Get = function() return getgenv().SkeletonSettings and getgenv().SkeletonSettings.Thickness or 1 end, Set = function(val) if getgenv().SkeletonSettings then getgenv().SkeletonSettings.Thickness = val end; UI_Skeleton_Thickness:Value(val) end},
        {Name = "Skeleton_Transparency", Type = "Slider", Get = function() return getgenv().SkeletonSettings and (getgenv().SkeletonSettings.Transparency * 100) or 100 end, Set = function(val) if getgenv().SkeletonSettings then getgenv().SkeletonSettings.Transparency = val / 100 end; UI_Skeleton_Transparency:Value(val) end},
        {Name = "Skeleton_UseTeamColor", Type = "Toggle", Get = function() return getgenv().SkeletonSettings and getgenv().SkeletonSettings.UseTeamColor or true end, Set = function(val) if getgenv().SkeletonSettings then getgenv().SkeletonSettings.UseTeamColor = val end; UI_Skeleton_UseTeamColor:Set(val) end},
        {Name = "Skeleton_Color", Type = "Colorpicker", Get = function() return getgenv().SkeletonSettings and getgenv().SkeletonSettings.Color or Color3.fromRGB(255, 255, 255) end, Set = function(val) if getgenv().SkeletonSettings then getgenv().SkeletonSettings.Color = val end; UI_Skeleton_Color:Set(val) end},
        {Name = "Skeleton_TeamColor", Type = "Colorpicker", Get = function() return getgenv().SkeletonSettings and getgenv().SkeletonSettings.TeamColor or Color3.fromRGB(0, 255, 0) end, Set = function(val) if getgenv().SkeletonSettings then getgenv().SkeletonSettings.TeamColor = val end; UI_Skeleton_TeamColor:Set(val) end},
        {Name = "Skeleton_EnemyColor", Type = "Colorpicker", Get = function() return getgenv().SkeletonSettings and getgenv().SkeletonSettings.EnemyColor or Color3.fromRGB(255, 0, 0) end, Set = function(val) if getgenv().SkeletonSettings then getgenv().SkeletonSettings.EnemyColor = val end; UI_Skeleton_EnemyColor:Set(val) end},

        {Name = "Arrow_Enabled", Type = "Toggle", Get = function() return getgenv().ArrowSettings and getgenv().ArrowSettings.Enabled or false end, Set = function(val) if getgenv().ArrowSettings then getgenv().ArrowSettings.Enabled = val end if UI_Arrow_Enabled then UI_Arrow_Enabled:Set(val) end end},
        {Name = "Arrow_Dist", Type = "Slider", Get = function() return getgenv().ArrowSettings and getgenv().ArrowSettings.DistFromCenter or 80 end, Set = function(val) if getgenv().ArrowSettings then getgenv().ArrowSettings.DistFromCenter = val end if UI_Arrow_Dist then UI_Arrow_Dist:Value(val) end end},
        {Name = "Arrow_Height", Type = "Slider", Get = function() return getgenv().ArrowSettings and getgenv().ArrowSettings.TriangleHeight or 16 end, Set = function(val) if getgenv().ArrowSettings then getgenv().ArrowSettings.TriangleHeight = val end if UI_Arrow_Height then UI_Arrow_Height:Value(val) end end},
        {Name = "Arrow_Width", Type = "Slider", Get = function() return getgenv().ArrowSettings and getgenv().ArrowSettings.TriangleWidth or 16 end, Set = function(val) if getgenv().ArrowSettings then getgenv().ArrowSettings.TriangleWidth = val end if UI_Arrow_Width then UI_Arrow_Width:Value(val) end end},
        {Name = "Arrow_Filled", Type = "Toggle", Get = function() return getgenv().ArrowSettings and getgenv().ArrowSettings.TriangleFilled or true end, Set = function(val) if getgenv().ArrowSettings then getgenv().ArrowSettings.TriangleFilled = val end if UI_Arrow_Filled then UI_Arrow_Filled:Set(val) end end},
        {Name = "Arrow_Thickness", Type = "Slider", Get = function() return getgenv().ArrowSettings and getgenv().ArrowSettings.TriangleThickness or 1 end, Set = function(val) if getgenv().ArrowSettings then getgenv().ArrowSettings.TriangleThickness = val end if UI_Arrow_Thickness then UI_Arrow_Thickness:Value(val) end end},
        {Name = "Arrow_Transparency", Type = "Slider", Get = function() return getgenv().ArrowSettings and (getgenv().ArrowSettings.TriangleTransparency * 100) or 0 end, Set = function(val) if getgenv().ArrowSettings then getgenv().ArrowSettings.TriangleTransparency = val / 100 end if UI_Arrow_Transparency then UI_Arrow_Transparency:Value(val) end end},
        {Name = "Arrow_Color", Type = "Colorpicker", Get = function() return getgenv().ArrowSettings and getgenv().ArrowSettings.TriangleColor or Color3.fromRGB(255, 255, 255) end, Set = function(val) if getgenv().ArrowSettings then getgenv().ArrowSettings.TriangleColor = val end if UI_Arrow_Color then UI_Arrow_Color:Set(val) end end},
        {Name = "Arrow_AntiAliasing", Type = "Toggle", Get = function() return getgenv().ArrowSettings and getgenv().ArrowSettings.AntiAliasing or false end, Set = function(val) if getgenv().ArrowSettings then getgenv().ArrowSettings.AntiAliasing = val end if UI_Arrow_AntiAliasing then UI_Arrow_AntiAliasing:Set(val) end end},
    }

    local function RegisterESPSettings(teamStr)
        local cap = (teamStr == "enemy") and "Enemy" or "Friendly"
        table.insert(ConfigFlags, { Name = "ESP_"..cap.."_Enabled", Type = "Toggle", Get = function() return Sense.teamSettings[teamStr].enabled end, Set = function(val) Sense.teamSettings[teamStr].enabled = val; if currentESPTeam == cap then espControls.Enabled:Set(val) end end })
        table.insert(ConfigFlags, { Name = "ESP_"..cap.."_Box", Type = "Toggle", Get = function() return Sense.teamSettings[teamStr].box end, Set = function(val) Sense.teamSettings[teamStr].box = val; if currentESPTeam == cap then espControls.Box:Set(val) end end })
        table.insert(ConfigFlags, { Name = "ESP_"..cap.."_Name", Type = "Toggle", Get = function() return Sense.teamSettings[teamStr].name end, Set = function(val) Sense.teamSettings[teamStr].name = val; if currentESPTeam == cap then espControls.Name:Set(val) end end })
        table.insert(ConfigFlags, { Name = "ESP_"..cap.."_Tracer", Type = "Toggle", Get = function() return Sense.teamSettings[teamStr].tracer end, Set = function(val) Sense.teamSettings[teamStr].tracer = val; if currentESPTeam == cap then espControls.Tracer:Set(val) end end })
        table.insert(ConfigFlags, { Name = "ESP_"..cap.."_HealthBar", Type = "Toggle", Get = function() return Sense.teamSettings[teamStr].healthBar end, Set = function(val) Sense.teamSettings[teamStr].healthBar = val; if currentESPTeam == cap then espControls.HealthBar:Set(val) end end })
        table.insert(ConfigFlags, { Name = "ESP_"..cap.."_Distance", Type = "Toggle", Get = function() return Sense.teamSettings[teamStr].distance end, Set = function(val) Sense.teamSettings[teamStr].distance = val; if currentESPTeam == cap then espControls.Distance:Set(val) end end })
        table.insert(ConfigFlags, { Name = "ESP_"..cap.."_Chams", Type = "Toggle", Get = function() return Sense.teamSettings[teamStr].chams end, Set = function(val) Sense.teamSettings[teamStr].chams = val; if currentESPTeam == cap then espControls.Chams:Set(val) end end })
        table.insert(ConfigFlags, { Name = "ESP_"..cap.."_Color", Type = "Colorpicker", Get = function() return Sense.teamSettings[teamStr].boxColor[1] end, Set = function(val) 
            Sense.teamSettings[teamStr].boxColor = {val, 1}
            Sense.teamSettings[teamStr].tracerColor = {val, 1}
            Sense.teamSettings[teamStr].chamsOutlineColor = {val, 0}
            if currentESPTeam == cap then espControls.Color:Set(val) end 
        end })
    end
    
    RegisterESPSettings("enemy")
    RegisterESPSettings("friendly")

    -- Automate loop registering
    for _, flag in pairs(ConfigFlags) do
        library:RegisterFlag(flag.Name, flag.Type, flag.Get, flag.Set)
    end

    TabUISettings:NewSection('Configuration')
    local currentConfigName = "default"
    local configList = library:ListConfigs()

    TabUISettings:NewTextbox("Create New Config", "default", "Enter new name...", "all", "small", true, false, function(Value) currentConfigName = Value end)
    local ConfigSelector = TabUISettings:NewSelector("Saved Configs", "Select...", configList, function(Value)
        if Value ~= "Select..." then
            currentConfigName = Value
            print("[PLVSMVWVRE] Selected config: " .. currentConfigName)
        end
    end)

    TabUISettings:NewButton("Refresh Config List", function()
        for _, oldConfig in pairs(configList) do ConfigSelector:RemoveOption(oldConfig) end
        configList = library:ListConfigs()
        for _, newConfig in pairs(configList) do ConfigSelector:AddOption(newConfig) end
        print("[PLVSMVWVRE] Config list refreshed!")
    end)
    TabUISettings:NewSeperator()
    TabUISettings:NewButton("Save Config", function()
        if currentConfigName ~= "" and currentConfigName ~= "Select..." then
            if library:SaveConfig(currentConfigName) then
                print("[PLVSMVWVRE] Successfully saved config: " .. currentConfigName)
                if not table.find(configList, currentConfigName) then
                    table.insert(configList, currentConfigName)
                    ConfigSelector:AddOption(currentConfigName)
                end
            else
                warn("[PLVSMVWVRE] Failed to save config.")
            end
        end
    end)
    TabUISettings:NewButton("Load Config", function()
        if currentConfigName ~= "" and currentConfigName ~= "Select..." then
            if library:LoadConfig(currentConfigName) then
                print("[PLVSMVWVRE] Successfully loaded config: " .. currentConfigName)
            else
                warn("[PLVSMVWVRE] Failed to load config.")
            end
        end
    end)
    TabUISettings:NewButton("Delete Config", function()
        if currentConfigName ~= "" and currentConfigName ~= "Select..." then
            if library:DeleteConfig(currentConfigName) then
                print("[PLVSMVWVRE] Deleted config: " .. currentConfigName)
                ConfigSelector:RemoveOption(currentConfigName)
                local index = table.find(configList, currentConfigName)
                if index then table.remove(configList, index) end
                currentConfigName = "default"
            end
        end
    end)

    -- [[ AUTOLOAD UI CONTROLS ]]
    local autoloadLabel = TabUISettings:NewLabel("Current Autoload: " .. (library:GetAutoload() or "None"), "left")
    TabUISettings:NewButton("Set as Autoload", function()
        if currentConfigName ~= "" and currentConfigName ~= "Select..." then
            if library:SetAutoload(currentConfigName) then
                autoloadLabel:Text("Current Autoload: " .. currentConfigName)
                print("[PLVSMVWVRE] Set " .. currentConfigName .. " as autoload!")
            end
        end
    end)
    TabUISettings:NewButton("Clear Autoload", function()
        if library:ClearAutoload() then
            autoloadLabel:Text("Current Autoload: None")
            print("[PLVSMVWVRE] Cleared autoload setting!")
        end
    end)

    Launch()

    -- Trigger autoload
    task.spawn(function()
        local success = library:Autoload()
        if success then
            print("[PLVSMVWVRE] Autoloaded config successfully!")
        end
    end)
    
    if getgenv().Library.Unloaded then
        for name, connection in pairs(EventConnections) do
            if connection then
                if typeof(connection) == "RBXScriptConnection" then
                    connection:Disconnect()
                else
                    warn("Invalid connection type for " .. name .. ": " .. typeof(connection))
                end
                EventConnections[name] = nil
            end
        end
    
        local allDisconnected = true
        for _, connection in pairs(EventConnections) do
            if connection then
                allDisconnected = false
                break
            end
        end
    
        if allDisconnected then
            print("✅ All runtime functions are now unloaded.")
        else
            warn("⚠️ Some runtime functions could not be unloaded.")
        end
    end
end

-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |                                           Checking...                                           |
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

local function CallBuild()
    local function UNCTest()
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
            UNCRecieved = rate
            UNCMissed = fails
            UNCUndefined = undefined
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
            local function test_f()
                return "success"
            end
            local copy = clonefunction(test_f)
            assert(test_f() == copy(), "The clone should return the same value as the original")
            assert(test_f ~= copy, "The clone should not be equal to the original")
        end)
        
        test("getcallingscript", {})
        
        test("getscriptclosure", {"getscriptfunction"}, function()
            local module = game:GetService("CoreGui").RobloxGui.Modules.Common.Constants
            local constants = getrenv().require(module)
            local generated = getscriptclosure(module)()
            assert(constants ~= generated, "Generated module should not match the original")
            assert(shallowEqual(constants, generated), "Generated constant table should be shallow equal to the original")
        end)
        
        test("hookfunction", {"replaceclosure"}, function()
            local function test_f()
                return true
            end
            local ref = hookfunction(test_f, function()
                return false
            end)
            assert(test_f() == false, "Function should return false")
            assert(ref() == true, "Original function should return true")
            assert(test_f ~= ref, "Original function should not be same as the reference")
        end)
        
        test("iscclosure", {}, function()
            assert(iscclosure(print) == true, "Function 'print' should be a C closure")
            assert(iscclosure(function() end) == false, "Executor function should not be a C closure")
        end)
        
        test("islclosure", {}, function()
            assert(islclosure(print) == false, "Function 'print' should not be a Lua closure")
            assert(islclosure(function() end) == true, "Executor function should be a Lua closure")
        end)
        
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
        
        test("newcclosure", {}, function()
            local function test_f()
                return true
            end
            local testC = newcclosure(test_f)
            assert(test_f() == testC(), "New C closure should return the same value as the original")
            assert(test_f ~= testC, "New C closure should not be same as the original")
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
            local function test_f()
                print("Hello, world!")
            end
            assert(debug.getconstant(test_f, 1) == "print", "First constant must be print")
            assert(debug.getconstant(test_f, 2) == nil, "Second constant must be nil")
            assert(debug.getconstant(test_f, 3) == "Hello, world!", "Third constant must be 'Hello, world!'")
        end)
        
        test("debug.getconstants", {}, function()
            local function test_f()
                local num = 5000 .. 50000
                print("Hello, world!", num, warn)
            end
            local constants = debug.getconstants(test_f)
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
            local function test_f(...)
                print(...)
            end
            local info = debug.getinfo(test_f)
            for k, v in pairs(types) do
                assert(info[k] ~= nil, "Did not return a table with a '" .. k .. "' field")
                assert(type(info[k]) == v, "Did not return a table with " .. k .. " as a " .. v .. " (got " .. type(info[k]) .. ")")
            end
        end)
        
        test("debug.getproto", {}, function()
            local function test_f()
                local function proto()
                    return true
                end
            end
            local proto = debug.getproto(test_f, 1, true)[1]
            local realproto = debug.getproto(test_f, 1)
            assert(proto, "Failed to get the inner function")
            assert(proto() == true, "The inner function did not return anything")
            if not realproto() then
                return "Proto return values are disabled on this executor"
            end
        end)
        
        test("debug.getprotos", {}, function()
            local function test_f()
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
            for i in ipairs(debug.getprotos(test_f)) do
                local proto = debug.getproto(test_f, i, true)[1]
                local realproto = debug.getproto(test_f, i)
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
            local function test_f()
                print(upvalue)
            end
            assert(debug.getupvalue(test_f, 1) == upvalue, "Unexpected value returned from debug.getupvalue")
        end)
        
        test("debug.getupvalues", {}, function()
            local upvalue = function() end
            local function test_f()
                print(upvalue)
            end
            local upvalues = debug.getupvalues(test_f)
            assert(upvalues[1] == upvalue, "Unexpected value returned from debug.getupvalues")
        end)
        
        test("debug.setconstant", {}, function()
            local function test_f()
                return "fail"
            end
            debug.setconstant(test_f, 1, "success")
            assert(test_f() == "success", "debug.setconstant did not set the first constant")
        end)
        
        test("debug.setstack", {}, function()
            local function test_f()
                return "fail", debug.setstack(1, 1, "success")
            end
            assert(test_f() == "success", "debug.setstack did not set the first stack item")
        end)
        
        test("debug.setupvalue", {}, function()
            local function upvalue()
                return "fail"
            end
            local function test_f()
                return upvalue()
            end
            debug.setupvalue(test_f, 1, function()
                return "success"
            end)
            assert(test_f() == "success", "debug.setupvalue did not set the first upvalue")
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
            local function test_f()
            end
            bindable.OnInvoke = test_f
            assert(getcallbackvalue(bindable, "OnInvoke") == test_f, "Did not return the correct value")
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
        test("getrawmetatable", {}, function()
            local metatable = { __metatable = "Locked!" }
            local object = setmetatable({}, metatable)
            assert(getrawmetatable(object) == metatable, "Did not return the metatable")
        end)
        
        test("hookmetamethod", {}, function()
            local object = setmetatable({}, { __index = newcclosure(function() return false end), __metatable = "Locked!" })
            local ref = hookmetamethod(object, "__index", function() return true end)
            assert(object.test == true, "Failed to hook a metamethod and change the return value")
            assert(ref() == false, "Did not return the original function")
        end)
        
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
        
        test("getgenv", {}, function()
            getgenv().__TEST_GLOBAL = true
            assert(__TEST_GLOBAL, "Failed to set a global variable")
            getgenv().__TEST_GLOBAL = nil
        end)
        
        test("getloadedmodules", {}, function()
            local modules = getloadedmodules()
            assert(type(modules) == "table", "Did not return a table")
            assert(#modules > 0, "Did not return a table with any values")
            assert(typeof(modules[1]) == "Instance", "First value is not an Instance")
            assert(modules[1]:IsA("ModuleScript"), "First value is not a ModuleScript")
        end)
        
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
                    task.wait() 
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

local success, errorMessage = hookedPcall(function() repeat task.wait() until game:IsLoaded() CallBuild() end)
if success then print("✅ Initialized Build!") else error("🚨 Build Call Failed 2 Initialize: "..tostring(errorMessage)) end