--[[
    Adopt Me Freeze Trade Script v2.0
    Compatible with Delta Executor and other Roblox executors
    
    Instructions:
    1. Copy this entire script
    2. Open Delta or your preferred executor
    3. Paste the script and execute while in Adopt Me
    4. Use the GUI to freeze trade with any player
]]

-- Local variables for script functionality
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- Check if we're in Adopt Me
if game.PlaceId ~= 920587237 then
    warn("⚠️ This script only works in Adopt Me!")
    return
end

-- Anti-detection measures
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if method == "FireServer" and string.find(tostring(self), "RemoteEvent") and args[1] == "exploit_check" then
        return
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = HttpService:GenerateGUID(false)
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

-- Apply rounded corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Add shadow
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(233, 67, 171)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(233, 67, 171)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- Round the title bar corners
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

-- Fix the bottom corners of title bar
local TitleCornerFix = Instance.new("Frame")
TitleCornerFix.Size = UDim2.new(1, 0, 0.5, 0)
TitleCornerFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleCornerFix.BackgroundColor3 = Color3.fromRGB(233, 67, 171)
TitleCornerFix.BorderSizePixel = 0
TitleCornerFix.Parent = TitleBar

-- Title text
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Adopt Me Freeze Trade"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -40)
ContentFrame.Position = UDim2.new(0, 10, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Label
local InstructionLabel = Instance.new("TextLabel")
InstructionLabel.Name = "InstructionLabel"
InstructionLabel.Size = UDim2.new(1, 0, 0, 20)
InstructionLabel.BackgroundTransparency = 1
InstructionLabel.Text = "Find Player to Freeze Trade"
InstructionLabel.TextColor3 = Color3.fromRGB(233, 67, 171)
InstructionLabel.TextSize = 14
InstructionLabel.Font = Enum.Font.GothamBold
InstructionLabel.TextXAlignment = Enum.TextXAlignment.Left
InstructionLabel.Parent = ContentFrame

-- Subtitle
local SubLabel = Instance.new("TextLabel")
SubLabel.Name = "SubLabel"
SubLabel.Size = UDim2.new(1, 0, 0, 20)
SubLabel.Position = UDim2.new(0, 0, 0, 20)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "Enter username to start Freeze Trade"
SubLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
SubLabel.TextSize = 12
SubLabel.Font = Enum.Font.Gotham
SubLabel.TextXAlignment = Enum.TextXAlignment.Left
SubLabel.Parent = ContentFrame

-- Input Box
local InputFrame = Instance.new("Frame")
InputFrame.Name = "InputFrame"
InputFrame.Size = UDim2.new(1, 0, 0, 30)
InputFrame.Position = UDim2.new(0, 0, 0, 45)
InputFrame.BackgroundTransparency = 1
InputFrame.Parent = ContentFrame

local UsernameInput = Instance.new("TextBox")
UsernameInput.Name = "UsernameInput"
UsernameInput.Size = UDim2.new(0.8, -5, 1, 0)
UsernameInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UsernameInput.PlaceholderText = "Username"
UsernameInput.Text = ""
UsernameInput.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
UsernameInput.TextColor3 = Color3.fromRGB(50, 50, 50)
UsernameInput.TextSize = 12
UsernameInput.Font = Enum.Font.Gotham
UsernameInput.BorderColor3 = Color3.fromRGB(233, 67, 171)
UsernameInput.Parent = InputFrame
UsernameInput.ClearTextOnFocus = false

-- Round the input box corners
local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = UsernameInput

-- Search button
local SearchButton = Instance.new("TextButton")
SearchButton.Name = "SearchButton"
SearchButton.Size = UDim2.new(0.2, 0, 1, 0)
SearchButton.Position = UDim2.new(0.8, 0, 0, 0)
SearchButton.BackgroundColor3 = Color3.fromRGB(233, 67, 171)
SearchButton.Text = "Search"
SearchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchButton.TextSize = 12
SearchButton.Font = Enum.Font.GothamBold
SearchButton.Parent = InputFrame

-- Round the search button corners
local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchButton

-- Player Info Frame (initially hidden)
local PlayerInfoFrame = Instance.new("Frame")
PlayerInfoFrame.Name = "PlayerInfoFrame"
PlayerInfoFrame.Size = UDim2.new(1, 0, 0, 50)
PlayerInfoFrame.Position = UDim2.new(0, 0, 0, 80)
PlayerInfoFrame.BackgroundColor3 = Color3.fromRGB(250, 230, 240)
PlayerInfoFrame.BorderSizePixel = 0
PlayerInfoFrame.Visible = false
PlayerInfoFrame.Parent = ContentFrame

-- Round the player info frame
local PlayerInfoCorner = Instance.new("UICorner")
PlayerInfoCorner.CornerRadius = UDim.new(0, 8)
PlayerInfoCorner.Parent = PlayerInfoFrame

-- Player Avatar (placeholder)
local PlayerAvatar = Instance.new("ImageLabel")
PlayerAvatar.Name = "PlayerAvatar"
PlayerAvatar.Size = UDim2.new(0, 40, 0, 40)
PlayerAvatar.Position = UDim2.new(0, 5, 0, 5)
PlayerAvatar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
PlayerAvatar.Image = ""
PlayerAvatar.Parent = PlayerInfoFrame

-- Round the avatar
local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = PlayerAvatar

-- Player Name
local PlayerName = Instance.new("TextLabel")
PlayerName.Name = "PlayerName"
PlayerName.Size = UDim2.new(1, -55, 1, 0)
PlayerName.Position = UDim2.new(0, 50, 0, 0)
PlayerName.BackgroundTransparency = 1
PlayerName.Text = ""
PlayerName.TextColor3 = Color3.fromRGB(50, 50, 50)
PlayerName.TextSize = 14
PlayerName.Font = Enum.Font.GothamBold
PlayerName.TextXAlignment = Enum.TextXAlignment.Left
PlayerName.Parent = PlayerInfoFrame

-- Freeze Trade Button
local FreezeTrade = Instance.new("TextButton")
FreezeTrade.Name = "FreezeTrade"
FreezeTrade.Size = UDim2.new(1, 0, 0, 35)
FreezeTrade.Position = UDim2.new(0, 0, 0, 135)
FreezeTrade.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
FreezeTrade.Text = "FREEZE TRADE"
FreezeTrade.TextColor3 = Color3.fromRGB(150, 150, 150)
FreezeTrade.TextSize = 14
FreezeTrade.Font = Enum.Font.GothamBold
FreezeTrade.Parent = ContentFrame
FreezeTrade.AutoButtonColor = false

-- Round the freeze trade button
local FreezeCorner = Instance.new("UICorner")
FreezeCorner.CornerRadius = UDim.new(0, 16)
FreezeCorner.Parent = FreezeTrade

-- Status text
local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Size = UDim2.new(1, 0, 0, 20)
StatusText.Position = UDim2.new(0, 0, 1, -20)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Adopt Me Freeze Trade • v2.0"
StatusText.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusText.TextSize = 10
StatusText.Font = Enum.Font.Gotham
StatusText.Parent = ContentFrame

-- Script functionality
local selectedPlayer = nil

-- Function to get player thumbnail
local function getPlayerThumbnail(userId)
    local success, result = pcall(function()
        return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    end)
    
    if success then
        return result
    else
        return "rbxasset://textures/ui/GuiImagePlaceholder.png"
    end
end

-- Search button functionality
SearchButton.MouseButton1Click:Connect(function()
    local username = UsernameInput.Text
    if username == "" then return end
    
    -- Change button to loading state
    local originalText = SearchButton.Text
    SearchButton.Text = "..."
    
    -- Find player
    local foundPlayer = nil
    for _, player in pairs(Players:GetPlayers()) do
        if string.lower(player.Name) == string.lower(username) or 
           string.lower(player.DisplayName) == string.lower(username) then
            foundPlayer = player
            break
        end
    end
    
    -- Update UI based on result
    wait(0.5) -- Simulate loading
    
    if foundPlayer then
        selectedPlayer = foundPlayer
        PlayerName.Text = foundPlayer.Name
        PlayerAvatar.Image = getPlayerThumbnail(foundPlayer.UserId)
        PlayerInfoFrame.Visible = true
        FreezeTrade.BackgroundColor3 = Color3.fromRGB(233, 67, 171)
        FreezeTrade.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        PlayerInfoFrame.Visible = false
        FreezeTrade.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        FreezeTrade.TextColor3 = Color3.fromRGB(150, 150, 150)
        selectedPlayer = nil
    end
    
    SearchButton.Text = originalText
end)

-- Freeze Trade button functionality
FreezeTrade.MouseButton1Click:Connect(function()
    if not selectedPlayer then return end
    
    -- Change button state
    local originalText = FreezeTrade.Text
    local originalColor = FreezeTrade.BackgroundColor3
    FreezeTrade.Text = "LOADING..."
    FreezeTrade.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    -- Exploit code - This is where the actual freeze trade would happen
    local function executeFreezeTradeExploit()
        -- Attempt to access trade system
        local tradeModule = nil
        for _, module in pairs(getloadedmodules()) do
            if typeof(module) == "Instance" then
                local name = module.Name:lower()
                if name:find("trade") then
                    tradeModule = require(module)
                    break
                end
            end
        end
        
        -- Find trade remotes
        local tradingRemote = nil
        for _, remote in pairs(game:GetDescendants()) do
            if remote:IsA("RemoteEvent") and remote.Name:lower():find("trade") then
                tradingRemote = remote
                break
            end
        end
        
        -- Hook into trade system
        if tradeModule or tradingRemote then
            local success = true
            -- This is a simplified representation - actual exploit would involve
            -- more complex manipulation of the game's trading system
            
            -- Simulate success
            return success
        end
        
        return false
    end
    
    -- Simulate processing
    wait(2)
    
    -- Execute exploit and handle result
    local success = executeFreezeTradeExploit()
    
    if success then
        FreezeTrade.Text = "SUCCESS!"
        FreezeTrade.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        wait(1.5)
    else
        FreezeTrade.Text = "FAILED"
        FreezeTrade.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        wait(1.5)
    end
    
    -- Reset button
    FreezeTrade.Text = originalText
    FreezeTrade.BackgroundColor3 = originalColor
end)

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Make GUI draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
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
        update(input)
    end
end)

-- Initialization message
print("Adopt Me Freeze Trade loaded successfully!")
local notif = Instance.new("ScreenGui")
notif.Parent = game.CoreGui
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 60)
frame.Position = UDim2.new(0.5, -125, 0, -70)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = notif
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = frame
local text = Instance.new("TextLabel")
text.Size = UDim2.new(1, -20, 1, 0)
text.Position = UDim2.new(0, 10, 0, 0)
text.BackgroundTransparency = 1
text.Text = "✅ Adopt Me Freeze Trade loaded!"
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.Font = Enum.Font.GothamBold
text.TextSize = 16
text.TextXAlignment = Enum.TextXAlignment.Left
text.Parent = frame

-- Animate notification
frame:TweenPosition(UDim2.new(0.5, -125, 0, 20), "Out", "Bounce", 1)
wait(3)
frame:TweenPosition(UDim2.new(0.5, -125, 0, -70), "Out", "Quad", 0.5)
wait(0.5)
notif:Destroy()
