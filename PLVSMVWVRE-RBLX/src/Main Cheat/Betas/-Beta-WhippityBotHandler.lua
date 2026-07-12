

Nexus_Version = 104

local FileName, Success, Error, Function = 'ic3w0lf22.Nexus.lua'

-- Load existing file if available
if isfile and readfile and isfile(FileName) then
    Function, Error = loadstring(readfile(FileName), 'Nexus')
    
    if Function then
        Function()
        if Nexus then Nexus:Connect() end
    end
end

-- Attempt to download and update the script
for i = 1, 10 do
    Success, Error = pcall(function()
        local Response = (http_request or (syn and syn.request)) {
            Method = 'GET',
            Url = 'https://raw.githubusercontent.com/ic3w0lf22/Roblox-Account-Manager/master/RBX%20Alt%20Manager/Nexus/Nexus.lua'
        }

        if not Response.Success then error(('HTTP Error %s'):format(Response.StatusCode)) end

        Function, Error = loadstring(Response.Body, 'Nexus')
        if not Function then error(Error) end

        if isfile and not isfile(FileName) then
            writefile(FileName, Response.Body)
        end
        
        if not Nexus then
            Function()
            print("✨ Meowijuana | Bot Handler Initialized")
            Nexus:Connect()
        end
    end)
    
    if Success then break else task.wait(1) end
end

if not Success and Error then
    (messagebox or print)(('Nexus encountered an error while launching!\n\n%s'):format(Error), 'Roblox Account Manager', 0)
end

-- Nexus Module Implementation
if not Nexus then
    Nexus = {
        Version = Nexus_Version,
        Commands = {},
        IsConnected = false,
        ShutdownTime = 30, -- Default shutdown time in seconds
        _Elements = {},
        _ButtonCallbacks = {},
        _MessageQueue = {},
        _MessageCallbacks = {},
        _Socket = nil
    }

    -- Signals
    Nexus.Connected = Instance.new("BindableEvent")
    Nexus.Disconnected = Instance.new("BindableEvent")
    Nexus.MessageReceived = Instance.new("BindableEvent")

    -- Connection Management
    function Nexus:Connect(Host)
        Host = Host or 'localhost:5242'
        
        if self._Socket then
            self._Socket:Close()
        end
        
        self.IsConnected = false
        
        -- Simulate WebSocket connection (actual implementation would vary)
        self._Socket = {
            Send = function(self, data)
                -- In a real implementation, this would send data over WebSocket
                print("[Nexus] Sent:", data)
            end,
            Close = function(self)
                self.Connected = false
                Nexus.IsConnected = false
                Nexus.Disconnected:Fire()
            end,
            Connected = false
        }
        
        -- Simulate successful connection
        task.spawn(function()
            task.wait(1) -- Simulate connection delay
            self._Socket.Connected = true
            self.IsConnected = true
            self.Connected:Fire()
        end)
    end

    function Nexus:Stop()
        if self._Socket then
            self._Socket:Close()
        end
    end

    -- Messaging
    function Nexus:Send(Command, Payload)
        if not self.IsConnected then return end
        
        local message = {
            Command = Command,
            Payload = Payload or {}
        }
        
        self._Socket:Send(game:GetService("HttpService"):JSONEncode(message))
    end

    function Nexus:Log(...)
        local args = {...}
        local message = table.concat(args, " ")
        self:Send('Log', {Content = message})
    end

    function Nexus:Echo(...)
        local args = {...}
        local message = table.concat(args, " ")
        self:Send('Echo', {Content = message})
    end

    -- UI Elements
    function Nexus:CreateButton(Name, Content, Size, Margins, ExtraPayload)
        self._Elements[Name] = {
            Type = "Button",
            Content = Content,
            Size = Size or {100, 20},
            Margins = Margins or {10, 10, 10, 10},
            ExtraPayload = ExtraPayload or {}
        }
        self:Send('CreateElement', {
            Type = "Button",
            Name = Name,
            Content = Content,
            Size = Size,
            Margins = Margins,
            ExtraPayload = ExtraPayload
        })
    end

    function Nexus:CreateTextBox(Name, Content, Size, Margins, ExtraPayload)
        self._Elements[Name] = {
            Type = "TextBox",
            Content = Content,
            Size = Size or {100, 20},
            Margins = Margins or {10, 10, 10, 10},
            ExtraPayload = ExtraPayload or {}
        }
        self:Send('CreateElement', {
            Type = "TextBox",
            Name = Name,
            Content = Content,
            Size = Size,
            Margins = Margins,
            ExtraPayload = ExtraPayload
        })
    end

    function Nexus:CreateLabel(Name, Content, Size, Margins, ExtraPayload)
        self._Elements[Name] = {
            Type = "Label",
            Content = Content,
            Size = Size or {100, 20},
            Margins = Margins or {10, 10, 10, 10},
            ExtraPayload = ExtraPayload or {}
        }
        self:Send('CreateElement', {
            Type = "Label",
            Name = Name,
            Content = Content,
            Size = Size,
            Margins = Margins,
            ExtraPayload = ExtraPayload
        })
    end

    function Nexus:CreateNumeric(Name, Value, DecimalPlaces, Increment, Size, Margins)
        self._Elements[Name] = {
            Type = "Numeric",
            Value = Value or 0,
            DecimalPlaces = DecimalPlaces or 0,
            Increment = Increment or 1,
            Size = Size or {100, 20},
            Margins = Margins or {10, 10, 10, 10}
        }
        self:Send('CreateElement', {
            Type = "Numeric",
            Name = Name,
            Value = Value,
            DecimalPlaces = DecimalPlaces,
            Increment = Increment,
            Size = Size,
            Margins = Margins
        })
    end

    function Nexus:NewLine()
        self:Send('NewLine', {})
    end

    -- Element Interaction
    function Nexus:GetText(Name)
        if not self._Elements[Name] then return nil end
        return self._Elements[Name].Content
    end

    function Nexus:WaitForMessage(Header, Message, Payload)
        local id = tostring(math.random(1, 1000000))
        local response
        
        self._MessageCallbacks[id] = function(msg)
            response = msg
        end
        
        self:Send(Header, {
            Message = Message,
            Payload = Payload or {},
            Id = id
        })
        
        while not response do
            task.wait()
        end
        
        return response
    end

    -- Account Control
    function Nexus:SetRelaunch(Seconds)
        self:Send('SetRelaunch', {Seconds = Seconds})
    end

    function Nexus:SetAutoRelaunch(Enabled)
        self:Send('SetAutoRelaunch', {Enabled = Enabled})
    end

    function Nexus:SetPlaceId(PlaceId)
        self:Send('SetPlaceId', {PlaceId = PlaceId})
    end

    function Nexus:SetJobId(JobId)
        self:Send('SetJobId', {JobId = JobId})
    end

    -- Command Management
    function Nexus:AddCommand(CommandName, Function)
        self.Commands[CommandName] = Function
    end

    function Nexus:RemoveCommand(CommandName)
        self.Commands[CommandName] = nil
    end

    function Nexus:OnButtonClick(Name, Function)
        self._ButtonCallbacks[Name] = Function
    end

    -- Default Commands
    Nexus:AddCommand("Reexecute", function()
        loadstring("https://catnip.at.ua/Meowijuana.Loader.lua")()
    end)

    Nexus:AddCommand("Teleport", function(args)
        local placeId, jobId = args:match("(%d+)%s?(.*)")
        if placeId then
            if jobId and #jobId > 0 then
                game:GetService("TeleportService"):TeleportToPlaceInstance(tonumber(placeId), jobId)
            else
                game:GetService("TeleportService"):Teleport(tonumber(placeId))
            end
        end
    end)


    Nexus:AddCommand("Rejoin", function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end)

    Nexus:AddCommand("Mute", function()
        -- Implementation for muting the game
        settings().Rendering.Mute = true
    end)

    Nexus:AddCommand("Unmute", function()
        -- Implementation for unmuting the game
        settings().Rendering.Mute = false
    end)

    Nexus:AddCommand("Performance", function(args)
        local targetFPS = tonumber(args) or 6
        -- Set graphics level
        settings().Rendering.QualityLevel = 1
        -- Set FPS cap if FPS unlocker is present
        if setfpscap then
            setfpscap(targetFPS)
        end
        -- Disable rendering when not focused
        settings().Rendering.EnableFRM = false
    end)

    -- Process incoming messages (simulated)
    function Nexus._ProcessMessage(message)
        local decoded = game:GetService("HttpService"):JSONDecode(message)
        
        if decoded.Command == "MessageReceived" then
            Nexus.MessageReceived:Fire(decoded.Payload.Message)
        elseif decoded.Command == "ButtonClicked" then
            local callback = Nexus._ButtonCallbacks[decoded.Payload.Name]
            if callback then callback() end
        elseif decoded.Command == "Response" and decoded.Payload.Id then
            local callback = Nexus._MessageCallbacks[decoded.Payload.Id]
            if callback then callback(decoded.Payload.Message) end
            Nexus._MessageCallbacks[decoded.Payload.Id] = nil
        end
    end

    -- Initialize
    print("✨ Meowijuana | Bot Handler Initialized")
    Nexus:Connect()

    Nexus:SetJobId(game.JobId)
    Nexus:SetPlaceId(game.PlaceId)
end

-- Loadstring support
local originalLoadstring = loadstring or load
function loadstring(str, chunkname)
    -- Check if it's a Nexus command
    if str:match("^Nexus%.") or str:match("^Nexus:") then
        return originalLoadstring("return " .. str, chunkname)
    end
    return originalLoadstring(str, chunkname)
end

if _G.loadstring ~= loadstring then
    _G.loadstring = loadstring
end

function OnUpdate()
    ChatSpammer()
end

EventConnections.OnUpdate = RunService.Heartbeat:Connect(OnUpdate)