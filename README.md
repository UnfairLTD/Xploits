# Unfair Hub
Hello! This is the official Unfair Hub V0.1.1 Script, its the first version of this script. for more updates, dont forget to check out on github or Discord!

## Loadstring
```lua
getgenv().SecureMode = true

local r, s = pcall(function() return loadstring(game:HttpGet("https://tinyurl.com/UnfairHub")) end)
if r and type(s) == "function" then pcall(s) else game:GetService("StarterGui"):SetCore("SendNotification", {Title="Unfair Hub", Text="Outdated or invalid script URL!", Duration=5}) end
```


## Compatibility
Unsupported Executors:
* Nezur
* JJSploit
* Solara
* AWP

## Updates
for more updates, check out the discord channel, right [here](https://discord.com/invite/7m6n24djSh)
