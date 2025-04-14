if game.PlaceId == 142823291 then
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
        Name = "Unfair Hub V0.4.4 | Murder Mystery 2",
        Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
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
        Image = 3926305904
    })

    playDingSound()

    -- Example tab
    local MainTab = Window:CreateTab("Tab Example", 4483362458) -- Title, Image
end
