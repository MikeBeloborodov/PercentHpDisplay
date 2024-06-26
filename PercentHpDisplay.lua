function PercentDisplayLoad()
	--- Player Frame
	local playerHpDisplay = CreateFrame("Frame", "playerHpDisplay", PlayerFrameHealthBar)
	playerHpDisplay:RegisterEvent("UNIT_HEALTH")
	playerHpDisplay:RegisterEvent("PLAYER_ENTERING_WORLD")
	playerHpDisplay:SetWidth(1)
	playerHpDisplay:SetHeight(1)
	playerHpDisplay:SetPoint("TOP", PlayerFrameHealthBar, "TOP", 0, 0)

	local playerHpText = playerHpDisplay:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	playerHpText:SetPoint("TOP", playerHpDisplay, "TOP", 0, 0)
	playerHpText:SetText(tostring( math.floor( tonumber(UnitHealth("player")) / tonumber(UnitHealthMax("player")) * 100) ) .. "%")
	playerHpText:SetTextColor(1, 1, 1)

	playerHpDisplay:SetScript("OnEvent", function ()
		local hpChangeTarget = arg1
		if hpChangeTarget == "player" or event == "PLAYER_ENTERING_WORLD" then
			local healthString = tostring( math.floor( tonumber(UnitHealth("player")) / tonumber(UnitHealthMax("player")) * 100) ) .. "%"
			playerHpText:SetText(healthString)
		end
	end)

	-- Target Frame
	targetHpDisplay = CreateFrame("Frame", "targetHpDisplay", TargetFrameHealthBar)
	targetHpDisplay:RegisterEvent("UNIT_HEALTH")
	targetHpDisplay:RegisterEvent("PLAYER_TARGET_CHANGED")
	targetHpDisplay:SetWidth(1)
	targetHpDisplay:SetHeight(1)
	targetHpDisplay:SetPoint("TOP", TargetFrameHealthBar, "TOP", 0, 0)

	local targetHpText = targetHpDisplay:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	targetHpText:SetPoint("TOP", targetHpDisplay, "TOP", 0, 0)
	targetHpText:SetText("")
	targetHpText:SetTextColor(1, 1, 1)

	targetHpDisplay:SetScript("OnEvent", function ()
		if (UnitHealth("target") == 0) then targetHpText:SetText(""); return end

		local healthString = tostring( math.floor(tonumber(UnitHealth("target")) / tonumber( UnitHealthMax("target")) * 100) ) .. "%"
		if tonumber(UnitHealthMax("target")) > tonumber(UnitHealthMax("player")) then
			healthString = healthString .. " !!!"
		end
		if event == "UNIT_HEALTH" then 
			local hpChangeTarget = arg1
			if hpChangeTarget == "target" then
				targetHpText:SetText(healthString)
			end
		end
		if event == "PLAYER_TARGET_CHANGED" then
			targetHpText:SetText(healthString)
		end
	end)

	--- Warrior Rage
	local _, class, _ = UnitClass("player");
	if class == "WARRIOR" then
		local warriorRage = CreateFrame("Frame", "warriorRage", PlayerFrameManaBar)
		warriorRage:RegisterEvent("UNIT_RAGE")
		warriorRage:RegisterEvent("PLAYER_ENTERING_WORLD")
		warriorRage:SetWidth(1)
		warriorRage:SetHeight(1)
		warriorRage:SetPoint("TOP", PlayerFrameManaBar, "TOP", 0, 0)

		local warriorRageText = warriorRage:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		warriorRageText:SetPoint("TOP", warriorRage, "TOP", 0, 0)
		warriorRageText:SetText(tostring( math.floor( tonumber(UnitMana("player")) / tonumber(UnitManaMax("player")) * 100) ))
		warriorRageText:SetTextColor(1, 1, 1)

		warriorRage:SetScript("OnEvent", function ()
			if event == "UNIT_RAGE" or event == "PLAYER_ENTERING_WORLD" then 
				local rageString = tostring( math.floor( tonumber(UnitMana("player")) / tonumber(UnitManaMax("player")) * 100) )
				warriorRageText:SetText(rageString)
			end
		end)
	end
end