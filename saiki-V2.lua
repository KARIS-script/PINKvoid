-- Saiki Kusuo Powers - Draggable Deluxe
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local WA_LINK = "https://whatsapp.com/channel/0029VbD8SsK4SpkJ9HjqBo1x"

local Settings = {
    FlightSpeed = 100,
    FlightSmoothness = 0.2,
    PunchPower = 500,
    FireSize = 10,
    InvisibilityOpacity = 100,
    RegenAmount = 9,
    TeleportEnabled = false,
    AutoRegen = false,
    FlightEnabled = false,
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SaikiPowers"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Deluxe (DRAGGABLE)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -30)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
ToggleBtn.Text = "$"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextScaled = true
ToggleBtn.Parent = ScreenGui

-- DRAG SYSTEM
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function updateDrag(input)
    local delta = input.Position - dragStart
    local newX = startPos.X.Offset + delta.X
    local newY = startPos.Y.Offset + delta.Y
    -- Batasin biar gak keluar layar
    local screenW = ScreenGui.AbsoluteSize.X
    local screenH = ScreenGui.AbsoluteSize.Y
    newX = math.clamp(newX, 0, screenW - ToggleBtn.AbsoluteSize.X)
    newY = math.clamp(newY, 0, screenH - ToggleBtn.AbsoluteSize.Y)
    ToggleBtn.Position = UDim2.new(0, newX, 0, newY)
end

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ToggleBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 240, 245)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 182, 193)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(173, 216, 230)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(144, 238, 144))
}
Gradient.Rotation = 45
Gradient.Parent = MainFrame

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 100, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(255, 218, 224)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

-- Tombol Exit
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Parent = MainFrame
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Tombol Ukuran UI
local SizeBtn = Instance.new("TextButton")
SizeBtn.Size = UDim2.new(0, 25, 0, 25)
SizeBtn.Position = UDim2.new(1, -60, 0, 5)
SizeBtn.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
SizeBtn.Text = "⛶"
SizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SizeBtn.TextScaled = true
SizeBtn.Parent = MainFrame

local sizeLevels = {1.0, 1.2, 0.8}
local sizeIndex = 1

SizeBtn.MouseButton1Click:Connect(function()
    sizeIndex = sizeIndex + 1
    if sizeIndex > #sizeLevels then sizeIndex = 1 end
    local scale = sizeLevels[sizeIndex]
    MainFrame.Size = UDim2.new(0, 450 * scale, 0, 350 * scale)
    MainFrame.Position = UDim2.new(0.5, -225 * scale, 0.5, -175 * scale)
end)

-- Search Bar
local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(1, -115, 0, 30)
SearchFrame.Position = UDim2.new(0, 108, 0, 35)
SearchFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SearchFrame.BorderSizePixel = 0
SearchFrame.Parent = MainFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -10, 1, 0)
SearchBox.Position = UDim2.new(0, 5, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.PlaceholderText = "Cari fitur..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(80, 80, 80)
SearchBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
SearchBox.TextScaled = true
SearchBox.Parent = SearchFrame

-- Content
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -115, 1, -75)
ContentFrame.Position = UDim2.new(0, 108, 0, 70)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
ContentFrame.Parent = MainFrame

local allFeatures = {}

local function clearContent()
    for _, v in pairs(ContentFrame:GetChildren()) do
        if v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("Frame") then v:Destroy() end
    end
    allFeatures = {}
end

local function createToggle(name, yPos, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.95, 0, 0, 30)
    Btn.Position = UDim2.new(0.025, 0, 0, yPos)
    Btn.BackgroundColor3 = Color3.fromRGB(230, 245, 255)
    Btn.Text = name
    Btn.TextScaled = true
    Btn.Parent = ContentFrame
    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.BackgroundColor3 = state and Color3.fromRGB(255, 182, 193) or Color3.fromRGB(230, 245, 255)
        callback(state)
    end)
    table.insert(allFeatures, {name = name, button = Btn})
end

local function createSlider(name, yPos, min, max, default, callback)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.95, 0, 0, 20)
    Label.Position = UDim2.new(0.025, 0, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(80, 80, 80)
    Label.TextScaled = true
    Label.Parent = ContentFrame

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(0.9, 0, 0, 8)
    SliderBg.Position = UDim2.new(0.05, 0, 0, yPos + 22)
    SliderBg.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = ContentFrame

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
    Fill.BorderSizePixel = 0
    Fill.Parent = SliderBg

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 16, 0, 16)
    Btn.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Text = ""
    Btn.Parent = SliderBg

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

-- TELEPORT
mouse.Button1Down:Connect(function()
    if Settings.TeleportEnabled then
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp and mouse.Hit then
            hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end
end)

-- AUTO REGEN
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

-- FLIGHT
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
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if humanoid then
        pcall(function()
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
        end)
    end
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
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        pcall(function()
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
        end)
    end
end

RunService.RenderStepped:Connect(function()
    if flying and bodyVel and bodyGyro then
        local char = player.Character
        if not char then return end
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then return end
        local cam = workspace.CurrentCamera
        local moveDir = humanoid.MoveDirection
        local camLook = cam.CFrame.LookVector
        local targetVel = Vector3.new(0, 0, 0)
        if moveDir.Magnitude > 0 then targetVel = moveDir * Settings.FlightSpeed end
        local verticalSpeed = camLook.Y * Settings.FlightSpeed
        targetVel = targetVel + Vector3.new(0, verticalSpeed, 0)
        currentVelocity = currentVelocity:Lerp(targetVel, Settings.FlightSmoothness)
        bodyVel.Velocity = currentVelocity
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

-- API
local function toggleApiAura(v)
    if v then
        local char = player.Character
        if char then
            local tool = Instance.new("Tool")
            tool.Name = "API AURA"
            tool.RequiresHandle = false
            tool.Parent = player.Backpack
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local attachment = Instance.new("Attachment", hrp)
                local particle = Instance.new("ParticleEmitter", attachment)
                particle.Texture = "rbxassetid://243098098"
                particle.Color = ColorSequence.new(Color3.fromRGB(255, 69, 0))
                particle.Size = NumberSequence.new(Settings.FireSize)
                particle.Transparency = NumberSequence.new(0.3)
                particle.Lifetime = NumberRange.new(0.5, 1)
                particle.Rate = 100
                particle.Speed = NumberRange.new(5, 10)
                particle.SpreadAngle = Vector2.new(180, 180)
            end
        end
    end
end

local function toggleApiRadius(v)
    if v then
        local char = player.Character
        if char then
            local tool = Instance.new("Tool")
            tool.Name = "API RADIUS"
            tool.RequiresHandle = false
            tool.Parent = player.Backpack
            tool.Activated:Connect(function()
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    for _, plr in pairs(game.Players:GetPlayers()) do
                        if plr ~= player and plr.Character then
                            local targetHrp = plr.Character:FindFirstChild("HumanoidRootPart")
                            local targetHumanoid = plr.Character:FindFirstChild("Humanoid")
                            if targetHrp and targetHumanoid then
                                local dist = (targetHrp.Position - hrp.Position).Magnitude
                                if dist <= 30 then
                                    targetHumanoid.Health = 0
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end

local function toggleApiTrail(v)
    if v then
        local char = player.Character
        if char then
            local tool = Instance.new("Tool")
            tool.Name = "API JEJAK"
            tool.RequiresHandle = false
            tool.Parent = player.Backpack
            tool.Activated:Connect(function()
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local trailPart = Instance.new("Part")
                    trailPart.Size = Vector3.new(3, 0.2, 3)
                    trailPart.Position = hrp.Position - Vector3.new(0, 2.5, 0)
                    trailPart.Anchored = true
                    trailPart.CanCollide = false
                    trailPart.Material = Enum.Material.Neon
                    trailPart.Color = Color3.fromRGB(255, 69, 0)
                    trailPart.Parent = workspace
                    local fire = Instance.new("Fire")
                    fire.Size = Settings.FireSize
                    fire.Parent = trailPart
                    task.delay(5, function() if trailPart then trailPart:Destroy() end end)
                    trailPart.Touched:Connect(function(hit)
                        local hitChar = hit.Parent
                        if hitChar and hitChar ~= char then
                            local hitHumanoid = hitChar:FindFirstChild("Humanoid")
                            if hitHumanoid then
                                hitHumanoid.Health = 0
                            end
                        end
                    end)
                end
            end)
        end
    end
end

local function openPowers()
    clearContent()
    local y = 5
    createToggle("TELEKINESIS", y, function(v)
        if v and mouse.Target and mouse.Target:IsA("BasePart") then mouse.Target.Anchored = not mouse.Target.Anchored end
    end) y = y + 35
    createToggle("TELEPORT (Klik)", y, function(v)
        Settings.TeleportEnabled = v
    end) y = y + 35
    createToggle("TIME STOP", y, function(v)
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local h = plr.Character:FindFirstChild("Humanoid")
                if h then h.WalkSpeed = v and 0 or 16 end
            end
        end
    end) y = y + 35
    createToggle("BOUNDLESS", y, function(v)
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
                        local ray = Ray.new(hrp.Position, hrp.CFrame.LookVector * 10)
                        local targetPart = workspace:FindPartOnRay(ray, char)
                        if targetPart then
                            local targetChar = targetPart.Parent
                            if targetChar then
                                local targetHumanoid = targetChar:FindFirstChild("Humanoid")
                                local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
                                if targetHumanoid and targetHrp then
                                    local bv = Instance.new("BodyVelocity", targetHrp)
                                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                                    bv.Velocity = hrp.CFrame.LookVector * Settings.PunchPower + Vector3.new(0, 200, 0)
                                    game:GetService("Debris"):AddItem(bv, 0.5)
                                    targetHumanoid.Health = 0
                                end
                            end
                        end
                    end
                end)
            end
        end
    end) y = y + 35
    createToggle("INVISIBLE", y, function(v)
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = v and (1 - (Settings.InvisibilityOpacity / 100)) or 0
                end
            end
        end
    end) y = y + 35
    createToggle("X-RAY", y, function(v)
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
                obj.LocalTransparencyModifier = v and 0.7 or 0
            end
        end
    end) y = y + 35
    createToggle("MIND READ", y, function(v)
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
                 
