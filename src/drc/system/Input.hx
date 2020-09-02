package drc.system;

import drc.input.Keyboard;
import drc.core.EventDispacher;
import drc.input.Gamepad;
import drc.input.Mouse;
import drc.types.GamepadEvent;
import drc.types.TextEvent;

interface Input 
{
	//** Publics.
	
	public var gamepadEvent:EventDispacher<GamepadEvent>;

	public var textEvent:EventDispacher<TextEvent>;
	
	public var keyboard(get, null):Keyboard;
	
	public var mouse(get, null):Mouse;
	
	//** Methods.
	
	public function getGamepad(index:UInt):Gamepad;
	
	public function postUpdate():Void;

	public function beginTextInput():Void;

	public function endTextInput():Void;
	
	//** Getters and setters.
	
	private function get_keyboard():Keyboard;
	
	private function get_mouse():Mouse;
}