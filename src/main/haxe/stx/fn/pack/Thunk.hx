package stx.fn.pack;

import stx.fn.head.data.Thunk in ThunkT;

@:callable abstract Thunk<O>(ThunkT<O>) from ThunkT<O>{
  public function new(self:ThunkT<O>){
    this = self;
  }
}