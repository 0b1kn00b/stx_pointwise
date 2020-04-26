stx_fn
=============

Haxe function composition library.

# Function Composition Library for Haxe

## Usage

```
    using stx.Fn;

    class Main{
        static function main(){
            var full_function   = ((i:I) -> return i++).fn()// Unary<Int,Int>
            var arrow_function  = ( (i) -> i++ ).fn(); //Unary<Int,Int>
        }
    } 

```

`using stx.Fn` pulls in all the necessary mixin functions. Currying, manipulating argument order, performing effects, memoization, catching errors, composition blah blah.

Function arities are named.

## Block
* 0 inputs, 0 outputs.  
```FunXX         Block     #enact      0 -> 0```

## Thunk
* 0 input, 1 output.  
```FunXR         Thunk     #reply      0 -> 1```

## Unary
* 1 input, 1 output.  
```Fun1R         Unary     #apply      1 -> 1```


### cache
```
    static public inline function cache<P1, R>(f: P1->R, p1: P1): Thunk<R>
```
Produces a function that calls `f` with the given parameters `p1....pn`,
calls this function only once and memoizes the result.
```
    static public inline function defer<P1, R>(f: P1->R, p1: P1)
```

## Binary
* 2 inputs, 1 output

### rotate
```
    static public function rotate<P1, P2, R>(f:P1->P2->R): P2->P1->R
```
Places parameter 1 at the back.


### flip
```
    static public function flip<P1, P2, R>(f: P1->P2->R): P2->P1->R{
```
Produces a function which takes the parameters of `f` in a flipped order.


### curry
```
    static public function curry<P1, P2, R>(f: P1->P2->R): (P1->(P2->R))
```
Produces a function that produces a function for each parameter in the originating function. When these
functions have been called, the result of the original function is returned.


### uncurry

```
    static public function uncurry<P1, P2, R>(f: (P1->(P2->R))): P1->P2->R
```
Takes a function with one parameter that returns a function of one parameter, and produces
a function that takes two parameters that calls the two functions sequentially,


### cache
```
static public function cache<P1, P2, R>(f: P1->P2->R, p1: P1, p2: P2): Thunk<R>;
```
Produces a function that calls `f` with the given parameters `p1....pn`, and memoizes the result.


### pipe
```
static public function pipe<P1, P2, R>(f: P1->P2->R, p1 : P1, p2 : P2): Thunk<R>;
```
As with lazy, but calls the wrapped function every time it is called.  


### equals   

```
static public function equals<P1,P2,R>(a:P1->P2->R,b:P1->P2->R)
```
Compares function identity.

### bindI
```
static public function bindI<P0,P1,R>(m:P0->P1->R,p0:P0):P1->R
```
  Calls only first parameter, returning Unary function

### bindII
```
static public function bindII<P0,P1,R>(m:P0->P1->R,p1:P1):P0->R
```
  Calls only second parameter, returning Unary function

##### Ternary
* 3 inputs, 1 output 
```Fun3R         Ternary   #applyIII   3 -> 1```


## (Excessive) Detail

In functional languages, functions are first class citizens: meaning a function can be accepted as a  function argument, and functions can be returned from functions.

This allows for composition.

Say you are processing strings, say making a slug from a title (ignoring regexps)

```
static function removeCaps(str:String):String{
 //implement
}
static function underscoreSpaces(str:String):String{

}
```
If you were to call this in a regular way, you could address it like:
```
var lower_cased = removeCaps(title);
var slug        = underscoreSpaces(lower_cased)
```
If you notice the type annotations, they go `String -> String` and `String ->String`

The output value from the first function can go directly into the second, so you can call:
```
var slug = underscoreSpaces(removeCaps(title));
```
the `then` operator formalises this, so you can call:

    var slug = removeCaps.then(underscoreSpaced)(title);

As well as reading in the application order, you can also pass around `removeCaps.then(underscoreSpaced)` as a function.

A second, more elaborate combinator is `first()` which is used to preserve the input to the function, so that you can compare the input and output later on, or change single values while ignoring others or, more interestingly, order computations compositionally.

`first()` needs an understanding of tuples, Couple is a wrapper (see `stx.Nano`) for two typed values which have no names, but only positions `fst()` and `snd()`.

Couple in haxe is notated as Couple<A,B>, but here I will represent a 2-tuple as (A,B) to reduce the noise.

The `first` combinator takes a function `A-> B` and produces a function `(A,C) -> (B,C)`, and what it does is to ignore whatever is on the right hand side of the tuple. Sort of pointless on it`s own untill you learn of the dual of `first`: `second`.

     (A->B) -> (C,A) -> (C,B)

so two functions `fnl = A->B` and `fnr = C->D` can be *ordered* by using:

    fnl.first().then(fnr.second())(tuple2(a,c))

This is most useful where the functions are asynchronous, see arrowlets for details.

## Combinators

**The type annotation `U` indicates that the type may not be known at the calling of the combinator.**

### First
  Takes a function `A->B` and produces a function `Couple<A,U> -> Couple<B,U>` which ignores the value on the right side of the inputted `Couple`.
### Second      
  Takes a function `A->B` and produces a function `Couple<U,A> -> Couple<U,B>` which ignores the value on the *left* side of the inputted `Couple`.
### Left
   Takes a function `A->B` and produced a function `Either<A,U> -> Either<B,U>` which ignores the input if it is `Either.Right`.
### Right
   Takes a function `A->B` and produced a function `Either<U,A> -> Either<U,B>` which ignores the input if it is `Either.Left`.
### Bound
  Takes a function `A->B` and a function `Couple<A,B>->C`, and produced a function `A->C`. The term `A` in the second function is the untouched input passed into the resulting function.
### Pair
  Takes functions `A->B` and `C->D` and produces a function `Couple<A,C>->Couple<B,D>`, running the functions in left->right order.
### Split
   Takes functions `A->B` and `A->C` and produces a function `A->Couple<B,C>`. The input `A` is passed to the first function, then the second.
### Repeat
  Takes a function `A->Either<A,B>` and runs it while the output is `Left(a:A)` until it produces `Right(b:B)`, returning that result.
