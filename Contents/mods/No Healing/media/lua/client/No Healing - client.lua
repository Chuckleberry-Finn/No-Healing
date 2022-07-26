local noHealingRecord = {}

---@param player IsoPlayer|IsoGameCharacter
local function noHeal(player)

    noHealingRecord[player] = noHealingRecord[player] or {}

    local pBodyDamage = player:getBodyDamage()
    local pbdBodyParts = pBodyDamage:getBodyParts()

    pBodyDamage:setHealthFromFoodTimer(0)
    pBodyDamage:setHealthFromFood(0)

    for i=0, pbdBodyParts:size()-1 do
        ---@type BodyPart
        local BodyPart = pbdBodyParts:get(i)
        local bpIndex = BodyPart:getIndex()+1

        noHealingRecord[player][bpIndex] = noHealingRecord[player][bpIndex] or {}

        noHealingRecord[player][bpIndex]["lastHealth"] = math.min((noHealingRecord[player][bpIndex]["lastHealth"] or BodyPart:getHealth()), BodyPart:getHealth())
        BodyPart:SetHealth(noHealingRecord[player][bpIndex]["lastHealth"])
        noHealingRecord[player][bpIndex]["lastScratchTime"] = math.max((noHealingRecord[player][bpIndex]["lastScratchTime"] or 0), BodyPart:getScratchTime())
        BodyPart:setScratchTime(noHealingRecord[player][bpIndex]["lastScratchTime"])
        noHealingRecord[player][bpIndex]["lastCutTime"] = math.max((noHealingRecord[player][bpIndex]["lastCutTime"] or 0), BodyPart:getCutTime())
        BodyPart:setCutTime(noHealingRecord[player][bpIndex]["lastCutTime"])
        noHealingRecord[player][bpIndex]["lastBiteTime"] = math.max((noHealingRecord[player][bpIndex]["lastBiteTime"] or 0), BodyPart:getBiteTime())
        BodyPart:setBiteTime(noHealingRecord[player][bpIndex]["lastBiteTime"])
        noHealingRecord[player][bpIndex]["lastBleedingTime"] = math.max((noHealingRecord[player][bpIndex]["lastBleedingTime"] or 0), BodyPart:getBleedingTime())
        BodyPart:setBleedingTime(noHealingRecord[player][bpIndex]["lastBleedingTime"])
        noHealingRecord[player][bpIndex]["lastBurnTime"] = math.max((noHealingRecord[player][bpIndex]["lastBurnTime"] or 0), BodyPart:getBurnTime())
        BodyPart:setBurnTime(noHealingRecord[player][bpIndex]["lastBurnTime"])
        noHealingRecord[player][bpIndex]["lastFractureTime"] = math.max((noHealingRecord[player][bpIndex]["lastFractureTime"] or 0), BodyPart:getFractureTime())
        BodyPart:setFractureTime(noHealingRecord[player][bpIndex]["lastFractureTime"])
        noHealingRecord[player][bpIndex]["lastDeepWoundTime"] = math.max((noHealingRecord[player][bpIndex]["lastDeepWoundTime"] or 0), BodyPart:getDeepWoundTime())
        BodyPart:setDeepWoundTime( noHealingRecord[player][bpIndex]["lastDeepWoundTime"])
    end
end
Events.OnPlayerUpdate.Add(noHeal)