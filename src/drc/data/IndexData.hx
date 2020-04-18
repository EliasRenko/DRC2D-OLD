package drc.data;

class IndexData 
{
	//** Publics.
	
	/**
	 * The lenght of the innerData vector. Cannot be set.
	 */
	public var count(get, null):Int;
	
	/**
	 * A vector array of all the indices.
	 */
	public var innerData:Array<UInt> = new Array<UInt>();
	
	/**
	 * Creates a new indices instance.
	 * 
	 * @param	data: The data to be uploaded.
	 */
	public function new(?data:Array<UInt>) 
	{
		//** Check if the data is null.
		
		if (data != null)
		{
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
	public function add(value:UInt):Int
	{
		return innerData.push(value);
	}
	
	/**
	 * Dispose of the inner data of the list.
	 */
	public function dispose():Void
	{
		for (index in 0...innerData.length)
		{
			innerData.pop();
		}
	}
	
	/**
	 * Insert an amount of data into the list.
	 * 
	 * @param	count The amount of data to be uploaded.
	 */
	public function insert(count:UInt, ?value:UInt):Void
	{
		for (value in 0...count)
		{
			innerData.push(1);
		}
	}
	
	/**
	 * Remove an amount of data from the list.
	 * 
	 * @param	count
	 */
	public function pop(count:UInt):Void
	{
		for (value in 0...count)
		{
			innerData.pop();
		}
	}
	
	/**
	 * Resolve a copy of a value at the specified index.
	 * 
	 * @param	index The index position of the value.
	 * 
	 * @return	Float
	 */
	public function resolve(index:Int):Float
	{
		return innerData[index];
	}
	
	/**
	 * Upload a vector of indices.
	 * 
	 * @param	data The index data to be uploaded.
	 */
	public function upload(data:Array<UInt>):Void
	{
		innerData = data;
	}
	
	//** Getters and setters.
	
	private function get_count():Int
	{
		return innerData.length;
	}
}