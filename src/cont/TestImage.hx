package cont;

import sdl.SDL;
import haxe.io.Bytes;
import drc.buffers.Uint8Array;
import drc.buffers.Float32Array;
import drc.core.Context;
import drc.core.EventDispacher;
import drc.display.Profile;
import drc.graphics.Image;
import drc.objects.State;
import drc.types.DataEvent;
import drc.utils.Common;
import drc.utils.Resources;
import drc.backend.native.NativeTexture;
import opengl.WebGL;

class TestImage extends State
{
	var __context:Context;
	
	var data:Array<Float>;
	var program:GLProgram;
	
	var aPosition:Int = 0;
	var uniform_MP:Int = 0;
	var uniform_MV:Int = 0;
	var uniform_TEX:Int = 0;
	
	var projection:Float32Array;
	var modelview:Float32Array;
	
	var profile:Profile;
	
	var img:Image;
	
	public function new() 
	{
		super();
		
		__context = Common.context;
		
		var event = new EventDispacher<DataEvent> ();
		
		event.add (function(event:DataEvent) { trace (event.data); });
		
		event.dispatch({data: "EVENT!", timestamp: 1});
		
		data = 
		[
			128, 64, 0,
			0, 64, 0,
			64, 0, 0.0
		];    
		
		profile = Resources.getProfile("res/profiles/texture.json");
		
		var vertexSource = Resources.loadText("res/shaders/default.vert");
			
				var vShader = WebGL.createShader(WebGL.VERTEX_SHADER);

                WebGL.shaderSource(vShader, vertexSource);
                WebGL.compileShader(vShader);
				
			var fragmentSource = Resources.loadText("res/shaders/default.frag");
				
				var fShader = WebGL.createShader(WebGL.FRAGMENT_SHADER);

                WebGL.shaderSource(fShader, fragmentSource);
                WebGL.compileShader(fShader);
				
				
		//var program:GLProgram;
				
		program = WebGL.createProgram();

		WebGL.attachShader(program, vShader);
		WebGL.attachShader(program, fShader);
		
		WebGL.linkProgram(program);
		
		if (WebGL.getProgramParameter(program, WebGL.LINK_STATUS) == 0) {
            throw "Unable to link the shader program: " + WebGL.getProgramInfoLog(program);
        }
		
		program = profile.program.innerData;
		
		img = new Image(profile);

		img.textures[0] = Resources.loadTexture('res/graphics/grid.png');

		//img.textures[0] = new NativeTexture(stb.Image.load("res/graphics/grid.png", 0));
		
		aPosition = WebGL.getAttribLocation(program, "location");
		
        uniform_MP = WebGL.getUniformLocation(program, "uMatrix");
		uniform_MV = WebGL.getUniformLocation(program, "modelview");
		
		uniform_TEX = WebGL.getUniformLocation(program, "uImage0");
	}
	
	override public function render():Void
	{
		//var glBuffer = WebGL.createBuffer();
		
		//WebGL.bindBuffer(WebGL.ARRAY_BUFFER, glBuffer);
		
		//WebGL.bufferData(WebGL.ARRAY_BUFFER, Float32Array.fromArray(data), WebGL.STATIC_DRAW);
		
		//WebGL.bindBuffer(WebGL.ARRAY_BUFFER, null);
		
		__context.generateVertexBuffer();
		
		__context.loadVertexBuffer(img.vertices.innerData);
		
		__context.generateIndexBuffer();
		
		__context.loadIndexBuffer(img.indices.innerData);
		
		__context.setViewport(0, 0, 640, 480);
		
		__context.clear(0, 0, 0, 1);
		
		WebGL.enable(WebGL.DEPTH_TEST);
		
		projection = createOrthoMatrix(projection, 0, 640, 480, 0, 1000, -1000 );
		
		modelview = create2DMatrix(modelview, 0, 0, 1, 0 );
		
		WebGL.useProgram(program);
		
		WebGL.uniformMatrix4fv(uniform_MP, false, projection);
		WebGL.uniformMatrix4fv(uniform_MV, false, modelview);
		
		//WebGL.bindBuffer(WebGL.ARRAY_BUFFER, glBuffer);
		__context.generateVertexBuffer();
		
		
		//WebGL.vertexAttribPointer(aPosition, 3, WebGL.FLOAT, false, 0, 0);
		
		//__context.setAttributePointer(aPosition, 3, false, 0, 0);
		
		var offset:Int = 0;
		
		for (i in 0...profile.attributes.length) 
		{
			__context.setAttributePointer(profile.attributes[i].location, profile.attributes[i].format, false, 5 * Float32Array.BYTES_PER_ELEMENT, offset * Float32Array.BYTES_PER_ELEMENT);
			
			offset += profile.attributes[i].format;
		}

		//var glTexture = WebGL.createTexture();

		//__context.generateTexture();

		//__context.loadTextureUniform(uniform_TEX, img.textures[0]);

		//WebGL.bindTexture(WebGL.TEXTURE_2D, glTexture);

		//WebGL.uniform1i(uniform_TEX, 0);

		WebGL.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_WRAP_S, WebGL.CLAMP_TO_EDGE);
		WebGL.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_WRAP_T, WebGL.CLAMP_TO_EDGE);

		WebGL.blendFunc(WebGL.SRC_ALPHA, WebGL.ONE_MINUS_SRC_ALPHA);
		WebGL.enable(WebGL.BLEND);

		//Webgl.texImage2D (Webgl.TEXTURE_2D, 0, __context.gl.RGBA, __context.gl.RGBA, __context.gl.UNSIGNED_BYTE, image.src);

		//WebGL.texImage2D(WebGL.TEXTURE_2D, 0, WebGL.RGBA, img.textures[0].width, img.textures[0].height, 0, WebGL.RGBA, WebGL.UNSIGNED_BYTE, Uint8Array.fromBytes(Bytes.ofData(img.textures[0].bytes)));

		WebGL.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_MAG_FILTER, WebGL.LINEAR);
		WebGL.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_MIN_FILTER, WebGL.LINEAR);

		WebGL.activeTexture(WebGL.TEXTURE0);

		//WebGL.enable(WebGL.TEXTURE_2D);

		//__context.gl.bindTexture (__context.gl.TEXTURE_2D, null);

		//__context.setUniform(profile.uniforms[0], projection);
		//__context.setUniform(profile.uniforms[1], projection);
		
		//WebGL.drawArrays(WebGL.TRIANGLES, 0, 3);
		
		__context.generateIndexBuffer();
		
		//__context.drawArrays(0, img.__verticesToRender);
		
		__context.drawElements(0, img.__indicesToRender);
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
}