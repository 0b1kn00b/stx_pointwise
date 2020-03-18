package stx.fn.body;

class Picks{
  static public function leftPickToSwitch<PI,RI,RII>(fn:Pick<PI,RII,RI>):Switch<PI,RI,RII,RI>{
    return (e) -> switch e{
      case Left(v)  : fn(v);
      case Right(v) : Right(v);
    }
  }
  static public function rightPickToSwitch<RI,PI,RII>(fn:Pick<PI,RI,RII>):Switch<RI,PI,RI,RII>{
    return (e) -> switch e {
      case Left(v)  : Left(v);
      case Right(v) : fn(v);
    }
  }
}