-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |                                 If Adonis Exists Kill him Method                                |
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
function Deob()
    --// Known service names (hardcoded for compatibility)
    local KNOWN_SERVICES = {
        "AccessControlService",
        "AnimationControllerService",
        "AssetService",
        "AssetTrackerService",
        "BadgeService",
        "BrowserService",
        "Chat",
        "ClientSettingsService",
        "CollectionService",
        "CommonUIService",
        "ContentProvider",
        "CoreGui",
        "CorePackages",
        "DataModelMeshService",
        "DataStoreService",
        "DebugSettings",
        "DiagnosticsService",
        "DialogService",
        "DiscordIntegrationService",
        "DistributedGameMaster",
        "EconomyService",
        "ExperienceProvider",
        "FacebookService",
        "FavoritesService",
        "FriendService",
        "GamePassService",
        "GameSettingService",
        "GenericSettings",
        "Geometry",
        "GoogleService",
        "GuidanceService",
        "GuiService",
        "HttpService",
        "IdService",
        "InsertService",
        "InternalAnimationSupport",
        "InternalAsyncLoaderService",
        "InternalRandomAdditionService",
        "InventoryService",
        "JobResponseManager",
        "KeyValueStoreService",
        "LanguageService",
        "LegacyScriptContext",
        "Lighting",
        "LocalizationService",
        "LogService",
        "MarketplaceService",
        "MaterialService",
        "MessagingService",
        "ModalDialogService",
        "ModelMeshService",
        "NetworkPeer",
        "NetworkReplicator",
        "NotificationService",
        "PackageService",
        "PathfindingModifierService",
        "PermissionService",
        "PhysicsService",
        "PointsService",
        "PolicyService",
        "PlayerConfiguration",
        "Players",
        "PluginDebugService",
        "PluginExecutionCoordinator",
        "PluginLogger",
        "PluginManager",
        "PluginSecurity",
        "PluginTraceService",
        "PostureController",
        "ProcessService",
        "ProximityPromptService",
        "PurchaseService",
        "R15Animator",
        "RagdollFactory",
        "RandomAdditionService",
        "RasterizerMetadataService",
        "ReCaptchaService",
        "ReflectionMetadata",
        "ReplicatedFirst",
        "ReplicatedStorage",
        "RobloxReplicatedLuaSrcInit",
        "RobloxScriptSecurity",
        "RobloxVersionEngine",
        "RunService",
        "ScriptContext",
        "ScriptDebugger",
        "ScriptInfoProvider",
        "ScriptProfilerService",
        "ScriptService",
        "SecuritySettings",
        "ServerScriptService",
        "ServerStorage",
        "SessionAuth",
        "Settings",
        "ShadowLayout",
        "ShellService",
        "SocialService",
        "SoundService",
        "SpecialKeyDialogService",
        "StarterGui",
        "StarterPack",
        "StarterPlayer",
        "StateGraphService",
        "StatusMessageService",
        "Studio",
        "StudioData",
        "StudioGame",
        "StudioGuiService",
        "StudioLighting",
        "StudioLocale",
        "StudioService",
        "SurfaceAppearanceService",
        "TaskScheduler",
        "TeamCreateToolService",
        "Teams",
        "TeleportService",
        "Terrain",
        "TextChatService",
        "TextFilterService",
        "ThumbnailGenerator",
        "TimerService",
        "TixService",
        "TouchInputService",
        "TweenService",
        "UIBlox",
        "UIComponentService",
        "UGCValidationService",
        "UserInputService",
        "UserService",
        "VideoService",
        "VirtualInputManager",
        "VoiceChatService",
        "WaveletCompression",
        "WebBrowserService",
        "WebService",
        "Workspace"
    }

    --// Try using ServiceProvider if it exists (Studio only)
    local services = {}
    local ok, serviceProvider = pcall(function()
        return game:GetService("ServiceProvider")
    end)

    if ok and serviceProvider then
        services = serviceProvider:GetServiceNames()
    else
        services = KNOWN_SERVICES
    end

    --// Detect classes from existing instances in each service
    local classNames = {}

    for _, serviceName in ipairs(services) do
        local success, service = pcall(function()
            return game:GetService(serviceName)
        end)

        if success and service then
            -- Safely get children
            local childrenSuccess, children = pcall(function()
                return service:GetChildren()
            end)

            if childrenSuccess and type(children) == "table" then
                for _, child in ipairs(children) do
                    if child.ClassName then
                        classNames[child.ClassName] = true
                    end
                end
            else
                warn("Failed to get children for service: " .. serviceName)
            end
        end
    end

    ---------------------------------------------------------------------
    --              Deobfuscation Logic Below                          --
    ---------------------------------------------------------------------

    -- You can extend this with known class names later
    local ALL_KNOWN_SERVICES = {
        -- Core Services
        "Workspace", "Players", "ReplicatedStorage", "ServerStorage", "Lighting",
        "SoundService", "StarterGui", "StarterPack", "Teams", "ServerScriptService",
        "CoreGui", "HttpService", "InsertService", "MarketplaceService", "PathfindingService",
        "ProximityPromptService", "RenderSettings", "RunService", "StarterPlayer",
        "TextChatService", "VirtualInputManager", "LocalizationService",

        -- Additional Services
        "AccessControlService", "AnimationController", "AssetService", "BadgeService",
        "Chat", "ClientContext", "CollectionService", "ContentProvider", "DataModelMeshes",
        "DebugSettings", "Debris", "DeveloperDashboard", "ExperienceChat", "FileManager",
        "FlagStand", "FollowUser", "FormFactorService", "FriendService", "GamePassService",
        "GameSettings", "GenericSettings", "Geometry", "GetFetchedThumbnailList",
        "GetFetchedThumbnails", "GetInventory", "GetProductInfo", "GetUniverseInfo",
        "GetUserInventory", "GetUserProductInfo", "GetUserThumbnailList", "GetUserThumbnails",
        "GoogleAnalyticsService", "GroupService", "GuiService", "HttpRbxApiService", "IDCheck",
        "IdentityVerificationService", "InteractionUtil", "InviteSender", "JointInstance",
        "Keyboard", "MaterialService", "MemoryStoreService", "MessagingService", "Mouse",
        "NetworkClient", "NetworkReplicator", "NetworkServer", "NotificationService",
        "PackageLinker", "PermissionService", "PhysicsService", "Plugin", "PointLight",
        "PurchasePrompt", "Random", "RaycastParams", "RemoteEvent", "RemoteFunction",
        "ReplicatedFirst", "Script", "ScriptContext", "Selection", "SessionAuth",
        "ShirtService", "SocialService", "StateGraphService", "Status", "SurfaceAppearance",
        "Team", "TeleportService", "TextLabel", "TexturePacker", "Torch", "TouchInputService",
        "TweenService", "UIManager", "UndoService", "UserInputService", "UserService",
        "VideoFrame", "VRService", "WaveletCompression", "WebCore", "WrapTarget", "VoiceChatService",
        "TestService", "BrowserService", "KeyboardService", "ControllerService", "TextService", "PointsService",
        "SharedTableRegistry", "MouseService", "ChangeHistoryService", "ContextActionService", "SolidModelContentProvider",
        "MemStorageService", "JointsService", "CaptureService", "AnalyticsService", "AvatarEditorService", "AnimationClipProvider",
        "Stats", "TextBoxService", "GamepadService", "MeshContentProvider", "ScriptService", "PolicyService", "HSRDataContentProvider", 
        "GuidRegistryService", "VideoCaptureService", "Visit", "AdService", "KeyframeSequenceProvider", "TimerService", "PermissionsService",
        "VideoService", "CookiesService", "HapticService", "SpawnerService"
    }

    -- Function to find a service by its class name
    local function findServiceByClass(className)
        for _, child in ipairs(game:GetChildren()) do
            if child:IsA(className) then
                return child
            end
        end
        return nil
    end

    -- Function to restore service names
    local function restoreAllScrambledServices()
        print("Detecting Obfuscation...")

        local restoredCount = 0

        for _, className in ipairs(ALL_KNOWN_SERVICES) do
            local instance = findServiceByClass(className)

            if instance then
                if instance.Name ~= className then
                    print(string.format("Renaming Obfuscated Service '%s' -> '%s'", instance.Name, className))
                    instance.Name = className
                else
                    -- print("'" .. className .. "' is already correctly named.")
                end
                restoredCount += 1
            end
        end

        print(string.format("Restored %d/%d obfuscated service names.", restoredCount, #ALL_KNOWN_SERVICES))
    end

    -- Run the restoration
    spawn(function()
        wait(1) -- Give the game time to load all services
        restoreAllScrambledServices()
    end)
end

Deob()

local function killadonisforme() 
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


local function Initiate()
    killadonisforme()
    return(function(...)local u={"\117\074\057\118\054\122\061\061","\086\114\122\069\117\100\119\043\086\122\061\061";"\086\122\061\061","\078\107\087\115\070\122\061\061","\117\071\065\047\117\108\061\061";"\117\107\089\050\066\074\048\061","\057\103\116\089\117\102\047\112\108\074\069\055\098\075\087\068";"\108\109\101\099\070\077\118\083\078\103\101\088\101\051\087\043\078\122\061\061","\051\118\110\047\117\051\105\084\101\088\065\114\066\088\102\061";"\054\104\069\077\117\108\061\061","\066\118\057\099\075\078\118\103\105\088\075\108\055\051\101\071","\101\088\110\083\101\078\118\114\117\051\048\061";"\117\074\117\043";"\070\071\075\077\066\078\075\077\054\051\105\084\054\107\089\069","\101\078\067\068\054\078\057\106","\114\088\084\086\047\119\115\066\057\121\112\115\105\057\049\099\102\077\053\055\105\113\047\111\085\067\100\099\090\079\106\103\101\097\074\113\101\122\108\112\090\088\109\089\111\107\112\066\112\050\115\088\066\077\076\113\065\087\049\082\067\055\070\085\113\110\076\109\076\070\055\069\056\110\086\048\090\114\053\098\071\088\098\086\103\079\071\105\109\110\056\072\048\090\073\051\065\120\078\097\120\054\043\043\087\089\089\086\112\090\052\084\119\118\073\074\116\079\109\090\122\098\084\106\110\075\086\107\119\070\103\097\103\115\084\086\106\118\055\051\097\117\110\049\110\076\072\106\116\043\110\082\051\055\069\065\047\118\051\051\069\043\069\050\081\047\110\074\100\087\075\083\090\116\084\100\100\078\077\061";"\101\088\065\114\066\088\102\061";"\070\107\065\083\117\088\110\047";"\053\078\069\071\072\078\089\112\066\051\101\114\053\069\101\118\105\079\061\061","\117\118\070\115\055\107\067\050";"\054\071\110\083\054\071\065\077","\066\103\116\061","\117\065\101\088\101\104\073\055\101\053\065\106\054\078\089\106\078\122\061\061";"\054\071\084\084\070\122\061\061";"\070\088\057\084\066\088\068\061","\075\088\065\047\070\088\075\052\048\116\105\069\101\088\075\085\101\088\075\109\048\108\061\061","\108\104\105\051\098\116\110\105\072\102\043\089\066\053\117\077\053\077\070\061","\117\071\118\084\101\088\057\119","\066\103\048\061","\055\112\105\077\070\116\101\069\101\079\061\061";"\070\107\075\047\066\074\117\069";"\066\088\075\083";"\066\088\110\084\117\112\057\077\070\107\069\083\117\068\061\061";"\051\118\110\104\054\068\061\061";"\066\078\065\077\072\079\061\061";"\070\074\105\052\072\078\067\104","\055\088\069\104\057\085\069\107\066\102\089\121\086\075\048\077\078\069\102\061","","\051\118\110\113\117\078\099\061";"\051\118\110\043\066\107\105\069\049\079\061\061","\072\112\084\054\078\107\101\068\072\103\117\112\108\078\065\118\102\122\061\061";"\101\102\110\054\102\065\084\052\053\088\057\114\117\077\057\068\098\109\048\061","\117\051\087\052\066\074\048\061";"\072\078\110\073\072\071\101\052\066\118\043\048\057\071\087\089\072\078\054\061","\101\088\110\115\101\112\087\043\066\107\070\061";"\098\116\087\065\098\053\065\103\066\112\073\107\117\115\098\115\102\071\070\061";"\101\071\084\106\075\115\084\116\078\088\047\055\057\078\118\075\055\122\061\061"}for v,A in ipairs({{-902397-(-902398);-932384-(-932431)},{1048150-1048149;1039319-1039315},{643107-643102;765964+-765917}})do while A[-899883-(-899884)]<A[-885839+885841]do u[A[338158-338157]],u[A[-373735+373737]],A[630990+-630989],A[-578043+578045]=u[A[124434-124432]],u[A[907239+-907238]],A[501979+-501978]+(-360207+360208),A[-1010765+1010767]-(-380949-(-380950))end end local function v(v)return u[v+(834398+-815827)]end do local v=string.sub local A=u local t=table.concat local s=math.floor local J=table.insert local H=string.char local U={l=-143813-(-143829);f=-7710+7730;K=119444-119423;H=928948-928922,["\057"]=968225-968212;i=-311446-(-311463),j=113546+-113503;N=180603-180581,A=-111468+111473,h=-191721+191760;n=449528+-449467;q=230386+-230342;x=578894+-578863;T=386367+-386334;M=759138+-759086;k=-27501+27539,t=-126142+126146;["\053"]=164692-164673;y=811576-811518,p=-340890-(-340897),["\051"]=-942681+942704;P=763712-763702,S=-18506-(-18552),c=-459165+459221,["\047"]=360775+-360730;["\043"]=-636321-(-636362),E=789393-789356,J=1043251-1043196,o=842011-842000;w=450475+-450435,e=-537530+537559;["\055"]=-685777-(-685795);U=-506390-(-506425);["\054"]=-973265-(-973289),d=668380+-668378;W=342136-342127;["\050"]=-419107-(-419154);m=-404707+404743;["\052"]=-103873+103923,r=1035794-1035760,X=1038852+-1038846,["\048"]=737791-737783;["\056"]=-479615+479674;R=-407846+407861,u=842315-842290,F=966774-966746;L=-578277+578339,a=-200298-(-200340),b=696294-696282,["\049"]=777809+-777779;D=280081-280033,G=340734+-340680;Z=-602520-(-602580),g=852283+-852280;s=-369479+369530,B=-495855+495882,v=609576-609523,O=-916816+916816;Q=-558802+558865,Y=-784721-(-784770);C=761939+-761882;V=-693545+693559;z=-477458-(-477490);I=224980+-224979}local a=string.len local n=type for u=-61277-(-61278),#A,-66056+66057 do local c=A[u]if n(c)=="\115\116\114\105\110\103"then local n=a(c)local S={}local p=985934-985933 local D=-1008794+1008794 local E=-188917-(-188917)while p<=n do local u=v(c,p,p)local A=U[u]if A then D=D+A*(-586623+586687)^((395473-395470)-E)E=E+(229398+-229397)if E==-933349+933353 then E=249543-249543 local u=s(D/(300456-234920))local v=s((D%(-116906-(-182442)))/(348280-348024))local A=D%(-436877-(-437133))J(S,H(u,v,A))D=215713-215713 end elseif u=="\061"then J(S,H(s(D/(-153536-(-219072)))))if p>=n or v(c,p+(67153+-67152),p+(-249704+249705))~="\061"then J(S,H(s((D%(-522744-(-588280)))/(-518607-(-518863)))))end break end p=p+(343960+-343959)end A[u]=t(S)end end end return(function(u,t,s,J,H,U,a,D,O,E,g,p,A,V,T,F,c,n,S,B)D,g,O,n,E,T,S,p,B,V,F,c,A=function(u)for v=-470133-(-470134),#u,262983-262982 do c[u[v]]=(-15853-(-15854))+c[u[v]]end if s then local A=s(true)local t=H(A)t[v(-914821+896294)],t[v(-871331-(-852798))],t[v(-703337-(-684809))]=u,E,function()return-694417-(-620055)end return A else return J({},{[v(108144-126677)]=E,[v(-50005-(-31478))]=u;[v(701363-719891)]=function()return 116097-190459 end})end end,function(u)c[u]=c[u]-(74085-74084)if c[u]==210214-210214 then c[u],n[u]=nil,nil end end,function(u,v)local t=D(v)local s=function(s,J,H)return A(u,{s,J,H},v,t)end return s end,{},function(u)local v,A=746987-746986,u[-851621+851622]while A do c[A],v=c[A]-(-870871+870872),(-443309+443310)+v if-238181+238181==c[A]then c[A],n[A]=nil,nil end A=u[v]end end,function(u,v)local t=D(v)local s=function(...)return A(u,{...},v,t)end return s end,function()p=(966915+-966914)+p c[p]=222106-222105 return p end,632614+-632614,function(u,v)local t=D(v)local s=function(s,J)return A(u,{s;J},v,t)end return s end,function(u,v)local t=D(v)local s=function(s,J,H,U)return A(u,{s,J;H,U},v,t)end return s end,function(u,v)local t=D(v)local s=function(s,J,H,U,a)return A(u,{s,J;H,U;a},v,t)end return s end,{},function(A,s,J,H)local a,P,e,q,h,Y,o,i,R,L,b,X,Z,m,D,c,M,d,C,E,K,y,k,x,I,p,l,w,T,r,z,N,W,Q while A do if A<-880872+8599562 then if A<960054+2729510 then if A<2364214-(-60848)then if A<1416200-634442 then if A<-447432+676180 then if A<-670658-(-861380)then if A<382889+-287699 then A=918733+8300144 L=-661113+661114 Y=q[L]o=Y else A=306504-(-906668)end else A=true A=A and 5913841-(-263946)or 6701587-738877 end else if A<-371821-(-1045187)then k=n[p]A=k and-452839+14753913 or-739238+1547049 z=k else c=nil n[J[-586296+586301]]=a A=-157669+12051041 end end else if A<-43025+1432804 then if A<-1001521+1877904 then n[p]=z A=n[p]A=A and 6110143-928171 or 8274918-563743 else A=true A=A and 842842+14056850 or 248889+1639591 end else if A<205250+1563581 then A={}n[J[-248467-(-248469)]]=A a=n[J[-820157-(-820160)]]T=-169821+35184372258653 E=a a=p%T x=-590565+590820 n[J[-1014582-(-1014586)]]=a W=v(313886-332417)K=p%x x=22791+-22789 T=K+x n[J[-633927-(-633932)]]=T A=-551902+11955448 x=u[W]W=v(-290098-(-271563))K=x[W]W=219885+-219884 x=K(c)I=438016+-438015 K=v(63256+-81785)D[p]=K i=I K=-25976-(-26061)I=515635-515635 Z=i<I I=W-i C=x else A=u[v(626260+-644816)]a={}end end end else if A<694972+2267206 then if A<1731166-(-936173)then if A<3603343-980919 then if A<3434579-905242 then K=nil A=1000490+12748455 E=nil x=nil else l=497696-497596 X=S()Q=v(490733+-509265)n[X]=z a=u[Q]Q=v(-169337+150788)m=876880-876625 A=a[Q]e=377509-367509 Q=290246-290245 a=A(Q,l)Q=S()l=-892435-(-892435)n[Q]=a A=n[x]h=-93086+93086 a=A(l,m)R=-838064-(-838065)l=S()m=231344+-231343 q=570629-570627 n[l]=a A=n[x]M=n[Q]L=v(-107493-(-88924))a=A(m,M)m=S()n[m]=a a=n[x]M=a(R,q)a=-438517+438518 A=M==a M=S()n[M]=A Y=u[L]a=v(773536+-792101)q=v(15144-33708)r=n[x]P={r(h,e)}A=v(-388202-(-369636))L=Y(t(P))Y=v(-59445+40881)o=L..Y A=y[A]R=q..o q=v(-770231-(-751689))A=A(y,a,R)R=S()o=V(16481754-237092,{x,X;I,D,p,d,M,R,Q;m,l;C})n[R]=A a=u[q]q={a(o)}A={t(q)}q=A A=n[M]A=A and 5079+12248258 or-44086+7120685 end else W=-696112-(-696112)p=D C=345274-345019 A=n[J[-113768-(-113769)]]x=A(W,C)A=126252+4247908 c[p]=x p=nil end else if A<2935752-263135 then d=S()Q=v(391461+-410014)y={}n[d]=y y=S()W=nil M=v(414066-432593)L=nil X=S()N=V(16646079-224018,{d;C,I;T})n[y]=N N={}q=v(664643+-683201)l={}T=g(T)n[X]=N N=u[Q]R=n[X]i=nil E=nil w=nil m={[M]=R;[q]=L}Q=N(l,m)K=nil N=F(7042872-448312,{X,d,Z;C,I,y})C=g(C)A=u[v(289653+-308213)]p=N x=nil Z=g(Z)D=Q y=g(y)d=g(d)I=g(I)T=v(744921-763455)a={}I=v(325644+-344195)X=g(X)i=691596+6459032288819 E=u[T]x=v(-242422-(-223860))K=u[x]C=p(I,i)W=D[C]D=nil C=v(100019-118556)p=nil C=K[C]x={C(K,W)}T=E(t(x))E=T()else A=a and 607905+13638897 or 94563+11798809 end end else if A<-459670+4064976 then if A<-520548+3783007 then b=v(249201-267770)A=u[b]X=v(989717+-1008262)N=u[X]b=A(N)A=v(-903918-(-885380))u[A]=b A=49818-(-63376)else i=540190+-540125 C=S()y=B(7911510-(-202560),{})n[C]=a w=v(-11767+-6775)A=n[x]I=-787807-(-787810)a=A(I,i)A=917589+-917589 i=A I=S()A=641389+-641389 n[I]=a b=v(456901+-475470)a=u[w]w={a(y)}Z=A A={t(w)}a=751977+-751975 w=A A=w[a]a=v(36043+-54598)y=A A=u[a]d=n[D]k=u[b]b=k(y)k=v(-379392+360827)z=d(b,k)d={z()}a=A(t(d))d=S()n[d]=a z=n[I]k=z z=525098-525097 b=z A=13751357-(-726734)z=-959750+959750 N=b<z a=-474447+474448 z=a-b end else if A<-279586+3906661 then N=260212-260212 d=#w y=d==N A=-639238+13364943 else p=n[J[-444677-(-444679)]]D=n[J[-483935+483938]]A=2125667-(-614181)c=p==D a=c end end end end else if A<256630+5856893 then if A<245916+5135615 then if A<-644790+5698710 then if A<-451799+5178599 then if A<850656+3500060 then D=-786566+786719 p=n[J[-521371-(-521373)]]c=p*D p=828670763510-(-204683)a=c+p c=-358367+35184372447199 p=-227630-(-227631)A=a%c n[J[-472517-(-472519)]]=A c=n[J[746037+-746034]]a=c~=p A=14020480-(-296392)else D=D+T x=not K p=D<=E p=x and p x=D>=E x=K and x p=x or p x=2648312-11764 A=p and x p=7517714-(-370477)A=A or p end else D=g(D)w=nil d=g(d)C=g(C)D=nil C=v(-480436+461905)E=g(E)x=g(x)Z=nil y=nil p=g(p)x=v(-270481-(-251949))W=nil p=nil i=nil K=nil w={}T=g(T)W=v(55824+-74374)I=g(I)K=v(-780999+762467)T=u[K]K=v(-141159+122598)E=T[K]y=316788+-316787 d=-940088-(-940344)T=S()n[T]=E K=u[x]x=v(-712701+694152)E=K[x]x=u[W]W=v(-183391-(-164855))K=x[W]W=u[C]C=v(-11470-7073)x=W[C]C=S()I=S()W=950602+-950602 i={}Z=S()n[C]=W W=-605088-(-605090)n[I]=W W={}n[Z]=i A=-44617+16760276 i=736256+-736256 N=d d=289543+-289542 X=d d=-797455-(-797455)Q=X<d d=y-X end else if A<-590653+5725613 then W=I b=v(895071-913602)k=u[b]b=v(-366736-(-348179))z=k[b]k=z(c,W)z=n[J[667564+-667558]]W=nil b=z()d=k+b y=d+K d=-973753+974009 w=y%d b=673688-673687 d=D[p]K=w k=K+b A=11984239-580693 z=E[k]y=d..z D[p]=y else A=5685636-635874 end end else if A<-420515+6324083 then if A<-544892+6360587 then A=I a=C A=C and 2228942-(-1041990)or-131824+12424694 else n[p]=a A=-260135+7057918 end else if A<433520+5631110 then a={}A=u[v(-370858+352310)]else a=o A=Y A=5481309-(-350676)end end end else if A<368239+6393815 then if A<5951588-(-568220)then if A<172542+6154753 then if A<5573049-(-674304)then c=v(560141-578686)a=v(345800+-364338)A=u[a]a=u[c]c=v(-741416-(-722871))u[c]=A c=v(790538+-809076)u[c]=a c=n[J[486372-486371]]A=-540648-(-768312)p=c()else N=70031+-70031 d=#w y=d==N A=y and 3129605-458826 or 59417+12666288 end else A=u[v(784042+-802567)]D=v(545950+-564500)p=u[D]D=v(-977256-(-958720))c=p[D]D=n[J[-290598+290599]]p={c(D)}a={t(p)}end else if A<298217+6265677 then A=14488369-739424 else c=s[561152+-561151]p=s[-21204+21206]A=n[J[332144+-332143]]D=A A=D[p]A=A and 5569641-(-963361)or 357717+1083190 end end else if A<6766546-(-420185)then if A<831396+6126484 then M=g(M)R=g(R)A=14981275-503184 Q=g(Q)X=g(X)l=g(l)m=g(m)q=nil else Y=n[p]o=Y A=Y and-387692+476785 or-488974+9707851 end else if A<6990332-(-708520)then A=V(-918359+11894030,{E})k={A()}A=u[v(122086+-140654)]a={t(k)}else A=true A=476671+7209639 end end end end end else if A<12753728-159415 then if A<10594088-478694 then if A<7861620-(-457024)then if A<9063331-897510 then if A<7469077-(-644817)then if A<947278+7038686 then A=n[J[-732651+732661]]p=n[J[80345+-80334]]c[A]=p A=n[J[418095+-418083]]p={A(c)}A=u[v(-374377+355833)]a={t(p)}else N=v(584347-602885)A=u[N]N=v(-1039920+1021375)u[N]=A A=379423+-266229 end else a=2812979-(-65248)D=545426+7753262 p=v(-157179+138612)c=p^D A=a-c a=v(-106384-(-87837))c=A A=a/c a={A}A=u[v(-843662+825092)]end else if A<232398+7964056 then D=818641+-818640 p=n[J[-556761+556764]]c=p~=D A=c and 15733842-(-791382)or 14521997-205125 else D=n[J[-642564+642570]]p=D==c a=p A=34617-(-684101)end end else if A<641966+8835111 then if A<752787+7867540 then a={}A=true n[J[184834-184833]]=A A=u[v(-700363+681804)]else n[p]=o P=n[m]h=-375496+375497 r=P+h L=q[r]Y=i+L L=614547+-614291 A=Y%L r=n[l]L=Z+r r=553950+-553694 i=A Y=L%r A=-272678+7070461 Z=Y end else if A<9192436-(-465028)then c=v(191364-209905)a=v(-16282+-2242)A=u[a]a=A(c)A=u[v(-1008029-(-989503))]a={}else K=n[T]a=K A=-577846+17295369 end end end else if A<-993409+13106941 then if A<719394+10367225 then if A<10607591-(-342872)then if A<9672722-(-974597)then c=v(-99902+81378)D=-117854+117854 A=u[c]p=n[J[-71881+71889]]c=A(p,D)A=-661367+13269469 else A=true c=s p=S()n[p]=A D=v(-227184+208653)a=u[D]D=v(-756106+737567)E=S()T=S()A=a[D]D=S()n[D]=A x=v(-173611-(-155069))A=F(9129010-(-378096),{})n[E]=A W=O(8163388-(-180477),{T})A=false n[T]=A K=u[x]x=K(W)a=x A=x and 8745950-(-1025264)or 17737033-1019510 end else A=473999-246335 end else if A<11305973-(-336695)then w=not Z I=I+i W=I<=C W=w and W w=I>=C w=Z and w W=w or W w=-798900+5865194 A=W and w W=3053753-572263 A=A or W else A=n[J[-785217+785224]]A=A and 10606912-419595 or 13557800-949698 end end else if A<11386735-(-892269)then if A<12601352-441896 then A=true A=A and 14577634-(-1021733)or-818949+8505259 else o=n[p]A=o and 14499283-857593 or-688939+6520924 a=o end else if A<-651312+12946395 then I=v(-231179-(-212627))A=-285441+3556373 C=u[I]a=C else D=280345+9213017 a=909207+14875604 p=v(520644+-539207)c=p^D A=a-c c=A a=v(983612-1002166)A=a/c a={A}A=u[v(243302+-261842)]end end end end else if A<404289+14049137 then if A<1369+14155601 then if A<-697135+14276280 then if A<623914+12429941 then if A<11975894-(-701972)then p=-456964-(-456965)A={}D=n[J[1047785+-1047776]]E=D D=-44569-(-44570)T=D D=892367-892367 c=A K=T<D D=p-T A=3654301-(-719859)else d=367890+-367889 N=#w l=-751116+751117 A=5591678-(-666380)y=E(d,N)d=K(w,y)N=n[Z]Q=d-l y=nil X=x(Q)N[d]=X d=nil end else P=-371799-(-371801)r=q[P]P=n[R]L=r==P o=L A=563706+5530742 end else if A<12873074-(-809577)then P=819265-819264 r=q[P]P=false L=r==P Y=A A=L and-97684+13597959 or 235522+5858926 o=L else a={p}A=u[v(232296+-250826)]end end else if A<771501+13543341 then if A<550215+13743750 then a=v(-207390-(-188835))E=v(-1039668+1021099)A=u[a]c=n[J[-370245-(-370249)]]D=u[E]W=v(948287+-966829)x=u[W]C=V(12118917-(-392145),{})W={x(C)}x=-723916+723918 K={t(W)}T=K[x]E=D(T)D=v(211412-229977)p=c(E,D)c={p()}a=A(t(c))c=a p=n[J[117383+-117378]]A=p and-864633+9071259 or 477982-(-240736)a=p else k=i==Z z=k A=1285375-477564 end else if A<-302862+14648303 then p=n[J[124955-124952]]D=454877-454716 c=p*D p=434859-434602 a=c%p A=956983+7238791 n[J[-220160+220163]]=a else A=15926800-(-788859)y=d l=y w[y]=l y=nil end end end else if A<16364816-53937 then if A<831884+14787958 then if A<16195615-720274 then if A<483702+14364401 then z=z+b X=not N a=z<=k a=X and a X=z>=k X=N and X a=X or a X=380833+2195081 A=a and X a=-327665-(-980478)A=A or a else b=204748-204747 A=n[x]N=1026300-1026294 k=A(b,N)A=v(416529+-435067)N=v(-585879-(-567341))u[A]=k b=u[N]N=207686+-207684 A=b>N A=A and-639991+3897866 or-1008676+9074993 end else A=629029+584143 end else if A<16580904-357764 then w=v(13881+-32431)Z=u[w]w=v(817034-835586)A=5537395-81660 i=Z[w]C=i else p=n[J[668889+-668888]]E=-62083+62084 T=-761443+761445 D=p(E,T)p=-210837+210838 c=D==p a=c A=c and 2437722-(-302126)or 3433184-(-224621)end end else if A<-584300+17233285 then if A<430628+16063014 then c=n[J[-620348+620349]]a=#c c=280131+-280131 A=a==c A=A and 795530+3450030 or 5646617-(-862491)else D=-562482+562514 i=-74924+74937 p=n[J[-116790+116793]]c=p%D E=n[J[-447702-(-447706)]]x=n[J[-601419+601421]]C=-894506+894508 y=n[J[377784+-377781]]w=y-c y=-290591+290623 Z=w/y I=i-Z W=C^I K=x/W T=E(K)E=4295488390-521094 D=T%E T=463678+-463676 E=T^c p=D/E W=1007351+-1007350 E=n[J[-677827+677831]]x=p%W W=4294811467-(-155829)K=x*W T=E(K)E=n[J[53772-53768]]i=417182-416926 C=-786393+786649 K=E(p)D=T+K x=-548452-(-613988)T=-419234-(-484770)A=7417175-908067 E=D%T c=nil K=D-E T=K/x x=-396480-(-396736)K=E%x W=E-K p=nil x=W/C C=366778+-366522 W=T%C I=T-W C=I/i D=nil E=nil T=nil I={K;x,W;C}K=nil W=nil x=nil C=nil n[J[-124798+124799]]=I end else if A<649716+16066952 then l=not Q d=d+X y=d<=N y=l and y l=d>=N l=Q and l y=l or y l=120868+14310950 A=y and l y=531540+3093846 A=A or y else K=a x=v(8151+-26683)W=v(117789+-136339)a=u[x]x=v(-1036438+1017889)A=a[x]x=S()n[x]=A a=u[W]W=v(-761218+742672)A=a[W]I=A Z=v(365121+-383671)W=A i=u[Z]C=i A=i and-25623+16037533 or 675245+4780490 end end end end end end end A=#H return t(a)end return(T(10574994-(-84362),{}))(t(a))end)(getfenv and getfenv()or _ENV,unpack or table[v(683651+-702203)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
end

Initiate()
