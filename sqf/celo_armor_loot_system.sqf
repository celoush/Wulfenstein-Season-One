/*
* celo armor loot system
* author: celoush
* version: 1.02 
* required: Arma 3 - v2.0.1+
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

		_weapons_armor = _unit getVariable ["celo_arsys_weapon",createHashMap];
		_uniforms_armor = _unit getVariable ["celo_arsys_uniform",createHashMap];
		_backpacks_armor = _unit getVariable ["celo_arsys_backpack",createHashMap];
		_headgears_armor = _unit getVariable ["celo_arsys_headgear",createHashMap];
		_vests_armor = _unit getVariable ["celo_arsys_vest",createHashMap];
		_used_armor = false;

		if ((_headgear != "") && (!_used_armor)) then {
			_armor = _headgears_armor getOrDefault [_headgear,5];
			if (_armor > 0) then {
				_used_armor = true;
				_armor = (_armor - _damage) max 0;				
				_headgears_armor set [_headgear,_armor];
				if (_armor <= 0) then {
					removeHeadgear _unit;
					_headgears_armor set [_headgear,5];
				};
				_unit setVariable ["celo_arsys_headgear",_headgears_armor];				
			};			
		};

		if (!_used_armor) then {
			scopeName "primaryWeaponScope";
			_items = primaryWeaponItems _unit;
			for [{private _i = 0}, {_i < 4}, {_i = _i + 1}] do {
				if (_items#_i!="") then {
					_unit removePrimaryWeaponItem (_items#_i);
					_used_armor = true;
					breakOut "primaryWeaponScope";
				}
			};
		};

		if (!_used_armor) then {
			_goggles = goggles _unit;
			if (_goggles!="") then {
				removeGoggles _unit;
				_used_armor = true;
			};
		};		

		if ((_uniform != "") && (!_used_armor)) then {
			_armor = _uniforms_armor getOrDefault [_uniform,5];
			if (_armor > 0) then {
				_used_armor = true;
				_armor = (_armor - _damage) max 0;				
				_uniforms_armor set [_uniform,_armor];
				if (_armor <= 0) then {
					removeUniform _unit;
					_uniforms_armor set [_uniform,5];
				};
				_unit setVariable ["celo_arsys_uniform",_uniforms_armor];				
			};
			
		};

		if (!_used_armor) then {
			scopeName "handgunWeaponScope";
			_items = handgunItems _u;
			for [{private _i = 0}, {_i < 4}, {_i = _i + 1}] do {
				if (_items#_i!="") then {
					_unit removeHandgunItem (_items#_i);
					_used_armor = true;
					breakOut "handgunWeaponScope";
				}
			};
		};		

		if ((_weapon != "") && (!_used_armor)) then {
			_armor = _weapons_armor getOrDefault [_weapon,5];
			if (_armor > 0) then {
				_used_armor = true;
				_armor = (_armor - _damage) max 0;	
				_weapons_armor set [_weapon,_armor];
				if (_armor <= 0) then {
					_unit removeWeapon (primaryWeapon _unit);
					_weapons_armor set [_weapon,5];
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
				_armor = _vests_armor getOrDefault [_vest,20];
				if (_armor > 0) then {
					_used_armor = true;
					_armor = (_armor - _damage) max 0;				
					_vests_armor set [_vest,_armor];				
					if (_armor <= 0) then {
						removeVest _unit;
						_vests_armor set [_vest,20];
					};
					_unit setVariable ["celo_arsys_vest",_vests_armor];				
				};	
			};

			if (_check_backpack) then {
				_armor = _backpacks_armor getOrDefault [_backpack,15];
				if (_armor > 0) then {
					_used_armor = true;
					_armor = (_armor - _damage) max 0;				
					_backpacks_armor set [_backpack,_armor];
					if (_armor <= 0) then {
						removeBackpack _unit;
						_backpacks_armor set [_backpack,15];
					};
					_unit setVariable ["celo_arsys_backpack",_backpacks_armor];				
				};			
			};			
		};	

		if (_used_armor) then {0} else {_damage};
	}];
};
