package drc.backend.web.core;

import js.html.webgl.RenderingContext;
import drc.system.Input;
import drc.backend.web.core.GL;
import drc.core.EventDispacher;
import drc.utils.Common;
import drc.input.Keyboard;

class Runtime implements drc.core.Runtime {

    // ** Publics.

    public var active(get, null):Bool;

    public var event(get, null):EventDispacher<Float>;

    public var input(get, null):Input;

    public var name(get, null):String;

    public var keyboard(get, null):Keyboard;

    // ** Privates.

    /** @private **/ private var __active:Bool;

    /** @private **/ private var __input:Input;

    /** @private **/ private var __name:String = 'Web';

    /** @private **/ private var __window:drc.backend.web.system.Window;

    /** @private **/ private var __event:EventDispacher<Float>;

    /** @private **/ private var __keyboard:BackendKeyboard;

    public function new() {

        __active = true;

        __event = new EventDispacher();

        // ** __gamepads.
    }

    public function init():Void {

        __initVideo();

        __keyboard = new BackendKeyboard();

        if (js.Browser.navigator.getGamepads != null) {

            trace('getGamepads is true');
        }

        if (untyped js.Browser.navigator.webkitGetGamepads != null) {

            trace('webkit getGamepads is true');
        }

        __window.innerData.addEventListener("gamepadconnected", function(gamepad:js.html.Gamepad) {

            trace('Gamepad connected!');
        });

        __window.innerData.addEventListener("gamepaddisconnected", function(event) {

            
        });

        js.Browser.document.addEventListener('keydown', function(keyboardEvent:js.html.KeyboardEvent) {

            __keyboard.dispatch(keyboardEvent.keyCode, 1);
        });

        js.Browser.document.addEventListener('keyup', function(keyboardEvent:js.html.KeyboardEvent) {

        });
    }

    public function release():Void {}

    public function pollEvents():Void {}

    public function present() {}

    // **

    private function __initVideo():Void {

        __window = new drc.backend.web.system.Window();

        __window.innerData = js.Browser.document.createCanvasElement();

        __window.innerData.width = 640;

        __window.innerData.height = 480;

        Common.window = __window;

        js.Browser.document.body.appendChild(__window.innerData);

        var _gl:RenderingContext = null;

        _gl = __window.innerData.getContext('webgl');

        if (_gl != null) {

            trace('Context created');
        }

        _gl.getExtension('OES_element_index_uint');

        GL.gl = _gl;
        
    }

    public function requestLoopFrame():Void {

        js.Browser.window.requestAnimationFrame(__loop);
    }

    private function __loop(timestamp:Float):Void {

        // ** Gamepads poll.



        // **

        __event.dispatch(0, 1);

        js.Browser.window.requestAnimationFrame(__loop);
    }

    public function getGamepad(index:UInt):Void {
        
    }

    // ** Getters and setters.

    private function get_active():Bool {

        return __active;
    }

    private function get_event():EventDispacher<Float> {

		return __event;
	}

    private function get_input():Input {
        
        return __input;
    }

    private function get_name():String {
        
        return __name;
    }

    private function get_keyboard():Keyboard {
		
		return __keyboard;
	}
}

private class BackendKeyboard extends Keyboard {

    public function new() {
        
        super();
    }
}