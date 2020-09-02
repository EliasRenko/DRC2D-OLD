package cont.ui;

import drc.system.Window;
import drc.types.WindowEventType;
import cont.ui.UiForm;
import drc.objects.State;
import drc.utils.Common;

class UiState extends State {

    // ** Publics.

    public var form:UiForm;

    public function new() {

        super();

        form = new UiForm(Common.window.width, Common.window.height);
    }

    override function init() {

        super.init();

        addEntity(form);
    }

    override function onWindowEvent(window:Window, type:WindowEventType) {

        super.onWindowEvent(window, type);

        form.resize(window.width, window.height);
    }
}