package cont.ui;

import drc.display.Drawable;

class UiGraphic extends UiLayout {

    // ** Privates.

    /** @private **/ private var __drawable:Drawable;

    public function new(drawable:Drawable, width:Float, height:Float, x:Float = 0, y:Float = 0) {
        
        super(width, height, x, y);

        __drawable = drawable;
    }

    override function init() {

        super.init();

        __drawable.z = z - 1;

        //** Call setGraphicX method.
		
		__setGraphicX();
		
		//** Call setGraphicY method.
		
		__setGraphicY();

        __form.state.addGraphic(__drawable);
    }

    override function release() {

        __drawable.remove();

        super.release();
    }

    private function __setGraphicX():Void
    {
        __drawable.x = __x + __offsetX;
    }
    
    private function __setGraphicY():Void
    {
        __drawable.y = __y + __offsetY;
    }

    override function set_x(value:Float):Float 
    {
        //** Super set_x.
        
        super.set_x(value);
        
        //** Call setGraphicX method.
        
        __setGraphicX();
        
        //** Return.
        
        return value;
    }
    
    override function set_y(value:Float):Float 
    {
        //** Super set_y.
        
        super.set_y(value);
        
        //** Call setGraphicY method.
        
        __setGraphicY();
        
        //** Return.
        
        return value;
    }
    
    override function set_z(value:Float):Float 
    {
        //** Super set_y.
        
        super.set_z(value);
        
        //** Set the z of the graphic.
        
        __drawable.z = __z;
        
        //** Return.
        
        return value;
    }
    
    override function __setOffsetX(value:Float):Void 
    {
        super.__setOffsetX(value);
        
        __setGraphicX();
    }
    
    override function __setOffsetY(value:Float):Void 
    {
        super.__setOffsetY(value);
        
        __setGraphicY();
    }
}