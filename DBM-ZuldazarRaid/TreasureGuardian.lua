local mod	= DBM:NewMod(2342, "DBM-ZuldazarRaid", 2, 1176)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
--mod:SetCreatureID(138967)--145261 or 147564
mod:SetEncounterID(2271)
--mod:DisableESCombatDetection()
mod:SetZone()
--mod:SetBossHPInfoToHighest()
--mod:SetUsedIcons(1, 2, 8)
--mod:SetHotfixNoticeRev(17775)
--mod:SetMinSyncRevision(16950)
--mod.respawnTime = 35

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 282939 287659 287070 285995 284941",
	"SPELL_CAST_SUCCESS 283507 287648 284081 284493 284470 287072 285014 287037",
	"SPELL_AURA_APPLIED 284798 283507 287648 284470 287072 285014 287037",
--	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED 284798 283507 287648 284470 287072 285014",
	"UNIT_DIED",
	"UNIT_SPELLCAST_START boss1 boss2 boss3"
)

--Figure out right crush idea, too many to guess right, also need to see how it's done by source
--TODO, more trap work, especially ruby beam targetting
--The Zandalari Crown Jewels
local warnGrosslyIncandescent			= mod:NewTargetNoFilterAnnounce(284798, 1)
--Stage One: Raiding The Vault
----The Hand of In'zashi
local warnVolatileCharge				= mod:NewTargetAnnounce(283507, 2)
----Traps
local warnFlameJet						= mod:NewSpellAnnounce(285479, 3)
local warnRubyBeam						= mod:NewSpellAnnounce(284081, 3)
local warnPulseToxin					= mod:NewSpellAnnounce(284493, 2)
local warnTimeBomb						= mod:NewTargetAnnounce(284470, 2)
--Stage Two: Toppling the Guardian
local warnPhase2						= mod:NewPhaseAnnounce(2, 2)
local warnLiquidGold					= mod:NewTargetAnnounce(287072, 2)
--local warnRupturingBlood				= mod:NewStackAnnounce(274358, 2, nil, "Tank")

--The Zandalari Crown Jewels
local specWarnGrosslyIncandescent		= mod:NewSpecialWarningYou(284798, nil, nil, nil, 1, 2)
local yellGrosslyIncandescent			= mod:NewYell(284798)
--Stage One: Raiding The Vault
----The Hand of In'zashi
local specWarnVolatileCharge			= mod:NewSpecialWarningMoveAway(283507, nil, nil, nil, 1, 2)
local yellVolatileCharge				= mod:NewYell(283507)
local yellVolatileChargeFade			= mod:NewFadesYell(283507)
----Yalat's Bulwark
local specWarnFlamesofPunishment		= mod:NewSpecialWarningDodge(282939, nil, nil, nil, 2, 2)
----Traps
local specWarnTimeBomb					= mod:NewSpecialWarningMoveAway(284470, nil, nil, nil, 1, 2)
local yellTimeBomb						= mod:NewYell(284470)
local yellTimeBombFade					= mod:NewFadesYell(284470)
--Stage Two: Toppling the Guardian
local specWarnLiquidGold				= mod:NewSpecialWarningMoveAway(287072, nil, nil, nil, 1, 2)
local yellLiquidGold					= mod:NewYell(287072)
local yellLiquidGoldFade				= mod:NewFadesYell(287072)
local specWarnSpiritsofGold				= mod:NewSpecialWarningSwitch(285995, "Dps", nil, nil, 1, 2)
local specWarnCoinShower				= mod:NewSpecialWarningMoveTo(285014, nil, nil, nil, 3, 2)
local yellCoinShower					= mod:NewYell(285014, nil, nil, nil, "YELL")
local yellCoinShowerFade				= mod:NewFadesYell(285014, nil, nil, nil, "YELL")
local specWarnWailofGreed				= mod:NewSpecialWarningCount(284941, nil, nil, nil, 2, 2)
local specWarnCoinSweep					= mod:NewSpecialWarningTaunt(287037, nil, nil, nil, 1, 2)
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)

--mod:AddTimerLine(DBM:EJ_GetSectionInfo(18527))
--Stage One: Raiding The Vault
--local timerCrushCD					= mod:NewCDSourceTimer(55, 283604, nil, nil, nil, 3)--Both
----The Hand of In'zashi
local timerVolatileChargeCD				= mod:NewAITimer(55, 283507, nil, nil, nil, 3)
----Yalat's Bulwark
local timerFlamesofPunishmentCD			= mod:NewAITimer(55, 282939, nil, nil, nil, 3)
----Traps
local timerFlameJetCD					= mod:NewAITimer(55, 285479, nil, nil, nil, 3)
local timerRubyBeamCD					= mod:NewAITimer(55, 284081, nil, nil, nil, 3)
local timerPulseToxinCD					= mod:NewAITimer(55, 284493, nil, nil, nil, 2)
local timerTimeBombCD					= mod:NewAITimer(55, 284470, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
--Stage Two: Toppling the Guardian
local timerDrawPowerCD					= mod:NewCastTimer(5, 282939, nil, nil, nil, 6)
local timerLiquidGoldCD					= mod:NewAITimer(5, 287072, nil, nil, nil, 3)
local timerSpiritsofGoldCD				= mod:NewAITimer(5, 285995, nil, nil, nil, 1)
local timerCoinShowerCD					= mod:NewAITimer(5, 285014, nil, nil, nil, 5, nil, DBM_CORE_DEADLY_ICON)
local timerWailofGreedCD				= mod:NewAITimer(55, 284941, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)
local timerCoinSweepCD					= mod:NewAITimer(14.1, 287037, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON)

--local berserkTimer					= mod:NewBerserkTimer(600)

--local countdownCollapsingWorld			= mod:NewCountdown(50, 243983, true, 3, 3)
--local countdownRupturingBlood				= mod:NewCountdown("Alt12", 244016, false, 2, 3)
--local countdownFelstormBarrage			= mod:NewCountdown("AltTwo32", 244000, nil, nil, 3)

--mod:AddSetIconOption("SetIconGift", 255594, true)
--mod:AddRangeFrameOption("8/10")
--mod:AddInfoFrameOption(258040, true)
--mod:AddNamePlateOption("NPAuraOnPresence", 276093)
--mod:AddSetIconOption("SetIconDarkRev", 273365, true)

mod.vb.phase = 1
mod.vb.wailCast = 0
local grosslyIncandescentTargets = {}

local updateInfoFrame
do
	local grosslyIncan = DBM:GetSpellInfo(284798)
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		--Boss Power
		--[[local currentPower, maxPower = UnitPower("boss1"), UnitPowerMax("boss1")
		if maxPower and maxPower ~= 0 then
			if currentPower / maxPower * 100 >= 1 then
				addLine(UnitName("boss1"), currentPower)
			end
		end--]]
		--The Zandalari Crown Jewels Helper
		for i=1, #grosslyIncandescentTargets do
			local name = grosslyIncandescentTargets[i]
			local uId = DBM:GetRaidUnitId(name)
			if not uId then break end
			addLine(grosslyIncan, UnitName(uId))
		end
		----Player personal checks
		local spellName1, _, _, _, _, expireTime = DBM:UnitDebuff("player", 284556)
		if spellName1 and expireTime then--Personal Shadow-Touched
			local remaining = expireTime-GetTime()
			addLine(spellName1, math.floor(remaining))
		end
		local spellName2, _, currentStack, _, _, expireTime2 = DBM:UnitDebuff("player", 284573)
		if spellName2 and currentStack then--Personal Tailwinds count
			local remaining = expireTime2-GetTime()
			addLine(spellName2.." ("..currentStack..")", math.floor(remaining))
		end
		local spellName3, _, currentStack2, _, _, expireTime3 = DBM:UnitDebuff("player", 284614)
		if spellName3 and currentStack2 then--Personal Focused Animus count
			local remaining = expireTime3-GetTime()
			addLine(spellName3.." ("..currentStack2..")", math.floor(remaining))
		end
		local spellName4, _, currentStack3 = DBM:UnitDebuff("player", 284817)
		if spellName4 and currentStack3 then--Personal Earthen Roots count
			addLine(spellName4.." ("..currentStack3..")", "")
		end
		local spellName5, _, currentStack4 = DBM:UnitDebuff("player", 284883)
		if spellName5 and currentStack4 then--Personal Opal of the unleashed Rage count
			addLine(spellName5.." ("..currentStack4..")", "")
		end
		local spellName6, _, _, _, _, expireTime4 = DBM:UnitDebuff("player", 284519)
		if spellName6 and expireTime4 then--Personal Quickened Pulse remaining
			local remaining = expireTime4-GetTime()
			addLine(spellName6, math.floor(remaining))
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.wailCast = 0
--	if self.Options.NPAuraOnPresence then
--		DBM:FireEvent("BossMod_EnableHostileNameplates")
--	end
	timerVolatileChargeCD:Start(1-delay)
	timerFlamesofPunishmentCD:Start(1-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(OVERVIEW)
		DBM.InfoFrame:Show(8, "function", updateInfoFrame, false, false)
	end
end

function mod:OnCombatEnd()
--	if self.Options.RangeFrame then
--		DBM.RangeCheck:Hide()
--	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
--	if self.Options.NPAuraOnPresence then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 282939 or spellId == 287659 then
		specWarnFlamesofPunishment:Show()
		specWarnFlamesofPunishment:Play("watchwave")
		timerFlamesofPunishmentCD:Start()
	elseif spellId == 287070 then
		self.vb.phase = 2
		self.vb.wailCast = 0
		--Do these stop?
		timerTimeBombCD:Stop()
		timerPulseToxinCD:Stop()
		timerRubyBeamCD:Stop()
		timerFlameJetCD:Stop()
		warnPhase2:Show()
		timerDrawPowerCD:Start()
		timerLiquidGoldCD:Start(2)
		timerSpiritsofGoldCD:Start(2)
		timerWailofGreedCD:Start(2)
		timerCoinSweepCD:Start(2)
	elseif spellId == 285995 then
		specWarnSpiritsofGold:Show()
		specWarnSpiritsofGold:Play("killmob")
		timerSpiritsofGoldCD:Start()
	elseif spellId == 284941 then
		self.vb.wailCast = self.vb.wailCast + 1
		specWarnWailofGreed:Show(self.vb.wailCast)
		specWarnWailofGreed:Play("aesoon")
		timerWailofGreedCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 283507 or spellId == 287648 then
		timerVolatileChargeCD:Start()
	elseif spellId == 284081 then
		warnRubyBeam:Show()
		timerRubyBeamCD:Start()
	elseif spellId == 284493 then
		warnPulseToxin:Show()
		timerPulseToxinCD:Start()
	elseif spellId == 284470 then
		timerTimeBombCD:Start()
	elseif spellId == 287072 then
		timerLiquidGoldCD:Start()
	elseif spellId == 285014 then
		timerCoinShowerCD:Start()
	elseif spellId == 287037 then
		timerCoinSweepCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 287037 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			if args:IsPlayer() then
				--specWarnRupturingBlood:Show()
				--specWarnRupturingBlood:Play("defensive")
			else
				--if not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", spellId) then--Can't taunt less you've dropped yours off, period.
					specWarnCoinSweep:Show(args.destName)
					specWarnCoinSweep:Play("tauntboss")
				--end
			end
		end
	elseif spellId == 284798 then
		if args:IsPlayer() then
			specWarnGrosslyIncandescent:Show()
			specWarnGrosslyIncandescent:Play("targetyou")
			yellGrosslyIncandescent:Yell()
		else
			warnGrosslyIncandescent:Show(args.destName)
		end
		if not tContains(grosslyIncandescentTargets, args.destName) then
			table.insert(grosslyIncandescentTargets, args.destName)
		end
	elseif spellId == 283507 or spellId == 287648 then
		if args:IsPlayer() then
			specWarnVolatileCharge:Show()
			specWarnVolatileCharge:Play("runout")
			yellVolatileCharge:Yell()
			yellVolatileChargeFade:Countdown(8)
		else
			warnVolatileCharge:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 284470 then
		if args:IsPlayer() then
			specWarnTimeBomb:Show()
			specWarnTimeBomb:Play("runout")
			yellTimeBomb:Yell()
			yellTimeBombFade:Countdown(10)
		else
			warnTimeBomb:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 287072 then
		if args:IsPlayer() then
			specWarnLiquidGold:Show()
			specWarnLiquidGold:Play("runout")
			yellLiquidGold:Yell()
			yellLiquidGoldFade:Countdown(12)
		else
			warnLiquidGold:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 285014 then
		if args:IsPlayer() then
			specWarnCoinShower:Show(GROUP)
			yellCoinShower:Yell()
			yellCoinShowerFade:Countdown(10)
		elseif not self:IsTank() then--Exclude only tanks
			specWarnCoinShower:Show(args.destName)
		end
		specWarnCoinShower:Play("gathershare")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 284798 then
		tDeleteItem(grosslyIncandescentTargets, args.destName)
	elseif spellId == 283507 or spellId == 287648 then
		if args:IsPlayer() then
			yellVolatileChargeFade:Cancel()
		end
	elseif spellId == 284470 then
		if args:IsPlayer() then
			yellTimeBombFade:Cancel()
		end
	elseif spellId == 287072 then
		if args:IsPlayer() then
			yellLiquidGoldFade:Cancel()
		end
	elseif spellId == 285014 then
		if args:IsPlayer() then
			yellCoinShowerFade:Cancel()
		end
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 228007 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 145273 then--The Hand of In'zashi
		timerVolatileChargeCD:Stop()
	elseif cid == 145274 then--Yalat's Bulwark
		timerFlamesofPunishmentCD:Stop()
	--elseif cid == 147218 then--Spirit of Gold
		
	end
end

function mod:UNIT_SPELLCAST_START(uId, _, spellId)
	if spellId == 283947 and self:AntiSpam(5, 1) then--Flame Jet
		warnFlameJet:Show()
		timerFlameJetCD:Start()
	end
end