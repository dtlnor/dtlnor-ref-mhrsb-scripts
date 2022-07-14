
local cfg = json.load_file("someCheat.json")

if not cfg then	cfg = {	} end
if not cfg.isAdjustSharpness then cfg.isAdjustSharpness = 1.0 end
if not cfg.set_hunter_wire_gauges then cfg.set_hunter_wire_gauges = false end
if not cfg.set_mudeki_gauges then cfg.set_mudeki_gauges = false end
if not cfg.set_LS_LongSwordGaugeAll then cfg.set_LS_LongSwordGaugeAll = false end
if not cfg.sharpness_adjust_rate then cfg.sharpness_adjust_rate = false end
if not cfg.set_LS_FixedDamage then cfg.set_LS_FixedDamage = false end
if not cfg.set_ThrowTaruCount then cfg.set_ThrowTaruCount = false end
if not cfg.set_infTrap then cfg.set_infTrap = false end
if not cfg.set_infItem then cfg.set_infItem = false end
if not cfg.small_barrel_timer then cfg.small_barrel_timer = 2.5 end

if not cfg.set_CA_ChargedBottleNum then cfg.set_CA_ChargedBottleNum = false end

json.dump_file("someCheat.json", cfg)

local status =""

local function get_localplayer()
	local PlayMan = sdk.get_managed_singleton("snow.player.PlayerManager")
	if not PlayMan then return end
	local MasterPlayer = PlayMan:call("findMasterPlayer")
	if not MasterPlayer then return end

    return MasterPlayer
end

local function set_hunter_wire_gauges(value)
    local player = get_localplayer()

    if not player then
        return
    end

    local hunter_wire_gauges = player:get_field("_HunterWireGauge")

    if hunter_wire_gauges == nil then return end
    hunter_wire_gauges = hunter_wire_gauges:get_elements()

    for i, gauge in ipairs(hunter_wire_gauges) do
        gauge:set_field("_RecastTimer", value)
    end
end

local function set_mudeki_gauges(value)
    local player = get_localplayer()

    if not player then
        return
    end

    local mutekiTime = player:get_field("_MutekiTime")

    if mutekiTime == nil then return end
	player:set_field("_MutekiTime", value)
    
end

local function set_LS_LongSwordGaugeLvTimer(value)
    local player = get_localplayer()

    if not player then
        return
    end

    local fieldValue = player:get_field("_LongSwordGaugeLvTimer")

    if fieldValue == nil then return end
	player:set_field("_LongSwordGaugeLvTimer", value)
    
end

local function set_LS_LongSwordGauge(value)
    local player = get_localplayer()

    if not player then
        return
    end

    local fieldValue = player:get_field("_LongSwordGauge")

    if fieldValue == nil then return end
	player:set_field("_LongSwordGauge", value)
    
end

local function set_LS_LongSwordGaugeLv(value)
    local player = get_localplayer()

    if not player then
        return
    end

    local fieldValue = player:get_field("_LongSwordGaugeLv")

    if fieldValue == nil then return end
	player:set_field("_LongSwordGaugeLv", value)
    
end

--[[
    [via.attribute.IgnoreDataMemberAttribute()]
    [literal][expose][default]private static  System.Boolean Group_ChargeAxe = [1] /* */;
    [literal][default]public static  System.Int32 ChargeGaugeMax = [100, 0, 0, 0] /* int: 100 */;
    [literal][default]public static  System.Int32 ChargeGaugeSmall = [30, 0, 0, 0] /* int: 30 */;
    [literal][default]public static  System.Int32 ChargeGaugeLarge = [46, 0, 0, 0] /* int: 46 */;
    [literal][default]public static  System.Int32 ChargeGaugeOverheat = [72, 0, 0, 0] /* int: 72 */;
    [literal][default]private static  System.Int32 ChargeLargeBottleNum = [5, 0, 0, 0] /* int: 5 */;
    [literal][default]private static  System.Int32 ChargeSmallBottleNum = [3, 0, 0, 0] /* int: 3 */;
    [literal][default]private static  System.Int32 _BottleNumNormalMax = [5, 0, 0, 0] /* int: 5 */;
    [literal][default]public static  snow.shell.PlayerShellBase.RandomConvertType _RandomTypeForBottleAttackDefault = [1, 0, 0, 0] /* uint: 1 [hexBE]00000001 */;
    [literal][default]private static  snow.shell.PlayerShellBase.RandomConvertType _RandomTypeForGuardCounter = [14, 0, 0, 0] /* uint: 14 [hexBE]0000000E */;
    [via.attribute.DataMemberAttribute()]
    [expose]private  snow.player.PlayerUserDataChargeAxe _PlayerUserDataC_Axe;
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    private  snow.data.ChargeAxeWeaponData <RefWeaponData>k__BackingField;
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    private  snow.gui.GuiHud_Weapon_C_Axe <Hud>k__BackingField;
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    private  System.UInt32 <ChargedBottleNum>k__BackingField;
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    private  System.Boolean <IsDrawAnchorGuardEffect>k__BackingField;
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    private  System.Boolean <IsDrawOffShieldBuffEffect>k__BackingField;
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    private  snow.player.ChargeAxe.SkillFastTransformState <FastTransformState>k__BackingField;
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    private  snow.player.ChargeAxe.SkillFastTransformAttack <FastTransformAttackType>k__BackingField;
    [via.attribute.IgnoreDataMemberAttribute()]
    [expose]private  System.Single _ChargeGauge;
    private  snow.player.ChargeAxe.UseBottleRequest _UseBottleReq;
    private  snow.player.ChargeAxe.BottleAttackRequest _BottleAtkReq;
    private  System.Collections.Generic.List`1<snow.player.ChargeAxe.CheckAttackHitRequest> _CheckAttackHitRequestList;
    private  System.Single _ShieldBuffTimer;
    private  System.Single _SwordBuffTimer;
    private  System.Single _ChainsawBuffBottleAddTimer;
    private  snow.player.ChargeAxe.ReadySlashEffectState _ReadyEffectState;
    private  via.effect.script.CreatedEffectContainer _AnchorGuardEffectWire;
    private  via.effect.script.CreatedEffectContainer _OverheatEffect;
    private  via.effect.script.CreatedEffectContainer _ShieldBuffEffect;
    private  via.effect.script.CreatedEffectContainer _SwordBuffEffect;
    private  via.effect.script.CreatedEffectContainer _ChainsawEffect;
    private  via.effect.script.CreatedEffectContainer _ChainsawBuffEffect;
    private  via.effect.script.CreatedEffectContainer _ReadyEffect;
    private  via.effect.script.CreatedEffectContainer _ShieldBuffStartEffect;
    private  snow.BitSetFlag`1<snow.player.ChargeAxe.ChargeAxeFlag> _ChargeAxeFlag;
    private  System.Boolean _IsChainsawBuff;
    private  System.Boolean _GuardPoint;
    private  System.Boolean _GuardCounter;
    private  System.Boolean _IsGuardHitFromHeavyChange;
    private  System.Boolean _IsCounterFullChargeElementEnhance;
    private  System.Boolean _IsChainsawWeaponForSlave;
    private  snow.data.ChargeAxeWeaponBaseData.BottleTypes _SlaveBottleType;
    private  snow.player.ChargeAxe.SkillFastTransformAttack _ContinueFastTransformAttack;
]]
local function set_CA_ChargedBottleNum(value)
    local player = get_localplayer()

    if not player then
        return
    end

    local fieldValue = player:get_field("<ChargedBottleNum>k__BackingField")

    if fieldValue == nil then return end
	player:set_field("<ChargedBottleNum>k__BackingField", value)
	player:set_field("_ChargeGauge", 70)    
	player:set_field("_ShieldBuffTimer", 18000)    
	player:set_field("_SwordBuffTimer", 5400)
    
end

local function on_pre_get_sharpness_adjust_rate(args)
    local sharpness = args[2]
    local sharpness_category = args[3]

    --log.debug("lua:log: Sharpness: " .. tostring(sdk.to_int64(sharpness)))
    --log.debug("lua:log: Sharpness category: " .. tostring(sdk.to_int64(sharpness_category)))
	
	return sdk.PreHookResult.CALL_ORIGINAL
end

local function on_post_get_sharpness_adjust_rate(retval)
    local sharpnessMulti = sdk.to_float(retval)
    --log.debug("lua:log: SharpnessMulti: " .. tostring(sharpnessMulti))
    
    return sdk.float_to_ptr(sharpnessMulti * cfg.isAdjustSharpness)
end

local function set_LS_HitData(value)
    local player = get_localplayer()

    if not player then
        return
    end

    local RefRSCController = player:get_field("_RefRSCController")
    if RefRSCController == nil then return end

    local AttackWorks = RefRSCController:get_field("<AttackWorks>k__BackingField")

    if AttackWorks == nil then return end
    AttackWorks = AttackWorks:get_elements()

    for i, Attack in ipairs(AttackWorks) do
        local HitData = Attack:get_field("<HitData>k__BackingField")
        if HitData == nil then return end
        HitData:set_field("_BreakRate", value)
    end
    
end

local function set_LS_FixedDamage(value)
    local player = get_localplayer()

    if not player then
        return
    end

    local RefRSCController = player:get_field("_RefRSCController")
    if RefRSCController == nil then return end

    local AttackWorks = RefRSCController:get_field("<AttackWorks>k__BackingField")

    if AttackWorks == nil then return end
    AttackWorks = AttackWorks:get_elements()

    for i, Attack in ipairs(AttackWorks) do
        local HitData = Attack:get_field("<HitData>k__BackingField")
        if HitData == nil then return end
        HitData:set_field("_BaseDamage", value)
        HitData:set_field("_BaseAttackElement", 0)
        HitData:set_field("_BaseAttackElementValue", 0)
        HitData:set_field("_SharpnessType", 4) --4:ignore meat
        HitData:set_field("_SubRate", 0) --element
        HitData:set_field("_PlayerAttackAttr", 16672)
    end
    RefRSCController:call("resetAllHitAttack")
end

local function set_ThrowTaruCount(value)
    local player = get_localplayer()

    if not player then
        return
    end

    local fieldValue = player:get_field("_ThrowTaruCount")

    if fieldValue == nil then return end
	player:set_field("_ThrowTaruCount", value)
    
end


local function change_em_attr(enemy)
	if not enemy then
		return;
	end
    if cfg.set_infTrap then
        local Damage_Param = enemy:get_field("<DamageParam>k__BackingField");
        if not Damage_Param then  return end

        local ShockTrap_Param = Damage_Param:get_field("_ShockTrapParam");
        if not ShockTrap_Param then  return end
            
        local ShockTrap_ActiveTime = ShockTrap_Param:get_field("<ActiveTime>k__BackingField");
        if not ShockTrap_ActiveTime then return end
            
        local ShockTrap_ActiveTimer = ShockTrap_Param:get_field("<ActiveTimer>k__BackingField");
        if not ShockTrap_ActiveTimer then return end
        ShockTrap_Param:set_field("<ActiveTimer>k__BackingField", ShockTrap_ActiveTime)
        

        local Damage_Param = enemy:get_field("<DamageParam>k__BackingField");
        if not Damage_Param then  return end

        local FallTrap_Param = Damage_Param:get_field("_FallTrapParam");
        if not FallTrap_Param then  return end
            
        local FallTrap_ActiveTime = FallTrap_Param:get_field("<ActiveTime>k__BackingField");
        if not FallTrap_ActiveTime then return end
            
        local FallTrap_ActiveTimer = FallTrap_Param:get_field("<ActiveTimer>k__BackingField");
        if not FallTrap_ActiveTimer then return end
        FallTrap_Param:set_field("<ActiveTimer>k__BackingField", FallTrap_ActiveTime)
    end
end



local setShellTimer = function(lifeTime)

    local PlCommonShellMan = sdk.get_managed_singleton("snow.shell.PlCommonShellManager")
    if not PlCommonShellMan then return end
    local PlCommonShell001s = PlCommonShellMan:get_field("_PlCommonShell001s")
    if PlCommonShell001s then
        local shellListSize = PlCommonShell001s:call("get_Count")
        if (not shellListSize) or shellListSize == 0 then return end
        local shell001 = PlCommonShell001s:call("get_Item", 0)
        if not shell001 then return end

        local shellInstanceCount = shell001:call("get_Count")
        if (not shellInstanceCount) or shellInstanceCount == 0 then return end

        local LastShell = shell001:call("get_Item", shellInstanceCount-1)
        if not LastShell then return end

        local shellUserData = LastShell:get_field("_userData")
        if not shellUserData then return end
        local shellUserData_moveParam = shellUserData:get_field("_moveParam")
        if not shellUserData_moveParam then return end
        local DetonateTime = shellUserData_moveParam:get_field("_DetonateTime")
        if not DetonateTime then return end

        dif = DetonateTime - lifeTime
        if dif > 1 or dif < -1 then
            shellUserData_moveParam:set_field("_DetonateTime", lifeTime)
            local LastShellTimer = LastShell:get_field("_lifeTimer")
            if not LastShellTimer then return end
            LastShell:set_field("_lifeTimer", lifeTime)
            status = "Pass5"
        end
        
    end
end


re.on_application_entry("UpdateBehavior", function()
    if cfg.set_mudeki_gauges then set_mudeki_gauges(30.0) end
    if cfg.set_hunter_wire_gauges then set_hunter_wire_gauges(0.0) end
	if cfg.set_LS_LongSwordGaugeAll then set_LS_LongSwordGaugeLvTimer(3500.0) end
	if cfg.set_LS_LongSwordGaugeAll then set_LS_LongSwordGauge(100.0) end
    if cfg.set_LS_LongSwordGaugeAll then set_LS_LongSwordGaugeLv(3) end
    --set_LS_HitData(50)
    if cfg.set_LS_FixedDamage then set_LS_FixedDamage(1000) end
    if cfg.set_ThrowTaruCount then set_ThrowTaruCount(0) end
    setShellTimer(cfg.small_barrel_timer * 60) --count at frame
    if cfg.set_CA_ChargedBottleNum then set_CA_ChargedBottleNum(5) end
end)

local drawSetting = false
re.on_frame(function()
    
	if drawSetting then
		if imgui.begin_window("cheat setting", true, 0) then
            local saveChanged = false
			imgui.text("---normal---")
			--changed, value = imgui.slider_int("set_mudeki_gauges", cfg.shell_work_num, 5, 20)
        	--if changed then cfg.shell_work_num = value  
			--	saveChanged = true end

			imgui.text("Small Bomb Timer(2.5s default)")
            changed, value = imgui.drag_float("s", cfg.small_barrel_timer, 0.01, 0.01, 60,"%.2f")
			if changed then cfg.small_barrel_timer = value
                saveChanged = true end

			changed, value = imgui.checkbox("set_mudeki_gauges", cfg.set_mudeki_gauges)
			if changed then cfg.set_mudeki_gauges = value
                saveChanged = true end
			changed, value = imgui.checkbox("set_hunter_wire_gauges", cfg.set_hunter_wire_gauges)
			if changed then cfg.set_hunter_wire_gauges = value
                saveChanged = true end
			changed, value = imgui.checkbox("set_LS_LongSwordGaugeAll", cfg.set_LS_LongSwordGaugeAll)
			if changed then cfg.set_LS_LongSwordGaugeAll = value
                saveChanged = true end
			changed, value = imgui.checkbox("set_CA_ChargedBottleNum", cfg.set_CA_ChargedBottleNum)
			if changed then cfg.set_CA_ChargedBottleNum = value
                saveChanged = true end
            imgui.text("Sharpness mulitplier's multipler")
            changed, value = imgui.drag_float("x", cfg.isAdjustSharpness, 0.01, 0.01, 50,"%.2f")
			if changed then cfg.isAdjustSharpness = value
                saveChanged = true end
			changed, value = imgui.checkbox("set_FixedDamage", cfg.set_FixedDamage)
			if changed then cfg.set_FixedDamage = value
                saveChanged = true end
			changed, value = imgui.checkbox("set_ThrowTaruCount", cfg.set_ThrowTaruCount)
			if changed then cfg.set_ThrowTaruCount = value
                saveChanged = true end
            changed, value = imgui.checkbox("set_infTrap", cfg.set_infTrap)
            if changed then cfg.set_infTrap = value
                saveChanged = true end
            changed, value = imgui.checkbox("set_infItem", cfg.set_infItem)
            if changed then cfg.set_infItem = value
                saveChanged = true end
                
			if saveChanged then json.dump_file("someCheat.json", cfg) end

			imgui.spacing()
			imgui.end_window()
		else
			drawSetting = false
		end
	end
end)




--local EquipDataManager = sdk.get_managed_singleton("snow.data.EquipDataManager")
--local PlEquipPack = EquipDataManager:call("get_PlEquipPack")
--local InventoryDataList = PlEquipPack:call("get_InventoryDataList")
--status=PlEquipPack:get_type_definition():get_full_name()
local script_name = "someCheat v0.2:"--..status.."!"
re.on_draw_ui(function()
    if string.len(script_name) > 0 then
        imgui.text(script_name)
    end
    imgui.same_line()
    if imgui.button("[someCheat]Setting") then
        drawSetting = true
    end
	
end)

sdk.hook(
    sdk.find_type_definition("snow.player.PlayerSharpnessAdjustRate"):get_method("getSharpnessAdjustRate"), 
    on_pre_get_sharpness_adjust_rate, 
    on_post_get_sharpness_adjust_rate)

sdk.hook(sdk.find_type_definition("snow.hit.userdata.PlHitAttackRSData"):get_method("get_SpecialPoint"), function(args)
    return sdk.PreHookResult.CALL_ORIGINAL
end, function(retval)
    local value = sdk.to_int64(retval)
	--log.debug("lua:log: "..tostring(value))
    return sdk.to_ptr(100)
end)
--snow.enemy.EnemyDamageStockParam is force kill / mario

local enemy_character_base_type_def = sdk.find_type_definition("snow.enemy.EnemyCharacterBase");
local enemy_character_base_type_def_update_method = enemy_character_base_type_def:get_method("update");
sdk.hook(enemy_character_base_type_def_update_method, function(args) 
    change_em_attr(sdk.to_managed_object(args[2]));
end, function(retval) end);


sdk.hook(sdk.find_type_definition("snow.data.DataShortcut"):get_method("consumeItem"), function(args)
    if cfg.set_infItem then
        return sdk.PreHookResult.SKIP_ORIGINAL
    else
        return sdk.PreHookResult.CALL_ORIGINAL
    end
end, function(retval) end)
sdk.hook(sdk.find_type_definition("snow.data.DataShortcut"):get_method("consumeItemFromPouch"), function(args)
    if cfg.set_infItem then
        return sdk.PreHookResult.SKIP_ORIGINAL
    else
        return sdk.PreHookResult.CALL_ORIGINAL
    end
end, function(retval) end)
sdk.hook(sdk.find_type_definition("snow.data.DataShortcut"):get_method("consumeItemFromBox"), function(args)
    if cfg.set_infItem then
        return sdk.PreHookResult.SKIP_ORIGINAL
    else
        return sdk.PreHookResult.CALL_ORIGINAL
    end
end, function(retval) end)