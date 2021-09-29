class Chobi{
  
  FCircle cuerpo;
  float vel, velBase; //<>// //<>//
  boolean f, llego, cambio, rapido, lento, act;
  PVector prePos;
  PImage[] iz, der;
  PShape[] izq,de;
  int time, ti, ac, fra, sha;
  AudioPlayer caer,aplas,lle;
  
  
  Chobi(float x, float y, float v, float s, int i, int ns, FWorld mundo,Minim minim){
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
    sha = 0;
    act = true;
    lle = minim.loadFile("snd/goal.wav");
    caer = minim.loadFile("snd/caer.wav");
    aplas = minim.loadFile("snd/aplas.wav");

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
    mundo.add(cuerpo);
    prePos = new PVector(x,y);
    iz = new PImage[2];
    iz[0] = loadImage("img/iz1.png");
    iz[1] = loadImage("img/iz2.png");
    der = new PImage [2];
    der[0] = loadImage("img/der1.png");
    der[1] = loadImage("img/der2.png");
    
    //Shapes
    izq = new PShape[2];
    izq[0] = createShape();
    izq[0].beginShape();
      izq[0].noStroke();
      izq[0].textureMode(NORMAL);
      izq[0].texture(iz[0]);
      izq[0].vertex(-s*.5,-s*.5,0,0);
      izq[0].vertex(s*.5,-s*.5,1,0);
      izq[0].vertex(s*.5,s*.5,1,1);
      izq[0].vertex(-s*.5,s*.5,0,1);
    izq[0].endShape();
    
    izq[1] = createShape();
    izq[1].beginShape();
      izq[1].noStroke();
      izq[1].textureMode(NORMAL);
      izq[1].texture(iz[1]);
      izq[1].vertex(-s*.5,-s*.5,0,0);
      izq[1].vertex(s*.5,-s*.5,1,0);
      izq[1].vertex(s*.5,s*.5,1,1);
      izq[1].vertex(-s*.5,s*.5,0,1);
    izq[1].endShape();
    
    de = new PShape[2];
    de[0] = createShape();
    de[0].beginShape();
      de[0].noStroke();
      de[0].textureMode(NORMAL);
      de[0].texture(der[0]);
      de[0].vertex(-s*.5,-s*.5,0,0);
      de[0].vertex(s*.5,-s*.5,1,0);
      de[0].vertex(s*.5,s*.5,1,1);
      de[0].vertex(-s*.5,s*.5,0,1);
    de[0].endShape();
    
    de[1] = createShape();
    de[1].beginShape();
      de[1].noStroke();
      de[1].textureMode(NORMAL);
      de[1].texture(der[1]);
      de[1].vertex(-s*.5,-s*.5,0,0);
      de[1].vertex(s*.5,-s*.5,1,0);
      de[1].vertex(s*.5,s*.5,1,1);
      de[1].vertex(-s*.5,s*.5,0,1);
    de[1].endShape();
    
    
  }
  
  void update(int t, int ob, int ter){
    llego = false;
    f = false;
    if (cuerpo.getY()>=height){
      f = true;
      if(!(t <= ob-ter)){
        caer.play();
      }
    }
    if (!f){
      checkearContactos(t,ob,ter);
      
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
  void checkearContactos(int t, int ob, int ter){
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
          if(!(ob <= ter+1)){
            lle.play();
          }
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
            if(!(t <= ob-ter)){
              aplas.play();
            }
            f = true;
          }
        }
      }
    }
    
    //Distintos tiempos de animacion para las velocidades
    if (rapido){ac = 125;}
    else if (lento){ac = 500;}
    else {ac = 250;}
    
    if(millis()>ti+ac){
      fra ++;
      if (fra == 2){
        fra = 0;
      }
      ti = millis();
    }
    if(vel>0){sha=2+fra;}
    else {sha=fra;}
  }
  
  //Hecho así nomás porque la entrega es en 3 días
  void dibujar(){
    if(act){
      pushMatrix();
        translate(cuerpo.getX(),cuerpo.getY());
        switch (sha){
          case 0: 
            shape(izq[0]);
          break;
          
          case 1:
            shape(izq[1]);
          break;
          
          case 2:
            shape(de[0]);
          break;
          
          case 3:
            shape(de[1]);
          break;
        }
      popMatrix();
    }
  }
  
   void delete(FWorld mundo){
    mundo.remove(cuerpo);
    act = false;
  }
}
