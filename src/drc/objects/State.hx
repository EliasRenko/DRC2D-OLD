package drc.objects;

import drc.buffers.Float32Array;
import drc.display.Drawable;
import drc.part.Object;
import drc.utils.Common;
import drc.part.RecycleList;

class State extends Object 
{
	// ** Publics.

	public var camera:Camera = new Camera();

	public var entities:RecycleList<Entity> = new RecycleList<Entity>();

	public var graphics:Array<Drawable> = new Array<Drawable>();

	/**
	 * The x position of the mouse in the state.
	 */
	public var mouseX(get, null):Float;

	/**
	 * The y position of the mouse in the state.
	 */
	public var mouseY(get, null):Float;

	

	public function new() {

	}
	
	override public function init():Void {

	}
	
	override public function release():Void {

	}

	public function addEntity(entity:Entity):Entity
	{
		@:privateAccess entity.__state = this;
		
		//entity.body.space = space;
		
		return entities.add(entity);
	}
	
	public function render():Void {

		for (i in 0...graphics.length) {

			if (graphics[i].visible) {

				graphics[i].render();

				Common.stage.draw(graphics[i], camera.render(graphics[i].matrix));
			}
		}
	}
	
	public function update():Void {

		entities.forEachActive(__updateEntities);
	}

	private function __updateEntities(entity:Entity):Void
	{
		entity.update();
	}

	public function addGraphic(graphic:Drawable):Void {

		graphics.push(graphic);
	}

	// ** Getters and setters.

	private function get_mouseX():Float {

		return 0;
	}

	private function get_mouseY():Float {

		return 0;
	}
}