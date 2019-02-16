package stx.fp.pack;

import stx.fp.head.data.SemiGroup in SemiGroupT;

abstract SemiGroup<T>(SemiGroupT<T>) from SemiGroupT<T>{
  public function new(self){
    this = self;
  }
}