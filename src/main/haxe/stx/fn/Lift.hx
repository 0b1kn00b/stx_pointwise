package stx.fn;

class Lift{
  
}
class LiftUnary{
  static public inline function fn<PI,R>(fn:PI->R):Unary<PI,R>{
    return fn;
  }
}
class LiftBinary{
  static public inline function fn<PI,PII,R>(fn:PI->PII->R):Join<PI,PII,R>{
    return (tp) -> fn(tp.fst(),tp.snd());
  }
}