package drc.core;

import drc.input.Keyboard;

interface Runtime {

	//** Publics.
	
	public var active(get, null):Bool;

	public var event(get, null):EventDispacher<Float>;
	
	public var name(get, null):String;

	public var keyboard(get, null):Keyboard;
	
	//** Privates.
	
	/** @private **/ private var __active:Bool;
	
	/** @private **/ private var __name:String;
	
	public function init():Void;
	
	public function release():Void;

	public function getGamepad(index:UInt):Void;
	
	public function pollEvents():Void;
	
	public function present():Void;

	public function requestLoopFrame():Void;
	
	//** Getters and setters.
	
	private function get_active():Bool;

	private function get_event():EventDispacher<Float>;
	
	private function get_name():String;
}