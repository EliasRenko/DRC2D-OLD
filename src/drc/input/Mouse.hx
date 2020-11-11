package drc.input;

import drc.core.EventDispacher;

class Mouse extends EventDispacher<UInt> {

    public function new() {
        
        super();

        add(__onButtonDown, 0);

        add(__onButtonUp, 1);
    }

    private function __onButtonDown(num:UInt, type:UInt) {
        

    }

    private function __onButtonUp(num:UInt, type:UInt) {
        
    }
}