package drc.system;

import drc.types.WindowEvent;

interface Window 
{
	//** Publics.
	
	public var height(get, null):Int;
	
	public var onEventHandler:WindowEvent -> Void;
	
	public var width(get, null):Int;
	
	//** Getters and setters.
	
	public function get_height():Int;
	
	public function get_width():Int;
}