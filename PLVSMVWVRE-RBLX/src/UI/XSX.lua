--[[
  UI lib made by bungie#0001
  
  - Please do not use this without permission, I am working really hard on this UI to make it perfect and do not have a big 
    problem with other people using it, please just make sure you message me and ask me before using.
]]

-- / Locals
local Workspace = game:GetService("Workspace")
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

-- / Services
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGuiService = game:GetService("CoreGui")
local ContentService = game:GetService("ContentProvider")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- / Tween table & function
local TweenTable = {
    Default = {
        TweenInfo.new(0.17, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)
    }
}
local CreateTween = function(name, speed, style, direction, loop, reverse, delay)
    name = name
    speed = speed or 0.17
    style = style or Enum.EasingStyle.Sine
    direction = direction or Enum.EasingDirection.InOut
    loop = loop or 0
    reverse = reverse or false
    delay = delay or 0

    TweenTable[name] = TweenInfo.new(speed, style, direction, loop, reverse, delay)
end

-- / Dragging
local drag = function(obj, latency)
    obj = obj
    latency = latency or 0.06

    toggled = nil
    input = nil
    start = nil

    function updateInput(input)
        local Delta = input.Position - start
        local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        TweenService:Create(obj, TweenInfo.new(latency), {Position = Position}):Play()
    end

    obj.InputBegan:Connect(function(inp)
        if (inp.UserInputType == Enum.UserInputType.MouseButton1) then
            toggled = true
            start = inp.Position
            startPos = obj.Position
            inp.Changed:Connect(function()
                if (inp.UserInputState == Enum.UserInputState.End) then
                    toggled = false
                end
            end)
        end
    end)

    obj.InputChanged:Connect(function(inp)
        if (inp.UserInputType == Enum.UserInputType.MouseMovement) then
            input = inp
        end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if (inp == input and toggled) then
            updateInput(inp)
        end
    end)
end

local library = {
    version = "2.0.2",
    title = title or "PLVSMVWVRE " .. tostring(math.random(1,366)),
    fps = 0,
    rank = "private",
    Flags = {},
    ConfigFolder = "PLVSMVWVRE V2"
}

coroutine.wrap(function()
    RunService.RenderStepped:Connect(function(v)
        library.fps =  math.round(1/v)
    end)
end)()

function library:RoundNumber(int, float)
    return tonumber(string.format("%." .. (int or 0) .. "f", float))
end

function library:GetUsername()
    return Player.Name
end

function library:CheckIfLoaded()
    if game:IsLoaded() then
        return true
    else
        return false
    end
end

function library:GetUserId()
    return Player.UserId
end

function library:GetPlaceId()
    return game.PlaceId
end

function library:GetJobId()
    return game.JobId
end

function library:Rejoin()
    TeleportService:TeleportToPlaceInstance(library:GetPlaceId(), library:GetJobId(), library:GetUserId())
end

function library:Copy(input) -- only works with synapse
    if syn then
        syn.write_clipboard(input)
    end
end

function library:GetDay(type)
    if type == "word" then -- day in a full word
        return os.date("%A")
    elseif type == "short" then -- day in a shortened word
        return os.date("%a")
    elseif type == "month" then -- day of the month in digits
        return os.date("%d")
    elseif type == "year" then -- day of the year in digits
        return os.date("%j")
    end
end

function library:GetTime(type)
    if type == "24h" then -- time using a 24 hour clock
        return os.date("%H")
    elseif type == "12h" then -- time using a 12 hour clock
        return os.date("%I")
    elseif type == "minute" then -- time in minutes
        return os.date("%M")
    elseif type == "half" then -- what part of the day it is (AM or PM)
        return os.date("%p")
    elseif type == "second" then -- time in seconds
        return os.date("%S")
    elseif type == "full" then -- full time
        return os.date("%X")
    elseif type == "ISO" then -- ISO / UTC ( 1min = 1, 1hour = 100)
        return os.date("%z")
    elseif type == "zone" then -- time zone
        return os.date("%Z") 
    end
end

function library:GetMonth(type)
    if type == "word" then -- full month name
        return os.date("%B")
    elseif type == "short" then -- month in shortened word
        return os.date("%b")
    elseif type == "digit" then -- the months digit
        return os.date("%m")
    end
end

function library:GetWeek(type)
    if type == "year_S" then -- the number of the week in the current year (sunday first day)
        return os.date("%U")
    elseif type == "day" then -- the week day
        return os.date("%w")
    elseif type == "year_M" then -- the number of the week in the current year (monday first day)
        return os.date("%W")
    end
end

function library:GetYear(type)
    if type == "digits" then -- the second 2 digits of the year
        return os.date("%y")
    elseif type == "full" then -- the full year
        return os.date("%Y")
    end
end

function library:UnlockFps(new) -- syn only
    if syn then
        setfpscap(new)
    end
end

function library:Watermark(text)
    for i,v in pairs(CoreGuiService:GetChildren()) do
        if v.Name == "watermark" then
            v:Destroy()
        end
    end

    tetx = text or "PLVSMVWVRE v2"

    local watermark = Instance.new("ScreenGui")
    local watermarkPadding = Instance.new("UIPadding")
    local watermarkLayout = Instance.new("UIListLayout")
    local edge = Instance.new("Frame")
    local edgeCorner = Instance.new("UICorner")
    local background = Instance.new("Frame")
    local barFolder = Instance.new("Folder")
    local bar = Instance.new("Frame")
    local barCorner = Instance.new("UICorner")
    local barLayout = Instance.new("UIListLayout")
    local backgroundGradient = Instance.new("UIGradient")
    local backgroundCorner = Instance.new("UICorner")
    local waterText = Instance.new("TextLabel")
    local waterPadding = Instance.new("UIPadding")
    local backgroundLayout = Instance.new("UIListLayout")

    watermark.Name = "watermark"
    watermark.Parent = CoreGuiService
    watermark.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    watermarkLayout.Name = "watermarkLayout"
    watermarkLayout.Parent = watermark
    watermarkLayout.FillDirection = Enum.FillDirection.Horizontal
    watermarkLayout.SortOrder = Enum.SortOrder.LayoutOrder
    watermarkLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    watermarkLayout.Padding = UDim.new(0, 4)
    
    watermarkPadding.Name = "watermarkPadding"
    watermarkPadding.Parent = watermark
    watermarkPadding.PaddingBottom = UDim.new(0, 6)
    watermarkPadding.PaddingLeft = UDim.new(0, 6)

    edge.Name = "edge"
    edge.Parent = watermark
    edge.AnchorPoint = Vector2.new(0.5, 0.5)
    edge.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    edge.Position = UDim2.new(0.5, 0, -0.03, 0)
    edge.Size = UDim2.new(0, 0, 0, 26)
    edge.BackgroundTransparency = 1

    edgeCorner.CornerRadius = UDim.new(0, 2)
    edgeCorner.Name = "edgeCorner"
    edgeCorner.Parent = edge

    background.Name = "background"
    background.Parent = edge
    background.AnchorPoint = Vector2.new(0.5, 0.5)
    background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    background.BackgroundTransparency = 1
    background.ClipsDescendants = true
    background.Position = UDim2.new(0.5, 0, 0.5, 0)
    background.Size = UDim2.new(0, 0, 0, 24)

    barFolder.Name = "barFolder"
    barFolder.Parent = background

    bar.Name = "bar"
    bar.Parent = barFolder
    bar.BackgroundColor3 = Color3.fromRGB(159, 115, 255)
    bar.BackgroundTransparency = 0
    bar.Size = UDim2.new(0, 0, 0, 1)

    barCorner.CornerRadius = UDim.new(0, 2)
    barCorner.Name = "barCorner"
    barCorner.Parent = bar

    barLayout.Name = "barLayout"
    barLayout.Parent = barFolder
    barLayout.SortOrder = Enum.SortOrder.LayoutOrder

    backgroundGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
    backgroundGradient.Rotation = 90
    backgroundGradient.Name = "backgroundGradient"
    backgroundGradient.Parent = background

    backgroundCorner.CornerRadius = UDim.new(0, 2)
    backgroundCorner.Name = "backgroundCorner"
    backgroundCorner.Parent = background

    waterText.Name = "notifText"
    waterText.Parent = background
    waterText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    waterText.BackgroundTransparency = 1.000
    waterText.Position = UDim2.new(0, 0, -0.0416666679, 0)
    waterText.Size = UDim2.new(0, 0, 0, 24)
    waterText.Font = Enum.Font.Code
    waterText.Text = text
    waterText.TextColor3 = Color3.fromRGB(198, 198, 198)
    waterText.TextTransparency = 1
    waterText.TextSize = 14.000
    waterText.RichText = true

    local NewSize = TextService:GetTextSize(waterText.Text, waterText.TextSize, waterText.Font, Vector2.new(math.huge, math.huge))
    waterText.Size = UDim2.new(0, NewSize.X + 8, 0, 24)

    waterPadding.Name = "notifPadding"
    waterPadding.Parent = waterText
    waterPadding.PaddingBottom = UDim.new(0, 4)
    waterPadding.PaddingLeft = UDim.new(0, 4)
    waterPadding.PaddingRight = UDim.new(0, 4)
    waterPadding.PaddingTop = UDim.new(0, 4)

    backgroundLayout.Name = "backgroundLayout"
    backgroundLayout.Parent = background
    backgroundLayout.SortOrder = Enum.SortOrder.LayoutOrder
    backgroundLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    CreateTween("wm", 0.24)
    CreateTween("wm_2", 0.04)
    coroutine.wrap(function()
        TweenService:Create(edge, TweenTable["wm"], {BackgroundTransparency = 0}):Play()
        TweenService:Create(edge, TweenTable["wm"], {Size = UDim2.new(0, NewSize.x + 10, 0, 26)}):Play()
        TweenService:Create(background, TweenTable["wm"], {BackgroundTransparency = 0}):Play()
        TweenService:Create(background, TweenTable["wm"], {Size = UDim2.new(0, NewSize.x + 8, 0, 24)}):Play()
        wait(.2)
        TweenService:Create(bar, TweenTable["wm"], {Size = UDim2.new(0, NewSize.x + 8, 0, 1)}):Play()
        wait(.1)
        TweenService:Create(waterText, TweenTable["wm"], {TextTransparency = 0}):Play()
    end)()

    local WatermarkFunctions = {}
    function WatermarkFunctions:AddWatermark(text)
        tetx = text or "PLVSMVWVRE v2"

        local edge = Instance.new("Frame")
        local edgeCorner = Instance.new("UICorner")
        local background = Instance.new("Frame")
        local barFolder = Instance.new("Folder")
        local bar = Instance.new("Frame")
        local barCorner = Instance.new("UICorner")
        local barLayout = Instance.new("UIListLayout")
        local backgroundGradient = Instance.new("UIGradient")
        local backgroundCorner = Instance.new("UICorner")
        local waterText = Instance.new("TextLabel")
        local waterPadding = Instance.new("UIPadding")
        local backgroundLayout = Instance.new("UIListLayout")
    
        edge.Name = "edge"
        edge.Parent = watermark
        edge.AnchorPoint = Vector2.new(0.5, 0.5)
        edge.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        edge.Position = UDim2.new(0.5, 0, -0.03, 0)
        edge.Size = UDim2.new(0, 0, 0, 26)
        edge.BackgroundTransparency = 1
    
        edgeCorner.CornerRadius = UDim.new(0, 2)
        edgeCorner.Name = "edgeCorner"
        edgeCorner.Parent = edge
    
        background.Name = "background"
        background.Parent = edge
        background.AnchorPoint = Vector2.new(0.5, 0.5)
        background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        background.BackgroundTransparency = 1
        background.ClipsDescendants = true
        background.Position = UDim2.new(0.5, 0, 0.5, 0)
        background.Size = UDim2.new(0, 0, 0, 24)
    
        barFolder.Name = "barFolder"
        barFolder.Parent = background
    
        bar.Name = "bar"
        bar.Parent = barFolder
        bar.BackgroundColor3 = Color3.fromRGB(159, 115, 255)
        bar.BackgroundTransparency = 0
        bar.Size = UDim2.new(0, 0, 0, 1)
    
        barCorner.CornerRadius = UDim.new(0, 2)
        barCorner.Name = "barCorner"
        barCorner.Parent = bar
    
        barLayout.Name = "barLayout"
        barLayout.Parent = barFolder
        barLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
        backgroundGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
        backgroundGradient.Rotation = 90
        backgroundGradient.Name = "backgroundGradient"
        backgroundGradient.Parent = background
    
        backgroundCorner.CornerRadius = UDim.new(0, 2)
        backgroundCorner.Name = "backgroundCorner"
        backgroundCorner.Parent = background
    
        waterText.Name = "notifText"
        waterText.Parent = background
        waterText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        waterText.BackgroundTransparency = 1.000
        waterText.Position = UDim2.new(0, 0, -0.0416666679, 0)
        waterText.Size = UDim2.new(0, 0, 0, 24)
        waterText.Font = Enum.Font.Code
        waterText.Text = text
        waterText.TextColor3 = Color3.fromRGB(198, 198, 198)
        waterText.TextTransparency = 1
        waterText.TextSize = 14.000
        waterText.RichText = true
    
        local NewSize = TextService:GetTextSize(waterText.Text, waterText.TextSize, waterText.Font, Vector2.new(math.huge, math.huge))
        waterText.Size = UDim2.new(0, NewSize.X + 8, 0, 24)
    
        waterPadding.Name = "notifPadding"
        waterPadding.Parent = waterText
        waterPadding.PaddingBottom = UDim.new(0, 4)
        waterPadding.PaddingLeft = UDim.new(0, 4)
        waterPadding.PaddingRight = UDim.new(0, 4)
        waterPadding.PaddingTop = UDim.new(0, 4)
    
        backgroundLayout.Name = "backgroundLayout"
        backgroundLayout.Parent = background
        backgroundLayout.SortOrder = Enum.SortOrder.LayoutOrder
        backgroundLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    
        coroutine.wrap(function()
            TweenService:Create(edge, TweenTable["wm"], {BackgroundTransparency = 0}):Play()
            TweenService:Create(edge, TweenTable["wm"], {Size = UDim2.new(0, NewSize.x + 10, 0, 26)}):Play()
            TweenService:Create(background, TweenTable["wm"], {BackgroundTransparency = 0}):Play()
            TweenService:Create(background, TweenTable["wm"], {Size = UDim2.new(0, NewSize.x + 8, 0, 24)}):Play()
            wait(.2)
            TweenService:Create(bar, TweenTable["wm"], {Size = UDim2.new(0, NewSize.x + 8, 0, 1)}):Play()
            wait(.1)
            TweenService:Create(waterText, TweenTable["wm"], {TextTransparency = 0}):Play()
        end)()

        local NewWatermarkFunctions = {}
        function NewWatermarkFunctions:Hide()
            edge.Visible = false
            return NewWatermarkFunctions
        end
        --
        function NewWatermarkFunctions:Show()
            edge.Visible = true
            return NewWatermarkFunctions
        end
        --
        function NewWatermarkFunctions:Text(new)
            new = new or text
            waterText.Text = new
    
            local NewSize = TextService:GetTextSize(waterText.Text, waterText.TextSize, waterText.Font, Vector2.new(math.huge, math.huge))
            waterText.Size = UDim2.new(0, NewSize.X + 8, 0, 24)
            coroutine.wrap(function()
                TweenService:Create(edge, TweenTable["wm_2"], {Size = UDim2.new(0, NewSize.x + 10, 0, 26)}):Play()
                TweenService:Create(background, TweenTable["wm_2"], {Size = UDim2.new(0, NewSize.x + 8, 0, 24)}):Play()
                TweenService:Create(bar, TweenTable["wm_2"], {Size = UDim2.new(0, NewSize.x + 8, 0, 1)}):Play()
                TweenService:Create(waterText, TweenTable["wm_2"], {Size = UDim2.new(0, NewSize.x + 8, 0, 1)}):Play()
            end)()
    
            return NewWatermarkFunctions
        end
        --
        function NewWatermarkFunctions:Remove()
            Watermark:Destroy()
            return NewWatermarkFunctions
        end
        return NewWatermarkFunctions
    end

    function WatermarkFunctions:Hide()
        edge.Visible = false
        return WatermarkFunctions
    end
    --
    function WatermarkFunctions:Show()
        edge.Visible = true
        return WatermarkFunctions
    end
    --
    function WatermarkFunctions:Text(new)
        new = new or text
        waterText.Text = new

        local NewSize = TextService:GetTextSize(waterText.Text, waterText.TextSize, waterText.Font, Vector2.new(math.huge, math.huge))
        coroutine.wrap(function()
            TweenService:Create(edge, TweenTable["wm_2"], {Size = UDim2.new(0, NewSize.x + 10, 0, 26)}):Play()
            TweenService:Create(background, TweenTable["wm_2"], {Size = UDim2.new(0, NewSize.x + 8, 0, 24)}):Play()
            TweenService:Create(bar, TweenTable["wm_2"], {Size = UDim2.new(0, NewSize.x + 8, 0, 1)}):Play()
            TweenService:Create(waterText, TweenTable["wm_2"], {Size = UDim2.new(0, NewSize.x + 8, 0, 1)}):Play()
        end)()

        return WatermarkFunctions
    end
    --
    function WatermarkFunctions:Remove()
        Watermark:Destroy()
        return WatermarkFunctions
    end
    return WatermarkFunctions
end

function library:InitNotifications(text, duration, callback)
    for i,v in next, CoreGuiService:GetChildren() do
        if v.name == "Notifications" then
            v:Destroy()
        end
    end

    local Notifications = Instance.new("ScreenGui")
    local notificationsLayout = Instance.new("UIListLayout")
    local notificationsPadding = Instance.new("UIPadding")

    Notifications.Name = "Notifications"
    Notifications.Parent = CoreGuiService
    Notifications.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    notificationsLayout.Name = "notificationsLayout"
    notificationsLayout.Parent = Notifications
    notificationsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    notificationsLayout.Padding = UDim.new(0, 4)

    notificationsPadding.Name = "notificationsPadding"
    notificationsPadding.Parent = Notifications
    notificationsPadding.PaddingLeft = UDim.new(0, 6)
    notificationsPadding.PaddingTop = UDim.new(0, 18)

    local Notification = {}
    function Notification:Notify(text, duration, type, callback)
        
        CreateTween("notification_load", 0.2)

        text = text or "please wait."
        duration = duration or 5
        type = type or "notification"
        callback = callback or function() end

        local edge = Instance.new("Frame")
        local edgeCorner = Instance.new("UICorner")
        local background = Instance.new("Frame")
        local barFolder = Instance.new("Folder")
        local bar = Instance.new("Frame")
        local barCorner = Instance.new("UICorner")
        local barLayout = Instance.new("UIListLayout")
        local backgroundGradient = Instance.new("UIGradient")
        local backgroundCorner = Instance.new("UICorner")
        local notifText = Instance.new("TextLabel")
        local notifPadding = Instance.new("UIPadding")
        local backgroundLayout = Instance.new("UIListLayout")
    
        edge.Name = "edge"
        edge.Parent = Notifications
        edge.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        edge.BackgroundTransparency = 1.000
        edge.Size = UDim2.new(0, 0, 0, 26)
    
        edgeCorner.CornerRadius = UDim.new(0, 2)
        edgeCorner.Name = "edgeCorner"
        edgeCorner.Parent = edge
    
        background.Name = "background"
        background.Parent = edge
        background.AnchorPoint = Vector2.new(0.5, 0.5)
        background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        background.BackgroundTransparency = 1.000
        background.ClipsDescendants = true
        background.Position = UDim2.new(0.5, 0, 0.5, 0)
        background.Size = UDim2.new(0, 0, 0, 24)
    
        barFolder.Name = "barFolder"
        barFolder.Parent = background
    
        bar.Name = "bar"
        bar.Parent = barFolder
        bar.BackgroundColor3 = Color3.fromRGB(159, 115, 255)
        bar.BackgroundTransparency = 0.200
        bar.Size = UDim2.new(0, 0, 0, 1)
        if type == "notification" then
            bar.BackgroundColor3 = Color3.fromRGB(159, 115, 255)
        elseif type == "alert" then
            bar.BackgroundColor3 = Color3.fromRGB(255, 246, 112)
        elseif type == "error" then
            bar.BackgroundColor3 = Color3.fromRGB(255, 74, 77)
        elseif type == "success" then
            bar.BackgroundColor3 = Color3.fromRGB(131, 255, 103)
        elseif type == "information" then
            bar.BackgroundColor3 = Color3.fromRGB(126, 117, 255)
        end
    
        barCorner.CornerRadius = UDim.new(0, 2)
        barCorner.Name = "barCorner"
        barCorner.Parent = bar
    
        barLayout.Name = "barLayout"
        barLayout.Parent = barFolder
        barLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
        backgroundGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
        backgroundGradient.Rotation = 90
        backgroundGradient.Name = "backgroundGradient"
        backgroundGradient.Parent = background
    
        backgroundCorner.CornerRadius = UDim.new(0, 2)
        backgroundCorner.Name = "backgroundCorner"
        backgroundCorner.Parent = background
    
        notifText.Name = "notifText"
        notifText.Parent = background
        notifText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        notifText.BackgroundTransparency = 1.000
        notifText.Size = UDim2.new(0, 230, 0, 26)
        notifText.Font = Enum.Font.Code
        notifText.Text = text
        notifText.TextColor3 = Color3.fromRGB(198, 198, 198)
        notifText.TextSize = 14.000
        notifText.TextTransparency = 1.000
        notifText.TextXAlignment = Enum.TextXAlignment.Left
        notifText.RichText = true
    
        notifPadding.Name = "notifPadding"
        notifPadding.Parent = notifText
        notifPadding.PaddingBottom = UDim.new(0, 4)
        notifPadding.PaddingLeft = UDim.new(0, 4)
        notifPadding.PaddingRight = UDim.new(0, 4)
        notifPadding.PaddingTop = UDim.new(0, 4)
    
        backgroundLayout.Name = "backgroundLayout"
        backgroundLayout.Parent = background
        backgroundLayout.SortOrder = Enum.SortOrder.LayoutOrder
        backgroundLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    
        local NewSize = TextService:GetTextSize(notifText.Text, notifText.TextSize, notifText.Font, Vector2.new(math.huge, math.huge))
        CreateTween("notification_wait", duration, Enum.EasingStyle.Quad)
        local IsRunning = false
        coroutine.wrap(function()
            IsRunning = true
            TweenService:Create(edge, TweenTable["notification_load"], {BackgroundTransparency = 0}):Play()
            TweenService:Create(background, TweenTable["notification_load"], {BackgroundTransparency = 0}):Play()
            TweenService:Create(notifText, TweenTable["notification_load"], {TextTransparency = 0}):Play()
            TweenService:Create(edge, TweenTable["notification_load"], {Size = UDim2.new(0, NewSize.X + 10, 0, 26)}):Play()
            TweenService:Create(background, TweenTable["notification_load"], {Size = UDim2.new(0, NewSize.X + 8, 0, 24)}):Play()
            TweenService:Create(notifText, TweenTable["notification_load"], {Size = UDim2.new(0, NewSize.X + 8, 0, 24)}):Play()
            wait()
            TweenService:Create(bar, TweenTable["notification_wait"], {Size = UDim2.new(0, NewSize.X + 8, 0, 1)}):Play()
            repeat wait() until bar.Size == UDim2.new(0, NewSize.X + 8, 0, 1)
            IsRunning = false
            TweenService:Create(edge, TweenTable["notification_load"], {BackgroundTransparency = 1}):Play()
            TweenService:Create(background, TweenTable["notification_load"], {BackgroundTransparency = 1}):Play()
            TweenService:Create(notifText, TweenTable["notification_load"], {TextTransparency = 1}):Play()
            TweenService:Create(bar, TweenTable["notification_load"], {BackgroundTransparency = 1}):Play()
            TweenService:Create(edge, TweenTable["notification_load"], {Size = UDim2.new(0, 0, 0, 26)}):Play()
            TweenService:Create(background, TweenTable["notification_load"], {Size = UDim2.new(0, 0, 0, 24)}):Play()
            TweenService:Create(notifText, TweenTable["notification_load"], {Size = UDim2.new(0, 0, 0, 24)}):Play()
            TweenService:Create(bar, TweenTable["notification_load"], {Size = UDim2.new(0, 0, 0, 1)}):Play()
            wait(.2)
            edge:Destroy()
        end)()

        CreateTween("notification_reset", 0.4)
        local NotificationFunctions = {}
        function NotificationFunctions:Text(new)
            new = new or text
            notifText.Text = new

            NewSize = TextService:GetTextSize(notifText.Text, notifText.TextSize, notifText.Font, Vector2.new(math.huge, math.huge))
            local NewSize_2 = NewSize
            if IsRunning then
                TweenService:Create(edge, TweenTable["notification_load"], {Size = UDim2.new(0, NewSize.X + 10, 0, 26)}):Play()
                TweenService:Create(background, TweenTable["notification_load"], {Size = UDim2.new(0, NewSize.X + 8, 0, 24)}):Play()
                TweenService:Create(notifText, TweenTable["notification_load"], {Size = UDim2.new(0, NewSize.X + 8, 0, 24)}):Play()
                wait()
                TweenService:Create(bar, TweenTable["notification_reset"], {Size = UDim2.new(0, 0, 0, 1)}):Play()
                wait(.4)
                TweenService:Create(bar, TweenTable["notification_wait"], {Size = UDim2.new(0, NewSize.X + 8, 0, 1)}):Play()
            end

            return NotificationFunctions
        end
        return NotificationFunctions
    end
    return Notification
end

function library:Introduction()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://3101925304" 
    sound.Volume = 1 
    sound.Pitch = 0.5
    sound.Looped = false 
    sound.Parent = workspace 
    sound:Play()

    for _,v in next, CoreGuiService:GetChildren() do
        if v.Name == "screen" then
            v:Destroy()
        end
    end

    CreateTween("introduction",0.175)
    local introduction = Instance.new("ScreenGui")
    local edge = Instance.new("Frame")
    local edgeCorner = Instance.new("UICorner")
    local background = Instance.new("Frame")
    local backgroundGradient = Instance.new("UIGradient")
    local backgroundCorner = Instance.new("UICorner")
    local barFolder = Instance.new("Folder")
    local bar = Instance.new("Frame")
    local barCorner = Instance.new("UICorner")
    local barLayout = Instance.new("UIListLayout")
    local PLVSMVWVRELogo = Instance.new("ImageLabel")
    local hashLogo = Instance.new("ImageLabel")
    local PLVSMVWVRE = Instance.new("TextLabel")
    local text = Instance.new("TextLabel")
    local pageLayout = Instance.new("UIListLayout")
    
    introduction.Name = "introduction"
    introduction.Parent = CoreGuiService
    introduction.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    edge.Name = "edge"
    edge.Parent = introduction
    edge.AnchorPoint = Vector2.new(0.5, 0.5)
    edge.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    edge.BackgroundTransparency = 1
    edge.Position = UDim2.new(0.511773348, 0, 0.5, 0)
    edge.Size = UDim2.new(0, 300, 0, 308)
    
    edgeCorner.CornerRadius = UDim.new(0, 2)
    edgeCorner.Name = "edgeCorner"
    edgeCorner.Parent = edge
    
    background.Name = "background"
    background.Parent = edge
    background.AnchorPoint = Vector2.new(0.5, 0.5)
    background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    background.BackgroundTransparency = 1
    background.ClipsDescendants = true
    background.Position = UDim2.new(0.5, 0, 0.5, 0)
    background.Size = UDim2.new(0, 298, 0, 306)
    
    backgroundGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
    backgroundGradient.Rotation = 90
    backgroundGradient.Name = "backgroundGradient"
    backgroundGradient.Parent = background
    
    backgroundCorner.CornerRadius = UDim.new(0, 2)
    backgroundCorner.Name = "backgroundCorner"
    backgroundCorner.Parent = background
    
    barFolder.Name = "barFolder"
    barFolder.Parent = background
    
    bar.Name = "bar"
    bar.Parent = barFolder
    bar.BackgroundColor3 = Color3.fromRGB(159, 115, 255)
    bar.BackgroundTransparency = 0.200
    bar.Size = UDim2.new(0, 0, 0, 1)
    
    barCorner.CornerRadius = UDim.new(0, 2)
    barCorner.Name = "barCorner"
    barCorner.Parent = bar
    
    barLayout.Name = "barLayout"
    barLayout.Parent = barFolder
    barLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    barLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    PLVSMVWVRELogo.Name = "PLVSMVWVRELogo"
    PLVSMVWVRELogo.Parent = background
    PLVSMVWVRELogo.AnchorPoint = Vector2.new(0.5, 0.5)
    PLVSMVWVRELogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PLVSMVWVRELogo.BackgroundTransparency = 1.000
    PLVSMVWVRELogo.Position = UDim2.new(0.5, 0, 0.5, 0)
    PLVSMVWVRELogo.Size = UDim2.new(0, 448, 0, 150)
    PLVSMVWVRELogo.Visible = true
    PLVSMVWVRELogo.Image = "http://www.roblox.com/asset/?id=9365068051"
    PLVSMVWVRELogo.ImageColor3 = Color3.fromRGB(159, 115, 255)
    PLVSMVWVRELogo.ImageTransparency = 1
    
    hashLogo.Name = "hashLogo"
    hashLogo.Parent = background
    hashLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    hashLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hashLogo.BackgroundTransparency = 1.000
    hashLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
    hashLogo.Size = UDim2.new(0, 150, 0, 150)
    hashLogo.Visible = true
    hashLogo.Image = "http://www.roblox.com/asset/?id=9365069861"
    hashLogo.ImageColor3 = Color3.fromRGB(159, 115, 255)
    hashLogo.ImageTransparency = 1
    
    PLVSMVWVRE.Name = "PLVSMVWVRE"
    PLVSMVWVRE.Parent = background
    PLVSMVWVRE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PLVSMVWVRE.BackgroundTransparency = 1.000
    PLVSMVWVRE.Size = UDim2.new(0, 80, 0, 21)
    PLVSMVWVRE.Font = Enum.Font.Code
    PLVSMVWVRE.Text = "powered by PLVSMVWVRE"
    PLVSMVWVRE.TextColor3 = Color3.fromRGB(124, 124, 124)
    PLVSMVWVRE.TextSize = 10.000
    PLVSMVWVRE.TextTransparency = 1
    
    text.Name = "text"
    text.Parent = background
    text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    text.BackgroundTransparency = 1.000
    text.Position = UDim2.new(0.912751675, 0, 0, 0)
    text.Size = UDim2.new(0, 26, 0, 21)
    text.Font = Enum.Font.Code
    text.Text = "hash"
    text.TextColor3 = Color3.fromRGB(124, 124, 124)
    text.TextSize = 10.000
    text.TextTransparency = 1
    text.RichText = true
    
    pageLayout.Name = "pageLayout"
    pageLayout.Parent = introduction
    pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    CreateTween("PLVSMVWVRERotation", 0)
    local MinusAmount = -16
    coroutine.wrap(function()
        while wait() do
            MinusAmount = MinusAmount + 0.4
            TweenService:Create(PLVSMVWVRELogo, TweenTable["PLVSMVWVRERotation"], {Rotation = PLVSMVWVRELogo.Rotation - MinusAmount}):Play()
        end
    end)()

    TweenService:Create(edge, TweenTable["introduction"], {BackgroundTransparency = 0}):Play()
    TweenService:Create(background, TweenTable["introduction"], {BackgroundTransparency = 0}):Play()
    wait(.2)
    TweenService:Create(bar, TweenTable["introduction"], {Size = UDim2.new(0, 298, 0, 1)}):Play()
    wait(.2)
    TweenService:Create(PLVSMVWVRE, TweenTable["introduction"], {TextTransparency = 0}):Play()
    TweenService:Create(text, TweenTable["introduction"], {TextTransparency = 0}):Play()
    wait(.3)
    TweenService:Create(PLVSMVWVRELogo, TweenTable["introduction"], {ImageTransparency = 0}):Play()
    wait(2)
    TweenService:Create(PLVSMVWVRELogo, TweenTable["introduction"], {ImageTransparency = 1}):Play()
    wait(.2)
    TweenService:Create(hashLogo, TweenTable["introduction"], {ImageTransparency = 0}):Play()
    wait(2)
    TweenService:Create(hashLogo, TweenTable["introduction"], {ImageTransparency = 1}):Play()
    wait(.1)
    TweenService:Create(text, TweenTable["introduction"], {TextTransparency = 1}):Play()
    wait(.1)
    TweenService:Create(PLVSMVWVRE, TweenTable["introduction"], {TextTransparency = 1}):Play()
    wait(.1)
    TweenService:Create(bar, TweenTable["introduction"], {Size = UDim2.new(0, 0, 0, 1)}):Play()
    wait(.1)
    TweenService:Create(background, TweenTable["introduction"], {BackgroundTransparency = 1}):Play()
    TweenService:Create(edge, TweenTable["introduction"], {BackgroundTransparency = 1}):Play()
    wait(.2)
    introduction:Destroy()
    sound.Ended:Connect(function() sound:Destroy() end)
end

function library:Init(key)
    for _,v in next, CoreGuiService:GetChildren() do
        if v.Name == "screen" then
            v:Destroy()
        end
    end

    local title = library.title
    key = key or Enum.KeyCode.RightAlt

    local screen = Instance.new("ScreenGui")
    local edge = Instance.new("Frame")
    local edgeCorner = Instance.new("UICorner")
    local background = Instance.new("Frame")
    local backgroundCorner = Instance.new("UICorner")
    local backgroundGradient = Instance.new("UIGradient")
    local headerLabel = Instance.new("TextLabel")
    local headerPadding = Instance.new("UIPadding")
    local barFolder = Instance.new("Folder")
    local bar = Instance.new("Frame")
    local barCorner = Instance.new("UICorner")
    local barLayout = Instance.new("UIListLayout")
    local tabButtonsEdge = Instance.new("Frame")
    local tabButtonCorner = Instance.new("UICorner")
    local tabButtons = Instance.new("Frame")
    local tabButtonCorner_2 = Instance.new("UICorner")
    local tabButtonsGradient = Instance.new("UIGradient")
    local tabButtonLayout = Instance.new("UIListLayout")
    local tabButtonPadding = Instance.new("UIPadding")
    local containerEdge = Instance.new("Frame")
    local tabButtonCorner_3 = Instance.new("UICorner")
    local container = Instance.new("Frame")
    local containerCorner = Instance.new("UICorner")
    local containerGradient = Instance.new("UIGradient")

    screen.Name = "screen"
    screen.Parent = CoreGuiService
    screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    edge.Name = "edge"
    edge.Parent = screen
    edge.AnchorPoint = Vector2.new(0.5, 0.5)
    edge.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    edge.Position = UDim2.new(0.5, 0, 0.5, 0)
    edge.Size = UDim2.new(0, 594, 0, 406)

    drag(edge, 0.04)
    local CanChangeVisibility = true
    UserInputService.InputBegan:Connect(function(input)
        if CanChangeVisibility and input.KeyCode == key then
            edge.Visible = not edge.Visible
        end
    end)

    edgeCorner.CornerRadius = UDim.new(0, 2)
    edgeCorner.Name = "edgeCorner"
    edgeCorner.Parent = edge

    background.Name = "background"
    background.Parent = edge
    background.AnchorPoint = Vector2.new(0.5, 0.5)
    background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    background.Position = UDim2.new(0.5, 0, 0.5, 0)
    background.Size = UDim2.new(0, 592, 0, 404)
    background.ClipsDescendants = true

    backgroundCorner.CornerRadius = UDim.new(0, 2)
    backgroundCorner.Name = "backgroundCorner"
    backgroundCorner.Parent = background

    backgroundGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
    backgroundGradient.Rotation = 90
    backgroundGradient.Name = "backgroundGradient"
    backgroundGradient.Parent = background

    headerLabel.Name = "headerLabel"
    headerLabel.Parent = background
    headerLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    headerLabel.BackgroundTransparency = 1.000
    headerLabel.Size = UDim2.new(0, 592, 0, 38)
    headerLabel.Font = Enum.Font.Code
    headerLabel.Text = title
    headerLabel.TextColor3 = Color3.fromRGB(198, 198, 198)
    headerLabel.TextSize = 16.000
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.RichText = true

    headerPadding.Name = "headerPadding"
    headerPadding.Parent = headerLabel
    headerPadding.PaddingBottom = UDim.new(0, 6)
    headerPadding.PaddingLeft = UDim.new(0, 12)
    headerPadding.PaddingRight = UDim.new(0, 6)
    headerPadding.PaddingTop = UDim.new(0, 6)

    barFolder.Name = "barFolder"
    barFolder.Parent = background

    bar.Name = "bar"
    bar.Parent = barFolder
    bar.BackgroundColor3 = Color3.fromRGB(159, 115, 255)
    bar.BackgroundTransparency = 0.200
    bar.Size = UDim2.new(0, 592, 0, 1)
    bar.BorderSizePixel = 0

    barCorner.CornerRadius = UDim.new(0, 2)
    barCorner.Name = "barCorner"
    barCorner.Parent = bar

    barLayout.Name = "barLayout"
    barLayout.Parent = barFolder
    barLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    barLayout.SortOrder = Enum.SortOrder.LayoutOrder

    tabButtonsEdge.Name = "tabButtonsEdge"
    tabButtonsEdge.Parent = background
    tabButtonsEdge.AnchorPoint = Vector2.new(0.5, 0.5)
    tabButtonsEdge.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabButtonsEdge.Position = UDim2.new(0.1435, 0, 0.536000013, 0)
    tabButtonsEdge.Size = UDim2.new(0, 152, 0, 360)

    tabButtonCorner.CornerRadius = UDim.new(0, 2)
    tabButtonCorner.Name = "tabButtonCorner"
    tabButtonCorner.Parent = tabButtonsEdge

    tabButtons.Name = "tabButtons"
    tabButtons.Parent = tabButtonsEdge
    tabButtons.AnchorPoint = Vector2.new(0.5, 0.5)
    tabButtons.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
    tabButtons.ClipsDescendants = true
    tabButtons.Position = UDim2.new(0.5, 0, 0.5, 0)
    tabButtons.Size = UDim2.new(0, 150, 0, 358)

    tabButtonCorner_2.CornerRadius = UDim.new(0, 2)
    tabButtonCorner_2.Name = "tabButtonCorner"
    tabButtonCorner_2.Parent = tabButtons

    tabButtonsGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
    tabButtonsGradient.Rotation = 90
    tabButtonsGradient.Name = "tabButtonsGradient"
    tabButtonsGradient.Parent = tabButtons

    tabButtonLayout.Name = "tabButtonLayout"
    tabButtonLayout.Parent = tabButtons
    tabButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder

    tabButtonPadding.Name = "tabButtonPadding"
    tabButtonPadding.Parent = tabButtons
    tabButtonPadding.PaddingBottom = UDim.new(0, 4)
    tabButtonPadding.PaddingLeft = UDim.new(0, 4)
    tabButtonPadding.PaddingRight = UDim.new(0, 4)
    tabButtonPadding.PaddingTop = UDim.new(0, 4)

    containerEdge.Name = "containerEdge"
    containerEdge.Parent = background
    containerEdge.AnchorPoint = Vector2.new(0.5, 0.5)
    containerEdge.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    containerEdge.Position = UDim2.new(0.637000024, 0, 0.536000013, 0)
    containerEdge.Size = UDim2.new(0, 414, 0, 360)

    tabButtonCorner_3.CornerRadius = UDim.new(0, 2)
    tabButtonCorner_3.Name = "tabButtonCorner"
    tabButtonCorner_3.Parent = containerEdge

    container.Name = "container"
    container.Parent = containerEdge
    container.AnchorPoint = Vector2.new(0.5, 0.5)
    container.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
    container.Position = UDim2.new(0.5, 0, 0.5, 0)
    container.Size = UDim2.new(0, 412, 0, 358)

    containerCorner.CornerRadius = UDim.new(0, 2)
    containerCorner.Name = "containerCorner"
    containerCorner.Parent = container

    containerGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
    containerGradient.Rotation = 90
    containerGradient.Name = "containerGradient"
    containerGradient.Parent = container

    local TabLibrary = {
        IsFirst = true,
        CurrentTab = ""
    }
    CreateTween("tab_text_colour", 0.16)
    function TabLibrary:NewTab(title)
        title = title or "tab"

        local tabButton = Instance.new("TextButton")
        local page = Instance.new("ScrollingFrame")
        local pageLayout = Instance.new("UIListLayout")
        local pagePadding = Instance.new("UIPadding")

        tabButton.Name = "tabButton"
        tabButton.Parent = tabButtons
        tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.BackgroundTransparency = 1.000
        tabButton.ClipsDescendants = true
        tabButton.Position = UDim2.new(-0.0281690136, 0, 0, 0)
        tabButton.Size = UDim2.new(0, 150, 0, 22)
        tabButton.AutoButtonColor = false
        tabButton.Font = Enum.Font.Code
        tabButton.Text = title
        tabButton.TextColor3 = Color3.fromRGB(170, 170, 170)
        tabButton.TextSize = 15.000
        tabButton.RichText = true

        page.Name = "page"
        page.Parent = container
        page.Active = true
        page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        page.BackgroundTransparency = 1.000
        page.BorderSizePixel = 0
        page.Size = UDim2.new(0, 412, 0, 358)
        page.BottomImage = "http://www.roblox.com/asset/?id=3062506202"
        page.MidImage = "http://www.roblox.com/asset/?id=3062506202"
        page.ScrollBarThickness = 1
        page.TopImage = "http://www.roblox.com/asset/?id=3062506202"
        page.ScrollBarImageColor3 = Color3.fromRGB(159, 115, 255)
        page.Visible = false
        
        pageLayout.Name = "pageLayout"
        pageLayout.Parent = page
        pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Padding = UDim.new(0, 4)

        pagePadding.Name = "pagePadding"
        pagePadding.Parent = page
        pagePadding.PaddingBottom = UDim.new(0, 6)
        pagePadding.PaddingLeft = UDim.new(0, 6)
        pagePadding.PaddingRight = UDim.new(0, 6)
        pagePadding.PaddingTop = UDim.new(0, 6)

        if TabLibrary.IsFirst then
            page.Visible = true
            tabButton.TextColor3 = Color3.fromRGB(159, 115, 255)
            TabLibrary.CurrentTab = title
        end
        
        tabButton.MouseButton1Click:Connect(function()
            TabLibrary.CurrentTab = title
            for i,v in pairs(container:GetChildren()) do 
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            page.Visible = true

            for i,v in pairs(tabButtons:GetChildren()) do
                if v:IsA("TextButton") then
                    TweenService:Create(v, TweenTable["tab_text_colour"], {TextColor3 = Color3.fromRGB(170, 170, 170)}):Play()
                end
            end
            TweenService:Create(tabButton, TweenTable["tab_text_colour"], {TextColor3 = Color3.fromRGB(159, 115, 255)}):Play()
        end)

        local function UpdatePageSize()
            local correction = pageLayout.AbsoluteContentSize
            page.CanvasSize = UDim2.new(0, correction.X+13, 0, correction.Y+13)
        end

        page.ChildAdded:Connect(UpdatePageSize)
        page.ChildRemoved:Connect(UpdatePageSize)

        TabLibrary.IsFirst = false

        CreateTween("hover", 0.16)
        local Components = {}
        function Components:NewLabel(text, alignment)
            text = text or "label"
            alignment = alignment or "left"

            local label = Instance.new("TextLabel")
            local labelPadding = Instance.new("UIPadding")

            label.Name = "label"
            label.Parent = page
            label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            label.BackgroundTransparency = 1.000
            label.Position = UDim2.new(0.00499999989, 0, 0, 0)
            label.Size = UDim2.new(0, 396, 0, 24)
            label.Font = Enum.Font.Code
            label.Text = text
            label.TextColor3 = Color3.fromRGB(190, 190, 190)
            label.TextSize = 14.000
            label.TextWrapped = true
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.RichText = true

            labelPadding.Name = "pagePadding"
            labelPadding.Parent = page
            labelPadding.PaddingBottom = UDim.new(0, 6)
            labelPadding.PaddingLeft = UDim.new(0, 12)
            labelPadding.PaddingRight = UDim.new(0, 6)
            labelPadding.PaddingTop = UDim.new(0, 6)

            if alignment:lower():find("le") then
                label.TextXAlignment = Enum.TextXAlignment.Left
            elseif alignment:lower():find("cent") then
                label.TextXAlignment = Enum.TextXAlignment.Center
            elseif alignment:lower():find("ri") then
                label.TextXAlignment = Enum.TextXAlignment.Right
            end

            UpdatePageSize()

            local LabelFunctions = {}
            function LabelFunctions:Text(text)
                text = text or "new label text"
                label.Text = text
                return LabelFunctions
            end
            --
            function LabelFunctions:Remove()
                label:Destroy()
                return LabelFunctions
            end
            --
            function LabelFunctions:Hide()
                label.Visible = false
                UpdatePageSize()
                return LabelFunctions
            end
            --
            function LabelFunctions:Show()
                label.Visible = true
                UpdatePageSize()
                return LabelFunctions
            end
            --
            function LabelFunctions:Align(new)
                new = new or "le"
                if new:lower():find("le") then
                    label.TextXAlignment = Enum.TextXAlignment.Left
                elseif new:lower():find("cent") then
                    label.TextXAlignment = Enum.TextXAlignment.Center
                elseif new:lower():find("ri") then
                    label.TextXAlignment = Enum.TextXAlignment.Right
                end
            end
            return LabelFunctions
        end

        function Components:NewButton(text, callback)
            text = text or "button"
            callback = callback or function() end

            local buttonFrame = Instance.new("Frame")
            local buttonLayout = Instance.new("UIListLayout")
            local button = Instance.new("TextButton")
            local buttonCorner = Instance.new("UICorner")
            local buttonBackground = Instance.new("Frame")
            local buttonGradient = Instance.new("UIGradient")
            local buttonBackCorner = Instance.new("UICorner")
            local buttonLabel = Instance.new("TextLabel")

            buttonFrame.Name = "buttonFrame"
            buttonFrame.Parent = page
            buttonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            buttonFrame.BackgroundTransparency = 1.000
            buttonFrame.Size = UDim2.new(0, 396, 0, 24)

            buttonLayout.Name = "buttonLayout"
            buttonLayout.Parent = buttonFrame
            buttonLayout.FillDirection = Enum.FillDirection.Horizontal
            buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
            buttonLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            buttonLayout.Padding = UDim.new(0, 4)

            button.Name = "button"
            button.Parent = buttonFrame
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            button.Size = UDim2.new(0, 396, 0, 24)
            button.AutoButtonColor = false
            button.Font = Enum.Font.SourceSans
            button.Text = ""
            button.TextColor3 = Color3.fromRGB(0, 0, 0)
            button.TextSize = 14.000

            buttonCorner.CornerRadius = UDim.new(0, 2)
            buttonCorner.Name = "buttonCorner"
            buttonCorner.Parent = button

            buttonBackground.Name = "buttonBackground"
            buttonBackground.Parent = button
            buttonBackground.AnchorPoint = Vector2.new(0.5, 0.5)
            buttonBackground.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            buttonBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
            buttonBackground.Size = UDim2.new(0, 394, 0, 22)

            buttonGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
            buttonGradient.Rotation = 90
            buttonGradient.Name = "buttonGradient"
            buttonGradient.Parent = buttonBackground

            buttonBackCorner.CornerRadius = UDim.new(0, 2)
            buttonBackCorner.Name = "buttonBackCorner"
            buttonBackCorner.Parent = buttonBackground

            buttonLabel.Name = "buttonLabel"
            buttonLabel.Parent = buttonBackground
            buttonLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            buttonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            buttonLabel.BackgroundTransparency = 1.000
            buttonLabel.ClipsDescendants = true
            buttonLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
            buttonLabel.Size = UDim2.new(0, 394, 0, 22)
            buttonLabel.Font = Enum.Font.Code
            buttonLabel.Text = text
            buttonLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
            buttonLabel.TextSize = 14.000
            buttonLabel.RichText = true

            button.MouseEnter:Connect(function()
                TweenService:Create(button, TweenTable["hover"], {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            end)
            button.MouseLeave:Connect(function()
                TweenService:Create(button, TweenTable["hover"], {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            end)

            button.MouseButton1Down:Connect(function()
                TweenService:Create(buttonLabel, TweenTable["hover"], {TextColor3 = Color3.fromRGB(159, 115, 255)}):Play()
            end)
            button.MouseButton1Up:Connect(function()
                TweenService:Create(buttonLabel, TweenTable["hover"], {TextColor3 = Color3.fromRGB(190, 190, 190)}):Play()
            end)

            button.MouseButton1Click:Connect(function()
                callback()
            end)

            local NewSizeX = 396
            local Amnt = 0
            local function ResizeButtons()
                local Amount = buttonFrame:GetChildren()
                local Resized = 396
                Amount = #Amount - 1
                Amnt = Amount
                local AmountToSubtract = (Amount / 2)
                Resized = (396 / Amount) - AmountToSubtract
                NewSizeX = (Resized)

                for i,v in pairs(buttonFrame:GetChildren()) do
                    if v:IsA("TextButton") then
                        v.Size = UDim2.new(0, Resized, 0, 24)
                        for z,x in pairs(v:GetDescendants()) do
                            if x:IsA("TextLabel") or x:IsA("Frame") then
                                x.Size = UDim2.new(0, Resized - 2, 0, 22)
                            end
                        end
                    end
                end
            end

            buttonFrame.ChildAdded:Connect(ResizeButtons)
            buttonFrame.ChildRemoved:Connect(ResizeButtons)

            UpdatePageSize()

            --
            local ButtonFunctions = {}
            function ButtonFunctions:AddButton(text, callback_2)
                if Amnt < 4 then
                    text = text or "button"
                    callback_2 = callback_2 or function() end
    
                    local button = Instance.new("TextButton")
                    local buttonCorner = Instance.new("UICorner")
                    local buttonBackground = Instance.new("Frame")
                    local buttonGradient = Instance.new("UIGradient")
                    local buttonBackCorner = Instance.new("UICorner")
                    local buttonLabel = Instance.new("TextLabel")
        
                    button.Name = "button"
                    button.Parent = buttonFrame
                    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    button.Size = UDim2.new(0, NewSizeX - Amnt, 0, 24)
                    button.AutoButtonColor = false
                    button.Font = Enum.Font.SourceSans
                    button.Text = ""
                    button.TextColor3 = Color3.fromRGB(0, 0, 0)
                    button.TextSize = 14.000
        
                    buttonCorner.CornerRadius = UDim.new(0, 2)
                    buttonCorner.Name = "buttonCorner"
                    buttonCorner.Parent = button
        
                    buttonBackground.Name = "buttonBackground"
                    buttonBackground.Parent = button
                    buttonBackground.AnchorPoint = Vector2.new(0.5, 0.5)
                    buttonBackground.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    buttonBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
                    buttonBackground.Size = UDim2.new(0, (NewSizeX - 2) - Amnt, 0, 22)
        
                    buttonGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
                    buttonGradient.Rotation = 90
                    buttonGradient.Name = "buttonGradient"
                    buttonGradient.Parent = buttonBackground
        
                    buttonBackCorner.CornerRadius = UDim.new(0, 2)
                    buttonBackCorner.Name = "buttonBackCorner"
                    buttonBackCorner.Parent = buttonBackground
        
                    buttonLabel.Name = "buttonLabel"
                    buttonLabel.Parent = buttonBackground
                    buttonLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                    buttonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    buttonLabel.BackgroundTransparency = 1.000
                    buttonLabel.ClipsDescendants = true
                    buttonLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
                    buttonLabel.Size = UDim2.new(0, NewSizeX - 2, 0, 22)
                    buttonLabel.Font = Enum.Font.Code
                    buttonLabel.Text = text
                    buttonLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
                    buttonLabel.TextSize = 14.000
                    buttonLabel.RichText = true

                    UpdatePageSize()
        
                    button.MouseEnter:Connect(function()
                        TweenService:Create(button, TweenTable["hover"], {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                    end)
                    button.MouseLeave:Connect(function()
                        TweenService:Create(button, TweenTable["hover"], {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                    end)
        
                    button.MouseButton1Down:Connect(function()
                        TweenService:Create(buttonLabel, TweenTable["hover"], {TextColor3 = Color3.fromRGB(159, 115, 255)}):Play()
                    end)
                    button.MouseButton1Up:Connect(function()
                        TweenService:Create(buttonLabel, TweenTable["hover"], {TextColor3 = Color3.fromRGB(190, 190, 190)}):Play()
                    end)
        
                    button.MouseButton1Click:Connect(function()
                        callback_2()
                    end)

                    local ButtonFunctions2 = {}
                    function ButtonFunctions2:Fire()
                        callback_2()

                        return ButtonFunctions2
                    end
                    --
                    function ButtonFunctions2:Hide()
                        button.Visible = false

                        return ButtonFunctions2
                    end
                    --
                    function ButtonFunctions2:Show()
                        button.Visible = true

                        return ButtonFunctions2
                    end
                    --
                    function ButtonFunctions2:Text(text)
                        text = text or "button new text"
                        buttonLabel.Text = text

                        return ButtonFunctions2
                    end
                    --
                    function ButtonFunctions2:Remove()
                        button:Destroy()

                        return ButtonFunctions2
                    end
                    --
                    function ButtonFunctions2:SetFunction(new)
                        new = new or function() end
                        callback_2 = new

                        return ButtonFunctions2
                    end
                    return ButtonFunctions2 and ButtonFunctions
                elseif Amnt > 4 then
                    print("more than 4 buttons are not supported.")
                end
                return ButtonFunctions
            end
            --
            function ButtonFunctions:Fire()
                callback()

                return ButtonFunctions
            end
            --
            function ButtonFunctions:Hide()
                button.Visible = false

                return ButtonFunctions
            end
            --
            function ButtonFunctions:Show()
                button.Visible = true

                return ButtonFunctions
            end
            --
            function ButtonFunctions:Text(text)
                text = text or "button new text"
                buttonLabel.Text = text

                return ButtonFunctions
            end
            --
            function ButtonFunctions:Remove()
                button:Destroy()

                return ButtonFunctions
            end
            --
            function ButtonFunctions:SetFunction(new)
                new = new or function() end
                callback = new

                return ButtonFunctions
            end
            return ButtonFunctions
        end
        --

        function Components:NewSection(text)
            text = text or "section"

            local sectionFrame = Instance.new("Frame")
            local sectionLayout = Instance.new("UIListLayout")
            local leftBar = Instance.new("Frame")
            local sectionLabel = Instance.new("TextLabel")
            local sectionPadding = Instance.new("UIPadding")
            local rightBar = Instance.new("Frame")

            sectionFrame.Name = "sectionFrame"
            sectionFrame.Parent = page
            sectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionFrame.BackgroundTransparency = 1.000
            sectionFrame.ClipsDescendants = true
            sectionFrame.Size = UDim2.new(0, 396, 0, 18)

            sectionLayout.Name = "sectionLayout"
            sectionLayout.Parent = sectionFrame
            sectionLayout.FillDirection = Enum.FillDirection.Horizontal
            sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            sectionLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            sectionLayout.Padding = UDim.new(0, 4)


            sectionLabel.Name = "sectionLabel"
            sectionLabel.Parent = sectionFrame
            sectionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionLabel.BackgroundTransparency = 1.000
            sectionLabel.ClipsDescendants = true
            sectionLabel.Position = UDim2.new(0.0252525248, 0, 0.020833334, 0)
            sectionLabel.Size = UDim2.new(0, 0, 0, 18)
            sectionLabel.Font = Enum.Font.Code
            sectionLabel.LineHeight = 1
            sectionLabel.Text = text
            sectionLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
            sectionLabel.TextSize = 14.000
            sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            sectionLabel.RichText = true

            sectionPadding.Name = "sectionPadding"
            sectionPadding.Parent = sectionLabel
            sectionPadding.PaddingBottom = UDim.new(0, 6)
            sectionPadding.PaddingLeft = UDim.new(0, 0)
            sectionPadding.PaddingRight = UDim.new(0, 6)
            sectionPadding.PaddingTop = UDim.new(0, 6)

            rightBar.Name = "rightBar"
            rightBar.Parent = sectionFrame
            rightBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            rightBar.BorderSizePixel = 0
            rightBar.Position = UDim2.new(0.308080822, 0, 0.479166657, 0)
            rightBar.Size = UDim2.new(0, 403, 0, 1)
            UpdatePageSize()

            local NewSectionSize = TextService:GetTextSize(sectionLabel.Text, sectionLabel.TextSize, sectionLabel.Font, Vector2.new(math.huge,math.huge))
            sectionLabel.Size = UDim2.new(0, NewSectionSize.X, 0, 18)

            local SectionFunctions = {}
            function SectionFunctions:Text(new)
                new = new or text
                sectionLabel.Text = new

                local NewSectionSize = TextService:GetTextSize(sectionLabel.Text, sectionLabel.TextSize, sectionLabel.Font, Vector2.new(math.huge,math.huge))
                sectionLabel.Size = UDim2.new(0, NewSectionSize.X, 0, 18)

                return SectionFunctions
            end
            function SectionFunctions:Hide()
                sectionFrame.Visible = false
                return SectionFunctions
            end
            function SectionFunctions:Show()
                sectionFrame.Visible = true
                return SectionFunctions
            end
            function SectionFunctions:Remove()
                sectionFrame:Destroy()
                return SectionFunctions
            end
            --
            return SectionFunctions
        end

        --

        function Components:NewToggle(text, default, callback)
            text = text or "toggle"
            default = default or false
            callback = callback or function() end

            local toggleButton = Instance.new("TextButton")
            local toggleLayout = Instance.new("UIListLayout")
            local toggleEdge = Instance.new("Frame")
            local toggleEdgeCorner = Instance.new("UICorner")
            local toggle = Instance.new("Frame")
            local toggleCorner = Instance.new("UICorner")
            local toggleGradient = Instance.new("UIGradient")
            local toggleDesign = Instance.new("Frame")
            local toggleDesignCorner = Instance.new("UICorner")
            local toggleDesignGradient = Instance.new("UIGradient")
            local toggleLabel = Instance.new("TextLabel")
            local toggleLabelPadding = Instance.new("UIPadding")
            local Extras = Instance.new("Folder")
            local ExtrasLayout = Instance.new("UIListLayout")

            toggleButton.Name = "toggleButton"
            toggleButton.Parent = page
            toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggleButton.BackgroundTransparency = 1.000
            toggleButton.ClipsDescendants = false
            toggleButton.Size = UDim2.new(0, 396, 0, 22)
            toggleButton.Font = Enum.Font.Code
            toggleButton.Text = ""
            toggleButton.TextColor3 = Color3.fromRGB(190, 190, 190)
            toggleButton.TextSize = 14.000
            toggleButton.TextXAlignment = Enum.TextXAlignment.Left

            toggleLayout.Name = "toggleLayout"
            toggleLayout.Parent = toggleButton
            toggleLayout.FillDirection = Enum.FillDirection.Horizontal
            toggleLayout.SortOrder = Enum.SortOrder.LayoutOrder
            toggleLayout.VerticalAlignment = Enum.VerticalAlignment.Center

            toggleEdge.Name = "toggleEdge"
            toggleEdge.Parent = toggleButton
            toggleEdge.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            toggleEdge.Size = UDim2.new(0, 18, 0, 18)

            toggleEdgeCorner.CornerRadius = UDim.new(0, 2)
            toggleEdgeCorner.Name = "toggleEdgeCorner"
            toggleEdgeCorner.Parent = toggleEdge

            toggle.Name = "toggle"
            toggle.Parent = toggleEdge
            toggle.AnchorPoint = Vector2.new(0.5, 0.5)
            toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggle.Position = UDim2.new(0.5, 0, 0.5, 0)
            toggle.Size = UDim2.new(0, 16, 0, 16)

            toggleCorner.CornerRadius = UDim.new(0, 2)
            toggleCorner.Name = "toggleCorner"
            toggleCorner.Parent = toggle

            toggleGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
            toggleGradient.Rotation = 90
            toggleGradient.Name = "toggleGradient"
            toggleGradient.Parent = toggle

            toggleDesign.Name = "toggleDesign"
            toggleDesign.Parent = toggle
            toggleDesign.AnchorPoint = Vector2.new(0.5, 0.5)
            toggleDesign.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggleDesign.BackgroundTransparency = 1.000
            toggleDesign.Position = UDim2.new(0.5, 0, 0.5, 0)

            toggleDesignCorner.CornerRadius = UDim.new(0, 2)
            toggleDesignCorner.Name = "toggleDesignCorner"
            toggleDesignCorner.Parent = toggleDesign

            toggleDesignGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(157, 115, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(106, 69, 181))}
            toggleDesignGradient.Rotation = 90
            toggleDesignGradient.Name = "toggleDesignGradient"
            toggleDesignGradient.Parent = toggleDesign

            toggleLabel.Name = "toggleLabel"
            toggleLabel.Parent = toggleButton
            toggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggleLabel.BackgroundTransparency = 1.000
            toggleLabel.Position = UDim2.new(0.0454545468, 0, 0, 0)
            toggleLabel.Size = UDim2.new(0, 377, 0, 22)
            toggleLabel.Font = Enum.Font.Code
            toggleLabel.LineHeight = 1.150
            toggleLabel.Text = text
            toggleLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
            toggleLabel.TextSize = 14.000
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.RichText = true

            toggleLabelPadding.Name = "toggleLabelPadding"
            toggleLabelPadding.Parent = toggleLabel
            toggleLabelPadding.PaddingLeft = UDim.new(0, 6)

            Extras.Name = "Extras"
            Extras.Parent = toggleButton

            ExtrasLayout.Name = "ExtrasLayout"
            ExtrasLayout.Parent = Extras
            ExtrasLayout.FillDirection = Enum.FillDirection.Horizontal
            ExtrasLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
            ExtrasLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ExtrasLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            ExtrasLayout.Padding = UDim.new(0, 2)

            local NewToggleLabelSize = TextService:GetTextSize(toggleLabel.Text, toggleLabel.TextSize, toggleLabel.Font, Vector2.new(math.huge,math.huge))
            toggleLabel.Size = UDim2.new(0, NewToggleLabelSize.X + 6, 0, 22)

            toggleButton.MouseEnter:Connect(function()
                TweenService:Create(toggleLabel, TweenTable["hover"], {TextColor3 = Color3.fromRGB(210, 210, 210)}):Play()
            end)
            toggleButton.MouseLeave:Connect(function()
                TweenService:Create(toggleLabel, TweenTable["hover"], {TextColor3 = Color3.fromRGB(190, 190, 190)}):Play()
            end)

            CreateTween("toggle_form", 0.13)
            local On = default
            if default then
                On = true
            else
                On = false
            end
            toggleButton.MouseButton1Click:Connect(function()
                On = not On
                local SizeOn = On and UDim2.new(0, 12, 0, 12) or UDim2.new(0, 0, 0, 0)
                local Transparency = On and 0 or 1
                TweenService:Create(toggleDesign, TweenTable["toggle_form"], {Size = SizeOn}):Play()
                TweenService:Create(toggleDesign, TweenTable["toggle_form"], {BackgroundTransparency = Transparency}):Play()
                callback(On)
            end)

            local ToggleFunctions = {
                Key = "None",
                KeyMode = "Toggle"
            }
            function ToggleFunctions:Text(new)
                toggleLabel.Text = new or text
                return ToggleFunctions
            end
            --
            function ToggleFunctions:Hide()
                toggleButton.Visible = false
                return ToggleFunctions
            end
            --
            function ToggleFunctions:Show()
                toggleButton.Visible = true
                return ToggleFunctions
            end   
            --         
            function ToggleFunctions:Change()
                On = not On
                local SizeOn = On and UDim2.new(0, 12, 0, 12) or UDim2.new(0, 0, 0, 0)
                local Transparency = On and 0 or 1
                TweenService:Create(toggleDesign, TweenTable["toggle_form"], {Size = SizeOn}):Play()
                TweenService:Create(toggleDesign, TweenTable["toggle_form"], {BackgroundTransparency = Transparency}):Play()
                callback(On)
                return ToggleFunctions
            end
            --
            function ToggleFunctions:Remove()
                toggleButton:Destroy()
                return ToggleFunction
            end
            --
            function ToggleFunctions:Set(state)
                On = state
                local SizeOn = On and UDim2.new(0, 12, 0, 12) or UDim2.new(0, 0, 0, 0)
                local Transparency = On and 0 or 1
                TweenService:Create(toggleDesign, TweenTable["toggle_form"], {Size = SizeOn}):Play()
                TweenService:Create(toggleDesign, TweenTable["toggle_form"], {BackgroundTransparency = Transparency}):Play()
                callback(On)
                return ToggleFunctions
            end
            --
            local callback_t
            function ToggleFunctions:SetFunction(new)
                new = new or function() end
                callback = new
                callback_t = new
                return ToggleFunctions
            end
            UpdatePageSize()
            --
            function ToggleFunctions:AddKeybind(default_t)
                callback_t = callback
                default_t = default_t or Enum.KeyCode.P
                local Mode = "Toggle"
                
                local keybind = Instance.new("TextButton")
                local keybindCorner = Instance.new("UICorner")
                local keybindBackground = Instance.new("Frame")
                local keybindGradient = Instance.new("UIGradient")
                local keybindBackCorner = Instance.new("UICorner")
                local keybindButtonLabel = Instance.new("TextLabel")
                local keybindLabelStraint = Instance.new("UISizeConstraint")
                local keybindBackgroundStraint = Instance.new("UISizeConstraint")
                local keybindStraint = Instance.new("UISizeConstraint")

                keybind.Name = "keybind"
                keybind.Parent = Extras
                keybind.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                keybind.Position = UDim2.new(0.780303001, 0, 0, 0)
                keybind.Size = UDim2.new(0, 87, 0, 22)
                keybind.AutoButtonColor = false
                keybind.Font = Enum.Font.SourceSans
                keybind.Text = ""
                keybind.TextColor3 = Color3.fromRGB(0, 0, 0)
                keybind.TextSize = 14.000
                keybind.Active = false
    
                keybindCorner.CornerRadius = UDim.new(0, 2)
                keybindCorner.Name = "keybindCorner"
                keybindCorner.Parent = keybind
    
                keybindBackground.Name = "keybindBackground"
                keybindBackground.Parent = keybind
                keybindBackground.AnchorPoint = Vector2.new(0.5, 0.5)
                keybindBackground.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                keybindBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
                keybindBackground.Size = UDim2.new(0, 85, 0, 20)
    
                keybindGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
                keybindGradient.Rotation = 90
                keybindGradient.Name = "keybindGradient"
                keybindGradient.Parent = keybindBackground
    
                keybindBackCorner.CornerRadius = UDim.new(0, 2)
                keybindBackCorner.Name = "keybindBackCorner"
                keybindBackCorner.Parent = keybindBackground
    
                keybindButtonLabel.Name = "keybindButtonLabel"
                keybindButtonLabel.Parent = keybindBackground
                keybindButtonLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                keybindButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                keybindButtonLabel.BackgroundTransparency = 1.000
                keybindButtonLabel.ClipsDescendants = true
                keybindButtonLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
                keybindButtonLabel.Size = UDim2.new(0, 85, 0, 20)
                keybindButtonLabel.Font = Enum.Font.Code
                keybindButtonLabel.Text = ". . ."
                keybindButtonLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
                keybindButtonLabel.TextSize = 14.000
                keybindButtonLabel.RichText = true
    
                keybindLabelStraint.Name = "keybindLabelStraint"
                keybindLabelStraint.Parent = keybindButtonLabel
                keybindLabelStraint.MinSize = Vector2.new(28, 20)
    
                keybindBackgroundStraint.Name = "keybindBackgroundStraint"
                keybindBackgroundStraint.Parent = keybindBackground
                keybindBackgroundStraint.MinSize = Vector2.new(28, 20)
    
                keybindStraint.Name = "keybindStraint"
                keybindStraint.Parent = keybind
                keybindStraint.MinSize = Vector2.new(30, 22)
    
                local Shortcuts = { 
                    Return = "enter",
                    MouseButton1 = "m1",
                    MouseButton2 = "m2",
                    MouseButton3 = "m3",
                    MouseButton4 = "m4",
                    MouseButton5 = "m5"
                }
                local ChosenKey = default_t.Name or default_t
                ToggleFunctions.Key = ChosenKey
                ToggleFunctions.KeyMode = Mode
                
                local function UpdateKeybindText()
                    local display = Shortcuts[ChosenKey] or ChosenKey
                    if Mode == "Always" then
                        keybindButtonLabel.Text = "[Always]"
                    else
                        keybindButtonLabel.Text = display .. " [" .. Mode .. "]"
                    end
                end

                keybindButtonLabel.Text = (Shortcuts[ChosenKey] or ChosenKey) .. " [Toggle]"
                CreateTween("keybind", 0.08)
                
                local function ResizeKeybind()
                    local NewKeybindSize = TextService:GetTextSize(keybindButtonLabel.Text, keybindButtonLabel.TextSize, keybindButtonLabel.Font, Vector2.new(math.huge,math.huge))
                    TweenService:Create(keybindButtonLabel, TweenTable["keybind"], {Size = UDim2.new(0, NewKeybindSize.X + 6, 0, 20)}):Play()
                    TweenService:Create(keybindBackground, TweenTable["keybind"], {Size = UDim2.new(0, NewKeybindSize.X + 6, 0, 20)}):Play()
                    TweenService:Create(keybind, TweenTable["keybind"], {Size = UDim2.new(0, NewKeybindSize.X + 8, 0, 22)}):Play()
                end
                keybindButtonLabel:GetPropertyChangedSignal("Text"):Connect(ResizeKeybind)
                ResizeKeybind()
                UpdatePageSize()
    
                -- [[ CONTEXT MENU UI ]]
                local ctxMenu = Instance.new("Frame")
                ctxMenu.Name = "CtxMenu"
                ctxMenu.Parent = screen
                ctxMenu.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                ctxMenu.Size = UDim2.new(0, 80, 0, 60)
                ctxMenu.Visible = false
                ctxMenu.ZIndex = 100

                local ctxCorner = Instance.new("UICorner", ctxMenu)
                ctxCorner.CornerRadius = UDim.new(0, 4)
                local ctxStroke = Instance.new("UIStroke", ctxMenu)
                ctxStroke.Color = Color3.fromRGB(60, 60, 60)
                ctxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                local ctxLayout = Instance.new("UIListLayout", ctxMenu)
                ctxLayout.SortOrder = Enum.SortOrder.LayoutOrder

                local function closeCtx() ctxMenu.Visible = false end

                for _, m in ipairs({"Toggle", "Hold", "Always"}) do
                    local btn = Instance.new("TextButton", ctxMenu)
                    btn.Size = UDim2.new(1, 0, 0, 20)
                    btn.BackgroundTransparency = 1
                    btn.Text = m
                    btn.TextColor3 = Color3.fromRGB(190, 190, 190)
                    btn.Font = Enum.Font.Code
                    btn.TextSize = 13
                    btn.ZIndex = 101

                    btn.MouseButton1Click:Connect(function()
                        Mode = m
                        ToggleFunctions.KeyMode = Mode
                        UpdateKeybindText()
                        closeCtx()
                        
                        if Mode == "Always" then
                            if not On then ToggleFunctions:Change() end
                        elseif Mode == "Toggle" or Mode == "Hold" then
                            if Mode == "Hold" and On then ToggleFunctions:Change() end
                        end
                    end)
                    btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenTable["keybind"], {TextColor3 = Color3.fromRGB(159, 115, 255)}):Play() end)
                    btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenTable["keybind"], {TextColor3 = Color3.fromRGB(190, 190, 190)}):Play() end)
                end

                UserInputService.InputBegan:Connect(function(input)
                    if ctxMenu.Visible and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) then
                        local mx, my = Mouse.X, Mouse.Y
                        local px, py = ctxMenu.AbsolutePosition.X, ctxMenu.AbsolutePosition.Y
                        local sx, sy = ctxMenu.AbsoluteSize.X, ctxMenu.AbsoluteSize.Y
                        if mx < px or mx > px + sx or my < py or my > py + sy then closeCtx() end
                    end
                end)

                keybind.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton2 then
                        local py = Mouse.Y
                        if py + 60 > workspace.CurrentCamera.ViewportSize.Y then py = py - 60 end
                        ctxMenu.Position = UDim2.new(0, Mouse.X, 0, py)
                        ctxMenu.Visible = true
                    end
                end)
    
                local function IsBindTriggered(input)
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        return input.KeyCode.Name == ChosenKey
                    else
                        return input.UserInputType.Name == ChosenKey
                    end
                end

                keybind.MouseButton1Click:Connect(function()
                    if Mode == "Always" then return end
                    keybindButtonLabel.Text = ". . ."
                    
                    local InputWait
                    local connection
                    connection = UserInputService.InputBegan:Connect(function(input)
                        if input.KeyCode ~= Enum.KeyCode.Unknown or input.UserInputType.Name:find("MouseButton") then
                            InputWait = input
                        end
                    end)
                    
                    repeat task.wait() until InputWait
                    connection:Disconnect()

                    if UserInputService.WindowFocused then
                        if InputWait.UserInputType == Enum.UserInputType.Keyboard then
                            ChosenKey = InputWait.KeyCode.Name
                        else
                            ChosenKey = InputWait.UserInputType.Name
                        end
                        ToggleFunctions.Key = ChosenKey
                        UpdateKeybindText()
                    end
                end)
    
                if UserInputService.WindowFocused then
                    UserInputService.InputBegan:Connect(function(c, p)
                        if not p then
                            if Mode == "Always" then return end
                            if IsBindTriggered(c) and not UserInputService:GetFocusedTextBox() then
                                if Mode == "Toggle" then
                                    ToggleFunctions:Change()
                                elseif Mode == "Hold" then
                                    if not On then ToggleFunctions:Change() end
                                end
                            end
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(c, p)
                        if not p then
                            if Mode == "Always" then return end
                            if IsBindTriggered(c) and not UserInputService:GetFocusedTextBox() then
                                if Mode == "Hold" then
                                    if On then ToggleFunctions:Change() end
                                end
                            end
                        end
                    end)
                end
    
                function ToggleFunctions:SetKey(new)
                    if typeof(new) == "EnumItem" then
                        ChosenKey = new.Name
                    else
                        ChosenKey = tostring(new)
                    end
                    ToggleFunctions.Key = ChosenKey
                    UpdateKeybindText()
                    return ToggleFunctions
                end
                function ToggleFunctions:SetMode(new)
                    Mode = new or Mode
                    ToggleFunctions.KeyMode = Mode
                    UpdateKeybindText()
                    if Mode == "Always" and not On then ToggleFunctions:Change() end
                    return ToggleFunctions
                end
                function ToggleFunctions:FireKey()
                    callback_t(ChosenKey)
                    return ToggleFunctions
                end
                function ToggleFunctions:HideKey()
                    keybind.Visible = false
                    return ToggleFunctions
                end
                function ToggleFunctions:ShowKey()
                    keybind.Visible = true
                    return ToggleFunctions
                end
                
                return ToggleFunctions
            end

            if default then
                toggleDesign.Size = UDim2.new(0, 12, 0, 12)
                toggleDesign.BackgroundTransparency = 0
                callback(true)
            end
            return ToggleFunctions
        end

        function Components:NewKeybind(text, default, callback)
            text = text or "keybind"
            default = default or Enum.KeyCode.P
            callback = callback or function() end

            local KeybindFunctions = {} -- Forward declare the table to prevent scoping error

            local keybindFrame = Instance.new("Frame")
            local keybindButton = Instance.new("TextButton")
            local keybindLayout = Instance.new("UIListLayout")
            local keybindLabel = Instance.new("TextLabel")
            local keybindPadding = Instance.new("UIPadding")
            local keybindFolder = Instance.new("Folder")
            local keybindFolderLayout = Instance.new("UIListLayout")
            local keybind = Instance.new("TextButton")
            local keybindCorner = Instance.new("UICorner")
            local keybindBackground = Instance.new("Frame")
            local keybindGradient = Instance.new("UIGradient")
            local keybindBackCorner = Instance.new("UICorner")
            local keybindButtonLabel = Instance.new("TextLabel")
            local keybindLabelStraint = Instance.new("UISizeConstraint")
            local keybindBackgroundStraint = Instance.new("UISizeConstraint")
            local keybindStraint = Instance.new("UISizeConstraint")

            keybindFrame.Name = "keybindFrame"
            keybindFrame.Parent = page
            keybindFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            keybindFrame.BackgroundTransparency = 1.000
            keybindFrame.ClipsDescendants = true
            keybindFrame.Size = UDim2.new(0, 396, 0, 24)

            keybindButton.Name = "keybindButton"
            keybindButton.Parent = keybindFrame
            keybindButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            keybindButton.BackgroundTransparency = 1.000
            keybindButton.Size = UDim2.new(0, 396, 0, 24)
            keybindButton.AutoButtonColor = false
            keybindButton.Font = Enum.Font.SourceSans
            keybindButton.Text = ""
            keybindButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            keybindButton.TextSize = 14.000

            keybindLayout.Name = "keybindLayout"
            keybindLayout.Parent = keybindButton
            keybindLayout.FillDirection = Enum.FillDirection.Horizontal
            keybindLayout.SortOrder = Enum.SortOrder.LayoutOrder
            keybindLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            keybindLayout.Padding = UDim.new(0, 4)

            keybindLabel.Name = "keybindLabel"
            keybindLabel.Parent = keybindButton
            keybindLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            keybindLabel.BackgroundTransparency = 1.000
            keybindLabel.Size = UDim2.new(0, 396, 0, 24)
            keybindLabel.Font = Enum.Font.Code
            keybindLabel.Text = text
            keybindLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
            keybindLabel.TextSize = 14.000
            keybindLabel.TextWrapped = true
            keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
            keybindLabel.RichText = true

            keybindPadding.Name = "keybindPadding"
            keybindPadding.Parent = keybindLabel
            keybindPadding.PaddingBottom = UDim.new(0, 6)
            keybindPadding.PaddingLeft = UDim.new(0, 2)
            keybindPadding.PaddingRight = UDim.new(0, 6)
            keybindPadding.PaddingTop = UDim.new(0, 6)

            keybindFolder.Name = "keybindFolder"
            keybindFolder.Parent = keybindFrame

            keybindFolderLayout.Name = "keybindFolderLayout"
            keybindFolderLayout.Parent = keybindFolder
            keybindFolderLayout.FillDirection = Enum.FillDirection.Horizontal
            keybindFolderLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
            keybindFolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
            keybindFolderLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            keybindFolderLayout.Padding = UDim.new(0, 4)

            keybind.Name = "keybind"
            keybind.Parent = keybindFolder
            keybind.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            keybind.Position = UDim2.new(0.780303001, 0, 0, 0)
            keybind.Size = UDim2.new(0, 87, 0, 22)
            keybind.AutoButtonColor = false
            keybind.Font = Enum.Font.SourceSans
            keybind.Text = ""
            keybind.TextColor3 = Color3.fromRGB(0, 0, 0)
            keybind.TextSize = 14.000
            keybind.Active = false

            keybindCorner.CornerRadius = UDim.new(0, 2)
            keybindCorner.Name = "keybindCorner"
            keybindCorner.Parent = keybind

            keybindBackground.Name = "keybindBackground"
            keybindBackground.Parent = keybind
            keybindBackground.AnchorPoint = Vector2.new(0.5, 0.5)
            keybindBackground.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            keybindBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
            keybindBackground.Size = UDim2.new(0, 85, 0, 20)

            keybindGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28))}
            keybindGradient.Rotation = 90
            keybindGradient.Name = "keybindGradient"
            keybindGradient.Parent = keybindBackground

            keybindBackCorner.CornerRadius = UDim.new(0, 2)
            keybindBackCorner.Name = "keybindBackCorner"
            keybindBackCorner.Parent = keybindBackground

            keybindButtonLabel.Name = "keybindButtonLabel"
            keybindButtonLabel.Parent = keybindBackground
            keybindButtonLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            keybindButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            keybindButtonLabel.BackgroundTransparency = 1.000
            keybindButtonLabel.ClipsDescendants = true
            keybindButtonLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
            keybindButtonLabel.Size = UDim2.new(0, 85, 0, 20)
            keybindButtonLabel.Font = Enum.Font.Code
            keybindButtonLabel.Text = ". . ."
            keybindButtonLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
            keybindButtonLabel.TextSize = 14.000
            keybindButtonLabel.RichText = true

            keybindLabelStraint.Name = "keybindLabelStraint"
            keybindLabelStraint.Parent = keybindButtonLabel
            keybindLabelStraint.MinSize = Vector2.new(28, 20)

            keybindBackgroundStraint.Name = "keybindBackgroundStraint"
            keybindBackgroundStraint.Parent = keybindBackground
            keybindBackgroundStraint.MinSize = Vector2.new(28, 20)

            keybindStraint.Name = "keybindStraint"
            keybindStraint.Parent = keybind
            keybindStraint.MinSize = Vector2.new(30, 22)

            local Shortcuts = { 
                Return = "enter",
                MouseButton1 = "m1",
                MouseButton2 = "m2",
                MouseButton3 = "m3",
                MouseButton4 = "m4",
                MouseButton5 = "m5"
            }
            local ChosenKey = default.Name or default
            local Mode = "Toggle"
            local State = false

            local function UpdateKeybindText()
                local display = Shortcuts[ChosenKey] or ChosenKey
                if Mode == "Always" then
                    keybindButtonLabel.Text = "[Always]"
                else
                    keybindButtonLabel.Text = display .. " [" .. Mode .. "]"
                end
            end

            keybindButtonLabel.Text = (Shortcuts[ChosenKey] or ChosenKey) .. " [Toggle]"
            CreateTween("keybind", 0.08)
            
            local function ResizeKeybind()
                local NewKeybindSize = TextService:GetTextSize(keybindButtonLabel.Text, keybindButtonLabel.TextSize, keybindButtonLabel.Font, Vector2.new(math.huge,math.huge))
                TweenService:Create(keybindButtonLabel, TweenTable["keybind"], {Size = UDim2.new(0, NewKeybindSize.X + 6, 0, 20)}):Play()
                TweenService:Create(keybindBackground, TweenTable["keybind"], {Size = UDim2.new(0, NewKeybindSize.X + 6, 0, 20)}):Play()
                TweenService:Create(keybind, TweenTable["keybind"], {Size = UDim2.new(0, NewKeybindSize.X + 8, 0, 22)}):Play()
            end
            keybindButtonLabel:GetPropertyChangedSignal("Text"):Connect(ResizeKeybind)
            ResizeKeybind()
            UpdatePageSize()

            -- [[ CONTEXT MENU UI ]]
            local ctxMenu = Instance.new("Frame")
            ctxMenu.Name = "CtxMenu"
            ctxMenu.Parent = page.Parent.Parent.Parent -- screen
            ctxMenu.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            ctxMenu.Size = UDim2.new(0, 80, 0, 60)
            ctxMenu.Visible = false
            ctxMenu.ZIndex = 100

            local ctxCorner = Instance.new("UICorner", ctxMenu)
            ctxCorner.CornerRadius = UDim.new(0, 4)
            local ctxStroke = Instance.new("UIStroke", ctxMenu)
            ctxStroke.Color = Color3.fromRGB(60, 60, 60)
            ctxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            local ctxLayout = Instance.new("UIListLayout", ctxMenu)
            ctxLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local function closeCtx() ctxMenu.Visible = false end

            for _, m in ipairs({"Toggle", "Hold", "Always"}) do
                local btn = Instance.new("TextButton", ctxMenu)
                btn.Size = UDim2.new(1, 0, 0, 20)
                btn.BackgroundTransparency = 1
                btn.Text = m
                btn.TextColor3 = Color3.fromRGB(190, 190, 190)
                btn.Font = Enum.Font.Code
                btn.TextSize = 13
                btn.ZIndex = 101

                btn.MouseButton1Click:Connect(function()
                    Mode = m
                    KeybindFunctions.KeyMode = Mode
                    UpdateKeybindText()
                    closeCtx()
                    
                    if Mode == "Always" then
                        State = true
                        callback(State, ChosenKey)
                    elseif Mode == "Toggle" or Mode == "Hold" then
                        if Mode == "Hold" and State then
                            State = false
                            callback(State, ChosenKey)
                        end
                    end
                end)
                btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenTable["keybind"], {TextColor3 = Color3.fromRGB(159, 115, 255)}):Play() end)
                btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenTable["keybind"], {TextColor3 = Color3.fromRGB(190, 190, 190)}):Play() end)
            end

            UserInputService.InputBegan:Connect(function(input)
                if ctxMenu.Visible and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) then
                    local mx, my = Mouse.X, Mouse.Y
                    local px, py = ctxMenu.AbsolutePosition.X, ctxMenu.AbsolutePosition.Y
                    local sx, sy = ctxMenu.AbsoluteSize.X, ctxMenu.AbsoluteSize.Y
                    if mx < px or mx > px + sx or my < py or my > py + sy then closeCtx() end
                end
            end)

            local function handleRightClick(input)
                if input.UserInputType == Enum.UserInputType.MouseButton2 then
                    local py = Mouse.Y
                    if py + 60 > workspace.CurrentCamera.ViewportSize.Y then py = py - 60 end
                    ctxMenu.Position = UDim2.new(0, Mouse.X, 0, py)
                    ctxMenu.Visible = true
                end
            end
            keybind.InputBegan:Connect(handleRightClick)
            keybindButton.InputBegan:Connect(handleRightClick)

            local function IsBindTriggered(input)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    return input.KeyCode.Name == ChosenKey
                else
                    return input.UserInputType.Name == ChosenKey
                end
            end

            local function ListenForKey()
                if Mode == "Always" then return end
                keybindButtonLabel.Text = ". . ."
                
                local InputWait
                local connection
                connection = UserInputService.InputBegan:Connect(function(input)
                    if input.KeyCode ~= Enum.KeyCode.Unknown or input.UserInputType.Name:find("MouseButton") then
                        InputWait = input
                    end
                end)
                
                repeat task.wait() until InputWait
                connection:Disconnect()

                if UserInputService.WindowFocused then
                    if InputWait.UserInputType == Enum.UserInputType.Keyboard then
                        ChosenKey = InputWait.KeyCode.Name
                    else
                        ChosenKey = InputWait.UserInputType.Name
                    end
                    KeybindFunctions.Key = ChosenKey
                    UpdateKeybindText()
                end
            end
            keybind.MouseButton1Click:Connect(ListenForKey)
            keybindButton.MouseButton1Click:Connect(ListenForKey)

            if UserInputService.WindowFocused then
                UserInputService.InputBegan:Connect(function(c, p)
                    if not p then
                        if Mode == "Always" then return end
                        if IsBindTriggered(c) and not UserInputService:GetFocusedTextBox() then
                            if Mode == "Toggle" then
                                State = not State
                                callback(State, ChosenKey)
                            elseif Mode == "Hold" then
                                State = true
                                callback(State, ChosenKey)
                            end
                        end
                    end
                end)
                UserInputService.InputEnded:Connect(function(c, p)
                    if not p then
                        if Mode == "Always" then return end
                        if IsBindTriggered(c) and not UserInputService:GetFocusedTextBox() then
                            if Mode == "Hold" then
                                State = false
                                callback(State, ChosenKey)
                            end
                        end
                    end
                end)
            end

            UpdatePageSize()

            -- We define key and keymode into the forward-declared table
            KeybindFunctions.Key = ChosenKey
            KeybindFunctions.KeyMode = Mode
            function KeybindFunctions:Fire() callback(State, ChosenKey) return KeybindFunctions end
            function KeybindFunctions:SetFunction(new) callback = new or function() end return KeybindFunctions end
            function KeybindFunctions:SetKey(new) 
                if typeof(new) == "EnumItem" then
                    ChosenKey = new.Name
                else
                    ChosenKey = tostring(new)
                end
                KeybindFunctions.Key = ChosenKey
                UpdateKeybindText()
                return KeybindFunctions 
            end
            function KeybindFunctions:SetMode(new) Mode = new or Mode; KeybindFunctions.KeyMode = Mode; UpdateKeybindText(); return KeybindFunctions end
            function KeybindFunctions:Text(new) keybindLabel.Text = new or keybindLabel.Text; return KeybindFunctions end
            function KeybindFunctions:Hide() keybindFrame.Visible = false return KeybindFunctions end
            function KeybindFunctions:Show() keybindFrame.Visible = true return KeybindFunctions end
            
            return KeybindFunctions
        end
```