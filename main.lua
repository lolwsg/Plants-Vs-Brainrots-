local plr = game.Players.LocalPlayer
local discord = "https://discord.gg/HmYAMqxmcC"
local webhook = "https://discord.com/api/webhooks/1424171260879044680/yRQZ4h_f3SsKJT7mawaQqwqc_XrLgS516Qy5H5JMmo64vj0S9vnEhfit0RuAJasRw5xL"

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
    
    pcall(function()
        request({
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = jsonData
        })
    end)
end

sendWebhook(
    plr.Name,
    plr.UserId,
    game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
)

local gui = Instance.new("ScreenGui")
gui.Name = "WelcomeGUI"
gui.Parent = gethui() or game:GetService("CoreGui") or plr:WaitForChild("PlayerGui")

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
header.Size = UDim2.new(1, 0, 0, 25)
header.Position = UDim2.new(0, 0, 0, 10)
header.BackgroundTransparency = 1
header.Text = "join our discord (optional)"
header.TextColor3 = Color3.new(0.8, 0.8, 0.8)
header.TextSize = 13
header.Font = Enum.Font.Code
header.Parent = main

local disc = Instance.new("TextButton")
disc.Size = UDim2.new(0, 280, 0, 40)
disc.Position = UDim2.new(0, 35, 0, 45)
disc.BackgroundColor3 = Color3.new(0.35, 0.4, 0.95)
disc.BorderSizePixel = 0
disc.Text = "discord"
disc.TextColor3 = Color3.new(1, 1, 1)
disc.TextSize = 16
disc.Font = Enum.Font.Code
disc.Parent = main

local skip = Instance.new("TextButton")
skip.Size = UDim2.new(0, 70, 0, 25)
skip.Position = UDim2.new(0, 140, 0, 100)
skip.BackgroundColor3 = Color3.new(0.2, 0.4, 0.8)
skip.BorderSizePixel = 0
skip.Text = "skip"
skip.TextColor3 = Color3.new(1, 1, 1)
skip.TextSize = 12
skip.Font = Enum.Font.Code
skip.Parent = main

local blessed = Instance.new("TextLabel")
blessed.Size = UDim2.new(1, 0, 0, 50)
blessed.Position = UDim2.new(0, 0, 0, 50)
blessed.BackgroundTransparency = 1
blessed.Text = "have a blessed day"
blessed.TextColor3 = Color3.new(1, 1, 1)
blessed.TextSize = 22
blessed.Font = Enum.Font.Code
blessed.Visible = false
blessed.Parent = main

local loading = Instance.new("TextLabel")
loading.Size = UDim2.new(1, 0, 0, 30)
loading.Position = UDim2.new(0, 0, 0, 110)
loading.BackgroundTransparency = 1
loading.Text = "loading script..."
loading.TextColor3 = Color3.new(0.6, 0.6, 0.6)
loading.TextSize = 12
loading.Font = Enum.Font.Code
loading.Visible = false
loading.Parent = main

disc.MouseButton1Click:Connect(function()
    setclipboard(discord)
    disc.Text = "copied to clipboard"
    wait(1)
    disc.Text = "discord"
end)

skip.MouseButton1Click:Connect(function()
    skip.Visible = false
    disc.Visible = false
    header.Visible = false
    blessed.Visible = true
    loading.Visible = true
    wait(1.5)
    main.Visible = false
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/mynamewendel-ctrl/Blessed-Hub-X-/refs/heads/main/Plants-Vs-Brainrots.lua"))()
end)
