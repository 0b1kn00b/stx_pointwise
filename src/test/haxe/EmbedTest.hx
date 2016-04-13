using stx.Pointwise;
using Test;

import stx.Embed;

import haxe.ds.Option;

using EmbedTest;
private enum Lego{
  LegoOfMyString(str:String);
  LegoOfMyInt(int:Int);
}
class LegoTest{
  var int_embed : Embed<Int>;
  var str_embed : Embed<String>;
  public function new(){
    int_embed = new Embed();
    str_embed = new Embed();
  }
  public function packAll(int,str):Array<Block>{
    return [int_embed.pack(int),str_embed.pack(str)];
  }
  public function unpack(b:Block){
    return if(int_embed.check(b)){
      int_embed.unpack(b).map(LegoOfMyInt);//assumes Option has a map function, which isn't in stdlib
    }else if(str_embed.check(b)){
      str_embed.unpack(b).map(LegoOfMyString);
    }else{
      None;
    }
  }
  public static function main(){
    var lego = new LegoTest();
    /*
      * Array<Block> has no type signature to indicate it is carrying multiple types.
    */
    var blocks = lego.packAll(1,"wotcha");
    /*
      Need another Block of some other type.
    */
    var other_Embed = new Embed();
    var block = other_Embed.pack(true);
    /*
    *  The type signature of blocks does not need to change to accomodate the Embed<Bool>;
    */
    blocks.push(block);
    /*
    * The blocks in transport contain references to an Int, a String, and a Bool without the need to
    * use an enumeration and it's supporting functions.
    */
    var transport = new MovingBlocksAround(blocks);
    /*
    * Start pulling out data with the Lego enum.
    */
    var o0 = lego.unpack(transport.blocks[0]);//Some(LegoOfMyInt(1));
    trace(o0);
    var o1 = lego.unpack(transport.blocks[1]);//Some(LegoOfMyString("wotcha"));
    trace(o1);
    /*
    * Not of a compatible type, doesn't matter because it doesn't have the reference either,
    * and the Embed is empty as far as LegoTest is concerned.
    */
    lego.unpack(transport.blocks[2]);//None
    /*
    * Using the scope I have here to get at a value opaque to LegoTest and MovingBlocksAround.
    */
     var o2 = other_Embed.unpack(transport.blocks[2]);//Some(true);
     trace(o2);
  }
  static private function map<A,B>(opt:Option<A>,fn:A->B):Option<B>{
    return switch(opt){
    case Some(v) : Some(fn(v));
      case None : None;
    }
  }
  /**
    Does not need to know about the type of it's data.
  **/
}
class MovingBlocksAround{
  public var blocks : Array<Block>;
  public function new(blocks:Array<Block>){
    this.blocks = blocks;
  }
}
