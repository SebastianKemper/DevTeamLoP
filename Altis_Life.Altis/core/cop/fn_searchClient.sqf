#include "..\..\script_macros.hpp"
/*
	File: fn_searchClient.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Searches the player and he returns information back to the player.
*/
params [
	["_cop",Objnull,[objNull]]
];
if(isNull _cop) exitWith {};
private _inv = [];
private _robber = false;
private _var = "";
private _val = 0;
//Illegal items
{
    _var = configName(_x);
    _val = ITEM_VALUE(_var);
    if (_val > 0) then {
        _inv pushBack [_var,_val];
        [false,_var,_val] call life_fnc_handleInv;
    };
} forEach ("getNumber(_x >> 'illegal') isEqualTo 1" configClasses (missionConfigFile >> "VirtualItems"));

if(!life_use_atm) then {
	CASH = 0;
	_robber = true;
};
[[player,_inv,_robber],"life_fnc_copSearch",_cop,false] spawn life_fnc_MP;