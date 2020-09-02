package cont.ui;

import drc.part.Group;
import cont.ui.UiEventType;

class UiLayout extends UiControl
{
	// ** Publics.

	public var controls(get, null):Group<UiControl>;

	// ** Privates.

	/** @private **/ private var __controls:Group<UiControl> = new Group<UiControl>();

	/** @private **/ private var __collisionIndex:Int = -1;
	
	public function new(width:Float, height:Float, x:Float = 0, y:Float = 0) 
	{
		//** Super.
		
		super(x, y);
		
		//** Pass the width value to it's variable counterpart.
		
		__width = width;
		
		//** Pass the height value to it's variable counterpart.
		
		__height = height;

		__type = 'layout';
	}
	
	override public function init():Void 
	{
		//** Super init.
		
		super.init();

		//** For each child...
		
		for (i in 0...__controls.count)
		{
			//** Init every child.
			
			__initMember(__controls.members[i]);
		}
		
		//** Set the hitbox.
		
		__setHitbox(0, 0, width, height);
	}
	
	override public function release():Void 
	{
		// ** Get the memberss count.
		
		var i:Int = __controls.count - 1;

		// ** Release every child of the control.

		while (i > -1) {

			__controls.members[i].release();

			i --;
		}

		//** Super release.
		
		super.release();
	}

	public function addControl(control:UiControl):UiControl {

		//** If the layout is active...
		
		if (__form != null)
		{
			// ** Init member.
			
			__initMember(control);
		}

		return __controls.add(control);
	}

	public function removeControl(control:UiControl):Void {
		
		// ** Remove the control.

		__controls.remove(control);
	}
	
	override public function update():Void 
	{
		super.update();

		__collisionIndex = -1;

		for (i in 0...__controls.count)
		{
			// if (__members.members[i] == null)
			// {
			// 	continue;
			// }
			
			__controls.members[i].update();
		}
	}

	override function updateCollision() {

		super.updateCollision();

		// ** If collide...

		if (collide)
		{
			// ** For every control...
			
			for (i in 0...__controls.count)
			{
				// ** Set the collision index.

				__collisionIndex = i;

				if (i >= __controls.count) {

					continue;
				}

				// ** Update the collision of the child.

				__controls.members[i].updateCollision();

				if (__controls.members[i] == null) {

					continue;
				}

				// ** If collision has been found.

				if (__controls.members[i].collide)
				{
					return;
				}
			}
			
			if (hover) {

				onMouseHover();
			}
			else {

				__form.hoverControl = this;
			}

			//** If right click...
			
			if (__allow)
			{
				if (__form.leftClick)
				{
					__form.selectedControl = this;
	
					__onClick();
				}
			}
		}
	}
	
	private function __initMember(control:UiControl):Void
	{
		@:privateAccess control.__parent = this;
		
		// ** Set the offsetX of the control.
		
		@:privateAccess control.__offsetX = __x + __offsetX; // ** Define metadata privateAccess.
		
		// ** Set the offsetY of the control.
		
		@:privateAccess control.__offsetY = __y + __offsetY; // ** Define metadata privateAccess.
		
		// ** Assign the default visiblity value to the control.

		@:privateAccess control.visible = control.visible ? __visible : false; // ** Define metadata privateAccess.

		// ** Assign the default z value to the control.
		
		@:privateAccess control.z += __z - 1; // ** Define metadata privateAccess.
		
		if (__mask)
		{
			@:privateAccess control.__mask = true;
			
			@:privateAccess control.__maskBox = __maskBox;
		}
		
		// ** Call init method.
		
		control.init();
	}

	private function __onClick():Void {

		onEvent.dispatch(this, ON_CLICK);
	}

	private function __onRightClick():Void {

	}

	override private function __setMask(x:Float, y:Float, width:Float, height:Float):Void {
		
		super.__setMask(x, y, width, height);

		for (i in 0...__controls.count) {

			@:privateAccess __controls.members[i].__setMask(x, y, width, height);
		}
	}

	override function onFormResize() {

		super.onFormResize();

		for (i in 0...__controls.count) {

			__controls.members[i].onFormResize();
		}
	}

	// ** Getters and setters.

	private function get_controls():Group<UiControl> {

		return __controls;
	}

	override function set_visible(value:Bool):Bool {

		for (i in 0...__controls.count)
		{
			// ** Set the visible property of the member.
			
			__controls.members[i].visible = value;
		}

		return super.set_visible(value);
	}

	override function set_x(value:Float):Float {

		// ** For each child...
		
		for (i in 0...__controls.count)
		{
			// ** Set the offsetX property of the member.
			
			@:privateAccess __controls.members[i].__setOffsetX(value + __offsetX);
		}
		
		// ** Return.
		
		return super.set_x(value);
	}

	override function set_y(value:Float):Float {

		//** For each child...
		
		for (i in 0...__controls.count)
		{
			//** Set the offsetY property of the member.
			
			@:privateAccess __controls.members[i].__setOffsetY(value + __offsetY);
		}
		
		//** Return.
		
		return super.set_y(value);
	}

	override function set_z(value:Float):Float {

		//** For each child...
		
		for (i in 0...__controls.count)
		{
			//** Set the z property of the member.
			
			__controls.members[i].z = value;
		}
		
		//** Return.
		
		return super.set_z(value);
	}

	override function __setOffsetX(value:Float):Void 
	{
		super.__setOffsetX(value);
		
		for (i in 0...__controls.count)
		{
			@:privateAccess __controls.members[i].__setOffsetX(x + value);
		}
	}
		
	override function __setOffsetY(value:Float):Void 
	{
		super.__setOffsetY(value);
		
		for (i in 0...__controls.count)
		{
			@:privateAccess __controls.members[i].__setOffsetY(y + value);
		}
	}
}