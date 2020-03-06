package stx.fn.pack;

abstract Projectable<T>(Void->T){
  public function new(self){
    this = self;
  }
  public function prj(){
    return this();
  }
}