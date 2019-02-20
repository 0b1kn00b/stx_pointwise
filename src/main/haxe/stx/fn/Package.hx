package stx.fn;

/**
* Function that takes no input, produces no result.
**/
typedef Block         =  stx.fn.pack.Block;
/**
* Function that takes one input and produces no result.
**/
typedef Sink<T>       =  stx.fn.pack.Sink<T>;
/**
* Function that takes no input, produces output.
**/
typedef Thunk<T>      =  stx.fn.pack.Thunk<T>;

/*********************************************
**********************************************/


/**
 * Function that takes 1 input, produces output.
 */
typedef Unary<PI,R>                             = stx.fn.pack.Unary<PI,R>;

/**
  Function that takes 2 inputs, produces output.
**/
typedef Binary<PI,PII,R>                        = stx.fn.pack.Binary<PI,PII,R>;

/**
  Function that takes 3 inputs, produces output.e
**/
typedef Ternary<PI,PII,PIII,R>                  = stx.fn.pack.Ternary<PI,PII,PIII,R>;

/**
  Function that takes 4 inputs, produces output.
**/
typedef Quaternary<PI,PII,PIII,PIV,R>           = stx.fn.pack.Quaternary<PI,PII,PIII,PIV,R>;

/**
  Function that takes 5 inputs, produces output.
**/
typedef Quinary<PI,PII,PIII,PIV,PV,R>           = stx.fn.pack.Quinary<PI,PII,PIII,PIV,PV,R>;

/**
  Function that takes 6 inputs, produces output.
**/
typedef Senary<PI,PII,PIII,PIV,PV,PVI,R>        = stx.fn.pack.Senary<PI,PII,PIII,PIV,PV,PVI,R>;


typedef Api                                     = stx.fn.pack.Api;
/**
  YCombinator
**/
typedef Y<A,B>                                  = stx.fn.pack.Y<A,B>;
typedef Y2<S,A,B>                               = stx.fn.pack.Y2<S,A,B>;
typedef Dual<PI,PII,RI,RII>                     = stx.fn.pack.Dual<PI,PII,RI,RII>;
typedef Switch<PI,PII,RI,RII>                   = stx.fn.pack.Switch<PI,PII,RI,RII>;
typedef Pick<PI,RI,RII>                         = stx.fn.pack.Pick<PI,RI,RII>;
typedef Fork<P,RI,RII>                          = stx.fn.pack.Fork<P,RI,RII>;
typedef Join<PI,PII,R>                          = stx.fn.pack.Join<PI,PII,R>;
typedef Perhaps<P,R>                            = stx.fn.pack.Perhaps<P,R>;
typedef VBlock<T>                               = stx.fn.pack.VBlock<T>;
typedef Batch<T>                                = stx.fn.pack.Batch<T>;
typedef Product<T,U>                            = stx.fn.pack.Product<T,U>;