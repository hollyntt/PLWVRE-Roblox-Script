-- Restructured to support dynamic loader settings and full safety guards

getgenv().SkeletonSettings = getgenv().SkeletonSettings or {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    Thickness = 1,
    Transparency = 1,
    
    TeamCheck = true,
    TeamColor = Color3.fromRGB(0, 255, 0),
    EnemyColor = Color3.fromRGB(255, 0, 0),
    UseTeamColor = true,
}

local Settings = getgenv().SkeletonSettings

----------------------------------------------------------------

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local Camera = game:GetService("Workspace").CurrentCamera

local function DrawLine()
    local l = Drawing.new("Line")
    l.Visible = false
    l.From = Vector2.new(0, 0)
    l.To = Vector2.new(1, 1)
    l.Color = Settings.Color
    l.Thickness = Settings.Thickness
    l.Transparency = Settings.Transparency
    return l
end

local function DrawESP(plr)
    repeat task.wait() until plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil
    local limbs = {}
    local R15 = (plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15) and true or false
    if R15 then 
        limbs = {
            -- Spine
            Head_UpperTorso = DrawLine(),
            UpperTorso_LowerTorso = DrawLine(),
            -- Left Arm
            UpperTorso_LeftUpperArm = DrawLine(),
            LeftUpperArm_LeftLowerArm = DrawLine(),
            LeftLowerArm_LeftHand = DrawLine(),
            -- Right Arm
            UpperTorso_RightUpperArm = DrawLine(),
            RightUpperArm_RightLowerArm = DrawLine(),
            RightLowerArm_RightHand = DrawLine(),
            -- Left Leg
            LowerTorso_LeftUpperLeg = DrawLine(),
            LeftUpperLeg_LeftLowerLeg = DrawLine(),
            LeftLowerLeg_LeftFoot = DrawLine(),
            -- Right Leg
            LowerTorso_RightUpperLeg = DrawLine(),
            RightUpperLeg_RightLowerLeg = DrawLine(),
            RightLowerLeg_RightFoot = DrawLine(),
        }
    else 
        limbs = {
            Head_Spine = DrawLine(),
            Spine = DrawLine(),
            LeftArm = DrawLine(),
            LeftArm_UpperTorso = DrawLine(),
            RightArm = DrawLine(),
            RightArm_UpperTorso = DrawLine(),
            LeftLeg = DrawLine(),
            LeftLeg_LowerTorso = DrawLine(),
            RightLeg = DrawLine(),
            RightLeg_LowerTorso = DrawLine()
        }
    end

    local function Visibility(state)
        for i, v in pairs(limbs) do
            v.Visible = state
        end
    end

    local function UpdaterR15()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            -- Handle global toggle
            if not Settings.Enabled then
                Visibility(false)
                return
            end

            local char = plr.Character
            if char ~= nil and char:FindFirstChild("Humanoid") ~= nil and char:FindFirstChild("HumanoidRootPart") ~= nil and char.Humanoid.Health > 0 then
                
                -- Guard: Ensure every single required R15 limb is fully loaded to prevent indexing nil errors
                local head = char:FindFirstChild("Head")
                local ut = char:FindFirstChild("UpperTorso")
                local lt = char:FindFirstChild("LowerTorso")
                local lua = char:FindFirstChild("LeftUpperArm")
                local lla = char:FindFirstChild("LeftLowerArm")
                local lh = char:FindFirstChild("LeftHand")
                local rua = char:FindFirstChild("RightUpperArm")
                local rla = char:FindFirstChild("RightLowerArm")
                local rh = char:FindFirstChild("RightHand")
                local lul = char:FindFirstChild("LeftUpperLeg")
                local lll = char:FindFirstChild("LeftLowerLeg")
                local lf = char:FindFirstChild("LeftFoot")
                local rul = char:FindFirstChild("RightUpperLeg")
                local rll = char:FindFirstChild("RightLowerLeg")
                local rf = char:FindFirstChild("RightFoot")

                if head and ut and lt and lua and lla and lh and rua and rla and rh and lul and lll and lf and rul and rll and rf then
                    local HUM, vis = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
                    if vis then
                        -- Math transformations
                        local H = Camera:WorldToViewportPoint(head.Position)
                        local UT_p = Camera:WorldToViewportPoint(ut.Position)
                        local LT_p = Camera:WorldToViewportPoint(lt.Position)
                        local LUA_p = Camera:WorldToViewportPoint(lua.Position)
                        local LLA_p = Camera:WorldToViewportPoint(lla.Position)
                        local LH_p = Camera:WorldToViewportPoint(lh.Position)
                        local RUA_p = Camera:WorldToViewportPoint(rua.Position)
                        local RLA_p = Camera:WorldToViewportPoint(rla.Position)
                        local RH_p = Camera:WorldToViewportPoint(rh.Position)
                        local LUL_p = Camera:WorldToViewportPoint(lul.Position)
                        local LLL_p = Camera:WorldToViewportPoint(lll.Position)
                        local LF_p = Camera:WorldToViewportPoint(lf.Position)
                        local RUL_p = Camera:WorldToViewportPoint(rul.Position)
                        local RLL_p = Camera:WorldToViewportPoint(rll.Position)
                        local RF_p = Camera:WorldToViewportPoint(rf.Position)

                        -- Determine Color Settings Dynamically
                        local targetColor = Settings.Color
                        if Settings.UseTeamColor then
                            if Settings.TeamCheck and plr.Team == Player.Team then
                                targetColor = Settings.TeamColor
                            else
                                targetColor = Settings.EnemyColor
                            end
                        end

                        -- Sync formatting properties in real-time
                        for _, line in pairs(limbs) do
                            line.Color = targetColor
                            line.Thickness = Settings.Thickness
                            line.Transparency = Settings.Transparency
                        end

                        -- Head to Upper Torso
                        limbs.Head_UpperTorso.From = Vector2.new(H.X, H.Y)
                        limbs.Head_UpperTorso.To = Vector2.new(UT_p.X, UT_p.Y)

                        -- Spine
                        limbs.UpperTorso_LowerTorso.From = Vector2.new(UT_p.X, UT_p.Y)
                        limbs.UpperTorso_LowerTorso.To = Vector2.new(LT_p.X, LT_p.Y)

                        -- Left Arm
                        limbs.UpperTorso_LeftUpperArm.From = Vector2.new(UT_p.X, UT_p.Y)
                        limbs.UpperTorso_LeftUpperArm.To = Vector2.new(LUA_p.X, LUA_p.Y)

                        limbs.LeftUpperArm_LeftLowerArm.From = Vector2.new(LUA_p.X, LUA_p.Y)
                        limbs.LeftUpperArm_LeftLowerArm.To = Vector2.new(LLA_p.X, LLA_p.Y)

                        limbs.LeftLowerArm_LeftHand.From = Vector2.new(LLA_p.X, LLA_p.Y)
                        limbs.LeftLowerArm_LeftHand.To = Vector2.new(LH_p.X, LH_p.Y)

                        -- Right Arm
                        limbs.UpperTorso_RightUpperArm.From = Vector2.new(UT_p.X, UT_p.Y)
                        limbs.UpperTorso_RightUpperArm.To = Vector2.new(RUA_p.X, RUA_p.Y)

                        limbs.RightUpperArm_RightLowerArm.From = Vector2.new(RUA_p.X, RUA_p.Y)
                        limbs.RightUpperArm_RightLowerArm.To = Vector2.new(RLA_p.X, RLA_p.Y)

                        limbs.RightLowerArm_RightHand.From = Vector2.new(RLA_p.X, RLA_p.Y)
                        limbs.RightLowerArm_RightHand.To = Vector2.new(RH_p.X, RH_p.Y)

                        -- Left Leg
                        limbs.LowerTorso_LeftUpperLeg.From = Vector2.new(LT_p.X, LT_p.Y)
                        limbs.LowerTorso_LeftUpperLeg.To = Vector2.new(LUL_p.X, LUL_p.Y)

                        limbs.LeftUpperLeg_LeftLowerLeg.From = Vector2.new(LUL_p.X, LUL_p.Y)
                        limbs.LeftUpperLeg_LeftLowerLeg.To = Vector2.new(LLL_p.X, LLL_p.Y)

                        limbs.LeftLowerLeg_LeftFoot.From = Vector2.new(LLL_p.X, LLL_p.Y)
                        limbs.LeftLowerLeg_LeftFoot.To = Vector2.new(LF_p.X, LF_p.Y)

                        -- Right Leg
                        limbs.LowerTorso_RightUpperLeg.From = Vector2.new(LT_p.X, LT_p.Y)
                        limbs.LowerTorso_RightUpperLeg.To = Vector2.new(RUL_p.X, RUL_p.Y)

                        limbs.RightUpperLeg_RightLowerLeg.From = Vector2.new(RUL_p.X, RUL_p.Y)
                        limbs.RightUpperLeg_RightLowerLeg.To = Vector2.new(RLL_p.X, RLL_p.Y)

                        limbs.RightLowerLeg_RightFoot.From = Vector2.new(RLL_p.X, RLL_p.Y)
                        limbs.RightLowerLeg_RightFoot.To = Vector2.new(RF_p.X, RF_p.Y)

                        Visibility(true)
                    else
                        Visibility(false)
                    end
                else
                    Visibility(false)
                end
            else 
                Visibility(false)
                if game.Players:FindFirstChild(plr.Name) == nil then 
                    for i, v in pairs(limbs) do
                        v:Remove()
                    end
                    connection:Disconnect()
                end
            end
        end)
    end

    local function UpdaterR6()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            -- Handle global toggle
            if not Settings.Enabled then
                Visibility(false)
                return
            end

            local char = plr.Character
            if char ~= nil and char:FindFirstChild("Humanoid") ~= nil and char:FindFirstChild("HumanoidRootPart") ~= nil and char.Humanoid.Health > 0 then
                
                -- Guard: Ensure every single required R6 limb is fully loaded to prevent indexing nil errors
                local head = char:FindFirstChild("Head")
                local torso = char:FindFirstChild("Torso")
                local leftArm = char:FindFirstChild("Left Arm")
                local rightArm = char:FindFirstChild("Right Arm")
                local leftLeg = char:FindFirstChild("Left Leg")
                local rightLeg = char:FindFirstChild("Right Leg")

                if head and torso and leftArm and rightArm and leftLeg and rightLeg then
                    local HUM, vis = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
                    if vis then
                        local H = Camera:WorldToViewportPoint(head.Position)
                        
                        local T_Height = torso.Size.Y/2 - 0.2
                        local UT = Camera:WorldToViewportPoint((torso.CFrame * CFrame.new(0, T_Height, 0)).p)
                        local LT = Camera:WorldToViewportPoint((torso.CFrame * CFrame.new(0, -T_Height, 0)).p)

                        local LA_Height = leftArm.Size.Y/2 - 0.2
                        local LUA = Camera:WorldToViewportPoint((leftArm.CFrame * CFrame.new(0, LA_Height, 0)).p)
                        local LLA = Camera:WorldToViewportPoint((leftArm.CFrame * CFrame.new(0, -LA_Height, 0)).p)

                        local RA_Height = rightArm.Size.Y/2 - 0.2
                        local RUA = Camera:WorldToViewportPoint((rightArm.CFrame * CFrame.new(0, RA_Height, 0)).p)
                        local RLA = Camera:WorldToViewportPoint((rightArm.CFrame * CFrame.new(0, -RA_Height, 0)).p)

                        local LL_Height = leftLeg.Size.Y/2 - 0.2
                        local LUL = Camera:WorldToViewportPoint((leftLeg.CFrame * CFrame.new(0, LL_Height, 0)).p)
                        local LLL = Camera:WorldToViewportPoint((leftLeg.CFrame * CFrame.new(0, -LL_Height, 0)).p)

                        local RL_Height = rightLeg.Size.Y/2 - 0.2
                        local RUL = Camera:WorldToViewportPoint((rightLeg.CFrame * CFrame.new(0, RL_Height, 0)).p)
                        local RLL = Camera:WorldToViewportPoint((rightLeg.CFrame * CFrame.new(0, -RL_Height, 0)).p)

                        -- Determine Color Settings Dynamically
                        local targetColor = Settings.Color
                        if Settings.UseTeamColor then
                            if Settings.TeamCheck and plr.Team == Player.Team then
                                targetColor = Settings.TeamColor
                            else
                                targetColor = Settings.EnemyColor
                            end
                        end

                        -- Sync formatting properties in real-time
                        for _, line in pairs(limbs) do
                            line.Color = targetColor
                            line.Thickness = Settings.Thickness
                            line.Transparency = Settings.Transparency
                        end

                        -- Head to Spine top
                        limbs.Head_Spine.From = Vector2.new(H.X, H.Y)
                        limbs.Head_Spine.To = Vector2.new(UT.X, UT.Y)

                        -- Spine
                        limbs.Spine.From = Vector2.new(UT.X, UT.Y)
                        limbs.Spine.To = Vector2.new(LT.X, LT.Y)

                        -- Left Arm
                        limbs.LeftArm.From = Vector2.new(LUA.X, LUA.Y)
                        limbs.LeftArm.To = Vector2.new(LLA.X, LLA.Y)

                        limbs.LeftArm_UpperTorso.From = Vector2.new(UT.X, UT.Y)
                        limbs.LeftArm_UpperTorso.To = Vector2.new(LUA.X, LUA.Y)

                        -- Right Arm
                        limbs.RightArm.From = Vector2.new(RUA.X, RUA.Y)
                        limbs.RightArm.To = Vector2.new(RLA.X, RLA.Y)

                        limbs.RightArm_UpperTorso.From = Vector2.new(UT.X, UT.Y)
                        limbs.RightArm_UpperTorso.To = Vector2.new(RUA.X, RUA.Y)

                        -- Left Leg
                        limbs.LeftLeg.From = Vector2.new(LUL.X, LUL.Y)
                        limbs.LeftLeg.To = Vector2.new(LLL.X, LLL.Y)

                        limbs.LeftLeg_LowerTorso.From = Vector2.new(LT.X, LT.Y)
                        limbs.LeftLeg_LowerTorso.To = Vector2.new(LUL.X, LUL.Y)

                        -- Right Leg
                        limbs.RightLeg.From = Vector2.new(RUL.X, RUL.Y)
                        limbs.RightLeg.To = Vector2.new(RLL.X, RLL.Y)

                        limbs.RightLeg_LowerTorso.From = Vector2.new(LT.X, LT.Y)
                        limbs.RightLeg_LowerTorso.To = Vector2.new(RUL.X, RUL.Y)

                        Visibility(true)
                    else
                        Visibility(false)
                    end
                else
                    Visibility(false)
                end
            else 
                Visibility(false)
                if game.Players:FindFirstChild(plr.Name) == nil then 
                    for i, v in pairs(limbs) do
                        v:Remove()
                    end
                    connection:Disconnect()
                end
            end
        end)
    end

    if R15 then
        coroutine.wrap(UpdaterR15)()
    else 
        coroutine.wrap(UpdaterR6)()
    end
end

for i, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v.Name ~= Player.Name then
        DrawESP(v)
    end
end

game.Players.PlayerAdded:Connect(function(newplr)
    if newplr.Name ~= Player.Name then
        DrawESP(newplr)
    end
end)