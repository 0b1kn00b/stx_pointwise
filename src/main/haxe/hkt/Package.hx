package hkt;

class Package{
  
}
typedef App<A,B>                    = hkt.pack.App<A,B>;
typedef Applicatives                = hkt.body.Applicatives;
typedef Monads                      = hkt.body.Monads;

typedef Functor<F>                  = hkt.pack.Functor<F>;
typedef Applicative<F>              = hkt.pack.Applicative<F>;
typedef Monad<M>                    = hkt.pack.Monad<M>;
typedef Option                      = hkt.pack.Option;

