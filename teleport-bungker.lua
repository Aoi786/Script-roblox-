local player = game.Players.LocalPlayer
local coreGui = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or player:WaitForChild("PlayerGui")

-- Membuat ScreenGui Utama
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BunkerTeleportGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = coreGui

-- Main Frame (Menu)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 160, 0, 220)
mainFrame.Position = UDim2.new(0.8, 0, 0.4, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(218, 165, 32) -- Warna Emas
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Top Bar (Header)
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 25)
topBar.BackgroundColor3 = Color3.fromRGB(184, 134, 11) -- Emas Gelap
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 1, 0)
title.Position = UDim2.new(0, 5, 0, 0)
title.BackgroundTransparency = 1
title.Text = "BUNGKER"
title.Font = Enum.Font.Code
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 1, 0)
minimizeBtn.Position = UDim2.new(1, -30, 0, 0)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.Code
minimizeBtn.TextSize = 18
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Parent = topBar

-- Scrolling Frame (Wadah Tombol)
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -25)
scrollFrame.Position = UDim2.new(0, 0, 0, 25)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 3
scrollFrame.Parent = mainFrame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = scrollFrame
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 3)

local uiPadding = Instance.new("UIPadding")
uiPadding.Parent = scrollFrame
uiPadding.PaddingTop = UDim.new(0, 4)
uiPadding.PaddingBottom = UDim.new(0, 4)
uiPadding.PaddingLeft = UDim.new(0, 4)
uiPadding.PaddingRight = UDim.new(0, 4)

-- Logika Teleportasi
local function teleportTo(partFunction)
    local success, targetPart = pcall(partFunction)
    if success and targetPart and targetPart:IsA("BasePart") then
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
end

-- Daftar Lokasi
local locations = {
    {name = "0 Labu",   func = function() return game:GetService("Workspace").AirDROP.Cube end},
    {name = "1 Rumah",  func = function() return game:GetService("Workspace").Bunkers["8693354055_Bunker"].Stairs.Part end},
    {name = "2 GL",     func = function() return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.WallDecor2["1"] end},
    {name = "3 Salon",  func = function() return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.BTScreen["2"] end},
    {name = "4 Marmer", func = function() return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.KitchenIsland1["2"] end},
    {name = "5 Lemari", func = function() return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.Shelf2["1"] end},
    {name = "6 Lampu",  func = function() return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.Lamp4["2"] end},
    {name = "7 Meja",   func = function() return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.Table2["2"] end},
    {name = "8 Toilet", func = function() return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.WashingMachine1["1"] end}
}

-- Membuat Tombol
for _, loc in ipairs(locations) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 22)
    btn.BackgroundColor3 = Color3.fromRGB(255, 235, 150)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(150, 120, 0)
    btn.Text = loc.name
    btn.Font = Enum.Font.Code
    btn.TextSize = 12
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Parent = scrollFrame
    
    btn.MouseButton1Click:Connect(function()
        teleportTo(loc.func)
    end)
end

-- Menyesuaikan ukuran scroll area otomatis
uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + 8)
end)

-- Logika Minimize
local isMinimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame.Size = UDim2.new(0, 160, 0, 25)
        scrollFrame.Visible = false
        minimizeBtn.Text = "+"
