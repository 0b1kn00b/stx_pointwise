package stx.fn.body;

/**
  Helpers for working with Blocks.
**/
class Blocks{
  static public var NIL(default,never) : Block = function(){}
  /**
    Compare function identity.
  **/
  static public function eq(a:Block,b:Block){
    return Reflect.compareMethods(a,b);
  }
  /**
    Produces a function that takes a parameter, ignores it, and calls `f`.
  **/
  static public function promote<A>(f: Block): A->Void {
    return function(a: A): Void {
      f();
    }
  }
  /**
    Produces a function that calls `f1` and `f2` in left to right order.*
  * @returns The composite function.
  **/
  static public function then(f1:Void->Void, f2:Void->Void):Void->Void {
    return function() {
      f1();
      f2();
    }
  }

  static public function upply(fn:Block){
    fn();
  }
  static public inline function and(fn0:Block,fn1:Block):Block{
    return function(){
      fn0();
      fn1();
    }
  }

  static public function catching(fn:Block):Thunk<Option<Error>>{
    return function(){
        var o = None;
          try{
            fn();
          }catch(e:Error){
            o = Some(e);
          }catch(e:Dynamic){
            o = Some(new Error(InternalError,e));
          }
        return o;
      }
  }
}
