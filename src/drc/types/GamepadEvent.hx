package drc.types;

typedef GamepadEvent =
{
	var type:GamepadEventType;
	
	var timestamp:Float;
	
	var index:UInt;
	
	var ?data1:Int;
	
	var ?data2:Int;
}