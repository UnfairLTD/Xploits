

# Unfair Hub
This is the first version : 0.1



## Loadstring
```lua
getgenv().SecureMode = true

local r, s = pcall(function() return loadstring(game:HttpGet("tinyurl.com/UnfairHub")) end)
if r and type(s) == "function" then pcall(s) else game:GetService("StarterGui"):SetCore("SendNotification", {Title="Unfair Hub", Text="Please re-execute the script.", Duration=5}) end
```


## Compatibility

It depends on, wich things your Executor supports.

## Updates
we update very often, but still check out the our [Discord](https://discord.com/invite/7m6n24djSh).

