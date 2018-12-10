package stx.core;


using stx.Pointwise;

import haxe.ds.Option;

using tink.CoreApi;
using stx.Tuple;

class Compose{
 
  /**
    Returns a function that applies a function on the lhs of a tuple to the value on the rhs.
  **/
  static public function application<A,I,O>(fn:A->Tuple2<I->O,I>):A->O{
    return
      function(v:A):O{
        var t = fn(v);
        return t.fst()(t.snd());
      }
  }


  /**
    Creates a function that splits an input to it's inputs.
  **/
  static public function pinch<A,B,C>(fn0:Tuple2<A,A>->Tuple2<B,C>):A->Tuple2<B,C>{
    return function(x:A){
        return fn0(new Tup2(x,x));
      }
  }
  /**
    Produces a function that is only called in the event of Some(v) being passed
    to it.
  **/
  static public function maybe<A,B>(fn:A->B):Option<A>->Option<B>{
    return function(opt:Option<A>){
      return switch (opt) {
        case Some(v) : Some(fn(v));
        case None    : None;
      }
    }
  }
  static public function fromOption<A,B>(fn:A->Option<B>):Option<A>->Option<B>{
    return function(opt:Option<A>):Option<B>{
      return switch (opt) {
        case Some(v) :
          var o = fn(v);
          if(o == null){
            None;
          }else{
            o;
          }
        case None   : None;
      }
    }
  }
  static public function repeat<I,O>(fn:I->Either<I,O>):I->O{
    return function(v:I){
      var i : I = null;
      var o : O = null;
      while(true){
        switch (fn(i)) {
          case Left(v) : i = v;
          case Right(v) : o = v; break;
        }
      }
      return o;
    }
  }
}