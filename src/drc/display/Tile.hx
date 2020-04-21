package drc.display;

import drc.display.Graphic;
import drc.display.Tilemap;
import drc.display.Region;

class Tile extends Graphic {

    // ** Publics.

    public var id(get, set):Null<UInt>;

    /** Privates. **/

    private var __id:Null<UInt>;

    public var parentTilemap(get, set):Tilemap;

    /** @private */ private var __parentTilemap:Tilemap;

    public function new(parent:Tilemap, id:Null<UInt>, ?x:Int = 0, ?y:Int = 0) {

        super(x, y);

        if (parent != null)
        {
            parentTilemap = parent;

            vertices.upload(
            [
                64, 64, 0, 0, 0,
                64, 256, 0, 0, 1,
                256, 256, 0, 1, 1,
                256, 64, 0, 1, 0
            ]);
    
        }
       
        //__width = 256;

        //__height = 256;

        //__originX = __width / 2;

        //__originY = __height / 2;

        if (id == null) {

            return;
        }

        this.id = id;
    }

    public function add():Void {

        __add();
    }

    override function __add():Void 
    {
        //** Add itself to the parent tilemap.
        
        __parentTilemap.addTile(this);
    }
        
        override function __remove():Void 
        {
            //** Remove itself from the parent tilemap.
            
            __parentTilemap.removeTile(this);
        }

    override function render() {
        
        var radian = angle * (Math.PI / -180);
		
		var cosT = Math.cos(radian);
		
		var sinT = Math.sin(radian);
		
		var scaledWidth:Float = width * scaleX;
        var scaledHeight:Float = height * scaleY;
		
		var centerX:Float = originX;
        var centerY:Float = originY;
		
		vertices.innerData[parentTilemap.shadings["x"].positions[0]] = (__x + offsetX) - (cosT * centerX) - (sinT * centerY);
		
		vertices.innerData[parentTilemap.shadings["x"].positions[1]] = (__x + offsetX) - (cosT * centerX) + (sinT * (scaledHeight - centerY)); 
		
		vertices.innerData[parentTilemap.shadings["x"].positions[2]] = (__x + offsetX) + (cosT * (scaledWidth - centerX)) + (sinT * (scaledHeight - centerY));
		
		vertices.innerData[parentTilemap.shadings["x"].positions[3]] =  (__x + offsetX) + (cosT * (scaledWidth - centerX)) - (sinT * centerY);
		
		vertices.innerData[parentTilemap.shadings["y"].positions[0]] = (__y + offsetY) + (sinT * centerX) - (cosT * centerY);
		
		vertices.innerData[parentTilemap.shadings["y"].positions[1]] = (__y + offsetY) + (sinT * centerX) + (cosT * (scaledHeight - centerY));
		
		vertices.innerData[parentTilemap.shadings["y"].positions[2]] = (__y + offsetY) - (sinT * (scaledWidth - centerX)) + (cosT * (scaledHeight - centerY));
		
		vertices.innerData[parentTilemap.shadings["y"].positions[3]] = (__y + offsetY) - (sinT * (scaledWidth - centerX)) - (cosT * centerY);
		
		//** ---
		
		vertices.innerData[parentTilemap.shadings["z"].positions[0]] = __z;
		vertices.innerData[parentTilemap.shadings["z"].positions[1]] = __z;
		vertices.innerData[parentTilemap.shadings["z"].positions[2]] = __z;
		vertices.innerData[parentTilemap.shadings["z"].positions[3]] = __z;
    }

    // ** Getters and setters.

    private function get_id():UInt {
        
        return __id;
    }

    private function set_id(value:UInt):UInt {

        __id = value;

        if (parentTilemap == null)
        {
            //** Get the name of the class.
            
            var className = Type.getClassName(Type.getClass(this));
            
            //** Throw error!
            
            //DrcConsole.showTrace("Class: " + className + " has not been assigned a tilemap parent.");
            
            //** Return.
            
            return 0;
        }

        var rect:Region = parentTilemap.tileset.regions[value];

        if (rect == null)
        {
            rect = parentTilemap.tileset.regions[64];
        }

        vertices.innerData[parentTilemap.shadings["u"].positions[0]] = rect.values[0] / parentTilemap.textures[0].width;
		vertices.innerData[parentTilemap.shadings["v"].positions[0]] = rect.values[1] / parentTilemap.textures[0].height; //y
		
		vertices.innerData[parentTilemap.shadings["u"].positions[1]] = rect.values[0] / parentTilemap.textures[0].width;	//down
		vertices.innerData[parentTilemap.shadings["v"].positions[1]] = (rect.values[1] + rect.values[3]) / parentTilemap.textures[0].height;
		
		vertices.innerData[parentTilemap.shadings["u"].positions[2]] = (rect.values[0] + rect.values[2]) / parentTilemap.textures[0].width; //Width
		vertices.innerData[parentTilemap.shadings["v"].positions[2]] = (rect.values[1] + rect.values[3]) / parentTilemap.textures[0].height; //Height
		
		vertices.innerData[parentTilemap.shadings["u"].positions[3]] = (rect.values[0] + rect.values[2]) / parentTilemap.textures[0].width; //up
		vertices.innerData[parentTilemap.shadings["v"].positions[3]] = rect.values[1] / parentTilemap.textures[0].height;

        width = rect.values[2];
		
		//** Set the height of the tile.
		
		height = rect.values[3];

        return __id;
    }

    private function get_parentTilemap():Tilemap
        {
            //** Return.
            
            return __parentTilemap;
        }
        
        private function set_parentTilemap(tilemap:Tilemap):Tilemap
        {
            var active:Bool = __active;
            
            if (__parentTilemap != null)
            {
                __parentTilemap.removeTile(this);
                
                vertices.dispose();
            }

            vertices.insert(tilemap.profile.dataPerVertex * 4);
            
            __parentTilemap = tilemap;
            
            id = __id;
            
            if (active)
            {
                __add();
            }
            
            //** Return.
            
            return __parentTilemap;
        }
}