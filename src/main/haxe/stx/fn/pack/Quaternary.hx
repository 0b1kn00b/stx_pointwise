package stx.fn.pack;

import stx.fn.head.data.Quaternary in QuaternaryT;

@:callable abstract Quaternary<PI,PII,PIII,PIV,R>(QuaternaryT<PI,PII,PIII,PIV,R>) from QuaternaryT<PI,PII,PIII,PIV,R>{
  public function new(self:QuaternaryT<PI,PII,PIII,PIV,R>){
    this = self;
  }
}