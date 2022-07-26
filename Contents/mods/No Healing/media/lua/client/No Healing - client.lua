local noHealingRecord = {}

---@param player IsoPlayer|IsoGameCharacter
local function noHeal(player)

    noHealingRecord[player] = noHealingRecord[player] or {}

    local pBodyDamage = player:getBodyDamage()
    local pbdBodyParts = pBodyDamage:getBodyParts()

    for i=0, pbdBodyParts:size()-1 do
        ---@type BodyPart
        local BodyPart = pbdBodyParts:get(i)
        local bpIndex = BodyPart:getIndex()

        noHealingRecord[player][bpIndex]["lastScratchTime"] = math.max((noHealingRecord[player][bpIndex]["lastScratchTime"] or 0), player:getScratchTime())
        noHealingRecord[player][bpIndex]["lastCutTime"] = math.max((noHealingRecord[player][bpIndex]["lastCutTime"] or 0), player:getCutTime())
        noHealingRecord[player][bpIndex]["lastBiteTime"] = math.max((noHealingRecord[player][bpIndex]["lastBiteTime"] or 0), player:getBiteTime())
        noHealingRecord[player][bpIndex]["lastBleedingTime"] = math.max((noHealingRecord[player][bpIndex]["lastBleedingTime"] or 0), player:getBleedingTime())
        noHealingRecord[player][bpIndex]["lastBurnTime"] = math.max((noHealingRecord[player][bpIndex]["lastBurnTime"] or 0), player:getBurnTime())
        noHealingRecord[player][bpIndex]["lastFractureTime"] = math.max((noHealingRecord[player][bpIndex]["lastFractureTime"] or 0), player:getFractureTime())
        noHealingRecord[player][bpIndex]["lastDeepWoundTime"] = math.max((noHealingRecord[player][bpIndex]["lastDeepWoundTime"] or 0), player:getDeepWoundTime())
        
    end
end
Events.OnPlayerUpdate.Add(noHeal)