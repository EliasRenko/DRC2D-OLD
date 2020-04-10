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
	
	/** @private **/ private var __glFrameBuffer:GLFramebuffer;

	/** @private **/ private var __glIndexBuffer:GLBuffer;
	
	/** @private **/ private var __glTextures:Array<GLTexture> = new Array<GLTexture>();

	/** @private **/ private var __glVertexBuffer:GLBuffer;

	public function new() 
	{
		__glFrameBuffer = WebGL.createFramebuffer();

		__glIndexBuffer = WebGL.createBuffer();
		
		__glVertexBuffer = WebGL.createBuffer();

		__glTextures[0] = WebGL.createTexture();
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

	public function setRenderToTexture(texture:Texture):Void {
		
		WebGL.bindFramebuffer(WebGL.FRAMEBUFFER, __glFrameBuffer);

		var attachmentPoint = WebGL.COLOR_ATTACHMENT0;

		WebGL.framebufferTexture2D(WebGL.FRAMEBUFFER, attachmentPoint, WebGL.TEXTURE_2D, texture.glTexture, 0);

		if (WebGL.checkFramebufferStatus(WebGL.FRAMEBUFFER) != WebGL.FRAMEBUFFER_COMPLETE) {
			
			trace('Framebuffer problem!');
		}
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

	public function loadTexture(width:Int, height:Int, data:Uint8Array):Void {
		
		//WebGL.uniform1i(location, 0);

		WebGL.texImage2D(WebGL.TEXTURE_2D, 0, WebGL.RGBA, width, height, 0, WebGL.RGBA, WebGL.UNSIGNED_BYTE, data);
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