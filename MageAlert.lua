MageAlert = {
	Sound = true,
	Flash = true,
	Fofsound = true
};

local Sealinc = 0
local Red = 0
local falpha = 0
local falphainc = 0
local maxalpha = 0.3

local FoF = 44544
local BF = 57761
local HS = 48108
local MB = 44401
local BFname = GetSpellInfo(57761)
local BFICON = "OFF"
local MBname = GetSpellInfo(44401)
local MBICON = "OFF"
local HSname = GetSpellInfo(48108)
local HSICON = "OFF"
local FFname = GetSpellInfo(44544)
local FFICON = "OFF"

function Checker(self, elapsed)
  if (Red > 0) then
	if falphainc == 0 then
		falpha = falpha + elapsed
		if falpha > maxalpha then
			falpha = maxalpha
			falphainc = 2
		end
	end
	if falphainc >= 2 then
		falphainc = falphainc + elapsed
		if falphainc > 2.3 then
			falphainc = 1
		end
	end
	if falphainc == 1 then
		falpha = falpha - elapsed
		if falpha < 0 then
			falpha = 0
			Red = 0
			falphainc = 0
			Flash_Red:Hide( )
			Flash_Orange:Hide( )
			Flash_Purple:Hide( )
			Flash_Blue:Hide( )
		end
	end
	Flash_Red:SetAlpha( falpha )
	Flash_Orange:SetAlpha( falpha )
	Flash_Purple:SetAlpha( falpha )
	Flash_Blue:SetAlpha( falpha )
  end
end


function Buah_Start(self)
	DEFAULT_CHAT_FRAME:AddMessage("|cff99cc01Mage|cffFF0000Alert|cffffffff Version 1.3 Addon loaded!")
	DEFAULT_CHAT_FRAME:AddMessage("/magealert for help")
	SLASH_MAGEALARM1 = "/magealert"
	SlashCmdList["MAGEALARM"] = Splashcommand
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function Splashcommand(msg)

	if (msg == "sound on") then
		MageAlert.Sound = true;
		DEFAULT_CHAT_FRAME:AddMessage("|cff99cc01Mage|cffFF0000Alert|cffffffff Addon! Config set to: Sound = |cff33ff99 on")
	end

	if (msg == "sound off") then
		MageAlert.Sound = false;
		DEFAULT_CHAT_FRAME:AddMessage("|cff99cc01Mage|cffFF0000Alert|cffffffff Addon! Config set to: Sound = |cffffff78 off")
	end

	if (msg == "flash on") then
		MageAlert.Flash = true;
		DEFAULT_CHAT_FRAME:AddMessage("|cff99cc01Mage|cffFF0000Alert|cffffffff Addon! Config set to: Flash = |cff33ff99 on")
	end

	if (msg == "flash off") then
		MageAlert.Flash = false;
		DEFAULT_CHAT_FRAME:AddMessage("|cff99cc01Mage|cffFF0000Alert|cffffffff Addon! Config set to: Flash = |cffffff78 off")
	end

	if (msg == "fofsound on") then
		MageAlert.Fofsound = true;
		DEFAULT_CHAT_FRAME:AddMessage("|cff99cc01Mage|cffFF0000Alert|cffffffff Addon! Config set to: FoFSound = |cff33ff99 on")
	end
	
	if (msg == "fofsound off") then
		MageAlert.Fofsound = false;
		DEFAULT_CHAT_FRAME:AddMessage("|cff99cc01Mage|cffFF0000Alert|cffffffff Addon! Config set to: FoFSound = |cffffff78 off")
	end

	if (msg == "") then
		DEFAULT_CHAT_FRAME:AddMessage("/magealert sound on/off - enable/disable the sound")
		DEFAULT_CHAT_FRAME:AddMessage("/magealert flash on/off - enable/disable the flash")
		DEFAULT_CHAT_FRAME:AddMessage("/magealert fofsound on/off - enable/disable the Fingers of Frost sound")
		DEFAULT_CHAT_FRAME:AddMessage("Current settings:")
		
		if (MageAlert.Sound == false) then 
			DEFAULT_CHAT_FRAME:AddMessage("sound: |cffffff78 off") else 
			DEFAULT_CHAT_FRAME:AddMessage("sound: |cff33ff99 on") 
		end
		if (MageAlert.Flash == false) then 
			DEFAULT_CHAT_FRAME:AddMessage("flash: |cffffff78 off") else 
			DEFAULT_CHAT_FRAME:AddMessage("flash: |cff33ff99 on") 
		end
		if (MageAlert.Fofsound == false) then 
			DEFAULT_CHAT_FRAME:AddMessage("fofsound: |cffffff78 off") else 
			DEFAULT_CHAT_FRAME:AddMessage("fofsound: |cff33ff99 on") 
		end
	end

	if (msg == "ver") or (msg == "version") then
		DEFAULT_CHAT_FRAME:AddMessage("|cff99cc01Mage|cffFF0000Alert|cffffffff by Yheen")
		DEFAULT_CHAT_FRAME:AddMessage("Version 1.3 update by l3m0nqu1z")
		DEFAULT_CHAT_FRAME:AddMessage("You can always find the latest version on curse.com")
	end

end

function MageAlert_OnEvent(self,event, ...)

	if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		if (sourceGUID == playerGUID) then
			if (AuraUtil.FindAuraByName(BFname, "player")) then
				if (BFICON == "OFF") then
					if (MageAlert.Sound == true) then
						PlaySoundFile("Interface\\AddOns\\MageAlert\\Sounds\\brainfreeze.mp3")
					end
					if (MageAlert.Flash == true) then
						Flash_Blue:Show()
						Red = 1
					end
				BFICON = "ON"
				end
			end
			if not (AuraUtil.FindAuraByName(BFname, "player")) then
				BFICON = "OFF"
			end
			
			if (AuraUtil.FindAuraByName(MBname, "player")) then
				if (MBICON == "OFF") then
					if (MageAlert.Sound == true) then
						PlaySoundFile("Interface\\AddOns\\MageAlert\\Sounds\\missilebarrage.mp3")
					end
					if (MageAlert.Flash == true) then
						Flash_Orange:Show()
						Red = 1
					end
				MBICON = "ON"
				end
			end
			if not (AuraUtil.FindAuraByName(MBname, "player")) then
				MBICON = "OFF"
			end
			
			if (AuraUtil.FindAuraByName(HSname, "player")) then
				if (HSICON == "OFF") then
					if (MageAlert.Sound == true) then
						PlaySoundFile("Interface\\AddOns\\MageAlert\\Sounds\\hotstreak.mp3")
					end
					if (MageAlert.Flash == true) then
						Flash_Red:Show()
						Red = 1
					end
				HSICON = "ON"
				end
			end
			if not (AuraUtil.FindAuraByName(HSname, "player")) then
				HSICON = "OFF"
			end

			if (AuraUtil.FindAuraByName(FFname, "player")) then
				if (FFICON == "OFF") then
					if (MageAlert.Sound == true) and (MageAlert.Fofsound == true) then
						PlaySoundFile("Interface\\AddOns\\MageAlert\\Sounds\\fingeroffrost.mp3")
					end
					if (MageAlert.Flash == true) then
						Flash_Purple:Show()
						Red = 1
					end
				FFICON = "ON"
				end
			end
			if not (AuraUtil.FindAuraByName(FFname, "player")) then
				FFICON = "OFF"
			end

		end
	end
end
