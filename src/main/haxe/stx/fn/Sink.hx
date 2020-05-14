package stx.fn;

@:callable abstract Sink<P>(SinkDef<P>) from SinkDef<P> to SinkDef<P>{
  public function new(self:SinkDef<P>){
    this = self;
  }
  static public function unit<P>():Sink<P>{
    return lift((p:P) -> {});
  }
  @:noUsing static public function lift<P>(fn:P->Void):Sink<P>{
    return new Sink(fn);
  }

  #if tink_core
    @:to public function toTinkCallback():tink.core.Callback<P>{
      return this;
    }
  #end
  public function stage(before: P -> Void, after: P->Void):Sink<P>{
    return (p:P) -> {
      before(p);
      this(p);
      after(p);
    }
  }
}