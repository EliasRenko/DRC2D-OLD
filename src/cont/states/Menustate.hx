package cont.states;

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
import haxe.io.Path;
import drc.utils.Resources;

class Menustate extends UiState {

    private var __container:UiContainer;

    // ** Labels.

    /** @private **/ private var __label_newGame:UiLabel;

    /** @private **/ private var __label_loadGame:UiLabel;

    /** @private **/ private var __label_options:UiLabel;

    /** @private **/ private var __label_quit:UiLabel;

    /** @private **/ private var __window_newGame:UiWindow;

    /** @private **/ private var __list_maps:UiList<UiControl>;

    public function new() {
        
        super();

        __container = new UiContainer(320, 128);

        // ** Labels.

        __label_newGame = new UiLabel('New Game', 1, 0, 0);
        __label_newGame.onEvent.add(__onClick_newGame, ON_CLICK);

        __label_loadGame = new UiLabel('Load Game', 1, 0, 32);
        __label_loadGame.onEvent.add(__onClick_loadGame, ON_CLICK);

        __label_options = new UiLabel('Options', 1, 0, 64);
        __label_options.onEvent.add(__onClick_options, ON_CLICK);

        __label_quit = new UiLabel('Quit', 1, 0, 96);
        __label_quit.onEvent.add(__onClick_quit, ON_CLICK);

        // ** Windows.

        __window_newGame = new UiWindow('New Game', 256, 128, 64, 64);
        __window_newGame.visible = false;

        // ** List.

        __list_maps = new UiList();

        var path:String = Resources.path + '/res/maps';

        var maps:Array<String> = Resources.getDirectory('res/maps');

        for (i in 0...maps.length) {

            __list_maps.addListItem(new UiLabel(Path.withoutExtension(maps[i]), 0));
        }

        // ** ----

        __container.addControl(__label_newGame);

        __container.addControl(__label_loadGame);

        __container.addControl(__label_options);

        __container.addControl(__label_quit);

        __window_newGame.addControl(__list_maps);
    }

    override function init() {

        super.init();

        form.addControl(__container);

        form.addControl(__window_newGame);

        __container.x = 16;

        __container.y = Common.window.height - __container.height;
    }

    override function onWindowEvent(window:Window, type:WindowEventType) {

        super.onWindowEvent(window, type);

        if (type == RESIZED) {

            __container.y = window.height - __container.height;
        }
    }

    private function __onClick_newGame(control:UiControl, type:UiEventType):Void {

        __window_newGame.visible = true;
    }

    private function __onClick_loadGame(control:UiControl, type:UiEventType):Void {

    }

    private function __onClick_options(control:UiControl, type:UiEventType):Void {

    }

    private function __onClick_quit(control:UiControl, type:UiEventType):Void {

    }
}