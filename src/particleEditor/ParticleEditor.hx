package particleEditor;

import cont.ui.UiSlider;
import drc.utils.Resources;
import drc.data.Profile;
import drc.objects.Emitter;
import drc.display.Tilemap;
import cont.ui.UiWindow;
import cont.ui.UiControl;
import cont.ui.UiMenustrip;
import cont.ui.UiState;
import drc.utils.Common;

class ParticleEditor extends UiState {

    // ** Privates.

    /** @private **/ private var __menustrip:UiMenustrip;

    /** @private **/ private var __window_options:UiWindow;

    /** @private **/ private var __slider_interval:UiSlider;

    /** @private **/ private var __slider_lifespan:UiSlider;

    /** @private **/ private var __slider_speed:UiSlider;

    /** @private **/ private var __slider_speedVariant:UiSlider;

    /** @private **/ private var __slider_gravity:UiSlider;

    /** @private **/ private var __profile:Profile;

    /** @private **/ private var __tilemap:Tilemap;

    /** @private **/ private var __emitter:Emitter;

    public function new() {
        
        super();

        Common.stage.resize(1366, 768);

        Common.window.resize(1366, 768);

        __profile = Resources.getProfile("res/profiles/texture.json");

        __tilemap = new Tilemap(__profile, [Resources.loadTexture("res/graphics/dev_tiles.png")]);

        __tilemap.tileset.addRegion({values: [0, 0, 32, 32]});

        // ** Menustrip - Main.

        __menustrip = new UiMenustrip(1366);

        __menustrip.addLabel('File');

        __menustrip.addOption('New', 0, __onFileClick);

        __menustrip.addOption('Open', 0, __onOpenClick);

        __menustrip.addOption('Save', 0, __onSaveClick);

        __menustrip.addOption('Exit', 0, __onExitClick);

        __menustrip.addLabel('Edit');

        __menustrip.addLabel('View');

        __menustrip.addOption('Editor', 2, __onEditorOptionClick);

        __menustrip.addLabel('Help');

        form.addControl(__menustrip);

        // ** Window - Options.

        __window_options = new UiWindow('Options', 128, 256, 0, 31);

        __slider_interval = new UiSlider('Interval', 96, 4, 0);

        __slider_interval.multiplier = 0.01;

        __slider_interval.precision = 2;

        __window_options.addControl(__slider_interval);

        __slider_lifespan = new UiSlider('Lifespan', 96, 4, 40);

        __slider_lifespan.multiplier = 0.2;

        __slider_lifespan.precision = 2;

        __slider_lifespan.value = 2;

        __window_options.addControl(__slider_lifespan);

        __slider_speed = new UiSlider('Speed', 96, 4, 80);

        __slider_speed.multiplier = 0.1;

        __slider_speed.precision = 2;

        __window_options.addControl(__slider_speed);

        __slider_speedVariant = new UiSlider('Speed Var', 96, 4, 120);

        __slider_speedVariant.multiplier = 0.1;

        __slider_speedVariant.precision = 2;

        __window_options.addControl(__slider_speedVariant);

        __slider_gravity = new UiSlider('Gravity', 96, 4, 160);

        __slider_gravity.multiplier = 0.1;

        __slider_gravity.precision = 2;

        __window_options.addControl(__slider_gravity);

        form.addControl(__window_options);

        // ** Emitter.

        __emitter = new Emitter(__tilemap);

        addGraphic(__tilemap);
    }

    override function render() {

        __emitter.emit(683, 384, 90, 0);

        //trace(__tilemap.tiles.passiveCount);

        super.render();
    }

    override function update() {

        __emitter.interval = __slider_interval.value;

        __emitter.lifespan = __slider_lifespan.value; 

        __emitter.speed = __slider_speed.value;

        __emitter.gravity = __slider_gravity.value;

        super.update();
    }

    private function __onFileClick(control:UiControl, type:UInt):Void {

    }

    private function __onOpenClick(control:UiControl, type:UInt):Void {

    }

    private function __onSaveClick(control:UiControl, type:UInt):Void {

    }

    private function __onExitClick(control:UiControl, type:UInt):Void {

    }

    private function __onEditorOptionClick(control:UiControl, type:UInt):Void {

    }
}