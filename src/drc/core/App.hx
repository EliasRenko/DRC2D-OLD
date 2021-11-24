package drc.core;

import drc.display.Stage;
import drc.objects.State;
import drc.part.ObjectList;
import drc.system.Window;
import drc.types.WindowEventType;
import drc.utils.Common;
import drc.utils.Resources;
import drc.core.Runtime;

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

	/** @private **/ private var __resources:Resources;

	/** @private **/ private var __runtime:Runtime;

	/** @private **/ private var __stage:Stage;

	/** @private **/ private var __promise:Promise<Dynamic>;

	public function new() {
		
		Common.app = this;

		__runtime = new Runtime();
		
		// ** Init runtime.

		__runtime.init();
		
		__context = new Context();
		
		Common.context = __context;

		__resources = new Resources();

		Common.resources = __resources;

		preload();
	}

	public function preload():Void {

		var _preloads:Array<Promise<Dynamic>> = [

			__resources.loadProfile('res/profiles/texture.json'),

			__resources.loadProfile('res/profiles/debug.json'),

			__resources.loadProfile('res/profiles/default.json'),

			__resources.loadProfile('res/profiles/gui.json'),

			__resources.loadProfile("res/profiles/font.json"),

			__resources.loadProfile("res/profiles/checker.json"),

			__resources.loadTexture('res/graphics/grid_bw.png'),

			__resources.loadTexture('res/graphics/grid_mt.png'),

			__resources.loadTexture("res/graphics/gui.png"),

			__resources.loadTexture("res/graphics/checker.png"),

			__resources.loadFont("res/fonts/font.json"),

			__resources.loadFont("res/fonts/nokiafc22.json"),

			__resources.loadText("res/graphics/gui.json"),
		];

		__promise = Promise.all(_preloads);
	}

	public function run():Void {

		__promise.onComplete(function(promise:Promise<Dynamic>, type:Int) {
			
			__stage = new Stage(Common.resources.getProfile('res/profiles/texture.json'));

			Common.stage = stage;

			// ** 

			ready();

			__runtime.window.addEventListener(__onWindowEvent, 0);

			__runtime.event.addEventListener(loop, 1);

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
		
		__context.clear(0, 0, 0, 1);
		
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
		
		__context.clear(0, 0, 0, 1);
		
		stage.present();
		
		__runtime.present();
		
		//__runtime.input.postUpdate();

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

	// **

	/* public static function main() {

		#if cpp

		var _appRef = Type.resolveClass("Main");

		var _app:App = Type.createInstance(_appRef, []);

		if (_app == null) {

			trace('Main is null!');

			throw 'Main instance is null.';
		} 

		trace('Main is Running!');

		// ** Run the app.

		_app.run();

		#end
	} */
}
