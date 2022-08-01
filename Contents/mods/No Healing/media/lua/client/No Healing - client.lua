local noHealingRecord = {}

---@param player IsoPlayer|IsoGameCharacter
local function noHeal(player)

    noHealingRecord[player] = noHealingRecord[player] or {}

    local pBodyDamage = player:getBodyDamage()
    local pbdBodyParts = pBodyDamage:getBodyParts()

    if SandboxVars.NoHealing.Food then
        pBodyDamage:setHealthFromFoodTimer(0)
    end

    if SandboxVars.NoHealing.Passive then
        pBodyDamage:setStandardHealthAddition(0)
        pBodyDamage:setReducedHealthAddition(0)
        pBodyDamage:setSeverlyReducedHealthAddition(0)
    end
    
    if SandboxVars.NoHealing.Sleeping then
        pBodyDamage:setSleepingHealthAddition(0)
    end

    --getGameTime():getMultiplier()

    for i=0, pbdBodyParts:size()-1 do
        ---@type BodyPart
        local BodyPart = pbdBodyParts:get(i)
        local bpIndex = BodyPart:getIndex()+1

        noHealingRecord[player][bpIndex] = noHealingRecord[player][bpIndex] or {}

        --noHealingRecord[player][bpIndex]["lastHealth"] = math.min((noHealingRecord[player][bpIndex]["lastHealth"] or BodyPart:getHealth()), BodyPart:getHealth())
        --BodyPart:SetHealth(noHealingRecord[player][bpIndex]["lastHealth"])

        if SandboxVars.NoHealing.Scratch then
            noHealingRecord[player][bpIndex]["lastScratchTime"] = math.max((noHealingRecord[player][bpIndex]["lastScratchTime"] or 0), BodyPart:getScratchTime())
            BodyPart:setScratchTime(noHealingRecord[player][bpIndex]["lastScratchTime"])
        end

        if SandboxVars.NoHealing.Cut then
            noHealingRecord[player][bpIndex]["lastCutTime"] = math.max((noHealingRecord[player][bpIndex]["lastCutTime"] or 0), BodyPart:getCutTime())
            BodyPart:setCutTime(noHealingRecord[player][bpIndex]["lastCutTime"])
        end

        if SandboxVars.NoHealing.Bite then
            noHealingRecord[player][bpIndex]["lastBiteTime"] = math.max((noHealingRecord[player][bpIndex]["lastBiteTime"] or 0), BodyPart:getBiteTime())
            BodyPart:setBiteTime(noHealingRecord[player][bpIndex]["lastBiteTime"])
        end

        if SandboxVars.NoHealing.Bleeding then
            noHealingRecord[player][bpIndex]["lastBleedingTime"] = math.max((noHealingRecord[player][bpIndex]["lastBleedingTime"] or 0), BodyPart:getBleedingTime())
            BodyPart:setBleedingTime(noHealingRecord[player][bpIndex]["lastBleedingTime"])
        end

        if SandboxVars.NoHealing.Burn then
            noHealingRecord[player][bpIndex]["lastBurnTime"] = math.max((noHealingRecord[player][bpIndex]["lastBurnTime"] or 0), BodyPart:getBurnTime())
            BodyPart:setBurnTime(noHealingRecord[player][bpIndex]["lastBurnTime"])
        end

        if SandboxVars.NoHealing.Fracture then
            noHealingRecord[player][bpIndex]["lastFractureTime"] = math.max((noHealingRecord[player][bpIndex]["lastFractureTime"] or 0), BodyPart:getFractureTime())
            BodyPart:setFractureTime(noHealingRecord[player][bpIndex]["lastFractureTime"])
        end

        if SandboxVars.NoHealing.DeepWound then
            noHealingRecord[player][bpIndex]["lastDeepWoundTime"] = math.max((noHealingRecord[player][bpIndex]["lastDeepWoundTime"] or 0), BodyPart:getDeepWoundTime())
            BodyPart:setDeepWoundTime(noHealingRecord[player][bpIndex]["lastDeepWoundTime"])
        end

    end
end
Events.OnPlayerUpdate.Add(noHeal)