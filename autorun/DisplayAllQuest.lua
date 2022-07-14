sdk.hook(sdk.find_type_definition("snow.progress.quest.ProgressQuestManager"):get_method("isDisp"), function(args)
	return sdk.PreHookResult.SKIP_ORIGINAL
end, function(retval)
	return sdk.to_ptr(1)
end)