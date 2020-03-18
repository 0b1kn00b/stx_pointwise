package stx.fn;

import stx.fn.unary.Constructor;

@:using(stx.fn.unary.Implementation)
@:callable abstract Unary<PI,R>(UnaryDef<PI,R>) from UnaryDef<PI,R> to UnaryDef<PI,R>{
  static public function unit() return _().unit();
  static public inline function _() return Constructor.ZERO;
  @:noUsing static public function lift<PI,R>(fn:PI->R):Unary<PI,R> return new Unary(fn);
  
  @:noUsing static public function pure<PI,R>(r:R):Unary<PI,R>{
    return (v:PI) -> r;
  }
  public function new(self:UnaryDef<PI,R>){
    this = self;
  }
  public function prj():PI->R{
    return this;
  }
}