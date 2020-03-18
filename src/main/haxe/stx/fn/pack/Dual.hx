package stx.fn.pack;

@:forward @:callable abstract Dual<Pi,Pii,Ri,Rii>(DualDef<Pi,Pii,Ri,Rii>) from DualDef<Pi,Pii,Ri,Rii> to DualDef<Pi,Pii,Ri,Rii>{
  static public function unit<P>():Dual<P,P,P,P>{
    return new Dual(
      (tp:Tuple<P,P>) -> (tp:Tuple<P,P>)
    );
  }
  public function new(self:DualDef<Pi,Pii,Ri,Rii>){
    this = self;
  }
  public function into<RiiI>(fn:Ri->Rii->RiiI){
    return this.then(__.into2(fn));
  }
  public function pass<Ri0,Rii0>(fn:Ri->Rii->Tuple<Ri0,Rii0>):Dual<Pi,Pii,Ri0,Rii0>{
    return this.then(__.into2(fn));
  }
  public function first<Ri0>(fn:Ri->Ri0):Dual<Pi,Pii,Ri0,Rii>{
    var next = fn.fn().first();
    return this.then(fn.fn().first());
  }
  public function second<Rii0>(fn:Rii->Rii0):Dual<Pi,Pii,Ri,Rii0>{
    return this.then(fn.fn().second());
  }
  @:from static public function fromUnary<Pi,Pii,Ri,Rii>(self:Unary<Tuple<Pi,Pii>,Tuple<Ri,Rii>>):Dual<Pi,Pii,Ri,Rii>{
    return new Dual(self);
  }
  @:to public function toUnary():Unary<Tuple<Pi,Pii>,Tuple<Ri,Rii>>{
    return this;
  }
}
