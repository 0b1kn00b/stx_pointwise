package stx.fn.body;


/**
  Class for working with Unary Functions.
**/
class Unaries {
  /**
   * Applies the function.
   * @param fn The function  
   * @param p1 The parameter
   * @return Thunk<R>
   */
  static public inline function apply<PI,R>(fn:Unary<PI,R>,v:PI):R{
    return fn(v);
  }
  /**
   * Produces a function that calls `f` with the given parameters `p1....pn`, calls this function only once and memoizes the result.
   * @param fn 
   * @return }
   */
  @:note("those brackets are there to fox the Java compiler")
  static public inline function lazy<PI, R>(f: Unary<PI,R>, p1: PI): Thunk<R> {
    var r : R   = null;

    return function() {
      return if (r == null) {
        r = untyped (false);//<---
        r = f(p1); r;
      }else{
        r;
      }
    }
  }
  /**
		As with lazy, but calls the wrapped function every time it is called.
	**/
  static public inline function pipe<PI, R>(f: Unary<PI,R>, p1: Thunk<PI>): Thunk<R> {
    return function(){
      return f(p1());
    }
  }
  /**
		Compares function identity.
	**/
  static public function eq<PI,R>(a:Unary<PI,R>,b:Unary<PI,R>){
    return Reflect.compareMethods(a,b);
  }
  
  /**
   * Returns a function that applies `fn1` then `fn2` on the input
   * @param fn1 
   * @param fn2 
   * @return PI->R
   */
  static public inline function then<PI,PII,R>(fn1:Unary<PI,PII>,fn2:Unary<PII,R>):Unary<PI,R>{
    return
      function(a:PI):R{
        return fn2(fn1(a));
      }
  }
   /**
    Returns a function that applies `fn1` to the left hand side of a Tuple
  **/
  static public function first<A,B,C,D>(fn1:Unary<A,C>):Dual<A,B,C,B>{
    return
      function(t:Tuple2<A,B>){
        return tuple2(fn1(t.fst()),t.snd());
      }
  }
  /**
    Returns a function that applies `fn1` to the right hand side of a Tuple
  **/
  static public function second<A,B,C,D>(fn1:B->D):Dual<A,B,A,D>{
    return
      function(t:Tuple2<A,B>){
        return tuple2(t.fst(),fn1(t.snd()));
      }
  }
  /**
   * Binds two functions together to run with bound inputs. 
   * @param fn1 
   * @param fn2 
   * @return Tuple2<A,B>->Tuple2<C,D>
   */
  static public inline function pair<PI,PII,RI,RII>(fn1:Unary<PI,RI>,fn2:Unary<PII,RII>):Dual<PI,PII,RI,RII>{
    return
      function(t){
        return tuple2(fn1(t.fst()),fn2(t.snd()));
      }
  }
  /**
   * Returns a function that applies a function to the Left value of an Either.
   * @param fn 
   * @return Either<PI,RI>->Either<RII,RI>
   */
  static public inline function left<PI,RI,RII>(fn:Unary<PI,RII>):Switch<PI,RI,RII,RI>{
    return (e) -> switch e {
      case Left(v)  : Left(fn(v));
      case Right(v) : Right(v);
    };
  }
  /**
    Returns a function that applies a function to the Right value of an Either.
  **/
  static public inline function right<RI,PI,RII>(fn:Unary<PI,RII>):Switch<RI,PI,RI,RII>{
    return (e) -> switch e {
      case Left(v)  : Left(v);
      case Right(v) : Right(fn(v));
    }
  }
  /**
   * unit function
   * @return Unary<A,A>
   */
  @:noUsing static public function unit<A>():Unary<A,A>{
    return (x:A) -> x;
  }
  /**
    Returns a function that produces a `Tuple2` from a value.
  **/
  static public function fan<I,O>(a:Unary<I,O>):Fork<I,O,O>{
    return a.then(
        function(x){
          return tuple2(x,x);
        }
      );
  }
    /**
    Combines functions such that a single input is passed to both.
  **/
  static public function fork<A,B,C>(split_:Unary<A,B>,_split:Unary<A,C>):Fork<A,B,C>{
    return function(x:A){
        return tuple2( split_(x), _split(x) );
      }
  } 
  /**
    Applies a function to the input, passing it's original input plus output forward to `bindr`.
  **/
  static public function bound<A,B,C>(bindl:Unary<A,C>,bindr:Join<A,C,B>):Unary<A,B>{
    var out = unit().fork(bindl).then(bindr);
    return out;
  }
  /**
    Applies a function to the input, and produces the original input plus the calculated value.
  **/
  static public function span<A,B,C>(bindl:Unary<A,C>):Fork<A,A,C>{
    return bound(bindl,(x) -> x);
  }

  static public function enclose<A,B>(self:Unary<A,B>):Sink<A>{
    return (a:A) -> {
      self(a);
    }
  }
}
