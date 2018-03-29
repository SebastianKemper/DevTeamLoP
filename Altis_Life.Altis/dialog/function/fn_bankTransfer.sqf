#include "..\..\script_macros.hpp"
/*
    File: fn_bankTransfer.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Figure it out again.
*/
if(isNil "life_money_antiglitch") then {life_money_antiglitch = false;};
if(life_money_antiglitch) exitWith {
	["Geldspam verboten","RED",5] spawn life_fnc_notification_system;
	ctrlShow[2001,true];
};
private ["_value","_unit","_tax"];
_val = parseNumber(ctrlText 2702);
_unit = call compile format ["%1",(lbData[2703,(lbCurSel 2703)])];
if (isNull _unit) exitWith {};
if((lbCurSel 2703) isEqualto -1) exitWith {[localize "STR_ATM_NoneSelected","RED",5] spawn life_fnc_notification_system;};
if(isNil "_unit") exitWith {[localize "STR_ATM_DoesntExist","RED",5] spawn life_fnc_notification_system;};
if(_val > 10000000) exitWith {[localize "STR_ATM_TransferMax","RED",5] spawn life_fnc_notification_system;};
if(_val < 0) exitwith {};
if(_val > BANK) exitWith {[localize "STR_ATM_NotEnough","RED",5] spawn life_fnc_notification_system;};
_tax = [_val] call life_fnc_taxRate;
if((_val + _tax) > BANK) exitWith {[format[localize "STR_ATM_SentMoneyFail",_val,_tax],"RED",5] spawn life_fnc_notification_system;};

BANK = BANK - (_value + _tax);

[_val,profileName] remoteExecCall ["life_fnc_wireTransfer",_unit];
[player, _unit, _val, 0, BANK, CASH] remoteExec ["TON_fnc_handleDBLog",RSERV]; //By Nukefliege
[] call life_fnc_atmMenu;
[1] call SOCK_fnc_updatePartial;
[format[localize "STR_ATM_SentMoneySuccess",[_val] call life_fnc_numberText,_unit getVariable["realname",name _unit],[_tax] call life_fnc_numberText],"GREEN",5] spawn life_fnc_notification_system;

if (LIFE_SETTINGS(getNumber,"player_moneyLog") isEqualTo 1) then {
    if (LIFE_SETTINGS(getNumber,"battlEye_friendlyLogging") isEqualTo 1) then {
        money_log = format [localize "STR_DL_ML_transferredBank_BEF",_value,_unit getVariable ["realname",name _unit],[BANK] call life_fnc_numberText,[CASH] call life_fnc_numberText];
    } else {
        money_log = format [localize "STR_DL_ML_transferredBank",profileName,(getPlayerUID player),_value,_unit getVariable ["realname",name _unit],[BANK] call life_fnc_numberText,[CASH] call life_fnc_numberText];
    };
    publicVariableServer "money_log";
};
[]spawn {
	life_money_antiglitch = true;
	uiSleep 1;
	life_money_antiglitch = false;
};