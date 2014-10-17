/*=============================================================

	Made by: Main_Fighter (MainFighter.com)
	Please acknowledge my work and keep this here :)
	Thanks for using my terrible scripts xD

==============================================================*/

/*=============================================================
	HUD Settings
==============================================================*/
local HUD = {}
-- true = Enable
-- false = Disable
HUD.Background = true -- Disables drawing of background
HUD.PlayerName = true -- Disables drawing of PlayerName
HUD.SteamID = false -- Disables drawing of SteamID, It will be placed in the bottom right hand corner of the players screen
HUD.PlayerAvatar = true -- Disables drawing of PlayerAvatar
HUD.Health = true -- Disables drawing of Health
HUD.HealthNumber = false -- Disables drawing of Health number in health bar
HUD.Armor = true -- Disables drawing of Armor
HUD.ArmorNumber = false -- Disables drawing of Armor number in armor bar
HUD.DarkRPHungerMod = false -- YES THIS WORKS BUT IT IS NOT IN THE RIGHT PLACE AS OF THIS TIME Disables drawing of DarkRP's hunger mod
HUD.HungerNumber = false -- YES THIS WORKS BUT IT IS NOT IN THE RIGHT PLACE AS OF THIS TIME Disables drawing of the hunger number
HUD.DarkRP = true -- Disables drawing of DarkRP elements

/*=============================================================
	Hides default DarkRP HUD elements
==============================================================*/
local hideHUDElements = {
	["DarkRP_HUD"] = false,
	["DarkRP_EntityDisplay"] = false,
	["DarkRP_ZombieInfo"] = false,
	["DarkRP_LocalPlayerHUD"] = true,
	["DarkRP_Hungermod"] = true,
	["DarkRP_Agenda"] = false
}

hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
	if hideHUDElements[name] then return false end
end)
/*=============================================================
	Hides default Garry's Mod HUD elements
==============================================================*/
local function hideElements(name)
	if name == "CHudHealth" or name == "CHudBattery" or name == "CHudSuitPower" then
		return false
	end
	if hideHUDElements[name] then
		return false
	end	
end
hook.Add("HUDShouldDraw", "hideElements", hideElements)

/*=============================================================
	HUD elements
==============================================================*/
local function DrawBackground()
	draw.RoundedBoxEx(6, 0, ScrH() - 104, 270, 64, Color(50,50,50,255), false, false, false, false)
end

local function DrawPlayerName()
	draw.DrawText(LocalPlayer():Nick(), "other", 70, ScrH() - 100, Color(255, 255, 255, 255))
end

local function DrawPlayerSteamID()
    draw.DrawText(LocalPlayer():SteamID(), "other", ScrW() - 193, ScrH() - 30, Color(255, 255, 255, 255))
end
	
local function DrawPlayerAvatar()
	local Avatar = vgui.Create( "AvatarImage", Panel )
	Avatar:SetSize( 64, 64 )
	Avatar:SetPos( 0, ScrH() - 104 )
	Avatar:SetPlayer( LocalPlayer(), 64 )
end

local function DrawHealth()
	draw.RoundedBox(0, 0, ScrH() - 40, 270, 20, Color(50, 50, 50,255))

	local DrawHealth = LocalPlayer():Health() or 0
	local EchoHealth = LocalPlayer():Health() or 0

	if DrawHealth > 100 then DrawHealth = 100 end
	if DrawHealth < 0 then DrawHealth = 0 end
	
	if DrawHealth != 0 then
		draw.RoundedBox(0, 0, ScrH() - 40, (270) * DrawHealth / 100, 20, Color(170, 0, 0, 255))
	end
	draw.DrawText("Health", "healtharmor", 110, ScrH() - 40, Color(255, 255, 255, 255))
	if HUD.HealthNumber then
		draw.DrawText(EchoHealth, "healtharmor", 3, ScrH() - 40, Color(255, 255, 255, 255))
	end
end

local function DrawArmor()
	draw.RoundedBox(0, 0, ScrH() - 20, 270, 20, Color(50, 50, 50,255))

	local DrawArmor = LocalPlayer():Armor() or 0
	local EchoArmor = LocalPlayer():Armor() or 0

	if DrawArmor > 100 then DrawArmor = 100 end
	if DrawArmor < 0 then DrawArmor = 0 end
	
	if DrawArmor != 0 then
		draw.RoundedBox(0, 0, ScrH() - 20, (270) * DrawArmor / 100, 20, Color(0, 0, 170, 255))
	end
	draw.DrawText("Armor", "healtharmor", 112, ScrH() - 19, Color(255, 255, 255, 255))
	if HUD.ArmorNumber then
		draw.DrawText(EchoArmor, "healtharmor", 3, ScrH() - 19, Color(255, 255, 255, 255))
	end
end

local function DrawDarkRPHunger()
	draw.RoundedBoxEx(6, 0, ScrH() - 123, 270, 20, Color(50, 50, 50,255), false, true, false, false)

	local DrawEnergy = LocalPlayer():getDarkRPVar("Energy") or 0
	local EchoEnergy = LocalPlayer():getDarkRPVar("Energy") or 0

	if DrawEnergy > 100 then DrawEnergy = 100 end
	if DrawEnergy < 0 then DrawEnergy = 0 end
	
	if DrawEnergy != 0 then
		draw.RoundedBoxEx(6, 0, ScrH() - 123, (270) * DrawEnergy / 100, 20, Color(0, 0, 170, 255), false, true, false, false)
	end
	draw.DrawText("Hunger", "healtharmor", 112, ScrH() - 123, Color(255, 255, 255, 255))
	if HUD.HungerNumber then
		draw.DrawText(EchoEnergy, "healtharmor", 5, ScrH() - 123, Color(255, 255, 255, 255))
	end
end

local function DrawDarkRPJob()
	draw.DrawText(LocalPlayer():getDarkRPVar("job"), "other", 70, ScrH() - 73, Color(255, 255, 255, 255))
end

local function DrawDarkRPWallet()
	draw.DrawText("Wallet: $"..LocalPlayer():getDarkRPVar("money"), "other", 5, 0, Color(255, 255, 255, 255))
end

local function DrawDarkRPSalary()
	draw.DrawText("Salary: $"..LocalPlayer():getDarkRPVar("salary"), "other", 5, 30, Color(255, 255, 255, 255))
end
/*=============================================================
	Drawing the actual HUD elements
==============================================================*/
function DrawHUD()
	localplayer = localplayer and IsValid(localplayer) and localplayer or LocalPlayer()
	if not IsValid(localplayer) then return end

	if HUD.Background then
		DrawBackground()
	end

	if HUD.PlayerName then
		DrawPlayerName()
	end

	if HUD.SteamID then
		DrawPlayerSteamID()
	end

	if HUD.PlayerAvatar then
		DrawPlayerAvatar()
    end

	if HUD.Health then
		DrawHealth()
	end

	if HUD.Armor then
		DrawArmor()
	end

	if HUD.DarkRPHungerMod then
		DrawDarkRPHunger()
	end

	if HUD.DarkRP then
		DrawDarkRPJob()
		DrawDarkRPWallet()
		DrawDarkRPSalary()
	end
end

hook.Add("HUDPaint", "DrawHUD", DrawHUD)