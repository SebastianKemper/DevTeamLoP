#include "..\..\script_macros.hpp"
/*
    File: fn_impoundMenu.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Not actually a impound menu, may act as confusion to some but that is what I wanted.
    The purpose of this menu is it is now called a 'Garage' where vehicles are stored (persistent ones).
*/
#define Button1 2812;
#define Title 2801;
disableSerialization;
params [
	["_vehicles",[],[[]]],
	["_type","",[""]]
];

ctrlShow[2803,false];
ctrlShow[2830,false];
waitUntil {!isNull (findDisplay 2800)};
private _Button1 = _display displayCtrl Button1;

if (count _vehicles isEqualTo 0) exitWith {
    ctrlSetText[2811,localize "STR_Garage_NoVehicles"];
};

_control = CONTROL(2800,2802);
lbClear _control;

{
    _vehicleInfo = [(_x select 2)] call life_fnc_fetchVehInfo;
    _control lbAdd (_vehicleInfo select 3);
    _tmp = if (_type isEqualTo "jail") then {[(_x select 2),(_x select 8),_type,(_x select 10)]} else {[(_x select 2),(_x select 8)]};
	_tmp = str(_tmp);
    _control lbSetData [(lbSize _control)-1,_tmp];
    _control lbSetPicture [(lbSize _control)-1,(_vehicleInfo select 2)];
    _control lbSetValue [(lbSize _control)-1,(_x select 0)];
	false
} count _vehicles;
lbSort _control;
ctrlShow[2810,false];
ctrlShow[2811,false];
if (_type isEqualTo "insure") then {
	_Button1 ctrlSetText "Reparieren";
	_Button1 buttonSetAction "[] call life_fnc_restoreVehicle; closeDialog 0;";
	_title ctrlSetText "Versicherung";
} else {
	_Button1 ctrlSetText localize "STR_Global_Retrieve";
	if (_type isEqualTo "jail") then {_Button1 ctrlSetText "Auslösen";};
	_Button1 buttonSetAction "[] call life_fnc_unimpound; closeDialog 0;";
	_title ctrlSetText localize"STR_GUI_Garage";
};
