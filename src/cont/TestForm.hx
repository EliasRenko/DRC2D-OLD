package cont;

import cont.ui.UiList;
import cont.ui.UiControl;
import cont.ui.UiStamp;
import cont.ui.UiStamp;
import cont.ui.UiContainer;
import cont.ui.UiWindow;
import cont.ui.UiButton;
import cont.ui.UiLabel;
import drc.input.Control;
import cont.ui.UiPanel;
import cont.ui.UiMenustrip;
import drc.objects.State;
import cont.ui.UiForm;
import drc.utils.Common;
import cont.ui.UiEventType;
import drc.utils.Common;

class TestForm extends State {

    // ** Publics.

    public var form:UiForm;

    public var layers:Array<Layer> = new Array<Layer>();
 
    // ** Privates.

    private var __menustrip:UiMenustrip;

    private var __layout_tools:UiContainer;

    public var stamp_tools:UiStamp;
	
	public var stamp_selectionTool:UiStamp;
	
	public var stamp_brushTool:UiStamp;
	
	public var stamp_clippingTool:UiStamp;
	
	public var stamp_manipulationTool:UiStamp;
	
    public var stamp_tileTool:UiStamp;
    
    public var panel_info:UiPanel;

    public var label_info:UiLabel;

    public var window_layers:UiWindow;

    public var list_tiles:UiList<UiControl>;

    public function new() {
        
        super();

        form = new UiForm(640, 480);

        __menustrip = new UiMenustrip(640, 0, 0);

        form.addControl(__menustrip);

        // ** Menustrip.

        __menustrip.addLabel('File');

        __menustrip.addLabel('Edit');

        __menustrip.addLabel('View');

        __menustrip.addLabel('Help');

        __menustrip.addOption('New', 0);

        __menustrip.addOption('Open', 0);

        __menustrip.addOption('Save', 0);

        __menustrip.addOption('Load', 0);

        __menustrip.addOption('Exit', 0);

        __menustrip.addOption("Undo", 1);
		
        __menustrip.addOption("Redo", 1);
        
        // ** Tools.

        __layout_tools = new UiContainer(136, 68, 0, 380);

        form.addControl(__layout_tools);

        stamp_tools = new UiStamp(35, 0, 0);
		
        stamp_selectionTool = new UiStamp(36, 0, 2);
        stamp_selectionTool.onEvent.add(__onSelectionToolEvent);
		
        stamp_brushTool = new UiStamp(15, 34, 2);
        stamp_brushTool.onEvent.add(__onBrushToolEvent);
		
        stamp_clippingTool = new UiStamp(16, 68, 2);
        stamp_clippingTool.onEvent.add(__onClippingToolEvent);
		
		stamp_manipulationTool = new UiStamp(37, 102, 2);
		
		stamp_tileTool = new UiStamp(38, 0, 36);

        //__layout_tools.addControl(stamp_tools);
		
		__layout_tools.addControl(stamp_selectionTool);
		
		__layout_tools.addControl(stamp_brushTool);
		
		__layout_tools.addControl(stamp_clippingTool);
		
		__layout_tools.addControl(stamp_manipulationTool);
		
		__layout_tools.addControl(stamp_tileTool);

        panel_info = new UiPanel(640, 32, 0, 448);

        form.addControl(panel_info);

        label_info = new UiLabel('Info', 0, 8, 6);

        panel_info.addControl(label_info);

        addEntity(form);

        list_tiles = new UiList(128, 128, 0, 0);

        var _label:UiLabel = new UiLabel("Item1", 0, 0);

        list_tiles.addListItem(_label);
        //list_tiles.addListItem(new UiLabel("Item2"));

        

        window_layers = new UiWindow("Layers", 128, 256, 0, 32);

        form.addControl(window_layers);

        window_layers.addControl(list_tiles);

        // ** ---

        layers.push(new Layer());

        addGraphic(layers[0].tilemap);
    }

    private function __onSelectionToolEvent(control:UiControl, type:UiEventType):Void {

        switch(type) {

            case MOUSE_ENTER:

                label_info.text = 'Selection tool';

            case _:
        }
    }

    private function __onBrushToolEvent(control:UiControl, type:UiEventType):Void {

        switch(type) {

            case MOUSE_ENTER:

                label_info.text = 'Brush tool';

            case _:
        }
    }

    private function __onClippingToolEvent(control:UiControl, type:UiEventType):Void {

        switch(type) {

            case MOUSE_ENTER:

                label_info.text = 'Clipping tool';

            case _:
        }
    }

    override function render() {

        super.render();
    }

    override function update() {

        if (Common.input.mouse.released(1)) {

            layers[0].addTile(mouseX, mouseY);
        }

        if (Common.input.getGamepad(0).check(Control.A)) {

            form.__tilemap.z += 1;
        }

        if (Common.input.getGamepad(0).check(Control.B)) {

            form.__tilemap.z -= 1;
        }

        if (Common.input.getGamepad(0).check(Control.Y)) {

            camera.z += 1;
        }
        
        if (Common.input.getGamepad(0).check(Control.X)) {

            camera.z -= 1;
		}

        if (Common.input.getGamepad(0).check(Control.LEFT_SHOULDER)) {

            camera.yaw -= 1;
        }
        
        if (Common.input.getGamepad(0).check(Control.RIGHT_SHOULDER)) {

            camera.yaw += 1;
		}

        if (Common.input.getGamepad(0).check(Control.DPAD_UP)) {

            camera.y += 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_DOWN)) {

            camera.y -= 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_LEFT)) {

            camera.x += 1;
		}

		if (Common.input.getGamepad(0).check(Control.DPAD_RIGHT)) {

            camera.x -= 1;
        }
        
        super.update();
    }
}