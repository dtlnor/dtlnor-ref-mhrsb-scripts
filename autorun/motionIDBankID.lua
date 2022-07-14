-- dtlnor rich info display motionID bankID only v1.0.0

if not cfg then	cfg = {	} end

if not cfg.rec_margin then cfg.rec_margin = 10 end
if not cfg.line_space then cfg.line_space = 20 end

if not cfg.general_x then cfg.general_x = 1250 end
if not cfg.general_y then cfg.general_y = 100 end
if not cfg.general_cap_width then cfg.general_cap_width = 120 end
if not cfg.general_width then cfg.general_width = 170 end

local total_line = 0
local general_line = 0
-- top left of rectengle
local printGeneralLine = function(cap, value)
	draw.text(cap, cfg.general_x + cfg.rec_margin, cfg.general_y + cfg.rec_margin + general_line * cfg.line_space, 0xFFFFFFFF)
	if value then
		draw.text(tostring(value), cfg.general_x + cfg.general_cap_width + cfg.rec_margin, cfg.general_y + general_line * cfg.line_space + cfg.rec_margin, 0xFFFFFFFF)
	end
	general_line = general_line + 1
end

re.on_frame(function()

	local PlayMan = sdk.get_managed_singleton("snow.player.PlayerManager")
	if not PlayMan then return end
	local MasterPlayer = PlayMan:call("findMasterPlayer")
	if not MasterPlayer then return end

	local IsFieldMainOutZone = MasterPlayer:call("get_IsFieldMainOutZone")
	local IsFieldMainZone = MasterPlayer:call("get_IsFieldMainZone")
	if IsFieldMainOutZone or IsFieldMainZone then

		general_line = 0

		draw.filled_rect(cfg.general_x, cfg.general_y, 
			cfg.general_width + cfg.general_cap_width + cfg.rec_margin * 2, 
			total_line * cfg.line_space + cfg.rec_margin * 2, 
			0x44000000)

		total_line = general_line

		local PlayerMotionCtrl = MasterPlayer:get_field("_RefPlayerMotionCtrl")
		if not PlayerMotionCtrl then return end
		
		local field = PlayerMotionCtrl:call("get_OldMotionID")
		printGeneralLine("OldMotionID", field)

		local field = PlayerMotionCtrl:call("get_OldBankID")
		printGeneralLine("OldBankID", field)
		
		total_line = general_line
	end

end)