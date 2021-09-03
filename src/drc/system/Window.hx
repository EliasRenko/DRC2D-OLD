package drc.system;

import drc.types.WindowEvent;
import drc.core.EventDispacher;
import drc.types.WindowEventType;

class Window extends EventDispacher<Window> {

	/** Publics. **/
	
	public var fullscreen(get, set):Bool;

	public var height(get, null):Int;

	public var x(get, null):Int;

	public var y(get, null):Int;

	public var width(get, null):Int;

	public function new() {
		
		super();
	}

	public function showDialog(title:String, message:String):Void {};
	
	public function resize(width:Int, height:Int):Void {}

	//** Getters and setters.
	
	private function get_fullscreen():Bool {

		return false;
	}

	private function set_fullscreen(value:Bool):Bool {

		return false;
	}

	private function get_height():Int {

		return 0;
	}
	
	private function get_x():Int {

		return 0;
	}

	private function get_y():Int {

		return 0;
	}

	private function get_width():Int { 

		return 0;
	}
}