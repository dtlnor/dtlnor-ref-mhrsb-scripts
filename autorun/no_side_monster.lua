local cfg = json.load_file("ArenaTargetQuest.json")

if not cfg then
	cfg = {
	}
	Target_questNo = {
		203,
		206,
		207,
		202,
		305,
		306,
		307,
		308,
		309,
		303,
		311,
		404,
		405,
		406,
		407,
		408,
		409,
		402,
		411,
		503,
		504,
		505,
		506,
		507,
		501,
		601,
		604,
		605,
		606,
		10104,
		10105,
		10106,
		10107,
		10108,
		10109,
		10110,
		10204,
		10205,
		10206,
		10207,
		10208,
		10209,
		10210,
		10211,
		10203,
		10303,
		10304,
		10305,
		10306,
		10307,
		10308,
		10309,
		10310,
		10311,
		10312,
		10313,
		10314,
		10302,
		10404,
		10406,
		10407,
		10408,
		10409,
		10410,
		10411,
		10413,
		10504,
		10505,
		10506,
		10507,
		10508,
		10509,
		10510,
		10503,
		10511,
		10604,
		10605,
		10606,
		10607,
		10608,
		10609,
		10610,
		10602,
		10616,
		10708,
		10709,
		10710,
		10711,
		10712,
		10713,
		10701,
		10702,
		10721,
		10703,
		10704,
		10705,
		10707,
		10725,
		10726,
		10727,
		10728,
		10729,
		10730,
		10731,
		10733,
		10734,
		10735,
		10736,
		10737,
		10738,
		10739,
		10740,
	}
	cfg.target_questNo = Target_questNo
	
	json.dump_file("ArenaTargetQuest.json", cfg)
end

local function dump_quest_data(normalQuestData_array, normalQuestDataForEnemy_array)
	for i,quest in ipairs(normalQuestDataForEnemy_array) do
		local QuestNo = quest:get_field("_QuestNo")
		if QuestNo == nil then return
		else
			--if checkQuestNo(QuestNo) then

				cfg_QuestData.read_only_quest_data[tostring(QuestNo)] = {}
				
				local value = quest:get_field("_EmsSetNo")
				cfg_QuestData.read_only_quest_data[tostring(QuestNo)].EmsSetNo = value
				--log.debug("lua:log:"..tostring(value))
					
				local RouteNo = quest:get_field("_RouteNo")
				local value = RouteNo[0]:get_field("mValue")
				cfg_QuestData.read_only_quest_data[tostring(QuestNo)].RouteNo_0 = value
				--log.debug("lua:log:"..tostring(value))

				local InitSetName = quest:get_field("_InitSetName")
				local value = InitSetName:call("GetValue(System.Int32)", 0)
				value = value:call("Substring(System.Int32)",0)
				cfg_QuestData.read_only_quest_data[tostring(QuestNo)].InitSetName_0 = value
				--log.debug("lua:log:"..value)

			--end

		end
	end

	for i,quest in ipairs(normalQuestData_array) do
		local QuestNo = quest:get_field("_QuestNo")
		if QuestNo == nil then return
		else
			--if checkQuestNo(QuestNo) then 
				local value = quest:get_field("_MapNo")
				cfg_QuestData.read_only_quest_data[tostring(QuestNo)].MapNo = value
				--log.debug("lua:log:"..tostring(value))

				local value = quest:get_field("_InitExtraEmNum")
				cfg_QuestData.read_only_quest_data[tostring(QuestNo)].InitExtraEmNum = value
				--log.debug("lua:log:"..tostring(value))

				local BossEmType = quest:get_field("_BossEmType")
				BossEmType = BossEmType:get_elements()
				cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType = {}
				for i, value in ipairs(BossEmType) do
					cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType[tostring(i)] = value:get_field("value__")
					--log.debug("lua:log:"..tostring(value:get_field("value__")))
				end

				local SwapEmRate = quest:get_field("_SwapEmRate")
				cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapEmRate = {}
				SwapEmRate = SwapEmRate:get_elements()
				for i, value in ipairs(SwapEmRate) do
					cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapEmRate[tostring(i)] = value:get_field("mValue")
					--log.debug("lua:log:"..tostring(value:get_field("mValue")))
				end
				
				local BossSetCondition = quest:get_field("_BossSetCondition")
				cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossSetCondition = {}
				BossSetCondition = BossSetCondition:get_elements()
				for i, value in ipairs(BossSetCondition) do
					cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossSetCondition[tostring(i)] = value:get_field("value__")
					--log.debug("lua:log:"..tostring(value:get_field("value__")))
				end

				local SwapSetCondition = quest:get_field("_SwapSetCondition")
				cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetCondition = {}
				SwapSetCondition = SwapSetCondition:get_elements()
				for i, value in ipairs(SwapSetCondition) do
					cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetCondition[tostring(i)] = value:get_field("value__")
					--log.debug("lua:log:"..tostring(value:get_field("value__")))
				end

				local SwapSetParam = quest:get_field("_SwapSetParam")
				cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetParam = {}
				SwapSetParam = SwapSetParam:get_elements()
				for i, value in ipairs(SwapSetParam) do
					cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetParam[tostring(i)] = value:get_field("mValue")
					--log.debug("lua:log:"..tostring(value:get_field("mValue")))
				end

				local SwapExitTime = quest:get_field("_SwapExitTime")
				cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapExitTime = {}
				SwapExitTime = SwapExitTime:get_elements()
				for i, value in ipairs(SwapExitTime) do
					cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapExitTime[tostring(i)] = value:get_field("mValue")
					--log.debug("lua:log:"..tostring(value:get_field("mValue")))
				end
			--end
		end
	end
end

local function dump_quest()
	log.debug("lua:log: dump_quest")

    local questman = sdk.get_managed_singleton("snow.QuestManager")
    if not questman then return end

    local normalQuestData = questman:get_field("_normalQuestData")
	if normalQuestData == nil then return end
    local normalQuestData_array = normalQuestData:get_field("_Param")
	if normalQuestData_array == nil then return end
	normalQuestData_array = normalQuestData_array:get_elements()
    local normalQuestDataForEnemy = questman:get_field("_normalQuestDataForEnemy")
	if normalQuestDataForEnemy == nil then return end
    local normalQuestDataForEnemy_array = normalQuestDataForEnemy:get_field("_Param")
	if normalQuestDataForEnemy_array == nil then return end
	normalQuestDataForEnemy_array = normalQuestDataForEnemy_array:get_elements()

	local DlQuestData = questman:get_field("_DlQuestData")
	if DlQuestData == nil then return end
    local DlQuestData_array = DlQuestData:get_field("_Param")
	if DlQuestData_array == nil then return end
	DlQuestData_array = DlQuestData_array:get_elements()
    local DlQuestDataForEnemy = questman:get_field("_DlQuestDataForEnemy")
	if DlQuestDataForEnemy == nil then return end
    local DlQuestDataForEnemy_array = DlQuestDataForEnemy:get_field("_Param")
	if DlQuestDataForEnemy_array == nil then return end
	DlQuestDataForEnemy_array = DlQuestDataForEnemy_array:get_elements()

	dump_quest_data( normalQuestData_array, normalQuestDataForEnemy_array)
	dump_quest_data( DlQuestData_array, DlQuestDataForEnemy_array)

	log.debug("lua:log: dump_quest end")
end

local function checkQuestNo(questNo)
	
	for i, quest in ipairs(cfg.target_questNo) do
		if questNo == quest then
			return true
		end
	end
	return false
end

local function set_quest_data(isArena, normalQuestData_array, normalQuestDataForEnemy_array)

	for i,quest in ipairs(normalQuestData_array) do
		local QuestNo = quest:get_field("_QuestNo")
		if QuestNo == nil then return
		else
			if checkQuestNo(QuestNo) then 
				quest:set_field("_InitExtraEmNum", 0)

				local BossEmType = quest:get_field("_BossEmType")
				local value = sdk.create_instance("snow.enemy.EnemyDef.EmTypes")
				value:set_field("value__", 0)
				BossEmType:call("SetValue(System.Object, System.Int32)", value, 1)
				BossEmType:call("SetValue(System.Object, System.Int32)", value, 2)
				BossEmType:call("SetValue(System.Object, System.Int32)", value, 3)
				BossEmType:call("SetValue(System.Object, System.Int32)", value, 4)
				BossEmType:call("SetValue(System.Object, System.Int32)", value, 5)
				BossEmType:call("SetValue(System.Object, System.Int32)", value, 6)

				local SwapEmRate = quest:get_field("_SwapEmRate")
				local value = sdk.create_instance("System.Byte")
				value:set_field("mValue", 0)
				SwapEmRate:call("SetValue(System.Object, System.Int32)", value, 0)
				SwapEmRate:call("SetValue(System.Object, System.Int32)", value, 1)
				
				local BossSetCondition = quest:get_field("_BossSetCondition")
				local value = sdk.create_instance("snow.QuestManager.BossSetCondition")
				value:set_field("value__", 1)
				BossSetCondition:call("SetValue(System.Object, System.Int32)", value, 0)
				
				local SwapSetCondition = quest:get_field("_SwapSetCondition")
				value = sdk.create_instance("snow.QuestManager.SwapSetCondition")
				value:set_field("value__", 0)
				SwapSetCondition:call("SetValue(System.Object, System.Int32)", value, 0)
				SwapSetCondition:call("SetValue(System.Object, System.Int32)", value, 1)

				local SwapSetParam = quest:get_field("_SwapSetParam")
				local value = sdk.create_instance("System.Byte")
				value:set_field("mValue", 0)
				SwapSetParam:call("SetValue(System.Byte, System.Int32)", value, 0)
				SwapSetParam:call("SetValue(System.Byte, System.Int32)", value, 1)

				local SwapExitTime = quest:get_field("_SwapExitTime")
				local value = sdk.create_instance("System.Byte")
				value:set_field("mValue", 0)
				SwapExitTime:call("SetValue(System.Byte, System.Int32)", value, 0)
				SwapExitTime:call("SetValue(System.Byte, System.Int32)", value, 1)
			end
		end
	end
end

local function set_quest(isArena)
	log.debug("lua:log: set_localQuestData")

    local questman = sdk.get_managed_singleton("snow.QuestManager")
    if not questman then return end

    local normalQuestData = questman:get_field("_normalQuestData")
	if normalQuestData == nil then return end
    local normalQuestData_array = normalQuestData:get_field("_Param")
	if normalQuestData_array == nil then return end
	normalQuestData_array = normalQuestData_array:get_elements()
    local normalQuestDataForEnemy = questman:get_field("_normalQuestDataForEnemy")
	if normalQuestDataForEnemy == nil then return end
    local normalQuestDataForEnemy_array = normalQuestDataForEnemy:get_field("_Param")
	if normalQuestDataForEnemy_array == nil then return end
	normalQuestDataForEnemy_array = normalQuestDataForEnemy_array:get_elements()

	local DlQuestData = questman:get_field("_DlQuestData")
	if DlQuestData == nil then return end
    local DlQuestData_array = DlQuestData:get_field("_Param")
	if DlQuestData_array == nil then return end
	DlQuestData_array = DlQuestData_array:get_elements()
    local DlQuestDataForEnemy = questman:get_field("_DlQuestDataForEnemy")
	if DlQuestDataForEnemy == nil then return end
    local DlQuestDataForEnemy_array = DlQuestDataForEnemy:get_field("_Param")
	if DlQuestDataForEnemy_array == nil then return end
	DlQuestDataForEnemy_array = DlQuestDataForEnemy_array:get_elements()

	set_quest_data(isArena, normalQuestData_array, normalQuestDataForEnemy_array)
	set_quest_data(isArena, DlQuestData_array, DlQuestDataForEnemy_array)

	log.debug("lua:log: set_localQuestData end")
end

local function load_quest_data(normalQuestData_array, normalQuestDataForEnemy_array)
	for i,quest in ipairs(normalQuestDataForEnemy_array) do
		local QuestNo = quest:get_field("_QuestNo")
		if QuestNo == nil then return
		else
			if not (QuestNo == 0) then
				quest:set_field("_EmsSetNo", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].EmsSetNo)

				local RouteNo = quest:get_field("_RouteNo")
				local value = sdk.create_instance("System.Byte")
				value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].RouteNo_0)
				RouteNo:call("SetValue(System.Object, System.Int32)", value, 0)

				local InitSetName = quest:get_field("_InitSetName")
				local value = sdk.create_managed_string(cfg_QuestData.read_only_quest_data[tostring(QuestNo)].InitSetName_0)
				InitSetName:call("SetValue(System.Object, System.Int32)", value, 0)
				quest:set_field("_InitSetName", InitSetName)
			end
		end
	end

	for i,quest in ipairs(normalQuestData_array) do
		local QuestNo = quest:get_field("_QuestNo")
		if QuestNo == nil then return
		else
			if not (QuestNo == 0) then 
				local Map = cfg_QuestData.read_only_quest_data[tostring(QuestNo)].MapNo
				quest:set_field("_MapNo", Map)
				quest:set_field("_InitExtraEmNum", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].InitExtraEmNum)

				local BossEmType = quest:get_field("_BossEmType")
				local value = sdk.create_instance("snow.enemy.EnemyDef.EmTypes")
				value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType["2"])
				BossEmType:call("SetValue(System.Object, System.Int32)", value, 1)
				value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType["3"])
				BossEmType:call("SetValue(System.Object, System.Int32)", value, 2)
				value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType["4"])
				BossEmType:call("SetValue(System.Object, System.Int32)", value, 3)
				value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType["5"])
				BossEmType:call("SetValue(System.Object, System.Int32)", value, 4)
				value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType["6"])
				BossEmType:call("SetValue(System.Object, System.Int32)", value, 5)
				value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType["7"])
				BossEmType:call("SetValue(System.Object, System.Int32)", value, 6)

				local SwapEmRate = quest:get_field("_SwapEmRate")
				local value = sdk.create_instance("System.Byte")
				value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapEmRate["1"])
				SwapEmRate:call("SetValue(System.Object, System.Int32)", value, 0)
				value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapEmRate["2"])
				SwapEmRate:call("SetValue(System.Object, System.Int32)", value, 1)
				
				local BossSetCondition = quest:get_field("_BossSetCondition")
				local value = sdk.create_instance("snow.QuestManager.BossSetCondition")
				value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossSetCondition["1"])
				BossSetCondition:call("SetValue(System.Object, System.Int32)", value, 0)
				
				local SwapSetCondition = quest:get_field("_SwapSetCondition")
				value = sdk.create_instance("snow.QuestManager.SwapSetCondition")
				value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetCondition["1"])
				SwapSetCondition:call("SetValue(System.Object, System.Int32)", value, 0)
				value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetCondition["2"])
				SwapSetCondition:call("SetValue(System.Object, System.Int32)", value, 1)

				local SwapSetParam = quest:get_field("_SwapSetParam")
				local value = sdk.create_instance("System.Byte")
				value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetParam["1"])
				SwapSetParam:call("SetValue(System.Byte, System.Int32)", value, 0)
				value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetParam["2"])
				SwapSetParam:call("SetValue(System.Byte, System.Int32)", value, 1)

				local SwapExitTime = quest:get_field("_SwapExitTime")
				local value = sdk.create_instance("System.Byte")
				value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapExitTime["1"])
				SwapExitTime:call("SetValue(System.Byte, System.Int32)", value, 0)
				value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapExitTime["2"])
				SwapExitTime:call("SetValue(System.Byte, System.Int32)", value, 1)
			end
		end
	end
end

local function load_quest()
	log.debug("lua:log: load_quest")

    local questman = sdk.get_managed_singleton("snow.QuestManager")
    if not questman then return end

    local normalQuestData = questman:get_field("_normalQuestData")
	if normalQuestData == nil then return end
    local normalQuestData_array = normalQuestData:get_field("_Param")
	if normalQuestData_array == nil then return end
	normalQuestData_array = normalQuestData_array:get_elements()
    local normalQuestDataForEnemy = questman:get_field("_normalQuestDataForEnemy")
	if normalQuestDataForEnemy == nil then return end
    local normalQuestDataForEnemy_array = normalQuestDataForEnemy:get_field("_Param")
	if normalQuestDataForEnemy_array == nil then return end
	normalQuestDataForEnemy_array = normalQuestDataForEnemy_array:get_elements()

	local DlQuestData = questman:get_field("_DlQuestData")
	if DlQuestData == nil then return end
    local DlQuestData_array = DlQuestData:get_field("_Param")
	if DlQuestData_array == nil then return end
	DlQuestData_array = DlQuestData_array:get_elements()
    local DlQuestDataForEnemy = questman:get_field("_DlQuestDataForEnemy")
	if DlQuestDataForEnemy == nil then return end
    local DlQuestDataForEnemy_array = DlQuestDataForEnemy:get_field("_Param")
	if DlQuestDataForEnemy_array == nil then return end
	DlQuestDataForEnemy_array = DlQuestDataForEnemy_array:get_elements()

	load_quest_data(normalQuestData_array, normalQuestDataForEnemy_array)
	load_quest_data(DlQuestData_array, DlQuestDataForEnemy_array)

	log.debug("lua:log: load_quest end")
end

needs_initial_quest_data = false

local status = "default"

needs_initial_quest_data = true

re.on_pre_application_entry("UpdateBehavior", function() 
	
    if needs_initial_quest_data then
		set_quest(true)
		status = "no side monster"
        needs_initial_quest_data = false
    end
end)

re.on_draw_ui(
    function() 
		
        if string.len(status) > 0 then
            imgui.text(status)
        end
		imgui.same_line()
        if imgui.button("set no side monster") then
            set_quest(true)
			status = "no side monster"
        end
		imgui.same_line()
		if imgui.button("reset") then
			cfg_QuestData = json.load_file("QuestDataDump.json")
			if not cfg_QuestData then
				cfg_QuestData = {
				}
				cfg_QuestData.read_only_quest_data = {}
				dump_quest()
				json.dump_file("QuestDataDump.json", cfg_QuestData)
			end
            load_quest()
			status = "default"
        end

    end
)