#include "..\..\script_macros.hpp"
/*
	File: fn_adminFreeze.sqf
	Author: ColinM9991
 
	Description: Freezes selected player
*/
if (FETCH_CONST(life_adminlevel) < 3) exitWith {closeDialog 0; hint localize "STR_ANOTF_ErrorLevel";};
private _unit = lbData[2902,lbCurSel (2902)];
_unit = call compile format ["%1", _unit];
if (isNil "_unit") exitWith {};
if (isNull _unit) exitWith {};
if (_unit isEqualTo player) exitWith {hint localize "STR_ANOTF_Error";};
[[player],"life_fnc_freezePlayer",_unit,false] spawn life_fnc_MP;