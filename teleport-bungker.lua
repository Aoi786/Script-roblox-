-- Membuat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MinimizeBtn = Instance.new("TextButton")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- Konfigurasi ScreenGui
ScreenGui.Name = "BungkerTeleportGUI"
ScreenGui.Parent = game.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Konfigurasi MainFrame (Latar belakang emas & ukuran compact)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- Warna Emas
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true -- Membuat menu bisa digeser

-- Konfigurasi TopBar
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(218, 165, 32) -- Warna Emas Gelap
TopBar.Size = UDim2.new(1, 0, 0, 30)

-- Konfigurasi Judul
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "BUNGKER"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Konfigurasi Tombol Minimize ("-")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = TopBar
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Position = UDim2.new(0.8, 0, 0, 0)
MinimizeBtn.Size = UDim2.new(0.2, 0, 1, 0)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeBtn.TextSize = 24

-- Konfigurasi ScrollingFrame (Untuk menu scroll)
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Parent = MainFrame
ScrollFrame.Active = true
ScrollFrame.BackgroundColor3 = Color3.fromRGB(255, 223, 0)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.Position = UDim2.new(0, 0, 0, 30)
ScrollFrame.Size = UDim2.new(1, 0, 1, -30)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 320) -- Sesuaikan jika tombol bertambah
ScrollFrame.ScrollBarThickness = 5

-- Konfigurasi Layout Daftar Tombol
UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Fungsi Minimize/Maximize
local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 200, 0, 30)
        ScrollFrame.Visible = false
        MinimizeBtn.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 200, 0, 250)
        ScrollFrame.Visible = true
        MinimizeBtn.Text = "-"
    end
end)

-- Fungsi Membuat Tombol Teleport
local function CreateTPButton(name, targetPath)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = ScrollFrame
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextSize = 14
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                -- Mengambil lokasi dari targetPath
                local target = targetPath()
                if target then
                    player.Character.HumanoidRootPart.CFrame = target.CFrame
                end
            end)
        end
    end)
end

-- Mendaftar Lokasi Teleport (Note: angka pada path direferensikan menggunakan kurung siku ["1"])
CreateTPButton("1. Teleport ke Labu", function()
    return game:GetService("Workspace"):FindFirstChild("AirDROP") and game.Workspace.AirDROP:FindFirstChild("Cube")
end)

CreateTPButton("2. Teleport ke Rumah", function()
    return game:GetService("Workspace"):FindFirstChild("Bunkers") and game.Workspace.Bunkers:FindFirstChild("8693354055_Bunker") and game.Workspace.Bunkers["8693354055_Bunker"]:FindFirstChild("Stairs") and game.Workspace.Bunkers["8693354055_Bunker"].Stairs:FindFirstChild("Part")
end)

CreateTPButton("3. Teleport ke GL", function()
    return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.WallDecor2["1"]
end)

CreateTPButton("4. Teleport ke Salon", function()
    return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.BTScreen["2"]
end)

CreateTPButton("5. Teleport ke Marmer", function()
    return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.KitchenIsland1["2"]
end)

CreateTPButton("6. Teleport ke Lemari", function()
    return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.Shelf2["1"]
end)

CreateTPButton("7. Teleport ke Lampu", function()
    return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.Lamp4["2"]
end)

CreateTPButton("8. Teleport ke Meja", function()
    return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.Table2["2"]
end)

CreateTPButton("9. Teleport ke Toilet", function()
    return game:GetService("Workspace").Wyposazenie.MarketWyposazenie.WashingMachine1["1"]
end)
