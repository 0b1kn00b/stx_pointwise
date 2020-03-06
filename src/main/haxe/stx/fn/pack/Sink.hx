package stx.fn.pack;

import stx.fn.body.Sinks;
import stx.fn.head.data.Sink in SinkT;

@:callable abstract Sink<T>(SinkT<T>) from SinkT<T> to SinkT<T>{
  public function new(self:SinkT<T>){
    this = self;
  }
  static public function unit<T>():Sink<T>{
    return lift((t:T) -> {});
  }
  static public function lift<T>(fn:T->Void):Sink<T>{
    return new Sink(fn);
  }

  @:to public function toTinkCallback():Callback<T>{
    return this;
  }
  public function fore_command(fn:T->Void):Sink<T>{
    return lift((t:T) -> {
      fn(t);
      this(t);
    });
  }
  public function post_command(fn:T->Void):Sink<T>{
    return lift((t:T) -> {
      this(t);
      fn(t);
    });
  }
  
  #if (js || flash)
    public function tramepoline(f:T->Void):Sink<T>{
      return function(t:T):Void{
          haxe.Timer.delay(
            function() {
              this(t);
            },10
          );
        }
    }
	#else
    public function trampoline():Sink<T>{
      return function(t:T):Void{
        this(t);
      }
    }
	#end
}