class Chobi{
  
  FCircle cuerpo;
  float vel, velBase, size_X; //<>//
  boolean llego;
  
  
  Chobi(float x, float y, int i,int ns){
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
    
    ArrayList<FContact> contactos = cuerpo.getContacts();
    
    for(FContact cont : contactos){
      FBody c1 = cont.getBody1();
      FBody c2 = cont.getBody2();
      if(c1.getName()!= null && c2.getName() != null){
        if((c1.getName().contains("Pared")) || (c2.getName().contains("Pared"))){
          vel*=(-1);
        }
        if((c1.getName().contains("Portal")) || (c2.getName().contains("Portal"))){
          llego = true;
        }
      }
      
      float vy = cuerpo.getVelocityY();
      cuerpo.setVelocity(vel,vy);
    }
    
    //int sign = Integer.signum(round(vel));
    //FBody[] cuerpos = new FBody[20]; 
    //float fin = cuerpo.getX();
    //if (vel > 0){
    //  fin = cuerpo.getX()+size_X+10;
    //}else if (vel < 0){
    //  fin = cuerpo.getX()-size_X-10;
    //}
    //FRaycastResult res = new FRaycastResult();
    //FBody ray = mundo.raycastOne(cuerpo.getX(),cuerpo.getY(),fin,cuerpo.getY(),res,true);
    ////int ray = mundo.raycast(cuerpo.getX(),cuerpo.getY(),cuerpo.getX()+size_X*.5*sign,cuerpo.getY(),cuerpos,20,true);
    
    //if(ray != null){
    //  /*vel *= -1;
    //  cuerpo.setVelocity(vel,0);*/
    //  ArrayList<FBody> cuerpos = mundo.getBodies(res.getX(),res.getY(), true);
    //  ray.setFill(255,0,0);
    //  ellipse(res.getX(),res.getY(),10,10);
    //  if (cuerpos != null){
    //  for(FBody cuer : cuerpos){
    //    if (cuer.getName() != null){
    //    if(cuer.getName().contains("Plata")){
    //      vel *= -1;
    //      //cuerpo.setVelocity(vel,0);
    //      //break;
    //    }
    //    }
    //  }
    //  }
    //  cuerpo.setVelocity(vel,cuerpo.getVelocityY());
    //}
  }
  
  void delete(){
    mundo.remove(cuerpo);
  }
}
