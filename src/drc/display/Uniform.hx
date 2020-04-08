package drc.display;

import drc.display.UniformFormat;

class Uniform 
{
	/**
	 * The format of the uniform. Cannot be set.
	 */
	public var format(get, null):UniformFormat;
	
	/**
	 * The name of the uniform. Cannot be set.
	 */
	public var name(get, null):String;
	
	/**
	 * The location of the uniform variable. Cannot be set.
	 */
	public var location(get, null):Int;
	
	//** Privates.
	
	/** @private */ private var __format:UniformFormat;
	
	/** @private */ private var __name:String;
	
	/** @private */ private var __location:Int;
	
	public function new(name:String, format:UniformFormat) 
	{
		__name = name;
		
		__format = format;
	}
	
	public function assignLocation(location:Int):Void
	{
		__location = location;
	}
	
	//** Getters and setters.
	
	private function get_name():String
	{
		return __name;
	}
	
	private function get_format():UniformFormat
	{
		return __format;
	}
	
	private function get_location():Int
	{
		return __location;
	}
}