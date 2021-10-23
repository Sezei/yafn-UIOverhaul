local plr = game:GetService("Players").LocalPlayer
local ui = plr.PlayerGui:FindFirstChild("GameUI")
local real = ui.realGameUI

local hpBar = {}
hpBar.Image = real.HPBarBG
hpBar.Missing = real.HPBarBG.RedBar
hpBar.Health = real.HPBarBG.GreenBar

function hpBar.SetHealthColor(color)
    hpBar.Health.BackgroundColor3 = color
end
function hpBar.SetMissingColor(color)
    hpBar.Missing.BackgroundColor3 = color
    hpBar.Image.ImageColor3 = color
end
function hpBar.HitFHealth() -- Bind Hit Full Health - Runs function when Health gets filled. (90%+)
    return
end
function hpBar.HitNHealth() -- Bind Hit Normal Health - Runs function when Health gets between 90% to 10%.
    return
end
function hpBar.HitLHealth() -- Bind Hit Low Health - Runs function when Health gets below 10%.
    return
end
function hpBar.onMiss() -- Fires when a miss has been added, no matter the 
    return
end
function hpBar.HealthChanged(newhealth) -- Health Changed.
    return
end

local function calculateHealth(Scale)
    return math.min(math.round((Scale*100) / 0.98), 100)
end

local firedSHealth = false
local firedNHealth = false

hpBar.Health:GetPropertyChangedSignal("Size"):Connect(
    function()
        -- Listen to Size
        -- After some research, ~0.98 scale is full, 0 is death.
        local h = calculateHealth(hpBar.Health.Size.X.Scale)
        hpBar.HealthChanged(h)
        if h == 0 then
           ShouldHaveDied = true; 
        end
        if h >= 85 then
            if not firedSHealth then
               hpBar.HitFHealth()
               firedNHealth = false
               firedSHealth = true
            end
        elseif h <= 15 then
            if not firedSHealth then
               hpBar.HitLHealth() -- HOW DID I MISS THIS
               firedNHealth = false
               firedSHealth = true
            end
        else
            if not firedNHealth then
                hpBar.HitNHealth()
                firedNHealth = true
                firedSHealth = false
            end
        end
    end
)


return hpBar
