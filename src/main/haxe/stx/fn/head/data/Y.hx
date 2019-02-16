package stx.fn.head.data;

import stx.fn.pack.FT in FTA;
import stx.fn.pack.Unary in UnaryA;

typedef Y<A, B>              = UnaryA<FTA<A,B>,Unary<A,B>>; 