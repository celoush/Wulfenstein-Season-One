celo_fnc_debug_level = {
	params ["_level"];
	systemChat format ["DEBUG: PLAYING LEVEL",_level];
	_level spawn {
		params ["_level"];
		if (_level > 1) then {
			(_level - 1) spawn celo_proc_end_level;
		};
		private _level_pos = markerPos format["level_%1",_level];		
		player setPos _level_pos;
	};
};

celo_fnc_debug_level_end = {
	params ["_level"];
	_level spawn celo_fnc_debug_level;
	private _level_enemies = missionNamespace getVariable format["Level%1_enemies",_level];
	{_x setDammage 1} forEach _level_enemies;
	_level spawn {
		params ["_level"];
		sleep 1;
		player setPos markerPos format["level_%1_end",_level];
	}
};