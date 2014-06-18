package stx;

import tink.core.Pair;
import tink.core.Either;

import stx.types.*;
import haxe.ds.Option;


using stx.Compose;
using stx.Functions;

class ComposeDo{
  /**
    Produces a function that calls `f1` and `f2` in left to right order.
  **/
  @returns("The composite function.")
  public static function then(f1:Void->Void, f2:Void->Void):Void->Void {
    return function() {
      f1();
      f2();
    }
  }
}
class ComposeDo1{
  /**
    Produces a function that calls `f1` and `f2` in left to right order with the same input, and returns no result.
  **/
  @returns("The composite function.")
  public static function then<P1>(f1:P1->Void, f2:P1->Void):P1->Void {     
    return function(p1) {       
      f1(p1);       
      f2(p1);
    }   
  }   
}
class ComposeDo2{
  /**
    Produces a function that calls `f1` and `f2` in left to right order with the same input, and returns no result.
  **/
  public static function then<P1, P2>(f1:P1->P2->Void, f2:P1->P2->Void):P1->P2->Void {
    return function(p1, p2) {
      f1(p1, p2);
      f2(p1, p2);
    }
  }
}
class ComposeDo3{
  /**
    Produces a function that calls `f1` and `f2` in left to right order with the same input, and returns no result.
  **/
  public static function then<P1, P2, P3>(f1:P1->P2->P3->Void, f2:P1->P2->P3->Void):P1->P2->P3->Void {
    return function(p1, p2, p3) {
      f1(p1, p2, p3);
      f2(p1, p2, p3);
    }
  }
}
class ComposeDo4{
  /**
    Produces a function that calls `f1` and `f2` in left to right order with the same input, and returns no result.
  **/
  public static function then<P1, P2, P3, P4>(f1:P1->P2->P3->P4->Void, f2:P1->P2->P3->P4->Void):P1->P2->P3->P4->Void {
    return function(p1, p2, p3, p4) {
      f1(p1, p2, p3, p4);
      f2(p1, p2, p3, p4);
    }
  }
}
class ComposeDo5{
  /**
    Produces a function that calls `f1` and `f2` in left to right order with the same input, and returns no result.
  **/
  public static function then<P1, P2, P3, P4, P5>(f1:P1->P2->P3->P4->P5->Void, f2:P1->P2->P3->P4->P5->Void):P1->P2->P3->P4->P5->Void {
    return function(p1, p2, p3, p4, p5) {
      f1(p1, p2, p3, p4, p5);
      f2(p1, p2, p3, p4, p5);
    }
  }
}
class Compose0{
  static public function then<A, B>(fn0:Thunk<A>,fn1:A->B):Thunk<B>{
    return function():B{
      return fn1(fn0());
    }
  }
}
/**
  Arrowlet class for Functions.
**/
class Compose{
  @:noUsing static public function apply<I,O>(fn:I->O,v:I):O{
    return fn(v);
  }
  /**
    Returns a function that applies `fn1` then `fn2` on the input
  **/
  static public function then<A,B,C>(fn1:A->B,fn2:B->C):A->C{
    return 
      function(a:A):C{
        return fn2(fn1(a));
      }
  }
  /**
    Returns a function that applies `fn1` to the left hand side of a Tuple
  **/
  static public function first<A,B,C,D>(fn1:A->C):Pair<A,B>->Pair<C,B>{
    return 
      function(t:Pair<A,B>){
        return new Pair(fn1(t.a),t.b);
      }
  }
  /**
    Returns a function that applies `fn1` to the right hand side of a Tuple
  **/
  static public function second<A,B,C,D>(fn1:B->D):Pair<A,B>->Pair<A,D>{
    return 
      function(t:Pair<A,B>){
        return new Pair(t.a,fn1(t.b));
      } 
  }
  static public function pair<A,B,C,D>(fn1:A->C,fn2:B->D):Pair<A,B>->Pair<C,D>{
    return 
      function(t){
        return new Pair(fn1(t.a),fn2(t.b));
      }
  }
  /**
    Returns a function that applies a function on the lhs of a tuple to the value on the rhs.
  **/
  static public function application<A,I,O>(fn:A->Pair<I->O,I>):A->O{
    return 
      function(v:A):O{
        var t = fn(v);
        return t.a(t.b);
      }
  }
  /**
    Returns a function that applies a function to the Left value of an Either.
  **/
  static public function left<A,B,C>(fn:A->C):Either<A,B>->Either<C,B>{
    return 
      function(e:Either<A,B>):Either<C,B>{
        return 
          switch (e) {
            case Left(v)  : Left(fn(v));
            case Right(v) : Right(v);
          }
      }
  }
  /**
    Returns a function that applies a function to the Right value of an Either.
  **/
  static public function right<A,B,D>(fn:B->D):Either<A,B>->Either<A,D>{
    return 
      function(e:Either<A,B>):Either<A,D>{
        return 
          switch (e) {
            case Left(v)  : Left(v);
            case Right(v) : Right(fn(v));
          }
      }
  }
  static public function fromR<A,B,C>(fn:B->Either<A,C>):Either<A,B>->Either<A,C>{
    return function(e:Either<A,B>){
      return switch (e){
        case    Left(l)      : Left(l);
        case    Right(r)     : fn(r);
      }
    }
  }
  /**
    Unit function.
        [[1,2],[3,4]].flatMap( Compose.unit() );//[1,2,3,4]
  **/
  @:noUsing static public function unit<A,B>():A->A{
    return cast function(x) return x;
  }
  /**
    Returns a function that produces a `Pair` from a value.
  **/
  static public function fan<I,O>(a:I->O):I->Pair<O,O>{
    return a.then(
        function(x){
          return new Pair(x,x);
        }
      );
  }
  /**
    Returns a function that produces `v`.
  **/
  @:noUsing static public function pure<A,B>(v:B):A->B{
    return function(x:A){ return v; }
  }
  static public function split<A,B,C>(split_:A->B,_split:A->C):A->Pair<B,C>{ 
    return function(x){
        return new Pair( split_(x), _split(x) );
      }
  }
  static public function tie<A,B,C>(bindl:A->C,bindr:Pair<A,C>->B):A->B{
    return unit().split(bindl).then( bindr );
  }
  static public function pinch<A,B,C>(fn0:Pair<A,A>->Pair<B,C>):A->Pair<B,C>{
    return function(x:A){
        return fn0(new Pair(x,x));
      }
  }
  static public function both<A,B>(fn:A->B):Pair<A,A>->Pair<B,B>{
    return function(t){
        return new Pair(fn(t.a),fn(t.b));
      }
  }
  /**
    Returns a function that calls `f1` with the output of `f2`.
  **/
  public static function compose<U, V, W>(f1: V->W, f2: U->V): U->W {
    return function(u: U): W {
      return f1(f2(u));
    }
  }
  static public function option<A,B>(fn:A->B):Option<A>->Option<B>{
    return function(opt:Option<A>){
      return switch (opt) {
        case Some(v) : Some(fn(v));
        case None    : None;
      }
    }
  }
  static public function fromOption<A,B>(fn:A->Option<B>):Option<A>->Option<B>{
    return function(opt:Option<A>):Option<B>{
      return switch (opt) {
        case Some(v) : 
          var o = fn(v);
          if(o == null){
            None;
          }else{
            o;
          }
        case None   : None;
      }
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
}
class Compose2{
  /**
    Returns a function that calls `f2` with the output of `f1`.
  **/
  public static function then<U, V, W, X>(f1: U->V->W, f2: W->X): U->V->X {
    return 
      function(u:U,v:V):X{
        return f2(f1(u,v));
      }
  }
}