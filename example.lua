local lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/sstvskids/uiLib/refs/heads/main/ui.lua'))()
local stav = lib.library.CreateWindow('Ballz')
stav:CreateModule({
	Name = 'Kill Aura',
	Function = function(callback)
		print(callback)
	end,
})
stav:CreateModule({
	Name = 'Speed'
})


lib.library.CreateWindow('Stav.lua here')
lib.library.CreateNotif('You have mail!', 6.7, 11422155687)
