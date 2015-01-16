/**
 * fn_addOpenWounds_CMS.sqf
 * @Descr: Add open wounds to unit.
 * @Author: Glowbal
 *
 * @Arguments: [unit OBJECT (The object that will recieve the wound), bodyPart STRING, type STRING (Small, medium or large), amount NUMBER (The amount of open wounds added)]
 * @Return: void
 * @PublicAPI: true
 */

private ["_unit", "_bodyPart", "_type", "_openWounds", "_selection", "_amount", "_newAmount"];
_unit = _this select 0;
_bodyPart = _this select 1;
_type = _this select 2;
_amount = _this select 3;

if (typeName _bodyPart == "STRING") then {
	_bodyPart = [_bodyPart] call cse_fnc_getBodyPartNumber_CMS;
};
if (typeName _type == "STRING") then {
	_type = switch (toLower _type) do {
		case "small": {0};
		case "medium": {1};
		case "large": {2};
		default {-1};
	};
};

if (_type < 0) exitwith {
	[format["Adding an injury with an invalid type: %1",_this], 0] call cse_fnc_debug;
};

_openWounds = [_unit,"cse_openWounds"] call cse_fnc_getVariable;
_selection = _openWounds select _bodyPart;
_newAmount = (_selection select _type) + _amount;
if (_newAmount < 0) then {
	_newAmount = 0;
};
_selection set [ _type, _newAmount];
_openWounds set [ _bodyPart , _selection];
[_unit, "cse_openWounds",_openWounds] call cse_fnc_setVariable;

[_unit] call cse_fnc_unitLoop_CMS;