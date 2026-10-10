-- Saiki Powers - Full Version
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local WA_LINK = "https://whatsapp.com/channel/0029VbD8SsK4SpkJ9HjqBo1x"

local Settings = {
    FlightSpeed = 100,
    PunchPower = 500,
    FireSize = 10,
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SaikiPowers"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Deluxe (huruf $)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -30)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
ToggleBtn.Text = "$"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextScaled = true
ToggleBtn.Parent = ScreenGui
local TBC = Instance.new("UICorner", ToggleBtn)
TBC.CornerRadius = UDim.new(0, 8)

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 240, 245)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
local MC = Instance.new("UICorner", MainFrame)
MC.CornerRadius = UDim.new(0, 12)

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 182, 193)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(173, 216, 230)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(144, 238, 144))
}
Gradient.Rotation = 45
Gradient.Parent = MainFrame

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 100, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(255, 218, 224)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
local SC = Instance.new("UICorner", Sidebar)
SC.CornerRadius = UDim.new(0, 12)

local SideTitle = Instance.new("TextLabel")
SideTitle.Size = UDim2.new(1, 0, 0, 40)
SideTitle.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
SideTitle.Text = "SAIKI"
SideTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SideTitle.TextScaled = true
SideTitle.Parent = Sidebar
local STC = Instance.new("UICorner", SideTitle)
STC.CornerRadius = UDim.new(0, 12)

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -110, 1, -20)
ContentFrame.Position = UDim2.new(0, 105, 0, 10)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
ScrollingFrame.Parent = ContentFrame

local function clearContent()
    for _, v in pairs(ScrollingFrame:GetChildren()) do
        if v:IsA("TextButton") or v:IsA("Frame") or v:IsA("TextLabel") then v:Destroy() end
    end
end

local function createToggle(name, yPos, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.95, 0, 0, 28)
    Btn.Position = UDim2.new(0.025, 0, 0, yPos)
    Btn.BackgroundColor3 = Color3.fromRGB(230, 245, 255)
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(80, 80, 80)
    Btn.TextScaled = true
    Btn.Parent = ScrollingFrame
    local c = Instance.new("UICorner", Btn)
    c.CornerRadius = UDim.new(0, 6)
    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.BackgroundColor3 = state and Color3.fromRGB(255, 182, 193) or Color3.fromRGB(230, 245, 255)
        Btn.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(80, 80, 80)
        callback(state)
    end)
end

local function createSlider(name, yPos, min, max, default, callback)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.95, 0, 0, 20)
    Label.Position = UDim2.new(0.025, 0, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(80, 80, 80)
    Label.TextScaled = true
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ScrollingFrame

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(0.9, 0, 0, 8)
    SliderBg.Position = UDim2.new(0.05, 0, 0, yPos + 22)
    SliderBg.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = ScrollingFrame
    local SBC = Instance.new("UICorner", SliderBg)
    SBC.CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
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

-- API ITEM
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
                particle.Rate = 100
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
                                    targetHumanoid:TakeDamage(1000)
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
                                hitHumanoid:TakeDamage(1000)
                                hitHumanoid.Health = 0
                            end
                        end
                    end)
                end
            end)
        end
    end
end

local function openElements()
    clearContent()
    createToggle("API (AURA)", 5, function(v) toggleApiAura(v) end)
    createToggle("API (RADIUS 30)", 40, function(v) toggleApiRadius(v) end)
    createToggle("API (JEJAK)", 75, function(v) toggleApiTrail(v) end)
end

local function openSettings()
    clearContent()
    createSlider("Kecepatan Terbang", 5, 10, 500, Settings.FlightSpeed, function(v) Settings.FlightSpeed = v end)
    createSlider("Kekuatan Tonjokan", 40, 100, 2000, Settings.PunchPower, function(v) Settings.PunchPower = v end)
    createSlider("Ukuran Api", 75, 1, 50, Settings.FireSize, function(v) Settings.FireSize = v end)
end

local function openSC()
    clearContent()
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.95, 0, 0, 100)
    label.Position = UDim2.new(0.025, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = "follow for more script\n" .. WA_LINK
    label.TextColor3 = Color3.fromRGB(80, 80, 80)
    label.TextScaled = true
    label.TextWrapped = true
    label.Parent = ScrollingFrame
end

local function createSideButton(name, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(230, 245, 255)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(80, 80, 80)
    btn.TextScaled = true
    btn.Parent = Sidebar
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
end

createSideButton("Elemen", 50, openElements)
createSideButton("Pengaturan", 90, openSettings)
createSideButton("SC", 130, openSC)

openElements()

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Parent = MainFrame
local CC = Instance.new("UICorner", CloseBtn)
CC.CornerRadius = UDim.new(0, 12)
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

print("Saiki Loaded")