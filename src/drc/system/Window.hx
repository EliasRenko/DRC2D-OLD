package drc.system;

import drc.types.WindowEvent;

interface Window {

	/** Publics. **/
	
	public var height(get, null):Int;
	
	public var onEventHandler:WindowEvent -> Void;

	public var width(get, null):Int;

	/**  **/

	public function showDialog(title:String, message:String):Void;
	
	//** Getters and setters.
	
	public function get_height():Int;
	
	public function get_width():Int;
}