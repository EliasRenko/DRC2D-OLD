package drc.core;

import drc.backend.native.NativeInput;
import drc.system.Input;

interface Runtime 
{
	//** Publics.
	
	public var active(get, null):Bool;
	
	public var input(get, null):Input;
	
	public var name(get, null):String;
	
	//** Privates.
	
	/** @private **/ private var __active:Bool;
	
	/** @private **/ private var __name:String;
	
	public function init():Void;
	
	public function release():Void;
	
	public function pollEvents():Void;
	
	public function present():Void;
	
	//** Getters and setters.
	
	private function get_active():Bool;
	
	private function get_input():Input;
	
	private function get_name():String;
}