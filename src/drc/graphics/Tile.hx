package drc.graphics;

import drc.display.Drawable;

class Tile extends Drawable {

    /** Privates. **/

    private var __parentTilemap:Tilemap;

    public function new(parent:Tilemap, x:Int = 0, y:Int = 0, id:UInt = 0) {

        super(x, y);

        __parentTilemap = parent;

        vertices.upload(
        [
            64, 64, 0, 0, 0,
            64, 256, 0, 0, 1,
            256, 256, 0, 1, 1,
            256, 64, 0, 1, 0
        ]);

        __width = 256;

        __height = 256;

        //__originX = __width / 2;

        //__originY = __height / 2;
    }

    override function render() {
        
        var radian = angle * (Math.PI / -180);
		
		var cosT = Math.cos(radian);
		
		var sinT = Math.sin(radian);
		
		var scaledWidth:Float = width * scaleX;
        var scaledHeight:Float = height * scaleY;
		
		var centerX:Float = originX;
        var centerY:Float = originY;
		
		vertices.innerData[__parentTilemap.shadings["x"].positions[0]] = (__x + offsetX) - (cosT * centerX) - (sinT * centerY);
		
		vertices.innerData[__parentTilemap.shadings["x"].positions[1]] = (__x + offsetX) - (cosT * centerX) + (sinT * (scaledHeight - centerY)); 
		
		vertices.innerData[__parentTilemap.shadings["x"].positions[2]] = (__x + offsetX) + (cosT * (scaledWidth - centerX)) + (sinT * (scaledHeight - centerY));
		
		vertices.innerData[__parentTilemap.shadings["x"].positions[3]] =  (__x + offsetX) + (cosT * (scaledWidth - centerX)) - (sinT * centerY);
		
		vertices.innerData[__parentTilemap.shadings["y"].positions[0]] = (__y + offsetY) + (sinT * centerX) - (cosT * centerY);
		
		vertices.innerData[__parentTilemap.shadings["y"].positions[1]] = (__y + offsetY) + (sinT * centerX) + (cosT * (scaledHeight - centerY));
		
		vertices.innerData[__parentTilemap.shadings["y"].positions[2]] = (__y + offsetY) - (sinT * (scaledWidth - centerX)) + (cosT * (scaledHeight - centerY));
		
		vertices.innerData[__parentTilemap.shadings["y"].positions[3]] = (__y + offsetY) - (sinT * (scaledWidth - centerX)) - (cosT * centerY);
		
		//** ---
		
		vertices.innerData[__parentTilemap.shadings["z"].positions[0]] = __z;
		vertices.innerData[__parentTilemap.shadings["z"].positions[1]] = __z;
		vertices.innerData[__parentTilemap.shadings["z"].positions[2]] = __z;
		vertices.innerData[__parentTilemap.shadings["z"].positions[3]] = __z;
    }
}