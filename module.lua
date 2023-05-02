local module = table.create(1)
module.__index = module


-- module handler --
module.details=nil
module.connections = table.create(1)
module.new_cframe = function(object, cframe)
	if object:IsA("Model") then object:PivotTo(cframe) elseif object:IsA("BasePart") then object.CFrame = cframe end
end
module.new_connection = function(rblx_connection)
	table.insert(module.connections, rblx_connection)
end


-- services --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")


-- local variables --
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local Camera = workspace.CurrentCamera
local Hrp = Character.PrimaryPart
local Hum = Character:WaitForChild("Humanoid")


-- settings --
local Speed = 25
local lastPosition = Character:GetPivot()


local isFlying = false
local Flyable = true

local isHolding = false
local Movable = true


function module.fly()
	if #module.connections >0 then
		for _, connection in ipairs(module.connections) do
			connection:Disconnect()
		end
	end
	module.new_connection(UserInputService.InputBegan:Connect(function(input, ...)
		if input.KeyCode == Enum.KeyCode.F then
			Flyable = not Flyable
			if Flyable then
				isFlying = true
				Hrp.Anchored = true
				Hrp.PlatformStand = true
			else
				isFlying = false
				return
			end
		end
	end))
	module.new_connection(RunService.Stepped:Connect(function()
		if Flyable and isFlying then
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then
				local CalCFrame = Camera.CFrame + Camera.CFrame.LookVector * Speed
				module.new_cframe(Character.PrimaryPart, CalCFrame)
			elseif UserInputService:IsKeyDown(Enum.KeyCode.S) then
				local CalCFrame = Camera.CFrame + Camera.CFrame.LookVector * 0
				module.new_cframe(Character.PrimaryPart, CalCFrame)
			end
		end
	end))
	table.insert(module.connections)
end

function module:Cleanup(message)
	local success, _  = pcall(function()
		for _, rblxConnection in ipairs(module.connections) do
			rblxConnection:Disconnect()
		end
	end)
	if success and message then
		print(message)
	else
		return
	end
end


return module
