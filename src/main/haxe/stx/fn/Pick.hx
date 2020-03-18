package stx.fn;

@:callable abstract Pick<P,Ri,Rii>(PickDef<P,Ri,Rii>) from PickDef<P,Ri,Rii>{
  public function new(self) this = self;
  
  static public function leftPickToSwitch<P,Ri,Rii>(fn:Pick<P,Rii,Ri>):Switch<P,Ri,Rii,Ri>{
    return (e) -> switch e{
      case Left(v)  : fn(v);
      case Right(v) : Right(v);
    }
  }
  static public function rightPickToSwitch<Ri,P,Rii>(fn:Pick<P,Ri,Rii>):Switch<Ri,P,Ri,Rii>{
    return (e) -> switch e {
      case Left(v)  : Left(v);
      case Right(v) : fn(v);
    }
  }
}