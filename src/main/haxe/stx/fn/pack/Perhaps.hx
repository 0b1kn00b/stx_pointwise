package stx.fn.pack;

@:forward @:callable abstract Perhaps<P,R>(PerhapsDef<P,R>) from PerhapsDef<P,R>{
  public function new(self){
    this = self;
  }
}