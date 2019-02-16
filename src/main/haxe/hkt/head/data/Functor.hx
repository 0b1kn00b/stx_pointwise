package hkt.head.data;

import hkt.pack.App in AppA;

interface Functor<F>{
  public function map<A,B>(fn:Unary<A,B>): AppA<F,A> -> AppA<F,B>;
}