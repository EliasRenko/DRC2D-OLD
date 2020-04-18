package drc.backend.native.system;

import drc.backend.native.input.Gamepad;
import drc.core.EventDispacher;

import drc.system.Input;
import drc.types.GamepadEvent;
import sdl.GameController;
import haxe.ds.Vector;
import sdl.Joystick;
import sdl.SDL;

#if cpp

class Input implements drc.system.Input
{
	//** Publics.
	
	public var gamepadEvent:EventDispacher<GamepadEvent> = new EventDispacher<GamepadEvent>();
	
	//** Privates.
	
	/** @private **/ private var __gamepadIndexes:Map<Int, Int>;
	
	/** @private **/ private var __gamepads:Vector<Gamepad>;
	
	public function new() 
	{
		__gamepadIndexes = new Map<Int, Int>();
		
		__gamepads = new Vector<Gamepad>(4);
		
		for (i in 0...4) 
		{
			__gamepads[i] = new Gamepad(i);
		}
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
		trace('Gamepad event: ' + event.type);
		
		gamepadEvent.dispatch(event);
	}
	
	public function onGamepadButtonDown(id:Int, button:Int):Void
	{
		__gamepads[__gamepadIndexes.get(id)].onButtonPress(button);
	}
	
	public function onGamepadButtonUp(id:Int, button:Int):Void
	{
		__gamepads[__gamepadIndexes.get(id)].onButtonRelease(button);
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
	}
}

#end