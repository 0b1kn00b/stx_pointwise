package stx.fn.pack;

import stx.fn.head.data.Block in BlockT;
import stx.fn.body.Blocks;

@:callable abstract Block(BlockT) from BlockT to BlockT{ 
  static public function unit(){return function(){};}
  static public function pure(fn:Void->Void):Block{return fn;}
  static public function lift(fn:Void->Void):Block{ return new Block(fn); }
  public function new(self:BlockT){
    this = self;
  }
  public function equals(that){
    return Blocks.equals(this,that);
  }
  public function upply(){
    Blocks.upply(this);
  }
  public function returning<T>(v:T):Thunk<T>{
    return () -> {
      this();
      return v;
    }
  }
} 