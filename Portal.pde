class Portal{

  FBox collider;
  PShape port;
  
  Portal(float x,float y,int i, FWorld mundo){
  
    collider = new FBox(50,100);
    collider.setPosition(x,y+30);
    collider.setName("Portal_"+i);
    collider.setGroupIndex(-1);
    collider.setSensor(true);
    collider.setStatic(true);
    mundo.add(collider);
    
    port = createShape();
    port.beginShape();
      port.noStroke();
      port.textureMode(NORMAL);
      port.texture(loadImage("img/portal.png"));
      port.vertex(-50,-50,0,0);
      port.vertex(50,-50,1,0);
      port.vertex(50,50,1,1);
      port.vertex(-50,50,0,1);
    port.endShape();
    
  }
  
  void dibujar(){
    pushMatrix();
      translate(collider.getX(),collider.getY()-collider.getHeight()*.5-1);
      shape(port);
    popMatrix();
  }
  
  void delete(FWorld mundo){
    mundo.remove(collider);
  }
}
