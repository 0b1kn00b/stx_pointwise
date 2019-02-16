package stx.fn.body;

/**
  Functions for working with Thunks
*/
class Thunks {
  @:noUsing static public inline function toThunk<T>(v:T):Void->T{
    return function(){
      return v;
    }
  }
  /**
    Calls a Thunk.
  **/
  static public function reply<A>(a:Thunk<A>):A{
    return a();
  }
  /**
		Applies a `Thunk` and returns an `Outcome`
	**/
  public static function catching<A,B>(c:Thunk<A>):Thunk<Outcome<A,Error>>{
    return function(){
        var o = null;
          try{
            o = Outcome.Success(c());
          }catch(e:Error){
            o = Outcome.Failure(e);
          }catch(e:Dynamic){
            o = Outcome.Failure(new Error(InternalError,e));
          }
        return o;
      }
  }
  /**
		Ignores error in `th` when called, instead returning a `null`
	**/
  public static function suppress<A>(th:Thunk<A>):Thunk<Null<A>>{
    return function(){
      return try{
        th();
      }catch(d:Dynamic){
        null;
      }
    }
  }
  /**
    Returns a Thunk that applies a Thunk one time only and stores the result,
    after which each successive call returns the stored value.
  **/
  @params("The Thunk to call once")
  @returns("A Thunk which will call the input Thunk once.")
  static public function lazy<T>(t: Thunk<T>): Thunk<T> {
    var evaled = false;
    var result = null;

    return function() {
      if (!evaled) { evaled = true; result = t(); }

      return result;
    }
  }
  /**
		Takes a function that returns a result, and produces one that ignores that result.
	**/
  public static function enclose<R>(f:Thunk<R>):Block{
    return function():Void{
        f();
      }
  }
  /**
		Takes a function `f` and produces one that ignores any error the occurs whilst calling `f`.
	**/
  public static function swallow(f: Block): Block {
    return function() {
      try {
        f();
      }
      catch (e: Dynamic) { }
    }
  }
  /**
		Produces a function that calls `f`, ignores its result, and returns the result produced by thunk.
	**/
  public static function returning<R1, R2>(f: Void->R1, thunk: Thunk<R2>): Thunk<R2> {
    return function() {
      f();

      return thunk();
    }
  }
  /**
		Produces a function that takes a parameter. ignores it, and calls `f`, returning it's result.
	**/
  public static function promote<A, Z>(f: Void->Z): A->Z {
    return function(a: A): Z {
      return f();
    }
  }
  /**
    Produces a function that calls and stores the result of 'before', then `f`, then calls `after` with the result of
    `before` and finally returns the result of `f`.
  **/
  public static function stage<Z, T>(f: Thunk<Z>, before: Void->T, after: T->Void): Z {
    var state = before();

    var result = f();

    after(state);

    return result;
  }
  /**
		Compares function identity.
	**/
  public static function equals<  A>(a:Thunk<A>,b:Thunk<A>){
    return Reflect.compareMethods(a,b);
  }
  /**
    Produces a function that calls `f1` and `f2` in left to right order with the same input, and returns no result.
    @returns The composite function.
  **/
  static public function then<A, B>(fn0:Thunk<A>,fn1:A->B):Thunk<B>{
    return function():B{
      return fn1(fn0());
    }
  }
}
