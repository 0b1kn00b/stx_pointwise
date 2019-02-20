package stx.core;

class Binaries {
  public static inline function apply<A,B,C>(fn:A->B->C,v0:A,v1:B):C{
    return fn(v0,v1);
  }
  /**
		Places parameter 1 at the back.
	**/
  static public function rotate<P1, P2, R>(f:P1->P2->R): P2->P1->R {
    return function(p2:P2, p1:P1){
        return f(p1,p2);
      }
  }
  /**
		Produces a function that ignores any error the occurs whilst calling the input function.
	**/
  public static function swallow<P1, P2, R>(f: P1->P2->R): P1->P2->R {
    return swallowWith(f, null);
  }
  /**
		Produces a function that ignores any error the occurs whilst calling the input function, and produces `d` if error occurs.
	**/
  public static function swallowWith<P1, P2, R>(f: P1->P2->R, d: R): P1->P2->R {
    return function(p1:P1, p2:P2):R {
      try {
        return f(p1, p2);
      }
      catch (e: Dynamic) { }
      return d;
    }
  }
  /**
		Produces a function that calls `f`, ignores its result, and returns the result produced by thunk.
	**/
  public static function returning<P1, P2, R1, R2>(f: P1->P2->R1, thunk: Thunk<R2>): P1->P2->R2 {
    return function(p1, p2) {
      f(p1, p2);

      return thunk();
    }
  }
  /**
		Produces a function which takes the parameters of `f` in a flipped order.
	**/
  public static function flip<P1, P2, R>(f: P1->P2->R): P2->P1->R{
    return function(p2, p1) {
      return f(p1, p2);
    }
  }
  /**
    Produces a function that produces a function for each parameter in the originating function. When these
    functions have been called, the result of the original function is returned.
  **/
  public static function curry<P1, P2, R>(f: P1->P2->R): (P1->(P2->R)) {
    return function(p1: P1) {
      return function(p2: P2) {
        return f(p1, p2);
      }
    }
  }
  /**
    Takes a function with one parameter that returns a function of one parameter, and produces
    a function that takes two parameters that calls the two functions sequentially,
  **/
  public static function uncurry<P1, P2, R>(f: (P1->(P2->R))): P1->P2->R {
    return function(p1: P1, p2: P2) {
      return f(p1)(p2);
    }
  }
  /**
		Procudes a function that calls `f` with the given parameters `p1....pn`, and caches the result
	**/
  public static function lazy<P1, P2, R>(f: P1->P2->R, p1: P1, p2: P2): Thunk<R> {
    var r : R = null;

    return function() {
      return r == null ? r = f(p1, p2) : r;
    }
  }
  /**
		As with lazy, but calls the wrapped function every time it is called.
	**/
  static public function defer<P1, P2, R>(f: P1->P2->R, p1 : P1, p2 : P2): Thunk<R> {
    return function(){
      return f(p1,p2);
    }
  }
  /**
		Produces a function that calls `f`, ignoring the result.
	**/
  public static function enclose<P1, P2, R>(f: P1->P2->R): P1->P2->Void {
    return function(p1, p2):Void{
      f(p1, p2);
    }
  }
  /**
		Compares function identity.
	**/
  public static function equals<P1,P2,R>(a:P1->P2->R,b:P1->P2->R) {
    return Reflect.compareMethods(a,b);
  }

  /**
    Calls only first parameter, returning Unary function
  **/
  static public function c0<P0,P1,R>(m:P0->P1->R,p0:P0):P1->R{
    var fn : P0 -> P1 -> R = m;
    return fn.bind(p0);
  }
  /**
    Calls only second parameter, returning Unary function
  **/
  static public function c1<P0,P1,R>(m:P0->P1->R,p1:P1):P0->R{
    var fn : P0 -> P1 -> R = m;
    return fn.bind(_,p1);
  }
}
