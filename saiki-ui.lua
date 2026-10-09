-- Saiki Kusuo Powers - Full Version + Auto Regen + Tombol Gambar
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ===== KONFIGURASI =====
local IMAGE_URL = "https://i.imgur.com/xxxxx.png" -- Ganti dengan link gambar Saiki kamu
local WA_LINK = "https://whatsapp.com/channel/0029VbD8SsK4SpkJ9HjqBo1x"

local Settings = {
    TelekinesisPower = 200,
    FlightSpeed = 100,
    InvisibilityOpacity = 100,
    TimeStopRange = 500,
    PyrokinesisSize = 10,
    ElementPower = 50,
    AutoRegen = false,
    RegenAmount = 9,
}

-- ===== GUI UTAMA =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SaikiPowers"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- ===== TOMBOL BUKA UI (GAMBAR KOTAK) =====
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Size = UDim2.new(0, 60, 0, 60) -- Kotak
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -30)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
ToggleBtn.Image = IMAGE_URL
ToggleBtn.ScaleType = Enum.ScaleType.Crop
ToggleBtn.Parent = ScreenGui
local TBC = Instance.new("UICorner", ToggleBtn)
TBC.CornerRadius = UDim.new(0, 8) -- Sedikit melengkung di sudut, tapi tetap kotak

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 320)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 10, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
local MC = Instance.new("UICorner", MainFrame)
MC.CornerRadius = UDim.new(0, 12)

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 105, 180)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 50, 120)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 182, 193))
}
Gradient.Rotation = 45
Gradient.Parent = MainFrame

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 100, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(50, 15, 40)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
local SC = Instance.new("UICorner", Sidebar)
SC.CornerRadius = UDim.new(0, 12)

local SideTitle = Instance.new("TextLabel")
SideTitle.Size = UDim2.new(1, 0, 0, 40)
SideTitle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
SideTitle.Text = "SAIKI"
SideTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SideTitle.TextScaled = true
SideTitle.Font = Enum.Font.GothamBold
SideTitle.Parent = Sidebar
local STC = Instance.new("UICorner", SideTitle)
STC.CornerRadius = UDim.new(0, 12)

local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(1, -110, 0, 30)
SearchFrame.Position = UDim2.new(0, 105, 0, 5)
SearchFrame.BackgroundColor3 = Color3.fromRGB(60, 20, 50)
SearchFrame.BorderSizePixel = 0
SearchFrame.Parent = MainFrame
local SFC = Instance.new("UICorner", SearchFrame)
SFC.CornerRadius = UDim.new(0, 8)

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -20, 1, 0)
SearchBox.Position = UDim2.new(0, 10, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.PlaceholderText = "Cari fitur..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.PlaceholderColor3 = Color3.fromRGB(200, 150, 180)
SearchBox.TextScaled = true
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Parent = SearchFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -110, 1, -70)
ContentFrame.Position = UDim2.new(0, 105, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
ScrollingFrame.Parent = ContentFrame

local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, -110, 0, 25)
Footer.Position = UDim2.new(0, 105, 1, -25)
Footer.BackgroundTransparency = 1
Footer.Text = "WA: " .. WA_LINK
Footer.TextColor3 = Color3.fromRGB(255, 182, 193)
Footer.TextScaled = true
Footer.Font = Enum.Font.Gotham
Footer.TextXAlignment = Enum.TextXAlignment.Left
Footer.Parent = MainFrame

-- ===== FUNGSI =====
local allFeatures = {}

local function clearContent()
    for _, v in pairs(ScrollingFrame:GetChildren()) do v:Destroy() end
    allFeatures = {}
end

local function createToggle(name, yPos, default, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.95, 0, 0, 28)
    Btn.Position = UDim2.new(0.025, 0, 0, yPos)
    Btn.BackgroundColor3 = Color3.fromRGB(80, 20, 60)
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextScaled = true
    Btn.Font = Enum.Font.Gotham
    Btn.Parent = ScrollingFrame
    local c = Instance.new("UICorner", Btn)
    c.CornerRadius = UDim.new(0, 6)
    local state = default
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.BackgroundColor3 = state and Color3.fromRGB(255, 105, 180) or Color3.fromRGB(80, 20, 60)
        callback(state)
    end)
    if default then Btn.BackgroundColor3 = Color3.fromRGB(255, 105, 180) end
    table.insert(allFeatures, {name = name, button = Btn})
end

local function createSlider(name, yPos, min, max, default, callback)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.95, 0, 0, 20)
    Label.Position = UDim2.new(0.025, 0, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ScrollingFrame

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(0.9, 0, 0, 8)
    SliderBg.Position = UDim2.new(0.05, 0, 0, yPos + 22)
    SliderBg.BackgroundColor3 = Color3.fromRGB(50, 20, 40)
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = ScrollingFrame
    local SBC = Instance.new("UICorner", SliderBg)
    SBC.CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    Fill.BorderSizePixel = 0
    Fill.Parent = SliderBg
    local FillC = Instance.new("UICorner", Fill)
    FillC.CornerRadius = UDim.new(1, 0)

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 16, 0, 16)
    Btn.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Text = ""
    Btn.Parent = SliderBg
    local BC = Instance.new("UICorner", Btn)
    BC.CornerRadius = UDim.new(1, 0)

    local dragging = false

    Btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    Btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
            Fill.Size = UDim2.new(pos, 0, 1, 0)
            Btn.Position = UDim2.new(pos, -8, 0.5, -8)
            local val = math.floor(min + (max - min) * pos)
            Label.Text = name .. ": " .. val
            callback(val)
        end
    end)
    table.insert(allFeatures, {name = name, button = SliderBg, label = Label})
end

local regenConnection = nil
local lastHealth = nil

local function startAutoRegen()
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end
    lastHealth = humanoid.Health
    
    regenConnection = humanoid.HealthChanged:Connect(function(newHealth)
        if Settings.AutoRegen and lastHealth then
            local diff = lastHealth - newHealth
            if diff > 0 then
                local healAmount = math.min(diff - 1, Settings.RegenAmount)
                if healAmount > 0 then
                    humanoid.Health = math.min(humanoid.MaxHealth, newHealth + healAmount)
                end
            end
        end
        lastHealth = humanoid.Health
    end)
end

local function openPowers()
    clearContent()
    createToggle("TELEKINESIS", 5, false, function(v)
        if v and mouse.Target and mouse.Target:IsA("BasePart") then
            mouse.Target.Anchored = not mouse.Target.Anchored
        end
    end)
    createToggle("TELEPORT (Klik)", 40, false, function(v)
        if v and mouse.Hit then
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
            end
        end
    end)
    createToggle("PYROKINESIS", 75, false, function(v)
        if v and mouse.Target and mouse.Target:IsA("BasePart") then
            local fire = Instance.new("Fire")
            fire.Size = Settings.PyrokinesisSize
            fire.Parent = mouse.Target
            mouse.Target:BreakJoints()
        end
    end)
    createToggle("TIME STOP", 110, false, function(v)
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local h = plr.Character:FindFirstChild("Humanoid")
                if h then
                    h.WalkSpeed = v and 0 or 16
                    h.JumpPower = v and 0 or 50
                end
            end
        end
    end)
    createToggle("MIND READ", 145, false, function(v)
        if v then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local bb = Instance.new("BillboardGui")
                        bb.Size = UDim2.new(0, 150, 0, 40)
                        bb.StudsOffset = Vector3.new(0, 3, 0)
                        bb.Adornee = hrp
                        bb.Parent = hrp
                        local lbl = Instance.new("TextLabel")
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.BackgroundTransparency = 1
                        lbl.Text = plr.Name
                        lbl.TextColor3 = Color3.fromRGB(255, 105, 180)
                        lbl.TextScaled = true
                        lbl.Parent = bb
                    end
                end
            end
        end
    end)
    createToggle("X-RAY", 180, false, function(v)
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
                obj.LocalTransparencyModifier = v and 0.7 or 0
            end
        end
    end)
    createToggle("SUPER STRENGTH", 215, false, function(v)
        if v then
            local char = player.Character
            if char then
                local tool = Instance.new("Tool")
                tool.Name = "SaikiPunch"
                tool.RequiresHandle = false
                tool.Parent = player.Backpack
                tool.Activated:Connect(function()
                    if mouse.Target and mouse.Target.Parent then
                        local h = mouse.Target.Parent:FindFirstChild("Humanoid")
                        if h then h.Health = 0 end
                        mouse.Target:BreakJoints()
                    end
                end)
            end
        end
    end)
end

local function openElements()
    clearContent()
    local activeElement = nil
    
    local elements = {
        {name = "API", color = Color3.fromRGB(255, 69, 0)},
        {name = "AIR", color = Color3.fromRGB(0, 150, 255)},
        {name = "ANGIN", color = Color3.fromRGB(200, 255, 200)},
        {name = "TANAH", color = Color3.fromRGB(139, 69, 19)},
        {name = "LISTRIK", color = Color3.fromRGB(255, 255, 0)},
        {name = "BESI", color = Color3.fromRGB(150, 150, 150)},
    }
    
    for i, el in ipairs(elements) do
        createToggle(el.name, (i-1) * 35 + 5, false, function(v)
            if v then
                if activeElement then
                    activeElement:Destroy()
                end
                local char = player.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local attachment = Instance.new("Attachment", hrp)
                        local particle = Instance.new("ParticleEmitter", attachment)
                        particle.Texture = "rbxassetid://243098098"
                        particle.Color = ColorSequence.new(el.color)
                        particle.Size = NumberSequence.new(2)
                        particle.Transparency = NumberSequence.new(0.3)
                        particle.Lifetime = NumberRange.new(1, 2)
                        particle.Rate = 50
                        particle.Speed = NumberRange.new(5, 10)
                        particle.SpreadAngle = Vector2.new(180, 180)
                        activeElement = attachment
                    end
                end
            else
                if activeElement then
                    activeElement:Destroy()
                    activeElement = nil
                end
            end
        end)
    end
    
    createSlider("Kekuatan Elemen", 220, 10, 100, Settings.ElementPower, function(v)
        Settings.ElementPower = v
    end)
end

local function openSettings()
    clearContent()
    createToggle("INVISIBLE", 5, false, function(v)
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = v and (1 - (Settings.InvisibilityOpacity / 100)) or 0
                end
            end
        end
    end)
    createSlider("Opasitas Invisible (%)", 40, 0, 100, Settings.InvisibilityOpacity, function(v)
        Settings.InvisibilityOpacity = v
    end)
    createToggle("AUTO REGEN", 100, false, function(v)
        Settings.AutoRegen = v
        if v then
            startAutoRegen()
        else
            if regenConnection then
                regenConnection:Disconnect()
                regenConnection = nil
            end
        end
    end)
    createSlider("Jumlah Regen (HP)", 140, 1, 50, Settings.RegenAmount, function(v)
        Settings.RegenAmount = v
    end)
end

local function openFlight()
    clearContent()
    local flying = false
    local bodyVel
    local bodyGyro
    
    createToggle("FLIGHT", 5, false, function(v)
        flying = v
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if flying then
            bodyVel = Instance.new("BodyVelocity", hrp)
            bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyVel.Velocity = Vector3.new(0, 0, 0)
            bodyGyro = Instance.new("BodyGyro", hrp)
            bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bodyGyro.P = 1000
            bodyGyro.D = 50
            RunService.RenderStepped:Connect(function()
                if flying and bodyVel and bodyGyro then
                    local cam = workspace.CurrentCamera
                    bodyVel.Velocity = cam.CFrame.lookVector * Settings.FlightSpeed
                    bodyGyro.CFrame = cam.CFrame
                end
            end)
        else
            if bodyVel then bodyVel:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
        end
    end)
    createSlider("Kecepatan Terbang", 40, 10, 500, Settings.FlightSpeed, function(v)
        Settings.FlightSpeed = v
    end)
end

local function createSideButton(name, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(80, 20, 60)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = Sidebar
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
end

createSideButton("Powers", 50, openPowers)
createSideButton("Elemen", 90, openElements)
createSideButton("Settings", 130, openSettings)
createSideButton("Flight", 170, openFlight)

openPowers()

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(SearchBox.Text)
    for _, f in ipairs(allFeatures) do
        if query == "" then
            f.button.Visible = true
            if f.label then f.label.Visible = true end
        else
            local visible = string.find(string.lower(f.name), query) ~= nil
            f.button.Visible = visible
            if f.label then f.label.Visible = visible end
        end
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame
local CC = Instance.new("UICorner", CloseBtn)
CC.CornerRadius = UDim.new(0, 12)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)