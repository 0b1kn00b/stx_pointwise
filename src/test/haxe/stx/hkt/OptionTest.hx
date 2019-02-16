package stx.hkt;

import utest.Test;
using utest.Assert;

import stx.fn.pack.Block;
import stx.fn.pack.VBlock;

import stx.core.pack.Embed;
import hkt.Package;
import haxe.ds.Option in Option_;

class OptionTest extends Test{
  public function test(){
    var l = Option.some("one");
    var c = Option.prj(l);
    switch(c){
      case Some(v) : "one".equals(v);
      default : 
    }
  }
  public function testFMap(){
    var m = Option.monad();
    var r = m.bind(
          m.pure(19),
          function(x:Int):App<Option,Int>{
            return Option.some(x+2);
          }
        );
        switch(
          Option.prj(r)
        ){
          case Some(v) : 21.equals(v);
          default : 
        }
  }
}
