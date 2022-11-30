import json, io

with io.open(r"EMList.json", mode="r", encoding="utf-8") as theFile:
        emList = json.load(theFile)

from enum import Enum

class EnumEnemyTypeIndex(Enum):
    EnemyIndex000 = 0
    EnemyIndex001 = 1
    EnemyIndex002 = 2
    EnemyIndex003 = 3
    EnemyIndex004 = 4
    EnemyIndex005 = 5
    EnemyIndex006 = 6
    EnemyIndex007 = 7
    EnemyIndex008 = 8
    EnemyIndex009 = 9
    EnemyIndex010 = 10
    EnemyIndex011 = 11
    EnemyIndex012 = 12
    EnemyIndex013 = 13
    EnemyIndex014 = 14
    EnemyIndex015 = 15
    EnemyIndex016 = 16
    EnemyIndex017 = 17
    EnemyIndex018 = 18
    EnemyIndex019 = 19
    EnemyIndex020 = 20
    EnemyIndex021 = 21
    EnemyIndex022 = 22
    EnemyIndex023 = 23
    EnemyIndex024 = 24
    EnemyIndex025 = 25
    EnemyIndex026 = 26
    EnemyIndex027 = 27
    EnemyIndex028 = 28
    EnemyIndex029 = 29
    EnemyIndex030 = 30
    EnemyIndex031 = 31
    EnemyIndex032 = 32
    EnemyIndex033 = 33
    EnemyIndex034 = 34
    EnemyIndex035 = 35
    EnemyIndex036 = 36
    EnemyIndex037 = 37
    EnemyIndex038 = 38
    EnemyIndex039 = 39
    EnemyIndex040 = 40
    EnemyIndex041 = 41
    EnemyIndex042 = 42
    EnemyIndex043 = 43
    EnemyIndex044 = 44
    EnemyIndex045 = 45
    EnemyIndex046 = 46
    EnemyIndex047 = 47
    EnemyIndex048 = 48
    EnemyIndex049 = 49
    EnemyIndex050 = 50
    EnemyIndex051 = 51
    EnemyIndex052 = 52
    EnemyIndex053 = 53
    EnemyIndex054 = 54
    EnemyIndex055 = 55
    EnemyIndex056 = 56
    EnemyIndex057 = 57
    EnemyIndex058 = 58
    EnemyIndex059 = 59
    EnemyIndex060 = 60
    EnemyIndex061 = 61
    EnemyIndex062 = 62
    EnemyIndex063 = 63
    EnemyIndex064 = 64
    EnemyIndex065 = 65
    EnemyIndex066 = 66
    EnemyIndex067 = 67
    EnemyIndex068 = 68
    EnemyIndex069 = 69
    EnemyIndex070 = 70
    EnemyIndex071 = 71
    EnemyIndex072 = 72
    EnemyIndex073 = 73
    EnemyIndex074 = 74
    EnemyIndex075 = 75
    EnemyIndex076 = 76
    EnemyIndex077 = 77
    EnemyIndex078 = 78
    EnemyIndex079 = 79
    EnemyIndex080 = 80
    EnemyIndex081 = 81
    EnemyIndex082 = 82
    EnemyIndex083 = 83
    EnemyIndex084 = 84
    EnemyIndex085 = 85
    EnemyIndex086 = 86
    EnemyIndex087 = 87
    EnemyIndex088 = 88
    EnemyIndex089 = 89
    EnemyIndex090 = 90
    EnemyIndex091 = 91
    EnemyIndex092 = 92
    EnemyIndex093 = 93
    EnemyIndex094 = 94
    EnemyIndex095 = 95
    EnemyIndex096 = 96
    EnemyIndex097 = 97
    EnemyIndex098 = 98
    EnemyIndex099 = 99
    EnemyIndex100 = 100
    EnemyIndex101 = 101
    EnemyIndex102 = 102
    EnemyIndex103 = 103
    EnemyIndex104 = 104
    EnemyIndex105 = 105
    EnemyIndex106 = 106
    EnemyIndex107 = 107
    EnemyIndex108 = 108
    EnemyIndex109 = 109
    EnemyIndex110 = 110
    EnemyIndex111 = 111
    EnemyIndex112 = 112
    EnemyIndex113 = 113
    EnemyIndex114 = 114
    EnemyIndex115 = 115
    EnemyIndex116 = 116
    EnemyIndex117 = 117
    EnemyIndex118 = 118
    EnemyIndex119 = 119
    EnemyIndex120 = 120
    EnemyIndex121 = 121
    EnemyIndex122 = 122
    EnemyIndex123 = 123
    EnemyIndex124 = 124
    EnemyIndex125 = 125
    EnemyIndex126 = 126
    EnemyIndex127 = 127
    EnemyIndex128 = 128
    EnemyIndex129 = 129
    EnemyIndex130 = 130
    EnemyIndex131 = 131
    EnemyIndex132 = 132
    EnemyIndex133 = 133
    EnemyIndex134 = 134
    EnemyIndex135 = 135
    EnemyIndex136 = 136
    EnemyIndex137 = 137
    EnemyIndex138 = 138
    EnemyIndex139 = 139
    EnemyIndex140 = 140
    EnemyIndex141 = 141
    EnemyIndex142 = 142
    EnemyIndex143 = 143
    EnemyIndex144 = 144
    EnemyIndex145 = 145
    EnemyIndex146 = 146
    EnemyIndex147 = 147
    EnemyIndex148 = 148
    EnemyIndex149 = 149
    EnemyIndex150 = 150
    EnemyIndex151 = 151
    EnemyIndex152 = 152
    EnemyIndex153 = 153
    EnemyIndex154 = 154
    EnemyIndex155 = 155
    EnemyIndex156 = 156
    EnemyIndex157 = 157
    EnemyIndex158 = 158
    EnemyIndex159 = 159
    TotalNum = 116
    IndexInvalid = 65535
    

class EnumEmTypes(Enum):
    EmTypeNoData = 0
    EmType001_00 = 1
    EmType001_02 = 513
    EmType001_07 = 1793
    EmType002_00 = 2
    EmType002_02 = 514
    EmType002_07 = 1794
    EmType003_00 = 3
    EmType004_00 = 4
    EmType007_00 = 7
    EmType007_07 = 1799
    EmType019_00 = 19
    EmType020_00 = 20
    EmType023_00 = 23
    EmType023_05 = 1303
    EmType024_00 = 24
    EmType024_08 = 2072
    EmType025_00 = 25
    EmType025_08 = 2073
    EmType027_00 = 27
    EmType027_08 = 2075
    EmType032_00 = 32
    EmType037_00 = 37
    EmType037_02 = 549
    EmType042_00 = 42
    EmType044_00 = 44
    EmType047_00 = 47
    EmType054_00 = 54
    EmType057_00 = 57
    EmType057_07 = 1849
    EmType059_00 = 59
    EmType060_00 = 60
    EmType060_07 = 1852
    EmType061_00 = 61
    EmType062_00 = 62
    EmType071_00 = 71
    EmType071_05 = 1351
    EmType072_00 = 72
    EmType077_00 = 77
    EmType081_00 = 81
    EmType082_00 = 82
    EmType082_02 = 594
    EmType082_07 = 1874
    EmType086_05 = 1366
    EmType089_00 = 89
    EmType089_05 = 1369
    EmType090_00 = 90
    EmType090_01 = 346
    EmType091_00 = 91
    EmType092_00 = 92
    EmType093_00 = 93
    EmType093_01 = 349
    EmType094_00 = 94
    EmType094_01 = 350
    EmType095_00 = 95
    EmType095_01 = 351
    EmType096_00 = 96
    EmType097_00 = 97
    EmType098_00 = 98
    EmType099_00 = 99
    EmType099_05 = 1379
    EmType100_00 = 100
    EmType102_00 = 102
    EmType107_00 = 107
    EmType108_00 = 108
    EmType109_00 = 109
    EmType118_00 = 118
    EmType118_05 = 1398
    EmType131_00 = 131
    EmType132_00 = 132
    EmType133_00 = 133
    EmType134_00 = 134
    EmType135_00 = 135
    EmType136_00 = 136
    EmType136_01 = 392
    EmsType003_00 = 4099
    EmsType003_05 = 5379
    EmsType005_00 = 4101
    EmsType006_00 = 4102
    EmsType007_00 = 4103
    EmsType008_00 = 4104
    EmsType009_00 = 4105
    EmsType013_00 = 4109
    EmsType014_00 = 4110
    EmsType016_00 = 4112
    EmsType019_00 = 4115
    EmsType020_00 = 4116
    EmsType021_00 = 4117
    EmsType025_00 = 4121
    EmsType026_00 = 4122
    EmsType027_00 = 4123
    EmsType029_00 = 4125
    EmsType034_00 = 4130
    EmsType035_00 = 4131
    EmsType036_00 = 4132
    EmsType038_00 = 4134
    EmsType039_00 = 4135
    EmsType040_00 = 4136
    EmsType041_00 = 4137
    EmsType042_00 = 4138
    EmsType043_00 = 4139
    EmsType044_00 = 4140
    EmsType049_00 = 4145
    EmsType051_00 = 4147
    EmsType051_05 = 5427
    EmsType090_00 = 4186
    EmsType091_00 = 4187
    EmsType091_05 = 5467
    EmsType092_00 = 4188
    EmsType092_01 = 4444
    EmsType093_00 = 4189
    EmsType094_00 = 4190

chsEMListFromTypeIndex = [
    "雌火龙",
    "霸主・雌火龙",
    "火龙",
    "霸主・火龙",
    "奇怪龙",
    "岩龙",
    "角龙",
    "霸主・角龙",
    "金狮子",
    "钢龙",
    "霞龙",
    "炎王龙",
    "轰龙",
    "迅龙",
    "冰牙龙",
    "土砂龙",
    "水兽",
    "眠狗龙王",
    "雷狼龙",
    "霸主・雷狼龙",
    "毒狗龙王",
    "青熊兽",
    "霸主・青熊兽",
    "白兔兽",
    "赤甲兽",
    "泡狐龙",
    "霸主・泡狐龙",
    "神秘红光天彗龙",
    "怨虎龙",
    "天狗兽",
    "伞鸟",
    "河童蛙",
    "人鱼龙",
    "妃蜘蛛",
    "泥翁龙",
    "风神龙",
    "雪鬼兽",
    "镰鼬龙王",
    "雷神龙",
    "百龙渊源雷神龙",
    "蛮颚龙",
    "毒妖鸟",
    "搔鸟",
    "泥鱼龙",
    "飞雷龙",
    "爆鳞龙",

    "机关蛙",

    "精灵鹿",
    "精灵鹿",

    "艾露猫",
    "梅拉露",
    "野猪",
    "波波",
    "雪鹿",
    "翼蛇龙",
    "硬甲龙",
    "飞甲虫",
    "甲虫",
    "咬鱼",
    "狗龙",
    "雌狗龙",
    "眠狗龙",
    "砂鱼",
    "水生兽",
    "熔岩兽",
    "垂皮龙",
    "丸鸟",
    "毒狗龙",
    "变形幼冰鲨",
    "贼龙",
    "冠突龙",
    "冠突龙",
    "狸兽",
    "镰鼬龙",
    "镰鼬龙",
    "臣蜘蛛",

    "金火龙",
    "银火龙",
    "大名盾蟹",
    "将军镰蟹",
    "激昂金狮子",
    "月迅龙",
    "黑蚀龙",
    "天廻龙",
    "千刃龙",
    "电龙",
    "焰狐龙",
    "嗟怨震天怨虎龙",
    "绯天狗兽",
    "冰人鱼龙",
    "炽妃蜘蛛",
    "熔翁龙",
    "红莲爆鳞龙",

    "爵银龙",
    "冰狼龙",
    "刚缠兽",

    "冥渊龙",
    "棘龙",
    "棘茶龙",
    "巨甲虫",
    "巨蜂",
    "蓝速龙",
    "盾蟹",
    "镰蟹",
    "卫蜘蛛",
    "丽羊兽",
    "狡狗龙",
    "怪异克服钢龙",
    "怪异克服霞龙",
    "怪异克服炎王龙",
    "Unkn1",
    "Unkn2",
    "Unkn3",
    "混沌黑蚀龙",

]

engEMListFromTypeIndex = [
    "Rathian",
    "Apex Rathian",
    "Rathalos",
    "Apex Rathalos",
    "Khezu",
    "Basarios",
    "Diablos",
    "Apex Diablos",
    "Rajang",
    "Kushala Daora",
    "Chameleos",
    "Teostra",
    "Tigrex",
    "Nargacuga",
    "Barioth",
    "Barroth",
    "Royal Ludroth",
    "Great Baggi",
    "Zinogre",
    "Apex Zinogre",
    "Great Wroggi",
    "Arzuros",
    "Apex Arzuros",
    "Lagombi",
    "Volvidon",
    "Mizutsune",
    "Apex Mizutsune",
    "Crimson Glow Valstrax",
    "Magnamalo",
    "Bishaten",
    "Aknosom",
    "Tetranadon",
    "Somnacanth",
    "Rakna-Kadaki",
    "Almudron",
    "Wind Serpent Ibushi",
    "Goss Harag",
    "Great Izuchi",
    "Thunder Serpent Narwa",
    "Narwa the Allmother",
    "Anjanath",
    "Pukei-Pukei",
    "Kulu-Ya-Ku",
    "Jyuratodus",
    "Tobi-Kadachi",
    "Bazelgeuse",

    "Giant Mechanized Toa",

    "Kelbi (Male)",
    "Kelbi (Female)",

    "Felyne",
    "Melynx",
    "Bullfango",
    "Popo",
    "Anteka",
    "Remobra",
    "Rhenoplos",
    "Bnahabra",
    "Altaroth",
    "Gajau",
    "Jaggi",
    "Jaggia",
    "Baggi",
    "Delex",
    "Ludroth",
    "Uroktor",
    "Slagtoth",
    "Gargwa",
    "Wroggi",
    "Zamite",
    "Jagras",

    "Kestodon (Male)",
    "Kestodon (Female)",

    "Bombadgy",

    "Izuchi (Male)",
    "Izuchi (Female)",

    "Rachnoid",

    "Gold Rathian",
    "Silver Rathalos",
    "Daimyo Hermitaur",
    "Shogun Ceanataur",
    "Furious Rajang",
    "Lucent Nargacuga",
    "Gore Magala",
    "Shagaru Magala",
    "Seregios",
    "Astalos",
    "Violet Mizutsune",
    "Scorned Magnamalo",
    "Blood Orange Bishaten",
    "Aurora Somnacanth",
    "Pyre Rakna-Kadaki",
    "Magma Almudron",
    "Seething Bazelgeuse",

    "Malzeno",
    "Lunagaron",
    "Garangolm",

    "Gaismagorm",
    "Espinas",
    "Flaming Espinas",
    "Hornetaur",
    "Vespoid",
    "Velociprey",
    "Hermitaur",
    "Ceanataur",
    "Pyrantula",
    "Gowngoat",
    "Boggi",
    "Risen Kushala Daora",
    "Risen Chameleos",
    "Risen Teostra",
    "Unkn1",
    "Unkn2",
    "Unkn3",
    "Chaotic Gore Magala",

]

for i in range(len(emList["EmTypes"])):
    emType = (int)(emList["EmTypes"][i])
    enemyTypeIndex = (int)(emList["EnemyTypeIndex"][i])
    record = ' | '.join((
        EnumEmTypes(emType).name,
        '{:08X}'.format(emType).format(),
        EnumEnemyTypeIndex(enemyTypeIndex).name,
        str(enemyTypeIndex),
        engEMListFromTypeIndex[enemyTypeIndex]
    ))
    #print('| '+record+' |')


record = ' | '.join((
    EnumEmTypes.EmTypeNoData.name,
    '{:08X}'.format(EnumEmTypes.EmTypeNoData.value).format(),
    "",
    "",
    ""
))
print('| '+record+' |')
for i in range(len(EnumEnemyTypeIndex)):
    try:
        emListidx = list(emList["EnemyTypeIndex"]).index(i)
        emType = (int)(emList["EmTypes"][emListidx])
        enemyTypeIndex = (int)(emList["EnemyTypeIndex"][emListidx])
        
        record = ' | '.join((
            EnumEmTypes(emType).name,
            '{:08X}'.format(emType).format(),
            EnumEnemyTypeIndex(enemyTypeIndex).name,
            str(enemyTypeIndex),
            engEMListFromTypeIndex[enemyTypeIndex]
        ))
        print('| '+record+' |')
    except:
        try:
            record = ' | '.join((
                "",
                "",
                EnumEnemyTypeIndex(i).name,
                str(i),
                ""
            ))
            print('| '+record+' |')
        except:
            record = ' | '.join((
                "",
                "",
                "TotalNum",
                str(EnumEnemyTypeIndex.TotalNum.value),
                ""
            ))
            print('| '+record+' |')
            record = ' | '.join((
                "",
                "",
                EnumEnemyTypeIndex.IndexInvalid.name,
                str(EnumEnemyTypeIndex.IndexInvalid.value),
                ""
            ))
            print('| '+record+' |')
