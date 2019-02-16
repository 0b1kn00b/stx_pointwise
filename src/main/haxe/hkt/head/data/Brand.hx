package hkt.head.data;

@:allow(hkt)class Brand{
  public var embed : Embed<Block>;

  public function new(){
    this.embed = new Embed();
  }
}