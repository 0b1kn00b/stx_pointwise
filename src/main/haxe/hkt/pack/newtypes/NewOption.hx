package hkt.pack.newtypes;

import hkt.pack.Option;

@:allow(hkt)class NewOption<T> extends NewAny<Option,Opt<T>,T>{
  private static var branding = new Option();
  public function new(){
    super(branding);
  }
}