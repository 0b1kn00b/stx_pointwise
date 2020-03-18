package stx.fn;

typedef BlockDef                                = Void->Void;
typedef Block                                   = stx.fn.pack.Block;

/**
* Function that takes one input and produces no result.
**/
typedef SinkDef<R>                              = R -> Void;
typedef Sink<P>                                 = stx.fn.pack.Sink<P>;

typedef ThunkDef<R>                             = Void -> R;
typedef Thunk<R>                                = stx.fn.pack.Thunk<R>;

typedef UnaryDef<Pi,R>                          = Pi -> R;
typedef Unary<Pi,R>                             = stx.fn.pack.Unary<Pi,R>;

typedef BinaryDef<Pi,Pii,R>                     = Pi -> Pii -> R; 
typedef Binary<Pi,Pii,R>                        = stx.fn.pack.Binary<Pi,Pii,R>;

typedef TernaryDef<Pi,Pii,Piii,R>               = Pi -> Pii -> Piii -> R;
typedef Ternary<Pi,Pii,Piii,R>                  = stx.fn.pack.Ternary<Pi,Pii,Piii,R>;


typedef DualDef<Pi,Pii,Ri,Rii>                  = Tuple<Pi,Pii> -> Tuple<Ri,Rii>;
typedef Dual<Pi,Pii,Ri,Rii>                     = stx.fn.pack.Dual<Pi,Pii,Ri,Rii>;

typedef SwitchDef<Pi,Pii,Ri,Rii>                = Either<Pi,Pii> -> Either<Ri,Rii>;
typedef Switch<Pi,Pii,Ri,Rii>                   = stx.fn.pack.Switch<Pi,Pii,Ri,Rii>;

typedef PickDef<Pi,Ri,Rii>                      = Pi -> Either<Ri,Rii>;
typedef Pick<Pi,Ri,Rii>                         = stx.fn.pack.Pick<Pi,Ri,Rii>;


typedef PerhapsDef<P,R>                         = Option<P> -> Option<R>;
typedef Perhaps<P,R>                            = stx.fn.pack.Perhaps<P,R>;


//typedef BatchDef<T>                             = T -> T -> T;
//typedef Batch<T>                                = stx.fn.pack.Batch<T>;

typedef ProductDef<P,R>                         = P -> P -> R;
typedef Product<P,R>                            = stx.fn.pack.Product<P,R>;


typedef OtherDef<P,R>                           = Option<P> -> R;
typedef Other<P,R>                              = stx.fn.pack.Other<P,R>;

typedef CullDef<Pi,Pii,R>                       = Either<Pi,Pii> -> R;

typedef ForkDef<Pi,Ri,Rii>                      = Pi -> Tuple<Ri,Rii>;
typedef Fork<P,Ri,Rii>                          = stx.fn.pack.Fork<P,Ri,Rii>;

typedef JoinDef<Pi,Pii,R>                       = Tuple<Pi,Pii> -> R; 
typedef Join<Pi,Pii,R>                          = stx.fn.pack.Join<Pi,Pii,R>;


typedef FoldDef<P,R>                            = P -> R -> R;

class LiftSomethingNMotSureYet{
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
class LiftUncurryTernary{
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
class LiftSomethingElse{
   /**
   * Binds two functions together to run with bound inputs. 
   * @param fn1 
   * @param fn2 
   * @return Tuple<A,B>->Tuple<C,D>
   */
   static public inline function pair<Pi,Pii,Ri,Rii>(fn1:Unary<Pi,Ri>,fn2:Unary<Pii,Rii>):Dual<Pi,Pii,Ri,Rii>{
    return
      function(t){
        return __.tuple(fn1(t.fst()),fn2(t.snd()));
      }
  }
}

class LiftFn{
  // static public function fn(stx:Wildcard):Api{
  //   return new Api();
  // }
  /**
    Creates a function that splits an input to it's inputs.
  **/
  static public function pinch<A,B,C>(fn0:Dual<A,A,B,C>):Fork<A,B,C>{
    return function(x:A){
        return fn0(__.tuple(x,x));
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
class LiftSink{
  // static public inline function fn<T>(f:T->Void):Sink<T>{
  //    return f;
  // }
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
typedef LiftDual    = stx.fn.lift.LiftDual;

typedef LiftUnaryImplementation = stx.fn.pack.unary.Implementation;


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
// class LiftAppliableToUnary{
//   static public function fn<P,R>(apply:AppliableApi<P,R>):Unary<P,R>{
//     return apply.apply;
//   }
// }
class LiftIf{
  static public function if_else<T>(b:Bool,yes:Thunk<T>,no:Thunk<T>){
    return switch(b){
      case true   : yes();
      case false  : no();
    }
  }
}