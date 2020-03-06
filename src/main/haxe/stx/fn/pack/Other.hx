package stx.fn.pack;

import stx.fn.head.data.Unary in UnaryT;
import stx.fn.head.data.Other in OtherT;

@:forward @:callable abstract Other<PI,R>(OtherT<PI,R>) from OtherT<PI,R> to Other<PI,R>{
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
  @:from static public function fromUnaryT<PI,R>(fn:UnaryT<Option<PI>,R>):Other<PI,R>{
    return new Other(fn);
  }
  public function broker<Z>(fn:Other<PI,R>->Z):Z{
    return fn(this);
  }
}