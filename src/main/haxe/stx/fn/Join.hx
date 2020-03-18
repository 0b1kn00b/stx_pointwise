package stx.fn;

@:forward @:callable abstract Join<PI,PII,R>(JoinDef<PI,PII,R>) from JoinDef<PI,PII,R> to JoinDef<PI,PII,R>{
  public function new(self){
    this = self;
  }
  @:to public function toUnary():Unary<Tuple<PI,PII>,R>{
    return this;
  }
  @:to public function toFunction():Tuple<PI,PII>->R{
    return this;
  }
  @:from static public function fromFn2<PI,PII,R>(fn:PI->PII->R):Join<PI,PII,R>{
    return (tp:Tuple<PI,PII>) -> __.into2(fn)(tp);
  }
}