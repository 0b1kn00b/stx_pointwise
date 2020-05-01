package stx;

class Fn{

}
typedef BlockDef                                = Void->Void;
typedef Block                                   = stx.fn.Block;

typedef FunXXDef                                = BlockDef;
typedef FunXX                                   = Block;

/**
* Function that takes one input and produces no result.
**/
typedef SinkDef<P>                              = P -> Void;
typedef Sink<P>                                 = stx.fn.Sink<P>;
typedef FunXRDef<P>                             = SinkDef<P>;
typedef Fun1X<P>                                = Sink<P>;


typedef ThunkDef<R>                             = Void -> R;
typedef Thunk<R>                                = stx.fn.Thunk<R>;
typedef Fun1XDef<R>                             = ThunkDef<R>;
typedef FunXR<R>                                = Thunk<R>;

typedef UnaryDef<P,R>                           = P -> R;
typedef Unary<P,R>                              = stx.fn.Unary<P,R>;
typedef Fun1RDef<P,R>                           = UnaryDef<P,R>;
typedef Fun1R<P,R>                              = Unary<P,R>;

typedef BinaryDef<Pi,Pii,R>                     = Pi -> Pii -> R; 
typedef Binary<Pi,Pii,R>                        = stx.fn.Binary<Pi,Pii,R>;
typedef Fun2RDef<Pi,Pii,R>                      = BinaryDef<Pi,Pii,R>;
typedef Fun2R<Pi,Pii,R>                         = Binary<Pi,Pii,R>;


typedef TernaryDef<Pi,Pii,Piii,R>               = Pi -> Pii -> Piii -> R;
typedef Ternary<Pi,Pii,Piii,R>                  = stx.fn.Ternary<Pi,Pii,Piii,R>;


typedef DualDef<Pi,Pii,Ri,Rii>                  = Couple<Pi,Pii> -> Couple<Ri,Rii>;
typedef Dual<Pi,Pii,Ri,Rii>                     = stx.fn.Dual<Pi,Pii,Ri,Rii>;

typedef SwitchDef<Pi,Pii,Ri,Rii>                = Either<Pi,Pii> -> Either<Ri,Rii>;
typedef Switch<Pi,Pii,Ri,Rii>                   = stx.fn.Switch<Pi,Pii,Ri,Rii>;

typedef PickDef<Pi,Ri,Rii>                      = Pi -> Either<Ri,Rii>;
typedef Pick<Pi,Ri,Rii>                         = stx.fn.Pick<Pi,Ri,Rii>;

typedef PerhapsDef<P,R>                         = Option<P> -> Option<R>;
typedef Perhaps<P,R>                            = stx.fn.Perhaps<P,R>;

class LiftCurriedBinary{
  /**
    Takes a function with one parameter that returns a function of one parameter, and produces
    a function that takes two parameters that calls the two functions sequentially,
  **/
  public static function uncurry<P1, P2, R>(f: (P1->(P2->R))): P1->P2->R {
    return function(p1: P1, p2: P2) {
      return f(p1)(p2);
    }
  }
}
class LiftCurriedTernary{
    /**
    Takes a function with one parameter that returns a function of one parameter, and produces
    a function that takes two parameters that calls the two functions sequentially,
  **/
    public static function uncurry<P1, P2, P3, R>(f: (P1->(P2->(P3->R)))): P1->P2->P3->R {
      return function(p1: P1, p2: P2, p3: P3) {
        return f(p1)(p2)(p3);
      }
    }
}
class LiftFn{
  /**
    Creates a function that splits an input to it's inputs.
  **/
  static public function pinch<A,B,C>(fn0:Dual<A,A,B,C>):Unary<A,Couple<B,C>>{
    return function(x:A){
      return fn0(__.couple(x,x));
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

typedef LiftBroker = stx.fn.lift.LiftBroker;

class LiftUnary{
  static public inline function fn<P,R>(f:P->R):Unary<P,R>{
    return f;
  }
}
class LiftBlock{
  static public inline function fn(f:Void->Void):Block{
    return f;
  }
}
class LiftThunk{
  static public inline function fn<R>(fn:Void->R):Thunk<R>{
    return fn;
  }
}


class LiftBinary{
  static public inline function fn<PI,PII,R>(fn:PI->PII->R):Binary<PI,PII,R>{
    return new Binary(fn);
  }
  static inline public function bind1<PI,PII,R>(fn:PI->PII->R,p:PI):Unary<PII,R>{
    return fn.bind(p);
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
class LiftTernary{
  static public inline function fn<PI,PII,PIII,R>(fn:PI->PII->PIII->R):Ternary<PI,PII,PIII,R>{
    return fn;
  }
}
class LiftIf{
  static public function if_else<T>(b:Bool,yes:Thunk<T>,no:Thunk<T>){
    return switch(b){
      case true   : yes();
      case false  : no();
    }
  }
}