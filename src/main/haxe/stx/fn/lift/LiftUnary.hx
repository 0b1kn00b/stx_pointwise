package stx.fn.lift;

class LiftUnary{
  static public function elevate<Pi,Pii,Ri,Rii>(fn:Ri->Rii):Unary<Unary<Pi,Pii->Ri>,Unary<Pi,Unary<Pii,Rii>>>{
    var l = LiftUnary.fn;
    return((f0:Unary<Pi,Pii->Ri>) -> f0.then((f1:Pii->Ri) -> l(f1).then(fn) ));
  }
  static public inline function fn<Pi,R>(fn:Pi->R):Unary<Pi,R>{
    return fn;
  }
  static inline public function bindI<P,R>(fn:P->R,p:P):Thunk<R>{
    return fn.bind(p);
  }
}