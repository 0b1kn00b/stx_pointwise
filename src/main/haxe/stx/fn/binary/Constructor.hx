package stx.fn.binary;

class Constructor{
  public function new(){}
  
  static public var ZERO(default,never) = new Constructor();
  public var _(default,never) = new Destructure();
}
class Destructure extends Clazz{
  public function braid<Pi,Pii,R>(pI:Pi,pII:Pii,self:Pi->Pii->R):R{
    return self(pI,pII);
  }
  /**
		Places parameter 1 at the back.
	**/
  public function rotate<Pi, Pii, R>(f:Pi->Pii->R): Pii->Pi->R {
    return function(pII:Pii, pI:Pi){
        return f(pI,pII);
      }
  }
  /**
		Produces a function which takes the parameters of `f` in a flipped order.
	**/
  public function swap<Pi, Pii, R>(f: Pi->Pii->R): Pii->Pi->R{
    return function(pII, pI) {
      return f(pI, pII);
    }
  }
  /**
    Produces a function that produces a function for each parameter in the originating function. When these
    functions have been called, the result of the original function is returned.
  **/
  public function curry<Pi, Pii, R>(f: Pi->Pii->R): (Pi->(Pii->R)) {
    return function(pI: Pi) {
      return function(pII: Pii) {
        return f(pI, pII);
      }
    }
  }

  /**
		Compares function identity.
	**/
  public function equals<Pi,Pii,R>(that:Pi->Pii->R,self:Pi->Pii->R) {
    return Reflect.compareMethods(self,that);
  }
  /**
    Calls only first parameter, returning Unary function
  **/
  public function bindPi<Pi,Pii,R>(pI:Pi,self:Pi->Pii->R):Pii->R{
    var fn : Pi -> Pii -> R = self;
    return fn.bind(pI);
  }
  /**
    Calls only second parameter, returning Unary function
  **/
  public function bindPii<Pi,Pii,R>(pII:Pii,self:Pi->Pii->R):Pi->R{
    var fn : Pi -> Pii -> R = self;
    return fn.bind(_,pII);
  }
  /**
		Procudes a function that calls `f` with the given parameters `p1....pn`, and caches the result
  **/
  public function cache<Pi,Pii,R>(pI: Pi,pII: Pii,self: Binary<Pi,Pii,R>): Thunk<R> {
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
  public function pipe<Pi, Pii, R>(tp : Thunk<Tuple<Pi,Pii>>,self: Pi->Pii->R): Thunk<R> {
    return function(){
      return tp().into(self);
    }
  }
}