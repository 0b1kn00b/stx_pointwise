package stx.fn.pack;

using stx.fn.body.Unaries;
import stx.fn.head.data.Unary in UnaryT;

@:using(Unaries) @:callable abstract Unary<PI,R>(UnaryT<PI,R>) from UnaryT<PI,R> to UnaryT<PI,R>{
  @:noUsing static public function pure<PI,R>(r:R):Unary<PI,R>{
    return (v:PI) -> r;
  }
  public function new(self:UnaryT<PI,R>){
    this = self;
  }
  /**
   * Applies the function with the parameter.
   * @param pi function parameter
   * @return R return type
   */
  public inline function apply(pi:PI):R{
    return this.apply(pi);
  }
  /**
   * Creates a function that applies the function and returns either an Error or the result
   * @return Unary<PI,Outcome<R,Error>>
   */
  public inline function catching():Unary<PI,Outcome<R,Error>>{
    return this.catching();
  }
  /**
   * Produces a function that calls the function with the given parameters `p1....pn`, calls this function only once and memoizes the result.
   * @param pi 
   * @return Thunk<R>
   */
  public inline function lazy(pi:PI):Thunk<R>{
    return this.lazy(pi);
  }
  /**
   * Produces a function that calls this function with the result of `pi`.
   * @param pi 
   * @return Thunk<R>
   */
  public inline function pipe(pi:Thunk<PI>):Thunk<R>{
    return this.pipe(pi);
  }
  /**
   * Identity equality.
   * @param pi 
   * @return Bool
   */
  public inline function eq(pi:Unary<PI,R>):Bool{
    return this.eq(pi);
  }
  
  /**
   * Produces a function that runs the introduced function after this.
   * @param fn 
   * @return Unary<P,RI>
   */
  public inline function then<RI>(fn:Unary<R,RI>):Unary<PI,RI>{
    return this.then(fn);
  }

  public inline function fork<RII>(fn:Unary<PI,RII>):Fork<PI,R,RII>{
    return this.fork(fn);
  } 

   /**
    Creates a function applying the same function to both the left and right portions of
    a Tuple2;
  **/
  public function dual():Dual<PI,PI,R,R>{
    return function(t){
      return tuple2(this(t.fst()),this(t.snd()));
    }
  }
  public function perhaps():Perhaps<PI,R>{
    return (x:Option<PI>) -> switch(x){
      case Some(v) : Some(this(v));
      case None: None;
    }
  }
  public function toFunction():PI->R{
    return this;
  }
}