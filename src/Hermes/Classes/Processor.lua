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

	local ScriptTypes = {
		["Server"] = "Script",
		["Client"] = "LocalScript",
		["Module"] = "ModuleScript"
	 }

	for name, data in pairs(dataTable) do
		if table.find(ScriptTypes, data.Type) then
			local Script = Instance.new(ScriptTypes[data.Type])
			Script.Parent = ImportFolder
			Script.Name = name
			Script.Source = data.Data
		end
	end
end

return Processor
