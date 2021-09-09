class Portal{

  FBox collider;
  
  Portal(float x,float y,int i, FWorld mundo){
  
    collider = new FBox(50,100);
    collider.setPosition(x,y+30);
    collider.setName("Portal_"+i);
    collider.setGroupIndex(-1);
    collider.setSensor(true);
    collider.setStatic(true);
    //collider.setFill(0);
    //collider.setStroke(255);
    PImage im = loadImage("img/portal.png");
    im.resize(60,120);
    collider.attachImage(im);
    mundo.add(collider);
    
  }
  
  void delete(FWorld mundo){
    mundo.remove(collider);
  }
}
