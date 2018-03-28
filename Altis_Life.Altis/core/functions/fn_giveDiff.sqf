#include "..\..\script_macros.hpp"
/*
	File: fn_giveDiff.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	??A?SD?ADS?A
*/
params [
	"_unit",
	"_item",
	"_val",
	"_from"
];
if !(_unit isEqualTo player) exitWith {};
private _bool = if(count _this > 4) then {true} else {false};
private _type = M_CONFIG(getText,"VirtualItems",_item,"displayName");
if(_bool) then {
	if(([true,_item,(parseNumber _val)] call life_fnc_handleInv)) then {[format[localize "STR_MISC_TooMuch",_from getVariable["realname",name _from],_val,(localize _type)],"RED",10] spawn life_fnc_notification_system;};
} else {
	if(([true,_item,(parseNumber _val)] call life_fnc_handleInv)) then { [format[localize "STR_MISC_TooMuch_2",_from getVariable["realname",name _from],_val,(localize _type)],"RED",10] spawn life_fnc_notification_system;};
};