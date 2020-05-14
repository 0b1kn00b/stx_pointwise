package stx.fn;

@:using(stx.fn.Unary.UnaryLift)
@:callable abstract Unary<PI,R>(UnaryDef<PI,R>) from UnaryDef<PI,R> to UnaryDef<PI,R>{
  static public var _(default,never) = UnaryLift;

  public function new(self:UnaryDef<PI,R>) this = self;
  @:noUsing static public function lift<PI,R>(fn:PI->R):Unary<PI,R> return new Unary(fn);
  @:noUsing static public function unit<PI>():Unary<PI,PI> return lift((x:PI) -> x);
  
  @:noUsing static public function pure<PI,R>(r:R):Unary<PI,R>{
    return (v:PI) -> r;
  }
  
  public function prj():PI->R{
    return this;
  }
}
class UnaryLift{

  /**
   * Applies the function.
   * @param fn The function  
   * @param p1 The parameter
   * @return Thunk<R>
   */
   static public function apply<Pi,R>(self:Unary<Pi,R>,pI:Pi):R{
    return self(pI);
  }
  /**
   * Produces a function that calls `f` with the given parameters `p1....pn`, calls this function only once and memoizes the result.
   * @param fn 
   * @return }
   */
  @:note("those brackets are there to fox the Java compiler")
  static public function cache<Pi, R>(self: Unary<Pi,R>,pI: Pi){
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
		As with cache, but calls the wrapped function every time it is called.
	**/
  static public function pipe<Pi, R>(self: Unary<Pi,R>,pI: Void -> Pi){
    return function(){
      return self(pI());
    }
  }
  /**
		Compares function identity.
	**/
  static public function equals<Pi,R>(self:Unary<Pi,R>,that:Pi->R):Bool{
    return Reflect.compareMethods(self,that);
  }
  
  /**
   * Returns a function that applies `fn1` then `that` on the input
   * @param fn1 
   * @param fn2 
   * @return Pi->R
   */
  static public function then<Pi,Pii,R>(self:Unary<Pi,Pii>,that:Unary<Pii,R>):Unary<Pi,R>{
    return function(a:Pi):R{
      return that(self(a));
    }
  }
  /**
   * Returns a function that calls the original function both on the left and the right of a Couple.
  **/
  static public function dual<Pi,R>(self:Pi->R):Dual<Pi,Pi,R,R>{
    return function(t:Couple<Pi,Pi>){
      return t.decouple(
        (l,r) -> __.couple(self(l),self(r))
      );
    }
  }
  static function perhaps<Pi,R>(self:Pi->R):Perhaps<Pi,R>{
    return (x:Option<Pi>) -> switch(x){
      case Some(v) : Some(self(v));
      case None: None;
    }
  }
  /**
    Returns a function that applies `fn1` to the left hand side of a Couple
  **/
  static public function first<Pi,Pii,Ri,D>(fn1:Unary<Pi,Ri>):Dual<Pi,Pii,Ri,Pii>{
    return function(t:Couple<Pi,Pii>){
      return __.couple(fn1(t.fst()),t.snd());
    }
  }
  /**
    Returns a function that applies `fn1` to the right hand side of a Couple
  **/
  static public function second<Pi,Pii,Ri,Rii>(fn1:Pii->Rii):Dual<Pi,Pii,Pi,Rii>{
    return function(t:Couple<Pi,Pii>){
      return __.couple(t.fst(),fn1(t.snd()));
    }
  }
  /**
    Applies a function to the input, passing it's original input plus output forward to `bindr`.
  **/
  static public function bound<P,Ri,Rii>(bindl:Unary<P,Ri>,bindr:Unary<Couple<P,Ri>,Rii>):Unary<P,Rii>{
      var out = Unary.unit().split(bindl).then(bindr);
    return out;
  }
  /**
   * Applies a function to the input, and produces the original input plus the calculated value.
  **/
   static public function broach<Pi,R>(bindl:Unary<Pi,R>):Unary<Pi,Couple<Pi,R>>{
    return bound(bindl,(x) -> x);
  }
    /**
    Riombines functions such that a single input is passed to both.
  **/
  static public function split<P,Ri,Rii>(self:Unary<P,Ri>,that:Unary<P,Rii>):Unary<P,Couple<Ri,Rii>>{
    return function(p:P){
      return __.couple( self(p), that(p) );
    }
  }
  /**
    Returns a function that produces a `Couple` from a value.
  **/
  static public function fan<P,R>(a:P->R):Unary<P,Couple<R,R>>{
    return a.fn().then(
      function(x){
        return __.couple(x,x);
      }
    );
  }  
  /**
   * Binds two functions together to run with bound inputs. 
   * @param fn1 
   * @param fn2 
   * @return Couple<A,B>->Couple<C,D>
   */
   static public inline function pair<Pi,Pii,Ri,Rii>(fn1:Unary<Pi,Ri>,fn2:Unary<Pii,Rii>):Dual<Pi,Pii,Ri,Rii>{
    return
      function(t){
        return __.couple(fn1(t.fst()),fn2(t.snd()));
      }
  }  
}