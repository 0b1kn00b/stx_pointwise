package stx.fp.head.data;

typedef Monoid<T> = {
  >SemiGroup<T>,
  public function prior():T;
}