package stx.fn.body;


/**
  Mixins for working with Sinks;
**/
class Sinks{
  static public inline function action<T>(fn:Sink<T>):T->T{
    return function(x:T):T{
      fn(x);
      return x;
    }
  }
}
