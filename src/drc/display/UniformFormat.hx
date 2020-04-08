package drc.display;

@:enum abstract UniformFormat(Null<String>)
{
	var FLOAT1 = "float1";
	
	var FLOAT2 = "float2";
	
	var FLOAT3 = "float3";
	
	var FLOAT4 = "float4";
	
	var INT1 = "int1";
	
	var INT2 = "int2";
	
	var INT3 = "int3";
	
	var INT4 = "int4";
	
	var UINT1 = "uint1";
	
	var UINT2 = "uint2";
	
	var UINT3 = "uint3";
	
	var UINT4 = "uint4";
	
	var VEC1 = "vec1";
	
	var VEC2 = "vec2";
	
	var VEC3 = "vec3";
	
	var VEC4 = "vec4";
	
	var MAT4 = "mat4";
	
	@:from private static function fromString(value:String):UniformFormat
	{
		return switch (value)
		{
			case "float1": FLOAT1;
			
			case "float2": FLOAT2;
			
			case "float3": FLOAT3;
			
			case "float4": FLOAT4;
			
			case "uint1": UINT1;
			
			case "uint2": UINT2;
			
			case "uint3": UINT3;
			
			case "uint4": UINT4;
			
			case "vec1": VEC4;
			
			case "vec2": VEC4;
			
			case "vec3": VEC4;
			
			case "vec4": VEC4;
			
			case "mat4": MAT4;
			
			default: VEC4;
		}
	}
	
	@:to private function toString():String
	{
		return switch (cast this : UniformFormat)
		{
			case UniformFormat.FLOAT1: "float1";
			
			case UniformFormat.FLOAT2: "float2";
			
			case UniformFormat.FLOAT3: "float3";
			
			case UniformFormat.FLOAT4: "float4";
			
			case UniformFormat.UINT1: "uint1";
			
			case UniformFormat.UINT2: "uint2";
			
			case UniformFormat.UINT3: "uint3";
			
			case UniformFormat.UINT4: "uint4";
			
			case UniformFormat.VEC1: "vec1";
			
			case UniformFormat.VEC2: "vec2";
			
			case UniformFormat.VEC3: "vec3";
			
			case UniformFormat.VEC4: "vec4";
			
			case UniformFormat.MAT4: "mat4";
			
			default: null;
		}
	}
}
	