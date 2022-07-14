
local cfg = json.load_file("FixedEmScale.json")

if not cfg then	cfg = {	} end
if not cfg.isAdjSize then cfg.isAdjSize = true end
if not cfg.scaleSelection then cfg.scaleSelection = 2 end

json.dump_file("FixedEmScale.json", cfg)


--[[
local maxScale = -1
local minScale = -1
local midScale = -1
local maxScalei, maxScalej = -1, -1
local minScalei, minScalej = -1, -1
local midScalei, midScalej = -1, -1]]

local SRTblInitialized = false
local SRTblHolder = nil

local function getRandomScaleTableDataList()
    local EnemyManager = sdk.get_managed_singleton("snow.enemy.EnemyManager")
	if not EnemyManager then return end

    local BossRandomScale = EnemyManager:get_field("_BossRandomScale")
    if not BossRandomScale then return end

    return BossRandomScale:get_field("_RandomScaleTableDataList")
end


local function changeSRValue()
    RandomScaleTableDataList = getRandomScaleTableDataList()
    if not RandomScaleTableDataList then return end
    
    local BossRandomScaleSize = RandomScaleTableDataList:call("get_Count")
    if not BossRandomScaleSize then return end
    
    for i = 0, BossRandomScaleSize-1 do
        RandomScaleTableData = RandomScaleTableDataList:call("get_Item", i)
        if not RandomScaleTableData then return end
        local Type = RandomScaleTableData:get_field("_Type") -- log type for verif
        if not (Type == SRTblHolder[i+1].type) then return end -- logically useless (equivalent to check if object nil haha)
        --log.debug("lua:log: Type:" .. tostring(Type))
        local scaleRate = RandomScaleTableData:get_field("_ScaleAndRateData")
        if not scaleRate then return end

        local scaleRateSize = scaleRate:call("get_Count")
        if not scaleRateSize then return end
        for j = 0, scaleRateSize-1 do
            scaleRateItem = scaleRate:call("get_Item", j)
            if not scaleRateItem then return end
            scaleRateItem:set_field("_Rate", 0)
        end

        if cfg.scaleSelection == 1 then
            scaleRate:call("get_Item", SRTblHolder[i+1].maxJ - 1):set_field("_Rate", 100)
        elseif cfg.scaleSelection == 2 then
            scaleRate:call("get_Item", SRTblHolder[i+1].minJ - 1):set_field("_Rate", 100)
        elseif cfg.scaleSelection == 3 then
            scaleRate:call("get_Item", SRTblHolder[i+1].midJ - 1):set_field("_Rate", 100)
        else return end
    end

    return true
end

local function restoreSRValue()
    RandomScaleTableDataList = getRandomScaleTableDataList()
    if not RandomScaleTableDataList then return end

    local BossRandomScaleSize = RandomScaleTableDataList:call("get_Count")
    if not BossRandomScaleSize then return end
    
    for i = 0, BossRandomScaleSize-1 do
        RandomScaleTableData = RandomScaleTableDataList:call("get_Item", i)
        if not RandomScaleTableData then return end
        local Type = RandomScaleTableData:get_field("_Type") -- log type for verif
        if not (Type == SRTblHolder[i+1].type) then return end -- logically useless (equivalent to check if object nil haha)
        --log.debug("lua:log: Type:" .. tostring(Type))
        local scaleRate = RandomScaleTableData:get_field("_ScaleAndRateData")
        if not scaleRate then return end

        local scaleRateSize = scaleRate:call("get_Count")
        if not scaleRateSize then return end
        for j = 0, scaleRateSize-1 do
            scaleRateItem = scaleRate:call("get_Item", j)
            if not scaleRateItem then return end
            scaleRateItem:set_field("_Rate", SRTblHolder[i+1].rate[j+1])
        end

    end

    return true
end

local function EachScaleRate(scaleRate, type)
    local scaleRateTable = { }
    --local scaleRateTable.scale = { } --seems no need scale
    scaleRateTable.rate = { }
    scaleRateTable.type = type -- log type for verif

    local scaleRateSize = scaleRate:call("get_Count")
    if not scaleRateSize then return end
    local max = 0
    local min = 2
    local midrate = 0
    local maxj = 1
    local minj = 1
    local midj = 1
    --local mid = 0
    for j = 0, scaleRateSize-1 do
        scaleRateItem = scaleRate:call("get_Item", j)
        if not scaleRateItem then return end
        local scale = scaleRateItem:get_field("_Scale")
        local rate = scaleRateItem:get_field("_Rate")
        if not scale then return end
        if not rate then return end
        --log.debug("lua:log: getSize: inter: scale:" .. tostring(scale)  .. " rate:" .. tostring(rate)) end
        --this j start from 1 as lua like it
        --scaleRateTable.scale[j+1] = scale --seems no need scale
        scaleRateTable.rate[j+1] = rate
        if rate > 0 then
            if scale > max then
                max = scale
                maxj = j + 1
            end
            if scale < min then
                min = scale
                minj = j + 1
            end
            if rate > midrate then
                midrate = rate
                --mid = scale
                midj = j + 1
            end
        end
    end
    -- this J also start from 1 to avoid confusion
    scaleRateTable.maxJ = maxj
    scaleRateTable.minJ = minj
    scaleRateTable.midJ = midj
    --[[
    maxScale = max
    maxScalej = maxi, maxj
    minScale = min
    minScalej = mini, minj
    midScale = mid
    midScalej = midi, midj]]
    return scaleRateTable
end

local function GetScaleAndRateData()
    RandomScaleTableDataList = getRandomScaleTableDataList()
    if not RandomScaleTableDataList then return end

    local BossRandomScaleSize = RandomScaleTableDataList:call("get_Count")
    if not BossRandomScaleSize then return end

    local ScaleAndRateData = {}
    for i = 0, BossRandomScaleSize-1 do
        RandomScaleTableData = RandomScaleTableDataList:call("get_Item", i)
        if not RandomScaleTableData then return end
        local Type = RandomScaleTableData:get_field("_Type")
        if not Type then return end
        --log.debug("lua:log: Type:" .. tostring(Type))
        local scaleRate = RandomScaleTableData:get_field("_ScaleAndRateData")
        if not scaleRate then return end
        -- this i start from 1 as lua like it
        ScaleAndRateData[i+1] = EachScaleRate(scaleRate, Type) --pass type for verif
        if not ScaleAndRateData[i+1] then return end
    end

    return ScaleAndRateData

end


--[[
local function findMinMidMax(RandomScaleTableData)
    local scaleRate = RandomScaleTableData:get_field("_ScaleAndRateData")
    if not scaleRate then return end
    scaleRate = scaleRate:get_elements()
    if not scaleRate then return end
    local max = 0
    local min = 2
    local midrate = 0
    local mid = 0
    for j, scaleRateItem in ipairs(scaleRate) do
        local scale = scaleRateItem:get_field("_Scale")
        local rate = scaleRateItem:get_field("_Rate")
        if not scale then return end
        if not rate then return end
        --log.debug("lua:log: getSize: inter: scale:" .. tostring(scale)  .. " rate:" .. tostring(rate)) end
        if rate > 0 then
            if scale > max then
                max = scale
                maxi = i
                maxj = j
            end
            if scale < min then
                min = scale
                mini = i
                minj = j
            end
            if rate > midrate then
                midrate = rate
                mid = scale
                midi = i
                midj = j
            end
        end
    end
    maxScale = max
    maxScalei, maxScalej = maxi, maxj
    minScale = min
    minScalei, minScalej = mini, minj
    midScale = mid
    midScalei, midScalej = midi, midj
    return true
end

local function getSize(tblType)
	if not tblType then
		return
	end
	local EnemyManager = sdk.get_managed_singleton("snow.enemy.EnemyManager")
	if not EnemyManager then return end

    local BossRandomScale = EnemyManager:get_field("_BossRandomScale") --EnemyBossRandomScaleData getBossRandomScale (if change when get?)
    if not BossRandomScale then return end

    local RandomScaleTableDataList = BossRandomScale:get_field("_RandomScaleTableDataList")
    if not RandomScaleTableDataList then return end

    local BossRandomScaleSize = RandomScaleTableDataList:call("get_Count")
    if not BossRandomScaleSize then return end

    for i = 0, BossRandomScaleSize-1 do
        RandomScaleTableData = RandomScaleTableDataList:call("get_Item", i)
        if not RandomScaleTableData then return end
        local Type = RandomScaleTableData:get_field("_Type")
        if Type == tblType then
            log.debug("lua:log: findMinMidMax[3]: tblType: " .. tostring(tblType))
            return findMinMidMax(RandomScaleTableData)
        end
    end
end

local hasResult = false
local EnemyBossRandomScaleData_type = sdk.find_type_definition("snow.enemy.EnemyBossRandomScaleData")
local EnemyBossRandomScaleData_get_size = EnemyBossRandomScaleData_type:get_method("getBossRandomScale")

--snow.enemy.EnemyManager
--getBossRandomScale
sdk.hook(sdk.find_type_definition("snow.enemy.EnemyManager"):get_method("getBossRandomScale"), function(args)
    log.debug("lua:log: EnemyManager args: ")
    return sdk.PreHookResult.CALL_ORIGINAL
end,  function(retval)
    log.debug("lua:log: EnemyManager retval: ")
    return retval
end)

sdk.hook(EnemyBossRandomScaleData_get_size, function(args)
    tblType = sdk.to_int64(args[3])
    log.debug("lua:log: args[3]: tblType: " .. tostring(tblType))
    if getSize(tblType) then
        hasResult = true
        log.debug("lua:log: getSize: result: mid:" .. tostring(midScale) .. " min:" .. tostring(minScale) .. " max:" .. tostring(maxScale))
    else
        hasResult = false
        log.debug("lua:log: getSizeFail: result: tblType" .. tostring(tblType) .. " mid:" .. tostring(midScale) .. " min:" .. tostring(minScale) .. " max:" .. tostring(maxScale))
    end
    return sdk.PreHookResult.CALL_ORIGINAL
end, 
function(retval)
    if not cfg.isAdjSize then return retval end
    if maxScale == 0 then return retval end
    if minScale == 2 then return retval end
    if midScale == 0 then return retval end

    local EnemyManager = sdk.get_managed_singleton("snow.enemy.EnemyManager")
	if not EnemyManager then return end

    local BossRandomScale = EnemyManager:get_field("_BossRandomScale") --EnemyBossRandomScaleData getBossRandomScale (if change when get?)
    if not BossRandomScale then return end

    local RandomScaleTableDataList = BossRandomScale:get_field("_RandomScaleTableDataList")
    if not RandomScaleTableDataList then return end

    if hasResult then
        if cfg.scaleSelection == 1 then
            log.debug("lua:log: getSize: result::" .. tostring(maxScale))
            --here buged
            shit = RandomScaleTableDataList:call("get_Item", maxScalei-1)
            log.debug("lua:log: getSize: result1::" .. tostring(shit))
            shit = get_field("_ScaleAndRateData")
            log.debug("lua:log: getSize: result2::" .. tostring(shit))
            shit = call("get_Item", maxScalej-1)
            log.debug("lua:log: getSize: result3::" .. tostring(shit))
            shit = get_field("_Scale")
            log.debug("lua:log: getSize: result4::" .. tostring(shit))
            return maxScale
        elseif cfg.scaleSelection == 2 then
            log.debug("lua:log: getSize: result::" .. tostring(minScale))
            return minScale
        elseif cfg.scaleSelection == 3 then
            log.debug("lua:log: getSize: result::" .. tostring(midScale))
            return midScale
        end
    end

    log.debug("lua:log: args[3]: cfg.scaleSelection out of range: " .. tostring(cfg.scaleSelection))
    return retval
end)
]]


--local drawSetting = false

local script_state = "FixedEmScale script V2 - Not Initialize"
re.on_application_entry("UpdateScene", function()
    if not SRTblInitialized then
        -- try dump SRTbl until true
        SRTblHolder = GetScaleAndRateData()
        if SRTblHolder then
            SRTblInitialized = true
            script_state = "FixedEmScale script V2 - Select to fix scale"
            if cfg.isAdjSize then
                if not changeSRValue() then
                    log.debug("lua:log: changeSRValue() fail")
                    script_state = "FixedEmScale script V2 - fail to apply change, try again"
                end
            end
        end
    end
    --[[
	if drawSetting then
		if imgui.begin_window("Fixed Enemy Scale setting", true, 0) then
            local saveChanged = false
			changed, value = imgui.checkbox("enable this mod", cfg.isAdjSize)
			if changed then cfg.isAdjSize = value
                if cfg.isAdjSize then 
                    changeSRValue()
                else
                    restoreSRValue()
                end
                saveChanged = true
            end

            imgui.text("")
            imgui.text("select the enemy scale you want to fix to")
            changed, value = imgui.combo("dropDownList", cfg.scaleSelection, {"Max possible scale","Min possible scale","Most possible scale(Mid, usually 1.00)"})
			if changed then
                cfg.scaleSelection = value
                if cfg.isAdjSize then 
                    if not changeSRValue() then
                        log.debug("lua:log: changeSRValue() fail")
                    end
                end
                saveChanged = true
            end

			if saveChanged then json.dump_file("FixedEmScale.json", cfg) end

			imgui.spacing()
			imgui.end_window()
		else
			drawSetting = false
		end
	end]]
end)

re.on_draw_ui(function()
    
    --if string.len(script_name) > 0 then
    --    imgui.text(script_name+" ")
    --end
    --imgui.same_line()
    --if imgui.button("FixedEmScale Setting") then
    --    drawSetting = true
    --end
    local saveChanged = false
    changed, value = imgui.combo(script_state, cfg.scaleSelection, {"Max possible scale","Min possible scale","Most possible scale(Mid, usually 1.00)","Disable the script"})
    if changed then
        if value == 4 then
            cfg.isAdjSize = false
            cfg.scaleSelection = value
            if SRTblInitialized then
                if not restoreSRValue() then
                    log.debug("lua:log: restoreSRValue() fail")
                    script_state = "FixedEmScale script V2 - fail to disable, try again"
                end
            end
        else
            cfg.isAdjSize = true
            cfg.scaleSelection = value
            if SRTblInitialized then
                if not changeSRValue() then
                    log.debug("lua:log: changeSRValue() fail")
                    script_state = "FixedEmScale script V2 - fail to apply change, try again"
                end
            end
        end

        saveChanged = true
    end

    if saveChanged then json.dump_file("FixedEmScale.json", cfg) end
    saveChanged = false -- lazy to check if local var reset inside on draw

end)
