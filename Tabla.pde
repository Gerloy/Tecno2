class Tabla{

  FBox tabla;
  PShape ta;
  
  Tabla(float x,float y,float tx,float ty, float p, int i, FWorld mundo){
    
    tabla = new FBox(tx,ty);
    tabla.setPosition(x,y);
    tabla.setDensity(p);
    tabla.setFill(132,94,33);
    tabla.setNoStroke();
    tabla.setName("Tabla_"+i);
    tabla.setGroupIndex(1);
    mundo.add(tabla);
    
    ta = createShape();
    ta.beginShape();
      ta.noStroke();
      ta.fill(132,94,33);
      ta.vertex(-tx*.5,-ty*.5);
      ta.vertex(tx*.5,-ty*.5);
      ta.vertex(tx*.5,ty*.5);
      ta.vertex(-tx*.5,ty*.5);
    ta.endShape();
  }
  
  void dibujar(){
    pushMatrix();
      translate(tabla.getX(),tabla.getY());
      rotate(tabla.getRotation());
        shape(ta);
    popMatrix();
  }
  
  void delete(FWorld mundo){
    mundo.remove(tabla);
  }
}
