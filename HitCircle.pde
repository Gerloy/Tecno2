class HitCircle{
  
  FCircle circulo;
  FMouseJoint joint;
  PShape cir;
  
  HitCircle(FWorld mundo){    
    //Creo el circulo que va a chocar con la cajita
    circulo = new FCircle(width * .05);
    circulo.setPosition(width*.5,height*.5);
    circulo.setDensity(20);
    circulo.setName("Player");
    //sin friction restitution no va a frenar ni rebotar ccuando
    //choque con otros objetos
    circulo.setFriction(0);
    circulo.setRestitution(0);
    circulo.setGroupIndex(-1);
    mundo.add(circulo);
    
    joint = new FMouseJoint(circulo,circulo.getX(),circulo.getY());
    joint.setDrawable(false);
    mundo.add(joint);
    
    cir = createShape();
    cir.beginShape();
      cir.noStroke();
      cir.texture(loadImage("img/cir.png"));
      cir.textureMode(NORMAL);
      cir.vertex(-circulo.getSize()*.5,-circulo.getSize()*.5,0,0);
      cir.vertex(circulo.getSize()*.5,-circulo.getSize()*.5,1,0);
      cir.vertex(circulo.getSize()*.5,circulo.getSize()*.5,1,1);
      cir.vertex(-circulo.getSize()*.5,circulo.getSize()*.5,0,1);
    cir.endShape();
  }
  
  void update(float pos){
    joint.setTarget(mouseX+pos,mouseY);
  }
  
  void dibujar(){
    pushMatrix();
      translate(circulo.getX(),circulo.getY());
      shape(cir);
    popMatrix();
  }
  
  void checkBtns(Boton[] botones){
    boolean[] conts = new boolean[botones.length];
    for (int i=0; i<conts.length; i++){
      conts[i] = false;
    }
    ArrayList<FContact> contactos = circulo.getContacts();
    for (FContact cont : contactos){
      int i = 0;
      FBody c1 = cont.getBody1();
      FBody c2 = cont.getBody2();
      for (Boton btn : botones){
        if((c1.getName()!=null) && (c2.getName()!= null)){
          if(((c1.getName().contains(btn.btn.getName())) || (c2.getName().contains(btn.btn.getName())))){
            conts[i] = true;
          }
        }
        i++;
      }
    }
    for (int i=0; i<conts.length; i++){
      if(!conts[i]){
        botones[i].activo = false;
      }
    }
  }
  
  void delete(FWorld mundo){
    mundo.remove(circulo);
    mundo.remove(joint);
  }
}
