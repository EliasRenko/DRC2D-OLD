package drc.core;

import haxe.io.Int32Array;
import haxe.io.Float32Array;
//import haxe.io.UInt8Array;
import haxe.io.UInt8Array;
import drc.display.Drawable.TextureParameters;
import drc.data.Texture;
import drc.display.Uniform;
import drc.core.GL;
//import drc.buffers.Float32Array;
//import drc.buffers.Int32Array;
import drc.buffers.Uint8Array;



class Context 
{
	//** Privates.
	
	/** @private **/ private var __glDepthBuffer:GLRenderbuffer;

	/** @private **/ private var __glFrameBuffer:GLFramebuffer;

	/** @private **/ private var __glIndexBuffer:GLBuffer;

	/** @private **/ private var __glVertexBuffer:GLBuffer;

	public function new() 
	{
		__glDepthBuffer = GL.createRenderbuffer();

		__glFrameBuffer = GL.createFramebuffer();

		__glIndexBuffer = GL.createBuffer();
		
		__glVertexBuffer = GL.createBuffer();
	}
	
	public function clear(r:Float, g:Float, b:Float, a:Float):Void
	{
		GL.clearDepth(1.0);
		
		GL.clearStencil(0);
		
		//GL.clearColor(0, 0.2, 0.2, 1);

		GL.clearColor(r, g, b, a);
		
		GL.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT | GL.STENCIL_BUFFER_BIT);
	}
	
	public function drawArrays(offset:Int, count:Int):Void
	{
		GL.drawArrays(GL.TRIANGLES, offset, count);
	}
	
	public function drawElements(offset:Int, count:Int):Void
	{
		GL.drawElements(GL.TRIANGLES, count, GL.UNSIGNED_INT, offset);
	}

	public function bindFrameBuffer():Void {
		
		GL.bindFramebuffer(GL.FRAMEBUFFER, __glFrameBuffer);
	}

	public function setRenderToTexture(bitmapData:Texture):Void {
		
		GL.bindFramebuffer(GL.FRAMEBUFFER, __glFrameBuffer);

		var attachmentPoint = GL.COLOR_ATTACHMENT0;

		GL.framebufferTexture2D(GL.FRAMEBUFFER, attachmentPoint, GL.TEXTURE_2D, bitmapData.glTexture, 0);

		GL.bindRenderbuffer(GL.RENDERBUFFER, __glDepthBuffer);

		GL.renderbufferStorage(GL.RENDERBUFFER, GL.DEPTH_COMPONENT16, bitmapData.width, bitmapData.height);
		GL.framebufferRenderbuffer(GL.FRAMEBUFFER, GL.DEPTH_ATTACHMENT, GL.RENDERBUFFER, __glDepthBuffer);

		if (GL.checkFramebufferStatus(GL.FRAMEBUFFER) != GL.FRAMEBUFFER_COMPLETE) {
			
			trace('Framebuffer problem!');
		}
	}

	public function setBlendFactors(source:Null<Int>, dest:Null<Int>):Void {
		
		GL.enable(GL.BLEND);

		if (source == -1 || dest == -1) {

			GL.blendFunc(GL.ONE, GL.ONE_MINUS_SRC_ALPHA);

			return;
		}
		
		//GL.blendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);

		GL.blendFunc(source, dest);

		//GL.blendFuncSeparate(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA, GL.ONE, GL.ZERO);
	}

	public function setSamplerState(params:TextureParameters):Void {

		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, params.wrapX);
		
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, params.wrapY);

		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, params.magnification);

		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, params.minification);
	}

	public function setRenderToBackbuffer():Void {

		GL.bindFramebuffer(GL.FRAMEBUFFER, null);
	}

	public function generateFrameBuffer():Void {

		GL.createFramebuffer();
	}
	
	public function generateIndexBuffer():Void
	{
		GL.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, __glIndexBuffer);
	}

	public function generateTexture():GLTexture
	{
		var _glTexture:GLTexture = GL.createTexture();

		GL.bindTexture(GL.TEXTURE_2D, _glTexture);

		return _glTexture;
	}
	
	public function generateVertexBuffer():Void
	{
		GL.bindBuffer(GL.ARRAY_BUFFER, __glVertexBuffer);
	}
	
	public function loadIndexBuffer(data:Array<UInt>):Void
	{
		GL.bufferData(GL.ELEMENT_ARRAY_BUFFER, Int32Array.fromArray(data).view, GL.STATIC_DRAW);
		
		GL.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, null);
	}

	public function loadTexture(width:Int, height:Int, comp:Int, data:UInt8Array):Void {
		
		var _format:Int;

		switch(comp) {

			case 1:

				_format = GL.RED;

			case 2:

				_format = GL.LUMINANCE_ALPHA;

			case 3:

				_format = GL.RGB;

			case 4:

				_format = GL.RGBA;

			default:

			_format = GL.RGBA;
		}

		GL.texImage2D(GL.TEXTURE_2D, 0, _format, width, height, 0, _format, GL.UNSIGNED_BYTE, data.view);

		GL.bindTexture(GL.TEXTURE_2D, null);
	}
	
	public function loadVertexBuffer(data:Array<Float>):Void
	{
		GL.bufferData(GL.ARRAY_BUFFER, Float32Array.fromArray(data).view, GL.STATIC_DRAW);
		
		GL.bindBuffer(GL.ARRAY_BUFFER, null);
	}
	
	public function setAttributePointer(index:Int, size:Int, normalized:Bool, stride:Int, offset:Int):Void
	{
		GL.enableVertexAttribArray(index);
		
		GL.vertexAttribPointer(index, size, GL.FLOAT, normalized, stride, offset);
	}

	public function setUniform(uniform:Uniform, value:Dynamic):Void {
		
		switch (uniform.format) {

			case FLOAT1:

				GL.uniform1f(uniform.location, value);

			case MAT4:

				GL.uniformMatrix4fv(uniform.location, false, value);

			default:
		}
	}
	
	public function setViewport(x:Int, y:Int, width:Int, height:Int):Void
	{
		GL.viewport(x, y, width, height);
	}
}