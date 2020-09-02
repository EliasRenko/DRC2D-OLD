package cont.ui;

import drc.display.Tile;
import drc.part.Group;
import cont.ui.UiEventType;
import drc.utils.Common;

class UiSlider extends UiLayout {

    // ** Publics.

    public var multiplier:Float = 1;

    public var precision:Int = 0;

    public var value(get, set):Float;

    // ** Privates.

    /** @private **/ private var __graphics:Group<Tile>;

    /** @private **/ private var __grip:UiSliderGrip;

    /** @private **/ private var __label_title:UiLabel;

    /** @private **/ private var __label:UiLabel;

    /** @private **/ private var __value:Float;

    public function new(name:String, width:Float, x:Float, y:Float) {

        super(width, 36, x, y);

        __grip = new UiSliderGrip(0, 14);

        __grip.onEvent.add(__onGripDrag, ON_DRAG);

        __label_title = new UiLabel(name, 0, 0, 0);

        __label = new UiLabel('0', 0, width + 8, 19);

        __graphics = new Group<Tile>(3);
		
		__graphics.addAt(0, new Tile(null, 59));
		
		__graphics.addAt(1, new Tile(null, 60));
		
        __graphics.addAt(2, new Tile(null, 61));
        
        __graphics.addAt(3, new Tile(null, 62));

        __graphics.addAt(4, new Tile(null, 63));
    }

    override public function init():Void 
    {
        super.init();

        super.addControl(__grip);

        super.addControl(__label_title);

        super.addControl(__label);

        for (i in 0...__graphics.count) 
        {
            __graphics.members[i].parentTilemap = @:privateAccess __form.__tilemap;
            
            @:privateAccess __form.__tilemap.addTile(__graphics.members[i]);
            
            __graphics.members[i].offsetY = 20;

            __graphics.members[i].visible = visible;

            __graphics.members[i].z = __parent.z - 1;
        }
        
        __graphics.members[1].offsetX = 7;
        
        __graphics.members[2].offsetX = 23;
        
        __graphics.members[3].offsetX = 7;

        __graphics.members[3].z -= 1;

        __graphics.members[4].offsetY = 18;

        __setWidth();

        //** Call setGraphicX method.
		
		__setGraphicX();
		
		//** Call setGraphicY method.
		
		__setGraphicY();
    }

    private function __setWidth():Void
    {
        __graphics.members[1].width = __width - 14;
        
        __graphics.members[2].offsetX = __width - 7;

        __graphics.members[4].offsetX = __width + 3;
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

    override function update() {

        super.update();

        if (selected) {
                
            if (Common.input.keyboard.pressed(79)) {

                value ++;

                return;
            }

            if (Common.input.keyboard.pressed(80)) {

                value --;

                return;
            }
        }
    }

    override function updateCollision() {

        super.updateCollision();

        if (collide) {

        }
    }

    private function __onGripDrag(control:UiControl, type:UInt):Void {

        if (control.x < 0) {
			
			control.x = 0;
		}

		if (control.x > width - __grip.width) {

			control.x = width - __grip.width;
		}

		__value = ((control.x / (width - 12)) * 100) * multiplier;

        __value = __round(__value, precision);

        __graphics.members[3].width = control.x;

        __label.text = Std.string(__value);
    }

    private function __round(value:Float, precision:Int):Float {

        var num = value;

        num = num * Math.pow(10, precision);

        num = Math.round(num) / Math.pow(10, precision);

        return num;
    }

    // ** Getters and setters.

    private function get_value():Float {

        return __value;
    }

    private function set_value(value:Float):Float {

        if (value < 0) value = 0;

        if (value > 100) value = 100;

        __value = value;

        __grip.x = (value / 100) * (width - 12);

        return __value;
    }

    override function set_x(value:Float):Float 
    {
        super.set_x(value);
        
        __setGraphicX();
        
        //@:privateAccess __label.__setOffsetX(x + value);
        
        return value;
    }
    
    override function set_y(value:Float):Float 
    {
        super.set_y(value);
        
        __setGraphicY();
        
        //@:privateAccess __label.__setOffsetY(y + value);
        
        return value;
    }
    
    override function set_z(value:Float):Float 
    {
        //@:privateAccess __label.z = value - 3;
        
        for (i in 0...__graphics.count)
        {
            __graphics.members[i].z = value;
        }

        __label_title.z = value - 1;

        __label.z = value - 1;

        return value;
    }
    
    override function __setOffsetX(value:Float):Void 
    {
        super.__setOffsetX(value);
        
        __setGraphicX();
        
        //@:privateAccess __label.__setOffsetX(x + value);
    }
    
    override function __setOffsetY(value:Float):Void 
    {
        super.__setOffsetY(value);
        
        __setGraphicY();
        
        //@:privateAccess __label.__setOffsetY(y + value);
    } 
}

private class UiSliderGrip extends UiStamp {

	public function new(x:Float, y:Float) {
		
		super(58, x, y);

        __allowDragY = false;
        
        z = -3;
	}

	override function updateCollision() {

		super.updateCollision();

		if (collide) {

			if (__form.leftClick) {

				__form.startDrag(this);
			}
		}
	}
}