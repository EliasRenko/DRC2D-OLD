package cont.ui;

@:enum abstract UiEventType(UInt) from UInt to UInt {

	var ANY = 0;
	
	var ON_CLICK = 1;
	
	var ON_FOCUS_GAIN = 2;
	
    var ON_FOCUS_LOST = 3;
    
    var VISIBLE = 4;

    var INVISIBLE = 5;

    var MOUSE_HOVER = 6;

    var MOUSE_ENTER = 7;

    var MOUSE_LEAVE = 8;

    var ON_RIGHT_CLICK = 9;

    var ON_TEXT_INPUT = 10;

    var ON_DRAG_START = 11;

    var ON_DRAG = 12;

    var ON_DRAG_STOP = 13;

    var ON_RESIZE = 13;
}