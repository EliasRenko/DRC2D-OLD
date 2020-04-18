package drc.input;

interface Mouse 
{
	//** Publics.
	
	public var active(get, null):Bool;
	
	public var doubleClick(get, null):Bool;
	
	public var hasMoved(get, null):Bool;

	//** Privates.
	
	/** @private **/ private var __active:Bool;

	/** @private **/ private var __hasMoved:Bool;
	
	public function check(control:Int):Bool;
	
	public function pressed(control:Int):Bool;
	
	public function released(control:Int):Bool;
	
	//** Getters and setters.
	
	private function get_active():Bool;
	
	private function get_doubleClick():Bool;

	private function get_hasMoved():Bool;
}

