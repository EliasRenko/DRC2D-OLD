package drc.backend.native;

import drc.backend.native.NativeDevice;
import sdl.Joystick;

class NativeJoystick extends NativeDevice implements drc.input.Gamepad
{
	//** Publics.
	
	//** Publics.
	
	public var active(get, null):Bool;
	
	public var id(get, null):UInt;
	
	public var index(get, null):UInt;
	
	public var name(get, null):String;
	
	//** Privates.
	
	/** @private **/ private var __active:Bool = false;
	
	/** @private **/ private var __id:Null<UInt>;
	
	/** @private **/ private var __index:UInt;
	
	public function new() 
	{
		
	}
}