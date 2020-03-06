package stx.fn;

class Lift{
  static public function fn(stx:Wildcard):Api{
    return new Api();
  }
  /**
    Creates a function that splits an input to it's inputs.
  **/
  static public function pinch<A,B,C>(fn0:Dual<A,A,B,C>):Fork<A,B,C>{
    return function(x:A){
        return fn0(tuple2(x,x));
      }
  }
  static public function repeat<I,O>(fn:I->Either<I,O>):I->O{
    return function(v:I){
      var i : I = null;
      var o : O = null;
      while(true){
        switch (fn(i)) {
          case Left(v) : i = v;
          case Right(v) : o = v; break;
        }
      }
      return o;
    }
  }
  /**
  *  An operation that soley passes it's input.
  **/
  static inline public function noop<A>():Unary<A,A>{
    return function (a:A){ return a; }
  }
  static inline public function Thunk(__:Wildcard){
    return new ThunkApi();
  }
  static public function broker<T,U>(v:T,fn:Unary<T,T> -> Unary<T,U>):U{
    return fn(__.through())(v);
  }
  static public macro function brokert<T,U>(e0:haxe.macro.Expr,e1:haxe.macro.Expr):haxe.macro.Expr{

    var str0 = haxe.macro.TypeTools.toString(haxe.macro.Context.typeof(e0));
    var str1 = haxe.macro.TypeTools.toString(haxe.macro.Context.typeof(e1));

    haxe.macro.Context.warning(str0,haxe.macro.Context.currentPos());
    haxe.macro.Context.warning(str1,haxe.macro.Context.currentPos());

    return macro {
      stx.core.Lift.broker($e0,$e1);
    }
  }
  //Ignores the input function, so you can see the types if there is an error in the function
  static public macro function brokeru<T,U>(e0:haxe.macro.Expr,e1:haxe.macro.Expr):haxe.macro.Expr{

    var str0 = haxe.macro.TypeTools.toString(haxe.macro.Context.typeof(e0));
    var str1 = haxe.macro.TypeTools.toString(haxe.macro.Context.typeof(e1));

    haxe.macro.Context.warning(str0,haxe.macro.Context.currentPos());
    haxe.macro.Context.warning(str1,haxe.macro.Context.currentPos());
    
    return macro {
      $e0;
    }
  }
  static public function dual<P>(_:Wildcard){
    return Dual.unit();
  }
}

class ThunkApi{
  public function new(){}
}

class LiftSink{
  static public inline function fn<T>(f:T->Void):Sink<T>{
     return f;
  }
  
}
class LiftBlock{
  static public inline function fn(f:Void->Void):Block{
    return f;
  }
}
class LiftThunk{
  static public inline function fn<R>(fn:Void->R):Thunk<R>{
    return fn;
  }
}

class LiftUnaryT{
  static public function elevate<PI,PII,RI,RII>(fn:RI->RII):Unary<Unary<PI,PII->RI>,Unary<PI,Unary<PII,RII>>>{
    var l = LiftUnary.fn;
    return((f0:Unary<PI,PII->RI>) -> f0.then(
      (f1:PII->RI) -> l(f1).then(fn) 
    ));
  }
}
class LiftUnary{
  static public inline function fn<PI,R>(fn:PI->R):Unary<PI,R>{
    return fn;
  }
  static inline public function bind1<P,R>(fn:P->R,p:P):Thunk<R>{
    return fn.bind(p);
  }
}
class LiftBinary{
  static public inline function fn<PI,PII,R>(fn:PI->PII->R):Binary<PI,PII,R>{
    return new Binary(fn);
  }
  static inline public function bind1<PI,PII,R>(fn:PI->PII->R,p:PI):Unary<PII,R>{
    return fn.bind(p);
  }
}
class LiftPerhapsConstructor{
  static public inline function perhaps<P,R>(fn:P->Option<R>):Perhaps<P,R>{
    return (x) -> switch(x){
      case Some(v)  : fn(v);
      case None     : None;
    }
  }
}
class LiftPerhaps{
  static public inline function perhaps<P,R>(fn:P->R):Perhaps<P,R>{
    return (x) -> switch(x){
      case Some(v)  : Some(fn(v));
      case None     : None;
    }
  } 
}
class LiftTernary{
  static public inline function fn<PI,PII,PIII,R>(fn:PI->PII->PIII->R):Ternary<PI,PII,PIII,R>{
    return fn;
  }
}
class LiftAppliableToUnary{
  static public function fn<P,R>(apply:Appliable<P,R>):Unary<P,R>{
    return apply.apply;
  }
}
class LiftIf{
  static public function if_else<T>(b:Bool,yes:Thunk<T>,no:Thunk<T>){
    return switch(b){
      case true   : yes();
      case false  : no();
    }
  }
}