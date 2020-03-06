package stx.fn.pack;

import stx.fn.head.data.Dual in DualT;

@:forward @:callable abstract Dual<PI,PII,RI,RII>(DualT<PI,PII,RI,RII>) from DualT<PI,PII,RI,RII> to DualT<PI,PII,RI,RII>{
  static public function unit<P>():Dual<P,P,P,P>{
    return new Dual(
      (tp:Tuple2<P,P>) -> (tp:Tuple2<P,P>)
    );
  }
  public function new(self:DualT<PI,PII,RI,RII>){
    this = self;
  }
  public function into<RIII>(fn:RI->RII->RIII){
    return this.then(__.into2(fn));
  }
  public function pass<RI0,RII0>(fn:RI->RII->Tuple2<RI0,RII0>):Dual<PI,PII,RI0,RII0>{
    return this.then(__.into2(fn));
  }
  public function first<RI0>(fn:RI->RI0):Dual<PI,PII,RI0,RII>{
    return this.then(fn.fn().first());
  }
  public function second<RII0>(fn:RII->RII0):Dual<PI,PII,RI,RII0>{
    return this.then(fn.fn().second());
  }
}