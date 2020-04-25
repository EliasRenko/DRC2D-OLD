package drc.backend.web.core;

import drc.system.Input;

class Runtime implements drc.core.Runtime {

    // ** Publics.

    public var active(get, null):Bool;

    public var input(get, null):Input;

    public var name(get, null):String;

    // ** Privates.

    private var __active:Bool;

    private var __input:Input;

    private var __name:String;

    private var __window:js.html.CanvasElement;

    public function init():Void {

    }

    public function release():Void {}

    public function pollEvents():Void {}

    public function present() {}

    // **

    private function __initVideo():Void {

        var _gl = null;

        _gl = __window.getContext('webgl');

        if (_gl != null) {

            trace('Context created');
        }
    }

    // ** Getters and setters.

    private function get_active():Bool {

        return __active;
    }

    private function get_input():Input {
        
        return __input;
    }

    private function get_name():String {
        
        return __name;
    }
}