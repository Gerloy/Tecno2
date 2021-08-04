class Plataforma{
  
  FBox plata;
  
  Plataforma(float px, float py, float tx, float ty,int i, boolean tipo){
    
    plata = new FBox(tx,ty);
    plata.setPosition(px,py);
    if (tipo){
      plata.setName("Piso_"+i);
    }else {plata.setName("Pared_"+i);}
    plata.setStroke(255);
    plata.setFill(0);
    plata.setStatic(true);
    plata.setGroupIndex(-1);
    mundo.add(plata);
  }
  
  void delete(){
    mundo.remove(plata);
  }
}
