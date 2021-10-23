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

## Example Script; (Corruption)
```lua
local ts = game:GetService("TweenService");

local s,f = pcall(function()
local healthLabel = Instance.new("TextLabel");
healthLabel.Name = "HealthLabel"
healthLabel.Text = "Corruption"
healthLabel.Position = UDim2.new(0.5, -100, 0.5, -45)
healthLabel.BackgroundTransparency = 1
healthLabel.TextSize = 22
healthLabel.Font = Enum.Font.Ubuntu
healthLabel.TextColor3 = Color3.new(1, 1, 1)
healthLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
healthLabel.TextStrokeTransparency = 0
healthLabel.Size = UDim2.new(0, 200, 0, 50)

local fullhp = false

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/greasemonkey123/yafn-UIOverhaul/main/UI.lua",true))();
healthLabel.Parent = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("GameUI").realGameUI.HPBarBG
healthLabel.ZIndex = 10;
local tween = ts:Create(UI.hp.Health,
TweenInfo.new(
0.5,
Enum.EasingStyle.Linear,
Enum.EasingDirection.Out,
-1,
true,
0
),{BackgroundColor3 = Color3.new(0.5,0,0.5)})
UI.hp.SetHealthColor(Color3.new(1,1,1));
UI.hp.SetMissingColor(Color3.new(0,0,0));
function UI.hp.HealthChanged(h)
   if h == 100 then
      tween:Play()
   else
      tween:Cancel()
      if h > 85 then
         UI.hp.SetHealthColor(Color3.new(1,0,1));
      elseif h < 15 then
         UI.hp.SetHealthColor(Color3.new(1,1,1));
      else
         UI.hp.SetHealthColor(Color3.new(1,0.5,1));
      end
   end
end
end)

if not s then
   warn(f)
end
```
