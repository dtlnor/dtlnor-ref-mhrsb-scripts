local json_path = "bhvt_dump/"
local cfg = json.load_file(json_path.."dump_bhvt_infos.json")
-- local Enums_Internal = json.load_file(json_path.."Enums_Internal.json")

if not cfg then	cfg = {	} end
if not cfg.is_dump_action then cfg.is_dump_action = false end
if not cfg.is_dump_action then cfg.is_dump_condition = false end
if not cfg.is_dump_action then cfg.is_dump_event = false end
if not cfg.is_dump_action then cfg.is_dump_node = true end
-- layer = layer - 1
if not cfg.is_dump_action then cfg.layer = 1 end

json.dump_file(json_path.."dump_bhvt_infos.json", cfg)

local layer_names = {
    "MainLayer",
    "LowerLayer",
}

local murmur_hash_type = sdk.find_type_definition("via.murmur_hash")
local murmur_hash_as_utf8 = murmur_hash_type:get_method("calc32AsUTF8")
local murmur_hash_instance = nil
local function get_mmh3_as_utf8(string)
    if not string then return end

    if not murmur_hash_instance then
        murmur_hash_instance = murmur_hash_type:create_instance()
    end
    
    -- string = "snow.player.fsm.PlayerFsm2ActionDogRideAccess"
    -- log.debug(tostring(murmur_hash_as_utf8:call(murmur_hash, string, #string)))
    return murmur_hash_as_utf8:call(murmur_hash_instance, string, #string)
end

local function generate_enum_reverse(typename)
    local t = sdk.find_type_definition(typename)
    if not t then return {} end

    local fields = t:get_fields()
    local enum = {}

    for i, field in ipairs(fields) do
        if field:is_static() then
            local name = field:get_name()
            local raw_value = field:get_data(nil)

            log.info(name .. " = " .. tostring(raw_value))
 
            enum[raw_value] = name
        end
    end

    return enum
end

local function generate_node_tag_into_table(typename, enum_table)
    local t = sdk.find_type_definition(typename)
    if not t then return {} end

    local fields = t:get_fields()

    for i, field in ipairs(fields) do
        if field:is_static() then
            local name = field:get_name()
            local raw_value = field:get_data(nil)

            log.info(name .. " = " .. tostring(raw_value))
 
            enum_table[raw_value] = typename.."."..name
        end
    end

    return enum_table
end

local function value_to_enum(raw_value, value_type_def)
    -- return string if is enum, return list if is bitflag enum, return raw value if not enum
    local retval_value = raw_value
    if not retval_value then return retval_value end

    if value_type_def:is_a("System.Enum") then
        local enum_list = generate_enum_reverse(value_type_def:get_full_name())

        retval_value = enum_list[raw_value]
        if retval_value then
            retval_value = "["..tostring(raw_value).."]"..retval_value
        else
            -- bitflag?
            retval_value = {}
            local value_index = 1
            for enum_value, enum_name in pairs(enum_list) do
                if enum_value & raw_value > 0 then
                    retval_value[value_index] = "["..tostring(enum_value).."]"..enum_name
                    value_index = value_index+1
                end
            end
        end
    end
    return retval_value
end

local function update_all_getter(td, obj, tdb_properties_table)
    
    local methods = td:get_methods()
    for i = 1, #methods do
        local getter = methods[i]
        local name_start = 5
        local is_potential_getter = getter:get_num_params() == 0 and getter:get_name():find("get_") == 1
        
        if is_potential_getter then -- start of string
            local isolated_name = getter:get_name():sub(name_start)
            local retval_value = value_to_enum(getter:call(obj), getter:get_return_type())

            tdb_properties_table[isolated_name] = retval_value
        end
    end
    return tdb_properties_table
end

local function update_all_field(td, obj, tdb_fields_table)
    local fields = td:get_fields()
    for i=1, #fields do
        local field = fields[i]
        local field_name = field:get_name()
        local field_value = value_to_enum(field:get_data(obj), field:get_type())
        tdb_fields_table[field_name] = field_value
    end
    return tdb_fields_table
end

local function update_rsz_datas(all_rsz_table, rsz_objects, rsz_base_type_name, is_static)
    -- by object id
    for index = 0, #rsz_objects - 1 do
        local rsz_object = rsz_objects[index]
        local td = rsz_object:get_type_definition()
        local _type_name = td:get_full_name()

        local current_rsz_type = td
        local rsz_tdb_fields = {}
        local rsz_tdb_properties = {}

        while current_rsz_type:get_full_name() ~= rsz_base_type_name do
            update_all_getter(current_rsz_type, rsz_object, rsz_tdb_properties)
            update_all_field(current_rsz_type, rsz_object, rsz_tdb_fields)
            current_rsz_type = current_rsz_type:get_parent_type()
        end
        -- these are in rsz_base_type_name
        if rsz_base_type_name == "via.behaviortree.TransitionEvent" then
            rsz_tdb_properties["UID"] = rsz_object:get_UID()
            rsz_tdb_properties["Enabled"] = rsz_object:get_Enabled()
        elseif rsz_base_type_name == "via.behaviortree.Action" then
            rsz_tdb_properties["ID"] = rsz_object:get_ID()
            rsz_tdb_properties["Enabled"] = rsz_object:get_Enabled()
        elseif rsz_base_type_name == "via.behaviortree.Condition" then
            rsz_tdb_properties["ID"] = rsz_object:get_ID()
            -- rsz_tdb_properties["GUID"] = rsz_object:get_GUID():call("ToString()") -- always zero
            rsz_tdb_properties["Condition"] = rsz_object:getCondition()
        end

        local table_index = index
        if is_static then
            table_index = 0x40000000 | index
        end
        all_rsz_table[table_index] = {
            object_index = table_index,
            type_hash = get_mmh3_as_utf8(_type_name),
            hash_code = rsz_object:GetHashCode(),
            type_name = _type_name,
            fields = rsz_tdb_fields,
            properties = rsz_tdb_properties,
        }
    end
end

local dump_bhvt_infos = function()
    log.debug("dumping bhvt infos...")

    local UplayerManager = sdk.get_managed_singleton('snow.player.PlayerManager')
    if not UplayerManager then return end

    local UmasterPlayer = UplayerManager:call("findMasterPlayer")
    if not UmasterPlayer then return end
    local masterPlayerType = UmasterPlayer:get_type_definition():get_full_name()

    local playerGameObj = UmasterPlayer:call("get_GameObject")
    if not playerGameObj then return end

    local WeaponTypeValue = UmasterPlayer:get_field("_playerWeaponType")
    if not WeaponTypeValue then return end

    -- local snow_player_PlayerWeaponType = generate_enum_reverse("snow.player.PlayerWeaponType")
    -- local WeaponTypeName = snow_player_PlayerWeaponType[WeaponTypeValue]
    -- log.debug(tostring( WeaponTypeName ))

    local bhvt = playerGameObj:call("getComponent(System.Type)", sdk.typeof("via.behaviortree.BehaviorTree"))
	if bhvt == nil then return end
    -- log.debug(tostring( bhvt:get_tree_count() ))

	local motion_fsm2 = playerGameObj:call("getComponent(System.Type)", sdk.typeof("via.motion.MotionFsm2"))
	if motion_fsm2 == nil then return end

    -- get layer(inherit bhvt core handle) zero motion fsm2 ?
    local layer_count = motion_fsm2:call("getLayerCount")
    log.debug("layerCount " .. tostring(layer_count))

	local layer = motion_fsm2:call("getLayer", cfg.layer-1)
	if layer == nil then return end
    -- log.debug("layer " .. tostring(layer).." - " ..layer:ToString())
    -- log.debug("motion_fsm2 " .. " " ..motion_fsm2:ToString())

    -- from MotionFsm2Layer, get TreeObject
	local tree_object = layer:get_tree_object()
	if tree_object == nil then return end

    -- from TreeObject, get TreeObjectData
    local tree_object_data = tree_object:get_data()
	if tree_object_data == nil then return end
    
    -- from TreeObject, get TreeNode
    local tree_nodes = tree_object:get_nodes()
	if tree_nodes == nil then return end

    -- from TreeObjectData, get TreeNodeData
    local tree_node_datas = tree_object_data:get_nodes()
	if tree_node_datas == nil then return end

    -- from TreeObject, get actions re object
    local all_actions = tree_object:get_actions()
	if all_actions == nil then return end

    -- from TreeObjectData, get get static action
    local all_static_actions = tree_object_data:get_static_actions()
	if all_static_actions == nil then return end

    if not cfg.is_dump_action == false and cfg.is_dump_event == false and cfg.is_dump_node == false and cfg.is_dump_condition == false then 
        log.debug("early exit when not dumping anything...")
        return 
    end

    local all_action_table = {}
    update_rsz_datas(all_action_table, all_actions, "via.behaviortree.Action", false)
    update_rsz_datas(all_action_table, all_static_actions, "via.behaviortree.Action", true)

    if cfg.is_dump_action then
        json.dump_file(json_path..masterPlayerType.."_"..layer_names[cfg.layer].."_actions.json", all_action_table)
    end

    local all_transitions = tree_object:get_transitions()
	if all_transitions == nil then return end

    local all_static_transitions = tree_object_data:get_static_transitions()
	if all_static_transitions == nil then return end

    local all_transition_table = {}
    update_rsz_datas(all_transition_table, all_transitions, "via.behaviortree.TransitionEvent", false)
    update_rsz_datas(all_transition_table, all_static_transitions, "via.behaviortree.TransitionEvent", true)

    if cfg.is_dump_event then
        json.dump_file(json_path..masterPlayerType.."_"..layer_names[cfg.layer].."_events.json", all_transition_table)
    end

    local all_conditions = tree_object:get_conditions()
	if all_conditions == nil then return end

    local all_static_conditions = tree_object_data:get_static_conditions()
	if all_static_conditions == nil then return end

    local all_condition_table = {}
    update_rsz_datas(all_condition_table, all_conditions, "via.behaviortree.Condition", false)
    update_rsz_datas(all_condition_table, all_static_conditions, "via.behaviortree.Condition", true)

    if cfg.is_dump_condition then
        json.dump_file(json_path..masterPlayerType.."_"..layer_names[cfg.layer].."_conditions.json", all_condition_table)
    end

    if false then -- filter
        local filter = "snow.player.fsm.PlayerFsm2ActionAttackNameUI"
        -- snow.player.fsm.PlayerFsm2ActionAttackNameUIBowReadyEscape
        -- snow.player.fsm.PlayerFsm2ActionAttackNameUIGreatSword
        -- local filter_type = sdk.find_type_definition(filter)
        local match_list = {}
        for index = 0, tree_object:get_action_count() - 1 do
            local td = sdk.find_type_definition( all_action_table[index].type_name)
            if td:is_a(filter) then
                match_list[index] = all_action_table[index]
            end
        end

        -- snow.player.fsm.PlayerFsm2EventAttackNameUI
        -- snow.player.fsm.PlayerFsm2EventAttackNameUI_BowReadyEscape
        
        json.dump_file(WeaponTypeName.."_match_actions.json", match_list)
    
    end

    -- action_methods = tree_object_data:get_action_methods()
    -- -- lod.debug(tostring(action_methods:get_type_definition():get_full_name()))
    -- for i, action_method in ipairs(action_methods) do
    --     lod.debug(tostring(action_method))
    -- end
    
    if not cfg.is_dump_node then 
        log.debug("early exit when not dumping nodes...")
        return 
    end

    local node_tag_list = {
        "snow.player.SlashAxeTag",
        "snow.player.HeavyBowgunTag",
        "snow.player.BowTag",
        "snow.player.InsectGlaiveTag",
        "snow.player.LightBowgunTag",
        "snow.player.LanceTag",
        "snow.player.ChargeAxeTag",
        "snow.player.GreatSwordTag",
        "snow.player.HammerTag",
        "snow.player.GunLanceTag",
        "snow.player.ActionNoAttack",
        "snow.player.ActStatus",
        "snow.player.Situation",
        "snow.player.ServantAct",
        "snow.player.ForCamera",
        "snow.player.ForOtomo",
        "snow.player.ForEnemy",
        "snow.player.LobbyCommonTag",
        "snow.camera.NoInterrupt",
        "snow.otomo.OtStatus",
        "snow.otomo.OtActFlag",
        "snow.otomo.OtomoMotionTagEnum.MotionTagEnum",
        "snow.enemy.EnemyCommonMotionTagEnumDefine.MotionTagEnum",
    }

    local node_tag_collection = {}
    for i, tag_type in ipairs(node_tag_list) do
        generate_node_tag_into_table(tag_type, node_tag_collection)
    end

    local node_data_attr = {
        -- "via.behaviortree.TreeNodeData.NodeAttribute"
        [1]  = "IsEnabled",
        [2]  = "IsRestartable",
        [4]  = "HasReferenceTree",
        [8]  = "BubblesChildEnd",
        [16] = "SelectOnce",
        [32] = "IsFSMNode",
        [64] = "TraverseToLeaf",
    }
    
    -- tree node get re object, tree node data get index
    local all_node_table = {}
    for NodeIndex = 0, #tree_nodes -1 do
        -- local NodeID  = 135
        local node = tree_nodes[NodeIndex]
        local node_data = node:get_data()

        local full_name = node:get_full_name()
        local node_id = node_data.id
        -- local node_parent = node_data.parent
        -- local has_selector = node_data.has_selector
        -- local node_data_addr = node_data:as_memoryview():get_address()
        local node_is_branch = node_data.is_branch
        local node_is_end = node_data.is_end

        local node_attr = node_data.attr
        local node_attrs = {}
        local node_attrs_idx = 1
        for value, name in pairs(node_data_attr) do
            if (node_attr & value) > 0 then
                node_attrs[node_attrs_idx] = name
                node_attrs_idx = node_attrs_idx+1
            end
        end

        local node_tags = node_data:get_tags()
        local tags_table = {}
        for tags = 0, #node_tags - 1 do
            if node_tag_collection[node_tags[tags]] then
                tags_table[tags+1] = node_tag_collection[node_tags[tags]]
            else
                tags_table[tags+1] = node_tags[tags]
            end
        end

        local states = node_data:get_states()
        -- local states_2 = node_data:get_states_2() -- always zero
        local transition_conditions = node_data:get_transition_conditions() -- con dition
        local transition_events = node_data:get_transition_events() -- mStates
        local transition_ids = node_data:get_transition_ids() -- TransitionMaps
        local transition_attributes = node_data:get_transition_attributes() -- mTransitionAttributes
        local states_table = {}
        for cur_state = 0, #states - 1 do
            local tableindex = cur_state + 1
            states_table[tableindex] = {
                state_node_index = states[cur_state],
                state_node_name = tree_nodes[states[cur_state]]:get_full_name(),
                condition = all_condition_table[transition_conditions[cur_state]],
                event = {},
                transitionId = transition_ids[cur_state],
                attr = transition_attributes[cur_state],
            }
            local events = transition_events[cur_state]
            for cur_event = 0, #events - 1 do
                local event_tableindex = cur_event + 1
                local event = events[cur_event]
                states_table[tableindex].event[event_tableindex] = all_transition_table[event]
            end
        end
        
        local start_states = node_data:get_start_states() -- Transition
        local start_transitions = node_data:get_start_transitions() -- Transition [static]consition
        local start_states_table = {}
        for cur_start_state = 0, #start_states - 1 do
            local tableindex = cur_start_state + 1
            start_states_table[tableindex] = {
                state_node_index = start_states[cur_start_state],
                state_node_name = tree_nodes[start_states[cur_start_state]]:get_full_name(),
                condition = all_condition_table[start_transitions[cur_start_state]]
            }
        end

        local actions = node_data:get_actions()
        local actions_table = {}
        for cur_action = 0, #actions - 1 do
            local tableindex = cur_action + 1
            -- actions_table[tableindex] = actions[cur_action]
            actions_table[tableindex] = all_action_table[actions[cur_action]]
        end

        all_node_table[NodeIndex] = {
            full_name = full_name,
            node_id = node_id,
            node_index = NodeIndex,
            attr = node_attrs,
            is_branch = node_is_branch,
            is_end = node_is_end,
            tags = tags_table,
            states = states_table,
            start_states = start_states_table,
            actions = actions_table
        }


        -- -- local status1 = node:get_status1() --what is this

        -- local childrens = node_data:get_children() -- child nodes conditions
        -- local child_conditions = node_data:get_conditions() -- child nodes conditions
        -- for children = 0, #childrens - 1 do
        --     log.debug("    "..tostring(#childrens).."-"..tostring("children["..tostring(childrens[children]).."]"))
        --     log.debug("    "..tostring(#child_conditions).."-"..tostring("condition["..tostring(child_conditions[children]).."]"))
        -- end


    end

    json.dump_file(json_path..masterPlayerType.."_"..layer_names[cfg.layer].."_nodes.json", all_node_table)

    -- local AttackCombo_type = sdk.find_type_definition("snow.gui.AttackCombo")
    -- local AttackCombo_inst = AttackCombo_type:create_instance()
    -- AttackCombo_inst:resetAttackCombo()
    -- local setAttackCombo_method_td = AttackCombo_type:get_method("setAttackCombo(snow.player.PlayerAttackNameIUDefine.Command, snow.player.PlayerAttackNameIUDefine.AttackNameID)")
    -- -- log.debug(tostring(setAttackCombo_method_td:get_name()))
    -- setAttackCombo_method_td:call(AttackCombo_inst, 13, 41)
    -- log.debug(tostring(AttackCombo_inst:get_AttackMessageId():ToString()))
    -- local getmsg = sdk.find_type_definition("snow.gui.SnowGuiCommonUtility"):get_method("getMessage")
    -- log.debug(tostring(getmsg(nil,AttackCombo_inst:get_AttackMessageId())))

    log.debug("dump_bhvt_infos finish...")
end

re.on_draw_ui(
    function()
        if imgui.tree_node("dump_bhvt_infos") then
            local changed = false
            changed, cfg.is_dump_action = imgui.checkbox("Dump Actions", cfg.is_dump_action)
            if changed then json.dump_file(json_path.."dump_bhvt_infos.json", cfg) end

            changed, cfg.is_dump_condition = imgui.checkbox("Dump Conditions", cfg.is_dump_condition)
            if changed then json.dump_file(json_path.."dump_bhvt_infos.json", cfg) end

            changed, cfg.is_dump_event = imgui.checkbox("Dump Transition Events", cfg.is_dump_event)
            if changed then json.dump_file(json_path.."dump_bhvt_infos.json", cfg) end

            changed, cfg.is_dump_node = imgui.checkbox("Dump Nodes", cfg.is_dump_node)
            if changed then json.dump_file(json_path.."dump_bhvt_infos.json", cfg) end

            if imgui.button("Dump") then
                dump_bhvt_infos()
            end
            imgui.same_line()
            changed, cfg.layer = imgui.combo("layer["..tostring(cfg.layer-1).."]", cfg.layer, layer_names)
            if changed then json.dump_file(json_path.."dump_bhvt_infos.json", cfg) end
        end
        imgui.tree_pop()
    end
)
