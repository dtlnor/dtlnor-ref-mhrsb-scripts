
local cfg = json.load_file("effect_show.json")

if not cfg then	cfg = {	} end

if not cfg.FONT_NAME then cfg.FONT_NAME = "NotoSansCJKjp-Bold.otf" end
if not cfg.FONT_SIZE then cfg.FONT_SIZE = 18 end

if not cfg.rec_margin then cfg.rec_margin = 10 end
if not cfg.line_space then cfg.line_space = 20 end

if not cfg.general_x then cfg.general_x = 100 end
if not cfg.general_y then cfg.general_y = 100 end
if not cfg.general_cap_width then cfg.general_cap_width = 350 end
if not cfg.general_width then cfg.general_width = 450 end
if not cfg.index_width then cfg.index_width = cfg.general_cap_width + cfg.general_width + cfg.rec_margin * 2 end
if not cfg.EffectManager_show then cfg.EffectManager_show = true end
if not cfg.object_effect_manager_show then cfg.object_effect_manager_show = true end
json.dump_file("effect_show.json", cfg)

local CHINESE_GLYPH_RANGES = {
    --0x0020, 0x00FF, -- Basic Latin + Latin Supplement
    --0x2000, 0x206F, -- General Punctuation
	---0x2150, 0x218F, -- Number Forms
    --0x3000, 0x30FF, -- CJK Symbols and Punctuations, Hiragana, Katakana
    --0x31F0, 0x31FF, -- Katakana Phonetic Extensions
    --0xFF00, 0xFFEF, -- Half-width characters
    --0x4e00, 0x9FAF, -- CJK Ideograms
	--0x25A0, 0x25FF, -- Geometric Shapes
    0x0020, 0xE007F, -- All (https://jrgraphix.net/research/unicode_blocks.php)
    0,
}

local font = imgui.load_font(cfg.FONT_NAME, cfg.FONT_SIZE, CHINESE_GLYPH_RANGES)

local general_line = 0
local column_index = 0
local total_line = 0
local total_column = 0
-- top left of rectengle
local printGeneralLine = function(cap, value, index)
	draw.text(cap, cfg.general_x + cfg.rec_margin + index * cfg.index_width,
		cfg.general_y + general_line * cfg.line_space + cfg.rec_margin,
		0xFFFFFFFF)
	if value then
		draw.text(tostring(value), cfg.general_x + cfg.rec_margin + cfg.general_cap_width + index * cfg.index_width,
			cfg.general_y + general_line * cfg.line_space + cfg.rec_margin,
			0xFFFFFFFF)
	end
	general_line = general_line + 1
end

local dispObjectEffectManagerInfo = function(ObjEffectManager, index)

	if not ObjEffectManager then return end
	local CurrentGameObject = ObjEffectManager:get_field("CurrentGameObject")
	if not CurrentGameObject then return end
	local object_name = CurrentGameObject:call("get_Name")

	printGeneralLine("-----"..object_name.." - refObjectEffectManager-----", "", index)

	local DataContainerPath = ObjEffectManager:get_field("DataContainerPath")
	printGeneralLine("DataContainerPath", DataContainerPath, index)

	local EPVDataContainerObj = ObjEffectManager:get_field("EPVDataContainerObj")
	local StandardData = EPVDataContainerObj:get_field("StandardData")
	printGeneralLine("-----(EPV) StandardDataSetting-----", "", index)

	for i = 0, StandardData:call("get_Count") -1 do
		local StandardDataSetting = StandardData:call("get_Item", i)
		if StandardDataSetting then
			local dispName = StandardDataSetting:call("get_dispName")
			local prefabDataName = StandardDataSetting:call("get_data"):call("get_Path")
			printGeneralLine(dispName, prefabDataName, index)

		end
	end
	
	local CreatedEffectDataList = ObjEffectManager:get_field("CreatedEffectDataList")
	printGeneralLine("-----CreatedEffectDataList-----", "", index)

	for i = 0, CreatedEffectDataList:call("get_Count") -1 do
		local CreatedEffectData = CreatedEffectDataList:call("get_Item", i)
		if CreatedEffectData then
			local EffectID = CreatedEffectData:get_field("id")
			local ContainerList = CreatedEffectData:get_field("list")
			if EffectID then 
				local containerID = EffectID:call("get_containerID")
				local elementID = EffectID:call("get_elementID")
				printGeneralLine("containerID - elementID", containerID.." - "..elementID, index)
			end

		end
	end
end

re.on_frame(function()
	imgui.push_font(font)

	local EffMan = sdk.get_managed_singleton("via.effect.script.EffectManager")
	if not EffMan then return end

	local ContainerManagersList = EffMan:get_field("ContainerManagers")
	if not ContainerManagersList then return end
	local numOfContainerManagers = ContainerManagersList:call("get_Count")
	if not numOfContainerManagers then return end
	local ContainerManagersArray = ContainerManagersList:get_field("mItems")
	if not ContainerManagersArray then return end
	--ContainerManagersArray = ContainerManagersArray:get_elements()

	if cfg.EffectManager_show then
		--for i, ContainerManager in pairs(ContainerManagersArray) do
		for i = 0, numOfContainerManagers-1 do
			ContainerManager = ContainerManagersArray:call("get_Item", i)
			if ContainerManager then
				local Creator = ContainerManager:call("getCreator")
				if Creator then
					local object_name = Creator:call("get_Name")
					--local component = Creator:call("getComponent", sdk.find_type_definition("via.effect.script.ObjectEffectManager"):get_runtime_type() )

					draw.text(i.."-"..tostring(object_name), 250 * math.floor((i-1) / 25) + 25 , 40 * ( (i-1) % 25) + 25 , 0xFFFFFFFF)
					if false then
						local transform = Creator:call("get_Transform")
						if transform then
						--	local EffPos = transform:call("get_Position")
						--	if EffPos then
						--		--draw.world_text(tostring(object_name), EffPos, 0xFFFFFFFF)
						--	end
						end
					end
				end
				local Container = ContainerManager:call("getContainer")
				if Container then
					local EffectNum = Container:call("getEffectNum")
					if EffectNum then
						local EPVDataElementList = Container:call("getEPVDataElement")
						if EPVDataElementList then					
							local ListSize = EPVDataElementList:get_field("mSize")
							local List = EPVDataElementList:get_field("mItems")
							for Elementidx = 0, ListSize-1 do
								EPVDataElement = EPVDataElementList:call("get_Item", Elementidx)
								if EPVDataElement then

									local elementid = EPVDataElement:call("get_id")
									if elementid then
										draw.text("  ["..tostring(Elementidx).."]ele_id:"..tostring(elementid), 250 * math.floor((i-1) / 25) + 25 + (Elementidx*50) , 40 * ( (i-1) % 25) + 25 + 20 , 0xFFFFFFFF)
									end
									--draw.text(" 2 "..tostring(Elementidx), 250 * math.floor((i-1) / 25) + 25 , 40 * ( (i-1) % 25) + 25 + 20 , 0xFFFFFFFF)
									
								end
							end
							--for Elementidx, EPVDataElement in pairs(List) do
							--	if EPVDataElement then
							--		local elementid = EPVDataElement:call("get_id")
							--		if elementid then
							--			--draw.text("  ["..tostring(Elementidx).."]ele_id:"..tostring(elementid), 250 * math.floor((i-1) / 25) + 25 + (i*elementid) , 40 * ( (i-1) % 25) + 25 + 20 , 0xFFFFFFFF)
							--		end
							--	end
							--end
						end
					end
				end

			end
		end
	end

	local PlayMan = sdk.get_managed_singleton("snow.player.PlayerManager")
	if not PlayMan then return end
	local MasterPlayer = PlayMan:call("findMasterPlayer")
	if not MasterPlayer then return end
	local MasterPlayer_refObjectEffectManager = MasterPlayer:get_field("_RefObjectEffectManager")
	if not MasterPlayer_refObjectEffectManager then return end
	
	local QuestEffectManager = sdk.get_managed_singleton("snow.QuestEffectManager")
	if not QuestEffectManager then return end
	local QuestrefObjectEffectManager = QuestEffectManager:get_field("refObjectEffectManager")
	if not QuestrefObjectEffectManager then return end

	if cfg.object_effect_manager_show then
		general_line = 0
		column_index = 0
		draw.filled_rect(cfg.general_x, cfg.general_y, 
			cfg.general_width + cfg.general_cap_width + cfg.rec_margin * 2 + total_column * cfg.index_width, 
			total_line * cfg.line_space + cfg.rec_margin * 2, 
			0xAA000000)

		dispObjectEffectManagerInfo(QuestrefObjectEffectManager, column_index)
		--if general_line > total_line then total_line = general_line end
		--general_line = 0
		--column_index = column_index + 1
		printGeneralLine("", "", column_index)
		printGeneralLine("", "", column_index)
		dispObjectEffectManagerInfo(MasterPlayer_refObjectEffectManager, column_index)
		--if general_line > total_line then total_line = general_line end
		
		local HunterWireObjArray = MasterPlayer:call("get_RefHunterWireObj")
		if HunterWireObjArray then
			--general_line = 0
			for i = 0, HunterWireObjArray:call("get_Count") -1 do
				--column_index = 1
				local HunterWireObj = HunterWireObjArray:call("get_Item", i)
				if HunterWireObj then
					printGeneralLine("", "", column_index)
					printGeneralLine("", "", column_index)
					local HunterWireObjRefObjectEffectManager = HunterWireObj:call("get_RefObjectEffectManager")
					dispObjectEffectManagerInfo(HunterWireObjRefObjectEffectManager, column_index + i)
					--if general_line > total_line then total_line = general_line end
				end
			end
		end

		total_line = general_line
		total_column = column_index
	end
	--dispObjectEffectManagerInfo(HunterWireObj, 2)
	
	
	--draw.text(tostring(numOfContainerManagers), 800, 500, 0xFFFFFFFF)

	
	if drawSetting then
		if imgui.begin_window("effect_show", true, 0) then
			imgui.text("---object effect manager---")
			local saveChanged = false
			changed, value = imgui.checkbox("is show object effect manager", cfg.object_effect_manager_show)
			if changed then cfg.object_effect_manager_show = value
				saveChanged = true end
			changed, value = imgui.slider_int("general_x", cfg.general_x, -1920, 1920)
        	if changed then cfg.general_x = value  
				saveChanged = true end
			changed, value = imgui.slider_int("general_y", cfg.general_y, -1080, 1080)
        	if changed then cfg.general_y = value  
				saveChanged = true end
			changed, value = imgui.slider_int("general_cap_width", cfg.general_cap_width, 1, 1920)
        	if changed then cfg.general_cap_width = value  
				saveChanged = true end
			changed, value = imgui.slider_int("general_width", cfg.general_width, 1, 1920)
        	if changed then cfg.general_width = value  
				saveChanged = true end

			imgui.text("---effect manager all effect---")
			
			changed, value = imgui.checkbox("is show effect manager all effect", cfg.EffectManager_show)
			if changed then cfg.EffectManager_show = value
				saveChanged = true end

			if saveChanged then json.dump_file("effect_show.json", cfg) end
			imgui.spacing()
			imgui.end_window()
		else
			drawSetting = false
		end
	end
    imgui.pop_font()

end)


local script_name = "effect_show"
re.on_draw_ui(function()
    if string.len(script_name) > 0 then
        imgui.text(script_name)
    end
    imgui.same_line()
    if imgui.button("effect_show Setting") then
        drawSetting = true
    end
	
end)