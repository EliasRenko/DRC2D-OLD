package editor;

import cont.ui.UiList;
import cont.ui.UiControl;
import cont.ui.UiButton;
import cont.ui.UiTextField;
import cont.ui.UiDialog;
import cont.ui.UiComboBox;

class LayerDialog extends UiDialog {

    // ** Publics.
    
    public var textfield_name:UiTextField;
    
    public var button_create:UiButton;

    public var comboBox_tilemaps:UiComboBox;

    // ** Privates.

    private var __editor:Editor;

    public function new(editor:Editor) {

        super('New Layer', 256, 256);

        __editor = editor;

        textfield_name = new UiTextField('Layer ' + __editor.default_id, 128, 30, 4, 8);

        addControl(textfield_name);

        button_create = new UiButton('Create', 80, 6, 200, __onCreateClick);

        addControl(button_create);

        comboBox_tilemaps = new UiComboBox(128, 4, 32);

        addControl(comboBox_tilemaps);

        comboBox_tilemaps.addOption('Tileset');
    }

    private function __onCreateClick(control:UiControl, type:UInt):Void {

        __editor.addLayer(textfield_name.text);

        __editor.default_id ++;

        this.release();
    }
}