-- Saiki Kusuo Powers - Polos
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local WA_LINK = "https://whatsapp.com/channel/0029VbD8SsK4SpkJ9HjqBo1x"

local Settings = {
    FlightSpeed = 100,
    FlightSmoothness = 0.2,
    InvisibilityOpacity = 100,
    AutoRegen = false,
    RegenAmount = 9,
    FlightEnabled = false,
}

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SaikiPowers"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Tombol buka UI (teks doang)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -30)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
ToggleBtn.Text = "S"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextScaled = true
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = ScreenGui
local TBC = Instance.new("UICorner", ToggleBtn)
TBC.CornerRadius = UDim.new(0, 30)

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 10, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
local MC = Instance.new("UICorner", MainFrame)
MC.CornerRadius = UDim.new(0, 12)

-- Sidebar
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

-- Search
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

local allFeatures = {}

local function clearContent()
    for _, v in pairs(ScrollingFrame:GetChildren()) do
        if v:IsA("TextButton") or v:IsA("Frame") or v:IsA("TextLabel") then v:Destroy() end
    end
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

-- Auto Regen
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
                if healAmount > 0 then humanoid.Health = math.min(humanoid.MaxHealth, newHealth + healAmount) end
            end
        end
        lastHealth = humanoid.Health
    end)
end

-- Flight (analog)
local flying = false
local bodyVel = nil
local bodyGyro = nil
local jumpCount = 0
local lastJumpTime = 0
local currentVelocity = Vector3.new(0, 0, 0)

local function startFlight()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if flying then return end
    flying = true
    bodyVel = Instance.new("BodyVelocity", hrp)
    bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVel.Velocity = Vector3.new(0, 0, 0)
    bodyGyro = Instance.new("BodyGyro", hrp)
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.P = 1000
    bodyGyro.D = 50
    bodyGyro.CFrame = hrp.CFrame
end

local function stopFlight()
    flying = false
    if bodyVel then bodyVel:Destroy() bodyVel = nil end
    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
end

RunService.RenderStepped:Connect(function()
    if flying and bodyVel and bodyGyro then
        local char = player.Character
        if not char then return end
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then return end
        local moveDir = humanoid.MoveDirection
        local targetVel = Vector3.new(0, 0, 0)
        if moveDir.Magnitude > 0 then targetVel = moveDir * Settings.FlightSpeed end
        currentVelocity = currentVelocity:Lerp(targetVel, Settings.FlightSmoothness)
        bodyVel.Velocity = currentVelocity
        local cam = workspace.CurrentCamera
        bodyGyro.CFrame = cam.CFrame
    end
end)

UIS.JumpRequest:Connect(function()
    if not Settings.FlightEnabled then return end
    local now = tick()
    if now - lastJumpTime < 0.4 then jumpCount = jumpCount + 1 else jumpCount = 1 end
    lastJumpTime = now
    if jumpCount >= 2 then
        jumpCount = 0
        if flying then stopFlight() else startFlight() end
    end
end)

local function openPowers()
    clearContent()
    createToggle("TELEKINESIS", 5, false, function(v)
        if v and mouse.Target and mouse.Target:IsA("BasePart") then mouse.Target.Anchored = not mouse.Target.Anchored end
    end)
    createToggle("TELEPORT (Klik)", 40, false, function(v)
        if v and mouse.Hit then
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0)) end
        end
    end)
    createToggle("PYROKINESIS", 75, false, function(v)
        if v and mouse.Target and mouse.Target:IsA("BasePart") then
            local fire = Instance.new("Fire")
            fire.Size = 10
            fire.Parent = mouse.Target
            mouse.Target:BreakJoints()
        end
    end)
    createToggle("TIME STOP", 110, false, function(v)
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local h = plr.Character:FindFirstChild("Humanoid")
                if h then h.WalkSpeed = v and 0 or 16 h.JumpPower = v and 0 or 50 end
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
            if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then obj.LocalTransparencyModifier = v and 0.7 or 0 end
        end
    end)
    createToggle("BOUNDLESS", 215, false, function(v)
        if v then
            local char = player.Character
            if char then
                local tool = Instance.new("Tool")
                tool.Name = "Boundless"
                tool.RequiresHandle = false
                tool.Parent = player.Backpack
                tool.Activated:Connect(function()
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local rayParams = RaycastParams.new()
                        rayParams.FilterDescendantsInstances = {char}
                        rayParams.FilterType = Enum.RaycastFilterType.Exclude
                        local result = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 10, rayParams)
                        if result and result.Instance then
                            local targetChar = result.Instance.Parent
                            if targetChar then
                                local targetHumanoid = targetChar:FindFirstChild("Humanoid")
                                local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
                                if targetHumanoid and targetHrp then
                                    local bv = Instance.new("BodyVelocity", targetHrp)
                                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                    bv.Velocity = hrp.CFrame.LookVector * 500 + Vector3.new(0, 200, 0)
                                    game:GetService("Debris"):AddItem(bv, 0.5)
                                    targetHumanoid.Health = 0
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
    createToggle("FLIGHT (2x JUMP)", 250, false, function(v)
        Settings.FlightEnabled = v
        if not v and flying then stopFlight() end
    end)
    -- Elemen
    local elements = {"API", "AIR", "ANGIN", "TANAH", "LISTRIK", "BESI"}
    local elementColors = {
        Color3.fromRGB(255, 69, 0),
        Color3.fromRGB(0, 150, 255),
        Color3.fromRGB(200, 255, 200),
        Color3.fromRGB(139, 69, 19),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(150, 150, 150),
    }
    local activeElement = nil
    for i, name in ipairs(elements) do
        createToggle(name, 285 + (i-1) * 35, false, function(v)
            if v then
                if activeElement then activeElement:Destroy() end
                local char = player.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local attachment = Instance.new("Attachment", hrp)
                        local particle = Instance.new("ParticleEmitter", attachment)
                        particle.Texture = "rbxassetid://243098098"
                        particle.Color = ColorSequence.new(elementColors[i])
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
                if activeElement then activeElement:Destroy() activeElement = nil end
            end
        end)
    end
end

local function openSettings()
    clearContent()
    createToggle("INVISIBLE", 5, false, function(v)
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.LocalTransparencyModifier = v and (1 - (Settings.InvisibilityOpacity / 100)) or 0 end
            end
        end
    end)
    createToggle("AUTO REGEN", 40, false, function(v)
        Settings.AutoRegen = v
        if v then startAutoRegen()
        else
            if regenConnection then regenConnection:Disconnect() regenConnection = nil end
        end
    end)
end

local function openSC()
    clearContent()
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.95, 0, 0, 100)
    label.Position = UDim2.new(0.025, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = "follow for more script\n" .. WA_LINK
    label.TextColor3 = Color3.fromRGB(255, 182, 193)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextWrapped = true
    label.Parent = ScrollingFrame
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
createSideButton("Pengaturan", 90, openSettings)
createSideButton("SC", 130, openSC)

openPowers()

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
    MainFrame.Visible = false
end)

-- Notifikasi
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Saiki Powers";
    Text = "Script loaded!";
    Duration = 3;
})