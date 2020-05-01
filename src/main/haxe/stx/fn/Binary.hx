package stx.fn;

@:using(stx.fn.Binary.BinaryLift)
@:callable abstract Binary<Pi,Pii,R>(BinaryDef<Pi,Pii,R>) from BinaryDef<Pi,Pii,R> to BinaryDef<Pi,Pii,R>{
  static public var _(default,never) = BinaryLift;

  public function new(self:BinaryDef<Pi,Pii,R>){
    this = self;
  }
  public function prj():Pi->Pii->R{
    return this;
  }
}
class BinaryLift extends Clazz{
  static public function then<Pi,Pii,R,Ri>(self:Pi->Pii->R,that:R->Ri):Binary<Pi,Pii,Ri>{
    return (pI:Pi,pII:Pii) -> return that(self(pI,pII));
  }

  static public function braid<Pi,Pii,R>(self:Pi->Pii->R,pI:Pi,pII:Pii):R{
    return self(pI,pII);
  }
  /**
		Places parameter 1 at the back.
	**/
  static public function rotate<Pi, Pii, R>(self:Pi->Pii->R): Binary<Pii,Pi,R>{
    return function(pII:Pii, pI:Pi){
        return self(pI,pII);
      }
  }
  /**
		Produces a function which takes the parameters of `f` in a flipped order.
	**/
  static public function swap<Pi, Pii, R>(self: Pi->Pii->R): Binary<Pii,Pi,R>{
    return function(pII, pI) {
      return self(pI, pII);
    }
  }
  /**
    Produces a function that produces a function for each parameter in the originating function. When these
    functions have been called, the result of the original function is returned.
  **/
  static public function curry<Pi, Pii, R>(self: Pi->Pii->R): (Pi->(Pii->R)){
    return function(pI: Pi) {
      return function(pII: Pii) {
        return self(pI, pII);
      }
    }
  }

  /**
		Compares function identity.
	**/
  static public function equals<Pi,Pii,R>(self:Pi->Pii->R,that:Pi->Pii->R){
    return Reflect.compareMethods(self,that);
  }
  /**
    Calls only first parameter, returning Unary function
  **/
  static public function bindPi<Pi,Pii,R>(self:Pi->Pii->R,pI:Pi):Pii->R{
    var fn : Pi -> Pii -> R = self;
    return fn.bind(pI);
  }
  /**
    Calls only second parameter, returning Unary function
  **/
  static public function bindPii<Pi,Pii,R>(pII:Pii,self:Pi->Pii->R):Pi->R{
    var fn : Pi -> Pii -> R = self;
    return fn.bind(_,pII);
  }
  /*
		Procudes a function that calls `f` with the given parameters `p1....pn`, and caches the result
  **/
  static public function cache<Pi,Pii,R>(self: Binary<Pi,Pii,R>, pI: Pi,pII: Pii): Thunk<R>{
    var r : R   = null;

    return function() {
      return if (r == null) {
        r = untyped (false);//<--- breaks live lock
        r = self(pI,pII); r;
      }else{
        r;
      }
    }
  }
  /**
    As with lazy, but calls the wrapped function every time it is called.
  **/
  static public function pipe<Pi, Pii, R>(self: Pi->Pii->R,tp : Thunk<Couple<Pi,Pii>>): Thunk<R>{
    return function(){
      return tp().decouple(self);
    }
  }  
}