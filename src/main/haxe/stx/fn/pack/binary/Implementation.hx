package stx.fn.pack.binary;

class Implementation{
  static public function _() return Binary._()._;

  static public function braid<Pi,Pii,R>(self:Pi->Pii->R,pI:Pi,pII:Pii):R                         return _().braid(pI,pII,self);
  static public function rotate<Pi, Pii, R>(self:Pi->Pii->R): Pii->Pi->R                          return _().rotate(self);
  static public function swap<Pi, Pii, R>(self: Pi->Pii->R): Pii->Pi->R                           return _().swap(self);
  static public function curry<Pi, Pii, R>(self: Pi->Pii->R): (Pi->(Pii->R))                      return _().curry(self);
  static public function equals<Pi,Pii,R>(self:Pi->Pii->R,that:Pi->Pii->R)                        return _().equals(that,self);
  static public function bindPi<Pi,Pii,R>(self:Pi->Pii->R,pI:Pi):Pii->R                           return _().bindPi(pI,self);
  static public function bindPii<Pi,Pii,R>(self:Pi->Pii->R,pII:Pii):Pi->R                         return _().bindPii(pII,self);
  static public function cache<Pi,Pii,R>(self: Binary<Pi,Pii,R>, pI: Pi,pII: Pii): Thunk<R>       return _().cache(pI,pII,self);
  static public function pipe<Pi, Pii, R>(self: Pi->Pii->R,tp : Thunk<Tuple<Pi,Pii>>): Thunk<R>   return _().pipe(tp,self);
}