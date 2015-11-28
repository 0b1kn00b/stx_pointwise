package stx;

using stx.Tuple;

@:callable abstract M1<P,R>(P->R) from P->R to P->R{
  public function new(self){
    this = self;
  }
  @:from static public function fromFunction2<P0,P1,R>(fn:P0->P1->R):M1<Tuple2<P0,P1>,R>{
    return Tuples2.tupled(fn);
  }
  @:from static public function fromM2<P0,P1,R>(fn:M2<P0,P1,R>):M1<Tuple2<P0,P1>,R>{
    return Tuples2.tupled(fn);
  }

  public function then<R,R1>(fn:M1<R,R1>):M1<P,R1>{
    return Compose.then(this,fn);
  }

  public function first<B>():M1<Tuple2<P,B>,Tuple2<R,B>>{
    return Compose.first(this);
  }
  public function second<A>():M1<Tuple2<A,P>,Tuple2<A,R>>{
    return Compose.second(this);
  }
}

class Methods1{
  static public function untuple<P0,P1,R>(fn:M1<Tuple2<P0,P1>,R>):M2<P0,P1,R>{
    return Tuples2.untupled(fn);
  }
}

@:callable abstract M2<P0,P1,R>(P0->P1->R) from P0->P1->R to P0->P1->R{
  public function new(self){
    this = self;
  }
  /**
    Curry the
  **/
  public function c0(p0){
    return Methods2.c0(this,p0);
  }
  public function c1(p1){
    return Methods2.c1(this,p1);
  }
  public function tuple(){
    return Methods2.tupled(this);
  }
}
class Methods2{
  static public function c0<P0,P1,R>(m:M2<P0,P1,R>,p0:P0):M1<P1,R>{
    var fn : P0 -> P1 -> R = m;
    return fn.bind(p0);
  }
  static public function c1<P0,P1,R>(m:M2<P0,P1,R>,p1:P1):M1<P0,R>{
    var fn : P0 -> P1 -> R = m;
    return fn.bind(_,p1);
  }
  static public function tupled<P0,P1,R>(m:M2<P0,P1,R>):M1<Tuple2<P0,P1>,R>{
    return Tuples2.tupled(m);
  }
}
