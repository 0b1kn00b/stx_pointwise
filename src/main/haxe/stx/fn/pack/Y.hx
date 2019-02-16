package stx.fn.pack;

import stx.fn.head.data.Recursive;
import stx.fn.head.data.Y in YT;

@:callable @:forward abstract Y<A,B>(YT<A,B>) from YT<A,B> to YT<A,B>{
  public function new(){
    this = function(f:FT<A,B>):Unary<A,B>{
      var r = ((function (w:Recursive<A->B>){
      return f(FT.unit()); 
      }):Recursive<A->B>);
      return r(r);
    }
  }
}