-- Load Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Player and Camera Variables
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Variables for toggles and features
local ESPEnabled = false
local NoClipEnabled = false
local GodModeEnabled = false
local ChamsEnabled = false

-- Create the Orion Window
local Window = OrionLib:MakeWindow({Name = "Universal Script Hub", HidePremium = true, IntroEnabled = false})

-- Function to create ESP
local function createESP(player)
    if not player.Character then return end

    local esp = Instance.new("BillboardGui")
    esp.Parent = player.Character:WaitForChild("Head")
    esp.Size = UDim2.new(0, 200, 0, 50)
    esp.AlwaysOnTop = true
    esp.StudsOffset = Vector3.new(0, 2, 0)

    local label = Instance.new("TextLabel")
    label.Parent = esp
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = player.Name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0.5
    label.TextSize = 16
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
end

-- Function to remove ESP
local function removeESP(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local head = player.Character:FindFirstChild("Head")
        for _, child in pairs(head:GetChildren()) do
            if child:IsA("BillboardGui") then
                child:Destroy()
            end
        end
    end
end

-- No-Clip Function
local function toggleNoClip()
    NoClipEnabled = not NoClipEnabled
    local character = Player.Character
    if NoClipEnabled then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- God Mode Function
local function toggleGodMode()
    GodModeEnabled = not GodModeEnabled
    local character = Player.Character
    local humanoid = character:WaitForChild("Humanoid")
    if GodModeEnabled then
        humanoid.Health = humanoid.Health + 1000
        humanoid.MaxHealth = 10000
    else
        humanoid.MaxHealth = 100
    end
end

-- Kill All Function
local function killAll()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = 0
            end
        end
    end
end

-- Rejoin Function
local function rejoin()
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end

-- Chams Function
local function toggleChams()
    ChamsEnabled = not ChamsEnabled
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                if ChamsEnabled then
                    local outline = Instance.new("SelectionBox")
                    outline.Parent = head
                    outline.Adornee = head
                    outline.Color = Color3.fromRGB(0, 255, 0)
                    outline.LineThickness = 0.1
                else
                    for _, child in pairs(head:GetChildren()) do
                        if child:IsA("SelectionBox") then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    end
end

-- Refreshing ESP, Chams, and Kill All
RunService.Heartbeat:Connect(function()
    -- Refresh ESP (if enabled)
    if ESPEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                -- If ESP is not already present for the player, create it
                if not player.Character.Head:FindFirstChildOfClass("BillboardGui") then
                    createESP(player)
                end
            end
        end
    else
        -- Remove ESP for all players
        for _, player in pairs(game.Players:GetPlayers()) do
            removeESP(player)
        end
    end

    -- Refresh Chams (if enabled)
    if ChamsEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                local head = player.Character:FindFirstChild("Head")
                if head and not head:FindFirstChildOfClass("SelectionBox") then
                    toggleChams()
                end
            end
        end
    else
        -- Remove Chams for all players
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    for _, child in pairs(head:GetChildren()) do
                        if child:IsA("SelectionBox") then
                            child:Destroy()
                        end
                    end
                end
            end
        end
    end
end)

-- Create Orion GUI Buttons and Toggles

-- ESP Toggle
Window:MakeTab({
    Name = "Script",
    Icon = "rbxassetid://6039813346",
    PremiumOnly = false
})

Window:MakeToggle({
    Name = "Toggle ESP",
    Default = false,
    Callback = function(State)
        ESPEnabled = State
    end
})

-- No-Clip Toggle
Window:MakeToggle({
    Name = "Toggle No-Clip",
    Default = false,
    Callback = toggleNoClip
})

-- God Mode Toggle
Window:MakeToggle({
    Name = "Toggle God Mode",
    Default = false,
    Callback = toggleGodMode
})

-- Kill All Button
Window:MakeButton({
    Name = "Kill All Players",
    Callback = killAll
})

-- Rejoin Button
Window:MakeButton({
    Name = "Rejoin Game",
    Callback = rejoin
})

-- Chams Toggle
Window:MakeToggle({
    Name = "Toggle Chams",
    Default = false,
    Callback = toggleChams
})

-- Show the Orion Window
OrionLib:Init()
