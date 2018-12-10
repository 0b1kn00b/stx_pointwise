package stx.fn.pack;

import stx.fn.head.data.Fork in ForkT;

@:forward @:callable abstract Fork<P,RI,RII>(ForkT<P,RI,RII>) from ForkT<P,RI,RII> to ForkT<P,RI,RII>{
  public function new(self){
    this = self;
  }
  @:from static public function fromUnary<P,RI,RII>(fn:Unary<P,Tuple2<RI,RII>>){
    return new Fork(fn);
  }
  @:to public function toUnary():Unary<P,Tuple2<RI,RII>>{
    return this;
  }
  public function then<RIII>(fn:Join<RI,RII,RIII>):Unary<P,RIII>{
    return this.then(fn);
  }
}