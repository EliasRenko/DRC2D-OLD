package drc.core;

class Future<T>
{
	public var error():Dynamic;
	
	public var isComplete():Bool;
	
	public var isError():Bool;
	
	public var value():T;
	
	public function new(work:Void -> T = null, async:Bool = true) 
	{
		if (work == null) return;
		
		if (async)
		{
			var promise:Promise<T>();
			
			promise.future = this;
			
			FutureWork.queue({promise: promise, work: work});
		}
	}
}

private class FutureWork
{
	public static function queue(state:Dynamic = null):Void
	{
		
	}
}