package drc.display;

import drc.display.Region;

class Tileset {

    // ** Publics.

    public var regions:Array<Region>;

    public function new(?regions:Array<Region>) {
        
        if (regions == null) {

            this.regions = new Array<Region>();

            return;
        }

        this.regions = regions;
    }

    public function addRegion(region:Region):Void {

        regions.push(region);
    }
}