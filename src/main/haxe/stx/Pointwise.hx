package stx;

import haxe.ds.Option;

/**
  Mixins to Compose Unary Functions.
**/
typedef Compose       = stx.core.Compose;
/*********************************************
                Functions 1-6;
**********************************************/

/**
  Function that takes 1 input, produces output.
**/
typedef Unary         = stx.core.Unary;

/**
  Function that takes 2 inputs, produces output.
**/
typedef Binary        = stx.core.Binary;

/**
  Function that takes 3 inputs, produces output.e
**/
typedef Ternary       = stx.core.Ternary;

/**
  Function that takes 4 inputs, produces output.
**/
typedef Quaternary    = stx.core.Quaternary;

/**
  Function that takes 5 inputs, produces output.
**/
typedef Quinary       = stx.core.Quinary;

/**
  Function that takes 6 inputs, produces output.
**/
typedef Senary        = stx.core.Senary;

/**
* Function that takes no input, produces output.
**/
typedef Thunk<T>      = stx.data.Thunk<T>;

/**
* Mixins for Thunks.
**/
typedef Thunks        = stx.core.Thunks;


/**
* Function that takes no input, produces no result.
**/
typedef Block         = stx.data.Block;


/**
* Function that takes one input and produces no result.
**/
typedef Sink<T>       =  stx.data.Sink<T>;
/**
* Mixins for Sinks.
**/
typedef Sinks         =  stx.core.Sinks;

class Pointwise{
  /**
    Takes a value and wraps it in a function.
  **/
  static inline public function toThunk<T>(v:T):Thunk<T>{
    return Thunks.toThunk(v);
  }
  /**
    Produces a function that is only called in the event of Some(v) being passed
    to it.
  **/
  static inline public function maybe<A,B>(fn:A->B):Option<A>->Option<B>{
    return Compose.maybe(fn);
  }
}
