local Major = 3
local Minor = 2
local VERSION = Major+(Minor*0.1)

local needs_initial_quest_data = true
local cfg_QuestData = json.load_file("QuestDataDump.json")
if cfg_QuestData then needs_initial_quest_data = false end

local cfg = json.load_file("ArenaTargetQuest.json")

if not cfg then
	cfg = {	}
	local Target_questNo = {
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
		60101,
		60102,
		60103,
		60104,
		60105,
		60107,
		60108,
		60111,
		60112,
		60114,
		60117,
		60118,
		60119,
		60124,
		60125,
		60127,
		60128,
		60135,
		60143,
		60146,
		60147,
		60148,
		60149,
		60150,
		60151,
		60152,
		315100,
		315102,
		315103,
		315104,
		315108,
		315190,
		315109,
		315110,
		315111,
		315112,
		315122,
		315160,
		405200,
		315201,
		315202,
		315203,
		315204,
		315220,
		315200,
		315260,
		465201,
		465202,
		455201,
		455202,
		455204,
		455205,
		315290,
		315205,
		315206,
		315207,
		315214,
		465203,
		455203,
		455206,
		405300,
		315301,
		315302,
		315303,
		315304,
		315318,
		465301,
		465308,
		465306,
		455301,
		455302,
		455303,
		455307,
		315390,
		315306,
		315307,
		315308,
		315321,
		465305,
		465302,
		465307,
		465309,
		455313,
		455308,
		455310,
		455312,
		405400,
		315401,
		315402,
		315403,
		315429,
		465406,
		465407,
		455401,
		455402,
		315490,
		315406,
		315407,
		315408,
		315414,
		315415,
		465405,
		465408,
		465403,
		455406,
		455407,
		455408,
		315491,
		315418,
		315419,
		315420,
		465401,
		465410,
		465409,
		465402,
		455409,
		455410,
		455411,
		455412,
		455414,
		405500,
		315501,
		315502,
		315523,
		315500,
		465501,
		455501,
		455508,
		315590,
		315507,
		315506,
		315509,
		315508,
		315511,
		315510,
		465507,
		465505,
		465502,
		455511,
		455512,
		455513,
		315591,
		315607,
		315608,
		465601,
		465602,
		455601,
		455602,
		315613,
		315614,
		315615,
		315616,
		315617,
		315618,
		315619,
		315620,
		315621,
		315622,
		315623,
		315624,
		465604,
		455604,
		455611,
		455612,
		385100,
		385101,
		385102,
		385103,
		385104,
		385105,
		385106,
		385201,
		385202,
		385203,
		385204,
		385205,
		385206,
		385207,
		385208,
		385301,
		385302,
		385303,
		385304,
		385305,
		385306,
		385307,
		385308,
		315603,
		385401,
		385402,
		385403,
		385404,
		385405,
		385406,
		385407,
		385408,
		315604,
		315605,
		315602,
		315629,
		455614,
		455615,
		455616,
		385501,
		385502,
		385503,
		385504,
		385505,
		385506,
		385507,
		385508,
		385509,
	}
	cfg.target_questNo = Target_questNo
	cfg.quest_dump_version = VERSION
	json.dump_file("ArenaTargetQuest.json", cfg)
	needs_initial_quest_data = true
end

if not cfg.quest_dump_version then
	cfg.quest_dump_version = VERSION
	needs_initial_quest_data = true
	json.dump_file("ArenaTargetQuest.json", cfg)
else
	if (cfg.quest_dump_version < Major) then
		cfg.quest_dump_version = VERSION
		needs_initial_quest_data = true
		json.dump_file("ArenaTargetQuest.json", cfg)
	end
end

local map16Test = {
	[82] = true,
	[83] = true,
	[84] = true,
	[85] = true,
	[89] = true,
}

local MapID = {
	["Default"] = 0,
	["Arena"] = 10,
	["Infernal Springs"] = 9,
	["Forlorn Arena"] = 14,
	["Yawning Abyss"] = 16,
}

local function getNormalQuestDataList(questman, fieldname)
    local normalQuestData = questman:get_field(fieldname)
	if normalQuestData == nil then return end
    local normalQuestData_array = normalQuestData:get_field("_Param")
	if normalQuestData_array == nil then return end
	normalQuestData_array = normalQuestData_array:get_elements()
	return normalQuestData_array
end

local function getNormalQuestDataForEnemyList(questman, fieldname)
    local normalQuestDataForEnemy = questman:get_field(fieldname)
	if normalQuestDataForEnemy == nil then return end
    local normalQuestDataForEnemy_array = normalQuestDataForEnemy:get_field("_Param")
	if normalQuestDataForEnemy_array == nil then return end
	normalQuestDataForEnemy_array = normalQuestDataForEnemy_array:get_elements()
	return normalQuestDataForEnemy_array
end

local function dump_quest_data(normalQuestData_array, normalQuestDataForEnemy_array)
	if normalQuestData_array == nil then return end
	if normalQuestDataForEnemy_array == nil then return end
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
	return true
end

local function dump_quest()
	log.debug("lua:log: dump_quest")

    local questman = sdk.get_managed_singleton("snow.QuestManager")
    if not questman then return end

	if not dump_quest_data(
		getNormalQuestDataList(questman, "_normalQuestData"),
		getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemy")
	) then return end

	if not dump_quest_data(
		getNormalQuestDataList(questman, "_DlQuestData"),
		getNormalQuestDataForEnemyList(questman, "_DlQuestDataForEnemy")
	) then return end

	if not dump_quest_data(
		getNormalQuestDataList(questman, "_nomalQuestDataKohaku"),
		getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemyKohaku")
	) then return end

	log.debug("lua:log: dump_quest end")

	return true
end

local function checkQuestNo(questNo)
	
	for i, quest in ipairs(cfg.target_questNo) do
		if questNo == quest then
			return true
		end
	end
	return false
end

local function set_quest_data(arenaSelection, normalQuestData_array, normalQuestDataForEnemy_array)
	if normalQuestData_array == nil then return end
	if normalQuestDataForEnemy_array == nil then return end
	
	local testQuestNoOfMap16 = {}

	for i,quest in ipairs(normalQuestData_array) do
		local QuestNo = quest:get_field("_QuestNo")
		if QuestNo == nil then return
		else
			if checkQuestNo(QuestNo) then 
				local Map = MapID[arenaSelection]
				quest:set_field("_MapNo", Map)
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
				TargetBoss = BossEmType:call("GetValue(System.Int32)", 0)
				if (map16Test[TargetBoss]) then
					testQuestNoOfMap16[QuestNo] = true
				end

				local SwapEmRate = quest:get_field("_SwapEmRate")
				local value = sdk.create_instance("System.Byte")
				value:set_field("mValue", 0)
				SwapEmRate:call("SetValue(System.Object, System.Int32)", value, 0)
				SwapEmRate:call("SetValue(System.Object, System.Int32)", value, 1)
				
				local BossSetCondition = quest:get_field("_BossSetCondition")
				local value = sdk.create_instance("snow.QuestManager.BossSetCondition")
				value:set_field("value__", 1)
				BossSetCondition:call("SetValue(System.Object, System.Int32)", value, 0)
				--[[
				value:set_field("value__", 0)
				BossSetCondition:call("SetValue(System.Object, System.Int32)", value, 1)
				BossSetCondition:call("SetValue(System.Object, System.Int32)", value, 2)
				BossSetCondition:call("SetValue(System.Object, System.Int32)", value, 3)
				BossSetCondition:call("SetValue(System.Object, System.Int32)", value, 4)
				BossSetCondition:call("SetValue(System.Object, System.Int32)", value, 5)
				BossSetCondition:call("SetValue(System.Object, System.Int32)", value, 6)

				local BossSetParam = quest:get_field("_BossSetParam")
				local value = sdk.create_instance("System.UInt32")
				value:set_field("mValue", 0)
				BossSetParam:call("SetValue(System.Object, System.Int32)", value, 0)
				BossSetParam:call("SetValue(System.Object, System.Int32)", value, 1)
				BossSetParam:call("SetValue(System.Object, System.Int32)", value, 2)
				BossSetParam:call("SetValue(System.Object, System.Int32)", value, 3)
				BossSetParam:call("SetValue(System.Object, System.Int32)", value, 4)
				BossSetParam:call("SetValue(System.Object, System.Int32)", value, 5)
				BossSetParam:call("SetValue(System.Object, System.Int32)", value, 6)
				]]
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
	
	for i,quest in ipairs(normalQuestDataForEnemy_array) do
		local QuestNo = quest:get_field("_QuestNo")
		if QuestNo == nil then return
		else
			if checkQuestNo(QuestNo) then
				quest:set_field("_EmsSetNo", 0)

				local RouteNo = quest:get_field("_RouteNo")
				local value = sdk.create_instance("System.Byte")
				value:set_field("mValue", 10)
				RouteNo:call("SetValue(System.Object, System.Int32)", value, 0)

				local InitSetName = quest:get_field("_InitSetName")
				local initSet = "メイン"
				if arenaSelection == "Arena" then initSet = "A"
				elseif arenaSelection == "Infernal Springs" then initSet = "メイン"
				elseif arenaSelection == "Forlorn Arena" then initSet = "メイン"
				elseif arenaSelection == "Yawning Abyss" then
					if (testQuestNoOfMap16[QuestNo]) then
						initSet = "テスト"
					else
						initSet = "メイン"
					end
				end
				
				InitSetName:call("SetValue(System.Object, System.Int32)", initSet, 0)
				quest:set_field("_InitSetName", InitSetName)
			end
		end
	end

end

local function set_quest(arenaSelection)
	log.debug("lua:log: set_localQuestData")

    local questman = sdk.get_managed_singleton("snow.QuestManager")
    if not questman then return end

	set_quest_data(arenaSelection, getNormalQuestDataList(questman, "_normalQuestData"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemy"))
	set_quest_data(arenaSelection, getNormalQuestDataList(questman, "_DlQuestData"), getNormalQuestDataForEnemyList(questman, "_DlQuestDataForEnemy"))
	set_quest_data(arenaSelection, getNormalQuestDataList(questman, "_nomalQuestDataKohaku"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemyKohaku"))

	log.debug("lua:log: set_localQuestData end")
end

local function load_quest_data(normalQuestData_array, normalQuestDataForEnemy_array)
	if normalQuestData_array == nil then return end
	if normalQuestDataForEnemy_array == nil then return end
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
				value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetParam["2"])
				SwapSetParam:call("SetValue(System.Byte, System.Int32)", value, 1)

				local SwapExitTime = quest:get_field("_SwapExitTime")
				local value = sdk.create_instance("System.Byte")
				value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapExitTime["1"])
				SwapExitTime:call("SetValue(System.Byte, System.Int32)", value, 0)
				value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapExitTime["2"])
				SwapExitTime:call("SetValue(System.Byte, System.Int32)", value, 1)
			end
		end
	end
end

local function load_quest()
	log.debug("lua:log: load_quest")

    local questman = sdk.get_managed_singleton("snow.QuestManager")
    if not questman then return end

	load_quest_data( getNormalQuestDataList(questman, "_normalQuestData"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemy"))
	load_quest_data( getNormalQuestDataList(questman, "_DlQuestData"), getNormalQuestDataForEnemyList(questman, "_DlQuestDataForEnemy"))
	load_quest_data( getNormalQuestDataList(questman, "_nomalQuestDataKohaku"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemyKohaku"))

	log.debug("lua:log: load_quest end")
end

--[[
re.on_pre_application_entry("UpdateBehavior", function() 
	
    if needs_initial_quest_data then
		setup_localQuestData()
		json.dump_file("ArenaQuestBeta2.json", cfg)
        --set_localQuestData(true)
        needs_initial_quest_data = false
    end
end)]]

if (needs_initial_quest_data) then
	cfg_QuestData = {}
	cfg_QuestData.read_only_quest_data = {}
	if dump_quest() then
		json.dump_file("QuestDataDump.json", cfg_QuestData)
		needs_initial_quest_data = false
	end
end

local name = "ForceArena v"..tostring(VERSION)..":"
local status = ""

local QuestAreaValues = {"Default", "Arena", "Infernal Springs", "Forlorn Arena"}
local QuestAreaSelection = 1

re.on_draw_ui(function() 
	imgui.text(name..status)
	imgui.same_line()
	local changed, value = imgui.combo("click to select", QuestAreaSelection, QuestAreaValues)
	if changed then
		QuestAreaSelection = value
		if (needs_initial_quest_data) then
			cfg_QuestData = {}
			cfg_QuestData.read_only_quest_data = {}
			if not dump_quest() then
				status = " fail to initialize quest data, pls select again."
			else
				status = ""
				json.dump_file("QuestDataDump.json", cfg_QuestData)
				needs_initial_quest_data = false
			end
		end
		if QuestAreaValues[QuestAreaSelection] == "Default" then
			load_quest()
		else
			set_quest(QuestAreaValues[QuestAreaSelection])
		end
	end
end)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--[[thanks to gao_bili providing the code to prevent invalid quirous quest generated.]]

local Fixed = false

sdk.hook(
	sdk.find_type_definition("snow.stage.StageManager"):get_method("onQuestClear"),
	function(args)
		if QuestAreaValues[QuestAreaSelection] == "Default" then return end
		local questManager = sdk.get_managed_singleton("snow.QuestManager")
		if not questManager then return end
		if questManager:isMysteryQuest() then
			load_quest()
			Fixed = true
		end
	end,
	function(retval) end
)

sdk.hook(
    sdk.find_type_definition("snow.gui.GuiManager"):get_method("notifyReturnInVillage"),
    function(args)
		if Fixed then
			set_quest(QuestAreaValues[QuestAreaSelection])
			Fixed = false
		end
    end,
	function(retval) end
)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==