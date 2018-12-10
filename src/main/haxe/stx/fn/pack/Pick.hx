package stx.fn.pack;

import stx.fn.head.data.Pick in PickT;

@:callable abstract Pick<P,RI,RII>(PickT<P,RI,RII>) from PickT<P,RI,RII>{
  public function new(self){
    this = self;
  }
}