local Converted = {
	["_ExploitGui"] = Instance.new("ScreenGui");
	["_Frame"] = Instance.new("Frame");
	["_UIStroke"] = Instance.new("UIStroke");
	["_UIGradient"] = Instance.new("UIGradient");
	["_LocalScript"] = Instance.new("LocalScript");
	["_Jumppower"] = Instance.new("TextBox");
	["_LocalScript1"] = Instance.new("LocalScript");
	["_UIStroke1"] = Instance.new("UIStroke");
	["_UIGradient1"] = Instance.new("UIGradient");
	["_LocalScript2"] = Instance.new("LocalScript");
	["_Jumppower Text"] = Instance.new("TextLabel");
	["_Walkspeed Text"] = Instance.new("TextLabel");
	["_Walkspeed"] = Instance.new("TextBox");
	["_LocalScript3"] = Instance.new("LocalScript");
	["_UIStroke2"] = Instance.new("UIStroke");
	["_UIGradient2"] = Instance.new("UIGradient");
	["_LocalScript4"] = Instance.new("LocalScript");
	["_Separator"] = Instance.new("TextLabel");
	["_Separator1"] = Instance.new("TextLabel");
	["_TextLabel"] = Instance.new("TextLabel");
	["_Separator2"] = Instance.new("TextLabel");
	["_Pet Spawner"] = Instance.new("TextButton");
	["_LocalScript5"] = Instance.new("LocalScript");
	["_UIStroke3"] = Instance.new("UIStroke");
	["_UIGradient3"] = Instance.new("UIGradient");
	["_LocalScript6"] = Instance.new("LocalScript");
	["_LocalScript7"] = Instance.new("LocalScript");
}

Converted["_ExploitGui"].ResetOnSpawn = false
Converted["_ExploitGui"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Converted["_ExploitGui"].Name = "ExploitGui"
Converted["_ExploitGui"].Parent = game:GetService("CoreGui")

Converted["_Frame"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Frame"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame"].BorderSizePixel = 0
Converted["_Frame"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Frame"].Size = UDim2.new(0, 500, 0, 300)
Converted["_Frame"].Parent = Converted["_ExploitGui"]

Converted["_UIStroke"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke"].Thickness = 4
Converted["_UIStroke"].Parent = Converted["_Frame"]

Converted["_UIGradient"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(0.11245675384998322, Color3.fromRGB(255, 157.0000058412552, 0)),
	ColorSequenceKeypoint.new(0.22491350769996643, Color3.fromRGB(255, 255, 1.0000000591389835)),
	ColorSequenceKeypoint.new(0.3581314980983734, Color3.fromRGB(255, 255, 31.935899332165718)),
	ColorSequenceKeypoint.new(0.5121107697486877, Color3.fromRGB(55.00000052154064, 255, 0)),
	ColorSequenceKeypoint.new(0.6522491574287415, Color3.fromRGB(0, 38.0000015348196, 255)),
	ColorSequenceKeypoint.new(0.8166090250015259, Color3.fromRGB(162.00000554323196, 0, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 221.00000202655792))
}
Converted["_UIGradient"].Parent = Converted["_UIStroke"]

Converted["_Jumppower"].CursorPosition = -1
Converted["_Jumppower"].Font = Enum.Font.FredokaOne
Converted["_Jumppower"].Text = ""
Converted["_Jumppower"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Jumppower"].TextScaled = true
Converted["_Jumppower"].TextSize = 14
Converted["_Jumppower"].TextWrapped = true
Converted["_Jumppower"].BackgroundColor3 = Color3.fromRGB(38.0000015348196, 38.0000015348196, 38.0000015348196)
Converted["_Jumppower"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Jumppower"].BorderSizePixel = 0
Converted["_Jumppower"].Position = UDim2.new(0.5, 0, 0.773333311, 0)
Converted["_Jumppower"].Size = UDim2.new(0, 200, 0, 50)
Converted["_Jumppower"].Name = "Jumppower"
Converted["_Jumppower"].Parent = Converted["_Frame"]

Converted["_UIStroke1"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Converted["_UIStroke1"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke1"].Thickness = 2.5
Converted["_UIStroke1"].Parent = Converted["_Jumppower"]

Converted["_UIGradient1"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(0.11245675384998322, Color3.fromRGB(255, 157.0000058412552, 0)),
	ColorSequenceKeypoint.new(0.22491350769996643, Color3.fromRGB(255, 255, 1.0000000591389835)),
	ColorSequenceKeypoint.new(0.3581314980983734, Color3.fromRGB(255, 255, 31.935899332165718)),
	ColorSequenceKeypoint.new(0.5121107697486877, Color3.fromRGB(55.00000052154064, 255, 0)),
	ColorSequenceKeypoint.new(0.6522491574287415, Color3.fromRGB(0, 38.0000015348196, 255)),
	ColorSequenceKeypoint.new(0.8166090250015259, Color3.fromRGB(162.00000554323196, 0, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 221.00000202655792))
}
Converted["_UIGradient1"].Parent = Converted["_UIStroke1"]

Converted["_Jumppower Text"].Font = Enum.Font.FredokaOne
Converted["_Jumppower Text"].Text = "Jumppower Modifier"
Converted["_Jumppower Text"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Jumppower Text"].TextScaled = true
Converted["_Jumppower Text"].TextSize = 14
Converted["_Jumppower Text"].TextWrapped = true
Converted["_Jumppower Text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Jumppower Text"].BackgroundTransparency = 1
Converted["_Jumppower Text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Jumppower Text"].BorderSizePixel = 0
Converted["_Jumppower Text"].Position = UDim2.new(0.0219999999, 0, 0.773333311, 0)
Converted["_Jumppower Text"].Size = UDim2.new(0, 200, 0, 50)
Converted["_Jumppower Text"].Name = "Jumppower Text"
Converted["_Jumppower Text"].Parent = Converted["_Frame"]

Converted["_Walkspeed Text"].Font = Enum.Font.FredokaOne
Converted["_Walkspeed Text"].Text = "Walkspeed Modifier"
Converted["_Walkspeed Text"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Walkspeed Text"].TextScaled = true
Converted["_Walkspeed Text"].TextSize = 14
Converted["_Walkspeed Text"].TextWrapped = true
Converted["_Walkspeed Text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Walkspeed Text"].BackgroundTransparency = 1
Converted["_Walkspeed Text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Walkspeed Text"].BorderSizePixel = 0
Converted["_Walkspeed Text"].Position = UDim2.new(0.0219999999, 0, 0.543333352, 0)
Converted["_Walkspeed Text"].Size = UDim2.new(0, 200, 0, 50)
Converted["_Walkspeed Text"].Name = "Walkspeed Text"
Converted["_Walkspeed Text"].Parent = Converted["_Frame"]

Converted["_Walkspeed"].CursorPosition = -1
Converted["_Walkspeed"].Font = Enum.Font.FredokaOne
Converted["_Walkspeed"].Text = ""
Converted["_Walkspeed"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Walkspeed"].TextScaled = true
Converted["_Walkspeed"].TextSize = 14
Converted["_Walkspeed"].TextWrapped = true
Converted["_Walkspeed"].BackgroundColor3 = Color3.fromRGB(38.0000015348196, 38.0000015348196, 38.0000015348196)
Converted["_Walkspeed"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Walkspeed"].BorderSizePixel = 0
Converted["_Walkspeed"].Position = UDim2.new(0.5, 0, 0.543333352, 0)
Converted["_Walkspeed"].Size = UDim2.new(0, 200, 0, 50)
Converted["_Walkspeed"].Name = "Walkspeed"
Converted["_Walkspeed"].Parent = Converted["_Frame"]

Converted["_UIStroke2"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Converted["_UIStroke2"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke2"].Thickness = 2.5
Converted["_UIStroke2"].Parent = Converted["_Walkspeed"]

Converted["_UIGradient2"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(0.11245675384998322, Color3.fromRGB(255, 157.0000058412552, 0)),
	ColorSequenceKeypoint.new(0.22491350769996643, Color3.fromRGB(255, 255, 1.0000000591389835)),
	ColorSequenceKeypoint.new(0.3581314980983734, Color3.fromRGB(255, 255, 31.935899332165718)),
	ColorSequenceKeypoint.new(0.5121107697486877, Color3.fromRGB(55.00000052154064, 255, 0)),
	ColorSequenceKeypoint.new(0.6522491574287415, Color3.fromRGB(0, 38.0000015348196, 255)),
	ColorSequenceKeypoint.new(0.8166090250015259, Color3.fromRGB(162.00000554323196, 0, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 221.00000202655792))
}
Converted["_UIGradient2"].Parent = Converted["_UIStroke2"]

Converted["_Separator"].Font = Enum.Font.SourceSans
Converted["_Separator"].Text = "------------------------------------------------"
Converted["_Separator"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Separator"].TextScaled = true
Converted["_Separator"].TextSize = 14
Converted["_Separator"].TextWrapped = true
Converted["_Separator"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Separator"].BackgroundTransparency = 1
Converted["_Separator"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Separator"].BorderSizePixel = 0
Converted["_Separator"].Position = UDim2.new(0.00200000009, 0, 0.396666676, 0)
Converted["_Separator"].Size = UDim2.new(0, 499, 0, 50)
Converted["_Separator"].Name = "Separator"
Converted["_Separator"].Parent = Converted["_Frame"]

Converted["_Separator1"].Font = Enum.Font.SourceSans
Converted["_Separator1"].Text = "--------------------"
Converted["_Separator1"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Separator1"].TextScaled = true
Converted["_Separator1"].TextSize = 14
Converted["_Separator1"].TextWrapped = true
Converted["_Separator1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Separator1"].BackgroundTransparency = 1
Converted["_Separator1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Separator1"].BorderSizePixel = 0
Converted["_Separator1"].Position = UDim2.new(0.00999999978, 0, 0.649999976, 0)
Converted["_Separator1"].Size = UDim2.new(0, 211, 0, 50)
Converted["_Separator1"].Name = "Separator"
Converted["_Separator1"].Parent = Converted["_Frame"]

Converted["_TextLabel"].Font = Enum.Font.FredokaOne
Converted["_TextLabel"].Text = "Adopt Me Pet Spawner Script"
Converted["_TextLabel"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel"].TextScaled = true
Converted["_TextLabel"].TextSize = 14
Converted["_TextLabel"].TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel"].TextWrapped = true
Converted["_TextLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel"].BackgroundTransparency = 1
Converted["_TextLabel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel"].BorderSizePixel = 0
Converted["_TextLabel"].Size = UDim2.new(0, 500, 0, 45)
Converted["_TextLabel"].Parent = Converted["_Frame"]

Converted["_Separator2"].Font = Enum.Font.SourceSans
Converted["_Separator2"].Text = "------------------------------------------------"
Converted["_Separator2"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Separator2"].TextScaled = true
Converted["_Separator2"].TextSize = 14
Converted["_Separator2"].TextWrapped = true
Converted["_Separator2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Separator2"].BackgroundTransparency = 1
Converted["_Separator2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Separator2"].BorderSizePixel = 0
Converted["_Separator2"].Position = UDim2.new(0, 0, 0.0833333358, 0)
Converted["_Separator2"].Size = UDim2.new(0, 499, 0, 50)
Converted["_Separator2"].Name = "Separator"
Converted["_Separator2"].Parent = Converted["_Frame"]

Converted["_Pet Spawner"].Font = Enum.Font.FredokaOne
Converted["_Pet Spawner"].Text = "Pet Spawner"
Converted["_Pet Spawner"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Pet Spawner"].TextSize = 31
Converted["_Pet Spawner"].TextWrapped = true
Converted["_Pet Spawner"].BackgroundColor3 = Color3.fromRGB(38.0000015348196, 38.0000015348196, 38.0000015348196)
Converted["_Pet Spawner"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Pet Spawner"].BorderSizePixel = 0
Converted["_Pet Spawner"].Position = UDim2.new(0.300000012, 0, 0.25, 0)
Converted["_Pet Spawner"].Size = UDim2.new(0, 200, 0, 50)
Converted["_Pet Spawner"].Name = "Pet Spawner"
Converted["_Pet Spawner"].Parent = Converted["_Frame"]

Converted["_UIStroke3"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Converted["_UIStroke3"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke3"].Thickness = 2.5
Converted["_UIStroke3"].Parent = Converted["_Pet Spawner"]

Converted["_UIGradient3"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(0.11245675384998322, Color3.fromRGB(255, 157.0000058412552, 0)),
	ColorSequenceKeypoint.new(0.22491350769996643, Color3.fromRGB(255, 255, 1.0000000591389835)),
	ColorSequenceKeypoint.new(0.3581314980983734, Color3.fromRGB(255, 255, 31.935899332165718)),
	ColorSequenceKeypoint.new(0.5121107697486877, Color3.fromRGB(55.00000052154064, 255, 0)),
	ColorSequenceKeypoint.new(0.6522491574287415, Color3.fromRGB(0, 38.0000015348196, 255)),
	ColorSequenceKeypoint.new(0.8166090250015259, Color3.fromRGB(162.00000554323196, 0, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 221.00000202655792))
}
Converted["_UIGradient3"].Parent = Converted["_UIStroke3"]

local fake_module_scripts = {}

local function RJHUIUZ_fake_script() -- Fake Script: StarterGui.ExploitGui.Frame.UIStroke.UIGradient.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_UIGradient"]
    local req = require
    local require = function(obj)
        local fake = fake_module_scripts[obj]
        if fake then
            return fake()
        end
        return req(obj)
    end

	local UIGradient = script.parent
	while true do
		UIGradient.Rotation += 1
		wait()
	end
end
local function RRQGGNW_fake_script() -- Fake Script: StarterGui.ExploitGui.Frame.Jumppower.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_Jumppower"]
    local req = require
    local require = function(obj)
        local fake = fake_module_scripts[obj]
        if fake then
            return fake()
        end
        return req(obj)
    end

	local textBox = script.Parent
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	
	textBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local newJumpPower = tonumber(textBox.Text)
			if newJumpPower then
				humanoid.JumpHeight = newJumpPower
				print("JumpPower changed to:", newJumpPower)
			else
				print("Please enter a valid number.")
			end
		end
	end)
end
local function GVIB_fake_script() -- StarterGui.ExploitGui.Frame.Jumppower.UIStroke.UIGradient.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_UIGradient1"]
    local req = require
    local require = function(obj)
        local fake = fake_module_scripts[obj]
        if fake then
            return fake()
        end
        return req(obj)
    end

	local UIGradient = script.parent
	while true do
		UIGradient.Rotation += 1
		wait()
	end
end
local function MCSZ_fake_script() --  StarterGui.ExploitGui.Frame.Walkspeed.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_Walkspeed"]
    local req = require
    local require = function(obj)
        local fake = fake_module_scripts[obj]
        if fake then
            return fake()
        end
        return req(obj)
    end

	local textBox = script.Parent
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	
	textBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local newWalkSpeed = tonumber(textBox.Text)
			if newWalkSpeed then
				humanoid.WalkSpeed = newWalkSpeed
				print("WalkSpeed changed to:", newWalkSpeed)
			else
				print("Please enter a valid number.")
			end
		end
	end)
end
local function TGFUD_fake_script() --  StarterGui.ExploitGui.Frame.Walkspeed.UIStroke.UIGradient.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_UIGradient2"]
    local req = require
    local require = function(obj)
        local fake = fake_module_scripts[obj]
        if fake then
            return fake()
        end
        return req(obj)
    end

	local UIGradient = script.parent
	while true do
		UIGradient.Rotation += 1
		wait()
	end
end
local function JFOA_fake_script() --  StarterGui.ExploitGui.Frame.Pet Spawner.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_Pet Spawner"]
    local req = require
    local require = function(obj)
        local fake = fake_module_scripts[obj]
        if fake then
            return fake()
        end
        return req(obj)
    end

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()

	end)
end
local function BIEDUV_fake_script() --  StarterGui.ExploitGui.Frame.Pet Spawner.UIStroke.UIGradient.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_UIGradient3"]
    local req = require
    local require = function(obj)
        local fake = fake_module_scripts[obj]
        if fake then
            return fake()
        end
        return req(obj)
    end

	local UIGradient = script.parent
	while true do
		UIGradient.Rotation += 1
		wait()
	end
end
local function UPQSIJN_fake_script() --  StarterGui.ExploitGui.Frame.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_Frame"]
    local req = require
    local require = function(obj)
        local fake = fake_module_scripts[obj]
        if fake then
            return fake()
        end
        return req(obj)
    end

	script.Parent.Active = true
	script.Parent.Draggable = true
end

coroutine.wrap(RJHUIUZ_fake_script)()
coroutine.wrap(RRQGGNW_fake_script)()
coroutine.wrap(GVIB_fake_script)()
coroutine.wrap(MCSZ_fake_script)()
coroutine.wrap(TGFUD_fake_script)()
coroutine.wrap(JFOA_fake_script)()
coroutine.wrap(BIEDUV_fake_script)()
coroutine.wrap(UPQSIJN_fake_script)()
