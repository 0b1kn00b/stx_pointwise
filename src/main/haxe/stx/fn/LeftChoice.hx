package stx.fn;

import tink.core.Either;

typedef LeftChoiceT<B,C,D> = Either<B,D> -> Either<C,D>

@:forward abstract LeftChoice<B,C,D>(LeftChoiceT<B,C,D>) from LeftChoiceT<B,C,D> to LeftChoiceT<B,C,D>{
	public function new(fn:B->C){
    this = function(i:Either<B,D>):Either<C,D>{
      return switch(i){
        case Left(v)  : Left(fn(v));
        case Right(v) : Right(v);
      }
    }
	}
}
