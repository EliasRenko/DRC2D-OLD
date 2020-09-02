package cont.ui;

import cont.ui.UiEventType;

class UiComboBox extends UiLayout {

    // ** Publics.

    // ** Privates.

    /** @private **/ private var __comboBoxButton:UiComboBoxButton;

    /** @private **/ private var __stripPanel:UiStripPanel;

    public function new(width:Int, x:Float, y:Float) {

        super(width, 40, x, y);

        __comboBoxButton = new UiComboBoxButton(width, x, y);

        __comboBoxButton.onEvent.add(__onButton_click, ON_CLICK);

        __stripPanel = new UiStripPanel(width, x, y + 32);
    }

    override function init():Void {
    
        super.init();

        addControl(__comboBoxButton);

        __initMember(__stripPanel);
			
        __stripPanel.visible = false;
    }

    override function release() {

        __stripPanel.release();

        super.release();
    }

    public function addOption(text:String):Void {

        var _label:UiLabel = new UiLabel(text, 0);

        _label.onEvent.add(__onOption_click, ON_CLICK);

        __stripPanel.addControl(_label);

        //var _listItem:UiListItem = cast(__stripPanel.addControl(_label), UiListItem);

        //_listItem.onEvent.add(__onOption_click, ON_CLICK);
    }

    override function update():Void {
        
        __stripPanel.update();
    }
    
    override function updateCollision():Void {

        super.updateCollision();

        __stripPanel.updateCollision();
    }

    private function __onButton_click(control:UiControl, type:UiEventType):Void {

		__form.selectedControl = __stripPanel;
    }

    private function __onOption_click(control:UiControl, type:UiEventType):Void {

        var _label:UiLabel = cast(control, UiLabel);

        __comboBoxButton.text = _label.text;
    }
    
    override function set_x(value:Float):Float {

        super.set_x(value);

        @:privateAccess __stripPanel.__setOffsetX(x + value);

        return __x;
    }

    override function set_y(value:Float):Float {

        super.set_y(value);

        @:privateAccess __stripPanel.__setOffsetY(y + value);

        return __y;
    }
    override function set_z(value:Float):Float {

        super.set_z(value);

        __stripPanel.z = value;

        return  __z;
    }

    override function __setOffsetX(value:Float):Void 
    {
        super.__setOffsetX(value);
        
        @:privateAccess __stripPanel.__setOffsetX(x + value);
    }
    
    override function __setOffsetY(value:Float):Void 
    {
        super.__setOffsetY(value);
        
        @:privateAccess __stripPanel.__setOffsetY(y + value);
    }
}

private class UiComboBoxButton extends UiButton {

    public function new(width:Int, x:Float, y:Float) {

        super('Test', width, x, y);
    }
}