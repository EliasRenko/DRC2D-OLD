package drc.display;

import drc.math.Matrix;
import drc.core.Context;
import drc.display.Drawable;
import drc.data.Profile;
import drc.data.Texture;
import drc.utils.Common;
import opengl.WebGL;
import drc.buffers.Float32Array;
import drc.utils.Resources;

class Stage extends Drawable
{
	/** Publics. **/

	public var drawCalls(get, null):UInt = 0;

	/** Privates. **/

	/** @private **/ private var __drawCalls:UInt = 0;

	/** @private **/private var __context:Context;

	public function new(profile:Profile) 
	{
		super(profile);
		
		__context = Common.context;

		vertices.insert(profile.dataPerVertex * 3, 0);
		
		width = 640;
		
		height = 480;

		//x = -1;

		//y = 1;
		
		textures = new Array<Texture>();

		textures[0] = new drc.backend.native.data.Texture();

		textures[0].create(640, 480);

		vertices.upload(
		[
			0, 0, 0, 0, 1,
			
			0, 480, 0, 0, 0,
			
			640, 480, 0, 1, 0,
			
			640, 0, 0, 1, 1
		]);
		
		vertices.upload(
		[0, 0, 0, 0, 1, 
		0, 960, 0, 0, -1,  
		1280, 0, 0, 2, 1]);
		
		indices.upload([0, 1, 2, 0, 2, 3]);
		
		__verticesToRender = 4;
		
		__indicesToRender = 6;

		matrix = matrix.createOrthoMatrix(0, 640, 480, 0, 1000, -1000);
	}

	public function setToDraw():Void {
		
		__context.setRenderToTexture(textures[0]);

		renderToTexture = true;

		__context.clear(0.2, 0, 0.3, 1);
	}

	public function present():Void {

		renderToTexture = false;

		__context.setViewport(0, 0, 640, 480);

		__drawTriangles(this, matrix);
	}

	public function draw(image:Drawable, matrix:Matrix):Void {
		
		__drawCalls ++;

		__drawTriangles(image, matrix);
	}

	var projection:Float32Array;

	var renderToTexture:Bool = false;

	private function __drawTriangles(img:Drawable, matrix:Matrix):Void {
		
		__context.generateVertexBuffer();
		
		__context.loadVertexBuffer(img.vertices.innerData);
		
		__context.generateIndexBuffer();
		
		__context.loadIndexBuffer(img.indices.innerData);
		
		WebGL.enable(WebGL.DEPTH_TEST);
		
		var projection:Matrix = matrix;

		//var projection:Matrix = img.matrix.createOrthoMatrix(0, 640, 480, 0, 1000, -1000);

		//img.matrix[12] = img.x;

		//img.matrix[13] = img.y;

		//projection.append(matrix);

		WebGL.useProgram(img.profile.program.innerData);
		
		var loc = WebGL.getUniformLocation(img.profile.program.innerData, "matrix");

		WebGL.uniformMatrix4fv(loc, false, projection);
		
		__context.generateVertexBuffer();
		
		var offset:Int = 0;
		
		for (i in 0...img.profile.attributes.length) {

			__context.setAttributePointer(img.profile.attributes[i].offset, img.profile.attributes[i].format, false, 5 * Float32Array.BYTES_PER_ELEMENT, offset * Float32Array.BYTES_PER_ELEMENT);
			
			offset += img.profile.attributes[i].format;
		}

		offset = 1;

		for (i in 0...img.textures.length) {

			WebGL.activeTexture(WebGL.TEXTURE0);

			WebGL.bindTexture(WebGL.TEXTURE_2D, img.textures[i].glTexture);
		}

		
		__context.setSamplerState();

		__context.setBlendFactors();

		__context.generateIndexBuffer();
		
		if (renderToTexture) {

			//__context.bindFrameBuffer();
		}

		__context.drawElements(0, img.__indicesToRender);

		WebGL.bindTexture(WebGL.TEXTURE_2D, null);
	}

	//** Getters and setters. **/

	private function get_drawCalls():UInt
	{
		return __drawCalls;
	}
	
	override function set_height(value:Float):Float
	{
		vertices.innerData[shadings["y"].positions[0]] = 0 - (originY * 2);
		
		vertices.innerData[shadings["y"].positions[1]] = 2 * (value - originY);
		
		vertices.innerData[shadings["y"].positions[2]] = 0 - (originY * 2);
		
		return super.set_height(value);
	}
	
	override function set_originX(value:Float):Float 
	{
		super.set_originX(value);
		
		width = __width;
		
		return __originX;
	}
	
	override function set_originY(value:Float):Float 
	{
		super.set_originY(value);
		
		height = __height;
		
		return __originY;
	}
	
	override function set_width(value:Float):Float
	{
		vertices.innerData[shadings["x"].positions[0]] = 0 - (originX * 2);
		
		vertices.innerData[shadings["x"].positions[1]] = 0 - (originX * 2);
		
		vertices.innerData[shadings["x"].positions[2]] = 2 * (value - originX);
		
		return super.set_width(value);
	}
}