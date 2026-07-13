-- Blissful's Drawing-Based Player Radar (Restructured for PLVSMVWVRE loader integration)

-- Clean up any existing instances of this script before starting a new one
if getgenv().RadarSettings and getgenv().RadarSettings.Cleanup then
    pcall(getgenv().RadarSettings.Cleanup)
end

-- Export the configurations globally so the main script UI can manipulate them in real-time
local RadarSettings = {
    Enabled = true,
    Position = Vector2.new(200, 200),
    Radius = 100,
    Scale = 1.5, -- Factor determining relative map zoom/integration
    RadarBack = Color3.fromRGB(10, 10, 10),
    RadarBorder = Color3.fromRGB(75, 75, 75),
    RadarBackTransparency = 0.6,
    RadarBorderTransparency = 0.8,
    
    LocalPlayerDot = Color3.fromRGB(255, 255, 255),
    PlayerDot = Color3.fromRGB(60, 170, 255),
    
    TeamCheck = true,
    TeamColor = Color3.fromRGB(0, 255, 0),
    EnemyColor = Color3.fromRGB(255, 0, 0),
    UseTeamColor = true,
    ShowHealthColor = true, -- Color dots red/yellow/green based on target health
}
getgenv().RadarSettings = RadarSettings

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RS = game:GetService("RunService")

local V3 = Vector3.new
local V2 = Vector2.new
local CF = CFrame.new

-- Drawing helper function
local function NewCircle(transparency, color, radius, filled, thickness)
    local c = Drawing.new("Circle")
    c.Transparency = transparency
    c.Color = color
    c.Visible = false
    c.Thickness = thickness
    c.Radius = radius
    c.Filled = filled
    return c
end

-- Radar UI Components
local RadarBackground = NewCircle(RadarSettings.RadarBackTransparency, RadarSettings.RadarBack, RadarSettings.Radius, true, 1)
local RadarBorder = NewCircle(RadarSettings.RadarBorderTransparency, RadarSettings.RadarBorder, RadarSettings.Radius, false, 2)
local CenterDot = NewCircle(1, RadarSettings.LocalPlayerDot, 4, true, 1)

-- Optional crosshair overlay inside the radar window
local LineV = Drawing.new("Line")
LineV.Thickness = 1
LineV.Transparency = 0.3
LineV.Color = RadarSettings.RadarBorder

local LineH = Drawing.new("Line")
LineH.Thickness = 1
LineH.Transparency = 0.3
LineH.Color = RadarSettings.RadarBorder

local Connections = {}
local PlayerDots = {}

-- Clean up a player dot drawing object
local function RemovePlayerDot(player_obj)
    if PlayerDots[player_obj] then
        pcall(function() PlayerDots[player_obj]:Remove() end)
        PlayerDots[player_obj] = nil
    end
end

-- Track player relative positioning mathematically
local function GetRelative(pos, lpChar)
    if not lpChar or not lpChar:FindFirstChild("HumanoidRootPart") then return V2(0,0) end
    local rootP = lpChar:FindFirstChild("HumanoidRootPart").Position
    local camP = Camera.CFrame.Position
    local relative = CF(V3(rootP.X, camP.Y, rootP.Z), camP):PointToObjectSpace(pos)

    return V2(relative.X, relative.Z)
end

-- Lerp color helper to visually indicate player health
local function GetHealthColor(health, maxHealth)
    local ratio = math.clamp(health / maxHealth, 0, 1)
    return Color3.fromRGB(255 * (1 - ratio), 255 * ratio, 0)
end

-- Main render loop
local mainConnection
mainConnection = RS.RenderStepped:Connect(function()
    if not RadarSettings.Enabled then
        RadarBackground.Visible = false
        RadarBorder.Visible = false
        CenterDot.Visible = false
        LineV.Visible = false
        LineH.Visible = false
        for _, dot in pairs(PlayerDots) do
            dot.Visible = false
        end
        return
    end

    local lpChar = Player.Character
    if not lpChar or not lpChar:FindFirstChild("HumanoidRootPart") then
        RadarBackground.Visible = false
        RadarBorder.Visible = false
        CenterDot.Visible = false
        LineV.Visible = false
        LineH.Visible = false
        return
    end

    -- Update central background elements
    RadarBackground.Position = RadarSettings.Position
    RadarBackground.Radius = RadarSettings.Radius
    RadarBackground.Color = RadarSettings.RadarBack
    RadarBackground.Transparency = RadarSettings.RadarBackTransparency
    RadarBackground.Visible = true

    RadarBorder.Position = RadarSettings.Position
    RadarBorder.Radius = RadarSettings.Radius
    RadarBorder.Color = RadarSettings.RadarBorder
    RadarBorder.Transparency = RadarSettings.RadarBorderTransparency
    RadarBorder.Visible = true

    CenterDot.Position = RadarSettings.Position
    CenterDot.Color = RadarSettings.LocalPlayerDot
    CenterDot.Visible = true

    -- Update crosshair lines
    LineV.From = RadarSettings.Position - V2(0, RadarSettings.Radius)
    LineV.To = RadarSettings.Position + V2(0, RadarSettings.Radius)
    LineV.Color = RadarSettings.RadarBorder
    LineV.Visible = true

    LineH.From = RadarSettings.Position - V2(RadarSettings.Radius, 0)
    LineH.To = RadarSettings.Position + V2(RadarSettings.Radius, 0)
    LineH.Color = RadarSettings.RadarBorder
    LineH.Visible = true

    -- Update player dots on the radar
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= Player then
            local otherChar = otherPlayer.Character
            if otherChar and otherChar:FindFirstChild("HumanoidRootPart") and otherChar:FindFirstChildOfClass("Humanoid") then
                local hum = otherChar:FindFirstChildOfClass("Humanoid")
                if hum.Health > 0 then
                    local relative = GetRelative(otherChar.HumanoidRootPart.Position, lpChar)
                    
                    -- relative.X is right (+), relative.Z is forward (- in Object Space)
                    local xOffset = relative.X * RadarSettings.Scale
                    local zOffset = relative.Z * RadarSettings.Scale -- negative means forward, moving it UP on screen

                    local distance = math.sqrt(xOffset^2 + zOffset^2)

                    -- Render dot if inside the circular Radar bounds
                    if distance <= RadarSettings.Radius then
                        if not PlayerDots[otherPlayer] then
                            PlayerDots[otherPlayer] = NewCircle(1, RadarSettings.PlayerDot, 4, true, 1)
                        end

                        local dot = PlayerDots[otherPlayer]
                        dot.Position = RadarSettings.Position + V2(xOffset, zOffset)
                        
                        -- Determine dot coloring logic
                        if RadarSettings.ShowHealthColor then
                            dot.Color = GetHealthColor(hum.Health, hum.MaxHealth)
                        elseif RadarSettings.UseTeamColor then
                            if RadarSettings.TeamCheck and otherPlayer.Team == Player.Team then
                                dot.Color = RadarSettings.TeamColor
                            else
                                dot.Color = RadarSettings.EnemyColor
                            end
                        else
                            dot.Color = RadarSettings.PlayerDot
                        end

                        dot.Visible = true
                    else
                        if PlayerDots[otherPlayer] then
                            PlayerDots[otherPlayer].Visible = false
                        end
                    end
                else
                    if PlayerDots[otherPlayer] then
                        PlayerDots[otherPlayer].Visible = false
                    end
                end
            else
                if PlayerDots[otherPlayer] then
                    PlayerDots[otherPlayer].Visible = false
                end
            end
        end
    end
end)
table.insert(Connections, mainConnection)

-- Clean up player elements as they leave
local playerRemovingConn = Players.PlayerRemoving:Connect(function(oldPlayer)
    RemovePlayerDot(oldPlayer)
end)
table.insert(Connections, playerRemovingConn)

-- Cleanup handler to cleanly unload Radar
RadarSettings.Cleanup = function()
    for _, conn in ipairs(Connections) do
        pcall(function() conn:Disconnect() end)
    end
    pcall(function() RadarBackground:Remove() end)
    pcall(function() RadarBorder:Remove() end)
    pcall(function() CenterDot:Remove() end)
    pcall(function() LineV:Remove() end)
    pcall(function() LineH:Remove() end)
    for _, dot in pairs(PlayerDots) do
        pcall(function() dot:Remove() end)
    end
    Connections = {}
    PlayerDots = {}
end

return RadarSettings