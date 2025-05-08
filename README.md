# Unfair Hub
Hello! This is the official Unfair Hub V0.1 Script, its the first version of this script. for more updates, dont forget to check out on github or Discord!

## Loadstring
```lua
getgenv().SecureMode = true

local r, s = pcall(function() return loadstring(game:HttpGet("https://raw.githubusercontent.com/UnfairLTD/Xploits/refs/heads/main/UnfairHub.lua")) end)
if r and type(s) == "function" then pcall(s) else game:GetService("StarterGui"):SetCore("SendNotification", {Title="Unfair Hub", Text="Please re-execute the script.", Duration=5}) end
```


## Compatibility

It depends on, wich things your Executor supports.

## Updates
we update very often, but still check out the our [Discord](https://discord.com/invite/7m6n24djSh).

