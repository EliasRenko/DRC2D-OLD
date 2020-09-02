package editor;

import cont.ui.UiCheckBox;
import cont.ui.UiStamp;
import cont.ui.UiScrollBar;
import drc.system.Window;
import drc.types.WindowEventType;
import drc.display.Image;
import drc.display.Region;
import drc.display.Tile;
import drc.display.Tilemap;
import editor.Layer;
import cont.ui.UiDialog;
import cont.ui.UiButton;
import cont.ui.UiLabel;
import cont.ui.UiList;
import cont.ui.UiWindow;
import cont.ui.UiControl;
import cont.ui.UiMenustrip;
import cont.ui.UiState;
import editor.LayerDialog;
import drc.utils.Resources;
import drc.utils.Common;
import editor.LayerItem;
import cont.ui.UiEventType;
import editor.TilemapDialog;
import cont.ui.UiSlider;

class Editor extends UiState {

    // ** Publics.

    public var active_layer:Layer;

    public var active_id:UInt = 0;

    public var default_id:UInt = 0;

    public var grid:Image;

    public var scrollBar:UiScrollBar;

    // ** Privates.

    /** @private **/ private var __menustrip:UiMenustrip;

    /** @private **/ private var __window_layers:UiWindow;

    /** @private **/ private var __list_layers:UiList<LayerItem>;

    /** @private **/ private var __button_addLayer:UiButton;

    public function new() {

        super();

        __menustrip = new UiMenustrip(640);

        __menustrip.addLabel('File');

        __menustrip.addOption('New', 0, __onFileClick);

        __menustrip.addOption('Open', 0, __onOpenClick);

        __menustrip.addOption('Save', 0, __onSaveClick);

        __menustrip.addOption('Exit', 0, __onExitClick);

        __menustrip.addLabel('Edit');

        __menustrip.addLabel('View');

        __menustrip.addOption('Layers', 2, __onShowLayersClick);

        __menustrip.addLabel('Help');

        form.addControl(__menustrip);

        __window_layers = new UiWindow('Layers', 128, 360, 0, 32);

        __window_layers.shouldClose = false;

        form.addControl(__window_layers);

        __list_layers = new UiList(128, 128, 0, 0);

        scrollBar = new UiScrollBar(__list_layers);

        __window_layers.addControl(scrollBar);

        

        //scrollBar.addControl(__list_layers);

        __button_addLayer = new UiButton('Add Layer', 106, 6, 260, __onAddLayerClick);

        __window_layers.addControl(__button_addLayer);

        grid = new Image(Resources.getProfile('res/profiles/texture.json'), [Resources.loadTexture('res/graphics/bg.png')]);

        grid.width = 640;

        grid.height = 480;

        var _slider:UiSlider = new UiSlider('Test', 300, 256, 256);

        form.addControl(_slider);

        var _checkbox:UiCheckBox = new UiCheckBox('Active', 100, 64);

        form.addControl(_checkbox);

        addGraphic(grid);

        //var _scrollBar:UiScrollBar = new UiScrollBar(128, 128, 320, 240);

        //form.addControl(_scrollBar);

        //var _stamp:UiStamp = new UiStamp(15, 40, 16);

        //_scrollBar.addControl(_stamp);
    }

    public function addLayer(name:String):Void {

        var _layer:Layer = new Layer(Resources.getProfile("res/profiles/texture.json"), [Resources.loadTexture("res/graphics/dev_tiles.png")]);

        _layer.tileset.addRegion({values: [0, 0, 32, 32]});
        _layer.tileset.addRegion({values: [32, 0, 32, 32]});
        _layer.tileset.addRegion({values: [0, 32, 32, 32]});
        _layer.tileset.addRegion({values: [32, 32, 32, 32]});

        active_layer = _layer;

        addGraphic(_layer);

        var _layerItem:LayerItem = new LayerItem(this, name, _layer);

        _layerItem.onEvent.add(__onLayerClick, ON_CLICK);

        __list_layers.addListItem(_layerItem);
    }

    public function setActiveLayer(layer:Layer) {

        active_layer = layer;
    }

    override function update() {

        super.update();

        if (Common.input.keyboard.released(43)) {

            var _tilemapDialog:TilemapDialog = new TilemapDialog(this, active_layer);

            form.showDialog(_tilemapDialog);
        }

        if (Common.input.mouse.pressed(1)) {

            if (form.__selectedControlOld.type == 'form') {

                if (active_layer == null) return;

                if (active_layer.visible) {

                    var _tile:Tile = new Tile(active_layer, active_id, mouseX, mouseY);

                    _tile.add();
                }
            }
        }
    }

    override function onWindowEvent(window:Window, type:WindowEventType) {
        
        super.onWindowEvent(window, type);

        switch (type) {

            case SIZE_CHANGED:

                form.resize(window.width, window.height);

            case _:
        }
    }

    private function __onFileClick(control:UiControl, type:UInt):Void {

    }

    private function __onOpenClick(control:UiControl, type:UInt):Void {

    }

    private function __onSaveClick(control:UiControl, type:UInt):Void {

    }

    private function __onExitClick(control:UiControl, type:UInt):Void {

    }

    private function __onShowLayersClick(control:UiControl, type:UInt):Void {

        if (__window_layers.visible) return;

        __window_layers.visible = true;
    }

    private function __onLayerClick(control:UiControl, type:UInt):Void {

        var _layerItem:LayerItem = cast(control, LayerItem);

        active_layer = _layerItem.layer;
    }

    private function __onAddLayerClick(control:UiControl, type:UInt):Void {
        
        var _layerDialog:LayerDialog = new LayerDialog(this);

        form.showDialog(_layerDialog);
    }
}