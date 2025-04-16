local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

	local function GetPlayerCoins(player)
    local coins
    pcall(function()
        coins = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Coins")
        -- Alternative example: coins = player:WaitForChild("Data"):FindFirstChild("Coins")
    end)
    return coins
end
	local murdererESPEnabled = false
	local currentMurderer = nil
	local sheriffESPEnabled = false
	local currentSheriff = nil
	local espBox = nil
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local username = LocalPlayer.Name
	local userId = LocalPlayer.UserId
	local espEnabled = false
	local RunService = game:GetService("RunService")
	local highlights = {}
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local nameTags = {}
	local updateConnection
	local connection
	local espEnabled = false
	local playerNames = {}
	local playerDropdown = nil
	local Workspace = game:GetService("Workspace")

	local function removeESP()
    if espBox then
        espBox:Destroy()
        espBox = nil
    end
    currentSheriff = nil
end

-- Create blue highlight for the Sheriff
local function createESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "SheriffESP"
    highlight.FillColor = Color3.fromRGB(0, 170, 255)
    highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
    highlight.FillTransparency = 0.25
    highlight.OutlineTransparency = 0
    highlight.Adornee = player.Character
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = player.Character

    espBox = highlight
end

-- Sheriff detection logic
local function findSheriff()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hasGun = (player.Backpack:FindFirstChild("Gun") ~= nil) or (player.Character:FindFirstChild("Gun") ~= nil)
            if hasGun then
                return player
            end
        end
    end
    return nil
end

-- Loop to constantly check for Sheriff
RunService.RenderStepped:Connect(function()
    if sheriffESPEnabled then
        local foundSheriff = findSheriff()
        if foundSheriff ~= currentSheriff then
            removeESP()
            if foundSheriff then
                createESP(foundSheriff)
                currentSheriff = foundSheriff
            end
        end
    else
        removeESP()
    end
end)

	local function removeESP()
    if espBox then
        espBox:Destroy()
        espBox = nil
    end
    currentMurderer = nil
end

-- Create red highlight for Murderer
local function createESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "MurdererESP"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
    highlight.FillTransparency = 0.25
    highlight.OutlineTransparency = 0
    highlight.Adornee = player.Character
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = player.Character

    espBox = highlight
end

-- Detect who has the Knife (Murderer)
local function findMurderer()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player:FindFirstChild("Backpack") then
            local hasKnife = player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")
            if hasKnife then
                return player
            end
        end
    end
    return nil
end

-- Update every frame
RunService.RenderStepped:Connect(function()
    if murdererESPEnabled then
        local foundMurderer = findMurderer()
        if foundMurderer ~= currentMurderer then
            removeESP()
            if foundMurderer then
                createESP(foundMurderer)
                currentMurderer = foundMurderer
            end
        end
    else
        removeESP()
    end
end)

	local function applyESP(player, color, name)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end

    -- Clear old ESP
    if highlights[player] then
        highlights[player]:Destroy()
        highlights[player] = nil
    end

    -- Create new Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = name
    highlight.FillColor = color
    highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
    highlight.FillTransparency = 0.25
    highlight.OutlineTransparency = 0
    highlight.Adornee = player.Character
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = player.Character

    highlights[player] = highlight
end

-- Remove ESP for all players
local function clearAllESP()
    for player, esp in pairs(highlights) do
        if esp then
            esp:Destroy()
        end
    end
    highlights = {}
end

-- Main detection and ESP logic
RunService.RenderStepped:Connect(function()
    if not espEnabled then
        clearAllESP()
        return
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player:FindFirstChild("Backpack") then
            local hasKnife = player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")
            local hasGun = player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")

            if hasKnife then
                applyESP(player, Color3.fromRGB(255, 0, 0), "MurdererESP")
            elseif hasGun then
                applyESP(player, Color3.fromRGB(0, 170, 255), "SheriffESP")
            else
                applyESP(player, Color3.fromRGB(0, 255, 0), "InnocentESP")
            end
        end
    end
end)

	local function getCoinCount(player)
    local success, coins = pcall(function()
        return player:FindFirstChild("Data") and player.Data:FindFirstChild("Coins") and player.Data.Coins.Value or 0
    end)
    return success and coins or "Unknown"
end

-- Show notification
local function showCoinNotification(player)
    local coins = getCoinCount(player)
    Rayfield:Notify({
        Title = player.Name .. "'s Coins",
        Content = "They have " .. tostring(coins) .. " coins.",
        Duration = 5,
        Image = 4483362458
    })
end

-- Build current player list (no LocalPlayer)
local function buildPlayerList()
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(list, plr.Name)
        end
    end
    return list
end

	setclipboard("https://discord.com/invite/7m6n24djSh")

    local Window = Rayfield:CreateWindow({
        Name = "Unfair Hub - v0.1.1 (PREVIEW)",
        Icon = 0,
        LoadingTitle = "Unfair UI Loading..",
        LoadingSubtitle = "Hello User!",
        Theme = "Default",

        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,

        ConfigurationSaving = {
            Enabled = false,
            FolderName = true,
            FileName = "Configuration"
        },

        Discord = {
            Enabled = false,
            Invite = "noinvitelink",
            RememberJoins = true
        },

        KeySystem = false,
        KeySettings = {
            Title = "Get Key",
            Subtitle = "Key System",
            Note = "Discord copied please find the key in discord!",
            FileName = "Key",
            SaveKey = false,
            GrabKeyFromSite = false,
            Key = {"Hello"}
        }
    })

    -- Play the "ding" sound
    local function playDingSound()
        local Sound = Instance.new("Sound")
        Sound.SoundId = "rbxassetid://9068539820"
        Sound.Volume = 1
        Sound.Parent = game:GetService("SoundService")
        Sound:Play()
        game:GetService("Debris"):AddItem(Sound, 2)
    end

    playDingSound()

    -- Create the "Player Info" Tab
    local MainTab = Window:CreateTab("Home", "warehouse")

	MainTab:CreateLabel("Welcome to Unfair Hub")	

    MainTab:CreateLabel("Signed in as : " .. username)


	MainTab:CreateParagraph({
    Title = "Version 1.1 - Updates/Changelog",
    Content = [[
 [*] Script Hub :   
   [*] Bug Fixes
      [*] Optimized Script
	 [*] Adding more features
        ]]
    })

	local Tab = Window:CreateTab("MM2", "gamepad-2")
    local Esp = Tab:CreateSection("ESP")

	local Toggle = Tab:CreateToggle({
   		Name = "ESP All",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})
	
	local Toggle = Tab:CreateToggle({
   		Name = "ESP Murderer",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "ESP Sheriff",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})
	
	local Toggle = Tab:CreateToggle({
   		Name = "Trap Esp",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Gun Esp",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})



    local Chams = Tab:CreateSection("Chams")

    local Toggle = Tab:CreateToggle({
   		Name = "Cham All",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

    local Toggle = Tab:CreateToggle({
   		Name = "Cham Murderer",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Cham Sheriff",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Cham Coins",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Slider = Tab:CreateSlider({
   		Name = "Cham Opacity",
   		Range = {0, 100},
   		Increment = 10,
   		Suffix = "",
   		CurrentValue = 70,
   		Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
})

	local Lobby = Tab:CreateSection("Lobby")

	local Toggle = Tab:CreateToggle({
   		Name = "Hide Lobby Esp & Chams",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Effect = Tab:CreateSection("Effects")

	local Toggle = Tab:CreateToggle({
   		Name = "See dead Chat",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Role Notify",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Mute Radios",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Better FPS",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Show Timer",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Player = Tab:CreateSection("Player")

	local Button = Tab:CreateButton({
   		Name = "God Mode",
   		Callback = function()
  		-- The function that takes place when the button is pressed
   	end,
	})

	local Button = Tab:CreateButton({
   		Name = "Invisible",
   		Callback = function()
   		-- The function that takes place when the button is pressed
  	end,
	})

	local Tools = Tab:CreateSection("Tools")

	local Toggle = Tab:CreateToggle({
   		Name = "Say Roles",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "Void Protect",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Mods = Tab:CreateSection("Mods")

	local Toggle = Tab:CreateToggle({
   		Name = "Auto Get Gun",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Toggle = Tab:CreateToggle({
   		Name = "View Gun",
   		CurrentValue = false,
   		Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Value)
			--Script
   	end,
	})

	local Keybind = Tab:CreateKeybind({
   		Name = "Get Gun",
   		CurrentKeybind = "G",
   		HoldToInteract = false,
   		Flag = "Keybind1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Keybind)
			--Script
   	end,
	})

	local Dropdown = Tab:CreateDropdown({
   		Name = "Silent Aim",
   		Options = {"None","Knife","Gun"},
   		CurrentOption = {"None"},
   		MultipleOptions = true,
   		Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   		Callback = function(Options)
			--Script here
   	end,
	})

	local Dropdown = Tab:CreateDropdown({
		Name = "Aim",
		Options = {"Off","Static","Dynamic"},
		CurrentOption = {"Off"},
		MultipleOptions = true,
		Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
		Callback = function(Options)
		 --Script here
	end,
 	})

	 local Dropdown = Tab:CreateDropdown({
		Name = "Aim Body part",
		Options = {"Root","Torso","Head"},
		CurrentOption = {"Root"},
		MultipleOptions = true,
		Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
		Callback = function(Options)
		 --Script here
	end,
 	})

	local Label = Tab:CreateLabel("Checking gun status...")

	 -- Gun Check Loop
	task.spawn(function()
		while true do
			local gunDropped = Workspace:FindFirstChild("GunDrop")
			local sheriffAlive = false
	 
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player:FindFirstChild("Backpack") then
					local hasGun = player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")
					if hasGun then
						sheriffAlive = true
						break
					end
				end
			end
	 
			if gunDropped then
				gunLabel:Set("🟢 Gun Dropped")
			else
				if sheriffAlive then
					gunLabel:Set("🔴 Gun not dropped")
				else
					gunLabel:Set("🔴 Gun not dropped (Sheriff may be dead)")
				end
			end
	 
			task.wait(1)
		end
	end)

	local Misc = Window:CreateTab("Scripts", "code")

	local Label = Misc:CreateLabel("We are working on other games!")

	local Dropdown = Misc:CreateDropdown({
		Name = "Murder Mystery 2",
		Options = {"Copy"},
		CurrentOption = {""},
		MultipleOptions = false,
		Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
		Callback = function(Options)
			setclipboard("142823291")
		end,
	})

	local Premium = Window:CreateTab("Premium", "star")

	local Robux = Premium:CreateLabel("Get more Features with Unfair Hub Premium")
	local Legit = Premium:CreateLabel("Very Cheap and fun, just for 500 Robux!")

	Premium:CreateParagraph({
    	Title = "Features",
    	Content = [[
 [*] Kick features   
   [*] Breaking Game features
      [*] Commands For Alt!
	 [*] More Scripts!
        ]]
    })

	Premium:CreateParagraph({
    	Title = "Steps to get Premium",
    	Content = [[
	[1] Copy the button under the paragraph!
	[2] Go to any browser (Your're Choise)
	[3] Visit the website
	[4] Follow the instructions!
        ]]
    })

	local Button = Premium:CreateButton({
   		Name = "Copy URL",
   		Callback = function()
		   print("Good Script LOL")
   			setclipboard("Works!")
			   local function showNotification(title, text)

    local success, errorMsg = pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 15  -- Duration in seconds (adjust as needed)
        })
    end)

    if not success then
        warn("Failed to send notification:", errorMsg)
    end
end

-- Example usage
showNotification("Not Done", "We Are working on the Website please come back another time!")
   	end,
	})


















	









	local function showNotification(title, text)
    -- Ensure it runs on the local player to show the notification
    local success, errorMsg = pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 15  -- Duration in seconds (adjust as needed)
        })
    end)

    if not success then
        warn("Failed to send notification:", errorMsg)
    end
end

-- Example usage
showNotification("Unfair Hub Loaded", "The Script loaded sucessfully! Updates are in Discord or Github")
