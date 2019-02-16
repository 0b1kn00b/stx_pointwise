package stx.fn.pack;

typedef FoldT<R,A> = Binary<A,R,R>;

@:callable abstract Fold<R,A>(Fold<R,A>) from Fold<R,A>{

} 