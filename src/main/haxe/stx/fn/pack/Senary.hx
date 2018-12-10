package stx.fn.pack;

import stx.fn.head.data.Senary in SenaryT;

@:callable abstract Senary<PI,PII,PIII,PIV,PV,PVI,R>(SenaryT<PI,PII,PIII,PIV,PV,PVI,R>) from SenaryT<PI,PII,PIII,PIV,PV,PVI,R>{
  public function new(self:SenaryT<PI,PII,PIII,PIV,PV,PVI,R>){
    this = self;
  }
}