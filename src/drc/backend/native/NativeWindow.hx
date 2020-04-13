package drc.backend.native;

import sdl.Window;
import drc.types.WindowEvent;
import sdl.SDL;
import drc.debug.Log;

#if cpp

class NativeWindow implements drc.system.Window
{
	/** Publics. **/
	
	public var innerData:sdl.Window;
	
	public var height(get, null):Int;

	public var onEventHandler:WindowEvent -> Void;
	
	public var width(get, null):Int;
	
	/** Privates. **/
	
	/**  **/

	public function new() {
		
	}
	
	public function showDialog(title:String, message:String):Void {
		
		SDL.showSimpleMessageBox(SDL_MESSAGEBOX_ERROR, title, message, innerData);
	}

	public function onEvent(event:WindowEvent):Void {

		if (onEventHandler == null)
		{
			return;
		}
		
		onEventHandler(event);
	}
	
	//** Getters and setters.
	
	public function get_height():Int {

		var size:SDLSize = {w:0, h:0};
		
		SDL.getWindowSize(innerData, size);
		
		return size.h;
	}
	
	public function get_width():Int {

		var size:SDLSize = {w:0, h:0};
		
		SDL.getWindowSize(innerData, size);
		
		return size.w;
	}
}

#end