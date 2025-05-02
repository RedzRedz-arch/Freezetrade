--[[
    chinoks Trade Script GUI
    Designed for Blox Fruits Executors
    Features: Modern UI, Drag-Inertia, Toggle, Blur, Shadows, Rainbow Credits
    Created by: [Your Name]
--]]

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Safe parent selection
local parentGui = (pcall(function() return game.CoreGui end) and game.CoreGui) or Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main UI Container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChinoksTradeGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = parentGui

-- UI Blur Effect
local blur = Instance.new("BlurEffect")
blur.Size = 6
blur.Enabled = true
blur.Parent = game.Lighting

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(400, 250)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundTransparency = 0.05
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- UICorner
local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 16)

-- Drop Shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.4
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.ZIndex = 0
shadow.Parent = MainFrame

-- Glow Effect
local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://4996891970"
glow.ImageColor3 = Color3.fromRGB(255, 80, 80)
glow.Size = UDim2.new(1, 50, 1, 50)
glow.Position = UDim2.new(0.5, -25, 0.5, -25)
glow.ZIndex = 1
glow.Parent = MainFrame

-- Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.fromOffset(160, 50)
ToggleButton.Position = UDim2.new(0.5, -80, 0.4, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.Text = "Turn On"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 20
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Parent = MainFrame

local toggleCorner = Instance.new("UICorner", ToggleButton)
toggleCorner.CornerRadius = UDim.new(0, 12)

-- Status Indicator
local StatusIndicator = Instance.new("Frame")
StatusIndicator.Size = UDim2.fromOffset(20, 20)
StatusIndicator.Position = UDim2.new(1, -30, 0.5, -10)
StatusIndicator.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
StatusIndicator.Parent = ToggleButton

local indicatorCorner = Instance.new("UICorner", StatusIndicator)
indicatorCorner.CornerRadius = UDim.new(1, 0)

-- Rainbow Credit Label
local CreditLabel = Instance.new("TextLabel")
CreditLabel.Text = "chinoks Trade Script"
CreditLabel.Size = UDim2.new(1, 0, 0, 30)
CreditLabel.Position = UDim2.new(0, 0, 1, -35)
CreditLabel.Font = Enum.Font.GothamSemibold
CreditLabel.TextScaled = true
CreditLabel.BackgroundTransparency = 1
CreditLabel.TextStrokeTransparency = 0.6
CreditLabel.Parent = MainFrame

-- Hidden version label
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Text = "v1.0.0"
VersionLabel.Size = UDim2.new(0, 0, 0, 0)
VersionLabel.Visible = false
VersionLabel.Parent = MainFrame

-- Close Button (Invisible)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.fromOffset(30, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = ""
CloseButton.Parent = MainFrame

-- Warning Popup
local WarningPopup = Instance.new("Frame")
WarningPopup.Size = UDim2.fromOffset(280, 120)
WarningPopup.Position = UDim2.new(0.5, -140, 0.5, -60)
WarningPopup.Visible = false
WarningPopup.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
WarningPopup.Parent = MainFrame

local wpCorner = Instance.new("UICorner", WarningPopup)
wpCorner.CornerRadius = UDim.new(0, 12)

local WarningIcon = Instance.new("ImageLabel")
WarningIcon.Image = "rbxassetid://7733960981"
WarningIcon.Size = UDim2.fromOffset(30, 30)
WarningIcon.Position = UDim2.new(0, 10, 0, 10)
WarningIcon.BackgroundTransparency = 1
WarningIcon.Parent = WarningPopup

local WarningTitle = Instance.new("TextLabel")
WarningTitle.Text = "Warning"
WarningTitle.Font = Enum.Font.GothamBold
WarningTitle.TextSize = 22
WarningTitle.TextColor3 = Color3.new(1, 0.3, 0.3)
WarningTitle.Position = UDim2.new(0, 50, 0, 10)
WarningTitle.Size = UDim2.new(1, -60, 0, 30)
WarningTitle.BackgroundTransparency = 1
WarningTitle.Parent = WarningPopup

local WarningMessage = Instance.new("TextLabel")
WarningMessage.Text = "Using this script might risk your account!"
WarningMessage.Font = Enum.Font.Gotham
WarningMessage.TextSize = 16
WarningMessage.TextWrapped = true
WarningMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
WarningMessage.Position = UDim2.new(0, 10, 0, 50)
WarningMessage.Size = UDim2.new(1, -20, 0, 60)
WarningMessage.BackgroundTransparency = 1
WarningMessage.Parent = WarningPopup

-- Rainbow Text Effect
task.spawn(function()
	while true do
		for hue = 0, 1, 0.01 do
			CreditLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
			RunService.RenderStepped:Wait()
		end
	end
end)

-- Dragging with Tween & Inertia
local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

RunService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		local goal = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = goal}):Play()
	end
end)

MainFrame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Toggle Logic
local isOn = false
ToggleButton.MouseButton1Click:Connect(function()
	isOn = not isOn
	ToggleButton.Text = isOn and "Turn Off" or "Turn On"
	StatusIndicator.BackgroundColor3 = isOn and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(80, 80, 80)
	WarningPopup.Visible = isOn
end)

-- Close Function
CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
	blur:Destroy()
end)
