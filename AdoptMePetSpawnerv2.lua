-- Enhanced Pet Spawner UI Demo
-- Educational purposes only - creates visual pet props
-- For loadstring use with GitHub: loadstring(game:HttpGet("https://raw.githubusercontent.com/YourUsername/YourRepository/main/petspawner.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create ScreenGui with proper touch support
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PetSpawnerDemo"
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
        animationSpeed = 1
    },
    ["Shadow Dragon"] = {
        model = "ShadowDragon",
        primaryColor = Color3.fromRGB(40, 40, 40),
        secondaryColor = Color3.fromRGB(138, 43, 226),
        scale = Vector3.new(2.5, 2.5, 2.5),
        meshId = "rbxassetid://3250312895", -- Dragon-like mesh
        animationSpeed = 1.2
    },
    ["Frost Dragon"] = {
        model = "FrostDragon",
        primaryColor = Color3.fromRGB(166, 214, 255),
        secondaryColor = Color3.fromRGB(87, 160, 255),
        scale = Vector3.new(2.5, 2.5, 2.5),
        meshId = "rbxassetid://3250312895", -- Dragon-like mesh
        animationSpeed = 1.2
    },
    ["Bat Dragon"] = {
        model = "BatDragon",
        primaryColor = Color3.fromRGB(80, 80, 80),
        secondaryColor = Color3.fromRGB(194, 52, 52),
        scale = Vector3.new(2.5, 2.5, 2.5),
        meshId = "rbxassetid://3250312895", -- Dragon-like mesh
        animationSpeed = 1.2
    },
    ["Giraffe"] = {
        model = "Giraffe",
        primaryColor = Color3.fromRGB(253, 196, 49),
        secondaryColor = Color3.fromRGB(162, 92, 0),
        scale = Vector3.new(2.2, 2.5, 2.2),
        meshId = "rbxassetid://8914375633", -- Quadruped-like mesh
        animationSpeed = 0.8
    },
    ["Parrot"] = {
        model = "Parrot",
        primaryColor = Color3.fromRGB(255, 66, 66),
        secondaryColor = Color3.fromRGB(255, 230, 77),
        scale = Vector3.new(1.5, 1.5, 1.5),
        meshId = "rbxassetid://6843054184", -- Bird-like mesh
        animationSpeed = 1.3
    },
    ["Unicorn"] = {
        model = "Unicorn",
        primaryColor = Color3.fromRGB(255, 150, 255),
        secondaryColor = Color3.fromRGB(182, 108, 255),
        scale = Vector3.new(2, 2, 2),
        meshId = "rbxassetid://8914375633", -- Quadruped-like mesh
        animationSpeed = 1
    },
    ["Turtle"] = {
        model = "Turtle",
        primaryColor = Color3.fromRGB(120, 190, 33),
        secondaryColor = Color3.fromRGB(61, 145, 64),
        scale = Vector3.new(1.8, 1.5, 1.8),
        meshId = "rbxassetid://4770583278", -- Turtle-like mesh
        animationSpeed = 0.6
    }
}

-- Main container (semi-transparent modal)
local BackgroundFrame = Instance.new("Frame")
BackgroundFrame.Name = "BackgroundFrame"
BackgroundFrame.Size = UDim2.new(1, 0, 1, 0)
BackgroundFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BackgroundFrame.BackgroundTransparency = 0.3
BackgroundFrame.Parent = ScreenGui

-- Main UI Panel - Bigger and Preppier
local MainPanel = Instance.new("Frame")
MainPanel.Name = "MainPanel"
MainPanel.Size = UDim2.new(0.9, 0, 0.6, 0) -- Bigger
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
TitleBar.Name = "PetSpawner By Chinoks"
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
TitleText.TextSize = 28
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -20, 0.5, 0)
CloseButton.AnchorPoint = Vector2.new(1, 0.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.Text = "✕"
CloseButton.TextColor3 = colors.text
CloseButton.TextSize = 24
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
InstructionLabel.Size = UDim2.new(1, 0, 0, 30)
InstructionLabel.BackgroundTransparency = 1
InstructionLabel.Text = "✨ Create Your Dream Pet ✨"
InstructionLabel.TextColor3 = colors.accent
InstructionLabel.TextSize = 22
InstructionLabel.Font = Enum.Font.GothamBold
InstructionLabel.Parent = ContentFrame

-- Subtitle
local SubLabel = Instance.new("TextLabel")
SubLabel.Name = "SubLabel"
SubLabel.Size = UDim2.new(1, 0, 0, 20)
SubLabel.Position = UDim2.new(0, 0, 0, 35)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "Select options and click spawn to create a visual pet"
SubLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
SubLabel.TextSize = 16
SubLabel.Font = Enum.Font.Gotham
SubLabel.Parent = ContentFrame

-- Divider
local Divider = Instance.new("Frame")
Divider.Name = "Divider"
Divider.Size = UDim2.new(0.8, 0, 0, 2)
Divider.Position = UDim2.new(0.5, 0, 0, 65)
Divider.AnchorPoint = Vector2.new(0.5, 0)
Divider.BackgroundColor3 = colors.primary
Divider.BorderSizePixel = 0
Divider.Parent = ContentFrame

local DividerGradient = TitleGradient:Clone()
DividerGradient.Parent = Divider

-- Rarity Selection
local RarityLabelFrame = Instance.new("Frame")
RarityLabelFrame.Name = "RarityLabelFrame"
RarityLabelFrame.Size = UDim2.new(1, 0, 0, 30)
RarityLabelFrame.Position = UDim2.new(0, 0, 0, 80)
RarityLabelFrame.BackgroundTransparency = 1
RarityLabelFrame.Parent = ContentFrame

local RarityLabel = Instance.new("TextLabel")
RarityLabel.Name = "RarityLabel"
RarityLabel.Size = UDim2.new(1, 0, 1, 0)
RarityLabel.BackgroundTransparency = 1
RarityLabel.Text = "Choose Rarity:"
RarityLabel.TextColor3 = colors.text
RarityLabel.TextSize = 18
RarityLabel.Font = Enum.Font.GothamBold
RarityLabel.TextXAlignment = Enum.TextXAlignment.Left
RarityLabel.Parent = RarityLabelFrame

local RarityFrame = Instance.new("Frame")
RarityFrame.Name = "RarityFrame"
RarityFrame.Size = UDim2.new(1, 0, 0, 50)
RarityFrame.Position = UDim2.new(0, 0, 0, 110)
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
    button.TextSize = 20
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
PetLabelFrame.Size = UDim2.new(1, 0, 0, 30)
PetLabelFrame.Position = UDim2.new(0, 0, 0, 170)
PetLabelFrame.BackgroundTransparency = 1
PetLabelFrame.Parent = ContentFrame

local PetLabel = Instance.new("TextLabel")
PetLabel.Name = "PetLabel"
PetLabel.Size = UDim2.new(1, 0, 1, 0)
PetLabel.BackgroundTransparency = 1
PetLabel.Text = "Choose Pet:"
PetLabel.TextColor3 = colors.text
PetLabel.TextSize = 18
PetLabel.Font = Enum.Font.GothamBold
PetLabel.TextXAlignment = Enum.TextXAlignment.Left
PetLabel.Parent = PetLabelFrame

-- Pet Selection
local PetSelectionFrame = Instance.new("Frame")
PetSelectionFrame.Name = "PetSelectionFrame"
PetSelectionFrame.Size = UDim2.new(1, 0, 0, 50)
PetSelectionFrame.Position = UDim2.new(0, 0, 0, 200)
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
PetDropdown.TextSize = 20
PetDropdown.Font = Enum.Font.Gotham
PetDropdown.Parent = PetSelectionFrame

-- Dropdown arrow
local DropdownArrow = Instance.new("ImageLabel")
DropdownArrow.Name = "DropdownArrow"
DropdownArrow.Size = UDim2.new(0, 20, 0, 20)
DropdownArrow.Position = UDim2.new(1, -30, 0.5, 0)
DropdownArrow.AnchorPoint = Vector2.new(0.5, 0.5)
DropdownArrow.BackgroundTransparency = 1
DropdownArrow.Image = "rbxassetid://9074628624" -- Arrow icon
DropdownArrow.ImageColor3 = colors.text
DropdownArrow.Parent = PetSelectionFrame

-- Preview area
local PreviewFrame = Instance.new("Frame")
PreviewFrame.Name = "PreviewFrame"
PreviewFrame.Size = UDim2.new(1, 0, 0, 100)
PreviewFrame.Position = UDim2.new(0, 0, 0, 260)
PreviewFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
PreviewFrame.Parent = ContentFrame

local PreviewCorner = Instance.new("UICorner")
PreviewCorner.CornerRadius = UDim.new(0, 10)
PreviewCorner.Parent = PreviewFrame

local PreviewLabel = Instance.new("TextLabel")
PreviewLabel.Name = "PreviewLabel"
PreviewLabel.Size = UDim2.new(1, 0, 0, 30)
PreviewLabel.Position = UDim2.new(0, 0, 0, 5)
PreviewLabel.BackgroundTransparency = 1
PreviewLabel.Text = "Preview:"
PreviewLabel.TextColor3 = colors.text
PreviewLabel.TextSize = 16
PreviewLabel.Font = Enum.Font.GothamBold
PreviewLabel.Parent = PreviewFrame

-- Preview icon
local PreviewIcon = Instance.new("ImageLabel")
PreviewIcon.Name = "PreviewIcon"
PreviewIcon.Size = UDim2.new(0, 60, 0, 60)
PreviewIcon.Position = UDim2.new(0.5, 0, 0.5, 10)
PreviewIcon.AnchorPoint = Vector2.new(0.5, 0.5)
PreviewIcon.BackgroundTransparency = 1
PreviewIcon.Image = "rbxassetid://6843054184" -- Default owl icon
PreviewIcon.ImageColor3 = Color3.fromRGB(146, 102, 58)
PreviewIcon.Parent = PreviewFrame

-- Spawn Button (at the bottom)
local SpawnButton = Instance.new("TextButton")
SpawnButton.Name = "SpawnButton"
SpawnButton.Size = UDim2.new(0.8, 0, 0, 60)
SpawnButton.Position = UDim2.new(0.5, 0, 1, -70)
SpawnButton.AnchorPoint = Vector2.new(0.5, 0)
SpawnButton.BackgroundColor3 = colors.accent
SpawnButton.Text = "SPAWN PET"
SpawnButton.TextColor3 = colors.textDark
SpawnButton.TextSize = 24
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
StatusText.Size = UDim2.new(1, 0, 0, 20)
StatusText.Position = UDim2.new(0, 0, 1, -20)
StatusText.BackgroundTransparency = 1
StatusText.Text = "🐾 Pet Spawner • v2.0"
StatusText.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusText.TextSize = 14
StatusText.Font = Enum.Font.Gotham
StatusText.Parent = ContentFrame

-- Add pets dropdown (simulated)
local petList = {"Owl", "Shadow Dragon", "Frost Dragon", "Bat Dragon", "Giraffe", "Parrot", "Unicorn", "Turtle"}
local selectedPet = petList[1]

-- Update preview when pet or rarity changes
local function updatePreview()
    local petInfo = petData[selectedPet]
    if petInfo then
        PreviewIcon.Image = "rbxassetid://" .. string.match(petInfo.meshId, "%d+")
        
        -- Set colors based on rarity
        local primaryColor = petInfo.primaryColor
        local secondaryColor = petInfo.secondaryColor
        
        if selectedRarity.name == "NFR" then
            -- Make it neon-like for NFR
            primaryColor = Color3.fromRGB(
                math.min(primaryColor.R * 1.5 * 255, 255),
                math.min(primaryColor.G * 1.5 * 255, 255),
                math.min(primaryColor.B * 1.5 * 255, 255)
            )
        elseif selectedRarity.name == "MFR" then
            -- Make it even brighter for MFR
            primaryColor = Color3.fromRGB(
                math.min(primaryColor.R * 2 * 255, 255),
                math.min(primaryColor.G * 2 * 255, 255),
                math.min(primaryColor.B * 2 * 255, 255)
            )
        end
        
        PreviewIcon.ImageColor3 = primaryColor
    end
end

-- Dropdown functionality
local dropdownOpen = false
local DropdownContainer = Instance.new("Frame")
DropdownContainer.Name = "DropdownContainer"
DropdownContainer.Size = UDim2.new(1, 0, 0, 250)
DropdownContainer.Position = UDim2.new(0, 0, 1, 5)
DropdownContainer.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
DropdownContainer.Visible = false
DropdownContainer.ZIndex = 10
DropdownContainer.Parent = PetSelectionFrame

local DropdownCorner = Instance.new("UICorner")
DropdownCorner.CornerRadius = UDim.new(0, 10)
DropdownCorner.Parent = DropdownContainer

local DropdownScrollFrame = Instance.new("ScrollingFrame")
DropdownScrollFrame.Name = "DropdownScrollFrame"
DropdownScrollFrame.Size = UDim2.new(1, -10, 1, -10)
DropdownScrollFrame.Position = UDim2.new(0.5, 0, 0, 5)
DropdownScrollFrame.AnchorPoint = Vector2.new(0.5, 0)
DropdownScrollFrame.BackgroundTransparency = 1
DropdownScrollFrame.ScrollBarThickness = 6
DropdownScrollFrame.ScrollBarImageColor3 = colors.accent
DropdownScrollFrame.CanvasSize = UDim2.new(0, 0, 0, #petList * 40)
DropdownScrollFrame.ZIndex = 10
DropdownScrollFrame.Parent = DropdownContainer

-- Populate dropdown
local function populateDropdown()
    for i, petName in ipairs(petList) do
        local petOption = Instance.new("TextButton")
        petOption.Name = petName .. "Option"
        petOption.Size = UDim2.new(1, -10, 0, 40)
        petOption.Position = UDim2.new(0.5, 0, 0, (i-1) * 40 + 5)
        petOption.AnchorPoint = Vector2.new(0.5, 0)
        petOption.BackgroundColor3 = Color3.fromRGB(80, 80, 85)
        petOption.Text = petName
        petOption.TextColor3 = colors.text
        petOption.TextSize = 18
        petOption.Font = Enum.Font.Gotham
        petOption.ZIndex = 10
        petOption.Parent = DropdownScrollFrame
        
        local petOptionCorner = Instance.new("UICorner")
        petOptionCorner.CornerRadius = UDim.new(0, 8)
        petOptionCorner.Parent = petOption
        
        -- Icon for the pet
        local petIcon = Instance.new("ImageLabel")
        petIcon.Name = "PetIcon"
        petIcon.Size = UDim2.new(0, 25, 0, 25)
        petIcon.Position = UDim2.new(0, 10, 0.5, 0)
        petIcon.AnchorPoint = Vector2.new(0, 0.5)
        petIcon.BackgroundTransparency = 1
        petIcon.Image = "rbxassetid://" .. string.match(petData[petName].meshId, "%d+")
        petIcon.ImageColor3 = petData[petName].primaryColor
        petIcon.ZIndex = 10
        petIcon.Parent = petOption
        
        -- Click to select
        petOption.MouseButton1Click:Connect(function()
            selectedPet = petName
            PetDropdown.Text = petName
            dropdownOpen = false
            DropdownContainer.Visible = false
            DropdownArrow.Rotation = 0
            updatePreview()
        end)
        
        -- Hover effects
        petOption.MouseEnter:Connect(function()
            TweenService:Create(petOption, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 100, 105)}):Play()
        end)
        
        petOption.MouseLeave:Connect(function()
            TweenService:Create(petOption, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 85)}):Play()
        end)
    end
end

populateDropdown()

-- Toggle dropdown visibility
PetDropdown.MouseButton1Click:Connect(function()
    dropdownOpen = not dropdownOpen
    DropdownContainer.Visible = dropdownOpen
    DropdownArrow.Rotation = dropdownOpen and 180 or 0
end)

-- Close dropdown when clicking elsewhere
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local mousePos = UserInputService:GetMouseLocation()
        local dropdownFrame = PetSelectionFrame.AbsolutePosition
        local dropdownSize = PetSelectionFrame.AbsoluteSize
        local containerSize = DropdownContainer.AbsoluteSize
        
        local inFrame = mousePos.X >= dropdownFrame.X and
                       mousePos.X <= dropdownFrame.X + dropdownSize.X and
                       mousePos.Y >= dropdownFrame.Y and
                       mousePos.Y <= dropdownFrame.Y + dropdownSize.Y
                       
        local inContainer = dropdownOpen and
                           mousePos.X >= dropdownFrame.X and
                           mousePos.X <= dropdownFrame.X + dropdownSize.X and
                           mousePos.Y >= dropdownFrame.Y + dropdownSize.Y and
                           mousePos.Y <= dropdownFrame.Y + dropdownSize.Y + containerSize.Y
        
        if dropdownOpen and not inFrame and not inContainer then
            dropdownOpen = false
            DropdownContainer.Visible = false
            DropdownArrow.Rotation = 0
        end
    end
end)

-- Make UI draggable
local dragging = false
local dragInput, dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    MainPanel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainPanel.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Button hover effects
SpawnButton.MouseEnter:Connect(function()
    TweenService:Create(SpawnButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(colors.accent.R*1.1, colors.accent.G*1.1, colors.accent.B*1.1)}):Play()
    TweenService:Create(buttonGlow, TweenInfo.new(0.3), {ImageTransparency = 0.5}):Play()
end)

SpawnButton.MouseLeave:Connect(function()
    TweenService:Create(SpawnButton, TweenInfo.new(0.2), {BackgroundColor3 = colors.accent}):Play()
    TweenService:Create(buttonGlow, TweenInfo.new(0.3), {ImageTransparency = 0.7}):Play()
end)

-- Sparkle animation for MFR and NFR pets
local sparkleFrames = {}
local function createSparkleEffect(pet)
    for i = 1, 5 do
        local sparkle = Instance.new("ImageLabel")
        sparkle.Size = UDim2.new(0, math.random(10, 20), 0, math.random(10, 20))
        sparkle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        sparkle.BackgroundTransparency = 1
        sparkle.Image = "rbxassetid://6333823"  -- Sparkle image
        sparkle.ImageColor3 = selectedRarity.name == "MFR" and 
            Color3.fromHSV(math.random(), 0.8, 1) or  -- Rainbow for MFR
            Color3.fromRGB(255, 255, 255)  -- White for NFR
        sparkle.ImageTransparency = 0.4
        sparkle.ZIndex = 3
        sparkle.Parent = pet.PrimaryPart
        
        table.insert(sparkleFrames, sparkle)
    end
end

-- Function to create the pet
local activePets = {}

local function spawnPet()
    -- Visual feedback for button press
    TweenService:Create(SpawnButton, TweenInfo.new(0.1), {Size = UDim2.new(0.78, 0, 0, 56)}):Play()
    wait(0.1)
    TweenService:Create(SpawnButton, TweenInfo.new(0.1), {Size = UDim2.new(0.8, 0, 0, 60)}):Play()
    
    local petInfo = petData[selectedPet]
    if not petInfo then return end
    
    -- Create pet model
    local petModel = Instance.new("Model")
    petModel.Name = selectedPet .. "_" .. selectedRarity.name
    
    -- Create pet primary part (body)
    local primaryPart = Instance.new("Part")
    primaryPart.Name = "PrimaryPart"
    primaryPart.Size = Vector3.new(1, 1, 1)
    primaryPart.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0)
    primaryPart.Anchored = true
    primaryPart.CanCollide = false
    primaryPart.Transparency = 1  -- Make base part invisible
    primaryPart.Parent = petModel
    
    -- Set as primary part
    petModel.PrimaryPart = primaryPart
    
    -- Add special mesh
    local specialMesh = Instance.new("SpecialMesh")
    specialMesh.MeshId = petInfo.meshId
    specialMesh.Scale = petInfo.scale
    
    -- Set materials based on rarity
    if selectedRarity.name == "FR" then
        specialMesh.TextureId = ""  -- No texture, just color
    elseif selectedRarity.name == "NFR" then
        specialMesh.TextureId = ""  -- No texture, neon material
    elseif selectedRarity.name == "MFR" then
        specialMesh.TextureId = ""  -- No texture, neon material with special effects
    end
    
    -- Apply colors based on rarity
    local primaryColor = petInfo.primaryColor
    local secondaryColor = petInfo.secondaryColor
    
    if selectedRarity.name == "NFR" then
        primaryColor = Color3.fromRGB(
            math.min(primaryColor.R * 1.5 * 255, 255),
            math.min(primaryColor.G * 1.5 * 255, 255),
            math.min(primaryColor.B * 1.5 * 255, 255)
        )
    elseif selectedRarity.name == "MFR" then
        primaryColor = Color3.fromRGB(
            math.min(primaryColor.R * 2 * 255, 255),
            math.min(primaryColor.G * 2 * 255, 255),
            math.min(primaryColor.B * 2 * 255, 255)
        )
    end
    
    -- Create mesh part for visualization
    local meshPart = Instance.new("MeshPart")
    meshPart.Name = "Body"
    meshPart.Color = primaryColor
    meshPart.Material = (selectedRarity.name == "FR") and Enum.Material.Plastic or Enum.Material.Neon
    meshPart.Size = Vector3.new(1, 1, 1)  -- Will be adjusted by mesh scale
    meshPart.Position = primaryPart.Position
    meshPart.CanCollide = false
    meshPart.Transparency = 0.1
    meshPart.MeshId = petInfo.meshId
    meshPart.Parent = petModel
    
    -- If it's a neon or mega variant, create special effects
    if selectedRarity.name == "NFR" or selectedRarity.name == "MFR" then
        createSparkleEffect(petModel)
        
        -- Add point light
        local light = Instance.new("PointLight")
        light.Color = selectedRarity.name == "MFR" and Color3.fromRGB(255, 255, 255) or primaryColor
        light.Range = 8
        light.Brightness = 1
        light.Parent = petModel.PrimaryPart
        
        -- For MFR, animate rainbow colors
        if selectedRarity.name == "MFR" then
            spawn(function()
                local h, s, v = 0, 1, 1
                while petModel.Parent do
                    h = (h + 0.005) % 1
                    local rainbowColor = Color3.fromHSV(h, s, v)
                    light.Color = rainbowColor
                    meshPart.Color = Color3.fromRGB(
                        math.min(petInfo.primaryColor.R * 255 + rainbowColor.R * 100, 255),
                        math.min(petInfo.primaryColor.G * 255 + rainbowColor.G * 100, 255),
                        math.min(petInfo.primaryColor.B * 255 + rainbowColor.B * 100, 255)
                    )
                    
                    -- Update sparkle colors
                    for _, sparkle in ipairs(sparkleFrames) do
                        if math.random() < 0.1 then
                            sparkle.ImageColor3 = Color3.fromHSV(math.random(), 0.8, 1)
                        end
                    end
                    
                    RunService.RenderStepped:Wait()
                end
            end)
        end
    end
    
    -- Position pet above player
    petModel:SetPrimaryPartCFrame(CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0)))
    petModel.Parent = workspace
    
    -- Add to active pets table
    table.insert(activePets, petModel)
    
    -- Update status text
    StatusText.Text = "✨ " .. selectedRarity.name .. " " .. selectedPet .. " spawned!"
    
    -- Animation loop - make pet follow player
    spawn(function()
        local time = 0
        local amplitude = 0.5
        local frequency = 2 * math.pi / 4  -- Complete cycle in 4 seconds
        
        while petModel.Parent do
            time = time + 0.03 * petInfo.animationSpeed
            
            local targetPosition = LocalPlayer.Character.HumanoidRootPart.Position + 
                                    Vector3.new(
                                        math.cos(time) * 2,  -- Circle around player
                                        3 + math.sin(time * frequency) * amplitude,  -- Hover up and down
                                        math.sin(time) * 2   -- Circle around player
                                    )
            
            -- Look at player while circling
            local lookAt = (LocalPlayer.Character.HumanoidRootPart.Position - targetPosition).Unit
            local cf = CFrame.new(targetPosition, targetPosition + lookAt)
            
            -- Smooth movement
            petModel:SetPrimaryPartCFrame(cf)
            
            wait()
        end
    end)
    
    -- Apply animation to sparkles
    spawn(function()
        while petModel.Parent do
            for _, sparkle in ipairs(sparkleFrames) do
                if sparkle and sparkle.Parent then
                    sparkle.Position = UDim2.new(math.random(), 0, math.random(), 0)
                    sparkle.Rotation = math.random(0, 360)
                    
                    -- Fade in and out
                    TweenService:Create(sparkle, TweenInfo.new(0.5), {ImageTransparency = 0.2}):Play()
                    wait(0.5)
                    TweenService:Create(sparkle, TweenInfo.new(0.5), {ImageTransparency = 0.8}):Play()
                    wait(0.5)
                end
            end
            wait()
        end
    end)
    
    -- Limit to 3 pets at once
    if #activePets > 3 then
        local oldPet = table.remove(activePets, 1)
        if oldPet and oldPet.Parent then
            -- Fade out animation
            for _, child in pairs(oldPet:GetDescendants()) do
                if child:IsA("BasePart") then
                    TweenService:Create(child, TweenInfo.new(1), {Transparency = 1}):Play()
                elseif child:IsA("PointLight") then
                    TweenService:Create(child, TweenInfo.new(1), {Brightness = 0}):Play()
                end
            end
            
            wait(1)
            oldPet:Destroy()
        end
    end
end

-- Connect spawn button
SpawnButton.MouseButton1Click:Connect(spawnPet)

-- Initialize preview
updatePreview()

-- Notification when script loads
local NotificationFrame = Instance.new("Frame")
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Size = UDim2.new(0, 300, 0, 80)
NotificationFrame.Position = UDim2.new(0.5, 0, 0, -100)
NotificationFrame.AnchorPoint = Vector2.new(0.5, 0)
NotificationFrame.BackgroundColor3 = colors.primary
NotificationFrame.Parent = ScreenGui

local NotificationCorner = Instance.new("UICorner")
NotificationCorner.CornerRadius = UDim.new(0, 10)
NotificationCorner.Parent = NotificationFrame

local NotificationGradient = TitleGradient:Clone()
NotificationGradient.Parent = NotificationFrame

local NotificationLabel = Instance.new("TextLabel")
NotificationLabel.Name = "NotificationLabel"
NotificationLabel.Size = UDim2.new(1, -20, 1, 0)
NotificationLabel.Position = UDim2.new(0.5, 0, 0, 0)
NotificationLabel.AnchorPoint = Vector2.new(0.5, 0)
NotificationLabel.BackgroundTransparency = 1
NotificationLabel.Text = "✨ Pet Spawner v2.0 Loaded ✨\nEnhanced with preppy UI!"
NotificationLabel.TextColor3 = colors.text
NotificationLabel.TextSize = 18
NotificationLabel.Font = Enum.Font.GothamBold
NotificationLabel.Parent = NotificationFrame

-- Animate notification
TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, 0, 0, 20)}):Play()

spawn(function()
    wait(3)
    TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 0, -100)}):Play()
    wait(0.5)
    NotificationFrame:Destroy()
end)

-- Disclaimer in console
print("⚠️ NOTE: This script is for EDUCATIONAL PURPOSES ONLY")
print("🐾 Pet Spawner v2.0 loaded successfully")
print("✨ Enhanced with preppy UI and visual effects")
