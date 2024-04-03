local function ApplyCost(CustomCost)
    local idMan = sdk.get_managed_singleton("snow.data.ContentsIdDataManager")
    local ArmorBaseUserDataArray = idMan:call("get_PlArmorIdDataModule")
    ArmorBaseUserDataArray = ArmorBaseUserDataArray:get_field("_BaseUserData")
    ArmorBaseUserDataArray = ArmorBaseUserDataArray:get_field("_Param")

    local ArmorBaseUserDataSize = ArmorBaseUserDataArray:call("get_Count")
    if not ArmorBaseUserDataSize then return end
    
    for i = 0, ArmorBaseUserDataSize-1 do
        data = ArmorBaseUserDataArray:call("get_Item", i)
        if not data then return end
        data:set_field("_CustomCost", CustomCost)
    end
end

local targetCost = -1
re.on_draw_ui(function()
    imgui.text("double click to input cost directly")
    imgui.same_line()
	local changed, value = imgui.drag_int("applyCost", targetCost, 0.5, 0, 140)
    if changed then
        targetCost = value
        ApplyCost(targetCost)
	end
end)
