local module = {
	connections = {}
}
module.__index = module


-- services --
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")


-- user --
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local Camera = workspace.CurrentCamera

local Hrp = Character.PrimaryPart
local Hum = Character:WaitForChild("Humanoid")


-- settings --
local Speed = _G.Speed or 25


local isFlying = false
local Flyable = true

local isHolding = false
local Movable = true


if _G.Connections then
	for i, v: RBXScriptConnection in next, _G.Connections do
		v:Disconnect()
	end
end

function module:Fly(T)
	Speed = T and T.Speed or Speed
	if not module.Stepped or not module.Input then
		table.insert(module.connections, UserInputService.InputBegan:Connect(function(input, ...)
			if input.KeyCode == Enum.KeyCode.F then
				if not Flyable then
					return
				else
					isFlying = not isFlying
					Hrp.Anchored = isFlying
					Hum.PlatformStand = isFlying
				end
			end
		end))
		table.insert(module.connections, RunService.Stepped:Connect(function()
			if isFlying and Flyable then
				if UserInputService:IsKeyDown(Enum.KeyCode.W) then
					Character.PrimaryPart.CFrame = Camera.CFrame + Camera.CFrame.LookVector * Speed
				elseif UserInputService:IsKeyDown(Enum.KeyCode.S) then
					Character.PrimaryPart.CFrame = Camera.CFrame + Camera.CFrame.LookVector * 0
				end
			end
		end))
	end
end

function module:Cleanup()
	for _, v: RBXScriptConnection in next, module.connections do
		v:Disconnect()
	end
end




return module
