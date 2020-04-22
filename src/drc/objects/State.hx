package drc.objects;

import drc.buffers.Float32Array;
import drc.display.Drawable;
import drc.part.Object;
import drc.utils.Common;
import drc.part.RecycleList;
import drc.input.Control;

class State extends Object {

	// ** Publics.

	public var camera:Camera = new Camera();

	public var entities:RecycleList<Entity> = new RecycleList<Entity>();

	public var graphics:RecycleList<Drawable> = new RecycleList<Drawable>();

	//public var graphics:Array<Drawable> = new Array<Drawable>();

	/**
	 * The x position of the mouse in the state.
	 */
	public var mouseX(get, null):Float;

	/**
	 * The y position of the mouse in the state.
	 */
	public var mouseY(get, null):Float;

	// ** Privates.

	private var __perpspective:Bool = false;

	public function new() {}

	override public function init():Void {}

	override public function release():Void {}

	public function addEntity(entity:Entity):Entity {

		@:privateAccess entity.__state = this;

		return entities.add(entity);
	}

	public function addGraphic(graphic:Drawable):Void {

		graphics.add(graphic);
	}

	public function render():Void {

		graphics.forEachActive(__renderGraphic);
	}

	public function update():Void {

		if (Common.input.getGamepad(0).pressed(Control.BACK)) {

			if (__perpspective) {

				__perpspective = false;
			}
			else {

				__perpspective = true;
			}
		}

		entities.forEachActive(__updateEntitie);
	}

	private function __renderGraphic(drawable:Drawable):Void {
		
		if (drawable.visible) {

			drawable.render();

			if (__perpspective) {

				Common.stage.draw(drawable, camera.render2(drawable.matrix));
			}
			else {

				Common.stage.draw(drawable, camera.render(drawable.matrix));
			}
		}
	}

	private function __updateEntitie(entity:Entity):Void {

		entity.update();
	}

	// ** Getters and setters.

	private function get_mouseX():Float {

		return 0;
	}

	private function get_mouseY():Float {

		return 0;
	}
}
