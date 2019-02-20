package stx.fn.pack;

import stx.fn.body.Ternaries;

import stx.fn.head.data.Ternary in TernaryT;

@:callable abstract Ternary<PI,PII,PIII,R>(TernaryT<PI,PII,PIII,R>) from TernaryT<PI,PII,PIII,R>{
  public function new(self:TernaryT<PI,PII,PIII,R>){
    this = self;
  }
  public function curry(){
    return Ternaries.curry(this);
  }
}