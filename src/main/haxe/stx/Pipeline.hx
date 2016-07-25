package stx;

import tink.core.Either;

typedef PipelineT<A,B> = A -> Either<A,B>;

abstract Pipelin(Type) {

  public inline function new( v : Type ) {
    this = v;
  }
}
