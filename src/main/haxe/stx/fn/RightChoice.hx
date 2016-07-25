package stx.fn;

import tink.core.Either;

typedef RightChoiceT<B,C,D> = Either<D,B> -> Either<D,C>;

@:callable @:forward abstract RightChoice<B,C,D>(RightChoiceT<B,C,D>) from RightChoiceT<B,C,D> to RightChoiceT<B,C,D>{
	@:static public function fromFn(fn:B->C):RightChoice<B,C,D>{
		return function(i:Either<D,B>):Either<D,C>{
      return switch(i){
        case Right(v) : Right(fn(v));
        case Left(v)  : Left(v);
      }
    }
	}
}
