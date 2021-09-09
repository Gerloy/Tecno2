class Caja{
  
  FBox cajita;
  
  Caja(float s, float x, float y, float p, int i, FWorld mundo){
    
    cajita = new FBox(s,s);
    cajita.setPosition(x,y);
    cajita.setName("Caja_"+i);
    cajita.setNoStroke();
    cajita.setFill(121,85,72);
    cajita.setDensity(p);
    cajita.setRestitution(.5);
    cajita.setGroupIndex(1);
    mundo.add(cajita);
  }
  
  void delete(FWorld mundo){
    mundo.remove(cajita);
  }
} 
