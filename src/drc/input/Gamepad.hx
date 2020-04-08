package drc.input;

interface Gamepad 
{
	//** Publics.
	
	public var active(get, null):Bool;
	
	public var id(get, null):UInt;
	
	public var index(get, null):UInt;
	
	public var name(get, null):String;
	
	//** Privates.
	
	/** @private **/ private var __active:Bool;
	
	public function check(control:Int):Bool;
	
	public function pressed(control:Int):Bool;
	
	public function released(control:Int):Bool;
	
	//** Getters and setters.
	
	private function get_active():Bool;
	
	private function get_id():UInt;
	
	private function get_index():UInt;
	
	private function get_name():String;
}