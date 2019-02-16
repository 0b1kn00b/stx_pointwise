package hkt.pack;

import hkt.body.Monads;
import hkt.pack.newtypes.NewOption;
import haxe.ds.Option in Option_;

@:allow(hkt)class Option extends hkt.head.data.Brand{
  private function new(){
    super();
  }
  static public function get<U>():NewOption<U>{
    return new NewOption();
  }
  static public function inj<T>(opt:Option_<T>):App<Option,T>{
    return get().inj(opt);
  }
  static public function prj<T>(opt:App<Option,T>):Option_<T>{
    return get().prj(opt);
  }
  static public function some<T>(v:T){
    return inj(Some(v));
  }
  static public function none<T>():App<Option,T>{
    return inj(None);
  }
  static public function monad():OptionMonad{
    return new OptionMonad();
  }
}
private class OptionMonad implements hkt.head.data.Monad<Option>{
  
  public function new(){

  }
  public function returns<T>(x:T):App<Option,T>{
    return Option.inj(Some(x));
  }
  public function apply<T,R>(fn:App<Option,T->R>,v:App<Option,T>):App<Option,R>{
    var l = Option.prj(fn);
    var r = Option.prj(v);
    var n = Option.get();

    return switch([l,r]){
      case [Some(f),Some(x)]  : n.inj(Some(f(x)));
      default                 : n.inj(None); 
    }
  }
  public function pure<T>(val:T):App<Option,T>{
    return returns(val);
  } 
  public function map<A,B>(fn:A->B){
    return Monads.map(this,fn);
  }
  public function bind<T,R>(m:App<Option,T>,fn:T->App<Option,R>):App<Option,R>{
    var x : Opt<T> = Option.prj(m);
    return switch(x){
      case Some(v)  : fn(v);
      case None     : Option.inj(None);
    }
  }
}