package stx.fn;

@:forward @:callable abstract Other<PI,R>(OtherDef<PI,R>) from OtherDef<PI,R> to Other<PI,R>{
  public function new(self){
    this = self;
  }
  public function reply():R{
    return this(None);
  }
  public function apply(v:PI):R{
    return this(Some(v));
  }
  public function close(v:PI):Thunk<R>{
    return () -> apply(v);
  }
  @:from static public function fromUnaryT<PI,R>(fn:UnaryDef<Option<PI>,R>):Other<PI,R>{
    return new Other(fn);
  }
  public function broker<Z>(fn:Other<PI,R>->Z):Z{
    return fn(this);
  }
}