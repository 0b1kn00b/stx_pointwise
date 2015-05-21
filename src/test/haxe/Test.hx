import stx.Compose;
import stx.Functions;


class Test{
  static function main(){
    var f = function(i:Int){ };
    var fn : SomeFunction<Int> = f;
    f(2);
  } 
}
@:forward abstract SomeFunction<T>(T->Void) from T->Void to T->Void{

  @:to public function toFunction():T->Void{
    return this;
  }
  public function new(v){
    this = v;
  }
}