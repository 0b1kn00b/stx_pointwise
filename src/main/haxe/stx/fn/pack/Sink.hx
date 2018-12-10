package stx.fn.pack;

import stx.fn.head.data.Sink in SinkT;

@:callable abstract Sink<I>(SinkT<I>) from SinkT<I>{
  public function new(self:SinkT<I>){
    this = self;
  }
}