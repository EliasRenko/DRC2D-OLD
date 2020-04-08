package drc.core;

class Promise<T>
{
	public var future:Future<T>
	
	public function new() 
	{
		future = new Future<T>();
	}
}