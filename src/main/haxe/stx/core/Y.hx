package stx.core;

import stx.data.Recursive;
import stx.data.Y in YT;

@:callable @:forward abstract Y<A,B>(YT<A,B>) from YT<A,B> to YT<A,B>{
  public function new(){
    this = function(f:(A->B)->(A->B)):(A->B){
      var r = ((function (w:Recursive<A->B>){
      return f(function(x){ return w(w)(x); }); 
      }):Recursive<A->B>);
      return r(r);
    }
  } 
}