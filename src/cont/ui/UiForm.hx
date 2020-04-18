package cont.ui;

import drc.data.Profile;
import drc.display.Charmap;
import drc.display.Tile;
import drc.display.Tilemap;
import drc.objects.DrcEntity;
import drc.part.DrcRecycleList;
import drc.utils.Resources;
import drc.utils.Common;

class UiForm extends DrcEntity
{
	//** Publics.
	
	public static inline var GRAPHIC_BUTTON_0_ID:UInt = 17;
	
	public static inline var GRAPHIC_BUTTON_1_ID:UInt = 18;
	
	public static inline var GRAPHIC_BUTTON_2_ID:UInt = 19;
	
	public static inline var GRAPHIC_BUTTON_OFF_0_ID:UInt = 20;
	
	public static inline var GRAPHIC_BUTTON_OFF_1_ID:UInt = 21;
	
	public static inline var GRAPHIC_BUTTON_OFF_2_ID:UInt = 22;
	
	public static inline var GRAPHIC_TEXTFIELD_0_ID:UInt = 23;
	
	public static inline var GRAPHIC_TEXTFIELD_1_ID:UInt = 24;
	
	public static inline var GRAPHIC_TEXTFIELD_2_ID:UInt = 25;
	
	public static inline var GRAPHIC_PANEL_0_ID:UInt = 26;
	
	public static inline var GRAPHIC_PANEL_1_ID:UInt = 27;
	
	public static inline var GRAPHIC_PANEL_2_ID:UInt = 28;
	
	public static inline var GRAPHIC_PANEL_3_ID:UInt = 29;
	
	public static inline var GRAPHIC_PANEL_4_ID:UInt = 30;
	
	public static inline var GRAPHIC_PANEL_5_ID:UInt = 31;
	
	public static inline var GRAPHIC_PANEL_6_ID:UInt = 32;
	
	public static inline var GRAPHIC_PANEL_7_ID:UInt = 33;
	
	public static inline var GRAPHIC_PANEL_8_ID:UInt = 34;
	
	public static inline var GRAPHIC_STRIP_0_ID:UInt = 0;
	
	public static inline var GRAPHIC_STRIP_1_ID:UInt = 1;
	
	public static inline var GRAPHIC_STRIP_2_ID:UInt = 2;
	
	public static inline var CONST_GRAPHIC_CHECKBOX_0_ID:UInt = 9;
	
	public static inline var CONST_GRAPHIC_CHECKBOX_1_ID:UInt = 10;
	
	public var cursorId(get, set):Int;
	
	public var mouseX:Float = 0;
	
	public var mouseY:Float = 0;
	
	public var leftClick:Bool;
	
	public var rightClick:Bool;
	
	public var lastChar:Int;
	
	public var selectedControl(get, set):UiControl;
	
	public var selected(get, null):Bool;
	
	//** Privates.
	
	/** @private */ private var __dialog:UiDialog;
	
	/** @private */ private var __container:UiContainer;
	
	/** @private */ private var __charmap:Charmap;
	
	/** @private */ private var __tilemap:Tilemap;
	
	/** @private */ private var __profile:Profile;
	
	/** @private */ private var __cursor:Tile;
	
	/** @private */ private var __selectedControl:UiControl;
	
	public function new(width:Float, height:Float) 
	{
		super();
		
		//DrcCommon.input.mouse.hide();
		
		__container = new UiContainer(width, height);
		
		__container.z = 0;
		
		@:privateAccess __container.__form = this;
		
		//__box.init();
		
		@:privateAccess __container.__setHitbox(0, 0, 640, 480);
		
		__profile = Resources.getProfile("res/profiles/ui.json");
		
		__charmap = new Charmap(__profile, Resources.loadText("res/fonts/nokiafc22.json"));
		
		__tilemap = new Tilemap(__profile, Resources.loadTexture("res/graphics/ui.png"), Resources.loadTileset("res/graphics/ui.json"));
		
		__cursor = new Tile(__tilemap, 3, 0, 0);
		
		__cursor.z = -20;
		
		//__cursor.centerOrigin();
		
		__selectedControl = __container;
	}
	
	override public function init():Void 
	{
		super.init();
		
		//** Add the character map to the state.
		
		__state.addGraphic(__tilemap);
		
		__state.addGraphic(__charmap);
		
		__tilemap.addTile(__cursor);
	}
	
	override public function release():Void 
	{
		super.release();
	}
	
	public function addControl(control:UiControl):UiControl
	{
		//@:privateAccess control.__form = this;
		
		@:privateAccess control.__parent = __container;
		
		control.z = 0;
		
		//__controls.add(control);
		
		return __container.addControl(control);
	}
	
	public function removeControl(control:UiControl):Void
	{
		//trace(@:privateAccess __container.__children.members[3] == null);
		
		control.release();
		
		__container.removeControl(control);
		
		//trace(@:privateAccess __container.__children.members[3] == null);
		
		//@:privateAccess __container.__children.members[1] = null;
	}
	
	public function showDialog(dialog:UiDialog):Void
	{
		if (__dialog != null)
		{
			__dialog.release();
		}
		
		__dialog = dialog;
		
		@:privateAccess __dialog.__parent = __container;
		
		__dialog.init();
		
		__dialog.x = (__container.width / 2) - (__dialog.width / 2); 
		
		__dialog.y = (__container.height / 2) - (__dialog.height / 2); 
	}
	
	public function hideDialog():Void
	{
		if (__dialog == null)
		{
			return;
		}
		
		__dialog.release();
		
		__dialog = null;
	}
	
	public function resize(width:Float, height:Float):Void
	{
		__container.width = width;
		
		__container.height = height;
		
		@:privateAccess __container.__setHitbox(0, 0, width, height);
	}
	
	override public function update():Void
	{
		cursorId = 3;
		
		//lastChar = Common.input.keyboard.lastControl;
		
		leftClick = Common.input.mouse.pressed(1);
		
		rightClick = Common.input.mouse.pressed(2);
		
		//__cursor.x = mouseX = DrcCommon.input.mouse.windowX;
		
		//__cursor.y = mouseY = DrcCommon.input.mouse.windowY;
		
		if (__dialog == null)
		{
			__container.update();
			
			__container.updateCollision();
			
			if (__selectedControl != null)
			{
				//__selectedControl.postUpdate();
			}
			
			return;
		}
		
		__dialog.update();
		
		__dialog.updateCollision();
		
		// if (DrcCommon.input.keyboard.released(DrcKey.ESCAPE))
		// {
		// 	hideDialog();
		// }
	}
	
	private function __updateControls(control:UiControl):Void
	{
		//control.update();
		
		//control.updateCollision();
		
		//control.postUpdate();
	}
	
	//** Getters and Setters.
	
	private function get_cursorId():Int
	{
		return __cursor.id;
	}
	
	private function set_cursorId(value:Int):Int
	{
		return __cursor.id = value;
	}
	
	private function get_selectedControl():UiControl
	{
		return __selectedControl;
	}
	
	private function get_selected():Bool
	{
		return __container.selected;
	}
	
	private function set_selectedControl(control:UiControl):UiControl
	{
		__selectedControl.onFocusLost();
		
		__selectedControl.selected = false;
		
		__selectedControl = control;
		
		__selectedControl.selected = true;
		
		__selectedControl.onFocusGain();
		
		return __selectedControl;
	}
}