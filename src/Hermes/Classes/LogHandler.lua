-- LogHandler module

local LogHandler = {}
LogHandler.__index = LogHandler

-- Constructor function for creating new LogHandler instances
function LogHandler.new()
	local self = setmetatable({}, LogHandler)
	return self
end

-- Set the UI element for logging
function LogHandler:SetUI(UIElement: TextLabel)
	self.UIElement = UIElement
end

-- Log a message with timestamp
function LogHandler:Log(message: string)
	local currentTime = os.date("%A, %B %d, %Y at %X")
	local output = string.format("[%s]: %s", currentTime, message) -- Use string.format for better readability
	self.UIElement.Text = output
end

-- Set text color
function LogHandler:SetColor(RGBValue: Color3)
	self.UIElement.TextColor3 = RGBValue
end

-- Add a new line to the UI
function LogHandler:NewLine()
	local newLine = self.UIElement:Clone()
	newLine.Parent = self.UIElement.Parent
	task.wait(0.1)
	newLine.Name = tostring(#self.UIElement.Parent:GetChildren())

	print(newLine.Name)

	if tonumber(newLine.Name) >= 11 then
		self.UIElement.Parent:GetChildren()[2]:Destroy()
	end

	self.UIElement = newLine
end

-- Grab the UI Element

function LogHandler:GrabUIElement(): TextLabel
	return self.UIElement
end

return LogHandler
