#include "..\..\script_macros.hpp"
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Prompts the user about disbanding the gang and if the user accepts the gang will be
	disbanded and removed from the database.
*/
private["_action"];

_action = [
	localize "STR_GNOTF_DisbandWarn",
	localize "STR_Gang_Disband_Gang",
	localize "STR_Global_Yes",
	localize "STR_Global_No"
] call BIS_fnc_guiMessage;

if(_action) then {
	//h/int localize "STR_GNOTF_DisbandGangPro";
	[localize "STR_GNOTF_DisbandGangPro","GREEN",5] spawn life_fnc_notification_system;
	[[grpPlayer],"TON_fnc_removeGang",false,false] spawn life_fnc_MP;
} else {
	//h/int localize "STR_GNOTF_DisbandGangCanc";
	[localize "STR_GNOTF_DisbandGangCanc","RED",10] spawn life_fnc_notification_system;
};