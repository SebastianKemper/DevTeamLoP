/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Tries to place a storage box in the nearest house.
*/
private["_boxType","_house","_positions","_containers","_pos","_houseCfg"];
_boxType = _this select 0;

_house = nearestBuilding (getPosATL player);
//_house =(nearestObjects[getPosATL player, ["House_F"],12] select 0);
if(!(_house in life_2vehicles)) exitWith {
	//h/int localize "STR_ISTR_Box_NotinHouse"
	[localize "STR_ISTR_Box_NotinHouse","RED",10] spawn life_fnc_notification_system;
};
_containers = _house getVariable["containers",[]];
_houseCfg = [(typeOf _house)] call life_fnc_houseConfig;
if(count _houseCfg isEqualto 0) exitWith {}; //What the fuck happened?
if(count _containers >= (_houseCfg select 1)) exitWith {
	//h/int localize "STR_ISTR_Box_HouseFull"
	[localize "STR_ISTR_Box_HouseFull","RED",10] spawn life_fnc_notification_system;
};

_slots = _house getVariable ["slots",[]];
_positions = [_house] call life_fnc_getBuildingPositions;
_pos = [0,0,0];
{
	_slots = _house getVariable ["slots",[]];
	if(!(_forEachIndex in _slots)) exitWith {
		_slots pushBack _forEachIndex;
		_house setVariable["slots",_slots,true];
		_pos = _x;
	};
} foreach _positions;
if(_pos isEqualTo [0,0,0]) exitWith {
	//h/int localize "STR_ISTR_Box_HouseFull_2"
	[localize "STR_ISTR_Box_HouseFull_2","RED",10] spawn life_fnc_notification_system;
};
if(!([false,_boxType,1] call life_fnc_handleInv)) exitWith {};
switch (_boxType) do {
	case "storagesmall": {
		_container = "Box_IND_Grenades_F" createVehicle [0,0,0];
		_container setPosATL _pos;
		
		_containers pushBack _container;
		_house setVariable["containers",_containers,true];
		[[_house],"TON_fnc_updateHouseContainers",false,false] spawn life_fnc_MP;
		
		//Empty out the crate
		clearWeaponCargoGlobal _container;
		clearMagazineCargoGlobal _container;
		clearItemCargoGlobal _container;
		clearBackpackCargoGlobal _container;
	};
	
	case "storagebig": {
		_container = "I_supplyCrate_F" createVehicle [0,0,0];
		_container setPosATL _pos;
		
		_containers pushBack _container;
		_house setVariable["containers",_containers,true];
		[[_house],"TON_fnc_updateHouseContainers",false,false] spawn life_fnc_MP;
		
		//Empty out the crate
		clearWeaponCargoGlobal _container;
		clearMagazineCargoGlobal _container;
		clearItemCargoGlobal _container;
		clearBackpackCargoGlobal _container;
	};
	case "storagebigextra": {
		_container = "Land_CargoBox_V1_F" createVehicle [0,0,0];
		_container setPosATL _pos;
		
		_containers pushBack _container;
		_house setVariable["containers",_containers,true];
		[[_house],"TON_fnc_updateHouseContainers",false,false] spawn life_fnc_MP;
		
		//Empty out the crate
		clearWeaponCargoGlobal _container;
		clearMagazineCargoGlobal _container;
		clearItemCargoGlobal _container;
		clearBackpackCargoGlobal _container;
	};
};