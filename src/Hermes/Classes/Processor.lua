local Processor = {}
Processor.__index = Processor

function Processor.new()
	local self = setmetatable({}, Processor)
	return self
end

function Processor:Process(RepoName: string, dataTable: {})
	local ImportFolder = Instance.new("Folder")
	ImportFolder.Parent = workspace
	ImportFolder.Name = RepoName

	local ScriptTypes = { "Server", "Client", "Module" }

	for name, data in pairs(dataTable) do
		if table.find(ScriptTypes, data.Type) then
			local Script
			if data.Type == "Server" then
				Script = Instance.new("Script")
			elseif data.Type == "Client" then
				Script = Instance.new("LocalScript")
			elseif data.Type == "Module" then
				Script = Instance.new("ModuleScript")
			end
			Script.Parent = ImportFolder
			Script.Name = name
			Script.Source = data.Data
		end
	end
end

return Processor
