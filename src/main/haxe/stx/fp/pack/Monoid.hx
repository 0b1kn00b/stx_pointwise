package stx.fp.pack;

import stx.fp.head.data.Monoid in MonoidT;

@:forward abstract Monoid<T>(MonoidT<T>) from MonoidT<T>{
  public function new(self){
    this = self;
  }
  public function put(v:T):Monoid<T>{
    return {
      prior : () -> this.batch(this.prior(),v),
      batch: (l,r) -> this.batch(l,r) 
    }
  }
  public function into<F>(next:F,fn:Monoid<T>->F->T){
    return put(fn(this,next));
  }
}