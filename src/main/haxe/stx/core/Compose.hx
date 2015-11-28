package stx.core;

using stx.Pointwise;

import haxe.ds.Option;

using tink.CoreApi;
using stx.Tuple;

class Compose{
  @:noUsing static public function apply<I,O>(fn:I->O,v:I):O{
    return fn(v);
  }
  /**
    Returns a function that applies `fn1` then `fn2` on the input
  **/
  static public function then<A,B,C>(fn1:A->B,fn2:B->C):A->C{
    return
      function(a:A):C{
        return fn2(fn1(a));
      }
  }
  /**
    Returns a function that applies `fn1` to the left hand side of a Tuple
  **/
  static public function first<A,B,C,D>(fn1:A->C):Tuple2<A,B>->Tuple2<C,B>{
    return
      function(t:Tuple2<A,B>){
        return new Tup2(fn1(t.fst()),t.snd());
      }
  }
  /**
    Returns a function that applies `fn1` to the right hand side of a Tuple
  **/
  static public function second<A,B,C,D>(fn1:B->D):Tuple2<A,B>->Tuple2<A,D>{
    return
      function(t:Tuple2<A,B>){
        return new Tup2(t.fst(),fn1(t.snd()));
      }
  }
  static public function pair<A,B,C,D>(fn1:A->C,fn2:B->D):Tuple2<A,B>->Tuple2<C,D>{
    return
      function(t){
        return new Tup2(fn1(t.fst()),fn2(t.snd()));
      }
  }
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
    Returns a function that applies a function to the Left value of an Either.
  **/
  static public function left<A,B,C>(fn:A->C):Either<A,B>->Either<C,B>{
    return
      function(e:Either<A,B>):Either<C,B>{
        return
          switch (e) {
            case Left(v)  : Left(fn(v));
            case Right(v) : Right(v);
          }
      }
  }
  /**
    Returns a function that applies a function to the Right value of an Either.
  **/
  static public function right<A,B,D>(fn:B->D):Either<A,B>->Either<A,D>{
    return
      function(e:Either<A,B>):Either<A,D>{
        return
          switch (e) {
            case Left(v)  : Left(v);
            case Right(v) : Right(fn(v));
          }
      }
  }
  static public function fromR<A,B,C>(fn:B->Either<A,C>):Either<A,B>->Either<A,C>{
    return function(e:Either<A,B>){
      return switch (e){
        case    Left(l)      : Left(l);
        case    Right(r)     : fn(r);
      }
    }
  }
  /**
    Unit function.
        [[1,2],[3,4]].flatMap( Compose.unit() );//[1,2,3,4]
  **/
  @:noUsing static public function unit<A,B>():A->A{
    return cast function(x) return x;
  }
  /**
    Returns a function that produces a `Tuple2` from a value.
  **/
  static public function fan<I,O>(a:I->O):I->Tuple2<O,O>{
    return a.then(
        function(x){
          return new Tup2(x,x);
        }
      );
  }
  /**
    Returns a function that produces `v`.
  **/
  @:noUsing static public function pure<A,B>(v:B):A->B{
    return function(x:A){ return v; }
  }

  /**
    Combines functions such that a single input is passed to both.
  **/
  static public function split<A,B,C>(split_:A->B,_split:A->C):A->Tuple2<B,C>{
    return function(x){
        return new Tup2( split_(x), _split(x) );
      }
  }
  /**
    Applies a function to the input, passing it's original input plus output forward to `bindr`.
  **/
  static public function tie<A,B,C>(bindl:A->C,bindr:Tuple2<A,C>->B):A->B{
    return unit().split(bindl).then( bindr );
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
    Creates a function applying the same function to both the left and right portions of
    a Tuple2;
  **/
  static public function both<A,B>(fn:A->B):Tuple2<A,A>->Tuple2<B,B>{
    return function(t){
        return new Tup2(fn(t.fst()),fn(t.snd()));
      }
  }
  /**
    Returns a function that calls `f1` with the output of `f2`.
  **/
  public static function compose<U, V, W>(f1: V->W, f2: U->V): U->W {
    return function(u: U): W {
      return f1(f2(u));
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
