local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Unfair Hub | MM2, HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})

local MainTab = Window:MakeTab({
	Name = "Welcome",
	Icon = "nil",
	PremiumOnly = false
})

local Label = MainTab:AddLabel("Status: Checking...")

-- functions
local isPremium = false
pcall(function()
    isPremium = OrionLib.IsPremium and OrionLib:IsPremium()
end)

-- Update label
if isPremium then
    Label:Set("Status: Premium ✅")
else
    Label:Set("Status: Free User ❌")
end

MainTab:AddButton({
    Name = "Copy Discord", 
    Callback = function()
        -- Set the link to be copied
        setclipboard("https://discord.com/invite/7m6n24djSh")
        OrionLib:MakeNotification({
            Name = "Link Copied",
            Content = "Don't forget to check out!",
            Image = "rbxassetid://7734054099", -- Optional icon
            Time = 5
        })
    end
})

local VisTab = Window:MakeTab({
	Name = "Visual",
	Icon = "nil",
	PremiumOnly = false
})

VisTab:AddToggle({
	Name = "ESP",
	Default = false,
	Callback = function(Value)
		local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MurdererColor = Color3.fromRGB(255, 0, 0) -- Red for Murderer
local SheriffColor = Color3.fromRGB(0, 0, 255) -- Blue for Sheriff
local InnocentColor = Color3.fromRGB(0, 255, 0) -- Green for Innocent

-- Variable to track if the labels are active (toggle)
local labelsActive = false

-- Function to get a player's role (assumes a 'Role' value exists)
local function getPlayerRole(player)
    if player:FindFirstChild("Role") then
        return player.Role.Value
    end
    return "Innocent" -- Default role
end

-- Function to update or create a label above a player's head
local function updateLabel(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local head = player.Character.Head
        local billboard = head:FindFirstChild("PlayerLabel")

        -- If label doesn't exist, create it
        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "PlayerLabel"
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.Adornee = head
            billboard.Parent = head

            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextScaled = true
            textLabel.Font = Enum.Font.GothamBold
            textLabel.Parent = billboard
        end

        -- Get role and update text & color
        local role = getPlayerRole(player)
        local textLabel = billboard:FindFirstChildOfClass("TextLabel")
        if textLabel then
            textLabel.Text = player.Name
            if role == "Murderer" then
                textLabel.TextColor3 = MurdererColor
            elseif role == "Sheriff" then
                textLabel.TextColor3 = SheriffColor
            else
                textLabel.TextColor3 = InnocentColor
            end
        end
    end
end

-- Function to refresh labels every second
local function refreshLabels()
    while true do
        if labelsActive then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    updateLabel(player)
                end
            end
        end
        task.wait(1) -- Refresh every 1 second
    end
end

-- Toggle function to enable or disable the labels
local function toggleLabels()
    labelsActive = not labelsActive
    if labelsActive then
        print("Labels are now ACTIVE.")
    else
        print("Labels are now INACTIVE.")
    end
end

-- Example usage: Toggling the labels with a key press (e.g., "T" key)
LocalPlayer.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.T then
        toggleLabels()
    end
end)

-- Start refreshing labels in a separate thread
task.spawn(refreshLabels)

	end    
})

OrionLib:Init()
