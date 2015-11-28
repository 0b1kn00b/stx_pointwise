package stx.core;

using stx.Pointwise;

/**
  Mixins for working with Sinks;
**/
class Sinks{
  static public function action<T>(fn:Sink<T>):T->T{
    return function(x:T):T{
      fn(x);
      return x;
    }
  }
}
