package stx.fn.pack;

import stx.fn.head.data.Join in JoinT;

@:forward @:callable abstract Join<PI,PII,R>(JoinT<PI,PII,R>) from JoinT<PI,PII,R> to JoinT<PI,PII,R>{
  public function new(self){
    this = self;
  }
  @:to public function toUnary():Unary<Tuple2<PI,PII>,R>{
    return this;
  }
  @:to public function toFunction():Tuple2<PI,PII>->R{
    return this;
  }
  @:from static public function fromFn2<PI,PII,R>(fn:PI->PII->R):Join<PI,PII,R>{
    return (tp:Tuple2<PI,PII>) -> __.into2(fn)(tp);
  }
}