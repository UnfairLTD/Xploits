local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "Unfair Hub V0.4.3 | MM2, HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})

OrionLib:MakeNotification({
    Name = "Executed",
    Content = "You're logged in as: " .. LocalPlayer.Name,
    Image = "rbxassetid://6031094678", -- Green check icon
    Time = 5
})

local executorName = identifyexecutor()  -- This function gets the current executor name

    -- Notification for supported executors (Delta or Vega X)
    if executorName == "Delta" or executorName == "Vega X" then
        OrionLib:MakeNotification({
            Name = "Executor Supported",
            Content = "the script supports: " .. executorName,
            Image = "rbxassetid://6031094678", -- Optional checkmark icon
            Time = 5
        })
    else
        -- Notification for unsupported executors
        OrionLib:MakeNotification({
            Name = "Executor Not Supported",
            Content = "(" .. executorName .. ") doesn't support Unfair Hub.",
            Image = "rbxassetid://6031091002", -- Optional X icon
            Time = 5
        })
    end

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

VisTab:AddToggle({
	Name = "Esp Murd",
	Default = false,
	Callback = function(Value)
		local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MurdererColor = Color3.fromRGB(255, 0, 0) -- Red for Murderer

-- Variable to track if labels are active (toggle)
local labelsActive = false

-- Function to get a player's role (assumes a 'Role' value exists)
local function getPlayerRole(player)
    if player:FindFirstChild("Role") then
        return player.Role.Value
    end
    return "Innocent" -- Default role
end

-- Function to create and update the label above the Murderer's head
local function updateLabel(player)
    -- Only create label for Murderer players and only if the player is not the LocalPlayer
    if player ~= LocalPlayer and getPlayerRole(player) == "Murderer" and player.Character and player.Character:FindFirstChild("Head") then
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

        -- Update text & color for Murderer
        local textLabel = billboard:FindFirstChildOfClass("TextLabel")
        if textLabel then
            textLabel.Text = player.Name
            -- Set color to Red for Murderer
            textLabel.TextColor3 = MurdererColor
        end
    end
end

-- Function to refresh labels every second
local function refreshLabels()
    while true do
        if labelsActive then
            -- Update labels only for players who are the Murderer (and visible only to LocalPlayer)
            for _, player in pairs(Players:GetPlayers()) do
                updateLabel(player)
            end
        end
        task.wait(1) -- Refresh every 1 second
    end
end

-- Toggle function to enable or disable label updates
local function toggleLabels()
    labelsActive = not labelsActive
    if labelsActive then
        print("Murderer labels are now ACTIVE.")
    else
        print("Murderer labels are now INACTIVE.")
    end
end

-- Call toggleLabels() to activate or deactivate labels based on the condition you want
toggleLabels() -- This can be called from other parts of the script based on the condition you set

-- Start refreshing labels
task.spawn(refreshLabels)

	end    
})

VisTab:AddToggle({
	Name = "Esp Sheriff",
	Default = false,
	Callback = function(Value)
		local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local SheriffColor = Color3.fromRGB(0, 0, 255) -- Blue for Sheriff

-- Toggle state
local labelsActive = false

-- Function to get a player's role
local function getPlayerRole(player)
    if player:FindFirstChild("Role") then
        return player.Role.Value
    end
    return "Innocent"
end

-- Function to create and update the label above the Sheriff's head
local function updateLabel(player)
    if player ~= LocalPlayer and getPlayerRole(player) == "Sheriff" and player.Character and player.Character:FindFirstChild("Head") then
        local head = player.Character.Head
        local billboard = head:FindFirstChild("PlayerLabel")

        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "PlayerLabel"
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.Adornee = head
            billboard.AlwaysOnTop = true
            billboard.Parent = head

            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextScaled = true
            textLabel.Font = Enum.Font.GothamBold
            textLabel.Parent = billboard
        end

        local textLabel = billboard:FindFirstChildOfClass("TextLabel")
        if textLabel then
            textLabel.Text = player.Name
            textLabel.TextColor3 = SheriffColor
        end
    end
end

-- Function to refresh labels every second
local function refreshLabels()
    while true do
        if labelsActive then
            for _, player in pairs(Players:GetPlayers()) do
                updateLabel(player)
            end
        end
        task.wait(1)
    end
end

-- Toggle function to enable or disable the label
local function toggleLabels()
    labelsActive = not labelsActive
end

-- Call this to activate the labels (no keybind used)
toggleLabels()

-- Start refreshing loop
task.spawn(refreshLabels)

	end    
})

VisTab:AddToggle({
	Name = "Cham",
	Default = false,
	Callback = function(Value)
		local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Colors = {
    Murderer = Color3.fromRGB(255, 0, 0), -- Red
    Sheriff = Color3.fromRGB(0, 0, 255),  -- Blue
    Innocent = Color3.fromRGB(0, 255, 0)  -- Green
}

-- Toggle state
local chamsActive = false

-- Function to get a player's role
local function getPlayerRole(player)
    if player:FindFirstChild("Role") then
        return player.Role.Value
    end
    return "Innocent"
end

-- Function to apply cham effect
local function applyCham(player)
    if player ~= LocalPlayer and player.Character then
        for _, part in ipairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") and not part:FindFirstChild("Cham") then
                local cham = Instance.new("Highlight")
                cham.Name = "Cham"
                cham.Adornee = part
                cham.Parent = part
                cham.DepthMode = Enum.HighlightDepthMode.Occluded
            end
        end
    end
end

-- Function to refresh chams
local function refreshChams()
    while true do
        if chamsActive then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local role = getPlayerRole(player)
                    local color = Colors[role] or Colors.Innocent

                    for _, part in ipairs(player.Character:GetChildren()) do
                        local cham = part:FindFirstChild("Cham")
                        if cham then
                            cham.FillColor = color
                            cham.OutlineColor = color
                        else
                            applyCham(player)
                        end
                    end
                end
            end
        end
        task.wait(1)
    end
end

-- Toggle function to enable or disable chams
local function toggleChams()
    chamsActive = not chamsActive
end

-- Call to enable on startup (remove if you want it off by default)
toggleChams()

-- Start the cham refresh loop
task.spawn(refreshChams)

	end    
})

VisTab:AddToggle({
	Name = "Cham Murd",
	Default = false,
	Callback = function(Value)
		local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local MurdererColor = Color3.fromRGB(255, 0, 0) -- Red for Murderer

-- Toggle state
local chamsActive = false

-- Function to get a player's role
local function getPlayerRole(player)
    if player:FindFirstChild("Role") then
        return player.Role.Value
    end
    return "Innocent"
end

-- Function to apply cham effect
local function applyCham(player)
    if player ~= LocalPlayer and player.Character then
        for _, part in ipairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") and not part:FindFirstChild("Cham") then
                local cham = Instance.new("Highlight")
                cham.Name = "Cham"
                cham.Adornee = part
                cham.Parent = part
                cham.DepthMode = Enum.HighlightDepthMode.Occluded
                cham.FillColor = MurdererColor
                cham.OutlineColor = MurdererColor
            end
        end
    end
end

-- Function to remove all chams from a player
local function removeCham(player)
    if player.Character then
        for _, part in ipairs(player.Character:GetChildren()) do
            local cham = part:FindFirstChild("Cham")
            if cham then
                cham:Destroy()
            end
        end
    end
end

-- Function to refresh chams every second
local function refreshChams()
    while true do
        if chamsActive then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and getPlayerRole(player) == "Murderer" then
                    applyCham(player)
                else
                    removeCham(player)
                end
            end
        else
            -- Turn off all chams when toggle is off
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    removeCham(player)
                end
            end
        end
        task.wait(1)
    end
end

-- Toggle function
local function toggleChams()
    chamsActive = not chamsActive
end

-- Enable chams by default (you can comment this if you want it disabled at start)
toggleChams()

-- Start the cham refresh loop
task.spawn(refreshChams)

	end    
})

VisTab:AddToggle({
	Name = "Cham Sheriff",
	Default = false,
	Callback = function(Value)
		local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local SheriffColor = Color3.fromRGB(0, 0, 255) -- Blue for Sheriff

-- Toggle state
local chamsActive = false

-- Function to get a player's role
local function getPlayerRole(player)
    if player:FindFirstChild("Role") then
        return player.Role.Value
    end
    return "Innocent"
end

-- Function to apply cham effect
local function applyCham(player)
    if player ~= LocalPlayer and player.Character then
        for _, part in ipairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") and not part:FindFirstChild("Cham") then
                local cham = Instance.new("Highlight")
                cham.Name = "Cham"
                cham.Adornee = part
                cham.Parent = part
                cham.DepthMode = Enum.HighlightDepthMode.Occluded
                cham.FillColor = SheriffColor
                cham.OutlineColor = SheriffColor
            end
        end
    end
end

-- Function to remove cham effects
local function removeCham(player)
    if player.Character then
        for _, part in ipairs(player.Character:GetChildren()) do
            local cham = part:FindFirstChild("Cham")
            if cham then
                cham:Destroy()
            end
        end
    end
end

-- Function to refresh chams every second
local function refreshChams()
    while true do
        if chamsActive then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and getPlayerRole(player) == "Sheriff" then
                    applyCham(player)
                else
                    removeCham(player)
                end
            end
        else
            -- Remove all chams if toggle is off
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    removeCham(player)
                end
            end
        end
        task.wait(1)
    end
end

-- Toggle function
local function toggleChams()
    chamsActive = not chamsActive
end

-- Enable toggle by default (optional: comment this out to start disabled)
toggleChams()

-- Start the cham refresh loop
task.spawn(refreshChams)

	end    
})

VisTab:AddToggle({
	Name = "Cham Coins",
	Default = false,
	Callback = function(Value)
		local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local CoinColor = Color3.fromRGB(255, 255, 0) -- Yellow for Coins

-- Toggle state
local chamsActive = false

-- Function to apply cham effect to a coin
local function applyCham(coin)
    if not coin:FindFirstChild("Cham") then
        local cham = Instance.new("Highlight")
        cham.Name = "Cham"
        cham.Adornee = coin
        cham.Parent = coin
        cham.DepthMode = Enum.HighlightDepthMode.Occluded
        cham.FillColor = CoinColor
        cham.OutlineColor = CoinColor
    end
end

-- Function to remove cham from a coin
local function removeCham(coin)
    local cham = coin:FindFirstChild("Cham")
    if cham then
        cham:Destroy()
    end
end

-- Function to refresh chams every second
local function refreshChams()
    while true do
        for _, coin in ipairs(Workspace:GetChildren()) do
            if coin:IsA("Part") and coin.Name == "Coin" then
                if chamsActive then
                    applyCham(coin)
                else
                    removeCham(coin)
                end
            end
        end
        task.wait(1)
    end
end

-- Toggle function
local function toggleChams()
    chamsActive = not chamsActive
end

-- Enable toggle by default (optional)
toggleChams()

-- Start the cham refresh loop
task.spawn(refreshChams)

	end    
})

VisTab:AddToggle({
	Name = "Esp Gun",
	Default = false,
	Callback = function(Value)
		local Workspace = game:GetService("Workspace")

local GunLabelColor = Color3.fromRGB(0, 255, 0) -- Green for Dropped Gun

-- Toggle state
local labelsActive = false

-- Function to create or update a label above the dropped gun
local function updateGunLabel(gun)
    if gun:IsA("Part") and gun.Name == "GunDrop" then
        local billboard = gun:FindFirstChild("GunLabel")

        -- If label doesn't exist, create it
        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "GunLabel"
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.Adornee = gun
            billboard.Parent = gun

            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextScaled = true
            textLabel.Font = Enum.Font.GothamBold
            textLabel.TextColor3 = GunLabelColor
            textLabel.Text = "Dropped Gun"
            textLabel.Parent = billboard
        end
    end
end

-- Function to remove label from gun
local function removeGunLabel(gun)
    local label = gun:FindFirstChild("GunLabel")
    if label then
        label:Destroy()
    end
end

-- Function to refresh gun labels every second
local function refreshGunLabels()
    while true do
        for _, item in ipairs(Workspace:GetChildren()) do
            if item:IsA("Part") and item.Name == "GunDrop" then
                if labelsActive then
                    updateGunLabel(item)
                else
                    removeGunLabel(item)
                end
            end
        end
        task.wait(1)
    end
end

-- Toggle function
local function toggleGunLabels()
    labelsActive = not labelsActive
end

-- Enable by default (optional)
toggleGunLabels()

-- Start refreshing loop
task.spawn(refreshGunLabels)

	end    
})

VisTab:AddToggle({
	Name = "Role Notify",
	Default = false,
	Callback = function(Value)
		local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RoleColors = {
    ["Murderer"] = Color3.fromRGB(255, 0, 0),
    ["Sheriff"] = Color3.fromRGB(0, 0, 255),
    ["Innocent"] = Color3.fromRGB(0, 255, 0)
}

local function showInstantRole()
    local roleValue = ReplicatedStorage:WaitForChild("GetRole"):InvokeServer() -- Retrieves your role instantly
    local roleChooser = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("RoleChooserGui") 

    if roleChooser then
        local roleLabel = roleChooser:FindFirstChild("InstantRoleLabel")
        if not roleLabel then
            roleLabel = Instance.new("TextLabel")
            roleLabel.Name = "InstantRoleLabel"
            roleLabel.Size = UDim2.new(0, 200, 0, 50)
            roleLabel.Position = UDim2.new(0.5, -100, 0, -60)
            roleLabel.BackgroundTransparency = 1
            roleLabel.TextScaled = true
            roleLabel.Font = Enum.Font.GothamBold
            roleLabel.Parent = roleChooser
        end

        roleLabel.Text = "Your Role: " .. roleValue
        roleLabel.TextColor3 = RoleColors[roleValue] or Color3.fromRGB(255, 255, 255)
    end
end

showInstantRole()

	end 

})

VisTab:AddToggle({
	Name = "Mute Radio",
	Default = false,
	Callback = function(Value)
		local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Toggle state
local muteEnabled = false

local function muteRadios()
    if not muteEnabled then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local backpack = player:FindFirstChildOfClass("Backpack")
            local character = player.Character

            -- Mute radios in backpack
            if backpack then
                for _, item in pairs(backpack:GetChildren()) do
                    if item:IsA("Tool") and item:FindFirstChild("Handle") then
                        local sound = item.Handle:FindFirstChildOfClass("Sound")
                        if sound then
                            sound.Volume = 0
                        end
                    end
                end
            end

            -- Mute radios in character
            for _, obj in pairs(character:GetChildren()) do
                if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                    local sound = obj.Handle:FindFirstChildOfClass("Sound")
                    if sound then
                        sound.Volume = 0
                    end
                end
            end
        end
    end
end

-- Heartbeat loop to keep radios muted
RunService.Heartbeat:Connect(function()
    muteRadios()
end)

-- Toggle function
local function toggleMute()
    muteEnabled = not muteEnabled
end

-- Enable by default (optional)
toggleMute()

	end    
})

local MiscTab = Window:MakeTab({
	Name = "Innocent Tab",
	Icon = "nil",
	PremiumOnly = false
})

MiscTab:AddButton({
	Name = "Void Murder",
	Callback = function()
        local function getMurderer()
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player:FindFirstChild("Backpack") then
                    for _, tool in ipairs(player.Backpack:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name == "Knife" then
                            return player
                        end
                    end
                    if player.Character:FindFirstChild("Knife") then
                        return player
                    end
                end
            end
            return nil
        end
        
        -- Void the murderer
        local function voidMurderer()
            local murderer = getMurderer()
            if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
                murderer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -5000, 0)
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Success",
                    Text = murderer.Name .. " has been voided.",
                    Duration = 4
                })
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "No Murderer Found",
                    Text = "Couldn't detect the murderer yet.",
                    Duration = 4
                })
            end
        end
  	end    
})

MiscTab:AddToggle({
	Name = "Auto get Gun",
	Default = false,
	Callback = function(Value)
		local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Mouse = LocalPlayer:GetMouse()

-- Variable to track if the player has the gun
local hasGun = false

-- Function to detect when the gun drops and grab it
local function grabGun()
    -- Search for the gun in the game world
    local gun = nil
    for _, item in pairs(workspace:GetChildren()) do
        -- Check if it's a gun
        if item:IsA("Tool") and item.Name == "Gun" then
            gun = item
            break
        end
    end

    if gun then
        -- If the player doesn't already have the gun, move towards it and grab it
        if not hasGun then
            local gunPosition = gun.Position
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(gunPosition) -- Move to gun
            wait(0.1) -- Wait for the character to reach the gun

            -- Simulate grabbing the gun (this assumes the gun can be picked up automatically)
            local gunClone = gun:Clone()
            gunClone.Parent = LocalPlayer.Backpack
            gun:Destroy() -- Remove the gun from the world
            hasGun = true
            print("Gun grabbed!")
        end
    end
end

-- Reset gun status after each round
local function onRoundStart()
    hasGun = false
end

-- Continuously search for the gun and grab it every second
RunService.Heartbeat:Connect(function()
    grabGun()
end)

-- Listen for round start event to reset the hasGun variable
game:GetService("ReplicatedStorage"):WaitForChild("Rounds").RoundStarted.OnClientEvent:Connect(onRoundStart)

	end        
})

MiscTab:AddBind({
	Name = "Get gun",
	Default = Enum.KeyCode.G,
	Hold = false,
	Callback = function()
		local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        local Mouse = LocalPlayer:GetMouse()
        local UserInputService = game:GetService("UserInputService")
        
        -- Variable to track if the player has the gun
        local hasGun = false
        
        -- Function to detect when the gun drops and grab it
        local function grabGun()
            -- Search for the gun in the game world
            local gun = nil
            for _, item in pairs(workspace:GetChildren()) do
                -- Check if it's a gun
                if item:IsA("Tool") and item.Name == "Gun" then
                    gun = item
                    break
                end
            end
        
            if gun then
                -- If the player doesn't already have the gun, move towards it and grab it
                if not hasGun then
                    local gunPosition = gun.Position
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(gunPosition) -- Move to gun
                    wait(0.1) -- Wait for the character to reach the gun
        
                    -- Simulate grabbing the gun (this assumes the gun can be picked up automatically)
                    local gunClone = gun:Clone()
                    gunClone.Parent = LocalPlayer.Backpack
                    gun:Destroy() -- Remove the gun from the world
                    hasGun = true
                    print("Gun grabbed!")
                end
            end
        end
        
        -- Listen for the "G" key press to grab the gun
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            -- Only listen for the G key if it's not already processed by the game (such as typing in the chat)
            if gameProcessed then return end
        
            if input.KeyCode == Enum.KeyCode.G then
                grabGun()
            end
        end)
        
        -- Reset gun status after each round
        local function onRoundStart()
            hasGun = false
        end
        
        -- Listen for round start event to reset the hasGun variable
        game:GetService("ReplicatedStorage"):WaitForChild("Rounds").RoundStarted.OnClientEvent:Connect(onRoundStart)
        
            end      
})

MiscTab:AddToggle({
	Name = "Better Aim",
	Default = false,
	Callback = function(Value)
		local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Mouse = LocalPlayer:GetMouse()

-- Function to get the player's role
local function getPlayerRole(player)
    if player:FindFirstChild("Role") then
        return player.Role.Value
    end
    return "Innocent" -- Default role
end

-- Function to shoot bullet towards the murderer when the sheriff fires
local function shootAtMurderer()
    -- Check if the player is sheriff
    if getPlayerRole(LocalPlayer) == "Sheriff" then
        -- Find the murderer
        local murderer = nil
        for _, player in pairs(Players:GetPlayers()) do
            if getPlayerRole(player) == "Murderer" then
                murderer = player
                break
            end
        end

        if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
            local murdererPosition = murderer.Character.HumanoidRootPart.Position

            -- Fire the gun at the murderer's position
            local gun = LocalPlayer.Backpack:FindFirstChild("Gun")
            if gun then
                -- Assuming the gun is a Tool that fires a bullet when the "Fire" event is triggered
                local bullet = gun:FindFirstChild("Handle") or gun:FindFirstChildOfClass("Part")
                if bullet then
                    -- Create a custom ray from gun's position to murderer's position
                    local direction = (murdererPosition - bullet.Position).unit * 100 -- Adjust range as needed
                    local ray = Ray.new(bullet.Position, direction)

                    -- Fire the bullet toward the murderer (simulate the shot)
                    local hit, position = workspace:FindPartOnRay(ray, LocalPlayer.Character)

                    -- Create a visual effect for the shot (optional)
                    local shotEffect = Instance.new("Part")
                    shotEffect.Size = Vector3.new(0.1, 0.1, (position - bullet.Position).magnitude)
                    shotEffect.Position = (bullet.Position + position) / 2
                    shotEffect.Anchored = true
                    shotEffect.CanCollide = false
                    shotEffect.BrickColor = BrickColor.new("Bright red")
                    shotEffect.Parent = workspace
                    game:GetService("Debris"):AddItem(shotEffect, 0.5)

                    -- Trigger the gun's shooting animation
                    gun:Activate()
                end
            end
        end
    end
end

-- Listen for shooting input
Mouse.Button1Down:Connect(function()
    shootAtMurderer()
end)

	end    
})

MiscTab:AddBind({
	Name = "Kill",
	Default = Enum.KeyCode.K,
	Hold = false,
	Callback = function()
		local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Function to get the player's role
local function getPlayerRole(player)
    if player:FindFirstChild("Role") then
        return player.Role.Value
    end
    return "Innocent" -- Default role
end

-- Function to kill all players if the player is murderer
local function killAllPlayers()
    if getPlayerRole(LocalPlayer) == "Murderer" then
        for _, player in pairs(Players:GetPlayers()) do
            -- Check if it's not the local player
            if player ~= LocalPlayer then
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    local humanoid = player.Character.Humanoid
                    humanoid.Health = 0 -- Set health to 0, effectively killing the player
                end
            end
        end
    end
end

-- Continuously check if the player is murderer and kill all other players
RunService.Heartbeat:Connect(function()
    killAllPlayers()
end)

	end       
})

MiscTab:AddBind({
	Name = "Shoot Murder",
	Default = Enum.KeyCode.C,
	Hold = false,
	Callback = function()
		local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()

-- Function to get player's role
local function getPlayerRole(player)
    if player:FindFirstChild("Role") then
        return player.Role.Value
    end
    return "Innocent" -- Default role
end

-- Function to automatically shoot the murderer if you're the Sheriff or Hero
local function shootMurderer()
    if getPlayerRole(LocalPlayer) == "Sheriff" or getPlayerRole(LocalPlayer) == "Hero" then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if getPlayerRole(player) == "Murderer" then
                    -- Get the murderer’s position
                    local murderer = player.Character
                    if murderer and murderer:FindFirstChild("HumanoidRootPart") then
                        -- Shoot at the murderer’s position
                        mouse.Hit = murderer.HumanoidRootPart.CFrame
                        mouse.Button1Down:Fire() -- Simulate shooting
                    end
                end
            end
        end
    end
end

-- Continuously check if you're the Sheriff or Hero and shoot the murderer
game:GetService("RunService").Heartbeat:Connect(function()
    shootMurderer()
end)

	end     
})

local TeleTab = Window:MakeTab({
	Name = "Teleport",
	Icon = "nil",
	PremiumOnly = false
})

TeleTab:AddButton({
	Name = "Lobby",
	Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        -- Function to teleport to the lobby
        local function teleportToLobby()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Part") and v.Name:lower():find("lobby") then
                        -- Teleport to the lobby's position
                        LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 3, 0)
                        return
                    end
                end
            end
        end
        
        -- Keybind to teleport (Press "L" to go to the lobby)
        game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.L then
                teleportToLobby()
            end
        end)
        
      end    
})

TeleTab:AddButton({
	Name = "Map",
	Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        -- Function to teleport to the map
        local function teleportToMap()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Part") and v.Name:lower():find("spawn") then
                        -- Teleport to the map's spawn location
                        LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 3, 0)
                        return
                    end
                end
            end
        end
        
        -- Keybind to teleport (Press "M" to go to the map)
        game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.M then
                teleportToMap()
            end
        end)

  	end    
})

TeleTab:AddButton({
	Name = "Above Map",
	Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        -- Function to teleport above the map
        local function teleportAboveMap()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Part") and v.Name:lower():find("spawn") then
                        -- Teleport above the map
                        LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 100, 0)
                        return
                    end
                end
            end
        end
        
        -- Automatically teleport when the script runs
        teleportAboveMap()

  	end    
})

TeleTab:AddButton({
	Name = "Murderer",
	Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        -- Function to get the Murderer's position and teleport
        local function teleportToMurderer()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player:FindFirstChild("Role") and player.Role.Value == "Murderer" then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                        return
                    end
                end
            end
        end
        
        -- Automatically teleport to the Murderer when executed
        teleportToMurderer()

  	end    
})

TeleTab:AddButton({
	Name = "Sheriff",
	Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        -- Function to find and teleport to the Sheriff
        local function teleportToSheriff()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player:FindFirstChild("Role") and player.Role.Value == "Sheriff" then
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                        return
                    end
                end
            end
        end
        
        -- Automatically teleport to the Sheriff when executed
        teleportToSheriff()

  	end    
})

local AutoTab = Window:MakeTab({
	Name = "Auto Farm",
	Icon = "nil",
	PremiumOnly = false
})

AutoTab:AddToggle({
	Name = "Farm Coins",
	Default = false,
	Callback = function(Value)
        local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Workspace = game:GetService("Workspace")

-- Function to collect coins automatically
local function collectCoins()
    while true do
        for _, coin in pairs(Workspace:GetChildren()) do
            if coin:IsA("Part") and coin.Name == "Coin" then
                -- Move the player under the coin
                HumanoidRootPart.CFrame = coin.CFrame * CFrame.new(0, -10, 0) -- Moves you 10 studs below the coin
                task.wait(0.1) -- Small delay to ensure pickup
            end
        end
        task.wait(1) -- Refresh every second
    end
end

-- Start collecting coins
task.spawn(collectCoins)

	end       
})

local PremiumTab = Window:MakeTab({
	Name = "Premuim (FREE!)",
	Icon = "nil",
	PremiumOnly = false
})

PremiumTab:AddToggle({
	Name = "Break Gun",
	Default = false,
	Callback = function(Value)
		local gunBroken = false

-- Function to break the sheriff's gun
local function breakGun()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Backpack") then
            for _, tool in ipairs(player.Backpack:GetChildren()) do
                if tool:IsA("Tool") and tool.Name == "Gun" then
                    -- Disconnect gun firing
                    local gun = tool
                    if gun:FindFirstChild("Remote") then
                        gun.Remote.OnServerEvent:Disconnect()
                    end
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Gun Broken",
                        Text = player.Name .. "'s gun has been disabled.",
                        Duration = 4
                    })
                end
            end
        end
    end
end

-- Function to unbreak the sheriff's gun (restore firing)
local function unbreakGun()
    -- Re-enable gun's firing mechanism
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Backpack") then
            for _, tool in ipairs(player.Backpack:GetChildren()) do
                if tool:IsA("Tool") and tool.Name == "Gun" then
                    -- Reconnect gun firing functionality
                    local gun = tool
                    if gun:FindFirstChild("Remote") then
                        local remote = gun.Remote
                        remote.OnServerEvent:Connect(function(playerWhoFired)
                            -- Replicate normal gun behavior
                        end)
                    end
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Gun Restored",
                        Text = player.Name .. "'s gun is now functional.",
                        Duration = 4
                    })
                end
            end
        end
    end
end

-- Toggle function for breaking/unbreaking the gun
local function toggleGunBreak()
    if gunBroken then
        unbreakGun()
        gunBroken = false
    else
        breakGun()
        gunBroken = true
    end
end
	end    
})

PremiumTab:AddToggle({
	Name = "Lag Server",
	Default = false,
	Callback = function(Value)
		local lagging = false

-- Function to create server lag
local function createLag()
    while lagging do
        -- Spam remote event (This is just a dummy example, replace with a real remote event if needed)
        local remote = Instance.new("RemoteEvent")
        remote.Name = "LagEvent"
        remote.Parent = ReplicatedStorage
        remote:FireAllClients()
        
        -- Create a bunch of parts (simulating mass object creation)
        for i = 1, 100 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(1, 1, 1)
            part.Position = Vector3.new(math.random(-1000, 1000), 50, math.random(-1000, 1000))
            part.Anchored = true
            part.Parent = workspace
        end
        
        -- Wait briefly to avoid script timeout, but still create lag
        wait(0.1)
    end
end

-- Function to stop server lag
local function stopLag()
    -- Remove all lag-related objects or events
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Part") then
            obj:Destroy()
        end
    end
    for _, obj in ipairs(ReplicatedStorage:GetChildren()) do
        if obj.Name == "LagEvent" then
            obj:Destroy()
        end
    end
end

-- Toggle function for creating server lag
local function toggleLag()
    if lagging then
        lagging = false
        stopLag()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Lag Stopped",
            Text = "Server lag has been stopped.",
            Duration = 4
        })
    else
        lagging = true
        createLag()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Lag Started",
            Text = "Server lag is now active.",
            Duration = 4
        })
    end
end
	end    
})

PremiumTab:AddToggle({
	Name = "Auto Trap All",
	Default = false,
	Callback = function(Value)
		local trapEnabled = false

-- Function to deploy traps on all players
local function trapAllPlayers()
    -- Check if the player is the Murderer
    if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Backpack") then
        local backpack = LocalPlayer.Character.Backpack
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "BearTrap" then
                -- Trigger trap for all players
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        -- Create a trap effect on each player
                        local trap = tool:Clone()
                        trap.Parent = player.Character
                        trap:Activate()
                        
                        -- Optionally, you can add a cooldown or visual effect to show trap is deployed
                        game.Debris:AddItem(trap, 3)  -- Remove trap after 3 seconds
                    end
                end
                break
            end
        end
    end
end

-- Function to toggle trap effect on/off
local function toggleTrap()
    if trapEnabled then
        trapEnabled = false
        game.StarterGui:SetCore("SendNotification", {
            Title = "Trap Disabled",
            Text = "Trap effect is now disabled for all players.",
            Duration = 4
        })
    else
        trapEnabled = true
        game.StarterGui:SetCore("SendNotification", {
            Title = "Trap Enabled",
            Text = "Trap effect is now enabled for all players.",
            Duration = 4
        })
    end
end
	end    
})

PremiumTab:AddToggle({
	Name = "Make all blind",
	Default = false,
	Callback = function(Value)
		local blindEnabled = false

-- Create blindness effect
local function applyBlindness()
    -- Make a black frame that covers the entire screen
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.Position = UDim2.new(0, 0, 0, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.5  -- Adjust transparency to make it less intense or more intense
    Frame.Parent = ScreenGui

    -- Apply the effect to all players except the executor
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            -- Create a ScreenGui for the other player and apply the blindness
            local blindGui = ScreenGui:Clone()
            blindGui.Parent = player.PlayerGui
        end
    end
end

-- Remove blindness effect
local function removeBlindness()
    -- Remove all blindness screens from all players
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            -- Remove the blind effect by destroying the ScreenGui
            local blindGui = player:FindFirstChild("PlayerGui")
            if blindGui then
                local effect = blindGui:FindFirstChild("ScreenGui")
                if effect then
                    effect:Destroy()
                end
            end
        end
    end
end

-- Toggle function to enable or disable blindness
local function toggleBlindness()
    if blindEnabled then
        blindEnabled = false
        removeBlindness()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Blindness Disabled",
            Text = "Blindness effect has been removed from all players.",
            Duration = 4
        })
    else
        blindEnabled = true
        applyBlindness()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Blindness Enabled",
            Text = "Blindness effect has been applied to all players (except you).",
            Duration = 4
        })
    end
end
	end    
})

PremiumTab:AddButton({
	Name = "Force Reset",
	Callback = function()
        local function forceResetAllPlayers()
            -- Loop through all players and reset them
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                    local humanoid = player.Character:FindFirstChild("Humanoid")
                    humanoid.Health = 0  -- This forces the player's character to reset
                end
            end
            game.StarterGui:SetCore("SendNotification", {
                Title = "Reset Successful",
                Text = "All players have been reset except you.",
                Duration = 4
            })
        end
  	end    
})

PremiumTab:AddButton({
	Name = "Fake Inv",
	Callback = function()
        local function createFakeTool(toolName)
            local tool = Instance.new("Tool")
            tool.Name = toolName
            tool.RequiresHandle = true
            
            -- Create a handle so the tool appears in the inventory
            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(1, 1, 1)
            handle.Anchored = false
            handle.CanCollide = false
            handle.Material = Enum.Material.SmoothPlastic
            handle.Color = Color3.fromRGB(255, 0, 0)  -- Red color for visibility
            handle.Parent = tool
        
            -- Set the tool to not be usable
            tool.Activated:Connect(function()
                -- Prevent any functionality by overriding activation
            end)
            
            -- Parent the tool to the player's backpack
            tool.Parent = Backpack
        end
        
        -- Function to fill the inventory with fake knives and guns
        local function fillInventoryWithFakeTools()
            -- Create fake knives and guns (adjust this as necessary for more items)
            for i = 1, 10 do
                createFakeTool("FakeKnife_" .. i)
                createFakeTool("FakeGun_" .. i)
            end
        
            -- Notify the player that the inventory has been filled with fake tools
            game.StarterGui:SetCore("SendNotification", {
                Title = "Fake Inventory Filled",
                Text = "Your inventory has been filled with fake knives and guns! Everyone can see it.",
                Duration = 4
            })
        end
  	end    
})

PremiumTab:AddDropdown({
    Name = "Fling Player",
    Options = playerList,
    Callback = function(playerName)
        selectedPlayer = playerName
    end
})

-- Function to fling the selected player
local function flingPlayer(playerName)
    -- Check if player is selected
    if not selectedPlayer then
        game.StarterGui:SetCore("SendNotification", {
            Title = "Error",
            Text = "Please select a player first!",
            Duration = 4
        })
        return
    end

    -- Find the selected player
    local player = Players:FindFirstChild(playerName)
    if player and player.Character then
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            -- Apply a force to fling the player
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(5000, 5000, 5000)  -- High force values to fling the player
            bodyVelocity.Velocity = Vector3.new(0, 500, 0)  -- Direction of the fling (upwards)
            bodyVelocity.Parent = humanoidRootPart

            -- Clean up after a short delay
            game.Debris:AddItem(bodyVelocity, 0.1)

            game.StarterGui:SetCore("SendNotification", {
                Title = "Fling Success",
                Text = selectedPlayer .. " has been flung!",
                Duration = 4
            })
        end
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Error",
            Text = "Selected player is not available!",
            Duration = 4
        })
    end
end

PremiumTab:AddButton({
    Name = "Fling",
    Callback = function()
        flingPlayer(selectedPlayer)
    end
})

local SettingTab = Window:MakeTab({
	Name = "Settings",
	Icon = "nil",
	PremiumOnly = false
})

local colorOptions = {
    "Red",
    "Green",
    "Blue",
    "Yellow",
    "Purple",
    "Cyan",
    "Orange"
}

-- Function to change Orion UI color
local function changeUIColor(colorName)
    local color = Color3.fromRGB(255, 255, 255) -- Default to white

    if colorName == "Red" then
        color = Color3.fromRGB(255, 0, 0)
    elseif colorName == "Green" then
        color = Color3.fromRGB(0, 255, 0)
    elseif colorName == "Blue" then
        color = Color3.fromRGB(0, 0, 255)
    elseif colorName == "Yellow" then
        color = Color3.fromRGB(255, 255, 0)
    elseif colorName == "Purple" then
        color = Color3.fromRGB(128, 0, 128)
    elseif colorName == "Cyan" then
        color = Color3.fromRGB(0, 255, 255)
    elseif colorName == "Orange" then
        color = Color3.fromRGB(255, 165, 0)
    end

    -- Change the UI's primary color
    Window:SetTheme({
        Primary = color
    })
end

--DropDown
SettingTab:AddDropdown({
    Name = "Select UI Color",
    Options = colorOptions,
    Default = "Red",
    Callback = function(selectedColor)
        changeUIColor(selectedColor)
    end
})

local function destroyUI()
    -- Destroy the entire window
    Window:Destroy()

    -- Notify user
    game.StarterGui:SetCore("SendNotification", {
        Title = "Orion UI Destroyed",
        Text = "The Orion UI has been destroyed.",
        Duration = 4
    })
end

-- Button to destroy the Orion UI
SettingTab:AddButton({
    Name = "Destroy UI",
    Callback = function()
        destroyUI()
    end
})

SettingTab:AddToggle({
	Name = "Exploit Protection",
	Default = false,
	Callback = function(Value)
		local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Prevent fling by monitoring the BodyVelocity and BodyGyro
local function preventFling()
    local bodyVelocity = Character:FindFirstChild("BodyVelocity")
    local bodyGyro = Character:FindFirstChild("BodyGyro")

    if bodyVelocity then
        bodyVelocity.MaxForce = Vector3.new(0, 0, 0) -- Disable force
        bodyVelocity.Velocity = Vector3.new(0, 0, 0) -- Stop any movement
    end
    
    if bodyGyro then
        bodyGyro.MaxTorque = Vector3.new(0, 0, 0) -- Disable rotation force
        bodyGyro.CFrame = Character.HumanoidRootPart.CFrame -- Fix orientation
    end
end

-- Prevent bringing to the void by resetting position if it's too low
local function preventVoid()
    local function checkPosition()
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = Character.HumanoidRootPart
            if rootPart.Position.Y < -1000 then
                -- Teleport back to a safe position (e.g., spawn point)
                rootPart.CFrame = CFrame.new(0, 50, 0)
            end
        end
    end

    -- Continuously monitor position to prevent falling to the void
    game:GetService("RunService").Heartbeat:Connect(function()
        checkPosition()
    end)
end

-- Prevent kick by intercepting remote events used for kicking
local function preventKick()
    -- Attempt to block remote events that could be used for kicking
    local function onKickEvent(event)
        -- Block any kick requests or stop actions
        if event.Name == "KickEvent" then
            return false
        end
    end

    -- Listen to all RemoteEvents for a possible kick signal
    for _, object in pairs(game:GetChildren()) do
        if object:IsA("RemoteEvent") then
            object.OnServerEvent:Connect(onKickEvent)
        end
    end
end

-- Toggle for protection
local protectionEnabled = true

local function toggleProtection()
    protectionEnabled = not protectionEnabled

    if protectionEnabled then
        -- Enable all protections
        print("Exploit protection enabled")
        preventFling()
        preventVoid()
        preventKick()
    else
        -- Disable protections (for testing purposes)
        print("Exploit protection disabled")
    end
end
	end    
})

SettingTab:AddButton({
	Name = "Server hop",
	Callback = function()
        local Players = game:GetService("Players")
        local TeleportService = game:GetService("TeleportService")
        local LocalPlayer = Players.LocalPlayer
        local PlaceId = game.PlaceId  -- Current game Place ID
        
        -- Function to teleport to a new server of the same game
        local function serverHop()
            -- Teleport the player to the same game
            TeleportService:Teleport(PlaceId, LocalPlayer)
            print("Server hopping to a new server!")
        end
  	end    
})

local TrollTab = Window:MakeTab({
	Name = "Troll",
	Icon = "nil",
	PremiumOnly = false
})

TrollTab:AddButton({
	Name = "FE YEET GUI (Trollface Edition)",
	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sitiosweb24/FE-Yeet-GUI-Trollgeface-Edition/refs/heads/main/mainscript.lua",true))()
  	end    
})

TrollTab:AddButton({
	Name = "Play Sound (Loud)",
	Callback = function()
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
        
        -- Sound creation function
        local function playLoudSound()
            -- Create a sound instance
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://yourSoundID"  -- Replace this with the actual sound asset ID
            sound.Volume = 10  -- Set the volume (maximum loudness)
            sound.Parent = ReplicatedStorage  -- Parent it to ReplicatedStorage (or Workspace)
            
            -- Play the sound for all players
            for _, player in pairs(Players:GetPlayers()) do
                local character = player.Character
                if character then
                    -- Play sound on each player's head (or any part of the character)
                    local head = character:FindFirstChild("Head")
                    if head then
                        sound:Clone().Parent = head
                        sound:Play()
                    end
                end
            end
        end
  	end    
})

TrollTab:AddButton({
	Name = "YOU ARE AN IDIOT",
	Callback = function()
        local function playIdiotSound()
            -- Create a sound instance
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://yourSoundID"  -- Replace this with the actual sound asset ID
            sound.Volume = 10  -- Set the volume (maximum loudness)
            sound.Parent = ReplicatedStorage  -- Parent it to ReplicatedStorage or Workspace
            
            -- Play the sound for all players by attaching it to their heads
            for _, player in pairs(Players:GetPlayers()) do
                local character = player.Character
                if character then
                    local head = character:FindFirstChild("Head")
                    if head then
                        sound:Clone().Parent = head
                        sound:Play()
                    end
                end
            end
        end
        
        -- Function to create and display the "You Are An Idiot" GUI for all players
        local function showIdiotGui()
            -- Loop through all players
            for _, player in pairs(Players:GetPlayers()) do
                -- Ensure the player has a player GUI
                if player.PlayerGui then
                    -- Create ScreenGui
                    local screenGui = Instance.new("ScreenGui")
                    screenGui.Name = "IdiotGui"
                    screenGui.Parent = player.PlayerGui
        
                    -- Create the TextLabel (the "You are an idiot" message)
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.new(0, 200, 0, 50)
                    textLabel.Position = UDim2.new(0.5, -100, 0.5, -25)  -- Centered on screen
                    textLabel.Text = "You are an idiot!"
                    textLabel.TextSize = 24
                    textLabel.BackgroundTransparency = 0.5
                    textLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textLabel.TextScaled = true
                    textLabel.Parent = screenGui
        
                    -- Enable dragging functionality for the TextLabel
                    local dragging = false
                    local dragStart = nil
                    local startPos = nil
        
                    -- Function to begin dragging the GUI
                    textLabel.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            dragStart = input.Position
                            startPos = textLabel.Position
                        end
                    end)
        
                    -- Function to drag the GUI around the screen
                    textLabel.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            local delta = input.Position - dragStart
                            textLabel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                        end
                    end)
        
                    -- Function to stop dragging the GUI
                    textLabel.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)
                end
            end
        end
  	end    
})

TrollTab:AddButton({
	Name = "Replace Sky",
	Callback = function()
        local function replaceSkyWithCat()
            -- Create the Sky object
            local sky = Instance.new("Sky")
            
            sky.SkyboxBk = "rbxassetid://80701819973015"  -- Back face
            sky.SkyboxDn = "rbxassetid://80701819973015"  -- Bottom face
            sky.SkyboxFt = "rbxassetid://80701819973015"  -- Front face
            sky.SkyboxLf = "rbxassetid://80701819973015"  -- Left face
            sky.SkyboxRt = "rbxassetid://80701819973015"  -- Right face
            sky.SkyboxUp = "rbxassetid://80701819973015"  -- Top face
            
            -- Apply the Sky object to the Lighting service (this will change the sky for all players)
            Lighting.Sky = sky
        end
  	end    
})

getgenv().SecureMode = true

elseif game.PlaceId == 2753915549 then
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "Unfair Hub V0.4.3 | Blox Fruits", HidePremium = false, SaveConfig = false})


OrionLib:MakeNotification({
    Name = "Executed",
    Content = "You're logged in as: " .. LocalPlayer.Name,
    Image = "rbxassetid://6031094678", -- Green check icon
    Time = 5
})

local executorName = identifyexecutor()  -- This function gets the current executor name

    -- Notification for supported executors (Delta or Vega X)
    if executorName == "Delta" or executorName == "Vega X" then
        OrionLib:MakeNotification({
            Name = "Executor Supported",
            Content = "the script supports: " .. executorName,
            Image = "rbxassetid://6031094678", -- Optional checkmark icon
            Time = 5
        })
    else
        -- Notification for unsupported executors
        OrionLib:MakeNotification({
            Name = "Executor Not Supported",
            Content = "(" .. executorName .. ") doesn't support Unfair Hub.",
            Image = "rbxassetid://6031091002", -- Optional X icon
            Time = 5
        })
    end

local BloxTab = Window:MakeTab({
	Name = "Welcome",
	Icon = "nil",
	PremiumOnly = false
})

local Label = Blox:AddLabel("Status: Checking...")

-- functions
local isPremium = false
pcall(function()
    isPremium = OrionLib.IsPremium and OrionLib:IsPremium()
end)

-- Update label
if isPremium then
    Label:Set("Status: Premium")
else
    Label:Set("Status: Free User")
end

BloxTab:AddButton({
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


local BloxyTab = Window:MakeTab({
	Name = "Visual",
	Icon = "nil",
	PremiumOnly = false
})

local TeleportSpots = {
    ["Starter Island"] = Vector3.new(1037, 17, 1430),
    ["Jungle"] = Vector3.new(-1249, 11, 341),
    ["Pirate Village"] = Vector3.new(-1144, 5, 3850),
    ["Desert"] = Vector3.new(1142, 6, 4370),
    ["Frozen Village"] = Vector3.new(1207, 27, -1210),
    ["Marine Fortress"] = Vector3.new(-4500, 20, 4260),
    ["Sky Island"] = Vector3.new(-4970, 2780, -2625),
    ["Colosseum"] = Vector3.new(-1420, 7, -3015),
    ["Prison"] = Vector3.new(5100, 1, 4740),
    ["Magma Village"] = Vector3.new(-5230, 50, 8500),
}

-- Dropdown for selecting teleport location
BloxyTab:AddDropdown({
    Name = "Teleport To",
    Default = "",
    Options = table.pack(unpack((function()
        local keys = {}
        for name, _ in pairs(TeleportSpots) do
            table.insert(keys, name)
        end
        return keys
    end)())),
    Callback = function(selected)
        if TeleportSpots[selected] then
            HRP.CFrame = CFrame.new(TeleportSpots[selected])
        end
    end
})

local currentDropdown
local playerNames = {}

-- Create Dropdown
BloxyTab:AddDropdown({
    Name = "Select Player to Teleport",
    Default = "",
    Options = playerNames,
    Callback = function(selected)
        local targetPlayer = Players:FindFirstChild(selected)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            HRP.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
        end
    end
})

local Mouse = game.Players.LocalPlayer:GetMouse()
local UIS = game:GetService("UserInputService")

local isSpamEnabled = false

-- Function to spam click
local function spamClick()
    while isSpamEnabled do
        -- Check if mouse is inside the UI
        if not OrionLib:IsWindowOpen() and not UIS.MouseEnabled then
            Mouse.Button1Down:Fire()
        end
        task.wait(0.1) -- Adjust the click interval
    end
end

-- Add a toggle to enable/disable spam clicking
BloxyTab:AddToggle({
    Name = "Auto Click",
    Default = false,
    Callback = function(state)
        isSpamEnabled = state
        if state then
            spamClick()
        end
    end
})

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")

-- Ensure that if the mouse is in the UI, it won't click
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- Disable clicking if the mouse is in the UI
        if OrionLib:IsWindowOpen() then
            isSpamEnabled = false
        end
    end
end)

local isAutoClaimEnabled = false
local chestLocations = {}

-- Function to teleport to the chest and claim it
local function teleportToChest(chest)
    if chest and chest.Parent then
        -- Teleport to the chest
        HumanoidRootPart.CFrame = chest.CFrame

        -- Auto claim chest (Assume there's a function to claim chest)
        -- If the chest has a function to be claimed or clicked, call it here
        -- For example, if there's a remote or function to claim:
        -- game.ReplicatedStorage.ClaimChest:FireServer(chest)

        print("Chest claimed at position: " .. tostring(chest.Position))
    end
end

-- Function to continuously check and teleport to new chests
local function checkForChests()
    while isAutoClaimEnabled do
        -- Loop through all the chests in the game
        for _, chest in ipairs(Workspace:GetChildren()) do
            -- Check if it's a chest (you might want to replace this with the correct name or object type)
            if chest:IsA("Part") and chest.Name == "Chest" then
                -- Teleport to the first chest found and claim it
                teleportToChest(chest)
                chestLocations[chest] = true
                task.wait(0.5) -- Adjust the wait time to prevent spamming
            end
        end
        task.wait(1) -- Refresh every second to check for new chests
    end
end

-- Add a toggle to enable/disable chest teleport and auto claim
BloxyTab:AddToggle({
    Name = "Auto get chest",
    Default = false,
    Callback = function(state)
        isAutoClaimEnabled = state
        if state then
            checkForChests()  -- Start checking for chests if enabled
        end
    end
})

BloxyTab:AddToggle({
	Name = "Lag Server",
	Default = false,
	Callback = function(Value)
		local lagging = false

-- Function to create server lag
local function createLag()
    while lagging do
        -- Spam remote event (This is just a dummy example, replace with a real remote event if needed)
        local remote = Instance.new("RemoteEvent")
        remote.Name = "LagEvent"
        remote.Parent = ReplicatedStorage
        remote:FireAllClients()
        
        -- Create a bunch of parts (simulating mass object creation)
        for i = 1, 100 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(1, 1, 1)
            part.Position = Vector3.new(math.random(-1000, 1000), 50, math.random(-1000, 1000))
            part.Anchored = true
            part.Parent = workspace
        end
        
        -- Wait briefly to avoid script timeout, but still create lag
        wait(0.1)
    end
end

-- Function to stop server lag
local function stopLag()
    -- Remove all lag-related objects or events
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Part") then
            obj:Destroy()
        end
    end
    for _, obj in ipairs(ReplicatedStorage:GetChildren()) do
        if obj.Name == "LagEvent" then
            obj:Destroy()
        end
    end
end

-- Toggle function for creating server lag
local function toggleLag()
    if lagging then
        lagging = false
        stopLag()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Lag Stopped",
            Text = "Server lag has been stopped.",
            Duration = 4
        })
    else
        lagging = true
        createLag()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Lag Started",
            Text = "Server lag is now active.",
            Duration = 4
        })
    end
end
	end    
})

local TrollerTab = Window:MakeTab({
	Name = "Troll",
	Icon = "nil",
	PremiumOnly = false
})

TrollerTab:AddButton({
	Name = "FE YEET GUI (Trollface Edition)",
	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sitiosweb24/FE-Yeet-GUI-Trollgeface-Edition/refs/heads/main/mainscript.lua",true))()
  	end    
})

TrollerTab:AddButton({
	Name = "Play Sound (Loud)",
	Callback = function()
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
        
        -- Sound creation function
        local function playLoudSound()
            -- Create a sound instance
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://yourSoundID"  -- Replace this with the actual sound asset ID
            sound.Volume = 10  -- Set the volume (maximum loudness)
            sound.Parent = ReplicatedStorage  -- Parent it to ReplicatedStorage (or Workspace)
            
            -- Play the sound for all players
            for _, player in pairs(Players:GetPlayers()) do
                local character = player.Character
                if character then
                    -- Play sound on each player's head (or any part of the character)
                    local head = character:FindFirstChild("Head")
                    if head then
                        sound:Clone().Parent = head
                        sound:Play()
                    end
                end
            end
        end
  	end    
})

TrollerTab:AddButton({
	Name = "YOU ARE AN IDIOT",
	Callback = function()
        local function playIdiotSound()
            -- Create a sound instance
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://yourSoundID"  -- Replace this with the actual sound asset ID
            sound.Volume = 10  -- Set the volume (maximum loudness)
            sound.Parent = ReplicatedStorage  -- Parent it to ReplicatedStorage or Workspace
            
            -- Play the sound for all players by attaching it to their heads
            for _, player in pairs(Players:GetPlayers()) do
                local character = player.Character
                if character then
                    local head = character:FindFirstChild("Head")
                    if head then
                        sound:Clone().Parent = head
                        sound:Play()
                    end
                end
            end
        end
        
        -- Function to create and display the "You Are An Idiot" GUI for all players
        local function showIdiotGui()
            -- Loop through all players
            for _, player in pairs(Players:GetPlayers()) do
                -- Ensure the player has a player GUI
                if player.PlayerGui then
                    -- Create ScreenGui
                    local screenGui = Instance.new("ScreenGui")
                    screenGui.Name = "IdiotGui"
                    screenGui.Parent = player.PlayerGui
        
                    -- Create the TextLabel (the "You are an idiot" message)
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.new(0, 200, 0, 50)
                    textLabel.Position = UDim2.new(0.5, -100, 0.5, -25)  -- Centered on screen
                    textLabel.Text = "You are an idiot!"
                    textLabel.TextSize = 24
                    textLabel.BackgroundTransparency = 0.5
                    textLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textLabel.TextScaled = true
                    textLabel.Parent = screenGui
        
                    -- Enable dragging functionality for the TextLabel
                    local dragging = false
                    local dragStart = nil
                    local startPos = nil
        
                    -- Function to begin dragging the GUI
                    textLabel.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            dragStart = input.Position
                            startPos = textLabel.Position
                        end
                    end)
        
                    -- Function to drag the GUI around the screen
                    textLabel.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            local delta = input.Position - dragStart
                            textLabel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                        end
                    end)
        
                    -- Function to stop dragging the GUI
                    textLabel.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)
                end
            end
        end
  	end    
})

TrollerTab:AddButton({
	Name = "Replace Sky",
	Callback = function()
        local function replaceSkyWithCat()
            -- Create the Sky object
            local sky = Instance.new("Sky")
            
            sky.SkyboxBk = "rbxassetid://80701819973015"  -- Back face
            sky.SkyboxDn = "rbxassetid://80701819973015"  -- Bottom face
            sky.SkyboxFt = "rbxassetid://80701819973015"  -- Front face
            sky.SkyboxLf = "rbxassetid://80701819973015"  -- Left face
            sky.SkyboxRt = "rbxassetid://80701819973015"  -- Right face
            sky.SkyboxUp = "rbxassetid://80701819973015"  -- Top face
            
            -- Apply the Sky object to the Lighting service (this will change the sky for all players)
            Lighting.Sky = sky
        end
  	end    
})

OrionLib:Init()
