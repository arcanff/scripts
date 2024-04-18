getgenv().readfile = nil
wait(1)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "SISYPHUS SIMULATOR [💎]",
    LoadingTitle = "VIP SISYPHUS SIMULATOR",
    LoadingSubtitle = "By ARCAN",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil, -- Create a custom folder for your hub/game
        FileName = "SISYPHUSHUB"
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
        Title = "Key | Sisyphus Hub",
        Subtitle = "Key System",
        Note = "Key In Discord Server",
        FileName = "SisyphusKeyHub", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
        SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
        GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
        Key = {"1"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> EASTER TAB <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local Tabs = {
    Easter = Window:CreateTab("EASTER", nil),
    Farm = Window:CreateTab("FARM", nil),
    Relics = Window:CreateTab("RELICS", nil),
    Xtras = Window:CreateTab("XTRAS", nil)
}

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> EGG SECTION <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local Egg = Tabs.Easter:CreateSection("EVENT FARM")

local function CollectEggs()
    local collecting = true -- Variable para controlar si se está recolectando huevos

    -- Comienza a recolectar huevos
    while collecting do
        game:GetService("ReplicatedStorage").Easter.AddEgg:FireServer()
        wait() -- Espera 0.1 segundo antes de recolectar otro huevo
    end
end

-- Función para hacer el server hop
local function ServerHop()
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/"
    
    local _place = game.PlaceId
    local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
    function ListServers(cursor)
        local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
        return Http:JSONDecode(Raw)
    end
    
    local Server, Next; repeat
        local Servers = ListServers(Next)
        Server = Servers.data[1]
        Next = Servers.nextPageCursor
    until Server
    
    TPS:TeleportToPlaceInstance(_place,Server.id,game:GetService('Players').LocalPlayer)
end

-- Crear el botón para activar la recolección de huevos y hacer el server hop
local Button = Tabs.Easter:CreateButton({
    Name = "Egg Sucking || Server Hop",
    Callback = function()
        spawn(CollectEggs)
        wait(2.5)
        ServerHop() 
    end,
})

local Button = Tabs.Easter:CreateButton({
    Name = "Egg Sucking",
    Callback = function()
        spawn(CollectEggs)
    end,
})

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> SHOP SECTION <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local Shop = Tabs.Easter:CreateSection("EASTER SHOP")

local Dragon = Tabs.Easter:CreateButton({
    Name = "DRAGON",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Easter"):WaitForChild("GetPetBig"):FireServer()
    end,
})

local Cat = Tabs.Easter:CreateButton({
    Name = "CAT",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Easter"):WaitForChild("GetPetCat"):FireServer()
    end,
})

-- local Coins = Tabs.Easter:CreateButton({
--     Name = "COINS",
--     Callback = function()
--         game:GetService("ReplicatedStorage"):WaitForChild("Easter"):WaitForChild("ExchangeCoin"):FireServer()
--     end,
-- })


-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> PUSH SECTION <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local Push = Tabs.Farm:CreateSection("PUSH")

local active = false -- Variable para controlar si la función está activa o no

local AutoPush = Tabs.Farm:CreateToggle({
    Name = "AUTO PUSH",
    CurrentValue = false,
    Flag = "AutoPush",
    Callback = function(value)
        active = value -- Actualiza el estado de la variable según el valor del toggle

        -- Define la función a repetir
        local function PushBerstWorld()
            local args = {
                [1] = true
            }
            PlayerBestWorld = getsenv(game.Players.LocalPlayer.PlayerScripts.WorldManager).getBestWorld()
            if game.Players.LocalPlayer.World.Value ~= PlayerBestWorld then -- teleport if youre on wrong world (game bugs if wrong world)
                game:GetService("ReplicatedStorage").Remote.Event.World:FindFirstChild("[C-S]TryGoWorld"):FireServer(PlayerBestWorld)
                wait(.3)
            end
            game:GetService("ReplicatedStorage").Remote.Event.Game:FindFirstChild("[C-S]PlayerTryBall"):FireServer(PlayerBestWorld)
            wait(.1)
            game:GetService("ReplicatedStorage").Remote.Event.Game:FindFirstChild("[C-S]PlayerEnd"):FireServer(false,0.99)

        end

        -- Repite la función mientras el toggle esté activo
        while active do
            PushBerstWorld()
            wait() -- Espera un breve momento antes de repetir la función
        end
    end,
})

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> REBIRTH SECTION <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local Rebirth = Tabs.Farm:CreateSection("REBIRTH")

local active_auto_rebirth = false -- Variable para controlar si la función de AUTO REBIRTH está activa o no
local ToggleAutoRebirth = Tabs.Farm:CreateToggle({
    Name = "AUTO REBIRTH",
    CurrentValue = false,
    Flag = "ToggleAutoRebirth",
    Callback = function(value)
        active_auto_rebirth = value -- Actualiza el estado de la variable según el valor del toggle
        
        -- Define la función a repetir
        local function AutoRebirth()
            local args = {
                [1] = true
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Event"):WaitForChild("Eco"):WaitForChild("[C-S]PlayerTryRebirth"):FireServer()
        end
        
        -- Repite la función mientras el toggle esté activo
        while active_auto_rebirth do
            AutoRebirth()
            wait(1/35) -- Espera un breve momento antes de repetir la función
        end
    end,
})

local active_super_rebirth = false -- Variable para controlar si la función de SUPERREBIRTH está activa o no
local ToggleSuperRebirth = Tabs.Farm:CreateToggle({
    Name = "SUPERREBIRTH",
    CurrentValue = false,
    Flag = "ToggleSuperRebirth",
    Callback = function(value)
        active_super_rebirth = value -- Actualiza el estado de la variable según el valor del toggle

        -- Define la función a repetir
        local function SuperRebirth()
            local args = {
                [1] = true
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Event"):WaitForChild("Eco"):WaitForChild("[C-S]PlayerTrySuperRebirth"):FireServer()
        end

        -- Repite la función mientras el toggle esté activo
        while active_super_rebirth do
            SuperRebirth()
            wait() -- Espera un breve momento antes de repetir la función
        end
    end,
})

local Egg = Tabs.Farm:CreateSection("CHRISTMAS")


local ToggleChristmas = Tabs.Farm:CreateToggle({
    Name = "CHRISTMAS",
    CurrentValue = false,
    Flag = "ToggleChristmas",
    Callback = function(value)
        active = value -- Actualiza el estado de la variable según el valor del toggle

        -- Define la función a repetir
        local function Gifts()
            local args = {
                [1] = -1
            }
            game:GetService("ReplicatedStorage").Remote.Event.Game:FindFirstChild("[C-S]PlayerTryBall"):FireServer(unpack(args))
            game:GetService("ReplicatedStorage").Remote.Event.Game:FindFirstChild("[C-S]PlayerEnd"):FireServer(false,0.99)
        end
        -- Repite la función mientras el toggle esté activo
        while active do
            Gifts()
            wait() -- Espera un breve momento antes de repetir la funciónqe3xrfcsw
        end
    end,
})

local ChristmasUp = Tabs.Farm:CreateToggle({
    Name = "CHRISTMAS COUNT UP",
    CurrentValue = false,
    Flag = "ChristmasUp",
    Callback = function(value)
        active = value -- Actualiza el estado de la variable según el valor del toggle

        -- Define la función a repetir
        local function Gifts()
            local args = {
                [1] = -1
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Event"):WaitForChild("Game"):WaitForChild("[C-S]PlayerTryBall"):FireServer(unpack(args))
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Event"):WaitForChild("Game"):WaitForChild("[C-S]PlayerEnd"):FireServer(true,1)

        end

        -- Repite la función mientras el toggle esté activo
        while active do
            Gifts()
            wait() -- Espera un breve momento antes de repetir la funciónqe3xrfcsw
        end
    end,
})

local Egg = Tabs.Farm:CreateSection("NETHER")


local ToggleNether = Tabs.Farm:CreateToggle({
    Name = "NETHER",
    CurrentValue = false,
    Flag = "ToggleNether",
    Callback = function(value)
        active = value -- Actualiza el estado de la variable según el valor del toggle
        local function Coins()
            local args = {
                [1] = -2
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Event"):WaitForChild("Game"):WaitForChild("[C-S]PlayerEnd"):FireServer(true,1)
        end
        while active do
            Coins()
            wait()
        end
    end,
})
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> RELICS SECTION <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local Relics = Tabs.Relics:CreateSection("RELICS")

local ToggleAtlantisRelic = Tabs.Relics:CreateToggle({
    Name = "ATLANTIS",
    CurrentValue = false,
    Flag = "ToggleAtlantisRelic",
    Callback = function(value)
        AtlantisRelic = value -- Actualiza el estado de la variable según el valor del toggle

        -- Define la función a repetir
        local function Atlantis()
            local args = {
                [1] = "2",
                [2] = 1
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Function"):WaitForChild("Ornaments"):WaitForChild("[C-S]PlayerTryDoLuck"):InvokeServer(unpack(args))
        end
        -- Repite la función mientras el toggle esté activo
        while AtlantisRelic do
            Atlantis()
            wait() -- Espera un breve momento antes de repetir la función
        end
    end,
})

local ToggleTempleRelic = Tabs.Relics:CreateToggle({
    Name = "TEMPLE",
    CurrentValue = false,
    Flag = "ToggleTempleRelic",
    Callback = function(value)
        TempleRelic = value -- Actualiza el estado de la variable según el valor del toggle

        -- Define la función a repetir
        local function Temple()
            local args = {
                [1] = "3",
                [2] = 1
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Function"):WaitForChild("Ornaments"):WaitForChild("[C-S]PlayerTryDoLuck"):InvokeServer(unpack(args))
            
        end

        -- Repite la función mientras el toggle esté activo
        while TempleRelic do
            Temple()
            wait() -- Espera un breve momento antes de repetir la función
        end
    end,
})

local TogglePyramidRelic = Tabs.Relics:CreateToggle({
    Name = "PYRAMID",
    CurrentValue = false,
    Flag = "TogglePyramidRelic",
    Callback = function(value)
        PiramidRelic = value -- Actualiza el estado de la variable según el valor del toggle

        -- Define la función a repetir
        local function Pyramid()
            local args = {
                [1] = "4",
                [2] = 1
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Function"):WaitForChild("Ornaments"):WaitForChild("[C-S]PlayerTryDoLuck"):InvokeServer(unpack(args))
            
        end

        -- Repite la función mientras el toggle esté activo
        while PiramidRelic do
            Pyramid()
        end
    end,
})

local ToggleHeavenRelic = Tabs.Relics:CreateToggle({
    Name = "HEAVEN",
    CurrentValue = false,
    Flag = "ToggleHeavenRelic",
    Callback = function(value)
        HeavenRelic = value -- Actualiza el estado de la variable según el valor del toggle

        -- Define la función a repetir
        local function Heaven()
            local args = {
                [1] = "5",
                [2] = 1
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Function"):WaitForChild("Ornaments"):WaitForChild("[C-S]PlayerTryDoLuck"):InvokeServer(unpack(args))
            
        end

        -- Repite la función mientras el toggle esté activo
        while HeavenRelic do
            Heaven()
            wait() -- Espera un breve momento antes de repetir la función
        end
    end,
})

local ToggleSpaceRelic = Tabs.Relics:CreateToggle({
    Name = "SPACE",
    CurrentValue = false,
    Flag = "ToggleSpaceRelic",
    Callback = function(value)
        SpaceRelic = value -- Actualiza el estado de la variable según el valor del toggle

        -- Define la función a repetir
        local function Space()
            local args = {
                [1] = "6",
                [2] = 1
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Function"):WaitForChild("Ornaments"):WaitForChild("[C-S]PlayerTryDoLuck"):InvokeServer(unpack(args))
            
        end

        -- Repite la función mientras el toggle esté activo
        while SpaceRelic do
            Space()
            wait() -- Espera un breve momento antes de repetir la función
        end
    end,
})

local ToggleCoveRelic = Tabs.Relics:CreateToggle({
    Name = "COVE",
    CurrentValue = false,
    Flag = "ToggleCoveRelic",
    Callback = function(value)
        CoveRelic = value -- Actualiza el estado de la variable según el valor del toggle

        -- Define la función a repetir
        local function Cove()
            local args = {
                [1] = "7",
                [2] = 1
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Function"):WaitForChild("Ornaments"):WaitForChild("[C-S]PlayerTryDoLuck"):InvokeServer(unpack(args))
            
        end

        -- Repite la función mientras el toggle esté activo
        while CoveRelic do
            Cove()
            wait() -- Espera un breve momento antes de repetir la función
        end
    end,
})

local ToggleTimeRelic = Tabs.Relics:CreateToggle({
    Name = "TIME",
    CurrentValue = false,
    Flag = "ToggleTimeRelic",
    Callback = function(value)
        TimeRelic = value -- Actualiza el estado de la variable según el valor del toggle

        -- Define la función a repetir
        local function Time()
            local args = {
                [1] = "8",
                [2] = 1
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Function"):WaitForChild("Ornaments"):WaitForChild("[C-S]PlayerTryDoLuck"):InvokeServer(unpack(args))
            
        end

        -- Repite la función mientras el toggle esté activo
        while TimeRelic do
            Time()
            wait() -- Espera un breve momento antes de repetir la función
        end
    end,
})

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> XTRAS SECTION <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
local Xtras = Tabs.Xtras:CreateSection("FUNCTIONS")

local Slider = Tabs.Xtras:CreateSlider({
    Name = "Slider Example",
    Range = {0, 300},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
    end,
})

local Slider = Tabs.Xtras:CreateSlider({
    Name = "Jump",
    Range = {0, 300},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 50,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
    end,
})

local Button = Tabs.Xtras:CreateButton({
    Name = "Server Hop",
    Callback = function()

        ServerHop() 
    end,
})

local Dropdown = Tabs.Xtras:CreateDropdown({
    Name = "Dropdown Example",
    Options = {"Option 1","Option 2"},
    CurrentOption = {"Option 1"},
    MultipleOptions = false,
    Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Option)
    -- The function that takes place when the selected option is changed
    -- The variable (Option) is a table of strings for the current selected options
    end,
})