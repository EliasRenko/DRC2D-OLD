package drc.display;

import drc.display.Attribute;
import drc.display.Program;
import drc.display.Uniform;

class Profile 
{
	//** Publics.
	
	public var attributes:Array<Attribute> = new Array<Attribute>();
	
	public var dataPerVertex:UInt;
	
	public var name(get, null):String;
	
	public var program:Program;
	
	public var uniforms:Array<Uniform> = new Array<Uniform>();
	
	//** Privates.
	
	/** @private **/ private var __name:String;
	
	public function new(name:String) 
	{
		__name = name;
	}
	
	public function addAttribute(attribute:Attribute):Void
	{
		attributes.push(attribute);
	}
	
	public function addUniform(uniform:Uniform):Void
	{
		uniforms.push(uniform);
	}
	
	//** Getters and setters.
	
	private function get_name():String
	{
		return __name;
	}
}