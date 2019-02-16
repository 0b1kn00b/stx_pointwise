package stx.fn.pack;

import stx.fn.head.data.Block in BlockT;
import stx.fn.body.Blocks;

@:callable abstract Block(BlockT) from BlockT to BlockT{ 
  static public function unit(){
    return function(){};
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
  public function catching():Thunk<stx.core.pack.Option<stx.Error>>{
    return Blocks.catching(this);
  }
} 