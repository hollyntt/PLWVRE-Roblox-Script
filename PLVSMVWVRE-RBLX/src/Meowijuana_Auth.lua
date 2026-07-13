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
    repeat task.wait() until game:IsLoaded()
    return(function(...)local R={"\115\089\120\077\105\089\082\119\109\049\105\103\056\083\050\087\054\079\087\061","\068\049\057\117\050\078\054\087\106\112\043\085\070\049\074\116\104\103\113\061","\115\068\112\089\114\086\061\061";"\054\101\112\072\054\056\061\061";"\054\079\082\055\115\103\098\061","\043\113\077\121\099\115\056\121\090\112\070\089\117\050\055\066\084\068\120\066\102\115\097\106\108\076\089\111\098\073\050\077\081\106\087\081\053\112\114\101\119\079\056\105\083\100\109\106\053\087\111\068\053\072\075\118\112\069\099\074\088\109\082\099\069\080\051\071\117\083\106\119\122\107\113\065\079\101\087\106\056\097\099\099\119\099\053\118\119\084\057\111\066\114\068\105\101\043\119\083\119\099\050\100\121\101\105\100\101\087\056\090\048\106\098\053\108\081\113\069\119\103\119\104\085\077\050\074\098\100\055\098\108\043\057\077\113\121\089\119\068\075\119\069\122\049\105\118\043\076\100\116\108\105\069\120\043\108\051\067\075\090\065\090\050\049\083\043\103\105\078\067\083\086\112\106\118\049\098\061","\070\099\112\085\054\047\120\072","\056\068\072\066\109\101\118\117\070\102\104\083\049\102\104\071\114\086\061\061","\079\117\120\119\115\099\050\118\067\086\061\061";"\109\052\050\089\070\080\057\118\057\086\061\061";"\057\047\112\100\115\047\049\061";"\070\047\043\074\115\047\073\061","\105\101\074\074\070\113\061\061";"\057\089\117\121\081\116\049\101";"\070\103\050\055\114\068\077\075";"\115\047\120\074\054\052\043\089\070\099\118\085\054\073\061\061","\105\101\120\085\105\101\112\089";"\070\101\081\089\115\068\081\089\105\079\050\074\105\099\090\118";"\115\102\098\061","\081\047\112\072\070\047\081\055\098\080\050\118\057\047\081\078\057\047\081\116\098\056\061\061";"\115\102\080\061";"\057\080\057\084\057\099\113\055\068\116\112\116\057\099\074\085\049\052\080\061";"\105\075\118\089\054\056\061\061","\057\047\120\085\057\068\117\100\054\079\098\061","\054\103\043\117\105\113\061\061","\067\079\112\066\105\078\074\085\081\049\049\101\114\049\071\061";"\054\047\077\052\056\049\080\101\054\102\111\056\114\089\112\056\105\099\104\061","";"\070\116\117\084\115\079\050\065\069\079\050\051\104\117\086\101","\115\047\081\085";"\054\099\090\108\115\103\098\061";"\057\112\104\073\057\081\074\102\054\103\087\055\056\079\049\077\114\056\061\061","\057\068\077\073\105\068\043\066","\079\117\120\084\054\068\071\061","\069\100\113\118\054\122\087\119\069\113\061\061";"\049\089\082\118\049\081\082\055\105\049\072\114\068\049\090\056\070\117\118\118","\079\117\120\072\054\079\050\074\057\047\112\100\115\047\049\061";"\054\101\117\074\057\047\043\087","\057\047\120\083\057\052\082\119\115\099\070\061";"\114\047\090\066\049\079\112\103\043\116\090\111\114\068\057\080","\081\118\112\090\067\049\074\117\070\112\050\072\106\089\120\117\109\049\105\061";"\079\117\120\075\105\073\061\061","\104\052\112\111\069\047\077\117\115\079\074\099\054\103\057\083";"\069\113\061\061";"\068\099\077\098\115\112\118\099\043\078\043\047\070\047\112\055","\068\047\105\061","\070\099\081\072\115\103\054\118"}local function n(n)return R[n+(-376740-(-420899))]end for n,M in ipairs({{425551+-425550,82585-82538},{-519111-(-519112);-406199+406244};{-454280+454326;190003-189956}})do while M[-674468-(-674469)]<M[627589-627587]do R[M[22709-22708]],R[M[909291+-909289]],M[966038-966037],M[-728356-(-728358)]=R[M[315300+-315298]],R[M[127747+-127746]],M[496673-496672]+(-362820-(-362821)),M[998214-998212]-(-444101-(-444102))end end do local n=table.concat local M=type local e=string.sub local q=string.char local A=table.insert local J=string.len local Y=R local l={j=894751+-894732;t=-254166+254202,K=654968+-654929;E=-279554+279568;J=-388645+388678,D=615684+-615662,O=-333142+333165;N=564817-564782,m=-777281-(-777299);v=936527-936490;z=411022+-411020;["\054"]=-208608+208633,M=-502416+502473,n=-1048379-(-1048442),T=83161-83117;q=-165661+165693,l=601176-601129,s=-777670+777697,w=-85055+85096;A=363649-363638,["\047"]=-886822-(-886828);d=246172-246138;i=-969072+969096,B=257440+-257397;Y=431859-431807;V=285836+-285836;b=-39415+39423,H=16522+-16477;p=-96547+96552;C=-47750+47780;["\052"]=275905-275898;["\055"]=611602-611552,["\057"]=529575+-529546,r=-1025518+1025544,["\056"]=317037+-317021;X=621094-621063,S=-653945+653996;g=855600+-855545,["\048"]=848785+-848725,["\051"]=380865+-380823,["\043"]=-720305+720318;["\053"]=892424-892362,U=470158-470112;W=116395-116355,G=680586-680530,R=139068+-139059,e=115603+-115549,L=-471702-(-471717),u=-86184-(-86237),["\049"]=174072-174052;["\050"]=-819556+819573;a=706964-706905;x=484341-484280,y=548071+-548061;h=761299-761287;Z=-140514+140563,I=-64034-(-64082);k=-248044-(-248102);P=-380694-(-380698),c=806182+-806144,Q=815542+-815521;F=-941362+941390;f=851548+-851545,o=-309500-(-309501)}local S=math.floor for R=198656+-198655,#Y,-796253-(-796254)do local a=Y[R]if M(a)=="\115\116\114\105\110\103"then local M=J(a)local I={}local E=99851-99850 local k=42021+-42021 local B=288756+-288756 while E<=M do local R=e(a,E,E)local n=l[R]if n then k=k+n*(-932856+932920)^((294388-294385)-B)B=B+(-736812-(-736813))if B==-259185-(-259189)then B=-187639-(-187639)local R=S(k/(414865+-349329))local n=S((k%(-353700+419236))/(896537-896281))local M=k%(5454-5198)A(I,q(R,n,M))k=-189030+189030 end elseif R=="\061"then A(I,q(S(k/(836495-770959))))if E>=M or e(a,E+(141984-141983),E+(545578-545577))~="\061"then A(I,q(S((k%(-63515+129051))/(-718632-(-718888)))))end break end E=E+(842414+-842413)end Y[R]=n(I)end end end return(function(R,e,q,A,J,Y,l,f,M,c,E,X,S,a,D,I,U,k,B,T,O,H)f,D,S,M,T,U,k,E,O,X,H,I,c,B,a=function(R,n)local e=k(n)local q=function(...)return M(R,{...},n,e)end return q end,function(R,n)local e=k(n)local q=function(q,A,J,Y)return M(R,{q;A,J;Y},n,e)end return q end,{},function(M,q,A,J)local Q,y,w,s,K,x,t,d,f,v,B,C,L,g,l,P,r,h,W,a,u,m,k,p,E,z,o,b,i,F,j,V,N,G while M do if M<7406942-476392 then if M<3900779-402984 then if M<1803160-(-632585)then if M<218281+1615166 then if M<-108456+1449687 then if M<2047253-930588 then if M<-360039+1325638 then t=I()N=-322989+322992 S[t]=l M=S[y]z=-368805-(-368870)g=n(927538+-971660)l=M(N,z)M=-459103-(-459103)x=n(-566580-(-522431))z=M M=-545708+545708 Q=M N=I()S[N]=l l=R[x]V=X(-722215+3186143,{})x={l(V)}l=1029626+-1029624 M={e(x)}x=M M=x[l]l=n(-1013552+969415)V=M M=R[l]b=S[k]W=R[g]g=W(V)W=n(-176322-(-132196))G=b(g,W)b={G()}l=M(e(b))b=I()S[b]=l l=-854661-(-854662)G=S[N]W=G G=36107-36106 g=G G=510698-510698 i=g<G M=1570337-459597 G=l-g else u=not i G=G+g l=G<=W l=u and l u=G>=W u=i and u l=u or l u=3734385-(-530133)M=l and u l=-341544+16644485 M=M or l end else M=11484683-441551 end else if M<-846567+2255376 then M=767596+3654695 else s=298722-298721 S[E]=F d=S[C]m=d+s r=v[m]w=z+r r=60850-60594 M=w%r m=S[j]r=Q+m m=-1016865-(-1017121)z=M w=r%m Q=w M=9850184-(-586084)end end else if M<2393546-164857 then if M<2817200-798983 then k=-813867+814060 E=S[A[425354-425352]]a=E*k E=908782+27337665926091 l=a+E a=818653+35184371270179 E=-473329-(-473330)M=l%a S[A[725527-725525]]=M M=-84955+14067005 a=S[A[-596557-(-596560)]]l=a~=E else S[E]=G M=S[E]M=M and 1032426+363686 or-357171+2795260 end else if M<1822006-(-554076)then g=n(161385+-205531)h=N W=R[g]g=n(-499699+455561)G=W[g]W=G(a,h)G=S[A[-1014731-(-1014737)]]g=G()M=6917363-(-198755)b=W+g V=b+o b=-119362+119618 x=V%b g=45964+-45963 b=k[E]o=x W=o+g G=B[W]h=nil V=b..G k[E]=V else M=17427526-927723 end end end else if M<3440890-200002 then if M<-160862+3004607 then if M<159176+2668357 then if M<995482+1463360 then M=true M=646784+10760996 else l=-908855+12270607 k=11183514-(-345901)E=n(-60104+15989)a=E^k M=l-a a=M l=n(276802-320949)M=l/a l={M}M=R[n(-59493-(-15380))]end else a=n(557302-601458)M=R[a]E=S[A[450166-450158]]k=-781050+781050 a=M(E,k)M=9972469-(-610942)end else if M<-609729+3689996 then d=-425486+425488 m=v[d]d=S[L]r=m==d F=r M=4936074-(-550166)else F=S[E]l=F M=F and 4510958-1025382 or-188368+12918536 end end else if M<934739+2479632 then if M<2692621-(-631222)then M=N l=t M=t and 1018131-442669 or 597751+5517666 else M=l and 11148772-743141 or 3750826-(-944564)end else if M<271133+3197774 then o=S[f]M=974735+4957585 l=o else d=-566843-(-566844)m=v[d]w=M d=false r=m==d F=r M=r and 111117+2773454 or 4920877-(-565363)end end end end else if M<-960644+5746696 then if M<3943249-(-60745)then if M<4020805-273227 then if M<4105171-543820 then if M<681722+2853227 then M=16570987-25971 V=b j=V x[V]=j V=nil else M=760526+1428184 W=z==Q G=W end else M=R[n(126223+-170376)]l={E}end else if M<3600017-(-335957)then g=n(408543+-452665)M=R[g]u=n(-352806-(-308666))i=R[u]g=M(i)M=n(350313-394455)R[M]=g M=4332216-391920 else M=15979603-(-520200)end end else if M<136687+4217972 then if M<4975867-730865 then b=-954948-(-954949)i=#x V=B(b,i)b=o(x,V)i=S[Q]j=-205039+205040 V=nil P=b-j u=y(P)i[b]=u b=nil M=6799098-(-705805)else u=I()S[u]=G P=n(-655457-(-611299))C=174942-174687 l=R[P]K=-364928-(-374928)s=-588210+588210 P=n(-262294+218140)v=711472-711470 M=l[P]P=450212+-450211 j=-878200-(-878300)l=M(P,j)P=I()S[P]=l j=361723+-361723 M=S[y]l=M(j,C)j=I()C=-831753+831754 S[j]=l L=-76534+76535 M=S[y]p=S[P]l=M(C,p)C=I()r=n(-1068277-(-1024155))S[C]=l l=S[y]p=l(L,v)l=707145+-707144 M=p==l p=I()v=n(-684999+640882)S[p]=M M=n(-772161+728025)w=R[r]M=V[M]m=S[y]d={m(s,K)}l=n(227707+-271833)r=w(e(d))w=n(-131257-(-87140))F=r..w L=v..F M=M(V,l,L)L=I()v=n(-1017690-(-973541))F=X(1017181+9985886,{y;u;N,k,E;b;p;L;P,C;j,t})S[L]=M l=R[v]v={l(F)}M={e(v)}v=M M=S[p]M=M and 3540842-315095 or 980458+9947131 end else if M<857916+3704486 then B=T(B)f=T(f)o=nil k=T(k)h=nil E=T(E)h=n(-717255-(-673105))Q=nil E=nil Q=I()z=nil t=T(t)b=T(b)N=T(N)V=nil y=T(y)x=nil o=n(-1059110-(-1014952))f=R[o]o=n(936244+-980374)k=nil B=f[o]f=I()z={}S[f]=B t=n(620444+-664590)y=n(-265935+221777)o=R[y]y=n(386201-430355)B=o[y]y=R[h]h=n(463439+-507553)o=y[h]N=I()h=R[t]t=n(237180+-281328)y=h[t]h=928505+-928505 t=I()S[t]=h h=911859+-911857 S[N]=h h={}x={}b=-671217-(-671473)S[Q]=z z=-879102-(-879102)i=b b=137827+-137826 u=b V=998211-998210 b=220529+-220529 P=u<b b=V-u M=-884879+17429895 else M=S[A[524628-524621]]M=M and 666142+2172362 or 223507+10359904 end end end else if M<5371596-(-581653)then if M<5924685-468445 then if M<4079734-(-970114)then if M<-847596+5729910 then M=true M=M and 1680445-(-745441)or 630917+10776863 else M={}S[A[-60619+60621]]=M l=S[A[-853278-(-853281)]]y=891307-891052 h=n(-823263-(-779117))B=l f=35184373134270-1045438 N=-206877+206878 l=E%f S[A[-916162+916166]]=l o=E%y y=-771775+771777 f=o+y S[A[-377234+377239]]=f y=R[h]h=n(-19640-24491)o=y[h]y=o(a)h=228149-228148 o=n(-273766-(-229633))k[E]=o M=6548633-(-567485)z=N o=176422+-176394 t=y N=-808310-(-808310)Q=z<N N=h-z end else i=n(-107816+63674)M=R[i]i=n(-1078063-(-1033923))R[i]=M M=516505+3423791 end else if M<-912214+6453513 then l=F M=w M=-521807+13251975 else o=l y=n(-760540-(-716382))l=R[y]y=n(300424-344578)M=l[y]y=I()h=n(-814701-(-770551))S[y]=M Q=n(-541311-(-497161))l=R[h]h=n(-550960-(-506816))M=l[h]h=M z=R[Q]t=z N=M M=z and 7016989-(-558527)or-561943+3811409 end end else if M<5636040-(-787481)then if M<5881157-(-284231)then N=n(488772+-532900)t=R[N]M=-378218+953680 l=t else E=S[A[-51684-(-51686)]]k=S[A[-264739-(-264742)]]a=E==k l=a M=-618825+4008967 end else if M<-869054+7741435 then k=330572+11281712 l=8359749-510221 E=n(-826860+782725)a=E^k M=l-a a=M l=n(117958+-162083)M=l/a l={M}M=R[n(166438-210567)]else M=-820601+4409423 end end end end end else if M<11965871-(-1023448)then if M<9705205-(-871900)then if M<-577735+8151507 then if M<397068+7025686 then if M<7313211-201816 then if M<7019350-(-44158)then M=S[A[-783548-(-783558)]]E=S[A[-683246+683257]]a[M]=E M=S[A[-376779+376791]]E={M(a)}l={e(E)}M=R[n(-406109-(-361975))]else E=q[-552781-(-552783)]a=q[-139754+139755]M=S[A[1016433-1016432]]k=M M=k[E]M=M and 7830531-952063 or 5405125-513327 end else x=not Q N=N+z h=N<=t h=x and h x=N>=t x=Q and x h=x or h x=1680294-(-604118)M=h and x h=-557012+11444261 M=M or h end else if M<7476735-(-26372)then E=S[A[-727322-(-727325)]]k=558083-558082 a=E~=k M=a and 212765+13451432 or 12933726-(-1048324)else b=#x i=1524-1524 V=b==i M=V and-947684+16494391 or 3850457-(-158323)end end else if M<8921946-39513 then if M<-362349+8417193 then M=-871019+4120485 x=n(-794869-(-750719))Q=R[x]x=n(-838427+794299)z=Q[x]t=z else M=-767286+2351072 r=-712019+712020 w=v[r]F=w end else if M<-760111+11172994 then l=n(920805-964942)t=D(6784270-(-28280),{})h=n(337111+-381260)M=R[l]a=S[A[-231192+231196]]B=n(-596831-(-552709))k=R[B]y=R[h]h={y(t)}o={e(h)}y=-839269-(-839271)f=o[y]B=k(f)k=n(-781053-(-736927))E=a(B,k)a={E()}l=M(e(a))E=S[A[366854+-366849]]a=l M=E and 727637+14748795 or 32665+14819344 l=E else L=T(L)M=1391727-280987 P=T(P)C=T(C)j=T(j)u=T(u)p=T(p)v=nil end end end else if M<109377+10926572 then if M<10125935-(-775226)then if M<10094253-(-743355)then if M<969209+9665560 then M={}E=-427502-(-427503)k=S[A[-37023-(-37032)]]a=M M=15629918-(-24355)B=k k=139573-139572 f=k k=1019775-1019775 o=f<k k=E-f else a=S[A[-1016112-(-1016113)]]l=#a a=161874+-161874 M=l==a M=M and 627937+1353814 or 14996333-(-660600)end else y=nil o=nil M=2701495-(-887327)B=nil end else if M<1001895+9991361 then w=S[E]F=w M=w and 812651+7569864 or 2462916-879130 else f=356569-356567 E=S[A[-323734-(-323735)]]B=-8801-(-8802)k=E(B,f)E=-235052-(-235053)a=k==E l=a M=a and-738351+4128493 or 5542947-(-791356)end end else if M<11150092-(-836506)then if M<12055678-1001391 then M=true M=M and-5061+13421812 or 14385549-(-288705)else M=U(-1006323+2148099,{B})W={M()}l={e(W)}M=R[n(464833+-508945)]end else if M<12071351-(-600722)then l=n(202297-246453)M=R[l]a=n(15891+-60032)l=M(a)l={}M=R[n(397151-441269)]else S[E]=l M=9787374-(-648894)end end end end else if M<14621107-(-1004448)then if M<462561+14094171 then if M<601442+13297391 then if M<13730418-(-74030)then if M<760518+12725532 then l=n(-791425+747283)M=R[l]a=n(-769684+725544)l=R[a]a=n(-1090629-(-1046489))R[a]=M a=n(-893443-(-849301))R[a]=l a=S[A[-1030946+1030947]]E=a()M=11147409-104277 else z=940213+-940200 E=S[A[-708752+708755]]k=-655923+655955 a=E%k B=S[A[809737+-809733]]y=S[A[-111989-(-111991)]]t=-38496-(-38498)V=S[A[271124-271121]]x=V-a V=956829-956797 Q=x/V N=z-Q h=t^N M=-1025790+16682723 o=y/h f=B(o)B=95598+4294871698 k=f%B f=-325047-(-325049)B=f^a h=1008835-1008834 E=k/B B=S[A[816897+-816893]]y=E%h h=31470+4294935826 o=y*h f=B(o)B=S[A[334095-334091]]y=671970+-606434 o=B(E)k=f+o f=311771-246235 B=k%f a=nil z=-780559+780815 o=k-B t=344337-344081 k=nil f=o/y y=754489-754233 o=B%y h=B-o y=h/t t=-256312-(-256568)h=f%t E=nil N=f-h t=N/z B=nil N={o;y;h;t}y=nil h=nil S[A[-1019228-(-1019229)]]=N o=nil f=nil t=nil end else M=true S[A[358392-358391]]=M l={}M=R[n(311309-355430)]end else if M<773749+13314795 then k=797311-797235 E=S[A[414924+-414921]]a=E*k E=-73746-(-74003)l=a%E M=8478099-976367 S[A[761891-761888]]=l else b=#x i=-1031988-(-1031988)V=b==i M=171251+3837529 end end else if M<353013+14921488 then if M<-33150+14824496 then M=R[n(-1036101-(-991962))]l={}else M=614389+4081001 S[A[-752696-(-752701)]]=l a=nil end else if M<-382689+15870932 then k=S[A[-651147-(-651153)]]M=103806+14748203 E=k==a l=E else V={}r=nil P=n(15244-59387)B=nil b=I()p=n(594152+-638304)M=R[n(1010846+-1054962)]S[b]=V i=c(-163134+10838782,{b;t;N,f})z=nil j={}v=n(864099+-908223)u=I()V=I()S[V]=i i={}S[u]=i y=nil i=R[P]L=S[u]C={[p]=L;[v]=r}y=n(147981+-192138)o=nil P=i(j,C)i=O(233051+6877617,{u,b;Q;t,N,V})N=T(N)N=n(-184718+140563)z=2480998204719-(-409428)x=nil h=nil k=P u=T(u)E=i t=T(t)l={}f=T(f)Q=T(Q)V=T(V)f=n(832961+-877106)B=R[f]b=T(b)o=R[y]t=E(N,z)h=k[t]k=nil t=n(520417-564568)t=o[t]E=nil y={t(o,h)}f=B(e(y))B=f()end end end else if M<16771044-505453 then if M<-589626+16523543 then if M<911225+14744103 then if M<-245988+15893807 then i=-928122+928128 M=S[y]g=-105772-(-105773)W=M(g,i)M=n(-827096-(-782954))R[M]=W i=n(-585105+540963)g=R[i]i=-679770+679772 M=g>i M=M and-747057+4670955 or 5152500-(-156683)else y=not o k=k+f E=k<=B E=y and E y=k>=B y=o and y E=y or E y=15265231-(-719387)M=E and y E=933918+6051570 M=M or E end else k=n(759989+-804139)E=R[k]k=n(818826-862940)M=R[n(33178+-77298)]a=E[k]k=S[A[621377+-621376]]E={a(k)}l={e(E)}end else if M<15458306-(-555609)then M=S[A[-881678+881679]]E=k t=553771-553516 h=199266+-199266 y=M(h,t)a[E]=y E=nil M=-935007+16589280 else l={}M=R[n(-1001955+957823)]end end else if M<16860578-467187 then if M<16812599-487621 then W=S[E]G=W M=W and 3550026-(-11006)or 1231930-(-956780)else E=I()M=true a=q S[E]=M k=n(45147+-89293)l=R[k]y=n(-306787+262638)f=I()k=n(-643392+599269)M=l[k]k=I()B=I()S[k]=M M=H(161928+12078068,{})S[B]=M M=false h=X(13004760-(-825208),{f})S[f]=M o=R[y]y=o(h)M=y and 4249347-826939 or 965878+4966442 l=y end else if M<1004211+15496402 then M=true M=M and 357661+15274530 or 16729688-613532 else j=not P b=b+u V=b<=i V=j and V j=b>=i j=P and j V=j or V j=4018278-490982 M=V and j V=13648419-(-521412)M=M or V end end end end end end end M=#J return e(l)end,function(R)a[R]=a[R]-(461011-461010)if a[R]==958628+-958628 then a[R],S[R]=nil,nil end end,function(R,n)local e=k(n)local q=function(q,A,J)return M(R,{q,A,J},n,e)end return q end,function(R)for n=-528366+528367,#R,497142-497141 do a[R[n]]=(-752392+752393)+a[R[n]]end if q then local M=q(true)local e=J(M)e[n(177665-221817)],e[n(609652+-653771)],e[n(410414-454541)]=R,B,function()return 829262+-4022795 end return M else return A({},{[n(-748669-(-704550))]=B;[n(1047267+-1091419)]=R,[n(-1016642+972515)]=function()return-2727802-465731 end})end end,380663-380663,function(R,n)local e=k(n)local q=function(q,A,J,Y,l,S,a)return M(R,{q,A,J,Y;l,S;a},n,e)end return q end,function(R,n)local e=k(n)local q=function(q)return M(R,{q},n,e)end return q end,function(R,n)local e=k(n)local q=function(q,A,J,Y,l)return M(R,{q;A,J,Y;l},n,e)end return q end,function()E=(579917+-579916)+E a[E]=-484784+484785 return E end,function(R,n)local e=k(n)local q=function(q,A)return M(R,{q;A},n,e)end return q end,function(R)local n,M=160264+-160263,R[624236+-624235]while M do a[M],n=a[M]-(-339029-(-339030)),n+(-780965-(-780966))if-324073-(-324073)==a[M]then a[M],S[M]=nil,nil end M=R[n]end end,{}return(f(-175678+16510884,{}))(e(l))end)(getfenv and getfenv()or _ENV,unpack or table[n(-237753-(-193625))],newproxy,setmetatable,getmetatable,select,{...})end)(...)
end

Initiate()
