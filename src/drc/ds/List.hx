package drc.ds;

class List<T> {

    // ** Publics.

    public var length:Int = 0;

    // ** Privates.

    private var __first:IListObject<T>;

	private var __last:IListObject<T>;

    public function new() {
        
    }

    public function add(item:T) {

        var x = ListObject.create(item, null);

        if (__first == null) {
            
            __first = x;
        }
        else {
            
            __last.next = x;
        }

        __last = x;
        
		length ++;
    }

    public function remove(item:T) {

    }

    public inline function iterator():ListIterator<T> {

		return new ListIterator<T>(__first);
	}
}

private class ListIterator<T> {

	var head:IListObject<T>;

	public inline function new(head:IListObject<T>) {

		this.head = head;
	}

	public inline function hasNext():Bool {

		return head != null;
	}

	public inline function next():T {

        var val = head.item;
        
        head = head.next;
        
		return val;
	}
}

private class ListObject<T> implements IListObject<T> {

    public var next:IListObject<T>;

    public var item:T;

    public function new(item:T, next:IListObject<T>) {

        this.item = item;
        
		this.next = next;
    }
    
    extern public inline static function create<T>(item:T, next:IListObject<T>):ListObject<T> {

		return new ListObject(item, next);
	}
}