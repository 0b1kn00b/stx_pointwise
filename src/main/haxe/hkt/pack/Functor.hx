package hkt.pack;

import hkt.head.data.Functor in FunctorT;

@:forward abstract Functor<F>(FunctorT<F>) from FunctorT<F> to FunctorT<F>{
  public function new(self){
    this = self;
  }
}