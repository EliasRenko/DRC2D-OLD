package cont.ui;

import drc.display.Uniform;
import cont.ui.UiControl;
import drc.types.TextEvent;
import drc.core.EventDispacher;
import haxe.Json;
import drc.display.BlendFactor;
import drc.data.Profile;
import drc.display.Charmap;
import drc.display.Tile;
import drc.display.Tilemap;
import drc.objects.Entity;
import drc.utils.Resources;
import drc.utils.Common;
import cont.ui.UiEventType;

@:enum abstract ControlType(String) from String to String {

	var LABEL = 'label';

	var BUTTON = 'button';

	var STAMP = 'stamp';

	var MENUSTRIP = 'menustrip';

	var WINDOW = 'window';

	var TEXTFIELD = 'textfield';

	var LAYOUT = 'layout';
}

@:enum abstract FormEventType(Int) from Int to Int {

	var TEXT_INPUT_BEGIN = 1;

	var TEXT_INPUT_END = 0;
}

typedef DragControl = {

	var control:UiControl;

	var x:Float;

	var y:Float;
}

class UiForm extends Entity
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
	
	// ** ---

	public var cursorId(get, set):Int;
	
	public var height(get, set):Float;

	public var hoverControl(get, set):UiControl;

	public var mouseX:Float = 0;
	
	public var mouseY:Float = 0;
	
	public var leftClick:Bool;
	
	public var rightClick:Bool;

	public var leftCheck:Bool;
	
	public var rightCheck:Bool;
	
	public var lastChar:Int;
	
	public var selectedControl(get, set):UiControl;
	
	public var selected(get, null):Bool;

	public var onEvent:EventDispacher<String> = new EventDispacher<String>();
	
	public var dragControl:DragControl;

	public var width(get, set):Float;

	//** Privates.
	
	/** @private */ private var __dialog:UiDialog;
	
	/** @private */ private var __container:UiContainer;
	
	/** @private */ private var __charmap:Charmap;
	
	/** @private */ public var __tilemap:Tilemap;
	
	/** @private */ private var __profile:Profile;
	
	/** @private */ public var __cursor:Tile;
	
	/** @private */ private var __selectedControl:UiControl;

	/** @private */ public var __selectedControlOld:UiControl;

	/** @private */ private var __hoverControl:UiControl;

	/** @private */ private var __hoverControlOld:UiControl;
	
	/** @private */ private var __namedControlls:Map<String, UiControl>;

	/** @private */ public var __debugControl:UiControl;

	/** @private **/ public var __debugWindow:UiWindow;

	/** @private **/ public var __debugList:UiList<UiControl>;

	/** @private **/ public var __propertiesWindow:UiWindow;

	/** @private **/ public var __propertiesList:UiList<UiControl>;

	/** @private **/ public var __properties:Map<String, UiTextField>;

	public function new(width:Float, height:Float) {

		super();
		
		//Common.input.mouse.showCursor(false);
		
		__container = new UiContainer(width, height);
		
		__container.z = 0;
		
		@:privateAccess __container.__type = 'form';

		@:privateAccess __container.__form = this;

		@:privateAccess __container.__setHitbox(0, 0, 640, 480);

		// ** Debug window.

		__debugWindow = new UiWindow('Editor', 128, 256, 32, 32);

		__debugWindow.z = -10;
		
		__debugList = new UiList(128, 256);

		__propertiesWindow = new UiWindow('Properties', 256, 256, 350, 32);

		__propertiesWindow.z = -10;

		__propertiesList = new UiList(256, 256);

		__properties = new Map<String, UiTextField>();

		// ** ---

		__profile = Resources.getProfile("res/profiles/ui.json");
		
		__charmap = new Charmap(Resources.getProfile("res/profiles/font.json"), "res/fonts/nokiafc22.ttf");

		__charmap.blendFactors.source = BlendFactor.SRC_ALPHA;

		__charmap.blendFactors.destination = BlendFactor.ONE_MINUS_SRC_ALPHA;
		
		__tilemap = new Tilemap(__profile, [Resources.loadTexture("res/graphics/ui.psd")], Resources.loadTileset("res/graphics/ui.json"));

		__cursor = new Tile(__tilemap, 3, 0, 0);
		
		__cursor.z = -20;
		
		__cursor.centerOrigin();
		
		__selectedControlOld = __container;

		__hoverControlOld = __container;

		Common.input.textEvent.add(onTextInput);
	}
	
	override public function init():Void {

		super.init();
		
		//** Add the character map to the state.
		
		__state.addGraphic(__tilemap);
		
		__state.addGraphic(__charmap);
		
		//__tilemap.addTile(__cursor);


		//__container.addControl(__debugWindow);

		//__debugWindow.addControl(__debugList);

		//__container.addControl(__propertiesWindow);

		//__propertiesWindow.addControl(__propertiesList);

		var _controls:Array<String> = [

			'button',

			'label',

			'stamp',

			'menustrip'
		];

		for (i in 0..._controls.length) {

			var _label:UiLabel = new UiLabel(_controls[i], 1, 0, 0);
			
			_label.onEvent.add(__insertControl);

			__debugList.addListItem(_label);
		}

		var _properties:Array<String> = [

			'width',
			'height',
			'x',
			'y'
		];

		var _restriction:String = '1234567890';

		for (i in 0..._properties.length) {

			var _label:UiLabel = new UiLabel(_properties[i], 0, 0, 0);
			
			_label.onEvent.add(__onProperty);

			var _textfield:UiTextField = new UiTextField('', 64, 64);

			_textfield.name = _properties[i];

			_textfield.restriction = _restriction;

			var _container:UiContainer = new UiContainer(128, 32);

			_container.addControl(_label);

			_container.addControl(_textfield);

			__properties.set(_properties[i], _textfield);

			__propertiesList.addListItem(_container);
		}
	}

	public function onTextInput(textEvent:TextEvent, type:UInt):Void {

		onEvent.dispatch(textEvent.data, 1);
	}

	public function onTextBegin() {
		
		Common.input.beginTextInput();
	}

	public function onTextEnd() {

		Common.input.endTextInput();
	}

	private function __onProperty(control:UiControl, type:UiEventType):Void {
		
		if (__debugControl == null) return;

		var _label:UiLabel = cast(control, UiLabel);

		switch (_label.text) {

			case 'x':

				__debugControl.x = 0;
				
			case 'y':

				__debugControl.y = 0;

			case _:
		}
	}

	private function __insertControl(control:UiControl, type:UiEventType):Void {

		var _label:UiLabel = cast(control, UiLabel);

		switch (_label.text) {

			case BUTTON:

				__container.addControl(new UiButton("Default", 128, 0, 0));

			case LABEL:

				__container.addControl(new UiLabel('Default', 0, 0, 0));

			case STAMP:

				__container.addControl(new UiStamp(36, 0, 0));

			case _:
		}
	}

	override public function release():Void {

		super.release();
	}
	
	public function startDrag(control:UiControl):Void {

		control.onEvent.dispatch(control, ON_DRAG_START);

		dragControl = {

			control: control,

			x: mouseX - control.x,

			y: mouseY - control.y
		}
	}

	public function stopDrag():Void {

		dragControl.control.onEvent.dispatch(dragControl.control, ON_DRAG_STOP);

		dragControl = null;
	}

	public function addControl(control:UiControl):UiControl {

		//@:privateAccess control.__form = this;
		
		@:privateAccess control.__parent = __container;
		
		switch (control.type) {

			case MENUSTRIP:

				control.z = -32;

			case _:

				control.z = 0;
		}

		//__controls.add(control);
		
		return __container.addControl(control);
	}
	
	public function removeControl(control:UiControl):Void {

		//trace(@:privateAccess __container.__children.members[3] == null);
		
		control.release();
		
		//trace(@:privateAccess __container.__children.members[3] == null);
		
		//@:privateAccess __container.__children.members[1] = null;
	}
	
	public function showDialog(dialog:UiDialog):Void {

		if (__dialog != null)
		{
			__dialog.release();
		}
		
		__dialog = dialog;
		
		@:privateAccess __dialog.__parent = __container;
		
		__dialog.init();
		
		__dialog.x = (__container.width / 2) - (__dialog.width / 2); 
		
		__dialog.y = (__container.height / 2) - (__dialog.height / 2); 

		//__dialog.z = -16;
	}
	
	public function hideDialog():Void {

		if (__dialog == null)
		{
			return;
		}
		
		__dialog.release();
		
		__dialog = null;
	}
	
	public function resize(width:Float, height:Float):Void {

		__container.width = width;
		
		__container.height = height;
		
		@:privateAccess __container.__setHitbox(0, 0, width, height);

		__container.onFormResize();
	}
	
	public function fromFile(path:String):Void {

		__namedControlls = new Map<String, UiControl>();

		var data:Dynamic = Resources.getJson(path);

		if (Reflect.hasField(data, "controls"))
		{
			var controlsData:Dynamic = Reflect.field(data, "controls");

			__addJsonControls(controlsData, __container);
		}
	}

	private function __addJsonControls(data:Dynamic, parent:UiLayout):Void {
		
		for (i in 0...data.length) {

			var control:UiControl;

			switch(data[i].control) {

				case BUTTON:

					control = new UiButton(data[i].text, data[i].width, data[i].x, data[i].y);

				case LABEL:

					control = new UiLabel(data[i].text, data[i].heading, data[i].x, data[i].y);

				case STAMP:

					control = new UiStamp(data[i].id, data[i].x, data[i].y);

				case MENUSTRIP:

					var _menustrip = new UiMenustrip(640, 0, 0);

					if (Reflect.hasField(data[i], "labels")) {

						var labelsData:Dynamic = Reflect.field(data[i], "labels");

						for (labelCount in 0...labelsData.length) {

							_menustrip.addLabel(labelsData[labelCount].text);

							if (Reflect.hasField(labelsData[labelCount], "options")) {

								var optionsData:Dynamic = Reflect.field(labelsData[labelCount], "options");

								for (optionCount in 0...optionsData.length) {

									_menustrip.addOption(optionsData[optionCount].text, labelCount);
								}
							}
						}
					}

					control = _menustrip;

				case WINDOW:

					var _window:UiWindow = new UiWindow(data[i].header, data[i].width, data[i].height, data[i].x, data[i].y);

					if (Reflect.hasField(data[i], "children")) {

						var controlsData:Dynamic = Reflect.field(data[i], "children");
		
						__addJsonControls(controlsData, _window);
					}

					control = _window;

				case TEXTFIELD:

					var _textfield:UiTextField = new UiTextField(data[i].text, data[i].width, 30, data[i].x, data[i].y);

					control = _textfield;

				case LAYOUT:

					var _layout:UiLayout = new UiLayout(data[i].width, data[i].height, data[i].x, data[i].y);

					if (Reflect.hasField(data[i], "children")) {

						var controlsData:Dynamic = Reflect.field(data[i], "children");
		
						__addJsonControls(controlsData, _layout);
					}

					control = _layout;

				case _:

					continue;
			}

			parent.addControl(control);

			if (Reflect.hasField(data[i], "name")) {

				control.name = data[i].name;

				__namedControlls.set(data[i].name, control);
			}
		}
	}

	public function __setDebugControl(control:UiControl) {

		if (__debugControl != null) {

			@:privateAccess __debugControl.__debugOff();

			__debugControl.debug = false;

			__debugControl = null;

			//__properties.get('width').onEvent.remove(onChangeValue);

			//__properties.get('height').onEvent.remove(onChangeValue);

			__properties.get('x').onEvent.remove(onChangeValue);

			__properties.get('y').onEvent.remove(onChangeValue);
		}

		if (control != null) {

			__debugControl = control;

			__debugControl.debug = true;

			@:privateAccess __debugControl.__debugOn();

			var field = Reflect.field(__debugControl, '__x');

			//__properties.get('width').text = Std.string(Reflect.field(__debugControl, '__width'));
			//__properties.get('width').onEvent.add(onChangeValue, 10);

			//__properties.get('height').text = Std.string(Reflect.field(__debugControl, '__height'));
			//__properties.get('height').onEvent.add(onChangeValue, 10);

			__properties.get('x').text = Std.string(Reflect.field(__debugControl, '__x'));
			__properties.get('x').onEvent.add(onChangeValue, 10);

			__properties.get('y').text = Std.string(Reflect.field(__debugControl, '__y'));
			__properties.get('y').onEvent.add(onChangeValue, 10);
		}
	}

	private function onChangeValue(control:UiControl, type:UiEventType) {

		var _textfield:UiTextField = cast(control, UiTextField);

		var value = Std.parseInt(_textfield.text);

		var _field = Reflect.field(__debugControl, 'set_' + _textfield.name);

		Reflect.callMethod(__debugControl, _field, [value]);
	}

	override public function update():Void {

		cursorId = 3;

		

		// ** G.

		if (Common.input.keyboard.pressed(10)) {

			return;
		}

		if (__debugControl != null) {

			// ** Delete.

			if (Common.input.keyboard.pressed(127)) {

				__debugControl.release();
			}

			// ** Escape.

			if (Common.input.keyboard.pressed(27)) {

				//@:privateAccess __debugControl.__debugOff();

				//__debugControl = null;

				__setDebugControl(null);
			}

			// ** Right

			if (Common.input.keyboard.pressed(100)) {

				__debugControl.x += 1;
			}

			// ** Left

			if (Common.input.keyboard.pressed(97)) {

				__debugControl.x -= 1;
			}

			// ** Down

			if (Common.input.keyboard.pressed(115)) {

				__debugControl.y += 1;
			}

			// ** Up

			if (Common.input.keyboard.pressed(119)) {

				__debugControl.y -= 1;
			}
		}

		//lastChar = Common.input.keyboard.lastControl;
		
		leftClick = Common.input.mouse.pressed(1);
		
		rightClick = Common.input.mouse.pressed(3);

		leftCheck = Common.input.mouse.check(1);
		
		if (Common.input.mouse.hasMoved) {

			__cursor.x = mouseX = Common.input.mouse.x;
		
			__cursor.y = mouseY = Common.input.mouse.y;
		}
		
		if (dragControl != null) {

			if (leftCheck) {

				if (@:privateAccess dragControl.control.__allowDragX) {

					dragControl.control.x = mouseX - dragControl.x;
				}

				if (@:privateAccess dragControl.control.__allowDragY) {

					dragControl.control.y = mouseY - dragControl.y;
				}

				dragControl.control.onEvent.dispatch(dragControl.control, ON_DRAG);

				return;
			}

			stopDrag();
		}

		if (__dialog == null)
		{
			__container.update();
			
			__container.updateCollision();
		}
		else {

			__dialog.update();
		
			__dialog.updateCollision();
		}

		if (__selectedControl != null)
		{
			__selectedControlOld.onFocusLost();
	
			__selectedControlOld.selected = false;
			
			__selectedControlOld = __selectedControl;
			
			__selectedControlOld.selected = true;
			
			__selectedControlOld.onFocusGain();

			__selectedControl = null;
		}

		if (__hoverControl != null)
		{
			__hoverControlOld.onMouseLeave();
	
			__hoverControlOld.hover = false;
			
			__hoverControlOld = __hoverControl;
			
			__hoverControlOld.hover = true;
			
			__hoverControlOld.onMouseEnter();

			__hoverControl = null;
		}
	}
	
	//** Getters and Setters.
	
	private function get_cursorId():Int {

		return __cursor.id;
	}
	
	private function set_cursorId(value:Int):Int {

		return __cursor.id = value;
	}
	
	private function get_selectedControl():UiControl {

		return __selectedControl;
	}
	
	private function get_selected():Bool {

		return __container.selected;
	}
	
	private function set_selectedControl(control:UiControl):UiControl {

		__selectedControl = control;
		
		return __selectedControl;
	}

	private function get_hoverControl():UiControl {

		return __hoverControl;
	}

	private function set_hoverControl(control:UiControl):UiControl {

		__hoverControl = control;
		
		return __hoverControl;
	}

	private function set_selectedControl2(control:UiControl):UiControl {

		__selectedControl.onFocusLost();
		
		__selectedControl.selected = false;
		
		__selectedControl = control;
		
		__selectedControl.selected = true;
		
		__selectedControl.onFocusGain();
		
		return __selectedControl;
	}

	// ** Getters and setters.

	private function get_height():Float {
		
		return __container.height;
	}

	private function set_height(value:Float):Float {
		
		__container.height = value;

		return value;
	}

	private function get_width():Float {
		
		return __container.width;
	}

	private function set_width(value:Float):Float {
		
		__container.width = value;

		return value;
	}
}

private class FormEditor {

	// ** Privates.

	/** @private **/ private var __form:UiForm;

	public function new(form:UiForm) {

		__form = form;
	}

	public function saveJsonForm(path:String):Void {

		var file:String = '{\n"controls": [\n';

		@:privateAccess file += __saveJsonControls(__form.__container);

		file = file.substring(0, file.length - 1);

		file += ']\n}';

		Resources.saveText(path, file);
	}

	private function __saveJsonControls(container:UiContainer):String {

		var file:String = '';

		// for (control in container.controls.members) {

		// 	switch (control.type) {

		// 		case BUTTON:

		// 			var _button:UiButton = cast(control, UiButton);

		// 			file += '{\n"control": "${_button.type}",\n';

		// 			file += '\n"text": "${_button.text}",\n';

		// 			file += '\n"width": ${_button.width},\n';

		// 		case LABEL:

		// 			var _label:UiLabel = cast(control, UiLabel);

		// 			file += '{\n"control": "${_label.type}",\n';

		// 			file += '{\n"heading": "${_label.heading}",\n';

		// 			file += '\n"text": "${_label.text}",\n';

		// 		case STAMP:

		// 			var _stamp:UiStamp = cast(control, UiStamp);

		// 			file += '{\n"control": "${_stamp.type}",\n';

		// 			file += '\n"id": ${_stamp.id},\n';

		// 		case MENUSTRIP:

		// 			var _menustrip:UiMenustrip = cast(control, UiMenustrip);

		// 			file += '{\n"control": "${_menustrip.type}",\n';

		// 			if (_menustrip.controls.count != 0) {

		// 				file += '\n"labels": [\n';

		// 				for (controlCount in 0..._menustrip.controls.count) {

		// 					if (_menustrip.controls.members[controlCount].type == LABEL) {

		// 						var _label:UiLabel = cast(_menustrip.controls.members[controlCount], UiLabel);

		// 						file += '{\n"text": "${_label.text}"\n';

		// 						file += '},';
		// 					}
		// 				}

		// 				file = file.substring(0, file.length - 1);

		// 				file += '],';
		// 			}

		// 		case _:

		// 			continue;
		// 	}

		// 	file += '\n"x": ${control.x},\n';

		// 	file += '\n"y": ${control.y},\n';

		// 	if (control.name != '') {

		// 		file += '\n"name": "${control.name}"\n';
		// 	}

		// 	if (Reflect.hasField(control, '__children')) {
			
		// 	}

		// 	file += '},';	
		// }

		return file;
	}
}