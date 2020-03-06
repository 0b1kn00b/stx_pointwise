package stx.fn.pack;

abstract Unknown(Projectable<Certainty>) to Projectable<Certainty>{
  public function new(){
    this = new Projectable(DoNotKnow.bind(null));
  }
}