package drc.objects;

import drc.buffers.Float32Array;
import drc.math.Matrix;

class Camera {

    /** Privates. **/

    private static var __identity:Array<Float> = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0];

    private var __matrix:Matrix = new Matrix();

    public function new(data:Float32Array = null) {

    }

    public function render(modelMatrix:Matrix):Matrix {
        
        var _view:Matrix = new Matrix();

        _view.identity();

        //_view.append(this);

        _view.append(modelMatrix);

        __matrix.identity();

        _view.append(__matrix);

        _view.append(__matrix.createOrthoMatrix(0, 640, 480, 0, 1000, -1000));

        //_view.append(__matrix);

        return _view;
    }
}