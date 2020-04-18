package drc.objects;

import drc.display.Drawable;
import drc.part.Object;
import drc.utils.Common;

class State extends Object 
{
	// ** Publics.

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
	
	public function render():Void {

		for(i in 0...graphics.length) {

			graphics[i].render();

			Common.stage.draw(graphics[i]);
		}
	}
	
	public function update():Void {

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