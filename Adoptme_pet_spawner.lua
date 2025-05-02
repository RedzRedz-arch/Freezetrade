-- Enhanced Mobile-Friendly Pet Spawner with Ride/Fly Functionality
-- Educational purposes only - creates functional pets with ride/fly abilities
-- For loadstring use with GitHub: loadstring(game:HttpGet("https://raw.githubusercontent.com/YourUsername/YourRepository/main/enhancedpetspawner.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create ScreenGui with proper touch support
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PetSpawnerEnhanced"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- Try to place in CoreGui for better persistence
local success = pcall(function()
    ScreenGui.Parent = game.CoreGui
end)

if not success then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Detect if on mobile device
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local uiScaleFactor = isMobile and 1.5 or 1  -- Increase UI scale on mobile

-- Color palette for a more preppy look
local colors = {
    background = Color3.fromRGB(30, 30, 35),
    primary = Color3.fromRGB(115, 76, 227), -- Purple
    secondary = Color3.fromRGB(240, 84, 193), -- Pink
    accent = Color3.fromRGB(66, 211, 227), -- Cyan
    text = Color3.fromRGB(255, 255, 255),
    textDark = Color3.fromRGB(50, 50, 50),
}

-- Pet data with meshes and colors
local petData = {
    ["Owl"] = {
        model = "Owl",
        primaryColor = Color3.fromRGB(146, 102, 58),
        secondaryColor = Color3.fromRGB(226, 185, 89),
        scale = Vector3.new(2, 2, 2),
        meshId = "rbxassetid://6843054184", -- Owl-like mesh
        animationSpeed = 1,
        ridingOffset = Vector3.new(0, 1.5, 0)
    },
    ["Shadow Dragon"] = {
        model = "ShadowDragon",
        primaryColor = Color3.fromRGB(40, 40, 40),
        secondaryColor = Color3.fromRGB(138, 43, 226),
        scale = Vector3.new(2.5, 2.5, 2.5),
        meshId = "rbxassetid://3250312895", -- Dragon-like mesh
        animationSpeed = 1.2,
        ridingOffset = Vector3.new(0, 1.8, 0)
    },
    ["Frost Dragon"] = {
        model = "FrostDragon",
        primaryColor = Color3.fromRGB(166, 214, 255),
        secondaryColor = Color3.fromRGB(87, 160, 255),
        scale = Vector3.new(2.5, 2.5, 2.5),
        meshId = "rbxassetid://3250312895", -- Dragon-like mesh
        animationSpeed = 1.2,
        ridingOffset = Vector3.new(0, 1.8, 0)
    },
    ["Bat Dragon"] = {
        model = "BatDragon",
        primaryColor = Color3.fromRGB(80, 80, 80),
        secondaryColor = Color3.fromRGB(194, 52, 52),
        scale = Vector3.new(2.5, 2.5, 2.5),
        meshId = "rbxassetid://3250312895", -- Dragon-like mesh
        animationSpeed = 1.2,
        ridingOffset = Vector3.new(0, 1.8, 0)
    },
    ["Giraffe"] = {
        model = "Giraffe",
        primaryColor = Color3.fromRGB(253, 196, 49),
        secondaryColor = Color3.fromRGB(162, 92, 0),
        scale = Vector3.new(2.2, 2.5, 2.2),
        meshId = "rbxassetid://8914375633", -- Quadruped-like mesh
        animationSpeed = 0.8,
        ridingOffset = Vector3.new(0, 2.5, -0.5)
    },
    ["Parrot"] = {
        model = "Parrot",
        primaryColor = Color3.fromRGB(255, 66, 66),
        secondaryColor = Color3.fromRGB(255, 230, 77),
        scale = Vector3.new(1.5, 1.5, 1.5),
        meshId = "rbxassetid://6843054184", -- Bird-like mesh
        animationSpeed = 1.3,
        ridingOffset = Vector3.new(0, 1.5, 0)
    },
    ["Unicorn"] = {
        model = "Unicorn",
        primaryColor = Color3.fromRGB(255, 150, 255),
        secondaryColor = Color3.fromRGB(182, 108, 255),
        scale = Vector3.new(2, 2, 2),
        meshId = "rbxassetid://8914375633", -- Quadruped-like mesh
        animationSpeed = 1,
        ridingOffset = Vector3.new(0, 2, -0.5)
    },
    ["Turtle"] = {
        model = "Turtle",
        primaryColor = Color3.fromRGB(120, 190, 33),
        secondaryColor = Color3.fromRGB(61, 145, 64),
        scale = Vector3.new(1.8, 1.5, 1.8),
        meshId = "rbxassetid://4770583278", -- Turtle-like mesh
        animationSpeed = 0.6,
        ridingOffset = Vector3.new(0, 1.8, 0)
    }
}

-- Main container (semi-transparent modal)
local BackgroundFrame = Instance.new("Frame")
BackgroundFrame.Name = "BackgroundFrame"
BackgroundFrame.Size = UDim2.new(1, 0, 1, 0)
BackgroundFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BackgroundFrame.BackgroundTransparency = 0.3
BackgroundFrame.Parent = ScreenGui

-- Main UI Panel - Adjusted for mobile
local MainPanel = Instance.new("Frame")
MainPanel.Name = "MainPanel"
-- Make wider on mobile for easier touch
MainPanel.Size = UDim2.new(isMobile and 0.95 or 0.9, 0, isMobile and 0.7 or 0.6, 0)
MainPanel.Position = UDim2.new(0.5, 0, 0.5, 0)
MainPanel.AnchorPoint = Vector2.new(0.5, 0.5)
MainPanel.BackgroundColor3 = colors.background
MainPanel.BorderSizePixel = 0
MainPanel.Parent = BackgroundFrame

-- Apply rounded corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12) -- Rounder corners
UICorner.Parent = MainPanel

-- Add gradient to make it prettier
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 30))
})
UIGradient.Rotation = 45
UIGradient.Parent = MainPanel

-- Add glow effect
local Glow = Instance.new("ImageLabel")
Glow.Name = "Glow"
Glow.Size = UDim2.new(1.2, 0, 1.2, 0)
Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://5028857084"
Glow.ImageColor3 = colors.primary
Glow.ImageTransparency = 0.8
Glow.ZIndex = -1
Glow.Parent = MainPanel

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0.15, 0)
TitleBar.BackgroundColor3 = colors.primary
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainPanel

-- Round the title bar corners
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- Fix the bottom corners of title bar
local TitleCornerFix = Instance.new("Frame")
TitleCornerFix.Size = UDim2.new(1, 0, 0.5, 0)
TitleCornerFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleCornerFix.BackgroundColor3 = colors.primary
TitleCornerFix.BorderSizePixel = 0
TitleCornerFix.Parent = TitleBar

-- Gradient for the title bar
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, colors.primary),
    ColorSequenceKeypoint.new(1, colors.secondary)
})
TitleGradient.Rotation = 90
TitleGradient.Parent = TitleBar
TitleGradient:Clone().Parent = TitleCornerFix

-- Title text
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 20, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "🐾 Pet Spawner"
TitleText.TextColor3 = colors.text
TitleText.TextSize = isMobile and 32 or 28 -- Larger text on mobile
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, isMobile and 50 or 40, 0, isMobile and 50 or 40) -- Larger on mobile
CloseButton.Position = UDim2.new(1, -20, 0.5, 0)
CloseButton.AnchorPoint = Vector2.new(1, 0.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.Text = "✕"
CloseButton.TextColor3 = colors.text
CloseButton.TextSize = isMobile and 28 or 24 -- Larger text on mobile
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.CornerRadius = UDim.new(1, 0)
CloseButtonCorner.Parent = CloseButton

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -40, 0.85, -20)
ContentFrame.Position = UDim2.new(0.5, 0, 0.15, 10)
ContentFrame.AnchorPoint = Vector2.new(0.5, 0)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainPanel

-- Label
local InstructionLabel = Instance.new("TextLabel")
InstructionLabel.Name = "InstructionLabel"
InstructionLabel.Size = UDim2.new(1, 0, 0, isMobile and 40 or 30)
InstructionLabel.BackgroundTransparency = 1
InstructionLabel.Text = "✨ Create Your Dream Pet ✨"
InstructionLabel.TextColor3 = colors.accent
InstructionLabel.TextSize = isMobile and 26 or 22 -- Larger text on mobile
InstructionLabel.Font = Enum.Font.GothamBold
InstructionLabel.Parent = ContentFrame

-- Subtitle
local SubLabel = Instance.new("TextLabel")
SubLabel.Name = "SubLabel"
SubLabel.Size = UDim2.new(1, 0, 0, isMobile and 30 or 20)
SubLabel.Position = UDim2.new(0, 0, 0, isMobile and 45 or 35)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "Select options and click spawn to create a rideable pet"
SubLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
SubLabel.TextSize = isMobile and 20 or 16 -- Larger text on mobile
SubLabel.Font = Enum.Font.Gotham
SubLabel.Parent = ContentFrame

-- Divider
local Divider = Instance.new("Frame")
Divider.Name = "Divider"
Divider.Size = UDim2.new(0.8, 0, 0, 2)
Divider.Position = UDim2.new(0.5, 0, 0, isMobile and 85 or 65)
Divider.AnchorPoint = Vector2.new(0.5, 0)
Divider.BackgroundColor3 = colors.primary
Divider.BorderSizePixel = 0
Divider.Parent = ContentFrame

local DividerGradient = TitleGradient:Clone()
DividerGradient.Parent = Divider

-- Rarity Selection
local RarityLabelFrame = Instance.new("Frame")
RarityLabelFrame.Name = "RarityLabelFrame"
RarityLabelFrame.Size = UDim2.new(1, 0, 0, isMobile and 40 or 30)
RarityLabelFrame.Position = UDim2.new(0, 0, 0, isMobile and 100 or 80)
RarityLabelFrame.BackgroundTransparency = 1
RarityLabelFrame.Parent = ContentFrame

local RarityLabel = Instance.new("TextLabel")
RarityLabel.Name = "RarityLabel"
RarityLabel.Size = UDim2.new(1, 0, 1, 0)
RarityLabel.BackgroundTransparency = 1
RarityLabel.Text = "Choose Rarity:"
RarityLabel.TextColor3 = colors.text
RarityLabel.TextSize = isMobile and 22 or 18 -- Larger text on mobile
RarityLabel.Font = Enum.Font.GothamBold
RarityLabel.TextXAlignment = Enum.TextXAlignment.Left
RarityLabel.Parent = RarityLabelFrame

local RarityFrame = Instance.new("Frame")
RarityFrame.Name = "RarityFrame"
RarityFrame.Size = UDim2.new(1, 0, 0, isMobile and 60 or 50)
RarityFrame.Position = UDim2.new(0, 0, 0, isMobile and 140 or 110)
RarityFrame.BackgroundTransparency = 1
RarityFrame.Parent = ContentFrame

-- Create rarity buttons with more visual appeal
local rarities = {
    {name = "FR", color = Color3.fromRGB(255, 255, 255), textColor = Color3.fromRGB(50, 50, 50), icon = "🔥"},
    {name = "NFR", color = Color3.fromRGB(115, 230, 95), textColor = Color3.fromRGB(50, 50, 50), icon = "✨"},
    {name = "MFR", color = Color3.fromRGB(255, 217, 61), textColor = Color3.fromRGB(50, 50, 50), icon = "🌟"}
}

local selectedRarity = rarities[2]

for i, rarity in ipairs(rarities) do
    local button = Instance.new("TextButton")
    button.Name = rarity.name .. "Button"
    button.Size = UDim2.new(0.3, -10, 1, 0)
    button.Position = UDim2.new((i-1) * 0.33 + 0.165, 0, 0, 0)
    button.AnchorPoint = Vector2.new(0.5, 0)
    button.BackgroundColor3 = i == 2 and rarity.color or Color3.fromRGB(70, 70, 75)
    button.Text = rarity.icon .. " " .. rarity.name
    button.TextColor3 = i == 2 and rarity.textColor or colors.text
    button.TextSize = isMobile and 24 or 20 -- Larger text on mobile
    button.Font = Enum.Font.GothamBold
    button.Parent = RarityFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = button
    
    -- Add shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1.1, 0, 1.2, 0)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5028857084"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.ZIndex = -1
    shadow.Parent = button
    
    -- Add glow for selected
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.Size = UDim2.new(1.3, 0, 1.3, 0)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = rarity.color
    glow.ImageTransparency = i == 2 and 0.7 or 1
    glow.ZIndex = -1
    glow.Parent = button
    
    button.MouseButton1Click:Connect(function()
        -- Update visual selection
        for j, r in ipairs(rarities) do
            local otherButton = RarityFrame:FindFirstChild(r.name .. "Button")
            if otherButton then
                otherButton.BackgroundColor3 = r == rarity and r.color or Color3.fromRGB(70, 70, 75)
                otherButton.TextColor3 = (r == rarity and r.textColor) or colors.text
                otherButton.Glow.ImageTransparency = r == rarity and 0.7 or 1
            end
        end
        selectedRarity = rarity
    end)
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        if button.BackgroundColor3 ~= rarity.color then  -- If not selected
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(90, 90, 95)}):Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if button.BackgroundColor3 ~= rarity.color then  -- If not selected
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 75)}):Play()
        end
    end)
end

-- Pet Selection Label
local PetLabelFrame = Instance.new("Frame")
PetLabelFrame.Name = "PetLabelFrame"
PetLabelFrame.Size = UDim2.new(1, 0, 0, isMobile and 40 or 30)
PetLabelFrame.Position = UDim2.new(0, 0, 0, isMobile and 210 or 170)
PetLabelFrame.BackgroundTransparency = 1
PetLabelFrame.Parent = ContentFrame

local PetLabel = Instance.new("TextLabel")
PetLabel.Name = "PetLabel"
PetLabel.Size = UDim2.new(1, 0, 1, 0)
PetLabel.BackgroundTransparency = 1
PetLabel.Text = "Choose Pet:"
PetLabel.TextColor3 = colors.text
PetLabel.TextSize = isMobile and 22 or 18 -- Larger text on mobile
PetLabel.Font = Enum.Font.GothamBold
PetLabel.TextXAlignment = Enum.TextXAlignment.Left
PetLabel.Parent = PetLabelFrame

-- Pet Selection
local PetSelectionFrame = Instance.new("Frame")
PetSelectionFrame.Name = "PetSelectionFrame"
PetSelectionFrame.Size = UDim2.new(1, 0, 0, isMobile and 60 or 50)
PetSelectionFrame.Position = UDim2.new(0, 0, 0, isMobile and 250 or 200)
PetSelectionFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
PetSelectionFrame.Parent = ContentFrame

local PetSelectionCorner = Instance.new("UICorner")
PetSelectionCorner.CornerRadius = UDim.new(0, 10)
PetSelectionCorner.Parent = PetSelectionFrame

-- Add shadow to dropdown
local dropdownShadow = Instance.new("ImageLabel")
dropdownShadow.Name = "Shadow"
dropdownShadow.Size = UDim2.new(1.02, 0, 1.1, 0)
dropdownShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
dropdownShadow.AnchorPoint = Vector2.new(0.5, 0.5)
dropdownShadow.BackgroundTransparency = 1
dropdownShadow.Image = "rbxassetid://5028857084"
dropdownShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
dropdownShadow.ImageTransparency = 0.6
dropdownShadow.ZIndex = -1
dropdownShadow.Parent = PetSelectionFrame

local PetDropdown = Instance.new("TextButton")
PetDropdown.Name = "PetDropdown"
PetDropdown.Size = UDim2.new(1, 0, 1, 0)
PetDropdown.BackgroundTransparency = 1
PetDropdown.Text = "Owl"
PetDropdown.TextColor3 = colors.text
PetDropdown.TextSize = isMobile and 24 or 20 -- Larger text on mobile
PetDropdown.Font = Enum.Font.Gotham
PetDropdown.Parent = PetSelectionFrame

-- Dropdown arrow
local DropdownArrow = Instance.new("ImageLabel")
DropdownArrow.Name = "DropdownArrow"
DropdownArrow.Size = UDim2.new(0, isMobile and 30 or 20, 0, isMobile and 30 or 20)
DropdownArrow.Position = UDim2.new(1, -30, 0.5, 0)
DropdownArrow.AnchorPoint = Vector2.new(0.5, 0.5)
DropdownArrow.BackgroundTransparency = 1
DropdownArrow.Image = "rbxassetid://9074628624" -- Arrow icon
DropdownArrow.ImageColor3 = colors.text
DropdownArrow.Parent = PetSelectionFrame

-- Preview area
local PreviewFrame = Instance.new("Frame")
PreviewFrame.Name = "PreviewFrame"
PreviewFrame.Size = UDim2.new(1, 0, 0, isMobile and 120 or 100)
PreviewFrame.Position = UDim2.new(0, 0, 0, isMobile and 320 or 260)
PreviewFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
PreviewFrame.Parent = ContentFrame

local PreviewCorner = Instance.new("UICorner")
PreviewCorner.CornerRadius = UDim.new(0, 10)
PreviewCorner.Parent = PreviewFrame

local PreviewLabel = Instance.new("TextLabel")
PreviewLabel.Name = "PreviewLabel"
PreviewLabel.Size = UDim2.new(1, 0, 0, isMobile and 40 or 30)
PreviewLabel.Position = UDim2.new(0, 0, 0, 5)
PreviewLabel.BackgroundTransparency = 1
PreviewLabel.Text = "Preview:"
PreviewLabel.TextColor3 = colors.text
PreviewLabel.TextSize = isMobile and 20 or 16 -- Larger text on mobile
PreviewLabel.Font = Enum.Font.GothamBold
PreviewLabel.Parent = PreviewFrame

-- Preview icon
local PreviewIcon = Instance.new("ImageLabel")
PreviewIcon.Name = "PreviewIcon"
PreviewIcon.Size = UDim2.new(0, isMobile and 80 or 60, 0, isMobile and 80 or 60)
PreviewIcon.Position = UDim2.new(0.5, 0, 0.5, 10)
PreviewIcon.AnchorPoint = Vector2.new(0.5, 0.5)
PreviewIcon.BackgroundTransparency = 1
PreviewIcon.Image = "rbxassetid://6843054184" -- Default owl icon
PreviewIcon.ImageColor3 = Color3.fromRGB(146, 102, 58)
PreviewIcon.Parent = PreviewFrame

-- Spawn Button (at the bottom)
local SpawnButton = Instance.new("TextButton")
SpawnButton.Name = "SpawnButton"
SpawnButton.Size = UDim2.new(0.8, 0, 0, isMobile and 80 or 60)
SpawnButton.Position = UDim2.new(0.5, 0, 1, isMobile and -90 or -70)
SpawnButton.AnchorPoint = Vector2.new(0.5, 0)
SpawnButton.BackgroundColor3 = colors.accent
SpawnButton.Text = "SPAWN PET"
SpawnButton.TextColor3 = colors.textDark
SpawnButton.TextSize = isMobile and 30 or 24 -- Larger text on mobile
SpawnButton.Font = Enum.Font.GothamBold
SpawnButton.Parent = ContentFrame

local SpawnButtonCorner = Instance.new("UICorner")
SpawnButtonCorner.CornerRadius = UDim.new(0, 15)
SpawnButtonCorner.Parent = SpawnButton

-- Button gradient
local SpawnGradient = Instance.new("UIGradient")
SpawnGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, colors.accent),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(colors.accent.R*0.8, colors.accent.G*0.8, colors.accent.B*0.8))
})
SpawnGradient.Rotation = 90
SpawnGradient.Parent = SpawnButton

-- Button glow
local buttonGlow = Instance.new("ImageLabel")
buttonGlow.Name = "Glow"
buttonGlow.Size = UDim2.new(1.1, 0, 1.2, 0)
buttonGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
buttonGlow.AnchorPoint = Vector2.new(0.5, 0.5)
buttonGlow.BackgroundTransparency = 1
buttonGlow.Image = "rbxassetid://5028857084"
buttonGlow.ImageColor3 = colors.accent
buttonGlow.ImageTransparency = 0.7
buttonGlow.ZIndex = -1
buttonGlow.Parent = SpawnButton

-- Status text
local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Size = UDim2.new(1, 0, 0, isMobile and 30 or 20)
StatusText.Position = UDim2.new(0, 0, 1, isMobile and -30 or -20)
StatusText.BackgroundTransparency = 1
StatusText.Text = "🐾 Pet Spawner • v2.5"
StatusText.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusText.TextSize = isMobile and 18 or 14 -- Larger text on mobile
StatusText.Font = Enum.Font.Gotham
StatusText.Parent = ContentFrame

-- Add inventory button - NEW
local InventoryButton = Instance.new("TextButton")
InventoryButton.Name = "InventoryButton"
InventoryButton.Size = UDim2.new(0.35, 0, 0, isMobile and 60 or 40)
InventoryButton.Position = UDim2.new(0.825, 0, 0, isMobile and 100 or 80)
InventoryButton.Name = "InventoryButton"
InventoryButton.Size = UDim2.new(0.35, 0, 0, isMobile and 60 or 40)
InventoryButton.Position = UDim2.new(0.825, 0, 0, isMobile and 100 or 80)
InventoryButton.AnchorPoint = Vector2.new(0.5, 0)
InventoryButton.BackgroundColor3 = colors.secondary
InventoryButton.Text = "🎒 INVENTORY"
InventoryButton.TextColor3 = colors.text
InventoryButton.TextSize = isMobile and 20 or 16
InventoryButton.Font = Enum.Font.GothamBold
InventoryButton.Parent = ContentFrame

local InventoryButtonCorner = Instance.new("UICorner")
InventoryButtonCorner.CornerRadius = UDim.new(0, 10)
InventoryButtonCorner.Parent = InventoryButton

-- Inventory button gradient
local InventoryGradient = Instance.new("UIGradient")
InventoryGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, colors.secondary),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(colors.secondary.R*0.8, colors.secondary.G*0.8, colors.secondary.B*0.8))
})
InventoryGradient.Rotation = 90
InventoryGradient.Parent = InventoryButton

-- Button glow for inventory
local inventoryGlow = Instance.new("ImageLabel")
inventoryGlow.Name = "Glow"
inventoryGlow.Size = UDim2.new(1.1, 0, 1.2, 0)
inventoryGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
inventoryGlow.AnchorPoint = Vector2.new(0.5, 0.5)
inventoryGlow.BackgroundTransparency = 1
inventoryGlow.Image = "rbxassetid://5028857084"
inventoryGlow.ImageColor3 = colors.secondary
inventoryGlow.ImageTransparency = 0.7
inventoryGlow.ZIndex = -1
inventoryGlow.Parent = InventoryButton

-- Inventory Panel (initially hidden)
local InventoryPanel = Instance.new("Frame")
InventoryPanel.Name = "InventoryPanel"
InventoryPanel.Size = UDim2.new(1, 0, 1, 0)
InventoryPanel.BackgroundColor3 = colors.background
InventoryPanel.BorderSizePixel = 0
InventoryPanel.Visible = false
InventoryPanel.Parent = MainPanel

local InventoryPanelCorner = UICorner:Clone()
InventoryPanelCorner.Parent = InventoryPanel

local InventoryGradient = UIGradient:Clone()
InventoryGradient.Parent = InventoryPanel

-- Inventory Title Bar
local InventoryTitleBar = TitleBar:Clone()
InventoryTitleBar.Parent = InventoryPanel
InventoryTitleBar.TitleText.Text = "🎒 Pet Inventory"

-- Back Button
local BackButton = Instance.new("TextButton")
BackButton.Name = "BackButton"
BackButton.Size = UDim2.new(0, isMobile and 120 or 100, 0, isMobile and 50 or 40)
BackButton.Position = UDim2.new(1, -150, 0.5, 0)
BackButton.AnchorPoint = Vector2.new(1, 0.5)
BackButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
BackButton.Text = "◀ BACK"
BackButton.TextColor3 = colors.text
BackButton.TextSize = isMobile and 22 or 18
BackButton.Font = Enum.Font.GothamBold
BackButton.Parent = InventoryTitleBar

local BackButtonCorner = Instance.new("UICorner")
BackButtonCorner.CornerRadius = UDim.new(0, 10)
BackButtonCorner.Parent = BackButton
