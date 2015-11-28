stx_pointwise
=============

Haxe function composition library.

Documentation:

http://0b1kn00b.github.io/stx_pointwise/

#Function Composition Library for Haxe

This library contains two modules: `stx.Functions` and `stx.Compose`.

`stx.Function` contains utilities for chopping and changing the form of a function. Currying, manipulating argument order, performing effects, memoization, catching errors and so forth.

`stx.Compose` provides the `Arrow` of synchronous functions and provides tools for composition.

##stx.Compose

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

##stx.Functions

`stx.Functions` has a class for each function arity 0 to 5.  

###Swallow
###Enclose
###Curry
###Uncurry
###Ccw
###Lazy
###Memoize
###Catching
