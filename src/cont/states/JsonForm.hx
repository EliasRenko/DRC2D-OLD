package cont.states;

import cont.ui.UiMenustrip;
import cont.ui.UiTextField;
import cont.ui.UiButton;
import cont.ui.UiPanel;
import cont.ui.UiTextBox;
import cont.ui.UiForm;
import cont.ui.UiList;
import cont.ui.UiWindow;
import cont.ui.UiEventType;
import cont.ui.UiControl;
import drc.system.Window;
import drc.types.WindowEventType;
import cont.ui.UiLabel;
import cont.ui.UiContainer;
import cont.ui.UiState;
import drc.utils.Common;
import drc.utils.Resources;

class JsonForm extends UiState {

    public function onEvent(control:UiControl, type:UInt) {

        trace(type);
    }

    public function new() {
        
        super();

        form.fromFile('res/ui/formDebug.json');

        var _window:UiWindow = new UiWindow('Title', 128, 128, 64, 64);

        form.addControl(_window);

        _window.onEvent.add(onEvent, 0);

        return;

        // ** ---

        var _menustrip:UiMenustrip = new UiMenustrip(640);

        _menustrip.addLabel('File');
        _menustrip.addLabel('Edit');
        _menustrip.addLabel('View');
        _menustrip.addLabel('Help');

        _menustrip.addOption('New', 0);
        _menustrip.addOption('Open', 0);
        _menustrip.addOption('Save', 0);
        _menustrip.addOption('Exit', 0);

        form.addControl(_menustrip);

        var _panel:UiPanel = new UiPanel(256, 384, 64, 64);

        form.addControl(_panel);

        var _label:UiLabel = new UiLabel('Console', 1, 8, 6);

        //_label.

        _panel.addControl(_label);

        var _textbox:UiTextBox = new UiTextBox('Unknow command "impulse 101"', 224, 256, 16, 48);

        _panel.addControl(_textbox);

        var _button:UiButton = new UiButton('Submit', 80, 32, 320);

        _panel.addControl(_button);
    }

    override function init() {

        super.init();
    }

    override function onWindowEvent(window:Window, type:WindowEventType) {

        super.onWindowEvent(window, type);
    }
}