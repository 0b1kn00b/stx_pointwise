package stx.fn.pack;

import stx.fn.head.data.VBlock in VBlockT;

@:callable abstract VBlock<T>(VBlockT<T>) from VBlockT<T>{
  static public function unit<T>():VBlock<T>{
    return () -> {}
  }
  public function new(self:VBlockT<T>){
    this = self;
  }
  @:from static public function fromBlock<T>(b:Block):VBlock<T>{
    return b;
  }
  @:to public function toBlock():Block{
    return this;
  }
  @:to public function toBlockT():Void->Void{
    return this;
  }
}