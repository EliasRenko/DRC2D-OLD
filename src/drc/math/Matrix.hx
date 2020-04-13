package drc.math;

import drc.buffers.Float32Array;

abstract Matrix(Float32Array) from Float32Array to Float32Array {

    /** Privates. **/

    private static var __identity:Array<Float> = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0];

    public function new(data:Float32Array = null) {

        if (data != null && data.length == 16)
        {
            this = data;
        }
        else
        {
            this = new Float32Array(16);
        }
    }

    public function createOrthoMatrix(x0:Float, x1:Float,  y0:Float, y1:Float, zNear:Float, zFar:Float, ?flipped:Bool = false):Float32Array {

        

        var i = this;

        if(i == null) i = new Float32Array(16);

        var sx = 1.0 / (x1 - x0);
        var sy = 1.0 / (y1 - y0);
        var sz = 1.0 / (zFar - zNear);


            i[ 0] = 2.0*sx;        i[ 1] = 0;            i[ 2] = 0;                 i[ 3] = 0;
            i[ 4] = 0;             i[ 5] = (2.0*sy);       i[ 6] = 0;                 i[ 7] = 0;
            i[ 8] = 0;             i[ 9] = 0;            i[10] = -2.0*sz;           i[11] = 0;
            i[12] = -1;            i[13] = 1;            i[14] = -(zNear+zFar)*sz;  i[15] = 1;

        return i;
    }

    public function createOrthoMatrix2(x0:Float, x1:Float,  y0:Float, y1:Float, zNear:Float, zFar:Float):Float32Array {

        var i = this;

        if(i == null) i = new Float32Array(16);

        var sx = 1.0 / (x1 - x0);
        var sy = 1.0 / (y1 - y0);
        var sz = 1.0 / (zFar - zNear);

            i[ 0] = 2.0*sx;        i[ 1] = 0;            i[ 2] = 0;                 i[ 3] = 0;
            i[ 4] = 0;             i[ 5] = (2.0*sy);       i[ 6] = 0;                 i[ 7] = 0;
            i[ 8] = 0;             i[ 9] = 0;            i[10] = -2.0*sz;           i[11] = 0;
            i[12] = -(x0+x1)*sx;   i[13] = -(y0+y1)*sy;  i[14] = -(zNear+zFar)*sz;  i[15] = 1;

        return i;
    }

    public function create2DMatrix(x:Float, y:Float, scale:Float = 1, rotation:Float = 0 ) {

        var i = this;
        
        if(i == null) i = new Float32Array(16);

        var theta = rotation * Math.PI / 180.0;
        var c = Math.cos(theta);
        var s = Math.sin(theta);

            i[ 0] = c*scale;  i[ 1] = -s*scale;  i[ 2] = 0;      i[ 3] = 0;
            i[ 4] = s*scale;  i[ 5] = c*scale;   i[ 6] = 0;      i[ 7] = 0;
            i[ 8] = 0;        i[ 9] = 0;         i[10] = 1;      i[11] = 0;
            i[ 12] = x;       i[13] = y;         i[14] = 0;      i[15] = 1;

        return i;

    } //create2DMatrix
}