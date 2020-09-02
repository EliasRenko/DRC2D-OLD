package cont.ui;

import drc.display.Tile;

class UiTextBox extends UiPanel {

    // ** Publics.

    // ** Privates.

    private var __label:UiLabel;

    public function new(text:String, width:Float, height:Float, x:Int, y:Int) {

        super(width, height, x, y);

        __label = new UiLabel(text, 0, 4, 0);
    }

    override function init() {
        
        super.init();

        addControl(__label);
    }

    override function __initGraphics() {

        __graphics.addAt(0, new Tile(null, 45));
		
		__graphics.addAt(1, new Tile(null, 46));
		
		__graphics.addAt(2, new Tile(null, 47));
		
		__graphics.addAt(3, new Tile(null, 48));
		
		__graphics.addAt(4, new Tile(null, 49));
		
		__graphics.addAt(5, new Tile(null, 50));
		
		__graphics.addAt(6, new Tile(null, 51));
		
		__graphics.addAt(7, new Tile(null, 52));
		
		__graphics.addAt(8, new Tile(null, 53));
    }
}