package drc.ds;

import drc.ds.Object;

interface IListObject<T> {

    public var item:T;

    public var next:IListObject<T>;
}