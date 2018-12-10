package stx.fn.pack;

import stx.fn.head.data.Switch in SwitchT;

/**
 * Represents a function that has an input of one of either parameter type and returns one of either return type.
 */
@:forward @:callable abstract Switch<PI,PII,RI,RII>(SwitchT<PI,PII,RI,RII>) from SwitchT<PI,PII,RI,RII>{
  public function new(self:SwitchT<PI,PII,RI,RII>){
    this = self;
  }
}