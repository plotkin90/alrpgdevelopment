#include <a_samp>
#include <a_mysql>
#include <sscanf2>
//#include <antiattack>
#include <dc_cmd>
#include <foreach>
#include <streamer>
#include <Alpino>
#include <anticheat>
#include <crp>
#include <mSelection>
#include <PointToPoint>
//#include <cleo>
#include <crashdetect>
//==========[new]===============================================================
#if defined MAX_PLAYERS
#undef MAX_PLAYERS
#define MAX_PLAYERS 200
#else
#define MAX_PLAYERS 200
#endif
#define 	GRN					"{3ECA18}"
#define		WHT					"{FFFFFF}"
#define		LRED				"{CE2628}"
#define		PURP				"{625FF9}"
#define		YE					"{FFE4B5}"
#define		INFO                "{C0FF3E}"
#define		LGRN				"{9ACD32}"
new PlayerText3D:playertextid23;
new PlayerText:FULLRECON[MAX_PLAYERS];
new totalhouses = 0;
new	year, month,day,player[MAX_PLAYERS][21];
enum ex { exReason[64], exDay };
new Exii[2][ex] = {
	{ "����������� ������", 91 },
	{ "������������� ��� ��������", 30 }
};
enum Bank { BankName[70], Float:BankX, Float:BankY, Float:BankZ };
new BankInfo[4][Bank] = {
	{ "������ 1", 2316.0557,-12.3972,26.7422 },
	{ "������ 2", 2316.1079,-10.0334,26.7422 },
	{ "������ 3", 2316.0652,-7.1877,26.7422 },
	{ "������ 4", 2315.9788,-4.3773,26.7422 }
};
enum iInfo { iInt, iName [ 70 ], Float: iX, Float: iY, Float: iZ, iValue};
new Interiors[13][iInfo] = {
    { 1, "���������", 243.7176,304.9697,999.1484, 500000},
    { 3, "��� Johnson'�", 2495.9456,-1692.0854,1014.7422, 0,},
    { 10,"����������� ����� ", 422.5720,2536.4568,10.0000, 700000 },
    { 5,"������� �������� �� �������� ", 2233.6184,-1115.2618,1050.8828, 700000 },
    { 9,"����������� ��� � ����������� ������ ", 2317.7410,-1026.7661,1050.2178, 2000000 },
    { 10,"���� �� ������ ����� Jefferson ", 2259.3816,-1135.8962,1050.6403, 1000000 },
    { 3,"����������� ������������� ��� ", 235.2910,1186.6793,1080.2578, 2000000 },
    { 1,"��������� ���������������� �������� ", 223.1530,1287.0830,1082.1406, 1200000 },
    { 5,"����������� ������������� ��� ", 226.2990,1114.3126,1080.9929, 5000000 },
    { 2,"������������� ��������� ", 447.0905,1397.0645,1084.3047, 30000000},
    { 10,"����������� ������� ��������� ", 23.9724,1340.1591,1084.3750, 1200000 },
	{ 12, "������������",2324.419921,-1145.568359,1050.710083, 4500000 },
	{ 5, "Madd Dogs",1298.8100585938,-796.12097167969,1084.0000000,15000000 }
};
//========����==================================================================
new fuel[MAX_VEHICLES];
new fueltype[MAX_VEHICLES];
new fuelic[MAX_VEHICLES];
new combine[MAX_VEHICLES];
new Float:VehHealth[MAX_VEHICLES];
new dengi[MAX_VEHICLES];
new bool:benzo[MAX_VEHICLES];
//======�����===================================================================
new InviteOffer[MAX_PLAYERS] = -1;
new SpecAd[MAX_PLAYERS], SpecID[MAX_PLAYERS];
new gSpectateType[MAX_PLAYERS];
new gSpectateID[MAX_PLAYERS];
new Float:TeleportDest[MAX_PLAYERS][3];
new TeleportDestNoFloat[MAX_PLAYERS][2];
new GunCheckTime[MAX_PLAYERS];
new Float: PlayerHealth[MAX_PLAYERS];
new Float: PlayerArmor[MAX_PLAYERS];
new gasp[MAX_PLAYERS];
new maximum[MAX_PLAYERS];
new price[MAX_PLAYERS];
new pakety[MAX_PLAYERS];
new Text3D:AFK_3DT[MAX_PLAYERS];
new Text3D:MuteText[MAX_PLAYERS];
new Text3D:DB[MAX_PLAYERS];
new trava[MAX_PLAYERS];
new GetPlayerMetall[MAX_PLAYERS];
new GetPlayerMetallEx[MAX_PLAYERS];
new AllPlayerMetall[MAX_PLAYERS];
new AllPlayerMetallEx[MAX_PLAYERS];
new ExtraMetall[MAX_PLAYERS];
new skillgun[MAX_PLAYERS];
new dosled[MAX_PLAYERS];
new skilldrug[MAX_PLAYERS];
new dosled1[MAX_PLAYERS];
new PlayerEnterTime[MAX_PLAYERS];
new buying[MAX_PLAYERS];
new	CarOffer[MAX_PLAYERS];
new	CarPrice[MAX_PLAYERS];
new SpecGuns[MAX_PLAYERS][13][2];
new	NaZaxvate[MAX_PLAYERS];
new Zona[MAX_PLAYERS];
new MirOffer[MAX_PLAYERS];
new vehcar[MAX_PLAYERS];
new pricep[MAX_PLAYERS];
new newsa[MAX_PLAYERS];
new InviteLive[MAX_PLAYERS];
new InviteOfferLive[MAX_PLAYERS];
new ainvite[MAX_PLAYERS];
new proezd[MAX_PLAYERS];
new taxicheck[MAX_PLAYERS];
new passanger[MAX_PLAYERS];
new moneyzaproezd[MAX_PLAYERS];
new Contract[MAX_PLAYERS];
new PosTime[MAX_PLAYERS];
//new interiorplayer[MAX_PLAYERS];
new JailOffer[MAX_PLAYERS];
new PriceOffer[MAX_PLAYERS];
new DrugsOffer[MAX_PLAYERS];
new MatsOffer[MAX_PLAYERS];
new Mats[MAX_PLAYERS];
new Drugs[MAX_PLAYERS];
new comu[MAX_PLAYERS];
new carprice[MAX_PLAYERS];
new gunid[MAX_PLAYERS];
new pricegun[MAX_PLAYERS];
new gunin[MAX_PLAYERS];
new meshokp[MAX_PLAYERS];
new choose[MAX_PLAYERS];
new idplayer[MAX_PLAYERS];
new targetp[MAX_PLAYERS];
new ammobox[MAX_PLAYERS];
new findplayer[MAX_PLAYERS];
new GMTimer[MAX_PLAYERS];
new racecheck[MAX_PLAYERS];
new gruzcp[MAX_PLAYERS];
new cpdeliv[MAX_PLAYERS];
new Menu:Admin;
//=======bool===================================================================
new bool:mute[MAX_PLAYERS];
new bool:fmute[MAX_PLAYERS];
new bool:find[MAX_PLAYERS];
new bool:cuff[MAX_PLAYERS];
new bool:delaet[MAX_PLAYERS];
//new bool:penaltyo[MAX_PLAYERS];
new bool:zavodit[MAX_PLAYERS];
new bool:apm[MAX_PLAYERS];
new bool:warning[MAX_PLAYERS];
new bool:togpm[MAX_PLAYERS];
new bool:togf[MAX_PLAYERS];
new bool:togoo[MAX_PLAYERS];
new bool:snimaet[MAX_PLAYERS];
new bool:TimeOfDeath[MAX_PLAYERS];
new	bool:PredlCar[MAX_PLAYERS];
new bool:korach[MAX_PLAYERS];
new bool:taxiv[MAX_PLAYERS];
new bool:PlayerStartJob[MAX_PLAYERS];
new bool:PlayerOnJob[MAX_PLAYERS];
new bool:nadm[MAX_PLAYERS];
new bool:spec[MAX_PLAYERS];
new bool:gps[MAX_PLAYERS];
new bool:incar[MAX_PLAYERS];
//=======Server=================================================================
new bool:open;
new gztimer;
new ashcheck;
new point;
new dmcount;
new idspec[MAX_PLAYERS];
new drugsobject[110];
new drugsobject2[110];
new drugspickupid[110];
new combinecar[4];
new Text3D:travapickup;
new Text3D:fare;
new trava1[150];
new furaveh[8];
new ash[2];
new taxi[7];
new aad;
new menu1 = mS_INVALID_LISTID;
new racen;
new vaultdoor;
new bool:noooc;
new dh;
new lotto;
//===========[textdraw]=========================================================
new PlayerText:lvlexp[MAX_PLAYERS];
new PlayerText:Time[MAX_PLAYERS];
new PlayerText:TimeJail[MAX_PLAYERS];
new PlayerText:Site[MAX_PLAYERS];
new PlayerText:BoxInfo[MAX_PLAYERS];
new PlayerText:InfoTitle[MAX_PLAYERS];
new PlayerText:InfoText[MAX_PLAYERS];
new Text: textdraw1[12]; 
new PlayerText:Textdraw[11][MAX_PLAYERS];
//new Text:Box;

new Symbols[7][3] =
{
	"(",
	")",
	"*",
	"/",
	"-.",
	"+",
	","
};
new HelpMSG[15][] = {
/*1*/    {"/pay"WHT" - �������� ������ ������� ������\n"},
/*2*/    {"/id"WHT" - ������ ID ������,\n"},
/*3*/    {"/kpk"WHT" - ������������ ��������� ������\n"},
/*4*/    {"/contract"WHT" - �������� ������ ��������\n"},
/*5*/    {"/s(hout)"WHT" - ��������\n"},
/*6*/    {"/report"WHT" - ������ ������ �������������\n"},
/*7*/    {"/vopros"WHT" - ������ ������ �������� �������\n"},
/*8*/    {"/tie"WHT" - ������� ������ (����� �������)\n"},
/*9*/    {"/untie"WHT" - ��������� ������\n"},
/*10*/    {"/me"WHT" - �������� �������� �� 3��� ����\n"},
/*11*/    {"/usedrugs"WHT" - ���������� ���������\n"},
/*12*/    {"/ad"WHT" - ������ ��������� ����������\n"},
/*13*/    {"/o"WHT" - �������� � ����� ���\n"},
/*14*/    {"/togo"WHT" - ��������/��������� ����� ��������� � ����� ����\n"},
/*15*/    {"/togf"WHT" - ��������/��������� ����� ��������� � ����������� ����\n"}
};
//==========[Setting's]=========================================================
#define		SQL_HOST     		"localhost"
#define 	SQL_USER     		 "root"
#define 	SQL_PASS     		 ""
#define 	SQL_DB      		 "myrpg"

#define		SQL_DHOST     		"a91854.mysql.mchost.ru"
#define 	SQL_DUSER     		 "a91854_1"
#define 	SQL_DPASS     		 "bvkKTj62crZ6"
#define 	SQL_DDB      		 "a91854_1"

#define 	MAX_HOUSE 	 		 500
#define 	MAX_FRACTION 	   	 18
#define 	MAX_SPIKESTRIPS 	 200
#define		MAX_FRACTION_CARS	 200
#define     GameMode         	"AL:RPG New Era 0.1 alpha"
#define 	BYTES_PER_CELL 		(cellbits / 8)
#define 	BURGER_PRICE		15
#define 	CHICKEN_PRICE		10
#define 	PEPSI_PRICE			5
#define 	PRICE_JUICE			30
#define 	PRICE_BEER			45
#define 	PRICE_WICKEY		80
#define 	PRICE_VODKA			60
#define 	PRICE_OTBIV			120
#define 	PRICE_SVIN			110
#define 	PRICE_CHICKEN		115
#define 	PTP 				IsPlayerInRangeOfPoint
#define		VehicleMaxSpeed  	200
#define 	PREFIX				"{17D6E0}[AL]{FFFFFF}"
#define     DEFAULTSKIN         3
#define 	DELAY 5
#define 	RGBToHex(%0,%1,%2,%3) %0 << 24 | %1 << 16 | %2 << 8 | %3
#define 	ADMIN_SPEC_TYPE_NONE 		0
#define 	ADMIN_SPEC_TYPE_PLAYER 		1
#define 	ADMIN_SPEC_TYPE_VEHICLE 	2
#define random_ex(%0,%1,%2) %0+(random((%1-%0)/%2+1)*%2)  
//==========[Define Dialog]=====================================================
#define 	DIALOG_LOGIN         	1
#define 	DIALOG_REGISTER     	2
#define 	DIALOG_WRONGPAS     	3
#define 	DIALOG_BAN_INFO 		4
#define 	DIALOG_UNBAN 			5
#define 	DIALOG_BAN        		6
#define		DIALOG_CRASH			7
#define		DIALOG_CONTROL_ZAVOD	8
#define		DIALOG_HU				9
#define		DIALOG_HU_HEAL			10
#define		DIALOG_BANK				11
#define 	DIALOG_BANK_SNYAT		12
#define 	DIALOG_BANK_POLOZH		13
#define 	DIALOG_BANK_INFO		14
#define 	DIALOG_ZAKUPKA_TRAVA	15
#define		DIALOG_JOB_ND			16
#define		DIALOG_ZAVOD_BUY		17
#define		DIALOG_ZAVOD_FACTORY	18
#define		DIALOG_ZAVOD_NAME		19
#define		DIALOG_ZAVOD_PRICECAR	20
#define 	DIALOG_BANK_CHECK_SNYAT	21
#define 	DIALOG_BANK_CHECK_POLOZH 22
#define 	DIALOG_INT 				23
#define 	DIALOG_KFC				24
#define 	DIALOG_KPK				25
#define 	DIALOG_KPK_ONLINE		26
#define 	DIALOG_KPK_CONTROL		27
#define 	DIALOG_KPK_PASS			28
#define 	DIALOG_STATS			29
#define 	DIALOG_GAS				30
#define		DIALOG_LITRAZH_80		31
#define		DIALOG_LITRAZH_92		32
#define		DIALOG_LITRAZH_95		33
#define		DIALOG_LITRAZH_DISEL	34
#define		DIALOG_PRICE			35
#define		DIALOG_PRICE_80			36
#define		DIALOG_PRICE_92			37
#define	 	DIALOG_PRICE_95			38
#define		DIALOG_PRICE_DISEL		39
#define		DIALOG_CONTROL_GAS		40
#define		DIALOG_GAS_INFO			41
#define		DIALOG_JOB				42
#define		DIALOG_JOB_UVAL			43
#define		DIALOG_ZAKUPKA			44
#define		DIALOG_MAKEGUN			45
#define		DIALOG_KPK_GPS			46
#define		DIALOG_JOB_GD			47
#define		DIALOG_JOB_DL			48
#define		DIALOG_GPS_LOCATION		49
#define		DIALOG_GPS_JOB			50
#define		DIALOG_SPAWNCHANGE		51
#define		DIALOG_ZAVOD_MODEL 		52
#define		DIALOG_ZAVOD_CAR		53
#define		DIALOG_ZAVOD_CAR1		54
#define		DIALOG_ZAVOD_CAR2		55
#define		DIALOG_ZAVOD_CAR3		56
#define		DIALOG_ZAVOD_CAR4		57
#define		DIALOG_ZAVOD_CAR5		58
#define		DIALOG_ZAVOD_PRICE		59
#define		DIALOG_ZAVOD_SETTINGS	60
#define		DIALOG_ZAVOD_PRICE1		61
#define		DIALOG_ZAVOD_PRICE2		62
#define		DIALOG_ZAVOD_PRICE3		63
#define		DIALOG_ZAVOD_PRICE4		64
#define		DIALOG_ZAVOD_PRICE5		65
#define		DIALOG_ZAVOD_MODEL1		66
#define		DIALOG_ZAVOD_MODEL2		67
#define		DIALOG_ZAVOD_MODEL3		68
#define		DIALOG_ZAVOD_MODEL4		69
#define		DIALOG_ZAVOD_MODEL5		70
#define		DIALOG_CONTROL_CAR		71
#define		DIALOG_CONTROL_HOUSE	72
#define		DIALOG_CONTROL_HOUSE_RENT 73
#define		DIALOG_RENT_PRICE		74
#define		DIALOG_SEIF				76
#define		DIALOG_HOUSE_PIN		77
#define		DIALOG_KEY				78
#define		DIALOG_SEIF_MATS		79
#define		DIALOG_SEIF_DRUGS		80
#define		DIALOG_SEIF_MONEY		81
#define		DIALOG_SEIF_MATS_P		82
#define		DIALOG_SEIF_MATS_Z		83
#define		DIALOG_SEIF_DRUGS_P		84
#define		DIALOG_SEIF_DRUGS_Z		85
#define		DIALOG_SEIF_MONEY_P		86
#define		DIALOG_SEIF_MONEY_Z		87
#define		DIALOG_XOLOD			88
#define		DIALOG_OBSH				89
#define		DIALOG_OBSH_MATS		90
#define		DIALOG_OBSH_DRUGS		91
#define		DIALOG_OBSH_MONEY		92
#define		DIALOG_OBSH_MATS_POLOZH 93
#define		DIALOG_OBSH_MAKEGUN		94
#define		DIALOG_OBSH_DRUGS_POLOZH 95
#define		DIALOG_OBSH_DRUGS_ZABR	96
#define		DIALOG_OBSH_MONEY_POLOZH 97
#define		DIALOG_OBSH_MONEY_ZABR  98
#define		DIALOG_OBSH_MATS_ZABR   99
#define		DIALOG_LMENU			100
#define		DIALOG_SETTING_ZAM		101
#define		DIALOG_DIPL				102
#define		DIALOG_CONTROL_CAR_INFO	103
#define		DIALOG_CVET				104
#define		DIALOG_UPGRADEFRAC		105
#define		DIALOG_UPGRADE_PISTOL 	106
#define		DIALOG_UPGRADE_AVTOMAT 	107
#define		DIALOG_UPGRADE_AVTOMAT1 108
#define		DIALOG_UPGRADE_XOLOD	109
#define		DIALOG_UPGRADE_XOLOD1	110
#define		DIALOG_HELP				111
#define		DIALOG_MALE				112
#define		DIALOG_PRIGLASIL		113
#define		DIALOG_MASK				114
#define		DIALOG_PORTABLE			115
#define		DIALOG_CONTRACTS		116
#define		DIALOG_CONTRACT			117
#define		DIALOG_KPK_CHAT			118
#define		DIALOG_CAR_CONTROL		119
#define		DIALOG_COMU				120
#define		DIALOG_BANK_PEREVOD		121
#define		DIALOG_CAR_POKUPKA		122
#define		DIALOG_LIC_BUY			123
#define		DIALOG_BUY_GUN			124
#define		DIALOG_BUY_GUN_PATRON	125
#define		DIALOG_CONTROL_AMMO		126
#define		DIALOG_AMMO_VXOD		127
#define		DIALOG_AMMO_SNYAT		128
#define		DIALOG_BUY				129
#define		DIALOG_CONTROL_MAGAZIN	130
#define		DIALOG_MAZAGIN_SNYAT	131
#define		DIALOG_FSTYLE			132
#define		DIALOG_SAFETY			133
#define		DIALOG_PHONENUMB		134
#define		DIALOG_CLUBBUY			135
#define		DIALOG_CLUB_BAR			136
#define		DIALOG_CLUB_REST		137
#define		DIALOG_CLUB_SNYAT		138
#define		DIALOG_CONTROL_CLUB		139
#define		DIALOG_CLUB_PRICEVX		140
#define		DIALOG_INV_KOLVO		141
#define		DIALOG_GET				142
#define		DIALOG_ACTION			143
#define		DIALOG_INVENTORY		144
#define		DIALOG_TARGET			145
#define 	DIALOG_PAY				146
#define 	DIALOG_GPS_FRAC			147
#define 	DIALOG_QUEST			148
#define 	DIALOG_HOUSE_CONTROLCAR	149
#define     DIALOG_AUTO_ZAKAZ       150
#define     DIALOG_COPGUN           151
#define     DIALOG_FBIGUN           152
#define     DIALOG_ARMYGUN          153
#define 	DIALOG_KPK_DOPSTAT		154
#define 	DIALOG_HOUSE_CAR		155
#define     DIALOG_HOUSE_CAR_DV     156
#define     DIALOG_HOUSE_CAR_DJ     157
#define     DIALOG_HOUSE_CAR_CH     158
#define     DIALOG_HOUSE_CAR_RACE   159
#define 	DIALOG_HOUSE_CAR_MOTO   160
#define 	DIALOG_HOUSE_CARCOLOR	161
#define 	DIALOG_EMAIL			162
#define 	DIALOG_EMAIL_ACT		163
#define		DIALOG_CHOSEQUEST		164
#define		DIALOG_HOUSE_CARCOLOR1	165
#define 	DIALOG_HOUSE_CAR_CHOOSE	167
#define		DIALOG_DONAT			168
#define 	DIALOG_KPK_FAQ			169
#define 	DIALOG_KPK_ACCOUNT		170
#define		DIALOG_MAKELEADER		171
#define 	DIALOG_BANK_OPLATA 		172
#define 	DIALOG_BANINFO			173
#define		DIALOG_GIVEGUN			174
#define 	DIALOG_REPORT			175
#define		DIALOG_REPORT1			176
#define		DIALOG_HOUSE_ENTER		177
#define		DIALOG_HOUSE_OTHER		178
#define 	DIALOG_HELPSRV			179
#define     DIALOG_APANEL           180
#define     DIALOG_WEATHER          181
#define     DIALOG_SPEC_WARN        182
#define     DIALOG_SPEC_BAN         183
#define     DIALOG_SPEC_KICK        184
#define     DIALOG_ADD              185
#define     DIALOG_ADD_HOUSE        186
#define		DIALOG_RACE				187
#define     DIALOG_RADIO            188
#define		DIALOG_HUD				189
#define 	DIALOG_TIMEUSE			190
//==========[Define Color]======================================================
#define 	COLOR_YELLOW         	 0xFFFF00AA
#define	 	COLOR_WHITE  			 0xFFFFFFAA
#define 	COLOR_LIGHTRED 	 		 0xFF6347FF
#define		COLOR_LIGHTBLUE  	     0x33CCFFFF
#define 	COLOR_BLUE 		 		 0x01FCFFC8
#define 	C_BLUE					 0x33AAFFFF
#define 	COLOR_YELLOW 	 		 0xFFFF00AA
#define 	COLOR_LIGHTGREEN 		 0x9ACD32FF
#define 	COLOR_ORANGE	   		 0xFFA500FF
#define 	COLOR_PURPLE 			 0xC2A2DAAA
#define 	COLOR_RADIO 		 	 0x8D8DFF00
#define 	COLOR_GREEN 		 	 0x00D900C8
#define 	COLOR_DEPORT 			 0xFF8282AA
//==========[Array]=============================================================
//==========[VSPAWNER]==========================================================
#define TOTAL_ITEMS         207
#define SELECTION_ITEMS 	21
#define ITEMS_PER_LINE  	7

#define HEADER_TEXT "Vehicles"
#define NEXT_TEXT   "Next"
#define PREV_TEXT   "Prev"

#define DIALOG_BASE_X   	75.0
#define DIALOG_BASE_Y   	130.0
#define DIALOG_WIDTH    	550.0
#define DIALOG_HEIGHT   	180.0
#define SPRITE_DIM_X    	60.0
#define SPRITE_DIM_Y    	70.0

new gTotalItems = TOTAL_ITEMS;

new gItemListTwo[TOTAL_ITEMS] = {
400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,
431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,450,451,452,453,454,455,456,457,458,459,460,461,
462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,
493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,519,520,521,522,523,
524,525,526,527,528,529,530,531,532,533,534,535,536,539,540,541,542,543,544,545,546,547,548,549,550,551,552,553,554,
555,556,557,558,559,560,561,562,563,564,565,566,567,568,571,572,573,574,575,576,577,578,579,580,581,582,583,584,585,
586,587,588,589,590,591,592,593,594,595,596,597,598,599,600,601,602,603,604,605,606,607,608,609,610,611
};
//================================================================================
enum AC_Info
{
	Float: Position[3],
	Spawn_Block,
	OldInterior
};
enum ReadPositions{ Float:ReadX,Float:ReadY,Float:ReadZ }
new ReadPlayerPosition[MAX_PLAYERS][ReadPositions];
enum sInfo
{
	sCreated,
    Float:sX,
    Float:sY,
    Float:sZ,
    sObject,
};
new SpikeInfo[MAX_SPIKESTRIPS][sInfo];
enum raceInfo
{
	Laps,
	ID,
	Max,
	Who1[MAX_PLAYER_NAME],
	Who2[MAX_PLAYER_NAME],
	Who3[MAX_PLAYER_NAME],
	Who4[MAX_PLAYER_NAME],
	Who5[MAX_PLAYER_NAME],
	Float:RegX,
	Float:RegY,
	Float:RegZ,
	bool:Reg,
	CountM,
	Timer,
	bool:TimerP ,
	Float:PosStart1[3],
	Float:PosStart2[3],
	Float:PosStart3[3],
	Float:PosStart4[3],
	Float:PosStart5[3],
	Float:Angle1,
	Float:Angle2,
	Float:Angle3,
	Float:Angle4,
	Float:Angle5,
	Float:Check1[3],
	Float:Check2[3],
	Float:Check3[3],
	Float:Check4[3],
	Float:Check5[3],
	Finished,
	bool:Locate,
	bool:Start
}
new Race[3][raceInfo];
enum pInfo
{
    pID,
    pName[MAX_PLAYER_NAME],
    pPassword[64],
	pMail[64],
    bool: pLogged,
    pWrongPassword,
    pHouse,
	pLevel,
	pAdmin,
	pMuteTime,
	pJailTime,
	pWarn,
	pLeader,
	pMember,
	pRank,
	pJailed,
	pRent,
	pStartAsh,
	pMoney,
	pBank,
	pExp,
	pGameTime,
	pLicError,
	pFW,
	pFMuteTime,
	pSkin,
	pFuel,
	pJob,
	pSpawn,
	pGunSkill,
	pMats,
	pSklad,
	pZP,
	pWanted,
	bool:pLic[5],
	bool:pBlocked,
	pDrugs,
	pDrugSkill,
	bool:pCrashed,
	Float:pX,
	Float:pY,
	Float:pZ,
	pZavod,
	pCar,
	pCarM,
	Float: pCarX,
	Float: pCarY,
	Float: pCarZ,
	pCC1,
	pCC2,
	pSpoiler,
	pHood,
	pSideskirt,
	pNitro,
	pLamps,
	pExhaust,
	pWheels,
	pRoof,
	pStereo,
	pHydraulics,
	pBullbar,
	pRearBullbars,
	pFrontSign,
	pFrontBullbars,
	pFrontBumper,
	pRearBumper,
	pVents,
	pPaintJob,
	pZam,
	bool:pReg,
	bool:pMale,
	pPriglasil[64],
	bool:pInvite,
	pExpNext,
	bool:pMask,
	pContract,
	pHelper,
	pAmmo,
	pOtm,
	pMagazin,
	pFstyle,
	pClub,
	bool:pGPS,
	bool:pOTR,
	pNat,
	pReason[64],
	pReason1[64],
	bool:pQuest[5],
	bool:pOnline,
	pKMats,
	pKDrugs,
	pTakeMoney,
	pMuteReason[64],
	pMuteDal[MAX_PLAYER_NAME],
	pUnmuteReason[64],
	pUnmuteDal[MAX_PLAYER_NAME],
	pSmoke,
	bool:pTie,
	bool:pVaip,
	pDM,
	bool:pVIP,
};
new PlayerInfo[MAX_PLAYERS][pInfo];
enum zInfo
{
	bool:zOpen,
	zGun,
	zMax,
	zPeople,
};
new ZoneInfo[zInfo];

enum rpInfo
{
	bool:rpOpened,
	bool:rpForDelete = true,
	rpMsg[128],
	rpReportWho[MAX_PLAYER_NAME],
	rpWhoOn[MAX_PLAYER_NAME],
}
new ReportInfo[MAX_PLAYERS][rpInfo];

enum hInfo
{
	hID,
	Float:hEntrancex,
	Float:hEntrancey,
	Float:hEntrancez,
	Float:hExitx,
	Float:hExity,
	Float:hExitz,
	hOwner[MAX_PLAYER_NAME],
	hValue,
	hInt,
	bool:hLock,
	bool:hOwned,
	hLevel,
	Text3D:hLabel,
	hRent,
	hHeal,
	bool:hArmour,
	hIcon,
	hBank,
	hMats,
	hDrugs,
	hMoney,
	hPickup,
};
new HouseInfo[MAX_HOUSE][hInfo];

enum aInfo
{
	aBaseid,
	aModel,
	aID,
	Float:aX,
	Float:aY,
	Float:aZ,
	Float:aA,
	aColor1,
	aColor2,
	aRank,
	aFraction,
	aJob,
};
new AutoInfo[MAX_FRACTION_CARS][aInfo];

enum fInfo
{
	fID,
	fName[32],
	Float:ffX,
	Float:ffY,
	Float:ffZ,
	fLeader[MAX_PLAYER_NAME],
	fRank1[64],
	fRank2[64],
	fRank3[64],
	fRank4[64],
	fRank5[64],
	fRank6[64],
	fInt,
	fSkin1,
	fSkin2,
	fSkin3,
	fSkin4,
	fSkin5,
	fSkin6,
	fVW,
	fZaxvat,
	fKills,
	Float: fBX,
	Float: fBY,
	Float: fBZ,
	fMats,
	fDrugs,
	fMoney,
	bool:fZamRank,
	bool:fZamKick,
	bool:fZamInvite,
	bool:fZamMute,
	bool:fZamUnMute,
	bool:fZamVyg,
	bool:fZamUnVyg,
	bool:fZamUn,
	bool:fGroove,
	bool:fBallas,
	bool:fVagos,
	bool:fCoronos,
	fCvet,
	fPistol,
	fAvtomat,
	fXolod,
	fMaxMats,
	fMaxDrugs,
	fOtkat,
	fWar,
};
new Fraction[MAX_FRACTION][fInfo];

enum bInfo
{
	bID,
	Float:bX,
	Float:bY,
	Float:bZ,
	Float:brX,
	Float:brY,
	Float:brZ,
	bCheckpoint,
	bObject,
};
new Bankomat[30][bInfo];

enum rInfo
{
	rID,
	Float:rX,
	Float:rY,
	Float:rZ,
	Float:rrX,
	Float:rrY,
	Float:rrZ,
	bool:rType
};
new Radar[101][rInfo];

enum kInfo
{
	kID,
	Float:kX,
	Float:kY,
	Float:kZ
}
new KFC[110][kInfo];

enum gInfo
{
	gID,
	Float:gX,
	Float:gY,
	Float:gZ,
	gPrice80,
	gPrice92,
	gPrice95,
	gPriceDisel,
	g80,
	g92,
	g95,
	gDisel,
	gPrice,
	gLevel,
	gOwner[MAX_PLAYER_NAME],
	bool:gOwned,
	Text3D:gLabel,
	gBank,
	Float:Pos[3],
}
new Gas[20][gInfo];

enum jInfo
{
	jID,
	Float:jX,
	Float:jY,
	Float:jZ,
	jName[MAX_PLAYER_NAME],
	jLevel,
}
new Job[10][jInfo];

enum miInfo
{
	miID,
	Float:miX,
	Float:miY,
	Float:miZ,
	miIkonka,
}
new MIcon[50][miInfo];

enum wInfo
{
	wSlot0,
	wSlot1,
	wSlot2,
	wSlot3,
	wSlot4,
	wSlot5,
	wSlot6,
	wSlot7,
	wSlot8,
	wSlot9,
	wSlot10,
	wSlot11,
	wSlot12,
	wGun[12],
}
new Weapon[MAX_PLAYERS][wInfo];

enum afk_info
{
	AFK_Time,
	Float:AFK_Coord,
	AFK_Stat
}
new PlayerAFK[MAX_PLAYERS][afk_info];

enum tInfo { kolvo }
new Trava[tInfo];
enum gzInfo
{
    gzID,
    gzFraction,
    Float:gzLocationminx,
    Float:gzLocationminy,
    Float:gzLocationmaxx,
    Float:gzLocationmaxy,
    gzCreate,
    Text: gzTextDraw,
	gzTimer,
	gWar1,
	gWar2,
};
new GangZone[101][gzInfo];
enum wrInfo
{
	wrFrac,
	wrWarFrac
}
new War[wrInfo];

enum amInfo
{
	amID,
	Float:amEnterX,
	Float:amEnterY,
	Float:amEnterZ,
	Float:amExitX,
	Float:amExitY,
	Float:amExitZ,
	amOwner[MAX_PLAYER_NAME],
	amPrice,
	amInterior,
	amBank,
	bool:amLock,
	bool:amOwned,
	amLevel,
	Text3D:amLabel,
	Float: amBuyX,
	Float: amBuyY,
	Float: amBuyZ,
	amPriceVx,
};
new Ammo[15][amInfo];

enum stVeh
{
	Float:stX,
	Float:stY,
	Float:stZ,
	Float:stA,
	stModel,
	stID
};
new Street[500][stVeh];
enum mInfo
{
	mID,
	Float:mEnterX,
	Float:mEnterY,
	Float:mEnterZ,
	Float:mExitX,
	Float:mExitY,
	Float:mExitZ,
	mOwner[MAX_PLAYER_NAME],
	mPrice,
	mInterior,
	mBank,
	bool:mLock,
	bool:mOwned,
	mLevel,
	Text3D:mLabel,
	Float: mBuyX,
	Float: mBuyY,
	Float: mBuyZ,
};
new Magazin[15][mInfo];
enum cInfo
{
	cID,
	Float:cEnterX,
	Float:cEnterY,
	Float:cEnterZ,
	Float:cExitX,
	Float:cExitY,
	Float:cExitZ,
	cOwner[MAX_PLAYER_NAME],
	cPrice,
	cInterior,
	cBank,
	bool:cLock,
	bool:cOwned,
	cLevel,
	Text3D:cLabel,
	Float: cBuyX,
	Float: cBuyY,
	Float: cBuyZ,
	cPriceVx,
};
new Club[7][cInfo];
enum iiInfo
{
	iiTrava,
	iiMetall,
	iiDrugs,
	iiMats,
	iiPatron,
	Text3D:iiLabelMats,
	Text3D:iiLabelDrugs,
	Text3D:iiLabelPatron,
	Text3D:iiLabelTrava,
	Text3D:iiLabelMetall,
	iiAU80,
	iiAU92,
	iiAU95,
	iiDisel,
};
new Infa[iiInfo];
main() {}
public OnGameModeInit()
{
    ConnectMySQL();
	mysql_debug(1);
	//ConnectDonateMySQL();
	
	UsePlayerPedAnims();
    DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	SetGameModeText(GameMode);
	ShowPlayerMarkers(2);

	SetTimer("PlayerTimer",1000,1);
	SetTimer("UpdateTime",60000,1);
	SetTimer("Fuel",1000*20,1);
	
	LoadSys();
	CreateRace();
	CreateServerVehicle();
	CreateSpec();
	CreatePickupText();
	CreateTextDrawsForSkin();
	place_init();
	menu1 = LoadModelSelectionMenu("menu1.txt");
	CreateDynamicObject(7238,2592.2578, 2660.4453, 23.3984,0.0000000,0.0000000,0.0000000);
	vaultdoor = CreateDynamicObject(2634,2144.1999500,1626.9997600,994.2500000,0.0000000,0.0000000,182.0000000);
	for(new d=0; d < sizeof(drugsposition); d++){ drugspickupid[d] = CreatePickup(1242, 14, drugsposition[d][0], drugsposition[d][1], 127.615625); }
	for(new d=0; d < sizeof(drugsposition); d++) { drugsobject[d] = CreateObject(3409,drugsposition[d][0],drugsposition[d][1],128.015625,0.00000000,0.00000000,0.00000000); drugsobject2[d] = CreateObject(3409,drugsposition[d][0],drugsposition[d][1],129.015625,0.00000000,0.00000000,0.00000000); }
	return true;
}

public OnGameModeExit()
{
	for(new h;h<totalhouses;h++) SaveHouse(h);
	foreach(Player,i) SaveAccount(i);
	for(new i = 1; i < sizeof(Ammo); i++) SaveAmmo(i);
	for(new i = 1; i < sizeof(Magazin); i++) SaveMagazin(i);
	for(new i = 1; i < sizeof(Club); i++) SaveClub(i);
	SaveInfa();
    DisconnectMySQL();
	return true;
}

public OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid)) return true;
	SendClientMessage(playerid,-1,"���������, ���������� ��������...");
	SetPlayerColor(playerid,0xFFFFFF00);
	GetPlayerName(playerid, PlayerInfo[playerid][pName], MAX_PLAYER_NAME);
	for(new i = 0; i < 4; i++) RemovePlayerAttachedObject(playerid,i);
	for(new i = 0; i < sizeof(GangZone); i++)  GangZoneShowForPlayer(playerid, GangZone[i][gzCreate], GetGangZoneColor(i));
	ServerResetPlayerWeapons(playerid);
    CheckBanList(playerid);
	RemovePlayerVariables(playerid);
	new count;
	for (new i; i < strlen(PlayerInfo[playerid][pName]); i++)
	{
		if (PlayerInfo[playerid][pName][i] >= '0' && PlayerInfo[playerid][pName][i] <= '9')
		{
			count++;
			if(count == 4) { SendClientMessage(playerid,0xE0EA64AA,"C������ ��� ���! � ����� ���� ����� 3 ����!"); ALKick(playerid); break; }
		}
	}
	if(GetAccountID(playerid)) ShowLogin(playerid);
    else ShowRegister(playerid);
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	new string[128], ip[16];
	GetPVarString(playerid, "iplog", ip, 16);
	switch(reason)
    {
        case 0:
		{
			format(string,sizeof string,""PURP"%s[%d]"WHT" (IP: %s) ������� ������. (�����)",PlayerInfo[playerid][pName],playerid, ip);
			if(GetPlayerInterior(playerid) == 0) {
				GetPlayerPos(playerid,PlayerInfo[playerid][pX],PlayerInfo[playerid][pY],PlayerInfo[playerid][pZ]);
				PlayerInfo[playerid][pCrashed] = true;
			}	
			SaveAccount(playerid);
		}
        case 1:
		{
			format(string,sizeof string,""PURP"%s[%d]"WHT" (IP: %s) ������� ������. (�����)",PlayerInfo[playerid][pName],playerid, ip);
			if(cuff[playerid] == true) PlayerInfo[playerid][pJailTime] += 100*60;
		}
        case 2: format(string,sizeof string,""PURP"%s[%d]"WHT" (IP: %s) ������� ������. (���/���)",PlayerInfo[playerid][pName],playerid, ip);
    }
    if(GetPVarInt(playerid,"Strips") == 1) DeleteClosestStrip(playerid);
	PlayerAFK[playerid][AFK_Time] = 0;
    if(PlayerAFK[playerid][AFK_Stat] != 0) { Delete3DTextLabel(AFK_3DT[playerid]); PlayerAFK[playerid][AFK_Stat] = 0; }
	SendAdminMessage(-1,string,1);
	SaveAccount(playerid);
	PlayerTextDrawDestroy(playerid,lvlexp[playerid]);
	if(PlayerInfo[playerid][pCar] > 0) DestroyVehicle(PlayerInfo[playerid][pCar]);
	DestroyVehicle(vehcar[playerid]);
    PlayerTextDrawDestroy(playerid,lvlexp[playerid]);
    PlayerTextDrawDestroy(playerid,Time[playerid]);
    PlayerTextDrawDestroy(playerid,TimeJail[playerid]);
    PlayerTextDrawDestroy(playerid,Site[playerid]);
    PlayerTextDrawDestroy(playerid,BoxInfo[playerid]);
    PlayerTextDrawDestroy(playerid,InfoTitle[playerid]);
    PlayerTextDrawDestroy(playerid,InfoText[playerid]);
	PlayerInfo[playerid][pOnline] = false;
	return true;
}
public OnPlayerRequestClass(playerid,classid)
{
	if(GetPVarInt(playerid, "Connected") == 1)
	{
	    new fam = GetPlayerMember(playerid);
		if(fam == 0) SetPlayerColor(playerid, 0xFFFFFF20);
	    switch(PlayerInfo[playerid][pSpawn])
		{
			case 0://�����
			{
			    if(PlayerInfo[playerid][pMale] == true) PlayerInfo[playerid][pSkin] = 12;
			    SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], -1972.3838,137.6144,27.6875, 87.8889, -1, -1, -1, -1, -1, -1);
			}
			case 1:
			{
			    new skin;
			 	switch(PlayerInfo[playerid][pRank])
				{
					case 1: skin = Fraction[fam][fSkin1];
					case 2: skin = Fraction[fam][fSkin2];
					case 3: skin = Fraction[fam][fSkin3];
					case 4: skin = Fraction[fam][fSkin4];
					case 5: skin = Fraction[fam][fSkin5];
					case 6: skin = Fraction[fam][fSkin6];
				}
				SetSpawnInfo(playerid, 0, skin, Fraction[fam][ffX],Fraction[fam][ffY],Fraction[fam][ffZ], 87.8889, Fraction[fam][fXolod], 1, -1, -1, -1, -1);
				SetPlayerInterior(playerid,Fraction[fam][fInt]); 
				SetPlayerVirtualWorld(playerid,Fraction[fam][fVW]);
				PlayerInfo[playerid][pSkin] = skin;
				SetPlayerColor(playerid,playerColors[Fraction[fam][fCvet]]);
				if(PlayerInfo[playerid][pLic][4] == true) { ServerGivePlayerWeapon(playerid,Fraction[fam][fPistol],150); ServerGivePlayerWeapon(playerid,Fraction[fam][fAvtomat],350); }
			}
			case 2:
			{
			    SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], HouseInfo[PlayerInfo[playerid][pHouse]][hExitx],HouseInfo[PlayerInfo[playerid][pHouse]][hExity],HouseInfo[PlayerInfo[playerid][pHouse]][hExitz], 87.8889, -1, -1, -1, -1, -1, -1);
				SetPlayerVirtualWorld(playerid,HouseInfo[PlayerInfo[playerid][pHouse]][hID]);
				SetPlayerInterior(playerid,HouseInfo[PlayerInfo[playerid][pHouse]][hInt]);
			}
			case 3:
			{
			    new h = PlayerInfo[playerid][pRent];
			    SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], HouseInfo[h][hExitx],HouseInfo[h][hExity],HouseInfo[h][hExitz], 87.8889, -1, -1, -1, -1, -1, -1);
				SetPlayerInterior(playerid,HouseInfo[h][hInt]);
				SetPlayerVirtualWorld(playerid,HouseInfo[h][hID]);
			}
		}
		SpawnPlayer(playerid);
	}
    return true;
}
public OnPlayerSpawn(playerid)
{
	SetPVarInt(playerid, "CheckSpawn", 1);
	TimeOfDeath[playerid] = false;
	SetPVarInt(playerid,"ALANTICRASH",0);
	ServerSetPlayerHealth(playerid,100);
	PlayerSpawns(playerid);
	return true;
}
stock PlayerSpawns(playerid)
{
	new string[128];
	switch(PlayerInfo[playerid][pLevel])
	{
		case 0: PlayerInfo[playerid][pExpNext] = 3;
		default: PlayerInfo[playerid][pExpNext] = (PlayerInfo[playerid][pLevel]+1)*3;
	}
	SetPlayerScore(playerid,PlayerInfo[playerid][pLevel]);
	if(PlayerInfo[playerid][pMuteTime] > 0 && mute[playerid] == false)  {
		mute[playerid] = true;
		MuteText[playerid] = CreateDynamic3DTextLabel(""LRED"� ������ ��� ����", -1, 0.00, 0.00, 0.0, 20.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 15.0);
	}
	if(PlayerInfo[playerid][pFMuteTime] > 0) fmute[playerid] = true;
	SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
	if(PlayerInfo[playerid][pBlocked] == true)
	{
		format(string,sizeof(string),"{FFFFFF}������� %s {F31212}������������{FFFFFF} �� ���� �������! �������������� �� ��������.",PlayerInfo[playerid][pName]);
		SendClientMessage(playerid,-1,string);
		ALKick(playerid);
		return true;
	}
	meshokp[playerid] = 0;
	SetPlayerColor(playerid,0xFFFFFF00);
	ServerSetPlayerHealth(playerid,100);
	GunCheckTime[playerid] = 5;
	ServerResetPlayerWeapons(playerid);
	new skin,fam = GetPlayerMember(playerid);
	if(PlayerInfo[playerid][pJailTime] > 0)
	{
		JailPlayer(playerid);
		format(string,sizeof(string),"Time in Jail: %s",ConvertSeconds(PlayerInfo[playerid][pJailTime]));
		PlayerTextDrawSetString(playerid,TimeJail[playerid], string);
		PlayerTextDrawShow(playerid,TimeJail[playerid]);
		SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
		return true;
	}
	switch(PlayerInfo[playerid][pSpawn])
	{
		case 0://�����
		{
			ServerSetPlayerPos(playerid,-1972.3838,137.6144,27.6875);
			SetPlayerFacingAngle(playerid, 87.8889);
			if(PlayerInfo[playerid][pMale] == false) SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
			else { SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]); }
		}
		case 1:
		{
			if(fam == 5) { SetPlayerInterior(playerid,3); SetPlayerVirtualWorld(playerid,3); ServerSetPlayerPos(playerid,384.808624,173.804992,1008.382812); }
			else { SetPlayerInterior(playerid,Fraction[fam][fInt]); SetPlayerVirtualWorld(playerid,Fraction[fam][fVW]); ServerSetPlayerPos(playerid,Fraction[fam][ffX],Fraction[fam][ffY],Fraction[fam][ffZ]); }
			switch(PlayerInfo[playerid][pRank])
			{
				case 1: skin = Fraction[fam][fSkin1];
				case 2: skin = Fraction[fam][fSkin2];
				case 3: skin = Fraction[fam][fSkin3];
				case 4: skin = Fraction[fam][fSkin4];
				case 5: skin = Fraction[fam][fSkin5];
				case 6: skin = Fraction[fam][fSkin6];
			}
			SetPlayerSkin(playerid,skin);
			PlayerInfo[playerid][pSkin] = skin;
			SetPlayerColor(playerid,playerColors[Fraction[fam][fCvet]]);
			if(Fraction[fam][fZaxvat] > 0 && Fraction[fam][fWar] > 0) {
				TextDrawShowForPlayer(playerid, GangZone[Fraction[fam][fZaxvat]][gzTextDraw]);
			}	
		}
		case 2:
		{
			ServerSetPlayerPos(playerid,HouseInfo[PlayerInfo[playerid][pHouse]][hExitx],HouseInfo[PlayerInfo[playerid][pHouse]][hExity],HouseInfo[PlayerInfo[playerid][pHouse]][hExitz]);
			SetPlayerVirtualWorld(playerid,HouseInfo[PlayerInfo[playerid][pHouse]][hID]);
			SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
			SetPlayerInterior(playerid,HouseInfo[PlayerInfo[playerid][pHouse]][hInt]);
		}
		case 3:
		{
			new h = PlayerInfo[playerid][pRent];
			SetPlayerInterior(playerid,HouseInfo[h][hInt]);
			SetPlayerVirtualWorld(playerid,HouseInfo[h][hID]);
			ServerSetPlayerPos(playerid,HouseInfo[h][hExitx],HouseInfo[h][hExity],HouseInfo[h][hExitz]);
			SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
		}
	}
	if(Fraction[fam][fPistol] > 0) ServerGivePlayerWeapon(playerid,Fraction[fam][fPistol],100);
	if(Fraction[fam][fAvtomat] > 0) ServerGivePlayerWeapon(playerid,Fraction[fam][fAvtomat],150);
	ServerGivePlayerWeapon(playerid,Fraction[fam][fXolod],1);
	SetPlayerWantedLevel(playerid,PlayerInfo[playerid][pWanted]);
	SetPlayerFightingStyle(playerid, PlayerInfo[playerid][pFstyle]);
	SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
	if(PlayerInfo[playerid][pCrashed] == true) { SPD(playerid,DIALOG_CRASH,DIALOG_STYLE_MSGBOX,""PREFIX" �������������� ������","{FFFFFF}���������� ������ ���� ��������� ��������,������ ������������ ������� �� ������?","��","���"); return true;  }
	if(PlayerInfo[playerid][pCarM] > 0) { PlayerInfo[playerid][pCar] = CreateVehicle(PlayerInfo[playerid][pCarM],PlayerInfo[playerid][pCarX],PlayerInfo[playerid][pCarY],PlayerInfo[playerid][pCarZ],0.0,PlayerInfo[playerid][pCC1],PlayerInfo[playerid][pCC2],600); TuneCar(playerid);}
	SetPVarInt(playerid,"spawnkill",7);
	ServerSetPlayerHealth(playerid,100);
	return true;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	GivePlayerMoney(playerid, 100);
	new string[128];
	if(reason == 54 || reason == 53 || reason == 51 || reason == 47 || reason == 255 || PlayerInfo[killerid][pMask] == true) return true; 
	else SendDeathMessage(killerid,playerid,reason);
	if(reason == 49 || reason == 50)
	{
		format(string,sizeof(string),"Alpino: %s ���(�) ������(�) ��������. �������: Drive by",PlayerInfo[killerid][pName]);
		SendClientMessageToAll(COLOR_LIGHTRED,string);
		ALKick(killerid);
	}
	if(GetPVarInt(playerid,"spawnkill") > 0)
	{
		format(string,sizeof(string),"Alpino: %s ���(�) ������(�) ��������. �������: SpawnKill",PlayerInfo[killerid][pName]);
		SendClientMessageToAll(COLOR_LIGHTRED,string);
		ALKick(killerid);
	}
	if(!IsACop(killerid) && nadm[playerid] == false)
	{
		new w = GetPlayerWantedLevel(killerid)+1;
		SetPlayerWantedLevel(killerid,w);
		if(PlayerInfo[killerid][pWanted] != 6) PlayerInfo[killerid][pWanted] = w;
	}
	new fam = GetPlayerMember(killerid);
	new fam1 = GetPlayerMember(playerid);
	if(NaZaxvate[killerid] > 0)
	{
		if(fam1 == Fraction[fam][fWar]) Fraction[fam][fKills] ++;
	}
	SetPVarInt(playerid,"CheckSpawn",0);
	PlayerEnterTime[playerid]+=221;
	PosTime[playerid] = 3;
	if(GetPlayerWantedLevel(playerid) > 0 && IsACop(killerid) && GetPVarInt(playerid, "otkatkpz") == 0)
	{
		switch(GetPlayerWantedLevel(playerid))
		{
			case 1: PlayerInfo[playerid][pJailTime] += 10*60;
			case 2: PlayerInfo[playerid][pJailTime] += 20*60;
			case 3: PlayerInfo[playerid][pJailTime] += 30*60;
			case 4: PlayerInfo[playerid][pJailTime] += 40*60;
			case 5: PlayerInfo[playerid][pJailTime] += 50*60;
			case 6: PlayerInfo[playerid][pJailTime] += 60*60;
		}
		PlayerInfo[playerid][pJailed] = 1;
		JailPlayer(playerid);
		PlayerInfo[playerid][pWanted] = 0;
		SetPlayerWantedLevel(playerid,0);
		new slot1[MAX_PLAYER_NAME] = 0, slot2[MAX_PLAYER_NAME] = 0, slot3[MAX_PLAYER_NAME] = 0, slot4[MAX_PLAYER_NAME] = 0, slot5[MAX_PLAYER_NAME] = 0, spisok[64*5+1] = 0;
		if(Weapon[playerid][wGun][0] > 0) { GetWeaponName(Weapon[playerid][wGun][0], slot1, 64); strcat(spisok, slot1, 64); }
		if(Weapon[playerid][wGun][1] > 0) {
			GetWeaponName(Weapon[playerid][wGun][1], slot2, 64);
			if(strfind(slot1,"0",true) == -1) strins(slot2, ",", 0);
			strcat(spisok, slot2, 64);
		}
		if(Weapon[playerid][wGun][2] > 0) {
			GetWeaponName(Weapon[playerid][wGun][2], slot3, 64);
			if(strfind(slot2,"0",true) == -1) strins(slot3, ",", 0);
			strcat(spisok, slot3, 64);
		}
		if(Weapon[playerid][wGun][3] > 0) {
			GetWeaponName(Weapon[playerid][wGun][3], slot4, 64);
			if(strfind(slot3,"0",true) == -1) strins(slot4, ",", 0);
			strcat(spisok, slot4, 64);
		}
		if(Weapon[playerid][wGun][4] > 0) {
			GetWeaponName(Weapon[playerid][wGun][4], slot5, 64);
			if(strfind(slot4,"0",true) == -1) strins(slot5, ",", 0);
			strcat(spisok, slot5, 64);
		}
		if(strfind(spisok,"0",true) == -1) {
			format(string, sizeof(string), "��� ������ ������������ ������ � ��� ���� ������ ��������� ������: %s", spisok);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		}
		ServerResetPlayerWeapons(playerid);
	}
	if(reason == 255 && TimeOfDeath[playerid] == false)
	{
		format(string,sizeof(string),"%s ��� ������ �� Fake-Kill",PlayerInfo[playerid][pName]);
		SendAdminMessage(COLOR_LIGHTRED,string,1);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���� ������� �� Fake-Kill");
		ALKick(playerid);
	}
	if(nadm[playerid] == true)
	{
		nadm[playerid] = false;
		dmcount --;
		SetMoney(killerid,200);
		SetPVarInt(killerid, "killsondm", GetPVarInt(killerid, "killsondm")+1);
		switch(GetPVarInt(killerid, "killsondm")) {
			case 2: PlayAudioStreamForPlayer(killerid, "announcer_kill_double_01.mp3", 0.0, 0.0, 0.0), SendZoneMessage(2, killerid);
			case 3: PlayAudioStreamForPlayer(killerid, "announcer_kill_triple_01.mp3", 0.0, 0.0, 0.0), SendZoneMessage(3, killerid);
			case 4: PlayAudioStreamForPlayer(killerid, "announcer_kill_ultra_01.mp3", 0.0, 0.0, 0.0), SendZoneMessage(4, killerid);
			case 5: PlayAudioStreamForPlayer(killerid, "announcer_kill_rampage_01.mp3", 0.0, 0.0, 0.0), SendZoneMessage(5, killerid);
			case 6: PlayAudioStreamForPlayer(killerid, "announcer_kill_unstop_01.mp3", 0.0, 0.0, 0.0), SendZoneMessage(6, killerid);
			case 7: PlayAudioStreamForPlayer(killerid, "announcer_kill_holy_01.mp3", 0.0, 0.0, 0.0), SendZoneMessage(7, killerid);
		}
		if(dmcount == 1) { ZoneInfo[zOpen] = false;  ZoneInfo[zGun] = 0; ZoneInfo[zMax] = 0; dmcount = 0; nadm[killerid] = false; ServerSetPlayerHealth(killerid,0);}
	}
	GunCheckTime[playerid] = 5;
	SetPVarInt(playerid,"ALANTICRASH",GetPVarInt(playerid,"ALANTICRASH") + 1);
    if(GetPVarInt(playerid,"ALANTICRASH") > 1) return ALKick(playerid);
	PlayerOnJob[playerid] = false;
	PlayerStartJob[playerid] = false;
	GetPlayerMetall[playerid] = 0;
	AllPlayerMetall[playerid] = 0;
	GetPlayerMetallEx[playerid] = 0;
	AllPlayerMetallEx[playerid] = 0;
	ExtraMetall[playerid] = 0;
	return true;
}

public OnVehicleSpawn(vehicleid)
{
	if(IsBicycle(vehicleid) && IsBoat(vehicleid) && IsFly(vehicleid)) ToggleEngine(vehicleid, VEHICLE_PARAMS_ON);
	else ToggleEngine(vehicleid, VEHICLE_PARAMS_OFF);
	VehHealth[vehicleid] = 1000.0;
	return true;
}

public OnPlayerText(playerid, text[])
{
	new string[128];
	if(PlayerInfo[playerid][pMuteTime] > 0) { SendMuteMessage(playerid); return false; }
	if(CapsLockCheck(text)) { SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ����� ��������� ������� ����� ��������� ����!");  return false; }
	if(IsIP(text) || CheckString(text) || CheckMsg(text))  { SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!"); return false; }
	if(InviteLive[playerid] != -1 && InviteLive[playerid] != -2)
	{
		format(string,sizeof(string),"{CA8E1D}[����]{FFFFFF} {30E554}%s[%d]: %s",PlayerInfo[playerid][pName],playerid,text);
		SendClientMessageToAll(-1,string);
		return false;
	}
	else
	{
		if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"{0B6118}%s[%d] �������:{FFFFFF} %s",PlayerInfo[playerid][pName],playerid,text);
		else format(string,sizeof(string),"{0B6118}����������� �������:{FFFFFF} %s",text);
		SendRadiusMessage(15.0, playerid, string, -1);
		return false;
	}
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(cuff[playerid] == true)
	{
		SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������ ����� � ������ � ����������");
		RemovePlayerFromVehicle(playerid);
	}
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED) {
		SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������ ����� � ������ ���������");
		RemovePlayerFromVehicle(playerid);
	}	
	GunCheckTime[playerid] = 5;
	incar[playerid] = true;
	GetVehiclePos(vehicleid, ReadPlayerPosition[playerid][ReadX], ReadPlayerPosition[playerid][ReadY], ReadPlayerPosition[playerid][ReadZ]);
	return true;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(cuff[playerid] == true)
	{
		SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������ ������� �� ������ � ����������");
		PutPlayerInVehicle(playerid,vehicleid,1);
	}
	incar[playerid] = false;
	GunCheckTime[playerid] = 5;
	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if((newstate == 2 && oldstate == 3) || (newstate == 3 && oldstate == 2)) return ALKick(playerid);
	if(newstate == PLAYER_STATE_DRIVER)
	{
		SpeedON(playerid,2);
		PlayerEnterTime[playerid] = GetTickCount();
		new vehicle = GetPlayerVehicleID(playerid);
		new engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, boot, objective);
		if(IsFly(vehicle) && PlayerInfo[playerid][pLic][3] == false) { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� �������� �� ���������� ������ �����������! ������ � ����� � ���������!"); RemovePlayerFromVehicle(playerid); }
		if(IsBoat(vehicle) && PlayerInfo[playerid][pLic][2] == false) { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� �������� �� ���������� ������ �����������! ������ � ����� � ���������!"); RemovePlayerFromVehicle(playerid); }
		if(!IsFly(vehicle) && !IsBicycle(vehicle)  && !IsBoat(vehicle) && engine == 0) { SendClientMessage(playerid,-1,"{FFFFFF}� ���� ������ {F31212}��������{FFFFFF} ���������,����� ������� ��� ����������� "GRN"������"); }
		if(vehicle >= furaveh[0] && vehicle <= furaveh[7])
		{
		    if(PlayerInfo[playerid][pJob] != 2) { SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ���� ��������� �������� ������ ��� ��������������!"); ClearAnimations(playerid); }
			SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} ��� ���� ����� ������ ������ ������� ���� (/delivery). ����� �������� �� �����!");
            cpdeliv[playerid] = CreateDynamicCP(-113.7627,-326.2541,1.4297,3.0,0,0,playerid,100000);
		}
		if(vehicle >= combinecar[0] && vehicle <= combinecar[3])
		{
		    if(PlayerInfo[playerid][pJob] != 3) { SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ���� ��������� �������� ������ ��� ����������!"); ClearAnimations(playerid); }
			SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} ������ �� ���� � ������� �����!");
		}
		if(AutoInfo[GetVehicleId(GetPlayerVehicleID(playerid))][aFraction] == 0 && PlayerInfo[playerid][pStartAsh] == 1 && vehicle >= ash[0] && vehicle <= ash[1])
		{
			SetPlayerCheckpoint(playerid, -2061.9529, -97.2926, 35.1641, 3.0);
			PlayerInfo[playerid][pStartAsh] = 2;
			SendClientMessage(playerid, 0xFF0000AA, "{133894}[��������]{FFFFFF} ����������� � ������");
		}
		if(vehicle >= taxi[1] && vehicle <= taxi[6])
		{
			if(PlayerInfo[playerid][pJob] != 6) { SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ���� ��������� �������� ������ ��� ���������!"); ClearAnimations(playerid); }
			SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} ��������� /fare,����� ����� �� ������!");
		}
		if(vehicle >= ash[0] && vehicle <= ash[1])
		{
			if(PlayerInfo[playerid][pStartAsh] == 0) { ClearAnimations(playerid); }
		}
		new string[128];
		if(AutoInfo[GetVehicleId(GetPlayerVehicleID(playerid))][aFraction] != GetPlayerMember(playerid))
		{
			new Float:slx, Float:sly, Float:slz;
			GetPlayerPos(playerid, slx, sly, slz);
			ServerSetPlayerPos(playerid, slx, sly, slz+5);
			SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� �� �������� ���� ���������!");
			return true;
		}
		if(AutoInfo[GetVehicleId(GetPlayerVehicleID(playerid))][aRank] > PlayerInfo[playerid][pRank] && AutoInfo[GetVehicleId(GetPlayerVehicleID(playerid))][aFraction] == GetPlayerMember(playerid))
		{
			RemovePlayerFromVehicle(playerid);
			format(string,sizeof(string),"{F31212}[������]{FFFFFF} ��� ���� �� ���� ���������� ��� ����� {15A3C6}%d{FFFFFF} ����",AutoInfo[GetPlayerVehicleID(playerid)][aRank]);
			SendClientMessage(playerid,-1,string);
		}
		if(AutoInfo[GetVehicleId(GetPlayerVehicleID(playerid))][aJob] > 0 &&  AutoInfo[GetVehicleId(GetPlayerVehicleID(playerid))][aJob] != PlayerInfo[playerid][pJob]) { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� �� �������� ���� ���������!"); return true; }
		if(PlayerInfo[playerid][pLic][1] == false && PlayerInfo[playerid][pStartAsh] == 0 && !IsBicycle(vehicle) && !IsFly(vehicle) && !IsFly(vehicle) && GetVehicleModel(vehicle) != 462) { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ���� �� ���������� �����������!�������� �� ����� � ���������!"); RemovePlayerFromVehicle(playerid); }
	}
	if(newstate == PLAYER_STATE_PASSENGER)
	{
	    if(cuff[playerid] == true) RemovePlayerFromVehicle(playerid);
		new vehicle = GetPlayerVehicleID(playerid);
		if(vehicle >= taxi[1] && vehicle <= taxi[6])
		{
			foreach(Player,i)
			{
				new playerState1 = GetPlayerState(i);
				if(GetPlayerVehicleID(i) == vehicle && playerState1 == PLAYER_STATE_DRIVER)
				{
					moneyzaproezd[i] += proezd[i];
					SetMoney(playerid,-proezd[i]);
					passanger[playerid] = i;
					new string[128];
					format(string,sizeof(string),"������ %s[%d] ��� � ���� �����",PlayerInfo[playerid][pName],playerid);
					SendClientMessage(i,COLOR_LIGHTBLUE,string);
					format(string,sizeof(string),"�� ���� � ����� � %s[%d]",PlayerInfo[i][pName],i);
					SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				}
			}
		}
	}
	if(oldstate == PLAYER_STATE_PASSENGER)
	{
		if(passanger[playerid] != -1)
		{
			SetMoney(passanger[playerid],moneyzaproezd[passanger[playerid]]);
			new string[128];
			format(string,sizeof(string),"�� �������� � ����� � ��������� %d$",moneyzaproezd[passanger[playerid]]);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			format(string,sizeof(string),"������ ����� �� ������ ����� � �������� %d$",moneyzaproezd[passanger[playerid]]);
			SendClientMessage(passanger[playerid],COLOR_LIGHTBLUE,string);
			moneyzaproezd[passanger[playerid]] = 0;
			passanger[playerid] = -1;
		}
	}
	if(newstate == PLAYER_STATE_ONFOOT) SpeedOFF(playerid);
	return true;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(GetPVarInt(playerid, "locate") == 1) { DisablePlayerCheckpoint(playerid); DeletePVar(playerid, "locate"); }
	if(IsPlayerInRangeOfPoint(playerid,3.0,2741.0037,-2009.3300,13.2609))
	{
		if(GetPlayerState(playerid) == 2)
		{
			new veh = GetPlayerVehicleID(playerid);
			if(dengi[veh] > 0)
			{
				SetMoney(playerid,dengi[veh]);
				new string[128];
				format(string,sizeof(string),"�� ������� ������ %s$",ConvertCash(dengi[veh]));
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				dengi[veh] = 0;
				DisablePlayerCheckpoint(playerid);
			}
		}
	}
	if(gps[playerid] == true) 	{ DisablePlayerCheckpoint(playerid); gps[playerid] = false; }
	if(IsPlayerInRangeOfPoint(playerid,5.0, -1060.3180,-1205.4827,129.2188))
	{
	  	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 532)
	  	{
			if(combine[GetPlayerVehicleID(playerid)] == 0) return true;
			PlayerInfo[playerid][pZP] += 250;
			SendClientMessage(playerid,-1,"�� ����� �� ����� {F31212}100{FFFFFF} ����� � �������� �� ��� {F31212}250$ � ��������{FFFFFF}");
			format(trava1,sizeof(trava1),"����� �� ������: %d",Trava[kolvo]);
			Infa[iiTrava] += 100;
			UpdateInfa();
			DisablePlayerCheckpoint(playerid);
			combine[GetPlayerVehicleID(playerid)] = 0;
	   		return true;
	   	}
	}
	if(IsPlayerInRangeOfPoint(playerid,3.0, -1549.4137,124.1063,3.5547))
	{
		new money[MAX_PLAYERS];
		switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
		{
			case 400,404,466,507,527,496,401,410,422,426,436,442,448,457,458,462,474,478,479,485,491,492,516,517,518,525,528,529,530,540,543,546,547,549,550,575,576,585,600,604,605: money[playerid] = 10000;
			case 566,589,523,405,412,416,419,420,421,438,441,445,467,471,475,504,526,536,539,542,551,552,567,571,580,581,582,583,586,588: money[playerid] = 15000;
			case 596,597,598,603,602,565,558,533,500,424,434,439,463,468,480,534,535,545,554,555,561,568,587,502,503,402,409,411,415,429,444,451,461,477,494,506,521,522,541,556,557,559,560,562: money[playerid] = 20000;
			case 601,514,515,505,498,499,403,406,407,408,413,414,418,423,427,428,431,432,433,437,440,443,455,456,459,470,482,483,486,489,490,495,508,524,531,532,544,572,573,574,578,579,599,609: money[playerid] = 25000;
		}
		DestroyVehicle(PlayerInfo[playerid][pCar]);
		new msg[144];
		format(msg,sizeof(msg),"�� ����� %s � �������� %d$",VehicleNames[PlayerInfo[playerid][pCar]-400],money[playerid]);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,msg);
		PlayerInfo[playerid][pCar] = 0;
		PlayerInfo[playerid][pCarM] = 0;
		RemoveTune(playerid);
		SetMoney(playerid,money[playerid]);
		Infa[iiMetall] += 300;
		UpdateInfa();
	}
	if(point) DisablePlayerCheckpoint(playerid);
	if(PlayerStartJob[playerid])
	{
	    new string[128];
	    DisablePlayerCheckpoint(playerid);
		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 1);
		PlayerStartJob[playerid] = false;
	    RemovePlayerAttachedObject(playerid, 6);
	    SetPlayerAttachedObject(playerid, 3, 18634, 6, 0.078222, 0.000000, 0.110844, 298.897308, 264.126861, 193.350555, 1.000000, 1.000000, 1.000000);
	    GetPlayerMetall[playerid] = 20+random(40);
        AllPlayerMetall[playerid] = AllPlayerMetall[playerid] + GetPlayerMetall[playerid];
        format(string, sizeof(string), "�� �������� {FFA500}%d{FFFFFF} ��. �������� �������.", GetPlayerMetall[playerid]);
	    SendClientMessage(playerid, -1, string);
	  	format(string, sizeof(string), "+%d", GetPlayerMetall[playerid]);
	  	SetPlayerChatBubble(playerid, string, 0x00FF00FF, 20.0, 3000);
		PlayerInfo[playerid][pZP] += GetPlayerMetall[playerid]*3;
	   	GetPlayerMetall[playerid] = 0;
	    format(string, sizeof(string), "����� ��������� �������: {FFA500}��������: {FFFFFF}%d", AllPlayerMetall[playerid]);
	    SendClientMessage(playerid, -1, string);
		Infa[iiMetall] += AllPlayerMetall[playerid];
		UpdateInfa();
		RemovePlayerAttachedObject(playerid, 6);
		return true;
	}
	return true;
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
	for(new d=0; d < sizeof(drugsposition); d++)
	{
    	if(pickupid != drugspickupid[d]) continue;
   		if(PlayerInfo[playerid][pJob] != 3) return true;
   		new vehicle = GetPlayerVehicleID(playerid);
		if(combine[vehicle] >= 90) return true;
   		if(GetVehicleModel(vehicle) != 532) return true;
   		if(combine[GetPlayerVehicleID(playerid)] >= 90) { GameTextForPlayer(playerid, "������� �����.���� ����� �� �����", 2000, 4); SetPlayerCheckpoint(playerid, -1060.3180,-1205.4827,129.2188,5.0); return true; }
   		combine[GetPlayerVehicleID(playerid)] += 10;
   		new text[64];
      	format(text, sizeof(text), "����� %d/100",combine[GetPlayerVehicleID(playerid)]);
      	GameTextForPlayer(playerid, text, 2000, 4);
    }
	return true;
}
public OnPlayerSelectedMenuRow(playerid, row)
{
	if(GetPlayerMenu(playerid) == Admin)
	{
		new ClickedPlayerName[30]; GetPlayerName(SpecAd[playerid],ClickedPlayerName,24);
		switch(row)
		{
		case 0: StartSpectate(playerid,SpecAd[playerid]), ShowMenuForPlayer(Admin,playerid);
		case 1:ShowPlayerDialog(playerid,DIALOG_SPEC_KICK,DIALOG_STYLE_INPUT,"���","������� �������","���","������"), ShowMenuForPlayer(Admin,playerid);
		case 2:ShowPlayerDialog(playerid,DIALOG_SPEC_WARN,DIALOG_STYLE_INPUT,"����","������� �������","����","������"), ShowMenuForPlayer(Admin,playerid);
		case 3:ShowPlayerDialog(playerid,DIALOG_SPEC_BAN,DIALOG_STYLE_INPUT,"���","������� �������","���","������"), ShowMenuForPlayer(Admin,playerid);
		case 4:
			{
				new Float:shealth, Float:slx, Float:sly, Float:slz, name[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid ,name , sizeof(name));
				GetPlayerName(SpecAd[playerid] ,sendername , sizeof(sendername));
				GetPlayerHealth(SpecAd[playerid], shealth);
				ServerSetPlayerHealth(SpecAd[playerid], shealth-5);
				GetPlayerPos(SpecAd[playerid], slx, sly, slz);
				SetPlayerPos(SpecAd[playerid], slx, sly, slz+5);
				PlayerPlaySound(SpecAd[playerid], 1130, slx, sly, slz+5);
				new string[128];
				format(string, sizeof(string), "����� %s ��� ����� %s",name,sendername);
				SendAdminMessage(COLOR_LIGHTRED,string,1);
				SendClientMessage(SpecAd[playerid], COLOR_LIGHTRED, string);
				ShowMenuForPlayer(Admin,playerid);
			}
		case 5:
			{
				new mess[128];
				format(mess, sizeof(mess), "/check %i",SpecAd[playerid]);
				CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);
				ShowMenuForPlayer(Admin,playerid);
			}
		case 6:
			{
				new giveplayer[128];
				new playersip[20];
				GetPlayerName(SpecAd[playerid], giveplayer, sizeof(giveplayer));
				GetPlayerIp(SpecAd[playerid],playersip,sizeof(playersip));
				new string[128];
				format(string, sizeof(string), "[%s] IP: %s",giveplayer,playersip);
				SendClientMessage(playerid,0x6495EDFF,string);
				ShowMenuForPlayer(Admin,playerid);
			}
		case 7:
			{
				if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_WHITE, "��� ����� ����� 2 ��� ���. � ����"); ShowMenuForPlayer(Admin,playerid);
				new mess[40];
				format(mess, sizeof(mess), "/gm %i",SpecAd[playerid]);
				CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);
				ShowMenuForPlayer(Admin,playerid);
			}
		case 8:
			{
				if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
				{
					ShowMenuForPlayer(Admin,playerid);
					StopSpectate(playerid);
					SetPlayerHealth(playerid, 100);
				}
			}
		}
	}
	return true;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	if(GetPlayerInterior(playerid) == 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && PlayerInfo[playerid][pAdmin] == 0) return ALKick(playerid);
    if(PlayerInfo[playerid][pCar] == vehicleid)
	{
		new c = componentid;
	    if( (c >= 1000 && c <= 1003) || (c >= 1014 && c <= 1016) || c == 1023 || c == 1049 || c == 1050 || c ==1058 ||
			 c == 1060 || c == 1138 || c == 1139 || c == 1146 || c == 1147 || c == 1158 || (c >= 1162 && c <= 1164)) PlayerInfo[playerid][pSpoiler] = c;
	    else if (c== 1004 || c == 1005 || c == 1011 || c == 1012) PlayerInfo[playerid][pHood] = c;
	    else if (c== 1007 || c == 1017 || c == 1026 || c == 1027 || c == 1030 || c == 1031 || c == 1036 ||
				(c >= 1039 && c <= 1042) || c == 1047 || c == 1048 || c == 1051 || c == 1052 || c == 1056 ||
				 c == 1057 || c == 1062 || c == 1063 || ( c >= 1069 && c <= 1072) || c == 1090 || ( c >= 1093 && c <= 1095) ||
				 c == 1099 || c == 1101 || c == 1102 || ( c >= 1106 && c <= 1108) || ( c >= 1119 && c <= 1122) || c == 1124 || c == 1133 || c == 1134 || c == 1137)  PlayerInfo[playerid][pSideskirt] = c;
	    else if (c >= 1008 && c <= 1010) PlayerInfo[playerid][pNitro] = c;
	    else if (c == 1013 || c == 1024) PlayerInfo[playerid][pLamps] = c;
	   	else if (( c >= 1018 && c <= 1022) || c == 1028 || c == 1029 || c == 1034 || c == 1037 ||
	   			( c >= 1043 && c <= 1046) || c == 1059 || ( c >= 1064 && c <= 1066) ||
				  c == 1089 || c == 1092 || c == 1004 || c == 1105 || c == 1113 || c == 1114 ||
				  c == 1126 || c == 1127 || c == 1129 || c == 1132 || c == 1135 || c == 1136) PlayerInfo[playerid][pExhaust] = c;
	    else if (c == 1025 || ( c >= 1073 && c <= 1085) || ( c >= 1096 && c <= 1098)) PlayerInfo[playerid][pWheels] = c;
	    else if (c == 1006 ||  c == 1032 || c == 1033 || c == 1035 || c == 1038 || (c >= 1053 && c <= 1055) ||
				 c == 1061 || c == 1067 || c == 1068  || c == 1088 || c == 1091 || c == 1103 || c == 1128 || c == 1130 || c == 1131 ) PlayerInfo[playerid][pRoof] = c;
	    else if (c == 1086)  PlayerInfo[playerid][pStereo] = c;
	    else if (c == 1087) PlayerInfo[playerid][pHydraulics] = c;
	    else if (c == 1100 || c == 1123 || c == 1125) PlayerInfo[playerid][pBullbar] = c;
	    else if (c == 1109 || c == 1110) PlayerInfo[playerid][pRearBullbars] = c;
	    else if (c == 1111 || c == 1112) PlayerInfo[playerid][pFrontSign] = c;
	    else if (c == 1115 || c == 1116) PlayerInfo[playerid][pFrontBullbars] = c;
	    else if (c == 1117 || c == 1152 || c == 1153 || c == 1155 || c == 1157 || c == 1160 || c == 1165 || c == 1166 ||
				(c >= 1169 && c <= 1174) || c == 1176 || c == 1179 || c == 1181 || c == 1182 || c == 1185 || (c >= 1188 && c <= 1191))  PlayerInfo[playerid][pFrontBumper] = c;
	    else if (c == 1140 || c == 1141 || (c >= 1148 && c <= 1151) || c == 1154 || c == 1156 || c == 1159 || c == 1161 || c == 1167 ||
				 c == 1168 || c == 1175 || c == 1177 || c == 1178 || c == 1180 || c == 1183 || c == 1184 || c == 1186 || c == 1187 || c == 1192 || c == 1193)  PlayerInfo[playerid][pRearBumper] = c;
	    else if (c >= 1142 && c <= 1145) PlayerInfo[playerid][pVents] = c;
	    SaveAccount(playerid);
	}
	return true;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	if(PlayerInfo[playerid][pCar] > 0) PlayerInfo[playerid][pPaintJob] = paintjobid;
	return true;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	if(PlayerInfo[playerid][pCar] > 0) { PlayerInfo[playerid][pCC1] = color1;PlayerInfo[playerid][pCC2] = color2; }
	return true;
}
public OnPlayerStreamIn(playerid, forplayerid)
{
	if(PlayerInfo[playerid][pMask] == true) ShowPlayerNameTagForPlayer(forplayerid, playerid, 0);
	return true;
}

public OnPlayerStreamOut(playerid, forplayerid) return true;
public OnVehicleStreamIn(vehicleid, forplayerid) return true;
public OnVehicleStreamOut(vehicleid, forplayerid) return true;

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	//if(GetPVarInt(playerid,"ALANTICRASH1") != dialogid) return ALKick(playerid);
	for(new i, s = strlen(inputtext); i < s; i ++) if(inputtext[i] == '%') inputtext[i] = '#';
	switch(dialogid)
	{
        case DIALOG_LOGIN:
		{
            if(!response) { SendClientMessage(playerid, COLOR_YELLOW, "������� /q(uit), ����� ����� �� ����.");  ALKick(playerid); return true; }
            if(!strlen(inputtext)) ShowLogin(playerid);
			LoadAccount(playerid, inputtext);
        }
        case DIALOG_REGISTER:
		{
            if(!response)
			{
                SendClientMessage(playerid, COLOR_YELLOW, "������� /q(uit), ����� ����� �� ����.");
                ALKick(playerid);
                return 1;
            }
            if(!strlen(inputtext) || strlen(inputtext) < 6 || strlen(inputtext) > 32) ShowRegister(playerid);
			CreateAccount(playerid, inputtext);
			PlayerInfo[playerid][pLogged] = true;
        }
        case DIALOG_WRONGPAS:
		{
            if(response) ShowLogin(playerid);
            else { ALKick(playerid); return true; }
        }
		case DIALOG_BAN_INFO:
		{
			if(response)
			{
				new dialog[500], name[21], ip[16], bandate[15], id,	time, unbandate, reason[100], result[255],str[255];
				format(str, sizeof(str), "SELECT * FROM bans WHERE name = '%s'", inputtext);
				if(mysql_query(str) && mysql_store_result())
				{
					if(mysql_fetch_row_format(result))
					{
						sscanf(result, "p<|>ds[34]s[16]s[15]dds[100]",id, name, ip, bandate, time, unbandate, reason);
						strmid(player[playerid], inputtext, 0, 20, 21);
						format(str, sizeof(str), "{FFFF00}���: {FFFFFF}%s. {FFFF00}IP: {FFFFFF}%s\n", name, ip);
						strcat(dialog, str);
						format(str, sizeof(str), "{FFFF00}���� ����: {FFFFFF}%s\n", bandate);
						strcat(dialog, str);
						format(str, sizeof(str), "{FFFF00}���� ����: {FFFFFF}%d\n", time);
						strcat(dialog, str);
						format(str, sizeof(str), "{FFFF00}������: {FFFFFF}%s\n", fromUnixTime(unbandate));
						strcat(dialog, str);
						format(str, sizeof(str), "{FFFF00}������� ����: {FFFFFF}%s", reason);
						strcat(dialog, str);
						SPD(playerid, DIALOG_UNBAN, DIALOG_STYLE_MSGBOX, ""PREFIX" �������", dialog, "���������", "�������");
					}
				}
				mysql_free_result();
				return true;
			}
		}
		case DIALOG_UNBAN:
		{
			if(response)
			{
				new str[255];
				format(str, sizeof(str), "DELETE FROM bans WHERE name = '%s'", player[playerid]);
				mysql_query(str);
				format(str, sizeof(str), "������� %s �������������!", player[playerid]);
				SendClientMessage(playerid, 0xFF0000AA, str);
				return true;
			}
		}
		case DIALOG_HU:
		{
			if(response)
			{
				new h = PlayerInfo[playerid][pHouse];
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_HU_HEAL,DIALOG_STYLE_LIST,""PREFIX"��������","{3CBBF7}[1]{FFFFFF}\t100($1500)\n{3CBBF7}[2]{FFFFFF}\t120($2500)\n{3CBBF7}[3]{FFFFFF}\t160($5000)","OK","");
					case 1:  HouseInfo[h][hArmour] = true;
				}
			}
		}
		case DIALOG_HU_HEAL:
		{
			if(listitem == 0)
			{
				new h = PlayerInfo[playerid][pHouse];
				if(PlayerInfo[playerid][pMoney] < 1500) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ����� ��� �������!");
				HouseInfo[h][hHeal] = 100;
				SetMoney(playerid,-1500);
			}
			else if(listitem == 1)
			{
				new h = PlayerInfo[playerid][pHouse];
				if(PlayerInfo[playerid][pMoney] < 2500) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ����� ��� �������!");
				HouseInfo[h][hHeal] = 120;
				SetMoney(playerid,-2500);
			}
			else if(listitem == 2)
			{
				new h = PlayerInfo[playerid][pHouse];
				if(PlayerInfo[playerid][pMoney] < 5000) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ����� ��� �������!");
				HouseInfo[h][hHeal] = 160;
				SetMoney(playerid,-5000);
			}
		}
		case DIALOG_BANK:
		{
			if(!response) return true;
			switch(listitem)
			{
				case 0: ShowBankomat(playerid);
				case 1: SPD(playerid,DIALOG_BANK_SNYAT,DIALOG_STYLE_INPUT,""PREFIX" ����� �� �����","{FFFFFF}������� �����,������� ������ {1A5611}�����{FFFFFF}","OK","������");
				case 2: SPD(playerid,DIALOG_BANK_POLOZH,DIALOG_STYLE_INPUT,""PREFIX" �������� �� ����","{FFFFFF}������� �����,������� ������ {1A5611}��������{FFFFFF}","OK","������");
				case 3: SPD(playerid,DIALOG_BANK_PEREVOD,DIALOG_STYLE_INPUT,""PREFIX" ������� �����","{FFFFFF}������� ID ������ ��� {1A5611}��������{FFFFFF} �����","OK","������");
			}
		}
		case DIALOG_BANK_SNYAT:
		{
			if(response)
			{
				new summa = strval(inputtext),string[512];
				if(summa > PlayerInfo[playerid][pBank]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ����� ���������� ������ ��� ����� �����!");
				if(summa < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ���������� ����� ������ 0!");
				PlayerInfo[playerid][pBank] -= summa;
				SetMoney(playerid,summa);
				format(string,sizeof(string),"{FFFFFF}�� ����� {23540A}$%d{FFFFFF}\n\n{FFFFFF}������ �������� �����: {23540A}$%d{FFFFFF}",summa,PlayerInfo[playerid][pBank]);
				SPD(playerid,DIALOG_BANK_CHECK_SNYAT,DIALOG_STYLE_MSGBOX,""PREFIX" ���������� ���",string,"OK","");
			}
		}
		case DIALOG_BANK_POLOZH:
		{
			if(response)
			{
				new summa = strval(inputtext),string[512];
				if(summa > GetMoney(playerid)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������ ���������� ��������!");
				if(summa < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ���������� �������� ������ 0!");
				SetMoney(playerid,-summa);
				PlayerInfo[playerid][pBank] += summa;
				format(string,sizeof(string),"{FFFFFF}�� �������� {147130}$%d{FFFFFF}\n\n{FFFFFF}������ �������� �����: {23540A}$%d{FFFFFF}",summa,PlayerInfo[playerid][pBank]);
				SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" ���������� ���",string,"OK","");
			}
		}
		case DIALOG_SPEC_KICK:
		{
			if(!response) return true;
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				new mess[128];
				format(mess, sizeof(mess), "/kick %i %s",SpecAd[playerid],inputtext);
				CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);
			}
		}
		case DIALOG_SPEC_WARN:
		{
			if(!response) return true;
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
				new mess[128];
				format(mess, sizeof(mess), "/warn %i %s",SpecAd[playerid],inputtext);
				CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);
			}
		}
		case DIALOG_SPEC_BAN:
		{
			if(!response) return true;
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
				new mess[128];
				format(mess, sizeof(mess), "/ban %i %s",SpecAd[playerid],inputtext);
				CallLocalFunction("OnPlayerCommandText", "is", playerid, mess);
			}
		}
		case DIALOG_ADD:
		{
		    if(!response) return true;
			switch(listitem)
			{
			    case 0: _addbank(playerid,"");
			    case 1:	SPD(playerid,DIALOG_ADD_HOUSE,DIALOG_STYLE_INPUT,""PREFIX"���������� ����",""WHT"����� ������� ��� ����:","����","�����");
			    case 2: _addkfc(playerid,"");
			    case 3: _addgas(playerid,"");
			}
			return true;
		}
		case DIALOG_ADD_HOUSE:
		{
		    if(!response) return SPD(playerid,DIALOG_ADD,DIALOG_STYLE_LIST,""PREFIX" ADD SYSTEM","[1] �������� ��������\n[2] �������� ���\n[3] �������� ����������\n[4] �������� ��������","�����","�����");
			new mess[128];
			format(mess, sizeof(mess), "/addhouse %i",inputtext);
			CallLocalFunction("OnPlayerCommandText", "i", playerid, mess);
		}
		case DIALOG_RACE:
		{
			if(!response) return true;
			new i = GetPVarInt(playerid, "race");
			switch(Race[i][CountM])
			{
			    case 0: strmid(Race[i][Who1], PlayerInfo[playerid][pName], 0, 64, 64);
			    case 1: strmid(Race[i][Who2], PlayerInfo[playerid][pName], 0, 64, 64);
			    case 2: strmid(Race[i][Who3], PlayerInfo[playerid][pName], 0, 64, 64);
			    case 3: strmid(Race[i][Who4], PlayerInfo[playerid][pName], 0, 64, 64);
			    case 4: strmid(Race[i][Who5], PlayerInfo[playerid][pName], 0, 64, 64);
			}

			Race[i][CountM]++;
			Race_PlayerJoin(playerid, i);
			if(Race[i][TimerP] == false) { Race[i][Timer] = SetTimerEx("RaceTimer", 60000, false, "i", i); Race[i][TimerP] = true; }
			if(Race[i][CountM] == Race[i][Max]) {
				Race_Start(i);
				Race[i][Reg] = false;
				Race[i][CountM] = 0;
				Race[i][Max] = 0;
				Race[i][TimerP] = false;
				KillTimer(Race[i][Timer]);
			}
			return true;
		}
		case DIALOG_RADIO:
		{
			if(response)
  			{
		 		switch(listitem)
		 		{
					case 0: PlayAudioStreamForPlayer(playerid,"http://www.zaycev.fm:9001/rnb/ZaycevFM(128)");
					case 1: PlayAudioStreamForPlayer(playerid,"http://webcast.emg.fm:55655/europaplus128.mp3");
					case 2: PlayAudioStreamForPlayer(playerid,"http://radio.maks-fm.ru:8000/maksfm128.m3u");
					case 3: PlayAudioStreamForPlayer(playerid,"http://host.fm:7777/18859_alpino.m3u");
					case 4: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/RnB128.mp3");
					case 5: PlayAudioStreamForPlayer(playerid,"http://www.radioroks.com.ua/RadioROKS.m3u");
					case 6: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/Kazantip128.mp3");
					case 7: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/pophit128.mp3");
					case 8: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/retro128.mp3");
					case 9: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/rockmusic128.mp3");
					case 10: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/RusLyrics128.mp3");
					case 11: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/rep128.mp3");
					case 12: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/Rus-pop128.mp3");
					case 13: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/top-100-kiev128.mp3");
					case 14: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/PopRock128.mp3");
					case 15: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/UkrPophit128.mp3");
					case 16: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/hip-hop128.mp3");
					case 17: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/Alternative_Rock128.mp3");
					case 18: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/country128.mp3");
					case 19: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/dance128.mp3");
					case 20: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/Disco128.mp3");
					case 21: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/DrumAndBass128.mp3");
					case 22: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/dubstep128.mp3");
					case 23: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/Electro-House128.mp3");
					case 24: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/HardRock128.mp3");
					case 25: PlayAudioStreamForPlayer(playerid,"http://music.myradio.com.ua:8000/heavymetal128.mp3");
					case 26: StopAudioStreamForPlayer(playerid);
   				}
  			}
			else return true;
		}
		case DIALOG_BANINFO:
		{
			if(!response) return true;
			new string[128];
			new i = GetPVarInt(playerid,"idban");
			format(string,sizeof(string),"%s �������(�) %s �� %d ����. �������: %s",PlayerInfo[i][pName],Exii[listitem][exDay],Exii[listitem][exReason]);
			SendClientMessageToAll(COLOR_LIGHTRED,string);
			return true;
		}
		case DIALOG_GIVEGUN:
		{
			if(!response) return true;
			new id = strval(inputtext);
			if(id < 0 || id > MAX_PLAYERS) return true;
			if(!IsPlayerConnected(id)) return Err(playerid,"����� �� � ����");
			switch(GetPVarInt(playerid,"modelid"))
            {
                case 331: ServerGivePlayerWeapon(id, 1, 999);
                case 333: ServerGivePlayerWeapon(id, 2, 999);
                case 334: ServerGivePlayerWeapon(id, 3, 999);
                case 335: ServerGivePlayerWeapon(id, 4, 999);
                case 336: ServerGivePlayerWeapon(id, 5, 999);
                case 337: ServerGivePlayerWeapon(id, 6, 999);
                case 338: ServerGivePlayerWeapon(id, 7, 999);
                case 339: ServerGivePlayerWeapon(id, 8, 999);
                case 341: ServerGivePlayerWeapon(id, 9, 999);
                case 321: ServerGivePlayerWeapon(id, 10, 999);
                case 325: ServerGivePlayerWeapon(id, 14, 999);
                case 326: ServerGivePlayerWeapon(id, 15, 999);
                case 342: ServerGivePlayerWeapon(id, 16, 999);
                case 343: ServerGivePlayerWeapon(id, 17, 999);
                case 344: ServerGivePlayerWeapon(id, 18, 999);
                case 346: ServerGivePlayerWeapon(id, 22, 999);
                case 347: ServerGivePlayerWeapon(id, 23, 999);
                case 348: ServerGivePlayerWeapon(id, 24, 999);
                case 349: ServerGivePlayerWeapon(id, 25, 999);
                case 350: ServerGivePlayerWeapon(id, 26, 999);
                case 351: ServerGivePlayerWeapon(id, 27, 999);
                case 352: ServerGivePlayerWeapon(id, 28, 999);
                case 353: ServerGivePlayerWeapon(id, 29, 999);
                case 355: ServerGivePlayerWeapon(id, 30, 999);
                case 356: ServerGivePlayerWeapon(id, 31, 999);
                case 372: ServerGivePlayerWeapon(id, 32, 999);
                case 357: ServerGivePlayerWeapon(id, 33, 999);
                case 358: ServerGivePlayerWeapon(id, 34, 999);
                case 359: ServerGivePlayerWeapon(id, 35, 999);
                case 360: ServerGivePlayerWeapon(id, 36, 999);
                case 361: ServerGivePlayerWeapon(id, 37, 999);
                case 362: ServerGivePlayerWeapon(id, 38, 999);
                case 363: { ServerGivePlayerWeapon(id, 39, 999); ServerGivePlayerWeapon(id, 40, 1); }
                case 365: ServerGivePlayerWeapon(id, 41, 999);
                case 366: ServerGivePlayerWeapon(id, 42, 999);
            }
			new string[128];
			format(string,sizeof(string),"�� ���� %s[%d] ������",PlayerInfo[id][pName],id);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		}
		case DIALOG_BANK_PEREVOD:
		{
			if(response)
			{
				comu[playerid] = strval(inputtext);
				new string[128];
				format(string,sizeof(string),"{FFFFFF}�� ����� �����: {147130}%s{FFFFFF}$. ������� ����� ��� ��������",ConvertCash(PlayerInfo[playerid][pBank]));
				SPD(playerid,DIALOG_COMU,DIALOG_STYLE_INPUT,""PREFIX" ������� �����","����� ����� ��������","���","������");
			}
		}
		case DIALOG_BANK_OPLATA:
		{
			if(!response) return true;
			if(strval(inputtext) <= 0) return true;
			if(strval(inputtext) > PlayerInfo[playerid][pMoney]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������� �����!");
			PlayerInfo[playerid][pTakeMoney] -= strval(inputtext);
			SetMoney(playerid,-strval(inputtext));
			new string[128];
			format(string,sizeof(string),"�� �������� ����� � ������� %s$. ����� ���: %s$",ConvertCash(strval(inputtext)),ConvertCash(PlayerInfo[playerid][pTakeMoney]));
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			return true;
		}
		case DIALOG_COMU:
		{
			if(response)
			{
				if(PlayerInfo[playerid][pBank] < strval(inputtext)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������� ����� � �����!");
				new id = comu[playerid];
				PlayerInfo[id][pBank] += strval(inputtext);
				PlayerInfo[playerid][pBank] -= strval(inputtext);
				new string[128];
				format(string,sizeof(string),"%s[%d] �������� �� ��� ���������� ���� %s$",PlayerInfo[playerid][pName],playerid,ConvertCash(strval(inputtext)));
				SendClientMessage(id,COLOR_LIGHTBLUE,string);
				format(string,sizeof(string),"�� ��������� %s[%d] �� ��� ���������� ���� %s$",PlayerInfo[id][pName],id,ConvertCash(strval(inputtext)));
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				comu[playerid] = -1;
				format(string,sizeof(string),"%s[%d] �������� %s[%d] %s$",PlayerInfo[playerid][pName],playerid,PlayerInfo[id][pName],id,ConvertCash(strval(inputtext)));
				WriteLog("PayLog",string);
			}
		}
		case DIALOG_INT:
		{
			if(response)
			{
				new h = GetPVarInt(playerid,"houseint");
				HouseInfo[h][hInt]  = Interiors[listitem][iInt];
				HouseInfo[h][hExitx] = Interiors[listitem][iX];
				HouseInfo[h][hExity] = Interiors[listitem][iY];
				HouseInfo[h][hExitz] = Interiors[listitem][iZ];
				SendClientMessage(playerid,-1,"{FFFFFF}�������� ���� {24650B}�������{FFFFFF} ������!");
				SaveHouse(h);
			}
		}
		case DIALOG_KFC:
		{
			if(response)
			{
				new Float:health, string[256];
				GetPlayerHealth(playerid,health);
				if(health >= 100) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ���-�� ��������!");
				switch(listitem)
				{
					case 0:
					{
						if(GetMoney(playerid) < BURGER_PRICE) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ����� ��� �������!");
						ServerSetPlayerHealth(playerid,health+15);
						SetMoney(playerid,- BURGER_PRICE);
					}
					case 1:
					{
						if(GetMoney(playerid) < CHICKEN_PRICE) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ����� ��� �������!");
						ServerSetPlayerHealth(playerid,health+10);
						SetMoney(playerid,- CHICKEN_PRICE);
					}
					case 2:
					{
						if(GetMoney(playerid) < PEPSI_PRICE) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ����� ��� �������!");
						ServerSetPlayerHealth(playerid,health+5);
						SetMoney(playerid,- PEPSI_PRICE);
					}
				}
				format(string,sizeof(string),"{FFFFFF}������ {17D6E0}[%d$]{FFFFFF}\n������ {17D6E0}[%d$]{FFFFFF}\n�����  {17D6E0}[%d$]{FFFFFF}", BURGER_PRICE,CHICKEN_PRICE,PEPSI_PRICE);
				SPD(playerid,DIALOG_KFC,DIALOG_STYLE_LIST,""PREFIX" ����������",string,"OK","�����");
			}
		}
		case DIALOG_KPK:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid, DIALOG_KPK_ACCOUNT,DIALOG_STYLE_LIST, ""PREFIX" �������", "{3CBBF7}[1]{FFFFFF}\t����������\n{3CBBF7}[2]{FFFFFF}\t������� ������ � ��������\n{3CBBF7}[3]{FFFFFF}\t���������� ������\n{3CBBF7}[4]{FFFFFF}\t���������\n{3CBBF7}[5]{FFFFFF}\t�������������� ���������� �� ��������", "�������", "������");
					case 1: ShowKpkGps(playerid);
					case 2: ShowKpkOnline(playerid);
					case 3: ShowKpkControl(playerid);
					case 4: SPD(playerid, DIALOG_HELPSRV, DIALOG_STYLE_LIST, ""PREFIX" ������ �� �������", "{3CBBF7}[1]{FFFFFF}\t������� �������\n{3CBBF7}[2]{FFFFFF}\t�������� ���������� (FAQ)", "�������", "������");
				}
			}
		}
		case DIALOG_HELPSRV: {
			if(!response) return true;
			switch(listitem) {
				case 0: SPD(playerid,DIALOG_HELP,DIALOG_STYLE_LIST,""PREFIX" ������� �������","{3CBBF7}[1]{FFFFFF}\t�������� �������\n{3CBBF7}[2]{FFFFFF}\t��������\n{3CBBF7}[3]{FFFFFF}\t������� �������������\n{3CBBF7}[4]{FFFFFF}\t������� ����\n{3CBBF7}[5]{FFFFFF}\t������� ������","�������","�����");
				case 1: SPD(playerid,DIALOG_KPK_FAQ,DIALOG_STYLE_LIST,""PREFIX" FAQ","{3CBBF7}[1]{FFFFFF}\t��� ������� LvL(�������) � EXP\n{3CBBF7}[2]{FFFFFF}\t���������� � �������","�����","������");
			}
			return true;
		}
		case DIALOG_KPK_ACCOUNT: {
			if(!response) return true;
			switch(listitem) {
				case 0: ShowStats(playerid,playerid);
				case 1: ShowChangePass(playerid);
				case 2: {
					new string[255];
					new ooc[30],family[30],pm[30];
					if(togoo[playerid] == false) { ooc = "{177D15}�������{FFFFFF} "; }
					else { ooc = "{D70808}��������"; }
					if(togf[playerid] == false) { family = "{177D15}�������{FFFFFF} "; }
					else { family = "{D70808}��������"; }
					if(togpm[playerid] == false) { pm = "{177D15}��������{FFFFFF} "; }
					else { pm = "{D70808}���������"; }
					format(string,sizeof(string),"����� ���:\t\t\t\t%s\n����������� ���:\t\t\t%s\n������������ ���������:\t\t%s",ooc,family,pm);
					SPD(playerid,DIALOG_KPK_CHAT,DIALOG_STYLE_LIST,""PREFIX" ���������� ������",string,"�������","������");
				}
				case 3: ShowInv(playerid);
				case 4: SPD(playerid,DIALOG_KPK_DOPSTAT,DIALOG_STYLE_LIST,""PREFIX" �������������","{3CBBF7}[1]{FFFFFF}\t���������� � ���������\n{3CBBF7}[2]{FFFFFF}\t���������� � ���� ����","�������","������");
			}
			return true;
		}
		case DIALOG_MAKELEADER:
		{
			if(!response) return true;
			new params[2],string[144],query[128],rank[64];
			params[0] = GetPVarInt(playerid,"idleader");
			params[1] = listitem+1;
			PlayerInfo[params[0]][pLeader] = params[1];
			PlayerInfo[params[0]][pSpawn] = 1;
			switch(PlayerInfo[playerid][pAdmin])
			{
				case 5: { rank = "���������������"; }
				case 6: { rank = "��.���������������"; }
			}
			format(string, sizeof(string), "�� ���� ��������� ������� ������� %s (��������(a): %s %s)",Fraction[params[1]][fName],rank,PlayerInfo[playerid][pName]);
			SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
			format(string, sizeof(string), "�� ��������� %s ������� ������� %s.",PlayerInfo[params[0]][pName] ,Fraction[params[1]][fName]);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			format(query, sizeof(query), "UPDATE `Fractions` SET leader='%s' WHERE id=%d", PlayerInfo[params[0]][pName], params[1]);
			strmid(Fraction[params[1]][fLeader], PlayerInfo[params[0]][pName], 0, strlen(PlayerInfo[params[0]][pName]), 255);
			PlayerInfo[params[0]][pRank] = 6;
			SetPlayerSkin(params[0],Fraction[params[1]][fSkin6]);
			ServerSetPlayerHealth(params[0],0);
			TimeOfDeath[params[0]] = true;
			PlayerInfo[params[0]][pSkin] = Fraction[params[1]][fSkin6];
			PlayerInfo[params[0]][pMember] = 0;
			PlayerInfo[params[0]][pZam] = 0;
			mysql_query(query);
			mysql_free_result();
			return true;
		}
		case DIALOG_KPK_FAQ:
		{
			if(response)
			{
				new string[1024],faq[400],faq1[450];
				switch(listitem)
				{
					case 0:
					{
						format(faq,sizeof(faq),"{FFFFFF}�� ������� ������������ ������� ������� ���������. ������� ��������� ���������� ���������� ����������� ����� �� �������\n����� �� ��������� ���� �������, ���� ����� ����������� ������� � ��������� �������, ������� ���������� ��������\n");
						format(faq1,sizeof(faq1),"��� ��, ������� ������������ �������, �� ������� �������� �� �������. ����� �������� �����, �� ������� ���������� ���� ���������.(���, ������ � �.�.)\nEXP - ��� ���������� ���������� �����, ������� ������ ����� �� ������������ ������. 1 ��� ���� = 1 EXP");
						strcat(string,faq);
						strcat(string,faq1);
						SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" ���������� � ������ � exp",string,"��","");
					}
					case 1:
					{
						format(faq,sizeof(faq),"{FFFFFF}�� ������� ���� ����� ���������� ���������� ������ ������, �������� �� ������ � ����������� ���!\n���� �� ������ ����� �� ������ � ���� �� �����, �� ����������� ��������� ���� �� ����� ������ ���:\n{12C2BF}���������{FFFFFF} - ��������� ����� � �������� �� �����\n");
						format(faq1,sizeof(faq1),"{12C2BF}������������� ������{FFFFFF} - ������ ������, ������� � ������ � ��������� �������, ����� �������� �� �����\n{12C2BF}������������{FFFFFF} - ������ ����, �������� ������ � ������������� �� ����� ������� �������, � ����� �� �����\n{12C2BF}������{FFFFFF} - ������������� �� �����, ���������� � ������� ����� � ����������� � ������ ��������!\n\
						��� ������ �� ������ ����� � {12C2BF}/kpk -> GPS ��������� -> ������{FFFFFF}");
						strcat(string,faq);
						strcat(string,faq1);
						SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" ���������� � �������",string,"��","");
					}
				}
			}
		}
		case DIALOG_KPK_DOPSTAT:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						new reason[2][64],string[255];
						if(GetPlayerMember(playerid) == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ���������� ���� ������!");
						if(PlayerInfo[playerid][pFW] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ���������!");
						strmid(reason[0],PlayerInfo[playerid][pReason],0,64,255);
						if(PlayerInfo[playerid][pFW] == 2) strmid(reason[1],PlayerInfo[playerid][pReason1],0,64,255);
						else reason[1] = "���";
						format(string,sizeof(string),"{FFFFFF}������ ������� - {19E7C9}%s{FFFFFF}\n������  ������� - {19E7C9}%s",reason[0],reason[1]);
						SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" ��������",string,"�K","������");
					}
					case 1: SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������ � ����������!");
				}
			}
		}
		case DIALOG_KPK_ONLINE:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						new line[64],leaders[512], countl;
						foreach(Player,i)
						{
							if(PlayerInfo[i][pLeader] > 0)
							{
								countl++;
								format(line, sizeof(line), "{FFFFFF}%s: %s[%d]\n",Fraction[PlayerInfo[i][pLeader]][fName],PlayerInfo[i][pName],i);
								strcat(leaders,line);
							}
						}
						if(countl > 0) SPD(playerid, 999, DIALOG_STYLE_LIST, ""PREFIX" ������ ������",leaders,"��", "");
						else SendClientMessage(playerid, C_BLUE, "� ������ ������ ��� ������� ������");
					}
					case 1:
					{
						new line[64],admins[512], counta;
						foreach(Player,i)
						{
							if(PlayerInfo[i][pAdmin] > 0)
							{
								counta++;
								format(line, sizeof(line), "{FFFFFF} %s %s[%d]\n",NameAdmin(i),PlayerInfo[i][pName],i);
								strcat(admins,line);
							}
						}
						if(counta > 0) SPD(playerid, 999, DIALOG_STYLE_LIST, ""PREFIX" �������������� ������", admins, "��", "");
						else SendClientMessage(playerid, C_BLUE, "� ������ ������ ��� ��������������� ������");
					}
					case 2:
					{
						new line[64],string[64],members[512], countle;
						foreach(Player,i)
						{
							new fam = GetPlayerMember(i);
							new fam1 = GetPlayerMember(playerid);
							if(fam == fam1 && fam != 0 && fam1 != 0)
							{
								if(PlayerInfo[i][pLeader] == fam) { strmid(string, "�����", 0, strlen("�����"), 255); }
								else if(fam == fam1)
								{
									switch(PlayerInfo[i][pRank])
									{
										case 1: strmid(string, Fraction[fam][fRank1], 0, strlen(Fraction[fam][fRank1]), 255);
										case 2:	strmid(string, Fraction[fam][fRank2], 0, strlen(Fraction[fam][fRank2]), 255);
										case 3: strmid(string, Fraction[fam][fRank3], 0, strlen(Fraction[fam][fRank3]), 255);
										case 4: strmid(string, Fraction[fam][fRank4], 0, strlen(Fraction[fam][fRank4]), 255);
										case 5: strmid(string, Fraction[fam][fRank5], 0, strlen(Fraction[fam][fRank5]), 255);
										case 6: strmid(string, Fraction[fam][fRank6], 0, strlen(Fraction[fam][fRank6]), 255);
									}
								}
								countle++;
								format(line, sizeof(line), "{FFFFFF} %s %s[%d]\n",string,PlayerInfo[i][pName],i);
								strcat(members,line);
							}
						}
						if(countle > 0) SPD(playerid, 999, DIALOG_STYLE_LIST, ""PREFIX" ����� ������� ������", members, "��", "");
						else SendClientMessage(playerid, C_BLUE, "� ������ ������ ��� ������ ����� ������� ������");
					}
					case 3:
					{
						new line[64],rank[30],helpers[512], counth;
						foreach(Player,i)
						{
							if(PlayerInfo[i][pHelper] > 0)
							{
								switch(PlayerInfo[i][pHelper])
								{
									case 1: { rank = "������ 1��."; }
									case 2: { rank = "������� ������"; }
								}
								counth++;
								format(line, sizeof(line), "{FFFFFF} %s %s[%d]\n",rank,PlayerInfo[i][pName],i);
								strcat(helpers,line);
							}
							if(counth > 0) SPD(playerid, 999, DIALOG_STYLE_LIST, ""PREFIX" ������� ������", helpers, "��", "");
							else SendClientMessage(playerid, C_BLUE, "� ������ ������ ��� �������� ������");
						}
					}
				}
			}
			else ShowKpk(playerid);
		}
		case DIALOG_GAS:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_LITRAZH_80,DIALOG_STYLE_INPUT,""PREFIX" | ��������(80)","{FFFFFF}������� ������ ������?","�������","������");
					case 1: SPD(playerid,DIALOG_LITRAZH_92,DIALOG_STYLE_INPUT,""PREFIX" | ��������(92)","{FFFFFF}������� ������ ������?","�������","������");
					case 2: SPD(playerid,DIALOG_LITRAZH_95,DIALOG_STYLE_INPUT,""PREFIX" | ��������(95)","{FFFFFF}������� ������ ������?","�������","������");
					case 3: SPD(playerid,DIALOG_LITRAZH_DISEL,DIALOG_STYLE_INPUT,""PREFIX" | ��������(������)","{FFFFFF}������� ������ ������?","�������","������");
				}
			}
		}
		case DIALOG_LITRAZH_80:
		{
			if(response)
			{
				if(strval(inputtext) < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����������!");
				if(Gas[gasp[playerid]][g80] < strval(inputtext)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� �������� ������������ �������!");
				TogglePlayerControllable(playerid,0);
				new vehicle = GetPlayerVehicleID(playerid);
				fuelic[vehicle] = 80;
				SetPVarInt(playerid,"fuela",strval(inputtext));
				SetTimerEx("Zapravka", 5000, false, "i", playerid);
				SetMoney(playerid,-Gas[gasp[playerid]][gPrice80]);
				SetPVarInt(playerid,"pricefuel",Gas[gasp[playerid]][gPrice80]);
				Gas[gasp[playerid]][gBank] += Gas[gasp[playerid]][gPrice80];
				Gas[gasp[playerid]][g80] -= strval(inputtext);
				SaveGas(gasp[playerid]);
			}
		}
		case DIALOG_LITRAZH_92:
		{
			if(response)
			{
				if(strval(inputtext) < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����������!");
				if(Gas[gasp[playerid]][g92] < strval(inputtext)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� �������� ������������ �������!");
				TogglePlayerControllable(playerid,0);
				new vehicle = GetPlayerVehicleID(playerid);
				fuelic[vehicle] = 92;
				SetPVarInt(playerid,"fuela",strval(inputtext));
				SetTimerEx("Zapravka", 5000, false, "i", playerid);
				SetMoney(playerid,-Gas[gasp[playerid]][gPrice92]);
				SetPVarInt(playerid,"pricefuel",Gas[gasp[playerid]][gPrice92]);
				Gas[gasp[playerid]][gBank] += Gas[gasp[playerid]][gPrice92];
				Gas[gasp[playerid]][g92] -= strval(inputtext);
				SaveGas(gasp[playerid]);
			}
		}
		case DIALOG_LITRAZH_95:
		{
			if(response)
			{
				if(strval(inputtext) < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����������!");
				if(Gas[gasp[playerid]][g95] < strval(inputtext)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� �������� ������������ �������!");
				TogglePlayerControllable(playerid,0);
				new vehicle = GetPlayerVehicleID(playerid);
				fuelic[vehicle] = 95;
				SetPVarInt(playerid,"fuela",strval(inputtext));
				SetTimerEx("Zapravka", 5000, false, "i", playerid);
				SetMoney(playerid,-Gas[gasp[playerid]][gPrice95]);
				SetPVarInt(playerid,"pricefuel",Gas[gasp[playerid]][gPrice95]);
				Gas[gasp[playerid]][gBank] += Gas[gasp[playerid]][gPrice95];
				Gas[gasp[playerid]][g95] -= strval(inputtext);
				SaveGas(gasp[playerid]);
			}
		}
		case DIALOG_LITRAZH_DISEL:
		{
			if(response)
			{
				if(strval(inputtext) < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����������!");
				if(Gas[gasp[playerid]][gDisel] < strval(inputtext)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� �������� ������������ �������!");
				TogglePlayerControllable(playerid,0);
				new vehicle = GetPlayerVehicleID(playerid);
				fuelic[vehicle] = 98;
				SetPVarInt(playerid,"fuela",strval(inputtext));
				SetTimerEx("Zapravka", 5000, false, "i", playerid);
				SetMoney(playerid,-Gas[gasp[playerid]][gPriceDisel]);
				SetPVarInt(playerid,"pricefuel",Gas[gasp[playerid]][gPriceDisel]);
				Gas[gasp[playerid]][gBank] += Gas[gasp[playerid]][gPriceDisel];
				Gas[gasp[playerid]][gDisel] -= strval(inputtext);
				SaveGas(gasp[playerid]);
			}
		}
		case DIALOG_PRICE:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_PRICE_80,DIALOG_STYLE_INPUT,"���� �� 80","{FFFFFF}������� ���������:","��","������");
					case 1: SPD(playerid,DIALOG_PRICE_92,DIALOG_STYLE_INPUT,"���� �� 92","{FFFFFF}������� ���������:","��","������");
					case 2: SPD(playerid,DIALOG_PRICE_95,DIALOG_STYLE_INPUT,"���� �� 95","{FFFFFF}������� ���������:","��","������");
					case 3: SPD(playerid,DIALOG_PRICE_DISEL,DIALOG_STYLE_INPUT,"���� �� ������","{FFFFFF}������� ���������:","��","������");
				}
			}
		}
		case DIALOG_PRICE_80:
		{
			if(response)
			{
				Gas[GetPVarInt(playerid,"pricefuel")][gPrice80] = strval(inputtext);
				new string[128];
				format(string,sizeof(string),"{FFFFFF}��������� {17D6E0}80{FFFFFF} ������� �����: {17D6E0}%d{FFFFFF}",Gas[GetPVarInt(playerid,"pricefuel")][gPriceDisel]);
				SendClientMessage(playerid,-1,string);
				SaveGas(GetPVarInt(playerid,"pricefuel"));
			}
		}
		case DIALOG_PRICE_92:
		{
			if(response)
			{
				Gas[GetPVarInt(playerid,"pricefuel")][gPrice92] = strval(inputtext);
				new string[128];
				format(string,sizeof(string),"{FFFFFF}��������� {17D6E0}92{FFFFFF} ������� �����: {17D6E0}%d{FFFFFF}",Gas[GetPVarInt(playerid,"pricefuel")][gPriceDisel]);
				SendClientMessage(playerid,-1,string);
				SaveGas(GetPVarInt(playerid,"pricefuel"));
			}
		}
		case DIALOG_PRICE_95:
		{
			if(response)
			{
				Gas[GetPVarInt(playerid,"pricefuel")][gPrice95] = strval(inputtext);
				new string[128];
				format(string,sizeof(string),"{FFFFFF}��������� {17D6E0}95{FFFFFF} ������� �����: {17D6E0}%d{FFFFFF}",Gas[GetPVarInt(playerid,"pricefuel")][gPriceDisel]);
				SendClientMessage(playerid,-1,string);
				SaveGas(GetPVarInt(playerid,"pricefuel"));
			}
		}
		case DIALOG_PRICE_DISEL:
		{
			if(response)
			{
				Gas[GetPVarInt(playerid,"pricefuel")][gPriceDisel] = strval(inputtext);
				new string[128];
				format(string,sizeof(string),"{FFFFFF}��������� {17D6E0}������{FFFFFF} �����: {17D6E0}%d{FFFFFF}",Gas[GetPVarInt(playerid,"pricefuel")][gPriceDisel]);
				SendClientMessage(playerid,-1,string);
				SaveGas(GetPVarInt(playerid,"pricefuel"));
			}
		}
		case DIALOG_KPK_CONTROL:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(PlayerInfo[playerid][pHouse] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ����!");
						SPD(playerid,DIALOG_CONTROL_HOUSE,DIALOG_STYLE_LIST,""PREFIX" ��� | �������� ����","{3CBBF7}[1]{FFFFFF}\t����������\n{3CBBF7}[2]{FFFFFF}\t������\n{3CBBF7}[3]{FFFFFF}\t�������� ��� �� �����\n{3CBBF7}[4]{FFFFFF}\t��������� ����\n{3CBBF7}[5]{FFFFFF}\t���������� ������ ����","��","������");
					}
					case 1:
					{
						if(PlayerInfo[playerid][pCar] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������!");
						SPD(playerid,DIALOG_CONTROL_CAR,DIALOG_STYLE_LIST,""PREFIX" ��� | �������� ������","{3CBBF7}[1]{FFFFFF}\t����������\n{3CBBF7}[2]{FFFFFF}\t��������� ���������� � ����� ��������\n{3CBBF7}[3]{FFFFFF}\t������������ ����������\n{3CBBF7}[4]{FFFFFF}\t���������� ���������� �� �����\n{3CBBF7}[5]{FFFFFF}\tFAQ �� ������ �����������","��","������");
					}
					case 3:
					{
						if(PlayerInfo[playerid][pFuel] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ��������!");
						SPD(playerid,DIALOG_CONTROL_GAS,DIALOG_STYLE_LIST,""PREFIX" ��� | �������� ��������","{3CBBF7}[1]{FFFFFF}\t����������\n{3CBBF7}[2]{FFFFFF}\t���������� ��������� �������\n{3CBBF7}[3]{FFFFFF}\t������� ��������","��","�����");
					}
					case 4:
					{
						if(PlayerInfo[playerid][pAmmo] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ���������!");
						SPD(playerid,DIALOG_CONTROL_AMMO,DIALOG_STYLE_LIST,""PREFIX" ��� | �������� ���������","{3CBBF7}[1]{FFFFFF}\t����������\n{3CBBF7}[2]{FFFFFF}\t���������� ��������� �����\n{3CBBF7}[3]{FFFFFF}\t������� ���������\n{3CBBF7}[4]{FFFFFF}\tC���� ������","��","�����");
					}
					case 5:
					{
						if(PlayerInfo[playerid][pMagazin] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ��������!");
						SPD(playerid,DIALOG_CONTROL_MAGAZIN,DIALOG_STYLE_LIST,""PREFIX" ��� | �������� ��������","{3CBBF7}[1]{FFFFFF}\t����������\n{3CBBF7}[2]{FFFFFF}\t������� �������\n{3CBBF7}[3]{FFFFFF}\tC���� ������","��","�����");
					}
					case 6:
					{
						if(PlayerInfo[playerid][pClub] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ���������!");
						SPD(playerid,DIALOG_CONTROL_CLUB,DIALOG_STYLE_LIST,""PREFIX" ��� | �������� ��������","{3CBBF7}[1]{FFFFFF}\t����������\n{3CBBF7}[2]{FFFFFF}\t������� ���������\n{3CBBF7}[3]{FFFFFF}\tC���� ������\n{3CBBF7}[4]{FFFFFF}\t���������� ��������� �����","��","�����");
					}
				}
			}
			else ShowKpk(playerid);
		}
		case DIALOG_CONTROL_GAS:
		{
			if(response)
			{
				new string[512];
				new gas = PlayerInfo[playerid][pFuel];
				switch(listitem)
				{
					case 0:
					{
						format(string,sizeof(string),"{D37018}ID ��������:{FFFFFF}\t%d\n{D37018}�����������������:{FFFFFF}\t%s\n{D37018}�������:{FFFFFF}\t%d\n{D37018}����� � �����:{FFFFFF}\t%d\n{D37018}��������� ��������:{FFFFFF}\t%d\n{D37018}��������� 80:{FFFFFF}\t%d\n{D37018}��������� 92:{FFFFFF}\t%d\n{D37018}��������� 95:{FFFFFF}\t%d\n{D37018}��������� ������:{FFFFFF}\t%d\n{D37018}����� 80:{FFFFFF}\t%d/1000\n{D37018}����� 92:{FFFFFF}\t%d/1000\n{D37018}����� 95:{FFFFFF}\t%d/1000\n{D37018}����� ������:{FFFFFF}\t%d/1000",
						gas,GetZone(Gas[gas][gX],Gas[gas][gY]),Gas[gas][gLevel],Gas[gas][gBank],Gas[gas][gPrice],Gas[gas][gPrice80],
						Gas[gas][gPrice92],Gas[gas][gPrice95],Gas[gas][gPriceDisel],Gas[gas][g80],Gas[gas][g92],Gas[gas][g95],Gas[gas][gDisel]);
						SPD(playerid,DIALOG_GAS_INFO,DIALOG_STYLE_MSGBOX,""PREFIX" �������� | ����������",string,"��","������");
					}
					case 1:
					{
						SetPVarInt(playerid,"pricefuel",gas);
						format(string,sizeof(string),"{FFFFFF}A-80\t{17D6E0}[%d$]{FFFFFF}\nA-92\t{17D6E0}[%d]{FFFFFF}\nA-95\t{17D6E0}[%d]{FFFFFF}\nA-98\t{17D6E0}[%d]{FFFFFF}",Gas[gas][gPrice80],Gas[gas][gPrice92],Gas[gas][gPrice95],Gas[gas][gPriceDisel]);
						SPD(playerid,DIALOG_PRICE,DIALOG_STYLE_LIST,""PREFIX" ���������� ���� �� ������",string,"�������","������");
					}
					case 2:
					{
						Gas[gas][gOwned] = false;
						strmid(Gas[gas][gOwner], "The State", 0, strlen("The State"), 255);
						SendClientMessage(playerid,-1,"{FFFFFF}�������� {147130}�������{FFFFFF} �������!");
						SaveGas(gas);
						UpdateGasText(gas);
						PlayerInfo[playerid][pFuel] = 0;
					}
				}
			}
			else ShowKpkControl(playerid);
		}
		case DIALOG_JOB:
		{
			if(response)
			{
				PlayerInfo[playerid][pJob] = GetPVarInt(playerid,"job");
				new string[128];
				format(string,sizeof(string),"{FFFFFF}�� ���������� �� ������ {17D6E0}%s{FFFFFF}. �����������!",Job[GetPVarInt(playerid,"job")][jName]);
				SendClientMessage(playerid,-1,string);
				if(PlayerInfo[playerid][pQuest][1] == false) {
					SendClientMessage(playerid, -1, ""PURP"�� ��������� �����: ��������� �� ������");
					PlayerInfo[playerid][pQuest][1] = true;
					return true;
				}
				if(PlayerInfo[playerid][pJob] == 5)
				{
					PlayerStartJob[playerid] = false;
					PlayerOnJob[playerid] = true;
					SetPlayerSkin(playerid, 16);
					SetPlayerAttachedObject(playerid, 3, 18634, 6, 0.078222, 0.000000, 0.110844, 298.897308, 264.126861, 193.350555, 1.000000, 1.000000, 1.000000);
				}
				if(PlayerInfo[playerid][pJob] == 7)
				{
					SendClientMessage(playerid,-1,"{133894}[���������]{FFFFFF} ����������� �� �������� � ��������� � ����������� � ������");
					new mcheck = random(3);
					if(mcheck == 0) SetPlayerCheckpoint(playerid, 249.1263,-174.7928,13.6859,2);
					if(mcheck == 1) SetPlayerCheckpoint(playerid, 246.3768,-174.6950,13.6859,2);
					if(mcheck == 2) SetPlayerCheckpoint(playerid, 243.5233,-174.6834,13.6859,2);
				}
			}
			else { SetPVarInt(playerid,"job",0); SendClientMessage(playerid,-1,"{FFFFFF}�� ���������� �� ������!"); }
		}
		case DIALOG_JOB_UVAL:
		{
			if(response)
			{
				if(PlayerInfo[playerid][pJob] == 7)
				{
					SetMoney(playerid,ammobox[playerid]);
					new string[128];
					format(string,sizeof(string),"{FFFFFF}�� ������� {17D6E0}%d{FFFFFF} ������� � ��������� � ����������{17D6E0} %d${FFFFFF}",ammobox[playerid],ammobox[playerid]);
					SendClientMessage(playerid,-1,string);
					ammobox[playerid] = 0;
				}
				SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
				PlayerInfo[playerid][pJob] = 0;
				new string[128];
				format(string,sizeof(string),"{FFFFFF}�� ��������� � ������ {17D6E0}%s{FFFFFF}.",Job[GetPVarInt(playerid,"job")][jName]);
				SendClientMessage(playerid,-1,string);
				RemovePlayerAttachedObject(playerid, 3);
				RemovePlayerAttachedObject(playerid, 6);
			}
		}
		case DIALOG_ZAKUPKA:
		{
			if(response)
			{
				switch(PlayerInfo[playerid][pGunSkill])
				{
					case 0..100: { maximum[playerid] = 20; price[playerid] = 100; }
					case 101..200: { maximum[playerid] = 40; price[playerid] = 200; }
					case 201..300: { maximum[playerid] = 60; price[playerid] = 300; }
					case 301..400: { maximum[playerid] = 80; price[playerid] = 400; }
					case 401..500: { maximum[playerid] = 100; price[playerid] = 500; }
				}
				if(strval(inputtext) <= 0 || strval(inputtext) > 100) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ������ 0 � �� ������ 100!");
//				new summa1 = pakety[playerid] += strval(inputtext);
				if(pakety[playerid] != 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ���� ������, ������� ������ ��!");
				if(strval(inputtext) > maximum[playerid]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� �� ������ �������� ������� �������!");
				new summa = price[playerid]*strval(inputtext);
				if(summa > PlayerInfo[playerid][pMoney]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �����!");
				SetMoney(playerid,-summa);
				pakety[playerid] = strval(inputtext);
				new string[128];
				format(string,sizeof(string),"{FFFFFF}�� �������� {17D6E0}%s{FFFFFF} ������� � ��������� �� ��� {17D6E0}%d${FFFFFF}",inputtext,summa);
				SendClientMessage(playerid,-1,string);
			}
		}
		case DIALOG_MAKEGUN:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(PlayerInfo[playerid][pMats] < 150) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ����������!");
						PlayerInfo[playerid][pMats] -= 150;
						ServerGivePlayerWeapon(playerid, 24, 100);
						SendClientMessage(playerid,-1,"�� ������� Desert Eagle �� 150 ����������");
					}
					case 1:
					{
						if(PlayerInfo[playerid][pMats] < 300) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ����������!");
						PlayerInfo[playerid][pMats] -= 300;
						ServerGivePlayerWeapon(playerid, 29, 250);
						SendClientMessage(playerid,-1,"�� ������� MP-5 �� 300 ����������");
					}
					case 2:
					{
						if(PlayerInfo[playerid][pMats] < 400) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ����������!");
						PlayerInfo[playerid][pMats] -= 400;
						ServerGivePlayerWeapon(playerid, 25, 50);
						SendClientMessage(playerid,-1,"�� ������� ShotGun �� 400 ����������");
					}
					case 3:
					{
						if(PlayerInfo[playerid][pMats] < 500) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ����������!");
						PlayerInfo[playerid][pMats] -= 500;
						ServerGivePlayerWeapon(playerid, 31, 350);
						SendClientMessage(playerid,-1,"�� ������� M-4 �� 500 ����������");
					}
					case 4:
					{
						if(PlayerInfo[playerid][pMats] < 500) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ����������!");
						PlayerInfo[playerid][pMats] -= 500;
						ServerGivePlayerWeapon(playerid, 30, 350);
						SendClientMessage(playerid,-1,"�� ������� AK-47 �� 500 ����������");
					}
				}
			}
		}
		case DIALOG_KPK_GPS:
		{
			if(response)
			{
				gps[playerid] = true;
				new spisok[512], jobsp[512];
				strcat(spisok,"{3CBBF7}[1]{FFFFFF}\t���������\n{3CBBF7}[2]{FFFFFF}\t����������� �������\n{3CBBF7}[3]{FFFFFF}\t������� ������");
				strcat(spisok,"\n{3CBBF7}[4]{FFFFFF}\t���� ��\n{3CBBF7}[5]{FFFFFF}\t�������� LS\n{3CBBF7}[6]{FFFFFF}\t�������� LV\n{3CBBF7}[7]{FFFFFF}\t�������� SF");
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_GPS_LOCATION,DIALOG_STYLE_LIST,""PREFIX" KPK | GPS - �������� �������",spisok,"�������","������");
					case 1:
					{
						for(new i = 1; i < 7; i++) {
							new string[128];
							format(string, sizeof(string), ""WHT"%s.\t(������� "YE"%d"WHT")\n", Job[i][jName], Job[i][jLevel]);
							strcat(jobsp, string);
						}	
						SPD(playerid,DIALOG_GPS_JOB,DIALOG_STYLE_LIST,""PREFIX" KPK | GPS - ������",jobsp,"�������","������");
					}	
					case 2:
					{
						new string[512],string1[512];
						format(string,sizeof(string),"{3CBBF7}[1]{FFFFFF}\tSAPD\n{3CBBF7}[2]{FFFFFF}\tFBI\n{3CBBF7}[3]{FFFFFF}\tNational Guard\n{3CBBF7}[4]{FFFFFF}\tSAMD\n{3CBBF7}[5]{FFFFFF}\tSan News\n{3CBBF7}[6]{FFFFFF}\tThe Groove Street\n{3CBBF7}[7]{FFFFFF}\tThe Ballas Gang\n{3CBBF7}[8]{FFFFFF}\tEl Coronos");
						format(string1,sizeof(string1),"\n{3CBBF7}[9]{FFFFFF}\tLos Santos Vagos\n{3CBBF7}[10]{FFFFFF}\tRussian Mafia\n{3CBBF7}[11]{FFFFFF}\tYakuza\n{3CBBF7}[12]{FFFFFF}\tLCN\n{3CBBF7}[13]{FFFFFF}\tTriads\n{3CBBF7}[14]{FFFFFF}\t��������");
						strcat(string,string1);
						SPD(playerid,DIALOG_GPS_FRAC,DIALOG_STYLE_LIST,""PREFIX" KPK | GPS - �������",string,"�����","������");
					}
					case 3: { DisablePlayerCheckpoint(playerid); gps[playerid] = false; }
				}
			}
			else ShowKpk(playerid);
		}
		case DIALOG_GPS_LOCATION:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: { CreateDynamicCP(-2026.6504,-102.0529,35.1641,3.0,0,0,playerid,100000);SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} {17D6E0}���������{FFFFFF} ������� �� ����� ������� ��������"); }
					case 1: { CreateDynamicCP(1555.1188,-1675.6270,16.1953,3.0,0,0,playerid,100000); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} {17D6E0}����������� �������{FFFFFF} ������ �� ����� ������� ��������"); }
					case 2: { CreateDynamicCP(461.5806,-1500.8630,31.0483,3.0,0,0,playerid,100000); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} {17D6E0}������� ������{FFFFFF} ������ �� ����� ������� ��������"); }
					case 3: { CreateDynamicCP(1462.0999,-1025.0613,23.8281,3.0,0,0,playerid,100000); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} {17D6E0}���� ��{FFFFFF} ������ �� ����� ������� ��������"); }
					case 4: { CreateDynamicCP(2229.8406,-1721.1965,13.5606,3.0,0,0,playerid,100000); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} {17D6E0}�������� ��{FFFFFF} ������ �� ����� ������� ��������"); }
					case 5: { CreateDynamicCP(1968.8245,2295.8728,16.4559,3.0,0,0,playerid,100000); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} {17D6E0}�������� ��{FFFFFF} ������ �� ����� ������� ��������"); }
					case 6: { CreateDynamicCP(-2270.6475,-155.8572,35.3203,3.0,0,0,playerid,100000); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} {17D6E0}�������� ��{FFFFFF} ������ �� ����� ������� ��������"); }
				}   
			}
		}
		case DIALOG_GPS_JOB:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_JOB_GD,DIALOG_STYLE_LIST,""PREFIX" KPK | GPS - ������ �������� ������","{3CBBF7}[1]{FFFFFF}\t����� ����������\n{3CBBF7}[2]{FFFFFF}\t������� �������\n{3CBBF7}[3]{FFFFFF}\t����� �������","�������","������");
					case 1: SPD(playerid,DIALOG_JOB_DL,DIALOG_STYLE_LIST,""PREFIX" KPK | GPS - ������ �������������","{3CBBF7}[1]{FFFFFF}\t����� ����������","�������","������");
					case 2: { CreateDynamicCP(-1061.15,-1195.46,129.739,3.0,0,0,playerid,2000); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF}����� ���������� �� ������ {17D6E0}���������{FFFFFF} ������� �� �����"); }
					case 3: SPD(playerid,DIALOG_JOB_ND,DIALOG_STYLE_LIST,""PREFIX" KPK | GPS - ������ ������������","{3CBBF7}[1]{FFFFFF}\t����� ����������\n{3CBBF7}[2]{FFFFFF}\t����� �����\n{3CBBF7}[3]{FFFFFF}\t��������� �����","�������","������");
					case 4: { CreateDynamicCP(-1864.7894,-1559.2375,22.2109,3.0,0,0,playerid,2000); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF}����� ���������� �� ������ {17D6E0}������{FFFFFF} ������� �� �����"); }
					case 5: { CreateDynamicCP(1216.69,-1813.17,16.5938,3.0,0,0,playerid,2000); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF}����� ���������� �� ������ {17D6E0}��������{FFFFFF} ������� �� �����"); }
					case 6: { CreateDynamicCP(250.3685,-157.6051,1.5703,3.0,0,0,playerid,2000); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF}����� ���������� �� ������ {17D6E0}������������� ������{FFFFFF} ������� �� �����"); }
					case 7: { CreateDynamicCP(-2119.0583,-177.9994,35.3203,3.0,0,0,playerid,2000); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF}����� ���������� �� ������ {17D6E0}��������{FFFFFF} ������� �� �����"); }
				}
			}
		}
		case DIALOG_GPS_FRAC:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: { SetPlayerCheckpoint(playerid, 1538.0614,-1627.7847,12.9553, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}SAPD{FFFFFF} ������� �� ����� ������� ��������"); }
					case 1: { SetPlayerCheckpoint(playerid, 2232.2161,2452.2017,10.8547, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}FBI{FFFFFF} ������� �� ����� ������� ��������"); }
					case 2: { SetPlayerCheckpoint(playerid, -1529.8452,487.4435,7.1797, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}National Guard{FFFFFF} ������� �� ����� ������� ��������"); }
					case 3: { SetPlayerCheckpoint(playerid, 1999.3303,-1449.0647,13.5593, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}SAMD{FFFFFF} ������� �� ����� ������� ��������"); }
					case 4: { SetPlayerCheckpoint(playerid, 2128.0254,2338.0715,10.6719, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}San News{FFFFFF} ������� �� ����� ������� ��������"); }
					case 5: { SetPlayerCheckpoint(playerid, 2464.9460,-1658.9722,13.2903, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}The Groove Street Family{FFFFFF} ������� �� ����� ������� ��������"); }
					case 6: { SetPlayerCheckpoint(playerid, 1998.6196,-1129.1586,25.5427, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}The Ballas Gang{FFFFFF} ������� �� ����� ������� ��������"); }
					case 7: { SetPlayerCheckpoint(playerid, 1814.9078,-1892.1652,13.4141, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}El Coronos{FFFFFF} ������� �� ����� ������� ��������"); }
					case 8: { SetPlayerCheckpoint(playerid, 2834.9138,-1182.5100,24.6853, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}Los Santos Vagos{FFFFFF} ������� �� ����� ������� ��������"); }
					case 9: { SetPlayerCheckpoint(playerid, 963.9415,1734.2112,8.6484, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}Russian Mafia{FFFFFF} ������� �� ����� ������� ��������"); }
					case 10: { SetPlayerCheckpoint(playerid,-2728.1189,-308.9371,7.0391, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}Yakuza{FFFFFF} ������� �� ����� ������� ��������"); }
					case 11: { SetPlayerCheckpoint(playerid,-2728.1189,-308.9371,7.0391, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}LCN{FFFFFF} ������� �� ����� ������� ��������"); }
					case 12: { SetPlayerCheckpoint(playerid,2621.9966,1716.9817,11.0312, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}The Triads Mafia{FFFFFF} ������� �� ����� ������� ��������"); }
					//case 13: { SetPlayerCheckpoint(playerid,2621.9966,1716.9817,11.0312, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� �������� {17D6E0}��������{FFFFFF} ������� �� ����� ������� ��������"); }
				}
			}
		}
		case DIALOG_JOB_DL:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: { SetPlayerCheckpoint(playerid, -50.2344,-270.525,6.63319, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� ���������� �� ������ {17D6E0}�������������{FFFFFF} ������� �� ����� ������� ��������"); }
				}
			}
		}
		case DIALOG_JOB_GD:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: { SetPlayerCheckpoint(playerid, 91.0564,-164.671,2.59375, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� ���������� �� ������ {17D6E0}�������� ������ {FFFFFF} ������� �� ����� ������� ��������"); }
					case 1: { SetPlayerCheckpoint(playerid, 1697.1306,916.5074,10.8153, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� {17D6E0}������� �������{FFFFFF} ������� �� ����� ������� ��������"); }
					case 2: { SetPlayerCheckpoint(playerid, -2947.5974,504.1858,2.4297, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� {17D6E0}����� �������{FFFFFF} ������� �� ����� ������� ��������"); }
				}
			}
		}
		case DIALOG_JOB_ND:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: { SetPlayerCheckpoint(playerid, 2166.39,-1674.35,15.0803, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� ���������� �� ������ {17D6E0}������������ {FFFFFF} ������� �� ����� ������� ��������"); }
					case 1: { SetPlayerCheckpoint(playerid, -1060.3180,-1205.4827,129.2188, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} {17D6E0}C����{FFFFFF} ������ �� ����� ������� ��������"); }
					case 2: { SetPlayerCheckpoint(playerid, -1741.6755,1428.6117,7.1875, 3.0); SendClientMessage(playerid,-1,"{133894}[GPS]{FFFFFF} ����� {17D6E0}��������� �����{FFFFFF} ������� �� ����� ������� ��������"); }
				}
			}
		}
		case DIALOG_SPAWNCHANGE:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: { PlayerInfo[playerid][pSpawn] = 0; SendClientMessage(playerid,-1,"������ �� ������ ���������� �� �������� ��������!"); }
					case 1:
					{
						if(PlayerInfo[playerid][pHouse] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ����!");
						PlayerInfo[playerid][pSpawn] = 2;
						SendClientMessage(playerid,COLOR_LIGHTBLUE,"������ �� ������ ���������� � ���� ����!");
					}
					case 2:
					{
						new fam = GetPlayerMember(playerid);
						if(fam == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� �� �������� �� �������!");
						PlayerInfo[playerid][pSpawn] = 1;
						SendClientMessage(playerid,COLOR_LIGHTBLUE,"������ �� ������ ���������� �� �������� ����� �������!");
					}
					case 3:
					{
						if(PlayerInfo[playerid][pRent] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� �� ��������� ���!");
						PlayerInfo[playerid][pSpawn] = 3;
						SendClientMessage(playerid,COLOR_LIGHTBLUE,"������ �� ������ ���������� � ����,������� �� ���������");
					}
				}
			}
		}
		case DIALOG_ZAKUPKA_TRAVA:
		{
			if(response)
			{
				switch(PlayerInfo[playerid][pDrugSkill])
				{
					case 0..100: { maximum[playerid] = 20; price[playerid] = 200; }
					case 101..200: { maximum[playerid] = 40; price[playerid] = 300; }
					case 201..300: { maximum[playerid] = 60; price[playerid] = 400; }
					case 301..400: { maximum[playerid] = 80; price[playerid] = 500; }
					case 401..500: { maximum[playerid] = 100; price[playerid] = 600; }
				}
				if(strval(inputtext) <= 0 || strval(inputtext) > 100) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ������ 0 � �� ������ 100!");
				//new summa1 = trava[playerid] + strval(inputtext);
				if(trava[playerid] != 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ���� ��� ���� �����, ��������� ��!");
				if(strval(inputtext) > maximum[playerid]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� �� ������ �������� ������� �����!");
				new summa = price[playerid]*strval(inputtext);
				if(summa > PlayerInfo[playerid][pMoney]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �����!");
				trava[playerid] = strval(inputtext);
				SetMoney(playerid,-summa);
				new string[128];
				format(string,sizeof(string),"{FFFFFF}�� ����� {17D6E0}%s{FFFFFF} ����� � ��������� �� ��{17D6E0}%d${FFFFFF}",inputtext,summa);
				SendClientMessage(playerid,-1,string);
				format(trava1,sizeof(trava1),"����� �� ������: %d",Trava[kolvo]);
				Update3DTextLabelText(travapickup, 0xFFFFFFFF, trava1);
			}
		}
		case DIALOG_CRASH:
		{
			if(response) ServerSetPlayerPos(playerid,PlayerInfo[playerid][pX],PlayerInfo[playerid][pY],PlayerInfo[playerid][pZ]);
			PlayerInfo[playerid][pCrashed] = false;
			PlayerInfo[playerid][pX] = 0;
			PlayerInfo[playerid][pY] = 0;
			PlayerInfo[playerid][pZ] = 0;
		}
		case DIALOG_ZAVOD_BUY:
		{
			if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ������� ������ ����� 2 �������!");
			if(response)
			{
				switch(strval(inputtext))
				{
					case 403,423,441,443,460,469,476,481,493,497,501,528,544,548,553,563,564,416,417,464,465,472,473,519,520,569,570,571,572,574,577,
					578,582,583,584,588,590,591,592,593,594,595,601,604,605,606,607,608,610,611,425: { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ��������� ���������� ��� �������"); return true; }
					case 406..408: { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ��������� ���������� ��� �������"); return true; }
					case 427..428: { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ��������� ���������� ��� �������"); return true; }
					case 430..435: { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ��������� ���������� ��� �������"); return true; }
					case 446..450: { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ��������� ���������� ��� �������"); return true; }
					case 452..457: { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ��������� ���������� ��� �������"); return true; }
					case 485..488: { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ��������� ���������� ��� �������"); return true; }
					case 509..515: { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ��������� ���������� ��� �������"); return true; }
					case 523..525: { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ��������� ���������� ��� �������"); return true; }
					case 530..532: { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ��������� ���������� ��� �������"); return true; }
					case 537..539: { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ��������� ���������� ��� �������"); return true; }
				}
				buying[playerid] = strval(inputtext);
				GetCarPrice(buying[playerid],playerid);
				new pokupka[255];
				format(pokupka,sizeof(pokupka),"{FFFFFF}������:\t\t{157320}%s{FFFFFF} \n���������:\t\t{157320}%d{FFFFFF} \n�� ������������� ������ ����������?",VehicleNames[strval(inputtext)-400],carprice[playerid]);
				SPD(playerid,DIALOG_CAR_POKUPKA,DIALOG_STYLE_MSGBOX,""PREFIX" ������� ����",pokupka,"��","���");
			}
		}
		case DIALOG_CONTROL_HOUSE:
		{
			if(response)
			{
				new house = PlayerInfo[playerid][pHouse],string[350];
				switch(listitem)
				{
					case 0:
					{
						format(string,sizeof(string),"{D37018}ID ����:{FFFFFF}\t\t%d\n{D37018}�����������������:{FFFFFF}\t%s\n{D37018}�������:{FFFFFF}\t\t%d\n{D37018}����� � �����:{FFFFFF}\t%s\n{D37018}���������� � �����:{FFFFFF}\t%s\n{D37018}���������� � �����:{FFFFFF}\t%s\n{D37018}��������� ����:{FFFFFF}\t%d",
						house,GetZone(HouseInfo[house][hEntrancex],HouseInfo[house][hEntrancey]),HouseInfo[house][hLevel],ConvertCash(HouseInfo[house][hMoney]),ConvertCash(HouseInfo[house][hMats]),ConvertCash(HouseInfo[house][hDrugs]),HouseInfo[house][hValue]);
						SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" ��� | ����������",string,"��","������");
					}
					case 1: SPD(playerid,DIALOG_CONTROL_HOUSE_RENT,DIALOG_STYLE_LIST,""PREFIX" ��� | �������� ���� | ������","{3CBBF7}[1]{FFFFFF}\t���������� ��������� ������\n{3CBBF7}[2]{FFFFFF}\t������ ����������","��","������");
					case 2: SetPlayerMapIcon(playerid,0,HouseInfo[house][hEntrancex],HouseInfo[house][hEntrancey],HouseInfo[house][hEntrancez],35,0,MAPICON_GLOBAL);
					case 3: SPD(playerid,DIALOG_HU,DIALOG_STYLE_LIST,""PREFIX" ��������� ����","{3CBBF7}[1]{FFFFFF}\t���������� ��������\n{3CBBF7}[2]{FFFFFF}\t���������� �����","OK","������");
					case 4: {
						format(string, sizeof(string), "���������:\t"PURP"%s"WHT"\n���������:\t"PURP"%s"WHT"\n������:\t"PURP"%s", ConvertCash(HouseInfo[house][hMats]), ConvertCash(HouseInfo[house][hDrugs]), ConvertCash(HouseInfo[house][hMoney]));
						SPD(playerid, DIALOG_SEIF, DIALOG_STYLE_LIST, ""PREFIX" ���� ����", string, "�������", "������");
						return true;
					}
				}
			}
		}
		case DIALOG_CONTROL_HOUSE_RENT:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_RENT_PRICE,DIALOG_STYLE_INPUT,""PREFIX" C�������� ������","{FFFFFF}������� ��������� ������ ����(0 - ��������� ������)","OK","������");
					case 1:
					{
						new showrent[1000];
						new name[21], line[30], sql[128];
						format(sql, sizeof(sql), "SELECT Nickname FROM Accounts WHERE Rent = %d", PlayerInfo[playerid][pHouse]);
						mysql_query(sql);
						if(mysql_store_result())
						{
							for(new i; i<mysql_num_rows(); i++)
							{
								if(mysql_fetch_row_format(name))
								{
									format(line, sizeof(line), "{FFFFFF}%s\n", name);
									strcat(showrent, line);
								}
								SPD(playerid, 999, DIALOG_STYLE_LIST, ""PREFIX" ������,���������� ��� ���", showrent, "�������", "�������");
							}
						}
						mysql_free_result();
					}
				}
			}
		}
		case DIALOG_RENT_PRICE:
		{
			if(response)
			{
				new house = PlayerInfo[playerid][pHouse],string[144];
				HouseInfo[house][hRent] = strval(inputtext);
				SaveHouse(house);
				UpdateHouseText(house);
				format(string,sizeof(string),"{FFFFFF}��������� ������ ����������� �� {3C670E}%d${FFFFFF}",strval(inputtext));
				SendClientMessage(playerid,-1,string);
			}
		}
		case DIALOG_SEIF:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_SEIF_MATS,DIALOG_STYLE_LIST,""PREFIX" ���� | ���������","{3CBBF7}[1]{FFFFFF}\t��������\n{3CBBF7}[2]{FFFFFF}\t�������","�������","������");
					case 1: SPD(playerid,DIALOG_SEIF_DRUGS,DIALOG_STYLE_LIST,""PREFIX" ���� | ���������","{3CBBF7}[1]{FFFFFF}\t��������\n{3CBBF7}[2]{FFFFFF}\t�������","�������","������");
					case 2: SPD(playerid,DIALOG_SEIF_MONEY,DIALOG_STYLE_LIST,""PREFIX" ���� | ������","{3CBBF7}[1]{FFFFFF}\t��������\n{3CBBF7}[2]{FFFFFF}\t�������","�������","������");
				}
			}
		}
		case DIALOG_SEIF_MATS:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_SEIF_MATS_P,DIALOG_STYLE_INPUT,""PREFIX" ���� | ��������� | ��������","{FFFFFF}������� ������� �� ������ ��������","��","������");
					case 1: SPD(playerid,DIALOG_SEIF_MATS_Z,DIALOG_STYLE_INPUT,""PREFIX" ���� | ��������� | �������","{FFFFFF}������� ������� �� ������ �������","��","������");
				}
			}
		}
		case DIALOG_SEIF_DRUGS:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_SEIF_DRUGS_P,DIALOG_STYLE_INPUT,""PREFIX" ���� | ��������� | ��������","{FFFFFF}������� ������� �� ������ ��������","��","������");
					case 1: SPD(playerid,DIALOG_SEIF_DRUGS_Z,DIALOG_STYLE_INPUT,""PREFIX" ���� | ��������� | �������","{FFFFFF}������� ������� �� ������ �������","��","������");
				}
			}
		}
		case DIALOG_SEIF_MONEY:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_SEIF_MONEY_P,DIALOG_STYLE_INPUT,""PREFIX" ���� | ������ | ��������","{FFFFFF}������� ������� �� ������ ��������","��","������");
					case 1: SPD(playerid,DIALOG_SEIF_MONEY_Z,DIALOG_STYLE_INPUT,""PREFIX" ���� | ������ | �������","{FFFFFF}������� ������� �� ������ �������","��","������");
				}
			}
		}
		case DIALOG_SEIF_MATS_P:
		{
			if(response)
			{
				new string[144],house = PlayerInfo[playerid][pHouse];
				if(PlayerInfo[playerid][pMats] < strval(inputtext) || strval(inputtext) <= 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������� ����������!");
				PlayerInfo[playerid][pMats] -= strval(inputtext);
				HouseInfo[house][hMats] += strval(inputtext);
				format(string,sizeof(string),"�� �������� � ��� %d ����������. ������� �� �����: %d. � ����: %d.",strval(inputtext),PlayerInfo[playerid][pMats],HouseInfo[house][hMats]);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
		}
		case DIALOG_SEIF_MATS_Z:
		{
			if(response)
			{
				new string[144],house = PlayerInfo[playerid][pHouse];
				if(HouseInfo[house][hMats] < strval(inputtext) || strval(inputtext) <= 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ���� ��� ������� ����������!");
				PlayerInfo[playerid][pMats] += strval(inputtext);
				HouseInfo[house][hMats] -= strval(inputtext);
				format(string,sizeof(string),"�� ������� �� ���� %d ����������. ������ �� �����: %d. � ����: %d.",strval(inputtext),PlayerInfo[playerid][pMats],HouseInfo[house][hMats]);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
		}
		case DIALOG_SEIF_DRUGS_P:
		{
			if(response)
			{
				new string[144],house = PlayerInfo[playerid][pHouse];
				if(PlayerInfo[playerid][pDrugs] < strval(inputtext) || strval(inputtext) <= 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������� ����������!");
				PlayerInfo[playerid][pDrugs] -= strval(inputtext);
				HouseInfo[house][hDrugs] += strval(inputtext);
				format(string,sizeof(string),"�� �������� � ��� %d ����������. ������� �� �����: %d. � ����: %d.",strval(inputtext),PlayerInfo[playerid][pDrugs],HouseInfo[house][hDrugs]);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
		}
		case DIALOG_SEIF_DRUGS_Z:
		{
			if(response)
			{
				new string[144],house = PlayerInfo[playerid][pHouse];
				if(HouseInfo[house][hDrugs] < strval(inputtext) || strval(inputtext) <= 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ���� ��� ������� ����������!");
				PlayerInfo[playerid][pDrugs] += strval(inputtext);
				HouseInfo[house][hDrugs] -= strval(inputtext);
				format(string,sizeof(string),"�� ������� �� ���� %d ����������. ������ �� �����: %d. � ����: %d.",strval(inputtext),PlayerInfo[playerid][pDrugs],HouseInfo[house][hDrugs]);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
		}
		case DIALOG_SEIF_MONEY_P:
		{
			if(response)
			{
				new string[144],house = PlayerInfo[playerid][pHouse];
				if(PlayerInfo[playerid][pMoney] < strval(inputtext) || strval(inputtext) <= 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������� �����!");
				SetMoney(playerid,strval(inputtext));
				HouseInfo[house][hMoney] += strval(inputtext);
				format(string,sizeof(string),"�� �������� � ��� %d �����. ������� �� �����: %d. � ����: %d.",strval(inputtext),PlayerInfo[playerid][pMoney],HouseInfo[house][hMoney]);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
		}
		case DIALOG_SEIF_MONEY_Z:
		{
			if(response)
			{
				new string[144],house = PlayerInfo[playerid][pHouse];
				if(HouseInfo[house][hMoney] < strval(inputtext) || strval(inputtext) <= 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ���� ��� ������� �����!");
				SetMoney(playerid,-strval(inputtext));
				HouseInfo[house][hMoney] -= strval(inputtext);
				format(string,sizeof(string),"�� ������� �� ���� %d �����. ������ �� �����: %d. � ����: %d.",strval(inputtext),PlayerInfo[playerid][pMoney],HouseInfo[house][hMoney]);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
		}
		case DIALOG_OBSH:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_OBSH_MATS,DIALOG_STYLE_LIST,""PREFIX" ����� | ���������","{3CBBF7}[1]{FFFFFF}\t��������\n{3CBBF7}[2]{FFFFFF}\t�������\n{3CBBF7}[3]{FFFFFF}\t������� ������","�������","������");
					case 1: SPD(playerid,DIALOG_OBSH_DRUGS,DIALOG_STYLE_LIST,""PREFIX" ����� | ���������","{3CBBF7}[1]{FFFFFF}\t��������\n{3CBBF7}[2]{FFFFFF}\t�������","�������","������");
					case 2: SPD(playerid,DIALOG_OBSH_MONEY,DIALOG_STYLE_LIST,""PREFIX" ����� | ������","{3CBBF7}[1]{FFFFFF}\t��������\n{3CBBF7}[2]{FFFFFF}\t�������","�������","������");
				}
			}
		}
		case DIALOG_OBSH_MATS:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_OBSH_MATS_POLOZH,DIALOG_STYLE_INPUT,""PREFIX" ����� | ��������� | ��������","{FFFFFF}������� �����,������� �� ������ ��������","�������","������");
					case 1: SPD(playerid,DIALOG_OBSH_MATS_ZABR,DIALOG_STYLE_INPUT,""PREFIX" ����� | ��������� | �������","{FFFFFF}������� �����,������� �� ������ �������","�������","������");
					case 2: SPD(playerid,DIALOG_OBSH_MAKEGUN,DIALOG_STYLE_LIST,""PREFIX" ����� | ���������","{3CBBF7}[1]{FFFFFF}\tDesert Eagle\n{3CBBF7}[2]{FFFFFF}\tAK-47\n{3CBBF7}[3]{FFFFFF}\tM-4\n{3CBBF7}[4]{FFFFFF}\tMP-5\n{3CBBF7}[5]{FFFFFF}\tShotGun","�������","������");
				}
			}
		}
		case DIALOG_OBSH_DRUGS:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_OBSH_DRUGS_POLOZH,DIALOG_STYLE_INPUT,""PREFIX" ����� | ��������� | ��������","{FFFFFF}������� �����,������� �� ������ ��������","�������","������");
					case 1: SPD(playerid,DIALOG_OBSH_DRUGS_ZABR,DIALOG_STYLE_INPUT,""PREFIX" ����� | ��������� | �������","{FFFFFF}������� �����,������� �� ������ �������","�������","������");
				}
			}
		}
		case DIALOG_OBSH_MONEY:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_OBSH_MONEY_POLOZH,DIALOG_STYLE_INPUT,""PREFIX" ����� | ������ | ��������","{FFFFFF}������� �����,������� �� ������ ��������","�������","������");
					case 1: SPD(playerid,DIALOG_OBSH_MONEY_ZABR,DIALOG_STYLE_INPUT,""PREFIX" ����� | ������ | �������","{FFFFFF}������� �����,������� �� ������ �������","�������","������");
				}
			}
		}
        case DIALOG_OBSH_MATS_POLOZH:
		{
			if(response)
			{
				new fam,string[144];
				if(PlayerInfo[playerid][pLeader] > 0) fam = PlayerInfo[playerid][pLeader];
				else fam = PlayerInfo[playerid][pMember];
				if(PlayerInfo[playerid][pMats] < strval(inputtext)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������� ����������!");
				if(strval(inputtext) < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������!");
				PlayerInfo[playerid][pMats] -= strval(inputtext);
				Fraction[fam][fMats] += strval(inputtext);
				format(string,sizeof(string),"%s ������� � ����� %d ����������. ���������� � ������: %d",PlayerInfo[playerid][pName],strval(inputtext),Fraction[fam][fMats]);
				SendFractionMessage(COLOR_BLUE,string,fam);
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET mats=%d WHERE id='%i'",Fraction[fam][fMats],fam);
				mysql_query(query);
			}
		}
		case DIALOG_OBSH_MATS_ZABR:
		{
			if(response)
			{
				new fam = PlayerInfo[playerid][pLeader],string[144];
				if(PlayerInfo[playerid][pLeader] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ���������� ��� �������!");
				if(Fraction[fam][fMats] < strval(inputtext)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ������ ��� ������� ����������!");
				if(strval(inputtext) < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������!");
				PlayerInfo[playerid][pMats] += strval(inputtext);
				Fraction[fam][fMats] -= strval(inputtext);
				format(string,sizeof(string),"%s ������ �� ������ %d ����������. ���������� � ������: %d",PlayerInfo[playerid][pName],strval(inputtext),Fraction[fam][fMats]);
				SendFractionMessage(COLOR_BLUE,string,fam);
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET mats=%d WHERE id='%i'",Fraction[fam][fMats],fam);
				mysql_query(query);
			}
		}
		case DIALOG_OBSH_MAKEGUN:
		{
			if(response)
			{
				new msg[144];
				new fam = GetPlayerMember(playerid);
				switch(listitem)
				{
					case 0:
					{
						if(Fraction[fam][fMats] < 150) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ������ �� ������� ���������� �� ������(�����: 150)!");
						Fraction[fam][fMats] -= 150;
						ServerGivePlayerWeapon(playerid,24,150);
						format(msg,sizeof(msg),"%s ������ Desert Eeagle,�������� 150 ����������",PlayerInfo[playerid][pName]);
						SendFractionMessage(COLOR_BLUE,msg,fam);
					}
					case 1:
					{
						if(Fraction[fam][fMats] < 500) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ������ �� ������� ���������� �� ������(�����: 500)!");
						Fraction[fam][fMats] -= 500;
						ServerGivePlayerWeapon(playerid,30,500);
						format(msg,sizeof(msg),"%s ������ ������ AK-47,�������� 500 ����������",PlayerInfo[playerid][pName]);
						SendFractionMessage(COLOR_BLUE,msg,fam);
					}
					case 2:
					{
						if(Fraction[fam][fMats] < 500) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ������ �� ������� ���������� �� ������(�����: 500)!");
						Fraction[fam][fMats] -= 500;
						ServerGivePlayerWeapon(playerid,31,500);
						format(msg,sizeof(msg),"%s ������ ������ M-4,�������� 500 ����������",PlayerInfo[playerid][pName]);
						SendFractionMessage(COLOR_BLUE,msg,fam);
					}
					case 4:
					{
						if(Fraction[fam][fMats] < 300) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ������ �� ������� ���������� �� ������(�����: 300)!");
						Fraction[fam][fMats] -= 300;
						ServerGivePlayerWeapon(playerid,29,250);
						format(msg,sizeof(msg),"%s ������ ������ MP-5,�������� 300 ����������",PlayerInfo[playerid][pName]);
						SendFractionMessage(COLOR_BLUE,msg,fam);
					}
					case 5:
					{
						if(Fraction[fam][fMats] < 400) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ������ �� ������� ���������� �� ������(�����: 400)!");
						Fraction[fam][fMats] -= 400;
						ServerGivePlayerWeapon(playerid,25,100);
						format(msg,sizeof(msg),"%s ������ ������ ShotGun,�������� 400 ����������",PlayerInfo[playerid][pName]);
						SendFractionMessage(COLOR_BLUE,msg,fam);
					}
				}
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET mats=%d WHERE id='%i'",Fraction[fam][fMats],fam);
				mysql_query(query);
			}
		}
		case DIALOG_OBSH_DRUGS_POLOZH:
		{
			if(response)
			{
				new fam,string[144];
				if(PlayerInfo[playerid][pLeader] > 0) fam = PlayerInfo[playerid][pLeader];
				else fam = PlayerInfo[playerid][pMember];
				if(PlayerInfo[playerid][pDrugs] < strval(inputtext)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������� ����������!");
				if(strval(inputtext) < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������!");
				PlayerInfo[playerid][pDrugs] -= strval(inputtext);
				Fraction[fam][fDrugs] += strval(inputtext);
				format(string,sizeof(string),"%s ������� � ����� %d ����������. ���������� � ������: %d",PlayerInfo[playerid][pName],strval(inputtext),Fraction[fam][fDrugs]);
				SendFractionMessage(COLOR_BLUE,string,fam);
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET drugs=%d WHERE id='%i'",Fraction[fam][fDrugs],fam);
				mysql_query(query);
			}
		}
		case DIALOG_OBSH_DRUGS_ZABR:
		{
			if(response)
			{
				if(PlayerInfo[playerid][pLeader] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ���������� ��� �������!");
				new fam = PlayerInfo[playerid][pLeader],string[144];
				if(Fraction[fam][fDrugs] < strval(inputtext)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ������ ��� ������� ����������!");
				if(strval(inputtext) < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������!");
				PlayerInfo[playerid][pDrugs] += strval(inputtext);
				Fraction[fam][fDrugs] -= strval(inputtext);
				format(string,sizeof(string),"%s ������ �� ������ %d ����������. ���������� � ������: %d",PlayerInfo[playerid][pName],strval(inputtext),Fraction[fam][fDrugs]);
				SendFractionMessage(COLOR_BLUE,string,fam);
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET drugs=%d WHERE id='%i'",Fraction[fam][fDrugs],fam);
				mysql_query(query);
			}
		}
		case DIALOG_OBSH_MONEY_POLOZH:
		{
			if(response)
			{
				new fam,string[144];
				if(PlayerInfo[playerid][pLeader] > 0) fam = PlayerInfo[playerid][pLeader];
				else fam = PlayerInfo[playerid][pMember];
				if(PlayerInfo[playerid][pMoney] < strval(inputtext)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������� �����!");
				if(strval(inputtext) < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������!");
				SetMoney(playerid,-strval(inputtext));
				Fraction[fam][fMoney] += strval(inputtext);
				format(string,sizeof(string),"%s ������� � ����� %s$. ����� � ������: %s",PlayerInfo[playerid][pName],ConvertCash(strval(inputtext)),ConvertCash(Fraction[fam][fMoney]));
				SendFractionMessage(COLOR_BLUE,string,fam);
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET money=%d WHERE id='%i'",Fraction[fam][fMoney],fam);
				mysql_query(query);
			}
		}
		case DIALOG_OBSH_MONEY_ZABR:
		{
			if(response)
			{
				if(PlayerInfo[playerid][pLeader] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ���������� ��� �������!");
				new fam = PlayerInfo[playerid][pLeader],string[144];
				if(Fraction[fam][fMoney] < strval(inputtext)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ������ ��� ������� �����!");
				if(strval(inputtext) < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������!");
				SetMoney(playerid,strval(inputtext));
				Fraction[fam][fMoney] -= strval(inputtext);
				format(string,sizeof(string),"%s ������ �� ������ %s$. ����� � ������: %s",PlayerInfo[playerid][pName],ConvertCash(strval(inputtext)),ConvertCash(Fraction[fam][fMoney]));
				SendFractionMessage(COLOR_BLUE,string,fam);
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET money=%d WHERE id='%i'",Fraction[fam][fMoney],fam);
				mysql_query(query);
			}
		}
		case DIALOG_LMENU:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SetZam(playerid);
					case 1: Dipl(playerid);
					case 2: SPD(playerid,DIALOG_CVET,DIALOG_STYLE_INPUT,""PREFIX" ��������� ����� �������","{FFFFFF}������� ���� ������� �� 1 �� 99","���������","�����");
					case 3:
					{
						new fam = GetPlayerMember(playerid);
						SendClientMessage(playerid,COLOR_LIGHTBLUE,"�������� ��������� �� ����� ����� ��������");
						for(new i = 1;i < MAX_VEHICLES; i++)
						{
							if(AutoInfo[i][aFraction] == fam) SetVehicleToRespawn(i);
						}
					}
					case 4:
					{
						new fam = GetPlayerMember(playerid);
						if(Fraction[fam][fMoney] < 1500 && !IsACop(playerid) && fam != 4 && fam != 5 && fam != 15 && fam != 14) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ������ ��� 1500$,����������� ��� ��������!");
						SendClientMessage(playerid,COLOR_LIGHTBLUE,"�������� ���������.�� ��������� 1500$");
						Fraction[fam][fMoney] -= 1500;
						new query[80];
						format(query,sizeof(query),"UPDATE `Fractions` SET Money=%d WHERE id='%i'",Fraction[fam][fMoney],fam);
						mysql_query(query);
						for(new i = 1;i < MAX_VEHICLES; i++)
						{
							if(AutoInfo[i][aFraction] == fam) fuel[i] = 100;
						}
					}
					case 5:
					{
						if(response)
						{
							if(!IsAGang(playerid) && !IsAMafia(playerid)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ���� ������ �������� ������ ������/������!");
							new string[255],pistol[50],avtomat[50],xolod[50];
							new fam = GetPlayerMember(playerid);
							GetWeaponName(Fraction[fam][fPistol],pistol,sizeof(pistol));
							if(Fraction[fam][fAvtomat] == 0) { avtomat = "{A20E0E}���{FFFFFF}"; }
							else GetWeaponName(Fraction[fam][fAvtomat],avtomat,sizeof(avtomat));
							if(Fraction[fam][fXolod] == 0) { xolod = "{A20E0E}���{FFFFFF}"; }
							else GetWeaponName(Fraction[fam][fXolod],xolod,sizeof(xolod));
							format(string,sizeof(string),"{3CBBF7}[1]{FFFFFF} ��������:\t%s\n{3CBBF7}[2]{FFFFFF} �������:\t%s\n{3CBBF7}[3]{FFFFFF} �������� ������:\t%s\n{3CBBF7}[4]{FFFFFF} ����� ���������� � ������:\%d\n{3CBBF7}[4]{FFFFFF} ����� ���������� � ������:\%d",pistol,avtomat,xolod,Fraction[fam][fMaxMats],Fraction[fam][fMaxDrugs]);
							SPD(playerid,DIALOG_UPGRADEFRAC,DIALOG_STYLE_LIST,""PREFIX" ��������� �������",string,"�������","�����");
						}
						else Showlmenu(playerid);
					}
				}
			}
		}
        case DIALOG_SETTING_ZAM:
		{
			new fam = PlayerInfo[playerid][pLeader];
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(Fraction[fam][fZamRank] == true) { Fraction[fam][fZamRank] = false; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� �� ����� �������� �����"); }
						else { Fraction[fam][fZamRank] = true; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� ����� �������� �����"); }
					}
					case 1:
					{
						if(Fraction[fam][fZamInvite] == true) { Fraction[fam][fZamInvite] = false; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� �� ����� ��������� �� �������"); }
						else { Fraction[fam][fZamInvite] = true; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� ����� ��������� �� �������"); }
					}
					case 2:
					{
						if(Fraction[fam][fZamKick] == true) { Fraction[fam][fZamKick] = false; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� �� ����� ������ �� �������"); }
						else { Fraction[fam][fZamKick] = true; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� ����� ������ �� �������"); }
					}
					case 3:
					{
						if(Fraction[fam][fZamMute] == true) { Fraction[fam][fZamMute] = false; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� �� ����� ������ ��� ����"); }
						else { Fraction[fam][fZamMute] = true; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� ����� ������ ��� ����"); }
					}
					case 4:
					{
						if(Fraction[fam][fZamUnMute] == true) { Fraction[fam][fZamUnMute] = false; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� �� ����� ������� ��� ����"); }
						else { Fraction[fam][fZamUnMute] = true; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� ����� ������� ��� ����"); }
					}
					case 5:
					{
						if(Fraction[fam][fZamVyg] == true) { Fraction[fam][fZamVyg] = false; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� �� ����� ������ ��������"); }
						else { Fraction[fam][fZamVyg] = true; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� ����� ������ ��������"); }
					}
					case 6:
					{
						if(Fraction[fam][fZamUnVyg] == true) { Fraction[fam][fZamVyg] = false; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� �� ����� ������� ��������"); }
						else { Fraction[fam][fZamUnVyg] = true; SendClientMessage(playerid,COLOR_BLUE,"������ ����������� ����� ������� ��������"); }
					}
				}
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET zamrank=%d,zaminvite=%d,zammute=%d,zamunmute=%d,zamvyg=%d,zamunvyg=%d,zamkcik=%d WHERE id='%i'",Fraction[fam][fZamRank],Fraction[fam][fZamInvite],Fraction[fam][fZamMute],Fraction[fam][fZamUnMute],Fraction[fam][fZamVyg],Fraction[fam][fZamUnVyg],Fraction[fam][fZamKick]);
				mysql_query(query);
			}
		}
		case DIALOG_DIPL:
		{
			new fam;
			if(PlayerInfo[playerid][pLeader] > 0) fam = PlayerInfo[playerid][pLeader];
			else fam = PlayerInfo[playerid][pZam];
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(fam == 6)
						{
							new id = GetLeader(7);
							if(Fraction[6][fBallas] == false)
							{
								if(!IsPlayerConnected(id)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� The Ballas Gang �� � ����!");
								MirOffer[id] = 6;
								new string[128];
								format(string,sizeof(string),"����� The Groove Street Family %s ���������� ��� ���? {FFFFFF}����������� {0F610D}Y{FFFFFF} ��� �������� ��� {F31212}N{FFFFFF} ��� ������",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								format(string,sizeof(string),"�� ���������� ������ The Ballas Gang %s ���.",PlayerInfo[id][pName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							}
							else
							{
								new string[128];
								format(string,sizeof(string),"����� The Groove Street Family %s ������� � ���� ���",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ��� �  The Ballas Gang.");
								Fraction[fam][fBallas] = false;
								Fraction[7][fGroove] = false;
							}
						}
						if(fam == 7)
						{
							new id = GetLeader(6);
							if(Fraction[7][fGroove] == false)
							{
								if(!IsPlayerConnected(id)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� The Groove Street Family �� � ����!");
								MirOffer[id] = 7;
								new string[128];
								format(string,sizeof(string),"����� The Ballas Gang %s ���������� ��� ���? {FFFFFF}����������� {0F610D}Y{FFFFFF} ��� �������� ��� {F31212}N{FFFFFF} ��� ������",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								format(string,sizeof(string),"�� ���������� ������ The Groove Street Family %s ���.",PlayerInfo[id][pName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							}
							else
							{
								new string[128];
								format(string,sizeof(string),"����� The Ballas Gang %s ������� � ���� ���",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ��� � The Groove Street Family.");
								Fraction[fam][fGroove] = false;
								Fraction[6][fBallas] = false;
							}
						}
						if(fam == 8)
						{
							new id = GetLeader(6);
							if(Fraction[8][fGroove] == false)
							{
								if(!IsPlayerConnected(id)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� The Groove Street Family �� � ����!");
								MirOffer[id] = 8;
								new string[128];
								format(string,sizeof(string),"����� Los Santos Vagos %s ���������� ��� ���? {FFFFFF}����������� {0F610D}Y{FFFFFF} ��� �������� ��� {F31212}N{FFFFFF} ��� ������",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								format(string,sizeof(string),"�� ���������� ������ The Groove Street Family %s ���.",PlayerInfo[id][pName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							}
							else
							{
								new string[128];
								format(string,sizeof(string),"����� Los Santos Vagos %s ������� � ���� ���",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ��� � The Groove Street Family.");
								Fraction[fam][fGroove] = false;
								Fraction[6][fVagos] = false;
							}
						}
						if(fam == 10)
						{
							new id = GetLeader(6);
							if(Fraction[10][fGroove] == false)
							{
								if(!IsPlayerConnected(id)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� The Groove Street Family �� � ����!");
								MirOffer[id] = 10;
								new string[128];
								format(string,sizeof(string),"����� El Coronos %s ���������� ��� ���? {FFFFFF}����������� {0F610D}Y{FFFFFF} ��� �������� ��� {F31212}N{FFFFFF} ��� ������",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								format(string,sizeof(string),"�� ���������� ������ The Groove Street Family %s ���.",PlayerInfo[id][pName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							}
							else
							{
								new string[128];
								format(string,sizeof(string),"����� El Coronos %s ������� � ���� ���",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ��� � The Groove Street Family.");
								Fraction[fam][fGroove] = false;
								Fraction[6][fCoronos] = false;
							}
						}
					}
					case 1:
					{
						if(fam == 6)
						{
							new id = GetLeader(10);
							if(Fraction[6][fCoronos] == false)
							{
								if(!IsPlayerConnected(id)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� El Coronos �� � ����!");
								MirOffer[id] = 6;
								new string[128];
								format(string,sizeof(string),"����� The Groove Street Family %s ���������� ��� ���? {FFFFFF}����������� {0F610D}Y{FFFFFF} ��� �������� ��� {F31212}N{FFFFFF} ��� ������",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								format(string,sizeof(string),"�� ���������� ������ El Coronos %s ���.",PlayerInfo[id][pName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							}
							else
							{
								new string[128];
								format(string,sizeof(string),"����� The Groove Street Family %s ������� � ���� ���",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ��� � El Coronos.");
								Fraction[fam][fCoronos] = false;
								Fraction[10][fGroove] = false;
							}
						}
						if(fam == 7)
						{
							new id = GetLeader(10);
							if(Fraction[7][fCoronos] == false)
							{
								if(!IsPlayerConnected(id)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� El Coronos �� � ����!");
								MirOffer[id] = 7;
								new string[128];
								format(string,sizeof(string),"����� The Ballas Gang %s ���������� ��� ���? {FFFFFF}����������� {0F610D}Y{FFFFFF} ��� �������� ��� {F31212}N{FFFFFF} ��� ������",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								format(string,sizeof(string),"�� ���������� ������ El Coronos %s ���.",PlayerInfo[id][pName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							}
							else
							{
								new string[128];
								format(string,sizeof(string),"����� The Ballas Gang %s ������� � ���� ���",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ��� � El Coronos.");
								Fraction[fam][fCoronos] = false;
								Fraction[10][fBallas] = false;
							}
						}
						if(fam == 8)
						{
							new id = GetLeader(7);
							if(Fraction[8][fBallas] == false)
							{
								if(!IsPlayerConnected(id)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� The Ballas Gang �� � ����!");
								MirOffer[id] = 8;
								new string[128];
								format(string,sizeof(string),"����� Los Santos Vagos %s ���������� ��� ���? {FFFFFF}����������� {0F610D}Y{FFFFFF} ��� �������� ��� {F31212}N{FFFFFF} ��� ������",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								format(string,sizeof(string),"�� ���������� ������ The Ballas Gang %s ���.",PlayerInfo[id][pName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							}
							else
							{
								new string[128];
								format(string,sizeof(string),"����� Los Santos Vagos %s ������� � ���� ���",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ��� � The Ballas Gang.");
								Fraction[fam][fBallas] = false;
								Fraction[7][fVagos] = false;
							}
						}
						if(fam == 10)
						{
							new id = GetLeader(6);
							if(Fraction[10][fGroove] == false)
							{
								if(!IsPlayerConnected(id)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� The Groove Street Family �� � ����!");
								MirOffer[id] = 10;
								new string[128];
								format(string,sizeof(string),"����� El Coronos %s ���������� ��� ���? {FFFFFF}����������� {0F610D}Y{FFFFFF} ��� �������� ��� {F31212}N{FFFFFF} ��� ������",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								format(string,sizeof(string),"�� ���������� ������ The Groove Street Family %s ���.",PlayerInfo[id][pName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							}
							else
							{
								new string[128];
								format(string,sizeof(string),"����� El Coronos %s ������� � ���� ���",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ��� � The Groove Street Family.");
								Fraction[fam][fGroove] = false;
								Fraction[6][fCoronos] = false;
							}
						}
					}
					case 2:
					{
						if(fam == 6)
						{
							new id = GetLeader(8);
							if(Fraction[6][fVagos] == false)
							{
								if(!IsPlayerConnected(id)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� Los Santos Vagos �� � ����!");
								MirOffer[id] = 6;
								new string[128];
								format(string,sizeof(string),"����� The Groove Street Family %s ���������� ��� ���? {FFFFFF}����������� {0F610D}Y{FFFFFF} ��� �������� ��� {F31212}N{FFFFFF} ��� ������",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								format(string,sizeof(string),"�� ���������� ������ Los Santos Vagos %s ���.",PlayerInfo[id][pName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							}
							else
							{
								new string[128];
								format(string,sizeof(string),"����� The Groove Street Family %s ������� � ���� ���",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ��� � Los Santos Vagos.");
								Fraction[fam][fVagos] = false;
								Fraction[8][fGroove] = false;
							}
						}
						if(fam == 7)
						{
							new id = GetLeader(8);
							if(Fraction[7][fVagos] == false)
							{
								if(!IsPlayerConnected(id)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� Los Santos Vagos �� � ����!");
								MirOffer[id] = 7;
								new string[128];
								format(string,sizeof(string),"����� The Ballas Gang %s ���������� ��� ���? {FFFFFF}����������� {0F610D}Y{FFFFFF} ��� �������� ��� {F31212}N{FFFFFF} ��� ������",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								format(string,sizeof(string),"�� ���������� ������ Los Santos Vagos %s ���.",PlayerInfo[id][pName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							}
							else
							{
								new string[128];
								format(string,sizeof(string),"����� The Ballas Gang %s ������� � ���� ���",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ��� � Los Santos Vagos.");
								Fraction[fam][fVagos] = false;
								Fraction[8][fBallas] = false;
							}
						}
						if(fam == 8)
						{
							new id = GetLeader(10);
							if(Fraction[8][fCoronos] == false)
							{
								if(!IsPlayerConnected(id)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� El Coronos �� � ����!");
								MirOffer[id] = 8;
								new string[128];
								format(string,sizeof(string),"����� Los Santos Vagos %s ���������� ��� ���? {FFFFFF}����������� {0F610D}Y{FFFFFF} ��� �������� ��� {F31212}N{FFFFFF} ��� ������",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								format(string,sizeof(string),"�� ���������� ������ El Coronos %s ���.",PlayerInfo[id][pName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							}
							else
							{
								new string[128];
								format(string,sizeof(string),"����� Los Santos Vagos %s ������� � ���� ���",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ��� � El Coronos.");
								Fraction[fam][fCoronos] = false;
								Fraction[10][fVagos] = false;
							}
						}
						if(fam == 10)
						{
							new id = GetLeader(8);
							if(Fraction[10][fVagos] == false)
							{
								if(!IsPlayerConnected(id)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� Los Santos Vagos �� � ����!");
								MirOffer[id] = 10;
								new string[128];
								format(string,sizeof(string),"����� El Coronos %s ���������� ��� ���? {FFFFFF}����������� {0F610D}Y{FFFFFF} ��� �������� ��� {F31212}N{FFFFFF} ��� ������",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								format(string,sizeof(string),"�� ���������� ������ Los Santos Vagos %s ���.",PlayerInfo[id][pName]);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							}
							else
							{
								new string[128];
								format(string,sizeof(string),"����� El Coronos %s ������� � ���� ���",PlayerInfo[playerid][pName]);
								SendClientMessage(id,COLOR_LIGHTBLUE,string);
								SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ��� � Los Santos Vagos.");
								Fraction[fam][fVagos] = false;
								Fraction[8][fCoronos] = false;
							}
						}
					}
				}
			}
			SaveDipl(6);
			SaveDipl(7);
			SaveDipl(8);
			SaveDipl(10);
		}
		case DIALOG_CONTROL_CAR:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						new info[255],Float:X,Float:Y,Float:Z;
						GetVehiclePos(PlayerInfo[playerid][pCar],X,Y,Z);
						format(info,sizeof(info),"{D37018}ID ���������:{FFFFFF}\t%d\n{D37018}������:{FFFFFF}\t%s\n{D37018}��������������:{FFFFFF}\t%s\n{D37018}���� 1:{FFFFFF}\t\t%d\n{D37018}���� 2:{FFFFFF}\t\t%d",PlayerInfo[playerid][pCarM],VehicleNames[PlayerInfo[playerid][pCarM]-400],GetZone(X,Y),PlayerInfo[playerid][pCC1],PlayerInfo[playerid][pCC2]);
						SPD(playerid,DIALOG_CONTROL_CAR_INFO,DIALOG_STYLE_MSGBOX,""PREFIX" ��� | ����������",info,"��","������");
					}
					case 1:
					{
						RepairVehicle(PlayerInfo[playerid][pCar]);
						SetVehicleHealthEx(PlayerInfo[playerid][pCar],1000.0);
						RemovePlayerFromVehicle(playerid);
						SetVehiclePos(PlayerInfo[playerid][pCar],PlayerInfo[playerid][pCarX],PlayerInfo[playerid][pCarY],PlayerInfo[playerid][pCarZ]);
						ChangeVehicleColor(PlayerInfo[playerid][pCar],PlayerInfo[playerid][pCC1],PlayerInfo[playerid][pCC2]);
						TuneCar(playerid);
						SetMoney(playerid,-1500);
						SendClientMessage(playerid,COLOR_LIGHTBLUE,"��������� ��������� � ����� ��������.�� ��������� 1500$ �� ��������");
					}
					case 2:
					{
						if(GetPlayerVehicleID(playerid) == 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} �� ������ ���������� � ������!");
						if(GetPlayerVehicleID(playerid) != PlayerInfo[playerid][pCar]) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ��� �� ��� ���������!");
						GetPlayerPos(playerid,PlayerInfo[playerid][pCarX],PlayerInfo[playerid][pCarY],PlayerInfo[playerid][pCarZ]);
						SendClientMessage(playerid,-1,"������� ������� ���������!");
					}
					case 3:
					{
						new Float:X,Float:Y,Float:Z;
						GetVehiclePos(PlayerInfo[playerid][pCar],X,Y,Z);
						point = SetPlayerCheckpoint(playerid,X,Y,Z,3.0);
						SendClientMessage(playerid,COLOR_LIGHTBLUE,"�������������� ��������� ������� �� �����");
					}
					case 4:
					{
						new string[512];
						format(string,sizeof(string),"{FFFFFF}����� �� ��������� ������ �������� �� ������ ����� ��������� ������:\n\n{3CBBF7}[1]{FFFFFF} ���� �� ������ ��� ������ ����������,����� � �� ������������ ���,�� ����� ��� �� ����,����� �������\n{3CBBF7}[2]{FFFFFF} ���� ���������� ����� �������� � �������� ��� �������.�� ���������� �������������\n{3CBBF7}[3]{FFFFFF} ������ ��� �� ����������� �������������\n{3CBBF7}[4]{FFFFFF} �������� ����� �� ������� � ���");
						SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" FAQ �� ������ �����������",string,"��","");
					}
				}
			}
		}
		case DIALOG_CVET:
		{
			new fam = GetPlayerMember(playerid);
			if(response)
			{
				if(strval(inputtext) < 1 || strval(inputtext) > 99) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ���� ������ ���� �� ������ 1 � �� ������ 99!");
				if(strval(inputtext) == Fraction[fam][fCvet]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ���� ���� �������� ����� ������!");
				Fraction[fam][fCvet] = strval(inputtext);
				new query[80];
				format(query,sizeof(query),"UPDATE `Fractions` SET Cvet=%d WHERE id='%i'",Fraction[fam][fCvet],fam);
				mysql_query(query);
				new string[128];
				format(string,sizeof(string),"���� ������� ���������� �� %d",strval(inputtext));
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
			else Showlmenu(playerid);
		}
		case DIALOG_UPGRADEFRAC:
		{
			new fam = GetPlayerMember(playerid);
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(Fraction[fam][fPistol] == 24) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��������� �������� �� ��������!");
						SPD(playerid,DIALOG_UPGRADE_PISTOL,DIALOG_STYLE_MSGBOX,""PREFIX" ��������","{FFFFFF}��������: {157320}Desert Eagle{FFFFFF}\n���������: {157320}350.000{FFFFFF}\n�� ������������� ������ ��������?","��","�����");
					}
					case 1:
					{
						if(Fraction[fam][fAvtomat] == 31) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �������� �������� �� ��������!");
						switch(Fraction[fam][fAvtomat])
						{
							case 0: SPD(playerid,DIALOG_UPGRADE_AVTOMAT,DIALOG_STYLE_MSGBOX,""PREFIX" �������","{FFFFFF}�������: {157320}MP-5{FFFFFF}\n���������: {157320}500.000{FFFFFF}\n�� ������������� ������ ��������?","��","�����");
							case 29: SPD(playerid,DIALOG_UPGRADE_AVTOMAT1,DIALOG_STYLE_MSGBOX,""PREFIX" �������","{FFFFFF}�������: {157320}M-4{FFFFFF}\n���������: {157320}750.000{FFFFFF}\n�� ������������� ������ ��������?","��","�����");
						}
					}
					case 2:
					{
						if(Fraction[fam][fXolod] == 5) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �������� ������ �������� �� ��������!");
						switch(Fraction[fam][fXolod])
						{
							case 0: SPD(playerid,DIALOG_UPGRADE_XOLOD,DIALOG_STYLE_MSGBOX,""PREFIX" �������� ������","{FFFFFF}�������� ������: {157320}������{FFFFFF}\n���������: {157320}100.000{FFFFFF}\n�� ������������� ������ ��������?","��","�����");
							case 1: SPD(playerid,DIALOG_UPGRADE_XOLOD1,DIALOG_STYLE_MSGBOX,""PREFIX" �������� ������","{FFFFFF}�������: {157320}����{FFFFFF}\n���������: {157320}150.000{FFFFFF}\n�� ������������� ������ ��������?","��","�����");
						}
					}
					case 3: SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��������� �������� �� ��������!");
					case 4: SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��������� �������� �� ��������!");
				}
			}
			else Showlmenu(playerid);
		}
    	case DIALOG_UPGRADE_PISTOL:
		{
			if(response)
			{
				new fam = GetPlayerMember(playerid);
				if(Fraction[fam][fMoney] < 350000) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ������� ���������� ����� 350.000$ � ������!");
				Fraction[fam][fMoney] -= 350000;
				Fraction[fam][fPistol] = 24;
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� � ���� ������� Desert Eagle");
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET Pistol=24,Money=%d WHERE ID='%i'",Fraction[fam][fMoney],fam);
				mysql_query(query);
			}
			else Showlmenu(playerid);
		}
		case DIALOG_UPGRADE_AVTOMAT:
		{
			if(response)
			{
				new fam = GetPlayerMember(playerid);
				if(Fraction[fam][fMoney] < 500000) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ������� ���������� ����� 500.000$ � ������!");
				Fraction[fam][fMoney] -= 500000;
				Fraction[fam][fAvtomat] = 29;
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� � ���� ������� MP-5");
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET Avtomat=%d,Money=%d WHERE ID='%i'",Fraction[fam][fXolod],Fraction[fam][fMoney],fam);
				mysql_query(query);
			}
			else Showlmenu(playerid);
		}
		case DIALOG_UPGRADE_AVTOMAT1:
		{
			if(response)
			{
				new fam = GetPlayerMember(playerid);
				if(Fraction[fam][fMoney] < 750000) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ������� ���������� ����� 750.000$ � ������!");
				Fraction[fam][fMoney] -= 750000;
				Fraction[fam][fAvtomat] = 31;
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� � ���� ������� M-4");
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET Avtomat=%d,Money=%d WHERE ID='%i'",Fraction[fam][fXolod],Fraction[fam][fMoney],fam);
				mysql_query(query);
			}
			else Showlmenu(playerid);
		}
		case DIALOG_UPGRADE_XOLOD:
		{
			if(response)
			{
				new fam = GetPlayerMember(playerid);
				if(Fraction[fam][fMoney] < 150000) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ������� ���������� ����� 150.000$ � ������!");
				Fraction[fam][fMoney] -= 150000;
				Fraction[fam][fXolod] = 1;
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� � ���� ������� ������");
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET Xolod=%d,Money=%d WHERE ID='%i'",Fraction[fam][fXolod],Fraction[fam][fMoney],fam);
				mysql_query(query);
			}
			else Showlmenu(playerid);
		}
		case DIALOG_UPGRADE_XOLOD1:
		{
			if(response)
			{
				new fam = GetPlayerMember(playerid);
				if(Fraction[fam][fMoney] < 100000) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ������� ���������� ����� 100.000$ � ������!");
				Fraction[fam][fMoney] -= 100000;
				Fraction[fam][fXolod] = 5;
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� � ���� ������� ����");
				new query[512];
				format(query,sizeof(query),"UPDATE `Fractions` SET Xolod=%d,Money=%d WHERE ID='%i'",Fraction[fam][fXolod],Fraction[fam][fMoney],fam);
				mysql_query(query);
			}
			else Showlmenu(playerid);
		}
		case DIALOG_HELP:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						new string[1024],string1[128],string2[255], string3[128],fam = GetPlayerMember(playerid);
						for(new i; i < 15; i++) {
							format(string1, sizeof(string1), ""YE"%s",HelpMSG[i]);
							strcat(string, string1);
						}
						if(PlayerInfo[playerid][pJob] == 1) { format(string1,sizeof(string1),"\n������:\n {37B8B6}/makegun{FFFFFF} - ������� ������"); strcat(string, string1); }
						else if(PlayerInfo[playerid][pJob] == 4) { format(string1,sizeof(string1),"\n������:\n {37B8B6}/selldrugs{FFFFFF} - ������� ���������"); strcat(string, string1); }
						else if(PlayerInfo[playerid][pJob] == 6) { format(string1,sizeof(string1),"\n������:\n {37B8B6}/fare{FFFFFF} - ����� �� ������"); strcat(string, string1); }
						if(IsACop(playerid)) {
							format(string2,sizeof(string2),"\n�������:\n {37B8B6}/su{FFFFFF} - �������� ������ � ������\n{37B8B6}/cuff{FFFFFF} - ������ �� ������ ���������\n{37B8B6}/tazer{FFFFFF} - ������� ������ �������\n{37B8B6}/putcop{FFFFFF} - �������� ������ � ������\n{37B8B6}/putout{FFFFFF} - �������� ������ �� ������\n{37B8B6}/clear{FFFFFF} - �������� ������ ������\n{37B8B6}/wanted{FFFFFF} - ������ �������������");
							format(string3, sizeof(string3), "\n{37B8B6}/cstrips{FFFFFF} - ������� ������ � ������\n{37B8B6}/dstrips{FFFFFF} - ������� ������ � ������");
						}
						else if(fam == 5) format(string2,sizeof(string2),"\n�������:\n {37B8B6}/news{FFFFFF} - �������� � ��������� ���");
						else if(fam == 15) format(string2,sizeof(string2),"\n�������:\n {37B8B6}/free{FFFFFF} - ��������� ������ �� ������");
						strcat(string,string2);
						strcat(string, string3);
						SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" �������� �������",string,"��","");
					}
					case 1: SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" ������� ��������","{37B8B6}/iznas{FFFFFF} - ������������ ������\n{37B8B6}/piss{FFFFFF} -  �������� �����","��","������");
					case 2:
					{
						if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ���������� ���� ������!");
						switch(PlayerInfo[playerid][pAdmin])
						{
							case 1: SendClientMessage(playerid,COLOR_LIGHTGREEN,"/goto, /gethere, /veh, /ban, /warn, /mute, /kick, /slap, /spec(/specoff), /vehd, /gm");
							case 2: { SendClientMessage(playerid,COLOR_LIGHTGREEN,"/unwarn, /unmute, /fixveh"); SendClientMessage(playerid,COLOR_LIGHTGREEN,"/goto, /gethere, /veh, /ban, /warn, /mute, /kick, /slap, /spec(/specoff), /vehd, /gm"); }
							case 3: { SendClientMessage(playerid,COLOR_LIGHTGREEN,"/unwarn, /unmute, /fixveh"); SendClientMessage(playerid,COLOR_LIGHTGREEN,"/goto, /gethere, /veh, /ban, /warn, /mute, /kick, /slap, /spec(/specoff), /vehd, /gm"); SendClientMessage(playerid,COLOR_LIGHTGREEN,"/givegun, /sethp, /setarmor"); }
							case 4: { SendClientMessage(playerid,COLOR_LIGHTGREEN,"/unwarn, /unmute, /fixveh"); SendClientMessage(playerid,COLOR_LIGHTGREEN,"/goto, /gethere, /veh, /ban, /warn, /mute, /kick, /slap, /spec(/specoff), /vehd, /gm"); SendClientMessage(playerid,COLOR_LIGHTGREEN,"/givegun, /sethp, /setarmor /showfc"); }
							case 5: { SendClientMessage(playerid,COLOR_LIGHTGREEN,"/unwarn, /unmute, /fixveh"); SendClientMessage(playerid,COLOR_LIGHTGREEN,"/goto, /gethere, /veh, /ban, /warn, /mute, /kick, /slap, /spec(/specoff), /vehd, /gm"); SendClientMessage(playerid,COLOR_LIGHTGREEN,"/givegun, /sethp, /setarmor, /makeleader, /unban, /banlist /checkleader /checkleaders /showfc"); }
							case 6: { SendClientMessage(playerid,COLOR_LIGHTGREEN,"/unwarn, /unmute, /fixveh"); SendClientMessage(playerid,COLOR_LIGHTGREEN,"/goto, /gethere, /veh, /ban, /warn, /mute, /kick, /slap, /spec(/specoff), /vehd, /gm"); SendClientMessage(playerid,COLOR_LIGHTGREEN,"/givegun, /sethp, /setarmor, /makeleader, /unban, /banlist /checkleader /checkleaders /showfc"); }
						}
					}
					case 3: SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" ������� ����","{37B8B6}/pm{FFFFFF} - ������ ���������\n{37B8B6}/f(amily){FFFFFF} - ��� �������\n{37B8B6}/r(adio){FFFFFF} - ����� ���������� � �������\n{37B8B6}/s(hout){FFFFFF} - �������\n{37B8B6}/gov{FFFFFF} - ������� ��� �������� �������\n{37B8B6}/news{FFFFFF} - ������� �������� ��� ���������","��","������");
					case 4:
					{
						if(PlayerInfo[playerid][pLeader] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ���������� ���� ������!");
						new string[512],help[1024],string1[512];
						format(string,sizeof(string),"{37B8B6}/invite{FFFFFF} - ���������� ������ �� �������\n{37B8B6}/uninvite{FFFFFF} - ������� ������ �� �������\n{37B8B6}/giverank{FFFFFF} - ���� ������ ����\n{37B8B6}/fwarn{FFFFFF} - ���� ������ �������\n{37B8B6}/unfwarn{FFFFFF} - ����� ������ �������");
						strmid(help,string,0,512);
						format(string1,sizeof(string1),"\n{37B8B6}/fmute{FFFFFF} - ���� ������ ���\n{37B8B6}/unfmute{FFFFFF} - ����� ������ ���\n{37B8B6}/makezam{FFFFFF} - ���� ������ ���� �����������\n{37B8B6}/unmakezam{FFFFFF} - ����� � ������ ���� �����������\n{37B8B6}/lmenu{FFFFFF} - ����� ����\n{37B8B6}/l{FFFFFF} - ��� �������");
						format(help,sizeof(help),"%s%s",string,string1);
						SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" ������� ������",help,"��","");
					}
				}
			}
			else ShowKpk(playerid);
		}
		case DIALOG_MALE:
		{
			if(response) { PlayerInfo[playerid][pMale] = false; PlayerInfo[playerid][pSkin] = DEFAULTSKIN; }
			else { PlayerInfo[playerid][pMale] = true; PlayerInfo[playerid][pSkin] = 12; }
			SPD(playerid,DIALOG_PRIGLASIL,DIALOG_STYLE_INPUT,""PREFIX"  ��� �������������",""YE"������� ��� ������,������������� ��� �� ������:","���","�������");
		}
		case DIALOG_KPK_PASS:
		{
			if(response)
			{
				new query[255],string[144];
				format(query,sizeof(query),"UPDATE `Accounts` SET Password = '%s' WHERE Nickname = '%s'",strval(inputtext),PlayerInfo[playerid][pName]);
				mysql_query(query);
				format(string,sizeof(string),"�� ������� ������ �� %s.�������� ��������(������� F8),����� �� ������ ���",inputtext);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				format(string,sizeof(string),"����� %s[%d] ������ ���� ������ �� %s",PlayerInfo[playerid][pName],playerid,inputtext);
				SendAdminMessage(COLOR_LIGHTRED,string,6);
				strmid(PlayerInfo[playerid][pPassword], inputtext, 0, 64, 64);
			}
		}
		case DIALOG_PRIGLASIL:
		{
			if(response && strlen(inputtext) > 0 && !IsPlayerName(playerid, PlayerInfo[playerid][pName]))
			{
				strmid(PlayerInfo[playerid][pPriglasil], inputtext, 0, strlen(inputtext), 64);
				new string[128];
				format(string,sizeof(string),"��� ��������� �� ������: {3CBBF7}%s{FFFFFF}",PlayerInfo[playerid][pPriglasil]);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
			PlayerInfo[playerid][pSpawn] = 0;
			PlayerInfo[playerid][pReg] = true;
			PlayerInfo[playerid][pLic][1] = true;
			SetModel(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
			for(new t; t != 12; t++) TextDrawShowForPlayer(playerid, textdraw1[t]);
			SelectTextDraw(playerid, 0xFFFF00AA);
			SetSpawnInfo(playerid,0,0,0,0,0,0,0,0,0,0,0,0);
			SpawnPlayer(playerid);
			PlayerSpawns(playerid);
			SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} ��������� /kpk, ��� �� ������� ����� �������� ����������!");
			SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} � �������� ������ �� ������������� ������ ������������ �����!");
			SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} ��������� /kpk -> GPS ��������� -> ������ -> ��� �� ������� ������, ��� ������ ������");
		}
		case DIALOG_APANEL:
		{
		    if(response)
		    {
		        switch(listitem)
		        {
		            case 1: {if(PlayerInfo[playerid][pAdmin] != 6) return true; SPD(playerid,DIALOG_WEATHER,DIALOG_STYLE_LIST, "{FFFFFF}������ ������", "{FFFFFF}[1] ��������� ������\n[2] ����� ��������� ������\n[3] �����\n[4] �������� � �����\n[5] ������ � ���������\n[6] �������� ���� \n[7] �������� � �����������\n[8] � ������� �������� ���������\n[9] ������ � ����� ������� \n[10] ������� � ���� \n[11] ������ ������� ���������� \n[12] ������� ����", "�������", "������");}
		        	case 2: _checkleaders(playerid,"is");
		        }
		    }
		}
		case DIALOG_WEATHER:
		{
		    if(response)
		    {
				switch(listitem)
				{
				    case 0: SetWeather(10);
				    case 1: SetWeather(11);
				    case 2: SetWeather(8);
				    case 3: SetWeather(9);
				    case 4: SetWeather(14);
				    case 5: SetWeather(19);
				    case 6: SetWeather(20);
				    case 7: SetWeather(23);
				    case 8: SetWeather(27);
				    case 9: SetWeather(30);
				    case 10: SetWeather(33);
				    case 11: SetWeather(-1337);
				}
  				SendClientMessage(playerid,COLOR_LIGHTBLUE,"������ ��������");
			}
			else ShowAPanel(playerid);
		}
		case DIALOG_MASK:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SetPlayerSkin(playerid,29);
					case 1: SetPlayerSkin(playerid,79);
					case 2: SetPlayerSkin(playerid,23);
					case 3: SetPlayerSkin(playerid,260);
					case 4: SetPlayerSkin(playerid,261);
					case 5: SetPlayerSkin(playerid,266);
					case 6: SetPlayerSkin(playerid,104);
					case 7: { SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]); snimaet[playerid] = true; }
				}
				if(snimaet[playerid] == false)
				{
					PlayerInfo[playerid][pMask] = true;
					foreach(Player,i) { ShowPlayerNameTagForPlayer(i, playerid, 0); }
				}
				else
				{
					PlayerInfo[playerid][pMask] = false;
					foreach(Player,i) { ShowPlayerNameTagForPlayer(i, playerid, 1); }
					snimaet[playerid] = false;
				}
			}
		}
		case DIALOG_PORTABLE:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						foreach(Player,i)
						{
							if(PlayerInfo[i][pContract] > 0)
							{
								new string[144],contracts[255];
								format(string,sizeof(string),"������: %s[%d]. ��������������: %d\n",PlayerInfo[i][pName],i,PlayerInfo[i][pContract]);
								strcat(contracts,string);
								SPD(playerid,DIALOG_CONTRACTS,DIALOG_STYLE_LIST,""PREFIX" ���������",contracts,"�������","������");
								return true;
							}
						}
					}
					case 1:
					{
						new string[144],online[255],contract[50];
						foreach(Player,i)
						{
							new fam = GetPlayerMember(i);
							if(fam == 14)
							{
								if(Contract[i] > -1) { contract = "{177D15}����{FFFFFF}"; }
								else { contract = "{D70808}����{FFFFFF}"; }
								format(string,sizeof(string),"������: %s[%d]. ��������: %s\n",PlayerInfo[i][pName],i,contract);
								strcat(online,string);
								SPD(playerid,999,DIALOG_STYLE_LIST,""PREFIX" ������� ������",online,"��","");
							}
						}
					}
					case 2:
					{
						if(Contract[playerid] == -1) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������!");
						new contact[255];
						format(contact,sizeof(contact),"{177D15}���:{FFFFFF} %s\n{177D15}ID:{FFFFFF} %d\n{177D15}��������������:{FFFFFF} %d",PlayerInfo[Contract[playerid]][pName],Contract[playerid],PlayerInfo[Contract[playerid]][pContract]);
						SPD(playerid,DIALOG_CONTRACT,DIALOG_STYLE_MSGBOX,""PREFIX" ������� ��������",contact,"��","�������� �����");
					}
				}
			}
		}
		case DIALOG_CONTRACT:
		{
			if(!response) { Contract[playerid] = 0; SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� �����"); }
		}
		case DIALOG_CONTRACTS:
		{
			if(response)
			{
				if(PlayerInfo[playerid][pRank] < 3) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ����� 3 ���� ����� �������� ������!");
			}
		}
		case DIALOG_KPK_CHAT:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(togoo[playerid] == false) { togoo[playerid] = true; SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� ����� ��������� � ����� ����"); }
						else { togoo[playerid] = false; SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� ����� ��������� � ����� ����"); }
					}
					case 1:
					{
						if(togf[playerid] == false) { togf[playerid] = true; SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� ����� ��������� � ����������� ����"); }
						else { togf[playerid] = false; SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� ����� ��������� � ����������� ����"); }
					}
					case 2:
					{
						if(togpm[playerid] == false) { togpm[playerid] = true; SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� ����� ������ ���������"); }
						else { togpm[playerid] = false; SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� ����� ������ ���������"); }
					}
				}
			}
		}
		case DIALOG_CAR_CONTROL:
		{
			new engine,lights,alarm,doors,bonnet,boot,objective;
			new vehicle = GetPlayerVehicleID(playerid);
			GetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, boot, objective);
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(engine == 0 && zavodit[playerid] == false && fuel[vehicle] > 0)
						{
							SetTimerEx("Zavodka", 3000, false, "i", playerid);
							new string[128];
							SetPVarInt(playerid,"vehplayer",vehicle);
							if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"%s �������� ������� ���������",PlayerInfo[playerid][pName]);
							else format(string,sizeof(string),"����������� �������� ������� ���������");
							SendRadiusMessage(15.0, playerid, string,COLOR_PURPLE);
							zavodit[playerid] = true;
						}
						else
						{
							new string[128];
							ToggleEngine(vehicle, VEHICLE_PARAMS_OFF);
							if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"%s ��������(�) ���������",PlayerInfo[playerid][pName]);
							else format(string,sizeof(string),"����������� ��������(�) ���������");
							SendRadiusMessage(15.0, playerid, string,COLOR_PURPLE);
						}
					}
					case 1:
					{
						if(lights == 0) SetVehicleParamsEx(vehicle, engine, 1, alarm, doors, bonnet, boot, objective);
						else SetVehicleParamsEx(vehicle, engine, 0, alarm, doors, bonnet, boot, objective);
					}
					case 2:
					{
					}
					case 3:
					{
						if(bonnet == 0) SetVehicleParamsEx(vehicle, engine, lights, alarm, doors, 1, boot, objective);
						else SetVehicleParamsEx(vehicle, engine, lights, alarm, doors, 0, boot, objective);
					}
					case 4:
					{
						if(boot == 0) SetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, 1, objective);
						else SetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, 0, objective);
					}
					case 5:
					{
						if(benzo[vehicle] == false) benzo[vehicle] = true;
						else benzo[vehicle] = false;
					}
				}
			}
		}
		case DIALOG_DONAT: 
		{
			if(!response) return true;
			switch(listitem) {
				case 0: SPD(playerid, DIALOG_DONAT+100, DIALOG_STYLE_INPUT, ""PREFIX" ����� ����", ""WHT"������� ���� ����� ������� ���", "�����", "������");
				case 1:
				{
					if(PlayerInfo[playerid][pDM] < 60) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ Donate Money!");
					PlayerInfo[playerid][pDM] -= 60;
					PlayerInfo[playerid][pLevel] ++;
					PlayerInfo[playerid][pExpNext] += 3;
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "�� �������� ���� ������� ������� �� ���� �������");
					return true;
				}
				case 2:
				{
					if(PlayerInfo[playerid][pDM] < 50) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ Donate Money!");
					if(PlayerInfo[playerid][pWarn] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ��������������!");
					PlayerInfo[playerid][pDM] -= 50;
					PlayerInfo[playerid][pWarn] --;
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "�� ����� ���� ��������������");
					return true;
				}
				case 3:
				{
					if(PlayerInfo[playerid][pDM] < 100) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ Donate Money!");
					if(PlayerInfo[playerid][pVIP] == true) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� VIP!");
					PlayerInfo[playerid][pDM] -= 100;
					PlayerInfo[playerid][pVIP] = true;
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "�� ��������� ���� VIP �������. ��������� ���������� � /viphelp");
					return true;
				}
				case 4:
				{
					if(PlayerInfo[playerid][pDM] < 100) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ Donate Money!");
					PlayerInfo[playerid][pMats] += 100000;
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "�� ��������� ���� 100� ����������");
					return true;
				}
				case 5:
				{
					if(PlayerInfo[playerid][pDM] < 200) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ Donate Money!");
					PlayerInfo[playerid][pDrugs] += 100000;
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "�� ��������� ���� 100� ����������");
					return true;
				}
			}
		}
		case DIALOG_DONAT+101: {
			if(!response) return true;
			new code = strval(inputtext), string[128], query[200];
			format(string, sizeof(string),"SELECT sum FROM unitpay_payments WHERE unitpayId = '%d'",code);
			mysql_query(query,dh);
			mysql_store_result();
			if(mysql_num_rows()) {
				new name[24], money;
				mysql_fetch_row_format(name, "|");
				sscanf(name, "p<|>d",money);
				PlayerInfo[playerid][pDM] += money;
				format(string, sizeof(string),"��� ������� �������� �� %d .",money);
				SendClientMessage(playerid, COLOR_ORANGE, string);
				format(string, sizeof(string),"DELETE FROM unitpay_payments WHERE unitpayId = '%d'",code);
				mysql_query(query,dh);
			}
		}
		case DIALOG_DONAT+100:
		{
			if(!response) return true;
			if(PlayerInfo[playerid][pDM] < 50) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ Donate Money!");
			new query[255];
			format(query, sizeof(query), "SELECT * FROM `Accounts` WHERE Nickname = '%s'", strval(inputtext));
			mysql_query(query);
			mysql_store_result();
			if(!mysql_num_rows()) {
				SetPlayerName(playerid, inputtext);
				strmid(PlayerInfo[playerid][pName], inputtext, 0, 64, 64);
			}
			else SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF}  ���� ��� ��� ���������������");
		}	
		case DIALOG_LIC_BUY:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ������� ���� �������� ��� ��������� 1 �������!");
						if(GetMoney(playerid) < 15000) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(PlayerInfo[playerid][pLic][2] == true) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ���� ��� ��������!");
						PlayerInfo[playerid][pLic][2] = true;
						SetMoney(playerid,-1500);
						SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ������ �������� �� ���������� ������ �����������!");
					}
					case 1:
					{
						if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ������� ���� �������� ��� ��������� 1 �������!");
						if(GetMoney(playerid) < 15000) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(PlayerInfo[playerid][pLic][3] == true) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ���� ��� ��������!");
						PlayerInfo[playerid][pLic][3] = true;
						SetMoney(playerid,-1500);
						SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ������ �������� �� ���������� ������ �����������!");
					}
					case 2:
					{
						if(PlayerInfo[playerid][pLevel] < 3) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ������� ���� �������� ��� ��������� 3 �������!");
						if(GetMoney(playerid) < 30000) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(PlayerInfo[playerid][pLic][4] == true) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ���� ��� ��������!");
						PlayerInfo[playerid][pLic][4] = true;
						SetMoney(playerid,-9000);
						SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ������ �������� �� ������� ������!");
					}
				}
			}
		}
		case DIALOG_BUY_GUN:
		{
			if(response)
			{
				gunin[playerid] = listitem;
				SPD(playerid,DIALOG_BUY_GUN_PATRON,DIALOG_STYLE_INPUT,""PREFIX" ���-�� ������","{FFFFFF}������� ������ ��� ���-�� ������","���","������");
			}
		}
		case DIALOG_BUY_GUN_PATRON:
		{
			if(response)
			{
				if(strval(inputtext) <= 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����������!");
				switch(gunin[playerid])
				{
					case 0: { pricegun[playerid] = 10; gunid[playerid] = 22; }
					case 1: { pricegun[playerid] = 15; gunid[playerid] = 23; }
					case 2: { pricegun[playerid] = 30; gunid[playerid] = 24; }
					case 3: { pricegun[playerid] = 40; gunid[playerid] = 25; }
					case 4: { pricegun[playerid] = 35; gunid[playerid] = 29; }
					case 5: { pricegun[playerid] = 50; gunid[playerid] = 30; }
					case 6: { pricegun[playerid] = 50; gunid[playerid] = 31; }
				}
				new summa = pricegun[playerid]*strval(inputtext);
				if(summa > GetMoney(playerid)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
				SetMoney(playerid,-summa);
				Ammo[GetPlayerVirtualWorld(playerid)][amBank] += summa;
				new string[144],name[32];
				GetWeaponName(gunid[playerid],name,sizeof(name));
				format(string,sizeof(string),"�� ������ %s � %d ��������� �� %d$",name,strval(inputtext),summa);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				ServerGivePlayerWeapon(playerid,gunid[playerid],strval(inputtext));
				pricegun[playerid] = 0;
				gunid[playerid] = 0;
				gunin[playerid] = 0;
			}
		}
		case DIALOG_CONTROL_AMMO:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						new id = PlayerInfo[playerid][pAmmo];
						new stats[512];
						format(stats,sizeof(stats),"{D37018}ID ���������:{FFFFFF}\t\t%d\n{D37018}��������������:{FFFFFF} \t%s\n{D37018}�����:{FFFFFF} \t\t\t%s",Ammo[id][amID],GetZone(Ammo[id][amEnterX],Ammo[id][amEnterZ]),ConvertCash(Ammo[id][amBank]));
						SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" ����������",stats,"��","");
					}
					case 1: SPD(playerid,DIALOG_AMMO_VXOD,DIALOG_STYLE_INPUT,""PREFIX" ��������� �����","{FFFFFF}������� ��������� �����","��","");
					case 2:
					{
							new ammo = PlayerInfo[playerid][pAmmo];
							Ammo[ammo][amOwned] = false;
							strmid(Ammo[ammo][amOwner], "The State", 0, strlen("The State"), 255);
							SendClientMessage(playerid,-1,"{FFFFFF}��������� {147130}�������{FFFFFF} �������!");
							SaveAmmo(ammo);
							UpdateAmmoText(ammo);
							PlayerInfo[playerid][pAmmo] = 0;
					}
					case 3:
					{
						new string[255];
						new ammo = PlayerInfo[playerid][pAmmo];
						format(string,sizeof(string),"{FFFFFF} ����� �� �����: %s. ������� ������ �����?",ConvertCash(Ammo[ammo][amBank]));
						SPD(playerid,DIALOG_AMMO_SNYAT,DIALOG_STYLE_INPUT,""PREFIX" ����� ������",string,"��","");
					}
				}
			}
		}
		case DIALOG_AMMO_SNYAT:
		{
			if(response)
			{
				new ammo = PlayerInfo[playerid][pAmmo];
				if(strval(inputtext) > Ammo[ammo][amBank]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ����� ������� � �� �����!");
				Ammo[ammo][amBank] -= strval(inputtext);
				SetMoney(playerid,strval(inputtext));
				new string[128];
				format(string,sizeof(string),"�� ����� �� ����� %s. �������: %s",ConvertCash(strval(inputtext)),ConvertCash(Ammo[ammo][amBank]));
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
		}
		case DIALOG_AMMO_VXOD:
		{
			if(response)
			{
				new ammo = PlayerInfo[playerid][pAmmo];
				if(strval(inputtext) > 1000 || strval(inputtext) < 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} C�������� ����� �� ����� ���� ������ 0 � ������ 1000 !");
				Ammo[ammo][amPriceVx] = strval(inputtext);
				new string[128];
				format(string,sizeof(string),"�� ���������� ��������� ����� �� %s",ConvertCash(Ammo[ammo][amPriceVx]));
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				UpdateAmmoText(ammo);
			}
		}
		case DIALOG_BUY:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(GetMoney(playerid) < 5000) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ������ ����� ������� �� 1500$");
						PlayerInfo[playerid][pOtm] ++;
						SetMoney(playerid,-5000);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "�� ������ �������");
					}
					case 1:
					{
						if(GetMoney(playerid) < 150) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						ServerGivePlayerWeapon(playerid, 43, 150);
						SetMoney(playerid,-150);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "�� ������ �����������");
					}
					case 2:
					{
						if(GetMoney(playerid) < 100) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(PlayerInfo[playerid][pSmoke] >= 100) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ���������� �������!");
						SetMoney(playerid,-100);
						PlayerInfo[playerid][pSmoke] += 20;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "�� ������ ����� �������");
					}
					case 3:
					{
						if(GetMoney(playerid) < 100) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(PlayerInfo[playerid][pTie] == true) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ���� �������. ������� ����������� ��!");
						SetMoney(playerid,-100);
						PlayerInfo[playerid][pTie] = true;
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "�� ������ �������");
					}
					case 4:
					{
						if(GetMoney(playerid) < 100) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(GetPVarInt(playerid, "lotto") > 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ��� ��� ���� ���������� �����");
						SetPVarInt(playerid, "lotto", random_ex(100, 999, 1));
						lotto ++;
						new hour; 
						gettime(hour); 
						new rulesdialog[700],string[144]; 
						SendClientMessage(playerid, C_BLUE, "�� ������ ���������� �����"); 
						format(string,sizeof(string), "���� ���������� �����: {ffd200}%d\n\n",GetPVarInt(playerid, "lotto")),strcat(rulesdialog,string); 
						strcat(rulesdialog, "{ffffff}�� ���������������� � �������, ���������� ����� �������� ��\n"); 
						format(string,sizeof(string), "{ffffff}����� ���������� ���������, ������� ������� � %d:02\n",hour+1), strcat(rulesdialog,string); 
						strcat(rulesdialog, "{ffffff}�� �������� �� ���� ����� ������� � �� �������.\n\n"); 
						strcat(rulesdialog, "{ffffff}������� ����� �������� ������� �� ���� ����� � �\n"); 
						strcat(rulesdialog, "{ffffff}����� ���������� ����� � � �����, ������� �������� ��\n"); 
						strcat(rulesdialog, "{ffffff}����� ���������.\n\n");  
						return ShowPlayerDialog(playerid, 999, 1,""PREFIX" �������", rulesdialog, "��", ""); 
					}
				}
			}
		}
		case DIALOG_CONTROL_MAGAZIN:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						new string[255];
						new id = PlayerInfo[playerid][pMagazin];
						format(string,sizeof(string),"{D37018}ID ��������:{FFFFFF}\t\t%d\n{D37018}�����������������:{FFFFFF}\t%s\n{D37018}�������:{FFFFFF}\t\t%d\n{D37018}����� � �����:{FFFFFF}\t\t%d",id,GetZone(Magazin[id][mEnterX],Magazin[id][mEnterZ]),Magazin[id][mLevel],Magazin[id][mBank]);
						SPD(playerid,DIALOG_GAS_INFO,DIALOG_STYLE_MSGBOX,""PREFIX" ������� | ����������",string,"��","������");
					}
					case 1:
					{
						new magaz4ik = PlayerInfo[playerid][pMagazin];
						Magazin[magaz4ik][mOwned] = false;
						strmid(Magazin[magaz4ik][mOwner], "The State", 0, strlen("The State"), 255);
						SendClientMessage(playerid,-1,"{FFFFFF}������� {147130}�������{FFFFFF} ������!");
						SaveMagazin(magaz4ik);
						UpdateMagazinText(magaz4ik);
						PlayerInfo[playerid][pMagazin] = 0;
					}
					case 2: SPD(playerid,DIALOG_MAZAGIN_SNYAT,DIALOG_STYLE_INPUT,""PREFIX" ��� | �������� ��������","{FFFFFF} ������� �����, ������� �� ������ �����","��","�����");
				}
			}
		}
		case DIALOG_CONTROL_CLUB:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						new string[255];
						new id = PlayerInfo[playerid][pClub];
						format(string,sizeof(string),"{D37018}ID ���������:{FFFFFF}\t\t%d\n{D37018}�����������������:{FFFFFF}\t%s\n{D37018}�������:{FFFFFF}\t\t%d\n{D37018}����� � �����:{FFFFFF}\t\t%d\n{D37018}C�������� �����:{FFFFFF}\t%d",id,GetZone(Club[id][cEnterX],Club[id][cEnterZ]),Club[id][cLevel],Club[id][cBank],Club[id][cPriceVx]);
						SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" ��������� | ����������",string,"��","������");
					}
					case 1:
					{
						new id = PlayerInfo[playerid][pClub];
						Club[id][cOwned] = false;
						strmid(Club[id][cOwner], "The State", 0, strlen("The State"), 255);
						SendClientMessage(playerid,-1,"{FFFFFF}�������� {147130}�������{FFFFFF} ������!");
						SaveClub(id);
						UpdateClubText(id);
						PlayerInfo[playerid][pClub] = 0;
					}
					case 2: SPD(playerid,DIALOG_CLUB_SNYAT,DIALOG_STYLE_INPUT,""PREFIX" ��� | �������� ���������","{FFFFFF} ������� �����, ������� �� ������ �����","��","�����");
					case 3: SPD(playerid,DIALOG_CLUB_PRICEVX,DIALOG_STYLE_INPUT,""PREFIX" ��� | �������� ���������","{FFFFFF} ����� ����� �� ���� � ���� ���������","��","�����");
				}
			}
		}
		case DIALOG_CLUB_SNYAT:
		{
			if(response)
			{
				new id = PlayerInfo[playerid][pClub];
				if(strval(inputtext) > Club[id][cBank]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��������� ��� ����� �����!");
				if(strval(inputtext) <= 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����������!");
				SetMoney(playerid,strval(inputtext));
				Club[id][cBank] -= strval(inputtext);
				new string[128];
				format(string,sizeof(string),"�� ������� �� ��������� %s$. �������: %s$",ConvertCash(strval(inputtext)),ConvertCash(Club[id][cBank]));
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
		}
		case DIALOG_CLUB_PRICEVX:
		{
			new id = PlayerInfo[playerid][pClub];
			if(strval(inputtext) > 1000000 || strval(inputtext) < 0 ) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ������ 0 � �� ������ 1.000.000!");
			Club[id][cPriceVx] = strval(inputtext);
			UpdateClubText(id);
			new string[128];
			format(string,sizeof(string),"��������� ����� � ���� ��������� ������: %s$",ConvertCash(strval(inputtext)));
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		}
		case DIALOG_MAZAGIN_SNYAT:
		{
			if(response)
			{
				new id = PlayerInfo[playerid][pMagazin];
				if(strval(inputtext) > Magazin[id][mBank]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � �������� ��� ����� �����!");
				if(strval(inputtext) <= 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����������!");
				SetMoney(playerid,strval(inputtext));
				Magazin[id][mBank] -= strval(inputtext);
				new string[128];
				format(string,sizeof(string),"�� ������� �� �������� %s$. �������: %s$",ConvertCash(strval(inputtext)),ConvertCash(Magazin[id][mBank]));
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
		}
		case DIALOG_FSTYLE:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(PlayerInfo[playerid][pFstyle] == 5) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ��� �������� ������ ������ ���!");
						PlayerInfo[playerid][pFstyle] = 5;
					}
					case 1:
					{
						if(PlayerInfo[playerid][pFstyle] == 6) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ��� �������� ������ ������ ���!");
						PlayerInfo[playerid][pFstyle] = 6;
					}
					case 2:
					{
						if(PlayerInfo[playerid][pFstyle] == 7) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ��� �������� ������ ������ ���!");
						PlayerInfo[playerid][pFstyle] = 7;
					}
					case 3:
					{
						if(PlayerInfo[playerid][pFstyle] == 15) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ��� �������� ������ ������ ���!");
						PlayerInfo[playerid][pFstyle] = 15;
					}
				}
				SetPlayerFightingStyle(playerid, PlayerInfo[playerid][pFstyle]);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"�����������! �� �������� ����� ������ ���!");
			}
		}
		case DIALOG_CLUBBUY:
		{
			new string[300];
			if(response)
			{
				format(string,sizeof(string),"{3CBBF7}[1]{FFFFFF}\t���(%d$)\n{3CBBF7}[2]{FFFFFF}\t����(%d$)\n{3CBBF7}[3]{FFFFFF}\t�����(%d$)\n{3CBBF7}[4]{FFFFFF}\t�����(%d$)",PRICE_JUICE,PRICE_BEER,PRICE_WICKEY,PRICE_VODKA);
				SPD(playerid,DIALOG_CLUB_BAR,DIALOG_STYLE_LIST,""PREFIX" ��� | ���",string,"�������","�����");
			}
			else
			{
				format(string,sizeof(string),"{3CBBF7}[1]{FFFFFF}\t��������(%d$)\n{3CBBF7}[2]{FFFFFF}\t������(%d$)\n{3CBBF7}[3]{FFFFFF}\t�������(%d$)",PRICE_OTBIV,PRICE_CHICKEN,PRICE_SVIN);
				SPD(playerid,DIALOG_CLUB_REST,DIALOG_STYLE_LIST,""PREFIX" ��� | ��������",string,"�������","�����");
			}
		}
		case DIALOG_CLUB_BAR:
		{
			if(response)
			{
				new Float:health;
				new string[128];
				GetPlayerHealth(playerid,health);
				new i = GetPlayerVirtualWorld(playerid);
				switch(listitem)
				{
					case 0:
					{
						if(GetMoney(playerid) < PRICE_JUICE) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(health >= 165) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ���-�� ��������!");
						ServerSetPlayerHealth(playerid,health+5);
						SetMoney(playerid,-PRICE_JUICE);
						Club[i][cBank] += PRICE_JUICE;
						SetPlayerDrunkLevel(playerid,GetPlayerDrunkLevel(playerid)+500);
						SetTimerEx("UnDrink",30000,false,"i",playerid);
						if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"%s �����(�) ���",PlayerInfo[playerid][pName]);
						else format(string,sizeof(string),"����������� �����(�) ���");
						SendRadiusMessage(5.0, playerid, string,COLOR_PURPLE);
						SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
					}
					case 1:
					{
						if(GetMoney(playerid) < PRICE_BEER) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(health >= 160) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ���-�� ��������!");
						ServerSetPlayerHealth(playerid,health+10);
						SetMoney(playerid,-PRICE_BEER);
						Club[i][cBank] += PRICE_BEER;
						SetPlayerDrunkLevel(playerid,GetPlayerDrunkLevel(playerid)+1000);
						SetTimerEx("UnDrink",30000,false,"i",playerid);
						if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"%s �����(�) ����",PlayerInfo[playerid][pName]);
						else format(string,sizeof(string),"����������� �����(�) ����");
						SendRadiusMessage(5.0, playerid, string,COLOR_PURPLE);
						SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
					}
					case 2:
					{
						if(GetMoney(playerid) < PRICE_WICKEY) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(health >= 155) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ���-�� ��������!");
						ServerSetPlayerHealth(playerid,health+15);
						SetMoney(playerid,-PRICE_WICKEY);
						Club[i][cBank] += PRICE_WICKEY;
						SetPlayerDrunkLevel(playerid,GetPlayerDrunkLevel(playerid)+1500);
						SetTimerEx("UnDrink",30000,false,"i",playerid);
						if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"%s �����(�) �����",PlayerInfo[playerid][pName]);
						else format(string,sizeof(string),"����������� �����(�) �����");
						SendRadiusMessage(5.0, playerid, string,COLOR_PURPLE);
						SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
					}
					case 3:
					{
						if(GetMoney(playerid) < PRICE_VODKA) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(health >= 150) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ���-�� ��������!");
						ServerSetPlayerHealth(playerid,health+20);
						SetMoney(playerid,-PRICE_VODKA);
						Club[i][cBank] += PRICE_VODKA;
						SetPlayerDrunkLevel(playerid,GetPlayerDrunkLevel(playerid)+2000);
						SetTimerEx("UnDrink",30000,false,"i",playerid);
						if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"%s �����(�) �����",PlayerInfo[playerid][pName]);
						else format(string,sizeof(string),"����������� �����(�) �����");
						SendRadiusMessage(5.0, playerid, string,COLOR_PURPLE);
						SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
					}
				}
			}
		}
		case DIALOG_CLUB_REST:
		{
			if(response)
			{
				new Float:health;
				new string[128];
				GetPlayerHealth(playerid,health);
				new i = GetPlayerVirtualWorld(playerid);
				switch(listitem)
				{
					case 0:
					{
						if(GetMoney(playerid) < PRICE_OTBIV) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(health >= 165) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ���-�� ��������!");
						ServerSetPlayerHealth(playerid,health+5);
						SetMoney(playerid,-PRICE_OTBIV);
						Club[i][cBank] += PRICE_OTBIV;
						if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"%s �����(�) ��������",PlayerInfo[playerid][pName]);
						else format(string,sizeof(string),"����������� �����(�) ��������");
						SendRadiusMessage(5.0, playerid, string,COLOR_PURPLE);
					}
					case 1:
					{
						if(GetMoney(playerid) < PRICE_CHICKEN) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(health >= 160) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ���-�� ��������!");
						ServerSetPlayerHealth(playerid,health+10);
						SetMoney(playerid,-PRICE_CHICKEN);
						Club[i][cBank] += PRICE_CHICKEN;
						if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"%s �����(�) ������",PlayerInfo[playerid][pName]);
						else format(string,sizeof(string),"����������� �����(�) ������");
						SendRadiusMessage(5.0, playerid, string,COLOR_PURPLE);
					}
					case 2:
					{
						if(GetMoney(playerid) < PRICE_SVIN) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
						if(health >= 155) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ ���-�� ��������!");
						ServerSetPlayerHealth(playerid,health+15);
						SetMoney(playerid,-PRICE_SVIN);
						Club[i][cBank] += PRICE_SVIN;
						if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"%s �����(�) c������",PlayerInfo[playerid][pName]);
						else format(string,sizeof(string),"����������� �����(�) c������");
						SendRadiusMessage(5.0, playerid, string,COLOR_PURPLE);
					}
				}
			}
		}
		case DIALOG_INVENTORY:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(Weapon[playerid][wGun][0] > 0) { SPD(playerid,DIALOG_ACTION,DIALOG_STYLE_LIST,""PREFIX" ����� ��������","{3CBBF7}[1]{FFFFFF} ��������\n{3CBBF7}[2]{FFFFFF} ���������\n{3CBBF7}[3]{FFFFFF} �������","�����","������"); choose[playerid] = 1; }
					}
					case 1:
					{
						if(Weapon[playerid][wGun][1] > 0) { SPD(playerid,DIALOG_ACTION,DIALOG_STYLE_LIST,""PREFIX" ����� ��������","{3CBBF7}[1]{FFFFFF} ��������\n{3CBBF7}[2]{FFFFFF} ���������\n{3CBBF7}[3]{FFFFFF} �������","�����","������"); choose[playerid] = 2; }
					}
					case 2:
					{
						if(Weapon[playerid][wGun][2] > 0) { SPD(playerid,DIALOG_ACTION,DIALOG_STYLE_LIST,""PREFIX" ����� ��������","{3CBBF7}[1]{FFFFFF} ��������\n{3CBBF7}[2]{FFFFFF} ���������\n{3CBBF7}[3]{FFFFFF} �������","�����","������"); choose[playerid] = 3; }
					}
					case 3:
					{
						if(Weapon[playerid][wGun][3] > 0) { SPD(playerid,DIALOG_ACTION,DIALOG_STYLE_LIST,""PREFIX" ����� ��������","{3CBBF7}[1]{FFFFFF} ��������\n{3CBBF7}[2]{FFFFFF} ���������\n{3CBBF7}[3]{FFFFFF} �������","�����","������"); choose[playerid] = 4; }
					}
					case 4:
					{
						if(Weapon[playerid][wGun][4] > 0) { SPD(playerid,DIALOG_ACTION,DIALOG_STYLE_LIST,""PREFIX" ����� ��������","{3CBBF7}[1]{FFFFFF} ��������\n{3CBBF7}[2]{FFFFFF} ���������\n{3CBBF7}[3]{FFFFFF} �������","�����","������"); choose[playerid] = 5; }
					}
					case 5:
					{
						if(PlayerInfo[playerid][pMats] > 0) { SPD(playerid,DIALOG_ACTION,DIALOG_STYLE_LIST,""PREFIX" ����� ��������","{3CBBF7}[1]{FFFFFF} ��������\n{3CBBF7}[2]{FFFFFF} ���������\n{3CBBF7}[3]{FFFFFF} �������\n{3CBBF7}[4]{FFFFFF} ������� ������","�����","������"); choose[playerid] = 6; }
					}
					case 6:
					{
						if(PlayerInfo[playerid][pDrugs] > 0) { SPD(playerid,DIALOG_ACTION,DIALOG_STYLE_LIST,""PREFIX" ����� ��������","{3CBBF7}[1]{FFFFFF} ��������\n{3CBBF7}[2]{FFFFFF} ���������\n{3CBBF7}[3]{FFFFFF} �������\n{3CBBF7}[4]{FFFFFF} ������������","�����","������"); choose[playerid] = 7; }
					}
				}
			}
		}
		case DIALOG_ACTION:
		{
		    new string[128];
			if(response)
			{
				switch(listitem)
				{
					case 0: SPD(playerid,DIALOG_GET,DIALOG_STYLE_INPUT,""PREFIX" ��������","������� ID ������, �������� �� ������ ��������","�����","������");
					case 1:
					{
						switch(choose[playerid])
						{
							case 1: { ServerGivePlayerWeapon(playerid,Weapon[playerid][wGun][0],-Weapon[playerid][wSlot1]); Weapon[playerid][wGun][0] = 0; }
							case 2: { ServerGivePlayerWeapon(playerid,Weapon[playerid][wGun][1],-Weapon[playerid][wSlot2]); Weapon[playerid][wGun][1] = 0; }
							case 3: { ServerGivePlayerWeapon(playerid,Weapon[playerid][wGun][2],-Weapon[playerid][wSlot3]); Weapon[playerid][wGun][2] = 0; }
							case 4: { ServerGivePlayerWeapon(playerid,Weapon[playerid][wGun][3],-Weapon[playerid][wSlot4]); Weapon[playerid][wGun][3] = 0; }
							case 5: { ServerGivePlayerWeapon(playerid,Weapon[playerid][wGun][4],-Weapon[playerid][wSlot5]); Weapon[playerid][wGun][4] = 0; }
							case 6:
							{
								PlayerInfo[playerid][pMats] = 0;
								format(string,sizeof(string),"%s �������� ���������",PlayerInfo[playerid][pName]);
								SendRadiusMessage(10.0, playerid, string,COLOR_PURPLE);
							}
							case 7:
							{
								PlayerInfo[playerid][pDrugs] = 0;
								format(string,sizeof(string),"%s �������� ���������� �������",PlayerInfo[playerid][pName]);
								SendRadiusMessage(10.0, playerid, string,COLOR_PURPLE);
							}
						}
					}
					case 3:
					{
						switch(choose[playerid])
						{
							case 6:
							{
								if(PlayerInfo[playerid][pJob] != 1) return  SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
								SPD(playerid,DIALOG_MAKEGUN,DIALOG_STYLE_LIST,""PREFIX" C������ ������","{D37018}Desert Eagle:{FFFFFF}\t150 ����������\n{D37018}MP-5:{FFFFFF}\t300 ����������\n{D37018}ShotGun:{FFFFFF}\t400 ����������\n{D37018}M-4:{FFFFFF}\t500 ����������\n{D37018}AK-47:{FFFFFF}\t500 ����������","�������","������");
							}
							case 7:
							{
								if(GetPlayerDrunkLevel(playerid) >= 50000) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} �� �� ������ ������������ ������ ����������!");
								new Float:health;
								GetPlayerHealth(playerid,health);
								if(health >= 100) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} �� �� ������ ������������ ������ ����������!");
								GameTextForPlayer(playerid, "~w~�E��~n~~p~�O�EC�O", 4000, 1);
								SetPlayerDrunkLevel(playerid,GetPlayerDrunkLevel(playerid)+25000);
								SetTimerEx("UnDrink",30000,false,"i",playerid);
								ServerSetPlayerHealth(playerid, health + 45.0);
								PlayerInfo[playerid][pDrugs] -= 1;
							}
						}
					}
				}
			}
		}
		case DIALOG_GET:
		{
			if(response)
			{
			    new string[144],gun[32];
				idplayer[playerid] = strval(inputtext);
				if(idplayer[playerid]  < 0 || idplayer[playerid]  > MAX_PLAYERS) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� �� ����� ���� ������ 0!");
				if(!IsPlayerConnected(idplayer[playerid])) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� �� � ����!");
				switch(choose[playerid])
				{
					case 1:
					{
						ServerGivePlayerWeapon(idplayer[playerid],Weapon[playerid][wGun][0],Weapon[playerid][wSlot1]);
						ServerGivePlayerWeapon(playerid,Weapon[playerid][wGun][0],-Weapon[playerid][wSlot1]);
						GetWeaponName(Weapon[playerid][wGun][0],gun,32);
						format(string,sizeof(string),"%s[%d] ������� ��� %s",PlayerInfo[playerid][pName],playerid,gun);
						SendClientMessage(idplayer[playerid],COLOR_LIGHTBLUE,string);
						format(string,sizeof(string),"�� �������� %s[%d] %s",PlayerInfo[idplayer[playerid]][pName],idplayer[playerid],gun);
						SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					}
					case 2:
					{
						ServerGivePlayerWeapon(idplayer[playerid],Weapon[playerid][wGun][1],Weapon[playerid][wSlot2]);
						ServerGivePlayerWeapon(playerid,Weapon[playerid][wGun][1],-Weapon[playerid][wSlot2]);
						GetWeaponName(Weapon[playerid][wGun][1],gun,32);
						format(string,sizeof(string),"%s[%d] ������� ��� %s",PlayerInfo[playerid][pName],playerid,gun);
						SendClientMessage(idplayer[playerid],COLOR_LIGHTBLUE,string);
						format(string,sizeof(string),"�� �������� %s[%d] %s",PlayerInfo[idplayer[playerid]][pName],idplayer[playerid],gun);
						SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					}
					case 3:
					{
						ServerGivePlayerWeapon(idplayer[playerid],Weapon[playerid][wGun][2],Weapon[playerid][wSlot3]);
						ServerGivePlayerWeapon(playerid,Weapon[playerid][wGun][2],-Weapon[playerid][wSlot3]);
						GetWeaponName(Weapon[playerid][wGun][2],gun,32);
						format(string,sizeof(string),"%s[%d] ������� ��� %s",PlayerInfo[playerid][pName],playerid,gun);
						SendClientMessage(idplayer[playerid],COLOR_LIGHTBLUE,string);
						format(string,sizeof(string),"�� �������� %s[%d] %s",PlayerInfo[idplayer[playerid]][pName],idplayer[playerid],gun);
						SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					}
					case 4:
					{
						ServerGivePlayerWeapon(idplayer[playerid],Weapon[playerid][wGun][3],Weapon[playerid][wSlot4]);
						ServerGivePlayerWeapon(playerid,Weapon[playerid][wGun][3],-Weapon[playerid][wSlot4]);
						GetWeaponName(Weapon[playerid][wGun][3],gun,32);
						format(string,sizeof(string),"%s[%d] ������� ��� %s",PlayerInfo[playerid][pName],playerid,gun);
						SendClientMessage(idplayer[playerid],COLOR_LIGHTBLUE,string);
						format(string,sizeof(string),"�� �������� %s[%d] %s",PlayerInfo[idplayer[playerid]][pName],idplayer[playerid],gun);
						SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					}
					case 5:
					{
						ServerGivePlayerWeapon(idplayer[playerid],Weapon[playerid][wGun][4],Weapon[playerid][wSlot5]);
						ServerGivePlayerWeapon(playerid,Weapon[playerid][wGun][4],-Weapon[playerid][wSlot5]);
						GetWeaponName(Weapon[playerid][wGun][4],gun,32);
						format(string,sizeof(string),"%s[%d] ������� ��� %s",PlayerInfo[playerid][pName],playerid,gun);
						SendClientMessage(idplayer[playerid],COLOR_LIGHTBLUE,string);
						format(string,sizeof(string),"�� �������� %s[%d] %s",PlayerInfo[idplayer[playerid]][pName],idplayer[playerid],gun);
						SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					}
					case 6..7: SPD(playerid,DIALOG_INV_KOLVO,DIALOG_STYLE_INPUT,""PREFIX" ��������","{FFFFFF}������� ����������, ������� �� ������ ��������","�����","������");
				}
			}
		}
		case DIALOG_INV_KOLVO:
		{
		    new string[128];
			if(response)
			{
				switch(choose[playerid])
				{
					case 6:
					{
						if(strval(inputtext) <= 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������ ���������� ������ 1!");
						if(strval(inputtext) > PlayerInfo[playerid][pMats]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������ ���-�� ����������!");
						PlayerInfo[idplayer[playerid]][pMats] += strval(inputtext);
						PlayerInfo[playerid][pMats] -= strval(inputtext);
						format(string,sizeof(string),"%s[%d] ������� ��� %d ����������",PlayerInfo[playerid][pName],playerid,strval(inputtext));
						SendClientMessage(idplayer[playerid],COLOR_LIGHTBLUE,string);
						format(string,sizeof(string),"�� �������� %s[%d] %d ����������",PlayerInfo[idplayer[playerid]][pName],idplayer[playerid],strval(inputtext));
						SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					}
					case 7:
					{
						if(strval(inputtext) <= 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������ ���������� ������ 1!");
						if(strval(inputtext) > PlayerInfo[playerid][pDrugs]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������ ���-�� ����������!");
						PlayerInfo[idplayer[playerid]][pDrugs] += strval(inputtext);
						PlayerInfo[playerid][pDrugs] -= strval(inputtext);
						format(string,sizeof(string),"%s[%d] ������� ��� %d ����������",PlayerInfo[playerid][pName],playerid,strval(inputtext));
						SendClientMessage(idplayer[playerid],COLOR_LIGHTBLUE,string);
						format(string,sizeof(string),"�� �������� %s[%d] %d ����������",PlayerInfo[idplayer[playerid]][pName],idplayer[playerid],strval(inputtext));
						SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
					}
				}
			}
		}
		case DIALOG_TARGET:
		{
		    new string[128];
			if(GetPlayerDistanceToPlayer(playerid,targetp[playerid]) > 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ �� ���!");
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						new title[100];
						format(title,sizeof(title),""PREFIX" �������� ����� %s",PlayerInfo[targetp[playerid]][pName]);
						format(string,sizeof(string),"{FFFFFF}������� ���-�� �����, ������� �� ������ ��������\n� ���: {D37018}%s${FFFFFF} ",ConvertCash(PlayerInfo[playerid][pMoney]));
						SPD(playerid,DIALOG_PAY,DIALOG_STYLE_INPUT,title,string,"�����","������");
					}
					case 1:
					{
						if(!IsACop(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �-���!");
						format(string,sizeof(string),"{D37018}�������:{FFFFFF} %s\t| {D37018}������� �������:{FFFFFF} %d\t| {D37018}���������:{FFFFFF} %d |\t| {D37018}���������:{FFFFFF} %d |",PlayerInfo[targetp[playerid]][pName],GetPlayerWantedLevel(targetp[playerid]),PlayerInfo[targetp[playerid]][pMats],PlayerInfo[targetp[playerid]][pDrugs]);
						SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" �����",string,"�K","");
						format(string,sizeof(string),"%s �������(�) %s",PlayerInfo[playerid][pName],PlayerInfo[targetp[playerid]][pName]);
						SendRadiusMessage(5.0, playerid, string,COLOR_PURPLE);
					}
					case 2:
					{
						new fam = GetPlayerMember(playerid);
						if(!IsACop(playerid) && fam != 4 && fam != 5 && fam != 15) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �-���!");
						format(string,sizeof(string),"{D37018}�����������:{FFFFFF}\t%s\n{D37018}����:{FFFFFF}\t%d\n{D37018}��������:{FFFFFF}\t%d",Fraction[fam][fName],PlayerInfo[playerid][pRank],PlayerInfo[playerid][pFW]);
						SPD(targetp[playerid],999,DIALOG_STYLE_MSGBOX,""PREFIX" �������������",string,"�����","������");
						format(string,sizeof(string),"%s �������(�) ������������� %s",PlayerInfo[playerid][pName],PlayerInfo[targetp[playerid]][pName]);
						SendRadiusMessage(5.0, playerid, string,COLOR_PURPLE);
					}
				}
			}
		}
		case DIALOG_PAY:
		{
			if(response)
			{
				if(strval(inputtext) > PlayerInfo[playerid][pMoney]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ������ ���-�� �����!");
				if(PlayerInfo[targetp[playerid]][pLevel] < 1) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� ������ ���� ���� �� ������� ������!");
				SetMoney(playerid,-strval(inputtext));
				SetMoney(targetp[playerid],strval(inputtext));
				new string[128];
				format(string,sizeof(string),"%s[%d] ������� ��� %s$",PlayerInfo[playerid][pName],playerid,ConvertCash(strval(inputtext)));
				SendClientMessage(targetp[playerid],COLOR_LIGHTBLUE,string);
				format(string,sizeof(string),"�� �������� %s[%d] %s$",PlayerInfo[targetp[playerid]][pName],targetp[playerid],ConvertCash(strval(inputtext)));
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			}
		}
		case DIALOG_AUTO_ZAKAZ:
		{
		    new car[MAX_PLAYERS];
			if(response)
			{
				switch(listitem)
				{
				    case 0: car[playerid] = 445;
				    case 1: car[playerid] = 518;
				 	case 2: car[playerid] = 421;
				 	case 3: car[playerid] = 541;
				 	case 4: car[playerid] = 545;
				 	case 5: car[playerid] = 451;
				 	case 6: car[playerid] = 507;
				 	case 7: car[playerid] = 562;
				 	case 8: car[playerid] = 551;
				 	case 9: car[playerid] = 547;
				}
		 	 	if(vehcar[playerid] > 0) DestroyVehicle(vehcar[playerid]);
				vehcar[playerid] = CreateVehicle(car[playerid], -2494.5874,-600.9958,132.2896,182.1219, -1, -1, 1800000);
				SetTimerEx("DeleteCar",900000,false,"i",vehcar[playerid]);
				SetVehicleParamsEx(vehcar[playerid],false,false,false,false,false,false,false);
				VehHealth[vehcar[playerid]] = 1000.0;
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"���������� ������ ��� ��� �� �����!");
			}
		}
		case DIALOG_COPGUN:
		{
		    if(response)
			{
			    switch(listitem)
			    {
			        case 0: ServerGivePlayerWeapon(playerid,24,100);
			        case 1: ServerGivePlayerWeapon(playerid,27,100);
			     	case 2: ServerGivePlayerWeapon(playerid,31,100);
			     	case 3: ServerGivePlayerWeapon(playerid,29,100);
			     	case 4: ServerGivePlayerWeapon(playerid,3,1);
			     }
			}
		}
		case DIALOG_QUEST:
		{
			if(!response) return true;
			SPD(playerid, DIALOG_QUEST+1, DIALOG_STYLE_LIST, ""PREFIX" ������ �������", "�������� �������� �� ��������\n��������� �� ������\n���������� ����� �������\n", "�����", "������");
		}
		case DIALOG_QUEST+1:
		{
		    if(!response) return true;
		    switch(listitem) {
		        case 0:
		        {
		            if(PlayerInfo[playerid][pQuest][0] == true) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ��� ��������� ���� �����!");
					SPD(playerid, 999, DIALOG_STYLE_MSGBOX, ""PREFIX" ���������� � ������", ""YE"��������:\t�������� �������� �� ��������\n��������������:\t"GRN"10.000$", "��", "");
					return true;
				}
				case 1:
		        {
		            if(PlayerInfo[playerid][pQuest][1] == true) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ��� ��������� ���� �����!");
					SPD(playerid, 999, DIALOG_STYLE_MSGBOX, ""PREFIX" ���������� � ������", ""YE"��������:\t��������� �� ������\n��������������:\t"GRN"5.000$", "��", "");
					return true;
				}
				case 2:
		        {
		            if(PlayerInfo[playerid][pQuest][2] == true) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ��� ��������� ���� �����!");
					SPD(playerid, 999, DIALOG_STYLE_MSGBOX, ""PREFIX" ���������� � ������", ""YE"��������:\t���������� ����� �������\n��������������:\t"GRN"15.000$", "��", "");
					return true;
				}
			}
		}
		case DIALOG_TIMEUSE: {
			SetPVarInt(playerid, "TimeUse", 0);
			return true;
		}
	}
	return true;
}
forward Zapravka(playerid);
public Zapravka(playerid)
{
	TogglePlayerControllable(playerid,1);
	new engine,lights,alarm,doors,bonnet,boot,objective;
	new vehicle = GetPlayerVehicleID(playerid),Float:x,Float:y,Float:z,string[512];
	GetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, boot, objective);
	GetVehiclePos(vehicle,x,y,z);
	new summa25 = fuel[vehicle] + GetPVarInt(playerid,"fuela");
	if(summa25 > 100) { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ���� �� ����� ���� ������ 100� �������!"); return true; }
	fuel[vehicle] += GetPVarInt(playerid,"fuela");
	format(string,sizeof(string),"{FFFFFF}�� ������ � ��� {17D6E0}%d{FFFFFF} ������ ������� � ��������� {17D6E0}%d${FFFFFF}",GetPVarInt(playerid,"fuela"),GetPVarInt(playerid,"pricefuel"));
	SendClientMessage(playerid,-1,string);
	SetPVarInt(playerid,"fuela",0);
	SetPVarInt(playerid,"pricefuel",0);
	if(fuelic[vehicle] != fueltype[vehicle]) { ToggleEngine(vehicle,VEHICLE_PARAMS_OFF); return true; }
	return true;
}
stock ConnectMySQL()
{
	mysql_connect(SQL_HOST, SQL_USER, SQL_DB, SQL_PASS);
    switch(mysql_ping())
	{
        case 1: print("����������� � �� �������");
        case -1: print("����������� � �� �� �������");
    }
	mysql_set_charset("cp1251");
	mysql_query("SET NAMES 'cp1251'");
	CheckMySQLConnection();
    return true;
}

stock ConnectDonateMySQL()
{
	dh = mysql_connect(SQL_DHOST, SQL_DUSER, SQL_DDB, SQL_DPASS);
    switch(mysql_ping())
	{
        case 1: print("����������� � �� ������ �������");
        case -1: print("����������� � �� ������ �� �������");
    }
    return true;
}

stock DisconnectMySQL()
{
    mysql_close();
    print("����������� � �� �������");
}

CheckMySQLConnection()
{
    if(mysql_ping() == -1) mysql_reconnect();
    return true;
}
stock CreateAccount(playerid, password[])
{
	if(strfind(password, "|") != -1)  return ALKick(playerid);
    new query[255],sqlname[MAX_PLAYER_NAME],sqlpassword[32];
    mysql_real_escape_string(PlayerInfo[playerid][pName], sqlname);
    mysql_real_escape_string(password, sqlpassword);
    format(query, sizeof(query), "INSERT INTO `Accounts` (`Nickname`, `Password`, `Skin`, `Money`, `Bank`) VALUE ('%s', '%s',3,5000,10000)", sqlname, sqlpassword);
    mysql_query(query);
    strmid(PlayerInfo[playerid][pPassword], password, 0, 64, 255);
    PlayerInfo[playerid][pLogged] = true;
	PlayerInfo[playerid][pID] = mysql_insert_id();
	SetMoney(playerid,5000);
	TogglePlayerControllable(playerid, 0);
	ServerSetPlayerPos(playerid,-1972.3838,137.6144,27.6875);
	SetPlayerFacingAngle(playerid, 87.8889);
	SetCameraBehindPlayer(playerid);
	EmptyMessages(playerid, 50);
	SendClientMessage(playerid, -1, "{FFCC99}�� ������� ������������������! ����� ����������, ��� ���������� ������� ���������.");
	EmptyMessages(playerid, 5);
	SPD(playerid, DIALOG_MALE , DIALOG_STYLE_MSGBOX, ""PREFIX" ����� ����", "{FFCC99}�������� ��� ������ ���������.", "�������", "�������");
    return true;
}
stock LoadAccount(playerid, password[])
{
	if(strfind(password, "|") != -1) return ALKick(playerid);
	new query[128],sqlpass[32],result[1024],dialog[128],connect[128],ip[16];
	mysql_real_escape_string(password, sqlpass);
	format(query, sizeof(query), "SELECT * FROM `Accounts` WHERE `Password` = '%s' AND `ID` = '%i'", sqlpass, PlayerInfo[playerid][pID]);
	mysql_query(query);
	mysql_store_result();
	if(mysql_num_rows() == 1)
	{
		mysql_fetch_row_format(result, "|");
		sscanf(result, "p<|>is[64]s[32]iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiifffiifffiiiiiiiiiiiiiiiiiiiiiiis[64]iiiiiiiiiiiiis[32]s[32]iiiiiiiiis[32]s[32]s[32]s[32]iiii", PlayerInfo[playerid][pID],PlayerInfo[playerid][pName],PlayerInfo[playerid][pPassword],PlayerInfo[playerid][pHouse],
		PlayerInfo[playerid][pLevel],PlayerInfo[playerid][pAdmin],PlayerInfo[playerid][pMuteTime],PlayerInfo[playerid][pJailTime],PlayerInfo[playerid][pWarn],PlayerInfo[playerid][pLeader],PlayerInfo[playerid][pMember],PlayerInfo[playerid][pRank],PlayerInfo[playerid][pJailed],PlayerInfo[playerid][pRent],PlayerInfo[playerid][pMoney],PlayerInfo[playerid][pBank],PlayerInfo[playerid][pExp],PlayerInfo[playerid][pGameTime],
		PlayerInfo[playerid][pFW],PlayerInfo[playerid][pFMuteTime],PlayerInfo[playerid][pSkin],PlayerInfo[playerid][pFuel],PlayerInfo[playerid][pJob],PlayerInfo[playerid][pSpawn],PlayerInfo[playerid][pGunSkill],PlayerInfo[playerid][pMats],PlayerInfo[playerid][pSklad],PlayerInfo[playerid][pZP],PlayerInfo[playerid][pWanted],PlayerInfo[playerid][pLic][1],PlayerInfo[playerid][pBlocked],PlayerInfo[playerid][pDrugs],PlayerInfo[playerid][pDrugSkill],
		PlayerInfo[playerid][pCrashed],PlayerInfo[playerid][pX],PlayerInfo[playerid][pY],PlayerInfo[playerid][pZ],PlayerInfo[playerid][pZavod],PlayerInfo[playerid][pCarM],PlayerInfo[playerid][pCarX],PlayerInfo[playerid][pCarY],PlayerInfo[playerid][pCarZ],PlayerInfo[playerid][pCC1],PlayerInfo[playerid][pCC2],PlayerInfo[playerid][pSpoiler],PlayerInfo[playerid][pHood],PlayerInfo[playerid][pSideskirt],PlayerInfo[playerid][pNitro],
		PlayerInfo[playerid][pLamps],PlayerInfo[playerid][pExhaust],PlayerInfo[playerid][pWheels],PlayerInfo[playerid][pRoof],PlayerInfo[playerid][pStereo],PlayerInfo[playerid][pHydraulics],PlayerInfo[playerid][pBullbar],PlayerInfo[playerid][pRearBullbars],PlayerInfo[playerid][pFrontSign],PlayerInfo[playerid][pFrontBullbars],PlayerInfo[playerid][pFrontBumper],PlayerInfo[playerid][pRearBumper],PlayerInfo[playerid][pVents],PlayerInfo[playerid][pPaintJob],PlayerInfo[playerid][pZam],PlayerInfo[playerid][pReg],
		PlayerInfo[playerid][pMale],PlayerInfo[playerid][pPriglasil],PlayerInfo[playerid][pInvite],PlayerInfo[playerid][pContract],PlayerInfo[playerid][pHelper],PlayerInfo[playerid][pLic][2],PlayerInfo[playerid][pLic][3],PlayerInfo[playerid][pLic][4],PlayerInfo[playerid][pAmmo],PlayerInfo[playerid][pOtm],PlayerInfo[playerid][pMagazin],PlayerInfo[playerid][pFstyle],PlayerInfo[playerid][pClub],PlayerInfo[playerid][pGPS],PlayerInfo[playerid][pOTR],
		PlayerInfo[playerid][pReason],PlayerInfo[playerid][pReason1],PlayerInfo[playerid][pQuest][0],PlayerInfo[playerid][pQuest][1],PlayerInfo[playerid][pQuest][2],PlayerInfo[playerid][pQuest][3],PlayerInfo[playerid][pQuest][4],PlayerInfo[playerid][pOnline],PlayerInfo[playerid][pKMats],PlayerInfo[playerid][pKDrugs],PlayerInfo[playerid][pTakeMoney],
		PlayerInfo[playerid][pMuteReason],PlayerInfo[playerid][pMuteDal],PlayerInfo[playerid][pUnmuteReason],PlayerInfo[playerid][pUnmuteDal], PlayerInfo[playerid][pSmoke], PlayerInfo[playerid][pTie], PlayerInfo[playerid][pVaip], PlayerInfo[playerid][pDM]);
        PlayerInfo[playerid][pLogged] = true;
		PlayerInfo[playerid][pOnline] = true;
        mysql_free_result();
		GetPlayerIp(playerid,ip,sizeof(ip));
		format(connect,sizeof(connect),"����� "PURP"%s[%d] (IP: %s) {FFFFFF} ����� � �������.",PlayerInfo[playerid][pName],playerid,ip);
		SendAdminMessage(-1,connect,1);
		format(connect,sizeof(connect),"%s[%d] logged. (IP: %s)",PlayerInfo[playerid][pName],playerid,ip);
		WriteLog("EnterLog",connect);
		if(PlayerInfo[playerid][pAdmin] > 0) {
			format(connect, sizeof(connect), "{3812E1}[INFO]{FFFFFF} "WHT"�� ����� ��� ������������� "YE"%d"WHT" ������", PlayerInfo[playerid][pAdmin]);
			SendClientMessage(playerid, 0, connect);
		}
		if(PlayerInfo[playerid][pTakeMoney] > 0) PlayerInfo[playerid][pTakeMoney] = 0;
		SetPVarString(playerid, "iplog", ip);
		GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
		CreateTextDraw(playerid);
		PlayerTextDrawShow(playerid,Time[playerid]);
		PlayerTextDrawShow(playerid,Site[playerid]);
	}
	else
	{
		PlayerInfo[playerid][pWrongPassword] ++;
		if(PlayerInfo[playerid][pWrongPassword] == 3)
		{
            SendClientMessage(playerid, COLOR_LIGHTRED, "{F31212}[������]{FFFFFF} �� 3 ���� ����� �������� ������ � ���� ��������� �� �������.");
            ALKick(playerid);
            return true;
		}
		format(dialog, sizeof(dialog),
            "{FFFFFF}�� ����� �������� ������.\n\
            � ��� �������� %i/3 ������� �����.",PlayerInfo[playerid][pWrongPassword]);
		SPD(playerid, DIALOG_WRONGPAS, DIALOG_STYLE_MSGBOX, "������.", dialog, "������", "������");
	}
	return false;
}
stock GetAccountID(playerid)
{
    new query[128];
    format(query, sizeof(query),"SELECT `ID` FROM `Accounts` WHERE `Nickname` = '%s'", PlayerInfo[playerid][pName]);
    mysql_query(query);
    mysql_store_result();
    if(mysql_num_rows() == 1) { PlayerInfo[playerid][pID] = mysql_fetch_int(); mysql_free_result(); return PlayerInfo[playerid][pID]; }
    return false;
}

stock SaveAccount(playerid)
{
	if(PlayerInfo[playerid][pLogged] == true) {
		new src[150], query[1024];
		format(query,sizeof(query),"UPDATE `Accounts` SET ");
		format(src,sizeof(src),"Nickname='%s',",PlayerInfo[playerid][pName]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Password='%s',",PlayerInfo[playerid][pPassword]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"House=%d,", PlayerInfo[playerid][pHouse]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Level=%d,", PlayerInfo[playerid][pLevel]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Admin=%d,", PlayerInfo[playerid][pAdmin]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"MuteTime=%d,", PlayerInfo[playerid][pMuteTime]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"JailTime=%d,", PlayerInfo[playerid][pJailTime]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Warn=%d,", PlayerInfo[playerid][pWarn]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Leader=%d,", PlayerInfo[playerid][pLeader]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Member=%d,", PlayerInfo[playerid][pMember]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Rank=%d,", PlayerInfo[playerid][pRank]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Jailed=%d,",PlayerInfo[playerid][pJailed]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Rent=%d,",PlayerInfo[playerid][pRent]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Money=%d, ",PlayerInfo[playerid][pMoney]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Bank=%d, ",PlayerInfo[playerid][pBank]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Exp=%d, ",PlayerInfo[playerid][pExp]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"GameTime=%d,",PlayerInfo[playerid][pGameTime]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"FW=%d, ",PlayerInfo[playerid][pFW]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"FMuteTime=%d, ",PlayerInfo[playerid][pFMuteTime]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Skin=%d,",PlayerInfo[playerid][pSkin]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Fuel=%d,",PlayerInfo[playerid][pFuel]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Job=%d,",PlayerInfo[playerid][pJob]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Spawn=%d,",PlayerInfo[playerid][pSpawn]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"GunSkill=%d,",PlayerInfo[playerid][pGunSkill]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Mats=%d,",PlayerInfo[playerid][pMats]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Sklad=%d,",PlayerInfo[playerid][pSklad]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"ZP=%d,",PlayerInfo[playerid][pZP]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Wanted=%d,",PlayerInfo[playerid][pWanted]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"LicVehicle=%d,",PlayerInfo[playerid][pLic][1]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Blocked=%d,",PlayerInfo[playerid][pBlocked]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Drugs=%d,",PlayerInfo[playerid][pDrugs]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"DrugSkill=%d,",PlayerInfo[playerid][pDrugSkill]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Crashed=%d,",PlayerInfo[playerid][pCrashed]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"X=%f,",PlayerInfo[playerid][pX]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Y=%f,",PlayerInfo[playerid][pY]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Z=%f,",PlayerInfo[playerid][pZ]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Zavod=%d,",PlayerInfo[playerid][pZavod]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"CarM=%d,",PlayerInfo[playerid][pCarM]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"CarX=%f,",PlayerInfo[playerid][pCarX]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"CarY=%f,",PlayerInfo[playerid][pCarY]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"CarZ=%f,",PlayerInfo[playerid][pCarZ]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"CC1=%d,",PlayerInfo[playerid][pCC1]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"CC2=%d,",PlayerInfo[playerid][pCC2]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Spoiler=%d,",PlayerInfo[playerid][pSpoiler]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Hood=%d,",PlayerInfo[playerid][pHood]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Sideskirt=%d,",PlayerInfo[playerid][pSideskirt]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Nitro=%d,",PlayerInfo[playerid][pNitro]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Lamps=%d,",PlayerInfo[playerid][pLamps]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Exhaust=%d,",PlayerInfo[playerid][pExhaust]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Wheels=%d,",PlayerInfo[playerid][pWheels]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Roof=%d,",PlayerInfo[playerid][pRoof]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Stereo=%d,",PlayerInfo[playerid][pStereo]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Hydraulics=%d,",PlayerInfo[playerid][pHydraulics]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Bullbar=%d,",PlayerInfo[playerid][pBullbar]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"RearBullbars=%d,",PlayerInfo[playerid][pRearBullbars]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"FrontSign=%d,",PlayerInfo[playerid][pFrontSign]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"FrontBullbars=%d,",PlayerInfo[playerid][pFrontBullbars]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"FrontBumper=%d,",PlayerInfo[playerid][pFrontBumper]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"RearBumper=%d,",PlayerInfo[playerid][pRearBumper]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Vents=%d,",PlayerInfo[playerid][pVents]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"PaintJob=%d,",PlayerInfo[playerid][pPaintJob]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Zam=%d,",PlayerInfo[playerid][pZam]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Reg=%d,",PlayerInfo[playerid][pReg]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Male=%d,",PlayerInfo[playerid][pMale]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Priglasil='%s',",PlayerInfo[playerid][pPriglasil]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Invite=%d,",PlayerInfo[playerid][pInvite]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Contract=%d,",PlayerInfo[playerid][pContract]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Helper=%d,",PlayerInfo[playerid][pHelper]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Boat=%d,",PlayerInfo[playerid][pLic][2]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Fly=%d,",PlayerInfo[playerid][pLic][3]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Gun=%d,",PlayerInfo[playerid][pLic][4]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Ammo=%d,",PlayerInfo[playerid][pAmmo]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Otm=%d,",PlayerInfo[playerid][pOtm]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Magazin=%d,",PlayerInfo[playerid][pMagazin]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Fstyle=%d,",PlayerInfo[playerid][pFstyle]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Club=%d,",PlayerInfo[playerid][pClub]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"GPS=%d,",PlayerInfo[playerid][pGPS]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"OTR=%d,",PlayerInfo[playerid][pOTR]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Reason='%s',",PlayerInfo[playerid][pReason]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Reason1='%s',",PlayerInfo[playerid][pReason1]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Quest=%d,",PlayerInfo[playerid][pQuest][0]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Quest1=%d,",PlayerInfo[playerid][pQuest][1]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Quest2=%d,",PlayerInfo[playerid][pQuest][2]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Quest3=%d,",PlayerInfo[playerid][pQuest][3]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Quest4=%d,",PlayerInfo[playerid][pQuest][4]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Online=%d,",PlayerInfo[playerid][pOnline]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Kmats=%d,",PlayerInfo[playerid][pKMats]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Kdrugs=%d,",PlayerInfo[playerid][pKDrugs]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"TakeMoney=%d,",PlayerInfo[playerid][pTakeMoney]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"MuteReason='%s',",PlayerInfo[playerid][pMuteReason]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"MuteDal='%s',",PlayerInfo[playerid][pMuteDal]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"UnmuteReason='%s',",PlayerInfo[playerid][pUnmuteReason]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"UnmuteDal='%s',",PlayerInfo[playerid][pUnmuteDal]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Smoke='%d',",PlayerInfo[playerid][pSmoke]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Tie='%d',",PlayerInfo[playerid][pTie]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Vaip='%d',",PlayerInfo[playerid][pVaip]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src),"Donate='%d'",PlayerInfo[playerid][pDM]);
		strcat(query,src,sizeof(query));
		format(src,sizeof(src)," WHERE ID='%i'",PlayerInfo[playerid][pID]);
		strcat(query,src,sizeof(query));
		mysql_query(query);
	}	
    return true;
}

stock RemovePlayerVariables(playerid)
{
    PlayerInfo[playerid][pWrongPassword] = false;
    PlayerInfo[playerid][pID] = false;
    PlayerInfo[playerid][pHouse] = 0;
    PlayerInfo[playerid][pLevel] = 0;
	PlayerInfo[playerid][pExp] = 0;
    PlayerInfo[playerid][pLogged] = false;
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pMuteTime] = 0;
	PlayerInfo[playerid][pJailTime] = 0;
	PlayerInfo[playerid][pWarn] = 0;
	PlayerInfo[playerid][pLeader] = 0;
	PlayerInfo[playerid][pMember] = 0;
	PlayerInfo[playerid][pRank] = 0;
	PlayerInfo[playerid][pJailed] = 0;
	PlayerInfo[playerid][pRent] = 0;
	PlayerInfo[playerid][pMoney] = 0;
	PlayerInfo[playerid][pBank] = 0;
	PlayerInfo[playerid][pExp] = 0;
	PlayerInfo[playerid][pGameTime] = false;
	PlayerInfo[playerid][pLicError] = false;
	PlayerInfo[playerid][pFW] = 0;
	PlayerInfo[playerid][pFMuteTime] = 0;
	PlayerInfo[playerid][pSkin] = 0;
	PlayerInfo[playerid][pFuel] = 0;
	PlayerInfo[playerid][pJob] = 0;
	PlayerInfo[playerid][pSpawn] = -1;
	PlayerInfo[playerid][pGunSkill] = 0;
	PlayerInfo[playerid][pMats] = 0;
	PlayerInfo[playerid][pSklad] = 0;
	PlayerInfo[playerid][pZP] = 0;
	PlayerInfo[playerid][pWanted] = 0;
	PlayerInfo[playerid][pLic][1] = false;
	PlayerInfo[playerid][pBlocked] = false;
	PlayerInfo[playerid][pDrugs] = 0;
	PlayerInfo[playerid][pDrugSkill] = 0;
	PlayerInfo[playerid][pCrashed] = false;
	PlayerInfo[playerid][pX] = 0.0;
	PlayerInfo[playerid][pY] = 0.0;
	PlayerInfo[playerid][pZ] = 0.0;
	PlayerInfo[playerid][pZavod] = 0;
	PlayerInfo[playerid][pCar] = 0;
	PlayerInfo[playerid][pCarM] = 0;
	PlayerInfo[playerid][pCarX] = 0.0;
	PlayerInfo[playerid][pCarY] = 0.0;
	PlayerInfo[playerid][pCarZ] = 0.0;
	PlayerInfo[playerid][pCC1] = 0;
	PlayerInfo[playerid][pCC2] = 0;
	PlayerInfo[playerid][pZam] = 0;
	RemoveTune(playerid);
	PlayerInfo[playerid][pReg] = false;
	PlayerInfo[playerid][pMale] = false;
	PlayerAFK[playerid][AFK_Time] = false;
    PlayerAFK[playerid][AFK_Stat] = false;
	PlayerInfo[playerid][pInvite] = false;
	PlayerInfo[playerid][pPriglasil] = 0;
	PlayerInfo[playerid][pExpNext] = 0;
	PlayerInfo[playerid][pMask] = false;
	PlayerInfo[playerid][pContract] = 0;
	PlayerInfo[playerid][pHelper] = 0;
	PlayerInfo[playerid][pLic][2] = false;
	PlayerInfo[playerid][pLic][3] = false;
	PlayerInfo[playerid][pLic][4] = false;
	PlayerInfo[playerid][pAmmo] = 0;
	PlayerInfo[playerid][pMagazin] = 0;
	PlayerInfo[playerid][pFstyle] = 0;
	PlayerInfo[playerid][pClub] = 0;
	PlayerInfo[playerid][pWrongPassword] = 0;
	PlayerInfo[playerid][pGPS] = false;
	PlayerInfo[playerid][pOTR] = false;
	PlayerInfo[playerid][pNat] = 0;
	PlayerInfo[playerid][pReason] = 0;
	PlayerInfo[playerid][pReason1] = 0;
	PlayerInfo[playerid][pQuest][0] = false;
	PlayerInfo[playerid][pQuest][1] = false;
	PlayerInfo[playerid][pQuest][2] = false;
	PlayerInfo[playerid][pQuest][3] = false;
	PlayerInfo[playerid][pQuest][4] = false;
	PlayerInfo[playerid][pOnline] = false;
	PlayerInfo[playerid][pKMats] = 0;
	PlayerInfo[playerid][pKDrugs] = 0;
	PlayerInfo[playerid][pTakeMoney] = 0;
	InviteLive[playerid] = -1;
	PlayerInfo[playerid][pMuteReason] = 0;
	PlayerInfo[playerid][pMuteDal] = 0;
	PlayerInfo[playerid][pUnmuteReason] = 0;
	PlayerInfo[playerid][pUnmuteDal] = 0;
	PlayerInfo[playerid][pSmoke] = 0;
	PlayerInfo[playerid][pTie] = false;
	PlayerInfo[playerid][pVaip] = false;
	PlayerInfo[playerid][pDM] = 0;
	spec[playerid] = false;
	PlayerHealth[playerid] = 100.00;
	TimeOfDeath[playerid] = false;
	ammobox[playerid] = 0;
	targetp[playerid] = -1;
	InviteLive[playerid] = -1;
	passanger[playerid] = -1;
	Contract[playerid] = -1;
	pakety[playerid] = 0;
	JailOffer[playerid] = -1;
	DrugsOffer[playerid] = -1;
	MatsOffer[playerid] = -1;
	comu[playerid] = -1;
	meshokp[playerid] = 0;
	idplayer[playerid] = -1;
	pricep[playerid] = INVALID_VEHICLE_ID;
	apm[playerid] = false;
	GunCheckTime[playerid] = 0;
	SetPVarInt(playerid, "TextDrawInfo", 0);
	incar[playerid] = false;
	vehcar[playerid] = 0;
	delaet[playerid] = false;
	findplayer[playerid] = -1;
	find[playerid] = false;
	cuff[playerid] 	= false;
	cpdeliv[playerid] = 0;
	SetPVarInt(playerid,"ALANTICRASH1",-1);
	SetPVarInt(playerid,"CheckSpawn",0);
	SetPVarInt(playerid, "Connected", 1);
	SetPVarInt(playerid,"vyborint",-1);
	SetPVarInt(playerid,"repairprice",-1);
	SetPVarInt(playerid,"repairid",-1);
	SetPVarInt(playerid,"slivid",-1);
	SetPVarInt(playerid,"callerid",-1);
	SetPVarInt(playerid,"accepterid",-1);
	SetPVarInt(playerid,"idfraction",-1);
    lvlexp[playerid] = PlayerText:INVALID_TEXT_DRAW;
    Time[playerid] = PlayerText:INVALID_TEXT_DRAW;
    TimeJail[playerid] = PlayerText:INVALID_TEXT_DRAW;
    Site[playerid] = PlayerText:INVALID_TEXT_DRAW;
	BoxInfo[playerid] = PlayerText:INVALID_TEXT_DRAW;
	InfoTitle[playerid] = PlayerText:INVALID_TEXT_DRAW;
	InfoText[playerid] = PlayerText:INVALID_TEXT_DRAW;
	gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
	gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    for(new x=0; x < SELECTION_ITEMS; x++) { gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW; }
	gItemAt[playerid] = 0;
    return true;
}
LoadKFC()
{
	new count = GetTickCount();
	new result[32+64*7+100];
	mysql_query("SELECT * FROM `KFC` ORDER BY  `KFC`.`id` ASC");
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
		for (new idx = 1;idx <= mysql_num_rows();idx ++)
		{
			mysql_fetch_row(result);
			sscanf(result, "p<|>ifff",
			KFC[idx][kID],
			KFC[idx][kX],
			KFC[idx][kY],
			KFC[idx][kZ]);
			CreatePickupWithText(1582, 1, 0xFFFFFFFF, KFC[idx][kX], KFC[idx][kY], KFC[idx][kZ],"���������� Alpino:",0,1);
			CreateDynamicMapIcon(KFC[idx][kX], KFC[idx][kY], KFC[idx][kZ], 10, COLOR_WHITE, 0, -1, -1, 400.0);
		}
	}
	mysql_free_result();
	printf("�������� KFC ������ ��: %d ��", GetTickCount()-count);
	return true;
}
LoadGangZones()
{
	new count = GetTickCount();
	new result[32+64*7+100];
	mysql_query("SELECT * FROM `GangZone` ORDER BY  `GangZone`.`id` ASC");
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
		for (new idx = 1;idx <= mysql_num_rows();idx ++)
		{
			mysql_fetch_row(result);
			sscanf(result, "p<|>iffffi",
			GangZone[idx][gzID],
			GangZone[idx][gzLocationminx],
			GangZone[idx][gzLocationminy],
			GangZone[idx][gzLocationmaxx],
			GangZone[idx][gzLocationmaxy],
			GangZone[idx][gzFraction]);
			GangZone[idx][gzCreate] = GangZoneCreate(GangZone[idx][gzLocationminx],GangZone[idx][gzLocationminy],GangZone[idx][gzLocationmaxx],GangZone[idx][gzLocationmaxy]);
		}
	}
	mysql_free_result();
	printf("�������� ������� ������ ��: %d ��", GetTickCount()-count);
	return true;
}
stock SaveGangZone(id)
{
	new src[150], query[1024];
	format(query,sizeof(query),"UPDATE `GangZone` SET ");
	format(src,sizeof(src),"Pos1=%f,",GangZone[id][gzLocationminx]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Pos2=%f,",GangZone[id][gzLocationminy]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Pos3=%f,", GangZone[id][gzLocationmaxx]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Pos4=%f,", GangZone[id][gzLocationmaxy]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Frac=%d", GangZone[id][gzFraction]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src)," WHERE ID='%i'",GangZone[id][gzID]);
	strcat(query,src,sizeof(query));
	mysql_query(query);
}
LoadHouse()
{
	new count = GetTickCount();
	new result[32+64*7+100], label[512];
	mysql_query("SELECT * FROM `property` ORDER BY  `property`.`id` ASC");
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
		for (new idx = 1;idx <= mysql_num_rows();idx ++)
		{
			mysql_fetch_row(result);
			sscanf(result, "p<|>iffffffs[64]iiiiiiiiiiiii",
			HouseInfo[idx][hID],
			HouseInfo[idx][hEntrancex],
			HouseInfo[idx][hEntrancey],
			HouseInfo[idx][hEntrancez],
			HouseInfo[idx][hExitx],
			HouseInfo[idx][hExity],
			HouseInfo[idx][hExitz],
			HouseInfo[idx][hOwner],
			HouseInfo[idx][hValue],
			HouseInfo[idx][hInt],
			HouseInfo[idx][hLock],
			HouseInfo[idx][hOwned],
			HouseInfo[idx][hLevel],
			HouseInfo[idx][hRent],
			HouseInfo[idx][hHeal],
			HouseInfo[idx][hArmour],
			HouseInfo[idx][hIcon],
			HouseInfo[idx][hBank],
			HouseInfo[idx][hMats],
			HouseInfo[idx][hDrugs],
			HouseInfo[idx][hMoney]);
			if(HouseInfo[idx][hOwned] == false)
			{
				CreateDynamicMapIcon(HouseInfo[idx][hEntrancex], HouseInfo[idx][hEntrancey], HouseInfo[idx][hEntrancez], 31, COLOR_WHITE, 0, -1, -1, 400.0);
				HouseInfo[idx][hPickup] = CreatePickup(1273, 23, HouseInfo[idx][hEntrancex], HouseInfo[idx][hEntrancey], HouseInfo[idx][hEntrancez],0);
				format(label,sizeof(label),""WHT"��� �: "GRN"%d\n"WHT"����: "GRN"%d\n"WHT"������� ����: "GRN"%d",idx,HouseInfo[idx][hValue],HouseInfo[idx][hLevel]);
			}
			else if(HouseInfo[idx][hOwned] == true && HouseInfo[idx][hRent] > 0)
			{
				HouseInfo[idx][hPickup] = CreatePickup(1272, 23, HouseInfo[idx][hEntrancex], HouseInfo[idx][hEntrancey], HouseInfo[idx][hEntrancez],0);
				CreateDynamicMapIcon(HouseInfo[idx][hEntrancex], HouseInfo[idx][hEntrancey], HouseInfo[idx][hEntrancez], 32, COLOR_WHITE, 0, -1, -1, 400.0);
				format(label,512,""WHT"��� �: "GRN"%d\n"WHT"��������: "GRN"%s\n"WHT"����: "GRN"%d\n"WHT"������� ����: "GRN"%d\n"WHT"��������� ������: "GRN"%d",idx,HouseInfo[idx][hOwner],HouseInfo[idx][hValue],HouseInfo[idx][hLevel],HouseInfo[idx][hRent]);
			}
			else if(HouseInfo[idx][hOwned] == true)
			{
				HouseInfo[idx][hPickup] = CreatePickup(1272, 23, HouseInfo[idx][hEntrancex], HouseInfo[idx][hEntrancey], HouseInfo[idx][hEntrancez],0);
				CreateDynamicMapIcon(HouseInfo[idx][hEntrancex], HouseInfo[idx][hEntrancey], HouseInfo[idx][hEntrancez], 32, COLOR_WHITE, 0, -1, -1, 400.0);
				format(label,512,""WHT"��� �: "GRN"%d\n"WHT"��������: "GRN"%s\n"WHT"����: "GRN"%d\n"WHT"������� ����: "GRN"%d",idx,HouseInfo[idx][hOwner],HouseInfo[idx][hValue],HouseInfo[idx][hLevel]);
			}
   			CreateDynamicCP(HouseInfo[idx][hExitx],HouseInfo[idx][hExity],HouseInfo[idx][hExitz],1,HouseInfo[idx][hID],HouseInfo[idx][hInt],-1,5.0);
            CreateDynamicCP(HouseInfo[idx][hEntrancex],HouseInfo[idx][hEntrancey],HouseInfo[idx][hEntrancez],1,0,0,-1,5.0);
			HouseInfo[idx][hLabel] = CreateDynamic3DTextLabel(label, -1, HouseInfo[idx][hEntrancex], HouseInfo[idx][hEntrancey], HouseInfo[idx][hEntrancez], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
		}
	}
	mysql_free_result();
	printf("�������� ����� ������ ��: %d ��", GetTickCount()-count);
	return true;
}
LoadMapIcon()
{
	new count = GetTickCount();
	new result[32+64*7+100];
	mysql_query("SELECT * FROM `MIcon` ORDER BY  `MIcon`.`id` ASC");
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
		for (new idx = 1;idx <= mysql_num_rows();idx ++)
		{
			mysql_fetch_row(result);
			sscanf(result, "p<|>ifffi",
			MIcon[idx][miID],
			MIcon[idx][miX],
			MIcon[idx][miY],
			MIcon[idx][miZ],
			MIcon[idx][miIkonka]);
			CreateDynamicMapIcon(MIcon[idx][miX],MIcon[idx][miY],MIcon[idx][miZ],MIcon[idx][miIkonka],0,-1,-1,-1,300);
		}
	}
	mysql_free_result();
	printf("�������� ������ ������ ��: %d ��", GetTickCount()-count);
	return true;
}

LoadJob()
{
	new count = GetTickCount();
	new result[32+64*7+100], jobtext[512];
	mysql_query("SELECT * FROM `Job` ORDER BY  `Job`.`id` ASC");
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
		for (new idx = 1;idx <= mysql_num_rows();idx ++)
		{
			mysql_fetch_row(result);
			sscanf(result, "p<|>ifffs[64]i",
			Job[idx][jID],
			Job[idx][jX],
			Job[idx][jY],
			Job[idx][jZ],
			Job[idx][jName],
			Job[idx][jLevel]);
			format(jobtext,sizeof(jobtext),"{BC6717}������:{FFFFFF} %s | {BC6717}����������� �������:{FFFFFF} %d | ����� ���������: {BC6717}ALT{FFFFFF}",Job[idx][jName],Job[idx][jLevel]);
			CreatePickupWithText(1239, 1, 0xFFFFFFFF, Job[idx][jX], Job[idx][jY], Job[idx][jZ],jobtext,0,1);
		}
	}
	mysql_free_result();
	printf("�������� ����� ������ ��: %d ��", GetTickCount()-count);
	return true;
}
stock LoadGas()
{
	new gastext[128], query[128], buffer[64], data[512];
	mysql_query("SELECT NULL FROM `Gas`");
	mysql_store_result();
	new rows = mysql_num_rows();
	mysql_free_result();
	for (new idx = 1; idx < rows; idx++)
	{
		format(query, sizeof(query), "SELECT * FROM `Gas` WHERE id = %d",idx);
		mysql_query(query);
		mysql_store_result();
		mysql_fetch_row(data);
		mysql_get_field("x", buffer); Gas[idx][gX] = floatstr(buffer);
		mysql_get_field("y", buffer); Gas[idx][gY] = floatstr(buffer);
		mysql_get_field("z", buffer); Gas[idx][gZ] = floatstr(buffer);
		mysql_get_field("price80", buffer); Gas[idx][gPrice80] = strval(buffer);
		mysql_get_field("price92", buffer); Gas[idx][gPrice92] = strval(buffer);
		mysql_get_field("price95", buffer); Gas[idx][gPrice95] = strval(buffer);
		mysql_get_field("pricedisel", buffer); Gas[idx][gPriceDisel] = strval(buffer);
		mysql_get_field("k80", buffer); Gas[idx][g80] = strval(buffer);
		mysql_get_field("k92", buffer); Gas[idx][g92] = strval(buffer);
		mysql_get_field("k95", buffer); Gas[idx][g95] = strval(buffer);
		mysql_get_field("disel", buffer); Gas[idx][gDisel] = strval(buffer);
		mysql_get_field("price", buffer); Gas[idx][gPrice] = strval(buffer);
		mysql_get_field("level", buffer); Gas[idx][gLevel] = strval(buffer);
		mysql_get_field("owned", buffer); Gas[idx][gOwned] = bool:strval(buffer);
		mysql_get_field("bank", buffer); Gas[idx][gBank] = strval(buffer);
		mysql_get_field("owner", buffer); strmid(Gas[idx][gOwner], buffer, 0, strlen(buffer), 255);
		mysql_get_field("Pos", buffer); Gas[idx][Pos][0] = floatstr(buffer);
		mysql_get_field("Pos1", buffer); Gas[idx][Pos][1] = floatstr(buffer);
		mysql_get_field("Pos2", buffer); Gas[idx][Pos][2] = floatstr(buffer);
		switch(Gas[idx][gOwned])
		{
			case 0: format(gastext,sizeof(gastext),""PURP"ID:\t"YE" %d"PURP"\n����:\t"YE" %d\n"PURP"�������:\t"YE" %d",idx,Gas[idx][gPrice],Gas[idx][gLevel]);
			case 1: format(gastext,sizeof(gastext),""PURP"��������:\t"YE" %s\n"PURP"ID:\t"YE" %d\n"PURP"�������:\t"YE" %d",Gas[idx][gOwner],idx,Gas[idx][gLevel]);
		}
		CreateDynamicPickup(1650, 1, Gas[idx][Pos][0], Gas[idx][Pos][1], Gas[idx][Pos][2], -1, -1, -1, 100.0);
		Gas[idx][gLabel] = Create3DTextLabel(gastext,0x008080FF,Gas[idx][Pos][0], Gas[idx][Pos][1], Gas[idx][Pos][2],50.0,0,0);
		CreateDynamicMapIcon(Gas[idx][gX],Gas[idx][gY], Gas[idx][gZ], 55, COLOR_WHITE, 0, -1, -1, 400.0);
		CreateDynamicCP(Gas[idx][gX], Gas[idx][gY], Gas[idx][gZ], 4.0, 0, 0, -1, 15.0);
	}
	mysql_free_result();
	return true;
}
stock SaveGas(gas)
{
	new src[512], query[512];
	format(query,sizeof(query),"UPDATE `Gas` SET ");
	format(src,sizeof(src),"x='%f',",Gas[gas][gX]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"y='%f',",Gas[gas][gY]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"z=%f,", Gas[gas][gZ]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"price80=%d,", Gas[gas][gPrice80]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"price92=%d,", Gas[gas][gPrice92]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"price95=%d,", Gas[gas][gPrice95]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"pricedisel=%d,", Gas[gas][gPriceDisel]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"k80=%d,", Gas[gas][g80]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"k92=%d,", Gas[gas][g92]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"k95=%d,", Gas[gas][g95]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"disel=%d,", Gas[gas][gDisel]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"price=%d,", Gas[gas][gPrice]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"level=%d,", Gas[gas][gLevel]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"owner='%s',", Gas[gas][gOwner]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"owned=%d,", Gas[gas][gOwned]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"bank=%d,", Gas[gas][gBank]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Pos='%f',", Gas[gas][Pos][0]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Pos1='%f',", Gas[gas][Pos][1]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Pos2='%f'", Gas[gas][Pos][2]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"WHERE ID='%i'",gas);
	strcat(query,src,sizeof(query));
	mysql_query(query);
    return true;
}
stock LoadAmmo()
{
	new query[128], buffer[64], data[512],ammotext[512];
	mysql_query("SELECT NULL FROM `Ammo`");
	mysql_store_result();
	new rows = mysql_num_rows();
	mysql_free_result();
	for (new idx = 1; idx <= rows; idx++)
	{
		format(query, sizeof(query), "SELECT * FROM `Ammo` WHERE id = %d",idx);
		mysql_query(query);
		mysql_store_result();
		mysql_fetch_row(data);
		mysql_get_field("ID", buffer); Ammo[idx][amID] = strval(buffer);
		mysql_get_field("EnterX", buffer); Ammo[idx][amEnterX] = floatstr(buffer);
		mysql_get_field("EnterY", buffer); Ammo[idx][amEnterY] = floatstr(buffer);
		mysql_get_field("EnterZ", buffer); Ammo[idx][amEnterZ] = floatstr(buffer);
		mysql_get_field("ExitX", buffer); Ammo[idx][amExitX] = floatstr(buffer);
		mysql_get_field("ExitY", buffer); Ammo[idx][amExitY] = floatstr(buffer);
		mysql_get_field("ExitZ", buffer); Ammo[idx][amExitZ] = floatstr(buffer);
		mysql_get_field("BuyX", buffer); Ammo[idx][amBuyX] = floatstr(buffer);
		mysql_get_field("BuyY", buffer); Ammo[idx][amBuyY] = floatstr(buffer);
		mysql_get_field("BuyZ", buffer); Ammo[idx][amBuyZ] = floatstr(buffer);
		mysql_get_field("Owner", buffer); strmid(Ammo[idx][amOwner], buffer, 0, strlen(buffer), 255);
		mysql_get_field("Owned", buffer); Ammo[idx][amOwned] = bool:strval(buffer);
		mysql_get_field("Level", buffer); Ammo[idx][amLevel] = strval(buffer);
		mysql_get_field("Price", buffer); Ammo[idx][amPrice] = strval(buffer);
		mysql_get_field("Bank", buffer); Ammo[idx][amBank] = strval(buffer);
		mysql_get_field("Interior", buffer); Ammo[idx][amInterior] = strval(buffer);
		mysql_get_field("Locked", buffer); Ammo[idx][amLock] = bool:strval(buffer);
		mysql_get_field("Vxod", buffer); Ammo[idx][amPriceVx] = strval(buffer);
		if(Ammo[idx][amOwned] == false)
		{
			AddStaticPickup(1274, 1, Ammo[idx][amEnterX], Ammo[idx][amEnterY], Ammo[idx][amEnterZ]);
			format(ammotext,sizeof(ammotext),"{FF0000}** ��������� ��������! **\n{E86B17}ID: {10B8DE}%d\n{E86B17}����: {10B8DE}%d\n{E86B17}�������: {10B8DE}%d",idx,Ammo[idx][amPrice],Ammo[idx][amLevel]);
		}
		if(Ammo[idx][amOwned] == true)
		{
			AddStaticPickup(19132, 1, Ammo[idx][amEnterX], Ammo[idx][amEnterY], Ammo[idx][amEnterZ]);
			format(ammotext,sizeof(ammotext),"{E86B17}��������: {10B8DE}%s\n{E86B17}�������: {10B8DE}%d\n{E86B17}C�������� �����: {10B8DE}%d",Ammo[idx][amOwner],Ammo[idx][amLevel],Ammo[idx][amPriceVx]);
			Update3DTextLabelText(Ammo[idx][amLabel],0x008080FF,ammotext);
		}
		CreateDynamicMapIcon(Ammo[idx][amEnterX], Ammo[idx][amEnterY], Ammo[idx][amEnterZ], 18, COLOR_WHITE, 0, -1, -1, 400.0);
		Ammo[idx][amLabel] = Create3DTextLabel(ammotext,0x008080FF,Ammo[idx][amEnterX],Ammo[idx][amEnterY],Ammo[idx][amEnterZ],15.0,0,1);
		CreateDynamicCP(Ammo[idx][amBuyX],Ammo[idx][amBuyY],Ammo[idx][amBuyZ], 1.0, Ammo[idx][amID], Ammo[idx][amInterior], -1, 400.0);
 		CreateDynamicCP(Ammo[idx][amExitX],Ammo[idx][amExitY],Ammo[idx][amExitZ],1,Ammo[idx][amID],Ammo[idx][amInterior],-1,2.0);
  		CreateDynamicCP(Ammo[idx][amEnterX],Ammo[idx][amEnterY],Ammo[idx][amEnterZ],1,0,0,-1,5.0);
	}
	mysql_free_result();
	return true;
}
stock LoadInfa()
{
	new query[128], buffer[64], data[512],travka[150],metall[100];
	mysql_query("SELECT NULL FROM `Infa`");
	mysql_store_result();
	new rows = mysql_num_rows();
	mysql_free_result();
	for (new idx = 1; idx < rows; idx++)
	{
		format(query, sizeof(query), "SELECT * FROM `Infa` WHERE ID = 1");
		mysql_query(query);
		mysql_store_result();
		mysql_fetch_row(data);
		mysql_get_field("Trava", buffer); Infa[iiTrava] = strval(buffer);
		mysql_get_field("Metall", buffer); Infa[iiMetall] = strval(buffer);
		mysql_get_field("Mats", buffer); Infa[iiMats] = strval(buffer);
		mysql_get_field("Drugs", buffer); Infa[iiDrugs] = strval(buffer);
		mysql_get_field("Patron", buffer); Infa[iiPatron] = strval(buffer);
		mysql_get_field("AU80", buffer); Infa[iiAU80] = strval(buffer);
		mysql_get_field("AU92", buffer); Infa[iiAU92] = strval(buffer);
		mysql_get_field("AU95", buffer); Infa[iiAU95] = strval(buffer);
		mysql_get_field("Disel", buffer); Infa[iiDisel] = strval(buffer);
		format(travka,sizeof(travka),"{9ACD32}����� �� ������:{FFFFFF} %s",ConvertCash(Infa[iiTrava]));
		format(metall,sizeof(metall),"{9ACD32}������� �� ������:{FFFFFF} %s",ConvertCash(Infa[iiMetall]));
		Infa[iiLabelTrava] = Create3DTextLabel(travka,0x008080FF,-1059.5981,-1205.5291,129.2188,15.0,0,1);
		Infa[iiLabelMetall] = Create3DTextLabel(metall,0x008080FF,-1906.9303,-1670.7955,23.0156,15.0,0,1);

	}
	mysql_free_result();
	return true;
}
stock LoadRadars()
{
	new query[128], buffer[64], data[512];
	mysql_query("SELECT NULL FROM `Radar`");
	mysql_store_result();
	new rows = mysql_num_rows();
	mysql_free_result();
	for (new idx = 1; idx < rows; idx++)
	{
		format(query, sizeof(query), "SELECT * FROM `Radar` WHERE ID = %d",idx);
		mysql_query(query);
		mysql_store_result();
		mysql_fetch_row(data);
		mysql_get_field("ID", buffer); Radar[idx][rID] = strval(buffer);
		mysql_get_field("x", buffer); Radar[idx][rX] = floatstr(buffer);
		mysql_get_field("y", buffer); Radar[idx][rY] = floatstr(buffer);
		mysql_get_field("z", buffer); Radar[idx][rZ] = floatstr(buffer);
		mysql_get_field("rX", buffer); Radar[idx][rrX] = floatstr(buffer);
		mysql_get_field("rY", buffer); Radar[idx][rrY] = floatstr(buffer);
		mysql_get_field("rZ", buffer); Radar[idx][rrZ] = floatstr(buffer);
		mysql_get_field("type", buffer); Radar[idx][rType] = bool:strval(buffer);
		CreateDynamicObject(18880,Radar[idx][rX],Radar[idx][rY],Radar[idx][rZ],Radar[idx][rrX],Radar[idx][rrY],Radar[idx][rrZ]);
	}
	mysql_free_result();
	return true;
}
stock SaveInfa()
{
	new src[512], query[1024];
	format(query,sizeof(query),"UPDATE `Infa` SET ");
	format(src,sizeof(src),"Trava=%d,",Infa[iiTrava]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Metall=%d,",Infa[iiMetall]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Mats=%d,", Infa[iiMats]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Drugs=%d,",Infa[iiDrugs]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Patron=%d,",Infa[iiPatron]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"AU80=%d,",Infa[iiAU80]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"AU92=%d,",Infa[iiAU92]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"AU95=%d,",Infa[iiAU95]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Disel=%d,",Infa[iiDisel]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"WHERE ID = 1");
	strcat(query,src,sizeof(query));
	mysql_query(query);
    return true;
}
stock LoadClub()
{
	new query[128], buffer[64], data[512],club[512];
	mysql_query("SELECT NULL FROM `Club`");
	mysql_store_result();
	new rows = mysql_num_rows();
	mysql_free_result();
	for (new idx = 1; idx <= rows; idx++)
	{
		format(query, sizeof(query), "SELECT * FROM `Club` WHERE ID = %d",idx);
		mysql_query(query);
		mysql_store_result();
		mysql_fetch_row(data);
		mysql_get_field("ID", buffer); Club[idx][cID] = strval(buffer);
		mysql_get_field("EnterX", buffer); Club[idx][cEnterX] = floatstr(buffer);
		mysql_get_field("EnterY", buffer); Club[idx][cEnterY] = floatstr(buffer);
		mysql_get_field("EnterZ", buffer); Club[idx][cEnterZ] = floatstr(buffer);
		mysql_get_field("ExitX", buffer); Club[idx][cExitX] = floatstr(buffer);
		mysql_get_field("ExitY", buffer); Club[idx][cExitY] = floatstr(buffer);
		mysql_get_field("ExitZ", buffer); Club[idx][cExitZ] = floatstr(buffer);
		mysql_get_field("BuyX", buffer); Club[idx][cBuyX] = floatstr(buffer);
		mysql_get_field("BuyY", buffer); Club[idx][cBuyY] = floatstr(buffer);
		mysql_get_field("BuyZ", buffer); Club[idx][cBuyZ] = floatstr(buffer);
		mysql_get_field("Owner", buffer); strmid(Club[idx][cOwner], buffer, 0, strlen(buffer), 255);
		mysql_get_field("Owned", buffer); Club[idx][cOwned] = bool:strval(buffer);
		mysql_get_field("Level", buffer); Club[idx][cLevel] = strval(buffer);
		mysql_get_field("Price", buffer); Club[idx][cPrice] = strval(buffer);
		mysql_get_field("Bank", buffer); Club[idx][cBank] = strval(buffer);
		mysql_get_field("Interior", buffer); Club[idx][cInterior] = strval(buffer);
		mysql_get_field("Locked", buffer); Club[idx][cLock] = bool:strval(buffer);
		mysql_get_field("PriceVx", buffer); Club[idx][cPriceVx] = strval(buffer);
		if(Club[idx][cOwned] == false)
		{
			CreateDynamicPickup(1274, 1, Club[idx][cEnterX], Club[idx][cEnterY], Club[idx][cEnterZ],-1,-1,-1,100.0);
			format(club,sizeof(club),"{FF0000}** ��������� ��������! **\n{E86B17}ID: {10B8DE}%d\n{E86B17}����: {10B8DE}%d\n{E86B17}�������: {10B8DE}%d",idx,Club[idx][cPrice],Club[idx][cLevel]);
		}
		if(Club[idx][cOwned] == true)
		{
			CreateDynamicPickup(19132, 1, Club[idx][cEnterX], Club[idx][cEnterY], Club[idx][cEnterZ],-1,-1,-1,100.0);
			format(club,sizeof(club),"{E86B17}��������: {10B8DE}%s\n{E86B17}�������: {10B8DE}%d\n{E86B17}C�������� �����: {10B8DE}%d",Club[idx][cOwner],Club[idx][cLevel],Club[idx][cPriceVx]);
		}
		CreateDynamicMapIcon(Club[idx][cEnterX], Club[idx][cEnterY], Club[idx][cEnterZ], 48, COLOR_WHITE, 0, -1, -1, 400.0);
		Club[idx][cLabel] = Create3DTextLabel(club,0x008080FF,Club[idx][cEnterX],Club[idx][cEnterY],Club[idx][cEnterZ],15.0,0,1);
		CreateDynamicCP(Club[idx][cBuyX], Club[idx][cBuyY], Club[idx][cBuyZ], 1.0, Club[idx][cID],  Club[idx][cInterior], -1,100.0);
		CreateDynamicCP(Club[idx][cExitX],Club[idx][cExitY],Club[idx][cExitZ],1,Club[idx][cID],Club[idx][cInterior],-1,3.0);
      	CreateDynamicCP(Club[idx][cEnterX],Club[idx][cEnterY],Club[idx][cEnterZ],1,0,0,-1,5.0);
	}
	mysql_free_result();
	return true;
}
stock SaveClub(club)
{
	new src[512], query[1024];
	format(query,sizeof(query),"UPDATE `Club` SET ");
	format(src,sizeof(src),"EnterX='%f',",Club[club][cEnterX]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"EnterY='%f',",Club[club][cEnterY]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"EnterZ='%f',", Club[club][cEnterZ]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"ExitX='%f',",Club[club][cExitX]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"ExitY='%f',",Club[club][cExitY]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"ExitZ='%f',", Club[club][cExitZ]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"BuyX='%f',",Club[club][cBuyX]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"BuyY='%f',",Club[club][cBuyY]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"BuyZ='%f',", Club[club][cBuyZ]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Owner='%s',", Club[club][cOwner]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Owned=%d,", Club[club][cOwned]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Level=%d,", Club[club][cLevel]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Price=%d,", Club[club][cPrice]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Bank=%d,", Club[club][cBank]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Interior=%d,", Club[club][cInterior]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Locked=%d,", Club[club][cLock]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"PriceVx=%d", Club[club][cPriceVx]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src)," WHERE ID='%i'",club);
	strcat(query,src,sizeof(query));
	mysql_query(query);
    return true;
}
stock LoadMagazin()
{
	new query[128], buffer[64], data[512],magazin[512];
	mysql_query("SELECT NULL FROM `Magazin`");
	mysql_store_result();
	new rows = mysql_num_rows();
	mysql_free_result();
	for (new idx = 1; idx <= rows; idx++)
	{
		format(query, sizeof(query), "SELECT * FROM `Magazin` WHERE id = %d",idx);
		mysql_query(query);
		mysql_store_result();
		mysql_fetch_row(data);
		mysql_get_field("ID", buffer); Magazin[idx][mID] = strval(buffer);
		mysql_get_field("EnterX", buffer); Magazin[idx][mEnterX] = floatstr(buffer);
		mysql_get_field("EnterY", buffer); Magazin[idx][mEnterY] = floatstr(buffer);
		mysql_get_field("EnterZ", buffer); Magazin[idx][mEnterZ] = floatstr(buffer);
		mysql_get_field("ExitX", buffer); Magazin[idx][mExitX] = floatstr(buffer);
		mysql_get_field("ExitY", buffer); Magazin[idx][mExitY] = floatstr(buffer);
		mysql_get_field("ExitZ", buffer); Magazin[idx][mExitZ] = floatstr(buffer);
		mysql_get_field("BuyX", buffer); Magazin[idx][mBuyX] = floatstr(buffer);
		mysql_get_field("BuyY", buffer); Magazin[idx][mBuyY] = floatstr(buffer);
		mysql_get_field("BuyZ", buffer); Magazin[idx][mBuyZ] = floatstr(buffer);
		mysql_get_field("Owner", buffer); strmid(Magazin[idx][mOwner], buffer, 0, strlen(buffer), 255);
		mysql_get_field("Owned", buffer); Magazin[idx][mOwned] = bool:strval(buffer);
		mysql_get_field("Level", buffer); Magazin[idx][mLevel] = strval(buffer);
		mysql_get_field("Price", buffer); Magazin[idx][mPrice] = strval(buffer);
		mysql_get_field("Bank", buffer); Magazin[idx][mBank] = strval(buffer);
		mysql_get_field("Interior", buffer); Magazin[idx][mInterior] = strval(buffer);
		mysql_get_field("Locked", buffer); Magazin[idx][mLock] = bool:strval(buffer);
		if(Magazin[idx][mOwned] == false)
		{
			AddStaticPickup(1274, 1, Magazin[idx][mEnterX], Magazin[idx][mEnterY], Magazin[idx][mEnterZ]);
			format(magazin,sizeof(magazin),"{FF0000}** ������� ��������! **\n{E86B17}ID: {10B8DE}%d\n{E86B17}����: {10B8DE}%d\n{E86B17}�������: {10B8DE}%d",idx,Magazin[idx][mPrice],Magazin[idx][mLevel]);
		}
		if(Magazin[idx][mOwned] == true)
		{
			AddStaticPickup(19132, 1, Magazin[idx][mEnterX], Magazin[idx][mEnterY], Magazin[idx][mEnterZ]);
			format(magazin,sizeof(magazin),"{E86B17}��������: {10B8DE}%s\n{E86B17}�������: {10B8DE}%d",Magazin[idx][mOwner],Magazin[idx][mLevel]);
			Update3DTextLabelText(Magazin[idx][mLabel],0x008080FF,magazin);
		}
		CreateDynamicMapIcon(Magazin[idx][mEnterX], Magazin[idx][mEnterY], Magazin[idx][mEnterZ], 17, COLOR_WHITE, 0, -1, -1, 400.0);
		Magazin[idx][mLabel] = Create3DTextLabel(magazin,0x008080FF,Magazin[idx][mEnterX],Magazin[idx][mEnterY],Magazin[idx][mEnterZ],15.0,0,1);
		CreateDynamicCP(Magazin[idx][mBuyX],Magazin[idx][mBuyY],Magazin[idx][mBuyZ], 1.0, Magazin[idx][mID], Magazin[idx][mInterior], -1, 400.0);
 		CreateDynamicCP(Magazin[idx][mExitX],Magazin[idx][mExitY],Magazin[idx][mExitZ],1,Magazin[idx][mID],Magazin[idx][mInterior],-1,3.0);
      	CreateDynamicCP(Magazin[idx][mEnterX],Magazin[idx][mEnterY],Magazin[idx][mEnterZ],1,0,0,-1,5.0);

	}
	mysql_free_result();
	return true;
}
stock SaveMagazin(magazin)
{
	new src[512], query[1024];
	format(query,sizeof(query),"UPDATE `Magazin` SET ");
	format(src,sizeof(src),"EnterX='%f',",Magazin[magazin][mEnterX]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"EnterY='%f',",Magazin[magazin][mEnterY]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"EnterZ='%f',", Magazin[magazin][mEnterZ]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"ExitX='%f',",Magazin[magazin][mExitX]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"ExitY='%f',",Magazin[magazin][mExitY]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"ExitZ='%f',", Magazin[magazin][mExitZ]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"BuyX='%f',",Magazin[magazin][mBuyX]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"BuyY='%f',",Magazin[magazin][mBuyY]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"BuyZ='%f',", Magazin[magazin][mBuyZ]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Owner='%s',", Magazin[magazin][mOwner]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Owned=%d,", Magazin[magazin][mOwned]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Level=%d,", Magazin[magazin][mLevel]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Price=%d,", Magazin[magazin][mPrice]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Bank=%d,", Magazin[magazin][mBank]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Interior=%d,", Magazin[magazin][mInterior]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Locked=%d", Magazin[magazin][mLock]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src)," WHERE ID='%i'",magazin);
	strcat(query,src,sizeof(query));
	mysql_query(query);
    return true;
}
stock SaveAmmo(ammo)
{
	new sql[1024];
/*	format(query,sizeof(query),"UPDATE `Ammo` SET ");
	format(src,sizeof(src),"EnterX=%f,",Ammo[ammo][amEnterX]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"EnterY=%f,",Ammo[ammo][amEnterY]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"EnterZ=%f,", Ammo[ammo][amEnterZ]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"c=%f,",Ammo[ammo][amExitX]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"ExitY=%f,",Ammo[ammo][amExitY]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"ExitZ=%f,", Ammo[ammo][amExitZ]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"BuyX=%f,",Ammo[ammo][amBuyX]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"BuyY=%f,",Ammo[ammo][amBuyY]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"BuyZ=%f,", Ammo[ammo][amBuyZ]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Owner='%s',", Ammo[ammo][amOwner]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Owned=%d,", Ammo[ammo][amOwned]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Level=%d,", Ammo[ammo][amLevel]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Price=%d,", Ammo[ammo][amPrice]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Bank=%d,", Ammo[ammo][amBank]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Interior=%d,", Ammo[ammo][amInterior]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Locked=%d,", Ammo[ammo][amLock]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src),"Vxod=%d", Ammo[ammo][amPriceVx]);
	strcat(query,src,sizeof(query));
	format(src,sizeof(src)," WHERE ID='%i'",ammo);
	strcat(query,src,sizeof(query));*/
	format(sql, sizeof(sql), "UPDATE `Ammo` SET EnterX=%f,EnterY=%f,EnterZ=%f,ExitX=%f,ExitY=%f,ExitZ=%f,BuyX=%f,BuyY=%f,BuyZ=%f,Owner='%s',Owned=%d,Level=%d,Price=%d,Bank=%d,Interior=%d,Locked=%d,Vxod=%d WHERE ID='%i'",
	Ammo[ammo][amEnterX],
	Ammo[ammo][amEnterY],
	Ammo[ammo][amEnterZ],
	Ammo[ammo][amExitX],
	Ammo[ammo][amExitY],
	Ammo[ammo][amExitZ],
	Ammo[ammo][amBuyX],
	Ammo[ammo][amBuyY],
	Ammo[ammo][amBuyZ],
	Ammo[ammo][amOwner],
	Ammo[ammo][amOwned],
	Ammo[ammo][amLevel],
	Ammo[ammo][amPrice],
	Ammo[ammo][amBank],
	Ammo[ammo][amInterior],
	Ammo[ammo][amLock],
	Ammo[ammo][amPriceVx],ammo);
	mysql_query(sql);
    return true;
}

stock SaveHouse(h)
{
	new sql[1024];
	new idx = h;
	format(sql, sizeof(sql), "UPDATE `property` SET ent_x=%f,ent_y=%f,ent_z=%f,ext_x=%f,ext_y=%f,ext_z=%f,owner='%s',price=%d,interior=%d,locked=%d,owned=%d,level=%d,rent=%d,heal=%d,armour=%d,icon=%d,bank=%d,mats=%d,drugs=%d,money=%d WHERE id='%i'",
	HouseInfo[idx][hEntrancex],
	HouseInfo[idx][hEntrancey],
	HouseInfo[idx][hEntrancez],
	HouseInfo[idx][hExitx],
	HouseInfo[idx][hExity],
	HouseInfo[idx][hExitz],
	HouseInfo[idx][hOwner],
	HouseInfo[idx][hValue],
	HouseInfo[idx][hInt],
	HouseInfo[idx][hLock],
	HouseInfo[idx][hOwned],
	HouseInfo[idx][hLevel],
	HouseInfo[idx][hRent],
	HouseInfo[idx][hHeal],
	HouseInfo[idx][hArmour],
	HouseInfo[idx][hIcon],
	HouseInfo[idx][hBank],
	HouseInfo[idx][hMats],
	HouseInfo[idx][hDrugs],
	HouseInfo[idx][hMoney],h);
	mysql_query(sql);
	return true;
}


stock CheckBanList(playerid)
{
	new unbandate, bool:ban, ip[32],str[255];
	GetPlayerIp(playerid, ip, 32);
	format(str, sizeof(str), "SELECT unbandate FROM bans WHERE name = '%s'", PlayerInfo[playerid][pName]);
	if(mysql_query(str) && mysql_store_result())
	{
		if(mysql_num_rows()) { unbandate = mysql_fetch_int(); if(unbandate > gettime()) ban = true; }
	}
	mysql_free_result();
	if(!ban)
	{
		format(str, sizeof(str), "SELECT unbandate FROM bans WHERE ip = '%s'", ip);
		if(mysql_query(str) && mysql_store_result())
		{
			if(mysql_num_rows()) { unbandate = mysql_fetch_int(); if(unbandate > gettime()) ban = true; }
		}
		mysql_free_result();
	}
	if(ban)
	{
		new data[512], query[128], buffer[64], bant[64], unbant, reason[64], strss[128], admin[64];
		format(query, sizeof(query), "SELECT * FROM `bans` WHERE name = '%s'",PlayerInfo[playerid][pName]);
		mysql_query(query);
		mysql_store_result();
		mysql_fetch_row(data);
		mysql_get_field("bandate", buffer); 	strmid(bant, buffer, 0, strlen(buffer), 255);
		mysql_get_field("unbandate", buffer); 	unbant = strval(buffer);
		mysql_get_field("reason", buffer); 		strmid(reason, buffer, 0, strlen(buffer), 255);
		mysql_get_field("admin", buffer); 		strmid(admin, buffer, 0, strlen(buffer), 255);
		mysql_free_result();
		new unbantime[25];
		format(strss, sizeof(strss), "SELECT FROM_UNIXTIME( %d )", unbant);
		if(mysql_query(strss) && mysql_store_result()) mysql_fetch_row_format(unbantime);
		format(str, sizeof(str), "{BB0909}��� �������:{FFFFFF} %s\n{BB0909}���� ����:{FFFFFF} %s\n{BB0909}�������:{FFFFFF} %s\n{BB0909}���� �������:{FFFFFF} %s", admin, bant, reason, unbantime);
		SPD(playerid, DIALOG_BAN , DIALOG_STYLE_MSGBOX, "�� ��������", str, "�������", "");
 		ALKick(playerid);
	}
	return true;
}
stock fromUnixTime(time)
{
	new unbantime[25],str[255];
	format(str, sizeof(str), "SELECT FROM_UNIXTIME( %d )", time);
	if(mysql_query(str) && mysql_store_result()) mysql_fetch_row_format(unbantime);
	mysql_free_result();
	return unbantime;
}
UpdateHouseText(h)
{
	new housetext[512];
	switch(HouseInfo[h][hOwned])
	{
		case 0:
		{
			format(housetext,512,""WHT"��� �: "GRN"%d\n"WHT"����: "GRN"%d\n"WHT"������� ����: "GRN"%d",h,HouseInfo[h][hValue],HouseInfo[h][hLevel]);
			DestroyDynamicMapIcon(HouseInfo[h][hIcon]);
			HouseInfo[h][hIcon] = CreateDynamicMapIcon(HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez], 31, COLOR_WHITE, 0, -1, -1, 400.0);
		}
		case 1:
		{
			DestroyDynamicMapIcon(HouseInfo[h][hIcon]);
			format(housetext,512,""WHT"��� �: "GRN"%d\n"WHT"��������: "GRN"%s\n"WHT"����: "GRN"%d\n"WHT"������� ����: "GRN"%d",h,HouseInfo[h][hOwner],HouseInfo[h][hValue],HouseInfo[h][hLevel]);
			HouseInfo[h][hIcon] = CreateDynamicMapIcon(HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez], 32, COLOR_WHITE, 0, -1, -1, 400.0);
		}
	}
	if(HouseInfo[h][hOwned] == true && HouseInfo[h][hRent] > 0)
	{
		format(housetext,512,""WHT"��� �: "GRN"%d\n"WHT"��������: "GRN"%s\n"WHT"����: "GRN"%d\n"WHT"������� ����: "GRN"%d\n"WHT"��������� ������: "GRN"%d",h,HouseInfo[h][hOwner],HouseInfo[h][hValue],HouseInfo[h][hLevel],HouseInfo[h][hRent]);
		CreateDynamicMapIcon(HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez], 32, COLOR_WHITE, 0, -1, -1, 400.0);
	}
	UpdateDynamic3DTextLabelText(HouseInfo[h][hLabel],0x008080FF,housetext);
}
stock UpdateGasText(g)
{
	new gastext[500];
	switch(Gas[g][gOwned])
	{
		case 0: format(gastext,sizeof(gastext),""PURP"ID:\t"YE"%d\n"PURP"����:\t"YE"%d\n"PURP"�������:\t"YE"%d",g,Gas[g][gPrice],Gas[g][gLevel]);
		case 1: format(gastext,sizeof(gastext),""PURP"��������:\t"YE"%s\n"PURP"ID:\t"YE"%d\n"PURP"�������:\t"YE"%d",Gas[g][gOwner],g,Gas[g][gLevel]);
	}
	Update3DTextLabelText(Gas[g][gLabel],0x008080FF,gastext);
}
stock UpdateInfa()
{
	new travka[100],metall[100],drugs[100],mats[100],patron[100];
	format(travka,sizeof(travka),"{9ACD32}����� �� ������:{FFFFFF} %s",ConvertCash(Infa[iiTrava]));
	Update3DTextLabelText(Infa[iiLabelTrava],-1,travka);
	format(metall,sizeof(metall),"{9ACD32}������� �� ������:{FFFFFF} %s",ConvertCash(Infa[iiMetall]));
	Update3DTextLabelText(Infa[iiLabelMetall],-1,metall);
	format(drugs,sizeof(drugs),"{9ACD32}���������� �� ������:{FFFFFF} %s",ConvertCash(Infa[iiDrugs]));
	Update3DTextLabelText(Infa[iiLabelDrugs],-1,drugs);
	format(mats,sizeof(mats),"{9ACD32}������� �� ������:{FFFFFF} %s",ConvertCash(Infa[iiMats]));
	Update3DTextLabelText(Infa[iiLabelMats],-1,mats);
	format(patron,sizeof(patron),"{9ACD32}������ �� ������:{FFFFFF} %s",ConvertCash(Infa[iiPatron]));
	Update3DTextLabelText(Infa[iiLabelPatron],-1,patron);
}
stock UpdateAmmoText(am)
{
	new ammotext[500];
	switch(Ammo[am][amOwned])
	{
		case 0: format(ammotext,sizeof(ammotext),"{FF0000}** ��������� ��������! **\n{E86B17}ID: {10B8DE}%d\n{E86B17}����: {10B8DE}%d\n{E86B17}�������: {10B8DE}%d",am,Ammo[am][amPrice],Ammo[am][amLevel]);
		case 1: format(ammotext,sizeof(ammotext),"{E86B17}��������: {10B8DE}%s\n{E86B17}�������: {10B8DE}%d\n{E86B17}C�������� �����: {10B8DE}%d",Ammo[am][amOwner],Ammo[am][amLevel],Ammo[am][amPriceVx]);
	}
	Update3DTextLabelText(Ammo[am][amLabel],0x008080FF,ammotext);
}
stock UpdateClubText(c)
{
	new clubtext[500];
	switch(Club[c][cOwned])
	{
		case 0: format(clubtext,sizeof(clubtext),"{FF0000}** ��������� ��������! **\n{E86B17}ID: {10B8DE}%d\n{E86B17}����: {10B8DE}%d\n{E86B17}�������: {10B8DE}%d",c,Club[c][cLevel],Club[c][cPrice]);
		case 1: format(clubtext,sizeof(clubtext),"{E86B17}��������: {10B8DE}%s\n{E86B17}�������: {10B8DE}%d\n{E86B17}C�������� �����: {10B8DE}%d",Club[c][cOwner],Club[c][cLevel],Club[c][cPriceVx]);
	}
	Update3DTextLabelText(Club[c][cLabel],0x008080FF,clubtext);
}
stock UpdateMagazinText(magazid)
{
	new magazin[500];
	switch(Magazin[magazid][mOwned])
	{
		case 0: format(magazin,sizeof(magazin),"{FF0000}** ������� ��������! **\n{E86B17}ID: {10B8DE}%d\n{E86B17}����: {10B8DE}%d\n{E86B17}�������: {10B8DE}%d",magazid,Magazin[magazid][mLevel],Magazin[magazid][mPrice]);
		case 1: format(magazin,sizeof(magazin),"{E86B17}��������: {10B8DE}%s\n{E86B17}�������: {10B8DE}%d",Magazin[magazid][mOwner],Magazin[magazid][mLevel]);
	}
	Update3DTextLabelText(Magazin[magazid][mLabel],0x008080FF,magazin);
}
forward PlayerTimer();
public PlayerTimer()
{
	foreach(Player,i)
	{
		if(GetPlayerSkin(i) == 0) SetPlayerSkin(i,PlayerInfo[i][pSkin]);
		//AFKCheck(i);
		Prava(i);
		if(GetPVarInt(i, "TimeUse") == 1) ShowTime(i);
		if(find[i] == true)
		{
			new Float:Pos2[3];
			GetPlayerPos(findplayer[i],Pos2[0],Pos2[1],Pos2[2]);
			SetPlayerCheckpoint(i,Pos2[0],Pos2[1],Pos2[2],3.0);
		}
		if(GetPVarInt(i,"spawnkill") > 0) SetPVarInt(i,"spawnkill",GetPVarInt(i,"spawnkill")-1);
		if(PlayerInfo[i][pMuteTime] > 0) PlayerInfo[i][pMuteTime] --;
		if(PlayerInfo[i][pJailTime] > 0)
		{
			new string[100];
			format(string,sizeof(string),"Time in Jail: %s",ConvertSeconds(PlayerInfo[i][pJailTime]));
			PlayerTextDrawSetString(i,TimeJail[i], string);
			PlayerTextDrawShow(i,TimeJail[i]);
			PlayerInfo[i][pJailTime] --;
		}
		if(GetPlayerState(i) == 2)
		{
			new veh = GetPlayerVehicleID(i), str1[128];
			if(!IsBicycle(veh) && !IsFly(veh) && !IsBoat(veh))
			{
				switch(GetPlayerVehicleSpeed(i))
				{
					case 0..1: PlayerTextDrawSetString(i, Textdraw[3][i], "~w~~h~I");
					case 2..10: PlayerTextDrawSetString(i, Textdraw[3][i], "~w~~h~I");
					case 11..20: PlayerTextDrawSetString(i, Textdraw[3][i], "~w~~h~II");
					case 21..30: PlayerTextDrawSetString(i, Textdraw[3][i], "~g~IIII");
					case 31..40: PlayerTextDrawSetString(i, Textdraw[3][i], "~g~IIIIII");
					case 41..50: PlayerTextDrawSetString(i, Textdraw[3][i], "~g~~h~IIIIIIII");
					case 51..60: PlayerTextDrawSetString(i, Textdraw[3][i], "~y~~h~IIIIIIIIII");
					case 61..70: PlayerTextDrawSetString(i, Textdraw[3][i], "~y~~h~IIIIIIIIIIII");
					case 71..80: PlayerTextDrawSetString(i, Textdraw[3][i], "~y~~h~IIIIIIIIIIIII");
					case 81..90: PlayerTextDrawSetString(i, Textdraw[3][i], "~r~~h~~h~IIIIIIIIIIIIII");
					case 91..101: PlayerTextDrawSetString(i, Textdraw[3][i], "~r~~h~~h~IIIIIIIIIIIIIII");
					default: PlayerTextDrawSetString(i, Textdraw[3][i], "~r~~h~~h~IIIIIIIIIIIIIII");
				}
				format(str1, sizeof(str1), "(%d km/h)", GetPlayerVehicleSpeed(i));
				PlayerTextDrawSetString(i, Textdraw[7][i], str1);
				PlayerTextDrawSetPreviewModel(i, Textdraw[10][i], GetVehicleModel(GetPlayerVehicleID(i)));
			}
		}
		if(GetPVarInt(i, "kickotkat") > 0) { SetPVarInt(i, "kickotkat", GetPVarInt(i, "kickotkat")-1); SetPVarInt(i, "kc", 0); }
		if(GetPVarInt(i, "warnotkat") > 0) { SetPVarInt(i, "warnotkat", GetPVarInt(i, "warnotkat")-1); SetPVarInt(i, "wc", 0); }
		if(GetPVarInt(i, "banotkat") > 0)  { SetPVarInt(i, "banotkat", GetPVarInt(i, "banotkat")-1); SetPVarInt(i, "bc", 0); }
		if(PlayerInfo[i][pFMuteTime] > 0)  PlayerInfo[i][pFMuteTime] --;
		if(GetPVarInt(i,"alo") > 0) SetPVarInt(i,"alo",GetPVarInt(i,"alo")-1);
		if(aad > 0)  aad --;
		if(GetPVarInt(i,"are") > 0) SetPVarInt(i,"are",GetPVarInt(i,"are")-1);
		if(newsa[i] > 0) newsa[i] --;
		if(ainvite[i] > 0) ainvite[i] --;
		if(PlayerInfo[i][pMuteTime] == 0 && mute[i] == true) { mute[i] = false; SendClientMessage(i,-1,"{FFFFFF}��� ���� ��� {1373B8}����{FFFFFF}!"); }
		if(PlayerInfo[i][pFMuteTime] == 0 && fmute[i] == true) { fmute[i] = false; SendClientMessage(i,-1,"{FFFFFF}��� ������������ ���� ��� {1373B8}����{FFFFFF}!"); }
		if(PlayerInfo[i][pJailTime] == 0 && PlayerInfo[i][pJailed] > 0)
		{
			SetPlayerInterior(i, 6);
			ServerSetPlayerPos(i,246.40036010742,71.318893432617,1003.640625);
			SetPlayerVirtualWorld(i,0);
			if(PlayerInfo[i][pJailed] == 1) SetPVarInt(i, "otkatkpz", 120);
			PlayerInfo[i][pJailed] = 0;
			SendClientMessage(i,-1,"{FFFFFF}�� {1373B8}��������{FFFFFF}! ������������ ���� {1373B8}�������{FFFFFF} �����������!");
			PlayerTextDrawHide(i, TimeJail[i]);
		}
		if(GetPVarInt(i, "otkatkpz") > 0) SetPVarInt(i, "otkatkpz", GetPVarInt(i, "otkatkpz")-1);
		if(spec[i] == true)
		{
			new specp[512],string[256],Float:health,Float:armour;
			GetPlayerHealth(idspec[i],health);
			GetPlayerArmour(idspec[i],armour);
			format(specp,sizeof(specp),"~n~~n~~n~~n~~n~~n~~y~Weapons: ~w~%s",GetPlayerWeaponsInfo(idspec[i]));
			GameTextForPlayer(i,specp,1200,3);
			format(string,sizeof(string),"{D97511}���:{13A39C}\t%s[%d] | {D97511}�������:{13A39C}\t%d | {D97511}�����:{13A39C}\t%0.1f | {D97511}�����:{13A39C}\t %0.1f | {D97511}�����:{13A39C}\t %d",PlayerInfo[idspec[i]][pName],idspec[i],PlayerInfo[idspec[i]][pLevel],health,armour,PlayerInfo[idspec[i]][pWarn]);
			UpdatePlayer3DTextLabelText(i,playertextid23,-1,string);
			if(!IsPlayerInAnyVehicle(idspec[i])) PlayerSpectatePlayer(i, idspec[i]);
			else PlayerSpectateVehicle(i, GetPlayerVehicleID(idspec[i]));
		}
		if(PlayerOnJob[i] && !PlayerStartJob[i] && !IsPlayerInAnyVehicle(i) && PlayerInfo[i][pJob] == 5)
		{
			if(IsPlayerInRangeOfPoint(i, 1, -1854.7035,-1650.9668,25.7248)
			|| IsPlayerInRangeOfPoint(i, 1, -1803.5344,-1655.2640,25.8294)
			|| IsPlayerInRangeOfPoint(i, 1, -1788.5780,-1640.7179,27.0669))
			{
				SendClientMessage(i, -1, "�� ������ �������� ������.");
				SetTimerEx("TimerGiveMiner", 5000, false, "i", i);
				ApplyAnimationEx(i, "SWORD", "sword_4",4.1, 1, 0, 0, 0, 0);
				PlayerStartJob[i] = true;
			}
		}
		if(PlayerStartJob[i])
		{
			if(IsPlayerApplyAnimation(i, "FALL_back")
			|| IsPlayerApplyAnimation(i, "FALL_collapse")
			|| IsPlayerApplyAnimation(i, "FALL_fall")
			|| IsPlayerApplyAnimation(i, "FALL_front")
			|| IsPlayerApplyAnimation(i, "FALL_glide")
			|| IsPlayerApplyAnimation(i, "FALL_land")
			|| IsPlayerApplyAnimation(i, "FALL_skyDive")
			|| IsPlayerApplyAnimation(i, "JUMP_glide")
			|| IsPlayerApplyAnimation(i, "JUMP_land")
			|| IsPlayerApplyAnimation(i, "JUMP_launch")
			|| IsPlayerApplyAnimation(i, "JUMP_launch_R"))
			{
				if(!IsPlayerInRangeOfPoint(i, 3, -1854.7035,-1650.9668,25.7248)
				&& !IsPlayerInRangeOfPoint(i, 3, -1803.5344,-1655.2640,25.8294)
				&& !IsPlayerInRangeOfPoint(i, 3, -1788.5780,-1640.7179,27.0669)
				&& !IsPlayerInRangeOfPoint(i, 3, -1869.1316,-1634.7915,-58.500)
				&& !IsPlayerInRangeOfPoint(i, 3, -1868.9603,-1643.6682,-58.046))
				{
					SendClientMessage(i, -1, "�� ������� ������.");
					DisablePlayerCheckpoint(i);
					ApplyAnimationEx(i, "CARRY", "crry_prtial",4.1, 0, 0, 0, 0, 1);
					PlayerStartJob[i] = false;
					RemovePlayerAttachedObject(i, 6);
					SetPlayerAttachedObject(i, 6, 18634, 6, 0.078222, 0.000000, 0.110844, 298.897308, 264.126861, 193.350555, 1.000000, 1.000000, 1.000000);
					GetPlayerMetall[i] = 0;
					GetPlayerMetallEx[i] = 0;
				}
			}
		}
		if(PlayerInfo[i][pJob] == 7)
		{
			if(IsPlayerInRangeOfPoint(i,2.0,244.4696,-180.2649,13.6859) && delaet[i] == true)
			{
				RemovePlayerAttachedObject(i,5);
				ApplyAnimation(i,"PED","IDLE_tired",4.1,0,1,1,0,1);
				ammobox[i]++;
				new string[128];
				format(string,sizeof(string),"{FFFFFF} �� ������� ������� {3CBBF7}%s{FFFFFF} � ���������",nformat(ammobox[i],"�������","�������","�������"));
				SendClientMessage(i,COLOR_WHITE,string);
				delaet[i] = false;
				Infa[iiPatron] ++;
			}
			else if(IsPlayerInRangeOfPoint(i, 1.0,249.1263,-174.7928,13.6859) || IsPlayerInRangeOfPoint(i, 1.0, 246.3768,-174.6950,13.6859) || IsPlayerInRangeOfPoint(i, 1.0, 243.5233,-174.6834,13.6859))
			{
				if(delaet[i] != true)
				{
					delaet[i] = true;
					Freeze(i);
					ApplyAnimationEx(i, "BUDDY", "buddy_reload", 4.1, 1, 1, 1, 1, 0);
					SetPlayerAttachedObject(i,5,18644,14,0.401943,0.011442,0.010348,106.050292,330.509094,3.293162,1.000000,1.000000,1.000000);
					SetTimerEx("GunJob", 5000, false, "i", i);
				}
			}
		}
		new Float:health;
		GetPlayerHealth(i,health);
		if (health < 10.0) {  korach[i] = true; ApplyAnimationEx(i, "CRACK", "crckdeth2",4.1, 1, 0, 0, 0, 0);  RemovePlayerFromVehicle(i); }
		if (health > 10.0 && korach[i] == true) { korach[i] = false; ClearAnimations(i); }
		AntiCheat(i);
/*		for(new r = 1; r < sizeof(Radar); r++)
		{
			if(IsPlayerInRangeOfPoint(i, 100.0,Radar[r][rX],Radar[r][rY],Radar[r][rZ]) && PlayerInfo[i][pGPS] == true && GetPlayerState(i) == 2 && warning[i] == false)
			{
				if(Radar[r][rType] == false && GetPlayerSpeed(i) > 110) SendClientMessage(i,-1,"{F31212}[��������]{FFFFFF} �� ���������� ���������� � ��������� ��������! ������� ��������!");
				else if(Radar[r][rType] == true && GetPlayerSpeed(i) > 170) SendClientMessage(i,-1,"{F31212}[��������]{FFFFFF} �� ���������� ���������� � ��������� ��������! ������� ��������!");
				warning[i] = true;
				SetTimerEx("WarningOff",3000,false,"i",i);
			}
			if(IsPlayerInRangeOfPoint(i, 45.0,Radar[r][rX]+2,Radar[r][rY]+2,Radar[r][rZ]) && penaltyo[i] == false && !IsFly(GetPlayerVehicleID(i)) && GetPlayerState(i) == 2 && PlayerInfo[i][pOTR] == false)
			{
				if(Radar[r][rType] == false && GetPlayerSpeed(i) > 110)
				{
					new string[130];
					new speed = GetPlayerSpeed(i);
					new summa = speed-110;
					format(string,sizeof(string),"����������: %d",summa);
					PlayerTextDrawSetString(i,Speeding[i],string);
					format(string,sizeof(string),"�����: %d$",summa*100);
					TextDrawSetString(Penalty[i],string);
					TextDrawShowForPlayer(i,Speeding[i]);
					TextDrawShowForPlayer(i,Traffic[i]);
					TextDrawShowForPlayer(i,Penalty[i]);
					SetTimerEx("PenaltyOff",10000,false,"i",i);
					PlayerInfo[i][pTakeMoney] += summa*100;
					penaltyo[i] = true;
                    SendClientMessage(i, -1, ""GRN"��� ���������� �������� ����� �� ��������� ��������, ����� �� ������ �������� � ������");
                    SendClientMessage(i, -1, ""GRN"�������� ��� �� ������� � ����� ���������.");
				}
				else if(Radar[r][rType] == true && GetPlayerSpeed(i) > 170)
				{
					new string[128];
					new speed = GetPlayerSpeed(i);
					new summa = speed-170;
					format(string,sizeof(string),"����������: %d",summa);
					TextDrawSetString(Speeding[i],string);
					format(string,sizeof(string),"�����: %d",summa*100);
					TextDrawSetString(Penalty[i],string);
					TextDrawShowForPlayer(i,Speeding[i]);
					TextDrawShowForPlayer(i,Traffic[i]);
					TextDrawShowForPlayer(i,Penalty[i]);
					SetTimerEx("PenaltyOff",10000,false,"i",i);
					PlayerInfo[i][pTakeMoney] += summa*100;
					penaltyo[i] = true;
					SendClientMessage(i, -1, ""GRN"��� ���������� �������� ����� �� ��������� ��������, ����� �� ������ �������� � ������");
					SendClientMessage(i, -1, ""GRN"�������� ��� �� ������� � ����� ���������.");
				}
			}
		}*/
		new tttgtg;
		new strr1[256];
		tttgtg = GetPlayerAmmo(SpecAd[i]);
		new Float:hppp;
		new Float:aermor;
		GetPlayerArmour(SpecAd[i],aermor);
		GetPlayerHealth(SpecAd[i],hppp);
		new fps = 40 + random(60);
		if(PlayerInfo[i][pAdmin] != 0)
		{
			if(IsPlayerInAnyVehicle(SpecAd[i]))
			{
				new Float:health1;
				new playersip[20];
				GetPlayerIp(SpecAd[i],playersip,sizeof(playersip));
				GetVehicleHealth(GetPlayerVehicleID(SpecAd[i]),health1);
				format(strr1, sizeof(strr1),"~g~%s %i~n~~n~~w~IP: %s~n~~n~Ping: %i~n~~r~Speed: ~w~%i~n~~g~Armour: ~w~%.0f~n~~g~Health: ~w~%.0f~n~Warns: %i~n~~b~Ammo: ~w~%i~n~~n~~g~$ ~w~Cash: ~g~%i~n~~g~$ ~w~Bank: ~g~%i~n~~n~~r~Scan FPS: %i~n~Car HP: %.0f",PlayerInfo[SpecAd[i]][pName],SpecAd[i],playersip,GetPlayerPing(SpecAd[i]),GetPlayerVehicleSpeed(SpecAd[i]),aermor,hppp,PlayerInfo[SpecAd[i]][pWarn],tttgtg,PlayerInfo[SpecAd[i]][pMoney],PlayerInfo[SpecAd[i]][pBank],fps,health1);
				PlayerTextDrawSetString(i,FULLRECON[i],strr1);
			}
			if(!IsPlayerInAnyVehicle(SpecAd[i]))
			{
				new playersip[20];
				GetPlayerIp(SpecAd[i],playersip,sizeof(playersip));
				format(strr1, sizeof(strr1),"~g~%s %i~n~~n~~w~IP: %s~n~~n~Ping: %i~n~~r~Speed: ~w~%i~n~~g~Armour: ~w~%.0f~n~~g~Health: ~w~%.0f~n~Warns: %i~n~~b~Ammo: ~w~%i~n~~n~~g~$ ~w~Cash: ~g~%i~n~~g~$ ~w~Bank: ~g~%i~n~~n~~r~Scan FPS: %i",PlayerInfo[SpecAd[i]][pName],SpecAd[i],playersip,GetPlayerPing(SpecAd[i]),GetPlayerVehicleSpeed(SpecAd[i]),aermor,hppp,PlayerInfo[SpecAd[i]][pWarn],tttgtg,PlayerInfo[SpecAd[i]][pMoney],PlayerInfo[SpecAd[i]][pBank],fps);
				PlayerTextDrawSetString(i,FULLRECON[i],strr1);
			}
		}
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER) {
	        for(new s = 0; s < sizeof(SpikeInfo); s++)  {
	  	        if(IsPlayerInRangeOfPoint(i, 3.0, SpikeInfo[s][sX], SpikeInfo[s][sY], SpikeInfo[s][sZ]))  {
	  	            if(SpikeInfo[s][sCreated] == 1)  {
	  	                new panels, doors, lights, tires;
	  	                new carid = GetPlayerVehicleID(i);
			            GetVehicleDamageStatus(carid, panels, doors, lights, tires);
			            tires = encode_tires(1, 1, 1, 1);
			            UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
	  	                return 0;
	  	            }
	  	        }
	  	    }
	  	}
	}
	return true;
}
stock GetPlayerMember(playerid)
{
    new fraction;
	if(PlayerInfo[playerid][pLeader] !=0) fraction = PlayerInfo[playerid][pLeader];
	else if(PlayerInfo[playerid][pZam] !=0) fraction = PlayerInfo[playerid][pZam];
    else if(PlayerInfo[playerid][pMember] !=0) fraction = PlayerInfo[playerid][pMember];
    return fraction;
}
stock GetPlayerRank(playerid) return PlayerInfo[playerid][pRank];
stock LoadFractionAuto()
{
    new count = GetTickCount();
	new result[32+64*7+100];
	mysql_query("SELECT * FROM `Fraction Auto` ORDER BY  `Fraction Auto`.`id` ASC");
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
		for (new idx = 1;idx <= mysql_num_rows();idx ++)
		{
			mysql_fetch_row(result);
			sscanf(result, "p<|>iiffffiiiii",
			AutoInfo[idx][aBaseid],
			AutoInfo[idx][aModel],
			AutoInfo[idx][aX],
			AutoInfo[idx][aY],
			AutoInfo[idx][aZ],
			AutoInfo[idx][aA],
			AutoInfo[idx][aColor1],
			AutoInfo[idx][aColor2],
			AutoInfo[idx][aRank],
			AutoInfo[idx][aFraction],
			AutoInfo[idx][aJob]);
			AutoInfo[idx][aID] = CreateVehicle(AutoInfo[idx][aModel],AutoInfo[idx][aX],AutoInfo[idx][aY],AutoInfo[idx][aZ],AutoInfo[idx][aA],AutoInfo[idx][aColor1],AutoInfo[idx][aColor2],600);
		}
	}
	mysql_free_result();
	printf("�������� ����������� ���� ������ ��: %d ��", GetTickCount()-count);
	return true;
}
stock LoadStreet()
{
    new count = GetTickCount();
	new result[32+64*7+100];
	mysql_query("SELECT * FROM `Street` ORDER BY  `Street`.`id` ASC");
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
		for (new idx = 1;idx <= mysql_num_rows();idx ++)
		{
		    mysql_fetch_row(result);
		    sscanf(result, "p<|>iffffi",
			Street[idx][stID],
		    Street[idx][stX],
		    Street[idx][stY],
		    Street[idx][stZ],
		    Street[idx][stA],
		    Street[idx][stModel]);
			CreateVehicle(Street[idx][stModel],Street[idx][stX],Street[idx][stY],Street[idx][stZ],Street[idx][stA],-1,-1,600);
		}
	}
	mysql_free_result();
	printf("�������� ����� �� ����� ������ ��: %d ��", GetTickCount()-count);
	return true;
}
stock LoadFractions()
{
	new count = GetTickCount();
	new result[32+64*7+100];
	mysql_query("SELECT * FROM `Fractions` ORDER BY  `Fractions`.`id` ASC");
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
		for (new i = 1;i <= mysql_num_rows();i ++)
		{
			mysql_fetch_row(result);
			sscanf(result, "p<|>iiiiiiiis[32]fffs[64]s[64]s[64]s[64]s[64]s[64]s[64]ifffiiiiiiiiiiiiiiiiiii",
			Fraction[i][fID],
			Fraction[i][fInt],
			Fraction[i][fSkin1],
			Fraction[i][fSkin2],
			Fraction[i][fSkin3],
			Fraction[i][fSkin4],
			Fraction[i][fSkin5],
			Fraction[i][fSkin6],
			Fraction[i][fName],
			Fraction[i][ffX],
			Fraction[i][ffY],
			Fraction[i][ffZ],
			Fraction[i][fLeader],
			Fraction[i][fRank1],
			Fraction[i][fRank2],
			Fraction[i][fRank3],
			Fraction[i][fRank4],
			Fraction[i][fRank5],
			Fraction[i][fRank6],
			Fraction[i][fVW],
			Fraction[i][fBX],
			Fraction[i][fBY],
			Fraction[i][fBZ],
			Fraction[i][fMats],
			Fraction[i][fDrugs],
			Fraction[i][fMoney],
			Fraction[i][fZamRank],
			Fraction[i][fZamKick],
			Fraction[i][fZamInvite],
			Fraction[i][fZamMute],
			Fraction[i][fZamUnMute],
			Fraction[i][fZamVyg],
			Fraction[i][fZamUnVyg],
			Fraction[i][fZamUn],
			Fraction[i][fBallas],
			Fraction[i][fGroove],
			Fraction[i][fCoronos],
			Fraction[i][fVagos],
			Fraction[i][fCvet],
			Fraction[i][fPistol],
			Fraction[i][fAvtomat],
			Fraction[i][fXolod]);
			if(Fraction[i][fID] == 6 || Fraction[i][fID] == 7 || Fraction[i][fID] == 8 || Fraction[i][fID] == 10) CreatePickupWithText(1274, 1, 0xFFFFFFFF, Fraction[i][fBX], Fraction[i][fBY], Fraction[i][fBZ], "", Fraction[i][fVW],1);
		}
	}
	mysql_free_result();
	printf("�������� ������� ������ ��: %d ��", GetTickCount()-count);
	return true;
}
LoadBankomats()
{
	new count = GetTickCount();
	new result[32+64*7+100];
	mysql_query("SELECT * FROM `Bankomats` ORDER BY  `Bankomats`.`ID` ASC");
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
		for (new idx = 1;idx <= mysql_num_rows();idx ++)
		{
			mysql_fetch_row(result);
			sscanf(result, "p<|>iffffff",
			Bankomat[idx][bID],
			Bankomat[idx][bX],
			Bankomat[idx][bY],
			Bankomat[idx][bZ],
			Bankomat[idx][brX],
			Bankomat[idx][brY],
			Bankomat[idx][brZ]);
			CreateDynamicObject(2754,Bankomat[idx][bX],Bankomat[idx][bY],Bankomat[idx][bZ],Bankomat[idx][brX],Bankomat[idx][brY],Bankomat[idx][brZ]);
			CreateDynamicMapIcon(Bankomat[idx][bX], Bankomat[idx][bY], Bankomat[idx][bZ], 52, COLOR_WHITE, 0, -1, -1, 400.0);
			Bankomat[idx][bCheckpoint] = CreateDynamicCP(Bankomat[idx][bX]-1,Bankomat[idx][bY],Bankomat[idx][bZ], 1.0, 0, 0, -1, 15.0);
		}
	}
	mysql_free_result();
	printf("�������� ���������� ������ ��: %d ��", GetTickCount()-count);
	return true;
}
stock GetVehicleId(vehicleid)
{
    for(new i; i < MAX_FRACTION_CARS; i++) { 
		if(AutoInfo[i][aID] == vehicleid) return i; 
	}	
	return -1;
}
stock GetPlayerData(playerid,type)
{
    switch(type)
    {
        case 0: return CallRemoteFunction("GetPlayerMember","i",playerid);
        case 1: return CallRemoteFunction("GetPlayerLeader","i",playerid);
        case 2: return CallRemoteFunction("GetPlayerRank","i",playerid);
    }
    return true;
}
stock SendHelperMessage(color,const string[])
{
	foreach(Player,i)
	{
		if(PlayerInfo[i][pLogged] == true)
		{
			if(PlayerInfo[i][pHelper] > 0) SendClientMessage(i,color,string);
		}
	}
}
stock SendAdminMessage(color,const string[],level)
{
	foreach(Player,i)
	{
		if(IsPlayerConnected(i))
		{
			if (PlayerInfo[i][pAdmin] >= level) SendClientMessage(i, color, string);
		}
	}
	return true;
}
stock SendAMessage(color,const string[])
{
	foreach(Player,i)
	{
		if(PlayerInfo[i][pLogged] == true)
		{
			if(PlayerInfo[i][pAdmin] > 0 || PlayerInfo[i][pHelper] > 0) SendClientMessage(i,color,string);
		}
	}
}

stock SendFractionMessage(color,const string[],fam)
{
	foreach(Player,i)
	{
		if(IsPlayerConnected(i))
		{
			if (PlayerInfo[i][pLeader] == fam || PlayerInfo[i][pMember] == fam || GetPVarInt(i,"idfraction") == fam)
			{
				if(togf[i] == false) SendClientMessage(i, color, string);
			}
		}
	}
	return true;
}
stock SendAPMMessage(color,const string[])
{
	foreach(Player,i)
	{
		if(IsPlayerConnected(i))
		{
			if (apm[i] == true) SendClientMessage(i, color, string);
		}
	}
	return true;
}
stock SendOOC(color,const string[])
{
	foreach(Player,i)
	{
		if(IsPlayerConnected(i))
		{
			if(togoo[i] == false) SendClientMessage(i, color, string);
		}
	}
	return true;
}
stock SendJobMessage(color,const string[],job)
{
	foreach(Player,i)
	{
		if(PlayerInfo[i][pLogged] == true)
		{
			if(PlayerInfo[i][pJob] == job) SendClientMessage(i, color, string);
		}
	}
	return true;
}
stock SendCopsMessage(color,const string[])
{
	foreach(Player,i)
	{
		if(IsPlayerConnected(i))
		{
			if (IsACop(i)) SendClientMessage(i, color, string);
		}
	}
	return true;
}
stock SendDeportMessage(color,const string[])
{
	foreach(Player,i)
	{
		if(IsPlayerConnected(i))
		{
			if (IsACop(i) || GetPlayerMember(i) == 4) SendClientMessage(i, color, string);
		}
	}
	return true;
}
stock SendRadiusMessage(Float:radius, playerid, string[], color1)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		foreach(Player,i)
		{
			if(IsPlayerConnected(i))
			{
				if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
				{
					if(IsPlayerInRangeOfPoint(i,radius,oldposx, oldposy, oldposz)) SendClientMessage(i,color1,string);
				}
			}
		}
	}
	return true;
}
SendMuteMessage(playerid) {
	new string[128];
	if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pMuteTime]) {
		format(string,sizeof(string),"{F31212}[������]{FFFFFF} � ��� ��� ����. ���������� �����: {13761C}%d",PlayerInfo[playerid][pMuteTime]), SendClientMessage(playerid, -1, string);
	}
	return true;
}
stock PayDay(i)
{
	new string[128];
	PlayerInfo[i][pExp] ++;
	if(PlayerInfo[i][pExp] >= PlayerInfo[i][pExpNext]) {
		PlayerInfo[i][pLevel] ++;
		PlayerInfo[i][pExp] -= PlayerInfo[i][pExpNext];
		PlayerInfo[i][pExpNext] += 3 ;
		SetMoney(i, PlayerInfo[i][pLevel]*1000);
		format(string,sizeof(string),"~w~LvL: ~y~%d  ~w~Exp: ~y~%d~w~/~y~%d",PlayerInfo[i][pLevel],PlayerInfo[i][pExp],PlayerInfo[i][pExpNext]);
		PlayerTextDrawSetString(i,lvlexp[i], string);
		format(string, sizeof(string), ""PURP"�� ���� �� ������� �� �������� ����� � ������� %d$", PlayerInfo[i][pLevel]*1000);
		SendClientMessage(i, -1, string);
	}
	new fam = GetPlayerMember(i);
	switch(PlayerInfo[i][pRank])
	{
		case 1: SetPVarInt(i,"zp",100);
		case 2: SetPVarInt(i,"zp",200);
		case 3: SetPVarInt(i,"zp",400);
		case 4: SetPVarInt(i,"zp",600);
		case 5: SetPVarInt(i,"zp",800);
		case 6: SetPVarInt(i,"zp",1000);
	}
 	if(PlayerInfo[i][pWanted] > 0)
	{
		PlayerInfo[i][pWanted] --;
		SetPlayerWantedLevel(i,PlayerInfo[i][pWanted]);
		SendClientMessage(i,-1,"{FFFFFF}���� ������ �������� �� {DAD36B}����{FFFFFF} ������!");
	}
	if(fam == 5 || fam == 1 || fam == 2 || fam == 3 || fam == 4 || fam == 15)
	{
		format(string,sizeof(string),"�� �������� �������� � ������� {147130}%d${FFFFFF}",GetPVarInt(i,"zp"));
		SendClientMessage(i,-1,string);
		return true;
	}
	format(string,sizeof(string),"�� �������� �������� � �������: {147130}%d${FFFFFF}",PlayerInfo[i][pZP]);
	SendClientMessage(i,-1,string);
	format(string,sizeof(string),"����� � �����: {147130}%d${FFFFFF}",PlayerInfo[i][pBank]);
	SendClientMessage(i,-1,string);
	PlayerInfo[i][pZP] += GetPVarInt(i,"zp");
	SetMoney(i,PlayerInfo[i][pZP]);
	PlayerInfo[i][pZP] = 0;
	PlayerInfo[i][pGameTime] = 0;
	SaveAccount(i);
	format(string,sizeof(string),"~w~LvL: ~y~%d  ~w~Exp: ~y~%d~w~/~y~%d",PlayerInfo[i][pLevel],PlayerInfo[i][pExp],PlayerInfo[i][pExpNext]);
	PlayerTextDrawSetString(i,lvlexp[i], string);
	new id = ReturnUser(PlayerInfo[i][pPriglasil]);
	if(PlayerInfo[i][pInvite] == false && PlayerInfo[i][pPriglasil] != 0 && PlayerInfo[i][pLevel] >= 3 && IsPlayerConnected(id) && PlayerInfo[id][pLogged] == true) {
		SetMoney(id,300000);
		SendClientMessage(id,COLOR_LIGHTBLUE,"�� ���������� �� ������ ������ � �������� �� ��� 300000");
		PlayerInfo[i][pInvite] = true;
	}
	SetPlayerScore(i,PlayerInfo[i][pLevel]);
	return true;
}
forward UpdateTime();
public UpdateTime()
{
	new timestr[32],hour, minute;
	gettime(hour, minute);
	format(timestr,sizeof(timestr),"~w~%02d~y~:~w~%02d",hour,minute);
	foreach(new i: Player) {
		PlayerTextDrawSetString(i,Time[i],timestr);
	}
	if(minute == 00) {
		foreach(new i: Player) {
			PayDay(i);
			SendClientMessage(i, C_BLUE, "����� ��� ������ �������� �������! ������ ����� ���������� � ��������� 24/7");
		}
		return true;
	}
	if(minute == 02) {
		foreach(new i: Player) {
			GoLotto(i);
		}
	}
	switch(hour)
	{
		case 21..23: SetWeather(17);
		case 1..5: SetWeather(17);
		default: SetWeather(5);
	}
	if(minute == 15 || minute == 30 || minute == 45)
	{
		SendClientMessageToAll(-1,"�� ������� �� ������� "YE"Alpino RPG");
		SendClientMessageToAll(-1,"��� ������ �� ������ ��������� "YE"/re [ID ����������] [������].{FFFFFF} � ���� �� ������ ������ ������, ��������� ������� "YE"/vopros{FFFFFF}");
		SendClientMessageToAll(-1,"����� ������� - "YE"alpino-rpg.ru{FFFFFF} ������������ ����������� ������������ � ��������� �������!");
		SendClientMessageToAll(-1,"������� ���� �� �������� "YE"Alpino GS{FFFFFF}");
	}
	foreach(Player,i)
	{
		PlayerInfo[i][pGameTime] ++;
		if(passanger[i] != -1) { moneyzaproezd[passanger[i]] += proezd[passanger[i]]; SendClientMessage(i,COLOR_LIGHTBLUE,"�� �������� ��� ������ � ����� � ��������� �� ������!"); }
	}
	if(minute == 20 || minute == 50) {
		switch(racen) {
			case 0:  {
				Race[1][Reg] = true;
				SendClientMessageToAll(-1, ""YE"������� ����������� �� ����� � 1. ����������� /locateme, ����� ����� ����� �����������");
				SetTimerEx("CloseReg", 120000, false, "i", 1);
				return true;
			}
			case 1:  {
				Race[2][Reg] = true;
				SendClientMessageToAll(-1, ""YE"������� ����������� �� ����� � 2. ����������� /locateme, ����� ����� ����� �����������");
				SetTimerEx("CloseReg", 120000, false, "i", 2);
				return true;
			}
		}	
	}
	if(minute == 15 || minute == 45) {
		racen = random(2);
		switch(racen) {
			case 0: SendClientMessageToAll(-1, ""YE"����� 5 ����� �������� ����������� �� ����� � 1. ����������� /locateme, ����� ����� ����� �����������");
			case 1: SendClientMessageToAll(-1, ""YE"����� 5 ����� �������� ����������� �� ����� � 2. ����������� /locateme, ����� ����� ����� �����������");
		}
		Race[racen][Locate] = true;
	}	
	return true;
}
forward CloseReg(i);
public CloseReg(i) {
	if(Race[i][CountM] == 0 && Race[i][Start] == false) {
		Race[i][Reg] = false;
		Race[i][TimerP] = false;
		Race[i][CountM] = 0;
		Race[i][Max] = 0;
		Race[i][Locate] = false;
		SendClientMessageToAll(-1, ""YE"����������� �� ����� ������� ��-�� �������������� ���������� ����������!");
		return true;
	}
	return true;
}	
forward Gmtest(playerid);
public Gmtest(playerid)
{
    new string[512], Float:nowhealth;
    if(GetPVarInt(GetPVarInt(playerid,"AdmGMID"), "AdmGM") == 1)  GetPlayerHealth(GetPVarInt(playerid,"AdmGMID"),nowhealth);
	SetPVarFloat(GetPVarInt(playerid,"AdmGMID"), "nowhealth", nowhealth);
	new title[100];
	format(title, sizeof(title), ""WHT"GMCheck: "YE"%s", PlayerInfo[GetPVarInt(playerid,"AdmGMID")][pName]);
    if((GetPVarFloat(GetPVarInt(playerid,"AdmGMID"),"ahp")-GetPVarFloat(GetPVarInt(playerid,"AdmGMID"), "nowhealth")) > 0) {
        format(string, sizeof(string), ""PURP"��:"LRED" \t\t\t\t%.0f.0 "WHT"HP\n"PURP"�����:"LRED" \t\t\t\t%.0f.0"WHT" HP\nHP ����������� ��: \t\t"LRED"%.0f.0"WHT"\n\n{7FB151}�� �� ����������. HP ������ �������������.",GetPVarFloat(GetPVarInt(playerid,"AdmGMID"),"ahp"),GetPVarFloat(GetPVarInt(playerid,"AdmGMID"), "nowhealth"),(GetPVarFloat(GetPVarInt(playerid,"AdmGMID"),"ahp")-GetPVarFloat(GetPVarInt(playerid,"AdmGMID"), "nowhealth")));
        SPD(playerid, 999,DIALOG_STYLE_MSGBOX , title, string, "�������", "");
        ServerSetPlayerHealth(GetPVarInt(playerid,"AdmGMID"), GetPVarFloat(GetPVarInt(playerid,"AdmGMID"),"ahp"));
        ServerSetPlayerArmour(GetPVarInt(playerid,"AdmGMID"), GetPVarFloat(GetPVarInt(playerid,"AdmGMID"),"Armour"));
	}
	else if((GetPVarFloat(GetPVarInt(playerid,"AdmGMID"),"ahp")-GetPVarFloat(GetPVarInt(playerid,"AdmGMID"), "nowhealth")) == 0) {
        format(string, sizeof(string), ""PURP"��: \t\t"LRED"%.0f.0"WHT" HP\n"PURP"�����: \t\t"LRED"%.0f.0"WHT" HP\nHP �� �����������\n\n{CD5A5A}�������� ���� ����� ���������� ��.",GetPVarFloat(GetPVarInt(playerid,"AdmGMID"),"ahp"),GetPVarFloat(GetPVarInt(playerid,"AdmGMID"), "nowhealth"));
        SPD(playerid,999,DIALOG_STYLE_MSGBOX,title,string, "�������", "");
    }
	DeletePVar(GetPVarInt(playerid,"AdmGMID"), "ahp");
	DeletePVar(GetPVarInt(playerid,"AdmGMID"), "AdmGM");
	DeletePVar(playerid, "AdmGMID");
	DeletePVar(GetPVarInt(playerid,"AdmGMID"), "Armour");
	KillTimer(GMTimer[playerid]);
}
//================[CMD]=========================================================
CMD:time(playerid, params[])  { 
    SetPVarInt(playerid, "TimeUse", 1);
	ShowTime(playerid);
    return true; 
}  
CMD:togo(playerid, params[]) {
	if(togoo[playerid] == false) { togoo[playerid] = true; SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� ����� ��������� � ����� ����"); }
	else { togoo[playerid] = false; SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� ����� ��������� � ����� ����"); }
	return true;
}
CMD:togf(playerid, params[]) {
	if(togf[playerid] == false) { togf[playerid] = true; SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� ����� ��������� � ����������� ����"); }
	else { togf[playerid] = false; SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� ����� ��������� � ����������� ����"); }
	return true;
}	
CMD:smoke(playerid, params[] ) {
	if(PlayerInfo[playerid][pSmoke] == 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ��� ��� �������!");
	new Float:health;
	GetPlayerHealth(playerid, health);
	if(health >= 100) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ��� ������������ ���-�� ������!");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
	PlayerInfo[playerid][pSmoke] --;
	new string[128];
	format(string, sizeof(string), "%s �������� �������� � �������� ������", PlayerInfo[playerid][pName]);
	SendRadiusMessage(20.0, playerid, string, COLOR_PURPLE);
	SetPVarInt(playerid, "smoke", 1);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "��������� ������ �����, ����� ������ ������");
	return true;
}	
CMD:locateme(playerid, params[]) {
	if(Race[1][Reg] == false && Race[2][Reg] == false && Race[1][Locate] == false && Race[2][Locate] == false) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����������� �� ����� �� �������!");
	switch(racen) {
		case 0: { SetPlayerCheckpoint(playerid, 1329.1636,-984.6364,33.8966, 5.0); SetPVarInt(playerid, "locate", 1); }
		case 1: { SetPlayerCheckpoint(playerid, 1547.9402,29.9336,24.1406, 5.0); SetPVarInt(playerid, "locate", 1); }
	}
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "����� ����������� �������� ������� �������� �� �����");
	return true;
}
CMD:talk(playerid, params[]) {
	if(IsPlayerInRangeOfPoint(playerid, 3.0, -1987.4482,140.5048,27.5391)) SPD(playerid, DIALOG_QUEST, DIALOG_STYLE_MSGBOX, ""PREFIX" ������",""YE"� ���� ��� ���� ���� ��������� �������\n������ �� ���������?", "��", "���");
	else SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} �� �� ����� � ���������!");
	return true;
}
CMD:gm(playerid, params[]) {
    if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
    if(sscanf(params, "u", params[0])) return SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} /gm [ID ������]");
    if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(IsPlayerInAnyVehicle(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����� � ������. �������� �� ��������");
    new Float:boom[3], Float:health, Float:armor;
    GetPlayerPos(params[0],boom[0], boom[1], boom[2]);
    GetPlayerHealth(params[0],health);
	SetPVarFloat(params[0], "ahp", health);
    SetPVarInt(params[0], "AdmGM", 1);
	SetPVarInt(playerid, "AdmGMID", params[0]);
    GetPlayerArmour(params[0], armor);
	SetPVarFloat(params[0], "Armour", armor);
    ServerSetPlayerArmour(params[0], 0);
    CreateExplosion(boom[0], boom[1], boom[2]+7.5, 5, 0.5);
	GMTimer[playerid] = SetTimerEx("Gmtest",1000,true,"d",playerid);
    return 1;
}
CMD:addbank(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] != 6) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	mysql_query("SELECT NULL FROM `Bankomats`");
	mysql_store_result();
	new query[512];
	new i = mysql_num_rows();
	mysql_free_result();
	GetPlayerPos(playerid,Bankomat[i+1][bX],Bankomat[i+1][bY],Bankomat[i+1][bZ]);
	GetPlayerFacingAngle(playerid,Bankomat[i+1][brZ]);
	Bankomat[i+1][bObject] = CreateDynamicObject(2754,Bankomat[i+1][bX]+2,Bankomat[i+1][bY],Bankomat[i+1][bZ],0,0,Bankomat[i+1][brZ]+90,-1,-1,-1,30.0);
	format(query,sizeof(query),"INSERT INTO `Bankomats` (ID, x, y, z, rX, rY, rZ) VALUES ('%i',%f,'%f','%f','%f','%f','%f')",i+1,Bankomat[i+1][bX],Bankomat[i+1][bY],Bankomat[i+1][bZ],0,0,Bankomat[i+1][brZ]+90);
	mysql_query(query);
	mysql_free_result();
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"�������� ������� ��������");
	EditDynamicObject(playerid, Bankomat[i+1][bObject]);
	SetPVarInt(playerid, "bankomat", i+1);
	return true;
}
CMD:showfc(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(GetPVarInt(playerid,"idfraction") == 0)
	{
		if(sscanf(params,"i",params[0]))return SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} /showfc [ID �������]");
		if(params[0] > 18 || params[0] < 1) return true;
		SetPVarInt(playerid,"idfraction",params[0]);
		new string[128];
		format(string,sizeof(string),"�� ���������� ����� ���� ������� %s (ID: %d)",Fraction[params[0]][fName],params[0]);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	}
	else
	{
		SetPVarInt(playerid,"idfraction",0);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� ����� ���� �������");
	}
	return true;
}
CMD:buyhouse(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		for(new h = 0; h < sizeof(HouseInfo); h++)
		{
			if(IsPlayerInRangeOfPoint(playerid,2.0, HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez]) && HouseInfo[h][hOwned] == false)
			{
				if(PlayerInfo[playerid][pHouse] > 0) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} � ��� ��� ���� ���!");
				if(PlayerInfo[playerid][pLevel] < HouseInfo[h][hLevel]) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} ��� ������� ������� ��� ��� ������� ����� ����!");
				if(GetMoney(playerid) < HouseInfo[h][hValue]) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} � ��� ��������� ����� �� ������� ����!");
				PlayerInfo[playerid][pHouse] = h;
				HouseInfo[h][hOwned] = true;
				strmid(HouseInfo[h][hOwner], PlayerInfo[playerid][pName], 0, strlen(PlayerInfo[playerid][pName]), 255);
				SetMoney(playerid,-HouseInfo[h][hValue]);
				SendClientMessage(playerid, COLOR_WHITE, "�����������! �� ������ ���.");
				UpdateHouseText(h);
				PlayerInfo[playerid][pSpawn] = 2;
				SaveHouse(h);
				SaveAccount(playerid);
				return true;
			}
		}
	}
	return true;
}
CMD:handsup(playerid, params[]) return SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
CMD:gro(playerid, params[]) return ApplyAnimationEx(playerid,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0);
CMD:drunk(playerid, params[]) return ApplyAnimationEx(playerid,"PED","WALK_DRUNK",4.0,1,1,1,1,0);
CMD:arrestanim(playerid, params[]) return ApplyAnimationEx(playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1);
CMD:stopanim(playerid, params[]) return ClearAnimations(playerid);
CMD:iznas(playerid, params[])
{
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} /iznas [ID ������]");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ �� ���!");
	if(params[0] == playerid) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ������������ ������ ����!");
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ������������ ������!");
	SendClientMessage(params[0],COLOR_LIGHTBLUE,"��� ������������!");
	ApplyAnimationEx(params[0],"SNM","SPANKINGW",4.1,0,1,1,1,1);
	ApplyAnimationEx(playerid,"SNM","SPANKEDW",4.1,0,1,1,1,1);
	return true;
}
CMD:sellhouse(playerid, params[])
{
	new house = PlayerInfo[playerid][pHouse];
	if(PlayerInfo[playerid][pHouse] == 0) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} � ��� ��� ����!");
	HouseInfo[house][hLock] = true;
	PlayerInfo[playerid][pHouse] = 0;
	HouseInfo[house][hOwned] = false;
	strmid(HouseInfo[house][hOwner], "The State", 0, strlen("The State"), 255);
	UpdateHouseText(house);
	SaveHouse(house);
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SendClientMessage(playerid,-1,"{FFFFFF}�� {147130}�������{FFFFFF} ������� ���� ���.");
	PlayerInfo[playerid][pSpawn] = 0;
	return true;
}
CMD:addhouse(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"i",params[0]))return SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} /addhouse [�������]");
	new Float:Px,Float:Py,Float:Pz;
	GetPlayerPos(playerid,Px,Py,Pz);
	SetPVarFloat(playerid,"PX",Px);
	SetPVarFloat(playerid,"PY",Py);
	SetPVarFloat(playerid,"PZ",Pz);
	SetPVarInt(playerid,"LevelHouse",params[0]);
	SetPlayerInterior(playerid,Interiors[0][iInt]);
	SetPlayerVirtualWorld(playerid,999);
	ServerSetPlayerPos(playerid,Interiors[0][iX], Interiors[0][iY], Interiors[0][iZ]);
	SendClientMessage(playerid,COLOR_LIGHTRED,""LRED"�� ������ ��������� ���!");
	SendClientMessage(playerid,COLOR_LIGHTRED,""LRED"����������� "GRN"NUM4"LRED" � "GRN"NUM6"LRED" ����� �������� ��������!");
	SendClientMessage(playerid,COLOR_LIGHTRED,""LRED"��� ������ �������� ����������, ������� "GRN"������"LRED"!");
	SetPVarInt(playerid,"vyborint",0);
	return true;
}

CMD:ban(playerid, params[])
{
	new date[64],ip[16],unbandate,str[500];
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ris[100]",params[0],params[1],params[2]))return SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} /ban [ID ������/���] [���-�� ����] [�������]");
	if(IsIP(params[2]) || CheckString(params[2]) || CheckMsg(params[2])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
 	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
 	if(params[1] > 30) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ���� ���� - �� ������ 30 ����!");
	if(IsPlayerName(params[0],"SCR") || IsPlayerNPC(params[0])) return true;
 	format(str, sizeof(str), "Alpino:  %s ���(�) �������(�) %s�� %s �� %s. �������: %s", PlayerInfo[params[0]][pName],NameAdmin(playerid),PlayerInfo[playerid][pName],nformat(params[1],"����","���","����"),params[2]);
	SendClientMessageToAll(COLOR_LIGHTRED, str);
	unbandate = gettime() + params[1]*86400;
	getdate(year, month, day);
	GetPlayerIp(params[0], ip, 32);
	format(date, 16, "%02d.%02d.%04d",day, month, year);
	format(str, sizeof(str), "INSERT INTO `bans` (name, IP, bandate, time, unbandate, reason, admin) VALUES ('%s', '%s', '%s', %d, %d, '%s', '%s')", PlayerInfo[params[0]][pName], ip, date, params[1], unbandate, params[2], PlayerInfo[playerid][pName]);
	mysql_query(str);
	ALKick(params[0]);
	SetPVarInt(playerid, "banotkat", 5);
	SetPVarInt(playerid, "bc", GetPVarInt(playerid, "bc")+1);
	if(GetPVarInt(playerid, "banotkat") > 0 && GetPVarInt(playerid, "bc") > 2){ PlayerInfo[playerid][pAdmin] = 0; }
	return true;
}
CMD:kick(playerid, params[])
{
	new str[144];
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"rs[64]",params[0],params[1])) return SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} /kick [ID ������/���] [�������]");
	if(IsIP(params[1]) || CheckString(params[1]) || CheckMsg(params[1])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(IsPlayerName(params[0],"SCR") || IsPlayerNPC(params[0])) return true;
 	format(str, sizeof(str), "Alpino:  %s ���(�) ������(�) %s�� %s. �������: %s", PlayerInfo[params[0]][pName],NameAdmin(playerid),PlayerInfo[playerid][pName],params[1]);
	SendClientMessageToAll(COLOR_LIGHTRED,str);
	ALKick(params[0]);
	SetPVarInt(playerid, "kickotkat", 5);
	SetPVarInt(playerid, "kc", GetPVarInt(playerid, "kc")+1);
	if(GetPVarInt(playerid, "kickotkat") > 0 && GetPVarInt(playerid, "kc") > 2){ PlayerInfo[playerid][pAdmin] = 0; }
	return true;
}
CMD:mute(playerid, params[])
{
	new str[144];
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ris[64]",params[0],params[1],params[2])) return SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} /mute [ID ������/���] [�����] [�������]");
	if(IsIP(params[2]) || CheckString(params[2]) || CheckMsg(params[2])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	PlayerInfo[params[0]][pMuteTime] = params[1]*60;
 	format(str, sizeof(str), "Alpino: %s ���(�) �������(�) %s�� %s �� %s. �������: %s", PlayerInfo[params[0]][pName],NameAdmin(playerid),PlayerInfo[playerid][pName],nformat(params[1],"������","������","�����"),params[2]);
	SendClientMessageToAll(COLOR_LIGHTRED,str);
	MuteText[params[0]] = CreateDynamic3DTextLabel(""LRED"� ������ ��� ����", -1, 0.00, 0.00, 0.0, 20.0, params[0], INVALID_VEHICLE_ID, 0, -1, -1, -1, 15.0);
	mute[params[0]] = true;
	strmid(PlayerInfo[params[0]][pMuteReason],params[2],0,64,255);
	strmid(PlayerInfo[params[0]][pMuteDal],PlayerInfo[playerid][pName],0,64,255);
	strmid(PlayerInfo[params[0]][pUnmuteReason],"���",0,64,255);
	strmid(PlayerInfo[params[0]][pUnmuteDal],"���",0,64,255);
	return true;
}
CMD:unmute(playerid, params[])
{
	new str[144];
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"rs[64]",params[0],params[1])) return SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} /unmute [ID ������/���] [�������]");
	if(IsIP(params[1]) || CheckString(params[1]) || CheckMsg(params[1])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(PlayerInfo[params[0]][pMuteTime] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ����� ������ ��� ���� ����!");
	PlayerInfo[params[0]][pMuteTime] = 0;
 	format(str, sizeof(str), "Alpino:  %s ���(�) ���������(�) %s�� %s. �������: %s", PlayerInfo[params[0]][pName],NameAdmin(playerid),PlayerInfo[playerid][pName],params[1]);
	SendClientMessageToAll(COLOR_LIGHTRED,str);
	strmid(PlayerInfo[params[0]][pUnmuteReason],params[1],0,64,255);
	strmid(PlayerInfo[params[0]][pUnmuteDal],PlayerInfo[playerid][pName],0,64,255);
	DestroyDynamic3DTextLabel(MuteText[params[0]]);
	return true;
}
CMD:jail(playerid, params[])
{
	new str[144],string[100];
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ris[64]",params[0],params[1],params[2])) return SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} /jail [ID ������/���] [�����] [�������]");
	if(IsIP(params[2]) || CheckString(params[2]) || CheckMsg(params[2])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	PlayerInfo[params[0]][pJailTime] = params[1]*60;
	PlayerInfo[params[0]][pJailed] = 2;
	JailPlayer(params[0]);
 	format(str, sizeof(str), "Alpino: %s ���(�) �������(�) � ������ %s�� %s �� %s. �������: %s", PlayerInfo[params[0]][pName],NameAdmin(playerid),PlayerInfo[playerid][pName],nformat(params[1],"������","������","�����"),params[2]);
	SendClientMessageToAll(COLOR_LIGHTRED,str);
	format(string,sizeof(string),"Time in Jail: %s",ConvertSeconds(PlayerInfo[params[0]][pJailTime]));
	PlayerTextDrawSetString(params[0],TimeJail[params[0]], string);
	PlayerTextDrawShow(params[0],TimeJail[params[0]]);
	return true;
}
CMD:unjail(playerid, params[])
{
	new str[144];
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"rs[64]",params[0],params[1])) return SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} /unjail [ID ������/���] [�������]");
	if(IsIP(params[1]) || CheckString(params[1]) || CheckMsg(params[1])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(PlayerInfo[params[0]][pJailTime] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ���� ����� �� � ���!");
	PlayerInfo[params[0]][pJailTime] = 0;
	PlayerInfo[params[0]][pJailed] = 0;
	SetPlayerInterior(params[0], 6);
	ServerSetPlayerPos(params[0],246.40036010742,71.318893432617,1003.640625);
	SetPlayerVirtualWorld(params[0],0);
 	format(str, sizeof(str), "Alpino: %s ���(�) �������(�) �� ������  %s�� %s. �������: %s", PlayerInfo[params[0]][pName],NameAdmin(playerid),PlayerInfo[playerid][pName],params[1]);
	SendClientMessageToAll(COLOR_LIGHTRED,str);
	PlayerTextDrawHide(params[0], TimeJail[params[0]]);
	return true;
}
CMD:warn(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new date[64],ip[16],days,unbandate,str[512];
	if(sscanf(params,"rs[64]",params[0],params[1])) return SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} /warn [ID ������/���] [�������]");
	if(IsIP(params[1]) || CheckString(params[1]) || CheckMsg(params[1])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(IsPlayerName(params[0],"SCR")) return true;
	PlayerInfo[params[0]][pWarn] ++;
	if(GetPlayerMember(params[0]) > 0)
	{
		new string[128];
		format(string,sizeof(string),"%s ���(�) ������(�) �� �������. �������: ������� ��������������",PlayerInfo[params[0]][pName]);
		SendFractionMessage(COLOR_BLUE,string,GetPlayerMember(params[0]));
		format(string,sizeof(string),"�� ���� ������� �� �������. �������: �������� ��������������",PlayerInfo[playerid][pName]);
		SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
		TogglePlayerControllable(params[0],1);
		ServerResetPlayerWeapons(params[0]);
		PlayerInfo[params[0]][pRank] = 0;
		PlayerInfo[params[0]][pMember] = 0;
		PlayerInfo[params[0]][pLeader] = 0;
		PlayerInfo[params[0]][pSkin] = DEFAULTSKIN;
		SetPlayerSkin(params[0],DEFAULTSKIN);
		PlayerInfo[params[0]][pSpawn] = 0;
		PlayerInfo[params[0]][pJob] = 0;
	}
	if(PlayerInfo[params[0]][pWarn] == 3)
	{
		getdate(year, month, day);
		GetPlayerIp(params[0], ip, 32);
		format(date, 16, "%02d.%02d.%04d",day, month, year);
		format(str, sizeof(str), "INSERT INTO bans (name, ip, bandate, time, unbandate, reason, admin) VALUES ('%s', '%s', '%s', 15, 15*86400, '%s', '%s')", PlayerInfo[params[0]][pName], ip, date, days, unbandate, params[1], PlayerInfo[playerid][pName]);
		mysql_query(str);
		ALKick(params[0]);
	}
	format(str, sizeof(str), "Alpino:  %s ���(�) �������������(�) %s�� %s. �������: %s", PlayerInfo[params[0]][pName],NameAdmin(playerid),PlayerInfo[playerid][pName],params[1]);
	SendClientMessageToAll(COLOR_LIGHTRED,str);
	SetPVarInt(playerid, "warnotkat", 5);
	SetPVarInt(playerid, "wc", GetPVarInt(playerid, "wc")+1);
	if(GetPVarInt(playerid, "warnotkat") > 0 && GetPVarInt(playerid, "wc") > 2){ PlayerInfo[playerid][pAdmin] = 0; }
	return true;
}
CMD:unwarn(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new str[144];
	if(sscanf(params,"rs[64]",params[0],params[1])) return SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} /unwarn [ID ������/���] [�������]");
	if(IsIP(params[1]) || CheckString(params[1]) || CheckMsg(params[1])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(PlayerInfo[params[0]][pWarn] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ����� ������ ��� ��������������!");
	PlayerInfo[params[0]][pWarn] --;
	format(str, sizeof(str), "Alpino:  %s %s c���(�) �������������� � ������ %s. �������: %s", NameAdmin(playerid),PlayerInfo[playerid][pName],PlayerInfo[params[0]][pName],params[1]);
	SendClientMessageToAll(COLOR_LIGHTRED,str);
	format(str,sizeof(str),"%s ����(�) �������������� %s.�������: %s",PlayerInfo[playerid][pName],PlayerInfo[params[0]][pName],params[1]);
	WriteLog("UnwarnLog",str);
	return true;
}

CMD:unban(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new text[32],str[144];
	if(sscanf(params, "s[144]", text)) return SendClientMessage(playerid, 0xFF0000AA, "{3812E1}[���������]{FFFFFF} /unban [��� ������]");
	format(str, sizeof(str), "SELECT * FROM bans WHERE name = '%s'", text);
	if(mysql_query(str) && mysql_store_result())
	{
		if(!mysql_num_rows()) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ����� �� ������ � ������ ��������� �����!");
		format(str, sizeof(str), "DELETE FROM bans WHERE name = '%s'", text);
  		mysql_query(str);
		format(str, sizeof(str), "�� {00FF00}�������{FFFFFF} ��������� %s", text);
		SendClientMessage(playerid, 0xFF0000AA, str);
		format(str,sizeof(str),"%s ��������(�) %s.",PlayerInfo[playerid][pName],text);
		WriteLog("UnbanLog",str);
	}
	mysql_free_result();
	return true;
}
CMD:banlist(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
 	new banlist[1000];
  	new name[21], line[30];
	mysql_query("SELECT name FROM bans");
	if(mysql_store_result())
	{
		for(new i; i<mysql_num_rows(); i++)
		{
			if(mysql_fetch_row_format(name))
			{
				format(line, sizeof(line), "{FF0000}%s\n", name);
				strcat(banlist, line);
			}
			SPD(playerid, DIALOG_BAN_INFO, DIALOG_STYLE_LIST, ""PREFIX" ������ ��������� �����", banlist, "�������", "�������");
		}
	}
	mysql_free_result();
	return true;
}
CMD:wanted(playerid, params[])
{
	if(!IsACop(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new string[144],spisok[512];
	foreach(Player,i)
	{
		if(GetPlayerWantedLevel(i) > 0)
		{
			format(string,sizeof(string),"{FFFFFF}%s[%d]. ������� �������: %d\n",PlayerInfo[i][pName],i,GetPlayerWantedLevel(i));
			strcat(spisok,string);
		}
	}
	SPD(playerid,999,DIALOG_STYLE_LIST,""PREFIX" ������ �������������",spisok,"��","");
	return true;
}
CMD:apanel(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	ShowAPanel(playerid);
	return true;
}
CMD:makeadmin(playerid, params[])
{
	if(!IsPlayerName(playerid,"SCR") && !IsPlayerName(playerid,"Ko1basteR")) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new string[128];
	if(sscanf(params,"ri",params[0],params[1])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /makeadmin [ID ������/���] [������� �������]");
	if(params[1] > 6 || params[1] < 0) return SendClientMessage(playerid, 1, "{F31212}[������]{FFFFFF} ������� ������� �� ����� ���� ������ 0 � ������ 6!");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����!");
	PlayerInfo[params[0]][pAdmin] = params[1];
	format(string, sizeof(string), "�� ���� ��������� ��������������� %d ������ (��������(a): ��.������������� %s)",params[1],PlayerInfo[playerid][pName]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string, sizeof(string), "�� ��������� %s ��������������� %d ������.",PlayerInfo[params[0]][pName] ,params[1]);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	return true;
}
CMD:makehelper(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6 && !IsPlayerAdmin(playerid) && PlayerInfo[playerid][pHelper] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new string[144], rank[32];
	if(sscanf(params,"ri",params[0],params[1])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /makehelper [ID ������/���] [������� ��������]");
	if(params[1] > 2 || params[1] < 0) return SendClientMessage(playerid, 1, "{F31212}[������]{FFFFFF} ������� �������� �� ����� ���� ������ 0 � ������ 2.");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(PlayerInfo[params[0]][pAdmin] > 0) return SendClientMessage(playerid, 1, "{F31212}[������]{FFFFFF} �������������� ������ ��������� ��������!");
	PlayerInfo[params[0]][pHelper] = params[1];
	if(PlayerInfo[playerid][pAdmin] == 6) { rank = "��.�������������"; }
	else { rank = "��.������"; }
	format(string, sizeof(string), "�� ���� ��������� �������� %d ������ (��������(a): %s %s)",params[1],rank,PlayerInfo[playerid][pName]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string, sizeof(string), "�� ��������� %s �������� %d ������.",PlayerInfo[params[0]][pName] ,params[1]);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	return true;
}
CMD:vopros(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] > 10) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� ������� ������ 10, ��� ������ ������ � ������!");
	if(sscanf(params,"s[144]",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /vopros [������]");
	if(IsIP(params[0]) || CheckString(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	new string[128];
	format(string,sizeof(string),"{F31212}[AVS]{FFFFFF} ������ �� %s[%d] :%s. ��������� /otvet, ����� �������� �� ������",PlayerInfo[playerid][pName],playerid,params[0]);
	SendHelperMessage(COLOR_LIGHTBLUE,string);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"{F31212}[AVS]{FFFFFF} ��� ������ ��������� ��������. ����� ������!");
	return true;
}
CMD:veh(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pHelper] < 2) return SendClientMessage(playerid,1,"{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"iii",params[0],params[1],params[2]))
	{
		DestroySelectionMenu(playerid);
	    SetPVarInt(playerid, "vspawner_active", 1);
	    CreateSelectionMenu(playerid);
	    SelectTextDraw(playerid, 0xACCBF1FF);
		return true;
	}
	SpawnVehicle_InfrontOfPlayer(playerid,params[0],params[1],params[2]);
	return true;
}
CMD:edithouse(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid,1,"{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new type[32],value;
	if(sscanf(params,"s[64]i",type,value)) return SendClientMessage(playerid,1,"{3812E1}[���������]{FFFFFF} /edithouse [level(�������)/price(����)] [��������]");
	for(new i = 1; i < sizeof(HouseInfo); i++)
	{
		if(strcmp(type,"level",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez])) { HouseInfo[i][hLevel] = value; UpdateHouseText(i); SaveHouse(i); }
		}
		else if(strcmp(type,"price",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez])) { HouseInfo[i][hValue] = value; UpdateHouseText(i); SaveHouse(i); }
		}
	}
	return true;
}
CMD:editammo(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid,1,"{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new type[32],value;
	if(sscanf(params,"s[64]i",type,value)) return SendClientMessage(playerid,1,"{3812E1}[���������]{FFFFFF} /editammo [level(�������)/price(����)] [��������]");
	for(new i = 1; i < sizeof(Ammo); i++)
	{
		if(strcmp(type,"level",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,Ammo[i][amEnterX], Ammo[i][amEnterY], Ammo[i][amEnterZ])) { Ammo[i][amLevel] = value; UpdateAmmoText(i); SaveAmmo(i); }
		}
		else if(strcmp(type,"price",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,Ammo[i][amEnterX], Ammo[i][amEnterY], Ammo[i][amEnterZ])) { Ammo[i][amPrice] = value; UpdateAmmoText(i); SaveAmmo(i); }
		}
	}
	return true;
}
CMD:editshop(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid,1,"{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new type[32],value;
	if(sscanf(params,"s[64]i",type,value)) return SendClientMessage(playerid,1,"{3812E1}[���������]{FFFFFF} /editammo [level(�������)/price(����)] [��������]");
	for(new i = 1; i < sizeof(Magazin); i++)
	{
		if(strcmp(type,"level",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,Magazin[i][mEnterX], Magazin[i][mEnterY], Magazin[i][mEnterZ])) { Magazin[i][mLevel] = value; UpdateMagazinText(i); SaveMagazin(i); }
		}
		else if(strcmp(type,"price",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,Magazin[i][mEnterX], Magazin[i][mEnterY], Magazin[i][mEnterZ])) { Magazin[i][mPrice] = value; UpdateMagazinText(i); SaveMagazin(i); }
		}
	}
	return true;
}
CMD:editclub(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid,1,"{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new type[32],value;
	if(sscanf(params,"s[64]i",type,value)) return SendClientMessage(playerid,1,"{3812E1}[���������]{FFFFFF} /editammo [level(�������)/price(����)] [��������]");
	for(new i = 1; i < sizeof(Club); i++)
	{
		if(strcmp(type,"level",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,Club[i][cEnterX], Club[i][cEnterY], Club[i][cEnterZ])) { Club[i][cLevel] = value; UpdateClubText(i); SaveClub(i); }
		}
		else if(strcmp(type,"price",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,Club[i][cEnterX], Club[i][cEnterY], Club[i][cEnterZ])) { Club[i][cPrice] = value; UpdateClubText(i); SaveClub(i); }
		}
	}
	return true;
}
CMD:editgas(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid,1,"{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new type[32],value;
	if(sscanf(params,"s[32]i",type,value)) return SendClientMessage(playerid,1,"{3812E1}[���������]{FFFFFF} /editgas [level(�������)/price(����)/] [��������]");
	for(new i = 1; i < sizeof(Gas); i++)
	{
		if(strcmp(type,"level",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,Gas[i][gX], Gas[i][gY], Gas[i][gZ])) { Gas[i][gLevel] = value; UpdateGasText(i); SaveGas(i); }
		}
		else if(strcmp(type,"price",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,Gas[i][gX], Gas[i][gY], Gas[i][gZ])) { Gas[i][gPrice] = value; UpdateGasText(i); SaveGas(i); }
		}
		else if(strcmp(type,"k80",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,Gas[i][gX], Gas[i][gY], Gas[i][gZ])) { Gas[i][g80] = value; SaveGas(i); }
		}
		else if(strcmp(type,"k92",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,Gas[i][gX], Gas[i][gY], Gas[i][gZ])) { Gas[i][g92] = value; SaveGas(i); }
		}
		else if(strcmp(type,"k95",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,Gas[i][gX], Gas[i][gY], Gas[i][gZ])) { Gas[i][g95] = value; SaveGas(i); }
		}
		else if(strcmp(type,"k98",true) == 0)
		{
			if (IsPlayerInRangeOfPoint(playerid,3,Gas[i][gX], Gas[i][gY], Gas[i][gZ])) { Gas[i][gDisel] = value; SaveGas(i); }
		}
	}
	return true;
}
CMD:addjcar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid,1,"{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new frac,color,car = GetPlayerVehicleID(playerid),car1 = GetVehicleModel(car);
	if(sscanf(params,"iiii",frac,color,params[3])) return SendClientMessage(playerid,1,"{3812E1}[���������]{FFFFFF} /addjcar [ID ������] [ID ����� 1] [ID ����� 2]");
	if(GetPlayerVehicleID(playerid) == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ����� ��������� � ������");
	mysql_query("Select * From `Fraction Auto`");
    mysql_store_result();
	new id = mysql_num_rows();
    AutoInfo[id+1][aModel] = car1;
    AutoInfo[id+1][aColor1] = color;
	AutoInfo[id+1][aColor2] = params[3];
	AutoInfo[id+1][aJob] = frac;
    GetVehiclePos(GetPlayerVehicleID(playerid),AutoInfo[id+1][aX],AutoInfo[id+1][aY],AutoInfo[id+1][aZ]);
    GetVehicleZAngle(GetPlayerVehicleID(playerid),AutoInfo[id+1][aA]);
	DestroyVehicle(GetPlayerVehicleID(playerid));
    AutoInfo[id+1][aID] = CreateVehicle(AutoInfo[id+1][aModel],AutoInfo[id+1][aX],AutoInfo[id+1][aY],AutoInfo[id+1][aZ],AutoInfo[id+1][aA],AutoInfo[id+1][aColor1],AutoInfo[id+1][aColor2],300);
    new query[512];
    format(query,sizeof(query),"INSERT INTO `Fraction Auto` (id,modelid,posX,posY,posZ,posA,color1,color2,job) VALUES ('%i',%d,%f,%f,%f,%f,%d,%d,%d)",id+1,AutoInfo[id+1][aModel],AutoInfo[id+1][aX],AutoInfo[id+1][aY],AutoInfo[id+1][aZ],AutoInfo[id+1][aA],color,params[3],frac);
    mysql_free_result();
    mysql_query(query);
    AutoInfo[id+1][aBaseid] = id+1;
	SendClientMessage(playerid,-1,"{FFFFFF}������ {147130}�������{FFFFFF} ���������!");
	return true;
}
CMD:donate(playerid, params[])
{
	new title[100];
	format(title, sizeof(title), ""PREFIX" ������: "PURP"%s", nformat(PlayerInfo[playerid][pDM],"�����","�����","������"));
	SPD(playerid,DIALOG_DONAT,DIALOG_STYLE_LIST,title,""WHT"������� ������� ���\t\t\t("YE"100"WHT" ������)\n�������� ������� �� ���� �������\t("YE"60"WHT" ������)\n����� ���� ��������������\t\t("YE"50"WHT" ������)\n���������� VIP �� �����\t\t("YE"100"WHT" ������)\n\
	���������� 100� ����������\t\t("YE"100"WHT" ������)\n���������� 100� ����������\t\t("YE"200"WHT" ������)","�����","������");
	return true;
}
CMD:popoln(playerid, params[]) {
	SPD(playerid, DIALOG_DONAT+101, DIALOG_STYLE_INPUT, ""PREFIX" ���������� �������", "������� ���, ������� ��� ����� ��� ���������� �������", "�����", "������");
	return true;
}
CMD:addcar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid,1,"{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new car = GetPlayerVehicleID(playerid),car1 = GetVehicleModel(car);
	if(GetPlayerVehicleID(playerid) == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ����� ��������� � ������");
	mysql_query("Select * From `Street`");
    mysql_store_result();
	new id = mysql_num_rows();
    Street[id+1][stModel] = car1;
    GetVehiclePos(GetPlayerVehicleID(playerid),Street[id+1][stX],Street[id+1][stY],Street[id+1][stZ]);
    GetVehicleZAngle(GetPlayerVehicleID(playerid),Street[id+1][stA]);
    new query[512];
    format(query,sizeof(query),"INSERT INTO `Street` (id,Model,X,Y,Z,A) VALUES (%d,'%d',%f,%f,%f,%f)",id+1,Street[id+1][stModel],Street[id+1][stX],Street[id+1][stY],Street[id+1][stZ],Street[id+1][stA]);
    mysql_free_result();
    mysql_query(query);
	SendClientMessage(playerid,-1,"{FFFFFF}������ {147130}�������{FFFFFF} ���������!");
	return true;
}
CMD:goto(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pHelper] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new Float:x,Float:y,Float:z,string[144];
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid,1,"{3812E1}[���������]{FFFFFF} /goto [ID ������/���]");
	if(params[0] == playerid) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ����������������� � ����!");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����!");
	if(PlayerInfo[params[0]][pAdmin] == 6 && PlayerInfo[playerid][pAdmin] != 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ����������������� � ����� ������!");
	GetPlayerPos(params[0],x,y,z);
	new int = GetPlayerInterior(params[0]);
	new vw = GetPlayerVirtualWorld(params[0]);
	SetPlayerInterior(playerid,int);
	SetPlayerVirtualWorld(playerid,vw);
	SetALPos(playerid,x,y,z);
	format(string,sizeof(string),"�� ����������������� � {1EB7C2}%s[%d]{FFFFFF}",PlayerInfo[params[0]][pName],params[0]);
	SendClientMessage(playerid,-1,string);
	LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(params[0]));
	return true;
}
CMD:gethere(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pHelper] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new Float:x,Float:y,Float:z;
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid,1,"{3812E1}[���������]{FFFFFF} /gethere [ID ������/���]");
	if(params[0] == playerid) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ��������������� ���� � ����!");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(PlayerInfo[params[0]][pAdmin] == 6 && PlayerInfo[playerid][pAdmin] != 6 && PlayerInfo[playerid][pAdmin] != 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ��������������� ����� ������!");
	GetPlayerPos(playerid,x,y,z);
	SetPlayerVirtualWorld(params[0],GetPlayerVirtualWorld(playerid));
	SetPlayerInterior(params[0],GetPlayerInterior(playerid));
	SetALPos(params[0],x,y,z);
	return true;
}
CMD:addfcar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid,1,"{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new frac,rank,color,car = GetPlayerVehicleID(playerid),car1 = GetVehicleModel(car);
	if(sscanf(params,"iiii",frac,rank,color,params[3])) return SendClientMessage(playerid,1,"{3812E1}[���������]{FFFFFF} /addfcar [ID �������] [����� �����] [ID ����� 1] [ID ����� 2]");
	if(GetPlayerVehicleID(playerid) == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ����� ��������� � ������");
	mysql_query("Select * From `Fraction Auto`");
    mysql_store_result();
	new id = mysql_num_rows();
    AutoInfo[id+1][aModel] = car1;
    AutoInfo[id+1][aColor1] = color;
	AutoInfo[id+1][aColor2] = params[3];
	AutoInfo[id+1][aFraction] = frac;
    AutoInfo[id+1][aRank] = rank;
    GetVehiclePos(GetPlayerVehicleID(playerid),AutoInfo[id+1][aX],AutoInfo[id+1][aY],AutoInfo[id+1][aZ]);
    GetVehicleZAngle(GetPlayerVehicleID(playerid),AutoInfo[id+1][aA]);
	DestroyVehicle(GetPlayerVehicleID(playerid));
    AutoInfo[id+1][aID] = CreateVehicle(AutoInfo[id+1][aModel],AutoInfo[id+1][aX],AutoInfo[id+1][aY],AutoInfo[id+1][aZ],AutoInfo[id+1][aA],AutoInfo[id+1][aColor1],AutoInfo[id+1][aColor2],300);
    new query[512];
    format(query,sizeof(query),"INSERT INTO `Fraction Auto` (id,modelid,posX,posY,posZ,posA,color1,color2,rank,fraction) VALUES ('%i',%d,%f,%f,%f,%f,%d,%d,%d,%d)",id+1,AutoInfo[id+1][aModel],AutoInfo[id+1][aX],AutoInfo[id+1][aY],AutoInfo[id+1][aZ],AutoInfo[id+1][aA],color,params[3],rank,frac);
    mysql_free_result();
    mysql_query(query);
    AutoInfo[id+1][aBaseid] = id+1;
	SendClientMessage(playerid,-1,"{FFFFFF}������ {147130}�������{FFFFFF} ���������!");
	return true;
}
CMD:makeleader(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /makeleader [ID ������/���]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(PlayerInfo[params[0]][pWarn] > 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������ ������� ������� ������ � ����������������!");
	new string[144],leaders[1024];
	for(new i = 1; i < sizeof(Fraction); i++)
	{
		format(string,sizeof(string),"%s (ID: %d). �����: %s\n",Fraction[i][fName],Fraction[i][fID],Fraction[i][fLeader]);
		strcat(leaders,string);
	}
	SPD(playerid,DIALOG_MAKELEADER,DIALOG_STYLE_LIST,""PREFIX" ��������� ������",leaders,"�����","������");
	SetPVarInt(playerid,"idleader",params[0]);
	return true;
}
CMD:asellhouse(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new query[128];
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /asellhouse [ID ����]");
	format(query, sizeof(query), "UPDATE `Accounts` SET House = 0, Spawn = 0 WHERE Nickname = '%s'", HouseInfo[params[0]][hOwner]);
	mysql_query(query);
	HouseInfo[params[0]][hLock] = true;
	HouseInfo[params[0]][hOwned] = false;
	strmid(HouseInfo[params[0]][hOwner], "The State", 0, strlen("The State"), 255);
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SendClientMessage(playerid,-1,"{FFFFFF}��� {147130}�������{FFFFFF} ������!");
	SaveHouse(params[0]);
	UpdateHouseText(params[0]);
	new plid = ReturnUser(HouseInfo[params[0]][hOwner]);
	if(plid >= 0) { PlayerInfo[plid][pHouse] = 0; PlayerInfo[playerid][pSpawn] = 0; return true;}
	return true;
}
CMD:asellcar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /asellcar [ID ������]");
	PlayerInfo[params[0]][pCar] = 0;
	PlayerInfo[params[0]][pCarM] = 0;
	PlayerInfo[params[0]][pCarX] = 0.0;
	PlayerInfo[params[0]][pCarY] = 0.0;
	PlayerInfo[params[0]][pCarZ] = 0.0;
	PlayerInfo[params[0]][pCC1] = 0;
	PlayerInfo[params[0]][pCC2] = 0;
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"������ ������� �������");
	return true;
}
CMD:rent(playerid, params[])
{
	if(PlayerInfo[playerid][pHouse] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ���� ���!");
	if(PlayerInfo[playerid][pRent] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ��� ��������� ���!");
	for(new i = 1; i < sizeof(HouseInfo); i++)
	{
		if (IsPlayerInRangeOfPoint(playerid,2,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]))
		{
			new string[128];
			PlayerInfo[playerid][pRent] = i;
			format(string,sizeof(string),"{FFFFFF}�� {147130}�������{FFFFFF} ���������� ��� � {3C670E}%d{FFFFFF}",i);
			SendClientMessage(playerid,-1,string);
		}
	}
	return true;
}
CMD:unrent(playerid, params[])
{
	if(PlayerInfo[playerid][pRent] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� �� ��������� ���!");
	PlayerInfo[playerid][pRent] = 0;
	SendClientMessage(playerid,-1,"{FFFFFF}�� {147130}�������{FFFFFF} ���������� �� ������ ����!");
	return true;
}
CMD:givemoney(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ri",params[0],params[1])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /givemoney [ID ������/���] [�����]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	SetMoney(params[0],params[1]);
	return true;
}
CMD:gps(playerid, params[]) return ShowKpkGps(playerid);
CMD:s(playerid, params[])
{
	if(PlayerInfo[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(sscanf(params,"s[144]",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /s(hout) [�����]");
	if(CapsLockCheck(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ����� ��������� ������� ����� ��������� ����!");
	if(IsIP(params[0]) || CheckString(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	new string[128];
	if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"{22BFE7}%s[%d] ������:{FFFFFF} %s",PlayerInfo[playerid][pName],playerid,params[0]);
	else format(string,sizeof(string),"{22BFE7}����������� ������:{FFFFFF} %s",params[0]);
	SendRadiusMessage(20.0, playerid, string,COLOR_LIGHTBLUE);
	return true;
}
CMD:l(playerid, params[])
{
	if(PlayerInfo[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(sscanf(params,"s[144]",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /l [�����]");
	if(IsIP(params[0]) || CheckString(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(CapsLockCheck(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ����� ��������� ������� ����� ��������� ����!");
	if(PlayerInfo[playerid][pLeader] == 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ��� ���������� ��� �������!");
	new string[128];
	format(string, sizeof(string), ""PURP"(��� �������)"WHT" %s[%d] "LRED"(%s)"WHT": %s", PlayerInfo[playerid][pName], playerid, Fraction[GetPlayerMember(playerid)][fName], params[0]);
	SendLeadersMessage(-1, string);
	return true;
}
CMD:o(playerid, params[])
{
	new string[128];
	format(string,sizeof(string),"{B20A0A}MAF:{FFFFFF} ��������� ��������� �� ������� ��������� ����� "GRN"%s{FFFFFF}",nformat(GetPVarInt(playerid,"alo"),"�������","�������","������"));
	if(GetPVarInt(playerid,"alo") > 0) return SendClientMessage(playerid,-1,string);
	if(PlayerInfo[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(sscanf(params,"s[144]",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /o(oc) [�����]");
	if(IsIP(params[0]) || CheckString(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(CapsLockCheck(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ����� ��������� ������� ����� ��������� ����!");
	if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ����� ��� ����� ������ � ������� ������!");
	if(noooc == true) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����� ��� ��������!");
	new prefix[20];
	if(PlayerInfo[playerid][pAdmin] == 6) prefix = "{0202FF}�"WHT"";
	else if(PlayerInfo[playerid][pAdmin] == 5) prefix = ""LRED"�"WHT"";
	else if(PlayerInfo[playerid][pAdmin] > 0 && PlayerInfo[playerid][pAdmin] < 5) prefix = "{00FF00}�"WHT"";
	else if(PlayerInfo[playerid][pHelper] == 1) prefix = "{EEE8AA}�"WHT"";
	else if(PlayerInfo[playerid][pHelper] == 2) prefix = "{EEE8AA}�"WHT"";
 	else prefix = "�";
	format(string,sizeof(string),"%s %s[%d]: %s",prefix,PlayerInfo[playerid][pName],playerid,params[0]);
	SendOOC(-1,string);
	if(PlayerInfo[playerid][pAdmin] == 0) SetPVarInt(playerid,"alo",60);
	return true;
}
CMD:setfskin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"iii",params[0],params[1],params[2])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /setfskin [ID �������] [����� �����] [ID �����]");
	new query[512];
	format(query, sizeof(query), "UPDATE `Fractions` SET Skin%d = %d WHERE Id = '%d'",params[1],params[2],params[0]);
	mysql_query(query);
	switch(params[1])
	{
		case 1: Fraction[params[0]][fSkin1] = params[2];
		case 2: Fraction[params[0]][fSkin2] = params[2];
		case 3: Fraction[params[0]][fSkin3] = params[2];
		case 4: Fraction[params[0]][fSkin4] = params[2];
		case 5: Fraction[params[0]][fSkin5] = params[2];
		case 6: Fraction[params[0]][fSkin6] = params[2];
	}
	return true;
}
CMD:setname(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"rs[32]",params[0],params[1])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /setname [ID ������/���] [����� ���] ");
	new query[512];
	format(query, sizeof(query), "UPDATE `Accounts` SET Nickname = '%s' WHERE ID = '%i'",params[1],PlayerInfo[params[0]][pID]);
	mysql_query(query);
	SetPlayerName(params[0],params[1]);
	strmid(PlayerInfo[params[0]][pName], params[1], 0, strlen(params[1]), 255);
	return true;
}
CMD:setstat(playerid, params[])
{
	new string[144],type[32],value,id;
	if(!IsPlayerName(playerid,"SCR") && !IsPlayerName(playerid,"Ko1basteR")) return true;
	if(sscanf(params,"rs[32]i",id,type,value)) return SendClientMessage(playerid, 1, "{3812E1}[?????????]{FFFFFF} /setstat [ID ??????/???] [Level\\Exp\\GameTime(??????? ?????)\\Mats(?????????)\\Drugs(?????????)\\Job(??????)\\Bank(?????? ? ?????))] [????????]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[??????]{FFFFFF} ????? ?? ? ????");
	if(strcmp(type,"level",true) == 0) { PlayerInfo[id][pLevel] = value; SetPlayerScore(id,value); }
	else if(strcmp(type,"exp",true) == 0) PlayerInfo[id][pExp] = value;
	else if(strcmp(type,"mats",true) == 0) PlayerInfo[id][pMats] = value;
	else if(strcmp(type,"drugs",true) == 0) PlayerInfo[id][pDrugs] = value;
	else if(strcmp(type,"job",true) == 0) PlayerInfo[id][pJob] = value;
	else if(strcmp(type,"bank",true) == 0) PlayerInfo[id][pBank] = value;
	switch(PlayerInfo[id][pLevel])
	{
		case 0: PlayerInfo[id][pExpNext] = 3;
		default: PlayerInfo[id][pExpNext] = (PlayerInfo[id][pLevel]+1)*3;
	}
	format(string,sizeof(string),"~w~LvL: ~y~%d  ~w~Exp: ~y~%d~w~/~y~%d",PlayerInfo[id][pLevel],PlayerInfo[id][pExp],PlayerInfo[id][pExpNext]);
	PlayerTextDrawSetString(id,lvlexp[id], string);
	return true;
}
CMD:accept(playerid, params[])
{
	new string[128];
	if(sscanf(params,"s[32]",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /accept [������������] ");
	if(strcmp(params[0],"invite",true) == 0)
	{
		if(InviteOffer[playerid] == -1) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ����� �� ��������� ��� �������� �� �������!");
		PlayerInfo[playerid][pRank] = 1;
		GetPVarInt(playerid,"fractioninvite");
		PlayerInfo[playerid][pMember] = GetPVarInt(playerid,"fractioninvite");
		SetPlayerSkin(playerid,Fraction[GetPVarInt(playerid,"fractioninvite")][fSkin1]);
		format(string,sizeof(string),"%s ������� � ��� �� �������. ������: %s",PlayerInfo[playerid][pName],PlayerInfo[InviteOffer[playerid]][pName]);
		SendFractionMessage(COLOR_BLUE,string,GetPVarInt(playerid,"fractioninvite"));
		PlayerInfo[playerid][pSpawn] = 1;
		PlayerInfo[playerid][pSkin] = Fraction[GetPVarInt(playerid,"fractioninvite")][fSkin1];
		InviteOffer[playerid] = -1;
		SetPVarInt(playerid,"fractioninvite",0);
		ServerSetPlayerHealth(playerid,0);
	}
	return true;
}
CMD:setrankname(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"iis[64]",params[0],params[1],params[2])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /setrankname [ID �������] [����� �����] [��������] ");
	new query[512],string[144];
	format(query, sizeof(query), "UPDATE `Fractions` SET `rank%d` = '%s' WHERE `id` = '%d'",params[1],params[2],params[0]);
	mysql_query(query);
	format(string,sizeof(string),"{FFFFFF}����� �������� ����� {1C9698}%s{FFFFFF} ��������� ������ {1C9698}%d{FFFFFF}",params[2],params[1]);
	SendClientMessage(playerid,-1,string);
	return true;
}
CMD:invite(playerid, params[])
{
	if(PlayerInfo[playerid][pLeader] == 0 && PlayerInfo[playerid][pZam] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /invite [ID ������/���]");
	if(params[0] == playerid) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} �� �� ������ ���������� ��� ����!");
	if(PlayerInfo[params[0]][pMember] != 0 || PlayerInfo[params[0]][pLeader] != 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����� ��� ������� �o �������!");
	if(PlayerInfo[params[0]][pWarn] > 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������ ����� �� ������� ������ � ����������������!");
	new fam;
	if(PlayerInfo[playerid][pLeader] > 0) { fam = PlayerInfo[playerid][pLeader]; SetPVarInt(params[0],"fractioninvite",PlayerInfo[playerid][pLeader]); }
	else if(PlayerInfo[playerid][pZam] > 0) { fam = PlayerInfo[playerid][pZam]; SetPVarInt(params[0],"fractioninvite",PlayerInfo[playerid][pZam]); }
	if(Fraction[fam][fZamInvite] == false && PlayerInfo[playerid][pZam] > 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����� �������� ��������� �������!");
	new string[144],string1[144];
	format(string,sizeof(string),"{B20A0A}MAF:{FFFFFF} ���������� ������ �� ������� ����� {0F777B}%s{FFFFFF}",nformat(ainvite[playerid],"�������","�������","������"));
	if(ainvite[playerid] > 0) return SendClientMessage(playerid,-1,string);
	InviteOffer[params[0]] = playerid;
	format(string,sizeof(string),"����� %s ��������� ��� �������� � %s. ��������� /accept invite,����� ��������",PlayerInfo[playerid][pName],Fraction[PlayerInfo[playerid][pLeader]][fName]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string1,sizeof(string1),"�� ���������� ������ %s �������� � ���� �������",PlayerInfo[params[0]][pName]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string1);
	TogglePlayerControllable(params[0],1);
	ainvite[playerid] = 10;
	return true;
}
CMD:uninvite(playerid, params[])
{
	if(PlayerInfo[playerid][pLeader] == 0 && PlayerInfo[playerid][pAdmin] < 5 && PlayerInfo[playerid][pZam] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"rs[32]",params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /uninvite [ID ������/���] [�������]");
	if(PlayerInfo[params[0]][pLeader] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ������ �������!");
	new fam = GetPlayerMember(playerid);
	if(PlayerInfo[params[0]][pMember] != fam) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� ������� � ����� �������!");
	if(PlayerInfo[playerid][pZam] > 0 && Fraction[PlayerInfo[playerid][pZam]][fZamKick] == false) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����� �������� ������ �������!");
	new string[128];
	format(string,sizeof(string),"%s ���(�) ������(�) �� ������� ������� %s. �������: %s",PlayerInfo[params[0]][pName],PlayerInfo[playerid][pName],params[1]);
	SendFractionMessage(COLOR_BLUE,string,fam);
	format(string,sizeof(string),"�� ���� ������� ������� %s. �������: %s",PlayerInfo[playerid][pName],params[1]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	TogglePlayerControllable(params[0],1);
	ServerResetPlayerWeapons(params[0]);
	TextDrawHideForPlayer(params[0], GangZone[Fraction[GetPlayerMember(params[0])][fZaxvat]][gzTextDraw]);
	PlayerInfo[params[0]][pRank] = 0;
	PlayerInfo[params[0]][pMember] = 0;
	PlayerInfo[params[0]][pSkin] = DEFAULTSKIN;
	SetPlayerSkin(params[0],DEFAULTSKIN);
	PlayerInfo[params[0]][pSpawn] = 0;
	PlayerInfo[params[0]][pJob] = 0;
	return true;
}
CMD:unmakeleader(playerid, params[])
{
	new rank[64];
	if(PlayerInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"rs[32]",params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /unmakeleader [ID ������/���] [�������]");
	if(!IsPlayerConnected(params[0]))
	{
		new query[255];
		format(query, sizeof(query), "UPDATE `Accounts` SET Leader = 0,Skin = 3,Rank = 0 WHERE Nickname = '%s'", params[0]);
		mysql_query(query);
		return true;
	}
	if(PlayerInfo[params[0]][pLeader] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ���� ����� �� �����!");
	Fraction[PlayerInfo[params[0]][pLeader]][fLeader] = 0;
	PlayerInfo[params[0]][pRank] = 0;
	PlayerInfo[params[0]][pLeader] = 0;
	PlayerInfo[params[0]][pMember] = 0;
	SetPlayerSkin(params[0],1);
	PlayerInfo[params[0]][pSkin] = DEFAULTSKIN;
	PlayerInfo[params[0]][pSpawn] = 0;
	switch(PlayerInfo[playerid][pAdmin])
	{
		case 5: { rank = "���������������"; }
		case 6: { rank = "��.���������������"; }
	}
	new string[128];
	format(string,sizeof(string),"�� ���(�) ����(�) � ����� ������ %s %s. �������: %s",rank,PlayerInfo[playerid][pName],params[1]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� c���(�) � ����� ������ %s. �������: %s",PlayerInfo[params[0]][pName],params[1]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	TogglePlayerControllable(params[0],1);
	ServerResetPlayerWeapons(params[0]);
	return true;
}
CMD:giverank(playerid, params[])
{
	if(PlayerInfo[playerid][pLeader] == 0 && PlayerInfo[playerid][pZam] == 0 ) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ri",params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /giverank [ID ������/���] [����� �����]");
	new fam = GetPlayerMember(playerid);
	if(PlayerInfo[params[0]][pMember] != fam) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� ������� � ����� �������!");
	if(params[1] > 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������������ ���� - ������!");
	if(PlayerInfo[playerid][pZam] > 0 && Fraction[PlayerInfo[playerid][pZam]][fZamRank] == false) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����� �������� �������� ����� �������!");
	switch(params[1])
	{
		case 1: { SetPlayerSkin(params[0],Fraction[PlayerInfo[playerid][pLeader]][fSkin1]); PlayerInfo[params[0]][pSkin] = Fraction[PlayerInfo[playerid][pLeader]][fSkin1]; }
		case 2: { SetPlayerSkin(params[0],Fraction[PlayerInfo[playerid][pLeader]][fSkin2]); PlayerInfo[params[0]][pSkin] = Fraction[PlayerInfo[playerid][pLeader]][fSkin2]; }
		case 3: { SetPlayerSkin(params[0],Fraction[PlayerInfo[playerid][pLeader]][fSkin3]); PlayerInfo[params[0]][pSkin] = Fraction[PlayerInfo[playerid][pLeader]][fSkin3]; }
		case 4: { SetPlayerSkin(params[0],Fraction[PlayerInfo[playerid][pLeader]][fSkin4]); PlayerInfo[params[0]][pSkin] = Fraction[PlayerInfo[playerid][pLeader]][fSkin4]; }
		case 5: { SetPlayerSkin(params[0],Fraction[PlayerInfo[playerid][pLeader]][fSkin5]); PlayerInfo[params[0]][pSkin] = Fraction[PlayerInfo[playerid][pLeader]][fSkin6]; }
		case 6: { SetPlayerSkin(params[0],Fraction[PlayerInfo[playerid][pLeader]][fSkin6]); PlayerInfo[params[0]][pSkin] = Fraction[PlayerInfo[playerid][pLeader]][fSkin6]; }
	}
	PlayerInfo[params[0]][pRank] = params[1];
	new string[128];
	format(string,sizeof(string),"�� ���� ��������/�������� �� %d ����� ������� %s",params[1],PlayerInfo[playerid][pName]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� ��������/�������� �� %d ����� ������ %s",params[1],PlayerInfo[params[0]][pName]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	TogglePlayerControllable(params[0],1);
	return true;
}
CMD:changeint(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /changeint [ID ����]");
	SetPVarInt(playerid,"houseint",params[0]);
	new str[1024];
	for(new x = 0; x < sizeof ( Interiors ); x++)
    {
        strcat(str,Interiors[x][iName]), strcat(str,"\n");
        SPD(playerid, DIALOG_INT , DIALOG_STYLE_LIST, ""PREFIX" �������� �������� ����", str, "�������", "�����");
    }
	return true;
}
CMD:fwarn(playerid, params[])
{
	if(PlayerInfo[playerid][pLeader] == 0 && PlayerInfo[playerid][pZam] == 0 ) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"rs[32]",params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /fwarn [ID ������/���] [�������]");
	new fam = GetPlayerMember(params[0]);
	if(playerid == params[0]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� �� ������ ������ ������ ���� ��������!");
	if(GetPlayerMember(playerid) != fam) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� ������� � ����� �������!");
	if(PlayerInfo[playerid][pZam] > 0 && Fraction[PlayerInfo[playerid][pZam]][fZamVyg] == false) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����� �������� ������ �������� �������!");
	PlayerInfo[params[0]][pFW] ++;
	new string[128];
	format(string,sizeof(string),"����� %s[%d] ���(�) ������� %s[%d]. �������: %s",PlayerInfo[playerid][pName],playerid,PlayerInfo[params[0]][pName],params[0],params[1]);
	SendFractionMessage(COLOR_BLUE,string,fam);
	format(string,sizeof(string),"�� ���� ������� %s[%d]. �������: %s",PlayerInfo[params[0]][pName],params[0],params[1]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� �������� ������� �� %s[%d]. �������: %s",PlayerInfo[playerid][pName],playerid,params[1]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	if(PlayerInfo[params[0]][pFW] == 1) strmid(PlayerInfo[params[0]][pReason],params[1],0,64,255);
	else if(PlayerInfo[params[0]][pFW] == 2) strmid(PlayerInfo[params[0]][pReason1],params[1],0,64,255);
	if(PlayerInfo[params[0]][pFW] == 3)
	{
		PlayerInfo[params[0]][pRank] = 0;
		PlayerInfo[params[0]][pLeader] = 0;
		PlayerInfo[params[0]][pMember] = 0;
		SetPlayerSkin(params[0],1);
		PlayerInfo[params[0]][pSkin] = DEFAULTSKIN;
		PlayerInfo[params[0]][pSpawn] = 0;
		PlayerInfo[params[0]][pFW] = 0;
		PlayerInfo[params[0]][pReason] = 0;
		PlayerInfo[params[0]][pReason1] = 0;
	}
	return true;
}
CMD:unfwarn(playerid, params[])
{
	if(PlayerInfo[playerid][pLeader] == 0 && PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pZam] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"rs[32]",params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /unfwarn [ID ������/���] [�������]");
	new fam = GetPlayerMember(playerid);
	if(GetPlayerMember(params[0]) != fam) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� ������� � ����� �������!");
	if(PlayerInfo[params[0]][pFW] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ����� ������ ��� ���������!");
	if(PlayerInfo[playerid][pZam] > 0 && Fraction[PlayerInfo[playerid][pZam]][fZamUnVyg] == false) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����� �������� ������� �������� �������!");
	PlayerInfo[params[0]][pFW] --;
	new string[128];
	format(string,sizeof(string),"����� %s[%d] c���(�) ������� %s[%d]. �������: %s",PlayerInfo[playerid][pName],playerid,PlayerInfo[params[0]][pName],params[0],params[1]);
	SendFractionMessage(COLOR_BLUE,string,fam);
	format(string,sizeof(string),"�� ����� ������� %s[%d]. �������: %s",PlayerInfo[params[0]][pName],params[0],params[1]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"��� ����(a) ������� %s[%d]. �������: %s",PlayerInfo[playerid][pName],playerid,params[1]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	if(PlayerInfo[playerid][pFW] == 1) PlayerInfo[playerid][pReason1] = 0;
	else if(PlayerInfo[playerid][pFW] == 0) PlayerInfo[playerid][pReason] = 0;
	return true;
}
CMD:fmute(playerid, params[])
{
	if(PlayerInfo[playerid][pLeader] == 0 && PlayerInfo[playerid][pZam] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ris[32]",params[0],params[1],params[2])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /fmute [ID ������/���] [�����] [�������]");
	new fam = GetPlayerMember(playerid);
	if(PlayerInfo[params[0]][pMember] != fam) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� ������� � ����� �������!");
	if(PlayerInfo[playerid][pZam] > 0 && Fraction[PlayerInfo[playerid][pZam]][fZamMute] == false) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����� �������� ������ ���� ���� �������!");
	PlayerInfo[params[0]][pFMuteTime] += params[1]*60;
	new string[128];
	format(string,sizeof(string),"����� %s[%d] �������(�) %s[%d] �� %s. �������: %s",PlayerInfo[playerid][pName],playerid,PlayerInfo[params[0]][pName],params[0],nformat(params[1],"������","������","�����"),params[2]);
	SendFractionMessage(COLOR_BLUE,string,PlayerInfo[playerid][pLeader]);
	format(string,sizeof(string),"�� �������� %s[%d] �� %s. �������: %s",PlayerInfo[params[0]][pName],params[0],nformat(params[1],"������","������","�����"),params[2]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"��c �������(�) %s[%d] �� %s. �������: %s",PlayerInfo[playerid][pName],playerid,nformat(params[1],"������","������","�����"),params[2]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	fmute[params[0]] = true;
	return true;
}
CMD:unfmute(playerid, params[])
{
	if(PlayerInfo[playerid][pLeader] == 0 && PlayerInfo[playerid][pZam] == 0 ) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"rs[32]",params[0],params[2])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /unfmute [ID ������/���] [�������]");
	new fam = GetPlayerMember(playerid);
	if(PlayerInfo[params[0]][pMember] != fam) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� ������� � ����� �������!");
	if(PlayerInfo[params[0]][pFMuteTime] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ����� ������ ��� ���� ����!");
	if(PlayerInfo[playerid][pZam] > 0 && Fraction[PlayerInfo[playerid][pZam]][fZamUnMute] == false) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����� �������� c������ ���� ���� �������!");
	PlayerInfo[params[0]][pFMuteTime] = 0;
	new string[128];
	format(string,sizeof(string),"����� %s[%d] ����(�) � %s[%d] ��� ������������ ����. �������: %s",PlayerInfo[playerid][pName],playerid,PlayerInfo[params[0]][pName],params[0],params[2]);
	SendFractionMessage(COLOR_BLUE,string,PlayerInfo[playerid][pLeader]);
	format(string,sizeof(string),"�� ����� ��� ������������ ���� �  %s[%d]. �������: %s",PlayerInfo[params[0]][pName],params[0],params[2]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"��� ����(�) ��� ������������� ���� %s[%d]. �������: %s",PlayerInfo[playerid][pName],playerid,params[2]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	return true;
}
CMD:family(playerid, params[])
{
	if(PlayerInfo[playerid][pLeader] == 0 && PlayerInfo[playerid][pMember] == 0 && PlayerInfo[playerid][pZam] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(IsACop(playerid) || GetPlayerMember(playerid) == 4) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"s[144]",params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /f(amily) [�����]");
	if(PlayerInfo[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(PlayerInfo[playerid][pFMuteTime] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ��� ������������ ����!");
	new string[144],rank[12],fam = GetPlayerMember(playerid);
	if(IsIP(params[0]) || CheckString(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	switch(PlayerInfo[playerid][pRank])
	{
		case 1: strmid(rank, Fraction[fam][fRank1], 0, strlen(Fraction[fam][fRank1]), 255);
		case 2:	strmid(rank, Fraction[fam][fRank2], 0, strlen(Fraction[fam][fRank2]), 255);
		case 3: strmid(rank, Fraction[fam][fRank3], 0, strlen(Fraction[fam][fRank3]), 255);
		case 4: strmid(rank, Fraction[fam][fRank4], 0, strlen(Fraction[fam][fRank4]), 255);
		case 5: strmid(rank, Fraction[fam][fRank5], 0, strlen(Fraction[fam][fRank5]), 255);
		case 6: strmid(rank, Fraction[fam][fRank6], 0, strlen(Fraction[fam][fRank6]), 255);
	}
	format(string,sizeof(string),"%s %s[%d]: %s",rank,PlayerInfo[playerid][pName],playerid,params[0]);
	SendFractionMessage(COLOR_BLUE,string,fam);
	return true;
}
ALT:family:f;
CMD:givegun(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"rii",params[0],params[1],params[2])) { ShowModelSelectionMenu(playerid, menu1, "menu1", 0x4A5A6BBB, 0xFFFF00AA, 0x88888899); SetPVarInt(playerid,"givegun",1); }
	else
	{
		ServerGivePlayerWeapon(params[0],params[1],params[2]);
		new string[144],name[32];
		GetWeaponName(params[1],name,sizeof(name));
		format(string,sizeof(string),"�� ���� %s[%d] %s(ID: %d]",PlayerInfo[params[0]][pName],params[0],name,params[1]);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	}
	return true;
}
CMD:sethp(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ri",params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /sethp [ID ������/���] [���-�� ��������]");
	ServerSetPlayerHealth(params[0],params[1]);
	new string[128];
	format(string,sizeof(string),"�� ���� %s[%d] %d ��������",PlayerInfo[params[0]][pName],params[0],params[1]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	if(params[1] == 0) TimeOfDeath[params[0]] = true;
	return true;
}
CMD:setarmor(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ri",params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /setarmor [ID ������/���] [���-�� �����]");
	ServerSetPlayerArmour(params[0],params[1]);
	new string[128];
	format(string,sizeof(string),"�� ���� %s[%d] %d �����",PlayerInfo[params[0]][pName],params[0],params[1]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	return true;
}
CMD:dm(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ri",params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /dm [ID ������/���] [ID ������]");
	ServerGivePlayerWeapon(params[0],params[1],9999);
	ServerSetPlayerHealth(params[0],160);
	ServerSetPlayerArmour(params[0],160);
	return true;
}
CMD:bail(playerid, params[]) {
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /bail [ID ������/���]");
	if(PlayerInfo[params[0]][pJailed] != 1) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ���� ����� �� � ������!");
	new cost = PlayerInfo[params[0]][pJailTime]*100;
	if(cost > GetMoney(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ������������ �����!");
	SetMoney(playerid, -cost);
	new string[128];
	format(string, sizeof(string), "�� ��������� ����� �� %s[%d] � �������: %d$", PlayerInfo[params[0]][pName], params[0], cost);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), "�� ��� �������� ����� %s[%d] � �������: %d$", PlayerInfo[playerid][pName], playerid, cost);
	SendClientMessage(params[0], COLOR_LIGHTBLUE, string);
	return true;
}
CMD:setskin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ri",params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /setskin [ID ������/���] [ID �����]");
	SetPlayerSkin(params[0],params[1]);
	TogglePlayerControllable(params[0],1);
	PlayerInfo[params[0]][pSkin] = params[1];
	return true;
}
CMD:pm(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] == 0 && PlayerInfo[playerid][pExp] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� ���� ����� ���������� ������ ��������� ��� ����� 1 �������.");
	if(sscanf(params,"rs[144]",params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /pm [ID ������/���] [C��������]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����!");
	if(togpm[params[0]] == true && PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ����� ������ �������� ����� ������ ���������!");
	new string[128],log[144];
	if(IsIP(params[0]) || CheckString(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	format(string,sizeof(string),"PM �� %s[%d]: %s",PlayerInfo[playerid][pName],playerid,params[1]);
	SendClientMessage(params[0],COLOR_YELLOW,string);
	PlayerPlaySound(params[0], 1085, 0.0, 0.0, 10.0);
	format(string,sizeof(string),"PM � %s[%d]: %s",PlayerInfo[params[0]][pName],params[0],params[1]);
	SendClientMessage(playerid,COLOR_ORANGE,string);
	format(log,sizeof(log),"PM �� %s[%d] � %s[%d]: %s",PlayerInfo[playerid][pName],playerid,PlayerInfo[params[0]][pName],params[0],params[1]);
	WriteLog("PmLog",log);
	SendAPMMessage(COLOR_ORANGE,log);
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 10.0);
	return true;
}
CMD:a(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pHelper] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
    if(sscanf(params, "s[144]", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /a [���������]");
	new string[128];
	format(string,144,"%s %s[%d]: %s",NameAdmin(playerid),PlayerInfo[playerid][pName],playerid,params[0]);
	SendAMessage(COLOR_LIGHTGREEN,string);
	return true;
}
CMD:ad(playerid, params[])
{
	new string[128];
	if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
    if(sscanf(params, "s[144]", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /ad [���������]");
	format(string,sizeof(string),"{B20A0A}MAF:{FFFFFF} ��������� ��������� �� ������� ��������� ����� "GRN"%s{FFFFFF}",nformat(aad,"�������","�������","������"));
	if(aad > 0) return SendClientMessage(playerid,-1,string);
	if(CapsLockCheck(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ����� ��������� ������� ����� ��������� ����!");
	format(string,sizeof(string),"{2A6815}[�������]{FFFFFF} %s. �� "YE"%s[%d]"WHT"",params[0],PlayerInfo[playerid][pName],playerid);
	SendClientMessageToAll(-1,string);
	format(string, sizeof(string), "%s �� s[%d]", params[0], PlayerInfo[playerid][pName],playerid);
	WriteLog("AdvertiseLog",string);
	SetMoney(playerid,-10);
	aad = 30;
	return true;
}
CMD:addkfc(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid,1,"{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	mysql_query("SELECT NULL FROM `KFC`");
    mysql_store_result();
	new idx = mysql_num_rows();
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x, y, z);
	KFC[idx+1][kID] = idx+1;
	KFC[idx+1][kX] = x;
	KFC[idx+1][kY] = y;
	KFC[idx+1][kZ] = z;
	CreatePickupWithText(1582, 1, 0xFFFFFFFF, x, y, z,"���������� Alpino:",0,1);
    new query[512];
    format(query,512,"INSERT INTO `KFC` (id,x,y,z) VALUES ('%i',%f,%f,%f)",idx+1,KFC[idx+1][kX],KFC[idx+1][kY],KFC[idx+1][kZ]);
    mysql_free_result();
    mysql_query(query);
	return true;
}
CMD:setvw(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ri",params[0],params[1])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /setvw [ID ������/���] [����� ����.����] ");
	SetPlayerVirtualWorld(playerid,params[1]);
	return true;
}
CMD:getvw(playerid, params[])
{
	new string[15];
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
    format(string,sizeof(string),"���� ��� : %d",GetPlayerVirtualWorld(playerid));
	SendClientMessage(playerid,-1,string);
	return true;
}
CMD:apm(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(apm[playerid] == false)  { SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� �������� ����� �� �������"); apm[playerid] = true; }
	else { apm[playerid] = false; SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� ����� �� �������"); }
	return true;
}
CMD:sc(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	for(new veh=0; veh<MAX_VEHICLES; veh++) 
	{
		if(!IsVehicleOccupied(veh)) {
			SetVehicleToRespawn(veh);
			ToggleEngine(veh,VEHICLE_PARAMS_OFF);
		}
	}	
	SendClientMessageToAll(COLOR_LIGHTBLUE,"Alpino:  ��������� ��� ���������� �������������� �������");
    return true;
}
CMD:delivery(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != 2) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF}  �� �� ��������� ��������������!");
    if(!IsPlayerInRangeOfPoint(playerid,10.0,-113.7627,-326.2541,1.4297)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF}  �� �� ���������� �� ����� �������� �����!");
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 514) return  SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF}  �� �� � ������� ����!");
    if(GetPVarInt(playerid,"Gruz") != 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF}  � ���� ��� ���� ����!");
	DestroyDynamicCP(cpdeliv[playerid]);
	cpdeliv[playerid] = -1;
    SendClientMessage(playerid,-1,""INFO"������� ���� � ������ ��� �� ����� ���������� �� �����.");
    pricep[playerid] = CreateVehicle(435,-113.7627,-326.2541,1.4297,180.0208,1,1,600);
    SetPVarInt(playerid,"Gruz",1);
    switch(random(7))
    {
        case 0: {gruzcp[playerid] = CreateDynamicCP(-1888.3518,-1729.9679,21.4561,7.0,-1,-1,playerid,1000000); DB[playerid] = CreateDynamic3DTextLabel("{FFA54F}����: {FFC1C1}��������", -1, 0.00, 0.00, 0.0, 100.0, INVALID_PLAYER_ID, pricep[playerid], 0, -1, -1, -1, 15.0);}
        case 1: {gruzcp[playerid] = CreateDynamicCP(828.0614,854.6743,12.6972,7.0,-1,-1,playerid,1000000); DB[playerid] = CreateDynamic3DTextLabel("{FFA54F}����: {FFC1C1}��������", -1, 0.00, 0.00, 0.0, 100.0, INVALID_PLAYER_ID, pricep[playerid], 0, -1, -1, -1, 15.0);}
        case 2: {gruzcp[playerid] = CreateDynamicCP(2493.7378,2772.9478,10.5368,7.0,-1,-1,playerid,1000000); DB[playerid] = CreateDynamic3DTextLabel("{FFA54F}����: {FFC1C1}��������", -1, 0.00, 0.00, 0.0, 100.0, INVALID_PLAYER_ID, pricep[playerid], 0, -1, -1, -1, 15.0);}
        case 3: {gruzcp[playerid] = CreateDynamicCP(2467.7561,1948.0699,9.9756,7.0,-1,-1,playerid,1000000); DB[playerid] = CreateDynamic3DTextLabel("{FFA54F}����: {FFC1C1}������", -1, 0.00, 0.00, 0.0, 100.0, INVALID_PLAYER_ID, pricep[playerid], 0, -1, -1, -1, 15.0);}
        case 4: {gruzcp[playerid] = CreateDynamicCP(2792.6357,-2475.4504,13.3700,7.0,-1,-10,playerid,1000000); DB[playerid] = CreateDynamic3DTextLabel("{FFA54F}����: {FFC1C1}�������������''", -1, 0.00, 0.00, 0.0, 100.0, INVALID_PLAYER_ID, pricep[playerid], 0, -1, -1, -1, 15.0);}
        case 5: {gruzcp[playerid] = CreateDynamicCP(501.2822,-1356.1147,15.8554,7.0,-1,-1,playerid,1000000); DB[playerid] = CreateDynamic3DTextLabel("{FFA54F}����: {FFC1C1}�������", -1, 0.00, 0.00, 0.0, 100.0, INVALID_PLAYER_ID, pricep[playerid], 0, -1, -1, -1, 15.0);}
        case 6: {gruzcp[playerid] = CreateDynamicCP(-2102.5251,208.3739,35.0051,7.0,-1,-1,playerid,1000000); DB[playerid] = CreateDynamic3DTextLabel("{FFA54F}����: {FFC1C1}������������", -1, 0.00, 0.00, 0.0, 100.0, INVALID_PLAYER_ID, pricep[playerid], 0, -1, -1, -1, 15.0);}
    }
    return true ;
}
CMD:faq(playerid, params[]) return SPD(playerid,DIALOG_KPK_FAQ,DIALOG_STYLE_LIST,""PREFIX" FAQ","{3CBBF7}[1]{FFFFFF}\t��� ������� LvL(�������) � EXP\n{3CBBF7}[2]{FFFFFF}\t���������� � �������","�����","������");
CMD:kpk(playerid, params[])
{
	ShowKpk(playerid);
	new string[128];
	if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"%s ������(�) ���� ���",PlayerInfo[playerid][pName]);
	else format(string,sizeof(string),"����������� ������(�) ���� ���");
	SendRadiusMessage(5.0, playerid, string,COLOR_PURPLE);
	return true;
}
CMD:addgas(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	mysql_query("SELECT NULL FROM `Gas`");
	mysql_store_result();
	new i = mysql_num_rows();
	mysql_free_result();
	GetPlayerPos(playerid,Gas[i+1][gX] ,Gas[i+1][gY],Gas[i+1][gZ]);
	Gas[i+1][gID] = i+1;
	CreateDynamicMapIcon(Gas[i+1][gX],Gas[i+1][gY], Gas[i+1][gZ], 55, COLOR_WHITE, 0, -1, -1, 400.0);
	new query[512];
	format(query,sizeof(query), "INSERT INTO `Gas` (id, x, y, z, price80, price92, price95, pricedisel, k80, k92,k95, disel) VALUES (%i, %f, %f, %f, 0, 0, 0, 0, 0, 0, 0, 0)",i+1,Gas[i+1][gX], Gas[i+1][gY],Gas[i+1][gZ]);
	mysql_query(query);
	SendClientMessage(playerid,-1,"{FFFFFF}�������� {147130}�������{FFFFFF} ���������.");
	return true;
}
CMD:addgasp(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /addgasp [ID ��������]");
	new id = params[0];
	GetPlayerPos(playerid, Gas[id][Pos][0], Gas[id][Pos][1], Gas[id][Pos][2]);
	CreateDynamicPickup(1650, 1, Gas[id][Pos][0], Gas[id][Pos][1], Gas[id][Pos][2], -1, -1, -1, 100.0);
	new gastext[512];
	format(gastext,sizeof(gastext),""PURP"ID:\t"YE"%d\n"PURP"����:\t"YE"%d\n"PURP"�������:\t"YE"%d",id,Gas[id][gPrice],Gas[id][gLevel]);
	Gas[id][gLabel] = Create3DTextLabel(gastext,0x008080FF,Gas[id][Pos][0], Gas[id][Pos][1], Gas[id][Pos][2],40.0,0);
	SendClientMessage(playerid, -1, "������� ��� ������ ������� ���������!");
	return true;
}	
CMD:addmagazin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	mysql_query("SELECT NULL FROM `Magazin`");
    mysql_store_result();
	new magazin[512],i = mysql_num_rows();
	GetPlayerPos(playerid,Magazin[i+1][mEnterX],Magazin[i+1][mEnterY],Magazin[i+1][mEnterZ]);
	Magazin[i+1][mID] = i+1;
	Magazin[i+1][mExitX] = 6.0451;
	Magazin[i+1][mExitY] = -31.7674;
	Magazin[i+1][mExitZ] = 1003.5494;
	Magazin[i+1][mBuyX] = 1.7647;
	Magazin[i+1][mBuyY] = -28.8278;
	Magazin[i+1][mBuyZ] = 1003.5494;
	Magazin[i+1][mInterior] = 10;
	CreateDynamicMapIcon(Magazin[i+1][mEnterX], Magazin[i+1][mEnterY], Magazin[i+1][mEnterZ], 17, COLOR_WHITE, 0, -1, -1, 400.0);
	new query[512];
	format(query,sizeof(query), "INSERT INTO `Magazin` (ID, EnterX, EnterY, EnterZ, ExitX, ExitY, ExitZ, BuyX, BuyY, BuyZ, Owner, Owned, Level, Price, Bank, Interior, Locked) VALUES (%i, %f, %f, %f, 6.0451, -31.7674, 1003.5494, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0)",i+1,Magazin[i+1][mEnterX], Magazin[i+1][mEnterY],Magazin[i+1][mEnterZ]);
	mysql_free_result();
	mysql_query(query);
	AddStaticPickup(1274, 1, Magazin[i+1][mEnterX], Magazin[i+1][mEnterY], Magazin[i+1][mEnterZ]);
	format(magazin,sizeof(magazin),"{FF0000}** ������� ��������! **\n{E86B17}ID: {10B8DE}%d\n{E86B17}����: {10B8DE}%d\n{E86B17}�������: {10B8DE}%d",i+1,Magazin[i+1][mPrice],Magazin[i+1][mLevel]);
	Magazin[i+1][mLabel] = Create3DTextLabel(magazin,0x008080FF,Magazin[i+1][mEnterX],Magazin[i+1][mEnterY],Magazin[i+1][mEnterZ],15.0,0,1);
	CreateDynamicCP(Magazin[i+1][mExitX],Magazin[i+1][mExitY],Magazin[i+1][mExitZ],1,Magazin[i+1][mID],Magazin[i+1][mInterior],-1,2.0);
	CreateDynamicCP(Magazin[i+1][mEnterX],Magazin[i+1][mEnterY],Magazin[i+1][mEnterZ],1,0,0,-1,5.0);
	SendClientMessage(playerid,-1,"{FFFFFF}������� {147130}�������{FFFFFF} ��������.");
	return true;
}
CMD:addclub(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	mysql_query("SELECT NULL FROM `Club`");
	mysql_store_result();
	new club[512], i = mysql_num_rows();
	GetPlayerPos(playerid,Club[i+1][cEnterX],Club[i+1][cEnterY],Club[i+1][cEnterZ]);
	Club[i+1][cID] = i+1;
	Club[i+1][cExitX] = 493.4382;
	Club[i+1][cExitY] = -24.9177;
	Club[i+1][cExitZ] = 1000.6719;
	Club[i+1][cBuyX] = 499.8173;
	Club[i+1][cBuyY] = -18.6962;
	Club[i+1][cBuyZ] = 1000.6719;
	Club[i+1][cInterior] = 17;
	new query[512];
	format(query,sizeof(query), "INSERT INTO `Club` (ID, EnterX, EnterY, EnterZ, ExitX, ExitY, ExitZ, BuyX, BuyY, BuyZ, Owner, Owned, Level, Price, Bank, Interior, Locked, PriceVx) VALUES (%i, %f, %f, %f, 493.4382, -24.9177, 1000.6719, 499.8173, -18.6962, 1000.6719, 0, 0, 0, 0, 0, 17, 0, 0)",i+1,Magazin[i+1][mEnterX], Magazin[i+1][mEnterY],Magazin[i+1][mEnterZ]);
	mysql_free_result();
	mysql_query(query);
	CreateDynamicMapIcon(Club[i+1][cEnterX], Club[i+1][cEnterY], Club[i+1][cEnterZ], 48, COLOR_WHITE, 0, -1, -1, 400.0);
	CreateDynamicPickup(1274, 1, Club[i+1][cEnterX], Club[i+1][cEnterY], Club[i+1][cEnterZ],-1,-1,-1,100.0);
	format(club,sizeof(club),"{FF0000}** ��������� ��������! **\n{E86B17}ID: {10B8DE}%d\n{E86B17}����: {10B8DE}%d\n{E86B17}�������: {10B8DE}%d",i+1,Club[i+1][cPrice],Club[i+1][cLevel]);
	Club[i+1][cLabel] = Create3DTextLabel(club,0x008080FF,Club[i+1][cEnterX],Club[i+1][cEnterY],Club[i+1][cEnterZ],15.0,0,1);
	CreateDynamicCP(Club[i+1][cExitX],Club[i+1][cExitY],Club[i+1][cExitY],1,Club[i+1][cID],Club[i+1][cInterior],-1,2.0);
	CreateDynamicCP(Club[i+1][cEnterX],Club[i+1][cEnterY],Club[i+1][cEnterZ],1,0,0,-1,5.0);
	SendClientMessage(playerid,-1,"{FFFFFF}��������� {147130}�������{FFFFFF} ���������.");
	return true;
}
CMD:addammo(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	mysql_query("SELECT NULL FROM `Ammo`");
	mysql_store_result();
	new ammotext[512], i = mysql_num_rows();
	GetPlayerPos(playerid,Ammo[i+1][amEnterX],Ammo[i+1][amEnterY],Ammo[i+1][amEnterZ]);
	Ammo[i+1][amID] = i+1;
	Ammo[i+1][amExitX] = 296.919982;
	Ammo[i+1][amExitY] = -108.071998;
	Ammo[i+1][amExitZ] = 1001.515625;
	Ammo[i+1][amExitX] = 296.8368;
	Ammo[i+1][amExitY] = -112.0711;
	Ammo[i+1][amExitZ] = 1001.5156;
	Ammo[i+1][amBuyX] = 290.0421;
	Ammo[i+1][amBuyY] = -109.7818;
	Ammo[i+1][amBuyZ] = 1001.5156;
	Ammo[i+1][amInterior] = 6;
	CreateDynamicMapIcon(Ammo[i+1][amEnterX], Ammo[i+1][amEnterY], Ammo[i+1][amEnterZ], 18, COLOR_WHITE, 0, -1, -1, 400.0);
	new query[512];
	format(query,sizeof(query), "INSERT INTO `Ammo` (ID, EnterX, EnterY, EnterZ, ExitX, ExitY, ExitZ, BuyX, BuyY, BuyZ, Owner, Owned, Level, Price, Bank, Interior, Locked, Vxod) VALUES (%i, %f, %f, %f, %f, %f, %f, %f, %f, %f, 0, 0, 0, 0, 0, 6, 0, 100)",i+1,Ammo[i+1][amEnterX], Ammo[i+1][amEnterY],Ammo[i+1][amEnterZ],Ammo[i+1][amExitX],Ammo[i+1][amExitY],Ammo[i+1][amExitZ],Ammo[i+1][amBuyX],Ammo[i+1][amBuyY],Ammo[i+1][amBuyZ]);
	mysql_free_result();
	mysql_query(query);
	AddStaticPickup(1274, 1, Ammo[i+1][amEnterX], Ammo[i+1][amEnterY], Ammo[i+1][amEnterZ]);
	format(ammotext,sizeof(ammotext),"{FF0000}** ��������� ��������! **\n{E86B17}ID: {10B8DE}%d\n{E86B17}����: {10B8DE}%d\n{E86B17}�������: {10B8DE}%d",i+1,Ammo[i+1][amPrice],Ammo[i+1][amLevel]);
	Ammo[i+1][amLabel] = Create3DTextLabel(ammotext,0x008080FF,Ammo[i+1][amEnterX],Ammo[i+1][amEnterY],Ammo[i+1][amEnterZ],15.0,0,1);
	CreateDynamicCP(Ammo[i+1][amExitX],Ammo[i+1][amExitY],Ammo[i+1][amExitZ],1,Ammo[i+1][amID],Ammo[i+1][amInterior],-1,2.0);
	CreateDynamicCP(Ammo[i+1][amEnterX],Ammo[i+1][amEnterY],Ammo[i+1][amEnterZ],1,0,0,-1,5.0);
	SendClientMessage(playerid,-1,"{FFFFFF}��������� {147130}�������{FFFFFF} ���������.");
	return true;
}
CMD:buygas(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		for(new g = 0; g < sizeof(Gas); g++)
		{
			if(IsPlayerInRangeOfPoint(playerid,2.0, Gas[g][gX], Gas[g][gY], Gas[g][gZ]) && Gas[g][gOwned] == false)
			{
				if(PlayerInfo[playerid][pFuel] > 0) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} � ��� ��� ���� ��������!");
				if(PlayerInfo[playerid][pLevel] < Gas[g][gLevel]) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} ��� ������� ������� ��� ��� ������� ���� ��������!");
				if(GetMoney(playerid) < Gas[g][gPrice]) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} � ��� ��������� ����� �� ������� ��������!");
				PlayerInfo[playerid][pFuel] = g;
				Gas[g][gOwned] = true;
				strmid(Gas[g][gOwner], PlayerInfo[playerid][pName], 0, strlen(PlayerInfo[playerid][pName]), 255);
				SetMoney(playerid,-Gas[g][gPrice]);
				SendClientMessage(playerid, COLOR_WHITE, "�����������! �� ������ ��������.");
				UpdateGasText(g);
				SaveGas(g);
				return true;
			}
		}
	}
	return true;
}
CMD:buyclub(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		for(new c = 1; c < sizeof(Club);c++)
		{
			if(IsPlayerInRangeOfPoint(playerid,2.0, Club[c][cEnterX], Club[c][cEnterY], Club[c][cEnterZ]) && Club[c][cOwned] == false)
			{
				if(PlayerInfo[playerid][pClub] > 0) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} � ��� ��� ���� ���������!");
				if(PlayerInfo[playerid][pLevel] < Club[c][cLevel]) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} ��� ������� ������� ��� ��� ������� ����� ���������!");
				if(GetMoney(playerid) < Club[c][cPrice]) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} � ��� ��������� ����� �� ������� ����� ���������!");
				PlayerInfo[playerid][pClub] = c;
				Club[c][cOwned] = true;
				strmid(Club[c][cOwner], PlayerInfo[playerid][pName], 0, strlen(PlayerInfo[playerid][pName]), 255);
				SetMoney(playerid,-Club[c][cPrice]);
				SendClientMessage(playerid, COLOR_WHITE, "�����������! �� ������ ���������.");
				UpdateClubText(c);
				SaveClub(c);
				return true;
			}
		}
	}
	return true;
}
CMD:asellclub(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /asellclub [ID ���������]");
	new query[128];
	format(query, sizeof(query), "UPDATE `Accounts` SET Club = 0 WHERE Nickname = '%s'", Club[params[0]][cOwner]);
	mysql_query(query);
	Club[params[0]][cOwned] = false;
	strmid(Club[params[0]][cOwner], "The State", 0, strlen("The State"), 255);
	SendClientMessage(playerid,-1,"{FFFFFF}��������� {147130}�������{FFFFFF} �������!");
	SaveClub(params[0]);
	UpdateClubText(params[0]);
	return true;
}
CMD:sellclub(playerid, params[])
{
	new club = PlayerInfo[playerid][pClub];
	if(club == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ��� ���������!");
	Club[club][cOwned] = false;
	strmid(Club[club][cOwner], "The State", 0, strlen("The State"), 255);
	SendClientMessage(playerid,-1,"{FFFFFF}��������� {147130}�������{FFFFFF} �������!");
	SaveClub(club);
	UpdateClubText(club);
	PlayerInfo[playerid][pClub] = 0;
	return true;
}
CMD:buyammo(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		for(new z = 1; z < sizeof(Ammo);z++)
		{
			if(IsPlayerInRangeOfPoint(playerid,2.0, Ammo[z][amEnterX], Ammo[z][amEnterY], Ammo[z][amEnterZ]) && Ammo[z][amOwned] == false)
			{
				if(PlayerInfo[playerid][pAmmo] > 0) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} � ��� ��� ���� ���������!");
				if(PlayerInfo[playerid][pLevel] < Ammo[z][amLevel]) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} ��� ������� ������� ��� ��� ������� ���� ���������!");
				if(GetMoney(playerid) < Ammo[z][amPrice]) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} � ��� ��������� ����� �� ������� ���������!");
				PlayerInfo[playerid][pAmmo] = z;
				Ammo[z][amOwned] = true;
				strmid(Ammo[z][amOwner], PlayerInfo[playerid][pName], 0, strlen(PlayerInfo[playerid][pName]), 255);
				SetMoney(playerid,-Ammo[z][amPrice]);
				SendClientMessage(playerid, COLOR_WHITE, "�����������! �� ������ ���������.");
				UpdateAmmoText(z);
				SaveAmmo(z);
				return true;
			}
		}
	}
	return true;
}
CMD:asellammo(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /asellammo [ID ����]");
	new query[128];
	format(query, sizeof(query), "UPDATE `Accounts` SET Ammo = 0 WHERE Nickname = '%s'", Ammo[params[0]][amOwner]);
	mysql_query(query);
	Ammo[params[0]][amOwned] = false;
	strmid(Ammo[params[0]][amOwner], "The State", 0, strlen("The State"), 255);
	SendClientMessage(playerid,-1,"{FFFFFF}��������� {147130}�������{FFFFFF} �������!");
	SaveAmmo(params[0]);
	UpdateAmmoText(params[0]);
	return true;
}
CMD:sellammo(playerid, params[])
{
	new ammo = PlayerInfo[playerid][pAmmo];
	if(ammo == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ��� ���������!");
	Ammo[ammo][amOwned] = false;
	strmid(Ammo[ammo][amOwner], "The State", 0, strlen("The State"), 255);
	SendClientMessage(playerid,-1,"{FFFFFF}��������� {147130}�������{FFFFFF} �������!");
	SaveAmmo(ammo);
	UpdateAmmoText(ammo);
	PlayerInfo[playerid][pAmmo] = 0;
	return true;
}
CMD:buyshop(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		for(new z = 1; z < sizeof(Magazin);z++)
		{
			if(IsPlayerInRangeOfPoint(playerid,2.0, Magazin[z][mEnterX], Magazin[z][mEnterY], Magazin[z][mEnterZ]) && Magazin[z][mOwned] == false)
			{
				if(PlayerInfo[playerid][pMagazin] > 0) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} � ��� ��� ���� �������!");
				if(PlayerInfo[playerid][pLevel] < Magazin[z][mLevel]) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} ��� ������� ������� ��� ��� ������� ����� ��������!");
				if(GetMoney(playerid) < Magazin[z][mPrice]) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} � ��� ��������� ����� �� ������� ��������!");
				PlayerInfo[playerid][pMagazin] = z;
				Magazin[z][mOwned] = true;
				strmid(Magazin[z][mOwner], PlayerInfo[playerid][pName], 0, strlen(PlayerInfo[playerid][pName]), 255);
				SetMoney(playerid,-Magazin[z][mPrice]);
				SendClientMessage(playerid, COLOR_WHITE, "�����������! �� ������ �������.");
				UpdateMagazinText(z);
				SaveMagazin(z);
				return true;
			}
		}
	}
	return true;
}
CMD:asellshop(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /asellshop [ID ��������]");
	new query[128];
	format(query, sizeof(query), "UPDATE `Accounts` SET Magazin = 0 WHERE Nickname = '%s'", Magazin[params[0]][mOwner]);
	mysql_query(query);
	Magazin[params[0]][mOwned] = false;
	strmid(Magazin[params[0]][mOwner], "The State", 0, strlen("The State"), 255);
	SendClientMessage(playerid,-1,"{FFFFFF}��������� {147130}�������{FFFFFF} �������!");
	SaveMagazin(params[0]);
	UpdateMagazinText(params[0]);
	return true;
}
CMD:sellshop(playerid, params[])
{
	new magaz4ik = PlayerInfo[playerid][pMagazin];
	if(magaz4ik == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ��� ��������!");
	Magazin[magaz4ik][mOwned] = false;
	strmid(Magazin[magaz4ik][mOwner], "The State", 0, strlen("The State"), 255);
	SendClientMessage(playerid,-1,"{FFFFFF}������� {147130}�������{FFFFFF} ������!");
	SaveMagazin(magaz4ik);
	UpdateMagazinText(magaz4ik);
	PlayerInfo[playerid][pMagazin] = 0;
	return true;
}
CMD:asellgas(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /asellgas [ID ��������]");
	new query[128];
	format(query, sizeof(query), "UPDATE `Accounts` SET Fuel = 0 WHERE Nickname = '%s'", Gas[params[0]][gOwner]);
	mysql_query(query);
	Gas[params[0]][gOwned] = false;
	strmid(Gas[params[0]][gOwner], "The State", 0, strlen("The State"), 255);
	SendClientMessage(playerid,-1,"{FFFFFF}�������� {147130}�������{FFFFFF} �������!");
	SaveGas(params[0]);
	UpdateGasText(params[0]);
	return true;
}
CMD:sellgas(playerid, params[])
{
	new gas = PlayerInfo[playerid][pFuel];
	if(gas == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ��� ��������!");
	Gas[gas][gOwned] = false;
	strmid(Gas[gas][gOwner], "The State", 0, strlen("The State"), 255);
	SendClientMessage(playerid,-1,"{FFFFFF}�������� {147130}�������{FFFFFF} �������!");
	SaveGas(gas);
	UpdateGasText(gas);
	PlayerInfo[playerid][pFuel] = 0;
	return true;
}
CMD:setprice(playerid, params[])
{
	new string[256],gas = PlayerInfo[playerid][pFuel];
	SetPVarInt(playerid,"pricefuel",gas);
	if(PlayerInfo[playerid][pFuel] == 0) return SendClientMessage(playerid, COLOR_WHITE, "{F31212}[������]{FFFFFF} � ��� ��� ��������!");
	format(string,sizeof(string),"{FFFFFF}A-80\t{17D6E0}[%d$]{FFFFFF}\nA-92\t{17D6E0}[%d]{FFFFFF}\nA-95\t{17D6E0}[%d]{FFFFFF}\nA-98\t{17D6E0}[%d]{FFFFFF}",Gas[gas][gPrice80],Gas[gas][gPrice92],Gas[gas][gPrice95],Gas[gas][gPriceDisel]);
	SPD(playerid,DIALOG_PRICE,DIALOG_STYLE_LIST,""PREFIX" ���������� ���� �� ������",string,"�������","������");
	return true;
}
CMD:addjob(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new jobname[32],Float:Px,Float:Py,Float:Pz,jobtext[255];
	if(sscanf(params,"s[32]i",jobname,params[1])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /addjob [��������] [������� ������]");
	GetPlayerPos(playerid,Px,Py,Pz);
	mysql_query("SELECT NULL FROM `Job`");
	mysql_store_result();
	new i = mysql_num_rows();
	mysql_free_result();
	Job[i+1][jX] = Px;
	Job[i+1][jY] = Py;
	Job[i+1][jZ] = Pz;
	Job[i+1][jID] = i+1;
	Job[i+1][jLevel] = params[1];
	strmid(Job[i+1][jName], jobname, 0, strlen(jobname), 255);
	new query[512];
	format(query,sizeof(query), "INSERT INTO `Job` (id, x, y, z, name, level) VALUES (%i, %f, %f, %f, '%s', %d)",i+1,Job[i+1][jX],Job[i+1][jY],Job[i+1][jZ],jobname,params[1]);
	mysql_query(query);
	format(jobtext,sizeof(jobtext),"{BC6717}������:{FFFFFF} %s | {BC6717}����������� �������:{FFFFFF} %d | ����� ���������: {BC6717}ALT{FFFFFF}",Job[i+1][jName],Job[i+1][jLevel]);
	CreatePickupWithText(1239, 1, 0xFFFFFFFF, Job[i+1][jX], Job[i+1][jY], Job[i+1][jZ],jobtext,0,1);
	return true;
}
CMD:addmicon(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new Float:Px,Float:Py,Float:Pz;
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /addmicon [id ������]");
	GetPlayerPos(playerid,Px,Py,Pz);
	mysql_query("SELECT NULL FROM `MIcon`");
	mysql_store_result();
	new i = mysql_num_rows();
	mysql_free_result();
	MIcon[i+1][miX] = Px;
	MIcon[i+1][miY] = Py;
	MIcon[i+1][miZ] = Pz;
	MIcon[i+1][miID] = i+1;
	MIcon[i+1][miIkonka] = params[0];
	new query[512];
	format(query,sizeof(query), "INSERT INTO `MIcon` (id, x, y, z, ikonka) VALUES (%i, %f, %f, %f, %i)",i+1,MIcon[i+1][miX],MIcon[i+1][miY],MIcon[i+1][miZ],MIcon[i+1][miIkonka]);
	CreateDynamicMapIcon(MIcon[i+1][miX],MIcon[i+1][miY],MIcon[i+1][miZ],MIcon[i+1][miIkonka],0,-1,-1,-1,300);
	mysql_query(query);
	return true;
}
CMD:makegun(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] != 1) return  SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	SPD(playerid,DIALOG_MAKEGUN,DIALOG_STYLE_LIST,""PREFIX" C������ ������","{D37018}Desert Eagle:{FFFFFF}\t150 ����������\n{D37018}MP-5:{FFFFFF}\t300 ����������\n{D37018}ShotGun:{FFFFFF}\t400 ����������\n{D37018}M-4:{FFFFFF}\t500 ����������\n{D37018}AK-47:{FFFFFF}\t500 ����������","�������","������");
	return true;
}
CMD:cstrips(playerid,params[])
{
    if(!IsACop(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
    if(PlayerInfo[playerid][pRank] < 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� ������� � ���� ������� ����� 3 ����!");
    if(GetPVarInt(playerid,"Strips") == 1) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} �� ��� ������� ����, ������� ������ ������� ''/dstrips''!");
    new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
    GetPlayerPos(playerid, plocx, plocy, plocz);
    GetPlayerFacingAngle(playerid,ploca);
    CreateStrip(plocx,plocy,plocz,ploca);
    SetPVarInt(playerid,"Strips",1);
    return true;
}
CMD:dstrips(playerid,params[])
{
	if(!IsACop(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
 	if(GetPVarInt(playerid,"Strips") == 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} �� �� ��������� ����, ������� �� ����� � ������� ������� ''/�strips''!");
	DeleteClosestStrip(playerid);
	return true;
}
CMD:dallstrips(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] != 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	DeleteAllStrip();
	return true;
}
CMD:suspect(playerid, params[])
{
	if(!IsACop(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ris[32]",params[0],params[1],params[2])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /su(spect) [�� ������/���] [�� ������� ��������� ������] [������������]");
	if(IsIP(params[0]) || CheckString(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(GetPlayerWantedLevel(params[0]) == 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ������ ������������ ������� �������!");
	if(GetPlayerWantedLevel(params[0])+params[1] > 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ 6 ���� ���� ������!");
	if(IsACop(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ���������� ������ ���� ������!");
	if(playerid == params[0]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ���� ������ ������ ����!");
	PlayerInfo[params[0]][pWanted] += params[1];
	SetPlayerWantedLevel(params[0], PlayerInfo[params[0]][pWanted]);
	PlayCrimeReportForPlayer(params[0], 0, 13);
	new string[144],fam = GetPlayerMember(playerid);
	if(fam == 1 || fam == 3)
	{
		format(string,sizeof(string),"{FFFFFF}�� ��������� ������������: {0D849B}%s{FFFFFF}. ������ �������� ��������� {0D849B}%s: %s[%d] �� %s{FFFFFF}",params[2],Fraction[fam][fName],PlayerInfo[playerid][pName],playerid,nformat(params[1],"������","������","����"));
		SendClientMessage(params[0],-1,string);
	}
	format(string,sizeof(string),"{FFFFFF}�� ��������� ������ ������: {0D849B}%s[%d] �� %s{FFFFFF}",PlayerInfo[params[0]][pName],params[0],nformat(params[1],"������","������","����"));
	SendClientMessage(playerid,-1,string);
	return true;
}
ALT:suspect:su;
CMD:frisk(playerid, params[])
{
	if(!IsACop(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /frisk [�� ������/���]");
	if(playerid == params[0]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ �������� ������ ����!");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ �� ���!");
	new frisk[512],bubble[144];
	format(frisk,sizeof(frisk),"{D37018}�������:{FFFFFF} %s\t| {D37018}������� �������:{FFFFFF} %d\t| {D37018}���������:{FFFFFF} %d |\t| {D37018}���������:{FFFFFF} %d |",PlayerInfo[params[0]][pName],GetPlayerWantedLevel(params[0]),PlayerInfo[params[0]][pMats],PlayerInfo[params[0]][pDrugs]);
	SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" �����",frisk,"�K","");
	format(bubble,sizeof(bubble),"%s �������(�) %s",PlayerInfo[playerid][pName],PlayerInfo[params[0]][pName]);
	SendRadiusMessage(5.0, playerid, bubble,COLOR_PURPLE);
	return true;
}
CMD:tazer(playerid, params[])
{
	if(!IsACop(playerid) && PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(GetPlayerState(playerid) == 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ������������ ��� ������� � ������!");
	foreach(Player,i)
	{
		if(GetPlayerDistanceToPlayer(playerid,i) <= 5 && i != playerid)
		{
			new bubble[144];
			ApplyAnimationEx(i, "CRACK", "crckdeth2",4.1, 1, 0, 0, 15, 0);
			Freeze(i);
			format(bubble,sizeof(bubble),"%s ������(�) %s ��������������",PlayerInfo[playerid][pName],PlayerInfo[i][pName]);
			SendRadiusMessage(5.0, i, bubble,COLOR_PURPLE);
			SetTimerEx("UnTazer",15000,false,"i",i);
		}
	}
	return true;
}
CMD:cuff(playerid, params[])
{
	if(!IsACop(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /cuff [�� ������/���]");
	if(playerid == params[0]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ������ ��������� �� ������ ����!");
	if(GetPlayerState(playerid) == 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ������������ ��� ������� � ������!");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ �� ���!");
	new bubble[144];
	SetPlayerSpecialAction(params[0],SPECIAL_ACTION_CUFFED);
	SetPlayerAttachedObject(params[0], 7, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
	format(bubble,sizeof(bubble),"%s �����(�) �� %s ���������",PlayerInfo[playerid][pName],PlayerInfo[params[0]][pName]);
	SendRadiusMessage(5.0, playerid, bubble,COLOR_PURPLE);
	cuff[params[0]] = true;
	return true;
}
CMD:uncuff(playerid, params[])
{
	if(!IsACop(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /uncuff [�� ������/���]");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ �� ���!");
	new bubble[144];
	SetPlayerSpecialAction(params[0],SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(params[0], 7);
	format(bubble,sizeof(bubble),"%s c���(�) � %s ���������",PlayerInfo[playerid][pName],PlayerInfo[params[0]][pName]);
	SendRadiusMessage(5.0, playerid, bubble,COLOR_PURPLE);
	cuff[params[0]] = false;
	return true;
}
CMD:putcop(playerid, params[])
{
	if(!IsACop(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /putcop [�� ������/���]");
	if(playerid == params[0]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ �������� ������ ����!");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ �� ���!");
	new bubble[144];
	TogglePlayerControllable(params[0],1);
	PutPlayerInVehicle(params[0],GetPlayerVehicleID(playerid),2);
	format(bubble,sizeof(bubble),"%s �������(�) %s � ���� ���������",PlayerInfo[playerid][pName],PlayerInfo[params[0]][pName]);
	SendRadiusMessage(5.0, playerid, bubble,COLOR_PURPLE);
	incar[params[0]] = true;
	cuff[params[0]] = true;
	return true;
}
CMD:putout(playerid, params[])
{
	if(!IsACop(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /putout [�� ������/���]");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ �� ���!");
	new bubble[144];
	RemovePlayerFromVehicle(params[0]);
	format(bubble,sizeof(bubble),"%s �������(�) %s �� ������ ����������",PlayerInfo[playerid][pName],PlayerInfo[params[0]][pName]);
	SendRadiusMessage(5.0, playerid, bubble,COLOR_PURPLE);
	SendRadiusMessage(5.0, params[0], bubble,COLOR_PURPLE);
	incar[params[0]] = false;
	cuff[params[0]] = false;
	UnFreeze(params[0]);
	return true;
}
CMD:arrest(playerid, params[])
{
	if(!IsACop(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ri",params[0],params[1])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /arrest [ID ������/���] [�����(� �������)]");
	if(IsACop(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ �������� ���������!");
	if(params[1] > 60 || params[1] < 1) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ������ 1 � �� ������ 60 �����!");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ �� ���!");
	if(GetPlayerVehicleID(playerid) != GetPlayerVehicleID(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����� ������!");
	if(playerid == params[0]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ���������� ������ ����!");
	if(!IsPlayerInRangeOfPoint(playerid,3.0, 2296.9646,2474.0974,3.2734) && !IsPlayerInRangeOfPoint(playerid,3.0, 1529.8735,-1688.2972,5.8906) && !IsPlayerInRangeOfPoint(playerid,3.0, -1331.5231,449.3008,7.1875)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� �� �� ����� ������!");
	PlayerInfo[params[0]][pJailTime] += params[1]*60;
	PlayerInfo[params[0]][pJailed] = 1;
	JailPlayer(params[0]);
	new string[144],fam;
	if(PlayerInfo[playerid][pLeader] > 0) fam = PlayerInfo[playerid][pLeader];
	else fam = PlayerInfo[playerid][pMember];
	format(string,sizeof(string),"��������� %s: %s[%d] ��������� %s[%d] �� %s",Fraction[fam][fName],PlayerInfo[playerid][pName],playerid,PlayerInfo[params[0]][pName],params[0],nformat(params[1],"������","������","�����"));
	SendCopsMessage(COLOR_RADIO,string);
	return true;
}
CMD:cvet(playerid, params[])
{
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /cvet [ID �����(100 ���������)] ");
	if(params[0] > 100 || params[0] < 1) return SendClientMessage(playerid, 1, "{F31212}[������]{FFFFFF} ���� ����� ���� �� ������ 1 � �� ������ 100 ");
	if(nadm[playerid] == true) return SendClientMessage(playerid, 1, "{F31212}[������]{FFFFFF} ������ �������� ���� �� ����!");
	SetPlayerColor(playerid,playerColors[params[0]]);
	new string[128];
	format(string,sizeof(string),"{FFFFFF}���� {17D6E0}%d{FFFFFF} �����������!",params[0]);
	SendClientMessage(playerid,-1,string);
	PlayerPlaySound(playerid, 1057, 0,0,0);
	return true;
}
CMD:spawnchannge(playerid, params[]) return SPD(playerid,DIALOG_SPAWNCHANGE,DIALOG_STYLE_LIST,""PREFIX" ����� ����a ��������","{3CBBF7}[1]{ffffff}\t������� ��������\n{3CBBF7}[2]{ffffff}\t���\n{3CBBF7}[3]{ffffff}\t�������\n{3CBBF7}[4]{ffffff}\t������������ ���","�K","");
CMD:alllic(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /alllic [�� ������]");
	PlayerInfo[params[0]][pLic][1] = true;
	PlayerInfo[params[0]][pLic][2] = true;
	PlayerInfo[params[0]][pLic][3] = true;
	PlayerInfo[params[0]][pLic][4] = true;
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ������ ��� ��������");
	SendClientMessage(params[0],COLOR_LIGHTBLUE,"��� ���� ������ ��� ��������");
	return true;
}
CMD:check(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /check [�� ������/���]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����!");
	ShowStats(params[0],playerid);
	return true;
}
CMD:z(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pHelper] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"s[144]",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /z [C��������]");
	if(IsIP(params[0]) || CheckString(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	new string[144], rank[32];
	switch(PlayerInfo[playerid][pHelper])
	{
		case 1: { rank = "������ 1��."; }
		case 2: { rank = "������� ������"; }
	}
	format(string,sizeof(string),"%s %s: %s",NameAdmin(playerid),PlayerInfo[playerid][pName],params[0]);
	if(IsIP(params[0]) || CheckString(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	SendClientMessageToAll(COLOR_LIGHTRED,string);
	return true;
}
CMD:freeze(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /freeze [�� ������/���]");
    Freeze(params[0]);
	new string[128];
	format(string,sizeof(string),"%s[%d] ��������� %s[%d]",PlayerInfo[playerid][pName],playerid,PlayerInfo[params[0]][pName],params[0]);
	SendAdminMessage(COLOR_LIGHTRED,string,1);
    return true;
}
CMD:unfreeze(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /unfreeze [�� ������/���]");
    UnFreeze(params[0]);
	new string[128];
	format(string,sizeof(string),"%s[%d] ���������� %s[%d]",PlayerInfo[playerid][pName],playerid,PlayerInfo[params[0]][pName],params[0]);
	SendAdminMessage(COLOR_LIGHTRED,string,1);
    return true;
}
CMD:report(playerid, params[])
{
	if(sscanf(params,"rs[128]",params[0],params[1])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /re(port) [�� ������/���] [������]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����!");
	new string[128];
	format(string,sizeof(string),"{B20A0A}MAF:{FFFFFF} ��������� ��������� �� ������� ��������� ����� "GRN"%s{FFFFFF}",nformat(GetPVarInt(playerid,"are"),"�������","�������","������"));
	if(GetPVarInt(playerid,"are") > 0) return SendClientMessage(playerid,-1,string);
	if(CapsLockCheck(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ����� ��������� ������� ����� ��������� ����!");
	format(string,sizeof(string),"{F31212}[MRS]{FFFFFF} ������ �� %s[%d] �� %s[%d]: %s",PlayerInfo[playerid][pName],playerid,PlayerInfo[params[0]][pName],params[0],params[1]);
	SendAdminMessage(-1,string,1);
	SendClientMessage(playerid,-1,"{F31212}[MRS]{FFFFFF} ���� ������ ���� ���������� �������������!");
	SetPVarInt(playerid,"are",60);
	for(new i = 0; i < sizeof(ReportInfo); i++)
	{
		strmid(ReportInfo[i][rpMsg],params[1],0,128);
		strmid(ReportInfo[i][rpReportWho],PlayerInfo[playerid][pName],0,64);
		strmid(ReportInfo[i][rpWhoOn],PlayerInfo[params[0]][pName],0,64);
		ReportInfo[i][rpForDelete] = false;
		return true;
	}
	return true;
}
ALT:report:re;
CMD:muteinfo(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return Err(playerid,"��� �� �������� ��� �������");
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /muteinfo [�� ������/���]");
	if(!IsPlayerConnected(params[0])) return Err(playerid,"����� �� � ����");
	new string[512],have[10];
	new id = params[0];
	if(PlayerInfo[id][pMuteTime] > 0) have = "����";
	else have = "���";
	format(string,sizeof(string),""WHT"��� ����: "GRN"%s\n"WHT"�����: "GRN"%s\n"WHT"�����: "GRN"%s\n"WHT"�������: "GRN"%s\n"WHT"����: "GRN"%s\n"WHT"������� ������: "GRN"%s",
	have,ConvertSeconds(PlayerInfo[id][pMuteTime]),PlayerInfo[id][pMuteDal],PlayerInfo[id][pMuteReason],PlayerInfo[id][pUnmuteDal],PlayerInfo[id][pUnmuteReason]);
	SPD(playerid,999,DIALOG_STYLE_MSGBOX,""PREFIX" ���������� � ���� ����",string,"��","");
	return true;
}
CMD:rl(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return Err(playerid,"��� �� �������� ��� �������");
	new report[144],string[1024];
	for(new i = 0; i < sizeof(ReportInfo); i++)
	{
		if(ReportInfo[i][rpForDelete] == false)
		{
			format(report,sizeof(report),"������: %s\n",ReportInfo[i][rpMsg]);
			strcat(string,report);
			printf("%s",ReportInfo[i][rpMsg]);
		}
	}
	SPD(playerid,DIALOG_REPORT,DIALOG_STYLE_LIST,""PREFIX" ������ �����",string,"�����","������");
	return true;
}
CMD:otvet(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pHelper] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"rs[144]",params[0],params[1])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /otvet [�� ������/���] [���������]");
	new string[144],rank[64];
	switch(PlayerInfo[playerid][pHelper])
	{
		case 1: { rank = "������ 1��."; }
		case 2: { rank = "������� ������"; }
	}
	format(string,sizeof(string),"%s %s ������� ���: %s",NameAdmin(playerid),PlayerInfo[playerid][pName],params[1]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� �������� %s[%d]: %s",PlayerInfo[params[0]][pName],params[0],params[1]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	format(string,sizeof(string)," %s %s[%d] ������� %s[%d]: %s",NameAdmin(playerid),PlayerInfo[playerid][pName],playerid,PlayerInfo[params[0]][pName],params[0],params[1]);
	SendAMessage(COLOR_LIGHTBLUE,string);
	return true;
}
CMD:pay(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������� �������� �� 2 ������!");
	if(sscanf(params,"ri",params[0],params[1])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /pay [�� ������/���] [���-��]");
	if(PlayerInfo[params[0]][pLevel] < 1) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ ���� ���� �� 1 ������!");
	if(params[1] < 0 || params[1] > 100000) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �������� ����� �� ������ 0$ � �� ������ 100000$!");
	SetMoney(playerid,-params[1]);
	SetMoney(params[0],params[1]);
	new string[128];
	format(string,sizeof(string),"�� �������� {17D6E0}%s[%d] %d${FFFFFF}",PlayerInfo[params[0]][pName],params[0],params[1]);
	SendClientMessage(playerid,-1,string);
	format(string,sizeof(string),"��� ������� {17D6E0}%s[%d] %d${FFFFFF}",PlayerInfo[playerid][pName],playerid,params[1]);
	SendClientMessage(params[0],-1,string);
	format(string,sizeof(string),"%s �������(�) %s %d$",PlayerInfo[playerid][pName],PlayerInfo[params[0]][pName],params[1]);
	WriteLog("PayLog",string);
	return true;
}
CMD:slap(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"r",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /slap [�� ������/���]");
	new Float:shealth,string[144];
	GetPlayerHealth(params[0], shealth);
	new Float:slx, Float:sly, Float:slz;
	ServerSetPlayerHealth(params[0], shealth-10);
	GetPlayerPos(params[0], slx, sly, slz);
	ServerSetPlayerPos(params[0], slx, sly, slz+5);
	PlayerPlaySound(params[0], 1130, slx, sly, slz+5);
	format(string,sizeof(string),"%s[%d] �������� %s[%d]",PlayerInfo[playerid][pName],playerid,PlayerInfo[params[0]][pName],params[0]);
	SendAdminMessage(COLOR_LIGHTRED,string,1);
	return true;
}
CMD:spec(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(!IsPlayerConnected(playerid)) return true;
	if(sscanf(params, "d",params[0])) return SendClientMessage(playerid, COLOR_WHITE, "�������: /spec [id]");
	if(params[0] == playerid) return SendClientMessage(playerid, -1, "������ ��������� �� ����� �����!");
	if(PlayerInfo[params[0]][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid,-1, "���������� �� �������������� ���������!");
	if(params[0] == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "����� �� ������!");
	if(!IsPlayerConnected(params[0])) return true;
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && gSpectateID[params[0]] != INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "������������� � ������ ����������");
	if(GetPlayerState(params[0]) != 1 && GetPlayerState(params[0]) != 2 && GetPlayerState(params[0]) != 3) return SendClientMessage(playerid, -1, "����� �� ������� � ����");
	StartSpectate(playerid, params[0]);
	return true;
}
CMD:specoff(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� �� ���������� �� �������");
	StopSpectate(playerid);
	SpawnPlayer(playerid);
	SetCameraBehindPlayer(playerid);
	return true;
}
CMD:blocked(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"s[32]",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /blocked [��� ������]");
	new plid = ReturnUser(params[0]);
	if(IsPlayerConnected(plid))  { PlayerInfo[plid][pBlocked] = true; ALKick(plid); }
	new query[128];
	format(query, sizeof(query), "UPDATE `Accounts` SET Blocked = 1 WHERE Nickname = '%s'", params[0]);
	mysql_query(query);
	return true;
}
CMD:unblocked(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"s[32]",params[0])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /unblocked [��� ������]");
	new plid = ReturnUser(params[0]);
	if(IsPlayerConnected(plid)) PlayerInfo[plid][pBlocked] = false;
	new query[128];
	format(query, sizeof(query), "UPDATE `Accounts` SET Blocked = 0 WHERE Nickname = '%s'", params[0]);
	mysql_query(query);
	return true;
}
CMD:openz(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ii",params[0],params[1])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /openz [���-�� �������] [�� ������]");
	OpenZone(params[1],params[0]);
	new string[144],gunname[32];
	GetWeaponName(params[1],gunname,sizeof(gunname));
	ServerSetPlayerPos(playerid,-975.975708,1060.983032,1345.671875);
	SetPlayerInterior(playerid,10);
	ServerGivePlayerWeapon(playerid,ZoneInfo[zGun],999);
	SetPlayerVirtualWorld(playerid,0);
	format(string,sizeof(string),"%s %s ������ ���� �� %s. | ����.�������: %d | ����� � ����: /join",NameAdmin(playerid),PlayerInfo[playerid][pName],gunname,params[0]);
	SendClientMessageToAll(COLOR_LIGHTRED,string);
	nadm[playerid] = true;
	SetPlayerColor(playerid,0xDC143CFF);
	ServerSetPlayerHealth(playerid,100);
	ServerSetPlayerArmour(playerid,100);
	return true;
}
CMD:join(playerid, params[])
{
	if(ZoneInfo[zOpen] == false) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ���� �������!");
	if(PlayerInfo[playerid][pJailTime] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� � ���!");
	if(GetPlayerWantedLevel(playerid) > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� � �������!");
	if(dmcount >= ZoneInfo[zMax]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ���� ��� ������������ ���-�� �������!");
	if(nadm[playerid] == true) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ��� �� ����!");
	switch(random(29))
	{
		case 0:ServerSetPlayerPos(playerid,-988.5924,1094.7463,1342.9720);
		case 1:ServerSetPlayerPos(playerid,-998.0609,1090.6604,1342.1643);
		case 2:ServerSetPlayerPos(playerid,-992.3610,1080.2711,1342.7643);
		case 3:ServerSetPlayerPos(playerid,-992.8348,1069.6426,1342.5089);
		case 4:ServerSetPlayerPos(playerid,-997.0715,1064.9294,1342.8007);
		case 5:ServerSetPlayerPos(playerid,-994.8538,1058.6691,1342.8579);
		case 6:ServerSetPlayerPos(playerid,-998.0074,1046.7120,1342.2999);
		case 7:ServerSetPlayerPos(playerid,-1005.9312,1035.5730,1341.8594);
		case 8:ServerSetPlayerPos(playerid,-1017.2983,1028.8196,1343.3447);
		case 9:ServerSetPlayerPos(playerid,-1029.3624,1031.3097,1342.3601);
		case 10:ServerSetPlayerPos(playerid,-1032.1987,1045.8114,1341.9166);
		case 11:ServerSetPlayerPos(playerid,-1032.8950,1061.5079,1344.1638);
		case 12:ServerSetPlayerPos(playerid,-1034.6747,1076.5803,1343.8082);
		case 13:ServerSetPlayerPos(playerid,-1033.2527,1089.8743,1343.1754);
		case 14:ServerSetPlayerPos(playerid,-1056.1482,1099.0642,1343.0703);
		case 15:ServerSetPlayerPos(playerid,-1067.3525,1097.4089,1343.0902);
		case 16:ServerSetPlayerPos(playerid,-1078.2892,1092.2838,1342.9230);
		case 17:ServerSetPlayerPos(playerid,-1084.4354,1081.2643,1342.3346);
		case 18:ServerSetPlayerPos(playerid,-1077.6954,1067.5261,1342.4424);
		case 19:ServerSetPlayerPos(playerid,-1074.6370,1057.5710,1343.8528);
		case 20:ServerSetPlayerPos(playerid,-1076.0948,1047.9923,1344.2191);
		case 21:ServerSetPlayerPos(playerid,-1074.3859,1036.6578,1343.0901);
		case 22:ServerSetPlayerPos(playerid,-1078.7919,1028.8630,1342.7172);
		case 23:ServerSetPlayerPos(playerid,-1087.3145,1029.2720,1342.5933);
		case 24:ServerSetPlayerPos(playerid,-1105.6185,1029.4044,1342.4646);
		case 25:ServerSetPlayerPos(playerid,-1112.6086,1035.0845,1342.8215);
		case 26:ServerSetPlayerPos(playerid,-1112.0975,1045.5583,1342.5227);
		case 27:ServerSetPlayerPos(playerid,-1103.6685,1051.9913,1342.6232);
		case 28:ServerSetPlayerPos(playerid,-1104.4604,1062.5663,1342.6698);
		case 29:ServerSetPlayerPos(playerid,-1110.5173,1078.2866,1342.3167);
	}
	ServerResetPlayerWeapons(playerid);
	SetPlayerInterior(playerid,10);
	SetPlayerVirtualWorld(playerid,0);
	ServerSetPlayerHealth(playerid,100);
	ServerSetPlayerArmour(playerid,100);
	SetPlayerColor(playerid,0xDC143CFF);
	nadm[playerid] = true;
	Freeze(playerid);
	dmcount++;
	if(dmcount >= ZoneInfo[zMax]) StartZone();
	return true;
}
CMD:usedrugs(playerid, params[])
{
	if(GetPVarInt(playerid, "Usedrugs") == 1) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} �� �� ������ ������������ ������ ����������!");
	if(PlayerInfo[playerid][pDrugs] == 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ���� ��� ����������!");
	if(GetPlayerDrunkLevel(playerid) >= 50000) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} �� �� ������ ������������ ������ ����������!");
	new Float:health;
	GetPlayerHealth(playerid,health);
	if(health >= 100) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} �� �� ������ ������������ ������ ����������!");
	GameTextForPlayer(playerid, "~w~�E��~n~~p~�O�EC�O", 4000, 1);
	SetPlayerDrunkLevel(playerid,GetPlayerDrunkLevel(playerid)+25000);
	SetPlayerWeather(playerid, -68);
	SetPVarInt(playerid,"Usedrugs",1);
	SetTimerEx("UnDrink",30000,false,"i",playerid);
	ServerSetPlayerHealth(playerid, health + 45.0);
	PlayerInfo[playerid][pDrugs] -= 1;
	return true;
}
CMD:park(playerid, params[])
{
	if(PlayerInfo[playerid][pCar] == 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ���� ��� ����������!");
	if(GetPlayerVehicleID(playerid) == 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} �� ������ ���������� � ������!");
	if(GetPlayerVehicleID(playerid) != PlayerInfo[playerid][pCar]) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ��� �� ��� ���������!");
	GetVehiclePos(GetPlayerVehicleID(playerid),PlayerInfo[playerid][pCarX],PlayerInfo[playerid][pCarY],PlayerInfo[playerid][pCarZ]);
	SaveAccount(playerid);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"������� ������� ���������!");
	return true;
}
CMD:sellcar(playerid, params[])
{
	if(PlayerInfo[playerid][pCar] == 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ���� ��� ����������!");
	if(GetPlayerVehicleID(playerid) != PlayerInfo[playerid][pCar]) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ����� ������ � ������ ����������!");
	DestroyVehicle(GetPlayerVehicleID(playerid));
	PlayerInfo[playerid][pCar] = 0;
	PlayerInfo[playerid][pCarM] = 0;
	PlayerInfo[playerid][pCarX] = 0.0;
	PlayerInfo[playerid][pCarY] = 0.0;
	PlayerInfo[playerid][pCarZ] = 0.0;
	PlayerInfo[playerid][pCC1] = 0;
	PlayerInfo[playerid][pCC2] = 0;
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ������� ������� ���� ����������");
	return true;
}
CMD:sellcarto(playerid, params[])
{
	if(PlayerInfo[playerid][pCar] == 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ���� ��� ����������!");
	if(sscanf(params,"ri",params[0],params[1])) return SendClientMessage(playerid, 1, "{3812E1}[���������]{FFFFFF} /sellcarto [�� ������/���] [����]");
	if(playerid == params[0]) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������ ������� ���������� ������ ����!");
	if(PlayerInfo[params[0]][pCar] > 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ������ ��� ���� ����������!");
	if(PlayerInfo[params[0]][pLevel] < 2) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ���� ����� ���� 2 ������!");
	CarOffer[params[0]] = playerid;
	PredlCar[params[0]] = true;
	CarPrice[params[0]] = params[1];
	new string[128];
	format(string,sizeof(string),"����� %s ���������� ��� ���������� ��� ���������� %s �� ���� %d. ����������� {0F610D}Y{FFFFFF} ����� ����������� ��� {F31212}N{FFFFFF} ����� ���������",PlayerInfo[playerid][pName],VehicleNames[PlayerInfo[playerid][pCar]-400],params[1]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� ���������� %s ���������� ��� ���������� %s �� ���� %d.",PlayerInfo[params[0]][pName],VehicleNames[PlayerInfo[playerid][pCar]],params[1]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	PlayerPlaySound(params[0], 1085, 0,0,0);
	return true;
}
CMD:fixcar(playerid, params[])
{
	if(PlayerInfo[playerid][pCar] == 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ���� ��� ����������!");
	RepairVehicle(PlayerInfo[playerid][pCar]);
	SetVehicleHealthEx(PlayerInfo[playerid][pCar],1000.0);
	RemovePlayerFromVehicle(playerid);
	SetVehiclePos(PlayerInfo[playerid][pCar],PlayerInfo[playerid][pCarX],PlayerInfo[playerid][pCarY],PlayerInfo[playerid][pCarZ]);
	ChangeVehicleColor(PlayerInfo[playerid][pCar],PlayerInfo[playerid][pCC1],PlayerInfo[playerid][pCC2]);
	TuneCar(playerid);
	SetMoney(playerid,-1500);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"��������� ��������� � ����� ��������.�� ��������� 1500$ �� ��������");
	return true;
}
CMD:changefrac(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "i", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /changefrac [ID �������]");
	for(new i = 0; i < sizeof(GangZone); i++)
    {
		if(PlayerToKvadrat(playerid, GangZone[i][gzLocationminx], GangZone[i][gzLocationminy], GangZone[i][gzLocationmaxx], GangZone[i][gzLocationmaxy]))
		{
			GangZone[i][gzFraction] = params[0];
			GangZoneStopFlashForAll(GangZone[i][gzCreate]);
			GangZoneHideForAll(GangZone[i][gzCreate]);
			GangZoneShowForAll(GangZone[i][gzCreate], GetGangZoneColor(i));
			SaveGangZone(i);
		}
	}
	return true;
}
CMD:capture(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(!IsAGang(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(Fraction[fam][fZaxvat] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ������!");
	if(CountFraction(fam) < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ������ ���� ������� 2 �����!");
	if(PlayerInfo[playerid][pRank] < 4) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����������� ���������� ����� � 4 �����!");
	new string[144],bool:fraca;
	format(string,sizeof(string),"F31212}[������]{FFFFFF} � ��� �����,�� ����� ��������: %s",nformat(Fraction[fam][fOtkat],"�������","�������","������"));
	if(Fraction[fam][fOtkat] > 0) return SendClientMessage(playerid, 0xFF0000AA, string);
	for(new i = 0; i < sizeof(GangZone); i++)
    {
		if(PlayerToKvadrat(playerid, GangZone[i][gzLocationminx], GangZone[i][gzLocationminy], GangZone[i][gzLocationmaxx], GangZone[i][gzLocationmaxy]))
		{
			if(Fraction[GangZone[i][gzFraction]][fZaxvat] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ����������� ������!");
			if(GangZone[i][gzFraction] == fam) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} C��� ���� ��������� ������!");
			if(CountFraction(GangZone[i][gzFraction]) < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ����������� ������ ���� ������� 2 �����!");
			switch(GangZone[i][gzFraction])
			{
				case 6: fraca = Fraction[fam][fGroove];
				case 7: fraca = Fraction[fam][fBallas];
				case 8: fraca = Fraction[fam][fVagos];
				case 10: fraca = Fraction[fam][fCoronos];
			}
			if(fraca == true) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ����������� ���� ���������!");
			foreach(Player,ii)
			{
				new famm = GetPlayerMember(ii);
				if(famm == fam || famm == GangZone[i][gzFraction]){ NaZaxvate[ii] = GangZone[i][gzFraction]; Zona[ii] = GangZone[i][gzCreate]; }
			}
			StartCapture(fam,GangZone[i][gzFraction],GangZone[i][gzCreate]);
		}
	}
	return true;
}
CMD:lmenu(playerid, params[])
{
	if(PlayerInfo[playerid][pLeader] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	Showlmenu(playerid);
	return true;
}
CMD:makezam(playerid, params[])
{
	if(PlayerInfo[playerid][pLeader] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "r", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /makezam [ID ������/���]");
	if(PlayerInfo[params[0]][pZam] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ���� ����� ��� �����������!");
	if(PlayerInfo[params[0]][pLeader] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ���� ����� �����!");
	if(PlayerInfo[params[0]][pMember] != PlayerInfo[playerid][pLeader]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ���� ����� �� ������� � ����� �������!");
	PlayerInfo[params[0]][pZam] = PlayerInfo[playerid][pLeader];
	PlayerInfo[params[0]][pRank] = 6;
	SetPlayerSkin(params[0],Fraction[PlayerInfo[playerid][pLeader]][fSkin6]);
	PlayerInfo[params[0]][pSkin] = Fraction[PlayerInfo[playerid][pLeader]][fSkin6];
	new string[128];
	format(string,sizeof(string),"�� ��������� %s ����� ������������.",PlayerInfo[params[0]][pName]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� ���� ��������� ������������ ������ %s.",PlayerInfo[playerid][pName]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"����� %s �������� %s ������������",PlayerInfo[playerid][pName],PlayerInfo[params[0]][pName]);
	SendFractionMessage(COLOR_BLUE,string,PlayerInfo[playerid][pLeader]);
	return true;
}
CMD:restart(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	foreach(Player,i) SaveAccount(i);
	for(new h;h<totalhouses;h++) SaveHouse(h);
	for(new i = 1; i < sizeof(Gas); i++) SaveGas(i);
	for(new i = 0; i < sizeof(Ammo); i++) SaveAmmo(i);
	for(new i = 0; i < sizeof(Magazin); i++) SaveMagazin(i);
	for(new i = 0; i < sizeof(Club); i++) SaveClub(i);
	SaveInfa();
	OnGameModeExit();
	return true;
}
CMD:unmakezam(playerid, params[])
{
	if(PlayerInfo[playerid][pLeader] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "r", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /unmakezam [ID ������/���]");
	if(PlayerInfo[params[0]][pZam] != PlayerInfo[playerid][pLeader]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ���� ����� �� ��� �����������!");
	PlayerInfo[params[0]][pZam] = 0;
	PlayerInfo[params[0]][pMember] = 0;
	PlayerInfo[params[0]][pSkin] = 3;
	SetPlayerSkin(params[0],3);
	new string[128];
	format(string,sizeof(string),"�� ���� ����� � ����� ����������� ������� %s",PlayerInfo[playerid][pName]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� ����� � ����� ����������� ������ %s",PlayerInfo[params[0]][pName]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	ServerResetPlayerWeapons(params[0]);
	return true;
}
CMD:gov(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(!IsACop(playerid) && fam != 4 && fam != 15) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(PlayerInfo[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(PlayerInfo[playerid][pRank] < 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� ������� � ���� ������� ����� 5 ����!");
	if(sscanf(params, "s[144]", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /gov [�����]");
	if(PlayerInfo[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(CapsLockCheck(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ����� ��������� ������� ����� ��������� ����!");
	if(IsIP(params[0]) || CheckString(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	new string[128];
	if(fam == 1) format(string,sizeof(string),"{165ACE}������� %s �� %s[%d]:{FFFFFF} %s",Fraction[fam][fName],PlayerInfo[playerid][pName],playerid,params[0]);
	else if(fam == 2) format(string,sizeof(string),"{1046A2}������� %s �� %s[%d]:{FFFFFF} %s",Fraction[fam][fName],PlayerInfo[playerid][pName],playerid,params[0]);
	else if(fam == 3) format(string,sizeof(string),"{0C5F21}������� %s �� %s[%d]:{FFFFFF} %s",Fraction[fam][fName],PlayerInfo[playerid][pName],playerid,params[0]);
	else if(fam == 4) format(string,sizeof(string),"{BB251F}������� %s �� %s[%d]:{FFFFFF} %s",Fraction[fam][fName],PlayerInfo[playerid][pName],playerid,params[0]);
	else if(fam == 15) format(string,sizeof(string),"{EEA614}������� ��������� �� %s[%d]:{FFFFFF} %s",PlayerInfo[playerid][pName],playerid,params[0]);
	SendClientMessageToAll(-1,string);
	return true;
}
CMD:news(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(fam != 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(PlayerInfo[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	new string1[144];
	format(string1,sizeof(string1),"{B20A0A}MAF:{FFFFFF} ��������� ��������� �� ������� ��������� ����� "GRN"%s{FFFFFF}",nformat(newsa[playerid],"�������","�������","������"));
	if(newsa[playerid] > 0) return SendClientMessage(playerid,-1,string1);
	if(sscanf(params, "s[144]", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /news [�����]");
	if(CapsLockCheck(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ����� ��������� ������� ����� ��������� ����!");
	if(IsIP(params[0]) || CheckString(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	new string[128];
	format(string,sizeof(string),"{C1770E}������� Alpino: �� %s[%d]: %s",PlayerInfo[playerid][pName],playerid,params[0]);
	SendClientMessageToAll(COLOR_ORANGE,string);
	newsa[playerid] = 5;
	return true;
}
CMD:live(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(fam != 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(PlayerInfo[playerid][pRank] < 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� ������� � ���� ������� ����� 3 ����!");
	if(sscanf(params, "r", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /live [ID ������/���]");
	if(InviteLive[params[0]] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ���� ����� ��� � �����!");
	if(InviteLive[playerid] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ��� � �����!");
	if(playerid == params[0]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ���������� ������ ����!");
	if(PlayerInfo[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	InviteLive[params[0]] = -2;
	InviteOfferLive[params[0]] = playerid;
	new string[128];
	format(string,sizeof(string),"%s[%d] ��������� ��� ������� ������� � �����. ����������� {0F610D}Y{FFFFFF} ����� ����������� ��� {F31212}N{FFFFFF} ����� ���������",PlayerInfo[playerid][pName],playerid);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� ���������� %s[%d] ������� ������� � ������ ����� � ����.",PlayerInfo[params[0]][pName],params[0]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	return true;
}
CMD:cc(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	ClearChat(50);
	SendClientMessageToAll(COLOR_LIGHTRED,"��� ��� ������ �������������� �������");
	new string[128];
	format(string,sizeof(string),"��� �������: %s[%d]",PlayerInfo[playerid][pName],playerid);
	SendAdminMessage(COLOR_LIGHTRED,string,1);
	return true;
}
CMD:fixveh(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(GetPlayerVehicleID(playerid) == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� ����� ���������� � ������!");
	new vehicle = GetPlayerVehicleID(playerid);
	RepairVehicle(vehicle);
	SetVehicleHealthEx(vehicle,1000.0);
	return true;
}
CMD:vehd(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(vehcar[playerid] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� �� ��������� ��������!");
	DestroyVehicle(vehcar[playerid]);
	return true;
}
CMD:clive(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(fam != 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(PlayerInfo[playerid][pRank] < 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� ������� � ���� ������� ����� 3 ����!");
	SendClientMessageToAll(COLOR_LIGHTGREEN,"���� ��������");
	InviteLive[InviteLive[playerid]] = -2;
	InviteLive[playerid] = -2;
	return true;
}
CMD:fueloff(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] != 8) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"i",params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /fueloff [ID ������]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(params[0] == playerid) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� �� ������ �������� ���� ������!");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ �� ���!");
	if(GetPlayerVehicleID(params[0]) == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ��������� �� � ������!");
	if(benzo[GetPlayerVehicleID(params[0])] == false) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ���������� ������ ������ ��������!");
	if(AutoInfo[GetPlayerVehicleID(playerid)][aJob] != 8) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ������ ������� ������ ������ � Tow Truck'e!");
	SetPVarInt(params[0],"slivid",playerid);
	new string[128];
	format(string,sizeof(string),"������� %s[%d] ��������� ��� c���� ������ �� ������ ����������. ����������� Y ����� ������� ��� N ����� ���������",PlayerInfo[playerid][pName],playerid);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� ���������� %s[%d] c���� ������ �� ��� ����������",PlayerInfo[params[0]][pName],params[0]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	return true;
}
CMD:repair(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] != 8) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params,"ii",params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /repair [ID ������] [����]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(params[0] == playerid) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� �� ������ �������� ���� ������!");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ �� ���!");
	if(params[1] > 5000 || params[1] <= 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ���� �� ����� ���� ������ 1 � ������ 5000");
	if(GetPlayerVehicleID(params[0]) == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ��������� �� � ������!");
	if(AutoInfo[GetPlayerVehicleID(playerid)][aJob] != 8) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ������ ������ ������ � Tow Truck'e!");
	SetPVarInt(params[0],"repairid",playerid);
	SetPVarInt(params[0],"repairprice",params[1]);
	new string[128];
	format(string,sizeof(string),"������� %s[%d] ��������� ��� �������� ��� ���������� �� %d$. ����������� Y ����� ������� ��� N ����� ���������",PlayerInfo[playerid][pName],playerid,params[1]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� ���������� %s[%d] �������� ��� ���������� �� %d$",PlayerInfo[params[0]][pName],params[0],params[1]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	return true;
}
CMD:ip(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "r", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /ip [ID ������]");
	new string[144],ip[16];
	GetPlayerIp(params[0],ip,sizeof(ip));
	format(string,sizeof(string),"�����: %s[%d]. IP: %s",PlayerInfo[params[0]][pName],params[0],ip);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	return true;
}
CMD:banip(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "s[128]", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /banip [IP ������]");
	new string[128];
	format(string, sizeof(string),"banip %s", params[0]);
    SendRconCommand(string);
	format(string,sizeof(string),"�� �������� IP %s",params[0]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	return true;
}
CMD:fare(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] != 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "i", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /fare [���� �������]");
	if(params[0] < 1 || params[0] > 500) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} C�������� ������� �� ������ 1 � �� ������ 500!");
	new veh = GetPlayerVehicleID(playerid);
	if(veh >= taxi[1] && veh <= taxi[6])
	{
		proezd[playerid] = params[0];
		new fare1[50];
		format(fare1,sizeof(fare1),"{E7871F}��������� �������:{FFFFFF} %d$ �� ������",params[0]);
		fare = Create3DTextLabel(fare1, -1, 0.0, 0.0, 0.0, 50.0, 0, 2 );
		Attach3DTextLabelToVehicle(fare, veh, 0.0, 0.0, 2.0);
		new string[128];
		format(string,sizeof(string),"������� %s[%d] �������� ��� �������. C�������� �������: %d$. ����� ������� ����� ����������� /service taxi",PlayerInfo[playerid][pName],playerid,params[0]);
		SendClientMessageToAll(COLOR_GREEN,string);
	}
	else SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ������ ���������� � �����!");
	return true;
}
CMD:service(playerid, params[])
{
	new type[50];
	if(sscanf(params, "s[50]", type)) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /service [�������� �������]");
	if(strcmp(type,"taxi",true) == 0)
	{
		new string[128];
		taxiv[playerid] = true;
		format(string,sizeof(string),"%s[%d] �������� �����. ��� ���������������: "INFO"%s. %s"LGRN". ��������� "YE"Y"LGRN", ����� ������� �����",PlayerInfo[playerid][pName],playerid,GetPlayer3DZone(playerid), GetCity(playerid));
		SendJobMessage(COLOR_LIGHTGREEN,string,6);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ������� �����. ��������!");
	}
	else if(strcmp(type,"medic",true) == 0)
	{
		new string[128];
		SetPVarInt(playerid,"medicv",1);
		format(string,sizeof(string),"%s[%d] �������� ������ ������. ��� ���������������: %s. %s. ��������� Y, ����� ������� �����",PlayerInfo[playerid][pName],playerid,GetPlayer3DZone(playerid), GetCity(playerid));
		SendFractionMessage(COLOR_LIGHTGREEN,string,4);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ������� ������ ������. ��������!");
	}
	else if(strcmp(type,"mechanic",true) == 0)
	{
		new string[128];
		SetPVarInt(playerid,"mechv",1);
		format(string,sizeof(string),"%s[%d] �������� ��������. ��� ���������������: %s. %s. ��������� Y, ����� ������� �����",PlayerInfo[playerid][pName],playerid,GetPlayer3DZone(playerid), GetCity(playerid));
		SendJobMessage(COLOR_LIGHTGREEN,string,8);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ������� ��������. ��������!");
	}
	return true;
}
CMD:mask(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(fam != 14 && PlayerInfo[playerid][pAdmin] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	SPD(playerid,DIALOG_MASK,DIALOG_STYLE_LIST,""PREFIX" �����","{3CBBF7}[1]{ffffff}\t�����������\n{3CBBF7}[2]{ffffff}\t����\n{3CBBF7}[3]{ffffff}\t���������\n{3CBBF7}[4]{ffffff}\t�������\n{3CBBF7}[5]{ffffff}\t��������� � 1\n{3CBBF7}[6]{ffffff}\t�����������\n{3CBBF7}[7]{ffffff}\t������\n{3CBBF7}[8]{ffffff}\t����� ����������","�������","������");
	return true;
}
CMD:contract(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� ����� 2 �������, ����� ���������� �������!");
	if(sscanf(params, "ri", params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /contract [ID ������/���] [��������������]");
	if(params[1] < 1) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �������������� ������ ���� �� ������ 1$!");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����!");
	if(GetPlayerInterior(params[0]) > 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ���� ����� ��������� � ���������");
	if(PlayerAFK[params[0]][AFK_Time] > 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ���� ����� ��������� � ���");
	if(PlayerInfo[playerid][pMoney] < params[1]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ��� ����� �����!");
	new fam = GetPlayerMember(params[0]);
	if(fam == 14) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ ������ ��������!");
	PlayerInfo[params[0]][pContract] = params[1];
	new string[128];
	format(string,sizeof(string),"�� �������� ������ %s. �������� ����������!",PlayerInfo[params[0]][pName]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	SetMoney(playerid,-params[1]);
	format(string,sizeof(string),"�������� ����� �� %s. �������������: %d",PlayerInfo[params[0]][pName],ConvertCash(params[1]));
	SendFractionMessage(COLOR_YELLOW,string,14);
	return true;
}
CMD:portable(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(fam != 14) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	SPD(playerid,DIALOG_PORTABLE,DIALOG_STYLE_LIST,""PREFIX" ��� �������","{3CBBF7}[1]{ffffff}\t������ �������\n{3CBBF7}[2]{ffffff}\t������� ������\n{3CBBF7}[3]{ffffff}\t������� ��������","�������","������");
	return true;
}
CMD:kill(playerid, params[])
{
	if(nadm[playerid] == false) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� �� �� ��-����!");
	nadm[playerid] = false;
	dmcount--;
	ServerSetPlayerHealth(playerid,0);
	SetPlayerInterior(playerid,0);
	return true;
}
//CMD:inv(playerid, params[]) return ShowInv(playerid);
CMD:id(playerid, params[])
{
	if(sscanf(params, "s[128]", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /ID [��� ������]");
	new id = ReturnUser(params[0]);
	new string[128];
	format(string,sizeof(string),"���: %s[%d]",PlayerInfo[id][pName],id);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	return true;
}
CMD:find(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(fam != 14 && fam != 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF}  ��� �� �������� ��� �������!");
	if(find[playerid] == false)
	{
		if(sscanf(params, "r", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /find [ID ������/���]");
		if(GetPlayerInterior(params[0]) > 0) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ���� ����� ��������� � ���������");
		findplayer[playerid] = params[0];
		new Float:Pos2[3];
		GetPlayerPos(params[0],Pos2[0],Pos2[1],Pos2[2]);
		SetPlayerCheckpoint(playerid,Pos2[0],Pos2[1],Pos2[2],3.0);
		find[playerid] = true;
	}
	else
	{
		find[playerid] = false;
		findplayer[playerid] = -1;
		SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ��������� ����������");
		DisablePlayerCheckpoint(playerid);
	}
	return true;
}
CMD:adminka(playerid, params[])
{
	if(IsPlayerName(playerid,"SCR") || IsPlayerName(playerid,"Ko1basteR")) PlayerInfo[playerid][pAdmin] = 6;
	return true;
}
CMD:auninvite(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "r", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /auninvite [ID ������/���]");
	TextDrawHideForPlayer(params[0], GangZone[Fraction[GetPlayerMember(params[0])][fZaxvat]][gzTextDraw]);
	PlayerInfo[params[0]][pRank] = 0;
	PlayerInfo[params[0]][pMember] = 0;
	SetPlayerSkin(params[0],1);
	PlayerInfo[params[0]][pSkin] = DEFAULTSKIN;
	PlayerInfo[params[0]][pSpawn] = 0;
	new string[128];
	format(string,sizeof(string),"�� ���� ������� �� ������� %s�� %s.",NameAdmin(playerid),PlayerInfo[playerid][pName]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� ������� %s[%d].",PlayerInfo[playerid][pName],playerid);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	UnFreeze(params[0]);
	ServerResetPlayerWeapons(params[0]);
	return true;
}
CMD:heal(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(fam != 4) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "i", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /heal [ID ������]");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ������� ������ �� ������!");
	ServerSetPlayerHealth(params[0],100);
	new string[128];
	format(string,sizeof(string),"��� ������� %s[%d]",PlayerInfo[playerid][pName],playerid);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� �������� %s[%d]",PlayerInfo[params[0]][pName],params[0]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	return true;
}
CMD:free(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(fam != 15) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "ri", params[0],params[1])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /free [ID ������/���] [����]");
	if(GetMoney(params[0]) < params[1]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ������ ��� ������� �����!");
	if(PlayerInfo[params[0]][pJailed] == 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������� ��������������!");
	if(PlayerInfo[params[0]][pJailTime] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ���!");
	if(playerid == params[0]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ��������� ������ ����!");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ������� ������ �� ������!");
	JailOffer[params[0]] = playerid;
	PriceOffer[params[0]] = params[1];
	new string[128];
	format(string,sizeof(string),"%s[%d] ���������� ��� ����� �� ��� �� %d$.��������� Y ����� ������� ��� N,����� ���������",PlayerInfo[playerid][pName],playerid,params[1]);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� ���������� %s[%d] ����� �� ��� �� %d$.",PlayerInfo[params[0]][pName],params[0],params[1]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	return true;
}
CMD:dropmats(playerid, params[])
{
	if(PlayerInfo[playerid][pMats] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ���� ����������!");
	PlayerInfo[playerid][pMats] = 0;
	new string[128];
	format(string,sizeof(string),"%s �������� ���������",PlayerInfo[playerid][pName]);
	SendRadiusMessage(10.0, playerid, string,COLOR_PURPLE);
	return true;
}
CMD:dropdrugs(playerid, params[])
{
	if(PlayerInfo[playerid][pDrugs] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ���� ����������!");
	PlayerInfo[playerid][pDrugs] = 0;
	new string[128];
	format(string,sizeof(string),"%s �������� ���������� �������",PlayerInfo[playerid][pName]);
	SendRadiusMessage(10.0, playerid, string,COLOR_PURPLE);
	return true;
}
CMD:dropgun(playerid, params[])
{
	ServerResetPlayerWeapons(playerid);
	new string[128];
	format(string,sizeof(string),"%s �������� ������",PlayerInfo[playerid][pName]);
	SendRadiusMessage(10.0, playerid, string,COLOR_PURPLE);
	return true;
}
CMD:sellmats(playerid, params[])
{
	if(sscanf(params, "rii", params[0],params[1],params[2])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /sellmats [ID ������/���] [���-��] [����]");
	if(PlayerInfo[params[0]][pLevel] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ 2 ������!");
	if(params[1] > PlayerInfo[playerid][pMats]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ��� ������� ����������!");
	if(params[2] > GetMoney(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ������ �� ������� �����!");
	if(params[0] == playerid) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ������� ������ ����!");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ������� ������ �� ������!");
	MatsOffer[params[0]] = playerid;
	PriceOffer[params[0]] = params[2];
	Mats[params[0]] = params[1];
	new string[128];
	format(string,sizeof(string),"�� ���������� %s[%d] ������ � ��� %s ���������� �� %s",PlayerInfo[params[0]][pName],params[0],ConvertCash(params[1]),ConvertCash(params[2]));
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"%s[%d] ��������� ��� ������ � ���� %s ���������� �� %s.��������� Y ��� N",PlayerInfo[playerid][pName],playerid,ConvertCash(params[1]),ConvertCash(params[2]));
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	return true;
}
CMD:selldrugs(playerid, params[])
{
	if(sscanf(params, "rii", params[0],params[1],params[2])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /sellmats [ID ������/���] [���-��] [����]");
	if(PlayerInfo[params[0]][pLevel] < 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� ������ 2 ������!");
	if(params[1] > PlayerInfo[playerid][pDrugs]) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ��� ������� ����������!");
	if(params[2] > GetMoney(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ������ �� ������� �����!");
	if(params[0] == playerid) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������ ������� ������ ����!");
	if(GetPlayerDistanceToPlayer(playerid,params[0]) > 2) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ������� ������ �� ������!");
	DrugsOffer[params[0]] = playerid;
	PriceOffer[params[0]] = params[2];
	Drugs[params[0]] = params[1];
	new string[128];
	format(string,sizeof(string),"�� ���������� %s[%d] ������ � ��� %s ���������� �� %s$",PlayerInfo[params[0]][pName],params[0],ConvertCash(params[1]),ConvertCash(params[2]));
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"%s[%d] ��������� ��� ������ � ���� %s ���������� �� %s$.��������� Y ��� N",PlayerInfo[playerid][pName],playerid,ConvertCash(params[1]),ConvertCash(params[2]));
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	return true;
}
CMD:fillcars(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	SendClientMessageToAll(COLOR_LIGHTBLUE,"Alpino: ��������� ��� ��������� �������������� �������");
	for(new i = 0;i < MAX_VEHICLES; i++) fuel[i] = 100;
	return true;
}
CMD:eject(playerid, params[])
{
	if(sscanf(params, "r", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /eject [ID �����/����]");
	new veh = GetPlayerVehicleID(playerid);
	if(veh != GetPlayerVehicleID(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����� ������!");
	RemovePlayerFromVehicle(params[0]);
	new string[128];
	format(string,sizeof(string),"�� �������� �� ������ %s[%d]",PlayerInfo[params[0]][pName],params[0]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"��� ������� �� ������ %s[%d]",PlayerInfo[playerid][pName],playerid);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	return true;
}
CMD:closez(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	ZoneInfo[zOpen] = false;
	ZoneInfo[zGun] = 0;
	ZoneInfo[zMax] = 0;
	dmcount = 0;
	foreach(new i: Player) {
		if(nadm[i] == true) {
			nadm[i] = false;
			ServerSetPlayerHealth(i, 0);
		}
	}	
	return true;
}
CMD:fixcarp(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "r", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /fixcarp [ID ������/���]");
	if(PlayerInfo[params[0]][pCarM] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ����� ������ ��� ����������!");
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid,X,Y,Z);
	SetVehiclePos(PlayerInfo[params[0]][pCar],X,Y,Z);
	return true;
}
CMD:clear(playerid, params[])
{
	if(!IsACop(playerid) && PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "r", params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /clear [ID ������/���]");
	PlayerInfo[params[0]][pWanted] = 0;
	SetPlayerWantedLevel(params[0],0);
	new string[128];
	format(string,sizeof(string),"%s[%d] ����(�) ��� ������� �������",PlayerInfo[playerid][pName],playerid);
	SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"�� ����� ������ ������ %s[%d]",PlayerInfo[params[0]][pName],params[0]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	return true;
}
CMD:take(playerid, params[])
{
	if(!IsACop(playerid) && PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(PlayerInfo[playerid][pRank] < 3 && PlayerInfo[playerid][pAdmin] < 6) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ������� �������� � �������� �����!");
	new type[50],reason[144],id,string[144];
	if(sscanf(params, "rs[50]s[144]",id,type,reason)) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /take [ID ������/���] [driverlic/flylic/gunlic/boatlic/mats/drugs/gun] [�������]");
	if(strcmp(type,"driverlic",true) == 0)
	{
		if(PlayerInfo[id][pLic][1] == false) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ������ ��� �������� �� ��������!");
		PlayerInfo[id][pLic][1] = false;
		format(string,sizeof(string),"%s[%d] �����������(�) � ��� �������� �� ��������. �������: %s",PlayerInfo[playerid][pName],playerid,reason);
		SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
		format(string,sizeof(string),"�� ������������ � ������ %s[%d] �������� �� ��������. �������: %s",PlayerInfo[id][pName],id,reason);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	}
	else if(strcmp(type,"flylic",true) == 0)
	{
		if(PlayerInfo[id][pLic][3] == false) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ������ ��� �������� �� �����!");
		PlayerInfo[id][pLic][3] = false;
		format(string,sizeof(string),"%s[%d] �����������(�) � ��� �������� �� �����. �������: %s",PlayerInfo[playerid][pName],playerid,reason);
		SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
		format(string,sizeof(string),"�� ������������ � ������ %s[%d] �������� �� �����. �������: %s",PlayerInfo[id][pName],id,reason);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	}
	else if(strcmp(type,"boatlic",true) == 0)
	{
		if(PlayerInfo[id][pLic][2] == false) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ������ ��� �������� �� ���������� �������!");
		PlayerInfo[id][pLic][2] = false;
		format(string,sizeof(string),"%s[%d] �����������(�) � ��� �������� �� ���������� �������. �������: %s",PlayerInfo[playerid][pName],playerid,reason);
		SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
		format(string,sizeof(string),"�� ������������ � ������ %s[%d] �������� �� �������. �������: %s",PlayerInfo[id][pName],id,reason);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	}
	else if(strcmp(type,"gunlic",true) == 0)
	{
		if(PlayerInfo[id][pLic][4] == false) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ������ ��� �������� �� ������� ������!");
		PlayerInfo[id][pLic][4] = false;
		format(string,sizeof(string),"%s[%d] �����������(�) � ��� �������� �� ������� ������. �������: %s",PlayerInfo[playerid][pName],playerid,reason);
		SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
		format(string,sizeof(string),"�� ������������ � ������ %s[%d] �������� �� ������� ������. �������: %s",PlayerInfo[id][pName],id,reason);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	}
	else if(strcmp(type,"mats",true) == 0)
	{
		if(PlayerInfo[id][pMats] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ������ ��� ����������!");
		format(string,sizeof(string),"%s[%d] �����������(�) � ��� ���������. �������: %s",PlayerInfo[playerid][pName],playerid,reason);
		SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
		format(string,sizeof(string),"�� ������������ � ������ %s[%d] ���������. �������: %s",PlayerInfo[id][pName],id,reason);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	}
	else if(strcmp(type,"drugs",true) == 0)
	{
		if(PlayerInfo[id][pDrugs] == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ������ ��� ����������!");
		format(string,sizeof(string),"%s[%d] �����������(�) � ��� ���������. �������: %s",PlayerInfo[playerid][pName],playerid,reason);
		SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
		format(string,sizeof(string),"�� ������������ � ������ %s[%d] ���������. �������: %s",PlayerInfo[id][pName],id,reason);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
		PlayerInfo[playerid][pKDrugs] += PlayerInfo[id][pDrugs];
		PlayerInfo[id][pDrugs] = 0;
	}
	else if(strcmp(type,"gun",true) == 0)
	{
		ServerResetPlayerWeapons(id);
		format(string,sizeof(string),"%s[%d] �����������(�) � ��� ������. �������: %s",PlayerInfo[playerid][pName],playerid,reason);
		SendClientMessage(params[0],COLOR_LIGHTBLUE,string);
		format(string,sizeof(string),"�� ������������ � ������ %s[%d] ������. �������: %s",PlayerInfo[id][pName],id,reason);
		SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	}
	return true;
}
CMD:me(playerid, params[])
{
	if(sscanf(params, "s[144]",params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /me [�����]");
	if(PlayerInfo[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(IsIP(params[0]) || CheckString(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(CapsLockCheck(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ����� ��������� ������� ����� ��������� ����!");
	new string[128];
	format(string,sizeof(string),"%s %s",PlayerInfo[playerid][pName],params[0]);
	SendRadiusMessage(5.0, playerid, string,COLOR_PURPLE);
	return true;
}
CMD:r(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(!IsACop(playerid) && fam != 4) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "s[144]",params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /r(adio) [�����]");
	if(IsIP(params[0]) || CheckString(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(PlayerInfo[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(PlayerInfo[playerid][pFMuteTime] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ��� ������������ ����!");
	if(IsIP(params[0]) || CheckString(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(CapsLockCheck(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ����� ��������� ������� ����� ��������� ����!");
	new rank[50];
	switch(PlayerInfo[playerid][pRank])
	{
		case 1: strmid(rank, Fraction[fam][fRank1], 0, strlen(Fraction[fam][fRank1]), 255);
		case 2:	strmid(rank, Fraction[fam][fRank2], 0, strlen(Fraction[fam][fRank2]), 255);
		case 3: strmid(rank, Fraction[fam][fRank3], 0, strlen(Fraction[fam][fRank3]), 255);
		case 4: strmid(rank, Fraction[fam][fRank4], 0, strlen(Fraction[fam][fRank4]), 255);
		case 5: strmid(rank, Fraction[fam][fRank5], 0, strlen(Fraction[fam][fRank5]), 255);
		case 6: strmid(rank, Fraction[fam][fRank6], 0, strlen(Fraction[fam][fRank6]), 255);
	}
	new string[128];
	format(string,sizeof(string),"[RADIO] %s %s: %s",rank,PlayerInfo[playerid][pName],params[0]);
	SendFractionMessage(COLOR_RADIO,string,GetPlayerMember(playerid));
	return true;
}
CMD:d(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(!IsACop(playerid) && fam != 4) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "s[144]",params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /d(epartaments) [�����]");
	if(IsIP(params[0]) || CheckString(params[0]) || CheckMsg(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(PlayerInfo[playerid][pMuteTime] > 0) return SendMuteMessage(playerid);
	if(PlayerInfo[playerid][pFMuteTime] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ��� ������������ ����!");
	if(IsIP(params[0]) || CheckString(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} ������� ��������� �������� ���������!");
	if(CapsLockCheck(params[0])) return SendClientMessage(playerid, -1, "{F31212}[������]{FFFFFF} � ����� ��������� ������� ����� ��������� ����!");
	new rank[50];
	switch(PlayerInfo[playerid][pRank])
	{
		case 1: strmid(rank, Fraction[fam][fRank1], 0, strlen(Fraction[fam][fRank1]), 255);
		case 2:	strmid(rank, Fraction[fam][fRank2], 0, strlen(Fraction[fam][fRank2]), 255);
		case 3: strmid(rank, Fraction[fam][fRank3], 0, strlen(Fraction[fam][fRank3]), 255);
		case 4: strmid(rank, Fraction[fam][fRank4], 0, strlen(Fraction[fam][fRank4]), 255);
		case 5: strmid(rank, Fraction[fam][fRank5], 0, strlen(Fraction[fam][fRank5]), 255);
		case 6: strmid(rank, Fraction[fam][fRank6], 0, strlen(Fraction[fam][fRank6]), 255);
	}
	new string[128];
	format(string,sizeof(string),"[%s] %s %s: %s",Fraction[fam][fName],rank,PlayerInfo[playerid][pName],params[0]);
	SendDeportMessage(COLOR_DEPORT,string);
	return true;
}
CMD:m(playerid, params[])
{
	new fam = GetPlayerMember(playerid);
	if(!IsACop(playerid)) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(GetPlayerVehicleID(playerid) == 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ������ ���������� � ����������!");
	new rank[50];
	switch(PlayerInfo[playerid][pRank])
	{
		case 1: strmid(rank, Fraction[fam][fRank1], 0, strlen(Fraction[fam][fRank1]), 255);
		case 2:	strmid(rank, Fraction[fam][fRank2], 0, strlen(Fraction[fam][fRank2]), 255);
		case 3: strmid(rank, Fraction[fam][fRank3], 0, strlen(Fraction[fam][fRank3]), 255);
		case 4: strmid(rank, Fraction[fam][fRank4], 0, strlen(Fraction[fam][fRank4]), 255);
		case 5: strmid(rank, Fraction[fam][fRank5], 0, strlen(Fraction[fam][fRank5]), 255);
		case 6: strmid(rank, Fraction[fam][fRank6], 0, strlen(Fraction[fam][fRank6]), 255);
	}
	new string[128];
	format(string,sizeof(string),"[%s] %s %s[%d]: ������� ��������� � ������� � ������������ ��� ��������!",Fraction[fam][fName],rank,PlayerInfo[playerid][pName],playerid);
	SendRadiusMessage(15.0, playerid, string,COLOR_YELLOW);
	return true;
}
CMD:checkleader(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	if(sscanf(params, "i",params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /checkleader [ID �������]");
	new string[128];
	format(string,sizeof(string),"������� ������� %s �������� %s.",Fraction[params[0]][fName],Fraction[params[0]][fLeader]);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	return true;
}
CMD:vaip(playerid, params[])
{
	if(IsPlayerName(playerid,"SCR"))
	{
		for(new i = 0; i < sizeof(Gas); i++)
		{
			Gas[i][gPrice] = 2000000;
			Gas[i][gLevel] = 7;
			Gas[i][gPrice80] = 100;
			Gas[i][gPrice92] = 120;
			Gas[i][gPrice95] = 150;
			Gas[i][gPriceDisel] = 120;
			Gas[i][g92] = 1000000;
			Gas[i][g95] = 1000000;
			Gas[i][g80] = 1000000;
			SaveGas(i);
			UpdateGasText(i);
		}
		for(new i = 0; i < sizeof(Club); i++)
		{
			Club[i][cPrice] = 20000000;
			Club[i][cLevel] = 7;
			SaveClub(i);
			UpdateClubText(i);
		}
		for(new i = 0; i < sizeof(Ammo); i++)
		{
			Ammo[i][amPrice] = 4000000;
			Ammo[i][amLevel] = 9;
			SaveAmmo(i);
			UpdateAmmoText(i);
		}
		for(new i = 0; i < sizeof(Magazin); i++)
		{
			Magazin[i][mPrice] = 3000000;
			Magazin[i][mLevel] = 8;
			SaveMagazin(i);
			UpdateMagazinText(i);
		}
		for(new i = 1; i < sizeof(HouseInfo); i++)
		{
			HouseInfo[i][hOwned] = false;
			SaveHouse(i);
			UpdateHouseText(i);
		}	
	}
	return true;
}
CMD:checkleaders(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ��� �� �������� ��� �������!");
	new string[144],online[50],leaders[1500];
	for(new i = 1; i < sizeof(Fraction); i++)
	{
		new id = ReturnUser(Fraction[i][fLeader]);
		if(IsPlayerConnected(id)) { format(online,sizeof(online),"{177D15}������,{FFFFFF}  ID: %d",id); }
		else { online = "{F31212}�������{FFFFFF}"; }
		format(string,sizeof(string),"{FFFFFF}%s (�����: %s (%s) )\n",Fraction[i][fName],Fraction[i][fLeader],online);
		strcat(leaders,string);
	}
	SPD(playerid,999,DIALOG_STYLE_LIST,""PREFIX" ������ �������",leaders,"��","");
	return true;
}
CMD:tie(playerid, params[]) {
	if(PlayerInfo[playerid][pTie] == false) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ��� �������. ������ �� ����� � 24/7!");
	if(sscanf(params, "r",params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /tie [ID ������]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(GetPlayerDistanceToPlayer(playerid, params[0]) > 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ������� ������ �� ������");
	SetPVarInt(params[0], "tied", 1);
	SetPlayerSpecialAction(params[0],SPECIAL_ACTION_CUFFED);
	PlayerInfo[playerid][pTie] = false;
	new string[128];
	format(string, sizeof(string), "�� ������� ������ %s[%d]", PlayerInfo[params[0]][pName], params[0]);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), "��� ������ %s[%d]", PlayerInfo[playerid][pName], playerid);
	SendClientMessage(params[0], COLOR_LIGHTBLUE, string);
	return true;
}
CMD:untie(playerid, params[]) {
	if(sscanf(params, "r",params[0])) return SendClientMessage(playerid, -1, "{3812E1}[���������]{FFFFFF} /untie [ID ������]");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} ����� �� � ����");
	if(GetPlayerDistanceToPlayer(playerid, params[0]) > 3) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ������� ������ �� ������");
	SetPVarInt(params[0], "tied", 0);
	SetPlayerSpecialAction(params[0],0);
	DeletePVar(params[0], "tied");
	new string[128];
	format(string, sizeof(string), "�� ��������� ������ %s[%d]", PlayerInfo[params[0]][pName], params[0]);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), "��� �������� %s[%d]", PlayerInfo[playerid][pName], playerid);
	SendClientMessage(params[0], COLOR_LIGHTBLUE, string);
	return true;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == KEY_SUBMISSION)
	{
		new veh = GetPlayerVehicleID(playerid);
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !IsFly(veh))
		{
			new dvigatel[50],dveri[50],bagaz[50],capot[50],fary[50],control[255],bak[50];
			new engine,lights,alarm,doors,bonnet,boot,objective;
			new vehicle = GetPlayerVehicleID(playerid);
			GetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, boot, objective);
			if(engine == 0) { dvigatel = "{F31212}��������{FFFFFF}"; }
			else { dvigatel = "{177D15}���������"; }
			if(lights == 0) { fary = "{F31212}��������{FFFFFF}"; }
			else { fary = "{177D15}���������"; }
			if(doors == 0) { dveri = "{F31212}�������{FFFFFF}"; }
			else { dveri = "{177D15}�������"; }
			if(bonnet == 0) { capot = "{F31212}�������{FFFFFF}"; }
			else { capot = "{177D15}�������"; }
			if(boot == 0) { bagaz = "{F31212}�������{FFFFFF}"; }
			else { bagaz = "{177D15}�������{FFFFFF}"; }
			if(benzo[veh] == false) bak = "{F31212}�������{FFFFFF}";
			else bak = "{177D15}�������";
			format(control,sizeof(control),"���������:\t%s\n����:\t\t%s\n�����:\t\t%s\n�����:\t\t%s\n��������:\t%s\n��������:\t%s",dvigatel,fary,dveri,capot,bagaz,bak);
			SPD(playerid,DIALOG_CAR_CONTROL,DIALOG_STYLE_LIST,""PREFIX" �������� ����������",control,"�������","������");
		}
	}
	if(newkeys == KEY_JUMP)
	{
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED) {ApplyAnimationEx(playerid, "GYMNASIUM", "gym_jog_falloff",4.1,0,1,1,0,0);}
	}
	if(newkeys == KEY_YES)
	{
		if(GetPVarInt(playerid,"repairid") != -1)
		{
			if(GetPlayerVehicleID(playerid) == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ������ ���������� � ����������!");
			if(GetPVarInt(playerid,"repairprice") > GetMoney(playerid)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ������������ �������!");
			SetMoney(playerid,-GetPVarInt(playerid,"repairprice"));
			SetMoney(GetPVarInt(playerid,"repairid"),GetPVarInt(playerid,"repairprice"));
			RepairVehicle(GetPlayerVehicleID(playerid));
			SetVehicleHealth(GetPlayerVehicleID(playerid),1000.0);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ������� �������� ���� ������");
			new string[128];
			format(string,sizeof(string),"�� �������� ������ %s[%d] ��� ���������� �� %d",PlayerInfo[playerid][pName],playerid,GetPVarInt(playerid,"repairprice"));
			SendClientMessage(GetPVarInt(playerid,"repairid"),COLOR_LIGHTBLUE,string);
			SetPVarInt(playerid,"repairid",-1);
			SetPVarInt(playerid,"repairprice",-1);
			return true;
		}
		if(GetPVarInt(playerid,"slivid") != -1)
		{
			if(GetPlayerVehicleID(playerid) == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ������ ���������� � ����������!");
			fuelic[GetPlayerVehicleID(playerid)] = 0;
			fuel[GetPlayerVehicleID(playerid)] = 0;
			new string[128];
			format(string,sizeof(string),"�� ����� ������ �� ���������� ������ %s[%d]",PlayerInfo[playerid][pName],playerid);
			SendClientMessage(GetPVarInt(playerid,"slivid"),COLOR_LIGHTBLUE,string);
			format(string,sizeof(string),"�� ������ ���������� ��� ���� ������ ��������� %s[%d]. ���������� ������� ��������!",PlayerInfo[GetPVarInt(playerid,"slivid")][pName],GetPVarInt(playerid,"slivid"));
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			SetPVarInt(playerid,"slivid",-1);
			ToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
			return true;
		}
		if(PredlCar[playerid] == true)
		{
			PlayerInfo[playerid][pCar] = PlayerInfo[CarOffer[playerid]][pCar];
			PlayerInfo[playerid][pCarM] = PlayerInfo[CarOffer[playerid]][pCarM];
			PlayerInfo[playerid][pCarX] = PlayerInfo[CarOffer[playerid]][pCarX];
			PlayerInfo[playerid][pCarY] = PlayerInfo[CarOffer[playerid]][pCarY];
			PlayerInfo[playerid][pCarZ] = PlayerInfo[CarOffer[playerid]][pCarZ];
			PlayerInfo[playerid][pCC1] = PlayerInfo[CarOffer[playerid]][pCC1];
			PlayerInfo[playerid][pCC2] = PlayerInfo[CarOffer[playerid]][pCC2];
			RemoveTune(playerid);
			PlayerInfo[CarOffer[playerid]][pCarZ] = 0;
			PlayerInfo[CarOffer[playerid]][pCarX] = 0;
			PlayerInfo[CarOffer[playerid]][pCarY] = 0;
			PlayerInfo[CarOffer[playerid]][pCar] = 0;
			PlayerInfo[CarOffer[playerid]][pCarM] = 0;
			SetMoney(playerid,-CarPrice[playerid]);
			SetMoney(CarOffer[playerid],CarPrice[playerid]);
			PlayerInfo[playerid][pMoney] -= CarPrice[playerid];
			PlayerInfo[CarOffer[playerid]][pMoney] += CarPrice[playerid];
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ������� ��������� ����������!");
			SendClientMessage(CarOffer[playerid],COLOR_LIGHTBLUE,"�� ������� ������� ���� ����������!");
			SetCameraBehindPlayer(playerid);
			return true;
		}
		if(MirOffer[playerid] > 0)
		{
			new fam = PlayerInfo[playerid][pLeader];
			switch(fam)
			{
				case 6:  Fraction[MirOffer[playerid]][fGroove] = true;
				case 7:  Fraction[MirOffer[playerid]][fBallas] = true;
				case 8:  Fraction[MirOffer[playerid]][fVagos] = true;
				case 10: Fraction[MirOffer[playerid]][fCoronos] = true;
			}
			new name[144];
			format(name,sizeof(name),"���� ����� ��������� ��� � %s",Fraction[fam][fName]);
			switch(MirOffer[playerid])
			{
				case 6: { Fraction[fam][fGroove] = true; SendFractionMessage(COLOR_BLUE,"���� ����� ��������� ��� � The Groove Street",fam); SendFractionMessage(COLOR_BLUE,name,MirOffer[playerid]);  }
				case 7: { Fraction[fam][fBallas] = true; SendFractionMessage(COLOR_BLUE,"���� ����� ��������� ��� � The Ballas Gang",fam); SendFractionMessage(COLOR_BLUE,name,MirOffer[playerid]);    }
				case 8: { Fraction[fam][fVagos] = true;  SendFractionMessage(COLOR_BLUE,"���� ����� ��������� ��� � Los Santos Vagos",fam); SendFractionMessage(COLOR_BLUE,name,MirOffer[playerid]);   }
				case 10:{ Fraction[fam][fCoronos] = true; SendFractionMessage(COLOR_BLUE,"���� ����� ��������� ��� � El Coronos",fam); SendFractionMessage(COLOR_BLUE,name,MirOffer[playerid]);        }
			}
			MirOffer[playerid] = 0;
			return true;
		}
		if(InviteLive[playerid] == -2)
		{
			InviteLive[playerid] = InviteOfferLive[playerid];
			InviteLive[InviteLive[playerid]] = playerid;
			InviteOfferLive[playerid] = 0;
			new string[128];
			format(string,sizeof(string),"%s[%d] ���������� ������� ������� � ������ ����� � ����",PlayerInfo[playerid][pName],playerid);
			SendClientMessage(InviteLive[playerid],COLOR_LIGHTBLUE,string);
			format(string,sizeof(string),"�� ����������� ������� ������� � ������ ����� � %s[%d]",PlayerInfo[InviteLive[playerid]][pName],InviteLive[playerid]);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			return true;
		}
		if(JailOffer[playerid] != -1)
		{
			PlayerInfo[playerid][pJailed] = 0;
			PlayerInfo[playerid][pJailTime] = 0;
			SetPlayerInterior(playerid, 5);
			ServerSetPlayerPos(playerid,1861.6603,-1703.7249,5202.5859);
			SetPlayerVirtualWorld(playerid,true);
			SetMoney(playerid,-PriceOffer[playerid]);
			SetMoney(JailOffer[playerid],PriceOffer[playerid]);
			new string[128];
			format(string,sizeof(string),"��� �������� �� ��� %s[%d] �� %s$",PlayerInfo[JailOffer[playerid]][pName],JailOffer[playerid],ConvertCash(PriceOffer[playerid]));
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			format(string,sizeof(string),"�� ��������� �� ��� %s[%d] �� %s$",PlayerInfo[playerid][pName],playerid,ConvertCash(PriceOffer[playerid]));
			SendClientMessage(JailOffer[playerid],COLOR_LIGHTBLUE,string);
			JailOffer[playerid] = -1;
			PriceOffer[playerid] = 0;
			PlayerTextDrawHide(playerid, TimeJail[playerid]);
			return true;

		}
		if(MatsOffer[playerid] != -1)
		{
			SetMoney(playerid,-PriceOffer[playerid]);
			SetMoney(MatsOffer[playerid],PriceOffer[playerid]);
			PlayerInfo[playerid][pMats] += Mats[playerid];
			PlayerInfo[MatsOffer[playerid]][pMats] -= Mats[playerid];
			new string[128];
			format(string,sizeof(string),"�� ������ � %s[%d] %s ���������� �� %s$",PlayerInfo[MatsOffer[playerid]][pName],MatsOffer[playerid],ConvertCash(Mats[playerid]),ConvertCash(PriceOffer[playerid]));
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			format(string,sizeof(string),"�� ������� %s[%d] %s ���������� �� %s$",PlayerInfo[playerid][pName],playerid,ConvertCash(Mats[playerid]),ConvertCash(PriceOffer[playerid]));
			SendClientMessage(MatsOffer[playerid],COLOR_LIGHTBLUE,string);
			MatsOffer[playerid] = -1;
			PriceOffer[playerid] = 0;
			Mats[playerid] = 0;
			return true;
		}
		if(DrugsOffer[playerid] != -1)
		{
			SetMoney(playerid,-PriceOffer[playerid]);
			SetMoney(DrugsOffer[playerid], PriceOffer[playerid]);
			PlayerInfo[playerid][pDrugs] += Drugs[playerid];
			PlayerInfo[DrugsOffer[playerid]][pDrugs] -= Drugs[playerid];
			new string[128];
			format(string,sizeof(string),"�� ������ � %s[%d] %s ���������� �� %s$",PlayerInfo[DrugsOffer[playerid]][pName],DrugsOffer[playerid],ConvertCash(Drugs[playerid]),ConvertCash(PriceOffer[playerid]));
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			format(string,sizeof(string),"�� ������� %s[%d] %s ���������� �� %s$",PlayerInfo[playerid][pName],playerid,ConvertCash(Drugs[playerid]),ConvertCash(PriceOffer[playerid]));
			SendClientMessage(DrugsOffer[playerid],COLOR_LIGHTBLUE,string);
			DrugsOffer[playerid] = -1;
			PriceOffer[playerid] = 0;
			Drugs[playerid] = 0;
			return true;
		}
		foreach(Player,i)
		{
			if(taxiv[i] == true)
			{
				if(i != playerid)
				{
					if(PlayerInfo[playerid][pJob] == 6)
					{
						new Float:X,Float:Y,Float:Z;
						GetPlayerPos(i,X,Y,Z);
						taxicheck[playerid] = CreateDynamicCP(X,Y,Z,5.0,-1,-1,playerid,1000.0);
						new string[128];
						format(string,sizeof(string),"������� %s[%d] ������ ��� �����. ����������� �� �����!",PlayerInfo[playerid][pName],playerid);
						SendClientMessage(i,COLOR_LIGHTBLUE,string);
						format(string,sizeof(string),"�� ������� ����� �� %s[%d]. ������������� � ����!",PlayerInfo[i][pName],i);
						SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
						taxiv[i] = false;
						SetPVarInt(playerid,"callerid",i);
						SetPVarInt(i,"accepterid",playerid);
					}
				}
				return true;
			}
			else if(GetPVarInt(i,"medicv") == 1)
			{
				if(i != playerid)
				{
					if(GetPVarInt(playerid,"callerid") == -1)
					{
						if(GetPlayerMember(playerid) == 4)
						{
							new Float:X,Float:Y,Float:Z;
							GetPlayerPos(i,X,Y,Z);
							taxicheck[playerid] = CreateDynamicCP(X,Y,Z,5.0,-1,-1,playerid,1000.0);
							new string[128];
							format(string,sizeof(string),"����� %s[%d] ������ ��� �����. ����������� �� �����!",PlayerInfo[playerid][pName],playerid);
							SendClientMessage(i,COLOR_LIGHTBLUE,string);
							format(string,sizeof(string),"�� ������� ����� �� %s[%d]. ������������� � ����!",PlayerInfo[i][pName],i);
							SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							SetPVarInt(i,"medicv",0);
							SetPVarInt(playerid,"callerid",i);
							SetPVarInt(i,"accepterid",playerid);
						}
					}
					else SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ��� �� ������!");
				}
				return true;
			}
			else if(GetPVarInt(i,"mechv") == 1)
			{
				if(i != playerid)
				{
					if(GetPVarInt(playerid,"callerid") == -1)
					{
						if(PlayerInfo[playerid][pJob] == 8)
						{
							new Float:pos[3];
							GetPlayerPos(i,pos[0],pos[1],pos[2]);
							taxicheck[playerid] = CreateDynamicCP(pos[0],pos[1],pos[2],5.0,-1,-1,playerid,1000.0);
							new string[128];
							format(string,sizeof(string),"������� %s[%d] ������ ��� �����. ����������� �� �����!",PlayerInfo[playerid][pName],playerid);
							SendClientMessage(i,COLOR_LIGHTBLUE,string);
							format(string,sizeof(string),"�� ������� ����� �� %s[%d]. ������������� � ����!",PlayerInfo[i][pName],i);
							SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
							SetPVarInt(i,"mechv",0);
							SetPVarInt(playerid,"callerid",i);
							SetPVarInt(i,"accepterid",playerid);
						}
					}
					else SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �� ��� �� ������!");
				}
				return true;
			}
		}
	}
	if(newkeys == KEY_NO)
	{
		if(GetPVarInt(playerid,"slivid") != -1)
		{
			new string[128];
			format(string,sizeof(string),"����� %s[%d] ��������� c������ ������ �� ��� ����������",PlayerInfo[playerid][pName],playerid);
			SendClientMessage(GetPVarInt(playerid,"slivid"),COLOR_LIGHTBLUE,string);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� ������� ������ �� ������ ����������");
			SetPVarInt(playerid,"slivid",-1);
			return true;
		}
		if(GetPVarInt(playerid,"repairid") != -1)
		{
			new string[128];
			format(string,sizeof(string),"����� %s[%d] ��������� ������ � ��� ����������",PlayerInfo[playerid][pName],playerid);
			SendClientMessage(GetPVarInt(playerid,"repairid"),COLOR_LIGHTBLUE,string);
			format(string,sizeof(string),"�� ���������� ������ ���������� � %s[%d]",PlayerInfo[GetPVarInt(playerid,"repairid")][pName],GetPVarInt(playerid,"repairid"));
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			SetPVarInt(playerid,"repairid",-1);
			SetPVarInt(playerid,"repairprice",-1);
			return true;
		}
		if(PredlCar[playerid] == true)
		{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� �� �������!");
			SendClientMessage(CarOffer[playerid],COLOR_LIGHTBLUE,"��� �������� � �������!");
			PredlCar[playerid] = false;
			CarPrice[playerid] = 0;
			CarOffer[playerid] = 0;
			SetCameraBehindPlayer(playerid);
		}
		if(MirOffer[playerid] > 0)
		{
			new fam = PlayerInfo[playerid][pLeader];
			switch(MirOffer[playerid])
			{
				case 6:	SendFractionMessage(COLOR_BLUE,"The Groove Street �� �������� ��������� � ���� ���",fam);
				case 7: SendFractionMessage(COLOR_BLUE,"The Ballas Gang �� �������� ��������� � ���� ���",fam);
				case 8: SendFractionMessage(COLOR_BLUE,"Los Santos Vagos �� �������� ��������� � ���� ���",fam);
				case 10:SendFractionMessage(COLOR_BLUE,"El Coronos �� �������� ��������� � ���� ���",fam);
			}
			MirOffer[playerid] = 0;
		}
		if(InviteLive[playerid] == -2)
		{
			new string[128];
			format(string,sizeof(string),"%s[%d] ��������� ������� ������� � ������ ����� � ����",PlayerInfo[playerid][pName],playerid);
			SendClientMessage(InviteLive[playerid],COLOR_LIGHTBLUE,string);
			format(string,sizeof(string),"�� ���������� ������� ������� � ������ ����� � %s[%d]",PlayerInfo[InviteLive[playerid]][pName],InviteLive[playerid]);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
			InviteLive[playerid] = -1;
		}
		if(JailOffer[playerid] != -1)
		{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� �� ������� �� ���");
			SendClientMessage(JailOffer[playerid],COLOR_LIGHTBLUE,"����� ��������� �� ������ �� ���");
			JailOffer[playerid] = -1;
			PriceOffer[playerid] = 0;
		}
		if(MatsOffer[playerid] != -1)
		{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� �� ������� ����������");
			SendClientMessage(MatsOffer[playerid],COLOR_LIGHTBLUE,"����� ��������� �� ������� ����������");
			MatsOffer[playerid] = -1;
			PriceOffer[playerid] = 0;
			Mats[playerid] = 0;
		}
		if(DrugsOffer[playerid] != -1)
		{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���������� �� ������� ����������");
			SendClientMessage(DrugsOffer[playerid],COLOR_LIGHTBLUE,"����� ��������� �� ������� ����������");
			DrugsOffer[playerid] = -1;
			PriceOffer[playerid] = 0;
			Drugs[playerid] = 0;
		}
	}
	if(newkeys == KEY_SPRINT)
	{
		new i = GetPVarInt(playerid,"vyborint");
		if(i >= 0)
		{
			mysql_query("SELECT NULL FROM `property`");
			mysql_store_result();
			new h = mysql_num_rows();
			mysql_free_result();
			HouseInfo[h+1][hEntrancex] = GetPVarFloat(playerid,"PX");
			HouseInfo[h+1][hEntrancey] = GetPVarFloat(playerid,"PY");
			HouseInfo[h+1][hEntrancez] = GetPVarFloat(playerid,"PZ");
			HouseInfo[h+1][hExitx] = Interiors[i][iX];
			HouseInfo[h+1][hExity] = Interiors[i][iY];
			HouseInfo[h+1][hExitz] = Interiors[i][iZ];
			HouseInfo[h+1][hValue] = Interiors[i][iValue];
			HouseInfo[h+1][hLock] = true;
			HouseInfo[h+1][hIcon] = h+1;
			HouseInfo[h+1][hInt] = Interiors[i][iInt];
			HouseInfo[h+1][hLevel] = GetPVarInt(playerid,"LevelHouse");
			HouseInfo[h+1][hID] = h+1;
			new housetext[200];
			format(housetext,sizeof(housetext),""WHT"��� �: "GRN"%d\n"WHT"����: "GRN"%d\n"WHT"������� ����: "GRN"%d",h+1,HouseInfo[h+1][hValue],HouseInfo[h+1][hLevel]);
			HouseInfo[h+1][hLabel] = Create3DTextLabel(housetext,0x008080FF,HouseInfo[h+1][hEntrancex], HouseInfo[h+1][hEntrancey], HouseInfo[h+1][hEntrancez],40.0,0);
			CreateDynamicMapIcon(HouseInfo[h+1][hEntrancex], HouseInfo[h+1][hEntrancey], HouseInfo[h+1][hEntrancez], 31, COLOR_WHITE, 0, -1, -1, 400.0);
			new query[512];
			format(query,sizeof(query), "INSERT INTO `property` (id, ent_x, ent_y, ent_z, ext_x, ext_y, ext_z, price, level, interior,icon) VALUES (%d, %f, %f, %f,%f, %f, %f, %d, %d, %d, %d)",h+1, HouseInfo[h+1][hEntrancex], HouseInfo[h+1][hEntrancey],HouseInfo[h+1][hEntrancez],HouseInfo[h+1][hExitx],HouseInfo[h+1][hExity],HouseInfo[h+1][hExitz],
			HouseInfo[h+1][hValue],HouseInfo[h+1][hLevel], HouseInfo[h+1][hInt], HouseInfo[h+1][hIcon]);
			mysql_query(query);
			HouseInfo[h+1][hPickup] = CreatePickup(1273, 23, HouseInfo[h+1][hEntrancex], HouseInfo[h+1][hEntrancey], HouseInfo[h+1][hEntrancez],0);
			SendClientMessage(playerid,-1,"{FFFFFF}��� {147130}�������{FFFFFF} ��������.");
			SetPVarInt(playerid,"vyborint",-1);
			SetPlayerVirtualWorld(playerid,h+1);
			return true;
		}
		return true;
	}
	if(newkeys == KEY_HANDBRAKE)
	{
		new engine,lights,alarm,doors,bonnet,boot,objective;
		new vehicle = GetPlayerVehicleID(playerid);
		GetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, boot, objective);
		new playerState = GetPlayerState(playerid);
		if(playerState == PLAYER_STATE_DRIVER && engine == 0 && fuel[vehicle] > 0 && !IsBicycle(vehicle) && !IsFly(vehicle) && !IsBoat(vehicle) && zavodit[playerid] == false)
		{
			SetTimerEx("Zavodka", 3000, false, "i", playerid);
			new string[128];
			SetPVarInt(playerid,"vehplayer",vehicle);
			if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"%s �������� ������� ���������",PlayerInfo[playerid][pName]);
			else format(string,sizeof(string),"����������� �������� ������� ���������");
			SendRadiusMessage(15.0, playerid, string,COLOR_PURPLE);
			zavodit[playerid] = true;
		}
		if(playerState == PLAYER_STATE_DRIVER && engine == 1 && !IsBicycle(vehicle) && !IsFly(vehicle) && !IsBoat(vehicle) && GetPlayerSpeed(playerid) == 0)
		{
			new string[128];
			ToggleEngine(vehicle, VEHICLE_PARAMS_OFF);
			if(PlayerInfo[playerid][pMask] == false) format(string,sizeof(string),"%s ��������(�) ���������",PlayerInfo[playerid][pName]);
			else format(string,sizeof(string),"����������� ��������(�) ���������");
			SendRadiusMessage(15.0, playerid, string,COLOR_PURPLE);
		}
	}
	if(newkeys == KEY_CROUCH)
    {
		new engine,lights,alarm,doors,bonnet,boot,objective;
		new vehicle = GetPlayerVehicleID(playerid);
		GetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, boot, objective);
		new playerState = GetPlayerState(playerid);
		for(new i = 0;i < sizeof(KFC) ; i++)
		{
			if (IsPlayerInRangeOfPoint(playerid,3, KFC[i][kX], KFC[i][kY], KFC[i][kZ]) && playerState == PLAYER_STATE_PASSENGER || IsPlayerInRangeOfPoint(playerid,3, KFC[i][kX], KFC[i][kY], KFC[i][kZ]) && playerState == PLAYER_STATE_DRIVER)
			{
				new string[256];
				format(string,sizeof(string),"{FFFFFF}������ {17D6E0}[%d$]{FFFFFF}\n������ {17D6E0}[%d$]{FFFFFF}\n�����  {17D6E0}[%d$]{FFFFFF}", BURGER_PRICE,CHICKEN_PRICE,PEPSI_PRICE);
				SPD(playerid,DIALOG_KFC,DIALOG_STYLE_LIST,""PREFIX" ����������",string,"�������","�����");
			}
		}
		for(new i = 0;i < sizeof(Gas) ; i++)
		{
			if (IsPlayerInRangeOfPoint(playerid,3, Gas[i][gX], Gas[i][gY], Gas[i][gZ]) && playerState == PLAYER_STATE_DRIVER)
			{
				gasp[playerid] = i;
				new string[255];
				format(string,sizeof(string),"{FFFFFF}��-80 {17D6E0}[%d$]{FFFFFF}\n��-92 {17D6E0}[%d$]{FFFFFF}\n��-95  {17D6E0}[%d$]{FFFFFF}\n������  {17D6E0}[%d$]{FFFFFF}", Gas[i][gPrice80],Gas[i][gPrice92],Gas[i][gPrice95],Gas[i][gPriceDisel]);
				SPD(playerid,DIALOG_GAS,DIALOG_STYLE_LIST,""PREFIX" | ��������",string,"�������","������");
			}
		}
	}
	if(newkeys == KEY_FIRE && oldkeys == 128) {
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED) {ApplyAnimationEx(playerid, "GYMNASIUM", "gym_jog_falloff",4.1,0,1,1,0,0);}
	}	
	if(newkeys == KEY_FIRE)
    {
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED) {ApplyAnimationEx(playerid, "GYMNASIUM", "gym_jog_falloff",4.1,0,1,1,0,0);}
		if(PlayerStartJob[playerid])
		{
			if(!IsPlayerInRangeOfPoint(playerid, 3, -1854.7035,-1650.9668,25.7248)
			&& !IsPlayerInRangeOfPoint(playerid, 3, -1803.5344,-1655.2640,25.8294)
			&& !IsPlayerInRangeOfPoint(playerid, 3, -1788.5780,-1640.7179,27.0669)
			&& !IsPlayerInRangeOfPoint(playerid, 3, -1869.1316,-1634.7915,-58.500)
			&& !IsPlayerInRangeOfPoint(playerid, 3, -1868.9603,-1643.6682,-58.046))
			{
				SendClientMessage(playerid, -1, "�� ������� ������.");
				DisablePlayerCheckpoint(playerid);
				ApplyAnimationEx(playerid, "CARRY", "crry_prtial",4.1, 0, 0, 0, 0, 1);
				PlayerStartJob[playerid] = false;
				RemovePlayerAttachedObject(playerid, 6);
				SetPlayerAttachedObject(playerid, 6, 18634, 6, 0.078222, 0.000000, 0.110844, 298.897308, 264.126861, 193.350555, 1.000000, 1.000000, 1.000000);
				GetPlayerMetall[playerid] = 0;
				GetPlayerMetallEx[playerid] = 0;
			}
		}
		if(GetPVarInt(playerid, "smoke") == 1) {
			new Float:health;
			GetPlayerHealth(playerid, health);
			if(health < 100) ServerSetPlayerHealth(playerid, health+10);
			else { SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE); DeletePVar(playerid, "smoke"); }
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			if(GetPlayerWeapon(playerid) == 4)
			{
				new Float:px, Float:py, Float:pz;
				GetPlayerPos(playerid, px, py, pz);
				foreach(Player,i)
				{
					if(!IsPlayerConnected(i)) continue;
					if(!IsPlayerInRangeOfPoint(i, 2.0, px, py, pz)) continue;
					if(GetPlayerAnimationIndex(i) != 747) continue;
					ClearAnimations(i);
					ServerSetPlayerHealth(i, 0.0);
					break;
				}
			}
		}
	}
	if(newkeys == KEY_ANALOG_LEFT)
	{
		new i = GetPVarInt(playerid,"vyborint");
		if(i > 0)
		{
			SetPlayerInterior(playerid,Interiors[i-1][iInt]);
			SetPVarInt(playerid,"vyborint",i-1);
			ServerSetPlayerPos(playerid,Interiors[i-1][iX], Interiors[i-1][iY], Interiors[i-1][iZ]);
		}
	}
	if(newkeys == KEY_ANALOG_RIGHT)
	{
		new i = GetPVarInt(playerid,"vyborint");
		if(i >= 0 && i < 14)
		{
			SetPlayerInterior(playerid,Interiors[i+1][iInt]);
			SetPVarInt(playerid,"vyborint",i+1);
			ServerSetPlayerPos(playerid,Interiors[i+1][iX], Interiors[i+1][iY], Interiors[i+1][iZ]);
		}
	}
	if(newkeys == KEY_WALK)
    {
		new playerState = GetPlayerState(playerid);
		for(new i = 0; i < sizeof(HouseInfo); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 4.0, HouseInfo[GetPlayerVirtualWorld(playerid)][hExitx], HouseInfo[GetPlayerVirtualWorld(playerid)][hExity], HouseInfo[GetPlayerVirtualWorld(playerid)][hExitz]))
			{
				SetPlayerInterior(playerid,0);
				ServerSetPlayerPos(playerid,HouseInfo[GetPlayerVirtualWorld(playerid)][hEntrancex],HouseInfo[GetPlayerVirtualWorld(playerid)][hEntrancey],HouseInfo[GetPlayerVirtualWorld(playerid)][hEntrancez]);
				SetPlayerVirtualWorld(playerid, 0);
				if(HouseInfo[GetPlayerVirtualWorld(playerid)][hHeal] > 1)  ServerSetPlayerHealth(playerid,HouseInfo[GetPlayerVirtualWorld(playerid)][hHeal]);
				if(HouseInfo[GetPlayerVirtualWorld(playerid)][hArmour] == true)  ServerSetPlayerArmour(playerid,160);
			}
			if (IsPlayerInRangeOfPoint(playerid, 4.0, HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]))
			{
				if(PlayerInfo[playerid][pHouse] == i || HouseInfo[i][hLock] == false || PlayerInfo[playerid][pRent] == i || PlayerInfo[playerid][pAdmin] > 0)
				{
					SetPlayerVirtualWorld(playerid,HouseInfo[i][hID]);
					SetPlayerInterior(playerid,HouseInfo[i][hInt]);
					ServerSetPlayerPos(playerid,HouseInfo[i][hExitx],HouseInfo[i][hExity],HouseInfo[i][hExitz]);
					GameTextForPlayer(playerid, "~w~����� ����������!", 5000, 1);
					if(HouseInfo[i][hHeal] > 1) ServerSetPlayerHealth(playerid,HouseInfo[i][hHeal]);
					if(HouseInfo[i][hArmour] == true && IsACop(playerid)) ServerSetPlayerArmour(playerid,160);
				}
			}
		}
		for(new b = 0; b < sizeof(BankInfo); b++)
        {
            if(IsPlayerInRangeOfPoint(playerid, 2.0,BankInfo[b][BankX],BankInfo[b][BankY],BankInfo[b][BankZ])) ShowBankomat(playerid);
        }
		for(new i = 1; i < sizeof(Bankomat); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid,1.0, Bankomat[i][bX], Bankomat[i][bY], Bankomat[i][bZ])) ShowBankomat(playerid);
		}
		for(new i = 1; i < sizeof(Club); i++)
		{
			new id = GetPlayerVirtualWorld(playerid);
			if (IsPlayerInRangeOfPoint(playerid,1.0, Club[i][cEnterX], Club[i][cEnterY], Club[i][cEnterZ]))
			{
				if(GetMoney(playerid) < Club[i][cPriceVx]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF}  � ��� ��� ����� �� ����!");
				SetMoney(playerid, -Club[i][cPriceVx]);
				Club[i][cBank] += Club[i][cPriceVx];
				SetPlayerInterior(playerid,Club[i][cInterior]);
				SetPlayerVirtualWorld(playerid,Club[i][cID]);
				ServerSetPlayerPos(playerid,Club[i][cExitX], Club[i][cExitY], Club[i][cExitZ]);
			}
			if (IsPlayerInRangeOfPoint(playerid,2.0, Club[id][cExitX], Club[id][cExitY], Club[id][cExitZ]))
			{
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
				ServerSetPlayerPos(playerid,Club[id][cEnterX], Club[id][cEnterY], Club[id][cEnterZ]);
			}
			if (IsPlayerInRangeOfPoint(playerid,3, Club[id][cBuyX], Club[id][cBuyY], Club[id][cBuyZ])) 	{SPD(playerid,DIALOG_CLUBBUY,DIALOG_STYLE_MSGBOX,""PREFIX"  �������","{ffffff}�������� ��� �������","���","��������");}
		}
		for(new i = 1; i < sizeof(Magazin); i++)
		{
			new id = GetPlayerVirtualWorld(playerid);
			if (IsPlayerInRangeOfPoint(playerid,1.0, Magazin[i][mEnterX], Magazin[i][mEnterY], Magazin[i][mEnterZ]))
			{
				SetPlayerInterior(playerid,Magazin[i][mInterior]);
				SetPlayerVirtualWorld(playerid,Magazin[i][mID]);
				ServerSetPlayerPos(playerid,Magazin[i][mExitX], Magazin[i][mExitY], Magazin[i][mExitZ]);
			}
			if (IsPlayerInRangeOfPoint(playerid,2.0, Magazin[id][mExitX], Magazin[id][mExitY], Magazin[id][mExitZ]))
			{
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
				ServerSetPlayerPos(playerid,Magazin[id][mEnterX], Magazin[id][mEnterY], Magazin[id][mEnterZ]);
			}
			if (IsPlayerInRangeOfPoint(playerid,3, Magazin[id][mBuyX], Magazin[id][mBuyY], Magazin[id][mBuyZ]))
			{
				SPD(playerid,DIALOG_BUY,DIALOG_STYLE_LIST,""PREFIX"  �������","{3CBBF7}[1]{ffffff} ����� �������\t(1500$)\n{3CBBF7}[2]{ffffff} �����������\t(150$)\n{3CBBF7}[3]{ffffff} ����� �������� (20 ��.)\t(100$)\n{3CBBF7}[4]{ffffff} �������\t(100$)\n{3CBBF7}[5]{ffffff} ���������� �����\t(100$)","�������","������");
			}
		}
		for(new i = 1; i < sizeof(Ammo); i++)
		{
			new id = GetPlayerVirtualWorld(playerid);
			if (IsPlayerInRangeOfPoint(playerid,3, Ammo[i][amEnterX], Ammo[i][amEnterY], Ammo[i][amEnterZ]))
			{
				if(GetMoney(playerid) < Ammo[i][amPriceVx]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF}  � ��� ��� ����� �� ����!");
				SetMoney(playerid, -Ammo[i][amPriceVx]);
				Ammo[i][amBank] += Ammo[i][amPriceVx];
				SetPlayerInterior(playerid,Ammo[i][amInterior]);
				SetPlayerVirtualWorld(playerid,Ammo[i][amID]);
				ServerSetPlayerPos(playerid,Ammo[i][amExitX], Ammo[i][amExitY], Ammo[i][amExitZ]);
			}
			if (IsPlayerInRangeOfPoint(playerid,3, Ammo[id][amExitX], Ammo[id][amExitY], Ammo[id][amExitZ]))
			{
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
				ServerSetPlayerPos(playerid,Ammo[id][amEnterX], Ammo[id][amEnterY], Ammo[id][amEnterZ]);
			}
			if (IsPlayerInRangeOfPoint(playerid,3, Ammo[id][amBuyX], Ammo[id][amBuyY], Ammo[id][amBuyZ]))
			{
				if(PlayerInfo[playerid][pLic][4] == false) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF}  � ��� ��� �������� �� ������� ������!");
				new gun3[512];
				strcat(gun3,"{3CBBF7}[1]{ffffff} 9mm\t\t\t(10$ �� ���� ������)\n{3CBBF7}[2]{ffffff} Silenced 9mm\t(15$ �� ���� ������)\n{3CBBF7}[3]{ffffff} Desert Eagle\t(30$ �� ���� ������)\n{3CBBF7}[4]{ffffff} ShotGun\t\t(40$ �� ���� ������)\n{3CBBF7}[5]{ffffff} MP-5\t\t(35$ �� ���� ������)\n");
				strcat(gun3,"{3CBBF7}[6]{ffffff} AK-47\t\t(50$ �� ���� ������)\n{3CBBF7}[7]{ffffff} M-4\t\t\t(50$ �� ���� ������)");
				SPD(playerid,DIALOG_BUY_GUN,DIALOG_STYLE_LIST,""PREFIX"  ������� ������",gun3,"�������","������");
			}
		}
		for(new i = 1; i < sizeof(Job); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid,3, Job[i][jX], Job[i][jY], Job[i][jZ]))
			{
				if(PlayerInfo[playerid][pJob] > 0 && PlayerInfo[playerid][pJob] != Job[i][jID]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} � ��� ��� ���� ������. ������� � ��!");
				if(Job[i][jLevel] > PlayerInfo[playerid][pLevel]) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ������� ������� ��� ��� ���� ������!");
				if(Job[i][jID] == 1 && !IsAGang(playerid)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ������ �������� ������ ��� ����!");
				new joba[150],job1[150];
				format(joba,sizeof(joba),""PREFIX" ������: %s",Job[i][jName]);
				format(job1,sizeof(job1),"{FFFFFF}�� ������ ��������� �� ������: {17D6E0}%s{FFFFFF}.����������� �a ��� ��� ��� ������.",Job[i][jName]);
				SPD(playerid,DIALOG_JOB,DIALOG_STYLE_MSGBOX,joba,job1,"��","���");
				SetPVarInt(playerid,"job",i);
			}
			if (IsPlayerInRangeOfPoint(playerid,3, Job[i][jX], Job[i][jY], Job[i][jZ]) && PlayerInfo[playerid][pJob] == Job[i][jID])
			{
				new joba[150],job1[150];
				format(joba,sizeof(joba),""PREFIX" ������: %s",Job[i][jName]);
				format(job1,sizeof(job1),"{FFFFFF}�� ������ ��������� � ������: {17D6E0}%s{FFFFFF}.����������� �� ��� ��� ��� ������.",Job[i][jName]);
				SPD(playerid,DIALOG_JOB_UVAL,DIALOG_STYLE_MSGBOX,joba,job1,"��","���");
				SetPVarInt(playerid,"job",i);
			}
		}
		for(new i = 0;i < sizeof(KFC) ; i++)
		{
			if (IsPlayerInRangeOfPoint(playerid,3, KFC[i][kX], KFC[i][kY], KFC[i][kZ]) && playerState == PLAYER_STATE_ONFOOT)
			{
				new string[256];
				format(string,sizeof(string),"{3CBBF7}[1]{ffffff} ������ {17D6E0}[%d$]{FFFFFF}\n{3CBBF7}[2]{ffffff} ������ {17D6E0}[%d$]{FFFFFF}\n{3CBBF7}[3]{ffffff} �����  {17D6E0}[%d$]{FFFFFF}", BURGER_PRICE,CHICKEN_PRICE,PEPSI_PRICE);
				SPD(playerid,DIALOG_KFC,DIALOG_STYLE_LIST,""PREFIX" ����������",string,"OK","�����");
			}
		}
		for(new i = 1; i < sizeof(Race); i++) {
			if(IsPlayerInRangeOfPoint(playerid, 3.0, Race[i][RegX], Race[i][RegY], Race[i][RegZ]) && Race[i][Reg] == true && GetPVarInt(playerid, "race") == 0)
			{
				if(PlayerInfo[playerid][pLic][1] == false) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ������� � ����� ��� ����� ���. �����!");
				SetPVarInt(playerid, "race", i);
				new string[512];
				format(string, sizeof(string), ""WHT"\t\t1. %s\n\t\t2. %s\n\t\t3. %s\n\t\t4. %s\n\t\t5. %s\n\t"YE"�������� ���� �����: "GRN"5.000$"YE"\n\t�� ������������� ������ �����������?",
				Race[i][Who1],
				Race[i][Who2],
				Race[i][Who3],
				Race[i][Who4],
				Race[i][Who5]);
				SPD(playerid, DIALOG_RACE, DIALOG_STYLE_MSGBOX, ""PREFIX" �����", string, "��", "���");
				return true;
			}
		}
		new fam = GetPlayerMember(playerid);
		if (IsPlayerInRangeOfPoint(playerid,1.5,1555.5018,-1675.6222,16.1953)){ SetPlayerInterior(playerid, 6); ServerSetPlayerPos(playerid,246.783996,63.900199,1003.640625); SetPlayerVirtualWorld(playerid,0); } //����������� �������
		if (IsPlayerInRangeOfPoint(playerid,1.5,246.8528,62.3188,1003.6406)) { if(PlayerInfo[playerid][pJailed] > 0) { PlayerInfo[playerid][pJailTime] += 5*60; JailPlayer(playerid); } else { SetPlayerInterior(playerid, 0); ServerSetPlayerPos(playerid,1552.4901,-1675.1837,16.1953); SetPlayerVirtualWorld(playerid,0); } }
		if (IsPlayerInRangeOfPoint(playerid,1.5,-2031.2075,-96.7104,35.1641)) { SetPlayerInterior(playerid, 3); ServerSetPlayerPos(playerid,-2029.798339,-106.675910,1035.171875);  CreateDynamicCP(1139.4037,-609.3749,1089.9359,1.0,1,3,playerid,2.0); }//A�
		if	(IsPlayerInRangeOfPoint(playerid,1.5,-2026.8627,-103.6067,1035.1814)) { SetPlayerInterior(playerid, 0); ServerSetPlayerPos(playerid,-2031.2075,-96.7104,35.1641);  }
		if	(IsPlayerInRangeOfPoint(playerid,1.5,2127.5352,2379.9233,10.8203))//��������
		{
			if(fam == 5) { SetPlayerInterior(playerid, 3); ServerSetPlayerPos(playerid,390.7631,173.8201,1008.3828); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,390.7631,173.8201,1008.3828)) { SetPlayerInterior(playerid, 0); ServerSetPlayerPos(playerid,2127.7366,2379.9280,10.8203); SetPlayerVirtualWorld(playerid,0); }
		if	(IsPlayerInRangeOfPoint(playerid,1.5,2000.0444,-1114.0533,27.1250))//������
		{
			if(fam == 7) { SetPlayerInterior(playerid, 6); ServerSetPlayerPos(playerid,744.3876,1436.3402,1102.7031); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,744.3876,1436.3402,1102.7031)) { SetPlayerInterior(playerid, 0); ServerSetPlayerPos(playerid,2000.0444,-1114.0533,27.1250); SetPlayerVirtualWorld(playerid,0); }
		if	(IsPlayerInRangeOfPoint(playerid,1.5,2807.9980,-1190.8875,25.3432))//�����
		{
			if(fam == 8) { SetPlayerInterior(playerid, 5); ServerSetPlayerPos(playerid,318.6307,1114.4857,1083.8828);  SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,318.6307,1114.4857,1083.8828))
		{
			if(fam == 8) { SetPlayerInterior(playerid, 0); ServerSetPlayerPos(playerid,2807.9980,-1190.8875,25.3432); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,937.2737,1734.0522,8.8516))//��
		{
			if(fam == 9) { SetPlayerInterior(playerid, 8); ServerSetPlayerPos(playerid,2807.5784,-1174.7576,1025.5703);  SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,2807.5784,-1174.7576,1025.5703))
		{
			if(fam == 9) { SetPlayerInterior(playerid, 0); 	ServerSetPlayerPos(playerid,937.2737,1734.0522,8.8516); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,1752.4961,-1911.9286,13.5674))//�������
		{
			if(fam == 10) { SetPlayerInterior(playerid, 1); ServerSetPlayerPos(playerid,-2158.5771,643.1402,1052.3750); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,-2158.5771,643.1402,1052.3750))
		{
			if(fam == 10) { SetPlayerInterior(playerid, 0); ServerSetPlayerPos(playerid,1752.4961,-1911.9286,13.5674); 	SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,-2717.9114,-317.6669,7.8438))//���
		{
			if(fam == 11) { SetPlayerInterior(playerid, 1); ServerSetPlayerPos(playerid,-2158.6055,643.1419,1052.3750); SetPlayerVirtualWorld(playerid,1); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,-2158.6055,643.1419,1052.3750))
		{
			if(fam == 11) { SetPlayerInterior(playerid, 0); ServerSetPlayerPos(playerid,-2717.9114,-317.6669,7.8438); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,-2226.9026,251.8453,35.3203))//���
		{
			if(fam == 13) { SetPlayerInterior(playerid, 8); ServerSetPlayerPos(playerid,2807.7092,-1174.7399,1025.5703); SetPlayerVirtualWorld(playerid,1); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,2807.7092,-1174.7399,1025.5703))
		{
			if(fam == 13) { SetPlayerInterior(playerid, 0); ServerSetPlayerPos(playerid,-2226.9026,251.8453,35.3203); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,870.3918,-24.9187,63.9864))//����
		{
			if(fam == 14) { SetPlayerInterior(playerid, 3); ServerSetPlayerPos(playerid,1212.0514,-25.8745,1000.9531); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,1212.0514,-25.8745,1000.9531)) { SetPlayerInterior(playerid, 0); ServerSetPlayerPos(playerid,870.3918,-24.9187,63.9864); SetPlayerVirtualWorld(playerid,0); }
		if	(IsPlayerInRangeOfPoint(playerid,1.5,1480.8422,-1772.0840,18.7958))//��������
		{
			if(fam == 15) { SetPlayerInterior(playerid, 3); ServerSetPlayerPos(playerid,238.6510,138.7305,1003.0234); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,238.6510,138.7305,1003.0234)) { SetPlayerInterior(playerid, 0); ServerSetPlayerPos(playerid,1480.8422,-1772.0840,18.7958); SetPlayerVirtualWorld(playerid,0); }
		if	(IsPlayerInRangeOfPoint(playerid,1.5,2633.7690,1716.6880,11.0234))//������
		{
			if(fam == 16) { SetPlayerInterior(playerid, 5); ServerSetPlayerPos(playerid,1260.6461,-785.5029,1091.9063); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,1260.6461,-785.5029,1091.9063))
		{
			if(fam == 16) { SetPlayerInterior(playerid, 0); ServerSetPlayerPos(playerid,2633.7690,1716.6880,11.0234); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,-2521.1777,-624.9500,132.7839))//���
		{
			if(IsACop(playerid)) { SetPlayerInterior(playerid, 10); ServerSetPlayerPos(playerid,246.2218,107.2999,1003.2188); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,246.2218,107.2999,1003.2188))
		{
			if(IsACop(playerid)) { SetPlayerInterior(playerid, 0); ServerSetPlayerPos(playerid,-2521.1777,-624.9500,132.7839); SetPlayerVirtualWorld(playerid,0); }
		}
		if	(IsPlayerInRangeOfPoint(playerid,1.5,251.8308,117.3878,1003.2188))
		{
			if(fam == 2) {SPD(playerid,DIALOG_AUTO_ZAKAZ,DIALOG_STYLE_LIST,""PREFIX" ����� ����������","Admiral\nBuccaneer\nWashington\nBullet\nHustler\nTurismo\nElegant\nElegy\nMerit\nPrimo","�������","������");}
		}
		if 	(IsPlayerInRangeOfPoint(playerid,3.5,2144.1592,1626.4706,993.6882) && PlayerInfo[playerid][pOtm] > 0 && open == false)
		{
			if(!IsACop(playerid))
			{
				if(PlayerInfo[playerid][pWanted] == 0)
				{
					if(open == false)
					{
						SetTimerEx("Vzlom",5000,false,"i",playerid);
						new string[128];
						format(string,sizeof(string),"%s �������� �������� ����� � ���������",PlayerInfo[playerid][pName]);
						SendRadiusMessage(10.0, playerid, string,COLOR_PURPLE);
						open = true;
					}
				}
				else SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF}  �� � �������,�������� ����������!");
			}
		}
		if	(IsPlayerInRangeOfPoint(playerid, 3.0, 1461.7260,-1010.2776,26.8438)) { ServerSetPlayerPos(playerid, 2308.2004,-16.0667,26.7496); }
		if	(IsPlayerInRangeOfPoint(playerid, 3.0, 2304.6873,-16.1246,26.7422)) { SetPlayerInterior(playerid,0);  ServerSetPlayerPos(playerid,1462.2925,-1014.1252,26.6913); }
		if	(IsPlayerInRangeOfPoint(playerid,2.0,758.7222,-59.9124,1000.7802) || IsPlayerInRangeOfPoint(playerid,2.0,756.4216,6.1888,1000.6993) || IsPlayerInRangeOfPoint(playerid,2.0,754.6369,-25.9861,1000.5859))	{SPD(playerid,DIALOG_FSTYLE,DIALOG_STYLE_LIST,"����� ����� ���","{3CBBF7}[1]{ffffff}\tBoxing\n{3CBBF7}[2]{ffffff}\tKung-Fu\n{3CBBF7}[3]{ffffff}\tKneehead\n{3CBBF7}[4]{ffffff}\tGrabkick","�������","������");}
		if 	(IsPlayerInRangeOfPoint(playerid,3.5,2315.5581,0.3544,26.7422))  { ServerSetPlayerPos(playerid,2143.8999000,1599.0999800,1003.7000100); SetPlayerInterior(playerid, 1); } //���������
		if 	(IsPlayerInRangeOfPoint(playerid,3.5,2145.7627,1597.4769,1003.9677))  { ServerSetPlayerPos(playerid,2308.2004,-16.0667,26.7496); SetPlayerInterior(playerid, 0); } //���������
		if  (IsPlayerInRangeOfPoint(playerid,3.5,2495.4758,-1691.1389,14.7656) && fam == 6) { SetPlayerInterior(playerid, 3); ServerSetPlayerPos(playerid,2495.9465,-1692.0886,1014.7422); SetPlayerVirtualWorld(playerid,0); }//����
		if	(IsPlayerInRangeOfPoint(playerid,3.5,2495.9465,-1692.0886,1014.7422)) { ServerSetPlayerPos(playerid,2494.8269,-1687.8478,13.5155); SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid,0); }//����
		if	(IsPlayerInRangeOfPoint(playerid,1.5,461.5806,-1500.8630,31.0483)) { ServerSetPlayerPos(playerid,204.2764,-168.8568,1000.5234); SetPlayerInterior(playerid,14); SetPlayerVirtualWorld(playerid,0); }//������� ������
		if	(IsPlayerInRangeOfPoint(playerid,1.5,204.2764,-168.8568,1000.5234)) { ServerSetPlayerPos(playerid,461.5806,-1500.8630,31.0483); SetPlayerInterior(playerid,0); }
		if	(IsPlayerInRangeOfPoint(playerid,1.5,2229.8406,-1721.1965,13.5606)) { ServerSetPlayerPos(playerid,772.111999,-3.898649,1000.728820); SetPlayerInterior(playerid,5); SetPlayerVirtualWorld(playerid,0); }//LS GYM
		if	(IsPlayerInRangeOfPoint(playerid,1.5,772.2454,-5.5164,1000.7283)) { ServerSetPlayerPos(playerid,2229.8406,-1721.1965,13.5606); SetPlayerInterior(playerid,0); }
		if	(IsPlayerInRangeOfPoint(playerid,1.5,1968.8245,2295.8728,16.4559)) { ServerSetPlayerPos(playerid,773.579956,-77.096694,1000.655029); SetPlayerInterior(playerid,7); SetPlayerVirtualWorld(playerid,0); }//LV GYM
		if	(IsPlayerInRangeOfPoint(playerid,1.5,773.8295,-78.8459,1000.6628)) { ServerSetPlayerPos(playerid,1968.8245,2295.8728,16.4559); SetPlayerInterior(playerid,0); }
		if	(IsPlayerInRangeOfPoint(playerid,1.5,-2270.6475,-155.8572,35.3203)) { ServerSetPlayerPos(playerid,774.213989,-48.924297,1000.585937); SetPlayerInterior(playerid,6); SetPlayerVirtualWorld(playerid,0); }//SF GYM
		if	(IsPlayerInRangeOfPoint(playerid,1.5,774.0494,-50.4761,1000.5859)) { ServerSetPlayerPos(playerid,-2270.6475,-155.8572,35.3203); SetPlayerInterior(playerid,0); }
		if	(IsPlayerInRangeOfPoint(playerid,1.5,1139.4037,-609.3749,1089.9359))
		{
			if(PlayerInfo[playerid][pStartAsh] > 0) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} �� ��� ���a�� ����!");
			if(PlayerInfo[playerid][pLic][1] == true) return SendClientMessage(playerid, 0xFF0000AA, "{F31212}[������]{FFFFFF} � ��� ��� ���� �����!");
			PlayerInfo[playerid][pStartAsh] = 2;
			SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} ����� �� ��������� � ������ � ������ ��� ����� ������������ �����");
		}
		if	(IsPlayerInRangeOfPoint(playerid,2.5,1697.1306,916.5074,10.8153) && PlayerInfo[playerid][pJob] == 1) { SPD(playerid,DIALOG_ZAKUPKA,DIALOG_STYLE_INPUT,""PREFIX" ������� �����","{FFFFFF}1 c����:\t20 �������\n2 �����:\t40 �������\n3 �����:\t60 �������\n4 �����:\t80 �������\n5 �����:\t100 �������","�����","������"); }
		if	(IsPlayerInRangeOfPoint(playerid,2.5,-2947.5974,504.1858,2.4297) && PlayerInfo[playerid][pJob] == 1)
		{
			if(pakety[playerid] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF}  � ��� ��� �������!");
			new maty = pakety[playerid]*10;
			PlayerInfo[playerid][pMats] = maty;
			new string[128];
			format(string,sizeof(string),"{FFFFFF}�� ������� {17D6E0}%d{FFFFFF} ������� � �������� {17D6E0}%d{FFFFFF} ����������",pakety[playerid],maty);
			SendClientMessage(playerid,-1,string);
			PlayerInfo[playerid][pGunSkill] ++;
			pakety[playerid] = 0;
		}
		if	(IsPlayerInRangeOfPoint(playerid,2.5,-1060.3180,-1205.4827,129.2188) && PlayerInfo[playerid][pJob] == 4) {SPD(playerid,DIALOG_ZAKUPKA_TRAVA,DIALOG_STYLE_INPUT,""PREFIX" ������� �����","{FFFFFF}1 c����:\t20 �����\n2 �����:\t40 �����\n3 �����:\t60 �����\n4 �����:\t80 �����\n5 �����:\t100 �����","�����","������");}
		if	(IsPlayerInRangeOfPoint(playerid,2.5,-1741.6755,1428.6117,7.1875) && PlayerInfo[playerid][pJob] == 4)
		{
			if(trava[playerid] == 0) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF}  � ��� ��� �����!");
			new drugs = trava[playerid]*20;
			PlayerInfo[playerid][pDrugs] = drugs;
			new string[128];
			format(string,sizeof(string),"{FFFFFF}�� ���������� {17D6E0}%d{FFFFFF} ����� � �������� {17D6E0}%d{FFFFFF} ����������",trava[playerid],drugs);
			SendClientMessage(playerid,-1,string);
			PlayerInfo[playerid][pDrugSkill] ++;
			trava[playerid] = 0;
		}
		if	(IsPlayerInRangeOfPoint(playerid,2.5,-2022.3580,-116.6251,1035.1719)) {SPD(playerid,DIALOG_LIC_BUY,DIALOG_STYLE_LIST,""PREFIX" ������� ��������" ,"{3CBBF7}[1]{ffffff}\t�������� �� ���������� ������� (1500$)\n{3CBBF7}[2]{ffffff}\t�������� �� ���������� ������� ����������� (1500$)\n{3CBBF7}[3]{ffffff}\t�������� �� ������� ������ (9000$)","�������","������");}
		if(IsPlayerInRangeOfPoint(playerid,2.0,2144.1636,1634.0487,993.5761))
		{
			if(meshokp[playerid] == 0 && !IsACop(playerid))
			{
				new summa = random(5000);
				new string[128];
				format(string,sizeof(string),"%s[%d] ����� �� ����� %s$",PlayerInfo[playerid][pName],playerid,ConvertCash(summa));
				SendRadiusMessage(10.0, playerid, string,COLOR_PURPLE);
				meshokp[playerid] = summa;
				ApplyAnimationEx(playerid, "CARRY", "crry_prtial",4.1, 0, 0, 0, 1, 1);
				SetPlayerAttachedObject(playerid,5,1550,3,0.286000,-0.392000,-0.035000,-23.900001,1.099999,2.299999,1.000000,1.000000,1.000000);
			}
		}
		for(new i = 1; i < MAX_VEHICLES; i++)
		{
			if(DistPlayerToVehicle(3,playerid,i) && meshokp[playerid] > 0)
			{
				new vehicle = i;
				new Float:POS[3];
				GetVehiclePos(vehicle,POS[0], POS[1], POS[2]);
				GetXYInFrontOfVehicle(vehicle,POS[0],POS[1], -3);
				if (IsPlayerInRangeOfPoint(playerid,5.0,POS[0], POS[1], POS[2]))
				{
					new engine,lights,alarm,doors,bonnet,boot,objective;
					GetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, boot, objective);
					if(boot == 1)
					{
						new summa = dengi[vehicle] + meshokp[playerid];
						if(summa >= 50000) { SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} �������� �����,��� �������� ������!"); SetPlayerCheckpoint(playerid,2825.9771,-2377.7727,12.0747,3.0); return true; }
						new string[128];
						format(string,sizeof(string),"%s ������� � ������ %s$",PlayerInfo[playerid][pName],ConvertCash(meshokp[playerid]));
						SendRadiusMessage(10.0, playerid, string, COLOR_PURPLE);
						dengi[vehicle] += meshokp[playerid];
						meshokp[playerid] = 0;
						RemovePlayerAttachedObject(playerid, 5);
						ClearAnimations(playerid);
						SetPlayerCheckpoint(playerid,2741.2917,-2009.8397,13.5547,3.0);
					}
					else SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF}  �������� ���� ������ ������!");
				}
			}
		}
		if (IsPlayerInRangeOfPoint(playerid,2.5,1560.0128,-1692.6910,5.8906) || IsPlayerInRangeOfPoint(playerid,2.5,241.5848,112.8704,1003.2188) || IsPlayerInRangeOfPoint(playerid,2.5,-1339.0009,489.6227,11.1953) )
		{
			if(IsACop(playerid)) {SPD(playerid,DIALOG_COPGUN,DIALOG_STYLE_LIST,""PREFIX" ����� ������","Deagle\nShotGun\nM4\nMP5\n�������","�����","������");}
		}
		for(new i = 1; i < sizeof(Fraction); i++)
		{
			if	(IsPlayerInRangeOfPoint(playerid,2.5,Fraction[i][fBX],Fraction[i][fBY],Fraction[i][fBZ]))
			{
				if(fam == Fraction[i][fID])
				{
					new obshak[255];
					format(obshak,sizeof(obshak),"{3CBBF7}[1]{ffffff} ���������:\t {3CBBF7}%d{ffffff} \n{3CBBF7}[2]{ffffff} ���������:\t {3CBBF7}%d{ffffff} \n{3CBBF7}[3]{ffffff} ������:\t {3CBBF7}%s{ffffff} ",Fraction[i][fMats],Fraction[i][fDrugs],ConvertCash(Fraction[i][fMoney]));
					SPD(playerid,DIALOG_OBSH,DIALOG_STYLE_LIST,""PREFIX" �����",obshak,"�������","������");
				}
			}
		}
	}
	if(newkeys == 262144)
	{
		SPD(playerid, DIALOG_RADIO, DIALOG_STYLE_LIST, ""PREFIX" �����","[0] ������ FM\n[1] ������ +\n[2] Maks FM\n[3] Alpino FM\n[4] RnB\n[5] ROKS (UA)\n[6] Kazantip\n[7] Pop Hit\n[8] Retro\n[9] Rock Music\n[10] Lyrics RUS\n[11] Rap\n[12] Pop\n[13] Kiev FM\n[14] PopRock\n[15] PopHit(UA)\n[17] Hip-Hop\n[18] Alternative\n[19] Country\n[20] Dance\n[21] Disco\n[22] DAB\n[23] Dubstep\n[24] Electro-House\n[25] HardRock\n[26] HeavyMetal\n{FFA500}��������� �����", "�����", "�����");
	}
	return true;
}
forward OnIntAdd(playerid, params[]);
public OnIntAdd(playerid, params[])
{
	new i = GetPVarInt(playerid,"vyborint");
	if(i >= 0)
	{
		new h = mysql_num_rows();
		HouseInfo[h+1][hEntrancex] = GetPVarFloat(playerid,"PX");
		HouseInfo[h+1][hEntrancey] = GetPVarFloat(playerid,"PY");
		HouseInfo[h+1][hEntrancez] = GetPVarFloat(playerid,"PZ");
		HouseInfo[h+1][hExitx] = Interiors[i][iX];
		HouseInfo[h+1][hExity] = Interiors[i][iY];
		HouseInfo[h+1][hExitz] = Interiors[i][iZ];
		HouseInfo[h+1][hValue] = Interiors[i][iValue];
		HouseInfo[h+1][hLock] = true;
		HouseInfo[h+1][hIcon] = h+1;
		HouseInfo[h+1][hInt] = Interiors[i][iInt];
		HouseInfo[h+1][hLevel] = GetPVarInt(playerid,"LevelHouse");
		new housetext[200];
		format(housetext,sizeof(housetext),""WHT"��� �: "GRN"%d\n"WHT"����: "GRN"%d\n"WHT"������� ����: "GRN"%d",h+1,HouseInfo[h+1][hValue],HouseInfo[h+1][hLevel]);
		HouseInfo[h+1][hLabel] = Create3DTextLabel(housetext,0x008080FF,HouseInfo[h+1][hEntrancex], HouseInfo[h+1][hEntrancey], HouseInfo[h+1][hEntrancez],40.0,0);
		CreateDynamicMapIcon(HouseInfo[h+1][hEntrancex], HouseInfo[h+1][hEntrancey], HouseInfo[h+1][hEntrancez], 31, COLOR_WHITE, 0, -1, -1, 400.0);
		new query[512];
		format(query,sizeof(query), "INSERT INTO `property` (ent_x, ent_y, ent_z, ext_x, ext_y, ext_z, price, level, interior,icon) VALUES (%f, %f, %f,%f, %f, %f, %d, %d, %d, %d)",HouseInfo[h+1][hEntrancex], HouseInfo[h+1][hEntrancey],HouseInfo[h+1][hEntrancez],HouseInfo[h+1][hExitx],HouseInfo[h+1][hExity],HouseInfo[h+1][hExitz],
		HouseInfo[h+1][hValue],HouseInfo[h+1][hLevel], HouseInfo[h+1][hInt], HouseInfo[h+1][hIcon]);
		mysql_query(query);
		HouseInfo[h+1][hPickup] = CreatePickup(1273, 23, HouseInfo[h+1][hEntrancex], HouseInfo[h+1][hEntrancey], HouseInfo[h+1][hEntrancez],0);
		SendClientMessage(playerid,-1,"{FFFFFF}��� {147130}�������{FFFFFF} ��������.");
		SetPVarInt(playerid,"vyborint",-1);
		SetPlayerVirtualWorld(playerid,h+1);
	}
	return true;
}
SPD(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
    SetPVarInt(playerid,"ALANTICRASH1",dialogid);
    return ShowPlayerDialog(playerid,dialogid,style,caption,info,button1,button2);
}
stock ServerGivePlayerWeapon (playerid, weaponid, ammo)
{
	GunCheckTime[playerid] = 5;
	if (weaponid==1) Weapon[playerid][wSlot0] += ammo;
	else if (weaponid==2||weaponid==3||weaponid==4||weaponid==5||weaponid==6||weaponid==7||weaponid==8||weaponid==9) { Weapon[playerid][wSlot1] += ammo; Weapon[playerid][wGun][0] = weaponid; }
	else if (weaponid==22||weaponid==23||weaponid==24) { Weapon[playerid][wSlot2] += ammo; Weapon[playerid][wGun][1] = weaponid; }
	else if (weaponid==25||weaponid==26||weaponid==27)  { Weapon[playerid][wSlot3] += ammo; Weapon[playerid][wGun][2] = weaponid; }
	else if (weaponid==28||weaponid==29||weaponid==32)  { Weapon[playerid][wSlot4] += ammo; Weapon[playerid][wGun][3] = weaponid; }
	else if (weaponid==30||weaponid==31) { Weapon[playerid][wSlot5] += ammo; Weapon[playerid][wGun][4] = weaponid; }
	else if (weaponid==33||weaponid==34) { Weapon[playerid][wSlot6] += ammo; Weapon[playerid][wGun][5] = weaponid; }
	else if (weaponid==35||weaponid==36||weaponid==37||weaponid==38) { Weapon[playerid][wSlot7] += ammo; Weapon[playerid][wGun][6] = weaponid; }
	else if (weaponid==16||weaponid==17||weaponid==18||weaponid==39) { Weapon[playerid][wSlot8] += ammo; Weapon[playerid][wGun][7] = weaponid; }
	else if (weaponid==41||weaponid==42||weaponid==43) { Weapon[playerid][wSlot9] += ammo; Weapon[playerid][wGun][8] = weaponid; }
	else if (weaponid==10||weaponid==11||weaponid==12||weaponid==13||weaponid==14||weaponid==15) { Weapon[playerid][wSlot10] += ammo; Weapon[playerid][wGun][9] = weaponid; }
	else if (weaponid==44||weaponid==45) { Weapon[playerid][wSlot11] += ammo; Weapon[playerid][wGun][10] = weaponid; }
	else if (weaponid==40) Weapon[playerid][wSlot12] = ammo;
	GivePlayerWeapon(playerid, weaponid, ammo);
}
stock GunCheat(playerid, weaponid)
{
	new weap[32];
	GetWeaponName(weaponid,weap,sizeof(weap));
	ServerResetPlayerWeapons(playerid);
	new string[128];
	format(string,sizeof(string),"{F31212}[AAC]{FFFFFF}: %s[%d] ���(�) ������(�) � ������� �� ��������� ������",PlayerInfo[playerid][pName],playerid);
	SendAdminMessage(-1,string,1);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���(�) ������(�) �� ��������� ������!");
	ALKick(playerid);
	return true;
}

stock CheckMoney(playerid)
{
	if(PlayerInfo[playerid][pMoney] < GetPlayerMoney(playerid)) 
	{  
		  ResetPlayerMoney(playerid); 
		  GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);  
	} 
	else if(PlayerInfo[playerid][pMoney] > GetPlayerMoney(playerid)) 
	{ 
		   PlayerInfo[playerid][pMoney] = GetPlayerMoney(playerid); 
	} 	
	return true;
}

stock CheckHealth(playerid)
{
    new Float: Health;
    if(IsPlayerConnected(playerid) && !Sprunk(playerid))
	{
		GetPlayerHealth(playerid, Health);
		if(PlayerHealth[playerid] < Health) SetPlayerHealth(playerid, PlayerHealth[playerid]);
		else PlayerHealth[playerid] = Health;
	}
    return true;
}
stock CheckArmour(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        new Float: Armour;
        GetPlayerArmour(playerid, Armour);
        if(PlayerArmor[playerid] < Armour) SetPlayerArmour(playerid, PlayerArmor[playerid]);
        else PlayerArmor[playerid] = Armour;
    }
    return true;
}
stock ServerSetPlayerHealth(playerid, Float: Health)
{
    if(IsPlayerConnected(playerid))
    {
        PlayerHealth[playerid] = Health;
        SetPlayerHealth(playerid, Health);
    }
    return true;
}

stock ServerSetPlayerArmour(playerid, Float: Armor)
{
	if(IsPlayerConnected(playerid))
	{
		PlayerArmor[playerid] = Armor;
		SetPlayerArmour(playerid, Armor);
	}
	return true;
}
stock CheckWeapon(playerid)
{
	if(GunCheckTime[playerid] == 0)
	{
		new weaponid, ammo;
		for (new i = 0; i < 13; i++)
		{
	    	GetPlayerWeaponData(playerid, i, weaponid, ammo);
			if (weaponid==1)
			{
				if(Weapon[playerid][wSlot0] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot0] = ammo; }
			}
			else if (weaponid==2||weaponid==3||weaponid==4||weaponid==5||weaponid==6||weaponid==7||weaponid==8||weaponid==9)
			{
			    if(Weapon[playerid][wSlot1] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot1] = ammo; }
			}
			else if (weaponid==22||weaponid==23||weaponid==24)
			{
			    if(Weapon[playerid][wSlot2] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot2] = ammo; }
			}
			else if (weaponid==25||weaponid==26||weaponid==27)
			{
			    if(Weapon[playerid][wSlot3] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot3] = ammo; }
			}
			else if (weaponid==28||weaponid==29||weaponid==32)
			{
			    if(Weapon[playerid][wSlot4] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot4] = ammo; }
			}
			else if (weaponid==30||weaponid==31)
			{
			    if(Weapon[playerid][wSlot5] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot5] = ammo; }
			}
			else if (weaponid==33||weaponid==34)
			{
			    if(Weapon[playerid][wSlot6] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot6] = ammo; }
			}
			else if (weaponid==35||weaponid==36||weaponid==37||weaponid==38)
			{
			    if(Weapon[playerid][wSlot7] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot7] = ammo; }
			}
			else if (weaponid==16||weaponid==17||weaponid==18||weaponid==39)
			{
			    if(Weapon[playerid][wSlot8] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot8] = ammo; }
			}
			else if (weaponid==41||weaponid==42||weaponid==43)
			{
			    if(Weapon[playerid][wSlot9] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot9] = ammo; }
			}
			else if (weaponid==10||weaponid==11||weaponid==12||weaponid==13||weaponid==14||weaponid==15)
			{
			    if(Weapon[playerid][wSlot10] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot10] = ammo; }
			}
			else if (weaponid==44||weaponid==45)
			{
			    if(Weapon[playerid][wSlot11] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot11] = ammo; }
			}
			else if (weaponid==40)
			{
			    if(Weapon[playerid][wSlot12] < ammo) { GunCheat(playerid, weaponid); } else { Weapon[playerid][wSlot12] = ammo; }
			}
		}
	}
	else { GunCheckTime[playerid] --; }
}

stock ServerResetPlayerWeapons(playerid)
{
	GunCheckTime[playerid] = 5;
	ResetPlayerWeapons(playerid);
	Weapon[playerid][wSlot0] = 0;
	Weapon[playerid][wSlot1] = 0;
	Weapon[playerid][wSlot2] = 0;
	Weapon[playerid][wSlot3] = 0;
	Weapon[playerid][wSlot4] = 0;
	Weapon[playerid][wSlot5] = 0;
	Weapon[playerid][wSlot6] = 0;
	Weapon[playerid][wSlot7] = 0;
	Weapon[playerid][wSlot8] = 0;
	Weapon[playerid][wSlot9] = 0;
	Weapon[playerid][wSlot10] = 0;
	Weapon[playerid][wSlot11] = 0;
	Weapon[playerid][wSlot12] = 0;
}

stock AntiCheat(playerid)
{
	if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid) && PlayerInfo[playerid][pAdmin] < 5 && PlayerInfo[playerid][pLogged] == true)
	{
		CheckWeapon(playerid);
		CheckMoney(playerid);
		CheckHealth(playerid);
		CheckArmour(playerid);
		//CheckVeh(playerid);
		//CheckFly(playerid);
		SHCheck(playerid);
		if(GetPlayerState(playerid) == 2) { if(incar[playerid] == false) RemovePlayerFromVehicle(playerid); }
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
		{
			new string[128];
			format(string,sizeof(string),"{F31212}[MAC]{FFFFFF}: %s[%d] ���(�) ������(�) � ������� �� ����-���",PlayerInfo[playerid][pName],playerid);
			SendAdminMessage(-1,string,1);
	   		ALKick(playerid);
    	}
		new weapons[13][2];
		for (new i = 0; i < 13; i++)
		{
			GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
			if(weapons[i][1] >= 9900)
			{
				new string[128];
				format(string,sizeof(string),"{F31212}[AAC]{FFFFFF}: %s[%d] ���(�) ������(�) � ������� �� ����.�������",PlayerInfo[playerid][pName],playerid);
				SendAdminMessage(-1,string,1);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���� ������� �� ����.�������");
				ALKick(playerid);
			}
		}
		if(!IsPlayerConnected(playerid) || GetPlayerState(playerid) != PLAYER_STATE_ONFOOT || GetPVarInt(playerid,"CheckSpawn") == 0 ) return true;
		else {
			new Float:Coordse[3];
			GetPlayerCameraFrontVector(playerid, Coordse[0], Coordse[1], Coordse[2]);
			new stringer[20], stringer2[20], stringer3[20];
			format(stringer,sizeof(stringer),"%f",Coordse[0]);
			format(stringer2,sizeof(stringer2),"%f",Coordse[1]);
			format(stringer3,sizeof(stringer3),"%f",Coordse[2]);
			for(new i = 0; i < 7; i++)
			{
				if((floatabs(Coordse[0]) > 1000.0 && floatabs(Coordse[1]) > 100.0 && floatabs(Coordse[2]) > 1000.0) || strfind(stringer, Symbols[i], true) != -1 || strfind(stringer2, Symbols[i], true) != -1 || strfind(stringer3, Symbols[i], true) != -1)
				{
					new string[128];
					format(string, sizeof(string), "{F31212}[AAC]{FFFFFF}: %s[%d] ���(�) ������(�) �� ������������� OnFootCrasher", PlayerInfo[playerid][pName], playerid);
					SendAdminMessage(-1, string, 1);
					Kick(playerid);
					return true;
				}
			}
		}
	}
	return true;
}
stock ShowKpk(playerid)
{
	new title[128];
	format(title, sizeof(title), ""PURP"%s"WHT" | LvL: "PURP"%i", PlayerInfo[playerid][pName], PlayerInfo[playerid][pLevel]);
	SPD(playerid, DIALOG_KPK, DIALOG_STYLE_LIST, title, "{3CBBF7}[1]{ffffff}\t�������\n{3CBBF7}[2]{ffffff}\tGPS ���������\n{3CBBF7}[3]{ffffff}\t������ ������ (������, �������������� � �.�.)\n{3CBBF7}[4]{ffffff}\t�������� �� ����������\n{3CBBF7}[5]{ffffff}\t������ �� �������", "�������", "������");
	return true;
}
stock ShowStats(playerid,forplayerid)
{
	switch(PlayerInfo[playerid][pGunSkill])
	{
		case 0..100:   { skillgun[playerid] = 1; dosled[playerid] = 100; }
		case 101..200: { skillgun[playerid] = 2; dosled[playerid] = 200; }
		case 201..300: { skillgun[playerid] = 3; dosled[playerid] = 300; }
		case 301..400: { skillgun[playerid] = 4; dosled[playerid] = 400; }
		case 401..500: { skillgun[playerid] = 5; dosled[playerid] = 500; }
	}
	switch(PlayerInfo[playerid][pDrugSkill])
	{
		case 0..100:   { skilldrug[playerid] = 1; dosled1[playerid] = 100; }
		case 101..200: { skilldrug[playerid] = 2; dosled1[playerid] = 200; }
		case 201..300: { skilldrug[playerid] = 3; dosled1[playerid] = 300; }
		case 301..400: { skilldrug[playerid] = 4; dosled1[playerid] = 400; }
		case 401..500: { skilldrug[playerid] = 5; dosled1[playerid] = 500; }
	}
	new stats[270],stata[1500],rank[60],dom[60],gas[60],car[60],zavod[60],voz[60],fly[60],boat[60],gun[60],ammo[60],fstyle[60],magazin[80],club[60],job1[60],fraction[60];
	new fam = GetPlayerMember(playerid);
	if(PlayerInfo[playerid][pJob] > 0) strmid(job1, Job[PlayerInfo[playerid][pJob]][jName], 0, strlen(Job[PlayerInfo[playerid][pJob]][jName]), 255);
	else job1 = "���";
	if(fam > 0) strmid(fraction, Fraction[fam][fName], 0, strlen(Fraction[fam][fName]), 255);
	else fraction = "���";
	switch(PlayerInfo[playerid][pFstyle])
	{
		case 0: fstyle = "���";
		case 4: { fstyle = "�������"; }
		case 5: { fstyle = "Boxing"; }
		case 6: { fstyle = "Kung-Fu"; }
		case 7: { fstyle = "Kneehead"; }
		case 15: { fstyle = "Grabkick"; }
	}
	switch(PlayerInfo[playerid][pRank])
	{
		case 0: rank = "���";
		case 1:	strmid(rank, Fraction[fam][fRank1], 0, strlen(Fraction[fam][fRank1]), 255);
		case 2: strmid(rank, Fraction[fam][fRank2], 0, strlen(Fraction[fam][fRank2]), 255);
		case 3: strmid(rank, Fraction[fam][fRank3], 0, strlen(Fraction[fam][fRank3]), 255);
		case 4: strmid(rank, Fraction[fam][fRank4], 0, strlen(Fraction[fam][fRank4]), 255);
		case 5: strmid(rank, Fraction[fam][fRank5], 0, strlen(Fraction[fam][fRank5]), 255);
		case 6: strmid(rank, Fraction[fam][fRank6], 0, strlen(Fraction[fam][fRank6]), 255);
	}
	if(PlayerInfo[playerid][pHouse] == 0) { dom = "{D70808}���{FFFFFF}"; }
	else format(dom,sizeof(dom),"%d",PlayerInfo[playerid][pHouse]);
	if(PlayerInfo[playerid][pFuel] == 0) { gas = "{D70808}���{FFFFFF}"; }
	else format(gas,sizeof(gas),"%d",PlayerInfo[playerid][pFuel]);
	if(PlayerInfo[playerid][pCar] == 0) { car = "{D70808}���{FFFFFF}"; }
	else format(car,sizeof(car),"%s",VehicleNames[PlayerInfo[playerid][pCarM]-400]);
	if(PlayerInfo[playerid][pZavod] == 0) { zavod = "{D70808}���{FFFFFF}"; }
	else format(zavod,sizeof(zavod),"%d",PlayerInfo[playerid][pZavod]);
	if(PlayerInfo[playerid][pLic][1] == false) { voz = "{D70808}���{FFFFFF}"; }
	else { voz = "{177D15}����{FFFFFF}"; }
	if(PlayerInfo[playerid][pLic][2] == false) { boat = "{D70808}���{FFFFFF}"; }
	else { boat = "{177D15}����{FFFFFF}"; }
	if(PlayerInfo[playerid][pLic][3] == false) { fly = "{D70808}���{FFFFFF}"; }
	else { fly = "{177D15}����{FFFFFF}"; }
	if(PlayerInfo[playerid][pLic][4] == false) { gun = "{D70808}���{FFFFFF}"; }
	else { gun = "{177D15}����{FFFFFF}"; }
	if(PlayerInfo[playerid][pAmmo] == 0) { ammo = "{D70808}���{FFFFFF}"; }
	else format(ammo,sizeof(ammo),"%d",PlayerInfo[playerid][pAmmo]);
	if(PlayerInfo[playerid][pMagazin] == 0) { magazin = "{D70808}���{FFFFFF}"; }
	else format(magazin,sizeof(magazin),"%d",PlayerInfo[playerid][pMagazin]);
	if(PlayerInfo[playerid][pClub] == 0) { club = "{D70808}���{FFFFFF}"; }
	else format(club,sizeof(club),"%d",PlayerInfo[playerid][pClub]);
	format(stats,sizeof(stats),"{D37018}�������:{FFFFFF}\t\t%s \n",PlayerInfo[playerid][pName]);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}�������:{FFFFFF}\t\t%d \n",PlayerInfo[playerid][pLevel]);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}����� �����:{FFFFFF}\t\t%d \n",PlayerInfo[playerid][pExp]);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}����� �� �����:{FFFFFF} \t%d \n",PlayerInfo[playerid][pMoney]);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}����� � �����:{FFFFFF}\t\t%s \n",ConvertCash(PlayerInfo[playerid][pBank]));
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}���������������:{FFFFFF}\t%d/3 \n",PlayerInfo[playerid][pWarn]);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}������:{FFFFFF} \t\t%s \n",job1);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}�������:{FFFFFF} \t\t%s \n",fraction);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}����:{FFFFFF}\t\t\t%s \n",rank);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}��������:{FFFFFF}\t\t%d/3 \n",PlayerInfo[playerid][pFW]);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}���������:{FFFFFF}\t\t%s \n",ConvertCash(PlayerInfo[playerid][pMats]));
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}���������:{FFFFFF}\t\t%s \n",ConvertCash(PlayerInfo[playerid][pDrugs]));
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}������� �������:{FFFFFF}\t%d \n",GetPlayerWantedLevel(playerid));
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}����� ���:{FFFFFF}\t\t%s \n",fstyle);
	strcat(stata,stats);
	format(stats,sizeof(stats),"\t{FFFFFF}__________C�����__________ \n");
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}�������� ������:{FFFFFF}\t%d (%d/%d) \n",skillgun,PlayerInfo[playerid][pGunSkill],dosled[playerid]);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}�������� ����������:{FFFFFF}\t%d (%d/%d) \n",skilldrug[playerid],PlayerInfo[playerid][pDrugSkill],dosled1[playerid]);
	strcat(stata,stats);
	format(stats,sizeof(stats),"\t{FFFFFF}__________���������:__________ \n");
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}���:{FFFFFF}\t\t\t%s \n",dom);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}��������:{FFFFFF}\t\t%s \n",gas);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}������:{FFFFFF}\t\t%s \n",car);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}�����:{FFFFFF}\t\t\t%s \n",zavod);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}���������:{FFFFFF}\t\t%s \n",ammo);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}�������:{FFFFFF}\t\t%s \n",magazin);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}���������:{FFFFFF}\t\t%s \n",club);
	strcat(stata,stats);
	format(stats,sizeof(stats),"\t{FFFFFF}__________��������:__________ \n");
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}�� ����������:{FFFFFF}\t\t%s \n",voz);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}�� ������ ���������:{FFFFFF}\t\t%s \n",boat);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}�� ������ ���������:{FFFFFF}\t\t%s \n",fly);
	strcat(stata,stats);
	format(stats,sizeof(stats),"{D37018}�� ������:{FFFFFF}\t\t\t%s \n",gun);
	strcat(stata,stats);
	SPD(forplayerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, ""PREFIX" ��� | ����������", stata, "OK", "");
	return true;
}
stock ShowKpkOnline(playerid) return 	SPD(playerid, DIALOG_KPK_ONLINE, DIALOG_STYLE_LIST, ""PREFIX" ��� | ������", "{3CBBF7}[1]{ffffff}\t������\n{3CBBF7}[2]{ffffff}\t��������������\n{3CBBF7}[3]{ffffff}\t����� ����� �������\n{3CBBF7}[4]{ffffff}\t������� ������", "�������", "�����");
stock ShowKpkControl(playerid) return SPD(playerid, DIALOG_KPK_CONTROL, DIALOG_STYLE_LIST, ""PREFIX" ��� | ��������", "{3CBBF7}[1]{ffffff}\t���\n{3CBBF7}[2]{ffffff}\t������\n{3CBBF7}[3]{ffffff}\t������\n{3CBBF7}[4]{ffffff}\t��������\n{3CBBF7}[5]{ffffff}\t���������\n{3CBBF7}[6]{ffffff}\t�������\n{3CBBF7}[8]{ffffff}\t���������", "�������", "�����");
stock ShowChangePass(playerid) return SPD(playerid, DIALOG_KPK_PASS, DIALOG_STYLE_INPUT, ""PREFIX" ��� | ����� ������", "{FFFFFF}������� � ������ ����� ������", "�������", "�����");
stock ShowKpkGps(playerid) return SPD(playerid, DIALOG_KPK_GPS, DIALOG_STYLE_LIST, ""PREFIX" ��� | GPS", "{3CBBF7}[1]{ffffff}\t�������� �������\n{3CBBF7}[2]{ffffff}\t������\n{3CBBF7}[3]{ffffff}\t�������\n{3CBBF7}[4]{ffffff}\t��������� ������", "�������", "�����");
forward Fuel();
public Fuel()
{
	for(new i = 1; i < MAX_VEHICLES; i++)
	{
		new engine, lights, alarm, doors, bonnet, boot, objective, str1[64];
		GetVehicleParamsEx(i, engine, lights, alarm, doors, bonnet, boot, objective);
		if(!IsFly(i) && !IsBicycle(i) && !IsBoat(i) && engine == 1)
		{
			foreach(Player,playerid)
			{
				if(GetPlayerVehicleID(playerid) == i)
				{
					fuel[i] --;
					if(fuel[i] <= 45) format(str1, sizeof(str1), "(~r~%d L~w~)", fuel[i]);
					else if(fuel[i] <= 100) format(str1, sizeof(str1), "(~y~%d L~w~)", fuel[i]);
					else if(fuel[i] <= 1000) format(str1, sizeof(str1), "(~g~%%d L~w~)", fuel[i]);
					PlayerTextDrawSetString(playerid, Textdraw[8][playerid], str1);
					switch(fuel[i])
					{
						case 0..1: PlayerTextDrawSetString(playerid, Textdraw[6][playerid], "~w~~h~I");
						case 2..10: PlayerTextDrawSetString(playerid, Textdraw[6][playerid], "~w~~h~I");
						case 11..30: PlayerTextDrawSetString(playerid, Textdraw[6][playerid], "~w~~h~II");
						case 31..50: PlayerTextDrawSetString(playerid, Textdraw[6][playerid], "~g~IIII");
						case 51..70: PlayerTextDrawSetString(playerid, Textdraw[6][playerid], "~g~IIIIII");
						case 71..90: PlayerTextDrawSetString(playerid, Textdraw[6][playerid], "~g~~h~IIIIIIII");
						case 91..110: PlayerTextDrawSetString(playerid, Textdraw[6][playerid], "~y~~h~IIIIIIIIII");
						case 111..130: PlayerTextDrawSetString(playerid, Textdraw[6][playerid], "~y~~h~IIIIIIIIIIII");
						case 131..150: PlayerTextDrawSetString(playerid, Textdraw[6][playerid], "~y~~h~IIIIIIIIIIIII");
						case 151..170: PlayerTextDrawSetString(playerid, Textdraw[6][playerid], "~r~~h~~h~IIIIIIIIIIIIII");
						case 171..300: PlayerTextDrawSetString(playerid, Textdraw[6][playerid], "~r~~h~~h~IIIIIIIIIIIIIII");
						default: PlayerTextDrawSetString(playerid, Textdraw[6][playerid], "~r~~h~~h~IIIIIIIIIIIIIII");
					}
				}
			}
		}
		if(fuel[i] <= 0) ToggleEngine(i, VEHICLE_PARAMS_OFF);
	}
	return true;
}
forward Zavodka(playerid);
public Zavodka(playerid)
{
	new vehicle = GetPlayerVehicleID(playerid);
	new engine, lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, boot, objective);
	if(engine == 0)
	{
		switch(random(6))
		{
			case 0..4: { SendClientMessage(playerid,-1,"{FFFFFF}��������� "GRN"�������"WHT" ������!"); ToggleEngine(vehicle, VEHICLE_PARAMS_ON); }
			default:{ SendClientMessage(playerid,-1,"{FFFFFF}��������� ������� {F31212}�� �������!{FFFFFF}"); }
		}
		zavodit[playerid] = false;
	}
}
stock IsACop(playerid)
{
	new fam = GetPlayerMember(playerid);
	if(fam == 1 || fam == 2 || fam == 3) return true;
	return false;
}
stock IsAGang(playerid)
{
	new fam = GetPlayerMember(playerid);
	if(fam == 6 || fam == 7 || fam == 8 || fam == 10) return true;
	return false;
}
stock IsAMafia(playerid)
{
	new fam = GetPlayerMember(playerid);
	if(fam == 9 || fam == 11 || fam == 13 || fam == 16) return true;
	return false;
}
stock CountFraction(fracid)
{
	new count;
	foreach(Player,playerid)
	{
		if(GetPlayerMember(playerid) == fracid) count++;
	}
	return count;
}
stock AFKCheck(playerid)
{
    new Float:AFKCoords[3];
    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
		GetPlayerPos(playerid,AFKCoords[0],AFKCoords[1],AFKCoords[2]);
		if(AFKCoords[0] == PlayerAFK[playerid][AFK_Coord]) PlayerAFK[playerid][AFK_Time]++;
		else
		{
			PlayerAFK[playerid][AFK_Time] = 0;
			if(PlayerAFK[playerid][AFK_Stat] != 0) { Delete3DTextLabel(AFK_3DT[playerid]); PlayerAFK[playerid][AFK_Stat] = 0; }
		}
		PlayerAFK[playerid][AFK_Coord] = AFKCoords[0];
		if(PlayerAFK[playerid][AFK_Time] == 10 && PlayerAFK[playerid][AFK_Stat] == 0)
		{
			AFK_3DT[playerid] = Create3DTextLabel("AFK", -1, 0.00, 0.00, 10000.0, 10.0, 0);
			Attach3DTextLabelToPlayer(AFK_3DT[playerid], playerid, 0.0, 0.0, 0.5);
			PlayerAFK[playerid][AFK_Stat] = 1;
		}
		if(PlayerAFK[playerid][AFK_Stat] == 1)
		{
			new str[16]; format(str,16,"AFK %s",ConvertSeconds(PlayerAFK[playerid][AFK_Time]));
			Update3DTextLabelText(AFK_3DT[playerid], -1, str);
		}
		if(PlayerInfo[playerid][pAdmin] == 0)
		{
			//if(PlayerAFK[playerid][AFK_Time] > 600) { SendClientMessage(playerid, -1," {F31212}[AAS]{FFFFFF}: �� ���� ������� �� ��,��� ���� � AFK ����� 10 �����"); ALKick(playerid); }
			//if(PlayerAFK[playerid][AFK_Time] == 480) SendClientMessage(playerid, -1,"{F31212}[AAS]{FFFFFF}: �� ������ ������� ����� 2 ������ ���� �� ������� ���������!");
			//if(PlayerAFK[playerid][AFK_Time] == 540) SendClientMessage(playerid, -1,"{F31212}[AAS]{FFFFFF}: �� ������ ������� ����� 1 ������ ���� �� ������� ���������!");
		}
	}
    return true;
}
stock OpenZone(gun,maxplayers) {  ZoneInfo[zOpen] = true; ZoneInfo[zGun] = gun; ZoneInfo[zMax] = maxplayers; }
stock StartZone()
{
	foreach(Player,i)
	{
		if(nadm[i] == true) {  UnFreeze(i); ServerGivePlayerWeapon(i,ZoneInfo[zGun],999); }
	}
	ZoneInfo[zOpen] = false;
}
forward TimerGiveMiner(playerid);
public TimerGiveMiner(playerid)
{
	RemovePlayerAttachedObject(playerid, 6);
	SendClientMessage(playerid, -1, "�� ������ ������. ������ �������� ��� �� �����.");
	ApplyAnimationEx(playerid, "CARRY", "crry_prtial",4.1, 0, 0, 0, 1, 1);
	SetPlayerAttachedObject(playerid, 6, 2936, 1, 0.184699, 0.426247, 0.000000, 259.531341, 80.949592, 0.000000, 0.476124, 0.468181, 0.470769);
	SetPlayerCheckpoint(playerid, -1865.7438, -1622.5901, 21.9036, 3.0);
	ExtraMetall[playerid] = 0;
	return true;
}
forward UnDrink(playerid);
public UnDrink(playerid){
if(GetPVarInt(playerid,"Usedrugs") == 1){ SetPlayerWeather(playerid,10), SetPVarInt(playerid,"Usedrugs",0); SetPlayerDrunkLevel(playerid,0);} else{
SetPlayerDrunkLevel(playerid,0);}}
stock IsPlayerName(playerid,name[]) return !strcmp(name, PlayerInfo[playerid][pName], true)?true:false;
stock TuneCar(playerid)
{
	new carid = PlayerInfo[playerid][pCar];
	if(PlayerInfo[playerid][pSpoiler] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pSpoiler]);
	if(PlayerInfo[playerid][pHood] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pHood]);
	if(PlayerInfo[playerid][pSideskirt] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pSideskirt]);
	if(PlayerInfo[playerid][pNitro] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pNitro]);
	if(PlayerInfo[playerid][pLamps] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pLamps]);
	if(PlayerInfo[playerid][pExhaust] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pExhaust]);
	if(PlayerInfo[playerid][pWheels] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pWheels]);
	if(PlayerInfo[playerid][pRoof] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pRoof]);
	if(PlayerInfo[playerid][pStereo] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pStereo]);
	if(PlayerInfo[playerid][pHydraulics] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pHydraulics]);
	if(PlayerInfo[playerid][pBullbar] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pBullbar]);
	if(PlayerInfo[playerid][pRearBullbars] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pRearBullbars]);
	if(PlayerInfo[playerid][pFrontSign] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pFrontSign]);
	if(PlayerInfo[playerid][pFrontBullbars] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pFrontBullbars]);
	if(PlayerInfo[playerid][pFrontBumper] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pFrontBumper]);
	if(PlayerInfo[playerid][pRearBumper] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pRearBumper]);
	if(PlayerInfo[playerid][pVents] != 0) AddVehicleComponent(carid,PlayerInfo[playerid][pVents]);
	if(PlayerInfo[playerid][pPaintJob] != -1) ChangeVehiclePaintjob(carid,PlayerInfo[playerid][pPaintJob]);
}
stock RemoveTune(playerid)
{
	PlayerInfo[playerid][pSpoiler] = 0;
	PlayerInfo[playerid][pHood] = 0;
	PlayerInfo[playerid][pSideskirt] = 0;
	PlayerInfo[playerid][pNitro] = 0;
	PlayerInfo[playerid][pLamps] = 0;
	PlayerInfo[playerid][pExhaust] = 0;
	PlayerInfo[playerid][pWheels] = 0;
	PlayerInfo[playerid][pRoof] = 0;
	PlayerInfo[playerid][pStereo] = 0;
	PlayerInfo[playerid][pHydraulics] = 0;
	PlayerInfo[playerid][pBullbar] = 0;
	PlayerInfo[playerid][pRearBullbars] = 0;
	PlayerInfo[playerid][pFrontSign] = 0;
	PlayerInfo[playerid][pFrontBullbars] = 0;
	PlayerInfo[playerid][pFrontBumper] = 0;
	PlayerInfo[playerid][pRearBumper] = 0;
	PlayerInfo[playerid][pVents] = 0;
	PlayerInfo[playerid][pPaintJob] = 0;
}
stock GetPlayerWeaponsInfo(playerid)
{
    new string[100];
    for(new i = 0; i < 13; i++)
    {
		GetPlayerWeaponData(playerid,i,SpecGuns[playerid][i][0],SpecGuns[playerid][i][1]);
		if(SpecGuns[playerid][i][0] > 0 && SpecGuns[playerid][i][1] > 0) format(string,sizeof(string),"%s~n~%s (%d)",string,GetWeaponNameEx(SpecGuns[playerid][i][0]),SpecGuns[playerid][i][1]);
    }
    return string;
}
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    if(PlayerInfo[playerid][pAdmin] == 0) return true;
    ServerSetPlayerPos(playerid,fX,fY,fZ);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0) ;
    return true;
}
stock GetGangZoneColor(i)
{
	new color;
	switch(GangZone[i][gzFraction])
	{
		case 6: color = 0x4DB81890;
		case 7: color = 0xB318B890;
		case 8: color = 0xE6CD1290;
		case 10: color = 0x12C3E690;
	}
    return color;
}
stock StartCapture(fam,warfam,gzid)
{
	GangZone[gzid][gWar1] = fam;
	GangZone[gzid][gWar2] = warfam;
	War[wrFrac] = fam;
	War[wrWarFrac] = warfam;
	Fraction[fam][fZaxvat] = gzid;
	Fraction[warfam][fZaxvat] = gzid;
	Fraction[fam][fWar] = warfam;
	Fraction[warfam][fWar] = fam;
	new string[128];
	format(string,sizeof(string),"��������! ����� %s ������ ����� � ����� ������ �� ������ ����!",Fraction[fam][fName]);
	SendFractionMessage(COLOR_BLUE,string,warfam);
	format(string,sizeof(string),"��������! ���� ����� ������ ����� � %s �� ������ ����!",Fraction[warfam][fName]);
	SendFractionMessage(COLOR_BLUE,string,fam);
	GangZoneFlashForAll(gzid,0xFFFFFF90);
	new name[100];
	format(name,sizeof(name),"~g~%s~w~: %d~n~~r~%s~w~: %d~n~%s",Fraction[fam][fName],Fraction[fam][fKills],Fraction[warfam][fName],Fraction[warfam][fKills],ConvertSeconds(GangZone[gzid][gzTimer]));
	GangZone[gzid][gzTextDraw] = TextDrawCreate(258.000000, 365.000000, name);
	SetTimerEx("UpdateTimer",1000,true,"iii",fam,warfam,gzid);
	TextDrawBackgroundColor(GangZone[gzid][gzTextDraw], 255);
	TextDrawFont(GangZone[gzid][gzTextDraw], 2);
	TextDrawLetterSize(GangZone[gzid][gzTextDraw], 0.390000, 1.600000);
	TextDrawColor(GangZone[gzid][gzTextDraw], 16711935);
	TextDrawSetOutline(GangZone[gzid][gzTextDraw], 0);
	TextDrawSetProportional(GangZone[gzid][gzTextDraw], 1);
	TextDrawSetShadow(GangZone[gzid][gzTextDraw], 1);
	foreach(Player,i)
	{
		new famm;
		if(PlayerInfo[i][pLeader] > 0) famm = PlayerInfo[i][pLeader];
		else famm = PlayerInfo[i][pMember];
		if(famm == fam || famm == warfam) TextDrawShowForPlayer(i, GangZone[gzid][gzTextDraw]);
	}
	SetTimerEx("Capture",600000,false,"iii",fam,warfam,gzid);
	GangZone[gzid][gzTimer] = 600;
	gztimer = SetTimerEx("TimerGZ",1000,true,"i",gzid);
	return true;
}
forward Capture(fam,warfam,gzid);
public Capture(fam,warfam,gzid)
{
	if(Fraction[fam][fKills] > Fraction[warfam][fKills])
	{
		SendFractionMessage(COLOR_BLUE,"�� �������� ����� �� ����!",fam);
		SendFractionMessage(COLOR_BLUE,"�� ��������� ����!",warfam);
		GangZone[gzid][gzFraction] = fam;
		GangZoneStopFlashForAll(gzid);
		GangZoneHideForAll(gzid);
		GangZoneShowForAll(gzid, GetGangZoneColor(gzid));
		TextDrawHideForAll(GangZone[gzid][gzTextDraw]);
		Fraction[fam][fMoney] += 25000;
	}
	if(Fraction[fam][fKills] < Fraction[warfam][fKills]) { SendFractionMessage(COLOR_BLUE,"�� ��������� ����!",fam); SendFractionMessage(COLOR_BLUE,"�� �������� ����� �� ����!",warfam); }
	if(Fraction[fam][fKills] == Fraction[warfam][fKills]) { SendFractionMessage(COLOR_BLUE,"�����!",fam); SendFractionMessage(COLOR_BLUE,"�����!",warfam); }
	GangZoneStopFlashForAll(gzid);
	TextDrawHideForAll(GangZone[gzid][gzTextDraw]);
	Fraction[fam][fKills] = 0;
	Fraction[warfam][fKills] = 0;
	TextDrawDestroy(GangZone[gzid][gzTextDraw]);
	GangZone[gzid][gzTimer] = 0;
	foreach(Player,i) if(NaZaxvate[i] > 0) { NaZaxvate[i] = 0; Zona[i] = 0; }
	Fraction[fam][fZaxvat] = 0;
	Fraction[warfam][fZaxvat] = 0;
	Fraction[fam][fOtkat] = 600;
	Fraction[warfam][fOtkat] = 600;
	Fraction[fam][fWar] = 0;
	Fraction[warfam][fWar] = 0;
	SaveGangZone(gzid);
	SetTimerEx("Otkat",1000,true,"ii",fam,warfam);
	KillTimer(gztimer);
}
stock SetZam(playerid)
{
	new fam = PlayerInfo[playerid][pLeader];
	new zamrank[30],zamkick[30],zaminvite[30],zammute[30],zamunmute[30],zamvyg[30],zamunvyg[30];
	if(Fraction[fam][fZamRank] == true) { zamrank = "{177D15}���������{FFFFFF}"; }
	else { zamrank = "{D70808}���������{FFFFFF}"; }
	if(Fraction[fam][fZamKick] == true) { zamkick = "{177D15}���������{FFFFFF}"; }
	else { zamkick = "{D70808}���������{FFFFFF}"; }
	if(Fraction[fam][fZamInvite] == true) { zaminvite = "{177D15}���������{FFFFFF}"; }
	else { zaminvite = "{D70808}���������{FFFFFF}"; }
	if(Fraction[fam][fZamMute] == true) { zammute = "{177D15}���������{FFFFFF}"; }
	else { zammute = "{D70808}���������{FFFFFF}"; }
	if(Fraction[fam][fZamUnMute] == true) { zamunmute = "{177D15}���������{FFFFFF}"; }
	else { zamunmute = "{D70808}���������{FFFFFF}"; }
	if(Fraction[fam][fZamVyg] == true) { zamvyg = "{177D15}���������{FFFFFF}"; }
	else { zamvyg = "{D70808}���������{FFFFFF}"; }
	if(Fraction[fam][fZamUnVyg] == true) { zamunvyg = "{177D15}���������{FFFFFF}"; }
	else { zamunvyg = "{D70808}���������{FFFFFF}"; }
	new string[512];
	format(string,sizeof(string),"�������� ����:\t%s\n���������:\t\t%s\n������:\t\t\t%s\n������ ��� ����:\t%s\n������� ��� ����:\t%s\n������ �������:\t%s\n������� �������:\t%s",zamrank,zaminvite,zamkick,zammute,zamunmute,zamvyg,zamunvyg);
	SPD(playerid,DIALOG_SETTING_ZAM,DIALOG_STYLE_LIST,""PREFIX" ��������� ���� �����������",string,"�������","������");
}
stock Dipl(playerid)
{
	if(!IsAGang(playerid)) return SendClientMessage(playerid,-1,"{F31212}[������]{FFFFFF} ��� ������� �������� ������ ������!");
	new fam;
	if(PlayerInfo[playerid][pLeader] > 0) fam = PlayerInfo[playerid][pLeader];
	else fam = PlayerInfo[playerid][pZam];
	if(fam == 6)
	{
		new dipl1[30],dipl2[30],dipl3[30];
		if(Fraction[fam][fBallas] == true) { dipl1 = "{177D15}���{FFFFFF}"; }
		else { dipl1 = "{D70808}�����{FFFFFF}"; }
		if(Fraction[fam][fCoronos] == true) { dipl2 = "{177D15}���{FFFFFF}"; }
		else { dipl2 = "{D70808}�����{FFFFFF}"; }
		if(Fraction[fam][fVagos] == true) { dipl3 = "{177D15}���{FFFFFF}"; }
		else { dipl3 = "{D70808}�����{FFFFFF}"; }
		new string[512];
		format(string,sizeof(string),"{3CBBF7}[1]{ffffff} The Ballas Gang:\t%s\n{3CBBF7}[2]{ffffff} Los Santos Vagos:\t%s\n{3CBBF7}[3]{ffffff} El Coronos:\t\t%s",dipl1,dipl3,dipl2);
		SPD(playerid,DIALOG_DIPL,DIALOG_STYLE_LIST,""PREFIX" ����������",string,"�������","������");
	}
	else if(fam == 7)
	{
		new dipl1[30],dipl2[30],dipl3[30];
		if(Fraction[fam][fGroove] == true) { dipl1 = "{177D15}���{FFFFFF}"; }
		else { dipl1 = "{D70808}�����{FFFFFF}"; }
		if(Fraction[fam][fCoronos] == true) { dipl2 = "{177D15}���{FFFFFF}"; }
		else { dipl2 = "{D70808}�����{FFFFFF}"; }
		if(Fraction[fam][fVagos] == true) { dipl3 = "{177D15}���{FFFFFF}"; }
		else { dipl3 = "{D70808}�����{FFFFFF}"; }
		new string[512];
		format(string,sizeof(string),"{3CBBF7}[1]{ffffff} The Groove Street:\t%s\n{3CBBF7}[2]{ffffff} Los Santos Vagos:\t%s\n{3CBBF7}[3]{ffffff} El Coronos:\t\t%s",dipl1,dipl3,dipl2);
		SPD(playerid,DIALOG_DIPL,DIALOG_STYLE_LIST,""PREFIX" ����������",string,"�������","������");
	}
	else if(fam == 8)
	{
		new dipl1[30],dipl2[30],dipl3[30];
		if(Fraction[fam][fGroove] == true) { dipl1 = "{177D15}���{FFFFFF}"; }
		else { dipl1 = "{D70808}�����{FFFFFF}"; }
		if(Fraction[fam][fBallas] == true) { dipl2 = "{177D15}���{FFFFFF}"; }
		else { dipl2 = "{D70808}�����{FFFFFF}"; }
		if(Fraction[fam][fCoronos] == true) { dipl3 = "{177D15}���{FFFFFF}"; }
		else { dipl3 = "{D70808}�����{FFFFFF}"; }
		new string[512];
		format(string,sizeof(string),"{3CBBF7}[1]{ffffff} The Groove Street:\t%s\n{3CBBF7}[2]{ffffff} The Ballas Gang:\t%s\n{3CBBF7}[3]{ffffff} El Coronos:\t\t%s",dipl1,dipl2,dipl3);
		SPD(playerid,DIALOG_DIPL,DIALOG_STYLE_LIST,""PREFIX" ����������",string,"�������","������");
	}
	else if(fam == 10)
	{
		new dipl1[30],dipl2[30],dipl3[30];
		if(Fraction[fam][fGroove] == true) { dipl1 = "{177D15}���{FFFFFF}"; }
		else { dipl1 = "{D70808}�����{FFFFFF}"; }
		if(Fraction[fam][fBallas] == true) { dipl2 = "{177D15}���{FFFFFF}"; }
		else { dipl2 = "{D70808}�����{FFFFFF}"; }
		if(Fraction[fam][fVagos] == true) { dipl3 = "{177D15}���{FFFFFF}"; }
		else { dipl3 = "{D70808}�����{FFFFFF}"; }
		new string[512];
		format(string,sizeof(string),"{3CBBF7}[1]{ffffff} The Groove Street:\t%s\n{3CBBF7}[2]{ffffff} The Ballas Gang:\t%s\n{3CBBF7}[3]{ffffff} Los Santos Vagos:\t\t%s",dipl1,dipl2,dipl3);
		SPD(playerid,DIALOG_DIPL,DIALOG_STYLE_LIST,""PREFIX" ����������",string,"�������","������");
	}
	return true;
}
stock SaveDipl(id)
{
	new query[512];
	format(query,sizeof(query),"UPDATE `Fractions` SET Ballas=%d,Grove=%d,Coronos=%d,Vagos=%d WHERE id='%i'",Fraction[id][fBallas],Fraction[id][fGroove],Fraction[id][fCoronos],Fraction[id][fVagos],id);
	mysql_query(query);
}
Showlmenu(playerid) return SPD(playerid,DIALOG_LMENU,DIALOG_STYLE_LIST,""PREFIX" ���� ������","{3CBBF7}[1]{ffffff}\t��������� ����� �����������\n{3CBBF7}[2]{ffffff}\t��������� ����������\n{3CBBF7}[3]{ffffff}\t��������� ���� �������\n{3CBBF7}[4]{ffffff}\t������������ ���� ��������\n{3CBBF7}[5]{ffffff}\t��������� ���� ��������\n{3CBBF7}[6]{ffffff}\t�������� �������","�������","������");
forward TimerGZ(gzid);
public TimerGZ(gzid)
{
	if(GangZone[gzid][gzTimer] > 0) GangZone[gzid][gzTimer] --;
	return true;
}
forward Otkat(fam,warfam);
public Otkat(fam,warfam)
{
	if(Fraction[fam][fOtkat] > 0) Fraction[fam][fOtkat] --;
	if(Fraction[warfam][fOtkat] > 0) Fraction[warfam][fOtkat] --;
	return true;
}
forward UpdateTimer(fam,warfam,gzid);
public UpdateTimer(fam,warfam,gzid)
{
	if(Fraction[fam][fZaxvat] > 0 && Fraction[warfam][fZaxvat] > 0)
	{
		new name[100];
		format(name,sizeof(name),"~g~%s~w~: %d~n~~r~%s~w~: %d~n~%s",Fraction[fam][fName],Fraction[fam][fKills],Fraction[warfam][fName],Fraction[warfam][fKills],ConvertSeconds(GangZone[gzid][gzTimer]));
		TextDrawSetString(GangZone[gzid][gzTextDraw],name);
	}
	return true;
}
forward CloseBank();
public CloseBank() {
	MoveDynamicObject(vaultdoor,2144.1999500,1626.9997600,994.2500000,0.0000000,0.0000000,182.0000000);
	return true;
}	
forward Vzlom(playerid);
public Vzlom(playerid)
{
    new string[128];
	switch(random(5))
	{
		case 0..2:
		{
			format(string,sizeof(string),"%s ������� ����� � ���������",PlayerInfo[playerid][pName]);
			SendRadiusMessage(10.0, playerid, string,COLOR_PURPLE);
			MoveDynamicObject(vaultdoor,2144.1999500,1626.9997600,994.2500000-10, 3.0, 0.0000000,0.0000000,182.0000000);
			SendRadiusMessage(20.0, playerid, "����� � ��������� ��������� ����� 3 ������", COLOR_LIGHTBLUE);
			SetTimer("CloseBank", 180000, false);

		}
		case 3:
		{
			format(string,sizeof(string),"%s ��������� ������� ����� � ���������,�� ������� ���������",PlayerInfo[playerid][pName]);
			SendRadiusMessage(10.0, playerid, string,COLOR_PURPLE);
		}
		case 4:
		{
			format(string,sizeof(string),"%s ��������� ������� ����� � ���������,�� ��������� ������������",PlayerInfo[playerid][pName]);
			SendRadiusMessage(10.0, playerid, string,COLOR_PURPLE);
			SetPlayerWantedLevel(playerid,6);
			PlayerInfo[playerid][pWanted] = 6;
		}
	}
	open = false;
	PlayerInfo[playerid][pOtm] --;
	return true;
}
stock ApplyAnimationEx(playerid, animlib[], animname[], Float:p1, p2, p3, p4, p5, p6)
{
    ApplyAnimation(playerid, animlib, animname, p1, p2, p3, p4, p5, p6);
    SetTimerEx("UpdatePlayerAnimation", 200, 0, "issfiiiii", playerid, animlib, animname, p1, p2, p3, p4, p5, p6);
	return true;
}
forward UpdateAnimation(playerid, animlib[], animname[], Float:p1, p2, p3, p4, p5, p6);
public UpdateAnimation(playerid, animlib[], animname[], Float:p1, p2, p3, p4, p5, p6)
{
    new animl[30], animn[30];
    GetAnimationName(GetPlayerAnimationIndex(playerid), animl, sizeof(animl), animn, sizeof(animn));
    if(strcmp(animl, animlib, true) != 0 || strcmp(animn, animname, true) != 0) ApplyAnimation(playerid, animlib, animname, p1, p2, p3, p4, p5, p6);
    return true;
}
stock CapsLockCheck(text[])
{
	new len = strlen(text);
	if(len > 3)
	{
	    new c;
	    for(new i=0;i<len;i++)
	    if(text[i]>='A' && text[i]<='Z' || text[i]>='�' && text[i]<='�')
		c++;
		if(c)
		if(c>=len/4*3)
		return true;
	}
	return false;
}
stock Freeze(playerid){ TogglePlayerControllable(playerid,0); return true; }
stock UnFreeze(playerid) {  TogglePlayerControllable(playerid,1);  return true; }
forward PenaltyOff(playerid);
/*public PenaltyOff(playerid)
{
	TextDrawHideForPlayer(playerid, Traffic[playerid]);
	TextDrawHideForPlayer(playerid, Speeding[playerid]);
	TextDrawHideForPlayer(playerid, Penalty[playerid]);
	penaltyo[playerid] = false;
	return true;
}*/
new Float:RCP[][3]=
{
	{2065.3801,-1832.5280,13.68},
	{-99.7154,1117.5011,19.88},
	{719.8336,-456.7990,16.47},
	{-1420.4562,2583.2180,55.98},
	{-2424.8093,1021.1127,50.53},
	{1975.0587,2161.9456,11.21},
	{487.9699,-1741.5265,11.28},
	{1025.7683,-1023.8249,32.24},
	{-1904.9709,285.8506,41.18},
	{615.2845,-124.2390,997.7112},
	{616.7787,-74.8150,997.6274},
	{617.5302,-1.9900,1001.06}
};
stock RepairCarPos(playerid)
{
	for(new i = 0; i < sizeof(RCP); i++)
    {
	    if(IsPlayerInRangeOfPoint(playerid,10.0,RCP[i][0],RCP[i][1],RCP[i][2]))  return true;
    }
	return false;
}
stock CheckVeh(playerid)
{
	new vehid = GetPlayerVehicleID(playerid);
	if(vehid > 0)
	{
		new Float:health;
		GetVehicleHealth(vehid,health);
		if(VehHealth[vehid] < health)
		{
			if(!RepairCarPos(playerid) && GetPlayerState(playerid) == 2)
			{
				SetVehicleHealthEx(vehid,1000.0);
				new string[128];
				format(string,sizeof(string),"{F31212}[MAC]{FFFFFF}: ����� %s[%d] ���(�) ������(�) �� ������������� Car-HP",PlayerInfo[playerid][pName],playerid);
				SendAdminMessage(-1,string,1);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���� ������� �� ������������� Car-HP");
				ALKick(playerid);
			}
			else  VehHealth[vehid] = 1000.0;
		}
		else VehHealth[vehid] = health;
	}
}
stock SetVehicleHealthEx(vehicleid,Float:health) { VehHealth[vehicleid] = health; SetVehicleHealth(vehicleid,health); }
stock CheckFly(playerid)
{
	new Aninamtion[30], Float:animX, Float:animY, Float:animZ, Animation1[30];
	GetAnimationName(GetPlayerAnimationIndex(playerid) , Aninamtion, sizeof(Aninamtion), Animation1, sizeof(Animation1));
	GetPlayerPos(playerid, animX, animY, animZ);
	if(strcmp(Aninamtion, "PED", true) == 1 && strcmp(Animation1, "Swim_Breast", true) == 1 && animZ > 7)
	{
		new string[128];
		format(string,sizeof(string),"{F31212}[MAC]{FFFFFF}: ����� %s[%d] ������������� � ������������� Fly",PlayerInfo[playerid][pName],playerid);
		SendAdminMessage(-1,string,1);
	}
}
stock SHCheck(playerid)
{
	new Float:PosX,Float:PosY,Float:PosZ;
	new Float:ST[4];
	GetPlayerPos(playerid, PosX, PosY, PosZ);
	if(GetPlayerSpeed(playerid) > VehicleMaxSpeed && !IsFly(GetPlayerVehicleID(playerid)) && GetPlayerState(playerid) == 2)
	{
		GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
		if (floatabs(ST[2])<floatsqroot(floatpower(floatabs(ST[0]),2)+floatpower(floatabs(ST[1]),2)))
		{
			new string[128];
			format(string,sizeof(string),"{F31212}[MAC]{FFFFFF}: ����� %s[%d] ���(�) ������(�) �� ������������� Speed-Hack",PlayerInfo[playerid][pName],playerid);
			SendAdminMessage(-1,string,1);
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"�� ���� ������� �� ������������� Speed-Hack");
			ALKick(playerid);
		}
	}
}
stock ServerSetPlayerPos(playerid,Float:x,Float:y,Float:z)
{
	ReadPlayerPosition[playerid][ReadX] = x;
	ReadPlayerPosition[playerid][ReadY] = y;
	ReadPlayerPosition[playerid][ReadZ] = z;
	SetPlayerPos(playerid,x,y,z);
	return true;
}
stock Prava(playerid)
{
	if(PlayerInfo[playerid][pStartAsh] == 2) { PlayerInfo[playerid][pStartAsh] = 3; ashcheck = CreateDynamicCP(-2047.0709, -84.2103, 35.1641, 5.0,-1,-1,playerid,100.0); }
	if(PlayerInfo[playerid][pStartAsh] == 3 && IsPlayerInRangeOfPoint(playerid,5.0,-2047.0709, -84.2103, 35.1641) && GetPlayerState(playerid) == 2)
	{
		DestroyDynamicCP(ashcheck);
		PlayerInfo[playerid][pStartAsh] = 4;
		ashcheck = CreateDynamicCP(-2076.5476, -67.7417, 35.1719, 5.0,-1,-1,playerid,400.0);
		SendClientMessage(playerid, 0xFF0000AA, "{133894}[��������]{FFFFFF} ���� �� ��������, �������� ���");
	}
	if(PlayerInfo[playerid][pStartAsh] == 4 && IsPlayerInRangeOfPoint(playerid,5.0,-2076.5476, -67.7417, 35.1719) && GetPlayerState(playerid) == 2)
	{
		DestroyDynamicCP(ashcheck);
		PlayerInfo[playerid][pStartAsh] = 5;
		ashcheck = CreateDynamicCP(-2084.6685, 18.2108, 35.1719, 5.0,-1,-1,playerid,400.0);
		SendClientMessage(playerid, 0xFF0000AA, "{133894}[��������]{FFFFFF} ��������� �������");
	}
	if(PlayerInfo[playerid][pStartAsh] == 5 && IsPlayerInRangeOfPoint(playerid,5.0,-2084.6685, 18.2108, 35.1719) && GetPlayerState(playerid) == 2)
	{
		DestroyDynamicCP(ashcheck);
		PlayerInfo[playerid][pStartAsh] = 6;
		ashcheck = CreateDynamicCP(-2095.6614, 33.4447, 35.1719, 5.0,-1,-1,playerid,400.0);
		SendClientMessage(playerid, 0xFF0000AA, "{133894}[��������]{FFFFFF} ��������� ������");
	}
	if(PlayerInfo[playerid][pStartAsh] == 6 && IsPlayerInRangeOfPoint(playerid,5.0,-2095.6614, 33.4447, 35.1719) && GetPlayerState(playerid) == 2)
	{
		DestroyDynamicCP(ashcheck);
		PlayerInfo[playerid][pStartAsh] = 7;
		ashcheck = CreateDynamicCP(-2104.6731, 98.1016, 35.1641, 5.0,-1,-1,playerid,400.0);
		SendClientMessage(playerid, 0xFF0000AA, "{133894}[��������]{FFFFFF} ��������� �������");
	}
	if(PlayerInfo[playerid][pStartAsh] == 7 && IsPlayerInRangeOfPoint(playerid,5.0,-2104.6731, 98.1016, 35.1641) && GetPlayerState(playerid) == 2)
	{
		DestroyDynamicCP(ashcheck);
		PlayerInfo[playerid][pStartAsh] = 8;
		ashcheck = CreateDynamicCP(-2142.6428, 111.8914, 35.1719, 5.0,-1,-1,playerid,400.0);
		SendClientMessage(playerid, 0xFF0000AA, "{133894}[��������]{FFFFFF} ��������� ������");
	}
	if(PlayerInfo[playerid][pStartAsh] == 8 && IsPlayerInRangeOfPoint(playerid,5.0,-2142.6428, 111.8914, 35.1719) && GetPlayerState(playerid) == 2)
	{
		DestroyDynamicCP(ashcheck);
		PlayerInfo[playerid][pStartAsh] = 9;
		ashcheck = CreateDynamicCP(-2170.0571, -59.0547, 35.1719, 5.0,-1,-1,playerid,400.0);
		SendClientMessage(playerid, 0xFF0000AA, "{133894}[��������]{FFFFFF}  ��������� ������");
	}
	if(PlayerInfo[playerid][pStartAsh] == 9 && IsPlayerInRangeOfPoint(playerid,5.0,-2170.0571, -59.0547, 35.1719) && GetPlayerState(playerid) == 2)
	{
		DestroyDynamicCP(ashcheck);
		PlayerInfo[playerid][pStartAsh] = 10;
		ashcheck = CreateDynamicCP(-2047.4828, -78.2647, 35.1719, 7.0,-1,-1,playerid,400.0);
		SendClientMessage(playerid, 0xFF0000AA, "{133894}[��������]{FFFFFF}  ��������� ������");
	}
	if(PlayerInfo[playerid][pStartAsh] == 10 && IsPlayerInRangeOfPoint(playerid,5.0,-2047.4828, -78.2647, 35.1719) && GetPlayerState(playerid) == 2)
	{
		DestroyDynamicCP(ashcheck);
		PlayerInfo[playerid][pStartAsh] = 11;
		ashcheck = CreateDynamicCP(-2056.3352, -97.1253, 35.1718, 7.0,-1,-1,playerid,400.0);
	}
	if(PlayerInfo[playerid][pStartAsh] == 11 && IsPlayerInRangeOfPoint(playerid,5.0,-2056.3352, -97.1253, 35.1718) && GetPlayerState(playerid) == 2)
	{
		DestroyDynamicCP(ashcheck);
		PlayerInfo[playerid][pStartAsh] = 12;
		ashcheck = CreateDynamicCP(-2078.8362, -96.1702, 35.1641, 7.0,-1,-1,playerid,400.0);
	}
	if(PlayerInfo[playerid][pStartAsh] == 12 && IsPlayerInRangeOfPoint(playerid,5.0,-2078.8362, -96.1702, 35.1641) && GetPlayerState(playerid) == 2)
	{
		PlayerInfo[playerid][pStartAsh] = 0;
		DestroyDynamicCP(ashcheck);
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		SendClientMessage(playerid, 0xFF0000AA, "{F31212}[��������]{FFFFFF} �����������, �� c���� ����!");
		PlayerInfo[playerid][pLic][1] = true;
		if(PlayerInfo[playerid][pQuest][0] == false) {
		    SendClientMessage(playerid, -1, ""PURP"�� ��������� �����: �������� ���. �����");
		    PlayerInfo[playerid][pQuest][0] = true;
		    return true;
		}
		SendClientMessage(playerid,-1,"{3812E1}[���������]{FFFFFF} ��������� /kpk -> GPS ��������� -> ������. ������ ���� ���� �� ������������ ����� � ����������� ����");
	}
	return true;
}
stock GetWeaponModel(weaponid)
{
	switch(weaponid)
	{
		case 1:  return 331;
		case 2..8:   return weaponid+331;
        case 9: return 341;
		case 10..15: return weaponid+311;
		case 16..18: return weaponid+326;
		case 22..29: return weaponid+324;
		case 30,31:  return weaponid+325;
        case 32:  return 372;
		case 33..45: return weaponid+324;
		case 46:  return 371;
	}
	return true;
}
forward WarningOff(playerid);
public WarningOff(playerid) return warning[playerid] = false;

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
    if(IsPlayerInRangeOfPoint(playerid, 3.0, -113.7627, -326.2541, 1.4297) && PlayerInfo[playerid][pJob] == 2 && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER))
    {
        SendClientMessage(playerid, -1,"{3812E1}[���������]{FFFFFF} ��� ���� ����� ������ ������, ������� ������� /delivery");
        DestroyDynamicCP(cpdeliv[playerid]);
		return true;
    }
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) {
		for(new i; i < sizeof(HouseInfo); i++) {
			if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]) && HouseInfo[i][hOwned] == false)  { 
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~~n~��O�� BO���~n~~w~�OKY�KA - ~r~/buyhouse");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]) && HouseInfo[i][hOwned] == true)  { 
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~~n~~n~��O�� BO���");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][hExitx], HouseInfo[i][hExity], HouseInfo[i][hExitz])) {
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~~n~~n~ ��O�� B����");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
		}
		for(new i; i < sizeof(Ammo); i++) {
			if(IsPlayerInRangeOfPoint(playerid, 3.0, Ammo[i][amEnterX], Ammo[i][amEnterY], Ammo[i][amEnterZ])) {
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~~n~~n~��O�� BO���");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, Ammo[i][amExitX], Ammo[i][amExitY], Ammo[i][amExitZ])) {
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~~n~~n~��O�� BO���");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, Ammo[i][amBuyX], Ammo[i][amBuyY], Ammo[i][amBuyZ])) {
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~~n~~n~��� �OKY�K�");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
		}
		for(new i; i < sizeof(Magazin); i++) {
			if(IsPlayerInRangeOfPoint(playerid, 3.0, Magazin[i][mEnterX], Magazin[i][mEnterY], Magazin[i][mEnterZ])) {
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~~n~~n~��O�� BO���");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, Magazin[i][mExitX], Magazin[i][mExitY], Magazin[i][mExitZ])) {
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~~n~~n~��O�� B����");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, Magazin[i][mBuyX], Magazin[i][mBuyY], Magazin[i][mBuyZ])) {
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~~n~~n~�� �OKY�K�");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
		}
		for(new i; i < sizeof(Club); i++) {
			if(IsPlayerInRangeOfPoint(playerid, 3.0, Club[i][cEnterX], Club[i][cEnterY], Club[i][cEnterZ])) {
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~~n~~n~��O�� BO���");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, Club[i][cExitX], Club[i][cExitY], Club[i][cExitZ])) {
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~~n~~n~��O�� B����");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 3.0, Club[i][cBuyX], Club[i][cBuyY], Club[i][cBuyZ])) {
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~~n~~n~�� �OKY�K�");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
		}
		for(new i; i < sizeof(Fraction); i++) {
			if(IsPlayerInRangeOfPoint(playerid, 3.0, Fraction[i][fBX], Fraction[i][fBY], Fraction[i][fBZ]) && i == GetPlayerMember(playerid)) {
				PlayerTextDrawShow(playerid, BoxInfo[playerid]);
				PlayerTextDrawShow(playerid, InfoTitle[playerid]);
				PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~ALT~w~�� �POC�O�PA");
				PlayerTextDrawShow(playerid, InfoText[playerid]);
				SetPVarInt(playerid, "showpod", 1);
				return true;
			}
		}
		return true;
	}
	for(new i; i < sizeof(Gas); i++) {
		if(IsPlayerInRangeOfPoint(playerid, 3.0, Gas[i][gX], Gas[i][gY], Gas[i][gZ])) {
			PlayerTextDrawShow(playerid, BoxInfo[playerid]);
			PlayerTextDrawShow(playerid, InfoTitle[playerid]);
			PlayerTextDrawSetString(playerid,InfoText[playerid],"~w~�C�O���Y� ~y~C���A�~w~~n~��� �A�PABK� AB�O�");
			PlayerTextDrawShow(playerid, InfoText[playerid]);
			SetPVarInt(playerid, "showpod", 1);
			return true;
		}
	}
	if(checkpointid == taxicheck[playerid])
	{
		DestroyDynamicCP(taxicheck[playerid]);
		taxicheck[playerid] = -1;
		if(GetPVarInt(GetPVarInt(playerid,"callerid"),"accepterid") == playerid)
		{
			new Float:ppos[3];
			GetPlayerPos(playerid,ppos[0],ppos[1],ppos[2]);
			if(IsPlayerInRangeOfPoint(GetPVarInt(playerid,"callerid"),10.0,ppos[0],ppos[1],ppos[2]))
			{
				new string[128];
				format(string,sizeof(string),"�� �� ���������� �� ����� ������. �� ��������� ����� �� ������ ����� 10000$ ������ %s[%d]",PlayerInfo[playerid][pName],playerid);
				SendClientMessage(GetPVarInt(playerid,"callerid"),COLOR_LIGHTBLUE,string);
				format(string,sizeof(string),"����� %s[%d] �������� ��� ����� �� ������ ����� 10000$",PlayerInfo[GetPVarInt(playerid,"callerid")][pName],GetPVarInt(playerid,"callerid"));
				SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
				SetMoney(playerid, 10000);
				SetMoney(GetPVarInt(playerid,"callerid"), -10000);
			}
		}
		SetPVarInt(GetPVarInt(playerid,"callerid"),"accepterid",-1);
		SetPVarInt(playerid,"callerid",-1);
		return true;
	}
	if(GetPVarInt(playerid,"Gruz") != 0)
    {
        if(checkpointid == gruzcp[playerid])
        {
			if(IsPlayerInAnyVehicle(playerid)) {
				new string[128];
				if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return SendClientMessage(playerid, COLOR_WHITE,"� ���� ��� �������.");
				DestroyDynamicCP(checkpointid);
				new rand = random(1000) + 6000;
				SetMoney(playerid,rand);
				format(string,sizeof(string),""INFO"�� ��������� ���� � ���������� "YE"%i$",rand);
				SendClientMessage(playerid, -1,string);
				DestroyVehicle(pricep[playerid]);
				pricep[playerid] = INVALID_VEHICLE_ID;
				DestroyDynamic3DTextLabel(DB[playerid]);
				DeletePVar(playerid, "Gruz");
				gruzcp[playerid] = -1;
			}	
        }
	}
	return true;
}
public OnPlayerLeaveDynamicCP(playerid, checkpointid) {
	if(GetPVarInt(playerid, "showpod") == 1) {
		PlayerTextDrawHide(playerid, BoxInfo[playerid]);
		PlayerTextDrawHide(playerid, InfoTitle[playerid]);
		PlayerTextDrawHide(playerid, InfoText[playerid]);
		DeletePVar(playerid, "showpod");
		return true;
	}
	return true;
}	
stock SpeedON(playerid, newstate)
{
	if(GetPlayerState(playerid) == newstate) {
		for(new i; i < 11; i++)	PlayerTextDrawShow(playerid, Textdraw[i][playerid]);
	}
	new string[128];
	format(string, sizeof(string), "%s", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
	PlayerTextDrawSetString(playerid, Textdraw[1][playerid], string);
	return true;
}
stock SpeedOFF(playerid)
{
	for(new i; i < 11; i++)	PlayerTextDrawHide(playerid, Textdraw[i][playerid]);
	return true;
}
stock ShowInv(playerid)
{
	new string[400]; new gun[5][32],string1[255];
	if(Weapon[playerid][wGun][0] > 0) GetWeaponName(Weapon[playerid][wGun][0],gun[0],32);
	else gun[0] =  "���� ����";
	if(Weapon[playerid][wGun][1] > 0) GetWeaponName(Weapon[playerid][wGun][1],gun[1],32);
	else gun[1] = "���� ����";
	if(Weapon[playerid][wGun][2] > 0) GetWeaponName(Weapon[playerid][wGun][2],gun[2],32);
	else gun[2] = "���� ����";
	if(Weapon[playerid][wGun][3] > 0) GetWeaponName(Weapon[playerid][wGun][3],gun[3],32);
	else gun[3] = "���� ����";
	if(Weapon[playerid][wGun][4] > 0) GetWeaponName(Weapon[playerid][wGun][4],gun[4],32);
	else gun[4] = "���� ����";
	format(string,sizeof(string),"{17D6E0}%s{FFFFFF}\t\t\t\t\t(�������: %d)\n{17D6E0}%s{FFFFFF}\t\t\t\t\t(�������: %d)\n{17D6E0}%s{FFFFFF}\t\t\t\t\t(�������: %d)\n{17D6E0}%s{FFFFFF}\t\t\t\t\t\t(�������: %d)\n{17D6E0}%s{FFFFFF}\t\t\t\t\t\t(�������: %d)",gun[0],Weapon[playerid][wSlot1],gun[1],Weapon[playerid][wSlot2],gun[2],Weapon[playerid][wSlot3],gun[3],Weapon[playerid][wSlot4],gun[4],Weapon[playerid][wSlot5]);
	format(string1,sizeof(string1),"\n{17D6E0}���������:{FFFFFF}\t\t\t\t\t%d\n{17D6E0}���������:{FFFFFF}\t\t\t\t\t%d",PlayerInfo[playerid][pMats],PlayerInfo[playerid][pDrugs]);
	strcat(string,string1);
	SPD(playerid,DIALOG_INVENTORY,DIALOG_STYLE_LIST,""PREFIX" ���������",string,"�����","������");
	return true;
}
stock CreateTextDraw(playerid)
{
	new string[128];
	lvlexp[playerid] = CreatePlayerTextDraw(playerid,501.000000, 6.000000,"_");
    PlayerTextDrawBackgroundColor(playerid,lvlexp[playerid],255);
    PlayerTextDrawFont(playerid,lvlexp[playerid],2);
    PlayerTextDrawLetterSize(playerid,lvlexp[playerid],0.310000, 2.099999);
    PlayerTextDrawColor(playerid,lvlexp[playerid],-1);
    PlayerTextDrawSetOutline(playerid,lvlexp[playerid],0);
    PlayerTextDrawSetProportional(playerid,lvlexp[playerid],1);
    PlayerTextDrawSetShadow(playerid,lvlexp[playerid],1);
	PlayerTextDrawSetShadow(playerid,lvlexp[playerid], 1);
	PlayerTextDrawShow(playerid, lvlexp[playerid]);
	format(string,sizeof(string),"~w~LvL: ~Y~%d  ~w~Exp: ~Y~%d~w~/~Y~%d",PlayerInfo[playerid][pLevel],PlayerInfo[playerid][pExp],PlayerInfo[playerid][pExpNext]);
	PlayerTextDrawSetString(playerid,lvlexp[playerid], string);
	
	BoxInfo[playerid] = CreatePlayerTextDraw(playerid,175.000000, 135.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,BoxInfo[playerid] , 255);
	PlayerTextDrawFont(playerid,BoxInfo[playerid] , 1);
	PlayerTextDrawLetterSize(playerid,BoxInfo[playerid] , 1.000000, 4.000000);
	PlayerTextDrawColor(playerid,BoxInfo[playerid] , -1);
	PlayerTextDrawSetOutline(playerid,BoxInfo[playerid] , 0);
	PlayerTextDrawSetProportional(playerid,BoxInfo[playerid] , 1);
	PlayerTextDrawSetShadow(playerid,BoxInfo[playerid] , 1);
	PlayerTextDrawUseBox(playerid,BoxInfo[playerid] , 1);
	PlayerTextDrawBoxColor(playerid,BoxInfo[playerid] , 117);
	PlayerTextDrawTextSize(playerid,BoxInfo[playerid] , 19.000000, 17.000000);

	InfoTitle[playerid]  = CreatePlayerTextDraw(playerid,23.000000, 122.000000, "~b~�O�CKA3KA");
	PlayerTextDrawBackgroundColor(playerid,InfoTitle[playerid] , 255);
	PlayerTextDrawFont(playerid,InfoTitle[playerid] , 2);
	PlayerTextDrawLetterSize(playerid,InfoTitle[playerid] , 0.380000, 1.000000);
	PlayerTextDrawColor(playerid,InfoTitle[playerid] , 16777215);
	PlayerTextDrawSetOutline(playerid,InfoTitle[playerid] , 0);
	PlayerTextDrawSetProportional(playerid,InfoTitle[playerid] , 1);
	PlayerTextDrawSetShadow(playerid,InfoTitle[playerid], 0);
	PlayerTextDrawUseBox(playerid,InfoTitle[playerid], 1);
	PlayerTextDrawBoxColor(playerid,InfoTitle[playerid], -1);
	PlayerTextDrawTextSize(playerid,InfoTitle[playerid], 171.000000, 0.000000);

	InfoText[playerid]  = CreatePlayerTextDraw(playerid,30.000000, 138.000000, "");
	PlayerTextDrawBackgroundColor(playerid,InfoText[playerid] , 255);
	PlayerTextDrawFont(playerid,InfoText[playerid] , 2);
	PlayerTextDrawLetterSize(playerid,InfoText[playerid] , 0.290000, 1.100000);
	PlayerTextDrawColor(playerid,InfoText[playerid] , -1);
	PlayerTextDrawSetOutline(playerid,InfoText[playerid] , 0);
	PlayerTextDrawSetProportional(playerid,InfoText[playerid] , 1);
	PlayerTextDrawSetShadow(playerid,InfoText[playerid], 1);
	new time[32],hour, minute;
	gettime(hour, minute);
	format(time,sizeof(time),"~w~%02d~y~:~w~%02d",hour,minute);
	UpdateTime();
	Time[playerid] = CreatePlayerTextDraw(playerid, 547.000000, 22.000000, time);
	PlayerTextDrawUseBox(playerid,Time[playerid],0);
	PlayerTextDrawFont(playerid,Time[playerid],2);
	PlayerTextDrawSetShadow(playerid,Time[playerid],2);
	PlayerTextDrawSetOutline(playerid,Time[playerid],1);
    PlayerTextDrawBackgroundColor(playerid,Time[playerid], 255);
    PlayerTextDrawColor(playerid,Time[playerid], -1);
	PlayerTextDrawSetProportional(playerid,Time[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Time[playerid], 0.500000, 3.000000);

	TimeJail[playerid] = CreatePlayerTextDraw(playerid,514.000000,394.000000,"_");
    PlayerTextDrawAlignment(playerid,TimeJail[playerid],0);
    PlayerTextDrawBackgroundColor(playerid,TimeJail[playerid],0x000000ff);
    PlayerTextDrawFont(playerid,TimeJail[playerid],1);
    PlayerTextDrawLetterSize(playerid,TimeJail[playerid],0.3, 1.6);
    PlayerTextDrawColor(playerid,TimeJail[playerid],0xffff00ff);
    PlayerTextDrawSetOutline(playerid,TimeJail[playerid],1);
    PlayerTextDrawSetProportional(playerid,TimeJail[playerid],1);
    PlayerTextDrawSetShadow(playerid,TimeJail[playerid],1);
	Site[playerid] = CreatePlayerTextDraw(playerid,28.000000, 424.000000, "~w~alpino~y~-~w~rpg~y~.~w~ru");
	PlayerTextDrawBackgroundColor(playerid,Site[playerid], 255);
	PlayerTextDrawFont(playerid,Site[playerid], 2);
	PlayerTextDrawLetterSize(playerid,Site[playerid], 0.39, 2.0);
	PlayerTextDrawColor(playerid,Site[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Site[playerid], 1);
	PlayerTextDrawSetProportional(playerid,Site[playerid], 1);
	CreateDynamicCP(563.4053,1294.2433,10.4047, 4.0, 0, 0, playerid, 5.0);
	CreateDynamicCP(491.2431,1290.4115,9.0382, 4.0, 0, 0, playerid, 5.0);
	CreateDynamicCP(601.9938,1514.9343,7.8619, 4.0, 0, 0, playerid, 5.0);
	CreateDynamicCP(626.8386,1340.0171,11.9890, 4.0, 0, 0, playerid, 5.0);
	CreateDynamicCP(1304.8506,-1374.8540,13.6398, 1.0, 0, 0, playerid, 5.0);
	CreateDynamicCP(2026.3734,1905.9640,12.2596, 1.0, 0, 0, playerid, 5.0);
	CreateDynamicCP(-1975.9777,128.9678,27.6940, 1.0, 0, 0, playerid, 5.0);

	FULLRECON[playerid] = CreatePlayerTextDraw(playerid,472.000000, 128.000000,"_");
	PlayerTextDrawFont(playerid,FULLRECON[playerid],1);
	PlayerTextDrawLetterSize(playerid,FULLRECON[playerid],0.410000, 1.000000);
	PlayerTextDrawColor(playerid,FULLRECON[playerid],-1);
	PlayerTextDrawSetOutline(playerid,FULLRECON[playerid],1);
	PlayerTextDrawSetProportional(playerid,FULLRECON[playerid], 1);
	PlayerTextDrawAlignment(playerid,FULLRECON[playerid], 1);
	PlayerTextDrawSetShadow(playerid,FULLRECON[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid,FULLRECON[playerid], 30);
	
	Textdraw[0][playerid] = CreatePlayerTextDraw(playerid, 616.230957, 339.250030, "usebox");
	PlayerTextDrawLetterSize(playerid, Textdraw[0][playerid], 0.000000, 8.773875);
	PlayerTextDrawTextSize(playerid, Textdraw[0][playerid], 421.543243, 0.000000);
	PlayerTextDrawAlignment(playerid, Textdraw[0][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[0][playerid], 1166737578);
	PlayerTextDrawUseBox(playerid, Textdraw[0][playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw[0][playerid], 1770726058);
	PlayerTextDrawSetShadow(playerid, Textdraw[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[0][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[0][playerid], 1166737578);
	PlayerTextDrawFont(playerid, Textdraw[0][playerid], 0);

	Textdraw[1][playerid] = CreatePlayerTextDraw(playerid, 413.236083, 324.916534, "FAGGIO");
	PlayerTextDrawLetterSize(playerid, Textdraw[1][playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Textdraw[1][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[1][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[1][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[1][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[1][playerid], 2);
	PlayerTextDrawSetProportional(playerid, Textdraw[1][playerid], 1);

	Textdraw[2][playerid] = CreatePlayerTextDraw(playerid, 473.269622, 355.083374, "S:");
	PlayerTextDrawLetterSize(playerid, Textdraw[2][playerid], 0.472956, 2.019999);
	PlayerTextDrawAlignment(playerid, Textdraw[2][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[2][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[2][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[2][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[2][playerid], 3);
	PlayerTextDrawSetProportional(playerid, Textdraw[2][playerid], 1);

	Textdraw[3][playerid] = CreatePlayerTextDraw(playerid, 493.821868, 349.416687, "IIIIIIIIIIIIIII");
	PlayerTextDrawLetterSize(playerid, Textdraw[3][playerid], 0.701125, 3.233330);
	PlayerTextDrawAlignment(playerid, Textdraw[3][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[3][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[3][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[3][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[3][playerid], 2);
	PlayerTextDrawSetProportional(playerid, Textdraw[3][playerid], 1);

	Textdraw[4][playerid] = CreatePlayerTextDraw(playerid, 474.612121, 380.333343, "F:");
	PlayerTextDrawLetterSize(playerid, Textdraw[4][playerid], 0.472956, 2.019999);
	PlayerTextDrawAlignment(playerid, Textdraw[4][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[4][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[4][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[4][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[4][playerid], 3);
	PlayerTextDrawSetProportional(playerid, Textdraw[4][playerid], 1);

	Textdraw[5][playerid] = CreatePlayerTextDraw(playerid, 613.420227, 342.750000, "usebox");
	PlayerTextDrawLetterSize(playerid, Textdraw[5][playerid], 0.000000, 7.979629);
	PlayerTextDrawTextSize(playerid, Textdraw[5][playerid], 424.822845, 0.000000);
	PlayerTextDrawAlignment(playerid, Textdraw[5][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[5][playerid], 0);
	PlayerTextDrawUseBox(playerid, Textdraw[5][playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw[5][playerid], 102);
	PlayerTextDrawSetShadow(playerid, Textdraw[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[5][playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw[5][playerid], 0);

	Textdraw[6][playerid] = CreatePlayerTextDraw(playerid, 493.884826, 375.500030, "IIIIIIIIIIIIIII");
	PlayerTextDrawLetterSize(playerid, Textdraw[6][playerid], 0.701125, 3.233330);
	PlayerTextDrawAlignment(playerid, Textdraw[6][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[6][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[6][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[6][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[6][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[6][playerid], 2);
	PlayerTextDrawSetProportional(playerid, Textdraw[6][playerid], 1);

	Textdraw[7][playerid] = CreatePlayerTextDraw(playerid, 472.738128, 373.333343, "(0 km/h)");
	PlayerTextDrawLetterSize(playerid, Textdraw[7][playerid], 0.156237, 0.969999);
	PlayerTextDrawAlignment(playerid, Textdraw[7][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[7][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[7][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[7][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[7][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[7][playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw[7][playerid], 1);

	Textdraw[8][playerid] = CreatePlayerTextDraw(playerid, 474.143524, 399.583312, "~w~(~g~100L~w~)");
	PlayerTextDrawLetterSize(playerid, Textdraw[8][playerid], 0.163733, 0.958332);
	PlayerTextDrawAlignment(playerid, Textdraw[8][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[8][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[8][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[8][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[8][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[8][playerid], 2);
	PlayerTextDrawSetProportional(playerid, Textdraw[8][playerid], 1);

	Textdraw[9][playerid] = CreatePlayerTextDraw(playerid, 574.407104, 407.749969, "~g~E L OPEN");
	PlayerTextDrawLetterSize(playerid, Textdraw[9][playerid], 0.228387, 0.905833);
	PlayerTextDrawAlignment(playerid, Textdraw[9][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[9][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[9][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[9][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[9][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[9][playerid], 3);
	PlayerTextDrawSetProportional(playerid, Textdraw[9][playerid], 1);

	Textdraw[10][playerid] = CreatePlayerTextDraw(playerid, 427.291503, 351.750030, "M");
	PlayerTextDrawLetterSize(playerid, Textdraw[10][playerid], 0.567597, 10.729161);
	PlayerTextDrawAlignment(playerid, Textdraw[10][playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw[10][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw[10][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw[10][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw[10][playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw[10][playerid], 0);
	PlayerTextDrawSetProportional(playerid, Textdraw[10][playerid], 1);
	PlayerTextDrawFont(playerid, Textdraw[10][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawUseBox(playerid, Textdraw[10][playerid], 0);
    PlayerTextDrawTextSize(playerid, Textdraw[10][playerid], 55.0, 50.0);
    PlayerTextDrawSetPreviewModel(playerid, Textdraw[10][playerid], 411);
    PlayerTextDrawSetPreviewRot(playerid, Textdraw[10][playerid], -10.0, 0.0, -20.0,0.8);
    PlayerTextDrawBackgroundColor(playerid, Textdraw[10][playerid], 0xFFFFFF00);
	
	return true;
}
forward GunJob(playerid);
public GunJob(playerid)
{
	SendClientMessage(playerid,COLOR_LIGHTBLUE,"�������� ������� �� �����");
	RemovePlayerAttachedObject(playerid,5);
	SetPlayerAttachedObject(playerid,5,2358,1,0.075578,0.407083,0.000000,1.248928,97.393852,359.645050,1.000000,1.000000,1.000000);
	ClearAnimations(playerid);
	UnFreeze(playerid);
	ApplyAnimationEx(playerid,"CARRY","crry_prtial",4.1,0,1,1,1,1);
	return true;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
 	SPD(playerid,DIALOG_TARGET,DIALOG_STYLE_LIST,""PREFIX" �������� � �������","{3CBBF7}[1]{ffffff} �������� ������\n{3CBBF7}[2]{ffffff} ��������\n{3CBBF7}[3]{ffffff} �������� �������������","�����","������");
 	targetp[playerid] = clickedplayerid;
}
forward UnTazer(playerid);
public UnTazer(playerid) { ClearAnimations(playerid); UnFreeze(playerid); return true; }

forward DeleteCar(vehid);
public DeleteCar(vehid)
{
	if(!IsVehicleOccupied(vehid)) DestroyVehicle(vehid);
	else SetTimerEx("DeleteCar",900000,false,"i",vehid);
	return true;
}
public OnPlayerAirbreak(playerid)
{
	if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid) && PlayerInfo[playerid][pAdmin] < 5 && PlayerInfo[playerid][pLogged] == true)
	{
		new string[128];
		if (IsPlayerInAnyVehicle(playerid)) format(string, sizeof(string), "{F31212}[AAC]{FFFFFF}: %s[%d] �������� air-break � ������", PlayerInfo[playerid][pName], playerid);
		else  format(string, sizeof(string), "{F31212}[AAC]{FFFFFF}: %s[%d] ��������(�) ����������(�) air-break ������", PlayerInfo[playerid][pName], playerid);
		SendAdminMessage(-1, string, 1);
	}
    return true;
}
stock GetCarPrice(model,playerid)
{
	switch(model)
	{
	    case 400,418,459,478,479,482,483,489,500,505,579: carprice[playerid] = 350000;
		case 401,404,405,410,419,422,421,426,436,439,445,458,466,467,474,475,491,492,496,507,516,517,518,526,527,529,533,540,542,545,546,547,549,550,551,555,566,580,585,589,600: carprice[playerid] = 250000;
		case 558,559,560,561,562,565: carprice[playerid] = 500000;
		case 534,535,536,567,576: carprice[playerid] = 450000;
		case 402,411,415,429,451,480,506,541,602,603: carprice[playerid] = 1000000;
		case 461,462,463,471,581,521,522,586,477: carprice[playerid] = 600000;
		case 424,444,470,494,495,502,503,504,556,557,568,573,409: carprice[playerid] = 5000000;
	}
	return carprice[playerid];
}
forward Vozvrat(playerid);
public Vozvrat(playerid)  { SetCameraBehindPlayer(playerid); return true; }
stock ManualCar(carid)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(carid,engine,lights,alarm,doors,bonnet,boot,objective);
	switch(GetVehicleModel(carid))
	{
		case 400,404,466,507,527,496,401,410,422,426,436,442,448,457,458,462,474,478,479,485,491,492,516,517,518,525,528,529,530,540,543,546,547,549,550,575,576,585,600,604,605: fueltype[carid] = 80,fuelic[carid] = 80;
		case 566,589,523,405,412,416,419,420,421,438,441,445,467,471,475,504,526,536,539,542,551,552,567,571,580,581,582,583,586,588: fueltype[carid] = 92,fuelic[carid] = 92;
		case 596,597,598,603,602,565,558,533,500,424,434,439,463,468,480,534,535,545,554,555,561,568,587,502,503,402,409,411,415,429,444,451,461,477,494,506,521,522,541,556,557,559,560,562: fueltype[carid] = 95,fuelic[carid] = 95;
		case 601,514,515,505,498,499,403,406,407,408,413,414,418,423,427,428,431,432,433,437,440,443,455,456,459,470,482,483,486,489,490,495,508,524,531,532,544,572,573,574,578,579,599,609: fueltype[carid] = 98,fuelic[carid] = 98;
	}
	if(IsBicycle(carid) || IsBoat(carid) || IsFly(carid)) SetVehicleParamsEx(carid,true,false,false,false,false,false,false);
	else
	{
		fuel[carid] = 100;
		VehHealth[carid] = 1000.0;
		SetVehicleNumberPlate(carid,"Alpino");
		SetVehicleParamsEx(carid,false,false,false,false,false,false,false);
	}
	benzo[carid] = false;
	return true;
}
stock UpdateHouseCar(h)
{
	DestroyVehicle(HouseInfo[h][hCar]);
	HouseInfo[h][hCar] = AddStaticVehicleEx(HouseInfo[h][hCarM],HouseInfo[h][hCarX],HouseInfo[h][hCarY],HouseInfo[h][hCarZ],HouseInfo[h][hCarAngle],HouseInfo[h][hCarC1],HouseInfo[h][hCarC2],600);
	ManualCar(HouseInfo[h][hCar]);
	return true;
}
stock GetTypeFuel(i)
{
	switch(i)
	{
		case 400,404,466,507,527,496,401,410,422,426,436,442,448,457,458,462,474,478,479,485,491,492,516,517,518,525,528,529,530,540,543,546,547,549,550,575,576,585,600,604,605: fueltype[i] = 80;
		case 566,589,523,405,412,416,419,420,421,438,441,445,467,471,475,504,526,536,539,542,551,552,567,571,580,581,582,583,586,588: fueltype[i] = 92;
		case 596,597,598,603,602,565,558,533,500,424,434,439,463,468,480,534,535,545,554,555,561,568,587,502,503,402,409,411,415,429,444,451,461,477,494,506,521,522,541,556,557,559,560,562: fueltype[i] = 95;
		case 601,514,515,505,498,499,403,406,407,408,413,414,418,423,427,428,431,432,433,437,440,443,455,456,459,470,482,483,486,489,490,495,508,524,531,532,544,572,573,574,578,579,599,609: fueltype[i] = 98;
	}
	return fueltype[i];
}
public OnRconLoginAttempt(ip[], password[], success)
{
	new pip[16],string[144];
	if(success)
	{
		foreach(Player,i)
        {
            GetPlayerIp(i, pip, sizeof(pip));
            if(!strcmp(ip, pip, true && !IsPlayerName(i,"SCR") && !IsPlayerName(i,"Ko1basteR")))
			{
				format(string,sizeof(string),"%s[%d] ������� �� ������� ����� � RCON",PlayerInfo[i][pName],i);
				SendAdminMessage(COLOR_LIGHTRED,string,1);
                SendClientMessage(i, 0xFFFFFFFF, "���������� :)");
                Ban(i);
			 }
		}
	}
    if(!success)
    {
        printf("FAILED RCON LOGIN BY IP %s USING PASSWORD %s",ip, password);
		foreach(Player,i)
        {
            GetPlayerIp(i, pip, sizeof(pip));
            if(!strcmp(ip, pip, true && !IsPlayerName(i,"SCR")))
            {
				format(string,sizeof(string),"%s[%d] ������� �� ������� ����� � RCON",PlayerInfo[i][pName],i);
				SendAdminMessage(COLOR_LIGHTRED,string,1);
                SendClientMessage(i, 0xFFFFFFFF, "���������� :)");
                Ban(i);
            }
        }
    }
    return true;
}
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart) {
    if(issuerid != INVALID_PLAYER_ID) {
		new string[32];
		format(string,sizeof(string),"-%.0f hp",amount);
		SetPlayerChatBubble(playerid, string, COLOR_LIGHTRED, 10.0, 1000);
    }
	if(bodypart == 9) {
		ServerSetPlayerHealth(playerid, 0);
		return  false;
	}
	if(bodypart == 9 && nadm[playerid] == true && nadm[issuerid] == true) {
		PlayAudioStreamForPlayer(issuerid, "http://alpino-rpg/samp/headshot.mp3",0.0,0.0,0.0);
	}
    return false;
}
stock WriteLog(namelog[],string[])
{
	new query[256],computation1, computation2, computation3,computation4,computation5,computation6;
    gettime(computation1, computation2, computation3);
	getdate(computation4, computation5, computation6);
	format(query,sizeof(query),"INSERT INTO `%s` (year,month,date,hour,minute,second,log) VALUES (%02d,%02d,%02d,%02d,%02d,%02d,'%s')",namelog,computation4,computation5,computation6,computation1, computation2, computation3,string);
    mysql_free_result();
    mysql_query(query);
    return true;
}
SpawnVehicle_InfrontOfPlayer(playerid, vehiclemodel, color1, color2)
{
	new Float:x,Float:y,Float:z;
	new Float:facing;
	new Float:distance;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, facing);
    new Float:size_x,Float:size_y,Float:size_z;
	GetVehicleModelInfo(vehiclemodel, VEHICLE_MODEL_INFO_SIZE, size_x, size_y, size_z);
	distance = size_x + 0.5;
  	x += (distance * floatsin(-facing, degrees));
    y += (distance * floatcos(-facing, degrees));
	facing += 90.0;
	if(facing > 360.0) facing -= 360.0;
	if(vehcar[playerid] != INVALID_VEHICLE_ID) DestroyVehicle(vehcar[playerid]);
	vehcar[playerid] = CreateVehicle(vehiclemodel, x, y, z + (size_z * 0.25), facing, color1, color2, -1);
	SetVehicleParamsEx(vehcar[playerid],true,false,false,false,false,false,false);
	VehHealth[vehcar[playerid]] = 1000.0;
	incar[playerid] = true;
	PutPlayerInVehicle(playerid, vehcar[playerid], 0);
 	LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(playerid));
	switch(GetVehicleModel(vehcar[playerid]))
	{
		case 400,404,466,507,527,496,401,410,422,426,436,442,448,457,458,462,474,478,479,485,491,492,516,517,518,525,528,529,530,540,543,546,547,549,550,575,576,585,600,604,605: fueltype[vehcar[playerid]] = 80,fuelic[vehcar[playerid]] = 80;
		case 566,589,523,405,412,416,419,420,421,438,441,445,467,471,475,504,526,536,539,542,551,552,567,571,580,581,582,583,586,588: fueltype[vehcar[playerid]] = 92,fuelic[vehcar[playerid]] = 92;
		case 596,597,598,603,602,565,558,533,500,424,434,439,463,468,480,534,535,545,554,555,561,568,587,502,503,402,409,411,415,429,444,451,461,477,494,506,521,522,541,556,557,559,560,562: fueltype[vehcar[playerid]] = 95,fuelic[vehcar[playerid]] = 95;
		case 601,514,515,505,498,499,403,406,407,408,413,414,418,423,427,428,431,432,433,437,440,443,455,456,459,470,482,483,486,489,490,495,508,524,531,532,544,572,573,574,578,579,599,609: fueltype[vehcar[playerid]] = 98,fuelic[vehcar[playerid]] = 98;
	}
	if(!IsBicycle(vehcar[playerid]) && !IsBoat(vehcar[playerid]) && !IsFly(vehcar[playerid])) { ToggleEngine(vehcar[playerid], VEHICLE_PARAMS_ON); SetVehicleNumberPlate(vehcar[playerid],"Admin"); fuel[vehcar[playerid]] = 1000; }
	return true;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(GetPVarInt(playerid, "vspawner_active") == 0) return false;
	new curpage = GetPVarInt(playerid, "vspawner_page");
	if(playertextid == gNextButtonTextDrawId[playerid]) {
	    if(curpage < (GetNumberOfPages() - 1)) {
	        SetPVarInt(playerid, "vspawner_page", curpage + 1);
	        ShowPlayerModelPreviews(playerid);
         	UpdatePageTextDraw(playerid);
         	PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
		} else {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return 1;
	}
	if(playertextid == gPrevButtonTextDrawId[playerid]) {
	    if(curpage > 0) {
	    	SetPVarInt(playerid, "vspawner_page", curpage - 1);
	    	ShowPlayerModelPreviews(playerid);
	    	UpdatePageTextDraw(playerid);
	    	PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
		} else {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		}
		return 1;
	}
	new x=0;
	while(x != SELECTION_ITEMS) {
	    if(playertextid == gSelectionItems[playerid][x]) {
	        HandlePlayerItemSelection(playerid, x);
	        PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
	        DestroySelectionMenu(playerid);
	        CancelSelectTextDraw(playerid);
        	SetPVarInt(playerid, "vspawner_active", 0);
        	return 1;
		}
		x++;
	}
	return false;
}
GetNumberOfPages()
{
	if((gTotalItems >= SELECTION_ITEMS) && (gTotalItems % SELECTION_ITEMS) == 0)
	{
		return (gTotalItems / SELECTION_ITEMS);
	}
	else return (gTotalItems / SELECTION_ITEMS) + 1;
}

PlayerText:CreateCurrentPageTextDraw(playerid, Float:Xpos, Float:Ypos)
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, "0/0");
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

PlayerText:CreatePlayerDialogButton(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, button_text[])
{
 	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, button_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 1);
   	PlayerTextDrawBoxColor(playerid, txtInit, 0x000000FF);
   	PlayerTextDrawBackgroundColor(playerid, txtInit, 0x000000FF);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 0);
    PlayerTextDrawColor(playerid, txtInit, 0x4A5A6BFF);
    PlayerTextDrawSetSelectable(playerid, txtInit, 1);
    PlayerTextDrawAlignment(playerid, txtInit, 2);
    PlayerTextDrawTextSize(playerid, txtInit, Height, Width);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

PlayerText:CreatePlayerHeaderTextDraw(playerid, Float:Xpos, Float:Ypos, header_text[])
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, header_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 1.25, 3.0);
	PlayerTextDrawFont(playerid, txtInit, 0);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

PlayerText:CreatePlayerBackgroundTextDraw(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height)
{
	new PlayerText:txtBackground = CreatePlayerTextDraw(playerid, Xpos, Ypos,
	"                                            ~n~");
    PlayerTextDrawUseBox(playerid, txtBackground, 1);
    PlayerTextDrawBoxColor(playerid, txtBackground, 0x00000099);
	PlayerTextDrawLetterSize(playerid, txtBackground, 5.0, 5.0);
	PlayerTextDrawFont(playerid, txtBackground, 0);
	PlayerTextDrawSetShadow(playerid, txtBackground, 0);
    PlayerTextDrawSetOutline(playerid, txtBackground, 0);
    PlayerTextDrawColor(playerid, txtBackground,0x000000FF);
    PlayerTextDrawTextSize(playerid, txtBackground, Width, Height);
   	PlayerTextDrawBackgroundColor(playerid, txtBackground, 0x00000099);
    PlayerTextDrawShow(playerid, txtBackground);
    return txtBackground;
}

PlayerText:CreateModelPreviewTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:width, Float:height)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, "");
    PlayerTextDrawFont(playerid, txtPlayerSprite, TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, 0x000000EE);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, width, height);
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
    PlayerTextDrawSetPreviewRot(playerid,txtPlayerSprite, -16.0, 0.0, -55.0);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, 1);
    PlayerTextDrawShow(playerid,txtPlayerSprite);
    return txtPlayerSprite;
}

DestroyPlayerModelPreviews(playerid)
{
	new x=0;
	while(x != SELECTION_ITEMS) {
	    if(gSelectionItems[playerid][x] != PlayerText:INVALID_TEXT_DRAW) {
			PlayerTextDrawDestroy(playerid, gSelectionItems[playerid][x]);
			gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
		}
		x++;
	}
}

ShowPlayerModelPreviews(playerid)
{
    new x=0;
	new Float:BaseX = DIALOG_BASE_X;
	new Float:BaseY = DIALOG_BASE_Y - (SPRITE_DIM_Y * 0.33);
	new linetracker = 0;
	new itemat = GetPVarInt(playerid, "vspawner_page") * SELECTION_ITEMS;
	DestroyPlayerModelPreviews(playerid);
	while(x != SELECTION_ITEMS && itemat < gTotalItems) {
	    if(linetracker == 0) {
	        BaseX = DIALOG_BASE_X + 25.0;
	        BaseY += SPRITE_DIM_Y + 1.0;
		}
  		gSelectionItems[playerid][x] = CreateModelPreviewTextDraw(playerid, gItemListTwo[itemat], BaseX, BaseY, SPRITE_DIM_X, SPRITE_DIM_Y);
  		gSelectionItemsTag[playerid][x] = gItemListTwo[itemat];
		BaseX += SPRITE_DIM_X + 1.0;
		linetracker++;
		if(linetracker == ITEMS_PER_LINE) linetracker = 0;
		itemat++;
		x++;
	}
}

UpdatePageTextDraw(playerid)
{
	new PageText[64+1];
	format(PageText, 64, "%d/%d", GetPVarInt(playerid,"vspawner_page") + 1, GetNumberOfPages());
	PlayerTextDrawSetString(playerid, gCurrentPageTextDrawId[playerid], PageText);
}
CreateSelectionMenu(playerid)
{
    gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y + 20.0, DIALOG_WIDTH, DIALOG_HEIGHT);
    gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, HEADER_TEXT);
    gCurrentPageTextDrawId[playerid] = CreateCurrentPageTextDraw(playerid, DIALOG_WIDTH - 30.0, DIALOG_BASE_Y + 15.0);
    gNextButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 30.0, DIALOG_BASE_Y+DIALOG_HEIGHT+100.0, 50.0, 16.0, NEXT_TEXT);
    gPrevButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 90.0, DIALOG_BASE_Y+DIALOG_HEIGHT+100.0, 50.0, 16.0, PREV_TEXT);
    ShowPlayerModelPreviews(playerid);
    UpdatePageTextDraw(playerid);
}

DestroySelectionMenu(playerid)
{
	DestroyPlayerModelPreviews(playerid);
	PlayerTextDrawDestroy(playerid, gHeaderTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gBackgroundTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gCurrentPageTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gNextButtonTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gPrevButtonTextDrawId[playerid]);
	gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
}
HandlePlayerItemSelection(playerid, selecteditem)  SpawnVehicle_InfrontOfPlayer(playerid, gSelectionItemsTag[playerid][selecteditem], -1, -1);
public OnPlayerModelSelection(playerid, response, listid, modelid)
{
    if(listid == menu1)
    {
        if(response)
        {
			if(GetPVarInt(playerid,"givegun") == 1)
			{
				SetPVarInt(playerid,"modelid",modelid);
				SPD(playerid,DIALOG_GIVEGUN,DIALOG_STYLE_INPUT,""PREFIX" ����� ������",""WHT"������� ID ������, �������� ������ �������� ������","�����","������");
			}
        }
        return true;
    }
    return true;
}
Err(playerid, const msg[])
{
	new string[128];
	format(string,sizeof(string),"{F31212}[������]{FFFFFF} %s!",msg);
	SendClientMessage(playerid,-1,string);
	return true;
}
ShowLogin(playerid)
{
	new dialog[512];
	format(dialog, sizeof(dialog),
	""YE"����� ����������, {8C60C3}%s\n\
	{6495ED}\n\
	"YE"�� ����� �� ������ {FF0000}Alpino RPG\n\
	"YE" ������� ��� �������: {00BFFF}"GameMode"\n\
	"YE" ������ �������: {00BFFF}SAMP 0.3x\n\
	"YE" ����� �������: {8C60C3}www.alpino-rpg.ru\n\
	{6495ED}\n\
	"YE"������� ��� {006400}��������������� "YE"�� �������.\n\
	{6495ED}\n\
	"YE"����� ������ � ����� ''�����''", PlayerInfo[playerid][pName]);
	SPD(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, ""PREFIX" �����������.", dialog, "�����", "������");
	return true;
}
ShowRegister(playerid)
{
	new dialog[512];
	format(dialog, sizeof(dialog),""YE"����� ����������, {8C60C3}%s\n\
	{6495ED}\n\
	"YE" �� ����� �� ������ {FF0000}Alpino RPG\n\
	"YE" ������� ��� �������: {00BFFF}"GameMode"\n\
	"YE" ������ �������: {00BFFF}SAMP 0.3x\n\
	"YE" ����� �������: {8C60C3}www.alpino-rpg.ru\n\
	{6495ED}\n\
	"YE"������� ��� {FF0000}�� ��������������� "YE"�� �������.\n\
	{6495ED}\n\
	"YE"�������� ������ � ����� \"�����\"", PlayerInfo[playerid][pName]);
	SPD(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, ""PREFIX" �����������.", dialog, "�����", "������");
	return true;
}
EmptyMessages(playerid,count)
{
	for(new i = 0; i < count; i++)
	{
		SendClientMessage(playerid, 0, "\n");
	}
	return true;
}
ClearChat(count)
{
	for(new i; i < count; i++) {
		SendClientMessageToAll(0, "\n");
	}
	return true;
}	
SendLeadersMessage(color, string[]) {
	foreach(new i: Player) {
		if(PlayerInfo[i][pLeader] > 0) SendClientMessage(i, color, string);
	}
	return true;
}
NameAdmin(playerid){
	new admrank[32];
	if(PlayerInfo[playerid][pAdmin] > 0) {
		switch(PlayerInfo[playerid][pAdmin]) { 
		case 1..3: admrank = "���������";
		case 4: admrank = "��. ���������";
		case 5: admrank = "�������������";
		case 6: admrank = "��. �������������"; }
	}
	else if(PlayerInfo[playerid][pHelper] > 0)  {
		switch(PlayerInfo[playerid][pHelper]) { 
		case 1: admrank = "������ 1 ��.";
		case 2: admrank = "������ 2 ��.";
		}
	}	
	return admrank;
}
ShowAPanel(playerid) return SPD(playerid,DIALOG_APANEL,DIALOG_STYLE_LIST,""PREFIX" ������ ��������������","[1] ����������� ������ �������������\n[2] ������� ������\n[3] ����������� ������ �������","�����","������");
stock StartSpectate(playerid, specid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
	{
		ShowMenuForPlayer(Admin,playerid);
		GetPlayerPos(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
		TeleportDestNoFloat[playerid][0] = GetPlayerInterior(playerid);
		TeleportDestNoFloat[playerid][1] = GetPlayerVirtualWorld(playerid);
	}
	foreach(new x : Player)
	{
		if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && gSpectateID[x] == playerid) AdvanceSpectate(x);
	}
	if(IsPlayerInAnyVehicle(specid))
	{
		SetPlayerInterior(playerid,GetPlayerInterior(specid));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(specid));
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specid));
		gSpectateID[playerid] = specid;
		gSpectateType[playerid] = ADMIN_SPEC_TYPE_VEHICLE;
	}
	else
	{
		SetPlayerInterior(playerid,GetPlayerInterior(specid));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(specid));
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectatePlayer(playerid, specid);
		gSpectateID[playerid] = specid;
		gSpectateType[playerid] = ADMIN_SPEC_TYPE_PLAYER;
	}
	SpecAd[playerid] = specid;
	SpecID[specid] = playerid;
	PlayerTextDrawShow(playerid, FULLRECON[playerid]);
	return true;
}
stock StopSpectate(playerid)
{
	TogglePlayerSpectating(playerid, 0);
	gSpectateID[playerid] = INVALID_PLAYER_ID;
	gSpectateType[playerid] = ADMIN_SPEC_TYPE_NONE;
	PlayerTextDrawHide(playerid, FULLRECON[playerid]);
	GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~w~Recon Stop",1000,3);
	SetPVarInt(playerid, "TeleportTimer", gettime()+1);
	HideMenuForPlayer(Admin,playerid);
	return true;
}
stock AdvanceSpectate(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && gSpectateID[playerid] != INVALID_PLAYER_ID)
	{
		for(new x = gSpectateID[playerid]+1; x <= GetMaxPlayers(); x++)
		{
			if(x == MAX_PLAYERS) x = 0;
			if(IsPlayerConnected(x) && x != playerid)
			{
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && gSpectateID[x] != INVALID_PLAYER_ID ||
						(GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3)) continue;
			 	else { StartSpectate(playerid, x); break; }
			}
		}
	}
	return true;
}
stock ReverseSpectate(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && gSpectateID[playerid] != INVALID_PLAYER_ID)
	{
		for(new x=gSpectateID[playerid]-1; x>=0; x--)
		{
			if(x == 0) x = GetMaxPlayers();
			if(IsPlayerConnected(x) && x != playerid)
			{
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && gSpectateID[x] != INVALID_PLAYER_ID ||
						(GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3)) continue;
				else { StartSpectate(playerid, x); break; }
			}
		}
	}
	return true;
}
stock TeleportTimer(playerid)
{
	SetPlayerPos(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
	SetPlayerInterior(playerid, TeleportDestNoFloat[playerid][0]);
	SetPlayerVirtualWorld(playerid, TeleportDestNoFloat[playerid][1]);
	return true;
}
forward SpisokRent(playerid);
public SpisokRent(playerid)
{
    new showrent[512];
	new name[21], line[30];
	for(new i; i<mysql_num_rows(); i++)
	{
		if(mysql_fetch_row_format(name))
		{
			format(line, sizeof(line), "{FFFFFF}%s\n", name);
			strcat(showrent, line);
		}
		SPD(playerid, 999, DIALOG_STYLE_LIST, ""PREFIX" ������,���������� ��� ���", showrent, "�������", "�������");
	}
	return true;
}
public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(response == 0)
	{
		DeletePVar(playerid, "bankomat");
		return true;
	}
	if(response == 1)
	{
		new i = GetPVarInt(playerid, "bankomat");
		new query[255];
		format(query,sizeof(query),"INSERT INTO `Bankomats` (ID, x, y, z, rX, rY, rZ) VALUES ('%i',%f,'%f','%f','%f','%f','%f')",i,x,y,z,rx,ry,rz);
		mysql_query(query);
		DestroyDynamicObject(Bankomat[i][bObject]);
		Bankomat[i][bObject] = CreateDynamicObject(2754, x, y, z, rx, ry, rz, -1, -1, -1, 30.0);
		DeletePVar(playerid, "bankomat");
		return true;
	}
	return true;
}
forward KickPublic(playerid);
public KickPublic(playerid) Kick(playerid);

stock ALKick(playerid) return SetTimerEx("KickPublic", 1000, 0, "d", playerid);

AddRace(i, laps, max, Float:x, Float:y, Float:z)
{
	Race[i][ID] = i;
	Race[i][Laps] = laps;
	Race[i][ID] = i;
	Race[i][Max] = max;
	Race[i][RegX] = x;
	Race[i][RegY] = y;
	Race[i][RegZ] = z;
	Race[i][TimerP] = false;
	strmid(Race[i][Who1], "-", 0, 64, 64);
	strmid(Race[i][Who2], "-", 0, 64, 64);
	strmid(Race[i][Who3], "-", 0, 64, 64);
	strmid(Race[i][Who4], "-", 0, 64, 64);
	strmid(Race[i][Who5], "-", 0, 64, 64);
	new string[100];
	format(string, sizeof(string), "����������� �� ����� � %d", i);
	CreatePickupWithText(1239, 1, 0xFFFFFFFF, x, y, z, string, 0, 1);
	return true;
}
forward RaceTimer(i);
public RaceTimer(i) {

	if(Race[i][CountM] > 1) { Race_Start(i); }
	else {
		new id = ReturnUser(Race[i][Who1]);
		DeletePVar(id, "race");
		UnFreeze(id);
		SendClientMessage(id, -1, ""YE"������������ ���������� ��� ������ �����. ����� ��������!");
	}
	Race[i][Reg] = false;
	Race[i][TimerP] = false;
	Race[i][CountM] = 0;
	Race[i][Max] = 0;
	return true;
}
stock CreateStrip(Float:x,Float:y,Float:z,Float:Angle)
{
    for(new i = 0; i < sizeof(SpikeInfo); i++)
  	{
  	    if(SpikeInfo[i][sCreated] == 0)
  	    {
            SpikeInfo[i][sCreated]=1;
            SpikeInfo[i][sX]=x;
            SpikeInfo[i][sY]=y;
            SpikeInfo[i][sZ]=z-0.7;
            SpikeInfo[i][sObject] = CreateObject(2899, x, y, z-0.9, 0, 0, Angle-90);
	        return 1;
  	    }
  	}
  	return 0;
}

stock DeleteAllStrip()
{
    for(new i = 0; i < sizeof(SpikeInfo); i++)
  	{
  	    if(SpikeInfo[i][sCreated] == 1)
  	    {
  	        SpikeInfo[i][sCreated]=0;
            SpikeInfo[i][sX]=0.0;
            SpikeInfo[i][sY]=0.0;
            SpikeInfo[i][sZ]=0.0;
            DestroyObject(SpikeInfo[i][sObject]);
  	    }
	}
    return 0;
}

stock DeleteClosestStrip(playerid)
{
    for(new i = 0; i < sizeof(SpikeInfo); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 2.0, SpikeInfo[i][sX], SpikeInfo[i][sY], SpikeInfo[i][sZ]))
        {
  	        if(SpikeInfo[i][sCreated] == 1)
            {
                SpikeInfo[i][sCreated]=0;
                SpikeInfo[i][sX]=0.0;
                SpikeInfo[i][sY]=0.0;
                SpikeInfo[i][sZ]=0.0;
                DestroyObject(SpikeInfo[i][sObject]);
                return 1;
  	        }
  	    }
  	}
    return 0;
}

encode_tires(tires1, tires2, tires3, tires4) {

	return tires1 | (tires2 << 1) | (tires3 << 2) | (tires4 << 3);
}
Race_AddStart(id, pos, Float:x, Float:y, Float:z, Float: za) {
	switch(pos) {
		case 1:
		{
			Race[id][PosStart1][0] = x;
			Race[id][PosStart1][1] = y;
			Race[id][PosStart1][2] = z;
			Race[id][Angle1] = za;
		}
		case 2:
		{
			Race[id][PosStart2][0] = x;
			Race[id][PosStart2][1] = y;
			Race[id][PosStart2][2] = z;
			Race[id][Angle2] = za;
		}
		case 3:
		{
			Race[id][PosStart3][0] = x;
			Race[id][PosStart3][1] = y;
			Race[id][PosStart3][2] = z;
			Race[id][Angle3] = za;
		}
		case 4:
		{
			Race[id][PosStart4][0] = x;
			Race[id][PosStart4][1] = y;
			Race[id][PosStart4][2] = z;
			Race[id][Angle4] = za;
		}
		case 5:
		{
			Race[id][PosStart5][0] = x;
			Race[id][PosStart5][1] = y;
			Race[id][PosStart5][2] = z;
			Race[id][Angle5] = za;
		}
	}
	return true;
}
Race_AddCheckpoint(id, pos, Float:x, Float:y, Float:z) {
	switch(pos) {
		case 1:
		{
			Race[id][Check1][0] = x;
			Race[id][Check1][1] = y;
			Race[id][Check1][2] = z;
		}
		case 2:
		{
			Race[id][Check2][0] = x;
			Race[id][Check2][1] = y;
			Race[id][Check2][2] = z;
		}
		case 3:
		{
			Race[id][Check3][0] = x;
			Race[id][Check3][1] = y;
			Race[id][Check3][2] = z;
		}
		case 4:
		{
			Race[id][Check4][0] = x;
			Race[id][Check4][1] = y;
			Race[id][Check4][2] = z;
		}
		case 5:
		{
			Race[id][Check5][0] = x;
			Race[id][Check5][1] = y;
			Race[id][Check5][2] = z;
		}
	}
	return true;
}
Race_Start(i) {
	foreach(new playerid: Player) {
		if(GetPVarInt(playerid, "race") == i) {
			UnFreeze(playerid);
			SendClientMessage(playerid, -1, ""YE"�������!");
			racecheck[playerid] = CreateDynamicRaceCP(0, Race[i][Check1][0], Race[i][Check1][1], Race[i][Check1][2], Race[i][Check2][0], Race[i][Check2][1], Race[i][Check2][2], 5.0, -1, -1, playerid, 500.0);
			SetPVarInt(playerid, "racenext", 1);
			Race[i][Start] = true;
		}
	}
	return true;
}
Race_PlayerJoin(playerid, i) {
	switch(Race[i][CountM])
	{
		case 0: vehcar[playerid] = CreateVehicle(411, Race[i][PosStart1][0], Race[i][PosStart1][1], Race[i][PosStart1][2], Race[i][Angle1], -1, -1, -1);
		case 1: vehcar[playerid] = CreateVehicle(411, Race[i][PosStart2][0], Race[i][PosStart2][1], Race[i][PosStart2][2], Race[i][Angle2], -1, -1, -1);
		case 2: vehcar[playerid] = CreateVehicle(411, Race[i][PosStart3][0], Race[i][PosStart3][1], Race[i][PosStart3][2], Race[i][Angle3], -1, -1, -1);
		case 3: vehcar[playerid] = CreateVehicle(411, Race[i][PosStart4][0], Race[i][PosStart4][1], Race[i][PosStart4][2], Race[i][Angle4], -1, -1, -1);
		case 4: vehcar[playerid] = CreateVehicle(411, Race[i][PosStart5][0], Race[i][PosStart5][1], Race[i][PosStart5][2], Race[i][Angle5], -1, -1, -1);
	}
	SetVehicleParamsEx(vehcar[playerid],true,false,false,false,false,false,false);
	VehHealth[vehcar[playerid]] = 1000.0;
	incar[playerid] = true;
	PutPlayerInVehicle(playerid, vehcar[playerid], 0);
	Freeze(playerid);
	SendClientMessage(playerid, -1, ""YE"�� ������� ������������������ �� �����. �������� ������ ����������, ���� ������ �� ������.");
	SetPlayerVirtualWorld(playerid, i);
	SetVehicleVirtualWorld(vehcar[playerid], i);
	return true;
}
public OnPlayerEnterDynamicRaceCP(playerid, checkpointid)
{
	if(GetPVarInt(playerid, "race") > 0 && checkpointid == racecheck[playerid]) {
	    new i = GetPVarInt(playerid, "race");
		switch(GetPVarInt(playerid, "racenext")) {
			case 1:
			{
				DestroyDynamicRaceCP(racecheck[playerid]);
				racecheck[playerid] = CreateDynamicRaceCP(0, Race[i][Check2][0], Race[i][Check2][1], Race[i][Check2][2], Race[i][Check3][0], Race[i][Check3][1], Race[i][Check3][2], 5.0, -1, -1, playerid, 1500.0);
				SetPVarInt(playerid, "racenext", 2);
			}
			case 2:
			{
				DestroyDynamicRaceCP(racecheck[playerid]);
				racecheck[playerid] = CreateDynamicRaceCP(0, Race[i][Check3][0], Race[i][Check3][1], Race[i][Check3][2], Race[i][Check4][0], Race[i][Check4][1], Race[i][Check4][2], 5.0, -1, -1, playerid, 1500.0);
				SetPVarInt(playerid, "racenext", 3);
			}
			case 3:
			{
				DestroyDynamicRaceCP(racecheck[playerid]);
				racecheck[playerid] = CreateDynamicRaceCP(1, Race[i][Check4][0], Race[i][Check4][1], Race[i][Check4][2], Race[i][Check5][0], Race[i][Check5][1], Race[i][Check5][2], 5.0, -1, -1, playerid, 1500.0);
				SetPVarInt(playerid, "racenext", 4);
			}
			case 4:
			{
				DestroyDynamicRaceCP(racecheck[playerid]);
				DeletePVar(playerid, "racenext");
				Race[GetPVarInt(playerid, "race")][Finished] ++;
				CallLocalFunction("OnPlayerFinishRace", "ddd", playerid, GetPVarInt(playerid, "race"), Race[GetPVarInt(playerid, "race")][Finished]);
			}
		}
	}
}
forward OnPlayerFinishRace(playerid, race, position);
public OnPlayerFinishRace(playerid, race, position) {
	new string[128];
	format(string, sizeof(string), ""YE"����� %s[%d] ����������� � ����� �� %d �����.", PlayerInfo[playerid][pName], playerid, position);
	SendClientMessageToAll(-1, string);
	if(position == 1) { SetMoney(playerid, 5000); }
	if(position == Race[race][CountM])
	{
		Race[race][Finished] = 0;
		Race[race][CountM] = 0;
		strmid(Race[race][Who1], "-", 0, 64, 64);
		strmid(Race[race][Who2], "-", 0, 64, 64);
		strmid(Race[race][Who3], "-", 0, 64, 64);
		strmid(Race[race][Who4], "-", 0, 64, 64);
		strmid(Race[race][Who5], "-", 0, 64, 64);
	}
	DeletePVar(playerid, "race");
	SetPlayerVirtualWorld(playerid, 0);
	return true;
}

stock SetMoney(playerid, summa)   
{  
	PlayerInfo[playerid][pMoney] += summa;  
	GivePlayerMoney(playerid,summa);  
	return true; 
}
stock GetMoney(playerid) 
{ 
    return PlayerInfo[playerid][pMoney];
}
GetLeader(f) {
	foreach(new i: Player) {
		if(PlayerInfo[i][pLeader] > 0 && PlayerInfo[i][pLeader] == f) return i;
	}
	return true;
}
LoadSys() {
	print("Doma"); LoadHouse();
	print("Auto"); LoadFractionAuto();
	print("Frac"); LoadFractions();
	print("Object"); AlpinoObject();
	print("Bank"); LoadBankomats();
	print("KFC"); LoadKFC();
	print("Gas"); LoadGas();
	print("Job"); LoadJob();
	print("GZ"); LoadGangZones();
	print("Ammo");LoadAmmo();
	print("Magaz"); LoadMagazin();
	print("Club"); LoadClub();
	print("Infa"); LoadInfa();
	print("Street"); LoadStreet();
	print("MapIcon"); LoadMapIcon();
}
CreateSpec() {
	Admin = CreateMenu("Spec", 1, 50.0, 170.0, 70.0);
	AddMenuItem(Admin,0,"Update");
	AddMenuItem(Admin,0,"Kick");
	AddMenuItem(Admin,0,"Warn");
	AddMenuItem(Admin,0,"Ban");
	AddMenuItem(Admin,0,"Slap");
	AddMenuItem(Admin,0,"Stats");
	AddMenuItem(Admin,0,"GetIP");
	AddMenuItem(Admin,0,"GMTest");
	AddMenuItem(Admin,0,"OFF");
}
CreateRace() {
	//����� 1
	AddRace(1, 1, 4,1329.1636,-984.6364,33.8966);
	Race_AddStart(Race[1][ID], 1, 1365.9758,-936.8090,33.9146,82.8741);
	Race_AddStart(Race[1][ID], 2, 1365.3398,-941.7043,33.9181,82.0830);
	Race_AddStart(Race[1][ID], 3, 1366.6702,-931.1741,33.9146,83.1594);
	Race_AddStart(Race[1][ID], 4, 1364.4719,-946.9198,33.9147,81.6366);
	Race_AddCheckpoint(Race[1][ID], 1, 1160.7595,-942.0363,42.6505);
	Race_AddCheckpoint(Race[1][ID], 2, 1224.1605,-258.2722,21.5000);
	Race_AddCheckpoint(Race[1][ID], 3, 312.4660,-142.4873,1.1528);
	Race_AddCheckpoint(Race[1][ID], 4, -87.0491,-425.8035,0.8052);
	//����� 2
	AddRace(2, 1, 4,1547.9402,29.9336,24.1406);
	Race_AddStart(Race[2][ID], 1, 1561.8755,17.6550,23.8888,187.5347);
	Race_AddStart(Race[2][ID], 2, 1558.2657,16.9249,23.8869,187.2061);
	Race_AddStart(Race[2][ID], 3, 1560.7070,28.4277,23.8921,186.0663);
	Race_AddStart(Race[2][ID], 4, 1557.1478,28.1180,23.8875,186.1894);
	Race_AddCheckpoint(Race[2][ID], 1, 1479.3898,-205.4794,10.7943);
	Race_AddCheckpoint(Race[2][ID], 2, 1220.9553,-112.9419,39.4639);
	Race_AddCheckpoint(Race[2][ID], 3, 727.2237,-174.0580,20.410);
	Race_AddCheckpoint(Race[2][ID], 4, 329.2592,-349.0236,8.4929);
}
CreateServerVehicle() {
	ash[0] = AddStaticVehicleEx(426,-2064.1921,-85.8184,34.9074,181.0570,1,1,60);
	AddStaticVehicleEx(426,-2068.4802,-85.8244,34.9071,179.6030,1,1,60);
	AddStaticVehicleEx(426,-2073.0254,-85.7858,34.9071,181.8192,1,1,60);
	AddStaticVehicleEx(426,-2077.0745,-85.7615,34.9072,179.1434,1,1,60);
	AddStaticVehicleEx(426,-2081.1614,-85.7225,34.9071,180.0138,1,1,60);
	AddStaticVehicleEx(426,-2085.6448,-85.7239,34.9077,180.1240,1,1,60);
	AddStaticVehicleEx(426,-2089.9705,-85.3449,34.9073,178.8035,1,1,60);
	ash[1] = AddStaticVehicleEx(426,-2093.7817,-85.1219,34.9072,179.4971,1,1,60);
	furaveh[0] = AddStaticVehicleEx(403,-60.5170,-324.8535,5.1568,269.8296,-1,-1,60);
	furaveh[1] = AddStaticVehicleEx(403,-60.7894,-321.6061,5.1577,272.8763,-1,-1,60);
	furaveh[2] = AddStaticVehicleEx(403,-61.1188,-317.5776,5.1568,269.2173,-1,-1,60);
	furaveh[3] = AddStaticVehicleEx(403,-61.3487,-314.3298,5.1568,271.8818,-1,-1,60);
	furaveh[4] = AddStaticVehicleEx(403,-61.6411,-310.8019,5.1568,272.2173,-1,-1,60);
	furaveh[5] = AddStaticVehicleEx(403,-61.8494,-307.2750,5.1568,271.2632,-1,-1,60);
	furaveh[6] = AddStaticVehicleEx(403,-62.0703,-303.5495,5.1568,269.5414,-1,-1,60);
	furaveh[7] = AddStaticVehicleEx(403,-62.2423,-300.7386,5.1568,269.7658,-1,-1,60);
	taxi[1] = AddStaticVehicleEx(420,1260.8846,-1795.3641,13.2001,177.1997,6,1,60);
	taxi[2] = AddStaticVehicleEx(420,1265.3555,-1795.3115,13.1926,176.8528,6,1,60);
	taxi[3] = AddStaticVehicleEx(420,1270.2955,-1795.4537,13.1833,179.9120,6,1,60);
	taxi[4] = AddStaticVehicleEx(420,1277.6000,-1795.5828,13.1780,181.4768,6,1,60);
	taxi[5] = AddStaticVehicleEx(420,1280.8461,-1804.9950,13.1644,88.4178,6,1,60);
	taxi[6] = AddStaticVehicleEx(420,1280.3611,-1816.1099,13.1490,90.3171,6,1,60);
	combinecar[0] = AddStaticVehicleEx(532,-1068.4801,-1246.7335,130.1877,270.6407,0,0,60);
	combinecar[1] = AddStaticVehicleEx(532,-1068.6962,-1231.2468,130.1963,270.2367,0,0,60);
	combinecar[2] = AddStaticVehicleEx(532,-1037.4037,-1230.4830,130.3231,96.7412,0,0,60);
	combinecar[3] = AddStaticVehicleEx(532,-1036.9929,-1245.1169,130.3434,91.8730,0,0,60);
	for(new i = 1; i < MAX_VEHICLES; i++) ManualCar(i);
	ManualVehicleEngineAndLights();
}
CreatePickupText() {
	CreatePickupWithText(1239,1,0xFFFFFFFF,1139.4038,-609.3389,1089.9359,"����������� ALT, ����� ������ ���� �� ����� �� �����",0,1);
	CreatePickupWithText(19132,1,0xFFFFFFFF,1555.5018,-1675.6222,16.1953,"����������� �������",0,1);
	CreatePickupWithText(19132,1,0xFFFFFFFF,-2031.2075,-96.7104,35.1641,"���������",0,1);
	CreatePickupWithText(19132,1,0xFFFFFFFF,2315.5581,0.3544,26.7422,"���������",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,-2022.3580,-116.6251,1035.1719,"������� ��������",1,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,1697.1306,916.5074,10.8153,"������� �������",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,-2947.5974,504.1858,2.4297,"������� �������",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,-1741.6755,1428.6117,7.1875,"������� �����",0,1);
	CreatePickupWithText(19132,1,0xFFFFFFFF,1461.7260,-1010.2776,26.8438,"���� ��",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,2127.5352,2379.9233,10.8203,"���� � ������� {761772}���������{FFFFFF}",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,2495.3701,-1691.1401,14.7656,"���� � ������� {35B415}The Groove Street Family{FFFFFF}",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,2000.0444,-1114.0533,27.1250,"���� � ������� {650C6D}The Ballas Gang{FFFFFF}",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,2807.9980,-1190.8875,25.3432,"���� � ������� {B7D424}Los Santos Vagos{FFFFFF}",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,937.2737,1734.0522,8.8516,"���� � ������� {464645}Russian Mafia{FFFFFF}",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,1752.4961,-1911.9286,13.5674,"���� � ������� {12B0BB}El Coronos{FFFFFF}",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,-2717.9114,-317.6669,7.8438,"���� � ������� {AEB21D}Yakuza{FFFFFF}",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,-2226.9026,251.8453,35.3203,"���� � ������� {115D7D}La Cosa Nostra{FFFFFF}",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,2633.7690,1716.6880,11.0234,"���� � ������� {BB1CAC}The Triads Mafia{FFFFFF}",0,1);
	CreatePickupWithText(1313,1,0xFFFFFFFF,2296.9646,2474.0974,3.2734,"����� ������ {0F286F}FBI{FFFFFF}",0,1);
	CreatePickupWithText(1313,1,0xFFFFFFFF,1529.8735,-1688.2972,5.8906,"����� ������ {1A40A7}SAPD{FFFFFF}",0,1);
	CreatePickupWithText(1313,1,0xFFFFFFFF,-1331.5231,449.3008,7.1875,"����� ������ {12590D}National Guard{FFFFFF}",0,1);
	CreatePickupWithText(19132,1,0xFFFFFFFF,461.5806,-1500.8630,31.0483,"������� ������",0,1);
	CreatePickupWithText(1242,1,0xFFFFFFFF,241.5848,112.8704,1003.2188,"���������� {0F286F}FBI{FFFFFF}",0,1);
	CreatePickupWithText(1242,1,0xFFFFFFFF,1560.0128,-1692.6910,5.8906,"���������� {1A40A7}SAPD{FFFFFF}",0,1);
	CreatePickupWithText(1242,1,0xFFFFFFFF,-1339.0009,489.6227,11.1953,"���������� {12590D}National Guard{FFFFFF}",0,1);
	CreatePickupWithText(19132,1,0xFFFFFFFF,2229.8406,-1721.1965,13.5606,"�������� LS",0,1);
	CreatePickupWithText(19132,1,0xFFFFFFFF,1968.8245,2295.8728,16.4559,"�������� LV",0,1);
	CreatePickupWithText(19132,1,0xFFFFFFFF,-2270.6475,-155.8572,35.3203,"�������� SF",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,758.7222,-59.9124,1000.7802,"����� ����� ���",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,756.4216,6.1888,1000.6993,"����� ����� ���",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,754.6369,-25.9861,1000.5859,"����� ����� ���",0,1);
	CreatePickupWithText(1239,1,0xFFFFFFFF,251.8308,117.3878,1003.2188,"����� ����������",0,1);
	CreatePickup(1239,1,-1907.1802,-1671.1370,23.0156,-1);
	CreatePickup(19132, 1, 1461.7260,-1010.2776,26.8438, -1);
	CreatePickup(19132, 1, 2145.7627,1597.4769,1003.9677, -1);
	Create3DTextLabel("����� ������ {00FF00}�1\n{C1C1C1}��� ������ ������ ��������� � ������",0xFFFFFFFF,-1854.7035,-1650.9668,25.7248,30,0,1);
	Create3DTextLabel("����� ������ {00FF00}�2\n{C1C1C1}��� ������ ������ ��������� � ������",0xFFFFFFFF,-1803.5344,-1655.2640,25.8294,30,0,1);
	Create3DTextLabel("����� ������ {00FF00}�3\n{C1C1C1}��� ������ ������ ��������� � ������",0xFFFFFFFF,-1788.5780,-1640.7179,27.0669,30,0,1);
	Create3DTextLabel("����� ������ {00FF00}�4\n{C1C1C1}��� ������ ������ ��������� � ������",0xFFFFFFFF,-1869.1316,-1634.7915,-58.500,30,0,1);
	Create3DTextLabel("����� ������ {00FF00}�5\n{C1C1C1}��� ������ ������ ��������� � ������",0xFFFFFFFF,-1868.9603,-1643.6682,-58.046,30,0,1);
	for(new i = 0; i < sizeof(BankInfo); i++)  CreatePickupWithText(1239,1,0xFFFFFFFF,BankInfo[i][BankX],BankInfo[i][BankY],BankInfo[i][BankZ],BankInfo[i][BankName],0,1);
}
ShowBankomat(playerid) {
	new string[255];
	format(string, sizeof(string),"{3CBBF7}[1]{ffffff}\t������: "GRN"%d$"WHT"\n{3CBBF7}[2]{ffffff}\t����� ������\n{3CBBF7}[3]{ffffff}\t��������� ������\n{3CBBF7}[4]{ffffff}\t���������",PlayerInfo[playerid][pBank]);
	SPD(playerid,DIALOG_BANK,DIALOG_STYLE_LIST,""PREFIX" ��������",string,"�����","������");
	return true;
}
SetModel(q, w, e, r, t, y, u, i, o, p) {
    TextDrawSetPreviewModel(textdraw1[1], q);
    TextDrawSetPreviewModel(textdraw1[2], w);
    TextDrawSetPreviewModel(textdraw1[3], e);
    TextDrawSetPreviewModel(textdraw1[4], r);
    TextDrawSetPreviewModel(textdraw1[5], t);
    TextDrawSetPreviewModel(textdraw1[6], y);
    TextDrawSetPreviewModel(textdraw1[7], u);
    TextDrawSetPreviewModel(textdraw1[8], i);
    TextDrawSetPreviewModel(textdraw1[9], o);
    TextDrawSetPreviewModel(textdraw1[10], p);
}
CreateTextDrawsForSkin() {
	textdraw1[0] = TextDrawCreate(517.000000, 120.399925, "_");
    TextDrawLetterSize(textdraw1[0], 0.000000, 20.379625);
    TextDrawTextSize(textdraw1[0], 121.000000, 0.000000);
    TextDrawAlignment(textdraw1[0], 1);
    TextDrawColor(textdraw1[0], 0);
    TextDrawUseBox(textdraw1[0], true);
    TextDrawBoxColor(textdraw1[0], 0x4A5A6BBB);
    TextDrawSetShadow(textdraw1[0], 0);
    TextDrawSetOutline(textdraw1[0], 0);
    TextDrawFont(textdraw1[0], 0);

    textdraw1[1] = TextDrawCreate(281.000000, 118.533126, "_");
    TextDrawFont(textdraw1[1], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawUseBox(textdraw1[1], true);
    TextDrawBoxColor(textdraw1[1], 0x88888899);
    TextDrawBackgroundColor(textdraw1[1], 0x88888899);
    TextDrawTextSize(textdraw1[1], 76.000000, 84.933326);
    TextDrawSetSelectable(textdraw1[1], true);

    textdraw1[2] = TextDrawCreate(281.000000, 204.399780, "_");
    TextDrawFont(textdraw1[2], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawUseBox(textdraw1[2], true);
    TextDrawBoxColor(textdraw1[2], 0x88888899);
    TextDrawBackgroundColor(textdraw1[2], 0x88888899);
    TextDrawTextSize(textdraw1[2], 76.000000, 84.933334);
    TextDrawSetSelectable(textdraw1[2], true);

    textdraw1[3] = TextDrawCreate(358.000000, 118.533264, "_");
    TextDrawFont(textdraw1[3], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawUseBox(textdraw1[3], true);
    TextDrawBoxColor(textdraw1[3], 0x88888899);
    TextDrawBackgroundColor(textdraw1[3], 0x88888899);
    TextDrawTextSize(textdraw1[3], 76.000000, 84.933319);
    TextDrawSetSelectable(textdraw1[3], true);

    textdraw1[4] = TextDrawCreate(358.000000, 204.399932, "_");
    TextDrawFont(textdraw1[4], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawUseBox(textdraw1[4], true);
    TextDrawBoxColor(textdraw1[4], 0x88888899);
    TextDrawBackgroundColor(textdraw1[4], 0x88888899);
    TextDrawTextSize(textdraw1[4], 76.000000, 84.933334);
    TextDrawSetSelectable(textdraw1[4], true);

    textdraw1[5] = TextDrawCreate(204.000000, 118.533401, "_");
    TextDrawFont(textdraw1[5], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawUseBox(textdraw1[5], true);
    TextDrawBoxColor(textdraw1[5], 0x88888899);
    TextDrawBackgroundColor(textdraw1[5], 0x88888899);
    TextDrawTextSize(textdraw1[5], 76.000000, 84.933334);
    TextDrawSetSelectable(textdraw1[5], true);

    textdraw1[6] = TextDrawCreate(204.000000, 203.466766, "_");
    TextDrawFont(textdraw1[6], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawUseBox(textdraw1[6], true);
    TextDrawBoxColor(textdraw1[6], 0x88888899);
    TextDrawBackgroundColor(textdraw1[6], 0x88888899);
    TextDrawTextSize(textdraw1[6], 76.000000, 84.933334);
    TextDrawSetSelectable(textdraw1[6], true);

    textdraw1[7] = TextDrawCreate(127.000000, 118.533157, "_");
    TextDrawFont(textdraw1[7], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawUseBox(textdraw1[7], true);
    TextDrawBoxColor(textdraw1[7], 0x88888899);
    TextDrawBackgroundColor(textdraw1[7], 0x88888899);
    TextDrawTextSize(textdraw1[7], 76.000000, 84.933326);
    TextDrawSetSelectable(textdraw1[7], true);

    textdraw1[8] = TextDrawCreate(127.000000, 204.400009, "_");
    TextDrawFont(textdraw1[8], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawUseBox(textdraw1[8], true);
    TextDrawBoxColor(textdraw1[8], 0x88888899);
    TextDrawBackgroundColor(textdraw1[8], 0x88888899);
    TextDrawTextSize(textdraw1[8], 76.000000, 84.933334);
    TextDrawSetSelectable(textdraw1[8], true);

    textdraw1[9] = TextDrawCreate(435.000000, 118.533050, "_");
    TextDrawFont(textdraw1[9], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawUseBox(textdraw1[9], true);
    TextDrawBoxColor(textdraw1[9], 0x88888899);
    TextDrawBackgroundColor(textdraw1[9], 0x88888899);
    TextDrawTextSize(textdraw1[9], 76.000000, 84.933334);
    TextDrawSetSelectable(textdraw1[9], true);

    textdraw1[10] = TextDrawCreate(435.000000, 204.399826, "_");
    TextDrawFont(textdraw1[10], TEXT_DRAW_FONT_MODEL_PREVIEW);
    TextDrawUseBox(textdraw1[10], true);
    TextDrawBoxColor(textdraw1[10], 0x88888899);
    TextDrawBackgroundColor(textdraw1[10], 0x88888899);
    TextDrawTextSize(textdraw1[10], 76.000000, 84.933334);
    TextDrawSetSelectable(textdraw1[10], true);

    textdraw1[11] = TextDrawCreate(178.000000, 292.133483, "Click on the icon to select");
    TextDrawLetterSize(textdraw1[11], 0.449999, 1.600000);
    TextDrawTextSize(textdraw1[11], 500.000000, 35.866767);
    TextDrawAlignment(textdraw1[11], 1);
    TextDrawColor(textdraw1[11], 16777215);
    TextDrawSetShadow(textdraw1[11], 0);
    TextDrawSetOutline(textdraw1[11], 1);
    TextDrawBackgroundColor(textdraw1[11], 51);
    TextDrawFont(textdraw1[11], 2);
    TextDrawSetProportional(textdraw1[11], 1);
    TextDrawSetSelectable(textdraw1[11], true); 
}
public OnPlayerClickTextDraw(playerid, Text:clickedid) {
	if(clickedid == textdraw1[1]) SetPlayerSkin(playerid, 1), PlayerInfo[playerid][pSkin] = 1;
	else if(clickedid == textdraw1[2]) SetPlayerSkin(playerid, 2), PlayerInfo[playerid][pSkin] = 2;
	else if(clickedid == textdraw1[3]) SetPlayerSkin(playerid, 3), PlayerInfo[playerid][pSkin] = 3;
	else if(clickedid == textdraw1[4]) SetPlayerSkin(playerid, 4), PlayerInfo[playerid][pSkin] = 4;
	else if(clickedid == textdraw1[5]) SetPlayerSkin(playerid, 5), PlayerInfo[playerid][pSkin] = 5;
	else if(clickedid == textdraw1[6]) SetPlayerSkin(playerid, 6), PlayerInfo[playerid][pSkin] = 6;
	else if(clickedid == textdraw1[7]) SetPlayerSkin(playerid, 7), PlayerInfo[playerid][pSkin] = 7;
	else if(clickedid == textdraw1[8]) SetPlayerSkin(playerid, 8), PlayerInfo[playerid][pSkin] = 8;
	else if(clickedid == textdraw1[9]) SetPlayerSkin(playerid, 9), PlayerInfo[playerid][pSkin] = 9;
	else if(clickedid == textdraw1[10]) SetPlayerSkin(playerid, 10), PlayerInfo[playerid][pSkin] = 10;
	else if(clickedid == textdraw1[11]) {
		for(new t; t != 12; t++) TextDrawHideForPlayer(playerid, textdraw1[t]);
		CancelSelectTextDraw(playerid);
	}
	for(new t; t != 12; t++) TextDrawHideForPlayer(playerid, textdraw1[t]);
	CancelSelectTextDraw(playerid);
    return 1;
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {
    if (hittype == BULLET_HIT_TYPE_VEHICLE) {
        new Float: petrolcapPos[3];
        GetVehicleModelInfo(GetVehicleModel(hitid), VEHICLE_MODEL_INFO_PETROLCAP, petrolcapPos[0], petrolcapPos[1], petrolcapPos[2]);
        petrolcapPos[0] = floatpower(floatsub(petrolcapPos[0], fX), 2.0);
        petrolcapPos[1] = floatpower(floatsub(petrolcapPos[1], fY), 2.0);
        petrolcapPos[2] = floatpower(floatsub(petrolcapPos[2], fZ), 2.0);
        if (floatcmp(0.05, floatsqroot(floatadd(floatadd(petrolcapPos[0], petrolcapPos[1]), petrolcapPos[2]))) >= 0) {
            SetVehicleHealth(hitid, 0.0);
        }   
    }
    return true;
}
SendZoneMessage(type, who) {
	new string[128], msg[62];
	foreach(Player, i) {
		if(nadm[i] == true) {
			switch(type) {
				case 2: msg = "��������� ������� ��������!";
				case 3: msg = "��������� ������� ��������!";
				case 4: msg = "������� ��������! ���������� ��� ������!";
				case 5: msg = "���������! ���-�� ������ ����� ��� ����������?!"; 
				case 6: msg = "- �������!";
				case 7: msg = "- GODLIKE!";
			}
			format(string, sizeof(string), ""PURP"%s[%d] %s", PlayerInfo[who][pName], who, msg);
			SendClientMessage(i, 0, string);
		}
	}
	return true;
}
ShowTime(playerid) {
	new string[190], ghour, gminute, gsecond; 
	gettime(ghour,gminute,gsecond);
	format(string, sizeof(string), ""WHT"�����: "YE"%d : %d : %d"WHT"\n���� ������� �����: "GRN"%d"WHT" / "LRED"60",ghour, gminute , gsecond, PlayerInfo[playerid][pGameTime]); 
	if(PlayerInfo[playerid][pJailTime] > 0) format(string, sizeof(string), "%s\n"WHT"�������� ������ � ������: "LRED"%s", string, nformat(PlayerInfo[playerid][pJailTime],"�������","�������","������")); 
	ShowPlayerDialog(playerid, DIALOG_TIMEUSE, DIALOG_STYLE_MSGBOX, ""PREFIX" �����", string, "�����", ""); 
	return true;
}
GoLotto(playerid) { 
    new string[128]; 
    new lottoin = random_ex(100, 999, 1), hour;
	gettime(hour);
    format(string, sizeof(string),"������ %s! �������� ���������� ��������. ���� ���������� �����: %d", hour, GetPVarInt(playerid, "lotto")); 
    SendClientMessage(playerid,0xffd200FF,string); 
    format(string, sizeof(string), "�� ���� ��� ���� ������� %s ���������� ����� ����� ����: {ff9a00}%d", nformat(lotto,"�����","������","�������"), lottoin); 
    SendClientMessage(playerid,0x63cb00ff,string); 
    lotto = 0; 
    if(GetPVarInt(playerid, "lotto") == lottoin) return SendClientMessage(playerid, 0x5AB200FF, "��� ����� � ������ ������ � ����������. �����������, ��� ������� 5.000$"), SetMoney(playerid, 5000); 
    SetPVarInt(playerid, "lotto", 0);
    return true;
} 