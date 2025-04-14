if game.PlaceId == 142823291 then
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Unfair Hub V0.4.4 | Murder Mystery 2",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Sirius",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

setclipboard("https://discord.com/invite/7m6n24djSh")

-- Play the "ding" sound
local function playDingSound()
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://9068539820"  -- Ding sound ID
    Sound.Volume = 1
    Sound.PlayOnRemove = true
    Sound.Parent = game:GetService("SoundService")
    Sound:Destroy()
end

-- Show a notification with the checkmark icon using Rayfield and play the sound at the same time
window:Notification({
    Title = "Executed",
    Content = "Discord Copied Into Clipboard, Check out Our Discord",
    Duration = 3,  -- Notification duration in seconds
    Icon = "rbxassetid://3926305904"  -- Checkmark icon Asset ID
})

playDingSound()

end
