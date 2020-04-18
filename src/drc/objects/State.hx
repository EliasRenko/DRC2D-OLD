package drc.objects;

import drc.display.Drawable;
import drc.part.Object;
import drc.utils.Common;
import drc.part.DrcRecycleList;

class State extends Object 
{
	// ** Publics.

	public var entities:DrcRecycleList<DrcEntity> = new DrcRecycleList<DrcEntity>();

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

	public function addEntity(entity:DrcEntity):DrcEntity
	{
		@:privateAccess entity.__state = this;
		
		//entity.body.space = space;
		
		return entities.add(entity);
	}
	
	public function render():Void {

		for(i in 0...graphics.length) {

			graphics[i].render();

			Common.stage.draw(graphics[i]);
		}
	}
	
	public function update():Void {

		entities.forEachActive(__updateEntities);
	}

	private function __updateEntities(entity:DrcEntity):Void
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