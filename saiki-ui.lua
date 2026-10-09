-- Saiki Kusuo Powers - Full Version with Settings
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ===== KONFIGURASI =====
local IMAGE_URL = https://imgur.com/a/isADRGw -- 
local WA_LINK = https://whatsapp.com/channel/0029VbD8SsK4SpkJ9HjqBo1x

-- ===== VARIABEL SETTINGS =====
local Settings = {
    TelekinesisPower = 200,
    FlightSpeed = 100,
    InvisibilityOpacity = 100,
    TimeStopRange = 500,
    PyrokinesisSize = 10,
    SuperStrengthEnabled = true,
}

-- ===== GUI UTAMA =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SaikiPowers"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 420)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
local MC = Instance.new("UICorner", MainFrame)
MC.CornerRadius = UDim.new(0, 12)

-- ===== SIDEBAR =====
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
local SC = Instance.new("UICorner", Sidebar)
SC.CornerRadius = UDim.new(0, 12)

local SideTitle = Instance.new("TextLabel")
SideTitle.Size = UDim2.new(1, 0, 0, 50)
SideTitle.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
SideTitle.Text = "SAIKI KUSUO"
SideTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SideTitle.TextScaled = true
SideTitle.Font = Enum.Font.GothamBold
SideTitle.Parent = Sidebar
local STC = Instance.new("UICorner", SideTitle)
STC.CornerRadius = UDim.new(0, 12)

-- ===== KONTEN =====
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -140, 1, -30)
ContentFrame.Position = UDim2.new(0, 140, 0, 0)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- ===== FOOTER (WhatsApp) =====
local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Footer.BorderSizePixel = 0
Footer.Parent = MainFrame
local FC = Instance.new("UICorner", Footer)
FC.CornerRadius = UDim.new(0, 12)

local FooterText = Instance.new("TextLabel")
FooterText.Size = UDim2.new(1, 0, 1, 0)
FooterText.BackgroundTransparency = 1
FooterText.Text = "get more script on " .. WA_LINK
FooterText.TextColor3 = Color3.fromRGB(0, 255, 150)
FooterText.TextScaled = true
FooterText.Font = Enum.Font.Gotham
FooterText.Parent = Footer

-- ===== FUNGSI GANTI TAB =====
local currentTab = nil
local function clearContent()
    for _, v in pairs(ContentFrame:GetChildren()) do
        v:Destroy()
    end
end

local function createSideButton(name, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = Sidebar
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
end

-- ===== FUNGSI BUAT SLIDER =====
local function createSlider(parent, name, yPos, min, max, default, callback)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 25)
    Label.Position = UDim2.new(0, 10, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = parent

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(1, -20, 0, 8)
    SliderBg.Position = UDim2.new(0, 10, 0, yPos + 28)
    SliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = parent
    local SBC = Instance.new("UICorner", SliderBg)
    SBC.CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
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
end

-- ===== FUNGSI BUAT TOGGLE =====
local function createToggle(parent, name, yPos, default, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 30)
    Btn.Position = UDim2.new(0.05, 0, 0, yPos)
    Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextScaled = true
    Btn.Font = Enum.Font.Gotham
    Btn.Parent = parent
    local c = Instance.new("UICorner", Btn)
    c.CornerRadius = UDim.new(0, 6)
    local state = default
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.BackgroundColor3 = state and Color3.fromRGB(120, 0, 200) or Color3.fromRGB(60, 60, 100)
        callback(state)
    end)
    if default then Btn.BackgroundColor3 = Color3.fromRGB(120, 0, 200) end
end

-- ===== TAB 1: POWERS =====
local function openPowers()
    clearContent()
    local telekinesisActive = false
    local selectedObject = nil

    createToggle(ContentFrame, "TELEKINESIS", 10, false, function(v)
        telekinesisActive = v
        if v then mouse.TargetFilter = player.Character end
    end)

    mouse.Button1Down:Connect(function()
        if telekinesisActive and mouse.Target then
            selectedObject = mouse.Target
            if selectedObject and selectedObject:IsA("BasePart") and not selectedObject.Anchored then
                selectedObject.Anchored = true
                local bp = Instance.new("BodyPosition", selectedObject)
                bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bp.Position = mouse.Hit.Position + Vector3.new(0, 5, 0)
            end
        end
    end)
    mouse.Button1Up:Connect(function()
        if selectedObject then
            for _, v in pairs(selectedObject:GetChildren()) do
                if v:IsA("BodyPosition") then v:Destroy() end
            end
            selectedObject.Anchored = false
            selectedObject.Velocity = mouse.Hit.lookVector * Settings.TelekinesisPower
            selectedObject = nil
        end
    end)

    createToggle(ContentFrame, "TELEPORT (Shift + Klik)", 50, false, function(v) end)
    UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.LeftShift and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp and mouse.Hit then
                hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
            end
        end
    end)

    createToggle(ContentFrame, "PYROKINESIS", 90, false, function(v)
        if v and mouse.Target and mouse.Target:IsA("BasePart") then
            local fire = Instance.new("Fire")
            fire.Size = Settings.PyrokinesisSize
            fire.Heat = 50
            fire.Parent = mouse.Target
            mouse.Target:BreakJoints()
        end
    end)

    createToggle(ContentFrame, "TIME STOP", 130, false, function(v)
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

    createToggle(ContentFrame, "MIND READ", 170, false, function(v)
        if v then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local bb = Instance.new("BillboardGui")
                        bb.Size = UDim2.new(0, 200, 0, 50)
                        bb.StudsOffset = Vector3.new(0, 3, 0)
                        bb.Adornee = hrp
                        bb.Parent = hrp
                        local lbl = Instance.new("TextLabel")
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.BackgroundTransparency = 1
                        lbl.Text = plr.Name .. " | " .. math.floor(hrp.Position.X) .. "," .. math.floor(hrp.Position.Y) .. "," .. math.floor(hrp.Position.Z)
                        lbl.TextColor3 = Color3.fromRGB(0, 255, 255)
                        lbl.TextScaled = true
                        lbl.Parent = bb
                    end
                end
            end
        end
    end)

    createToggle(ContentFrame, "X-RAY", 210, false, function(v)
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
                obj.LocalTransparencyModifier = v and 0.7 or 0
            end
        end
    end)

    createToggle(ContentFrame, "SUPER STRENGTH", 250, false, function(v)
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

-- ===== TAB 2: SETTINGS =====
local function openSettings()
    clearContent()

    createSlider(ContentFrame, "Kekuatan Telekinesis", 10, 50, 1000, Settings.TelekinesisPower, function(v)
        Settings.TelekinesisPower = v
    end)

    createSlider(ContentFrame, "Kecepatan Terbang", 80, 10, 500, Settings.FlightSpeed, function(v)
        Settings.FlightSpeed = v
    end)

    createSlider(ContentFrame, "Opasitas Invisibility (%)", 150, 0, 100, Settings.InvisibilityOpacity, function(v)
        Settings.InvisibilityOpacity = v
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = 1 - (v / 100)
                end
            end
        end
    end)

    createSlider(ContentFrame, "Ukuran Pyrokinesis", 220, 1, 50, Settings.PyrokinesisSize, function(v)
        Settings.PyrokinesisSize = v
    end)

    createSlider(ContentFrame, "Jarak Time Stop", 290, 100, 2000, Settings.TimeStopRange, function(v)
        Settings.TimeStopRange = v
    end)
end

-- ===== TAB 3: FLIGHT =====
local function openFlight()
    clearContent()
    local flying = false
    local bodyVel
    createToggle(ContentFrame, "FLIGHT", 10, false, function(v)
        flying = v
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if flying then
            bodyVel = Instance.new("BodyVelocity", hrp)
            bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyVel.Velocity = Vector3.new(0, 0, 0)
            RunService.RenderStepped:Connect(function()
                if flying and bodyVel then
                    local cam = workspace.CurrentCamera
                    bodyVel.Velocity = cam.CFrame.lookVector * Settings.FlightSpeed
                end
            end)
        else
            if bodyVel then bodyVel:Destroy() end
        end
    end)
    createSlider(ContentFrame, "Kecepatan Terbang", 60, 10, 500, Settings.FlightSpeed, function(v)
        Settings.FlightSpeed = v
    end)
end

-- ===== TOMBOL SIDEBAR =====
createSideButton("Powers", 60, openPowers)
createSideButton("Settings", 110, openSettings)
createSideButton("Flight", 160, openFlight)

-- Default tab
openPowers()

-- ===== TOMBOL CLOSE =====
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame
local CC = Instance.new("UICorner", CloseBtn)
CC.CornerRadius = UDim.new(0, 15)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)