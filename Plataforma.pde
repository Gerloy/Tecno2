class Plataforma{
  
  FBox plata;
  
  Plataforma(float px, float py, float tx, float ty,int i, int tipo, FWorld mundo){
    
    plata = new FBox(tx,ty);
    plata.setPosition(px,py);
    switch (tipo){
      case 0:
        plata.setName("Piso_"+i);
        plata.setNoStroke();
        plata.setFill(121,99,61);
        //plata.attachImage(loadImage("img/pared.png"));
      break;
      
      case 1:
        plata.setName("Pared_"+i);
        plata.setNoStroke();
        plata.setFill(121,99,61);
        //plata.attachImage(loadImage("img/pared.png"));
      break;
      
      case 2:
        plata.setName("Baja_Vel_"+i);
        plata.setStroke(255,0,0);
        plata.setFill(255,0,0);
      break;
      
      case 3:
        plata.setName("Sube_Vel_"+i);
        plata.setStroke(0,255,0);
        plata.setFill(0,255,0);
      break;
    }
    //plata.setStroke(255);
    //plata.setFill(0);
    plata.setStatic(true);
    plata.setGroupIndex(-1);
    mundo.add(plata);
  }
  
  void delete(FWorld mundo){
    mundo.remove(plata);
  }
}
