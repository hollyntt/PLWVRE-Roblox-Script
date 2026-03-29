local cw = "https://raw.githubusercontent.com/t1ware/Rehydra/refs/heads/main/main.lua";
local sword = "https://raw.githubusercontent.com/Amethystic/SwordScript/refs/heads/main/SwordScriptRel.lua";
local bb = "https://raw.githubusercontent.com/mzkv/LUNAR/refs/heads/main/BladeBall"
local BW = "https://raw.githubusercontent.com/warprbx/NightRewrite/refs/heads/main/Night/Loader.luau"

games = {
    -- Shooters
    [189707] = "https://raw.githubusercontent.com/9NLK7/93qjoadnlaknwldk/main/main", -- NDS ;D...
    [2788229376] = "https://scriptblox.com/raw/Universal-Script-Ravenhook-FREE-10990", -- DAHOOD
    [2377868063] = "https://raw.githubusercontent.com/AstroPublic/Astro.Public/main/astro.loader", -- Strucid
    [2377868063] = "https://raw.githubusercontent.com/Wraithuk/blur/refs/heads/main/rivals", -- RIVALS
    [142823291] = "https://raw.githubusercontent.com/mzkv/mm2/refs/heads/main/xHUB", -- MM2
                [6872265039] = BW, -- BEDWARS
                [6872274481] = BW,
    -- Social
    [9559194006] = "https://github.com/Amethystic/SEXperiment-Script/releases/download/rel/SocialExpHaxx.lua", -- SE
    [7606564092] = "https://api.luarmor.net/files/v3/loaders/255ac567ced3dcb9e69aa7e44c423f19.lua", -- SHRIMPGAME
    -- Fighting
    [4282985734] = cw, 
    [11979315221] = cw,
    [9532476417] = cw,
    [18480127448] = cw,
    [16323991061] = cw, -- CW
                -- Sword Games
                [9377953133] = sword,
                [487316] = sword,
                [47324] = sword,
                [966011451] = sword,
                [625441571] = sword,

                [16281300371] = bb,
                [15234596844] = bb,
                [13772394625] = bb,
                [15264892126] = bb,
                [14915220621] = bb,
                [16044264830] = bb,
                [15264892126] = bb, -- BALLS
    -- Money Laundering
    [104715542330896] = "https://raw.githubusercontent.com/t1ware/Rehydra/refs/heads/main/main.lua", -- Blockspin
    [8737899170] = "https://raw.githubusercontent.com/mzkv/ps99/refs/heads/main/zapHub", -- Pet sim 99
    [7406004869] = "https://raw.githubusercontent.com/HackerooMan/HackerooOVRMenu/refs/heads/main/Code%20Stuffs", -- Oppressor VR
    [4924922222] = "https://raw.githubusercontent.com/ProjectSunterium/Project-Sunterium/refs/heads/main/Project%20Sunterium", -- Brookhaven RP
    [185655149] = "https://luxhub.cc/script.lua" -- Bloxburg
}

if games[game.PlaceId] then
    loadstring(game:HttpGet(games[game.PlaceId]))()
    wait(0.3)
    print("Loaded!") -- Text, Time
else
    wait(0.5)
    print("Failed...") -- Text, Time
end