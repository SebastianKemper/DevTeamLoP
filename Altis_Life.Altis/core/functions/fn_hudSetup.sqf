#include "..\..\script_macros.hpp"
/*
	File: fn_hudSetup.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Setups the hud for the player?
*/
private["_display","_alpha","_version","_p","_pg"];
disableSerialization;
_display = findDisplay 46;
_alpha = _display displayCtrl 1001;
_version = _display displayCtrl 1000;

2 cutRsc ["playerHUD","PLAIN"];
_version ctrlSetText format["BETA: 0.%1.%2",(productVersion select 2),(productVersion select 3)];
[] call life_fnc_hudUpdate;

[] spawn
{
    private ["_dam"];
    for "_i" from 0 to 1 step 0 do {
        _dam = damage player;
        waitUntil {!((damage player) isEqualTo _dam)};
        [] call life_fnc_hudUpdate;
    };
};

[] spawn {
	for "_i" from 0 to 1 step 0 do {
		[] call life_fnc_hudUpdate;
		sleep 30;
	};
};