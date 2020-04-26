package stx.fn;

@:using(stx.fn.Block.BlockLift)
@:callable abstract Block(BlockDef) from BlockDef to BlockDef{ 
  static public var ZERO(default,never) : Block = function(){}
  static public var _(default,never) = BlockLift;

  public function new(self:BlockDef) this = self;

  static public function unit():Block{return function(){};}
  static public function pure(fn:Void->Void):Block{return fn;}
  static public function lift(fn:Void->Void):Block{ return new Block(fn); }
  
}
class BlockLift{

  static public function returning<R>(self:Block,r:R):Thunk<R>{
    return () -> { self(); return r; }
  }
  /**
    Compare function identity.
  **/
  static public function equals(self:Block,that:Block){
    return Reflect.compareMethods(self,that);
  }
  /**
    Produces a function that takes a parameter, ignores it, and calls `f`.
  **/
  static public function promote<P>(f: Block): P->Void {
    return function(p: P): Void {
      f();
    }
  }
  /**
    Produces a function that calls `f1` and `f2` in left to right order.*
  * @returns The composite function.
  **/
  static public function then(self:Block, that:Block):Block {
    return function() {
      self();
      that();
    }
  }

  static public function enact(self:Block){
    self();
  }
}
