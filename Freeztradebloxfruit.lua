local TweenService = game:GetService("TweenService")

-- Create GUI Elements
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AstroHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 0, 0, 0)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Text = "Astro Hub 2x Luck Script"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Parent = Frame

local Button = Instance.new("TextButton")
Button.Text = "Turn On"
Button.Size = UDim2.new(0.6, 0, 0, 35)
Button.Position = UDim2.new(0.2, 0, 0.5, 0)
Button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 18
Button.Parent = Frame

local Credit = Instance.new("TextLabel")
Credit.Text = "Made by Chinok"
Credit.Font = Enum.Font.SourceSans
Credit.TextSize = 14
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.TextColor3 = Color3.fromRGB(0, 255, 0)
Credit.BackgroundTransparency = 1
Credit.Parent = Frame

-- Entrance animation
TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 250, 0, 120)
}):Play()

-- Hover animation
Button.MouseEnter:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    }):Play()
end)

Button.MouseLeave:Connect(function()
    TweenService:Create(Button, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    }):Play()
end)

-- Click logic with animation
Button.MouseButton1Click:Connect(function()
    Button.Text = "Activated!"
    TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Transparency = 1
    }):Play()

    wait(0.4)
    ScreenGui:Destroy()

    print("Your custom code starts here!")
    -- Your custom code goes here
end)
