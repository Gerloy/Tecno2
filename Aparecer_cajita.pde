//Objeto que hace una cosa específica, después tengo que convertirlo en clase script
//y hacerlo un blueprint como los otros para hacer cosas piolas
class Aparecer_Cajita{
  
    FBox cajita, coli;
  
  Aparecer_Cajita(FWorld m){
    
    coli = new FBox(20,600);
    coli.setPosition(900,300);
    coli.setSensor(true);
    coli.setName("wdawdawd");
    coli.setStatic(true);
    coli.setDrawable(false);
    m.add(coli);
  }
  
  void update(FWorld m){
    ArrayList<FContact> contactos = coli.getContacts(); 
    for(FContact cont : contactos){
      FBody c1 = cont.getBody1();
      FBody c2 = cont.getBody2();
      if(c1.getName()!= null && c2.getName() != null){
        if((c1.getName() == "Circulo") || (c2.getName() == "Circulo")){
          cajita = new FBox(50,50);
          cajita.setPosition(1400,0);
          cajita.setDensity(80);
          cajita.setFill(0);
          cajita.setStroke(255);
          m.add(cajita);
          cajita.addImpulse(0,-50);
          m.remove(coli);
        }
      }
    }
  }
}
