using stx.Pointwise;


class Test{
  static function main(){
      var fn = function(x:Int) {return x+1; };

      var fn0 = fn.then(fn);

      trace(fn0(0));

      var a = true;

      var b = a.toThunk();

  }
}
