-- Chinoks Hub Freeze Trade!
-- This is a Freeze Trade that when turn on it freeze player screen and make them auto accept!

local ChinoksHub = {}
ChinoksHub.Enabled = false
ChinoksHub.GUI = nil
ChinoksHub.Dragging = false
ChinoksHub.DragStart = nil
ChinoksHub.StartPos = nil

-- Colors and theme (premium dark look)
local Theme = {
    Background = Color3.fromRGB(15, 15, 25),     -- Dark background
    HeaderBar = Color3.fromRGB(30, 32, 45),      -- Slightly lighter for header
    ButtonOn = Color3.fromRGB(0, 162, 255),      -- Bright blue for buttons
    ButtonOff = Color3.fromRGB(70, 70, 90),      -- Muted for inactive
    Text = Color3.fromRGB(255, 255, 255),        -- White text
    SubText = Color3.fromRGB(180, 180, 190),     -- Slightly dimmed text
    Accent = Color3.fromRGB(255, 65, 65),        -- Red accent
    Borders = Color3.fromRGB(50, 50, 70)         -- Subtle borders
}

-- Create a smooth rounded button
local function CreateButton(parent, text, position, size, color)
    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(0, 100, 0, 40)
    button.Position = position or UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = color or Theme.ButtonOff
    button.Text = text
    button.TextColor3 = Theme.Text
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.Parent = parent
    
    -- Add rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    -- Add a subtle stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Borders
    stroke.Thickness = 1
    stroke.Parent = button
    
    -- Add hover effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(
            math.min(button.BackgroundColor3.R * 255 + 20, 255) / 255,
            math.min(button.BackgroundColor3.G * 255 + 20, 255) / 255,
            math.min(button.BackgroundColor3.B * 255 + 20, 255) / 255
        )
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = color or Theme.ButtonOff
    end)
    
    -- Add click effect
    button.MouseButton1Down:Connect(function()
        button:TweenSize(
            UDim2.new(button.Size.X.Scale, button.Size.X.Offset * 0.95, button.Size.Y.Scale, button.Size.Y.Offset * 0.95),
            "Out", "Quad", 0.1, true
        )
    end)
    
    button.MouseButton1Up:Connect(function()
        button:TweenSize(size or UDim2.new(0, 100, 0, 40), "Out", "Quad", 0.1, true)
    end)
    
    return button
end

-- Add a cool background effect
function ChinoksHub:AddBackgroundEffects(frame)
    -- Add some subtle stars in the background
    for i = 1, 30 do
        local star = Instance.new("Frame")
        star.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        star.BackgroundTransparency = math.random(40, 80) / 100
        star.BorderSizePixel = 0
        
        -- Random size (tiny)
        local size = math.random(1, 2)
        star.Size = UDim2.new(0, size, 0, size)
        
        -- Random position
        star.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
        star.Parent = frame
        
        -- Subtle twinkle animation
        spawn(function()
            while star.Parent do
                star.BackgroundTransparency = math.random(40, 80) / 100
                wait(math.random(1, 3))
            end
        end)
    end
end

-- Create the main compact UI
function ChinoksHub:CreateCompactUI()
    -- If UI already exists, destroy it
    if self.GUI then
        self.GUI:Destroy()
    end
    
    -- Create the ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ChinoksHubMobile"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Try to put it in CoreGui (works on exploits) but fall back to PlayerGui (works in Studio)
    local success, result = pcall(function()
        screenGui.Parent = game:GetService("CoreGui")
        return true
    end)
    
    if not success then
        screenGui.Parent = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
    end
    
    self.GUI = screenGui
    
    -- Create main frame - compact for mobile
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 250, 0, 220)
    mainFrame.Position = UDim2.new(0.5, -125, 0.3, 0)
    mainFrame.BackgroundColor3 = Theme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true -- Required for dragging on mobile
    mainFrame.Parent = screenGui
    
    -- Add rounded corners to main frame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    -- Add subtle drop shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5554236805"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.SliceScale = 1
    shadow.ZIndex = -1
    shadow.Parent = mainFrame
    
    -- Create header with title and close button
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 36)
    header.BackgroundColor3 = Theme.HeaderBar
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    -- Rounded corners for header
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 8)
    headerCorner.Parent = header
    
    -- Fix the bottom corners (make them square)
    local headerFix = Instance.new("Frame")
    headerFix.Size = UDim2.new(1, 0, 0, 10)
    headerFix.Position = UDim2.new(0, 0, 1, -10)
    headerFix.BackgroundColor3 = Theme.HeaderBar
    headerFix.BorderSizePixel = 0
    headerFix.ZIndex = 0
    headerFix.Parent = header
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -50, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "CHINOKS HUB"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = Theme.Text
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    -- Add a cool icon
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Position = UDim2.new(0, 15, 0.5, -10)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://6031225814" -- Lock icon
    icon.ImageColor3 = Theme.ButtonOn
    icon.Parent = title
    
    -- Adjust title position to make room for icon
    title.Position = UDim2.new(0, 45, 0, 0)
    
    -- Close button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 36, 0, 36)
    closeButton.Position = UDim2.new(1, -36, 0, 0)
    closeButton.BackgroundColor3 = Theme.Accent
    closeButton.Text = "X"
    closeButton.TextColor3 = Theme.Text
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 16
    closeButton.Parent = header
    
    -- Add rounded corners to close button
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 0)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        self.GUI = nil
    end)
    
    -- Content container
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -20, 1, -46)
    content.Position = UDim2.new(0, 10, 0, 36)
    content.BackgroundTransparency = 1
    content.Parent = mainFrame
    
    -- Feature title
    local featureTitle = Instance.new("TextLabel")
    featureTitle.Size = UDim2.new(1, 0, 0, 36)
    featureTitle.Position = UDim2.new(0, 0, 0, 10)
    featureTitle.BackgroundTransparency = 1
    featureTitle.Text = "FREEZE TRADE"
    featureTitle.Font = Enum.Font.GothamBold
    featureTitle.TextSize = 20
    featureTitle.TextColor3 = Theme.Text
    featureTitle.Parent = content
    
    -- Description text
    local description = Instance.new("TextLabel")
    description.Size = UDim2.new(1, 0, 0, 60)
    description.Position = UDim2.new(0, 0, 0, 50)
    description.BackgroundTransparency = 1
    description.Text = "This is a Freeze Trade that when turn on it freeze player screen and make them auto accept!
    "
    description.Font = Enum.Font.Gotham
    description.TextSize = 14
    description.TextWrapped = true
    description.TextColor3 = Theme.SubText
    description.Parent = content
    
    -- Toggle button
    local toggleButton = CreateButton(
        content,
        "OFF",
        UDim2.new(0.5, -50, 0, 120),
        UDim2.new(0, 100, 0, 40),
        Theme.ButtonOff
    )
    
    -- Make the entire UI draggable (mobile-friendly)
    self:MakeDraggable(mainFrame, header)
    
    -- Add subtle background effects
    self:AddBackgroundEffects(mainFrame)
    
    -- Toggle functionality
    toggleButton.MouseButton1Click:Connect(function()
        self.Enabled = not self.Enabled
        
        if self.Enabled then
            toggleButton.Text = "ON"
            toggleButton.BackgroundColor3 = Theme.ButtonOn
            
            -- Show effect notification
            self:ShowStatusEffect(true)
        else
            toggleButton.Text = "OFF"
            toggleButton.BackgroundColor3 = Theme.ButtonOff
            
            -- Hide effect notification
            self:ShowStatusEffect(false)
        end
    end)
    
    -- Add a minimize button to make it even more compact when needed
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 36, 0, 36)
    minimizeButton.Position = UDim2.new(1, -72, 0, 0)
    minimizeButton.BackgroundColor3 = Theme.HeaderBar
    minimizeButton.Text = "—"
    minimizeButton.TextColor3 = Theme.Text
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextSize = 16
    minimizeButton.Parent = header
    
    local isMinimized = false
    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        
        if isMinimized then
            content.Visible = false
            mainFrame:TweenSize(UDim2.new(0, 250, 0, 36), "Out", "Quad", 0.3, true)
            minimizeButton.Text = "+"
        else
            mainFrame:TweenSize(UDim2.new(0, 250, 0, 220), "Out", "Quad", 0.3, true)
            wait(0.3)
            content.Visible = true
            minimizeButton.Text = "—"
        end
    end)
    
    -- Add a watermark
    local watermark = Instance.new("TextLabel")
    watermark.Size = UDim2.new(1, 0, 0, 20)
    watermark.Position = UDim2.new(0, 0, 1, -20)
    watermark.BackgroundTransparency = 1
    watermark.Text = "Made by Chinoks © 2025"
    watermark.TextTransparency = 0.5
    watermark.Font = Enum.Font.Gotham
    watermark.TextSize = 11
    watermark.TextColor3 = Theme.SubText
    watermark.Parent = content
    
    return screenGui
end

-- Function to make an object draggable (mobile-friendly)
function ChinoksHub:MakeDraggable(gui, dragArea)
    -- For PC
    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self.Dragging = true
            self.DragStart = input.Position
            self.StartPos = gui.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    self.Dragging = false
                end
            end)
        end
    end)
    
    dragArea.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or 
            input.UserInputType == Enum.UserInputType.Touch) and self.Dragging then
            
            local delta = input.Position - self.DragStart
            gui.Position = UDim2.new(
                self.StartPos.X.Scale,
                self.StartPos.X.Offset + delta.X,
                self.StartPos.Y.Scale,
                self.StartPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- For mobile specifically - additional touch support
    dragArea.TouchPan:Connect(function(touchPositions, totalTranslation, velocity, state)
        if state == Enum.UserInputState.Begin then
            self.StartPos = gui.Position
        elseif state == Enum.UserInputState.Change then
            gui.Position = UDim2.new(
                self.StartPos.X.Scale,
                self.StartPos.X.Offset + totalTranslation.X,
                self.StartPos.Y.Scale,
                self.StartPos.Y.Offset + totalTranslation.Y
            )
        end
    end)
end

-- Show status effect at the top of the screen
function ChinoksHub:ShowStatusEffect(enabled)
    -- Remove existing status if any
    if self.StatusBar then
        self.StatusBar:Destroy()
        self.StatusBar = nil
    end
    
    if not enabled then return end
    
    -- Create status bar
    local statusBar = Instance.new("Frame")
    statusBar.Name = "StatusBar"
    statusBar.Size = UDim2.new(1, 0, 0, 30)
    statusBar.Position = UDim2.new(0, 0, 0, -30)
    statusBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    statusBar.BackgroundTransparency = 0.3
    statusBar.BorderSizePixel = 0
    statusBar.Parent = self.GUI
    
    -- Status text
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 1, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "CHINOKS FREEZE TRADE ACTIVE"
    statusText.Font = Enum.Font.GothamBold
    statusText.TextSize = 14
    statusText.TextColor3 = Theme.ButtonOn
    statusText.Parent = statusBar
    
    -- Slide in animation
    statusBar:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true)
    
    -- Store reference
    self.StatusBar = statusBar
    
    -- Pulse animation
    spawn(function()
        while self.StatusBar and self.StatusBar.Parent do
            statusText.TextColor3 = Theme.ButtonOn
            wait(0.5)
            statusText.TextColor3 = Theme.Accent
            wait(0.5)
        end
    end)
end

-- Initialize the hub
function ChinoksHub:Initialize()
    self:CreateCompactUI()
    
    -- Show a brief toast notification
    local success, _ = pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Chinoks Hub",
            Text = "Mobile UI Loaded!",
            Duration = 3
        })
    end)
    
    if not success then
        -- Fallback notification method
        local notification = Instance.new("Message")
        notification.Text = "Chinoks Hub Mobile Loaded!"
        notification.Parent = self.GUI
        wait(3)
        notification:Destroy()
    end
end

-- Run the hub
ChinoksHub:Initialize()

return ChinoksHub
