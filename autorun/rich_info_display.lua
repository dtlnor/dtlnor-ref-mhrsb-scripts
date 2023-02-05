-- const define
local playerStats = {
	{cap="MaxHP",field="_vitalMax"},
	{cap="RedHP",field="_r_Vital"},
	{cap="CriticalRate",field="_CriticalRate"},
	{cap="Attack",field="_Attack"},
	{cap="Defence",field="_Defence"},
	{cap="AtkUpBuffTimer@60fps",field="_AtkUpBuffSecondTimer"},
	{cap="DefUpBuffTimer@60fps",field="_DefUpBuffSecondTimer"},
	--{cap="DeathCount",field="_DieCount"},
	{cap="createdShellId",field="_createdShellId"},
}

local playerAttackWorks = {
	{cap="Phase",property="get_Phase",enum=1},
	{cap="StartDelay@60fps",property="get_StartDelay",enum=0},
	{cap="EndDelay@60fps",property="get_EndDelay",enum=0},
	{cap="Timer@60fps",property="get_Timer",enum=0},
	--{cap="MotionLayerIndex",property="get_RefMotionLayerIndex",enum=0}, --seems const
	--{cap="Attr",property="get_Attr",enum=0}, --snow.hit.PlShapeAttr ????? --unkn attr seems const
	--{cap="ResourceIndex",property="get_ResourceIndex",enum=0},
	{cap="RSID",property="get_RSID",enum=0},
	{cap="HitIDUpdateCount",property="get_HitIDUpdateCount",enum=0},
	--{cap="HitIDUpdateLoopCount",property="get_HitIDUpdateLoopCount",enum=0}, --seems const
	{cap="TotalFrame@60fps",property="get_TotalFrame",enum=0},
	{cap="HitIDUpdateEndFrame@60fps",property="get_HitIDUpdateEndFrame",enum=0},
}
local playerAttackWorksEnum={
	["Phase"] = {
		[0] = "Initialized",
		[1] = "Started",
		[2] = "Active",
		[3] = "Finished",
	},
}
local playerHitAttackRSData = {
	{cap="HitID",property="get_HitID",enum=0},
	{cap="HitIdUpdateLoopNum",property="get_HitIdUpdateLoopNum",enum=0},
	{cap="HitIDUpdateDelaiesNum",property="get_HitIDUpdateDelaiesNum",enum=0},
	{cap="HitIdUpdateNum",property="get_HitIdUpdateNum",enum=0},
	{cap="SumHitIdUpdateDelaies",property="get_SumHitIdUpdateDelaies",enum=0},
	--{cap="ConstHitID",property="get_ConstHitID",enum=0}, --seems same to HitID
	--{cap="DamageTypeValue",property="get_DamageTypeValue",enum=0}, --seems const
	{cap="Damage",property="get_Damage",enum=0},
	{cap="AttackAttr",property="get_AttackAttr",enum=2},
	{cap="hitFlag",property="get_Flag",enum=2},
	--{cap="HitAttr",property="get_HitAttr",enum=2}, --already in rcol, skip it
	--{cap="HitStartDelay",property="get_HitStartDelay",enum=0}, --seems same to StartDelay
	--{cap="HitEndDelay",property="get_HitEndDelay",enum=0}, --seems same to EndDelay
	--{cap="TotalDamage",property="get_TotalDamage",enum=0}, --seems same to Base damage
	{cap="BaseDamage(MV)",property="get_BaseDamage",enum=0},
	--{cap="Name",property="get_Name",enum=0},
	--{cap="get_StaminaDamage",property="get_StaminaDamage",enum=0},
	{cap="CriticalRate",property="get_CriticalRate",enum=0},
	--{cap="get_ActionRandom",property="get_ActionRandom",enum=0},
	--{cap="get_SubRate",property="get_SubRate",enum=0},
	--{cap="get_BaseSubRate",property="get_BaseSubRate",enum=0},
	--{cap="get_DebuffRate",property="get_DebuffRate",enum=0},
	{cap="JustStartDelay@60fps",property="get_JustStartDelay",enum=0},
	{cap="JustKeepTime@60fps",property="get_JustKeepTime",enum=0},
	--{cap="get_BreakRate",property="get_BreakRate",enum=0},
	--{cap="get_BaseWireAttackDamage",property="get_BaseWireAttackDamage",enum=0},
	--{cap="get_RequestSetResourseIndex",property="get_RequestSetResourseIndex",enum=0},
	--{cap="get_RequestSetID",property="get_RequestSetID",enum=0},
	--{cap="OverriddenHitStopType",property="get_OverriddenHitStopType",enum=1},
	{cap="OverriddenHitStopTime",property="get_OverriddenHitStopTime",enum=1},
	--{cap="get_HitStopType",property="get_HitStopType",enum=0},
	--{cap="get_HitStopTime",property="get_HitStopTime",enum=0},
	--{cap="get_SpecialPoint",property="get_SpecialPoint",enum=0},
	--{cap="get_GimmickDamageType",property="get_GimmickDamageType",enum=0},
	--{cap="get_HitMarkType",property="get_HitMarkType",enum=0},
	--{cap="get_PlayerAttackAttr",property="get_PlayerAttackAttr",enum=0},
}
local playerHitAttackRSDataEnum={
	["AttackAttr"] = {
		[1] = "ElementS",
		[2] = "Bomb",
		[4] = "EnsureDebuff",
		[8] = "TriggerMount", --TriggerMarionetteStart",
		[16] = "ForceKill",
		[32] = "Fertilizers", --"Koyashi",
		[64] = "AllowDisabled",
		[128] = "PreventCheepTech",
		[256] = "RampageBossAngerEndSpStop",
		[512] = "ForcePartsLossPermitDamageAttrSlash",
	},
	["hitFlag"] = {
		[1] = "SelfHit",
		[2] = "TeamHit",
		[4] = "TeamHitPlNoDamage",
		[8] = "FirstHitId",
		[16] = "PunishingDraw", --BattoPower
		[32] = "DownStaminaBottle",
	},
	["OverriddenHitStopType"] = {
		[0] = "None",
		[1] = "HitStop",
		[2] = "HitSlow",
		[3] = "AbsHitStop",
		[4] = "Max",
	},
	["OverriddenHitStopTime"] = {
		[0] = "Lv0",
		[1] = "Lv1",
		[2] = "Lv2",
		[3] = "Lv3",
		[4] = "Lv4",
		[5] = "Lv5",
		[6] = "Lv6",
		[7] = "Lv7",
		[8] = "Lv8",
	}
}

local GlobleEnum = {
	["ActionPattern"] = { --snow.player.DamageActionInfo.ActionPattern
		[0] = "NotDamage",
		[1] = "StunStart",
		[2] = "StunLoop",
		[3] = "StunEnd",
		[4] = "ParalyzeStart",
		[5] = "ParalyzeLoop",
		[6] = "ParalyzeEnd",
		[7] = "SleepMovableWait",
		[8] = "SleepMovableWalk",
		[9] = "SleepMainStart",
		[10] = "SleepMainLoop",
		[11] = "SleepMainEnd",
		[12] = "TornadoStart",
		[13] = "TornadoLoop",
		[14] = "TornadoEnd",
		[15] = "QuakeStart",
		[16] = "QuakeLoop",
		[17] = "QuakeEnd",
		[18] = "BetoStart",
		[19] = "BetoLoop",
		[20] = "BetoFire",
		[21] = "BetoEnd",
		[22] = "Smash",
		[23] = "SmashDown",
		[24] = "SmashSp",
		[25] = "Upper",
		[26] = "Small",
		[27] = "FallDown",
		[28] = "Wind",
		[29] = "Ear",
		[30] = "Slammed",
		[31] = "EscapeDamage",
	},
	["CheckType"] = { --snow.player.DamageReflexInfo.Type
		[0] = "Common_NoHit",
		[1] = "Common_NoDamageHit",
		[2] = "Bow_JustEscape",
		[3] = "ShortSword_Counter",
		[4] = "Common_GimmickHold",
		[5] = "GunLance_GuardEdge",
	},
	["ActionNoAttackTag"] = {
		[0xFDCE8F4A] = "NONE",
		[0x82C455F9] = "AttackWait",
		[0x0FD26018] = "AttackWalk",
		[0xB2FF03D5] = "AttackStepS",
		[0x7396C01F] = "AttackStepM",
		[0xC96F469A] = "AttackStepL",
		[0xAF07CD00] = "AttackFall",
		[0x0A80DC7C] = "AttackJump",
		[0xF28390A2] = "AttackKan",
		[0x2496DFA8] = "AttackKanVer2",
		[0x8FF6E2CF] = "AttackGuardWait",
		[0x5278C6B3] = "AttackGuardHitL",
		[0x361EE75F] = "AttackGuardHitM",
		[0x1B66484C] = "AttackGuardHitS",
		[0xA33A1AF1] = "AttackGuardStart",
		[0xF9B2A2EF] = "AttackGuardEnd",
		[0x4C6041ED] = "AttackEscape",
		[0xB4EB0BEC] = "Attack000",
		[0xD2E13406] = "Attack001",
		[0x5781331A] = "Attack002",
		[0x15779D9F] = "Attack003",
		[0x91290127] = "Attack004",
		[0x9C3CDC73] = "Attack005",
		[0xEEB0B20B] = "Attack006",
		[0xD6CCAE4C] = "Attack007",
		[0xEB47697A] = "Attack008",
		[0x6E4B96A1] = "Attack009",
		[0x25FAE7C4] = "Attack010",
		[0x484A9378] = "Attack011",
		[0x2859E147] = "Attack012",
		[0x20A39CA5] = "Attack013",
		[0x86DB2652] = "Attack014",
		[0xEEA0F4E0] = "Attack015",
		[0x3C50D593] = "Attack016",
		[0x234E6881] = "Attack017",
		[0xA39ED0A8] = "Attack018",
		[0x3C589F65] = "Attack019",
		[0x9F107F38] = "Attack020",
		[0xE4A3B989] = "Attack021",
		[0x4E7A7B84] = "Attack022",
		[0x90EC8AA7] = "Attack023",
		[0xC6AF6CA7] = "Attack024",
		[0x70939329] = "Attack025",
		[0x5B3E754B] = "Attack026",
		[0x038A8460] = "Attack027",
		[0xE497D607] = "Attack028",
		[0xDA50A56A] = "Attack029",
		[0x5DAF9E2D] = "Attack030",
		[0x7211DFA3] = "Attack031",
		[0xA09E65B6] = "Attack032",
		[0x9D661F68] = "Attack033",
		[0x4AA6D8C4] = "Attack034",
		[0xFB68B18A] = "Attack035",
		[0x14EA3936] = "Attack036",
		[0xF53BCA28] = "Attack037",
		[0x153FA9CB] = "Attack038",
		[0x6F4A7BF9] = "Attack039",
		[0x0A6CAA23] = "Attack040",
		[0x57C8B578] = "Attack041",
		[0x7AA815A0] = "Attack042",
		[0x4315D3F8] = "Attack043",
		[0x178C9F0A] = "Attack044",
		[0xE8036967] = "Attack045",
	},
	["damage_type"] = {
		[0] = "Invalid",
		[1] = "None",
		[2] = "KnockBack",
		[3] = "FallDown",
		[4] = "Buttobi",
		[5] = "ButtobiNoDown",
		[6] = "ButtobiSp",
		[7] = "ButtobiNoEscape",
		[8] = "Upper",
		[9] = "ButtobiSlamDown",
		[10] = "WindS",
		[11] = "WindM",
		[12] = "WindL",
		[13] = "QuakeS",
		[14] = "QuakeL",
		[15] = "EarS",
		[16] = "EarL",
		[17] = "EarLL",
		[18] = "CatchAttack",
		[19] = "CatchingAttack",
		[20] = "MarionetteAttack",
		[21] = "GrappleAttack",
		[22] = "OtomoConstrain",
		[23] = "BuffAttack",
		[24] = "BuffDefence",
		[25] = "BuffStamina",
		[26] = "HitCheck",
		[27] = "Deodorant",
		[28] = "BuffInk",
		[29] = "Flash",
		[30] = "Sound",
		[31] = "Tornado",
		[32] = "TornadoAttack",
		[33] = "RecoverableUpper",
		[34] = "NoMediationCatchAttack",
		[35] = "PositionRise",
		[36] = "Beto",
		[37] = "QuakeIndirect",
		[38] = "ButtobiHm",
		[39] = "Max",
	},
	["DamageReaction"] = {
		[-1] = "None",
		[0] = "Small_F",
		[1] = "Small_B",
		[2] = "Small_L",
		[3] = "Small_R",
		[4] = "Smash_F",
		[5] = "Smash_B",
		[6] = "SmashDown_F",
		[7] = "SmashDown_B",
		[8] = "SmashSp",
		[9] = "SmashDownNoEscape_F",
		[10] = "SmashDownNoEscape_B",
		[11] = "FallDown_F",
		[12] = "FallDown_B",
		[13] = "Upper_F",
		[14] = "Upper_B",
		[15] = "UpperFriend_F",
		[16] = "UpperFriend_B",
		[17] = "UpperRecoverable_F",
		[18] = "Fly_Small_F",
		[19] = "Fly_Small_B",
		[20] = "Paralyze_Normal",
		[21] = "Paralyze_Fly",
		[22] = "SmallInParalyze",
		[23] = "Sleep",
		[24] = "Quake_S",
		[25] = "Quake_L",
		[26] = "Ear_S",
		[27] = "Ear_L",
		[28] = "Ear_LL",
		[29] = "Ear_Fly",
		[30] = "Wind_S",
		[31] = "Wind_L",
		[32] = "Wind_LL",
		[33] = "Wind_Fly",
		[34] = "Guard_S",
		[35] = "Guard_M",
		[36] = "Guard_L",
		[37] = "LanceCounter_S",
		[38] = "LanceCounter_M",
		[39] = "LanceCounter_L",
		[40] = "LancePowerGuard_S",
		[41] = "LancePowerGuard_M",
		[42] = "LancePowerGuard_L",
		[43] = "LanceGuardRage_S",
		[44] = "LanceGuardRage_M",
		[45] = "LanceGuardRage_L",
		[46] = "LanceGuardDash_S",
		[47] = "LanceGuardDash_M",
		[48] = "LanceGuardDash_L",
		[49] = "LanceJustGuard",
		[50] = "LanceGuardFly_S",
		[51] = "LanceGuardFly_M",
		[52] = "LanceGuardFly_L",
		[53] = "ChargeAxeAnchorGuard_S",
		[54] = "ChargeAxeAnchorGuard_M",
		[55] = "ChargeAxeAnchorGuard_L",
		[56] = "ChargeAxeAnchorGuard_NoCharge",
		[57] = "RestraintSign_Kneel",
		[58] = "RestraintSign_LieOnFace",
		[59] = "ButtobiSlamDown",
		[60] = "EnemyConstMediationCatch",
		[61] = "Tornado",
		[62] = "TornadoAttack",
		[63] = "Flash",
		[64] = "PositionRise",
		[65] = "Beto",
		[66] = "BetoFire",
		[67] = "QuakeIndirect",
		[68] = "Stun",
		[69] = "ChainWireMoveGuard_S",
		[70] = "ChainWireMoveGuard_M",
		[71] = "Ride_Small_F",
		[72] = "Ride_Small_B",
		[73] = "Ride_Loop",
		[74] = "Ride_Smash_F",
		[75] = "Ride_Smash_B",
		[76] = "Ride_Fall_F",
		[77] = "Ride_Fall_B",
		[78] = "Ride_Paralyze",
		[79] = "Ride_Beto",
		[80] = "Ride_Wind_S",
		[81] = "Ride_Wind_L",
		[82] = "Ride_Wind_LL",
		[83] = "Ride_Wind_Fly",
		[84] = "Ride_Ear_S",
		[85] = "Ride_Ear_L",
		[86] = "Ride_Ear_LL",
		[87] = "Ride_Ear_Fly",
		[88] = "Ride_Quake_S",
		[89] = "Ride_Quake_L",
		[90] = "Ride_Flash",
		[91] = "Ride_Tornado",
		[92] = "Ride_TornadoAttack",
		[93] = "Ride_PositionRise",
		[94] = "Ride_SmashSp",
		[95] = "Ride_SmashDownNoEscape_F",
		[96] = "Ride_SmashDownNoEscape_B",
		[97] = "Num",		
	},
	["GuardReaction"] = {
		[-1] = "None",
		[0] = "S",
		[1] = "M",
		[2] = "L",
		[3] = "Max",
	},
	["HitResponse"] = {
		[0] = "yellow Lv2", --Shinzaku
		[1] = "yellow", --Zaku
		[2] = "white", --Suru
		[3] = "bounce", --Kan
		[4] = "Max",
		[5] = "Invalid",
	},
	["MotTags"] = {
		[3960009946] = "Situation_Muteki",
		[1780053704] = "Situation_HunterWireNotRecover",
		[1569967862] = "Situation_NorecoverStamina",
		[1621177739] = "Situation_SuperArmor",
		[997029872] = "Situation_HyperArmor",
		[4234667294] = "Situation_IgnoreKan",
		[564685070] = "Situation_FlyIsJump",
		[2066114227] = "Situation_WireAimUIOff",
		[429118873] = "Situation_WallStepOn",
	},
	["Command"] = {
		[0] = "AtkX",
		[1] = "AtkA",
		[2] = "AtkXA",
		[3] = "AtkXR1",
		[4] = "AtkAR1",
		[5] = "AtkXAR1",
		[6] = "AtkR2",
		[7] = "AtkR2On",
		[8] = "AtkR2Off",
		[9] = "AtkR1Release",
		[10] = "AtkR2Release",
		[11] = "AtkXOn",
		[12] = "AtkAOn",
		[13] = "AtkXOff",
		[14] = "AtkAOff",
		[15] = "AtkXRelease",
		[16] = "AtkARelease",
		[17] = "WpStart",
		[18] = "WpEnd",
		[19] = "Escape",
		[20] = "EscapeR",
		[21] = "EscapeL",
		[22] = "EscapeF",
		[23] = "EscapeB",
		[24] = "AtkR1",
		[25] = "Dash",
		[26] = "Guard",
		[27] = "Sit",
		[28] = "WpStartXAR",
		[29] = "Ride",
		[30] = "Tsuta",
		[31] = "TsutaEnd",
		[32] = "TsutaDash",
		[33] = "WireUp",
		[34] = "WireFront",
		[35] = "WireTarget",
		[36] = "WireStopEnd",
		[37] = "WireEscape",
		[38] = "WireUpGunner",
		[39] = "WireFrontGunner",
		[40] = "PopAction",
		[41] = "GimmickPopAction",
		[42] = "GimmickCancel",
		[43] = "NpcFacilityPopAction",
		[44] = "LongJump",
		[45] = "ItemPopAction",
		[46] = "EnvCreaturePopAction",
		[47] = "AtkR1Delay",
		[48] = "AtkAwithoutR1",
		[49] = "AtkXwithoutR1",
		[50] = "AtkXAwithoutR1",
		[51] = "AtkXorA",
		[52] = "AtkXwithoutA",
		[53] = "AtkAwithoutX",
		[54] = "AtkXwithoutAandR1",
		[55] = "AtkAwithoutXandR1",
		[56] = "ItemY",
		[57] = "ItemYOn",
		[58] = "ItemYOff",
		[59] = "KunaiAimZLOn",
		[60] = "RideDriftOn",
		[61] = "RideDriftOff",
		[62] = "RideJump",
		[63] = "SlidingJump",
		[64] = "Marionette",
		[65] = "AnyTrigger",
		[66] = "OtomoPopAction",
		[67] = "AtkRB",
		[68] = "HagitoriPopAction",
		[69] = "TrapRemovePopAction",
		[70] = "LongJumpPointRelease",
		[71] = "AtkBNoDelay",
		[72] = "AtkBOff",
		[73] = "AtkXAOn",
		[74] = "AtkR1ZL",
		[75] = "OtomoCommunicationStart",
		[76] = "OtomoCommunicationA",
		[77] = "OtomoCommunicationB",
		[78] = "OtomoCommunicationX",
		[79] = "OtomoCommunicationY",
		[80] = "AtkR1ZR",
		[81] = "AtkR1Off",
		[82] = "AtkXInclude",
		[83] = "AtkAInclude",
		[84] = "DeliveryPopAction",
		[85] = "Fishing",
		[86] = "DropEnvCreature",
		[87] = "Decide",
		[88] = "Cancel",
		[89] = "AtkR1On",
		[90] = "AtkZLB",
		[91] = "Marionette_AtkA",
		[92] = "Marionette_AtkX",
		[93] = "Marionette_AtkXA",
		[94] = "Marionette_Escape",
		[95] = "Marionette_FreeRun",
		[96] = "Marionette_Separation",
		[97] = "BowEscape",
		[98] = "BowChangeBottle",
		[99] = "BowReadyShot",
		[100] = "BowFireShot",
		[101] = "BowFireShotTrg",
		[102] = "BowDragonShot",
		[103] = "BowComboArrowAtk",
		[104] = "BowAtkA",
		[105] = "BowAtkAOn",
		[106] = "BowAtkARelease",
		[107] = "BowWireUpReadyBow",
		[108] = "BowWireFrontReadyBow",
		[109] = "BowgunShotTrg",
		[110] = "BowgunShotOn",
		[111] = "BowgunShotOnWithoutStrike",
		[112] = "BowgunShotOff",
		[113] = "BowgunSpecialBullet",
		[114] = "BowgunReload",
		[115] = "BowgunReloadWithoutA",
		[116] = "BowgunStrike",
		[117] = "BowgunFlyAtkX",
		[118] = "BowgunContinueReload",
		[119] = "BowgunShotOnDelay",
		[120] = "WireUpReadyHeavy",
		[121] = "WireFrontReadyHeavy",
		[122] = "RideDash",
		[123] = "ActionStart",
		[124] = "ActionEnd",
		[125] = "ItemTake",
		[126] = "AtkXAR1_ZR",
		[127] = "AtkXAorR1",
		[128] = "Gimmick_Hold",
		[129] = "Gimmick_HoldCancel",
		[130] = "GatlingGunShotEnd",
		[131] = "GimmickShotTrg_AorZR",
		[132] = "GimmickShotTrg_X",
		[133] = "GimmickShotTrg_Y",
		[134] = "GimmickShotOn_AorZR",
		[135] = "GimmickShotOn_X",
		[136] = "GimmickShotOn_Y",
		[137] = "AtkXAorR1Trg",
		[138] = "GuardTrg",
		[139] = "AtkZRZL",
		[140] = "AtkXOriginal",
		[141] = "AtkXOnOriginal",
		[142] = "AtkAOnOriginal",
		[143] = "PopActionOn",
		[144] = "AtkXAR1_NoCheckZL",
		[145] = "CancelNoDelay",
		[146] = "Max",

	}
}
local hitdata_type = sdk.find_type_definition("snow.hit.userdata.BaseHitAttackRSData")
local app_type = sdk.find_type_definition("via.Application")
local CharacterController_type = sdk.find_type_definition("via.physics.CharacterController")

local playerWeaponType = {
	GreatSword = 0,
	SlashAxe = 1,
	LongSword = 2,
	LightBowgun = 3,
	HeavyBowgun = 4,
	Hammer = 5,
	GunLance = 6,
	Lance = 7,
	ShortSword = 8,
	DualBlades = 9,
	Horn = 10,
	ChargeAxe = 11,
	InsectGlaive = 12,
	Bow = 13,
	FemaleStart = 14,
}

local cfg = json.load_file("rich_info_display.json")

if not cfg then	cfg = {	} end

if not cfg.FONT_NAME then cfg.FONT_NAME = "NotoSansCJKjp-Bold.otf" end
if not cfg.FONT_SIZE then cfg.FONT_SIZE = 18 end

if not cfg.rec_margin then cfg.rec_margin = 10 end
if not cfg.line_space then cfg.line_space = 20 end

if not cfg.general_x then cfg.general_x = 1250 end
if not cfg.general_y then cfg.general_y = 100 end
if not cfg.general_cap_width then cfg.general_cap_width = 120 end
if not cfg.general_width then cfg.general_width = 170 end

if not cfg.works_x then cfg.works_x = 1200 end
if not cfg.works_y then cfg.works_y = 130 end
if not cfg.work_cap_width then cfg.work_cap_width = 180 end
if not cfg.work_width then cfg.work_width = 125 end

if not cfg.is_link_general then cfg.is_link_general = false end
if not cfg.shell_works_x then cfg.shell_works_x = cfg.works_x end
if not cfg.shell_works_y then cfg.shell_works_y = cfg.works_y + (#playerAttackWorks + #playerHitAttackRSData + 4) * cfg.line_space + cfg.rec_margin * 2 end
if not cfg.shell_work_num then cfg.shell_work_num = 8 end

if not cfg.shellLifeSec then cfg.shellLifeSec = 15 end
if not cfg.isShellManuallySetLife then cfg.isShellManuallySetLife = false end

if not cfg.shapeColor then cfg.shapeColor = 0x30FFAAAA end
if not cfg.limitShapeStock then cfg.limitShapeStock = 1 end

if not cfg.printAtkWorks then cfg.printAtkWorks = false end
if not cfg.printShellWork then cfg.printShellWork = false end

local screen_w = 1920
local screen_h = 1080

json.dump_file("rich_info_display.json", cfg)

local total_line = 0
local CHINESE_GLYPH_RANGES = {
    0x0020, 0x00FF, -- Basic Latin + Latin Supplement
	0x0100, 0x017F, -- Latin Extended-A
	0x0180, 0x024F, -- Latin Extended-B
	--0x2150, 0x218F, -- Number Forms
	0x1E00, 0x21FF, -- Latin Extended Additional to Number Forms
    0x2000, 0x206F, -- General Punctuation
    0x3000, 0x30FF, -- CJK Symbols and Punctuations, Hiragana, Katakana
    0x31F0, 0x31FF, -- Katakana Phonetic Extensions
    0xFF00, 0xFFEF, -- Half-width characters
    0x4e00, 0x9FAF, -- CJK Ideograms
	0x25A0, 0x25FF, -- Geometric Shapes
    --0x0020, 0xE007F, -- All (https://jrgraphix.net/research/unicode_blocks.php)
    0,
}

local font = imgui.load_font(cfg.FONT_NAME, cfg.FONT_SIZE, CHINESE_GLYPH_RANGES)

local general_line = 0
-- top left of rectengle
local printGeneralLine = function(cap, value)
	local value_color = 0xFFFFFFFF
	draw.text(cap, cfg.general_x + cfg.rec_margin, cfg.general_y + cfg.rec_margin + general_line * cfg.line_space, 0xFFFFFFFF)
	if value == true then
		value = "true"
		value_color = 0xFF00FF00
	elseif value == false then
		value = "false"
		value_color = 0xFFFFFFFF
	elseif value == nil then
		value = "nil"
		value_color = 0xFF808080
	end
	if value then
		draw.text(tostring(value), cfg.general_x + cfg.general_cap_width + cfg.rec_margin, cfg.general_y + general_line * cfg.line_space + cfg.rec_margin, value_color)
	end
	general_line = general_line + 1
end

local printGeneralLine_color = function(cap, value, value_color)
	draw.text(cap, cfg.general_x + cfg.rec_margin, cfg.general_y + cfg.rec_margin + general_line * cfg.line_space, value)
	if value == true then
		value = "true"
	elseif value == false then
		value = "false"
	elseif value == nil then
		value = "nil"
	end
	if value then
		draw.text(tostring(value), cfg.general_x + cfg.general_cap_width + cfg.rec_margin, cfg.general_y + general_line * cfg.line_space + cfg.rec_margin, value_color)
	end
	general_line = general_line + 1
end

local works_line = 0
--top right of rectengle
local printWorkLine = function(str, work_idx, works_x, works_y)
	draw.text(tostring(str), 
		works_x - cfg.work_width * work_idx - cfg.work_cap_width + cfg.rec_margin, 
		works_y + cfg.rec_margin + works_line * cfg.line_space, 
		0xFFFFFFFF)
		works_line = works_line + 1
end

local showHitWorks = function(AttackWorks, works_x, works_y)
	works_line = 0

	draw.filled_rect(works_x - cfg.work_width * #AttackWorks - cfg.work_cap_width,
		works_y,
		cfg.work_width * #AttackWorks + cfg.work_cap_width + cfg.rec_margin * 2 ,
		(#playerAttackWorks + #playerHitAttackRSData + 4) * cfg.line_space + cfg.rec_margin * 2,
		0x44000000)
	
	local anchor = works_line
	printWorkLine("----Hit AttackWorks Data----", 0, works_x, works_y)

	-- show caps
	for propertyNum in pairs(playerAttackWorks) do
		printWorkLine(playerAttackWorks[propertyNum].cap, 0, works_x, works_y)
	end

	for i, work in pairs(AttackWorks) do
		works_line = anchor
		printWorkLine("work["..tostring(i).."]", i, works_x, works_y)
		
		for propertyNum in pairs(playerAttackWorks) do
			local property = work:call(playerAttackWorks[propertyNum].property)
			if property then
				if (property >= 2147483648) then
					property = property - 4294967296
				end
				if playerAttackWorks[propertyNum].enum == 1 then
					property = playerAttackWorksEnum[playerAttackWorks[propertyNum].cap][property]
				elseif playerAttackWorks[propertyNum].enum == 2 then
					local resultStr = ""
					for bit, str in pairs(playerAttackWorksEnum[playerAttackWorks[propertyNum].cap]) do
						if (bit & property) == bit then
							resultStr = resultStr..str.." "
						end
					end
					property = resultStr
				end
				printWorkLine(property, i, works_x, works_y)
			end
		end
	end
	works_line = works_line + 1

	printWorkLine("----Hit Data----", 0, works_x, works_y)

	anchor = works_line
	-- show caps
	for propertyNum in pairs(playerHitAttackRSData) do
		printWorkLine(playerHitAttackRSData[propertyNum].cap, 0, works_x, works_y)
	end
	printWorkLine("name", 0, works_x, works_y)

	for i, work in pairs(AttackWorks) do
		local HitData = work:call("get_HitData")

		if HitData then
			works_line = anchor
			for propertyNum in pairs(playerHitAttackRSData) do
				local property = HitData:call(playerHitAttackRSData[propertyNum].property)
				if property then
					if (property >= 2147483648) then
						property = property - 4294967296
					end
					if playerHitAttackRSData[propertyNum].enum == 1 then
						property = playerHitAttackRSDataEnum[playerHitAttackRSData[propertyNum].cap][property]
					elseif playerHitAttackRSData[propertyNum].enum == 2 then
						local resultStr = ""
						for bit, str in pairs(playerHitAttackRSDataEnum[playerHitAttackRSData[propertyNum].cap]) do
							if (bit & property) == bit then
								resultStr = resultStr..str.." "
							end
						end
						property = resultStr
					end
					printWorkLine(property, i, works_x, works_y)
				end
			end

			local name = sdk.call_native_func(HitData, hitdata_type, "get_Name")
			if name then
				printWorkLine(name, i, works_x, works_y)
			end
		end
	end
end

local showShellWorksBase = function(works_x, works_y)
	works_line = 0
	draw.filled_rect(works_x - cfg.work_width * cfg.shell_work_num - cfg.work_cap_width,
		works_y,
		cfg.work_width * cfg.shell_work_num + cfg.work_cap_width + cfg.rec_margin * 2 ,
		(#playerAttackWorks + #playerHitAttackRSData + 3) * cfg.line_space + cfg.rec_margin * 2,
		0x44000000)
	
	local anchor = works_line
	printWorkLine("----Shell AttackWorks Data----", 0, works_x, works_y)

	-- show caps
	for propertyNum in pairs(playerAttackWorks) do
		printWorkLine(playerAttackWorks[propertyNum].cap, 0, works_x, works_y)
	end

	printWorkLine("----Hit Data----", 0, works_x, works_y)

	-- show caps
	for propertyNum in pairs(playerHitAttackRSData) do
		printWorkLine(playerHitAttackRSData[propertyNum].cap, 0, works_x, works_y)
	end
	printWorkLine("name", 0, works_x, works_y)
end

local hasShellInstance = false
local workidx = 0
local storedwork = {
	[1] = 0,
	[2] = 0,
	[3] = 0,
	[4] = 0,
	[5] = 0,
	[6] = 0,
	[7] = 0,
	[8] = 0,
}
local inStored = function(hit)
	for i, hitID in ipairs(storedwork) do
		if hit == hitID then
			return i
		end
	end
	return 0
end
local showShellWorks = function(cap, AttackWorks, works_x, works_y)
	works_line = 0
	local anchor = works_line

	for i, work in pairs(AttackWorks) do
		works_line = anchor
		local HitData = work:call("get_HitData")
		if HitData then
			local hitID = HitData:call("get_HitID")
			local workidxResult = inStored(hitID)

			hasShellInstance = true

			if workidxResult ~= 0 then
				workidx = workidxResult
			else
				workidx = (workidx % cfg.shell_work_num) + 1
				storedwork[workidx] = hitID
			end

			printWorkLine(cap.." work["..tostring(i).."]", workidx, works_x, works_y)
			
			for propertyNum in pairs(playerAttackWorks) do
				local property = work:call(playerAttackWorks[propertyNum].property)
				if property then
					if (property >= 2147483648) then
						property = property - 4294967296
					end
					if playerAttackWorks[propertyNum].enum == 1 then
						property = playerAttackWorksEnum[playerAttackWorks[propertyNum].cap][property]
					elseif playerAttackWorks[propertyNum].enum == 2 then
						local resultStr = ""
						for bit, str in pairs(playerAttackWorksEnum[playerAttackWorks[propertyNum].cap]) do
							if (bit & property) == bit then
								resultStr = resultStr..str.." "
							end
						end
						property = resultStr
					end
					printWorkLine(property, workidx, works_x, works_y)
				end
			end
			printWorkLine("", workidx, works_x, works_y)
			for propertyNum in pairs(playerHitAttackRSData) do
				local property = HitData:call(playerHitAttackRSData[propertyNum].property)
				if property then
					if (property >= (1 << 31)) then --unsign 32 to sign 32
						property = property - (1 << 32)
					end
					if playerHitAttackRSData[propertyNum].enum == 1 then
						property = playerHitAttackRSDataEnum[playerHitAttackRSData[propertyNum].cap][property]
					elseif playerHitAttackRSData[propertyNum].enum == 2 then
						local resultStr = ""
						for bit, str in pairs(playerHitAttackRSDataEnum[playerHitAttackRSData[propertyNum].cap]) do
							if (bit & property) == bit then
								resultStr = resultStr..str.." "
							end
						end
						property = resultStr
					end
					printWorkLine(property, workidx, works_x, works_y)
				end
			end

			local name = sdk.call_native_func(HitData, hitdata_type, "get_Name")
			if name then
				printWorkLine(name, workidx, works_x, works_y)
			end
		end
	end
end

local UpTimeSecond = 0
local TimeAnchor = 0
local shellTimer = function()
	if TimeAnchor < UpTimeSecond + 0.25 then
		if TimeAnchor < UpTimeSecond then
			TimeAnchor = UpTimeSecond + cfg.shellLifeSec
			return 0 --start timer
		end
		return 1 --end timer, short break of 0.25s
	else
		return 3 --running timer, until cfg.shellLifeSec
	end
end

local displayShellInfo = function(Shells_List, cap)
	if Shells_List then
		Shells_List = Shells_List:get_elements()
		for i, Shell_List in pairs(Shells_List) do -- no continue in Lua, pain, hate goto
			if Shell_List then
				Shell_List = Shell_List:get_field("mItems")
				if Shell_List then
					Shell_List = Shell_List:get_elements()
					for j, Shell in pairs(Shell_List) do
						if Shell then

							if Shell:get_field("_lifeTimer") then
								if shellTimer() == 3 and cfg.isShellManuallySetLife then
									Shell:set_field("_lifeTimer", 0.125)
								end
								printGeneralLine(cap.."Shell["..tostring(i-1).."]["..tostring(j-1).."]_lifeTimer", Shell:get_field("_lifeTimer"))
							end

							if Shell:get_field("_Timer") then
								if Shell:get_field("_Timer") < 2 then
									if shellTimer() == 3 and cfg.isShellManuallySetLife then
										Shell:set_field("_Timer", 5)
									end
								end
								printGeneralLine(cap.."Shell["..tostring(i-1).."]["..tostring(j-1).."]_Timer", Shell:get_field("_Timer"))
							end
							
							if Shell:get_field("_ElapsedFrame") then
								if Shell:get_field("_ElapsedFrame") < 2 then
									if shellTimer() == 3 and cfg.isShellManuallySetLife then
										Shell:set_field("_ElapsedFrame", 5)
									end
								end
								printGeneralLine(cap.."Shell["..tostring(i-1).."]["..tostring(j-1).."]_ElapsedFrame", Shell:get_field("_ElapsedFrame"))
							end
							
							--local ShellCharacterController = shell:call("getCharacterController") --no chara ctrler
							local shellPos = Shell:call("get_Pos")
							if shellPos then
								draw.world_text(cap.."Shell["..tostring(i-1).."]["..tostring(j-1).."]", shellPos, 0xFFFFFFFF)
							end
							local shellRSCController = Shell:call("getRSCController")
							if shellRSCController then
								local shellAttackWorks = shellRSCController:call("get_AttackWorks")
								if shellAttackWorks then
									shellAttackWorks = shellAttackWorks:get_elements()
									showShellWorks(cap, shellAttackWorks, cfg.shell_works_x, cfg.shell_works_y)
								end
							end
						end
					end
				end
			end
		end
	end
end

local swValue = 0
local swBaseUptimeSec = 0
local swState = false
local DeltaSec = 0
local swStart = function()
	swBaseUptimeSec = UpTimeSecond
	swValue = 0
	swState = true
end

local swCurrent = function()
	if swState == true then
		swValue = (UpTimeSecond - swBaseUptimeSec) * 60
		--swValue = (swValue + (DeltaSec*60))
	else
		swValue = 0
	end
	return swValue
end

local swEnd = function()
	swValue = 0
	swBaseUptimeSec = 0
	swState = false
end


local damageObject = {}
damageObject.total_damage = 0
damageObject.physical_damage = 0
damageObject.elemental_damage = 0
damageObject.ailment_damage = 0
damageObject.tempDispVal_1 = 0
damageObject.tempDispVal_2 = 0
damageObject.tempDispVal_3 = 0
damageObject.tempDispVal_List = 0

damageObject.HitPosOffset = 0
damageObject.HitPos = 0

local shapePosStock = {}
damageObject.collideCenterPos = 0
damageObject.collideShapeNum = 0

local HitKabutowariLastHitPos = nil
local shellWorkResetTimeAnchor = 0
local drawSetting = false

local get_info_main = function()
	local sceneman = sdk.get_native_singleton("via.SceneManager")
	if not sceneman then return end
	
	local sceneview = sdk.call_native_func(sceneman, sdk.find_type_definition("via.SceneManager"), "get_MainView")
	if not sceneview then return end
	
	local size = sceneview:call("get_Size")
	if not size then return end
	
	local screen_w_t = size:get_field("w")
	if not screen_w_t then
		return
	else
		screen_w = screen_w_t
	end
	
	local screen_h_t = size:get_field("h")
	if not screen_h_t then
		return
	else
		screen_h = screen_h_t
	end


	local PlayMan = sdk.get_managed_singleton("snow.player.PlayerManager")
	if not PlayMan then return end
	-- local MasterPlayer = PlayMan:call("findMasterPlayer")
	-- if not MasterPlayer then return end

	local player = PlayMan:call("getMasterPlayerID")
	if not player or player > 4 then return end
	
	local MasterPlayer = PlayMan:get_field("PlayerList"):call("get_Item", player)
	if not MasterPlayer then return end
	if not MasterPlayer:get_type_definition():is_a("snow.player.PlayerQuestBase") then return end

	local IsFieldMainOutZone = MasterPlayer:call("get_IsFieldMainOutZone")
	local IsFieldMainZone = MasterPlayer:call("get_IsFieldMainZone")
	if IsFieldMainOutZone or IsFieldMainZone then

		local PlayerData = MasterPlayer:call("get_PlayerData")
		if not PlayerData then return end
		local PlayerMotionCtrl = MasterPlayer:get_field("_RefPlayerMotionCtrl")
		if not PlayerMotionCtrl then return end

		local CharacterController = MasterPlayer:call("getCharacterController")
		if not CharacterController then return end

		local app = sdk.get_native_singleton("via.Application")
		if not app then return end

		local AppMan = sdk.get_managed_singleton("snow.AppManager")
		if not AppMan then return end
		local DmgMan = sdk.get_managed_singleton("snow.DamageManager")
		if not DmgMan then return end

		local DamageAction = MasterPlayer:call("get_DamageAction")
		local DamageReflex = MasterPlayer:call("get_DamageReflex")
		local HitInfo = MasterPlayer:get_field("_HitInfo")
		local DmgInfo = HitInfo:get_field("_DmgInfo")
		local RefPlayerInput = MasterPlayer:call("get_RefPlayerInput")
		local mNow = RefPlayerInput:call("get_mNow")
		--[[
		local scene_manager = sdk.get_native_singleton("via.SceneManager")
		if not scene_manager then return end
		local scene_manager_type = sdk.find_type_definition("via.SceneManager")
		local scene = sdk.call_native_func(scene_manager, scene_manager_type, "get_CurrentScene")
		if not scene then return end
		local scene_type = sdk.find_type_definition("via.Scene")]]

		--show 3d pos you
		local playerPos = sdk.call_native_func(CharacterController, CharacterController_type, "get_Position")
		if playerPos then
			draw.world_text("MasterPlayer", playerPos, 0xFFFFFFFF)
		end

		general_line = 0

		draw.filled_rect(cfg.general_x, cfg.general_y, 
			cfg.general_width + cfg.general_cap_width + cfg.rec_margin * 2, 
			total_line * cfg.line_space + cfg.rec_margin * 2, 
			0x44000000)
		
		for fieldNum in pairs(playerStats) do
			local field = PlayerData:get_field(playerStats[fieldNum].field)
			if field then
				printGeneralLine(playerStats[fieldNum].cap, field)
			end
		end

		total_line = general_line

		-- damage cancel means wire escape after blow out by enemy

		--local vitalContext = PlayerData:call("set__vital", 150)
		--if vitalContext then printGeneralLine("_vitalContext", vitalContext) end

		-- stun accumenlator, put on player stats
		--local StunAccumulator = MasterPlayer:get_field("_StunAccumulator") 
		--printGeneralLine("_StunAccumulator", field)
		--local field = StunAccumulator:get_field("<Value>k__BackingField") -- 100 to trigger stun
		--printGeneralLine("Value", field)
		--local field = StunAccumulator:get_field("<SubtractValue>k__BackingField") -- = 1, by every SubtractInterval (so, subtract 30/sec)
		--printGeneralLine("SubtractValue", field)
		--local field = StunAccumulator:get_field("<SubtractInterval>k__BackingField") -- = 2, by every timer end
		--printGeneralLine("SubtractInterval@60fps", field)
		--local field = StunAccumulator:get_field("_SubtractIntervalTimer") -- start from SubtractInterval
		--printGeneralLine("_SubtractIntervalTimer@60fps", field)

		--local field = MasterPlayer:get_field("_StunAccumulatorReduceStopTimer") -- 300frame(5s) to prevent stun value drop
		--printGeneralLine("_StunAccumulatorReduceStopTimer@60fps", field)
		--local field = MasterPlayer:get_field("_StunDurationTimer")
		--printGeneralLine("_StunDurationTimer@60fps", field)


		--[[ --fixed value
		local field = MasterPlayer:call("get_ContinueFrame")
		local field = MasterPlayer:call("get_MotionAddUpperID")
		local field = MasterPlayer:call("get_MotionAddUpperMaskID")
		local field = MasterPlayer:call("get_MotionAddUpperBank")
		local field = MasterPlayer:call("getMotSpeed")
		]]

		local field = DamageAction:call("get_CurrentAction")
		field = GlobleEnum["ActionPattern"][field]
		printGeneralLine("CurDmg(receive)Action", field)

		local field = DamageReflex:call("get_IsSuccess")
		printGeneralLine("DamageReflex Success", field)

		--local ActiveDamageReflexType = HitInfo:get_field("_ActiveDamageReflexType") --change only when active, similar to get_CheckType
		--printGeneralLine("_ActiveDamageReflexType", ActiveDamageReflexType)
		local field = DamageReflex:call("get_CheckType")
		field = GlobleEnum["CheckType"][field]
		printGeneralLine("DmgReflex CheckType", field)
		
		local ActiveDamageReflexHitLook = HitInfo:get_field("_ActiveDamageReflexHitLook")
		--printGeneralLine("_ActiveDamageReflexHitLook", ActiveDamageReflexHitLook)
		if ActiveDamageReflexHitLook then ActiveDamageReflexHitLook = " (Active)" else ActiveDamageReflexHitLook = "" end
		local field = DamageReflex:call("isCheckingNoHitLook")
		printGeneralLine("DRCheckingNoHitLook", tostring(field))
		local field = DamageReflex:call("isCheckingHitLook")
		printGeneralLine("DRCheckingHitLook", tostring(field)..ActiveDamageReflexHitLook)
		
		-- local field = DamageReflex:call("isChecking") --seems const
		-- printGeneralLine("DRChecking", field)
		local field = DamageReflex:get_field("_IsChecking")
		if field then
			printGeneralLine_color("DRChecking", field, 0xFF00FF00)
		else
			printGeneralLine("DRChecking", field)
		end
		local field = DamageReflex:call("isHitLook") --same as isCheckingHitLook
		printGeneralLine("DRHitLook", field)		
		local field = MasterPlayer:call("getDamageCancelEscapeStateName")
		printGeneralLine("DmgCancelEscapeState", field)
		local field = MasterPlayer:call("getDamageCancelGuardStateName")
		printGeneralLine("DmgCancelGuardState", field)

		local field = PlayerMotionCtrl:call("get_IsGuardActionDuration")
		printGeneralLine("is GuardAction", field)

		local field = HitInfo:get_field("_GuardReaction")
		field = GlobleEnum["GuardReaction"][field]
		printGeneralLine("GuardReaction", field)

		local field = MasterPlayer:call("getGuardAngleRange")
		printGeneralLine("GuardAngleRange(deg)", math.floor((field/math.pi)*360).."°")

		--local field = HitInfo:get_field("_IsGuardSkillGuardableAttack")
		--printGeneralLine("isGuardUpActive", field)

		local field = HitInfo:get_field("_DamageReaction")
		field = GlobleEnum["DamageReaction"][field]
		printGeneralLine("DamageReaction", field)

		--local field = MasterPlayer:call("getHitResult") -- can not reflect second hit work's response
		--printGeneralLine("HitResult", field)

		local field = MasterPlayer:call("getActionNoAttackTag")
		field = GlobleEnum["ActionNoAttackTag"][field]
		printGeneralLine("ActionNoAttackTag", field)
		--local field = MasterPlayer:call("isBatto") --use batto timer is enough
		--printGeneralLine("isBatto", field)

		local field = MasterPlayer:get_field("_BattoStartTimer")
		printGeneralLine("preWepDrawTimer@60fps", field)

		local field = MasterPlayer:get_field("_BattoTimer")
		printGeneralLine("CriDrawTimer@60fps", field)

		--[[protected virtual System.Boolean isIgnoreMotionSet_Guard_S (    );
		protected virtual System.Boolean isIgnoreMotionSet_Guard_M (    );
		protected virtual System.Boolean isIgnoreMotionSet_Ear_S (    );
		protected virtual System.Boolean isIgnoreMotionSet_Ear_L (    );
		protected virtual System.Boolean isIgnoreMotionSet_Ear_LL (    );
		protected virtual System.Boolean isSetSuperArmorOthers (    );]]

		local isInvalidKan = MasterPlayer:call("isInvalidKan")
		local isForceKan = MasterPlayer:call("isForceKan")
		printGeneralLine("isMindEye / ForceBounce", tostring(isInvalidKan).." / "..tostring(isForceKan))

		local field = MasterPlayer:call("isForceDisableHitStop")
		printGeneralLine("ForceDisableHitStop", field)

		local field = MasterPlayer:call("getReduseSharpnessRate")
		printGeneralLine("ReduseSharpnessRate", field) -- why always 1

		--local field = HitInfo:get_field("_DamageFlag")
		--printGeneralLine("_DamageFlag", field)

		local field = DmgInfo:get_field("damage_type")
		field = GlobleEnum["damage_type"][field]
		local DamageTypeValue = DmgInfo:get_field("DamageTypeValue")
		--printGeneralLine("DamageTypeValue", field)
		if DamageTypeValue == 0 then DamageTypeValue = "" else DamageTypeValue = " ("..DamageTypeValue..")" end
		printGeneralLine("damage_type (value)", field..DamageTypeValue)
		--[expose]public  snow.hit.DamageType damage_type;
		local field = DmgInfo:get_field("damage_power")
		printGeneralLine("damage_power", field)
		--local field = DmgInfo:get_field("damage_vec")
		--printGeneralLine("damage_vec",  field)
		--local field = DmgInfo:get_field("damage_stock_f")
		--printGeneralLine("damage_stock_f", field)
		--local field = DmgInfo:get_field("_HealStock")
		--printGeneralLine("_HealStock", field)
		--local field = DmgInfo:get_field("_DebuffSec")
		--printGeneralLine("_DebuffSec", field)
		--local field = DmgInfo:get_field("_ResistElementDebuffFlag")
		--printGeneralLine("_ResistElementDebuffFlag", field)

		--local field = HitInfo:get_field("isFront")
		--printGeneralLine("isFront", field)
		--local field = HitInfo:get_field("_AngleY")
		--printGeneralLine("_AngleY", field)
		--local field = HitInfo:get_field("_NoStaminaGuard")
		--printGeneralLine("_NoStaminaGuard", field)

		--local field = HitInfo:get_field("_AttackEmId")
		--printGeneralLine("_AttackEmId", field)
		--local field = HitInfo:get_field("_IsFriendlyFire")
		--printGeneralLine("_IsFriendlyFire", field)
		--local field = HitInfo:get_field("_IsTeamHit")
		--printGeneralLine("_IsTeamHit", field)
		--local field = HitInfo:get_field("_IsMarionetteAttack")
		--printGeneralLine("_IsMarionetteAttack", field)
		--local field = HitInfo:get_field("_IsZeroDamageAttack")
		--printGeneralLine("_IsZeroDamageAttack", field)

		local CurrentHitID = DmgMan:call("get_CurrentHitID")
		printGeneralLine("CurrentHitID", CurrentHitID)

		local field = PlayerMotionCtrl:call("get_OldMotionID")
		printGeneralLine("OldMotionID", field)

		local field = PlayerMotionCtrl:call("get_OldBankID")
		printGeneralLine("OldBankID", field)

		local field = RefPlayerInput:get_field("_ReserveCommands")[0]:get_field("_Command")
		printGeneralLine("ReserveCommand", GlobleEnum["Command"][field])
		local field = RefPlayerInput:get_field("_ReserveCommands")[0]:get_field("_TransitionId")
		printGeneralLine("ReserveTransitionId", field)

		local field = MasterPlayer:call("get_PosAdd"):call("get_TimeSpeed")
		printGeneralLine("TimeSpeed", field)

		DeltaSec = MasterPlayer:get_field("<DeltaSec>k__BackingField") -- same as ElapsedSecond
		printGeneralLine("DeltaSec(FrameInterval)", DeltaSec)

		local DeltaTime = sdk.call_native_func(app, app_type, "get_DeltaTime")
		printGeneralLine("DeltaTime(FPS:baseFPS)", DeltaTime) -- (framerate / 60fps) | (frame passed in every base frame@60fps)
		
		--local field = sdk.call_native_func(app, app_type, "get_ElapsedSecond") -- same as delta sec
		--printGeneralLine("ElapsedSecond", field)

		--local field = sdk.call_native_func(app, app_type, "get_FrameTimeMillisecond") -- same as delta sec / 1000
		--printGeneralLine("FrameTimeMillisecond", field)

		--local field = sdk.call_native_func(app, app_type, "get_CurrentElapsedTimeMillisecond") -- frame delay? (set vSync and higher than 60 fps let it fix to ~16)
		--printGeneralLine("CurrentElapsedTimeMillisecond", field)

		UpTimeSecond = sdk.call_native_func(app, app_type, "get_UpTimeSecond")
		printGeneralLine("UpTimeSecond", UpTimeSecond)
		
		local FrameCount = sdk.call_native_func(app, app_type, "get_FrameCount")
		printGeneralLine("FrameCount", FrameCount)

		local field = AppMan:call("get_AverageFps")
		printGeneralLine("AverageFps", field)

		--local field = AppMan:call("get_AverageRps") --average render per second? (set vSync and higher than 60 fps let it fix to ~60rps)
		--printGeneralLine("AverageRps", field)

		local field = MasterPlayer:call("getFsmJumpTimer")
		printGeneralLine("FsmJumpTimer@60fps", field)
		
		local field = MasterPlayer:call("getFsmActionTimer")
		printGeneralLine("FsmActionTimer", field)

				local field = MasterPlayer:call("checkMuteki")
		printGeneralLine("is Muteki", field)
		local field = MasterPlayer:get_field("_MutekiTime")
		if field > 0 then
			printGeneralLine_color("Iframe@60fps", field, 0xFF00FF00)
		else
			printGeneralLine("Iframe@60fps", field)
		end

		local field = MasterPlayer:call("checkSuperArmor")
		printGeneralLine("is SuperArmor", field)
		local field = MasterPlayer:get_field("_SuperArmorTimer")
		if field > 0 then
			printGeneralLine_color("SuperArmorTimer@60fps", field, 0xFF00FF00)
		else
			printGeneralLine("SuperArmorTimer@60fps", field)
		end

		-- not work
		local field = MasterPlayer:call("checkHyperArmor")
		printGeneralLine("is HyperArmor", field)
		-- local Situation = sdk.create_instance("snow.player.Situation")
		-- Situation:set_field("value__", 0x60A1358B)
		-- local field = MasterPlayer:call("isSituationTag(snow.player.Situation)",Situation)
		-- printGeneralLine("is isSituationTag", field)

		local field = MasterPlayer:get_field("_HyperArmorTimer")
		if field > 0 then
			printGeneralLine_color("HyperArmorTimer@60fps", field, 0xFF00FF00)
		else
			printGeneralLine("HyperArmorTimer@60fps", field)
		end


		local field = MasterPlayer:get_field("_DamageReduceTimer")
		printGeneralLine("DamageReduceTimer@60fps", field)
		
		local field = MasterPlayer:get_field("_DamageReduceRate")
		printGeneralLine("DamageReduceRate@60fps", field)
		
		local field = MasterPlayer:get_field("mHitStopTimer")
		printGeneralLine("HitStopTimer@60fps", field)
		
		local field = MasterPlayer:get_field("_HitSlowTimer")
		printGeneralLine("HitSlowTimer@60fps", field)
		
		--local field = MasterPlayer:get_field("_IsDamage")
		--local field = MasterPlayer:get_field("_IsCounterAttack")

		local field = MasterPlayer:get_field("_EquipSkill_036_Timer")
		printGeneralLine("OffensiveGuardTimer@60fps", field)

		--local field = MasterPlayer:get_field("_IsGuardPrevFrame") -- for _EquipSkill_036_ only
		--printGeneralLine("_IsGuardPrevFrame", field)

		--local field = MasterPlayer:get_field("_WpEndCommandNgTimer")
		--printGeneralLine("_WpEndCommandNgTimer@60fps", field)

		--local field = MasterPlayer:get_field("_HitSlowSpeed") look at time speed is fine
		--printGeneralLine("_HitSlowSpeed@60fps", field)

		
		--[[ --what are these do????
		local field = MasterPlayer:get_field("_RegeneOn")
		printGeneralLine("_RegeneOn", field)
		
		local field = MasterPlayer:get_field("_RegeneBowTimer")
		printGeneralLine("_RegeneBowTimer@60fps", field)
		
		local field = MasterPlayer:get_field("_RegeneBowIntervalTimer")
		printGeneralLine("_RegeneBowIntervalTimer@60fps", field)
		
		local field = MasterPlayer:get_field("_RegeneBowIntervalTime")
		printGeneralLine("_RegeneBowIntervalTime@60fps", field)
		
		local field = MasterPlayer:get_field("_RegeneTimer")
		printGeneralLine("_RegeneTimer@60fps", field)]]
		
		
		local CmdTimer = RefPlayerInput:get_field("_CmdTimer")
		--printGeneralLine("CmdWaitTimer(PAD)@60fps", field)
		local WireTypeChangeDelayTimer = RefPlayerInput:get_field("_WireTypeChangeDelayTimer")
		--printGeneralLine("_WTCmdTimer(PAD)@60fps", field)
		printGeneralLine("CmdWaitTimer(pad)@60fps", CmdTimer .. " | " .. WireTypeChangeDelayTimer)

		local mKeyOn = mNow:get_field("mKeyOn")
		local Datas = mKeyOn:get_field("_Flag")
		local KeyOn_1 = Datas[0]:get_field("mValue")
		local KeyOn_2 = Datas[1]:get_field("mValue")
		printGeneralLine("mKeyOn",KeyOn_1 .. " + " .. KeyOn_2)
		local mKeyTrg = mNow:get_field("mKeyTrg")
		local Datas = mKeyTrg:get_field("_Flag")
		local KeyTrg_1 = Datas[0]:get_field("mValue")
		local KeyTrg_2 = Datas[1]:get_field("mValue")
		printGeneralLine("mKeyTrg",KeyTrg_1 .. " + " .. KeyTrg_2)
		local mKeyRel = mNow:get_field("mKeyRel")
		local Datas = mKeyRel:get_field("_Flag")
		local KeyRel_1 = Datas[0]:get_field("mValue")
		local KeyRel_2 = Datas[1]:get_field("mValue")
		printGeneralLine("mKeyRel",KeyRel_1 .. " + " .. KeyRel_2)
		local mKeyDelay = mNow:get_field("mKeyDelay")
		local Datas = mKeyDelay:get_field("_Flag")
		local KeyDelay_1 = Datas[0]:get_field("mValue")
		local KeyDelay_2 = Datas[1]:get_field("mValue")
		printGeneralLine("mKeyDelay", KeyDelay_1 .. " + " .. KeyDelay_2)

		if (KeyTrg_1 > 0 or KeyTrg_2 > 0) and (KeyTrg_1 ~= 16384) then
			swStart()
		end
		if KeyDelay_1 > 0 or KeyDelay_2 > 0 then
			swEnd()
		end
		printGeneralLine("mKeydelayCount", swCurrent())

		local mPadOn = mNow:call("get_mPadOn")
		local mPadTrg = mNow:call("get_mPadTrg")
		local mPadRel = mNow:call("get_PadRel")

		local WTCmdTimeRno = RefPlayerInput:get_field("_WireTypeChangeCmdTimeRno")
		--printGeneralLine("_WTCmdTimeRno", field)
		local field = RefPlayerInput:get_field("_CmdTimeRno")
		--printGeneralLine("_CmdTimeRno", field)
		printGeneralLine("_CmdTimeRno", field .. " + " .. WTCmdTimeRno)
		printGeneralLine("mPadOn", mPadOn)
		local WTOldButton = RefPlayerInput:get_field("_WireTypeChangeOldButton")
		--printGeneralLine("_WTOldButton", field)
		local field = RefPlayerInput:get_field("_OldButton")
		--printGeneralLine("_OldButton", field .. " + " .. mPadTrg)
		printGeneralLine("_OldButton", field .. " + " .. WTOldButton .. " + " .. mPadTrg)
		printGeneralLine("get_PadRel", mPadRel)
		local WTDelayButton = RefPlayerInput:get_field("_WireTypeChangeDelayButton")
		--printGeneralLine("_WTDelayButton", field)
		local field = RefPlayerInput:get_field("_DelayButton")
		--printGeneralLine("_DelayButton", field)
		printGeneralLine("_DelayButton", field .. " + " .. WTDelayButton)
		local field = RefPlayerInput:get_field("_ReserveCommandsNum")
		printGeneralLine("_ReserveCommandsNum", field)

		--getCriticalElementDamage --? what are these
		--getCriticalMinusPain
		--getExprodeDamageValue

		if cfg.printAtkWorks then
			-- print hit atkworks
			local RSCController = MasterPlayer:call("getRSCController")
			if not RSCController then return end
			local AttackWorks = RSCController:call("get_AttackWorks")
			if not AttackWorks then return end
			AttackWorks = AttackWorks:get_elements()
			showHitWorks(AttackWorks, cfg.works_x, cfg.works_y)

			--print hit response
			works_line = works_line - #playerHitAttackRSData - 3 -- back to just before hit data
			printWorkLine("HitResponse", 0, cfg.works_x, cfg.works_y)
			works_line = works_line - 1
			local RequestHitWork = MasterPlayer:get_field("_RequestHitWork")
			if RequestHitWork then RequestHitWork = RequestHitWork:get_elements() end
			for i, rhw in pairs(RequestHitWork) do
				local field = rhw:get_field("_HitResponse")
				if field then
					field = GlobleEnum["HitResponse"][field]
					printWorkLine(field, i, cfg.works_x, cfg.works_y)
					works_line = works_line - 1
				end
			end
			works_line = works_line + #playerHitAttackRSData + 4 -- go to right position
		end
		--print shell atkworks rec
		
		if cfg.printShellWork then
			showShellWorksBase(cfg.shell_works_x, cfg.shell_works_y)

			local WeaponType = MasterPlayer:get_field("_playerWeaponType")
			if WeaponType == playerWeaponType.LongSword then
				local field = MasterPlayer:call("get_LongSwordGaugeLvTimer")
				printGeneralLine("LSGaugeLvTimer", field)

				local field = MasterPlayer:get_field("_LongSwordGaugeTimer")
				printGeneralLine("LSGaugeTimer@60fps", field)

				local field = MasterPlayer:call("get_LongSwordGauge")
				printGeneralLine("LSGauge(subByTimer)", field)

				local field = MasterPlayer:call("get_LongSwordGaugePowerUpTime")
				printGeneralLine("LSGaugePowerUpTime", field)

				local CreateAfterKabutowariShellTimer = MasterPlayer:get_field("_CreateAfterKabutowariShellTimer")
				local CreateAfterKabutowariHitFrame = MasterPlayer:get_field("_CreateAfterKabutowariHitFrame")
				printGeneralLine("SHBshellCreateTimer@60fps", CreateAfterKabutowariShellTimer .. " / " .. CreateAfterKabutowariHitFrame)

				HitKabutowariLastHitPos = MasterPlayer:get_field("HitKabutowariLastHitPos")
				if HitKabutowariLastHitPos then
					--draw.world_text(CurrentHitID, HitKabutowariLastHitPos, 0x8000FF00)
				end

				local LSShellMan = sdk.get_managed_singleton("snow.shell.LongSwordShellManager")
				if not LSShellMan then return end
				local LSShell000sList = LSShellMan:get_field("_LongSwordShell000s")
				displayShellInfo(LSShell000sList, "LS000")
			elseif WeaponType == playerWeaponType.ChargeAxe then
				local CAShellMan = sdk.get_managed_singleton("snow.shell.ChargeAxeShellManager")
				-- snow.shell.ChargeAxeShellManager.ChargeAxeShell000_ID
				-- snow.shell.ChargeAxeShellManager.ShellIndex
				if not CAShellMan then return end
				local CAShell000sList = CAShellMan:get_field("_ChargeAxeShell000s")
				displayShellInfo(CAShell000sList, "CA000")
				local CAShell001sList = CAShellMan:get_field("_ChargeAxeShell001s")
				displayShellInfo(CAShell001sList, "CA001")
				local CAShell002sList = CAShellMan:get_field("_ChargeAxeShell002s")
				displayShellInfo(CAShell002sList, "CA002")
				local CAShell003sList = CAShellMan:get_field("_ChargeAxeShell003s")
				displayShellInfo(CAShell003sList, "CA003")
				local CAShell004sList = CAShellMan:get_field("_ChargeAxeShell004s")
				displayShellInfo(CAShell004sList, "CA004")
				local CAShell004sList = CAShellMan:get_field("_ChargeAxeShell005s")
				displayShellInfo(CAShell004sList, "CA005")
				local CAShell004sList = CAShellMan:get_field("_ChargeAxeShell006s")
				displayShellInfo(CAShell004sList, "CA006")
				local CAShell004sList = CAShellMan:get_field("_ChargeAxeShell007s")
				displayShellInfo(CAShell004sList, "CA007")

			elseif WeaponType == playerWeaponType.Bow then
				local BowShellMan = sdk.get_managed_singleton("snow.shell.BowShellManager")
				if not BowShellMan then return end
				local BowShell000sList = BowShellMan:get_field("_BowShell000s")
				displayShellInfo(BowShell000sList, "Bow000")
				local BowShell010sList = BowShellMan:get_field("_BowShell010s")
				displayShellInfo(BowShell010sList, "Bow0010")
				local BowShell011sList = BowShellMan:get_field("_BowShell011s")
				displayShellInfo(BowShell011sList, "Bow011")
			end

			--reset shell work order if no shell instance after 0.7s
			if hasShellInstance then
				shellWorkResetTimeAnchor = UpTimeSecond + 0.7
			else
				if shellWorkResetTimeAnchor < UpTimeSecond then
					workidx = 0
				end
			end
			hasShellInstance = false

		end
		--local field = MasterPlayer:call("get_RefPlayerAction")
		--local field = MasterPlayer:call("get_ActionRandomValue")
		--local field = MasterPlayer:call("getFsmActionTimer")
		--local field = MasterPlayer:call("isKanActionSkill")
		--

		--local scene = sdk.call_native_func(scene, scene_type, "get_FrameCount")
		--printGeneralLine("FrameCount", field)

		--[[
		
		public via.motion.Motion getMotion (
		);

		[il][ret][has_this][hid_by_sig]
		public via.motion.MotionFsm2 getMotionFsm2 (
		);

		[il][ret][has_this][hid_by_sig]
		public via.physics.CharacterController getCharacterController ( CharacterController
		);

		[il][ret][has_this][hid_by_sig]
		public snow.RSCController getRSCController ( RSCController
		);get_AttackWorks
		
		[il][ret][has_this][hid_by_sig]
		public snow.DamageReceiver getDamageReceiver (
		);]]
	end

	--if false then
	if IsFieldMainOutZone or IsFieldMainZone then
		printGeneralLine("total_damage", damageObject.total_damage)
		printGeneralLine("physical_damage", damageObject.physical_damage)
		printGeneralLine("elemental_damage", damageObject.elemental_damage)
		printGeneralLine("ailment_damage", damageObject.ailment_damage)
	
		printGeneralLine("tempDispVal_1", damageObject.tempDispVal_1)
		printGeneralLine("tempDispVal_2", damageObject.tempDispVal_2)
		printGeneralLine("tempDispVal_3", damageObject.tempDispVal_3)
		printGeneralLine("tempDispVal_List", damageObject.tempDispVal_List)
	
		if damageObject.HitPosOffset then
			draw.world_text("●", damageObject.HitPosOffset, 0xAACC0000) --blue
		end
		if damageObject.HitPos then
			draw.world_text("●", damageObject.HitPos, 0xAA00CC00) --green
		end
		
		for shape_pos_i, shape_pos in pairs(shapePosStock) do
			draw.world_text(shape_pos_i, shape_pos.dmgShapeCenter, 0x8000FFFF)
			--draw.world_text("██", shape_pos.collideCenterPos, 0xFFFFFFFF)
			draw.world_text(shape_pos_i, shape_pos.collideCenterPos, 0x800000FF) -- red (collide center)
			if shape_pos.atkColShapeType == 3 or shape_pos.atkColShapeType == 4 then --if capsule
				draw.world_text(shape_pos_i, shape_pos.atkShapeCenter, 0x80FF00FF)
				draw.world_text("●", shape_pos.atkShapeCsStart, 0xAAFFFFFF)
				draw.world_text("●", shape_pos.atkShapeCsEnd, 0xAAFFFFFF)
				draw.world_text(shape_pos_i, shape_pos.atkShapeCsStart, 0x80FF00FF)
				draw.world_text(shape_pos_i, shape_pos.atkShapeCsEnd, 0x80FF00FF)
				local atkShapeCsStartVec2f = draw.world_to_screen(shape_pos.atkShapeCsStart)
				local atkShapeCsEndVec2f = draw.world_to_screen(shape_pos.atkShapeCsEnd)
				if atkShapeCsStartVec2f and atkShapeCsEndVec2f then 
					draw.line(atkShapeCsStartVec2f.x, atkShapeCsStartVec2f.y,	atkShapeCsEndVec2f.x, atkShapeCsEndVec2f.y, 0xAAFFFFFF) -- pair
					
    				draw.capsule(shape_pos.atkShapeCsStart, shape_pos.atkShapeCsEnd, shape_pos.atkShapeCsRadi, cfg.shapeColor, true)
				end
				if shape_pos.atkColShapeType == 4 then
					draw.world_text("█", shape_pos.atkPreShapeCsStart, 0xAAFFFFFF)
					draw.world_text("█", shape_pos.atkPreShapeCsEnd, 0xAAFFFFFF)
					draw.world_text(shape_pos_i, shape_pos.atkPreShapeCsStart, 0x80FF00FF)
					draw.world_text(shape_pos_i, shape_pos.atkPreShapeCsEnd, 0x80FF00FF)
				
					local atkPreShapeCsStartVec2f = draw.world_to_screen(shape_pos.atkPreShapeCsStart)
					local atkPreShapeCsEndVec2f = draw.world_to_screen(shape_pos.atkPreShapeCsEnd)
					if atkPreShapeCsStartVec2f and atkPreShapeCsEndVec2f and atkShapeCsStartVec2f and atkShapeCsEndVec2f then 
						draw.line(atkPreShapeCsStartVec2f.x, atkPreShapeCsStartVec2f.y,	atkPreShapeCsEndVec2f.x, atkPreShapeCsEndVec2f.y, 0xAAFFFFFF) -- p pair
		
						draw.line(atkPreShapeCsStartVec2f.x, atkPreShapeCsStartVec2f.y,	atkShapeCsStartVec2f.x, atkShapeCsStartVec2f.y, 0xAAFFFFFF) -- p start to start
						draw.line(atkShapeCsEndVec2f.x, atkShapeCsEndVec2f.y,	atkPreShapeCsEndVec2f.x, atkPreShapeCsEndVec2f.y, 0xAAFFFFFF) -- p end to end

						local currMid_x = (atkShapeCsStartVec2f.x + atkShapeCsEndVec2f.x)/2
						local currMid_y = (atkShapeCsStartVec2f.y + atkShapeCsEndVec2f.y)/2
		
						local prevMid_x = (atkPreShapeCsStartVec2f.x + atkPreShapeCsEndVec2f.x)/2
						local prevMid_y = (atkPreShapeCsStartVec2f.y + atkPreShapeCsEndVec2f.y)/2
						
						local StartMid_x = (atkShapeCsStartVec2f.x + atkPreShapeCsStartVec2f.x)/2
						local StartMid_y = (atkShapeCsStartVec2f.y + atkPreShapeCsStartVec2f.y)/2
		
						local EndMid_x = (atkShapeCsEndVec2f.x + atkPreShapeCsEndVec2f.x)/2
						local EndMid_y = (atkShapeCsEndVec2f.y + atkPreShapeCsEndVec2f.y)/2
						
						draw.line(currMid_x, currMid_y,	prevMid_x, prevMid_y, 0xAAFFFFFF) -- 
						draw.line(StartMid_x, StartMid_y,	EndMid_x, EndMid_y, 0xAAFFFFFF) -- 
						
						draw.capsule(shape_pos.atkShapeCsStart, shape_pos.atkShapeCsEnd, shape_pos.atkShapeCsRadi, cfg.shapeColor, true)
						draw.capsule(shape_pos.atkPreShapeCsStart, shape_pos.atkPreShapeCsEnd, shape_pos.atkPreShapeCsRadi, cfg.shapeColor, true)
					end
				end
			elseif shape_pos.atkColShapeType == 1 or shape_pos.atkColShapeType == 2 then --if sphere
				draw.world_text(shape_pos_i, shape_pos.atkShapeCenter, 0x80FF00FF)
				draw.world_text("●", shape_pos.atkShapeCsStart, 0xAAFFFFFF)
				draw.world_text(shape_pos_i, shape_pos.atkShapeCsStart, 0x80FF00FF)
				draw.sphere(shape_pos.atkShapeCsStart, shape_pos.atkShapeCsRadi, cfg.shapeColor, true)
				if shape_pos.atkColShapeType == 2 then
					draw.world_text("█", shape_pos.atkPreShapeCsStart, 0xAAFFFFFF)
					draw.world_text(shape_pos_i, shape_pos.atkPreShapeCsStart, 0x80FF00FF)
					local atkShapeCsStartVec2f = draw.world_to_screen(shape_pos.atkShapeCsStart)
					local atkShapeCsEndVec2f = draw.world_to_screen(shape_pos.atkPreShapeCsStart)
					
					if atkShapeCsStartVec2f and atkShapeCsEndVec2f then 
						draw.line(atkShapeCsStartVec2f.x, atkShapeCsStartVec2f.y,	atkShapeCsEndVec2f.x, atkShapeCsEndVec2f.y, 0xAAFFFFFF) -- pair
						draw.sphere(shape_pos.atkPreShapeCsStart, shape_pos.atkPreShapeCsRadi, cfg.shapeColor, true)
					end
				end
			end
		end
	end

	total_line = general_line
end


re.on_frame(function()
	imgui.push_font(font)
	get_info_main()
	
	if drawSetting then
		if imgui.begin_window("rich info dispay setting", true, 0) then
			imgui.text("---general panel---")
			local saveChanged = false
			changed, value = imgui.slider_int("general_x", cfg.general_x, -screen_w, screen_w)
        	if changed then cfg.general_x = value  
				saveChanged = true end
			changed, value = imgui.slider_int("general_y", cfg.general_y, -screen_h, screen_h)
        	if changed then cfg.general_y = value
				saveChanged = true end
			changed, value = imgui.slider_int("general_cap_width", cfg.general_cap_width, 100, 600)
        	if changed then cfg.general_cap_width = value  
				saveChanged = true end
			changed, value = imgui.slider_int("general_width", cfg.general_width, 100, 600)
        	if changed then cfg.general_width = value  
				saveChanged = true end
			imgui.text("---AttackWorks panel---")
			changed, value = imgui.checkbox("Show AttackWorks panel", cfg.printAtkWorks)
			if changed then cfg.printAtkWorks = value  
				saveChanged = true end
			changed, value = imgui.slider_int("works_x", cfg.works_x, -1920, 1920)
        	if changed then
				cfg.works_x = value
				if cfg.is_link_general then
					cfg.shell_works_x = value
				end
				saveChanged = true
			end
			changed, value = imgui.slider_int("works_y", cfg.works_y, 1, 1080)
        	if changed then
				cfg.works_y = value
				if cfg.is_link_general then
					cfg.shell_works_y = cfg.works_y + (#playerAttackWorks + #playerHitAttackRSData + 4) * cfg.line_space + cfg.rec_margin * 2
				end
				saveChanged = true end
			changed, value = imgui.slider_int("work_cap_width", cfg.work_cap_width, 100, 600)
        	if changed then cfg.work_cap_width = value  
				saveChanged = true end
			changed, value = imgui.slider_int("work_width", cfg.work_width, 100, 600)
        	if changed then cfg.work_width = value  
				saveChanged = true end
			imgui.text("---spacing---")
			changed, value = imgui.slider_int("line_space", cfg.line_space, 1, 200)
        	if changed then cfg.line_space = value  
				saveChanged = true end
			imgui.text("---other---")
			changed, value = imgui.checkbox("is manually set shell life", cfg.isShellManuallySetLife)
			if changed then cfg.isShellManuallySetLife = value  
				saveChanged = true end
			changed, value = imgui.slider_int("shell life sec", cfg.shellLifeSec, 2, 600)
        	if changed then cfg.shellLifeSec = value 
				saveChanged = true end
			if imgui.button("release shell life") then
				TimeAnchor = UpTimeSecond + 0.25
				saveChanged = true
			end
			
			changed, value = imgui.checkbox("Show shell work panel", cfg.printShellWork)
			if changed then cfg.printShellWork = value  
				saveChanged = true end
			changed, value = imgui.slider_int("shell_work_num", cfg.shell_work_num, 5, 20)
        	if changed then cfg.shell_work_num = value  
				saveChanged = true end

			changed, value = imgui.checkbox("is link", cfg.is_link_general)
			if changed then cfg.is_link_general = value
				saveChanged = true end

			changed, value = imgui.slider_int("shell_works_x", cfg.shell_works_x, 1, 1920)
        	if changed then cfg.shell_works_x = value  
				saveChanged = true end
			changed, value = imgui.slider_int("shell_works_y", cfg.shell_works_y, 1, 1080)
        	if changed then cfg.shell_works_y = value
				saveChanged = true end

				
			changed, value = imgui.slider_int("limit shape draw numbers", cfg.limitShapeStock, 1, 500)
			if changed then cfg.limitShapeStock = value
				saveChanged = true end

			if imgui.button("reset shape history") then
				shapePosStock = {}
				damageObject.collideCenterPos = 0
				damageObject.collideShapeNum = 0
			end
			
			imgui.text("---Choose the color of the shape---")
			changed, value = imgui.color_picker("shapeColor", cfg.shapeColor, 0)
        	if changed then cfg.shapeColor = value
				saveChanged = true end

			if saveChanged then json.dump_file("rich_info_display.json", cfg) end
        	--[[if changed then cfg.line_space = value end
			changed, value = imgui.slider_int("font_size", cfg.FONT_SIZE, 1, 120)
        	if changed then
				cfg.FONT_SIZE = value
				imgui.pop_font()
				imgui.load_font(cfg.FONT_NAME, cfg.FONT_SIZE, CHINESE_GLYPH_RANGES) 
				imgui.push_font(font)
			end]]
			imgui.spacing()
			imgui.end_window()
		else
			drawSetting = false
		end
	end

    imgui.pop_font()
end)

local script_name = "rich info display"
re.on_draw_ui(function()
    if string.len(script_name) > 0 then
        imgui.text(script_name)
    end
    imgui.same_line()
    if imgui.button("rich info Setting") then
        drawSetting = true
    end
	
end)

local printTag = function(cap, value)
	draw.text(cap, cfg.general_x + cfg.rec_margin + 300, cfg.general_y + cfg.rec_margin + (general_line - total_line) * cfg.line_space, 0xFFFFFFFF)
	if value then
		draw.text(tostring(value), cfg.general_x + cfg.general_width + cfg.rec_margin + 300, cfg.general_y + (general_line - total_line) * cfg.line_space + cfg.rec_margin, 0xFFFFFFFF)
	end
	general_line = general_line + 1
end
--[[ -- show action tag
sdk.hook(
	sdk.find_type_definition("snow.player.Bow"):get_method("isBowTag"), 
	function(args)
		local Tag = sdk.to_int64(args[3])
		Tag = GlobleEnum["MotTags"][Tag]
		printTag("",Tag)
		return sdk.PreHookResult.CALL_ORIGINAL
	end,
	function(retval)
		--local value = sdk.to_managed_object(retval):get_field("mValue")
		--printTag(tostring(value),"")
		return retval
end)

sdk.hook(
	sdk.find_type_definition("snow.player.PlayerBase"):get_method("isActionStatusTag"), 
	function(args)
		local Tag = sdk.to_int64(args[3])
		Tag = GlobleEnum["MotTags"][Tag]
		if #Tag > 2 then
			printTag(Tag,"")
		end
		return sdk.PreHookResult.CALL_ORIGINAL
	end,
	function(retval)
		--printTag(retval,"")
		return retval
end)]]
--snow.player.fsm.PlayerFsm2MutekiTimer
--snow.player.fsm.PlayerFsm2EscapeMutekiTimer
--snow.player.fsm.PlayerFsm2ActionSuperArmorSetTimer
--snow.player.fsm.PlayerFsm2ActionLongSwordResetIaiTimer
--snow.player.fsm.PlayerFsm2ActionHyperArmorSetTimer
--snow.player.fsm.PlayerFsm2ActionCountTimer
--snow.hit.EnemyCalcDamageInfo.AfterCalcInfo_DamageSide

--[[
sdk.hook(
	sdk.find_type_definition("snow.player.LongSword"):get_method("reserveMotFSMNodeSet"), 
	function(args)
		local Tag = args[2]
		printTag("yo",Tag)
		return sdk.PreHookResult.CALL_ORIGINAL
	end,
	function(retval)
		printTag("yoyo",sdk.to_int64(retval))
		--local value = sdk.to_managed_object(retval):get_field("mValue")
		--printTag(tostring(value),"")
		return retval
end)
]]

local update_hitinfo = function(hitinfo)
	--damageObject.total_damage = sdk.to_managed_object(args[2]):get_type_definition():get_full_name()
	--damageObject.physical_damage = sdk.to_managed_object(args[3]):get_type_definition():get_full_name()
	--damageObject.elemental_damage = sdk.to_managed_object(args[4]):get_type_definition():get_full_name()
	--damageObject.ailment_damage = sdk.to_managed_object(args[6]):get_type_definition():get_full_name()
	--local hit = sdk.to_managed_object(args[4])

	local atkShapeCenter = 0
	local dmgShapeCenter = 0
	local atkColShapeType = 0
	local atkShapeCsStart = 0
	local atkShapeCsEnd = 0
	local atkShapeCsRadi = 0
	local atkPreShapeCsStart = 0
	local atkPreShapeCsEnd = 0
	local atkPreShapeCsRadi = 0
	
	damageObject.collideShapeNum = damageObject.collideShapeNum + 1
	damageObject.collideCenterPos = hitinfo:call("get_Position")
	
	atkShapeCenter = hitinfo:call("get_AttackShapeCenter")
	dmgShapeCenter = hitinfo:call("get_DamageShapeCenter")

	local AttackCollider = hitinfo:call("get_HitDamageShapeInfo"):call("get_AttackCollider") --player wep shape
		--AttackCollider = sdk.to_managed_object(AttackCollider)
		--local name = sdk.call_native_func(HitData, hitdata_type, "get_Name")
		
		local AttackColliderStr = ""
		-- AttackColliderStr = AttackColliderStr .. AttackCollider:get_type_definition():get_full_name() .. " | " -- via.physics.Collider
		-- nil AttackColliderStr = AttackColliderStr .. tostring(AttackCollider:call("get_CollisionFilterResource"):get_type_definition():get_full_name()) .. " | "
		-- nil AttackColliderStr = AttackColliderStr .. tostring(AttackCollider:call("get_CollisionMaterialResource"):get_type_definition():get_full_name()) .. " | "
		-- nil AttackColliderStr = AttackColliderStr .. tostring(sdk.call_native_func(AttackCollider, sdk.find_type_definition("via.physics.CollisionFilterResourceHolder"), "get_CollisionFilterResource")) .. " | "
		-- nil AttackColliderStr = AttackColliderStr .. tostring(sdk.call_native_func(AttackCollider, sdk.find_type_definition("via.physics.CollisionMaterialResourceHolder"), "get_CollisionMaterialResource")) .. " | "
		
		AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_JointNameA") .. " | "
		AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_JointNameB") .. " | "
		AttackColliderStr = AttackColliderStr .. tostring(AttackCollider:call("get_Enabled")) .. " | "
		AttackColliderStr = AttackColliderStr .. tostring(AttackCollider:call("get_DevelopDraw")) .. " | "
		--AttackColliderStr = AttackColliderStr .. AttackCollider:call("getJointNames") .. " | "
		--AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_Shape"):get_type_definition():get_full_name() .. " | " --via continusous capluse shape
		--AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_TransformedShape"):get_type_definition():get_full_name() .. " | " --via continusous capluse shape
		-- nil AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_Shape"):call("get_UserData"):get_type_definition():get_full_name() .. " | "
		-- nil AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_TransformedShape"):call("get_UserData"):get_type_definition():get_full_name() .. " | "
		local TransformedShape = AttackCollider:call("get_TransformedShape")
		atkColShapeType = TransformedShape:call("get_ShapeType")

		if atkColShapeType == 4 then -- is continous capsule
			AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_Shape"):call("get_Capsule"):call("ToString") .. " | " --get radius and pos. data same as in rcol
			--AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_TransformedShape"):call("get_Capsule"):call("ToString") .. " | " -- radius and pos data in global
			atkShapeCsStart = TransformedShape:call("get_Capsule"):call("get_StartPosition")
			atkShapeCsEnd = TransformedShape:call("get_Capsule"):call("get_EndPosition")
			atkShapeCsRadi = TransformedShape:call("get_Capsule"):call("get_Radius")
			atkPreShapeCsStart = TransformedShape:call("get_PreviousCapsule"):call("get_StartPosition")
			atkPreShapeCsEnd = TransformedShape:call("get_PreviousCapsule"):call("get_EndPosition")
			atkPreShapeCsRadi = TransformedShape:call("get_PreviousCapsule"):call("get_Radius")
			AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_Shape"):call("get_PreviousCapsule"):call("ToString") .. " | " --data same as in rcol

		elseif atkColShapeType == 3 then -- is single capsule
			AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_Shape"):call("get_Capsule"):call("ToString") .. " | " --get radius and pos. data same as in rcol
			--AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_TransformedShape"):call("get_Capsule"):call("ToString") .. " | " -- radius and pos data in global
			atkShapeCsStart = TransformedShape:call("get_Capsule"):call("get_StartPosition")
			atkShapeCsEnd = TransformedShape:call("get_Capsule"):call("get_EndPosition")
			atkShapeCsRadi = TransformedShape:call("get_Capsule"):call("get_Radius")
			atkPreShapeCsStart = nil
			atkPreShapeCsEnd = nil

		elseif atkColShapeType == 1 then -- is single sphere
			AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_Shape"):call("get_Sphere"):call("ToString") .. " | " --get radius and pos. data same as in rcol
			--AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_TransformedShape"):call("get_Sphere"):call("ToString") .. " | " -- radius and pos data in global
			atkShapeCsStart = TransformedShape:call("get_Sphere"):call("get_Center")
			atkShapeCsRadi = TransformedShape:call("get_Sphere"):call("get_Radius")
			atkShapeCsEnd = nil
			atkPreShapeCsStart = nil --TransformedShape:call("get_Center") --same as TransformedShape:call("get_Sphere"):call("get_Center")
			atkPreShapeCsEnd = nil

		elseif atkColShapeType == 2 then -- is continous sphere
			AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_Shape"):call("get_Sphere"):call("ToString") .. " | " --get radius and pos. data same as in rcol
			--AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_TransformedShape"):call("get_Sphere"):call("ToString") .. " | " -- radius and pos data in global
			atkShapeCsStart = TransformedShape:call("get_Sphere"):call("get_Center")
			atkShapeCsRadi = TransformedShape:call("get_Sphere"):call("get_Radius")
			atkShapeCsEnd = nil
			atkPreShapeCsStart = TransformedShape:call("get_PreviousSphere"):call("get_Center")
			atkPreShapeCsRadi = TransformedShape:call("get_PreviousSphere"):call("get_Radius")
			atkPreShapeCsEnd = nil
			AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_Shape"):call("get_PreviousSphere"):call("ToString") .. " | " --data same as in rcol

		else
			atkShapeCsStart = nil
			atkShapeCsEnd = nil
			atkPreShapeCsStart = nil
			atkPreShapeCsEnd = nil
		end
		--atkPreShapeCsStart = AttackCollider:call("get_TransformedShape"):call("get_PosA")
		--atkPreShapeCsEnd = AttackCollider:call("get_TransformedShape"):call("get_PosB")
		--:call("get_Capsule"):call("ToString") .. " | " --via continusous capluse shape


		--AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_FilterInfo"):get_type_definition():get_full_name() .. " | " -- via FilterInfo
		--AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_FilterInfo"):call("ToString") .. " | " -- via FilterInfo
		--[[local FilterInfo = AttackCollider:call("get_FilterInfo")
		AttackColliderStr = AttackColliderStr .. FilterInfo:call("get_Layer") .. " | "
		AttackColliderStr = AttackColliderStr .. FilterInfo:call("get_Group") .. " | "
		AttackColliderStr = AttackColliderStr .. FilterInfo:call("get_SubGroup") .. " | "
		AttackColliderStr = AttackColliderStr .. FilterInfo:call("get_IgnoreSubGroup") .. " | "
		AttackColliderStr = AttackColliderStr .. FilterInfo:call("get_MaskBits") .. " | "]] -- dont know how to use

		--AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_UserData"):get_type_definition():get_full_name() .. " | " --dummy hit atk shape
		--AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_UserData"):call("ToString") .. " | " --dummy hit atk shape
		local UserData = AttackCollider:call("get_UserData") --dummy hit atk shape
			AttackColliderStr = AttackColliderStr .. UserData:call("get_CustomShapeType") .. " | "
			AttackColliderStr = AttackColliderStr .. "P" .. UserData:call("get_Priority") .. " | " -- might be useful
			local OldShapeCenterPos = UserData:call("get_OldShapeCenterPos") -- shape pos at previous frame for non-continuous shape?
			--AttackColliderStr = AttackColliderStr .. OldShapeCenterPos:call("ToString") .. " | "
			if OldShapeCenterPos:get_field("_HasValue") then -- as this is nullable
				damageObject.HitPos = OldShapeCenterPos:call("get_Value") -- shape pos at previous frame for non-continuous shape?
			end
		--damageObject.HitPos = UserData:call("get_OldShapeCenterPos")
		AttackColliderStr = AttackColliderStr .. UserData:call("get_ConditionMatchHitAttr") .. " | "
		AttackColliderStr = AttackColliderStr .. UserData:call("get_OwnerType") .. " | "
		AttackColliderStr = AttackColliderStr .. UserData:call("get_RingRadius") .. " | "
		AttackColliderStr = AttackColliderStr .. tostring(UserData:call("get_IsEnemyData")) .. " | " 
		AttackColliderStr = AttackColliderStr .. UserData:call("ToString") .. " | " 
		AttackColliderStr = AttackColliderStr .. AttackCollider:call("get_GameObject"):call("get_Name") .. " | "

	local DamageShapeDataList = hitinfo:call("get_HitDamageShapeInfo"):call("get_DamageShapeDataList") -- em meat? --em hit damage shape list
		local DamageShapeDataStr = ""
		for DamageShapeDataList_idx = 0, DamageShapeDataList:call("get_Count") - 1 do
			local DamageShapeData = DamageShapeDataList:call("get_Item", DamageShapeDataList_idx)
			--DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:get_type_definition():get_full_name() .. " | " --snow.hit.userdata.EmHitDamageShapeData
			DamageShapeDataStr = DamageShapeDataStr .. "P" .. DamageShapeData:call("get_Priority") .. " | " -- might be useful
			DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("get_RequestSetId") .. " | " -- might be useful
			DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("get_CollidableIndex") .. " | " -- might be useful
			DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("get_CustomShapeType") .. " | " -- might be useful
			DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("get_OwnerType") .. " | "
			DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("get_Meat") .. " | " --(0) ABCD
			DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("get_Attr") .. " | " --(1) allow disable / no break const obj / no break const obj uniq
			DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("get_BaseHitMarkType") .. " | " --(0) normal / moderate
			DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("get_HitSoundAttr") .. " | " --just sound type
			DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("get_HitPosCorrection") .. " | " -- no info
			DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("get_LimitedHitAttr") .. " | " --(1) limited stan
			DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("get_RingRadius") .. " | "
			DamageShapeDataStr = DamageShapeDataStr .. tostring(DamageShapeData:call("get_IsEnemyData")) .. " | " 
			--DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("get_Name") .. " | " 
			--damageObject.HitPos = DamageShapeData:call("get_OldShapeCenterPos")
			DamageShapeDataStr = DamageShapeDataStr .. DamageShapeData:call("ToString") .. " \n"
		end

	--update stock
	shapePosStock[damageObject.collideShapeNum] = {}
	shapePosStock[damageObject.collideShapeNum].collideCenterPos = damageObject.collideCenterPos
	shapePosStock[damageObject.collideShapeNum].atkShapeCenter = atkShapeCenter
	shapePosStock[damageObject.collideShapeNum].dmgShapeCenter = dmgShapeCenter
	shapePosStock[damageObject.collideShapeNum].atkShapeCsStart = atkShapeCsStart
	shapePosStock[damageObject.collideShapeNum].atkShapeCsEnd = atkShapeCsEnd
	shapePosStock[damageObject.collideShapeNum].atkShapeCsRadi = atkShapeCsRadi
	shapePosStock[damageObject.collideShapeNum].atkPreShapeCsStart = atkPreShapeCsStart
	shapePosStock[damageObject.collideShapeNum].atkPreShapeCsEnd = atkPreShapeCsEnd
	shapePosStock[damageObject.collideShapeNum].atkPreShapeCsRadi = atkPreShapeCsRadi
	shapePosStock[damageObject.collideShapeNum].atkColShapeType = atkColShapeType

	--remove the item
	if (damageObject.collideShapeNum - cfg.limitShapeStock) > 0 then
		shapePosStock[damageObject.collideShapeNum - cfg.limitShapeStock] = nil
	end

	damageObject.tempDispVal_1 = AttackColliderStr
	damageObject.tempDispVal_List = DamageShapeDataStr
	
	--snow.hit.DamageFlowInfoBase
	--local damageObject = {}
	--damageObject.tempDispVal_2 = hitinfo:call("get_DamageRSData"):get_type_definition():get_full_name()
	--damageObject.total_damage = hitinfo:call("get_DamageRSData"):call("get_TotalDamage")
	--damageObject.physical_damage = hitinfo:call("get_DamageRSData"):call("get_PhysicalDamage")
	--damageObject.elemental_damage = hitinfo:call("get_DamageRSData"):call("get_ElementDamage")
	--damageObject.ailment_damage = hitinfo:call("get_DamageRSData"):call("get_ConditionDamage")

end

local hitinfoTargetMethod = sdk.find_type_definition("snow.enemy.EnemyCharacterBase"):get_method("afterCalcDamage_DamageSide")
--local hitinfoTargetMethod = sdk.find_type_definition("snow.player.LongSword"):get_method("determinateDamageFlowTypeAttackSide")
sdk.hook(hitinfoTargetMethod, function(args)
	pcall(update_hitinfo, sdk.to_managed_object(args[4]))
end, function(retval)
	return retval
end)
