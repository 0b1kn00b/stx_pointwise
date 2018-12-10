package stx.fn.pack;

import stx.fn.head.data.Dual in DualT;

@:forward @:callable abstract Dual<PI,PII,RI,RII>(DualT<PI,PII,RI,RII>) from DualT<PI,PII,RI,RII> to DualT<PI,PII,RI,RII>{
  public function new(self:DualT<PI,PII,RI,RII>){
    this = self;
  }
}