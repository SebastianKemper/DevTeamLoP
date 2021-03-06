/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Defuses blasting charges for the cops?
*/
private["_vault","_ui","_title","_progressBar","_cP","_titleTxt"];
_vault = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _vault) exitWith {};
if(typeOf _vault != "Land_CargoBox_V1_F") exitWith {};
if(!(_vault getVariable["chargeplaced",false])) exitWith {
	//h/int localize "STR_ISTR_Defuse_Nothing"
	[localize "STR_ISTR_Defuse_Nothing","RED",10] spawn life_fnc_notification_system;
};

life_action_inUse = true;
//Setup the progress bar
disableSerialization;
_title = localize "STR_ISTR_Defuse_Process";
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNamespace getVariable "life_progress";
_progressBar = _ui displayCtrl 38201;
_titleTxt = _ui displayCtrl 38202;
_titleTxt ctrlSetText format["%2 (1%1)...","%",_title];
_progressBar progressSetPosition 0.01;
_cP = 0.01;

while {true} do
{
	if(animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
		[[player,"AinvPknlMstpSnonWnonDnon_medic_1"],"life_fnc_animSync",true,false] spawn life_fnc_MP;
		player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
	};
	sleep 0.26;
	if(isNull _ui) then {
		5 cutRsc ["life_progress","PLAIN"];
		_ui = uiNamespace getVariable "life_progress";
		_progressBar = _ui displayCtrl 38201;
		_titleTxt = _ui displayCtrl 38202;
	};
	_cP = _cP + .0035;
	_progressBar progressSetPosition _cP;
	_titleTxt ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_title];
	if(_cP >= 1 OR !alive player) exitWith {};
	if(life_interrupted) exitWith {};
};

//Kill the UI display and check for various states
5 cutText ["","PLAIN"];
player playActionNow "stop";
if(!alive player) exitWith {life_action_inUse = false;};
if(life_interrupted) exitWith {
	life_interrupted = false; 
	//t/itleText[localize "STR_NOTF_ActionCancel","PLAIN"]; 
	[localize "STR_NOTF_ActionCancel","RED",10] spawn life_fnc_notification_system;
	life_action_inUse = false;
};

life_action_inUse = false;
_vault setVariable["chargeplaced",false,true];
[[2,localize "STR_ISTR_Defuse_Success"],"life_fnc_broadcast",west,false] spawn life_fnc_MP;