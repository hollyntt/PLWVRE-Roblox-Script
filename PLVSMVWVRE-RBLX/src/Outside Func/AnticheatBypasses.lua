local function Initiate()
    local StarterGUI = game:GetService("StarterGui")
    local PlayerGUI = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local ReplicatedFirst = game:GetService("ReplicatedFirst")
    local StarterCharacterScripts = game.StarterPlayer.StarterPlayerScripts
    local RunService = game:GetService("RunService")
    local Workspace = game.workspace

    local Found_KnightmareAntiCheatDebugGUI_Starter = StarterGUI:FindFirstChild("KnightmareAntiCheatDebugGUI")
    local Found_KnightmareAntiCheatDebugGUI_Player = PlayerGUI:FindFirstChild("KnightmareAntiCheatDebugGUI")

    local Found_Zaraza_AntiCheat = Workspace:FindFirstChild("Zaraza Anticheat")
    local Zaraza_AntiCheat_RemoteEvent = ReplicatedStorage:FindFirstChild("ZarazaRemote")
    local Zaraza_AntiCheat_SCS = StarterCharacterScripts:FindFirstChild("Zaraza")

    local IAC_AntiCheat_RemoteEvent = ReplicatedStorage:FindFirstChild("iac-respond")
    local IAC_AntiCheat_RF = ReplicatedFirst:FindFirstChild("IndexAntiCheat")

    function antickick()
        if getrawmetatable then
            function formatargs(getArgs,v)
                if #getArgs == 0 then 
                    return "" 
                end
                
                local collectArgs = {}
                for k,v in next,getArgs do
                    local argument = ""
                    if type(v) == "string" then
                        argument = "\""..v.."\""
                    elseif type(v) == "table" then
                        argument = "{" .. formatargs(v,true) .. "}"
                    else
                        argument = tostring(v)
                    end
                    if v and type(k) ~= "number" then
                        table.insert(collectArgs,k.."="..argument)
                    else
                        table.insert(collectArgs,argument)
                    end
                end
                return table.concat(collectArgs, ", ")
            end
            
            kicknum = 0
            local game_meta = getrawmetatable(game)
            local game_namecall = game_meta.__namecall
            local game_index = game_meta.__index
            local w = (setreadonly or fullaccess or make_writeable)
            pcall(w, game_meta, false)
            game_meta.__namecall = function(out, ...)
                local args = {...}
                local Method = args[#args]
                args[#args] = nil
                
                if Method == "Kick" and out == LP then
                    kicknum = kicknum + 1
                    warn("Blocked client-kick attempt "..kicknum)
                    return
                end
                
                if antiremotes then
                    if Method == "FireServer" or Method == "InvokeServer" then
                        if out.Name ~= "CharacterSoundEvent" and out.Name ~= "SayMessageRequest" and out.Name ~= "AddCharacterLoadedEvent" and out.Name ~= "RemoveCharacterEvent" and out.Name ~= "DefaultServerSoundEvent" and out.Parent ~= "DefaultChatSystemChatEvents" then
                            warn("Blocked remote: "..out.Name.." // Method: "..Method)
                            return
                        end
                    end
                else
                    if Method == "FireServer" or Method == "InvokeServer" then
                        for i,noremote in pairs(blockedremotes) do
                            if out.Name == noremote and out.Name ~= "SayMessageRequest" then
                                warn("Blocked remote: "..out.Name.." // Method: "..Method)
                                return
                            end
                        end
                    end
                end
                
                if spyingremotes then
                    if Method == "FireServer" or Method == "InvokeServer" then
                        if out.Name ~= "CharacterSoundEvent" and out.Name ~= "AddCharacterLoadedEvent" and out.Name ~= "RemoveCharacterEvent" and out.Name ~= "DefaultServerSoundEvent" and out.Name ~= "SayMessageRequest" then
                            local arguments = {}
                            for i = 1,#args do
                                arguments[i] = args[i]
                            end
                            local getScript = getfenv(2).script
                            if getScript == nil then
                                getScript = "??? (Not Found) ???"
                            end
                            warn("<> <> <> A "..out.ClassName.." has been fired! How to fire:\ngame."..out:GetFullName()..":"..Method.."("..formatargs(arguments)..")\n\nFired from script: ".. tostring(getScript:GetFullName()))
                        end
                    end
                end
                
                return game_namecall(out, ...)
            end
        end
    end

    local function RemoveKnightmareAntiCheatDebugGUI()
        Found_KnightmareAntiCheatDebugGUI_Starter:Destroy()
        Found_KnightmareAntiCheatDebugGUI_Player:Destroy()
    end

    local function RemoveZaraza()
        Found_Zaraza_AntiCheat:Destroy()
        Zaraza_AntiCheat_SCS:Destroy()
    end

    local function RemoveAdonis()
        local getinfo = getinfo or debug.getinfo
        local DEBUG = true
        local Hooked = {}
        
        local Detected, Kill
        
        setthreadidentity(2)
        
        for i, v in getgc(true) do
            if typeof(v) == "table" then
                local DetectFunc = rawget(v, "Detected")
                local KillFunc = rawget(v, "Kill")
            
                if typeof(DetectFunc) == "function" and not Detected then
                    Detected = DetectFunc
                    
                    local Old; Old = hookfunction(Detected, function(Action, Info, NoCrash)
                        if Action ~= "_" then
                            if DEBUG then
                                warn(`Adonis AntiCheat flagged\nMethod: {Action}\nInfo: {Info}`)
                            end
                        end
                        
                        return true
                    end)
        
                    table.insert(Hooked, Detected)
                end
        
                if rawget(v, "Variables") and rawget(v, "Process") and typeof(KillFunc) == "function" and not Kill then
                    Kill = KillFunc
                    local Old; Old = hookfunction(Kill, function(Info)
                        if DEBUG then
                            warn(`Adonis AntiCheat tried to kill (fallback): {Info}`)
                        end
                    end)
        
                    table.insert(Hooked, Kill)
                end
            end
        end
        
        local Old; Old = hookfunction(getrenv().debug.info, newcclosure(function(...)
            local LevelOrFunc, Info = ...
        
            if Detected and LevelOrFunc == Detected then
                if DEBUG then
                    warn(`zins | adonis bypassed`)
                end
        
                return coroutine.yield(coroutine.running())
            end
            
            return Old(...)
        end))
        -- setthreadidentity(9)
        setthreadidentity(7)
    end

    local function RemoveIAC()
        IAC_AntiCheat_RemoteEvent:Destroy()
        IAC_AntiCheat_RF:Destroy()
    end

    function AdonisAnticheat()
        RemoveAdonis()
    end

    function KnightmareAntiCheatDebugGUI()
        if Found_KnightmareAntiCheatDebugGUI_Starter or Found_KnightmareAntiCheatDebugGUI_Player then
            RemoveKnightmareAntiCheatDebugGUI()
        end
    end

    function IndexAntiCheatDetector()
        if IAC_AntiCheat_RF or IAC_AntiCheat_RemoteEvent then
            RemoveIAC()
        end
    end


    function ZarazaAC(Value)
        if Found_Zaraza_AntiCheat then
            RemoveZaraza()
        end
    end

    if Found_KnightmareAntiCheatDebugGUI_Starter or Found_KnightmareAntiCheatDebugGUI_Player then
        print("found Knightmare AntiCheat.")
        KnightmareAntiCheatDebugGUI()
        antickick()
    elseif Found_Zaraza_AntiCheat then
        print("found Zaraza AntiCheat.")
        ZarazaAC()
        antickick()
    elseif IAC_AntiCheat_RF then
        print("found IAC AntiCheat.")
        IndexAntiCheatDetector()
        antickick()
    else
        antickick()
        AdonisAnticheat()
    end
end

Initiate()