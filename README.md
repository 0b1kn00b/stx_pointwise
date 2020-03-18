stx_fn
=============

//Nullary
//Block     #enact      0 -> 0
//Thunk     #reply      0 -> 1

//Unary     #apply      1 -> 1
//Binary    #braid      2 -> 1
//Ternary   #scope      3 -> 1

//Sink      #chuck      1 -> 0

//Tuple     #tuple      2 -> 0
//Arrow     #relay      2 -> 2 

```

/*
FPiR
FpiTuple2
Fun_pIrI    // 
Fun_pIIrI   // 
Fun_pIrII   //
Fun_pXrX
Fun_pXrI
Fun_pIrX

  FunXX              //Close
  FunXR<R>           //Reply
  Fun1X<P>           //Upply
  Fun1R<P,R>         //Apply

  Fun2R<Pi,Pii,R>    //Tuply
*/
```

Haxe function composition library.

Full Documentation:


# Function Composition Library for Haxe


`using stx.Pointwise` pulls in all the necessary mixin functions. Currying, manipulating argument order, performing effects, memoization, catching errors, composition and so forth.

`stx.data.*` contains type definitions

`stx.core.*` contains static implementations

Function arities are named.

###### Block
* 0 inputs, 0 outputs.

###### Thunk
* 0 input, 1 output

##### `stx.data.Unary`
* 1 input, 1 output


    public static function catching<A,B>(fn:A->B):A->Outcome<B,Error>

Applies a Thunk and returns Either an error or it's result


    public static function swallow<A>(f: A->Void): A->Void

Produces a function that ignores any error the occurs whilst
calling the input function.


    public static function swallowWith<P1, R>(f: P1->R, d: R): P1->R

Produces a function that ignores
any error the occurs whilst calling the input function, and produces `d` if
error occurs.


    public static function returning<P1, R1, R2>(f: P1->R1, thunk: Thunk<R2>) : P1->R2

Produces a function that calls `f`, ignores its result, and returns the result produced by thunk.


    static public inline function lazy<P1, R>(f: P1->R, p1: P1): Thunk<R>

Produces a function that calls `f` with the given parameters `p1....pn`,
calls this function only once and memoizes the result.

    static public inline function defer<P1, R>(f: P1->R, p1: P1)

As with lazy, but calls the wrapped function every time it is called.

    public static function enclose<P1, R>(f: P1->R): P1->Void

Produces a function that calls `f`, ignoring the result.

    equals<P1,R>(a:P1->R,b:P1->R):Bool

Compares function identity.

##### `stx.data.Binary`
* 2 inputs, 1 output


    static public function rotate<P1, P2, R>(f:P1->P2->R): P2->P1->R

Places parameter 1 at the back.

    public static function swallow<P1, P2>(f: P1->P2->Void): P1->P2->Void

Produces a function that ignores any error the occurs whilst calling the input function.

    public static function swallowWith<P1, P2, R>(f: P1->P2->R, d: R): P1->P2->R

Produces a function that ignores any error the occurs whilst calling the input function, and produces `d` if error occurs.


    public static function returning<P1, P2, R1, R2>(f: P1->P2->R1, thunk: Thunk<R2>): P1->P2->R2 {

Produces a function that calls `f`, ignores its result, and returns the result produced by thunk.


    public static function flip<P1, P2, R>(f: P1->P2->R): P2->P1->R{

Produces a function which takes the parameters of `f` in a flipped order.


    public static function curry<P1, P2, R>(f: P1->P2->R): (P1->(P2->R))

Produces a function that produces a function for each parameter in the originating function. When these
functions have been called, the result of the original function is returned.


    public static function uncurry<P1, P2, R>(f: (P1->(P2->R))): P1->P2->R

Takes a function with one parameter that returns a function of one parameter, and produces
a function that takes two parameters that calls the two functions sequentially,


    public static function lazy<P1, P2, R>(f: P1->P2->R, p1: P1, p2: P2): Thunk<R>;

Produces a function that calls `f` with the given parameters `p1....pn`, and memoizes the result.

    static public function defer<P1, P2, R>(f: P1->P2->R, p1 : P1, p2 : P2): Thunk<R>;

As with lazy, but calls the wrapped function every time it is called.  


    public static function enclose<P1, P2, R>(f: P1->P2->R): P1->P2->Void

Produces a function that calls `f`, ignoring the result.


    public static function equals<P1,P2,R>(a:P1->P2->R,b:P1->P2->R)

Compares function identity.

static public function c0<P0,P1,R>(m:P0->P1->R,p0:P0):P1->R

  Calls only first parameter, returning Unary function

static public function c1<P0,P1,R>(m:P0->P1->R,p1:P1):P0->R

  Calls only second parameter, returning Unary function

##### Ternary
* 3 inputs, 1 output

##### Quaternary
* 4 inputs, 1 output

##### Quaternary
* 4 inputs, 1 output

##### Quinary
* 5 inputs, 1 output

##### Senary
* 6 inputs, 1 output

###Swallow
###Enclose
###Curry
###Uncurry
###Lazy
###Memoize
###Catching


In functional languages, functions are first class citizens: meaning a function can be accepted as a  function argument, and functions can be returned from functions.

This allows for composition.

Say you are processing strings, say making a slug from a title (ignoring regexps)

    static function removeCaps(str:String):String{
        //implement
    }
    static function underscoreSpaces(str:String):String{
    }

If you were to call this in a regular way, you could address it like:

    var lower_cased = removeCaps(title);
    var slug = underscoreSpaces(lower_cased)

If you notice the type annotations, they go `String -> String` and `String ->String`

The output value from the first function can go directly into the second, so you can call:

    var slug = underscoreSpaces(removeCaps(title));

the `then` operator formalises this, so you can call:

    var slug = removeCaps.then(underscoreSpaced)(title);

As well as reading in the application order, you can also pass around `removeCaps.then(underscoreSpaced)` as a function.

A second, more elaborate combinator is `first()` which is used to preserve the input to the function, so that you can compare the input and output later on, or change single values while ignoring others or, more interestingly, order computations compositionally.

`first()` needs an understanding of tuples, Tuple2 being a wrapper for two typed values which have no names, but only positions `fst()` and `snd()`.

Tuple2 in haxe is notated as Tuple2<A,B>, but here I will represent a 2-tuple as (A,B) to reduce the noise.

The `first` combinator takes a function `A-> B` and produces a function `(A,C) -> (B,C)`, and what it does is to ignore whatever is on the right hand side of the tuple. Sort of pointless on it`s own untill you learn of the dual of `first`: `second`.

     (A->B) -> (C,A) -> (C,B)

so two functions `fnl = A->B` and `fnr = C->D` can be *ordered* by using:

    fnl.first().then(fnr.second())(tuple2(a,c))

This is most useful where the functions are asynchronous, see arrowlets for details.

##Combinators

**The type annotation `X` indicates that the type may not be known at the calling of the combinator.**

###First
  Takes a function `A->B` and produces a function `Tuple2<A,X> -> Tuple2<B,X>` which ignores the value on the right side of the inputted `Tuple2`.
###Second      
  Takes a function `A->B` and produces a function `Tuple2<X,A> -> Tuple2<X,B>` which ignores the value on the *left* side of the inputted `Tuple2`.
###Left
   Takes a function `A->B` and produced a function `Either<A,X> -> Either<B,X>` which ignores the input if it is `Either.Right`.
###Right
   Takes a function `A->B` and produced a function `Either<X,A> -> Either<X,B>` which ignores the input if it is `Either.Left`.
###Tie
  Takes a function `A->B` and a function `Tuple2<A,B>->C`, and produced a function `A->C`. The term `A` in the second function is the untouched input passed into the resulting function.
###Pair
  Takes functions `A->B` and `C->D` and produces a function `Tuple2<A,C>->Tuple2<B,D>`, running the functions in left->right order.
###Split
   Takes functions `A->B` and `A->C` and produces a function `A->Tuple2<B,C>`. The input `A` is passed to the first function, then the second.
###Repeat
  Takes a function `A->Either<A,B>` and runs it while the output is `Left(a:A)` until it produces `Right(b:B)`, returning that result.
