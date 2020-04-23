package drc.core;

import drc.data.Texture;
import drc.display.Uniform;
import opengl.WebGL;
import drc.buffers.Float32Array;
import drc.buffers.Int32Array;
import drc.buffers.Uint8Array;
import haxe.io.Bytes;

class Context 
{
	//** Privates.
	
	/** @private **/ private var __glDepthBuffer:GLRenderbuffer;

	/** @private **/ private var __glFrameBuffer:GLFramebuffer;

	/** @private **/ private var __glIndexBuffer:GLBuffer;

	/** @private **/ private var __glVertexBuffer:GLBuffer;

	public function new() 
	{
		__glDepthBuffer = WebGL.createRenderbuffer();

		__glFrameBuffer = WebGL.createFramebuffer();

		__glIndexBuffer = WebGL.createBuffer();
		
		__glVertexBuffer = WebGL.createBuffer();
	}
	
	public function clear(r:Float, g:Float, b:Float, a:Float):Void
	{
		WebGL.clearDepth(1.0);
		
		WebGL.clearStencil(0);
		
		//WebGL.clearColor(0, 0.2, 0.2, 1);

		WebGL.clearColor(r, g, b, a);
		
		WebGL.clear(WebGL.COLOR_BUFFER_BIT | WebGL.DEPTH_BUFFER_BIT | WebGL.STENCIL_BUFFER_BIT);
	}
	
	public function drawArrays(offset:Int, count:Int):Void
	{
		WebGL.drawArrays(WebGL.TRIANGLES, offset, count);
	}
	
	public function drawElements(offset:Int, count:Int):Void
	{
		WebGL.drawElements(WebGL.TRIANGLES, count, WebGL.UNSIGNED_INT, offset);
	}

	public function bindFrameBuffer():Void {
		
		WebGL.bindFramebuffer(WebGL.FRAMEBUFFER, __glFrameBuffer);
	}

	public function setRenderToTexture(bitmapData:Texture):Void {
		
		WebGL.bindFramebuffer(WebGL.FRAMEBUFFER, __glFrameBuffer);

		var attachmentPoint = WebGL.COLOR_ATTACHMENT0;

		WebGL.framebufferTexture2D(WebGL.FRAMEBUFFER, attachmentPoint, WebGL.TEXTURE_2D, bitmapData.glTexture, 0);

		WebGL.bindRenderbuffer(WebGL.RENDERBUFFER, __glDepthBuffer);

		WebGL.renderbufferStorage(WebGL.RENDERBUFFER, WebGL.DEPTH_COMPONENT16, bitmapData.width, bitmapData.height);
		WebGL.framebufferRenderbuffer(WebGL.FRAMEBUFFER, WebGL.DEPTH_ATTACHMENT, WebGL.RENDERBUFFER, __glDepthBuffer);

		if (WebGL.checkFramebufferStatus(WebGL.FRAMEBUFFER) != WebGL.FRAMEBUFFER_COMPLETE) {
			
			trace('Framebuffer problem!');
		}
	}

	public function setBlendFactors(source:Null<Int>, dest:Null<Int>):Void {
		
		WebGL.enable(WebGL.BLEND);

		if (source == -1 || dest == -1) {

			WebGL.blendFunc(WebGL.ONE, WebGL.ONE_MINUS_SRC_ALPHA);

			return;
		}
		
		//WebGL.blendFunc(WebGL.SRC_ALPHA, WebGL.ONE_MINUS_SRC_ALPHA);

		WebGL.blendFunc(source, dest);

		//WebGL.blendFuncSeparate(WebGL.SRC_ALPHA, WebGL.ONE_MINUS_SRC_ALPHA, WebGL.ONE, WebGL.ZERO);
	}

	public function setSamplerState():Void {

		WebGL.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_WRAP_S, WebGL.CLAMP_TO_EDGE);
		WebGL.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_WRAP_T, WebGL.CLAMP_TO_EDGE);

		WebGL.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_MAG_FILTER, WebGL.NEAREST);
		WebGL.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_MIN_FILTER, WebGL.NEAREST);
	}

	public function setRenderToBackbuffer():Void {

		WebGL.bindFramebuffer(WebGL.FRAMEBUFFER, null);
	}

	public function generateFrameBuffer():Void {

		WebGL.createFramebuffer();
	}
	
	public function generateIndexBuffer():Void
	{
		WebGL.bindBuffer(WebGL.ELEMENT_ARRAY_BUFFER, __glIndexBuffer);
	}

	public function generateTexture():GLTexture
	{
		var _glTexture:GLTexture = WebGL.createTexture();

		WebGL.bindTexture(WebGL.TEXTURE_2D, _glTexture);

		return _glTexture;
	}
	
	public function generateVertexBuffer():Void
	{
		WebGL.bindBuffer(WebGL.ARRAY_BUFFER, __glVertexBuffer);
	}
	
	public function loadIndexBuffer(data:Array<UInt>):Void
	{
		WebGL.bufferData(WebGL.ELEMENT_ARRAY_BUFFER, Int32Array.fromArray(data), WebGL.STATIC_DRAW);
		
		WebGL.bindBuffer(WebGL.ELEMENT_ARRAY_BUFFER, null);
	}

	public function loadTexture(width:Int, height:Int, comp:Int, data:Uint8Array):Void {
		
		var _format:Int;

		switch(comp) {

			case 1:

				_format = WebGL.RED;

			case 2:

				_format = WebGL.LUMINANCE_ALPHA;

			case 3:

				_format = WebGL.RGB;

			case 4:

				_format = WebGL.RGBA;

			default:

			_format = WebGL.RGBA;
		}

		WebGL.texImage2D(WebGL.TEXTURE_2D, 0, _format, width, height, 0, _format, WebGL.UNSIGNED_BYTE, data);

		WebGL.bindTexture(WebGL.TEXTURE_2D, null);
	}
	
	public function loadVertexBuffer(data:Array<Float>):Void
	{
		WebGL.bufferData(WebGL.ARRAY_BUFFER, Float32Array.fromArray(data), WebGL.STATIC_DRAW);
		
		WebGL.bindBuffer(WebGL.ARRAY_BUFFER, null);
	}
	
	public function setAttributePointer(index:Int, size:Int, normalized:Bool, stride:Int, offset:Int):Void
	{
		WebGL.enableVertexAttribArray(index);
		
		WebGL.vertexAttribPointer(index, size, WebGL.FLOAT, normalized, stride, offset);
	}

	public function setUniform(uniform:Uniform, value:Dynamic):Void {
		
		switch (uniform.format) {

			case FLOAT1:

				WebGL.uniform1f(uniform.location, value);

			case MAT4:

				WebGL.uniformMatrix4fv(uniform.location, false, value);

			default:
		}
	}
	
	public function setViewport(x:Int, y:Int, width:Int, height:Int):Void
	{
		WebGL.viewport(0, 0, 640, 480);
	}
}