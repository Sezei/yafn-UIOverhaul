local s,f = pcall(function()
    local TweenService = game:GetService("TweenService")
local plr = game:GetService("Players").LocalPlayer
local ui = plr.PlayerGui:FindFirstChild("GameUI")
local scorelabel = ui.ScoreLabel
local real = ui.realGameUI
local NewUI = Instance.new("ScreenGui")
NewUI.Parent = plr.PlayerGui
NewUI.ResetOnSpawn = false
local Frame = Instance.new("Frame")
Frame.Parent = NewUI
Frame.AnchorPoint = Vector2.new(0, 1)
Frame.Position = UDim2.new(0, 0, 1, -95)
Frame.BackgroundTransparency = 1
local Score_TextLabel = Instance.new("TextLabel")
local Score = Instance.new("TextLabel")
local Accuracy = Instance.new("TextLabel")
local Misses = Instance.new("TextLabel")
local Rating = Instance.new("TextLabel")
local RatingB = Instance.new("TextLabel")
local Combo = Instance.new("TextLabel")

local SicksLabel = Instance.new("TextLabel")
local Sicks = 0

local GoodsLabel = Instance.new("TextLabel")
local Goods = 0

local BadsLabel = Instance.new("TextLabel")
local Bads = 0

local highestCombo = 0
local LastMisses = 0
local totalNotes = 0
local ShouldHaveDied = false;

--local storage for the Tweening (v1A)
local sVal = Instance.new("NumberValue")
local colorP = Instance.new("Color3Value")
local colorS = Instance.new("Color3Value")
local colorA = Instance.new("Color3Value")
local colorB = Instance.new("Color3Value")
local colorC = Instance.new("Color3Value")
local colorD = Instance.new("Color3Value")

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

local ret = {ui = NewUI, hp = hpBar, settings = {tweenScore = true}}

do
    Score_TextLabel.Parent = Frame
    Score_TextLabel.Name = "Score_TextLabel"
    Score_TextLabel.Text = "Score"
    Score_TextLabel.Position = UDim2.new(0, 20, 0, 0)
    Score_TextLabel.BackgroundTransparency = 1
    Score_TextLabel.TextSize = 32
    Score_TextLabel.Font = Enum.Font.Ubuntu
    Score_TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    Score_TextLabel.TextColor3 = Color3.new(1, 1, 1)
    Score_TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    Score_TextLabel.TextStrokeTransparency = 0
    Score_TextLabel.Size = UDim2.new(0, 200, 0, 32)
    --
    Score.Parent = Frame
    Score.Name = "Score"
    Score.Text = "---"
    Score.Position = UDim2.new(0, 20, 0, 38)
    Score.BackgroundTransparency = 1
    Score.TextSize = 42
    Score.Font = Enum.Font.Ubuntu
    Score.TextXAlignment = Enum.TextXAlignment.Left
    Score.TextColor3 = Color3.new(1, 1, 1)
    Score.TextStrokeColor3 = Color3.new(0, 0, 0)
    Score.TextStrokeTransparency = 0
    Score.Size = UDim2.new(0, 200, 0, 32)
    --
    Accuracy.Parent = Frame
    Accuracy.Name = "Accuracy"
    Accuracy.Text = "Accuracy : ---%"
    Accuracy.Position = UDim2.new(0, 80, 0, -30)
    Accuracy.BackgroundTransparency = 1
    Accuracy.TextSize = 24
    Accuracy.Font = Enum.Font.Ubuntu
    Accuracy.TextXAlignment = Enum.TextXAlignment.Left
    Accuracy.TextColor3 = Color3.new(1, 1, 1)
    Accuracy.TextStrokeColor3 = Color3.new(0, 0, 0)
    Accuracy.TextStrokeTransparency = 0.5
    Accuracy.Size = UDim2.new(0, 200, 0, 32)
    --
    Misses.Parent = Frame
    Misses.Name = "Misses"
    Misses.Text = "Combo Breaks : 0"
    Misses.Position = UDim2.new(0, 80, 0, -60)
    Misses.BackgroundTransparency = 1
    Misses.TextSize = 24
    Misses.Font = Enum.Font.Ubuntu
    Misses.TextXAlignment = Enum.TextXAlignment.Left
    Misses.TextColor3 = Color3.new(1, 1, 1)
    Misses.TextStrokeColor3 = Color3.new(0, 0, 0)
    Misses.TextStrokeTransparency = 0.5
    Misses.Size = UDim2.new(0, 200, 0, 32)
    --
    Rating.Parent = Frame
    Rating.Name = "Rating"
    Rating.Text = "-"
    Rating.Position = UDim2.new(0, 20, 0, -50)
    Rating.BackgroundTransparency = 1
    Rating.TextSize = 64
    Rating.Font = Enum.Font.GothamBlack
    Rating.TextColor3 = Color3.new(1, 1, 1)
    Rating.TextStrokeColor3 = Color3.new(0, 0, 0)
    Rating.TextStrokeTransparency = 0.3
    Rating.Size = UDim2.new(0, 50, 0, 50)
    Rating.TextYAlignment = Enum.TextYAlignment.Bottom
    --
    RatingB.Parent = Frame
    RatingB.Name = "RatingB"
    RatingB.Text = "(---)"
    RatingB.Position = UDim2.new(0, 20, 0, -19)
    RatingB.BackgroundTransparency = 1
    RatingB.TextSize = 16
    RatingB.Font = Enum.Font.GothamSemibold
    RatingB.TextColor3 = Color3.new(1, 1, 1)
    RatingB.TextStrokeColor3 = Color3.new(0, 0, 0)
    RatingB.TextStrokeTransparency = 0.3
    RatingB.Size = UDim2.new(0, 50, 0, 19)
    RatingB.TextYAlignment = Enum.TextYAlignment.Bottom
    -- Combo stuff
    Combo.Parent = Frame
    Combo.Name = "Combo"
    Combo.Text = "Combo : --- (---)"
    Combo.Position = UDim2.new(0, 20, 0, -80)
    Combo.BackgroundTransparency = 1
    Combo.TextSize = 24
    Combo.Font = Enum.Font.Ubuntu
    Combo.TextXAlignment = Enum.TextXAlignment.Left
    Combo.TextColor3 = Color3.new(1, 1, 1)
    Combo.TextStrokeColor3 = Color3.new(0, 0, 0)
    Combo.TextStrokeTransparency = 0
    Combo.Size = UDim2.new(0, 200, 0, 32)
    -- heh
    Combo.Parent = Frame
    Combo.Name = "Combo"
    Combo.Text = "Combo : --- (---)"
    Combo.Position = UDim2.new(0, 20, 0, -85)
    Combo.BackgroundTransparency = 1
    Combo.TextSize = 24
    Combo.Font = Enum.Font.Ubuntu
    Combo.TextXAlignment = Enum.TextXAlignment.Left
    Combo.TextColor3 = Color3.new(1, 1, 1)
    Combo.TextStrokeColor3 = Color3.new(0, 0, 0)
    Combo.TextStrokeTransparency = 0.5
    Combo.Size = UDim2.new(0, 200, 0, 32)
    --
    SicksLabel.Parent = Frame
    SicksLabel.Name = "SicksLabel"
    SicksLabel.Text = "Sicks : ---"
    SicksLabel.Position = UDim2.new(0, 20, 0, -105)
    SicksLabel.BackgroundTransparency = 1
    SicksLabel.TextSize = 16
    SicksLabel.Font = Enum.Font.Ubuntu
    SicksLabel.TextXAlignment = Enum.TextXAlignment.Left
    SicksLabel.TextColor3 = Color3.new(1, 1, 1)
    SicksLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    SicksLabel.TextStrokeTransparency = 0.7
    SicksLabel.Size = UDim2.new(0, 200, 0, 32)
    --
    GoodsLabel.Parent = Frame
    GoodsLabel.Name = "GoodsLabel"
    GoodsLabel.Text = "Goods : ---"
    GoodsLabel.Position = UDim2.new(0, 20, 0, -120)
    GoodsLabel.BackgroundTransparency = 1
    GoodsLabel.TextSize = 16
    GoodsLabel.Font = Enum.Font.Ubuntu
    GoodsLabel.TextXAlignment = Enum.TextXAlignment.Left
    GoodsLabel.TextColor3 = Color3.new(1, 1, 1)
    GoodsLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    GoodsLabel.TextStrokeTransparency = 0.7
    GoodsLabel.Size = UDim2.new(0, 200, 0, 32)
    --
    BadsLabel.Parent = Frame
    BadsLabel.Name = "BadsLabel"
    BadsLabel.Text = "Bads : ---"
    BadsLabel.Position = UDim2.new(0, 20, 0, -135)
    BadsLabel.BackgroundTransparency = 1
    BadsLabel.TextSize = 16
    BadsLabel.Font = Enum.Font.Ubuntu
    BadsLabel.TextXAlignment = Enum.TextXAlignment.Left
    BadsLabel.TextColor3 = Color3.new(1, 1, 1)
    BadsLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    BadsLabel.TextStrokeTransparency = 0.7
    BadsLabel.Size = UDim2.new(0, 200, 0, 32)
    -- VERSION 1A STUFF
    sVal.Value = 0
    colorP.Value = Color3.new(0, 0.666667, 1)
    colorS.Value = Color3.new(1, 1, 0.498039)
    colorA.Value = Color3.new(1, 0.666667, 0)
    colorB.Value = Color3.new(1, 0.466667, 0)
    colorC.Value = Color3.new(1, 0.231373, 0)
    colorD.Value = Color3.new(0.65098, 0.65098, 0.65098)
end

local function calculateRating(acc, miss)
    local acc = tonumber(string.sub(acc, 1, -2))
    local miss = tonumber(miss)
    local avoidAddition = false;

    --RatingB
    if not ShouldHaveDied then
        if miss == 0 then
            RatingB.Text = "(FC)"
        elseif miss < 10 then
            RatingB.Text = "(SDCB)"
        else
            RatingB.Text = "(Clear)"
        end
    else -- Run is Invalid due to dying.
        RatingB.Text = "(Invalid)"
    end
    
    if acc == 100 then
        Rating.Text = "P"
        Rating.TextColor3 = colorP.Value
        avoidAddition = true
    elseif acc >= 95 then
        Rating.Text = "S"
        Rating.TextColor3 = colorS.Value
    elseif acc >= 90 then
        Rating.Text = "A"
        Rating.TextColor3 = colorA.Value
    elseif acc >= 85 then
        Rating.Text = "B"
        Rating.TextColor3 = colorB.Value
    elseif acc >= 75 then
        Rating.Text = "C"
        Rating.TextColor3 = colorC.Value
    elseif acc == 0 and sVal.Value == 0 and miss == 0 then
        Rating.Text = "-"
        Rating.TextColor3 = Color3.new(1, 1, 1)
        avoidAddition = true
    else
        Rating.Text = "D"
        Rating.TextColor3 = colorD.Value
    end
    
    if not avoidAddition then
        if miss == 0 then
            Rating.Text = Rating.Text.."+"
        elseif miss >= 50 then
            Rating.Text = Rating.Text.."-"
        end
    end
end

local function clearHighestCombo()
    firedSHealth = false
    firedNHealth = false
    highestCombo = 0
    LastMisses = 0
    Sicks = 0
    Goods = 0
    Bads = 0
    totalNotes = 0
    ShouldHaveDied = false;
end

local function getAccuracy()
    local weights = { Sick = 100, Good = 80, Bad = 40} -- In-game it's 0.5 for bad and 0.1 for awful so i estimated it to be 0.4
    local total = totalNotes * 100
    local calc = (Sicks * weights.Sick + Goods * weights.Good + Bads * weights.Bad)/total
    local returning = tonumber(string.sub(tostring(calc),1,5)) -- 100% or 99.99%
    return returning
end

local function getLastRating(diff)
  if diff == 380 then
    Sicks = Sicks + 1
  elseif diff == 150 then
    Goods = Goods + 1
  elseif diff == 0 then
    Bads = Bads + 1
  end
end

local prevScore = 0;

local function tweenScore(newscore)
    getLastRating(newscore-prevScore)
    if ret.settings.tweenScore == true then
        if newscore == 0 then
            clearHighestCombo()
            sVal.Value = 0
        else
            newscore = newscore / 10
            TweenService:Create(
                sVal,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Value = newscore}
            ):Play()
        end
    else
        sVal.Value = newscore
    end
end

sVal:GetPropertyChangedSignal("Value"):Connect(
    function()
        Score.Text = tostring(math.round(sVal.Value) * 10)
    end
)

scorelabel:GetPropertyChangedSignal("Text"):Connect(
    function()
        -- "Score: 999999 | Combo: 999 | Misses: 9 | Accuracy: 99%"
        --  1	   2	  3 4	   5   6 7       8 9 10        11
        totalNotes = totalNotes+1
        local st = string.split(scorelabel.Text, " ")
        highestCombo = math.max( tonumber(st[5]) , highestCombo )   
        print("Getting ScoreTween")
        tweenScore(tonumber(st[2]))
        print("ScoreTween Sent")
        Accuracy.Text = "Accuracy : " .. getAccuracy()
        print("Accuracy Set")
        Misses.Text = "Combo Breaks : " .. st[8]
        print("CB Set")
        Combo.Text = "Combo : "..st[5].." ("..tostring(highestCombo)..")"
        print("Combo Set")
        SicksLabel.Text = "Sicks : "..Sicks
        GoodsLabel.Text = "Goods : "..Goods
        BadsLabel.Text = "Bads : "..Bads
        if tonumber(st[8]) > LastMisses then
            LastMisses = tonumber(st[8])
            hpBar.onMiss()
        end
        calculateRating(st[11], st[8])
    end
)

scorelabel.Visible = false

function ret.SetRatingColor(rating, color)
    if not rating or not color then
        return
    end
    if rating == "P" then
        colorP.Value = color
    elseif rating == "S" then
        colorS.Value = color
    elseif rating == "A" then
        colorA.Value = color
    elseif rating == "B" then
        colorB.Value = color
    elseif rating == "C" then
        colorC.Value = color
    elseif rating == "D" then
        colorD.Value = color
    end
end

function ret.GetRatingColor(rating)
    if not rating then
        return nil
    end
    if rating == "P" then
        return colorP.Value
    elseif rating == "S" then
        return colorS.Value
    elseif rating == "A" then
        return colorA.Value
    elseif rating == "B" then
        return colorB.Value
    elseif rating == "C" then
        return colorC.Value
    elseif rating == "D" then
        return colorD.Value
    end
end

return ret

end) if not s then warn(f) end
