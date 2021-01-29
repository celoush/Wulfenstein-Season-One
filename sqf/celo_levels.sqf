celo_proc_enemy_reaction = {
	params ["_e"];
	//sleep (random 0.3);
	_e doTarget player; 
	//_e setunitpos "UP";
	sleep (0.05 + random 0.15);
	_e enableAI "PATH";
	_e forceWalk true;
	_e doMove getPosATL player;	
};

celo_fnc_enemy_handler = {
	private _e = _this#0;
	_e spawn celo_proc_enemy_reaction;
	_e removeAllEventHandlers "Fired";
	_e removeAllEventHandlers "Hit";
};

celo_fnc_get_random_fight_music = {
	selectRandom [
		"Music_FreeRoam_Battle_Alien_Loop_01",
		"Music_FreeRoam_Battle_Alien_Loop_02",
		"Music_FreeRoam_Battle_Alien_Loop_03",
		"Music_FreeRoam_Battle_Human_Loop",
		"Music_FreeRoam_Russian_Theme_Loop",
		"Music_Battle_Human_Loop"
	]
};

celo_ending_level_music_names_list = [
	'',
	'LeadTrack01_F_6th_Anniversary_Remix', //level 1
	'LeadTrack04_F', //level 2
	'Track_P_02', //level 3
	'LeadTrack03_F_EPA', //level 4
	'LeadTrack02_F_Tank', //level 5
	'EventTrack01_F_Jets', //level 6
	'Music_Arrival', //level 7
	'Track_D_01', //level 8
	'LeadTrack05_F_Tank', //level 9
	'Track_M_02', //level 10
	'Track_R_21', //level 11
	'Track_O_16', //level 12
	'LeadTrack02_F_Bootcamp', //level 13
	'Track_C_18', //level 14
	'Track_C_19', //level 15
	'Track_P_15', //level 16
	'Track_O_01', //level 17
	'Track_R_05', //level 18
	'Track_O_14', //level 19
	'LeadTrack01_F' //level 20	
];

celo_fnc_get_ending_level_music = {
	params ["_level"];
	celo_ending_level_music_names_list#_level
};

/*celo_proc_enemy_knowsabout_reaction = {
	params ["_enemy"];
	waitUntil {
		sleep 1;
		if (!alive _enemy) exitWith { true };	
		(_enemy knowsAbout player > 3.9)
	};	
	_enemy spawn celo_proc_enemy_reaction;	
};*/

celo_proc_start_level = {
	params ["_level"];
	private _text = if (_level > 1) then {
		format [("<t align = 'center' size='1.6'>Level %1</t>"),_level]
	} else {
		("<t align = 'center' size='1.2'>"+(localize "STR_CELO_First_Level")+'</t>')
	};
	[parseText _text, [safeZoneX + safeZoneW - 0.35 - 0.025, safeZoneY + safeZoneH - 0.25 - 0.05, 0.35, 0.10], [10, 3]] spawn BIS_fnc_textTiles;

	3 fadeMusic 0;
	0 spawn {
		sleep 2;
		0 call celo_fnc_force_savegame;
	};
	sleep 4;
	playMusic (call celo_fnc_get_random_fight_music);
	0 fadeMusic 0.2;
	if (_level > 1) then {
		{_x removeAllEventHandlers "Fired";deleteVehicle _x} forEach (getMissionLayerEntities format["Level %1",_level - 1] # 0);		
	};
	private _level_enemies = missionNamespace getVariable format["Level%1_enemies",1];
	{
	  _x addEventHandler ["Fired", celo_fnc_enemy_handler];
	  _x addEventHandler ["Hit", celo_fnc_enemy_handler];

	  //_x spawn celo_proc_enemy_knowsabout_reaction;

	} forEach _level_enemies;
};

celo_proc_end_level = {
	params ["_level"];
	if (_level == 1) then {
		private _text = format [("<t align = 'center' size='1.1'>"+(localize "STR_CELO_First_Level_End")+'</t>'),name player];
		[parseText _text, [safeZoneX + safeZoneW - 0.35 - 0.025, safeZoneY + safeZoneH - 0.25 - 0.05, 0.35, 0.10], [10, 3]] spawn BIS_fnc_textTiles;
	};
	playMusic (_level call celo_fnc_get_ending_level_music);
	0 fadeMusic 1;
	//setting another level
	{
		_x enableSimulation true;
		_x hideObject false;		
	} forEach (getMissionLayerEntities format ["Level %1",_level+1] select 0);
	//removing ending wall
	deleteVehicle (missionNamespace getVariable format["endingWall_%1",_level]);


	// smoking
	private _level_pos = markerPos format["level_%1",_level+1];
	private _posX = _level_pos#0;
	private _posY = _level_pos#1;
	private _z = 100;
	private _smoke = "SmokeShellRed" createVehicle [_posX,_posY,_z]; 
	waitUntil {
		_z = _z - 0.275;
	  	_smoke setPos [_posX,_posY,_z];
	  	sleep 0.1;
	 	(_z < 2)
	};
	waitUntil {sleep 1;player distance _smoke < 150};
	deletevehicle _smoke;
};

celo_proc_earthquake_timer = {
	private ["_timer","_level","_counter"];
	sleep 20;
	_counter = 0;	
	celo_earthquake_timer_counter = 0;
	while {_timer = (194 - _counter*2);_timer > 8} do {	
		setAccTime 1;	
		_level = _counter call celo_fnc_get_earthquake_level_for_loop;
		[_level] spawn BIS_fnc_earthquake;
		_counter = _counter + 1;		
		celo_earthquake_timer_counter = _counter;		
		sleep _timer;
		if (celo_earthquake_timer_counter != _counter) then {
			_counter = celo_earthquake_timer_counter;
			systemChat format["DEBUG: COUNTER RESET TO %1",_counter];
		};
		if (_counter == 15 || _counter == 40 || _counter == 70) then {
			0 spawn {
				sleep 10;
				private _text = format [("<t align = 'center' size='1.1'>"+(localize "STR_CELO_time_warning")+'</t>')];
				[parseText _text, [safeZoneX + safeZoneW - 0.35 - 0.025, safeZoneY + safeZoneH - 0.25 - 0.05, 0.35, 0.10], [10, 3]] spawn BIS_fnc_textTiles;				
			};
		};
	};
	0 spawn {
		cutText["","WHITE OUT",1];
		sleep 0.25;
		"end2" call BIS_fnc_endMission;
	};
};

celo_fnc_get_earthquake_level_for_loop = {
	params ["_counter"];
	if (_counter < 15) exitWith {1};
	if (_counter < 40) exitWith {2};
	if (_counter < 70) exitWith {3};
	4
};

// look 2020
celo_fnc_set_look_2021 = {
	"colorCorrections" ppEffectAdjust [1, 0.99, -0.02, [0.8, 0.8, 1.0, 0.05], [0.5,0.8, 0.6, 0.65], [0.2, 0.5, 0.1, 0.0]];"colorCorrections" ppEffectCommit 0;   
	"colorCorrections" ppEffectEnable true; 	
};

// look BW
celo_fnc_set_look_bw = {
	"colorCorrections" ppEffectAdjust [1, 1.04, -0.004, [0.5, 0.5, 0.5, 0.0], [0.5, 0.5, 0.5, 0.0],  [0.5, 0.5, 0.5, 0.0]];
	"colorCorrections" ppEffectCommit 0; 
	"colorCorrections" ppEffectEnable true;	
};

celo_proc_goggles_look_handler = { 
	private _celo_color_mode = "";
	while {true} do {
		if (goggles player != '' and _celo_color_mode!="BW") then {
			call celo_fnc_set_look_bw;	
			_celo_color_mode = 'BW';
		};
		if (goggles player == '' and _celo_color_mode!="2021") then {
			call celo_fnc_set_look_2021;
			_celo_color_mode = '2021';
		};
		sleep 0.5;
	};
};