package stx.fn.pack;

import stx.fn.body.Thunks;
import stx.fn.head.data.Thunk in ThunkT;

@:callable abstract Thunk<O>(ThunkT<O>) from ThunkT<O>{
  static public function lift<R>(thk:ThunkT<R>):Thunk<R>{
    return new Thunk(thk);
  }
  public function new(self:ThunkT<O>){
    this = self;
  }
  public function then<R>(fn:Unary<O,R>):Thunk<R>{
    return () -> fn(this());
  }
  public function lazy():Thunk<O>{
    return Thunks.lazy(this);
  }
  public function prj():ThunkT<O>{
    return this;
  }
}