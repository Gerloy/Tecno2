class Caja{
  
  FBox cajita;
  
  Caja(float s, float x, float y, int i){
    
    cajita = new FBox(s,s);
    cajita.setPosition(x,y);
    cajita.setName("Caja_"+i);
    cajita.setStroke(255);
    cajita.setFill(0);
    cajita.setDensity(s);
    cajita.setRestitution(.5);
    cajita.setGroupIndex(1);
    mundo.add(cajita);
  }
  
  void delete(){
    mundo.remove(cajita);
  }
} 
