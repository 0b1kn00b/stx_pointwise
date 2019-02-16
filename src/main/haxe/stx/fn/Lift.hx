package stx.fn;

class Lift{
  static public function fn(stx:Stx<Wildcard>):Api{
    return new Api();
  }
  /**
    Creates a function that splits an input to it's inputs.
  **/
  static public function pinch<A,B,C>(fn0:Dual<A,A,B,C>):Fork<A,B,C>{
    return function(x:A){
        return fn0(new Tup2(x,x));
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
  /**
  *  An operation that soley passes it's input.
  **/
  static inline public function noop<A>():Unary<A,A>{
    return function (a:A){ return a; }
  }
}
class LiftThunk{
  static public inline function fn<R>(fn:Void->R):Thunk<R>{
    return fn;
  }
}
class LiftUnary{
  static public inline function fn<PI,R>(fn:PI->R):Unary<PI,R>{
    return fn;
  }
}
class LiftBinary{
  static public inline function fn<PI,PII,R>(fn:PI->PII->R):Join<PI,PII,R>{
    return (tp) -> fn(tp.fst(),tp.snd());
  }
}
class LiftPerhapsConstructor{
  static public inline function perhaps<P,R>(fn:P->Option<R>):Perhaps<P,R>{
    return (x) -> switch(x){
      case Some(v)  : fn(v);
      case None     : None;
    }
  }
}
class LiftPerhaps{
  static public inline function perhaps<P,R>(fn:P->R):Perhaps<P,R>{
    return (x) -> switch(x){
      case Some(v)  : Some(fn(v));
      case None     : None;
    }
  } 
}