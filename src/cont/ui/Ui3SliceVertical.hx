package cont.ui;

import drc.display.Tile;
import drc.part.Group;

class Ui3SliceVertical extends UiLayout {

    // ** Privates.

    /** @private **/ private var __graphics:Group<Tile>;

    public function new(graphics:Group<Tile>, x:Float = 0, y:Float = 0) {

        #if debug

        if (graphics.length != 3) throw '3SliceVertical must contain only 3 tiles.';

        #end

        var _width:Float = __graphics.members[0].width;

        var _height:Float = 0;

        for (i in 0...__graphics.count) {

            __graphics.members[i].x = _height;

            _height += __graphics.members[i].height;
        }

        super(_width, _height, x, y);
    }

    override function init() {

        super.init();

        for (i in 0...__graphics.count) 
        {
            __graphics.members[i].parentTilemap = @:privateAccess __form.__tilemap;
            
            @:privateAccess __form.__tilemap.addTile(__graphics.members[i]);

            __graphics.members[i].visible = visible;

            __graphics.members[i].z = __parent.z - 1;
        }


    }

    private function __setWidth():Void
    {
        __graphics.members[1].width = __width - 14;
        
        __graphics.members[2].offsetX = __width - 7;

        __graphics.members[4].offsetX = __width + 4;
    }
    
    private function __setGraphicX():Void
    {
        for (i in 0...__graphics.count) 
        {
            __graphics.members[i].x = __x + __offsetX;
        }
    }
    
    private function __setGraphicY():Void
    {
        for (i in 0...__graphics.count) 
        {
            __graphics.members[i].y = __y + __offsetY;
        }
    }
}