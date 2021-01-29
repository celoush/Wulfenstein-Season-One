/*
* celo armor loot system
* author: celoush
* version: 1.01
*/


celo_fnc_armor_loot_system = {
	params ["_person"];	
	_person addEventHandler ["HandleDamage",{
		params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];

		private ["_headgear","_uniform","_backpack","_armor","_vest","_weapon","_headgears_armor","_uniforms_armor","_backpacks_armor","_vests_armor","_used_armor","_weapons_armor","_items","_item_name","_goggles"];		
		_vest = vest _unit;
		_headgear = headgear _unit;
		_uniform = uniform _unit;
		_backpack = backpack _unit;
		_weapon = primaryWeapon _unit;

		_weapons_armor = _unit getVariable ["celo_arsys_weapon",[]];
		_uniforms_armor = _unit getVariable ["celo_arsys_uniform",[]];
		_backpacks_armor = _unit getVariable ["celo_arsys_backpack",[]];
		_headgears_armor = _unit getVariable ["celo_arsys_headgear",[]];
		_vests_armor = _unit getVariable ["celo_arsys_vest",[]];
		_used_armor = false;

		if ((_headgear != "") && (!_used_armor)) then {
			_armor = [_headgears_armor,_headgear,5] call BIS_fnc_getFromPairs;
			if (_armor > 0) then {
				_used_armor = true;
				_armor = (_armor - _damage) max 0;				
				[_headgears_armor,_headgear,_armor] call BIS_fnc_setToPairs;				
				if (_armor <= 0) then {
					removeHeadgear _unit;
					[_headgears_armor,_headgear,5] call BIS_fnc_setToPairs;
				};
				_unit setVariable ["celo_arsys_headgear",_headgears_armor];				
			};			
		};

		if (!_used_armor) then {
			scopeName "primaryWeaponScope";
			_items = primaryWeaponItems player;
			for [{private _i = 0}, {_i < 4}, {_i = _i + 1}] do {
				if (_items#_i!="") then {
					player removePrimaryWeaponItem (_items#_i);
					_used_armor = true;
					breakOut "primaryWeaponScope";
				}
			};
		};

		if (!_used_armor) then {
			_goggles = goggles player;
			if (_goggles!="") then {
				removeGoggles player;
				_used_armor = true;
			};
		};		

		if ((_uniform != "") && (!_used_armor)) then {
			_armor = [_uniforms_armor,_uniform,5] call BIS_fnc_getFromPairs;
			if (_armor > 0) then {
				_used_armor = true;
				_armor = (_armor - _damage) max 0;				
				[_uniforms_armor,_uniform,_armor] call BIS_fnc_setToPairs;				
				if (_armor <= 0) then {
					removeUniform _unit;
					[_uniforms_armor,_uniform,5] call BIS_fnc_setToPairs;
				};
				_unit setVariable ["celo_arsys_uniform",_uniforms_armor];				
			};
			
		};

		if (!_used_armor) then {
			scopeName "handgunWeaponScope";
			_items = handgunItems player;
			for [{private _i = 0}, {_i < 4}, {_i = _i + 1}] do {
				if (_items#_i!="") then {
					player removeHandgunItem (_items#_i);
					_used_armor = true;
					breakOut "handgunWeaponScope";
				}
			};
		};		

		if ((_weapon != "") && (!_used_armor)) then {
			_armor = [_weapons_armor,_weapon,5] call BIS_fnc_getFromPairs;
			if (_armor > 0) then {
				_used_armor = true;
				_armor = (_armor - _damage) max 0;				
				[_weapons_armor,_weapon,_armor] call BIS_fnc_setToPairs;				
				if (_armor <= 0) then {
					_unit removeWeapon (primaryWeapon _unit);
					[_weapons_armor,_weapon,5] call BIS_fnc_setToPairs;
				};
				_unit setVariable ["celo_arsys_weapon",_weapons_armor];				
			};			
		};

		if (!_used_armor) then {
			// now randomly select vest or backpack

			private _check_vest = false;
			private _check_backpack = false;

			if ((_vest!="")&&(_backpack!="")) then {
				if (random 1 > 0.5) then {
					_check_vest = true;
				} else {
					_check_backpack = true;
				}
			} else {
				if (_vest!="") then {
					_check_vest = true;
				} else {
					if (_backpack!="") then {
						_check_backpack = true;
					}
				}
			};

			if (_check_vest) then {
				_armor = [_vests_armor,_vest,20] call BIS_fnc_getFromPairs;
				if (_armor > 0) then {
					_used_armor = true;
					_armor = (_armor - _damage) max 0;				
					[_vests_armor,_vest,_armor] call BIS_fnc_setToPairs;				
					if (_armor <= 0) then {
						removeVest _unit;
						[_vests_armor,_vest,20] call BIS_fnc_setToPairs;
					};
					_unit setVariable ["celo_arsys_vest",_vests_armor];				
				};	
			};

			if (_check_backpack) then {
				_armor = [_backpacks_armor,_backpack,15] call BIS_fnc_getFromPairs;
				if (_armor > 0) then {
					_used_armor = true;
					_armor = (_armor - _damage) max 0;				
					[_backpacks_armor,_backpack,_armor] call BIS_fnc_setToPairs;				
					if (_armor <= 0) then {
						removeBackpack _unit;
						[_backpacks_armor,_backpack,15] call BIS_fnc_setToPairs;
					};
					_unit setVariable ["celo_arsys_backpack",_backpacks_armor];				
				};			
			};			
		};	

		if (_used_armor) then {0} else {_damage};
	}];
};