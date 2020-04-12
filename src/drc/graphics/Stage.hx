package drc.graphics;

import drc.backend.native.NativeTexture;
import drc.core.Context;
import drc.display.Graphic;
import drc.display.Profile;
import drc.data.BitmapData;
import drc.utils.Common;
import opengl.WebGL;
import drc.buffers.Float32Array;
import drc.utils.Resources;

class Stage extends Graphic
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

		textures = new Array<BitmapData>();

		textures[0] = new NativeTexture();

		textures[0].create(640, 480);

		vertices.upload(
		[
			0, 0, 0, 0, 1,
			0, 480, 0, 0, 0,
			640, 480, 0, 1, 0,
			640, 0, 0, 1, 1
		]);
		
		indices.upload([0, 1, 2, 0, 2, 3]);
		
		__verticesToRender = 4;
		
		__indicesToRender = 6;
	}

	public function setToDraw():Void {
		
		__context.setRenderToTexture(textures[0]);

		renderToTexture = true;

		__context.clear(0.2, 0, 0.2, 1);
	}

	public function present():Void {

		renderToTexture = false;

		__context.setViewport(0, 0, 640, 480);

		__drawTriangles(this);
	}

	public function draw(image:Image):Void {
		
		__drawCalls ++;

		__drawTriangles(image);
	}

	var projection:Float32Array;

	var renderToTexture:Bool = false;

	private function __drawTriangles(img:Graphic):Void {
		
		__context.generateVertexBuffer();
		
		__context.loadVertexBuffer(img.vertices.innerData);
		
		__context.generateIndexBuffer();
		
		__context.loadIndexBuffer(img.indices.innerData);
		
		WebGL.enable(WebGL.DEPTH_TEST);
		
		var projection:Float32Array = img.matrix.createOrthoMatrix(0, 640, 480, 0, 1000, -1000);
		
		WebGL.useProgram(img.profile.program.innerData);
		
		var loc = WebGL.getUniformLocation(img.profile.program.innerData, "matrix");

		WebGL.uniformMatrix4fv(loc, false, projection);
		
		__context.generateVertexBuffer();
		
		var offset:Int = 0;
		
		for (i in 0...img.profile.attributes.length) {

			__context.setAttributePointer(profile.attributes[i].location, profile.attributes[i].format, false, 5 * Float32Array.BYTES_PER_ELEMENT, offset * Float32Array.BYTES_PER_ELEMENT);
			
			offset += profile.attributes[i].format;
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

	function createOrthoMatrix( ?into:Float32Array, x0:Float, x1:Float,  y0:Float, y1:Float, zNear:Float, zFar:Float ) : Float32Array {

        var i = into;
        if(i == null) i = new Float32Array(16);

        var sx = 1.0 / (x1 - x0);
        var sy = 1.0 / (y1 - y0);
        var sz = 1.0 / (zFar - zNear);

            i[ 0] = 2.0*sx;        i[ 1] = 0;            i[ 2] = 0;                 i[ 3] = 0;
            i[ 4] = 0;             i[ 5] = 2.0*sy;       i[ 6] = 0;                 i[ 7] = 0;
            i[ 8] = 0;             i[ 9] = 0;            i[10] = -2.0*sz;           i[11] = 0;
            i[12] = -(x0+x1)*sx;   i[13] = -(y0+y1)*sy;  i[14] = -(zNear+zFar)*sz;  i[15] = 1;

        return i;

    } //createOrthoMatrix
	
	function create2DMatrix( ?into:Float32Array, x:Float, y:Float, scale:Float = 1, rotation:Float = 0 ) {

        var i = into;
        if(i == null) i = new Float32Array(16);

        var theta = rotation * Math.PI / 180.0;
        var c = Math.cos(theta);
        var s = Math.sin(theta);

            i[ 0] = c*scale;  i[ 1] = -s*scale;  i[ 2] = 0;      i[ 3] = 0;
            i[ 4] = s*scale;  i[ 5] = c*scale;   i[ 6] = 0;      i[ 7] = 0;
            i[ 8] = 0;        i[ 9] = 0;         i[10] = 1;      i[11] = 0;
            i[ 12] = x;       i[13] = y;         i[14] = 0;      i[15] = 1;

        return i;

	} //create2DMatrix
	
	//** Getters and setters. **/

	private function get_drawCalls():UInt {

		return __drawCalls;
	}
}