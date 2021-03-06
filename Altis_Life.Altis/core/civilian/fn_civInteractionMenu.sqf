/* File Original: fn_copInteractionMenu.sqf
Author: TONIC
File: fn_civInteractionMenu.sqf
Author: AlexDinio
*/
#define Btn1 37450
#define Btn2 37451
#define Btn3 37452
#define Btn4 37453
#define Btn5 37454
#define Btn6 37455
#define Btn7 37456
#define Btn8 37457
#define Title 37401
params ["_curTarget","_closestMan"];
private["_display","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7","_Btn8"];
if(!dialog) then {
createDialog "pInteraction_Menu";
};
disableSerialization;
//_curTarget = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
//if(isNull _curTarget) exitWith {closeDialog 0;};
if !(_closestMan isEqualTo "") then {
	if(!isPlayer _closestMan && (side _closestMan isEqualTo civilian || side _closestMan isEqualTo west)) exitWith {closeDialog 0;};
	_display = findDisplay 37400;
	_Btn1 = _display displayCtrl Btn1;
	_Btn2 = _display displayCtrl Btn2;
	_Btn3 = _display displayCtrl Btn3;
	_Btn4 = _display displayCtrl Btn4;
	_Btn5 = _display displayCtrl Btn5;
	_Btn6 = _display displayCtrl Btn6;
	_Btn7 = _display displayCtrl Btn7;
	_Btn8 = _display displayCtrl Btn8;
	_Btn4 ctrlShow false;
	_Btn5 ctrlShow false;
	_Btn6 ctrlShow false;
	_Btn7 ctrlShow false;
	_Btn8 ctrlShow false;
	_Btn1 ctrlShow true;
	_Btn2 ctrlShow true;
	_Btn3 ctrlShow true;
	life_pInact_curTarget = _closestMan;

	//Set Unrestrain Button
	_Btn1 ctrlSetText localize "STR_pInAct_Unrestrain";
	_Btn1 buttonSetAction "[life_pInact_curTarget] call life_fnc_unrestrain; closeDialog 0;";

	//Set Escort Button
	if((_closestMan getVariable["Escorting",false])) then {
		_Btn2 ctrlSetText localize "STR_pInAct_StopEscort";
		_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_stopEscorting; closeDialog 0;";
	} else {
		_Btn2 ctrlSetText localize "STR_pInAct_Escort";
		_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_escortAction; closeDialog 0;";
	};
	//Set in Car Button
	_Btn3 ctrlSetText localize "STR_pInAct_PutInCar";
	_Btn3 buttonSetAction "[life_pInact_curTarget] call life_fnc_putInCar;";
	if((side player isEqualTo civilian) && (player != _closestMan) && !(player getVariable["Re-strained",FALSE])) then {
		_Btn1 ctrlEnable true;
		_Btn2 ctrlEnable true;
		_Btn3 ctrlEnable true
	} else {
		_Btn1 ctrlEnable false;
		_Btn2 ctrlEnable false;
		_Btn3 ctrlEnable false;
	};
};