package editor;

import drc.display.Region;
import drc.utils.Resources;
import drc.display.Image;
import cont.ui.UiDialog;
import editor.Editor;
import cont.ui.UiGraphic;

class TilemapDialog extends UiDialog {

    // ** Publics.

    public var layer:Layer;

    // ** Privates.

    private var __editor:Editor;

    private var __graphic:UiGraphic;

    public function new(editor:Editor, layer:Layer) {
        
        super('Tilemap', 320, 240);

        __editor = editor;

        this.layer = layer;

        var _image:Image = new Image(Resources.getProfile('res/profiles/texture.json'), [Resources.loadTexture('res/graphics/dev_tiles.png')]);

        __graphic = new UiGraphic(_image, 300, 260);

        addControl(__graphic);
    }

    override function init() {

        super.init();
    }

    override function updateCollision() {

        super.updateCollision();

        if (__graphic.collide) {

            if (__form.leftClick) {

                for (i in 0...layer.tileset.regions.length) {

                    var _region:Region = layer.tileset.regions[i];

                    if (__form.mouseX > _region.values[0] + __graphic.x + __graphic.__offsetX && __form.mouseY > _region.values[1] + __graphic.y + __graphic.__offsetY) {

                        if (__form.mouseX <= _region.values[0] + _region.values[2] + __graphic.x + __graphic.__offsetX && __form.mouseY <= _region.values[1] + _region.values[3] + __graphic.y + __graphic.__offsetY) {

                            trace('Collision ' + i);

                            __editor.active_id = i;

                            //return;
                        }
                    }
                    
                }
            }
        }
    }
}