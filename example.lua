-- Example:
--[[

	Ex. 1:
	SimpleFly:Fly()
	
	Ex. 2:
	SimpleFly:Fly {
		Speed = 25,
		Position = CFrame.new(0, 0, 0)
	}
	
	task.wait(10)
	
	Ex. 1:
	SimpleFly:Cleanup()
	
	Ex. 2:
	SimpleFly:Cleanup(true) -- display_console_message // Prints a message to the console when cleanup is done.
]]

-- | [Information]									  |
-- | Leaving Speed blank, will just use the default,- |
-- | Speed that has been set before hand.			  |
-- | Leaving position blank, will make you teleport,- |
-- | Back to where you executed the script.			  |


local SimpleFly = game:GetService("HttpService"):PostAsync("https://github.com/MrAgentRBLX/SimpleFly/blob/main/Source.lua", "GET", Enum.HttpContentType.TextPlain)
SimpleFly:Fly {
	Speed = 25
}

task.wait(10)
SimpleFly:Cleanup(true)
