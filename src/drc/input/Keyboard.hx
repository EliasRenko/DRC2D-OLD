package drc.input;

import drc.core.EventDispacher;
import drc.types.KeyboardEvent;

class Keyboard extends EventDispacher<KeyboardEvent>{

    public function new() {
        
        super();

        //addEventListener(__onKeyDown, 1);

        //addEventListener(__onKeyDown, 2);
    }

    public function startTextInput():Void {
        
    }

    public function stopTextInput():Void {
        
    }

    public function onKeyDown(keycode:Int):Void {
        
        dispatchEvent({key: keycode}, 1);
    }

    public function onKeyUp(keycode:Int):Void {
     
        dispatchEvent({key: keycode}, 2);
    }

    public function onTextInput(text:String):Void {
        
        dispatchEvent({text: text}, 3);
    }

    private function __onKeyDown(key:UInt, type:UInt):Void {

    }

    private function __onKeyUp(key:UInt, type:UInt):Void {

    }
}