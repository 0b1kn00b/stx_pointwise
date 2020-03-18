package stx.fn.lift;

class LiftSwitch{
  /**
    * Returns a function that applies a function to the Left value of an Either.
    * @param fn 
    * @return Either<Pi,Ri>->Either<Rii,Ri>
  */
  static public inline function left<Pi,Ri,Rii>(fn:Unary<Pi,Rii>):Switch<Pi,Ri,Rii,Ri>{
    return (e) -> switch e {
      case Left(v)  : Left(fn(v));
      case Right(v) : Right(v);
    };
  }
    /**
      Returns a function that applies a function to the Right value of an Either.
    **/
    static public inline function right<Ri,Pi,Rii>(fn:Unary<Pi,Rii>):Switch<Ri,Pi,Ri,Rii>{
      return (e) -> switch e {
        case Left(v)  : Left(v);
        case Right(v) : Right(fn(v));
      }
    }  
}