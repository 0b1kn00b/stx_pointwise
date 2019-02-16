package hkt.head.data;

import hkt.pack.App in AppA;
 
interface Monad<M> extends Applicative<M>{
  public function returns<T>(v:T):AppA<M,T>;
  public function bind<T,R>(m:AppA<M,T>,fn:T->AppA<M,R>):AppA<M,R>;
}