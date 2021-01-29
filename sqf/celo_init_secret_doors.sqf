celo_secret_doors = [secretDoor_1_1,secretDoor_3_1,secretDoor_4_1,secretDoor_6_1,secretDoor_10_1,secretDoor_15_1,secretDoor_21_1,secretDoor_21_2];
celo_fnc_init_secret_doors = {
	params ["_unit","_doors"];
	{_unit disableCollisionWith _x} foreach _doors;
};

addMissionEventHandler ["loaded",{
	[player,celo_secret_doors] call celo_fnc_init_secret_doors;
	playMusic (call celo_fnc_get_random_fight_music)
}];
[player,celo_secret_doors] call celo_fnc_init_secret_doors;