local DifficultyWaveArgs = nil

function on_pre_getDifficultyWaveLv(args)
	DifficultyWaveArgs = args
    local NandoYuragi_type = args[3]
    local isSkill = args[4]
    --log.debug("lua:log: args 3: " .. tostring(NandoYuragi_type))
    --log.debug("lua:log: args 4: " .. tostring(isSkill))

    return sdk.PreHookResult.CALL_ORIGINAL
end

function on_post_getDifficultyWaveLv(retval)

    local NandoYuragi_type = sdk.to_int64(DifficultyWaveArgs[3])
    local isSkill = sdk.to_int64(DifficultyWaveArgs[4])
	local waveLv = sdk.to_ptr(0)
	
    --log.debug("lua:log: args 3: " .. tostring(NandoYuragi_type))
    --log.debug("lua:log: args 4: " .. tostring(isSkill))
	
	if NandoYuragi_type == 0 then
		waveLv = sdk.to_ptr(0)
		--log.debug("lua:log: out: " .. tostring(waveLv))
		return waveLv
	elseif NandoYuragi_type == 1 then
		waveLv = sdk.to_ptr(0xFFFFFFFF)
		--log.debug("lua:log: out: " .. tostring(waveLv))
		return waveLv
	elseif NandoYuragi_type == 2 then
		waveLv = sdk.to_ptr(0xFFFFFFFE)
		--log.debug("lua:log: out: " .. tostring(waveLv))
		return waveLv
	else
		--log.debug("lua:log: retval: " .. tostring(retval))
		return retval		
	end
		
end
	
sdk.hook(sdk.find_type_definition("snow.enemy.SystemDifficultyWaveData"):get_method("getDifficultyWaveLv"), 
	on_pre_getDifficultyWaveLv,
	on_post_getDifficultyWaveLv)
