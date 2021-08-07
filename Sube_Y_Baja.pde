class Sube_Y_Baja{
  FBox tabla;
  FPoly soporte;
  FRevoluteJoint joint;
  float scale;
  PVector pos;
  
  Sube_Y_Baja(float s, float x, float y, FWorld mundo){
    
      scale = s;
      pos = new PVector(x,y);
      
      //Hago el soporte (triángulo equilátero)
      soporte = new FPoly();
      soporte.vertex(pos.x-s*.5,pos.y);
      soporte.vertex(pos.x+s*.5,pos.y);
      soporte.vertex(pos.x,pos.y-s*.75);
      soporte.setStroke(255);
      soporte.setFill(0);
      soporte.setStatic(true);
      mundo.add(soporte);
      
      //Hago la tabla
      tabla = new FBox(s*3,s*.16);
      tabla.setPosition(pos.x,pos.y-s*.75);
      tabla.setStroke(255);
      tabla.setFill(0);
      tabla.setRotation(random(-QUARTER_PI*.5,QUARTER_PI*.5));
      mundo.add(tabla);
      
      //Hago el joint
      joint = new FRevoluteJoint(soporte,tabla,pos.x,pos.y-s*.75);
      joint.setCollideConnected(true);
      joint.setDrawable(false);
      mundo.add(joint);
  }
  
  void delete(FWorld mundo){
    mundo.remove(tabla);
    mundo.remove(soporte);
    mundo.remove(joint);
  }
}
