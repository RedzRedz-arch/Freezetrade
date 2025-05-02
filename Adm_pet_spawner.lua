-- Adopt Me Visual Pet Spawner (Client-side only)
-- By Claude - Works with Delta and other executors
-- This will only create pets visible to you

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Pets table to track spawned pets
local pets = {}
local isDragging = false
local guiVisible = true

-- Function to create a visual pet
local function createVisualPet(petType, petSize)
    -- Create the pet model
    local pet = Instance.new("Part")
    pet.Name = "VisualPet_" .. petType
    pet.Size = Vector3.new(petSize, petSize, petSize)
    pet.Anchored = false
    pet.CanCollide = false
    pet.Material = Enum.Material.SmoothPlastic
    pet.Transparency = 0.1
    
    -- Give the pet a color based on type
    if petType == "Dragon" then
        pet.BrickColor = BrickColor.new("Really red")
    elseif petType == "Unicorn" then
        pet.BrickColor = BrickColor.new("Pink")
    elseif petType == "Dog" then
        pet.BrickColor = BrickColor.new("Brown")
    elseif petType == "Cat" then
        pet.BrickColor = BrickColor.new("Black")
    elseif petType == "Golden" then
        pet.BrickColor = BrickColor.new("New Yeller")
        pet.Material = Enum.Material.Neon
    else
        pet.BrickColor = BrickColor.new("Bright blue") -- Default
    end
    
    -- Create head shape for the pet
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(petSize * 0.8, petSize * 0.8, petSize * 0.8)
    head.CanCollide = false
    head.BrickColor = pet.BrickColor
    head.Material = pet.Material
    head.Transparency = pet.Transparency
    
    -- Create welding constraint between parts
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = pet
    weld.Part1 = head
    weld.Parent = pet
    
    -- Add eyes
    local eye1 = Instance.new("Part")
    eye1.Name = "RightEye"
    eye1.Size = Vector3.new(petSize * 0.2, petSize * 0.2, petSize * 0.1)
    eye1.BrickColor = BrickColor.new("Really black")
    eye1.CanCollide = false
    eye1.Transparency = 0
    
    local eye2 = Instance.new("Part")
    eye2.Name = "LeftEye"
    eye2.Size = Vector3.new(petSize * 0.2, petSize * 0.2, petSize * 0.1)
    eye2.BrickColor = BrickColor.new("Really black")
    eye2.CanCollide = false
    eye2.Transparency = 0
    
    -- Add specific features based on pet type
    if petType == "Dragon" then
        -- Add wings
        local wing1 = Instance.new("Part")
        wing1.Name = "RightWing"
        wing1.Size = Vector3.new(0.2, petSize * 1.2, petSize * 1)
        wing1.BrickColor = BrickColor.new("Really red")
        wing1.CanCollide = false
        wing1.Transparency = 0.2
        
        local wing2 = Instance.new("Part")
        wing2.Name = "LeftWing"
        wing2.Size = Vector3.new(0.2, petSize * 1.2, petSize * 1)
        wing2.BrickColor = BrickColor.new("Really red")
        wing2.CanCollide = false
        wing2.Transparency = 0.2
        
        wing1.Parent = pet
        wing2.Parent = pet
        
        local wingWeld1 = Instance.new("WeldConstraint")
        wingWeld1.Part0 = pet
        wingWeld1.Part1 = wing1
        wingWeld1.Parent = pet
        
        local wingWeld2 = Instance.new("WeldConstraint")
        wingWeld2.Part0 = pet
        wingWeld2.Part1 = wing2
        wingWeld2.Parent = pet
        
        -- Position wings
        wing1.Position = pet.Position + Vector3.new(petSize * 0.7, 0, 0)
        wing2.Position = pet.Position + Vector3.new(-petSize * 0.7, 0, 0)
        
    elseif petType == "Unicorn" then
        -- Add horn
        local horn = Instance.new("Part")
        horn.Name = "Horn"
        horn.Shape = Enum.PartType.Cylinder
        horn.Size = Vector3.new(petSize * 0.8, petSize * 0.15, petSize * 0.15)
        horn.BrickColor = BrickColor.new("Institutional white")
        horn.Material = Enum.Material.Neon
        horn.CanCollide = false
        horn.Parent = head
        
        local hornWeld = Instance.new("WeldConstraint")
        hornWeld.Part0 = head
        hornWeld.Part1 = horn
        hornWeld.Parent = head
        
        -- Position and rotate horn
        horn.CFrame = CFrame.new(head.Position + Vector3.new(0, petSize * 0.5, -petSize * 0.1)) * CFrame.Angles(math.rad(-90), 0, 0)
    end
    
    -- Parent the head and eyes to the pet
    head.Parent = pet
    eye1.Parent = head
    eye2.Parent = head
    
    -- Position head and eyes relative to body
    head.Position = pet.Position + Vector3.new(0, petSize * 0.9, 0)
    eye1.Position = head.Position + Vector3.new(petSize * 0.25, petSize * 0.1, -petSize * 0.35)
    eye2.Position = head.Position + Vector3.new(-petSize * 0.25, petSize * 0.1, -petSize * 0.35)
    
    -- Weld eyes to head
    local weld1 = Instance.new("WeldConstraint")
    weld1.Part0 = head
    weld1.Part1 = eye1
    weld1.Parent = head
    
    local weld2 = Instance.new("WeldConstraint")
    weld2.Part0 = head
    weld2.Part1 = eye2
    weld2.Parent = head
    
    -- Make the pet float with a BodyVelocity
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.P = 1250
    bodyVelocity.Parent = pet
    
    -- Parent to workspace
    pet.Parent = workspace
    
    -- Initial position behind the player
    pet.Position = Character.HumanoidRootPart.Position - Character.HumanoidRootPart.CFrame.LookVector * 5
    
    -- Create a table to store information about this pet
    local petInfo = {
        model = pet,
        bodyVelocity = bodyVelocity,
        followOffset = Vector3.new(math.random(-2, 2), 2 + math.random() * 1.5, math.random(-2, 2)),
        bobPhase = math.random() * math.pi * 2, -- Random starting phase for bobbing motion
        bobSpeed = 3 + math.random() * 2, -- Random bob speed
        type = petType
    }
    
    -- Add to pets table
    table.insert(pets, petInfo)
    
    return petInfo
end

-- Function to update pet positions
local function updatePets(dt)
    for _, petInfo in ipairs(pets) do
        local pet = petInfo.model
        local bodyVelocity = petInfo.bodyVelocity
        
        if pet and pet.Parent and Character and Character:FindFirstChild("HumanoidRootPart") then
            -- Calculate target position with offset
            local targetPosition = Character.HumanoidRootPart.Position + petInfo.followOffset
            
            -- Add bobbing motion
            petInfo.bobPhase = (petInfo.bobPhase + dt * petInfo.bobSpeed) % (math.pi * 2)
            targetPosition = targetPosition + Vector3.new(0, math.sin(petInfo.bobPhase) * 0.3, 0)
            
            -- Calculate direction and distance
            local direction = (targetPosition - pet.Position)
            local distance = direction.Magnitude
            
            -- Set velocity proportional to distance (with a maximum speed)
            local maxSpeed = 10
            local speed = math.min(distance * 2, maxSpeed)
            if distance > 0.5 then
                bodyVelocity.Velocity = direction.Unit * speed
            else
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
            
            -- Make pets look at player
            if distance > 0.1 then
                local lookDirection = direction.Unit
                local lookCFrame = CFrame.lookAt(pet.Position, pet.Position + Vector3.new(lookDirection.X, 0, lookDirection.Z))
                pet.CFrame = CFrame.new(pet.Position) * (lookCFrame - lookCFrame.Position)
            end
            
            -- Animate wings or other parts if they exist
            if petInfo.type == "Dragon" then
                local rightWing = pet:FindFirstChild("RightWing")
                local leftWing = pet:FindFirstChild("LeftWing")
                
                if rightWing and leftWing then
                    local wingAngle = math.sin(petInfo.bobPhase) * 0.3
                    rightWing.CFrame = CFrame.new(rightWing.Position) * CFrame.Angles(0, 0, wingAngle)
                    leftWing.CFrame = CFrame.new(leftWing.Position) * CFrame.Angles(0, 0, -wingAngle)
                end
            end
        end
    end
end

-- Create UI
local function createUI()
    -- Check if UI already exists
    local existingUI = LocalPlayer.PlayerGui:FindFirstChild("VisualPetSpawnerGUI")
    if existingUI then
        existingUI:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VisualPetSpawnerGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = LocalPlayer.PlayerGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 200, 0, 280)
    MainFrame.Position = UDim2.new(0.85, -100, 0.5, -140)
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -50, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Text = "Visual Pet Spawner"
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.Parent = TopBar
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    CloseButton.BorderSizePixel = 0
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Text = "X"
    CloseButton.TextSize = 18
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TopBar
    
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.Text = "-"
    MinimizeButton.TextSize = 18
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = TopBar
    
    local PetContainer = Instance.new("Frame")
    PetContainer.Name = "PetContainer"
    PetContainer.Size = UDim2.new(1, 0, 1, -30)
    PetContainer.Position = UDim2.new(0, 0, 0, 30)
    PetContainer.BackgroundTransparency = 1
    PetContainer.Parent = MainFrame
    
    local PetScrollFrame = Instance.new("ScrollingFrame")
    PetScrollFrame.Name = "PetScrollFrame"
    PetScrollFrame.Size = UDim2.new(1, -10, 1, -10)
    PetScrollFrame.Position = UDim2.new(0, 5, 0, 5)
    PetScrollFrame.BackgroundTransparency = 1
    PetScrollFrame.ScrollBarThickness = 4
    PetScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be updated based on buttons
    PetScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    PetScrollFrame.Parent = PetContainer
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "UIListLayout"
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.Parent = PetScrollFrame
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 5)
    UIPadding.PaddingBottom = UDim.new(0, 5)
    UIPadding.PaddingLeft = UDim.new(0, 5)
    UIPadding.PaddingRight = UDim.new(0, 5)
    UIPadding.Parent = PetScrollFrame
    
    -- Pet type buttons
    local petTypes = {"Dragon", "Unicorn", "Dog", "Cat", "Golden"}
    
    for i, petType in ipairs(petTypes) do
        local Button = Instance.new("TextButton")
        Button.Name = petType .. "Button"
        Button.Size = UDim2.new(1, -10, 0, 40)
        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Button.BorderColor3 = Color3.fromRGB(30, 30, 30)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Text = "Spawn " .. petType
        Button.TextSize = 16
        Button.Font = Enum.Font.Gotham
        Button.LayoutOrder = i
        Button.Parent = PetScrollFrame
        
        -- Create hover effect
        local ButtonHover = Instance.new("UICorner")
        ButtonHover.CornerRadius = UDim.new(0, 5)
        ButtonHover.Parent = Button
        
        -- Button click event
        Button.MouseButton1Click:Connect(function()
            local pet = createVisualPet(petType, 1.5)
            Button.Text = petType .. " Spawned!"
            
            spawn(function()
                wait(1)
                if Button and Button.Parent then
                    Button.Text = "Spawn " .. petType
                end
            end)
        end)
    end
    
    -- Create clear all button
    local ClearButton = Instance.new("TextButton")
    ClearButton.Name = "ClearButton"
    ClearButton.Size = UDim2.new(1, -10, 0, 40)
    ClearButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    ClearButton.BorderColor3 = Color3.fromRGB(150, 30, 30)
    ClearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ClearButton.Text = "Remove All Pets"
    ClearButton.TextSize = 16
    ClearButton.Font = Enum.Font.Gotham
    ClearButton.LayoutOrder = #petTypes + 1
    ClearButton.Parent = PetScrollFrame
    
    -- Create hover effect
    local ClearButtonHover = Instance.new("UICorner")
    ClearButtonHover.CornerRadius = UDim.new(0, 5)
    ClearButtonHover.Parent = ClearButton
    
    -- Update ScrollFrame Canvas Size
    PetScrollFrame.CanvasSize = UDim2.new(0, 0, 0, (#petTypes + 1) * 45)
    
    -- Button click events
    ClearButton.MouseButton1Click:Connect(function()
        for _, petInfo in ipairs(pets) do
            if petInfo.model and petInfo.model.Parent then
                petInfo.model:Destroy()
            end
        end
        pets = {}
        ClearButton.Text = "All Pets Removed"
        
        spawn(function()
            wait(1)
            if ClearButton and ClearButton.Parent then
                ClearButton.Text = "Remove All Pets"
            end
        end)
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        
        -- Stop updating pets
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end
        
        -- Clear pets
        for _, petInfo in ipairs(pets) do
            if petInfo.model and petInfo.model.Parent then
                petInfo.model:Destroy()
            end
        end
        pets = {}
    end)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        guiVisible = not guiVisible
        PetContainer.Visible = guiVisible
        MainFrame.Size = guiVisible and UDim2.new(0, 200, 0, 280) or UDim2.new(0, 200, 0, 30)
        MinimizeButton.Text = guiVisible and "-" or "+"
    end)
    
    -- Make TopBar draggable
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    TopBar.InputBegan:Connect(function(input)
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
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    return ScreenGui
end

-- Start updating pets
local updateConnection = RunService.Heartbeat:Connect(function(dt)
    updatePets(dt)
end)

-- Create UI
local ui = createUI()

-- Print success message
print("Adopt Me Visual Pet Spawner loaded successfully!")
