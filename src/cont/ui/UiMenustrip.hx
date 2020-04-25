package cont.ui;

import drc.part.Group;
import src.cont.ui.UiStripPanel;

class UiMenustrip extends UiStrip
{
	// ** Privates.
	
	/** @private **/ private var __lastLabel:Float = 4;
	
	/** @private **/ private var __panels:Group<UiStripPanel> = new Group<UiStripPanel>();
	
	/** @private **/ //private var __selectedLabel:Null<Int>;
	
	public function new(width:Float, x:Float = 0, y:Float = 0) 
	{
		super(width, x, y);
		
		__graphics.members[0].id = UiForm.GRAPHIC_STRIP_0_ID;
		
		__graphics.members[1].id = UiForm.GRAPHIC_STRIP_1_ID;
		
		__graphics.members[2].id = UiForm.GRAPHIC_STRIP_2_ID;
	}
	
	override public function init():Void 
	{
		super.init();
		
		for (i in 0...__panels.count)
		{
			__children.members[i].x = __lastLabel;
			
			//** Call initMember method.
			
			__initMember(__panels.members[i]);
			
			__panels.members[i].x = __lastLabel;
			
			__panels.members[i].visible = false;
			
			__lastLabel += __children.members[i].width + 12;
		}
	}
	
	override public function release():Void 
	{
		super.release();
	}
	
	public function addLabel(text:String):Void
	{
		var label:UiControl = addControl(new UiLabel(text, __lastLabel, 2, __onLabelClick));
		
		var list:UiStripPanel = new UiStripPanel(128, label.x, 24);
		
		@:privateAccess list.__parent = this;
		
		if (__form != null)
		{
			//** Call initMember method.
			
			__initMember(list);
			
			list.visible = false;
			
			__lastLabel += label.width + 12;
		}
		
		__panels.add(list);
	}
	
	public function addOption(text:String, index:UInt, handler:UiControl->Void = null)
	{
		//var label:UiControl = addControl(new UiLabel(text, 4, 0));
		
		__panels.members[index].addControl(new UiLabel(text, 0, 0, handler));
	}
	
	private function __hideList(control:UiControl):Void
	{
		control.visible = false;
	}
	
	override public function update():Void 
	{
		super.update();
		
		for (i in 0...__panels.count)
		{
			__panels.members[i].update();
		}
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();
		
		if (__collisionIndex >= 0) {

			if (__form.rightClick) {
				
				//__panels.members[__collisionIndex].visible = true;
			}

			return;
		}

		for (i in 0...__panels.count)
		{
			__panels.members[i].updateCollision();
			
			if (__panels.members[i].collide)
			{
				__collide = true;
				
				return;
			}
		}
	}
	
	override public function onFocusLost():Void 
	{
		super.onFocusLost();
		
		// if (__selectedLabel != null)
		// {
		// 	__panels.members[__selectedLabel].visible = false;
		// }
		
		// __selectedLabel = null;
	}
	
	public function removeLabel(label:UiLabel):Void
	{
		
	}
	
	private function __onLabelClick(control:UiControl):Void
	{
		// if (__selectedLabel != null)
		// {
		// 	__panels.members[__selectedLabel].visible = false;
		// }
		
		// __selectedLabel = __collisionIndex;
		
		// __panels.members[__selectedLabel].visible = true;
		
		__form.selectedControl = __panels.members[__collisionIndex];

		//__selectedLabel = __collisionIndex;
	}
	
	//** Getters and setters.
	
	override function set_z(value:Float):Float 
	{
		for (i in 0...__panels.count)
		{
			__panels.members[i].z = value;
		}
		
		return super.set_z(value);
	}
}