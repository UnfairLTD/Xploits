if game.PlaceId == 142823291 then
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local username = LocalPlayer.Name

-- Create the UI Window
local Window = Rayfield:CreateWindow({
   Name = "Unfair Hub V0.4.4 | Murder Mystery 2",
   Icon = 0,
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Sirius",
   Theme = "Default",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Big Hub"
   }
})

-- Copy Discord invite to clipboard
setclipboard("https://discord.com/invite/7m6n24djSh")

-- Play a ding sound
local function playDingSound()
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://9068539820"
    Sound.Volume = 1
    Sound.PlayOnRemove = true
    Sound.Parent = game:GetService("SoundService")
    Sound:Destroy()
end

-- Notify user of execution
Window:Notify({
    Title = "Executed",
    Content = "Discord Copied Into Clipboard, Check out Our Discord",
    Duration = 3,
    Image = 7733658504 -- Small green checkmark
})

playDingSound()

-- Main Tab with player info
local MainTab = Window:CreateTab("Player Info", 4483362458)

-- Empty line for Rayfield to initialize properly
wait(0.1)

MainTab:CreateLabel("Logged in as: " .. username)
local statusLabel = MainTab:CreateLabel("Status: Checking...")

-- Check Roblox Premium
local function checkPremium()
    if LocalPlayer.MembershipType == Enum.MembershipType.Premium then
        statusLabel:Set("Status: Premium")
        -- You can add any additional premium functionality here
    else
        statusLabel:Set("Status: None")
    end
end

checkPremium()

end
