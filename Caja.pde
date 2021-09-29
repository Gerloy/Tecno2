class Caja{
  
  FBox cajita;
  PShape caj;
  
  Caja(float s, float x, float y, float p, int i, FWorld mundo){
    
    cajita = new FBox(s,s);
    cajita.setPosition(x,y);
    cajita.setName("Caja_"+i);
    cajita.setDensity(p);
    cajita.setRestitution(.5);
    cajita.setGroupIndex(1);
    mundo.add(cajita);
    
    caj = createShape();
    caj.beginShape();
      caj.noStroke();
      caj.texture(loadImage("img/caja.png"));
      caj.textureMode(NORMAL);
      caj.vertex(-s*.5,-s*.5,0,0);
      caj.vertex(s*.5,-s*.5,1,0);
      caj.vertex(s*.5,s*.5,1,1);
      caj.vertex(-s*.5,s*.5,0,1);
    caj.endShape();
  }
  
  void dibujar(){
    pushMatrix();
      translate(cajita.getX(),cajita.getY()+1);
      rotate(cajita.getRotation());
      shape(caj);
    popMatrix();
  }
  
  void delete(FWorld mundo){
    mundo.remove(cajita);
  }
} 
