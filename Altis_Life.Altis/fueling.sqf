life_fuelstation_stationlist = (nearestObjects [getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["Land_fs_feed_F","Land_CarService_F"], 25000]);
{_x setFuelCargo 1;} forEach life_fuelstation_stationlist;