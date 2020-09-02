package cont.ui;

import drc.display.Tile;
import drc.utils.Common;
import drc.part.Group;
import drc.utils.Common;
import StringTools;

class UiTextField extends UiLayout
{
	// ** Publics.
	
	public var maxCharacters:Int = -1;
	
	public var onClickHandler:UiControl->Void;
	
	public var text(get, set):String;

	public var restriction:String;
	
	// ** Privates.

	/** @private */ private var __graphics:Group<Tile>;
	
	/** @private */ private var __graphic:Tile;
	
	/** @private */ private var __label:UiLabel;
	
	/** @private */ private var __stamp:UiStamp;
	
	public function new(text:String, width:Float = 64, height:Float = 30, x:Float = 0, y:Float = 0) 
	{
		super(width, 30, x, y);
		
		__graphics = new Group<Tile>(3);
		
		__graphics.addAt(0, new Tile(null, UiForm.GRAPHIC_TEXTFIELD_0_ID));
		
		__graphics.addAt(1, new Tile(null, UiForm.GRAPHIC_TEXTFIELD_1_ID));
		
		__graphics.addAt(2, new Tile(null, UiForm.GRAPHIC_TEXTFIELD_2_ID));
		
		__label = new UiLabel(text, 1, 6, 4);

		__label.wordwrap = true;

		__label.fieldWidth = width;
		
		__stamp = new UiStamp(12, 0, 0);

		__type = 'textfield';
	}
	
	override public function init():Void 
	{
		super.init();
		
		//** Init the label.
		
		__initMember(__label);
		
		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].parentTilemap = @:privateAccess __form.__tilemap;
			
			@:privateAccess __form.__tilemap.addTile(__graphics.members[i]);
			
			__graphics.members[i].visible = visible;
			
			__graphics.members[i].z = __parent.z - 1;
		}
		
		__graphics.members[1].offsetX = 6;
		
		__graphics.members[2].offsetX = 22;
		
		//** Call setGraphicX method.
		
		__setGraphicX();
		
		//** Call setGraphicY method.
		
		__setGraphicY();
		
		__setWidth();
		
		__initMember(__stamp);
		
		__stamp.visible = false;
		
		__stamp.x = __label.width + 4;
		
		__setHitbox(0, 0, width, height);
	}
	
	override public function release():Void 
	{
		trace(__graphics.count);
		
		for (i in 0...__graphics.count) 
		{
			@:privateAccess __form.__tilemap.removeTile(__graphics.members[i]);
		}
		
		__label.release();
		
		__stamp.release();
		
		super.release();
	}
	
	private function __setWidth():Void
	{
		__graphics.members[1].width = __width - 12;
		
		__graphics.members[2].offsetX = __width - 6;
	}
	
	private function __setGraphicX():Void
	{
		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].x = __x + __offsetX;
		}
	}
	
	private function __setGraphicY():Void
	{
		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].y = __y + __offsetY;
		}
	}
	
	override public function update():Void 
	{
		super.update();

		if (focused) {

			if (Common.input.keyboard.pressed(42)) {

				__subString();
			}
		}
	}
	
	override public function updateCollision():Void 
	{
		super.updateCollision();

		if (collide)
		{
			//** Set the cursor.
			
			__form.cursorId = 5;
			
			//** If right click...
			
			if (__form.leftClick)
			{
				__form.selectedControl = this;
			}
		}
	}
	
	override public function onFocusGain():Void 
	{
		super.onFocusGain();
		
		__stamp.visible = true;
		
		__form.onTextBegin();

		__form.onEvent.add(__windowOnTextInput, 1);

		//DrcCommon.view.stage.window.onKeyDown.add(__windowOnKeyDown);
		
		//DrcCommon.view.stage.window.onTextInput.add(__windowOnTextInput);
	}
	
	override public function onFocusLost():Void 
	{
		super.onFocusLost();
		
		__stamp.visible = false;
		
		__form.onTextEnd();
		
		__form.onEvent.remove(__windowOnTextInput);

		//DrcCommon.view.stage.window.onKeyDown.remove(__windowOnKeyDown);
		
		//DrcCommon.view.stage.window.onTextInput.remove(__windowOnTextInput);
	}
	
	private function __windowOnTextInput(char:String, type:UInt):Void
	{
		if (restriction != null) {

			if (!StringTools.contains(restriction, char)) {

				return;
			}
		}

		__setText(text + char);
		
		__stamp.x = __label.width + 4;

		onEvent.dispatch(this, 10);
	}
	
	private function __setText(value:String):Void
	{
		if (maxCharacters != -1)
		{
			if (__label.text.length >= maxCharacters)
			{
				return;
			}
		}
		
		__label.text = value;
	}

	private function __subString() {
		
		text = text.substring(0, text.length - 1);

		onEvent.dispatch(this, 10);
	}
	
	//** Getters and setters.
	
	private function get_text():String
	{
		return __label.text;
	}
	
	private function set_text(value:String):String
	{
		__setText(value);
		
		return __label.text;
	}
	
	override function set_visible(value:Bool):Bool 
	{
		for (i in 0...__graphics.count) 
		{
			__graphics.members[i].visible = value;
		}
		
		__label.visible = value;
		
		return super.set_visible(value);
	}
	
	override function set_x(value:Float):Float 
	{
		super.set_x(value);
		
		//@:privateAccess __graphic.__setOffsetX(value);
		
		__label.__setOffsetX(value + __offsetX);
		
		//** Call setGraphicX method.
		
		__setGraphicX();
		
		return value;
	}
	
	override function set_y(value:Float):Float 
	{
		super.set_y(value);
		
		//@:privateAccess __graphic.__setOffsetY(value);
		
		__label.__setOffsetY(value + __offsetY);
		
		//** Call setGraphicY method.
		
		__setGraphicY();
		
		return value;
	}
	
	override function set_z(value:Float):Float 
	{
		return super.set_z(value);
	}
	
	override function __setOffsetX(value:Float):Void 
	{
		super.__setOffsetX(value);
		
		__setGraphicX();
		
		__label.__setOffsetX(x + value);
	}
	
	override function __setOffsetY(value:Float):Void 
	{
		super.__setOffsetY(value);
		
		__setGraphicY();
		
		__label.__setOffsetY(y + value);
	}
}