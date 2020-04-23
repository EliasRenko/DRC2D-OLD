package drc.core;

class Promise<T>
{
	// ** Publics.

	public var result:Dynamic;

	public var state:PromiseState;
	
	// ** Privates.

	private var fulfill_reactions: Array<Dynamic>;

	private var reject_reactions: Array<Dynamic>;
	
    private var settle_reactions: Array<Dynamic>;

	public function new<T>(func:T) {

		state = PENDING;

		fulfill_reactions = [];

		reject_reactions = [];
		
		settle_reactions = [];
		
		Promises.queue(function() {

			
		});
	}
}

class Promises {

	static var calls: Array<Dynamic> = [];

    static var defers: Array<{f:Dynamic,a:Dynamic}> = [];

        /** Call this once when you want to propagate promises */
    public static function step() {

        next();

        while(defers.length > 0) {

			var defer = defers.shift();
			
			defer.f(defer.a);
        }

    } //

        /** Handle the next job in the queue if any */
    public static function next() {

        if(calls.length > 0) (calls.shift())();
    } //

        /** Defer a call with an argument to the next step */
	public static function defer<T,T1>(f:T, ?a:T1) {

		if(f == null) return;
		
        defers.push({f:f, a:a});
    } //

        /** Queue a job to be executed in order */
	public static function queue<T>(f:T) {

		if(f == null) return;
		
        calls.push(f);
    } //
}

@:enum
abstract PromiseState(Int) from Int to Int {
        
    var PENDING = 0;
        
    var FULFILLED = 1;
        
    var REJECTED = 2;

}