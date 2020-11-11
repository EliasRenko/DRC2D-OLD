package drc.data;

class VertexData {

	//** Publics.
	
	/**
	 * The count of the vertices.
	 */
	public var count(get, null):Int;
	
	/**
	 * A vector list of all the vertex data.
	 */
	public var innerData:Array<Float> = new Array<Float>();
	
	//** Privates.
	
	/** @private */ private var __dataPerVertex:Int;
	
	//** Methods.
	
	/**
	 * Creates a new vertices instance.
	 * 
	 * @param	data: The data to be uploaded.
	 */
	public function new(?data:Array<Float>) {

		//** Check if the data is null.
		
		if (data != null) {

			//** Upload the data.
			
			upload(data);
		}
	}
	
	/**
	 * Add a new value into the list.
	 * 
	 * @param	value The value to be added.
	 * 
	 * @return The new lenght of the list.
	 */
	public function add(value:Float):Int {

		return innerData.push(value);
	}
	
	/**
	 * Dispose of the inner data of the list.
	 */
	public function dispose():Void {

		for (vertex in 0...innerData.length) {

			innerData.pop();
		}
	}
	
	/**
	 * Insert an amount of data into the list.
	 * 
	 * @param	count The amount of data to be uploaded.
	 * @param	value The default value to be uploaded.
	 */
	public function insert(count:UInt, value:Float = 1):Void {

		for (i in 0...count) {

			innerData.push(value);
		}
	}
	
	/**
	 * Remove an amount of data from the list.
	 * 
	 * @param	count
	 */
	public function pop(count:UInt):Void {

		for (i in 0...count) {

			innerData.pop();
		}
	}
	
	/**
	 * Resolve a copy of a value at the specified index.
	 * 
	 * @param	index The index position of the value.
	 * 
	 * @return	Float The selected value.
	 */
	public function resolve(index:Int):Float {

		return innerData[index];
	}
	
	/**
	 * Upload a vector of vertices.
	 * 
	 * @param	data The index data to be uploaded.
	 */
	public function upload(data:Array<Float>):Void {

		innerData = data;
	}
	
	//** Getters and setters.
	
	private function get_count():Int {
		
		return Std.int(innerData.length / __dataPerVertex);
	}
}