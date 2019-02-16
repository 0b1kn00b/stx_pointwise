package hkt.pack.newtypes;

import haxe.ds.Option in Option_;
import hkt.pack.Option;
import hkt.head.data.Brand;

@:allow(hkt)class NewAny<B:Brand,Wrap,T> implements NewType<B,Wrap,T>{
  var embed : Embed<Wrap>;
  var brand : B;

  public function new(brand:B){
    this.brand = brand;
    this.embed = new Embed();
  }
  function shade(opt:Block):VBlock<T>{
    return VBlock.fromBlock(opt);
  }
  public function inj(value:Wrap):App<B,T>{
    var embedded  = this.embed.pack(value);
    var global = brand.embed.pack(
      () -> {
        var out = this.embed.unpack(embedded);
        HKT.handle(out);
      }
    );
    var block     = shade(global);
    var out : App<B,T> = App.create(brand,block);
    return out;
  }
  public function prj(app:App<B,T>):Wrap{
    var retrieved     = app.apply(brand);
    var val           = None;
    HKT.handle = function(x:Option_<Wrap>){
      val = x;
    }
    switch(brand.embed.unpack(retrieved)){
      case Some(f) : f();
      case None    : throw  "";
    }
    return switch(val){
      case Some(v) : v ;
      case None : throw  ""; None;
    }
  }
}