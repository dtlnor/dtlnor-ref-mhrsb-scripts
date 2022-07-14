
if not cfg then	cfg = {	} end
if not cfg.EmTypes then cfg.EmTypes = {} end
if not cfg.EnemyTypeIndex then cfg.EnemyTypeIndex = {} end


local function getList()
    local EnemyManager = sdk.get_managed_singleton("snow.enemy.EnemyManager")
	if not EnemyManager then return end

    local EnemyConvertIndex = EnemyManager:get_field("EnemyConvertIndex")
    if not EnemyConvertIndex then return end

    local kvPairs = EnemyConvertIndex:get_field("_entries")
    if not kvPairs then return end

    local kvPairCount = kvPairs:call("get_Count")
    if not kvPairCount then return end

	for i = 0, kvPairCount - 1 do
		local kvPair = kvPairs:call("get_Item", i)
		if kvPair then
            local key = kvPair:get_field("key")
            local value = kvPair:get_field("value")
            cfg.EmTypes[i+1] = key
            cfg.EnemyTypeIndex[i+1] = value
		end
	end
end


re.on_draw_ui(
    function() 
		
        if imgui.button("dumpEMList") then
            getList()
            json.dump_file("EMList.json", cfg)

        end
    end
)