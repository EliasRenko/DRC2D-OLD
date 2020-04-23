package drc.core;

import drc.core.Runtime;
import drc.display.Stage;
import drc.objects.State;
import drc.part.ObjectList;
import drc.utils.Common;
import drc.utils.Resources;

#if cpp

	import drc.backend.native.core.Runtime;

#end

class App
{

	// ** Publics.

	/**
	 * The backend runtime of the application. Cannot be set.
	 */
	public var runtime(get, null):Runtime;

	/**
	 * The stage of the application. Cannot be set.
	 */
	public var stage(get, null):Stage;

	/**
	 * The states of the application.
	 */
	public var states:ObjectList<State> = new ObjectList<State>();

	// Privates

	/** @private **/ private var __context:Context;

	/** @private **/ private var __runtime:Runtime;

	/** @private **/ private var __stage:Stage;

	public function new()
	{
		#if cpp
		
		__runtime = new drc.backend.native.core.Runtime();
		
		#else
		
		throw 'No backend has been found.';
		
		#end
		
		__runtime.init();
		
		__context = new Context();
		
		Common.context = __context;
		
		__stage = new Stage(Resources.getProfile("res/profiles/texture.json"));
		
		Common.stage = stage;
	}

	public function run():Void
	{
		while (runtime.active)
		{
			__runtime.pollEvents();
			
			update();
			
			stage.setToDraw();
			
			render();
			
			__context.setRenderToBackbuffer();
			
			__context.clear(1, 0, 0, 1);
			
			stage.present();
			
			__runtime.present();
			
			__runtime.input.postUpdate();
		}
		
		Sys.exit(0);
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

	// ** Getters and setters.

	private function get_runtime():Runtime
	{
		return __runtime;
	}

	private function get_stage():Stage
	{
		return __stage;
	}
}
