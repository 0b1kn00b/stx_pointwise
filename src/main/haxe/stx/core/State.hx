package stx.core;

import tink.CoreApi;
using stx.Tuple;

using stx.Tuple;
using stx.Pointwise;


import stx.data.State in TState;

@:forward @:callable abstract State<S,R>(TState<S,R>) from TState<S,R> to TState<S,R>{
  static public function newVar<S,A>(v:A):State<WorldState,StateRef<WorldState,A>>{
    return State.pure(new StateRef(v));
  }
  @:noUsing static public function modifier<S,A>(f:A->A,sr:StateRef<S,A>):State<S,StateRef<S,A>>{
    return sr.modify(f);
  }
  @:noUsing static public function reader<S,A>(sr:StateRef<S,A>):State<S,A>{
    return sr.read();
  }
  @:noUsing static public function unit<S>():State<S,Noise>{
    return function(s:S){
      return tuple2(Noise,s);
    }
  }
  @:noUsing static public function pure<S,A>(value:A):State<S,A>{
    return function(s:S):Tuple2<A,S>{
      return tuple2(value,s);
    }
  }
  public function new(v){
    this = v;
  }
  public function apply(s:S):Tuple2<R,S>{
    return this(s);
  }
  public function map<R1>(fn:R->R1):State<S,R1>{
    return States.map(this,fn);
  }
  public function mod<S,R>(fn:S->S):State<S,R>{
    return States.mod(this,fn);
  }
  public function refine<S,R>(fn:S->R->S):State<S,R>{
    return States.refine(this,fn);
  }
  public function flatMap<R1>(fn:R->State<S,R1>){
    return States.flatMap(this,fn);
  }
  public function access<R1>(fn:R->S->R1):State<S,R1>{
    return States.access(this,fn);
  }
  public function getSt(){
    return States.getSt(this);
  }
  public function exec(s:S):S{
    return apply(s).snd();
  }
  @doc("Run `State` with `s`, returning the result.")
  public function eval(s:S):R{
    return apply(s).fst();
  }
}
class States{
  static public function apply<S,R>(state:State<S,R>,s:S):Tuple2<R,S>{
    return state.apply(s);
  }
  @doc("Run `State` with `s`, dropping the result and returning `s`.")
  static public function exec<S,R>(st:State<S,R>,s:S):S{
    return apply(st,s).snd();
  }
  @doc("Run `State` with `s`, returning the result.")
  static public function eval<S,R>(st:State<S,R>,s:S):R{
    return apply(st,s).fst();
  }
  static public function map<S,R,R1>(st:State<S,R>,fn:R->R1):State<S,R1>{
    var fn2 : Tuple2<R,S> -> Tuple2<R1,S> = fn.first();
    return function(s:S){
      var o = st.apply(s);
      return tuple2(fn(o.fst()),o.snd());
    }
  }
  static public function each<S,R>(st:State<S,R>,fn:R->Void):State<S,R>{
    return map(st,
      function(x){
        fn(x);
        return x;
      }
    );
  }
  static public function mod<S,R>(st:State<S,R>,fn:S->S):State<S,R>{
    return function(s:S):Tuple2<R,S>{
      var o = apply(st,s);
      return tuple2( o.fst(), fn(o.snd()) );
    }
  }
  static public function refine<S,R>(st:State<S,R>,fn:S->R->S):State<S,R>{
    return st.then(
      function(next,memo){
        var m_next = fn(memo,next);
        return tuple2(next,m_next);
      }.tupled()
    );
  }
  static public function flatMap<S,R,R1>(st:State<S,R>,fn:R->State<S,R1>):State<S,R1>{
    return apply.bind(st)
      .then( fn.pair(Compose.unit()) )
      .then(
        function(t:Tuple2<State<S,R1>,S>) {
          return t.fst().apply(t.snd());
        }
      );
  }
  static public function getSt<S,R>(st:State<S,R>):State<S,S>{
    return function(s:S):Tuple2<S,S>{
      var o = apply(st,s);
      return tuple2(o.snd(),o.snd());
    }
  }
  static public function putSt<S,R>(st:State<S,R>,n:S):State<S,R>{
    return function (s:S){
      var o = apply(st,s);
      return tuple2(o.fst(),n);
    }
  }
  static public function access<S,R,R1>(state:State<S,R>,fn:R->S->R1):State<S,R1>{
    return function (s:S){
      return tuple2(fn.tupled()(apply(state,s)),s);
    }
  }
}
private class StateRef<S,A>{
  private var value : A;
  public function new(v:A){
    this.value = v;
  }
  public function read():State<S,A> {
    return State.pure(value);
  }
  public function write(a:A):State<S,StateRef<S,A>>{
    return function(s:S){
      this.value = a;
      return tuple2(this,s);
    }
  }
  public function modify(f:A->A):State<S,StateRef<S,A>> {
    var a = read();
    var v = a.flatMap(f.then(write));
    return v;
  }
}
private class WorldState{
  public function new(){

  }
}
class WorldStates{
  static public function run<A>(v:State<WorldState,StateRef<WorldState,A>>){
    return v.apply( new WorldState() );
  }
  static public function exec<R>(v:State<WorldState,StateRef<WorldState,R>>):WorldState{
    return v.apply(new WorldState()).snd();
  }
  static public function eval<R>(v:State<WorldState,StateRef<WorldState,R>>):StateRef<WorldState,R>{
    return v.apply(new WorldState()).fst();
  }
}
