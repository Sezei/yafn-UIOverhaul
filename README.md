# yafn-UIOverhaul
An overhaul for the YAFN UI. Game: https://www.roblox.com/games/6946711722/Yet-Another-Funkin-Night-Beta

# How to load
You can load the UI using this line;

```lua
local ret = loadstring(game:HttpGet("https://raw.githubusercontent.com/greasemonkey123/yafn-UIOverhaul/main/UI.lua",true))()
```

# API
The API is rather simple to use with this overhaul;
## HP Related API
* `ret.hpBar.SetHealthColor(color3:newcolor)` -> Sets the 'Health Remaining' bar (normally Green) to your preferred color3 value. Returns nil.
* `ret.hpBar.SetMissingColor(color3:newcolor)` -> Sets the 'Missing Health' part of the bar (normally Red) to your preferred color3 value. Returns nil.
* `ret.hpBar.HitFHealth()` -> **REWRITABLE FUNCTION.** Runs this function when the health value hits 85% and doesn't run again until your health gets below it.
* `ret.hpBar.HitFHealth()` -> **REWRITABLE FUNCTION.** Runs this function when the health value hits a 'neutral' spot and doesn't run again until your health gets below 15 or above 85.
* `ret.hpBar.HitLHealth()` -> **REWRITABLE FUNCTION.** Runs this function when the health value hits 15% and doesn't run again until your health gets above it.
* `ret.hpBar.onMiss()` -> **REWRITABLE FUNCTION.** Runs this function when a miss has been detected.
* `ret.hpBar.HealthChanged(number:newhealth)` -> **REWRITABLE FUNCTION.** Runs this function whenever the health has been changed. SENDS VARIABLE "newhealth".

## Other API stuff
* `ret.SetRatingColor(string:rating, color3:newcolor)` -> Sets the rating color of [Rating] to [newcolor].
* `ret.GetRatingColor(rating)` -> Gets the rating color of [Rating]. (Returns Color3 value).
