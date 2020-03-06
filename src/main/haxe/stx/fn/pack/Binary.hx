package stx.fn.pack;

import stx.fn.body.Binaries;
import stx.fn.head.data.Binary in BinaryT;

@:callable abstract Binary<PI,PII,R>(BinaryT<PI,PII,R>) from BinaryT<PI,PII,R>{
  public function new(self:BinaryT<PI,PII,R>){
    this = self;
  }
  public function tp():Join<PI,PII,R>{
    return (tp) -> this(tp.fst(),tp.snd());
  }
  public function flip():Binary<PII,PI,R>{
    return Binaries.flip(this);
  }
  public function bind1(pi:PI):Unary<PII,R>{
    return this.bind(pi);
  }
  public function prj():PI->PII->R{
    return this;
  }
}