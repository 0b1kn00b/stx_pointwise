package stx.fn.unary;

class Implementation{
  static public function _() return Unary._()._;
  
  static public function apply<Pi,R>(self:Unary<Pi,R>,pI:Pi):R                              return _().apply(pI,self);
  static public function cache<Pi, R>(self: Unary<Pi,R>,pI: Pi)                             return _().cache(pI,self);
  static public function pipe<Pi, R>(self: Unary<Pi,R>,pI: Void -> Pi)                      return _().pipe(pI,self);
  static public function equals<Pi,R>(self:Unary<Pi,R>,that:Pi->R):Bool                     return _().equals(that,self);
  static public function then<Pi,Pii,R>(self:Unary<Pi,Pii>,that:Unary<Pii,R>):Unary<Pi,R>   return _().then(self,that);
  
}