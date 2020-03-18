package stx.fn.pack;

import stx.fn.pack.ternary.Constructor;

@:callable abstract Ternary<Pi,Pii,Piii,R>(TernaryDef<Pi,Pii,Piii,R>) from TernaryDef<Pi,Pii,Piii,R>{
  
  static public inline function _() return Constructor.ZERO;

  public function new(self:TernaryDef<Pi,Pii,Piii,R>){
    this = self;
  }
  public function curry()                                                   return _()._.curry(this);
  public function rotate(): Ternary<Pii,Piii,Pi,R>                          return _()._.rotate(this);
  
  public function cache(pI: Pi, pII: Pii, pIII: Piii): Thunk<R>             return _()._.cache(pI,pII,pIII,this);

  public function equals(that:Pi->Pii->Piii->R)                             return _()._.equals(that,this);
}