package stx;

using Lambda;
import haxe.ds.Option;
import stx.types.*;

using stx.Tuple;
using stx.Pointwise;

typedef PFMethod<A,Z>               = Tuple2<A->Bool,A->Z>;
typedef PartialFunctionType<A,Z>    = Array<PFMethod<A,Z>>;
typedef PF<A,Z>                     = PartialFunctions<A,Z>;

class PFMethods{
  static public function unit<A>():PFMethod<A,A>{
    var m : A->A     = Compose.unit();
    var p : A->Bool  = function(x) return false;
    return tuple2(p,m);
  }
}
abstract Partial<A,Z>(PartialFunctionType<A,Z>) from PartialFunctionType<A,Z> to PartialFunctionType<A,Z>{
  public function new(v){
    this = v;
  }
  @:from static public function fromFunctions<A,Z>(arr:Array<Tuple2<A->Bool,A->Z>>):Partial<A,Z>{
    return arr.map(
      function(x:Tuple2<A->Bool,A->Z>):Tuple2<A->Bool,A->Z>{
        var l : A->Bool = x.fst();
        var r : A->Z    = x.snd();
        return tuple2(l,r);
      }
    );
  }
  public function isDefinedAt(a: A): Bool {
    return PF.isDefinedAt(this,a);
  }
  public function orElse(that: PartialFunctionType<A, Z>): Partial<A, Z> {
    return PF.orElse(this,that);
  }
  public function orDo(f: A ->  Z): Partial<A, Z> {
    return PF.orDo(this,f);
  }
  public function orReturn(pf:PF<A,Z>,z: Thunk<Z>): Partial<A, Z> {
    return PF.orReturn(this,z);
  }
  public function orReturnC(pf:PF<A,Z>,z: Z): Partial<A, Z> {
    return PF.orReturn(this,Pointwise.toThunk(z));
  }
  public function iterator():Iterator<PFMethod<A,Z>>{
    return this.iterator();
  }
  public function apply(a: A): Z {
    return PF.apply(this,a);
  }
  @:to public function toFunction():A -> Option<Z>{
    var self = this;
    return function(a) {
      return if (PF.isDefinedAt(self,a)){
        Some(PF.apply(self,a));
      }else{
        None;
      }
    }
  }
  public function attach(pred:A->Bool,method:A->Z):Partial<A,Z>{
    return PartialFunctions.attach(this,pred,method);
  }
}
class PartialFunctions<A, Z>{
  @:noUsing static public function unit<A>():PartialFunctionType<A,A>{
    return create([tuple2(function(x) return false,function(x){ return x;})]);
  }
  static public function toPartialFunctionType<A, Z>(def: Array<Tuple2<A->Bool, A->Z>>):PartialFunctionType<A, Z> {
    return def;
  }
  @:noUsing static public function create<A, Z>(def: Array<Tuple2<A->Bool, A->Z>>):PartialFunctionType<A, Z> {
    return def;
  }
  static public function attach<A,Z>(pf:PartialFunctionType<A,Z>,pred:A->Bool,method:A->Z):PartialFunctionType<A,Z>{
    var next = pf.copy();
        next.push(tuple2(pred,method));
    return next;
  }
  static public function isDefinedAt<A,Z>(pf:PartialFunctionType<A,Z>,a: A): Bool {
    for (d in pf) {
      if (d.fst().apply(a)) return true;
    }
    return false;
  }
  static public function orElse<A,Z>(pf:PartialFunctionType<A,Z>,that: PartialFunctionType<A, Z>): PartialFunctionType<A, Z> {
    return create(pf.concat(
      [tuple2(isDefinedAt.bind(that), apply.bind(that))]
    ));
  }
  static public function orDo<A,Z>(pf:PartialFunctionType<A,Z>,f: A ->  Z): PartialFunctionType<A, Z> {
    return create(pf.concat([
      tuple2(function(a) { return true; },f)
    ]));
  }
  static public function orReturn<A,Z>(pf:PartialFunctionType<A,Z>,z: Thunk<Z>): PartialFunctionType<A, Z> {
    return create(pf.concat([
      tuple2(function(a) { return true; },function(a) { return z(); })
    ]));
  }
  static public function apply<A,Z>(pf:PartialFunctionType<A,Z>,a: A): Z {
    for (d in pf) {
      if (d.fst().apply(a)) return d.snd().apply(a);
    }
    return throw new tink.core.Error(500,"Function undefined");
  }
  static public function toFunction<A,Z>(pf:PartialFunctionType<A,Z>): A -> Option<Z> {
    var self = pf;
    return function(a) {
      return if (isDefinedAt(self,a)) Some(apply(self,a));
             else None;
    }
  }
  static public function asPartialFunction<A,Z>(arr:Array<Tuple2<A->Bool,A->Z>>):Partial<A,Z>{
    return new Partial(arr);
  }
}
