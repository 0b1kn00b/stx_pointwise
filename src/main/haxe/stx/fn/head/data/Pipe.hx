package stx.ds.head.data;

import stx.ds.pack.Pipe in PipeA;
typedef Pipe<I,O> = I -> Tuple2<Option<O>,PipeA<I,O>;