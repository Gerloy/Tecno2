class Chobi{
  
  FCircle cuerpo;
  float vel, velBase, size_X; //<>//
  boolean llego, cambio;
  
  
  Chobi(float x, float y, int i, int ns, FWorld mundo){
    vel = 100; //<>//
    size_X = 50;
    llego = false;

    cuerpo = new FCircle(size_X);
    cuerpo.setPosition(x,y);
    cuerpo.setDensity(20);
    cuerpo.setName("Chobi_"+ns+"_"+i);
    cuerpo.setRotatable(true);
    cuerpo.setFriction(0);
    cuerpo.setRestitution(0);
    cuerpo.setRestitution(0);
    cuerpo.setGroupIndex(-2);
    cuerpo.setVelocity(vel,0);
    cuerpo.setStroke(255);
    cuerpo.setFill(0);
    mundo.add(cuerpo);
    
  }
  
  void update(){
    
    llego = false;
    ArrayList<FContact> contactos = cuerpo.getContacts();
    cambio = false;
    
    for(FContact cont : contactos){
      if(!cambio){
        if((cont.getY() <= cuerpo.getY()+size_X*.15) && (cont.getY() >= cuerpo.getY()-size_X*.15)){
          vel*=-1;
        }
      }
      FBody c1 = cont.getBody1();
      FBody c2 = cont.getBody2();
      if(c1.getName()!= null && c2.getName() != null){
        if((c1.getName().contains("Portal")) || (c2.getName().contains("Portal"))){
          this.llego = true;
        }
      }
    }
    float vy = cuerpo.getVelocityY();
    cuerpo.setVelocity(vel,vy);
  }
  
  void delete(FWorld mundo){
    mundo.remove(cuerpo);
  }
}
