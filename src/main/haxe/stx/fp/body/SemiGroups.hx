package stx.fp.body;

import stx.fp.head.data.SemiGroup;

class SemiGroups{
  @:noUsing static public function array<T>(){
    var out = function(sg:SemiGroup<Array<T>>){
      return switch(sg){
        case SemiGroupPlus(l,r) : l.concat(r);
      }
    };
    $type(out);
  } 
}