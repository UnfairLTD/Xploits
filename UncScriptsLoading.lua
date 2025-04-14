local scriptsToLoad = {
    {name = "Script 1", url = "https://raw.githubusercontent.com/UnfairScripts/Xploits/refs/heads/main/UncScript.lua"},
    {name = "Script 2", url = "https://pastebin.com/raw/wzB1Qh78"}
}

local passedScripts = {} -- List of successfully loaded scripts
local failedScripts = {} -- List of failed scripts

-- Function to load a script
local function loadScript(scriptData)
    local success, result = pcall(function()
        local scriptContent = game:HttpGet(scriptData.url) -- Get script from URL
        print("Fetched script content: " .. scriptContent)  -- Print the script content for debugging
        local func = loadstring(scriptContent)
        if func then
            func()  -- Execute the script
        else
            error("Failed to load script")  -- Handle case where loadstring fails
        end
    end)
    
    if success then
        table.insert(passedScripts, scriptData.name)
    else
        print("Error loading script: " .. result)  -- Print the error message
        table.insert(failedScripts, scriptData.name)
    end
end

-- Load all scripts
for _, scriptData in ipairs(scriptsToLoad) do
    loadScript(scriptData)
end

-- Notify about the result
local function notify(title, text, duration)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 10
        })
    end)
end

-- Show which scripts passed or failed
local passText = "✅ Passed Scripts:\n" .. table.concat(passedScripts, "\n") 
local failText = "❌ Failed Scripts:\n" .. table.concat(failedScripts, "\n")

-- Show notifications
if #passedScripts > 0 then
    notify("✅ Script Load Result", passText, 10)
end

if #failedScripts > 0 then
    notify("❌ Script Load Result", failText, 10)
end

-- Show notification based on how many scripts were loaded
if #passedScripts == 0 then
    notify("No Scripts Loaded", "No scripts were successfully loaded.", 10)
elseif #passedScripts == 1 then
    notify("1 Script Loaded", "1 script was successfully loaded.", 10)
elseif #passedScripts == 2 then
    notify("2 Scripts Loaded", "2 scripts were successfully loaded.", 10)
end

-- Output result to console
print("===== Script Load Test =====")
if #passedScripts > 0 then
    print("✅ Passed Scripts:")
    for _, script in ipairs(passedScripts) do
        print("- " .. script)
    end
end

if #failedScripts > 0 then
    print("❌ Failed Scripts:")
    for _, script in ipairs(failedScripts) do
        print("- " .. script)
    end
end
print("============================")
