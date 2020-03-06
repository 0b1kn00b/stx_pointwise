import stx.fn.Package;

// class Test extends stx.test.pack.Test{
//   static function main(){
//     var test = new Test([
//       //new stx.hkt.OptionTest().tests,
//       new UncertainTest().tests
//     ]);
//     test.run();
//     trace("done");
//   }
// }
// class UncertainTest extends Case{
//   public function testValid(){
//     var a = new SomethingLearnt(new Unknown());
//     trace(Type.typeof(a.cert));
//     $type(a);
//     var b = a.learn();
//     $type(b);
//     trace(Type.typeof(b.cert));
//   }
// }
// class SomethingLearnt<T:Projectable<Certainty>>{
//   public var cert : T;
//   public function new(cert:T){
//     this.cert = cert;
//   }
//   public function learn():SomethingLearnt<Known>{
//     return new SomethingLearnt(new Known());
//   }
// }



/*class ChoiceTest extends haxe.unit.TestCase{
  public function testLR(){
    var a = (function(x:Int){
      return Right(x + 2);
    }).fromRight();

    var o0 = a(Left(3));
    this.assertTrue(T.enumEq(Left(3),o0));
    var o1 = a(Right(3));
    this.assertTrue(T.enumEq(Right(5),o1));

    var b = (function(x:Int):Int{
      return x*2;
    }).right();

    var o2 = b(Right(10));
    this.assertTrue(T.enumEq(Right(20),o2));

    var c = (function(i:Int):Either<String,Int>{
      return Left('issues from $i');
    }).fromRight();

    trace(c(Right(0)));
    trace(c(Left('ok')));
  }
}
*/