package drc.backend.native.system;

import drc.backend.native.input.Keyboard;
import drc.backend.native.input.Gamepad;
import drc.core.EventDispacher;
import drc.input.Mouse;
import drc.system.Input;
import drc.types.GamepadEvent;
import haxe.ds.Vector;
import sdl.Joystick;
import sdl.SDL;
import drc.types.TextEvent;

#if cpp

class Input implements drc.system.Input
{
	// ** Publics.
	
	/**
	 * 
	 */
	public var gamepadEvent:EventDispacher<GamepadEvent> = new EventDispacher<GamepadEvent>();
	
	public var textEvent:EventDispacher<TextEvent> = new EventDispacher<TextEvent>();

	/**
	 * 
	 */
	public var mouse(get, null):Mouse;

	public var keyboard(get, null):Keyboard;
	
	// ** Privates.
	
	/** @private **/ private var __gamepadIndexes:Map<Int, Int>;

	/** @private **/ private var __gamepads:Vector<Gamepad>;

	/** @private **/ private var __mouse:drc.backend.native.input.Mouse;

	/** @private **/ private var __keyboard:drc.backend.native.input.Keyboard;
	
	public function new() 
	{
		__gamepadIndexes = new Map<Int, Int>();
		
		__gamepads = new Vector<Gamepad>(4);
		
		for (i in 0...4) 
		{
			__gamepads[i] = new Gamepad(i);
		}
		
		__mouse = new drc.backend.native.input.Mouse();

		__keyboard = new drc.backend.native.input.Keyboard();
	}
	
	public function getGamepad(index:UInt):Gamepad
	{
		return __gamepads[index];
	}
	
	public function onGamepadConnected(index:Int, joystick:Joystick):Void
	{
		__gamepadIndexes.set(__gamepads[index].open(joystick), index);
	}
	
	public function onGamepadDisconnected(id:Int):Void
	{	
		__gamepads[__gamepadIndexes.get(id)].close();
		
		__gamepadIndexes.remove(id);
	}
	
	public function onGamepadEvent(event:GamepadEvent):Void
	{
		//trace('Gamepad event: ' + event.type);
		
		//gamepadEvent.dispatch(event);
	}
	
	public function onGamepadButtonDown(id:Int, button:Int):Void
	{
		__gamepads[__gamepadIndexes.get(id)].onButtonPress(button);
	}
	
	public function onGamepadButtonUp(id:Int, button:Int):Void
	{
		__gamepads[__gamepadIndexes.get(id)].onButtonRelease(button);
	}
	
	public function onMouseEvent():Void
	{
		
	}
	
	public function onMouseMotion(x:Int, y:Int):Void 
	{
		__mouse.onMove(x, y);
	}

	public function onMouseButtonDown(button:Int, clicks:Int):Void
	{
		__mouse.onButtonPress(button, clicks);
	}

	public function onMouseButtonUp(button:Int):Void
	{
		__mouse.onButtonRelease(button);
	}

	public function onMouseWheel():Void
	{
		
	}

	public function onKeyboardDown(button:Int):Void {

		trace(button);

		__keyboard.onButtonPress(button);
	}

	public function onKeyboardUp(button:Int):Void {
		
		__keyboard.onButtonRelease(button);
	}

	public function beginTextInput():Void
	{
		SDL.startTextInput();
	}

	public function endTextInput():Void
	{
		SDL.stopTextInput();
	}

	public function onTextInput(char:String):Void
	{
		var _textEvent:TextEvent = 
		{
			data: char,

			timestamp: 0
		};

		textEvent.dispatch(_textEvent);
	}

	public function postUpdate():Void
	{
		for (i in 0...__gamepads.length) 
		{
			if (__gamepads[i].active)
			{
				__gamepads[i].postUpdate();
			}
		}
		
		__mouse.postUpdate();

		__keyboard.postUpdate();
	}

	// ** Getters and setters.

	private function get_mouse():Mouse {

		return __mouse;
	}

	private function get_keyboard():Keyboard {

		return __keyboard;
	}
}

#end