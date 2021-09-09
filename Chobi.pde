class Chobi{
  
  FCircle cuerpo;
  FBox te;
  float vel, velBase; //<>//
  boolean f, llego, cambio, rapido, lento;
  PVector prePos;
  PImage[] iz, der;
  int time, ti, ac, fra;
  
  
  Chobi(float x, float y, float v, float s, int i, int ns, FWorld mundo){
    vel = v; //<>//
    velBase = v;
    f = false;
    llego = false;
    rapido = false;
    lento = false;
    time = 0;
    ti = 0;
    ac = 250;
    fra = 0;

    te = new FBox(50,75);
    te.setPosition(x,y);
    te.setStatic(true);
    te.setSensor(true);
    te.setGroupIndex(-2);
    mundo.add(te);

    cuerpo = new FCircle(s);
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
    cuerpo.setDrawable(false);
    mundo.add(cuerpo);
    prePos = new PVector(x,y);
    iz = new PImage[2];
    iz[0] = loadImage("img/iz1.png");
    iz[0].resize(50,75);
    iz[1] = loadImage("img/iz2.png");
    iz[1].resize(50,75);
    der = new PImage [2];
    der[0] = loadImage("img/der1.png");
    der[0].resize(50,75);
    der[1] = loadImage("img/der2.png");
    der[1].resize(50,75);
    
    
  }
  
  void update(){
    llego = false;
    f = false;
    if (cuerpo.getY()>=height){
      f = true;
    }
    if (!f){
      checkearContactos();
      
      if(time > millis()){
        if(rapido){
          vel = Integer.signum(round(vel)) * velBase * 2;
        }
        if (lento){
          vel = Integer.signum(round(vel)) * velBase *.5;
        }
      }else {
        time = millis();
        lento = false;
        rapido = false;
      }
      
      if(cuerpo.getVelocityX()*Integer.signum(round(vel))< velBase){
        float vy = cuerpo.getVelocityY();
        cuerpo.setVelocity(vel,vy);
      }
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
        if((cont.getY() <= cuerpo.getY()+cuerpo.getSize()*.05) && (cont.getY() >= cuerpo.getY()-cuerpo.getSize()*.05)){
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
        if((c1.getName().contains("Baja_Vel")) || (c2.getName().contains("Baja_Vel"))){
          lento = true;
          rapido = false;
          time = millis() + 5000;
        }
        //Si el chobi hace contacto con una superficie de subir velocidad se aumenta su velocidad
        if((c1.getName().contains("Sube_Vel")) || (c2.getName().contains("Sube_Vel"))){
          rapido = true;
          lento = false;
          time = millis() + 5000;
        }
        //Si un objeto pesado aplasta al chobi se muere
        if (c1.getDensity()>40 || c2.getDensity()>40){
          if ((cont.getY()<=cuerpo.getY()-cuerpo.getSize()*.3)){
            f = true;
          }
        }
      }
    }
    
    //Distintos tiempos de animacion para las velocidades
    if (rapido){ac = 125;}
    else if (lento){ac = 500;}
    else {ac = 250;}
    
    te.setPosition(cuerpo.getX(),cuerpo.getY()+20);
    
    if(millis()>ti+ac){
      fra ++;
      if (fra == 2){
        fra = 0;
      }
      ti = millis();
    }
    if(vel>0){te.attachImage(der[fra]);}
    else {te.attachImage(iz[fra]);}
  }
  
  void delete(FWorld mundo){
    mundo.remove(cuerpo);
    mundo.remove(te);
  }
}
