class HitCircle{
  
  FCircle circulo;
  FMouseJoint joint;
  
  HitCircle(FWorld mundo){
    
    //Creo el circulo que va a chocar con la cajita
    circulo = new FCircle(width * .05);
    circulo.setPosition(width*.5,height*.5);
    circulo.setDensity(20);
    circulo.setName("Circulo");
    circulo.setStroke(255);
    circulo.setFill(0);
    //sin friction restitution no va a frenar ni rebotar ccuando
    //choque con otros objetos
    circulo.setFriction(0);
    circulo.setRestitution(0);
    circulo.setGroupIndex(-1);
    mundo.add(circulo);
    
    joint = new FMouseJoint(circulo,circulo.getX(),circulo.getY());
    joint.setDrawable(false);
    mundo.add(joint);
  }
  
  void update(float pos){
    joint.setTarget(mouseX+pos,mouseY);
  }
  
  void delete(FWorld mundo){
    mundo.remove(circulo);
    mundo.remove(joint);
  }
}
