package drc.core;

typedef Listener<T> =
{
	var func:T -> Void;
	
	var priority:UInt;
}

class EventDispacher<T>
{
	//** Publics.
	
	public var active:Bool = true;
	
	//** Privates.
	
	/** @private **/ private var __listeners:Array<Listener<T>> = new Array<Listener<T>>();
	
	public function new()
	{
		
	}
	
	public function add(listener:T -> Void, priority:UInt = 0):Void
	{
		var eventListener:Listener<T> = 
		{
			func: listener,
			
			priority: priority
		}
		
		for (i in 0...__listeners.length) 
		{
			if (priority > __listeners[i].priority)
			{
				__listeners.insert(i, eventListener);
				
				return;
			}
		}
		
		__listeners.push(eventListener);
	}
	
	public function dispatch(value:T):Void
	{
		if (active)
		{
			for (i in 0...__listeners.length) 
			{
				__listeners[i].func(value);
			}
		}
	}
	
	public function has(listener:T -> Void):Bool
	{
		for (i in 0...__listeners.length)
		{
			if (Reflect.compareMethods(__listeners[i].func, listener)) return true;
		}
		
		return false;
	}
	
	public function remove(listener:T -> Void):Void
	{
		for (i in 0...__listeners.length)
		{
			if (Reflect.compareMethods(__listeners[i].func, listener)) 
			{
				__listeners.splice(i, 1);
			}
		}
	}
}