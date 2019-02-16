package hkt.body;

import hkt.pack.App;
import hkt.pack.Applicative;
 
class Applicatives{
  static public function map<F,A,B>(ap:Applicative<F>,fn:Unary<A,B>): App<F,A> -> App<F,B>{
    var arg = ap.pure(fn);
    return ap.apply.bind(arg);
  }
}