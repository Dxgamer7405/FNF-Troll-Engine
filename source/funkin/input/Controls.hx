package funkin.input;

import flixel.FlxG;
import flixel.input.FlxInput;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKeyboard;
import flixel.input.keyboard.FlxKey;

class Controls {
	public var UI_UP(get, never):Bool; inline function get_UI_UP() return get("ui_up", PRESSED);
	public var UI_LEFT(get, never):Bool; inline function get_UI_LEFT() return get("ui_left", PRESSED);
	public var UI_RIGHT(get, never):Bool; inline function get_UI_RIGHT() return get("ui_right", PRESSED);
	public var UI_DOWN(get, never):Bool; inline function get_UI_DOWN() return get("ui_down", PRESSED);

	public var UI_UP_P(get, never):Bool; inline function get_UI_UP_P() return get("ui_up", JUST_PRESSED);
	public var UI_LEFT_P(get, never):Bool; inline function get_UI_LEFT_P() return get("ui_left", JUST_PRESSED);
	public var UI_RIGHT_P(get, never):Bool; inline function get_UI_RIGHT_P() return get("ui_right", JUST_PRESSED);
	public var UI_DOWN_P(get, never):Bool; inline function get_UI_DOWN_P() return get("ui_down", JUST_PRESSED);

	public var UI_UP_R(get, never):Bool; inline function get_UI_UP_R() return get("ui_up", JUST_RELEASED);
	public var UI_LEFT_R(get, never):Bool; inline function get_UI_LEFT_R() return get("ui_left", JUST_RELEASED);
	public var UI_RIGHT_R(get, never):Bool; inline function get_UI_RIGHT_R() return get("ui_right", JUST_RELEASED);
	public var UI_DOWN_R(get, never):Bool; inline function get_UI_DOWN_R() return get("ui_down", JUST_RELEASED);

	public var NOTE_UP(get, never):Bool; inline function get_NOTE_UP() return get("note_up", PRESSED);
	public var NOTE_LEFT(get, never):Bool; inline function get_NOTE_LEFT() return get("note_left", PRESSED);
	public var NOTE_RIGHT(get, never):Bool; inline function get_NOTE_RIGHT() return get("note_right", PRESSED);
	public var NOTE_DOWN(get, never):Bool; inline function get_NOTE_DOWN() return get("note_down", PRESSED);

	public var NOTE_UP_P(get, never):Bool; inline function get_NOTE_UP_P() return get("note_up", JUST_PRESSED);
	public var NOTE_LEFT_P(get, never):Bool; inline function get_NOTE_LEFT_P() return get("note_left", JUST_PRESSED);
	public var NOTE_RIGHT_P(get, never):Bool; inline function get_NOTE_RIGHT_P() return get("note_right", JUST_PRESSED);
	public var NOTE_DOWN_P(get, never):Bool; inline function get_NOTE_DOWN_P() return get("note_down", JUST_PRESSED);

	public var NOTE_UP_R(get, never):Bool; inline function get_NOTE_UP_R() return get("note_up", JUST_RELEASED);
	public var NOTE_LEFT_R(get, never):Bool; inline function get_NOTE_LEFT_R() return get("note_left", JUST_RELEASED);
	public var NOTE_RIGHT_R(get, never):Bool; inline function get_NOTE_RIGHT_R() return get("note_right", JUST_RELEASED);
	public var NOTE_DOWN_R(get, never):Bool; inline function get_NOTE_DOWN_R() return get("note_down", JUST_RELEASED);

	public var ACCEPT(get, never):Bool; inline function get_ACCEPT() return get("accept", JUST_PRESSED);
	public var BACK(get, never):Bool; inline function get_BACK() return get("back", JUST_PRESSED);
	public var PAUSE(get, never):Bool; inline function get_PAUSE() return get("pause", JUST_PRESSED);
	public var RESET(get, never):Bool; inline function get_RESET() return get("reset", JUST_PRESSED);
	
	////
	public static var default_keyBinds:Map<String, Array<FlxKey>> = [
		'note_left' => [A, LEFT],
		'note_down' => [S, DOWN],
		'note_up' => [W, UP],
		'note_right' => [D, RIGHT],
		'dodge' => [SPACE, NONE],
		'ui_left' => [A, LEFT],
		'ui_down' => [S, DOWN],
		'ui_up' => [W, UP],
		'ui_right' => [D, RIGHT],
		'accept' => [SPACE, ENTER],
		'back' => [ESCAPE, BACKSPACE],
		'pause' => [ENTER, ESCAPE],
		'reset' => [R, NONE],
		'volume_mute' => [ZERO, NONE],
		'volume_up' => [NUMPADPLUS, PLUS],
		'volume_down' => [NUMPADMINUS, MINUS],
		'fullscreen' => [F11, NONE],
		'debug_1' => [SEVEN, NONE],
		'debug_2' => [EIGHT, NONE],
		'botplay' => [F8, NONE]
	];

	public static var default_buttonBinds:Map<String, Array<FlxGamepadInputID>> = [
		'note_left' => [X, DPAD_LEFT],
		'note_down' => [A, DPAD_DOWN],
		'note_up' => [Y, DPAD_UP],
		'note_right' => [B, DPAD_RIGHT],
		
		'dodge' => [],

		'pause' => [START],
		'reset' => [],

		'ui_left' => [DPAD_LEFT],
		'ui_down' => [DPAD_DOWN],
		'ui_up' => [DPAD_UP],
		'ui_right' => [DPAD_RIGHT],

		'accept' => [A],
		'back' => [B],
	];

	public static var firstActive:Controls;
	public static var instances:Array<Controls> = [];

	public static function init() {
		firstActive = new Controls(0);
		firstActive.keyboard = FlxG.keys;
		firstActive.gamepad = FlxG.gamepads.getByID(0);
		firstActive.keyBinds = default_keyBinds;
		firstActive.buttonBinds = default_buttonBinds;
		instances[0] = firstActive;

		if (firstActive.gamepad != null)
			trace('Started with controller ${firstActive.gamepad.name}');

		FlxG.gamepads.deviceConnected.add(onGamepadConnected);
		FlxG.gamepads.deviceDisconnected.add(onGamepadDisconnected);
	}

	private static function newControls(id:Int) {
		var controls = new Controls(id);
		controls.keyboard = null;
		controls.gamepad = null;
		controls.keyBinds = default_keyBinds;
		controls.buttonBinds = default_buttonBinds;
		instances[id] = controls;
		return controls;
	}

	private static function onGamepadConnected(gamepad:FlxGamepad) {
		trace("Connected", gamepad.id, gamepad.name);
		var id = gamepad.id;
		var controls = instances[id] ?? newControls(id);
		controls.gamepad = gamepad;
	}

	private static function onGamepadDisconnected(gamepad:FlxGamepad) {
		trace("DISCONNECTED", gamepad.id, gamepad.name);
		var id = gamepad.id;
		var controls = instances[id];
		if (controls != null) controls.gamepad = null;
	}

	public final id:Int;
	public var keyBinds:Map<String, Array<FlxKey>>;
	public var buttonBinds:Map<String, Array<FlxGamepadInputID>>;
	public var keyboard:FlxKeyboard = FlxG.keys;
	public var gamepad:FlxGamepad = null;

	function new(id:Int) {
		this.id = id;
	}

	public function getFirstBind(id:String):Int {
		return true ? keyBinds.get(id)[0] : buttonBinds.get(id)[0];
	}

	public function checkKey(id:String, state:FlxInputState):Bool {
		#if FLX_KEYBOARD
		if (keyboard != null && keyBinds.exists(id)) {
			for (keyCode in keyBinds.get(id)) {
				if(keyCode == NONE)
					continue;

				if (keyboard.checkStatus(keyCode, state)) {
					return true;
				}
			}
		}
		#end
		return false;
	}

	public function checkButton(id:String, state:FlxInputState):Bool {
		#if FLX_GAMEPAD
		if (gamepad != null && gamepad.connected && buttonBinds.exists(id)) {
			for (buttonCode in buttonBinds.get(id)) {
				if (buttonCode == NONE)
					continue;
				
				if (gamepad.checkStatus(buttonCode, state)) {
					return true;
				}
			}
		}
		#end
		return false;
	}

	public inline function get(id:String, state:FlxInputState):Bool {
		return checkKey(id, state) || checkButton(id, state) || checkTouch(id, state);
	}

	private inline function touchStatus(touch:Dynamic, state:FlxInputState):Bool {
		return switch (state) {
			case JUST_PRESSED: touch.justPressed;
			case JUST_RELEASED: touch.justReleased;
			default: touch.pressed;
		};
	}

	private inline function touchInBounds(touch:Dynamic, x:Float, y:Float, w:Float, h:Float):Bool {
		var px = touch.screenX;
		var py = touch.screenY;
		return px >= x && px <= x + w && py >= y && py <= y + h;
	}

	private inline function isGameplayState():Bool {
		return Type.getClassName(Type.getClass(FlxG.state)) == "funkin.states.PlayState";
	}

	public function checkTouch(id:String, state:FlxInputState):Bool {
		#if mobile
		if (FlxG.touches == null || FlxG.touches.list == null || FlxG.touches.list.length <= 0)
			return false;

		var w = FlxG.width;
		var h = FlxG.height;
		var gameplay = isGameplayState();

		for (touch in FlxG.touches.list) {
			if (!touchStatus(touch, state))
				continue;

			if (gameplay) {
				// 4K lane buttons in the lower half of the screen
				var laneH = h * 0.45;
				var laneY = h - laneH;
				var laneW = w / 4;

				if (id == "note_left" && touchInBounds(touch, 0, laneY, laneW, laneH)) return true;
				if (id == "note_down" && touchInBounds(touch, laneW, laneY, laneW, laneH)) return true;
				if (id == "note_up" && touchInBounds(touch, laneW * 2, laneY, laneW, laneH)) return true;
				if (id == "note_right" && touchInBounds(touch, laneW * 3, laneY, laneW, laneH)) return true;

				// Pause button in top-right corner
				if (id == "pause" && touchInBounds(touch, w * 0.84, 0, w * 0.16, h * 0.16)) return true;
			} else {
				// Menu layout: D-Pad on left half + accept/back on right side
				var dpadX = 0.04 * w;
				var dpadY = 0.5 * h;
				var dpadW = 0.42 * w;
				var dpadH = 0.46 * h;
				var centerX = dpadX + dpadW * 0.5;
				var centerY = dpadY + dpadH * 0.5;

				if ((id == "ui_left" || id == "note_left") && touchInBounds(touch, dpadX, centerY - dpadH * 0.2, dpadW * 0.45, dpadH * 0.4)) return true;
				if ((id == "ui_right" || id == "note_right") && touchInBounds(touch, centerX + dpadW * 0.05, centerY - dpadH * 0.2, dpadW * 0.45, dpadH * 0.4)) return true;
				if ((id == "ui_up" || id == "note_up") && touchInBounds(touch, centerX - dpadW * 0.2, dpadY, dpadW * 0.4, dpadH * 0.45)) return true;
				if ((id == "ui_down" || id == "note_down") && touchInBounds(touch, centerX - dpadW * 0.2, centerY + dpadH * 0.05, dpadW * 0.4, dpadH * 0.45)) return true;

				if (id == "accept" && touchInBounds(touch, w * 0.68, h * 0.62, w * 0.28, h * 0.32)) return true;
				if (id == "back" && touchInBounds(touch, w * 0.68, h * 0.28, w * 0.28, h * 0.26)) return true;
			}
		}
		#end

		return false;
	}
}
