package stx.fn.head.data;

import stx.fn.pack.Pipe in PipeA;

typedef Pipe<I,O> = I -> Tuple2<Option<O>,PipeA<I,O>>;