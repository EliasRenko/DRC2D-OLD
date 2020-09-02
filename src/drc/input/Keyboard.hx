package drc.input;

interface Keyboard {

    // ** Publics.

    public var active(get, null):Bool;
    
    // ** Privates.
	
    /** @private **/ private var __active:Bool;
    

    public function check(control:Int):Bool;
	
	public function pressed(control:Int):Bool;
	
    public function released(control:Int):Bool;
    
    // ** Getters and setters.
    
    private function get_active():Bool;
}