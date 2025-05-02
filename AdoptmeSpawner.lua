--[[
    AdoptMePetSpawner/LocalPetSpawner.lua
    Client-sided pet spawner inspired by Adopt Me (Roblox)
    Only visible to the local player. Designed for GitHub educational/demo use.

    Requirements:
    - ReplicatedStorage > Pets > ShadowDragon, FrostDragon
    - StarterGui > PetSpawnerUI with:
        - Buttons: Main.FR, Main.NFR, Main.MFR
        - TextBox/Dropdown: Main.PetDropdown
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PetModels = {
    ["Shadow Dragon"] = ReplicatedStorage:WaitForChild("Pets"):WaitForChild("ShadowDragon"),
    ["Frost Dragon"] = ReplicatedStorage:WaitForChild("Pets"):WaitForChild("FrostDragon")
}

local player = Players.LocalPlayer
local screenGui = player:WaitForChild("PlayerGui"):WaitForChild("PetSpawnerUI")
local equipButtonFR = screenGui.Main.FR
local equipButtonNFR = screenGui.Main.NFR
local equipButtonMFR = screenGui.Main.MFR
local petDropdown = screenGui.Main.PetDropdown

local currentPet = nil
local selectedPetName = "Shadow Dragon"

local function spawnPet(petName, variant)
    if currentPet then currentPet:Destroy() end

    local petTemplate = PetModels[petName]
    if not petTemplate then warn("Pet not found: " .. petName) return end

    local petClone = petTemplate:Clone()
    petClone.Name = "FakePet"
    petClone.Parent = workspace
    petClone:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame * CFrame.new(2, 0, 2))

    petClone:SetAttribute("Variant", variant)
    currentPet = petClone
end

equipButtonFR.MouseButton1Click:Connect(function()
    spawnPet(selectedPetName, "FR")
end)

equipButtonNFR.MouseButton1Click:Connect(function()
    spawnPet(selectedPetName, "NFR")
end)

equipButtonMFR.MouseButton1Click:Connect(function()
    spawnPet(selectedPetName, "MFR")
end)

petDropdown:GetPropertyChangedSignal("Text"):Connect(function()
    selectedPetName = petDropdown.Text
end)
