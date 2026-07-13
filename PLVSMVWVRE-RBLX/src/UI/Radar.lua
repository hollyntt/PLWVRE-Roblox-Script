-- Made by Blissful#4992
-- Restructured only to support dynamic loader settings and full cleanup

getgenv().RadarInfo = getgenv().RadarInfo or {
    Enabled = false,
    Position = Vector2.new(200, 200),
    Radius = 100,
    Scale = 1, -- Determinant factor on the effect of the relative position for the 2D integration
    RadarBack = Color3.fromRGB(10, 10, 10),
    RadarBorder = Color3.fromRGB(75, 75, 75),
    LocalPlayerDot = Color3.fromRGB(255, 255, 255),
    PlayerDot = Color3.fromRGB(60, 170, 255),
    Team = Color3.fromRGB(0, 255, 0),
    Enemy = Color3.fromRGB(255, 0, 0),
    Health_Color = true,
    Team_Check = true
}

local RadarInfo = getgenv().RadarInfo

local RadarConnections = {}
local RadarDrawings = {}

RadarInfo.Unload = function()
    local currentRadarInfo = getgenv().RadarInfo or RadarInfo
    currentRadarInfo.Enabled = false
    for _, conn in ipairs(RadarConnections) do
        pcall(function() conn:Disconnect() end)
    end
    for _, draw in ipairs(RadarDrawings) do
        pcall(function() draw:Remove() end)
    end
    table.clear(RadarConnections)
    table.clear(RadarDrawings)
end

----------------------------------------------------------------

local Players = game:service("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = game:service("Workspace").CurrentCamera
local RS = game:service("RunService")
local UIS = game:service("UserInputService")

repeat wait() until Player.Character ~= nil and Player.Character.PrimaryPart ~= nil

-- Robust HTTP wrapper to prevent failure if Pastebin is unreachable
local LerpColorModule
pcall(function()
    LerpColorModule = loadstring(game:HttpGet("https://pastebin.com/raw/wRnsJeid"))()
end)

local HealthBarLerp
if LerpColorModule and LerpColorModule.Lerp then
    HealthBarLerp = LerpColorModule:Lerp(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0))
else
    HealthBarLerp = function(percent)
        local ratio = math.clamp(percent, 0, 1)
        return Color3.fromRGB(255 * (1 - ratio), 255 * ratio, 0)
    end
end

local function NewCircle(Transparency, Color, Radius, Filled, Thickness)
    local c = Drawing.new("Circle")
    c.Transparency = Transparency
    c.Color = Color
    c.Visible = false
    c.Thickness = Thickness
    c.Position = Vector2.new(0, 0)
    c.Radius = Radius
    c.NumSides = math.clamp(Radius*55/100, 10, 75)
    c.Filled = Filled
    
    table.insert(RadarDrawings, c)
    return c
end

-- Sync initial visibility with current config settings to prevent pop-in flickers
local RadarBackground = NewCircle(0.9, RadarInfo.RadarBack, RadarInfo.Radius, true, 1)
RadarBackground.Visible = RadarInfo.Enabled or false
RadarBackground.Position = RadarInfo.Position

local RadarBorder = NewCircle(0.75, RadarInfo.RadarBorder, RadarInfo.Radius, false, 3)
RadarBorder.Visible = RadarInfo.Enabled or false
RadarBorder.Position = RadarInfo.Position

local function GetRelative(pos)
    local char = Player.Character
    if char ~= nil and char.PrimaryPart ~= nil then
        local pmpart = char.PrimaryPart
        local camerapos = Vector3.new(Camera.CFrame.Position.X, pmpart.Position.Y, Camera.CFrame.Position.Z)
        local newcf = CFrame.new(pmpart.Position, camerapos)
        local r = newcf:PointToObjectSpace(pos)
        return r.X, r.Z
    else
        return 0, 0
    end
end

local function PlaceDot(plr)
    local PlayerDot = NewCircle(1, RadarInfo.PlayerDot, 3, true, 1)

    local function Update()
        local c 
        c = game:service("RunService").RenderStepped:Connect(function()
            -- Read directly from getgenv() to stay updated if table is overwritten by Config Manager
            local activeRadarInfo = getgenv().RadarInfo or RadarInfo

            -- Handle global toggle
            if activeRadarInfo.Enabled == false then
                PlayerDot.Visible = false
                return
            end

            local char = plr.Character
            if char and char:FindFirstChildOfClass("Humanoid") and char.PrimaryPart ~= nil and char:FindFirstChildOfClass("Humanoid").Health > 0 then
                local hum = char:FindFirstChildOfClass("Humanoid")
                local scale = activeRadarInfo.Scale
                local relx, rely = GetRelative(char.PrimaryPart.Position)
                local newpos = activeRadarInfo.Position - Vector2.new(relx * scale, rely * scale) 
                
                if (newpos - activeRadarInfo.Position).magnitude < activeRadarInfo.Radius-2 then 
                    PlayerDot.Radius = 3   
                    PlayerDot.Position = newpos
                    PlayerDot.Visible = true
                else 
                    local dist = (activeRadarInfo.Position - newpos).magnitude
                    local calc = (activeRadarInfo.Position - newpos).unit * (dist - activeRadarInfo.Radius)
                    local inside = Vector2.new(newpos.X + calc.X, newpos.Y + calc.Y)
                    PlayerDot.Radius = 2
                    PlayerDot.Position = inside
                    PlayerDot.Visible = true
                end

                PlayerDot.Color = activeRadarInfo.PlayerDot
                if activeRadarInfo.Team_Check then
                    if plr.TeamColor == Player.TeamColor then
                        PlayerDot.Color = activeRadarInfo.Team
                    else
                        PlayerDot.Color = activeRadarInfo.Enemy
                    end
                end

                if activeRadarInfo.Health_Color then
                    PlayerDot.Color = HealthBarLerp(hum.Health / hum.MaxHealth)
                end
            else 
                PlayerDot.Visible = false
                if Players:FindFirstChild(plr.Name) == nil then
                    PlayerDot:Remove()
                    c:Disconnect()
                end
            end
        end)
        table.insert(RadarConnections, c)
    end
    coroutine.wrap(Update)()
end

for _,v in pairs(Players:GetChildren()) do
    if v.Name ~= Player.Name then
        PlaceDot(v)
    end
end

local function NewLocalDot()
    local d = Drawing.new("Triangle")
    d.Visible = RadarInfo.Enabled or false
    d.Thickness = 1
    d.Filled = true
    d.Color = RadarInfo.LocalPlayerDot
    d.PointA = RadarInfo.Position + Vector2.new(0, -6)
    d.PointB = RadarInfo.Position + Vector2.new(-3, 6)
    d.PointC = RadarInfo.Position + Vector2.new(3, 6)
    
    table.insert(RadarDrawings, d)
    return d
end

local LocalPlayerDot = NewLocalDot()

local playerAddedConn = Players.PlayerAdded:Connect(function(v)
    if v.Name ~= Player.Name then
        PlaceDot(v)
    end
    LocalPlayerDot:Remove()
    LocalPlayerDot = NewLocalDot()
end)
table.insert(RadarConnections, playerAddedConn)

-- Loop
coroutine.wrap(function()
    local c 
    c = game:service("RunService").RenderStepped:Connect(function()
        local activeRadarInfo = getgenv().RadarInfo or RadarInfo

        -- Handle global toggle
        if activeRadarInfo.Enabled == false then
            if LocalPlayerDot ~= nil then LocalPlayerDot.Visible = false end
            RadarBackground.Visible = false
            RadarBorder.Visible = false
            return
        else
            if LocalPlayerDot ~= nil then LocalPlayerDot.Visible = true end
            RadarBackground.Visible = true
            RadarBorder.Visible = true
        end

        if LocalPlayerDot ~= nil then
            LocalPlayerDot.Color = activeRadarInfo.LocalPlayerDot
            LocalPlayerDot.PointA = activeRadarInfo.Position + Vector2.new(0, -6)
            LocalPlayerDot.PointB = activeRadarInfo.Position + Vector2.new(-3, 6)
            LocalPlayerDot.PointC = activeRadarInfo.Position + Vector2.new(3, 6)
        end
        RadarBackground.Position = activeRadarInfo.Position
        RadarBackground.Radius = activeRadarInfo.Radius
        RadarBackground.Color = activeRadarInfo.RadarBack

        RadarBorder.Position = activeRadarInfo.Position
        RadarBorder.Radius = activeRadarInfo.Radius
        RadarBorder.Color = activeRadarInfo.RadarBorder
    end)
    table.insert(RadarConnections, c)
end)()

-- Draggable
local inset = game:service("GuiService"):GetGuiInset()

local dragging = false
local offset = Vector2.new(0, 0)
UIS.InputBegan:Connect(function(input)
    local activeRadarInfo = getgenv().RadarInfo or RadarInfo
    if activeRadarInfo.Enabled == false then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 and (Vector2.new(Mouse.X, Mouse.Y + inset.Y) - activeRadarInfo.Position).magnitude < activeRadarInfo.Radius then
        offset = activeRadarInfo.Position - Vector2.new(Mouse.X, Mouse.Y)
        dragging = true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

coroutine.wrap(function()
    local dot = NewCircle(1, Color3.fromRGB(255, 255, 255), 3, true, 1)
    local c 
    c = game:service("RunService").RenderStepped:Connect(function()
        local activeRadarInfo = getgenv().RadarInfo or RadarInfo
        if activeRadarInfo.Enabled == false then
            dot.Visible = false
            return
        end

        if (Vector2.new(Mouse.X, Mouse.Y + inset.Y) - activeRadarInfo.Position).magnitude < activeRadarInfo.Radius then
            dot.Position = Vector2.new(Mouse.X, Mouse.Y + inset.Y)
            dot.Visible = true
        else 
            dot.Visible = false
        end
        if dragging then
            activeRadarInfo.Position = Vector2.new(Mouse.X, Mouse.Y) + offset
        end
    end)
    table.insert(RadarConnections, c)
end)()