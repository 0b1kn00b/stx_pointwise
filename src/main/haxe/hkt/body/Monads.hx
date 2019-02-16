package hkt.body;

import hkt.pack.Monad;
import hkt.pack.App in AppA;
 
class Monads{
  static public function map<F,A,B>(m:Monad<F>,fn:A->B):AppA<F,A>->AppA<F,B>{
    var next = m.apply.bind(m.pure(fn)); 
    return next;
  }  
  static public function pure<F,A>(m:Monad<F>,v:A):AppA<F,A>{
    return m.returns(v);
  }
}