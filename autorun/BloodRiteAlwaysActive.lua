local cfg_name = "BloodRiteAlwaysActive.json"
local cfg = json.load_file(cfg_name)

if not cfg then	cfg = {	} end
if not cfg.isShowHealHP then cfg.isShowHealHP = true end

json.dump_file(cfg_name, cfg)

sdk.hook(sdk.find_type_definition("snow.player.PlayerQuestBase"):get_method("calcBloodySkillHealVital(snow.hit.EnemyCalcDamageInfo.AfterCalcInfo_DamageSide, System.Boolean)"), function(args)
    -- player = sdk.to_managed_object(args[2])
    local resultInfo = sdk.to_managed_object(args[3])
    resultInfo:set_field("<IsBreakPartsDamage>k__BackingField", true)
end, function(retval) end)

local cache_add_hp = 0

sdk.hook(sdk.find_type_definition("snow.player.PlayerQuestBase"):get_method("addEquipSkill232Absorption(System.Single)"), function(args)
    -- local player = sdk.to_managed_object(args[2])
    local add = sdk.to_float(args[3])
    cache_add_hp = add
    -- log.debug(tostring(add))
end, function(retval) end)

local showHealHP = function()
	local PlayMan = sdk.get_managed_singleton("snow.player.PlayerManager")
	if not PlayMan then return end

	local player = PlayMan:call("getMasterPlayerID")
	if not player or player > 4 then return end

	local MasterPlayer = PlayMan:get_field("PlayerList"):call("get_Item", player)
	if not MasterPlayer then return end

    local CharacterController = MasterPlayer:call("getCharacterController")
    if not CharacterController then return end

    local playerPos = sdk.call_native_func(CharacterController, sdk.find_type_definition("via.physics.CharacterController"), "get_Position")
    if playerPos then
        playerPos.y = playerPos.y+1.8
        draw.world_text("+"..tostring(cache_add_hp), playerPos, 0xFF80FF80)
    end
end

re.on_frame(function()
    if cfg.isShowHealHP then
        showHealHP()
    end
end)

re.on_draw_ui(function()
    imgui.text("BloodRiteAlwaysActive -")
    imgui.same_line()
    local changed, value = imgui.checkbox("show heal HP", cfg.isShowHealHP)
    if changed then
        cfg.isShowHealHP = value
        json.dump_file(cfg_name, cfg)
    end
end)