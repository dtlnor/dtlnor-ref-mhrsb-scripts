sdk.hook(sdk.find_type_definition("snow.enemy.EnemyManager"):get_method("setupEnemyZakoSetData"), function(args)
	return sdk.PreHookResult.SKIP_ORIGINAL
end, function(retval) end)
