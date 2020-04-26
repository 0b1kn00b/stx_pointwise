package stx.fn;

@:using(stx.fn.Ternary.TernaryLift)
@:callable abstract Ternary<Pi,Pii,Piii,R>(TernaryDef<Pi,Pii,Piii,R>) from TernaryDef<Pi,Pii,Piii,R>{
  
  static public inline function _() return Constructor.ZERO;

  public function new(self:TernaryDef<Pi,Pii,Piii,R>){
    this = self;
  }
}
class TernaryLift extends Clazz{
  /**
		Places first parameter at the back.
	**/
  static public function rotate<Pi, Pii, Piii, R>(f: Pi->Pii->Piii->R): Pii->Piii->Pi->R {
    return function(pII:Pii,pIII:Piii,pI:Pi){
      return f(pI,pII,pIII);
    }
  }
  /**
    Produces a function that produces a function for each parameter in the originating function. When these
    functions have been called, the result of the original function is produced.
  **/
  static public function curry<Pi, Pii, Piii, R>(f: Pi->Pii->Piii->R): Pi -> (Pii -> (Piii -> R)) {
    return (pI) -> (pII) -> (pIII) -> f(pI,pII,pIII);
  }
  /**
		Produdes a function that calls `f` with the given parameters `pI....pn`.
	**/
  static public function cache<Pi, Pii, Piii, R>(self: Pi->Pii->Piii->R,pI: Pi, pII: Pii, pIII: Piii): Thunk<R> {
    var r : R   = null;

    return function() {
      return if (r == null) {
        r = untyped (false);//<--- breaks live lock
        r = self(pI,pII,pIII); r;
      }else{
        r;
      }
    }
  }
  /**
		Compares function identity.
	**/
  static public function equals<Pi, Pii, Piii, R>(self:Pi->Pii->Piii->R,that:Pi->Pii->Piii->R){
    return Reflect.compareMethods(self,that);
  }
}