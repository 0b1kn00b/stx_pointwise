package hkt;

import hkt.head.data.Brand;
import hkt.pack.App in AppA;
import stx.core.pack.Embed;

interface NewType<B:Brand,Wrap,T>{
  private var brand : B;
  private var embed : Embed<Wrap>;
  function inj(v:Wrap):AppA<B,T>;
  function prj(v:AppA<B,T>):Wrap;
}