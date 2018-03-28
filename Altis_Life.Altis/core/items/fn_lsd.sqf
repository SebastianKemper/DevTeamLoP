/*
	@Version: 1.0
	@Author: Sebi, lostofparadise.de
	@Edited: 15.09.2014
	@Info: Bevor Ihr es klaut, fragt bitte bei uns nach. Vielen Dank.
*/

//Close inventory
closeDialog 0;
life_pickAxeAllowed = false;
life_action_gather = true;
life_action_inUse = true;
sleep 1;
_smoke = "SmokeShellOrange" createVehicle position player;
if (vehicle player != player) then {
	_smoke attachTo [vehicle player, [0,-1,0]];
} else {
	_smoke attachTo [player, [0,0,1]];
};
//Little h/int then wait a litle before starting drugs effects
//h/int "Yes Baby...";
["Yes Baby...","PINK",5] spawn life_fnc_notification_system;
sleep 3;
player setDamage 0.15;

//Activate ppEffects we need
"chromAberration" ppEffectEnable true;
"radialBlur" ppEffectEnable true;
enableCamShake true;

//Let's go for 45secs of effetcs
for "_i" from 0 to 44 do
{
    "chromAberration" ppEffectAdjust [random 0.25,random 0.25,true];
    "chromAberration" ppEffectCommit 1;   
    "radialBlur" ppEffectAdjust  [random 0.02,random 0.02,0.15,0.15];
    "radialBlur" ppEffectCommit 1;
    addcamShake[random 3, 1, random 3];
    sleep 1;
};

//Stop effects
"chromAberration" ppEffectAdjust [0,0,true];
"chromAberration" ppEffectCommit 5;
"radialBlur" ppEffectAdjust  [0,0,0,0];
"radialBlur" ppEffectCommit 5;
sleep 6;
//h/int "Drogen nix gut!";
["Drogen nix gut!","PINK",5] spawn life_fnc_notification_system;
//Deactivate ppEffects
"chromAberration" ppEffectEnable false;
"radialBlur" ppEffectEnable false;
resetCamShake;
sleep 10;
life_action_gather = false;
life_action_inUse = false;
life_pickAxeAllowed = true;