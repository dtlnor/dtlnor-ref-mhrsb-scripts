local cfg = json.load_file("noRiding.json")

if not cfg then
	cfg = {Is_APEX_MODE = false}
	json.dump_file("noRiding.json", cfg)
end

local function change_em_attr(enemy, ApexMode)
	if not enemy then
		return;
	end

    if ApexMode == false then
        local Mario_Param = enemy:get_field("<MarioParam>k__BackingField");
        if not Mario_Param then 
            return;
        end
        
        local mario_cool_time = Mario_Param:get_field("<MarioCoolTimerSec>k__BackingField");
        if not mario_cool_time then
            return;
        end
        Mario_Param:set_field("<MarioCoolTimerSec>k__BackingField", 600.0)
    else
        local Damage_Param = enemy:get_field("<DamageParam>k__BackingField");
        if not Damage_Param then 
            return;
        end

        local Marionette_Start_Param = Damage_Param:get_field("_MarionetteStartParam");
        if not Marionette_Start_Param then 
            return;
        end
        
        local Marionette_Start_ActiveTime = Marionette_Start_Param:get_field("<ActiveTime>k__BackingField");
        if not Marionette_Start_ActiveTime then
            return;
        end
        Marionette_Start_Param:set_field("<ActiveTime>k__BackingField", 0.01)
    end

end

local enemy_character_base_type_def = sdk.find_type_definition("snow.enemy.EnemyCharacterBase");
local enemy_character_base_type_def_update_method = enemy_character_base_type_def:get_method("update");
sdk.hook(enemy_character_base_type_def_update_method, function(args) 
    change_em_attr(sdk.to_managed_object(args[2]), cfg.Is_APEX_MODE);
end, function(retval) end);


local status = ""

if cfg.Is_APEX_MODE then
    status = "apex style"
else
    status = "no riding"
end

re.on_draw_ui(function()

    if string.len(status) > 0 then
        imgui.text(status)
    end
    imgui.same_line()
    if imgui.button("apex style") then
        cfg.Is_APEX_MODE = true
        status = "apex style"
        json.dump_file("noRiding.json", cfg)
    end
    imgui.same_line()
    if imgui.button("no riding") then
        cfg.Is_APEX_MODE = false
        status = "no riding"
        json.dump_file("noRiding.json", cfg)
    end
end)