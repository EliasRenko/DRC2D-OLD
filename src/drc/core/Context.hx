package drc.core;

import drc.display.Uniform;
import opengl.WebGL;
import drc.buffers.Float32Array;
import drc.buffers.Int32Array;

class Context 
{
	//** Privates.
	
	/** @private **/  private var __glIndexBuffer:GLBuffer;
	
	/** @private **/  private var __glVertexBuffer:GLBuffer;
	
	public function new() 
	{
		__glIndexBuffer = WebGL.createBuffer();
		
		__glVertexBuffer = WebGL.createBuffer();
	}
	
	public function clear():Void
	{
		WebGL.clearDepth(1.0);
		
		WebGL.clearStencil(0);
		
		WebGL.clearColor(0, 0.2, 0.2, 1);
		
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
	
	public function generateIndexBuffer():Void
	{
		WebGL.bindBuffer(WebGL.ELEMENT_ARRAY_BUFFER, __glIndexBuffer);
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