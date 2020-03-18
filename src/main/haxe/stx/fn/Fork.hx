package stx.fn;

@:forward @:callable abstract Fork<P,Ri,Rii>(ForkDef<P,Ri,Rii>) from ForkDef<P,Ri,Rii> to ForkDef<P,Ri,Rii>{
  public function new(self){
    this = self;
  }
  @:from static public function fromUnary<P,Ri,Rii>(fn:Unary<P,Tuple<Ri,Rii>>){
    return new Fork(fn);
  }
  @:to public function toUnary():Unary<P,Tuple<Ri,Rii>>{
    return this;
  }
  public function then<RiiI>(fn:Join<Ri,Rii,RiiI>):Unary<P,RiiI>{
    return this.then(fn);
  }
}