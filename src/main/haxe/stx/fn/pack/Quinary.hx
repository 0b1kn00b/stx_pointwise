package stx.fn.pack;


import stx.fn.head.data.Quinary in QuinaryT;

@:callable abstract Quinary<PI,PII,PIII,PIV,PV,R>(QuinaryT<PI,PII,PIII,PIV,PV,R>) from QuinaryT<PI,PII,PIII,PIV,PV,R>{
  public function new(self:QuinaryT<PI,PII,PIII,PIV,PV,R>){
    this = self;
  }
}