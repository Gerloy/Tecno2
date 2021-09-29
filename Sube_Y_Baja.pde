class Sube_Y_Baja{
  FBox tabla, pared;
  FPoly soporte;
  FRevoluteJoint joint;
  float scale;
  PVector pos;
  PShape sop, tab;
  
  Sube_Y_Baja(float s, float x, float y, FWorld mundo, int i){
    
      scale = s;
      pos = new PVector(x,y);
      
      //Hago el soporte (triángulo equilátero)
      soporte = new FPoly();
      soporte.vertex(pos.x-s*.5,pos.y);
      soporte.vertex(pos.x+s*.5,pos.y);
      soporte.vertex(pos.x,pos.y-s*.75);
      soporte.setNoStroke();
      soporte.setFill(121,85,72);
      soporte.setStatic(true);
      soporte.setGroupIndex(-1);
      mundo.add(soporte);
      
      //Hago la PShape que va a mostrar el soporte
      sop = createShape();
      sop.beginShape();
        sop.noStroke();
        sop.texture(loadImage("img/soporte.png"));
        sop.textureMode(NORMAL);
        sop.vertex(-s*.5,0,0,0);
        sop.vertex(s*.5,0,1,0);
        sop.vertex(s*.5,s*.75,1,1);
        sop.vertex(-s*.5,s*.75,0,1);
      sop.endShape();
        
      //Hago la tabla
      tabla = new FBox(s*3,s*.16);
      tabla.setPosition(pos.x,pos.y-s*.75);
      tabla.setNoStroke();
      tabla.setFill(121,99,61);
      tabla.setRotation(random(-QUARTER_PI*.5,QUARTER_PI*.5));
      mundo.add(tabla);
      
      //Hago la PShape de la tabla
      //int w = int(tabla.getWidth()*tabla.getHeight()/4);
      tab = createShape();
      tab.beginShape();
        tab.noStroke();
        tab.texture(loadImage("img/tabla.png"));
        tab.textureMode(IMAGE);
        tab.vertex(-tabla.getWidth()*.5,-tabla.getHeight()*.5,0,0);
        tab.vertex(tabla.getWidth()*.5,-tabla.getHeight()*.5,16,0);
        tab.vertex(tabla.getWidth()*.5,tabla.getHeight()*.5,16,16);
        tab.vertex(-tabla.getWidth()*.5,tabla.getHeight()*.5,0,16);
      tab.endShape();
      
      //Hago el joint
      joint = new FRevoluteJoint(soporte,tabla,pos.x,pos.y-s*.75);
      joint.setCollideConnected(true);
      joint.setDrawable(false);
      mundo.add(joint);
      
      //Hago una paredcita para que los chobis no se choquen
      pared = new FBox(s,s*.75);
      pared.setPosition(x,y);
      pared.setStatic(true);
      pared.setDrawable(false);
      pared.setName("Pared_Sube_Y_Baja_"+i);
      pared.setSensor(true);
      mundo.add(pared);
  }
  
  void dibujar(){
    pushMatrix();
      translate(pos.x,pos.y-scale*.75+2);
      pushMatrix();
        rotate(tabla.getRotation());
        shape(tab); //Dibujo primero la tabla para que parezca que está agarrada al soporte
      popMatrix();
      shape(sop);
    popMatrix();
  }
  
  void delete(FWorld mundo){
    mundo.remove(tabla);
    mundo.remove(soporte);
    mundo.remove(joint);
    mundo.remove(pared);
  }
}
