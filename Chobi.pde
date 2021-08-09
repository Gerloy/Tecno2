class Chobi{
  
  FCircle cuerpo;
  float vel, velBase, sizeX; //<>//
  boolean f, llego, cambio, rapido, lento;
  PVector prePos;
  int time;
  
  
  Chobi(float x, float y, float v, int i, int ns, FWorld mundo){
    vel = v; //<>//
    velBase = v;
    sizeX = 50;
    f = false;
    llego = false;
    rapido = false;
    lento = false;
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
    f = false;
    if (cuerpo.getY()>=height){
      f = true;
    }
    if (!f){
      checkearContactos();
      
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
  }
  
  //Comprueba todos los contactos que hace el chobi en cada frame para definir como reacciona
  void checkearContactos(){
    cambio = false;
    ArrayList<FContact> contactos = cuerpo.getContacts();
    //Si el chobi colisiona con un cuerpo en la dirección en la que se está dirigiendo la velocidad cambia de signo 
    for(FContact cont : contactos){
      if(!cambio){
        if((cont.getY() <= cuerpo.getY()+10) && (cont.getY() >= cuerpo.getY()-10)){
          if (((cont.getX() < cuerpo.getX()) && (vel<0)) || ((cont.getX() > cuerpo.getX()) && (vel>0))){
            vel*=-1;
            cuerpo.setPosition(prePos.x+2*Integer.signum(round(vel)),prePos.y);
          }
        }
      }
      FBody c1 = cont.getBody1();
      FBody c2 = cont.getBody2();
      if(c1.getName()!= null && c2.getName() != null){
        if((c1.getName().contains("Portal")) || (c2.getName().contains("Portal"))){
          this.llego = true;
        }
        //Si el chobi hace contacto con una superficie de bajar velocidad se disminuye su velocidad
        if((c1.getName().contains("Baja_vel")) || (c2.getName().contains("Baja_vel"))){
          rapido = false;
          lento = true;
          time = millis() + 5000;
        }
        //Si el chobi hace contacto con una superficie de subir velocidad se aumenta su velocidad
        if((c1.getName().contains("Sube_vel")) || (c2.getName().contains("Sube_vel"))){
          rapido = false;
          lento = true;
          time = millis() + 5000;
        }
        //Si un objeto pesado aplasta al chobi se muere
        if (c1.getDensity()>40 || c2.getDensity()>40){
          if (cont.getY()<cuerpo.getY()-sizeX*.3){
            f = true;
          }
        }
        //if((!c1.getName().contains("Chobi")) && (c1.getDensity()>40) && ()){
        //  f = true;
        //}
        //if((!c2.getName().contains("Chobi")) && (c2.getDensity()>40)){
        //  f = true;
        //}
      }
    }
  }
  
  void delete(FWorld mundo){
    mundo.remove(cuerpo);
  }
}
