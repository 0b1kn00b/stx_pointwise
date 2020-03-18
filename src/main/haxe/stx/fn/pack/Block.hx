package stx.fn.pack;

//@:using(stx.fn.pack.Block.pack.Implementation)
@:callable abstract Block(BlockDef) from BlockDef to BlockDef{ 
  static public var ZERO(default,never) : Block = function(){}
  static public inline function _() return Constructor.ZERO;

  public function new(self:BlockDef) this = self;

  static public function unit():Block{return function(){};}
  static public function pure(fn:Void->Void):Block{return fn;}
  static public function lift(fn:Void->Void):Block{ return new Block(fn); }

  public function equals(that)                    return _()._.equals(that,this);
  public function enact()                                _()._.enact(this);
  
  public function returning<R>(r:R):Thunk<R>      return _()._.returning(r,this);
  public function promote<P>():Sink<P>            return _()._.promote(this);
  public function then(that:Block)                return _()._.then(that,this);
  
}
private class Constructor{
  public function new(){}
  public var _(default,never) = new Destructure();
  static public var ZERO(default,never) = new Constructor();
}
private class Destructure{
  public function new(){}

  public function returning<R>(r:R,self:Block):Thunk<R>{
    return () -> { self(); return r; }
  }
  /**
    Compare function identity.
  **/
  public function equals(that:Block,self:Block){
    return Reflect.compareMethods(self,that);
  }
  /**
    Produces a function that takes a parameter, ignores it, and calls `f`.
  **/
  public function promote<P>(f: Block): P->Void {
    return function(p: P): Void {
      f();
    }
  }
  /**
    Produces a function that calls `f1` and `f2` in left to right order.*
  * @returns The composite function.
  **/
  public function then(that:Block, self:Block):Block {
    return function() {
      self();
      that();
    }
  }

  public function enact(self:Block){
    self();
  }
}
