package drc.backend.native.input;

import drc.input.Device;
import drc.input.Mouse;
import haxe.ds.Vector;

class Mouse extends Device implements drc.input.Mouse
{
	// ** Publics.
	
	public var active(get, null):Bool;
	
	public var doubleClick(get, null):Bool;
	
	public var hasMoved(get, null):Bool;

	// ** Privates.
	
	/** @private **/ private var __active:Bool = false;

	/** @private **/ private var __doubleClick:Bool = false;
	
	/** @private **/ private var __hasMoved:Bool = false;
	
	public function new()
	{
		__checkControls = new Vector(4);
		
		__pressControls = new Array<Int>();
		
		__releaseControls = new Array<Int>();
	}

	public function onMove():Void
	{	
		__hasMoved = true;
	}
	
	public function onButtonPress(control:Int, clicks:Int):Void
	{
		__checkControls[control] = true;
		
		__checkCount ++;
		
		__pressControls[__pressCount ++] = control;
		
		if (clicks > 1)
		{
			__doubleClick = true;
		}
	}
	
	public function onButtonRelease(control:Int):Void
	{
		__checkControls[control] = false;
		
		__checkCount --;
		
		__releaseControls[__releaseCount ++] = control;
	}

	override public function postUpdate():Void
	{
		super.postUpdate();
		
		__doubleClick = false;
		
		__hasMoved = false;
	}
	
	// ** Getters and setters.
	
	private function get_active():Bool
	{
		return true;
	}
	
	private function get_doubleClick():Bool
	{	
		return __doubleClick;
	}

	private function get_hasMoved():Bool
	{	
		return __hasMoved;
	}
}