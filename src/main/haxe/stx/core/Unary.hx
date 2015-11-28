package stx.core;

import tink.CoreApi;

using stx.Pointwise;

/**
  Class for working with Unary Functions.
**/
class Unary {
  /**
	* Applies a Thunk and returns Either an error or it's result
	**/
  public static function catching<A,B>(fn:A->B):A->Outcome<B,Error>{
    return function(a){
        var o = null;
          try{
            o = Outcome.Success(fn(a));
          }catch(e:Error){
            o = Outcome.Failure(e);
          }catch(e:Dynamic){
            o = Outcome.Failure(new Error(InternalError,e));
          }
        return o;
      }
  }
  /**
    Produces a function that produces a function for each parameter in the originating function. When these
    functions have been called, the result of the original function is produced.
  **/
  public static function curry<P1, R>(f: P1->R) {
    return function() {
      return function(p1: P1) {
        return f(p1);
      }
    }
  }
  /**
    Produces a function that ignores any error the occurs whilst
    calling the input function.
  **/
  public static function swallow<A>(f: A->Void): A->Void {
    return enclose(swallowWith(f, null));
  }
  /**
    Produces a function that ignores
    any error the occurs whilst calling the input function, and produces `d` if
    error occurs.
  **/
  public static function swallowWith<P1, R>(f: P1->R, d: R): P1->R {
    return
      function(a) {
        try {
          return f(a);
        }catch (e:Dynamic) {
        }return d;
      }
  }
  /**
    Produces a function that calls `f`, ignores its result, and returns the result
    produced by thunk.
  **/
  public static function returning<P1, R1, R2>(f: P1->R1, thunk: Thunk<R2>) : P1->R2 {
    return function(p1) {
      f(p1);
      return thunk();
    }
  }

  /**
		Produces a function that calls `f` with the given parameters `p1....pn`,
    calls this function only once and memoizes the result.
	**/
  @:note("those brackets are there to fox the Java compiler")
  static public inline function lazy<P1, R>(f: P1->R, p1: P1): Thunk<R> {
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
  static public inline function defer<P1, R>(f: P1->R, p1: P1): Thunk<R> {
    return function(){
      return f(p1);
    }
  }
  /**
		Produces a function that calls `f`, ignoring the result.
	**/
  public static function enclose<P1, R>(f: P1->R): P1->Void {
    return function(p1) {
      f(p1);
    }
  }
  /**
		Compares function identity.
	**/
  public static function equals<P1,R>(a:P1->R,b:P1->R){
    return Reflect.compareMethods(a,b);
  }
}
