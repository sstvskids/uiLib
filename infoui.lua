--[[
	
	- [ stav.lua ] -
	info.ui
	
	CREATED: [ 12/10 ]
	
]]

local lib = {
	API = {},
	connections = {}
}

local cloneref = cloneref or function(obj)
	return obj
end

local inputService = cloneref(game:GetService('UserInputService'))
local tweenService = cloneref(game:GetService('TweenService'))
local textService = cloneref(game:GetService('TextService'))
local playersService = cloneref(game:GetService('Players'))
local runService = cloneref(game:GetService('RunService'))
local lplr = playersService.LocalPlayer

local gethui = get_hidden_ui or gethui or function()
	return (runService:IsStudio() and lplr.PlayerGui) or cloneref(game:GetService('CoreGui'))
end

local ScreenGUI = Instance.new('ScreenGui')
ScreenGUI.Name = '\0'
ScreenGUI.ResetOnSpawn = false
ScreenGUI.Parent = gethui()

local index = 0
local Windows = {}

if inputService.TouchEnabled then
	lplr:Kick('Not mobile supported :)')
end

local watermark
lib.API.Watermark = function(bool, txt)
	if bool == true and watermark == nil then
		watermark = Instance.new('TextLabel')
		watermark.AnchorPoint = Vector2.new(1, 1)
		watermark.Position = UDim2.new(1, -65, 1, -20)
		watermark.BackgroundTransparency = 1
		watermark.BorderSizePixel = 0
		watermark.Text = txt
		watermark.TextSize = 24
		watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
		watermark.Parent = ScreenGUI
	elseif bool == false and watermark ~= nil then
		watermark:Destroy()
		watermark = nil
	end
end

lib.API.CreateWindow = function(txt)
	local WindowFrame = Instance.new('Frame')
	WindowFrame.Position = UDim2.fromScale(0.01 + (index / 8.2), 0.01)
	WindowFrame.Size = UDim2.new(0.12, 0, 0, 32)
	WindowFrame.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
	WindowFrame.BorderSizePixel = 0
	WindowFrame.Parent = ScreenGUI
	
	local RedBar = Instance.new('Frame')
	RedBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	RedBar.Size = UDim2.new(1, 0, 0, -3)
	RedBar.AutomaticSize = Enum.AutomaticSize.X
	RedBar.BorderSizePixel = 0
	RedBar.Parent = WindowFrame 
	
	local WindowLabel = Instance.new('TextLabel')
	WindowLabel.Size = UDim2.fromScale(1, 1)
	WindowLabel.Position = UDim2.fromScale(0.05, 0)
	WindowLabel.BackgroundTransparency = 1
	WindowLabel.BorderSizePixel = 0
	WindowLabel.TextXAlignment = Enum.TextXAlignment.Left
	WindowLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	WindowLabel.TextSize = 12
	WindowLabel.AutomaticSize = Enum.AutomaticSize.X
	WindowLabel.Text = txt
	WindowLabel.Parent = WindowFrame
	
	local ModuleFrame = Instance.new('Frame')
	ModuleFrame.Position = UDim2.fromScale(0, 1)
	ModuleFrame.Size = UDim2.new(1, 0, 0, 0)
	ModuleFrame.BorderSizePixel = 0
	ModuleFrame.AutomaticSize = Enum.AutomaticSize.Y
	ModuleFrame.BackgroundTransparency = 1
	ModuleFrame.Parent = WindowFrame
	
	local ModulePadding = Instance.new('UIPadding')
	ModulePadding.PaddingTop = UDim.new(0, 2)
	ModulePadding.Parent = ModuleFrame

	local ModuleSort = Instance.new('UIListLayout')
	ModuleSort.SortOrder = Enum.SortOrder.LayoutOrder
	ModuleSort.Padding = UDim.new(0, 2)
	ModuleSort.Parent = ModuleFrame
	
	table.insert(lib.connections, inputService.InputBegan:Connect(function(key, gpe)
		if gpe then return end

		if key.KeyCode == Enum.KeyCode.RightShift then
			WindowFrame.Visible = not WindowFrame.Visible
		end
	end))
	
	index += 1
	
	Windows[txt] = {
		Modules = {},
		CreateModule = function(self, Table)
			local cfg = {}
			cfg[Table.Name] = {
				Enabled = false,
				Keybind = 'Unknown',
				Toggles = {}
			}
			
			local ModuleButton = Instance.new('Frame')
			ModuleButton.Size = UDim2.new(1, 0, 0, 32)
			ModuleButton.BorderSizePixel = 0
			ModuleButton.BackgroundColor3 = cfg[Table.Name].Enabled and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(29, 29, 29)
			ModuleButton.Parent = ModuleFrame
			
			--[[local ModulePadding = Instance.new('UIPadding')
			ModulePadding.PaddingBottom = UDim.new(0, 2)
			ModulePadding.Parent = ModuleFrame]]
			
			local ModuleText = Instance.new('TextButton')
			ModuleText.Position = UDim2.fromScale(0.05, 0)
			ModuleText.Size = UDim2.fromScale(1, 1)
			ModuleText.BackgroundTransparency = 1
			ModuleText.BorderSizePixel = 0
			ModuleText.TextXAlignment = Enum.TextXAlignment.Left
			ModuleText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ModuleText.TextSize = 12
			ModuleText.AutomaticSize = Enum.AutomaticSize.X
			ModuleText.Text = Table.Name
			ModuleText.Parent = ModuleButton
			
			local DropdownFrame = Instance.new('Frame')
			DropdownFrame.Size = UDim2.fromScale(1, 0)
			DropdownFrame.AutomaticSize = Enum.AutomaticSize.Y
			DropdownFrame.BackgroundTransparency = 1
			DropdownFrame.Visible = not DropdownFrame.Visible
			DropdownFrame.Parent = ModuleFrame
			
			local DropdownPadding = Instance.new('UIPadding')
			DropdownPadding.PaddingTop = UDim.new(0, -0.5)
			DropdownPadding.PaddingBottom = UDim.new(0, 2)
			DropdownPadding.Parent = DropdownFrame
			
			local DropdownSort = Instance.new('UIListLayout')
			DropdownSort.SortOrder = Enum.SortOrder.LayoutOrder
			ModuleSort.Padding = UDim.new(0, -0.5)
			DropdownSort.Parent = DropdownFrame
			
			local KeybindButton = Instance.new('Frame')
			KeybindButton.Size = UDim2.new(1, 0, 0, 32)
			KeybindButton.BorderSizePixel = 0
			KeybindButton.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
			KeybindButton.Parent = DropdownFrame
			
			local KeybindText = Instance.new('TextButton')
			KeybindText.Position = UDim2.fromScale(0.05, 0)
			KeybindText.Size = UDim2.fromScale(1, 1)
			KeybindText.BackgroundTransparency = 1
			KeybindText.TextXAlignment = Enum.TextXAlignment.Left
			KeybindText.TextColor3 = Color3.fromRGB(255, 255, 255)
			KeybindText.TextSize = 10.5
			KeybindText.Text = 'Keybind: '..cfg[Table.Name].Keybind
			KeybindText.Parent = KeybindButton

			table.insert(lib.connections, KeybindText.MouseButton1Click:Connect(function()
				local conn
				conn = inputService.InputBegan:Connect(function(key, gpe)
					if gpe then return end

					if key.KeyCode ~= Enum.KeyCode.Unknown then
						cfg[Table.Name].Keybind = tostring(key.KeyCode):gsub('Enum.KeyCode.', '')
						KeybindText.Text = 'Keybind: '..cfg[Table.Name].Keybind
						
						conn:Disconnect()
					end
				end)
			end))
			
			local moduleHandler = {
				Enabled = cfg[Table.Name].Enabled,
				Toggle = function(self)
					self.Enabled = not self.Enabled
					cfg[Table.Name].Enabled = not cfg[Table.Name].Enabled

					tweenService:Create(ModuleButton, TweenInfo.new(0.1), {BackgroundColor3 = self.Enabled and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(29, 29, 29)}):Play()
					if Table.Function then
						task.spawn(Table.Function, self.Enabled)
					end
				end,
			}
			
			function moduleHandler.CreateToggle(self, tab)
				if not cfg[Table.Name].Toggles[tab.Name] then
					cfg[Table.Name].Toggles[tab.Name] = {Enabled = false}
				end
				
				local ModuleButton = Instance.new('Frame')
				ModuleButton.Size = UDim2.new(1, 0, 0, 32)
				ModuleButton.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
				ModuleButton.BorderSizePixel = 0
				ModuleButton.Parent = DropdownFrame
				
				local ModuleText = Instance.new('TextButton')
				ModuleText.Position = UDim2.fromScale(0.05, 0)
				ModuleText.Size = UDim2.fromScale(1, 1)
				ModuleText.BackgroundTransparency = 1
				ModuleText.TextXAlignment = Enum.TextXAlignment.Left
				ModuleText.TextColor3 = Color3.fromRGB(255, 255, 255)
				ModuleText.TextSize = 10
				ModuleText.Text = tab.Name
				ModuleText.Parent = ModuleButton
				
				local moduleHandler = {
					Enabled = cfg[Table.Name].Toggles[tab.Name].Enabled,
					Toggle = function(self)
						self.Enabled = not self.Enabled
						cfg[Table.Name].Toggles[tab.Name].Enabled = not cfg[Table.Name].Toggles[tab.Name].Enabled

						tweenService:Create(ModuleButton, TweenInfo.new(0.1), {BackgroundColor3 = self.Enabled and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(29, 29, 29)}):Play()
						if tab.Function then
							task.spawn(tab.Function, self.Enabled)
						end
					end,
				}

				table.insert(lib.connections, ModuleText.MouseButton1Click:Connect(function()
					moduleHandler:Toggle()
				end))
				
				return moduleHandler
			end
			
			table.insert(lib.connections, ModuleText.MouseButton1Click:Connect(function()
				moduleHandler:Toggle()
			end))
			
			table.insert(lib.connections, ModuleText.MouseButton2Down:Connect(function()
				DropdownFrame.Visible = not DropdownFrame.Visible
			end))
			
			table.insert(lib.connections, inputService.InputBegan:Connect(function(key, gpe)
				if gpe then return end

				if key.KeyCode ~= Enum.KeyCode.Unknown and key.KeyCode == Enum.KeyCode[cfg[Table.Name].Keybind] then
					moduleHandler:Toggle()
				end
			end))
			
			self.Modules[Table.Name] = moduleHandler
			return moduleHandler
		end
	}
	
	return Windows[txt]
end

lib.API.Uninject = function()
	for i,v in lib.connections do
		v:Disconnect()
	end
	
	for i,v in Windows do
		for x,d in v.Modules do
			d:Toggle()
		end
	end
	
	ScreenGUI:Destroy()
	lib = nil
end

--[[
	- [ stav.lua ] -

	Example


local tabs = {
	Combat = lib.API.CreateWindow('Combat'),
	GUI = lib.API.CreateWindow('GUI')
}

local Aura
local Rotations
Aura = tabs.Combat:CreateModule({
	Name = 'Killaura'
}) -- to turn a module off when its toggled, do Aura:Toggle() (aura) being a placeholder for your variable name
Rotations = Aura:CreateToggle({
	Name = 'Rotations'
})

tabs.GUI:CreateModule({
	Name = 'Watermark',
	Function = function(callback)
		lib.API.Watermark(callback, 'stav.lua')
	end
})

tabs.GUI:CreateModule({
	Name = 'Uninject',
	Function = function(callback)
		if callback then
			lib.API.Uninject()
		end
	end
})]]

return lib
