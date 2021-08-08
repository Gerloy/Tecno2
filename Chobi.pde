class Chobi{
  
  FCircle cuerpo;
  float vel, velBase, sizeX; //<>//
  boolean llego, cambio, rapido, lento;
  PVector prePos;
  //int rapido, lento, time;
  int time;
  
  
  Chobi(float x, float y, float v, int i, int ns, FWorld mundo){
    vel = v; //<>//
    velBase = v;
    sizeX = 50;
    llego = false;
    rapido = false;
    lento = false;
    //rapido = 0;
    //lento = 0;
    time = 0;

    cuerpo = new FCircle(sizeX);
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
    prePos = new PVector(x,y);
    
  }
  
  void update(){
    llego = false;
    ArrayList<FContact> contactos = cuerpo.getContacts();
    cambio = false;
    
    for(FContact cont : contactos){
      if(!cambio){
        if((cont.getY() <= cuerpo.getY()+10) && (cont.getY() >= cuerpo.getY()-10)){
          vel*=-1;
          cuerpo.setPosition(prePos.x+2*Integer.signum(round(vel)),prePos.y);
        }
      }
      FBody c1 = cont.getBody1();
      FBody c2 = cont.getBody2();
      if(c1.getName()!= null && c2.getName() != null){
        if((c1.getName().contains("Portal")) || (c2.getName().contains("Portal"))){
          this.llego = true;
        }
        if((c1.getName().contains("Baja_vel")) || (c2.getName().contains("Baja_vel"))){
          //rapido = 0;
          //lento = 5000;
          rapido = false;
          lento = true;
          time = millis() + 5000;
        }
        if((c1.getName().contains("Sube_vel")) || (c2.getName().contains("Sube_vel"))){
          //lento = 0;
          //rapido = 5000;
          rapido = false;
          lento = true;
          time = millis() + 5000;
        }
      }
    }
    
    if(time >= millis()){
      if(rapido){
        vel = Integer.signum(round(vel)) * velBase * 2;
      }
      if (lento){
        vel = Integer.signum(round(vel)) * velBase *.5;
      }
    }
    
    float vy = cuerpo.getVelocityY();
    cuerpo.setVelocity(vel,vy);
    prePos = new PVector(cuerpo.getX(),cuerpo.getY());
  }
  
  void delete(FWorld mundo){
    mundo.remove(cuerpo);
  }
}
