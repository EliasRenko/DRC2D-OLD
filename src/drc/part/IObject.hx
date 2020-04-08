package;

interface IObject 
{
	//** Publics.
	
	public var active(get, null):Bool;
	
	public var index(get, null):Int;
	
	//** Privates.
	
	/** @private **/ private var __active:Bool;
	
	/** @private **/ private var __passive:Int;
	
	//** Methods.
	
	public function init():Void;
	
	public function release():Void;
	
	//** Getters and setters.
	
	public function get_active():Bool;
	
	public function get_index():Int;
}