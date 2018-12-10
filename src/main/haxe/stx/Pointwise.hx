package stx;

import haxe.ds.Option;
using stx.fn.Package;

//typedef State<R,A>    = stx.core.State<R,A>;
/**
  Mixins to Compose Unary Functions.
**/
typedef Compose       = stx.core.Compose;



typedef Cell<T>       = stx.pack.Cell<T>;

typedef Trivalent     = stx.data.Trivalent;

class Pointwise{
  /**
    Takes a value and wraps it in a function.
  **/
  static inline public function toThunk<T>(v:T):Thunk<T>{
    return Thunks.toThunk(v);
  }
  /**
    Produces an option of `v`, None if `v` is `null`.
  **/
  static inline public function toOption<V>(v:Null<V>):Option<V>{
    return if(v == null){
      None;
    }else{
      Some(v);
    }
  }
  /**
  Takes a value and wraps it in a function.
  **/
  @:noUsing static inline public function thunk<T>(v:T):Thunk<T>{
    return Thunks.toThunk(v);
  }
  /**
    Produces a function that is only called in the event of Some(v) being passed
    to it.
  **/
  static inline public function maybe<A,B>(fn:A->B):Option<A>->Option<B>{
    return Compose.maybe(fn);
  }
  /**
    An operation that soley passes it's input.
  **/
  static inline public function noop<A>():A->A{
    return function (a:A){ return a; }
  }
}

