if game.PlaceId == 142823291 then
   local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

   local Players = game:GetService("Players")
   local LocalPlayer = Players.LocalPlayer
   local username = LocalPlayer.Name

   local Window = Rayfield:CreateWindow({
       Name = "Unfair Hub V0.4.41 | Murder Mystery 2",
       Icon = 0,
       LoadingTitle = "Rayfield Interface Suite",
       LoadingSubtitle = "by Sirius",
       Theme = "Default",

       DisableRayfieldPrompts = false,
       DisableBuildWarnings = false,

       ConfigurationSaving = {
           Enabled = true,
           FolderName = nil,
           FileName = "Big Hub"
       },

       Discord = {
           Enabled = false,
           Invite = "noinvitelink",
           RememberJoins = true
       },

       KeySystem = false,
       KeySettings = {
           Title = "Untitled",
           Subtitle = "Key System",
           Note = "No method of obtaining the key is provided",
           FileName = "Key",
           SaveKey = true,
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

   -- Show a notification and play the sound
   print("Attempting to show notification...")  -- Debug line
   
   Rayfield:Notify({
       Title = "Executed",
       Content = "Discord Copied Into Clipboard, Check out Our Discord",
       Duration = 3,
       Image = 607866917 -- Green checkmark
   })

   playDingSound()

   -- Create the "Player Info" Tab
   local MainTab = Window:CreateTab("Player Info", 4483362458)

   -- Create a label in the "Player Info" Tab to display the player's username
   MainTab:CreateLabel("Username: " .. username)

   print("Notification should have been shown.")  -- Debug line
   
end
