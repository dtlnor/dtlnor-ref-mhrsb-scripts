local cfg = json.load_file("infRiding.json")

if not cfg then
	cfg = {Is_Final_MODE = false}
	json.dump_file("infRiding.json", cfg)
end


local function change_em_attr(enemy)
	if not enemy then
		return;
	end

    local Mario_Param = enemy:get_field("<MarioParam>k__BackingField");
    if not Mario_Param then return end
    
    local mario_GaugePointMax = Mario_Param:get_field("<GaugePointMax>k__BackingField");
    if not mario_GaugePointMax then return end
    
    local mario_GaugePoint = Mario_Param:get_field("_GaugePoint");
    if not mario_GaugePoint then return end
    Mario_Param:set_field("_GaugePoint", mario_GaugePointMax)

    local mario_FinalAttackTimerMax = Mario_Param:get_field("<FinalAttackTimerMax>k__BackingField");
    if not mario_FinalAttackTimerMax then return end

    local mario_FinalAttackTimer = Mario_Param:get_field("<FinalAttackTimer>k__BackingField");
    if not mario_FinalAttackTimer then return end
    Mario_Param:set_field("<FinalAttackTimer>k__BackingField", mario_FinalAttackTimerMax)
    
    local mario_FinalAttackPointMax = Mario_Param:get_field("<FinalAttackPointMax>k__BackingField");
    if not mario_FinalAttackPointMax then return end

    local mario_FinalAttackPoint = Mario_Param:get_field("_FinalAttackPoint");
    if not mario_FinalAttackPoint then return end
    if cfg.Is_Final_MODE then
        Mario_Param:set_field("_FinalAttackPoint", mario_FinalAttackPointMax)
    else
        Mario_Param:set_field("_FinalAttackPoint", 0)
    end

    local Damage_Param = enemy:get_field("<DamageParam>k__BackingField");
    if not Damage_Param then  return end

    local Marionette_Start_Param = Damage_Param:get_field("_MarionetteStartParam");
    if not Marionette_Start_Param then  return end
        
    local Marionette_Start_ActiveTime = Marionette_Start_Param:get_field("<ActiveTime>k__BackingField");
    if not Marionette_Start_ActiveTime then return end
        
    local Marionette_Start_ActiveTimer = Marionette_Start_Param:get_field("<ActiveTimer>k__BackingField");
    if not Marionette_Start_ActiveTimer then return end
    Marionette_Start_Param:set_field("<ActiveTimer>k__BackingField", Marionette_Start_ActiveTime)

end

local enemy_character_base_type_def = sdk.find_type_definition("snow.enemy.EnemyCharacterBase");
local enemy_character_base_type_def_update_method = enemy_character_base_type_def:get_method("update");
sdk.hook(enemy_character_base_type_def_update_method, function(args) 
    change_em_attr(sdk.to_managed_object(args[2]));
end, function(retval) end);


local status = ""

if cfg.Is_Final_MODE then
    status = "[infRiding]Final"
else
    status = "[infRiding]Normal"
end

re.on_draw_ui(function()

    if string.len(status) > 0 then
        imgui.text(status)
    end
    imgui.same_line()
    if imgui.button("Normal mode") then
        cfg.Is_Final_MODE = false
        status = "[infRiding]Normal"
        json.dump_file("infRiding.json", cfg)
    end
    imgui.same_line()
    if imgui.button("Final mode") then
        cfg.Is_Final_MODE = true
        status = "[infRiding]Final"
        json.dump_file("infRiding.json", cfg)
    end
end)