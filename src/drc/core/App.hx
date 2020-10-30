package drc.core;

import drc.display.Stage;
import drc.objects.State;
import drc.part.ObjectList;
import drc.system.Window;
import drc.types.WindowEventType;
import drc.utils.Common;
import drc.utils.Res;
import drc.utils.Resources;

#if cpp

	import drc.backend.native.core.Runtime;

#end

class App {

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

	// ** Privates

	/** @private **/ private var __context:Context;

	/** @private **/ private var __resources:Res;

	/** @private **/ private var __runtime:Runtime;

	/** @private **/ private var __stage:Stage;

	/** @private **/ private var __promise:Promise<Dynamic>;

	public function new() {

		#if cpp
		
		__runtime = new drc.backend.native.core.Runtime();
		
		#elseif js

		__runtime = new drc.backend.web.core.Runtime();

		#else
		
		throw 'No backend has been found.';
		
		#end
		
		// ** Init runtime.

		__runtime.init();
		
		__context = new Context();
		
		Common.context = __context;
		
		//__stage = new Stage(Resources.getProfile("res/profiles/texture.json"));

		__resources = new Res();

		Common.res = __resources;

		//Common.stage = stage;

		//Common.window.onEvent.add(__onWindowEvent, WindowEventType.RESIZED);

		preload();
	}

	public function preload():Void {

		var _preloads:Array<Promise<Dynamic>> = 
		[
			__resources.loadProfile('res/profiles/texture.json'),
			__resources.loadProfile('res/profiles/default.json'),
			__resources.loadTexture('res/graphics/grid_bw.png')
		];

		__promise = Promise.all(_preloads);
	}

	public function run():Void {

		__promise.onComplete(function(result:Array<String>, type:Int) {
			
			__stage = new Stage(Common.res.getProfile('res/profiles/texture.json'));

			Common.stage = stage;

			ready();

			__runtime.event.add(loop, 1);

			__runtime.requestLoopFrame();
		});
	}

	public function ready():Void {}

	public function loop(value:Float, type:UInt):Void {

		// ** While runtime is active...

		#if js 
		
		__runtime.pollEvents();
			
		update();
		
		stage.setToDraw();
		
		render();
		
		__context.setRenderToBackbuffer();
		
		__context.clear(0, 1, 0, 1);
		
		stage.present();
		
		__runtime.present();
		
		//__runtime.input.postUpdate();

		#else

		// ** C++

		__runtime.pollEvents();
			
		update();
		
		stage.setToDraw();
		
		render();
		
		__context.setRenderToBackbuffer();
		
		__context.clear(0, 1, 0, 1);
		
		stage.present();
		
		__runtime.present();
		
		__runtime.input.postUpdate();

		#end
	}

	public function loopNew(value:Float, type:UInt):Void {

		__runtime.pollEvents();
	}

	public function addState(state:State):State {

		// ** Add the state to the state list.

		states.add(state);

		// ** Init the state.

		__initState(state);

		// ** Return.

		return state;
	}

	public function removeState(state:State):Void {

		// ** Release the state.

		state.release();
	}

	public function render():Void {

		// ** For each state...

		for (i in 0...states.count) {

			// ** Render.

			states.members[i].render();
		}
	}

	public function update():Void {

		// ** For each state...

		for (i in 0...states.count) {

			// ** Update.

			states.members[i].update();
		}
	}

	// ** ------

	private function __initState(state:State):Void {

		@:privateAccess state.__parent = this;

		@:privateAccess state.__z = states.count - 1;
	}

	private function __onWindowEvent(window:Window, type:WindowEventType):Void {
		
		switch type {

			case CLOSE:

				// ** Quit the application.

			case RESIZED:

				// ** Resize the stage.

				__stage.resize(window.width, window.height);

			case _:
		}

		// ** For each state.

		for (i in 0...states.count) {

			states.members[i].onWindowEvent(window, type);
		}
	}

	// ** Getters and setters.

	private function get_runtime():Runtime {

		return __runtime;
	}

	private function get_stage():Stage {

		return __stage;
	}
}
