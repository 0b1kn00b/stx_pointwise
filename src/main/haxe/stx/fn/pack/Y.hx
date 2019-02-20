package stx.fn.pack;

import stx.fn.head.data.Recursive;
import stx.fn.head.data.Y in YT;

@:callable abstract Y<A,B>(YT<A,B>) from YT<A,B> to YT<A,B>{
  static public function unit<A,B>():Y<A,B>{
    return function(fn:Recursive<Unary<A,B>>):Unary<A,B> return fn(fn);
  }
  static public function pure<A,B>(f:Unary<A,B>):Y<A,B>{
    return function(fn:Recursive<Unary<A,B>>) return f;
  }
  public function new(self){
    this = self;
  }
  public function reply():Unary<A,B>{
    return this(this);
  }
}