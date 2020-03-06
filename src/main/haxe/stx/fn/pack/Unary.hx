package stx.fn.pack;

import stx.fn.body.Unaries;
import stx.fn.head.data.Unary in UnaryT;
import stx.fn.head.data.Join  in JoinT;

@:callable abstract Unary<PI,R>(UnaryT<PI,R>) from UnaryT<PI,R> to UnaryT<PI,R>{
  @:noUsing static public function lift<PI,R>(fn:PI->R):Unary<PI,R>{
    return new Unary(fn);
  }
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
    return Unaries.apply(this,pi);
  }
  /**
   * Produces a function that calls the function with the given parameters `p1....pn`, calls this function only once and memoizes the result.
   * @param pi 
   * @return Thunk<R>
   */
  public inline function lazy(pi:PI):Thunk<R>{
    return Unaries.lazy(this,pi);
  }
  /**
    memoises the first call
  **/  
  public inline function memo():Unary<PI,R>{
    var lazed = null;
    return (pi:PI) -> {
      lazed = __.option(lazed).defv(lazy(pi));
      return lazed();
    }
  }
  /**
   * Produces a function that calls this function with the result of `pi`.
   * @param pi 
   * @return Thunk<R>
   */
  public inline function close(pi:Thunk<PI>):Thunk<R>{
    return Unaries.pipe(this,pi);
  }
  /**
   * Identity equality.
   * @param pi 
   * @return Bool
   */
  public inline function eq(pi:Unary<PI,R>):Bool{
    return Unaries.eq(this,pi);
  }
  
  /**
   * Produces a function that runs the introduced function after this.
   * @param fn 
   * @return Unary<P,RI>
   */
  public inline function then<RI>(fn:UnaryT<R,RI>):Unary<PI,RI>{
    return Unaries.then(this,fn);
  }
  /**
   * Produces a function that runs this after the introduced function.
   * @param fn 
   * @return Unary<P,RI>
   */
   public inline function comp<P0>(fn:UnaryT<P0,PI>):Unary<P0,R>{
    return Unaries.then(fn,this);
  }

  public inline function fork<RII>(fn:UnaryT<PI,RII>):Fork<PI,R,RII>{
    return Unaries.fork(this,fn);
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
  public function bound<RI>(bindr:Join<PI,R,RI>):Unary<PI,RI>{
    return Unaries.bound(this,bindr);
  }
  public function broach():Fork<PI,PI,R>{
    return bound(tuple2);
  }
  public function first<X>():Dual<PI,X,R,X>{
    return Unaries.first(this);
  }
  public function second<X>():Dual<X,PI,X,R>{
    return Unaries.second(this);
  }
  public function enclose(){
    return Unaries.enclose(this);
  }
  public function pair<PII,RII>(that:Unary<PII,RII>):Dual<PI,PII,R,RII>{
    return Unaries.pair(this,that);
  }
  public function prj():PI->R{
    return this;
  }
}