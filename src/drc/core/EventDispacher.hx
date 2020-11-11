package drc.core;

typedef Listener<T> = {
	
	var func:T -> Int -> Void;
	
	var type:UInt;

	var priority:UInt;
}

class EventDispacher<T> {
	
	// ** Publics.
	
	public var active:Bool = true;

	public var count(get, null):Int;
	
	// ** Privates.
	
	/** @private **/ private var __listeners:Array<Listener<T>> = new Array<Listener<T>>();
	
	public function new() {}
	
	public function add(listener:T -> UInt -> Void, type:UInt = 0, priority:UInt = 0):Void {

		var eventListener:Listener<T> = {

			func: listener,

			type: type,
			
			priority: priority
		}
		
		for (i in 0...__listeners.length) {

			if (priority > __listeners[i].priority) {

				__listeners.insert(i, eventListener);
				
				return;
			}
		}
		
		__listeners.push(eventListener);
	}
	
	public function dispatch(value:T, type:UInt = 0):Void {

		if (active) {

			for (i in 0...__listeners.length) {

				if (__listeners[i].type == type || __listeners[i].type == 0) {

					__listeners[i].func(value, type);
				}
			}
		}
	}
	
	public function has(listener:T -> UInt -> Void):Bool {

		for (i in 0...__listeners.length) {

			if (Reflect.compareMethods(__listeners[i].func, listener)) return true;
		}
		
		return false;
	}
	
	public function remove(listener:T -> UInt -> Void):Void {

		// for (i in 0...__listeners.length) {

		// 	if (Reflect.compareMethods(__listeners[i].func, listener)) {

		// 		__listeners.splice(i, 1);
		// 	}
		// }

		var i:Int = __listeners.length - 1;

		while (i > -1) {

			if (Reflect.compareMethods(__listeners[i].func, listener)) {

				__listeners.splice(i, 1);
			}

			i --;
		}
	}

	// ** Getters and setters.

	private function get_count():Int {
		
		return __listeners.length;
	}
}