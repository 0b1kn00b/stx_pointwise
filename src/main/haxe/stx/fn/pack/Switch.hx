package stx.fn.pack;


/**
 * Represents a function that has an input of one of either parameter type and returns one of either return type.
 */
@:forward @:callable abstract Switch<Pi,Pii,Ri,Rii>(SwitchDef<Pi,Pii,Ri,Rii>) from SwitchDef<Pi,Pii,Ri,Rii>{
  public function new(self:SwitchDef<Pi,Pii,Ri,Rii>){
    this = self;
  }
}