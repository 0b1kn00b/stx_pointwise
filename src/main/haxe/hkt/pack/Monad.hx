package hkt.pack;

import hkt.body.Monads;
import hkt.head.data.Monad in MonadT;

@:forward abstract Monad<F>(MonadT<F>) from MonadT<F> to MonadT<F>{
  public function new(self){
    this = self;
  }
  public function map<A,B>(fn:Unary<A,B>): App<F,A> -> App<F,B>{
    return Monads.map(this,fn);
  }
  public function pure<A,B>(x){
    return Monads.pure(this,x);
  } 
}