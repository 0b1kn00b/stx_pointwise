package stx.core;


/**
  You can curry....
**/
class Senaries{
  public static function curry<P1, P2, P3, P4, P5, P6, R>(f: P1->P2->P3->P4->P5->P6->R): P1->(P2->(P3->(P4->(P5->(P6 ->R))))) {
    return function(p1: P1) {
      return function(p2: P2) {
        return function(p3: P3) {
          return function(p4: P4) {
            return function(p5: P5) {
              return function(p6: P6){
                return f(p1, p2, p3, p4, p5, p6);
              }
            }
          }
        }
      }
    }
  }
}
