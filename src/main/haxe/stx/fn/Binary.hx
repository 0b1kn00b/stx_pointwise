package stx.fn;

import stx.fn.binary.Constructor;

@:using(stx.fn.binary.Implementation)
@:callable abstract Binary<PI,PII,R>(BinaryDef<PI,PII,R>) from BinaryDef<PI,PII,R>{
  static public inline function _() return Constructor.ZERO;

  public function new(self:BinaryDef<PI,PII,R>){
    this = self;
  }
  public function prj():PI->PII->R{
    return this;
  }
}
