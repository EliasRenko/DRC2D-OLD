package cont;

import cont.ui.UiPanel;
import cont.ui.UiMenustrip;
import drc.objects.State;
import cont.ui.UiForm;

class TestForm extends State {

    public var form:UiForm;

    public function new() {
        
        super();

        form = new UiForm(640, 480);

        var c:UiMenustrip = new UiMenustrip(640, 0, 0);

        var panel:UiPanel = new UiPanel();

        addEntity(form);

        form.addControl(c);
        //form.addControl(panel);

        //c.addLabel('File');
        //c.addLabel('Edit');
        //c.addLabel('View');
        //c.addLabel('Help');
    }

    override function render() {

        super.render();
    }

    override function update() {

        super.update();
    }
}