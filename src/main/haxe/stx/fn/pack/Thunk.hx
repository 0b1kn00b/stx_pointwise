package stx.fn.pack;

import stx.fn.body.Thunks;

@:callable abstract Thunk<R>(ThunkDef<R>) from ThunkDef<R>{
  static public inline function _() return Constructor.ZERO;

  static public function lift<R>(thk:ThunkDef<R>):Thunk<R>{
    return new Thunk(thk);
  }
  public function new(self:ThunkDef<R>){
    this = self;
  }
  public function then<Ri>(that:R->Ri):Thunk<Ri>        return _()._.then(that,this);
  public function cache():Thunk<R>                      return _()._.cache(this);

  public function prj():ThunkDef<R>{
    return this;
  }
}
private class Constructor extends Clazz{
  static public var ZERO(default,never) = new Constructor();
  public var _(default,never) = new Destructure();
}

class Destructure extends Clazz{
  /**
    Calls a Thunk.
  **/
  public function reply<R>(self:Thunk<R>):R{
    return self();
  }
  /**
    Returns a Thunk that applies a Thunk one time only and stores the result,
    after which each successive call returns the stored value.
  **/
  @params("The Thunk to call once")
  @returns("A Thunk which will call the input Thunk once.")
  public function cache<R>(self: Thunk<R>): Thunk<R> {
    var r : R   = null;
    return function() {
      return if (r == null) {
        r = untyped (false);//<--- breaks live lock
        r = self(); r;
      }else{
        r;
      }
    }
  }
  public static function promote<P, R>(self: Void->R): P->R {
    return function(p: P): R {
      return self();
    }
  }
  /**
    Produces a function that calls and stores the result of 'before', then `f`, then calls `after` with the result of
    `before` and finally returns the result of `f`.
  **/
  public static function stage<R, T>(f: Thunk<R>, before: Void->T, after: T->Void): R {
    var state = before();

    var result = f();

    after(state);

    return result;
  }
  /**
		Compares function identity.
	**/
  public static function equals<R>(that:Thunk<R>,self:Thunk<R>){
    return Reflect.compareMethods(self,that);
  }
  /**
    Produces a function that calls `f1` and `f2` in left to right order with the same input, and returns no result.
    @returns The composite function.
  **/
  public function then<Ri,Rii>(that:Ri->Rii,self:Void -> Ri):Thunk<Rii>{
    return function():Rii{
      return that(self());
    }
  }
}