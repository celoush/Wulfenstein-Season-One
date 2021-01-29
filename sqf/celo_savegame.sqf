celo_fnc_force_savegame = {
	setAccTime 1;
	enableSaving true;
	savegame;
	enableSaving false;
};


celo_fnc_radio_save = {
	private _has_firstaidkit = [player, "FirstAidKit"] call BIS_fnc_hasItem;
	if (_has_firstaidkit) then {
		player removeItem "FirstAidKit";
		call celo_fnc_force_savegame;
	} else {
		hintSilent localize "STR_CELO_no_medkit_warning";
	}
};