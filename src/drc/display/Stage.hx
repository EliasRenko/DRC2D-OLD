package drc.display;

import drc.math.Matrix;
import drc.core.Context;
import drc.display.Drawable;
import drc.data.Profile;
import drc.data.Texture;
import drc.utils.Common;
import drc.core.GL in WebGL;
import haxe.io.Float32Array;
import drc.utils.Resources;

class Stage extends Drawable {

	// ** Publics.

	public var drawCalls(get, null):UInt = 0;

	// ** Privates.

	/** @private **/ private var __drawCalls:UInt = 0;

	/** @private **/ private var __context:Context;

	public function new(profile:Profile) 
	{
		super(profile);
		
		__context = Common.context;

		vertices.insert(profile.dataPerVertex * 3, 0);
		
		width = 640;
		
		height = 480;

		textures = new Array<Texture>();

		textures[0] = new drc.backend.native.data.Texture();

		textures[0].create(640, 480);
		
		vertices.upload(
		[0, 0, 0, 0, 1, 
		0, 960, 0, 0, -1,  
		1280, 0, 0, 2, 1]);
		
		indices.upload([0, 1, 2, 0, 2, 3]);
		
		setUV(0, 1, 2, -1);

		__verticesToRender = 3;
		
		__indicesToRender = 3;

		matrix = matrix.createOrthoMatrix(0, 640, 480, 0, 1000, -1000);

		WebGL.enable(WebGL.DEPTH_TEST);
	}

	public function resize(width:Int, height:Int) {
		
		this.width = width;

		this.height = height;

		textures[0].create(width, height);

		matrix = matrix.createOrthoMatrix(0, width, height, 0, 1000, -1000);
	}

	public function setToDraw():Void {
		
		__context.setRenderToTexture(textures[0]);

		__context.clear(0.3, 0, 0.2, 1);
	}

	public function present():Void {

		if (__shouldTransform) {

			__shouldTransform = false;
		}

		__context.setViewport(0, 0, Std.int(width), Std.int(height));

		__drawTriangles(this, matrix);
	}

	override function setUV(x:Float, y:Float, width:Float, height:Float) {

		vertices.innerData[shadings["u"].positions[0]] = x;
		
		vertices.innerData[shadings["u"].positions[1]] = x;
		
		vertices.innerData[shadings["u"].positions[2]] = width;
		
		vertices.innerData[shadings["v"].positions[0]] = y;
		
		vertices.innerData[shadings["v"].positions[1]] = height;
		
		vertices.innerData[shadings["v"].positions[2]] = y;
	}

	public function draw(image:Drawable, matrix:Matrix):Void {
		
		__drawCalls ++;

		__drawTriangles(image, matrix);
	}

	private function __drawTriangles(drawable:Drawable, matrix:Matrix):Void {
		
		__context.generateVertexBuffer();
		
		__context.loadVertexBuffer(drawable.vertices.innerData);
		
		__context.generateIndexBuffer();
		
		__context.loadIndexBuffer(drawable.indices.innerData);
		
		WebGL.depthFunc(WebGL.LESS);

		WebGL.useProgram(drawable.profile.program.innerData);
		
		var matrixLocation = WebGL.getUniformLocation(drawable.profile.program.innerData, "matrix");

		WebGL.uniformMatrix4fv(matrixLocation, false, matrix.getData());

		__context.generateVertexBuffer();
		
		var offset:Int = 0;
		
		for (i in 0...drawable.profile.attributes.length) {

			__context.setAttributePointer(drawable.profile.attributes[i].offset, drawable.profile.attributes[i].format, false,  drawable.profile.dataPerVertex * Float32Array.BYTES_PER_ELEMENT, offset * Float32Array.BYTES_PER_ELEMENT);
			
			offset += drawable.profile.attributes[i].format;
		}

		offset = 1;

		for (i in 0...drawable.textures.length) {

			WebGL.activeTexture(WebGL.TEXTURE0);

			WebGL.bindTexture(WebGL.TEXTURE_2D, drawable.textures[i].glTexture);
		}

		__context.setSamplerState(drawable.textureParams);

		__context.setBlendFactors(drawable.blendFactors.source, drawable.blendFactors.destination);

		__context.generateIndexBuffer();

		__context.drawElements(0, drawable.__indicesToRender);

		WebGL.bindTexture(WebGL.TEXTURE_2D, null);
	}

	// ** Getters and setters. ** //

	private function get_drawCalls():UInt {

		return __drawCalls;
	}
	
	override function set_height(value:Float):Float {

		vertices.innerData[shadings["y"].positions[0]] = 0 - (originY * 2);
		
		vertices.innerData[shadings["y"].positions[1]] = 2 * (value - originY);
		
		vertices.innerData[shadings["y"].positions[2]] = 0 - (originY * 2);
		
		return super.set_height(value);
	}
	
	override function set_originX(value:Float):Float {

		super.set_originX(value);
		
		width = __width;
		
		return __originX;
	}
	
	override function set_originY(value:Float):Float {

		super.set_originY(value);
		
		height = __height;
		
		return __originY;
	}

	override function set_x(value:Float):Float {

		__shouldTransform = true;

		return super.set_x(value);
	}

	override function set_y(value:Float):Float {

		__shouldTransform = true;

		return super.set_y(value);
	}
	
	override function set_width(value:Float):Float {

		vertices.innerData[shadings["x"].positions[0]] = 0 - (originX * 2);
		
		vertices.innerData[shadings["x"].positions[1]] = 0 - (originX * 2);
		
		vertices.innerData[shadings["x"].positions[2]] = 2 * (value - originX);
		
		return super.set_width(value);
	}
}