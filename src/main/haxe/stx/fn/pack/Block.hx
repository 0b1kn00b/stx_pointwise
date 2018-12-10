package stx.fn.pack;

import stx.fn.head.data.Block in BlockT;

@:callable abstract Block(BlockT) from BlockT{
  public function new(self:BlockT){
    this = self;
  }
}