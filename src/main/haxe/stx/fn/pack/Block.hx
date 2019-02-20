package stx.fn.pack;

import stx.fn.head.data.Block in BlockT;
import stx.fn.body.Blocks;

@:callable abstract Block(BlockT) from BlockT to BlockT{ 
  static public function unit(){
    return function(){};
  }
  static public function pure(fn:Void->Void):Block{
    return fn;
  }
  public function new(self:BlockT){
    this = self;
  }
  public function eq(that){
    return Blocks.eq(this,that);
  }
  public function upply(){
    Blocks.upply(this);
  }
  public function catching():Thunk<Option<Error>>{
    return Blocks.catching(this);
  }
} 