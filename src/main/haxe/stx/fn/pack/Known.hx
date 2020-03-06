package stx.fn.pack;

abstract Known(Projectable<Certainty>) to Projectable<Certainty>{
  public function new(){
    this = new Projectable(DoNotKnow.bind(Noise));
  }
}