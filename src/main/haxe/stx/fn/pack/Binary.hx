package stx.fn.pack;

import stx.fn.head.data.Binary in BinaryT;

@:callable abstract Binary<PI,PII,R>(BinaryT<PI,PII,R>) from BinaryT<PI,PII,R>{
  public function new(self:BinaryT<PI,PII,R>){
    this = self;
  }

}