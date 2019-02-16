import utest.Runner;
import utest.ui.Report;

using stx.fn.Lift;
using stx.core.Lift;

import haxe.ds.Option;

import stx.fn.Package;
import stx.fp.Package;

import stx.hkt.OptionTest;

class Test{
  static function main(){
    var runner = new Runner();
    Report.create(runner);
        runner.addCase(new stx.hkt.OptionTest());
        runner.run();
  }
}

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