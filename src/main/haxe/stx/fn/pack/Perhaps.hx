package stx.fn.pack;

import stx.fn.head.data.Perhaps in PerhapsT;

abstract Perhaps<P,R>(PerhapsT<P,R>) from PerhapsT<P,R>{
  public function new(self){
    this = self;
  }
}