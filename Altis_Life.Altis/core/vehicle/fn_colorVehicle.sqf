#include "..\..\script_macros.hpp"
/*
	File: fn_colorVehicle.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Reskins the vehicle
*/
params [
    ["_vehicle",objNull,[objNull]],
    ["_index",-1,[0]]
];
private _className = typeOf _vehicle;
private _classNameLife = _className;



if (isNull _vehicle || !alive _vehicle || _index isEqualTo -1) exitWith {};
//Does the vehicle already have random styles? Halt till it's set.

if(local _vehicle) then {
	switch (typeOf _vehicle) do
	{
		case "C_Offroad_01_F": {[[_vehicle,"color",3,true],"TON_fnc_setObjVar",false,false] spawn life_fnc_MP;};
		case "C_Hatchback_01_F": {[[_vehicle,"color",1,true],"TON_fnc_setObjVar",false,false] spawn life_fnc_MP;};
		case "C_Hatchback_01_sport_F": {[[_vehicle,"color",1,true],"TON_fnc_setObjVar",false,false] spawn life_fnc_MP;};
		case "C_SUV_01_F": {[[_vehicle,"color",1,true],"TON_fnc_setObjVar",false,false] spawn life_fnc_MP;};
		case "C_Van_01_box_F": {[[_vehicle,"color",1,true],"TON_fnc_setObjVar",false,false] spawn life_fnc_MP;};
		case "C_Van_01_transport_F": {[[_vehicle,"color",1,true],"TON_fnc_setObjVar",false,false] spawn life_fnc_MP;};
	};
};

if (!isClass (missionConfigFile >> "LifeCfgVehicles" >> _classNameLife)) then {
    _classNameLife = "Default"; //Use Default class if it doesn't exist
    diag_log format ["%1: LifeCfgVehicles class doesn't exist",_className];
};
private _texturesarray = (M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"textures"));
_counter = count _texturesarray;
if (_counter > 0 && (_counter < _index)) then { 
	_index = 0;
};

private _textures = ((M_CONFIG(getArray,"LifeCfgVehicles",_classNameLife,"textures") select _index) select 2);

if (isNil "_textures" || {count _textures isEqualTo 0}) exitWith {};

_vehicle setVariable ["Life_VEH_color",_index,true];

{_vehicle setObjectTextureGlobal [_forEachIndex,_x];} forEach _textures;

