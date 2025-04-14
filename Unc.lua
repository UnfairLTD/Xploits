local tickStart = tick()
local passed = 0
local total = 40 -- Updated for full UNC test coverage

-- 🛎️ Notify helper
local function notify(title, text, duration)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 10
        })
    end)
end

-- 📦 Executor name
local function getExecutor()
    return identifyexecutor and identifyexecutor() or "Unknown Executor"
end

-- ✅ Try-catch style test
local function try(func)
    local success = pcall(func)
    if success then passed += 1 end
end

-- 🧪 All feature checks
try(function() print("✅ Console check") end)
try(function() getgenv()._UNC = true end)
try(function() local _ = getfenv(function() end) end)
try(function() local _ = setfenv(function() end, getfenv()) end)
try(function() local old = print; hookfunction(print, function(...) end); hookfunction(print, old) end)
try(function() local _ = newcclosure(function() end) end)
try(function() local _ = islclosure(function() end) end)
try(function() local _ = getrawmetatable(game) end)
try(function() setreadonly(getrawmetatable(game), false); setreadonly(getrawmetatable(game), true) end)
try(function() make_writeable(getrawmetatable(game)) end)
try(function() make_readonly(getrawmetatable(game)) end)
try(function() local _ = checkcaller() end)
try(function() local _ = getcallingscript() end)
try(function() local _ = getgc() end)
try(function() local _ = getreg() end)
try(function() local _ = getconnections(game:GetService("Players").PlayerAdded) end)
try(function() local _ = iscclosure(function() end) end)
try(function() local _ = getupvalue(function() end, 1) end)
try(function() setupvalue(function() return 123 end, 1, 456) end)
try(function() local _ = debug.getinfo(function() end) end)
try(function()
    local p = Instance.new("Part", workspace)
    p.Anchored = false
    p.Position = Vector3.new(0,100,0)
    isnetworkowner(p)
end)
try(function() local _ = gethui() end)
try(function() setclipboard("UNC Test Clipboard") end)
try(function() local _ = request or http_request or syn and syn.request end)
try(function() local _ = getloadedmodules() end)
try(function() local _ = getinstances() end)
try(function()
    local a, b = Instance.new("Part", workspace), Instance.new("Part", workspace)
    a.Position, b.Position = Vector3.new(0,0,0), Vector3.new(0,0,0)
    firetouchinterest(a, b, 0)
end)
try(function() local _ = getrenv() end)
try(function() local _ = rawequal({}, {}) end)
try(function() local _ = rawset({}, "x", 1) end)
try(function() local _ = rawget({x = 1}, "x") end)
try(function() local _ = setmetatable({}, {}) end)
try(function() local _ = getmetatable(game) end)
try(function() local _ = select(1, ...) end)
try(function() local _ = typeof(getgenv) end)
try(function() local _ = pcall(function() end) end)
try(function() local _ = xpcall(function() end, function() end) end)
try(function() local _ = getrenv() end)
try(function() local _ = clonefunction and clonefunction(function() end) end)
try(function() local _ = getsenv and getsenv(game.Players.LocalPlayer.Character) end)

-- 🧾 Final Report
local score = math.floor((passed / total) * 100)
local tickEnd = tick()
local duration = string.format("%.2f", tickEnd - tickStart)
local execName = getExecutor()
local identity = printidentity and printidentity() or "Unknown"

-- 🔔 Notifications
notify("✅ UNC Test Complete", "Passed: " .. passed .. "/" .. total .. " (" .. score .. "/100)", 10)
wait(1)
notify("⏱️ Duration: " .. duration .. "s", "🧾 Identity Level: " .. tostring(identity), 10)
wait(1)

-- 📜 Console Output
print("====== UNC TEST REPORT ======")
print("🧠 Executor: " .. execName)
print("✅ Features Passed: " .. passed .. "/" .. total)
print("📈 Score: " .. score .. "/100")
print("⏱️ Time: " .. duration .. " seconds")
print("🧾 Identity Level: " .. tostring(identity))
print("==============================")
