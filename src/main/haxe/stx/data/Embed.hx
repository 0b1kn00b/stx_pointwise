package stx.data;

typedef Embed<T> = {
  function pack(v:T):Block;
  function unpack(fn:Block):haxe.ds.Option<T>;
  function check(fn:Block):Bool;
}
