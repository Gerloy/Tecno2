class Portal{

  FBox collider;
  
  Portal(float x,float y,int i){
  
    collider = new FBox(50,100);
    collider.setPosition(x,y);
    collider.setName("Portal_"+i);
    collider.setGroupIndex(-1);
    collider.setSensor(true);
    collider.setStatic(true);
    collider.setFill(0);
    collider.setStroke(255);
    mundo.add(collider);
    
  }
  
  void delete(){
    mundo.remove(collider);
  }
}
