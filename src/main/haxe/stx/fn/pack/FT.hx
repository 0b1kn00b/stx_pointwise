package stx.fn.pack;

import stx.fn.head.data.Recursive;
import stx.fn.head.data.FT in FTT;

@:callable abstract FT<A,B>(FTT<A,B>) from FTT<A,B> to FTT<A,B>{
  static public function unit<A,B>():FT<A,B>{
    return function(fn:Recursive<Unary<A,B>>):Unary<A,B> return fn(fn);
  }
  static public function pure<A,B>(f:Unary<A,B>):FT<A,B>{
    return function(fn:Recursive<Unary<A,B>>) return f;
  }
  public function new(self){
    this = self;
  }
  public function reply():Unary<A,B>{
    return this(this);
  }
}