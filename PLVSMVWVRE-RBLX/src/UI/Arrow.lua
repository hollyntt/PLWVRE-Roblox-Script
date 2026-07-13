-- Blissful's Arrow ESP (Restructured for PLVSMVWVRE loader integration)

-- Clean up any existing instances of this script before starting a new one
if getgenv().ArrowSettings and getgenv().ArrowSettings.Cleanup then
    pcall(getgenv().ArrowSettings.Cleanup)
end

-- Export the configurations globally so the main script UI can manipulate them in real-time
local ArrowSettings = {
    Enabled = true,
    DistFromCenter = 80,
    TriangleHeight = 16,
    TriangleWidth = 16,
    TriangleFilled = true,
    TriangleTransparency = 0,
    TriangleThickness = 1,
    TriangleColor = Color3.fromRGB(255, 255, 255),
    AntiAliasing = false,
    
    TeamCheck = true,
    TeamColor = Color3.fromRGB(0, 255, 0),
    EnemyColor = Color3.fromRGB(255, 0, 0),
    UseTeamColor = true,
}
getgenv().ArrowSettings = ArrowSettings

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RS = game:GetService("RunService")

local V3 = Vector3.new
local V2 = Vector2.new
local CF = CFrame.new
local COS = math.cos
local SIN = math.sin
local RAD = math.rad
local DRAWING = Drawing.new
local CWRAP = coroutine.wrap
local ROUND = math.round

local function GetRelative(pos, char)
    if not char or not char:FindFirstChild("HumanoidRootPart") then return V2(0,0) end
    local rootP = char.PrimaryPart and char.PrimaryPart.Position or char:FindFirstChild("HumanoidRootPart").Position
    local camP = Camera.CFrame.Position
    local relative = CF(V3(rootP.X, camP.Y, rootP.Z), camP):PointToObjectSpace(pos)

    return V2(relative.X, relative.Z)
end

local function RelativeToCenter(v)
    return Camera.ViewportSize/2 - v
end

local function RotateVect(v, a)
    a = RAD(a)
    local x = v.x * COS(a) - v.y * SIN(a)
    local y = v.x * SIN(a) + v.y * COS(a)

    return V2(x, y)
end

local function AntiA(v)
    if (not ArrowSettings.AntiAliasing) then return v end
    return V2(ROUND(v.x), ROUND(v.y))
end

local Connections = {}
local RenderObjects = {}

local function ShowArrow(PLAYER)
    local Arrow = DRAWING("Triangle")
    Arrow.Visible = false
    table.insert(RenderObjects, Arrow)

    local connection
    connection = RS.RenderStepped:Connect(function()
        -- Handle Global Enable Toggle
        if not ArrowSettings.Enabled then
            Arrow.Visible = false
            return
        end

        if PLAYER and PLAYER.Character and Player.Character then
            local CHAR = PLAYER.Character
            local HUM = CHAR:FindFirstChildOfClass("Humanoid")

            if HUM and CHAR.PrimaryPart ~= nil and HUM.Health > 0 then
                -- Determine arrow color based on configuration
                local targetColor = ArrowSettings.TriangleColor
                if ArrowSettings.UseTeamColor then
                    if ArrowSettings.TeamCheck and PLAYER.Team == Player.Team then
                        targetColor = ArrowSettings.TeamColor
                    else
                        targetColor = ArrowSettings.EnemyColor
                    end
                end

                -- Sync styling settings
                Arrow.Color = targetColor
                Arrow.Filled = ArrowSettings.TriangleFilled
                Arrow.Thickness = ArrowSettings.TriangleThickness
                Arrow.Transparency = 1 - ArrowSettings.TriangleTransparency

                local _, vis = Camera:WorldToViewportPoint(CHAR.PrimaryPart.Position)
                if vis == false then
                    local rel = GetRelative(CHAR.PrimaryPart.Position, Player.Character)
                    local direction = rel.unit

                    local base  = direction * ArrowSettings.DistFromCenter
                    local sideLength = ArrowSettings.TriangleWidth / 2
                    local baseL = base + RotateVect(direction, 90) * sideLength
                    local baseR = base + RotateVect(direction, -90) * sideLength

                    local tip = direction * (ArrowSettings.DistFromCenter + ArrowSettings.TriangleHeight)
                    
                    Arrow.PointA = AntiA(RelativeToCenter(baseL))
                    Arrow.PointB = AntiA(RelativeToCenter(baseR))
                    Arrow.PointC = AntiA(RelativeToCenter(tip))

                    Arrow.Visible = true
                else 
                    Arrow.Visible = false 
                end
            else 
                Arrow.Visible = false 
            end
        else 
            Arrow.Visible = false

            if not PLAYER or not PLAYER.Parent then
                Arrow:Remove()
                connection:Disconnect()
            end
        end
    end)
    table.insert(Connections, connection)
end

-- Load for existing players
for _, v in ipairs(Players:GetPlayers()) do
    if v ~= Player then
        ShowArrow(v)
    end
end

-- Load for newly joined players
local playerAddedConn = Players.PlayerAdded:Connect(function(v)
    if v ~= Player then
        ShowArrow(v)
    end
end)
table.insert(Connections, playerAddedConn)

-- Cleanup handler to cleanly unload Arrow ESP
ArrowSettings.Cleanup = function()
    for _, conn in ipairs(Connections) do
        pcall(function() conn:Disconnect() end)
    end
    for _, obj in ipairs(RenderObjects) do
        pcall(function() obj:Remove() end)
    end
    Connections = {}
    RenderObjects = {}
end

return ArrowSettings