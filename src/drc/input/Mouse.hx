package drc.input;

import drc.core.EventDispacher;

class Mouse extends EventDispacher<Mouse> {

    public var x:Int = 0;

    public var y:Int = 0;

    public var leftClick:Bool = false;

    public function new() {
        
        super();

        //addEventListener(__onButtonDown, 0);

        //addEventListener(__onButtonUp, 1);
    }

    private function __onButtonDown(num:UInt, type:UInt) {
        
        leftClick = true;

        dispatchEvent(this, 1);
    }

    private function __onButtonUp(num:UInt, type:UInt) {
        
        dispatchEvent(this, 2);
    }

    private function __onMotion(x:Int, y:Int) {
        
        this.x = x;

        this.y = y;

        dispatchEvent(this, 3);
    }
}