package drc.utils;

import haxe.io.UInt8Array;
import drc.buffers.Uint8Array;
#if cpp

import sys.io.File;
import drc.display.Region;
import drc.display.Tileset;
import stb.TrueType.StbBakedFont;
import drc.backend.native.data.Texture;
import sys.FileSystem;
import stb.Image.StbImageData;
import drc.data.Profile;
import opengl.WebGL;
import sdl.SDL;
import drc.debug.Log;
import sdl.RWops;
import haxe.io.Bytes;
//import haxe.io.UInt8Array;
import drc.display.Program;
import haxe.Json;
import drc.display.AttributeFormat;
import drc.display.Attribute;
import drc.display.Uniform;
import drc.display.UniformFormat;
import drc.display.Vertex;

typedef FileHandle = sdl.RWops;

@:enum abstract FileSeek(Int) from Int to Int {
	
    var set = 0;
	
    var cur = 1;
	
    var end = 2;
}

class Resources
{
	public static function path():String
	{
		var path = SDL.getBasePath();
		
        if (path == null)
		{
			path = '';
			
			Log.print(SDL.getError());
		}
		
        return path;
	}

	public static function getDirectory(path:String):Array<String> {

		if (FileSystem.exists(SDL.getBasePath() + '/' + path)) {

			return FileSystem.readDirectory(SDL.getBasePath() + '/' + path);
		}

		return null;
	}

	public static function getJson(path:String):Dynamic {
		
		if (FileSystem.exists(SDL.getBasePath() + '/' + path)) {

			return Json.parse(loadText(path));
		}

		return null;
	}

	public static function saveText(path:String, text:String):Void {

		File.saveContent(SDL.getBasePath() + '/' + path, text);
	}
	
	public static function handle(path:String, ?mode:String = "rb"):FileHandle
	{
		//var p = path();
		
		return SDL.RWFromFile(SDL.getBasePath() + path, mode);
	}
	
	public static function loadBytes(path:String):Bytes
	{
		var mode:String = 'rb';
		
		var file:RWops = SDL.RWFromFile(SDL.getBasePath() + path, mode);
		
		var size:Int = 0;
		
		var _cur = file_tell(file);
		
        file_seek(file, 0, FileSeek.end);
		
        size = file_tell(file);
		
        file_seek(file, _cur, FileSeek.set);
		
		var dest:UInt8Array = new UInt8Array(size);
		
		if (size != 0)
		{
			//file_read(_file, _dest, _dest.length, 1);
			
			SDL.RWread(file, dest.getData().bytes.getData(), size, 1);
		}
		
		SDL.RWclose(file);
		
		return dest.getData().bytes;
	}
	
	public static function loadText(path:String):String
	{
		var bytes:Bytes = loadBytes(path);
		
		return bytes.toString();
	}

	public static function loadTileset(path:String):Tileset
	{
		//** Create a new tileset class.
		
		var tileset:Tileset = new Tileset();
		
		var regions:Array<Region>;
		
		//** Parse the requested profile source file.
		
		var data:Dynamic = Json.parse(loadText(path));
		
		#if debug // ------
		
		//** Parse the name.
		
		var name:String = data.name;
		
		#end // ------
		
		if (Reflect.hasField(data, "regions"))
		{
			var regionsData:Dynamic = Reflect.field(data, "regions");
			
			regions = new Array<Region>();
			
			for (i in 0...regionsData.length)
			{
				var region:Region =
				{
					values: regionsData[i].dimensions
				}

				regions[regionsData[i].id] = region;
			}
			
			tileset.upload(regions);
		}
		
		#if debug // ------
		
		else 
		{
			throw "Tileset: " + name + " has no regions attached.";
		}
		
		#end // ------
		
		// ** Return.
		
		return tileset;
	}

	public static function loadFont(path:String):Texture {
		
		var _texture:Texture;

		var _data:StbImageData;

		if (FileSystem.exists(SDL.getBasePath() + path)) {

			_data = stb.Image.load(SDL.getBasePath() + path, 0);
		}
		else {

			_data = stb.Image.load(SDL.getBasePath() + 'res/graphics/grid_mt.png', 0);
		}

		//_texture = new Texture(UInt8Array.fromBytes(Bytes.ofData(_data.bytes)), _data.comp, _data.w, _data.h);

		_texture = new Texture(UInt8Array.fromBytes(Bytes.ofData(_data.bytes)), _data.comp, _data.w, _data.h);

		//_texture.uploadFont(_data.w, _data.h, _data.bytes);


		
		//_texture.upload(_data.bytes, _data.w, _data.h);

		return _texture;
	}
	
	public static function loadTexture(path:String):Texture {
		
		var _texture:Texture;

		var _data:StbImageData;

		if (FileSystem.exists(SDL.getBasePath() + path)) {

			_data = stb.Image.load(SDL.getBasePath() + path, 0);
		}
		else {

			_data = stb.Image.load(SDL.getBasePath() + 'res/graphics/grid_mt.png', 0);
		}

		//trace('COMP:' + _data.comp);

		//Uint8Array.fromBytes(Bytes.ofData

		_texture = new Texture(UInt8Array.fromBytes(Bytes.ofData(_data.bytes)), _data.comp, _data.w, _data.h);

		return _texture;
	}

	//public static function loadProfile(path:String):Profile
	//{
		//var profileData:Json = new Json(loadText(path));
		//
		//var profile:Profile = new Profile(profileData.field('name'));
		//
		//trace(profileData.field('attributes').name);
		//
		//return profile;
	//}
	
	public static function getProfile(path:String):Profile
	{
		#if cpp
		
		//** Parse the requested profile source file.
		
		var data:Dynamic = Json.parse(loadText(path));
		
		//** Create a new profile class.
		
		var profile:Profile = new Profile(data.name);
		
		//** Create a new vertex shader string.
		
		var vertexShader:String = "#version 300 es";
		
		var fragmentShader:String = "";
		
		var vertexShaderInTypes:String = "";
		
		var vertexShaderOutTypes:String = "";
		
		var vertexShaderUniforms:String = "";
		
		var vertexShaderBodyPart:String = "";
		
		var offset:Int = 0;
		
		var attributeLocation = 0;
		
		var dataPerVertex:UInt = 0;
		
		var structPos:Int = 0;

		//** If data has a filed called "atttribues"...
		
		if (Reflect.hasField(data, "attributes"))
		{
			var attributeData:Dynamic = Reflect.field(data, "attributes");
			
			for (count in 0...attributeData.length)
			{
				var f:AttributeFormat;
				
				switch (attributeData[count].format) 
				{
					case "vec2":
						
						f = AttributeFormat.VEC2;
						
					case "vec3":
						
						f = AttributeFormat.VEC3;
						
					case "vec4":
						
						f = AttributeFormat.VEC4;
						
					default:
						
						f = null;
				}

				var struct:Array<Vertex> = new Array<Vertex>();
				
				var structData:Dynamic = Reflect.field(attributeData[count], "struct");

				for (i in 0...structData.length) {

					var s:drc.display.Vertex = 
					{
						name: structData[i].name,

						position: structPos
					}

					struct.push(s);

					structPos ++;
				}

				profile.dataPerVertex = structPos;

				var attribute:Attribute = new Attribute(attributeData[count].name, f, offset, struct);
				
				profile.addAttribute(attribute);
				
				var name:String = attributeData[count].name;
				
				var format:String = attributeData[count].format;

				var varying:Bool = attributeData[count].varying;
				
				vertexShaderInTypes += "attribute " + format + " " + name + ";\n";
				
				//trace('varying: ' + varying);

				if (varying) {
					
					vertexShaderOutTypes += "varying " + format + " out_" + name + ";\n";
				
					vertexShaderBodyPart += "out_" + name + " = " + name + ";\n";
				}
			}
		}
		
		#if debug // ------
		
		else 
		{
			throw "Profile: " + profile.name + " has no field with name 'constants'.";
		}
		
		#end // ------
		
		//profile.addUniform(new Uniform("matrix", UniformFormat.MAT4));
		
		//vertexShaderUniforms += "uniform mat4 matrix;\n";
		
		if (Reflect.hasField(data, "uniforms"))
		{
			var uniformData:Dynamic = Reflect.field(data, "uniforms");
			
			for (uniformCount in 0...uniformData.length)
			{
				var uniform:Uniform = new Uniform(uniformData[uniformCount].name, uniformData[uniformCount].format);
				
				profile.addUniform(new Uniform(uniformData[uniformCount].name, uniformData[uniformCount].format));
				
				var name:String = uniformData[uniformCount].name;
				
				var format:String = uniformData[uniformCount].format;
				
				vertexShaderUniforms += "uniform " + format + " " + name + ";\n";
			}
		}

		var textures:Array<String> = new Array<String>();

		if (Reflect.hasField(data, "textures")) {

			var textureData:Dynamic = Reflect.field(data, "textures");

			for (textureCount in 0...textureData.length) {

				profile.textures[textureCount] = 
				{
					name: textureData[textureCount].name,

					format: textureData[textureCount].format
				}
			}
		}
		
		vertexShader = vertexShaderInTypes + vertexShaderOutTypes + vertexShaderUniforms;
		
		vertexShader += "\nvoid main(void) \n{\n";
		
		vertexShader += vertexShaderBodyPart;
		
		vertexShader += "gl_Position = matrix * vec4(location.xyz, 1);\n}";
		
		if (Reflect.hasField(data, "fragmentShader"))
		{	
			fragmentShader = loadText("res/shaders/" + Reflect.field(data, "fragmentShader"));
		}
		
		#if debug // ------
		
		else 
		{
			throw "Profile: " + profile.name + " has no fragment shader attached.";
		}
		
		#end // ------
		
		//trace(vertexShader);
		//trace(fragmentShader);
		
		var vShader = WebGL.createShader(WebGL.VERTEX_SHADER);
		
		WebGL.shaderSource(vShader, vertexShader);
		WebGL.compileShader(vShader);
		
		var fShader = WebGL.createShader(WebGL.FRAGMENT_SHADER);
		
		WebGL.shaderSource(fShader, fragmentShader);
		WebGL.compileShader(fShader);
		
		var glProgram = WebGL.createProgram();
		
		var program:Program = new Program(glProgram);
		
		var location:Int = 0;
		
		for (attributeCount in 0...profile.attributes.length) 
		{
			WebGL.bindAttribLocation(glProgram, location, profile.attributes[attributeCount].name);
			
			profile.attributes[attributeCount].assignLocation(location);
			
			location ++;
		}
		
		WebGL.attachShader(program.innerData, vShader);
		
		WebGL.attachShader(program.innerData, fShader);
		
		WebGL.linkProgram(program.innerData);
		
		if (WebGL.getProgramParameter(glProgram, WebGL.LINK_STATUS) == 0) {
			

			throw "Unable to link the shader program: " + WebGL.getProgramInfoLog(glProgram);
        }

		for (uniformCount in 0...profile.uniforms.length) 
		{
			var location:Int = WebGL.getUniformLocation(glProgram, profile.uniforms[uniformCount].name);

			profile.uniforms[uniformCount].assignLocation(location);
			
			#if debug // ------
			
			#end // ------
		}

		for (textureCount in 0...profile.textures.length) {

			var location:Int = WebGL.getUniformLocation(glProgram, profile.textures[textureCount].name);

			trace('Tex loc: ' + location);
		}

		profile.program = program;
		
		return profile;
		
		#end
		
		return null;
	}
	
	public static function data_load(path:String, ?mode:String = "rb"):String
	{
		trace(SDL.getBasePath() + path);
		
		var _file = SDL.RWFromFile(SDL.getBasePath() + path, mode);
		
		var _size = file_size(_file);
		
		var _dest:UInt8Array = new UInt8Array(_size);
		
		if(_size != 0) {
            file_read(_file, _dest, _dest.length, 1);
        }

            //close+release the file handle
        file_close(_file);
	
		
		
        
		
		//SDL.RWread(file, s, s.length, 1);
		
		//File.
		
		//return _dest.toBytes().toString();
		
		return _dest.getData().bytes.toString();
	}
	
	public static function write():Void
	{
		
	}
	
	public static function file_size(handle:FileHandle) : UInt
	 {

        var _cur = file_tell(handle);
		
        file_seek(handle, 0, FileSeek.end);
		
        var _size = file_tell(handle);
		
        file_seek(handle, _cur, FileSeek.set);
		
        return _size;

    } //file_size
	
		public static function file_seek(file:FileHandle, offset:Int, whence:Int) : Int {
        
        //assertnull(file);

        return SDL.RWseek(file, offset, whence);

    } //file_seek

		public static function file_tell(file:FileHandle) : Int {

        //assertnull(file);

        return SDL.RWtell(file);

    } //file_tell
	
			public static function file_close(file:FileHandle) : Int {

       
        return SDL.RWclose(file);

    } //file_close
	
	public static function file_read(file:FileHandle , dest:UInt8Array, size:Int, maxnum:Int) : Int {

        //assertnull(file);

		var d = dest.getData().bytes.getData();
		
        return SDL.RWread(file, d, size, maxnum);

    } //file_read
}

#end