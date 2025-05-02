-- Pet Spawner UI Demo
-- Educational purposes only - demonstrates UI creation techniques
-- This script DOES NOT actually spawn pets or modify the game

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")

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

-- Main container (semi-transparent modal)
local BackgroundFrame = Instance.new("Frame")
BackgroundFrame.Name = "BackgroundFrame"
BackgroundFrame.Size = UDim2.new(1, 0, 1, 0)
BackgroundFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BackgroundFrame.BackgroundTransparency = 0.3
BackgroundFrame.Parent = ScreenGui

-- Main UI Panel
local MainPanel = Instance.new("Frame")
MainPanel.Name = "MainPanel"
MainPanel.Size = UDim2.new(0.9, 0, 0.4, 0)
MainPanel.Position = UDim2.new(0.5, 0, 0.5, 0)
MainPanel.AnchorPoint = Vector2.new(0.5, 0.5)
MainPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainPanel.BorderSizePixel = 0
MainPanel.Parent = BackgroundFrame

-- Apply rounded corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainPanel

-- Title
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0.2, 0)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Pet Spawner"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 24
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = MainPanel

-- Rarity Selection
local RarityFrame = Instance.new("Frame")
RarityFrame.Name = "RarityFrame"
RarityFrame.Size = UDim2.new(1, -40, 0.25, 0)
RarityFrame.Position = UDim2.new(0.5, 0, 0.3, 0)
RarityFrame.AnchorPoint = Vector2.new(0.5, 0)
RarityFrame.BackgroundTransparency = 1
RarityFrame.Parent = MainPanel

-- Create rarity buttons
local rarities = {
    {name = "FR", color = Color3.fromRGB(255, 255, 255), textColor = Color3.fromRGB(0, 0, 0)},
    {name = "NFR", color = Color3.fromRGB(0, 200, 0), textColor = Color3.fromRGB(255, 255, 255)},
    {name = "MFR", color = Color3.fromRGB(200, 200, 200), textColor = Color3.fromRGB(0, 0, 0)}
}

local selectedRarity = rarities[2]

for i, rarity in ipairs(rarities) do
    local button = Instance.new("TextButton")
    button.Name = rarity.name .. "Button"
    button.Size = UDim2.new(0.33, -10, 1, 0)
    button.Position = UDim2.new((i-1) * 0.33 + 0.165, 0, 0, 0)
    button.AnchorPoint = Vector2.new(0.5, 0)
    button.BackgroundColor3 = i == 2 and rarity.color or Color3.fromRGB(40, 40, 40)
    button.Text = rarity.name
    button.TextColor3 = i == 2 and rarity.textColor or Color3.fromRGB(200, 200, 200)
    button.TextSize = 18
    button.Font = Enum.Font.GothamBold
    button.Parent = RarityFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        -- Update visual selection
        for j, r in ipairs(rarities) do
            local otherButton = RarityFrame:FindFirstChild(r.name .. "Button")
            if otherButton then
                otherButton.BackgroundColor3 = r == rarity and r.color or Color3.fromRGB(40, 40, 40)
                otherButton.TextColor3 = (r == rarity and r.textColor) or Color3.fromRGB(200, 200, 200)
            end
        end
        selectedRarity = rarity
    end)
end

-- Pet Selection
local PetSelectionFrame = Instance.new("Frame")
PetSelectionFrame.Name = "PetSelectionFrame"
PetSelectionFrame.Size = UDim2.new(1, -40, 0.25, 0)
PetSelectionFrame.Position = UDim2.new(0.5, 0, 0.55, 0)
PetSelectionFrame.AnchorPoint = Vector2.new(0.5, 0)
PetSelectionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PetSelectionFrame.Parent = MainPanel

local PetSelectionCorner = Instance.new("UICorner")
PetSelectionCorner.CornerRadius = UDim.new(0, 6)
PetSelectionCorner.Parent = PetSelectionFrame

local PetDropdown = Instance.new("TextButton")
PetDropdown.Name = "PetDropdown"
PetDropdown.Size = UDim2.new(1, 0, 1, 0)
PetDropdown.BackgroundTransparency = 1
PetDropdown.Text = "Owl"
PetDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
PetDropdown.TextSize = 18
PetDropdown.Font = Enum.Font.Gotham
PetDropdown.Parent = PetSelectionFrame

-- Spawn Button
local SpawnButton = Instance.new("TextButton")
SpawnButton.Name = "SpawnButton"
SpawnButton.Size = UDim2.new(0.5, 0, 0.15, 0)
SpawnButton.Position = UDim2.new(0.5, 0, 0.8, 0)
SpawnButton.AnchorPoint = Vector2.new(0.5, 0)
SpawnButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpawnButton.Text = "Spawn"
SpawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpawnButton.TextSize = 18
SpawnButton.Font = Enum.Font.GothamBold
SpawnButton.Parent = MainPanel

local SpawnButtonCorner = Instance.new("UICorner")
SpawnButtonCorner.CornerRadius = UDim.new(0, 6)
SpawnButtonCorner.Parent = SpawnButton

-- Add spawn icon
local SpawnIcon = Instance.new("ImageLabel")
SpawnIcon.Name = "SpawnIcon"
SpawnIcon.Size = UDim2.new(0, 30, 0, 30)
SpawnIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
SpawnIcon.AnchorPoint = Vector2.new(0.5, 0.5)
SpawnIcon.BackgroundTransparency = 1
SpawnIcon.Image = "rbxassetid://6031302945" -- Generic plus icon
SpawnIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
SpawnIcon.Parent = SpawnButton

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, 10, 0, -10)
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = MainPanel

local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.CornerRadius = UDim.new(1, 0)
CloseButtonCorner.Parent = CloseButton

-- Add pets dropdown (simulated)
local petList = {"Owl", "Shadow Dragon", "Frost Dragon", "Bat Dragon", "Giraffe", "Parrot", "Crow", "Evil Unicorn"}
local selectedPet = petList[1]

-- Dropdown functionality
local dropdownOpen = false
local DropdownContainer = Instance.new("Frame")
DropdownContainer.Name = "DropdownContainer"
DropdownContainer.Size = UDim2.new(1, 0, #petList * 0.5, 0)
DropdownContainer.Position = UDim2.new(0, 0, 1, 5)
DropdownContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
DropdownContainer.Visible = false
DropdownContainer.ZIndex = 10
DropdownContainer.Parent = PetSelectionFrame

local DropdownContainerCorner = Instance.new("UICorner")
DropdownContainerCorner.CornerRadius = UDim.new(0, 6)
DropdownContainerCorner.Parent = DropdownContainer

-- Populate dropdown
for i, pet in ipairs(petList) do
    local option = Instance.new("TextButton")
    option.Name = pet .. "Option"
    option.Size = UDim2.new(1, 0, 1/#petList, 0)
    option.Position = UDim2.new(0, 0, (i-1)/#petList, 0)
    option.BackgroundTransparency = 0.9
    option.Text = pet
    option.TextColor3 = Color3.fromRGB(255, 255, 255)
    option.TextSize = 16
    option.Font = Enum.Font.Gotham
    option.ZIndex = 11
    option.Parent = DropdownContainer
    
    -- Add hover effect
    option.MouseEnter:Connect(function()
        option.BackgroundTransparency = 0.5
    end)
    
    option.MouseLeave:Connect(function()
        option.BackgroundTransparency = 0.9
    end)
    
    -- Selection
    option.MouseButton1Click:Connect(function()
        selectedPet = pet
        PetDropdown.Text = pet
        DropdownContainer.Visible = false
        dropdownOpen = false
    end)
end

-- Toggle dropdown
PetDropdown.MouseButton1Click:Connect(function()
    dropdownOpen = not dropdownOpen
    DropdownContainer.Visible = dropdownOpen
end)

-- Close dropdown when clicking elsewhere
BackgroundFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        if dropdownOpen then
            DropdownContainer.Visible = false
            dropdownOpen = false
        end
    end
end)

-- Spawn button functionality (simulation only)
SpawnButton.MouseButton1Click:Connect(function()
    -- Visual feedback
    local originalColor = SpawnButton.BackgroundColor3
    SpawnButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    
    -- Show feedback notification
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 200, 0, 50)
    notification.Position = UDim2.new(0.5, 0, 0.8, 0)
    notification.AnchorPoint = Vector2.new(0.5, 0)
    notification.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    notification.BorderSizePixel = 0
    notification.Parent = ScreenGui
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 8)
    notifCorner.Parent = notification
    
    local notifText = Instance.new("TextLabel")
    notifText.Size = UDim2.new(1, 0, 1, 0)
    notifText.BackgroundTransparency = 1
    notifText.Text = "🔍 This is just a UI demo\nNo pets were actually spawned"
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.TextSize = 14
    notifText.Font = Enum.Font.Gotham
    notifText.Parent = notification
    
    -- Animate notification
    notification.Position = UDim2.new(0.5, 0, 1.1, 0)
    TweenService:Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, 0, 0.8, 0)}):Play()
    
    -- Reset button after delay
    wait(0.5)
    SpawnButton.BackgroundColor3 = originalColor
    
    -- Remove notification after delay
    wait(3)
    TweenService:Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, 0, 1.1, 0)}):Play()
    wait(0.5)
    notification:Destroy()
end)

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Make UI draggable for both mobile and PC
local dragging = false
local dragInput
local dragStart
local startPos

-- Better dragging that works on both mobile and PC
local function updateDrag(input)
    local delta = input.Position - dragStart
    TweenService:Create(MainPanel, TweenInfo.new(0.1), {
        Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    }):Play()
end

MainPanel.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or 
        input.UserInputType == Enum.UserInputType.Touch) and 
        not dropdownOpen then
        
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

MainPanel.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or
        input.UserInputType == Enum.UserInputType.Touch) and dragging then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Show loader notification
local function showLoaderNotification()
    local loaderNotif = Instance.new("Frame")
    loaderNotif.Name = "LoaderNotification"
    loaderNotif.Size = UDim2.new(0, 250, 0, 60)
    loaderNotif.Position = UDim2.new(0.5, 0, 0.9, 0)
    loaderNotif.AnchorPoint = Vector2.new(0.5, 0.5)
    loaderNotif.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    loaderNotif.BorderSizePixel = 0
    loaderNotif.Parent = ScreenGui
    
    local loaderCorner = Instance.new("UICorner")
    loaderCorner.CornerRadius = UDim.new(0, 8)
    loaderCorner.Parent = loaderNotif
    
    local loaderText = Instance.new("TextLabel")
    loaderText.Size = UDim2.new(1, -20, 1, 0)
    loaderText.Position = UDim2.new(0, 10, 0, 0)
    loaderText.BackgroundTransparency = 1
    loaderText.Text = "✓ Pet Spawner UI Loaded\nThis is a demonstration UI only"
    loaderText.TextColor3 = Color3.fromRGB(255, 255, 255)
    loaderText.TextSize = 14
    loaderText.Font = Enum.Font.GothamBold
    loaderText.TextXAlignment = Enum.TextXAlignment.Left
    loaderText.Parent = loaderNotif
    
    -- Auto remove after 5 seconds
    wait(5)
    loaderNotif:Destroy()
end

-- Show initial notification
showLoaderNotification()

-- Note: This script is for educational purposes only and doesn't include any actual 
-- exploit functionality. It demonstrates UI creation techniques in Roblox Lua.
