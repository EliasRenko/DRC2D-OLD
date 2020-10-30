package drc.core;

import haxe.Timer;

class Promise<T> {

    // ** Publics.

    public var isComplete(get, null):Bool;

    public var state(get, null):PromiseState;

    public var result(get, null):T;

    public var time(get, null):Float;

    // ** Privates.

    /** @private **/ private var __completeListeners:EventDispacher<T>;

    /** @private **/ private var __isComplete:Bool = false;

    /** @private **/ private var __state:PromiseState = ON_QUEUE;

    /** @private **/ private var __result:T;

    /** @private **/ private var __queuedPromise:Promise<T>;

    /** @private **/ private var __funcToRun:((T)->Void, ()->Void)->Void;

    /** @private **/ private var __time:Float = 0;

    public function new(func:((T)->Void, ()->Void)->Void, shoudlRun:Bool = true) {

        __funcToRun = func;

        if (shoudlRun) {
            
            run();

            return;
        }
    }

    public function run():Void {

        __time = Timer.stamp();

        if (__state == ON_QUEUE) {

            __state = PENDING;

            __funcToRun(__resolve, __reject);
        }
    }

    public static function all<U>(promises:Array<Promise<U>>):Promise<Array<U>> {

        var _count:Int = 0;

        var _results:Array<U> = [];

        return new Promise<Array<U>>(function(resolve, reject) {
        
            var _resolve = function(index:Int, result:U):Void {

                _count ++;

                _results[index] = result;

                if (_count == promises.length) {

                    resolve(_results);
                }
            }

            var _reject = function():Void {

            }

            for (i in 0...promises.length) {

                //promises[i].then(_resolve, _reject)

                if (promises[i] == null) {

                    _resolve(i, null);

                    continue;
                }

                promises[i].onComplete(function(result:U, type:UInt) {

                    _resolve(i, result);
                });

                // ** On error.

            }

            //resolve(new Array<U>());
        });
    }

    public function onComplete(listener:(T, UInt)->Void):Promise<T> {

        if (listener == null) return this;

        if (__state == COMPLETE) {

            listener(__result, 0);

            if (__queuedPromise != null) {

                __queuedPromise.run();
            }
        }
        else if (__state == PENDING) {

            if (__completeListeners == null) {

                __completeListeners = new EventDispacher();
            }

            __completeListeners.add(listener, 0);
        }

        return this;
    }

    public function onReject():Void {

    }

    public function then<U>(func:((T)->Void, ()->Void)->Void):Promise<T> {

        // func:((T)->Void, ()->Void)->Void

        // public function then<U>(func:(T)->Promise<U>):Promise<U> {

        switch(__state) {

            case COMPLETE:

                return new Promise<T>(func);

            case PENDING:

                return __queuedPromise = new Promise<T>(func, false);

            case REJECTED:

                return null;

            case _:

                throw 'ERROR';
        }
    }

    public function progress():Void {
        
    }

    private function __resolve(result:T):Void {

        __time = Timer.stamp() - __time;

        __state = COMPLETE;

        //__isComplete = true;

        __result = result;

        if (__completeListeners == null) return;

        __completeListeners.dispatch(__result, 0);
    }

    private function __reject():Void {

        trace('Rejected!');
    }

    // ** Getters and setters.

    private function get_isComplete():Bool {

        return __isComplete;
    }

    private function get_state():PromiseState {

        return __state;
    }

    private function get_result():T {
        
        return __result;
    }

    private function get_time():Float {

        return __time;
    }
}

@:enum
abstract PromiseState(Int) from Int to Int {
        
    var ON_QUEUE = 0;

    var PENDING = 1;
        
    var COMPLETE = 2;
        
    var REJECTED = 3;
}