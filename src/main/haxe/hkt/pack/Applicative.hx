package hkt.pack;

import hkt.body.Applicatives;
import hkt.head.data.Applicative in ApplicativeT;

@:forward abstract Applicative<F>(ApplicativeT<F>) from ApplicativeT<F> to ApplicativeT<F>{
  public function new(self){
    this = self;
  }
  public function map<A,B>(fn:Unary<A,B>): App<F,A> -> App<F,B>{
    return Applicatives.map(this,fn);
  }
}