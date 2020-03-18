package stx.fn.pack.unary;


class Constructor extends Clazz{
  static public var ZERO(default,never) = new Constructor();
  public var _(default,never) = new Destructure();

  /**
   * unit function
   * @return Unary<A,A>
   */
   public function unit<A>():Unary<A,A>{
    return (x:A) -> x;
  }
}
/**
  Class for working with Unary Functions.
**/
class Destructure extends Clazz{

  /**
   * Applies the function.
   * @param fn The function  
   * @param p1 The parameter
   * @return Thunk<R>
   */
  public inline function apply<Pi,R>(pI:Pi,self:Unary<Pi,R>):R{
    return self(pI);
  }
  /**
   * Produces a function that calls `f` with the given parameters `p1....pn`, calls this function only once and memoizes the result.
   * @param fn 
   * @return }
   */
  @:note("those brackets are there to fox the Java compiler")
  public inline function cache<Pi, R>(pI: Pi,self: Unary<Pi,R>): Thunk<R> {
    var r : R   = null;

    return function() {
      return if (r == null) {
        r = untyped (false);//<--- breaks live lock
        r = self(pI); r;
      }else{
        r;
      }
    }
  }
  /**
		As with lazy, but calls the wrapped function every time it is called.
	**/
  public inline function pipe<Pi, R>(pI: Void -> Pi,self: Pi -> R): Void -> R {
    return function(){
      return self(pI());
    }
  }
  /**
		Compares function identity.
	**/
  public function equals<Pi,R>(that:Pi->R,self:Pi->R):Bool{
    return Reflect.compareMethods(self,that);
  }
  
  /**
   * Returns a function that applies `fn1` then `that` on the input
   * @param fn1 
   * @param fn2 
   * @return Pi->R
   */
  public inline function then<Pi,Pii,R>(fn1:Pi->Pii,that:Unary<Pii,R>):Unary<Pi,R>{
    return
      function(a:Pi):R{
        return that(fn1(a));
      }
  }

  public function dual<Pi,R>(self:Pi->R):Dual<Pi,Pi,R,R>{
    return function(t:Tuple<Pi,Pi>){
      return t.into(
        (l,r) -> __.tuple(self(l),self(r))
      );
    }
  }
  public function perhaps<Pi,R>(self:Pi->R):Perhaps<Pi,R>{
    return (x:Option<Pi>) -> switch(x){
      case Some(v) : Some(self(v));
      case None: None;
    }
  }
}
