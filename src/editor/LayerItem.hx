package editor;

import drc.display.Tilemap;
import cont.ui.UiControl;
import cont.ui.UiStamp;
import cont.ui.UiLabel;
import cont.ui.UiLayout;
import cont.ui.UiEventType;

class LayerItem extends UiLayout{

    public var label:UiLabel;

    public var stamp:UiStamp;

    public var layer:Layer;

    // ** Privates.

    private var __editor:Editor;

    public function new(editor:Editor, text:String, layer:Layer) {
        
        super(128, 40);

        __editor = editor;

        this.layer = layer;

        label = new UiLabel(text, 0, 4, 6);

        addControl(label);

        stamp = new UiStamp(15, 32, 6);

        stamp.onEvent.add(__onVisiblity, ON_CLICK);

        addControl(stamp);
    }

    private function __onVisiblity(control:UiControl, type:UInt):Void {

        layer.visible = layer.visible ? false : true;
    }

    override function updateCollision() {

        super.updateCollision();
    }
}