package hkt.head.data;

import hkt.pack.App in AppA;

interface Applicative<F> extends Functor<F>{
  public function pure<T>(v:T): AppA<F,T>;
  public function apply<T,R>(fn: AppA<F,T->R>,v:AppA<F,T>):AppA<F,R>;
}