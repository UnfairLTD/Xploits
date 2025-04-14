if game.PlaceId == 142823291 then
   local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

   local Players = game:GetService("Players")
   local LocalPlayer = Players.LocalPlayer
   local username = LocalPlayer.Name

   local Window = Rayfield:CreateWindow({
       Name = "Unfair Hub V1.1 | Murder Mystery 2",
       Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
       LoadingTitle = "Loading..",
       LoadingSubtitle = "Pls wait.",
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

   setclipboard("https://discord.com/invite/7m6n24djSh")

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
   Rayfield:Notify({
       Title = "Executed",
       Content = "Discord Copied Into Clipboard, Check out Our Discord",
       Duration = 3,
       Image = "rbxassetid://607866917" -- Icon for the notification
   })

   playDingSound()

   -- Create the "Player Info" Tab
   local MainTab = Window:CreateTab("Player Info", 4483362458)

   -- Create a label in the "Player Info" Tab to display the player's username
   MainTab:CreateLabel("Username: " .. username)

end
