package stx.fn.lift;

class LiftBroker{
  static public function broker<T,U>(v:T,fn:Unary<T,T> -> Unary<T,U>):U{
    return fn((x) -> x)(v);
  }
  static public macro function brokert<T,U>(e0:haxe.macro.Expr,e1:haxe.macro.Expr):haxe.macro.Expr{

    var str0 = haxe.macro.TypeTools.toString(haxe.macro.Context.typeof(e0));
    var str1 = haxe.macro.TypeTools.toString(haxe.macro.Context.typeof(e1));

    haxe.macro.Context.warning(str0,haxe.macro.Context.currentPos());
    haxe.macro.Context.warning(str1,haxe.macro.Context.currentPos());

    return macro {
      stx.core.Lift.broker($e0,$e1);
    }
  }
  //Ignores the input function, so you can see the types if there is an error in the function
  static public macro function brokeru<T,U>(e0:haxe.macro.Expr,e1:haxe.macro.Expr):haxe.macro.Expr{

    var str0 = haxe.macro.TypeTools.toString(haxe.macro.Context.typeof(e0));
    var str1 = haxe.macro.TypeTools.toString(haxe.macro.Context.typeof(e1));

    haxe.macro.Context.warning(str0,haxe.macro.Context.currentPos());
    haxe.macro.Context.warning(str1,haxe.macro.Context.currentPos());
    
    return macro {
      $e0;
    }
  }
}