/*
	File: fn_sirenLights.sqf
	Author: Bryan "Tonic" Boardwine modifed by moeck (Lost of Paradise)
	
	Description:
	Lets play a game! Can you guess what it does? I have faith in you, if you can't
	then you have failed me and therefor I lose all faith in humanity.. No pressure.
*/
private["_vehicle"];
_vehicle = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _vehicle) exitWith {}; //Bad entry!
if(!(typeOf _vehicle in life_cop_veh)) exitWith {}; //Last chance check to prevent something from defying humanity and creating a monster.

_trueorfalse = _vehicle getVariable["lights",FALSE];

if(_trueorfalse) then {
	_vehicle setVariable["lights",FALSE,TRUE];
} else {
	_vehicle setVariable["lights",TRUE,TRUE];
	if(!(typeOf _vehicle in ["C_SUV_01_F","C_Offroad_02_unarmed_F","C_Hatchback_01_F","C_Hatchback_01_sport_F"])) then {
		[[_vehicle,0.22],"life_fnc_copLights",true,false] call life_fnc_MP;
	} else {
		[[_vehicle,0.22],"life_fnc_copLights_new_ground",true,false] call life_fnc_MP;
	};
};