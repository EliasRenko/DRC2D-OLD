package drc.core;

import drc.backend.native.NativeRuntime;
import drc.core.Runtime;
import drc.objects.State;
import drc.part.ObjectList;
import drc.utils.Common;
import drc.graphics.Canvas;
import drc.utils.Resources;

class App 
{
	//** Publics.

	public var canvas:Canvas;
	
	public var runtime:Runtime;
	
	public var states:ObjectList<State> = new ObjectList<State>();
	
	//** Privates.
	
	/** @private **/ private var __context:Context;
	
	public function new() 
	{
		#if cpp
		
		runtime = new drc.backend.native.NativeRuntime();
		
		#end
		
		runtime.init();
		
		__context = new Context();

		Common.context = __context;

		canvas = new Canvas(Resources.getProfile("res/profiles/texture.json"));

		Common.canvas = canvas;
	}
	
	public function init():Void
	{	
		while (runtime.active) 
		{
			runtime.pollEvents();
			
			//render();
			
			//update();

			canvas.setToDraw();

			canvas.draw();

			__context.setRenderToBackbuffer();

			__context.clear(1, 0, 0, 1);

			//canvas.draw();

			canvas.present();

			runtime.present();

			runtime.input.postUpdate();
			
			//Sys.sleep(0.5);
		}
	}
	
	public function release():Void
	{
		
	}
	
	public function addState(state:State):State
	{
		return states.add(state);
	}
	
	public function removeState(state:State):Void
	{
		states.remove(state);
	}
	
	public function render():Void
	{
		for (i in 0...states.count) 
		{
			states.members[i].render();
		}
	}
	
	public function update():Void
	{
		for (i in 0...states.count) 
		{
			states.members[i].update();
		}
	}
}