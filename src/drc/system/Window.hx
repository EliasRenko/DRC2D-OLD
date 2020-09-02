package drc.system;

import drc.types.WindowEvent;
import drc.core.EventDispacher;
import drc.types.WindowEventType;

interface Window {

	/** Publics. **/
	
	public var fullscreen(get, set):Bool;

	public var height(get, null):Int;
	
	public var onEventHandler:WindowEvent -> Void;

	public var onEvent:EventDispacher<Window>;

	public var x(get, null):Int;

	public var y(get, null):Int;

	public var width(get, null):Int;

	/**  **/

	public function showDialog(title:String, message:String):Void;
	
	public function resize(width:Int, height:Int):Void;

	//** Getters and setters.
	
	private function get_height():Int;
	
	private function get_x():Int;

	private function get_y():Int;

	private function get_width():Int;
}