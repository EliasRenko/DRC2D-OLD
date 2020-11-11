package drc.input;

import drc.core.EventDispacher;

class Keyboard extends EventDispacher<UInt>{

    public function new() {
        
        super();

        add(__onKeyDown, 1);

        add(__onKeyDown, 2);
    }

    private function __onKeyDown(key:UInt, type:UInt):Void {

        trace('DOWN!');
    }

    private function __onKeyUp(key:UInt, type:UInt):Void {

    }
}