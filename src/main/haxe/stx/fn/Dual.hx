package stx.fn;

@:using(stx.fn.Dual.DualLift)
@:forward @:callable abstract Dual<Pi,Pii,Ri,Rii>(DualDef<Pi,Pii,Ri,Rii>) from DualDef<Pi,Pii,Ri,Rii> to DualDef<Pi,Pii,Ri,Rii>{
  static public var _(default,never) = DualLift;
  static public function unit<P>():Dual<P,P,P,P>{
    return new Dual(
      (tp:Couple<P,P>) -> (tp:Couple<P,P>)
    );
  }
  public function new(self:DualDef<Pi,Pii,Ri,Rii>){
    this = self;
  }
  @:from static public function fromUnary<Pi,Pii,Ri,Rii>(self:Unary<Couple<Pi,Pii>,Couple<Ri,Rii>>):Dual<Pi,Pii,Ri,Rii>{
    return new Dual(self);
  }
  @:to public function toUnary():Unary<Couple<Pi,Pii>,Couple<Ri,Rii>>{
    return this;
  }
}
class DualLift{
  static public function into<Pi,Pii,Ri,RiiI>(fn:Ri->Rii->RiiI){
    return this.then(__.decouple(fn));
  }
  static public function pass<Pi,Pii,Ri,Ri0,Rii0>(fn:Ri->Rii->Couple<Ri0,Rii0>):Dual<Pi,Pii,Ri0,Rii0>{
    return this.then(__.decouple(fn));
  }
  static public function first<Pi,Pii,Ri,Rii>(fn:Ri->Rii):Dual<Pi,Pii,Rii,Rii>{
    return this.then(fn.fn().first());
  }
  static public function second<Pi,Pii,Ri,Rii>(fn:Rii->Rii):Dual<Pi,Pii,Ri,Rii>{
    return this.then(fn.fn().second());
  }
}
