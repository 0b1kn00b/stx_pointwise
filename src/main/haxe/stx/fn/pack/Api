package stx.fn.pack;

class Api{
  public function new(){}

  public function upply(fn:Block){
    stx.fn.body.Blocks.upply(fn);
  }
  public function thunk<T>(v:T):Thunk<T>{
    return () -> v;
  }
  public function folds(){
    return new Folds();
  }
}
class Folds{
  public function new(){}
  public function array<T>():T->Array<T>->Array<T>{
    return (next,memo) -> memo.concat([next]);
  }
}