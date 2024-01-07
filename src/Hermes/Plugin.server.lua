local HttpService = game:GetService("HttpService")

local LogHandler = require(script.Parent.Classes.LogHandler).new()
local Processor = require(script.Parent.Classes.Processor).new()

local toolbar: PluginToolbar = plugin:CreateToolbar("Hermes")
local button: PluginToolbarButton =
	toolbar:CreateButton("Activate", "", "http://www.roblox.com/asset/?id=15887910909", "")
local mainGui: ScreenGui = script:WaitForChild("PluginUI")
local mainBackground: Frame = mainGui:WaitForChild("Background")
local Boxes: Folder = mainBackground:WaitForChild("Boxes")
local Inputs: Folder = mainBackground:WaitForChild("Inputs")
local Buttons: Folder = mainBackground:WaitForChild("Buttons")
local OutputElement: TextLabel = Boxes:WaitForChild("OutputBox"):WaitForChild("ActualOutput")
local canActivate = true

LogHandler:SetUI(OutputElement)

if mainGui and canActivate then
	button.Click:Connect(function()
		if mainGui.Parent == script then
			mainGui.Parent = game:WaitForChild("CoreGui")
			task.wait(0.1)
			mainBackground:TweenPosition(
				UDim2.new(0.233, 0, 0.254, 0),
				Enum.EasingDirection.InOut,
				Enum.EasingStyle.Quad,
				0.2
			)
		else
			mainBackground:TweenPosition(
				UDim2.new(0.233, 0, 1, 0),
				Enum.EasingDirection.InOut,
				Enum.EasingStyle.Quad,
				0.2
			)
			task.wait(0.1)
			mainGui.Parent = script
		end
	end)
end

Buttons.Enter.MouseButton1Click:Connect(function()
	LogHandler:Log(`Sending GET request to http://localhost:3000/clone?url={Inputs.URL.Text}`)
	LogHandler:NewLine()
	LogHandler:Log(`Please wait patiently...`)

	local response = HttpService:GetAsync(`http://localhost:3000/clone?url={Inputs.URL.Text}`)

	-- Parse the JSON response
	local data = HttpService:JSONDecode(response)

	if data["message"] == "Repository cloned successfully." then
		LogHandler:NewLine()
		LogHandler:Log("Successfully Cloned the Repository. Attempting to import data...")
		local dataResponse = HttpService:GetAsync(`http://localhost:3000/get?repoName={data.repoName}`)
		LogHandler:NewLine()
		LogHandler:Log("")
		Processor:Process(data.repoName, HttpService:JSONDecode(dataResponse))
		LogHandler:Log(`Successfully Imported and Processed Data From The Repo: {data.repoName}`)
	else
		LogHandler:NewLine()
		LogHandler:Log(`Failed to clone {Inputs.URL.Text}`)
	end
end)

Buttons.Close.MouseButton1Click:Connect(function()
	canActivate = false
	mainBackground:TweenPosition(UDim2.new(0.233, 0, 1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2)
	task.wait(0.1)
	mainGui.Parent = script
	canActivate = true
end)
