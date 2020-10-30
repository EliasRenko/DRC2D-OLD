package drc.backend.web.core;

import js.html.webgl.RenderingContext;
import drc.system.Input;
import drc.backend.web.core.GL;
import drc.core.EventDispacher;
import drc.utils.Common;

#if js

class Runtime implements drc.core.Runtime {

    // ** Publics.

    public var active(get, null):Bool;

    public var event(get, null):EventDispacher<Float>;

    public var input(get, null):Input;

    public var name(get, null):String;

    // ** Privates.

    private var __active:Bool;

    private var __input:Input;

    private var __name:String;

    private var __window:drc.backend.web.system.Window;

    //private var __window:js.html.CanvasElement;

    /** @private **/ private var __event:EventDispacher<Float>;

    public function new() {

        __active = true;

        __event = new EventDispacher();
    }

    public function init():Void {

        __initVideo();
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

        __event.dispatch(0, 1);

        js.Browser.window.requestAnimationFrame(__loop);
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
}

#end