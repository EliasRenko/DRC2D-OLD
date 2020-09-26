package drc.backend.native.core;

import cpp.RawPointer;
import sdl.SysWM.HWND;
import cpp.Int64;
import cpp.Pointer;
import sdl.SysWM.SysWMinfo;
import drc.backend.native.system.Input;
import drc.backend.native.system.Window;
import drc.core.EventDispacher;
import drc.core.Runtime;
import drc.debug.Log;
import glew.GLEW;
import sdl.Event;
import sdl.GameController;
import sdl.Joystick;
import sdl.SDL;
import drc.types.GamepadEvent;
import drc.types.GamepadEventType;
import drc.types.WindowEventType;
import drc.utils.Common;
import drc.utils.Assets;

#if cpp

class Runtime implements drc.core.Runtime
{
	// ** Publics.

	public var active(get, null):Bool;

	public var assets(get, null):Assets;

	public var input(get, null):Input;

	public var name(get, null):String;

	// ** Privates.

	/** @private **/ private var __active:Bool;

	/** @private **/ private var __assets:Assets;

	/** @private **/ private var __input:Input;

	/** @private **/ private var __name:String = 'Native';

	/** @private **/ private var __window:Window;

	public function new()
	{
		Log.print(name);
	}

	public function init():Void
	{
		var _result:Int = 0;
		
		// ** Set SDL hints.
		
		SDL.setHint(SDL_HINT_XINPUT_ENABLED, '0');
		
		// ** Init SDL timer.
		
		_result = (SDL.init(SDL_INIT_TIMER));
		
		#if debug
		
		if (_result == 0)
		{
			Log.print(name + 'timer initiated.');
		}
		else
		{
			throw 'SDL failed to initiate timer: `${SDL.getError()}`';
		}
		
		#end
		
		// ** Init SDL video.
		
		_result = SDL.initSubSystem(SDL_INIT_VIDEO);
		
		#if debug
		
		if (_result == 0)
		{
			Log.print(name + 'video initiated.');
		}
		else
		{
			throw 'SDL failed to initiate video: `${SDL.getError()}`';
		}
		
		#end
		
		__initVideo();
		
		// ** Init SDL controllers.
		
		_result = SDL.initSubSystem(SDL_INIT_GAMECONTROLLER | SDL_INIT_JOYSTICK);
		
		#if debug
		
		if (_result == 0)
		{
			Log.print(name + 'controllers initiated.');
		}
		else
		{
			throw 'SDL failed to initiate controllers: `${SDL.getError()}`';
		}
		
		#end
		
		__assets = new Assets();

		Common.assets = __assets;

		__input = new Input();
		
		Common.input = __input;
		
		__active = true;

		var handle:HWND = getHWND();

		trace(handle);
		trace(RawPointer.addressOf(handle));
	}

	public function getHWND():HWND {

		return SDL.getHWND(__window.innerData);
	}

	public function release():Void
	{
		__active = false;
		
		SDL.quit();
	}

	public function pollEvents():Void
	{
		while (SDL.hasAnEvent())
		{
			var event = SDL.pollEvent();
			
			__handleInputEvent(event);
			
			__handleWindowEvent(event);
			
			if (event.type == SDL_QUIT)
			{
				release();
			}
		}
	}

	public function present():Void
	{
		SDL.GL_SwapWindow(__window.innerData);
	}

	private function __handleInputEvent(event:Event):Void
	{
		var _eventType:GamepadEventType = GamepadEventType.UNKNOWN;
		
		switch (event.type)
		{
			case SDL_JOYDEVICEADDED:
				
				if (!SDL.isGameController(event.jdevice.which))
				{
					var gamepadEvent:GamepadEvent =
					{
						type: GamepadEventType.ADDED,
						
						timestamp: event.window.timestamp,
						
						index: event.cdevice.which,
						
						data1: 0,
						
						data2: 0
					}
					
					var joystick:Joystick = SDL.joystickOpen(event.jdevice.which);
					
					__input.onGamepadConnected(event.jdevice.which, joystick);
				}
				
			case SDL_JOYDEVICEREMOVED:
				
				var gamepadEvent:GamepadEvent =
				{
					type: GamepadEventType.ADDED,
					
					timestamp: event.window.timestamp,
					
					index: event.cdevice.which,
					
					data1: 0,
					
					data2: 0
				}
				
			case SDL_JOYBUTTONDOWN:
				
				_eventType = GamepadEventType.PRESSED;
				
				//trace(event.jbutton.which + " - " + event.jbutton.button);
				//__input.onGamepadButtonDown(event.jbutton.which, event.jbutton.button);
				
			case SDL_JOYBUTTONUP:
				
				_eventType = GamepadEventType.RELEASED;
				
				//__input.onGamepadButtonUp(event.jbutton.which, event.jbutton.button);
				
			case SDL_CONTROLLERDEVICEADDED:
				
				var gamepadEvent:GamepadEvent =
				{
					type: GamepadEventType.ADDED,
					
					timestamp: event.window.timestamp,
					
					index: event.cdevice.which,
					
					data1: 0,
					
					data2: 0
				}
				
				var gamepad:GameController = SDL.gameControllerOpen(event.cdevice.which);
				
				__input.onGamepadConnected(event.cdevice.which, SDL.gameControllerGetJoystick(gamepad));
				
				__input.onGamepadEvent(gamepadEvent);
				
			case SDL_CONTROLLERDEVICEREMOVED:
				
				var gamepadEvent:GamepadEvent =
				{
					type: GamepadEventType.REMOVED,
					
					timestamp: event.window.timestamp,
					
					index: event.cdevice.which,
					
					data1: 0,
					
					data2: 0
				}
				
				__input.onGamepadDisconnected(event.cdevice.which);
				
				__input.onGamepadEvent(gamepadEvent);
				
			case SDL_CONTROLLERAXISMOTION:
				
				var _val:Float = (event.caxis.value+32768) / (32767 + 32768);
				
				var _normalized_val = ( -0.5 + _val) * 2.0;
				
				//trace(event.caxis.which + ' - Axis: ' + event.caxis.axis + ' - Value:' + _normalized_val);
				
			case SDL_CONTROLLERBUTTONDOWN:
				
				var gamepadEvent:GamepadEvent =
				{
					type: GamepadEventType.PRESSED,
					
					timestamp: event.window.timestamp,
					
					index: event.cdevice.which,
					
					data1: 0,
					
					data2: 0
				}
				
				__input.onGamepadButtonDown(event.cbutton.which, event.cbutton.button);
				
				__input.onGamepadEvent(gamepadEvent);
				
				//trace(event.cbutton.which + " - " + event.cbutton.button);
				
			case SDL_CONTROLLERBUTTONUP:
				
				var gamepadEvent:GamepadEvent =
				{
					type: GamepadEventType.RELEASED,
					
					timestamp: event.window.timestamp,
					
					index: event.cdevice.which,
					
					data1: 0,
					
					data2: 0
				}
				
				__input.onGamepadButtonUp(event.cbutton.which, event.cbutton.button);
				
				__input.onGamepadEvent(gamepadEvent);
				
			case SDL_CONTROLLERDEVICEREMAPPED:
				
				_eventType = GamepadEventType.REMAPPED;
				
			case SDL_MOUSEMOTION:
				
				__input.onMouseMotion(event.button.x, event.button.y);
				
			case SDL_MOUSEBUTTONDOWN:
				
				__input.onMouseButtonDown(event.button.button, event.button.clicks);
				
			case SDL_MOUSEBUTTONUP:
				
				__input.onMouseButtonUp(event.button.button);
				
			case SDL_MOUSEWHEEL:
				
				__input.onMouseWheel();
				
			case SDL_KEYDOWN:

				//__input.onKeyboardDown(event.key.keysym.sym);

				__input.onKeyboardDown(event.key.keysym.scancode);
				
			case SDL_KEYUP:
			
				//__input.onKeyboardUp(event.key.keysym.sym);

				__input.onKeyboardUp(event.key.keysym.scancode);

			case SDL_TEXTEDITING:
			
			case SDL_TEXTINPUT:

				__input.onTextInput(event.text.text);
			
			default:
		}
	}

	private function __handleWindowEvent(event:Event):Void
	{
		var data1:Int = event.window.data1;
		
		var data2:Int = event.window.data2;
		
		if (event.type == SDL_WINDOWEVENT)
		{
			var type:WindowEventType = 0;
			
			switch (event.window.event)
			{
				case SDL_WINDOWEVENT_SHOWN:
					
					type = WindowEventType.SHOWN;

					__window.onEventShown(data1, data2);
					
				case SDL_WINDOWEVENT_HIDDEN:
					
					type = WindowEventType.HIDDEN;

					__window.onEventHidden();
					
				case SDL_WINDOWEVENT_EXPOSED:
					
					type = WindowEventType.EXPOSED;
					
					__window.onEventExposed();

				case SDL_WINDOWEVENT_MOVED:
					
					type = WindowEventType.MOVED;

					__window.onEventMoved(data1, data2);
					
				case SDL_WINDOWEVENT_MINIMIZED:
					
					type = WindowEventType.MINIMIZED;
					
				case SDL_WINDOWEVENT_MAXIMIZED:
					
					type = WindowEventType.MAXIMIZED;
					
				case SDL_WINDOWEVENT_RESTORED:
					
					type = WindowEventType.RESTORED;
					
				case SDL_WINDOWEVENT_ENTER:
					
					type = WindowEventType.ENTER;
					
				case SDL_WINDOWEVENT_LEAVE:
					
					type = WindowEventType.LEAVE;
					
				case SDL_WINDOWEVENT_FOCUS_GAINED:
					
					type = WindowEventType.FOCUS_GAINED;
					
				case SDL_WINDOWEVENT_FOCUS_LOST:
					
					type = WindowEventType.FOCUS_LOST;
					
				case SDL_WINDOWEVENT_CLOSE:
					
					type = WindowEventType.CLOSE;
					
					release();
					
				case SDL_WINDOWEVENT_RESIZED:
					
					type = WindowEventType.RESIZED;

					__window.onEventResized();
					
				case SDL_WINDOWEVENT_SIZE_CHANGED:
					
					type = WindowEventType.SIZE_CHANGED;
					
				case SDL_WINDOWEVENT_NONE:
					
				default:
			}
			
			var windowEvent:drc.types.WindowEvent =
			{
				type : type,
				
				timestamp : event.window.timestamp,
				
				data1 : data1,
				
				data2 : data2
			}
			
			//__window.onEvent(windowEvent);
		}
	}

	private function __initVideo():Void
	{
		var _flags:SDLWindowFlags = SDL_WINDOW_SHOWN | SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE;
		
		__window = new Window();
		
		__window.innerData = SDL.createWindow('Director2D', 64, 64, 640, 480, _flags);
		
		Common.window = __window;
		
		if (__window == null)
		{
			throw 'SDL failed to create a window: `${SDL.getError()}`';
		}
		
		SDL.GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_ES);
		
		SDL.GL_SetAttribute(SDL_GL_RED_SIZE, 8);
		SDL.GL_SetAttribute(SDL_GL_GREEN_SIZE, 8);
		SDL.GL_SetAttribute(SDL_GL_BLUE_SIZE, 8);
		SDL.GL_SetAttribute(SDL_GL_ALPHA_SIZE, 8);
		SDL.GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
		SDL.GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);
		SDL.GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 2);
		SDL.GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 0);
		
		SDL.GL_SetSwapInterval(true);
		
		var gl = SDL.GL_CreateContext(__window.innerData);
		
		if (gl.isnull())
		{
			throw 'SDL failed to create a GL context: `${SDL.getError()}`';
		}
		
		//trace(SDL.GL);
		
		SDL.GL_MakeCurrent(__window.innerData, gl);
		
		var _result = GLEW.init();
		
		if (_result != GLEW.OK)
		{
			trace('runtime / sdl / failed to setup created render context, unable to recover / `${GLEW.error(_result)}`');
		}
		else
		{
			trace('sdl / GLEW init / ok');
		}
	}

	//** Getters and setters.

	private function get_active():Bool
	{
		return __active;
	}

	private function get_assets():Assets
	{
		return __assets;
	}

	private function get_input():Input
	{
		return __input;
	}

	private function get_name():String
	{
		return __name;
	}
}

#end