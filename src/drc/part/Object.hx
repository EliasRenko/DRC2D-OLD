package drc.part;

import drc.types.ObjectStatus;

class Object
{
	//** Publics.
	
	public var active(get, null):Bool;
	
	public var index(get, null):Int;
	
	public var status(get, null):ObjectStatus;
	
	//** Privates.
	
	/** @private **/ private var __active:Bool = false;
	
	/** @private **/ private var __index:Int = -1;

	/** @private **/ private var __passiveIndex:Int = -1;
	
	/** @private **/ private var __status:ObjectStatus = ObjectStatus.NULL;
	
	//** Methods.
	
	public function init():Void
	{
		
	}
	
	public function release():Void
	{
		
	}
	
	//** Getters and setters.
	
	private function get_active():Bool
	{
		return __active;
	}
	
	private function get_index():Int
	{
		return __index;
	}
	
	private function get_status():ObjectStatus
	{
		return __status;
	}
}