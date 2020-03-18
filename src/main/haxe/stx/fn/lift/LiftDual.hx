package stx.fn.lift;

class LiftDual{
  /**
    Returns a function that produces a `Tuple` from a value.
  **/
  static public function fan<P,R>(a:P->R):Fork<P,R,R>{
    return a.fn().then(
      function(x){
        return __.tuple(x,x);
      }
    );
  }  
  /**
    Riombines functions such that a single input is passed to both.
  **/
  static public function fork<P,Ri,Rii>(self:Unary<P,Ri>,that:Unary<P,Rii>):Fork<P,Ri,Rii>{
    return function(p:P){
      return __.tuple( self(p), that(p) );
    }
  }
  /**
    Applies a function to the input, and produces the original input plus the calculated value.
  **/
  static public function span<Pi,R>(bindl:Unary<Pi,R>):Fork<Pi,Pi,R>{
    return bound(bindl,(x) -> x);
  }
   /**
    Applies a function to the input, passing it's original input plus output forward to `bindr`.
  **/
  static public function bound<P,Ri,Rii>(bindl:Unary<P,Ri>,bindr:Join<P,Ri,Rii>):Unary<P,Rii>{
      var out = Unary.unit().fork(bindl).then(bindr);
    return out;
  }

  /**
    Returns a function that applies `fn1` to the left hand side of a Tuple
  **/
  static public function first<Pi,Pii,Ri,D>(fn1:Unary<Pi,Ri>):Dual<Pi,Pii,Ri,Pii>{
    return function(t:Tuple<Pi,Pii>){
      return __.tuple(fn1(t.fst()),t.snd());
    }
  }
  /**
    Returns a function that applies `fn1` to the right hand side of a Tuple
  **/
  static public function second<Pi,Pii,Ri,Rii>(fn1:Pii->Rii):Dual<Pi,Pii,Pi,Rii>{
    return function(t:Tuple<Pi,Pii>){
      return __.tuple(t.fst(),fn1(t.snd()));
    }
  }
}