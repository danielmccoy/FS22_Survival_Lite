----------------------------------------------------------------------------------------------------
-- Entry point of FS22_Survival mod
--
-- Copyright (c) Schliesser, 2021
----------------------------------------------------------------------------------------------------
Survival = {}
Survival.name = "Survival"

function Survival:loadMap()
    print('Survival: Difficulty raised!')

    -- disable loan
    Farm.MIN_LOAN = 0
    Farm.MAX_LOAN = 0

    -- override lease button callback of shop menu
    ShopConfigScreen.updateButtons = Utils.prependedFunction(ShopConfigScreen.updateButtons, Survival.updateButtons)

    -- override sleep check
    SleepManager.getCanSleep = Utils.overwrittenFunction(SleepManager.getCanSleep, Survival.disableFunction)

    -- override AI helper cost
    AIJob.getPricePerMs = Utils.overwrittenFunction(AIJob.getPricePerMs, Survival.getPricePerMs);
    AIJobFieldWork.getPricePerMs = Utils.overwrittenFunction(AIJobFieldWork.getPricePerMs, Survival.getPricePerMs)
    AIJobConveyor.getPricePerMs = Utils.overwrittenFunction(AIJobConveyor.getPricePerMs, Survival.getPricePerMs)

    -- override terraforming cost
    Landscaping.SCULPT_BASE_COST_PER_M3 = 0
end

-- prevent leasing in shop
function Survival:updateButtons(storeItem, vehicle, saleItem)
    storeItem.allowLeasing = false
end

-- return false to disable overwritten function
function Survival:disableFunction()
    return false
end

-- reduce AI helper cost
function Survival:getPricePerMs(sFunc)
    return 2000/1000/60/60; -- 2000 units per real life hour
end;

addModEventListener(Survival)
