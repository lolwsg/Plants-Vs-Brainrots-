local plr = game.Players.LocalPlayer
local key = "XARVOK"
local discord = "https://discord.gg/HmYAMqxmcC"
local webhook = "https://discord.com/api/webhooks/1424171260879044680/yRQZ4h_f3SsKJT7mawaQqwqc_XrLgS516Qy5H5JMmo64vj0S9vnEhfit0RuAJasRw5xL"
local attempts = 0
local lastTry = 0

local gui = Instance.new("ScreenGui")
gui.Name = "KeyGUI"
gui.Parent = game.CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 350, 0, 200)
main.Position = UDim2.new(0.5, -175, 0.5, -100)
main.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
main.BorderSizePixel = 2
main.BorderColor3 = Color3.new(0.2, 0.2, 0.2)
main.Active = true
main.Draggable = true
main.Parent = gui

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
header.BorderSizePixel = 0
header.Text = "key system"
header.TextColor3 = Color3.new(1, 1, 1)
header.TextSize = 16
header.Font = Enum.Font.Code
header.Parent = main

local input = Instance.new("TextBox")
input.Size = UDim2.new(0, 300, 0, 35)
input.Position = UDim2.new(0, 25, 0, 55)
input.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
input.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
input.PlaceholderText = "enter key"
input.Text = ""
input.TextColor3 = Color3.new(1, 1, 1)
input.TextSize = 14
input.Font = Enum.Font.Code
input.Parent = main

local submit = Instance.new("TextButton")
submit.Size = UDim2.new(0, 300, 0, 35)
submit.Position = UDim2.new(0, 25, 0, 100)
submit.BackgroundColor3 = Color3.new(0.2, 0.4, 0.8)
submit.BorderSizePixel = 0
submit.Text = "submit"
submit.TextColor3 = Color3.new(1, 1, 1)
submit.TextSize = 14
submit.Font = Enum.Font.Code
submit.Parent = main

local disc = Instance.new("TextButton")
disc.Size = UDim2.new(0, 300, 0, 30)
disc.Position = UDim2.new(0, 25, 0, 145)
disc.BackgroundColor3 = Color3.new(0.35, 0.4, 0.95)
disc.BorderSizePixel = 0
disc.Text = "get key (discord)"
disc.TextColor3 = Color3.new(1, 1, 1)
disc.TextSize = 12
disc.Font = Enum.Font.Code
disc.Parent = main

local function sendWebhook(username, userid, gameName)
    local data = {
        ["embeds"] = {{
            ["title"] = "script executed",
            ["color"] = 2895667,
            ["fields"] = {
                {["name"] = "User", ["value"] = username, ["inline"] = true},
                {["name"] = "UserID", ["value"] = tostring(userid), ["inline"] = true},
                {["name"] = "Game", ["value"] = gameName, ["inline"] = false}
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S")
        }}
    }
    
    local jsonData = game:GetService("HttpService"):JSONEncode(data)
    
    local success, err = pcall(function()
        syn.request({
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = jsonData
        })
    end)
    
    if not success then
        pcall(function()
            http_request({
                Url = webhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonData
            })
        end)
    end
end

local function check(k)
    if tick() - lastTry < 60 and attempts >= 3 then
        return false, "wait before trying again"
    end
    
    if tick() - lastTry >= 60 then
        attempts = 0
    end
    
    attempts = attempts + 1
    lastTry = tick()
    
    k = string.upper(k:gsub("%s", ""))
    
    if k == key then
        return true, "correct"
    else
        return false, "wrong key"
    end
end

submit.MouseButton1Click:Connect(function()
    local txt = input.Text
    if txt == "" then return end
    
    local ok, msg = check(txt)
    
    if ok then
        submit.Visible = false
        disc.Visible = false
        input.Visible = false
        
        header.Text = "verifying key..."
        header.BackgroundColor3 = Color3.new(0.8, 0.6, 0.2)
        wait(0.2)
        
        header.Text = "checking hwid..."
        wait(0.15)
        
        header.Text = "validating user..."
        wait(0.15)
        
        header.Text = "loading whitelist..."
        wait(0.2)
        
        header.Text = "injecting scripts..."
        sendWebhook(
            plr.Name,
            plr.UserId,
            game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        )
        wait(0.2)
        
        header.Text = "initializing functions..."
        wait(0.2)
        
        header.Text = "access granted"
        header.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
        wait(0.4)
        
        header.Text = "welcome " .. plr.Name
        wait(0.6)
        
        main.Visible = false
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/mynamewendel-ctrl/Blessed-Hub-X-/refs/heads/main/Plants-Vs-Brainrots.lua"))()
        
    else
        header.Text = msg
        header.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
        wait(1.5)
        header.Text = "key system"
        header.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        input.Text = ""
    end
end)

disc.MouseButton1Click:Connect(function()
    setclipboard(discord)
    disc.Text = "copied to clipboard"
    wait(1)
    disc.Text = "get key (discord)"
end)

input.FocusLost:Connect(function(enter)
    if enter then
        submit.MouseButton1Click:Fire()
    end
end)
