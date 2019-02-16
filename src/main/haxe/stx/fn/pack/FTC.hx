package stx.fn.pack;

import stx.fn.head.data.FTC as FTCT;

@:callable abstract FTC<S,A,B>(FTCT<S,A,B>) from FTCT<S,A,B> to FTCT<S,A,B>{
  public function new(self){
    this = self;
  }
  static public function y<S,A,B>(s:S,a:A):FTC<S,A,B>->(FTC<S,A,B>->B){
    return function(fn:FTC<S,A,B>):FTC<S,A,B> -> B{
      return function(mutual:FTC<S,A,B>):B{
        return fn(mutual)(s,a);
      }
    }
  }
} 