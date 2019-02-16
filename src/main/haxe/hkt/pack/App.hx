package hkt.pack;
 
class App<F,T>{
  var token   : F;
  var value   : VBlock<T>;

  public function new(token:F,value:VBlock<T>){
    this.token  = token;
    this.value  = value; 
  }
  public function apply(token:F):VBlock<T>{
    if(token != this.token){
      throw "Mismatched Token";
    }
    return value;
  }
  static public function create<F,T>(token:F,value:VBlock<T>):App<F,T>{
    return new App(token,value);
  }
}