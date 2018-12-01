package stx.pack;

import stx.data.*;
import tink.core.Ref;

@:access(tink.core.Ref) abstract Cell<T>(Ref<T>) from Ref<T> to Ref<T>{
    public function new(self){
        this = self;
    }
    @:from static public function fromT<T>(v:T):Cell<T>{
        return new Cell(v);
    }
    public var value(get,never) : T;

    public function get_value(){
        return this.value;
    }
    public function unbox():Ref<T>{
        return this;
    }
}