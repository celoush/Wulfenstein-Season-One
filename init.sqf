// starting
cutText["","BLACK IN",99999999];

// environment setup 
setViewDistance 1000;
setObjectViewDistance [1000,1000];
enableEnvironment false;

// mission functions init
#include "sqf\celo_savegame.sqf";
#include "sqf\celo_levels.sqf";
#include "sqf\celo_titles.sqf";
#include "sqf\celo_armor_loot_system.sqf";
#include "sqf\celo_debug.sqf";

// init enemies
level1_enemies = [e1_1,e1_2,e1_3,e1_4,e1_5,e1_6,e1_7,e1_8,e1_9,e1_10,e1_11,e1_12,e1_13,e1_14];
level2_enemies = [e2_1,e2_2,e2_3,e2_4,e2_5,e2_6,e2_7];
level3_enemies = [e3_1,e3_2,e3_3,e3_4,e3_5,e3_6,e3_7,e3_8,e3_9,e3_10,e3_11,e3_12,e3_13,e3_14,e3_15,e3_16,e3_17,e3_18,e3_19,e3_20];
level4_enemies = [e4_1,e4_2,e4_3,e4_4,e4_5,e4_6,e4_7,e4_8,e4_9,e4_10,e4_11,e4_12,e4_13,e4_14,e4_15,e4_16,e4_17,e4_18,e4_19,e4_20];
level5_enemies = [e5_1,e5_2,e5_3,e5_4,e5_5,e5_6,e5_7,e5_8,e5_9,e5_10];
level6_enemies = [e6_1,e6_2,e6_3,e6_4,e6_5,e6_6,e6_7,e6_8,e6_9,e6_10,e6_11,e6_12,e6_13,e6_14,e6_15,e6_16,e6_17,e6_18,e6_19,e6_20,e6_21,e6_22,e6_23,e6_24,e6_25,e6_26,e6_27,e6_28];
level7_enemies = [e7_1,e7_2,e7_3,e7_4,e7_5,e7_6,e7_7];
level8_enemies = [e8_1,e8_2,e8_3,e8_4,e8_5,e8_6,e8_7,e8_8,e8_9,e8_10,e8_11,e8_12,e8_13,e8_14,e8_15,e8_16,e8_17];
level9_enemies = [e9_1,e9_2,e9_3,e9_4,e9_5,e9_6,e9_7,e9_8];
level10_enemies = [e10_1,e10_2,e10_3,e10_4,e10_5,e10_6,e10_7,e10_8];
level11_enemies = [e11_1,e11_2,e11_3,e11_4,e11_5,e11_6,e11_7,e11_8,e11_9,e11_10,e11_11,e11_12,e11_13,e11_14,e11_15,e11_16,e11_17,e11_18,e11_19];
level12_enemies = [e12_1,e12_2,e12_3,e12_4,e12_5,e12_6,e12_7,e12_8,e12_9,e12_10];
level13_enemies = [e13_1,e13_2,e13_3,e13_4,e13_5,e13_6,e13_7,e13_8,e13_9,e13_10,e13_11];
level14_enemies = [e14_1,e14_2,e14_3,e14_4,e14_5,e14_6,e14_7,e14_8,e14_9];
level15_enemies = [e15_1,e15_2,e15_3,e15_4,e15_5,e15_6,e15_7,e15_8,e15_9];
level16_enemies = [e16_1,e16_2,e16_3,e16_4,e16_5,e16_6,e16_7,e16_8,e16_9,e16_10,e16_11,e16_12];
level17_enemies = [e17_1,e17_2,e17_3,e17_4,e17_5,e17_6,e17_7,e17_8,e17_9,e17_10,e17_11];
level18_enemies = [e18_1,e18_2,e18_3,e18_4,e18_5,e18_6,e18_7,e18_8,e18_9];
level19_enemies = [e19_1,e19_2,e19_3,e19_4,e19_5,e19_6,e19_7,e19_8,e19_9,e19_10];
level20_enemies = [e20_1,e20_2,e20_3,e20_4,e20_5,e20_6,e20_7,e20_8,e20_9,e20_10,e20_11,e20_12,e20_13,e20_14];
level21_enemies = [e21_1,e21_2,e21_3,e21_4,e21_5,e21_6,e21_7,e21_8,e21_9,e21_10,e21_11,e21_12,e21_13,e21_14,e21_15,e21_16,e21_17,e21_18,e21_19,e21_20,e21_21,e21_22,e21_23,e21_24,e21_25,e21_26,e21_27,e21_28,e21_29,e21_30] +
	[e21_31,e21_32,e21_33,e21_34,e21_35,e21_36,e21_37,e21_38,e21_39,e21_40,e21_41,e21_42,e21_43,e21_44,e21_45,e21_46,e21_47,e21_48,e21_49,e21_50,e21_51,e21_52,e21_53,e21_54,e21_55,e21_56,e21_57,e21_58,e21_59,e21_60] +
	[e21_61,e21_62,e21_63,e21_64,e21_65,e21_66,e21_67,e21_68,e21_69,e21_70,e21_71,e21_72,e21_73,e21_74,e21_75];

{_x setunitpos "UP";_x disableAI "PATH";_x setSkill (0.5 + random 0.3)} foreach level1_enemies;
{_x setunitpos "UP";_x disableAI "PATH";_x setSkill (0.6 + random 0.2)} foreach level2_enemies;
{_x setunitpos "UP";_x disableAI "PATH";_x setSkill (0.65 + random 0.15)} foreach level3_enemies;
{_x setunitpos "UP";_x disableAI "PATH";_x setSkill (0.55 + random 0.25)} foreach level4_enemies;
{_x setunitpos "UP";_x disableAI "PATH";_x setSkill (0.55 + random 0.25);_x setSpeaker "Male01POL"} foreach level5_enemies;
{_x setunitpos "UP";_x disableAI "PATH";_x setSkill (0.65 + random 0.25);_x setSpeaker "Male02POL"} foreach level6_enemies;
{_x setunitpos "UP";_x disableAI "PATH";_x setSkill (0.55 + random 0.35);_x setSpeaker "Male03POL"} foreach level7_enemies;
{_x setunitpos "UP";_x disableAI "PATH";_x setSkill (0.45 + random 0.55);_x setSpeaker "Male02POL"} foreach level8_enemies;
{_x setunitpos "UP";_x disableAI "PATH";_x setSkill (0.35 + random 0.65);_x setSpeaker "Male01POL"} foreach level9_enemies;
{_x setunitpos "UP";_x disableAI "PATH";_x setSkill (0.25 + random 0.85);_x setSpeaker "Male02POL"} foreach level10_enemies;
{_x setunitpos (if (random 1 > 0.5) then {"MIDDLE"} else {"UP"});_x disableAI "PATH";_x setSkill (0.55 + random 0.35);_x setSpeaker "Male02POL"} foreach level11_enemies;
{_x setunitpos (if (random 1 > 0.36) then {"MIDDLE"} else {"UP"});_x disableAI "PATH";_x setSkill (0.65 + random 0.35);_x setSpeaker "Male01POL"} foreach level12_enemies;
{_x setunitpos (if (random 1 > 0.6) then {"MIDDLE"} else {"UP"});_x disableAI "PATH";_x setSkill (0.55 + random 0.45);_x setSpeaker "Male02POL"} foreach level13_enemies;
{_x setunitpos (if (random 1 > 0.3) then {"MIDDLE"} else {"UP"});_x disableAI "PATH";_x setSkill (0.45 + random 0.55);_x setSpeaker "Male01POL"} foreach level14_enemies;
{_x setunitpos (if (random 1 > 0.7) then {"MIDDLE"} else {"UP"});_x disableAI "PATH";_x setSkill (0.5 + random 0.5);_x setSpeaker "Male02POL"} foreach level15_enemies;
{_x setunitpos (if (random 1 > 0.5) then {"MIDDLE"} else {"UP"});_x disableAI "PATH";_x setSkill (0.7 + random 0.25);_x setSpeaker "Male02POL"} foreach level16_enemies;
{_x setunitpos (if (random 1 > 0.4) then {"MIDDLE"} else {"UP"});_x disableAI "PATH";_x setSkill (0.4 + random 0.6);_x setSpeaker "Male01POL"} foreach level17_enemies;
{_x setunitpos (if (random 1 > 0.5) then {"MIDDLE"} else {"UP"});_x disableAI "PATH";_x setSkill (0.65 + random 0.35);_x setSpeaker "Male02POL"} foreach level18_enemies;
{_x setunitpos (if (random 1 > 0.3) then {"MIDDLE"} else {"UP"});_x disableAI "PATH";_x setSkill (0.75 + random 0.25);_x setSpeaker "Male01POL"} foreach level19_enemies;
{_x setunitpos (if (random 1 > 0.4) then {"MIDDLE"} else {"UP"});_x disableAI "PATH";_x setSkill (0.85 + random 0.15);_x setSpeaker "Male02POL"} foreach level20_enemies;
{_x setunitpos (if (random 1 > 0.51) then {"MIDDLE"} else {"UP"});_x disableAI "PATH";_x setSkill (0.5 + random 0.5);_x forceWalk true} foreach level21_enemies;
e21_73 setunitpos "UP";


// init level layers
for [{private _i = 2}, {_i < 22}, {_i = _i + 1}] do {
	{_x enableSimulation false;_x hideObject true;} forEach (getMissionLayerEntities format["Level %1",_i] # 0);	
}; 

#include "sqf\celo_init_secret_doors.sqf";

player call celo_fnc_armor_loot_system;

player addGoggles "G_Combat";

// some player inits
private _eastWest = createGroup west;
[player] joinSilent _eastWest;
player enableFatigue false;
private _ehPlayerKilled = player addEventHandler ["killed", {0 spawn { sleep 0.4; loadgame; }}];

// main end action
[	
	e21_device, // target
	localize "STR_CELO_ending_mission", //title
	"", //idleIcon
	"", //progressIcon 
	"_this distance _target < 5",  //conditionShow
	"_caller distance _target < 5", //conditionProgress
	{
	}, //codeStart
	{}, //codeProgress
	{
		markAsFinishedOnSteam;
		activateKey "klic_celo_wulfenstein_season_one";
		"end1" call BIS_fnc_endMission;
	}, // codeCompleted
	{}, //codeInterurupted
	[player], //arguments
	5 //duration
] call BIS_fnc_holdActionAdd;

// default look is BW, it can be changed by goggles


0 spawn celo_proc_goggles_look_handler;

0 spawn celo_proc_earthquake_timer;

waitUntil {time > 0};

// lets go
cutText["","BLACK IN",2];

