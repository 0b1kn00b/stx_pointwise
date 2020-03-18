package stx.fn.pack;

import stx.fn.head.data.Y2 as Y2T;

@:callable abstract Y2<S,A,B>(Y2T<S,A,B>) from Y2T<S,A,B> to Y2T<S,A,B>{
  public function new(self){
    this = self;
  }
  static public function y<S,A,B>(s:S,a:A):Y2<S,A,B>->(Y2<S,A,B>->B){
    return function(fn:Y2<S,A,B>):Y2<S,A,B> -> B{
      return function(mutual:Y2<S,A,B>):B{
        return fn(mutual)(s,a);
      }
    }
  }
} 