class Plataforma{
  
  FBox plata;
  PShape pla;
  PImage tex;
  int u,v;
  Plataforma(float px, float py, float tx, float ty,int i, int tipo, FWorld mundo){
    
    plata = new FBox(tx,ty);
    plata.setPosition(px,py);
    switch (tipo){
      case 0:
        plata.setName("Piso_"+i);
        tex = loadImage("img/tabla.png");
        u = 16;
        v = 16;
      break;
      
      case 1:
        plata.setName("Pared_"+i);
        tex = loadImage("img/pared.png");
        u = 16;
        v = round(tx*ty/u)/6;
      break;
      
      case 2:
        plata.setName("Baja_Vel_"+i);
        tex = loadImage("img/baja.png");
        u = 16;
        v = 16;
      break;
      
      case 3:
        plata.setName("Sube_Vel_"+i);
        tex = loadImage("img/sube.png");
        u = 16;
        v = 16;
      break;
    }
    plata.setStatic(true);
    plata.setGroupIndex(-1);
    mundo.add(plata);
    
    
    pla = createShape();
    pla.beginShape();
      pla.noStroke();
      pla.textureMode(IMAGE);
      pla.texture(tex);
      pla.vertex(-tx*.5,-ty*.5,0,0);
      pla.vertex(tx*.5,-ty*.5,u,0);
      pla.vertex(tx*.5,ty*.5,u,v);
      pla.vertex(-tx*.5,ty*.5,0,v);
    pla.endShape();
  }
  
  void dibujar(){
    pushMatrix();
      translate(plata.getX(),plata.getY());
      shape(pla);
    popMatrix();
  }
  
  void delete(FWorld mundo){
    mundo.remove(plata);
  }
}
