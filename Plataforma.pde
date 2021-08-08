class Plataforma{
  
  FBox plata;
  
  Plataforma(float px, float py, float tx, float ty,int i, int tipo, FWorld mundo){
    
    plata = new FBox(tx,ty);
    plata.setPosition(px,py);
    switch (tipo){
      case 0:
        plata.setName("Piso_"+i);
      break;
      
      case 1:
        plata.setName("Pared_"+i);
      break;
      
      case 2:
        plata.setName("Baja_Vel_"+i);
      break;
      
      case 3:
        plata.setName("Sube_Vel_"+i);
      break;
    }
    //if (tipo){
    //  plata.setName("Piso_"+i);
    //}else {plata.setName("Pared_"+i);}
    plata.setStroke(255);
    plata.setFill(0);
    plata.setStatic(true);
    plata.setGroupIndex(-1);
    mundo.add(plata);
  }
  
  void delete(FWorld mundo){
    mundo.remove(plata);
  }
}
